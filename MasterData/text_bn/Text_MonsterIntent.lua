__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MonsterIntent = readonly({
  ["MonsterIntent_怪物意图不明_Name"] = {
    Text = "অজ্ঞাত"
  },
  ["MonsterIntent_怪物意图不明_TipId"] = {
    Text = "শত্রুর অভিপ্রায় অনুধাবন করা যাচ্ছে না।"
  },
  ["MonsterIntent_怪物意图不明呢喃1_Name"] = {
    Text = "অজ্ঞাত"
  },
  ["MonsterIntent_怪物意图不明呢喃1_TipId"] = {
    Text = "শত্রুর অভিপ্রায় অনুধাবন করা যাচ্ছে না।"
  },
  ["MonsterIntent_怪物意图不明呢喃2_Name"] = {
    Text = "অজ্ঞাত"
  },
  ["MonsterIntent_怪物意图不明呢喃2_TipId"] = {
    Text = "শত্রুর অভিপ্রায় অনুধাবন করা যাচ্ছে না।"
  },
  ["MonsterIntent_怪物意图不明呢喃3_Name"] = {
    Text = "অজ্ঞাত"
  },
  ["MonsterIntent_怪物意图不明呢喃3_TipId"] = {
    Text = "শত্রুর অভিপ্রায় অনুধাবন করা যাচ্ছে না।"
  },
  ["MonsterIntent_怪物意图不明呢喃4_Name"] = {
    Text = "অজ্ঞাত"
  },
  ["MonsterIntent_怪物意图不明呢喃4_TipId"] = {
    Text = "শত্রুর অভিপ্রায় অনুধাবন করা যাচ্ছে না।"
  },
  ["MonsterIntent_怪物意图不明呢喃5_Name"] = {
    Text = "অজ্ঞাত"
  },
  ["MonsterIntent_怪物意图不明呢喃5_TipId"] = {
    Text = "শত্রুর অভিপ্রায় অনুধাবন করা যাচ্ছে না।"
  },
  ["MonsterIntent_怪物意图不明呢喃6_Name"] = {
    Text = "অজ্ঞাত"
  },
  ["MonsterIntent_怪物意图不明呢喃6_TipId"] = {
    Text = "শত্রুর অভিপ্রায় অনুধাবন করা যাচ্ছে না।"
  },
  ["MonsterIntent_怪物意图人面犬重攻击_Name"] = {
    Text = "স্ট্রাইক"
  },
  ["MonsterIntent_怪物意图人面犬重攻击_TipId"] = {
    Text = "মিত্রদের {s1} ডিএমজি দেয়।"
  },
  ["MonsterIntent_怪物意图削弱_Name"] = {
    Text = "দুর্বল করো"
  },
  ["MonsterIntent_怪物意图削弱_TipId"] = {
    Text = "তোমার দলে নেতিবাচক প্রভাব প্রয়োগ করবে।"
  },
  ["MonsterIntent_怪物意图强力削弱_Name"] = {
    Text = "দুর্বল করো"
  },
  ["MonsterIntent_怪物意图强力削弱_TipId"] = {
    Text = "তোমার দলে একটি শক্তিশালী নেতিবাচক প্রভাব প্রয়োগ করবে।"
  },
  ["MonsterIntent_怪物意图强力强化_Name"] = {
    Text = "উন্নত করুন"
  },
  ["MonsterIntent_怪物意图强力强化_TipId"] = {
    Text = "শত্রু নিজেকে শক্তিশালী করবে।"
  },
  ["MonsterIntent_怪物意图强化DCB02_2_Name"] = {
    Text = "উন্নত করুন"
  },
  ["MonsterIntent_怪物意图强化DCB02_2_TipId"] = {
    Text = "শত্রু নিজেকে শক্তিশালী করবে।"
  },
  ["MonsterIntent_怪物意图强化DCB02_4_Name"] = {
    Text = "উন্নত করুন"
  },
  ["MonsterIntent_怪物意图强化DCB02_4_TipId"] = {
    Text = "শত্রু নিজেকে শক্তিশালী করবে।"
  },
  ["MonsterIntent_怪物意图强化_Name"] = {
    Text = "উন্নত করুন"
  },
  ["MonsterIntent_怪物意图强化_TipId"] = {
    Text = "শত্রু নিজেকে শক্তিশালী করবে।"
  },
  ["MonsterIntent_怪物意图攻击_Name"] = {
    Text = "স্ট্রাইক"
  },
  ["MonsterIntent_怪物意图攻击_TipId"] = {
    Text = "মিত্রদের {s1} ডিএমজি দেয়।"
  },
  ["MonsterIntent_怪物意图攻击和削弱_Name"] = {
    Text = "স্ট্রাইক&দুর্বলতা"
  },
  ["MonsterIntent_怪物意图攻击和削弱_TipId"] = {
    Text = "তোমার দলে {s1} মাত্রার Damage প্রয়োগ করবে এবং নেতিবাচক প্রভাব আরোপ করবে।"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_Name"] = {
    Text = "স্ট্রাইক&দুর্বলতা"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_TipId"] = {
    Text = "তোমার দলে {s1} মাত্রার Damage প্রয়োগ করবে এবং নেতিবাচক প্রভাব আরোপ করবে।"
  },
  ["MonsterIntent_怪物意图攻击和强化_Name"] = {
    Text = "স্ট্রাইক&শক্তিবৃদ্ধি"
  },
  ["MonsterIntent_怪物意图攻击和强化_TipId"] = {
    Text = "তোমার দলে {s1} ক্ষতি প্রয়োগ করবে এবং শক্তিবৃদ্ধি প্রয়োগ করবে।"
  },
  ["MonsterIntent_怪物意图攻击和防御_Name"] = {
    Text = "স্ট্রাইক&প্রতিরক্ষা"
  },
  ["MonsterIntent_怪物意图攻击和防御_TipId"] = {
    Text = "তোমার দলে {s1} ক্ষতি প্রয়োগ করবে এবং চরিত্রের ঢাল অর্জন করবে।"
  },
  ["MonsterIntent_怪物意图狂气_Name"] = {
    Text = "এক্সাল্ট"
  },
  ["MonsterIntent_怪物意图狂气_TipId"] = {
    Text = "শত্রু পরের টার্নে এক্সাল্ট মুক্ত করবে।"
  },
  ["MonsterIntent_怪物意图狂气非攻击_Name"] = {
    Text = "এক্সাল্ট"
  },
  ["MonsterIntent_怪物意图狂气非攻击_TipId"] = {
    Text = "শত্রু পরের টার্নে এক্সাল্ট মুক্ত করবে।"
  },
  ["MonsterIntent_怪物意图眩晕_Name"] = {
    Text = "স্তব্ধ"
  },
  ["MonsterIntent_怪物意图眩晕_TipId"] = {
    Text = "স্তব্ধ এবং কার্যকর হতে অক্ষম।"
  },
  ["MonsterIntent_怪物意图超级狂气_Name"] = {
    Text = "এক্সাল্ট"
  },
  ["MonsterIntent_怪物意图超级狂气_TipId"] = {
    Text = "শত্রু পরের টার্নে এক্সাল্ট মুক্ত করবে।"
  },
  ["MonsterIntent_怪物意图释放终结_Name"] = {
    Text = "এক্সাল্ট"
  },
  ["MonsterIntent_怪物意图释放终结_TipId"] = {
    Text = "শত্রু পরের টার্নে তোমাকে বিলুপ্ত করে দেবে।"
  },
  ["MonsterIntent_怪物意图重攻击_Name"] = {
    Text = "স্ট্রাইক"
  },
  ["MonsterIntent_怪物意图重攻击_TipId"] = {
    Text = "মিত্রদের {s1} ডিএমজি দেয়।"
  },
  ["MonsterIntent_怪物意图防御_Name"] = {
    Text = "প্রতিরক্ষা"
  },
  ["MonsterIntent_怪物意图防御_TipId"] = {
    Text = "শত্রু চরিত্রের ঢাল অর্জন করবে।"
  },
  ["MonsterIntent_怪物意图防御和削弱_Name"] = {
    Text = "প্রতিরক্ষা&দুর্বলতা"
  },
  ["MonsterIntent_怪物意图防御和削弱_TipId"] = {
    Text = "চরিত্রের ঢাল পাবে এবং তোমার দলে ডিবাফ আরোপ করবে।"
  },
  ["MonsterIntent_怪物意图防御和强化_Name"] = {
    Text = "প্রতিরক্ষা&শক্তিবৃদ্ধি"
  },
  ["MonsterIntent_怪物意图防御和强化_TipId"] = {
    Text = "চরিত্রের ঢাল ও শক্তিবৃদ্ধি অর্জন করবে।"
  }
})
return Text_MonsterIntent
