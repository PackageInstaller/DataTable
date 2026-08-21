-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\UIConst.lua

local UIConst = GLDeclare("UIConst", {})

UIConst.UIMap = require("UI/UIMap")
UIConst.STATE_MAP = require("UI/UIStateVisible")
UIConst.AnchorPresets = Framework.UI.AnchorPresets
UIConst.TXTALIGN_UL = UnityEngine.TextAnchor.UpperLeft
UIConst.TXTALIGN_UC = UnityEngine.TextAnchor.UpperCenter
UIConst.TXTALIGN_UR = UnityEngine.TextAnchor.UpperRight
UIConst.TXTALIGN_ML = UnityEngine.TextAnchor.MiddleLeft
UIConst.TXTALIGN_MC = UnityEngine.TextAnchor.MiddleCenter
UIConst.TXTALIGN_MR = UnityEngine.TextAnchor.MiddleRight
UIConst.TXTALIGN_LL = UnityEngine.TextAnchor.LowerLeft
UIConst.TXTALIGN_LC = UnityEngine.TextAnchor.LowerCenter
UIConst.TXTALIGN_LR = UnityEngine.TextAnchor.LowerRight
UIConst.ControlTypeText = 1
UIConst.ControlTypeButton = 2
UIConst.ControlTypeDropdown = 3
UIConst.ControlTypeImage = 4
UIConst.ControlTypeInputField = 5
UIConst.ControlTypeRawImage = 6
UIConst.ControlTypeScrollbar = 7
UIConst.ControlTypeScrollRect = 8
UIConst.ControlTypeScrollRectUVImage = 9
UIConst.ControlTypeSlider = 10
UIConst.ControlTypeToggle = 11
UIConst.ControlTypeLoopScrollRectHorizontal = 12
UIConst.ControlTypeLoopScrollRectVertical = 13
UIConst.ControlTypeLayoutElement = 14
UIConst.ControlTypeFrameAni = 15
UIConst.ControlTypeRectMask2D = 16
UIConst.ControlTypeEmojiText = 17
UIConst.ControlTypeUIAni = 18
UIConst.ControlTypeMsgMovePool = 19
UIConst.ControlTypeTextNumberJumper = 20
UIConst.ControlTypeClickUI = 21
UIConst.ControlTypeWordPuzzleLogic = 22
UIConst.ControlTypeGameObject = 23
UIConst.ControlTypeETCButton = 24
UIConst.ControlTypeLazyEffectPlayer = 25
UIConst.ControlTypeUIMaterialProgressBase = 26
UIConst.ControlTypeNumberKeyboard = 27
UIConst.AbilityImageHelper = 28
UIConst.ControlTypeDragPage = 29
UIConst.ControlTypeBulletScreen = 30
UIConst.ControlTypeUnionTextureTrigger = 31
UIConst.ControlTypeDragPinchPanel = 32
UIConst.ControlTypeLocalizationComponent = 33
UIConst.ControlTypeScreenshotImage = 34
UIConst.ControlTypeRateEffectPlayer = 35
UIConst.ControlTypeLazyAudioPlayer = 36
UIConst.ControlTypeBookPlayer = 37
UIConst.ControlTypeLazyLivePlayer = 38
UIConst.ControlTypeUIBrowser = 39
UIConst.EXECUTABLE_CONTROL_TYPE = {
	[UIConst.ControlTypeLoopScrollRectHorizontal] = true,
	[UIConst.ControlTypeLoopScrollRectVertical] = true,
	[UIConst.ControlTypeUIAni] = true,
	[UIConst.ControlTypeScrollRect] = true
}
UIConst.EMOJI_ICON = 1
UIConst.EMOJI_ANI = 2
UIConst.EMOJI_BTN = 3
UIConst.EMOJI_LINK = 4

local ResChatIcon = require("ClientData/ResChatIcon")
local ResChatDynamicIcon = require("ClientData/ResChatDynamicIcon")

UIConst.EMOJI_DATA = {}
UIConst.EMOJI_TYPE_MAP = {}
UIConst.EMOJI_TYPE_MOVE = 1
UIConst.EMOJI_TYPE_LARGE = 2
UIConst.EMOJI_TYPE_PLAYER = 3

for _, data in ipairs(ResChatIcon) do
	local info = UIConst.EMOJI_DATA[data.tab_type] or {}

	info.type = data.type
	info.tabType = data.tab_type
	info.data = info.data or {}

	local iconName

	for i = data.icon_start_index, data.icon_end_index do
		if i < 10 then
			iconName = "<" .. data.icon_path .. "0" .. i .. ">"
		else
			iconName = "<" .. data.icon_path .. i .. ">"
		end

		table.insert(info.data, iconName)

		UIConst.EMOJI_TYPE_MAP[iconName] = data.type
	end

	UIConst.EMOJI_DATA[data.tab_type] = info
end

UIConst.EMOJI_MOVE_MAP = {}

for _, info in pairs(ResChatDynamicIcon) do
	UIConst.EMOJI_MOVE_MAP[info.icon_name] = info
end

UIConst.BOSS_EXPAND_DIFF_CONFIG = {
	{
		color = "WHITEMAIN",
		des = Lang.get(30088)
	},
	{
		color = "QUALITYORANGE",
		des = Lang.get(1476)
	},
	{
		color = "BLUELOG",
		des = Lang.get(3263)
	},
	{
		color = "COLORRANK07",
		des = Lang.get(55823)
	},
	{
		color = "COLORRANK08",
		des = Lang.get(3264)
	}
}
UIConst.BATTLE_SHARE_CONFIG = {
	{
		icon = "Icon6",
		type = BattleConst.BATTLE_TYPE_STAGE,
		name = Lang.get(29924)
	},
	{
		icon = "Icon1",
		type = BattleConst.BATTLE_TYPE_STEPTOWER,
		name = Lang.get(1460)
	},
	{
		icon = "Icon5",
		type = BattleConst.BATTLE_TYPE_EQUIPTOWER,
		name = Lang.get(30087)
	},
	{
		icon = "Icon4",
		type = BattleConst.BATTLE_TYPE_BOSSTOWER,
		name = Lang.get(727)
	},
	{
		icon = "Icon7",
		type = BattleConst.BATTLE_TYPE_ASYNC_PVP,
		name = Lang.get(29925)
	},
	{
		icon = "Icon2",
		type = BattleConst.BATTLE_TYPE_ONCETOWER,
		name = Lang.get(1462)
	},
	[8] = {
		icon = "Icon3",
		type = BattleConst.BATTLE_TYPE_MAZE,
		name = Lang.get(1461)
	},
	[9] = {
		icon = "Icon7",
		type = BattleConst.BATTLE_TYPE_THREE_TEAM_PVP,
		name = Lang.get(29926)
	},
	[10] = {
		icon = "Icon7",
		type = BattleConst.BATTLE_TYPE_WORLD_BOSS,
		name = Lang.get(1447)
	},
	[13] = {
		icon = "Icon9",
		type = BattleConst.BATTLE_TYPE_SEASON_TOWER,
		name = Lang.get(1445)
	},
	[14] = {
		icon = "Icon10",
		type = BattleConst.BATTLE_TYPE_RENT,
		name = Lang.get(665)
	},
	[16] = {
		icon = "Icon11",
		type = BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND,
		name = Lang.get(48602)
	}
}

local ResStage = require("ClientData/ResStage")
local ResEquipTower = require("ClientData/ResEquipTower")
local ResBossTower = require("ClientData/ResBossTower")
local ResMazeConfig = require("ClientData/ResMazeConfig")
local ResMazeNodeConfig = require("ClientData/ResMazeNodeConfig")
local ResWorldBoss = require("ClientData/ResWorldBoss")
local ResOpActTower = require("ClientData/ResOpActTower")
local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local ResBossTowerExpandLevel = require("ClientData/ResBossTowerExpandLevel")
local ResHeroCampCareerConfig = require("ClientData/ResHeroCampCareerConfig")
local ResBossTowerExpandCamp = require("ClientData/ResBossTowerExpandCamp")

function UIConst.getBattleShareInfo(typeId, value, specData)
	local param3 = bit.band(value, 32767)
	local param2 = bit.band(bit.rshift(value, 15), 255)
	local param1 = bit.band(bit.rshift(value, 23), 255)

	if param3 > 10000 then
		return
	end

	local info = utils.copyTable(UIConst.BATTLE_SHARE_CONFIG[typeId] or {})

	info.desc = ""

	local battleType
	local diff = {
		Lang.get(30088),
		Lang.get(1476),
		Lang.get(3263)
	}

	if UIConst.BATTLE_SHARE_CONFIG[typeId] then
		battleType = UIConst.BATTLE_SHARE_CONFIG[typeId].type
	end

	if battleType == BattleConst.BATTLE_TYPE_STAGE then
		local config = ResStage[1][param2][param3]
		local name = config.short_name or config.name

		info.desc = name .. " " .. param2 .. "-" .. param3
	elseif battleType == BattleConst.BATTLE_TYPE_STEPTOWER then
		info.desc = param2 .. "-" .. param3
	elseif battleType == BattleConst.BATTLE_TYPE_EQUIPTOWER then
		if ResEquipTower[param2] == nil or ResEquipTower[param2][param3] == nil then
			-- block empty
		else
			info.desc = ResEquipTower[param2][param3].name .. string.format(Lang.get(30089), param3)
		end
	elseif battleType == BattleConst.BATTLE_TYPE_BOSSTOWER then
		local str

		if param1 == 3 then
			str = string.format(Lang.get(30090), param3)
		else
			str = string.format(Lang.get(30091), param3 / 100)
		end

		if ResBossTower[param1] == nil or ResBossTower[param1][param2] == nil then
			-- block empty
		else
			info.desc = ResBossTower[param1][param2].name .. string.format(Lang.get(30089), param2) .. str
		end
	elseif battleType == BattleConst.BATTLE_TYPE_ONCETOWER then
		info.desc = string.format(Lang.get(30089), param3)
	elseif battleType == BattleConst.BATTLE_TYPE_ASYNC_PVP then
		-- block empty
	elseif battleType == BattleConst.BATTLE_TYPE_MAZE then
		local data = ResMazeConfig[param1][param2]

		info.desc = data.maze_name .. " " .. data.difficult_desc .. " " .. ResMazeNodeConfig[param3].name
	elseif battleType == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP then
		-- block empty
	elseif battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		info.desc = ResWorldBoss[param2][1].name .. " " .. (diff[param3] or "")
	elseif battleType == BattleConst.BATTLE_TYPE_SEASON_TOWER then
		if CurAvatar then
			info.desc = CurAvatar:getSeasonTowerName(param2, param3)
		end
	elseif battleType == BattleConst.BATTLE_TYPE_RENT and specData then
		local taskList = utils.getNumListFromString(specData.rent.taskidstr, ",")
		local rentData = RentTaskUtils.getTaskData(specData.rent.taskid)
		local diffId = rentData ~= nil and rentData.type or 1
		local title = RentTaskUtils.getTaskTitle(specData.rent.taskid) or ""
		local diffDesc = diff[diffId] or ""

		if diffId > 1 then
			local name = utils.GetPlayerName(specData.rent.name)

			info.watchDesc = string.format(Lang.get(30082), utils.getColorfulStr(name, ResColor.QUALITYORANGE))
		end

		info.desc = title .. " " .. diffDesc
	elseif battleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND and specData then
		local des

		for towerId, Bossdata in ipairs(ResBossTowerExpandLevel) do
			local camp = ResBossTowerExpandCamp[towerId].camp

			for layerId, layerData in ipairs(Bossdata) do
				for diff, levelData in ipairs(layerData) do
					if specData.camptower.level_id == levelData.level_id then
						local bossId = ResBossTowerExpandCamp[towerId].boss_id

						des = utils.format(Lang.get(50268), ResBossTower[bossId][1].name, ResHeroCampCareerConfig[1][camp].name, levelData.layer, UIConst.BOSS_EXPAND_DIFF_CONFIG[diff].des)

						break
					end
				end

				if des then
					break
				end
			end

			if des then
				break
			end
		end

		if des then
			info.desc = des
		end
	end

	return info
end

