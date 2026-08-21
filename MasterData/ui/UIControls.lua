-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\UIControls.lua

local Controls = GLDeclare("UIControls", {})

Controls.Window = require("UI/Control/Base/UIBaseWindow")
Controls.Child = require("UI/Control/Base/UIBaseChild")
Controls.Logo = require("UI/Control/Base/UIBaseLogo")
Controls.Panel = require("UI/Control/Com/Panel")
Controls.Label = require("UI/Control/Com/Label")
Controls.Image = require("UI/Control/Com/Image")
Controls.RawImage = require("UI/Control/Com/RawImage")
Controls.Button = require("UI/Control/Com/Button")
Controls.Input = require("UI/Control/Com/Input")
Controls.Toggle = require("UI/Control/Com/Toggle")
Controls.Dropdown = require("UI/Control/Com/Dropdown")
Controls.Slider = require("UI/Control/Com/Slider")
Controls.ScrollView = require("UI/Control/Com/ScrollView")
Controls.DragClickPanel = require("UI/Control/Com/DragClickPanel")
Controls.CustomToggle = require("UI/Control/Com/CustomToggle")
Controls.Tips = require("UI/Control/Tips/BaseTips")
Controls.TipsConfig = require("UI/Control/Tips/TipsConfig")
Controls.UIAni = require("UI/Control/Com/Animation")
Controls.FrameImage = require("UI/Control/Com/FrameImage")
Controls.ModelStage = require("UI/Control/Com/ModelStage")
Controls.RedDot = require("UI/Control/Com/RedDot")
Controls.MaterialProgress = require("UI/Control/Com/MaterialProgress")
Controls.LazyEffectPlayer = require("UI/Control/Com/LazyEffectPlayer")
Controls.RateEffectPlayer = require("UI/Control/Com/RateEffectPlayer")
Controls.LazyAudioPlayer = require("UI/Control/Com/LazyAudioPlayer")
Controls.BookPlayer = require("UI/Control/Com/BookPlayer")
Controls.LazyLivePlayer = require("UI/Control/Com/LazyLivePlayer")
Controls.LazyVideoPlayer = require("UI/Control/Com/LazyVideoPlayer")
Controls.ScrollViewLoopCell = require("UI/Control/Scroll/ScrollViewLoopCell")
Controls.ScrollViewLoopV = require("UI/Control/Scroll/ScrollRectLoopV")
Controls.ScrollViewLoopH = require("UI/Control/Scroll/ScrollRectLoopH")
Controls.UnionTextureTrigger = require("UI/Control/Com/UnionTextureTrigger")
Controls.ShortNumLabel = require("UI/Control/Com/ShortNumLabel")
Controls.ScreenshotImage = require("UI/Control/Com/ScreenshotImage")
Controls.Browser = require("UI/Control/Com/UIBrowser")

local function _GetGridClass(className, mixinClass, panelClass)
	local ClassType = Class(className, panelClass)

	MixinClass(ClassType, mixinClass, true)

	function ClassType:ctor()
		self:ctorMixin()
	end

	return ClassType
end

local GridItemMixin = require("UI/Common/Grid/Mixin/GridItemMixin")

Controls.ItemGridChild = _GetGridClass("ItemGridChild", GridItemMixin, Controls.Child)
Controls.ItemGridLoop = _GetGridClass("ItemGridLoop", GridItemMixin, Controls.ScrollViewLoopCell)

local AttrCellMixin = require("UI/Common/Grid/Mixin/AttrCellMixin")

Controls.AttrCellPanel = _GetGridClass("AttrCellPanel", AttrCellMixin, Controls.Panel)
Controls.AttrCellChild = _GetGridClass("AttrCellChild", AttrCellMixin, Controls.Child)

local GridFragItemMixin = require("UI/Common/Grid/Mixin/GridFragItemMixin")

Controls.FragItemGridChild = _GetGridClass("FragItemGridChild", GridFragItemMixin, Controls.Child)
Controls.FragItemGridLoop = _GetGridClass("FragItemGridLoop", GridFragItemMixin, Controls.ScrollViewLoopCell)

local CardHeroMixin = require("UI/Common/Grid/Mixin/CardHeroMixin")

Controls.HeroCardChild = _GetGridClass("HeroCardChild", CardHeroMixin, Controls.Child)
Controls.HeroCardLoop = _GetGridClass("HeroCardLoop", CardHeroMixin, Controls.ScrollViewLoopCell)

