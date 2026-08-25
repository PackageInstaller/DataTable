__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ActorAttrType = readonly({
  ActorAttrType_121209_AttributeDesc = {
    Text = "নিষিদ্ধ জ্ঞানের স্তর গোপনরক্ষকের স্তরের সমান এবং নিম্নলিখিত 3 ধরনের গবেষণা গভীরতার প্রভাব নির্ধারণ করে। যদি দলের জাগ্রত সত্তাদের গড় স্তর গোপনরক্ষকের স্তরের সমান বা তার বেশি হয়, তাহলে নিষিদ্ধ জ্ঞানের স্তর দলের জাগ্রত সত্তাদের গড় স্তর ও গোপনরক্ষকের স্তরের গড় হিসেবে গণনা করা হবে।\nজীবদেহ গবেষণা গভীরতা: <Blue:{s1}>\n·জাগ্রত সত্তার প্রতি 100 পয়েন্ট শারীরিক বৈশিষ্ট্য দলের জীবনীশক্তিতে রূপান্তরের প্রভাবের তীব্রতা নির্ধারণ করে।\nবস্তুরূপ গবেষণা গভীরতা: <Blue:{s2}>\n·সৃষ্টি, মুদ্রাঙ্কন, চাবি-আদেশ দ্বারা সৃষ্ট শক্তি, শুঁড়ের ক্ষতি, ঢাল, জীবনীশক্তি পুনরুদ্ধার, শক্তি হ্রাস জাতীয় প্রভাবের তীব্রতা নির্ধারণ করে।\nআত্মিক উপলব্ধি গবেষণা গভীরতা: <Blue:{s3}>\n·সৃষ্টি, মুদ্রাঙ্কন, চাবি-আদেশ দ্বারা সৃষ্ট নির্দিষ্ট বিষক্রিয়া, নির্দিষ্ট পাল্টা আক্রমণ, নির্দিষ্ট ক্ষতি, নির্দিষ্ট রক্তক্ষরণ জাতীয় প্রভাবের তীব্রতা নির্ধারণ করে।\n"
  },
  ActorAttrType_121209_Text = {
    Text = "নিষিদ্ধ জ্ঞানের স্তর"
  },
  ActorAttrType_18103_Text = {Text = "ঢাল"},
  ActorAttrType_18104_Text = {
    Text = "স্ট্রাইক কার্ড ক্ষতি শতাংশ সংশোধন"
  },
  ActorAttrType_18105_AttributeUpText = {
    Text = "ক্রিটিক্যাল ক্ষতি+{s1}"
  },
  ActorAttrType_18105_Text = {
    Text = "ক্রিটিক্যাল ক্ষতি"
  },
  ActorAttrType_18106_Text = {
    Text = "শিল্ড বৃদ্ধি"
  },
  ActorAttrType_18107_AttributeUpText = {
    Text = "আক্রমণ+{s1}"
  },
  ActorAttrType_18107_Text = {
    Text = "আক্রমণ"
  },
  ActorAttrType_18108_Text = {
    Text = "শারীরিক গঠন"
  },
  ActorAttrType_18109_Text = {
    Text = "কার্ড ক্ষতি শতাংশ সংশোধন"
  },
  ActorAttrType_18110_Text = {
    Text = "ভঙ্গুরতা শতাংশ সংশোধন"
  },
  ActorAttrType_18111_Text = {
    Text = "প্রাপ্ত শিল্ড শতাংশ সংশোধন"
  },
  ActorAttrType_18112_AttributeUpText = {
    Text = "প্রতিরক্ষা+{s1}"
  },
  ActorAttrType_18112_Text = {
    Text = "প্রতিরক্ষা বৃদ্ধি"
  },
  ActorAttrType_18113_AttributeDesc = {
    Text = "জাগ্রত সত্তার রেজ চার্জ করার দক্ষতা"
  },
  ActorAttrType_18113_Text = {
    Text = "প্রারম্ভিক রেজ"
  },
  ActorAttrType_18114_AttributeDesc = {
    Text = "শারীরিক গঠন যত বেশি, জাগ্রত সত্তার সর্বোচ্চ HP তত বেশি।\nরহস্যরক্ষকের তদন্ত লেভেল যত বেশি, শারীরিক গঠনের জাগ্রত সত্তার সর্বোচ্চ HP-এর উপর প্রভাব তত শক্তিশালী।"
  },
  ActorAttrType_18114_AttributeUpText = {
    Text = "শারীরিক গঠন+{s1}"
  },
  ActorAttrType_18114_Text = {
    Text = "শারীরিক গঠন"
  },
  ActorAttrType_18115_AttributeDesc = {
    Text = "জাগ্রত সত্তা উৎস আবির্ভাব মুক্ত করার পর, ফেরত পাওয়া রেজ মান"
  },
  ActorAttrType_18115_AttributeUpText = {
    Text = "রেজ ব্যয় হ্রাস+{s1}"
  },
  ActorAttrType_18115_Text = {
    Text = "রেজ ব্যয় হ্রাস"
  },
  ActorAttrType_18116_AttributeDesc = {
    Text = "শারীরিক গঠন যত বেশি, জাগ্রত সত্তার সর্বোচ্চ HP তত বেশি।\nরহস্যরক্ষকের তদন্ত লেভেল যত বেশি, শারীরিক গঠনের জাগ্রত সত্তার সর্বোচ্চ HP-এর উপর প্রভাব তত শক্তিশালী।"
  },
  ActorAttrType_18116_AttributeUpText = {
    Text = "শারীরিক গঠন+{s1}"
  },
  ActorAttrType_18116_Text = {
    Text = "শারীরিক গঠন বৃদ্ধি"
  },
  ActorAttrType_18117_Text = {
    Text = "শুঁড়ের ক্ষতি"
  },
  ActorAttrType_18118_Text = {
    Text = "অতিমাত্রিক কার্ড স্লট সংখ্যা"
  },
  ActorAttrType_18119_Text = {
    Text = "প্রাপ্ত ক্ষতি শতাংশ সংশোধন"
  },
  ActorAttrType_18120_AttributeDesc = {
    Text = "জাগ্রত সত্তার সর্বোচ্চ সঞ্চিত রেজ এবং রেজ বিস্ফোরণ মুক্ত করতে ব্যয়িত রেজ উভয়ই মৌলিক রেজের সমান।"
  },
  ActorAttrType_18120_AttributeUpText = {
    Text = "অ্যালিমাস সীমা +{s1}"
  },
  ActorAttrType_18120_Text = {
    Text = "মৌলিক রেজ"
  },
  ActorAttrType_18121_AttributeDesc = {
    Text = "স্কিল 2 স্তর"
  },
  ActorAttrType_18121_AttributeUpText = {
    Text = "দক্ষতা 2 স্তর +{s1}"
  },
  ActorAttrType_18121_Text = {
    Text = "স্কিল 2 স্তর"
  },
  ActorAttrType_18122_AttributeDesc = {
    Text = "প্রতিরক্ষা স্তর"
  },
  ActorAttrType_18122_AttributeUpText = {
    Text = "প্রতিরক্ষা স্তর+{s1}"
  },
  ActorAttrType_18122_Text = {
    Text = "প্রতিরক্ষা স্তর"
  },
  ActorAttrType_18123_Text = {
    Text = "ক্ষতির সংখ্যা নির্দিষ্ট মান সংশোধন"
  },
  ActorAttrType_18124_Text = {
    Text = "শিল্ড প্রদানের নির্দিষ্ট মান সংশোধন"
  },
  ActorAttrType_18125_Text = {
    Text = "প্রাপ্ত শিল্ড নির্দিষ্ট মান সংশোধন"
  },
  ActorAttrType_18126_AttributeDesc = {
    Text = "দলের রিয়েলম দক্ষতা দলের সকল জাগ্রত সত্তার রিয়েলম দক্ষতার সমষ্টির সমান। রিয়েলম দক্ষতা দলের রিয়েলম প্রতিভা প্রভাব বৃদ্ধি করে। যদি বর্তমান দল 「বিশুদ্ধ গভীর সমুদ্র/বিশুদ্ধ রক্তমাংস/বিশুদ্ধ অতিমাত্রিক」 হয়, তাহলে রিয়েলম দক্ষতার প্রভাব দ্বিগুণ হয়।\n·<Blue:বিশৃঙ্খলা> রিয়েলমের দলে প্রতি 1 পয়েন্ট রিয়েলম দক্ষতায়, কী-অর্ডার ব্যবহারের পর সকল জাগ্রত সত্তা অতিরিক্ত <Blue:0.05> পয়েন্ট উন্মাদনা অর্জন করে।\n·<Blue:গভীর সমুদ্র> রিয়েলমের দলে প্রতি 1 পয়েন্ট রিয়েলম দক্ষতায়, উন্মাদনা বিস্ফোরণ ব্যবহারের পর <Blue:0.25％> সম্ভাবনায় অতিরিক্ত 1 স্তর শুঁড় সমাবেশ অর্জন করা যায়(সম্ভাবনা 100% ছাড়িয়ে গেলে একাধিক স্তর পাওয়া যায়), 「শান্ত সমুদ্র」-এ পরিবর্তন করলে প্রাপ্ত শিল্ড <Blue:0.01％> সর্বোচ্চ জীবনী বৃদ্ধি পায়, 「উত্তাল তরঙ্গ」-এ সক্রিয় ক্ষতি দ্বারা সক্রিয় শুঁড় আক্রমণ <Blue:0.02%> শুঁড় ক্ষতি বৃদ্ধি পায়।\n·<Blue:রক্তমাংস> রিয়েলমের দলে প্রতি 1 পয়েন্ট রিয়েলম দক্ষতায়, প্রতি টার্নে প্রথমবার গ্রাস সক্রিয় হলে সর্বোচ্চ জীবনীর <Blue:0.01%> অতিরিক্ত শিল্ড এবং <Blue:0.005%> অস্থায়ী শক্তি অর্জন করা যায়(হারানো জীবনীর সাথে বৃদ্ধি পায়, সর্বোচ্চ 100％ পর্যন্ত)।\n·<Blue:অতিমাত্রিক> রিয়েলমের দলে প্রতি 1 পয়েন্ট রিয়েলম দক্ষতায়, টার্ন শুরুতে <Blue:0.125%> সম্ভাবনায় 1টি 「অনুপ্রেরণা」 কার্ড অর্জন করা যায়(সম্ভাবনা 100% ছাড়িয়ে গেলে একাধিক পাওয়া যায়)।"
  },
  ActorAttrType_18126_AttributeUpText = {
    Text = "রিয়েল্ম দক্ষতা +{s1}"
  },
  ActorAttrType_18126_Text = {
    Text = "রিয়েলম দক্ষতা"
  },
  ActorAttrType_18127_Text = {Text = "HP"},
  ActorAttrType_18128_AttributeUpText = {
    Text = "আক্রমণ+{s1}"
  },
  ActorAttrType_18128_Text = {
    Text = "আক্রমণ বৃদ্ধি"
  },
  ActorAttrType_18129_AttributeDesc = {
    Text = "মৌলিক ক্ষতি বোনাস যত বেশি, জাগ্রত সত্তার ক্ষতি তত বেশি"
  },
  ActorAttrType_18129_AttributeUpText = {
    Text = "মৌলিক ক্ষতি +{s1}"
  },
  ActorAttrType_18129_Text = {
    Text = "মৌলিক ক্ষতি"
  },
  ActorAttrType_18130_Text = {
    Text = "রক্ষক অভিজ্ঞতা"
  },
  ActorAttrType_18131_AttributeDesc = {
    Text = "রাউন্ড শেষে, জাগ্রত সত্তা স্বয়ংক্রিয়ভাবে যে পরিমাণ রেজ পুনরুদ্ধার করে (পাঠ্যক্রম মোডে, প্রতিটি কর্মের পরে জাগ্রত সত্তা যে পরিমাণ রেজ পুনরুদ্ধার করে)"
  },
  ActorAttrType_18131_AttributeUpText = {
    Text = "অ্যালিমাস স্বয়ংক্রিয় পুনরুদ্ধার +{s1}"
  },
  ActorAttrType_18131_Text = {
    Text = "রেজ স্বয়ংক্রিয় পুনরুদ্ধার"
  },
  ActorAttrType_18132_Text = {
    Text = "আত্মা জাগরণ স্তর"
  },
  ActorAttrType_18133_Text = {
    Text = "প্রাপ্ত উন্মাদনা শতাংশ সংশোধন"
  },
  ActorAttrType_18134_Text = {
    Text = "ভ্রূণ সংমিশ্রণ সীমা"
  },
  ActorAttrType_18135_Text = {
    Text = "ক্যারেক্টারের বর্তমান উন্মাদনা"
  },
  ActorAttrType_18136_Text = {
    Text = "প্রাপ্ত ক্ষতি নির্দিষ্ট মান সংশোধন"
  },
  ActorAttrType_18137_AttributeDesc = {
    Text = "জাগ্রত সত্তা শিল্ড ও পুনরুদ্ধার প্রভাব প্রয়োগ করলে, শিল্ড মান ও পুনরুদ্ধার মানের অনুপাত বৃদ্ধি পায়"
  },
  ActorAttrType_18137_AttributeUpText = {
    Text = "শিল্ড ও হিলিং শক্তি+{s1}"
  },
  ActorAttrType_18137_Text = {
    Text = "শিল্ড ও নিরাময় বর্ধন"
  },
  ActorAttrType_18138_Text = {
    Text = "নিরাময় বৃদ্ধি"
  },
  ActorAttrType_18139_AttributeDesc = {
    Text = "কমান্ড কার্ড খেলা বা জাগরণের সময়, প্রতি 1 অ্যারিথমেটিকা ব্যয়ে {s1} পয়েন্ট S-শক্তি অর্জন করুন। এই বৈশিষ্ট্য বৃদ্ধির সাথে সাথে, অতিরিক্ত S-শক্তি ধীরে ধীরে হ্রাস পাবে।"
  },
  ActorAttrType_18139_AttributeUpText = {
    Text = "কীফ্লেয়ার পুনরুৎপাদন +{s1}"
  },
  ActorAttrType_18139_Text = {
    Text = "সিলভার কী চার্জ লেভেল"
  },
  ActorAttrType_18140_Text = {
    Text = "মৃত্যু প্রতিরোধ সংখ্যা"
  },
  ActorAttrType_18141_AttributeDesc = {
    Text = "আঘাত স্তর"
  },
  ActorAttrType_18141_AttributeUpText = {
    Text = "আঘাত স্তর+{s1}"
  },
  ActorAttrType_18141_Text = {
    Text = "আঘাত স্তর"
  },
  ActorAttrType_18142_AttributeDesc = {
    Text = "সকল জাগ্রত সত্তার 「মৌলিক ক্ষতি」, প্রয়োগকৃত 「নির্দিষ্ট মান বিষক্রিয়া」 ও 「নির্দিষ্ট মান পাল্টা আক্রমণ」 স্তর এবং গভীর সমুদ্র রিয়েলমের প্রাথমিক শুঁড় ক্ষতি শতাংশ হারে বৃদ্ধি পায়।"
  },
  ActorAttrType_18142_AttributeUpText = {
    Text = "ক্ষতি বর্ধন+{s1}"
  },
  ActorAttrType_18142_Text = {
    Text = "ক্ষতি বর্ধন"
  },
  ActorAttrType_18143_Text = {
    Text = "উন্মাদনা বিস্ফোরণ ক্ষতি শতাংশ সংশোধন"
  },
  ActorAttrType_18144_AttributeDesc = {
    Text = "জাগ্রত সত্তা সক্রিয় ক্ষতি করার সময়, ক্রিটিক্যাল প্রতিরোধের সম্ভাবনা"
  },
  ActorAttrType_18144_AttributeUpText = {
    Text = "ক্রিটিক্যাল প্রতিরোধ+{s1}"
  },
  ActorAttrType_18144_Text = {
    Text = "ক্রিটিক্যাল প্রতিরোধ"
  },
  ActorAttrType_18145_AttributeDesc = {
    Text = "উৎস আবির্ভাব স্তর"
  },
  ActorAttrType_18145_AttributeUpText = {
    Text = "উৎস আবির্ভাব স্তর+{s1}"
  },
  ActorAttrType_18145_Text = {
    Text = "উৎস আবির্ভাব স্তর"
  },
  ActorAttrType_18146_Text = {
    Text = "প্রাপ্ত নিরাময় নির্দিষ্ট মান সংশোধন"
  },
  ActorAttrType_18147_AttributeUpText = {
    Text = "ভাগ্যবান অরিসন হার +{s1}"
  },
  ActorAttrType_18147_Text = {
    Text = "সৌভাগ্য মুদ্রাঙ্কন হার"
  },
  ActorAttrType_18148_Text = {
    Text = "নিরাময় প্রদানের নির্দিষ্ট মান সংশোধন"
  },
  ActorAttrType_18149_Text = {
    Text = "শারীরিক গঠন বৃদ্ধি"
  },
  ActorAttrType_18150_Text = {
    Text = "দুর্বলতা শতাংশ সংশোধন"
  },
  ActorAttrType_18151_AttributeDesc = {
    Text = "দলের মৃত্যু প্রতিরোধ দলের সকল জাগ্রত সত্তার মৃত্যু প্রতিরোধের সমষ্টির সমান।\nযুদ্ধে মারাত্মক ক্ষতি গ্রহণ করলে, একটি নির্দিষ্ট সম্ভাবনায় 1 পয়েন্ট জীবনী ধরে রাখা যায়। সক্রিয় হওয়ার পর পরবর্তী টার্নে অতিরিক্ত 2 পয়েন্ট কম্পিউটিং পাওয়ার এবং 2টি কার্ড ড্র করা যায়। বর্তমান ও পরবর্তী সকল মৃত্যু প্রতিরোধ অর্ধেক হয়ে যায়, তদন্ত শেষ হওয়া পর্যন্ত স্থায়ী।"
  },
  ActorAttrType_18151_AttributeUpText = {
    Text = "মৃত্যু প্রতিরোধ+{s1}"
  },
  ActorAttrType_18151_Text = {
    Text = "মৃত্যু প্রতিরোধ"
  },
  ActorAttrType_18152_Text = {
    Text = "উন্মাদনা প্রদানের শতাংশ সংশোধন"
  },
  ActorAttrType_18154_Text = {
    Text = "শুঁড় সীমা"
  },
  ActorAttrType_18155_AttributeDesc = {
    Text = "যুদ্ধে জয়ের পর শত্রুর ড্রপ করা কালো সীল শতাংশ হারে বৃদ্ধি পায়।"
  },
  ActorAttrType_18155_AttributeUpText = {
    Text = "কালো সীল ড্রপ+{s1}"
  },
  ActorAttrType_18155_Text = {
    Text = "কালো সীল ড্রপ"
  },
  ActorAttrType_18156_Text = {
    Text = "প্রাপ্ত উন্মাদনা নির্দিষ্ট মান সংশোধন"
  },
  ActorAttrType_18157_Text = {
    Text = "গোপন অভিপ্রায়"
  },
  ActorAttrType_18158_Text = {
    Text = "ক্ষতি প্রদানের নির্দিষ্ট মান সংশোধন"
  },
  ActorAttrType_18159_AttributeUpText = {
    Text = "ক্রিটিক্যাল হার+{s1}"
  },
  ActorAttrType_18159_Text = {
    Text = "ক্রিটিক্যাল হার"
  },
  ActorAttrType_18160_AttributeDesc = {
    Text = "স্কিল 1 স্তর"
  },
  ActorAttrType_18160_AttributeUpText = {
    Text = "দক্ষতা 1 স্তর +{s1}"
  },
  ActorAttrType_18160_Text = {
    Text = "স্কিল 1 স্তর"
  },
  ActorAttrType_18161_Text = {
    Text = "রক্ষক অভিজ্ঞতা"
  },
  ActorAttrType_18162_Text = {
    Text = "ক্ষতি বৃদ্ধি"
  },
  ActorAttrType_18163_Text = {
    Text = "শুঁড়ের সংখ্যা"
  },
  ActorAttrType_18164_Text = {
    Text = "প্রাপ্ত নিরাময় শতাংশ সংশোধন"
  },
  ActorAttrType_18165_Text = {
    Text = "সর্বোচ্চ গণনা শক্তি"
  },
  ActorAttrType_18166_Text = {
    Text = "ক্ষতি বৃদ্ধি শতাংশ সংশোধন"
  },
  ActorAttrType_18167_AttributeUpText = {
    Text = "প্রতিরক্ষা+{s1}"
  },
  ActorAttrType_18167_Text = {
    Text = "প্রতিরক্ষা"
  },
  ActorAttrType_18168_AttributeDesc = {
    Text = "নোসিস জাগরণ স্তর"
  },
  ActorAttrType_18168_AttributeUpText = {
    Text = "জাগরণ স্তর +{s1}"
  },
  ActorAttrType_18168_Text = {
    Text = "নোসিস জাগরণ স্তর"
  },
  ActorAttrType_21322_Text = {
    Text = "সিলভার কী চার্জ"
  },
  ActorAttrType_22207_AttributeDesc = {
    Text = "প্রতিবার উন্মাদনা বিস্ফোরণ ব্যবহারের পর {s1} পয়েন্ট উন্মাদনা অর্জন করুন। এই বৈশিষ্ট্য বাড়ার সাথে সাথে অতিরিক্ত বোনাস প্রভাব ক্রমশ হ্রাস পাবে।"
  },
  ActorAttrType_22207_AttributeUpText = {
    Text = "উন্মাদনা পুনর্ভরণ লেভেল+{s1}"
  },
  ActorAttrType_22207_Text = {
    Text = "উন্মাদনা পুনর্ভরণ লেভেল"
  },
  ActorAttrType_22214_Text = {
    Text = "উন্মাদনা পুনর্ভরণ"
  }
})
return Text_ActorAttrType