UIConst.FLY_ITEM_TYPE_EFFECT = 0
UIConst.FLY_ITEM_TYPE_ICON = 1
UIConst.FLY_MODE_UI_OBJ = 1
UIConst.FLY_MODE_ITEM = 2
UIConst.FLY_MODE_3D = 3
UIConst.ITEM_ICON_PATH = "Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/"
UIConst.ITEM_GRID_PATH = "Atlas/CommonAtlas/GridAtlas/"
UIConst.EQUIP_ICON_PATH = "Atlas/CommonAtlas/IconAtlas/"
UIConst.EQUIP_PART_MAX_NUM = 6
UIConst.EQUIP_PART_CONFIG = {
	{
		Lang.get(30092)
	},
	{
		Lang.get(30093)
	},
	{
		Lang.get(30094)
	},
	{
		Lang.get(30095)
	},
	{
		Lang.get(30096)
	},
	{
		Lang.get(30097)
	},
	{
		Lang.get(30098)
	}
}
UIConst.EQUIP_PART_CONFIG2 = {
	Lang.get(529),
	Lang.get(89818),
	Lang.get(89819),
	Lang.get(532),
	Lang.get(533),
	(Lang.get(534))
}
UIConst.EQUIP_SUIT_EMOJI = {
	"<0906>",
	"<0911>",
	"<0912>",
	"<0909>",
	"<0904>",
	"<1001>",
	"<0910>",
	"<0914>",
	"<0905>",
	"<0908>",
	"<0913>",
	"<0907>",
	"<0915>",
	"<1002>",
	"<1005>",
	"<1014>",
	"<1018>",
	"<1019>",
	"<1020>",
	"<1021>",
	"<1022>",
	"<1023>"
}
UIConst.HERO_EQUIP_ICON_PATH = "Atlas/HeroAtlas/HeroEquipAtlas"
UIConst.EQUIP_WEAR_UPGRADE_BG = {
	[Const.ITEM_QUALITY_WHITE] = {
		UIConst.HERO_EQUIP_ICON_PATH,
		"BgIconWhite"
	},
	[Const.ITEM_QUALITY_GREEN] = {
		UIConst.HERO_EQUIP_ICON_PATH,
		"BgIconGreen"
	},
	[Const.ITEM_QUALITY_BLUE] = {
		UIConst.HERO_EQUIP_ICON_PATH,
		"BgIconBlue"
	},
	[Const.ITEM_QUALITY_PURPLE] = {
		UIConst.HERO_EQUIP_ICON_PATH,
		"BgIconPurple"
	},
	[Const.ITEM_QUALITY_GOLD] = {
		UIConst.HERO_EQUIP_ICON_PATH,
		"BgIconGold"
	}
}
UIConst.COMMON_ICON_PATH = "Atlas/CommonAtlas/"
UIConst.COMMON_QUALITY_CONFIG = {
	[Const.ITEM_QUALITY_WHITE] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconWhite"
	},
	[Const.ITEM_QUALITY_GREEN] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconGreen"
	},
	[Const.ITEM_QUALITY_BLUE] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconBlue"
	},
	[Const.ITEM_QUALITY_PURPLE] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconPurple"
	},
	[Const.ITEM_QUALITY_GOLD] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconGold"
	},
	[Const.ITEM_QUALITY_PINK] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconPink"
	},
	[Const.ITEM_QUALITY_RED] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconRed"
	}
}
UIConst.HERO_QUALITY_CONFIG = {
	[Const.ITEM_QUALITY_WHITE] = {
		"Atlas/HeroAtlas/HeroCardCommonAtlas",
		"TxtQuality01"
	},
	[Const.ITEM_QUALITY_GREEN] = {
		"Atlas/HeroAtlas/HeroCardCommonAtlas",
		"TxtQuality02"
	},
	[Const.ITEM_QUALITY_BLUE] = {
		"Atlas/HeroAtlas/HeroCardCommonAtlas",
		"TxtQuality03"
	},
	[Const.ITEM_QUALITY_PURPLE] = {
		"Atlas/HeroAtlas/HeroCardCommonAtlas",
		"TxtQuality04"
	},
	[Const.ITEM_QUALITY_GOLD] = {
		"Atlas/HeroAtlas/HeroCardCommonAtlas",
		"TxtQuality05"
	}
}
UIConst.HERO_QUALITY_LOGO_CONFIG = {
	[Const.ITEM_QUALITY_WHITE] = {
		"Atlas/TeamSetAtlas/TeamSetAtlas",
		"BgWhite"
	},
	[Const.ITEM_QUALITY_GREEN] = {
		"Atlas/TeamSetAtlas/TeamSetAtlas",
		"BgGreen"
	},
	[Const.ITEM_QUALITY_BLUE] = {
		"Atlas/TeamSetAtlas/TeamSetAtlas",
		"BgBlue"
	},
	[Const.ITEM_QUALITY_PURPLE] = {
		"Atlas/TeamSetAtlas/TeamSetAtlas",
		"BgPurple"
	},
	[Const.ITEM_QUALITY_GOLD] = {
		"Atlas/TeamSetAtlas/TeamSetAtlas",
		"BgGold"
	}
}
UIConst.HERO_QUALITY_HEAD_CONFIG = {
	[Const.ITEM_QUALITY_WHITE] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconGreen"
	},
	[Const.ITEM_QUALITY_GREEN] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconBlue"
	},
	[Const.ITEM_QUALITY_BLUE] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconPurple"
	},
	[Const.ITEM_QUALITY_PURPLE] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconFuchsia"
	},
	[Const.ITEM_QUALITY_GOLD] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconGold"
	},
	[Const.ITEM_QUALITY_PINK] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconPink"
	},
	[Const.ITEM_QUALITY_RED] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconRed"
	}
}
UIConst.SHOP_QUALITY_CONFIG = {
	[Const.ITEM_QUALITY_WHITE] = {
		"Atlas/StoreAtlas/StoreAtlas",
		"BgGoodsWhite"
	},
	[Const.ITEM_QUALITY_GREEN] = {
		"Atlas/StoreAtlas/StoreAtlas",
		"BgGoodsGreen"
	},
	[Const.ITEM_QUALITY_BLUE] = {
		"Atlas/StoreAtlas/StoreAtlas",
		"BgGoodsBlue"
	},
	[Const.ITEM_QUALITY_PURPLE] = {
		"Atlas/StoreAtlas/StoreAtlas",
		"BgGoodsPurple"
	},
	[Const.ITEM_QUALITY_GOLD] = {
		"Atlas/StoreAtlas/StoreAtlas",
		"BgGoodsGold"
	},
	[Const.ITEM_QUALITY_PINK] = {
		"Atlas/StoreAtlas/StoreAtlas",
		"BgGoodsPink"
	},
	[Const.ITEM_QUALITY_RED] = {
		"Atlas/StoreAtlas/StoreAtlas02",
		"BgGoodsRed"
	},
	[Const.ITEM_QUALITY_UNKNOWN] = {
		"Atlas/StoreAtlas/StoreAtlas",
		"BgGoodsDis"
	}
}
UIConst.SHOP_PET_QUALITY_CONFIG = {
	[Const.ITEM_QUALITY_WHITE] = {
		"Atlas/PetAtlas/PetStoreAtlas",
		"BgPetStoreWhite"
	},
	[Const.ITEM_QUALITY_GREEN] = {
		"Atlas/PetAtlas/PetStoreAtlas",
		"BgPetStoreGreen"
	},
	[Const.ITEM_QUALITY_BLUE] = {
		"Atlas/PetAtlas/PetStoreAtlas",
		"BgPetStoreBlue"
	},
	[Const.ITEM_QUALITY_PURPLE] = {
		"Atlas/PetAtlas/PetStoreAtlas",
		"BgPetStorePurple"
	},
	[Const.ITEM_QUALITY_GOLD] = {
		"Atlas/PetAtlas/PetStoreAtlas",
		"BgPetStoreGold"
	},
	[Const.ITEM_QUALITY_PINK] = {
		"Atlas/PetAtlas/PetStoreAtlas",
		"BgPetStorePink"
	},
	[Const.ITEM_QUALITY_RED] = {
		"Atlas/PetAtlas/PetStoreAtlas",
		"BgPetStoreRed"
	},
	[Const.ITEM_QUALITY_UNKNOWN] = {
		"Atlas/PetAtlas/PetStoreAtlas",
		"BgPetStoreDis"
	}
}
UIConst.REARHOUSE_SHOP_QUALITY_CONFIG = {
	[Const.ITEM_QUALITY_WHITE] = {
		"Atlas/BackyardAtlas/BackyardStoreAtlas",
		"BgGoodsWhite"
	},
	[Const.ITEM_QUALITY_GREEN] = {
		"Atlas/BackyardAtlas/BackyardStoreAtlas",
		"BgGoodsGreen"
	},
	[Const.ITEM_QUALITY_BLUE] = {
		"Atlas/BackyardAtlas/BackyardStoreAtlas",
		"BgGoodsBlue"
	},
	[Const.ITEM_QUALITY_PURPLE] = {
		"Atlas/BackyardAtlas/BackyardStoreAtlas",
		"BgGoodsPurple"
	},
	[Const.ITEM_QUALITY_GOLD] = {
		"Atlas/BackyardAtlas/BackyardStoreAtlas",
		"BgGoodsGold"
	},
	[Const.ITEM_QUALITY_PINK] = {
		"Atlas/BackyardAtlas/BackyardStoreAtlas",
		"BgGoodsPink"
	},
	[Const.ITEM_QUALITY_RED] = {
		"Atlas/BackyardAtlas/BackyardStoreAtlas",
		"BgGoodsRed"
	},
	[Const.ITEM_QUALITY_UNKNOWN] = {
		"Atlas/BackyardAtlas/BackyardStoreAtlas",
		"BgGoodsDis"
	}
}
UIConst.RELIC_QUALITY_CONFIG = {
	[Const.ITEM_QUALITY_WHITE] = {
		"Atlas/CommonAtlas/GridAtlas/GridRelicAtlas",
		"BgRelicPurple"
	},
	[Const.ITEM_QUALITY_GREEN] = {
		"Atlas/CommonAtlas/GridAtlas/GridRelicAtlas",
		"BgRelicPurple"
	},
	[Const.ITEM_QUALITY_BLUE] = {
		"Atlas/CommonAtlas/GridAtlas/GridRelicAtlas",
		"BgRelicBlue"
	},
	[Const.ITEM_QUALITY_PURPLE] = {
		"Atlas/CommonAtlas/GridAtlas/GridRelicAtlas",
		"BgRelicPurple"
	},
	[Const.ITEM_QUALITY_GOLD] = {
		"Atlas/CommonAtlas/GridAtlas/GridRelicAtlas",
		"BgRelicYellow"
	},
	[Const.ITEM_QUALITY_PINK] = {
		"Atlas/CommonAtlas/GridAtlas/GridRelicAtlas",
		"BgRelicPurple"
	},
	[Const.ITEM_QUALITY_RED] = {
		"Atlas/CommonAtlas/GridAtlas/GridRelicAtlas",
		"BgRelicOrange"
	}
}
UIConst.RELIC_PANEL_QUALITY_CONFIG = {
	[Const.ITEM_QUALITY_WHITE] = {
		"Atlas/HeroAtlas/HeroEquipAtlas",
		"BgSacred02"
	},
	[Const.ITEM_QUALITY_GREEN] = {
		"Atlas/HeroAtlas/HeroEquipAtlas",
		"BgSacred02"
	},
	[Const.ITEM_QUALITY_BLUE] = {
		"Atlas/HeroAtlas/HeroEquipAtlas",
		"BgSacred03"
	},
	[Const.ITEM_QUALITY_PURPLE] = {
		"Atlas/HeroAtlas/HeroEquipAtlas",
		"BgSacred02"
	},
	[Const.ITEM_QUALITY_GOLD] = {
		"Atlas/HeroAtlas/HeroEquipAtlas",
		"BgSacred01"
	},
	[Const.ITEM_QUALITY_PINK] = {
		"Atlas/HeroAtlas/HeroEquipAtlas",
		"BgSacred02"
	},
	[Const.ITEM_QUALITY_RED] = {
		"Atlas/HeroAtlas/HeroEquipAtlas",
		"BgSacred04"
	}
}
UIConst.RELIC_BG_QUALITY_CONFIG = {
	[Const.ITEM_QUALITY_WHITE] = {
		"Atlas/HeroAtlas/HeroEquipAtlas",
		"BgSacredViolet"
	},
	[Const.ITEM_QUALITY_GREEN] = {
		"Atlas/HeroAtlas/HeroEquipAtlas",
		"BgSacredViolet"
	},
	[Const.ITEM_QUALITY_BLUE] = {
		"Atlas/HeroAtlas/HeroEquipAtlas",
		"BgSacredBlue"
	},
	[Const.ITEM_QUALITY_PURPLE] = {
		"Atlas/HeroAtlas/HeroEquipAtlas",
		"BgSacredViolet"
	},
	[Const.ITEM_QUALITY_GOLD] = {
		"Atlas/HeroAtlas/HeroEquipAtlas",
		"BgSacredGolden"
	},
	[Const.ITEM_QUALITY_PINK] = {
		"Atlas/HeroAtlas/HeroEquipAtlas",
		"BgSacredViolet"
	},
	[Const.ITEM_QUALITY_RED] = {
		"Atlas/HeroAtlas/HeroEquipAtlas",
		"BgSacredOrange"
	}
}
UIConst.RELIC_SPEICAL_SIGN_PATH = {
	[Const.RELIC_SPEICAL_SIGN_FULI] = {
		"Atlas/StoreAtlas/StoreRelicAtlas",
		"TxtBgFuli"
	},
	[Const.RELIC_SPEICAL_SIGN_SPRING] = {
		"Atlas/StoreAtlas/StoreRelicAtlas",
		"TxtBgSeasonSpring"
	},
	[Const.RELIC_SPEICAL_SIGN_SUMMER] = {
		"Atlas/StoreAtlas/StoreRelicAtlas",
		"TxtBgSeasonSummer"
	},
	[Const.RELIC_SPEICAL_SIGN_AUTUMN] = {
		"Atlas/StoreAtlas/StoreRelicAtlas",
		"TxtBgSeasonAutumn"
	},
	[Const.RELIC_SPEICAL_SIGN_WINTER] = {
		"Atlas/StoreAtlas/StoreRelicAtlas",
		"TxtBgSeasonWinter"
	},
	[Const.RELIC_SPEICAL_SIGN_ALLIN] = {
		"Atlas/StoreAtlas/StoreRelicAtlas",
		"TxtBgSeasonAllin"
	}
}
UIConst.SKIN_QUALITY_ICON_PATH = "Atlas/HeroAtlas/HeroSkinCardAtlas"
UIConst.SKIN_QUALITY_BG_PATH = "Atlas/ActivityAtlas/ActivityNewSkinPreviewAtlas/ActivityNewSkinPreviewAtlas"
UIConst.SKIN_QUALITY_ICON = {
	{
		"TxtAdvanced",
		"BgCell5"
	},
	{
		"TxtTreasure",
		"BgCell3"
	},
	{
		"TxtLimited",
		"BgCell1"
	},
	{
		"TxtCollector",
		"BgCell2"
	},
	{
		"TxtHalloween",
		"BgCell4"
	},
	{
		"TxtSouvenir",
		"BgCell4"
	},
	{
		"TxtSummerSwim",
		"BgCell1"
	},
	{
		"TxtChristmas",
		"BgCell1"
	},
	{
		"TxtSweet",
		"BgCell1"
	},
	{
		"TxtSpring",
		"BgCell1"
	}
}

local ResItem = require("ClientData/ResItem")
local moneyAtlasPath = UIConst.ITEM_ICON_PATH .. "CurrencyAtlas"
local moneyAtlasPath2 = UIConst.ITEM_ICON_PATH .. "CurrencyAtlas2"
local moneyAtlasPath3 = UIConst.ITEM_ICON_PATH .. "CurrencyAtlas3"