local CardPoolHeroMixin = require("UI/Common/Grid/Mixin/CardPoolHeroMixin")

Controls.HeroPoolCardChild = _GetGridClass("HeroPoolCardChild", CardPoolHeroMixin, Controls.Child)

local GridHeroMixin = require("UI/Common/Grid/Mixin/GridHeroMixin")

Controls.HeroGridChild = _GetGridClass("HeroGridChild", GridHeroMixin, Controls.Child)
Controls.HeroGridLoop = _GetGridClass("HeroGridLoop", GridHeroMixin, Controls.ScrollViewLoopCell)
Controls.GridSimpleHeroChild = require("UI/Common/Grid/GridSimpleHeroChild")

local RelatedGridHeroMixin = require("UI/Common/Grid/Mixin/RelatedGridHeroMixin")

Controls.RelatedHeroGridChild = _GetGridClass("RelatedHeroGridChild", RelatedGridHeroMixin, Controls.Child)

local CardMonsterMixin = require("UI/Common/Grid/Mixin/CardMonsterMixin")

Controls.MonsterCardChild = _GetGridClass("MonsterCardChild", CardMonsterMixin, Controls.Child)
Controls.MonsterCardLoop = _GetGridClass("MonsterCardLoop", CardMonsterMixin, Controls.ScrollViewLoopCell)

local GridBuffMixin = require("UI/Common/Grid/Mixin/GridBuffMixin")

Controls.BuffGridChild = _GetGridClass("BuffGridChild", GridBuffMixin, Controls.Child)
Controls.BuffGridLoop = _GetGridClass("BuffGridLoop", GridBuffMixin, Controls.ScrollViewLoopCell)
Controls.GridBuffWithMaster = require("UI/Common/Grid/GridBuffWithMaster")

local GridHeroSkillMixin = require("UI/Common/Grid/Mixin/GridHeroSkillMixin")

Controls.HeroSkillGridChild = _GetGridClass("HeroSkillGridChild", GridHeroSkillMixin, Controls.Child)
Controls.HeroSkillGridLoop = _GetGridClass("HeroSkillGridLoop", GridHeroSkillMixin, Controls.ScrollViewLoopCell)

local GridHeroHeadMixin = require("UI/Common/Grid/Mixin/GridHeroHeadMixin")

Controls.HeroHeadGridPanel = _GetGridClass("HeroHeadGridPanel", GridHeroHeadMixin, Controls.Panel)

local GridEquipMixin = require("UI/Common/Grid/Mixin/GridEquipMixin")

Controls.EquipGridPanel = _GetGridClass("EquipGridPanel", GridEquipMixin, Controls.Panel)
Controls.EquipGridChild = _GetGridClass("EquipGridChild", GridEquipMixin, Controls.Child)
Controls.EquipGridLoop = _GetGridClass("EquipGridLoop", GridEquipMixin, Controls.ScrollViewLoopCell)

local GridRelicMixin = require("UI/Common/Grid/Mixin/GridRelicMixin")

Controls.RelicGridPanel = _GetGridClass("RelicGridPanel", GridRelicMixin, Controls.Panel)
Controls.RelicGridChild = _GetGridClass("RelicGridChild", GridRelicMixin, Controls.Child)
Controls.RelicGridLoop = _GetGridClass("RelicGridLoop", GridRelicMixin, Controls.ScrollViewLoopCell)

local CardSkinMixin = require("UI/Common/Grid/Mixin/CardSkinMixin")

Controls.SkinCardChild = _GetGridClass("SkinCardChild", CardSkinMixin, Controls.Child)
Controls.SkinCardLoop = _GetGridClass("SkinCardLoop", CardSkinMixin, Controls.ScrollViewLoopCell)

local GridSkinMixin = require("UI/Common/Grid/Mixin/GridSkinMixin")

Controls.SkinGridChild = _GetGridClass("SkinGridChild", GridSkinMixin, Controls.Child)
Controls.SkinGridLoop = _GetGridClass("SkinGridLoop", GridSkinMixin, Controls.ScrollViewLoopCell)
Controls.EquipTempleteGridChild = _GetGridClass("EquipTempleteGridChild", GridEquipMixin, Controls.Child)
Controls.EquipTempleteGridLoop = _GetGridClass("EquipTempleteGridLoop", GridEquipMixin, Controls.ScrollViewLoopCell)

