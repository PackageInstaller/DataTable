-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/ui/cgmhideui.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cgmhideui = {}
cgmhideui.Data = {
[1] = {id = 1, uIname = 1228, uInameRemark = "暂停图标", scene = 1, layoutName = "BattleNewMain", fileName = "newbattle.battlenewmaindialog", nodePath = "PauseBtn,LeaveBtn", defaultDisplay = 1}
, 
[2] = {id = 2, uIname = 1229, uInameRemark = "战斗胜利图标", scene = 1, layoutName = "BattleNewMain", fileName = "newbattle.battlenewmaindialog", nodePath = "WinBtn", defaultDisplay = 1}
, 
[3] = {id = 3, uIname = 1230, uInameRemark = "战斗失败图标", scene = 1, layoutName = "BattleNewMain", fileName = "newbattle.battlenewmaindialog", nodePath = "LoseBtn", defaultDisplay = 1}
, 
[4] = {id = 4, uIname = 1231, uInameRemark = "战斗信息图标", scene = 1, layoutName = "BattleNewMain", fileName = "newbattle.battlenewmaindialog", nodePath = "DetailBtn,GMBtn,Element", defaultDisplay = 1}
, 
[5] = {id = 5, uIname = 1232, uInameRemark = "血条UI", scene = 1, layoutName = "BattleNewMain", fileName = "newbattle.battlenewmaindialog", nodePath = "HPCell", defaultDisplay = 1}
, 
[7] = {id = 7, uIname = 1234, uInameRemark = "技能图标", scene = 1, layoutName = "BattleNewMain", fileName = "newbattle.battlenewmaindialog", nodePath = "SkillPanel", defaultDisplay = 1}
, 
[8] = {id = 8, uIname = 1235, uInameRemark = "能量UI", scene = 1, layoutName = "BattleNewMain", fileName = "newbattle.battlenewmaindialog", nodePath = "BattleProgressBack,BattleEnergyBtn", defaultDisplay = 1}
, 
[10] = {id = 10, uIname = 1237, uInameRemark = "伤害数字", scene = 1, layoutName = "BattleNewMain", fileName = "newbattle.battlenewmaindialog", nodePath = "DamageNum", defaultDisplay = 1}
, 
[11] = {id = 11, uIname = 1238, uInameRemark = "角色头像1", scene = 2, layoutName = "DungeonHUD", fileName = "dungeon.dungeonhud", nodePath = "Back/Char1", defaultDisplay = 1}
, 
[12] = {id = 12, uIname = 1260, uInameRemark = "角色头像2", scene = 2, layoutName = "DungeonHUD", fileName = "dungeon.dungeonhud", nodePath = "Back/Char2", defaultDisplay = 1}
, 
[13] = {id = 13, uIname = 1261, uInameRemark = "角色头像3", scene = 2, layoutName = "DungeonHUD", fileName = "dungeon.dungeonhud", nodePath = "Back/Char3", defaultDisplay = 1}
, 
[14] = {id = 14, uIname = 1239, uInameRemark = "战利品图标", scene = 2, layoutName = "DungeonHUD", fileName = "dungeon.dungeonhud", nodePath = "Back/BagListBtn", defaultDisplay = 1}
, 
[15] = {id = 15, uIname = 1240, uInameRemark = "GM指令图标", scene = 2, layoutName = "DungeonHUD", fileName = "dungeon.dungeonhud", nodePath = "GM", defaultDisplay = 1}
, 
[16] = {id = 16, uIname = 1241, uInameRemark = "小地图UI", scene = 2, layoutName = "DungeonHUD", fileName = "dungeon.dungeonhud", nodePath = "MapArea,Back/NameBack,Back/Name,Back/Leave", defaultDisplay = 1}
, 
[17] = {id = 17, uIname = 1262, uInameRemark = "小地图背景", scene = 2, layoutName = "DungeonHUD", fileName = "dungeon.dungeonhud", nodePath = "MapBack", defaultDisplay = 1}
, 
[18] = {id = 18, uIname = 1242, uInameRemark = "聊天图标", scene = 2, layoutName = "DungeonHUD", fileName = "dungeon.dungeonhud", nodePath = "Back/ChatBtn", defaultDisplay = 1}
, 
[19] = {id = 19, uIname = 1243, uInameRemark = "交互状态UI", scene = 2, layoutName = "DungeonAct1", fileName = "dungeon.dungeonact", nodePath = "", defaultDisplay = 1}
, 
[20] = {id = 20, uIname = 1244, uInameRemark = "摇杆UI", scene = 2, layoutName = "ControlStick", fileName = "dungeon.rockerdialog", nodePath = "", defaultDisplay = 1}
, 
[21] = {id = 21, uIname = 1245, uInameRemark = "角色及名称", scene = 3, layoutName = "BaseMainHUD", fileName = "base.basemainui", nodePath = "PlayerInfo", defaultDisplay = 1}
, 
[22] = {id = 22, uIname = 1246, uInameRemark = "资源显示UI", scene = 3, layoutName = "BaseMainHUD", fileName = "base.basemainui", nodePath = "TopGroup", defaultDisplay = 1}
, 
[23] = {id = 23, uIname = 1247, uInameRemark = "设置图标", scene = 3, layoutName = "BaseMainHUD", fileName = "base.basemainui", nodePath = "MenuBtn", defaultDisplay = 1}
, 
[24] = {id = 24, uIname = 1248, uInameRemark = "GM指令图标", scene = 3, layoutName = "BaseMainHUD", fileName = "base.basemainui", nodePath = "GM", defaultDisplay = 1}
, 
[25] = {id = 25, uIname = 1249, uInameRemark = "文字UI", scene = 3, layoutName = "BaseInteract", fileName = "base.baseinteractdialog", nodePath = "", defaultDisplay = 1}
, 
[26] = {id = 26, uIname = 1250, uInameRemark = "左下角功能区", scene = 3, layoutName = "BaseMainMenu", fileName = "base.basemainmenudialog", nodePath = "", defaultDisplay = 1}
, 
[27] = {id = 27, uIname = 1251, uInameRemark = "邮件图标", scene = 3, layoutName = "BaseMainHUD", fileName = "base.basemainui", nodePath = "Mail", defaultDisplay = 1}
, 
[28] = {id = 28, uIname = 1252, uInameRemark = "聊天图标", scene = 3, layoutName = "BaseMainHUD", fileName = "base.basemainui", nodePath = "Chat", defaultDisplay = 1}
, 
[29] = {id = 29, uIname = 1255, uInameRemark = "点击特效", scene = 3, layoutName = "ClickEffectPoint", fileName = "clickeffect.clickeffectdialog", nodePath = "", defaultDisplay = 1}
, 
[30] = {id = 30, uIname = 1256, uInameRemark = "角色交互状态UI", scene = 2, layoutName = "DungeonAct1", fileName = "npc.npcactbutton", nodePath = "", defaultDisplay = 1}
, 
[31] = {id = 31, uIname = 1257, uInameRemark = "好友图标", scene = 3, layoutName = "BaseMainHUD", fileName = "base.basemainui", nodePath = "Friends", defaultDisplay = 1}
, 
[32] = {id = 32, uIname = 1258, uInameRemark = "福利图标", scene = 3, layoutName = "BaseMainHUD", fileName = "base.basemainui", nodePath = "Welfare", defaultDisplay = 1}
, 
[33] = {id = 33, uIname = 1259, uInameRemark = "商城图标", scene = 3, layoutName = "BaseMainHUD", fileName = "base.basemainui", nodePath = "Shop,FirstRecharge", defaultDisplay = 1}
, 
[34] = {id = 34, uIname = 1263, uInameRemark = "支援攻击图标", scene = 1, layoutName = "BattleNewMain", fileName = "newbattle.battlenewmaindialog", nodePath = "BattleAssistBack", defaultDisplay = 1}
, 
[35] = {id = 35, uIname = 1264, uInameRemark = "顶部图标", scene = 1, layoutName = "BattleNewMain", fileName = "newbattle.battlenewmaindialog", nodePath = "HPBar", defaultDisplay = 1}
, 
[36] = {id = 36, uIname = 1265, uInameRemark = "自动战斗图标", scene = 1, layoutName = "BattleNewMain", fileName = "newbattle.battlenewmaindialog", nodePath = "AutoBtn", defaultDisplay = 1}
, 
[37] = {id = 37, uIname = 1266, uInameRemark = "战斗速度图标", scene = 1, layoutName = "BattleNewMain", fileName = "newbattle.battlenewmaindialog", nodePath = "SpeedBtn", defaultDisplay = 1}
, 
[38] = {id = 38, uIname = 1280, uInameRemark = "活动图标", scene = 3, layoutName = "BaseMainHUD", fileName = "base.basemainui", nodePath = "Active,Activity", defaultDisplay = 1}
, 
[39] = {id = 39, uIname = 1283, uInameRemark = "自动战斗选中状态", scene = 1, layoutName = "BattleNewMain", fileName = "newbattle.battlenewmaindialog", nodePath = "AutoBtnCancel,Auto", defaultDisplay = 1}
}
cgmhideui.AllIds = {1, 2, 3, 4, 5, 7, 8, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39}
return cgmhideui

