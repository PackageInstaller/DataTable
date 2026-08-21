-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/message/csecondconfirm.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local csecondconfirm = {}
csecondconfirm.Data = {
[1] = {id = 1, message = "扣除道具不足，是否前往商城购买？", messageTextID = 700296, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "前往商城", rightbuttonTextID = 700352, count = 0}
, 
[2] = {id = 2, message = "待分解装备中含有传奇品质装备，是否确认分解？", messageTextID = 700297, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "分解", rightbuttonTextID = 700353, count = 0}
, 
[3] = {id = 3, message = "确认解散该队伍？", messageTextID = 700298, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[4] = {id = 4, message = "是否使用$parameter1$", messageTextID = 700299, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[5] = {id = 5, message = "确定删除该邮件？", messageTextID = 700300, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "删除", rightbuttonTextID = 700355, count = 0}
, 
[6] = {id = 6, message = "确认删除所有已读邮件？", messageTextID = 700301, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "删除", rightbuttonTextID = 700355, count = 0}
, 
[7] = {id = 7, message = "确定花费$parameter1$购买$parameter2$个$parameter3$吗？", messageTextID = 700302, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "购买", rightbuttonTextID = 700356, count = 0}
, 
[8] = {id = 8, message = "是否确认突破角色等级上限？", messageTextID = 700303, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[9] = {id = 9, message = "当前等级已到达上限，是否前往突破？", messageTextID = 700304, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[10] = {id = 10, message = "确定消耗$parameter1$$parameter2$进行召唤？（剩余数量：$parameter3$）", messageTextID = 700305, messagetype = 1, leftbutton = "再想想", leftbuttonTextID = 700350, rightbutton = "召唤", rightbuttonTextID = 700357, count = 0}
, 
[11] = {id = 11, message = "确定消耗$parameter1$$parameter2$进行十连召唤？", messageTextID = 700306, messagetype = 1, leftbutton = "再想想", leftbuttonTextID = 700350, rightbutton = "召唤", rightbuttonTextID = 700357, count = 0}
, 
[12] = {id = 12, message = "确定消耗$parameter1$$parameter2$，在$parameter3$召唤池再次进行$parameter4$吗？", messageTextID = 700307, messagetype = 1, leftbutton = "再想想", leftbuttonTextID = 700350, rightbutton = "召唤", rightbuttonTextID = 700357, count = 0}
, 
[13] = {id = 13, message = "此装备已被$parameter1$使用，确定继续装备吗？", messageTextID = 700308, messagetype = 1, leftbutton = "再想想", leftbuttonTextID = 700350, rightbutton = "装备", rightbuttonTextID = 700358, count = 0}
, 
[14] = {id = 14, message = "无法连接服务器，请检查您的网络状况。$B$（错误代码：$parameter1$）", messageTextID = 700309, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "重新连接", rightbuttonTextID = 700359, count = 0}
, 
[15] = {id = 15, message = "当前钻石不足，是否前往充值？", messageTextID = 700310, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[16] = {id = 16, message = "确认删除该好友吗？与该好友的聊天记录也将消失。", messageTextID = 700311, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[17] = {id = 17, message = "确认将该玩家转移至黑名单吗？", messageTextID = 700312, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[18] = {id = 18, message = "确认拒绝该好友申请吗？", messageTextID = 700313, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[19] = {id = 19, message = "灵魂炼成将永久销毁该角色，是否确认操作？", messageTextID = 700314, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[20] = {id = 20, message = "该角色为SSR角色，灵魂炼成将永久销毁角色，是否确认操作？", messageTextID = 700315, messagetype = 2, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 5}
, 
[21] = {id = 21, message = "当前玛那不足，是否前往兑换？", messageTextID = 700316, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[22] = {id = 22, message = "是否确认刷新？", messageTextID = 700317, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[23] = {id = 23, message = "确认消耗一个补签道具进行补签？", messageTextID = 700318, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[24] = {id = 24, message = "是否消耗贵重装备进行熔炼", messageTextID = 700319, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[25] = {id = 25, message = "新属性优于原属性，是否不替换属性，直接进行重铸？", messageTextID = 700320, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[26] = {id = 26, message = "是否替换属性？", messageTextID = 700321, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[27] = {id = 27, message = "是否确认召唤结果（确认后，获得此次召唤的角色，并且不能再次进行初回限定召唤）？", messageTextID = 700322, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[28] = {id = 28, message = "是否取消当前编制，恢复为变更前状态？", messageTextID = 700323, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[29] = {id = 29, message = "装备已满，请先进行装备分解。是否跳转至装备包裹？", messageTextID = 700324, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[30] = {id = 30, message = "技能已满，请先进行技能分解。是否跳转至技能包裹？", messageTextID = 700325, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[31] = {id = 31, message = "是否消耗$parameter1$钻石兑换$parameter2$灵魂，并进行召唤？", messageTextID = 700326, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[32] = {id = 32, message = "是否刷新此任务？当前的完成进度将丢失。", messageTextID = 700327, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[33] = {id = 33, message = "是否进入下一场景？", messageTextID = 700328, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[34] = {id = 34, message = "是否完成当前区域探索？", messageTextID = 700329, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[35] = {id = 35, message = "确认要撤退吗？", messageTextID = 700330, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[36] = {id = 36, message = "确认要结束探索吗？", messageTextID = 700331, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[37] = {id = 37, message = "是否分解当前装备？", messageTextID = 700332, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "分解", rightbuttonTextID = 700353, count = 0}
, 
[38] = {id = 38, message = "任务进行中无法更换，是否要终止任务？", messageTextID = 700333, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[39] = {id = 39, message = "前方有较困难的战斗，确定要前进吗？$B$（推荐等级：突破$parameter1$ Lv.$parameter2$）", messageTextID = 700334, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[40] = {id = 40, message = "确认将该玩家移出黑名单吗？", messageTextID = 700335, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[41] = {id = 41, message = "是否返回初始之间？", messageTextID = 700336, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[42] = {id = 42, message = "是否删除本条评论？", messageTextID = 700337, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[43] = {id = 43, message = "将会移除房间内所有家具，确认移除？", messageTextID = 700338, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[44] = {id = 44, message = "将会重置本次所做的所有改动，确认重置？", messageTextID = 700339, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[45] = {id = 45, message = "确认保存当前家具配置？", messageTextID = 700340, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[46] = {id = 46, message = "是否删除当前自定义主题？", messageTextID = 700341, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[47] = {id = 47, message = "前方有较困难的战斗，确定要前进吗？$B$（推荐等级：Lv.14）", messageTextID = 700342, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[48] = {id = 48, message = "是否结束副本？", messageTextID = 700343, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[49] = {id = 49, message = "是否进入下一层？", messageTextID = 700344, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[50] = {id = 50, message = "是否结束副本？", messageTextID = 700345, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[51] = {id = 51, message = "选中材料包含<color=#e25630ff>已强化过的装备</color>$B$是否确认强化？", messageTextID = 700346, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[52] = {id = 52, message = "选中材料包含<color=#e25630ff>金色以上品质装备</color>$B$是否确认强化？", messageTextID = 700347, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[53] = {id = 53, message = "选中材料包含<color=#e25630ff>已强化过的装备和金色以上品质装备</color>$B$是否确认强化？", messageTextID = 700348, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[54] = {id = 54, message = "本次抽卡结果有UR角色，是否仍要再次召唤？", messageTextID = 700603, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[55] = {id = 55, message = "附魔后其他属性将无法进行附魔，确认附魔？", messageTextID = 700640, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[56] = {id = 56, message = "选中材料包含<color=#e25630ff>已强化过的装备</color>$B$是否确认突破？", messageTextID = 700673, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[57] = {id = 57, message = "选中材料包含<color=#e25630ff>金色以上品质装备</color>$B$是否确认突破？", messageTextID = 700674, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[58] = {id = 58, message = "选中材料包含<color=#e25630ff>已强化过的装备和金色以上品质装备</color>$B$是否确认突破？", messageTextID = 700675, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[59] = {id = 59, message = "是否回到初始之间？", messageTextID = 700678, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[60] = {id = 60, message = "本层未探索完全，是否放弃探索，并进入下一层？", messageTextID = 700679, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[61] = {id = 61, message = "本层未探索完全，是否放弃探索，并离开副本？", messageTextID = 700680, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[62] = {id = 62, message = "是否消耗$parameter1$<sprite=0> 为 $parameter2$ 购买外观 $parameter3$", messageTextID = 700699, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "购买", rightbuttonTextID = 700700, count = 0}
, 
[63] = {id = 63, message = "您的外观券不足，是否购买外观券？", messageTextID = 700701, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[64] = {id = 64, message = "是否使用<sprite=0>$parameter1$ 购买 <sprite=16>$parameter2$", messageTextID = 700702, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "购买", rightbuttonTextID = 700700, count = 0}
, 
[65] = {id = 65, message = "当前阵容中，存在<color=#FF5D5D>精力未满</color>或<color=#FF5D5D>庭院技能不为异界之镜的人偶</color>，是否以当前阵容开始任务？", messageTextID = 700720, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[66] = {id = 66, message = "是否确认重置机关，并返回初始位置？", messageTextID = 700736, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[67] = {id = 67, message = "是否消耗$parameter1$<sprite=16> 为 $parameter2$ 购买外观 $parameter3$", messageTextID = 700746, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "购买", rightbuttonTextID = 700700, count = 0}
, 
[68] = {id = 68, message = "队伍中有位置仅有替补角色$B$是否自动补位？", messageTextID = 700749, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[69] = {id = 69, message = "当前队伍中存在空位，是否直接进入地宫？", messageTextID = 700753, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[70] = {id = 70, message = "该角色正在替补中，是否替换？", messageTextID = 700758, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[71] = {id = 71, message = "该角色正在编成中，是否替换？", messageTextID = 700759, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[72] = {id = 72, message = "下载语音需要消耗$parameter1$MB，是否立刻下载？", messageTextID = 700773, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[73] = {id = 73, message = "更新语音需要消耗$parameter1$MB，是否立刻下载？", messageTextID = 700774, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[74] = {id = 74, message = "等级<color=#DF4242ff>到达上限</color>的人偶训练经验将转换为$B$<color=#DF4242ff>玛那</color>x$parameter1$。$B$是否开始训练？", messageTextID = 700782, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[75] = {id = 75, message = "已经消耗的道具<color=#DF4242ff>无法返还</color>，人偶经验<color=#DF4242ff>不会增加</color>。$B$是否中止训练？", messageTextID = 700783, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[76] = {id = 76, message = "$parameter1$的进度将被重置，并可重新游玩。$B$是否重置进度？$B$*再次游玩无需消耗精神但没有奖励。", messageTextID = 700788, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[77] = {id = 77, message = "是否消耗$parameter1$ X 1$B$解锁$parameter2$-$parameter3$？", messageTextID = 700789, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[78] = {id = 78, message = "$parameter1$数量不足$B$是否去$parameter2$获取？", messageTextID = 700790, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[79] = {id = 79, message = "当前处于移动网络，下载语音需要花费$parameter1$MB流量，是否继续下载？", messageTextID = 700804, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[80] = {id = 80, message = "语音下载失败：下载分包资源的version.meta失败。", messageTextID = 700805, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "重试", rightbuttonTextID = 700812, count = 0}
, 
[81] = {id = 81, message = "语音下载失败：下载patch.meta失败。", messageTextID = 700806, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "重试", rightbuttonTextID = 700812, count = 0}
, 
[82] = {id = 82, message = "语音下载失败：检查更新文件失败。", messageTextID = 700807, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "重试", rightbuttonTextID = 700812, count = 0}
, 
[83] = {id = 83, message = "语音下载失败：下载差异包失败", messageTextID = 700808, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "重试", rightbuttonTextID = 700812, count = 0}
, 
[84] = {id = 84, message = "语音下载失败：合并文件失败。", messageTextID = 700809, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "重试", rightbuttonTextID = 700812, count = 0}
, 
[85] = {id = 85, message = "是否确认加入$parameter1$阵营？", messageTextID = 700814, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[86] = {id = 86, message = "本次附魔至少获得一条最高等级词缀，是否确认附魔？", messageTextID = 700826, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[87] = {id = 87, message = "本次附魔存在等级S及以上词缀，是否放弃本次附魔？", messageTextID = 700827, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[88] = {id = 88, message = "当前装备存在等级S及以上的词缀，是否确定附魔？", messageTextID = 700828, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[89] = {id = 89, message = "该人偶好感度<color=#DF4242ff>已达等级上限</color>，送礼后好感度<color=#DF4242ff>不再增加</color>。是否继续送礼物？", messageTextID = 700869, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700350, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[90] = {id = 90, message = "发现新资源$B$总共$parameter1$KB$B$建议使用wifi进行下载", messageTextID = 700882, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700350, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[91] = {id = 91, message = "发现新资源$B$总共$parameter1$MB$B$建议使用wifi进行下载", messageTextID = 700883, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700350, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[92] = {id = 92, message = "下载过程中出现异常$B$剩余$parameter1KB$B$请检查网络连接", messageTextID = 700884, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700350, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[93] = {id = 93, message = "下载过程中出现异常$B$剩余$parameter1MB$B$请检查网络连接", messageTextID = 700885, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700350, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[94] = {id = 94, message = "部分文件校验失败，需要重新下载$B$总共$parameter1$KB$B$建议使用wifi进行下载", messageTextID = 700886, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700350, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[95] = {id = 95, message = "部分文件校验失败，需要重新下载$B$总共$parameter1$MB$B$建议使用wifi进行下载", messageTextID = 700887, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700350, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[96] = {id = 96, message = "合并文件失败$B$存储空间不足，请清理后重试", messageTextID = 700888, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700350, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[97] = {id = 97, message = "本关卡难度较大，请合理搭配阵容，当前缺少可提供输出的人偶，是否确认使用该阵容出战？", messageTextID = 700903, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700350, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[98] = {id = 98, message = "本关卡难度较大，请合理搭配阵容，当前缺少可提供治疗的人偶，是否确认使用该阵容出战？", messageTextID = 700904, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700350, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[99] = {id = 99, message = "本次召唤<color=#FC3333>未获得UR人偶，建议继续召唤。</color>$B$是否确认召唤结果，获得此次召唤的角色?$B$（确认后，将无法再次进行初回限定召唤）", messageTextID = 700905, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700350, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[100] = {id = 100, message = "前方有较困难的战斗，确定要前进吗？$B$（推荐等级：Lv.8）", messageTextID = 700912, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[101] = {id = 101, message = "是否退出游戏？", messageTextID = 700925, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[102] = {id = 102, message = "是否消耗<color=#DF4242ff>$parameter1$x$parameter2$</color>开始训练？", messageTextID = 700929, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[103] = {id = 103, message = "确认要移除这名成员吗？", messageTextID = 700977, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[104] = {id = 104, message = "确认要解散集会吗？", messageTextID = 700978, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[105] = {id = 105, message = "确认要退出集会吗？\n（退出后12小时内不可再次加入集会呦）", messageTextID = 700979, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[106] = {id = 106, message = "确定要更改审核条件吗？", messageTextID = 700980, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[107] = {id = 107, message = "确定要委任$parameter1$为会长吗？\n（委任后您将失去会长权限）", messageTextID = 700981, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[108] = {id = 108, message = "当前灵魂不足，是否前往购买？", messageTextID = 701009, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[109] = {id = 109, message = "是否跳转到通知设置？", messageTextID = 701013, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[110] = {id = 110, message = "人偶等级过低，建议优先培养人偶。$B$是否前往升级人偶。推荐等级：突破$parameter1$ Lv.$parameter2$）", messageTextID = 701026, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[111] = {id = 111, message = "当前选择的材料装备是已强化装备，是否确定消耗该装备进行突破？", messageTextID = 701031, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[112] = {id = 112, message = "前方有较困难的战斗，确定要前进吗？$B$（推荐等级：Lv.$parameter1$）", messageTextID = 701061, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[113] = {id = 113, message = "人偶等级过低，建议优先培养人偶。$B$是否前往升级人偶。推荐等级：Lv.$parameter1$）", messageTextID = 701062, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[114] = {id = 114, message = "下载该人偶展示资源需要消耗$parameter1$MB，是否立刻下载？", messageTextID = 701067, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[115] = {id = 115, message = "更新该人偶展示资源需要消耗$parameter1$MB，是否立刻下载？", messageTextID = 701068, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[116] = {id = 116, message = "恭喜您通关本周的事象限界。", messageTextID = 701083, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[117] = {id = 117, message = "当前阵容不合理，直接挑战很有可能失败，是否确认前往？", messageTextID = 701151, messagetype = 1, leftbutton = "确认前往", leftbuttonTextID = 701153, rightbutton = "自动编队", rightbuttonTextID = 701152, count = 0}
, 
[118] = {id = 118, message = "本次附魔解锁了新的词缀栏位，$B$<color=#FC3333>该栏位一旦确定，无法再次被附魔替换</color>$B$是否确认本次附魔结果？", messageTextID = 701154, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确认替换", rightbuttonTextID = 701155, count = 0}
, 
[119] = {id = 119, message = "确定强化$parameter1$到Lv.$parameter1$吗?", messageTextID = 701211, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "强化", rightbuttonTextID = 701212, count = 0}
, 
[120] = {id = 120, message = "CG可在活动期间通过完成拼图获取，是否跳转至活动页面？", messageTextID = 701263, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[121] = {id = 121, message = "是否消耗$parameter1$<sprite=6> 补齐该拼图？", messageTextID = 701264, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[122] = {id = 122, message = "食用$parameter1$，回复$parameter2$精神，是否确定？$B$\n回复后精神：$parameter3$/$parameter4$", messageTextID = 701370, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[123] = {id = 123, message = "是否确定兑换人偶$parameter1$？", messageTextID = 701493, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[124] = {id = 124, message = "通关后将扣除一点人偶体力，是否确认出战？", messageTextID = 701546, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[125] = {id = 125, message = "选择一键装备最高评分装备或预设装备？", messageTextID = 701594, messagetype = 1, leftbutton = "最高评分装备", leftbuttonTextID = 701595, rightbutton = "预设装备", rightbuttonTextID = 701596, count = 0}
, 
[126] = {id = 126, message = "是否清空当前预设装备？", messageTextID = 701597, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[127] = {id = 127, message = "参与圣诞宴会，回复$parameter1$精神，是否确定？$B$\n回复后精神：$parameter2$/$parameter3$", messageTextID = 701655, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[128] = {id = 128, message = "请先通关前一篇章的事象记忆", messageTextID = 701656, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[129] = {id = 129, message = "已经获取当前支线里所有加成道具，继续挑战只会获得活动货币奖励，是否确定前往？", messageTextID = 701659, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[130] = {id = 130, message = "食用$parameter1$，回复$parameter2$福，是否确定？$B$\n回复后福：$parameter3$/$parameter4$", messageTextID = 701683, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[131] = {id = 131, message = "撤退仍会消耗挑战次数且进行奖励结算$B$\n确认要撤退吗？", messageTextID = 701684, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[132] = {id = 132, message = "人气值已满，确认要为她送上鲜花吗？", messageTextID = 701740, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[133] = {id = 133, message = "确认将人偶<color=#CFB53B>$parameter1$</color>重塑吗？", messageTextID = 701780, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[134] = {id = 134, message = "是否确认选择元素$parameter1$？（确认之后无法再更改）", messageTextID = 701804, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[135] = {id = 135, message = "是否确认分解专属装备？$B$<color=#FC3333>专属装备升级需要消耗专属装备</color>", messageTextID = 701829, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[136] = {id = 136, message = "是否消耗$parameter1$$parameter2$恢复$parameter3$的剩余次数？", messageTextID = 701866, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[137] = {id = 137, message = "是否将$parameter1$幸运铜币替换为$parameter2$玛那", messageTextID = 701913, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[138] = {id = 138, message = "是否中止派遣战斗？", messageTextID = 701971, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[139] = {id = 139, message = "是否解锁该技能？", messageTextID = 702016, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[140] = {id = 140, message = "解锁该技能后无法解锁另一分支技能，是否确认？", messageTextID = 702017, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[141] = {id = 141, message = "活动期间仅可购买一种，是否花费<sprite=0>$parameter1$进行购买？", messageTextID = 702037, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[142] = {id = 142, message = "当前无法解锁新的难度，\n是否继续挑战？", messageTextID = 702224, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[143] = {id = 143, message = "活动期间仅可购买一种，是否花费<sprite=0>$parameter1$进行购买？（当前活动剩余时间无法领取完所有返利）", messageTextID = 702075, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[144] = {id = 144, message = "是否消耗<sprite=0>$parameter1$解锁？", messageTextID = 702115, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[145] = {id = 145, message = "是否消耗<sprite=6>$parameter1$进行补签？", messageTextID = 702124, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[146] = {id = 146, message = "当前升级道具不足，是否跳转至每日任务获取？", messageTextID = 702132, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[147] = {id = 147, message = "已拥有该外观，购买后将返还$parameter1$钻石，是否继续购买？", messageTextID = 702266, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[148] = {id = 148, message = "是否花费<sprite=0>$parameter1$解锁进阶版？", messageTextID = 702537, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[149] = {id = 149, message = "是否确认选择该人偶？", messageTextID = 702539, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[150] = {id = 150, message = "是否跳过战斗直接对$parameter1$造成$parameter2$伤害？", messageTextID = 702569, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
, 
[151] = {id = 151, message = "今日积分获得已达上限，胜利无法继续获得积分，失败仍会扣减积分，是否继续？", messageTextID = 702579, messagetype = 1, leftbutton = "取消", leftbuttonTextID = 700349, rightbutton = "确定", rightbuttonTextID = 700354, count = 0}
}
csecondconfirm.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151}
return csecondconfirm