UIConst.RD_HINT_FUNCENTRY_DIAMOND = 201
UIConst.RD_HINT_MAIN_HEAD = 202
UIConst.MONEY_ID2INFO = {
	[Const.MONEY_ID_GOLD] = {
		moneyAtlasPath,
		"IconGold",
		ResItem[Const.MONEY_ID_GOLD].name or "",
		172
	},
	[Const.MONEY_ID_DIAMOND] = {
		moneyAtlasPath,
		"IconDiamond",
		ResItem[Const.MONEY_ID_DIAMOND].name or ""
	},
	[Const.MONEY_ID_POWER] = {
		moneyAtlasPath,
		"IconCapacity",
		ResItem[Const.MONEY_ID_POWER].name or ""
	},
	[Const.MONEY_ID_PVP] = {
		moneyAtlasPath,
		"IconPVP",
		ResItem[Const.MONEY_ID_PVP].name or "",
		173
	},
	[Const.MONEY_ID_MAZE] = {
		moneyAtlasPath,
		"IconMaze",
		ResItem[Const.MONEY_ID_MAZE].name or "",
		175
	},
	[Const.MONEY_ID_PVP_TICKET] = {
		moneyAtlasPath,
		"IconPVPTicket",
		ResItem[Const.MONEY_ID_PVP_TICKET].name or ""
	},
	[Const.MONEY_ID_FRIEND_GIFT] = {
		moneyAtlasPath,
		"IconFriend",
		ResItem[Const.MONEY_ID_FRIEND_GIFT].name or "",
		174
	},
	[Const.MONEY_ID_FURNITURE] = {
		moneyAtlasPath2,
		"IconFurniture",
		ResItem[Const.MONEY_ID_FURNITURE].name or "",
		176
	},
	[Const.MONEY_ID_REAR_HOUSE_COIN] = {
		moneyAtlasPath,
		"IconBackyard",
		ResItem[Const.MONEY_ID_REAR_HOUSE_COIN].name or ""
	},
	[Const.MONEY_ID_DRAW_BY_GOLD] = {
		moneyAtlasPath,
		"IconDrawHero1",
		ResItem[Const.MONEY_ID_DRAW_BY_GOLD].name or ""
	},
	[Const.MONEY_ID_DRAW_BY_DIAMOND] = {
		moneyAtlasPath,
		"IconDrawHero2",
		ResItem[Const.MONEY_ID_DRAW_BY_DIAMOND].name or ""
	},
	[Const.MONEY_ID_HERO_EXP] = {
		moneyAtlasPath,
		"IconHeroExp",
		ResItem[Const.MONEY_ID_HERO_EXP].name or ""
	},
	[Const.MONEY_ID_VIP_POINT] = {
		moneyAtlasPath2,
		"IconVIPPoint",
		ResItem[Const.MONEY_ID_VIP_POINT].name or ""
	},
	[Const.MONEY_ID_BP] = {
		moneyAtlasPath2,
		"IconBPPoint",
		ResItem[Const.MONEY_ID_BP].name or ""
	},
	[Const.MONEY_ID_STAGE_ENERGY] = {
		moneyAtlasPath2,
		"IconMainBattle",
		ResItem[Const.MONEY_ID_STAGE_ENERGY].name or ""
	},
	[Const.MONEY_ID_CIRCLE_COIN] = {
		moneyAtlasPath2,
		"IconCircleCoin",
		ResItem[Const.MONEY_ID_CIRCLE_COIN].name or ""
	},
	[Const.MONEY_ID_GOLD_LEAF] = {
		moneyAtlasPath2,
		"IconGoldenLeaf",
		ResItem[Const.MONEY_ID_GOLD_LEAF].name or ""
	},
	[Const.MONEY_ID_ARTIFACT_COIN] = {
		moneyAtlasPath2,
		"IconMaze2",
		ResItem[Const.MONEY_ID_ARTIFACT_COIN].name or ""
	},
	[Const.MONEY_ID_HIGH_FURNITURE] = {
		moneyAtlasPath2,
		"IconFurniture2",
		ResItem[Const.MONEY_ID_HIGH_FURNITURE].name or ""
	},
	[Const.MONEY_ID_REFUND_COIN] = {
		moneyAtlasPath3,
		"IconRebate",
		ResItem[Const.MONEY_ID_REFUND_COIN].name or ""
	},
	[Const.MONEY_ID_SKIN_COIN] = {
		moneyAtlasPath3,
		"IconSkin",
		ResItem[Const.MONEY_ID_SKIN_COIN].name or "",
		287
	}
}

local HERO_COMMON_ATLAS_PATH = "Atlas/HeroAtlas/HeroCardCommonAtlas"

