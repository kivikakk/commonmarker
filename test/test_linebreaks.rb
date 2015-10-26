require 'test_helper'

class TestLinebreaks < Minitest::Test
  def test_hardbreak_no_spaces
    doc = CommonMarker.render_doc("foo\nbaz")
    assert_equal "<p>foo\nbaz</p>\n", doc.to_html

    doc = CommonMarker.render_doc("foo\nbaz")
    assert_equal "<p>foo<br />\nbaz</p>\n", doc.to_html(:hardbreaks)
  end

  def test_hardbreak_with_spaces
    doc = CommonMarker.render_doc("foo  \nbaz")
    assert_equal "<p>foo<br />\nbaz</p>\n", doc.to_html

    doc = CommonMarker.render_doc("foo  \nbaz", :hardbreaks)
    assert_equal "<p>foo<br />\nbaz</p>\n", doc.to_html(:hardbreaks)
  end
end
