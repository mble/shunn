# shunn

`shunn` is a set of scripts to aid in generating short story manuscripts according to William Shunn's [Proper Manuscript Format](https://www.shunn.net/format/story/) from Markdown.

## Dependencies

- Ruby
- Pandoc
- weasyprint
- shellcheck

## Usage

1. Clone the repository.
2. `cd` into the repository.
3. Ensure your Markdown file has appropriate frontmatter. The required fields are:

```yaml
address:
  - "1234 Main St."
  - "City, State ZIP"
firsname: "John"
lastname: "Doe"
byline: "John Doe"
title: "The Title of Your Story"
email: "john.doe@example.com"
```

Optional fields are:

```yaml
font_family: '"Courier New", Courier, monospace'
page_size: "letter"
```

Alternatively, you can create a file `metadata.yaml` in the root of the repository with the same fields, and these will be applied automatically.

The application order of metadata is:

```
metadata.yaml < inputs/<filename>.md
```

4. Run `bin/prepare <filename>` to generate a PDF of your manuscript. The PDF will be saved in the `outputs` directory, as `<filename>.pdf`.

## Testing

Tests are run through `bats`. Run `bin/test` to run the tests.
Linting is done through `rubocop` and `shellcheck`. Run `bin/lint` to lint.