local GridMultiContainerMixin = require("UI/Common/Grid/Mixin/GridMultiContainerMixin")

Controls.GridMultiContainerChild = _GetGridClass("GridMultiContainerChild", GridMultiContainerMixin, Controls.Child)
Controls.GridMultiContainerLoop = _GetGridClass("GridMultiContainerLoop", GridMultiContainerMixin, Controls.ScrollViewLoopCell)

local GridNameContainerMixin = require("UI/Common/Grid/Mixin/GridNameContainerMixin")

Controls.GridNameContainerChild = _GetGridClass("GridNameContainerChild", GridNameContainerMixin, Controls.Child)

local GridArtifactMixin = require("UI/Common/Grid/Mixin/GridArtifactMixin")

Controls.ArtifactGridPanel = _GetGridClass("ArtifactGridPanel", GridArtifactMixin, Controls.Panel)
Controls.ArtifactGridChild = _GetGridClass("ArtifactGridChild", GridArtifactMixin, Controls.Child)
Controls.ArtifactGridLoop = _GetGridClass("ArtifactGridLoop", GridArtifactMixin, Controls.ScrollViewLoopCell)

local GridPlayerHeadMixin = require("UI/Common/Grid/Mixin/GridPlayerHeadMixin")

Controls.PlayerHeadGridChild = _GetGridClass("PlayerHeadGridChild", GridPlayerHeadMixin, Controls.Child)
Controls.PlayerHeadGridLoop = _GetGridClass("PlayerHeadGridLoop", GridPlayerHeadMixin, Controls.ScrollViewLoopCell)

local GridPlayerVip = require("UI/Common/Grid/Mixin/GridPlayerHeadMixin")
local HeroInfoHead = require("UI/Hero/HeroInfoHead")

Controls.GridHeroInfoChild = _GetGridClass("GridHeroInfoChild", HeroInfoHead, Controls.Child)
Controls.GridHeroInfoLoop = _GetGridClass("GridHeroInfoLoop", HeroInfoHead, Controls.ScrollViewLoopCell)

local BtnPlayerRankCell = require("UI/MainState/Rank/BtnPlayerRankCell")

Controls.BtnPlayerRankCellChild = _GetGridClass("BtnPlayerRankCellChild", BtnPlayerRankCell, Controls.Child)
Controls.BtnPlayerRankCellLoop = _GetGridClass("BtnPlayerRankCellLoop", BtnPlayerRankCell, Controls.ScrollViewLoopCell)

local BtnCircleMemberMixin = require("UI/Circle/BtnCircleMemberMixin")

Controls.BtnCircleMemberPanel = _GetGridClass("BtnCircleMemberPanel", BtnCircleMemberMixin, Controls.Panel)
Controls.BtnCircleMemberLoop = _GetGridClass("BtnCircleMemberLoop", BtnCircleMemberMixin, Controls.ScrollViewLoopCell)

local BtnCircleCellMixin = require("UI/Circle/BtnCircleCellMixin")

Controls.BtnCircleCellChild = _GetGridClass("BtnCircleCellChild", BtnCircleCellMixin, Controls.Child)
Controls.BtnCircleCellLoop = _GetGridClass("BtnCircleCellLoop", BtnCircleCellMixin, Controls.ScrollViewLoopCell)

local GridCircleCommonMixin = require("UI/Circle/GridCircleCommonMixin")

Controls.GridCircleCommonChild = _GetGridClass("GridCircleCommonChild", GridCircleCommonMixin, Controls.Child)
Controls.GridCircleCommonLoop = _GetGridClass("GridCircleCommonLoop", GridCircleCommonMixin, Controls.ScrollViewLoopCell)

local CardPetMixin = require("UI/Common/Grid/Mixin/CardPetMixin")

Controls.PetCardChild = _GetGridClass("PetCardChild", CardPetMixin, Controls.Child)
Controls.PetCardLoop = _GetGridClass("PetCardLoop", CardPetMixin, Controls.ScrollViewLoopCell)

local GridPetHeadMixin = require("UI/Common/Grid/Mixin/GridPetHeadMixin")