UIConst.HERO_CARD_SPRITE_BY_STEP = {
	{
		IMG_BAR1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardGreen"
		},
		IMG_BG1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardBgNml"
		},
		BG_STAR = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardGreenLv"
		},
		BG_HEAD = {
			HERO_COMMON_ATLAS_PATH .. "01",
			"BgHeadGreen"
		},
		IMG_STAR = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas7",
			"ImgGreenStar"
		},
		IMG_STAR_L = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas7",
			"ImgGreenL"
		},
		IMG_STAR_R = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas7",
			"ImgGreenR"
		},
		IMG_TRIANGLE = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas7",
			"ImgGreenR"
		},
		TEXT_STAR = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas7",
			"TextStarGreen"
		}
	},
	{
		IMG_BAR1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardBlue"
		},
		IMG_BG1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardBgNml"
		},
		BG_STAR = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardBlueLv"
		},
		BG_HEAD = {
			HERO_COMMON_ATLAS_PATH .. "01",
			"BgHeadBlue"
		},
		IMG_STAR = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas7",
			"ImgBlueStar"
		},
		IMG_STAR_L = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas7",
			"ImgBlueL"
		},
		IMG_STAR_R = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas7",
			"ImgBlueR"
		},
		IMG_TRIANGLE = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas7",
			"ImgBlueR"
		},
		TEXT_STAR = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas7",
			"TextStarBlue"
		}
	},
	{
		IMG_BAR1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardPurple"
		},
		IMG_BG1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardBgNml"
		},
		BG_STAR = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardPurpleLv"
		},
		BG_HEAD = {
			HERO_COMMON_ATLAS_PATH .. "01",
			"BgHeadPurple"
		},
		IMG_STAR = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas3",
			"ImgPurpleStar"
		},
		IMG_STAR_L = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas3",
			"ImgPurpleL"
		},
		IMG_STAR_R = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas3",
			"ImgPurpleR"
		},
		IMG_TRIANGLE = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas3",
			"ImgTrianglePurple"
		},
		TEXT_STAR = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas3",
			"TextStarPurple"
		}
	},
	{
		IMG_BAR1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardFuchsia"
		},
		IMG_BG1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardBgNml"
		},
		BG_STAR = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardFuchsiaLv"
		},
		BG_HEAD = {
			HERO_COMMON_ATLAS_PATH .. "01",
			"BgHeadFuchsia"
		},
		IMG_STAR = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas3",
			"ImgFuchsiaStar"
		},
		IMG_STAR_L = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas3",
			"ImgFuchsiaL"
		},
		IMG_STAR_R = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas3",
			"ImgFuchsiaR"
		},
		IMG_TRIANGLE = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas3",
			"ImgTriangleFuchsia"
		},
		TEXT_STAR = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas3",
			"TextStarFuchsia"
		}
	},
	{
		IMG_BAR1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardGold"
		},
		IMG_BG1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardBgNml"
		},
		BG_STAR = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardGoldLv"
		},
		BG_HEAD = {
			HERO_COMMON_ATLAS_PATH .. "01",
			"BgHeadGold"
		},
		IMG_STAR = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas5",
			"ImgYellowStar"
		},
		IMG_STAR_L = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas5",
			"ImgYellowL"
		},
		IMG_STAR_R = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas5",
			"ImgYellowR"
		},
		IMG_TRIANGLE = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas5",
			"ImgTriangleYellow"
		},
		TEXT_STAR = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas5",
			"TextStarYellow"
		}
	},
	{
		IMG_BAR1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardPink"
		},
		IMG_BG1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardBgNml"
		},
		BG_STAR = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardPinkLv"
		},
		BG_HEAD = {
			HERO_COMMON_ATLAS_PATH .. "01",
			"BgHeadPink"
		},
		IMG_STAR = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas4",
			"ImgPinkStar"
		},
		IMG_STAR_L = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas4",
			"ImgPinkL"
		},
		IMG_STAR_R = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas4",
			"ImgPinkR"
		},
		IMG_TRIANGLE = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas4",
			"ImgTrianglePink"
		},
		TEXT_STAR = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas4",
			"TextStarPink"
		}
	},
	{
		IMG_BAR1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardRed"
		},
		IMG_BG1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardBgNml"
		},
		BG_STAR = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardRedLv"
		},
		BG_HEAD = {
			HERO_COMMON_ATLAS_PATH .. "01",
			"BgHeadRed"
		},
		IMG_STAR = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas4",
			"ImgRedStar"
		},
		IMG_STAR_L = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas4",
			"ImgRedL"
		},
		IMG_STAR_R = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas4",
			"ImgRedR"
		},
		IMG_TRIANGLE = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas4",
			"ImgTriangleRed"
		},
		TEXT_STAR = {
			"Atlas/HeroStarUpAtlas/HeroStarUpAtlas4",
			"TextStarRed"
		}
	},
	{
		IMG_BAR1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardGold03"
		},
		IMG_BG1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardBgNml"
		},
		BG_STAR = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardGoldLv03"
		},
		BG_HEAD = {
			HERO_COMMON_ATLAS_PATH .. "01",
			"BgHeadGold03"
		}
	},
	{
		IMG_BAR1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardGold04"
		},
		IMG_BG1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardBgNml"
		},
		BG_STAR = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardGoldLv04"
		},
		BG_HEAD = {
			HERO_COMMON_ATLAS_PATH .. "01",
			"BgHeadGold04"
		}
	},
	{
		IMG_BAR1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardGold05"
		},
		IMG_BG1 = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardBgNml"
		},
		BG_STAR = {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardGoldLv05"
		},
		BG_HEAD = {
			HERO_COMMON_ATLAS_PATH .. "01",
			"BgHeadGold05"
		}
	}
}
UIConst.HERO_PROP_RANK_ICON = {
	{
		HERO_COMMON_ATLAS_PATH,
		"TxtRateD"
	},
	{
		HERO_COMMON_ATLAS_PATH,
		"TxtRateC"
	},
	{
		HERO_COMMON_ATLAS_PATH,
		"TxtRateB"
	},
	{
		HERO_COMMON_ATLAS_PATH,
		"TxtRateA"
	},
	{
		HERO_COMMON_ATLAS_PATH,
		"TxtRateS"
	}
}
UIConst.HERO_STEPUP_DES_SHOW_TPYE = {}
UIConst.HERO_STEPUP_DES_SHOW_TPYE.SKILL = 1
UIConst.HERO_STEPUP_DES_SHOW_TPYE.TIMETEXT = 2
UIConst.HERO_STEPUP_DES_SHOW_TPYE.DESTEXT = 3
UIConst.HERO_STEPUP_DES_SHOW_TPYE.CHARACTERTEXT = 4
UIConst.HERO_STEPUP_DES_SHOW_TPYE.IMAGE = 5
UIConst.CAMP_ENHANCE_BTN_IMG = {
	[0] = {
		"Atlas/BattleAtlas/BattleBrandAtlas",
		"IconBrandS0"
	},
	[3] = {
		"Atlas/BattleAtlas/BattleBrandAtlas",
		"IconBrandS1"
	},
	[4] = {
		"Atlas/BattleAtlas/BattleBrandAtlas",
		"IconBrandS2"
	},
	[5] = {
		"Atlas/BattleAtlas/BattleBrandAtlas",
		"IconBrandS3"
	}
}
UIConst.CAMP_ENHANCE_BTN_IMG_BIG = {
	[0] = {
		"Atlas/BattleAtlas/BattleBrandAtlas",
		"IconBrand0"
	},
	[3] = {
		"Atlas/BattleAtlas/BattleBrandAtlas",
		"IconBrand1"
	},
	[4] = {
		"Atlas/BattleAtlas/BattleBrandAtlas",
		"IconBrand2"
	},
	[5] = {
		"Atlas/BattleAtlas/BattleBrandAtlas",
		"IconBrand3"
	}
}
UIConst.HERO_STAR_EMOJI_DIC = {
	"<0301>",
	"<0302>",
	"<0303>",
	"<0304>",
	"<0305>",
	"<0306>",
	"<0306><0306>",
	"<0306><0306><0306>",
	"<0306><0306><0306><0306>",
	"<0306><0306><0306><0306><0306>",
	"<0307>",
	"<0307><0307>",
	"<0307><0307><0307>",
	"<0307><0307><0307><0307>",
	"<0307><0307><0307><0307><0307>"
}
UIConst.ARTIFACT_CAREER_BG = {
	[Const.CAREER_TYPE.ALL] = {
		{
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas",
			"BgBadge01"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas",
			"BgBadge02"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas",
			"BgBadge03"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas",
			"BgBadge04"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas",
			"BgBadge05"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas",
			"BgBadge06"
		}
	},
	[Const.CAREER_TYPE.TANK] = {
		[3] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1",
			"BgBadge13"
		},
		[4] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1",
			"BgBadge14"
		},
		[5] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1",
			"BgBadge15"
		},
		[6] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas",
			"BgBadge16"
		}
	},
	[Const.CAREER_TYPE.WORRIOR] = {
		[3] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1",
			"BgBadge23"
		},
		[4] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1",
			"BgBadge24"
		},
		[5] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1",
			"BgBadge25"
		},
		[6] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas",
			"BgBadge26"
		}
	},
	[Const.CAREER_TYPE.HUNTER] = {
		[3] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1",
			"BgBadge33"
		},
		[4] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1",
			"BgBadge34"
		},
		[5] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas1",
			"BgBadge35"
		},
		[6] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas",
			"BgBadge36"
		}
	},
	[Const.CAREER_TYPE.POET] = {
		[3] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas2",
			"BgBadge43"
		},
		[4] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas2",
			"BgBadge44"
		},
		[5] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas2",
			"BgBadge45"
		},
		[6] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas2",
			"BgBadge46"
		}
	},
	[Const.CAREER_TYPE.SUPPORT] = {
		[3] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas2",
			"BgBadge53"
		},
		[4] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas2",
			"BgBadge54"
		},
		[5] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas2",
			"BgBadge55"
		},
		[6] = {
			"Atlas/CommonAtlas/GridAtlas/BgBadgeAtlas2",
			"BgBadge56"
		}
	}
}
UIConst.ARTIFACT_QUALITY_PATH = {
	{
		"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
		"BgGray"
	},
	{
		"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
		"BgGreen"
	},
	{
		"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
		"BgBlue"
	},
	{
		"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
		"BgPurple"
	},
	{
		"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
		"BgOrange"
	},
	[7] = {
		"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
		"BgOrangeRed"
	}
}
UIConst.ARTIFACT_STAR_PATH = {
	[2] = {
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
			"BadgeStar21"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
			"BadgeStar22"
		}
	},
	[3] = {
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
			"BadgeStar31"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
			"BadgeStar32"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
			"BadgeStar33"
		}
	},
	[4] = {
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar41"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar42"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar43"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar44"
		}
	},
	[6] = {
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar61"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar62"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar63"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar64"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar65"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar66"
		}
	}
}
UIConst.ARTIFACT_STAR_LIGHT_PATH = {
	[2] = {
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
			"BadgeStar21Light"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
			"BadgeStar22Light"
		}
	},
	[3] = {
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
			"BadgeStar31Light"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
			"BadgeStar32Light"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
			"BadgeStar33Light"
		}
	},
	[4] = {
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar41Light"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar42Light"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar43Light"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar44Light"
		}
	},
	[6] = {
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar61Light"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar62Light"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar63Light"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar64Light"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar65Light"
		},
		{
			"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
			"BadgeStar66Light"
		}
	}
}
UIConst.ARTIFACT_STAR_BG_PATH = {
	[2] = {
		"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
		"BadgeStarBg2"
	},
	[3] = {
		"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
		"BadgeStarBg3"
	},
	[4] = {
		"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
		"BadgeStarBg4"
	},
	[6] = {
		"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas3",
		"BadgeStarBg6"
	}
}
UIConst.EQUIP_QUALITY_CONFIG = {
	{
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconWhite"
	},
	{
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconGreen"
	},
	{
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconGreenMax"
	},
	{
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconBlue"
	},
	{
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconBlueMax"
	},
	{
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconPurple"
	},
	{
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconFuchsia"
	},
	{
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconGold"
	},
	{
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconGoldMax"
	},
	{
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconPink"
	},
	{
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconPinkMax"
	},
	{
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconRed"
	},
	{
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"BgIconRedMax"
	}
}
UIConst.CHANNEL_ICON_MAP = {
	[Const.CHANNEL_WORLD] = {
		bg = "BgHornGreenBack",
		icon = "BgHornGreen",
		txt = Lang.get(747)
	},
	[Const.CHANNEL_GUILD] = {
		bg = "BgHornGreenBack",
		icon = "BgHornGreen",
		txt = Lang.get(748)
	},
	[Const.CHANNEL_SERVER] = {
		bg = "BgHornGreenBack",
		icon = "BgHornGreen",
		txt = Lang.get(427)
	},
	[Const.MAIN_CHANNEL_SYSTEM] = {
		bg = "BgHornOrangeBack",
		icon = "BgHornOrange",
		txt = Lang.get(1397)
	},
	[Const.WORLD_CHANNEL_SYSTEM] = {
		bg = "BgHornOrangeBack",
		icon = "BgHornOrange",
		txt = Lang.get(1397)
	},
	[Const.GUILD_CHANNEL_SYSTEM] = {
		bg = "BgHornBlueBack",
		icon = "BgHornBlue",
		txt = Lang.get(748)
	}
}
UIConst.CIRCLE_HEAD_PATH = {
	{
		"Atlas/CircleAtlas/CircleAtlas",
		"BgHeadGroup1"
	},
	{
		"Atlas/CircleAtlas/CircleAtlas",
		"BgHeadGroup2"
	},
	{
		"Atlas/CircleAtlas/CircleAtlas",
		"BgHeadGroup3"
	}
}
UIConst.CIRCLE_HEAD_BG_PATH = {
	{
		"Atlas/CircleAtlas/CircleAtlas",
		"BgSeekGroupL01"
	},
	{
		"Atlas/CircleAtlas/CircleAtlas",
		"BgSeekGroupL02"
	},
	{
		"Atlas/CircleAtlas/CircleAtlas",
		"BgSeekGroupL03"
	}
}
UIConst.CIRCLE_BANNER_PATH = {
	"NoAlpha/CircleBanner/BgCircleGroup1",
	"NoAlpha/CircleBanner/BgCircleGroup2",
	"NoAlpha/CircleBanner/BgCircleGroup3"
}
UIConst.CIRCLE_DUTY_SPRITE_PATH = {
	[Const.CIRCLE_DUTY_MANAGER] = {
		"Atlas/CircleAtlas/CircleAtlas",
		"IconManage"
	},
	[Const.CIRCLE_DUTY_ASSISTANT] = {
		"Atlas/CircleAtlas/CircleAtlas",
		"IconSubModerator"
	},
	[Const.CIRCLE_DUTY_BOSS] = {
		"Atlas/CircleAtlas/CircleAtlas",
		"IconModerator"
	}
}
UIConst.CIRCLE_BATTLE_SCORE_PATH = {
	"Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas5",
	"IconCircleBattlePoint"
}
UIConst.CIRCLE_BATTLE_CONTRIBUTE_PATH = {
	"Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/CurrencyAtlas5",
	"IconCircleContribute"
}
UIConst.CIRCLE_BATTLE_HEAD_MSG = {
	[Const.CIRCLE_BATTLE_MSG_TYPE.MOVE_POINT] = {
		iconPath = "Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/20",
		iconName = "312",
		name = Lang.get(39264)
	},
	[Const.CIRCLE_BATTLE_MSG_TYPE.SCORE] = {
		iconPath = "Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/20",
		iconName = "306",
		name = Lang.get(37247)
	},
	[Const.CIRCLE_BATTLE_MSG_TYPE.PROFICIENCY_SEARCH] = {
		iconPath = "Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/20",
		iconName = "313",
		name = Lang.get(39265)
	},
	[Const.CIRCLE_BATTLE_MSG_TYPE.PROFICIENCY_BATTLE] = {
		iconPath = "Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/20",
		iconName = "314",
		name = Lang.get(39266)
	}
}
UIConst.RD_HINT_A = 1
UIConst.RD_HINT_B = 2
UIConst.RD_HINT_ALL_NEWBIE_TASK = 3
UIConst.RD_HINT_TASK_MAIN = 4
UIConst.RD_HINT_DAILY_TASK = 5
UIConst.RD_HINT_WEEKLY_TASK = 6
UIConst.RD_HINT_ACHIEVE_TASK = 7
UIConst.RD_HINT_TRUNK_ACHIEVE = 8
UIConst.RD_HINT_BRANCH_ACHIEVE = 9
UIConst.RD_HINT_HERO = 10
UIConst.RD_HINT_HERO_STEP_UP = 11
UIConst.RD_HINT_HERO_EQUIP = 12
UIConst.RD_HINT_HERO_STAR_UP = 13
UIConst.RD_HINT_HERO_SELL = 14
UIConst.RD_HINT_HERO_STEP_CAN_SWEEP = 15
UIConst.RD_HINT_HERO_NEW_FIVE = 16
UIConst.RD_HINT_HERO_BASE = 17
UIConst.RD_HINT_HERO_STEP_QUICK_SWEEP = 18
UIConst.RD_HINT_HERO_SKIN = 19
UIConst.RD_HINT_DRAWCARD = 20
UIConst.RD_HINT_DRAWCARD_FREE = 21
UIConst.RD_HINT_DRAWCARD_STANDARD = 22
UIConst.RD_HINT_DRAWCARD_NEWBIE = 23
UIConst.RD_HINT_OTHER_BATTLE = 24
UIConst.RD_HINT_DRAWCARD_STANDARD_ITEM = 25
UIConst.RD_HINT_DRAWCARD_FREE_ITEM = 26
UIConst.RD_HINT_DRAWCARD_GROUP = 27
UIConst.RD_HINT_LOGIN_ACHIEVE = 28
UIConst.RD_HINT_NEWBIE_TASK = 29
UIConst.RD_HINT_FRIEND = 30
UIConst.RD_HINT_FRIEND_REQUEST = 31
UIConst.RD_HINT_FRIEND_GIFT = 32
UIConst.RD_HINT_ADVANCE_TASK = 33
UIConst.RD_HINT_CHALLENGE_BOSS = 40
UIConst.RD_HINT_HANDBOOK = 50
UIConst.RD_HINT_HANDBOOK_AWARD = 51
UIConst.RD_HINT_HANDBOOK_MONUMENT = 52
UIConst.RD_HINT_HANDBOOK_TEAM_PATCH = 53
UIConst.RD_HINT_MAZE = 60
UIConst.RD_HINT_CHAT = 70
UIConst.RD_HINT_CHAT_PRIVATE = 71
UIConst.RD_HINT_CHAT_DYNAMIC_ICON_NEW = 72
UIConst.RD_HINT_CHAT_MASTER_APPRENTICE = 73
UIConst.RD_HINT_PVP = 80
UIConst.RD_HINT_PVP_FORMATION = 81
UIConst.RD_HINT_PVP_RECORD = 82
UIConst.RD_HINT_PVP_ENTER = 83
UIConst.RD_HINT_STEPTOWER = 90
UIConst.RD_HINT_MAIL = 100
UIConst.RD_HINT_MAIL_UNREAD = 101
UIConst.RD_HINT_MALL = 110
UIConst.RD_HINT_FUND = 112
UIConst.RD_HINT_NEWBEE = 113
UIConst.RD_HINT_FUND_NO_BUY = 114
UIConst.RD_HINT_DAYBEE = 115
UIConst.RD_HINT_WEEKBEE = 116
UIConst.RD_HINT_MONTNBEE = 117
UIConst.RD_HINT_MONTHCARD = 118
UIConst.RD_HINT_BPAWARD = 119
UIConst.RD_HINT_BP_STARUP = 121
UIConst.RD_HINT_BP_PVP = 122
UIConst.RD_HINT_BP_DAILY = 123
UIConst.RD_HINT_BP_MAZE = 124
UIConst.RD_HINT_VIP_BENEFIT = 126
UIConst.RD_HINT_RECHARGE_GIFT = 127
UIConst.RD_HINT_FIRST_RECHARGE = 128
UIConst.RD_HINT_SECOND_RECHARGE = 129
UIConst.RD_HINT_BAG = 130
UIConst.RD_HINT_BAG_MATERIAL = 131
UIConst.RD_HINT_BAG_SHATTER = 132
UIConst.RD_HINT_BAG_RELIC = 133
UIConst.RD_HINT_BAG_EQUIP = 134
UIConst.RD_HINT_SURVEY = 140
UIConst.RD_HINT_OPACTIVITY = 141
UIConst.RD_HINT_TURNTABLE = 142
UIConst.RD_HINT_TURNTABLE_EXCHANGE = 143
UIConst.RD_HINT_REAR_HOUSE_POPULARITY_AWARD = 149
UIConst.RD_HINT_REAR_HOUSE = 150
UIConst.RD_HINT_REAR_HOUSE_UPGREAD = 151
UIConst.RD_HINT_REAR_HOUSE_UPGREAD_BTN = 152
UIConst.RD_HINT_REAR_HOUSE_EDIT = 153
UIConst.RD_HINT_REAR_HOUSE_EDIT_BTN = 154
UIConst.RD_HINT_REAR_HOUSE_NEW_ITEM = 155
UIConst.RD_HINT_REAR_HOUSE_CRYSTLE_UP = 156
UIConst.RD_HINT_COMFORTABLE_AWARD = 157
UIConst.RD_HINT_DISPATCH_AWARD = 158
UIConst.RD_HINT_REAR_HOUSE_CLEAN = 159
UIConst.RD_HINT_NEW_ROLE_DRESS = 160
UIConst.RD_HINT_NEW_HEAD = 161
UIConst.RD_HINT_NEW_HEAD_FRAME = 162
UIConst.RD_HINT_NEW_PENDANT = 189
UIConst.RD_HINT_NEW_CHAT_BUBBLE = 190
UIConst.RD_HINT_REAR_HOUSE_ACHIEVE = 163
UIConst.RD_HINT_REAR_HOUSE_CRYSTLE = 164
UIConst.RD_HINT_REAR_HOUSE_LEVEL_ACHIEVE = 165
UIConst.RD_HINT_CIRCLE = 170
UIConst.RD_HINT_CIRCLE_SIGN = 171
UIConst.RD_HINT_CIRCLE_EDIT_HEAD = 172
UIConst.RD_HINT_CIRCLE_INVITED = 173
UIConst.RD_HINT_RENT_MAIN = 180
UIConst.RD_HINT_RENT_NEWTASK = 181
UIConst.RD_HINT_RENT_BORROW = 182
UIConst.RD_HINT_RENT_FORAMTIONLACK = 183
UIConst.RD_HINT_RENT_MESSAGE = 184
UIConst.RD_HINT_RENT_NEWREQ = 185
UIConst.RD_HINT_RENT_NEWLETTER = 186
UIConst.RD_HINT_RENT_UNSELECT = 187
UIConst.RD_HINT_RENT_NEWSENDLETTER = 188
UIConst.RD_HINT_HOME = 200
UIConst.RD_HINT_EQUIPTOWER = 210
UIConst.RD_HINT_EQUIPTOWER1 = 211
UIConst.RD_HINT_EQUIPTOWER2 = 212
UIConst.RD_HINT_EQUIPTOWER3 = 213
UIConst.RD_HINT_SENIORPVP = 220
UIConst.RD_HINT_SENIORPVP_FORMATION = 221
UIConst.RD_HINT_SENIORPVP_RECORD = 222
UIConst.RD_HINT_SENIORPVP_AWARD = 223
UIConst.RD_HINT_WORLDBOSS = 230
UIConst.RD_HINT_WORLDBOSS_CHALLENGE = 231
UIConst.RD_HINT_ELITE_WORLDBOSS_CHALLENGE = 232
UIConst.RD_HINT_BEGINNER_HOOK = 240
UIConst.RD_HINT_BEGINNER_HERO = 241
UIConst.RD_HINT_OPACTPVP = 250
UIConst.RD_HINT_OPACTPVP_FORMATION = 251
UIConst.RD_HINT_OPACTPVP_CHALLENGE = 252
UIConst.RD_HINT_OPACTPVP_REPORT = 253
UIConst.RD_HINT_OPACTPVP_PART_CHANGE = 254
UIConst.RD_HINT_SDK_BBS_MSG = 260
UIConst.RD_HINT_PROFICIENT = 270
UIConst.RD_HINT_PLOTREWIND = 271
UIConst.RD_HINT_REAR_HOUSE_EDIT = 280
UIConst.RD_HINT_QQ_PRIVILEGE = 290
UIConst.RD_HINT_QQ_PRIVILEGE_ONCE = 291
UIConst.RD_HINT_QQ_PRIVILEGE_ACHIEVE = 292
UIConst.RD_HINT_QQ_PRIVILEGE_DAY = 293
UIConst.RD_HINT_CIRCLE_BATTLE = 300
UIConst.RD_HINT_CIRCLE_BATTLE_TALENT = 301
UIConst.RD_HINT_CIRCLE_BATTLE_POINT_ACHIEVE = 302
UIConst.RD_HINT_CIRCLE_BATTLE_ACTION_POINT = 303
UIConst.RD_HINT_MAINSETTING = 310
UIConst.RD_HINT_NOTICE = 311
UIConst.RD_HINT_CUSTOMER = 312
UIConst.RD_HINT_CHALLENGE_BOSS_ALL = 320
UIConst.RD_HINT_CHALLENGE_BOSS_EXPAND = 321
UIConst.RD_HINT_BATTLE_PET_WEAR = 329
UIConst.RD_HINT_BATTLE_EQUIP_WEAR = 330
UIConst.RD_HINT_RELATION = 331
UIConst.RD_HINT_SIGN = 332
UIConst.RD_HINT_SUN = 340
UIConst.RD_HINT_CROWN = 341
UIConst.RD_HINT_SUM = 342
UIConst.RD_HINT_REBACK = 350
UIConst.RD_HINT_NEW_MAZE_HALO_PREVIEW = 351
UIConst.RD_HINT_NEW_MAZE_HERO_PREVIEW = 352
UIConst.RD_HINT_PET = 360
UIConst.RD_HINT_PET_LEVEL_UP = 361
UIConst.RD_HINT_PET_STAR_UP = 362
UIConst.RD_HINT_PET_WEAR_AMULET = 363
UIConst.RD_HINT_PET_AMULET_STAR_UP = 364
UIConst.RD_HINT_PET_AMULET_RECYCLE = 365
UIConst.RD_HINT_PET_WEAR_AMULET_STAR_UP = 366
UIConst.RD_HINT_PET_GEM_UP = 367
UIConst.RD_HINT_PET_WEAR_GEM = 368
UIConst.RD_HINT_PET_DRAW = 369
UIConst.RD_HINT_PET_RUNE = 370
UIConst.RD_HINT_PET_POSSESS = 371
UIConst.RD_HINT_PET_POSSESS_REPLACE = 372
UIConst.RD_HINT_PET_POSSESS_INTELLIGENCE = 373
UIConst.RD_HINT_PET_POSSESS_GIFT = 374
UIConst.RD_HINT_MAIN_MAZE = 375
UIConst.RD_HINT_PET_MAZE = 376
UIConst.RD_HINT_PET_MAZE_ACHI = 377
UIConst.RD_HINT_PET_MAZE_BOSS = 378
UIConst.RD_HINT_PET_MAZE_NEW_SEASON = 379
UIConst.RD_SIGNET = 380
UIConst.RD_HINT_TOPPVP = 385
UIConst.RD_HINT_PAINT_PLUS = 390
UIConst.RD_HINT_PAINT_PLUS_MAIN_LEVEL = 391
UIConst.RD_HINT_PAINT_PLUS_RELATE_LEVEL = 392
UIConst.RD_HINT_PRIVILEGEMONTH = 395
UIConst.RD_HINT_SNEAK_BATTLE = 405
UIConst.RD_HINT_SNEAK_BATTLE_AWARD = 406
UIConst.RD_HINT_SNEAK_BATTLE_NEW_LEVEL = 407
UIConst.RD_HINT_SNEAK_BATTLE_HERO_RELIC = 408
UIConst.RD_HINT_EQUIP_RECYCLE = 410
UIConst.RD_HINT_EQUIP_RECYCLE_AWARD = 411
UIConst.RD_HINT_EQUIP_RECYCLE_AWARD_NORMAL = 412
UIConst.RD_HINT_EQUIP_RECYCLE_AWARD_RENT = 413
UIConst.RD_HINT_GAME_ASSISTANT = 414
UIConst.RD_HINT_FIRST_SUBSCRIBE_AWARD_NOT_GOT = 420
UIConst.RD_HINT_MINI_GAME = 500
UIConst.RD_HINT_MINI_GAME_MAIN_MENU = 501
UIConst.RD_HINT_MASTER_APPRENTICE_MAIN = 505
UIConst.RD_HINT_MASTER_APPRENTICE_INVITE = 506
UIConst.RD_HINT_MASTER_APPRENTICE_TASK = 507
UIConst.RD_HINT_MASTER_LV_AWARD = 508
UIConst.RD_HINT_APPRENTICE_GRADUATE = 509
UIConst.RD_HINT_APPRENTICE_DEVELOP_GUIDE = 510
UIConst.RD_HINT_APPRENTICE_BATTLE_GUIDE = 511
UIConst.RD_HINT_HERO_SEASON_RELIC = 520
UIConst.RD_HINT_HERO_SEASON_RELIC_UNLOCK = 521
UIConst.RD_HINT_HERO_SEASON_RELIC_UPLV = 522
UIConst.RD_HINT_HERO_SEASON_RELIC_FIRST_SHOW = 523
UIConst.RD_HINT_HERO_STICK_LVUP = 534
UIConst.RD_HINT_DYNAMIC_COUNTER = 1000

