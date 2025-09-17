--[[
关于CJK扩展字符
  CJK = 中日韩（China, Japan, Korea），这个主要是指的东亚地区使用汉字及部分衍生偏僻字的字符集
  （由于其使用频率非常低，一般的电脑系统里没有相关的字符，因此不能显示这些字）

查询unicode 编码
  1. https://unicode.org/charts/

查询 Unicode 编码区
  https://www.unicode.org/Public/UCD/latest/ucd/Blocks.txt

导出函数
  1. charset_filter: 滤除含 CJK 扩展汉字的候选项
  2. charset_comment_filter: 为候选项加上其所属字符集的注释

本例说明了 filter 最基本的写法。

请见 `charset_filter` 和 `charset_comment_filter` 上方注释。
--]]

-- 帮助函数（可跳过）
local charset = {
   ["Basic Latin"] = { first = 0x0000, last = 0x007F },
   ["Latin-1 Supplement"] = { first = 0x0080, last = 0x00FF },
   ["Latin Extended-A"] = { first = 0x0100, last = 0x017F },
   ["Latin Extended-B"] = { first = 0x0180, last = 0x024F },
   ["IPA Extensions"] = { first = 0x0250, last = 0x02AF },
   ["Spacing Modifier Letters"] = { first = 0x02B0, last = 0x02FF },
   ["Combining Diacritical Marks"] = { first = 0x0300, last = 0x036F },
   ["Greek and Coptic"] = { first = 0x0370, last = 0x03FF },
   ["Cyrillic"] = { first = 0x0400, last = 0x04FF },
   ["Cyrillic Supplement"] = { first = 0x0500, last = 0x052F },
   ["Armenian"] = { first = 0x0530, last = 0x058F },
   ["Hebrew"] = { first = 0x0590, last = 0x05FF },
   ["Arabic"] = { first = 0x0600, last = 0x06FF },
   ["Syriac"] = { first = 0x0700, last = 0x074F },
   ["Arabic Supplement"] = { first = 0x0750, last = 0x077F },
   ["Thaana"] = { first = 0x0780, last = 0x07BF },
   ["NKo"] = { first = 0x07C0, last = 0x07FF },
   ["Samaritan"] = { first = 0x0800, last = 0x083F },
   ["Mandaic"] = { first = 0x0840, last = 0x085F },
   ["Syriac Supplement"] = { first = 0x0860, last = 0x086F },
   ["Arabic Extended-B"] = { first = 0x0870, last = 0x089F },
   ["Arabic Extended-A"] = { first = 0x08A0, last = 0x08FF },
   ["Devanagari"] = { first = 0x0900, last = 0x097F },
   ["Bengali"] = { first = 0x0980, last = 0x09FF },
   ["Gurmukhi"] = { first = 0x0A00, last = 0x0A7F },
   ["Gujarati"] = { first = 0x0A80, last = 0x0AFF },
   ["Oriya"] = { first = 0x0B00, last = 0x0B7F },
   ["Tamil"] = { first = 0x0B80, last = 0x0BFF },
   ["Telugu"] = { first = 0x0C00, last = 0x0C7F },
   ["Kannada"] = { first = 0x0C80, last = 0x0CFF },
   ["Malayalam"] = { first = 0x0D00, last = 0x0D7F },
   ["Sinhala"] = { first = 0x0D80, last = 0x0DFF },
   ["Thai"] = { first = 0x0E00, last = 0x0E7F },
   ["Lao"] = { first = 0x0E80, last = 0x0EFF },
   ["Tibetan"] = { first = 0x0F00, last = 0x0FFF },
   ["Myanmar"] = { first = 0x1000, last = 0x109F },
   ["Georgian"] = { first = 0x10A0, last = 0x10FF },
   ["Hangul Jamo"] = { first = 0x1100, last = 0x11FF },
   ["Ethiopic"] = { first = 0x1200, last = 0x137F },
   ["Ethiopic Supplement"] = { first = 0x1380, last = 0x139F },
   ["Cherokee"] = { first = 0x13A0, last = 0x13FF },
   ["Unified Canadian Aboriginal Syllabics"] = { first = 0x1400, last = 0x167F },
   ["Ogham"] = { first = 0x1680, last = 0x169F },
   ["Runic"] = { first = 0x16A0, last = 0x16FF },
   ["Tagalog"] = { first = 0x1700, last = 0x171F },
   ["Hanunoo"] = { first = 0x1720, last = 0x173F },
   ["Buhid"] = { first = 0x1740, last = 0x175F },
   ["Tagbanwa"] = { first = 0x1760, last = 0x177F },
   ["Khmer"] = { first = 0x1780, last = 0x17FF },
   ["Mongolian"] = { first = 0x1800, last = 0x18AF },
   ["Unified Canadian Aboriginal Syllabics Extended"] = { first = 0x18B0, last = 0x18FF },
   ["Limbu"] = { first = 0x1900, last = 0x194F },
   ["Tai Le"] = { first = 0x1950, last = 0x197F },
   ["New Tai Lue"] = { first = 0x1980, last = 0x19DF },
   ["Khmer Symbols"] = { first = 0x19E0, last = 0x19FF },
   ["Buginese"] = { first = 0x1A00, last = 0x1A1F },
   ["Tai Tham"] = { first = 0x1A20, last = 0x1AAF },
   ["Combining Diacritical Marks Extended"] = { first = 0x1AB0, last = 0x1AFF },
   ["Balinese"] = { first = 0x1B00, last = 0x1B7F },
   ["Sundanese"] = { first = 0x1B80, last = 0x1BBF },
   ["Batak"] = { first = 0x1BC0, last = 0x1BFF },
   ["Lepcha"] = { first = 0x1C00, last = 0x1C4F },
   ["Ol Chiki"] = { first = 0x1C50, last = 0x1C7F },
   ["Cyrillic Extended-C"] = { first = 0x1C80, last = 0x1C8F },
   ["Georgian Extended"] = { first = 0x1C90, last = 0x1CBF },
   ["Sundanese Supplement"] = { first = 0x1CC0, last = 0x1CCF },
   ["Vedic Extensions"] = { first = 0x1CD0, last = 0x1CFF },
   ["Phonetic Extensions"] = { first = 0x1D00, last = 0x1D7F },
   ["Phonetic Extensions Supplement"] = { first = 0x1D80, last = 0x1DBF },
   ["Combining Diacritical Marks Supplement"] = { first = 0x1DC0, last = 0x1DFF },
   ["Latin Extended Additional"] = { first = 0x1E00, last = 0x1EFF },
   ["Greek Extended"] = { first = 0x1F00, last = 0x1FFF },
   ["General Punctuation"] = { first = 0x2000, last = 0x206F },
   ["Superscripts and Subscripts"] = { first = 0x2070, last = 0x209F },
   ["Currency Symbols"] = { first = 0x20A0, last = 0x20CF },
   ["Combining Diacritical Marks for Symbols"] = { first = 0x20D0, last = 0x20FF },
   ["Letterlike Symbols"] = { first = 0x2100, last = 0x214F },
   ["Number Forms"] = { first = 0x2150, last = 0x218F },
   ["Arrows"] = { first = 0x2190, last = 0x21FF },
   ["Mathematical Operators"] = { first = 0x2200, last = 0x22FF },
   ["Miscellaneous Technical"] = { first = 0x2300, last = 0x23FF },
   ["Control Pictures"] = { first = 0x2400, last = 0x243F },
   ["Optical Character Recognition"] = { first = 0x2440, last = 0x245F },
   ["Enclosed Alphanumerics"] = { first = 0x2460, last = 0x24FF },
   ["Box Drawing"] = { first = 0x2500, last = 0x257F },
   ["Block Elements"] = { first = 0x2580, last = 0x259F },
   ["Geometric Shapes"] = { first = 0x25A0, last = 0x25FF },
   ["Miscellaneous Symbols"] = { first = 0x2600, last = 0x26FF },
   ["Dingbats"] = { first = 0x2700, last = 0x27BF },
   ["Miscellaneous Mathematical Symbols-A"] = { first = 0x27C0, last = 0x27EF },
   ["Supplemental Arrows-A"] = { first = 0x27F0, last = 0x27FF },
   ["Braille Patterns"] = { first = 0x2800, last = 0x28FF },
   ["Supplemental Arrows-B"] = { first = 0x2900, last = 0x297F },
   ["Miscellaneous Mathematical Symbols-B"] = { first = 0x2980, last = 0x29FF },
   ["Supplemental Mathematical Operators"] = { first = 0x2A00, last = 0x2AFF },
   ["Miscellaneous Symbols and Arrows"] = { first = 0x2B00, last = 0x2BFF },
   ["Glagolitic"] = { first = 0x2C00, last = 0x2C5F },
   ["Latin Extended-C"] = { first = 0x2C60, last = 0x2C7F },
   ["Coptic"] = { first = 0x2C80, last = 0x2CFF },
   ["Georgian Supplement"] = { first = 0x2D00, last = 0x2D2F },
   ["Tifinagh"] = { first = 0x2D30, last = 0x2D7F },
   ["Ethiopic Extended"] = { first = 0x2D80, last = 0x2DDF },
   ["Cyrillic Extended-A"] = { first = 0x2DE0, last = 0x2DFF },
   ["Supplemental Punctuation"] = { first = 0x2E00, last = 0x2E7F },
   ["CJK Radicals Supplement"] = { first = 0x2E80, last = 0x2EFF },
   ["Kangxi Radicals"] = { first = 0x2F00, last = 0x2FDF },
   ["Ideographic Description Characters"] = { first = 0x2FF0, last = 0x2FFF },
   ["CJK Symbols and Punctuation"] = { first = 0x3000, last = 0x303F },
   ["Hiragana"] = { first = 0x3040, last = 0x309F },
   ["Katakana"] = { first = 0x30A0, last = 0x30FF },
   ["Bopomofo"] = { first = 0x3100, last = 0x312F },
   ["Hangul Compatibility Jamo"] = { first = 0x3130, last = 0x318F },
   ["Kanbun"] = { first = 0x3190, last = 0x319F },
   ["Bopomofo Extended"] = { first = 0x31A0, last = 0x31BF },
   ["CJK Strokes"] = { first = 0x31C0, last = 0x31EF },
   ["Katakana Phonetic Extensions"] = { first = 0x31F0, last = 0x31FF },
   ["Enclosed CJK Letters and Months"] = { first = 0x3200, last = 0x32FF },
   ["CJK Compatibility"] = { first = 0x3300, last = 0x33FF },
   ["CJK Unified Ideographs Extension A"] = { first = 0x3400, last = 0x4DBF },
   ["Yijing Hexagram Symbols"] = { first = 0x4DC0, last = 0x4DFF },
   ["CJK Unified Ideographs"] = { first = 0x4E00, last = 0x9FFF },
   ["Yi Syllables"] = { first = 0xA000, last = 0xA48F },
   ["Yi Radicals"] = { first = 0xA490, last = 0xA4CF },
   ["Lisu"] = { first = 0xA4D0, last = 0xA4FF },
   ["Vai"] = { first = 0xA500, last = 0xA63F },
   ["Cyrillic Extended-B"] = { first = 0xA640, last = 0xA69F },
   ["Bamum"] = { first = 0xA6A0, last = 0xA6FF },
   ["Modifier Tone Letters"] = { first = 0xA700, last = 0xA71F },
   ["Latin Extended-D"] = { first = 0xA720, last = 0xA7FF },
   ["Syloti Nagri"] = { first = 0xA800, last = 0xA82F },
   ["Common Indic Number Forms"] = { first = 0xA830, last = 0xA83F },
   ["Phags-pa"] = { first = 0xA840, last = 0xA87F },
   ["Saurashtra"] = { first = 0xA880, last = 0xA8DF },
   ["Devanagari Extended"] = { first = 0xA8E0, last = 0xA8FF },
   ["Kayah Li"] = { first = 0xA900, last = 0xA92F },
   ["Rejang"] = { first = 0xA930, last = 0xA95F },
   ["Hangul Jamo Extended-A"] = { first = 0xA960, last = 0xA97F },
   ["Javanese"] = { first = 0xA980, last = 0xA9DF },
   ["Myanmar Extended-B"] = { first = 0xA9E0, last = 0xA9FF },
   ["Cham"] = { first = 0xAA00, last = 0xAA5F },
   ["Myanmar Extended-A"] = { first = 0xAA60, last = 0xAA7F },
   ["Tai Viet"] = { first = 0xAA80, last = 0xAADF },
   ["Meetei Mayek Extensions"] = { first = 0xAAE0, last = 0xAAFF },
   ["Ethiopic Extended-A"] = { first = 0xAB00, last = 0xAB2F },
   ["Latin Extended-E"] = { first = 0xAB30, last = 0xAB6F },
   ["Cherokee Supplement"] = { first = 0xAB70, last = 0xABBF },
   ["Meetei Mayek"] = { first = 0xABC0, last = 0xABFF },
   ["Hangul Syllables"] = { first = 0xAC00, last = 0xD7AF },
   ["Hangul Jamo Extended-B"] = { first = 0xD7B0, last = 0xD7FF },
   ["High Surrogates"] = { first = 0xD800, last = 0xDB7F },
   ["High Private Use Surrogates"] = { first = 0xDB80, last = 0xDBFF },
   ["Low Surrogates"] = { first = 0xDC00, last = 0xDFFF },
   ["Private Use Area"] = { first = 0xE000, last = 0xF8FF },
   ["CJK Compatibility Ideographs"] = { first = 0xF900, last = 0xFAFF },
   ["Alphabetic Presentation Forms"] = { first = 0xFB00, last = 0xFB4F },
   ["Arabic Presentation Forms-A"] = { first = 0xFB50, last = 0xFDFF },
   ["Variation Selectors"] = { first = 0xFE00, last = 0xFE0F },
   ["Vertical Forms"] = { first = 0xFE10, last = 0xFE1F },
   ["Combining Half Marks"] = { first = 0xFE20, last = 0xFE2F },
   ["CJK Compatibility Forms"] = { first = 0xFE30, last = 0xFE4F },
   ["Small Form Variants"] = { first = 0xFE50, last = 0xFE6F },
   ["Arabic Presentation Forms-B"] = { first = 0xFE70, last = 0xFEFF },
   ["Halfwidth and Fullwidth Forms"] = { first = 0xFF00, last = 0xFFEF },
   ["Specials"] = { first = 0xFFF0, last = 0xFFFF },
   ["Linear B Syllabary"] = { first = 0x10000, last = 0x1007F },
   ["Linear B Ideograms"] = { first = 0x10080, last = 0x100FF },
   ["Aegean Numbers"] = { first = 0x10100, last = 0x1013F },
   ["Ancient Greek Numbers"] = { first = 0x10140, last = 0x1018F },
   ["Ancient Symbols"] = { first = 0x10190, last = 0x101CF },
   ["Phaistos Disc"] = { first = 0x101D0, last = 0x101FF },
   ["Lycian"] = { first = 0x10280, last = 0x1029F },
   ["Carian"] = { first = 0x102A0, last = 0x102DF },
   ["Coptic Epact Numbers"] = { first = 0x102E0, last = 0x102FF },
   ["Old Italic"] = { first = 0x10300, last = 0x1032F },
   ["Gothic"] = { first = 0x10330, last = 0x1034F },
   ["Old Permic"] = { first = 0x10350, last = 0x1037F },
   ["Ugaritic"] = { first = 0x10380, last = 0x1039F },
   ["Old Persian"] = { first = 0x103A0, last = 0x103DF },
   ["Deseret"] = { first = 0x10400, last = 0x1044F },
   ["Shavian"] = { first = 0x10450, last = 0x1047F },
   ["Osmanya"] = { first = 0x10480, last = 0x104AF },
   ["Osage"] = { first = 0x104B0, last = 0x104FF },
   ["Elbasan"] = { first = 0x10500, last = 0x1052F },
   ["Caucasian Albanian"] = { first = 0x10530, last = 0x1056F },
   ["Vithkuqi"] = { first = 0x10570, last = 0x105BF },
   ["Todhri"] = { first = 0x105C0, last = 0x105FF },
   ["Linear A"] = { first = 0x10600, last = 0x1077F },
   ["Latin Extended-F"] = { first = 0x10780, last = 0x107BF },
   ["Cypriot Syllabary"] = { first = 0x10800, last = 0x1083F },
   ["Imperial Aramaic"] = { first = 0x10840, last = 0x1085F },
   ["Palmyrene"] = { first = 0x10860, last = 0x1087F },
   ["Nabataean"] = { first = 0x10880, last = 0x108AF },
   ["Hatran"] = { first = 0x108E0, last = 0x108FF },
   ["Phoenician"] = { first = 0x10900, last = 0x1091F },
   ["Lydian"] = { first = 0x10920, last = 0x1093F },
   ["Sidetic"] = { first = 0x10940, last = 0x1095F },
   ["Meroitic Hieroglyphs"] = { first = 0x10980, last = 0x1099F },
   ["Meroitic Cursive"] = { first = 0x109A0, last = 0x109FF },
   ["Kharoshthi"] = { first = 0x10A00, last = 0x10A5F },
   ["Old South Arabian"] = { first = 0x10A60, last = 0x10A7F },
   ["Old North Arabian"] = { first = 0x10A80, last = 0x10A9F },
   ["Manichaean"] = { first = 0x10AC0, last = 0x10AFF },
   ["Avestan"] = { first = 0x10B00, last = 0x10B3F },
   ["Inscriptional Parthian"] = { first = 0x10B40, last = 0x10B5F },
   ["Inscriptional Pahlavi"] = { first = 0x10B60, last = 0x10B7F },
   ["Psalter Pahlavi"] = { first = 0x10B80, last = 0x10BAF },
   ["Old Turkic"] = { first = 0x10C00, last = 0x10C4F },
   ["Old Hungarian"] = { first = 0x10C80, last = 0x10CFF },
   ["Hanifi Rohingya"] = { first = 0x10D00, last = 0x10D3F },
   ["Garay"] = { first = 0x10D40, last = 0x10D8F },
   ["Rumi Numeral Symbols"] = { first = 0x10E60, last = 0x10E7F },
   ["Yezidi"] = { first = 0x10E80, last = 0x10EBF },
   ["Arabic Extended-C"] = { first = 0x10EC0, last = 0x10EFF },
   ["Old Sogdian"] = { first = 0x10F00, last = 0x10F2F },
   ["Sogdian"] = { first = 0x10F30, last = 0x10F6F },
   ["Old Uyghur"] = { first = 0x10F70, last = 0x10FAF },
   ["Chorasmian"] = { first = 0x10FB0, last = 0x10FDF },
   ["Elymaic"] = { first = 0x10FE0, last = 0x10FFF },
   ["Brahmi"] = { first = 0x11000, last = 0x1107F },
   ["Kaithi"] = { first = 0x11080, last = 0x110CF },
   ["Sora Sompeng"] = { first = 0x110D0, last = 0x110FF },
   ["Chakma"] = { first = 0x11100, last = 0x1114F },
   ["Mahajani"] = { first = 0x11150, last = 0x1117F },
   ["Sharada"] = { first = 0x11180, last = 0x111DF },
   ["Sinhala Archaic Numbers"] = { first = 0x111E0, last = 0x111FF },
   ["Khojki"] = { first = 0x11200, last = 0x1124F },
   ["Multani"] = { first = 0x11280, last = 0x112AF },
   ["Khudawadi"] = { first = 0x112B0, last = 0x112FF },
   ["Grantha"] = { first = 0x11300, last = 0x1137F },
   ["Tulu-Tigalari"] = { first = 0x11380, last = 0x113FF },
   ["Newa"] = { first = 0x11400, last = 0x1147F },
   ["Tirhuta"] = { first = 0x11480, last = 0x114DF },
   ["Siddham"] = { first = 0x11580, last = 0x115FF },
   ["Modi"] = { first = 0x11600, last = 0x1165F },
   ["Mongolian Supplement"] = { first = 0x11660, last = 0x1167F },
   ["Takri"] = { first = 0x11680, last = 0x116CF },
   ["Myanmar Extended-C"] = { first = 0x116D0, last = 0x116FF },
   ["Ahom"] = { first = 0x11700, last = 0x1174F },
   ["Dogra"] = { first = 0x11800, last = 0x1184F },
   ["Warang Citi"] = { first = 0x118A0, last = 0x118FF },
   ["Dives Akuru"] = { first = 0x11900, last = 0x1195F },
   ["Nandinagari"] = { first = 0x119A0, last = 0x119FF },
   ["Zanabazar Square"] = { first = 0x11A00, last = 0x11A4F },
   ["Soyombo"] = { first = 0x11A50, last = 0x11AAF },
   ["Unified Canadian Aboriginal Syllabics Extended-A"] = { first = 0x11AB0, last = 0x11ABF },
   ["Pau Cin Hau"] = { first = 0x11AC0, last = 0x11AFF },
   ["Devanagari Extended-A"] = { first = 0x11B00, last = 0x11B5F },
   ["Sharada Supplement"] = { first = 0x11B60, last = 0x11B7F },
   ["Sunuwar"] = { first = 0x11BC0, last = 0x11BFF },
   ["Bhaiksuki"] = { first = 0x11C00, last = 0x11C6F },
   ["Marchen"] = { first = 0x11C70, last = 0x11CBF },
   ["Masaram Gondi"] = { first = 0x11D00, last = 0x11D5F },
   ["Gunjala Gondi"] = { first = 0x11D60, last = 0x11DAF },
   ["Tolong Siki"] = { first = 0x11DB0, last = 0x11DEF },
   ["Makasar"] = { first = 0x11EE0, last = 0x11EFF },
   ["Kawi"] = { first = 0x11F00, last = 0x11F5F },
   ["Lisu Supplement"] = { first = 0x11FB0, last = 0x11FBF },
   ["Tamil Supplement"] = { first = 0x11FC0, last = 0x11FFF },
   ["Cuneiform"] = { first = 0x12000, last = 0x123FF },
   ["Cuneiform Numbers and Punctuation"] = { first = 0x12400, last = 0x1247F },
   ["Early Dynastic Cuneiform"] = { first = 0x12480, last = 0x1254F },
   ["Cypro-Minoan"] = { first = 0x12F90, last = 0x12FFF },
   ["Egyptian Hieroglyphs"] = { first = 0x13000, last = 0x1342F },
   ["Egyptian Hieroglyph Format Controls"] = { first = 0x13430, last = 0x1345F },
   ["Egyptian Hieroglyphs Extended-A"] = { first = 0x13460, last = 0x143FF },
   ["Anatolian Hieroglyphs"] = { first = 0x14400, last = 0x1467F },
   ["Gurung Khema"] = { first = 0x16100, last = 0x1613F },
   ["Bamum Supplement"] = { first = 0x16800, last = 0x16A3F },
   ["Mro"] = { first = 0x16A40, last = 0x16A6F },
   ["Tangsa"] = { first = 0x16A70, last = 0x16ACF },
   ["Bassa Vah"] = { first = 0x16AD0, last = 0x16AFF },
   ["Pahawh Hmong"] = { first = 0x16B00, last = 0x16B8F },
   ["Kirat Rai"] = { first = 0x16D40, last = 0x16D7F },
   ["Medefaidrin"] = { first = 0x16E40, last = 0x16E9F },
   ["Beria Erfe"] = { first = 0x16EA0, last = 0x16EDF },
   ["Miao"] = { first = 0x16F00, last = 0x16F9F },
   ["Ideographic Symbols and Punctuation"] = { first = 0x16FE0, last = 0x16FFF },
   ["Tangut"] = { first = 0x17000, last = 0x187FF },
   ["Tangut Components"] = { first = 0x18800, last = 0x18AFF },
   ["Khitan Small Script"] = { first = 0x18B00, last = 0x18CFF },
   ["Tangut Supplement"] = { first = 0x18D00, last = 0x18D7F },
   ["Tangut Components Supplement"] = { first = 0x18D80, last = 0x18DFF },
   ["Kana Extended-B"] = { first = 0x1AFF0, last = 0x1AFFF },
   ["Kana Supplement"] = { first = 0x1B000, last = 0x1B0FF },
   ["Kana Extended-A"] = { first = 0x1B100, last = 0x1B12F },
   ["Small Kana Extension"] = { first = 0x1B130, last = 0x1B16F },
   ["Nushu"] = { first = 0x1B170, last = 0x1B2FF },
   ["Duployan"] = { first = 0x1BC00, last = 0x1BC9F },
   ["Shorthand Format Controls"] = { first = 0x1BCA0, last = 0x1BCAF },
   ["Symbols for Legacy Computing Supplement"] = { first = 0x1CC00, last = 0x1CEBF },
   ["Miscellaneous Symbols Supplement"] = { first = 0x1CEC0, last = 0x1CEFF },
   ["Znamenny Musical Notation"] = { first = 0x1CF00, last = 0x1CFCF },
   ["Byzantine Musical Symbols"] = { first = 0x1D000, last = 0x1D0FF },
   ["Musical Symbols"] = { first = 0x1D100, last = 0x1D1FF },
   ["Ancient Greek Musical Notation"] = { first = 0x1D200, last = 0x1D24F },
   ["Kaktovik Numerals"] = { first = 0x1D2C0, last = 0x1D2DF },
   ["Mayan Numerals"] = { first = 0x1D2E0, last = 0x1D2FF },
   ["Tai Xuan Jing Symbols"] = { first = 0x1D300, last = 0x1D35F },
   ["Counting Rod Numerals"] = { first = 0x1D360, last = 0x1D37F },
   ["Mathematical Alphanumeric Symbols"] = { first = 0x1D400, last = 0x1D7FF },
   ["Sutton SignWriting"] = { first = 0x1D800, last = 0x1DAAF },
   ["Latin Extended-G"] = { first = 0x1DF00, last = 0x1DFFF },
   ["Glagolitic Supplement"] = { first = 0x1E000, last = 0x1E02F },
   ["Cyrillic Extended-D"] = { first = 0x1E030, last = 0x1E08F },
   ["Nyiakeng Puachue Hmong"] = { first = 0x1E100, last = 0x1E14F },
   ["Toto"] = { first = 0x1E290, last = 0x1E2BF },
   ["Wancho"] = { first = 0x1E2C0, last = 0x1E2FF },
   ["Nag Mundari"] = { first = 0x1E4D0, last = 0x1E4FF },
   ["Ol Onal"] = { first = 0x1E5D0, last = 0x1E5FF },
   ["Tai Yo"] = { first = 0x1E6C0, last = 0x1E6FF },
   ["Ethiopic Extended-B"] = { first = 0x1E7E0, last = 0x1E7FF },
   ["Mende Kikakui"] = { first = 0x1E800, last = 0x1E8DF },
   ["Adlam"] = { first = 0x1E900, last = 0x1E95F },
   ["Indic Siyaq Numbers"] = { first = 0x1EC70, last = 0x1ECBF },
   ["Ottoman Siyaq Numbers"] = { first = 0x1ED00, last = 0x1ED4F },
   ["Arabic Mathematical Alphabetic Symbols"] = { first = 0x1EE00, last = 0x1EEFF },
   ["Mahjong Tiles"] = { first = 0x1F000, last = 0x1F02F },
   ["Domino Tiles"] = { first = 0x1F030, last = 0x1F09F },
   ["Playing Cards"] = { first = 0x1F0A0, last = 0x1F0FF },
   ["Enclosed Alphanumeric Supplement"] = { first = 0x1F100, last = 0x1F1FF },
   ["Enclosed Ideographic Supplement"] = { first = 0x1F200, last = 0x1F2FF },
   ["Miscellaneous Symbols and Pictographs"] = { first = 0x1F300, last = 0x1F5FF },
   ["Emoticons"] = { first = 0x1F600, last = 0x1F64F },
   ["Ornamental Dingbats"] = { first = 0x1F650, last = 0x1F67F },
   ["Transport and Map Symbols"] = { first = 0x1F680, last = 0x1F6FF },
   ["Alchemical Symbols"] = { first = 0x1F700, last = 0x1F77F },
   ["Geometric Shapes Extended"] = { first = 0x1F780, last = 0x1F7FF },
   ["Supplemental Arrows-C"] = { first = 0x1F800, last = 0x1F8FF },
   ["Supplemental Symbols and Pictographs"] = { first = 0x1F900, last = 0x1F9FF },
   ["Chess Symbols"] = { first = 0x1FA00, last = 0x1FA6F },
   ["Symbols and Pictographs Extended-A"] = { first = 0x1FA70, last = 0x1FAFF },
   ["Symbols for Legacy Computing"] = { first = 0x1FB00, last = 0x1FBFF },
   ["CJK Unified Ideographs Extension B"] = { first = 0x20000, last = 0x2A6DF },
   ["CJK Unified Ideographs Extension C"] = { first = 0x2A700, last = 0x2B73F },
   ["CJK Unified Ideographs Extension D"] = { first = 0x2B740, last = 0x2B81F },
   ["CJK Unified Ideographs Extension E"] = { first = 0x2B820, last = 0x2CEAF },
   ["CJK Unified Ideographs Extension F"] = { first = 0x2CEB0, last = 0x2EBEF },
   ["CJK Unified Ideographs Extension I"] = { first = 0x2EBF0, last = 0x2EE5F },
   ["CJK Compatibility Ideographs Supplement"] = { first = 0x2F800, last = 0x2FA1F },
   ["CJK Unified Ideographs Extension G"] = { first = 0x30000, last = 0x3134F },
   ["CJK Unified Ideographs Extension H"] = { first = 0x31350, last = 0x323AF },
   ["CJK Unified Ideographs Extension J"] = { first = 0x323B0, last = 0x3347F },
   ["Tags"] = { first = 0xE0000, last = 0xE007F },
   ["Variation Selectors Supplement"] = { first = 0xE0100, last = 0xE01EF },
   ["Supplementary Private Use Area-A"] = { first = 0xF0000, last = 0xFFFFF },
   ["Supplementary Private Use Area-B"] = { first = 0x100000, last = 0x10FFFF } }

