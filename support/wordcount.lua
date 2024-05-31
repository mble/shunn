-- counts words in a document

local words = 0

local function format_int(number)
	local i, j, minus, int, fraction = tostring(number):find("([-]?)(%d+)([.]?%d*)")
	int = int:reverse():gsub("(%d%d%d)", "%1,")
	return minus .. int:reverse():gsub("^,", "") .. fraction
end

local wordcount = {
	Str = function(el)
		-- we don't count a word if it's entirely punctuation:
		if el.text:match("%P") then
			words = words + 1
		end
	end,

	Code = function(el)
		local _, n = el.text:gsub("%S+", "")
		words = words + n
	end,

	CodeBlock = function(el)
		local _, n = el.text:gsub("%S+", "")
		words = words + n
	end,
}

-- set metadata entry
function Meta(meta)
	local rounded = 100 * math.floor(words / 100 + 0.5)
	meta.wordcount = format_int(rounded)
	return meta
end

function Pandoc(el)
	-- skip metadata, just count body:
	pandoc.walk_block(pandoc.Div(el.blocks), wordcount)
end

return {
	{ Pandoc = Pandoc },
	{ Meta = Meta },
}