local REDDOT_F2C_MAP = {
	[UIConst.RD_HINT_A] = {
		UIConst.RD_HINT_B
	},
	[UIConst.RD_HINT_QQ_PRIVILEGE] = {
		UIConst.RD_HINT_QQ_PRIVILEGE_ONCE,
		UIConst.RD_HINT_QQ_PRIVILEGE_ACHIEVE,
		UIConst.RD_HINT_QQ_PRIVILEGE_DAY
	},
	[UIConst.RD_HINT_ACHIEVE_TASK] = {
		UIConst.RD_HINT_TRUNK_ACHIEVE,
		UIConst.RD_HINT_BRANCH_ACHIEVE
	},
	[UIConst.RD_HINT_TASK_MAIN] = {
		UIConst.RD_HINT_DAILY_TASK,
		UIConst.RD_HINT_WEEKLY_TASK,
		UIConst.RD_HINT_ACHIEVE_TASK
	},
	[UIConst.RD_HINT_HERO] = {
		UIConst.RD_HINT_HERO_STEP_UP,
		UIConst.RD_HINT_HERO_EQUIP,
		UIConst.RD_HINT_HERO_STAR_UP,
		UIConst.RD_HINT_HERO_SELL,
		UIConst.RD_HINT_HERO_STEP_CAN_SWEEP,
		UIConst.RD_HINT_HERO_NEW_FIVE,
		UIConst.RD_HINT_HERO_BASE,
		UIConst.RD_HINT_HERO_SKIN,
		UIConst.RD_HINT_HERO_STEP_QUICK_SWEEP,
		UIConst.RD_HINT_PAINT_PLUS,
		UIConst.RD_HINT_HERO_SEASON_RELIC,
		UIConst.RD_HINT_HERO_STICK_LVUP
	},
	[UIConst.RD_HINT_DRAWCARD] = {
		UIConst.RD_HINT_DRAWCARD_STANDARD,
		UIConst.RD_HINT_DRAWCARD_NEWBIE,
		UIConst.RD_HINT_DRAWCARD_STANDARD_ITEM,
		UIConst.RD_HINT_DRAWCARD_GROUP
	},
	[UIConst.RD_HINT_FRIEND] = {
		UIConst.RD_HINT_FRIEND_REQUEST,
		UIConst.RD_HINT_FRIEND_GIFT
	},
	[UIConst.RD_HINT_OTHER_BATTLE] = {
		UIConst.RD_HINT_CHALLENGE_BOSS_ALL,
		UIConst.RD_HINT_MAZE
	},
	[UIConst.RD_HINT_HANDBOOK] = {
		UIConst.RD_SIGNET,
		UIConst.RD_HINT_HANDBOOK_AWARD,
		UIConst.RD_HINT_PROFICIENT,
		UIConst.RD_HINT_PLOTREWIND,
		UIConst.RD_HINT_RELATION
	},
	[UIConst.RD_HINT_PVP] = {
		UIConst.RD_HINT_PVP_FORMATION,
		UIConst.RD_HINT_PVP_RECORD
	},
	[UIConst.RD_HINT_MAIL] = {
		UIConst.RD_HINT_MAIL_UNREAD
	},
	[UIConst.RD_HINT_BAG] = {
		UIConst.RD_HINT_BAG_MATERIAL,
		UIConst.RD_HINT_BAG_SHATTER,
		UIConst.RD_HINT_BAG_RELIC,
		UIConst.RD_HINT_BAG_EQUIP
	},
	[UIConst.RD_HINT_BAG_EQUIP] = {
		UIConst.RD_HINT_EQUIP_RECYCLE_AWARD
	},
	[UIConst.RD_HINT_MAINSETTING] = {
		UIConst.RD_HINT_CUSTOMER,
		UIConst.RD_HINT_NOTICE
	},
	[UIConst.RD_HINT_REAR_HOUSE_CRYSTLE] = {
		UIConst.RD_HINT_REAR_HOUSE_CRYSTLE_UP,
		UIConst.RD_HINT_REAR_HOUSE_ACHIEVE,
		UIConst.RD_HINT_REAR_HOUSE_LEVEL_ACHIEVE
	},
	[UIConst.RD_HINT_REAR_HOUSE] = {
		UIConst.RD_HINT_REAR_HOUSE_UPGREAD_BTN,
		UIConst.RD_HINT_REAR_HOUSE_NEW_ITEM,
		UIConst.RD_HINT_DISPATCH_AWARD,
		UIConst.RD_HINT_COMFORTABLE_AWARD,
		UIConst.RD_HINT_REAR_HOUSE_CLEAN,
		UIConst.RD_HINT_REAR_HOUSE_POPULARITY_AWARD
	},
	[UIConst.RD_HINT_REAR_HOUSE_UPGREAD] = {
		UIConst.RD_HINT_REAR_HOUSE_UPGREAD_BTN
	},
	[UIConst.RD_HINT_NEW_ROLE_DRESS] = {
		UIConst.RD_HINT_NEW_HEAD,
		UIConst.RD_HINT_NEW_HEAD_FRAME,
		UIConst.RD_HINT_NEW_PENDANT,
		UIConst.RD_HINT_NEW_CHAT_BUBBLE
	},
	[UIConst.RD_HINT_ALL_NEWBIE_TASK] = {
		UIConst.RD_HINT_NEWBIE_TASK
	},
	[UIConst.RD_HINT_CIRCLE] = {
		UIConst.RD_HINT_CIRCLE_SIGN,
		UIConst.RD_HINT_CIRCLE_EDIT_HEAD,
		UIConst.RD_HINT_CIRCLE_INVITED
	},
	[UIConst.RD_HINT_HOME] = {
		UIConst.RD_HINT_REAR_HOUSE,
		UIConst.RD_HINT_HANDBOOK,
		UIConst.RD_HINT_HANDBOOK_MONUMENT
	},
	[UIConst.RD_HINT_EQUIPTOWER] = {
		UIConst.RD_HINT_EQUIPTOWER1,
		UIConst.RD_HINT_EQUIPTOWER2,
		UIConst.RD_HINT_EQUIPTOWER3
	},
	[UIConst.RD_HINT_SENIORPVP] = {
		UIConst.RD_HINT_SENIORPVP_FORMATION,
		UIConst.RD_HINT_SENIORPVP_RECORD,
		UIConst.RD_HINT_SENIORPVP_AWARD
	},
	[UIConst.RD_HINT_PVP_ENTER] = {
		UIConst.RD_HINT_PVP,
		UIConst.RD_HINT_SENIORPVP
	},
	[UIConst.RD_HINT_WORLDBOSS] = {
		UIConst.RD_HINT_WORLDBOSS_CHALLENGE,
		UIConst.RD_HINT_ELITE_WORLDBOSS_CHALLENGE
	},
	[UIConst.RD_HINT_OPACTPVP] = {
		UIConst.RD_HINT_OPACTPVP_FORMATION,
		UIConst.RD_HINT_OPACTPVP_CHALLENGE,
		UIConst.RD_HINT_OPACTPVP_REPORT,
		UIConst.RD_HINT_OPACTPVP_PART_CHANGE
	},
	[UIConst.RD_HINT_RENT_MESSAGE] = {
		UIConst.RD_HINT_RENT_NEWREQ,
		UIConst.RD_HINT_RENT_NEWLETTER
	},
	[UIConst.RD_HINT_RENT_MAIN] = {
		UIConst.RD_HINT_RENT_NEWTASK,
		UIConst.RD_HINT_RENT_UNSELECT,
		UIConst.RD_HINT_RENT_BORROW,
		UIConst.RD_HINT_RENT_FORAMTIONLACK,
		UIConst.RD_HINT_RENT_MESSAGE,
		UIConst.RD_HINT_RENT_NEWSENDLETTER
	},
	[UIConst.RD_HINT_CIRCLE_BATTLE] = {
		UIConst.RD_HINT_CIRCLE_BATTLE_POINT_ACHIEVE,
		UIConst.RD_HINT_CIRCLE_BATTLE_ACTION_POINT
	},
	[UIConst.RD_HINT_CHALLENGE_BOSS_ALL] = {
		UIConst.RD_HINT_CHALLENGE_BOSS,
		UIConst.RD_HINT_CHALLENGE_BOSS_EXPAND
	},
	[UIConst.RD_HINT_CHAT] = {
		UIConst.RD_HINT_CHAT_PRIVATE,
		UIConst.RD_HINT_CHAT_DYNAMIC_ICON_NEW,
		UIConst.RD_HINT_CHAT_MASTER_APPRENTICE
	},
	[UIConst.RD_HINT_MAIN_HEAD] = {
		UIConst.RD_HINT_SIGN,
		UIConst.RD_HINT_FUNCENTRY_DIAMOND
	},
	[UIConst.RD_HINT_PET] = {
		UIConst.RD_HINT_PET_STAR_UP,
		UIConst.RD_HINT_PET_LEVEL_UP,
		UIConst.RD_HINT_PET_WEAR_AMULET,
		UIConst.RD_HINT_PET_AMULET_STAR_UP,
		UIConst.RD_HINT_PET_AMULET_RECYCLE,
		UIConst.RD_HINT_PET_GEM_UP,
		UIConst.RD_HINT_PET_WEAR_GEM,
		UIConst.RD_HINT_PET_DRAW,
		UIConst.RD_HINT_PET_RUNE
	},
	[UIConst.RD_HINT_PET_MAZE] = {
		UIConst.RD_HINT_PET_MAZE_ACHI,
		UIConst.RD_HINT_PET_MAZE_BOSS,
		UIConst.RD_HINT_PET_MAZE_NEW_SEASON
	},
	[UIConst.RD_HINT_MAIN_MAZE] = {
		UIConst.RD_HINT_MAZE,
		UIConst.RD_HINT_PET_MAZE
	},
	[UIConst.RD_HINT_PAINT_PLUS] = {
		UIConst.RD_HINT_PAINT_PLUS_MAIN_LEVEL,
		UIConst.RD_HINT_PAINT_PLUS_RELATE_LEVEL
	},
	[UIConst.RD_HINT_SNEAK_BATTLE] = {
		UIConst.RD_HINT_SNEAK_BATTLE_AWARD,
		UIConst.RD_HINT_SNEAK_BATTLE_NEW_LEVEL,
		UIConst.RD_HINT_SNEAK_BATTLE_HERO_RELIC
	},
	[UIConst.RD_HINT_EQUIP_RECYCLE] = {
		UIConst.RD_HINT_EQUIP_RECYCLE_AWARD
	},
	[UIConst.RD_HINT_EQUIP_RECYCLE_AWARD] = {
		UIConst.RD_HINT_EQUIP_RECYCLE_AWARD_NORMAL,
		UIConst.RD_HINT_EQUIP_RECYCLE_AWARD_RENT
	},
	[UIConst.RD_HINT_MASTER_APPRENTICE_MAIN] = {
		UIConst.RD_HINT_HANDBOOK_MONUMENT,
		UIConst.RD_HINT_MASTER_APPRENTICE_INVITE,
		UIConst.RD_HINT_MASTER_APPRENTICE_TASK,
		UIConst.RD_HINT_MASTER_LV_AWARD,
		UIConst.RD_HINT_APPRENTICE_GRADUATE,
		UIConst.RD_HINT_APPRENTICE_DEVELOP_GUIDE,
		UIConst.RD_HINT_APPRENTICE_BATTLE_GUIDE
	},
	[UIConst.RD_HINT_HERO_SEASON_RELIC] = {
		UIConst.RD_HINT_HERO_SEASON_RELIC_UNLOCK,
		UIConst.RD_HINT_HERO_SEASON_RELIC_UPLV
	}
}
local ResBossTower = require("ClientData/ResBossTower")

REDDOT_F2C_MAP[UIConst.RD_HINT_CHALLENGE_BOSS] = {}

for bossType, bossData in pairs(ResBossTower) do
	UIConst["RD_HINT_CHALLENGE_BOSS_" .. bossType] = UIConst.RD_HINT_CHALLENGE_BOSS + bossType

	table.insert(REDDOT_F2C_MAP[UIConst.RD_HINT_CHALLENGE_BOSS], UIConst["RD_HINT_CHALLENGE_BOSS_" .. bossType])
end

REDDOT_F2C_MAP[UIConst.RD_HINT_CHALLENGE_BOSS_EXPAND] = {}

for bossType, bossData in pairs(ResBossTower) do
	UIConst["RD_HINT_CHALLENGE_BOSS_EXPAND_" .. bossType] = UIConst.RD_HINT_CHALLENGE_BOSS_EXPAND + bossType

	table.insert(REDDOT_F2C_MAP[UIConst.RD_HINT_CHALLENGE_BOSS_EXPAND], UIConst["RD_HINT_CHALLENGE_BOSS_EXPAND_" .. bossType])
