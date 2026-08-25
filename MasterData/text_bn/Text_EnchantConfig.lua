__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_EnchantConfig = readonly({
  EnchantConfig_119927_Desc = {
    Text = "আরও [Arg1] বার প্রভাব ফেলে। <DepleteIconKeywords:ক্ষয়>. <RippleKeywords:অনুকম্পন>: ২টি কার্ড ড্র করো।"
  },
  EnchantConfig_119927_Name = {
    Text = "<BlueQuality:অতল প্রতিধ্বনি>"
  },
  EnchantConfig_18169_Desc = {
    Text = "খেললে, [Arg1] অ্যারিথমেটিকা পুনরুদ্ধার করুন।"
  },
  EnchantConfig_18169_Name = {
    Text = "<WhiteQuality:গণনা>"
  },
  EnchantConfig_18170_Desc = {
    Text = "খেলার পর [Arg1] স্তর <RetaliateIconKeywords:পাল্টা আঘাত> অর্জন করুন, সকল শত্রুর উপর [Arg2]% <RetaliateIconKeywords:পাল্টা আঘাত> ট্রিগার করুন।"
  },
  EnchantConfig_18170_Name = {
    Text = "<OrangeQuality:উন্নত কণ্টক>"
  },
  EnchantConfig_18171_Desc = {
    Text = "খোদাই করা কার্ডটির মধ্যে <DepleteIconKeywords:ক্ষয়> এবং <GuyouKeywords:সহজাত> আছে। খেলা হলে, এটি অতিরিক্ত [Arg1] বার প্রভাব ফেলে, এবং তুমি [Arg2]টি কালো চিহ্ন লাভ করো।"
  },
  EnchantConfig_18171_Name = {
    Text = "<OrangeQuality:উন্নত প্রতিধ্বনি>"
  },
  EnchantConfig_18172_Desc = {
    Text = "খেলার পরে সমস্ত শত্রু [Arg1] পয়েন্ট অস্থায়ী<PowerIconKeywords:শক্তি> হারায়।"
  },
  EnchantConfig_18172_Name = {
    Text = "<WhiteQuality:ক্ষয়>"
  },
  EnchantConfig_18173_Desc = {
    Text = "খেলার পর <EmbryoFusionIconKeywords:ভ্রূণ সংমিশ্রণ>  +[Arg1]।"
  },
  EnchantConfig_18173_Name = {
    Text = "<OrangeQuality:উন্নত রক্ততৃষ্ণা>"
  },
  EnchantConfig_18174_Desc = {
    Text = "খেলা হলে, সব শত্রুর ওপর [Arg1] টার্নের জন্য <VulnerabilityIconKeywords:দুর্বল> আরোপ করো।"
  },
  EnchantConfig_18174_Name = {
    Text = "<OrangeQuality:উন্নত দুর্বল>"
  },
  EnchantConfig_18175_Desc = {
    Text = "খেললে, [Arg1]টি শুঁড় আক্রমণ সক্রিয় করুন।"
  },
  EnchantConfig_18175_Name = {
    Text = "<OrangeQuality:উন্নত আধিপত্য>"
  },
  EnchantConfig_18176_Desc = {
    Text = "খেললে, [Arg1]টি শুঁড় আক্রমণ সক্রিয় করুন।"
  },
  EnchantConfig_18176_Name = {
    Text = "<WhiteQuality:আধিপত্য>"
  },
  EnchantConfig_18177_Desc = {
    Text = "[Arg1]টি কার্ড তুলুন।"
  },
  EnchantConfig_18177_Name = {
    Text = "<OrangeQuality:উন্নত নৈপুণ্য>"
  },
  EnchantConfig_18178_Desc = {
    Text = "প্রতিটি যুদ্ধের শুরুতে, ড্র পাইল-এ খোদাই করা কার্ডটির [Arg1]টি সাধারণ কপি শাফল করো। খোদাই করা কার্ড এবং তার তৈরি কপিগুলোর উভয়ের মধ্যেই <RetainIconKeywords:ধরে রাখো> থাকে।"
  },
  EnchantConfig_18178_Name = {
    Text = "<OrangeQuality:উন্নত প্রতিবিম্ব>"
  },
  EnchantConfig_18179_Desc = {
    Text = "খেলা হলে, এর প্রভাবসমূহ শেষ হওয়ার পর [Arg1] <PowerIconKeywords:STR> অর্জন করো।"
  },
  EnchantConfig_18179_Name = {
    Text = "<OrangeQuality:উন্নত শক্তি>"
  },
  EnchantConfig_18180_Desc = {
    Text = "খেললে, তার অওয়েকেনারের অ্যালিমাস <Energy:[Arg1]> দ্বারা বৃদ্ধি করো।"
  },
  EnchantConfig_18180_Name = {
    Text = "<OrangeQuality:উন্নত উন্মত্ততা>"
  },
  EnchantConfig_18181_Desc = {
    Text = "খেলা হলে, সব শত্রুর ওপর [Arg1] স্তর <IntoxicationIconKeywords:বিষক্রিয়া> আরোপ করো, তারপর প্রতিটি শত্রুর <IntoxicationIconKeywords:বিষক্রিয়া>-এর [Arg2]% ট্রিগার করো।"
  },
  EnchantConfig_18181_Name = {
    Text = "<OrangeQuality:উন্নত বিষ>"
  },
  EnchantConfig_18182_Desc = {
    Text = "খেলার পরে [Arg1] টি <DerivativeCardKeywords_4:「অনুপ্রেরণা」> ড্র পাইলে শাফল করো। 「অনুপ্রেরণা-1 অ্যারিথমেটিকা অর্জন করো। 1 টি কার্ড ড্র করো, <RetainIconKeywords:ধরে রাখো>, <DepleteIconKeywords:ব্যবহার করো>।」"
  },
  EnchantConfig_18182_Name = {
    Text = "<WhiteQuality:অন্তর্দৃষ্টি>"
  },
  EnchantConfig_18183_Desc = {
    Text = "খেলা হলে, সব শত্রুর ওপর [Arg1] টার্নের জন্য <VulnerabilityIconKeywords:দুর্বল> আরোপ করো।"
  },
  EnchantConfig_18183_Name = {
    Text = "<WhiteQuality:দুর্বল>"
  },
  EnchantConfig_18184_Desc = {
    Text = "খেললে, <Block:[Arg1]> চরিত্রের ঢাল অর্জন করুন।"
  },
  EnchantConfig_18184_Name = {
    Text = "<OrangeQuality:উন্নত দুর্গপ্রাচীর>"
  },
  EnchantConfig_18185_Desc = {
    Text = "খেলা হলে, সব শত্রুর ওপর [Arg1] স্তর <IntoxicationIconKeywords:বিষক্রিয়া> আরোপ করো, তারপর প্রতিটি শত্রুর <IntoxicationIconKeywords:বিষক্রিয়া>-এর [Arg2]% ট্রিগার করো।"
  },
  EnchantConfig_18185_Name = {
    Text = "<WhiteQuality:বিষ>"
  },
  EnchantConfig_18186_Desc = {
    Text = "প্রতিটি যুদ্ধের শুরুতে, ড্র পাইল-এ খোদাই করা কার্ডটির [Arg1]টি সাধারণ কপি শাফল করো। খোদাই করা কার্ড এবং তার তৈরি কপিগুলোর উভয়ের মধ্যেই <RetainIconKeywords:ধরে রাখো> থাকে।"
  },
  EnchantConfig_18186_Name = {
    Text = "<WhiteQuality:প্রতিবিম্ব>"
  },
  EnchantConfig_18187_Desc = {
    Text = "খেলা হলে, প্রথমে [Arg1] অস্থায়ী <PowerIconKeywords:STR> অর্জন করো, তারপর কার্ডটির প্রভাবসমূহ কার্যকর করো।"
  },
  EnchantConfig_18187_Name = {
    Text = "<OrangeQuality:উন্নত বিস্ফোরণ>"
  },
  EnchantConfig_18188_Desc = {
    Text = "[Arg1]টি কার্ড তুলুন।"
  },
  EnchantConfig_18188_Name = {
    Text = "<WhiteQuality:নৈপুণ্য>"
  },
  EnchantConfig_18189_Desc = {
    Text = "খেলার পরে [Arg1] টি <DerivativeCardKeywords_4:「অনুপ্রেরণা」> ড্র পাইলে শাফল করো। 「অনুপ্রেরণা-1 অ্যারিথমেটিকা অর্জন করো। 1 টি কার্ড ড্র করো, <RetainIconKeywords:ধরে রাখো>, <DepleteIconKeywords:ব্যবহার করো>।」"
  },
  EnchantConfig_18189_Name = {
    Text = "<OrangeQuality:উন্নত অন্তর্দৃষ্টি>"
  },
  EnchantConfig_18190_Desc = {
    Text = "খেলা হলে, সব শত্রুর ওপর [Arg1] টার্নের জন্য <WeaknessIconKeywords:দুর্বলতা> আরোপ করো।"
  },
  EnchantConfig_18190_Name = {
    Text = "<OrangeQuality:উন্নত দুর্বলতা>"
  },
  EnchantConfig_18191_Desc = {
    Text = "খেলার পর <EmbryoFusionIconKeywords:ভ্রূণ সংমিশ্রণ>  +[Arg1]।"
  },
  EnchantConfig_18191_Name = {
    Text = "<WhiteQuality:রক্তপিপাসা>"
  },
  EnchantConfig_18192_Desc = {
    Text = "খেলা হলে, সব শত্রুর ওপর [Arg1] টার্নের জন্য <WeaknessIconKeywords:দুর্বলতা> আরোপ করো।"
  },
  EnchantConfig_18192_Name = {
    Text = "<WhiteQuality:দুর্বলতা>"
  },
  EnchantConfig_18193_Desc = {
    Text = "খেলার পরে সমস্ত শত্রু [Arg1] পয়েন্ট অস্থায়ী<PowerIconKeywords:শক্তি> হারায়।"
  },
  EnchantConfig_18193_Name = {
    Text = "<OrangeQuality:উন্নত ক্ষয়>"
  },
  EnchantConfig_18194_Desc = {
    Text = "খেলা হলে, এর [Arg1]টি কপি অস্থায়ী <DimensionalSpaceIconKeywords:আল্ট্রা স্পেস> স্লটগুলোতে যোগ করো।"
  },
  EnchantConfig_18194_Name = {
    Text = "<OrangeQuality:উন্নত তরঙ্গলম্ফ>"
  },
  EnchantConfig_18195_Desc = {
    Text = "খেলা হলে, এর প্রভাবসমূহ শেষ হওয়ার পর [Arg1] <PowerIconKeywords:STR> অর্জন করো।"
  },
  EnchantConfig_18195_Name = {
    Text = "<WhiteQuality:শক্তি>"
  },
  EnchantConfig_18196_Desc = {
    Text = "খেললে, <Block:[Arg1]> চরিত্রের ঢাল অর্জন করুন।"
  },
  EnchantConfig_18196_Name = {
    Text = "<WhiteQuality:ব্যাস্টিয়ন>"
  },
  EnchantConfig_18197_Desc = {
    Text = "খেললে, [Arg1] অ্যারিথমেটিকা পুনরুদ্ধার করুন।"
  },
  EnchantConfig_18197_Name = {
    Text = "<OrangeQuality:উন্নত গণনা>"
  },
  EnchantConfig_18198_Desc = {
    Text = "খেলা হলে, অন্য সব জাগরণকারীর অ্যালিমাস <Energy:[Arg1]> দ্বারা বৃদ্ধি করো।"
  },
  EnchantConfig_18198_Name = {
    Text = "<OrangeQuality:উন্নত অনুঘটন>"
  },
  EnchantConfig_18199_Desc = {
    Text = "খেলার পর [Arg1] স্তর <RetaliateIconKeywords:পাল্টা আঘাত> অর্জন করুন, সকল শত্রুর উপর [Arg2]% <RetaliateIconKeywords:পাল্টা আঘাত> ট্রিগার করুন।"
  },
  EnchantConfig_18199_Name = {
    Text = "<WhiteQuality:কণ্টক>"
  },
  EnchantConfig_18200_Desc = {
    Text = "খোদাই করা কার্ডটির মধ্যে <DepleteIconKeywords:ক্ষয়> এবং <GuyouKeywords:সহজাত> আছে। খেলা হলে, এটি অতিরিক্ত [Arg1] বার প্রভাব ফেলে, এবং তুমি [Arg2]টি কালো চিহ্ন লাভ করো।"
  },
  EnchantConfig_18200_Name = {
    Text = "<WhiteQuality:প্রতিধ্বনি>"
  },
  EnchantConfig_18201_Desc = {
    Text = "খেললে, তার অওয়েকেনারের অ্যালিমাস <Energy:[Arg1]> দ্বারা বৃদ্ধি করো।"
  },
  EnchantConfig_18201_Name = {
    Text = "<WhiteQuality:বার্সার্ক>"
  },
  EnchantConfig_18202_Desc = {
    Text = "খেলা হলে, প্রথমে [Arg1] অস্থায়ী <PowerIconKeywords:STR> অর্জন করো, তারপর কার্ডটির প্রভাবসমূহ কার্যকর করো।"
  },
  EnchantConfig_18202_Name = {
    Text = "<WhiteQuality:বিস্ফোরণ>"
  },
  EnchantConfig_18203_Desc = {
    Text = "খেলা হলে, অন্য সব জাগরণকারীর অ্যালিমাস <Energy:[Arg1]> দ্বারা বৃদ্ধি করো।"
  },
  EnchantConfig_18203_Name = {
    Text = "<WhiteQuality:অনুঘটক>"
  },
  EnchantConfig_18204_Desc = {
    Text = "খেলা হলে, এর [Arg1]টি কপি অস্থায়ী <DimensionalSpaceIconKeywords:আল্ট্রা স্পেস> স্লটগুলোতে যোগ করো।"
  },
  EnchantConfig_18204_Name = {
    Text = "<WhiteQuality:তরঙ্গলম্ফ>"
  },
  EnchantConfig_48006_Desc = {
    Text = "প্রতি টার্নে প্রথমবার খেলা হলে 2 বার ট্রিগার হয়।"
  },
  EnchantConfig_48006_Name = {
    Text = "<WhiteQuality:সমবেত সুর>"
  },
  EnchantConfig_48007_Desc = {
    Text = "প্রতিটি পালার প্রথম আঘাত ৩ বার কার্যকর হয়।"
  },
  EnchantConfig_48007_Name = {
    Text = "<WhiteQuality:উন্নত যুগলবন্দি>"
  },
  EnchantConfig_49108_Desc = {
    Text = "কার্ড প্রাপ্তি <RetainIconKeywords:ধরে রাখো>, টার্নের শেষে হাতে থাকলে, <RetainIconKeywords:ধরে রাখো> ও <DepleteIconKeywords:ক্ষয়> সহ একটি মূল প্রতিলিপি প্রাপ্ত হও।"
  },
  EnchantConfig_49108_Name = {
    Text = "<WhiteQuality:জন্ম>"
  },
  EnchantConfig_59530_Desc = {
    Text = "ব্যবহারের সময়, হাতে থাকা এই জাগরণকারীর অন্তর্গত নয় এমন সব কার্ড বাতিল করো। 5টি নন-কমান্ড কার্ড লাভ করো। প্রতি যুদ্ধের জন্য একবার কার্যকর।"
  },
  EnchantConfig_59530_Name = {
    Text = "<OrangeQuality:লেক্স ভোলিস>"
  },
  EnchantConfig_59531_Desc = {
    Text = "খেললে 2টি কার্ড ড্র করো; তাদের অ্যারিথমেটিকা ব্যয় অরিসন কার্ডগুলোর প্রকৃত ব্যয় কমিয়ে দেয়, এবং এটি প্রতি যুদ্ধে মাত্র একবার কার্যকর।"
  },
  EnchantConfig_59531_Name = {
    Text = "<OrangeQuality:লেক্স নউস>"
  },
  EnchantConfig_59532_Desc = {
    Text = "খেলার পর, <RetainIconKeywords:ধরে রাখো> এবং <DepleteIconKeywords:ক্ষয়> যুক্ত 3টি বেস কপি লাভ করো। প্রতি যুদ্ধের জন্য একবার কার্যকর।"
  },
  EnchantConfig_59532_Name = {
    Text = "<OrangeQuality:লেক্স জেনিস>"
  },
  EnchantConfig_67415_Desc = {
    Text = "ব্যবহারের সময়, হাতে থাকা এই জাগরণকারীর অন্তর্গত নয় এমন সব কার্ড বাতিল করো। 5টি নন-কমান্ড কার্ড লাভ করো। প্রতি যুদ্ধের জন্য একবার কার্যকর।"
  },
  EnchantConfig_67415_Name = {
    Text = "<RedQuality:উন্নত লেক্স ভোলিস>"
  },
  EnchantConfig_67416_Desc = {
    Text = "খেললে 4টি কার্ড ড্র করো; তাদের অ্যারিথমেটিকা ব্যয় এই কার্ডের ব্যয়ের সমান পরিমাণ কমে যাবে, যা প্রতি যুদ্ধে মাত্র একবার কার্যকর।"
  },
  EnchantConfig_67416_Name = {
    Text = "<RedQuality:উন্নত লেক্স নউস>"
  },
  EnchantConfig_67417_Desc = {
    Text = "খেললে 3টি অ্যারিথমেটিকা ব্যয় -1 অর্জন করো এবং <RetainIconKeywords:Retain> ও <DepleteIconKeywords:ক্ষয়> কে বেস কপি হিসেবে সংযুক্ত করো; প্রতি যুদ্ধে মাত্র একবার কার্যকর।"
  },
  EnchantConfig_67417_Name = {
    Text = "<RedQuality:উন্নত লেক্স জেনিস>"
  }
})
return Text_EnchantConfig
