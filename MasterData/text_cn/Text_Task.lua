__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Task = readonly({
  Task_100331_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_100331_Name = {Text = "1胜"},
  Task_100332_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_100332_Name = {Text = "10胜"},
  Task_100333_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_100333_Name = {Text = "6胜"},
  Task_100334_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_100334_Name = {Text = "3胜"},
  Task_100523_Desc = {
    Text = "完成意识潜游「畸世绘」"
  },
  Task_100523_Name = {
    Text = "现世的狂想"
  },
  Task_100576_Desc = {
    Text = "每经历 1 回合战斗，调查评分降低 20 分 。"
  },
  Task_100576_Name = {
    Text = "时序沙漏<size=20><color=#747474>每经历 1 回合战斗，调查评分降低 20分 </color></size>"
  },
  Task_10143_Desc = {
    Text = "总回合72回合内通关"
  },
  Task_10143_Name = {
    Text = "总回合72回合内通关"
  },
  Task_10144_Desc = {
    Text = "总回合79回合内通关"
  },
  Task_10144_Name = {
    Text = "总回合79回合内通关"
  },
  Task_10145_Desc = {
    Text = "移动不超过40步通关"
  },
  Task_10145_Name = {
    Text = "运筹帷幄"
  },
  Task_10146_Desc = {
    Text = "通关时症状不多于1张"
  },
  Task_10146_Name = {
    Text = "神清气爽"
  },
  Task_10147_Desc = {
    Text = "通关时症状不多于1张"
  },
  Task_10147_Name = {
    Text = "神清气爽"
  },
  Task_10148_Desc = {
    Text = "总回合31回合内通关"
  },
  Task_10148_Name = {
    Text = "总回合31回合内通关"
  },
  Task_10149_Desc = {
    Text = "总回合40回合内通关"
  },
  Task_10149_Name = {
    Text = "总回合40回合内通关"
  },
  Task_10150_Desc = {
    Text = "总回合47回合内通关"
  },
  Task_10150_Name = {
    Text = "总回合47回合内通关"
  },
  Task_10151_Desc = {
    Text = "总回合58回合内通关"
  },
  Task_10151_Name = {
    Text = "总回合58回合内通关"
  },
  Task_10152_Desc = {
    Text = "总回合65回合内通关"
  },
  Task_10152_Name = {
    Text = "总回合65回合内通关"
  },
  Task_10153_Desc = {
    Text = "消灭融蚀怪物"
  },
  Task_10153_Name = {Text = "目标"},
  Task_10154_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10154_Name = {
    Text = "完美通过"
  },
  Task_10155_Desc = {
    Text = "移动不超过18步通关"
  },
  Task_10155_Name = {
    Text = "运筹帷幄"
  },
  Task_10156_Desc = {
    Text = "通关时症状不多于3张"
  },
  Task_10156_Name = {
    Text = "神清气爽"
  },
  Task_10157_Desc = {
    Text = "通关时至少拥有100黑印"
  },
  Task_10157_Name = {
    Text = "下局再用"
  },
  Task_10158_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10158_Name = {
    Text = "混沌即阶梯"
  },
  Task_10159_Desc = {
    Text = "最终战不超过8回合取胜"
  },
  Task_10159_Name = {
    Text = "速战速决"
  },
  Task_10160_Desc = {
    Text = "通关时至少拥有2个造物"
  },
  Task_10160_Name = {
    Text = "造物之力"
  },
  Task_10161_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10161_Name = {
    Text = "混沌即阶梯"
  },
  Task_10162_Desc = {
    Text = "通关时觉醒所有唤醒体"
  },
  Task_10162_Name = {
    Text = "最终降临"
  },
  Task_10163_Desc = {
    Text = "通关时至少拥有4个造物"
  },
  Task_10163_Name = {
    Text = "造物之力"
  },
  Task_10164_Desc = {
    Text = "通过关卡"
  },
  Task_10164_Name = {
    Text = "通关关卡"
  },
  Task_10165_Desc = {
    Text = "与8名唤醒体同调率到达等级5"
  },
  Task_10165_Name = {
    Text = "默契搭档Ⅳ"
  },
  Task_10166_Desc = {
    Text = "与12名唤醒体同调率到达等级3"
  },
  Task_10166_Name = {
    Text = "默契拍档Ⅴ"
  },
  Task_10167_Desc = {
    Text = "移动不超过45步通关"
  },
  Task_10167_Name = {
    Text = "运筹帷幄"
  },
  Task_10168_Desc = {
    Text = "总回合17回合内通关"
  },
  Task_10168_Name = {
    Text = "总回合17回合内通关"
  },
  Task_10169_Desc = {
    Text = "拥有20名唤醒体"
  },
  Task_10169_Name = {
    Text = "并肩作战II"
  },
  Task_10170_Desc = {
    Text = "拥有30名唤醒体"
  },
  Task_10170_Name = {
    Text = "并肩作战III"
  },
  Task_10171_Desc = {
    Text = "进行300次唤醒仪式"
  },
  Task_10171_Name = {
    Text = "天才守密人Ⅳ"
  },
  Task_10172_Desc = {
    Text = "拥有10名唤醒体"
  },
  Task_10172_Name = {
    Text = "并肩作战"
  },
  Task_10173_Desc = {
    Text = "与4名唤醒体同调率到达等级5"
  },
  Task_10173_Name = {
    Text = "默契拍档II"
  },
  Task_10174_Desc = {
    Text = "找回钱包"
  },
  Task_10174_Name = {Text = "目标"},
  Task_10175_Desc = {
    Text = "拥有40名唤醒体"
  },
  Task_10175_Name = {
    Text = "并肩作战Ⅳ"
  },
  Task_10176_Desc = {
    Text = "与4名唤醒体同调率到达3级"
  },
  Task_10176_Name = {
    Text = "默契拍档"
  },
  Task_10177_Desc = {
    Text = "完成400次波纳佩之墟"
  },
  Task_10177_Name = {
    Text = "波纳佩的赐福Ⅳ"
  },
  Task_10178_Desc = {
    Text = "完成600次波纳佩之墟"
  },
  Task_10178_Name = {
    Text = "波纳佩的赐福Ⅴ"
  },
  Task_10179_Desc = {
    Text = "完成50次蠕虫之所"
  },
  Task_10179_Name = {
    Text = "蠕虫豢养者"
  },
  Task_10180_Desc = {
    Text = "完成100次蠕虫之所"
  },
  Task_10180_Name = {
    Text = "蠕虫豢养者Ⅱ"
  },
  Task_10181_Desc = {
    Text = "完成200次蠕虫之所"
  },
  Task_10181_Name = {
    Text = "蠕虫豢养者Ⅲ"
  },
  Task_10182_Desc = {
    Text = "完成400次蠕虫之所"
  },
  Task_10182_Name = {
    Text = "蠕虫豢养者Ⅳ"
  },
  Task_10183_Desc = {
    Text = "完成600次蠕虫之所"
  },
  Task_10183_Name = {
    Text = "蠕虫豢养者Ⅴ"
  },
  Task_10184_Desc = {
    Text = "通关1次超验存在"
  },
  Task_10184_Name = {
    Text = "论隐秘的诞生"
  },
  Task_10185_Desc = {
    Text = "通关10次超验存在"
  },
  Task_10185_Name = {
    Text = "论隐秘的诞生Ⅱ"
  },
  Task_10186_Desc = {
    Text = "通关25次超验存在"
  },
  Task_10186_Name = {
    Text = "论隐秘的诞生Ⅲ"
  },
  Task_10187_Desc = {
    Text = "完成调查事件第3章「谨防恶犬」"
  },
  Task_10187_Name = {Text = "星之芽"},
  Task_10188_Desc = {
    Text = "经历最多6场战斗通关"
  },
  Task_10188_Name = {
    Text = "精准突破"
  },
  Task_10189_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_10189_Name = {
    Text = "安全第一"
  },
  Task_10190_Desc = {
    Text = "通关时症状不多于1张"
  },
  Task_10190_Name = {
    Text = "神清气爽"
  },
  Task_10191_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10191_Name = {
    Text = "完美通过"
  },
  Task_10192_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10192_Name = {
    Text = "完美通过"
  },
  Task_10193_Desc = {
    Text = "找到詹金"
  },
  Task_10193_Name = {Text = "目标"},
  Task_10194_Desc = {
    Text = "通关制剂淬炼难度I"
  },
  Task_10194_Name = {Text = "任务3"},
  Task_10195_Desc = {
    Text = "完成2次派遣任务"
  },
  Task_10195_Name = {Text = "任务2"},
  Task_10196_Desc = {
    Text = "累计唤醒40次"
  },
  Task_10196_Name = {Text = "任务1"},
  Task_10197_Desc = {
    Text = "升级第1章共鸣5次"
  },
  Task_10197_Name = {Text = "任务5"},
  Task_10198_Desc = {
    Text = "4个唤醒体升到10级"
  },
  Task_10198_Name = {Text = "任务4"},
  Task_10199_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10199_Name = {
    Text = "混沌即阶梯"
  },
  Task_10200_Desc = {
    Text = "通关时症状不多于1张"
  },
  Task_10200_Name = {
    Text = "神清气爽"
  },
  Task_10201_Desc = {
    Text = "逃离动力室"
  },
  Task_10201_Name = {Text = "目标"},
  Task_10202_Desc = {
    Text = "通关时至少拥有8张刻印卡牌"
  },
  Task_10202_Name = {
    Text = "刻印之力"
  },
  Task_10203_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10203_Name = {
    Text = "混沌即阶梯"
  },
  Task_10204_Desc = {
    Text = "前往调查地点"
  },
  Task_10204_Name = {Text = "目标"},
  Task_10205_Desc = {
    Text = "最终战不超过8回合取胜"
  },
  Task_10205_Name = {
    Text = "速战速决"
  },
  Task_10206_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10206_Name = {
    Text = "混沌即阶梯"
  },
  Task_10207_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_10207_Name = {
    Text = "安全第一"
  },
  Task_10208_Desc = {
    Text = "移动不超过35步通关"
  },
  Task_10208_Name = {
    Text = "运筹帷幄"
  },
  Task_10209_Desc = {
    Text = "通关时至少拥有4个造物"
  },
  Task_10209_Name = {
    Text = "造物之力"
  },
  Task_10210_Desc = {
    Text = "消耗 180 灵啡肽"
  },
  Task_10210_Name = {
    Text = "消耗体力"
  },
  Task_10211_Desc = {
    Text = "摆脱拦路的孩子们"
  },
  Task_10211_Name = {Text = "目标"},
  Task_10212_Desc = {
    Text = "完成阶段内全部任务可领取奖励"
  },
  Task_10212_Name = {
    Text = "第一阶段"
  },
  Task_10213_Desc = {
    Text = "穿越维度追踪达芙黛尔"
  },
  Task_10213_Name = {Text = "目标"},
  Task_10215_Desc = {
    Text = "最终战6回合内取胜"
  },
  Task_10215_Name = {
    Text = "最终战6回合内取胜"
  },
  Task_10216_Desc = {
    Text = "通过关卡"
  },
  Task_10216_Name = {
    Text = "通关关卡"
  },
  Task_10217_Desc = {
    Text = "最终战15回合内取胜，并压力少于500"
  },
  Task_10217_Name = {
    Text = "最终战15回合内取胜压力500内"
  },
  Task_10218_Desc = {
    Text = "拥有4名等级20的血肉唤醒体"
  },
  Task_10218_Name = {
    Text = "血肉之主II"
  },
  Task_10219_Desc = {
    Text = "跟随墨菲"
  },
  Task_10219_Name = {Text = "目标"},
  Task_10220_Desc = {
    Text = "通过关卡"
  },
  Task_10220_Name = {
    Text = "通关关卡"
  },
  Task_10221_Desc = {
    Text = "通过关卡"
  },
  Task_10221_Name = {
    Text = "通关关卡"
  },
  Task_10222_Desc = {
    Text = "累计打出 50 张牌"
  },
  Task_10223_Desc = {
    Text = "寻找猎颅者线索"
  },
  Task_10223_Name = {Text = "目标"},
  Task_10224_Desc = {
    Text = "通过关卡"
  },
  Task_10224_Name = {
    Text = "通关关卡"
  },
  Task_10225_Name = {Text = "15"},
  Task_10226_Desc = {
    Text = "通过关卡"
  },
  Task_10226_Name = {
    Text = "通关关卡"
  },
  Task_10228_Desc = {
    Text = "寻找船长"
  },
  Task_10228_Name = {Text = "目标"},
  Task_10229_Desc = {
    Text = "通过关卡"
  },
  Task_10229_Name = {
    Text = "通关关卡"
  },
  Task_10230_Desc = {
    Text = "追上「地狱犬」"
  },
  Task_10230_Name = {Text = "目标"},
  Task_10231_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10231_Name = {
    Text = "速战速决"
  },
  Task_10232_Desc = {
    Text = "通过关卡"
  },
  Task_10232_Name = {
    Text = "通关关卡"
  },
  Task_10233_Desc = {
    Text = "通过关卡"
  },
  Task_10233_Name = {
    Text = "通关关卡"
  },
  Task_10234_Desc = {
    Text = "通过关卡"
  },
  Task_10234_Name = {
    Text = "通关关卡"
  },
  Task_10235_Desc = {
    Text = "调查60次海渊残像"
  },
  Task_10235_Name = {
    Text = "深海之墟Ⅲ"
  },
  Task_10236_Desc = {
    Text = "调查30次海渊残像"
  },
  Task_10236_Name = {
    Text = "深海之墟Ⅱ"
  },
  Task_10237_Desc = {
    Text = "调查120次浑浊残像"
  },
  Task_10237_Name = {
    Text = "混沌之墟Ⅳ"
  },
  Task_10238_Desc = {
    Text = "调查60次浑浊残像"
  },
  Task_10238_Name = {
    Text = "混沌之墟Ⅲ"
  },
  Task_10239_Desc = {
    Text = "调查15次海渊残像"
  },
  Task_10239_Name = {
    Text = "深海之墟"
  },
  Task_10240_Desc = {
    Text = "调查240次浑浊残像"
  },
  Task_10240_Name = {
    Text = "混沌之墟Ⅴ"
  },
  Task_10241_Desc = {
    Text = "完成600次制剂粹制"
  },
  Task_10241_Name = {
    Text = "调制高手Ⅴ"
  },
  Task_10242_Desc = {
    Text = "完成400次制剂淬炼"
  },
  Task_10242_Name = {
    Text = "调制高手Ⅳ"
  },
  Task_10243_Desc = {
    Text = "调查30次浑浊残像"
  },
  Task_10243_Name = {
    Text = "混沌之墟Ⅱ"
  },
  Task_10244_Desc = {
    Text = "调查15次浑浊残像"
  },
  Task_10244_Name = {
    Text = "混沌之墟"
  },
  Task_10245_Desc = {
    Text = "保护詹金"
  },
  Task_10245_Name = {Text = "目标"},
  Task_10246_Desc = {
    Text = "阻拦异变的疯子"
  },
  Task_10246_Name = {Text = "目标"},
  Task_10247_Desc = {
    Text = "完成阶段内全部任务可领取奖励"
  },
  Task_10247_Name = {
    Text = "第三阶段"
  },
  Task_10248_Desc = {
    Text = "找到撬开活板门的工具"
  },
  Task_10248_Name = {Text = "目标"},
  Task_10249_Desc = {
    Text = "逃离危险"
  },
  Task_10249_Name = {Text = "目标"},
  Task_10250_Desc = {
    Text = "关卡结束时至少通过2个事件类型节点"
  },
  Task_10250_Name = {
    Text = "节点触发类"
  },
  Task_10251_Desc = {
    Text = "通关时未使用营地恢复血量"
  },
  Task_10251_Name = {
    Text = "特殊挑战类"
  },
  Task_10252_Desc = {
    Text = "最终战结束时剩余至少50%的血量"
  },
  Task_10252_Name = {
    Text = "最终战血量要求类"
  },
  Task_10253_Desc = {
    Text = "症状卡至少2张通关"
  },
  Task_10253_Name = {
    Text = "牌组规划类"
  },
  Task_10254_Desc = {
    Text = "症状卡最多2张通关"
  },
  Task_10254_Name = {
    Text = "牌组规划类"
  },
  Task_10255_Desc = {
    Text = "步数不少于30步通关"
  },
  Task_10255_Name = {
    Text = "路径规划类"
  },
  Task_10256_Desc = {
    Text = "步数不超过25步通关"
  },
  Task_10256_Name = {
    Text = "路径规划类"
  },
  Task_10257_Name = {Text = "76"},
  Task_10258_Desc = {
    Text = "通过关卡"
  },
  Task_10258_Name = {
    Text = "通关关卡"
  },
  Task_10259_Desc = {
    Text = "状态被指令移除次数（示例：成功驱散两次次虚弱效果）"
  },
  Task_10259_Name = {
    Text = "战斗效果类"
  },
  Task_10260_Desc = {
    Text = "状态被指令添加次数（示例：成功添加一次虚弱效果）"
  },
  Task_10260_Name = {
    Text = "战斗效果类"
  },
  Task_10261_Name = {Text = "72"},
  Task_10262_Name = {Text = "73"},
  Task_10263_Name = {Text = "70"},
  Task_10264_Name = {Text = "71"},
  Task_10265_Desc = {
    Text = "击退猎颅者"
  },
  Task_10265_Name = {Text = "目标"},
  Task_10266_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_10266_Name = {
    Text = "安全第一"
  },
  Task_10267_Desc = {
    Text = "经历最多3场战斗通关"
  },
  Task_10267_Name = {
    Text = "精准突破"
  },
  Task_10268_Desc = {
    Text = "通关时至少拥有50黑印"
  },
  Task_10268_Name = {
    Text = "下局再用"
  },
  Task_10269_Desc = {
    Text = "通关时症状不多于1张"
  },
  Task_10269_Name = {
    Text = "神清气爽"
  },
  Task_10270_Desc = {
    Text = "通关时至少拥有8张刻印卡牌"
  },
  Task_10270_Name = {
    Text = "刻印之力"
  },
  Task_10271_Desc = {
    Text = "移动不超过28步通关"
  },
  Task_10271_Name = {
    Text = "运筹帷幄"
  },
  Task_10272_Desc = {
    Text = "全部战斗总计狂气爆发次数少于等于4通关"
  },
  Task_10272_Name = {
    Text = "冷静优雅"
  },
  Task_10273_Desc = {
    Text = "通关时觉醒所有唤醒体"
  },
  Task_10273_Name = {
    Text = "最终降临"
  },
  Task_10274_Desc = {
    Text = "通关时至少拥有4个造物"
  },
  Task_10274_Name = {
    Text = "造物之力"
  },
  Task_10275_Desc = {
    Text = "总回合73回合内通关"
  },
  Task_10275_Name = {
    Text = "总回合73回合内通关"
  },
  Task_10276_Desc = {
    Text = "深入船舱"
  },
  Task_10276_Name = {Text = "目标"},
  Task_10277_CompleteCondDesc = {
    Text = "派遣总等级>={s1}"
  },
  Task_10277_Desc = {
    Text = "在图书馆静坐并不会让你获得更多的唤醒体。\n出发吧，迈出你的双腿，在自然中寻找那万分之一的可能性。"
  },
  Task_10277_Name = {
    Text = "调查任务：密银寻踪"
  },
  Task_10278_Desc = {
    Text = "通关时症状不多于1张"
  },
  Task_10278_Name = {
    Text = "神清气爽"
  },
  Task_10279_Desc = {
    Text = "移动不超过45步通关"
  },
  Task_10279_Name = {
    Text = "运筹帷幄"
  },
  Task_10280_Desc = {
    Text = "移动不超过30步通关"
  },
  Task_10280_Name = {
    Text = "运筹帷幄"
  },
  Task_10281_Desc = {
    Text = "将1名超维界域唤醒体升格至2阶"
  },
  Task_10281_Name = {
    Text = "超维精通Ⅱ"
  },
  Task_10282_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_10282_Name = {
    Text = "安全第一"
  },
  Task_10283_Desc = {
    Text = "完成阶段内全部任务可领取奖励"
  },
  Task_10283_Name = {
    Text = "第五阶段"
  },
  Task_10284_Desc = {
    Text = "最终战17回合内取胜"
  },
  Task_10284_Name = {
    Text = "最终战17回合内取胜"
  },
  Task_10285_Desc = {
    Text = "消耗10000000蔷薇金券"
  },
  Task_10285_Name = {
    Text = "挥金如土Ⅴ"
  },
  Task_10286_Name = {Text = "40"},
  Task_10287_Desc = {
    Text = "消耗5000000蔷薇金券"
  },
  Task_10287_Name = {
    Text = "挥金如土Ⅳ"
  },
  Task_10288_Desc = {
    Text = "最终战15回合内取胜"
  },
  Task_10288_Name = {
    Text = "最终战15回合内取胜"
  },
  Task_10289_Desc = {
    Text = "经历最多5场战斗通关"
  },
  Task_10289_Name = {
    Text = "精准突破"
  },
  Task_10290_Desc = {
    Text = "寻找角落里的声音"
  },
  Task_10290_Name = {Text = "目标"},
  Task_10291_Name = {Text = "12"},
  Task_10292_Desc = {
    Text = "累计登录90天"
  },
  Task_10292_Name = {
    Text = "持之以恒"
  },
  Task_10293_Desc = {
    Text = "累计登录60天"
  },
  Task_10293_Name = {
    Text = "自彼界而来"
  },
  Task_10294_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10294_Name = {
    Text = "混沌即阶梯"
  },
  Task_10295_Desc = {
    Text = "摆脱神秘女子的纠缠"
  },
  Task_10295_Name = {Text = "目标"},
  Task_10297_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10297_Name = {
    Text = "混沌即阶梯"
  },
  Task_10298_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10298_Name = {
    Text = "速战速决"
  },
  Task_10299_Name = {Text = "14"},
  Task_10300_Name = {Text = "13"},
  Task_10301_Desc = {
    Text = "消灭地狱犬"
  },
  Task_10301_Name = {Text = "目标"},
  Task_10302_CompleteCondDesc = {
    Text = "派遣总等级>={s1}"
  },
  Task_10302_Desc = {
    Text = "混沌是自然法则，秩序是人类妄想。"
  },
  Task_10302_Name = {
    Text = "研究任务：纯白诗篇"
  },
  Task_10302_UnlockCondDesc = {
    Text = "守密人 25 级开放"
  },
  Task_10303_Desc = {
    Text = "守密人达到35级"
  },
  Task_10303_Name = {
    Text = "守密人试训IV"
  },
  Task_10304_Name = {Text = "16"},
  Task_10305_Desc = {
    Text = "与8名唤醒体同调率到达等级3"
  },
  Task_10305_Name = {
    Text = "默契拍档III"
  },
  Task_10306_Name = {Text = "10"},
  Task_10307_Desc = {
    Text = "通关混沌之域间隙Ⅰ"
  },
  Task_10307_Name = {Text = "任务5"},
  Task_10308_Desc = {
    Text = "通关任意残像试炼1次"
  },
  Task_10308_Name = {Text = "任务4"},
  Task_10309_Desc = {
    Text = "通关金券搜查难度I"
  },
  Task_10309_Name = {Text = "任务3"},
  Task_10310_Desc = {
    Text = "将4名唤醒体提升至20级"
  },
  Task_10310_Name = {Text = "任务2"},
  Task_10311_Desc = {
    Text = "通关幻梦深潜1次"
  },
  Task_10311_Name = {Text = "任务1"},
  Task_10312_Name = {Text = "11"},
  Task_10313_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_10313_Name = {
    Text = "安全第一"
  },
  Task_10314_Desc = {
    Text = "移动不超过30步通关"
  },
  Task_10314_Name = {
    Text = "运筹帷幄"
  },
  Task_10315_Desc = {
    Text = "通关时觉醒所有唤醒体"
  },
  Task_10315_Name = {
    Text = "最终降临"
  },
  Task_10316_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10316_Name = {
    Text = "混沌即阶梯"
  },
  Task_10317_Desc = {
    Text = "通关时症状不多于3张"
  },
  Task_10317_Name = {
    Text = "神清气爽"
  },
  Task_10318_Desc = {
    Text = "通关时至少拥有3个造物"
  },
  Task_10318_Name = {
    Text = "造物之力"
  },
  Task_10319_Desc = {
    Text = "最终战不超过8回合取胜"
  },
  Task_10319_Name = {
    Text = "速战速决"
  },
  Task_10320_CompleteCondDesc = {
    Text = "派遣总等级>={s1}"
  },
  Task_10320_Desc = {
    Text = "闪闪发光的东西不一定是黄金，但一定价格不菲。\n相传，弥萨格由一帮离群的炼金术士创立，他们的野心可远不止点石成金。"
  },
  Task_10320_Name = {
    Text = "研究任务：炼金札记"
  },
  Task_10321_Desc = {
    Text = "移动不超过33步通关"
  },
  Task_10321_Name = {
    Text = "运筹帷幄"
  },
  Task_10322_Desc = {
    Text = "通关时至少拥有5个造物"
  },
  Task_10322_Name = {
    Text = "造物之力"
  },
  Task_10323_CompleteCondDesc = {
    Text = "派遣总等级>={s1}"
  },
  Task_10323_Desc = {
    Text = "严格意义上来说，唤醒体也是银芯科技的一种。\n你必须竭尽全力才能让它们不至于落伍。"
  },
  Task_10323_Name = {
    Text = "研究任务：制剂制作"
  },
  Task_10324_Desc = {
    Text = "击退院长室内的畸形怪物"
  },
  Task_10324_Name = {Text = "目标"},
  Task_10325_Desc = {
    Text = "通关时至少拥有2个造物"
  },
  Task_10325_Name = {
    Text = "造物之力"
  },
  Task_10326_Desc = {
    Text = "通关时至少拥有5张刻印卡牌"
  },
  Task_10326_Name = {
    Text = "刻印之力"
  },
  Task_10327_Desc = {
    Text = "通关时症状不多于2张"
  },
  Task_10327_Name = {
    Text = "神清气爽"
  },
  Task_10328_Desc = {
    Text = "通过关卡"
  },
  Task_10328_Name = {
    Text = "通关关卡"
  },
  Task_10329_Desc = {
    Text = "通过关卡"
  },
  Task_10329_Name = {
    Text = "通关关卡"
  },
  Task_10330_Desc = {
    Text = "移动不超过30步通关"
  },
  Task_10330_Name = {
    Text = "运筹帷幄"
  },
  Task_10331_Desc = {
    Text = "通过关卡"
  },
  Task_10331_Name = {
    Text = "通关关卡"
  },
  Task_10332_Desc = {
    Text = "最终战12回合内取胜"
  },
  Task_10332_Name = {
    Text = "最终战12回合内取胜"
  },
  Task_10333_Desc = {
    Text = "通过关卡"
  },
  Task_10333_Name = {
    Text = "通关关卡"
  },
  Task_10334_Desc = {
    Text = "提升唤醒体技能 3 次"
  },
  Task_10334_Name = {
    Text = "竞技场爱好者（未启用）"
  },
  Task_10335_Desc = {
    Text = "通关无光之境Ⅷ（未完成）"
  },
  Task_10336_Desc = {
    Text = "探寻疯人院的秘密"
  },
  Task_10336_Name = {Text = "目标"},
  Task_10337_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10337_Name = {
    Text = "完美通过"
  },
  Task_10338_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10338_Name = {
    Text = "完美通过"
  },
  Task_10339_Desc = {
    Text = "最终战7回合内取胜"
  },
  Task_10339_Name = {
    Text = "最终战7回合内取胜"
  },
  Task_10340_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10340_Name = {
    Text = "完美通过"
  },
  Task_10341_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10341_Name = {
    Text = "完美通过"
  },
  Task_10342_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10342_Name = {
    Text = "完美通过"
  },
  Task_10343_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10343_Name = {
    Text = "完美通过"
  },
  Task_10344_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10344_Name = {
    Text = "完美通过"
  },
  Task_10345_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10345_Name = {
    Text = "完美通过"
  },
  Task_10346_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10346_Name = {
    Text = "完美通过"
  },
  Task_10347_Desc = {
    Text = "将1名超维界域唤醒体升格至3阶"
  },
  Task_10347_Name = {
    Text = "超维精通Ⅲ"
  },
  Task_10348_Desc = {
    Text = "将1名血肉界域唤醒体升格至3阶"
  },
  Task_10348_Name = {
    Text = "血肉精通Ⅲ"
  },
  Task_10349_Desc = {
    Text = "将1名深海界域唤醒体升格至3阶"
  },
  Task_10349_Name = {
    Text = "深海精通Ⅲ"
  },
  Task_10350_Desc = {
    Text = "将1名混沌界域唤醒体升格至3阶"
  },
  Task_10350_Name = {
    Text = "混沌精通Ⅲ"
  },
  Task_10351_Desc = {
    Text = "通过关卡"
  },
  Task_10351_Name = {
    Text = "通关关卡"
  },
  Task_10352_Desc = {
    Text = "拥有4名等级40的血肉唤醒体"
  },
  Task_10352_Name = {
    Text = "血肉之主Ⅳ"
  },
  Task_10353_Desc = {
    Text = "通过关卡"
  },
  Task_10353_Name = {
    Text = "通关关卡"
  },
  Task_10354_Desc = {
    Text = "通过关卡"
  },
  Task_10354_Name = {
    Text = "通关关卡"
  },
  Task_10355_Desc = {
    Text = "通过关卡"
  },
  Task_10355_Name = {
    Text = "通关关卡"
  },
  Task_10356_Desc = {
    Text = "追上艾继丝"
  },
  Task_10356_Name = {Text = "目标"},
  Task_10357_Desc = {
    Text = "通过关卡"
  },
  Task_10357_Name = {
    Text = "通关关卡"
  },
  Task_10358_Desc = {
    Text = "最终战3回合内取胜"
  },
  Task_10358_Name = {
    Text = "最终战3回合内取胜"
  },
  Task_10359_Desc = {
    Text = "通过关卡"
  },
  Task_10359_Name = {
    Text = "通关关卡"
  },
  Task_10360_Desc = {
    Text = "通过关卡"
  },
  Task_10360_Name = {
    Text = "通关关卡"
  },
  Task_10361_Desc = {
    Text = "通过关卡"
  },
  Task_10361_Name = {
    Text = "通关关卡"
  },
  Task_10362_Desc = {
    Text = "通过关卡"
  },
  Task_10362_Name = {
    Text = "通关关卡"
  },
  Task_10363_Desc = {
    Text = "通过关卡"
  },
  Task_10363_Name = {
    Text = "通关关卡"
  },
  Task_10364_Desc = {
    Text = "通过关卡"
  },
  Task_10364_Name = {
    Text = "通关关卡"
  },
  Task_10365_Desc = {
    Text = "通过关卡"
  },
  Task_10365_Name = {
    Text = "通关关卡"
  },
  Task_10366_Desc = {
    Text = "通过关卡"
  },
  Task_10366_Name = {
    Text = "通关关卡"
  },
  Task_10367_Desc = {
    Text = "通过关卡"
  },
  Task_10367_Name = {
    Text = "通关关卡"
  },
  Task_10368_Desc = {
    Text = "通过关卡"
  },
  Task_10368_Name = {
    Text = "通关关卡"
  },
  Task_10369_Desc = {
    Text = "通过关卡"
  },
  Task_10369_Name = {
    Text = "通关关卡"
  },
  Task_10370_Desc = {
    Text = "找到10处主线第二章「@1@2」的析出点"
  },
  Task_10370_Desc2 = {
    Text = "找到10处主线第二章「以蜡像之名」的析出点"
  },
  Task_10370_Name = {Text = "@1@2"},
  Task_10370_Name2 = {
    Text = "潜藏的低语Ⅱ"
  },
  Task_10371_Desc = {
    Text = "找到9处主线第三章「@1@2」的析出点"
  },
  Task_10371_Desc2 = {
    Text = "找到9处主线第三章「谨防恶犬」的析出点"
  },
  Task_10371_Name = {Text = "@1@2"},
  Task_10371_Name2 = {
    Text = "潜藏的低语Ⅲ"
  },
  Task_10372_Desc = {
    Text = "完成336次派遣任务"
  },
  Task_10372_Name = {
    Text = "特派行动Ⅴ"
  },
  Task_10373_Desc = {
    Text = "找到8处主线第一章「东区秘事」的析出点"
  },
  Task_10373_Name = {
    Text = "潜藏的低语"
  },
  Task_10374_Desc = {
    Text = "完成84次派遣任务"
  },
  Task_10374_Name = {
    Text = "特派行动Ⅲ"
  },
  Task_10375_Desc = {
    Text = "完成168次派遣任务"
  },
  Task_10375_Name = {
    Text = "特派行动Ⅳ"
  },
  Task_10376_Desc = {
    Text = "完成12次派遣任务"
  },
  Task_10376_Name = {
    Text = "特派行动"
  },
  Task_10377_Desc = {
    Text = "完成36次派遣任务"
  },
  Task_10377_Name = {
    Text = "特派行动Ⅱ"
  },
  Task_10378_Desc = {
    Text = "通过关卡"
  },
  Task_10378_Name = {
    Text = "通关关卡"
  },
  Task_10379_Desc = {
    Text = "通过关卡"
  },
  Task_10379_Name = {
    Text = "通关关卡"
  },
  Task_10380_Desc = {
    Text = "通过关卡"
  },
  Task_10380_Name = {
    Text = "通关关卡"
  },
  Task_10381_Desc = {
    Text = "找到12处主线第四章「@1@2」的析出点"
  },
  Task_10381_Desc2 = {
    Text = "找到12处主线第四章「于无声处」的析出点"
  },
  Task_10381_Name = {Text = "@1@2"},
  Task_10381_Name2 = {
    Text = "潜藏的低语Ⅳ"
  },
  Task_10382_Desc = {
    Text = "拥有4名等级60的深海唤醒体"
  },
  Task_10382_Name = {
    Text = "深海之主Ⅵ"
  },
  Task_10383_Name = {Text = "18"},
  Task_10384_Desc = {
    Text = "最终战单回合累积护盾大于等于1000"
  },
  Task_10384_Name = {
    Text = "防卫过度"
  },
  Task_10385_Desc = {
    Text = "穿越意识通道，追踪弗朗西斯"
  },
  Task_10385_Name = {Text = "目标"},
  Task_10386_Name = {Text = "28"},
  Task_10387_Desc = {
    Text = "解决融蚀异变体"
  },
  Task_10387_Name = {Text = "目标"},
  Task_10388_Desc = {
    Text = "将莎拉引去地下室"
  },
  Task_10388_Name = {Text = "目标"},
  Task_10390_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10390_Name = {
    Text = "速战速决"
  },
  Task_10391_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10391_Name = {
    Text = "速战速决"
  },
  Task_10392_Desc = {
    Text = "脱离维度空间和「祂」的注视"
  },
  Task_10392_Name = {Text = "目标"},
  Task_10393_Name = {Text = "39"},
  Task_10394_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10394_Name = {
    Text = "速战速决"
  },
  Task_10395_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10395_Name = {
    Text = "速战速决"
  },
  Task_10396_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10396_Name = {
    Text = "速战速决"
  },
  Task_10397_Desc = {
    Text = "唤醒失神的莉莉"
  },
  Task_10397_Name = {Text = "目标"},
  Task_10398_Name = {Text = "32"},
  Task_10399_Name = {Text = "33"},
  Task_10400_Name = {Text = "30"},
  Task_10401_Name = {Text = "31"},
  Task_10402_Name = {Text = "36"},
  Task_10403_Name = {Text = "37"},
  Task_10404_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10404_Name = {
    Text = "速战速决"
  },
  Task_10405_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10405_Name = {
    Text = "速战速决"
  },
  Task_10406_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10406_Name = {
    Text = "混沌即阶梯"
  },
  Task_10407_Desc = {
    Text = "穿越黑暗的地铁"
  },
  Task_10407_Name = {Text = "目标"},
  Task_10409_Desc = {
    Text = "逃离疯人院"
  },
  Task_10409_Name = {Text = "目标"},
  Task_10410_Name = {Text = "2"},
  Task_10411_Name = {Text = "3"},
  Task_10413_Desc = {
    Text = "通关时至少拥有4个造物"
  },
  Task_10413_Name = {
    Text = "造物之力"
  },
  Task_10414_Name = {Text = "6"},
  Task_10415_Name = {Text = "7"},
  Task_10416_Name = {Text = "4"},
  Task_10417_Name = {Text = "5"},
  Task_10418_Name = {Text = "8"},
  Task_10419_Desc = {
    Text = "追上潘狄娅"
  },
  Task_10419_Name = {Text = "目标"},
  Task_10420_Desc = {
    Text = "完成调查事件「于无声处」困难难度"
  },
  Task_10420_Name = {
    Text = "妈妈，我不疼·困难"
  },
  Task_10421_Desc = {
    Text = "最终战不超过15回合取胜"
  },
  Task_10421_Name = {
    Text = "速战速决"
  },
  Task_10422_Desc = {
    Text = "最终战不超过8回合取胜"
  },
  Task_10422_Name = {
    Text = "速战速决"
  },
  Task_10423_Desc = {
    Text = "最终战不超过8回合取胜"
  },
  Task_10423_Name = {
    Text = "速战速决"
  },
  Task_10424_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_10424_Name = {
    Text = "速战速决"
  },
  Task_10425_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_10425_Name = {
    Text = "速战速决"
  },
  Task_10426_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_10426_Name = {
    Text = "速战速决"
  },
  Task_10427_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_10427_Name = {
    Text = "速战速决"
  },
  Task_10428_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_10428_Name = {
    Text = "速战速决"
  },
  Task_10429_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_10429_Name = {
    Text = "速战速决"
  },
  Task_10430_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_10430_Name = {
    Text = "速战速决"
  },
  Task_10431_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_10431_Name = {
    Text = "速战速决"
  },
  Task_10432_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_10432_Name = {
    Text = "速战速决"
  },
  Task_10433_Desc = {
    Text = "经历最多6场战斗通关"
  },
  Task_10433_Name = {
    Text = "精准突破"
  },
  Task_10434_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_10434_Name = {
    Text = "安全第一"
  },
  Task_10435_Desc = {
    Text = "通关时症状不多于1张"
  },
  Task_10435_Name = {
    Text = "神清气爽"
  },
  Task_10436_Desc = {
    Text = "阻止研究员"
  },
  Task_10436_Name = {Text = "目标"},
  Task_10437_Desc = {
    Text = "进入地下室"
  },
  Task_10437_Name = {Text = "目标"},
  Task_10438_Desc = {
    Text = "总回合24回合内通关"
  },
  Task_10438_Name = {
    Text = "总回合24回合内通关"
  },
  Task_10439_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_10439_Name = {
    Text = "速战速决"
  },
  Task_10440_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10440_Name = {
    Text = "混沌即阶梯"
  },
  Task_10441_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10441_Name = {
    Text = "速战速决"
  },
  Task_10442_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10442_Name = {
    Text = "速战速决"
  },
  Task_10443_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10443_Name = {
    Text = "速战速决"
  },
  Task_10444_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10444_Name = {
    Text = "速战速决"
  },
  Task_10445_Desc = {
    Text = "累计消耗1000黑印"
  },
  Task_10445_Name = {
    Text = "黑色召唤Ⅲ"
  },
  Task_10446_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10446_Name = {
    Text = "速战速决"
  },
  Task_10447_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10447_Name = {
    Text = "速战速决"
  },
  Task_10448_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10448_Name = {
    Text = "速战速决"
  },
  Task_10449_Desc = {
    Text = "通过关卡"
  },
  Task_10449_Name = {
    Text = "通关关卡"
  },
  Task_10450_Desc = {
    Text = "通过关卡"
  },
  Task_10450_Name = {
    Text = "通关关卡"
  },
  Task_10451_Desc = {
    Text = "完成600次禁忌纂录"
  },
  Task_10451_Name = {
    Text = "密契篆刻师Ⅴ"
  },
  Task_10452_Desc = {
    Text = "完成400次禁忌纂录"
  },
  Task_10452_Name = {
    Text = "密契篆刻师Ⅳ"
  },
  Task_10453_Desc = {
    Text = "完成200次禁忌纂录"
  },
  Task_10453_Name = {
    Text = "密契篆刻师Ⅲ"
  },
  Task_10454_Desc = {
    Text = "激活密契6件套装效果"
  },
  Task_10454_Name = {Text = "任务4"},
  Task_10455_Desc = {
    Text = "完成50次禁忌纂录"
  },
  Task_10455_Name = {
    Text = "密契篆刻师"
  },
  Task_10456_Desc = {
    Text = "通关50次超验存在"
  },
  Task_10456_Name = {
    Text = "论隐秘的诞生Ⅳ"
  },
  Task_10457_Desc = {
    Text = "找到萝坦"
  },
  Task_10457_Name = {Text = "目标"},
  Task_10458_Desc = {
    Text = "通过关卡"
  },
  Task_10458_Name = {
    Text = "通关关卡"
  },
  Task_10459_Desc = {
    Text = "通过关卡"
  },
  Task_10459_Name = {
    Text = "通关关卡"
  },
  Task_10460_Desc = {
    Text = "通过关卡"
  },
  Task_10460_Name = {
    Text = "通关关卡"
  },
  Task_10461_Desc = {
    Text = "通过关卡"
  },
  Task_10461_Name = {
    Text = "通关关卡"
  },
  Task_10462_Desc = {
    Text = "通过关卡"
  },
  Task_10462_Name = {
    Text = "通关关卡"
  },
  Task_10463_Desc = {
    Text = "通过关卡"
  },
  Task_10463_Name = {
    Text = "通关关卡"
  },
  Task_10464_Desc = {
    Text = "通过关卡"
  },
  Task_10464_Name = {
    Text = "通关关卡"
  },
  Task_10465_Desc = {
    Text = "通过关卡"
  },
  Task_10465_Name = {
    Text = "通关关卡"
  },
  Task_10466_Desc = {
    Text = "通过关卡"
  },
  Task_10466_Name = {
    Text = "通关关卡"
  },
  Task_10467_Desc = {
    Text = "通过关卡"
  },
  Task_10467_Name = {
    Text = "通关关卡"
  },
  Task_10468_Desc = {
    Text = "通过关卡"
  },
  Task_10468_Name = {
    Text = "通关关卡"
  },
  Task_10469_Desc = {
    Text = "通过关卡"
  },
  Task_10469_Name = {
    Text = "通关关卡"
  },
  Task_10470_Desc = {
    Text = "通过关卡"
  },
  Task_10470_Name = {
    Text = "通关关卡"
  },
  Task_10471_Desc = {
    Text = "通过关卡"
  },
  Task_10471_Name = {
    Text = "通关关卡"
  },
  Task_10472_Desc = {
    Text = "完成调查主线第2章「以蜡像之名」"
  },
  Task_10473_CompleteCondDesc = {
    Text = "派遣总等级>={s1}"
  },
  Task_10473_Desc = {
    Text = "它们在自己不曾察觉的恐惧中滚动。\n无所知，无光亮，无名字。"
  },
  Task_10473_Name = {
    Text = "研究任务：绯红诗篇"
  },
  Task_10473_UnlockCondDesc = {
    Text = "守密人 25 级开放"
  },
  Task_10474_Desc = {
    Text = "通过关卡"
  },
  Task_10474_Name = {
    Text = "通关关卡"
  },
  Task_10475_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10475_Name = {
    Text = "速战速决"
  },
  Task_10476_Desc = {
    Text = "完成400次金券搜查"
  },
  Task_10476_Name = {
    Text = "淘金者Ⅳ"
  },
  Task_10477_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_10477_Name = {
    Text = "安全第一"
  },
  Task_10478_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10478_Name = {
    Text = "速战速决"
  },
  Task_10479_Desc = {
    Text = "最终战10回合内取胜"
  },
  Task_10479_Name = {
    Text = "最终战10回合内取胜"
  },
  Task_10480_Desc = {
    Text = "通过关卡"
  },
  Task_10480_Name = {
    Text = "通关关卡"
  },
  Task_10481_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10481_Name = {
    Text = "速战速决"
  },
  Task_10482_Desc = {
    Text = "完成调查主线第4章「于无声处」"
  },
  Task_10483_Desc = {
    Text = "通过关卡"
  },
  Task_10483_Name = {
    Text = "通关关卡"
  },
  Task_10484_Desc = {
    Text = "通过关卡"
  },
  Task_10484_Name = {
    Text = "通关关卡"
  },
  Task_10485_Desc = {
    Text = "通过关卡"
  },
  Task_10485_Name = {
    Text = "通关关卡"
  },
  Task_10486_Desc = {
    Text = "通过关卡"
  },
  Task_10486_Name = {
    Text = "通关关卡"
  },
  Task_10487_Desc = {
    Text = "通过关卡"
  },
  Task_10487_Name = {
    Text = "通关关卡"
  },
  Task_10488_Desc = {
    Text = "通过关卡"
  },
  Task_10488_Name = {
    Text = "通关关卡"
  },
  Task_10489_Desc = {
    Text = "通过关卡"
  },
  Task_10489_Name = {
    Text = "通关关卡"
  },
  Task_10490_Desc = {
    Text = "通过关卡"
  },
  Task_10490_Name = {
    Text = "通关关卡"
  },
  Task_10492_Desc = {
    Text = "通过关卡"
  },
  Task_10492_Name = {
    Text = "通关关卡"
  },
  Task_10493_Desc = {
    Text = "通过关卡"
  },
  Task_10493_Name = {
    Text = "通关关卡"
  },
  Task_10494_Desc = {
    Text = "通过关卡"
  },
  Task_10494_Name = {
    Text = "通关关卡"
  },
  Task_10495_Desc = {
    Text = "通过关卡"
  },
  Task_10495_Name = {
    Text = "通关关卡"
  },
  Task_10496_Desc = {
    Text = "通过关卡"
  },
  Task_10496_Name = {
    Text = "通关关卡"
  },
  Task_10497_Desc = {
    Text = "完成30次幻梦深潜"
  },
  Task_10497_Name = {
    Text = "深潜者Ⅲ"
  },
  Task_10498_Desc = {
    Text = "完成60次幻梦深潜"
  },
  Task_10498_Name = {
    Text = "深潜者Ⅳ"
  },
  Task_10499_Desc = {
    Text = "完成1次幻梦深潜"
  },
  Task_10499_Name = {Text = "深潜者"},
  Task_10500_Desc = {
    Text = "完成15次幻梦深潜"
  },
  Task_10500_Name = {
    Text = "深潜者Ⅱ"
  },
  Task_10501_Desc = {
    Text = "一次伤害到达800"
  },
  Task_10501_Name = {
    Text = "强效伤害Ⅲ"
  },
  Task_10502_Desc = {
    Text = "一次伤害到达1000"
  },
  Task_10502_Name = {
    Text = "强效伤害Ⅳ"
  },
  Task_10503_Desc = {
    Text = "一次伤害到达200"
  },
  Task_10503_Name = {
    Text = "强效伤害"
  },
  Task_10504_Desc = {
    Text = "一次伤害到达400"
  },
  Task_10504_Name = {
    Text = "强效伤害Ⅱ"
  },
  Task_10505_Desc = {
    Text = "一次伤害到达5000"
  },
  Task_10505_Name = {
    Text = "致命伤害Ⅴ"
  },
  Task_10506_Desc = {
    Text = "给敌人叠加500层中毒"
  },
  Task_10506_Name = {
    Text = "毒理学专家"
  },
  Task_10507_Desc = {
    Text = "阻止艾继丝"
  },
  Task_10507_Name = {Text = "目标"},
  Task_10510_Desc = {
    Text = "在特定类型战斗X中，一回合打出伤害大于等于1000（X精英战）"
  },
  Task_10510_Name = {
    Text = "战栗嘉年华"
  },
  Task_10511_Desc = {
    Text = "在特定类型战斗X中，一回合使用狂气爆发次数大于等于5"
  },
  Task_10511_Name = {
    Text = "连锁狂乱"
  },
  Task_10512_Desc = {
    Text = "通关时使用营地回复功能次数少于等于1"
  },
  Task_10512_Name = {Text = "安全屋"},
  Task_10513_Desc = {
    Text = "通关时使用营地的地图探索度大于等于80%"
  },
  Task_10513_Name = {
    Text = "大开眼界"
  },
  Task_10514_Desc = {
    Text = "通关时种类X的卡牌卡数量小于等于3"
  },
  Task_10514_Name = {
    Text = "免疫前沿"
  },
  Task_10515_Desc = {
    Text = "通关时种类X的卡牌卡数量大于等于3"
  },
  Task_10515_Name = {
    Text = "病危通知"
  },
  Task_10516_Desc = {
    Text = "通关时特定类型X造物数量大于等于3（X黄金）"
  },
  Task_10516_Name = {Text = "淘金者"},
  Task_10517_Desc = {
    Text = "通关时获得刻印种类大于等于2（灵感和高级灵感等同）"
  },
  Task_10517_Name = {
    Text = "刻印藏家"
  },
  Task_10518_Desc = {
    Text = "通关时觉醒唤醒体大于等于2"
  },
  Task_10518_Name = {
    Text = "觉醒时刻"
  },
  Task_10519_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10519_Name = {
    Text = "混沌即阶梯"
  },
  Task_10520_Desc = {
    Text = "击退袭来的提灯教众"
  },
  Task_10520_Name = {Text = "目标"},
  Task_10521_Desc = {
    Text = "为法阵绘制争取时间"
  },
  Task_10521_Name = {Text = "目标"},
  Task_10522_Name = {Text = "22"},
  Task_10523_Desc = {
    Text = "将任意唤醒体技能提升至3级"
  },
  Task_10523_Name = {Text = "任务2"},
  Task_10524_Desc = {
    Text = "完成主线调查事件·困难1-8"
  },
  Task_10524_Name = {Text = "任务3"},
  Task_10525_Desc = {
    Text = "将4名唤醒体提升至40级"
  },
  Task_10525_Name = {Text = "任务1"},
  Task_10526_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10526_Name = {
    Text = "速战速决"
  },
  Task_10527_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10527_Name = {
    Text = "速战速决"
  },
  Task_10528_Desc = {
    Text = "完成100次制剂淬炼"
  },
  Task_10528_Name = {
    Text = "天才药理师Ⅱ"
  },
  Task_10529_Desc = {
    Text = "通关混沌之域间隙Ⅵ"
  },
  Task_10529_Name = {Text = "任务5"},
  Task_10530_Desc = {
    Text = "决战希洛"
  },
  Task_10530_Name = {Text = "目标"},
  Task_10531_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10531_Name = {
    Text = "速战速决"
  },
  Task_10532_Desc = {
    Text = "完成200次金券搜查"
  },
  Task_10532_Name = {
    Text = "淘金者Ⅲ"
  },
  Task_10533_Desc = {
    Text = "与朵尔协力击退提灯教众"
  },
  Task_10533_Name = {Text = "目标"},
  Task_10534_Desc = {
    Text = "完成50次金券搜查"
  },
  Task_10534_Name = {Text = "淘金者"},
  Task_10535_Desc = {
    Text = "完成100次金券搜查"
  },
  Task_10535_Name = {
    Text = "淘金者Ⅱ"
  },
  Task_10536_Desc = {
    Text = "通过关卡"
  },
  Task_10536_Name = {
    Text = "通关关卡"
  },
  Task_10537_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10537_Name = {
    Text = "速战速决"
  },
  Task_10538_CompleteCondDesc = {
    Text = "派遣总等级>={s1}"
  },
  Task_10538_Desc = {
    Text = "有时候，破坏的冲动即为创造的冲动。\n拾起你的画笔吧，艺术无需任何准备。"
  },
  Task_10538_Name = {
    Text = "调查任务：达达主义"
  },
  Task_10538_UnlockCondDesc = {
    Text = "完成调查事件 1-13 开放"
  },
  Task_10539_Desc = {
    Text = "完成阶段内全部任务可领取奖励"
  },
  Task_10539_Name = {
    Text = "第二阶段"
  },
  Task_10540_Desc = {
    Text = "完成调查主线第1章「东区秘事」困难难度"
  },
  Task_10542_Name = {Text = "51"},
  Task_10543_Name = {Text = "52"},
  Task_10544_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10544_Name = {
    Text = "完美通过"
  },
  Task_10545_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10545_Name = {
    Text = "完美通过"
  },
  Task_10546_Desc = {
    Text = "累计登录2天"
  },
  Task_10546_Name = {
    Text = "你好，守密人"
  },
  Task_10547_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10547_Name = {
    Text = "完美通过"
  },
  Task_10548_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10548_Name = {
    Text = "完美通过"
  },
  Task_10549_Desc = {
    Text = "通关混沌之域间隙Ⅰ"
  },
  Task_10550_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10550_Name = {
    Text = "完美通过"
  },
  Task_10552_Desc = {
    Text = "通关时至少拥有2个造物"
  },
  Task_10552_Name = {
    Text = "造物之力"
  },
  Task_10553_Desc = {
    Text = "通关时至少拥有5张刻印卡牌"
  },
  Task_10553_Name = {
    Text = "刻印之力"
  },
  Task_10554_Desc = {
    Text = "通关时症状不多于2张"
  },
  Task_10554_Name = {
    Text = "神清气爽"
  },
  Task_10555_Desc = {
    Text = "完成本章所有任务后可领取"
  },
  Task_10555_Name = {
    Text = "界域精通Ⅲ"
  },
  Task_10556_Desc = {
    Text = "移动不超过33步通关"
  },
  Task_10556_Name = {
    Text = "运筹帷幄"
  },
  Task_10557_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10557_Name = {
    Text = "完美通过"
  },
  Task_10558_Desc = {
    Text = "经历最多5场战斗通关"
  },
  Task_10558_Name = {
    Text = "精准突破"
  },
  Task_10559_Name = {Text = "61"},
  Task_10560_Name = {Text = "60"},
  Task_10561_Name = {Text = "63"},
  Task_10562_Name = {Text = "62"},
  Task_10563_Name = {Text = "65"},
  Task_10564_Name = {Text = "64"},
  Task_10565_CompleteCondDesc = {
    Text = "派遣总等级>={s1}"
  },
  Task_10565_Desc = {
    Text = "他的本能、理智和心都被封装在小小的玻璃瓶里。\n世界从此与他无关。"
  },
  Task_10565_Name = {
    Text = "调查任务：活性解离"
  },
  Task_10565_UnlockCondDesc = {
    Text = "完成调查事件 1-13 开放"
  },
  Task_10566_Name = {Text = "66"},
  Task_10567_Name = {Text = "69"},
  Task_10568_Name = {Text = "68"},
  Task_10569_Name = {Text = "57"},
  Task_10571_Desc = {
    Text = "进行150次唤醒仪式"
  },
  Task_10571_Name = {
    Text = "天才守密人Ⅲ"
  },
  Task_10572_Desc = {
    Text = "进行100次唤醒仪式"
  },
  Task_10572_Name = {
    Text = "天才守密人Ⅱ"
  },
  Task_10575_Desc = {
    Text = "将1名血肉界域唤醒体升格至5阶"
  },
  Task_10575_Name = {
    Text = "血肉精通Ⅴ"
  },
  Task_10576_Desc = {
    Text = "将1名深海界域唤醒体升格至5阶"
  },
  Task_10576_Name = {
    Text = "深海精通Ⅴ"
  },
  Task_10577_Desc = {
    Text = "进行50次唤醒仪式"
  },
  Task_10577_Name = {
    Text = "天才守密人"
  },
  Task_10578_Desc = {
    Text = "将1名超维界域唤醒体升格至5阶"
  },
  Task_10578_Name = {
    Text = "超维精通Ⅴ"
  },
  Task_10579_Desc = {
    Text = "拥有12件等级9的密契"
  },
  Task_10579_Name = {
    Text = "密契收藏家Ⅱ"
  },
  Task_10580_Desc = {
    Text = "拥有6件等级6的密契"
  },
  Task_10580_Name = {
    Text = "密契收藏家"
  },
  Task_10581_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10581_Name = {
    Text = "速战速决"
  },
  Task_10582_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10582_Name = {
    Text = "速战速决"
  },
  Task_10583_Desc = {
    Text = "追踪弗朗西斯残留的踪迹"
  },
  Task_10583_Name = {Text = "目标"},
  Task_10584_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10584_Name = {
    Text = "速战速决"
  },
  Task_10585_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10585_Name = {
    Text = "速战速决"
  },
  Task_10586_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10586_Name = {
    Text = "速战速决"
  },
  Task_10587_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10587_Name = {
    Text = "速战速决"
  },
  Task_10588_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10588_Name = {
    Text = "速战速决"
  },
  Task_10589_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10589_Name = {
    Text = "速战速决"
  },
  Task_10590_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10590_Name = {
    Text = "速战速决"
  },
  Task_10591_Desc = {
    Text = "通关时症状不多于3张"
  },
  Task_10591_Name = {
    Text = "神清气爽"
  },
  Task_10592_Desc = {
    Text = "再入拉伊疯人院"
  },
  Task_10592_Name = {Text = "目标"},
  Task_10593_Desc = {
    Text = "最终战15回合内取胜"
  },
  Task_10593_Name = {
    Text = "最终战15回合内取胜"
  },
  Task_10595_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10595_Name = {
    Text = "完美通过"
  },
  Task_10596_Desc = {
    Text = "逃离雪原"
  },
  Task_10596_Name = {Text = "目标"},
  Task_10597_Desc = {
    Text = "执行 3 次派遣"
  },
  Task_10597_Name = {
    Text = "进行委派"
  },
  Task_10598_Desc = {
    Text = "总回合38回合内通关"
  },
  Task_10598_Name = {
    Text = "总回合38回合内通关"
  },
  Task_10599_Desc = {
    Text = "消耗2500000蔷薇金券"
  },
  Task_10599_Name = {
    Text = "挥金如土Ⅲ"
  },
  Task_10600_Desc = {
    Text = "登录游戏"
  },
  Task_10600_Name = {
    Text = "登录游戏"
  },
  Task_10601_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10601_Name = {
    Text = "完美通过"
  },
  Task_10602_Desc = {
    Text = "通过关卡"
  },
  Task_10602_Name = {
    Text = "通关关卡"
  },
  Task_10603_Desc = {
    Text = "通关时觉醒所有唤醒体"
  },
  Task_10603_Name = {
    Text = "最终降临"
  },
  Task_10604_Desc = {
    Text = "通关时至少拥有4个造物"
  },
  Task_10604_Name = {
    Text = "造物之力"
  },
  Task_10605_Desc = {
    Text = "通过关卡"
  },
  Task_10605_Name = {
    Text = "通关关卡"
  },
  Task_10606_Desc = {
    Text = "通关时症状不多于1张"
  },
  Task_10606_Name = {
    Text = "神清气爽"
  },
  Task_10607_Desc = {
    Text = "通关时至少拥有8张刻印卡牌"
  },
  Task_10607_Name = {
    Text = "刻印之力"
  },
  Task_10608_Desc = {
    Text = "守密人达到25级"
  },
  Task_10608_Name = {
    Text = "守密人试训III"
  },
  Task_10609_Desc = {
    Text = "全部战斗总计狂气爆发次数少于等于4通关"
  },
  Task_10609_Name = {
    Text = "冷静优雅"
  },
  Task_10610_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10610_Name = {
    Text = "完美通过"
  },
  Task_10611_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_10611_Name = {
    Text = "安全第一"
  },
  Task_10612_Desc = {
    Text = "经历最多3场战斗通关"
  },
  Task_10612_Name = {
    Text = "精准突破"
  },
  Task_10613_Desc = {
    Text = "通关时至少拥有50黑印"
  },
  Task_10613_Name = {
    Text = "下局再用"
  },
  Task_10614_Desc = {
    Text = "与16名唤醒体同调率到达等级3"
  },
  Task_10614_Name = {
    Text = "默契拍档Ⅶ"
  },
  Task_10615_Name = {Text = "67"},
  Task_10616_Desc = {
    Text = "拥有4名等级40的深海唤醒体"
  },
  Task_10616_Name = {
    Text = "深海之主Ⅳ"
  },
  Task_10618_Desc = {
    Text = "总回合48回合内通关"
  },
  Task_10618_Name = {
    Text = "总回合48回合内通关"
  },
  Task_10619_Desc = {
    Text = "总回合53回合内通关"
  },
  Task_10619_Name = {
    Text = "总回合53回合内通关"
  },
  Task_10620_Desc = {
    Text = "调查30次维度残像"
  },
  Task_10620_Name = {
    Text = "超维之墟Ⅱ"
  },
  Task_10621_Desc = {
    Text = "调查60次维度残像"
  },
  Task_10621_Name = {
    Text = "超维之墟Ⅲ"
  },
  Task_10622_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10622_Name = {
    Text = "完美通过"
  },
  Task_10623_Desc = {
    Text = "调查15次维度残像"
  },
  Task_10623_Name = {
    Text = "超维之墟"
  },
  Task_10624_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10624_Name = {
    Text = "完美通过"
  },
  Task_10625_Desc = {
    Text = "调查120次器质残像"
  },
  Task_10625_Name = {
    Text = "血肉之墟Ⅳ"
  },
  Task_10626_Desc = {
    Text = "调查15次器质残像"
  },
  Task_10626_Name = {
    Text = "血肉之墟"
  },
  Task_10627_Desc = {
    Text = "调查30次器质残像"
  },
  Task_10627_Name = {
    Text = "血肉之墟Ⅱ"
  },
  Task_10628_Desc = {
    Text = "经历最多6场战斗通关"
  },
  Task_10628_Name = {
    Text = "精准突破"
  },
  Task_10629_Desc = {
    Text = "调查240次海渊残像"
  },
  Task_10629_Name = {
    Text = "深海之墟Ⅴ"
  },
  Task_10630_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10630_Name = {
    Text = "完美通过"
  },
  Task_10631_Desc = {
    Text = "特定战斗X（普通）中，一回合击杀怪物数量大于等于3"
  },
  Task_10631_Name = {
    Text = "猎杀时刻"
  },
  Task_10632_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10632_Name = {
    Text = "完美通过"
  },
  Task_10633_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10633_Name = {
    Text = "完美通过"
  },
  Task_10634_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10634_Name = {
    Text = "完美通过"
  },
  Task_10635_Desc = {
    Text = "通关时至少拥有5个造物"
  },
  Task_10635_Name = {
    Text = "造物之力"
  },
  Task_10636_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10636_Name = {
    Text = "完美通过"
  },
  Task_10637_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10637_Name = {
    Text = "完美通过"
  },
  Task_10638_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10638_Name = {
    Text = "完美通过"
  },
  Task_10639_Desc = {
    Text = "完成阶段内全部任务可领取奖励"
  },
  Task_10639_Name = {
    Text = "第四阶段"
  },
  Task_10640_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10640_Name = {
    Text = "完美通过"
  },
  Task_10641_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10641_Name = {
    Text = "完美通过"
  },
  Task_10642_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10642_Name = {
    Text = "完美通过"
  },
  Task_10643_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10643_Name = {
    Text = "完美通过"
  },
  Task_10644_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10644_Name = {
    Text = "完美通过"
  },
  Task_10645_Desc = {
    Text = "将1名超维界域唤醒体升格至1阶"
  },
  Task_10645_Name = {
    Text = "超维精通Ⅰ"
  },
  Task_10646_Desc = {
    Text = "通过关卡"
  },
  Task_10646_Name = {
    Text = "通关关卡"
  },
  Task_10647_Desc = {
    Text = "将1名混沌界域唤醒体升格至1阶"
  },
  Task_10647_Name = {
    Text = "混沌精通Ⅰ"
  },
  Task_10648_Desc = {
    Text = "将1名血肉界域唤醒体升格至1阶"
  },
  Task_10648_Name = {
    Text = "血肉精通Ⅰ"
  },
  Task_10649_Desc = {
    Text = "将1名深海界域唤醒体升格至1阶"
  },
  Task_10649_Name = {
    Text = "深海精通Ⅰ"
  },
  Task_10650_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_10650_Name = {
    Text = "安全第一"
  },
  Task_10651_Desc = {
    Text = "通过关卡"
  },
  Task_10651_Name = {
    Text = "通关关卡"
  },
  Task_10652_Desc = {
    Text = "完成调查事件「@1@2」"
  },
  Task_10652_Desc2 = {
    Text = "完成调查事件「以蜡像之名」"
  },
  Task_10652_Name = {Text = "@1@2"},
  Task_10652_Name2 = {
    Text = "蜡中的迷思"
  },
  Task_10653_Desc = {
    Text = "在调查事件「东区秘事」中共鸣3次"
  },
  Task_10653_Name = {
    Text = "感激回响"
  },
  Task_10654_Desc = {
    Text = "累计登录30天"
  },
  Task_10654_Name = {
    Text = "积极分子"
  },
  Task_10655_Name = {Text = "80"},
  Task_10656_Desc = {
    Text = "通关无光之境Ⅶ（未完成）"
  },
  Task_10656_Name = {Text = "雕砌者"},
  Task_10658_Desc = {
    Text = "每场30分"
  },
  Task_10658_Name = {
    Text = "战斗胜利  <size=20><color=#747474>每场30分</color></size>"
  },
  Task_10660_Desc = {Text = "吱"},
  Task_10660_Name = {Text = "吱吱"},
  Task_10661_Desc = {
    Text = "通过关卡"
  },
  Task_10661_Name = {
    Text = "通关关卡"
  },
  Task_10663_Desc = {
    Text = "累计登录7天"
  },
  Task_10663_Name = {
    Text = "早起的鸟儿有虫吃"
  },
  Task_10664_Desc = {
    Text = "移动不超过50步通关"
  },
  Task_10664_Name = {
    Text = "运筹帷幄"
  },
  Task_10665_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_10665_Name = {
    Text = "安全第一"
  },
  Task_10666_Desc = {
    Text = "经历最多7场战斗通关"
  },
  Task_10666_Name = {
    Text = "精准突破"
  },
  Task_10667_Desc = {
    Text = "将4个唤醒体升至60级"
  },
  Task_10667_Name = {Text = "任务1"},
  Task_10668_Desc = {
    Text = "完成进攻作战/防卫演练/协同作战 20 次"
  },
  Task_10668_Name = {
    Text = "技能材料本（未启用）"
  },
  Task_10669_Desc = {
    Text = "完成主线调查关卡 10次"
  },
  Task_10669_Name = {
    Text = "主线关卡本（未启用）"
  },
  Task_10670_Desc = {
    Text = "通关血肉之沼间隙Ⅰ"
  },
  Task_10671_Desc = {
    Text = "在商店中使用蔷薇金券兑换3次"
  },
  Task_10671_Name = {
    Text = "金币购买"
  },
  Task_10672_Desc = {
    Text = "给校友点赞 10 次"
  },
  Task_10672_Name = {
    Text = "好友点赞"
  },
  Task_10673_Desc = {
    Text = "完成超验存在 1 次"
  },
  Task_10673_Name = {Text = "周常BOSS"},
  Task_10674_Desc = {
    Text = "参与相位对弈 3 次"
  },
  Task_10674_Name = {Text = "PVP战斗"},
  Task_10675_Desc = {
    Text = "完成每周试炼"
  },
  Task_10675_Name = {
    Text = "每周试炼"
  },
  Task_10676_Desc = {
    Text = "使用助战 3 次"
  },
  Task_10676_Name = {
    Text = "好友助战"
  },
  Task_10677_Desc = {
    Text = "本周幻梦深潜累计积分达到 1800"
  },
  Task_10677_Name = {
    Text = "幻梦深潜"
  },
  Task_10678_Desc = {
    Text = "通关时每剩余1黑印得3分，最多600分"
  },
  Task_10678_Name = {
    Text = "黑色印记  <size=20><color=#747474>通关时每剩余1黑印得3分，最多600分</color></size>"
  },
  Task_10679_Desc = {
    Text = "最终战不超过15回合取胜"
  },
  Task_10679_Name = {
    Text = "速战速决"
  },
  Task_10680_CompleteCondDesc = {
    Text = "派遣总等级>={s1}"
  },
  Task_10680_Desc = {
    Text = "维度、空间、量子……或许你将永远无法理解这些词汇背后的深刻涵义。\n就像你无法理解这世上发生的大部分事情。"
  },
  Task_10680_Name = {
    Text = "研究任务：绛紫诗篇"
  },
  Task_10680_UnlockCondDesc = {
    Text = "守密人 25 级开放"
  },
  Task_10681_Desc = {
    Text = "通关时生命不低于80%"
  },
  Task_10681_Name = {
    Text = "安全第一"
  },
  Task_10682_Desc = {
    Text = "最终战25回合内取胜"
  },
  Task_10682_Name = {
    Text = "最终战25回合内取胜"
  },
  Task_10683_Desc = {
    Text = "将1名混沌界域唤醒体升格至2阶"
  },
  Task_10683_Name = {
    Text = "混沌精通Ⅱ"
  },
  Task_10684_Desc = {
    Text = "在调查事件「@1@2」中共鸣8次"
  },
  Task_10684_Desc2 = {
    Text = "在调查事件「谨防恶犬」中共鸣8次"
  },
  Task_10684_Name = {Text = "@1@2"},
  Task_10684_Name2 = {
    Text = "隐忍回响Ⅲ"
  },
  Task_10685_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10685_Name = {
    Text = "混沌即阶梯"
  },
  Task_10686_Desc = {
    Text = "通关时至少拥有3个造物"
  },
  Task_10686_Name = {
    Text = "造物之力"
  },
  Task_10687_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_10687_Name = {
    Text = "安全第一"
  },
  Task_10688_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_10688_Name = {
    Text = "安全第一"
  },
  Task_10689_Desc = {
    Text = "移动不超过30步通关"
  },
  Task_10689_Name = {
    Text = "运筹帷幄"
  },
  Task_10690_Desc = {
    Text = "通关时觉醒所有唤醒体"
  },
  Task_10690_Name = {
    Text = "最终降临"
  },
  Task_10691_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10691_Name = {
    Text = "混沌即阶梯"
  },
  Task_10692_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10692_Name = {
    Text = "混沌即阶梯"
  },
  Task_10693_Desc = {
    Text = "消除异变的源头"
  },
  Task_10693_Name = {Text = "目标"},
  Task_10694_Desc = {
    Text = "击退袭来的提灯教众"
  },
  Task_10694_Name = {Text = "目标"},
  Task_10695_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10695_Name = {
    Text = "完美通过"
  },
  Task_10696_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10696_Name = {
    Text = "完美通过"
  },
  Task_10697_Name = {Text = "29"},
  Task_10698_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10698_Name = {
    Text = "完美通过"
  },
  Task_10699_Name = {Text = "25"},
  Task_10700_Name = {Text = "24"},
  Task_10701_Name = {Text = "27"},
  Task_10702_Name = {Text = "26"},
  Task_10703_Name = {Text = "21"},
  Task_10704_Name = {Text = "20"},
  Task_10705_Name = {Text = "23"},
  Task_10706_Desc = {
    Text = "强化 1 次密契（未完成）"
  },
  Task_10706_Name = {
    Text = "饰品强化（未启用）"
  },
  Task_10707_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_10707_Name = {
    Text = "速战速决"
  },
  Task_10708_Desc = {
    Text = "移动不超过35步通关"
  },
  Task_10708_Name = {
    Text = "运筹帷幄"
  },
  Task_10710_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_10710_Name = {
    Text = "速战速决"
  },
  Task_10712_Name = {Text = "38"},
  Task_10713_Desc = {
    Text = "将1名混沌界域唤醒体升格至5阶"
  },
  Task_10713_Name = {
    Text = "混沌精通Ⅴ"
  },
  Task_10714_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10714_Name = {
    Text = "速战速决"
  },
  Task_10715_Desc = {
    Text = "突破包围"
  },
  Task_10715_Name = {Text = "目标"},
  Task_10716_Desc = {
    Text = "守密人达到5级"
  },
  Task_10716_Name = {
    Text = "守密人试训I"
  },
  Task_10717_Desc = {
    Text = "最终战单回合累积护盾大于等于1500"
  },
  Task_10717_Name = {
    Text = "防卫过度"
  },
  Task_10718_Name = {Text = "58"},
  Task_10719_Name = {Text = "59"},
  Task_10720_Desc = {
    Text = "通关混沌之域间隙Ⅶ"
  },
  Task_10720_Name = {Text = "任务5"},
  Task_10721_Desc = {
    Text = "将任意6个密契强化至12级"
  },
  Task_10721_Name = {Text = "任务4"},
  Task_10722_Desc = {
    Text = "通关时至少拥有8张刻印卡牌"
  },
  Task_10722_Name = {
    Text = "刻印之力"
  },
  Task_10723_Desc = {
    Text = "全部战斗总计狂气爆发次数少于等于4通关"
  },
  Task_10723_Name = {
    Text = "冷静优雅"
  },
  Task_10724_Desc = {
    Text = "将任意唤醒体技能提升至4级"
  },
  Task_10724_Name = {Text = "任务1"},
  Task_10725_Desc = {
    Text = "最终战单回合累积护盾大于等于2000"
  },
  Task_10725_Name = {
    Text = "防卫过度"
  },
  Task_10726_Name = {Text = "50"},
  Task_10727_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10727_Name = {
    Text = "完美通过"
  },
  Task_10728_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10728_Name = {
    Text = "完美通过"
  },
  Task_10729_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10729_Name = {
    Text = "完美通过"
  },
  Task_10730_Name = {Text = "54"},
  Task_10731_Name = {Text = "55"},
  Task_10732_Name = {Text = "56"},
  Task_10733_CompleteCondDesc = {
    Text = "派遣总等级>={s1}"
  },
  Task_10733_Desc = {
    Text = "那是上帝书写宇宙的语言。\n当你倾听它时，你在倾听无穷。"
  },
  Task_10733_Name = {
    Text = "调查任务：旧日残卷"
  },
  Task_10733_UnlockCondDesc = {
    Text = "完成调查事件 1-13 开放"
  },
  Task_10734_Desc = {
    Text = "完成600次金券搜查"
  },
  Task_10734_Name = {
    Text = "淘金者Ⅴ"
  },
  Task_10735_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10735_Name = {
    Text = "速战速决"
  },
  Task_10736_CompleteCondDesc = {
    Text = "派遣总等级>={s1}"
  },
  Task_10736_Desc = {
    Text = "严格意义上来说，唤醒体也是银芯科技的一种。\n你必须竭尽全力才能让它们不至于落伍。"
  },
  Task_10736_Name = {
    Text = "研究任务：制剂制作"
  },
  Task_10737_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10737_Name = {
    Text = "完美通过"
  },
  Task_10738_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10738_Name = {
    Text = "速战速决"
  },
  Task_10739_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10739_Name = {
    Text = "完美通过"
  },
  Task_10740_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10740_Name = {
    Text = "完美通过"
  },
  Task_10741_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_10741_Name = {
    Text = "安全第一"
  },
  Task_10742_Desc = {
    Text = "通关时至少拥有2个造物"
  },
  Task_10742_Name = {
    Text = "造物之力"
  },
  Task_10743_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10743_Name = {
    Text = "混沌即阶梯"
  },
  Task_10744_Desc = {
    Text = "经历最多5场战斗通关"
  },
  Task_10744_Name = {
    Text = "精准突破"
  },
  Task_10745_Desc = {
    Text = "通关时症状不多于3张"
  },
  Task_10745_Name = {
    Text = "神清气爽"
  },
  Task_10746_Desc = {
    Text = "通关时至少拥有100黑印"
  },
  Task_10746_Name = {
    Text = "下局再用"
  },
  Task_10747_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10747_Name = {
    Text = "混沌即阶梯"
  },
  Task_10748_Desc = {
    Text = "通关时觉醒所有唤醒体"
  },
  Task_10748_Name = {
    Text = "最终降临"
  },
  Task_10749_Desc = {
    Text = "通关时至少拥有4个造物"
  },
  Task_10749_Name = {
    Text = "造物之力"
  },
  Task_10750_Desc = {
    Text = "通过关卡"
  },
  Task_10750_Name = {
    Text = "通关关卡"
  },
  Task_10751_Desc = {
    Text = "总回合88回合内通关"
  },
  Task_10751_Name = {
    Text = "总回合88回合内通关"
  },
  Task_10752_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10752_Name = {
    Text = "速战速决"
  },
  Task_10753_Desc = {
    Text = "在调查事件「@1@2」中共鸣3次"
  },
  Task_10753_Desc2 = {
    Text = "在调查事件「以蜡像之名」中共鸣3次"
  },
  Task_10753_Name = {Text = "@1@2"},
  Task_10753_Name2 = {
    Text = "惊厥回响"
  },
  Task_10754_Desc = {
    Text = "在调查事件「@1@2」中共鸣6次"
  },
  Task_10754_Desc2 = {
    Text = "在调查事件「以蜡像之名」中共鸣6次"
  },
  Task_10754_Name = {Text = "@1@2"},
  Task_10754_Name2 = {
    Text = "惊厥回响Ⅱ"
  },
  Task_10755_Desc = {
    Text = "在调查事件「@1@2」中共鸣8次"
  },
  Task_10755_Desc2 = {
    Text = "在调查事件「以蜡像之名」中共鸣8次"
  },
  Task_10755_Name = {Text = "@1@2"},
  Task_10755_Name2 = {
    Text = "惊厥回响Ⅲ"
  },
  Task_10756_Desc = {
    Text = "在调查事件「@1@2」中共鸣3次"
  },
  Task_10756_Desc2 = {
    Text = "在调查事件「谨防恶犬」中共鸣3次"
  },
  Task_10756_Name = {Text = "@1@2"},
  Task_10756_Name2 = {
    Text = "隐忍回响"
  },
  Task_10757_Desc = {
    Text = "在调查事件「@1@2」中共鸣6次"
  },
  Task_10757_Desc2 = {
    Text = "在调查事件「谨防恶犬」中共鸣6次"
  },
  Task_10757_Name = {Text = "@1@2"},
  Task_10757_Name2 = {
    Text = "隐忍回响Ⅱ"
  },
  Task_10758_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_10758_Name = {
    Text = "速战速决"
  },
  Task_10759_Desc = {
    Text = "在调查事件「@1@2」中共鸣10次"
  },
  Task_10759_Desc2 = {
    Text = "在调查事件「谨防恶犬」中共鸣10次"
  },
  Task_10759_Name = {Text = "@1@2"},
  Task_10759_Name2 = {
    Text = "隐忍回响Ⅳ"
  },
  Task_10760_Desc = {
    Text = "在调查事件「@1@2」中共鸣3次"
  },
  Task_10760_Desc2 = {
    Text = "在调查事件「于无声处」中共鸣3次"
  },
  Task_10760_Name = {Text = "@1@2"},
  Task_10760_Name2 = {
    Text = "苦痛回响"
  },
  Task_10761_Desc = {
    Text = "在调查事件「@1@2」中共鸣6次"
  },
  Task_10761_Desc2 = {
    Text = "在调查事件「于无声处」中共鸣6次"
  },
  Task_10761_Name = {Text = "@1@2"},
  Task_10761_Name2 = {
    Text = "苦痛回响Ⅱ"
  },
  Task_10762_Desc = {
    Text = "在调查事件「@1@2」中共鸣8次"
  },
  Task_10762_Desc2 = {
    Text = "在调查事件「于无声处」中共鸣8次"
  },
  Task_10762_Name = {Text = "@1@2"},
  Task_10762_Name2 = {
    Text = "苦痛回响Ⅲ"
  },
  Task_10763_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_10763_Name = {
    Text = "速战速决"
  },
  Task_10764_Desc = {
    Text = "在深海之遗通关 1 次"
  },
  Task_10764_Name = {
    Text = "爬塔-深海"
  },
  Task_10765_Desc = {
    Text = "最终战不超过15回合取胜"
  },
  Task_10765_Name = {
    Text = "速战速决"
  },
  Task_10766_Desc = {
    Text = "通过关卡"
  },
  Task_10766_Name = {
    Text = "通关关卡"
  },
  Task_10767_Desc = {
    Text = "通过关卡"
  },
  Task_10767_Name = {
    Text = "通关关卡"
  },
  Task_10768_Desc = {
    Text = "拥有4名等级10的超维唤醒体"
  },
  Task_10768_Name = {
    Text = "超维之主"
  },
  Task_10769_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_10769_Name = {
    Text = "安全第一"
  },
  Task_10770_Desc = {
    Text = "完成本章所有任务后可领取"
  },
  Task_10770_Name = {
    Text = "界域精通Ⅴ"
  },
  Task_10771_Desc = {
    Text = "在混沌之域通关 1 次"
  },
  Task_10771_Name = {
    Text = "爬塔-混沌"
  },
  Task_10772_Desc = {
    Text = "在超维之旅通关 1 次"
  },
  Task_10772_Name = {
    Text = "爬塔-超维"
  },
  Task_10773_Desc = {
    Text = "在血肉之沼通关 1 次"
  },
  Task_10773_Name = {
    Text = "爬塔-血肉"
  },
  Task_10774_Desc = {
    Text = "在融灾禁区通关 1 次（特训值达到30）"
  },
  Task_10774_Name = {
    Text = "融灾禁区"
  },
  Task_10775_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10775_Name = {
    Text = "完美通过"
  },
  Task_10776_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10776_Name = {
    Text = "完美通过"
  },
  Task_10777_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10777_Name = {
    Text = "完美通过"
  },
  Task_10778_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10778_Name = {
    Text = "完美通过"
  },
  Task_10779_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10779_Name = {
    Text = "完美通过"
  },
  Task_10780_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10780_Name = {
    Text = "完美通过"
  },
  Task_10781_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10781_Name = {
    Text = "完美通过"
  },
  Task_10782_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10782_Name = {
    Text = "完美通过"
  },
  Task_10783_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10783_Name = {
    Text = "完美通过"
  },
  Task_10784_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10784_Name = {
    Text = "完美通过"
  },
  Task_10785_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10785_Name = {
    Text = "完美通过"
  },
  Task_10786_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10786_Name = {
    Text = "完美通过"
  },
  Task_10787_CompleteCondDesc = {
    Text = "派遣总等级>={s1}"
  },
  Task_10787_Desc = {
    Text = "闪闪发光的东西不一定是黄金，但一定价格不菲。\n相传，弥萨格由一帮离群的炼金术士创立，他们的野心可远不止点石成金。"
  },
  Task_10787_Name = {
    Text = "研究任务：炼金札记"
  },
  Task_10789_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10789_Name = {
    Text = "完美通过"
  },
  Task_10790_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10790_Name = {
    Text = "完美通过"
  },
  Task_10791_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10791_Name = {
    Text = "完美通过"
  },
  Task_10792_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10792_Name = {
    Text = "完美通过"
  },
  Task_10793_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10793_Name = {
    Text = "完美通过"
  },
  Task_10794_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10794_Name = {
    Text = "完美通过"
  },
  Task_10795_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10795_Name = {
    Text = "完美通过"
  },
  Task_10796_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10796_Name = {
    Text = "完美通过"
  },
  Task_10797_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10797_Name = {
    Text = "混沌即阶梯"
  },
  Task_10798_Desc = {
    Text = "给敌人叠加2000层中毒"
  },
  Task_10798_Name = {
    Text = "毒理学专家Ⅲ"
  },
  Task_10799_Desc = {
    Text = "给敌人叠加1000层中毒"
  },
  Task_10799_Name = {
    Text = "毒理学专家Ⅱ"
  },
  Task_10800_Desc = {
    Text = "反击击杀4名敌人并获得胜利"
  },
  Task_10800_Name = {
    Text = "正当防卫"
  },
  Task_10801_Desc = {
    Text = "给敌人叠加5000层中毒"
  },
  Task_10801_Name = {
    Text = "毒理学专家Ⅳ"
  },
  Task_10802_Desc = {
    Text = "通关副本时牌库中拥有30张牌"
  },
  Task_10802_Name = {
    Text = "卡牌收藏家"
  },
  Task_10803_Desc = {
    Text = "通过暴击伤害击杀6个敌人并取得胜利"
  },
  Task_10803_Name = {
    Text = "突如其来的暴虐"
  },
  Task_10804_Desc = {
    Text = "一场战斗丢弃30张手牌并胜利"
  },
  Task_10804_Name = {
    Text = "目空一切"
  },
  Task_10805_Desc = {
    Text = "通关副本时牌库中有8张症状卡"
  },
  Task_10805_Name = {
    Text = "厄运缠身"
  },
  Task_10806_Desc = {
    Text = "一回合消耗10算力，并胜利"
  },
  Task_10806_Name = {
    Text = "算无遗策"
  },
  Task_10807_Desc = {
    Text = "通关任意副本时拥有7个造物"
  },
  Task_10807_Name = {
    Text = "造物收藏家"
  },
  Task_10808_Desc = {
    Text = "将任意唤醒体技能提升至5级"
  },
  Task_10808_Name = {Text = "任务2"},
  Task_10809_Desc = {
    Text = "将1名混沌界域唤醒体升格至4阶"
  },
  Task_10809_Name = {
    Text = "混沌精通Ⅳ"
  },
  Task_10810_Desc = {
    Text = "完成密契转录10次"
  },
  Task_10810_Name = {Text = "任务4"},
  Task_10811_Desc = {
    Text = "通关混沌之域间隙Ⅷ"
  },
  Task_10811_Name = {Text = "任务5"},
  Task_10812_Desc = {
    Text = "将1名超维界域唤醒体升格至4阶"
  },
  Task_10812_Name = {
    Text = "超维精通Ⅳ"
  },
  Task_10814_Desc = {
    Text = "通过关卡"
  },
  Task_10814_Name = {
    Text = "通关关卡"
  },
  Task_10815_Desc = {
    Text = "通关时最多拥有6张刻印卡牌"
  },
  Task_10815_Name = {
    Text = "刻印抑制"
  },
  Task_10817_Desc = {
    Text = "完成50次制剂淬炼"
  },
  Task_10817_Name = {
    Text = "天才药理师"
  },
  Task_10818_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10818_Name = {
    Text = "完美通过"
  },
  Task_10819_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10819_Name = {
    Text = "完美通过"
  },
  Task_10820_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10820_Name = {
    Text = "完美通过"
  },
  Task_10821_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10821_Name = {
    Text = "完美通过"
  },
  Task_10822_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10822_Name = {
    Text = "完美通过"
  },
  Task_10823_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10823_Name = {
    Text = "完美通过"
  },
  Task_10824_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10824_Name = {
    Text = "完美通过"
  },
  Task_10825_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10825_Name = {
    Text = "速战速决"
  },
  Task_10826_Desc = {
    Text = "通过关卡"
  },
  Task_10826_Name = {
    Text = "通关关卡"
  },
  Task_10827_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10827_Name = {
    Text = "完美通过"
  },
  Task_10828_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_10828_Name = {
    Text = "速战速决"
  },
  Task_10830_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10830_Name = {
    Text = "完美通过"
  },
  Task_10831_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10831_Name = {
    Text = "完美通过"
  },
  Task_10832_Desc = {
    Text = "通过关卡"
  },
  Task_10832_Name = {
    Text = "通关关卡"
  },
  Task_10833_Desc = {
    Text = "通过关卡"
  },
  Task_10833_Name = {
    Text = "通关关卡"
  },
  Task_10834_Desc = {
    Text = "通关时至少拥有10张刻印卡牌"
  },
  Task_10834_Name = {
    Text = "刻印之力"
  },
  Task_10835_Desc = {
    Text = "通过关卡"
  },
  Task_10835_Name = {
    Text = "通关关卡"
  },
  Task_10836_Desc = {
    Text = "最终战20回合内取胜"
  },
  Task_10836_Name = {
    Text = "最终战20回合内取胜"
  },
  Task_10839_Desc = {
    Text = "移动不超过50步通关"
  },
  Task_10839_Name = {
    Text = "运筹帷幄"
  },
  Task_10840_Desc = {
    Text = "总回合43回合内通关"
  },
  Task_10840_Name = {
    Text = "总回合43回合内通关"
  },
  Task_10841_Name = {Text = "34"},
  Task_10842_Desc = {
    Text = "完成调查事件「谨防恶犬」困难难度"
  },
  Task_10842_Name = {Text = "雕砌者"},
  Task_10844_Desc = {
    Text = "将1名深海界域唤醒体升格至2阶"
  },
  Task_10844_Name = {
    Text = "深海精通Ⅱ"
  },
  Task_10845_Desc = {
    Text = "通过关卡"
  },
  Task_10845_Name = {
    Text = "通关关卡"
  },
  Task_10847_Name = {Text = "9"},
  Task_10848_Desc = {
    Text = "移动不超过24步通关"
  },
  Task_10848_Name = {
    Text = "运筹帷幄"
  },
  Task_10849_Name = {Text = "35"},
  Task_10852_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10852_Name = {
    Text = "完美通过"
  },
  Task_10853_Desc = {
    Text = "通过关卡"
  },
  Task_10853_Name = {
    Text = "通关关卡"
  },
  Task_10854_Desc = {
    Text = "通过关卡"
  },
  Task_10854_Name = {
    Text = "通关关卡"
  },
  Task_10855_Desc = {
    Text = "通过关卡"
  },
  Task_10855_Name = {
    Text = "通关关卡"
  },
  Task_10856_Name = {Text = "17"},
  Task_10857_Desc = {
    Text = "通过关卡"
  },
  Task_10857_Name = {
    Text = "通关关卡"
  },
  Task_10858_Desc = {
    Text = "通过关卡"
  },
  Task_10858_Name = {
    Text = "通关关卡"
  },
  Task_10859_Desc = {
    Text = "通过关卡"
  },
  Task_10859_Name = {
    Text = "通关关卡"
  },
  Task_10860_Desc = {
    Text = "通过关卡"
  },
  Task_10860_Name = {
    Text = "通关关卡"
  },
  Task_10861_Desc = {
    Text = "通过关卡"
  },
  Task_10861_Name = {
    Text = "通关关卡"
  },
  Task_10862_Desc = {
    Text = "通过关卡"
  },
  Task_10862_Name = {
    Text = "通关关卡"
  },
  Task_10863_Desc = {
    Text = "通过关卡"
  },
  Task_10863_Name = {
    Text = "通关关卡"
  },
  Task_10864_Desc = {
    Text = "通过关卡"
  },
  Task_10864_Name = {
    Text = "通关关卡"
  },
  Task_10865_Desc = {
    Text = "累计进行100次唤醒仪式"
  },
  Task_10865_Name = {Text = "抽卡"},
  Task_10866_Desc = {
    Text = "通过关卡"
  },
  Task_10866_Name = {
    Text = "通关关卡"
  },
  Task_10867_Desc = {
    Text = "通过关卡"
  },
  Task_10867_Name = {
    Text = "通关关卡"
  },
  Task_10868_Desc = {
    Text = "通过关卡"
  },
  Task_10868_Name = {
    Text = "通关关卡"
  },
  Task_10869_Desc = {
    Text = "全部战斗总计狂气爆发次数少于等于4通关"
  },
  Task_10869_Name = {
    Text = "冷静优雅"
  },
  Task_10870_Desc = {
    Text = "升级唤醒体技能100次"
  },
  Task_10870_Name = {
    Text = "技艺磨炼Ⅳ"
  },
  Task_10871_Desc = {
    Text = "升级唤醒体技能200次"
  },
  Task_10871_Name = {
    Text = "技艺磨炼Ⅴ"
  },
  Task_10872_Desc = {
    Text = "拥有4名等级60的超维唤醒体"
  },
  Task_10872_Name = {
    Text = "超维之主Ⅵ"
  },
  Task_10873_Desc = {
    Text = "升级唤醒体技能10次"
  },
  Task_10873_Name = {
    Text = "技艺磨炼"
  },
  Task_10874_Desc = {
    Text = "升级唤醒体技能20次"
  },
  Task_10874_Name = {
    Text = "技艺磨炼II"
  },
  Task_10875_Desc = {
    Text = "升级唤醒体技能50次"
  },
  Task_10875_Name = {
    Text = "技艺磨炼III"
  },
  Task_10876_Desc = {
    Text = "拥有4名等级20的超维唤醒体"
  },
  Task_10876_Name = {
    Text = "超维之主II"
  },
  Task_10877_Desc = {
    Text = "拥有4名等级30的超维唤醒体"
  },
  Task_10877_Name = {
    Text = "超维之主III"
  },
  Task_10878_Desc = {
    Text = "拥有4名等级40的超维唤醒体"
  },
  Task_10878_Name = {
    Text = "超维之主Ⅳ"
  },
  Task_10879_Desc = {
    Text = "拥有4名等级50的超维唤醒体"
  },
  Task_10879_Name = {
    Text = "超维之主Ⅴ"
  },
  Task_10880_Desc = {
    Text = "完成主线调查事件·困难2-11"
  },
  Task_10880_Name = {Text = "任务3"},
  Task_10881_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_10881_Name = {
    Text = "安全第一"
  },
  Task_10882_Desc = {
    Text = "移动不超过35步通关"
  },
  Task_10882_Name = {
    Text = "运筹帷幄"
  },
  Task_10883_Desc = {
    Text = "完成本章所有任务后可领取"
  },
  Task_10883_Name = {
    Text = "界域精通Ⅱ"
  },
  Task_10884_Desc = {
    Text = "通关时至少拥有8张刻印卡牌"
  },
  Task_10884_Name = {
    Text = "刻印之力"
  },
  Task_10885_Desc = {
    Text = "出战至少2位混沌唤醒体通关"
  },
  Task_10885_Name = {
    Text = "混沌即阶梯"
  },
  Task_10886_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_10886_Name = {
    Text = "安全第一"
  },
  Task_10887_Desc = {
    Text = "通过第一场战斗，干掉那几个小孩子，拿回自己的东西"
  },
  Task_10887_Name = {
    Text = "通过第一场战斗"
  },
  Task_10888_Desc = {
    Text = "移动不超过40步通关"
  },
  Task_10888_Name = {
    Text = "运筹帷幄"
  },
  Task_10889_Desc = {
    Text = "通关时最多拥有6张刻印卡牌"
  },
  Task_10889_Name = {
    Text = "刻印抑制"
  },
  Task_10890_Desc = {
    Text = "通关时至少拥有10张刻印卡牌"
  },
  Task_10890_Name = {
    Text = "刻印之力"
  },
  Task_10892_Desc = {
    Text = "移动不超过28步通关"
  },
  Task_10892_Name = {
    Text = "运筹帷幄"
  },
  Task_10893_Desc = {
    Text = "通过关卡"
  },
  Task_10893_Name = {
    Text = "通关关卡"
  },
  Task_10894_Desc = {
    Text = "通过关卡"
  },
  Task_10894_Name = {
    Text = "通关关卡"
  },
  Task_10895_Desc = {
    Text = "通过关卡"
  },
  Task_10895_Name = {
    Text = "通关关卡"
  },
  Task_10896_Desc = {
    Text = "通过关卡"
  },
  Task_10896_Name = {
    Text = "通关关卡"
  },
  Task_10897_Desc = {
    Text = "通过关卡"
  },
  Task_10897_Name = {
    Text = "通关关卡"
  },
  Task_10898_Desc = {
    Text = "通过关卡"
  },
  Task_10898_Name = {
    Text = "通关关卡"
  },
  Task_10899_Desc = {
    Text = "通过关卡"
  },
  Task_10899_Name = {
    Text = "通关关卡"
  },
  Task_10900_Desc = {
    Text = "通关时每剩余1%死亡抵抗得1分，最多600分"
  },
  Task_10900_Name = {
    Text = "得心应手  <size=20><color=#747474>通关时每剩余1%死亡抵抗得1分，最多600分</color></size>"
  },
  Task_10901_Desc = {
    Text = "通过关卡"
  },
  Task_10901_Name = {
    Text = "通关关卡"
  },
  Task_10902_Desc = {
    Text = "通过关卡"
  },
  Task_10902_Name = {
    Text = "通关关卡"
  },
  Task_10903_Name = {Text = "19"},
  Task_10904_Desc = {
    Text = "最终战不超过8回合取胜"
  },
  Task_10904_Name = {
    Text = "速战速决"
  },
  Task_10905_Desc = {
    Text = "与地底蜡像战斗"
  },
  Task_10905_Name = {Text = "目标"},
  Task_10906_Desc = {
    Text = "通关时症状不多于3张"
  },
  Task_10906_Name = {
    Text = "神清气爽"
  },
  Task_10907_Desc = {
    Text = "经历最多7场战斗通关"
  },
  Task_10907_Name = {
    Text = "精准突破"
  },
  Task_10908_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10908_Name = {
    Text = "完美通过"
  },
  Task_10909_Desc = {
    Text = "守密人达到15级"
  },
  Task_10909_Name = {
    Text = "守密人试训II"
  },
  Task_10910_Desc = {
    Text = "在调查事件「东区秘事」中共鸣8次"
  },
  Task_10910_Name = {
    Text = "感激回响Ⅲ"
  },
  Task_10911_Desc = {
    Text = "在调查事件「东区迷雾」中共鸣6次"
  },
  Task_10911_Name = {
    Text = "感激回响Ⅱ"
  },
  Task_10912_Desc = {
    Text = "将1名血肉界域唤醒体升格至2阶"
  },
  Task_10912_Name = {
    Text = "血肉精通Ⅱ"
  },
  Task_10913_Desc = {
    Text = "吱吱，吱吱……！！"
  },
  Task_10913_Name = {Text = "吱吱"},
  Task_10914_Desc = {
    Text = "前往馆长室"
  },
  Task_10914_Name = {Text = "目标"},
  Task_10915_Desc = {
    Text = "与12名唤醒体同调率到达等级5"
  },
  Task_10915_Name = {
    Text = "默契拍档Ⅵ"
  },
  Task_10916_Desc = {
    Text = "完成调查事件「东区秘事」"
  },
  Task_10916_Name = {
    Text = "金色糖纸"
  },
  Task_10917_Desc = {
    Text = "与16名唤醒体同调率到达等级5"
  },
  Task_10917_Name = {
    Text = "默契拍档Ⅷ"
  },
  Task_10918_Desc = {
    Text = "完成调查事件「@1@2」"
  },
  Task_10918_Desc2 = {
    Text = "完成调查事件「谨防恶犬」"
  },
  Task_10918_Name = {Text = "@1@2"},
  Task_10918_Name2 = {
    Text = "超越维度之眼"
  },
  Task_10919_Desc = {
    Text = "通过关卡"
  },
  Task_10919_Name = {
    Text = "通关关卡"
  },
  Task_10920_Desc = {
    Text = "通过关卡"
  },
  Task_10920_Name = {
    Text = "通关关卡"
  },
  Task_10921_Desc = {
    Text = "通过关卡"
  },
  Task_10921_Name = {
    Text = "通关关卡"
  },
  Task_10922_Desc = {
    Text = "完成200次波纳佩之墟"
  },
  Task_10922_Name = {
    Text = "波纳佩的赐福Ⅲ"
  },
  Task_10923_Desc = {
    Text = "完成100次波纳佩之墟"
  },
  Task_10923_Name = {
    Text = "波纳佩的赐福Ⅱ"
  },
  Task_10924_Desc = {
    Text = "完成400次混沌集群"
  },
  Task_10924_Name = {
    Text = "集群论者Ⅳ"
  },
  Task_10925_Desc = {
    Text = "完成200次混沌集群"
  },
  Task_10925_Name = {
    Text = "集群论者Ⅲ"
  },
  Task_10926_Desc = {
    Text = "完成50次波纳佩之墟"
  },
  Task_10926_Name = {
    Text = "波纳佩的赐福"
  },
  Task_10927_Desc = {
    Text = "完成600次混沌集群"
  },
  Task_10927_Name = {
    Text = "集群论者Ⅴ"
  },
  Task_10928_Desc = {
    Text = "调查240次维度残像"
  },
  Task_10928_Name = {
    Text = "超维之墟Ⅴ"
  },
  Task_10929_Desc = {
    Text = "调查120次维度残像"
  },
  Task_10929_Name = {
    Text = "超维之墟Ⅳ"
  },
  Task_10931_Desc = {
    Text = "完成50次混沌集群"
  },
  Task_10931_Name = {
    Text = "集群论者"
  },
  Task_10932_Desc = {
    Text = "累计消耗2500黑印"
  },
  Task_10932_Name = {
    Text = "黑色召唤Ⅳ"
  },
  Task_10933_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10933_Name = {
    Text = "完美通过"
  },
  Task_10934_CompleteCondDesc = {
    Text = "派遣总等级>={s1}"
  },
  Task_10934_Desc = {
    Text = "所有生命最终都会回归大海。\n就像永不停歇的时间之流，它是终结的开始。"
  },
  Task_10934_Name = {
    Text = "研究任务：碧蓝诗篇"
  },
  Task_10934_UnlockCondDesc = {
    Text = "守密人 25 级开放"
  },
  Task_10935_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10935_Name = {
    Text = "完美通过"
  },
  Task_10936_Desc = {
    Text = "每场60分"
  },
  Task_10936_Name = {
    Text = "战胜精英  <size=20><color=#747474>每场60分</color></size>"
  },
  Task_10937_Name = {Text = "78"},
  Task_10938_Desc = {
    Text = "拥有18件等级12的密契"
  },
  Task_10938_Name = {
    Text = "密契收藏家Ⅲ"
  },
  Task_10939_Name = {Text = "79"},
  Task_10940_Name = {Text = "77"},
  Task_10941_Desc = {
    Text = "通关时任一唤醒体的牌不超过1张，获得100分"
  },
  Task_10941_Name = {
    Text = "被忽略的  <size=20><color=#747474>通关时一个唤醒体的所有卡牌不多于1张</color></size>"
  },
  Task_10943_Name = {Text = "74"},
  Task_10944_Desc = {
    Text = "拥有4名等级20的深海唤醒体"
  },
  Task_10944_Name = {
    Text = "深海之主II"
  },
  Task_10945_Name = {Text = "75"},
  Task_10946_Desc = {
    Text = "将4名唤醒体提升至50级"
  },
  Task_10946_Name = {Text = "任务2"},
  Task_10947_Desc = {
    Text = "通过关卡"
  },
  Task_10947_Name = {
    Text = "目标1待包装文案"
  },
  Task_10948_Desc = {
    Text = "调查疯人院"
  },
  Task_10948_Name = {Text = "目标"},
  Task_10949_Desc = {
    Text = "通关时症状不多于1张"
  },
  Task_10949_Name = {
    Text = "神清气爽"
  },
  Task_10950_Name = {Text = "48"},
  Task_10951_Desc = {
    Text = "通关时每剩余1%生命得1分，最多100分"
  },
  Task_10951_Name = {
    Text = "剩余生命  <size=20><color=#747474>通关时每剩余1%生命得1分，最多100分</color></size>"
  },
  Task_10953_Desc = {
    Text = "完成调查主线第2章「以蜡像之名」困难难度"
  },
  Task_10954_Desc = {
    Text = "「安抚」愤怒的孩子们"
  },
  Task_10954_Name = {Text = "目标"},
  Task_10955_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10955_Name = {
    Text = "速战速决"
  },
  Task_10956_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_10956_Name = {
    Text = "速战速决"
  },
  Task_10957_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_10957_Name = {
    Text = "速战速决"
  },
  Task_10958_Desc = {
    Text = "通过关卡"
  },
  Task_10958_Name = {
    Text = "通关关卡"
  },
  Task_10959_Desc = {
    Text = "通关无光之境Ⅲ（未完成）"
  },
  Task_10962_Desc = {
    Text = "通过关卡"
  },
  Task_10962_Name = {
    Text = "通关关卡"
  },
  Task_10963_Desc = {
    Text = "移动不超过35步通关"
  },
  Task_10963_Name = {
    Text = "运筹帷幄"
  },
  Task_10964_Desc = {
    Text = "通过关卡"
  },
  Task_10964_Name = {
    Text = "目标提示最多8字"
  },
  Task_10965_Desc = {
    Text = "最终战不超过15回合取胜"
  },
  Task_10965_Name = {
    Text = "速战速决"
  },
  Task_10966_Desc = {
    Text = "移动不超过40步通关"
  },
  Task_10966_Name = {
    Text = "运筹帷幄"
  },
  Task_10969_Desc = {
    Text = "通关时生命不低于80%"
  },
  Task_10969_Name = {
    Text = "安全第一"
  },
  Task_10970_Desc = {
    Text = "将1名深海界域唤醒体升格至4阶"
  },
  Task_10970_Name = {
    Text = "深海精通Ⅳ"
  },
  Task_10971_Desc = {
    Text = "最终战不超过8回合取胜"
  },
  Task_10971_Name = {
    Text = "速战速决"
  },
  Task_10972_Desc = {
    Text = "将1名血肉界域唤醒体升格至4阶"
  },
  Task_10972_Name = {
    Text = "血肉精通Ⅳ"
  },
  Task_10973_Desc = {
    Text = "经历最多7场战斗通关"
  },
  Task_10973_Name = {
    Text = "精准突破"
  },
  Task_10974_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10974_Name = {
    Text = "完美通过"
  },
  Task_10975_CompleteCondDesc = {
    Text = "派遣总等级>={s1}"
  },
  Task_10975_Desc = {
    Text = "「它将转写你的心。」\n「是吗？那它一定千疮百孔吧。」"
  },
  Task_10975_Name = {
    Text = "调查任务：影像疗法"
  },
  Task_10975_UnlockCondDesc = {
    Text = "完成调查事件 1-13 开放"
  },
  Task_10976_Desc = {
    Text = "完成主线调查事件·困难4-12"
  },
  Task_10976_Name = {Text = "任务3"},
  Task_10977_Desc = {
    Text = "总回合26回合内通关"
  },
  Task_10977_Name = {
    Text = "总回合26回合内通关"
  },
  Task_10981_Desc = {
    Text = "最终战5回合内取胜"
  },
  Task_10981_Name = {
    Text = "最终战5回合内取胜"
  },
  Task_10982_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10982_Name = {
    Text = "完美通过"
  },
  Task_10983_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10983_Name = {
    Text = "完美通过"
  },
  Task_10984_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10984_Name = {
    Text = "完美通过"
  },
  Task_10985_Desc = {
    Text = "调查60次器质残像"
  },
  Task_10985_Name = {
    Text = "血肉之墟Ⅲ"
  },
  Task_10986_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10986_Name = {
    Text = "完美通过"
  },
  Task_10987_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_10987_Name = {
    Text = "完美通过"
  },
  Task_10988_Desc = {
    Text = "通过关卡"
  },
  Task_10988_Name = {
    Text = "通关关卡"
  },
  Task_10989_Desc = {
    Text = "通过关卡"
  },
  Task_10989_Name = {
    Text = "通关关卡"
  },
  Task_10990_Name = {Text = "49"},
  Task_10991_Desc = {
    Text = "通过关卡"
  },
  Task_10991_Name = {
    Text = "通关关卡"
  },
  Task_10992_Desc = {
    Text = "通过关卡"
  },
  Task_10992_Name = {
    Text = "通关关卡"
  },
  Task_10993_Desc = {
    Text = "警惕黑暗中潜伏之物"
  },
  Task_10993_Name = {Text = "目标"},
  Task_10994_Desc = {
    Text = "通过关卡"
  },
  Task_10994_Name = {
    Text = "通关关卡"
  },
  Task_10995_Desc = {
    Text = "通过关卡"
  },
  Task_10995_Name = {
    Text = "通关关卡"
  },
  Task_10996_Name = {Text = "43"},
  Task_10997_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_10997_Name = {
    Text = "安全第一"
  },
  Task_10998_Desc = {
    Text = "经历最多7场战斗通关"
  },
  Task_10998_Name = {
    Text = "精准突破"
  },
  Task_10999_Desc = {
    Text = "最终战不超过7回合取胜"
  },
  Task_10999_Name = {
    Text = "速战速决"
  },
  Task_11000_Name = {Text = "47"},
  Task_11001_Name = {Text = "46"},
  Task_11002_Name = {Text = "45"},
  Task_11003_Desc = {
    Text = "通关时症状不多于1张"
  },
  Task_11003_Name = {
    Text = "神清气爽"
  },
  Task_11004_Desc = {
    Text = "协助萝坦追击敌人"
  },
  Task_11004_Name = {Text = "目标"},
  Task_11005_Desc = {
    Text = "调查120次海渊残像"
  },
  Task_11005_Name = {
    Text = "深海之墟Ⅳ"
  },
  Task_11006_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_11006_Name = {
    Text = "完美通过"
  },
  Task_11007_Desc = {
    Text = "完成调查事件「@1@2」"
  },
  Task_11007_Desc2 = {
    Text = "完成调查事件「于无声处」"
  },
  Task_11007_Name = {Text = "@1@2"},
  Task_11007_Name2 = {
    Text = "妈妈，我不疼"
  },
  Task_11008_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_11008_Name = {
    Text = "完美通过"
  },
  Task_11009_Desc = {
    Text = "通过关卡"
  },
  Task_11009_Name = {
    Text = "通关关卡"
  },
  Task_11010_Desc = {
    Text = "累计消耗5000黑印"
  },
  Task_11010_Name = {
    Text = "黑色召唤Ⅴ"
  },
  Task_11011_Desc = {
    Text = "通关时剩余血量百分比大于等于80"
  },
  Task_11011_Name = {
    Text = "小菜一碟"
  },
  Task_11012_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_11012_Name = {
    Text = "速战速决"
  },
  Task_11013_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_11013_Name = {
    Text = "完美通过"
  },
  Task_11014_Desc = {
    Text = "强化密契3次"
  },
  Task_11014_Name = {
    Text = "时间测试2（未启用）"
  },
  Task_11015_Desc = {
    Text = "升级唤醒体3次"
  },
  Task_11015_Name = {
    Text = "时间测试1（未启用）"
  },
  Task_11016_Desc = {
    Text = "特定战斗X（精英）中，被添加特定状态中毒（Y）层数大于等于20"
  },
  Task_11016_Name = {
    Text = "成瘾剂量"
  },
  Task_11017_Desc = {
    Text = "最终战单回合累积护盾大于等于1500"
  },
  Task_11017_Name = {
    Text = "防卫过度"
  },
  Task_11018_Desc = {
    Text = "累计消耗500黑印"
  },
  Task_11018_Name = {
    Text = "黑色召唤Ⅱ"
  },
  Task_11019_Desc = {
    Text = "拥有4名等级30的深海唤醒体"
  },
  Task_11019_Name = {
    Text = "深海之主III"
  },
  Task_11020_Desc = {
    Text = "通过关卡"
  },
  Task_11020_Name = {
    Text = "通关关卡"
  },
  Task_11021_Desc = {
    Text = "拥有4名等级50的深海唤醒体"
  },
  Task_11021_Name = {
    Text = "深海之主Ⅴ"
  },
  Task_11022_Desc = {
    Text = "通过关卡"
  },
  Task_11022_Name = {
    Text = "通关关卡"
  },
  Task_11023_Desc = {
    Text = "拥有4名等级50的血肉唤醒体"
  },
  Task_11023_Name = {
    Text = "血肉之主Ⅴ"
  },
  Task_11024_Desc = {
    Text = "累计消耗250黑印"
  },
  Task_11024_Name = {
    Text = "黑色召唤"
  },
  Task_11025_Desc = {
    Text = "拥有4名等级10的深海唤醒体"
  },
  Task_11025_Name = {
    Text = "深海之主"
  },
  Task_11026_Desc = {
    Text = "拥有4名等级60的血肉唤醒体"
  },
  Task_11026_Name = {
    Text = "血肉之主Ⅵ"
  },
  Task_11027_Desc = {
    Text = "在特定类型战斗X中，一回合打出卡牌数量大于等于20"
  },
  Task_11027_Name = {
    Text = "卡牌大师"
  },
  Task_11029_Desc = {
    Text = "在调查事件「@1@2」中共鸣10次"
  },
  Task_11029_Desc2 = {
    Text = "在调查事件「于无声处」中共鸣10次"
  },
  Task_11029_Name = {Text = "@1@2"},
  Task_11029_Name2 = {
    Text = "苦痛回响Ⅳ"
  },
  Task_11030_Desc = {
    Text = "通关时至少拥有8张刻印卡牌"
  },
  Task_11030_Name = {
    Text = "刻印之力"
  },
  Task_11031_Desc = {
    Text = "通过关卡"
  },
  Task_11031_Name = {
    Text = "通关关卡"
  },
  Task_11032_Desc = {
    Text = "在特定战斗X中，一回合额外抽取卡牌数量大于等于5"
  },
  Task_11032_Name = {
    Text = "妙手偶得"
  },
  Task_11033_Desc = {
    Text = "完成调查事件「以蜡像之名」困难难度"
  },
  Task_11033_Name = {
    Text = "蜡中的迷思·困难"
  },
  Task_11034_Desc = {
    Text = "击退达芙黛尔"
  },
  Task_11034_Name = {Text = "目标"},
  Task_11035_Desc = {
    Text = "特定战斗X中，叠加护盾大于等于200（X精英战）"
  },
  Task_11035_Name = {
    Text = "坚不可摧"
  },
  Task_11036_Desc = {
    Text = "完成调查事件「东区秘事」困难难度"
  },
  Task_11036_Name = {
    Text = "东区迷雾·困难"
  },
  Task_11037_Name = {Text = "42"},
  Task_11038_Desc = {
    Text = "通关时触发死亡抵抗次数小于等于1"
  },
  Task_11038_Name = {
    Text = "无暇赴死"
  },
  Task_11041_Desc = {
    Text = "最终战不超过8回合取胜"
  },
  Task_11041_Name = {
    Text = "速战速决"
  },
  Task_11042_Desc = {
    Text = "寻找希莱斯特"
  },
  Task_11042_Name = {Text = "目标"},
  Task_11043_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_11043_Name = {
    Text = "完美通过"
  },
  Task_11044_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_11044_Name = {
    Text = "完美通过"
  },
  Task_11045_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_11045_Name = {
    Text = "完美通过"
  },
  Task_11046_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_11046_Name = {
    Text = "完美通过"
  },
  Task_11047_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_11047_Name = {
    Text = "完美通过"
  },
  Task_11048_Desc = {
    Text = "完成100次禁忌纂录"
  },
  Task_11048_Name = {
    Text = "密契篆刻师Ⅱ"
  },
  Task_11050_Desc = {
    Text = "通过关卡"
  },
  Task_11050_Name = {
    Text = "通关关卡"
  },
  Task_11052_Desc = {
    Text = "调查240次器质残像"
  },
  Task_11052_Name = {
    Text = "血肉之墟Ⅴ"
  },
  Task_11053_Desc = {
    Text = "最终战18回合内取胜"
  },
  Task_11053_Name = {
    Text = "最终战18回合内取胜"
  },
  Task_11054_Desc = {
    Text = "参观哈莉特的小屋"
  },
  Task_11054_Name = {Text = "目标"},
  Task_11055_Name = {Text = "41"},
  Task_11057_Desc = {
    Text = "移动不超过40步通关"
  },
  Task_11057_Name = {
    Text = "运筹帷幄"
  },
  Task_11058_Desc = {
    Text = "通关时症状不多于1张"
  },
  Task_11058_Name = {
    Text = "神清气爽"
  },
  Task_11059_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_11059_Name = {
    Text = "速战速决"
  },
  Task_11060_Desc = {
    Text = "完成100次混沌集群"
  },
  Task_11060_Name = {
    Text = "集群论者Ⅱ"
  },
  Task_11061_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_11061_Name = {
    Text = "速战速决"
  },
  Task_11062_Desc = {
    Text = "追上墨菲"
  },
  Task_11062_Name = {Text = "目标"},
  Task_11063_Desc = {
    Text = "找到声音源头"
  },
  Task_11063_Name = {Text = "目标"},
  Task_11064_Desc = {Text = "谢谢你"},
  Task_11064_Name = {
    Text = "谢谢你，"
  },
  Task_11065_Desc = {
    Text = "击退哈莉特"
  },
  Task_11065_Name = {Text = "目标"},
  Task_11066_Desc = {
    Text = "别忘了我哦。"
  },
  Task_11066_Name = {
    Text = "别忘了我哦。"
  },
  Task_11067_Desc = {
    Text = "谢谢你们……"
  },
  Task_11067_Name = {
    Text = "谢谢你们……"
  },
  Task_11068_Desc = {
    Text = "最终战不超过15回合取胜"
  },
  Task_11068_Name = {
    Text = "速战速决"
  },
  Task_11069_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_11069_Name = {
    Text = "完美通过"
  },
  Task_11070_Desc = {
    Text = "总回合16回合内通关"
  },
  Task_11070_Name = {
    Text = "总回合16回合内通关"
  },
  Task_11071_Desc = {
    Text = "总回合21回合内通关"
  },
  Task_11071_Name = {
    Text = "总回合21回合内通关"
  },
  Task_11072_Desc = {
    Text = "总回合11回合内通关"
  },
  Task_11072_Name = {
    Text = "总回合11回合内通关"
  },
  Task_11073_Desc = {
    Text = "通过关卡"
  },
  Task_11073_Name = {
    Text = "通关关卡"
  },
  Task_11074_Desc = {
    Text = "通过关卡"
  },
  Task_11074_Name = {
    Text = "通关关卡"
  },
  Task_11075_Desc = {
    Text = "通过关卡"
  },
  Task_11075_Name = {
    Text = "通关关卡"
  },
  Task_11076_Desc = {
    Text = "总回合31回合内通关"
  },
  Task_11076_Name = {
    Text = "总回合31回合内通关"
  },
  Task_11077_Desc = {
    Text = "拥有4名等级50的混沌唤醒体"
  },
  Task_11077_Name = {
    Text = "混沌之主Ⅴ"
  },
  Task_11078_Desc = {
    Text = "拥有4名等级40的混沌唤醒体"
  },
  Task_11078_Name = {
    Text = "混沌之主Ⅳ"
  },
  Task_11079_Desc = {
    Text = "拥有4名等级10的血肉唤醒体"
  },
  Task_11079_Name = {
    Text = "血肉之主"
  },
  Task_11080_Desc = {
    Text = "拥有4名等级60的混沌唤醒体"
  },
  Task_11080_Name = {
    Text = "混沌之主Ⅵ"
  },
  Task_11081_Desc = {
    Text = "拥有4名等级10的混沌唤醒体"
  },
  Task_11081_Name = {
    Text = "混沌之主"
  },
  Task_11082_Desc = {
    Text = "拥有4名等级30的混沌唤醒体"
  },
  Task_11082_Name = {
    Text = "混沌之主III"
  },
  Task_11083_Desc = {
    Text = "拥有4名等级20的混沌唤醒体"
  },
  Task_11083_Name = {
    Text = "混沌之主II"
  },
  Task_11084_Desc = {
    Text = "一场战斗触发4次死亡抵抗，并本局胜利"
  },
  Task_11084_Name = {
    Text = "不死不休"
  },
  Task_11085_Desc = {
    Text = "一回合内触腕攻击敌人15次，并本局胜利"
  },
  Task_11085_Name = {
    Text = "螺湮主宰"
  },
  Task_11086_Desc = {
    Text = "在超维回合中触发 5 次跃迁，并胜利"
  },
  Task_11086_Name = {
    Text = "维度跃迁者"
  },
  Task_11087_Desc = {
    Text = "一回合吞噬 5 个胚胎，并胜利"
  },
  Task_11087_Name = {
    Text = "饥肠辘辘"
  },
  Task_11088_Desc = {
    Text = "一回合打出15张牌，并胜利"
  },
  Task_11088_Name = {
    Text = "我的回合"
  },
  Task_11089_Desc = {
    Text = "一回合打出6张症状牌，并胜利"
  },
  Task_11089_Name = {
    Text = "重症患者"
  },
  Task_11090_Desc = {
    Text = "一回合打出10张打击牌，并胜利"
  },
  Task_11090_Name = {
    Text = "无尽的打击"
  },
  Task_11091_Desc = {
    Text = "战斗胜利时手牌、弃牌堆、抽牌堆共拥有少于等于 8 张牌"
  },
  Task_11091_Name = {
    Text = "口袋空空"
  },
  Task_11092_Desc = {
    Text = "追击「24」"
  },
  Task_11092_Name = {Text = "目标"},
  Task_11093_Name = {Text = "53"},
  Task_11094_Desc = {
    Text = "完成调查事件「谨防恶犬」困难难度"
  },
  Task_11094_Name = {
    Text = "超越维度之眼·困难"
  },
  Task_11095_Desc = {
    Text = "消耗500000蔷薇金券"
  },
  Task_11095_Name = {
    Text = "挥金如土"
  },
  Task_11096_Desc = {
    Text = "消耗1000000蔷薇金券"
  },
  Task_11096_Name = {
    Text = "挥金如土Ⅱ"
  },
  Task_11097_Desc = {
    Text = "首领战获得胜利，获得1200分"
  },
  Task_11097_Name = {
    Text = "战胜首领  <size=20><color=#747474>首领战获得胜利，获得1200分</color></size>"
  },
  Task_11098_Desc = {
    Text = "最终战9回合内取胜"
  },
  Task_11098_Name = {
    Text = "最终战9回合内取胜"
  },
  Task_11099_Desc = {
    Text = "回到主人身边"
  },
  Task_11099_Name = {Text = "目标"},
  Task_11100_Desc = {
    Text = "探寻声音的来源"
  },
  Task_11100_Name = {Text = "目标"},
  Task_11101_Desc = {
    Text = "最终战不超过8回合取胜"
  },
  Task_11101_Name = {
    Text = "速战速决"
  },
  Task_11102_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_11102_Name = {
    Text = "完美通过"
  },
  Task_11103_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_11103_Name = {
    Text = "完美通过"
  },
  Task_11104_Desc = {
    Text = "最终战不超过15回合取胜"
  },
  Task_11104_Name = {
    Text = "速战速决"
  },
  Task_11105_Desc = {
    Text = "通过关卡"
  },
  Task_11105_Name = {
    Text = "通关关卡"
  },
  Task_11106_Desc = {
    Text = "拥有4名等级30的血肉唤醒体"
  },
  Task_11106_Name = {
    Text = "血肉之主III"
  },
  Task_11107_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_11107_Name = {
    Text = "完美通过"
  },
  Task_11108_Desc = {
    Text = "找到蜡像《春》"
  },
  Task_11108_Name = {Text = "目标"},
  Task_11109_Desc = {
    Text = "穿越甲板"
  },
  Task_11109_Name = {Text = "目标"},
  Task_11111_Desc = {
    Text = "通过关卡"
  },
  Task_11111_Name = {
    Text = "通关关卡"
  },
  Task_11112_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_11112_Name = {
    Text = "速战速决"
  },
  Task_11113_Desc = {
    Text = "追上猎颅者"
  },
  Task_11113_Name = {Text = "目标"},
  Task_11114_Desc = {
    Text = "最终战8回合内取胜"
  },
  Task_11114_Name = {
    Text = "最终战8回合内取胜"
  },
  Task_11115_Desc = {
    Text = "总回合58回合内通关"
  },
  Task_11115_Name = {
    Text = "总回合58回合内通关"
  },
  Task_11116_Desc = {
    Text = "完成一次每日试训"
  },
  Task_11116_Name = {
    Text = "每日挑战"
  },
  Task_11117_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_11117_Name = {
    Text = "完美通过"
  },
  Task_11118_Desc = {
    Text = "通过关卡"
  },
  Task_11118_Name = {
    Text = "通关关卡"
  },
  Task_11119_Desc = {
    Text = "消灭融蚀体"
  },
  Task_11119_Name = {Text = "目标"},
  Task_11120_Desc = {
    Text = "通过关卡"
  },
  Task_11120_Name = {
    Text = "通关关卡"
  },
  Task_11121_Desc = {
    Text = "登上救生船"
  },
  Task_11121_Name = {Text = "目标"},
  Task_11122_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_11122_Name = {
    Text = "速战速决"
  },
  Task_11123_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_11123_Name = {
    Text = "速战速决"
  },
  Task_11124_Desc = {
    Text = "通过关卡"
  },
  Task_11124_Name = {
    Text = "通关关卡"
  },
  Task_11125_Desc = {
    Text = "完成本章所有任务后可领取"
  },
  Task_11125_Name = {
    Text = "界域精通Ⅳ"
  },
  Task_11126_Desc = {
    Text = "完成200次制剂淬炼"
  },
  Task_11126_Name = {
    Text = "调制高手Ⅲ"
  },
  Task_11127_Name = {Text = "44"},
  Task_11128_Desc = {
    Text = "不使用应急灵知体通关"
  },
  Task_11128_Name = {
    Text = "一命通关  <size=20><color=#747474>不使用应急灵知体通关</color></size>"
  },
  Task_11129_Desc = {
    Text = "回到前台，找到潘狄娅"
  },
  Task_11129_Name = {Text = "目标"},
  Task_11130_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_11130_Name = {
    Text = "完美通过"
  },
  Task_11135_Desc = {
    Text = "逃离弥利亚姆"
  },
  Task_11135_Name = {Text = "目标"},
  Task_11136_Desc = {
    Text = "累计提升唤醒体技能6次"
  },
  Task_11136_Name = {Text = "任务4"},
  Task_11137_Desc = {
    Text = "完成1次超验存在"
  },
  Task_11137_Name = {Text = "任务5"},
  Task_11138_Desc = {
    Text = "在冶炼室中进行1次材料合成"
  },
  Task_11138_Name = {Text = "任务1"},
  Task_11139_Desc = {
    Text = "将4个唤醒体提升至30级"
  },
  Task_11139_Name = {Text = "任务2"},
  Task_11140_Desc = {
    Text = "通关混沌之域间隙Ⅳ"
  },
  Task_11140_Name = {Text = "任务3"},
  Task_11141_Desc = {
    Text = "总回合39回合内通关"
  },
  Task_11141_Name = {
    Text = "总回合39回合内通关"
  },
  Task_11142_Desc = {
    Text = "总回合33回合内通关"
  },
  Task_11142_Name = {
    Text = "总回合33回合内通关"
  },
  Task_11143_Desc = {
    Text = "总回合54回合内通关"
  },
  Task_11143_Name = {
    Text = "总回合54回合内通关"
  },
  Task_11144_Desc = {
    Text = "总回合48回合内通关"
  },
  Task_11144_Name = {
    Text = "总回合48回合内通关"
  },
  Task_11145_Desc = {
    Text = "总回合14回合内通关"
  },
  Task_11145_Name = {
    Text = "总回合14回合内通关"
  },
  Task_11146_Desc = {
    Text = "移动不超过50步通关"
  },
  Task_11146_Name = {
    Text = "运筹帷幄"
  },
  Task_11147_Desc = {
    Text = "总回合26回合内通关"
  },
  Task_11147_Name = {
    Text = "总回合26回合内通关"
  },
  Task_11148_Desc = {
    Text = "总回合20回合内通关"
  },
  Task_11148_Name = {
    Text = "总回合20回合内通关"
  },
  Task_11149_Desc = {
    Text = "通过关卡"
  },
  Task_11149_Name = {
    Text = "通关关卡"
  },
  Task_11150_Desc = {
    Text = "总回合66回合内通关"
  },
  Task_11150_Name = {
    Text = "总回合66回合内通关"
  },
  Task_11151_Desc = {
    Text = "总回合60回合内通关"
  },
  Task_11151_Name = {
    Text = "总回合60回合内通关"
  },
  Task_11152_Desc = {
    Text = "完成阶段内全部任务可领取奖励"
  },
  Task_11152_Name = {
    Text = "第六阶段"
  },
  Task_11153_Desc = {
    Text = "完成本章所有任务后可领取"
  },
  Task_11153_Name = {
    Text = "界域精通Ⅰ"
  },
  Task_11154_Desc = {
    Text = "通过关卡"
  },
  Task_11154_Name = {
    Text = "通关关卡"
  },
  Task_11155_Desc = {
    Text = "通关时症状不多于3张"
  },
  Task_11155_Name = {
    Text = "神清气爽"
  },
  Task_11156_Desc = {
    Text = "完成调查主线第1章「东区秘事」"
  },
  Task_11157_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_11157_Name = {
    Text = "完美通过"
  },
  Task_116471_Desc = {
    Text = "使用深海界域唤醒体在「交融的苦血」中获胜2次"
  },
  Task_116472_Desc = {
    Text = "通关「风的托举」任意难度"
  },
  Task_116473_Desc = {
    Text = "交融的苦血·通关"
  },
  Task_116474_Desc = {
    Text = "通关「双生羽翼」癫狂难度"
  },
  Task_116475_Desc = {
    Text = "通关「冒险童话」任意难度"
  },
  Task_116476_Desc = {
    Text = "通关异梦视界「天边之外·下」"
  },
  Task_116477_Desc = {
    Text = "使用超维界域唤醒体在「交融的苦血」中获胜1次"
  },
  Task_116478_Desc = {
    Text = "通关「遗忘毒药」任意难度"
  },
  Task_116479_Desc = {
    Text = "通关「天真时代」任意难度"
  },
  Task_116480_Desc = {
    Text = "使用混沌界域唤醒体在「交融的苦血」中获胜2次"
  },
  Task_116481_Desc = {
    Text = "完成「交融的苦血·通关」所有成就"
  },
  Task_116482_Desc = {
    Text = "通关「天真时代」癫狂难度"
  },
  Task_116483_Desc = {
    Text = "通关「沉默觉醒」任意难度"
  },
  Task_116484_Desc = {
    Text = "通关「旧账本」任意难度"
  },
  Task_116485_Desc = {
    Text = "通关「旧账本」任意难度"
  },
  Task_116486_Desc = {
    Text = "交融的苦血·癫狂"
  },
  Task_116487_Desc = {
    Text = "使用深海界域唤醒体在「交融的苦血」中获胜1次"
  },
  Task_116488_Desc = {
    Text = "交融的苦血·界域"
  },
  Task_116489_Desc = {
    Text = "通关「双生羽翼」任意难度"
  },
  Task_116490_Desc = {
    Text = "通关「遗忘毒药」任意难度"
  },
  Task_116491_Desc = {
    Text = "通关「冒险童话」癫狂难度"
  },
  Task_116492_Desc = {
    Text = "通关「旧账本」癫狂难度"
  },
  Task_116493_Desc = {
    Text = "通关「风的托举」任意难度"
  },
  Task_116494_Desc = {
    Text = "通关「沉默觉醒」癫狂难度"
  },
  Task_116495_Desc = {
    Text = "通关「冒险童话」任意难度"
  },
  Task_116496_Desc = {
    Text = "通关「天真时代」任意难度"
  },
  Task_116497_Desc = {
    Text = "通关「遗忘毒药」癫狂难度"
  },
  Task_116498_Desc = {
    Text = "使用血肉界域唤醒体在「交融的苦血」中获胜2次"
  },
  Task_116499_Desc = {
    Text = "通关「风的托举」癫狂难度"
  },
  Task_116500_Desc = {
    Text = "使用血肉界域唤醒体在「交融的苦血」中获胜1次"
  },
  Task_116501_Desc = {
    Text = "通关「双生羽翼」任意难度"
  },
  Task_116502_Desc = {
    Text = "通关「沉默觉醒」任意难度"
  },
  Task_116503_Desc = {
    Text = "使用超维界域唤醒体在「交融的苦血」中获胜2次"
  },
  Task_116504_Desc = {
    Text = "使用混沌界域唤醒体在「交融的苦血」中获胜1次"
  },
  Task_116767_Desc = {
    Text = "通关 1 次波吕克斯试玩关卡"
  },
  Task_116768_Desc = {
    Text = "累计登录 1 天"
  },
  Task_116769_Desc = {
    Text = "通关超验存在 1 次"
  },
  Task_116770_Desc = {
    Text = "通关超验存在 1 次"
  },
  Task_116771_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_116772_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_116773_Desc = {
    Text = "完成 4 次每日试训"
  },
  Task_116774_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_116775_Desc = {
    Text = "累计登录 1 天"
  },
  Task_116776_Desc = {
    Text = "完成 4 次每日试训"
  },
  Task_116777_Desc = {
    Text = "消耗灵啡肽 1500 点"
  },
  Task_116778_Desc = {
    Text = "消耗灵啡肽 1500 点"
  },
  Task_116779_Desc = {
    Text = "唤醒 30 次"
  },
  Task_116780_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_116781_Desc = {
    Text = "唤醒 30 次"
  },
  Task_116782_Desc = {
    Text = "通关 1 次波吕克斯试玩关卡"
  },
  Task_116793_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_116793_Name = {Text = "3胜"},
  Task_116794_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_116794_Name = {Text = "1胜"},
  Task_116795_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_116795_Name = {Text = "6胜"},
  Task_116796_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_116796_Name = {Text = "10胜"},
  Task_116809_Desc = {
    Text = "完成异梦视界「再见，永无乡」"
  },
  Task_116809_Name = {
    Text = "美梦余音"
  },
  Task_116810_Desc = {
    Text = "完成异梦视界「再见，永无乡」困难难度"
  },
  Task_116810_Name = {
    Text = "美梦余音·困难"
  },
  Task_116820_Name = {
    Text = "击败BOSS3N次"
  },
  Task_116821_Name = {
    Text = "击败BOSS6N次"
  },
  Task_116822_Name = {
    Text = "击杀全部BOSS"
  },
  Task_116823_Name = {
    Text = "击败BOSS5N次"
  },
  Task_116824_Name = {
    Text = "击败BOSS1N次"
  },
  Task_116825_Name = {
    Text = "击败BOSS4N次"
  },
  Task_116826_Name = {
    Text = "击败BOSS7N次"
  },
  Task_116827_Name = {
    Text = "击败BOSS2N次"
  },
  Task_116884_Desc = {
    Text = "累计登录 11 天"
  },
  Task_116885_Desc = {
    Text = "累计登录 13 天"
  },
  Task_116886_Desc = {
    Text = "累计登录 7 天"
  },
  Task_116887_Desc = {
    Text = "累计登录 9 天"
  },
  Task_116888_Desc = {
    Text = "累计登录 10 天"
  },
  Task_116890_Desc = {
    Text = "累计登录 8 天"
  },
  Task_116891_Desc = {
    Text = "累计登录 16 天"
  },
  Task_116892_Desc = {
    Text = "累计登录 15 天"
  },
  Task_116894_Desc = {
    Text = "累计登录 4 天"
  },
  Task_116895_Desc = {
    Text = "累计登录 5 天"
  },
  Task_116896_Desc = {
    Text = "累计登录 3 天"
  },
  Task_116897_Desc = {
    Text = "累计登录 6 天"
  },
  Task_116899_Desc = {
    Text = "累计登录 1 天"
  },
  Task_116900_Desc = {
    Text = "累计登录 14 天"
  },
  Task_116901_Desc = {
    Text = "累计登录 2 天"
  },
  Task_116903_Desc = {
    Text = "累计登录 12 天"
  },
  Task_117156_Desc = {
    Text = "使用深海界域唤醒体在「湖中之城」中获胜1次"
  },
  Task_117157_Desc = {
    Text = "使用血肉界域唤醒体在「湖中之城」中获胜1次"
  },
  Task_117158_Desc = {
    Text = "使用超维界域唤醒体在「湖中之城」中获胜1次"
  },
  Task_117159_Desc = {
    Text = "使用混沌界域唤醒体在「湖中之城」中获胜1次"
  },
  Task_117304_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_117304_Name = {Text = "1胜"},
  Task_117305_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_117305_Name = {Text = "6胜"},
  Task_117306_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_117306_Name = {Text = "3胜"},
  Task_117307_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_117307_Name = {Text = "10胜"},
  Task_117487_Desc = {
    Text = "完成异梦视界「再见永无乡」困难难度"
  },
  Task_117487_Name = {
    Text = "永不言败 ·困难"
  },
  Task_117488_Desc = {
    Text = "完成异梦视界「再见永无乡」"
  },
  Task_117488_Name = {
    Text = "永不言败"
  },
  Task_117489_Desc = {
    Text = "完成异梦视界「天边之外·下」"
  },
  Task_117489_Name = {
    Text = "青空之上"
  },
  Task_118481_Desc = {
    Text = "带走墨菲"
  },
  Task_118481_Name = {Text = "目标"},
  Task_118482_Desc = {
    Text = "闯入仪式现场营救墨菲"
  },
  Task_118482_Name = {Text = "目标"},
  Task_118483_Desc = {
    Text = "重入乐园"
  },
  Task_118483_Name = {Text = "目标"},
  Task_118484_Desc = {
    Text = "揭开梦的帷幕"
  },
  Task_118484_Name = {Text = "目标"},
  Task_118485_Desc = {
    Text = "观察引航仪式"
  },
  Task_118485_Name = {Text = "目标"},
  Task_118486_Desc = {
    Text = "迎击漫天飞鱼"
  },
  Task_118486_Name = {Text = "目标"},
  Task_118487_Desc = {
    Text = "击退追击的蹈海者"
  },
  Task_118487_Name = {Text = "目标"},
  Task_118488_Desc = {
    Text = "抵达路的尽头"
  },
  Task_118488_Name = {Text = "目标"},
  Task_118489_Desc = {
    Text = "消灭「自我」"
  },
  Task_118489_Name = {Text = "目标"},
  Task_118490_Desc = {
    Text = "在乱局中救出墨菲"
  },
  Task_118490_Name = {Text = "目标"},
  Task_118787_Desc = {
    Text = "圣胎之咏"
  },
  Task_118791_Desc = {
    Text = "漆黑之链"
  },
  Task_118796_Desc = {
    Text = "沙海遗存"
  },
  Task_118799_Desc = {
    Text = "暗海之舟"
  },
  Task_118809_Desc = {
    Text = "荒沙之壁"
  },
  Task_118821_Desc = {
    Text = "蜡像之秘"
  },
  Task_118826_Desc = {
    Text = "浑浊残像"
  },
  Task_118835_Desc = {
    Text = "海渊残像"
  },
  Task_118837_Desc = {
    Text = "狂躁蜡馆"
  },
  Task_118842_Desc = {
    Text = "金券搜查"
  },
  Task_118845_Desc = {
    Text = "风暴外海"
  },
  Task_118852_Desc = {
    Text = "器质残像"
  },
  Task_118856_Desc = {
    Text = "错乱异镇"
  },
  Task_118860_Desc = {
    Text = "玩偶之泪"
  },
  Task_118871_Desc = {
    Text = "史瓦西喉"
  },
  Task_118873_Desc = {
    Text = "蠕虫之所"
  },
  Task_118877_Desc = {
    Text = "制剂淬炼"
  },
  Task_118879_Desc = {
    Text = "混沌集群"
  },
  Task_118881_Desc = {
    Text = "原初裂隙"
  },
  Task_118892_Desc = {
    Text = "虔诚之握"
  },
  Task_118907_Desc = {
    Text = "波纳佩之墟"
  },
  Task_118913_Desc = {
    Text = "界外之影"
  },
  Task_118915_Desc = {
    Text = "黑池之潮"
  },
  Task_118917_Desc = {
    Text = "维度残像"
  },
  Task_118918_Desc = {
    Text = "失序山脉"
  },
  Task_118922_Desc = {
    Text = "怪雾之都"
  },
  Task_118979_Desc = {
    Text = "棋逢对手·轮选"
  },
  Task_118980_Desc = {
    Text = "不使用「<color=#ae6abb>灵智</color>」唤醒体获得 20 胜场"
  },
  Task_118981_Desc = {
    Text = "在战斗中点击头像给 3 名对手发送表情「你好」或「Hi」"
  },
  Task_118982_Desc = {
    Text = "在预组模式中曾达到 500 积分"
  },
  Task_118983_Desc = {
    Text = "不使用「<color=#76bf9d>祝福</color>」唤醒体获得 20 胜场"
  },
  Task_118984_Desc = {
    Text = "在轮选模式中曾达到 1000 积分"
  },
  Task_118985_Desc = {
    Text = "在轮选模式中曾达到 2500 积分"
  },
  Task_118986_Desc = {
    Text = "完成「相位启蒙」所有成就"
  },
  Task_118987_Desc = {
    Text = "不使用「<color=#6a97c2>守护</color>」唤醒体获得 20 胜场"
  },
  Task_118988_Desc = {
    Text = "相位启蒙"
  },
  Task_118989_Desc = {
    Text = "在「对战表情」一次性携带 16 个表情参与相位对弈战斗"
  },
  Task_118990_Desc = {
    Text = "相位对弈战斗结束后复制对手阵容"
  },
  Task_118991_Desc = {
    Text = "参与 1 次「轮选模式」"
  },
  Task_118992_Desc = {
    Text = "在预组模式中曾达到 2000 积分"
  },
  Task_118993_Desc = {
    Text = "在轮选模式中曾达到 2000 积分"
  },
  Task_118994_Desc = {
    Text = "在轮选模式中曾达到 500 积分"
  },
  Task_118995_Desc = {
    Text = "在相位对弈战斗结束后与对手「再来一局」"
  },
  Task_118996_Desc = {
    Text = "在预组模式中曾达到 1000 积分"
  },
  Task_118997_Desc = {
    Text = "不使用「<color=#c26669>争斗</color>」唤醒体获得 20 胜场"
  },
  Task_118998_Desc = {
    Text = "在「收藏」内的卡牌评论点赞"
  },
  Task_118999_Desc = {
    Text = "在「收藏」内的「唤醒体试训」试玩唤醒体，并击败 1 只「熟悉的黑猫」"
  },
  Task_119000_Desc = {
    Text = "在预组模式中曾达到 3000 积分"
  },
  Task_119001_Desc = {
    Text = "参与 1 次「预组模式」"
  },
  Task_119002_Desc = {
    Text = "在预组模式中曾达到 1500 积分"
  },
  Task_119003_Desc = {
    Text = "在轮选模式中曾达到 3000 积分"
  },
  Task_119004_Desc = {
    Text = "在轮选模式中曾达到 1500 积分"
  },
  Task_119005_Desc = {
    Text = "棋逢对手·预组"
  },
  Task_119006_Desc = {
    Text = "在「守密人档案」的「战斗记录」观看相位对弈的「回放」"
  },
  Task_119007_Desc = {
    Text = "参与 1 次「密码对战」"
  },
  Task_119008_Desc = {
    Text = "在预组模式中曾达到 2500 积分"
  },
  Task_119009_Desc = {
    Text = "不使用「<color=#c3aa64>凶星</color>」唤醒体获得 20 胜场"
  },
  Task_119010_Desc = {
    Text = "万象洞悉"
  },
  Task_119193_Desc = {
    Text = "累计提取 68000 源液"
  },
  Task_119201_Desc = {
    Text = "累计提取 54000 源液"
  },
  Task_119212_Desc = {
    Text = "累计提取 42000 源液"
  },
  Task_119216_Desc = {
    Text = "累计提取 48000 源液"
  },
  Task_119217_Desc = {
    Text = "累计提取 36000 源液"
  },
  Task_119695_Desc = {
    Text = "累计登录 1 天"
  },
  Task_119696_Desc = {
    Text = "通关忘却篇第4章「于无声处」"
  },
  Task_119697_Desc = {
    Text = "通关星辰篇第4章「乐园」"
  },
  Task_119698_Desc = {
    Text = "累计使用 200 次钥令"
  },
  Task_119699_Desc = {
    Text = "通关忘却篇第7章「欲河」"
  },
  Task_120441_Desc = {
    Text = "完成「调查行动」第7章"
  },
  Task_120500_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_120501_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_120502_Desc = {
    Text = "在调查事件「@1@2」中共鸣2次"
  },
  Task_120502_Desc2 = {
    Text = "在调查事件「乐园」中共鸣2次"
  },
  Task_120502_Name = {Text = "@1@2"},
  Task_120502_Name2 = {
    Text = "虚妄回响"
  },
  Task_120503_Desc = {
    Text = "完成调查事件「@1@2」"
  },
  Task_120503_Desc2 = {
    Text = "完成调查事件「乐园」"
  },
  Task_120503_Name = {Text = "@1@2"},
  Task_120503_Name2 = {
    Text = "乐园的坍塌"
  },
  Task_120504_Desc = {
    Text = "通关星辰篇第4章 4-6"
  },
  Task_120505_Desc = {
    Text = "完成调查事件「乐园」困难难度"
  },
  Task_120505_Name = {
    Text = "乐园的坍塌·困难"
  },
  Task_120506_Desc = {
    Text = "在调查事件「@1@2」中共鸣6次"
  },
  Task_120506_Desc2 = {
    Text = "在调查事件「乐园」中共鸣6次"
  },
  Task_120506_Name = {Text = "@1@2"},
  Task_120506_Name2 = {
    Text = "虚妄回响Ⅲ"
  },
  Task_120507_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_120508_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_120509_Desc = {
    Text = "通关星辰篇第4章「乐园」困难难度"
  },
  Task_120510_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_120511_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_120512_Desc = {
    Text = "通关星辰篇第4章 4-6"
  },
  Task_120514_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_120515_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_120516_Desc = {
    Text = "通关星辰篇第4章 4-5 困难难度"
  },
  Task_120517_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_120518_Desc = {
    Text = "通关星辰篇第4章 4-5 困难难度"
  },
  Task_120519_Desc = {
    Text = "通关星辰篇第4章「乐园」"
  },
  Task_120520_Desc = {
    Text = "在调查事件「@1@2」中共鸣7次"
  },
  Task_120520_Desc2 = {
    Text = "在调查事件「乐园」中共鸣7次"
  },
  Task_120520_Name = {Text = "@1@2"},
  Task_120520_Name2 = {
    Text = "虚妄回响Ⅳ"
  },
  Task_120521_Desc = {
    Text = "通关星辰篇第4章「乐园」困难难度"
  },
  Task_120522_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_120523_Desc = {
    Text = "在调查事件「@1@2」中共鸣4次"
  },
  Task_120523_Desc2 = {
    Text = "在调查事件「乐园」中共鸣4次"
  },
  Task_120523_Name = {Text = "@1@2"},
  Task_120523_Name2 = {
    Text = "虚妄回响Ⅱ"
  },
  Task_120524_Desc = {
    Text = "通关星辰篇第4章「乐园」"
  },
  Task_120535_Desc = {
    Text = "通关忘却篇第4章「于无声处」"
  },
  Task_120536_Desc = {
    Text = "通关忘却篇第7章「欲河」"
  },
  Task_120537_Desc = {
    Text = "累计登录 1 天"
  },
  Task_120538_Desc = {
    Text = "通关星辰篇第4章「乐园」"
  },
  Task_120549_Desc = {
    Text = "在相位对弈中不投降的情况下战斗到最后 100 场"
  },
  Task_120850_Desc = {
    Text = "只使用血肉界域唤醒体通关 1 次「幻梦深潜」"
  },
  Task_120851_Desc = {
    Text = "使用混沌界域与超维界域唤醒体通关 1 次「幻梦深潜」"
  },
  Task_120852_Desc = {
    Text = "只使用混沌界域唤醒体通关 1 次「幻梦深潜」"
  },
  Task_120855_Desc = {
    Text = "「幻梦深潜」最高积分达到 1000"
  },
  Task_120856_Desc = {
    Text = "使用混沌界域与血肉界域唤醒体通关 1 次「幻梦深潜」"
  },
  Task_120857_Desc = {
    Text = "只使用混沌唤醒体完成 5 次难度VI及以上的「幻梦深潜」"
  },
  Task_120862_Desc = {
    Text = "只使用血肉唤醒体完成 5 次难度VI及以上的「幻梦深潜」"
  },
  Task_120863_Desc = {
    Text = "使用混沌与深海唤醒体完成 5 次难度VI及以上的「幻梦深潜」"
  },
  Task_120864_Desc = {
    Text = "使用混沌与超维唤醒体完成 5 次难度VI及以上的「幻梦深潜」"
  },
  Task_120865_Desc = {
    Text = "使用深海界域与超维界域唤醒体通关 1 次「幻梦深潜」"
  },
  Task_120867_Desc = {
    Text = "使用深海与血肉唤醒体完成 5 次难度VI及以上的「幻梦深潜」"
  },
  Task_120868_Desc = {
    Text = "噩梦之下"
  },
  Task_120869_Desc = {
    Text = "只使用超维唤醒体完成 5 次难度VI及以上的「幻梦深潜」"
  },
  Task_120870_Desc = {
    Text = "使用混沌与血肉唤醒体完成 5 次难度VI及以上的「幻梦深潜」"
  },
  Task_120871_Desc = {
    Text = "「幻梦深潜」最高积分达到 7000"
  },
  Task_120872_Desc = {
    Text = "只使用深海界域唤醒体通关 1 次「幻梦深潜」"
  },
  Task_120873_Desc = {
    Text = "只使用深海唤醒体完成 5 次难度VI及以上的「幻梦深潜」"
  },
  Task_120876_Desc = {
    Text = "界海巡游"
  },
  Task_120878_Desc = {
    Text = "「幻梦深潜」最高积分达到 6000"
  },
  Task_120879_Desc = {
    Text = "使用深海与超维唤醒体完成 5 次难度VI及以上的「幻梦深潜」"
  },
  Task_120880_Desc = {
    Text = "在「幻梦深潜」的「排行榜」处观看 1 次回放"
  },
  Task_120882_Desc = {
    Text = "只使用超维界域唤醒体通关 1 次「幻梦深潜」"
  },
  Task_120883_Desc = {
    Text = "使用混沌界域与深海界域唤醒体通关 1 次「幻梦深潜」"
  },
  Task_120884_Desc = {
    Text = "使用血肉与超维唤醒体完成 5 次难度VI及以上的「幻梦深潜」"
  },
  Task_120885_Desc = {
    Text = "初入梦海"
  },
  Task_120889_Desc = {
    Text = "「幻梦深潜」最高积分达到 5000"
  },
  Task_120890_Desc = {
    Text = "通关 1 次「幻梦深潜」"
  },
  Task_120891_Desc = {
    Text = "在「幻梦深潜」的「排行榜」处复制 1 次阵容"
  },
  Task_120892_Desc = {
    Text = "「幻梦深潜」最高积分达到 2000"
  },
  Task_120894_Desc = {
    Text = "「幻梦深潜」最高积分达到 4000"
  },
  Task_120895_Desc = {
    Text = "「幻梦深潜」最高积分达到 3000"
  },
  Task_120966_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_120966_Name = {Text = "3胜"},
  Task_120967_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_120967_Name = {Text = "6胜"},
  Task_120968_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_120968_Name = {Text = "10胜"},
  Task_120969_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_120969_Name = {Text = "1胜"},
  Task_120994_Desc = {
    Text = "消灭「再战原初·失谐序曲」所有分身"
  },
  Task_120994_Name = {
    Text = "击杀BOSS1"
  },
  Task_120995_Desc = {
    Text = "消灭「再战原初·倒错和声」所有分身"
  },
  Task_120995_Name = {
    Text = "击杀BOSS4"
  },
  Task_120996_Name = {
    Text = "世界BOSS活动结束"
  },
  Task_120997_Desc = {
    Text = "消灭「再战原初·永恒沉眠」所有分身"
  },
  Task_120997_Name = {
    Text = "击杀BOSS7"
  },
  Task_120998_Desc = {
    Text = "消灭「再战原初·死寂韵律」所有分身"
  },
  Task_120998_Name = {
    Text = "击杀BOSS3"
  },
  Task_120999_Desc = {
    Text = "消灭「再战原初·邪信奏音」所有分身"
  },
  Task_120999_Name = {
    Text = "击杀BOSS5"
  },
  Task_121000_Desc = {
    Text = "消灭「再战原初·癫狂尾章」所有分身"
  },
  Task_121000_Name = {
    Text = "击杀BOSS6"
  },
  Task_121001_Desc = {
    Text = "消灭「再战原初·无序前奏」所有分身"
  },
  Task_121001_Name = {
    Text = "击杀BOSS2"
  },
  Task_121033_Desc = {
    Text = "累计唤醒 30 次"
  },
  Task_121035_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_121040_Desc = {
    Text = "完成 4 次每日试训"
  },
  Task_121041_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_121042_Desc = {
    Text = "消耗灵啡肽 1500 点"
  },
  Task_121044_Desc = {
    Text = "通关超验存在 1 次"
  },
  Task_121045_Desc = {
    Text = "累计登录 1 天"
  },
  Task_121046_Desc = {
    Text = "通关 1 次茉夏试玩关卡"
  },
  Task_121047_Desc = {
    Text = "累计唤醒 30 次"
  },
  Task_121050_Desc = {
    Text = "消耗灵啡肽 1500 点"
  },
  Task_121051_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_121053_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_121054_Desc = {
    Text = "完成 4 次每日试训"
  },
  Task_121058_Desc = {
    Text = "通关超验存在 1 次"
  },
  Task_121061_Desc = {
    Text = "累计登录 1 天"
  },
  Task_121062_Desc = {
    Text = "通关 1 次茉夏试玩关卡"
  },
  Task_121206_Desc = {
    Text = "累计提取 76000 源液"
  },
  Task_121207_Desc = {
    Text = "累计提取 84000 源液"
  },
  Task_121208_Desc = {
    Text = "累计提取 92000 源液"
  },
  Task_121233_Desc = {
    Text = "在「虔诚之握Ⅳ」中获得三星评分"
  },
  Task_121234_Desc = {
    Text = "在「蜡像之秘Ⅱ」中获得三星评分"
  },
  Task_121235_Desc = {
    Text = "在「器质残像Ⅲ」中获得三星评分"
  },
  Task_121236_Desc = {
    Text = "在「玩偶之泪Ⅴ」中获得三星评分"
  },
  Task_121237_Desc = {
    Text = "在「蜡像之秘Ⅲ」中获得三星评分"
  },
  Task_121238_Desc = {
    Text = "在「金券搜查Ⅰ」中获得三星评分"
  },
  Task_121239_Desc = {
    Text = "在「界外之影Ⅳ」中获得三星评分"
  },
  Task_121240_Desc = {
    Text = "在「混沌集群Ⅳ」中获得三星评分"
  },
  Task_121241_Desc = {
    Text = "在「圣胎之咏Ⅱ」中获得三星评分"
  },
  Task_121242_Desc = {
    Text = "在「暗海之舟Ⅲ」中获得三星评分"
  },
  Task_121243_Desc = {
    Text = "在「漆黑之链Ⅲ」中获得三星评分"
  },
  Task_121244_Desc = {
    Text = "在「海渊残像Ⅴ」中获得三星评分"
  },
  Task_121245_Desc = {
    Text = "在「维度残像Ⅰ」中获得三星评分"
  },
  Task_121246_Desc = {
    Text = "在「失序山脉Ⅱ」中获得三星评分"
  },
  Task_121247_Desc = {
    Text = "在「怪雾之都Ⅱ」中获得三星评分"
  },
  Task_121248_Desc = {
    Text = "在「波纳佩之墟Ⅱ」中获得三星评分"
  },
  Task_121249_Desc = {
    Text = "在「器质残像Ⅱ」中获得三星评分"
  },
  Task_121250_Desc = {
    Text = "在「失序山脉Ⅰ」中获得三星评分"
  },
  Task_121251_Desc = {
    Text = "在「维度残像Ⅱ」中获得三星评分"
  },
  Task_121252_Desc = {
    Text = "在「浑浊残像Ⅳ」中获得三星评分"
  },
  Task_121253_Desc = {
    Text = "在「狂躁蜡馆Ⅱ」中获得三星评分"
  },
  Task_121254_Desc = {
    Text = "在「虔诚之握Ⅰ」中获得三星评分"
  },
  Task_121255_Desc = {
    Text = "在「混沌集群Ⅰ」中获得三星评分"
  },
  Task_121256_Desc = {
    Text = "在「蜡像之秘Ⅳ」中获得三星评分"
  },
  Task_121257_Desc = {
    Text = "在「蠕虫之所Ⅰ」中获得三星评分"
  },
  Task_121258_Desc = {
    Text = "在「荒沙之壁Ⅰ」中获得三星评分"
  },
  Task_121259_Desc = {
    Text = "在「玩偶之泪Ⅱ」中获得三星评分"
  },
  Task_121260_Desc = {
    Text = "在「虔诚之握Ⅲ」中获得三星评分"
  },
  Task_121261_Desc = {
    Text = "在「界外之影Ⅲ」中获得三星评分"
  },
  Task_121262_Desc = {
    Text = "在「沙海遗存Ⅲ」中获得三星评分"
  },
  Task_121263_Desc = {
    Text = "在「混沌集群Ⅱ」中获得三星评分"
  },
  Task_121264_Desc = {
    Text = "在「错乱异镇Ⅰ」中获得三星评分"
  },
  Task_121265_Desc = {
    Text = "在「海渊残像Ⅰ」中获得三星评分"
  },
  Task_121266_Desc = {
    Text = "在「沙海遗存Ⅰ」中获得三星评分"
  },
  Task_121267_Desc = {
    Text = "在「狂躁蜡馆Ⅲ」中获得三星评分"
  },
  Task_121268_Desc = {
    Text = "在「海渊残像Ⅳ」中获得三星评分"
  },
  Task_121269_Desc = {
    Text = "在「史瓦西喉Ⅳ」中获得三星评分"
  },
  Task_121270_Desc = {
    Text = "在「维度残像Ⅲ」中获得三星评分"
  },
  Task_121271_Desc = {
    Text = "在「金券搜查Ⅳ」中获得三星评分"
  },
  Task_121272_Desc = {
    Text = "在「海渊残像Ⅲ」中获得三星评分"
  },
  Task_121273_Desc = {
    Text = "在「制剂淬炼Ⅰ」中获得三星评分"
  },
  Task_121274_Desc = {
    Text = "在「蜡像之秘Ⅴ」中获得三星评分"
  },
  Task_121275_Desc = {
    Text = "在「沙海遗存Ⅱ」中获得三星评分"
  },
  Task_121276_Desc = {
    Text = "在「狂躁蜡馆Ⅰ」中获得三星评分"
  },
  Task_121277_Desc = {
    Text = "在「失序山脉Ⅲ」中获得三星评分"
  },
  Task_121278_Desc = {
    Text = "在「制剂淬炼Ⅳ」中获得三星评分"
  },
  Task_121279_Desc = {
    Text = "在「玩偶之泪Ⅲ」中获得三星评分"
  },
  Task_121280_Desc = {
    Text = "在「器质残像Ⅴ」中获得三星评分"
  },
  Task_121281_Desc = {
    Text = "在「暗海之舟Ⅰ」中获得三星评分"
  },
  Task_121282_Desc = {
    Text = "在「黑池之潮Ⅱ」中获得三星评分"
  },
  Task_121283_Desc = {
    Text = "在「浑浊残像Ⅲ」中获得三星评分"
  },
  Task_121284_Desc = {
    Text = "在「虔诚之握Ⅱ」中获得三星评分"
  },
  Task_121285_Desc = {
    Text = "在「风暴外海Ⅰ」中获得三星评分"
  },
  Task_121286_Desc = {
    Text = "在「蜡像之秘Ⅰ」中获得三星评分"
  },
  Task_121287_Desc = {
    Text = "在「波纳佩之墟Ⅲ」中获得三星评分"
  },
  Task_121288_Desc = {
    Text = "在「圣胎之咏Ⅲ」中获得三星评分"
  },
  Task_121289_Desc = {
    Text = "在「器质残像Ⅳ」中获得三星评分"
  },
  Task_121290_Desc = {
    Text = "在「器质残像Ⅰ」中获得三星评分"
  },
  Task_121291_Desc = {
    Text = "在「界外之影Ⅱ」中获得三星评分"
  },
  Task_121292_Desc = {
    Text = "在「圣胎之咏Ⅰ」中获得三星评分"
  },
  Task_121293_Desc = {
    Text = "在「史瓦西喉Ⅲ」中获得三星评分"
  },
  Task_121294_Desc = {
    Text = "在「界外之影Ⅰ」中获得三星评分"
  },
  Task_121295_Desc = {
    Text = "在「金券搜查Ⅱ」中获得三星评分"
  },
  Task_121296_Desc = {
    Text = "在「制剂淬炼Ⅴ」中获得三星评分"
  },
  Task_121297_Desc = {
    Text = "在「错乱异镇Ⅱ」中获得三星评分"
  },
  Task_121298_Desc = {
    Text = "在「制剂淬炼Ⅱ」中获得三星评分"
  },
  Task_121299_Desc = {
    Text = "在「史瓦西喉Ⅱ」中获得三星评分"
  },
  Task_121300_Desc = {
    Text = "在「金券搜查Ⅴ」中获得三星评分"
  },
  Task_121301_Desc = {
    Text = "在「怪雾之都Ⅲ」中获得三星评分"
  },
  Task_121302_Desc = {
    Text = "在「制剂淬炼Ⅲ」中获得三星评分"
  },
  Task_121303_Desc = {
    Text = "在「波纳佩之墟Ⅳ」中获得三星评分"
  },
  Task_121304_Desc = {
    Text = "在「混沌集群Ⅲ」中获得三星评分"
  },
  Task_121305_Desc = {
    Text = "在「怪雾之都Ⅰ」中获得三星评分"
  },
  Task_121306_Desc = {
    Text = "在「蠕虫之所Ⅲ」中获得三星评分"
  },
  Task_121307_Desc = {
    Text = "在「海渊残像Ⅱ」中获得三星评分"
  },
  Task_121308_Desc = {
    Text = "在「蠕虫之所Ⅳ」中获得三星评分"
  },
  Task_121309_Desc = {
    Text = "在「波纳佩之墟Ⅰ」中获得三星评分"
  },
  Task_121310_Desc = {
    Text = "在「浑浊残像Ⅱ」中获得三星评分"
  },
  Task_121311_Desc = {
    Text = "在「维度残像Ⅴ」中获得三星评分"
  },
  Task_121312_Desc = {
    Text = "在「蠕虫之所Ⅱ」中获得三星评分"
  },
  Task_121313_Desc = {
    Text = "在「漆黑之链Ⅱ」中获得三星评分"
  },
  Task_121314_Desc = {
    Text = "在「维度残像Ⅳ」中获得三星评分"
  },
  Task_121315_Desc = {
    Text = "在「浑浊残像Ⅴ」中获得三星评分"
  },
  Task_121316_Desc = {
    Text = "在「漆黑之链Ⅳ」中获得三星评分"
  },
  Task_121317_Desc = {
    Text = "在「漆黑之链Ⅰ」中获得三星评分"
  },
  Task_121318_Desc = {
    Text = "在「错乱异镇Ⅲ」中获得三星评分"
  },
  Task_121319_Desc = {
    Text = "在「玩偶之泪Ⅰ」中获得三星评分"
  },
  Task_121320_Desc = {
    Text = "在「暗海之舟Ⅱ」中获得三星评分"
  },
  Task_121321_Desc = {
    Text = "在「金券搜查Ⅲ」中获得三星评分"
  },
  Task_121322_Desc = {
    Text = "在「漆黑之链Ⅴ」中获得三星评分"
  },
  Task_121323_Desc = {
    Text = "在「玩偶之泪Ⅳ」中获得三星评分"
  },
  Task_121324_Desc = {
    Text = "在「黑池之潮Ⅰ」中获得三星评分"
  },
  Task_121325_Desc = {
    Text = "在「浑浊残像Ⅰ」中获得三星评分"
  },
  Task_121326_Desc = {
    Text = "在「史瓦西喉Ⅰ」中获得三星评分"
  },
  Task_121327_Desc = {
    Text = "在「原初裂隙Ⅰ」中获得三星评分"
  },
  Task_121331_Desc = {
    Text = "完成「初入梦海」全部任务"
  },
  Task_121332_Desc = {
    Text = "使用深海界域与血肉界域唤醒体通关 1 次「幻梦深潜」"
  },
  Task_121333_Desc = {
    Text = "使用血肉界域与超维界域唤醒体通关 1 次「幻梦深潜」"
  },
  Task_121834_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_121834_Name = {
    Text = "完美通过"
  },
  Task_121835_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_121835_Name = {
    Text = "完美通过"
  },
  Task_121836_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_121836_Name = {
    Text = "完美通过"
  },
  Task_121837_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_121837_Name = {
    Text = "完美通过"
  },
  Task_121838_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_121838_Name = {
    Text = "完美通过"
  },
  Task_121839_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_121839_Name = {
    Text = "完美通过"
  },
  Task_121840_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_121840_Name = {
    Text = "完美通过"
  },
  Task_121841_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_121841_Name = {
    Text = "完美通过"
  },
  Task_121842_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_121842_Name = {
    Text = "完美通过"
  },
  Task_121843_Desc = {
    Text = "承受所有圣象诅咒，且 15 回合内击败「乐园投影」。"
  },
  Task_121843_Name = {
    Text = "乐园的坍塌·隐藏"
  },
  Task_121844_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_121844_Name = {
    Text = "完美通过"
  },
  Task_121897_Desc = {
    Text = "每剩余 1 回合额外获得 20 分。（当前剩余回合：{s1}）"
  },
  Task_121897_Name = {
    Text = "时序沙漏<size=20><color=#747474>初始回合为 50，每剩余 1 回合额外获得 20 分。</color></size>"
  },
  Task_122110_Desc = {
    Text = "每日首次游玩 获得 500 分。"
  },
  Task_122110_Name = {
    Text = "拓梦先驱<size=20><color=#747474>每日首次游玩 获得 500 分 </color></size>"
  },
  Task_122197_Desc = {
    Text = "使用混沌界域唤醒体在「迷失的自我」中获胜1次"
  },
  Task_122198_Desc = {
    Text = "通关「支配四肢」癫狂难度"
  },
  Task_122199_Desc = {
    Text = "通关「敲碎心脏」癫狂难度"
  },
  Task_122200_Desc = {
    Text = "通关「切割阑尾」任意难度"
  },
  Task_122201_Desc = {
    Text = "通关「控制言语」任意难度"
  },
  Task_122202_Desc = {
    Text = "通关「本能思考」任意难度"
  },
  Task_122203_Desc = {
    Text = "通关「真我的解放」癫狂难度"
  },
  Task_122204_Desc = {
    Text = "通关「蒙蔽双眼」癫狂难度"
  },
  Task_122205_Desc = {
    Text = "通关「敲碎心脏」任意难度"
  },
  Task_122206_Desc = {
    Text = "通关「控制言语」任意难度"
  },
  Task_122207_Desc = {
    Text = "通关「切割阑尾」癫狂难度"
  },
  Task_122208_Desc = {
    Text = "通关「本能思考」任意难度"
  },
  Task_122209_Desc = {
    Text = "使用超维界域唤醒体在「迷失的自我」中获胜1次"
  },
  Task_122210_Desc = {
    Text = "通关「支配四肢」任意难度"
  },
  Task_122211_Desc = {
    Text = "通关「真我的解放」任意难度"
  },
  Task_122212_Desc = {
    Text = "通关多维连接「银与血的洗礼」"
  },
  Task_122213_Desc = {
    Text = "完成「迷失的自我·通关」所有成就"
  },
  Task_122214_Desc = {
    Text = "通关「蒙蔽双眼」任意难度"
  },
  Task_122215_Desc = {
    Text = "迷失的自我·界域"
  },
  Task_122216_Desc = {
    Text = "通关「本能思考」癫狂难度"
  },
  Task_122217_Desc = {
    Text = "通关「支配四肢」任意难度"
  },
  Task_122218_Desc = {
    Text = "通关「真我的解放」任意难度"
  },
  Task_122219_Desc = {
    Text = "迷失的自我·通关"
  },
  Task_122220_Desc = {
    Text = "使用血肉界域唤醒体在「迷失的自我」中获胜2次"
  },
  Task_122221_Desc = {
    Text = "迷失的自我·癫狂"
  },
  Task_122222_Desc = {
    Text = "通关「蒙蔽双眼」任意难度"
  },
  Task_122223_Desc = {
    Text = "通关「控制言语」癫狂难度"
  },
  Task_122224_Desc = {
    Text = "通关「切割阑尾」任意难度"
  },
  Task_122225_Desc = {
    Text = "使用深海界域唤醒体在「迷失的自我」中获胜1次"
  },
  Task_122226_Desc = {
    Text = "使用深海界域唤醒体在「迷失的自我」中获胜2次"
  },
  Task_122227_Desc = {
    Text = "使用血肉界域唤醒体在「迷失的自我」中获胜1次"
  },
  Task_122228_Desc = {
    Text = "通关「敲碎心脏」任意难度"
  },
  Task_122229_Desc = {
    Text = "使用超维界域唤醒体在「迷失的自我」中获胜2次"
  },
  Task_122230_Desc = {
    Text = "使用混沌界域唤醒体在「迷失的自我」中获胜2次"
  },
  Task_122411_Desc = {
    Text = "使用 1/2 名强化唤醒体时出战时，获得 250 / 500  分。（当前出战：{s1}）"
  },
  Task_122411_Name = {
    Text = "深渊呼唤<size=20><color=#747474>使用 1/2 名强化唤醒体时出战时，获得 250 / 500 分 </color></size>"
  },
  Task_122584_Name = {
    Text = "击杀全部BOSS"
  },
  Task_122704_Desc = {
    Text = "茉夏同调率达到10 级"
  },
  Task_122808_Desc = {
    Text = "获得茉夏时启灵6"
  },
  Task_122808_Name = {
    Text = "获得茉夏时启灵6"
  },
  Task_122808_UnlockCondDesc = {
    Text = "活动@唤醒体茉夏启灵礼包2活动"
  },
  Task_122809_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_122812_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_122816_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_122819_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_122824_Desc = {
    Text = "获得茉夏时启灵2"
  },
  Task_122824_Name = {
    Text = "获得茉夏时启灵2"
  },
  Task_122824_UnlockCondDesc = {
    Text = "活动@唤醒体茉夏启灵礼包2活动"
  },
  Task_122828_Desc = {
    Text = "完成「调查行动-忘却篇-第三章」困难模式"
  },
  Task_122829_Desc = {
    Text = "完成「调查行动-忘却篇-第一章」困难模式"
  },
  Task_122830_Desc = {
    Text = "完成「调查行动-忘却篇-第六章」困难模式"
  },
  Task_122831_Desc = {
    Text = "完成「调查行动-忘却篇-第七章」困难模式"
  },
  Task_122832_Desc = {
    Text = "完成「调查行动-忘却篇-第四章」困难模式"
  },
  Task_122833_Desc = {
    Text = "完成「调查行动-忘却篇-第二章」困难模式"
  },
  Task_122834_Desc = {
    Text = "完成「调查行动-忘却篇-第五章」困难模式"
  },
  Task_123135_Desc = {
    Text = "使用混沌界域唤醒体在「魔女小店」中获胜2次"
  },
  Task_123136_Desc = {
    Text = "使用深海界域唤醒体在「魔女小店」中获胜2次"
  },
  Task_123137_Desc = {
    Text = "使用血肉界域唤醒体在「魔女小店」中获胜1次"
  },
  Task_123138_Desc = {
    Text = "使用超维界域唤醒体在「魔女小店」中获胜1次"
  },
  Task_123139_Desc = {
    Text = "使用混沌界域唤醒体在「魔女小店」中获胜1次"
  },
  Task_123140_Desc = {
    Text = "使用血肉界域唤醒体在「魔女小店」中获胜2次"
  },
  Task_123141_Desc = {
    Text = "魔女小店·界域"
  },
  Task_123142_Desc = {
    Text = "使用深海界域唤醒体在「魔女小店」中获胜1次"
  },
  Task_123143_Desc = {
    Text = "使用超维界域唤醒体在「魔女小店」中获胜2次"
  },
  Task_123288_Desc = {
    Text = "使用超维界域唤醒体在「深海凝视」中获胜2次"
  },
  Task_123289_Desc = {
    Text = "使用深海界域唤醒体在「深海凝视」中获胜2次"
  },
  Task_123290_Desc = {
    Text = "使用血肉界域唤醒体在「深海凝视」中获胜2次"
  },
  Task_123291_Desc = {
    Text = "使用混沌界域唤醒体在「深海凝视」中获胜2次"
  },
  Task_123324_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_123325_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_123326_Desc = {
    Text = "完成 4 次每日试训"
  },
  Task_123327_Desc = {
    Text = "通关超验存在 1 次"
  },
  Task_123328_Desc = {
    Text = "累计登录 1 天"
  },
  Task_123329_Desc = {
    Text = "完成 4 次每日试训"
  },
  Task_123330_Desc = {
    Text = "通关 1 次泰旖丝试玩关卡"
  },
  Task_123331_Desc = {
    Text = "消耗灵啡肽 1500 点"
  },
  Task_123332_Desc = {
    Text = "累计唤醒 30 次"
  },
  Task_123333_Desc = {
    Text = "累计登录 1 天"
  },
  Task_123334_Desc = {
    Text = "通关 1 次泰旖丝试玩关卡"
  },
  Task_123335_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_123336_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_123337_Desc = {
    Text = "消耗灵啡肽 1500 点"
  },
  Task_123338_Desc = {
    Text = "通关超验存在 1 次"
  },
  Task_123339_Desc = {
    Text = "累计唤醒 30 次"
  },
  Task_123488_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_123488_Name = {Text = "3胜"},
  Task_123489_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_123489_Name = {Text = "6胜"},
  Task_123490_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_123490_Name = {Text = "10胜"},
  Task_123491_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_123491_Name = {Text = "1胜"},
  Task_123726_Name = {
    Text = "重新通关茉夏支线关卡普通6"
  },
  Task_123878_Desc = {
    Text = "使用混沌界域唤醒体在「野兽雄心」中获胜2次"
  },
  Task_123883_Desc = {
    Text = "使用超维界域唤醒体在「野兽雄心」中获胜2次"
  },
  Task_123885_Desc = {
    Text = "使用深海界域唤醒体在「野兽雄心」中获胜2次"
  },
  Task_123887_Desc = {
    Text = "使用血肉界域唤醒体在「野兽雄心」中获胜2次"
  },
  Task_124214_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_124214_Name = {Text = "3胜"},
  Task_124215_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_124215_Name = {Text = "10胜"},
  Task_124216_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_124216_Name = {Text = "1胜"},
  Task_124217_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_124217_Name = {Text = "6胜"},
  Task_124797_Desc = {
    Text = "完成多维连接「逆转回合」"
  },
  Task_124797_Name = {
    Text = "万象逆转"
  },
  Task_124798_Desc = {
    Text = "完成多维连接「银与血的洗礼」困难难度"
  },
  Task_124798_Name = {
    Text = "未来将会到来·困难"
  },
  Task_124799_Desc = {
    Text = "完成多维连接「银与血的洗礼」"
  },
  Task_124799_Name = {
    Text = "未来将会到来"
  },
  Task_124835_Desc = {
    Text = "通关「调查行动-忘却篇-第一章」"
  },
  Task_125386_Desc = {
    Text = "通关「尸解」任意难度"
  },
  Task_125387_Desc = {
    Text = "通关「窗后影」任意难度"
  },
  Task_125388_Desc = {
    Text = "通关「吮」任意难度"
  },
  Task_125389_Desc = {
    Text = "通关「循香」癫狂难度"
  },
  Task_125390_Desc = {
    Text = "通关「臃容众」任意难度"
  },
  Task_125391_Desc = {
    Text = "使用血肉界域唤醒体在「玄女无相」中获胜1次"
  },
  Task_125392_Desc = {
    Text = "完成意识潜游「扇下夜谈」"
  },
  Task_125392_Name = {
    Text = "天惶惶，地惶惶"
  },
  Task_125393_Desc = {
    Text = "通关「循香」任意难度"
  },
  Task_125394_Desc = {
    Text = "通关「枉死」癫狂难度"
  },
  Task_125395_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_125396_Desc = {
    Text = "使用混沌界域唤醒体在「玄女无相」中获胜2次"
  },
  Task_125397_Desc = {
    Text = "通关「爱怨相生」癫狂难度"
  },
  Task_125398_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_125399_Desc = {
    Text = "通关「枉死」任意难度"
  },
  Task_125400_Desc = {
    Text = "使用混沌界域唤醒体在「玄女无相」中获胜1次"
  },
  Task_125401_Desc = {
    Text = "玄女无相·通关"
  },
  Task_125402_Desc = {
    Text = "通关「吮」任意难度"
  },
  Task_125403_Desc = {
    Text = "通关「窗后影」任意难度"
  },
  Task_125404_Desc = {
    Text = "通关「极乐」癫狂难度"
  },
  Task_125406_Desc = {
    Text = "使用深海界域唤醒体在「玄女无相」中获胜1次"
  },
  Task_125407_Desc = {
    Text = "通关「极乐」任意难度"
  },
  Task_125409_Desc = {
    Text = "通关「极乐」任意难度"
  },
  Task_125410_Desc = {
    Text = "使用血肉界域唤醒体在「玄女无相」中获胜2次"
  },
  Task_125411_Desc = {
    Text = "使用深海界域唤醒体在「玄女无相」中获胜2次"
  },
  Task_125412_Desc = {
    Text = "通关「吮」癫狂难度"
  },
  Task_125413_Desc = {
    Text = "通关「意识潜游：扇下夜谈」"
  },
  Task_125414_Desc = {
    Text = "通关「罗织」任意难度"
  },
  Task_125415_Desc = {
    Text = "徐同调率达到10 级"
  },
  Task_125416_Desc = {
    Text = "使用超维界域唤醒体在「玄女无相」中获胜2次"
  },
  Task_125417_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_125418_Desc = {
    Text = "获得徐时启灵2"
  },
  Task_125418_Name = {
    Text = "获得徐时启灵2"
  },
  Task_125418_UnlockCondDesc = {
    Text = "活动@唤醒体徐启灵礼包2活动"
  },
  Task_125419_Desc = {
    Text = "通关「爱怨相生」任意难度"
  },
  Task_125420_Desc = {
    Text = "玄女无相·界域"
  },
  Task_125421_Desc = {
    Text = "通关「窗后影」癫狂难度"
  },
  Task_125422_Desc = {
    Text = "通关「爱怨相生」任意难度"
  },
  Task_125423_Desc = {
    Text = "使用超维界域唤醒体在「玄女无相」中获胜1次"
  },
  Task_125424_Desc = {
    Text = "通关「循香」任意难度"
  },
  Task_125425_Desc = {
    Text = "通关「臃容众」癫狂难度"
  },
  Task_125426_Desc = {
    Text = "获得徐时启灵6"
  },
  Task_125426_Name = {
    Text = "获得徐时启灵6"
  },
  Task_125426_UnlockCondDesc = {
    Text = "活动@唤醒体徐启灵礼包2活动"
  },
  Task_125427_Desc = {
    Text = "通关「罗织」任意难度"
  },
  Task_125428_Desc = {
    Text = "完成「玄女无相·通关」所有成就"
  },
  Task_125429_Desc = {
    Text = "通关「尸解」任意难度"
  },
  Task_125430_Desc = {
    Text = "通关「罗织」癫狂难度"
  },
  Task_125431_Desc = {
    Text = "通关「臃容众」任意难度"
  },
  Task_125432_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_125433_Desc = {
    Text = "通关「枉死」任意难度"
  },
  Task_125434_Desc = {
    Text = "玄女无相·癫狂"
  },
  Task_125435_Desc = {
    Text = "通关「尸解」癫狂难度"
  },
  Task_125500_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_125500_Name = {Text = "6胜"},
  Task_125501_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_125501_Name = {Text = "10胜"},
  Task_125502_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_125502_Name = {Text = "1胜"},
  Task_125503_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_125503_Name = {Text = "3胜"},
  Task_125686_Desc = {
    Text = "逃离追捕"
  },
  Task_125686_Name = {Text = "目标"},
  Task_125687_Desc = {
    Text = "从伏击中存活"
  },
  Task_125687_Name = {Text = "目标"},
  Task_125688_Desc = {
    Text = "夺回莉兹的身体"
  },
  Task_125688_Name = {Text = "目标"},
  Task_125689_Desc = {
    Text = "逃离阿拉克涅的陷阱"
  },
  Task_125689_Name = {Text = "目标"},
  Task_125690_Desc = {
    Text = "解除三质体的封印"
  },
  Task_125690_Name = {Text = "目标"},
  Task_125691_Desc = {
    Text = "对抗酒馆中的敌人"
  },
  Task_125691_Name = {Text = "目标"},
  Task_125692_Desc = {
    Text = "消灭变异体"
  },
  Task_125692_Name = {Text = "目标"},
  Task_125693_Desc = {
    Text = "救下「善良」"
  },
  Task_125693_Name = {Text = "目标"},
  Task_125694_Desc = {
    Text = "保护索蕾尔"
  },
  Task_125694_Name = {Text = "目标"},
  Task_125695_Desc = {
    Text = "为「回忆」复仇"
  },
  Task_125695_Name = {Text = "目标"},
  Task_125845_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_125845_Name = {
    Text = "完美通过"
  },
  Task_125846_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_125846_Name = {
    Text = "完美通过"
  },
  Task_125847_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_125847_Name = {
    Text = "完美通过"
  },
  Task_125848_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_125848_Name = {
    Text = "完美通过"
  },
  Task_125849_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_125849_Name = {
    Text = "完美通过"
  },
  Task_125850_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_125850_Name = {
    Text = "完美通过"
  },
  Task_125851_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_125851_Name = {
    Text = "完美通过"
  },
  Task_125852_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_125852_Name = {
    Text = "完美通过"
  },
  Task_125853_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_125853_Name = {
    Text = "完美通过"
  },
  Task_125854_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_125854_Name = {
    Text = "完美通过"
  },
  Task_126276_Desc = {
    Text = "通关「请勿剧透」癫狂难度"
  },
  Task_126277_Desc = {
    Text = "木偶的舞台·癫狂"
  },
  Task_126279_Desc = {
    Text = "使用深海界域唤醒体在「木偶的舞台」中获胜1次"
  },
  Task_126280_Desc = {
    Text = "木偶的舞台·通关"
  },
  Task_126281_Desc = {
    Text = "通关「燃烧」任意难度"
  },
  Task_126282_Desc = {
    Text = "通关「请勿剧透」任意难度"
  },
  Task_126285_Desc = {
    Text = "通关「入场」任意难度"
  },
  Task_126286_Desc = {
    Text = "通关「反转，反转」任意难度"
  },
  Task_126288_Desc = {
    Text = "通关「墙壁上的枪」任意难度"
  },
  Task_126290_Desc = {
    Text = "通关「燃烧」癫狂难度"
  },
  Task_126292_Desc = {
    Text = "通关「墙壁上的枪」癫狂难度"
  },
  Task_126293_Desc = {
    Text = "通关「燃烧」任意难度"
  },
  Task_126294_Desc = {
    Text = "完成「木偶的舞台·通关」所有成就"
  },
  Task_126295_Desc = {
    Text = "使用超维界域唤醒体在「木偶的舞台」中获胜1次"
  },
  Task_126296_Desc = {
    Text = "通关「反转，反转」癫狂难度"
  },
  Task_126297_Desc = {
    Text = "通关「入场」癫狂难度"
  },
  Task_126298_Desc = {
    Text = "木偶的舞台·界域"
  },
  Task_126299_Desc = {
    Text = "使用深海界域唤醒体在「木偶的舞台」中获胜2次"
  },
  Task_126302_Desc = {
    Text = "使用混沌界域唤醒体在「木偶的舞台」中获胜2次"
  },
  Task_126303_Desc = {
    Text = "通关「入场」任意难度"
  },
  Task_126304_Desc = {
    Text = "使用血肉界域唤醒体在「木偶的舞台」中获胜2次"
  },
  Task_126305_Desc = {
    Text = "通关「请勿剧透」任意难度"
  },
  Task_126307_Desc = {
    Text = "通关「墙壁上的枪」任意难度"
  },
  Task_126309_Desc = {
    Text = "使用血肉界域唤醒体在「木偶的舞台」中获胜1次"
  },
  Task_126311_Desc = {
    Text = "使用超维界域唤醒体在「木偶的舞台」中获胜2次"
  },
  Task_126312_Desc = {
    Text = "使用混沌界域唤醒体在「木偶的舞台」中获胜1次"
  },
  Task_126313_Desc = {
    Text = "通关「反转，反转」任意难度"
  },
  Task_126385_Desc = {
    Text = "通关星辰篇第5章「织命剧场」困难难度"
  },
  Task_126386_Desc = {
    Text = "通关星辰篇第5章「织命剧场」困难难度"
  },
  Task_126387_Desc = {
    Text = "通关星辰篇第5章 5-7"
  },
  Task_126388_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_126390_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_126391_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_126392_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_126393_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_126394_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_126395_Desc = {
    Text = "通关星辰篇第5章「织命剧场」"
  },
  Task_126396_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_126397_Desc = {
    Text = "通关星辰篇第5章 5-6 困难难度"
  },
  Task_126398_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_126399_Desc = {
    Text = "通关星辰篇第5章 5-6 困难难度"
  },
  Task_126400_Desc = {
    Text = "通关星辰篇第5章 5-7"
  },
  Task_126401_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_126402_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_126403_Desc = {
    Text = "通关星辰篇第5章「织命剧场」"
  },
  Task_126493_Desc = {
    Text = "古国杂俎Ⅶ"
  },
  Task_126494_Desc = {
    Text = "古国杂俎·限时专属"
  },
  Task_126495_Desc = {
    Text = "古国杂俎Ⅴ"
  },
  Task_126496_Desc = {
    Text = "古国杂俎Ⅰ"
  },
  Task_126497_Desc = {
    Text = "古国杂俎Ⅵ"
  },
  Task_126498_Desc = {
    Text = "古国杂俎Ⅲ"
  },
  Task_126499_Desc = {
    Text = "古国杂俎Ⅳ"
  },
  Task_126500_Desc = {
    Text = "古国杂俎·免费"
  },
  Task_126501_Desc = {
    Text = "古国杂俎Ⅱ"
  },
  Task_127071_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_127071_Name = {Text = "10胜"},
  Task_127072_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_127072_Name = {Text = "3胜"},
  Task_127073_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_127073_Name = {Text = "6胜"},
  Task_127074_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_127074_Name = {Text = "1胜"},
  Task_127094_Desc = {
    Text = "奥瑞塔启灵达到人格深化12"
  },
  Task_127095_Desc = {
    Text = "本源拉蒙娜启灵达到人格深化12"
  },
  Task_127096_Desc = {
    Text = "拉蒙娜启灵达到人格深化12"
  },
  Task_127097_Desc = {
    Text = "艾继丝启灵达到人格深化12"
  },
  Task_127098_Desc = {
    Text = "萝坦启灵达到人格深化12"
  },
  Task_127099_Desc = {
    Text = "艾瑞卡启灵达到人格深化12"
  },
  Task_127100_Desc = {
    Text = "朵尔启灵达到人格深化12"
  },
  Task_127101_Desc = {
    Text = "奥吉尔启灵达到人格深化12"
  },
  Task_129511_Desc = {
    Text = "使用由 3 名血肉与 1 名超维唤醒体组成的队伍通关困难或癫狂难度"
  },
  Task_129512_Desc = {
    Text = "使用由 3 名混沌与 1 名超维唤醒体组成的队伍通关困难或癫狂难度"
  },
  Task_129513_Desc = {
    Text = "专列轨迹·困难"
  },
  Task_129513_Name = {
    Text = "专列轨迹·困难"
  },
  Task_129514_Desc = {
    Text = "完成癫狂难度第三阶段"
  },
  Task_129515_Desc = {
    Text = "使用由 1 名血肉与 3 名超维唤醒体组成的队伍通关困难或癫狂难度"
  },
  Task_129516_Desc = {
    Text = "击败任意难度下的第三阶段首领「熔毁·朵尔」"
  },
  Task_129517_Desc = {
    Text = "击败任意难度下的第三阶段首领「乐园帷幕」"
  },
  Task_129518_Desc = {
    Text = "完成「专列轨迹·困难」所有任务"
  },
  Task_129519_Desc = {
    Text = "使用由 4 名超维唤醒体组成的队伍通关任意难度"
  },
  Task_129520_Desc = {
    Text = "完成普通难度第二阶段"
  },
  Task_129521_Desc = {
    Text = "击败任意难度下的第二阶段首领「海德拉」"
  },
  Task_129522_Desc = {
    Text = "使用由 4 名血肉唤醒体组成的队伍通关任意难度"
  },
  Task_129523_Desc = {
    Text = "使用由 2 名血肉与 2 名超维唤醒体组成的队伍通关任意难度"
  },
  Task_129524_Desc = {
    Text = "使用由 3 名深海与 1 名血肉唤醒体组成的队伍通关困难或癫狂难度"
  },
  Task_129525_Desc = {
    Text = "完成普通难度第一阶段"
  },
  Task_129526_Desc = {
    Text = "使用由 2 名混沌与 2 名血肉唤醒体组成的队伍通关任意难度"
  },
  Task_129527_Desc = {
    Text = "使用由 3 名混沌与 1 名血肉唤醒体组成的队伍通关困难或癫狂难度"
  },
  Task_129528_Desc = {
    Text = "完成「沿途留影·欢愉回廊」所有任务"
  },
  Task_129529_Desc = {
    Text = "完成普通难度第三阶段"
  },
  Task_129530_Desc = {
    Text = "使用由 3 名混沌与 1 名深海唤醒体组成的队伍通关困难或癫狂难度"
  },
  Task_129531_Desc = {
    Text = "击败任意难度下的第一阶段首领「▼阿▼▼亚」"
  },
  Task_129532_Desc = {
    Text = "完成困难难度第二阶段"
  },
  Task_129533_Desc = {
    Text = "完成癫狂难度第一阶段"
  },
  Task_129534_Desc = {
    Text = "沿途留影·往昔回忆"
  },
  Task_129534_Name = {
    Text = "沿途留影·往昔回忆"
  },
  Task_129535_Desc = {
    Text = "击败任意难度下的第三阶段首领「腐潮之傀」"
  },
  Task_129536_Desc = {
    Text = "沿途留影·欢愉回廊"
  },
  Task_129536_Name = {
    Text = "沿途留影·欢愉回廊"
  },
  Task_129537_Desc = {
    Text = "击败任意难度下的第三阶段首领「超维@2之蛹」"
  },
  Task_129538_Desc = {
    Text = "使用由 2 名深海与 2 名血肉唤醒体组成的队伍通关任意难度"
  },
  Task_129539_Desc = {
    Text = "击败任意难度下的第二阶段首领「丰穰母树」"
  },
  Task_129540_Desc = {
    Text = "击败任意难度下的第一阶段首领「爱哭鬼乔▼」"
  },
  Task_129541_Desc = {
    Text = "使用由 2 名混沌与 2 名深海唤醒体组成的队伍通关任意难度"
  },
  Task_129542_Desc = {
    Text = "完成困难难度第三阶段"
  },
  Task_129543_Desc = {
    Text = "击败任意难度下的第一阶段首领「修▼▼」"
  },
  Task_129544_Desc = {
    Text = "使用由 3 名深海与 1 名超维唤醒体组成的队伍通关困难或癫狂难度"
  },
  Task_129545_Desc = {
    Text = "完成癫狂难度第二阶段"
  },
  Task_129546_Desc = {
    Text = "击败任意难度下的第一阶段首领「梭行维度之犬」"
  },
  Task_129547_Desc = {
    Text = "击败任意难度下的第二阶段首领「双生矛盾」"
  },
  Task_129548_Desc = {
    Text = "使用由 1 名深海与 3 名血肉唤醒体组成的队伍通关困难或癫狂难度"
  },
  Task_129549_Desc = {
    Text = "使用由 2 名混沌与 2 名超维唤醒体组成的队伍通关任意难度"
  },
  Task_129550_Desc = {
    Text = "完成困难难度第一阶段"
  },
  Task_129551_Desc = {
    Text = "完成「专列轨迹·普通」所有任务"
  },
  Task_129552_Desc = {
    Text = "使用由 2 名深海与 2 名超维唤醒体组成的队伍通关任意难度"
  },
  Task_129553_Desc = {
    Text = "专列轨迹·普通"
  },
  Task_129553_Name = {
    Text = "专列轨迹·普通"
  },
  Task_129554_Desc = {
    Text = "使用由 1 名混沌与 3 名血肉唤醒体组成的队伍通关困难或癫狂难度"
  },
  Task_129555_Desc = {
    Text = "使用由 1 名混沌与 3 名超维唤醒体组成的队伍通关困难或癫狂难度"
  },
  Task_129556_Desc = {
    Text = "使用由 4 名深海唤醒体组成的队伍通关任意难度"
  },
  Task_129557_Desc = {
    Text = "使用由 1 名混沌与 3 名深海唤醒体组成的队伍通关困难或癫狂难度"
  },
  Task_129558_Desc = {
    Text = "使用由 1 名深海与 3 名超维唤醒体组成的队伍通关困难或癫狂难度"
  },
  Task_129559_Desc = {
    Text = "使用由 4 名混沌唤醒体组成的队伍通关任意难度"
  },
  Task_129560_Desc = {
    Text = "完成「沿途留影·往昔回忆」所有任务"
  },
  Task_129561_Desc = {
    Text = "击败任意难度下的第二阶段首领「圣婴」"
  },
  Task_129895_Desc = {
    Text = "完成特遣纪录「开往祈岁节的列车」"
  },
  Task_129895_Name = {
    Text = "爆竹声中一岁除"
  },
  Task_130180_Desc = {
    Text = "通关多维连接「被遗忘的爱之种」"
  },
  Task_130181_Desc = {
    Text = "通关「最后的小酌」癫狂难度"
  },
  Task_130182_Desc = {
    Text = "通关「餐桌」任意难度"
  },
  Task_130183_Desc = {
    Text = "使用深海界域唤醒体在「颠倒的新生」中获胜2次"
  },
  Task_130184_Desc = {
    Text = "使用血肉界域唤醒体在「颠倒的新生」中获胜1次"
  },
  Task_130185_Desc = {
    Text = "通关「学校」任意难度"
  },
  Task_130186_Desc = {
    Text = "通关「医院」任意难度"
  },
  Task_130187_Desc = {
    Text = "通关「最后的小酌」任意难度"
  },
  Task_130188_Desc = {
    Text = "通关「医院」癫狂难度"
  },
  Task_130189_Desc = {
    Text = "使用混沌界域唤醒体在「颠倒的新生」中获胜1次"
  },
  Task_130190_Desc = {
    Text = "使用血肉界域唤醒体在「颠倒的新生」中获胜2次"
  },
  Task_130191_Desc = {
    Text = "通关「水井」癫狂难度"
  },
  Task_130192_Desc = {
    Text = "使用超维界域唤醒体在「颠倒的新生」中获胜2次"
  },
  Task_130193_Desc = {
    Text = "通关「学校」癫狂难度"
  },
  Task_130194_Desc = {
    Text = "通关「餐桌」任意难度"
  },
  Task_130195_Desc = {
    Text = "通关「家」任意难度"
  },
  Task_130196_Desc = {
    Text = "通关「最后的小酌」任意难度"
  },
  Task_130197_Desc = {
    Text = "通关「脑损伤」任意难度"
  },
  Task_130198_Desc = {
    Text = "使用深海界域唤醒体在「颠倒的新生」中获胜1次"
  },
  Task_130199_Desc = {
    Text = "通关「脑损伤」任意难度"
  },
  Task_130200_Desc = {
    Text = "通关「水井」任意难度"
  },
  Task_130201_Desc = {
    Text = "通关「家」任意难度"
  },
  Task_130202_Desc = {
    Text = "通关「学校」任意难度"
  },
  Task_130203_Desc = {
    Text = "通关「医院」任意难度"
  },
  Task_130204_Desc = {
    Text = "通关「水井」任意难度"
  },
  Task_130205_Desc = {
    Text = "颠倒的新生·癫狂"
  },
  Task_130206_Desc = {
    Text = "通关「家」癫狂难度"
  },
  Task_130207_Desc = {
    Text = "通关「脑损伤」癫狂难度"
  },
  Task_130208_Desc = {
    Text = "颠倒的新生·界域"
  },
  Task_130209_Desc = {
    Text = "完成「颠倒的新生·通关」所有成就"
  },
  Task_130210_Desc = {
    Text = "颠倒的新生·通关"
  },
  Task_130211_Desc = {
    Text = "使用超维界域唤醒体在「颠倒的新生」中获胜1次"
  },
  Task_130212_Desc = {
    Text = "通关「餐桌」癫狂难度"
  },
  Task_130213_Desc = {
    Text = "使用混沌界域唤醒体在「颠倒的新生」中获胜2次"
  },
  Task_130412_Desc = {
    Text = "获得本源奥吉尔时启灵2"
  },
  Task_130412_Name = {
    Text = "获得本源奥吉尔时启灵2"
  },
  Task_130412_UnlockCondDesc = {
    Text = "活动@唤醒体本源奥吉尔启灵礼包2活动"
  },
  Task_130413_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_130414_Desc = {
    Text = "获得沙耶时启灵2"
  },
  Task_130414_Name = {
    Text = "获得沙耶时启灵2"
  },
  Task_130414_UnlockCondDesc = {
    Text = "活动@唤醒体沙耶启灵礼包2活动"
  },
  Task_130416_Desc = {
    Text = "获得沙耶时启灵6"
  },
  Task_130416_Name = {
    Text = "获得沙耶时启灵6"
  },
  Task_130416_UnlockCondDesc = {
    Text = "活动@唤醒体沙耶启灵礼包2活动"
  },
  Task_130417_Desc = {
    Text = "获得撒托古亚时启灵2"
  },
  Task_130417_Name = {
    Text = "获得撒托古亚时启灵2"
  },
  Task_130417_UnlockCondDesc = {
    Text = "活动@唤醒体撒托古亚启灵礼包2活动"
  },
  Task_130418_Desc = {
    Text = "获得撒托古亚时启灵6"
  },
  Task_130418_Name = {
    Text = "获得撒托古亚时启灵6"
  },
  Task_130418_UnlockCondDesc = {
    Text = "活动@唤醒体撒托古亚启灵礼包2活动"
  },
  Task_130420_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_130421_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_130424_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_130425_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_130427_Desc = {
    Text = "获得本源奥吉尔时启灵6"
  },
  Task_130427_Name = {
    Text = "获得本源奥吉尔时启灵6"
  },
  Task_130427_UnlockCondDesc = {
    Text = "活动@唤醒体本源奥吉尔启灵礼包2活动"
  },
  Task_130429_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_130440_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_130441_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_130442_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_130446_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_130447_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_130448_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_130459_Desc = {
    Text = "本源奥吉尔同调率达到10 级"
  },
  Task_130460_Desc = {
    Text = "撒托古亚同调率达到10 级"
  },
  Task_130461_Desc = {
    Text = "沙耶同调率达到10 级"
  },
  Task_130555_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_130555_Name = {Text = "3胜"},
  Task_130556_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_130556_Name = {Text = "10胜"},
  Task_130557_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_130557_Name = {Text = "1胜"},
  Task_130558_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_130558_Name = {Text = "6胜"},
  Task_130950_Desc = {
    Text = "通关「大·漩·涡」癫狂难度"
  },
  Task_130951_Desc = {
    Text = "通关「平凡的每天」癫狂难度"
  },
  Task_130952_Desc = {
    Text = "通关「轰鸣的雷暴」任意难度"
  },
  Task_130953_Desc = {
    Text = "通关「同伴发现」癫狂难度"
  },
  Task_130954_Desc = {
    Text = "莫丝与海·界域"
  },
  Task_130956_Desc = {
    Text = "完成「莫丝与海·通关」所有成就"
  },
  Task_130957_Desc = {
    Text = "通关「大·漩·涡」任意难度"
  },
  Task_130958_Desc = {
    Text = "获得莫丝时启灵6"
  },
  Task_130958_Name = {
    Text = "获得莫丝时启灵6"
  },
  Task_130958_UnlockCondDesc = {
    Text = "活动@唤醒体莫丝启灵礼包2活动"
  },
  Task_130959_Desc = {
    Text = "通关「大·漩·涡」任意难度"
  },
  Task_130960_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_130961_Desc = {
    Text = "莫丝与海·通关"
  },
  Task_130962_Desc = {
    Text = "通关「返航之路」任意难度"
  },
  Task_130963_Desc = {
    Text = "通关意识潜游「沉溺」"
  },
  Task_130964_Desc = {
    Text = "使用混沌界域唤醒体在「莫丝与海」中获胜2次"
  },
  Task_130965_Desc = {
    Text = "通关「平凡的每天」任意难度"
  },
  Task_130966_Desc = {
    Text = "通关「出海时刻」任意难度"
  },
  Task_130967_Desc = {
    Text = "通关「返航之路」任意难度"
  },
  Task_130968_Desc = {
    Text = "通关「同伴发现」任意难度"
  },
  Task_130970_Desc = {
    Text = "获得莫丝时启灵2"
  },
  Task_130970_Name = {
    Text = "获得莫丝时启灵2"
  },
  Task_130970_UnlockCondDesc = {
    Text = "活动@唤醒体莫丝启灵礼包2活动"
  },
  Task_130971_Desc = {
    Text = "使用血肉界域唤醒体在「莫丝与海」中获胜1次"
  },
  Task_130972_Desc = {
    Text = "通关「轰鸣的雷暴」任意难度"
  },
  Task_130973_Desc = {
    Text = "通关「漂流的宝物」癫狂难度"
  },
  Task_130974_Desc = {
    Text = "通关「出海时刻」癫狂难度"
  },
  Task_130975_Desc = {
    Text = "莫丝同调率达到10 级"
  },
  Task_130976_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_130977_Desc = {
    Text = "通关「同伴发现」任意难度"
  },
  Task_130978_Desc = {
    Text = "使用深海界域唤醒体在「莫丝与海」中获胜1次"
  },
  Task_130979_Desc = {
    Text = "通关「轰鸣的雷暴」癫狂难度"
  },
  Task_130980_Desc = {
    Text = "使用混沌界域唤醒体在「莫丝与海」中获胜1次"
  },
  Task_130981_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_130982_Desc = {
    Text = "通关「返航之路」癫狂难度"
  },
  Task_130983_Desc = {
    Text = "使用超维界域唤醒体在「莫丝与海」中获胜2次"
  },
  Task_130984_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_130985_Desc = {
    Text = "通关「出海时刻」任意难度"
  },
  Task_130986_Desc = {
    Text = "使用深海界域唤醒体在「莫丝与海」中获胜2次"
  },
  Task_130987_Desc = {
    Text = "使用血肉界域唤醒体在「莫丝与海」中获胜2次"
  },
  Task_130988_Desc = {
    Text = "通关「漂流的宝物」任意难度"
  },
  Task_130989_Desc = {
    Text = "使用超维界域唤醒体在「莫丝与海」中获胜1次"
  },
  Task_130990_Desc = {
    Text = "通关「平凡的每天」任意难度"
  },
  Task_130991_Desc = {
    Text = "通关「漂流的宝物」任意难度"
  },
  Task_130992_Desc = {
    Text = "莫丝与海·癫狂"
  },
  Task_131106_Desc = {
    Text = "阻止涅芙蕾亚"
  },
  Task_131106_Name = {Text = "目标"},
  Task_131172_Desc = {
    Text = "共轭命途·限时专属"
  },
  Task_131371_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_131372_Desc = {
    Text = "累计唤醒 30 次"
  },
  Task_131373_Desc = {
    Text = "累计唤醒 30 次"
  },
  Task_131374_Desc = {
    Text = "消耗灵啡肽 1500 点"
  },
  Task_131375_Desc = {
    Text = "完成 1 周所有每周试炼任务"
  },
  Task_131376_Desc = {
    Text = "累计登录 1 天"
  },
  Task_131377_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_131378_Desc = {
    Text = "完成 1 周所有每周试炼任务"
  },
  Task_131379_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_131380_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_131381_Desc = {
    Text = "通关超验存在 1 次"
  },
  Task_131382_Desc = {
    Text = "消耗灵啡肽 1500 点"
  },
  Task_131383_Desc = {
    Text = "通关超验存在 1 次"
  },
  Task_131384_Desc = {
    Text = "累计登录 1 天"
  },
  Task_131385_Desc = {
    Text = "通关 1 次莱克试玩关卡"
  },
  Task_131386_Desc = {
    Text = "通关 1 次莱克试玩关卡"
  },
  Task_131450_Desc = {
    Text = "在相位对弈中击败 60 名唤醒体"
  },
  Task_131451_Desc = {
    Text = "在相位对弈中击败 36 名唤醒体"
  },
  Task_131452_Desc = {
    Text = "在预组模式，获得 10 场胜利"
  },
  Task_131453_Desc = {
    Text = "在相位对弈中出牌 740 次"
  },
  Task_131454_Desc = {
    Text = "在相位对弈中释放狂气爆发 108 次"
  },
  Task_131455_Desc = {
    Text = "在相位对弈中释放狂气爆发 192 次"
  },
  Task_131456_Desc = {
    Text = "在相位对弈中释放狂气爆发 60 次"
  },
  Task_131457_Desc = {
    Text = "在相位对弈中击败 111 名唤醒体"
  },
  Task_131458_Desc = {
    Text = "在相位对弈中出牌 300 次"
  },
  Task_131459_Desc = {
    Text = "在相位对弈中出牌 480 次"
  },
  Task_131460_Desc = {
    Text = "在相位对弈中出牌 320 次"
  },
  Task_131461_Desc = {
    Text = "在相位对弈中击败 6 名唤醒体"
  },
  Task_131462_Desc = {
    Text = "在相位对弈中击败 129 名唤醒体"
  },
  Task_131463_Desc = {
    Text = "在相位对弈中释放狂气爆发 102 次"
  },
  Task_131464_Desc = {
    Text = "在相位对弈中出牌 100 次"
  },
  Task_131465_Desc = {
    Text = "在相位对弈中释放狂气爆发 66 次"
  },
  Task_131466_Desc = {
    Text = "在相位对弈中击败 12 名唤醒体"
  },
  Task_131467_Desc = {
    Text = "在相位对弈中获得累计 45 胜场"
  },
  Task_131468_Desc = {
    Text = "在相位对弈中释放狂气爆发 54 次"
  },
  Task_131469_Desc = {
    Text = "在相位对弈中释放狂气爆发 240 次"
  },
  Task_131470_Desc = {
    Text = "在相位对弈中击败 99 名唤醒体"
  },
  Task_131471_Desc = {
    Text = "在相位对弈中击败 87 名唤醒体"
  },
  Task_131472_Desc = {
    Text = "在轮选模式，再来一局并击败对手 1 次"
  },
  Task_131473_Desc = {
    Text = "在相位对弈中击败 30 名唤醒体"
  },
  Task_131474_Desc = {
    Text = "在预组模式，连续胜利两场 1 次"
  },
  Task_131475_Desc = {
    Text = "在轮选模式，获得 2 场胜利"
  },
  Task_131476_Desc = {
    Text = "在相位对弈中释放狂气爆发 156 次"
  },
  Task_131477_Desc = {
    Text = "在轮选模式，获得 6 场胜利"
  },
  Task_131478_Desc = {
    Text = "在相位对弈中出牌 160 次"
  },
  Task_131479_Desc = {
    Text = "在相位对弈中击败 135 名唤醒体"
  },
  Task_131480_Desc = {
    Text = "在相位对弈中出牌 880 次"
  },
  Task_131481_Desc = {
    Text = "在相位对弈中释放狂气爆发 132 次"
  },
  Task_131482_Desc = {
    Text = "在相位对弈中释放狂气爆发 204 次"
  },
  Task_131483_Desc = {
    Text = "在预组模式，获得 4 场胜利"
  },
  Task_131484_Desc = {
    Text = "在相位对弈中释放狂气爆发 144 次"
  },
  Task_131485_Desc = {
    Text = "在相位对弈中出牌 240 次"
  },
  Task_131486_Desc = {
    Text = "在相位对弈中出牌 940 次"
  },
  Task_131487_Desc = {
    Text = "在相位对弈中释放狂气爆发 210 次"
  },
  Task_131488_Desc = {
    Text = "在相位对弈中释放狂气爆发 174 次"
  },
  Task_131489_Desc = {
    Text = "在相位对弈中击败 54 名唤醒体"
  },
  Task_131490_Desc = {
    Text = "在相位对弈中击败 21 名唤醒体"
  },
  Task_131491_Desc = {
    Text = "在相位对弈中出牌 180 次"
  },
  Task_131492_Desc = {
    Text = "荣勋试炼"
  },
  Task_131493_Desc = {
    Text = "在相位对弈中出牌 400 次"
  },
  Task_131494_Desc = {
    Text = "在相位对弈中击败 57 名唤醒体"
  },
  Task_131495_Desc = {
    Text = "在轮选模式，获得 8 场胜利"
  },
  Task_131496_Desc = {
    Text = "在相位对弈中击败 81 名唤醒体"
  },
  Task_131497_Desc = {
    Text = "在相位对弈中击败 93 名唤醒体"
  },
  Task_131498_Desc = {
    Text = "在相位对弈中击败 120 名唤醒体"
  },
  Task_131499_Desc = {
    Text = "在相位对弈中释放狂气爆发 30 次"
  },
  Task_131500_Desc = {
    Text = "在相位对弈中出牌 220 次"
  },
  Task_131501_Desc = {
    Text = "在相位对弈中释放狂气爆发 264 次"
  },
  Task_131502_Desc = {
    Text = "在相位对弈中击败 102 名唤醒体"
  },
  Task_131503_Desc = {
    Text = "在相位对弈中出牌 140 次"
  },
  Task_131504_Desc = {
    Text = "在相位对弈中释放狂气爆发 96 次"
  },
  Task_131505_Desc = {
    Text = "在预组模式，再来一局并击败对手 1 次"
  },
  Task_131506_Desc = {
    Text = "在相位对弈中释放狂气爆发 78 次"
  },
  Task_131507_Desc = {
    Text = "在相位对弈中出牌 1000 次"
  },
  Task_131508_Desc = {
    Text = "在相位对弈中释放狂气爆发 90 次"
  },
  Task_131509_Desc = {
    Text = "在相位对弈中击败 132 名唤醒体"
  },
  Task_131510_Desc = {
    Text = "在相位对弈中击败 126 名唤醒体"
  },
  Task_131511_Desc = {
    Text = "在相位对弈中击败 9 名唤醒体"
  },
  Task_131512_Desc = {
    Text = "在相位对弈中释放狂气爆发 168 次"
  },
  Task_131513_Desc = {
    Text = "在相位对弈中释放狂气爆发 162 次"
  },
  Task_131514_Desc = {
    Text = "在相位对弈中释放狂气爆发 222 次"
  },
  Task_131515_Desc = {
    Text = "阈限试炼"
  },
  Task_131516_Desc = {
    Text = "在相位对弈中出牌 380 次"
  },
  Task_131517_Desc = {
    Text = "在相位对弈中出牌 660 次"
  },
  Task_131518_Desc = {
    Text = "在相位对弈中释放狂气爆发 114 次"
  },
  Task_131519_Desc = {
    Text = "在相位对弈中释放狂气爆发 120 次"
  },
  Task_131520_Desc = {
    Text = "在相位对弈中击败 144 名唤醒体"
  },
  Task_131521_Desc = {
    Text = "在相位对弈中击败 24 名唤醒体"
  },
  Task_131522_Desc = {
    Text = "在相位对弈中击败 42 名唤醒体"
  },
  Task_131523_Desc = {
    Text = "在相位对弈中出牌 460 次"
  },
  Task_131524_Desc = {
    Text = "在相位对弈中释放狂气爆发 180 次"
  },
  Task_131525_Desc = {
    Text = "在相位对弈中出牌 520 次"
  },
  Task_131526_Desc = {
    Text = "在相位对弈中出牌 840 次"
  },
  Task_131527_Desc = {
    Text = "在相位对弈中击败 69 名唤醒体"
  },
  Task_131528_Desc = {
    Text = "在相位对弈中出牌 720 次"
  },
  Task_131529_Desc = {
    Text = "在相位对弈中击败 33 名唤醒体"
  },
  Task_131530_Desc = {
    Text = "在相位对弈中击败 39 名唤醒体"
  },
  Task_131531_Desc = {
    Text = "在相位对弈中出牌 860 次"
  },
  Task_131532_Desc = {
    Text = "在相位对弈中出牌 560 次"
  },
  Task_131533_Desc = {
    Text = "在相位对弈中出牌 600 次"
  },
  Task_131534_Desc = {
    Text = "在相位对弈中点击头像给 3 名对手发送任意表情"
  },
  Task_131535_Desc = {
    Text = "在相位对弈中击败 66 名唤醒体"
  },
  Task_131536_Desc = {
    Text = "在相位对弈中出牌 200 次"
  },
  Task_131537_Desc = {
    Text = "在轮选模式，获得 1 场胜利"
  },
  Task_131538_Desc = {
    Text = "在相位对弈中释放狂气爆发 234 次"
  },
  Task_131539_Desc = {
    Text = "在相位对弈中出牌 820 次"
  },
  Task_131540_Desc = {
    Text = "在相位对弈中释放狂气爆发 18 次"
  },
  Task_131541_Desc = {
    Text = "在相位对弈中击败 63 名唤醒体"
  },
  Task_131542_Desc = {
    Text = "在相位对弈中释放狂气爆发 258 次"
  },
  Task_131543_Desc = {
    Text = "相位对弈对战结束后点赞对手 1 次"
  },
  Task_131544_Desc = {
    Text = "在相位对弈中获得累计 25 胜场"
  },
  Task_131545_Desc = {
    Text = "在相位对弈中击败 27 名唤醒体"
  },
  Task_131546_Desc = {
    Text = "在相位对弈中击败 18 名唤醒体"
  },
  Task_131547_Desc = {
    Text = "在相位对弈中击败 150 名唤醒体"
  },
  Task_131548_Desc = {
    Text = "在相位对弈中释放狂气爆发 48 次"
  },
  Task_131549_Desc = {
    Text = "在相位对弈中出牌 20 次"
  },
  Task_131550_Desc = {
    Text = "在相位对弈中释放狂气爆发 36 次"
  },
  Task_131551_Desc = {
    Text = "在相位对弈中击败 15 名唤醒体"
  },
  Task_131552_Desc = {
    Text = "在相位对弈中击败 84 名唤醒体"
  },
  Task_131553_Desc = {
    Text = "在相位对弈中出牌 280 次"
  },
  Task_131554_Desc = {
    Text = "在相位对弈中释放狂气爆发 72 次"
  },
  Task_131555_Desc = {
    Text = "在相位对弈中击败 108 名唤醒体"
  },
  Task_131556_Desc = {
    Text = "在相位对弈中释放狂气爆发 246 次"
  },
  Task_131557_Desc = {
    Text = "在相位对弈中出牌 700 次"
  },
  Task_131558_Desc = {
    Text = "在相位对弈中获得累计 35 胜场"
  },
  Task_131559_Desc = {
    Text = "在相位对弈中获得累计 50 胜场"
  },
  Task_131560_Desc = {
    Text = "在相位对弈中击败 3 名唤醒体"
  },
  Task_131561_Desc = {
    Text = "在相位对弈中击败 75 名唤醒体"
  },
  Task_131562_Desc = {
    Text = "在相位对弈中击败 51 名唤醒体"
  },
  Task_131563_Desc = {
    Text = "在相位对弈中出牌 120 次"
  },
  Task_131564_Desc = {
    Text = "在相位对弈中击败 78 名唤醒体"
  },
  Task_131565_Desc = {
    Text = "在相位对弈中击败 138 名唤醒体"
  },
  Task_131566_Desc = {
    Text = "在相位对弈中击败 90 名唤醒体"
  },
  Task_131567_Desc = {
    Text = "秘仪试炼"
  },
  Task_131568_Desc = {
    Text = "在预组模式，获得 6 场胜利"
  },
  Task_131569_Desc = {
    Text = "在预组模式，获得 8 场胜利"
  },
  Task_131570_Desc = {
    Text = "在相位对弈中击败 117 名唤醒体"
  },
  Task_131571_Desc = {
    Text = "在相位对弈中获得累计 40 胜场"
  },
  Task_131572_Desc = {
    Text = "在相位对弈中释放狂气爆发 126 次"
  },
  Task_131573_Desc = {
    Text = "在相位对弈中出牌 760 次"
  },
  Task_131574_Desc = {
    Text = "在相位对弈中释放狂气爆发 270 次"
  },
  Task_131575_Desc = {
    Text = "在预组模式，获得 1 场胜利"
  },
  Task_131576_Desc = {
    Text = "在相位对弈中释放狂气爆发 84 次"
  },
  Task_131577_Desc = {
    Text = "在相位对弈中释放狂气爆发 294 次"
  },
  Task_131578_Desc = {
    Text = "在相位对弈中获得累计 30 胜场"
  },
  Task_131579_Desc = {
    Text = "在相位对弈中出牌 960 次"
  },
  Task_131580_Desc = {
    Text = "在相位对弈中出牌 260 次"
  },
  Task_131581_Desc = {
    Text = "在相位对弈中释放狂气爆发 42 次"
  },
  Task_131582_Desc = {
    Text = "在相位对弈中击败 96 名唤醒体"
  },
  Task_131583_Desc = {
    Text = "在相位对弈中释放狂气爆发 228 次"
  },
  Task_131584_Desc = {
    Text = "在相位对弈中出牌 40 次"
  },
  Task_131585_Desc = {
    Text = "在相位对弈中出牌 800 次"
  },
  Task_131586_Desc = {
    Text = "在相位对弈中出牌 580 次"
  },
  Task_131587_Desc = {
    Text = "在相位对弈中释放狂气爆发 150 次"
  },
  Task_131588_Desc = {
    Text = "在相位对弈中击败 114 名唤醒体"
  },
  Task_131589_Desc = {
    Text = "在相位对弈中出牌 780 次"
  },
  Task_131590_Desc = {
    Text = "在相位对弈中释放狂气爆发 24 次"
  },
  Task_131591_Desc = {
    Text = "在相位对弈中释放狂气爆发 216 次"
  },
  Task_131592_Desc = {
    Text = "在相位对弈中释放狂气爆发 276 次"
  },
  Task_131593_Desc = {
    Text = "在相位对弈中出牌 500 次"
  },
  Task_131594_Desc = {
    Text = "在相位对弈中击败 147 名唤醒体"
  },
  Task_131595_Desc = {
    Text = "在预组模式，获得 2 场胜利"
  },
  Task_131596_Desc = {
    Text = "在相位对弈中击败 72 名唤醒体"
  },
  Task_131597_Desc = {
    Text = "在相位对弈中出牌 640 次"
  },
  Task_131598_Desc = {
    Text = "在相位对弈中击败 105 名唤醒体"
  },
  Task_131599_Desc = {
    Text = "在相位对弈中释放狂气爆发 300 次"
  },
  Task_131600_Desc = {
    Text = "在相位对弈中击败 48 名唤醒体"
  },
  Task_131601_Desc = {
    Text = "在相位对弈中出牌 920 次"
  },
  Task_131602_Desc = {
    Text = "在相位对弈中出牌 60 次"
  },
  Task_131603_Desc = {
    Text = "在相位对弈中出牌 360 次"
  },
  Task_131604_Desc = {
    Text = "在相位对弈中释放狂气爆发 282 次"
  },
  Task_131605_Desc = {
    Text = "在相位对弈中出牌 440 次"
  },
  Task_131606_Desc = {
    Text = "在相位对弈中击败 123 名唤醒体"
  },
  Task_131607_Desc = {
    Text = "在相位对弈中释放狂气爆发 198 次"
  },
  Task_131608_Desc = {
    Text = "在相位对弈中出牌 680 次"
  },
  Task_131609_Desc = {
    Text = "在相位对弈中击败 45 名唤醒体"
  },
  Task_131610_Desc = {
    Text = "在轮选模式，连续胜利两场 2 次"
  },
  Task_131611_Desc = {
    Text = "在相位对弈中释放狂气爆发 186 次"
  },
  Task_131612_Desc = {
    Text = "在相位对弈中释放狂气爆发 6 次"
  },
  Task_131613_Desc = {
    Text = "在相位对弈中出牌 620 次"
  },
  Task_131614_Desc = {
    Text = "在轮选模式，连续胜利两场 1 次"
  },
  Task_131615_Desc = {
    Text = "在相位对弈中出牌 900 次"
  },
  Task_131616_Desc = {
    Text = "在相位对弈中释放狂气爆发 252 次"
  },
  Task_131617_Desc = {
    Text = "在相位对弈中出牌 980 次"
  },
  Task_131618_Desc = {
    Text = "在相位对弈中击败 141 名唤醒体"
  },
  Task_131619_Desc = {
    Text = "在相位对弈中释放狂气爆发 288 次"
  },
  Task_131620_Desc = {
    Text = "在相位对弈中出牌 420 次"
  },
  Task_131621_Desc = {
    Text = "在轮选模式，获得 10 场胜利"
  },
  Task_131622_Desc = {
    Text = "在相位对弈中出牌 340 次"
  },
  Task_131623_Desc = {
    Text = "在轮选模式，获得 4 场胜利"
  },
  Task_131624_Desc = {
    Text = "在相位对弈中出牌 80 次"
  },
  Task_131625_Desc = {
    Text = "在预组模式，连续胜利两场 2 次"
  },
  Task_131626_Desc = {
    Text = "在相位对弈中出牌 540 次"
  },
  Task_131627_Desc = {
    Text = "在相位对弈中释放狂气爆发 138 次"
  },
  Task_131628_Desc = {
    Text = "在相位对弈中释放狂气爆发 12 次"
  },
  Task_131768_Desc = {
    Text = "完成意识潜游「沉溺」"
  },
  Task_131768_Name = {Text = "唧！"},
  Task_131801_Name = {
    Text = "逆转回合复刻活动结束"
  },
  Task_131891_Desc = {
    Text = "永恒的记忆·限时专属"
  },
  Task_131892_Desc = {
    Text = "永恒的记忆Ⅴ"
  },
  Task_131893_Desc = {
    Text = "永恒的记忆Ⅶ"
  },
  Task_131894_Desc = {
    Text = "永恒的记忆Ⅱ"
  },
  Task_131895_Desc = {
    Text = "永恒的记忆Ⅰ"
  },
  Task_131896_Desc = {
    Text = "永恒的记忆·免费"
  },
  Task_131897_Desc = {
    Text = "永恒的记忆Ⅲ"
  },
  Task_131898_Desc = {
    Text = "永恒的记忆Ⅳ"
  },
  Task_131899_Desc = {
    Text = "永恒的记忆Ⅵ"
  },
  Task_132335_Desc = {
    Text = "通关意识潜游「加冕之日」"
  },
  Task_132454_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_132454_Name = {Text = "10胜"},
  Task_132455_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_132455_Name = {Text = "3胜"},
  Task_132456_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_132456_Name = {Text = "6胜"},
  Task_132457_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_132457_Name = {Text = "1胜"},
  Task_132689_Desc = {
    Text = "使用PC设备登录"
  },
  Task_132690_Desc = {
    Text = "使用移动设备提取 1 次源液"
  },
  Task_132691_Desc = {
    Text = "使用PC设备提取 1 次源液"
  },
  Task_132692_Desc = {
    Text = "使用移动设备登录"
  },
  Task_132874_Desc = {
    Text = "本赛季击败第三阶段首领 1 次"
  },
  Task_132875_Desc = {
    Text = "本赛季胜利 5 次"
  },
  Task_132876_Desc = {
    Text = "本赛季胜利 5 次"
  },
  Task_132877_Desc = {
    Text = "本赛季通关 3 次「幻梦深潜」"
  },
  Task_132909_Desc = {
    Text = "通关 1 次阿拉克涅试玩关卡"
  },
  Task_132910_Desc = {
    Text = "完成 15 次派遣"
  },
  Task_132911_Desc = {
    Text = "完成任意一个赛季任务"
  },
  Task_132912_Desc = {
    Text = "累计打出300张牌"
  },
  Task_132913_Desc = {
    Text = "完成任意一个赛季任务"
  },
  Task_132914_Desc = {
    Text = "唤醒 30 次"
  },
  Task_132915_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_132916_Desc = {
    Text = "通关 1 次阿拉克涅试玩关卡"
  },
  Task_132917_Desc = {
    Text = "完成 15 次派遣"
  },
  Task_132918_Desc = {
    Text = "累计登录1天"
  },
  Task_132919_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_132920_Desc = {
    Text = "周活跃度达到1000"
  },
  Task_132921_Desc = {
    Text = "周活跃度达到1000"
  },
  Task_132922_Desc = {
    Text = "累计打出300张牌"
  },
  Task_132923_Desc = {
    Text = "累计登录1天"
  },
  Task_132924_Desc = {
    Text = "唤醒 30 次"
  },
  Task_132928_Desc = {
    Text = "完成以上全部任务"
  },
  Task_132929_Desc = {
    Text = "消耗灵啡肽 1800 点"
  },
  Task_132930_Desc = {
    Text = "完成 1 周的所有每周试炼任务"
  },
  Task_132931_Desc = {
    Text = "累计登录 1 天"
  },
  Task_132932_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_132933_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_133297_Desc = {
    Text = "完成异梦视界「征厨房记」"
  },
  Task_133297_Name = {
    Text = "狂喜！震怒！落泪！"
  },
  Task_133302_Desc = {
    Text = "「精粹活性离子」达到1000"
  },
  Task_133303_Desc = {
    Text = "使用助战 3 次"
  },
  Task_133304_Desc = {
    Text = "「精粹活性离子」达到1000"
  },
  Task_133305_Desc = {
    Text = "累计打出300张牌"
  },
  Task_133306_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_133307_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_133308_Desc = {
    Text = "累计打出300张牌"
  },
  Task_133309_Desc = {
    Text = "唤醒 30 次"
  },
  Task_133310_Desc = {
    Text = "累计登录1天"
  },
  Task_133311_Desc = {
    Text = "完成「禁忌试炼」中任意赛季任务"
  },
  Task_133312_Desc = {
    Text = "唤醒 30 次"
  },
  Task_133313_Desc = {
    Text = "完成 15 次派遣"
  },
  Task_133314_Desc = {
    Text = "完成「禁忌试炼」中任意赛季任务"
  },
  Task_133315_Desc = {
    Text = "使用助战 3 次"
  },
  Task_133316_Desc = {
    Text = "累计登录1天"
  },
  Task_133317_Desc = {
    Text = "完成 15 次派遣"
  },
  Task_133940_Desc = {
    Text = "给校友点赞 1 次"
  },
  Task_133940_Name = {
    Text = "好友点赞"
  },
  Task_133941_Desc = {
    Text = "消耗 180 灵啡肽"
  },
  Task_133941_Name = {
    Text = "消耗体力"
  },
  Task_133943_Desc = {
    Text = "打出 50 张卡牌"
  },
  Task_133943_Name = {
    Text = "每日试训"
  },
  Task_133944_Desc = {
    Text = "执行 3 次派遣"
  },
  Task_133944_Name = {
    Text = "进行委派"
  },
  Task_133945_Desc = {
    Text = "完成密契转录 50 次"
  },
  Task_133945_Name = {
    Text = "密契转录"
  },
  Task_133946_Desc = {
    Text = "完成超验存在 1 次"
  },
  Task_133946_Name = {Text = "周常BOSS"},
  Task_133947_Desc = {
    Text = "进行 30 次唤醒仪式"
  },
  Task_133947_Name = {Text = "抽卡"},
  Task_133948_Desc = {
    Text = "消耗 1500 灵啡肽"
  },
  Task_133948_Name = {
    Text = "消耗体力"
  },
  Task_133949_Desc = {
    Text = "消耗 100万 蔷薇金券"
  },
  Task_133949_Name = {
    Text = "挥金如土"
  },
  Task_134074_Desc = {
    Text = "完成调查事件「@1@2」"
  },
  Task_134074_Desc2 = {
    Text = "完成调查事件「织命剧场」"
  },
  Task_134074_Name = {Text = "@1@2"},
  Task_134074_Name2 = {
    Text = "命定的主演"
  },
  Task_134075_Desc = {
    Text = "完成调查事件「织命剧场」困难难度"
  },
  Task_134075_Name = {
    Text = "命定的主演·困难"
  },
  Task_134095_Desc = {
    Text = "在调查事件「@1@2」中共鸣3次"
  },
  Task_134095_Desc2 = {
    Text = "在调查事件「织命剧场」中共鸣3次"
  },
  Task_134095_Name = {Text = "@1@2"},
  Task_134095_Name2 = {
    Text = "依从回响"
  },
  Task_134096_Desc = {
    Text = "在调查事件「@1@2」中共鸣10次"
  },
  Task_134096_Desc2 = {
    Text = "在调查事件「织命剧场」中共鸣10次"
  },
  Task_134096_Name = {Text = "@1@2"},
  Task_134096_Name2 = {
    Text = "依从回响Ⅳ"
  },
  Task_134097_Desc = {
    Text = "在调查事件「@1@2」中共鸣9次"
  },
  Task_134097_Desc2 = {
    Text = "在调查事件「织命剧场」中共鸣9次"
  },
  Task_134097_Name = {Text = "@1@2"},
  Task_134097_Name2 = {
    Text = "依从回响Ⅲ"
  },
  Task_134098_Desc = {
    Text = "在调查事件「@1@2」中共鸣6次"
  },
  Task_134098_Desc2 = {
    Text = "在调查事件「织命剧场」中共鸣6次"
  },
  Task_134098_Name = {Text = "@1@2"},
  Task_134098_Name2 = {
    Text = "依从回响Ⅱ"
  },
  Task_134099_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_134099_Name = {
    Text = "完美通过"
  },
  Task_134121_Desc = {
    Text = "卡拉布达到人格深化12"
  },
  Task_134122_Desc = {
    Text = "凯刻斯达到人格深化12"
  },
  Task_134123_Desc = {
    Text = "法洛思达到人格深化12"
  },
  Task_134124_Desc = {
    Text = "茉夏达到人格深化12"
  },
  Task_134125_Desc = {
    Text = "沙耶达到人格深化12"
  },
  Task_134126_Desc = {
    Text = "撒托古亚达到人格深化12"
  },
  Task_134127_Desc = {
    Text = "泰旖丝达到人格深化12"
  },
  Task_134128_Desc = {
    Text = "本源沉睡之主达到人格深化12"
  },
  Task_134129_Desc = {
    Text = "希洛达到人格深化12"
  },
  Task_134130_Desc = {
    Text = "塔薇达到人格深化12"
  },
  Task_134131_Desc = {
    Text = "波吕克斯达到人格深化12"
  },
  Task_134132_Desc = {
    Text = "「24」达到人格深化12"
  },
  Task_134134_Desc = {
    Text = "尤乌哈希达到人格深化12"
  },
  Task_134135_Desc = {
    Text = "诞妄·墨菲达到人格深化12"
  },
  Task_134136_Desc = {
    Text = "熔毁·朵尔达到人格深化12"
  },
  Task_134137_Desc = {
    Text = "皮克曼达到人格深化12"
  },
  Task_134138_Desc = {
    Text = "潘狄娅达到人格深化12"
  },
  Task_134140_Desc = {
    Text = "奥尔拉达到人格深化12"
  },
  Task_134141_Desc = {
    Text = "徐达到人格深化12"
  },
  Task_134142_Desc = {
    Text = "汀克特达到人格深化12"
  },
  Task_134143_Desc = {
    Text = "凯蒂古拉达到人格深化12"
  },
  Task_134144_Desc = {
    Text = "雷娅达到人格深化12"
  },
  Task_134145_Desc = {
    Text = "墨菲达到人格深化12"
  },
  Task_134146_Desc = {
    Text = "杜勒赛因达到人格深化12"
  },
  Task_134148_Desc = {
    Text = "克珀珊特达到人格深化12"
  },
  Task_134149_Desc = {
    Text = "莉莉达到人格深化12"
  },
  Task_134150_Desc = {
    Text = "血链·希洛达到人格深化12"
  },
  Task_134151_Desc = {
    Text = "温柯尔达到人格深化12"
  },
  Task_134152_Desc = {
    Text = "哈姆林达到人格深化12"
  },
  Task_134153_Desc = {
    Text = "莱克达到人格深化12"
  },
  Task_134154_Desc = {
    Text = "珊达到人格深化12"
  },
  Task_134155_Desc = {
    Text = "卡茜亚达到人格深化12"
  },
  Task_134156_Desc = {
    Text = "卡斯托尔达到人格深化12"
  },
  Task_134157_Desc = {
    Text = "莫丝达到人格深化12"
  },
  Task_134158_Desc = {
    Text = "菲茵特达到人格深化12"
  },
  Task_134159_Desc = {
    Text = "诺缔拉达到人格深化12"
  },
  Task_134160_Desc = {
    Text = "阿格里帕达到人格深化12"
  },
  Task_134161_Desc = {
    Text = "詹金达到人格深化12"
  },
  Task_134162_Desc = {
    Text = "萨尔瓦多达到人格深化12"
  },
  Task_134163_Desc = {
    Text = "阿拉克涅达到人格深化12"
  },
  Task_134164_Desc = {
    Text = "达芙黛尔达到人格深化12"
  },
  Task_134165_Desc = {
    Text = "希莱斯特达到人格深化12"
  },
  Task_134166_Desc = {
    Text = "索蕾尔达到人格深化12"
  },
  Task_134167_Desc = {
    Text = "戈利亚达到人格深化12"
  },
  Task_134168_Desc = {
    Text = "图鲁达到人格深化12"
  },
  Task_134169_Desc = {
    Text = "克莱门汀达到人格深化12"
  },
  Task_134170_Desc = {
    Text = "珈伦达到人格深化12"
  },
  Task_134171_Desc = {
    Text = "宁菲亚达到人格深化12"
  },
  Task_134172_Desc = {
    Text = "旺达达到人格深化12"
  },
  Task_134173_Desc = {
    Text = "莉兹达到人格深化12"
  },
  Task_134174_Desc = {
    Text = "艾尔瓦达到人格深化12"
  },
  Task_134175_Desc = {
    Text = "弥利亚姆达到人格深化12"
  },
  Task_134394_Desc = {
    Text = "累计登录 6 天"
  },
  Task_134395_Desc = {
    Text = "累计登录 10 天"
  },
  Task_134396_Desc = {
    Text = "累计登录 16 天"
  },
  Task_134397_Desc = {
    Text = "累计登录 7 天"
  },
  Task_134398_Desc = {
    Text = "累计登录 15 天"
  },
  Task_134399_Desc = {
    Text = "累计登录 9 天"
  },
  Task_134400_Desc = {
    Text = "累计登录 4 天"
  },
  Task_134401_Desc = {
    Text = "累计登录 14 天"
  },
  Task_134402_Desc = {
    Text = "累计登录 5 天"
  },
  Task_134403_Desc = {
    Text = "累计登录 11 天"
  },
  Task_134404_Desc = {
    Text = "累计登录 13 天"
  },
  Task_134405_Desc = {
    Text = "累计登录 1 天"
  },
  Task_134406_Desc = {
    Text = "累计登录 2 天"
  },
  Task_134407_Desc = {
    Text = "累计登录 3 天"
  },
  Task_134408_Desc = {
    Text = "累计登录 8 天"
  },
  Task_134409_Desc = {
    Text = "累计登录 12 天"
  },
  Task_135038_Desc = {
    Text = "登录游戏"
  },
  Task_135038_Name = {
    Text = "登录游戏"
  },
  Task_137649_Desc = {
    Text = "本赛季打出 150 张牌"
  },
  Task_137650_Desc = {
    Text = "本赛季打出 150 张牌"
  },
  Task_138583_Desc = {
    Text = "唤醒 30 次"
  },
  Task_138584_Desc = {
    Text = "完成「禁忌试炼」中任意赛季任务"
  },
  Task_138585_Desc = {
    Text = "累计打出300张牌"
  },
  Task_138586_Desc = {
    Text = "使用助战 3 次"
  },
  Task_138587_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_138588_Desc = {
    Text = "累计登录1天"
  },
  Task_138589_Desc = {
    Text = "唤醒 30 次"
  },
  Task_138590_Desc = {
    Text = "完成 15 次派遣"
  },
  Task_138591_Desc = {
    Text = "累计打出300张牌"
  },
  Task_138592_Desc = {
    Text = "使用助战 3 次"
  },
  Task_138593_Desc = {
    Text = "「精粹活性离子」达到1000"
  },
  Task_138594_Desc = {
    Text = "「精粹活性离子」达到1000"
  },
  Task_138595_Desc = {
    Text = "累计登录1天"
  },
  Task_138596_Desc = {
    Text = "完成「禁忌试炼」中任意赛季任务"
  },
  Task_138597_Desc = {
    Text = "完成 15 次派遣"
  },
  Task_138598_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_138762_Desc = {
    Text = "承受「凌驾命运的悲歌」后，击败「背弃之网」涅芙蕾亚。"
  },
  Task_138762_Name = {
    Text = "命定的主演·隐藏"
  },
  Task_139118_Desc = {
    Text = "完成「多维连接-被遗忘的爱之种」"
  },
  Task_139119_Desc = {
    Text = "完成以上全部任务"
  },
  Task_139121_Desc = {
    Text = "唤醒 1000 次"
  },
  Task_139123_Desc = {
    Text = "唤醒 250 次"
  },
  Task_139124_Desc = {
    Text = "登录 1 天"
  },
  Task_139125_Desc = {
    Text = "完成「调查行动-忘却篇-第四章」普通模式"
  },
  Task_139126_Desc = {
    Text = "唤醒 500 次"
  },
  Task_139127_Desc = {
    Text = "唤醒 100 次"
  },
  Task_139600_Desc = {
    Text = "累计抓捕 1000000次"
  },
  Task_139614_Desc = {
    Text = "累计抓捕 500000次"
  },
  Task_139618_Desc = {
    Text = "累计抓捕 50次"
  },
  Task_139619_Desc = {
    Text = "累计抓捕 1000000次"
  },
  Task_139626_Desc = {
    Text = "累计抓捕 300000次"
  },
  Task_139629_Desc = {
    Text = "累计抓捕 700000次"
  },
  Task_139646_Desc = {
    Text = "校园抓捕记录"
  },
  Task_139649_Desc = {
    Text = "累计抓捕 100000次"
  },
  Task_139651_Desc = {
    Text = "个人抓捕记录"
  },
  Task_139652_Desc = {
    Text = "累计抓捕 100次"
  },
  Task_140087_Desc = {
    Text = "「巨物」通关1次"
  },
  Task_140088_Desc = {
    Text = "「黑金潮」通关1次"
  },
  Task_140089_Desc = {
    Text = "「拒捕」通关10次"
  },
  Task_140090_Desc = {
    Text = "「收网！收网！」通关5次"
  },
  Task_140091_Desc = {
    Text = "「满载而归」通关5次"
  },
  Task_140092_Desc = {
    Text = "「拒捕」通关1次"
  },
  Task_140093_Desc = {
    Text = "「巨物」通关10次"
  },
  Task_140094_Desc = {
    Text = "「第一桶银芯」通关5次"
  },
  Task_140095_Desc = {
    Text = "「黑金潮」通关5次"
  },
  Task_140096_Desc = {
    Text = "「第一桶银芯」通关1次"
  },
  Task_140097_Desc = {
    Text = "「满载而归」通关10次"
  },
  Task_140098_Desc = {
    Text = "「拒捕」通关5次"
  },
  Task_140099_Desc = {
    Text = "「巨物」通关5次"
  },
  Task_140100_Desc = {
    Text = "「满载而归」通关1次"
  },
  Task_140101_Desc = {
    Text = "「收网！收网！」通关10次"
  },
  Task_140102_Desc = {
    Text = "「再来一次」通关1次"
  },
  Task_140103_Desc = {
    Text = "「再来一次」通关10次"
  },
  Task_140104_Desc = {
    Text = "「第一桶银芯」通关10次"
  },
  Task_140105_Desc = {
    Text = "「收网！收网！」通关1次"
  },
  Task_140106_Desc = {
    Text = "「黑金潮」通关10次"
  },
  Task_140107_Desc = {
    Text = "「再来一次」通关5次"
  },
  Task_140114_Desc = {
    Text = "完成「多维连接-被遗忘的爱之种」"
  },
  Task_140115_Desc = {
    Text = "完成以上全部任务"
  },
  Task_140116_Desc = {
    Text = "登录 1 天"
  },
  Task_140117_Desc = {
    Text = "完成「调查行动-忘却篇-第四章」普通模式"
  },
  Task_140189_Desc = {
    Text = "累计提取 5000 源液"
  },
  Task_140190_Desc = {
    Text = "累计提取 20000 源液"
  },
  Task_140191_Desc = {
    Text = "累计提取 10000 源液"
  },
  Task_140192_Desc = {
    Text = "累计提取 30000 源液"
  },
  Task_140306_Desc = {
    Text = "完成多维连接「被遗忘的爱之种」困难难度"
  },
  Task_140306_Name = {
    Text = "漂泊者的归宿·困难"
  },
  Task_140307_Desc = {
    Text = "完成多维连接「被遗忘的爱之种」"
  },
  Task_140307_Name = {
    Text = "漂泊者的归宿"
  },
  Task_140463_Desc = {
    Text = "累计打出 200 张牌"
  },
  Task_140464_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_140465_Desc = {
    Text = "累计登录 1 天"
  },
  Task_140466_Desc = {
    Text = "「精粹活性离子」达到1000"
  },
  Task_140467_Desc = {
    Text = "完成以上全部任务"
  },
  Task_140468_Desc = {
    Text = "完成「禁忌试炼」中任意赛季任务"
  },
  Task_141311_Desc = {
    Text = "通关意识潜游「永远的厄波扬斯」"
  },
  Task_141312_Desc = {
    Text = "庞托斯同调率达到10 级"
  },
  Task_141313_Desc = {
    Text = "使用超维界域唤醒体在「高屋巡猎」中获胜1次"
  },
  Task_141314_Desc = {
    Text = "通关「森林法典」癫狂难度"
  },
  Task_141315_Desc = {
    Text = "通关「麦酒与香料」任意难度"
  },
  Task_141316_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_141317_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_141318_Desc = {
    Text = "通关「剖白」任意难度"
  },
  Task_141319_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_141320_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_141321_Desc = {
    Text = "使用血肉界域唤醒体在「高屋巡猎」中获胜2次"
  },
  Task_141322_Desc = {
    Text = "使用混沌界域唤醒体在「高屋巡猎」中获胜2次"
  },
  Task_141323_Desc = {
    Text = "使用深海界域唤醒体在「高屋巡猎」中获胜1次"
  },
  Task_141324_Desc = {
    Text = "高屋巡猎·界域"
  },
  Task_141325_Desc = {
    Text = "通关「哨音」癫狂难度"
  },
  Task_141326_Desc = {
    Text = "通关「追逃游戏」任意难度"
  },
  Task_141327_Desc = {
    Text = "通关「麦酒与香料」任意难度"
  },
  Task_141328_Desc = {
    Text = "通关「森林法典」任意难度"
  },
  Task_141329_Desc = {
    Text = "高屋巡猎·癫狂"
  },
  Task_141330_Desc = {
    Text = "通关「二元论」癫狂难度"
  },
  Task_141331_Desc = {
    Text = "通关「森林法典」任意难度"
  },
  Task_141332_Desc = {
    Text = "通关「麦酒与香料」癫狂难度"
  },
  Task_141333_Desc = {
    Text = "通关「剖白」癫狂难度"
  },
  Task_141335_Desc = {
    Text = "通关「肋软骨」任意难度"
  },
  Task_141336_Desc = {
    Text = "通关「二元论」任意难度"
  },
  Task_141337_Desc = {
    Text = "完成「高屋巡猎·通关」所有成就"
  },
  Task_141338_Desc = {
    Text = "获得庞托斯时启灵6"
  },
  Task_141338_Name = {
    Text = "获得庞托斯时启灵6"
  },
  Task_141338_UnlockCondDesc = {
    Text = "活动@唤醒体庞托斯启灵礼包2活动"
  },
  Task_141339_Desc = {
    Text = "通关「肋软骨」任意难度"
  },
  Task_141340_Desc = {
    Text = "通关「二元论」任意难度"
  },
  Task_141341_Desc = {
    Text = "高屋巡猎·通关"
  },
  Task_141342_Desc = {
    Text = "使用深海界域唤醒体在「高屋巡猎」中获胜2次"
  },
  Task_141343_Desc = {
    Text = "通关「哨音」任意难度"
  },
  Task_141344_Desc = {
    Text = "通关「剖白」任意难度"
  },
  Task_141345_Desc = {
    Text = "使用超维界域唤醒体在「高屋巡猎」中获胜2次"
  },
  Task_141346_Desc = {
    Text = "使用混沌界域唤醒体在「高屋巡猎」中获胜1次"
  },
  Task_141347_Desc = {
    Text = "通关「追逃游戏」癫狂难度"
  },
  Task_141348_Desc = {
    Text = "通关「哨音」任意难度"
  },
  Task_141349_Desc = {
    Text = "使用血肉界域唤醒体在「高屋巡猎」中获胜1次"
  },
  Task_141350_Desc = {
    Text = "庞托斯达到人格深化12"
  },
  Task_141351_Desc = {
    Text = "获得庞托斯时启灵2"
  },
  Task_141351_Name = {
    Text = "获得庞托斯时启灵2"
  },
  Task_141351_UnlockCondDesc = {
    Text = "活动@唤醒体庞托斯启灵礼包2活动"
  },
  Task_141352_Desc = {
    Text = "通关「追逃游戏」任意难度"
  },
  Task_141353_Desc = {
    Text = "通关「肋软骨」癫狂难度"
  },
  Task_141511_Desc = {
    Text = "累计打出300张牌"
  },
  Task_141512_Desc = {
    Text = "完成「禁忌试炼」中任意赛季任务"
  },
  Task_141513_Desc = {
    Text = "使用助战 3 次"
  },
  Task_141514_Desc = {
    Text = "完成 15 次派遣"
  },
  Task_141515_Desc = {
    Text = "累计登录1天"
  },
  Task_141516_Desc = {
    Text = "累计登录1天"
  },
  Task_141517_Desc = {
    Text = "唤醒 30 次"
  },
  Task_141518_Desc = {
    Text = "完成「禁忌试炼」中任意赛季任务"
  },
  Task_141519_Desc = {
    Text = "使用助战 3 次"
  },
  Task_141520_Desc = {
    Text = "「精粹活性离子」达到1000"
  },
  Task_141521_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_141522_Desc = {
    Text = "累计打出300张牌"
  },
  Task_141523_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_141524_Desc = {
    Text = "唤醒 30 次"
  },
  Task_141525_Desc = {
    Text = "「精粹活性离子」达到1000"
  },
  Task_141526_Desc = {
    Text = "完成 15 次派遣"
  },
  Task_141799_Desc = {
    Text = "使用深海界域唤醒体在「乌摩钵蒂的宝物」中获胜2次"
  },
  Task_141800_Desc = {
    Text = "使用超维界域唤醒体在「乌摩钵蒂的宝物」中获胜2次"
  },
  Task_141801_Desc = {
    Text = "通关「丝线」任意难度"
  },
  Task_141802_Desc = {
    Text = "使用血肉界域唤醒体在「乌摩钵蒂的宝物」中获胜2次"
  },
  Task_141803_Desc = {
    Text = "完成「乌摩钵蒂的宝物·通关」所有成就"
  },
  Task_141804_Desc = {
    Text = "使用混沌界域唤醒体在「乌摩钵蒂的宝物」中获胜1次"
  },
  Task_141805_Desc = {
    Text = "通关「苹果」任意难度"
  },
  Task_141806_Desc = {
    Text = "通关「镜子」任意难度"
  },
  Task_141807_Desc = {
    Text = "通关「钥匙」任意难度"
  },
  Task_141808_Desc = {
    Text = "通关「镜子」癫狂难度"
  },
  Task_141809_Desc = {
    Text = "通关「王冠」癫狂难度"
  },
  Task_141810_Desc = {
    Text = "通关「羽毛」任意难度"
  },
  Task_141811_Desc = {
    Text = "通关「眼睛」任意难度"
  },
  Task_141812_Desc = {
    Text = "通关「丝线」癫狂难度"
  },
  Task_141813_Desc = {
    Text = "通关「苹果」癫狂难度"
  },
  Task_141814_Desc = {
    Text = "通关「王冠」任意难度"
  },
  Task_141815_Desc = {
    Text = "使用血肉界域唤醒体在「乌摩钵蒂的宝物」中获胜1次"
  },
  Task_141816_Desc = {
    Text = "通关「镜子」任意难度"
  },
  Task_141817_Desc = {
    Text = "通关「羽毛」癫狂难度"
  },
  Task_141818_Desc = {
    Text = "通关「羽毛」任意难度"
  },
  Task_141819_Desc = {
    Text = "乌摩钵蒂的宝物·癫狂"
  },
  Task_141820_Desc = {
    Text = "乌摩钵蒂的宝物·界域"
  },
  Task_141821_Desc = {
    Text = "通关「眼睛」任意难度"
  },
  Task_141822_Desc = {
    Text = "通关「丝线」任意难度"
  },
  Task_141823_Desc = {
    Text = "通关「钥匙」任意难度"
  },
  Task_141824_Desc = {
    Text = "乌摩钵蒂的宝物·通关"
  },
  Task_141825_Desc = {
    Text = "通关「苹果」任意难度"
  },
  Task_141826_Desc = {
    Text = "使用超维界域唤醒体在「乌摩钵蒂的宝物」中获胜1次"
  },
  Task_141827_Desc = {
    Text = "使用深海界域唤醒体在「乌摩钵蒂的宝物」中获胜1次"
  },
  Task_141828_Desc = {
    Text = "通关「眼睛」癫狂难度"
  },
  Task_141829_Desc = {
    Text = "使用混沌界域唤醒体在「乌摩钵蒂的宝物」中获胜2次"
  },
  Task_141830_Desc = {
    Text = "通关「钥匙」癫狂难度"
  },
  Task_141831_Desc = {
    Text = "通关「王冠」任意难度"
  },
  Task_141899_Desc = {
    Text = "在「用户中心-完善资料」中绑定手机号或邮箱"
  },
  Task_143320_Desc = {
    Text = "完成意识潜游「永远的厄波扬斯」困难难度"
  },
  Task_143320_Name = {
    Text = "凉爽的夏夜·困难"
  },
  Task_143321_Desc = {
    Text = "完成意识潜游「永远的厄波扬斯」"
  },
  Task_143321_Name = {
    Text = "凉爽的夏夜"
  },
  Task_143588_Desc = {
    Text = "他怀中的厄波扬斯……"
  },
  Task_143588_Name = {
    Text = "他怀中的厄波扬斯……"
  },
  Task_143589_Desc = {
    Text = "留下来……"
  },
  Task_143589_Name = {
    Text = "留下来……"
  },
  Task_143590_Desc = {
    Text = "留在厄波扬斯"
  },
  Task_143590_Name = {
    Text = "留在厄波扬斯"
  },
  Task_144311_Desc = {
    Text = "使用 1/2/3/4 名强化唤醒体时出战时，获得 250 / 500 750 / 1000 分。（当前出战：{s1}）"
  },
  Task_144311_Name = {
    Text = "深渊呼唤<size=20><color=#747474>使用 1/2/3/4 名强化唤醒体时出战时，获得 250 / 500 / 750 / 1000 分 </color></size>"
  },
  Task_144312_Desc = {
    Text = "通关意识潜游「临时文本」"
  },
  Task_144313_Desc = {
    Text = "颠倒的新生·通关"
  },
  Task_144314_Desc = {
    Text = "通关「脑损伤」癫狂难度"
  },
  Task_144315_Desc = {
    Text = "使用深海界域唤醒体在「颠倒的新生」中获胜1次"
  },
  Task_144316_Desc = {
    Text = "通关「最后的小酌」癫狂难度"
  },
  Task_144317_Desc = {
    Text = "通关「最后的小酌」任意难度"
  },
  Task_144318_Desc = {
    Text = "颠倒的新生·界域"
  },
  Task_144319_Desc = {
    Text = "通关「医院」任意难度"
  },
  Task_144320_Desc = {
    Text = "使用深海界域唤醒体在「颠倒的新生」中获胜2次"
  },
  Task_144321_Desc = {
    Text = "通关「餐桌」任意难度"
  },
  Task_144322_Desc = {
    Text = "通关「餐桌」癫狂难度"
  },
  Task_144323_Desc = {
    Text = "通关「家」任意难度"
  },
  Task_144324_Desc = {
    Text = "使用超维界域唤醒体在「颠倒的新生」中获胜1次"
  },
  Task_144325_Desc = {
    Text = "通关「水井」任意难度"
  },
  Task_144326_Desc = {
    Text = "通关「家」任意难度"
  },
  Task_144327_Desc = {
    Text = "使用混沌界域唤醒体在「颠倒的新生」中获胜2次"
  },
  Task_144328_Desc = {
    Text = "通关「医院」任意难度"
  },
  Task_144329_Desc = {
    Text = "通关「水井」任意难度"
  },
  Task_144330_Desc = {
    Text = "通关「学校」任意难度"
  },
  Task_144331_Desc = {
    Text = "通关「脑损伤」任意难度"
  },
  Task_144332_Desc = {
    Text = "完成「颠倒的新生·通关」所有成就"
  },
  Task_144333_Desc = {
    Text = "通关「餐桌」任意难度"
  },
  Task_144334_Desc = {
    Text = "通关「学校」癫狂难度"
  },
  Task_144335_Desc = {
    Text = "通关「家」癫狂难度"
  },
  Task_144336_Desc = {
    Text = "使用血肉界域唤醒体在「颠倒的新生」中获胜1次"
  },
  Task_144337_Desc = {
    Text = "通关「脑损伤」任意难度"
  },
  Task_144338_Desc = {
    Text = "通关「学校」任意难度"
  },
  Task_144339_Desc = {
    Text = "通关「最后的小酌」任意难度"
  },
  Task_144340_Desc = {
    Text = "使用血肉界域唤醒体在「颠倒的新生」中获胜2次"
  },
  Task_144341_Desc = {
    Text = "使用混沌界域唤醒体在「颠倒的新生」中获胜1次"
  },
  Task_144342_Desc = {
    Text = "使用超维界域唤醒体在「颠倒的新生」中获胜2次"
  },
  Task_144343_Desc = {
    Text = "颠倒的新生·癫狂"
  },
  Task_144344_Desc = {
    Text = "通关「水井」癫狂难度"
  },
  Task_144345_Desc = {
    Text = "通关「医院」癫狂难度"
  },
  Task_144360_Desc = {
    Text = "累计打出300张牌"
  },
  Task_144361_Desc = {
    Text = "完成「禁忌试炼」中任意赛季任务"
  },
  Task_144362_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_144363_Desc = {
    Text = "完成 15 次派遣"
  },
  Task_144364_Desc = {
    Text = "「精粹活性离子」达到1000"
  },
  Task_144365_Desc = {
    Text = "唤醒 30 次"
  },
  Task_144366_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_144367_Desc = {
    Text = "累计登录1天"
  },
  Task_144368_Desc = {
    Text = "完成「禁忌试炼」中任意赛季任务"
  },
  Task_144369_Desc = {
    Text = "完成 15 次派遣"
  },
  Task_144370_Desc = {
    Text = "累计打出300张牌"
  },
  Task_144371_Desc = {
    Text = "「精粹活性离子」达到1000"
  },
  Task_144372_Desc = {
    Text = "唤醒 30 次"
  },
  Task_144373_Desc = {
    Text = "使用助战 3 次"
  },
  Task_144374_Desc = {
    Text = "使用助战 3 次"
  },
  Task_144375_Desc = {
    Text = "累计登录1天"
  },
  Task_145388_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_145389_Desc = {
    Text = "使用深海界域唤醒体在「贪戮角逐」中获胜2次"
  },
  Task_145390_Desc = {
    Text = "通关「觐献」任意难度"
  },
  Task_145392_Desc = {
    Text = "贪戮角逐·通关"
  },
  Task_145393_Desc = {
    Text = "通关「杀戮殿堂」癫狂难度"
  },
  Task_145394_Desc = {
    Text = "通关「权欲王冠」任意难度"
  },
  Task_145395_Desc = {
    Text = "通关意识潜游「直至鲸天陨落」"
  },
  Task_145396_Desc = {
    Text = "获得蚀灭·萝坦时启灵6"
  },
  Task_145396_Name = {
    Text = "获得蚀灭·萝坦时启灵6"
  },
  Task_145396_UnlockCondDesc = {
    Text = "活动@唤醒体蚀灭·萝坦启灵礼包2活动"
  },
  Task_145397_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_145398_Desc = {
    Text = "蚀灭·萝坦同调率达到10 级"
  },
  Task_145399_Desc = {
    Text = "贪戮角逐·界域"
  },
  Task_145400_Desc = {
    Text = "通关「困兽」任意难度"
  },
  Task_145401_Desc = {
    Text = "通关「杀戮殿堂」任意难度"
  },
  Task_145402_Desc = {
    Text = "通关「困兽」任意难度"
  },
  Task_145403_Desc = {
    Text = "通关「困兽」癫狂难度"
  },
  Task_145404_Desc = {
    Text = "使用超维界域唤醒体在「贪戮角逐」中获胜1次"
  },
  Task_145405_Desc = {
    Text = "使用混沌界域唤醒体在「贪戮角逐」中获胜2次"
  },
  Task_145406_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_145408_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_145409_Desc = {
    Text = "通关「权欲王冠」任意难度"
  },
  Task_145410_Desc = {
    Text = "完成「贪戮角逐·通关」所有成就"
  },
  Task_145411_Desc = {
    Text = "使用血肉界域唤醒体在「贪戮角逐」中获胜1次"
  },
  Task_145412_Desc = {
    Text = "使用血肉界域唤醒体在「贪戮角逐」中获胜2次"
  },
  Task_145413_Desc = {
    Text = "通关「觐献」任意难度"
  },
  Task_145414_Desc = {
    Text = "获得蚀灭·萝坦时启灵2"
  },
  Task_145414_Name = {
    Text = "获得蚀灭·萝坦时启灵2"
  },
  Task_145414_UnlockCondDesc = {
    Text = "活动@唤醒体蚀灭·萝坦启灵礼包2活动"
  },
  Task_145415_Desc = {
    Text = "使用混沌界域唤醒体在「贪戮角逐」中获胜1次"
  },
  Task_145416_Desc = {
    Text = "使用超维界域唤醒体在「贪戮角逐」中获胜2次"
  },
  Task_145417_Desc = {
    Text = "通关「觐献」癫狂难度"
  },
  Task_145418_Desc = {
    Text = "贪戮角逐·癫狂"
  },
  Task_145419_Desc = {
    Text = "通关「无人之镜」癫狂难度"
  },
  Task_145420_Desc = {
    Text = "通关「无人之镜」任意难度"
  },
  Task_145421_Desc = {
    Text = "通关「权欲王冠」癫狂难度"
  },
  Task_145423_Desc = {
    Text = "使用深海界域唤醒体在「贪戮角逐」中获胜1次"
  },
  Task_145424_Desc = {
    Text = "通关「无人之镜」任意难度"
  },
  Task_145425_Desc = {
    Text = "蚀灭·萝坦达到人格深化12"
  },
  Task_145426_Desc = {
    Text = "通关「杀戮殿堂」任意难度"
  },
  Task_145479_Desc = {
    Text = "完成意识潜游「直至鲸天陨落」"
  },
  Task_145479_Name = {
    Text = "我即是风暴"
  },
  Task_145576_Desc = {
    Text = "临时文本·限时专属"
  },
  Task_145578_Desc = {
    Text = "万愿拟造·限时专属"
  },
  Task_146542_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_146543_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_146544_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_146545_Desc = {
    Text = "通关星辰篇第6章 6-9"
  },
  Task_146546_Desc = {
    Text = "通关星辰篇第6章「山宴」困难难度"
  },
  Task_146547_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_146548_Desc = {
    Text = "通关星辰篇第6章「山宴」困难难度"
  },
  Task_146549_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_146550_Desc = {
    Text = "通关星辰篇第6章 6-9"
  },
  Task_146552_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_146553_Desc = {
    Text = "通关星辰篇第6章「山宴」"
  },
  Task_146554_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_146555_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_146556_Desc = {
    Text = "通关星辰篇第6章 6-5 困难难度"
  },
  Task_146557_Desc = {
    Text = "通关星辰篇第6章 6-5 困难难度"
  },
  Task_146558_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_146559_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_146560_Desc = {
    Text = "通关星辰篇第6章「山宴」"
  },
  Task_146801_Desc = {
    Text = "使用深海界域唤醒体在「临时文本」中获胜1次"
  },
  Task_146802_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_146803_Desc = {
    Text = "通关「临时文本」癫狂难度"
  },
  Task_146804_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_146805_Desc = {
    Text = "使用血肉界域唤醒体在「临时文本」中获胜2次"
  },
  Task_146806_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_146807_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_146808_Desc = {
    Text = "通关意识潜游「五日谈」"
  },
  Task_146809_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_146810_Desc = {
    Text = "使用深海界域唤醒体在「临时文本」中获胜2次"
  },
  Task_146811_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_146812_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_146813_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_146814_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_146815_Desc = {
    Text = "使用混沌界域唤醒体在「临时文本」中获胜1次"
  },
  Task_146816_Desc = {
    Text = "使用超维界域唤醒体在「临时文本」中获胜1次"
  },
  Task_146817_Desc = {
    Text = "临时文本·通关"
  },
  Task_146818_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_146819_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_146820_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_146821_Desc = {
    Text = "通关「临时文本」癫狂难度"
  },
  Task_146822_Desc = {
    Text = "通关「临时文本」癫狂难度"
  },
  Task_146823_Desc = {
    Text = "临时文本·界域"
  },
  Task_146824_Desc = {
    Text = "通关「临时文本」癫狂难度"
  },
  Task_146825_Desc = {
    Text = "通关「临时文本」癫狂难度"
  },
  Task_146826_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_146827_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_146828_Desc = {
    Text = "通关「临时文本」癫狂难度"
  },
  Task_146829_Desc = {
    Text = "使用混沌界域唤醒体在「临时文本」中获胜2次"
  },
  Task_146830_Desc = {
    Text = "通关「临时文本」癫狂难度"
  },
  Task_146831_Desc = {
    Text = "使用超维界域唤醒体在「临时文本」中获胜2次"
  },
  Task_146832_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_146833_Desc = {
    Text = "使用血肉界域唤醒体在「临时文本」中获胜1次"
  },
  Task_146834_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_146835_Desc = {
    Text = "临时文本·癫狂"
  },
  Task_146836_Desc = {
    Text = "完成「临时文本·通关」所有成就"
  },
  Task_146837_Desc = {
    Text = "通关「临时文本」癫狂难度"
  },
  Task_146838_Desc = {
    Text = "通关「临时文本」癫狂难度"
  },
  Task_146839_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_146840_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_147442_Desc = {
    Text = "使用血肉界域唤醒体在「临时文本」中获胜2次"
  },
  Task_147443_Desc = {
    Text = "暮星·汀克特同调率达到10 级"
  },
  Task_147444_Desc = {
    Text = "使用深海界域唤醒体在「临时文本」中获胜1次"
  },
  Task_147450_Desc = {
    Text = "通关意识潜游「临时文本」"
  },
  Task_147451_Desc = {
    Text = "使用超维界域唤醒体在「临时文本」中获胜1次"
  },
  Task_147452_Desc = {
    Text = "使用混沌界域唤醒体在「临时文本」中获胜1次"
  },
  Task_147453_Desc = {
    Text = "使用深海界域唤醒体在「临时文本」中获胜2次"
  },
  Task_147454_Desc = {
    Text = "使用血肉界域唤醒体在「临时文本」中获胜1次"
  },
  Task_147456_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_147458_Desc = {
    Text = "获得暮星·汀克特时启灵2"
  },
  Task_147458_Name = {
    Text = "获得暮星·汀克特时启灵2"
  },
  Task_147458_UnlockCondDesc = {
    Text = "活动@唤醒体暮星·汀克特启灵礼包2活动"
  },
  Task_147461_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_147464_Desc = {
    Text = "完成意识潜游「临时文本」"
  },
  Task_147464_Name = {
    Text = "临时文本"
  },
  Task_147465_Desc = {
    Text = "获得暮星·汀克特时启灵6"
  },
  Task_147465_Name = {
    Text = "获得暮星·汀克特时启灵6"
  },
  Task_147465_UnlockCondDesc = {
    Text = "活动@唤醒体暮星·汀克特启灵礼包2活动"
  },
  Task_147471_Desc = {
    Text = "暮星·汀克特达到人格深化12"
  },
  Task_147472_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_147474_Desc = {
    Text = "使用混沌界域唤醒体在「临时文本」中获胜2次"
  },
  Task_147475_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_147476_Desc = {
    Text = "完成「临时文本·通关」所有成就"
  },
  Task_147478_Desc = {
    Text = "完成意识潜游「临时文本」困难难度"
  },
  Task_147478_Name = {
    Text = "临时文本·困难"
  },
  Task_147483_Desc = {
    Text = "使用超维界域唤醒体在「临时文本」中获胜2次"
  },
  Task_147552_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_147553_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_147554_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_147555_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_147556_Desc = {
    Text = "通关「临时文本」癫狂难度"
  },
  Task_147557_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_147558_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_147559_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_147560_Desc = {
    Text = "通关「临时文本」癫狂难度"
  },
  Task_147561_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_147562_Desc = {
    Text = "通关「临时文本」癫狂难度"
  },
  Task_147563_Desc = {
    Text = "临时文本·癫狂"
  },
  Task_147564_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_147565_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_147566_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_147567_Desc = {
    Text = "通关「临时文本」癫狂难度"
  },
  Task_147568_Desc = {
    Text = "通关「临时文本」癫狂难度"
  },
  Task_147569_Desc = {
    Text = "临时文本·界域"
  },
  Task_147570_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_147571_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_147572_Desc = {
    Text = "通关「临时文本」癫狂难度"
  },
  Task_147573_Desc = {
    Text = "通关「临时文本」癫狂难度"
  },
  Task_147574_Desc = {
    Text = "临时文本·通关"
  },
  Task_147575_Desc = {
    Text = "通关「临时文本」任意难度"
  },
  Task_147676_Desc = {
    Text = "玩家等级到达2级"
  },
  Task_147676_Name = {
    Text = "（待包装）"
  },
  Task_147677_Desc = {
    Text = "拥有1名10级唤醒体"
  },
  Task_147677_Name = {
    Text = "（待包装）"
  },
  Task_147678_Desc = {
    Text = "完成调查事件「入学日」"
  },
  Task_147678_Name = {
    Text = "（待包装）"
  },
  Task_147679_Desc = {
    Text = "拥有5名唤醒体"
  },
  Task_147679_Name = {
    Text = "（待包装）"
  },
  Task_147894_Desc = {
    Text = "临时文本"
  },
  Task_147894_Name = {Text = "目标"},
  Task_147895_Desc = {
    Text = "完成调查事件「山宴」困难难度"
  },
  Task_147895_Name = {
    Text = "海拔8840米的安眠·困难"
  },
  Task_147896_Desc = {
    Text = "临时文本"
  },
  Task_147896_Name = {Text = "目标"},
  Task_147897_Desc = {
    Text = "临时文本"
  },
  Task_147897_Name = {Text = "目标"},
  Task_147898_Desc = {
    Text = "临时文本"
  },
  Task_147898_Name = {Text = "目标"},
  Task_147899_Desc = {
    Text = "临时文本"
  },
  Task_147899_Name = {Text = "目标"},
  Task_147900_Desc = {
    Text = "临时文本"
  },
  Task_147900_Name = {Text = "目标"},
  Task_147901_Desc = {
    Text = "临时文本"
  },
  Task_147901_Name = {Text = "目标"},
  Task_147902_Desc = {
    Text = "在调查事件「@1@2」中共鸣9次"
  },
  Task_147902_Desc2 = {
    Text = "在调查事件「山宴」中共鸣9次"
  },
  Task_147902_Name = {Text = "@1@2"},
  Task_147902_Name2 = {
    Text = "无谎者的七重礼拜Ⅳ"
  },
  Task_147903_Desc = {
    Text = "临时文本"
  },
  Task_147903_Name = {Text = "目标"},
  Task_147904_Desc = {
    Text = "临时文本"
  },
  Task_147904_Name = {Text = "目标"},
  Task_147905_Desc = {
    Text = "在调查事件「@1@2」中共鸣3次"
  },
  Task_147905_Desc2 = {
    Text = "在调查事件「山宴」中共鸣3次"
  },
  Task_147905_Name = {Text = "@1@2"},
  Task_147905_Name2 = {
    Text = "无谎者的七重礼拜"
  },
  Task_147906_Desc = {
    Text = "在调查事件「@1@2」中共鸣7次"
  },
  Task_147906_Desc2 = {
    Text = "在调查事件「山宴」中共鸣7次"
  },
  Task_147906_Name = {Text = "@1@2"},
  Task_147906_Name2 = {
    Text = "无谎者的七重礼拜Ⅲ"
  },
  Task_147907_Desc = {
    Text = "在调查事件「@1@2」中共鸣5次"
  },
  Task_147907_Desc2 = {
    Text = "在调查事件「山宴」中共鸣5次"
  },
  Task_147907_Name = {Text = "@1@2"},
  Task_147907_Name2 = {
    Text = "无谎者的七重礼拜Ⅱ"
  },
  Task_147908_Desc = {
    Text = "完成调查事件「@1@2」"
  },
  Task_147908_Desc2 = {
    Text = "完成调查事件「山宴」"
  },
  Task_147908_Name = {Text = "@1@2"},
  Task_147908_Name2 = {
    Text = "海拔8840米的安眠"
  },
  Task_147909_Desc = {
    Text = "临时文本"
  },
  Task_147909_Name = {Text = "目标"},
  Task_147910_Desc = {
    Text = "临时文本"
  },
  Task_147910_Name = {Text = "目标"},
  Task_148121_Desc = {
    Text = "完成 15 次派遣"
  },
  Task_148122_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_148123_Desc = {
    Text = "累计登录1天"
  },
  Task_148124_Desc = {
    Text = "唤醒 30 次"
  },
  Task_148125_Desc = {
    Text = "累计登录1天"
  },
  Task_148126_Desc = {
    Text = "完成「禁忌试炼」中任意赛季任务"
  },
  Task_148127_Desc = {
    Text = "完成「禁忌试炼」中任意赛季任务"
  },
  Task_148128_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_148129_Desc = {
    Text = "唤醒 30 次"
  },
  Task_148130_Desc = {
    Text = "完成 15 次派遣"
  },
  Task_148131_Desc = {
    Text = "使用助战 3 次"
  },
  Task_148132_Desc = {
    Text = "「精粹活性离子」达到1000"
  },
  Task_148133_Desc = {
    Text = "使用助战 3 次"
  },
  Task_148134_Desc = {
    Text = "累计打出300张牌"
  },
  Task_148135_Desc = {
    Text = "「精粹活性离子」达到1000"
  },
  Task_148136_Desc = {
    Text = "累计打出300张牌"
  },
  Task_148489_Desc = {
    Text = "完成意识潜游「五日谈」"
  },
  Task_148489_Name = {
    Text = "失乡者的凯旋"
  },
  Task_148490_Desc = {
    Text = "完成意识潜游「五日谈」困难难度"
  },
  Task_148490_Name = {
    Text = "失乡者的凯旋·困难"
  },
  Task_149335_Desc = {Text = "屠龙"},
  Task_149335_Name = {Text = "目标"},
  Task_149989_Desc = {
    Text = "通关星辰篇第6章 6-1"
  },
  Task_149990_Desc = {
    Text = "本源奥吉尔达到人格深化12"
  },
  Task_19734_Desc = {
    Text = "通关超维之旅·间隙Ⅵ"
  },
  Task_19735_Desc = {
    Text = "通关血肉之沼·间隙Ⅷ"
  },
  Task_19736_Desc = {
    Text = "通关超维之旅·间隙Ⅳ"
  },
  Task_19737_Desc = {
    Text = "通关血肉之沼·间隙Ⅱ"
  },
  Task_19738_Desc = {
    Text = "通关超维之旅·间隙Ⅱ"
  },
  Task_19739_Desc = {
    Text = "通关血肉之沼·间隙Ⅵ"
  },
  Task_19740_Desc = {
    Text = "设置陷阱，执行「狩猎」"
  },
  Task_19740_Name = {Text = "目标"},
  Task_19741_Desc = {
    Text = "通关超维之旅·间隙Ⅷ"
  },
  Task_19742_Desc = {
    Text = "通关深海之遗·间隙Ⅱ"
  },
  Task_19743_Desc = {
    Text = "通关混沌之域·间隙Ⅱ"
  },
  Task_19744_Desc = {
    Text = "通关深海之遗·间隙Ⅵ"
  },
  Task_19745_Desc = {
    Text = "通关混沌之域·间隙Ⅳ"
  },
  Task_19746_Desc = {
    Text = "通关深海之遗·间隙Ⅳ"
  },
  Task_19747_Desc = {
    Text = "通关混沌之域·间隙Ⅵ"
  },
  Task_19748_Desc = {
    Text = "通关混沌之域·间隙Ⅷ"
  },
  Task_19749_Desc = {
    Text = "通关深海之遗·间隙Ⅷ"
  },
  Task_19750_Desc = {
    Text = "设置陷阱，执行「狩猎」"
  },
  Task_19750_Name = {Text = "目标"},
  Task_19751_Desc = {
    Text = "协助萝坦追击敌人"
  },
  Task_19751_Name = {Text = "目标"},
  Task_19752_Desc = {
    Text = "通关血肉之沼·间隙Ⅳ"
  },
  Task_20972_Desc = {
    Text = "通关超维之旅间隙Ⅰ"
  },
  Task_20973_Desc = {
    Text = "通关深海之遗间隙Ⅰ"
  },
  Task_20990_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_20990_Name = {
    Text = "速战速决"
  },
  Task_20991_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_20991_Name = {
    Text = "完美通过"
  },
  Task_20992_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_20992_Name = {
    Text = "完美通过"
  },
  Task_20993_Desc = {
    Text = "最终战中一回合狂气爆发至少4次"
  },
  Task_20993_Name = {
    Text = "致命魔术"
  },
  Task_20994_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_20994_Name = {
    Text = "完美通过"
  },
  Task_20995_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_20995_Name = {
    Text = "完美通过"
  },
  Task_20996_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_20996_Name = {
    Text = "优雅而精准"
  },
  Task_20997_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_20997_Name = {
    Text = "速战速决"
  },
  Task_20998_Desc = {
    Text = "最终战一回合额外抽取至少5张牌"
  },
  Task_20998_Name = {Text = "抽卡！"},
  Task_20999_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_20999_Name = {
    Text = "完美通过"
  },
  Task_21000_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21000_Name = {
    Text = "速战速决"
  },
  Task_21001_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21001_Name = {
    Text = "完美通过"
  },
  Task_21002_Desc = {
    Text = "通关时觉醒所有唤醒体"
  },
  Task_21002_Name = {
    Text = "无限抱拥"
  },
  Task_21003_Desc = {
    Text = "获得至少4种不同种类刻印"
  },
  Task_21003_Name = {
    Text = "灵魂烙印"
  },
  Task_21004_Desc = {
    Text = "精英战中一回合造成至少240点伤害"
  },
  Task_21004_Name = {
    Text = "全力一击"
  },
  Task_21005_Desc = {
    Text = "通关时不使用联络点回复生命"
  },
  Task_21005_Name = {
    Text = "无火之人"
  },
  Task_21006_Desc = {
    Text = "通关时症状卡不多于3张"
  },
  Task_21006_Name = {
    Text = "节能主义"
  },
  Task_21007_Desc = {
    Text = "通关时携带至少1个诅咒造物"
  },
  Task_21007_Name = {
    Text = "奇兵秘藏"
  },
  Task_21008_Desc = {
    Text = "通关时症状卡不多于1张"
  },
  Task_21008_Name = {
    Text = "节能主义"
  },
  Task_21009_Desc = {
    Text = "最终战一回合打出至少4张卡牌"
  },
  Task_21009_Name = {
    Text = "我的回合"
  },
  Task_21010_Desc = {
    Text = "探索度达到100%"
  },
  Task_21010_Name = {
    Text = "俯瞰雾境"
  },
  Task_21011_Desc = {
    Text = "通关时携带至少5个造物"
  },
  Task_21011_Name = {
    Text = "奇兵秘藏"
  },
  Task_21012_Desc = {
    Text = "通关时携带至少5个造物"
  },
  Task_21012_Name = {
    Text = "奇兵秘藏"
  },
  Task_21013_Desc = {
    Text = "通关时携带至少5个造物"
  },
  Task_21013_Name = {
    Text = "奇兵秘藏"
  },
  Task_21014_Desc = {
    Text = "最终战一回合至少叠加最大生命50%的护盾"
  },
  Task_21014_Name = {
    Text = "钢铁之躯"
  },
  Task_21015_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21015_Name = {
    Text = "完美通过"
  },
  Task_21016_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21016_Name = {
    Text = "优雅而精准"
  },
  Task_21017_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21017_Name = {
    Text = "完美通过"
  },
  Task_21018_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21018_Name = {
    Text = "优雅而精准"
  },
  Task_21019_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21019_Name = {
    Text = "优雅而精准"
  },
  Task_21020_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21020_Name = {
    Text = "完美通过"
  },
  Task_21021_Desc = {
    Text = "最终战不超过15回合取胜"
  },
  Task_21021_Name = {
    Text = "速战速决"
  },
  Task_21022_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21022_Name = {
    Text = "完美通过"
  },
  Task_21023_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_21023_Name = {
    Text = "节能主义"
  },
  Task_21024_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21024_Name = {
    Text = "完美通过"
  },
  Task_21025_Desc = {
    Text = "最终战中一回合狂气爆发至少4次"
  },
  Task_21025_Name = {
    Text = "致命魔术"
  },
  Task_21026_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21026_Name = {
    Text = "完美通过"
  },
  Task_21027_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21027_Name = {
    Text = "速战速决"
  },
  Task_21028_Desc = {
    Text = "最终战不超过15回合取胜"
  },
  Task_21028_Name = {
    Text = "速战速决"
  },
  Task_21029_Desc = {
    Text = "最终战一回合打出至少6张卡牌"
  },
  Task_21029_Name = {
    Text = "我的回合"
  },
  Task_21030_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21030_Name = {
    Text = "完美通过"
  },
  Task_21032_Desc = {
    Text = "最终战中一回合造成至少40000点伤害"
  },
  Task_21032_Name = {
    Text = "全力一击"
  },
  Task_21033_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21033_Name = {
    Text = "完美通过"
  },
  Task_21034_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21034_Name = {
    Text = "完美通过"
  },
  Task_21035_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_21035_Name = {
    Text = "速战速决"
  },
  Task_21036_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21036_Name = {
    Text = "完美通过"
  },
  Task_21037_Desc = {
    Text = "通关时症状卡不多于1张"
  },
  Task_21037_Name = {
    Text = "节能主义"
  },
  Task_21038_Desc = {
    Text = "最终战一回合打出至少4张卡牌"
  },
  Task_21038_Name = {
    Text = "我的回合"
  },
  Task_21039_Desc = {
    Text = "探索度达到100%"
  },
  Task_21039_Name = {
    Text = "俯瞰雾境"
  },
  Task_21040_Desc = {
    Text = "通关时携带至少5个造物"
  },
  Task_21040_Name = {
    Text = "奇兵秘藏"
  },
  Task_21041_Desc = {
    Text = "通关时携带至少5个造物"
  },
  Task_21041_Name = {
    Text = "奇兵秘藏"
  },
  Task_21042_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21042_Name = {
    Text = "优雅而精准"
  },
  Task_21043_Desc = {
    Text = "最终战一回合至少叠加最大生命50%的护盾"
  },
  Task_21043_Name = {
    Text = "钢铁之躯"
  },
  Task_21044_Desc = {
    Text = "获得至少4种不同种类刻印"
  },
  Task_21044_Name = {
    Text = "灵魂烙印"
  },
  Task_21045_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21045_Name = {
    Text = "优雅而精准"
  },
  Task_21046_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21046_Name = {
    Text = "速战速决"
  },
  Task_21047_Desc = {
    Text = "最终战中一回合狂气爆发至少4次"
  },
  Task_21047_Name = {
    Text = "致命魔术"
  },
  Task_21048_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21048_Name = {
    Text = "完美通过"
  },
  Task_21049_Desc = {
    Text = "通关时症状卡不多于1张"
  },
  Task_21049_Name = {
    Text = "节能主义"
  },
  Task_21050_Desc = {
    Text = "通关时觉醒所有唤醒体"
  },
  Task_21050_Name = {
    Text = "无限抱拥"
  },
  Task_21051_Desc = {
    Text = "通关时携带至少2个造物"
  },
  Task_21051_Name = {
    Text = "奇兵秘藏"
  },
  Task_21052_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21052_Name = {
    Text = "完美通过"
  },
  Task_21053_Desc = {
    Text = "获得至少4种不同种类刻印"
  },
  Task_21053_Name = {
    Text = "灵魂烙印"
  },
  Task_21054_Desc = {
    Text = "获得至少4种不同种类刻印"
  },
  Task_21054_Name = {
    Text = "灵魂烙印"
  },
  Task_21055_Desc = {
    Text = "精英战中一回合造成至少980点伤害"
  },
  Task_21055_Name = {
    Text = "全力一击"
  },
  Task_21056_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21056_Name = {
    Text = "优雅而精准"
  },
  Task_21057_Desc = {
    Text = "通关时症状卡不多于3张"
  },
  Task_21057_Name = {
    Text = "节能主义"
  },
  Task_21058_Desc = {
    Text = "通关时携带至少1个诅咒造物"
  },
  Task_21058_Name = {
    Text = "奇兵秘藏"
  },
  Task_21059_Desc = {
    Text = "探索度达到100%"
  },
  Task_21059_Name = {
    Text = "俯瞰雾境"
  },
  Task_21060_Desc = {
    Text = "精英战中一回合使用至少3次狂气爆发"
  },
  Task_21060_Name = {
    Text = "致命魔术"
  },
  Task_21061_Desc = {
    Text = "最终战一回合额外抽取至少5张牌"
  },
  Task_21061_Name = {Text = "抽卡！"},
  Task_21062_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_21062_Name = {
    Text = "速战速决"
  },
  Task_21063_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21063_Name = {
    Text = "完美通过"
  },
  Task_21064_Desc = {
    Text = "通关时携带至少2个造物"
  },
  Task_21064_Name = {
    Text = "奇兵秘藏"
  },
  Task_21065_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_21065_Name = {
    Text = "节能主义"
  },
  Task_21066_Desc = {
    Text = "获得至少3种类型的刻印"
  },
  Task_21066_Name = {
    Text = "灵魂烙印"
  },
  Task_21067_Desc = {
    Text = "通关时觉醒唤醒体大于等于2"
  },
  Task_21067_Name = {
    Text = "无限抱拥"
  },
  Task_21068_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21068_Name = {
    Text = "优雅而精准"
  },
  Task_21069_Desc = {
    Text = "通关时携带至少1个诅咒造物"
  },
  Task_21069_Name = {
    Text = "奇兵秘藏"
  },
  Task_21070_Desc = {
    Text = "最终战一回合打出至少4张卡牌"
  },
  Task_21070_Name = {
    Text = "我的回合"
  },
  Task_21071_Desc = {
    Text = "最终战中一回合狂气爆发至少3次"
  },
  Task_21071_Name = {
    Text = "致命魔术"
  },
  Task_21072_Desc = {
    Text = "通关时症状卡不多于3张"
  },
  Task_21072_Name = {
    Text = "节能主义"
  },
  Task_21073_Desc = {
    Text = "通关时症状卡不多于1张"
  },
  Task_21073_Name = {
    Text = "节能主义"
  },
  Task_21074_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21074_Name = {
    Text = "完美通过"
  },
  Task_21075_Desc = {
    Text = "拥有4种不同类型刻印"
  },
  Task_21075_Name = {
    Text = "灵魂烙印"
  },
  Task_21076_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21076_Name = {
    Text = "速战速决"
  },
  Task_21077_Desc = {
    Text = "最终战一回合打出至少5张卡牌"
  },
  Task_21077_Name = {
    Text = "我的回合"
  },
  Task_21078_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21078_Name = {
    Text = "完美通过"
  },
  Task_21079_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21079_Name = {
    Text = "完美通过"
  },
  Task_21080_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21080_Name = {
    Text = "完美通过"
  },
  Task_21081_Desc = {
    Text = "最终战一回合造成350点伤害"
  },
  Task_21081_Name = {
    Text = "全力一击"
  },
  Task_21082_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21082_Name = {
    Text = "速战速决"
  },
  Task_21083_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21083_Name = {
    Text = "速战速决"
  },
  Task_21084_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21084_Name = {
    Text = "完美通过"
  },
  Task_21085_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21085_Name = {
    Text = "完美通过"
  },
  Task_21086_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_21086_Name = {
    Text = "节能主义"
  },
  Task_21087_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21087_Name = {
    Text = "速战速决"
  },
  Task_21088_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21088_Name = {
    Text = "速战速决"
  },
  Task_21089_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21089_Name = {
    Text = "完美通过"
  },
  Task_21090_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21090_Name = {
    Text = "速战速决"
  },
  Task_21091_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21091_Name = {
    Text = "速战速决"
  },
  Task_21092_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21092_Name = {
    Text = "速战速决"
  },
  Task_21093_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21093_Name = {
    Text = "速战速决"
  },
  Task_21094_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21094_Name = {
    Text = "速战速决"
  },
  Task_21095_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_21095_Name = {
    Text = "速战速决"
  },
  Task_21096_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_21096_Name = {
    Text = "速战速决"
  },
  Task_21097_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_21097_Name = {
    Text = "速战速决"
  },
  Task_21098_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_21098_Name = {
    Text = "速战速决"
  },
  Task_21099_Desc = {
    Text = "通关时携带至少1个诅咒造物"
  },
  Task_21099_Name = {
    Text = "奇兵秘藏"
  },
  Task_21100_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21100_Name = {
    Text = "优雅而精准"
  },
  Task_21101_Desc = {
    Text = "任一战斗中一回合击杀至少2个怪物"
  },
  Task_21101_Name = {
    Text = "斩草除根"
  },
  Task_21102_Desc = {
    Text = "通关时携带至少8个造物"
  },
  Task_21102_Name = {
    Text = "奇兵秘藏"
  },
  Task_21103_Desc = {
    Text = "通关时症状卡不多于1张"
  },
  Task_21103_Name = {
    Text = "节能主义"
  },
  Task_21104_Desc = {
    Text = "最终战一回合打出至少5张卡牌"
  },
  Task_21104_Name = {
    Text = "我的回合"
  },
  Task_21105_Desc = {
    Text = "最终战中一回合造成至少300点伤害"
  },
  Task_21105_Name = {
    Text = "全力一击"
  },
  Task_21106_Desc = {
    Text = "最终战一回合额外抽取至少3张牌"
  },
  Task_21106_Name = {Text = "抽卡！"},
  Task_21107_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21107_Name = {
    Text = "完美通过"
  },
  Task_21108_Desc = {
    Text = "最终战中一回合造成至少96000点伤害"
  },
  Task_21108_Name = {
    Text = "全力一击"
  },
  Task_21110_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_21110_Name = {
    Text = "节能主义"
  },
  Task_21111_Desc = {
    Text = "通关时症状卡不多于1张"
  },
  Task_21111_Name = {
    Text = "节能主义"
  },
  Task_21112_Desc = {
    Text = "任一战斗中一回合击杀至少2只怪物"
  },
  Task_21112_Name = {
    Text = "斩草除根"
  },
  Task_21113_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21113_Name = {
    Text = "完美通过"
  },
  Task_21114_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21114_Name = {
    Text = "速战速决"
  },
  Task_21115_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_21115_Name = {
    Text = "节能主义"
  },
  Task_21116_Desc = {
    Text = "通关时生命不低于80%"
  },
  Task_21116_Name = {
    Text = "优雅而精准"
  },
  Task_21117_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21117_Name = {
    Text = "完美通过"
  },
  Task_21118_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_21118_Name = {
    Text = "速战速决"
  },
  Task_21119_Desc = {
    Text = "通关时症状卡不多于1张"
  },
  Task_21119_Name = {
    Text = "节能主义"
  },
  Task_21120_Desc = {
    Text = "任一战斗中一回合击杀至少2只怪物"
  },
  Task_21120_Name = {
    Text = "斩草除根"
  },
  Task_21121_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_21121_Name = {
    Text = "节能主义"
  },
  Task_21122_Desc = {
    Text = "精英战中一回合造成至少1600点伤害"
  },
  Task_21122_Name = {
    Text = "全力一击"
  },
  Task_21123_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21123_Name = {
    Text = "速战速决"
  },
  Task_21124_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21124_Name = {
    Text = "完美通过"
  },
  Task_21125_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21125_Name = {
    Text = "完美通过"
  },
  Task_21126_Desc = {
    Text = "精英战中一回合使用至少3次狂气爆发"
  },
  Task_21126_Name = {
    Text = "致命魔术"
  },
  Task_21127_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_21127_Name = {
    Text = "速战速决"
  },
  Task_21128_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21128_Name = {
    Text = "完美通过"
  },
  Task_21129_Desc = {
    Text = "通关时症状卡不多于1张"
  },
  Task_21129_Name = {
    Text = "节能主义"
  },
  Task_21130_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21130_Name = {
    Text = "完美通过"
  },
  Task_21131_Desc = {
    Text = "通关时觉醒所有唤醒体"
  },
  Task_21131_Name = {
    Text = "无限抱拥"
  },
  Task_21132_Desc = {
    Text = "最终战中一回合造成至少6000点伤害"
  },
  Task_21132_Name = {
    Text = "全力一击"
  },
  Task_21133_Desc = {
    Text = "最终战一回合额外抽取至少5张牌"
  },
  Task_21133_Name = {Text = "抽卡！"},
  Task_21134_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21134_Name = {
    Text = "完美通过"
  },
  Task_21135_Desc = {
    Text = "最终战一回合额外抽取至少4张牌"
  },
  Task_21135_Name = {Text = "抽卡！"},
  Task_21136_Desc = {
    Text = "最终战不超过15回合取胜"
  },
  Task_21136_Name = {
    Text = "速战速决"
  },
  Task_21137_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_21137_Name = {
    Text = "速战速决"
  },
  Task_21138_Desc = {
    Text = "精英战中一回合造成至少1800点伤害"
  },
  Task_21138_Name = {
    Text = "全力一击"
  },
  Task_21139_Desc = {
    Text = "通关时携带至少1个诅咒造物"
  },
  Task_21139_Name = {
    Text = "奇兵秘藏"
  },
  Task_21140_Desc = {
    Text = "最终战一回合打出至少5张卡牌"
  },
  Task_21140_Name = {
    Text = "我的回合"
  },
  Task_21141_Desc = {
    Text = "最终战一回合至少叠加最大生命65%的护盾"
  },
  Task_21141_Name = {
    Text = "钢铁之躯"
  },
  Task_21142_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_21142_Name = {
    Text = "节能主义"
  },
  Task_21143_Desc = {
    Text = "获得至少4种不同种类刻印"
  },
  Task_21143_Name = {
    Text = "灵魂烙印"
  },
  Task_21144_Desc = {
    Text = "通关时携带至少2个造物"
  },
  Task_21144_Name = {
    Text = "奇兵秘藏"
  },
  Task_21145_Desc = {
    Text = "通关时使用联络点回复生命不多于1次"
  },
  Task_21145_Name = {
    Text = "无火之人"
  },
  Task_21146_Desc = {
    Text = "通关时携带至少1个诅咒造物"
  },
  Task_21146_Name = {
    Text = "奇兵秘藏"
  },
  Task_21147_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_21147_Name = {
    Text = "节能主义"
  },
  Task_21148_Desc = {
    Text = "精英战中一回合造成至少500点伤害"
  },
  Task_21148_Name = {
    Text = "全力一击"
  },
  Task_21149_Desc = {
    Text = "任一战斗中一回合击杀至少2只怪物"
  },
  Task_21149_Name = {
    Text = "斩草除根"
  },
  Task_21150_Desc = {
    Text = "觉醒至少3个唤醒体"
  },
  Task_21150_Name = {
    Text = "无限抱拥"
  },
  Task_21151_Desc = {
    Text = "获得至少4种不同种类刻印"
  },
  Task_21151_Name = {
    Text = "灵魂烙印"
  },
  Task_21152_Desc = {
    Text = "探索度达到100%"
  },
  Task_21152_Name = {
    Text = "俯瞰雾境"
  },
  Task_21153_Desc = {
    Text = "最终战中一回合狂气爆发至少4次"
  },
  Task_21153_Name = {
    Text = "致命魔术"
  },
  Task_21154_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_21154_Name = {
    Text = "节能主义"
  },
  Task_21155_Desc = {
    Text = "最终战一回合至少叠加最大生命60%的护盾"
  },
  Task_21155_Name = {
    Text = "钢铁之躯"
  },
  Task_21156_Desc = {
    Text = "通关时携带至少8个造物"
  },
  Task_21156_Name = {
    Text = "奇兵秘藏"
  },
  Task_21157_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21157_Name = {
    Text = "优雅而精准"
  },
  Task_21158_Desc = {
    Text = "最终战一回合额外抽取至少4张牌"
  },
  Task_21158_Name = {Text = "抽卡！"},
  Task_21159_Desc = {
    Text = "最终战中一回合造成至少5200点伤害"
  },
  Task_21159_Name = {
    Text = "全力一击"
  },
  Task_21160_Desc = {
    Text = "最终战一回合额外抽取至少3张牌"
  },
  Task_21160_Name = {Text = "抽卡！"},
  Task_21161_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21161_Name = {
    Text = "完美通过"
  },
  Task_21162_Desc = {
    Text = "最终战一回合至少叠加最大生命65%的护盾"
  },
  Task_21162_Name = {
    Text = "钢铁之躯"
  },
  Task_21163_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_21163_Name = {
    Text = "节能主义"
  },
  Task_21164_Desc = {
    Text = "通关时携带至少1个诅咒造物"
  },
  Task_21164_Name = {
    Text = "奇兵秘藏"
  },
  Task_21165_Desc = {
    Text = "最终战一回合打出至少4张卡牌"
  },
  Task_21165_Name = {
    Text = "我的回合"
  },
  Task_21166_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21166_Name = {
    Text = "完美通过"
  },
  Task_21167_Desc = {
    Text = "拥有4种不同类型刻印"
  },
  Task_21167_Name = {
    Text = "灵魂烙印"
  },
  Task_21168_Desc = {
    Text = "最终战一回合造成120点伤害"
  },
  Task_21168_Name = {
    Text = "全力一击"
  },
  Task_21169_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21169_Name = {
    Text = "优雅而精准"
  },
  Task_21170_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21170_Name = {
    Text = "优雅而精准"
  },
  Task_21171_Desc = {
    Text = "任一战斗中一回合击杀至少2个怪物"
  },
  Task_21171_Name = {
    Text = "斩草除根"
  },
  Task_21172_Desc = {
    Text = "最终战一回合额外抽取至少3张牌"
  },
  Task_21172_Name = {Text = "抽卡！"},
  Task_21173_Desc = {
    Text = "觉醒至少3个唤醒体"
  },
  Task_21173_Name = {
    Text = "无限抱拥"
  },
  Task_21174_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21174_Name = {
    Text = "优雅而精准"
  },
  Task_21176_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21176_Name = {
    Text = "速战速决"
  },
  Task_21177_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21177_Name = {
    Text = "速战速决"
  },
  Task_21178_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_21178_Name = {
    Text = "节能主义"
  },
  Task_21179_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21179_Name = {
    Text = "完美通过"
  },
  Task_21180_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21180_Name = {
    Text = "完美通过"
  },
  Task_21181_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21181_Name = {
    Text = "完美通过"
  },
  Task_21182_Desc = {
    Text = "通关时症状卡不多于1张"
  },
  Task_21182_Name = {
    Text = "节能主义"
  },
  Task_21183_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_21183_Name = {
    Text = "节能主义"
  },
  Task_21184_Desc = {
    Text = "探索度达到100%"
  },
  Task_21184_Name = {
    Text = "俯瞰雾境"
  },
  Task_21185_Desc = {
    Text = "最终战中一回合造成至少1000点伤害"
  },
  Task_21185_Name = {
    Text = "全力一击"
  },
  Task_21186_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21186_Name = {
    Text = "速战速决"
  },
  Task_21187_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_21187_Name = {
    Text = "速战速决"
  },
  Task_21188_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_21188_Name = {
    Text = "速战速决"
  },
  Task_21189_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21189_Name = {
    Text = "速战速决"
  },
  Task_21190_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21190_Name = {
    Text = "速战速决"
  },
  Task_21191_Desc = {
    Text = "通关时症状卡不多于1张"
  },
  Task_21191_Name = {
    Text = "节能主义"
  },
  Task_21192_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_21192_Name = {
    Text = "速战速决"
  },
  Task_21193_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_21193_Name = {
    Text = "速战速决"
  },
  Task_21194_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_21194_Name = {
    Text = "速战速决"
  },
  Task_21195_Desc = {
    Text = "最终战中一回合造成至少7300点伤害"
  },
  Task_21195_Name = {
    Text = "全力一击"
  },
  Task_21196_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_21196_Name = {
    Text = "速战速决"
  },
  Task_21197_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21197_Name = {
    Text = "优雅而精准"
  },
  Task_21198_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21198_Name = {
    Text = "速战速决"
  },
  Task_21199_Desc = {
    Text = "最终战一回合打出至少4张卡牌"
  },
  Task_21199_Name = {
    Text = "我的回合"
  },
  Task_21200_Desc = {
    Text = "通关时症状卡不多于3张"
  },
  Task_21200_Name = {
    Text = "节能主义"
  },
  Task_21201_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21201_Name = {
    Text = "完美通过"
  },
  Task_21202_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21202_Name = {
    Text = "完美通过"
  },
  Task_21203_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21203_Name = {
    Text = "完美通过"
  },
  Task_21204_Desc = {
    Text = "通关时携带至少2个造物"
  },
  Task_21204_Name = {
    Text = "奇兵秘藏"
  },
  Task_21205_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_21205_Name = {
    Text = "节能主义"
  },
  Task_21206_Desc = {
    Text = "获得至少3种类型的刻印"
  },
  Task_21206_Name = {
    Text = "灵魂烙印"
  },
  Task_21207_Desc = {
    Text = "通关时觉醒唤醒体大于等于2"
  },
  Task_21207_Name = {
    Text = "无限抱拥"
  },
  Task_21208_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21208_Name = {
    Text = "优雅而精准"
  },
  Task_21209_Desc = {
    Text = "通关时携带至少1个诅咒造物"
  },
  Task_21209_Name = {
    Text = "奇兵秘藏"
  },
  Task_21210_Desc = {
    Text = "最终战一回合打出至少4张卡牌"
  },
  Task_21210_Name = {
    Text = "我的回合"
  },
  Task_21211_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21211_Name = {
    Text = "完美通过"
  },
  Task_21212_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21212_Name = {
    Text = "速战速决"
  },
  Task_21213_Desc = {
    Text = "最终战中一回合造成至少2500点伤害"
  },
  Task_21213_Name = {
    Text = "全力一击"
  },
  Task_21214_Desc = {
    Text = "最终战一回合额外抽取至少5张牌"
  },
  Task_21214_Name = {Text = "抽卡！"},
  Task_21215_Desc = {
    Text = "最终战一回合打出至少6张卡牌"
  },
  Task_21215_Name = {
    Text = "我的回合"
  },
  Task_21216_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21216_Name = {
    Text = "优雅而精准"
  },
  Task_21217_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21217_Name = {
    Text = "优雅而精准"
  },
  Task_21218_Desc = {
    Text = "通关时觉醒所有唤醒体"
  },
  Task_21218_Name = {
    Text = "无限抱拥"
  },
  Task_21219_Desc = {
    Text = "最终战一回合额外抽取至少3张牌"
  },
  Task_21219_Name = {Text = "抽卡！"},
  Task_21220_Desc = {
    Text = "觉醒至少3个唤醒体"
  },
  Task_21220_Name = {
    Text = "无限抱拥"
  },
  Task_21221_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21221_Name = {
    Text = "优雅而精准"
  },
  Task_21222_Desc = {
    Text = "通关时携带至少1个诅咒造物"
  },
  Task_21222_Name = {
    Text = "奇兵秘藏"
  },
  Task_21223_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21223_Name = {
    Text = "完美通过"
  },
  Task_21224_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21224_Name = {
    Text = "完美通过"
  },
  Task_21225_Desc = {
    Text = "任一战斗中一回合击杀至少2只怪物"
  },
  Task_21225_Name = {
    Text = "斩草除根"
  },
  Task_21226_Desc = {
    Text = "通关时携带至少2个造物"
  },
  Task_21226_Name = {
    Text = "奇兵秘藏"
  },
  Task_21227_Desc = {
    Text = "获得至少4种不同种类刻印"
  },
  Task_21227_Name = {
    Text = "灵魂烙印"
  },
  Task_21228_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21228_Name = {
    Text = "完美通过"
  },
  Task_21229_Desc = {
    Text = "通关时不使用联络点回复生命"
  },
  Task_21229_Name = {
    Text = "无火之人"
  },
  Task_21230_Desc = {
    Text = "探索度达到100%"
  },
  Task_21230_Name = {
    Text = "俯瞰雾境"
  },
  Task_21231_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21231_Name = {
    Text = "速战速决"
  },
  Task_21232_Desc = {
    Text = "通关时使用联络点回复生命不多于1次"
  },
  Task_21232_Name = {
    Text = "无火之人"
  },
  Task_21233_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21233_Name = {
    Text = "完美通过"
  },
  Task_21234_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21234_Name = {
    Text = "完美通过"
  },
  Task_21235_Desc = {
    Text = "最终战一回合额外抽取至少4张牌"
  },
  Task_21235_Name = {Text = "抽卡！"},
  Task_21236_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21236_Name = {
    Text = "速战速决"
  },
  Task_21237_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21237_Name = {
    Text = "速战速决"
  },
  Task_21238_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21238_Name = {
    Text = "完美通过"
  },
  Task_21239_Desc = {
    Text = "最终战中一回合狂气爆发至少3次"
  },
  Task_21239_Name = {
    Text = "致命魔术"
  },
  Task_21240_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21240_Name = {
    Text = "完美通过"
  },
  Task_21241_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21241_Name = {
    Text = "完美通过"
  },
  Task_21242_Desc = {
    Text = "通关时生命不低于80%"
  },
  Task_21242_Name = {
    Text = "优雅而精准"
  },
  Task_21243_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21243_Name = {
    Text = "速战速决"
  },
  Task_21244_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21244_Name = {
    Text = "速战速决"
  },
  Task_21245_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21245_Name = {
    Text = "速战速决"
  },
  Task_21246_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21246_Name = {
    Text = "速战速决"
  },
  Task_21247_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21247_Name = {
    Text = "速战速决"
  },
  Task_21248_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21248_Name = {
    Text = "速战速决"
  },
  Task_21249_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21249_Name = {
    Text = "速战速决"
  },
  Task_21250_Desc = {
    Text = "最终战不超过15回合取胜"
  },
  Task_21250_Name = {
    Text = "速战速决"
  },
  Task_21251_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21251_Name = {
    Text = "速战速决"
  },
  Task_21252_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21252_Name = {
    Text = "速战速决"
  },
  Task_21253_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21253_Name = {
    Text = "速战速决"
  },
  Task_21254_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21254_Name = {
    Text = "优雅而精准"
  },
  Task_21255_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21255_Name = {
    Text = "速战速决"
  },
  Task_21256_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21256_Name = {
    Text = "速战速决"
  },
  Task_21257_Desc = {
    Text = "精英战中一回合造成至少6000点伤害"
  },
  Task_21257_Name = {
    Text = "全力一击"
  },
  Task_21258_Desc = {
    Text = "通关时携带至少1个诅咒造物"
  },
  Task_21258_Name = {
    Text = "奇兵秘藏"
  },
  Task_21259_Desc = {
    Text = "最终战一回合打出至少5张卡牌"
  },
  Task_21259_Name = {
    Text = "我的回合"
  },
  Task_21260_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21260_Name = {
    Text = "完美通过"
  },
  Task_21261_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21261_Name = {
    Text = "完美通过"
  },
  Task_21262_Desc = {
    Text = "获得至少4种不同种类刻印"
  },
  Task_21262_Name = {
    Text = "灵魂烙印"
  },
  Task_21263_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21263_Name = {
    Text = "完美通过"
  },
  Task_21264_Desc = {
    Text = "通关时携带至少2个造物"
  },
  Task_21264_Name = {
    Text = "奇兵秘藏"
  },
  Task_21265_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21265_Name = {
    Text = "速战速决"
  },
  Task_21266_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21266_Name = {
    Text = "完美通过"
  },
  Task_21267_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21267_Name = {
    Text = "完美通过"
  },
  Task_21268_Desc = {
    Text = "觉醒至少3个唤醒体"
  },
  Task_21268_Name = {
    Text = "无限抱拥"
  },
  Task_21269_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21269_Name = {
    Text = "完美通过"
  },
  Task_21270_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21270_Name = {
    Text = "速战速决"
  },
  Task_21271_Desc = {
    Text = "通关时携带至少5个造物"
  },
  Task_21271_Name = {
    Text = "奇兵秘藏"
  },
  Task_21272_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21272_Name = {
    Text = "速战速决"
  },
  Task_21273_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_21273_Name = {
    Text = "速战速决"
  },
  Task_21274_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21274_Name = {
    Text = "完美通过"
  },
  Task_21275_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_21275_Name = {
    Text = "速战速决"
  },
  Task_21276_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21276_Name = {
    Text = "完美通过"
  },
  Task_21277_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21277_Name = {
    Text = "速战速决"
  },
  Task_21278_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21278_Name = {
    Text = "完美通过"
  },
  Task_21279_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21279_Name = {
    Text = "完美通过"
  },
  Task_21280_Desc = {
    Text = "通关时觉醒所有唤醒体"
  },
  Task_21280_Name = {
    Text = "无限抱拥"
  },
  Task_21281_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_21281_Name = {
    Text = "节能主义"
  },
  Task_21282_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21282_Name = {
    Text = "完美通过"
  },
  Task_21283_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21283_Name = {
    Text = "完美通过"
  },
  Task_21284_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21284_Name = {
    Text = "完美通过"
  },
  Task_21285_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21285_Name = {
    Text = "完美通过"
  },
  Task_21286_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21286_Name = {
    Text = "完美通过"
  },
  Task_21287_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21287_Name = {
    Text = "完美通过"
  },
  Task_21288_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21288_Name = {
    Text = "完美通过"
  },
  Task_21289_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21289_Name = {
    Text = "完美通过"
  },
  Task_21290_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21290_Name = {
    Text = "完美通过"
  },
  Task_21291_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21291_Name = {
    Text = "完美通过"
  },
  Task_21292_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21292_Name = {
    Text = "完美通过"
  },
  Task_21293_Desc = {
    Text = "最终战不超过15回合取胜"
  },
  Task_21293_Name = {
    Text = "速战速决"
  },
  Task_21294_Desc = {
    Text = "最终战一回合至少叠加最大生命60%的护盾"
  },
  Task_21294_Name = {
    Text = "钢铁之躯"
  },
  Task_21295_Desc = {
    Text = "通关时觉醒所有唤醒体"
  },
  Task_21295_Name = {
    Text = "无限抱拥"
  },
  Task_21296_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_21296_Name = {
    Text = "优雅而精准"
  },
  Task_21297_Desc = {
    Text = "最终战一回合额外抽取至少4张牌"
  },
  Task_21297_Name = {Text = "抽卡！"},
  Task_21298_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_21298_Name = {
    Text = "速战速决"
  },
  Task_21299_Desc = {
    Text = "最终战不超过15回合取胜"
  },
  Task_21299_Name = {
    Text = "速战速决"
  },
  Task_21300_Desc = {
    Text = "吱吱，吱吱……！！"
  },
  Task_21300_Name = {Text = "吱吱"},
  Task_21301_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_21301_Name = {
    Text = "完美通过"
  },
  Task_21401_Desc = {
    Text = "打出50张卡牌"
  },
  Task_21401_Name = {
    Text = "每日试训"
  },
  Task_21794_Desc = {
    Text = "累计登录 3 天"
  },
  Task_21795_Desc = {
    Text = "累计登录 7 天"
  },
  Task_21821_Desc = {
    Text = "初始40分，超过3回合后每回合减5分"
  },
  Task_21821_Name = {
    Text = "精英回合数  <size=20><color=#747474>初始40分，超过3回合后每回合减5分</color></size>"
  },
  Task_21822_Desc = {
    Text = "初始40分，通关时步数超过40步后每步减2分"
  },
  Task_21822_Name = {
    Text = "累计步数  <size=20><color=#747474>初始40分，通关时超过40步后每步减2分</color></size>"
  },
  Task_21823_Desc = {
    Text = "初始600分，超过12回合后每回合减60分"
  },
  Task_21823_Name = {
    Text = "最终战回合数  <size=20><color=#747474>初始600分，超过12回合后每回合减60分</color></size>"
  },
  Task_21824_Desc = {
    Text = "每场初始30分，超过2回合后每回合减3分"
  },
  Task_21824_Name = {
    Text = "战斗回合数  <size=20><color=#747474>每场初始30分，超过2回合后每回合减3分</color></size>"
  },
  Task_21907_Desc = {
    Text = "累计唤醒50次"
  },
  Task_21908_Desc = {
    Text = "累计唤醒300次"
  },
  Task_21914_Desc = {
    Text = "调查等级达到 40 级"
  },
  Task_21915_Desc = {
    Text = "完成「调查行动」第1章"
  },
  Task_21916_Desc = {
    Text = "调查等级达到 30 级"
  },
  Task_21917_Desc = {
    Text = "调查等级达到 20 级"
  },
  Task_21918_Desc = {
    Text = "调查等级达到 50 级"
  },
  Task_22347_Desc = {
    Text = "击败尤乌哈希"
  },
  Task_22347_Name = {Text = "目标"},
  Task_22348_Desc = {
    Text = "控制冲动的奥古斯特"
  },
  Task_22348_Name = {Text = "目标"},
  Task_22349_Desc = {
    Text = "守护公主"
  },
  Task_22349_Name = {Text = "目标"},
  Task_22350_Desc = {
    Text = "制止奥古斯特"
  },
  Task_22350_Name = {Text = "目标"},
  Task_22351_Desc = {
    Text = "找出阿格里帕"
  },
  Task_22351_Name = {Text = "目标"},
  Task_22352_Desc = {
    Text = "躲避沙尘暴"
  },
  Task_22352_Name = {Text = "目标"},
  Task_22353_Desc = {
    Text = "保护艾瑞卡"
  },
  Task_22353_Name = {Text = "目标"},
  Task_22354_Desc = {
    Text = "找到艾瑞卡"
  },
  Task_22354_Name = {Text = "目标"},
  Task_22355_Desc = {
    Text = "跟上尤乌哈希"
  },
  Task_22355_Name = {Text = "目标"},
  Task_22356_Desc = {
    Text = "击退愤怒的奴隶"
  },
  Task_22356_Name = {Text = "目标"},
  Task_22358_Desc = {
    Text = "叠加最大生命50%的护盾"
  },
  Task_22358_Name = {
    Text = "生命之护Ⅱ"
  },
  Task_22359_Desc = {
    Text = "叠加最大生命30%的护盾"
  },
  Task_22359_Name = {
    Text = "生命之护Ⅰ"
  },
  Task_22380_Desc = {
    Text = "找到10处主线第五章「@1@2」的析出点"
  },
  Task_22380_Desc2 = {
    Text = "找到10处主线第五章「风暴之眼」的析出点"
  },
  Task_22380_Name = {Text = "@1@2"},
  Task_22380_Name2 = {
    Text = "潜藏的低语Ⅴ"
  },
  Task_22381_Desc = {
    Text = "完成600次史瓦西喉"
  },
  Task_22381_Name = {
    Text = "弯曲视界Ⅴ"
  },
  Task_22382_Desc = {
    Text = "完成100次史瓦西喉"
  },
  Task_22382_Name = {
    Text = "弯曲视界Ⅱ"
  },
  Task_22383_Desc = {
    Text = "完成50次史瓦西喉"
  },
  Task_22383_Name = {
    Text = "弯曲视界"
  },
  Task_22384_Desc = {
    Text = "完成400次史瓦西喉"
  },
  Task_22384_Name = {
    Text = "弯曲视界Ⅳ"
  },
  Task_22385_Desc = {
    Text = "完成200次史瓦西喉"
  },
  Task_22385_Name = {
    Text = "弯曲视界Ⅲ"
  },
  Task_22387_Desc = {
    Text = "完成调查事件「@1@2」"
  },
  Task_22387_Desc2 = {
    Text = "完成调查事件「风暴之眼」"
  },
  Task_22387_Name = {Text = "@1@2"},
  Task_22387_Name2 = {
    Text = "迷失三角"
  },
  Task_22388_Desc = {
    Text = "在调查事件「@1@2」中共鸣3次"
  },
  Task_22388_Desc2 = {
    Text = "在调查事件「风暴之眼」中共鸣3次"
  },
  Task_22388_Name = {Text = "@1@2"},
  Task_22388_Name2 = {
    Text = "无望回响"
  },
  Task_22389_Desc = {
    Text = "完成调查事件「风暴之眼」困难难度"
  },
  Task_22389_Name = {
    Text = "迷失三角·困难"
  },
  Task_22390_Desc = {
    Text = "在调查事件「@1@2」中共鸣7次"
  },
  Task_22390_Desc2 = {
    Text = "在调查事件「风暴之眼」中共鸣7次"
  },
  Task_22390_Name = {Text = "@1@2"},
  Task_22390_Name2 = {
    Text = "无望回响Ⅲ"
  },
  Task_22391_Desc = {
    Text = "在调查事件「@1@2」中共鸣6次"
  },
  Task_22391_Desc2 = {
    Text = "在调查事件「风暴之眼」中共鸣6次"
  },
  Task_22391_Name = {Text = "@1@2"},
  Task_22391_Name2 = {
    Text = "无望回响Ⅱ"
  },
  Task_22392_Desc = {
    Text = "在调查事件「@1@2」中共鸣10次"
  },
  Task_22392_Desc2 = {
    Text = "在调查事件「风暴之眼」中共鸣10次"
  },
  Task_22392_Name = {Text = "@1@2"},
  Task_22392_Name2 = {
    Text = "无望回响Ⅳ"
  },
  Task_23613_Desc = {
    Text = "寻找达芙黛尔"
  },
  Task_23613_Name = {Text = "目标"},
  Task_23614_Desc = {
    Text = "前往百货公司"
  },
  Task_23614_Name = {Text = "目标"},
  Task_23615_Desc = {
    Text = "完成拍摄"
  },
  Task_23615_Name = {Text = "目标"},
  Task_23616_Desc = {
    Text = "回到活动场地"
  },
  Task_23616_Name = {Text = "目标"},
  Task_23617_Desc = {
    Text = "进行拍摄"
  },
  Task_23617_Name = {Text = "目标"},
  Task_23618_Desc = {
    Text = "外出取材"
  },
  Task_23618_Name = {Text = "目标"},
  Task_23619_Desc = {
    Text = "击退敌人"
  },
  Task_23619_Name = {Text = "目标"},
  Task_23620_Desc = {
    Text = "探访疗养院"
  },
  Task_23620_Name = {Text = "目标"},
  Task_23646_Desc = {
    Text = "累计唤醒1000次"
  },
  Task_23708_Desc = {
    Text = "最终战一回合额外抽5张牌，获得100分"
  },
  Task_23708_Name = {
    Text = "再抽再抽  <size=20><color=#747474>最终战一回合额外抽5张牌</color></size>"
  },
  Task_23709_Desc = {
    Text = "获得5个黄金造物，获得100分"
  },
  Task_23709_Name = {
    Text = "金光闪闪  <size=20><color=#747474>获得5个黄金造物</color></size>"
  },
  Task_23710_Desc = {
    Text = "获得2个诅咒造物，获得100分"
  },
  Task_23710_Name = {
    Text = "奇兵秘藏  <size=20><color=#747474>获得2个诅咒造物</color></size>"
  },
  Task_23711_Desc = {
    Text = "最终战一回合打出7张卡牌，获得100分"
  },
  Task_23711_Name = {
    Text = "我的回合  <size=20><color=#747474>最终战一回合打出7张卡牌</color></size>"
  },
  Task_23712_Desc = {
    Text = "觉醒4名唤醒体，获得100分"
  },
  Task_23712_Name = {
    Text = "觉醒时刻  <size=20><color=#747474>觉醒4名唤醒体</color></size>"
  },
  Task_23713_Desc = {
    Text = "最终战一回合额外获得 3 算力，获得100分"
  },
  Task_23713_Name = {
    Text = "神机妙算  <size=20><color=#747474>最终战一回合额外获得 3 算力</color></size>"
  },
  Task_23714_Desc = {
    Text = "最终战一回合使用至少3次狂气爆发，获得100分"
  },
  Task_23714_Name = {
    Text = "致命魔术  <size=20><color=#747474>最终战一回合使用至少3次狂气爆发</color></size>"
  },
  Task_23715_Desc = {
    Text = "获得11个刻印，获得100分"
  },
  Task_23715_Name = {
    Text = "刻印之力  <size=20><color=#747474>获得11个刻印</color></size>"
  },
  Task_23716_Desc = {
    Text = "最终战一回合造成首领最大生命50%的伤害，获得100分"
  },
  Task_23716_Name = {
    Text = "降临之秽  <size=20><color=#747474>最终战一回合造成超过首领最大生命50%的伤害</color></size>"
  },
  Task_23717_Desc = {
    Text = "获得9种不同的刻印，获得100分"
  },
  Task_23717_Name = {
    Text = "刻印收藏  <size=20><color=#747474>获得9个不同的刻印</color></size>"
  },
  Task_23718_Desc = {
    Text = "最终战一回合获得最大生命80%的护盾，获得100分"
  },
  Task_23718_Name = {
    Text = "钢铁之躯  <size=20><color=#747474>最终战一回合获得最大生命80%的护盾</color></size>"
  },
  Task_23719_Desc = {
    Text = "通关时症状卡数量不少于4张，获得100分"
  },
  Task_23719_Name = {
    Text = "病入膏肓  <size=20><color=#747474>通关时症状卡牌数量不少于4张</color></size>"
  },
  Task_23720_Desc = {
    Text = "最终战每回合都使用狂气爆发，获得100分"
  },
  Task_23720_Name = {
    Text = "恐怖表演  <size=20><color=#747474>最终战每回合都使用狂气爆发</color></size>"
  },
  Task_23721_Desc = {
    Text = "获得7个造物，获得100分"
  },
  Task_23721_Name = {
    Text = "满载而归  <size=20><color=#747474>获得7个造物</color></size>"
  },
  Task_23722_Desc = {
    Text = "任一战斗一回合消灭4个敌人，获得100分"
  },
  Task_23722_Name = {
    Text = "不可饶恕  <size=20><color=#747474>任一战斗一回合消灭4个敌人</color></size>"
  },
  Task_23789_Desc = {
    Text = "累计登录 30 天"
  },
  Task_23868_Desc = {
    Text = "获得5场相位对弈的胜利"
  },
  Task_23868_Name = {
    Text = "每周奖励"
  },
  Task_23869_Desc = {
    Text = "相位对弈的段位达到资深Ⅰ"
  },
  Task_23873_Desc = {
    Text = "最终战一回合造成首领最大生命30%的伤害，获得100分"
  },
  Task_23873_Name = {
    Text = "降临之秽  <size=20><color=#747474>最终战一回合造成超过首领最大生命30%的伤害</color></size>"
  },
  Task_23874_Desc = {
    Text = "获得5个黄金或诅咒造物，获得100分"
  },
  Task_23874_Name = {
    Text = "好坏都要  <size=20><color=#747474>获得5个黄金或诅咒造物，获得100分</color></size>"
  },
  Task_23875_Desc = {
    Text = "获得8种不同的刻印，获得100分"
  },
  Task_23875_Name = {
    Text = "刻印收藏  <size=20><color=#747474>获得8种不同的刻印</color></size>"
  },
  Task_23876_Desc = {
    Text = "获得10个刻印，获得100分"
  },
  Task_23876_Name = {
    Text = "刻印之力  <size=20><color=#747474>获得10个刻印</color></size>"
  },
  Task_23877_Desc = {
    Text = "最终战一回合使用至少4次狂气爆发，获得100分"
  },
  Task_23877_Name = {
    Text = "致命魔术  <size=20><color=#747474>最终战一回合使用至少4次狂气爆发</color></size>"
  },
  Task_23878_Desc = {
    Text = "任一战斗一回合消灭3个敌人，获得100分"
  },
  Task_23878_Name = {
    Text = "不可饶恕  <size=20><color=#747474>任一战斗一回合消灭3个敌人</color></size>"
  },
  Task_23879_Desc = {
    Text = "获得8个造物，获得100分"
  },
  Task_23879_Name = {
    Text = "满载而归  <size=20><color=#747474>获得8个造物</color></size>"
  },
  Task_23885_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_23886_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_23887_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_23888_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_23889_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_23890_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_23891_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_23892_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_23893_Desc = {
    Text = "完成意识潜游「苍白后裔」普通模式"
  },
  Task_23893_Name = {
    Text = "通关奖励"
  },
  Task_23894_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_23895_Desc = {
    Text = "完成特遣纪录「雨镇幽影」普通模式"
  },
  Task_23895_Name = {
    Text = "通关奖励"
  },
  Task_23896_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_24139_Desc = {
    Text = "通关时携带至少5个造物"
  },
  Task_24139_Name = {
    Text = "奇兵秘藏"
  },
  Task_24140_Desc = {
    Text = "最终战一回合打出至少6张卡牌"
  },
  Task_24140_Name = {
    Text = "我的回合"
  },
  Task_24141_Desc = {
    Text = "通关时携带至少5个造物"
  },
  Task_24141_Name = {
    Text = "奇兵秘藏"
  },
  Task_24142_Desc = {
    Text = "最终战一回合打出至少6张卡牌"
  },
  Task_24142_Name = {
    Text = "我的回合"
  },
  Task_24177_Desc = {
    Text = "逃离动力室"
  },
  Task_24177_Name = {Text = "目标"},
  Task_24403_Desc = {
    Text = "追上可疑的马车"
  },
  Task_24403_Name = {Text = "目标"},
  Task_24404_Desc = {
    Text = "躲避「N」的注视"
  },
  Task_24404_Name = {Text = "目标"},
  Task_24405_Desc = {
    Text = "寻找《蔷薇之名》邀请函"
  },
  Task_24405_Name = {Text = "目标"},
  Task_24406_Desc = {
    Text = "进入人工密境，回到案发当日"
  },
  Task_24406_Name = {Text = "目标"},
  Task_24407_Desc = {
    Text = "抓住可疑男子"
  },
  Task_24407_Name = {Text = "目标"},
  Task_24408_Desc = {
    Text = "追上侍女珈伦"
  },
  Task_24408_Name = {Text = "目标"},
  Task_24409_Desc = {
    Text = "抵御神秘黑影的攻击"
  },
  Task_24409_Name = {Text = "目标"},
  Task_24410_Desc = {
    Text = "抵御面具黑影的攻击"
  },
  Task_24410_Name = {Text = "目标"},
  Task_24411_Desc = {
    Text = "抓捕朗贝尔先生"
  },
  Task_24411_Name = {Text = "目标"},
  Task_24412_Desc = {
    Text = "击退融蚀怪物"
  },
  Task_24412_Name = {Text = "目标"},
  Task_24457_Desc = {
    Text = "最终战一回合使用至少3/4次狂气爆发，获得50/100分。"
  },
  Task_24457_Name = {
    Text = "致命魔术<size=20><color=#747474>最终战一回合使用至少3次狂气爆发</color></size>"
  },
  Task_24458_Desc = {
    Text = "获得7/9/11个刻印，获得30/60/100分。"
  },
  Task_24458_Name = {
    Text = "刻印之力<size=20><color=#747474>获得7个刻印</color></size>"
  },
  Task_24459_Desc = {
    Text = "获得4/5/6个黄金造物，获得30/60/100分。"
  },
  Task_24459_Name = {
    Text = "金光闪闪<size=20><color=#747474>获得5个黄金造物</color></size>"
  },
  Task_24460_Desc = {
    Text = "获得4/5/6个黄金造物，获得30/60/100分。"
  },
  Task_24460_Name = {
    Text = "金光闪闪<size=20><color=#747474>获得4个黄金造物</color></size>"
  },
  Task_24461_Desc = {
    Text = "获得4/5/6个黄金或诅咒造物，获得30/60/100分。"
  },
  Task_24461_Name = {
    Text = "好坏都要<size=20><color=#747474>获得6个黄金或诅咒造物</color></size>"
  },
  Task_24462_Desc = {
    Text = "获得4/5/6个黄金或诅咒造物，获得30/60/100分。"
  },
  Task_24462_Name = {
    Text = "好坏都要<size=20><color=#747474>获得4个黄金或诅咒造物</color></size>"
  },
  Task_24463_Desc = {
    Text = "获得4/5/6个黄金或诅咒造物，获得30/60/100分。"
  },
  Task_24463_Name = {
    Text = "好坏都要<size=20><color=#747474>获得5个黄金或诅咒造物</color></size>"
  },
  Task_24464_Desc = {
    Text = "获得7/9/11个刻印，获得30/60/100分。"
  },
  Task_24464_Name = {
    Text = "刻印之力<size=20><color=#747474>获得9个刻印</color></size>"
  },
  Task_24465_Desc = {
    Text = "觉醒3/4名唤醒体，获得50/100分。"
  },
  Task_24465_Name = {
    Text = "觉醒时刻<size=20><color=#747474>觉醒3名唤醒体</color></size>"
  },
  Task_24466_Desc = {
    Text = "最终战一回合打出5/7/9张卡牌，获得30/60/100分。"
  },
  Task_24466_Name = {
    Text = "我的回合<size=20><color=#747474>最终战一回合打出9张卡牌</color></size>"
  },
  Task_24467_Desc = {
    Text = "觉醒3/4名唤醒体，获得50/100分。"
  },
  Task_24467_Name = {
    Text = "觉醒时刻<size=20><color=#747474>觉醒4名唤醒体</color></size>"
  },
  Task_24468_Desc = {
    Text = "最终战一回合使用至少3/4次狂气爆发，获得50/100分。"
  },
  Task_24468_Name = {
    Text = "致命魔术<size=20><color=#747474>最终战一回合使用至少4次狂气爆发</color></size>"
  },
  Task_24469_Desc = {
    Text = "最终战一回合额外获得2/3/4算力，获得30/60/100分。"
  },
  Task_24469_Name = {
    Text = "神机妙算<size=20><color=#747474>最终战一回合额外获得 2 算力</color></size>"
  },
  Task_24470_Desc = {
    Text = "最终战一回合额外获得2/3/4算力，获得30/60/100分。"
  },
  Task_24470_Name = {
    Text = "神机妙算<size=20><color=#747474>最终战一回合额外获得 3 算力</color></size>"
  },
  Task_24471_Desc = {
    Text = "通关时症状卡数量不少于3/4张，获得50/100分。"
  },
  Task_24471_Name = {
    Text = "病入膏肓<size=20><color=#747474>通关时症状卡牌数量不少于3张</color></size>"
  },
  Task_24472_Desc = {
    Text = "通关时症状卡数量不少于3/4张，获得50/100分。"
  },
  Task_24472_Name = {
    Text = "病入膏肓<size=20><color=#747474>通关时症状卡牌数量不少于4张</color></size>"
  },
  Task_24473_Desc = {
    Text = "最终战一回合额外获得2/3/4算力，获得30/60/100分。"
  },
  Task_24473_Name = {
    Text = "神机妙算<size=20><color=#747474>最终战一回合额外获得 4 算力</color></size>"
  },
  Task_24474_Desc = {
    Text = "通关时任一唤醒体的牌不超过2/1张，获得50/100分。"
  },
  Task_24474_Name = {
    Text = "被忽略的<size=20><color=#747474>通关时一个唤醒体的所有卡牌不多于2张</color></size>"
  },
  Task_24475_Desc = {
    Text = "最终战连续3/4/5个回合都使用狂气爆发，获得30/60/100分。"
  },
  Task_24475_Name = {
    Text = "恐怖表演<size=20><color=#747474>最终战连续5个回合都使用狂气爆发</color></size>"
  },
  Task_24476_Desc = {
    Text = "通关时任一唤醒体的牌不超过2/1张，获得50/100分。"
  },
  Task_24476_Name = {
    Text = "被忽略的<size=20><color=#747474>通关时一个唤醒体的所有卡牌不多于1张</color></size>"
  },
  Task_24477_Desc = {
    Text = "最终战连续3/4/5个回合都使用狂气爆发，获得30/60/100分。"
  },
  Task_24477_Name = {
    Text = "恐怖表演<size=20><color=#747474>最终战连续4个回合都使用狂气爆发</color></size>"
  },
  Task_24478_Desc = {
    Text = "获得6/7/8个造物，获得30/60/100分。"
  },
  Task_24478_Name = {
    Text = "满载而归<size=20><color=#747474>获得7个造物</color></size>"
  },
  Task_24479_Desc = {
    Text = "获得6/7/8个造物，获得30/60/100分。"
  },
  Task_24479_Name = {
    Text = "满载而归<size=20><color=#747474>获得6个造物</color></size>"
  },
  Task_24480_Desc = {
    Text = "最终战一回合获得最大生命25%/50%/75%的护盾，获得30/60/100分。"
  },
  Task_24480_Name = {
    Text = "钢铁之躯<size=20><color=#747474>最终战一回合获得最大生命25%的护盾</color></size>"
  },
  Task_24481_Desc = {
    Text = "最终战一回合造成首领最大生命20%/30%/40%的伤害，获得30/60/100分。"
  },
  Task_24481_Name = {
    Text = "降临之秽<size=20><color=#747474>最终战一回合造成超过首领最大生命30%的伤害</color></size>"
  },
  Task_24482_Desc = {
    Text = "获得6/7/8个造物，获得30/60/100分。"
  },
  Task_24482_Name = {
    Text = "满载而归<size=20><color=#747474>获得8个造物</color></size>"
  },
  Task_24483_Desc = {
    Text = "获得5/7/9种不同的刻印，获得30/60/100分。"
  },
  Task_24483_Name = {
    Text = "刻印收藏<size=20><color=#747474>获得9个不同的刻印</color></size>"
  },
  Task_24484_Desc = {
    Text = "获得5/7/9种不同的刻印，获得30/60/100分。"
  },
  Task_24484_Name = {
    Text = "刻印收藏<size=20><color=#747474>获得5个不同的刻印</color></size>"
  },
  Task_24485_Desc = {
    Text = "获得5/7/9种不同的刻印，获得30/60/100分。"
  },
  Task_24485_Name = {
    Text = "刻印收藏<size=20><color=#747474>获得7个不同的刻印</color></size>"
  },
  Task_24486_Desc = {
    Text = "获得4/5/6个黄金造物，获得30/60/100分。"
  },
  Task_24486_Name = {
    Text = "金光闪闪<size=20><color=#747474>获得6个黄金造物</color></size>"
  },
  Task_24487_Desc = {
    Text = "最终战连续3/4/5个回合都使用狂气爆发，获得30/60/100分。"
  },
  Task_24487_Name = {
    Text = "恐怖表演<size=20><color=#747474>最终战连续3个回合都使用狂气爆发</color></size>"
  },
  Task_24488_Desc = {
    Text = "获得2/3个诅咒造物，获得50/100分。"
  },
  Task_24488_Name = {
    Text = "奇兵秘藏<size=20><color=#747474>获得3个诅咒造物</color></size>"
  },
  Task_24489_Desc = {
    Text = "获得2/3个诅咒造物，获得50/100分。"
  },
  Task_24489_Name = {
    Text = "奇兵秘藏<size=20><color=#747474>获得2个诅咒造物</color></size>"
  },
  Task_24490_Desc = {
    Text = "最终战一回合获得最大生命25%/50%/75%的护盾，获得30/60/100分。"
  },
  Task_24490_Name = {
    Text = "钢铁之躯<size=20><color=#747474>最终战一回合获得最大生命50%的护盾</color></size>"
  },
  Task_24491_Desc = {
    Text = "最终战一回合打出5/7/9张卡牌，获得30/60/100分。"
  },
  Task_24491_Name = {
    Text = "我的回合<size=20><color=#747474>最终战一回合打出7张卡牌</color></size>"
  },
  Task_24492_Desc = {
    Text = "获得7/9/11个刻印，获得30/60/100分。"
  },
  Task_24492_Name = {
    Text = "刻印之力<size=20><color=#747474>获得11个刻印</color></size>"
  },
  Task_24493_Desc = {
    Text = "最终战一回合打出5/7/9张卡牌，获得30/60/100分。"
  },
  Task_24493_Name = {
    Text = "我的回合<size=20><color=#747474>最终战一回合打出5张卡牌</color></size>"
  },
  Task_24494_Desc = {
    Text = "最终战一回合造成首领最大生命20%/30%/40%的伤害，获得30/60/100分。"
  },
  Task_24494_Name = {
    Text = "降临之秽<size=20><color=#747474>最终战一回合造成超过首领最大生命40%的伤害</color></size>"
  },
  Task_24495_Desc = {
    Text = "最终战一回合获得最大生命25%/50%/75%的护盾，获得30/60/100分。"
  },
  Task_24495_Name = {
    Text = "钢铁之躯<size=20><color=#747474>最终战一回合获得最大生命75%的护盾</color></size>"
  },
  Task_24496_Desc = {
    Text = "最终战一回合造成首领最大生命20%/30%/40%的伤害，获得30/60/100分。"
  },
  Task_24496_Name = {
    Text = "降临之秽<size=20><color=#747474>最终战一回合造成超过首领最大生命20%的伤害</color></size>"
  },
  Task_24497_Desc = {
    Text = "任一战斗一回合消灭3/4个敌人，获得50/100分。"
  },
  Task_24497_Name = {
    Text = "不可饶恕<size=20><color=#747474>任一战斗一回合消灭4个敌人</color></size>"
  },
  Task_24498_Desc = {
    Text = "最终战一回合额外抽4/5/6张牌，获得30/60/100分。"
  },
  Task_24498_Name = {
    Text = "再抽再抽<size=20><color=#747474>最终战一回合额外抽5张牌</color></size>"
  },
  Task_24499_Desc = {
    Text = "最终战一回合额外抽4/5/6张牌，获得30/60/100分。"
  },
  Task_24499_Name = {
    Text = "再抽再抽<size=20><color=#747474>最终战一回合额外抽4张牌</color></size>"
  },
  Task_24500_Desc = {
    Text = "任一战斗一回合消灭3/4个敌人，获得50/100分。"
  },
  Task_24500_Name = {
    Text = "不可饶恕<size=20><color=#747474>任一战斗一回合消灭3个敌人</color></size>"
  },
  Task_24501_Desc = {
    Text = "最终战一回合额外抽4/5/6张牌，获得30/60/100分。"
  },
  Task_24501_Name = {
    Text = "再抽再抽<size=20><color=#747474>最终战一回合额外抽6张牌</color></size>"
  },
  Task_24534_Desc = {
    Text = "追上拉蒙娜"
  },
  Task_24534_Name = {Text = "目标"},
  Task_25013_Desc = {
    Text = "完成特遣纪录「蔷薇礼赞」普通模式"
  },
  Task_25013_Name = {
    Text = "通关奖励"
  },
  Task_25014_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_25015_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_25016_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_25017_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_25018_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_25019_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_25020_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_25021_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_25022_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_25023_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_25024_Desc = {
    Text = "完成意识潜游「一步之遥」普通模式"
  },
  Task_25024_Name = {
    Text = "通关奖励"
  },
  Task_25164_Desc = {
    Text = "跟随拉蒙娜"
  },
  Task_25164_Name = {Text = "目标"},
  Task_25167_Desc = {
    Text = "进入神秘宅邸"
  },
  Task_25167_Name = {Text = "目标"},
  Task_25168_Desc = {
    Text = "回到索蕾尔夫人的包厢"
  },
  Task_25168_Name = {Text = "目标"},
  Task_34729_Desc = {
    Text = "剧本迷思·超维"
  },
  Task_34731_Desc = {
    Text = "剧本迷思·混沌"
  },
  Task_34734_Desc = {
    Text = "特遣纪录"
  },
  Task_34737_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_34740_Desc = {
    Text = "剧本迷思·深海"
  },
  Task_34741_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_34742_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_34743_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_34744_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_34745_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_34746_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_34748_Desc = {
    Text = "剧本迷思·血肉"
  },
  Task_34750_Desc = {
    Text = "完成「特遣纪录」所有任务"
  },
  Task_34942_Desc = {
    Text = "使用混沌界域唤醒体在「剧本迷思」中累计使用25次钥令"
  },
  Task_34943_Desc = {
    Text = "在「剧本迷思」中，累计获得50张「胚胎」"
  },
  Task_34944_Desc = {
    Text = "在「剧本迷思」中，累计进入超维回合10次"
  },
  Task_34945_Desc = {
    Text = "在「剧本迷思」中，累计使用触腕攻击250次"
  },
  Task_34946_Desc = {
    Text = "使用血肉界域唤醒体在「剧本迷思」中获胜1次"
  },
  Task_34947_Desc = {
    Text = "使用超维界域唤醒体在「剧本迷思」中获胜1次"
  },
  Task_34948_Desc = {
    Text = "在「剧本迷思」中，累计使用触腕攻击100次"
  },
  Task_34949_Desc = {
    Text = "在「剧本迷思」中，累计进入超维回合5次"
  },
  Task_34950_Desc = {
    Text = "使用深海界域唤醒体在「剧本迷思」中获胜1次"
  },
  Task_34951_Desc = {
    Text = "在「剧本迷思」中，累计获得15张「胚胎」"
  },
  Task_34952_Desc = {
    Text = "使用混沌界域唤醒体在「剧本迷思」中累计使用10次钥令"
  },
  Task_34953_Desc = {
    Text = "使用混沌界域唤醒体在「剧本迷思」中获胜1次"
  },
  Task_35262_Desc = {
    Text = "完成「剧本迷思」所有界域任务"
  },
  Task_35263_Desc = {Text = "终章"},
  Task_35808_Desc = {
    Text = "累计消耗 500万 蔷薇金券"
  },
  Task_35808_Name = {
    Text = "挥金如土"
  },
  Task_36141_Desc = {
    Text = "在调查事件「@1@2」中共鸣6次"
  },
  Task_36141_Desc2 = {
    Text = "在调查事件「倒错的群星」中共鸣6次"
  },
  Task_36141_Name = {Text = "@1@2"},
  Task_36141_Name2 = {
    Text = "渴求回响Ⅱ"
  },
  Task_36142_Desc = {
    Text = "完成调查事件「@1@2」"
  },
  Task_36142_Desc2 = {
    Text = "完成调查事件「倒错的群星」"
  },
  Task_36142_Name = {Text = "@1@2"},
  Task_36142_Name2 = {
    Text = "拒绝呼唤"
  },
  Task_36143_Desc = {
    Text = "在调查事件「@1@2」中共鸣3次"
  },
  Task_36143_Desc2 = {
    Text = "在调查事件「倒错的群星」中共鸣3次"
  },
  Task_36143_Name = {Text = "@1@2"},
  Task_36143_Name2 = {
    Text = "渴求回响"
  },
  Task_36144_Desc = {
    Text = "完成调查事件「倒错的群星」困难难度"
  },
  Task_36144_Name = {
    Text = "拒绝呼唤·困难"
  },
  Task_36145_Desc = {
    Text = "在调查事件「@1@2」中共鸣8次"
  },
  Task_36145_Desc2 = {
    Text = "在调查事件「倒错的群星」中共鸣8次"
  },
  Task_36145_Name = {Text = "@1@2"},
  Task_36145_Name2 = {
    Text = "渴求回响Ⅲ"
  },
  Task_36155_Desc = {
    Text = "掩护船长驾驶"
  },
  Task_36155_Name = {Text = "目标"},
  Task_36156_Desc = {
    Text = "进入动力室"
  },
  Task_36156_Name = {Text = "目标"},
  Task_36157_Desc = {
    Text = "寻找同伴"
  },
  Task_36157_Name = {Text = "目标"},
  Task_36158_Desc = {
    Text = "抵抗蹈海者的攻势"
  },
  Task_36158_Name = {Text = "目标"},
  Task_36159_Desc = {
    Text = "靠近「圣婴」"
  },
  Task_36159_Name = {Text = "目标"},
  Task_36160_Desc = {
    Text = "抵抗攻击"
  },
  Task_36160_Name = {Text = "目标"},
  Task_36161_Desc = {
    Text = "回到驾驶室"
  },
  Task_36161_Name = {Text = "目标"},
  Task_36162_Desc = {
    Text = "击退敌人"
  },
  Task_36162_Name = {Text = "目标"},
  Task_36163_Desc = {
    Text = "前往驾驶室"
  },
  Task_36163_Name = {Text = "目标"},
  Task_36164_Desc = {
    Text = "前往动力室"
  },
  Task_36164_Name = {Text = "目标"},
  Task_36169_Desc = {
    Text = "前往广场"
  },
  Task_36169_Name = {Text = "目标"},
  Task_36316_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_36316_Name = {
    Text = "节能主义"
  },
  Task_36317_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_36317_Name = {
    Text = "节能主义"
  },
  Task_36359_Desc = {
    Text = "找到10处主线第六章「@1@2」的析出点"
  },
  Task_36359_Desc2 = {
    Text = "找到10处主线第六章「倒错的群星」的析出点"
  },
  Task_36359_Name = {Text = "@1@2"},
  Task_36359_Name2 = {
    Text = "潜藏的低语Ⅵ"
  },
  Task_36622_Desc = {
    Text = "控制异变的村民"
  },
  Task_36622_Name = {Text = "目标"},
  Task_36623_Desc = {
    Text = "前往旺达寝宫"
  },
  Task_36623_Name = {Text = "目标"},
  Task_36624_Desc = {
    Text = "击退融蚀浆怪物"
  },
  Task_36624_Name = {Text = "目标"},
  Task_36842_Desc = {
    Text = "完成意识潜游「诸事如常」普通模式"
  },
  Task_36842_Name = {
    Text = "通关奖励"
  },
  Task_36864_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_36872_Desc = {
    Text = "每使用1次应急灵知体，调查评分降低30%"
  },
  Task_36872_Name = {
    Text = "意念透支  <size=20><color=#747474>每使用1次应急灵知体，调查评分降低30%</color></size>"
  },
  Task_38749_Desc = {
    Text = "消耗 180 灵啡肽"
  },
  Task_38750_Desc = {
    Text = "使用助战 3 次"
  },
  Task_38751_Desc = {
    Text = "给校友点赞 10 次"
  },
  Task_38752_Desc = {
    Text = "完成每周试炼"
  },
  Task_38753_Desc = {
    Text = "执行 3 次派遣"
  },
  Task_38754_Desc = {
    Text = "完成所有训练任务"
  },
  Task_38755_Desc = {
    Text = "幻梦深潜胜利 1 次"
  },
  Task_38814_Desc = {
    Text = "使用混沌界域唤醒体在「湖中之城」中获胜1次"
  },
  Task_38815_Desc = {
    Text = "使用混沌界域唤醒体在「湖中之城」中获胜5次"
  },
  Task_38816_Desc = {
    Text = "使用混沌界域唤醒体在「湖中之城」中获胜3次"
  },
  Task_38817_Desc = {
    Text = "湖中之城·血肉"
  },
  Task_38818_Desc = {
    Text = "通关「启示录」任意追忆"
  },
  Task_38819_Desc = {
    Text = "通关「一段记忆」任意追忆"
  },
  Task_38820_Desc = {
    Text = "使用超维界域唤醒体在「湖中之城」中获胜5次"
  },
  Task_38821_Desc = {
    Text = "使用超维界域唤醒体在「湖中之城」中获胜3次"
  },
  Task_38822_Desc = {
    Text = "使用超维界域唤醒体在「湖中之城」中获胜1次"
  },
  Task_38823_Desc = {
    Text = "湖中之城·深海"
  },
  Task_38824_Desc = {
    Text = "通关「小苍兰」任意追忆"
  },
  Task_38825_Desc = {
    Text = "通关「井」任意追忆"
  },
  Task_38826_Desc = {
    Text = "意识潜游"
  },
  Task_38827_Desc = {
    Text = "使用深海界域唤醒体在「湖中之城」中获胜3次"
  },
  Task_38828_Desc = {
    Text = "使用深海界域唤醒体在「湖中之城」中获胜5次"
  },
  Task_38829_Desc = {
    Text = "使用深海界域唤醒体在「湖中之城」中获胜1次"
  },
  Task_38830_Desc = {
    Text = "通关「海市蜃楼」任意追忆"
  },
  Task_38831_Desc = {
    Text = "湖中之城·混沌"
  },
  Task_38832_Desc = {
    Text = "通关「真实」任意追忆"
  },
  Task_38833_Desc = {
    Text = "湖中之城·追忆"
  },
  Task_38834_Desc = {
    Text = "通关「黄金之城」任意追忆"
  },
  Task_38835_Desc = {
    Text = "使用血肉界域唤醒体在「湖中之城」中获胜1次"
  },
  Task_38836_Desc = {
    Text = "使用血肉界域唤醒体在「湖中之城」中获胜5次"
  },
  Task_38837_Desc = {
    Text = "使用血肉界域唤醒体在「湖中之城」中获胜3次"
  },
  Task_38838_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_38839_Desc = {
    Text = "湖中之城·超维"
  },
  Task_38840_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_39279_Desc = {
    Text = "每使用 1 次应急灵知体，调查评分降低 20% 。（已使用次数：{s1}）"
  },
  Task_39279_Name = {
    Text = "幻境援救<size=20><color=#747474>每使用 1 次应急灵知体，调查评分降低 20% </color></size>"
  },
  Task_40465_Desc = {
    Text = "触发 1/2/3 次以上死亡抵抗，获得 100/300/500 分。"
  },
  Task_40465_Name = {
    Text = "生死边缘<size=20><color=#747474>触发 1 次死亡抵抗</color></size>"
  },
  Task_40466_Desc = {
    Text = "触发 1/2/3 次以上死亡抵抗，获得 100/300/500 分。"
  },
  Task_40466_Name = {
    Text = "生死边缘<size=20><color=#747474>触发 3 次以上死亡抵抗</color></size>"
  },
  Task_40467_Desc = {
    Text = "触发 1/2/3 次以上死亡抵抗，获得 100/300/500 分。"
  },
  Task_40467_Name = {
    Text = "生死边缘<size=20><color=#747474>触发 2 次死亡抵抗</color></size>"
  },
  Task_40468_Desc = {
    Text = "拥有 5/6/7/8 个造物，获得 250/500/750/1000 分。"
  },
  Task_40468_Name = {
    Text = "实相搜罗<size=20><color=#747474>拥有 5 个造物</color></size>"
  },
  Task_40469_Desc = {
    Text = "拥有 5/6/7/8 个造物，获得 250/500/750/1000 分。"
  },
  Task_40469_Name = {
    Text = "实相搜罗<size=20><color=#747474>拥有 7 个造物</color></size>"
  },
  Task_40470_Desc = {
    Text = "拥有 5/6/7/8 个造物，获得 250/500/750/1000 分。"
  },
  Task_40470_Name = {
    Text = "实相搜罗<size=20><color=#747474>拥有 6 个造物</color></size>"
  },
  Task_40471_Desc = {
    Text = "最终战 11/10/9/8 回合内获胜，获得 250/500/750/1000\n/1000 分。"
  },
  Task_40471_Name = {
    Text = "沉梦疾行<size=20><color=#747474>在 8 回合以内败首领</color></size>"
  },
  Task_40472_Desc = {
    Text = "最终战 11/10/9/8 回合内获胜，获得 250/500/750/1000\n/1000 分。"
  },
  Task_40472_Name = {
    Text = "沉梦疾行<size=20><color=#747474>在 8 回合以内败首领</color></size>"
  },
  Task_40473_Desc = {
    Text = "最终战 11/10/9/8 回合内获胜，获得 250/500/750/1000\n/1000 分。"
  },
  Task_40473_Name = {
    Text = "沉梦疾行<size=20><color=#747474>在 9 回合以内败首领</color></size>"
  },
  Task_40474_Desc = {
    Text = "最终战 11/10/9/8 回合内获胜，获得 250/500/750/1000\n/1000 分。"
  },
  Task_40474_Name = {
    Text = "沉梦疾行<size=20><color=#747474>在 10 回合以内败首领</color></size>"
  },
  Task_40475_Desc = {
    Text = "最终战 11/10/9/8 回合内获胜，获得 250/500/750/1000\n/1000 分。"
  },
  Task_40475_Name = {
    Text = "沉梦疾行<size=20><color=#747474>在 11 回合以内败首领</color></size>"
  },
  Task_40476_Desc = {
    Text = "最终战获得胜利，获得1000分。"
  },
  Task_40476_Name = {
    Text = "终梦界碑<size=20><color=#747474>首领战获得胜利</color></size>"
  },
  Task_41334_Desc = {
    Text = "击退首领{s1}"
  },
  Task_41334_Name = {Text = "目标"},
  Task_41367_Desc = {
    Text = "完成「调查行动」第3章"
  },
  Task_41368_Desc = {
    Text = "完成「调查行动」第5章"
  },
  Task_41369_Desc = {
    Text = "完成「调查行动」第4章"
  },
  Task_41370_Desc = {
    Text = "完成「调查行动」第2章"
  },
  Task_41371_Desc = {
    Text = "特训值首次达到 325"
  },
  Task_41372_Desc = {
    Text = "特训值首次达到 350"
  },
  Task_41373_Desc = {
    Text = "特训值首次达到 225"
  },
  Task_41374_Desc = {
    Text = "特训值首次达到 300"
  },
  Task_41375_Desc = {
    Text = "特训值首次达到 100"
  },
  Task_41376_Desc = {
    Text = "特训值首次达到 150"
  },
  Task_41377_Desc = {
    Text = "特训值首次达到 50"
  },
  Task_41380_Desc = {
    Text = "完成以上所有追忆任务"
  },
  Task_43476_Desc = {
    Text = "守密人达到55级"
  },
  Task_43476_Name = {
    Text = "守密人试训IV"
  },
  Task_43477_Desc = {
    Text = "守密人达到45级"
  },
  Task_43477_Name = {
    Text = "守密人试训III"
  },
  Task_43514_Desc = {
    Text = "击退以格伦等人"
  },
  Task_43514_Name = {Text = "目标"},
  Task_43561_Desc = {
    Text = "完成调查主线第6章「倒错的群星」"
  },
  Task_43562_Desc = {
    Text = "完成调查主线第5章「风暴之眼」"
  },
  Task_43563_Desc = {
    Text = "完成调查主线第3章「谨防恶犬」"
  },
  Task_43564_Desc = {
    Text = "完成调查主线第6章「倒错的群星」困难难度"
  },
  Task_43565_Desc = {
    Text = "完成调查主线第4章「于无声处」困难难度"
  },
  Task_43566_Desc = {
    Text = "完成调查主线第3章「谨防恶犬」困难难度"
  },
  Task_43567_Desc = {
    Text = "完成调查主线第5章「风暴之眼」困难难度"
  },
  Task_43568_Desc = {
    Text = "完成调查主线第4章「于无声处」"
  },
  Task_43822_Desc = {
    Text = "拥有1名80级唤醒体"
  },
  Task_43822_Name = {
    Text = "「超越之力」Ⅰ"
  },
  Task_43824_Desc = {
    Text = "一次伤害到达250000"
  },
  Task_43824_Name = {
    Text = "生命不能承受之痛Ⅳ"
  },
  Task_43825_Desc = {
    Text = "一次伤害到达500000"
  },
  Task_43825_Name = {
    Text = "生命不能承受之痛Ⅴ"
  },
  Task_43826_Desc = {
    Text = "一次伤害到达50000"
  },
  Task_43826_Name = {
    Text = "生命不能承受之痛Ⅱ"
  },
  Task_43827_Desc = {
    Text = "一次伤害到达100000"
  },
  Task_43827_Name = {
    Text = "生命不能承受之痛Ⅲ"
  },
  Task_43828_Desc = {
    Text = "拥有3名80级唤醒体"
  },
  Task_43828_Name = {
    Text = "「超越之力」Ⅲ"
  },
  Task_43829_Desc = {
    Text = "拥有2名80级唤醒体"
  },
  Task_43829_Name = {
    Text = "「超越之力」Ⅱ"
  },
  Task_43831_Desc = {
    Text = "给敌人叠加10000层中毒"
  },
  Task_43831_Name = {
    Text = "现实之毒Ⅰ"
  },
  Task_43832_Desc = {
    Text = "完成意识潜游「骑士的愿望」"
  },
  Task_43832_Name = {
    Text = "一千零一夜"
  },
  Task_43833_Desc = {
    Text = "完成意识潜游「燃烧的群宴」"
  },
  Task_43833_Name = {
    Text = "月光之下无新事"
  },
  Task_43834_Desc = {
    Text = "完成特遣纪录「蔷薇礼赞」困难难度"
  },
  Task_43834_Name = {
    Text = "红玫瑰不会沉默·困难"
  },
  Task_43835_Desc = {
    Text = "完成特遣纪录「故事的魔法」困难难度"
  },
  Task_43835_Name = {
    Text = "简单的童年·困难"
  },
  Task_43836_Desc = {
    Text = "完成特遣纪录「故事的魔法」"
  },
  Task_43836_Name = {
    Text = "简单的童年"
  },
  Task_43837_Desc = {
    Text = "完成特遣纪录「雨镇幽影」困难难度"
  },
  Task_43837_Name = {
    Text = "时代的魔女·困难"
  },
  Task_43838_Desc = {
    Text = "完成特遣纪录「雨镇幽影」"
  },
  Task_43838_Name = {
    Text = "时代的魔女"
  },
  Task_43839_Desc = {
    Text = "完成特遣纪录「蔷薇礼赞」"
  },
  Task_43839_Name = {
    Text = "红玫瑰不会沉默"
  },
  Task_43840_Desc = {
    Text = "在相位对弈对战2000次"
  },
  Task_43840_Name = {
    Text = "相位重叠Ⅴ"
  },
  Task_43843_Desc = {
    Text = "分解一个SSR命轮"
  },
  Task_43843_Name = {
    Text = "身外之物"
  },
  Task_43844_Desc = {
    Text = "命轮叠位700次"
  },
  Task_43844_Name = {
    Text = "量子纠缠的未来Ⅰ"
  },
  Task_43845_Desc = {
    Text = "升级唤醒体技能1000次"
  },
  Task_43845_Name = {
    Text = "「诸武精通」Ⅷ"
  },
  Task_43846_Desc = {
    Text = "升级唤醒体技能1100次"
  },
  Task_43846_Name = {
    Text = "「诸武精通」Ⅸ"
  },
  Task_43847_Desc = {
    Text = "升级唤醒体技能1200次"
  },
  Task_43847_Name = {
    Text = "「诸武精通」Ⅹ"
  },
  Task_43849_Desc = {
    Text = "分解100个命轮"
  },
  Task_43849_Name = {
    Text = "宝贵的好奇心"
  },
  Task_43850_Desc = {
    Text = "分解200个命轮"
  },
  Task_43850_Name = {
    Text = "大卸八块的乐趣"
  },
  Task_43851_Desc = {
    Text = "分解300个命轮"
  },
  Task_43851_Name = {
    Text = "果壳中的宇宙"
  },
  Task_43863_Desc = {
    Text = "在相位对弈对战1000次"
  },
  Task_43863_Name = {
    Text = "相位重叠Ⅳ"
  },
  Task_43864_Desc = {
    Text = "在相位对弈对战500次"
  },
  Task_43864_Name = {
    Text = "相位重叠Ⅲ"
  },
  Task_43866_Desc = {
    Text = "完成100次幻梦深潜"
  },
  Task_43866_Name = {
    Text = "浅层冒险"
  },
  Task_43867_Desc = {
    Text = "在相位对弈对战250次"
  },
  Task_43867_Name = {
    Text = "相位重叠Ⅱ"
  },
  Task_43868_Desc = {
    Text = "在相位对弈对战100次"
  },
  Task_43868_Name = {
    Text = "相位重叠Ⅰ"
  },
  Task_43869_Desc = {
    Text = "与40名唤醒体同调率到达等级10"
  },
  Task_43869_Name = {
    Text = "大家都是我的翅膀"
  },
  Task_43873_Desc = {
    Text = "命轮叠位600次"
  },
  Task_43873_Name = {
    Text = "交错的命运Ⅵ"
  },
  Task_43874_Desc = {
    Text = "命轮叠位500次"
  },
  Task_43874_Name = {
    Text = "交错的命运Ⅴ"
  },
  Task_43875_Desc = {
    Text = "命轮叠位400次"
  },
  Task_43875_Name = {
    Text = "交错的命运Ⅳ"
  },
  Task_43876_Desc = {
    Text = "命轮叠位300次"
  },
  Task_43876_Name = {
    Text = "交错的命运Ⅲ"
  },
  Task_43877_Desc = {
    Text = "命轮叠位200次"
  },
  Task_43877_Name = {
    Text = "交错的命运Ⅱ"
  },
  Task_43878_Desc = {
    Text = "命轮叠位100次"
  },
  Task_43878_Name = {
    Text = "交错的命运Ⅰ"
  },
  Task_43880_Desc = {
    Text = "唤醒体激活启灵600次"
  },
  Task_43880_Name = {
    Text = "自未知的呼唤"
  },
  Task_43881_Desc = {
    Text = "唤醒体激活启灵500次"
  },
  Task_43881_Name = {
    Text = "灵与肉的融合Ⅳ"
  },
  Task_43882_Desc = {
    Text = "唤醒体激活启灵400次"
  },
  Task_43882_Name = {
    Text = "灵与肉的融合Ⅲ"
  },
  Task_43883_Desc = {
    Text = "完成意识潜游「如歌的雕琢」困难难度"
  },
  Task_43883_Name = {
    Text = "阿莱夫的秘密·困难"
  },
  Task_43884_Desc = {
    Text = "完成意识潜游「血与沙」困难难度"
  },
  Task_43884_Name = {
    Text = "野兽如是说·困难"
  },
  Task_43885_Desc = {
    Text = "完成意识潜游「一步之遥」"
  },
  Task_43885_Name = {
    Text = "回路使者"
  },
  Task_43886_Desc = {
    Text = "完成意识潜游「诸事如常」"
  },
  Task_43886_Name = {
    Text = "看不见的城市"
  },
  Task_43887_Desc = {
    Text = "完成意识潜游「骑士的愿望」困难难度"
  },
  Task_43887_Name = {
    Text = "一千零一夜 ·困难"
  },
  Task_43888_Desc = {
    Text = "完成意识潜游「燃烧的群宴」困难难度"
  },
  Task_43888_Name = {
    Text = "月光之下无新事·困难"
  },
  Task_43889_Desc = {
    Text = "完成意识潜游「如歌的雕琢」"
  },
  Task_43889_Name = {
    Text = "阿莱夫的秘密"
  },
  Task_43890_Desc = {
    Text = "完成意识潜游「血与沙」"
  },
  Task_43890_Name = {
    Text = "野兽如是说"
  },
  Task_43891_Desc = {
    Text = "完成意识潜游「扭曲核心」"
  },
  Task_43891_Name = {
    Text = "机械人偶会做梦吗"
  },
  Task_43892_Desc = {
    Text = "完成意识潜游「苍白后裔」"
  },
  Task_43892_Name = {
    Text = "我的德米安"
  },
  Task_43893_Desc = {
    Text = "给敌人叠加25000层中毒"
  },
  Task_43893_Name = {
    Text = "现实之毒Ⅱ"
  },
  Task_43896_Desc = {
    Text = "完成意识潜游「一步之遥」困难难度"
  },
  Task_43896_Name = {
    Text = "回路使者·困难"
  },
  Task_43897_Desc = {
    Text = "进行10000次唤醒仪式"
  },
  Task_43897_Name = {
    Text = "灵知歌者"
  },
  Task_43898_Desc = {
    Text = "完成意识潜游「扭曲核心」困难难度"
  },
  Task_43898_Name = {
    Text = "机械人偶会做梦吗·困难"
  },
  Task_43899_Desc = {
    Text = "累计消耗100000黑印"
  },
  Task_43899_Name = {
    Text = "欢迎「光」临Ⅳ"
  },
  Task_43900_Desc = {
    Text = "累计消耗50000黑印"
  },
  Task_43900_Name = {
    Text = "欢迎「光」临Ⅲ"
  },
  Task_43901_Desc = {
    Text = "累计消耗25000黑印"
  },
  Task_43901_Name = {
    Text = "欢迎「光」临Ⅱ"
  },
  Task_43902_Desc = {
    Text = "累计消耗10000黑印"
  },
  Task_43902_Name = {
    Text = "欢迎「光」临Ⅰ"
  },
  Task_43903_Desc = {
    Text = "拥有100件等级12的密契"
  },
  Task_43903_Name = {
    Text = "禁忌守护者Ⅲ"
  },
  Task_43904_Desc = {
    Text = "拥有150件等级12的密契"
  },
  Task_43904_Name = {
    Text = "禁忌守护者Ⅳ"
  },
  Task_43905_Desc = {
    Text = "拥有25件等级12的密契"
  },
  Task_43905_Name = {
    Text = "禁忌守护者Ⅰ"
  },
  Task_43906_Desc = {
    Text = "拥有50件等级12的密契"
  },
  Task_43906_Name = {
    Text = "禁忌守护者Ⅱ"
  },
  Task_43907_Desc = {
    Text = "进行2500次唤醒仪式"
  },
  Task_43907_Name = {
    Text = "吟诵灵魂之人Ⅱ"
  },
  Task_43908_Desc = {
    Text = "进行5000次唤醒仪式"
  },
  Task_43908_Name = {
    Text = "吟诵灵魂之人Ⅲ"
  },
  Task_43909_Desc = {
    Text = "进行500次唤醒仪式"
  },
  Task_43909_Name = {
    Text = "天才守密人Ⅴ"
  },
  Task_43910_Desc = {
    Text = "进行1000次唤醒仪式"
  },
  Task_43910_Name = {
    Text = "吟诵灵魂之人Ⅰ"
  },
  Task_43911_Desc = {
    Text = "完成意识潜游「苍白后裔」困难难度"
  },
  Task_43911_Name = {
    Text = "我的德米安·困难"
  },
  Task_43916_Desc = {
    Text = "一天内更换头像超过3次"
  },
  Task_43916_Name = {
    Text = "变相怪杰"
  },
  Task_43917_Desc = {
    Text = "在宿舍内与唤醒体对话100次"
  },
  Task_43917_Name = {
    Text = "今天就聊到这里吧"
  },
  Task_43918_Desc = {
    Text = "完成密契转录250次"
  },
  Task_43918_Name = {
    Text = "感觉不对"
  },
  Task_43919_Desc = {
    Text = "完成密契转录100次"
  },
  Task_43919_Name = {
    Text = "下笔如神"
  },
  Task_43921_Desc = {
    Text = "完成密契转录500次"
  },
  Task_43921_Name = {
    Text = "再出一版"
  },
  Task_43923_Desc = {
    Text = "一次伤害到达10000"
  },
  Task_43923_Name = {
    Text = "生命不能承受之痛Ⅰ"
  },
  Task_43928_Desc = {
    Text = "与30名唤醒体同调率到达等级10"
  },
  Task_43928_Name = {
    Text = "「爱」的解析"
  },
  Task_43930_Desc = {
    Text = "与16名唤醒体同调率到达等级10"
  },
  Task_43930_Name = {
    Text = "心与灵的交谈"
  },
  Task_43932_Desc = {
    Text = "与20名唤醒体同调率到达等级10"
  },
  Task_43932_Name = {
    Text = "灵魂的读者"
  },
  Task_43934_Desc = {
    Text = "解锁拉蒙娜的本源形态"
  },
  Task_43934_Name = {
    Text = "在少女的身旁"
  },
  Task_43936_Desc = {
    Text = "与12名唤醒体同调率到达等级10"
  },
  Task_43936_Name = {
    Text = "轻轻敲开沉睡的心灵"
  },
  Task_43937_Desc = {
    Text = "累计登录300天"
  },
  Task_43937_Name = {
    Text = "一份坚持的决心"
  },
  Task_43938_Desc = {
    Text = "累计登录365天"
  },
  Task_43938_Name = {
    Text = "一个群星闪烁的夜"
  },
  Task_43943_Desc = {
    Text = "累计登录120天"
  },
  Task_43943_Name = {
    Text = "一个平凡的早晨"
  },
  Task_43944_Desc = {
    Text = "累计登录150天"
  },
  Task_43944_Name = {
    Text = "一杯平淡的咖啡"
  },
  Task_43945_Desc = {
    Text = "累计登录180天"
  },
  Task_43945_Name = {
    Text = "一场简单的对话"
  },
  Task_43946_Desc = {
    Text = "累计登录240天"
  },
  Task_43946_Name = {
    Text = "一颗炽热的心脏"
  },
  Task_43948_Desc = {
    Text = "获得30种不同的命轮"
  },
  Task_43948_Name = {
    Text = "无常的掌控者"
  },
  Task_43949_Desc = {
    Text = "获得20种不同的命轮"
  },
  Task_43949_Name = {
    Text = "命运学徒Ⅱ"
  },
  Task_43950_Desc = {
    Text = "获得10种不同的命轮"
  },
  Task_43950_Name = {
    Text = "命运学徒Ⅰ"
  },
  Task_43953_Desc = {
    Text = "获得40种不同的命轮"
  },
  Task_43953_Name = {
    Text = "编织命运之人"
  },
  Task_43957_Desc = {
    Text = "使用1次助战"
  },
  Task_43957_Name = {
    Text = "出门靠朋友"
  },
  Task_43958_Desc = {
    Text = "修改简介留言"
  },
  Task_43958_Name = {
    Text = "你好，世界！"
  },
  Task_43959_Desc = {
    Text = "被点赞1000次"
  },
  Task_43959_Name = {
    Text = "当赞誉来敲门"
  },
  Task_43961_Desc = {
    Text = "点赞100次"
  },
  Task_43961_Name = {
    Text = "走出内心的一小步"
  },
  Task_43962_Desc = {
    Text = "点赞50次"
  },
  Task_43962_Name = {
    Text = "微不足道的尝试"
  },
  Task_43964_Desc = {
    Text = "关注100名校友"
  },
  Task_43964_Name = {
    Text = "群星闪耀时"
  },
  Task_43965_Desc = {
    Text = "关注1名校友"
  },
  Task_43965_Name = {
    Text = "你的名字？"
  },
  Task_43966_Desc = {
    Text = "累计登录500天"
  },
  Task_43966_Name = {
    Text = "卡达斯的太阳照常升起"
  },
  Task_43967_Desc = {
    Text = "唤醒体激活启灵60次"
  },
  Task_43967_Name = {
    Text = "灵与心的相会Ⅴ"
  },
  Task_43968_Desc = {
    Text = "唤醒体激活启灵100次"
  },
  Task_43968_Name = {
    Text = "阴影中的等待"
  },
  Task_43969_Desc = {
    Text = "唤醒体激活启灵30次"
  },
  Task_43969_Name = {
    Text = "灵与心的相会Ⅲ"
  },
  Task_43970_Desc = {
    Text = "唤醒体激活启灵45次"
  },
  Task_43970_Name = {
    Text = "灵与心的相会Ⅳ"
  },
  Task_43972_Desc = {
    Text = "唤醒体激活启灵15次"
  },
  Task_43972_Name = {
    Text = "灵与心的相会Ⅱ"
  },
  Task_43973_Desc = {
    Text = "拥有4名80级唤醒体"
  },
  Task_43973_Name = {
    Text = "「超越之力」Ⅳ"
  },
  Task_43975_Desc = {
    Text = "唤醒体激活启灵200次"
  },
  Task_43975_Name = {
    Text = "灵与肉的融合Ⅰ"
  },
  Task_43976_Desc = {
    Text = "唤醒体激活启灵300次"
  },
  Task_43976_Name = {
    Text = "灵与肉的融合Ⅱ"
  },
  Task_44231_Desc = {
    Text = "使用超维界域唤醒体在「圣堂之路」中获胜1次"
  },
  Task_44232_Desc = {
    Text = "使用超维界域唤醒体在「圣堂之路」中获胜3次"
  },
  Task_44233_Desc = {
    Text = "使用超维界域唤醒体在「圣堂之路」中获胜2次"
  },
  Task_44234_Desc = {
    Text = "通关「争夺」任意难度"
  },
  Task_44235_Desc = {
    Text = "通关「偏执」任意难度"
  },
  Task_44236_Desc = {
    Text = "使用深海界域唤醒体在「圣堂之路」中获胜1次"
  },
  Task_44237_Desc = {
    Text = "使用混沌界域唤醒体在「圣堂之路」中获胜3次"
  },
  Task_44238_Desc = {
    Text = "使用混沌界域唤醒体在「圣堂之路」中获胜2次"
  },
  Task_44239_Desc = {
    Text = "使用混沌界域唤醒体在「圣堂之路」中获胜1次"
  },
  Task_44240_Desc = {
    Text = "使用深海界域唤醒体在「圣堂之路」中获胜3次"
  },
  Task_44241_Desc = {
    Text = "「大约翰的神奇义卖」中购买150次"
  },
  Task_44242_Desc = {
    Text = "「大约翰的神奇义卖」中购买200次"
  },
  Task_44243_Desc = {
    Text = "「大约翰的神奇义卖」中购买100次"
  },
  Task_44244_Desc = {
    Text = "「格雷太太的小店」中购买200次"
  },
  Task_44245_Desc = {
    Text = "「格雷太太的小店」中购买150次"
  },
  Task_44246_Desc = {
    Text = "「格雷太太的小店」中购买100次"
  },
  Task_44247_Desc = {
    Text = "使用血肉界域唤醒体在「圣堂之路」中获胜3次"
  },
  Task_44248_Desc = {
    Text = "使用血肉界域唤醒体在「圣堂之路」中获胜2次"
  },
  Task_44249_Desc = {
    Text = "使用血肉界域唤醒体在「圣堂之路」中获胜1次"
  },
  Task_44250_Desc = {
    Text = "通关「忏悔」任意难度"
  },
  Task_44251_Desc = {
    Text = "圣堂义卖现场"
  },
  Task_44252_Desc = {
    Text = "「史密斯特卖」中购买100次"
  },
  Task_44253_Desc = {
    Text = "「史密斯特卖」中购买200次"
  },
  Task_44254_Desc = {
    Text = "「史密斯特卖」中购买150次"
  },
  Task_44255_Desc = {
    Text = "圣堂之路·深海"
  },
  Task_44256_Desc = {
    Text = "圣堂之路·超维"
  },
  Task_44257_Desc = {
    Text = "圣堂之路·混沌"
  },
  Task_44258_Desc = {
    Text = "通关「索取」任意难度"
  },
  Task_44259_Desc = {
    Text = "完成「圣堂之路」所有关卡任意难度"
  },
  Task_44260_Desc = {
    Text = "通关「指责」任意难度"
  },
  Task_44261_Desc = {
    Text = "使用深海界域唤醒体在「圣堂之路」中获胜2次"
  },
  Task_44262_Desc = {
    Text = "圣堂之路·血肉"
  },
  Task_44263_Desc = {
    Text = "圣堂之路·滋长"
  },
  Task_44264_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_44567_Desc = {
    Text = "阻止索菲亚"
  },
  Task_44567_Name = {Text = "目标"},
  Task_45665_Desc = {
    Text = "完成意识潜游「巨人的陨落」普通模式"
  },
  Task_45665_Name = {
    Text = "通关奖励"
  },
  Task_45666_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_46575_Desc = {
    Text = "使用超维界域唤醒体通关「无意识记」任意难度"
  },
  Task_46576_Desc = {
    Text = "通关「镜子」任意难度"
  },
  Task_46577_Desc = {
    Text = "使用血肉界域唤醒体通关「爬虫脑」任意难度"
  },
  Task_46578_Desc = {
    Text = "记忆编码·血肉"
  },
  Task_46579_Desc = {
    Text = "通关「爬虫脑」任意难度"
  },
  Task_46580_Desc = {
    Text = "使用血肉界域唤醒体通关「无意识记」任意难度"
  },
  Task_46581_Desc = {
    Text = "记忆编码·深海"
  },
  Task_46582_Desc = {
    Text = "通关「无意识记」任意难度"
  },
  Task_46583_Desc = {
    Text = "使用混沌界域唤醒体通关「遗忘曲线」任意难度"
  },
  Task_46584_Desc = {
    Text = "使用混沌界域唤醒体通关「镜子」任意难度"
  },
  Task_46585_Desc = {
    Text = "使用混沌界域唤醒体通关「杏仁体」任意难度"
  },
  Task_46586_Desc = {
    Text = "使用混沌界域唤醒体通关「爬虫脑」任意难度"
  },
  Task_46587_Desc = {
    Text = "使用混沌界域唤醒体通关「无意识记」任意难度"
  },
  Task_46588_Desc = {
    Text = "使用深海界域唤醒体通关「镜子」任意难度"
  },
  Task_46589_Desc = {
    Text = "使用深海界域唤醒体通关「遗忘曲线」任意难度"
  },
  Task_46590_Desc = {
    Text = "使用深海界域唤醒体通关「无意识记」任意难度"
  },
  Task_46591_Desc = {
    Text = "使用深海界域唤醒体通关「爬虫脑」任意难度"
  },
  Task_46592_Desc = {
    Text = "使用深海界域唤醒体通关「杏仁体」任意难度"
  },
  Task_46593_Desc = {
    Text = "完成「记忆编码」所有关卡任意难度"
  },
  Task_46594_Desc = {
    Text = "通关「遗忘曲线」任意难度"
  },
  Task_46595_Desc = {
    Text = "记忆编码·混沌"
  },
  Task_46596_Desc = {
    Text = "通关「杏仁体」任意难度"
  },
  Task_46597_Desc = {
    Text = "使用超维界域唤醒体通关「遗忘曲线」任意难度"
  },
  Task_46598_Desc = {
    Text = "使用超维界域唤醒体通关「镜子」任意难度"
  },
  Task_46599_Desc = {
    Text = "使用血肉界域唤醒体通关「遗忘曲线」任意难度"
  },
  Task_46600_Desc = {
    Text = "使用血肉界域唤醒体通关「镜子」任意难度"
  },
  Task_46601_Desc = {
    Text = "使用血肉界域唤醒体通关「杏仁体」任意难度"
  },
  Task_46602_Desc = {
    Text = "记忆编码·涌现"
  },
  Task_46603_Desc = {
    Text = "使用超维界域唤醒体通关「杏仁体」任意难度"
  },
  Task_46604_Desc = {
    Text = "使用超维界域唤醒体通关「爬虫脑」任意难度"
  },
  Task_46605_Desc = {
    Text = "记忆编码·超维"
  },
  Task_46624_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_46798_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46798_Name = {Text = "200分"},
  Task_46799_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46799_Name = {Text = "450分"},
  Task_46806_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46806_Name = {Text = "50分"},
  Task_46807_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46807_Name = {Text = "100分"},
  Task_46808_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46808_Name = {Text = "150分"},
  Task_46809_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46809_Name = {Text = "1500分"},
  Task_46810_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46810_Name = {Text = "250分"},
  Task_46811_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46811_Name = {Text = "300分"},
  Task_46812_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46812_Name = {Text = "350分"},
  Task_46821_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_46821_Name = {Text = "6胜"},
  Task_46822_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_46822_Name = {Text = "3胜"},
  Task_46823_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_46823_Name = {Text = "1胜"},
  Task_46826_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46826_Name = {Text = "1450分"},
  Task_46827_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46827_Name = {Text = "1400分"},
  Task_46828_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46828_Name = {Text = "1350分"},
  Task_46829_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46829_Name = {Text = "1300分"},
  Task_46830_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46830_Name = {Text = "1250分"},
  Task_46831_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46831_Name = {Text = "1200分"},
  Task_46832_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46832_Name = {Text = "1150分"},
  Task_46833_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46833_Name = {Text = "1100分"},
  Task_46834_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46834_Name = {Text = "1050分"},
  Task_46835_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46835_Name = {Text = "1000分"},
  Task_46836_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46836_Name = {Text = "600分"},
  Task_46837_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46837_Name = {Text = "650分"},
  Task_46838_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46838_Name = {Text = "500分"},
  Task_46839_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46839_Name = {Text = "550分"},
  Task_46840_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46840_Name = {Text = "800分"},
  Task_46841_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46841_Name = {Text = "850分"},
  Task_46842_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46842_Name = {Text = "700分"},
  Task_46843_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46843_Name = {Text = "750分"},
  Task_46844_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46844_Name = {Text = "900分"},
  Task_46845_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46845_Name = {Text = "950分"},
  Task_46846_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_46846_Name = {Text = "10胜"},
  Task_46847_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_46847_Name = {Text = "400分"},
  Task_46850_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_46850_Name = {Text = "10胜"},
  Task_46852_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_46852_Name = {Text = "3胜"},
  Task_46853_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_46853_Name = {Text = "6胜"},
  Task_46854_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_46854_Name = {Text = "1胜"},
  Task_47794_Desc = {
    Text = "通关无光之境所有界域间隙Ⅶ"
  },
  Task_47795_Desc = {
    Text = "通关无光之境所有界域间隙Ⅰ"
  },
  Task_47796_Desc = {
    Text = "通关无光之境所有界域间隙Ⅲ"
  },
  Task_47797_Desc = {
    Text = "通关无光之境所有界域间隙Ⅴ"
  },
  Task_47799_Desc = {
    Text = "通关无光之境所有界域间隙Ⅳ"
  },
  Task_47800_Desc = {
    Text = "通关无光之境所有界域间隙Ⅵ"
  },
  Task_47801_Desc = {
    Text = "通关无光之境所有界域间隙Ⅷ"
  },
  Task_47802_Desc = {
    Text = "通关无光之境所有界域间隙Ⅱ"
  },
  Task_48166_Desc = {
    Text = "击退罗杰斯等人"
  },
  Task_48166_Name = {Text = "目标"},
  Task_48167_Desc = {
    Text = "战胜影子「24」"
  },
  Task_48167_Name = {Text = "目标"},
  Task_48733_CompleteCondDesc = {
    Text = "派遣总等级>={s1}"
  },
  Task_48733_Desc = {
    Text = "从倒塌的教堂和破碎的文物中，博物馆获得它们的珍藏，你获得你的珍藏。\n你们各取所需。"
  },
  Task_48733_Name = {
    Text = "调查任务：泛神信仰"
  },
  Task_48733_UnlockCondDesc = {
    Text = "守密人 40 级开放"
  },
  Task_48734_CompleteCondDesc = {
    Text = "派遣总等级>={s1}"
  },
  Task_48734_Desc = {
    Text = "忘掉你的认知，忘掉你的目的。\n真相是什么，它们会告诉你。"
  },
  Task_48734_Name = {
    Text = "调查任务：先验理论"
  },
  Task_48734_UnlockCondDesc = {
    Text = "守密人 30 级开放"
  },
  Task_48735_CompleteCondDesc = {
    Text = "派遣总等级>={s1}"
  },
  Task_48735_Desc = {
    Text = "地理是高位者的谎言。\n小心那些等高线。"
  },
  Task_48735_Name = {
    Text = "调查任务：勘察测绘"
  },
  Task_48735_UnlockCondDesc = {
    Text = "守密人 20 级开放"
  },
  Task_48736_CompleteCondDesc = {
    Text = "派遣总等级>={s1}"
  },
  Task_48736_Desc = {
    Text = "收获两段不可信任的承诺，和一场难以忘怀的梦。"
  },
  Task_48736_Name = {
    Text = "调查任务：秘境幻影"
  },
  Task_48736_UnlockCondDesc = {
    Text = "守密人 50 级开放"
  },
  Task_48775_Desc = {
    Text = "莉莉同调率达到 10 级"
  },
  Task_48776_Desc = {
    Text = "奥瑞塔同调率达到 10 级"
  },
  Task_48777_Desc = {
    Text = "菲茵特同调率达到 10 级"
  },
  Task_48778_Desc = {
    Text = "旺达同调率达到 10 级"
  },
  Task_48779_Desc = {
    Text = "詹金同调率达到 10 级"
  },
  Task_48780_Desc = {
    Text = "奥吉尔同调率达到 10 级"
  },
  Task_48781_Desc = {
    Text = "莉兹同调率达到 10 级"
  },
  Task_48782_Desc = {
    Text = "达芙黛尔同调率达到 10 级"
  },
  Task_48783_Desc = {
    Text = "朵尔同调率达到 10 级"
  },
  Task_48784_Desc = {
    Text = "希莱斯特同调率达到 10 级"
  },
  Task_48785_Desc = {
    Text = "艾继丝同调率达到 10 级"
  },
  Task_48786_Desc = {
    Text = "墨菲同调率达到 10 级"
  },
  Task_48787_Desc = {
    Text = "珊同调率达到 10 级"
  },
  Task_48788_Desc = {
    Text = "尤乌哈希同调率达到 10 级"
  },
  Task_48789_Desc = {
    Text = "诺缔拉同调率达到 10 级"
  },
  Task_48790_Desc = {
    Text = "「24」同调率达到 10 级"
  },
  Task_48791_Desc = {
    Text = "阿格里帕同调率达到 10 级"
  },
  Task_48792_Desc = {
    Text = "法洛思同调率达到 10 级"
  },
  Task_48793_Desc = {
    Text = "温柯尔同调率达到 10 级"
  },
  Task_48794_Desc = {
    Text = "萨尔瓦多同调率达到 10 级"
  },
  Task_48795_Desc = {
    Text = "希洛同调率达到 10 级"
  },
  Task_48796_Desc = {
    Text = "艾瑞卡同调率达到 10 级"
  },
  Task_48797_Desc = {
    Text = "拉蒙娜同调率达到 10 级"
  },
  Task_48798_Desc = {
    Text = "索蕾尔同调率达到 10 级"
  },
  Task_48799_Desc = {
    Text = "泰旖丝同调率达到 10 级"
  },
  Task_48800_Desc = {
    Text = "戈利亚同调率达到 10 级"
  },
  Task_48801_Desc = {
    Text = "雷娅同调率达到 10 级"
  },
  Task_48802_Desc = {
    Text = "艾尔瓦同调率达到 10 级"
  },
  Task_48803_Desc = {
    Text = "凯刻斯同调率达到 10 级"
  },
  Task_48804_Desc = {
    Text = "图鲁同调率达到 10 级"
  },
  Task_48805_Desc = {
    Text = "卡茜亚同调率达到 10 级"
  },
  Task_48806_Desc = {
    Text = "珈伦同调率达到 10 级"
  },
  Task_48807_Desc = {
    Text = "潘狄娅同调率达到 10 级"
  },
  Task_48808_Desc = {
    Text = "汀克特同调率达到 10 级"
  },
  Task_48809_Desc = {
    Text = "宁菲亚同调率达到 10 级"
  },
  Task_48810_Desc = {
    Text = "萝坦同调率达到 10 级"
  },
  Task_48829_Desc = {
    Text = "累计登录 11 天"
  },
  Task_48830_Desc = {
    Text = "累计登录 14 天"
  },
  Task_48831_Desc = {
    Text = "累计登录 1 天"
  },
  Task_48832_Desc = {
    Text = "累计登录 16 天"
  },
  Task_48833_Desc = {
    Text = "累计登录 12 天"
  },
  Task_48834_Desc = {
    Text = "累计登录 13 天"
  },
  Task_48835_Desc = {
    Text = "累计登录 10 天"
  },
  Task_48836_Desc = {
    Text = "累计登录 5 天"
  },
  Task_48837_Desc = {
    Text = "累计登录 6 天"
  },
  Task_48838_Desc = {
    Text = "累计登录 7 天"
  },
  Task_48839_Desc = {
    Text = "累计登录 2 天"
  },
  Task_48840_Desc = {
    Text = "累计登录 3 天"
  },
  Task_48841_Desc = {
    Text = "累计登录 8 天"
  },
  Task_48842_Desc = {
    Text = "累计登录 9 天"
  },
  Task_48843_Desc = {
    Text = "累计登录 15 天"
  },
  Task_48844_Desc = {
    Text = "累计登录 4 天"
  },
  Task_49241_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_49241_Name = {Text = "1胜"},
  Task_49242_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_49242_Name = {Text = "3胜"},
  Task_49243_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_49243_Name = {Text = "6胜"},
  Task_49244_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_49244_Name = {Text = "10胜"},
  Task_49245_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_49245_Name = {Text = "10胜"},
  Task_49246_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_49246_Name = {Text = "1胜"},
  Task_49247_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_49247_Name = {Text = "6胜"},
  Task_49248_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_49248_Name = {Text = "3胜"},
  Task_49262_Desc = {
    Text = "最终战30回合内取胜"
  },
  Task_49262_Name = {
    Text = "最终战30回合内取胜"
  },
  Task_49380_Desc = {
    Text = "通关「再生花」任意难度"
  },
  Task_49381_Desc = {
    Text = "紊乱情欲·重现"
  },
  Task_49382_Desc = {
    Text = "完成「紊乱情欲·通关」所有任务"
  },
  Task_49383_Desc = {
    Text = "紊乱情欲·通关"
  },
  Task_49384_Desc = {
    Text = "通关「多胚生殖」任意难度"
  },
  Task_49385_Desc = {
    Text = "通关「落果」任意难度"
  },
  Task_49386_Desc = {
    Text = "在「紊乱情欲」中重现 30 次"
  },
  Task_49387_Desc = {
    Text = "通关「蜜腺」任意难度"
  },
  Task_49388_Desc = {
    Text = "在「紊乱情欲」中重现 10 次"
  },
  Task_49389_Desc = {
    Text = "通关「幼根」任意难度"
  },
  Task_49390_Desc = {
    Text = "通关「出芽」任意难度"
  },
  Task_49391_Desc = {
    Text = "在「紊乱情欲」中重现 20 次"
  },
  Task_49392_Desc = {
    Text = "在「紊乱情欲」中重现 50 次"
  },
  Task_49393_Desc = {
    Text = "在「紊乱情欲」中重现 40 次"
  },
  Task_49394_Desc = {
    Text = "通关「花萼」任意难度"
  },
  Task_49395_Desc = {
    Text = "通关「胚珠」任意难度"
  },
  Task_49396_Desc = {
    Text = "通关「授粉」任意难度"
  },
  Task_49397_Desc = {
    Text = "通关「年轮」任意难度"
  },
  Task_49769_Desc = {
    Text = "最终战一回合至少叠加最大生命50%的护盾"
  },
  Task_49769_Name = {
    Text = "钢铁之躯"
  },
  Task_49770_Desc = {
    Text = "精英战中一回合造成至少3000点伤害"
  },
  Task_49770_Name = {
    Text = "全力一击"
  },
  Task_49771_Desc = {
    Text = "任一战斗中一回合击杀至少2只怪物"
  },
  Task_49771_Name = {
    Text = "斩草除根"
  },
  Task_49772_Desc = {
    Text = "通关时携带至少1个诅咒造物"
  },
  Task_49772_Name = {
    Text = "奇兵秘藏"
  },
  Task_49773_Desc = {
    Text = "获得至少4种不同种类刻印"
  },
  Task_49773_Name = {
    Text = "灵魂烙印"
  },
  Task_49774_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_49774_Name = {
    Text = "优雅而精准"
  },
  Task_49775_Desc = {
    Text = "最终战一回合打出至少7张卡牌"
  },
  Task_49775_Name = {
    Text = "我的回合"
  },
  Task_49776_Desc = {
    Text = "通关时觉醒所有唤醒体"
  },
  Task_49776_Name = {
    Text = "无限抱拥"
  },
  Task_49777_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_49777_Name = {
    Text = "节能主义"
  },
  Task_49778_Desc = {
    Text = "任一战斗中一回合击杀至少2只怪物"
  },
  Task_49778_Name = {
    Text = "斩草除根"
  },
  Task_49779_Desc = {
    Text = "通关时携带至少1个诅咒造物"
  },
  Task_49779_Name = {
    Text = "奇兵秘藏"
  },
  Task_49780_Desc = {
    Text = "获得至少4种不同种类刻印"
  },
  Task_49780_Name = {
    Text = "灵魂烙印"
  },
  Task_49781_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_49781_Name = {
    Text = "优雅而精准"
  },
  Task_49782_Desc = {
    Text = "最终战一回合打出至少7张卡牌"
  },
  Task_49782_Name = {
    Text = "我的回合"
  },
  Task_49783_Desc = {
    Text = "通关时觉醒所有唤醒体"
  },
  Task_49783_Name = {
    Text = "无限抱拥"
  },
  Task_49784_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_49784_Name = {
    Text = "节能主义"
  },
  Task_49785_Desc = {
    Text = "最终战一回合至少叠加最大生命50%的护盾"
  },
  Task_49785_Name = {
    Text = "钢铁之躯"
  },
  Task_49786_Desc = {
    Text = "精英战中一回合造成至少4500点伤害"
  },
  Task_49786_Name = {
    Text = "全力一击"
  },
  Task_49787_Desc = {
    Text = "精英战中一回合造成至少7300点伤害"
  },
  Task_49787_Name = {
    Text = "全力一击"
  },
  Task_49788_Desc = {
    Text = "获得至少6种不同种类刻印"
  },
  Task_49788_Name = {
    Text = "灵魂烙印"
  },
  Task_49789_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_49789_Name = {
    Text = "优雅而精准"
  },
  Task_49790_Desc = {
    Text = "通关时携带至少7个造物"
  },
  Task_49790_Name = {
    Text = "奇兵秘藏"
  },
  Task_49791_Desc = {
    Text = "通关时不使用联络点回复生命"
  },
  Task_49791_Name = {
    Text = "无火之人"
  },
  Task_49792_Desc = {
    Text = "精英战中一回合造成至少9000点伤害"
  },
  Task_49792_Name = {
    Text = "全力一击"
  },
  Task_49793_Desc = {
    Text = "获得至少6种不同种类刻印"
  },
  Task_49793_Name = {
    Text = "灵魂烙印"
  },
  Task_49794_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_49794_Name = {
    Text = "优雅而精准"
  },
  Task_49795_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_49795_Name = {
    Text = "速战速决"
  },
  Task_49796_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_49796_Name = {
    Text = "速战速决"
  },
  Task_49797_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_49797_Name = {
    Text = "速战速决"
  },
  Task_49798_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_49798_Name = {
    Text = "速战速决"
  },
  Task_49799_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_49799_Name = {
    Text = "速战速决"
  },
  Task_49800_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_49800_Name = {
    Text = "速战速决"
  },
  Task_49801_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_49801_Name = {
    Text = "速战速决"
  },
  Task_49802_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_49802_Name = {
    Text = "速战速决"
  },
  Task_49803_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_49803_Name = {
    Text = "速战速决"
  },
  Task_49804_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_49804_Name = {
    Text = "完美通过"
  },
  Task_49805_Desc = {
    Text = "通关时携带至少7个造物"
  },
  Task_49805_Name = {
    Text = "奇兵秘藏"
  },
  Task_49806_Desc = {
    Text = "通关时不使用联络点回复生命"
  },
  Task_49806_Name = {
    Text = "无火之人"
  },
  Task_49807_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_49807_Name = {
    Text = "完美通过"
  },
  Task_49808_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_49808_Name = {
    Text = "完美通过"
  },
  Task_49809_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_49809_Name = {
    Text = "完美通过"
  },
  Task_49810_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_49810_Name = {
    Text = "完美通过"
  },
  Task_49811_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_49811_Name = {
    Text = "完美通过"
  },
  Task_49812_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_49812_Name = {
    Text = "完美通过"
  },
  Task_49813_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_49813_Name = {
    Text = "完美通过"
  },
  Task_49814_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_49814_Name = {
    Text = "完美通过"
  },
  Task_49815_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_49815_Name = {
    Text = "完美通过"
  },
  Task_49816_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_49816_Name = {
    Text = "完美通过"
  },
  Task_49817_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_49817_Name = {
    Text = "节能主义"
  },
  Task_49818_Desc = {
    Text = "最终战中一回合击杀至少4只怪物"
  },
  Task_49818_Name = {
    Text = "斩草除根"
  },
  Task_49819_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_49819_Name = {
    Text = "节能主义"
  },
  Task_49820_Desc = {
    Text = "最终战中一回合击杀至少4只怪物"
  },
  Task_49820_Name = {
    Text = "斩草除根"
  },
  Task_49821_Desc = {
    Text = "最终战不超过18回合取胜"
  },
  Task_49821_Name = {
    Text = "速战速决"
  },
  Task_49822_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_49822_Name = {
    Text = "速战速决"
  },
  Task_49823_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_49823_Name = {
    Text = "速战速决"
  },
  Task_49824_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_49824_Name = {
    Text = "完美通过"
  },
  Task_49852_Desc = {
    Text = "清理威胁营地的努比亚"
  },
  Task_49852_Name = {Text = "目标"},
  Task_49853_Desc = {
    Text = "在风暴之壁中前行"
  },
  Task_49853_Name = {Text = "目标"},
  Task_49854_Desc = {
    Text = "绑架亚兰士兵问出遗骸所在"
  },
  Task_49854_Name = {Text = "目标"},
  Task_49855_Desc = {
    Text = "寻找水源"
  },
  Task_49855_Name = {Text = "目标"},
  Task_49856_Desc = {
    Text = "击败卡茜亚，夺回遗骸"
  },
  Task_49856_Name = {Text = "目标"},
  Task_49857_Desc = {
    Text = "和泰旖丝共同作战"
  },
  Task_49857_Name = {Text = "目标"},
  Task_49858_Desc = {
    Text = "逃离卡茜亚的魔爪"
  },
  Task_49858_Name = {Text = "目标"},
  Task_49859_Desc = {
    Text = "阻止母树复生仪式"
  },
  Task_49859_Name = {Text = "目标"},
  Task_49860_Desc = {
    Text = "深入丰穰母树意识之海"
  },
  Task_49860_Name = {Text = "目标"},
  Task_49861_Desc = {
    Text = "帮亚兰人驱逐努比亚"
  },
  Task_49861_Name = {Text = "目标"},
  Task_49862_Desc = {
    Text = "寻找母树遗骸"
  },
  Task_49862_Name = {Text = "目标"},
  Task_49863_Desc = {
    Text = "击败母树"
  },
  Task_49863_Name = {Text = "目标"},
  Task_49879_Desc = {
    Text = "环行·拉蒙娜同调率达到 10 级"
  },
  Task_50033_Desc = {
    Text = "在调查事件「@1@2」中共鸣6次"
  },
  Task_50033_Desc2 = {
    Text = "在调查事件「欲河」中共鸣6次"
  },
  Task_50033_Name = {Text = "@1@2"},
  Task_50033_Name2 = {
    Text = "妄念回响Ⅱ"
  },
  Task_50034_Desc = {
    Text = "在调查事件「@1@2」中共鸣9次"
  },
  Task_50034_Desc2 = {
    Text = "在调查事件「欲河」中共鸣9次"
  },
  Task_50034_Name = {Text = "@1@2"},
  Task_50034_Name2 = {
    Text = "妄念回响Ⅲ"
  },
  Task_50035_Desc = {
    Text = "找到12处主线第七章「@1@2」的析出点"
  },
  Task_50035_Desc2 = {
    Text = "找到12处主线第七章「欲河」的析出点"
  },
  Task_50035_Name = {Text = "@1@2"},
  Task_50035_Name2 = {
    Text = "潜藏的低语Ⅶ"
  },
  Task_50036_Desc = {
    Text = "在调查事件「@1@2」中共鸣3次"
  },
  Task_50036_Desc2 = {
    Text = "在调查事件「欲河」中共鸣3次"
  },
  Task_50036_Name = {Text = "@1@2"},
  Task_50036_Name2 = {
    Text = "妄念回响"
  },
  Task_50037_Desc = {
    Text = "完成调查事件「@1@2」"
  },
  Task_50037_Desc2 = {
    Text = "完成调查事件「欲河」"
  },
  Task_50037_Name = {Text = "@1@2"},
  Task_50037_Name2 = {
    Text = "圣树焚尽之时"
  },
  Task_50038_Desc = {
    Text = "完成调查事件「欲河」困难难度"
  },
  Task_50038_Name = {
    Text = "圣树焚尽之时·困难"
  },
  Task_50039_Desc = {
    Text = "在调查事件「@1@2」中共鸣11次"
  },
  Task_50039_Desc2 = {
    Text = "在调查事件「欲河」中共鸣11次"
  },
  Task_50039_Name = {Text = "@1@2"},
  Task_50039_Name2 = {
    Text = "妄念回响Ⅳ"
  },
  Task_51106_Desc = {
    Text = "使用深海界域唤醒体在「剧本迷思」中获胜2次"
  },
  Task_51107_Desc = {
    Text = "完成「剧本迷思·通关」所有任务"
  },
  Task_51108_Desc = {
    Text = "通关「情节轮转」任意难度"
  },
  Task_51109_Desc = {
    Text = "特遣纪录"
  },
  Task_51109_Name = {
    Text = "【已废弃】"
  },
  Task_51110_Desc = {
    Text = "使用深海界域唤醒体在「剧本迷思」中获胜1次"
  },
  Task_51111_Desc = {
    Text = "剧本迷思·界域"
  },
  Task_51112_Desc = {
    Text = "使用混沌界域唤醒体在「剧本迷思」中获胜1次"
  },
  Task_51113_Desc = {
    Text = "使用超维界域唤醒体在「剧本迷思」中获胜2次"
  },
  Task_51114_Desc = {
    Text = "通关「卡塔西斯」任意难度"
  },
  Task_51115_Desc = {
    Text = "使用混沌界域唤醒体在「剧本迷思」中获胜2次"
  },
  Task_51116_Desc = {
    Text = "通关「假面喜剧」任意难度"
  },
  Task_51117_Desc = {
    Text = "通关「三一律」任意难度"
  },
  Task_51118_Desc = {
    Text = "使用超维界域唤醒体在「剧本迷思」中获胜1次"
  },
  Task_51119_Desc = {
    Text = "通关「弧光理论」任意难度"
  },
  Task_51120_Desc = {
    Text = "通关「剧作金字塔」任意难度"
  },
  Task_51121_Desc = {
    Text = "使用血肉界域唤醒体在「剧本迷思」中获胜1次"
  },
  Task_51122_Desc = {
    Text = "通关「戏剧的第四壁」任意难度"
  },
  Task_51123_Desc = {
    Text = "通关「陌生化效果」任意难度"
  },
  Task_51124_Desc = {
    Text = "剧本迷思·通关"
  },
  Task_51125_Desc = {
    Text = "使用血肉界域唤醒体在「剧本迷思」中获胜2次"
  },
  Task_51126_Desc = {
    Text = "通关「静场时刻」任意难度"
  },
  Task_51140_Desc = {
    Text = "通关特遣纪录「故事的魔法」"
  },
  Task_51141_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_51141_Name = {
    Text = "【已废弃】"
  },
  Task_51142_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_51142_Name = {
    Text = "【已废弃】"
  },
  Task_51143_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_51143_Name = {
    Text = "【已废弃】"
  },
  Task_51144_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_51144_Name = {
    Text = "【已废弃】"
  },
  Task_51145_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_51145_Name = {
    Text = "【已废弃】"
  },
  Task_51146_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_51146_Name = {
    Text = "【已废弃】"
  },
  Task_52280_Desc = {
    Text = "「莹泪祭坛」进献祭品获得100次奖赏"
  },
  Task_52281_Desc = {
    Text = "「莹泪祭坛」进献祭品获得200次奖赏"
  },
  Task_52282_Desc = {
    Text = "使用混沌界域唤醒体在「沉渊之祀」中获胜2次"
  },
  Task_52283_Desc = {
    Text = "沉渊之祀·通关"
  },
  Task_52284_Desc = {
    Text = "通关「见证」任意难度"
  },
  Task_52285_Desc = {
    Text = "使用深海界域唤醒体在「沉渊之祀」中获胜1次"
  },
  Task_52286_Desc = {
    Text = "使用深海界域唤醒体在「沉渊之祀」中获胜2次"
  },
  Task_52287_Desc = {
    Text = "通关「笃信」任意难度"
  },
  Task_52288_Desc = {
    Text = "使用混沌界域唤醒体在「沉渊之祀」中获胜1次"
  },
  Task_52289_Desc = {
    Text = "使用血肉界域唤醒体在「沉渊之祀」中获胜1次"
  },
  Task_52290_Desc = {
    Text = "沉渊之祀·界域"
  },
  Task_52291_Desc = {
    Text = "通关异梦视界「亵渎」"
  },
  Task_52292_Desc = {
    Text = "「猩血祭坛」进献祭品获得100次奖赏"
  },
  Task_52293_Desc = {
    Text = "「猩血祭坛」进献祭品获得200次奖赏"
  },
  Task_52294_Desc = {
    Text = "「灵髓祭坛」进献祭品获得200次奖赏"
  },
  Task_52295_Desc = {
    Text = "「灵髓祭坛」进献祭品获得100次奖赏"
  },
  Task_52296_Desc = {
    Text = "通关「质疑」任意难度"
  },
  Task_52297_Desc = {
    Text = "通关「动摇」任意难度"
  },
  Task_52298_Desc = {
    Text = "使用血肉界域唤醒体在「沉渊之祀」中获胜2次"
  },
  Task_52299_Desc = {
    Text = "使用超维界域唤醒体在「沉渊之祀」中获胜1次"
  },
  Task_52300_Desc = {
    Text = "通关「降临」任意难度"
  },
  Task_52301_Desc = {
    Text = "使用超维界域唤醒体在「沉渊之祀」中获胜2次"
  },
  Task_52302_Desc = {
    Text = "沉渊的回应"
  },
  Task_52303_Desc = {
    Text = "完成「沉渊之祀·通关」和「沉渊的回应」所有任务"
  },
  Task_53694_Desc = {
    Text = "「精粹活性离子」达到1000"
  },
  Task_53695_Desc = {
    Text = "累计完成20次派遣"
  },
  Task_53696_Desc = {
    Text = "返校报到第1天"
  },
  Task_53697_Desc = {
    Text = "使用混沌界域唤醒体取得3场胜利"
  },
  Task_53698_Desc = {
    Text = "在校友会为其他人点赞 10 次"
  },
  Task_53699_Desc = {
    Text = "返校报到第6天"
  },
  Task_53700_Desc = {
    Text = "返校报到第5天"
  },
  Task_53701_Desc = {Text = "第四天"},
  Task_53702_Desc = {Text = "第二天"},
  Task_53703_Desc = {Text = "第三天"},
  Task_53704_Desc = {Text = "第一天"},
  Task_53705_Desc = {
    Text = "使用超维界域唤醒体取得3场胜利"
  },
  Task_53706_Desc = {
    Text = "返校报到第4天"
  },
  Task_53707_Desc = {
    Text = "使用血肉界域唤醒体取得3场胜利"
  },
  Task_53708_Desc = {
    Text = "使用深海界域唤醒体取得3场胜利"
  },
  Task_53709_Desc = {
    Text = "返校报到第2天"
  },
  Task_53710_Desc = {
    Text = "完成任意一次唤醒体培养"
  },
  Task_53711_Desc = {
    Text = "累计消耗50000蔷薇金券"
  },
  Task_53712_Desc = {
    Text = "累计消耗1500点灵啡肽"
  },
  Task_53713_Desc = {
    Text = "「精粹活性离子」达到500"
  },
  Task_53714_Desc = {
    Text = "累计消耗50w蔷薇金券"
  },
  Task_53715_Desc = {
    Text = "在任意唤醒活动中进行累计20次唤醒仪式"
  },
  Task_53716_Desc = {
    Text = "通关一次无光之境或超验存在"
  },
  Task_53717_Desc = {
    Text = "使用校友的唤醒体助战10次"
  },
  Task_53718_Desc = {
    Text = "返校报到第3天"
  },
  Task_53719_Desc = {
    Text = "使用校友的唤醒体助战"
  },
  Task_53720_Desc = {
    Text = "在商店中使用金券进行 3 次兑换"
  },
  Task_53721_Desc = {
    Text = "消耗180点灵啡肽"
  },
  Task_53722_Desc = {
    Text = "执行 3 次派遣"
  },
  Task_53723_Desc = {
    Text = "返校报到第7天"
  },
  Task_53724_Desc = {
    Text = "「基础活性离子」达到1000"
  },
  Task_53725_Desc = {
    Text = "完成 1 次唤醒体试玩关卡"
  },
  Task_53726_Desc = {
    Text = "进行 1 次唤醒"
  },
  Task_53982_Desc = {
    Text = "使用混沌界域唤醒体在「蔷薇忆事」中获胜1次"
  },
  Task_53983_Desc = {
    Text = "通关「傀儡游戏」任意难度"
  },
  Task_53984_Desc = {
    Text = "通关「目光」任意难度"
  },
  Task_53985_Desc = {
    Text = "使用血肉界域唤醒体在「蔷薇忆事」中获胜2次"
  },
  Task_53986_Desc = {
    Text = "使用血肉界域唤醒体在「蔷薇忆事」中获胜1次"
  },
  Task_53987_Desc = {
    Text = "使用混沌界域唤醒体在「蔷薇忆事」中获胜2次"
  },
  Task_53988_Desc = {
    Text = "蔷薇忆事·界域"
  },
  Task_53989_Desc = {
    Text = "使用深海界域唤醒体在「蔷薇忆事」中获胜1次"
  },
  Task_53990_Desc = {
    Text = "使用深海界域唤醒体在「蔷薇忆事」中获胜2次"
  },
  Task_53991_Desc = {
    Text = "完成「蔷薇忆事·通关」所有任务"
  },
  Task_53992_Desc = {
    Text = "通关「未完的剧本」任意难度"
  },
  Task_53993_Desc = {
    Text = "使用超维界域唤醒体在「蔷薇忆事」中获胜1次"
  },
  Task_53994_Desc = {
    Text = "通关「蔷薇角」任意难度"
  },
  Task_53995_Desc = {
    Text = "蔷薇忆事·通关"
  },
  Task_53996_Desc = {
    Text = "使用超维界域唤醒体在「蔷薇忆事」中获胜2次"
  },
  Task_53997_Desc = {
    Text = "通关「长腿叔叔」任意难度"
  },
  Task_53998_Desc = {
    Text = "通关「礼物」任意难度"
  },
  Task_53999_Desc = {
    Text = "通关「终曲」任意难度"
  },
  Task_54000_Desc = {
    Text = "通关「釜底游鱼」任意难度"
  },
  Task_54001_Desc = {
    Text = "通关「脸」任意难度"
  },
  Task_54542_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_54542_Name = {Text = "1胜"},
  Task_54543_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_54543_Name = {Text = "6胜"},
  Task_54544_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_54544_Name = {Text = "3胜"},
  Task_54545_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_54545_Name = {Text = "10胜"},
  Task_54546_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_54546_Name = {Text = "1胜"},
  Task_54547_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_54547_Name = {Text = "10胜"},
  Task_54548_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_54548_Name = {Text = "10胜"},
  Task_54549_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_54549_Name = {Text = "6胜"},
  Task_54550_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_54550_Name = {Text = "1胜"},
  Task_54551_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_54551_Name = {Text = "3胜"},
  Task_54552_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_54552_Name = {Text = "6胜"},
  Task_54553_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_54553_Name = {Text = "3胜"},
  Task_54554_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_54554_Name = {Text = "6胜"},
  Task_54555_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_54555_Name = {Text = "1胜"},
  Task_54556_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_54556_Name = {Text = "10胜"},
  Task_54557_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_54557_Name = {Text = "3胜"},
  Task_54585_Desc = {
    Text = "累计提取 1000 源液"
  },
  Task_54586_Desc = {
    Text = "累计提取 3000 源液"
  },
  Task_54587_Desc = {
    Text = "累计提取 6000 源液"
  },
  Task_54588_Desc = {
    Text = "累计提取 10000 源液"
  },
  Task_54589_Desc = {
    Text = "累计提取 30000 源液"
  },
  Task_54590_Desc = {
    Text = "累计提取 60000 源液"
  },
  Task_54591_Desc = {
    Text = "累计提取 100000 源液"
  },
  Task_55092_Desc = {
    Text = "完成本章所有任务后可领取"
  },
  Task_55092_Name = {
    Text = "界域精通Ⅶ"
  },
  Task_55093_Desc = {
    Text = "完成本章所有任务后可领取"
  },
  Task_55093_Name = {
    Text = "界域精通Ⅵ"
  },
  Task_55094_Desc = {
    Text = "将3名血肉角色提升至60级"
  },
  Task_55094_Name = {
    Text = "界域精通Ⅶ"
  },
  Task_55095_Desc = {
    Text = "将3名深海角色提升至60级"
  },
  Task_55095_Name = {
    Text = "界域精通Ⅶ"
  },
  Task_55096_Desc = {
    Text = "将3名混沌角色提升至60级"
  },
  Task_55096_Name = {
    Text = "界域精通Ⅶ"
  },
  Task_55097_Desc = {
    Text = "完成本章所有任务后可领取"
  },
  Task_55097_Name = {
    Text = "界域精通Ⅷ"
  },
  Task_55098_Desc = {
    Text = "将3名超维角色提升至60级"
  },
  Task_55098_Name = {
    Text = "界域精通Ⅶ"
  },
  Task_55099_Desc = {
    Text = "将1名超维角色提升至60级"
  },
  Task_55099_Name = {
    Text = "界域精通Ⅵ"
  },
  Task_55100_Desc = {
    Text = "将1名混沌角色提升至60级"
  },
  Task_55100_Name = {
    Text = "界域精通Ⅵ"
  },
  Task_55101_Desc = {
    Text = "将1名深海角色提升至60级"
  },
  Task_55101_Name = {
    Text = "界域精通Ⅵ"
  },
  Task_55102_Desc = {
    Text = "将1名血肉角色提升至60级"
  },
  Task_55102_Name = {
    Text = "界域精通Ⅵ"
  },
  Task_55103_Desc = {
    Text = "将6名超维角色提升至60级"
  },
  Task_55103_Name = {
    Text = "界域精通Ⅷ"
  },
  Task_55104_Desc = {
    Text = "将6名深海角色提升至60级"
  },
  Task_55104_Name = {
    Text = "界域精通Ⅷ"
  },
  Task_55105_Desc = {
    Text = "将6名血肉角色提升至60级"
  },
  Task_55105_Name = {
    Text = "界域精通Ⅷ"
  },
  Task_55106_Desc = {
    Text = "将6名混沌角色提升至60级"
  },
  Task_55106_Name = {
    Text = "界域精通Ⅷ"
  },
  Task_55177_Desc = {
    Text = "完成「花园往事·通关」所有成就"
  },
  Task_55178_Desc = {
    Text = "花园往事·界域"
  },
  Task_55179_Desc = {
    Text = "柯蕾特的花房"
  },
  Task_55180_Desc = {
    Text = "使用混沌界域唤醒体在「花园往事」中获胜2次"
  },
  Task_55181_Desc = {
    Text = "通关「渺小王国」任意难度"
  },
  Task_55182_Desc = {
    Text = "使用混沌界域唤醒体在「花园往事」中获胜1次"
  },
  Task_55183_Desc = {
    Text = "花园往事·通关"
  },
  Task_55184_Desc = {
    Text = "通关「盛开的诗篇」任意难度"
  },
  Task_55185_Desc = {
    Text = "在「蔷薇花圃」交换诗文获得100次回馈"
  },
  Task_55186_Desc = {
    Text = "在「蔷薇花圃」交换诗文获得200次回馈"
  },
  Task_55187_Desc = {
    Text = "通关「灰烬」任意难度"
  },
  Task_55188_Desc = {
    Text = "使用血肉界域唤醒体在「花园往事」中获胜2次"
  },
  Task_55189_Desc = {
    Text = "在「桔梗花圃」交换诗文获得200次回馈"
  },
  Task_55190_Desc = {
    Text = "在「桔梗花圃」交换诗文获得100次回馈"
  },
  Task_55191_Desc = {
    Text = "使用血肉界域唤醒体在「花园往事」中获胜1次"
  },
  Task_55192_Desc = {
    Text = "通关特遣纪录「玫瑰的栖居」"
  },
  Task_55193_Desc = {
    Text = "通关「执手」任意难度"
  },
  Task_55194_Desc = {
    Text = "通关「第一朵玫瑰」任意难度"
  },
  Task_55195_Desc = {
    Text = "在「鸢尾花圃」交换诗文获得200次回馈"
  },
  Task_55196_Desc = {
    Text = "使用超维界域唤醒体在「花园往事」中获胜1次"
  },
  Task_55197_Desc = {
    Text = "使用超维界域唤醒体在「花园往事」中获胜2次"
  },
  Task_55198_Desc = {
    Text = "使用深海界域唤醒体在「花园往事」中获胜2次"
  },
  Task_55199_Desc = {
    Text = "使用深海界域唤醒体在「花园往事」中获胜1次"
  },
  Task_55200_Desc = {
    Text = "在「鸢尾花圃」交换诗文获得100次回馈"
  },
  Task_55426_Desc = {
    Text = "击败柯蕾特"
  },
  Task_55426_Name = {Text = "目标"},
  Task_55852_Desc = {
    Text = "将1个唤醒体升至70级"
  },
  Task_55852_Name = {Text = "任务2"},
  Task_55853_Desc = {
    Text = "完成调查行动·普通模式第7章"
  },
  Task_55853_Name = {Text = "任务3"},
  Task_55854_Desc = {
    Text = "将4个唤醒体升至62级"
  },
  Task_55854_Name = {Text = "任务1"},
  Task_55855_Desc = {
    Text = "任一唤醒体启灵达到人格深化4"
  },
  Task_55855_Name = {Text = "任务4"},
  Task_55856_Desc = {
    Text = "融灾特训值达到150"
  },
  Task_55856_Name = {Text = "任务5"},
  Task_55857_Desc = {
    Text = "完成阶段内全部任务可领取奖励"
  },
  Task_55857_Name = {
    Text = "第八阶段"
  },
  Task_55858_Desc = {
    Text = "完成阶段内全部任务可领取奖励"
  },
  Task_55858_Name = {
    Text = "第七阶段"
  },
  Task_55859_Desc = {
    Text = "将1名唤醒体提升至62级"
  },
  Task_55859_Name = {Text = "任务2"},
  Task_55860_Desc = {
    Text = "完成调查行动·普通模式第6章"
  },
  Task_55860_Name = {Text = "任务3"},
  Task_55861_Desc = {
    Text = "将任意唤醒体技能提升至6级"
  },
  Task_55861_Name = {Text = "任务1"},
  Task_55862_Desc = {
    Text = "激活任意唤醒体天赋1次"
  },
  Task_55862_Name = {Text = "任务4"},
  Task_55863_Desc = {
    Text = "融灾特训值达到50"
  },
  Task_55863_Name = {Text = "任务5"},
  Task_56002_Desc = {
    Text = "完成意识潜游「巨人的陨落」困难难度"
  },
  Task_56002_Name = {
    Text = "无匹的悍勇·困难"
  },
  Task_56003_Desc = {
    Text = "完成意识潜游「诸事如常」困难难度"
  },
  Task_56003_Name = {
    Text = "看不见的城市·困难"
  },
  Task_56004_Desc = {
    Text = "完成意识潜游「巨人的陨落」"
  },
  Task_56004_Name = {
    Text = "无匹的悍勇"
  },
  Task_56005_Desc = {
    Text = "完成特遣纪录「宁静的裂殖」困难难度"
  },
  Task_56005_Name = {
    Text = "归于河流源头·困难"
  },
  Task_56006_Desc = {
    Text = "完成特遣纪录「血的颜色」困难难度"
  },
  Task_56006_Name = {
    Text = "仁爱永恒·困难"
  },
  Task_56007_Desc = {
    Text = "完成特遣纪录「宁静的裂殖」"
  },
  Task_56007_Name = {
    Text = "归于河流源头"
  },
  Task_56008_Desc = {
    Text = "完成特遣纪录「血的颜色」"
  },
  Task_56008_Name = {
    Text = "仁爱永恒"
  },
  Task_56009_Desc = {
    Text = "完成异梦视界「亵渎」"
  },
  Task_56009_Name = {
    Text = "扭曲的狂信"
  },
  Task_56103_Desc = {
    Text = "给敌人叠加50000层中毒"
  },
  Task_56103_Name = {
    Text = "现实之毒Ⅲ"
  },
  Task_56104_Desc = {
    Text = "给敌人叠加100000层中毒"
  },
  Task_56104_Name = {
    Text = "现实之毒Ⅳ"
  },
  Task_56106_Desc = {
    Text = "拥有6名80级唤醒体"
  },
  Task_56106_Name = {
    Text = "「超越之力」Ⅴ"
  },
  Task_56107_Desc = {
    Text = "完成异梦视界「天边之外·上」"
  },
  Task_56107_Name = {Text = "下坠"},
  Task_56108_Desc = {
    Text = "完成200次幻梦深潜"
  },
  Task_56108_Name = {
    Text = "梦心历险记"
  },
  Task_56109_Desc = {
    Text = "完成300次幻梦深潜"
  },
  Task_56109_Name = {
    Text = "梦境行者"
  },
  Task_56110_Desc = {
    Text = "完成500次幻梦深潜"
  },
  Task_56110_Name = {Text = "操梦师"},
  Task_56111_Desc = {
    Text = "拥有8名80级唤醒体"
  },
  Task_56111_Name = {
    Text = "「超越之力」Ⅵ"
  },
  Task_56112_Desc = {
    Text = "拥有10名80级唤醒体"
  },
  Task_56112_Name = {
    Text = "「超越之力」Ⅶ"
  },
  Task_56113_Desc = {
    Text = "与8名唤醒体同调率到达等级10"
  },
  Task_56113_Name = {
    Text = "相逢何必曾相识"
  },
  Task_56115_Desc = {
    Text = "合成材料11111次"
  },
  Task_56115_Name = {
    Text = "高速运转的坩埚进入弥萨格"
  },
  Task_56116_Desc = {
    Text = "拥有200件等级12的密契"
  },
  Task_56116_Name = {
    Text = "禁忌守护者Ⅳ"
  },
  Task_56117_Desc = {
    Text = "与4名唤醒体同调率到达等级10"
  },
  Task_56117_Name = {
    Text = "默契拍档Ⅸ"
  },
  Task_56118_Desc = {
    Text = "升级唤醒体技能400次"
  },
  Task_56118_Name = {
    Text = "「诸武精通」Ⅱ"
  },
  Task_56120_Desc = {
    Text = "拥有30名80级唤醒体"
  },
  Task_56120_Name = {
    Text = "向虚无的宣战Ⅲ"
  },
  Task_56121_Desc = {
    Text = "拥有25名80级唤醒体"
  },
  Task_56121_Name = {
    Text = "向虚无的宣战Ⅱ"
  },
  Task_56122_Desc = {
    Text = "拥有20名80级唤醒体"
  },
  Task_56122_Name = {
    Text = "向虚无的宣战Ⅰ"
  },
  Task_56123_Desc = {
    Text = "拥有15名80级唤醒体"
  },
  Task_56123_Name = {
    Text = "「超越之力」Ⅷ"
  },
  Task_56126_Desc = {
    Text = "拥有40名80级唤醒体"
  },
  Task_56126_Name = {
    Text = "向虚无的宣战Ⅴ"
  },
  Task_56127_Desc = {
    Text = "拥有35名80级唤醒体"
  },
  Task_56127_Name = {
    Text = "向虚无的宣战Ⅳ"
  },
  Task_56128_Desc = {
    Text = "累计消耗250000黑印"
  },
  Task_56128_Name = {
    Text = "欢迎「光」临Ⅴ"
  },
  Task_56129_Desc = {
    Text = "累计消耗1000000黑印"
  },
  Task_56129_Name = {
    Text = "欢迎「光」临Ⅶ"
  },
  Task_56130_Desc = {
    Text = "累计消耗500000黑印"
  },
  Task_56130_Name = {
    Text = "欢迎「光」临Ⅵ"
  },
  Task_56131_Desc = {
    Text = "升级唤醒体技能800次"
  },
  Task_56131_Name = {
    Text = "「诸武精通」Ⅵ"
  },
  Task_56132_Desc = {
    Text = "升级唤醒体技能700次"
  },
  Task_56132_Name = {
    Text = "「诸武精通」Ⅴ"
  },
  Task_56133_Desc = {
    Text = "升级唤醒体技能600次"
  },
  Task_56133_Name = {
    Text = "「诸武精通」Ⅳ"
  },
  Task_56134_Desc = {
    Text = "升级唤醒体技能500次"
  },
  Task_56134_Name = {
    Text = "「诸武精通」Ⅲ"
  },
  Task_56135_Desc = {
    Text = "完成密契转录5000次"
  },
  Task_56135_Name = {
    Text = "五彩斑斓的黑"
  },
  Task_56136_Desc = {
    Text = "完成密契转录2500次"
  },
  Task_56136_Name = {
    Text = "善变的心"
  },
  Task_56137_Desc = {
    Text = "完成密契转录1000次"
  },
  Task_56137_Name = {
    Text = "用回初稿！"
  },
  Task_56138_Desc = {
    Text = "升级唤醒体技能900次"
  },
  Task_56138_Name = {
    Text = "「诸武精通」Ⅶ"
  },
  Task_56140_Desc = {
    Text = "完成密契转录10000次"
  },
  Task_56140_Name = {
    Text = "恶魔甲方"
  },
  Task_56156_Desc = {
    Text = "命轮叠位800次"
  },
  Task_56156_Name = {
    Text = "量子纠缠的未来Ⅱ"
  },
  Task_56157_Desc = {
    Text = "命轮叠位900次"
  },
  Task_56157_Name = {
    Text = "量子纠缠的未来Ⅲ"
  },
  Task_56161_Desc = {
    Text = "奥尔拉同调率达到 10 级"
  },
  Task_56162_Desc = {
    Text = "弥利亚姆同调率达到 10 级"
  },
  Task_56177_Desc = {
    Text = "获得80种不同的命轮"
  },
  Task_56177_Name = {
    Text = "编织命运之人"
  },
  Task_56178_Desc = {
    Text = "获得70种不同的命轮"
  },
  Task_56178_Name = {
    Text = "无常的掌控者"
  },
  Task_56179_Desc = {
    Text = "升级唤醒体技能300次"
  },
  Task_56179_Name = {
    Text = "「诸武精通」Ⅰ"
  },
  Task_56180_Desc = {
    Text = "命轮叠位1100次"
  },
  Task_56180_Name = {
    Text = "量子纠缠的未来Ⅴ"
  },
  Task_56181_Desc = {
    Text = "命轮叠位1200次"
  },
  Task_56181_Name = {
    Text = "量子纠缠的未来Ⅵ"
  },
  Task_56182_Desc = {
    Text = "点赞1000次"
  },
  Task_56182_Name = {
    Text = "社交悍匪"
  },
  Task_56184_Desc = {
    Text = "点赞250次"
  },
  Task_56184_Name = {
    Text = "迈向外部的一大步"
  },
  Task_56185_Desc = {
    Text = "点赞500次"
  },
  Task_56185_Name = {
    Text = "走向世界的大跨步"
  },
  Task_56186_Desc = {
    Text = "分解2000个命轮"
  },
  Task_56186_Name = {
    Text = "命运的主人"
  },
  Task_56187_Desc = {
    Text = "分解1000个命轮"
  },
  Task_56187_Name = {
    Text = "扼住命运的咽喉"
  },
  Task_56188_Desc = {
    Text = "获得60种不同的命轮"
  },
  Task_56188_Name = {
    Text = "命运学徒Ⅱ"
  },
  Task_56189_Desc = {
    Text = "获得50种不同的命轮"
  },
  Task_56189_Name = {
    Text = "命运学徒Ⅰ"
  },
  Task_56191_Desc = {
    Text = "命轮叠位1000次"
  },
  Task_56191_Name = {
    Text = "量子纠缠的未来Ⅳ"
  },
  Task_56192_Desc = {
    Text = "分解500个命轮"
  },
  Task_56192_Name = {
    Text = "向命运宣战"
  },
  Task_56349_Desc = {
    Text = "击退首领「艾继丝」"
  },
  Task_56349_Name = {Text = "目标"},
  Task_56350_Desc = {
    Text = "击退首领「达芙黛尔」"
  },
  Task_56350_Name = {Text = "目标"},
  Task_56351_Desc = {
    Text = "击退首领「雷娅」"
  },
  Task_56351_Name = {Text = "目标"},
  Task_56352_Desc = {
    Text = "击退首领「致奥尔拉」"
  },
  Task_56352_Name = {Text = "目标"},
  Task_56353_Desc = {
    Text = "击退首领「24」"
  },
  Task_56353_Name = {Text = "目标"},
  Task_56412_Desc = {
    Text = "通关「祂的降临」任意难度"
  },
  Task_56413_Desc = {
    Text = "通关「行刑者」任意难度"
  },
  Task_56414_Desc = {
    Text = "黑暗子宫·通关"
  },
  Task_56415_Desc = {
    Text = "通关「裹尸布」任意难度"
  },
  Task_56416_Desc = {
    Text = "黑暗子宫·界域"
  },
  Task_56417_Desc = {
    Text = "通关「蛰伏」任意难度"
  },
  Task_56420_Desc = {
    Text = "通关「屠戮羔羊」任意难度"
  },
  Task_56421_Desc = {
    Text = "通关「时空沟壑」任意难度"
  },
  Task_56422_Desc = {
    Text = "通关「黄色星辰」任意难度"
  },
  Task_57121_Desc = {
    Text = "通关「屠戮羔羊」癫狂难度"
  },
  Task_57122_Desc = {
    Text = "通关「行刑者」癫狂难度"
  },
  Task_57123_Desc = {
    Text = "使用深海界域唤醒体在「黑暗子宫」中获胜2次"
  },
  Task_57124_Desc = {
    Text = "使用超维界域唤醒体在「黑暗子宫」中获胜2次"
  },
  Task_57125_Desc = {
    Text = "通关「祂的降临」癫狂难度"
  },
  Task_57126_Desc = {
    Text = "使用深海界域唤醒体在「黑暗子宫」中获胜1次"
  },
  Task_57127_Desc = {
    Text = "通关「时空沟壑」癫狂难度"
  },
  Task_57128_Desc = {
    Text = "通关「黄色星辰」癫狂难度"
  },
  Task_57129_Desc = {
    Text = "使用混沌界域唤醒体在「黑暗子宫」中获胜1次"
  },
  Task_57130_Desc = {
    Text = "通关「蛰伏」癫狂难度"
  },
  Task_57131_Desc = {
    Text = "使用混沌界域唤醒体在「黑暗子宫」中获胜2次"
  },
  Task_57132_Desc = {
    Text = "使用血肉界域唤醒体在「黑暗子宫」中获胜1次"
  },
  Task_57133_Desc = {
    Text = "完成「黑暗子宫·通关」和「黑暗子宫·界域」所有任务"
  },
  Task_57134_Desc = {
    Text = "使用血肉界域唤醒体在「黑暗子宫」中获胜2次"
  },
  Task_57135_Desc = {
    Text = "通关「裹尸布」癫狂难度"
  },
  Task_57136_Desc = {
    Text = "使用超维界域唤醒体在「黑暗子宫」中获胜1次"
  },
  Task_57137_Desc = {
    Text = "黑暗子宫·癫狂"
  },
  Task_57369_Desc = {
    Text = "通关「衔树枝」任意难度"
  },
  Task_57370_Desc = {
    Text = "月夜传说·癫狂"
  },
  Task_57371_Desc = {
    Text = "通关「密室迷思」任意难度"
  },
  Task_57372_Desc = {
    Text = "月夜传说·通关"
  },
  Task_57373_Desc = {
    Text = "通关「衔树枝」癫狂难度"
  },
  Task_57374_Desc = {
    Text = "通关「无头尸」任意难度"
  },
  Task_57375_Desc = {
    Text = "使用混沌界域唤醒体在「月夜传说」中获胜2次"
  },
  Task_57376_Desc = {
    Text = "使用血肉界域唤醒体在「月夜传说」中获胜2次"
  },
  Task_57377_Desc = {
    Text = "使用血肉界域唤醒体在「月夜传说」中获胜1次"
  },
  Task_57378_Desc = {
    Text = "通关「不速之客」癫狂难度"
  },
  Task_57379_Desc = {
    Text = "通关「无头尸」癫狂难度"
  },
  Task_57380_Desc = {
    Text = "完成「月夜传说·通关」所有任务"
  },
  Task_57381_Desc = {
    Text = "通关「密室迷思」癫狂难度"
  },
  Task_57382_Desc = {
    Text = "使用超维界域唤醒体在「月夜传说」中获胜1次"
  },
  Task_57383_Desc = {
    Text = "使用超维界域唤醒体在「月夜传说」中获胜2次"
  },
  Task_57384_Desc = {
    Text = "使用深海界域唤醒体在「月夜传说」中获胜1次"
  },
  Task_57385_Desc = {
    Text = "使用深海界域唤醒体在「月夜传说」中获胜2次"
  },
  Task_57386_Desc = {
    Text = "通关「幸运庸众」任意难度"
  },
  Task_57387_Desc = {
    Text = "通关「不在场供述」癫狂难度"
  },
  Task_57388_Desc = {
    Text = "通关「侦探之友」任意难度"
  },
  Task_57389_Desc = {
    Text = "通关「不速之客」任意难度"
  },
  Task_57390_Desc = {
    Text = "使用混沌界域唤醒体在「月夜传说」中获胜1次"
  },
  Task_57391_Desc = {
    Text = "月夜传说·界域"
  },
  Task_57392_Desc = {
    Text = "通关「侦探之友」癫狂难度"
  },
  Task_57393_Desc = {
    Text = "通关「不在场供述」任意难度"
  },
  Task_57394_Desc = {
    Text = "通关「幸运庸众」癫狂难度"
  },
  Task_57404_Desc = {
    Text = "通关「后记」任意难度"
  },
  Task_57405_Desc = {
    Text = "通关「翻转诡计」任意难度"
  },
  Task_57406_Desc = {
    Text = "通关「后记」癫狂难度"
  },
  Task_57407_Desc = {
    Text = "通关「翻转诡计」癫狂难度"
  },
  Task_57409_Desc = {
    Text = "通关特遣纪录「狩猎愉快！」"
  },
  Task_57528_Name = {Text = "83"},
  Task_57529_Name = {Text = "89"},
  Task_57530_Name = {Text = "88"},
  Task_57531_Name = {Text = "87"},
  Task_57532_Name = {Text = "86"},
  Task_57533_Name = {Text = "85"},
  Task_57534_Name = {Text = "84"},
  Task_57535_Name = {Text = "90"},
  Task_57536_Name = {Text = "82"},
  Task_57537_Name = {Text = "81"},
  Task_57570_Desc = {
    Text = "通关「翻转诡计」任意难度"
  },
  Task_57571_Desc = {
    Text = "通关「侦探之友」任意难度"
  },
  Task_57572_Desc = {
    Text = "通关「无头尸」任意难度"
  },
  Task_57573_Desc = {
    Text = "通关「屠戮羔羊」任意难度"
  },
  Task_57574_Desc = {
    Text = "通关「不在场供述」任意难度"
  },
  Task_57575_Desc = {
    Text = "通关「黄色星辰」任意难度"
  },
  Task_57576_Desc = {
    Text = "通关「祂的降临」任意难度"
  },
  Task_57577_Desc = {
    Text = "通关「行刑者」任意难度"
  },
  Task_57578_Desc = {
    Text = "通关「后记」任意难度"
  },
  Task_57579_Desc = {
    Text = "通关「裹尸布」任意难度"
  },
  Task_57580_Desc = {
    Text = "通关「不速之客」任意难度"
  },
  Task_57581_Desc = {
    Text = "通关「蛰伏」任意难度"
  },
  Task_57582_Desc = {
    Text = "通关「时空沟壑」任意难度"
  },
  Task_57583_Desc = {
    Text = "通关「衔树枝」任意难度"
  },
  Task_57584_Desc = {
    Text = "通关「幸运庸众」任意难度"
  },
  Task_57585_Desc = {
    Text = "通关「密室迷思」任意难度"
  },
  Task_58104_Desc = {
    Text = "通关「忏悔」任意难度"
  },
  Task_58107_Desc = {
    Text = "通关「指责」任意难度"
  },
  Task_58109_Desc = {
    Text = "通关「偏执」癫狂难度"
  },
  Task_58110_Desc = {
    Text = "通关「争夺」任意难度"
  },
  Task_58111_Desc = {
    Text = "通关「争夺」任意难度"
  },
  Task_58112_Desc = {
    Text = "通关「忏悔」任意难度"
  },
  Task_58113_Desc = {
    Text = "通关「偏执」任意难度"
  },
  Task_58114_Desc = {
    Text = "通关「忏悔」癫狂难度"
  },
  Task_58115_Desc = {
    Text = "通关「索取」任意难度"
  },
  Task_58118_Desc = {
    Text = "通关「指责」癫狂难度"
  },
  Task_58119_Desc = {
    Text = "通关「索取」癫狂难度"
  },
  Task_58120_Desc = {
    Text = "完成「圣堂之路」所有关卡任意难度"
  },
  Task_58122_Desc = {
    Text = "通关「指责」任意难度"
  },
  Task_58123_Desc = {
    Text = "圣堂义卖现场"
  },
  Task_58124_Desc = {
    Text = "通关「偏执」任意难度"
  },
  Task_58126_Desc = {
    Text = "通关「索取」任意难度"
  },
  Task_58128_Desc = {
    Text = "圣堂之路·癫狂"
  },
  Task_58130_Desc = {
    Text = "圣堂之路·滋长"
  },
  Task_58131_Desc = {
    Text = "通关「争夺」癫狂难度"
  },
  Task_58132_Desc = {
    Text = "「大约翰的神奇义卖」中购买100次"
  },
  Task_58133_Desc = {
    Text = "「大约翰的神奇义卖」中购买200次"
  },
  Task_58134_Desc = {
    Text = "「格雷太太的小店」中购买100次"
  },
  Task_58135_Desc = {
    Text = "「格雷太太的小店」中购买200次"
  },
  Task_58136_Desc = {
    Text = "「史密斯特卖」中购买200次"
  },
  Task_58137_Desc = {
    Text = "「史密斯特卖」中购买100次"
  },
  Task_58138_Desc = {
    Text = "完成调查事件「{s1}」"
  },
  Task_58500_Desc = {
    Text = "轰鸣之音·通关"
  },
  Task_58501_Desc = {
    Text = "通关「管弦编制」癫狂难度"
  },
  Task_58502_Desc = {
    Text = "通关「序曲」任意难度"
  },
  Task_58503_Desc = {
    Text = "通关「小步舞曲」任意难度"
  },
  Task_58504_Desc = {
    Text = "通关「余音」任意难度"
  },
  Task_58505_Desc = {
    Text = "通关「终曲」任意难度"
  },
  Task_58506_Desc = {
    Text = "通关「慢板」任意难度"
  },
  Task_58507_Desc = {
    Text = "通关「快板」癫狂难度"
  },
  Task_58508_Desc = {
    Text = "通关「小步舞曲」癫狂难度"
  },
  Task_58509_Desc = {
    Text = "通关「余音」任意难度"
  },
  Task_58510_Desc = {
    Text = "使用混沌界域唤醒体在「轰鸣之音」中获胜1次"
  },
  Task_58511_Desc = {
    Text = "使用混沌界域唤醒体在「轰鸣之音」中获胜2次"
  },
  Task_58512_Desc = {
    Text = "通关「迷途梦引」任意难度"
  },
  Task_58513_Desc = {
    Text = "轰鸣之音·界域"
  },
  Task_58514_Desc = {
    Text = "通关「余音」癫狂难度"
  },
  Task_58515_Desc = {
    Text = "通关「小步舞曲」任意难度"
  },
  Task_58516_Desc = {
    Text = "轰鸣之音·癫狂"
  },
  Task_58517_Desc = {
    Text = "通关「快板」任意难度"
  },
  Task_58518_Desc = {
    Text = "通关「序曲」癫狂难度"
  },
  Task_58519_Desc = {
    Text = "通关「管弦编制」任意难度"
  },
  Task_58520_Desc = {
    Text = "通关「慢板」癫狂难度"
  },
  Task_58521_Desc = {
    Text = "通关「慢板」任意难度"
  },
  Task_58522_Desc = {
    Text = "使用深海界域唤醒体在「轰鸣之音」中获胜2次"
  },
  Task_58523_Desc = {
    Text = "使用深海界域唤醒体在「轰鸣之音」中获胜1次"
  },
  Task_58524_Desc = {
    Text = "通关「幕落」任意难度"
  },
  Task_58525_Desc = {
    Text = "通关「终曲」癫狂难度"
  },
  Task_58526_Desc = {
    Text = "通关「迷途梦引」癫狂难度"
  },
  Task_58527_Desc = {
    Text = "使用超维界域唤醒体在「轰鸣之音」中获胜2次"
  },
  Task_58528_Desc = {
    Text = "使用超维界域唤醒体在「轰鸣之音」中获胜1次"
  },
  Task_58529_Desc = {
    Text = "通关「快板」任意难度"
  },
  Task_58530_Desc = {
    Text = "完成「轰鸣之音·通关」所有任务"
  },
  Task_58531_Desc = {
    Text = "通关「序曲」任意难度"
  },
  Task_58532_Desc = {
    Text = "通关「幕落」任意难度"
  },
  Task_58533_Desc = {
    Text = "通关「管弦编制」任意难度"
  },
  Task_58534_Desc = {
    Text = "通关「迷途梦引」任意难度"
  },
  Task_58535_Desc = {
    Text = "通关「终曲」任意难度"
  },
  Task_58536_Desc = {
    Text = "通关「幕落」癫狂难度"
  },
  Task_58537_Desc = {
    Text = "使用血肉界域唤醒体在「轰鸣之音」中获胜1次"
  },
  Task_58538_Desc = {
    Text = "使用血肉界域唤醒体在「轰鸣之音」中获胜2次"
  },
  Task_58989_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_58989_Name = {
    Text = "速战速决"
  },
  Task_58990_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_58990_Name = {
    Text = "速战速决"
  },
  Task_58991_Desc = {
    Text = "最终战一回合额外抽取至少5张牌"
  },
  Task_58991_Name = {Text = "抽卡！"},
  Task_58992_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_58992_Name = {
    Text = "节能主义"
  },
  Task_58993_Desc = {
    Text = "获得至少4种不同种类刻印"
  },
  Task_58993_Name = {
    Text = "灵魂烙印"
  },
  Task_58994_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_58994_Name = {
    Text = "速战速决"
  },
  Task_58995_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_58995_Name = {
    Text = "速战速决"
  },
  Task_58996_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_58996_Name = {
    Text = "速战速决"
  },
  Task_58997_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_58997_Name = {
    Text = "速战速决"
  },
  Task_58998_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_58998_Name = {
    Text = "速战速决"
  },
  Task_58999_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_58999_Name = {
    Text = "速战速决"
  },
  Task_59000_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_59000_Name = {
    Text = "速战速决"
  },
  Task_59001_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_59001_Name = {
    Text = "完美通过"
  },
  Task_59002_Desc = {
    Text = "通关时症状卡不多于3张"
  },
  Task_59002_Name = {
    Text = "节能主义"
  },
  Task_59003_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_59003_Name = {
    Text = "节能主义"
  },
  Task_59004_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_59004_Name = {
    Text = "完美通过"
  },
  Task_59005_Desc = {
    Text = "通关时携带至少8个造物"
  },
  Task_59005_Name = {
    Text = "奇兵秘藏"
  },
  Task_59006_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_59006_Name = {
    Text = "完美通过"
  },
  Task_59007_Desc = {
    Text = "通关时携带至少1个诅咒造物"
  },
  Task_59007_Name = {
    Text = "奇兵秘藏"
  },
  Task_59008_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_59008_Name = {
    Text = "完美通过"
  },
  Task_59009_Desc = {
    Text = "最终战一回合打出至少6张卡牌"
  },
  Task_59009_Name = {
    Text = "我的回合"
  },
  Task_59010_Desc = {
    Text = "最终战一回合至少叠加最大生命65%的护盾"
  },
  Task_59010_Name = {
    Text = "钢铁之躯"
  },
  Task_59011_Desc = {
    Text = "最终战一回合打出至少6张卡牌"
  },
  Task_59011_Name = {
    Text = "我的回合"
  },
  Task_59012_Desc = {
    Text = "最终战一回合至少叠加最大生命65%的护盾"
  },
  Task_59012_Name = {
    Text = "钢铁之躯"
  },
  Task_59013_Desc = {
    Text = "最终战一回合额外抽取至少5张牌"
  },
  Task_59013_Name = {Text = "抽卡！"},
  Task_59014_Desc = {
    Text = "最终战中一回合造成至少20000点伤害"
  },
  Task_59014_Name = {
    Text = "全力一击"
  },
  Task_59015_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_59015_Name = {
    Text = "优雅而精准"
  },
  Task_59016_Desc = {
    Text = "获得至少4种不同种类刻印"
  },
  Task_59016_Name = {
    Text = "灵魂烙印"
  },
  Task_59017_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_59017_Name = {
    Text = "优雅而精准"
  },
  Task_59018_Desc = {
    Text = "通关时携带至少1个诅咒造物"
  },
  Task_59018_Name = {
    Text = "奇兵秘藏"
  },
  Task_59019_Desc = {
    Text = "通关时觉醒所有唤醒体"
  },
  Task_59019_Name = {
    Text = "无限抱拥"
  },
  Task_59020_Desc = {
    Text = "通关时携带至少2个造物"
  },
  Task_59020_Name = {
    Text = "奇兵秘藏"
  },
  Task_59021_Desc = {
    Text = "通关时携带至少1个诅咒造物"
  },
  Task_59021_Name = {
    Text = "奇兵秘藏"
  },
  Task_59022_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_59022_Name = {
    Text = "节能主义"
  },
  Task_59023_Desc = {
    Text = "最终战一回合额外抽取至少4张牌"
  },
  Task_59023_Name = {Text = "抽卡！"},
  Task_59024_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_59024_Name = {
    Text = "完美通过"
  },
  Task_59025_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_59025_Name = {
    Text = "完美通过"
  },
  Task_59026_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_59026_Name = {
    Text = "完美通过"
  },
  Task_59027_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_59027_Name = {
    Text = "完美通过"
  },
  Task_59028_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_59028_Name = {
    Text = "完美通过"
  },
  Task_59029_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_59029_Name = {
    Text = "完美通过"
  },
  Task_59030_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_59030_Name = {
    Text = "完美通过"
  },
  Task_59031_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_59031_Name = {
    Text = "完美通过"
  },
  Task_59032_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_59032_Name = {
    Text = "完美通过"
  },
  Task_59033_Desc = {
    Text = "通关时觉醒所有唤醒体"
  },
  Task_59033_Name = {
    Text = "无限抱拥"
  },
  Task_59034_Desc = {
    Text = "通关时携带至少2个造物"
  },
  Task_59034_Name = {
    Text = "奇兵秘藏"
  },
  Task_59035_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_59035_Name = {
    Text = "速战速决"
  },
  Task_59036_Desc = {
    Text = "通关时携带至少1个诅咒造物"
  },
  Task_59036_Name = {
    Text = "奇兵秘藏"
  },
  Task_59037_Desc = {
    Text = "最终战不超过18回合取胜"
  },
  Task_59037_Name = {
    Text = "速战速决"
  },
  Task_59038_Desc = {
    Text = "最终战不超过12回合取胜"
  },
  Task_59038_Name = {
    Text = "速战速决"
  },
  Task_59039_Desc = {
    Text = "最终战一回合至少叠加最大生命60%的护盾"
  },
  Task_59039_Name = {
    Text = "钢铁之躯"
  },
  Task_59040_Desc = {
    Text = "最终战一回合打出至少5张卡牌"
  },
  Task_59040_Name = {
    Text = "我的回合"
  },
  Task_59041_Desc = {
    Text = "最终战一回合至少叠加最大生命60%的护盾"
  },
  Task_59041_Name = {
    Text = "钢铁之躯"
  },
  Task_59042_Desc = {
    Text = "通关时症状卡不多于3张"
  },
  Task_59042_Name = {
    Text = "节能主义"
  },
  Task_59043_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_59043_Name = {
    Text = "优雅而精准"
  },
  Task_59044_Desc = {
    Text = "最终战不超过18回合取胜"
  },
  Task_59044_Name = {
    Text = "速战速决"
  },
  Task_59045_Desc = {
    Text = "最终战一回合额外抽取至少4张牌"
  },
  Task_59045_Name = {Text = "抽卡！"},
  Task_59046_Desc = {
    Text = "通关时携带至少8个造物"
  },
  Task_59046_Name = {
    Text = "奇兵秘藏"
  },
  Task_59047_Desc = {
    Text = "最终战一回合打出至少5张卡牌"
  },
  Task_59047_Name = {
    Text = "我的回合"
  },
  Task_59048_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_59048_Name = {
    Text = "优雅而精准"
  },
  Task_59438_Desc = {
    Text = "莱克同调率达到 10 级"
  },
  Task_60163_Desc = {
    Text = "通关关卡"
  },
  Task_60163_Name = {
    Text = "通关关卡"
  },
  Task_60163_UnlockCondDesc = {
    Text = "通关关卡8-9后解锁"
  },
  Task_60164_Desc = {
    Text = "通关关卡"
  },
  Task_60164_Name = {
    Text = "通关关卡"
  },
  Task_60164_UnlockCondDesc = {
    Text = "通关关卡8-11后解锁"
  },
  Task_60165_Desc = {
    Text = "通关关卡"
  },
  Task_60165_Name = {
    Text = "通关关卡"
  },
  Task_60165_UnlockCondDesc = {
    Text = "通关关卡8-10后解锁"
  },
  Task_60443_Desc = {
    Text = "完成调查主线第4章「于无声处」"
  },
  Task_60444_Desc = {
    Text = "特训值首次达到 150"
  },
  Task_60445_Desc = {
    Text = "特训值首次达到 325"
  },
  Task_60446_Desc = {
    Text = "特训值首次达到 50"
  },
  Task_60447_Desc = {
    Text = "特训值首次达到 100"
  },
  Task_60448_Desc = {
    Text = "完成调查主线第4章「于无声处」困难难度"
  },
  Task_60449_Desc = {
    Text = "特训值首次达到 300"
  },
  Task_60450_Desc = {
    Text = "完成调查主线第2章「以蜡像之名」"
  },
  Task_60451_Desc = {
    Text = "完成调查主线第5章「风暴之眼」困难难度"
  },
  Task_60452_Desc = {
    Text = "特训值首次达到 225"
  },
  Task_60453_Desc = {
    Text = "完成调查主线第1章「东区秘事」"
  },
  Task_60454_Desc = {
    Text = "完成调查主线第6章「倒错的群星」困难难度"
  },
  Task_60455_Desc = {
    Text = "完成调查主线第2章「以蜡像之名」困难难度"
  },
  Task_60456_Desc = {
    Text = "完成调查主线第5章「风暴之眼」"
  },
  Task_60457_Desc = {
    Text = "完成调查主线第3章「谨防恶犬」困难难度"
  },
  Task_60458_Desc = {
    Text = "完成调查主线第1章「东区秘事」困难难度"
  },
  Task_60459_Desc = {
    Text = "完成调查主线第3章「谨防恶犬」"
  },
  Task_60460_Desc = {
    Text = "完成调查主线第6章「倒错的群星」"
  },
  Task_60461_Desc = {
    Text = "特训值首次达到 350"
  },
  Task_60601_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60602_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60603_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60604_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60606_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60607_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60608_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60609_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60610_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60611_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60612_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60613_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60614_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60615_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60616_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60617_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60618_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60619_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60620_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60622_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60623_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60624_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60625_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60626_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60627_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60628_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60629_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60630_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60631_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60633_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60634_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60635_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60636_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60637_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60638_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60639_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60640_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60641_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60642_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60643_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60644_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60645_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60646_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60647_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60648_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60649_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60650_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60651_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60653_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60654_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60655_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60656_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60657_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60658_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60659_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60660_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60661_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60663_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60664_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60665_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60666_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60667_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60668_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60669_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60670_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60671_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60672_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60673_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60674_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60675_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60676_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60677_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60678_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60680_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60681_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60682_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60683_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60684_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60685_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60686_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60687_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60688_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60689_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60690_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60691_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60692_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60694_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60696_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60697_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60699_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60742_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60743_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60747_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60748_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60749_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60750_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60751_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60752_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60754_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60755_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60757_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60758_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60759_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60760_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60761_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60763_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60765_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60766_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60768_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60769_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60770_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60772_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60773_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60774_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60777_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60778_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60779_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60780_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60781_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60782_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60783_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60784_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60785_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60787_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60788_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60789_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60790_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60793_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60795_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60796_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60797_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60798_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60799_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60800_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60801_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60803_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60804_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60805_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_60829_Desc = {
    Text = "哈姆林同调率达到 10 级"
  },
  Task_61103_Desc = {
    Text = "获得本源朵尔"
  },
  Task_61103_Name = {
    Text = "获得本源朵尔"
  },
  Task_61104_Desc = {
    Text = "获得本源希洛"
  },
  Task_61104_Name = {
    Text = "获得本源希洛"
  },
  Task_61105_Desc = {
    Text = "获得莉莉"
  },
  Task_61105_Name = {
    Text = "获得莉莉"
  },
  Task_61106_Desc = {
    Text = "获得奥尔拉"
  },
  Task_61106_Name = {
    Text = "获得奥尔拉"
  },
  Task_61107_Desc = {
    Text = "获得弥利亚姆"
  },
  Task_61107_Name = {
    Text = "获得弥利亚姆"
  },
  Task_61108_Desc = {
    Text = "获得莱克"
  },
  Task_61108_Name = {
    Text = "获得莱克"
  },
  Task_61109_Desc = {
    Text = "获得索蕾尔"
  },
  Task_61109_Name = {
    Text = "获得索蕾尔"
  },
  Task_61110_Desc = {
    Text = "获得萨尔瓦多"
  },
  Task_61110_Name = {
    Text = "获得萨尔瓦多"
  },
  Task_61111_Desc = {
    Text = "获得旺达"
  },
  Task_61111_Name = {
    Text = "获得旺达"
  },
  Task_61112_Desc = {
    Text = "获得图鲁"
  },
  Task_61112_Name = {
    Text = "获得图鲁"
  },
  Task_61113_Desc = {
    Text = "获得「24」"
  },
  Task_61113_Name = {
    Text = "获得「24」"
  },
  Task_61114_Desc = {
    Text = "获得塔薇"
  },
  Task_61114_Name = {
    Text = "获得塔薇"
  },
  Task_61115_Desc = {
    Text = "获得泰旖丝"
  },
  Task_61115_Name = {
    Text = "获得泰旖丝"
  },
  Task_61116_Desc = {
    Text = "获得哈姆林"
  },
  Task_61116_Name = {
    Text = "获得哈姆林"
  },
  Task_61117_Desc = {
    Text = "获得达芙黛尔"
  },
  Task_61117_Name = {
    Text = "获得达芙黛尔"
  },
  Task_61118_Desc = {
    Text = "获得墨菲"
  },
  Task_61118_Name = {
    Text = "获得墨菲"
  },
  Task_61157_Desc = {
    Text = "完成调查主线第8章「终末交响曲」困难难度"
  },
  Task_61158_Desc = {
    Text = "完成调查主线第7章「欲河」"
  },
  Task_61159_Desc = {
    Text = "完成调查主线第7章「欲河」困难难度"
  },
  Task_61160_Desc = {
    Text = "完成调查主线第8章「终末交响曲」困难难度"
  },
  Task_61161_Desc = {
    Text = "完成调查主线第8章「终末交响曲」"
  },
  Task_61162_Desc = {
    Text = "完成调查主线第7章「欲河」困难难度"
  },
  Task_61163_Desc = {
    Text = "完成调查主线第7章「欲河」"
  },
  Task_61164_Desc = {
    Text = "完成调查主线第8章「终末交响曲」"
  },
  Task_61186_Desc = {
    Text = "通关「一段记忆」任意难度"
  },
  Task_61187_Desc = {
    Text = "通关「黄金之城」任意难度"
  },
  Task_61188_Desc = {
    Text = "使用混沌界域唤醒体在「湖中之城」中获胜1次"
  },
  Task_61189_Desc = {
    Text = "完成「湖中之城·通关」所有任务"
  },
  Task_61190_Desc = {
    Text = "通关「启示录」任意难度"
  },
  Task_61191_Desc = {
    Text = "通关「真实」癫狂难度"
  },
  Task_61192_Desc = {
    Text = "通关「黄金之城」癫狂难度"
  },
  Task_61193_Desc = {
    Text = "通关「海市蜃楼」任意难度"
  },
  Task_61194_Desc = {
    Text = "湖中之城·通关"
  },
  Task_61195_Desc = {
    Text = "通关「真实」任意难度"
  },
  Task_61196_Desc = {
    Text = "通关「小苍兰」任意难度"
  },
  Task_61197_Desc = {
    Text = "通关「海市蜃楼」任意难度"
  },
  Task_61198_Desc = {
    Text = "使用超维界域唤醒体在「湖中之城」中获胜1次"
  },
  Task_61199_Desc = {
    Text = "使用深海界域唤醒体在「湖中之城」中获胜1次"
  },
  Task_61200_Desc = {
    Text = "通关「海市蜃楼」癫狂难度"
  },
  Task_61201_Desc = {
    Text = "湖中之城·界域"
  },
  Task_61202_Desc = {
    Text = "通关「黄金之城」任意难度"
  },
  Task_61203_Desc = {
    Text = "通关「启示录」任意难度"
  },
  Task_61204_Desc = {
    Text = "通关「井」任意难度"
  },
  Task_61205_Desc = {
    Text = "通关「一段记忆」任意难度"
  },
  Task_61206_Desc = {
    Text = "使用血肉界域唤醒体在「湖中之城」中获胜1次"
  },
  Task_61207_Desc = {
    Text = "通关「小苍兰」癫狂难度"
  },
  Task_61208_Desc = {
    Text = "通关「启示录」癫狂难度"
  },
  Task_61209_Desc = {
    Text = "通关「井」任意难度"
  },
  Task_61210_Desc = {
    Text = "通关「小苍兰」任意难度"
  },
  Task_61211_Desc = {
    Text = "湖中之城·癫狂"
  },
  Task_61212_Desc = {
    Text = "通关「真实」任意难度"
  },
  Task_61213_Desc = {
    Text = "通关「一段记忆」癫狂难度"
  },
  Task_61214_Desc = {
    Text = "通关「井」癫狂难度"
  },
  Task_61215_Desc = {
    Text = "通关意识潜游「燃烧的群宴」"
  },
  Task_61375_Desc = {
    Text = "累计登录 12 天"
  },
  Task_61376_Desc = {
    Text = "累计登录 3 天"
  },
  Task_61377_Desc = {
    Text = "累计登录 9 天"
  },
  Task_61378_Desc = {
    Text = "累计登录 11 天"
  },
  Task_61379_Desc = {
    Text = "累计登录 10 天"
  },
  Task_61380_Desc = {
    Text = "累计登录 1 天"
  },
  Task_61381_Desc = {
    Text = "累计登录 4 天"
  },
  Task_61382_Desc = {
    Text = "累计登录 15 天"
  },
  Task_61383_Desc = {
    Text = "累计登录 14 天"
  },
  Task_61384_Desc = {
    Text = "累计登录 5 天"
  },
  Task_61385_Desc = {
    Text = "累计登录 8 天"
  },
  Task_61386_Desc = {
    Text = "累计登录 2 天"
  },
  Task_61387_Desc = {
    Text = "累计登录 13 天"
  },
  Task_61388_Desc = {
    Text = "累计登录 6 天"
  },
  Task_61389_Desc = {
    Text = "累计登录 16 天"
  },
  Task_61390_Desc = {
    Text = "累计登录 7 天"
  },
  Task_61394_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61395_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61396_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61397_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61398_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61399_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61400_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61401_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61402_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61403_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61404_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61405_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61407_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61408_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61409_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61410_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61411_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61412_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61413_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61414_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61415_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61416_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61417_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61418_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61419_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61420_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61421_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61422_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61425_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61426_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61427_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61428_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61430_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61431_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61432_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61433_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61434_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61435_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61436_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61438_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61439_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61440_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61441_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61442_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61443_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61444_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61445_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61446_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61447_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61448_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61449_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61450_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61451_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61452_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61453_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61455_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61456_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61457_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61458_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61459_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61460_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61461_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61462_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61463_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61464_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61465_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61466_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61468_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61469_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61470_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61471_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61472_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61473_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61474_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61475_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61476_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61477_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61478_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61479_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61481_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61519_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61520_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61521_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61522_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61523_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61524_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61525_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61526_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61527_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61528_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61616_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61617_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61620_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61621_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61622_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61623_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61626_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61627_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61628_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61629_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61631_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61633_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61634_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61636_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61637_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61639_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61640_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61642_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61643_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61644_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61645_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61648_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61649_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61650_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61652_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61653_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61654_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61655_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61657_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61659_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61660_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61661_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61662_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61665_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61666_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61668_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61669_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61671_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61672_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61673_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61675_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61676_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61678_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61679_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61681_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61682_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61684_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61685_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61687_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61688_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61690_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61691_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61693_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61694_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61696_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61697_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61699_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61700_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61701_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61702_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61704_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61705_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61706_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61707_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61709_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61710_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61712_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61713_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61716_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61717_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61719_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61720_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61722_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61723_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61725_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61726_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61727_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61729_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61731_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61733_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61734_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61735_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61736_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61739_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61740_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61743_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61744_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61748_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61749_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61750_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61751_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61753_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61754_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61756_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61757_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61758_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61759_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61762_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61763_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61765_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61766_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61767_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61769_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61770_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61771_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61772_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61774_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61777_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61778_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61781_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61782_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61783_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61784_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61785_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61788_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61789_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61791_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61792_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61794_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61795_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61796_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61797_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61798_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61801_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61802_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61804_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61805_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61807_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61808_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61810_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61811_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61814_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61815_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61816_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61817_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61819_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61820_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61821_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61824_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_61825_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_62002_Desc = {
    Text = "通关「见山」癫狂难度"
  },
  Task_62003_Desc = {
    Text = "通关「破土」任意难度"
  },
  Task_62004_Desc = {
    Text = "野兽雄心·界域"
  },
  Task_62005_Desc = {
    Text = "通关「寒夜」任意难度"
  },
  Task_62006_Desc = {
    Text = "在「吞食的野心」交换花苞获得200次回馈"
  },
  Task_62007_Desc = {
    Text = "在「吞食的野心」交换花苞获得100次回馈"
  },
  Task_62008_Desc = {
    Text = "通关「寒夜」癫狂难度"
  },
  Task_62009_Desc = {
    Text = "通关「寒夜」任意难度"
  },
  Task_62010_Desc = {
    Text = "通关「见山」任意难度"
  },
  Task_62011_Desc = {
    Text = "通关「斗兽」任意难度"
  },
  Task_62012_Desc = {
    Text = "通关「见山」任意难度"
  },
  Task_62013_Desc = {
    Text = "使用超维界域唤醒体在「野兽雄心」中获胜1次"
  },
  Task_62014_Desc = {
    Text = "山峦巨口"
  },
  Task_62015_Desc = {
    Text = "通关「破土」癫狂难度"
  },
  Task_62016_Desc = {
    Text = "野兽雄心·癫狂"
  },
  Task_62017_Desc = {
    Text = "通关「归来」癫狂难度"
  },
  Task_62018_Desc = {
    Text = "野兽雄心·通关"
  },
  Task_62019_Desc = {
    Text = "使用深海界域唤醒体在「野兽雄心」中获胜1次"
  },
  Task_62020_Desc = {
    Text = "在「重生的希冀」交换花苞获得100次回馈"
  },
  Task_62021_Desc = {
    Text = "在「复仇的战意」交换花苞获得200次回馈"
  },
  Task_62022_Desc = {
    Text = "在「复仇的战意」交换花苞获得100次回馈"
  },
  Task_62023_Desc = {
    Text = "完成「野兽雄心·通关」所有任务"
  },
  Task_62024_Desc = {
    Text = "使用混沌界域唤醒体在「野兽雄心」中获胜1次"
  },
  Task_62025_Desc = {
    Text = "在「重生的希冀」交换花苞获得200次回馈"
  },
  Task_62026_Desc = {
    Text = "通关「归来」任意难度"
  },
  Task_62027_Desc = {
    Text = "使用血肉界域唤醒体在「野兽雄心」中获胜1次"
  },
  Task_62028_Desc = {
    Text = "通关「斗兽」任意难度"
  },
  Task_62029_Desc = {
    Text = "通关「斗兽」癫狂难度"
  },
  Task_62030_Desc = {
    Text = "通关「归来」任意难度"
  },
  Task_62031_Desc = {
    Text = "通关「破土」任意难度"
  },
  Task_62092_Desc = {
    Text = "通关特遣纪录「艾尔沃斯的归人」"
  },
  Task_62207_Desc = {
    Text = "血链·希洛同调率达到 10 级"
  },
  Task_62209_Desc = {
    Text = "逃离雪山"
  },
  Task_62209_Name = {Text = "目标"},
  Task_62231_Desc = {
    Text = "获得莱克时启灵6"
  },
  Task_62231_Name = {
    Text = "获得莱克时启灵6"
  },
  Task_62231_UnlockCondDesc = {
    Text = "活动@唤醒体莱克启灵礼包2活动"
  },
  Task_62232_Desc = {
    Text = "获得詹金时启灵2"
  },
  Task_62232_Name = {
    Text = "获得詹金时启灵2"
  },
  Task_62232_UnlockCondDesc = {
    Text = "活动@唤醒体詹金启灵礼包1活动"
  },
  Task_62233_Desc = {
    Text = "获得詹金时启灵6"
  },
  Task_62233_Name = {
    Text = "获得詹金时启灵6"
  },
  Task_62233_UnlockCondDesc = {
    Text = "活动@唤醒体詹金启灵礼包2活动"
  },
  Task_62234_Desc = {
    Text = "获得哈姆林时启灵2"
  },
  Task_62234_Name = {
    Text = "获得哈姆林时启灵2"
  },
  Task_62234_UnlockCondDesc = {
    Text = "活动@唤醒体哈姆林启灵礼包1活动"
  },
  Task_62235_Desc = {
    Text = "获得旺达时启灵2"
  },
  Task_62235_Name = {
    Text = "获得旺达时启灵2"
  },
  Task_62235_UnlockCondDesc = {
    Text = "活动@唤醒体旺达启灵礼包1活动"
  },
  Task_62236_Desc = {
    Text = "获得宁菲亚时启灵6"
  },
  Task_62236_Name = {
    Text = "获得宁菲亚时启灵6"
  },
  Task_62236_UnlockCondDesc = {
    Text = "活动@唤醒体宁菲亚启灵礼包2活动"
  },
  Task_62237_Desc = {
    Text = "获得奥尔拉时启灵2"
  },
  Task_62237_Name = {
    Text = "获得奥尔拉时启灵2"
  },
  Task_62237_UnlockCondDesc = {
    Text = "活动@唤醒体奥尔拉启灵礼包1活动"
  },
  Task_62238_Desc = {
    Text = "获得旺达时启灵6"
  },
  Task_62238_Name = {
    Text = "获得旺达时启灵6"
  },
  Task_62238_UnlockCondDesc = {
    Text = "活动@唤醒体旺达启灵礼包2活动"
  },
  Task_62239_Desc = {
    Text = "获得卡茜亚时启灵2"
  },
  Task_62239_Name = {
    Text = "获得卡茜亚时启灵2"
  },
  Task_62239_UnlockCondDesc = {
    Text = "活动@唤醒体卡茜亚启灵礼包1活动"
  },
  Task_62240_Desc = {
    Text = "获得法洛思时启灵2"
  },
  Task_62240_Name = {
    Text = "获得法洛思时启灵2"
  },
  Task_62240_UnlockCondDesc = {
    Text = "活动@唤醒体法洛思启灵礼包1活动"
  },
  Task_62241_Desc = {
    Text = "获得哈姆林时启灵6"
  },
  Task_62241_Name = {
    Text = "获得哈姆林时启灵6"
  },
  Task_62241_UnlockCondDesc = {
    Text = "活动@唤醒体哈姆林启灵礼包2活动"
  },
  Task_62242_Desc = {
    Text = "获得汀克特时启灵6"
  },
  Task_62242_Name = {
    Text = "获得汀克特时启灵6"
  },
  Task_62242_UnlockCondDesc = {
    Text = "活动@唤醒体汀克特启灵礼包2活动"
  },
  Task_62243_Desc = {
    Text = "获得戈利亚时启灵6"
  },
  Task_62243_Name = {
    Text = "获得戈利亚时启灵6"
  },
  Task_62243_UnlockCondDesc = {
    Text = "活动@唤醒体戈利亚启灵礼包2活动"
  },
  Task_62244_Desc = {
    Text = "获得汀克特时启灵2"
  },
  Task_62244_Name = {
    Text = "获得汀克特时启灵2"
  },
  Task_62244_UnlockCondDesc = {
    Text = "活动@唤醒体汀克特启灵礼包1活动"
  },
  Task_62245_Desc = {
    Text = "获得雷娅时启灵6"
  },
  Task_62245_Name = {
    Text = "获得雷娅时启灵6"
  },
  Task_62245_UnlockCondDesc = {
    Text = "活动@唤醒体雷娅启灵礼包2活动"
  },
  Task_62246_Desc = {
    Text = "获得图鲁时启灵6"
  },
  Task_62246_Name = {
    Text = "获得图鲁时启灵6"
  },
  Task_62246_UnlockCondDesc = {
    Text = "活动@唤醒体图鲁启灵礼包2活动"
  },
  Task_62247_Desc = {
    Text = "获得尤乌哈希时启灵2"
  },
  Task_62247_Name = {
    Text = "获得尤乌哈希时启灵2"
  },
  Task_62247_UnlockCondDesc = {
    Text = "活动@唤醒体尤乌哈希启灵礼包1活动"
  },
  Task_62248_Desc = {
    Text = "获得图鲁时启灵2"
  },
  Task_62248_Name = {
    Text = "获得图鲁时启灵2"
  },
  Task_62248_UnlockCondDesc = {
    Text = "活动@唤醒体图鲁启灵礼包1活动"
  },
  Task_62249_Desc = {
    Text = "获得莉莉时启灵6"
  },
  Task_62249_Name = {
    Text = "获得莉莉时启灵6"
  },
  Task_62249_UnlockCondDesc = {
    Text = "活动@唤醒体莉莉启灵礼包2活动"
  },
  Task_62250_Desc = {
    Text = "获得菲茵特时启灵2"
  },
  Task_62250_Name = {
    Text = "获得菲茵特时启灵2"
  },
  Task_62250_UnlockCondDesc = {
    Text = "活动@唤醒体菲茵特启灵礼包1活动"
  },
  Task_62251_Desc = {
    Text = "获得达芙黛尔时启灵6"
  },
  Task_62251_Name = {
    Text = "获得达芙黛尔时启灵6"
  },
  Task_62251_UnlockCondDesc = {
    Text = "活动@唤醒体达芙黛尔启灵礼包2活动"
  },
  Task_62252_Desc = {
    Text = "获得阿格里帕时启灵6"
  },
  Task_62252_Name = {
    Text = "获得阿格里帕时启灵6"
  },
  Task_62252_UnlockCondDesc = {
    Text = "活动@唤醒体阿格里帕启灵礼包2活动"
  },
  Task_62253_Desc = {
    Text = "获得潘狄娅时启灵2"
  },
  Task_62253_Name = {
    Text = "获得潘狄娅时启灵2"
  },
  Task_62253_UnlockCondDesc = {
    Text = "活动@唤醒体潘狄娅启灵礼包1活动"
  },
  Task_62254_Desc = {
    Text = "获得达芙黛尔时启灵2"
  },
  Task_62254_Name = {
    Text = "获得达芙黛尔时启灵2"
  },
  Task_62254_UnlockCondDesc = {
    Text = "活动@唤醒体达芙黛尔启灵礼包1活动"
  },
  Task_62255_Desc = {
    Text = "获得索蕾尔时启灵2"
  },
  Task_62255_Name = {
    Text = "获得索蕾尔时启灵2"
  },
  Task_62255_UnlockCondDesc = {
    Text = "活动@唤醒体索蕾尔启灵礼包1活动"
  },
  Task_62256_Desc = {
    Text = "获得潘狄娅时启灵6"
  },
  Task_62256_Name = {
    Text = "获得潘狄娅时启灵6"
  },
  Task_62256_UnlockCondDesc = {
    Text = "活动@唤醒体潘狄娅启灵礼包2活动"
  },
  Task_62257_Desc = {
    Text = "获得「24」时启灵6"
  },
  Task_62257_Name = {
    Text = "获得「24」时启灵6"
  },
  Task_62257_UnlockCondDesc = {
    Text = "活动@唤醒体「24」启灵礼包2活动"
  },
  Task_62258_Desc = {
    Text = "获得莉兹时启灵2"
  },
  Task_62258_Name = {
    Text = "获得莉兹时启灵2"
  },
  Task_62258_UnlockCondDesc = {
    Text = "活动@唤醒体莉兹启灵礼包1活动"
  },
  Task_62259_Desc = {
    Text = "获得「24」时启灵2"
  },
  Task_62259_Name = {
    Text = "获得「24」时启灵2"
  },
  Task_62259_UnlockCondDesc = {
    Text = "活动@唤醒体「24」启灵礼包1活动"
  },
  Task_62260_Desc = {
    Text = "获得莉兹时启灵6"
  },
  Task_62260_Name = {
    Text = "获得莉兹时启灵6"
  },
  Task_62260_UnlockCondDesc = {
    Text = "活动@唤醒体莉兹启灵礼包2活动"
  },
  Task_62261_Desc = {
    Text = "获得希洛时启灵2"
  },
  Task_62261_Name = {
    Text = "获得希洛时启灵2"
  },
  Task_62261_UnlockCondDesc = {
    Text = "活动@唤醒体希洛启灵礼包1活动"
  },
  Task_62262_Desc = {
    Text = "获得萨尔瓦多时启灵2"
  },
  Task_62262_Name = {
    Text = "获得萨尔瓦多时启灵2"
  },
  Task_62262_UnlockCondDesc = {
    Text = "活动@唤醒体萨尔瓦多启灵礼包1活动"
  },
  Task_62263_Desc = {
    Text = "获得希洛时启灵6"
  },
  Task_62263_Name = {
    Text = "获得希洛时启灵6"
  },
  Task_62263_UnlockCondDesc = {
    Text = "活动@唤醒体希洛启灵礼包2活动"
  },
  Task_62264_Desc = {
    Text = "获得萨尔瓦多时启灵6"
  },
  Task_62264_Name = {
    Text = "获得萨尔瓦多时启灵6"
  },
  Task_62264_UnlockCondDesc = {
    Text = "活动@唤醒体萨尔瓦多启灵礼包2活动"
  },
  Task_62265_Desc = {
    Text = "获得宁菲亚时启灵2"
  },
  Task_62265_Name = {
    Text = "获得宁菲亚时启灵2"
  },
  Task_62265_UnlockCondDesc = {
    Text = "活动@唤醒体宁菲亚启灵礼包1活动"
  },
  Task_62266_Desc = {
    Text = "获得墨菲时启灵2"
  },
  Task_62266_Name = {
    Text = "获得墨菲时启灵2"
  },
  Task_62266_UnlockCondDesc = {
    Text = "活动@唤醒体墨菲启灵礼包1活动"
  },
  Task_62267_Desc = {
    Text = "获得莱克时启灵2"
  },
  Task_62267_Name = {
    Text = "获得莱克时启灵2"
  },
  Task_62267_UnlockCondDesc = {
    Text = "活动@唤醒体莱克启灵礼包1活动"
  },
  Task_62268_Desc = {
    Text = "获得塔薇时启灵6"
  },
  Task_62268_Name = {
    Text = "获得塔薇时启灵6"
  },
  Task_62268_UnlockCondDesc = {
    Text = "活动@唤醒体塔薇启灵礼包2活动"
  },
  Task_62269_Desc = {
    Text = "获得法洛思时启灵6"
  },
  Task_62269_Name = {
    Text = "获得法洛思时启灵6"
  },
  Task_62269_UnlockCondDesc = {
    Text = "活动@唤醒体法洛思启灵礼包2活动"
  },
  Task_62270_Desc = {
    Text = "获得塔薇时启灵2"
  },
  Task_62270_Name = {
    Text = "获得塔薇时启灵2"
  },
  Task_62270_UnlockCondDesc = {
    Text = "活动@唤醒体塔薇启灵礼包1活动"
  },
  Task_62271_Desc = {
    Text = "获得菲茵特时启灵6"
  },
  Task_62271_Name = {
    Text = "获得菲茵特时启灵6"
  },
  Task_62271_UnlockCondDesc = {
    Text = "活动@唤醒体菲茵特启灵礼包2活动"
  },
  Task_62272_Desc = {
    Text = "获得索蕾尔时启灵6"
  },
  Task_62272_Name = {
    Text = "获得索蕾尔时启灵6"
  },
  Task_62272_UnlockCondDesc = {
    Text = "活动@唤醒体索蕾尔启灵礼包2活动"
  },
  Task_62273_Desc = {
    Text = "获得珊时启灵2"
  },
  Task_62273_Name = {
    Text = "获得珊时启灵2"
  },
  Task_62273_UnlockCondDesc = {
    Text = "活动@唤醒体珊启灵礼包1活动"
  },
  Task_62274_Desc = {
    Text = "获得戈利亚时启灵2"
  },
  Task_62274_Name = {
    Text = "获得戈利亚时启灵2"
  },
  Task_62274_UnlockCondDesc = {
    Text = "活动@唤醒体戈利亚启灵礼包1活动"
  },
  Task_62275_Desc = {
    Text = "获得弥利亚姆时启灵2"
  },
  Task_62275_Name = {
    Text = "获得弥利亚姆时启灵2"
  },
  Task_62275_UnlockCondDesc = {
    Text = "活动@唤醒体弥利亚姆启灵礼包1活动"
  },
  Task_62276_Desc = {
    Text = "获得温柯尔时启灵6"
  },
  Task_62276_Name = {
    Text = "获得温柯尔时启灵6"
  },
  Task_62276_UnlockCondDesc = {
    Text = "活动@唤醒体温柯尔启灵礼包2活动"
  },
  Task_62277_Desc = {
    Text = "获得凯刻斯时启灵2"
  },
  Task_62277_Name = {
    Text = "获得凯刻斯时启灵2"
  },
  Task_62277_UnlockCondDesc = {
    Text = "活动@唤醒体凯刻斯启灵礼包1活动"
  },
  Task_62278_Desc = {
    Text = "获得弥利亚姆时启灵6"
  },
  Task_62278_Name = {
    Text = "获得弥利亚姆时启灵6"
  },
  Task_62278_UnlockCondDesc = {
    Text = "活动@唤醒体弥利亚姆启灵礼包2活动"
  },
  Task_62279_Desc = {
    Text = "获得温柯尔时启灵2"
  },
  Task_62279_Name = {
    Text = "获得温柯尔时启灵2"
  },
  Task_62279_UnlockCondDesc = {
    Text = "活动@唤醒体温柯尔启灵礼包1活动"
  },
  Task_62280_Desc = {
    Text = "获得凯刻斯时启灵6"
  },
  Task_62280_Name = {
    Text = "获得凯刻斯时启灵6"
  },
  Task_62280_UnlockCondDesc = {
    Text = "活动@唤醒体凯刻斯启灵礼包2活动"
  },
  Task_62281_Desc = {
    Text = "获得诺缔拉时启灵2"
  },
  Task_62281_Name = {
    Text = "获得诺缔拉时启灵2"
  },
  Task_62281_UnlockCondDesc = {
    Text = "活动@唤醒体诺缔拉启灵礼包1活动"
  },
  Task_62282_Desc = {
    Text = "获得雷娅时启灵2"
  },
  Task_62282_Name = {
    Text = "获得雷娅时启灵2"
  },
  Task_62282_UnlockCondDesc = {
    Text = "活动@唤醒体雷娅启灵礼包1活动"
  },
  Task_62283_Desc = {
    Text = "获得希莱斯特时启灵2"
  },
  Task_62283_Name = {
    Text = "获得希莱斯特时启灵2"
  },
  Task_62283_UnlockCondDesc = {
    Text = "活动@唤醒体希莱斯特启灵礼包1活动"
  },
  Task_62284_Desc = {
    Text = "获得珈伦时启灵2"
  },
  Task_62284_Name = {
    Text = "获得珈伦时启灵2"
  },
  Task_62284_UnlockCondDesc = {
    Text = "活动@唤醒体珈伦启灵礼包1活动"
  },
  Task_62285_Desc = {
    Text = "获得珊时启灵6"
  },
  Task_62285_Name = {
    Text = "获得珊时启灵6"
  },
  Task_62285_UnlockCondDesc = {
    Text = "活动@唤醒体珊启灵礼包2活动"
  },
  Task_62286_Desc = {
    Text = "获得希莱斯特时启灵6"
  },
  Task_62286_Name = {
    Text = "获得希莱斯特时启灵6"
  },
  Task_62286_UnlockCondDesc = {
    Text = "活动@唤醒体希莱斯特启灵礼包2活动"
  },
  Task_62287_Desc = {
    Text = "获得珈伦时启灵6"
  },
  Task_62287_Name = {
    Text = "获得珈伦时启灵6"
  },
  Task_62287_UnlockCondDesc = {
    Text = "活动@唤醒体珈伦启灵礼包2活动"
  },
  Task_62288_Desc = {
    Text = "获得诺缔拉时启灵6"
  },
  Task_62288_Name = {
    Text = "获得诺缔拉时启灵6"
  },
  Task_62288_UnlockCondDesc = {
    Text = "活动@唤醒体诺缔拉启灵礼包2活动"
  },
  Task_62289_Desc = {
    Text = "获得墨菲时启灵6"
  },
  Task_62289_Name = {
    Text = "获得墨菲时启灵6"
  },
  Task_62289_UnlockCondDesc = {
    Text = "活动@唤醒体墨菲启灵礼包2活动"
  },
  Task_62290_Desc = {
    Text = "获得奥尔拉时启灵6"
  },
  Task_62290_Name = {
    Text = "获得奥尔拉时启灵6"
  },
  Task_62290_UnlockCondDesc = {
    Text = "活动@唤醒体奥尔拉启灵礼包2活动"
  },
  Task_62291_Desc = {
    Text = "获得泰旖丝时启灵2"
  },
  Task_62291_Name = {
    Text = "获得泰旖丝时启灵2"
  },
  Task_62291_UnlockCondDesc = {
    Text = "活动@唤醒体泰旖丝启灵礼包1活动"
  },
  Task_62292_Desc = {
    Text = "获得艾尔瓦时启灵6"
  },
  Task_62292_Name = {
    Text = "获得艾尔瓦时启灵6"
  },
  Task_62292_UnlockCondDesc = {
    Text = "活动@唤醒体艾尔瓦启灵礼包2活动"
  },
  Task_62293_Desc = {
    Text = "获得阿格里帕时启灵2"
  },
  Task_62293_Name = {
    Text = "获得阿格里帕时启灵2"
  },
  Task_62293_UnlockCondDesc = {
    Text = "活动@唤醒体阿格里帕启灵礼包1活动"
  },
  Task_62294_Desc = {
    Text = "获得莉莉时启灵2"
  },
  Task_62294_Name = {
    Text = "获得莉莉时启灵2"
  },
  Task_62294_UnlockCondDesc = {
    Text = "活动@唤醒体莉莉启灵礼包1活动"
  },
  Task_62295_Desc = {
    Text = "获得泰旖丝时启灵6"
  },
  Task_62295_Name = {
    Text = "获得泰旖丝时启灵6"
  },
  Task_62295_UnlockCondDesc = {
    Text = "活动@唤醒体泰旖丝启灵礼包2活动"
  },
  Task_62296_Desc = {
    Text = "获得艾尔瓦时启灵2"
  },
  Task_62296_Name = {
    Text = "获得艾尔瓦时启灵2"
  },
  Task_62296_UnlockCondDesc = {
    Text = "活动@唤醒体艾尔瓦启灵礼包1活动"
  },
  Task_62297_Desc = {
    Text = "获得尤乌哈希时启灵6"
  },
  Task_62297_Name = {
    Text = "获得尤乌哈希时启灵6"
  },
  Task_62297_UnlockCondDesc = {
    Text = "活动@唤醒体尤乌哈希启灵礼包2活动"
  },
  Task_62298_Desc = {
    Text = "获得本源希洛时启灵2"
  },
  Task_62298_Name = {
    Text = "获得本源希洛时启灵2"
  },
  Task_62298_UnlockCondDesc = {
    Text = "活动@唤醒体本源希洛启灵礼包1活动"
  },
  Task_62299_Desc = {
    Text = "获得本源希洛时启灵6"
  },
  Task_62299_Name = {
    Text = "获得本源希洛时启灵6"
  },
  Task_62299_UnlockCondDesc = {
    Text = "活动@唤醒体本源希洛启灵礼包2活动"
  },
  Task_62300_Desc = {
    Text = "获得卡茜亚时启灵6"
  },
  Task_62300_Name = {
    Text = "获得卡茜亚时启灵6"
  },
  Task_62300_UnlockCondDesc = {
    Text = "活动@唤醒体卡茜亚启灵礼包2活动"
  },
  Task_62320_Desc = {
    Text = "完成特遣纪录「艾尔沃斯的归人」困难难度"
  },
  Task_62320_Name = {
    Text = "生命，破山而出·困难"
  },
  Task_62321_Desc = {
    Text = "完成调查事件「终末交响曲」困难难度"
  },
  Task_62321_Name = {
    Text = "战斗，以铭记的名义·困难"
  },
  Task_62322_Desc = {
    Text = "完成调查事件「@1@2」"
  },
  Task_62322_Desc2 = {
    Text = "完成调查事件「终末交响曲」"
  },
  Task_62322_Name = {Text = "@1@2"},
  Task_62322_Name2 = {
    Text = "战斗，以铭记的名义"
  },
  Task_62323_Desc = {
    Text = "在调查事件「@1@2」中共鸣3次"
  },
  Task_62323_Desc2 = {
    Text = "在调查事件「终末交响曲」中共鸣3次"
  },
  Task_62323_Name = {Text = "@1@2"},
  Task_62323_Name2 = {
    Text = "坚韧回响"
  },
  Task_62324_Desc = {
    Text = "完成特遣纪录「狩猎愉快！」"
  },
  Task_62324_Name = {
    Text = "命运的戏谑"
  },
  Task_62325_Desc = {
    Text = "在调查事件「@1@2」中共鸣9次"
  },
  Task_62325_Desc2 = {
    Text = "在调查事件「终末交响曲」中共鸣9次"
  },
  Task_62325_Name = {Text = "@1@2"},
  Task_62325_Name2 = {
    Text = "坚韧回响Ⅲ"
  },
  Task_62326_Desc = {
    Text = "找到10处主线第八章「@1@2」的析出点"
  },
  Task_62326_Desc2 = {
    Text = "找到10处主线第八章「终末交响曲」的析出点"
  },
  Task_62326_Name = {Text = "@1@2"},
  Task_62326_Name2 = {
    Text = "潜藏的低语Ⅷ"
  },
  Task_62327_Desc = {
    Text = "完成特遣纪录「艾尔沃斯的归人」"
  },
  Task_62327_Name = {
    Text = "生命，破山而出"
  },
  Task_62328_Desc = {
    Text = "完成特遣纪录「狩猎愉快！」困难难度"
  },
  Task_62328_Name = {
    Text = "命运的戏谑·困难"
  },
  Task_62329_Desc = {
    Text = "完成特遣纪录「玫瑰的栖居」"
  },
  Task_62329_Name = {
    Text = "花与诗的余香"
  },
  Task_62330_Desc = {
    Text = "在调查事件「@1@2」中共鸣6次"
  },
  Task_62330_Desc2 = {
    Text = "在调查事件「终末交响曲」中共鸣6次"
  },
  Task_62330_Name = {Text = "@1@2"},
  Task_62330_Name2 = {
    Text = "坚韧回响Ⅱ"
  },
  Task_62331_Desc = {
    Text = "在调查事件「@1@2」中共鸣13次"
  },
  Task_62331_Desc2 = {
    Text = "在调查事件「终末交响曲」中共鸣13次"
  },
  Task_62331_Name = {Text = "@1@2"},
  Task_62331_Name2 = {
    Text = "坚韧回响Ⅳ"
  },
  Task_62332_Desc = {
    Text = "完成特遣纪录「玫瑰的栖居」困难难度"
  },
  Task_62332_Name = {
    Text = "花与诗的余香·困难"
  },
  Task_62346_Desc = {
    Text = "在不依靠拉蒙娜协助的情况下，击败「完全的遗忘之理」。"
  },
  Task_62346_Name = {
    Text = "孤独的无上威仪"
  },
  Task_62371_Desc = {
    Text = "在拉蒙娜的协助下，击败「遗忘的伊始」。"
  },
  Task_62371_Name = {
    Text = "握住我的手，守密人"
  },
  Task_65510_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_65511_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_65512_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_65513_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_65514_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_65515_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_65516_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_65517_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_65518_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_65519_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_65722_Desc = {
    Text = "使用血肉界域唤醒体在「记忆编码」中获胜1次"
  },
  Task_65723_Desc = {
    Text = "通关「镜子」任意难度"
  },
  Task_65724_Desc = {
    Text = "使用超维界域唤醒体在「记忆编码」中获胜1次"
  },
  Task_65725_Desc = {
    Text = "记忆编码·通关"
  },
  Task_65726_Desc = {
    Text = "记忆编码·界域"
  },
  Task_65727_Desc = {
    Text = "通关「杏仁体」癫狂难度"
  },
  Task_65728_Desc = {
    Text = "通关「遗忘曲线」癫狂难度"
  },
  Task_65729_Desc = {
    Text = "使用混沌界域唤醒体在「记忆编码」中获胜1次"
  },
  Task_65730_Desc = {
    Text = "通关「杏仁体」任意难度"
  },
  Task_65731_Desc = {
    Text = "通关「杏仁体」任意难度"
  },
  Task_65732_Desc = {
    Text = "通关「镜子」任意难度"
  },
  Task_65733_Desc = {
    Text = "通关「遗忘曲线」任意难度"
  },
  Task_65734_Desc = {
    Text = "通关「爬虫脑」任意难度"
  },
  Task_65735_Desc = {
    Text = "完成「记忆编码·通关」所有任务"
  },
  Task_65736_Desc = {
    Text = "通关「遗忘曲线」任意难度"
  },
  Task_65737_Desc = {
    Text = "通关「无意识记」任意难度"
  },
  Task_65738_Desc = {
    Text = "通关「镜子」癫狂难度"
  },
  Task_65739_Desc = {
    Text = "记忆编码·癫狂"
  },
  Task_65740_Desc = {
    Text = "通关「无意识记」任意难度"
  },
  Task_65741_Desc = {
    Text = "通关特遣纪录「宁静的裂殖」"
  },
  Task_65742_Desc = {
    Text = "通关「无意识记」癫狂难度"
  },
  Task_65743_Desc = {
    Text = "通关「爬虫脑」任意难度"
  },
  Task_65744_Desc = {
    Text = "通关「爬虫脑」癫狂难度"
  },
  Task_65745_Desc = {
    Text = "使用深海界域唤醒体在「记忆编码」中获胜1次"
  },
  Task_66015_Desc = {
    Text = "塔薇同调率达到 10 级"
  },
  Task_66213_Desc = {
    Text = "神国诞临·癫狂"
  },
  Task_66214_Desc = {
    Text = "使用超维界域唤醒体在「神国诞临」中获胜1次"
  },
  Task_66215_Desc = {
    Text = "通关「见证」任意难度"
  },
  Task_66216_Desc = {
    Text = "通关「动摇」癫狂难度"
  },
  Task_66217_Desc = {
    Text = "通关「降临」任意难度"
  },
  Task_66218_Desc = {
    Text = "通关「笃信」癫狂难度"
  },
  Task_66219_Desc = {
    Text = "使用混沌界域唤醒体在「神国诞临」中获胜1次"
  },
  Task_66220_Desc = {
    Text = "通关「笃信」任意难度"
  },
  Task_66221_Desc = {
    Text = "通关「见证」任意难度"
  },
  Task_66224_Desc = {
    Text = "通关「质疑」任意难度"
  },
  Task_66227_Desc = {
    Text = "通关异梦视界「亵渎」"
  },
  Task_66228_Desc = {
    Text = "完成「神国诞临·通关」所有任务"
  },
  Task_66229_Desc = {
    Text = "通关「见证」癫狂难度"
  },
  Task_66230_Desc = {
    Text = "使用深海界域唤醒体在「神国诞临」中获胜1次"
  },
  Task_66231_Desc = {
    Text = "通关「降临」癫狂难度"
  },
  Task_66232_Desc = {
    Text = "神国诞临·界域"
  },
  Task_66233_Desc = {
    Text = "通关「动摇」任意难度"
  },
  Task_66235_Desc = {
    Text = "通关「质疑」癫狂难度"
  },
  Task_66236_Desc = {
    Text = "使用血肉界域唤醒体在「神国诞临」中获胜1次"
  },
  Task_66237_Desc = {
    Text = "通关「降临」任意难度"
  },
  Task_66238_Desc = {
    Text = "通关「动摇」任意难度"
  },
  Task_66240_Desc = {
    Text = "神国诞临·通关"
  },
  Task_66241_Desc = {
    Text = "通关「笃信」任意难度"
  },
  Task_66242_Desc = {
    Text = "通关「质疑」任意难度"
  },
  Task_66243_Desc = {
    Text = "沉渊的回应"
  },
  Task_66335_Desc = {
    Text = "逃离审查会追击"
  },
  Task_66335_Name = {Text = "目标"},
  Task_66336_Desc = {
    Text = "阻止人面犬报信"
  },
  Task_66336_Name = {Text = "目标"},
  Task_66337_Desc = {
    Text = "突破审查会的封锁"
  },
  Task_66337_Name = {Text = "目标"},
  Task_66338_Desc = {
    Text = "击败泰旖丝"
  },
  Task_66338_Name = {Text = "目标"},
  Task_66339_Desc = {Text = "击败N"},
  Task_66339_Name = {Text = "目标"},
  Task_66340_Desc = {
    Text = "阻止审查会的入侵"
  },
  Task_66340_Name = {Text = "目标"},
  Task_66341_Desc = {
    Text = "破坏双子神像"
  },
  Task_66341_Name = {Text = "目标"},
  Task_66342_Desc = {
    Text = "抵御哈姆林"
  },
  Task_66342_Name = {Text = "目标"},
  Task_66343_Desc = {
    Text = "找到塔薇"
  },
  Task_66343_Name = {Text = "目标"},
  Task_66344_Desc = {
    Text = "阻止于丽埃特"
  },
  Task_66344_Name = {Text = "目标"},
  Task_66422_Name = {
    Text = "击败BOSS1N次"
  },
  Task_66423_Name = {
    Text = "击败BOSS2N次"
  },
  Task_66424_Name = {
    Text = "击败BOSS3N次"
  },
  Task_66425_Name = {
    Text = "击败BOSS4N次"
  },
  Task_66426_Name = {
    Text = "击败BOSS5N次"
  },
  Task_66428_Name = {
    Text = "击杀全部BOSS"
  },
  Task_66580_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_66580_Name = {
    Text = "完美通过"
  },
  Task_66581_Desc = {
    Text = "通关时携带至少8个造物"
  },
  Task_66581_Name = {
    Text = "奇兵秘藏"
  },
  Task_66582_Desc = {
    Text = "最终战不超过25回合取胜"
  },
  Task_66582_Name = {
    Text = "速战速决"
  },
  Task_66583_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_66583_Name = {
    Text = "优雅而精准"
  },
  Task_66584_Desc = {
    Text = "通关时携带至少8个造物"
  },
  Task_66584_Name = {
    Text = "奇兵秘藏"
  },
  Task_66585_Desc = {
    Text = "最终战中一回合造成至少200000点伤害"
  },
  Task_66585_Name = {
    Text = "全力一击"
  },
  Task_66724_Desc = {
    Text = "通关「启程」癫狂难度"
  },
  Task_66725_Desc = {
    Text = "通关「诸世之门」癫狂难度"
  },
  Task_66726_Desc = {
    Text = "通关「知行之门」癫狂难度"
  },
  Task_66727_Desc = {
    Text = "通关「穷极之门」任意难度"
  },
  Task_66728_Desc = {
    Text = "通关「是非之门」癫狂难度"
  },
  Task_66729_Desc = {
    Text = "通关「归一之门」任意难度"
  },
  Task_66730_Desc = {
    Text = "通关「启程」任意难度"
  },
  Task_66731_Desc = {
    Text = "通关「是非之门」任意难度"
  },
  Task_66732_Desc = {
    Text = "通关「门扉之内」癫狂难度"
  },
  Task_66733_Desc = {
    Text = "使用深海界域唤醒体在「最终测试」中获胜1次"
  },
  Task_66734_Desc = {
    Text = "使用超维界域唤醒体在「最终测试」中获胜2次"
  },
  Task_66735_Desc = {
    Text = "使用深海界域唤醒体在「最终测试」中获胜2次"
  },
  Task_66736_Desc = {
    Text = "使用超维界域唤醒体在「最终测试」中获胜1次"
  },
  Task_66737_Desc = {
    Text = "通关「是非之门」任意难度"
  },
  Task_66738_Desc = {
    Text = "通关「知行之门」任意难度"
  },
  Task_66739_Desc = {
    Text = "最终测试·癫狂"
  },
  Task_66740_Desc = {
    Text = "通关「知行之门」任意难度"
  },
  Task_66741_Desc = {
    Text = "通关「诸世之门」任意难度"
  },
  Task_66742_Desc = {
    Text = "通关「穷极之门」任意难度"
  },
  Task_66743_Desc = {
    Text = "通关「门扉之内」任意难度"
  },
  Task_66744_Desc = {
    Text = "最终测试·通关"
  },
  Task_66745_Desc = {
    Text = "使用血肉界域唤醒体在「最终测试」中获胜2次"
  },
  Task_66746_Desc = {
    Text = "使用血肉界域唤醒体在「最终测试」中获胜1次"
  },
  Task_66747_Desc = {
    Text = "通关「理智之门」癫狂难度"
  },
  Task_66748_Desc = {
    Text = "通关「归一之门」癫狂难度"
  },
  Task_66749_Desc = {
    Text = "通关「启程」任意难度"
  },
  Task_66750_Desc = {
    Text = "使用混沌界域唤醒体在「最终测试」中获胜2次"
  },
  Task_66751_Desc = {
    Text = "使用混沌界域唤醒体在「最终测试」中获胜1次"
  },
  Task_66752_Desc = {
    Text = "通关「门扉之内」任意难度"
  },
  Task_66753_Desc = {
    Text = "通关「本性之门」任意难度"
  },
  Task_66754_Desc = {
    Text = "通关「本性之门」癫狂难度"
  },
  Task_66755_Desc = {
    Text = "通关「穷极之门」癫狂难度"
  },
  Task_66756_Desc = {
    Text = "最终测试·界域"
  },
  Task_66757_Desc = {
    Text = "完成「最终测试·通关」所有任务"
  },
  Task_66758_Desc = {
    Text = "通关「理智之门」任意难度"
  },
  Task_66759_Desc = {
    Text = "通关「本性之门」任意难度"
  },
  Task_66760_Desc = {
    Text = "通关「诸世之门」任意难度"
  },
  Task_66761_Desc = {
    Text = "通关「理智之门」任意难度"
  },
  Task_66762_Desc = {
    Text = "通关「归一之门」任意难度"
  },
  Task_67066_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_67067_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_67068_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_67069_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_67070_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_67071_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_67072_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_67073_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_67075_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_67076_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_67113_Desc = {
    Text = "找到2处主线终章「@1@2」的析出点"
  },
  Task_67113_Desc2 = {
    Text = "找到2处主线终章「长梦尽时」的析出点"
  },
  Task_67113_Name = {Text = "@1@2"},
  Task_67113_Name2 = {
    Text = "潜藏的低语Ⅸ"
  },
  Task_67114_Desc = {
    Text = "完成调查事件「长梦尽时」困难难度"
  },
  Task_67114_Name = {
    Text = "守望，至死方休·困难"
  },
  Task_67115_Desc = {
    Text = "完成调查事件「@1@2」"
  },
  Task_67115_Desc2 = {
    Text = "完成调查事件「长梦尽时」"
  },
  Task_67115_Name = {Text = "@1@2"},
  Task_67115_Name2 = {
    Text = "守望，至死方休"
  },
  Task_67116_Desc = {
    Text = "在调查事件「@1@2」中共鸣3次"
  },
  Task_67116_Desc2 = {
    Text = "在调查事件「长梦尽时」中共鸣3次"
  },
  Task_67116_Name = {Text = "@1@2"},
  Task_67116_Name2 = {
    Text = "穷极回响"
  },
  Task_67125_Name = {
    Text = "击败BOSS6N次"
  },
  Task_67126_Name = {
    Text = "击败BOSS7N次"
  },
  Task_67408_Desc = {
    Text = "阻挡托乎瓦波，关闭门扉"
  },
  Task_67408_Name = {Text = "目标"},
  Task_67409_Desc = {
    Text = "找到弥萨格的内鬼"
  },
  Task_67409_Name = {Text = "目标"},
  Task_67410_Desc = {
    Text = "阻挡托乎瓦波"
  },
  Task_67410_Name = {Text = "目标"},
  Task_67411_Desc = {
    Text = "与唤醒体们告别"
  },
  Task_67411_Name = {Text = "目标"},
  Task_67827_Desc = {
    Text = "臣服吧……臣服于，这永恒混沌的真相……"
  },
  Task_67827_Name = {
    Text = "臣服吧……臣服于，这永恒混沌的真相……"
  },
  Task_67828_Desc = {
    Text = "祂的痴愚，无可反抗。"
  },
  Task_67828_Name = {
    Text = "祂的痴愚，无可反抗。"
  },
  Task_67829_Desc = {
    Text = "祂的威仪，不可直视。"
  },
  Task_67829_Name = {
    Text = "祂的威仪，不可直视。"
  },
  Task_67919_Desc = {
    Text = "消灭「索纳尼尔号·疯狂之视」所有分身解锁"
  },
  Task_67919_Name = {
    Text = "击杀BOSS6"
  },
  Task_67920_Desc = {
    Text = "消灭「蜡像馆·恐惧之视」所有分身解锁"
  },
  Task_67920_Name = {
    Text = "击杀BOSS2"
  },
  Task_67921_Desc = {
    Text = "消灭「疗养院·诡谲之视」所有分身解锁"
  },
  Task_67921_Name = {
    Text = "击杀BOSS4"
  },
  Task_67922_Desc = {
    Text = "消灭「布里尔珀特·邪信之视」所有分身解锁"
  },
  Task_67922_Name = {
    Text = "击杀BOSS5"
  },
  Task_67923_Desc = {
    Text = "消灭「济贫院·悲泣之视」所有分身解锁"
  },
  Task_67923_Name = {
    Text = "击杀BOSS1"
  },
  Task_67924_Desc = {
    Text = "消灭「勒姆瓦希·诞临之视」所有分身解锁"
  },
  Task_67924_Name = {
    Text = "击杀BOSS7"
  },
  Task_67925_Desc = {
    Text = "消灭「拉伊·刺骨之视」所有分身解锁"
  },
  Task_67925_Name = {
    Text = "击杀BOSS3"
  },
  Task_67926_Name = {
    Text = "5个原初之视的所有分身被击杀"
  },
  Task_67927_Name = {
    Text = "2个原初之视的所有分身被击杀"
  },
  Task_67928_Name = {
    Text = "4个原初之视的所有分身被击杀"
  },
  Task_67929_Name = {
    Text = "6个原初之视的所有分身被击杀"
  },
  Task_67930_Name = {
    Text = "1个原初之视的所有分身被击杀"
  },
  Task_67931_Name = {
    Text = "7个原初之视的所有分身被击杀"
  },
  Task_67932_Name = {
    Text = "3个原初之视的所有分身被击杀"
  },
  Task_68342_Desc = {
    Text = "超越星辰Ⅲ"
  },
  Task_68343_Desc = {
    Text = "超越星辰Ⅴ"
  },
  Task_68344_Desc = {
    Text = "超越星辰Ⅶ"
  },
  Task_68345_Desc = {
    Text = "超越星辰Ⅱ"
  },
  Task_68346_Desc = {
    Text = "超越星辰Ⅳ"
  },
  Task_68347_Desc = {
    Text = "超越星辰Ⅰ"
  },
  Task_68348_Desc = {
    Text = "超越星辰Ⅵ"
  },
  Task_68365_Desc = {
    Text = "超越星辰·免费"
  },
  Task_68377_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68378_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68379_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68380_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68382_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68383_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68384_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68385_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68386_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68387_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68388_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68389_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68390_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68391_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68392_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68393_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68394_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68395_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68396_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68397_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_68418_Name = {
    Text = "世界BOSS活动结束"
  },
  Task_68492_Desc = {
    Text = "使用深海界域唤醒体在「深海凝视」中获胜1次"
  },
  Task_68493_Desc = {
    Text = "通关「神之眸」癫狂难度"
  },
  Task_68494_Desc = {
    Text = "使用超维界域唤醒体在「深海凝视」中获胜1次"
  },
  Task_68495_Desc = {
    Text = "通关「美好幻想」任意难度"
  },
  Task_68496_Desc = {
    Text = "通关「美好幻想」癫狂难度"
  },
  Task_68497_Desc = {
    Text = "通关「人性崩毁」任意难度"
  },
  Task_68498_Desc = {
    Text = "通关「人性崩毁」癫狂难度"
  },
  Task_68499_Desc = {
    Text = "使用血肉界域唤醒体在「深海凝视」中获胜1次"
  },
  Task_68500_Desc = {
    Text = "通关「神之眸」任意难度"
  },
  Task_68501_Desc = {
    Text = "通关「人性崩毁」任意难度"
  },
  Task_68502_Desc = {
    Text = "通关「乡愁」任意难度"
  },
  Task_68503_Desc = {
    Text = "使用混沌界域唤醒体在「深海凝视」中获胜1次"
  },
  Task_68504_Desc = {
    Text = "深海凝视·癫狂"
  },
  Task_68505_Desc = {
    Text = "通关「美好幻想」任意难度"
  },
  Task_68506_Desc = {
    Text = "通关「衰亡国度」任意难度"
  },
  Task_68507_Desc = {
    Text = "深海凝视·通关"
  },
  Task_68508_Desc = {
    Text = "通关「乡愁」任意难度"
  },
  Task_68509_Desc = {
    Text = "通关「乡愁」癫狂难度"
  },
  Task_68510_Desc = {
    Text = "通关「衰亡国度」任意难度"
  },
  Task_68511_Desc = {
    Text = "通关「衰亡国度」癫狂难度"
  },
  Task_68512_Desc = {
    Text = "深海凝视·界域"
  },
  Task_68513_Desc = {
    Text = "完成「深海凝视·通关」所有任务"
  },
  Task_68514_Desc = {
    Text = "通关「神之眸」任意难度"
  },
  Task_68860_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_68860_Name = {Text = "1胜"},
  Task_68861_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_68861_Name = {Text = "6胜"},
  Task_68862_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_68862_Name = {Text = "3胜"},
  Task_68863_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_68863_Name = {Text = "10胜"},
  Task_68864_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_68864_Name = {Text = "3胜"},
  Task_68865_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_68865_Name = {Text = "6胜"},
  Task_68866_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_68866_Name = {Text = "1胜"},
  Task_68867_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_68867_Name = {Text = "10胜"},
  Task_69819_Desc = {
    Text = "最终战35回合内取胜"
  },
  Task_69819_Name = {
    Text = "最终战35回合内取胜"
  },
  Task_70112_Desc = {
    Text = "使用深海界域唤醒体在「紊乱情欲」中获胜1次"
  },
  Task_70113_Desc = {
    Text = "通关「年轮」癫狂难度"
  },
  Task_70114_Desc = {
    Text = "使用深海界域唤醒体在「紊乱情欲」中获胜2次"
  },
  Task_70115_Desc = {
    Text = "通关「幼根」任意难度"
  },
  Task_70116_Desc = {
    Text = "通关「授粉」任意难度"
  },
  Task_70117_Desc = {
    Text = "通关「幼根」癫狂难度"
  },
  Task_70118_Desc = {
    Text = "通关「出芽」任意难度"
  },
  Task_70119_Desc = {
    Text = "使用超维界域唤醒体在「紊乱情欲」中获胜1次"
  },
  Task_70120_Desc = {
    Text = "使用超维界域唤醒体在「紊乱情欲」中获胜2次"
  },
  Task_70121_Desc = {
    Text = "紊乱情欲·癫狂"
  },
  Task_70122_Desc = {
    Text = "通关「落果」癫狂难度"
  },
  Task_70123_Desc = {
    Text = "紊乱情欲·界域"
  },
  Task_70124_Desc = {
    Text = "通关「授粉」癫狂难度"
  },
  Task_70125_Desc = {
    Text = "通关「花萼」癫狂难度"
  },
  Task_70126_Desc = {
    Text = "通关「再生花」任意难度"
  },
  Task_70127_Desc = {
    Text = "通关「再生花」癫狂难度"
  },
  Task_70128_Desc = {
    Text = "通关「出芽」癫狂难度"
  },
  Task_70129_Desc = {
    Text = "通关「蜜腺」任意难度"
  },
  Task_70130_Desc = {
    Text = "通关「年轮」任意难度"
  },
  Task_70131_Desc = {
    Text = "通关「胚珠」任意难度"
  },
  Task_70132_Desc = {
    Text = "通关「落果」任意难度"
  },
  Task_70133_Desc = {
    Text = "通关「胚珠」癫狂难度"
  },
  Task_70134_Desc = {
    Text = "使用混沌界域唤醒体在「紊乱情欲」中获胜2次"
  },
  Task_70135_Desc = {
    Text = "通关「花萼」任意难度"
  },
  Task_70136_Desc = {
    Text = "使用混沌界域唤醒体在「紊乱情欲」中获胜1次"
  },
  Task_70137_Desc = {
    Text = "使用血肉界域唤醒体在「紊乱情欲」中获胜2次"
  },
  Task_70138_Desc = {
    Text = "通关「多胚生殖」癫狂难度"
  },
  Task_70139_Desc = {
    Text = "使用血肉界域唤醒体在「紊乱情欲」中获胜1次"
  },
  Task_70140_Desc = {
    Text = "通关「多胚生殖」任意难度"
  },
  Task_70141_Desc = {
    Text = "通关「蜜腺」癫狂难度"
  },
  Task_70307_Desc = {
    Text = "最终战40回合内取胜"
  },
  Task_70307_Name = {
    Text = "最终战40回合内取胜"
  },
  Task_70446_Name = {
    Text = "重新通关8-8"
  },
  Task_70447_Name = {
    Text = "重新通关8-4"
  },
  Task_70448_Name = {
    Text = "重新通关莱克支线关卡普通12"
  },
  Task_70449_Name = {
    Text = "重新通关艾瑞卡支线关卡普通3"
  },
  Task_70450_Name = {
    Text = "重新通关3-14"
  },
  Task_70451_Name = {
    Text = "重新通关珊支线关卡普通4"
  },
  Task_70452_Name = {
    Text = "重新通关奥尔拉支线关卡普通9"
  },
  Task_70453_Name = {
    Text = "重新通关奥吉尔支线关卡普通4"
  },
  Task_70454_Name = {
    Text = "重新通关2-16"
  },
  Task_70455_Name = {
    Text = "重新通关2-15"
  },
  Task_70456_Name = {
    Text = "重新通关奥瑞塔支线关卡普通3"
  },
  Task_70457_Name = {
    Text = "重新通关「24」支线关卡普通10"
  },
  Task_70458_Name = {
    Text = "重新通关达芙黛尔支线关卡普通10"
  },
  Task_70459_Name = {
    Text = "重新通关阿格里帕支线关卡普通5"
  },
  Task_70460_Name = {
    Text = "重新通关6-8"
  },
  Task_70461_Name = {
    Text = "重新通关8-14"
  },
  Task_70462_Name = {
    Text = "重新通关索蕾尔支线关卡普通13"
  },
  Task_70463_Name = {
    Text = "重新通关弥利亚姆支线关卡普通15"
  },
  Task_70464_Name = {
    Text = "重新通关8-7"
  },
  Task_70465_Name = {
    Text = "重新通关7-2"
  },
  Task_70466_Name = {
    Text = "重新通关7-3"
  },
  Task_70467_Name = {
    Text = "重新通关7-1"
  },
  Task_70468_Name = {
    Text = "重新通关莉莉支线关卡普通7"
  },
  Task_70469_Name = {
    Text = "重新通关本源拉蒙娜支线关卡普通4"
  },
  Task_70470_Name = {
    Text = "重新通关1-8"
  },
  Task_70471_Name = {
    Text = "重新通关本源希洛支线关卡普通9"
  },
  Task_70472_Name = {
    Text = "重新通关4-16"
  },
  Task_70473_Name = {
    Text = "重新通关1-14"
  },
  Task_70474_Name = {
    Text = "重新通关4-13"
  },
  Task_70475_Name = {
    Text = "重新通关1-15"
  },
  Task_70476_Name = {
    Text = "重新通关9-13"
  },
  Task_70477_Name = {
    Text = "重新通关3-2"
  },
  Task_70478_Name = {
    Text = "重新通关3-3"
  },
  Task_70479_Name = {
    Text = "重新通关尤乌哈希支线关卡普通4"
  },
  Task_70480_Name = {
    Text = "重新通关6-15"
  },
  Task_70481_Name = {
    Text = "重新通关戈利亚支线关卡普通3"
  },
  Task_70482_Name = {
    Text = "重新通关5-12"
  },
  Task_70483_Name = {
    Text = "重新通关6-10"
  },
  Task_70484_Name = {
    Text = "重新通关萨尔瓦多支线关卡普通9"
  },
  Task_70485_Name = {
    Text = "重新通关旺达支线关卡普通4"
  },
  Task_70941_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_70941_Name = {
    Text = "速战速决"
  },
  Task_70942_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_70942_Name = {
    Text = "优雅而精准"
  },
  Task_70943_Desc = {
    Text = "最终战一回合额外抽取至少5张牌"
  },
  Task_70943_Name = {Text = "抽卡！"},
  Task_70944_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_70944_Name = {
    Text = "节能主义"
  },
  Task_70945_Desc = {
    Text = "获得至少1种刻印"
  },
  Task_70945_Name = {
    Text = "灵魂烙印"
  },
  Task_70946_Desc = {
    Text = "通关时生命不低于50%"
  },
  Task_70946_Name = {
    Text = "优雅而精准"
  },
  Task_70947_Desc = {
    Text = "通关时携带至少1个黄金造物"
  },
  Task_70947_Name = {
    Text = "奇兵秘藏"
  },
  Task_70948_Desc = {
    Text = "通关时症状卡不多于2张"
  },
  Task_70948_Name = {
    Text = "节能主义"
  },
  Task_70949_Desc = {
    Text = "通关时携带至少2个造物"
  },
  Task_70949_Name = {
    Text = "奇兵秘藏"
  },
  Task_70950_Desc = {
    Text = "通关时携带至少1个黄金造物"
  },
  Task_70950_Name = {
    Text = "奇兵秘藏"
  },
  Task_70951_Desc = {
    Text = "最终战一回合打出至少5张卡牌"
  },
  Task_70951_Name = {
    Text = "我的回合"
  },
  Task_70952_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_70952_Name = {
    Text = "速战速决"
  },
  Task_70953_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_70953_Name = {
    Text = "速战速决"
  },
  Task_70954_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_70954_Name = {
    Text = "速战速决"
  },
  Task_70955_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_70955_Name = {
    Text = "速战速决"
  },
  Task_70956_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_70956_Name = {
    Text = "速战速决"
  },
  Task_70957_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_70957_Name = {
    Text = "速战速决"
  },
  Task_70958_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_70958_Name = {
    Text = "速战速决"
  },
  Task_70959_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_70959_Name = {
    Text = "速战速决"
  },
  Task_70960_Desc = {
    Text = "最终战不超过10回合取胜"
  },
  Task_70960_Name = {
    Text = "速战速决"
  },
  Task_71343_Desc = {
    Text = "通关「狂灾」癫狂难度"
  },
  Task_71344_Desc = {
    Text = "使用混沌界域唤醒体在「虚无之门」中获胜1次"
  },
  Task_71345_Desc = {
    Text = "使用混沌界域唤醒体在「虚无之门」中获胜2次"
  },
  Task_71346_Desc = {
    Text = "通关「璀璨消亡」任意难度"
  },
  Task_71347_Desc = {
    Text = "通关「狂灾」任意难度"
  },
  Task_71348_Desc = {
    Text = "通关「混沌预言」任意难度"
  },
  Task_71349_Desc = {
    Text = "虚无之门·界域"
  },
  Task_71350_Desc = {
    Text = "通关「人偶之屋」任意难度"
  },
  Task_71351_Desc = {
    Text = "通关「星星」癫狂难度"
  },
  Task_71352_Desc = {
    Text = "通关「狂灾」任意难度"
  },
  Task_71353_Desc = {
    Text = "通关「璀璨消亡」任意难度"
  },
  Task_71354_Desc = {
    Text = "通关「狂欢舞会」任意难度"
  },
  Task_71355_Desc = {
    Text = "虚无之门·癫狂"
  },
  Task_71356_Desc = {
    Text = "通关「傀儡线」任意难度"
  },
  Task_71357_Desc = {
    Text = "通关「真实毒药」任意难度"
  },
  Task_71358_Desc = {
    Text = "通关「傀儡线」癫狂难度"
  },
  Task_71359_Desc = {
    Text = "使用血肉界域唤醒体在「虚无之门」中获胜2次"
  },
  Task_71360_Desc = {
    Text = "通关「混沌预言」任意难度"
  },
  Task_71361_Desc = {
    Text = "通关「邀请」癫狂难度"
  },
  Task_71362_Desc = {
    Text = "使用超维界域唤醒体在「虚无之门」中获胜2次"
  },
  Task_71363_Desc = {
    Text = "使用超维界域唤醒体在「虚无之门」中获胜1次"
  },
  Task_71364_Desc = {
    Text = "虚无之门·通关"
  },
  Task_71365_Desc = {
    Text = "完成「虚无之门·通关」所有成就"
  },
  Task_71366_Desc = {
    Text = "通关「璀璨消亡」癫狂难度"
  },
  Task_71367_Desc = {
    Text = "通关「真实毒药」癫狂难度"
  },
  Task_71368_Desc = {
    Text = "通关「傀儡线」任意难度"
  },
  Task_71369_Desc = {
    Text = "使用血肉界域唤醒体在「虚无之门」中获胜1次"
  },
  Task_71370_Desc = {
    Text = "通关「人偶之屋」癫狂难度"
  },
  Task_71373_Desc = {
    Text = "通关「星星」任意难度"
  },
  Task_71374_Desc = {
    Text = "使用深海界域唤醒体在「虚无之门」中获胜2次"
  },
  Task_71375_Desc = {
    Text = "使用深海界域唤醒体在「虚无之门」中获胜1次"
  },
  Task_71376_Desc = {
    Text = "通关「狂欢舞会」任意难度"
  },
  Task_71377_Desc = {
    Text = "通关「人偶之屋」任意难度"
  },
  Task_71378_Desc = {
    Text = "通关「星星」任意难度"
  },
  Task_71379_Desc = {
    Text = "通关「邀请」任意难度"
  },
  Task_71380_Desc = {
    Text = "通关「混沌预言」癫狂难度"
  },
  Task_71381_Desc = {
    Text = "通关「狂欢舞会」癫狂难度"
  },
  Task_71382_Desc = {
    Text = "通关「真实毒药」任意难度"
  },
  Task_71385_Desc = {
    Text = "通关「邀请」任意难度"
  },
  Task_71757_Desc = {
    Text = "通关「假面喜剧」癫狂难度"
  },
  Task_71758_Desc = {
    Text = "通关「情节轮转」任意难度"
  },
  Task_71759_Desc = {
    Text = "通关「静场时刻」癫狂难度"
  },
  Task_71760_Desc = {
    Text = "通关「静场时刻」任意难度"
  },
  Task_71761_Desc = {
    Text = "通关「卡塔西斯」癫狂难度"
  },
  Task_71762_Desc = {
    Text = "通关「弧光理论」任意难度"
  },
  Task_71763_Desc = {
    Text = "通关「情节轮转」癫狂难度"
  },
  Task_71764_Desc = {
    Text = "通关「陌生化效果」癫狂难度"
  },
  Task_71765_Desc = {
    Text = "通关「三一律」癫狂难度"
  },
  Task_71766_Desc = {
    Text = "通关「三一律」任意难度"
  },
  Task_71767_Desc = {
    Text = "通关「卡塔西斯」任意难度"
  },
  Task_71768_Desc = {
    Text = "通关「假面喜剧」任意难度"
  },
  Task_71769_Desc = {
    Text = "通关「戏剧的第四壁」癫狂难度"
  },
  Task_71770_Desc = {
    Text = "通关「戏剧的第四壁」任意难度"
  },
  Task_71771_Desc = {
    Text = "通关「陌生化效果」任意难度"
  },
  Task_71772_Desc = {
    Text = "通关「弧光理论」癫狂难度"
  },
  Task_71773_Desc = {
    Text = "通关「剧作金字塔」癫狂难度"
  },
  Task_71774_Desc = {
    Text = "通关「剧作金字塔」任意难度"
  },
  Task_71775_Desc = {
    Text = "剧本迷思·癫狂"
  },
  Task_71795_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_71795_Name = {Text = "2800分"},
  Task_71796_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_71796_Name = {Text = "2700分"},
  Task_71797_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_71797_Name = {Text = "2900分"},
  Task_71798_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_71798_Name = {Text = "2600分"},
  Task_71799_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_71799_Name = {Text = "2300分"},
  Task_71800_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_71800_Name = {Text = "2400分"},
  Task_71801_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_71801_Name = {Text = "2500分"},
  Task_71802_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_71802_Name = {Text = "1900分"},
  Task_71803_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_71803_Name = {Text = "2000分"},
  Task_71804_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_71804_Name = {Text = "2100分"},
  Task_71805_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_71805_Name = {Text = "2200分"},
  Task_71806_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_71806_Name = {Text = "3000分"},
  Task_71807_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_71807_Name = {Text = "1600分"},
  Task_71808_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_71808_Name = {Text = "1700分"},
  Task_71809_Desc = {
    Text = "对弈积分最高达到"
  },
  Task_71809_Name = {Text = "1800分"},
  Task_71819_Desc = {
    Text = "通关「终曲」任意难度"
  },
  Task_71820_Desc = {
    Text = "通关「脸」任意难度"
  },
  Task_71821_Desc = {
    Text = "通关「长腿叔叔」任意难度"
  },
  Task_71822_Desc = {
    Text = "通关「目光」任意难度"
  },
  Task_71823_Desc = {
    Text = "通关「傀儡游戏」任意难度"
  },
  Task_71824_Desc = {
    Text = "通关「未完的剧本」任意难度"
  },
  Task_71825_Desc = {
    Text = "通关「蔷薇角」任意难度"
  },
  Task_71826_Desc = {
    Text = "通关「釜底游鱼」任意难度"
  },
  Task_71827_Desc = {
    Text = "通关「礼物」任意难度"
  },
  Task_71867_Desc = {
    Text = "拥有 5/6/7/8 个造物，获得 250/500/750/1000 分。"
  },
  Task_71867_Name = {
    Text = "实相搜罗<size=20><color=#747474>拥有 8 个造物</color></size>"
  },
  Task_71868_Desc = {
    Text = "每使用 1 次肌肉记忆，调查评分降低 20% 。"
  },
  Task_71868_Name = {
    Text = "梦游行者<size=20><color=#747474>每使用 1 次肌肉记忆，调查评分降低 20% </color></size>"
  },
  Task_71887_Name = {Text = "100"},
  Task_71888_Name = {Text = "98"},
  Task_71889_Name = {Text = "99"},
  Task_71890_Name = {Text = "94"},
  Task_71891_Name = {Text = "95"},
  Task_71892_Name = {Text = "96"},
  Task_71893_Name = {Text = "97"},
  Task_71894_Name = {Text = "91"},
  Task_71895_Name = {Text = "92"},
  Task_71896_Name = {Text = "93"},
  Task_71934_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71935_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71936_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71937_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71939_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71940_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71941_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71942_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71943_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71944_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71945_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71946_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71947_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71948_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71949_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71950_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71952_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71953_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71954_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71955_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71977_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71978_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71980_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_71981_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_72038_Name = {
    Text = "重新通关图鲁支线关卡普通4"
  },
  Task_72039_Desc = {
    Text = "通关「目光」癫狂难度"
  },
  Task_72040_Desc = {
    Text = "通关「釜底游鱼」癫狂难度"
  },
  Task_72041_Desc = {
    Text = "通关「傀儡游戏」癫狂难度"
  },
  Task_72042_Desc = {
    Text = "通关「礼物」癫狂难度"
  },
  Task_72043_Desc = {
    Text = "通关特遣纪录「蔷薇忆事」"
  },
  Task_72044_Desc = {
    Text = "通关「长腿叔叔」癫狂难度"
  },
  Task_72045_Desc = {
    Text = "通关「未完的剧本」癫狂难度"
  },
  Task_72046_Desc = {
    Text = "通关「蔷薇角」癫狂难度"
  },
  Task_72047_Desc = {
    Text = "通关「脸」癫狂难度"
  },
  Task_72048_Desc = {
    Text = "通关「终曲」癫狂难度"
  },
  Task_72049_Desc = {
    Text = "蔷薇忆事·癫狂"
  },
  Task_72245_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72245_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72386_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72386_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72387_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72387_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72389_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72389_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72390_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72390_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72391_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72391_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72392_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72392_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72393_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72393_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72394_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72394_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72395_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72395_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72396_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72396_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72416_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72416_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72420_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72420_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72540_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72540_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72541_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72541_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72542_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72542_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72545_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72545_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72546_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72546_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72547_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72547_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72548_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72548_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72549_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72549_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72632_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72632_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72652_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72652_UnlockCondDesc = {
    Text = "完成「逆转回合：来自异界的客人」后解锁，是否前往「逆转回合」？"
  },
  Task_72677_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72677_UnlockCondDesc = {
    Text = "完成「逆转回合：来自异界的客人」后解锁，是否前往「逆转回合」？"
  },
  Task_72678_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72678_UnlockCondDesc = {
    Text = "完成「逆转回合：来自异界的客人」后解锁，是否前往「逆转回合」？"
  },
  Task_72679_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72679_UnlockCondDesc = {
    Text = "完成「逆转回合：来自异界的客人」后解锁，是否前往「逆转回合」？"
  },
  Task_72681_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72681_UnlockCondDesc = {
    Text = "完成「逆转回合：来自异界的客人」后解锁，是否前往「逆转回合」？"
  },
  Task_72682_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72682_UnlockCondDesc = {
    Text = "完成「逆转回合：来自异界的客人」后解锁，是否前往「逆转回合」？"
  },
  Task_72683_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72683_UnlockCondDesc = {
    Text = "完成「逆转回合：来自异界的客人」后解锁，是否前往「逆转回合」？"
  },
  Task_72684_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72684_UnlockCondDesc = {
    Text = "完成「逆转回合：来自异界的客人」后解锁，是否前往「逆转回合」？"
  },
  Task_72685_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72685_UnlockCondDesc = {
    Text = "完成「逆转回合：来自异界的客人」后解锁，是否前往「逆转回合」？"
  },
  Task_72700_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72700_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72701_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72701_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72703_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72703_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72704_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72704_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72705_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72705_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72706_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72706_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72707_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72707_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72709_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72709_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72773_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72773_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72790_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72790_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72798_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72798_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72799_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72799_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72800_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72800_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72801_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72801_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72802_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72802_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72803_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72803_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72805_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72805_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72806_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72806_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72807_Desc = {
    Text = "魔法橡果达到"
  },
  Task_72807_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_72957_Desc = {
    Text = "使用「跨越疼痛」获得3次胜利"
  },
  Task_72958_Desc = {
    Text = "使用「畸体回噬」获得1次胜利"
  },
  Task_72959_Desc = {
    Text = "使用「核心熔解」获得3次胜利"
  },
  Task_72961_Desc = {
    Text = "使用「35mm的魔法」获得1次胜利"
  },
  Task_72963_Desc = {
    Text = "使用「女王的戒律」获得3次胜利"
  },
  Task_72965_Desc = {
    Text = "使用「百万蒙宠之眼」获得1次胜利"
  },
  Task_72968_Desc = {
    Text = "使用「涌现」获得1次胜利"
  },
  Task_72973_Desc = {
    Text = "使用「莉莉」获得1次胜利"
  },
  Task_72975_Desc = {
    Text = "使用「咆哮的血与沙」获得3次胜利"
  },
  Task_72976_Desc = {
    Text = "使用「至为珍贵的藏品」获得3次胜利"
  },
  Task_72977_Desc = {
    Text = "使用「隐世的转轮」获得3次胜利"
  },
  Task_72978_Desc = {
    Text = "使用「信息就是生命」获得3次胜利"
  },
  Task_72980_Desc = {
    Text = "使用「莉兹」获得1次胜利"
  },
  Task_72982_Desc = {
    Text = "使用「超越死亡」获得3次胜利"
  },
  Task_72983_Desc = {
    Text = "使用「湖畔回眸」获得1次胜利"
  },
  Task_72986_Desc = {
    Text = "使用「巨人之刃」获得1次胜利"
  },
  Task_72989_Desc = {
    Text = "使用「奥吉尔」获得3次胜利"
  },
  Task_72990_Desc = {
    Text = "使用「吞噬摇篮曲」获得1次胜利"
  },
  Task_72992_Desc = {
    Text = "使用「临界点」获得1次胜利"
  },
  Task_72993_Desc = {
    Text = "使用「致挚友」获得1次胜利"
  },
  Task_72994_Desc = {
    Text = "使用「短暂的永恒」获得1次胜利"
  },
  Task_72995_Desc = {
    Text = "使用「珊瑚女之死」获得1次胜利"
  },
  Task_72997_Desc = {
    Text = "使用「奥瑞塔」获得3次胜利"
  },
  Task_72999_Desc = {
    Text = "使用「玫瑰的胜利」获得3次胜利"
  },
  Task_73001_Desc = {
    Text = "使用「宠爱」获得1次胜利"
  },
  Task_73003_Desc = {
    Text = "使用「伊萨拉乌的目光」获得3次胜利"
  },
  Task_73004_Desc = {
    Text = "使用「勋爵手杖」获得1次胜利"
  },
  Task_73006_Desc = {
    Text = "使用「好运时间」获得3次胜利"
  },
  Task_73007_Desc = {
    Text = "使用「阿格里帕」获得3次胜利"
  },
  Task_73009_Desc = {
    Text = "使用「待到雪山消融」获得1次胜利"
  },
  Task_73011_Desc = {
    Text = "使用「心之壁垒」获得1次胜利"
  },
  Task_73012_Desc = {
    Text = "使用「弥利亚姆」获得3次胜利"
  },
  Task_73014_Desc = {
    Text = "使用「哈姆林」获得1次胜利"
  },
  Task_73015_Desc = {
    Text = "使用「海之梦」获得3次胜利"
  },
  Task_73016_Desc = {
    Text = "使用「谵妄」获得1次胜利"
  },
  Task_73018_Desc = {
    Text = "使用「快乐魔法秀」获得1次胜利"
  },
  Task_73019_Desc = {
    Text = "使用「熟成」获得1次胜利"
  },
  Task_73021_Desc = {
    Text = "使用「纯银的初心」获得1次胜利"
  },
  Task_73022_Desc = {
    Text = "使用「朵尔」获得1次胜利"
  },
  Task_73025_Desc = {
    Text = "使用「呢喃」获得1次胜利"
  },
  Task_73026_Desc = {
    Text = "使用「活性」获得1次胜利"
  },
  Task_73028_Desc = {
    Text = "使用「达芙黛尔」获得1次胜利"
  },
  Task_73030_Desc = {
    Text = "使用「温柯尔」获得3次胜利"
  },
  Task_73033_Desc = {
    Text = "使用「沉入殷红」获得1次胜利"
  },
  Task_73037_Desc = {
    Text = "使用「挣脱锁链之日」获得3次胜利"
  },
  Task_73039_Desc = {
    Text = "使用「冬夜追忆」获得1次胜利"
  },
  Task_73041_Desc = {
    Text = "使用「隐秘的诞生」获得1次胜利"
  },
  Task_73044_Desc = {
    Text = "使用「莱克」获得3次胜利"
  },
  Task_73045_Desc = {
    Text = "使用「熔毁·朵尔」获得1次胜利"
  },
  Task_73047_Desc = {
    Text = "使用「菲茵特」获得1次胜利"
  },
  Task_73048_Desc = {
    Text = "使用「泰旖丝」获得3次胜利"
  },
  Task_73050_Desc = {
    Text = "使用「艾继丝」获得3次胜利"
  },
  Task_73051_Desc = {
    Text = "使用「奥瑞塔」获得1次胜利"
  },
  Task_73052_Desc = {
    Text = "使用「珊」获得1次胜利"
  },
  Task_73053_Desc = {
    Text = "使用「墨菲」获得1次胜利"
  },
  Task_73054_Desc = {
    Text = "使用「塔薇」获得3次胜利"
  },
  Task_73055_Desc = {
    Text = "使用「朵尔」获得3次胜利"
  },
  Task_73056_Desc = {
    Text = "使用「萨尔瓦多」获得1次胜利"
  },
  Task_73057_Desc = {
    Text = "使用「唯一的种子」获得3次胜利"
  },
  Task_73059_Desc = {
    Text = "使用「银鳕鱼的决心」获得3次胜利"
  },
  Task_73061_Desc = {
    Text = "使用「切割与伤害」获得3次胜利"
  },
  Task_73063_Desc = {
    Text = "使用「慈悲的哺育」获得1次胜利"
  },
  Task_73064_Desc = {
    Text = "使用「惩戒」获得3次胜利"
  },
  Task_73066_Desc = {
    Text = "使用「命运轮盘赌」获得3次胜利"
  },
  Task_73067_Desc = {
    Text = "使用「潘狄娅」获得1次胜利"
  },
  Task_73068_Desc = {
    Text = "使用「全部的她」获得1次胜利"
  },
  Task_73070_Desc = {
    Text = "使用「巨人的霸道」获得3次胜利"
  },
  Task_73073_Desc = {
    Text = "使用「拉蒙娜」获得3次胜利"
  },
  Task_73074_Desc = {
    Text = "使用「诗笺的句尾」获得1次胜利"
  },
  Task_73075_Desc = {
    Text = "使用「苍白后裔」获得3次胜利"
  },
  Task_73077_Desc = {
    Text = "使用「旺达」获得1次胜利"
  },
  Task_73081_Desc = {
    Text = "使用「虔诚的伟力」获得1次胜利"
  },
  Task_73082_Desc = {
    Text = "使用「记忆螺旋」获得1次胜利"
  },
  Task_73083_Desc = {
    Text = "使用「溯洄时计」获得3次胜利"
  },
  Task_73085_Desc = {
    Text = "使用「奥尔拉」获得1次胜利"
  },
  Task_73086_Desc = {
    Text = "使用「聚首时刻」获得1次胜利"
  },
  Task_73087_Desc = {
    Text = "使用「无声欢宴」获得3次胜利"
  },
  Task_73088_Desc = {
    Text = "使用「于暴雨之中」获得1次胜利"
  },
  Task_73089_Desc = {
    Text = "使用「萝坦」获得1次胜利"
  },
  Task_73090_Desc = {
    Text = "使用「血肉狂宴」获得1次胜利"
  },
  Task_73095_Desc = {
    Text = "使用「珈伦」获得1次胜利"
  },
  Task_73097_Desc = {
    Text = "使用「欲海浮沉」获得1次胜利"
  },
  Task_73098_Desc = {
    Text = "使用「卡茜亚」获得1次胜利"
  },
  Task_73099_Desc = {
    Text = "使用「仲夏之梦」获得1次胜利"
  },
  Task_73100_Desc = {
    Text = "使用「索蕾尔」获得3次胜利"
  },
  Task_73102_Desc = {
    Text = "使用「神王的颂歌」获得1次胜利"
  },
  Task_73105_Desc = {
    Text = "使用「不平等交换」获得3次胜利"
  },
  Task_73107_Desc = {
    Text = "使用「骑士之心」获得1次胜利"
  },
  Task_73109_Desc = {
    Text = "使用「苦咒缚」获得3次胜利"
  },
  Task_73110_Desc = {
    Text = "使用「萨尔瓦多」获得3次胜利"
  },
  Task_73111_Desc = {
    Text = "使用「星天之兽」获得3次胜利"
  },
  Task_73117_Desc = {
    Text = "使用「蚀骨的拥抱」获得1次胜利"
  },
  Task_73118_Desc = {
    Text = "使用「奥瑞塔的宝藏」获得1次胜利"
  },
  Task_73120_Desc = {
    Text = "使用「饕餮寓言」获得1次胜利"
  },
  Task_73122_Desc = {
    Text = "使用「环行·拉蒙娜」获得3次胜利"
  },
  Task_73123_Desc = {
    Text = "使用「最后的誓言」获得1次胜利"
  },
  Task_73124_Desc = {
    Text = "使用「放逐」获得3次胜利"
  },
  Task_73126_Desc = {
    Text = "使用「眷顾」获得1次胜利"
  },
  Task_73128_Desc = {
    Text = "使用「贪婪」获得3次胜利"
  },
  Task_73129_Desc = {
    Text = "使用「凯刻斯」获得1次胜利"
  },
  Task_73130_Desc = {
    Text = "使用「真理之门」获得3次胜利"
  },
  Task_73131_Desc = {
    Text = "使用「以蔷薇之名」获得1次胜利"
  },
  Task_73134_Desc = {
    Text = "使用「艾瑞卡」获得3次胜利"
  },
  Task_73136_Desc = {
    Text = "使用「死亡的剖析」获得3次胜利"
  },
  Task_73138_Desc = {
    Text = "使用「汀克特」获得3次胜利"
  },
  Task_73139_Desc = {
    Text = "使用「短暂的永恒」获得3次胜利"
  },
  Task_73140_Desc = {
    Text = "使用「职责所在」获得3次胜利"
  },
  Task_73141_Desc = {
    Text = "使用「明悟」获得1次胜利"
  },
  Task_73144_Desc = {
    Text = "使用「巨人之刃」获得3次胜利"
  },
  Task_73147_Desc = {
    Text = "使用「永不停歇的演奏」获得3次胜利"
  },
  Task_73148_Desc = {
    Text = "使用「冰川下的沉眠」获得3次胜利"
  },
  Task_73150_Desc = {
    Text = "使用「莉莉」获得3次胜利"
  },
  Task_73151_Desc = {
    Text = "使用「玫瑰的胜利」获得1次胜利"
  },
  Task_73152_Desc = {
    Text = "使用「灰雾真容」获得3次胜利"
  },
  Task_73153_Desc = {
    Text = "使用「图鲁」获得1次胜利"
  },
  Task_73154_Desc = {
    Text = "使用「希冀」获得1次胜利"
  },
  Task_73156_Desc = {
    Text = "使用「雷娅」获得3次胜利"
  },
  Task_73157_Desc = {
    Text = "使用「宠爱」获得3次胜利"
  },
  Task_73161_Desc = {
    Text = "使用「宁菲亚」获得3次胜利"
  },
  Task_73162_Desc = {
    Text = "使用「狂乱」获得3次胜利"
  },
  Task_73165_Desc = {
    Text = "使用「不存在之地」获得1次胜利"
  },
  Task_73166_Desc = {
    Text = "使用「法洛思」获得3次胜利"
  },
  Task_73167_Desc = {
    Text = "使用「希洛」获得1次胜利"
  },
  Task_73170_Desc = {
    Text = "使用「图鲁」获得3次胜利"
  },
  Task_73172_Desc = {
    Text = "使用「吮吸」获得3次胜利"
  },
  Task_73173_Desc = {
    Text = "使用「引舵之帆」获得1次胜利"
  },
  Task_73174_Desc = {
    Text = "使用「聚首时刻」获得3次胜利"
  },
  Task_73176_Desc = {
    Text = "使用「希莱斯特」获得1次胜利"
  },
  Task_73177_Desc = {
    Text = "使用「珊」获得3次胜利"
  },
  Task_73178_Desc = {
    Text = "使用「洞悉」获得1次胜利"
  },
  Task_73180_Desc = {
    Text = "使用「永恒安魂曲」获得3次胜利"
  },
  Task_73181_Desc = {
    Text = "使用「无法完成的演算」获得3次胜利"
  },
  Task_73182_Desc = {
    Text = "使用「阿格里帕」获得1次胜利"
  },
  Task_73183_Desc = {
    Text = "使用「被缚的歌谣」获得3次胜利"
  },
  Task_73185_Desc = {
    Text = "使用「极夜与破晓」获得3次胜利"
  },
  Task_73186_Desc = {
    Text = "使用「专注精神」获得1次胜利"
  },
  Task_73189_Desc = {
    Text = "使用「坠入虚无的人偶」获得3次胜利"
  },
  Task_73192_Desc = {
    Text = "使用「伏于夜色」获得1次胜利"
  },
  Task_73193_Desc = {
    Text = "使用「记忆症候」获得1次胜利"
  },
  Task_73197_Desc = {
    Text = "使用「遗忘之手」获得3次胜利"
  },
  Task_73200_Desc = {
    Text = "使用「冒险的行囊」获得1次胜利"
  },
  Task_73204_Desc = {
    Text = "使用「血链·希洛」获得3次胜利"
  },
  Task_73206_Desc = {
    Text = "使用「吞噬摇篮曲」获得3次胜利"
  },
  Task_73208_Desc = {
    Text = "使用「熔毁·朵尔」获得3次胜利"
  },
  Task_73209_Desc = {
    Text = "使用「珊瑚女之死」获得3次胜利"
  },
  Task_73210_Desc = {
    Text = "使用「奥吉尔」获得1次胜利"
  },
  Task_73212_Desc = {
    Text = "使用「慈悲的哺育」获得3次胜利"
  },
  Task_73213_Desc = {
    Text = "使用「临界点」获得3次胜利"
  },
  Task_73214_Desc = {
    Text = "使用「致挚友」获得3次胜利"
  },
  Task_73216_Desc = {
    Text = "使用「沉入殷红」获得3次胜利"
  },
  Task_73217_Desc = {
    Text = "使用「切割与伤害」获得1次胜利"
  },
  Task_73218_Desc = {
    Text = "使用「灰雾真容」获得1次胜利"
  },
  Task_73219_Desc = {
    Text = "使用「脑中之音」获得3次胜利"
  },
  Task_73220_Desc = {
    Text = "使用「勋爵手杖」获得3次胜利"
  },
  Task_73222_Desc = {
    Text = "使用「遗忘之手」获得1次胜利"
  },
  Task_73223_Desc = {
    Text = "使用「詹金」获得3次胜利"
  },
  Task_73224_Desc = {
    Text = "使用「弥利亚姆」获得1次胜利"
  },
  Task_73225_Desc = {
    Text = "使用「好运时间」获得1次胜利"
  },
  Task_73227_Desc = {
    Text = "使用「迷失的道路」获得1次胜利"
  },
  Task_73228_Desc = {
    Text = "使用「艾尔瓦」获得1次胜利"
  },
  Task_73229_Desc = {
    Text = "使用「神言石板」获得1次胜利"
  },
  Task_73232_Desc = {
    Text = "使用「涌现」获得3次胜利"
  },
  Task_73233_Desc = {
    Text = "使用「尤乌哈希」获得3次胜利"
  },
  Task_73235_Desc = {
    Text = "使用「35mm的魔法」获得3次胜利"
  },
  Task_73236_Desc = {
    Text = "使用「腐朽赠礼」获得1次胜利"
  },
  Task_73237_Desc = {
    Text = "使用「贪婪」获得1次胜利"
  },
  Task_73241_Desc = {
    Text = "使用「不存在之地」获得3次胜利"
  },
  Task_73243_Desc = {
    Text = "使用「莉兹」获得3次胜利"
  },
  Task_73246_Desc = {
    Text = "使用「隐世的转轮」获得1次胜利"
  },
  Task_73249_Desc = {
    Text = "使用「脑中之音」获得1次胜利"
  },
  Task_73250_Desc = {
    Text = "使用「24」获得1次胜利"
  },
  Task_73253_Desc = {
    Text = "使用「坚韧意志」获得3次胜利"
  },
  Task_73254_Desc = {
    Text = "使用「畸体回噬」获得3次胜利"
  },
  Task_73257_Desc = {
    Text = "使用「泰旖丝」获得1次胜利"
  },
  Task_73259_Desc = {
    Text = "使用「菲茵特」获得3次胜利"
  },
  Task_73260_Desc = {
    Text = "使用「塔薇」获得1次胜利"
  },
  Task_73262_Desc = {
    Text = "使用「艾继丝」获得1次胜利"
  },
  Task_73266_Desc = {
    Text = "使用「银鳕鱼的决心」获得1次胜利"
  },
  Task_73267_Desc = {
    Text = "使用「萝坦」获得3次胜利"
  },
  Task_73268_Desc = {
    Text = "使用「唯一的种子」获得1次胜利"
  },
  Task_73269_Desc = {
    Text = "使用「惩戒」获得1次胜利"
  },
  Task_73270_Desc = {
    Text = "使用「伤痛之鳍」获得1次胜利"
  },
  Task_73271_Desc = {
    Text = "使用「仲夏之梦」获得3次胜利"
  },
  Task_73278_Desc = {
    Text = "使用「巨人的霸道」获得1次胜利"
  },
  Task_73279_Desc = {
    Text = "使用「艾瑞卡」获得1次胜利"
  },
  Task_73280_Desc = {
    Text = "使用「放逐」获得1次胜利"
  },
  Task_73281_Desc = {
    Text = "使用「海之梦」获得1次胜利"
  },
  Task_73282_Desc = {
    Text = "使用「待到雪山消融」获得3次胜利"
  },
  Task_73284_Desc = {
    Text = "使用「命运轮盘赌」获得1次胜利"
  },
  Task_73285_Desc = {
    Text = "使用「真理之门」获得1次胜利"
  },
  Task_73286_Desc = {
    Text = "使用「拉蒙娜」获得1次胜利"
  },
  Task_73287_Desc = {
    Text = "使用「潘狄娅」获得3次胜利"
  },
  Task_73288_Desc = {
    Text = "使用「以蔷薇之名」获得3次胜利"
  },
  Task_73289_Desc = {
    Text = "使用「全部的她」获得3次胜利"
  },
  Task_73290_Desc = {
    Text = "使用「旺达」获得3次胜利"
  },
  Task_73292_Desc = {
    Text = "使用「诗笺的句尾」获得3次胜利"
  },
  Task_73293_Desc = {
    Text = "使用「苍白后裔」获得1次胜利"
  },
  Task_73294_Desc = {
    Text = "使用「汀克特」获得1次胜利"
  },
  Task_73296_Desc = {
    Text = "使用「核心熔解」获得1次胜利"
  },
  Task_73297_Desc = {
    Text = "使用「神迹降临」获得1次胜利"
  },
  Task_73298_Desc = {
    Text = "使用「咆哮的血与沙」获得1次胜利"
  },
  Task_73299_Desc = {
    Text = "使用「詹金」获得1次胜利"
  },
  Task_73302_Desc = {
    Text = "使用「呢喃」获得3次胜利"
  },
  Task_73303_Desc = {
    Text = "使用「女王的戒律」获得1次胜利"
  },
  Task_73305_Desc = {
    Text = "使用「熟成」获得3次胜利"
  },
  Task_73306_Desc = {
    Text = "使用「跨越疼痛」获得1次胜利"
  },
  Task_73309_Desc = {
    Text = "使用「无声欢宴」获得1次胜利"
  },
  Task_73311_Desc = {
    Text = "使用「迷失的道路」获得3次胜利"
  },
  Task_73312_Desc = {
    Text = "使用「戈利亚」获得3次胜利"
  },
  Task_73313_Desc = {
    Text = "使用「饕餮寓言」获得3次胜利"
  },
  Task_73314_Desc = {
    Text = "使用「温柯尔」获得1次胜利"
  },
  Task_73315_Desc = {
    Text = "使用「百万蒙宠之眼」获得3次胜利"
  },
  Task_73316_Desc = {
    Text = "使用「达芙黛尔」获得3次胜利"
  },
  Task_73317_Desc = {
    Text = "使用「信息就是生命」获得1次胜利"
  },
  Task_73318_Desc = {
    Text = "使用「莱克」获得1次胜利"
  },
  Task_73321_Desc = {
    Text = "使用「奥尔拉」获得3次胜利"
  },
  Task_73322_Desc = {
    Text = "使用「至为珍贵的藏品」获得1次胜利"
  },
  Task_73323_Desc = {
    Text = "使用「诺缔拉」获得3次胜利"
  },
  Task_73324_Desc = {
    Text = "使用「湖畔回眸」获得3次胜利"
  },
  Task_73325_Desc = {
    Text = "使用「超越死亡」获得1次胜利"
  },
  Task_73326_Desc = {
    Text = "使用「冬夜追忆」获得3次胜利"
  },
  Task_73327_Desc = {
    Text = "使用「冒险的行囊」获得3次胜利"
  },
  Task_73328_Desc = {
    Text = "使用「戈利亚」获得1次胜利"
  },
  Task_73330_Desc = {
    Text = "使用「苦咒缚」获得1次胜利"
  },
  Task_73333_Desc = {
    Text = "使用「无法完成的演算」获得1次胜利"
  },
  Task_73334_Desc = {
    Text = "使用「星天之兽」获得1次胜利"
  },
  Task_73335_Desc = {
    Text = "使用「神迹降临」获得3次胜利"
  },
  Task_73338_Desc = {
    Text = "使用「坠入虚无的人偶」获得1次胜利"
  },
  Task_73341_Desc = {
    Text = "使用「墨菲」获得3次胜利"
  },
  Task_73343_Desc = {
    Text = "使用「极夜与破晓」获得1次胜利"
  },
  Task_73345_Desc = {
    Text = "使用「伊萨拉乌的目光」获得1次胜利"
  },
  Task_73346_Desc = {
    Text = "使用「专注精神」获得3次胜利"
  },
  Task_73349_Desc = {
    Text = "使用「蚀骨的拥抱」获得3次胜利"
  },
  Task_73352_Desc = {
    Text = "使用「伏于夜色」获得3次胜利"
  },
  Task_73353_Desc = {
    Text = "使用「眷顾」获得3次胜利"
  },
  Task_73354_Desc = {
    Text = "使用「诺缔拉」获得1次胜利"
  },
  Task_73355_Desc = {
    Text = "使用「环行·拉蒙娜」获得1次胜利"
  },
  Task_73356_Desc = {
    Text = "使用「奥瑞塔的宝藏」获得3次胜利"
  },
  Task_73357_Desc = {
    Text = "使用「最后的誓言」获得3次胜利"
  },
  Task_73359_Desc = {
    Text = "使用「凯刻斯」获得3次胜利"
  },
  Task_73360_Desc = {
    Text = "使用「死亡的剖析」获得1次胜利"
  },
  Task_73362_Desc = {
    Text = "使用「快乐魔法秀」获得3次胜利"
  },
  Task_73363_Desc = {
    Text = "使用「宁菲亚」获得1次胜利"
  },
  Task_73366_Desc = {
    Text = "使用「溯洄时计」获得1次胜利"
  },
  Task_73369_Desc = {
    Text = "使用「谵妄」获得3次胜利"
  },
  Task_73370_Desc = {
    Text = "使用「哈姆林」获得3次胜利"
  },
  Task_73372_Desc = {
    Text = "使用「纯银的初心」获得3次胜利"
  },
  Task_73374_Desc = {
    Text = "使用「珈伦」获得3次胜利"
  },
  Task_73377_Desc = {
    Text = "使用「不平等交换」获得1次胜利"
  },
  Task_73379_Desc = {
    Text = "使用「索蕾尔」获得1次胜利"
  },
  Task_73380_Desc = {
    Text = "使用「卡茜亚」获得3次胜利"
  },
  Task_73382_Desc = {
    Text = "使用「挣脱锁链之日」获得1次胜利"
  },
  Task_73387_Desc = {
    Text = "使用「隐秘的诞生」获得3次胜利"
  },
  Task_73388_Desc = {
    Text = "使用「心之壁垒」获得3次胜利"
  },
  Task_73390_Desc = {
    Text = "使用「伤痛之鳍」获得3次胜利"
  },
  Task_73392_Desc = {
    Text = "使用「尤乌哈希」获得1次胜利"
  },
  Task_73394_Desc = {
    Text = "使用「虔诚的伟力」获得3次胜利"
  },
  Task_73395_Desc = {
    Text = "使用「血链·希洛」获得1次胜利"
  },
  Task_73396_Desc = {
    Text = "使用「神言石板」获得3次胜利"
  },
  Task_73400_Desc = {
    Text = "使用「永恒安魂曲」获得1次胜利"
  },
  Task_73404_Desc = {
    Text = "使用「镜中人」获得1次胜利"
  },
  Task_73405_Desc = {
    Text = "使用「于暴雨之中」获得3次胜利"
  },
  Task_73407_Desc = {
    Text = "使用「腐朽赠礼」获得3次胜利"
  },
  Task_73409_Desc = {
    Text = "使用「希莱斯特」获得3次胜利"
  },
  Task_73410_Desc = {
    Text = "使用「洞悉」获得3次胜利"
  },
  Task_73413_Desc = {
    Text = "使用「被缚的歌谣」获得1次胜利"
  },
  Task_73417_Desc = {
    Text = "使用「记忆症候」获得3次胜利"
  },
  Task_73418_Desc = {
    Text = "使用「镜中人」获得3次胜利"
  },
  Task_73422_Desc = {
    Text = "使用「24」获得3次胜利"
  },
  Task_73425_Desc = {
    Text = "使用「坚韧意志」获得1次胜利"
  },
  Task_73426_Desc = {
    Text = "使用「艾尔瓦」获得3次胜利"
  },
  Task_73427_Desc = {
    Text = "使用「狂乱」获得1次胜利"
  },
  Task_73430_Desc = {
    Text = "使用「活性」获得3次胜利"
  },
  Task_73431_Desc = {
    Text = "使用「永不停歇的演奏」获得1次胜利"
  },
  Task_73432_Desc = {
    Text = "使用「职责所在」获得1次胜利"
  },
  Task_73433_Desc = {
    Text = "使用「明悟」获得3次胜利"
  },
  Task_73435_Desc = {
    Text = "使用「记忆螺旋」获得3次胜利"
  },
  Task_73437_Desc = {
    Text = "使用「希冀」获得3次胜利"
  },
  Task_73440_Desc = {
    Text = "使用「冰川下的沉眠」获得1次胜利"
  },
  Task_73442_Desc = {
    Text = "使用「血肉狂宴」获得3次胜利"
  },
  Task_73444_Desc = {
    Text = "使用「欲海浮沉」获得3次胜利"
  },
  Task_73445_Desc = {
    Text = "使用「雷娅」获得1次胜利"
  },
  Task_73451_Desc = {
    Text = "使用「希洛」获得3次胜利"
  },
  Task_73453_Desc = {
    Text = "使用「引舵之帆」获得3次胜利"
  },
  Task_73456_Desc = {
    Text = "使用「法洛思」获得1次胜利"
  },
  Task_73457_Desc = {
    Text = "使用「骑士之心」获得3次胜利"
  },
  Task_73459_Desc = {
    Text = "使用「神王的颂歌」获得3次胜利"
  },
  Task_73462_Desc = {
    Text = "使用「吮吸」获得1次胜利"
  },
  Task_73584_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_73584_Name = {Text = "10胜"},
  Task_73585_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_73585_Name = {Text = "1胜"},
  Task_73586_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_73586_Name = {Text = "6胜"},
  Task_73587_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_73587_Name = {Text = "3胜"},
  Task_73588_Desc = {
    Text = "魔法橡果达到"
  },
  Task_73588_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_73589_Desc = {
    Text = "魔法橡果达到"
  },
  Task_73589_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_73590_Desc = {
    Text = "魔法橡果达到"
  },
  Task_73590_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_73591_Desc = {
    Text = "魔法橡果达到"
  },
  Task_73591_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_73592_Desc = {
    Text = "魔法橡果达到"
  },
  Task_73592_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_73593_Desc = {
    Text = "魔法橡果达到"
  },
  Task_73593_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_73594_Desc = {
    Text = "魔法橡果达到"
  },
  Task_73594_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_73595_Desc = {
    Text = "魔法橡果达到"
  },
  Task_73595_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_73596_Desc = {
    Text = "魔法橡果达到"
  },
  Task_73596_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_73597_Desc = {
    Text = "魔法橡果达到"
  },
  Task_73597_UnlockCondDesc = {
    Text = "完成「逆转回合：逆转万象的瞬间」后解锁，是否前往「逆转回合」？"
  },
  Task_73672_Desc = {
    Text = "获得本源朵尔时启灵2"
  },
  Task_73672_Name = {
    Text = "获得本源朵尔时启灵2"
  },
  Task_73672_UnlockCondDesc = {
    Text = "活动@唤醒体本源朵尔启灵礼包1活动"
  },
  Task_73673_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_73674_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_73676_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_73677_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_73679_Desc = {
    Text = "获得本源朵尔时启灵6"
  },
  Task_73679_Name = {
    Text = "获得本源朵尔时启灵6"
  },
  Task_73679_UnlockCondDesc = {
    Text = "活动@唤醒体本源朵尔启灵礼包2活动"
  },
  Task_73686_Desc = {
    Text = "熔毁·朵尔同调率达到 10 级"
  },
  Task_73880_Desc = {
    Text = "跟随熔毁·朵尔确认“答案”"
  },
  Task_73880_Name = {Text = "目标"},
  Task_73881_Desc = {
    Text = "压制陷入异化的莎拉"
  },
  Task_73881_Name = {Text = "目标"},
  Task_73882_Desc = {
    Text = "击溃B-68号熔毁·朵尔"
  },
  Task_73882_Name = {Text = "目标"},
  Task_73883_Desc = {
    Text = "探索眼前的维度世界"
  },
  Task_73883_Name = {Text = "目标"},
  Task_73884_Desc = {
    Text = "让詹金安静下来"
  },
  Task_73884_Name = {Text = "目标"},
  Task_73885_Desc = {
    Text = "束缚熔毁·朵尔"
  },
  Task_73885_Name = {Text = "目标"},
  Task_73886_Desc = {
    Text = "守卫钟楼"
  },
  Task_73886_Name = {Text = "目标"},
  Task_73887_Desc = {
    Text = "清理济贫院走廊中的异变体"
  },
  Task_73887_Name = {Text = "目标"},
  Task_73888_Desc = {
    Text = "自于丽埃特手中救回萨尔瓦多"
  },
  Task_73888_Name = {Text = "目标"},
  Task_73889_Desc = {
    Text = "开辟前往济世大圣堂的道路"
  },
  Task_73889_Name = {Text = "目标"},
  Task_74202_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_74203_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_74204_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_74205_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_74206_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_74207_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_74208_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_74210_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_74211_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_74212_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_74222_Desc = {
    Text = "完成意识潜游「加冕之日」"
  },
  Task_74222_Name = {
    Text = "王权永恒"
  },
  Task_74223_Desc = {
    Text = "完成调查事件「重临雾都」困难难度"
  },
  Task_74223_Name = {
    Text = "勿要迷失于灰夜·困难"
  },
  Task_74224_Desc = {
    Text = "在调查事件「@1@2」中共鸣10次"
  },
  Task_74224_Desc2 = {
    Text = "在调查事件「重临雾都」中共鸣10次"
  },
  Task_74224_Name = {Text = "@1@2"},
  Task_74224_Name2 = {
    Text = "空无回响Ⅳ"
  },
  Task_74225_Desc = {
    Text = "完成调查事件「@1@2」"
  },
  Task_74225_Desc2 = {
    Text = "完成调查事件「重临雾都」"
  },
  Task_74225_Name = {Text = "@1@2"},
  Task_74225_Name2 = {
    Text = "勿要迷失于灰夜"
  },
  Task_74226_Desc = {
    Text = "在调查事件「@1@2」中共鸣3次"
  },
  Task_74226_Desc2 = {
    Text = "在调查事件「重临雾都」中共鸣3次"
  },
  Task_74226_Name = {Text = "@1@2"},
  Task_74226_Name2 = {
    Text = "空无回响"
  },
  Task_74227_Desc = {
    Text = "在调查事件「@1@2」中共鸣6次"
  },
  Task_74227_Desc2 = {
    Text = "在调查事件「重临雾都」中共鸣6次"
  },
  Task_74227_Name = {Text = "@1@2"},
  Task_74227_Name2 = {
    Text = "空无回响Ⅱ"
  },
  Task_74228_Desc = {
    Text = "在调查事件「@1@2」中共鸣8次"
  },
  Task_74228_Desc2 = {
    Text = "在调查事件「重临雾都」中共鸣8次"
  },
  Task_74228_Name = {Text = "@1@2"},
  Task_74228_Name2 = {
    Text = "空无回响Ⅲ"
  },
  Task_74235_Desc = {
    Text = "找到莉兹"
  },
  Task_74235_Name = {Text = "目标"},
  Task_74295_Desc = {
    Text = "完成意识潜游「热情归尘」"
  },
  Task_74295_Name = {
    Text = "青焰旋舞"
  },
  Task_74296_Desc = {
    Text = "完成意识潜游「热情归尘」困难难度"
  },
  Task_74296_Name = {
    Text = "青焰旋舞·困难"
  },
  Task_74332_Name = {
    Text = "逆转回合活动结束"
  },
  Task_74333_Desc = {
    Text = "通关逆转回合剧情第二章"
  },
  Task_74333_UnlockCondDesc = {
    Text = "领取「回合奇赏：积分达到1200」后解锁"
  },
  Task_74334_Desc = {
    Text = "通关逆转回合剧情序章"
  },
  Task_74335_Desc = {
    Text = "通关逆转回合剧情第三章"
  },
  Task_74335_UnlockCondDesc = {
    Text = "领取「回合奇赏：积分达到2400」后解锁"
  },
  Task_74342_Desc = {
    Text = "使用守护类角色打出25张卡牌"
  },
  Task_74343_Desc = {
    Text = "使用凶星类角色打出25张卡牌"
  },
  Task_74344_Desc = {
    Text = "使用祝福类角色打出25张卡牌"
  },
  Task_74345_Desc = {
    Text = "使用灵智类角色打出25张卡牌"
  },
  Task_74346_Desc = {
    Text = "使用斗争类角色打出25张卡牌"
  },
  Task_74375_Desc = {
    Text = "使用斗争类角色打出1750张卡牌"
  },
  Task_74376_Desc = {
    Text = "使用祝福类角色打出400张卡牌"
  },
  Task_74377_Desc = {
    Text = "使用灵智类角色打出1225张卡牌"
  },
  Task_74378_Desc = {
    Text = "使用凶星类角色打出1125张卡牌"
  },
  Task_74379_Desc = {
    Text = "使用凶星类角色打出775张卡牌"
  },
  Task_74380_Desc = {
    Text = "使用祝福类角色打出1775张卡牌"
  },
  Task_74381_Desc = {
    Text = "使用斗争类角色打出775张卡牌"
  },
  Task_74382_Desc = {
    Text = "使用灵智类角色打出700张卡牌"
  },
  Task_74383_Desc = {
    Text = "使用守护类角色打出1875张卡牌"
  },
  Task_74384_Desc = {
    Text = "使用祝福类角色打出825张卡牌"
  },
  Task_74385_Desc = {
    Text = "使用斗争类角色打出1800张卡牌"
  },
  Task_74386_Desc = {
    Text = "使用斗争类角色打出1200张卡牌"
  },
  Task_74387_Desc = {
    Text = "使用祝福类角色打出775张卡牌"
  },
  Task_74388_Desc = {
    Text = "使用灵智类角色打出525张卡牌"
  },
  Task_74389_Desc = {
    Text = "使用灵智类角色打出1600张卡牌"
  },
  Task_74390_Desc = {
    Text = "使用祝福类角色打出675张卡牌"
  },
  Task_74391_Desc = {
    Text = "使用斗争类角色打出1975张卡牌"
  },
  Task_74392_Desc = {
    Text = "使用守护类角色打出1525张卡牌"
  },
  Task_74393_Desc = {
    Text = "使用凶星类角色打出1325张卡牌"
  },
  Task_74394_Desc = {
    Text = "使用凶星类角色打出1550张卡牌"
  },
  Task_74395_Desc = {
    Text = "使用祝福类角色打出1125张卡牌"
  },
  Task_74396_Desc = {
    Text = "使用凶星类角色打出125张卡牌"
  },
  Task_74397_Desc = {
    Text = "使用凶星类角色打出1600张卡牌"
  },
  Task_74398_Desc = {
    Text = "使用祝福类角色打出650张卡牌"
  },
  Task_74399_Desc = {
    Text = "使用凶星类角色打出325张卡牌"
  },
  Task_74400_Desc = {
    Text = "使用祝福类角色打出1325张卡牌"
  },
  Task_74401_Desc = {
    Text = "使用祝福类角色打出150张卡牌"
  },
  Task_74402_Desc = {
    Text = "使用凶星类角色打出50张卡牌"
  },
  Task_74403_Desc = {
    Text = "使用祝福类角色打出2000张卡牌"
  },
  Task_74404_Desc = {
    Text = "使用斗争类角色打出850张卡牌"
  },
  Task_74405_Desc = {
    Text = "使用祝福类角色打出1150张卡牌"
  },
  Task_74406_Desc = {
    Text = "使用凶星类角色打出150张卡牌"
  },
  Task_74407_Desc = {
    Text = "使用守护类角色打出550张卡牌"
  },
  Task_74408_Desc = {
    Text = "使用凶星类角色打出800张卡牌"
  },
  Task_74409_Desc = {
    Text = "使用斗争类角色打出100张卡牌"
  },
  Task_74410_Desc = {
    Text = "使用守护类角色打出1600张卡牌"
  },
  Task_74411_Desc = {
    Text = "使用灵智类角色打出1300张卡牌"
  },
  Task_74412_Desc = {
    Text = "使用祝福类角色打出1850张卡牌"
  },
  Task_74413_Desc = {
    Text = "使用灵智类角色打出1525张卡牌"
  },
  Task_74414_Desc = {
    Text = "使用守护类角色打出1425张卡牌"
  },
  Task_74415_Desc = {
    Text = "使用守护类角色打出1275张卡牌"
  },
  Task_74416_Desc = {
    Text = "使用灵智类角色打出925张卡牌"
  },
  Task_74417_Desc = {
    Text = "使用守护类角色打出800张卡牌"
  },
  Task_74418_Desc = {
    Text = "使用灵智类角色打出1625张卡牌"
  },
  Task_74419_Desc = {
    Text = "使用灵智类角色打出1775张卡牌"
  },
  Task_74420_Desc = {
    Text = "使用祝福类角色打出1100张卡牌"
  },
  Task_74421_Desc = {
    Text = "使用凶星类角色打出100张卡牌"
  },
  Task_74422_Desc = {
    Text = "使用灵智类角色打出1750张卡牌"
  },
  Task_74423_Desc = {
    Text = "使用灵智类角色打出1125张卡牌"
  },
  Task_74424_Desc = {
    Text = "使用灵智类角色打出750张卡牌"
  },
  Task_74425_Desc = {
    Text = "使用凶星类角色打出1725张卡牌"
  },
  Task_74426_Desc = {
    Text = "使用斗争类角色打出1150张卡牌"
  },
  Task_74427_Desc = {
    Text = "使用灵智类角色打出175张卡牌"
  },
  Task_74428_Desc = {
    Text = "使用凶星类角色打出1625张卡牌"
  },
  Task_74429_Desc = {
    Text = "使用祝福类角色打出425张卡牌"
  },
  Task_74430_Desc = {
    Text = "使用灵智类角色打出1700张卡牌"
  },
  Task_74431_Desc = {
    Text = "使用斗争类角色打出1325张卡牌"
  },
  Task_74432_Desc = {
    Text = "使用祝福类角色打出1225张卡牌"
  },
  Task_74433_Desc = {
    Text = "使用凶星类角色打出225张卡牌"
  },
  Task_74434_Desc = {
    Text = "使用斗争类角色打出1875张卡牌"
  },
  Task_74435_Desc = {
    Text = "使用灵智类角色打出725张卡牌"
  },
  Task_74436_Desc = {
    Text = "使用灵智类角色打出325张卡牌"
  },
  Task_74437_Desc = {
    Text = "使用灵智类角色打出1350张卡牌"
  },
  Task_74438_Desc = {
    Text = "使用守护类角色打出1725张卡牌"
  },
  Task_74439_Desc = {
    Text = "使用斗争类角色打出1375张卡牌"
  },
  Task_74440_Desc = {
    Text = "使用守护类角色打出925张卡牌"
  },
  Task_74441_Desc = {
    Text = "使用凶星类角色打出1950张卡牌"
  },
  Task_74442_Desc = {
    Text = "使用斗争类角色打出450张卡牌"
  },
  Task_74443_Desc = {
    Text = "使用守护类角色打出175张卡牌"
  },
  Task_74444_Desc = {
    Text = "使用守护类角色打出1100张卡牌"
  },
  Task_74445_Desc = {
    Text = "使用守护类角色打出450张卡牌"
  },
  Task_74446_Desc = {
    Text = "使用斗争类角色打出1225张卡牌"
  },
  Task_74447_Desc = {
    Text = "使用灵智类角色打出1475张卡牌"
  },
  Task_74448_Desc = {
    Text = "使用守护类角色打出1250张卡牌"
  },
  Task_74449_Desc = {
    Text = "使用灵智类角色打出100张卡牌"
  },
  Task_74450_Desc = {
    Text = "使用斗争类角色打出975张卡牌"
  },
  Task_74451_Desc = {
    Text = "使用祝福类角色打出800张卡牌"
  },
  Task_74452_Desc = {
    Text = "使用凶星类角色打出1875张卡牌"
  },
  Task_74453_Desc = {
    Text = "使用斗争类角色打出900张卡牌"
  },
  Task_74454_Desc = {
    Text = "使用守护类角色打出1950张卡牌"
  },
  Task_74455_Desc = {
    Text = "使用守护类角色打出1000张卡牌"
  },
  Task_74456_Desc = {
    Text = "使用斗争类角色打出1925张卡牌"
  },
  Task_74457_Desc = {
    Text = "使用灵智类角色打出1825张卡牌"
  },
  Task_74458_Desc = {
    Text = "使用斗争类角色打出1725张卡牌"
  },
  Task_74459_Desc = {
    Text = "使用凶星类角色打出1500张卡牌"
  },
  Task_74460_Desc = {
    Text = "使用凶星类角色打出1375张卡牌"
  },
  Task_74461_Desc = {
    Text = "使用守护类角色打出350张卡牌"
  },
  Task_74462_Desc = {
    Text = "使用凶星类角色打出1975张卡牌"
  },
  Task_74463_Desc = {
    Text = "使用守护类角色打出625张卡牌"
  },
  Task_74464_Desc = {
    Text = "使用守护类角色打出500张卡牌"
  },
  Task_74465_Desc = {
    Text = "使用灵智类角色打出1200张卡牌"
  },
  Task_74466_Desc = {
    Text = "使用灵智类角色打出775张卡牌"
  },
  Task_74467_Desc = {
    Text = "使用灵智类角色打出975张卡牌"
  },
  Task_74468_Desc = {
    Text = "使用灵智类角色打出1550张卡牌"
  },
  Task_74469_Desc = {
    Text = "使用灵智类角色打出2000张卡牌"
  },
  Task_74470_Desc = {
    Text = "使用凶星类角色打出1050张卡牌"
  },
  Task_74471_Desc = {
    Text = "使用守护类角色打出1700张卡牌"
  },
  Task_74472_Desc = {
    Text = "使用斗争类角色打出1500张卡牌"
  },
  Task_74473_Desc = {
    Text = "使用祝福类角色打出75张卡牌"
  },
  Task_74474_Desc = {
    Text = "使用祝福类角色打出550张卡牌"
  },
  Task_74475_Desc = {
    Text = "使用灵智类角色打出150张卡牌"
  },
  Task_74476_Desc = {
    Text = "使用斗争类角色打出1575张卡牌"
  },
  Task_74477_Desc = {
    Text = "使用灵智类角色打出425张卡牌"
  },
  Task_74478_Desc = {
    Text = "使用守护类角色打出950张卡牌"
  },
  Task_74479_Desc = {
    Text = "使用守护类角色打出700张卡牌"
  },
  Task_74480_Desc = {
    Text = "使用斗争类角色打出1175张卡牌"
  },
  Task_74481_Desc = {
    Text = "使用斗争类角色打出700张卡牌"
  },
  Task_74482_Desc = {
    Text = "使用祝福类角色打出1275张卡牌"
  },
  Task_74483_Desc = {
    Text = "使用灵智类角色打出625张卡牌"
  },
  Task_74484_Desc = {
    Text = "使用凶星类角色打出275张卡牌"
  },
  Task_74485_Desc = {
    Text = "使用守护类角色打出1575张卡牌"
  },
  Task_74486_Desc = {
    Text = "使用守护类角色打出1400张卡牌"
  },
  Task_74487_Desc = {
    Text = "使用斗争类角色打出1675张卡牌"
  },
  Task_74488_Desc = {
    Text = "使用灵智类角色打出1075张卡牌"
  },
  Task_74489_Desc = {
    Text = "使用守护类角色打出325张卡牌"
  },
  Task_74490_Desc = {
    Text = "使用祝福类角色打出1025张卡牌"
  },
  Task_74491_Desc = {
    Text = "使用灵智类角色打出1025张卡牌"
  },
  Task_74492_Desc = {
    Text = "使用灵智类角色打出1050张卡牌"
  },
  Task_74493_Desc = {
    Text = "使用守护类角色打出600张卡牌"
  },
  Task_74494_Desc = {
    Text = "使用灵智类角色打出1900张卡牌"
  },
  Task_74495_Desc = {
    Text = "使用守护类角色打出125张卡牌"
  },
  Task_74496_Desc = {
    Text = "使用灵智类角色打出200张卡牌"
  },
  Task_74497_Desc = {
    Text = "使用祝福类角色打出1575张卡牌"
  },
  Task_74498_Desc = {
    Text = "使用凶星类角色打出575张卡牌"
  },
  Task_74499_Desc = {
    Text = "使用斗争类角色打出800张卡牌"
  },
  Task_74500_Desc = {
    Text = "使用灵智类角色打出1275张卡牌"
  },
  Task_74501_Desc = {
    Text = "使用守护类角色打出1625张卡牌"
  },
  Task_74502_Desc = {
    Text = "使用祝福类角色打出1900张卡牌"
  },
  Task_74503_Desc = {
    Text = "使用斗争类角色打出1100张卡牌"
  },
  Task_74504_Desc = {
    Text = "使用斗争类角色打出150张卡牌"
  },
  Task_74505_Desc = {
    Text = "使用祝福类角色打出50张卡牌"
  },
  Task_74506_Desc = {
    Text = "使用斗争类角色打出1025张卡牌"
  },
  Task_74507_Desc = {
    Text = "使用斗争类角色打出1900张卡牌"
  },
  Task_74508_Desc = {
    Text = "使用斗争类角色打出675张卡牌"
  },
  Task_74509_Desc = {
    Text = "使用守护类角色打出1925张卡牌"
  },
  Task_74510_Desc = {
    Text = "使用灵智类角色打出1850张卡牌"
  },
  Task_74511_Desc = {
    Text = "使用凶星类角色打出1250张卡牌"
  },
  Task_74512_Desc = {
    Text = "使用斗争类角色打出1950张卡牌"
  },
  Task_74513_Desc = {
    Text = "使用斗争类角色打出550张卡牌"
  },
  Task_74514_Desc = {
    Text = "使用斗争类角色打出250张卡牌"
  },
  Task_74515_Desc = {
    Text = "使用凶星类角色打出1525张卡牌"
  },
  Task_74516_Desc = {
    Text = "使用守护类角色打出75张卡牌"
  },
  Task_74517_Desc = {
    Text = "使用灵智类角色打出1150张卡牌"
  },
  Task_74518_Desc = {
    Text = "使用凶星类角色打出825张卡牌"
  },
  Task_74519_Desc = {
    Text = "使用守护类角色打出50张卡牌"
  },
  Task_74520_Desc = {
    Text = "使用凶星类角色打出1200张卡牌"
  },
  Task_74521_Desc = {
    Text = "使用斗争类角色打出1600张卡牌"
  },
  Task_74522_Desc = {
    Text = "使用斗争类角色打出1125张卡牌"
  },
  Task_74523_Desc = {
    Text = "使用凶星类角色打出1425张卡牌"
  },
  Task_74524_Desc = {
    Text = "使用斗争类角色打出225张卡牌"
  },
  Task_74525_Desc = {
    Text = "使用灵智类角色打出375张卡牌"
  },
  Task_74526_Desc = {
    Text = "使用守护类角色打出1475张卡牌"
  },
  Task_74527_Desc = {
    Text = "使用守护类角色打出100张卡牌"
  },
  Task_74528_Desc = {
    Text = "使用斗争类角色打出375张卡牌"
  },
  Task_74529_Desc = {
    Text = "使用守护类角色打出1850张卡牌"
  },
  Task_74530_Desc = {
    Text = "使用斗争类角色打出350张卡牌"
  },
  Task_74531_Desc = {
    Text = "使用祝福类角色打出1675张卡牌"
  },
  Task_74532_Desc = {
    Text = "使用凶星类角色打出675张卡牌"
  },
  Task_74533_Desc = {
    Text = "使用灵智类角色打出1650张卡牌"
  },
  Task_74534_Desc = {
    Text = "使用灵智类角色打出75张卡牌"
  },
  Task_74535_Desc = {
    Text = "使用斗争类角色打出50张卡牌"
  },
  Task_74536_Desc = {
    Text = "使用斗争类角色打出875张卡牌"
  },
  Task_74537_Desc = {
    Text = "使用守护类角色打出1650张卡牌"
  },
  Task_74538_Desc = {
    Text = "使用祝福类角色打出250张卡牌"
  },
  Task_74539_Desc = {
    Text = "使用祝福类角色打出100张卡牌"
  },
  Task_74540_Desc = {
    Text = "使用祝福类角色打出1075张卡牌"
  },
  Task_74541_Desc = {
    Text = "使用凶星类角色打出1750张卡牌"
  },
  Task_74542_Desc = {
    Text = "使用斗争类角色打出750张卡牌"
  },
  Task_74543_Desc = {
    Text = "使用灵智类角色打出550张卡牌"
  },
  Task_74544_Desc = {
    Text = "使用斗争类角色打出1450张卡牌"
  },
  Task_74545_Desc = {
    Text = "使用斗争类角色打出725张卡牌"
  },
  Task_74546_Desc = {
    Text = "使用灵智类角色打出600张卡牌"
  },
  Task_74547_Desc = {
    Text = "使用祝福类角色打出700张卡牌"
  },
  Task_74548_Desc = {
    Text = "使用守护类角色打出1550张卡牌"
  },
  Task_74549_Desc = {
    Text = "使用祝福类角色打出850张卡牌"
  },
  Task_74550_Desc = {
    Text = "使用凶星类角色打出1450张卡牌"
  },
  Task_74551_Desc = {
    Text = "使用斗争类角色打出1625张卡牌"
  },
  Task_74552_Desc = {
    Text = "使用斗争类角色打出200张卡牌"
  },
  Task_74553_Desc = {
    Text = "使用祝福类角色打出1525张卡牌"
  },
  Task_74554_Desc = {
    Text = "使用凶星类角色打出525张卡牌"
  },
  Task_74555_Desc = {
    Text = "使用祝福类角色打出325张卡牌"
  },
  Task_74556_Desc = {
    Text = "使用斗争类角色打出1525张卡牌"
  },
  Task_74557_Desc = {
    Text = "使用凶星类角色打出375张卡牌"
  },
  Task_74558_Desc = {
    Text = "使用祝福类角色打出1375张卡牌"
  },
  Task_74559_Desc = {
    Text = "使用祝福类角色打出300张卡牌"
  },
  Task_74560_Desc = {
    Text = "使用祝福类角色打出225张卡牌"
  },
  Task_74561_Desc = {
    Text = "使用斗争类角色打出1850张卡牌"
  },
  Task_74562_Desc = {
    Text = "使用守护类角色打出475张卡牌"
  },
  Task_74563_Desc = {
    Text = "使用祝福类角色打出600张卡牌"
  },
  Task_74564_Desc = {
    Text = "使用守护类角色打出1375张卡牌"
  },
  Task_74565_Desc = {
    Text = "使用守护类角色打出1450张卡牌"
  },
  Task_74566_Desc = {
    Text = "使用守护类角色打出300张卡牌"
  },
  Task_74567_Desc = {
    Text = "使用灵智类角色打出950张卡牌"
  },
  Task_74568_Desc = {
    Text = "使用守护类角色打出1200张卡牌"
  },
  Task_74569_Desc = {
    Text = "使用凶星类角色打出1025张卡牌"
  },
  Task_74570_Desc = {
    Text = "使用祝福类角色打出950张卡牌"
  },
  Task_74571_Desc = {
    Text = "使用斗争类角色打出1350张卡牌"
  },
  Task_74572_Desc = {
    Text = "使用守护类角色打出525张卡牌"
  },
  Task_74573_Desc = {
    Text = "使用斗争类角色打出125张卡牌"
  },
  Task_74574_Desc = {
    Text = "使用祝福类角色打出475张卡牌"
  },
  Task_74575_Desc = {
    Text = "使用灵智类角色打出350张卡牌"
  },
  Task_74576_Desc = {
    Text = "使用灵智类角色打出1175张卡牌"
  },
  Task_74577_Desc = {
    Text = "使用灵智类角色打出1250张卡牌"
  },
  Task_74578_Desc = {
    Text = "使用守护类角色打出775张卡牌"
  },
  Task_74579_Desc = {
    Text = "使用守护类角色打出400张卡牌"
  },
  Task_74580_Desc = {
    Text = "使用斗争类角色打出825张卡牌"
  },
  Task_74581_Desc = {
    Text = "使用灵智类角色打出650张卡牌"
  },
  Task_74582_Desc = {
    Text = "使用凶星类角色打出1575张卡牌"
  },
  Task_74583_Desc = {
    Text = "使用祝福类角色打出350张卡牌"
  },
  Task_74584_Desc = {
    Text = "使用斗争类角色打出1400张卡牌"
  },
  Task_74585_Desc = {
    Text = "使用守护类角色打出275张卡牌"
  },
  Task_74586_Desc = {
    Text = "使用祝福类角色打出1500张卡牌"
  },
  Task_74587_Desc = {
    Text = "使用凶星类角色打出500张卡牌"
  },
  Task_74588_Desc = {
    Text = "使用斗争类角色打出1075张卡牌"
  },
  Task_74589_Desc = {
    Text = "使用祝福类角色打出625张卡牌"
  },
  Task_74590_Desc = {
    Text = "使用斗争类角色打出575张卡牌"
  },
  Task_74591_Desc = {
    Text = "使用凶星类角色打出850张卡牌"
  },
  Task_74592_Desc = {
    Text = "使用守护类角色打出650张卡牌"
  },
  Task_74593_Desc = {
    Text = "使用祝福类角色打出575张卡牌"
  },
  Task_74594_Desc = {
    Text = "使用祝福类角色打出375张卡牌"
  },
  Task_74595_Desc = {
    Text = "使用守护类角色打出225张卡牌"
  },
  Task_74596_Desc = {
    Text = "使用灵智类角色打出1875张卡牌"
  },
  Task_74597_Desc = {
    Text = "使用守护类角色打出1075张卡牌"
  },
  Task_74598_Desc = {
    Text = "使用斗争类角色打出1825张卡牌"
  },
  Task_74599_Desc = {
    Text = "使用凶星类角色打出1700张卡牌"
  },
  Task_74600_Desc = {
    Text = "使用守护类角色打出150张卡牌"
  },
  Task_74601_Desc = {
    Text = "使用守护类角色打出1750张卡牌"
  },
  Task_74602_Desc = {
    Text = "使用守护类角色打出1975张卡牌"
  },
  Task_74603_Desc = {
    Text = "使用凶星类角色打出750张卡牌"
  },
  Task_74604_Desc = {
    Text = "使用祝福类角色打出1750张卡牌"
  },
  Task_74605_Desc = {
    Text = "使用凶星类角色打出1150张卡牌"
  },
  Task_74606_Desc = {
    Text = "使用凶星类角色打出1475张卡牌"
  },
  Task_74607_Desc = {
    Text = "使用守护类角色打出875张卡牌"
  },
  Task_74608_Desc = {
    Text = "使用凶星类角色打出725张卡牌"
  },
  Task_74609_Desc = {
    Text = "使用祝福类角色打出1725张卡牌"
  },
  Task_74610_Desc = {
    Text = "使用凶星类角色打出1800张卡牌"
  },
  Task_74611_Desc = {
    Text = "使用祝福类角色打出1050张卡牌"
  },
  Task_74612_Desc = {
    Text = "使用祝福类角色打出1925张卡牌"
  },
  Task_74613_Desc = {
    Text = "使用凶星类角色打出925张卡牌"
  },
  Task_74614_Desc = {
    Text = "使用灵智类角色打出250张卡牌"
  },
  Task_74615_Desc = {
    Text = "使用灵智类角色打出900张卡牌"
  },
  Task_74616_Desc = {
    Text = "使用凶星类角色打出350张卡牌"
  },
  Task_74617_Desc = {
    Text = "使用祝福类角色打出1350张卡牌"
  },
  Task_74618_Desc = {
    Text = "使用祝福类角色打出125张卡牌"
  },
  Task_74619_Desc = {
    Text = "使用凶星类角色打出1775张卡牌"
  },
  Task_74620_Desc = {
    Text = "使用凶星类角色打出1925张卡牌"
  },
  Task_74621_Desc = {
    Text = "使用凶星类角色打出1900张卡牌"
  },
  Task_74622_Desc = {
    Text = "使用灵智类角色打出875张卡牌"
  },
  Task_74623_Desc = {
    Text = "使用守护类角色打出250张卡牌"
  },
  Task_74624_Desc = {
    Text = "使用守护类角色打出900张卡牌"
  },
  Task_74625_Desc = {
    Text = "使用守护类角色打出675张卡牌"
  },
  Task_74626_Desc = {
    Text = "使用守护类角色打出1350张卡牌"
  },
  Task_74627_Desc = {
    Text = "使用灵智类角色打出1450张卡牌"
  },
  Task_74628_Desc = {
    Text = "使用祝福类角色打出875张卡牌"
  },
  Task_74629_Desc = {
    Text = "使用斗争类角色打出1550张卡牌"
  },
  Task_74630_Desc = {
    Text = "使用灵智类角色打出1000张卡牌"
  },
  Task_74631_Desc = {
    Text = "使用凶星类角色打出2000张卡牌"
  },
  Task_74632_Desc = {
    Text = "使用灵智类角色打出675张卡牌"
  },
  Task_74633_Desc = {
    Text = "使用守护类角色打出1025张卡牌"
  },
  Task_74634_Desc = {
    Text = "使用凶星类角色打出1300张卡牌"
  },
  Task_74635_Desc = {
    Text = "使用灵智类角色打出1800张卡牌"
  },
  Task_74636_Desc = {
    Text = "使用守护类角色打出1825张卡牌"
  },
  Task_74637_Desc = {
    Text = "使用斗争类角色打出1700张卡牌"
  },
  Task_74638_Desc = {
    Text = "使用斗争类角色打出1000张卡牌"
  },
  Task_74639_Desc = {
    Text = "使用祝福类角色打出275张卡牌"
  },
  Task_74640_Desc = {
    Text = "使用灵智类角色打出1100张卡牌"
  },
  Task_74641_Desc = {
    Text = "使用祝福类角色打出1800张卡牌"
  },
  Task_74642_Desc = {
    Text = "使用斗争类角色打出1475张卡牌"
  },
  Task_74643_Desc = {
    Text = "使用凶星类角色打出1225张卡牌"
  },
  Task_74644_Desc = {
    Text = "使用祝福类角色打出975张卡牌"
  },
  Task_74645_Desc = {
    Text = "使用斗争类角色打出400张卡牌"
  },
  Task_74646_Desc = {
    Text = "使用灵智类角色打出800张卡牌"
  },
  Task_74647_Desc = {
    Text = "使用灵智类角色打出1925张卡牌"
  },
  Task_74648_Desc = {
    Text = "使用灵智类角色打出1375张卡牌"
  },
  Task_74649_Desc = {
    Text = "使用灵智类角色打出400张卡牌"
  },
  Task_74650_Desc = {
    Text = "使用祝福类角色打出1000张卡牌"
  },
  Task_74651_Desc = {
    Text = "使用凶星类角色打出700张卡牌"
  },
  Task_74652_Desc = {
    Text = "使用祝福类角色打出1700张卡牌"
  },
  Task_74653_Desc = {
    Text = "使用凶星类角色打出1075张卡牌"
  },
  Task_74654_Desc = {
    Text = "使用斗争类角色打出1050张卡牌"
  },
  Task_74655_Desc = {
    Text = "使用斗争类角色打出175张卡牌"
  },
  Task_74656_Desc = {
    Text = "使用灵智类角色打出300张卡牌"
  },
  Task_74657_Desc = {
    Text = "使用凶星类角色打出1000张卡牌"
  },
  Task_74658_Desc = {
    Text = "使用灵智类角色打出825张卡牌"
  },
  Task_74659_Desc = {
    Text = "使用斗争类角色打出600张卡牌"
  },
  Task_74660_Desc = {
    Text = "使用守护类角色打出725张卡牌"
  },
  Task_74661_Desc = {
    Text = "使用守护类角色打出750张卡牌"
  },
  Task_74662_Desc = {
    Text = "使用凶星类角色打出1675张卡牌"
  },
  Task_74663_Desc = {
    Text = "使用灵智类角色打出1500张卡牌"
  },
  Task_74664_Desc = {
    Text = "使用守护类角色打出375张卡牌"
  },
  Task_74665_Desc = {
    Text = "使用守护类角色打出1150张卡牌"
  },
  Task_74666_Desc = {
    Text = "使用灵智类角色打出275张卡牌"
  },
  Task_74667_Desc = {
    Text = "使用祝福类角色打出900张卡牌"
  },
  Task_74668_Desc = {
    Text = "使用灵智类角色打出475张卡牌"
  },
  Task_74669_Desc = {
    Text = "使用凶星类角色打出75张卡牌"
  },
  Task_74670_Desc = {
    Text = "使用祝福类角色打出175张卡牌"
  },
  Task_74671_Desc = {
    Text = "使用守护类角色打出1775张卡牌"
  },
  Task_74672_Desc = {
    Text = "使用灵智类角色打出575张卡牌"
  },
  Task_74673_Desc = {
    Text = "使用斗争类角色打出500张卡牌"
  },
  Task_74674_Desc = {
    Text = "使用灵智类角色打出1725张卡牌"
  },
  Task_74675_Desc = {
    Text = "使用斗争类角色打出950张卡牌"
  },
  Task_74676_Desc = {
    Text = "使用灵智类角色打出1950张卡牌"
  },
  Task_74677_Desc = {
    Text = "使用守护类角色打出1500张卡牌"
  },
  Task_74678_Desc = {
    Text = "使用祝福类角色打出1975张卡牌"
  },
  Task_74679_Desc = {
    Text = "使用凶星类角色打出975张卡牌"
  },
  Task_74680_Desc = {
    Text = "使用灵智类角色打出1325张卡牌"
  },
  Task_74681_Desc = {
    Text = "使用斗争类角色打出1775张卡牌"
  },
  Task_74682_Desc = {
    Text = "使用灵智类角色打出125张卡牌"
  },
  Task_74683_Desc = {
    Text = "使用祝福类角色打出1550张卡牌"
  },
  Task_74684_Desc = {
    Text = "使用斗争类角色打出2000张卡牌"
  },
  Task_74685_Desc = {
    Text = "使用凶星类角色打出1275张卡牌"
  },
  Task_74686_Desc = {
    Text = "使用祝福类角色打出525张卡牌"
  },
  Task_74687_Desc = {
    Text = "使用凶星类角色打出550张卡牌"
  },
  Task_74688_Desc = {
    Text = "使用斗争类角色打出650张卡牌"
  },
  Task_74689_Desc = {
    Text = "使用凶星类角色打出875张卡牌"
  },
  Task_74690_Desc = {
    Text = "使用祝福类角色打出1875张卡牌"
  },
  Task_74691_Desc = {
    Text = "使用守护类角色打出1300张卡牌"
  },
  Task_74692_Desc = {
    Text = "使用凶星类角色打出1100张卡牌"
  },
  Task_74693_Desc = {
    Text = "使用守护类角色打出2000张卡牌"
  },
  Task_74694_Desc = {
    Text = "使用凶星类角色打出1850张卡牌"
  },
  Task_74695_Desc = {
    Text = "使用斗争类角色打出75张卡牌"
  },
  Task_74696_Desc = {
    Text = "使用斗争类角色打出625张卡牌"
  },
  Task_74697_Desc = {
    Text = "使用斗争类角色打出1425张卡牌"
  },
  Task_74698_Desc = {
    Text = "使用守护类角色打出1800张卡牌"
  },
  Task_74699_Desc = {
    Text = "使用灵智类角色打出225张卡牌"
  },
  Task_74700_Desc = {
    Text = "使用祝福类角色打出725张卡牌"
  },
  Task_74701_Desc = {
    Text = "使用守护类角色打出1175张卡牌"
  },
  Task_74702_Desc = {
    Text = "使用灵智类角色打出450张卡牌"
  },
  Task_74703_Desc = {
    Text = "使用守护类角色打出575张卡牌"
  },
  Task_74704_Desc = {
    Text = "使用祝福类角色打出1625张卡牌"
  },
  Task_74705_Desc = {
    Text = "使用凶星类角色打出625张卡牌"
  },
  Task_74706_Desc = {
    Text = "使用凶星类角色打出1350张卡牌"
  },
  Task_74707_Desc = {
    Text = "使用祝福类角色打出1650张卡牌"
  },
  Task_74708_Desc = {
    Text = "使用凶星类角色打出650张卡牌"
  },
  Task_74709_Desc = {
    Text = "使用守护类角色打出200张卡牌"
  },
  Task_74710_Desc = {
    Text = "使用守护类角色打出1125张卡牌"
  },
  Task_74711_Desc = {
    Text = "使用灵智类角色打出50张卡牌"
  },
  Task_74712_Desc = {
    Text = "使用凶星类角色打出450张卡牌"
  },
  Task_74713_Desc = {
    Text = "使用祝福类角色打出1250张卡牌"
  },
  Task_74714_Desc = {
    Text = "使用凶星类角色打出250张卡牌"
  },
  Task_74715_Desc = {
    Text = "使用祝福类角色打出1450张卡牌"
  },
  Task_74716_Desc = {
    Text = "使用灵智类角色打出1675张卡牌"
  },
  Task_74717_Desc = {
    Text = "使用凶星类角色打出900张卡牌"
  },
  Task_74718_Desc = {
    Text = "使用灵智类角色打出500张卡牌"
  },
  Task_74719_Desc = {
    Text = "使用守护类角色打出1325张卡牌"
  },
  Task_74720_Desc = {
    Text = "使用凶星类角色打出425张卡牌"
  },
  Task_74721_Desc = {
    Text = "使用祝福类角色打出1425张卡牌"
  },
  Task_74722_Desc = {
    Text = "使用斗争类角色打出1300张卡牌"
  },
  Task_74723_Desc = {
    Text = "使用祝福类角色打出925张卡牌"
  },
  Task_74724_Desc = {
    Text = "使用祝福类角色打出1825张卡牌"
  },
  Task_74725_Desc = {
    Text = "使用祝福类角色打出1175张卡牌"
  },
  Task_74726_Desc = {
    Text = "使用凶星类角色打出175张卡牌"
  },
  Task_74727_Desc = {
    Text = "使用祝福类角色打出750张卡牌"
  },
  Task_74728_Desc = {
    Text = "使用守护类角色打出850张卡牌"
  },
  Task_74729_Desc = {
    Text = "使用斗争类角色打出1650张卡牌"
  },
  Task_74730_Desc = {
    Text = "使用斗争类角色打出1275张卡牌"
  },
  Task_74731_Desc = {
    Text = "使用凶星类角色打出1175张卡牌"
  },
  Task_74732_Desc = {
    Text = "使用灵智类角色打出1975张卡牌"
  },
  Task_74733_Desc = {
    Text = "使用斗争类角色打出275张卡牌"
  },
  Task_74734_Desc = {
    Text = "使用灵智类角色打出1425张卡牌"
  },
  Task_74735_Desc = {
    Text = "使用守护类角色打出1900张卡牌"
  },
  Task_74736_Desc = {
    Text = "使用祝福类角色打出1600张卡牌"
  },
  Task_74737_Desc = {
    Text = "使用凶星类角色打出600张卡牌"
  },
  Task_74738_Desc = {
    Text = "使用守护类角色打出1050张卡牌"
  },
  Task_74739_Desc = {
    Text = "使用凶星类角色打出1400张卡牌"
  },
  Task_74740_Desc = {
    Text = "使用祝福类角色打出200张卡牌"
  },
  Task_74741_Desc = {
    Text = "使用祝福类角色打出500张卡牌"
  },
  Task_74742_Desc = {
    Text = "使用守护类角色打出1225张卡牌"
  },
  Task_74743_Desc = {
    Text = "使用斗争类角色打出525张卡牌"
  },
  Task_74744_Desc = {
    Text = "使用凶星类角色打出400张卡牌"
  },
  Task_74745_Desc = {
    Text = "使用祝福类角色打出1400张卡牌"
  },
  Task_74746_Desc = {
    Text = "使用守护类角色打出425张卡牌"
  },
  Task_74747_Desc = {
    Text = "使用斗争类角色打出475张卡牌"
  },
  Task_74748_Desc = {
    Text = "使用凶星类角色打出475张卡牌"
  },
  Task_74749_Desc = {
    Text = "使用祝福类角色打出1475张卡牌"
  },
  Task_74750_Desc = {
    Text = "使用斗争类角色打出300张卡牌"
  },
  Task_74751_Desc = {
    Text = "使用灵智类角色打出1575张卡牌"
  },
  Task_74752_Desc = {
    Text = "使用守护类角色打出1675张卡牌"
  },
  Task_74753_Desc = {
    Text = "使用守护类角色打出975张卡牌"
  },
  Task_74754_Desc = {
    Text = "使用斗争类角色打出1250张卡牌"
  },
  Task_74755_Desc = {
    Text = "使用灵智类角色打出850张卡牌"
  },
  Task_74756_Desc = {
    Text = "使用祝福类角色打出1200张卡牌"
  },
  Task_74757_Desc = {
    Text = "使用凶星类角色打出1650张卡牌"
  },
  Task_74758_Desc = {
    Text = "使用凶星类角色打出200张卡牌"
  },
  Task_74759_Desc = {
    Text = "使用祝福类角色打出1950张卡牌"
  },
  Task_74760_Desc = {
    Text = "使用凶星类角色打出950张卡牌"
  },
  Task_74761_Desc = {
    Text = "使用祝福类角色打出450张卡牌"
  },
  Task_74762_Desc = {
    Text = "使用灵智类角色打出1400张卡牌"
  },
  Task_74763_Desc = {
    Text = "使用斗争类角色打出325张卡牌"
  },
  Task_74764_Desc = {
    Text = "使用斗争类角色打出925张卡牌"
  },
  Task_74765_Desc = {
    Text = "使用凶星类角色打出1825张卡牌"
  },
  Task_74766_Desc = {
    Text = "使用凶星类角色打出300张卡牌"
  },
  Task_74767_Desc = {
    Text = "使用祝福类角色打出1300张卡牌"
  },
  Task_74768_Desc = {
    Text = "使用斗争类角色打出425张卡牌"
  },
  Task_74769_Desc = {
    Text = "使用守护类角色打出825张卡牌"
  },
  Task_75738_Desc = {
    Text = "通关「无头尸」任意难度"
  },
  Task_75739_Desc = {
    Text = "通关「归于灰海」任意难度"
  },
  Task_75740_Desc = {
    Text = "通关「沼泽恶鬼」任意难度"
  },
  Task_75741_Desc = {
    Text = "通关「雨夜追猎」任意难度"
  },
  Task_75742_Desc = {
    Text = "通关「它与她」任意难度"
  },
  Task_76237_Desc = {
    Text = "通关星辰篇第1章 1-5 困难难度"
  },
  Task_76238_Desc = {
    Text = "通关终章「长梦尽时」"
  },
  Task_76239_Desc = {
    Text = "通关星辰篇第1章 1-6"
  },
  Task_76240_Desc = {
    Text = "通关终章 9-3 困难难度"
  },
  Task_76241_Desc = {
    Text = "通关终章「长梦尽时」困难难度"
  },
  Task_76242_Desc = {
    Text = "通关终章「长梦尽时」"
  },
  Task_76243_Desc = {
    Text = "通关星辰篇第1章「重临雾都」困难难度"
  },
  Task_76244_Desc = {
    Text = "通关星辰篇第1章「重临雾都」困难难度"
  },
  Task_76245_Desc = {
    Text = "通关终章 9-4"
  },
  Task_76246_Desc = {
    Text = "通关星辰篇第1章 1-6"
  },
  Task_76247_Desc = {
    Text = "通关星辰篇第1章「重临雾都」"
  },
  Task_76248_Desc = {
    Text = "通关星辰篇第1章 1-5 困难难度"
  },
  Task_76249_Desc = {
    Text = "通关终章「长梦尽时」困难难度"
  },
  Task_76250_Desc = {
    Text = "通关终章 9-3 困难难度"
  },
  Task_76251_Desc = {
    Text = "通关终章 9-4"
  },
  Task_76252_Desc = {
    Text = "通关星辰篇第1章「重临雾都」"
  },
  Task_76339_Desc = {
    Text = "通关「归于灰海」任意难度"
  },
  Task_76340_Desc = {
    Text = "魔女小店·癫狂"
  },
  Task_76341_Desc = {
    Text = "通关「雨夜追猎」癫狂难度"
  },
  Task_76342_Desc = {
    Text = "通关「沼泽恶鬼」癫狂难度"
  },
  Task_76343_Desc = {
    Text = "通关「它与她」任意难度"
  },
  Task_76344_Desc = {
    Text = "魔女的宝库"
  },
  Task_76345_Desc = {
    Text = "在「瑰丽秘宝」交换获得300个物品"
  },
  Task_76346_Desc = {
    Text = "在「瑰丽秘宝」交换获得150个物品"
  },
  Task_76347_Desc = {
    Text = "通关「无头尸」癫狂难度"
  },
  Task_76348_Desc = {
    Text = "通关「雨夜追猎」任意难度"
  },
  Task_76349_Desc = {
    Text = "通关「它与她」癫狂难度"
  },
  Task_76350_Desc = {
    Text = "通关「归于灰海」癫狂难度"
  },
  Task_76351_Desc = {
    Text = "在「珍藏奇货」交换获得150个物品"
  },
  Task_76352_Desc = {
    Text = "通关特遣纪录「雨镇幽影」"
  },
  Task_76353_Desc = {
    Text = "完成「魔女小店·通关」所有任务"
  },
  Task_76354_Desc = {
    Text = "在「珍藏奇货」交换获得300个物品"
  },
  Task_76355_Desc = {
    Text = "通关「沼泽恶鬼」任意难度"
  },
  Task_76356_Desc = {
    Text = "在「解忧佳品」交换获得300个物品"
  },
  Task_76357_Desc = {
    Text = "在「解忧佳品」交换获得150个物品"
  },
  Task_76358_Desc = {
    Text = "魔女小店·通关"
  },
  Task_76359_Desc = {
    Text = "通关「无头尸」任意难度"
  },
  Task_77674_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_77674_Name = {Text = "10胜"},
  Task_77675_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_77675_Name = {Text = "1胜"},
  Task_77676_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_77676_Name = {Text = "3胜"},
  Task_77677_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_77677_Name = {Text = "6胜"},
  Task_78106_Desc = {
    Text = "使用「环行·拉蒙娜」获得6次胜利"
  },
  Task_78107_Desc = {
    Text = "使用「伊萨拉乌的目光」获得6次胜利"
  },
  Task_78108_Desc = {
    Text = "使用「坚韧意志」获得6次胜利"
  },
  Task_78109_Desc = {
    Text = "使用「艾瑞卡」获得10次胜利"
  },
  Task_78112_Desc = {
    Text = "使用「莉莉」获得6次胜利"
  },
  Task_78113_Desc = {
    Text = "使用「仲夏之梦」获得6次胜利"
  },
  Task_78114_Desc = {
    Text = "使用「全部的她」获得6次胜利"
  },
  Task_78115_Desc = {
    Text = "使用「血链·希洛」获得10次胜利"
  },
  Task_78116_Desc = {
    Text = "使用「莱克」获得10次胜利"
  },
  Task_78117_Desc = {
    Text = "使用「拉蒙娜」获得10次胜利"
  },
  Task_78118_Desc = {
    Text = "使用「宁菲亚」获得6次胜利"
  },
  Task_78119_Desc = {
    Text = "使用「以蔷薇之名」获得6次胜利"
  },
  Task_78120_Desc = {
    Text = "使用「阿格里帕」获得6次胜利"
  },
  Task_78122_Desc = {
    Text = "使用「弥利亚姆」获得6次胜利"
  },
  Task_78123_Desc = {
    Text = "使用「莉兹」获得6次胜利"
  },
  Task_78124_Desc = {
    Text = "使用「放逐」获得6次胜利"
  },
  Task_78125_Desc = {
    Text = "使用「宠爱」获得6次胜利"
  },
  Task_78126_Desc = {
    Text = "使用「镜中人」获得6次胜利"
  },
  Task_78127_Desc = {
    Text = "使用「挣脱锁链之日」获得6次胜利"
  },
  Task_78128_Desc = {
    Text = "使用「迷失的道路」获得6次胜利"
  },
  Task_78129_Desc = {
    Text = "使用「汀克特」获得6次胜利"
  },
  Task_78130_Desc = {
    Text = "使用「聚首时刻」获得6次胜利"
  },
  Task_78131_Desc = {
    Text = "使用「潘狄娅」获得6次胜利"
  },
  Task_78132_Desc = {
    Text = "使用「萨尔瓦多」获得10次胜利"
  },
  Task_78133_Desc = {
    Text = "使用「海之梦」获得6次胜利"
  },
  Task_78134_Desc = {
    Text = "使用「真理之门」获得6次胜利"
  },
  Task_78135_Desc = {
    Text = "使用「狂乱」获得6次胜利"
  },
  Task_78137_Desc = {
    Text = "使用「伤痛之鳍」获得6次胜利"
  },
  Task_78138_Desc = {
    Text = "使用「希洛」获得10次胜利"
  },
  Task_78139_Desc = {Text = "唤醒体"},
  Task_78140_Desc = {
    Text = "使用「24」获得6次胜利"
  },
  Task_78141_Desc = {
    Text = "使用「卡茜亚」获得6次胜利"
  },
  Task_78142_Desc = {
    Text = "使用「塔薇」获得6次胜利"
  },
  Task_78143_Desc = {
    Text = "使用「戈利亚」获得6次胜利"
  },
  Task_78144_Desc = {
    Text = "使用「24」获得10次胜利"
  },
  Task_78145_Desc = {
    Text = "使用「神言石板」获得6次胜利"
  },
  Task_78146_Desc = {
    Text = "使用「永恒安魂曲」获得6次胜利"
  },
  Task_78147_Desc = {
    Text = "使用「惩戒」获得6次胜利"
  },
  Task_78148_Desc = {
    Text = "使用「神迹降临」获得6次胜利"
  },
  Task_78149_Desc = {
    Text = "使用「诗笺的句尾」获得6次胜利"
  },
  Task_78150_Desc = {
    Text = "使用「坠入虚无的人偶」获得6次胜利"
  },
  Task_78151_Desc = {
    Text = "使用「无声欢宴」获得6次胜利"
  },
  Task_78152_Desc = {
    Text = "使用「虔诚的伟力」获得6次胜利"
  },
  Task_78153_Desc = {
    Text = "使用「图鲁」获得10次胜利"
  },
  Task_78154_Desc = {
    Text = "使用「银鳕鱼的决心」获得6次胜利"
  },
  Task_78155_Desc = {
    Text = "使用「贪婪」获得6次胜利"
  },
  Task_78159_Desc = {
    Text = "使用「明悟」获得6次胜利"
  },
  Task_78160_Desc = {
    Text = "使用「灰雾真容」获得6次胜利"
  },
  Task_78161_Desc = {
    Text = "使用「血肉狂宴」获得6次胜利"
  },
  Task_78162_Desc = {
    Text = "使用「温柯尔」获得6次胜利"
  },
  Task_78163_Desc = {
    Text = "使用「百万蒙宠之眼」获得6次胜利"
  },
  Task_78164_Desc = {
    Text = "使用「呢喃」获得6次胜利"
  },
  Task_78166_Desc = {
    Text = "使用「朵尔」获得6次胜利"
  },
  Task_78168_Desc = {
    Text = "使用「阿格里帕」获得10次胜利"
  },
  Task_78169_Desc = {
    Text = "使用「萝坦」获得10次胜利"
  },
  Task_78170_Desc = {
    Text = "使用「戈利亚」获得10次胜利"
  },
  Task_78171_Desc = {
    Text = "使用「沉入殷红」获得6次胜利"
  },
  Task_78172_Desc = {
    Text = "使用「潘狄娅」获得10次胜利"
  },
  Task_78173_Desc = {
    Text = "使用「饕餮寓言」获得6次胜利"
  },
  Task_78174_Desc = {
    Text = "使用「命运轮盘赌」获得6次胜利"
  },
  Task_78175_Desc = {
    Text = "使用「切割与伤害」获得6次胜利"
  },
  Task_78176_Desc = {
    Text = "使用「神王的颂歌」获得6次胜利"
  },
  Task_78177_Desc = {
    Text = "使用「熔毁·朵尔」获得10次胜利"
  },
  Task_78178_Desc = {
    Text = "使用「雷娅」获得6次胜利"
  },
  Task_78179_Desc = {Text = "命轮"},
  Task_78180_Desc = {
    Text = "使用「希洛」获得6次胜利"
  },
  Task_78181_Desc = {
    Text = "使用「冬夜追忆」获得6次胜利"
  },
  Task_78182_Desc = {
    Text = "使用「巨人的霸道」获得6次胜利"
  },
  Task_78183_Desc = {
    Text = "使用「达芙黛尔」获得10次胜利"
  },
  Task_78184_Desc = {
    Text = "使用「引舵之帆」获得6次胜利"
  },
  Task_78185_Desc = {
    Text = "使用「莱克」获得6次胜利"
  },
  Task_78186_Desc = {
    Text = "使用「菲茵特」获得6次胜利"
  },
  Task_78187_Desc = {
    Text = "使用「遗忘之手」获得6次胜利"
  },
  Task_78188_Desc = {
    Text = "使用「泰旖丝」获得6次胜利"
  },
  Task_78189_Desc = {
    Text = "使用「宁菲亚」获得10次胜利"
  },
  Task_78190_Desc = {
    Text = "使用「旺达」获得6次胜利"
  },
  Task_78192_Desc = {
    Text = "使用「诺缔拉」获得6次胜利"
  },
  Task_78193_Desc = {
    Text = "使用「艾继丝」获得6次胜利"
  },
  Task_78194_Desc = {
    Text = "使用「无法完成的演算」获得6次胜利"
  },
  Task_78196_Desc = {
    Text = "使用「女王的戒律」获得6次胜利"
  },
  Task_78197_Desc = {
    Text = "使用「奥瑞塔」获得6次胜利"
  },
  Task_78198_Desc = {
    Text = "使用「环行·拉蒙娜」获得10次胜利"
  },
  Task_78199_Desc = {
    Text = "使用「伏于夜色」获得6次胜利"
  },
  Task_78200_Desc = {
    Text = "使用「血链·希洛」获得6次胜利"
  },
  Task_78201_Desc = {
    Text = "使用「跨越疼痛」获得6次胜利"
  },
  Task_78202_Desc = {
    Text = "使用「巨人之刃」获得6次胜利"
  },
  Task_78203_Desc = {
    Text = "使用「艾尔瓦」获得10次胜利"
  },
  Task_78204_Desc = {
    Text = "使用「临界点」获得6次胜利"
  },
  Task_78205_Desc = {
    Text = "使用「珊瑚女之死」获得6次胜利"
  },
  Task_78206_Desc = {
    Text = "使用「唯一的种子」获得6次胜利"
  },
  Task_78208_Desc = {
    Text = "使用「吞噬摇篮曲」获得6次胜利"
  },
  Task_78209_Desc = {
    Text = "使用「致挚友」获得6次胜利"
  },
  Task_78210_Desc = {
    Text = "使用「专注精神」获得6次胜利"
  },
  Task_78212_Desc = {
    Text = "使用「记忆症候」获得6次胜利"
  },
  Task_78213_Desc = {
    Text = "使用「达芙黛尔」获得6次胜利"
  },
  Task_78214_Desc = {
    Text = "使用「待到雪山消融」获得6次胜利"
  },
  Task_78216_Desc = {
    Text = "使用「希冀」获得6次胜利"
  },
  Task_78217_Desc = {
    Text = "使用「极夜与破晓」获得6次胜利"
  },
  Task_78218_Desc = {
    Text = "使用「墨菲」获得10次胜利"
  },
  Task_78219_Desc = {
    Text = "使用「不平等交换」获得6次胜利"
  },
  Task_78220_Desc = {
    Text = "使用「奥瑞塔的宝藏」获得6次胜利"
  },
  Task_78221_Desc = {
    Text = "使用「艾继丝」获得10次胜利"
  },
  Task_78223_Desc = {
    Text = "使用「勋爵手杖」获得6次胜利"
  },
  Task_78224_Desc = {
    Text = "使用「欲海浮沉」获得6次胜利"
  },
  Task_78225_Desc = {
    Text = "使用「尤乌哈希」获得6次胜利"
  },
  Task_78226_Desc = {
    Text = "使用「弥利亚姆」获得10次胜利"
  },
  Task_78227_Desc = {
    Text = "使用「拉蒙娜」获得6次胜利"
  },
  Task_78228_Desc = {
    Text = "使用「骑士之心」获得6次胜利"
  },
  Task_78229_Desc = {
    Text = "使用「熔毁·朵尔」获得6次胜利"
  },
  Task_78230_Desc = {
    Text = "使用「至为珍贵的藏品」获得6次胜利"
  },
  Task_78231_Desc = {
    Text = "使用「冒险的行囊」获得6次胜利"
  },
  Task_78232_Desc = {
    Text = "使用「眷顾」获得6次胜利"
  },
  Task_78233_Desc = {
    Text = "使用「艾尔瓦」获得6次胜利"
  },
  Task_78234_Desc = {
    Text = "使用「最后的誓言」获得6次胜利"
  },
  Task_78235_Desc = {
    Text = "使用「奥尔拉」获得6次胜利"
  },
  Task_78236_Desc = {
    Text = "使用「于暴雨之中」获得6次胜利"
  },
  Task_78237_Desc = {
    Text = "使用「朵尔」获得10次胜利"
  },
  Task_78238_Desc = {
    Text = "使用「超越死亡」获得6次胜利"
  },
  Task_78239_Desc = {
    Text = "使用「星天之兽」获得6次胜利"
  },
  Task_78240_Desc = {
    Text = "使用「咆哮的血与沙」获得6次胜利"
  },
  Task_78241_Desc = {
    Text = "使用「湖畔回眸」获得6次胜利"
  },
  Task_78242_Desc = {
    Text = "使用「詹金」获得10次胜利"
  },
  Task_78243_Desc = {Text = "钥令"},
  Task_78244_Desc = {
    Text = "使用「苍白后裔」获得6次胜利"
  },
  Task_78245_Desc = {
    Text = "使用「凯刻斯」获得6次胜利"
  },
  Task_78246_Desc = {
    Text = "使用「哈姆林」获得6次胜利"
  },
  Task_78247_Desc = {
    Text = "使用「奥尔拉」获得10次胜利"
  },
  Task_78248_Desc = {
    Text = "使用「核心熔解」获得6次胜利"
  },
  Task_78249_Desc = {
    Text = "使用「谵妄」获得6次胜利"
  },
  Task_78250_Desc = {
    Text = "使用「隐秘的诞生」获得6次胜利"
  },
  Task_78251_Desc = {
    Text = "使用「奥瑞塔」获得10次胜利"
  },
  Task_78252_Desc = {
    Text = "使用「墨菲」获得6次胜利"
  },
  Task_78253_Desc = {
    Text = "使用「纯银的初心」获得6次胜利"
  },
  Task_78254_Desc = {
    Text = "使用「图鲁」获得6次胜利"
  },
  Task_78255_Desc = {
    Text = "使用「珊」获得6次胜利"
  },
  Task_78256_Desc = {
    Text = "使用「詹金」获得6次胜利"
  },
  Task_78257_Desc = {
    Text = "使用「温柯尔」获得10次胜利"
  },
  Task_78258_Desc = {
    Text = "使用「旺达」获得10次胜利"
  },
  Task_78261_Desc = {
    Text = "使用「溯洄时计」获得6次胜利"
  },
  Task_78262_Desc = {
    Text = "使用「玫瑰的胜利」获得6次胜利"
  },
  Task_78263_Desc = {
    Text = "使用「奥吉尔」获得10次胜利"
  },
  Task_78264_Desc = {
    Text = "使用「法洛思」获得6次胜利"
  },
  Task_78265_Desc = {
    Text = "使用「菲茵特」获得10次胜利"
  },
  Task_78266_Desc = {
    Text = "使用「哈姆林」获得10次胜利"
  },
  Task_78267_Desc = {
    Text = "使用「慈悲的哺育」获得6次胜利"
  },
  Task_78269_Desc = {
    Text = "使用「死亡的剖析」获得6次胜利"
  },
  Task_78270_Desc = {
    Text = "使用「熟成」获得6次胜利"
  },
  Task_78272_Desc = {
    Text = "使用「信息就是生命」获得6次胜利"
  },
  Task_78273_Desc = {
    Text = "使用「蚀骨的拥抱」获得6次胜利"
  },
  Task_78274_Desc = {
    Text = "使用「珊」获得10次胜利"
  },
  Task_78275_Desc = {
    Text = "使用「冰川下的沉眠」获得6次胜利"
  },
  Task_78276_Desc = {
    Text = "使用「艾瑞卡」获得6次胜利"
  },
  Task_78277_Desc = {
    Text = "使用「隐世的转轮」获得6次胜利"
  },
  Task_78278_Desc = {
    Text = "使用「35mm的魔法」获得6次胜利"
  },
  Task_78279_Desc = {
    Text = "使用「脑中之音」获得6次胜利"
  },
  Task_78280_Desc = {
    Text = "使用「好运时间」获得6次胜利"
  },
  Task_78281_Desc = {
    Text = "使用「珈伦」获得10次胜利"
  },
  Task_78282_Desc = {
    Text = "使用「塔薇」获得10次胜利"
  },
  Task_78283_Desc = {
    Text = "使用「尤乌哈希」获得10次胜利"
  },
  Task_78284_Desc = {
    Text = "使用「莉兹」获得10次胜利"
  },
  Task_78286_Desc = {
    Text = "使用「心之壁垒」获得6次胜利"
  },
  Task_78287_Desc = {
    Text = "使用「卡茜亚」获得10次胜利"
  },
  Task_78288_Desc = {
    Text = "使用「畸体回噬」获得6次胜利"
  },
  Task_78289_Desc = {
    Text = "使用「永不停歇的演奏」获得6次胜利"
  },
  Task_78290_Desc = {
    Text = "使用「苦咒缚」获得6次胜利"
  },
  Task_78291_Desc = {
    Text = "使用「希莱斯特」获得10次胜利"
  },
  Task_78292_Desc = {
    Text = "使用「不存在之地」获得6次胜利"
  },
  Task_78294_Desc = {
    Text = "使用「汀克特」获得10次胜利"
  },
  Task_78295_Desc = {
    Text = "使用「法洛思」获得10次胜利"
  },
  Task_78296_Desc = {
    Text = "使用「莉莉」获得10次胜利"
  },
  Task_78297_Desc = {
    Text = "使用「短暂的永恒」获得6次胜利"
  },
  Task_78298_Desc = {
    Text = "使用「活性」获得6次胜利"
  },
  Task_78299_Desc = {
    Text = "使用「诺缔拉」获得10次胜利"
  },
  Task_78301_Desc = {
    Text = "使用「萨尔瓦多」获得6次胜利"
  },
  Task_78303_Desc = {
    Text = "使用「吮吸」获得6次胜利"
  },
  Task_78304_Desc = {
    Text = "使用「凯刻斯」获得10次胜利"
  },
  Task_78305_Desc = {
    Text = "使用「奥吉尔」获得6次胜利"
  },
  Task_78306_Desc = {
    Text = "使用「职责所在」获得6次胜利"
  },
  Task_78307_Desc = {
    Text = "使用「索蕾尔」获得10次胜利"
  },
  Task_78308_Desc = {
    Text = "使用「快乐魔法秀」获得6次胜利"
  },
  Task_78309_Desc = {
    Text = "使用「洞悉」获得6次胜利"
  },
  Task_78310_Desc = {
    Text = "使用「希莱斯特」获得6次胜利"
  },
  Task_78313_Desc = {
    Text = "使用「涌现」获得6次胜利"
  },
  Task_78314_Desc = {
    Text = "使用「雷娅」获得10次胜利"
  },
  Task_78315_Desc = {
    Text = "使用「被缚的歌谣」获得6次胜利"
  },
  Task_78316_Desc = {
    Text = "使用「索蕾尔」获得6次胜利"
  },
  Task_78317_Desc = {
    Text = "使用「珈伦」获得6次胜利"
  },
  Task_78318_Desc = {Text = "出牌"},
  Task_78319_Desc = {
    Text = "使用「萝坦」获得6次胜利"
  },
  Task_78320_Desc = {
    Text = "使用「腐朽赠礼」获得6次胜利"
  },
  Task_78321_Desc = {
    Text = "使用「泰旖丝」获得10次胜利"
  },
  Task_78322_Desc = {
    Text = "使用「记忆螺旋」获得6次胜利"
  },
  Task_78326_Desc = {
    Text = "凯蒂古拉同调率达到10 级"
  },
  Task_78327_Desc = {
    Text = "亚弗戈蒙同调率达到10 级"
  },
  Task_78328_Desc = {
    Text = "波吕克斯同调率达到10 级"
  },
  Task_78329_Desc = {
    Text = "秃鹫同调率达到10 级"
  },
  Task_78332_Desc = {
    Text = "兰提戈斯同调率达到10 级"
  },
  Task_78333_Desc = {
    Text = "卡拉布同调率达到10 级"
  },
  Task_78334_Desc = {
    Text = "克珀珊特同调率达到10 级"
  },
  Task_78336_Desc = {
    Text = "阿拉克涅同调率达到10 级"
  },
  Task_78338_Desc = {
    Text = "黑法老同调率达到10 级"
  },
  Task_78339_Desc = {
    Text = "夏塔克鸟同调率达到10 级"
  },
  Task_78340_Desc = {
    Text = "皮克曼同调率达到10 级"
  },
  Task_78341_Desc = {
    Text = "克莱门汀同调率达到10 级"
  },
  Task_78342_Desc = {
    Text = "卡斯托尔同调率达到10 级"
  },
  Task_78366_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78367_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78368_Desc = {
    Text = "获得夏塔克鸟时启灵6"
  },
  Task_78368_Name = {
    Text = "获得夏塔克鸟时启灵6"
  },
  Task_78368_UnlockCondDesc = {
    Text = "活动@唤醒体夏塔克鸟启灵礼包2活动"
  },
  Task_78369_Desc = {
    Text = "获得凯蒂古拉时启灵6"
  },
  Task_78369_Name = {
    Text = "获得凯蒂古拉时启灵6"
  },
  Task_78369_UnlockCondDesc = {
    Text = "活动@唤醒体凯蒂古拉启灵礼包2活动"
  },
  Task_78370_Desc = {
    Text = "获得夏塔克鸟时启灵2"
  },
  Task_78370_Name = {
    Text = "获得夏塔克鸟时启灵2"
  },
  Task_78370_UnlockCondDesc = {
    Text = "活动@唤醒体夏塔克鸟启灵礼包2活动"
  },
  Task_78371_Desc = {
    Text = "获得凯蒂古拉时启灵2"
  },
  Task_78371_Name = {
    Text = "获得凯蒂古拉时启灵2"
  },
  Task_78371_UnlockCondDesc = {
    Text = "活动@唤醒体凯蒂古拉启灵礼包2活动"
  },
  Task_78372_Desc = {
    Text = "获得波吕克斯时启灵2"
  },
  Task_78372_Name = {
    Text = "获得波吕克斯时启灵2"
  },
  Task_78372_UnlockCondDesc = {
    Text = "活动@唤醒体波吕克斯启灵礼包2活动"
  },
  Task_78373_Desc = {
    Text = "获得波吕克斯时启灵6"
  },
  Task_78373_Name = {
    Text = "获得波吕克斯时启灵6"
  },
  Task_78373_UnlockCondDesc = {
    Text = "活动@唤醒体波吕克斯启灵礼包2活动"
  },
  Task_78375_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78379_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78380_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78382_Desc = {
    Text = "获得阿拉克涅时启灵6"
  },
  Task_78382_Name = {
    Text = "获得阿拉克涅时启灵6"
  },
  Task_78382_UnlockCondDesc = {
    Text = "活动@唤醒体阿拉克涅启灵礼包2活动"
  },
  Task_78383_Desc = {
    Text = "获得阿拉克涅时启灵2"
  },
  Task_78383_Name = {
    Text = "获得阿拉克涅时启灵2"
  },
  Task_78383_UnlockCondDesc = {
    Text = "活动@唤醒体阿拉克涅启灵礼包2活动"
  },
  Task_78384_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78385_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78390_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78391_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78394_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78395_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78396_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78397_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78400_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78401_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78402_Desc = {
    Text = "获得皮克曼时启灵6"
  },
  Task_78402_Name = {
    Text = "获得皮克曼时启灵6"
  },
  Task_78402_UnlockCondDesc = {
    Text = "活动@唤醒体皮克曼启灵礼包2活动"
  },
  Task_78403_Desc = {
    Text = "获得皮克曼时启灵2"
  },
  Task_78403_Name = {
    Text = "获得皮克曼时启灵2"
  },
  Task_78403_UnlockCondDesc = {
    Text = "活动@唤醒体皮克曼启灵礼包2活动"
  },
  Task_78404_Desc = {
    Text = "获得卡斯托尔时启灵2"
  },
  Task_78404_Name = {
    Text = "获得卡斯托尔时启灵2"
  },
  Task_78404_UnlockCondDesc = {
    Text = "活动@唤醒体卡斯托尔启灵礼包2活动"
  },
  Task_78405_Desc = {
    Text = "获得卡斯托尔时启灵6"
  },
  Task_78405_Name = {
    Text = "获得卡斯托尔时启灵6"
  },
  Task_78405_UnlockCondDesc = {
    Text = "活动@唤醒体卡斯托尔启灵礼包2活动"
  },
  Task_78409_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78415_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78416_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78418_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78419_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78421_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78423_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78424_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78426_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78429_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78430_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78431_Desc = {
    Text = "获得卡拉布时启灵2"
  },
  Task_78431_Name = {
    Text = "获得卡拉布时启灵2"
  },
  Task_78431_UnlockCondDesc = {
    Text = "活动@唤醒体卡拉布启灵礼包2活动"
  },
  Task_78432_Desc = {
    Text = "获得卡拉布时启灵6"
  },
  Task_78432_Name = {
    Text = "获得卡拉布时启灵6"
  },
  Task_78432_UnlockCondDesc = {
    Text = "活动@唤醒体卡拉布启灵礼包2活动"
  },
  Task_78435_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78436_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78437_Desc = {
    Text = "获得亚弗戈蒙时启灵2"
  },
  Task_78437_Name = {
    Text = "获得亚弗戈蒙时启灵2"
  },
  Task_78437_UnlockCondDesc = {
    Text = "活动@唤醒体亚弗戈蒙启灵礼包2活动"
  },
  Task_78438_Desc = {
    Text = "获得克莱门汀时启灵2"
  },
  Task_78438_Name = {
    Text = "获得克莱门汀时启灵2"
  },
  Task_78438_UnlockCondDesc = {
    Text = "活动@唤醒体克莱门汀启灵礼包2活动"
  },
  Task_78440_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78441_Desc = {
    Text = "获得克莱门汀时启灵6"
  },
  Task_78441_Name = {
    Text = "获得克莱门汀时启灵6"
  },
  Task_78441_UnlockCondDesc = {
    Text = "活动@唤醒体克莱门汀启灵礼包2活动"
  },
  Task_78446_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78447_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78449_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78450_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78451_Desc = {
    Text = "获得黑法老时启灵2"
  },
  Task_78451_Name = {
    Text = "获得黑法老时启灵2"
  },
  Task_78451_UnlockCondDesc = {
    Text = "活动@唤醒体黑法老启灵礼包2活动"
  },
  Task_78453_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78458_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78459_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78460_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78466_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78468_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78470_Desc = {
    Text = "获得黑法老时启灵6"
  },
  Task_78470_Name = {
    Text = "获得黑法老时启灵6"
  },
  Task_78470_UnlockCondDesc = {
    Text = "活动@唤醒体黑法老启灵礼包2活动"
  },
  Task_78476_Desc = {
    Text = "获得兰提戈斯时启灵6"
  },
  Task_78476_Name = {
    Text = "获得兰提戈斯时启灵6"
  },
  Task_78476_UnlockCondDesc = {
    Text = "活动@唤醒体兰提戈斯启灵礼包2活动"
  },
  Task_78477_Desc = {
    Text = "获得兰提戈斯时启灵2"
  },
  Task_78477_Name = {
    Text = "获得兰提戈斯时启灵2"
  },
  Task_78477_UnlockCondDesc = {
    Text = "活动@唤醒体兰提戈斯启灵礼包2活动"
  },
  Task_78481_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78483_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78484_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78485_Desc = {
    Text = "获得秃鹫时启灵2"
  },
  Task_78485_Name = {
    Text = "获得秃鹫时启灵2"
  },
  Task_78485_UnlockCondDesc = {
    Text = "活动@唤醒体秃鹫启灵礼包2活动"
  },
  Task_78486_Desc = {
    Text = "获得秃鹫时启灵6"
  },
  Task_78486_Name = {
    Text = "获得秃鹫时启灵6"
  },
  Task_78486_UnlockCondDesc = {
    Text = "活动@唤醒体秃鹫启灵礼包2活动"
  },
  Task_78487_Desc = {
    Text = "获得亚弗戈蒙时启灵6"
  },
  Task_78487_Name = {
    Text = "获得亚弗戈蒙时启灵6"
  },
  Task_78487_UnlockCondDesc = {
    Text = "活动@唤醒体亚弗戈蒙启灵礼包2活动"
  },
  Task_78488_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78489_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78492_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78493_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78495_Desc = {
    Text = "获得克珀珊特时启灵6"
  },
  Task_78495_Name = {
    Text = "获得克珀珊特时启灵6"
  },
  Task_78495_UnlockCondDesc = {
    Text = "活动@唤醒体克珀珊特启灵礼包2活动"
  },
  Task_78496_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78497_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78499_Desc = {
    Text = "获得克珀珊特时启灵2"
  },
  Task_78499_Name = {
    Text = "获得克珀珊特时启灵2"
  },
  Task_78499_UnlockCondDesc = {
    Text = "活动@唤醒体克珀珊特启灵礼包2活动"
  },
  Task_78573_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78574_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78576_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78577_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78599_Desc = {
    Text = "最终战13回合内取胜"
  },
  Task_78599_Name = {
    Text = "最终战13回合内取胜"
  },
  Task_78600_Desc = {
    Text = "最终战14回合内取胜"
  },
  Task_78600_Name = {
    Text = "最终战14回合内取胜"
  },
  Task_78718_Desc = {
    Text = "使用血肉界域唤醒体在「记忆编码」中获胜2次"
  },
  Task_78719_Desc = {
    Text = "使用混沌界域唤醒体在「记忆编码」中获胜2次"
  },
  Task_78720_Desc = {
    Text = "使用深海界域唤醒体在「记忆编码」中获胜2次"
  },
  Task_78721_Desc = {
    Text = "使用超维界域唤醒体在「记忆编码」中获胜2次"
  },
  Task_78723_Desc = {
    Text = "暗潮虫鸣Ⅱ"
  },
  Task_78724_Desc = {
    Text = "暗潮虫鸣Ⅰ"
  },
  Task_78725_Desc = {
    Text = "暗潮虫鸣Ⅶ"
  },
  Task_78726_Desc = {
    Text = "暗潮虫鸣Ⅴ"
  },
  Task_78727_Desc = {
    Text = "暗潮虫鸣·免费"
  },
  Task_78728_Desc = {
    Text = "暗潮虫鸣Ⅵ"
  },
  Task_78729_Desc = {
    Text = "暗潮虫鸣Ⅲ"
  },
  Task_78730_Desc = {
    Text = "暗潮虫鸣Ⅳ"
  },
  Task_78740_Desc = {
    Text = "获得本源沉睡之主时启灵6"
  },
  Task_78740_Name = {
    Text = "获得本源沉睡之主时启灵6"
  },
  Task_78740_UnlockCondDesc = {
    Text = "活动@唤醒体本源沉睡之主启灵礼包2活动"
  },
  Task_78741_Desc = {
    Text = "本源沉睡之主同调率达到10 级"
  },
  Task_78742_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78743_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78745_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78746_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78748_Desc = {
    Text = "获得本源沉睡之主时启灵2"
  },
  Task_78748_Name = {
    Text = "获得本源沉睡之主时启灵2"
  },
  Task_78748_UnlockCondDesc = {
    Text = "活动@唤醒体本源沉睡之主启灵礼包2活动"
  },
  Task_78763_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78764_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78766_Desc = {
    Text = "获得本源深海淑女时启灵2"
  },
  Task_78766_Name = {
    Text = "获得本源深海淑女时启灵2"
  },
  Task_78766_UnlockCondDesc = {
    Text = "活动@唤醒体本源深海淑女启灵礼包2活动"
  },
  Task_78767_Desc = {
    Text = "获得本源深海淑女时启灵6"
  },
  Task_78767_Name = {
    Text = "获得本源深海淑女时启灵6"
  },
  Task_78767_UnlockCondDesc = {
    Text = "活动@唤醒体本源深海淑女启灵礼包2活动"
  },
  Task_78768_Desc = {
    Text = "本源深海淑女同调率达到10 级"
  },
  Task_78769_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_78770_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_79259_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_79259_Name = {
    Text = "不触发应急灵知体通关"
  },
  Task_79283_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_79283_Name = {
    Text = "完美通过"
  },
  Task_79284_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_79284_Name = {
    Text = "完美通过"
  },
  Task_79285_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_79285_Name = {
    Text = "完美通过"
  },
  Task_79286_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_79286_Name = {
    Text = "完美通过"
  },
  Task_79287_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_79287_Name = {
    Text = "完美通过"
  },
  Task_79288_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_79288_Name = {
    Text = "完美通过"
  },
  Task_79289_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_79289_Name = {
    Text = "完美通过"
  },
  Task_79290_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_79290_Name = {
    Text = "完美通过"
  },
  Task_79291_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_79291_Name = {
    Text = "完美通过"
  },
  Task_79292_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_79292_Name = {
    Text = "完美通过"
  },
  Task_79304_Desc = {
    Text = "使用「纯白初遇」获得1次胜利"
  },
  Task_79305_Desc = {
    Text = "使用「陨日」获得1次胜利"
  },
  Task_79306_Desc = {
    Text = "使用「虚无瘟疫」获得1次胜利"
  },
  Task_79307_Desc = {
    Text = "使用「旋转，旋转」获得6次胜利"
  },
  Task_79308_Desc = {
    Text = "使用「鼠鼠的智慧」获得1次胜利"
  },
  Task_79309_Desc = {
    Text = "使用「纯白初遇」获得3次胜利"
  },
  Task_79310_Desc = {
    Text = "使用「灼热的吻别」获得6次胜利"
  },
  Task_79311_Desc = {
    Text = "使用「陨日」获得3次胜利"
  },
  Task_79312_Desc = {
    Text = "使用「牧羊人的手杖」获得3次胜利"
  },
  Task_79313_Desc = {
    Text = "使用「不朽的葬仪」获得1次胜利"
  },
  Task_79314_Desc = {
    Text = "使用「鼠鼠的智慧」获得3次胜利"
  },
  Task_79315_Desc = {
    Text = "使用「群山的觉悟」获得3次胜利"
  },
  Task_79316_Desc = {
    Text = "使用「小小心愿」获得3次胜利"
  },
  Task_79317_Desc = {
    Text = "使用「灵魂诞生」获得1次胜利"
  },
  Task_79318_Desc = {
    Text = "使用「深海的呼唤」获得6次胜利"
  },
  Task_79319_Desc = {
    Text = "使用「腐烂盛筵」获得6次胜利"
  },
  Task_79320_Desc = {
    Text = "使用「群星的庇佑」获得3次胜利"
  },
  Task_79321_Desc = {
    Text = "使用「腐烂盛筵」获得3次胜利"
  },
  Task_79322_Desc = {
    Text = "使用「门扉的答案」获得1次胜利"
  },
  Task_79323_Desc = {
    Text = "使用「牧羊人的手杖」获得6次胜利"
  },
  Task_79324_Desc = {
    Text = "使用「深海的呼唤」获得1次胜利"
  },
  Task_79325_Desc = {
    Text = "使用「深海的呼唤」获得3次胜利"
  },
  Task_79326_Desc = {
    Text = "使用「虚无瘟疫」获得3次胜利"
  },
  Task_79327_Desc = {
    Text = "使用「春天的献诗」获得6次胜利"
  },
  Task_79328_Desc = {
    Text = "使用「一声枪响」获得1次胜利"
  },
  Task_79329_Desc = {
    Text = "使用「不朽的葬仪」获得3次胜利"
  },
  Task_79330_Desc = {
    Text = "使用「酒馆之门」获得1次胜利"
  },
  Task_79331_Desc = {
    Text = "使用「永世执念」获得3次胜利"
  },
  Task_79332_Desc = {
    Text = "使用「小小心愿」获得1次胜利"
  },
  Task_79333_Desc = {
    Text = "使用「门扉的答案」获得6次胜利"
  },
  Task_79334_Desc = {
    Text = "使用「青石王座」获得6次胜利"
  },
  Task_79335_Desc = {
    Text = "使用「群星的庇佑」获得1次胜利"
  },
  Task_79336_Desc = {
    Text = "使用「群山的觉悟」获得6次胜利"
  },
  Task_79337_Desc = {
    Text = "使用「陨日」获得6次胜利"
  },
  Task_79338_Desc = {
    Text = "使用「阿库特之春」获得6次胜利"
  },
  Task_79339_Desc = {
    Text = "使用「鼠鼠的智慧」获得6次胜利"
  },
  Task_79340_Desc = {
    Text = "使用「暴食」获得6次胜利"
  },
  Task_79341_Desc = {
    Text = "使用「不朽的葬仪」获得6次胜利"
  },
  Task_79342_Desc = {
    Text = "使用「海之祭」获得6次胜利"
  },
  Task_79343_Desc = {
    Text = "使用「注射守护」获得1次胜利"
  },
  Task_79344_Desc = {
    Text = "使用「注射守护」获得3次胜利"
  },
  Task_79345_Desc = {
    Text = "使用「酒馆之门」获得3次胜利"
  },
  Task_79346_Desc = {
    Text = "使用「往昔的花与诗」获得3次胜利"
  },
  Task_79347_Desc = {
    Text = "使用「旋转，旋转」获得1次胜利"
  },
  Task_79348_Desc = {
    Text = "使用「魔女宽檐帽」获得6次胜利"
  },
  Task_79349_Desc = {
    Text = "使用「跨越回溯之扉」获得3次胜利"
  },
  Task_79350_Desc = {
    Text = "使用「第四乐章」获得6次胜利"
  },
  Task_79351_Desc = {
    Text = "使用「青石王座」获得1次胜利"
  },
  Task_79352_Desc = {
    Text = "使用「第四乐章」获得1次胜利"
  },
  Task_79353_Desc = {
    Text = "使用「酒馆之门」获得6次胜利"
  },
  Task_79354_Desc = {
    Text = "使用「虚无瘟疫」获得6次胜利"
  },
  Task_79355_Desc = {
    Text = "使用「一声枪响」获得6次胜利"
  },
  Task_79356_Desc = {
    Text = "使用「魔女宽檐帽」获得1次胜利"
  },
  Task_79357_Desc = {
    Text = "使用「旋转，旋转」获得3次胜利"
  },
  Task_79358_Desc = {
    Text = "使用「腐烂盛筵」获得1次胜利"
  },
  Task_79359_Desc = {
    Text = "使用「青石王座」获得3次胜利"
  },
  Task_79360_Desc = {
    Text = "使用「灼热的吻别」获得3次胜利"
  },
  Task_79361_Desc = {
    Text = "使用「灵魂诞生」获得3次胜利"
  },
  Task_79362_Desc = {
    Text = "使用「永世执念」获得1次胜利"
  },
  Task_79363_Desc = {
    Text = "使用「跨越回溯之扉」获得1次胜利"
  },
  Task_79364_Desc = {
    Text = "使用「灼热的吻别」获得1次胜利"
  },
  Task_79365_Desc = {
    Text = "使用「往昔的花与诗」获得6次胜利"
  },
  Task_79366_Desc = {
    Text = "使用「群星的庇佑」获得6次胜利"
  },
  Task_79367_Desc = {
    Text = "使用「春天的献诗」获得1次胜利"
  },
  Task_79368_Desc = {
    Text = "使用「群山的觉悟」获得1次胜利"
  },
  Task_79369_Desc = {
    Text = "使用「阿库特之春」获得3次胜利"
  },
  Task_79370_Desc = {
    Text = "使用「注射守护」获得6次胜利"
  },
  Task_79371_Desc = {
    Text = "使用「魔女宽檐帽」获得3次胜利"
  },
  Task_79372_Desc = {
    Text = "使用「海之祭」获得3次胜利"
  },
  Task_79373_Desc = {
    Text = "使用「跨越回溯之扉」获得6次胜利"
  },
  Task_79374_Desc = {
    Text = "使用「纯白初遇」获得6次胜利"
  },
  Task_79375_Desc = {
    Text = "使用「小小心愿」获得6次胜利"
  },
  Task_79376_Desc = {
    Text = "使用「暴食」获得3次胜利"
  },
  Task_79377_Desc = {
    Text = "使用「海之祭」获得1次胜利"
  },
  Task_79378_Desc = {
    Text = "使用「第四乐章」获得3次胜利"
  },
  Task_79379_Desc = {
    Text = "使用「暴食」获得1次胜利"
  },
  Task_79380_Desc = {
    Text = "使用「门扉的答案」获得3次胜利"
  },
  Task_79381_Desc = {
    Text = "使用「往昔的花与诗」获得1次胜利"
  },
  Task_79382_Desc = {
    Text = "使用「牧羊人的手杖」获得1次胜利"
  },
  Task_79383_Desc = {
    Text = "使用「一声枪响」获得3次胜利"
  },
  Task_79384_Desc = {
    Text = "使用「灵魂诞生」获得6次胜利"
  },
  Task_79385_Desc = {
    Text = "使用「阿库特之春」获得1次胜利"
  },
  Task_79386_Desc = {
    Text = "使用「永世执念」获得6次胜利"
  },
  Task_79387_Desc = {
    Text = "使用「春天的献诗」获得3次胜利"
  },
  Task_79483_Desc = {
    Text = "恐惧愈疗·界域"
  },
  Task_79484_Desc = {
    Text = "使用深海界域唤醒体在「恐惧愈疗」中获胜2次"
  },
  Task_79485_Desc = {
    Text = "使用深海界域唤醒体在「恐惧愈疗」中获胜1次"
  },
  Task_79486_Desc = {
    Text = "通关「记忆诊所」任意难度"
  },
  Task_79487_Desc = {
    Text = "使用超维界域唤醒体在「恐惧愈疗」中获胜2次"
  },
  Task_79488_Desc = {
    Text = "使用超维界域唤醒体在「恐惧愈疗」中获胜1次"
  },
  Task_79489_Desc = {
    Text = "通关「新生」癫狂难度"
  },
  Task_79490_Desc = {
    Text = "恐惧愈疗·通关"
  },
  Task_79491_Desc = {
    Text = "通关「逐火之蛾」任意难度"
  },
  Task_79492_Desc = {
    Text = "使用血肉界域唤醒体在「恐惧愈疗」中获胜1次"
  },
  Task_79493_Desc = {
    Text = "使用血肉界域唤醒体在「恐惧愈疗」中获胜2次"
  },
  Task_79494_Desc = {
    Text = "通关「新生」任意难度"
  },
  Task_79495_Desc = {
    Text = "通关「燃烧的世界」癫狂难度"
  },
  Task_79496_Desc = {
    Text = "通关「侵梦之时」癫狂难度"
  },
  Task_79497_Desc = {
    Text = "通关「记忆诊所」任意难度"
  },
  Task_79498_Desc = {
    Text = "通关「逐火之蛾」任意难度"
  },
  Task_79499_Desc = {
    Text = "通关「燃烧的世界」任意难度"
  },
  Task_79500_Desc = {
    Text = "恐惧愈疗·癫狂"
  },
  Task_79501_Desc = {
    Text = "通关「燃烧的世界」任意难度"
  },
  Task_79502_Desc = {
    Text = "通关「侵梦之时」任意难度"
  },
  Task_79503_Desc = {
    Text = "使用混沌界域唤醒体在「恐惧愈疗」中获胜1次"
  },
  Task_79504_Desc = {
    Text = "使用混沌界域唤醒体在「恐惧愈疗」中获胜2次"
  },
  Task_79505_Desc = {
    Text = "通关「新生」任意难度"
  },
  Task_79506_Desc = {
    Text = "通关「逐火之蛾」癫狂难度"
  },
  Task_79507_Desc = {
    Text = "完成「恐惧愈疗·通关」所有任务"
  },
  Task_79508_Desc = {
    Text = "通关「侵梦之时」任意难度"
  },
  Task_79509_Desc = {
    Text = "通关「记忆诊所」癫狂难度"
  },
  Task_79747_Desc = {
    Text = "获得克莱门汀"
  },
  Task_79747_Name = {
    Text = "获得克莱门汀"
  },
  Task_80218_Desc = {
    Text = "击败拦路的「镇民」"
  },
  Task_80218_Name = {Text = "目标"},
  Task_80219_Desc = {
    Text = "阻止「生命仪式」"
  },
  Task_80219_Name = {Text = "目标"},
  Task_80220_Desc = {
    Text = "击溃宇宙@2的投影"
  },
  Task_80220_Name = {Text = "目标"},
  Task_80221_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_80221_Name = {
    Text = "完美通过"
  },
  Task_80222_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_80222_Name = {
    Text = "完美通过"
  },
  Task_80223_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_80223_Name = {
    Text = "完美通过"
  },
  Task_80224_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_80224_Name = {
    Text = "完美通过"
  },
  Task_80225_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_80225_Name = {
    Text = "完美通过"
  },
  Task_80226_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_80226_Name = {
    Text = "完美通过"
  },
  Task_80227_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_80227_Name = {
    Text = "完美通过"
  },
  Task_80228_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_80228_Name = {
    Text = "完美通过"
  },
  Task_80229_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_80229_Name = {
    Text = "完美通过"
  },
  Task_80230_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_80230_Name = {
    Text = "完美通过"
  },
  Task_80231_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_80231_Name = {
    Text = "完美通过"
  },
  Task_80232_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_80232_Name = {
    Text = "完美通过"
  },
  Task_80233_Desc = {
    Text = "确认「拉蒙娜」"
  },
  Task_80233_Name = {Text = "目标"},
  Task_80234_Desc = {
    Text = "避免被巡逻队抓获"
  },
  Task_80234_Name = {Text = "目标"},
  Task_80235_Desc = {
    Text = "甩脱「克莱门汀」们"
  },
  Task_80235_Name = {Text = "目标"},
  Task_80236_Desc = {
    Text = "前往克莱门汀的诊疗室"
  },
  Task_80236_Name = {Text = "目标"},
  Task_80237_Desc = {Text = "回家"},
  Task_80237_Name = {Text = "目标"},
  Task_80238_Desc = {
    Text = "阻止赫伯特的「收容」"
  },
  Task_80238_Name = {Text = "目标"},
  Task_80239_Desc = {
    Text = "摆脱医生的追捕"
  },
  Task_80239_Name = {Text = "目标"},
  Task_80240_Desc = {
    Text = "深入阿尔比诺的记忆"
  },
  Task_80240_Name = {Text = "目标"},
  Task_80241_Desc = {
    Text = "压制发狂的病人"
  },
  Task_80241_Name = {Text = "目标"},
  Task_80286_Desc = {
    Text = "通关星辰篇第2章 2-9"
  },
  Task_80287_Desc = {
    Text = "通关星辰篇第2章 2-6 困难难度"
  },
  Task_80288_Desc = {
    Text = "完成调查事件「@1@2」"
  },
  Task_80288_Desc2 = {
    Text = "完成调查事件「蜕变」"
  },
  Task_80288_Name = {Text = "@1@2"},
  Task_80288_Name2 = {
    Text = "聆听宇宙的嗡鸣"
  },
  Task_80289_Desc = {
    Text = "完成调查事件「蜕变」困难难度"
  },
  Task_80289_Name = {
    Text = "聆听宇宙的嗡鸣·困难"
  },
  Task_80290_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_80291_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_80292_Desc = {
    Text = "通关星辰篇第2章「蜕变」"
  },
  Task_80293_Desc = {
    Text = "通关星辰篇第2章「蜕变」困难难度"
  },
  Task_80294_Desc = {
    Text = "通关星辰篇第2章 2-6 困难难度"
  },
  Task_80295_Desc = {
    Text = "在调查事件「@1@2」中共鸣9次"
  },
  Task_80295_Desc2 = {
    Text = "在调查事件「蜕变」中共鸣9次"
  },
  Task_80295_Name = {Text = "@1@2"},
  Task_80295_Name2 = {
    Text = "衍变回响Ⅲ"
  },
  Task_80296_Desc = {
    Text = "在调查事件「@1@2」中共鸣6次"
  },
  Task_80296_Desc2 = {
    Text = "在调查事件「蜕变」中共鸣6次"
  },
  Task_80296_Name = {Text = "@1@2"},
  Task_80296_Name2 = {
    Text = "衍变回响Ⅱ"
  },
  Task_80297_Desc = {
    Text = "在调查事件「@1@2」中共鸣3次"
  },
  Task_80297_Desc2 = {
    Text = "在调查事件「蜕变」中共鸣3次"
  },
  Task_80297_Name = {Text = "@1@2"},
  Task_80297_Name2 = {
    Text = "衍变回响"
  },
  Task_80298_Desc = {
    Text = "通关星辰篇第2章 2-9"
  },
  Task_80299_Desc = {
    Text = "在调查事件「@1@2」中共鸣11次"
  },
  Task_80299_Desc2 = {
    Text = "在调查事件「蜕变」中共鸣11次"
  },
  Task_80299_Name = {Text = "@1@2"},
  Task_80299_Name2 = {
    Text = "衍变回响Ⅳ"
  },
  Task_80300_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_80301_Desc = {
    Text = "通关星辰篇第2章「蜕变」"
  },
  Task_80302_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_80303_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_80304_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_80305_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_80306_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_80307_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_80309_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_80310_Desc = {
    Text = "通关星辰篇第2章「蜕变」困难难度"
  },
  Task_80419_Name = {
    Text = "重新通关星辰篇2_18"
  },
  Task_80433_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_80433_Name = {Text = "10胜"},
  Task_80434_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_80434_Name = {Text = "6胜"},
  Task_80435_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_80435_Name = {Text = "3胜"},
  Task_80436_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_80436_Name = {Text = "1胜"},
  Task_80993_Desc = {
    Text = "清扫工具达到"
  },
  Task_80994_Desc = {
    Text = "完成任意 3 个任务"
  },
  Task_80994_Name = {
    Text = "今日扫除完成！"
  },
  Task_80995_Desc = {
    Text = "活动奖励"
  },
  Task_80996_Desc = {
    Text = "清扫工具达到"
  },
  Task_80997_Desc = {
    Text = "消耗 100000 蔷薇金券"
  },
  Task_80997_Name = {
    Text = "背包整理"
  },
  Task_80998_Desc = {
    Text = "清扫工具达到"
  },
  Task_80999_Desc = {
    Text = "清扫工具达到"
  },
  Task_81000_Desc = {
    Text = "累计登录 6 天"
  },
  Task_81001_Desc = {
    Text = "任意调查行动通关 1 次"
  },
  Task_81001_Name = {
    Text = "回忆除尘"
  },
  Task_81002_Desc = {
    Text = "累计登录 3 天"
  },
  Task_81003_Desc = {
    Text = "清扫工具达到"
  },
  Task_81004_Desc = {
    Text = "清扫工具达到"
  },
  Task_81005_Desc = {
    Text = "清扫工具达到"
  },
  Task_81006_Desc = {
    Text = "活动任务"
  },
  Task_81007_Desc = {
    Text = "完成 1 次相位对弈"
  },
  Task_81007_Name = {
    Text = "维度消毒"
  },
  Task_81008_Desc = {
    Text = "累计登录 5 天"
  },
  Task_81009_Desc = {
    Text = "累计登录 7 天"
  },
  Task_81010_Desc = {
    Text = "清扫工具达到"
  },
  Task_81011_Desc = {
    Text = "累计登录 1 天"
  },
  Task_81012_Desc = {
    Text = "累计登录 4 天"
  },
  Task_81013_Desc = {
    Text = "累计登录 2 天"
  },
  Task_81014_Desc = {
    Text = "清扫工具达到"
  },
  Task_81015_Desc = {
    Text = "清扫工具达到"
  },
  Task_81016_Desc = {
    Text = "融蚀之墟中消耗 180 灵啡肽"
  },
  Task_81016_Name = {
    Text = "融蚀清理"
  },
  Task_81017_Desc = {Text = "7天登录"},
  Task_81018_Desc = {
    Text = "幻梦深潜通关 1 次"
  },
  Task_81018_Name = {
    Text = "梦境通风"
  },
  Task_81083_Desc = {
    Text = "邃海迷航·癫狂"
  },
  Task_81084_Desc = {
    Text = "通关「最终挽歌」任意难度"
  },
  Task_81085_Desc = {
    Text = "使用深海界域唤醒体在「邃海迷航」中获胜2次"
  },
  Task_81086_Desc = {
    Text = "通关「破旧罗盘」任意难度"
  },
  Task_81087_Desc = {
    Text = "使用深海界域唤醒体在「邃海迷航」中获胜1次"
  },
  Task_81088_Desc = {
    Text = "通关「最终挽歌」任意难度"
  },
  Task_81089_Desc = {
    Text = "通关「导航员手册」癫狂难度"
  },
  Task_81090_Desc = {
    Text = "通关「领航之光」癫狂难度"
  },
  Task_81091_Desc = {
    Text = "使用超维界域唤醒体在「邃海迷航」中获胜2次"
  },
  Task_81092_Desc = {
    Text = "通关「老式六分仪」癫狂难度"
  },
  Task_81093_Desc = {
    Text = "通关意识潜游「最后的引航」"
  },
  Task_81094_Desc = {
    Text = "通关「破旧罗盘」癫狂难度"
  },
  Task_81095_Desc = {
    Text = "通关「领航之光」任意难度"
  },
  Task_81096_Desc = {
    Text = "通关「破旧罗盘」任意难度"
  },
  Task_81097_Desc = {
    Text = "完成「邃海迷航·通关」所有成就"
  },
  Task_81098_Desc = {
    Text = "通关「领航之光」任意难度"
  },
  Task_81099_Desc = {
    Text = "通关「星辰轨迹」癫狂难度"
  },
  Task_81100_Desc = {
    Text = "通关「星辰轨迹」任意难度"
  },
  Task_81101_Desc = {
    Text = "通关「信号旗语」任意难度"
  },
  Task_81102_Desc = {
    Text = "通关「信号旗语」任意难度"
  },
  Task_81103_Desc = {
    Text = "通关「老式六分仪」任意难度"
  },
  Task_81104_Desc = {
    Text = "通关「古老海图」任意难度"
  },
  Task_81105_Desc = {
    Text = "通关「信号旗语」癫狂难度"
  },
  Task_81106_Desc = {
    Text = "通关「导航员手册」任意难度"
  },
  Task_81107_Desc = {
    Text = "通关「导航员手册」任意难度"
  },
  Task_81108_Desc = {
    Text = "通关「斑驳星盘」任意难度"
  },
  Task_81109_Desc = {
    Text = "使用血肉界域唤醒体在「邃海迷航」中获胜1次"
  },
  Task_81110_Desc = {
    Text = "使用超维界域唤醒体在「邃海迷航」中获胜1次"
  },
  Task_81111_Desc = {
    Text = "通关「最终挽歌」癫狂难度"
  },
  Task_81112_Desc = {
    Text = "邃海迷航·通关"
  },
  Task_81113_Desc = {
    Text = "通关「星辰轨迹」任意难度"
  },
  Task_81114_Desc = {
    Text = "通关「古老海图」任意难度"
  },
  Task_81115_Desc = {
    Text = "通关「古老海图」癫狂难度"
  },
  Task_81116_Desc = {
    Text = "通关「斑驳星盘」癫狂难度"
  },
  Task_81117_Desc = {
    Text = "通关「老式六分仪」任意难度"
  },
  Task_81118_Desc = {
    Text = "通关「斑驳星盘」任意难度"
  },
  Task_81119_Desc = {
    Text = "邃海迷航·界域"
  },
  Task_81120_Desc = {
    Text = "使用混沌界域唤醒体在「邃海迷航」中获胜2次"
  },
  Task_81121_Desc = {
    Text = "使用血肉界域唤醒体在「邃海迷航」中获胜2次"
  },
  Task_81122_Desc = {
    Text = "使用混沌界域唤醒体在「邃海迷航」中获胜1次"
  },
  Task_81481_Desc = {
    Text = "在不依靠环行·拉蒙娜的协助下，击败「宇宙@2投影」。"
  },
  Task_81481_Name = {
    Text = "聆听宇宙的嗡鸣·隐藏"
  },
  Task_81772_Name = {
    Text = "击败BOSS1N次"
  },
  Task_81773_Name = {
    Text = "击败BOSS7N次"
  },
  Task_81774_Name = {
    Text = "击杀全部BOSS"
  },
  Task_81775_Name = {
    Text = "击败BOSS3N次"
  },
  Task_81776_Name = {
    Text = "击败BOSS2N次"
  },
  Task_81777_Name = {
    Text = "击败BOSS6N次"
  },
  Task_81778_Name = {
    Text = "击败BOSS4N次"
  },
  Task_81779_Name = {
    Text = "击败BOSS5N次"
  },
  Task_84111_Name = {
    Text = "重新通关克珀珊特支线关卡普通4"
  },
  Task_84143_Desc = {
    Text = "累计登录2天"
  },
  Task_84144_Desc = {
    Text = "累计登录3天"
  },
  Task_84145_Desc = {
    Text = "累计登录2天"
  },
  Task_84146_Desc = {
    Text = "累计登录5天"
  },
  Task_84147_Desc = {
    Text = "累计登录8天"
  },
  Task_84148_Desc = {
    Text = "累计登录2天"
  },
  Task_84149_Desc = {
    Text = "累计登录5天"
  },
  Task_84150_Desc = {
    Text = "累计登录10天"
  },
  Task_84151_Desc = {
    Text = "累计登录5天"
  },
  Task_84152_Desc = {
    Text = "累计登录10天"
  },
  Task_84153_Desc = {
    Text = "累计登录4天"
  },
  Task_84154_Desc = {
    Text = "累计登录9天"
  },
  Task_84155_Desc = {
    Text = "累计登录3天"
  },
  Task_84156_Desc = {
    Text = "累计登录6天"
  },
  Task_84157_Desc = {
    Text = "累计登录2天"
  },
  Task_84158_Desc = {
    Text = "累计登录4天"
  },
  Task_84159_Desc = {
    Text = "累计登录3天"
  },
  Task_84160_Desc = {
    Text = "累计登录1天"
  },
  Task_84161_Desc = {
    Text = "累计登录7天"
  },
  Task_84162_Desc = {
    Text = "累计登录5天"
  },
  Task_84163_Desc = {
    Text = "累计登录1天"
  },
  Task_84164_Desc = {
    Text = "累计登录1天"
  },
  Task_84165_Desc = {
    Text = "累计登录8天"
  },
  Task_84166_Desc = {
    Text = "累计登录7天"
  },
  Task_84167_Desc = {
    Text = "累计登录4天"
  },
  Task_84168_Desc = {
    Text = "累计登录6天"
  },
  Task_84169_Desc = {
    Text = "累计登录4天"
  },
  Task_84170_Desc = {
    Text = "累计登录9天"
  },
  Task_84171_Desc = {
    Text = "累计登录1天"
  },
  Task_84172_Desc = {
    Text = "累计登录3天"
  },
  Task_84323_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_84323_Name = {Text = "3胜"},
  Task_84324_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_84324_Name = {Text = "6胜"},
  Task_84325_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_84325_Name = {Text = "1胜"},
  Task_84326_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_84326_Name = {Text = "10胜"},
  Task_84349_Desc = {
    Text = "完成意识潜游「最后的引航」"
  },
  Task_84349_Name = {
    Text = "繁星与深渊的指引"
  },
  Task_88945_Desc = {
    Text = "通关「破开囚笼」任意难度"
  },
  Task_88946_Desc = {
    Text = "通关异梦视界「天边之外·上」"
  },
  Task_88947_Desc = {
    Text = "使用混沌界域唤醒体在「飞跃青空」中获胜2次"
  },
  Task_88948_Desc = {
    Text = "通关「孤独之旅」任意难度"
  },
  Task_88949_Desc = {
    Text = "使用深海界域唤醒体在「飞跃青空」中获胜1次"
  },
  Task_88950_Desc = {
    Text = "使用混沌界域唤醒体在「飞跃青空」中获胜1次"
  },
  Task_88951_Desc = {
    Text = "通关「传烛者」任意难度"
  },
  Task_88952_Desc = {
    Text = "通关「破开囚笼」癫狂难度"
  },
  Task_88953_Desc = {
    Text = "通关「破开囚笼」任意难度"
  },
  Task_88954_Desc = {
    Text = "使用超维界域唤醒体在「飞跃青空」中获胜1次"
  },
  Task_88955_Desc = {
    Text = "通关「自由与死亡」癫狂难度"
  },
  Task_88956_Desc = {
    Text = "通关「孤独之旅」任意难度"
  },
  Task_88957_Desc = {
    Text = "飞跃青空·癫狂"
  },
  Task_88958_Desc = {
    Text = "通关「自由与死亡」任意难度"
  },
  Task_88959_Desc = {
    Text = "通关「自由与死亡」任意难度"
  },
  Task_88960_Desc = {
    Text = "通关「无尽沙」任意难度"
  },
  Task_88961_Desc = {
    Text = "完成「飞跃青空·通关」所有成就"
  },
  Task_88962_Desc = {
    Text = "通关「传烛者」任意难度"
  },
  Task_88963_Desc = {
    Text = "通关「无尽沙」癫狂难度"
  },
  Task_88964_Desc = {
    Text = "通关「愚者」癫狂难度"
  },
  Task_88965_Desc = {
    Text = "通关「昨日之梦」癫狂难度"
  },
  Task_88966_Desc = {
    Text = "通关「孤独之旅」癫狂难度"
  },
  Task_88967_Desc = {
    Text = "使用血肉界域唤醒体在「飞跃青空」中获胜2次"
  },
  Task_88968_Desc = {
    Text = "通关「昨日之梦」任意难度"
  },
  Task_88969_Desc = {
    Text = "飞跃青空·界域"
  },
  Task_88970_Desc = {
    Text = "使用深海界域唤醒体在「飞跃青空」中获胜2次"
  },
  Task_88971_Desc = {
    Text = "飞跃青空·通关"
  },
  Task_88972_Desc = {
    Text = "通关「无尽沙」任意难度"
  },
  Task_88973_Desc = {
    Text = "使用血肉界域唤醒体在「飞跃青空」中获胜1次"
  },
  Task_88974_Desc = {
    Text = "通关「愚者」任意难度"
  },
  Task_88975_Desc = {
    Text = "通关「传烛者」癫狂难度"
  },
  Task_88976_Desc = {
    Text = "使用超维界域唤醒体在「飞跃青空」中获胜2次"
  },
  Task_88977_Desc = {
    Text = "通关「昨日之梦」任意难度"
  },
  Task_88978_Desc = {
    Text = "通关「愚者」任意难度"
  },
  Task_89577_Desc = {
    Text = "累计登录 12 天"
  },
  Task_89578_Desc = {
    Text = "累计登录 15 天"
  },
  Task_89579_Desc = {
    Text = "累计登录 2 天"
  },
  Task_89580_Desc = {
    Text = "累计登录 10 天"
  },
  Task_89581_Desc = {
    Text = "累计登录 11 天"
  },
  Task_89582_Desc = {
    Text = "累计登录 3 天"
  },
  Task_89583_Desc = {
    Text = "累计登录 6 天"
  },
  Task_89584_Desc = {
    Text = "累计登录 16 天"
  },
  Task_89585_Desc = {
    Text = "累计登录 4 天"
  },
  Task_89586_Desc = {
    Text = "累计登录 1 天"
  },
  Task_89587_Desc = {
    Text = "累计登录 7 天"
  },
  Task_89588_Desc = {
    Text = "累计登录 14 天"
  },
  Task_89589_Desc = {
    Text = "累计登录 8 天"
  },
  Task_89590_Desc = {
    Text = "累计登录 5 天"
  },
  Task_89591_Desc = {
    Text = "累计登录 13 天"
  },
  Task_89592_Desc = {
    Text = "累计登录 9 天"
  },
  Task_89844_Desc = {
    Text = "首次命轨合契唤醒({s1}/1)"
  },
  Task_89844_Name = {
    Text = "完成任务领取幻衣绘形券"
  },
  Task_89845_Desc = {
    Text = "7日登录({s1}/7)"
  },
  Task_89845_Name = {
    Text = "完成任务领取幻衣绘形券"
  },
  Task_89846_Desc = {
    Text = "击退异动海潮集群({s1}/30)"
  },
  Task_89846_Name = {
    Text = "完成任务领取幻衣绘形券"
  },
  Task_90036_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_90036_Name = {Text = "6胜"},
  Task_90037_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_90037_Name = {Text = "3胜"},
  Task_90038_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_90038_Name = {Text = "10胜"},
  Task_90039_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_90039_Name = {Text = "1胜"},
  Task_90495_Desc = {
    Text = "通关实战教学·混沌之念"
  },
  Task_90495_Name = {
    Text = "混沌之念"
  },
  Task_90866_Desc = {
    Text = "渊海胎动Ⅰ"
  },
  Task_90867_Desc = {
    Text = "万愿拟造Ⅰ"
  },
  Task_90868_Desc = {
    Text = "临时文本·免费"
  },
  Task_90869_Desc = {
    Text = "颅庭挽歌Ⅶ"
  },
  Task_90870_Desc = {
    Text = "临时文本Ⅳ"
  },
  Task_90871_Desc = {
    Text = "共轭命途Ⅲ"
  },
  Task_90872_Desc = {
    Text = "颅庭挽歌Ⅰ"
  },
  Task_90873_Desc = {
    Text = "万愿拟造Ⅴ"
  },
  Task_90874_Desc = {
    Text = "渊海胎动Ⅵ"
  },
  Task_90875_Desc = {
    Text = "临时文本Ⅰ"
  },
  Task_90876_Desc = {
    Text = "渊海胎动·免费"
  },
  Task_90877_Desc = {
    Text = "颅庭挽歌·免费"
  },
  Task_90878_Desc = {
    Text = "颅庭挽歌Ⅵ"
  },
  Task_90879_Desc = {
    Text = "万愿拟造Ⅳ"
  },
  Task_90880_Desc = {
    Text = "万愿拟造·免费"
  },
  Task_90881_Desc = {
    Text = "颅庭挽歌Ⅲ"
  },
  Task_90882_Desc = {
    Text = "共轭命途Ⅱ"
  },
  Task_90883_Desc = {
    Text = "临时文本Ⅴ"
  },
  Task_90884_Desc = {
    Text = "颅庭挽歌Ⅴ"
  },
  Task_90885_Desc = {
    Text = "临时文本Ⅵ"
  },
  Task_90886_Desc = {
    Text = "临时文本Ⅶ"
  },
  Task_90887_Desc = {
    Text = "共轭命途Ⅵ"
  },
  Task_90888_Desc = {
    Text = "共轭命途Ⅳ"
  },
  Task_90889_Desc = {
    Text = "颅庭挽歌Ⅳ"
  },
  Task_90890_Desc = {
    Text = "共轭命途Ⅴ"
  },
  Task_90891_Desc = {
    Text = "共轭命途Ⅰ"
  },
  Task_90892_Desc = {
    Text = "万愿拟造Ⅲ"
  },
  Task_90893_Desc = {
    Text = "渊海胎动Ⅱ"
  },
  Task_90894_Desc = {
    Text = "临时文本Ⅲ"
  },
  Task_90895_Desc = {
    Text = "共轭命途Ⅶ"
  },
  Task_90896_Desc = {
    Text = "颅庭挽歌Ⅱ"
  },
  Task_90897_Desc = {
    Text = "渊海胎动Ⅶ"
  },
  Task_90898_Desc = {
    Text = "渊海胎动Ⅴ"
  },
  Task_90899_Desc = {
    Text = "渊海胎动Ⅳ"
  },
  Task_90900_Desc = {
    Text = "万愿拟造Ⅵ"
  },
  Task_90901_Desc = {
    Text = "共轭命途·免费"
  },
  Task_90902_Desc = {
    Text = "万愿拟造Ⅱ"
  },
  Task_90903_Desc = {
    Text = "渊海胎动Ⅲ"
  },
  Task_90904_Desc = {
    Text = "万愿拟造Ⅶ"
  },
  Task_90905_Desc = {
    Text = "临时文本Ⅱ"
  },
  Task_91028_Desc = {
    Text = "通关「勇士桂冠」癫狂难度"
  },
  Task_91029_Desc = {
    Text = "使用混沌界域唤醒体在「神圣的猎食」中获胜1次"
  },
  Task_91030_Desc = {
    Text = "使用血肉界域唤醒体在「神圣的猎食」中获胜1次"
  },
  Task_91031_Desc = {
    Text = "使用超维界域唤醒体在「神圣的猎食」中获胜1次"
  },
  Task_91032_Desc = {
    Text = "使用血肉界域唤醒体在「神圣的猎食」中获胜2次"
  },
  Task_91033_Desc = {
    Text = "神圣的猎食·通关"
  },
  Task_91034_Desc = {
    Text = "通关「凶猛猎手」任意难度"
  },
  Task_91035_Desc = {
    Text = "神圣的猎食·癫狂"
  },
  Task_91036_Desc = {
    Text = "通关「远征号角」任意难度"
  },
  Task_91037_Desc = {
    Text = "通关「合作智慧」任意难度"
  },
  Task_91038_Desc = {
    Text = "使用深海界域唤醒体在「神圣的猎食」中获胜2次"
  },
  Task_91039_Desc = {
    Text = "使用超维界域唤醒体在「神圣的猎食」中获胜2次"
  },
  Task_91040_Desc = {
    Text = "通关异梦视界「征厨房记」"
  },
  Task_91041_Desc = {
    Text = "通关「勇士桂冠」任意难度"
  },
  Task_91042_Desc = {
    Text = "通关「勇士桂冠」任意难度"
  },
  Task_91043_Desc = {
    Text = "使用深海界域唤醒体在「神圣的猎食」中获胜1次"
  },
  Task_91044_Desc = {
    Text = "通关「荣耀凯旋」任意难度"
  },
  Task_91045_Desc = {
    Text = "通关「凶猛猎手」任意难度"
  },
  Task_91046_Desc = {
    Text = "通关「合作智慧」癫狂难度"
  },
  Task_91047_Desc = {
    Text = "通关「远征号角」任意难度"
  },
  Task_91048_Desc = {
    Text = "通关「合作智慧」任意难度"
  },
  Task_91049_Desc = {
    Text = "通关「荣耀凯旋」任意难度"
  },
  Task_91050_Desc = {
    Text = "完成「神圣的猎食·通关」所有成就"
  },
  Task_91051_Desc = {
    Text = "通关「远征号角」癫狂难度"
  },
  Task_91052_Desc = {
    Text = "通关「荣耀凯旋」癫狂难度"
  },
  Task_91053_Desc = {
    Text = "神圣的猎食·界域"
  },
  Task_91054_Desc = {
    Text = "通关「凶猛猎手」癫狂难度"
  },
  Task_91055_Desc = {
    Text = "使用混沌界域唤醒体在「神圣的猎食」中获胜2次"
  },
  Task_91129_Desc = {
    Text = "等级达到20级"
  },
  Task_91131_Desc = {
    Text = "等级达到5级"
  },
  Task_91149_Desc = {
    Text = "等级达到15级"
  },
  Task_91154_Desc = {
    Text = "等级达到10级"
  },
  Task_91332_Desc = {
    Text = "击败杜勒赛因"
  },
  Task_91332_Name = {Text = "目标"},
  Task_91333_Desc = {
    Text = "击溃入侵者"
  },
  Task_91333_Name = {Text = "目标"},
  Task_91334_Desc = {
    Text = "击溃「腐潮之傀」，守护葬骸城"
  },
  Task_91334_Name = {Text = "目标"},
  Task_91335_Desc = {
    Text = "击败蹈海者"
  },
  Task_91335_Name = {Text = "目标"},
  Task_91336_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_91336_Name = {
    Text = "完美通过"
  },
  Task_91337_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_91337_Name = {
    Text = "完美通过"
  },
  Task_91338_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_91338_Name = {
    Text = "完美通过"
  },
  Task_91339_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_91339_Name = {
    Text = "完美通过"
  },
  Task_91340_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_91340_Name = {
    Text = "完美通过"
  },
  Task_91341_Desc = {
    Text = "破坏皮克曼的「画作」"
  },
  Task_91341_Name = {Text = "目标"},
  Task_91342_Desc = {
    Text = "击败敌人，进入食尸鬼王城"
  },
  Task_91342_Name = {Text = "目标"},
  Task_91343_Desc = {
    Text = "摆脱食尸鬼的追捕"
  },
  Task_91343_Name = {Text = "目标"},
  Task_91344_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_91344_Name = {
    Text = "完美通过"
  },
  Task_91345_Desc = {
    Text = "击败融蚀体"
  },
  Task_91345_Name = {Text = "目标"},
  Task_91346_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_91346_Name = {
    Text = "完美通过"
  },
  Task_91347_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_91347_Name = {
    Text = "完美通过"
  },
  Task_91348_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_91348_Name = {
    Text = "完美通过"
  },
  Task_91349_Desc = {
    Text = "击退戈利亚，破坏法阵"
  },
  Task_91349_Name = {Text = "目标"},
  Task_91350_Desc = {
    Text = "不触发应急灵知体通关"
  },
  Task_91350_Name = {
    Text = "完美通过"
  },
  Task_91351_Desc = {
    Text = "击败管家弗兰"
  },
  Task_91351_Name = {Text = "目标"},
  Task_91357_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_91358_Desc = {
    Text = "通关星辰篇第3章 3-5"
  },
  Task_91359_Desc = {
    Text = "完成调查事件「@1@2」"
  },
  Task_91359_Desc2 = {
    Text = "完成调查事件「餍飨」"
  },
  Task_91359_Name = {Text = "@1@2"},
  Task_91359_Name2 = {
    Text = "骨与灵的共餐"
  },
  Task_91360_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_91361_Desc = {
    Text = "通关星辰篇第3章 3-5 困难难度"
  },
  Task_91362_Desc = {
    Text = "通关星辰篇第3章「餍飨」困难难度"
  },
  Task_91363_Desc = {
    Text = "完成调查事件「餍飨」困难难度"
  },
  Task_91363_Name = {
    Text = "骨与灵的共餐·困难"
  },
  Task_91364_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_91365_Desc = {
    Text = "通关星辰篇第3章「餍飨」"
  },
  Task_91366_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_91367_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_91368_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_91370_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_91371_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_91372_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_91373_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_91379_Desc = {
    Text = "通关星辰篇第3章 2-5 困难难度"
  },
  Task_91380_Desc = {
    Text = "通关星辰篇第3章 2-5"
  },
  Task_91381_Desc = {
    Text = "通关星辰篇第3章「餍飨」困难难度"
  },
  Task_91382_Desc = {
    Text = "通关星辰篇第3章「餍飨」"
  },
  Task_91436_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_91436_Name = {Text = "1胜"},
  Task_91437_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_91437_Name = {Text = "3胜"},
  Task_91438_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_91438_Name = {Text = "6胜"},
  Task_91439_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_91439_Name = {Text = "10胜"},
  Task_91720_Desc = {
    Text = "7日登录({s1}/7)"
  },
  Task_91720_Name = {
    Text = "完成任务领取幻衣绘形券"
  },
  Task_91721_Desc = {
    Text = "通关全部癫狂难度({s1}/5)"
  },
  Task_91721_Name = {
    Text = "完成任务领取幻衣绘形券"
  },
  Task_91786_Desc = {
    Text = "使用血肉界域唤醒体在「神国诞临」中获胜2次"
  },
  Task_91787_Desc = {
    Text = "使用混沌界域唤醒体在「神国诞临」中获胜2次"
  },
  Task_91788_Desc = {
    Text = "使用深海界域唤醒体在「神国诞临」中获胜2次"
  },
  Task_91789_Desc = {
    Text = "使用超维界域唤醒体在「神国诞临」中获胜2次"
  },
  Task_94489_Desc = {
    Text = "将6名混沌角色提升至80级"
  },
  Task_94489_Name = {
    Text = "界域精通Ⅹ"
  },
  Task_94490_Desc = {
    Text = "将6名深海角色提升至70级"
  },
  Task_94490_Name = {
    Text = "界域精通Ⅸ"
  },
  Task_94491_Desc = {
    Text = "将6名超维角色提升至70级"
  },
  Task_94491_Name = {
    Text = "界域精通Ⅸ"
  },
  Task_94492_Desc = {
    Text = "将6名血肉角色提升至80级"
  },
  Task_94492_Name = {
    Text = "界域精通Ⅹ"
  },
  Task_94493_Desc = {
    Text = "将6名深海角色提升至80级"
  },
  Task_94493_Name = {
    Text = "界域精通Ⅹ"
  },
  Task_94494_Desc = {
    Text = "将6名血肉角色提升至70级"
  },
  Task_94494_Name = {
    Text = "界域精通Ⅸ"
  },
  Task_94495_Desc = {
    Text = "将6名混沌角色提升至70级"
  },
  Task_94495_Name = {
    Text = "界域精通Ⅸ"
  },
  Task_94496_Desc = {
    Text = "将6名超维角色提升至80级"
  },
  Task_94496_Name = {
    Text = "界域精通Ⅹ"
  },
  Task_94497_Desc = {
    Text = "完成本章所有任务后可领取"
  },
  Task_94497_Name = {
    Text = "界域精通Ⅹ"
  },
  Task_94498_Desc = {
    Text = "完成本章所有任务后可领取"
  },
  Task_94498_Name = {
    Text = "界域精通Ⅸ"
  },
  Task_94613_Desc = {
    Text = "通关实战教学·超维之域"
  },
  Task_94613_Name = {
    Text = "超维之域"
  },
  Task_94614_Desc = {
    Text = "通关实战教学·血肉之殖"
  },
  Task_94614_Name = {
    Text = "血肉之殖"
  },
  Task_94615_Desc = {
    Text = "通关实战教学·深海之触"
  },
  Task_94615_Name = {
    Text = "深海之触"
  },
  Task_94699_Desc = {
    Text = "颅庭挽歌·限时专属"
  },
  Task_94861_Desc = {
    Text = "消耗灵啡肽 1800 点"
  },
  Task_94863_Desc = {
    Text = "累计唤醒 100 次"
  },
  Task_94865_Desc = {
    Text = "使用助战 3 次"
  },
  Task_94867_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_94871_Desc = {
    Text = "通关 1 次凯蒂古拉试玩关卡"
  },
  Task_94874_Desc = {
    Text = "完成 2 周每周试炼"
  },
  Task_94876_Desc = {
    Text = "消耗灵啡肽 1800 点"
  },
  Task_94877_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_94882_Desc = {
    Text = "累计登录 1 天"
  },
  Task_94885_Desc = {
    Text = "完成 2 周每周试炼"
  },
  Task_94886_Desc = {
    Text = "通关 1 次凯蒂古拉试玩关卡"
  },
  Task_94888_Desc = {
    Text = "使用助战 3 次"
  },
  Task_94891_Desc = {
    Text = "累计登录 1 天"
  },
  Task_94895_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_94898_Desc = {
    Text = "累计唤醒 100 次"
  },
  Task_94901_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_95192_Desc = {
    Text = "通关「地表的太阳」癫狂难度"
  },
  Task_95193_Desc = {
    Text = "使用血肉界域唤醒体在「烬灭追猎」中获胜2次"
  },
  Task_95194_Desc = {
    Text = "通关「无声的世界」任意难度"
  },
  Task_95195_Desc = {
    Text = "使用混沌界域唤醒体在「烬灭追猎」中获胜1次"
  },
  Task_95196_Desc = {
    Text = "通关意识潜游「不朽极昼」"
  },
  Task_95197_Desc = {
    Text = "通关「契约目标」任意难度"
  },
  Task_95198_Desc = {
    Text = "通关「无声的世界」癫狂难度"
  },
  Task_95199_Desc = {
    Text = "通关「契约目标」任意难度"
  },
  Task_95200_Desc = {
    Text = "通关「地表的太阳」任意难度"
  },
  Task_95201_Desc = {
    Text = "通关「炽焰宣判」任意难度"
  },
  Task_95202_Desc = {
    Text = "使用深海界域唤醒体在「烬灭追猎」中获胜1次"
  },
  Task_95203_Desc = {
    Text = "通关「亘古誓言」任意难度"
  },
  Task_95204_Desc = {
    Text = "通关「炽焰宣判」任意难度"
  },
  Task_95205_Desc = {
    Text = "使用超维界域唤醒体在「烬灭追猎」中获胜1次"
  },
  Task_95206_Desc = {
    Text = "使用混沌界域唤醒体在「烬灭追猎」中获胜2次"
  },
  Task_95207_Desc = {
    Text = "通关「覆世之光」任意难度"
  },
  Task_95208_Desc = {
    Text = "通关「地表的太阳」任意难度"
  },
  Task_95209_Desc = {
    Text = "使用血肉界域唤醒体在「烬灭追猎」中获胜1次"
  },
  Task_95210_Desc = {
    Text = "使用超维界域唤醒体在「烬灭追猎」中获胜2次"
  },
  Task_95211_Desc = {
    Text = "通关「炽焰宣判」癫狂难度"
  },
  Task_95212_Desc = {
    Text = "烬灭追猎·癫狂"
  },
  Task_95213_Desc = {
    Text = "使用深海界域唤醒体在「烬灭追猎」中获胜2次"
  },
  Task_95214_Desc = {
    Text = "通关「契约目标」癫狂难度"
  },
  Task_95215_Desc = {
    Text = "通关「无声的世界」任意难度"
  },
  Task_95216_Desc = {
    Text = "通关「覆世之光」任意难度"
  },
  Task_95217_Desc = {
    Text = "烬灭追猎·界域"
  },
  Task_95218_Desc = {
    Text = "通关「炼狱之歌」任意难度"
  },
  Task_95219_Desc = {
    Text = "通关「亘古誓言」任意难度"
  },
  Task_95220_Desc = {
    Text = "通关「亘古誓言」癫狂难度"
  },
  Task_95221_Desc = {
    Text = "通关「覆世之光」癫狂难度"
  },
  Task_95222_Desc = {
    Text = "通关「炼狱之歌」任意难度"
  },
  Task_95223_Desc = {
    Text = "完成「烬灭追猎·通关」所有成就"
  },
  Task_95224_Desc = {
    Text = "通关「炼狱之歌」癫狂难度"
  },
  Task_95225_Desc = {
    Text = "烬灭追猎·通关"
  },
  Task_95470_Desc = {Text = "战胜N"},
  Task_95470_Name = {Text = "目标"},
  Task_95520_Desc = {
    Text = "累计提取 16000 源液"
  },
  Task_95521_Desc = {
    Text = "累计提取 25000 源液"
  },
  Task_95522_Desc = {
    Text = "累计提取 13000 源液"
  },
  Task_95523_Desc = {
    Text = "累计提取 8000 源液"
  },
  Task_95524_Desc = {
    Text = "累计提取 2000 源液"
  },
  Task_95525_Desc = {
    Text = "累计提取 20000 源液"
  },
  Task_95526_Desc = {
    Text = "累计提取 4000 源液"
  },
  Task_95527_Desc = {
    Text = "累计提取 5000 源液"
  },
  Task_95532_Desc = {
    Text = "花园往事·癫狂"
  },
  Task_95533_Desc = {
    Text = "通关「灰烬」癫狂难度"
  },
  Task_95534_Desc = {
    Text = "通关「渺小王国」癫狂难度"
  },
  Task_95535_Desc = {
    Text = "通关「第一朵玫瑰」癫狂难度"
  },
  Task_95536_Desc = {
    Text = "通关「执手」癫狂难度"
  },
  Task_95537_Desc = {
    Text = "通关「盛开的诗篇」癫狂难度"
  },
  Task_95543_Desc = {
    Text = "通关「第一朵玫瑰」任意难度"
  },
  Task_95544_Desc = {
    Text = "通关「执手」任意难度"
  },
  Task_95545_Desc = {
    Text = "通关「盛开的诗篇」任意难度"
  },
  Task_95546_Desc = {
    Text = "通关「灰烬」任意难度"
  },
  Task_95547_Desc = {
    Text = "通关「渺小王国」任意难度"
  },
  Task_95830_Desc = {
    Text = "噬灵之飨·界域"
  },
  Task_95831_Desc = {
    Text = "通关「亡焰炙魂」癫狂难度"
  },
  Task_95832_Desc = {
    Text = "通关「腐殖调香」任意难度"
  },
  Task_95833_Desc = {
    Text = "通关「腐殖调香」癫狂难度"
  },
  Task_95834_Desc = {
    Text = "通关「沉棺开启」任意难度"
  },
  Task_95835_Desc = {
    Text = "使用血肉界域唤醒体在「噬灵之飨」中获胜2次"
  },
  Task_95836_Desc = {
    Text = "获得杜勒赛因时启灵2"
  },
  Task_95836_Name = {
    Text = "获得杜勒赛因时启灵2"
  },
  Task_95836_UnlockCondDesc = {
    Text = "活动@唤醒体杜勒赛因启灵礼包2活动"
  },
  Task_95837_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_95838_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_95839_Desc = {
    Text = "通关「沉棺开启」任意难度"
  },
  Task_95840_Desc = {
    Text = "使用混沌界域唤醒体在「噬灵之飨」中获胜1次"
  },
  Task_95841_Desc = {
    Text = "使用血肉界域唤醒体在「噬灵之飨」中获胜1次"
  },
  Task_95842_Desc = {
    Text = "通关「骨血剥离」癫狂难度"
  },
  Task_95843_Desc = {
    Text = "通关「灵龛盛筵」癫狂难度"
  },
  Task_95844_Desc = {
    Text = "通关「亡焰炙魂」任意难度"
  },
  Task_95845_Desc = {
    Text = "通关「亡焰炙魂」任意难度"
  },
  Task_95846_Desc = {
    Text = "杜勒赛因同调率达到10 级"
  },
  Task_95847_Desc = {
    Text = "噬灵之飨·通关"
  },
  Task_95848_Desc = {
    Text = "完成「噬灵之飨·通关」所有任务"
  },
  Task_95849_Desc = {
    Text = "通关「沉棺开启」癫狂难度"
  },
  Task_95850_Desc = {
    Text = "获得杜勒赛因时启灵6"
  },
  Task_95850_Name = {
    Text = "获得杜勒赛因时启灵6"
  },
  Task_95850_UnlockCondDesc = {
    Text = "活动@唤醒体杜勒赛因启灵礼包2活动"
  },
  Task_95853_Desc = {
    Text = "通关「骨血剥离」任意难度"
  },
  Task_95854_Desc = {
    Text = "噬灵之飨·癫狂"
  },
  Task_95855_Desc = {
    Text = "通关「灵龛盛筵」任意难度"
  },
  Task_95856_Desc = {
    Text = "使用深海界域唤醒体在「噬灵之飨」中获胜1次"
  },
  Task_95857_Desc = {
    Text = "通关「腐殖调香」任意难度"
  },
  Task_95858_Desc = {
    Text = "使用超维界域唤醒体在「噬灵之飨」中获胜1次"
  },
  Task_95860_Desc = {
    Text = "使用超维界域唤醒体在「噬灵之飨」中获胜2次"
  },
  Task_95861_Desc = {
    Text = "通关「骨血剥离」任意难度"
  },
  Task_95862_Desc = {
    Text = "使用深海界域唤醒体在「噬灵之飨」中获胜2次"
  },
  Task_95863_Desc = {
    Text = "通关「灵龛盛筵」任意难度"
  },
  Task_95864_Desc = {
    Text = "使用混沌界域唤醒体在「噬灵之飨」中获胜2次"
  },
  Task_95865_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_95866_UnlockCondDesc = {
    Text = "请先获取上一个礼包"
  },
  Task_96333_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_96333_Name = {Text = "10胜"},
  Task_96334_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_96334_Name = {Text = "3胜"},
  Task_96335_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_96335_Name = {Text = "6胜"},
  Task_96336_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_96336_Name = {Text = "1胜"},
  Task_96618_Desc = {
    Text = "在商店中使用金券进行 3 次兑换"
  },
  Task_96619_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_96620_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_96621_Desc = {
    Text = "通关 1 次「24」混沌试玩关卡"
  },
  Task_96622_Desc = {
    Text = "完成 2 周所有每周试炼任务"
  },
  Task_96623_Desc = {
    Text = "通关超验存在 1 次"
  },
  Task_96624_Desc = {
    Text = "累计登录 15 天"
  },
  Task_96625_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_96626_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_96627_Desc = {
    Text = "通关超验存在 1 次"
  },
  Task_96628_Desc = {
    Text = "消耗灵啡肽 1800 点"
  },
  Task_96629_Desc = {
    Text = "累计登录 1 天"
  },
  Task_96630_Desc = {
    Text = "累计登录 1 天"
  },
  Task_96631_Desc = {
    Text = "在商店中使用金券进行 3 次兑换"
  },
  Task_96632_Desc = {
    Text = "消耗灵啡肽 1800 点"
  },
  Task_96633_Desc = {
    Text = "通关 1 次「24」混沌试玩关卡"
  },
  Task_96840_Desc = {
    Text = "异界图卷·通关"
  },
  Task_96841_Desc = {
    Text = "通关「地狱之变」任意难度"
  },
  Task_96842_Desc = {
    Text = "通关「金牛疯舞」任意难度"
  },
  Task_96843_Desc = {
    Text = "通关「线魂肆虐」任意难度"
  },
  Task_96844_Desc = {
    Text = "通关「狂欢定格」癫狂难度"
  },
  Task_96845_Desc = {
    Text = "通关「金牛疯舞」癫狂难度"
  },
  Task_96846_Desc = {
    Text = "使用超维界域唤醒体在「异界图卷」中获胜2次"
  },
  Task_96847_Desc = {
    Text = "通关「灵感侵染」任意难度"
  },
  Task_96848_Desc = {
    Text = "通关「血色蔓延」癫狂难度"
  },
  Task_96849_Desc = {
    Text = "通关「血色蔓延」任意难度"
  },
  Task_96850_Desc = {
    Text = "通关「金牛疯舞」任意难度"
  },
  Task_96851_Desc = {
    Text = "通关「血色蔓延」任意难度"
  },
  Task_96852_Desc = {
    Text = "使用混沌界域唤醒体在「异界图卷」中获胜2次"
  },
  Task_96853_Desc = {
    Text = "完成「异界图卷·通关」所有成就"
  },
  Task_96854_Desc = {
    Text = "通关「线魂肆虐」任意难度"
  },
  Task_96855_Desc = {
    Text = "通关「狂欢定格」任意难度"
  },
  Task_96856_Desc = {
    Text = "异界图卷·界域"
  },
  Task_96857_Desc = {
    Text = "使用深海界域唤醒体在「异界图卷」中获胜2次"
  },
  Task_96858_Desc = {
    Text = "通关「线魂肆虐」癫狂难度"
  },
  Task_96859_Desc = {
    Text = "使用血肉界域唤醒体在「异界图卷」中获胜1次"
  },
  Task_96860_Desc = {
    Text = "通关「地狱之变」任意难度"
  },
  Task_96861_Desc = {
    Text = "使用混沌界域唤醒体在「异界图卷」中获胜1次"
  },
  Task_96862_Desc = {
    Text = "通关意识潜游「畸世绘」"
  },
  Task_96863_Desc = {
    Text = "通关「梦魇堆垒」任意难度"
  },
  Task_96864_Desc = {
    Text = "使用深海界域唤醒体在「异界图卷」中获胜1次"
  },
  Task_96865_Desc = {
    Text = "通关「灵感侵染」癫狂难度"
  },
  Task_96866_Desc = {
    Text = "通关「梦魇堆垒」任意难度"
  },
  Task_96867_Desc = {
    Text = "异界图卷·癫狂"
  },
  Task_96868_Desc = {
    Text = "通关「狂欢定格」任意难度"
  },
  Task_96869_Desc = {
    Text = "通关「灵感侵染」任意难度"
  },
  Task_96870_Desc = {
    Text = "使用血肉界域唤醒体在「异界图卷」中获胜2次"
  },
  Task_96871_Desc = {
    Text = "通关「地狱之变」癫狂难度"
  },
  Task_96872_Desc = {
    Text = "通关「梦魇堆垒」癫狂难度"
  },
  Task_96873_Desc = {
    Text = "使用超维界域唤醒体在「异界图卷」中获胜1次"
  },
  Task_97192_Desc = {
    Text = "累计登录 1 天"
  },
  Task_97193_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_97194_Desc = {
    Text = "累计登录 1 天"
  },
  Task_97195_Desc = {
    Text = "通关 1 次杜勒赛因试玩关卡"
  },
  Task_97196_Desc = {
    Text = "完成 2 周每周试炼"
  },
  Task_97197_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_97198_Desc = {
    Text = "消耗灵啡肽 1800 点"
  },
  Task_97199_Desc = {
    Text = "通关超验存在 1 次"
  },
  Task_97200_Desc = {
    Text = "通关超验存在 1 次"
  },
  Task_97201_Desc = {
    Text = "消耗灵啡肽 1800 点"
  },
  Task_97202_Desc = {
    Text = "完成 3 次每日试训"
  },
  Task_97203_Desc = {
    Text = "通关 1 次杜勒赛因试玩关卡"
  },
  Task_97243_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_97244_Desc = {
    Text = "完成 2 周每周试炼"
  },
  Task_97245_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_97246_Desc = {
    Text = "完成 3 次每日试训"
  },
  Task_97309_Desc = {
    Text = "在调查事件「@1@2」中共鸣6次"
  },
  Task_97309_Desc2 = {
    Text = "在调查事件「餍飨」中共鸣6次"
  },
  Task_97309_Name = {Text = "@1@2"},
  Task_97309_Name2 = {
    Text = "暴食回响Ⅲ"
  },
  Task_97310_Desc = {
    Text = "在调查事件「@1@2」中共鸣9次"
  },
  Task_97310_Desc2 = {
    Text = "在调查事件「餍飨」中共鸣9次"
  },
  Task_97310_Name = {Text = "@1@2"},
  Task_97310_Name2 = {
    Text = "暴食回响Ⅳ"
  },
  Task_97311_Desc = {
    Text = "在调查事件「@1@2」中共鸣2次"
  },
  Task_97311_Desc2 = {
    Text = "在调查事件「餍飨」中共鸣2次"
  },
  Task_97311_Name = {Text = "@1@2"},
  Task_97311_Name2 = {
    Text = "暴食回响"
  },
  Task_97312_Desc = {
    Text = "在调查事件「@1@2」中共鸣4次"
  },
  Task_97312_Desc2 = {
    Text = "在调查事件「餍飨」中共鸣4次"
  },
  Task_97312_Name = {Text = "@1@2"},
  Task_97312_Name2 = {
    Text = "暴食回响Ⅱ"
  },
  Task_97322_Desc = {
    Text = "在完美守护溟梦之帷时，击败「腐潮之傀」。"
  },
  Task_97322_Name = {
    Text = "一个承诺，一次守望·隐藏"
  },
  Task_97673_Desc = {
    Text = "通关「第五日」癫狂难度"
  },
  Task_97674_Desc = {
    Text = "通关「第一日」癫狂难度"
  },
  Task_97675_Desc = {
    Text = "通关「第二日」任意难度"
  },
  Task_97676_Desc = {
    Text = "创生七日·通关"
  },
  Task_97677_Desc = {
    Text = "通关「第七日」任意难度"
  },
  Task_97678_Desc = {
    Text = "使用混沌界域唤醒体在「创生七日」中获胜1次"
  },
  Task_97679_Desc = {
    Text = "完成「创生七日·通关」所有成就"
  },
  Task_97680_Desc = {
    Text = "通关「第二日」癫狂难度"
  },
  Task_97681_Desc = {
    Text = "通关「第七日」癫狂难度"
  },
  Task_97682_Desc = {
    Text = "通关「第七日」任意难度"
  },
  Task_97683_Desc = {
    Text = "通关「第六日」任意难度"
  },
  Task_97684_Desc = {
    Text = "通关「第一日」任意难度"
  },
  Task_97685_Desc = {
    Text = "通关「第三日」癫狂难度"
  },
  Task_97686_Desc = {
    Text = "使用超维界域唤醒体在「创生七日」中获胜1次"
  },
  Task_97687_Desc = {
    Text = "使用血肉界域唤醒体在「创生七日」中获胜1次"
  },
  Task_97688_Desc = {
    Text = "通关「第四日」癫狂难度"
  },
  Task_97689_Desc = {
    Text = "通关「第一日」任意难度"
  },
  Task_97690_Desc = {
    Text = "使用超维界域唤醒体在「创生七日」中获胜2次"
  },
  Task_97691_Desc = {
    Text = "通关「第四日」任意难度"
  },
  Task_97692_Desc = {
    Text = "使用深海界域唤醒体在「创生七日」中获胜1次"
  },
  Task_97693_Desc = {
    Text = "通关「第三日」任意难度"
  },
  Task_97694_Desc = {
    Text = "使用混沌界域唤醒体在「创生七日」中获胜2次"
  },
  Task_97695_Desc = {
    Text = "通关「第六日」任意难度"
  },
  Task_97696_Desc = {
    Text = "使用血肉界域唤醒体在「创生七日」中获胜2次"
  },
  Task_97697_Desc = {
    Text = "通关「第六日」癫狂难度"
  },
  Task_97698_Desc = {
    Text = "创生七日·癫狂"
  },
  Task_97699_Desc = {
    Text = "通关「第四日」任意难度"
  },
  Task_97700_Desc = {
    Text = "创生七日·界域"
  },
  Task_97701_Desc = {
    Text = "使用深海界域唤醒体在「创生七日」中获胜2次"
  },
  Task_97702_Desc = {
    Text = "通关「第二日」任意难度"
  },
  Task_97703_Desc = {
    Text = "通关「第三日」任意难度"
  },
  Task_97704_Desc = {
    Text = "通关「第五日」任意难度"
  },
  Task_97705_Desc = {
    Text = "通关「第五日」任意难度"
  },
  Task_97855_Desc = {
    Text = "使用血肉界域唤醒体在「日光下新事」中获胜1次"
  },
  Task_97856_Desc = {
    Text = "累计登录 6 天"
  },
  Task_97857_Desc = {
    Text = "累计登录 4 天"
  },
  Task_97858_Desc = {
    Text = "通关「诗意花园」癫狂难度"
  },
  Task_97859_Desc = {
    Text = "通关异梦视界「再见，永无乡」"
  },
  Task_97860_Desc = {
    Text = "累计登录 3 天"
  },
  Task_97861_Desc = {
    Text = "完成「日光下新事·通关」所有成就"
  },
  Task_97862_Desc = {
    Text = "使用混沌界域唤醒体在「日光下新事」中获胜2次"
  },
  Task_97863_Desc = {
    Text = "使用深海界域唤醒体在「日光下新事」中获胜1次"
  },
  Task_97864_Desc = {
    Text = "通关「故地重游」癫狂难度"
  },
  Task_97865_Desc = {
    Text = "日光下新事·通关"
  },
  Task_97866_Desc = {
    Text = "日光下新事·界域"
  },
  Task_97867_Desc = {
    Text = "通关「完美童话」癫狂难度"
  },
  Task_97868_Desc = {
    Text = "通关「诗意花园」任意难度"
  },
  Task_97869_Desc = {
    Text = "使用超维界域唤醒体在「日光下新事」中获胜1次"
  },
  Task_97870_Desc = {
    Text = "通关「机械之梦」任意难度"
  },
  Task_97871_Desc = {
    Text = "通关「直面黑阳」癫狂难度"
  },
  Task_97872_Desc = {
    Text = "通关「直面黑阳」任意难度"
  },
  Task_97873_Desc = {
    Text = "通关「完美童话」任意难度"
  },
  Task_97874_Desc = {
    Text = "使用血肉界域唤醒体在「日光下新事」中获胜2次"
  },
  Task_97875_Desc = {
    Text = "累计登录 5 天"
  },
  Task_97876_Desc = {
    Text = "通关「故地重游」任意难度"
  },
  Task_97877_Desc = {
    Text = "累计登录 7 天"
  },
  Task_97878_Desc = {
    Text = "通关「机械之梦」癫狂难度"
  },
  Task_97879_Desc = {
    Text = "通关「直面黑阳」任意难度"
  },
  Task_97880_Desc = {
    Text = "累计登录 2 天"
  },
  Task_97881_Desc = {
    Text = "通关「完美童话」任意难度"
  },
  Task_97882_Desc = {
    Text = "通关「机械之梦」任意难度"
  },
  Task_97883_Desc = {
    Text = "使用混沌界域唤醒体在「日光下新事」中获胜1次"
  },
  Task_97884_Desc = {
    Text = "累计登录 1 天"
  },
  Task_97885_Desc = {
    Text = "日光下新事·癫狂"
  },
  Task_97886_Desc = {Text = "7天登录"},
  Task_97887_Desc = {
    Text = "使用超维界域唤醒体在「日光下新事」中获胜2次"
  },
  Task_97888_Desc = {
    Text = "通关「故地重游」任意难度"
  },
  Task_97889_Desc = {
    Text = "使用深海界域唤醒体在「日光下新事」中获胜2次"
  },
  Task_97890_Desc = {
    Text = "通关「诗意花园」任意难度"
  },
  Task_97952_Desc = {
    Text = "通关异梦视界「再见，永无乡」"
  },
  Task_97953_Desc = {
    Text = "完成 4 次每日试训"
  },
  Task_97954_Desc = {
    Text = "通关异梦视界「再见，永无乡」"
  },
  Task_97955_Desc = {
    Text = "累计登录 1 天"
  },
  Task_97956_Desc = {
    Text = "通关超验存在 1 次"
  },
  Task_97957_Desc = {
    Text = "消耗灵啡肽 1500 点"
  },
  Task_97958_Desc = {
    Text = "完成 4 次每日试训"
  },
  Task_97959_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_97960_Desc = {
    Text = "消耗灵啡肽 1500 点"
  },
  Task_97961_Desc = {
    Text = "累计消耗 100000 蔷薇金券"
  },
  Task_97962_Desc = {
    Text = "完成 20 次派遣"
  },
  Task_97963_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_97964_Desc = {
    Text = "融灾禁区特训值达到 100"
  },
  Task_97965_Desc = {
    Text = "累计消耗 100000 蔷薇金券"
  },
  Task_97966_Desc = {
    Text = "通关超验存在 1 次"
  },
  Task_97967_Desc = {
    Text = "累计登录 1 天"
  },
  Task_98151_Desc = {
    Text = "渊海胎动·限时专属"
  },
  Task_98347_Desc = {
    Text = "在本赛季累计完成10胜"
  },
  Task_98347_Name = {Text = "10胜"},
  Task_98348_Desc = {
    Text = "在本赛季累计完成3胜"
  },
  Task_98348_Name = {Text = "3胜"},
  Task_98349_Desc = {
    Text = "在本赛季累计完成6胜"
  },
  Task_98349_Name = {Text = "6胜"},
  Task_98350_Desc = {
    Text = "在本赛季累计完成1胜"
  },
  Task_98350_Name = {Text = "1胜"},
  Task_98505_Desc = {
    Text = "完成意识潜游「不朽极昼」"
  },
  Task_98505_Name = {
    Text = "欢愉破碎之日"
  },
  Task_98700_Desc = {
    Text = "累计登录 15 天"
  },
  Task_98701_Desc = {
    Text = "完成 2 周所有每周试炼任务"
  }
})
return Text_Task
