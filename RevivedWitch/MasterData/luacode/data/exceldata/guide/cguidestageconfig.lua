-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/guide/cguidestageconfig.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local cguidestageconfig = {}
cguidestageconfig.Data = {
[101] = {id = 101, type = 1, direction = "Up", wordId = 2301032, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 5, 
GuideFrame = {"character.newcharacterinfodialog", "MenuBtn"}
}
, 
[102] = {id = 102, type = 1, direction = "Up", wordId = 2301033, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"fastmenu.fastmenudialog", "Back/HomeBtn"}
}
, 
[201] = {id = 201, type = 1, direction = "Down", wordId = 2301026, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 1, 
GuideFrame = {"base.basemainmenudialog", "CharInfo"}
}
, 
[202] = {id = 202, type = 2, direction = "Down", wordId = 2301027, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 2, 
GuideFrame = {"1"}
}
, 
[203] = {id = 203, type = 1, direction = "Down", wordId = 2301028, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 3, 
GuideFrame = {"character.newcharacterinfodialog", "BackGround/RightPanel/LevelUp"}
}
, 
[204] = {id = 204, type = 3, direction = "Down", wordId = 2301029, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"character.newcharacterinfodialog", "BackGround/Frame/CharLevelUp/LevelUpBtn"}
}
, 
[301] = {id = 301, type = 1, direction = "Up", wordId = 2301064, profileId = 12398, raycastTarget = 1, hideBlack = 1, event = 31, 
GuideFrame = {"0"}
}
, 
[302] = {id = 302, type = 21, direction = "Up", wordId = 2301065, profileId = 12398, raycastTarget = 1, hideBlack = 0, event = 31, 
GuideFrame = {"1"}
}
, 
[303] = {id = 303, type = 21, direction = "Up", wordId = 2301066, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 40, 
GuideFrame = {"5"}
}
, 
[304] = {id = 304, type = 1, direction = "Up", wordId = 2301067, profileId = 12398, raycastTarget = 1, hideBlack = 1, event = 31, 
GuideFrame = {"0"}
}
, 
[305] = {id = 305, type = 21, direction = "Up", wordId = 2301068, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 41, 
GuideFrame = {"4"}
}
, 
[306] = {id = 306, type = 1, direction = "Up", wordId = 2301069, profileId = 12398, raycastTarget = 1, hideBlack = 1, event = 31, 
GuideFrame = {"0"}
}
, 
[307] = {id = 307, type = 1, direction = "Up", wordId = 2301070, profileId = 12398, raycastTarget = 1, hideBlack = 1, event = 8, 
GuideFrame = {"0"}
}
, 
[401] = {id = 401, type = 1, direction = "Down", wordId = 2301049, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 19, 
GuideFrame = {"dungeon.dungeonhud", "Back/Char1/Guide"}
}
, 
[402] = {id = 402, type = 10, direction = "Down", wordId = 2301050, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"character.newcharacterinfodialog", "BackGround/RightPanel/Equip/EquipBtn/Guide"}
}
, 
[501] = {id = 501, type = 4, direction = "", wordId = 0, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 7, 
GuideFrame = {"base.baseinteractdialog"}
}
, 
[502] = {id = 502, type = 5, direction = "", wordId = 0, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"mainline.mainline.mainlineworlddialog"}
}
, 
[503] = {id = 503, type = 19, direction = "", wordId = 0, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {}
}
, 
[504] = {id = 504, type = 13, direction = "", wordId = 0, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"teamedit.teameditprewardialog", "Btn4"}
}
, 
[601] = {id = 601, type = 14, direction = "Down", wordId = 2301060, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {}
}
, 
[701] = {id = 701, type = 1, direction = "Up", wordId = 2301056, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 15, 
GuideFrame = {"base.basemainmenudialog", "Gacha"}
}
, 
[702] = {id = 702, type = 1, direction = "", wordId = 0, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"gacha.gachamaindialog", "Frame/GachaMainCell(Clone)/First"}
}
, 
[801] = {id = 801, type = 1, direction = "Down", wordId = 2301071, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"dungeon.dungeonnextfloordialog", "LeaveBtn"}
}
, 
[901] = {id = 901, type = 1, direction = "Up", wordId = 2301039, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 18, 
GuideFrame = {"base.basemainmenudialog", "Task"}
}
, 
[902] = {id = 902, type = 9, direction = "Up", wordId = 2301040, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {}
}
, 
[1001] = {id = 1001, type = 1, direction = "Down", wordId = 2301045, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 9, 
GuideFrame = {"teamedit.teameditprewardialog", "TeamBack/CharacterPanel/CellFrame/Pos1/Guide"}
}
, 
[1002] = {id = 1002, type = 6, direction = "Down", wordId = 2301046, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 10, 
GuideFrame = {}
}
, 
[1003] = {id = 1003, type = 1, direction = "Down", wordId = 2301047, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 11, 
GuideFrame = {"teamedit.changeteamroledialog", "Back/ConfirmBtn/Effect"}
}
, 
[1101] = {id = 1101, type = 1, direction = "Up", wordId = 2301062, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 25, 
GuideFrame = {"mainline.mainline.mainlineworlddialog", "ResourceGroupBtn/Guide"}
}
, 
[1102] = {id = 1102, type = 28, direction = "Up", wordId = 2301063, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 4, 
GuideFrame = {"1", "Frame/Back"}
}
, 
[1103] = {id = 1103, type = 1, direction = "Up", wordId = 2301095, profileId = 12398, raycastTarget = 1, hideBlack = 0, event = 8, 
GuideFrame = {"mainline.resource.resourcefloordialog", "Detail/AutoBtn"}
}
, 
[1201] = {id = 1201, type = 1, direction = "Down", wordId = 2301083, profileId = 12398, raycastTarget = 1, hideBlack = 1, event = 8, 
GuideFrame = {"0"}
}
, 
[1301] = {id = 1301, type = 1, direction = "Down", wordId = 2301048, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"teamedit.teameditprewardialog", "Btn4/Effect"}
}
, 
[1401] = {id = 1401, type = 1, direction = "Up", wordId = 2301162, profileId = 12398, raycastTarget = 1, hideBlack = 0, event = 31, 
GuideFrame = {"0"}
}
, 
[1402] = {id = 1402, type = 1, direction = "Up", wordId = 2301163, profileId = 12398, raycastTarget = 1, hideBlack = 0, event = 31, 
GuideFrame = {"0"}
}
, 
[1501] = {id = 1501, type = 1, direction = "Up", wordId = 2301044, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"dungeon.dungeonhud", "Back/Leave"}
}
, 
[1601] = {id = 1601, type = 15, direction = "Down", wordId = 2301073, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 26, 
GuideFrame = {"100"}
}
, 
[1602] = {id = 1602, type = 1, direction = "Down", wordId = 2301160, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 27, 
GuideFrame = {"magictree.magictreedialog", "TreeDetail/Cell3"}
}
, 
[1603] = {id = 1603, type = 1, direction = "Down", wordId = 2301074, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"magictree.magictreedialog", "DetailPanel/LockState/OpenBtn/Image"}
}
, 
[1701] = {id = 1701, type = 1, direction = "Down", wordId = 2301017, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 13, 
GuideFrame = {"dungeon.dungeonnextfloordialog", "Detail/GoBtn/Effect"}
}
, 
[1702] = {id = 1702, type = 1, direction = "Down", wordId = 2301018, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"teamedit.teameditprewardialog", "Btn4/Effect"}
}
, 
[1901] = {id = 1901, type = 1, direction = "Up", wordId = 2301085, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 32, 
GuideFrame = {"base.basemainmenudialog", "Friends"}
}
, 
[1902] = {id = 1902, type = 1, direction = "Down", wordId = 2301086, profileId = 12398, raycastTarget = 1, hideBlack = 1, event = 31, 
GuideFrame = {"0"}
}
, 
[1903] = {id = 1903, type = 17, direction = "Up", wordId = 2301087, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {}
}
, 
[2001] = {id = 2001, type = 18, direction = "Down", wordId = 2301088, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 33, 
GuideFrame = {}
}
, 
[2002] = {id = 2002, type = 1, direction = "Down", wordId = 2301089, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"assistbattle.choosesupportroledialog", "ConfirmBtn/Effect"}
}
, 
[2101] = {id = 2101, type = 1, direction = "Up", wordId = 2301072, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"base.basemainmenudialog", "Yard"}
}
, 
[2201] = {id = 2201, type = 22, direction = "Up", wordId = 0, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 6, 
GuideFrame = {"InteractableObjs/Char"}
}
, 
[2202] = {id = 2202, type = 1, direction = "Down", wordId = 2301150, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 46, 
GuideFrame = {"signboard.signboardmaindialog", "UI/GiftBtnBack"}
}
, 
[2203] = {id = 2203, type = 1, direction = "Down", wordId = 2301151, profileId = 12398, raycastTarget = 1, hideBlack = 0, event = 8, 
GuideFrame = {"0"}
}
, 
[2301] = {id = 2301, type = 22, direction = "Up", wordId = 2301120, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 7, 
GuideFrame = {"InteractableObjs/base_gate"}
}
, 
[2302] = {id = 2302, type = 1, direction = "Up", wordId = 2301090, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 44, 
GuideFrame = {"mainline.mainline.mainlineworlddialog", "BossRushBtn/Guide"}
}
, 
[2303] = {id = 2303, type = 26, direction = "Down", wordId = 2301157, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 45, 
GuideFrame = {"2"}
}
, 
[2304] = {id = 2304, type = 27, direction = "Up", wordId = 2301091, profileId = 12398, raycastTarget = 1, hideBlack = 0, event = 31, 
GuideFrame = {"Photo"}
}
, 
[2305] = {id = 2305, type = 27, direction = "Up", wordId = 2301092, profileId = 12398, raycastTarget = 1, hideBlack = 0, event = 8, 
GuideFrame = {"Reward"}
}
, 
[2401] = {id = 2401, type = 22, direction = "Up", wordId = 2301164, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 6, 
GuideFrame = {"InteractableObjs/Char"}
}
, 
[2402] = {id = 2402, type = 1, direction = "Down", wordId = 2301165, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 12, 
GuideFrame = {"signboard.signboardmaindialog", "UI/ChangeBtn"}
}
, 
[2403] = {id = 2403, type = 29, direction = "Down", wordId = 0, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"2"}
}
, 
[2501] = {id = 2501, type = 1, direction = "Down", wordId = 2301096, profileId = 12398, raycastTarget = 1, hideBlack = 1, event = 38, 
GuideFrame = {"0"}
}
, 
[2502] = {id = 2502, type = 1, direction = "Down", wordId = 2301097, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 37, 
GuideFrame = {"character.newcharacterinfodialog", "BackBtn"}
}
, 
[2503] = {id = 2503, type = 1, direction = "Down", wordId = 2301098, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 39, 
GuideFrame = {"character.newcharacterinfodialog", "BackGround/RightPanel/BreakBtn"}
}
, 
[2504] = {id = 2504, type = 1, direction = "Down", wordId = 2301099, profileId = 12398, raycastTarget = 1, hideBlack = 1, event = 8, 
GuideFrame = {"0"}
}
, 
[2601] = {id = 2601, type = 22, direction = "Up", wordId = 2301061, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 7, 
GuideFrame = {"InteractableObjs/base_gate"}
}
, 
[2602] = {id = 2602, type = 1, direction = "Up", wordId = 2301100, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 44, 
GuideFrame = {"mainline.mainline.mainlineworlddialog", "BossRushBtn/Guide"}
}
, 
[2603] = {id = 2603, type = 26, direction = "Up", wordId = 2301158, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"3"}
}
, 
[2701] = {id = 2701, type = 1, direction = "Down", wordId = 2301104, profileId = 12398, raycastTarget = 1, hideBlack = 1, event = 31, 
GuideFrame = {"0"}
}
, 
[2702] = {id = 2702, type = 1, direction = "Down", wordId = 2301105, profileId = 12398, raycastTarget = 1, hideBlack = 0, event = 31, 
GuideFrame = {"alchemy.alchemydialog", "ResultItemBack"}
}
, 
[2703] = {id = 2703, type = 1, direction = "Down", wordId = 2301106, profileId = 12398, raycastTarget = 1, hideBlack = 0, event = 31, 
GuideFrame = {"alchemy.alchemydialog", "Char/Add"}
}
, 
[2704] = {id = 2704, type = 1, direction = "Down", wordId = 2301107, profileId = 12398, raycastTarget = 1, hideBlack = 0, event = 8, 
GuideFrame = {"alchemy.alchemydialog", "Level"}
}
, 
[2801] = {id = 2801, type = 1, direction = "Down", wordId = 2301108, profileId = 12398, raycastTarget = 1, hideBlack = 1, event = 31, 
GuideFrame = {"0"}
}
, 
[2802] = {id = 2802, type = 1, direction = "Down", wordId = 2301109, profileId = 12398, raycastTarget = 1, hideBlack = 0, event = 31, 
GuideFrame = {"courtcabin.cabinmaindialog", "Panel/Down/Btn1"}
}
, 
[2803] = {id = 2803, type = 1, direction = "Down", wordId = 2301110, profileId = 12398, raycastTarget = 1, hideBlack = 0, event = 8, 
GuideFrame = {"courtcabin.cabinmaindialog", "Panel/Down/Btn2"}
}
, 
[3001] = {id = 3001, type = 1, direction = "", wordId = 0, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"signboard.signboardmaindialog", "BackBtn"}
}
, 
[3201] = {id = 3201, type = 1, direction = "Down", wordId = 2301168, profileId = 12398, raycastTarget = 1, hideBlack = 1, event = 31, 
GuideFrame = {"0"}
}
, 
[3301] = {id = 3301, type = 1, direction = "Down", wordId = 2301172, profileId = 12398, raycastTarget = 1, hideBlack = 0, event = 8, 
GuideFrame = {"towerv2.scene.towerv2scenedialog", "Panel/AutoBtn"}
}
, 
[3401] = {id = 3401, type = 1, direction = "Down", wordId = 2301169, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"towerv2.scene.towerv2scenedialog", "Panel/BuffBtn"}
}
, 
[4301] = {id = 4301, type = 22, direction = "Up", wordId = 2301140, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 7, 
GuideFrame = {"InteractableObjs/base_gate"}
}
, 
[4302] = {id = 4302, type = 1, direction = "Up", wordId = 2301141, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 42, 
GuideFrame = {"mainline.mainline.mainlineworlddialog", "SideStoryBtn/Guide"}
}
, 
[4303] = {id = 4303, type = 23, direction = "Up", wordId = 2301142, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 43, 
GuideFrame = {"Panel/Lock/UnLockBtn/Effect"}
}
, 
[4304] = {id = 4304, type = 24, direction = "", wordId = 0, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"confirmbox.secondconfirmdialog", "ConfirmButton", "77"}
}
, 
[4501] = {id = 4501, type = 7, direction = "Down", wordId = 2301144, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 16, 
GuideFrame = {"teamedit.teameditprewardialog@TeamBack/CharacterPanel/CellFrame/Pos6/Guide", "teamedit.teampresetmaindialog@TeamBack/CharacterPanel/CellFrame/Pos6"}
}
, 
[4502] = {id = 4502, type = 8, direction = "Down", wordId = 2301145, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 17, 
GuideFrame = {}
}
, 
[4503] = {id = 4503, type = 1, direction = "Down", wordId = 2301146, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"teamedit.changeteamroledialog", "Back/ConfirmBtn/Effect"}
}
, 
[4603] = {id = 4603, type = 25, direction = "Down", wordId = 2301143, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {}
}
, 
[4702] = {id = 4702, type = 1, direction = "Up", wordId = 2301155, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 44, 
GuideFrame = {"mainline.mainline.mainlineworlddialog", "BossRushBtn/Guide"}
}
, 
[4703] = {id = 4703, type = 26, direction = "Down", wordId = 2301159, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"7"}
}
, 
[4903] = {id = 4903, type = 26, direction = "Up", wordId = 2301156, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"1"}
}
, 
[5001] = {id = 5001, type = 1, direction = "", wordId = 0, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"gacha.gachamaindialog", "BackBtn"}
}
, 
[5101] = {id = 5101, type = 1, direction = "", wordId = 0, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"task.taskmaindialog", "BackBtn/Effect"}
}
, 
[5302] = {id = 5302, type = 1, direction = "Up", wordId = 2301051, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 20, 
GuideFrame = {"character.newcharacterinfodialog", "BackGround/RightPanel/Equip/Equip1/EquipCell"}
}
, 
[5303] = {id = 5303, type = 1, direction = "Up", wordId = 2301052, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 21, 
GuideFrame = {"equip.equipchangenewdialog", "SelectTips/TipsBack/ForgeBtn"}
}
, 
[5304] = {id = 5304, type = 11, direction = "Up", wordId = 2301053, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 22, 
GuideFrame = {}
}
, 
[5305] = {id = 5305, type = 12, direction = "Up", wordId = 2301054, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {}
}
, 
[5401] = {id = 5401, type = 13, direction = "", wordId = 0, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 23, 
GuideFrame = {"equipforge.equipforgedialog", "BackBtn"}
}
, 
[5402] = {id = 5402, type = 13, direction = "", wordId = 0, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 24, 
GuideFrame = {"equip.equipchangenewdialog", "BackBtn"}
}
, 
[5403] = {id = 5403, type = 13, direction = "", wordId = 0, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"character.newcharacterinfodialog", "BackBtn"}
}
, 
[5501] = {id = 5501, type = 16, direction = "Up", wordId = 2301075, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {}
}
, 
[5601] = {id = 5601, type = 15, direction = "Up", wordId = 2301076, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 28, 
GuideFrame = {"300"}
}
, 
[5602] = {id = 5602, type = 1, direction = "Up", wordId = 2301077, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"firefly.fireflydialog", "RightPanel/Bai/AddBtn"}
}
, 
[5701] = {id = 5701, type = 1, direction = "Up", wordId = 2301078, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"firefly.fireflydialog", "BackBtn"}
}
, 
[5801] = {id = 5801, type = 15, direction = "Down", wordId = 2301079, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 26, 
GuideFrame = {"100"}
}
, 
[5802] = {id = 5802, type = 1, direction = "Down", wordId = 2301161, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 29, 
GuideFrame = {"magictree.magictreedialog", "TreeDetail/Cell2"}
}
, 
[5803] = {id = 5803, type = 1, direction = "Down", wordId = 2301080, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"magictree.magictreedialog", "DetailPanel/LockState/OpenBtn/Image"}
}
, 
[5901] = {id = 5901, type = 15, direction = "Up", wordId = 2301081, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 30, 
GuideFrame = {"200"}
}
, 
[5902] = {id = 5902, type = 1, direction = "Up", wordId = 2301082, profileId = 12398, raycastTarget = 1, hideBlack = 1, event = 8, 
GuideFrame = {"0"}
}
, 
[6401] = {id = 6401, type = 1, direction = "Up", wordId = 2301174, profileId = 12398, raycastTarget = 1, hideBlack = 0, event = 8, 
GuideFrame = {"activity.swimsuit.swimsuitmaindialog", "Panel/Time/ChangeBtn"}
}
, 
[6501] = {id = 6501, type = 1, direction = "Down", wordId = 2301200, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 47, 
GuideFrame = {"equip.bagdialog", "GroupBtnArea/Btn4/GroupBtn"}
}
, 
[6502] = {id = 6502, type = 30, direction = "Down", wordId = 2301201, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 48, 
GuideFrame = {}
}
, 
[6503] = {id = 6503, type = 1, direction = "Down", wordId = 2301202, profileId = 12398, raycastTarget = 1, hideBlack = 0, event = 31, 
GuideFrame = {"bag.rolereset.changeselectroledialog", "Txt"}
}
, 
[6504] = {id = 6504, type = 31, direction = "Up", wordId = 2301203, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 49, 
GuideFrame = {}
}
, 
[6505] = {id = 6505, type = 1, direction = "Down", wordId = 2301204, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 8, 
GuideFrame = {"bag.rolereset.changeselectroledialog", "Back/ConfirmBtn"}
}
, 
[6601] = {id = 6601, type = 32, direction = "Down", wordId = 0, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 50, 
GuideFrame = {}
}
, 
[6602] = {id = 6602, type = 1, direction = "Down", wordId = 0, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 51, 
GuideFrame = {"activity.giftoftime.killbosscharacterinfodialog", "ExpCost/UpBtn"}
}
, 
[6603] = {id = 6603, type = 1, direction = "Down", wordId = 0, profileId = 12398, raycastTarget = 0, hideBlack = 0, event = 52, 
GuideFrame = {"confirmbox.secondconfirmdialog", "ConfirmButton"}
}
}
cguidestageconfig.AllIds = {101, 102, 201, 202, 203, 204, 301, 302, 303, 304, 305, 306, 307, 401, 402, 501, 502, 503, 504, 601, 701, 702, 801, 901, 902, 1001, 1002, 1003, 1101, 1102, 1103, 1201, 1301, 1401, 1402, 1501, 1601, 1602, 1603, 1701, 1702, 1901, 1902, 1903, 2001, 2002, 2101, 2201, 2202, 2203, 2301, 2302, 2303, 2304, 2305, 2401, 2402, 2403, 2501, 2502, 2503, 2504, 2601, 2602, 2603, 2701, 2702, 2703, 2704, 2801, 2802, 2803, 3001, 3201, 3301, 3401, 4301, 4302, 4303, 4304, 4501, 4502, 4503, 4603, 4702, 4703, 4903, 5001, 5101, 5302, 5303, 5304, 5305, 5401, 5402, 5403, 5501, 5601, 5602, 5701, 5801, 5802, 5803, 5901, 5902, 6401, 6501, 6502, 6503, 6504, 6505, 6601, 6602, 6603}
return cguidestageconfig