end

for i = 1, Const.REARHOUSE_WALL_NUM do
	UIConst["RD_HINT_REAR_HOUSE_EDIT" .. i] = UIConst.RD_HINT_REAR_HOUSE_EDIT + i

	table.insert(REDDOT_F2C_MAP[UIConst.RD_HINT_REAR_HOUSE], UIConst["RD_HINT_REAR_HOUSE_EDIT" .. i])
end

function UIConst.generateDynamicRDEvent()
	UIConst.RD_HINT_DYNAMIC_COUNTER = UIConst.RD_HINT_DYNAMIC_COUNTER + 1

	return UIConst.RD_HINT_DYNAMIC_COUNTER
end

UIConst.RD_CONDITION_MAP = {
	[UIConst.RD_HINT_NEWBIE_TASK] = Const.CONDITION_LIMIT_NEWBIE_TASK,
	[UIConst.RD_HINT_DRAWCARD] = Const.CONDITION_LIMIT_DRAW,
	[UIConst.RD_HINT_MALL] = Const.CONDITION_LIMIT_SHOP,
	[UIConst.RD_HINT_HANDBOOK] = Const.CONDITION_LIMIT_HANDBOOK,
	[UIConst.RD_HINT_HANDBOOK_MONUMENT] = Const.CONDITION_LIMIT_MONUMENT,
	[UIConst.RD_HINT_REAR_HOUSE] = Const.CONDITION_LIMIT_YARD,
	[UIConst.RD_HINT_FUNCENTRY_DIAMOND] = Const.CONDITION_LIMIT_RECHARGE,
	[UIConst.RD_HINT_HANDBOOK_AWARD] = Const.CONDITION_LIMIT_HANDBOOK_HERO,
	[UIConst.RD_HINT_RELATION] = Const.CONDITION_LIMIT_RELATION
}
UIConst.CONDITION_RD_MAP = {}

for rdHint, conditionId in pairs(UIConst.RD_CONDITION_MAP) do
	UIConst.CONDITION_RD_MAP[conditionId] = rdHint
end

UIConst.RD_MALL_NEW_SUB_TAB = {}
UIConst.RD_MAIL_TYPE = {
	UIConst.RD_HINT_MALL,
	UIConst.RD_HINT_MALL,
	[4] = UIConst.RD_HINT_FUNCENTRY_DIAMOND
}
UIConst.RD_HINT_MALL_TAB = {}
UIConst.RD_HINT_ACTIVITY_CONFIG = {}
UIConst.RD_HINT_MALL_ALL_HINT = {}

local ResMall = require("ClientData/ResMall")
local ResMallSubPanelConfig = require("ClientData/ResMallSubPanelConfig")

for tabId, tabInfo in pairs(ResMall) do
	local tabHintId = UIConst.generateDynamicRDEvent()

	REDDOT_F2C_MAP[tabHintId] = {}

	local hintTable = {}

	for _, subId in ipairs(tabInfo.contents or {}) do
		local configData = ResMallSubPanelConfig[subId]
		local subHintId, onceNewRD

		if configData and configData.needNoticeNew == 1 then
			onceNewRD = UIConst.generateDynamicRDEvent()
			UIConst.RD_MALL_NEW_SUB_TAB[subId] = onceNewRD
		end

		if configData and configData.redHint then
			if onceNewRD then
				subHintId = UIConst.generateDynamicRDEvent()
				REDDOT_F2C_MAP[subHintId] = {}

				table.insert(REDDOT_F2C_MAP[subHintId], onceNewRD)
				table.insert(REDDOT_F2C_MAP[subHintId], configData.redHint)

				configData.redHint = subHintId
			else
				subHintId = configData.redHint
			end
		elseif configData.limitTypeExtra == 1 then
			local actNewHintId = UIConst.generateDynamicRDEvent()
			local actId = configData.limitConditionExtra

			if actId then
				UIConst.RD_HINT_ACTIVITY_CONFIG[actId] = actNewHintId
			end

			if onceNewRD then
				subHintId = UIConst.generateDynamicRDEvent()
				REDDOT_F2C_MAP[subHintId] = {}

				table.insert(REDDOT_F2C_MAP[subHintId], onceNewRD)
				table.insert(REDDOT_F2C_MAP[subHintId], actNewHintId)
			else
				subHintId = actNewHintId
			end

			configData.redHint = subHintId
		elseif onceNewRD then
			subHintId = onceNewRD
			configData.redHint = subHintId
		end

		if subHintId then
			table.insert(REDDOT_F2C_MAP[tabHintId], subHintId)
			table.insert(UIConst.RD_HINT_MALL_ALL_HINT, subHintId)
		end
	end

	local rdMallType = UIConst.RD_MAIL_TYPE[tabInfo.type]

	if rdMallType then
		if not REDDOT_F2C_MAP[rdMallType] then
			REDDOT_F2C_MAP[rdMallType] = {}
		end

		table.insert(REDDOT_F2C_MAP[rdMallType], tabHintId)
	end

	UIConst.RD_HINT_MALL_TAB[tabId] = tabHintId
end

for fKey, cKeys in pairs(REDDOT_F2C_MAP) do
	for _, cKey in ipairs(cKeys) do
		RedDotManager.setKeyRelation(cKey, fKey)
	end
end

UIConst.AVG_TALK_TYPE_LEFT = 0
UIConst.AVG_TALK_TYPE_RIGHT = 1
UIConst.AVG_TALK_TYPE_OS = 2
UIConst.AVG_TALK_TYPE_ASIDE = 3
UIConst.AVG_TALK_TYPE_BRANCH = 4
UIConst.AVG_TALK_TYPE_BOOM = 5
UIConst.AVG_TALK_TYPE_SPECIALOPT = 6
UIConst.AVG_TALK_TYPE_INTRODUCTION = 7
UIConst.AVG_TALK_TYPE_CHAPTEREND = 8
UIConst.AVG_TALK_TYPE_ASIDEBLACK = 9
UIConst.AVG_TALK_TYPE_SECTIONINTRO = 10
UIConst.AVG_TALK_TYPE_VIDEO = 11
UIConst.AVG_TALK_TYPE_IDCARD = 12
UIConst.AVG_TALK_TERMINAL_LEFT = 13
UIConst.AVG_TALK_TERMINAL_BLOOM = 14
UIConst.AVG_TALK_TYPE_LIVE = 15
UIConst.AVG_TALK_TYPE_POSTER = 16
UIConst.AVG_TERMINAL_TYPE_NONE = 0
UIConst.AVG_TERMINAL_TYPE_CALLOUT = 1
UIConst.AVG_TERMINAL_TYPE_CALLIN = 2
UIConst.AVG_TERMINAL_TYPE_TALK = 3
UIConst.AVG_TERMINAL_TYPE_END = 4
UIConst.AVG_TERMINAL_TYPE_OPEN = 5
UIConst.AVG_BG_FAKERECORDER = 1
UIConst.AVG_BG_MEMORY = 2
UIConst.ROLEIMAGE_SHOWTYPE_HANDBOOK = "handbook"
UIConst.ROLEIMAGE_SHOWTYPE_HERO_GET = "hero_get"
UIConst.ROLEIMAGE_SHOWTYPE_BATTLE_SKILL = "battle_skill"
UIConst.ROLEIMAGE_SHOWTYPE_DRAW_CARD = "draw_card"
UIConst.ROLEIMAGE_SHOWTYPE_STAR_UP = "star_up"
UIConst.ROLEIMAGE_SHOWTYPE_GET_SKIN = "get_skin"
UIConst.ROLEIMAGE_SHOWTYPE_BUY_SKIN = "buy_skin"
UIConst.ROLEIMAGE_SHOWTYPE_SHOW_SKIN = "show_skin"
UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK = "rent_task"
UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK_DETAIL = "rent_task_detail"
UIConst.ROLEIMAGE_SHOWTYPE_HERO_DROP = "hero_drop"
UIConst.ROLEIMAGE_SHOWTYPE_NEW_MAZE_UPHERO = "new_maze_up_hero"
UIConst.AVG_OPT_MODE_PRESS = 1
UIConst.AVG_OPT_MODE_CLICK = 2
UIConst.PLOT_REWIND_MAIN_LINE = 1
UIConst.PLOT_REWIND_SIDE_LINE = 2
UIConst.DETAIL_CELL_WIDTH = 684
UIConst.DETAIL_CELL_HEIGHT = 154
UIConst.CHAPTER_CELL_WIDTH = 684
UIConst.CHAPTER_CELL_HEIGHT = 200
UIConst.AVG_DEFAULT_BG_MATERIAL = "UI/GUIRes/Material/UITransSquare.mat"
UIConst.PET_PORTRAIT_02_DEFAULT_MATERIAL = "Res/Effects/Materials/mask_rc_01.mat"
UIConst.PET_PORTRAIT_02_GET_NEW_MATERIAL = "Res/Effects/Materials/mask_rc_02.mat"
UIConst.SERVER_BULLET_NONE = 1
UIConst.SERVER_BULLET_EXIST = 2
UIConst.SERVER_BULLET_UNKNOWN = 3
UIConst.AVG_BULLET_TEXT = 101
UIConst.AVG_BULLET_EMOJI = 102
UIConst.AVG_BULLET_MOVEEMOJI = 103
UIConst.ACTIVITY_ID_SNOW_OR_NIGHT_BP = 1605
UIConst.NEED_HINT_NEW_UNLOCK_GIFT = {
	[UIConst.ACTIVITY_ID_SNOW_OR_NIGHT_BP] = 1
}
UIConst.MIKU_CONCERT = 2102
UIConst.AI_CHANNEL = 2103
UIConst.AI_CHANNEL2 = 2104
UIConst.CONCERT_SCROLL_HORIZONTAL = 1
UIConst.CONCERT_SCROLL_VERTICAL = 2
UIConst.CONCERT_REWARD_COMMON = 1
UIConst.CONCERT_REWARD_SHOWGIFT = 2
UIConst.CONCERT_SCROLL_TYPE = {
	UIConst.CONCERT_SCROLL_HORIZONTAL,
	UIConst.CONCERT_SCROLL_VERTICAL
}
UIConst.CONCERT_GIFT_EFFECT = {
	[UIConst.MIKU_CONCERT] = 1
}
UIConst.CONFIRM_ONEBTN = 1
UIConst.CONFIRM_TWOBTN = 2
UIConst.CONFIRM_INPUT = 3
UIConst.CONFIRM_ONEBTN_DENY = 4
UIConst.CONFIRM_ITEM = 5
UIConst.CONFIRM_THREEBTN = 6
UIConst.SKILL_PANEL_HERO_BASE = 1
UIConst.SKILL_PANEL_HANDBOOK = 2
UIConst.SKILL_PANEL_HERO_STEP = 3
UIConst.SKILL_PANEL_ROLE_INFO = 4
UIConst.SKILL_PANEL_WORLD_BOSS = 5
UIConst.SKILL_PANEL_WORLD_BOSS_NEXT = 6
UIConst.SKILL_TIPS_INFO = {
	[UIConst.SKILL_PANEL_HERO_BASE] = {
		nodePath = "SkillPanel/SkillTipsPanel"
	},
	[UIConst.SKILL_PANEL_HANDBOOK] = {
		nodePath = "MainInfoPanel/HeroContentBaseInfoPanel/SkillPanel/SkillTipsPanel"
	},
	[UIConst.SKILL_PANEL_HERO_STEP] = {
		nodePath = "SkillTipsPanel"
	},
	[UIConst.SKILL_PANEL_ROLE_INFO] = {
		nodePath = "HeroContentPanel/HeroContentBaseInfoPanel/SkillPanel/SkillTipsPanel"
	},
	[UIConst.SKILL_PANEL_WORLD_BOSS] = {
		maxHeight = 530,
		nodePath = "MainInfoPanel/InfoPanel/BossInfo/SkillTipsPanel",
		pivot = {
			0.5,
			1
		}
	},
	[UIConst.SKILL_PANEL_WORLD_BOSS_NEXT] = {
		nodePath = "BgPanel/BossInfo/SkillTipsPanel"
	}
}
UIConst.SKILL_TYPE_PATH = {
	[Const.HERO_SKILL_FIELD.ATTACK] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"IconActive"
	},
	[Const.HERO_SKILL_FIELD.SKILL] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"IconUltimate"
	},
	[Const.HERO_SKILL_FIELD.HERO_PASSIVE] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"IconAuto"
	},
	[Const.HERO_SKILL_FIELD.ENTER_PASSIVE] = {
		"Atlas/CommonAtlas/GridAtlas/GridAtlas",
		"IconSpecial"
	}
}
UIConst.HERO_DEFAULT_SORT_MAP = {
	{
		name = "level",
		text = Lang.get(1203)
	},
	{
		name = "star",
		text = Lang.get(1204)
	},
	{
		name = "inCry",
		hide = 1,
		text = Lang.get(30099)
	},
	{
		name = "step",
		hide = 1,
		text = Lang.get(1105)
	},
	{
		name = "quality",
		hide = 1,
		text = Lang.get(372)
	}
}
UIConst.HERO_MAZE_SORT_MAP = {
	{
		name = "mazeStatus",
		text = Lang.get(30100)
	},
	{
		name = "mazeHpStep",
		text = Lang.get(30101)
	},
	{
		name = "level",
		text = Lang.get(1203)
	},
	{
		name = "star",
		text = Lang.get(1204)
	},
	{
		name = "inCry",
		hide = 1,
		text = Lang.get(30099)
	},
	{
		name = "step",
		hide = 1,
		text = Lang.get(1105)
	},
	{
		name = "quality",
		hide = 1,
		text = Lang.get(372)
	}
}
UIConst.HERO_SNEAK_BATTLE_SORT_MAP = {
	{
		name = "sneakState",
		text = Lang.get(30100)
	},
	{
		name = "sneakStage",
		hide = 1,
		text = Lang.get(93810)
	},
	{
		name = "level",
		text = Lang.get(1203)
	},
	{
		name = "star",
		text = Lang.get(1204)
	},
	{
		name = "inCry",
		hide = 1,
		text = Lang.get(30099)
	},
	{
		name = "step",
		hide = 1,
		text = Lang.get(1105)
	},
	{
		name = "quality",
		hide = 1,
		text = Lang.get(372)
	}
}
UIConst.HERO_SNEAK_BATTLE_FORMATION_SORT_MAP = {
	{
		name = "recommend",
		text = Lang.get(319)
	},
	{
		name = "star",
		text = Lang.get(1204)
	}
}
UIConst.HERO_SNEAK_BATTLE_PRE_FORMATION_SORT_MAP = {
	{
		name = "canUse",
		text = Lang.get(97828)
	},
	{
		name = "power",
		text = Lang.get(657)
	}
}
UIConst.HERO_MAZE_SORT_MAP_HP = {
	{
		name = "mazeHpStep",
		text = Lang.get(30101)
	},
	{
		name = "mazeStatus",
		text = Lang.get(30100)
	},
	{
		name = "level",
		text = Lang.get(1203)
	},
	{
		name = "star",
		text = Lang.get(1204)
	},
	{
		name = "inCry",
		hide = 1,
		text = Lang.get(30099)
	},
	{
		name = "step",
		hide = 1,
		text = Lang.get(1105)
	},
	{
		name = "quality",
		hide = 1,
		text = Lang.get(372)
	}
}
UIConst.SELL_HERO_SORT_MAP = {
	{
		name = "star",
		text = Lang.get(1204)
	},
	{
		name = "realLevel",
		text = Lang.get(1203)
	},
	{
		name = "step",
		hide = 1,
		text = Lang.get(1105)
	},
	{
		name = "quality",
		hide = 1,
		text = Lang.get(372)
	}
}
UIConst.HERO_CLAN_CLEAR_SORT = {
	{
		name = "clanClearState",
		hide = 1,
		forceTop = 1,
		text = Lang.get(40572)
	},
	{
		name = "level",
		text = Lang.get(1203)
	},
	{
		name = "star",
		text = Lang.get(1204)
	},
	{
		name = "inCry",
		hide = 1,
		text = Lang.get(30099)
	},
	{
		name = "step",
		hide = 1,
		text = Lang.get(1105)
	},
	{
		name = "quality",
		hide = 1,
		text = Lang.get(372)
	}
}
UIConst.HERO_DEFAULT_FILTER_MAP = {
	{
		title = Lang.get(373),
		data = {
			{
				Const.CAMP_CONFIG[1].name,
				"camp",
				1
			},
			{
				Const.CAMP_CONFIG[2].name,
				"camp",
				2
			},
			{
				Const.CAMP_CONFIG[3].name,
				"camp",
				3
			}
		}
	},
	{
		title = Lang.get(374),
		data = {
			{
				Const.CAREER_CONFIG[1].name,
				"career",
				1
			},
			{
				Const.CAREER_CONFIG[2].name,
				"career",
				2
			},
			{
				Const.CAREER_CONFIG[3].name,
				"career",
				3
			},
			{
				Const.CAREER_CONFIG[4].name,
				"career",
				4
			},
			{
				Const.CAREER_CONFIG[5].name,
				"career",
				5
			}
		}
	}
}
UIConst.HERO_MAZE_FILTER_MAP = {
	{
		title = Lang.get(373),
		data = {
			{
				Const.CAMP_CONFIG[1].name,
				"camp",
				1
			},
			{
				Const.CAMP_CONFIG[2].name,
				"camp",
				2
			},
			{
				Const.CAMP_CONFIG[3].name,
				"camp",
				3
			}
		}
	},
	{
		title = Lang.get(374),
		data = {
			{
				Const.CAREER_CONFIG[1].name,
				"career",
				1
			},
			{
				Const.CAREER_CONFIG[2].name,
				"career",
				2
			},
			{
				Const.CAREER_CONFIG[3].name,
				"career",
				3
			},
			{
				Const.CAREER_CONFIG[4].name,
				"career",
				4
			},
			{
				Const.CAREER_CONFIG[5].name,
				"career",
				5
			}
		}
	},
	{
		title = Lang.get(30101),
		data = {
			{
				Lang.get(30102),
				"mazeHpStep",
				{
					0.01,
					100
				}
			},
			{
				Lang.get(30103),
				"mazeHpStep",
				0
			}
		}
	}
}