local function exists(single_filter, text)
  for i in utf8.codes(text) do
     local c = utf8.codepoint(text, i)
     if (not single_filter(c)) then
      return false
     end
  end
  return true
end

local function is_charset(s)
   return function (c)
      return c >= charset[s].first and c <= charset[s].last
   end
end

local function is_cjk_ext(c)
   return is_charset("Basic Latin")(c) or
      is_charset("Latin-1 Supplement")(c) or
      is_charset("Latin Extended-A")(c) or
      is_charset("Latin Extended-B")(c) or
      is_charset("IPA Extensions")(c) or
      is_charset("Spacing Modifier Letters")(c) or
      is_charset("Combining Diacritical Marks")(c) or
      is_charset("Greek and Coptic")(c) or
      is_charset("Cyrillic")(c) or
      is_charset("Cyrillic Supplement")(c) or
      is_charset("Armenian")(c) or
      is_charset("Hebrew")(c) or
      is_charset("Arabic")(c) or
      is_charset("Syriac")(c) or
      is_charset("Arabic Supplement")(c) or
      is_charset("Thaana")(c) or
      is_charset("NKo")(c) or
      is_charset("Samaritan")(c) or
      is_charset("Mandaic")(c) or
      is_charset("Syriac Supplement")(c) or
      is_charset("Arabic Extended-B")(c) or
      is_charset("Arabic Extended-A")(c) or
      is_charset("Devanagari")(c) or
      is_charset("Bengali")(c) or
      is_charset("Gurmukhi")(c) or
      is_charset("Gujarati")(c) or
      is_charset("Oriya")(c) or
      is_charset("Tamil")(c) or
      is_charset("Telugu")(c) or
      is_charset("Kannada")(c) or
      is_charset("Malayalam")(c) or
      is_charset("Sinhala")(c) or
      is_charset("Thai")(c) or
      is_charset("Lao")(c) or
      is_charset("Tibetan")(c) or
      is_charset("Myanmar")(c) or
      is_charset("Georgian")(c) or
      is_charset("Hangul Jamo")(c) or
      is_charset("Ethiopic")(c) or
      is_charset("Ethiopic Supplement")(c) or
      is_charset("Cherokee")(c) or
      is_charset("Unified Canadian Aboriginal Syllabics")(c) or
      is_charset("Ogham")(c) or
      is_charset("Runic")(c) or
      is_charset("Tagalog")(c) or
      is_charset("Hanunoo")(c) or
      is_charset("Buhid")(c) or
      is_charset("Tagbanwa")(c) or
      is_charset("Khmer")(c) or
      is_charset("Mongolian")(c) or
      is_charset("Unified Canadian Aboriginal Syllabics Extended")(c) or
      is_charset("Limbu")(c) or
      is_charset("Tai Le")(c) or
      is_charset("New Tai Lue")(c) or
      is_charset("Khmer Symbols")(c) or
      is_charset("Buginese")(c) or
      is_charset("Tai Tham")(c) or
      is_charset("Combining Diacritical Marks Extended")(c) or
      is_charset("Balinese")(c) or
      is_charset("Sundanese")(c) or
      is_charset("Batak")(c) or
      is_charset("Lepcha")(c) or
      is_charset("Ol Chiki")(c) or
      is_charset("Cyrillic Extended-C")(c) or
      is_charset("Georgian Extended")(c) or
      is_charset("Sundanese Supplement")(c) or
      is_charset("Vedic Extensions")(c) or
      is_charset("Phonetic Extensions")(c) or
      is_charset("Phonetic Extensions Supplement")(c) or
      is_charset("Combining Diacritical Marks Supplement")(c) or
      is_charset("Latin Extended Additional")(c) or
      is_charset("Greek Extended")(c) or
      is_charset("General Punctuation")(c) or
      is_charset("Superscripts and Subscripts")(c) or
      is_charset("Currency Symbols")(c) or
      is_charset("Combining Diacritical Marks for Symbols")(c) or
      is_charset("Letterlike Symbols")(c) or
      is_charset("Number Forms")(c) or
      is_charset("Arrows")(c) or
      is_charset("Mathematical Operators")(c) or
      is_charset("Miscellaneous Technical")(c) or
      is_charset("Control Pictures")(c) or
      is_charset("Optical Character Recognition")(c) or
      is_charset("Enclosed Alphanumerics")(c) or
      is_charset("Box Drawing")(c) or
      is_charset("Block Elements")(c) or
      is_charset("Geometric Shapes")(c) or
      is_charset("Miscellaneous Symbols")(c) or
      is_charset("Dingbats")(c) or
      is_charset("Miscellaneous Mathematical Symbols-A")(c) or
      is_charset("Supplemental Arrows-A")(c) or
      is_charset("Braille Patterns")(c) or
      is_charset("Supplemental Arrows-B")(c) or
      is_charset("Miscellaneous Mathematical Symbols-B")(c) or
      is_charset("Supplemental Mathematical Operators")(c) or
      is_charset("Miscellaneous Symbols and Arrows")(c) or
      is_charset("Glagolitic")(c) or
      is_charset("Latin Extended-C")(c) or
      is_charset("Coptic")(c) or
      is_charset("Georgian Supplement")(c) or
      is_charset("Tifinagh")(c) or
      is_charset("Ethiopic Extended")(c) or
      is_charset("Cyrillic Extended-A")(c) or
      is_charset("Supplemental Punctuation")(c) or
      is_charset("CJK Radicals Supplement")(c) or
      is_charset("Kangxi Radicals")(c) or
      is_charset("Ideographic Description Characters")(c) or
      is_charset("CJK Symbols and Punctuation")(c) or
      is_charset("Hiragana")(c) or
      is_charset("Katakana")(c) or
      is_charset("Bopomofo")(c) or
      is_charset("Hangul Compatibility Jamo")(c) or
      is_charset("Kanbun")(c) or
      is_charset("Bopomofo Extended")(c) or
      is_charset("CJK Strokes")(c) or
      is_charset("Katakana Phonetic Extensions")(c) or
      is_charset("Enclosed CJK Letters and Months")(c) or
      is_charset("CJK Compatibility")(c) or
      is_charset("CJK Unified Ideographs Extension A")(c) or
      is_charset("Yijing Hexagram Symbols")(c) or
      is_charset("CJK Unified Ideographs")(c) or
      is_charset("Yi Syllables")(c) or
      is_charset("Yi Radicals")(c) or
      is_charset("Lisu")(c) or
      is_charset("Vai")(c) or
      is_charset("Cyrillic Extended-B")(c) or
      is_charset("Bamum")(c) or
      is_charset("Modifier Tone Letters")(c) or
      is_charset("Latin Extended-D")(c) or
      is_charset("Syloti Nagri")(c) or
      is_charset("Common Indic Number Forms")(c) or
      is_charset("Phags-pa")(c) or
      is_charset("Saurashtra")(c) or
      is_charset("Devanagari Extended")(c) or
      is_charset("Kayah Li")(c) or
      is_charset("Rejang")(c) or
      is_charset("Hangul Jamo Extended-A")(c) or
      is_charset("Javanese")(c) or
      is_charset("Myanmar Extended-B")(c) or
      is_charset("Cham")(c) or
      is_charset("Myanmar Extended-A")(c) or
      is_charset("Tai Viet")(c) or
      is_charset("Meetei Mayek Extensions")(c) or
      is_charset("Ethiopic Extended-A")(c) or
      is_charset("Latin Extended-E")(c) or
      is_charset("Cherokee Supplement")(c) or
      is_charset("Meetei Mayek")(c) or
      is_charset("Hangul Syllables")(c) or
      is_charset("Hangul Jamo Extended-B")(c) or
      is_charset("High Surrogates")(c) or
      is_charset("High Private Use Surrogates")(c) or
      is_charset("Low Surrogates")(c) or
      is_charset("Private Use Area")(c) or
      is_charset("CJK Compatibility Ideographs")(c) or
      is_charset("Alphabetic Presentation Forms")(c) or
      is_charset("Arabic Presentation Forms-A")(c) or
      is_charset("Variation Selectors")(c) or
      is_charset("Vertical Forms")(c) or
      is_charset("Combining Half Marks")(c) or
      is_charset("CJK Compatibility Forms")(c) or
      is_charset("Small Form Variants")(c) or
      is_charset("Arabic Presentation Forms-B")(c) or
      is_charset("Halfwidth and Fullwidth Forms")(c) or
      is_charset("Specials")(c) or
      is_charset("Linear B Syllabary")(c) or
      is_charset("Linear B Ideograms")(c) or
      is_charset("Aegean Numbers")(c) or
      is_charset("Ancient Greek Numbers")(c) or
      is_charset("Ancient Symbols")(c) or
      is_charset("Phaistos Disc")(c) or
      is_charset("Lycian")(c) or
      is_charset("Carian")(c) or
      is_charset("Coptic Epact Numbers")(c) or
      is_charset("Old Italic")(c) or
      is_charset("Gothic")(c) or
      is_charset("Old Permic")(c) or
      is_charset("Ugaritic")(c) or
      is_charset("Old Persian")(c) or
      is_charset("Deseret")(c) or
      is_charset("Shavian")(c) or
      is_charset("Osmanya")(c) or
      is_charset("Osage")(c) or
      is_charset("Elbasan")(c) or
      is_charset("Caucasian Albanian")(c) or
      is_charset("Vithkuqi")(c) or
      is_charset("Todhri")(c) or
      is_charset("Linear A")(c) or
      is_charset("Latin Extended-F")(c) or
      is_charset("Cypriot Syllabary")(c) or
      is_charset("Imperial Aramaic")(c) or
      is_charset("Palmyrene")(c) or
      is_charset("Nabataean")(c) or
      is_charset("Hatran")(c) or
      is_charset("Phoenician")(c) or
      is_charset("Lydian")(c) or
      is_charset("Sidetic")(c) or
      is_charset("Meroitic Hieroglyphs")(c) or
      is_charset("Meroitic Cursive")(c) or
      is_charset("Kharoshthi")(c) or
      is_charset("Old South Arabian")(c) or
      is_charset("Old North Arabian")(c) or
      is_charset("Manichaean")(c) or
      is_charset("Avestan")(c) or
      is_charset("Inscriptional Parthian")(c) or
      is_charset("Inscriptional Pahlavi")(c) or
      is_charset("Psalter Pahlavi")(c) or
      is_charset("Old Turkic")(c) or
      is_charset("Old Hungarian")(c) or
      is_charset("Hanifi Rohingya")(c) or
      is_charset("Garay")(c) or
      is_charset("Rumi Numeral Symbols")(c) or
      is_charset("Yezidi")(c) or
      is_charset("Arabic Extended-C")(c) or
      is_charset("Old Sogdian")(c) or
      is_charset("Sogdian")(c) or
      is_charset("Old Uyghur")(c) or
      is_charset("Chorasmian")(c) or
      is_charset("Elymaic")(c) or
      is_charset("Brahmi")(c) or
      is_charset("Kaithi")(c) or
      is_charset("Sora Sompeng")(c) or
      is_charset("Chakma")(c) or
      is_charset("Mahajani")(c) or
      is_charset("Sharada")(c) or
      is_charset("Sinhala Archaic Numbers")(c) or
      is_charset("Khojki")(c) or
      is_charset("Multani")(c) or
      is_charset("Khudawadi")(c) or
      is_charset("Grantha")(c) or
      is_charset("Tulu-Tigalari")(c) or
      is_charset("Newa")(c) or
      is_charset("Tirhuta")(c) or
      is_charset("Siddham")(c) or
      is_charset("Modi")(c) or
      is_charset("Mongolian Supplement")(c) or
      is_charset("Takri")(c) or
      is_charset("Myanmar Extended-C")(c) or
      is_charset("Ahom")(c) or
      is_charset("Dogra")(c) or
      is_charset("Warang Citi")(c) or
      is_charset("Dives Akuru")(c) or
      is_charset("Nandinagari")(c) or
      is_charset("Zanabazar Square")(c) or
      is_charset("Soyombo")(c) or
      is_charset("Unified Canadian Aboriginal Syllabics Extended-A")(c) or
      is_charset("Pau Cin Hau")(c) or
      is_charset("Devanagari Extended-A")(c) or
      is_charset("Sharada Supplement")(c) or
      is_charset("Sunuwar")(c) or
      is_charset("Bhaiksuki")(c) or
      is_charset("Marchen")(c) or
      is_charset("Masaram Gondi")(c) or
      is_charset("Gunjala Gondi")(c) or
      is_charset("Tolong Siki")(c) or
      is_charset("Makasar")(c) or
      is_charset("Kawi")(c) or
      is_charset("Lisu Supplement")(c) or
      is_charset("Tamil Supplement")(c) or
      is_charset("Cuneiform")(c) or
      is_charset("Cuneiform Numbers and Punctuation")(c) or
      is_charset("Early Dynastic Cuneiform")(c) or
      is_charset("Cypro-Minoan")(c) or
      is_charset("Egyptian Hieroglyphs")(c) or
      is_charset("Egyptian Hieroglyph Format Controls")(c) or
      is_charset("Egyptian Hieroglyphs Extended-A")(c) or
      is_charset("Anatolian Hieroglyphs")(c) or
      is_charset("Gurung Khema")(c) or
      is_charset("Bamum Supplement")(c) or
      is_charset("Mro")(c) or
      is_charset("Tangsa")(c) or
      is_charset("Bassa Vah")(c) or
      is_charset("Pahawh Hmong")(c) or
      is_charset("Kirat Rai")(c) or
      is_charset("Medefaidrin")(c) or
      is_charset("Beria Erfe")(c) or
      is_charset("Miao")(c) or
      is_charset("Ideographic Symbols and Punctuation")(c) or
      is_charset("Tangut")(c) or
      is_charset("Tangut Components")(c) or
      is_charset("Khitan Small Script")(c) or
      is_charset("Tangut Supplement")(c) or
      is_charset("Tangut Components Supplement")(c) or
      is_charset("Kana Extended-B")(c) or
      is_charset("Kana Supplement")(c) or
      is_charset("Kana Extended-A")(c) or
      is_charset("Small Kana Extension")(c) or
      is_charset("Nushu")(c) or
      is_charset("Duployan")(c) or
      is_charset("Shorthand Format Controls")(c) or
      is_charset("Symbols for Legacy Computing Supplement")(c) or
      is_charset("Miscellaneous Symbols Supplement")(c) or
      is_charset("Znamenny Musical Notation")(c) or
      is_charset("Byzantine Musical Symbols")(c) or
      is_charset("Musical Symbols")(c) or
      is_charset("Ancient Greek Musical Notation")(c) or
      is_charset("Kaktovik Numerals")(c) or
      is_charset("Mayan Numerals")(c) or
      is_charset("Tai Xuan Jing Symbols")(c) or
      is_charset("Counting Rod Numerals")(c) or
      is_charset("Mathematical Alphanumeric Symbols")(c) or
      is_charset("Sutton SignWriting")(c) or
      is_charset("Latin Extended-G")(c) or
      is_charset("Glagolitic Supplement")(c) or
      is_charset("Cyrillic Extended-D")(c) or
      is_charset("Nyiakeng Puachue Hmong")(c) or
      is_charset("Toto")(c) or
      is_charset("Wancho")(c) or
      is_charset("Nag Mundari")(c) or
      is_charset("Ol Onal")(c) or
      is_charset("Tai Yo")(c) or
      is_charset("Ethiopic Extended-B")(c) or
      is_charset("Mende Kikakui")(c) or
      is_charset("Adlam")(c) or
      is_charset("Indic Siyaq Numbers")(c) or
      is_charset("Ottoman Siyaq Numbers")(c) or
      is_charset("Arabic Mathematical Alphabetic Symbols")(c) or
      is_charset("Mahjong Tiles")(c) or
      is_charset("Domino Tiles")(c) or
      is_charset("Playing Cards")(c) or
      is_charset("Enclosed Alphanumeric Supplement")(c) or
      is_charset("Enclosed Ideographic Supplement")(c) or
      is_charset("Miscellaneous Symbols and Pictographs")(c) or
      is_charset("Emoticons")(c) or
      is_charset("Ornamental Dingbats")(c) or
      is_charset("Transport and Map Symbols")(c) or
      is_charset("Alchemical Symbols")(c) or
      is_charset("Geometric Shapes Extended")(c) or
      is_charset("Supplemental Arrows-C")(c) or
      is_charset("Supplemental Symbols and Pictographs")(c) or
      is_charset("Chess Symbols")(c) or
      is_charset("Symbols and Pictographs Extended-A")(c) or
      is_charset("Symbols for Legacy Computing")(c) or
      is_charset("CJK Unified Ideographs Extension B")(c) or
      is_charset("CJK Unified Ideographs Extension C")(c) or
      is_charset("CJK Unified Ideographs Extension D")(c) or
      is_charset("CJK Unified Ideographs Extension E")(c) or
      is_charset("CJK Unified Ideographs Extension F")(c) or
      is_charset("CJK Unified Ideographs Extension I")(c) or
      is_charset("CJK Compatibility Ideographs Supplement")(c) or
      is_charset("CJK Unified Ideographs Extension G")(c) or
      is_charset("CJK Unified Ideographs Extension H")(c) or
      is_charset("CJK Unified Ideographs Extension J")(c) or
      is_charset("Tags")(c) or
      is_charset("Variation Selectors Supplement")(c) or
      is_charset("Supplementary Private Use Area-A")(c) or
      is_charset("Supplementary Private Use Area-B")(c)