Controls.GridPetHeadChild = _GetGridClass("GridPetHeadChild", GridPetHeadMixin, Controls.Child)
Controls.GridPetHeadLoop = _GetGridClass("GridPetHeadLoop", GridPetHeadMixin, Controls.ScrollViewLoopCell)

local GridPetSkillMixin = require("UI/Common/Grid/Mixin/GridPetSkillMixin")

Controls.GridPetSkillChild = _GetGridClass("GridPetSkillChild", GridPetSkillMixin, Controls.Child)
Controls.GridPetSkillLoop = _GetGridClass("GridPetSkillLoop", GridPetSkillMixin, Controls.ScrollViewLoopCell)

local GridPetGemMixin = require("UI/Common/Grid/Mixin/GridPetGemMixin")

Controls.GridPetGemChild = _GetGridClass("GridPetGemChild", GridPetGemMixin, Controls.Child)
Controls.GridPetGemLoop = _GetGridClass("GridPetGemLoop", GridPetGemMixin, Controls.ScrollViewLoopCell)

local GridPetGiftLongMixin = require("UI/Common/Grid/Mixin/GridPetGiftLongMixin")

Controls.GridPetGiftLongChild = _GetGridClass("GridPetGiftLongChild", GridPetGiftLongMixin, Controls.Child)
Controls.GridPetGiftLongLoop = _GetGridClass("GridPetGiftLongLoop", GridPetGiftLongMixin, Controls.ScrollViewLoopCell)

local GridPetGiftHeadMixin = require("UI/Common/Grid/Mixin/GridPetGiftHeadMixin")

Controls.GridPetGiftHeadChild = _GetGridClass("GridPetGiftHeadChild", GridPetGiftHeadMixin, Controls.Child)
Controls.GridPetGiftHeadLoop = _GetGridClass("GridPetGiftHeadLoop", GridPetGiftHeadMixin, Controls.ScrollViewLoopCell)

local GridPetGiftDetailMixin = require("UI/Common/Grid/Mixin/GridPetGiftDetailMixin")

Controls.GridPetGiftDetailChild = _GetGridClass("GridPetGiftDetailChild", GridPetGiftDetailMixin, Controls.Child)
Controls.GridPetGiftDetailLoop = _GetGridClass("GridPetGiftDetailLoop", GridPetGiftDetailMixin, Controls.ScrollViewLoopCell)

local GridBattleBuffMixin = require("UI/Common/Grid/Mixin/GridBattleBuffMixin")

Controls.BattleBuffGridChild = _GetGridClass("BattleBuffGridChild", GridBattleBuffMixin, Controls.Child)

local SignetCellMixin = require("UI/Signet/SignetCellMixin")

Controls.SignetCellChild = _GetGridClass("SignetCellChild", SignetCellMixin, Controls.Child)
Controls.SignetCellLoop = _GetGridClass("SignetCellLoop", SignetCellMixin, Controls.ScrollViewLoopCell)
Controls.PriceBuyPanel = require("UI/Common/PriceBuyPanel")

local ITEM_GRID_TYPE_CONFIG = {
	[Const.ITEM_TYPE_FRAG_ITEM] = {
		"FragItemGrid",
		"System/Common/Grid/GridShatterItem"
	},
	[Const.ITEM_TYPE_EQUIP] = {
		"EquipGrid",
		"System/Common/Grid/GridEquipItem"
	},
	[Const.ITEM_TYPE_EQUIP_TEMPLETE] = {
		"EquipTempleteGrid",
		"System/Common/Grid/GridEquipItem"
	},
	[Const.ITEM_TYPE_ARTIFACT] = {
		"ArtifactGrid",
		"System/Common/Grid/GridBadgeSmallItem"
	},
	[Const.ITEM_TYPE_RELIC] = {
		"RelicGrid",
		"System/Common/Grid/GridRelicSmallItem"
	},
	[Const.ITEM_TYPE_HERO] = {
		"HeroGrid",
		"System/StarUp/GridHeroStarUp"
	},
	[Const.ITEM_TYPE_SKIN] = {
		"SkinGrid",
		"System/Common/Grid/GridSkinItemSmall"
	}
}

function Controls.getGridPanelType(item, panelType)
	local keyWord = "ItemGrid"

	if ITEM_GRID_TYPE_CONFIG[item.itemType] then
		keyWord = ITEM_GRID_TYPE_CONFIG[item.itemType][1]
	end

	return Controls[keyWord .. panelType]
end

