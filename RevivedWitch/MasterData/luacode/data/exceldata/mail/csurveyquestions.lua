-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/mail/csurveyquestions.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local csurveyquestions = {}
csurveyquestions.Data = {
[1] = {id = 1, questionType = 1, questionTitle = "你之前是否参加过“复苏的魔女”内测？（单选）", 
selection = {"是", "否"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[2] = {id = 2, questionType = 2, questionTitle = "吸引你再次参加测试的主要原因是？（最多选三项）", 
selection = {"魔女题材剧情", "像素风画面", "新颖战斗玩法", "探索式地图关卡", "精美人物立绘", "某个喜爱的人偶", "上次测试的充值返利", "其他"}
, multiCountMin = 1, multiCountMax = 3, confirmAnswer = 0}
, 
[3] = {id = 3, questionType = 2, questionTitle = "《复苏的魔女》最吸引你的是？（最多选三项）", 
selection = {"主角的魔女造型", "西幻世界观", "“会魔法的少女”的角色设定", "角色立绘好看", "探索式RPG玩法", "精致像素风场景", "战斗模式好玩", "BGM好听", "游戏评分高", "其他"}
, multiCountMin = 1, multiCountMax = 3, confirmAnswer = 0}
, 
[4] = {id = 4, questionType = 2, questionTitle = "你平时喜欢玩什么手游？（最多选三项）", 
selection = {"二次元游戏（如：明日方舟等）", "像素风游戏（如：克鲁塞德战记等）", "女性向游戏（如：恋与制作人等）", "日式RPG（如：另一个伊甸）", "有魔女角色的游戏（如：爆裂魔女等）", "MMORPG(如：楚留香）", "放置挂机（如：剑与远征）", "Roguelike（如：不思议迷宫）", "音乐节奏（如：Cytus）", "SLG（如：率土之滨）", "其他"}
, multiCountMin = 1, multiCountMax = 3, confirmAnswer = 0}
, 
[5] = {id = 5, questionType = 2, questionTitle = "你一般通过什么渠道获取新游戏？（最多选三项）", 
selection = {"微博/P站画手同人图", "B站手书动画/玩梗视频", "B站up主的安利视频", "TapTap推荐", "朋友/群友推荐", "主动搜索", "App Store/手机应用商店", "其他"}
, multiCountMin = 1, multiCountMax = 3, confirmAnswer = 0}
, 
[6] = {id = 6, questionType = 2, questionTitle = "除了玩游戏还有哪些其他爱好？（最多选三项）", 
selection = {"看动画番剧", "逛展会（如：CP,CJ）", "和贴吧／微博同好水贴聊天", "看网文（如：诡秘之主）", "看日本轻小说（如：刀剑神域）", "看漫画", "其他"}
, multiCountMin = 1, multiCountMax = 3, confirmAnswer = 0}
, 
[7] = {id = 7, questionType = 2, questionTitle = "你平常会逛哪些APP？（最多选三项）", 
selection = {"微博", "百度贴吧", "NGA/小黑盒", "微信公众号", "B站", "QQ空间", "网易云音乐等听歌APP", "今日头条等新闻APP", "动漫之家等漫画APP", "抖音等短视频APP", "其他"}
, multiCountMin = 1, multiCountMax = 3, confirmAnswer = 0}
, 
[8] = {id = 8, questionType = 1, questionTitle = "你的性别是？（单选）", 
selection = {"男", "女"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[9] = {id = 9, questionType = 1, questionTitle = "你的年龄是？（单选）", 
selection = {"16岁以下", "16-18岁", "19-23岁", "24岁-29岁", "30岁及以上"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[10] = {id = 10, questionType = 1, questionTitle = "你的职业是？（单选）", 
selection = {"在读学生（高中及以下）", "在读学生（大学及以上）", "民营/外企/私企公司员工", "国企/事业单位/公务员", "个体商户/自由职业者", "商场/餐饮等工作人员"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[11] = {id = 11, questionType = 1, questionTitle = "后续我们将抽取部分用户进行线下访谈，参与访谈将获得200元京东卡奖励，请问你是否愿意参加（坐标深圳，时间1月底）？（单选）", 
selection = {"不愿意", "愿意"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[12] = {id = 12, questionType = 3, questionTitle = "请留下你的QQ号，便于工作人员与你取得联系", 
selection = {}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[13] = {id = 13, questionType = 4, questionTitle = "为验证问卷有效性，请回答3+5=？", 
selection = {"11", "12", "8", "20"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 3}
, 
[14] = {id = 14, questionType = 1, questionTitle = "你对新手引导的体验如何评价？ （单选）", 
selection = {"体验良好，在需要而且合适的时候出现", "体验一般，有时候在不合适的时候出现", "体验较差，经常在不合适的时候出现，影响游戏体验"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[15] = {id = 15, questionType = 2, questionTitle = "新手引导体验不舒服的地方主要是？（最多选三项）", 
selection = {"战斗指导较难理解，无法掌握", "人偶养成指导过多，较难记住", "缺少地图指导，地图道具的使用有困难", "商城指导不足，讲解不够清晰", "时间长前期体验重复，比较无聊", "其他"}
, multiCountMin = 1, multiCountMax = 3, confirmAnswer = 0}
, 
[16] = {id = 16, questionType = 2, questionTitle = "《复苏的魔女》里你最喜欢的点是什么？（最多选三项）", 
selection = {"角色立绘好看", "角色设定有意思", "收集养成的快感", "剧情的趣味性", "探索式RPG玩法", "精致的像素风场景", "BGM好听", "新颖的战斗方式", "其他"}
, multiCountMin = 1, multiCountMax = 3, confirmAnswer = 0}
, 
[17] = {id = 17, questionType = 2, questionTitle = "本次测试优化的游戏内容，你满意的有哪些？（最多选三项）", 
selection = {"主线中新增的地图符文", "梦境世界（材料副本）", "破碎之境（周常副本-多编队）", "事象限界（周常副本-roguelike玩法）", "时空裂隙（周常副本-人偶对战）", "事象记忆（角色支线）", "其他"}
, multiCountMin = 1, multiCountMax = 3, confirmAnswer = 0}
, 
[18] = {id = 18, questionType = 2, questionTitle = "吸引你持续玩下去的动力是什么？（最多选三项）", 
selection = {"有人物养成目标", "有收集目标（全图鉴）", "想知道剧情走向", "关卡通关的快感", "想解锁更多玩法", "发掘不同的战斗策略", "其他"}
, multiCountMin = 1, multiCountMax = 3, confirmAnswer = 0}
, 
[19] = {id = 19, questionType = 2, questionTitle = "哪些游戏内容，你最想吐槽？（最多选三项）", 
selection = {"新手引导", "剧情世界观", "角色立绘", "角色设定", "声优配音", "付费体验", "地图关卡", "战斗模式", "周边玩法（如魔女庭院、副本Boss等）", "其他"}
, multiCountMin = 1, multiCountMax = 3, confirmAnswer = 0}
, 
[20] = {id = 20, questionType = 1, questionTitle = "在游戏过程中，你会打开游戏音效吗？", 
selection = {"会", "不会听游戏配乐及音效"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[21] = {id = 21, questionType = 2, questionTitle = "你希望在官方社区看到什么内容？（最多选三项）", 
selection = {"角色Q萌番外日常", "好看的角色海报", "精致的PV", "游戏设定爆料", "角色设定爆料", "研发相关的采访/视频/直播等", "官方漫画", "周边", "其他"}
, multiCountMin = 1, multiCountMax = 3, confirmAnswer = 0}
, 
[22] = {id = 22, questionType = 1, questionTitle = "以下你认为哪个描述最适合《复苏的魔女》？（单选）", 
selection = {"西幻世界，魔女之旅", "萌系小魔女，梦镜大冒险", "跨时空魔女养成RPG", "冒险吧！魔女大人", "都不适合"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[23] = {id = 23, questionType = 3, questionTitle = "当你想向朋友推荐《复苏的魔女》时，你会怎么说？", 
selection = {}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[24] = {id = 24, questionType = 4, questionTitle = "为验证问卷有效性，请回答1+2=？", 
selection = {"50", "15", "76", "3"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 4}
, 
[25] = {id = 25, questionType = 1, questionTitle = "你对第五章新主线（嘉庇艾尔）的体验如何？（单选）", 
selection = {"很满意", "感觉不错", "比较无感", "不喜欢"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[26] = {id = 26, questionType = 3, questionTitle = "你最喜欢的人偶是？", 
selection = {}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[27] = {id = 27, questionType = 1, questionTitle = "你喜欢她的原因是？（单选）", 
selection = {"立绘好看", "声音好听", "战斗力强", "人设带感", "其他"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[28] = {id = 28, questionType = 1, questionTitle = "你在培养人偶时，有没有遇到瓶颈？（单选）", 
selection = {"玛那难刷", "升级材料难刷", "装备难刷", "其他"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[29] = {id = 29, questionType = 2, questionTitle = "你觉得商城里最值得买的是？（最多选两项）", 
selection = {"月卡", "梦境螺旋", "首充赠礼", "成长礼包", "限时礼包", "时装", "其他"}
, multiCountMin = 1, multiCountMax = 2, confirmAnswer = 0}
, 
[30] = {id = 30, questionType = 3, questionTitle = "游玩过程中有让你印象深刻的一瞬间吗？", 
selection = {}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[31] = {id = 31, questionType = 3, questionTitle = "请问你对《复苏的魔女》有什么建议或期待？", 
selection = {}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[32] = {id = 32, questionType = 4, questionTitle = "为验证问卷有效性，请回答2+2=？", 
selection = {"15", "4", "80", "23"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 2}
, 
[33] = {id = 33, questionType = 1, questionTitle = "你为什么会下载《复苏的魔女》？【单选】", 
selection = {"看到应用商店推荐", "看到应用商店排行榜", "自己喜欢主动搜索", "看到up主视频觉得有意思", "被朋友安利", "看到广告被吸引", "雷霆游戏都会尝试", "其他游戏Q群有人讨论", "其他"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[34] = {id = 34, questionType = 2, questionTitle = "体验过《复苏的魔女》后，哪个特点最吸引你？【多选】", 
selection = {"西幻世界观", "魔女题材剧情", "精致像素风画面", "角色立绘好看", "探索式RPG玩法", "战斗模式好玩", "BGM好听", "其他"}
, multiCountMin = 1, multiCountMax = 8, confirmAnswer = 0}
, 
[35] = {id = 35, questionType = 2, questionTitle = "体验过《复苏的魔女》后，你想吐槽的是？【多选】", 
selection = {"新手引导", "剧情世界观", "角色立绘", "角色设定", "中文声优配音", "日文声优配音", "地图关卡", "战斗模式", "性能问题（发热/卡顿等）", "周边玩法（如魔女庭院）", "其他"}
, multiCountMin = 1, multiCountMax = 11, confirmAnswer = 0}
, 
[36] = {id = 36, questionType = 2, questionTitle = "以下官方内容你看过哪些？【多选】", 
selection = {"预抽卡页面活动", "公测前瞻直播", "魔女世界观动画PV", "乐高定格动画视频", "社区四格条漫", "社区趣味宣传视频", "其他"}
, multiCountMin = 1, multiCountMax = 7, confirmAnswer = 0}
, 
[37] = {id = 37, questionType = 2, questionTitle = "以下关于《复苏的魔女》的内容你看到过哪些？【多选】", 
selection = {"我都没有看过", "B站up主的安利视频", "抖音达人的趣味视频", "A站开屏/达人视频", "微博画师安利", "知乎上的活动", "官方Tap发布的内容", "官方B站号发布的内容", "其他"}
, multiCountMin = 1, multiCountMax = 9, confirmAnswer = 0}
, 
[38] = {id = 38, questionType = 2, questionTitle = "以下平台你经常使用的是哪些？【多选】", 
selection = {"微博", "百度贴吧", "NGA", "微信公众号", "B站", "QQ空间", "今日头条等新闻APP", "动漫之家等漫画APP", "抖音等短视频APP", "其他"}
, multiCountMin = 1, multiCountMax = 10, confirmAnswer = 0}
, 
[39] = {id = 39, questionType = 2, questionTitle = "你喜欢的游戏类型是？【多选】", 
selection = {"二次元游戏（如：明日方舟等）", "像素风游戏（如：克鲁塞德战记等）", "女性向游戏（如：恋与制作人等）", "日式RPG（如：另一个伊甸等）", "有魔女角色的游戏（如：爆裂魔女等）", "MMORPG(如：楚留香）", "放置挂机（如：剑与远征）", "Roguelike（如：不思议迷宫）", "音乐节奏（如：Cytus）", "SLG（如：率土之滨）", "其他"}
, multiCountMin = 1, multiCountMax = 11, confirmAnswer = 0}
, 
[40] = {id = 40, questionType = 1, questionTitle = "你的性别是？【单选】", 
selection = {"男", "女"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[41] = {id = 41, questionType = 1, questionTitle = "你的年龄是？【单选】", 
selection = {"16岁以下", "16-18岁", "19-23岁", "24岁-29岁", "30岁及以上"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
, 
[42] = {id = 42, questionType = 1, questionTitle = "你的职业是？【单选】", 
selection = {"在读学生（高中及以下）", "在读学生（大学及以上）", "民营/外企/私企公司员工", "国企/事业单位/公务员", "个体商户/自由职业者", "商场/餐饮等工作人员", "其他"}
, multiCountMin = 1, multiCountMax = 1, confirmAnswer = 0}
}
csurveyquestions.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42}
return csurveyquestions