end

--[[
filter 的功能是对 translator 翻译而来的候选项做修饰，
如去除不想要的候选、为候选加注释、候选项重排序等。

欲定义的 filter 包含两个输入参数：
 - input: 候选项列表
 - env: 可选参数，表示 filter 所处的环境（本例没有体现）

filter 的输出与 translator 相同，也是若干候选项，也要求您使用 `yield` 产生候选项。

如下例所示，charset_filter 将滤除含 CJK 扩展汉字的候选项：
--]]
local function charset_filter(input)
   -- 使用 `iter()` 遍历所有输入候选项
   for cand in input:iter() do
      -- 如果当前候选项 `cand` 不含 CJK 扩展汉字
      if (not exists(is_cjk_ext, cand.text))
      then
       -- 结果中仍保留此候选
       yield(cand)
      end
      --[[ 上述条件不满足时，当前的候选 `cand` 没有被 yield。
           因此过滤结果中将不含有该候选。
      --]]
   end
end


--[[
如下例所示，charset_comment_filter 为候选项加上其所属字符集的注释：
--]]
local function charset_comment_filter(input)
   -- 使用 `iter()` 遍历所有输入候选项
   for cand in input:iter() do
      -- 判断当前候选内容 `cand.text` 中文字属哪个字符集
      for s, r in pairs(charset) do
       if (exists(is_charset(s), cand.text)) then
          --[[ 修改候选的注释 `cand.comment`
                 因复杂类型候选项的注释不能被直接修改，
                 因此使用 `get_genuine()` 得到其对应真实的候选项
            --]]
          cand:get_genuine().comment = cand.comment .. " " .. s
          break
       end
      end
      -- 在结果中对应产生一个带注释的候选
      yield(cand)
   end
end

-- 本例中定义了两个 filter，故使用一个表将两者导出
return { filter = charset_filter,
       comment_filter = charset_comment_filter }