function Controls.getGridPanelPrefab(item)
	if ITEM_GRID_TYPE_CONFIG[item.itemType] then
		return ITEM_GRID_TYPE_CONFIG[item.itemType][2]
	else
		return "System/Common/Grid/GridMaterialItem"
	end
end

function Controls.getGridChild(clientItem, parent, path, isShowPreviewTips)
	local gridPrefab = UIControls.getGridPanelPrefab(clientItem)
	local gridType = UIControls.getGridPanelType(clientItem, "Child")
	local gridChild = gridType(parent, path, gridPrefab)

	if isShowPreviewTips and clientItem.itemType and Const.HAVE_PREVIEW_TIPS_TYPE_DIC[clientItem.itemType] then
		gridChild.isShowPreviewTips = isShowPreviewTips
	end

	return gridChild
end

Controls.GridSimpleContainerChild = require("UI/Common/Grid/GridSimpleContainerChild")
Controls.GridContainerChild = require("UI/Common/Grid/GridContainerChild")

function Controls.getGridContainer(parent, path, isShowPreviewTips)
	local gridContainer = Controls.GridContainerChild(parent, path, "System/Common/Grid/GridContainer")

	if isShowPreviewTips then
		gridContainer.isShowPreviewTips = isShowPreviewTips
	end

	return gridContainer
end

Controls.GridAwardContainer = require("UI/Common/Grid/GridAwardContainer")

function Controls.getGridAwardContainer(parent, path, isShowPreviewTips)
	local awardGridContainer = Controls.GridAwardContainer(parent, path, "System/Common/Grid/GridAwardContainer")

	if isShowPreviewTips then
		awardGridContainer.isShowPreviewTips = isShowPreviewTips
	end

	return awardGridContainer
end

Controls.GridAwardPanelContainer = require("UI/Common/Grid/GridAwardPanelContainer")

function Controls.getGridAwardPanelContainer(parent, path, prefabPath, isShowPreviewTips)
	local awardPanelContainer = Controls.GridAwardPanelContainer(parent, path, prefabPath or "System/Activity/GridTaskPaid")

	if isShowPreviewTips then
		awardPanelContainer.isShowPreviewTips = isShowPreviewTips
	end

	return awardPanelContainer
end

Controls.PlayerVipChild = require("UI/Common/Grid/PlayerVipChild")

function Controls.PanelPlayerVip(parent, path)
	return Controls.PlayerVipChild(parent, path, "System/Common/Grid/GridVIP")
end

Controls.GridContainerLoop = require("UI/Common/Grid/GridContainerLoop")

function Controls.getGridContainerLoop(parent, idx, isShowPreviewTips)
	local gridContainerLoop = Controls.GridContainerLoop(parent, "System/Common/Grid/GridContainer", idx)

	if isShowPreviewTips then
		gridContainerLoop.isShowPreviewTips = isShowPreviewTips
	end

	return gridContainerLoop
end

local RoleImage = require("UI/Control/Com/RoleImage")

function Controls.Role(parent, path, x, y)
	return RoleImage(parent, path or "", "System/Common/Grid/GridHeroPortrait", x, y, true)
end

function Controls.PetRole(parent, path, x, y)
	return RoleImage(parent, path or "", "System/Common/Grid/GridPetPortrait", x, y, true)
end

local AvgRoleImage = require("UI/Control/Com/AvgRoleImage")

function Controls.AvgRole(parent, path, x, y)
	return AvgRoleImage(parent, path or "", "System/AVG/AVGTalkRole", x, y, true)
end

local NumKeyboard = require("UI/Common/NumKeyboard")

local function initNumKeyboard(parent, path)
	return NumKeyboard(parent, path, "System/Common/Keyboard/KeyboardPanel")
end

Controls.NumKeyboard = initNumKeyboard

local UIConst = UIConst

local function checkControl(parent, path, controlType)
	local root = parent.mRoot or parent

	if root ~= nil then
		if controlType == nil then
			controlType = UIConst.ControlTypeGameObject
		end

		return root:getController():CheckCom(controlType, path) ~= 0
	end
end

Controls.checkControlFunc = checkControl
UIConst.BtnChooseEquipSet = require("UI/Common/CommonCell/BtnChooseEquipSet")
UIConst.ShopCellLoopInit = require("UI/MainState/Trade/ShopCellLoopInit")

return Controls