local FILTER_CAREER_MAP = {
	atlas = "Atlas/HeroAtlas/HeroCardCommonAtlas",
	title = Lang.get(374),
	data = {
		{
			"IconCareerS01",
			"career",
			1
		},
		{
			"IconCareerS02",
			"career",
			2
		},
		{
			"IconCareerS03",
			"career",
			3
		},
		{
			"IconCareerS04",
			"career",
			4
		},
		{
			"IconCareerS05",
			"career",
			5
		}
	}
}
local FILTER_GROUP_MAP = {
	atlas = "Atlas/HeroAtlas/HeroCardCommonAtlas",
	title = Lang.get(373),
	data = {
		{
			"IconGroupS01",
			"camp",
			1
		},
		{
			"IconGroupS02",
			"camp",
			2
		},
		{
			"IconGroupS03",
			"camp",
			3
		},
		{
			"IconGroupS04",
			"camp",
			4
		},
		{
			"IconGroupS05",
			"camp",
			5
		}
	}
}
local MULTI_FILTER_TEAM_MAP = {
	atlas = "Atlas/CommonAtlas/IconTeamAtlas",
	title = Lang.get(1178),
	data = {
		{
			"IconTeamLittle01",
			"team",
			1
		},
		{
			"IconTeamLittle02",
			"team",
			2
		},
		{
			"IconTeamLittle03",
			"team",
			3
		},
		{
			"IconTeamLittle04",
			"team",
			4
		},
		{
			"IconTeamLittle05",
			"team",
			5
		},
		{
			"IconTeamLittle06",
			"team",
			6
		}
	}
}

UIConst.EQUIP_FILTER_GROUP_MAP = {
	atlas = "Atlas/CommonAtlas/IconAtlas/EquipAtlas/00",
	title = Lang.get(101564),
	data = {
		{
			"00Nml",
			"part",
			1
		},
		{
			"01Nml",
			"part",
			2
		},
		{
			"02Nml",
			"part",
			3
		},
		{
			"03Nml",
			"part",
			4
		},
		{
			"04Nml",
			"part",
			5
		},
		{
			"05Nml",
			"part",
			6
		}
	}
}

local FILTER_TEAM_MAP = {
	atlas = "Atlas/HeroAtlas/HeroCardCommonAtlas",
	title = Lang.get(1178),
	data = {
		{
			"IconTeam01",
			"team",
			1
		},
		{
			"IconTeam02",
			"team",
			2
		},
		{
			"IconTeam03",
			"team",
			3
		},
		{
			"IconTeam04",
			"team",
			4
		},
		{
			"IconTeam05",
			"team",
			5
		},
		{
			"IconTeam06",
			"team",
			6
		}
	}
}

UIConst.EQUIP_DEFAULT_SORT_MAP = {
	{
		name = "sortQuality",
		text = Lang.get(372)
	},
	{
		name = "sortDefineId",
		hide = 1,
		text = Lang.get(51403)
	},
	{
		name = "enhanceLevel",
		text = Lang.get(920)
	},
	{
		name = "suitId",
		text = Lang.get(50273)
	}
}
UIConst.FILTER_TYPE_SINGLE_SEL = 1
UIConst.FILTER_TYPE_MULTI_SEL = 2
UIConst.HERO_DEFAULT_FILTER_PANEL_MAP = {
	FILTER_GROUP_MAP,
	FILTER_CAREER_MAP
}
UIConst.HERO_NO_CAMP_FILTER_PANEL_MAP = {
	FILTER_CAREER_MAP
}
UIConst.HERO_MAZE_FILTER_PANEL_NO_CAMP_MAP = {
	FILTER_CAREER_MAP
}
UIConst.HERO_MAZE_FILTER_PANEL_MAP = {
	FILTER_GROUP_MAP,
	FILTER_CAREER_MAP
}
UIConst.CLAN_CLEAR_FILTER_PANEL_MAP = {
	FILTER_GROUP_MAP,
	FILTER_CAREER_MAP,
	FILTER_TEAM_MAP
}
UIConst.WEAR_FILTER_PANEL_MAP = {
	{
		type = UIConst.FILTER_TYPE_SINGLE_SEL,
		map = FILTER_GROUP_MAP
	},
	{
		type = UIConst.FILTER_TYPE_SINGLE_SEL,
		map = FILTER_CAREER_MAP
	},
	{
		type = UIConst.FILTER_TYPE_MULTI_SEL,
		map = MULTI_FILTER_TEAM_MAP
	}
}
UIConst.HANDBOOK_FILTER_PANEL_MAP = {
	{
		type = UIConst.FILTER_TYPE_SINGLE_SEL,
		map = FILTER_GROUP_MAP
	},
	{
		type = UIConst.FILTER_TYPE_SINGLE_SEL,
		map = FILTER_CAREER_MAP
	},
	{
		type = UIConst.FILTER_TYPE_SINGLE_SEL,
		map = FILTER_TEAM_MAP
	}
}
UIConst.SIGNET_VERTICAL_FILTER_MAP = {
	{
		name = "all",
		text = Lang.get(370)
	},
	{
		name = "have",
		text = Lang.get(152)
	},
	{
		name = "noHave",
		text = Lang.get(519)
	}
}

local ResGamePlayNotice = require("ClientData/ResGamePlayNotice")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")

UIConst.RANK_UI_INFO = {
	[Const.RANK_TYPE_ONCETOWER] = {
		title = ResGamePlayNotice[Const.GAME_PLAY_NOTICE_ONCE_TOWER].name,
		title2 = Lang.get(30104)
	},
	[Const.RANK_TYPE_BOSSTOWER1] = {
		title = ResBossTower[1][1].name,
		title2 = Lang.get(30105)
	},
	[Const.RANK_TYPE_BOSSTOWER2] = {
		title = ResBossTower[2][1].name,
		title2 = Lang.get(30105)
	},
	[Const.RANK_TYPE_BOSSTOWER3] = {
		title = ResGamePlayNotice[Const.GAME_PLAY_NOTICE_CHALLENGE_BOSS].name,
		title2 = Lang.get(30106)
	},
	[Const.RANK_TYPE_BOSSTOWER4] = {
		title = ResGamePlayNotice[Const.GAME_PLAY_NOTICE_CHALLENGE_BOSS].name,
		title2 = Lang.get(30105)
	},
	[Const.RANK_TYPE_MAINSTAGE] = {
		title = Lang.get(29924),
		title2 = Lang.get(30104)
	},
	[Const.RANK_TYPE_ASYNCPVP] = {
		hideTime = 1,
		title = ResGamePlayNotice[Const.GAME_PLAY_NOTICE_ARENA].name,
		title2 = Lang.get(318)
	},
	[Const.RANK_TYPE_GROUP1] = {
		title = string.format(Lang.get(30083), ResHeroCampCareerConfig[1][1].name),
		title2 = Lang.get(30107)
	},
	[Const.RANK_TYPE_GROUP2] = {
		title = string.format(Lang.get(30083), ResHeroCampCareerConfig[1][2].name),
		title2 = Lang.get(30107)
	},
	[Const.RANK_TYPE_GROUP3] = {
		title = string.format(Lang.get(30083), ResHeroCampCareerConfig[1][3].name),
		title2 = Lang.get(30107)
	},
	[Const.RANK_TYPE_MULTIPVP] = {
		hideTime = 1,
		title = "",
		title2 = ""
	},
	[Const.RANK_TYPE_WORLDBOSS] = {
		showSvrName = 1,
		showPanelTime = 1,
		showBtnAward = 1,
		title2 = "",
		title = Lang.get(1447)
	},
	[Const.RANK_TYPE_ACTIVITY_PLOT] = {
		hideTime = 1,
		title = Lang.get(30108),
		title2 = Lang.get(30109)
	},
	[Const.RANK_TYPE_OPACTPVP] = {
		hideTime = 1,
		title = "",
		title2 = ""
	},
	[Const.RANK_TYPE_HOUSEFAVOR] = {
		hideTime = 1,
		title2 = "",
		title = Lang.get(30110)
	},
	[Const.RANK_TYPE_SEASON_TOWER_SCORE] = {
		showSvrName = 1,
		showPanelTime = 1,
		showBtnAward = 1,
		title = Lang.get(1628),
		title2 = Lang.get(337)
	},
	[Const.RANK_TYPE_SEASON_TOWER_LAYER] = {
		showSvrName = 1,
		showPanelTime = 1,
		hideTitle2 = 1,
		title = Lang.get(30111),
		title2 = Lang.get(30112)
	},
	[Const.RANK_TYPE_CIRCLE_BATTLE_FEAT] = {
		showBtnAward = 1,
		showPanelTime = 1,
		hideTitle2 = 1,
		title = Lang.get(38603),
		title2 = Lang.get(36308)
	},
	[Const.RANK_TYPE_CIRCLE_BATTLE_LAYER] = {
		showBtnAward = 1,
		showPanelTime = 1,
		hideTitle2 = 1,
		title = Lang.get(38604),
		title2 = Lang.get(30112)
	},
	[Const.RANK_TYPE_CAT_RACE] = {
		showSvrName = 1,
		hideTitle2 = 1,
		title = Lang.get(52676),
		title2 = Lang.get(52677)
	},
	[Const.RANK_TYPE_NEW_MAZE] = {
		showSvrName = 1,
		showPanelTime = 1,
		showBtnAward = 1,
		hideTitle2 = 1,
		title2 = "",
		title = ResNewMazeDisplay[13060051].desc
	},
	[Const.RANK_TYPE_PET_MAZE] = {
		showSvrName = 1,
		showPanelTime = 1,
		showBtnAward = 1,
		hideTitle2 = 1,
		title2 = "",
		title = Lang.get(78036)
	},
	[Const.RANK_TYPE_SNEAK_BATTLE] = {
		showPanelTime = 1,
		showBtnAward = 1,
		title = Lang.get(92505),
		title2 = Lang.get(96609)
	}
}

for i = 1, 9 do
	local info = ResBossTowerExpandCamp[i]
	local title = string.format("%s-%s", ResBossTower[info.boss_id][1].name, ResHeroCampCareerConfig[1][info.camp].name)

	UIConst.RANK_UI_INFO[Const["RANK_TYPE_BOSS_EXPAND_" .. i]] = {
		title = title
	}
end

