#!/usr/bin/env bats

load 'test_helper/bats-support/load'
load 'test_helper/bats-assert/load'

DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
PATH="$DIR/../bin:$PATH"

@test "process" {
  run process test/test_input.md --metadata-file="$DIR/test_metadata.yaml"
  assert_success
  assert_line -p "<title>A Room With A View - Extract</title>"
}

@test "contains author information" {
    run process test/test_input.md --metadata-file="$DIR/test_metadata.yaml"
    assert_success
    assert_line -p "<p class=\"author\">Edward Morgan Forster</p>"
    assert_line -p '<p class="email">e.m.forster@example.com</p>'
}

@test "contains address information" {
    run process test/test_input.md --metadata-file="$DIR/test_metadata.yaml"
    assert_success
    assert_line -p '<p class="address">123 Fake Street</p>'
    assert_line -p '<p class="address">Anytown</p>'
    assert_line -p '<p class="address">CO</p>'
    assert_line -p '<p class="address">USA</p>'
    assert_line -p '<p class="address">90210</p>'
}

@test "contains byline" {
    run process test/test_input.md --metadata-file="$DIR/test_metadata.yaml"
    assert_success
    assert_line -p '<meta name="author" content="by E. M. Forster" />'
    assert_line -p '<p class="author">by E. M. Forster</p>'
}

@test "contains approximate wordcount" {
    run process test/test_input.md --metadata-file="$DIR/test_metadata.yaml"
    assert_success
    assert_line -p '<p class="wordcount">about 1,200 words</p>'
}

@test "renders smart quotes" {
    run process test/test_input.md --metadata-file="$DIR/test_metadata.yaml"
    assert_success
    assert_line -p '“'
    assert_line -p '”'
    assert_line -p '’'
}

