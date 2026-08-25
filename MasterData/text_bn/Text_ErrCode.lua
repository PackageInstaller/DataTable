__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ErrCode = readonly({
  ErrCode_CMD_UNDEFINED_Desc = {
    Text = "কমান্ড বিদ্যমান নেই"
  },
  ErrCode_ERR_ACTIVITY_FINISH_Desc = {
    Text = "ইভেন্টটি সমাপ্ত হয়েছে।"
  },
  ErrCode_ERR_ACTIVITY_LOGINDAILY_Desc = {
    Text = "লগইন দিনের সংখ্যা অপর্যাপ্ত, পুরস্কার গ্রহণ করা সম্ভব নয়"
  },
  ErrCode_ERR_ACTIVITY_NOT_CONDITION_Desc = {
    Text = "ইভেন্টে অংশগ্রহণের শর্ত পূরণ হয়নি"
  },
  ErrCode_ERR_ACTIVITY_NOT_FIND_Desc = {
    Text = "এই ইভেন্ট বিদ্যমান নয়"
  },
  ErrCode_ERR_ACTIVITY_NOT_HANDLE_CLASS_Desc = {
    Text = "এই ইভেন্টটি এখনো উন্নয়নাধীন"
  },
  ErrCode_ERR_ACTIVITY_NOT_OPEN_Desc = {
    Text = "এই ইভেন্টটি এখনও শুরু হয়নি"
  },
  ErrCode_ERR_ACTIVITY_TASK_NOT_FINISH_Desc = {
    Text = "ইভেন্ট মিশন সম্পন্ন হয়নি"
  },
  ErrCode_ERR_ACTIVITY_TRIALSTAGE_FAIL_Desc = {
    Text = "ডেমো ইভেন্ট: অসম্পূর্ণ স্টেজের জন্য পুরস্কার গ্রহণ করা যাবে না"
  },
  ErrCode_ERR_ACTIVITY_TRIAL_NOT_STAGE_Desc = {
    Text = "পরীক্ষামূলক ইভেন্ট: এই স্তরটি পাওয়া যায়নি"
  },
  ErrCode_ERR_ASSISTED_ONCE_Desc = {
    Text = "এই রক্ষক ইতিমধ্যেই এই ইভেন্টে একবার সহায়তা প্রদান করেছে"
  },
  ErrCode_ERR_ASSIST_NEED_FOLLOW_EACHOTHER_Desc = {
    Text = "এই ইভেন্টে যুদ্ধ সহায়তার জন্য পরস্পরকে অনুসরণ করা রক্ষকদের প্রয়োজন"
  },
  ErrCode_ERR_ASSIST_STAR_LIMIT_Desc = {
    Text = "\"তুমি অতিরিক্ত প্রিয় সহায়ক যোগ করেছ। অনুগ্রহ করে তালিকাটি সামঞ্জস্য করো।\""
  },
  ErrCode_ERR_AWAKER_NOT_ARRIVED_LEVEL_Desc = {
    Text = "দক্ষতা উন্নয়ন অর্জনের শর্ত পূরণ হয়নি"
  },
  ErrCode_ERR_AWAKER_NOT_BREAKLEVEL_Desc = {
    Text = "জাগ্রতের এডিফাই স্তর অপর্যাপ্ত"
  },
  ErrCode_ERR_AWAKER_START_DROP_DATE_Desc = {
    Text = "জাগরণকারী এখনো সংগ্রহযোগ্য নয়"
  },
  ErrCode_ERR_AWAKER_USED_Desc = {
    Text = "এই জাগরণকারী ইতিমধ্যে ব্যবহৃত হয়েছে"
  },
  ErrCode_ERR_AlREADY_BAN_Desc = {
    Text = "আবার ব্লক করা যাবে না"
  },
  ErrCode_ERR_BANNED_Desc = {
    Text = "তুমি এই প্লেয়ারের ব্ল্যাকলিস্টে আছো, কোনো অপারেশন করতে পারবে না"
  },
  ErrCode_ERR_BANNED_FOLLOW_LIKE_Desc = {
    Text = "এই ব্যবহারকারী তোমাকে ব্ল্যাকলিস্ট করেছে, তুমি তাকে Follow them বা লাইক করতে পারবে না"
  },
  ErrCode_ERR_BAN_FOLLOW_LIKE_Desc = {
    Text = "তুমি এই ব্যবহারকারীকে ব্ল্যাকলিস্ট করেছ, তাকে লাইক বা Follow them করতে পারবে না"
  },
  ErrCode_ERR_BAN_NUM_LIMIT_Desc = {
    Text = "ব্ল্যাকলিস্টের সীমা পূর্ণ হয়েছে"
  },
  ErrCode_ERR_BATTLE_CREATE_FAILED_Desc = {
    Text = "যুদ্ধ তৈরি ব্যর্থ হয়েছে"
  },
  ErrCode_ERR_BP_BUYLEVEL_NOT_ENOUGH_Desc = {
    Text = "পাস স্তর ক্রয়ের জন্য পর্যাপ্ত মুদ্রা নেই"
  },
  ErrCode_ERR_BP_FAIL_Desc = {
    Text = "অভিযান ব্যর্থ হয়েছে"
  },
  ErrCode_ERR_BP_NOT_CONFIG_PRIZE_Desc = {
    Text = "পাস ক্রয়-অধিকারের মূল্য কনফিগার করা হয়নি"
  },
  ErrCode_ERR_BP_PRIVILEGELEVEL_MAX_Desc = {
    Text = "পাসের প্রিভিলেজ স্তর সর্বোচ্চ সীমায় পৌঁছেছে, পুনরায় ক্রয় করা সম্ভব নয়"
  },
  ErrCode_ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH_Desc = {
    Text = "পুরস্কার গ্রহণের জন্য পর্যাপ্ত অধিকার স্তর নেই"
  },
  ErrCode_ERR_BP_REWARD_NOT_EXISTS_Desc = {
    Text = "পুরস্কার বিদ্যমান নয়"
  },
  ErrCode_ERR_BP_REWARD_RECEIVED_Desc = {
    Text = "পুরস্কার সংগৃহীত"
  },
  ErrCode_ERR_BUY_TICKET_NO_MONEY_Desc = {
    Text = "পর্যাপ্ত সিলভার প্রাইম নেই"
  },
  ErrCode_ERR_BUY_TICKET_NO_TIMES_Desc = {
    Text = "ভাউচার কেনার প্রচেষ্টা অপর্যাপ্ত"
  },
  ErrCode_ERR_CANT_ENCHANCE_RELIC_Desc = {
    Text = "রেলিক উন্নয়ন সমর্থন করে না"
  },
  ErrCode_ERR_CARD_MAX_LEVEL_Desc = {
    Text = "এই কার্ড সর্বোচ্চ স্তরে পৌঁছেছে এবং শক্তিবৃদ্ধি করা সম্ভব নয়"
  },
  ErrCode_ERR_CARD_NOT_UPDRADE_Desc = {
    Text = "এই কার্ডটির শক্তিবৃদ্ধি করা যাবে না"
  },
  ErrCode_ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD_Desc = {
    Text = "তোমার মন্তব্যে ব্লক করা শব্দ রয়েছে।"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_COMMENT_Desc = {
    Text = "তুমি ইতিমধ্যে মন্তব্য করেছ।"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_DELETE_Desc = {
    Text = "তুমি এটা আগেই মুছে ফেলেছ।"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_LIKE_Desc = {
    Text = "তুমি এটা আগেই পছন্দ করেছ।"
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_UNLIKE_Desc = {
    Text = "খুব দ্রুত আনলাইক করা হয়েছে।"
  },
  ErrCode_ERR_CARD_REVIEW_LENGTH_EXCEEDED_Desc = {
    Text = "মন্তব্যটি খুব লম্বা।"
  },
  ErrCode_ERR_CARD_REVIEW_LIKE_ALREADY_DELETED_Desc = {
    Text = "এই মন্তব্যটি মুছে ফেলা হয়েছে।"
  },
  ErrCode_ERR_CARD_REVIEW_TIMEOUT_Desc = {
    Text = "মন্তব্যের সময়সীমা শেষ। অনুগ্রহ করে আবার চেষ্টা করো।"
  },
  ErrCode_ERR_CARD_UPGRADE_NOT_NUMBER_Desc = {
    Text = "একচেটিয়া কার্ড উন্নয়ন অর্জনের আর কোনো প্রচেষ্টা অবশিষ্ট নেই"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_PLOT_Desc = {
    Text = "ইনস্ট্যান্স চ্যালেঞ্জের জন্য কোনো গল্প খুঁজে পাওয়া যায়নি"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_TASK_Desc = {
    Text = "ইনস্ট্যান্স চ্যালেঞ্জের জন্য কোনো গল্প-কোয়েস্ট খুঁজে পাওয়া যায়নি"
  },
  ErrCode_ERR_CHALLENGE_NOT_IN_STAGEGROUP_Desc = {
    Text = "মায়াবী অবগাহন আপডেট হচ্ছে। পরে আবার চেষ্টা করুন।"
  },
  ErrCode_ERR_CHALLENGE_TASK_FINISH_Desc = {
    Text = "চ্যালেঞ্জ সম্পন্ন। পুরস্কার পুনরায় গ্রহণ করা যাবে না।"
  },
  ErrCode_ERR_CHALLENGE_TASK_RUNING_Desc = {
    Text = "চ্যালেঞ্জ সম্পন্ন হয়নি। পুরস্কার সংগ্রহযোগ্য নয়।"
  },
  ErrCode_ERR_CHAPTER_PRIZE_CONDITION_Desc = {
    Text = "অধ্যায় পুরস্কার প্রয়োজনীয় পয়েন্টে পৌঁছায়নি"
  },
  ErrCode_ERR_CHAPTER_PRIZE_FINISH_Desc = {
    Text = "অধ্যায় পুরস্কার ইতিমধ্যে গ্রহণ করা হয়েছে"
  },
  ErrCode_ERR_CHOOSE_GEAR_NOT_FIND_Desc = {
    Text = "বর্তমান নোড পাওয়া যায়নি"
  },
  ErrCode_ERR_CHREATE_ROLE_Desc = {
    Text = "এই চরিত্রের নামটি ইতিমধ্যেই নেওয়া হয়েছে"
  },
  ErrCode_ERR_CLIENT_DATA_Desc = {
    Text = "ক্লায়েন্ট ডেটা ইনপুট ত্রুটি"
  },
  ErrCode_ERR_CLOSE_GEAR_NOT_FIND_Desc = {
    Text = "বর্তমান নোড পাওয়া যায়নি, বন্ধ করা সম্ভব নয়"
  },
  ErrCode_ERR_CONFIG_Desc = {
    Text = "কনফিগ ডেটা ত্রুটি"
  },
  ErrCode_ERR_COURSE_CREDIT_NOT_ENOUGH_Desc = {
    Text = "পুরস্কার গ্রহণ করা সম্ভব নয়"
  },
  ErrCode_ERR_COURSE_MODULE_NOT_FINISH_Desc = {
    Text = "পুরস্কারের শর্ত এখনো পূরণ হয়নি"
  },
  ErrCode_ERR_COURSE_NOT_BARRIES_DATA_Desc = {
    Text = "কোনো স্তরের গোপনরক্ষকের হ্যান্ডবুক ডেটা সংগ্রহযোগ্য নয়"
  },
  ErrCode_ERR_COURSE_NOT_FIND_COPIES_Desc = {
    Text = "এই ইনস্ট্যান্সের কুয়েস্টের জন্য কোনো পয়েন্ট নেই"
  },
  ErrCode_ERR_COURSE_NOT_FIND_MODULE_Desc = {
    Text = "বিষয়ের স্কোরের জন্য মডিউল পাওয়া যায়নি"
  },
  ErrCode_ERR_COURSE_NOT_FIND_TASK_Desc = {
    Text = "এ পর্যন্ত কোনো গোপনরক্ষকের হ্যান্ডবুক পাওয়া যায়নি"
  },
  ErrCode_ERR_COURSE_NOT_FIND_UNIT_Desc = {
    Text = "এই বিষয়ে কোনো ইউনিট ডেটা পাওয়া যায়নি"
  },
  ErrCode_ERR_COURSE_PRIZE_Desc = {
    Text = "ইউনিট ইতিমধ্যে জমা দেওয়া হয়েছে, পুনরায় জমা দেওয়ার প্রয়োজন নেই"
  },
  ErrCode_ERR_COURSE_TASK_CONDITION_NOT_FINISH_Desc = {
    Text = "মিশনের উপ-কর্মগুলো অসম্পূর্ণ"
  },
  ErrCode_ERR_COURSE_TASK_FINISH_Desc = {
    Text = "মিশন সম্পন্ন"
  },
  ErrCode_ERR_COURSE_UNIT_NOT_FINISH_Desc = {
    Text = "ইউনিটের অধীনে থাকা গোপনরক্ষকের হ্যান্ডবুক সম্পূর্ণভাবে সম্পন্ন হয়নি, জমা দেওয়া যাবে না"
  },
  ErrCode_ERR_CREATE_ROLE_CLOSE_Desc = {
    Text = "নতুন রক্ষকদের নিবন্ধন আপাতত স্থগিত রয়েছে"
  },
  ErrCode_ERR_CREATE_ROLE_Desc = {
    Text = "কোনো চরিত্র পাওয়া যায়নি। অনুগ্রহ করে একটি তৈরি করুন।"
  },
  ErrCode_ERR_CUSTOM_CMD_USE_LIMIT_Desc = {
    Text = "কাস্টম কমান্ড ব্যবহারের সীমা পূর্ণ হয়েছে"
  },
  ErrCode_ERR_ENCHANCE_RELIC_EXIST_Desc = {
    Text = "রেলিক উন্নত করা হয়েছে"
  },
  ErrCode_ERR_ENERGY_STORE_MAX_Desc = {
    Text = "মেনোফিন যথেষ্ট, পুনরায় ভরার প্রয়োজন নেই"
  },
  ErrCode_ERR_ENHANCE_RELIC_Desc = {
    Text = "এ সময় উৎসর্গ প্রদান করা যাবে না"
  },
  ErrCode_ERR_EQUIP_NOT_FIND_Desc = {
    Text = "অ্যাক্সেসরি বিদ্যমান নয়"
  },
  ErrCode_ERR_EVENT_AREA_NOT_MATCH_Desc = {
    Text = "ইভেন্ট এলাকার ত্রুটি"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_DATA_Desc = {
    Text = "ইভেন্টের জন্য নির্বাচিত কার্ডটি বিদ্যমান নয়"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_NUM_MAX_Desc = {
    Text = "ইভেন্টের জন্য অতিরিক্ত সংখ্যক কার্ড নির্বাচিত হয়েছে"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_DATA_Desc = {
    Text = "ইভেন্টের জন্য নির্বাচিত রেলিকটি বিদ্যমান নয়"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_NUM_MAX_Desc = {
    Text = "ইভেন্টের জন্য অতিরিক্ত সংখ্যক রেলিক নির্বাচিত হয়েছে"
  },
  ErrCode_ERR_EVENT_CONFIG_NOTYPE_Desc = {
    Text = "ইনস্ট্যান্স কনফিগারেশন টেবিলে ইভেন্ট টাইপ ভুলভাবে প্রবেশ করা হয়েছে"
  },
  ErrCode_ERR_EVENT_DATA_Desc = {
    Text = "ইভেন্ট ডেটা ত্রুটি"
  },
  ErrCode_ERR_EVENT_DROP_CARD_NO_REFRESH_NUM_Desc = {
    Text = "যুদ্ধ ড্রপ কার্ড রিফ্রেশের আর কোনো সুযোগ অবশিষ্ট নেই"
  },
  ErrCode_ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM_Desc = {
    Text = "যুদ্ধ ড্রপ রেলিক রিফ্রেশের আর কোনো সুযোগ অবশিষ্ট নেই"
  },
  ErrCode_ERR_EVENT_FINISH_Desc = {
    Text = "ইভেন্ট সম্পন্ন"
  },
  ErrCode_ERR_EVENT_NOT_FIND_Desc = {
    Text = "ইনস্ট্যান্সে এই ইভেন্টটি বিদ্যমান নয়"
  },
  ErrCode_ERR_EVENT_NOT_MONEY_ENOUGT_Desc = {
    Text = "পর্যাপ্ত সিলভার নেই। ক্রয় করা সম্ভব নয়।"
  },
  ErrCode_ERR_EVENT_NOT_NODE_Desc = {
    Text = "এই নোডে কোনো ইভেন্ট পাওয়া যায়নি"
  },
  ErrCode_ERR_EVENT_RANDOM_POND_Desc = {
    Text = "ইভেন্টের র্যান্ডম পুলে কোনো ডেটা নেই"
  },
  ErrCode_ERR_EVENT_REST_FUNCLOCK_Desc = {
    Text = "সংযোগস্থল ফাংশন লক করা"
  },
  ErrCode_ERR_EVENT_REST_FUNC_SELECT_Desc = {
    Text = "শিবির ইতিমধ্যেই একটি ফাংশন নির্বাচন করেছে, আরেকটি নির্বাচন করা সম্ভব নয়"
  },
  ErrCode_ERR_EVENT_REST_NOT_USENUM_Desc = {
    Text = "শিবির ফাংশনের আর কোনো ব্যবহার অবশিষ্ট নেই"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "ইভেন্ট শপ রিফ্রেশের আর কোনো সুযোগ অবশিষ্ট নেই"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REMOVECARD_Desc = {
    Text = "ইভেন্ট মিথাগ দোকানে কার্ড অপসারণের সব প্রচেষ্টা ইতিমধ্যেই ক্ষয় হয়েছে"
  },
  ErrCode_ERR_EVENT__CHOOSE_CARD_NUM_Desc = {
    Text = "ইভেন্টের জন্য নির্বাচিত কার্ডের সংখ্যা অপর্যাপ্ত"
  },
  ErrCode_ERR_EVENT__CHOOSE_RELIC_NUM_Desc = {
    Text = "ইভেন্টের জন্য নির্বাচিত রেলিকের সংখ্যা অপর্যাপ্ত"
  },
  ErrCode_ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND_Desc = {
    Text = "নির্দিষ্ট একচেটিয়া কার্ডের তথ্য খুঁজে পাওয়া যায়নি"
  },
  ErrCode_ERR_EXCLUSIVECARD_ROLE_NOT_FOUND_Desc = {
    Text = "উন্নয়ন অর্জনের পথের জন্য কোনো চরিত্র আইডি কনফিগার করা নেই"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_INVALID_Desc = {
    Text = "নির্ধারিত একচেটিয়া কার্ডটি আনলক করা হয়নি"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_CHANGE_Desc = {
    Text = "সুইচ করতে এক্সক্লুসিভ কার্ড পরিবর্তন করুন"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_SWITCH_Desc = {
    Text = "এক্সক্লুসিভ কার্ড পরিবর্তনে ব্যর্থ হয়েছে"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH_Desc = {
    Text = "সুইচ করতে এক্সক্লুসিভ কার্ডের উন্নয়ন অর্জন করুন"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND_Desc = {
    Text = "এই একচেটিয়া কার্ডটির জন্য UUID খুঁজে পাওয়া যাচ্ছে না"
  },
  ErrCode_ERR_EXPIRED_SUPPORTLIST_Desc = {
    Text = "সহায়ক অ্যাওয়েকনার আর বৈধ নেই। অনুগ্রহ করে সহায়তার তালিকা রিফ্রেশ করে নতুন করে একটি সহায়ক অ্যাওয়েকনার নির্বাচন করুন।"
  },
  ErrCode_ERR_FACTORY_COMPOSE_ITEM_LOCK_Desc = {
    Text = "সংশ্লেষণ আইটেম আনলক করা হয়নি"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_CURRENCY_Desc = {
    Text = "আইটেম নির্মাণের জন্য পর্যাপ্ত মুদ্রা নেই"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_ITEMS_Desc = {
    Text = "প্রয়োজনীয় আইটেম নির্মাণের জন্য পর্যাপ্ত উপাদান নেই"
  },
  ErrCode_ERR_FACTORY_EXIST_Desc = {
    Text = "ভবন ইতিমধ্যেই বিদ্যমান, পুনরায় নির্মাণ করা সম্ভব নয়"
  },
  ErrCode_ERR_FACTORY_HAVE_ACTOR_Desc = {
    Text = "এই স্থানে ইতিমধ্যেই এক জাগরণকারী অবস্থান নিয়েছে, প্রবেশ করা যাবে না"
  },
  ErrCode_ERR_FACTORY_MAX_LEVEL_Desc = {
    Text = "ভবন সর্বোচ্চ স্তরে পৌঁছেছে"
  },
  ErrCode_ERR_FACTORY_NOT_EXIST_Desc = {
    Text = "ভবনটি বিদ্যমান নয়"
  },
  ErrCode_ERR_FACTORY_UPGRADE_CONDITION_Desc = {
    Text = "ভবন উন্নয়ন অর্জন/নির্মাণের শর্ত অপর্যাপ্ত"
  },
  ErrCode_ERR_FACTORY_UPGRADE_ITEMS_Desc = {
    Text = "উন্নয়ন অর্জন/নির্মাণের জন্য পর্যাপ্ত আইটেম নেই"
  },
  ErrCode_ERR_GAIN_BATTLE_PRIZE_Desc = {
    Text = "বর্তমান নোডে কোনো পুরস্কার সংগ্রহযোগ্য নয়"
  },
  ErrCode_ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH_Desc = {
    Text = "চ্যালেঞ্জের আর কোনো প্রচেষ্টা অবশিষ্ট নেই"
  },
  ErrCode_ERR_GAMECOPY_ENERGY_NOT_ENOUGH_Desc = {
    Text = "তোমার বর্তমান HP অত্যন্ত কম, তুমি এখন দুর্বলতা অবস্থায় আছো"
  },
  ErrCode_ERR_GAMECOPY_MOPPING_LOCK_Desc = {
    Text = "অন্বেষণ স্তর ২-এ নাগাল পেলে আনলক হবে"
  },
  ErrCode_ERR_GAMECOPY_NOF_FINISH_Desc = {
    Text = "একটি অনুসন্ধান সম্পন্ন করার পর তুমি সঙ্গে সঙ্গে আবার অনুসন্ধান করতে পারবে।"
  },
  ErrCode_ERR_GAMECOPY_NOT_Desc = {
    Text = "ইনস্ট্যান্স ত্রুটি"
  },
  ErrCode_ERR_GAMECOPY_NOT_FIND_Desc = {
    Text = "কোনো ইনস্ট্যান্স পাওয়া যায়নি"
  },
  ErrCode_ERR_GEAR_BLOCK_Desc = {
    Text = "নোড লক করা"
  },
  ErrCode_ERR_GEAR_FINISH_Desc = {
    Text = "নোড সম্পন্ন হয়েছে"
  },
  ErrCode_ERR_GEAR_NOT_FINISH_Desc = {
    Text = "নোড সম্পন্ন হয়নি"
  },
  ErrCode_ERR_GEAR_NOT_NEIGHBORING_Desc = {
    Text = "নোডগুলো পরস্পর সংলগ্ন নয়"
  },
  ErrCode_ERR_GEAR_SHOP_NOT_NUM_Desc = {
    Text = "দোকান রিফ্রেশের সংখ্যা অপর্যাপ্ত"
  },
  ErrCode_ERR_HOME_PLAYERLEVEL_LOCK_Desc = {
    Text = "খেলোয়াড়ের স্তর অপর্যাপ্ত"
  },
  ErrCode_ERR_ILLEGAL_CHARACTER_Desc = {
    Text = "বর্ণনায় অবৈধ অক্ষর রয়েছে। অনুগ্রহ করে পুনরায় লিখো।"
  },
  ErrCode_ERR_INOTHERBATTLE_Desc = {
    Text = "প্রতিপক্ষ এই মুহূর্তে ব্যস্ত"
  },
  ErrCode_ERR_INVALID_INDEX_Desc = {
    Text = "অবৈধ সূচক মান"
  },
  ErrCode_ERR_INVITE_EACH_Desc = {
    Text = "আপনি ইতিমধ্যেই তাদের আমন্ত্রণকারী।"
  },
  ErrCode_ERR_INVITE_REPEAT_Desc = {
    Text = "আমন্ত্রণকারী ইতিমধ্যেই বিদ্যমান"
  },
  ErrCode_ERR_IN_COPIES_Desc = {
    Text = "ইনস্ট্যান্সের অবস্থা ত্রুটিপূর্ণ, অনুগ্রহ করে আবার লগ ইন করুন"
  },
  ErrCode_ERR_ITEM_BAG_FULL_Desc = {
    Text = "সামগ্রী পূর্ণ"
  },
  ErrCode_ERR_ITEM_CHARGES_USEDUP_Desc = {
    Text = "আপনি আজকের ক্রয়সীমায় পৌঁছে গেছেন"
  },
  ErrCode_ERR_ITEM_HAS_BEEN_EQUIP_Desc = {
    Text = "আইটেমটি সজ্জিত করা হয়েছে"
  },
  ErrCode_ERR_ITEM_HAS_LOCKED_Desc = {
    Text = "আইটেমটি লক করা"
  },
  ErrCode_ERR_ITEM_HAS_UNLOCKED_Desc = {
    Text = "আইটেম লক করা নয়"
  },
  ErrCode_ERR_ITEM_MAX_STAGE_Desc = {
    Text = "আইটেমটি সর্বোচ্চ স্তরে পৌঁছেছে"
  },
  ErrCode_ERR_ITEM_NOT_ENOUGH_Desc = {
    Text = "আইটেম অপর্যাপ্ত"
  },
  ErrCode_ERR_ITEM_NOT_FIND_Desc = {
    Text = "আইটেম পাওয়া যায়নি"
  },
  ErrCode_ERR_ITEM_NOT_MATCH_Desc = {
    Text = "আইটেম অসামঞ্জস্যপূর্ণ"
  },
  ErrCode_ERR_ITEM_NOT_USE_Desc = {
    Text = "আইটেম ব্যবহার করা যাবে না"
  },
  ErrCode_ERR_ITEM_REPEAT_Desc = {
    Text = "ডুপ্লিকেট আইটেম"
  },
  ErrCode_ERR_ITEM_START_DROP_DATE_Desc = {
    Text = "নিয়তিচক্র বা পসি এখনো সংগ্রহযোগ্য নয়"
  },
  ErrCode_ERR_ITEM_SUB_NUM_FAULT_Desc = {
    Text = "আইটেম ব্যবহারের পরিমাণ সঠিক নয়"
  },
  ErrCode_ERR_ITEM_UNUSABLE_Desc = {
    Text = "আইটেম ব্যবহার করা যাবে না"
  },
  ErrCode_ERR_LAST_GEAR_NOT_FIND_Desc = {
    Text = "পূর্ববর্তী ট্রিগার নোড পাওয়া যায়নি"
  },
  ErrCode_ERR_LEAVE_NOT_CONDITION_Desc = {
    Text = "বর্তমানে সংগৃহীত শক্তি পোর্টাল সক্রিয় করার জন্য যথেষ্ট নয়। প্রয়োজন {s1} শক্তি পয়েন্ট"
  },
  ErrCode_ERR_LEVEL_MAX_Desc = {
    Text = "সর্বোচ্চ স্তর অর্জিত"
  },
  ErrCode_ERR_LOCKED_Desc = {
    Text = "লক করা"
  },
  ErrCode_ERR_LOCK_COPIESAREA_Desc = {
    Text = "ইনস্ট্যান্স এলাকা এখনো আনলক করা হয়নি"
  },
  ErrCode_ERR_LOCK_COPIESPLOTMOPPING_Desc = {
    Text = "গল্প ঝাড়ু এখনো আনলক করা হয়নি"
  },
  ErrCode_ERR_LOCK_COPIES_Desc = {
    Text = "নির্বাচিত ইনস্ট্যান্স এখনো আনলক করা হয়নি"
  },
  ErrCode_ERR_LOCK_SROTYLINE_Desc = {
    Text = "নির্বাচিত গল্প এখনো আনলক করা হয়নি"
  },
  ErrCode_ERR_LOGIN_SERVER_Desc = {
    Text = "লগইন সার্ভার ত্রুটি"
  },
  ErrCode_ERR_MAIL_ITEM_GAIN_Desc = {
    Text = "সংযুক্তি গ্রহণ করা হয়েছে"
  },
  ErrCode_ERR_MAIL_NOT_FIND_Desc = {
    Text = "মেইল বিদ্যমান নয়"
  },
  ErrCode_ERR_MATCH_FAIL_Desc = {
    Text = "ম্যাচ ব্যর্থ হয়েছে"
  },
  ErrCode_ERR_MAXSUMMONLIMIT_Desc = {
    Text = "সর্বোচ্চ জাগরণ সীমায় পৌঁছেছে!"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHALLENGE_Desc = {
    Text = "নির্দিষ্ট সোনা ডানজিয়নে চ্যালেঞ্জ করা সম্ভব নয়"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE_Desc = {
    Text = "মোতায়েনের জন্য একজন জাগরণকারী নির্বাচন করুন"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CONDITION_Desc = {
    Text = "নির্দিষ্ট সোনা ইনস্ট্যান্স লক করা আছে - অনুগ্রহ করে নির্দিষ্ট তদন্ত ইনস্ট্যান্স সম্পন্ন করুন"
  },
  ErrCode_ERR_NAME_CHANGE_COOLTIME_Desc = {
    Text = "নাম পরিবর্তনের সময় এখনও হয়নি, অনুগ্রহ করে প্রহরা করুন"
  },
  ErrCode_ERR_NAME_ILLEGAL_CHARACTER_Desc = {
    Text = "নামে অবৈধ অক্ষর রয়েছে, অনুগ্রহ করে পুনরায় প্রবেশ করুন"
  },
  ErrCode_ERR_NAME_NOT_LENGTH_Desc = {
    Text = "নামের দৈর্ঘ্য অবৈধ, অবশ্যই 2-4 অক্ষর হতে হবে"
  },
  ErrCode_ERR_NOTE_LENGTH_LIMIT_Desc = {
    Text = "ইনপুট স্ট্রিংটি অতিরিক্ত দীর্ঘ"
  },
  ErrCode_ERR_NOTE_LENGTH_SHORT_Desc = {
    Text = "ইনপুট অক্ষর অনেক ছোট"
  },
  ErrCode_ERR_NOT_ENOUGH_INTEGRAL_Desc = {
    Text = "পর্যাপ্ত পয়েন্ট নেই"
  },
  ErrCode_ERR_NOT_HAVE_ITEM_Desc = {
    Text = "আইটেমের মালিকানা নেই"
  },
  ErrCode_ERR_NOT_MOVE_Desc = {
    Text = "সরানো সম্ভব নয়"
  },
  ErrCode_ERR_NOT_OPEN_Desc = {
    Text = "ফিচার লক করা"
  },
  ErrCode_ERR_NOT_PRIZE_CONDITION_Desc = {
    Text = "পুরস্কারের শর্ত পূরণ হয়নি। দাবি করা সম্ভব নয়।"
  },
  ErrCode_ERR_NO_AWAKER_DETAIL_Desc = {
    Text = "প্রোফাইল আপডেট হচ্ছে, পরে ফিরে এসে দেখুন"
  },
  ErrCode_ERR_NO_FRIEND_GAME_Desc = {
    Text = "কোনো প্রগতি-মান প্রীতি ম্যাচ নেই"
  },
  ErrCode_ERR_NO_TRINKET_Desc = {
    Text = "কোনো অব্যবহৃত কভেন্যান্ট নেই"
  },
  ErrCode_ERR_NPC_DATA_Desc = {
    Text = "এনপিসি ডেটা ত্রুটিপূর্ণ"
  },
  ErrCode_ERR_NPC_FINISH_Desc = {
    Text = "এনপিসি ইতিমধ্যে ট্রিগার হয়েছে"
  },
  ErrCode_ERR_NPC_NOT_FIND_Desc = {
    Text = "এনপিসি বিদ্যমান নয়"
  },
  ErrCode_ERR_OFFLINE_Desc = {
    Text = "প্রতিপক্ষ বর্তমানে অফলাইন"
  },
  ErrCode_ERR_PLAYERLEVEL_NOT_ENOUGH_Desc = {
    Text = "খেলোয়াড়ের স্তর অপর্যাপ্ত"
  },
  ErrCode_ERR_PLOTMOP_STARLIMIT_Desc = {
    Text = "ঝাড়ু দেওয়ার জন্য পর্যাপ্ত গল্প নক্ষত্রপুঞ্জ নেই"
  },
  ErrCode_ERR_PLOTSAY_NOT_END_Desc = {
    Text = "কোনো গল্পসংক্রান্ত সংলাপ ইভেন্ট পাওয়া যায়নি"
  },
  ErrCode_ERR_PLOT_BUY_TIMES_NOT_ENOUGH_Desc = {
    Text = "গল্পরেখা চ্যালেঞ্জের ক্রয় প্রচেষ্টা অপর্যাপ্ত"
  },
  ErrCode_ERR_PRIZE_GAIN_Desc = {
    Text = "পুরস্কার সংগৃহীত"
  },
  ErrCode_ERR_PRIZE_NOT_FIND_Desc = {
    Text = "এমন কোনো পুরস্কার নেই"
  },
  ErrCode_ERR_PUTENCHANT_FAIL_Desc = {
    Text = "রুন বসানো ব্যর্থ হয়েছে"
  },
  ErrCode_ERR_PVPCOLLECT_NOT_FIND_Desc = {
    Text = "PVP সংগ্রহ এখনো অর্জিত হয়নি"
  },
  ErrCode_ERR_PVPTEAM_NEED_KEEPERSKILL_Desc = {
    Text = "ট্র্যাফেজ টিম মোতায়েনের জন্য পর্যাপ্ত পসি নেই"
  },
  ErrCode_ERR_PVPTEAM_NEED_WEAPON_Desc = {
    Text = "ট্র্যাফেজ টিম মোতায়েনের জন্য পর্যাপ্ত WoD নেই"
  },
  ErrCode_ERR_PVP_DRAFT_LOCK_Desc = {
    Text = "ড্রাফট পিক মোডের শর্ত পূরণ হয়নি"
  },
  ErrCode_ERR_PVP_NOT_COOLTIME_Desc = {
    Text = "চ্যালেঞ্জ কুলডাউনে রয়েছে"
  },
  ErrCode_ERR_PVP_NOT_COUNT_Desc = {
    Text = "চ্যালেঞ্জের আর কোনো প্রচেষ্টা অবশিষ্ট নেই"
  },
  ErrCode_ERR_PVP_NOT_FIND_OTHER_Desc = {
    Text = "চ্যালেঞ্জ করার মতো কোনো প্রতিপক্ষ নেই"
  },
  ErrCode_ERR_PVP_NOT_FIND_ROUSE_Desc = {
    Text = "মোতায়েনের জন্য একজন জাগরণকারী নির্বাচন করুন"
  },
  ErrCode_ERR_PVP_OverWinTime_Desc = {
    Text = "দুই খেলোয়াড়ের একজন ইতিমধ্যে দুইটি জয় অর্জন করেছে। অতিরিক্ত কোনো রাউন্ড অনুমোদিত নয়।"
  },
  ErrCode_ERR_PVP_QUIT_Desc = {
    Text = "প্রতিপক্ষ খেলা ত্যাগ করেছে"
  },
  ErrCode_ERR_PVP_ROOM_NOT_EXIST_Desc = {
    Text = "পাসওয়ার্ড মোড অবৈধ বা মেয়াদোত্তীর্ণ"
  },
  ErrCode_ERR_RANK_OUT_OF_RANGE_Desc = {
    Text = "বর্তমানে 2000 এর বাইরের র‍্যাংকিং তথ্য দেখা সমর্থিত নয়।"
  },
  ErrCode_ERR_RECHARGE_NOT_CONFIG_Desc = {
    Text = "রিচার্জ সেটিংসে এমন কোনো কনফিগারেশন বিদ্যমান নেই"
  },
  ErrCode_ERR_RECHARGE_NOT_FREE_Desc = {
    Text = "তুমি ইতিমধ্যে ফ্রি টপ-আপ পেয়েছ, আবার রিচার্জ করা যাবে না"
  },
  ErrCode_ERR_REFRESH_NUM_LIMIT_Desc = {
    Text = "আইটেম রিফ্রেশের সীমা পূর্ণ হয়েছে"
  },
  ErrCode_ERR_RELATION_Desc = {
    Text = "তোমাদের একে অপরকে ফলো করা আবশ্যক"
  },
  ErrCode_ERR_RELIC_FULL_Desc = {
    Text = "রেলিক পূর্ণ"
  },
  ErrCode_ERR_REQUEST_CD_Desc = {
    Text = "অনুরোধ অত্যন্ত ঘন ঘন করা হচ্ছে। অনুগ্রহ করে পরে আবার চেষ্টা করুন।"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_ITEM_Desc = {
    Text = "এলিট উন্নতকরণের জন্য উপকরণ অপর্যাপ্ত"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_MONEY_Desc = {
    Text = "জাগরণকারীর উন্নয়ন অর্জনের জন্য মুদ্রা অপর্যাপ্ত"
  },
  ErrCode_ERR_ROLE_DATA_Desc = {
    Text = "চরিত্র ডেটা ত্রুটি"
  },
  ErrCode_ERR_ROLE_ENERGY_FULL_Desc = {
    Text = "জাগরণকারীর আগমন হার সর্বোচ্চ সীমায় পৌঁছেছে, আর বৃদ্ধি করা সম্ভব নয়"
  },
  ErrCode_ERR_ROLE_LEVEl_NOENOUGH_Desc = {
    Text = "জাগরণকারীর স্তর অপর্যাপ্ত"
  },
  ErrCode_ERR_ROLE_MAX_LEVEL_Desc = {
    Text = "জাগরণকারী সর্বোচ্চ স্তরে পৌঁছেছে এবং উন্নয়ন অর্জন করা সম্ভব নয়"
  },
  ErrCode_ERR_ROLE_MONEY_NOT_ENOUGH_Desc = {
    Text = "অপর্যাপ্ত মুদ্রা"
  },
  ErrCode_ERR_ROLE_NOT_ADVANCE_Desc = {
    Text = "জাগ্রত সর্বোচ্চ এডিফাই স্তরে আরোহণ করেছে।"
  },
  ErrCode_ERR_ROLE_NOT_ARRIVED_MAXLEVEL_Desc = {
    Text = "অগ্রসর হতে সর্বোচ্চ স্তরে নাগাল দিন"
  },
  ErrCode_ERR_ROLE_NOT_FIND_Desc = {
    Text = "কোনো জাগরণকারীর ডেটা পাওয়া যায়নি"
  },
  ErrCode_ERR_ROLE_NOT_SKILL_Desc = {
    Text = "জাগরণকারীর কোনো দক্ষতা নেই"
  },
  ErrCode_ERR_ROLE_NOT_SLOTDATA_Desc = {
    Text = "কোনো স্লট তথ্য সংগ্রহযোগ্য নয়"
  },
  ErrCode_ERR_ROLE_POTENCY_MAX_Desc = {
    Text = "জাগরণকারীর সম্ভাবনা সর্বোচ্চ স্তরে পৌঁছেছে"
  },
  ErrCode_ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM_Desc = {
    Text = "জাগরণকারীর সম্ভাবনা উন্নয়ন অর্জনের জন্য আইটেম অপর্যাপ্ত"
  },
  ErrCode_ERR_ROLE_SKILL_LOCKED_Desc = {
    Text = "জাগরণকারীর দক্ষতা এখনো আনলক করা হয়নি"
  },
  ErrCode_ERR_ROLE_SKILL_MAX_Desc = {
    Text = "দক্ষতা সর্বোচ্চ স্তরে পৌঁছেছে"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_ITEM_Desc = {
    Text = "দক্ষতা উন্নয়ন অর্জনের জন্য পর্যাপ্ত আইটেম নেই"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_MONEY_Desc = {
    Text = "দক্ষতা উন্নয়ন অর্জনের জন্য পর্যাপ্ত মুদ্রা নেই"
  },
  ErrCode_ERR_ROLE_SLOT_MAX_LEVEL_Desc = {
    Text = "সর্বোচ্চ স্তর অর্জিত"
  },
  ErrCode_ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER_Desc = {
    Text = "আর কোনো ম্যানুয়াল উন্নয়ন অর্জন স্লট সংগ্রহযোগ্য নেই"
  },
  ErrCode_ERR_ROLE_STAGE_Desc = {
    Text = "ইতিমধ্যেই অগ্রসর হয়েছে; আবার অগ্রসর হওয়া সম্ভব নয়"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_ITEM_Desc = {
    Text = "জাগরণকারীর উন্নয়ন অর্জনের জন্য প্রয়োজনীয় আইটেম অপর্যাপ্ত"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_MONEY_Desc = {
    Text = "জাগরণকারীর উন্নয়ন অর্জনের জন্য মুদ্রা অপর্যাপ্ত"
  },
  ErrCode_ERR_SCHOOL_NOT_MATCH_Desc = {
    Text = "রিয়েল্ম শর্ত পূরণ করছে না"
  },
  ErrCode_ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT_Desc = {
    Text = "রিয়েল্ম টাওয়ারে মোতায়েন করা জাগরণকারীরা রিয়েল্মের শর্ত পূরণ করে না"
  },
  ErrCode_ERR_SCHOOL_TOWN_BATCH_MATCH_Desc = {
    Text = "তুমি যে স্তরে প্রবেশ করেছ, তা বর্তমানে সংগ্রহযোগ্য নয়"
  },
  ErrCode_ERR_SCHOOL_TOWN_SAME_AWAKER_Desc = {
    Text = "রিয়েল্ম টাওয়ারে একই জাগরণকারী মোতায়েন করা যাবে না"
  },
  ErrCode_ERR_SENIORMONEY_NOT_ENOUGH_Desc = {
    Text = "সিলভার অপর্যাপ্ত"
  },
  ErrCode_ERR_SERVER_CLOSED_Desc = {
    Text = "ক্যাম্পাস রক্ষণাবেক্ষণ চলছে। সম্পন্ন হওয়া পর্যন্ত অপেক্ষা করুন।"
  },
  ErrCode_ERR_SERVER_NOT_START_Desc = {
    Text = "সেবা শুরু হয়নি"
  },
  ErrCode_ERR_SHOP_BUY_Desc = {
    Text = "ইতিমধ্যেই ক্রয় করা হয়েছে"
  },
  ErrCode_ERR_SHOP_CUSTOM_CMD_Desc = {
    Text = "এই মুহূর্তে অনুভব করা সম্ভব নয়"
  },
  ErrCode_ERR_SHOP_GOODS_EXPIRE_Desc = {
    Text = "আইটেমটির মেয়াদ শেষ হয়েছে, রিডিম করা সম্ভব নয়"
  },
  ErrCode_ERR_SHOP_GOODS_NOT_ENGHOU_Desc = {
    Text = "বিক্রয়ের আইটেমটির মজুত ফুরিয়ে গেছে"
  },
  ErrCode_ERR_SHOP_NOT_DATA_Desc = {
    Text = "কোনো দোকানের তথ্য উপলব্ধ নয়"
  },
  ErrCode_ERR_SHOP_NOT_Desc = {
    Text = "এই ধরনের কোনো দোকান নেই"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_Desc = {
    Text = "এ ধরনের কোনো আইটেম বিক্রয়ের জন্য নেই"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_SELL_Desc = {
    Text = "দোকানে এই আইটেমটি মজুত নেই"
  },
  ErrCode_ERR_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "কোনো রিফ্রেশ প্রচেষ্টা অবশিষ্ট নেই"
  },
  ErrCode_ERR_SHOP_NOT_SELL_Desc = {
    Text = "এই আইটেমটি মিথাগ দোকানে সংগ্রহযোগ্য নয়"
  },
  ErrCode_ERR_SHOP_REFRESH_Desc = {
    Text = "বর্তমান নোডটি মিথাগ দোকান নয়, রিফ্রেশ করা সম্ভব নয়।"
  },
  ErrCode_ERR_SOCIAL_NO_ROLE_Desc = {
    Text = "এই প্লেয়ারটি অস্তিত্বহীন।"
  },
  ErrCode_ERR_STAGE_GROUP_BAN_BY_TASK_Desc = {
    Text = "আদিম দর্শনের সব অবতার পরাজিত হয়েছে"
  },
  ErrCode_ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT_Desc = {
    Text = "এই ধরনের স্টেজের দৈনিক চ্যালেঞ্জ সীমা পূর্ণ হয়েছে"
  },
  ErrCode_ERR_SUMMON_CLICKTOOFAST_Desc = {
    Text = "ক্লিক করার হার অত্যধিক। অনুগ্রহ করে পরে আবার চেষ্টা করুন।"
  },
  ErrCode_ERR_SUMMON_NOT_OPEN_Desc = {
    Text = "জাগরণ কার্যক্রম সক্রিয় নয়"
  },
  ErrCode_ERR_TALENT_ACTIVE_CONDITION_Desc = {
    Text = "সক্রিয়করণের শর্ত পূরণ হয়নি"
  },
  ErrCode_ERR_TALENT_ACTIVE_Desc = {
    Text = "অনুরণন ইতিমধ্যেই সক্রিয়। পুনরায় সক্রিয় করার প্রয়োজন নেই।"
  },
  ErrCode_ERR_TALENT_INIT_STATE_NOT_RESET_Desc = {
    Text = "প্রাথমিক অনুরণন রিসেট করা যাবে না"
  },
  ErrCode_ERR_TALENT_ITEM_NOT_ENOUGH_Desc = {
    Text = "অনুরণনের উপকরণ অপর্যাপ্ত"
  },
  ErrCode_ERR_TALENT_MAX_LEVEL_Desc = {
    Text = "অনুরণন পয়েন্ট সর্বোচ্চ স্তরে পৌঁছেছে"
  },
  ErrCode_ERR_TALENT_NOT_COPIES_Desc = {
    Text = "ইনস্ট্যান্সে কোনো অনুরণন পাওয়া যায়নি"
  },
  ErrCode_ERR_TALENT_NOT_FIND_Desc = {
    Text = "কোনো অনুরণন ডেটা পাওয়া যায়নি"
  },
  ErrCode_ERR_TALENT_NOT_FIND_LEVEL_Desc = {
    Text = "অনুরণনের স্তর-সম্পর্কিত কোনো ডেটা পাওয়া যায়নি"
  },
  ErrCode_ERR_TALENT_NOT_RESET_NUM_Desc = {
    Text = "কোনো রিসেটের চেষ্টা অবশিষ্ট নেই"
  },
  ErrCode_ERR_TALENT_UNLOCK_Desc = {
    Text = "জাগরণকারীর উৎপাদন প্রভাব ইতিমধ্যেই আনলক করা হয়েছে; পুনরায় আনলক করার প্রয়োজন নেই।"
  },
  ErrCode_ERR_TASKMODULE_PRIZE_NOT_GAIN_Desc = {
    Text = "পুরস্কার সংগৃহীত"
  },
  ErrCode_ERR_TASK_APPOINT_TASK_FINISH_Desc = {
    Text = "অর্পিত মিশন সম্পন্ন হয়েছে, এখন আর তা প্রত্যাহার করা যাবে না"
  },
  ErrCode_ERR_TASK_DELEGATE_NOT_COND_Desc = {
    Text = "বরাদ্দের শর্ত অপর্যাপ্ত"
  },
  ErrCode_ERR_TASK_FINISH_Desc = {
    Text = "মিশন সম্পন্ন"
  },
  ErrCode_ERR_TASK_NOT_FIND_Desc = {
    Text = "গোপনরক্ষকের হ্যান্ডবুক পাওয়া যায়নি"
  },
  ErrCode_ERR_TASK_NOT_GAINPRIZE_Desc = {
    Text = "কুয়েস্ট অসম্পূর্ণ, পুরস্কার সংগ্রহযোগ্য নয়"
  },
  ErrCode_ERR_TEAM_NAME_ILLEGLE_Desc = {
    Text = "দলের নাম কেবল চীনা বা ইংরেজি অক্ষরই ধারণ করতে পারবে"
  },
  ErrCode_ERR_TEAM_NAME_TOO_LONG_Desc = {
    Text = "দলের নামের দৈর্ঘ্য ৮ অক্ষরের বেশি হতে পারবে না"
  },
  ErrCode_ERR_TEAM_NEED_4_AWAKER_Desc = {
    Text = "দলে 4 জন জাগরণকারী প্রয়োজন"
  },
  ErrCode_ERR_TEAM_NO_TEAM_Desc = {
    Text = "দলের বিন্যাস পাওয়া যায়নি"
  },
  ErrCode_ERR_TEAM_NO_WEAPON_SLOT_Desc = {
    Text = "দলের জাগরণকারী নিয়তিচক্র সেট করেনি"
  },
  ErrCode_ERR_TEAM_SCHOOLMIX_Desc = {
    Text = "দলে থাকা জাগরণকারীদের সঙ্গে রিয়েল্ম সংঘাত রয়েছে, অনুগ্রহ করে সমন্বয় করো"
  },
  ErrCode_ERR_TEAM_WEAPON_NOT_EXISTS_Desc = {
    Text = "নিয়তিচক্র বিদ্যমান নয়"
  },
  ErrCode_ERR_TICKET_NOT_ENOUGH_Desc = {
    Text = "ভাউচার অপর্যাপ্ত"
  },
  ErrCode_ERR_TOKEN_Desc = {
    Text = "লগইন টোকেন ত্রুটি"
  },
  ErrCode_ERR_TRIGGER_NOT_FIND_Desc = {
    Text = "বর্তমান ট্রিগার নোড পাওয়া যায়নি"
  },
  ErrCode_ERR_TRINKET_NOT_TRAINING_Desc = {
    Text = "অ্যাক্সেসরি রেকর্ড করা হয়নি, বৈশিষ্ট্য প্রতিস্থাপন করা সম্ভব নয়"
  },
  ErrCode_ERR_UNATTEN_FIRST_Desc = {
    Text = "আগে আনফলো করুন, তারপর ব্লক করুন"
  },
  ErrCode_ERR_UNIT_USED_ONCE_Desc = {
    Text = "আজকের এই খেলায় জাগরণকারী, নিয়তিচক্র, অথবা পসি ইতিমধ্যে ব্যবহার করা হয়েছে"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_AVAILABLE_Desc = {
    Text = "সাইড কোয়েস্ট আনলক ব্যর্থ: সাইড কোয়েস্ট ইতিমধ্যেই সংগ্রহযোগ্য"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NOT_OPEN_Desc = {
    Text = "সাইড কোয়েস্ট আনলক ব্যর্থ: সাইড কোয়েস্ট সক্রিয় করা হয়নি"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM_Desc = {
    Text = "সাইড কোয়েস্ট আনলক ব্যর্থ: আনলকের জন্য প্রয়োজনীয় কোনো আইটেম নেই"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_UNLOCKED_Desc = {
    Text = "সাইড কোয়েস্ট আনলক ব্যর্থ: সাইড কোয়েস্ট ইতিমধ্যেই আনলক করা"
  },
  ErrCode_ERR_VERSION_TOO_OLD_Desc = {
    Text = "ভার্সন মিলছে না, অনুগ্রহ করে আপডেট করো। আপডেট করা থাকলে, ক্যাম্পাস রক্ষণাবেক্ষণ শেষ হওয়া পর্যন্ত অপেক্ষা করো।"
  },
  ErrCode_FAILED_Desc = {
    Text = "ব্যর্থতা"
  },
  ErrCode_IS_CREATE_ROLE_Desc = {
    Text = "এই চরিত্রটি ইতোমধ্যে বিদ্যমান; আরেকটি তৈরি করার প্রয়োজন নেই"
  },
  ErrCode_SUCCESS_Desc = {
    Text = "সাফল্য"
  }
})
return Text_ErrCode