function UIConst.getRankScoreStr(rankType, scoreInfo)
	if (scoreInfo == 0 or scoreInfo == "0") and not Const.SPE_EMPTY_PROGRESS_SHOW_TYPE[rankType] then
		return Lang.get(1588)
	end

	if rankType == Const.RANK_TYPE_ONCETOWER then
		if Const.REVIEW_VERSION then
			return scoreInfo .. Lang.get(616)
		else
			return scoreInfo .. "F"
		end
	end

	if rankType == Const.RANK_TYPE_MAINSTAGE then
		local season = math.floor(scoreInfo / 10000)
		local chapter = math.floor((scoreInfo - 10000 * season) / 100)
		local level = scoreInfo - season * 10000 - chapter * 100

		return ClientUtils.getMainStageLevelStr(season, chapter, level)
	end

	if rankType == Const.RANK_TYPE_BOSSTOWER3 then
		local layer = math.floor(scoreInfo / 100000)
		local level = scoreInfo - layer * 100000

		return utils.format(Lang.get(30084), layer, level)
	end

	if rankType == Const.RANK_TYPE_BOSSTOWER1 or rankType == Const.RANK_TYPE_BOSSTOWER2 then
		local layer = math.floor(scoreInfo / 100000)
		local percent = tonumber(string.format("%.2f", (scoreInfo - 100000 * layer) / 100)) .. "%"

		return utils.format(Lang.get(30085), layer, percent)
	end

	if rankType == Const.RANK_TYPE_ACTIVITY_PLOT then
		if scoreInfo > 0 then
			return utils.calcTimeTxt(scoreInfo)
		else
			return Lang.get(30113)
		end
	end

	if rankType == Const.RANK_TYPE_SEASON_TOWER_LAYER then
		return string.format(Lang.get(30086), scoreInfo)
	end

	if rankType == Const.RANK_TYPE_CIRCLE_BATTLE_LAYER then
		if scoreInfo > 0 then
			local layer = math.floor(scoreInfo / 100000)
			local progressValue = math.floor((scoreInfo - 100000 * layer) / 100)
			local progress = progressValue .. "%"

			return utils.format(Lang.get(45092), layer, layer + 1, progress)
		else
			return Lang.get(38574)
		end
	end

	if rankType == Const.RANK_TYPE_SNEAK_BATTLE then
		local actData = CurAvatar:getSneakBattleActivityData()

		if actData then
			local level = math.floor(scoreInfo / 100)
			local stage = scoreInfo % 100
			local levelName = actData:getLevelName(level) or ""
			local stageName = actData:getStageName(level, stage) or ""

			return utils.format("%1s-%2s", levelName, stageName)
		end

		return ""
	end

	if rankType == Const.RANK_TYPE_CIRCLE_BATTLE_FEAT then
		return utils.format(Lang.get(42723), scoreInfo)
	end

	if rankType == Const.RANK_TYPE_CAT_RACE then
		return string.format("%sm", scoreInfo)
	end

	if Const.RANK_TYPE_BOSS_EXPAND_MAP[rankType] then
		return string.format(Lang.get(50269), scoreInfo)
	end

	if rankType == Const.RANK_TYPE_NEW_MAZE then
		if Const.OPEN_NEW_MAZE_TALENT then
			scoreInfo = tonumber(scoreInfo) or 0

			local score = scoreInfo % Const.RANK_NEW_MAZE_SCORE_RATE

			scoreInfo = math.floor(scoreInfo / Const.RANK_NEW_MAZE_SCORE_RATE)

			local level = math.floor(scoreInfo / 10000)
			local layer = scoreInfo - 10000 * level
			local actData = CurAvatar:getNewMazeActData()
			local name = ""

			if actData and actData.levelMiscData[level] then
				name = actData.levelMiscData[level].level_name
			end

			return string.format(Lang.get(102252), name, layer, score)
		else
			scoreInfo = tonumber(scoreInfo) or 0
			scoreInfo = math.floor(scoreInfo / Const.RANK_NEW_MAZE_SCORE_RATE)

			local level = math.floor(scoreInfo / 10000)
			local layer = scoreInfo - 10000 * level
			local actData = CurAvatar:getNewMazeActData()
			local name = ""

			if actData and actData.levelMiscData[level] then
				name = actData.levelMiscData[level].level_name
			end

			return string.format(Lang.get(68620), name, layer)
		end
	end

	if rankType == Const.RANK_TYPE_PET_MAZE then
		local level = math.floor(scoreInfo / 100000000)
		local score = scoreInfo - 100000000 * level

		return string.format(Lang.get(78292), level, score)
	end

	return scoreInfo .. ""
end

local ResBattleShowState = require("ClientData/ResBattleShowState")

function UIConst.getBattleShowStateInfo(stateID)
	local data = ResBattleShowState[stateID]
	local info = ""

	if data then
		local arrow = data.arrow or 0

		arrow = arrow == 0 and "" or string.format("%02d", arrow)
		info = string.format("%s|%s|%d", data.stateName or "", arrow, data.dir or 0)
	end

	return info
end

local ResHero = require("ClientData/ResHero")
local ResCommonModel = require("ClientData/ResCommonModel")

function UIConst.getHeroIconPath(heroId)
	if ResHero[heroId] then
		local model = ResHero[heroId].model

		if ResCommonModel[model] and ResCommonModel[model].icon_path then
			return {
				"Atlas/" .. ResCommonModel[model].icon_path,
				ResCommonModel[model].icon_name
			}
		end
	end
end

function UIConst.getHeroHeadIconPath(heroId)
	if ResHero[heroId] then
		local model = ResHero[heroId].model

		if ResCommonModel[model] and ResCommonModel[model].head_path then
			return {
				"Atlas/" .. ResCommonModel[model].head_path,
				ResCommonModel[model].head_name
			}
		end
	end
end

function UIConst.getModelHeadIconPath(model)
	if ResCommonModel[model] and ResCommonModel[model].head_path then
		return {
			"Atlas/" .. ResCommonModel[model].head_path,
			ResCommonModel[model].head_name
		}
	end
end

function UIConst.getHeroQualityPath(heroId)
	if ResHero[heroId] and ResHero[heroId].quality then
		return UIConst.HERO_QUALITY_CONFIG[ResHero[heroId].quality]
	end
end

function UIConst.getHeroQuality(heroId)
	if ResHero[heroId] and ResHero[heroId].quality then
		return ResHero[heroId].quality
	end
end

function UIConst.getHeroCamZoomPos(hero)
	local showModelId = hero:getShowModelId()

	if showModelId and ResCommonModel[showModelId] and ResCommonModel[showModelId].camera_zoom_pos then
		return ResCommonModel[showModelId].camera_zoom_pos
	end
end

function UIConst.getHeroStarPath(star, isLarge)
	if star then
		if isLarge then
			local starPath = star < 10 and "IconStarL0" or "IconStarL"

			return {
				"Atlas/HeroAtlas/HeroAtlas",
				starPath .. star
			}
		else
			local starPath = star < 10 and "IconStar0" or "IconStar"

			return {
				"Atlas/HeroAtlas/HeroCardCommonAtlas",
				starPath .. star
			}
		end
	end
end

local ResStarUpCondition = require("ClientData/ResStarUpCondition")

function UIConst.getHeroStarColor(star)
	local quality = ResStarUpCondition[star].step_img_idx or 1

	if quality == Const.OBJ_QUALITY_WHITE then
		return ResColor.QUALITYGREEN
	elseif quality == Const.OBJ_QUALITY_GREEN then
		return ResColor.QUALITYBLUE
	elseif quality == Const.OBJ_QUALITY_BLUE then
		return ResColor.QUALITYPURPLE
	elseif quality == Const.OBJ_QUALITY_PURPLE then
		return ResColor.QUALITYFUCHSIA
	elseif quality == Const.OBJ_QUALITY_GOLD then
		return ResColor.QUALITYORANGE
	elseif quality == 6 then
		return ResColor.QUALITYPINK
	elseif quality == 7 then
		return ResColor.QUALITYRED
	end
end

function UIConst.getHeroStepPath(star)
	local stepImgIdx = ResStarUpCondition[star].step_img_idx or 1

	return UIConst.HERO_QUALITY_HEAD_CONFIG[stepImgIdx]
end

function UIConst.getHeroDrawCameraInfo(heroId)
	if ResHero[heroId] then
		local model = ResHero[heroId].model

		if ResCommonModel[model] and ResCommonModel[model].draw_camera_pos then
			return ResCommonModel[model].draw_camera_pos, ResCommonModel[model].draw_camera_rot, ResCommonModel[model].draw_camera_cue
		end
	end
end

local ResMonster = require("ClientData/ResMonster")

function UIConst.getMonsterIconPath(monsterId)
	if ResMonster[monsterId] then
		local model = ResMonster[monsterId].model

		if ResCommonModel[model] and ResCommonModel[model].icon_path then
			return {
				"Atlas/" .. ResCommonModel[model].icon_path,
				ResCommonModel[model].icon_name
			}
		end
	end
end

function UIConst.getMonsterHeadIconPath(monsterId)
	if ResMonster[monsterId] then
		local model = ResMonster[monsterId].model

		if ResCommonModel[model] and ResCommonModel[model].head_path then
			return {
				"Atlas/" .. ResCommonModel[model].head_path,
				ResCommonModel[model].head_name
			}
		end
	end
end

function UIConst.getHeroCampIconPath(campId)
	return {
		"Atlas/HeroAtlas/HeroCardCommonAtlas",
		"IconGroup0" .. campId
	}
end

function UIConst.getHeroCampLargeIconPath(campId)
	if campId >= 4 then
		return {
			"Atlas/OtherBattleAtlas/EquipTowerAtlas2",
			"IconGroupL0" .. campId
		}
	else
		return {
			"Atlas/OtherBattleAtlas/EquipTowerAtlas",
			"IconGroupL0" .. campId
		}
	end
end

function UIConst.getHeroCampBgIconPath(campId)
	return {
		"Atlas/CommonAtlas/BgGroupAtlas",
		"BgGroup0" .. campId
	}
end

function UIConst.getHeroCampAvgIconPath(campId)
	return {
		"Atlas/AvgAtlas/AvgAtlas",
		"BgGroup0" .. campId
	}
end

function UIConst.getHeroCareerIconPath(careerId)
	if careerId ~= Const.CAREER_TYPE.ALL then
		return {
			"Atlas/HeroAtlas/HeroCardCommonAtlas",
			"IconCareer0" .. careerId
		}
	else
		return {
			"Atlas/HeroAtlas/HeroCardCommonAtlas",
			"IconCareer00"
		}
	end
end

function UIConst.getNewHeroCareerIconPath(careerId)
	if careerId ~= Const.CAREER_TYPE.ALL then
		return {
			"Atlas/HeroAtlas/HeroCardCommonAtlas",
			"IconCareerStroke0" .. careerId
		}
	else
		return {
			"Atlas/HeroAtlas/HeroCardCommonAtlas",
			"IconCareerStroke00"
		}
	end
end

function UIConst.getLargeTeamIconPath(teamId)
	if teamId <= 6 then
		return {
			"Atlas/CommonAtlas/IconTeamLargeAtlas",
			"TxtTeam0" .. teamId
		}
	end
end

function UIConst.getHeroGroupTeamIconPath(team)
	if team <= 6 then
		return {
			"Atlas/CommonAtlas/IconTeamAtlas",
			"IconTeamLittle0" .. team
		}
	end
end

UIConst.HERO_TEAM_CONFIG = ResHeroCampCareerConfig[3]

for teamId, teamInfo in pairs(ResHeroCampCareerConfig[3]) do
	teamInfo.iconPath = "Atlas/CommonAtlas/IconTeamAtlas"
	teamInfo.iconS = "IconTeamS0" .. teamId
	teamInfo.cellIconPath = "Atlas/SeasonTowerAtlas/SeasonTowerMainAtlas01"
	teamInfo.cellIcon = "BtnLimitCard0" .. teamId
	teamInfo.iconSS = "IconTeamLittle0" .. teamId
end

function UIConst.getHeroCardBgByCamp(campId)
	if campId == Const.CAMP_TYPE.SLIM_SNOW then
		return {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardBgNmlLight"
		}
	elseif campId == Const.CAMP_TYPE.NINE_NIGHT then
		return {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardBgNmlBlack"
		}
	else
		return {
			HERO_COMMON_ATLAS_PATH,
			"ImgCardBgNml"
		}
	end
end

local ResRoleHead = require("ClientData/ResRoleHead")

function UIConst.getPlayerHeadIconPath(headId)
	if headId == 0 then
		headId = Const.DEFAULT_HEAD
	end

	local headInfo = ResRoleHead[headId]

	if headInfo then
		return {
			"Atlas/" .. headInfo.atlas_path,
			headInfo.icon_path
		}
	end
end

local ResRoleImageData = require("ClientData/ResRoleImageData")
local ROLE_ATLAS_PATH = "Atlas/CommonAtlas/HeroPortraitAtlas/"

function UIConst.getAvgHeadIconPath(heroId)
	local imageData = ResRoleImageData[heroId]

	if imageData then
		return {
			ROLE_ATLAS_PATH .. imageData.res_path,
			imageData.res_name,
			imageData.size,
			imageData.scale
		}
	end
end

local ResRoleFaceData = require("ClientData/ResRoleFaceData")

function UIConst.getAvgHeadEmoji(heroId, emojiIndex)
	local faceData = ResRoleFaceData[heroId]
	local emojiInfo = {}

	if faceData and faceData[emojiIndex] then
		emojiInfo[1] = ROLE_ATLAS_PATH .. faceData[emojiIndex].res_path
		emojiInfo[2] = faceData[emojiIndex].res_name

		if faceData[1] then
			local faceSize = faceData[1].size

			if faceSize then
				emojiInfo[3] = {
					faceSize[1],
					faceSize[2]
				}
			end

			local facePos = faceData[1].pos

			if facePos then
				emojiInfo[4] = {
					facePos[1],
					facePos[2]
				}
			end

			local faceScale = faceData[1].scale

			if faceScale then
				emojiInfo[5] = faceScale
			end
		end

		return emojiInfo
	else
		return
	end
end

function UIConst.getRoleImageByType(heroId, imgType)
	local imageData = ResRoleImageData[heroId]

	if imageData then
		local resPath = ROLE_ATLAS_PATH .. imageData.res_path
		local resName = imageData.res_name
		local pos, scale, size

		if imageData[imgType] and imageData[imgType][1] then
			pos = imageData[imgType][1] and imageData[imgType][1].pos or imageData.pos
			scale = imageData[imgType][1] and imageData[imgType][1].scale or imageData.scale
			size = imageData[imgType][1] and imageData[imgType][1].size or imageData.size
		else
			pos = imageData.pos
			scale = imageData.scale
			size = imageData.size
		end

		return {
			resPath,
			resName,
			pos,
			scale,
			size
		}
	end
end

local ResUIBgChange = require("ClientData/ResUIBgChange")
local ResUIBgChangeInfo = require("ClientData/ResUIBgChangeInfo")

function UIConst.getBgChangeInfo(uiName)
	if uiName and ResUIBgChange[uiName] then
		local changeId, tmpStartTime

		for id, changeInfo in pairs(ResUIBgChange[uiName]) do
			if not changeInfo.valid_time_id or not changeInfo.expire_time_id then
				return
			end

			local startPassed = ClientUtils.isTimeConfigPassed(changeInfo.valid_time_id)
			local endPassed = ClientUtils.isTimeConfigPassed(changeInfo.expire_time_id)

			if startPassed and not endPassed and (not changeId or tmpStartTime and tmpStartTime < ClientUtils.getTimeConfigTimestamp(changeInfo.valid_time_id)) then
				changeId = changeInfo.change_id
				tmpStartTime = ClientUtils.getTimeConfigTimestamp(changeInfo.valid_time_id)
			end
		end

		if changeId then
			return ResUIBgChangeInfo[changeId]
		end
	end
end

function UIConst.getGenderImagePath(gender)
	if gender == Const.GENDER_MAN then
		return {
			"Atlas/FriendAtlas/FriendAtlas",
			"IconMale"
		}
	else
		return {
			"Atlas/FriendAtlas/FriendAtlas",
			"IconFemale"
		}
	end
end

function UIConst.getAVGData(resName)
	local ExcelData = require("ClientData/AVGData/ExcelData/" .. resName)
	local EditorData = require("ClientData/AVGData/EditorData/" .. resName)
	local Data = {}
	local metaTable = {
		__index = function(obj, key)
			if ExcelData[key] then
				return ExcelData[key]
			end

			if EditorData[key] then
				return EditorData[key]
			end
		end
	}

	setmetatable(Data, metaTable)

	return Data
end

return UIConst
