__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TipsType = readonly({
  TipsType_100001_Desc = {
    Text = "切换分辨率后需重启客户端才能生效，是否确认？"
  },
  TipsType_100001_LeftBtnDesc = {Text = "取消"},
  TipsType_100001_RightBtnDesc = {Text = "确认"},
  TipsType_100001_Title = {
    Text = "切换分辨率确认"
  },
  TipsType_100002_Desc = {
    Text = "正在等待 {s1} 接受再来一局邀请"
  },
  TipsType_100002_RightBtnDesc = {Text = "取消"},
  TipsType_100002_Title = {
    Text = "再来一局"
  },
  TipsType_100003_Desc = {
    Text = "{s1} 邀请你再来一局"
  },
  TipsType_100003_LeftBtnDesc = {Text = "拒绝"},
  TipsType_100003_RightBtnDesc = {Text = "接受"},
  TipsType_100003_Title = {
    Text = "再来一局"
  },
  TipsType_100004_Desc = {
    Text = "已经是当前宿舍背景"
  },
  TipsType_100005_Desc = {
    Text = "相位对弈玩法未开启"
  },
  TipsType_100006_Desc = {
    Text = "对方相位对弈玩法未开启"
  },
  TipsType_100007_Desc = {
    Text = "互相关注才能发起友谊赛"
  },
  TipsType_100008_Desc = {
    Text = "对方已离线"
  },
  TipsType_100009_Desc = {
    Text = "对方正在探索中"
  },
  TipsType_100010_Desc = {
    Text = "友谊赛等待超时"
  },
  TipsType_100011_Desc = {
    Text = "你已取消友谊赛"
  },
  TipsType_100012_Desc = {
    Text = "友谊赛邀请被拒绝"
  },
  TipsType_100012_LeftBtnDesc = {Text = "确认"},
  TipsType_100012_Title = {Text = "提示"},
  TipsType_100013_Desc = {
    Text = "对方已离线"
  },
  TipsType_100014_Desc = {
    Text = "对方已进入其他玩法"
  },
  TipsType_100015_Desc = {
    Text = "邀请过于频繁，{s1}秒后重试"
  },
  TipsType_100016_Desc = {
    Text = "对方已取消友谊赛"
  },
  TipsType_100016_LeftBtnDesc = {Text = "确认"},
  TipsType_100016_Title = {Text = "提示"},
  TipsType_100017_Desc = {
    Text = "该玩家正在进行友谊赛"
  },
  TipsType_100017_LeftBtnDesc = {Text = "确认"},
  TipsType_100017_Title = {Text = "提示"},
  TipsType_100018_Desc = {
    Text = "此编队包含限时使用的卡牌，需要解锁本期核心课题才可继续使用，期待与你再次并肩作战！\n是否前往解锁核心课题？"
  },
  TipsType_100018_LeftBtnDesc = {Text = "取消"},
  TipsType_100018_RightBtnDesc = {Text = "确认"},
  TipsType_100018_Title = {
    Text = "核心课题已过期"
  },
  TipsType_10001_Desc = {
    Text = "操作成功"
  },
  TipsType_100020_Desc = {
    Text = "尚在战斗中，是否继续之前的战斗？"
  },
  TipsType_100020_LeftBtnDesc = {Text = "取消"},
  TipsType_100020_RightBtnDesc = {Text = "确认"},
  TipsType_100020_Title = {Text = "提示"},
  TipsType_10002_Desc = {
    Text = "配置表错误"
  },
  TipsType_10003_Desc = {
    Text = "客户端传入数据错误"
  },
  TipsType_10004_Desc = {
    Text = "服务器未启动"
  },
  TipsType_10005_Desc = {
    Text = "角色数据错误"
  },
  TipsType_10006_Desc = {
    Text = "没有找到唤醒体数据"
  },
  TipsType_10007_Desc = {
    Text = "唤醒体已达最高等级"
  },
  TipsType_10008_Desc = {
    Text = "没有足够的课题分"
  },
  TipsType_10009_Desc = {
    Text = "唤醒体未达最高等级，无法启灵"
  },
  TipsType_100100_Desc = {
    Text = "游戏当前有版本更新，若未自动更新，请尝试重启 Steam 后检查更新。"
  },
  TipsType_100100_RightBtnDesc = {Text = "确认"},
  TipsType_100100_Title = {
    Text = "更新提示"
  },
  TipsType_10010_Desc = {
    Text = "已完成启灵"
  },
  TipsType_10011_Desc = {
    Text = "当前未创建角色"
  },
  TipsType_10012_Desc = {
    Text = "当前已有角色"
  },
  TipsType_10013_Desc = {
    Text = "角色名重复"
  },
  TipsType_10014_Desc = {
    Text = "密境区域错误"
  },
  TipsType_10015_Desc = {
    Text = "无法定位密境区域"
  },
  TipsType_10016_Desc = {
    Text = "当前体力过低"
  },
  TipsType_10017_Desc = {
    Text = "{s1}到{s2}可解锁"
  },
  TipsType_10018_Desc = {
    Text = "抵达此密境第二层1次后，可进行快速调查"
  },
  TipsType_10019_Desc = {
    Text = "事件已完成"
  },
  TipsType_10020_Desc = {
    Text = "事件配置表中类型填写错误"
  },
  TipsType_10021_Desc = {
    Text = "事件不存在"
  },
  TipsType_10022_Desc = {
    Text = "黑印不足无法购买"
  },
  TipsType_10023_Desc = {
    Text = "此卡无法强化"
  },
  TipsType_10024_Desc = {
    Text = "此卡已达强化上限"
  },
  TipsType_10025_Desc = {
    Text = "行商不售卖此商品"
  },
  TipsType_10026_Desc = {
    Text = "无此奖励"
  },
  TipsType_10027_Desc = {
    Text = "奖励已领取"
  },
  TipsType_10028_Desc = {
    Text = "事件数据错误"
  },
  TipsType_10029_Desc = {
    Text = "商品已购买"
  },
  TipsType_10030_Desc = {
    Text = "当前能量不足以启动传送门，启动传送门需要{s1}点能量。"
  },
  TipsType_10031_Desc = {
    Text = "未找到剧情对话事件"
  },
  TipsType_10032_Desc = {
    Text = "事件选择指令卡数量不足"
  },
  TipsType_10033_Desc = {
    Text = "事件选择指令卡数量过多"
  },
  TipsType_10034_Desc = {
    Text = "事件选择指令卡不存在"
  },
  TipsType_10035_Desc = {
    Text = "随机事件池中无数据"
  },
  TipsType_10036_Desc = {
    Text = "行商不售卖此商品"
  },
  TipsType_10037_Desc = {
    Text = "事件选择造物数量不足"
  },
  TipsType_10038_Desc = {
    Text = "事件选择造物数量过多"
  },
  TipsType_10039_Desc = {
    Text = "事件选择造物不存在"
  },
  TipsType_10040_Desc = {
    Text = "未找到此事件节点"
  },
  TipsType_10041_Desc = {
    Text = "行商刷新次数已用尽"
  },
  TipsType_10042_Desc = {
    Text = "战斗掉落指令卡刷新次数已用尽"
  },
  TipsType_10043_Desc = {
    Text = "战斗掉落造物刷新次数已用尽"
  },
  TipsType_10044_Desc = {
    Text = "联络点功能被锁"
  },
  TipsType_10045_Desc = {
    Text = "事件区域不匹配！当前区域：{s1}，事件配置区域：{s2}"
  },
  TipsType_10046_Desc = {
    Text = "事件商店删除卡牌次数已用完"
  },
  TipsType_10047_Desc = {
    Text = "未找到课题单元数据"
  },
  TipsType_10048_Desc = {
    Text = "单元已提交，无需再次提交"
  },
  TipsType_10049_Desc = {
    Text = "单元下的课题尚未全部完成，无法提交"
  },
  TipsType_10050_Desc = {
    Text = "未找到课题模块"
  },
  TipsType_10051_Desc = {
    Text = "关卡没有课题数据"
  },
  TipsType_10052_Desc = {
    Text = "没有此密境对应的课题"
  },
  TipsType_10053_Desc = {
    Text = "学分不足，无法领取奖励"
  },
  TipsType_10054_Desc = {
    Text = "学分奖励尚未达到领取条件"
  },
  TipsType_10055_Desc = {
    Text = "课题分尚未找到任务"
  },
  TipsType_10056_Desc = {
    Text = "课题分任务已完成"
  },
  TipsType_10057_Desc = {
    Text = "课题分任务中的子任务未完成"
  },
  TipsType_10058_Desc = {
    Text = "NPC已被触发"
  },
  TipsType_10059_Desc = {
    Text = "NPC数据错误"
  },
  TipsType_10060_Desc = {
    Text = "NPC不存在"
  },
  TipsType_10061_Desc = {
    Text = "密境中未发现"
  },
  TipsType_10062_Desc = {
    Text = "未发现共鸣数据"
  },
  TipsType_10063_Desc = {
    Text = "共鸣已达最大等级"
  },
  TipsType_10064_Desc = {
    Text = "未发现共鸣等级相关数据"
  },
  TipsType_10065_Desc = {
    Text = "无重置次数"
  },
  TipsType_10066_Desc = {
    Text = "未达到激活共鸣条件"
  },
  TipsType_10067_Desc = {
    Text = "共鸣粒子不足"
  },
  TipsType_10068_Desc = {
    Text = "启灵已完成，无法再次启灵"
  },
  TipsType_10069_Desc = {
    Text = "启灵所需素材不足"
  },
  TipsType_10070_Desc = {
    Text = "唤醒体升级所需素材不足"
  },
  TipsType_10071_Desc = {
    Text = "唤醒体升级所需金券不足"
  },
  TipsType_10072_Desc = {
    Text = "唤醒体升级所需金券不足"
  },
  TipsType_10073_Desc = {
    Text = "无唤醒体技能"
  },
  TipsType_10074_Desc = {
    Text = "尚未解锁唤醒体技能"
  },
  TipsType_10075_Desc = {
    Text = "唤醒所需的「银芯」不足"
  },
  TipsType_10076_Desc = {
    Text = "物品不足"
  },
  TipsType_10077_Desc = {
    Text = "今日购买次数已达上限"
  },
  TipsType_10078_Desc = {
    Text = "物品不可使用"
  },
  TipsType_10079_Desc = {
    Text = "物品使用数量错误"
  },
  TipsType_10080_Desc = {
    Text = "技能已达到最大等级"
  },
  TipsType_10081_Desc = {
    Text = "素材不足，无法升级。"
  },
  TipsType_10082_Desc = {
    Text = "货币不足，无法升级。"
  },
  TipsType_10083_Desc = {
    Text = "唤醒体连接率已到达最高等级"
  },
  TipsType_10084_Desc = {
    Text = "该唤醒体同源精神不足"
  },
  TipsType_10085_Desc = {
    Text = "升级路线没有配置角色id"
  },
  TipsType_10086_Desc = {
    Text = "找不到指定专属卡信息"
  },
  TipsType_10087_Desc = {
    Text = "指定专属卡未解锁"
  },
  TipsType_10088_Desc = {
    Text = "找不到该专属卡uuid"
  },
  TipsType_10089_Desc = {
    Text = "章节奖励未达到积分"
  },
  TipsType_10090_Desc = {
    Text = "章节奖励已领取"
  },
  TipsType_10091_Desc = {
    Text = "选择的剧情线尚未解锁"
  },
  TipsType_10092_Desc = {
    Text = "选择的副本尚未解锁"
  },
  TipsType_10093_Desc = {
    Text = "副本区域尚未解锁"
  },
  TipsType_10094_Desc = {
    Text = "剧情线扫荡尚未解锁"
  },
  TipsType_10095_Desc = {
    Text = "未找到副本挑战的剧情线"
  },
  TipsType_10096_Desc = {
    Text = "未找到副本挑战的剧情线任务"
  },
  TipsType_10097_Desc = {
    Text = "挑战任务已完成,无法再次领取奖励"
  },
  TipsType_10098_Desc = {
    Text = "挑战任务尚未完成,无法领取奖励"
  },
  TipsType_10099_Desc = {
    Text = "建筑不存在"
  },
  TipsType_10100_Desc = {
    Text = "建筑已到达最大等级"
  },
  TipsType_10101_Desc = {
    Text = "升级/建设建筑条件不足"
  },
  TipsType_10102_Desc = {
    Text = "建筑已存在不能再次建设"
  },
  TipsType_10103_Desc = {
    Text = "升级/建设所需要的的道具不足"
  },
  TipsType_10104_Desc = {
    Text = "位置已存在唤醒体,无法入驻"
  },
  TipsType_10105_Desc = {
    Text = "合成道具所需的其他道具不足"
  },
  TipsType_10106_Desc = {
    Text = "合成道具需要的货币不足"
  },
  TipsType_10107_Desc = {
    Text = "合成道具未解锁"
  },
  TipsType_10108_Desc = {
    Text = "连接服务器失败，请检查网络后重试"
  },
  TipsType_10109_Desc = {
    Text = "营地已选择了功能无法再次选择"
  },
  TipsType_10110_Desc = {
    Text = "营地功能已没有使用次数"
  },
  TipsType_10111_Desc = {
    Text = "专属卡没有升级无法切换"
  },
  TipsType_10112_Desc = {
    Text = "专属卡没有变化无法切换"
  },
  TipsType_10113_Desc = {
    Text = "专属卡切换失败"
  },
  TipsType_10114_Desc = {
    Text = "获得唤醒体{s1}"
  },
  TipsType_10115_Desc = {
    Text = "重复获得{s1}，已转为了{s2}{s3}"
  },
  TipsType_10116_Desc = {
    Text = "{s1}信物超过上限，已转为了{s2}{s3}"
  },
  TipsType_10117_Desc = {
    Text = "Log上传成功"
  },
  TipsType_10118_Desc = {
    Text = "指令不匹配，当前在等待指令 {s1}，输入了 {s2}"
  },
  TipsType_10119_Desc = {
    Text = "失去卡牌:{s1}; uid:{s2}"
  },
  TipsType_10120_Desc = {
    Text = "不可释放"
  },
  TipsType_10121_Desc = {
    Text = "无此技能"
  },
  TipsType_10122_Desc = {
    Text = "技能尚在缓冲"
  },
  TipsType_10123_Desc = {
    Text = "技能次数耗尽"
  },
  TipsType_10124_Desc = {
    Text = "检查建筑Tid {s1} 相关建筑升级次序是否循环"
  },
  TipsType_10125_Desc = {
    Text = "检查建筑Tid {s1} 是否没有相关配置"
  },
  TipsType_10126_Desc = {
    Text = "建筑Tid {s1} 实际等级应该是 {s2},配置的为 {s3}"
  },
  TipsType_10127_Desc = {
    Text = "找不到建筑类型配置"
  },
  TipsType_10128_Desc = {
    Text = "找不到建筑配置，或者没有建筑类型"
  },
  TipsType_10129_Desc = {
    Text = "此剧情线课题分任务暂未开放"
  },
  TipsType_10130_Desc = {
    Text = "移除成功"
  },
  TipsType_10131_Desc = {
    Text = "成功增加「灵啡肽」× {s1}"
  },
  TipsType_10132_Desc = {
    Text = "修复完成"
  },
  TipsType_10133_Desc = {
    Text = "GM 添加道具根据道具名【\"..arg1..\"】没有找到对应的道具"
  },
  TipsType_10134_Desc = {
    Text = "事件【\"..arg1..\"】不存在"
  },
  TipsType_10135_Desc = {
    Text = "当前：按{s1}"
  },
  TipsType_10136_Desc = {
    Text = "技能升级成功"
  },
  TipsType_10137_Desc = {
    Text = "生成成功"
  },
  TipsType_10138_Desc = {
    Text = "修改服务器时间成功"
  },
  TipsType_10139_Desc = {
    Text = "修改服务器时间失败"
  },
  TipsType_10140_Desc = {
    Text = "建筑总数：17\n此临时版本仅开放部分建筑"
  },
  TipsType_10141_Desc = {
    Text = "未达到建筑解锁条件"
  },
  TipsType_10142_Desc = {
    Text = "建筑:{s1}配置的界面不存在 {s2}"
  },
  TipsType_10143_Desc = {
    Text = "该合成公式暂未解锁"
  },
  TipsType_10144_Desc = {
    Text = "素材不足"
  },
  TipsType_10145_Desc = {
    Text = "合成成功"
  },
  TipsType_10146_Desc = {
    Text = "升级成功"
  },
  TipsType_10147_Desc = {
    Text = "怪物栏为空，不能进入战斗"
  },
  TipsType_10148_Desc = {
    Text = "「灵啡肽」回复"
  },
  TipsType_10149_Desc = {
    Text = "填写的角色ID重复，不能进入战斗"
  },
  TipsType_10150_Desc = {
    Text = "填写的ID{s1}不存在，不能进入战斗"
  },
  TipsType_10151_Desc = {
    Text = "怪物没有对应的动作"
  },
  TipsType_10152_Desc = {
    Text = "暂未开放"
  },
  TipsType_10153_Desc = {
    Text = "当前卡堆中无卡牌"
  },
  TipsType_10154_Desc = {
    Text = "其他卡牌生效中，不能出牌"
  },
  TipsType_10155_Desc = {
    Text = "不在手卡中，无法打出"
  },
  TipsType_10156_Desc = {
    Text = "此卡不可打出"
  },
  TipsType_10157_Desc = {
    Text = "此卡未配置技能"
  },
  TipsType_10158_Desc = {
    Text = "此卡不可打出"
  },
  TipsType_10159_Desc = {
    Text = "算力不足"
  },
  TipsType_10160_Desc = {
    Text = "场上没有对应唤醒体"
  },
  TipsType_10161_Desc = {
    Text = "剩余次数不足"
  },
  TipsType_10162_Desc = {
    Text = "使用探索技能"
  },
  TipsType_10163_Desc = {
    Text = "已选择%d张指令卡"
  },
  TipsType_10164_Desc = {
    Text = "已达数量上限"
  },
  TipsType_10165_Desc = {
    Text = "尚未选中"
  },
  TipsType_10166_Desc = {
    Text = "此卡不可消耗算力打出"
  },
  TipsType_10167_Desc = {
    Text = "消耗总和超过"
  },
  TipsType_10168_Desc = {
    Text = "已选择{s1}张卡牌"
  },
  TipsType_10169_Desc = {
    Text = "触腕数量已达上限"
  },
  TipsType_10170_Desc = {
    Text = "移除成功"
  },
  TipsType_10171_Desc = {
    Text = "强化成功"
  },
  TipsType_10172_Desc = {
    Text = "变化成功"
  },
  TipsType_10173_Desc = {
    Text = "已复制到剪切板"
  },
  TipsType_10174_Desc = {
    Text = "已成功获得指令卡"
  },
  TipsType_10175_Desc = {
    Text = "移除次数已用尽"
  },
  TipsType_10176_Desc = {
    Text = "强化次数已用尽"
  },
  TipsType_10177_Desc = {
    Text = "变化次数已用尽"
  },
  TipsType_10178_Desc = {
    Text = "复制次数已用尽"
  },
  TipsType_10179_Desc = {
    Text = "选择指令卡张数到达上限"
  },
  TipsType_10180_Desc = {
    Text = "尚未选择指令卡"
  },
  TipsType_10181_Desc = {
    Text = "商城暂未开启，敬请期待。"
  },
  TipsType_10182_Desc = {
    Text = "敬请期待"
  },
  TipsType_10183_Desc = {
    Text = "课题目标所在区域过远，无法定位"
  },
  TipsType_10184_Desc = {
    Text = "错过目标所在区域，无法完成"
  },
  TipsType_10185_Desc = {
    Text = "暂未解锁此课题"
  },
  TipsType_10186_Desc = {
    Text = "探索密境解锁更多调查"
  },
  TipsType_10187_Desc = {
    Text = "完成前置任务解锁更多调查"
  },
  TipsType_10188_Desc = {
    Text = "提交成功，课题分+{s1}"
  },
  TipsType_10189_Desc = {
    Text = "没有可以提交的课题"
  },
  TipsType_10190_Desc = {
    Text = "暂未开启，请留意副本开启时间。"
  },
  TipsType_10191_Desc = {
    Text = "暂未达到关卡解锁条件"
  },
  TipsType_10192_Desc = {
    Text = "{s1}不能为空"
  },
  TipsType_10193_Desc = {
    Text = "{s1}和{s2}不能为空"
  },
  TipsType_10194_Desc = {
    Text = "刷新次数已用尽，无法刷新。"
  },
  TipsType_10195_Desc = {
    Text = "获取途径尚未解锁"
  },
  TipsType_10196_Desc = {
    Text = "获取途径不在开放时间内"
  },
  TipsType_10197_Desc = {
    Text = "请选择需变化的造物"
  },
  TipsType_10198_Desc = {
    Text = "移除成功"
  },
  TipsType_10199_Desc = {
    Text = "移除次数已用尽"
  },
  TipsType_10200_Desc = {
    Text = "变化次数已用尽"
  },
  TipsType_10201_Desc = {
    Text = "请选择需移除的造物"
  },
  TipsType_10202_Desc = {
    Text = "数量已达上限"
  },
  TipsType_10203_Desc = {
    Text = "请至少选择{s1}个造物"
  },
  TipsType_10204_Desc = {
    Text = "当前剩余切换次数为0，无法进行切换"
  },
  TipsType_10205_Desc = {
    Text = "所有专属卡均已升至等级上限"
  },
  TipsType_10206_Desc = {
    Text = "当前排斥度为0，无法继续降低"
  },
  TipsType_10207_Desc = {
    Text = "暂未开放"
  },
  TipsType_10208_Desc = {
    Text = "锢灵之锚不足，无法进行强化"
  },
  TipsType_10209_Desc = {
    Text = "需{s1}达到{s2}级方可施行启灵"
  },
  TipsType_10210_Desc = {
    Text = "「{s1}」不足"
  },
  TipsType_10211_Desc = {
    Text = "暂未拥有「{s1}」"
  },
  TipsType_10212_Desc = {
    Text = "已达等级上限"
  },
  TipsType_10213_Desc = {
    Text = "请先选择素材"
  },
  TipsType_10214_Desc = {
    Text = "「{s1}」不足"
  },
  TipsType_10215_Desc = {
    Text = "升级成功"
  },
  TipsType_10216_Desc = {
    Text = "灵知制剂已增加"
  },
  TipsType_10217_Desc = {
    Text = "已达启灵上限"
  },
  TipsType_10218_Desc = {
    Text = "升级失败"
  },
  TipsType_10219_Desc = {
    Text = "道具不足，无法升级"
  },
  TipsType_10220_Desc = {Text = "Lv. MAX"},
  TipsType_10221_Desc = {
    Text = "技能升级成功"
  },
  TipsType_10222_Desc = {
    Text = "黑印不足，无法购买"
  },
  TipsType_10223_Desc = {Text = "售罄"},
  TipsType_10224_Desc = {
    Text = "黑印不足，无法移除指令卡"
  },
  TipsType_10225_Desc = {
    Text = "移除{s1}张指令卡"
  },
  TipsType_10226_Desc = {
    Text = "此方向暂未开放，无法进行强化"
  },
  TipsType_10227_Desc = {
    Text = "此方向已强化至上限等级"
  },
  TipsType_10228_Desc = {
    Text = "请先选择专属卡希望强化的方向"
  },
  TipsType_10229_Desc = {
    Text = "锢灵之锚不足，无法进行强化"
  },
  TipsType_10230_Desc = {
    Text = "暂未拥有该界域唤醒体，无法选择。"
  },
  TipsType_10231_Desc = {
    Text = "创建一个队伍"
  },
  TipsType_10232_Desc = {
    Text = "队伍名称不能超过{s1}汉字"
  },
  TipsType_10233_Desc = {
    Text = "队伍名称不能为空"
  },
  TipsType_10234_Desc = {
    Text = "兑换成功。"
  },
  TipsType_10235_Desc = {
    Text = "没有更多「银芯」了。"
  },
  TipsType_10236_Desc = {
    Text = "不能再减少了。"
  },
  TipsType_10237_Desc = {
    Text = "{s1}暂未开启，敬请期待。"
  },
  TipsType_10238_Desc = {
    Text = "召唤暂未开启，敬请期待。"
  },
  TipsType_10239_Desc = {
    Text = "校园小地图功能暂未开启"
  },
  TipsType_10240_Desc = {
    Text = "课题等级{s1}时解锁"
  },
  TipsType_10241_Desc = {
    Text = "没有符合条件的卡牌"
  },
  TipsType_10242_Desc = {
    Text = "所有界域卡已升级"
  },
  TipsType_10243_Desc = {
    Text = "没有可升级的指令卡"
  },
  TipsType_10244_Desc = {
    Text = "发现新的传送点！可前往{s1}。"
  },
  TipsType_10245_Desc = {
    Text = "已经获得过此造物，无法重复获得"
  },
  TipsType_10246_Desc = {
    Text = "恢复成功"
  },
  TipsType_10247_Desc = {
    Text = "移除成功"
  },
  TipsType_10248_Desc = {
    Text = "打开背包界面"
  },
  TipsType_10249_Desc = {
    Text = "检测到您上次异常下线，现已将「灵啡肽」及应得物资返还，可打开背包查看"
  },
  TipsType_10250_Desc = {
    Text = "AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  TipsType_10251_Desc = {
    Text = "AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  TipsType_10252_Desc = {
    Text = "AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  TipsType_10253_Desc = {
    Text = "AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  TipsType_10254_Desc = {
    Text = "AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  TipsType_10255_Desc = {
    Text = "AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  TipsType_10256_Desc = {
    Text = "AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  TipsType_10257_Desc = {
    Text = "AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  TipsType_10258_Desc = {
    Text = "AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  TipsType_10259_Desc = {
    Text = "AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  TipsType_10260_Desc = {
    Text = "AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  TipsType_10261_Desc = {
    Text = "AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  TipsType_10262_Desc = {
    Text = "AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  TipsType_10263_Desc = {
    Text = "AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  TipsType_10264_Desc = {
    Text = "AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  TipsType_10265_Desc = {
    Text = "AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  TipsType_10266_Desc = {
    Text = "AVG版仅提供个别建筑，此处表示建筑总数为17"
  },
  TipsType_10267_Desc = {
    Text = "不满足使用条件"
  },
  TipsType_10268_Desc = {
    Text = "调查等级2级解锁快速调查"
  },
  TipsType_10269_Desc = {
    Text = "连接中断"
  },
  TipsType_10270_Desc = {
    Text = "服务器连接中断，稍后将返回登录页面。"
  },
  TipsType_10271_Desc = {Text = "确认"},
  TipsType_10272_Desc = {
    Text = "服务器尚未开放，请稍后再试。"
  },
  TipsType_10273_Desc = {
    Text = "操作成功"
  },
  TipsType_10274_Desc = {
    Text = "未找到对应密境"
  },
  TipsType_10275_Desc = {
    Text = "密境事件已完成"
  },
  TipsType_10276_Desc = {
    Text = "密境事件配置类型填写错误"
  },
  TipsType_10277_Desc = {
    Text = "密境事件不存在"
  },
  TipsType_10278_Desc = {
    Text = "黑印不足，无法购买"
  },
  TipsType_10279_Desc = {
    Text = "此卡无法强化"
  },
  TipsType_10280_Desc = {
    Text = "此卡已达强化上限"
  },
  TipsType_10281_Desc = {
    Text = "行商不出售此商品"
  },
  TipsType_10282_Desc = {
    Text = "无此奖励"
  },
  TipsType_10283_Desc = {
    Text = "奖励已领取"
  },
  TipsType_10284_Desc = {
    Text = "配置表错误"
  },
  TipsType_10285_Desc = {
    Text = "事件数据错误"
  },
  TipsType_10286_Desc = {
    Text = "商品已购买"
  },
  TipsType_10287_Desc = {
    Text = "未找到课题单元数据"
  },
  TipsType_10288_Desc = {
    Text = "单元已提交，无需再次提交"
  },
  TipsType_10289_Desc = {
    Text = "单元下的课题尚未全部完成，无法提交"
  },
  TipsType_10290_Desc = {
    Text = "课题无模块"
  },
  TipsType_10291_Desc = {
    Text = "关卡无课题数据"
  },
  TipsType_10292_Desc = {
    Text = "客户端传入数据错误"
  },
  TipsType_10293_Desc = {
    Text = "服务未启动"
  },
  TipsType_10294_Desc = {
    Text = "角色数据错误"
  },
  TipsType_10295_Desc = {
    Text = "没有角色，需创建"
  },
  TipsType_10296_Desc = {
    Text = "已有角色，不需要再次创建"
  },
  TipsType_10297_Desc = {
    Text = "角色名重复"
  },
  TipsType_10298_Desc = {
    Text = "密境错误"
  },
  TipsType_10299_Desc = {
    Text = "该剧情线尚未解锁，无法进入。"
  },
  TipsType_10300_Desc = {
    Text = "在此处可以查看地形效果以及怪物信息"
  },
  TipsType_10301_Desc = {
    Text = "{s1}达到{s2}解锁{s3}"
  },
  TipsType_10302_Desc = {
    Text = "{s1}达到{s2}解锁{s3}"
  },
  TipsType_10303_Desc = {
    Text = "未达到建筑解锁条件"
  },
  TipsType_10304_Desc = {
    Text = "未达到建筑升级条件"
  },
  TipsType_10305_Desc = {
    Text = "建筑升级素材不足"
  },
  TipsType_10306_Desc = {
    Text = "有可领取的任务奖励"
  },
  TipsType_10307_Desc = {
    Text = "（生命将降低<Negative:10%%>）"
  },
  TipsType_10308_Desc = {
    Text = "每回合结束时，获得等同于当前加护层数的<BuffTipBlock:护盾>值。每次受到伤害，加护减少<BuffTip:1>层"
  },
  TipsType_10309_Desc = {
    Text = "多重加护"
  },
  TipsType_10310_Desc = {
    Text = "体力低于警戒值，调查风险提高"
  },
  TipsType_10311_Desc = {
    Text = "体力低于警戒值，调查风险极高，是否选择强行进入？"
  },
  TipsType_10312_Desc = {
    Text = "当前体力过低，无法进入密境。"
  },
  TipsType_10313_Desc = {
    Text = "请选择同等级专属卡进行切换"
  },
  TipsType_10314_Desc = {
    Text = "唤醒体启灵2级后解锁该方向"
  },
  TipsType_10315_Desc = {
    Text = "唤醒体启灵3级后解锁该方向"
  },
  TipsType_10316_Desc = {Text = "当前"},
  TipsType_10317_Desc = {
    Text = "所有唤醒体均未解锁技能，无法充能"
  },
  TipsType_10318_Desc = {
    Text = "所有唤醒体技能的能量已满"
  },
  TipsType_10319_Desc = {Text = "已使用"},
  TipsType_10320_Desc = {
    Text = "黑印不足"
  },
  TipsType_10321_Desc = {
    Text = "黑印不足"
  },
  TipsType_10322_Desc = {
    Text = "黑印不足"
  },
  TipsType_10323_Desc = {
    Text = "无法重复获得已有造物"
  },
  TipsType_10324_Desc = {
    Text = "刷新次数不足"
  },
  TipsType_10325_Desc = {
    Text = "将对我方造成{s1}点伤害。"
  },
  TipsType_10326_Desc = {Text = "攻击"},
  TipsType_10327_Desc = {
    Text = "在这里会显示关卡的小地图预览，玩家可以提前进行策略部署"
  },
  TipsType_10328_Desc = {
    Text = "你花了10分钟完成日常副本中的一个关卡，在这里得到了独特的玩法体验并且通过关卡设计强化了流派认知"
  },
  TipsType_10329_Desc = {
    Text = "当前生命上限已低于最大生命上限的50%，请注意安全"
  },
  TipsType_10330_Desc = {
    Text = "维系唤醒体存在的能量。受到伤害会减少生命，生命归零即代表调查失败。"
  },
  TipsType_10331_Desc = {
    Text = "唤醒体攻击强度的体现。力量越强，使用指令卡时对敌方造成的伤害越高。"
  },
  TipsType_10332_Desc = {
    Text = "唤醒体防御能力的体现。戒备越高，使用指令卡时获得的护盾越多。"
  },
  TipsType_10333_Desc = {
    Text = "点击任意处继续"
  },
  TipsType_10334_Desc = {
    Text = "尚未完成任务调查项目"
  },
  TipsType_10335_Desc = {
    Text = "调查评价"
  },
  TipsType_10336_Desc = {
    Text = "赋予1张专属卡以启示之灵"
  },
  TipsType_10337_Desc = {
    Text = "选择专属卡的强化方向"
  },
  TipsType_10338_Desc = {
    Text = "主城小地图暂未开启，敬请期待。"
  },
  TipsType_10339_Desc = {
    Text = "{s1}{s2}值"
  },
  TipsType_10340_Desc = {
    Text = "{s1}基础卡组等级提升"
  },
  TipsType_10341_Desc = {
    Text = "<Positive:好感度：>"
  },
  TipsType_10342_Desc = {
    Text = "与唤醒体之间的情感联结的体现。好感度加深，可更加深入了解唤醒体。"
  },
  TipsType_10343_Desc = {
    Text = "<Positive:当前等级：>{s1}"
  },
  TipsType_10344_Desc = {
    Text = "<Positive:基础卡组：>"
  },
  TipsType_10345_Desc = {
    Text = "该界域进入副本时拥有的初始卡组。"
  },
  TipsType_10346_Desc = {
    Text = "<Positive:卡组最高等级：>{s1}级"
  },
  TipsType_10347_Desc = {
    Text = "<Positive:卡组等级：>"
  },
  TipsType_10348_Desc = {
    Text = "该界域指定数量唤醒体达到指定好感度等级时，可升级基础卡组。"
  },
  TipsType_10349_Desc = {
    Text = "<Positive:升级内容：>"
  },
  TipsType_10350_Desc = {
    Text = "每次升级将提升一种指令卡的基础值。"
  },
  TipsType_10351_Desc = {
    Text = "{s1}好感度提升"
  },
  TipsType_10352_Desc = {
    Text = "密境沉寂中"
  },
  TipsType_10353_Desc = {
    Text = "密境排斥入侵者"
  },
  TipsType_10354_Desc = {
    Text = "密境排斥度增加"
  },
  TipsType_10355_Desc = {
    Text = "排斥度达到{s1}，密境正在注视你"
  },
  TipsType_10356_Desc = {Text = "启灵1"},
  TipsType_10357_Desc = {
    Text = "领会该技能"
  },
  TipsType_10358_Desc = {
    Text = "能够同时存在的触腕数量最大值。"
  },
  TipsType_10359_Desc = {
    Text = "触腕攻击强度的体现。触腕力量越强，激发触腕时对敌方造成的伤害越高。"
  },
  TipsType_10360_Desc = {
    Text = "尚未选择指令卡"
  },
  TipsType_10361_Desc = {
    Text = "变化成功"
  },
  TipsType_10362_Desc = {
    Text = "尚未选择指令卡"
  },
  TipsType_10363_Desc = {
    Text = "复制成功"
  },
  TipsType_10364_Desc = {
    Text = "已选择{s1}张指令卡"
  },
  TipsType_10365_Desc = {
    Text = "尚未选择指令卡"
  },
  TipsType_10366_Desc = {
    Text = "尚未选择指令卡"
  },
  TipsType_10367_Desc = {
    Text = "升级成功"
  },
  TipsType_10368_Desc = {
    Text = "造物背包界面开发中，敬请期待"
  },
  TipsType_10369_Desc = {
    Text = "请选择需变化的造物"
  },
  TipsType_10370_Desc = {
    Text = "版本更新，请重新下载安装包"
  },
  TipsType_10371_Desc = {
    Text = "进阶效应"
  },
  TipsType_10372_Desc = {
    Text = "密境信息"
  },
  TipsType_10373_Desc = {
    Text = "每使用1张伤害卡，触腕会对随机敌人造成{s1}点伤害。"
  },
  TipsType_10374_Desc = {
    Text = "当前无待完成课题"
  },
  TipsType_10375_Desc = {
    Text = "当前无已归档课题"
  },
  TipsType_10376_Desc = {
    Text = "本次调查未完成课题"
  },
  TipsType_10377_Desc = {
    Text = "无法回退"
  },
  TipsType_10378_Desc = {
    Text = "(以下课题已自动归档)"
  },
  TipsType_10379_Desc = {
    Text = "目标课题已完成"
  },
  TipsType_10380_Desc = {
    Text = "您没有此道具"
  },
  TipsType_10381_Desc = {
    Text = "错误的索引值"
  },
  TipsType_10382_Desc = {Text = "未解锁"},
  TipsType_10383_Desc = {
    Text = "专属卡升级，没有次数"
  },
  TipsType_10384_Desc = {
    Text = "已解锁1个造物保留格！"
  },
  TipsType_10385_Desc = {
    Text = "连接率提升"
  },
  TipsType_10386_Desc = {
    Text = "没有槽位信息"
  },
  TipsType_10387_Desc = {
    Text = "货币不足"
  },
  TipsType_10388_Desc = {
    Text = "已到达最大等级"
  },
  TipsType_10389_Desc = {
    Text = "开发中敬请期待"
  },
  TipsType_10390_Desc = {
    Text = "已没有手动升级槽位次数"
  },
  TipsType_10391_Desc = {
    Text = "在商店或营地解除封印后可使用"
  },
  TipsType_10392_Desc = {
    Text = "本场战斗扣除{s1}体力"
  },
  TipsType_10393_Desc = {
    Text = "唤醒体能量已满，无法继续提升"
  },
  TipsType_10394_Desc = {
    Text = "已将所有唤醒体的能量提升完毕"
  },
  TipsType_10395_Desc = {
    Text = "需要使用「眼」解锁"
  },
  TipsType_10396_Desc = {
    Text = "已成功刻印"
  },
  TipsType_10397_Desc = {
    Text = "已上阵{s1}唤醒体，队伍将携带{s2}界域特性。"
  },
  TipsType_10398_Desc = {
    Text = "队伍将变为中立，不携带任何界域特性。"
  },
  TipsType_10399_Desc = {
    Text = "小循环系统验证在第四章关卡开启"
  },
  TipsType_10400_Desc = {
    Text = "最多继承{s1}个造物，请先减少选中造物数量。"
  },
  TipsType_10401_Desc = {
    Text = "未勾选造物无法继承"
  },
  TipsType_10405_Desc = {Text = "获得{s1}"},
  TipsType_10406_Desc = {
    Text = "上阵唤醒体已达到上限"
  },
  TipsType_10407_Desc = {
    Text = "该黄金塔无法挑战-"
  },
  TipsType_10408_Desc = {
    Text = "该黄金塔未解锁-请完成指定的调查副本"
  },
  TipsType_10409_Desc = {
    Text = "请选择上场的唤醒体"
  },
  TipsType_10410_Desc = {
    Text = "唤醒体正在努力完成派遣任务，晚点再来领取吧"
  },
  TipsType_10411_Desc = {
    Text = "已领取{s1}蔷薇金券"
  },
  TipsType_10412_Desc = {
    Text = "时间报酬需要随时间累积"
  },
  TipsType_10413_Desc = {
    Text = "「银芯」不足"
  },
  TipsType_10414_Desc = {
    Text = "没有挑战次数"
  },
  TipsType_10415_Desc = {
    Text = "挑战冷却中"
  },
  TipsType_10416_Desc = {
    Text = "没有挑战对手"
  },
  TipsType_10417_Desc = {
    Text = "请选择上阵的唤醒体"
  },
  TipsType_10418_Desc = {
    Text = "灵知制剂不足，无法继续提升等级"
  },
  TipsType_10419_Desc = {
    Text = "当前等级已达上限"
  },
  TipsType_10420_Desc = {
    Text = "唤醒体暂未解锁"
  },
  TipsType_10421_Desc = {
    Text = "解除收藏成功"
  },
  TipsType_10422_Desc = {
    Text = "剧情线挑战购买次数不足"
  },
  TipsType_10423_Desc = {
    Text = "剧情线星级不足，无法扫荡"
  },
  TipsType_10424_Desc = {
    Text = "调查副本队伍界域搭配错误"
  },
  TipsType_10425_Desc = {
    Text = "「银芯」不足"
  },
  TipsType_10426_Desc = {
    Text = "今日凭证购买次数已达上限"
  },
  TipsType_10427_Desc = {
    Text = "三星通关秘境后解锁"
  },
  TipsType_10428_Desc = {
    Text = "成功获取{s1}张凭证"
  },
  TipsType_10429_Desc = {
    Text = "成功获得{s1}次挑战次数"
  },
  TipsType_10430_Desc = {
    Text = "通关 调查4-6 解锁"
  },
  TipsType_10431_Desc = {
    Text = "凭证不足"
  },
  TipsType_10432_Desc = {
    Text = "凭证购买次数不足"
  },
  TipsType_10433_Desc = {
    Text = "启灵等级已达上限"
  },
  TipsType_10434_Desc = {
    Text = "「{s1}」不足"
  },
  TipsType_10435_Desc = {
    Text = "没有此商品出售"
  },
  TipsType_10436_Desc = {
    Text = "没有此类型商店"
  },
  TipsType_10437_Desc = {
    Text = "出售的商品已没有库存"
  },
  TipsType_10438_Desc = {
    Text = "没有商店数据"
  },
  TipsType_10439_Desc = {
    Text = "没有刷新次数"
  },
  TipsType_10440_Desc = {
    Text = "今日「灵啡肽」购买次数已达上限"
  },
  TipsType_10441_Desc = {
    Text = "唤醒体残片不足"
  },
  TipsType_10442_Desc = {
    Text = "启灵点已激活"
  },
  TipsType_10443_Desc = {
    Text = "前置启灵点未激活"
  },
  TipsType_10444_Desc = {
    Text = "成功购买「灵啡肽」× {s1}"
  },
  TipsType_10445_Desc = {
    Text = "「灵啡肽」已达上限"
  },
  TipsType_10446_Desc = {
    Text = "完成 调查1-12 解锁"
  },
  TipsType_10447_Desc = {
    Text = "完成 序章 解锁"
  },
  TipsType_10448_Desc = {
    Text = "完成 序章 解锁"
  },
  TipsType_10449_Desc = {
    Text = "完成 调查2-4 解锁"
  },
  TipsType_10450_Desc = {
    Text = "该技能等级已达到上限"
  },
  TipsType_10451_Desc = {
    Text = "唤醒体升格等阶不足"
  },
  TipsType_10452_Desc = {
    Text = "技能升级素材不足"
  },
  TipsType_10453_Desc = {
    Text = "完成 调查3-15 解锁"
  },
  TipsType_10454_Desc = {
    Text = "完成 调查3-7 解锁"
  },
  TipsType_10455_Desc = {
    Text = "技能升级未到达设置的条件"
  },
  TipsType_10456_Desc = {
    Text = "测试版本每个充值项仅允许进行1次充值操作"
  },
  TipsType_10457_Desc = {
    Text = "此唤醒体本源降临冷却中，下回合再释放吧"
  },
  TipsType_10458_Desc = {
    Text = "充值配置表中没有此配置"
  },
  TipsType_10459_Desc = {
    Text = "已免费充值过无法再次充值"
  },
  TipsType_10460_Desc = {
    Text = "共鸣已激活无需再次激活"
  },
  TipsType_10461_Desc = {
    Text = "道具{s1}的价格已发生变更，请注意确认"
  },
  TipsType_10462_Desc = {
    Text = "「蔷薇金券」不足"
  },
  TipsType_10463_Desc = {
    Text = "「演习徽章」不足"
  },
  TipsType_10464_Desc = {
    Text = "通关 调查3-4 解锁"
  },
  TipsType_10465_Desc = {
    Text = "通关 调查2-16 解锁"
  },
  TipsType_10466_Desc = {
    Text = "通关 调查3-16 解锁"
  },
  TipsType_10467_Desc = {
    Text = "通关 调查4-12 解锁"
  },
  TipsType_10468_Desc = {
    Text = "通关 调查5-12 解锁"
  },
  TipsType_10469_Desc = {
    Text = "通关 调查6-12 解锁"
  },
  TipsType_10470_Desc = {
    Text = "通关 调查1-7 解锁"
  },
  TipsType_10471_Desc = {
    Text = "装备成功"
  },
  TipsType_10472_Desc = {
    Text = "卸下成功"
  },
  TipsType_10473_Desc = {
    Text = "已达到最大等级"
  },
  TipsType_10474_Desc = {
    Text = "「蔷薇金券」不足"
  },
  TipsType_10475_Desc = {
    Text = "请选择材料"
  },
  TipsType_10476_Desc = {
    Text = "正被上锁保护中，请先解除锁定状态"
  },
  TipsType_10477_Desc = {
    Text = "关卡未开放"
  },
  TipsType_10478_Desc = {
    Text = "战斗外未开放"
  },
  TipsType_10479_Desc = {
    Text = "弃牌堆为空"
  },
  TipsType_10480_Desc = {
    Text = "RPG战斗调整中，当前直接结算胜利"
  },
  TipsType_10482_Desc = {
    Text = "命轮已锁定"
  },
  TipsType_10483_Desc = {
    Text = "命轮未找到"
  },
  TipsType_10484_Desc = {
    Text = "命轮已达最大等阶"
  },
  TipsType_10485_Desc = {
    Text = "命轮已被装备"
  },
  TipsType_10486_Desc = {
    Text = "命轮不匹配"
  },
  TipsType_10487_Desc = {
    Text = "命轮未锁定"
  },
  TipsType_10488_Desc = {
    Text = "正处于「编队」「助战」「密契方案」中的密契，不可分解。"
  },
  TipsType_10489_Desc = {
    Text = "正处于「编队」「助战」中的命轮，不可分解。"
  },
  TipsType_10490_Desc = {
    Text = "狂气值不足，无法释放狂气爆发"
  },
  TipsType_10491_Desc = {
    Text = "请先领取前一个礼包。"
  },
  TipsType_10492_Desc = {
    Text = "当前密契已锁定，解锁以作为物资消耗"
  },
  TipsType_10493_Desc = {
    Text = "当前命轮已锁定，解锁以作为物资消耗"
  },
  TipsType_10494_Desc = {
    Text = "通关 调查1-7 解锁"
  },
  TipsType_10495_Desc = {
    Text = "通关 调查1-13 解锁"
  },
  TipsType_10496_Desc = {
    Text = "当前密契等级已达上限"
  },
  TipsType_10497_Desc = {
    Text = "商店已重置"
  },
  TipsType_10498_Desc = {
    Text = "更换成功"
  },
  TipsType_10499_Desc = {
    Text = "收藏成功"
  },
  TipsType_10500_Desc = {
    Text = "叠位成功"
  },
  TipsType_10501_Desc = {
    Text = "当前挑战尚未解锁"
  },
  TipsType_10502_Desc = {
    Text = "当前唤醒体已在{s1}的其他关卡中进行了挑战，无法再次出战"
  },
  TipsType_10503_Desc = {
    Text = "上阵唤醒体不足4个，无法挑战"
  },
  TipsType_10504_Desc = {
    Text = "通关 调查3-7 解锁"
  },
  TipsType_10505_Desc = {
    Text = "第1层达到三星解锁"
  },
  TipsType_10506_Desc = {
    Text = "第2层达到三星解锁"
  },
  TipsType_10507_Desc = {
    Text = "第3层达到三星解锁"
  },
  TipsType_10508_Desc = {
    Text = "第4层达到三星解锁"
  },
  TipsType_10509_Desc = {
    Text = "第5层达到三星解锁"
  },
  TipsType_10510_Desc = {
    Text = "第6层达到三星解锁"
  },
  TipsType_10511_Desc = {
    Text = "第7层达到三星解锁"
  },
  TipsType_10512_Desc = {
    Text = "第8层达到三星解锁"
  },
  TipsType_10513_Desc = {
    Text = "请选择希望强化的密契"
  },
  TipsType_10514_Desc = {Text = "已领取"},
  TipsType_10515_Desc = {
    Text = "通关 调查2-14 解锁"
  },
  TipsType_10516_Desc = {
    Text = "通关 调查4-7 解锁"
  },
  TipsType_10517_Desc = {
    Text = "通关 调查4-7 解锁"
  },
  TipsType_10518_Desc = {
    Text = "编队已保存"
  },
  TipsType_10519_Desc = {
    Text = "请触摸发光区域进行移动"
  },
  TipsType_10520_Desc = {
    Text = "队伍名中不可包含中文、英文、数字以外的字符"
  },
  TipsType_10521_Desc = {
    Text = "队伍名长度不可大于8个字符"
  },
  TipsType_10522_Desc = {
    Text = "队伍中唤醒体数量不足{s1}个，无法进行调查"
  },
  TipsType_10523_Desc = {
    Text = "唤醒体已参与过该层无光之境其它密境的战斗"
  },
  TipsType_10524_Desc = {
    Text = "队伍中已有两个界域的唤醒体，无法再选中其他界域唤醒体"
  },
  TipsType_10525_Desc = {
    Text = "请选中一个唤醒体"
  },
  TipsType_10526_Desc = {
    Text = "无法再选中更多的唤醒体"
  },
  TipsType_10527_Desc = {
    Text = "养成注意：幻梦深潜中，唤醒体等级和技能等级都被调为1级"
  },
  TipsType_10528_Desc = {
    Text = "队伍名不可为空"
  },
  TipsType_10529_Desc = {
    Text = "队伍中有唤醒体已筋疲力尽，无法再战斗"
  },
  TipsType_10530_Desc = {
    Text = "邮箱内的附件已全部领取完成"
  },
  TipsType_10531_Desc = {
    Text = "通关序章后解锁"
  },
  TipsType_10532_Desc = {
    Text = "背包已满，未领取完成，需清理背包后继续领取"
  },
  TipsType_10533_Desc = {
    Text = "背包已满，奖励将发送至邮箱"
  },
  TipsType_10534_Desc = {
    Text = "背包已满，物资未全部领取完成，需清理背包后继续领取"
  },
  TipsType_10535_Desc = {
    Text = "没有信函附件可领取"
  },
  TipsType_10536_Desc = {
    Text = "请先兑换造物"
  },
  TipsType_10537_Desc = {
    Text = "完成 调查2-4 解锁"
  },
  TipsType_10538_Desc = {
    Text = "完成 调查1-12 解锁"
  },
  TipsType_10539_Desc = {
    Text = "完成 调查1-12 解锁"
  },
  TipsType_10540_Desc = {
    Text = "完成 调查1-12 解锁"
  },
  TipsType_10541_Desc = {
    Text = "第9层达到三星解锁"
  },
  TipsType_10542_Desc = {
    Text = "第10层达到三星解锁"
  },
  TipsType_10543_Desc = {
    Text = "第11层达到三星解锁"
  },
  TipsType_10544_Desc = {
    Text = "第12层达到三星解锁"
  },
  TipsType_10545_Desc = {
    Text = "第13层达到三星解锁"
  },
  TipsType_10546_Desc = {
    Text = "第14层达到三星解锁"
  },
  TipsType_10547_Desc = {
    Text = "此功能即将移除"
  },
  TipsType_10548_Desc = {
    Text = "完成 调查1-7 解锁"
  },
  TipsType_10549_Desc = {
    Text = "造物获取已达上限，无法继续获取"
  },
  TipsType_10550_Desc = {
    Text = "{s1}完成链接，现在可以指挥她作战了！"
  },
  TipsType_10551_Desc = {
    Text = "{s1}的等级和技能等级已超出灵知增幅器提供的等级，无法使用"
  },
  TipsType_10552_Desc = {
    Text = "唤醒体等级和技能等级已超出灵知增幅器提供的等级，无法使用"
  },
  TipsType_10553_Desc = {
    Text = "敬请期待"
  },
  TipsType_10554_Desc = {
    Text = "通过上一关卡后解锁"
  },
  TipsType_10555_Desc = {
    Text = "脆弱通路上不可回头"
  },
  TipsType_10556_Desc = {
    Text = "暂未开放，敬请期待"
  },
  TipsType_10557_Desc = {
    Text = "当前已拥有该造物，无法重复获取"
  },
  TipsType_10558_Desc = {
    Text = "即将获得系统剪切板中的内容并进行<Positive:【粘贴】>，\n是否确认？"
  },
  TipsType_10558_LeftBtnDesc = {Text = "取消"},
  TipsType_10558_RightBtnDesc = {Text = "确认"},
  TipsType_10558_Title = {
    Text = "启用粘贴功能"
  },
  TipsType_10559_Desc = {
    Text = "升格素材不足"
  },
  TipsType_10560_Desc = {
    Text = "当前已是初始状态"
  },
  TipsType_10561_Desc = {
    Text = "「蔷薇金券」不足"
  },
  TipsType_10562_Desc = {Text = "未升格"},
  TipsType_10563_Desc = {
    Text = "共鸣重置成功"
  },
  TipsType_10564_Desc = {
    Text = "调查等级达到 {s1}级 解锁"
  },
  TipsType_10565_Desc = {
    Text = "被封印的狂气无法释放"
  },
  TipsType_1056601_Desc = {
    Text = "银芯通讯异常，请检查网络并重试({s1})"
  },
  TipsType_10566_Desc = {
    Text = "银芯通讯异常，请稍后重试({s1})"
  },
  TipsType_10567_Desc = {
    Text = "获取服务器信息失败！{s1}"
  },
  TipsType_10568_Desc = {
    Text = "请先选择服务器"
  },
  TipsType_10569_Desc = {
    Text = "尚未解锁"
  },
  TipsType_10570_Desc = {
    Text = "请输入账号"
  },
  TipsType_10571_Desc = {
    Text = "共鸣激活材料不足"
  },
  TipsType_10572_Desc = {
    Text = "前置共鸣点未升级"
  },
  TipsType_10573_Desc = {Text = "已满级"},
  TipsType_10574_Desc = {
    Text = "升级成功"
  },
  TipsType_10575_Desc = {
    Text = "该唤醒体不可更换"
  },
  TipsType_10576_Desc = {
    Text = "该位置不可上阵"
  },
  TipsType_10577_Desc = {
    Text = "唤醒体数量不足，不可挑战"
  },
  TipsType_10578_Desc = {
    Text = "暂未解锁下一关卡"
  },
  TipsType_10579_Desc = {
    Text = "已经是最后一个关卡了"
  },
  TipsType_10580_Desc = {
    Text = "已达当前经验上限，无法添加"
  },
  TipsType_10581_Desc = {
    Text = "命轮槽已满，无法添加"
  },
  TipsType_10582_Desc = {
    Text = "当前无可以快捷置入的素材"
  },
  TipsType_10583_Desc = {
    Text = "请放置素材到命轮槽"
  },
  TipsType_10584_Desc = {
    Text = "没有可装备的命轮"
  },
  TipsType_10585_Desc = {
    Text = "完成 调查2-8 解锁"
  },
  TipsType_10586_Desc = {
    Text = "完成 调查2-14 解锁"
  },
  TipsType_10587_Desc = {
    Text = "完成 调查3-16 解锁"
  },
  TipsType_10588_Desc = {
    Text = "完成 调查4-12 解锁"
  },
  TipsType_10589_Desc = {
    Text = "完成 调查5-12 解锁"
  },
  TipsType_10590_Desc = {
    Text = "完成 调查6-12 解锁"
  },
  TipsType_10591_Desc = {
    Text = "完成 调查2-12 解锁"
  },
  TipsType_10592_Desc = {
    Text = "该用户已被禁止登录，如有疑问请联系客服。"
  },
  TipsType_10593_Desc = {
    Text = "登录会话已过期，请重新登录。"
  },
  TipsType_10594_Desc = {
    Text = "当前「灵啡肽」不足"
  },
  TipsType_10595_Desc = {
    Text = "是否激活“{s1}”？"
  },
  TipsType_10595_Title = {
    Text = "激活天赋"
  },
  TipsType_10596_Desc = {
    Text = "还未获得该唤醒体"
  },
  TipsType_10597_Desc = {
    Text = "没有可强化的命轮"
  },
  TipsType_10598_Desc = {
    Text = "该账号由于违反相关条例已被禁止登录直至{s1}，如有疑问请联系客服。"
  },
  TipsType_10599_Desc = {
    Text = "通关 调查2-15 解锁"
  },
  TipsType_10600_Desc = {
    Text = "已达等级上限，无法继续添加"
  },
  TipsType_10601_Desc = {
    Text = "完成调查1-7后开启守密人成长记录"
  },
  TipsType_10602_Desc = {
    Text = "完成调查1-7后开启界域精通任务"
  },
  TipsType_10603_Desc = {
    Text = "尚未选择素材"
  },
  TipsType_10604_Desc = {
    Text = "长时间未操作，自动退出副本"
  },
  TipsType_10605_Desc = {
    Text = "问卷填写完毕，感谢您的支持！"
  },
  TipsType_10606_Desc = {
    Text = "激活所需素材不足"
  },
  TipsType_10607_Desc = {
    Text = "本周内获取奖励次数已耗尽，挑战后无法再获得奖励。是否仍要挑战？"
  },
  TipsType_10607_LeftBtnDesc = {Text = "取消"},
  TipsType_10607_RightBtnDesc = {Text = "确认"},
  TipsType_10607_Title = {
    Text = "挑战提示"
  },
  TipsType_10608_Desc = {
    Text = "校园维护中，请静候修整完成"
  },
  TipsType_10609_Desc = {
    Text = "成功邀请{s1}进入你的宿舍"
  },
  TipsType_10610_Desc = {
    Text = "{s1}已经在你的宿舍中了"
  },
  TipsType_10611_Desc = {
    Text = "当前为非wifi网络，是否使用流量继续下载？"
  },
  TipsType_10611_LeftBtnDesc = {Text = "取消"},
  TipsType_10611_RightBtnDesc = {Text = "确认"},
  TipsType_10611_Title = {
    Text = "下载确认"
  },
  TipsType_10612_Desc = {
    Text = "所有卡牌都已刻印"
  },
  TipsType_10613_Desc = {
    Text = "网络异常，请等待"
  },
  TipsType_10614_Desc = {
    Text = "当前挑战未解锁"
  },
  TipsType_10615_Desc = {
    Text = "冷却中，下回合才能释放。"
  },
  TipsType_10616_Desc = {
    Text = "处于选择中，选择完才能释放。"
  },
  TipsType_10617_Desc = {
    Text = "当前狂气爆发不满足释放条件，无法释放。"
  },
  TipsType_10618_Desc = {
    Text = "当前队伍平均等级{s1}低于推荐等级{s2}，调查可能会遇到较大的挑战，是否确认？"
  },
  TipsType_10618_LeftBtnDesc = {
    Text = "前往提升"
  },
  TipsType_10618_RightBtnDesc = {Text = "确认"},
  TipsType_10618_Title = {
    Text = "调查确认"
  },
  TipsType_10619_Desc = {
    Text = "调查等级 {s1}级 后方可使用"
  },
  TipsType_10620_Desc = {
    Text = "网络状况不佳，请检查Steam连接或重启Steam后重试"
  },
  TipsType_10621_Desc = {
    Text = "是否确认使用<WeaponEffect_Num:{s1}>作为你的名字？"
  },
  TipsType_10621_LeftBtnDesc = {Text = "取消"},
  TipsType_10621_RightBtnDesc = {Text = "确认"},
  TipsType_10621_Title = {
    Text = "镌刻确认"
  },
  TipsType_10622_Desc = {
    Text = "镌刻冷却中，{s1}时{s2}分后可再次镌刻"
  },
  TipsType_10623_Desc = {
    Text = "镌刻成功"
  },
  TipsType_10624_Desc = {
    Text = "名字中只能包含中文、英文和数字"
  },
  TipsType_10625_Desc = {
    Text = "此卡即将丢弃"
  },
  TipsType_10626_Desc = {
    Text = "请在Steam中开启以下选项：\n【Steam设置-游戏中-在游戏中启用Steam界面】\n并重启游戏生效。"
  },
  TipsType_10626_RightBtnDesc = {Text = "确认"},
  TipsType_10626_Title = {Text = "提示"},
  TipsType_10628_Desc = {
    Text = "新的名字不可与当前重复"
  },
  TipsType_10629_Desc = {
    Text = "请输入{s1}~{s2}个字符"
  },
  TipsType_10630_Desc = {
    Text = "{s1}达成三星后可进行重现"
  },
  TipsType_10631_Desc = {
    Text = "由于您的账户违反相关条例已被强制下线。"
  },
  TipsType_10631_RightBtnDesc = {Text = "确认"},
  TipsType_10631_Title = {
    Text = "温馨提示"
  },
  TipsType_10632_Desc = {
    Text = "完成挑战后，今日可进行重现"
  },
  TipsType_10633_Desc = {
    Text = "本次分解将消耗以下物资，<Blue:分解后将无法恢复>，是否确认分解？"
  },
  TipsType_10633_LeftBtnDesc = {Text = "取消"},
  TipsType_10633_RightBtnDesc = {Text = "确认"},
  TipsType_10633_Title = {
    Text = "分解确认"
  },
  TipsType_10634_Desc = {
    Text = "当前月卡剩余天数已超过{s1}天，无法累计。"
  },
  TipsType_10635_Desc = {
    Text = "所需「源液」不足，是否前往源液提取？"
  },
  TipsType_10635_LeftBtnDesc = {Text = "取消"},
  TipsType_10635_RightBtnDesc = {Text = "确认"},
  TipsType_10635_Title = {
    Text = "源液不足"
  },
  TipsType_10636_Desc = {
    Text = "当前无闲置命轮"
  },
  TipsType_10637_Desc = {
    Text = "当前无闲置密契"
  },
  TipsType_10638_Desc = {
    Text = "当前无可装备密契位置，请卸下密契后尝试"
  },
  TipsType_10640_Desc = {
    Text = "确认卸下该唤醒体的所有密契吗？"
  },
  TipsType_10640_LeftBtnDesc = {Text = "取消"},
  TipsType_10640_RightBtnDesc = {Text = "确认"},
  TipsType_10640_Title = {Text = "提示"},
  TipsType_10641_Desc = {
    Text = "切换语言后需重启客户端才能生效，是否确认？"
  },
  TipsType_10641_LeftBtnDesc = {Text = "取消"},
  TipsType_10641_RightBtnDesc = {Text = "确认"},
  TipsType_10641_Title = {
    Text = "切换语言确认"
  },
  TipsType_10642_Desc = {
    Text = "玩家等级不足"
  },
  TipsType_10643_Desc = {
    Text = "步入遍布融蚀的区域，生命值减少{s1}点"
  },
  TipsType_10644_Desc = {
    Text = "已选择该钥令"
  },
  TipsType_10645_Desc = {
    Text = "未获得该钥令"
  },
  TipsType_10646_Desc = {
    Text = "「{s1}」不足"
  },
  TipsType_10647_Desc = {
    Text = "调查事件尚未开启，{s1}"
  },
  TipsType_10648_Desc = {
    Text = "轮转间隙已更新"
  },
  TipsType_10649_Desc = {
    Text = "当前可派遣数量已达上限"
  },
  TipsType_10650_Desc = {
    Text = "当前没有已解锁SSR角色"
  },
  TipsType_10651_Desc = {
    Text = "收集数量达到一定数量才可使用"
  },
  TipsType_10652_Desc = {
    Text = "当前没有未获得的头像和对战表情"
  },
  TipsType_10701_Desc = {
    Text = "当前已装备命轮，请卸下后重试。"
  },
  TipsType_10702_Desc = {
    Text = "装备的SSR命轮额外叠位达到 12 时，方可同时装备两个SSR命轮"
  },
  TipsType_10703_Desc = {
    Text = "唤醒体已装备相同命轮，无法重复装备。"
  },
  TipsType_10704_Desc = {
    Text = "密契等级已达上限"
  },
  TipsType_10705_Desc = {
    Text = "消耗材料数量已达上限"
  },
  TipsType_10706_Desc = {
    Text = "最多锁定两个副属性"
  },
  TipsType_10707_Desc = {
    Text = "转录材料不足"
  },
  TipsType_10708_Desc = {
    Text = "唤醒体升格{s1}阶后开启"
  },
  TipsType_10709_Desc = {
    Text = "「{s1}」不足"
  },
  TipsType_10710_Desc = {Text = "已售罄"},
  TipsType_10711_Desc = {
    Text = "此商品未解锁"
  },
  TipsType_10712_Desc = {
    Text = "消耗材料已满"
  },
  TipsType_10713_Desc = {
    Text = "命轮叠位已达上限"
  },
  TipsType_10714_Desc = {
    Text = "不满足事件条件，无法选择"
  },
  TipsType_10715_Desc = {
    Text = "请安装对应app后再进行分享"
  },
  TipsType_10716_Desc = {
    Text = "无法再选中更多的命轮"
  },
  TipsType_10717_Desc = {
    Text = "无法再选中更多的钥令"
  },
  TipsType_10718_Desc = {
    Text = "激活成功"
  },
  TipsType_10719_Desc = {
    Text = "「千面印章」不足，可在「置换设置」中选择材料置换"
  },
  TipsType_10720_Desc = {
    Text = "已切换为1倍速"
  },
  TipsType_10721_Desc = {
    Text = "已切换为2倍速"
  },
  TipsType_10722_Desc = {
    Text = "校园入口拥堵中，请稍后重试"
  },
  TipsType_10723_Desc = {
    Text = "保存成功"
  },
  TipsType_10724_Desc = {
    Text = "保存失败，相册权限未开启或内存不足"
  },
  TipsType_10725_Desc = {
    Text = "消耗素材不足"
  },
  TipsType_10726_Desc = {
    Text = "请选择卡牌"
  },
  TipsType_10727_Desc = {
    Text = "该唤醒体已被禁用"
  },
  TipsType_10728_Desc = {
    Text = "本源形态不可派遣，请重新选择"
  },
  TipsType_10736_Desc = {
    Text = "「灵啡肽」已充足，无需补充"
  },
  TipsType_10737_Desc = {
    Text = "检测到新的游戏版本，请重新启动游戏更新以保证正常体验。"
  },
  TipsType_10738_Desc = {
    Text = "当前没有待阅读的教学"
  },
  TipsType_10739_Desc = {
    Text = "{s1}已在{s2}中进行过挑战，无法重复上场"
  },
  TipsType_10740_Desc = {
    Text = "当前调查等级{s1}低于推荐等级{s2}，调查可能会遇到较大的挑战，是否确认？"
  },
  TipsType_10740_LeftBtnDesc = {Text = "取消"},
  TipsType_10740_RightBtnDesc = {Text = "确认"},
  TipsType_10740_Title = {
    Text = "调查确认"
  },
  TipsType_10741_Desc = {
    Text = "当前队伍平均等级{s1}和守密人调查等级{s2}均低于推荐等级，调查会遇到非常大的挑战，是否确认？"
  },
  TipsType_10741_LeftBtnDesc = {Text = "取消"},
  TipsType_10741_RightBtnDesc = {Text = "确认"},
  TipsType_10741_Title = {
    Text = "调查确认"
  },
  TipsType_10742_Desc = {
    Text = "队伍中相同的命轮效果无法重复生效，当前<Blue:{s1}>存在命轮未生效的情况，建议守密人重新调整命轮装备后再进行调查。\n是否仍要进行调查？"
  },
  TipsType_10742_LeftBtnDesc = {Text = "取消"},
  TipsType_10742_RightBtnDesc = {Text = "确认"},
  TipsType_10742_Title = {
    Text = "调查确认"
  },
  TipsType_10743_Desc = {
    Text = "融灾禁区无剩余助战次数"
  },
  TipsType_10744_Desc = {
    Text = "关注人数已达上限"
  },
  TipsType_10745_Desc = {
    Text = "生日日期有误，无法设置"
  },
  TipsType_10746_Desc = {
    Text = "已复制到剪切板"
  },
  TipsType_10747_Desc = {
    Text = "点赞成功"
  },
  TipsType_10748_Desc = {
    Text = "{s1}已是助战唤醒体"
  },
  TipsType_10749_Desc = {
    Text = "助战唤醒体不可为空"
  },
  TipsType_10750_Desc = {
    Text = "今日已点赞过该守密人了"
  },
  TipsType_10751_Desc = {
    Text = "最多可以展示4名唤醒体"
  },
  TipsType_10752_Desc = {
    Text = "界域不符合要求，无法上场"
  },
  TipsType_10753_Desc = {
    Text = "{s1}已经上阵，不可重复选择"
  },
  TipsType_10754_Desc = {
    Text = "{s1}已重置"
  },
  TipsType_10755_Desc = {
    Text = "解锁成功"
  },
  TipsType_10756_Desc = {
    Text = "当前无叠位材料可放入"
  },
  TipsType_10757_Desc = {
    Text = "{s1}已经在今日本次活动中进行过挑战，无法再次上场"
  },
  TipsType_10758_Desc = {
    Text = "队伍界域不满足要求"
  },
  TipsType_10761_Desc = {
    Text = "本源形态唤醒体无法与其普通形态同时出战"
  },
  TipsType_10762_Desc = {
    Text = "本源形态唤醒体无法与其普通形态同时展示"
  },
  TipsType_10799_Desc = {
    Text = "当前<Blue:{s1}>的密契6件套效果由于<Blue:队伍唯一>的限制未生效，建议守密人重新调整密契后再进行调查。\n是否仍要进行调查？"
  },
  TipsType_10799_LeftBtnDesc = {Text = "取消"},
  TipsType_10799_RightBtnDesc = {Text = "确认"},
  TipsType_10799_Title = {
    Text = "调查确认"
  },
  TipsType_10801_Desc = {
    Text = "密契方案数量已达上限"
  },
  TipsType_10802_Desc = {
    Text = "{s1}已在其他密契方案中使用，无法保存方案"
  },
  TipsType_10803_Desc = {
    Text = "密契方案名不允许为空"
  },
  TipsType_10804_Desc = {
    Text = "包含非法字符，请重新输入"
  },
  TipsType_10805_Desc = {Text = "已保存"},
  TipsType_10806_Desc = {
    Text = "当前密契已在{s1}中应用"
  },
  TipsType_10807_Desc = {Text = "已装备"},
  TipsType_10808_Desc = {Text = "已卸下"},
  TipsType_10809_Desc = {
    Text = "当前队伍已出战"
  },
  TipsType_10810_Desc = {
    Text = "密契方案不可为空"
  },
  TipsType_10811_Desc = {
    Text = "当前已装备该方案"
  },
  TipsType_10812_Desc = {Text = "已装备"},
  TipsType_10813_Desc = {
    Text = "是否确认删除方案【{s1}】？"
  },
  TipsType_10813_LeftBtnDesc = {Text = "取消"},
  TipsType_10813_RightBtnDesc = {Text = "确认"},
  TipsType_10814_Desc = {
    Text = "本次调查上阵唤醒体不符合队伍要求"
  },
  TipsType_10815_Desc = {
    Text = "当前唤醒体为剧情特殊设计，无法查看详情"
  },
  TipsType_10816_Desc = {
    Text = "「代理凭证」不足"
  },
  TipsType_10817_Desc = {
    Text = "当前没有您的结算记录，请先「挑战」并在次日9:00 结算后再执行。"
  },
  TipsType_10818_Desc = {
    Text = "今日代理已完成，不可重复代理"
  },
  TipsType_10821_Desc = {
    Text = "当前暂无物资，请稍后再来"
  },
  TipsType_10822_Desc = {
    Text = "活动已结束"
  },
  TipsType_10823_Desc = {
    Text = "特殊种子售罄后才可要求商铺进行补货"
  },
  TipsType_10824_Desc = {
    Text = "补货次数已用完，没有更多的货物储备了"
  },
  TipsType_10825_Desc = {
    Text = "「{s1}」不足"
  },
  TipsType_10826_Desc = {
    Text = "特殊种子已售罄，可选择播种进行重置"
  },
  TipsType_10827_Desc = {
    Text = "特殊种子已重置"
  },
  TipsType_10828_Desc = {
    Text = "物品已全部交换完，请选择重置"
  },
  TipsType_10829_Desc = {
    Text = "重置成功"
  },
  TipsType_10830_Desc = {
    Text = "队伍中存在无法上场的唤醒体，无法进入调查"
  },
  TipsType_10831_Desc = {
    Text = "队伍中存在相同命轮，无法进入融灾禁区"
  },
  TipsType_10832_Desc = {
    Text = "队伍未装备钥令，无法进入调查"
  },
  TipsType_10833_Desc = {
    Text = "队伍中存在无法装备的命轮，无法进入调查"
  },
  TipsType_10834_Desc = {
    Text = "不可为助战唤醒体装备命轮"
  },
  TipsType_10835_Desc = {
    Text = "不可为助战唤醒体装备密契"
  },
  TipsType_10836_Desc = {
    Text = "不可为剧情预设唤醒体装备命轮"
  },
  TipsType_10837_Desc = {
    Text = "不可为剧情预设唤醒体装备密契"
  },
  TipsType_10838_Desc = {
    Text = "表情方案中的表情数量已达上限"
  },
  TipsType_10839_Desc = {
    Text = "表情已使用，点击表情方案中的表情可卸下"
  },
  TipsType_10840_Desc = {
    Text = "表情发送太快啦"
  },
  TipsType_10841_Desc = {
    Text = "表情方案不可为空"
  },
  TipsType_10842_Desc = {
    Text = "表情方案已更新"
  },
  TipsType_10843_Desc = {
    Text = "此条目尚未解锁"
  },
  TipsType_10844_Desc = {
    Text = "尚未解锁"
  },
  TipsType_10850_Desc = {
    Text = "队伍中存在无法装备的钥令，无法进入调查"
  },
  TipsType_10901_Desc = {Text = "麻痹"},
  TipsType_10902_Desc = {Text = "昏迷"},
  TipsType_10903_Desc = {
    Text = "暂未拥有：{s1}"
  },
  TipsType_10904_Desc = {
    Text = "通关本章「普通」模式后，解锁「溯梦」模式观赏剧情"
  },
  TipsType_10905_Desc = {
    Text = "完成「调查行动」1-15·普通 后解锁 「溯梦」观赏剧情"
  },
  TipsType_10906_Desc = {
    Text = "「现实起点」不足"
  },
  TipsType_10907_Desc = {Text = "已解锁"},
  TipsType_10908_Desc = {
    Text = "{s1}启灵等级已满，继续领取将转为<TipsHighlightText:「灵魂回溯碎片」× 2>、<TipsHighlightText:「根源沉淀」× 250>，是否确认唤醒？"
  },
  TipsType_10908_LeftBtnDesc = {Text = "取消"},
  TipsType_10908_RightBtnDesc = {Text = "确认"},
  TipsType_10908_Title = {
    Text = "唤醒确认"
  },
  TipsType_10909_Desc = {
    Text = "{s1}已唤醒，继续领取将转为<TipsHighlightText:「残片·{s2}」× 1>和<TipsHighlightText:「根源沉淀」× 50>，是否确认唤醒？"
  },
  TipsType_10909_LeftBtnDesc = {Text = "取消"},
  TipsType_10909_RightBtnDesc = {Text = "确认"},
  TipsType_10909_Title = {
    Text = "唤醒确认"
  },
  TipsType_10910_Desc = {
    Text = "是否确认唤醒<TipsHighlightText:{s1}>？"
  },
  TipsType_10910_LeftBtnDesc = {Text = "取消"},
  TipsType_10910_RightBtnDesc = {Text = "确认"},
  TipsType_10910_Title = {
    Text = "唤醒确认"
  },
  TipsType_10911_Desc = {
    Text = "空间不足"
  },
  TipsType_10912_Desc = {
    Text = "超维空间尚无指令卡，不可使用"
  },
  TipsType_10913_Desc = {
    Text = "本回合无法再次使用"
  },
  TipsType_10914_Desc = {
    Text = "是否确认选择<TipsHighlightText:{s1}>？"
  },
  TipsType_10914_LeftBtnDesc = {Text = "取消"},
  TipsType_10914_RightBtnDesc = {Text = "确认"},
  TipsType_10914_Title = {
    Text = "任选确认"
  },
  TipsType_10915_Desc = {
    Text = "解锁编队需按顺序进行，不可跳过未解锁的编队"
  },
  TipsType_10916_Desc = {
    Text = "是否消耗<Blue: {s1} × {s2}> 解锁？"
  },
  TipsType_10916_LeftBtnDesc = {Text = "取消"},
  TipsType_10916_RightBtnDesc = {Text = "确认"},
  TipsType_10916_Title = {
    Text = "解锁确认"
  },
  TipsType_10917_Desc = {
    Text = "成功解锁 {s1}"
  },
  TipsType_10918_Desc = {
    Text = "成功解锁{s1}，队伍已全部解锁完毕"
  },
  TipsType_10919_Desc = {
    Text = "完成[{s1}：{s2}]后解锁，是否前往[{s1}]?"
  },
  TipsType_10919_LeftBtnDesc = {Text = "取消"},
  TipsType_10919_RightBtnDesc = {Text = "确认"},
  TipsType_10919_Title = {
    Text = "暂未解锁"
  },
  TipsType_10920_Desc = {
    Text = "在限时活动「相位逆转」中积累「魔法橡果」× {s1} 即可解锁，是否前往「相位逆转」？"
  },
  TipsType_10920_LeftBtnDesc = {Text = "取消"},
  TipsType_10920_RightBtnDesc = {Text = "确认"},
  TipsType_10920_Title = {
    Text = "暂未解锁"
  },
  TipsType_10921_Desc = {
    Text = "无法同时装备两个主属性相同的命轮"
  },
  TipsType_20001_Desc = {
    Text = "带勾选二次确认"
  },
  TipsType_20001_LeftBtnDesc = {Text = "确定"},
  TipsType_20001_Title = {Text = "标题"},
  TipsType_20002_Desc = {
    Text = "不带勾选二次确认"
  },
  TipsType_20002_LeftBtnDesc = {Text = "取消"},
  TipsType_20002_RightBtnDesc = {Text = "确定"},
  TipsType_20002_Title = {Text = "标题"},
  TipsType_20003_Desc = {
    Text = "您的账号已在其他设备登录。"
  },
  TipsType_20003_RightBtnDesc = {Text = "确认"},
  TipsType_20003_Title = {
    Text = "断线提示"
  },
  TipsType_20004_Desc = {
    Text = "与服务器连接断开，请重新登录。"
  },
  TipsType_20004_RightBtnDesc = {Text = "确认"},
  TipsType_20004_Title = {
    Text = "断线提示"
  },
  TipsType_20005_Desc = {
    Text = "同步失败，是否再次尝试？"
  },
  TipsType_20005_LeftBtnDesc = {Text = "取消"},
  TipsType_20005_RightBtnDesc = {Text = "确认"},
  TipsType_20005_Title = {
    Text = "同步失败"
  },
  TipsType_20006_Desc = {
    Text = "失去同步，稍后将返回登录界面。"
  },
  TipsType_20006_RightBtnDesc = {Text = "确认"},
  TipsType_20006_Title = {
    Text = "同步失败"
  },
  TipsType_20007_Desc = {
    Text = "失去同步，稍后将返回登录界面。"
  },
  TipsType_20007_RightBtnDesc = {Text = "确认"},
  TipsType_20007_Title = {
    Text = "同步失败"
  },
  TipsType_20008_Desc = {
    Text = "本次调查消耗体力 <Positive:{s1}>，是否确认结束？"
  },
  TipsType_20008_LeftBtnDesc = {Text = "取消"},
  TipsType_20008_RightBtnDesc = {Text = "确认"},
  TipsType_20008_Title = {
    Text = "结束勘探"
  },
  TipsType_20009_Desc = {
    Text = "刷新将会更新刻印和造物，唤醒体觉醒和出售指令卡的次数不会重置，是否确认？"
  },
  TipsType_20009_LeftBtnDesc = {Text = "取消"},
  TipsType_20009_RightBtnDesc = {Text = "确认"},
  TipsType_20009_Title = {
    Text = "确认刷新"
  },
  TipsType_20010_Desc = {
    Text = "此界域唤醒体数量不足，是否继续创建队伍？"
  },
  TipsType_20010_LeftBtnDesc = {Text = "取消"},
  TipsType_20010_RightBtnDesc = {Text = "确认"},
  TipsType_20011_Desc = {
    Text = "未选择任何唤醒体，编队不予保留。"
  },
  TipsType_20011_LeftBtnDesc = {
    Text = "确认离开"
  },
  TipsType_20011_RightBtnDesc = {
    Text = "继续编队"
  },
  TipsType_20012_Desc = {
    Text = "未选择唤醒体"
  },
  TipsType_20012_RightBtnDesc = {Text = "确认"},
  TipsType_20013_Desc = {
    Text = "队伍尚有空缺，是否确认启程？"
  },
  TipsType_20013_LeftBtnDesc = {Text = "返回"},
  TipsType_20013_RightBtnDesc = {Text = "启程"},
  TipsType_20014_Desc = {
    Text = "队伍数量已达上限。"
  },
  TipsType_20014_RightBtnDesc = {Text = "确认"},
  TipsType_20015_Desc = {
    Text = "是否删除此队伍？"
  },
  TipsType_20015_LeftBtnDesc = {Text = "取消"},
  TipsType_20015_RightBtnDesc = {Text = "确认"},
  TipsType_20016_Desc = {
    Text = "{s1}通关后解锁"
  },
  TipsType_20016_RightBtnDesc = {Text = "确认"},
  TipsType_20017_Desc = {
    Text = "此处可查看地图信息和已经打过的怪物信息，当前版本暂未开发"
  },
  TipsType_20017_RightBtnDesc = {Text = "确认"},
  TipsType_20018_Desc = {
    Text = "暂未达到关卡解锁条件"
  },
  TipsType_20018_RightBtnDesc = {Text = "确认"},
  TipsType_20018_Title = {
    Text = "快速勘探"
  },
  TipsType_20019_Desc = {
    Text = "「银芯」不足，是否前往商城购买？"
  },
  TipsType_20019_LeftBtnDesc = {Text = "取消"},
  TipsType_20019_RightBtnDesc = {Text = "前往"},
  TipsType_20020_Desc = {
    Text = "进阶{s1}通关后解锁此进阶难度"
  },
  TipsType_20020_RightBtnDesc = {Text = "确认"},
  TipsType_20021_Desc = {
    Text = "{s1}普通模式通关后解锁进阶训练"
  },
  TipsType_20021_RightBtnDesc = {Text = "确认"},
  TipsType_20022_Desc = {
    Text = "「银芯」不足，是否前往购买"
  },
  TipsType_20022_LeftBtnDesc = {Text = "取消"},
  TipsType_20022_RightBtnDesc = {Text = "确认"},
  TipsType_20022_Title = {
    Text = "银芯不足"
  },
  TipsType_20023_Desc = {
    Text = "本次升级溢出{s1}点经验（不返还），且角色达到等级上限后无法继续获得经验，是否继续？"
  },
  TipsType_20023_LeftBtnDesc = {Text = "取消"},
  TipsType_20023_RightBtnDesc = {Text = "确认"},
  TipsType_20024_Desc = {
    Text = "队伍未满编，无法进入副本。"
  },
  TipsType_20024_RightBtnDesc = {Text = "确认"},
  TipsType_20026_Desc = {
    Text = "是否确认充能？"
  },
  TipsType_20026_LeftBtnDesc = {Text = "取消"},
  TipsType_20026_RightBtnDesc = {Text = "确认"},
  TipsType_20027_Desc = {
    Text = "是否确认恢复生命？"
  },
  TipsType_20027_LeftBtnDesc = {Text = "取消"},
  TipsType_20027_RightBtnDesc = {Text = "确认"},
  TipsType_20028_Desc = {
    Text = "关闭此界面将放弃拾取【{s1}】，是否放弃？"
  },
  TipsType_20028_LeftBtnDesc = {Text = "取消"},
  TipsType_20028_RightBtnDesc = {Text = "确认"},
  TipsType_20029_Desc = {
    Text = "关闭此界面将跳过本次事件（造物不会被移除），是否确认？"
  },
  TipsType_20029_LeftBtnDesc = {Text = "取消"},
  TipsType_20029_RightBtnDesc = {Text = "确认"},
  TipsType_20030_Desc = {
    Text = "已勾选造物将不会携带，是否放弃继承？"
  },
  TipsType_20030_LeftBtnDesc = {Text = "取消"},
  TipsType_20030_RightBtnDesc = {Text = "确认"},
  TipsType_20031_Desc = {
    Text = "是否确认退出战斗？"
  },
  TipsType_20031_LeftBtnDesc = {Text = "取消"},
  TipsType_20031_RightBtnDesc = {Text = "确认"},
  TipsType_20032_Desc = {
    Text = "当前关卡暂未解锁，是否前往通关调查关卡解锁？"
  },
  TipsType_20032_LeftBtnDesc = {Text = "取消"},
  TipsType_20032_RightBtnDesc = {Text = "确认"},
  TipsType_20032_Title = {
    Text = "暂未解锁"
  },
  TipsType_20033_Desc = {
    Text = "当前挑战次数不足，是否消耗「银芯」× 500 重置？"
  },
  TipsType_20033_LeftBtnDesc = {Text = "取消"},
  TipsType_20033_RightBtnDesc = {Text = "确认"},
  TipsType_20034_Desc = {
    Text = "当前挑战冷却中，是否消耗「银芯」× 50 重置？"
  },
  TipsType_20034_LeftBtnDesc = {Text = "取消"},
  TipsType_20034_RightBtnDesc = {Text = "确认"},
  TipsType_20035_Desc = {
    Text = "推荐等级为{s1}，当前队伍平均等级为{s2}，调查将遇到阻碍，是否继续进行？"
  },
  TipsType_20035_LeftBtnDesc = {Text = "取消"},
  TipsType_20035_RightBtnDesc = {Text = "确认"},
  TipsType_20035_Title = {
    Text = "战力不足"
  },
  TipsType_20036_Desc = {
    Text = "当前扫荡次数设定为{s1}，但挑战副本仅会消耗{s2}体力获得1次奖励，是否确认挑战？"
  },
  TipsType_20036_LeftBtnDesc = {Text = "取消"},
  TipsType_20036_RightBtnDesc = {Text = "确认"},
  TipsType_20036_Title = {
    Text = "挑战确认"
  },
  TipsType_20037_Desc = {
    Text = "强化素材中包含高级素材，是否确定强化？"
  },
  TipsType_20037_LeftBtnDesc = {Text = "取消"},
  TipsType_20037_RightBtnDesc = {Text = "确认"},
  TipsType_20037_Title = {
    Text = "强化确认"
  },
  TipsType_20038_Desc = {
    Text = "这件装备正处于锁定状态，是否解除锁定？"
  },
  TipsType_20038_LeftBtnDesc = {Text = "取消"},
  TipsType_20038_RightBtnDesc = {Text = "确认"},
  TipsType_20039_Desc = {
    Text = "确认后本次调查将会失败，无法获得后续调查奖励，是否确认结束调查？"
  },
  TipsType_20039_LeftBtnDesc = {Text = "取消"},
  TipsType_20039_RightBtnDesc = {Text = "确认"},
  TipsType_20039_Title = {
    Text = "退出调查"
  },
  TipsType_20040_Desc = {
    Text = "<WeaponEffect_Num:主动退出调查将消耗「灵啡肽」× {s1}。>确认后本次调查将会失败，无法获得后续调查奖励，是否确认结束调查？"
  },
  TipsType_20040_LeftBtnDesc = {Text = "取消"},
  TipsType_20040_RightBtnDesc = {Text = "确认"},
  TipsType_20040_Title = {
    Text = "退出调查"
  },
  TipsType_20041_BottomDesc = {
    Text = "当前拥有时间压缩许可：{s1}"
  },
  TipsType_20041_Desc = {
    Text = "是否消耗{s1}个时间压缩许可加速？"
  },
  TipsType_20041_LeftBtnDesc = {Text = "取消"},
  TipsType_20041_RightBtnDesc = {Text = "确认"},
  TipsType_20041_Title = {
    Text = "加速确认"
  },
  TipsType_20042_Desc = {
    Text = "RPG战斗调整中，当前直接结算胜利"
  },
  TipsType_20042_LeftBtnDesc = {Text = "取消"},
  TipsType_20042_RightBtnDesc = {Text = "确认"},
  TipsType_20043_Desc = {
    Text = "是否花费 {s1} 银芯，刷新当前任务？"
  },
  TipsType_20043_LeftBtnDesc = {Text = "取消"},
  TipsType_20043_RightBtnDesc = {Text = "确认"},
  TipsType_20043_Title = {
    Text = "任务刷新"
  },
  TipsType_20044_BottomDesc = {
    Text = "消耗：{s1}研究许可"
  },
  TipsType_20044_Desc = {
    Text = "是否进行{s1}的研究？\n研究效果: {s2}"
  },
  TipsType_20044_LeftBtnDesc = {Text = "取消"},
  TipsType_20044_RightBtnDesc = {Text = "确认"},
  TipsType_20044_Title = {
    Text = "研究确认"
  },
  TipsType_20045_BottomDesc = {
    Text = "取消研究不保留已研究进度"
  },
  TipsType_20045_Desc = {
    Text = "是否取消{s1}的研究？(将返还全额研究许可)"
  },
  TipsType_20045_LeftBtnDesc = {Text = "取消"},
  TipsType_20045_RightBtnDesc = {Text = "确认"},
  TipsType_20045_Title = {
    Text = "研究取消"
  },
  TipsType_20046_Desc = {
    Text = "是否消耗 {s1} 「银芯」加速？"
  },
  TipsType_20046_LeftBtnDesc = {Text = "取消"},
  TipsType_20046_RightBtnDesc = {Text = "确认"},
  TipsType_20046_Title = {
    Text = "加速确认"
  },
  TipsType_20047_Desc = {
    Text = "缺少 {s1} 个<Blue:「{s2}」>，是否消耗<Blue:「银芯」×{s3} >购买？"
  },
  TipsType_20047_LeftBtnDesc = {Text = "取消"},
  TipsType_20047_RightBtnDesc = {Text = "确认"},
  TipsType_20047_Title = {
    Text = "购买确认"
  },
  TipsType_20048_Desc = {
    Text = "缺少 {s1} 个<Blue:「{s2}」>，是否消耗<Blue:「银芯」×{s3} >购买？"
  },
  TipsType_20048_LeftBtnDesc = {Text = "取消"},
  TipsType_20048_RightBtnDesc = {Text = "确认"},
  TipsType_20048_Title = {
    Text = "购买确认"
  },
  TipsType_20049_Desc = {
    Text = "<Blue:「{s1}」> 已被 <Blue:「{s2}」> 所装备，是否确认更换？"
  },
  TipsType_20049_LeftBtnDesc = {Text = "取消"},
  TipsType_20049_RightBtnDesc = {Text = "确认"},
  TipsType_20049_Title = {
    Text = "更换提示"
  },
  TipsType_20050_Desc = {
    Text = "消耗命轮已经过叠位，是否确认？"
  },
  TipsType_20050_LeftBtnDesc = {Text = "取消"},
  TipsType_20050_RightBtnDesc = {Text = "确认"},
  TipsType_20050_Title = {
    Text = "叠位提示"
  },
  TipsType_20051_Desc = {
    Text = "当前叠位将超过命轮的叠位等级上限，叠位后将根据溢出等级返还相应数量的命轮，是否确认？"
  },
  TipsType_20051_LeftBtnDesc = {Text = "取消"},
  TipsType_20051_RightBtnDesc = {Text = "确认"},
  TipsType_20051_Title = {
    Text = "叠位提示"
  },
  TipsType_20052_Desc = {
    Text = "推荐等级为{s1}，当前队伍平均等级为{s2}，调查将遇到较大阻碍，是否继续进行？"
  },
  TipsType_20052_LeftBtnDesc = {Text = "取消"},
  TipsType_20052_RightBtnDesc = {Text = "确认"},
  TipsType_20052_Title = {
    Text = "战力不足"
  },
  TipsType_20053_Desc = {
    Text = "推荐等级为{s1}，当前队伍平均等级为{s2}，调查将遇到极大阻碍，是否继续进行？"
  },
  TipsType_20053_LeftBtnDesc = {Text = "取消"},
  TipsType_20053_RightBtnDesc = {Text = "确认"},
  TipsType_20053_Title = {
    Text = "战力不足"
  },
  TipsType_20054_Desc = {
    Text = "当前挑战奖励已全部领取，继续挑战将不会获得奖励，是否确认？"
  },
  TipsType_20054_LeftBtnDesc = {Text = "取消"},
  TipsType_20054_RightBtnDesc = {Text = "确认"},
  TipsType_20054_Title = {
    Text = "挑战确认"
  },
  TipsType_20055_Desc = {
    Text = "重置后，当前关卡进度将会重置为0颗星，唤醒体出战记录同步清除，是否确认重置？"
  },
  TipsType_20055_LeftBtnDesc = {Text = "取消"},
  TipsType_20055_RightBtnDesc = {Text = "确认"},
  TipsType_20055_Title = {
    Text = "重置确认"
  },
  TipsType_20056_Desc = {
    Text = "挑战成功后，当前编队的四名唤醒体将无法出战{s1}的其他关卡，是否确认挑战？"
  },
  TipsType_20056_LeftBtnDesc = {Text = "取消"},
  TipsType_20056_RightBtnDesc = {Text = "确认"},
  TipsType_20056_Title = {
    Text = "挑战确认"
  },
  TipsType_20057_Desc = {
    Text = "队伍构成违背学院手册的推荐指示，是否仍要继续挑战？"
  },
  TipsType_20057_LeftBtnDesc = {Text = "取消"},
  TipsType_20057_RightBtnDesc = {Text = "确认"},
  TipsType_20057_Title = {
    Text = "编队确认"
  },
  TipsType_20058_Desc = {
    Text = "当前关卡已挑战成功，若希望重新挑战需先重置当前关卡进度为0颗星，唤醒体出战记录同步清除，是否确认重置？"
  },
  TipsType_20058_LeftBtnDesc = {Text = "取消"},
  TipsType_20058_RightBtnDesc = {Text = "确认"},
  TipsType_20058_Title = {
    Text = "重置确认"
  },
  TipsType_20059_Desc = {
    Text = "当前队伍唤醒体数量未满四个，无法进入战斗"
  },
  TipsType_20059_Title = {
    Text = "编队保存"
  },
  TipsType_20060_BottomDesc = {
    Text = "确认后将无法重新唤醒"
  },
  TipsType_20060_Desc = {
    Text = "是否选择本次唤醒结果（将获得本次唤醒的所有唤醒体和命轮）？"
  },
  TipsType_20060_LeftBtnDesc = {Text = "取消"},
  TipsType_20060_RightBtnDesc = {Text = "确认"},
  TipsType_20060_Title = {
    Text = "确认选择"
  },
  TipsType_20061_BottomDesc = {
    Text = "当前银芯：{s1}"
  },
  TipsType_20061_Desc = {
    Text = "是否消费  {s1} 「银芯」重新唤醒？\n重新唤醒将不保留本次抽卡结果"
  },
  TipsType_20061_LeftBtnDesc = {Text = "取消"},
  TipsType_20061_RightBtnDesc = {Text = "确认"},
  TipsType_20061_Title = {
    Text = "重新唤醒"
  },
  TipsType_20062_Desc = {
    Text = "确定要删除所有的已读信函吗？\n附件未领取的信函并不会删除"
  },
  TipsType_20062_LeftBtnDesc = {Text = "取消"},
  TipsType_20062_RightBtnDesc = {Text = "确认"},
  TipsType_20062_Title = {
    Text = "删除已读"
  },
  TipsType_20063_Desc = {
    Text = "确认删除？"
  },
  TipsType_20063_LeftBtnDesc = {Text = "取消"},
  TipsType_20063_RightBtnDesc = {Text = "确认"},
  TipsType_20063_Title = {
    Text = "删除当前信件"
  },
  TipsType_20064_Desc = {
    Text = "珍藏箱中的信函被删除后，将无法恢复，\n是否删除此信函？"
  },
  TipsType_20064_LeftBtnDesc = {Text = "取消"},
  TipsType_20064_RightBtnDesc = {Text = "确认"},
  TipsType_20064_Title = {
    Text = "删除珍藏信件"
  },
  TipsType_20065_Desc = {
    Text = "确认消耗 <Blue:{s1}> ，合成 <Blue:{s2}> 吗？"
  },
  TipsType_20065_LeftBtnDesc = {Text = "取消"},
  TipsType_20065_RightBtnDesc = {Text = "确认"},
  TipsType_20065_Title = {
    Text = "合成确认"
  },
  TipsType_20066_Desc = {
    Text = "确认分解<Blue:{s1}，获得{s2}>吗？"
  },
  TipsType_20066_LeftBtnDesc = {Text = "取消"},
  TipsType_20066_RightBtnDesc = {Text = "确认"},
  TipsType_20066_Title = {
    Text = "分解确认"
  },
  TipsType_20067_Desc = {
    Text = "确认消耗 <Blue:{s1}> 个SSR品阶密契，重印 <Blue:{s2}> 个 <Blue:{s3}> ？"
  },
  TipsType_20067_LeftBtnDesc = {Text = "取消"},
  TipsType_20067_RightBtnDesc = {Text = "确认"},
  TipsType_20067_Title = {
    Text = "重印确认"
  },
  TipsType_20068_Desc = {
    Text = "所有唤醒体彻底失去战斗能力\n\n唯一的守密人啊\n接下来你该如何选择？"
  },
  TipsType_20068_LeftBtnDesc = {
    Text = "重新战斗"
  },
  TipsType_20068_RightBtnDesc = {
    Text = "暂时撤退"
  },
  TipsType_20068_Title = {
    Text = "调查失败"
  },
  TipsType_20069_Desc = {
    Text = "当前选中唤醒体狂气已满，是否确定仍然选择该唤醒体"
  },
  TipsType_20069_LeftBtnDesc = {Text = "取消"},
  TipsType_20069_RightBtnDesc = {Text = "确认"},
  TipsType_20069_Title = {
    Text = "确定选择"
  },
  TipsType_20070_Desc = {
    Text = "是否确认使用{s1}？\n等级与技能已提升的唤醒体将不会返还升级物资"
  },
  TipsType_20070_LeftBtnDesc = {Text = "取消"},
  TipsType_20070_RightBtnDesc = {Text = "确认"},
  TipsType_20070_Title = {
    Text = "增幅确认"
  },
  TipsType_20071_Desc = {
    Text = "受守密人调查等级限制，唤醒体等级将提升至{s1}级，缺少的升级物资不会返还，是否确认提升？"
  },
  TipsType_20071_LeftBtnDesc = {Text = "取消"},
  TipsType_20071_RightBtnDesc = {Text = "确认"},
  TipsType_20071_Title = {
    Text = "增幅确认"
  },
  TipsType_20072_Desc = {
    Text = "确认跳过本小节全部剧情吗？\n注：之后您可重新进入本关卡观看剧情。"
  },
  TipsType_20072_LeftBtnDesc = {Text = "取消"},
  TipsType_20072_RightBtnDesc = {Text = "确认"},
  TipsType_20072_Title = {
    Text = "跳过剧情"
  },
  TipsType_20073_Desc = {
    Text = "确认分解{s1}，获得{s2}吗？\n（当前密契已强化，分解不返还强化物资）"
  },
  TipsType_20073_LeftBtnDesc = {Text = "取消"},
  TipsType_20073_RightBtnDesc = {Text = "确认"},
  TipsType_20073_Title = {
    Text = "分解确认"
  },
  TipsType_20074_Desc = {
    Text = "确认分解{s1}，获得{s2}吗？\n（当前命轮稀有度较高）"
  },
  TipsType_20074_LeftBtnDesc = {Text = "取消"},
  TipsType_20074_RightBtnDesc = {Text = "确认"},
  TipsType_20074_Title = {
    Text = "分解确认"
  },
  TipsType_20075_BottomDesc = {
    Text = "消耗：{s1}研究许可"
  },
  TipsType_20075_Desc = {
    Text = "是否启动{s1}研究？\n生产效率: {s2}蔷薇金券/每6小时\n      ——>{s3}蔷薇金券/每6小时"
  },
  TipsType_20075_LeftBtnDesc = {Text = "取消"},
  TipsType_20075_RightBtnDesc = {Text = "确认"},
  TipsType_20075_Title = {
    Text = "研究确认"
  },
  TipsType_20076_BottomDesc = {
    Text = "消耗：{s1}研究许可"
  },
  TipsType_20076_Desc = {
    Text = "是否启动{s1}的研究？\n生产效率: {s2}灵知制剂/每6小时\n      ——>{s3}灵知制剂/每6小时"
  },
  TipsType_20076_LeftBtnDesc = {Text = "取消"},
  TipsType_20076_RightBtnDesc = {Text = "确认"},
  TipsType_20076_Title = {
    Text = "研究确认"
  },
  TipsType_20077_BottomDesc = {
    Text = "消耗：{s1}研究许可"
  },
  TipsType_20077_Desc = {
    Text = "是否启动{s1}的研究？\n生产效率: {s2}密契回痕/每6小时\n      ——>{s3}密契回痕/每6小时"
  },
  TipsType_20077_LeftBtnDesc = {Text = "取消"},
  TipsType_20077_RightBtnDesc = {Text = "确认"},
  TipsType_20077_Title = {
    Text = "研究确认"
  },
  TipsType_20078_Desc = {
    Text = "确认跳过本段全部剧情？\n注：之后您可重新进入本关卡观看剧情。"
  },
  TipsType_20078_LeftBtnDesc = {Text = "取消"},
  TipsType_20078_RightBtnDesc = {Text = "确认"},
  TipsType_20078_Title = {
    Text = "跳过剧情"
  },
  TipsType_20079_Desc = {
    Text = "银钥感知到致命危机，是否启用应急灵知体？\n（复活将消耗1次应急灵知体，应急灵知体每日9点自动获得1次，当前剩余次数：{s1}/{s2}）"
  },
  TipsType_20079_LeftBtnDesc = {Text = "取消"},
  TipsType_20079_RightBtnDesc = {Text = "确认"},
  TipsType_20079_Title = {
    Text = "复活确认"
  },
  TipsType_20080_Desc = {
    Text = "银钥感知到致命危机，是否启用应急灵知体？\n（复活将消耗1次应急灵知体，应急灵知体每日9点自动获得1次，当前剩余次数：{s1}/{s2}）"
  },
  TipsType_20080_RightBtnDesc = {Text = "确认"},
  TipsType_20080_Title = {
    Text = "复活确认"
  },
  TipsType_20081_Desc = {
    Text = "游戏初始化失败。{s1}"
  },
  TipsType_20081_RightBtnDesc = {Text = "确认"},
  TipsType_20081_Title = {
    Text = "登录错误提示"
  },
  TipsType_20082_Desc = {
    Text = "是否消耗<Blue:「银芯」× {s1} >购买<Blue: {s2} >级?"
  },
  TipsType_20082_LeftBtnDesc = {Text = "取消"},
  TipsType_20082_RightBtnDesc = {Text = "确认"},
  TipsType_20082_Title = {
    Text = "提升等级"
  },
  TipsType_20083_Desc = {
    Text = "消耗的命轮{s1}，是否确认强化？"
  },
  TipsType_20083_LeftBtnDesc = {Text = "取消"},
  TipsType_20083_RightBtnDesc = {Text = "确认"},
  TipsType_20083_Title = {
    Text = "消耗确认"
  },
  TipsType_20084_Desc = {
    Text = "队伍平均等级低于关卡推荐等级，出场唤醒体的属性将受到削弱，是否依然选择调查？"
  },
  TipsType_20084_LeftBtnDesc = {
    Text = "前往提升"
  },
  TipsType_20084_RightBtnDesc = {Text = "确认"},
  TipsType_20084_Title = {
    Text = "调查确认"
  },
  TipsType_20085_Desc = {
    Text = "确认退出游戏"
  },
  TipsType_20085_LeftBtnDesc = {Text = "取消"},
  TipsType_20085_RightBtnDesc = {Text = "确认"},
  TipsType_20085_Title = {
    Text = "退出游戏"
  },
  TipsType_20086_Desc = {
    Text = "服务器维护中"
  },
  TipsType_20086_RightBtnDesc = {Text = "确认"},
  TipsType_20086_Title = {
    Text = "断线提示"
  },
  TipsType_20087_Desc = {
    Text = "是否确认消耗<TipsHighlightText:{s1} × {s2}>，开启<TipsHighlightText:{s3}>？"
  },
  TipsType_20087_LeftBtnDesc = {Text = "取消"},
  TipsType_20087_RightBtnDesc = {Text = "确认"},
  TipsType_20087_Title = {
    Text = "开启确认"
  },
  TipsType_20088_Desc = {
    Text = "领取后「灵啡肽」将溢出，超出{s1}的部分无法获得。\n是否继续领取？"
  },
  TipsType_20088_LeftBtnDesc = {Text = "取消"},
  TipsType_20088_RightBtnDesc = {Text = "确认"},
  TipsType_20088_Title = {
    Text = "灵啡肽溢出"
  },
  TipsType_20089_Desc = {
    Text = "消耗「蔷薇金券」×<Blue: {s1} >刷新库存 \n 剩余刷新次数：<Blue:{s2}> \n 刷新次数越多，所需「蔷薇金券」数量越多"
  },
  TipsType_20089_LeftBtnDesc = {Text = "取消"},
  TipsType_20089_RightBtnDesc = {Text = "确认"},
  TipsType_20089_Title = {
    Text = "刷新库存"
  },
  TipsType_20090_Desc = {
    Text = "命轮数量已达上限，需要清理命轮后才能进行唤醒，是否前往？\n\n<color=#ADC0CB>*可在「设置」中设定SR/R级命轮自动分解</color>"
  },
  TipsType_20090_LeftBtnDesc = {Text = "取消"},
  TipsType_20090_RightBtnDesc = {
    Text = "前往清理"
  },
  TipsType_20090_Title = {
    Text = "清理提示"
  },
  TipsType_20091_Desc = {
    Text = "密契数量已达上限，需要清理密契后才能进行调查，是否前往？"
  },
  TipsType_20091_LeftBtnDesc = {Text = "取消"},
  TipsType_20091_RightBtnDesc = {
    Text = "前往清理"
  },
  TipsType_20091_Title = {
    Text = "清理提示"
  },
  TipsType_20092_Desc = {
    Text = "是否确认卸下当前唤醒体装备的所有命轮？"
  },
  TipsType_20092_LeftBtnDesc = {Text = "取消"},
  TipsType_20092_RightBtnDesc = {Text = "确认"},
  TipsType_20092_Title = {
    Text = "卸下确认"
  },
  TipsType_20093_Desc = {
    Text = "消耗密契已进行升级，是否确认？"
  },
  TipsType_20093_LeftBtnDesc = {Text = "取消"},
  TipsType_20093_RightBtnDesc = {Text = "确认"},
  TipsType_20093_Title = {
    Text = "升级确认"
  },
  TipsType_20094_Desc = {
    Text = "原副属性中存在较好的属性，替换后将不会保存，是否确认替换？"
  },
  TipsType_20094_LeftBtnDesc = {Text = "取消"},
  TipsType_20094_RightBtnDesc = {Text = "确认"},
  TipsType_20094_Title = {
    Text = "替换确认"
  },
  TipsType_20095_Desc = {
    Text = "当前转录出的副属性中存在较好的属性，继续转录将不会保存，是否确认？"
  },
  TipsType_20095_LeftBtnDesc = {Text = "取消"},
  TipsType_20095_RightBtnDesc = {Text = "确认"},
  TipsType_20095_Title = {
    Text = "转录确认"
  },
  TipsType_20096_Desc = {
    Text = "密契升级后将会溢出等级上限，溢出后将返还转录材料，是否确认？"
  },
  TipsType_20096_LeftBtnDesc = {Text = "取消"},
  TipsType_20096_RightBtnDesc = {Text = "确认"},
  TipsType_20096_Title = {
    Text = "升级确认"
  },
  TipsType_20097_Desc = {
    Text = "该唤醒体启灵已满\n选择后将仅获得「灵魂回溯碎片」×1"
  },
  TipsType_20097_LeftBtnDesc = {Text = "取消"},
  TipsType_20097_RightBtnDesc = {Text = "继续"},
  TipsType_20097_Title = {
    Text = "确认选择"
  },
  TipsType_20098_Desc = {
    Text = "该商品可使用<Blue:{s1}>张密银交易凭证购买"
  },
  TipsType_20098_LeftBtnDesc = {
    Text = "现金支付"
  },
  TipsType_20098_RightBtnDesc = {
    Text = "凭证支付"
  },
  TipsType_20098_Title = {
    Text = "结算方式选择"
  },
  TipsType_20099_Desc = {
    Text = "是否退出游戏？"
  },
  TipsType_20099_LeftBtnDesc = {Text = "取消"},
  TipsType_20099_RightBtnDesc = {Text = "确认"},
  TipsType_20099_Title = {Text = "提示"},
  TipsType_20100_Desc = {
    Text = "检测到新的游戏版本，请重新启动游戏进行资源更新"
  },
  TipsType_20100_RightBtnDesc = {Text = "确认"},
  TipsType_20100_Title = {
    Text = "更新提示"
  },
  TipsType_20101_Desc = {
    Text = "该调查已完成，重新调查是否选择跳过剧情？"
  },
  TipsType_20101_LeftBtnDesc = {
    Text = "跳过剧情"
  },
  TipsType_20101_RightBtnDesc = {
    Text = "保留剧情"
  },
  TipsType_20101_Title = {
    Text = "剧情确认"
  },
  TipsType_20102_Desc = {
    Text = "确定不再关注{s1}？"
  },
  TipsType_20102_LeftBtnDesc = {Text = "取消"},
  TipsType_20102_RightBtnDesc = {Text = "确认"},
  TipsType_20102_Title = {
    Text = "取消关注"
  },
  TipsType_20103_Desc = {
    Text = "活动期间<WeaponEffect_Num:限时免费>解锁，是否解锁？"
  },
  TipsType_20103_LeftBtnDesc = {Text = "取消"},
  TipsType_20103_RightBtnDesc = {Text = "确认"},
  TipsType_20103_Title = {
    Text = "活动福利"
  },
  TipsType_20105_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20105_LeftBtnDesc = {Text = "退出"},
  TipsType_20105_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20105_Title = {
    Text = "调查确认"
  },
  TipsType_20106_Desc = {
    Text = "是否消耗<Blue:「源液」×  {s1} >购买？"
  },
  TipsType_20106_LeftBtnDesc = {Text = "取消"},
  TipsType_20106_RightBtnDesc = {Text = "购买"},
  TipsType_20106_Title = {
    Text = "购买确认"
  },
  TipsType_20107_Desc = {
    Text = "确定要选择 <Blue:{s1}> 吗？"
  },
  TipsType_20107_LeftBtnDesc = {Text = "取消"},
  TipsType_20107_RightBtnDesc = {Text = "确认"},
  TipsType_20107_Title = {
    Text = "选择确认"
  },
  TipsType_20108_Desc = {
    Text = "本次叠位将消耗稀有物品「循环母版」\n是否继续？"
  },
  TipsType_20108_LeftBtnDesc = {Text = "取消"},
  TipsType_20108_RightBtnDesc = {Text = "确认"},
  TipsType_20108_Title = {
    Text = "消耗确认"
  },
  TipsType_20109_Desc = {
    Text = "确定要重新开始本次战斗吗？"
  },
  TipsType_20109_LeftBtnDesc = {Text = "取消"},
  TipsType_20109_RightBtnDesc = {Text = "确认"},
  TipsType_20109_Title = {
    Text = "重新战斗"
  },
  TipsType_20110_Desc = {
    Text = "确认选择{s1}月{s2}日作为你的生日吗?\n确认后将无法修改。"
  },
  TipsType_20110_LeftBtnDesc = {Text = "取消"},
  TipsType_20110_RightBtnDesc = {Text = "确认"},
  TipsType_20110_Title = {
    Text = "生日确认"
  },
  TipsType_20111_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20111_LeftBtnDesc = {Text = "退出"},
  TipsType_20111_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20111_Title = {
    Text = "调查确认"
  },
  TipsType_20112_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20112_LeftBtnDesc = {Text = "退出"},
  TipsType_20112_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20112_Title = {
    Text = "调查确认"
  },
  TipsType_20113_Desc = {
    Text = "是否将所有已获得的教学内容标记为已阅读，并领取教学奖励？（建议新入学的守密人仔细阅读教学内容~）"
  },
  TipsType_20113_LeftBtnDesc = {Text = "取消"},
  TipsType_20113_RightBtnDesc = {Text = "确认"},
  TipsType_20113_Title = {
    Text = "一键阅读确认"
  },
  TipsType_20114_Desc = {
    Text = "确认选择<WeaponEffect_Num:{s1}>开启回溯吗？\n此操作不可回退，请谨慎确认"
  },
  TipsType_20114_LeftBtnDesc = {Text = "取消"},
  TipsType_20114_RightBtnDesc = {Text = "确认"},
  TipsType_20114_Title = {
    Text = "回溯选择"
  },
  TipsType_201151_Desc = {
    Text = "当前唤醒体没有启灵，无需进行启灵回溯"
  },
  TipsType_20115_Desc = {
    Text = "当前唤醒体未经过任何养成，无需进行养成回溯"
  },
  TipsType_20116_Desc = {
    Text = "<WeaponEffect_Num:{s1}>已开启回溯。\n是否立即前往进行回溯？"
  },
  TipsType_20116_LeftBtnDesc = {Text = "取消"},
  TipsType_20116_RightBtnDesc = {Text = "前往"},
  TipsType_20116_Title = {
    Text = "开启成功"
  },
  TipsType_20117_Desc = {
    Text = "即将重置唤醒体的升级、升格、技能、天赋和灵知深化状态，并返还相应消耗。\n确认对<WeaponEffect_Num:{s1}>进行养成回溯吗？"
  },
  TipsType_20117_LeftBtnDesc = {Text = "取消"},
  TipsType_20117_RightBtnDesc = {Text = "确认"},
  TipsType_20117_Title = {
    Text = "养成回溯"
  },
  TipsType_20118_Desc = {
    Text = "即将重置唤醒体的启灵等级，并返还启灵消耗。\n确认对<WeaponEffect_Num:{s1}>进行启灵回溯吗？"
  },
  TipsType_20118_LeftBtnDesc = {Text = "取消"},
  TipsType_20118_RightBtnDesc = {Text = "确认"},
  TipsType_20118_Title = {
    Text = "启灵回溯"
  },
  TipsType_20119_Desc = {
    Text = "即将重置唤醒体的升级、升格、技能、启灵、天赋和灵知深化状态，返还相应消耗，\n并将唤醒体归还至黑池。\n确认对<WeaponEffect_Num:{s1}>进行黑池归还吗？"
  },
  TipsType_20119_LeftBtnDesc = {Text = "取消"},
  TipsType_20119_RightBtnDesc = {Text = "确认"},
  TipsType_20119_Title = {
    Text = "黑池归还"
  },
  TipsType_20120_Desc = {
    Text = "特殊唤醒体不可进行归还"
  },
  TipsType_20121_Desc = {
    Text = "即将重置命轮的叠位状态，并返还所有叠位消耗。\n确认对<WeaponEffect_Num:{s1}>进行叠位回溯吗？"
  },
  TipsType_20121_LeftBtnDesc = {Text = "取消"},
  TipsType_20121_RightBtnDesc = {Text = "确认"},
  TipsType_20121_Title = {
    Text = "叠位回溯"
  },
  TipsType_20122_Desc = {
    Text = "即将重置命轮的叠位状态，返还所有叠位消耗，并将命轮归还至黑池。\n确认对<WeaponEffect_Num:{s1}>进行黑池归还吗？"
  },
  TipsType_20122_LeftBtnDesc = {Text = "取消"},
  TipsType_20122_RightBtnDesc = {Text = "确认"},
  TipsType_20122_Title = {
    Text = "黑池归还"
  },
  TipsType_20123_Desc = {
    Text = "完成挑战后，队伍中的唤醒体、命轮和钥令将无法在其他融灾禁区中上场，是否确认？"
  },
  TipsType_20123_LeftBtnDesc = {Text = "取消"},
  TipsType_20123_RightBtnDesc = {Text = "确认"},
  TipsType_20123_Title = {
    Text = "挑战确认"
  },
  TipsType_20124_Desc = {
    Text = "重置后，当前调查队伍的唤醒体、命轮和钥令都可以重新上场，但通过该关卡获得的特训值也会扣除（不影响奖励状态），是否确认重置？"
  },
  TipsType_20124_LeftBtnDesc = {Text = "取消"},
  TipsType_20124_RightBtnDesc = {Text = "确认"},
  TipsType_20124_Title = {
    Text = "重置确认"
  },
  TipsType_20125_Desc = {
    Text = "当前命轮叠位等级为0，不需要叠位回溯"
  },
  TipsType_20126_Desc = {
    Text = "当前唤醒体正在派遣中，请召回后再进行回溯或归还"
  },
  TipsType_20127_Desc = {
    Text = "当前命轮已锁定，归还前请先解除锁定"
  },
  TipsType_20128_Desc = {
    Text = "{s1}已通关，需要进行重置才可以进行挑战，是否确认重置？\n（重置后，调查队伍中的唤醒体、命轮和钥令可重新上场，但通过该关卡获得的特训值也会扣除。）"
  },
  TipsType_20128_LeftBtnDesc = {Text = "取消"},
  TipsType_20128_RightBtnDesc = {Text = "确认"},
  TipsType_20128_Title = {
    Text = "重置确认"
  },
  TipsType_20129_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20129_LeftBtnDesc = {Text = "退出"},
  TipsType_20129_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20129_Title = {
    Text = "调查确认"
  },
  TipsType_20130_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20130_LeftBtnDesc = {Text = "退出"},
  TipsType_20130_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20130_Title = {
    Text = "调查确认"
  },
  TipsType_20131_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20131_LeftBtnDesc = {Text = "退出"},
  TipsType_20131_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20131_Title = {
    Text = "调查确认"
  },
  TipsType_20132_Desc = {
    Text = "勾选后，若<TipsHighlightText:密契残本>充足，则优先消耗残本。\n若残本不足，则自动消耗 <TipsHighlightText:「{s1}」> 补足残本。"
  },
  TipsType_20132_LeftBtnDesc = {Text = "取消"},
  TipsType_20132_RightBtnDesc = {
    Text = "仍要勾选"
  },
  TipsType_20132_Title = {
    Text = "自动补足"
  },
  TipsType_20133_Desc = {
    Text = "是否对 <TipsHighlightText:「{s1}」> 进行灵知深化？"
  },
  TipsType_20133_LeftBtnDesc = {Text = "取消"},
  TipsType_20133_RightBtnDesc = {Text = "确认"},
  TipsType_20133_Title = {
    Text = "灵知深化"
  },
  TipsType_20134_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20134_LeftBtnDesc = {Text = "退出"},
  TipsType_20134_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20134_Title = {
    Text = "调查确认"
  },
  TipsType_20137_Desc = {
    Text = "确认消耗<Blue:「{s1}」×{s2}>解锁该曲目吗？"
  },
  TipsType_20137_LeftBtnDesc = {Text = "取消"},
  TipsType_20137_RightBtnDesc = {Text = "确认"},
  TipsType_20137_Title = {
    Text = "解锁确认"
  },
  TipsType_20138_Desc = {
    Text = "活动期间内 <Blue:限时免费>解锁，是否解锁？"
  },
  TipsType_20138_LeftBtnDesc = {Text = "取消"},
  TipsType_20138_RightBtnDesc = {Text = "确认"},
  TipsType_20138_Title = {
    Text = "解锁确认"
  },
  TipsType_20139_Desc = {
    Text = "确认消耗<Blue:「{s1}」×{s3}> ，开启<Blue:「{s2}」>吗？"
  },
  TipsType_20139_LeftBtnDesc = {Text = "取消"},
  TipsType_20139_RightBtnDesc = {Text = "确认"},
  TipsType_20139_Title = {
    Text = "解锁确认"
  },
  TipsType_20140_Desc = {
    Text = "<Blue:「{s1}」>当前已达持有上限，继续领取将无法获得该道具。是否领取？"
  },
  TipsType_20140_LeftBtnDesc = {Text = "取消"},
  TipsType_20140_RightBtnDesc = {Text = "确认"},
  TipsType_20140_Title = {
    Text = "领取确认"
  },
  TipsType_20141_Desc = {
    Text = "是否以 30%的最大生命({s1})为代价\n跳过战斗，立即消灭敌人？\n\n当前生命:{s2}"
  },
  TipsType_20141_LeftBtnDesc = {Text = "取消"},
  TipsType_20141_RightBtnDesc = {Text = "确认"},
  TipsType_20141_Title = {
    Text = "肌肉记忆"
  },
  TipsType_20142_Desc = {
    Text = "是否选择失去 <color=#BB646D> {s1} </color> 点生命，获得 {s2} 枚黑印？"
  },
  TipsType_20142_LeftBtnDesc = {Text = "取消"},
  TipsType_20142_RightBtnDesc = {Text = "确认"},
  TipsType_20142_Title = {
    Text = "调查确认"
  },
  TipsType_20145_LeftBtnDesc = {Text = "取消"},
  TipsType_20145_Title = {
    Text = "登录奖励"
  },
  TipsType_20151_Desc = {
    Text = "重置后，「特殊物品」的剩余数量将重置至上限，是否确认？"
  },
  TipsType_20151_LeftBtnDesc = {Text = "取消"},
  TipsType_20151_RightBtnDesc = {Text = "确认"},
  TipsType_20151_Title = {
    Text = "重置确认"
  },
  TipsType_20152_Desc = {
    Text = "「{s1}」不足，是否使用「蔷薇金券」× {s2}补齐？"
  },
  TipsType_20152_LeftBtnDesc = {Text = "取消"},
  TipsType_20152_RightBtnDesc = {Text = "确认"},
  TipsType_20152_Title = {
    Text = "激活确认"
  },
  TipsType_20153_Desc = {
    Text = "重置后，「特殊物品」和「普通物品」的剩余数量会重置至上限。\n第{s1}次及之后，「特殊物品」将不会再重置。\n是否确认？"
  },
  TipsType_20153_LeftBtnDesc = {Text = "取消"},
  TipsType_20153_RightBtnDesc = {Text = "确认"},
  TipsType_20153_Title = {
    Text = "重置确认"
  },
  TipsType_20154_Desc = {
    Text = "重置后，「特殊物品」和「普通物品」的剩余数量会重置至上限。\n第3次及之后，「特殊物品」将不会再重置。\n <Blue:当前仍有「普通物品」>，是否确认？"
  },
  TipsType_20154_LeftBtnDesc = {Text = "取消"},
  TipsType_20154_RightBtnDesc = {Text = "确认"},
  TipsType_20154_Title = {
    Text = "重置确认"
  },
  TipsType_20155_Desc = {
    Text = "叠位材料中包含已上锁的命轮，是否确认消耗用于叠位？"
  },
  TipsType_20155_LeftBtnDesc = {Text = "取消"},
  TipsType_20155_RightBtnDesc = {Text = "确认"},
  TipsType_20155_Title = {
    Text = "叠位确认"
  },
  TipsType_20156_Desc = {
    Text = "是否确认消耗<TipsHighlightText:「现实起点」× 1>解锁？\n（欲海翻波活动期间，解锁所需的「现实起点」从{s1}个降低为{s2}个。）"
  },
  TipsType_20156_LeftBtnDesc = {Text = "取消"},
  TipsType_20156_RightBtnDesc = {Text = "确认"},
  TipsType_20156_Title = {
    Text = "解锁确认"
  },
  TipsType_20157_Desc = {
    Text = "是否确认消耗<TipsHighlightText:「现实起点」× {s1}>解锁？"
  },
  TipsType_20157_LeftBtnDesc = {Text = "取消"},
  TipsType_20157_RightBtnDesc = {Text = "确认"},
  TipsType_20157_Title = {
    Text = "解锁确认"
  },
  TipsType_20158_Desc = {
    Text = "当前关卡已过期，完成挑战后将不会获得奖励，是否确认退出？"
  },
  TipsType_20158_LeftBtnDesc = {Text = "取消"},
  TipsType_20158_RightBtnDesc = {Text = "确认"},
  TipsType_20158_Title = {
    Text = "退出确认"
  },
  TipsType_20159_Desc = {
    Text = "<TipsHighlightText:「{s1}」>超出上限<TipsHighlightText: {s2} >个，每个已转换为<Blue:「无形者的请柬」× 1>"
  },
  TipsType_20159_Title = {
    Text = "转换提示"
  },
  TipsType_20160_Desc = {
    Text = "你已解锁<TipsHighlightText:「{s1}」>\n本次活动的免费解锁福利将为你提供以下补偿。"
  },
  TipsType_20160_RightBtnDesc = {Text = "确认"},
  TipsType_20160_Title = {
    Text = "补偿提示"
  },
  TipsType_20161_Desc = {
    Text = "<TipsHighlightText:「{s1}」>超出上限<TipsHighlightText: {s2} >个，每个已转换为<Blue:「蔷薇金券」× 5000>"
  },
  TipsType_20161_Title = {
    Text = "转换提示"
  },
  TipsType_20162_Desc = {
    Text = "即将重置唤醒体的升级、升格、技能、天赋和灵知深化状态，并返还相应消耗。\n确认对<WeaponEffect_Num:{s1}>进行养成回溯吗？"
  },
  TipsType_20162_LeftBtnDesc = {Text = "取消"},
  TipsType_20162_RightBtnDesc = {Text = "确认"},
  TipsType_20162_Title = {
    Text = "养成回溯"
  },
  TipsType_20163_Desc = {
    Text = "即将重置唤醒体的启灵状态，并返还相应消耗。\n确认对<WeaponEffect_Num:{s1}>进行养成回溯吗？"
  },
  TipsType_20163_LeftBtnDesc = {Text = "取消"},
  TipsType_20163_RightBtnDesc = {Text = "确认"},
  TipsType_20163_Title = {
    Text = "启灵回溯"
  },
  TipsType_20164_Desc = {
    Text = "即将重置唤醒体的升级、升格、技能、天赋、启灵和灵知深化状态，返还相应消耗，\n并将唤醒体归还至黑池。\n确认对<WeaponEffect_Num:{s1}>进行黑池归还吗？"
  },
  TipsType_20164_LeftBtnDesc = {Text = "取消"},
  TipsType_20164_RightBtnDesc = {Text = "确认"},
  TipsType_20164_Title = {
    Text = "黑池归还"
  },
  TipsType_20165_Desc = {
    Text = "<WeaponEffect_Num:{s1}>属于特殊唤醒体，仅能回溯升级、升格、技能、天赋和灵知深化养成，<Red:无法回溯启灵养成>，确认选择<WeaponEffect_Num:{s1}>开启回溯吗？\n此操作不可回退，请谨慎确认"
  },
  TipsType_20165_LeftBtnDesc = {Text = "取消"},
  TipsType_20165_RightBtnDesc = {Text = "确认"},
  TipsType_20165_Title = {
    Text = "回溯选择"
  },
  TipsType_20166_Desc = {
    Text = "特殊唤醒体不可进行启灵回溯"
  },
  TipsType_20167_Desc = {
    Text = "本次回溯已使用过「养成回溯」，请下次回溯开启时进行「养成回溯」。"
  },
  TipsType_20168_Desc = {
    Text = "本次回溯已使用过「启灵回溯」，请下次回溯开启时进行「启灵回溯」。"
  },
  TipsType_20169_BottomDesc = {
    Text = "<Blue:注意：一旦选定，本次活动无法再更改！>"
  },
  TipsType_20169_Desc = {
    Text = "是否确认选择唤醒体<OrangeQuality:「{s1}」>以及推荐命轮<OrangeQuality:「{s2}」>，作为本期活动的定向UP。"
  },
  TipsType_20169_LeftBtnDesc = {Text = "取消"},
  TipsType_20169_RightBtnDesc = {Text = "确认"},
  TipsType_20169_Title = {
    Text = "确认选择"
  },
  TipsType_20170_Desc = {
    Text = "已达到每日挑战上限，请明天再来挑战吧！"
  },
  TipsType_20171_Desc = {
    Text = "现在可以前往「幻梦深潜」了！"
  },
  TipsType_20173_Desc = {
    Text = "现在可以前往「相位对弈」了！"
  },
  TipsType_20174_Desc = {
    Text = "现在可以前往「调查行动·困难」了！"
  },
  TipsType_20175_Desc = {
    Text = "现在可以前往「超验存在」了！"
  },
  TipsType_20176_Desc = {
    Text = "现在可以前往「融灾禁区」了！"
  },
  TipsType_20177_Desc = {
    Text = "现在可以前往「繁衍狂欢」了！"
  },
  TipsType_20178_Desc = {
    Text = "现在可以前往装备「第二命轮」了！"
  },
  TipsType_20179_Desc = {
    Text = "现在可以前往「混沌集群」了！"
  },
  TipsType_20180_Desc = {
    Text = "现在可以前往「禁忌纂录」了！"
  },
  TipsType_20181_Desc = {
    Text = "现在可以前往「密契升级」了！"
  },
  TipsType_20182_Desc = {
    Text = "现在可以前往「密契转录」了！"
  },
  TipsType_20183_Desc = {
    Text = "当前活动已结束"
  },
  TipsType_20184_Desc = {
    Text = "现在可以前往「学籍档案」了！"
  },
  TipsType_20185_Desc = {
    Text = "确认跳过本段全部剧情？"
  },
  TipsType_20185_LeftBtnDesc = {Text = "取消"},
  TipsType_20185_RightBtnDesc = {Text = "确认"},
  TipsType_20185_Title = {
    Text = "跳过剧情"
  },
  TipsType_20186_Desc = {
    Text = "将下载运行游戏的必要数据。\n是否继续？\n\n*建议在WiFi环境下进行下载。"
  },
  TipsType_20186_LeftBtnDesc = {Text = "取消"},
  TipsType_20186_RightBtnDesc = {Text = "确认"},
  TipsType_20187_Desc = {
    Text = "资源下载完成"
  },
  TipsType_20187_LeftBtnDesc = {Text = "确认"},
  TipsType_20188_Desc = {
    Text = "存储空间不足，需要预留至少{s1}存储空间，否则运行时可能导致资源丢失，是否继续下载新？"
  },
  TipsType_20188_LeftBtnDesc = {Text = "取消"},
  TipsType_20188_RightBtnDesc = {Text = "确认"},
  TipsType_20189_Desc = {
    Text = "资源下载失败，是否重试？"
  },
  TipsType_20189_LeftBtnDesc = {Text = "取消"},
  TipsType_20189_RightBtnDesc = {Text = "确认"},
  TipsType_20190_Desc = {
    Text = "<TipsHighlightText:{s1}>超出上限<TipsHighlightText: {s2} >个，每个已转换为<Blue:{s3}>"
  },
  TipsType_20190_Title = {
    Text = "转换提示"
  },
  TipsType_20191_Desc = {
    Text = "现在可以前往「活动」了！"
  },
  TipsType_20192_Desc = {
    Text = "将下载游玩序章后续内容的必要数据。\n资源大小：{s1}\n是否继续？\n\n*建议在WiFi环境下进行下载。"
  },
  TipsType_20192_LeftBtnDesc = {Text = "取消"},
  TipsType_20192_RightBtnDesc = {Text = "下载"},
  TipsType_20193_Desc = {
    Text = "现在可以前往「派遣」了！"
  },
  TipsType_20194_Desc = {
    Text = "现在可以前往「银芯通信」了！"
  },
  TipsType_20195_Desc = {
    Text = "现在可以前往「学期课题」了！"
  },
  TipsType_20196_Desc = {
    Text = "现在可以前往「无光之境」了！"
  },
  TipsType_20197_Desc = {
    Text = "已达最大可唤醒次数，请前往领取任务奖励！"
  },
  TipsType_20198_Desc = {
    Text = "还未完成任务，请完成任务后再来领取！"
  },
  TipsType_20199_Desc = {
    Text = "领取后「代理凭证」将超出拥有上限，\n超出部分将不会获得。\n是否继续领取？"
  },
  TipsType_20199_LeftBtnDesc = {Text = "取消"},
  TipsType_20199_RightBtnDesc = {Text = "确认"},
  TipsType_20199_Title = {
    Text = "领取确认"
  },
  TipsType_20200_Desc = {
    Text = "申请试训代理将消耗 <Blue:「代理凭证」× 1>\n申请后将直接完成每日试训，是否确认？"
  },
  TipsType_20200_LeftBtnDesc = {Text = "取消"},
  TipsType_20200_RightBtnDesc = {Text = "确认"},
  TipsType_20200_Title = {
    Text = "代理确认"
  },
  TipsType_20201_Desc = {
    Text = "以下密契正在装备中，是否进行替换？"
  },
  TipsType_20201_LeftBtnDesc = {Text = "取消"},
  TipsType_20201_RightBtnDesc = {Text = "确认"},
  TipsType_20201_Title = {
    Text = "替换确认"
  },
  TipsType_20202_Desc = {
    Text = "当前方案应用于{s1}，是否确认删除方案【{s2}】？"
  },
  TipsType_20202_LeftBtnDesc = {Text = "取消"},
  TipsType_20202_RightBtnDesc = {Text = "确认"},
  TipsType_20202_Title = {
    Text = "删除确认"
  },
  TipsType_20203_Desc = {
    Text = "队伍中相同的命轮效果无法重复生效，{s1}已在当前队伍装备，是否确认装备？"
  },
  TipsType_20203_LeftBtnDesc = {Text = "取消"},
  TipsType_20203_RightBtnDesc = {Text = "确认"},
  TipsType_20203_Title = {
    Text = "装备确认"
  },
  TipsType_20204_Desc = {
    Text = "当前密契已在{s1}中使用，分解后将会从该方案中移除，是否确认？"
  },
  TipsType_20204_LeftBtnDesc = {Text = "取消"},
  TipsType_20204_RightBtnDesc = {Text = "确认"},
  TipsType_20204_Title = {
    Text = "删除确认"
  },
  TipsType_20205_Desc = {
    Text = "当前密契已在编队{s1}中使用，分解后将会卸下该密契，是否确认？"
  },
  TipsType_20205_LeftBtnDesc = {Text = "取消"},
  TipsType_20205_RightBtnDesc = {Text = "确认"},
  TipsType_20205_Title = {
    Text = "删除确认"
  },
  TipsType_20206_Desc = {
    Text = "当前命轮已在编队{s1}中使用，分解后将会在编队中卸下该命轮，是否确认？"
  },
  TipsType_20206_LeftBtnDesc = {Text = "取消"},
  TipsType_20206_RightBtnDesc = {Text = "确认"},
  TipsType_20206_Title = {
    Text = "删除确认"
  },
  TipsType_20207_Desc = {
    Text = "当前方案尚未保存，退出后将清空本次编辑，是否确认退出？"
  },
  TipsType_20207_LeftBtnDesc = {Text = "取消"},
  TipsType_20207_RightBtnDesc = {Text = "确认"},
  TipsType_20207_Title = {
    Text = "保存确认"
  },
  TipsType_20208_Desc = {
    Text = "任务奖励已领取，去看看其它任务吧！"
  },
  TipsType_20209_Desc = {
    Text = "任务已过期"
  },
  TipsType_20210_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20210_LeftBtnDesc = {Text = "退出"},
  TipsType_20210_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20210_Title = {
    Text = "调查确认"
  },
  TipsType_20211_Desc = {
    Text = "{s1}天{s2}小时后开启"
  },
  TipsType_20212_Desc = {
    Text = "{s1}小时{s2}分后开启"
  },
  TipsType_20213_Desc = {
    Text = "<WeaponEffect_Num:{s1}>已在编队中触发超限因果，任意回溯将会导致超限因果失效，并且将会从编队中自动卸下，确认选择<WeaponEffect_Num:{s1}>开启回溯吗？\n此操作不可回退，请谨慎确认"
  },
  TipsType_20213_LeftBtnDesc = {Text = "取消"},
  TipsType_20213_RightBtnDesc = {Text = "确认"},
  TipsType_20213_Title = {
    Text = "回溯选择"
  },
  TipsType_20214_Desc = {
    Text = "即将重置命轮的叠位状态，并返还所有叠位消耗。\n<WeaponEffect_Num:{s1}>已在编队中触发超限因果，回溯后将会从编队中自动卸下。\n确认对<WeaponEffect_Num:{s1}>进行叠位回溯吗？"
  },
  TipsType_20214_LeftBtnDesc = {Text = "取消"},
  TipsType_20214_RightBtnDesc = {Text = "确认"},
  TipsType_20214_Title = {
    Text = "叠位回溯"
  },
  TipsType_20215_Desc = {
    Text = "即将重置命轮的叠位状态，返还所有叠位消耗，并将命轮归还至黑池。\n<WeaponEffect_Num:{s1}>已在编队中触发超限因果，归还后将会从编队中自动卸下。\n确认对<WeaponEffect_Num:{s1}>进行黑池归还吗？"
  },
  TipsType_20215_LeftBtnDesc = {Text = "取消"},
  TipsType_20215_RightBtnDesc = {Text = "确认"},
  TipsType_20215_Title = {
    Text = "黑池归还"
  },
  TipsType_20216_Desc = {
    Text = "是否消耗 <Blue:「{s1}」× {s2} >购买？"
  },
  TipsType_20216_LeftBtnDesc = {Text = "取消"},
  TipsType_20216_RightBtnDesc = {Text = "购买"},
  TipsType_20216_Title = {
    Text = "购买确认"
  },
  TipsType_20217_Desc = {
    Text = "{s1}将在{s2}后开启。"
  },
  TipsType_20218_Desc = {
    Text = "本次调查的预选唤醒体不可下场，只可替换为对应唤醒体"
  },
  TipsType_20219_Desc = {
    Text = "已上阵相同唤醒体，不可重复选择。"
  },
  TipsType_20220_Desc = {
    Text = "检测到当前没有使用WIFI，下载会消耗较多流量，是否确认下载？\n资源大小：{s1}\n是否继续？"
  },
  TipsType_20220_LeftBtnDesc = {Text = "取消"},
  TipsType_20220_RightBtnDesc = {Text = "下载"},
  TipsType_20221_Desc = {
    Text = "资源下载完成"
  },
  TipsType_20221_LeftBtnDesc = {Text = "确认"},
  TipsType_20222_Desc = {
    Text = "存储空间不足，需要预留至少{s1}存储空间，否则运行时可能导致资源丢失，是否继续下载新？"
  },
  TipsType_20222_LeftBtnDesc = {Text = "取消"},
  TipsType_20222_RightBtnDesc = {Text = "确认"},
  TipsType_20223_Desc = {
    Text = "资源下载失败，是否重试？"
  },
  TipsType_20223_LeftBtnDesc = {Text = "取消"},
  TipsType_20223_RightBtnDesc = {Text = "确认"},
  TipsType_20224_Desc = {
    Text = "将下载游玩序章后续内容的必要数据。\n资源大小：{s1}\n是否继续？\n\n*建议在WiFi环境下进行下载。"
  },
  TipsType_20224_LeftBtnDesc = {Text = "取消"},
  TipsType_20224_RightBtnDesc = {Text = "下载"},
  TipsType_20225_Desc = {
    Text = "{s1}已通关，是否进行额外挑战？\n额外挑战可以获得 {s2} 特训值"
  },
  TipsType_20225_LeftBtnDesc = {Text = "取消"},
  TipsType_20225_RightBtnDesc = {Text = "确认"},
  TipsType_20225_Title = {
    Text = "额外挑战"
  },
  TipsType_20226_Desc = {
    Text = "重置后，额外挑战队伍的唤醒体、钥令和命轮都可以重新上场，但该关卡额外通关获得的特训值也会扣除（不影响奖励状态），是否确认重置？"
  },
  TipsType_20226_LeftBtnDesc = {Text = "取消"},
  TipsType_20226_RightBtnDesc = {Text = "确认"},
  TipsType_20226_Title = {
    Text = "重置确认"
  },
  TipsType_20227_Desc = {
    Text = "重置后，当前调查队伍的唤醒体、钥令和命轮都可以重新上场，并且额外挑战队伍将替代当前调查队伍，但该关卡额外通关获得的特训值也会扣除（不影响奖励状态），是否确认重置？"
  },
  TipsType_20227_LeftBtnDesc = {Text = "取消"},
  TipsType_20227_RightBtnDesc = {Text = "确认"},
  TipsType_20227_Title = {
    Text = "重置确认"
  },
  TipsType_20228_Desc = {
    Text = "向下滑动列表查看更多公告"
  },
  TipsType_20229_Desc = {
    Text = "「<Blue:{s1}>」已达到叠位等级上限\n是否继续购买？\n剩余数量：{s2}"
  },
  TipsType_20229_LeftBtnDesc = {Text = "取消"},
  TipsType_20229_RightBtnDesc = {Text = "确认"},
  TipsType_20229_Title = {
    Text = "购买确认"
  },
  TipsType_20230_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20230_LeftBtnDesc = {Text = "退出"},
  TipsType_20230_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20230_Title = {
    Text = "调查确认"
  },
  TipsType_20231_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20231_LeftBtnDesc = {Text = "退出"},
  TipsType_20231_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20231_Title = {
    Text = "调查确认"
  },
  TipsType_20232_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20232_LeftBtnDesc = {Text = "退出"},
  TipsType_20232_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20232_Title = {
    Text = "调查确认"
  },
  TipsType_20233_Desc = {
    Text = "当前所需材料不足，是否消耗以下材料进行补全？"
  },
  TipsType_20233_LeftBtnDesc = {Text = "取消"},
  TipsType_20233_RightBtnDesc = {Text = "确认"},
  TipsType_20233_Title = {
    Text = "补全确认"
  },
  TipsType_20234_Desc = {
    Text = "该关卡只能装备指定钥令，无法进行替换。"
  },
  TipsType_20235_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20235_LeftBtnDesc = {Text = "退出"},
  TipsType_20235_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20235_Title = {
    Text = "调查确认"
  },
  TipsType_20236_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20236_LeftBtnDesc = {Text = "退出"},
  TipsType_20236_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20236_Title = {
    Text = "调查确认"
  },
  TipsType_20237_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20237_LeftBtnDesc = {Text = "退出"},
  TipsType_20237_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20237_Title = {
    Text = "调查确认"
  },
  TipsType_20238_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20238_LeftBtnDesc = {Text = "退出"},
  TipsType_20238_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20238_Title = {
    Text = "调查确认"
  },
  TipsType_20239_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20239_LeftBtnDesc = {Text = "退出"},
  TipsType_20239_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20239_Title = {
    Text = "调查确认"
  },
  TipsType_20240_Desc = {
    Text = "修复完成，请重新启动游戏"
  },
  TipsType_20240_RightBtnDesc = {Text = "确认"},
  TipsType_20240_Title = {
    Text = "温馨提示"
  },
  TipsType_20241_Desc = {
    Text = "还需{s1}个「<Blue:{s2}>」即可达到叠位等级上限\n是否继续购买？"
  },
  TipsType_20241_LeftBtnDesc = {Text = "取消"},
  TipsType_20241_RightBtnDesc = {Text = "确认"},
  TipsType_20241_Title = {
    Text = "购买确认"
  },
  TipsType_20250_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20250_LeftBtnDesc = {Text = "退出"},
  TipsType_20250_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20250_Title = {
    Text = "调查确认"
  },
  TipsType_20251_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20251_LeftBtnDesc = {Text = "退出"},
  TipsType_20251_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20251_Title = {
    Text = "调查确认"
  },
  TipsType_20252_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_20252_LeftBtnDesc = {Text = "退出"},
  TipsType_20252_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_20252_Title = {
    Text = "调查确认"
  },
  TipsType_20259_Desc = {
    Text = "已保存「千面印章」不足时的置换设置"
  },
  TipsType_20300_Desc = {
    Text = "已有 {s1} 定位唤醒体，无法在同一个队伍中使用同定位唤醒体。"
  },
  TipsType_20301_Desc = {
    Text = "现在可以前往「常训任务」了！"
  },
  TipsType_20351_Desc = {
    Text = "{s1}不足，是否使用{s2}{s3}兑换{s4}{s5}"
  },
  TipsType_20351_LeftBtnDesc = {Text = "取消"},
  TipsType_20351_RightBtnDesc = {Text = "确认"},
  TipsType_20351_Title = {Text = "{s1}不足"},
  TipsType_20352_Desc = {
    Text = "即将与对方绑定，绑定后无法解绑，确认要继续绑定吗？"
  },
  TipsType_20352_LeftBtnDesc = {Text = "取消"},
  TipsType_20352_RightBtnDesc = {Text = "确认"},
  TipsType_20352_Title = {
    Text = "邀请确认"
  },
  TipsType_20353_Desc = {
    Text = "邀请码已复制至剪切板。"
  },
  TipsType_20354_Desc = {
    Text = "您已是对方的邀请人。"
  },
  TipsType_20355_Desc = {
    Text = "不能输入自己的邀请码，尝试去获取其他守密人的邀请码吧。"
  },
  TipsType_20356_Desc = {
    Text = "重新游玩可再次体验序章剧情与教学！\n但重新游玩时关卡内容所有奖励均为演示，无法真正获取奖励。\n是否确认？"
  },
  TipsType_20356_LeftBtnDesc = {Text = "取消"},
  TipsType_20356_RightBtnDesc = {Text = "确认"},
  TipsType_20356_Title = {
    Text = "调查确认"
  },
  TipsType_20357_Desc = {
    Text = "确定不再关注这 {s1} 位守密人？"
  },
  TipsType_20357_LeftBtnDesc = {Text = "取消"},
  TipsType_20357_RightBtnDesc = {Text = "确认"},
  TipsType_20357_Title = {
    Text = "取消关注"
  },
  TipsType_20358_Desc = {
    Text = "有未确认的取消关注，离开将不保存任何操作，是否离开？"
  },
  TipsType_20358_LeftBtnDesc = {Text = "取消"},
  TipsType_20358_RightBtnDesc = {Text = "确认"},
  TipsType_20358_Title = {
    Text = "退出确认"
  },
  TipsType_20400_Desc = {
    Text = "<WeaponEffect_Num:「{s1}」>不足，是否前往兑换？"
  },
  TipsType_20400_LeftBtnDesc = {Text = "取消"},
  TipsType_20400_RightBtnDesc = {Text = "确认"},
  TipsType_20400_Title = {
    Text = "抽奖道具不足"
  },
  TipsType_300001_Desc = {
    Text = "「银辉初耀」只有一次免费唤醒的机会，确认要使用吗？"
  },
  TipsType_300001_LeftBtnDesc = {Text = "取消"},
  TipsType_300001_RightBtnDesc = {Text = "确认"},
  TipsType_300001_Title = {
    Text = "唤醒确认"
  },
  TipsType_300002_Desc = {
    Text = "确认选择本次唤醒结果吗？确认后本次唤醒将消耗免费5连抽次数"
  },
  TipsType_300002_LeftBtnDesc = {Text = "取消"},
  TipsType_300002_RightBtnDesc = {Text = "确认"},
  TipsType_300002_Title = {
    Text = "唤醒确认"
  },
  TipsType_30001_Desc = {
    Text = "侧边提示无图标"
  },
  TipsType_30002_Desc = {Text = "{s1}"},
  TipsType_30003_Desc = {Text = "{s1}解锁"},
  TipsType_30004_Desc = {
    Text = "{s1}进阶模式解锁"
  },
  TipsType_30005_Desc = {
    Text = "{s1}（困难）解锁"
  },
  TipsType_31000_Desc = {
    Text = "确定要使用此出生年月认证吗？出生年月一旦确定不可再更改！"
  },
  TipsType_31000_LeftBtnDesc = {Text = "取消"},
  TipsType_31000_RightBtnDesc = {Text = "确认"},
  TipsType_31000_Title = {
    Text = "年龄认证"
  },
  TipsType_31001_Desc = {
    Text = "本月已充值<Blue:{s1}>元，上限限制为<Blue:{s2}>元，请下个月再充值或换更低金额的挡位充值试试吧"
  },
  TipsType_31002_Desc = {
    Text = "请先完成年龄认证"
  },
  TipsType_31003_Desc = {
    Text = "银钥感知到致命危机，是否启用应急灵知体？\n（复活将消耗1次应急灵知体，应急灵知体每日9点自动获得1次，当前剩余次数：{s1}）\n<Blue:（首次复活不消耗应急灵知体）>"
  },
  TipsType_31003_LeftBtnDesc = {Text = "取消"},
  TipsType_31003_RightBtnDesc = {Text = "确认"},
  TipsType_31003_Title = {
    Text = "复活确认"
  },
  TipsType_31004_Desc = {
    Text = "银钥感知到致命危机，是否启用应急灵知体？\n（复活将消耗1次应急灵知体，应急灵知体每日9点自动获得1次，当前剩余次数：{s1}）\n<Blue:（首次复活不消耗应急灵知体）>"
  },
  TipsType_31004_RightBtnDesc = {Text = "确认"},
  TipsType_31004_Title = {
    Text = "复活确认"
  },
  TipsType_40001_Desc = {
    Text = "当生命降至0时，调查会强制结束。"
  },
  TipsType_40001_Title = {Text = "生命"},
  TipsType_40002_Desc = {
    Text = "地图移动、调查事件将会产生精神压力，压力累积会使守密人受到症状。\n每移动一格，压力提升10点。压力每满100点获得1个症状。\n当压力达到500后，每移动一格，扣除10%生命。"
  },
  TipsType_40002_Title = {Text = "压力"},
  TipsType_40003_Desc = {
    Text = "派遣等级越高，任务难度越高，派遣获得的奖励也相应提升。"
  },
  TipsType_40003_Title = {
    Text = "派遣等级"
  },
  TipsType_40004_Desc = {
    Text = "每回合打出的第 1 张指令卡的临时复制会进入超维空间。\n当超维空间达到上限时，获得 1 个额外的超维回合并保留护盾。\n界域精通效果：回合开始时有概率将 1 张「灵感」加入手中。"
  },
  TipsType_40004_Title = {
    Text = "超维空间"
  },
  TipsType_40005_Desc = {
    Text = "守密人可以通过调查、幕间演习等挑战提升自身等级。更多的玩法会随着守密人的等级提升而逐步解锁。"
  },
  TipsType_40005_Title = {Text = "等级"},
  TipsType_40006_Desc = {
    Text = "打出指令卡需要消耗算力。回合结束时不会保留剩余算力，回合开始时使算力恢复至上限。"
  },
  TipsType_40006_Title = {Text = "算力"},
  TipsType_40007_Desc = {
    Text = "银钥匙感知到一缕特殊能量，地图中或许隐藏着珍贵的物资……"
  },
  TipsType_40007_Title = {
    Text = "隐藏物资"
  },
  TipsType_40008_Desc = {
    Text = "战斗中遇到致命危机时可以发动，每次发动消耗1枚，使守密人生命和唤醒体狂气回复至上限，每天9点自动获得1枚。"
  },
  TipsType_40008_Title = {
    Text = "应急灵知体"
  },
  TipsType_40009_Desc = {
    Text = "打出指令卡需要消耗算力。回合结束时不会保留剩余算力，回合开始时算力上限 +1 并使算力恢复至上限。当前是第 {s1} 回合。"
  },
  TipsType_40009_Title = {Text = "算力"},
  TipsType_AbyssChallengeResetTips_Desc = {
    Text = "融灾禁区已重置，正在进行中的挑战将立即结束。"
  },
  TipsType_AbyssChallengeResetTips_RightBtnDesc = {Text = "确认"},
  TipsType_AbyssChallengeResetTips_Title = {Text = "提示"},
  TipsType_AbyssChallengeRevivalTips_Desc = {
    Text = "银钥感知到致命危机，是否启用应急灵知体？\n（复活将消耗 {s1} 个应急灵知体，应急灵知体每日 9 点自动获得 1 个）"
  },
  TipsType_AbyssChallengeRevivalTips_LeftBtnDesc = {Text = "取消"},
  TipsType_AbyssChallengeRevivalTips_RightBtnDesc = {Text = "确认"},
  TipsType_AbyssChallengeRevivalTips_Title = {
    Text = "复活确认"
  },
  TipsType_AcceptConfirm_Desc = {
    Text = "是否接受 <Blue:{s1}>的 <Blue:{s2}>邀请？"
  },
  TipsType_AcceptConfirm_LeftBtnDesc = {Text = "拒绝"},
  TipsType_AcceptConfirm_RightBtnDesc = {Text = "接受"},
  TipsType_AcceptConfirm_Title = {
    Text = "密码对战"
  },
  TipsType_ActivitySignRewardTaskNotCompleteTips_Desc = {
    Text = "完成对应任务即可进行唤醒"
  },
  TipsType_AlreadyIsBackgroundMusicTips_Desc = {
    Text = "已经是当前背景音乐"
  },
  TipsType_AwakerAutoInsertCoinNotEnoughTips_Desc = {
    Text = "「蔷薇金券」不足以完整使用当前拥有的「灵知制剂」，可补充「蔷薇金券」后再尝试。"
  },
  TipsType_AwakerNotOpenTips_Desc = {
    Text = "唤醒体暂未到开放时间，敬请期待"
  },
  TipsType_AwakerRandomChestConfirm_Desc = {
    Text = "确认消耗 <Blue:{s1}>，获得1个<Blue:随机>唤醒体吗？"
  },
  TipsType_AwakerRandomChestConfirm_LeftBtnDesc = {Text = "取消"},
  TipsType_AwakerRandomChestConfirm_RightBtnDesc = {Text = "确认"},
  TipsType_AwakerRandomChestConfirm_Title = {
    Text = "使用确认"
  },
  TipsType_BattleCreateFail_Desc = {
    Text = "战斗创建失败"
  },
  TipsType_BattlePassAllCompleteTips_Desc = {
    Text = "当前守密纪行已全部完成。"
  },
  TipsType_BestExperienceTips_Chapter3_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_BestExperienceTips_Chapter3_LeftBtnDesc = {Text = "退出"},
  TipsType_BestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_BestExperienceTips_Chapter3_Title = {
    Text = "调查确认"
  },
  TipsType_BestExperienceTips_Chapter7_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_BestExperienceTips_Chapter7_LeftBtnDesc = {Text = "退出"},
  TipsType_BestExperienceTips_Chapter7_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_BestExperienceTips_Chapter7_Title = {
    Text = "调查确认"
  },
  TipsType_BestExperienceTips_Chapter8_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_BestExperienceTips_Chapter8_LeftBtnDesc = {Text = "退出"},
  TipsType_BestExperienceTips_Chapter8_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_BestExperienceTips_Chapter8_Title = {
    Text = "调查确认"
  },
  TipsType_BestExperienceTips_ChapterS2_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_BestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "退出"},
  TipsType_BestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_BestExperienceTips_ChapterS2_Title = {
    Text = "调查确认"
  },
  TipsType_BestExperienceTips_ChapterS3_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_BestExperienceTips_ChapterS3_LeftBtnDesc = {Text = "退出"},
  TipsType_BestExperienceTips_ChapterS3_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_BestExperienceTips_ChapterS3_Title = {
    Text = "调查确认"
  },
  TipsType_BestExperienceTips_ChapterS4_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_BestExperienceTips_ChapterS4_LeftBtnDesc = {Text = "退出"},
  TipsType_BestExperienceTips_ChapterS4_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_BestExperienceTips_ChapterS4_Title = {
    Text = "调查确认"
  },
  TipsType_BestExperienceTips_ChapterS5_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_BestExperienceTips_ChapterS5_LeftBtnDesc = {Text = "退出"},
  TipsType_BestExperienceTips_ChapterS5_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_BestExperienceTips_ChapterS5_Title = {
    Text = "调查确认"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_LeftBtnDesc = {Text = "退出"},
  TipsType_BestExperienceTips_MainStoryS1_6_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Title = {
    Text = "调查确认"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_LeftBtnDesc = {Text = "退出"},
  TipsType_BestExperienceTips_TwoAnniversarySubStage_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Title = {
    Text = "调查确认"
  },
  TipsType_CancelCollectAwakerTips_Desc = {
    Text = "已取消收藏"
  },
  TipsType_CoinBulkBuyConfirm_Desc = {
    Text = "是否消耗「蔷薇金券」× {s1} 进行购买？"
  },
  TipsType_CoinBulkBuyConfirm_LeftBtnDesc = {Text = "取消"},
  TipsType_CoinBulkBuyConfirm_RightBtnDesc = {Text = "确认"},
  TipsType_CoinBulkBuyConfirm_Title = {
    Text = "购买确认"
  },
  TipsType_CollectAwakerTips_Desc = {
    Text = "收藏成功"
  },
  TipsType_CommonUseBattleHelpLimitTips_Desc = {
    Text = "常用助战守密人已达上限，请调整常用助战列表"
  },
  TipsType_DiskIsFullOrViolation_Desc = {
    Text = "文件写入失败，请检查设备剩余存储空间是否充足"
  },
  TipsType_DiskIsFullOrViolation_RightBtnDesc = {Text = "确认"},
  TipsType_DiskSpaceNotEnough_Desc = {
    Text = "存储空间不足，是否继续尝试下载？"
  },
  TipsType_DiskSpaceNotEnough_LeftBtnDesc = {Text = "取消"},
  TipsType_DiskSpaceNotEnough_RightBtnDesc = {Text = "确认"},
  TipsType_DoubleExBPBuyConfirm_Desc = {
    Text = "是否消耗<Blue:「源液」× {s1} >购买？\n <color=#ACBFCA>本期为特殊课题，核心课题的价格降低</color>"
  },
  TipsType_DoubleExBPBuyConfirm_LeftBtnDesc = {Text = "取消"},
  TipsType_DoubleExBPBuyConfirm_RightBtnDesc = {Text = "购买"},
  TipsType_DoubleExBPBuyConfirm_Title = {
    Text = "购买确认"
  },
  TipsType_EnterSix_DigitPasswordTips_Desc = {
    Text = "请输入 <color=#5EF2FF>相位值</color>"
  },
  TipsType_FilterMaxAwakerCountTips_Desc = {
    Text = "最多选择 {s1} 名唤醒体进行筛选"
  },
  TipsType_FollowBackConfirm_Desc = {
    Text = "确定对当前页的 <color=#5EF2FF>{s1}</color> 名追随者进行关注？\n\n<color=#96947F>当前关注 </color>{s2}<color=#A0A0A0>/{s3}\n超出上限之后将无法关注</color>"
  },
  TipsType_FollowBackConfirm_LeftBtnDesc = {Text = "取消"},
  TipsType_FollowBackConfirm_RightBtnDesc = {Text = "确认"},
  TipsType_FollowBackConfirm_Title = {
    Text = "回关确认"
  },
  TipsType_FrenziedOmenUpgradeConfirm_Desc = {
    Text = "此操作将消耗大量资源，适合想将唤醒体的能力培养到极限的情况，确认强化「疯狂预兆」吗？"
  },
  TipsType_FrenziedOmenUpgradeConfirm_LeftBtnDesc = {Text = "取消"},
  TipsType_FrenziedOmenUpgradeConfirm_RightBtnDesc = {Text = "确认"},
  TipsType_FrenziedOmenUpgradeConfirm_Title = {
    Text = "强化确认"
  },
  TipsType_GnosticPotentialUpgradeConfirm_Desc = {
    Text = "此操作将消耗大量资源，适合想将唤醒体的能力培养到极限的情况，确认强化「内在灵格」吗？"
  },
  TipsType_GnosticPotentialUpgradeConfirm_LeftBtnDesc = {Text = "取消"},
  TipsType_GnosticPotentialUpgradeConfirm_RightBtnDesc = {Text = "确认"},
  TipsType_GnosticPotentialUpgradeConfirm_Title = {
    Text = "强化确认"
  },
  TipsType_InCharging_Desc = {
    Text = "订单处理中，请勿重复支付。\n若支付已完成，请耐心等待系统发放奖励。\n若支付未完成，请尝试重启游戏后重试。\n如有疑问，请联系客服。"
  },
  TipsType_InCharging_RightBtnDesc = {Text = "确认"},
  TipsType_InCharging_Title = {
    Text = "温馨提示"
  },
  TipsType_KeyShortNameDownLoadTips_Desc = {
    Text = "正在下载文本标识资源，请过一会再尝试查看"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_Desc = {
    Text = "该唤醒体启灵已满\n选择后将仅获得「灵魂回溯碎片」× 2"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_LeftBtnDesc = {Text = "取消"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_RightBtnDesc = {Text = "继续"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_Title = {
    Text = "确认选择"
  },
  TipsType_MainResetBG_Desc = {
    Text = "是否需要将宿舍的背景<Blue:「画面」>与<Blue:「音乐」>恢复到默认？"
  },
  TipsType_MainResetBG_LeftBtnDesc = {Text = "取消"},
  TipsType_MainResetBG_RightBtnDesc = {Text = "确认"},
  TipsType_MainResetBG_Title = {
    Text = "恢复默认"
  },
  TipsType_MultiSelectBox_FixItemTips_Desc = {
    Text = "固定获得物品，不可更改"
  },
  TipsType_MultiSelectBox_SelectTips_Desc = {
    Text = "请完成所有自选物品选择后，才可进行购买"
  },
  TipsType_OppositeSideCancelMatchTips_Desc = {
    Text = "对方取消了匹配"
  },
  TipsType_OppositeSideRejectTips_Desc = {
    Text = "对方拒绝了<Blue:{s1}>的邀请，请重新选择模式"
  },
  TipsType_PVEExceedMaxRoundsTips_Desc = {
    Text = "战斗回合数已达上限\n\n唯一的守密人啊\n接下来你该如何选择？"
  },
  TipsType_PVEExceedMaxRoundsTips_LeftBtnDesc = {
    Text = "重新战斗"
  },
  TipsType_PVEExceedMaxRoundsTips_RightBtnDesc = {
    Text = "暂时撤退"
  },
  TipsType_PVEExceedMaxRoundsTips_Title = {
    Text = "调查失败"
  },
  TipsType_PVEReplayErrorTips_Desc = {
    Text = "获取战斗回放错误，请稍后重试"
  },
  TipsType_PVEReplayMaxRounds_Desc = {
    Text = "回放已达到25回合的最大限制，\n回放结束。"
  },
  TipsType_PVEReplayMaxRounds_RightBtnDesc = {Text = "确认"},
  TipsType_PVEReplayMaxRounds_Title = {
    Text = "结束确认"
  },
  TipsType_PVEReplayNoDataTips_Desc = {
    Text = "暂无调查行动记录"
  },
  TipsType_PVEReplayRepeatClickTips_Desc = {
    Text = "正在加载战斗回放，请勿重复操作"
  },
  TipsType_PVEReplaySpecialTeamAssignTips_Desc = {
    Text = "暂不支持特殊编队的战斗回放，敬请期待"
  },
  TipsType_PVEReplayTimeoutTips_Desc = {
    Text = "获取战斗回放超时"
  },
  TipsType_PVEReplayUnableOperateTips_Desc = {
    Text = "战斗回放中不可进行操作"
  },
  TipsType_PVETeamShareCodeCopyTips_Desc = {
    Text = "已复制到剪切板"
  },
  TipsType_PVETeamShareCodeError_Desc = {
    Text = "未能正确识别到剪切板内有 <color=#5EF2FF>调查行动</color> 编队"
  },
  TipsType_PVETeamShareCodeSaveTips_Desc = {
    Text = "是否确认保存该编队码对应的队伍配置？\n未持有该配置的部分将会被空置。"
  },
  TipsType_PVETeamShareCodeSaveTips_LeftBtnDesc = {Text = "取消"},
  TipsType_PVETeamShareCodeSaveTips_RightBtnDesc = {Text = "确认"},
  TipsType_PVETeamShareCodeSaveTips_Title = {
    Text = "保存确认"
  },
  TipsType_PVETeamShareCodeSpecialTeamAssignTips_Desc = {
    Text = "该队伍包含预设唤醒体，无法复制或导入编队码"
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_Desc = {
    Text = "对局已达回合上限，先手方未能终结对局，判为失败。"
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_RightBtnDesc = {Text = "确认"},
  TipsType_PVPExceedMaxRoundsTips_Loser_Title = {
    Text = "对战结束"
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_Desc = {
    Text = "对局已达回合上限，后手方成功坚守至终局，判为胜利。"
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_RightBtnDesc = {Text = "确认"},
  TipsType_PVPExceedMaxRoundsTips_Winner_Title = {
    Text = "对战结束"
  },
  TipsType_PVPSurrenderConfirm_Desc = {
    Text = "是否投降？"
  },
  TipsType_PVPSurrenderConfirm_LeftBtnDesc = {Text = "取消"},
  TipsType_PVPSurrenderConfirm_RightBtnDesc = {Text = "确认"},
  TipsType_PVPSurrenderConfirm_Title = {
    Text = "投降确认"
  },
  TipsType_PVPTeamShareCodeError_Desc = {
    Text = "未能正确识别到剪切板内有 <color=#5EF2FF>相位对弈</color> 编队"
  },
  TipsType_PVP_PasswordBattle_BlockTips_Desc = {
    Text = "是否需要拉黑这位守密人？"
  },
  TipsType_PVP_PasswordBattle_BlockTips_LeftBtnDesc = {Text = "拒绝"},
  TipsType_PVP_PasswordBattle_BlockTips_RightBtnDesc = {Text = "接受"},
  TipsType_PVP_PasswordBattle_BlockTips_Title = {
    Text = "是否拉黑"
  },
  TipsType_PVP_PasswordBattle_GameStartedTips_Desc = {
    Text = "本场密码对战已开始"
  },
  TipsType_PVP_PasswordBattle_OthersEnterTips_Desc = {
    Text = "有新的守密人进入了本场密码对战"
  },
  TipsType_PVP_PasswordBattle_QueueTips_Desc = {
    Text = "正在排队中……"
  },
  TipsType_PVP_PasswordBattle_QuitTips_Desc = {
    Text = "是否退出密码对战？"
  },
  TipsType_PVP_PasswordBattle_QuitTips_LeftBtnDesc = {Text = "取消"},
  TipsType_PVP_PasswordBattle_QuitTips_RightBtnDesc = {Text = "退出"},
  TipsType_PVP_PasswordBattle_QuitTips_Title = {
    Text = "退出确认"
  },
  TipsType_PVP_PasswordBattle_RejectedTips_Desc = {
    Text = "对方拒绝了与你对战"
  },
  TipsType_PassportHoistTips1_Desc = {
    Text = "「基础活性离子」\n·解锁后，本期课题持续期间在「日常试训」的「基础活性离子」累积奖励中获得的「现实起点」、「无垢之芯」、「经验」、「银芯」提升至 3 倍。购买「核心课题」后会补发本期已领取的「基础活性离子」累积奖励的额外倍率部分。"
  },
  TipsType_PassportHoistTips2_Desc = {
    Text = "「时序逆行」\n·可在战斗中返回经历过的回合。\n·可返回至战斗的前 25 回合中的任意一个回合。\n·重新挑战后依然可以使用逆行功能回到之前的回合。"
  },
  TipsType_PassportHoistTips3_Desc = {
    Text = "「相位对弈」\n·解锁后，本期课题持续期间可使用「相位对弈」全部卡牌。"
  },
  TipsType_Password_CopiedTips_Desc = {
    Text = " <color=#5EF2FF>相位值</color> 已复制到剪切板"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_Desc = {
    Text = "是否消耗<Blue:「源液」× {s1} >购买？\n\n<size=30><color=#ACBFCA>消耗「源液」时，优先扣除赠送的「源液」。\n（提取：{s2}，赠送：{s3}）</color></size>"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_LeftBtnDesc = {Text = "取消"},
  TipsType_PayMoneyBuyConfirmDescDetail_RightBtnDesc = {Text = "购买"},
  TipsType_PayMoneyBuyConfirmDescDetail_Title = {
    Text = "购买确认"
  },
  TipsType_PublishEmptyCommentTips_Desc = {
    Text = "评论内容不可为空"
  },
  TipsType_PvpCollectionCommentDeleteTips_Desc = {
    Text = "是否删除该评论？"
  },
  TipsType_PvpCollectionCommentDeleteTips_LeftBtnDesc = {Text = "取消"},
  TipsType_PvpCollectionCommentDeleteTips_RightBtnDesc = {Text = "确认"},
  TipsType_PvpCollectionCommentDeleteTips_Title = {
    Text = "删除确认"
  },
  TipsType_PvpHideCommentConfirm_Desc = {
    Text = "是否隐藏其所有评论？"
  },
  TipsType_PvpHideCommentConfirm_LeftBtnDesc = {Text = "否"},
  TipsType_PvpHideCommentConfirm_RightBtnDesc = {Text = "是"},
  TipsType_PvpHideCommentConfirm_Title = {Text = "隐藏"},
  TipsType_PvpMatchingInterruptTips_Desc = {
    Text = "检测到网络异常，匹配中断。"
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Desc = {
    Text = "尚在战斗中，是否继续之前的战斗？ \n「疾驰的欢愉专列」赛季已更新。继续挑战可完成最新赛季任务，但无法进入「贵宾名录」。"
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_LeftBtnDesc = {Text = "取消"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_RightBtnDesc = {Text = "确认"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Title = {Text = "提示"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Desc = {
    Text = "上次挑战进度为 {s1} - 第 {s2} 阶段 - 第 {s3} 场战斗，已获得「贵宾积分」× {s4}\n赛季已更新。继续挑战可完成最新赛季任务，但无法进入「贵宾名录」。是否要继续挑战？"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_LeftBtnDesc = {Text = "取消"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_RightBtnDesc = {Text = "确认"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Title = {
    Text = "继续挑战"
  },
  TipsType_RailWayContinueSaveStage_Desc = {
    Text = "上次挑战进度为 {s1} - 第 {s2} 阶段 - 第 {s3} 场战斗，已获得「贵宾积分」× {s4}\n是否要继续挑战？"
  },
  TipsType_RailWayContinueSaveStage_LeftBtnDesc = {Text = "取消"},
  TipsType_RailWayContinueSaveStage_RightBtnDesc = {Text = "确认"},
  TipsType_RailWayContinueSaveStage_Title = {
    Text = "继续挑战"
  },
  TipsType_RailWayHaveSaveStage_Desc = {
    Text = "需要结束上次保存的挑战后才可进行新的挑战"
  },
  TipsType_RailWaySaveAndExitInBattleTips_Desc = {
    Text = "是否确认退出挑战?\n本次挑战进度将会被保存，下次挑战时会以当前进度继续进行，并重开本场战斗。"
  },
  TipsType_RailWaySaveAndExitInBattleTips_LeftBtnDesc = {Text = "取消"},
  TipsType_RailWaySaveAndExitInBattleTips_RightBtnDesc = {Text = "确认"},
  TipsType_RailWaySaveAndExitInBattleTips_Title = {
    Text = "保存并退出"
  },
  TipsType_RailWaySaveAndExitTips_Desc = {
    Text = "是否确认退出挑战?\n本次挑战进度将会被保存，下次挑战时会以当前进度继续进行。"
  },
  TipsType_RailWaySaveAndExitTips_LeftBtnDesc = {Text = "取消"},
  TipsType_RailWaySaveAndExitTips_RightBtnDesc = {Text = "确认"},
  TipsType_RailWaySaveAndExitTips_Title = {
    Text = "保存并退出"
  },
  TipsType_RailWaySeasonSwitchTips_Desc = {
    Text = "赛季已更新。继续挑战可完成最新赛季任务，但无法进入「贵宾名录」。"
  },
  TipsType_ReplayNullTips_Desc = {
    Text = "回放信息不可为空"
  },
  TipsType_SchoolConflictTips_Desc = {
    Text = "队伍中唤醒体存在界域冲突，请进行调整。"
  },
  TipsType_SelectedAwakensAndCardsExceedLimit_Desc = {
    Text = "超过了选定数量"
  },
  TipsType_ServerRankDataLoading_Desc = {
    Text = "该榜单数据尚未加载完成，请稍后重新打开界面。"
  },
  TipsType_ServerRankDataLoading_RightBtnDesc = {Text = "确认"},
  TipsType_ServerRankDataLoading_Title = {
    Text = "服务器排行榜数据初始化中"
  },
  TipsType_ShopBulkBuyConfirm_Desc = {
    Text = "将使用 <Blue:{s1}> 个{s2}，兑换 <Blue:{s3}> 个{s4}，确认进行兑换吗？"
  },
  TipsType_ShopBulkBuyConfirm_LeftBtnDesc = {Text = "取消"},
  TipsType_ShopBulkBuyConfirm_RightBtnDesc = {Text = "确认"},
  TipsType_ShopBulkBuyConfirm_Title = {
    Text = "兑换确认"
  },
  TipsType_SocialRecordHideTips_Desc = {
    Text = "战斗记录被隐藏"
  },
  TipsType_SteamOverlayEnabledTips_Desc = {
    Text = "请在 Steam「设置-游戏中」及本游戏「属性-通用」中开启「在游戏中启用 Steam 叠加界面」，完成后重新启动游戏再次尝试。"
  },
  TipsType_SteamOverlayEnabledTips_LeftBtnDesc = {Text = "确认"},
  TipsType_SteamOverlayEnabledTips_Title = {
    Text = "温馨提示"
  },
  TipsType_SteamRestartTips_Desc = {
    Text = "Steam 授权异常，请重启 Steam 客户端后重试"
  },
  TipsType_SteamRestartTips_RightBtnDesc = {Text = "确认"},
  TipsType_SteamRestartTips_Title = {
    Text = "登录异常"
  },
  TipsType_SubBestExperienceTips_Chapter3_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_SubBestExperienceTips_Chapter3_LeftBtnDesc = {Text = "退出"},
  TipsType_SubBestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_SubBestExperienceTips_Chapter3_Title = {
    Text = "调查确认"
  },
  TipsType_SubBestExperienceTips_Chapter5_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_SubBestExperienceTips_Chapter5_LeftBtnDesc = {Text = "退出"},
  TipsType_SubBestExperienceTips_Chapter5_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_SubBestExperienceTips_Chapter5_Title = {
    Text = "调查确认"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Desc = {
    Text = "为确保最佳剧情体验，建议完成以下调查关卡。"
  },
  TipsType_SubBestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "退出"},
  TipsType_SubBestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "仍要调查"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Title = {
    Text = "调查确认"
  },
  TipsType_SummonFailureTips_Desc = {
    Text = "唤醒消耗材料信息变化，请重新唤醒"
  },
  TipsType_SummonPriorityNotEnoughTips_Desc = {
    Text = "缺少 {s1} 个<Blue:「{s2}」>，是否消耗<Blue:「{s4}」×{s3} >代替？"
  },
  TipsType_SummonPriorityNotEnoughTips_LeftBtnDesc = {Text = "取消"},
  TipsType_SummonPriorityNotEnoughTips_RightBtnDesc = {Text = "确认"},
  TipsType_SummonPriorityNotEnoughTips_Title = {
    Text = "兑换确认"
  },
  TipsType_SummonType_14SelectConfirm_BottomDesc = {
    Text = "<Blue:注意：一旦选定，本次活动无法再更改！>"
  },
  TipsType_SummonType_14SelectConfirm_Desc = {
    Text = "是否确认选择唤醒体<OrangeQuality:「{s1}」、「{s2}」、「{s3}」、「{s4}」>作为本期活动的定向UP？"
  },
  TipsType_SummonType_14SelectConfirm_LeftBtnDesc = {Text = "取消"},
  TipsType_SummonType_14SelectConfirm_RightBtnDesc = {Text = "确认"},
  TipsType_SummonType_14SelectConfirm_Title = {
    Text = "确认选择"
  },
  TipsType_SummonType_14SelectLimitTips_BottomDesc = {
    Text = "<Blue:注意：一旦选定，本次活动无法再更改！>"
  },
  TipsType_SummonType_14SelectLimitTips_Desc = {
    Text = "已达到选择数量上限"
  },
  TipsType_SummonType_17IncompleteSelectionTips_Desc = {
    Text = "请先完成所有类型的选择后再尝试吧"
  },
  TipsType_SummonType_17SelectConfirm_Desc = {
    Text = "确认完成本期指定唤醒体选择？\n确认后，本期选择将无法再次更改。"
  },
  TipsType_SummonType_17SelectConfirm_LeftBtnDesc = {Text = "取消"},
  TipsType_SummonType_17SelectConfirm_RightBtnDesc = {Text = "确认"},
  TipsType_SummonType_17SelectConfirm_Title = {
    Text = "确认选择"
  },
  TipsType_SupportListLatestTips_Desc = {
    Text = "已是最新状态，快去关注更多校友获得更多助战选择吧！"
  },
  TipsType_TrinketAutoRefineExitTips_Desc = {
    Text = "正在进行自动转录，无法进行操作。"
  },
  TipsType_TrinketAutoRefineTips_BottomDesc = {
    Text = "（自动转录至一条未锁定属性强度为8时停止。）"
  },
  TipsType_TrinketAutoRefineTips_Desc = {
    Text = "至多转录 {s1} 次\n至多消耗"
  },
  TipsType_TrinketAutoRefineTips_LeftBtnDesc = {Text = "取消"},
  TipsType_TrinketAutoRefineTips_RightBtnDesc = {Text = "确认"},
  TipsType_TrinketAutoRefineTips_Title = {
    Text = "自动转录确认"
  },
  TipsType_TrinketBagFullTips_Desc = {
    Text = "密契背包已满"
  },
  TipsType_TrinketBatchUnbindTips_Desc = {
    Text = "是否析离所有密契？"
  },
  TipsType_TrinketBatchUnbindTips_LeftBtnDesc = {Text = "取消"},
  TipsType_TrinketBatchUnbindTips_RightBtnDesc = {Text = "确认"},
  TipsType_TrinketBatchUnbindTips_Title = {
    Text = "析离确认"
  },
  TipsType_TrinketBindSaveTips_Desc = {
    Text = "存在被结合的密契，无法保存为方案！"
  },
  TipsType_TrinketBindTips_Desc = {
    Text = "确认结合以下密契？已被其他唤醒体装备或在编队/方案/助战中存在的密契将被自动卸下。"
  },
  TipsType_TrinketBindTips_LeftBtnDesc = {Text = "取消"},
  TipsType_TrinketBindTips_RightBtnDesc = {Text = "确认"},
  TipsType_TrinketBindTips_Title = {
    Text = "结合确认"
  },
  TipsType_TrinketChangeBindTips_Desc = {
    Text = "确认修改结合？"
  },
  TipsType_TrinketChangeBindTips_LeftBtnDesc = {Text = "取消"},
  TipsType_TrinketChangeBindTips_RightBtnDesc = {Text = "确认"},
  TipsType_TrinketChangeBindTips_Title = {
    Text = "修改结合确认"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_Desc = {
    Text = "是否析离所有密契？\n\n<color=#9BA3A2><size=30>所选素材中含有 +12 密契部件。</size></color>"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_LeftBtnDesc = {Text = "取消"},
  TipsType_TrinketHighLevelBatchUnbindTips_RightBtnDesc = {Text = "确认"},
  TipsType_TrinketHighLevelBatchUnbindTips_Title = {
    Text = "析离确认"
  },
  TipsType_TrinketHighLevelChangeBindTips_Desc = {
    Text = "确认修改结合？\n\n<color=#9BA3A2><size=30>所选素材中含有 +12 密契部件。</size></color>"
  },
  TipsType_TrinketHighLevelChangeBindTips_LeftBtnDesc = {Text = "取消"},
  TipsType_TrinketHighLevelChangeBindTips_RightBtnDesc = {Text = "确认"},
  TipsType_TrinketHighLevelChangeBindTips_Title = {
    Text = "修改结合确认"
  },
  TipsType_TrinketHighLevelUnbindTips_Desc = {
    Text = "确认析离该密契？\n\n<color=#9BA3A2><size=30>所选素材中含有 +12 密契部件。</size></color>"
  },
  TipsType_TrinketHighLevelUnbindTips_LeftBtnDesc = {Text = "取消"},
  TipsType_TrinketHighLevelUnbindTips_RightBtnDesc = {Text = "确认"},
  TipsType_TrinketHighLevelUnbindTips_Title = {
    Text = "析离确认"
  },
  TipsType_TrinketUnbindTips_Desc = {
    Text = "确认析离该密契？"
  },
  TipsType_TrinketUnbindTips_LeftBtnDesc = {Text = "取消"},
  TipsType_TrinketUnbindTips_RightBtnDesc = {Text = "确认"},
  TipsType_TrinketUnbindTips_Title = {
    Text = "析离确认"
  },
  TipsType_TryAgainLaterTips_Desc = {
    Text = "该 <color=#5EF2FF>相位值</color> 正在被使用，请稍后再试"
  },
  TipsType_WaitOppositeSideAccept_Desc = {
    Text = "正在等待\n{s1}\n接受 <Blue:{s2}>的邀请"
  },
  TipsType_WaitOppositeSideAccept_LeftBtnDesc = {Text = "取消"},
  TipsType_WaitOppositeSideAccept_Title = {
    Text = "密码对战"
  },
  TipsType_WaitOthersEnter_Desc = {
    Text = "正在等待其他守密人输入\n <Blue:{s1}>\n匹配密码对战"
  },
  TipsType_WaitOthersEnter_LeftBtnDesc = {Text = "取消"},
  TipsType_WaitOthersEnter_RightBtnDesc = {
    Text = "复制 <color=#5EF2FF>相位值</color>"
  },
  TipsType_WaitOthersEnter_Title = {
    Text = "密码对战"
  },
  TipsType_WeaponRandomChestConfirm_Desc = {
    Text = "确认消耗 <Blue:{s1}>，获得1个<Blue:随机>命轮吗？"
  },
  TipsType_WeaponRandomChestConfirm_LeftBtnDesc = {Text = "取消"},
  TipsType_WeaponRandomChestConfirm_RightBtnDesc = {Text = "确认"},
  TipsType_WeaponRandomChestConfirm_Title = {
    Text = "使用确认"
  },
  TipsType_WeekChallengeSweepTips_Desc = {
    Text = "本周内获取奖励次数已耗尽，无法进行重现。"
  }
})
return Text_TipsType
