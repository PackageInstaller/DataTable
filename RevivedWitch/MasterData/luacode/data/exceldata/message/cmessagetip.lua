-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/message/cmessagetip.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cmessagetip = {}
cmessagetip.Data = {
[100001] = {id = 100001, msgType = 1, msg = "您获得了$parameter1$金币。", msgTextID = 700361}
, 
[100002] = {id = 100002, msgType = 1, msg = "您获得了$parameter1$钻石。", msgTextID = 700362}
, 
[100003] = {id = 100003, msgType = 1, msg = "账号不能为空。", msgTextID = 700363}
, 
[100004] = {id = 100004, msgType = 1, msg = "召唤失败。", msgTextID = 700364}
, 
[100005] = {id = 100005, msgType = 1, msg = "您的角色仓库已满，先进行清理才能继续召唤哦。", msgTextID = 700365}
, 
[100006] = {id = 100006, msgType = 1, msg = "当前剩余玛那不足。", msgTextID = 700366}
, 
[100007] = {id = 100007, msgType = 1, msg = "注入玛那已经到达极限了。", msgTextID = 700367}
, 
[100008] = {id = 100008, msgType = 1, msg = "目前没有可以删除的已读（已领取）邮件。", msgTextID = 700368}
, 
[100009] = {id = 100009, msgType = 1, msg = "不能购买更多物品了。", msgTextID = 700369}
, 
[100010] = {id = 100010, msgType = 1, msg = "没有可领取的邮件了。", msgTextID = 700370}
, 
[100011] = {id = 100011, msgType = 1, msg = "请先选择数量。", msgTextID = 700371}
, 
[100012] = {id = 100012, msgType = 1, msg = "目前没有可更换的装备。", msgTextID = 700372}
, 
[100013] = {id = 100013, msgType = 1, msg = "当前精神力不足。", msgTextID = 700373}
, 
[100014] = {id = 100014, msgType = 1, msg = "当前名字中含有限制字符。", msgTextID = 700374}
, 
[100015] = {id = 100015, msgType = 1, msg = "输入名字长度过短。", msgTextID = 701239}
, 
[100016] = {id = 100016, msgType = 1, msg = "输入名字长度过长。", msgTextID = 701240}
, 
[100017] = {id = 100017, msgType = 1, msg = "$parameter1$不足，不能进行召唤。", msgTextID = 700377}
, 
[100018] = {id = 100018, msgType = 1, msg = "灵魂破损人偶无法出战。", msgTextID = 700378}
, 
[100019] = {id = 100019, msgType = 1, msg = "目前没有可更换的技能", msgTextID = 700379}
, 
[100020] = {id = 100020, msgType = 1, msg = "账号在其他设备登录，已被迫下线。$B$（错误代码：$parameter1$）", msgTextID = 700380}
, 
[100021] = {id = 100021, msgType = 1, msg = "服务器连接异常，请稍后再试。$B$（错误代码：$parameter1$）", msgTextID = 700381}
, 
[100022] = {id = 100022, msgType = 1, msg = "网络连接异常。$B$（错误代码：$parameter1$）", msgTextID = 700382}
, 
[100023] = {id = 100023, msgType = 1, msg = "当前拥有$parameter1$非绑钻，$parameter1$绑钻。", msgTextID = 700383}
, 
[100024] = {id = 100024, msgType = 1, msg = "没有找到此好友。", msgTextID = 700384}
, 
[100025] = {id = 100025, msgType = 1, msg = "此人好像没有来到魔女世界呢。", msgTextID = 700385}
, 
[100026] = {id = 100026, msgType = 1, msg = "已发送申请！请等待对方通过。", msgTextID = 700386}
, 
[100027] = {id = 100027, msgType = 1, msg = "您已成功添加对方为好友。", msgTextID = 700387}
, 
[100028] = {id = 100028, msgType = 1, msg = "对方好友已满。", msgTextID = 700388}
, 
[100029] = {id = 100029, msgType = 1, msg = "不能添加对方为好友。", msgTextID = 700389}
, 
[100030] = {id = 100030, msgType = 1, msg = "队伍状态较差，建议返回初始之间。", msgTextID = 700390}
, 
[100031] = {id = 100031, msgType = 1, msg = "发送的消息不能为空。", msgTextID = 700391}
, 
[100032] = {id = 100032, msgType = 1, msg = "$parameter1$不足。", msgTextID = 700392}
, 
[100033] = {id = 100033, msgType = 1, msg = "当前活动已结束。", msgTextID = 700393}
, 
[100034] = {id = 100034, msgType = 1, msg = "介绍长度不可超过$parameter1$字。", msgTextID = 700394}
, 
[100035] = {id = 100035, msgType = 1, msg = "购买失败。", msgTextID = 700395}
, 
[100036] = {id = 100036, msgType = 1, msg = "无效或错误的激活码。", msgTextID = 700396}
, 
[100037] = {id = 100037, msgType = 1, msg = "此激活码已被使用。", msgTextID = 700397}
, 
[100038] = {id = 100038, msgType = 1, msg = "修改失败，可能存在限制词汇。", msgTextID = 700398}
, 
[100039] = {id = 100039, msgType = 1, msg = "购买成功。", msgTextID = 700399}
, 
[100040] = {id = 100040, msgType = 1, msg = "分解成功。", msgTextID = 700400}
, 
[100041] = {id = 100041, msgType = 1, msg = "输入消息长度不能超过$parameter1$字符。", msgTextID = 700401}
, 
[100042] = {id = 100042, msgType = 1, msg = "当前时间为：$parameter1$。", msgTextID = 700402}
, 
[100043] = {id = 100043, msgType = 1, msg = "不能添加自己。", msgTextID = 700403}
, 
[100044] = {id = 100044, msgType = 1, msg = "您的好友数量已达到上限。", msgTextID = 700404}
, 
[100045] = {id = 100045, msgType = 1, msg = "对方已经是您的好友。", msgTextID = 700405}
, 
[100046] = {id = 100046, msgType = 1, msg = "对方已在您的黑名单。", msgTextID = 700406}
, 
[100047] = {id = 100047, msgType = 1, msg = "无法熔炼更多装备。", msgTextID = 700407}
, 
[100048] = {id = 100048, msgType = 1, msg = "当前没有熔炼装备。", msgTextID = 700408}
, 
[100049] = {id = 100049, msgType = 1, msg = "当前材料不足。", msgTextID = 700409}
, 
[100050] = {id = 100050, msgType = 1, msg = "请先进行重铸操作。", msgTextID = 700410}
, 
[100051] = {id = 100051, msgType = 1, msg = "重铸中，请稍后再试。", msgTextID = 700411}
, 
[100052] = {id = 100052, msgType = 1, msg = "该ID无效。", msgTextID = 700412}
, 
[100053] = {id = 100053, msgType = 1, msg = "输入的手机号不符合规则。", msgTextID = 700413}
, 
[100054] = {id = 100054, msgType = 1, msg = "短信验证码已发送，请留意短信。", msgTextID = 700414}
, 
[100055] = {id = 100055, msgType = 1, msg = "短信验证码发送次数已达上限，请2小时后再试。", msgTextID = 700415}
, 
[100056] = {id = 100056, msgType = 1, msg = "短信验证码发送次数已达上限，请24小时后再试。", msgTextID = 700416}
, 
[100057] = {id = 100057, msgType = 1, msg = "验证码不可为空。", msgTextID = 700417}
, 
[100058] = {id = 100058, msgType = 1, msg = "短信验证码错误，请重新输入。", msgTextID = 700418}
, 
[100059] = {id = 100059, msgType = 1, msg = "发送内容不能为空。", msgTextID = 700419}
, 
[100060] = {id = 100060, msgType = 1, msg = "重复内容需等待一段时间才能继续发送。", msgTextID = 700420}
, 
[100061] = {id = 100061, msgType = 1, msg = "$parameter1$秒后才能再次发言。", msgTextID = 700421}
, 
[100062] = {id = 100062, msgType = 2, msg = "您获得了$parameter1$玛那。", msgTextID = 700422}
, 
[100063] = {id = 100063, msgType = 2, msg = "您获得了$parameter1$灵魂。", msgTextID = 700423}
, 
[100064] = {id = 100064, msgType = 1, msg = "发送失败。", msgTextID = 700424}
, 
[100065] = {id = 100065, msgType = 1, msg = "输入的邮箱不符合规则。", msgTextID = 700425}
, 
[100066] = {id = 100066, msgType = 1, msg = "验证码已发送，请留意邮件。", msgTextID = 700426}
, 
[100067] = {id = 100067, msgType = 1, msg = "验证码发送次数已达上限，请2小时后再试。", msgTextID = 700427}
, 
[100068] = {id = 100068, msgType = 1, msg = "验证码发送次数已达上限，请24小时后再试。", msgTextID = 700428}
, 
[100069] = {id = 100069, msgType = 1, msg = "验证码不可为空。", msgTextID = 700429}
, 
[100070] = {id = 100070, msgType = 1, msg = "验证码错误，请重新输入。", msgTextID = 700430}
, 
[100071] = {id = 100071, msgType = 1, msg = "该功能仍在开发中，敬请期待。", msgTextID = 700431}
, 
[100072] = {id = 100072, msgType = 1, msg = "当前装备强化次数已满。", msgTextID = 700432}
, 
[100073] = {id = 100073, msgType = 1, msg = "相同人偶仅能上阵一个。", msgTextID = 700433}
, 
[100074] = {id = 100074, msgType = 1, msg = "$parameter1$不足，无法购买。", msgTextID = 700434}
, 
[100075] = {id = 100075, msgType = 1, msg = "当前队伍生命值充足，不需要恢复。", msgTextID = 700435}
, 
[100076] = {id = 100076, msgType = 1, msg = "请编辑队伍并前往下一层吧。", msgTextID = 700436}
, 
[100077] = {id = 100077, msgType = 1, msg = "您的钻石不足。", msgTextID = 700437}
, 
[100078] = {id = 100078, msgType = 1, msg = "今日的祈愿任务刷新次数已用完。", msgTextID = 700438}
, 
[100079] = {id = 100079, msgType = 1, msg = "复制成功。", msgTextID = 700439}
, 
[100080] = {id = 100080, msgType = 1, msg = "探索中无法跳转", msgTextID = 700440}
, 
[100081] = {id = 100081, msgType = 1, msg = "剩余召唤次数不足。", msgTextID = 700441}
, 
[100082] = {id = 100082, msgType = 1, msg = "自动探索中无法打开人偶详情。", msgTextID = 700442}
, 
[100083] = {id = 100083, msgType = 1, msg = "请选择要分解的装备。", msgTextID = 700443}
, 
[100084] = {id = 100084, msgType = 1, msg = "您的抽卡道具不足。", msgTextID = 700444}
, 
[100085] = {id = 100085, msgType = 1, msg = "钥匙数量不足。", msgTextID = 700445}
, 
[100086] = {id = 100086, msgType = 1, msg = "今日体力兑换次数已达上限", msgTextID = 700446}
, 
[100087] = {id = 100087, msgType = 1, msg = "进化已达到上限。", msgTextID = 700447}
, 
[100088] = {id = 100088, msgType = 1, msg = "可同时进行的魔法树任务已达上限。", msgTextID = 700448}
, 
[100089] = {id = 100089, msgType = 1, msg = "可同时进行的探索任务已达上限。", msgTextID = 700449}
, 
[100090] = {id = 100090, msgType = 1, msg = "BOSS挑战不能使用助战", msgTextID = 700450}
, 
[100091] = {id = 100091, msgType = 1, msg = "挑战成功后才能查看", msgTextID = 700451}
, 
[100092] = {id = 100092, msgType = 1, msg = "魔法树$parameter1$级解锁。", msgTextID = 700452}
, 
[100093] = {id = 100093, msgType = 1, msg = "角色等级不足", msgTextID = 700453}
, 
[100094] = {id = 100094, msgType = 1, msg = "可派遣的萤火虫已达到上限。", msgTextID = 700454}
, 
[100095] = {id = 100095, msgType = 1, msg = "道具不足，无法添加任务。", msgTextID = 700455}
, 
[100096] = {id = 100096, msgType = 1, msg = "升级萤火灯台可解锁更高等级。", msgTextID = 700456}
, 
[100097] = {id = 100097, msgType = 1, msg = "升级萤火灯台可解锁更多萤火虫。", msgTextID = 700457}
, 
[100098] = {id = 100098, msgType = 1, msg = "冒险中无法升级人偶", msgTextID = 700458}
, 
[100099] = {id = 100099, msgType = 1, msg = "冒险中无法突破人偶", msgTextID = 700459}
, 
[100100] = {id = 100100, msgType = 1, msg = "冒险中无法进化人偶", msgTextID = 700460}
, 
[100101] = {id = 100101, msgType = 1, msg = "冒险中无法升级技能", msgTextID = 700461}
, 
[100102] = {id = 100102, msgType = 1, msg = "萤火虫数量达到上限", msgTextID = 700462}
, 
[100103] = {id = 100103, msgType = 1, msg = "请输入规定范围内的频道数字", msgTextID = 700463}
, 
[100104] = {id = 100104, msgType = 1, msg = "当前文字中含有限制字符。", msgTextID = 700464}
, 
[100105] = {id = 100105, msgType = 1, msg = "已达到最大等级。", msgTextID = 700465}
, 
[100106] = {id = 100106, msgType = 1, msg = "$parameter1$", msgTextID = 700466}
, 
[100107] = {id = 100107, msgType = 1, msg = "昵称修改成功！（24小时内不能再次修改）", msgTextID = 700467}
, 
[100108] = {id = 100108, msgType = 1, msg = "改名未超过24小时，无法修改昵称。", msgTextID = 700468}
, 
[100109] = {id = 100109, msgType = 1, msg = "刷新频率过快，$parameter1$秒后可再次刷新。", msgTextID = 700469}
, 
[100110] = {id = 100110, msgType = 1, msg = "请求频率过快。", msgTextID = 700470}
, 
[100111] = {id = 100111, msgType = 1, msg = "光点已收集，无需重复点击。", msgTextID = 700471}
, 
[100112] = {id = 100112, msgType = 1, msg = "任务所在关卡$parameter1$尚未开启。", msgTextID = 700472}
, 
[100113] = {id = 100113, msgType = 1, msg = "战斗超时，自动失败。", msgTextID = 700473}
, 
[100114] = {id = 100114, msgType = 1, msg = "最近一次登录无日志记录。", msgTextID = 700474}
, 
[100115] = {id = 100115, msgType = 1, msg = "货币不足，购买失败。", msgTextID = 700475}
, 
[100116] = {id = 100116, msgType = 1, msg = "商品已过期，购买失败。", msgTextID = 700476}
, 
[100117] = {id = 100117, msgType = 1, msg = "商品库存不足，购买失败。", msgTextID = 700477}
, 
[100118] = {id = 100118, msgType = 1, msg = "已达到最大等级。", msgTextID = 700478}
, 
[100119] = {id = 100119, msgType = 1, msg = "已拥有该外观。", msgTextID = 700479}
, 
[100120] = {id = 100120, msgType = 1, msg = "梦境螺旋活动未开启。", msgTextID = 700480}
, 
[100121] = {id = 100121, msgType = 1, msg = "无法为自己的评论点赞", msgTextID = 700481}
, 
[100122] = {id = 100122, msgType = 1, msg = "不可重复评论同一角色", msgTextID = 700482}
, 
[100123] = {id = 100123, msgType = 1, msg = "请输入35字以内的评论", msgTextID = 700483}
, 
[100124] = {id = 100124, msgType = 1, msg = "当前评论中含有限制字符", msgTextID = 700484}
, 
[100125] = {id = 100125, msgType = 1, msg = "请输入内容", msgTextID = 700485}
, 
[100126] = {id = 100126, msgType = 1, msg = "$parameter1$秒后才能再次评论", msgTextID = 700486}
, 
[100127] = {id = 100127, msgType = 1, msg = "操作过快", msgTextID = 700487}
, 
[100128] = {id = 100128, msgType = 1, msg = "战斗场景输入有误，请重新输入", msgTextID = 700488}
, 
[100129] = {id = 100129, msgType = 1, msg = "友情点不足。", msgTextID = 700489}
, 
[100130] = {id = 100130, msgType = 1, msg = "通关剧情$parameter1$后可购买礼包。", msgTextID = 700490}
, 
[100131] = {id = 100131, msgType = 1, msg = "激活码尝试次数过多。（错误代码：$parameter1$）", msgTextID = 700491}
, 
[100132] = {id = 100132, msgType = 1, msg = "检测当前账号异常，请联系客服。（错误代码：$parameter1$）", msgTextID = 700492}
, 
[100133] = {id = 100133, msgType = 1, msg = "当前账号被封禁，请联系客服。$parameter1$天$parameter1$时$parameter1$分$parameter1$秒", msgTextID = 700493}
, 
[100134] = {id = 100134, msgType = 1, msg = "当前账号因发布违规言论被禁言。 $parameter1$天$parameter1$时$parameter1$分$parameter1$秒", msgTextID = 700494}
, 
[100135] = {id = 100135, msgType = 1, msg = "当前账号因违规行为被禁止登录。 $parameter1$天$parameter1$时$parameter1$分$parameter1$秒", msgTextID = 700495}
, 
[100136] = {id = 100136, msgType = 1, msg = "当前账号因违规行为被禁止登录排行榜。 $parameter1$天$parameter1$时$parameter1$分$parameter1$秒", msgTextID = 700496}
, 
[100137] = {id = 100137, msgType = 1, msg = "通关剧情1-3解锁召唤。", msgTextID = 700497}
, 
[100138] = {id = 100138, msgType = 1, msg = "因为圣坛的效果，全体角色血量恢复50%", msgTextID = 700498}
, 
[100139] = {id = 100139, msgType = 1, msg = "通关剧情1-3解锁委托板。", msgTextID = 700499}
, 
[100140] = {id = 100140, msgType = 1, msg = "$parameter1$", msgTextID = 700500}
, 
[100141] = {id = 100141, msgType = 1, msg = "当前队伍存在状态不佳的角色，无法进入战斗", msgTextID = 700501}
, 
[100142] = {id = 100142, msgType = 1, msg = "当前角色状态不佳，不能编入队伍", msgTextID = 700502}
, 
[100143] = {id = 100143, msgType = 1, msg = "当前浮岛的事件已触发", msgTextID = 700503}
, 
[100144] = {id = 100144, msgType = 1, msg = "本周剩余挑战次数不足", msgTextID = 700504}
, 
[100145] = {id = 100145, msgType = 1, msg = "登录过于频繁，请稍后再试。", msgTextID = 700505}
, 
[100146] = {id = 100146, msgType = 1, msg = "0000", msgTextID = 700506}
, 
[100147] = {id = 100147, msgType = 1, msg = "1000", msgTextID = 700507}
, 
[100148] = {id = 100148, msgType = 1, msg = "1100", msgTextID = 700508}
, 
[100149] = {id = 100149, msgType = 1, msg = "1110", msgTextID = 700509}
, 
[100150] = {id = 100150, msgType = 1, msg = "1111", msgTextID = 700510}
, 
[100151] = {id = 100151, msgType = 1, msg = "当前层未完成，不能跳转", msgTextID = 700511}
, 
[100152] = {id = 100152, msgType = 1, msg = "您有正在挑战中的事象限界", msgTextID = 700512}
, 
[100153] = {id = 100153, msgType = 1, msg = "已完成手机号绑定", msgTextID = 700513}
, 
[100154] = {id = 100154, msgType = 1, msg = "已完成邮箱绑定", msgTextID = 700514}
, 
[100155] = {id = 100155, msgType = 1, msg = "魔法树等级不足。", msgTextID = 700515}
, 
[100156] = {id = 100156, msgType = 1, msg = "登录排队已满，请稍后再试。", msgTextID = 700516}
, 
[100157] = {id = 100157, msgType = 1, msg = "当前服务器繁忙，请稍后再试。", msgTextID = 700517}
, 
[100158] = {id = 100158, msgType = 1, msg = "当前没有可以兑换的魂石。", msgTextID = 700518}
, 
[100159] = {id = 100159, msgType = 1, msg = "登录失败，请等待$parameter1$秒后再次尝试。", msgTextID = 700519}
, 
[100160] = {id = 100160, msgType = 1, msg = "改名成功。", msgTextID = 700520}
, 
[100161] = {id = 100161, msgType = 3, msg = "根据您的实名认证信息，您未满$parameter1$周岁，无法购买。", msgTextID = 700537}
, 
[100162] = {id = 100162, msgType = 3, msg = "购买成功。由于您未满$parameter1$周岁，每月累计充值不得超过$parameter1$元人民币。$B$本月剩余充值额度：<color=#82C65D>$parameter1$</color>元。", msgTextID = 700538}
, 
[100163] = {id = 100163, msgType = 3, msg = "无法购买。由于您未满$parameter1$周岁，每月累计充值不得超过$parameter1$元人民币。$B$本月已充值<color=#FC3333>$parameter1$</color>元。", msgTextID = 700539}
, 
[100164] = {id = 100164, msgType = 3, msg = "无法购买。由于您未满$parameter1$周岁，单次充值不得超过$parameter1$元人民币。", msgTextID = 700540}
, 
[100165] = {id = 100165, msgType = 3, msg = "未检测到您的实名认证信息，无法购买。请先通过实名认证。", msgTextID = 700541}
, 
[100166] = {id = 100166, msgType = 1, msg = "当前服务器已满，请稍后再试。", msgTextID = 700546}
, 
[100167] = {id = 100167, msgType = 1, msg = "材料不足，无法继续添加", msgTextID = 700547}
, 
[100168] = {id = 100168, msgType = 1, msg = "材料不足，选择配方失败", msgTextID = 700548}
, 
[100169] = {id = 100169, msgType = 1, msg = "有重叠状态家具，不能添加到自定义主题", msgTextID = 700549}
, 
[100170] = {id = 100170, msgType = 1, msg = "有重叠状态家具", msgTextID = 700550}
, 
[100171] = {id = 100171, msgType = 1, msg = "没有刷新次数了，请再等等吧", msgTextID = 700551}
, 
[100172] = {id = 100172, msgType = 1, msg = "好感度已达最大值，不能继续送礼", msgTextID = 700602}
, 
[100173] = {id = 100173, msgType = 1, msg = "剩余召唤次数不足", msgTextID = 700604}
, 
[100174] = {id = 100174, msgType = 1, msg = "已发送好友申请，请勿重复申请。", msgTextID = 700607}
, 
[100175] = {id = 100175, msgType = 1, msg = "剩余刷新次数不足。", msgTextID = 700613}
, 
[100176] = {id = 100176, msgType = 1, msg = "通关剧情2-2开启人偶突破。", msgTextID = 700614}
, 
[100177] = {id = 100177, msgType = 1, msg = "通关剧情2-4开启装备突破。", msgTextID = 700615}
, 
[100178] = {id = 100178, msgType = 1, msg = "通关剧情2-10开启装备附魔。", msgTextID = 700616}
, 
[100179] = {id = 100179, msgType = 1, msg = "使用助战人偶可获得的友情点达到上限。", msgTextID = 700625}
, 
[100180] = {id = 100180, msgType = 1, msg = "此兑换码已被使用！", msgTextID = 700627}
, 
[100181] = {id = 100181, msgType = 1, msg = "已兑换过同类型的奖励！", msgTextID = 700628}
, 
[100182] = {id = 100182, msgType = 1, msg = "兑换码无效！", msgTextID = 700629}
, 
[100183] = {id = 100183, msgType = 1, msg = "兑换码不能为空！", msgTextID = 700630}
, 
[100184] = {id = 100184, msgType = 1, msg = "请先选择需要替换的属性。", msgTextID = 700637}
, 
[100185] = {id = 100185, msgType = 1, msg = "存在相同类型属性，无法附魔。", msgTextID = 700638}
, 
[100186] = {id = 100186, msgType = 1, msg = "频道人数已满。", msgTextID = 700651}
, 
[100187] = {id = 100187, msgType = 1, msg = "频道不可用。", msgTextID = 700652}
, 
[100189] = {id = 100189, msgType = 1, msg = "战斗验证失败", msgTextID = 700653}
, 
[100190] = {id = 100190, msgType = 1, msg = "该手机号已被绑定。", msgTextID = 700654}
, 
[100191] = {id = 100191, msgType = 1, msg = "未找到此玩家。", msgTextID = 700660}
, 
[100192] = {id = 100192, msgType = 1, msg = "通关剧情1-3解锁商城。", msgTextID = 700661}
, 
[100193] = {id = 100193, msgType = 1, msg = "不能添加对方为好友。", msgTextID = 700662}
, 
[100194] = {id = 100194, msgType = 1, msg = "账号已登出。", msgTextID = 700663}
, 
[100195] = {id = 100195, msgType = 1, msg = "通关剧情2-4后解锁魔女庭院。", msgTextID = 700664}
, 
[100196] = {id = 100196, msgType = 1, msg = "通关剧情1-3解锁召唤。", msgTextID = 700665}
, 
[100197] = {id = 100197, msgType = 1, msg = "当前没有可用家具。", msgTextID = 700666}
, 
[100198] = {id = 100198, msgType = 1, msg = "可用家具已全部摆放成功。", msgTextID = 700667}
, 
[100199] = {id = 100199, msgType = 1, msg = "获得时之音盒（主线2-2）后解锁梦境世界。", msgTextID = 700668}
, 
[100200] = {id = 100200, msgType = 1, msg = "服务器维护中。", msgTextID = 700669}
, 
[100201] = {id = 100201, msgType = 1, msg = "已复制本条评论信息，userID：$parameter1$，commentKey：$parameter1$，roleID：$parameter1$", msgTextID = 700670}
, 
[100202] = {id = 100202, msgType = 1, msg = "月卡购买数量达到上限，无法继续购买。", msgTextID = 700676}
, 
[100203] = {id = 100203, msgType = 1, msg = "升级条件未满足", msgTextID = 700693}
, 
[100204] = {id = 100204, msgType = 1, msg = "操作过于频繁，请稍后再试。", msgTextID = 700696}
, 
[100205] = {id = 100205, msgType = 1, msg = "该兑换码已过期。", msgTextID = 700697}
, 
[100206] = {id = 100206, msgType = 1, msg = "获得$parameter1$外观券。", msgTextID = 700703}
, 
[100207] = {id = 100207, msgType = 1, msg = "更换成功", msgTextID = 700704}
, 
[100208] = {id = 100208, msgType = 1, msg = "暂未获得此外观", msgTextID = 700705}
, 
[100209] = {id = 100209, msgType = 1, msg = "人偶派遣未满$parameter1$人，无法开始任务。", msgTextID = 700719}
, 
[100210] = {id = 100210, msgType = 1, msg = "通关剧情1-1解锁外观。", msgTextID = 700728}
, 
[100211] = {id = 100211, msgType = 1, msg = "通关剧情1-3解锁。", msgTextID = 700729}
, 
[100212] = {id = 100212, msgType = 1, msg = "对方待处理的好友申请已达上限", msgTextID = 700733}
, 
[100213] = {id = 100213, msgType = 1, msg = "发出的申请已达上限", msgTextID = 700734}
, 
[100214] = {id = 100214, msgType = 1, msg = "当前仅可选择下一个区域进行探索。", msgTextID = 700737}
, 
[100215] = {id = 100215, msgType = 1, msg = "由于过于火爆，世界聊天频道已暂时关闭。", msgTextID = 700745}
, 
[100216] = {id = 100216, msgType = 1, msg = "队伍中有位置仅有替补角色，是否自动补位？", msgTextID = 700750}
, 
[100217] = {id = 100217, msgType = 1, msg = "精神不足，无法进行战斗。", msgTextID = 700751}
, 
[100218] = {id = 100218, msgType = 1, msg = "$parameter1$级解锁。", msgTextID = 700752}
, 
[100219] = {id = 100219, msgType = 1, msg = "可派遣的萤火虫总数已增加", msgTextID = 700754}
, 
[100220] = {id = 100220, msgType = 1, msg = "材料不足，无法升级", msgTextID = 700755}
, 
[100221] = {id = 100221, msgType = 1, msg = "剩余可派遣萤火虫不足", msgTextID = 700756}
, 
[100222] = {id = 100222, msgType = 1, msg = "当前未收集$parameter1$", msgTextID = 700757}
, 
[100223] = {id = 100223, msgType = 1, msg = "$parameter1$已收集满，无法继续派遣", msgTextID = 700769}
, 
[100224] = {id = 100224, msgType = 1, msg = "$parameter1$数量不足，无法开始训练", msgTextID = 700778}
, 
[100225] = {id = 100225, msgType = 1, msg = "训练已终止", msgTextID = 700779}
, 
[100226] = {id = 100226, msgType = 1, msg = "队伍中存在被限制角色不能出战", msgTextID = 700784}
, 
[100227] = {id = 100227, msgType = 1, msg = "该角色被限制不能出战", msgTextID = 700791}
, 
[100228] = {id = 100228, msgType = 1, msg = "活动已结束", msgTextID = 700810}
, 
[100229] = {id = 100229, msgType = 1, msg = "人偶$parameter1$已被派遣至$parameter2$", msgTextID = 700813}
, 
[100230] = {id = 100230, msgType = 1, msg = "兑换成功", msgTextID = 700819}
, 
[100231] = {id = 100231, msgType = 1, msg = "购买成功", msgTextID = 700820}
, 
[100232] = {id = 100232, msgType = 1, msg = "魔力等级达到$parameter1$级开启该区域。", msgTextID = 700821}
, 
[100233] = {id = 100233, msgType = 1, msg = "今日兑换次数已达上限", msgTextID = 700822}
, 
[100234] = {id = 100234, msgType = 1, msg = "$parameter1$-$parameter2$现已开放！", msgTextID = 700825}
, 
[100235] = {id = 100235, msgType = 1, msg = "至少购买一件", msgTextID = 700832}
, 
[100236] = {id = 100236, msgType = 1, msg = "已达到购买数量上限", msgTextID = 700833}
, 
[100237] = {id = 100237, msgType = 1, msg = "附魔材料不足。", msgTextID = 700839}
, 
[100238] = {id = 100238, msgType = 1, msg = "完成首次充值任意金额即可领取奖励", msgTextID = 700852}
, 
[100239] = {id = 100239, msgType = 1, msg = "通关剧情2-13后即可领取奖励", msgTextID = 700853}
, 
[100240] = {id = 100240, msgType = 1, msg = "指定章节未解锁", msgTextID = 700854}
, 
[100241] = {id = 100241, msgType = 1, msg = "存在尚未完成的章节", msgTextID = 700855}
, 
[100242] = {id = 100242, msgType = 1, msg = "所需道具数量不足", msgTextID = 700856}
, 
[100243] = {id = 100243, msgType = 1, msg = "时空之钥不足，无法进行战斗。", msgTextID = 700857}
, 
[100244] = {id = 100244, msgType = 1, msg = "替补角色尚未解锁。", msgTextID = 700859}
, 
[100245] = {id = 100245, msgType = 1, msg = "通关剧情2-8解锁助战功能。", msgTextID = 700861}
, 
[100246] = {id = 100246, msgType = 1, msg = "属性加成已解锁", msgTextID = 700862}
, 
[100247] = {id = 100247, msgType = 1, msg = "$parameter1$已解锁", msgTextID = 700863}
, 
[100248] = {id = 100248, msgType = 1, msg = "$parameter1$已解锁", msgTextID = 700864}
, 
[100249] = {id = 100249, msgType = 1, msg = "当前无任何礼物，请通过商城购买和其他玩法中获得礼物", msgTextID = 700865}
, 
[100250] = {id = 100250, msgType = 1, msg = "好感度+$parameter1$", msgTextID = 700866}
, 
[100251] = {id = 100251, msgType = 1, msg = "好感度等级提升，请查看好感度奖励", msgTextID = 700867}
, 
[100252] = {id = 100252, msgType = 1, msg = "送礼过于频繁，请稍等一会", msgTextID = 700870}
, 
[100253] = {id = 100253, msgType = 1, msg = "至少赠送1件礼物", msgTextID = 700871}
, 
[100254] = {id = 100254, msgType = 1, msg = "已达到当前赠送上限", msgTextID = 700872}
, 
[100255] = {id = 100255, msgType = 1, msg = "继续升级需要魔力等级达到$parameter1$级", msgTextID = 700890}
, 
[100256] = {id = 100256, msgType = 1, msg = "时空精粹不足", msgTextID = 700891}
, 
[100257] = {id = 100257, msgType = 1, msg = "尚未解锁该断片", msgTextID = 700892}
, 
[100258] = {id = 100258, msgType = 1, msg = "尚未解锁事象记忆", msgTextID = 700893}
, 
[100259] = {id = 100259, msgType = 1, msg = "魔法树2级解锁", msgTextID = 700919}
, 
[100260] = {id = 100260, msgType = 1, msg = "魔法树3级解锁", msgTextID = 700920}
, 
[100261] = {id = 100261, msgType = 1, msg = "解锁条件未满足", msgTextID = 700921}
, 
[100262] = {id = 100262, msgType = 1, msg = "已增加$parameter1$天月卡天数。", msgTextID = 700927}
, 
[100263] = {id = 100263, msgType = 1, msg = "通关剧情1-4解锁。", msgTextID = 700928}
, 
[100264] = {id = 100264, msgType = 1, msg = "升级建筑需要魔法树等级达到$parameter1$级", msgTextID = 700931}
, 
[100265] = {id = 100265, msgType = 1, msg = "无符合关键字的主题", msgTextID = 700934}
, 
[100266] = {id = 100266, msgType = 1, msg = "今日剩余附魔次数不足", msgTextID = 700935}
, 
[100267] = {id = 100267, msgType = 1, msg = "当前公会人员已满", msgTextID = 700936}
, 
[100268] = {id = 100268, msgType = 1, msg = "当前公会已解散", msgTextID = 700937}
, 
[100269] = {id = 100269, msgType = 1, msg = "加入申请已经发出，敬请期待", msgTextID = 700938}
, 
[100270] = {id = 100270, msgType = 1, msg = "由于您已创建过一次公会，本次创建公会的价格将有所提升", msgTextID = 700939}
, 
[100271] = {id = 100271, msgType = 1, msg = "必须输入公会名称后才可继续创建", msgTextID = 700940}
, 
[100272] = {id = 100272, msgType = 1, msg = "您已经加入其它公会，请重新进入公会界面查看", msgTextID = 700941}
, 
[100273] = {id = 100273, msgType = 1, msg = "输入名称含有违规字符", msgTextID = 700942}
, 
[100274] = {id = 100274, msgType = 1, msg = "您已超出字数限制", msgTextID = 700943}
, 
[100275] = {id = 100275, msgType = 1, msg = "当前发言过快请等待", msgTextID = 700944}
, 
[100276] = {id = 100276, msgType = 1, msg = "距离您上次退出公会不满12小时，请在$parameter1$再次尝试", msgTextID = 700945}
, 
[100277] = {id = 100277, msgType = 1, msg = "您已超出字数限制", msgTextID = 700946}
, 
[100278] = {id = 100278, msgType = 1, msg = "输入宣言含有违规字符", msgTextID = 700947}
, 
[100279] = {id = 100279, msgType = 1, msg = "该玩家已经离开了公会", msgTextID = 700948}
, 
[100280] = {id = 100280, msgType = 1, msg = "你没有权限", msgTextID = 700949}
, 
[100281] = {id = 100281, msgType = 1, msg = "$parameter1$已经被移出了公会", msgTextID = 700950}
, 
[100282] = {id = 100282, msgType = 1, msg = "您已离开了$parameter1$公会，请加入其他魔女的公会吧", msgTextID = 700951}
, 
[100283] = {id = 100283, msgType = 1, msg = "会长必须辞去当前职务", msgTextID = 700952}
, 
[100284] = {id = 100284, msgType = 1, msg = "已达公会人数上限", msgTextID = 700953}
, 
[100285] = {id = 100285, msgType = 1, msg = "该玩家已加入其他公会", msgTextID = 700954}
, 
[100286] = {id = 100286, msgType = 1, msg = "该玩家已加入公会", msgTextID = 700955}
, 
[100287] = {id = 100287, msgType = 1, msg = "你没有权限", msgTextID = 700956}
, 
[100288] = {id = 100288, msgType = 1, msg = "该玩家退出上一个公会未满12小时", msgTextID = 700957}
, 
[100289] = {id = 100289, msgType = 1, msg = "未清理该层所有怪物时，不可使用自动探索", msgTextID = 700958}
, 
[100290] = {id = 100290, msgType = 1, msg = "您已提交过申请", msgTextID = 700995}
, 
[100291] = {id = 100291, msgType = 1, msg = "该公会当前申请已达到上限", msgTextID = 700999}
, 
[100292] = {id = 100292, msgType = 1, msg = "输入内容不能为空", msgTextID = 701005}
, 
[100293] = {id = 100293, msgType = 1, msg = "当前所有公会已提全部提交过申请", msgTextID = 701008}
, 
[100294] = {id = 100294, msgType = 1, msg = "通关间幕4.5-3解锁", msgTextID = 701010}
, 
[100295] = {id = 100295, msgType = 1, msg = "活跃度+$parameter1$", msgTextID = 701012}
, 
[100296] = {id = 100296, msgType = 1, msg = "关卡尚未开放", msgTextID = 701015}
, 
[100297] = {id = 100297, msgType = 1, msg = "通关简单模式全部关卡后解锁强化难度", msgTextID = 701016}
, 
[100298] = {id = 100298, msgType = 1, msg = "活动已结束", msgTextID = 701017}
, 
[100299] = {id = 100299, msgType = 1, msg = "该成员已是当前职位", msgTextID = 701019}
, 
[100300] = {id = 100300, msgType = 1, msg = "当前入住人偶均需要休息。", msgTextID = 701024}
, 
[100301] = {id = 100301, msgType = 1, msg = "没有符合条件的人偶。", msgTextID = 701025}
, 
[100302] = {id = 100302, msgType = 1, msg = "通关剧情2-8解锁好友功能", msgTextID = 701021}
, 
[100303] = {id = 100303, msgType = 1, msg = "请先将该玩家移出黑名单", msgTextID = 701022}
, 
[100304] = {id = 100304, msgType = 1, msg = "对方已在魔女大人的黑名单中了", msgTextID = 701023}
, 
[100305] = {id = 100305, msgType = 1, msg = "通关剧情$parameter1$后即可进入星辰幻镜", msgTextID = 701030}
, 
[100306] = {id = 100306, msgType = 1, msg = "举报成功", msgTextID = 701033}
, 
[100307] = {id = 100307, msgType = 1, msg = "请填写举报描述", msgTextID = 701038}
, 
[100308] = {id = 100308, msgType = 1, msg = "人偶状态已全部恢复", msgTextID = 701047}
, 
[100309] = {id = 100309, msgType = 1, msg = "当前职位委任人数已满", msgTextID = 701048}
, 
[100310] = {id = 100310, msgType = 1, msg = "您的权限不足", msgTextID = 701049}
, 
[100311] = {id = 100311, msgType = 1, msg = "仅能向人偶送礼。", msgTextID = 701050}
, 
[100312] = {id = 100312, msgType = 1, msg = "尚未解锁人偶送礼功能。", msgTextID = 701051}
, 
[100313] = {id = 100313, msgType = 1, msg = "前置节点未解锁。", msgTextID = 701052}
, 
[100314] = {id = 100314, msgType = 1, msg = "该外观已购买。", msgTextID = 701057}
, 
[100315] = {id = 100315, msgType = 1, msg = "技能未解锁。", msgTextID = 701060}
, 
[100316] = {id = 100316, msgType = 1, msg = "请先使用AABAA开头的兑换码。", msgTextID = 701066}
, 
[100317] = {id = 100317, msgType = 1, msg = "暂无套装效果", msgTextID = 701077}
, 
[100318] = {id = 100318, msgType = 1, msg = "操作过于频繁，请稍后再试。", msgTextID = 701079}
, 
[100319] = {id = 100319, msgType = 1, msg = "达到每日举报次数上限。", msgTextID = 701080}
, 
[100320] = {id = 100320, msgType = 1, msg = "抽卡次数达到上限。", msgTextID = 701085}
, 
[100321] = {id = 100321, msgType = 1, msg = "已通关当前主线全部章节，期待后续更新", msgTextID = 701086}
, 
[100322] = {id = 100322, msgType = 1, msg = "$parameter1$", msgTextID = 700466}
, 
[100323] = {id = 100323, msgType = 1, msg = "通关剧情1-2解锁人偶技能", msgTextID = 701087}
, 
[100324] = {id = 100324, msgType = 1, msg = "改名功能暂时无法使用。", msgTextID = 701098}
, 
[100325] = {id = 100325, msgType = 1, msg = "取名功能暂时无法使用。", msgTextID = 701099}
, 
[100326] = {id = 100326, msgType = 1, msg = "签名功能暂时无法使用。", msgTextID = 701100}
, 
[100327] = {id = 100327, msgType = 1, msg = "公会创建功能暂时无法使用。", msgTextID = 701101}
, 
[100328] = {id = 100328, msgType = 1, msg = "公会修改功能暂时无法使用。", msgTextID = 701102}
, 
[100329] = {id = 100329, msgType = 1, msg = "公会介绍功能正在维护中。", msgTextID = 701103}
, 
[100330] = {id = 100330, msgType = 1, msg = "公会公告功能正在维护中。", msgTextID = 701104}
, 
[100331] = {id = 100331, msgType = 1, msg = "人偶评论功能正在维护中。", msgTextID = 701105}
, 
[100332] = {id = 100332, msgType = 1, msg = "您的灵魂不足", msgTextID = 701117}
, 
[100333] = {id = 100333, msgType = 1, msg = "此邀请码无效", msgTextID = 701118}
, 
[100334] = {id = 100334, msgType = 1, msg = "邀请码使用次数已达上限", msgTextID = 701119}
, 
[100335] = {id = 100335, msgType = 1, msg = "游客模式下不可编辑该内容。", msgTextID = 701122}
, 
[100336] = {id = 100336, msgType = 1, msg = "游客模式下不可发布评论。", msgTextID = 701123}
, 
[100337] = {id = 100337, msgType = 1, msg = "游客模式下无法使用该功能。", msgTextID = 701124}
, 
[100338] = {id = 100338, msgType = 1, msg = "游客模式下无法使用该功能。", msgTextID = 701125}
, 
[100339] = {id = 100339, msgType = 1, msg = "游客模式下不可发言。", msgTextID = 701126}
, 
[100340] = {id = 100340, msgType = 1, msg = "游客模式下不可编辑该内容。", msgTextID = 701127}
, 
[100341] = {id = 100341, msgType = 1, msg = "达到每日搜索次数上限。", msgTextID = 701128}
, 
[100342] = {id = 100342, msgType = 1, msg = "该玩家为离线状态。", msgTextID = 701129}
, 
[100343] = {id = 100343, msgType = 1, msg = "当前没有可以加入的公会，请刷新后重试", msgTextID = 701136}
, 
[100344] = {id = 100344, msgType = 1, msg = "当前还没有任何公会", msgTextID = 701137}
, 
[100345] = {id = 100345, msgType = 1, msg = "玩家不可将自己添加为好友。", msgTextID = 701140}
, 
[100346] = {id = 100346, msgType = 1, msg = "玩家不可将自己加入黑名单。", msgTextID = 701141}
, 
[100347] = {id = 100347, msgType = 1, msg = "通关剧情1-2开启梦境螺旋。", msgTextID = 701142}
, 
[100348] = {id = 100348, msgType = 1, msg = "您有$parameter1$个$parameter1$已过期。", msgTextID = 701143}
, 
[100349] = {id = 100349, msgType = 1, msg = "装备等级未达到当前等级上限，无法进行突破。", msgTextID = 701159}
, 
[100350] = {id = 100350, msgType = 1, msg = "灵魂晶石不足，无法兑换。", msgTextID = 701160}
, 
[100351] = {id = 100351, msgType = 1, msg = "本关卡不能携带助战人偶", msgTextID = 701172}
, 
[100352] = {id = 100352, msgType = 1, msg = "该公会人数已满", msgTextID = 701181}
, 
[100353] = {id = 100353, msgType = 1, msg = "该活动还未开始，请在$B$<color=#FC3333>周六周日</color>$B$再来吧", msgTextID = 701182}
, 
[100354] = {id = 100354, msgType = 1, msg = "请至少捐赠一件道具", msgTextID = 701183}
, 
[100355] = {id = 100355, msgType = 1, msg = "您本周捐赠已达到上限，请下周再来", msgTextID = 701184}
, 
[100356] = {id = 100356, msgType = 1, msg = "您的公会币不足", msgTextID = 701185}
, 
[100357] = {id = 100357, msgType = 1, msg = "当前添加数量已达到上限", msgTextID = 701186}
, 
[100358] = {id = 100358, msgType = 1, msg = "为该玩家点了个赞，并收获了$parameter1$点友情点", msgTextID = 701173}
, 
[100359] = {id = 100359, msgType = 1, msg = "为该玩家点了个赞", msgTextID = 701174}
, 
[100360] = {id = 100360, msgType = 1, msg = "为$parameter1$名玩家点了个赞，并收获了$parameter1$点友情点", msgTextID = 701175}
, 
[100361] = {id = 100361, msgType = 1, msg = "您获得了$parameter1$点友情点", msgTextID = 701176}
, 
[100362] = {id = 100362, msgType = 1, msg = "当前没有友情点可供收取", msgTextID = 701177}
, 
[100363] = {id = 100363, msgType = 1, msg = "您今日收取友情点已达上限", msgTextID = 701178}
, 
[100364] = {id = 100364, msgType = 1, msg = "999999+", msgTextID = 701179}
, 
[100365] = {id = 100365, msgType = 1, msg = "公会即将降级请及时提升公会经验", msgTextID = 701180}
, 
[100366] = {id = 100366, msgType = 1, msg = "您当前无好友可以点赞", msgTextID = 701189}
, 
[100367] = {id = 100367, msgType = 1, msg = "您本次捐赠数量超出上限", msgTextID = 701190}
, 
[100368] = {id = 100368, msgType = 1, msg = "今日战斗次数已达上限", msgTextID = 701191}
, 
[100369] = {id = 100369, msgType = 1, msg = "该专属装备后续更新实装", msgTextID = 701213}
, 
[100370] = {id = 100370, msgType = 1, msg = "冒险中无法强化专属装备", msgTextID = 701214}
, 
[100371] = {id = 100371, msgType = 1, msg = "$parameter1$不足，无法购买$parameter1$", msgTextID = 701215}
, 
[100372] = {id = 100372, msgType = 1, msg = "未定之路开启中", msgTextID = 701227}
, 
[100373] = {id = 100373, msgType = 1, msg = "活动开启中", msgTextID = 701228}
, 
[100374] = {id = 100374, msgType = 1, msg = "通关剧情2-18解锁", msgTextID = 701229}
, 
[100375] = {id = 100375, msgType = 1, msg = "活动尚未开启，暂无通关记录可以查看", msgTextID = 701247}
, 
[100376] = {id = 100376, msgType = 1, msg = "通关3.5-2解锁专属装备", msgTextID = 701248}
, 
[100377] = {id = 100377, msgType = 1, msg = "请单击选择一个祝福", msgTextID = 701249}
, 
[100378] = {id = 100378, msgType = 1, msg = "当前$parameter1$不足。", msgTextID = 701306}
, 
[100379] = {id = 100379, msgType = 1, msg = "通关剧情2-2解锁。", msgTextID = 701307}
, 
[100380] = {id = 100380, msgType = 1, msg = "记忆碎片数量不足", msgTextID = 701326}
, 
[100381] = {id = 100381, msgType = 1, msg = "无法获得当前进度奖励，请解锁更多的拼图吧", msgTextID = 701327}
, 
[100382] = {id = 100382, msgType = 1, msg = "该宝箱空空如也", msgTextID = 701328}
, 
[100383] = {id = 100383, msgType = 1, msg = "当前阵容已替换至队伍1", msgTextID = 701329}
, 
[100384] = {id = 100384, msgType = 1, msg = "当前建筑已升至满级", msgTextID = 701331}
, 
[100385] = {id = 100385, msgType = 1, msg = "材料不足，无法升级", msgTextID = 701332}
, 
[100386] = {id = 100386, msgType = 1, msg = "所需材料不足。", msgTextID = 701350}
, 
[100387] = {id = 100387, msgType = 1, msg = "通关主线可解锁功能", msgTextID = 701371}
, 
[100388] = {id = 100388, msgType = 1, msg = "尚未建造【小卖部】", msgTextID = 701372}
, 
[100389] = {id = 100389, msgType = 1, msg = "尚未建造【小吃摊】", msgTextID = 701373}
, 
[100390] = {id = 100390, msgType = 1, msg = "尚未建造【陈列架】", msgTextID = 701374}
, 
[100391] = {id = 100391, msgType = 1, msg = "完成全部海岛任务，可进入下一阶段。", msgTextID = 701414}
, 
[100392] = {id = 100392, msgType = 1, msg = "材料不足，无法解锁建筑", msgTextID = 701417}
, 
[100393] = {id = 100393, msgType = 1, msg = "通关剧情$parameter1$后即可进入海岛冒险", msgTextID = 701420}
, 
[100394] = {id = 100394, msgType = 1, msg = "伤害达到指定数值后可领取该奖励", msgTextID = 701487}
, 
[100395] = {id = 100395, msgType = 1, msg = "事象限界升级中", msgTextID = 701488}
, 
[100396] = {id = 100396, msgType = 1, msg = "海岛冒险活动已结束。", msgTextID = 701494}
, 
[100397] = {id = 100397, msgType = 1, msg = "当前网络环境不稳定", msgTextID = 701495}
, 
[100398] = {id = 100398, msgType = 3, msg = "活动已结束。", msgTextID = 701499}
, 
[100399] = {id = 100399, msgType = 1, msg = "美味共享活动在11月04日 4:00开放。", msgTextID = 701500}
, 
[100400] = {id = 100400, msgType = 1, msg = "不给糖就捣蛋——不在活动时间内", msgTextID = 701514}
, 
[100401] = {id = 100401, msgType = 1, msg = "当前奖池已被清空。", msgTextID = 701517}
, 
[100402] = {id = 100402, msgType = 1, msg = "奖池已重置。", msgTextID = 701518}
, 
[100403] = {id = 100403, msgType = 1, msg = "南瓜数量不足", msgTextID = 701519}
, 
[100404] = {id = 100404, msgType = 1, msg = "当前梦境世界未开启", msgTextID = 701520}
, 
[100405] = {id = 100405, msgType = 1, msg = "时装已购买", msgTextID = 701521}
, 
[100406] = {id = 100406, msgType = 1, msg = "暂未持有此角色，获得后可更换此时装", msgTextID = 701522}
, 
[100407] = {id = 100407, msgType = 1, msg = "没有正在开放的活动", msgTextID = 701523}
, 
[100408] = {id = 100408, msgType = 1, msg = "不能跳转哦", msgTextID = 701524}
, 
[100409] = {id = 100409, msgType = 1, msg = "暂时没有受邀玩家", msgTextID = 701525}
, 
[100410] = {id = 100410, msgType = 1, msg = "活动已结束", msgTextID = 701538}
, 
[100411] = {id = 100411, msgType = 1, msg = "您的占卜水晶不足", msgTextID = 701537}
, 
[100412] = {id = 100412, msgType = 1, msg = "委托版功能未解锁", msgTextID = 701539}
, 
[100413] = {id = 100413, msgType = 1, msg = "暂无奖励", msgTextID = 701543}
, 
[100414] = {id = 100414, msgType = 1, msg = "活动已结束", msgTextID = 701544}
, 
[100415] = {id = 100415, msgType = 1, msg = "队伍中存在体力不足的人偶，不可出战", msgTextID = 701545}
, 
[100416] = {id = 100416, msgType = 1, msg = "将于2021年11月10日 12:00开服", msgTextID = 701547}
, 
[100417] = {id = 100417, msgType = 1, msg = "通关剧情2-2后开启奇妙万圣夜", msgTextID = 701548}
, 
[100418] = {id = 100418, msgType = 1, msg = "通关剧情2-13后开启", msgTextID = 701549}
, 
[100419] = {id = 100419, msgType = 1, msg = "通关剧情2-2后开启", msgTextID = 701550}
, 
[100420] = {id = 100420, msgType = 1, msg = "通关剧情2-13后开启", msgTextID = 701551}
, 
[100421] = {id = 100421, msgType = 1, msg = "活动暂未开启", msgTextID = 701572}
, 
[100422] = {id = 100422, msgType = 1, msg = "需要更新游戏版本，请前往下载最新客户端", msgTextID = 701573}
, 
[100423] = {id = 100423, msgType = 1, msg = "通关剧情2-2后开启", msgTextID = 701575}
, 
[100424] = {id = 100424, msgType = 1, msg = "今日任务已完成，明日再来吧", msgTextID = 701576}
, 
[100425] = {id = 100425, msgType = 1, msg = "服务器连接失败，请稍后再试", msgTextID = 701578}
, 
[100426] = {id = 100426, msgType = 1, msg = "所有任务已完成，记得领取奖励哦", msgTextID = 701582}
, 
[100427] = {id = 100427, msgType = 1, msg = "本关卡已通关", msgTextID = 701583}
, 
[100428] = {id = 100428, msgType = 1, msg = "尚未解锁本关卡", msgTextID = 701584}
, 
[100429] = {id = 100429, msgType = 1, msg = "请点击许愿图标，许个愿吧", msgTextID = 701590}
, 
[100430] = {id = 100430, msgType = 1, msg = "尚未满足购买条件", msgTextID = 701598}
, 
[100431] = {id = 100431, msgType = 1, msg = "尚未满足领取条件，请输入邀请码", msgTextID = 701599}
, 
[100432] = {id = 100432, msgType = 1, msg = "当前无预设装备", msgTextID = 701602}
, 
[100433] = {id = 100433, msgType = 1, msg = "该装备已预设超过6个角色", msgTextID = 701603}
, 
[100434] = {id = 100434, msgType = 1, msg = "$parameter1$秒后才能再次更换助战人偶", msgTextID = 701608}
, 
[100435] = {id = 100435, msgType = 1, msg = "$parameter1$评分需要达到$parameter2$解锁后续关卡", msgTextID = 701613}
, 
[100436] = {id = 100436, msgType = 1, msg = "$parameter1$$parameter2$$parameter3$评分需要全部达到$parameter4$解锁后续关卡", msgTextID = 701614}
, 
[100437] = {id = 100437, msgType = 1, msg = "$parameter1$评分达到$parameter2$解锁", msgTextID = 701615}
, 
[100438] = {id = 100438, msgType = 1, msg = "应援活动已结束啦，感谢支持Team Snow Memoria~", msgTextID = 701642}
, 
[100439] = {id = 100439, msgType = 1, msg = "通关剧情2-13后开启", msgTextID = 701643}
, 
[100440] = {id = 100440, msgType = 1, msg = "您的荧光棒不足", msgTextID = 701651}
, 
[100441] = {id = 100441, msgType = 1, msg = "活动商城将于12月23日开启", msgTextID = 701657}
, 
[100442] = {id = 100442, msgType = 1, msg = "今日挑战次数为0", msgTextID = 701658}
, 
[100443] = {id = 100443, msgType = 1, msg = "新春红包活动将于2月1日 4:00开放", msgTextID = 701682}
, 
[100444] = {id = 100444, msgType = 1, msg = "请选择人偶", msgTextID = 701691}
, 
[100445] = {id = 100445, msgType = 1, msg = "邀请码兑换成功，请领取礼包。", msgTextID = 701692}
, 
[100446] = {id = 100446, msgType = 1, msg = "您的钻石不足。", msgTextID = 701693}
, 
[100447] = {id = 100447, msgType = 1, msg = "通关活动战斗1-2后即可进入", msgTextID = 701698}
, 
[100448] = {id = 100448, msgType = 1, msg = "通关活动剧情1-5后即可进入", msgTextID = 701699}
, 
[100449] = {id = 100449, msgType = 1, msg = "通关活动剧情3-8后即可进入", msgTextID = 701700}
, 
[100450] = {id = 100450, msgType = 1, msg = "通关主线$parameter1$后即可进入", msgTextID = 701701}
, 
[100451] = {id = 100451, msgType = 1, msg = "活动已结束，请尽快兑换奖励", msgTextID = 701710}
, 
[100452] = {id = 100452, msgType = 1, msg = "活动已结束", msgTextID = 701712}
, 
[100453] = {id = 100453, msgType = 1, msg = "道具不足", msgTextID = 701716}
, 
[100454] = {id = 100454, msgType = 1, msg = "邀请玩家以获得折扣优惠", msgTextID = 701721}
, 
[100455] = {id = 100455, msgType = 1, msg = "活动已结束", msgTextID = 701765}
, 
[100456] = {id = 100456, msgType = 1, msg = "请5秒后再次赠送", msgTextID = 701775}
, 
[100457] = {id = 100457, msgType = 1, msg = "所需材料不足。", msgTextID = 701779}
, 
[100458] = {id = 100458, msgType = 1, msg = "贺岁大礼活动将于1月27日 04:00:00开放", msgTextID = 701781}
, 
[100459] = {id = 100459, msgType = 1, msg = "注入玛那已经到达极限了。", msgTextID = 701805}
, 
[100460] = {id = 100460, msgType = 1, msg = "当前剩余玛那或材料不足。", msgTextID = 701806}
, 
[100461] = {id = 100461, msgType = 1, msg = "精品商城已结束。", msgTextID = 701828}
, 
[100462] = {id = 100462, msgType = 1, msg = "请先完成前一张拼图", msgTextID = 701837}
, 
[100463] = {id = 100463, msgType = 1, msg = "您的钻石不足。", msgTextID = 701867}
, 
[100464] = {id = 100464, msgType = 1, msg = "剩余挑战次数不足", msgTextID = 701880}
, 
[100465] = {id = 100465, msgType = 1, msg = "当前风车数量不足", msgTextID = 701892}
, 
[100466] = {id = 100466, msgType = 1, msg = "当前角色在助战中无法重塑", msgTextID = 701902}
, 
[100467] = {id = 100467, msgType = 1, msg = "活动已经结束啦，剩余铜币可兑换为玛那", msgTextID = 701914}
, 
[100468] = {id = 100468, msgType = 1, msg = "当前铜币数量不足", msgTextID = 701906}
, 
[100469] = {id = 100469, msgType = 1, msg = "活动商城已关闭", msgTextID = 701924}
, 
[100470] = {id = 100470, msgType = 1, msg = "当前副本挑战次数已满。", msgTextID = 701933}
, 
[100471] = {id = 100471, msgType = 1, msg = "今日派遣次数已达上限。", msgTextID = 701972}
, 
[100472] = {id = 100472, msgType = 1, msg = "派遣功能不能使用助战。", msgTextID = 701973}
, 
[100473] = {id = 100473, msgType = 1, msg = "关卡通关后解锁", msgTextID = 701996}
, 
[100474] = {id = 100474, msgType = 1, msg = "已有派遣进行中", msgTextID = 701997}
, 
[100475] = {id = 100475, msgType = 1, msg = "请先领取奖励", msgTextID = 701998}
, 
[100476] = {id = 100476, msgType = 1, msg = "当前处于结算时间", msgTextID = 702015}
, 
[100477] = {id = 100477, msgType = 1, msg = "不在活动时间内，无法购买。", msgTextID = 702019}
, 
[100478] = {id = 100478, msgType = 1, msg = "剩余天数不足，购买失败。", msgTextID = 702074}
, 
[100479] = {id = 100479, msgType = 1, msg = "当前活动已结束。", msgTextID = 702140}
, 
[100480] = {id = 100480, msgType = 1, msg = "通关3-18解锁素体进阶功能", msgTextID = 702144}
, 
[100481] = {id = 100481, msgType = 1, msg = "您的材料不足", msgTextID = 702161}
, 
[100482] = {id = 100482, msgType = 1, msg = "当前道具数量不足，请前往每日任务获取", msgTextID = 702198}
, 
[100483] = {id = 100483, msgType = 1, msg = "您的$parameter1$药剂不足", msgTextID = 702216}
, 
[100484] = {id = 100484, msgType = 1, msg = "纹章平均等级大于lv.$parameter1$后提升最大等级上限", msgTextID = 702221}
, 
[100485] = {id = 100485, msgType = 1, msg = "本次活动已关闭", msgTextID = 702228}
, 
[100486] = {id = 100486, msgType = 1, msg = "已拥有外观", msgTextID = 702241}
, 
[100487] = {id = 100487, msgType = 1, msg = "本次活动已关闭", msgTextID = 702246}
, 
[100488] = {id = 100488, msgType = 1, msg = "已拥有外观", msgTextID = 702259}
, 
[100489] = {id = 100489, msgType = 1, msg = "通关剧情2-2开启", msgTextID = 702261}
, 
[100490] = {id = 100490, msgType = 1, msg = "活动已结束。", msgTextID = 702262}
, 
[100491] = {id = 100491, msgType = 1, msg = "7月7日 04:00后开启", msgTextID = 702264}
, 
[100492] = {id = 100492, msgType = 1, msg = "系统维护升级，可能有部分玩家的发言功能会受到影响", msgTextID = 702267}
, 
[100493] = {id = 100493, msgType = 1, msg = "精神之证购买数量达到上限，无法继续购买。", msgTextID = 702311}
, 
[100494] = {id = 100494, msgType = 1, msg = "城堡商店9月15日04:00开启", msgTextID = 702385}
, 
[100495] = {id = 100495, msgType = 1, msg = "通关剧情3-5开启", msgTextID = 702499}
, 
[100496] = {id = 100496, msgType = 3, msg = "充值服务已关闭", msgTextID = 702500}
, 
[100497] = {id = 100497, msgType = 3, msg = "新用户登陆已关闭", msgTextID = 702501}
, 
[100498] = {id = 100498, msgType = 1, msg = "当前活动已结束。", msgTextID = 702512}
, 
[100499] = {id = 100499, msgType = 1, msg = "当前目标暂不可挑战", msgTextID = 702562}
, 
[100500] = {id = 100500, msgType = 1, msg = "剩余战斗次数不足，无法挑战", msgTextID = 702566}
, 
[100501] = {id = 100501, msgType = 1, msg = "boss已被击败", msgTextID = 702567}
, 
[100502] = {id = 100502, msgType = 1, msg = "至少拥有一次挑战记录才可使用跳过战斗功能", msgTextID = 702568}
, 
[100503] = {id = 100503, msgType = 3, msg = "是否跳过战斗直接对$parameter1$造成$parameter2$伤害？", msgTextID = 702569}
, 
[100504] = {id = 100504, msgType = 1, msg = "无法重复挑战同一个boss", msgTextID = 702570}
, 
[100505] = {id = 100505, msgType = 1, msg = "活动正在结算中，$parameter1$开放新赛季。", msgTextID = 702575}
, 
[100506] = {id = 100506, msgType = 1, msg = "尚无可领取奖励。", msgTextID = 702576}
, 
[100507] = {id = 100507, msgType = 1, msg = "刷新过快，请稍后再进行刷新。", msgTextID = 702577}
, 
[100508] = {id = 100508, msgType = 1, msg = "当前尚未设置攻击/防守阵容，无法进行挑战，请先设置对应阵容。", msgTextID = 702578}
, 
[100509] = {id = 100509, msgType = 1, msg = "刷新成功！", msgTextID = 702582}
, 
[100510] = {id = 100510, msgType = 1, msg = "活动已结束。", msgTextID = 702584}
, 
[100511] = {id = 100511, msgType = 1, msg = "需要加入一个公会。", msgTextID = 702586}
}
cmessagetip.AllIds = {100001, 100002, 100003, 100004, 100005, 100006, 100007, 100008, 100009, 100010, 100011, 100012, 100013, 100014, 100015, 100016, 100017, 100018, 100019, 100020, 100021, 100022, 100023, 100024, 100025, 100026, 100027, 100028, 100029, 100030, 100031, 100032, 100033, 100034, 100035, 100036, 100037, 100038, 100039, 100040, 100041, 100042, 100043, 100044, 100045, 100046, 100047, 100048, 100049, 100050, 100051, 100052, 100053, 100054, 100055, 100056, 100057, 100058, 100059, 100060, 100061, 100062, 100063, 100064, 100065, 100066, 100067, 100068, 100069, 100070, 100071, 100072, 100073, 100074, 100075, 100076, 100077, 100078, 100079, 100080, 100081, 100082, 100083, 100084, 100085, 100086, 100087, 100088, 100089, 100090, 100091, 100092, 100093, 100094, 100095, 100096, 100097, 100098, 100099, 100100, 100101, 100102, 100103, 100104, 100105, 100106, 100107, 100108, 100109, 100110, 100111, 100112, 100113, 100114, 100115, 100116, 100117, 100118, 100119, 100120, 100121, 100122, 100123, 100124, 100125, 100126, 100127, 100128, 100129, 100130, 100131, 100132, 100133, 100134, 100135, 100136, 100137, 100138, 100139, 100140, 100141, 100142, 100143, 100144, 100145, 100146, 100147, 100148, 100149, 100150, 100151, 100152, 100153, 100154, 100155, 100156, 100157, 100158, 100159, 100160, 100161, 100162, 100163, 100164, 100165, 100166, 100167, 100168, 100169, 100170, 100171, 100172, 100173, 100174, 100175, 100176, 100177, 100178, 100179, 100180, 100181, 100182, 100183, 100184, 100185, 100186, 100187, 100189, 100190, 100191, 100192, 100193, 100194, 100195, 100196, 100197, 100198, 100199, 100200, 100201, 100202, 100203, 100204, 100205, 100206, 100207, 100208, 100209, 100210, 100211, 100212, 100213, 100214, 100215, 100216, 100217, 100218, 100219, 100220, 100221, 100222, 100223, 100224, 100225, 100226, 100227, 100228, 100229, 100230, 100231, 100232, 100233, 100234, 100235, 100236, 100237, 100238, 100239, 100240, 100241, 100242, 100243, 100244, 100245, 100246, 100247, 100248, 100249, 100250, 100251, 100252, 100253, 100254, 100255, 100256, 100257, 100258, 100259, 100260, 100261, 100262, 100263, 100264, 100265, 100266, 100267, 100268, 100269, 100270, 100271, 100272, 100273, 100274, 100275, 100276, 100277, 100278, 100279, 100280, 100281, 100282, 100283, 100284, 100285, 100286, 100287, 100288, 100289, 100290, 100291, 100292, 100293, 100294, 100295, 100296, 100297, 100298, 100299, 100300, 100301, 100302, 100303, 100304, 100305, 100306, 100307, 100308, 100309, 100310, 100311, 100312, 100313, 100314, 100315, 100316, 100317, 100318, 100319, 100320, 100321, 100322, 100323, 100324, 100325, 100326, 100327, 100328, 100329, 100330, 100331, 100332, 100333, 100334, 100335, 100336, 100337, 100338, 100339, 100340, 100341, 100342, 100343, 100344, 100345, 100346, 100347, 100348, 100349, 100350, 100351, 100352, 100353, 100354, 100355, 100356, 100357, 100358, 100359, 100360, 100361, 100362, 100363, 100364, 100365, 100366, 100367, 100368, 100369, 100370, 100371, 100372, 100373, 100374, 100375, 100376, 100377, 100378, 100379, 100380, 100381, 100382, 100383, 100384, 100385, 100386, 100387, 100388, 100389, 100390, 100391, 100392, 100393, 100394, 100395, 100396, 100397, 100398, 100399, 100400, 100401, 100402, 100403, 100404, 100405, 100406, 100407, 100408, 100409, 100410, 100411, 100412, 100413, 100414, 100415, 100416, 100417, 100418, 100419, 100420, 100421, 100422, 100423, 100424, 100425, 100426, 100427, 100428, 100429, 100430, 100431, 100432, 100433, 100434, 100435, 100436, 100437, 100438, 100439, 100440, 100441, 100442, 100443, 100444, 100445, 100446, 100447, 100448, 100449, 100450, 100451, 100452, 100453, 100454, 100455, 100456, 100457, 100458, 100459, 100460, 100461, 100462, 100463, 100464, 100465, 100466, 100467, 100468, 100469, 100470, 100471, 100472, 100473, 100474, 100475, 100476, 100477, 100478, 100479, 100480, 100481, 100482, 100483, 100484, 100485, 100486, 100487, 100488, 100489, 100490, 100491, 100492, 100493, 100494, 100495, 100496, 100497, 100498, 100499, 100500, 100501, 100502, 100503, 100504, 100505, 100506, 100507, 100508, 100509, 100510, 100511}
return cmessagetip

