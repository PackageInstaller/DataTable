-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroEquipUpGradeDlg.lua

local EquipMaterialListChild = require("UI/Equip/EquipMaterialListChild")
local ArtifactMaterialListChild = require("UI/Equip/ArtifactMaterialListChild")
local CommonSortPanel = require("UI/Common/CommonSortPanel")
local EquipUpGradePanel = require("UI/Equip/EquipUpGradePanel")
local ArtifactUpGradePanel = require("UI/Equip/ArtifactUpGradePanel")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local strClassName = "HeroEquipUpGradeDlg"
local HeroEquipUpGradeDlg = Class(strClassName, UIControls.Window)
local UPGRADE_INFO_CONFIG = {
	{
		EquipMaterialListChild,
		"System/Hero/EquipListPanel",
		EquipUpGradePanel,
		"System/Hero/EquipUpGradePanel"
	},
	{
		ArtifactMaterialListChild,
		"System/Hero/BadgeListPanel",
		ArtifactUpGradePanel,
		"System/Hero/BadgeUpGradePanel"
	}
}
local EQUIP_UPGRADE_MATERIAL_SORT_MAP = {
	{
		name = "upgradePart",
		hide = 1,
		forceTop = 1,
		text = Lang.get(30333)
	},
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
	},
	{
		name = "mainPropSortValue",
		hide = 1,
		text = Lang.get(50272)
	}
}
local ARTIFACT_UPGRADE_MATERIAL_SORT_MAP = {
	{
		name = "quality",
		text = Lang.get(372)
	},
	{
		name = "id",
		text = Lang.get(30334)
	},
	{
		name = "breakLevel",
		text = Lang.get(1833)
	},
	{
		name = "enhanceLevel",
		hide = 1,
		text = Lang.get(920)
	}
}
local SUIT_FILTER_MAP = {
	{
		title = Lang.get(50273),
		data = {
			{
				ResEquipSuit[1].name,
				"suitId",
				1
			},
			{
				ResEquipSuit[2].name,
				"suitId",
				2
			},
			{
				ResEquipSuit[3].name,
				"suitId",
				3
			},
			{
				ResEquipSuit[4].name,
				"suitId",
				4
			}
		}
	}
}

function HeroEquipUpGradeDlg:ctor()
	self:initUI()
end

function HeroEquipUpGradeDlg:initUI()
	self.btnSuitList = UIControls.Button(self, "BgItemList/TabFunPanel/BtnFilter", "Text")

	self.btnSuitList:addEventClick(self.onBtnSuitListClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.sortPanel = CommonSortPanel(self, "BgItemList/TabFunPanel")
	self.sortPanel.mEventDataListChanged = Slot(self.updateSort, self)
	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.suitFilterMap = CurAvatar:initSuitFilterMapInfo()

	if UIControls.checkControlFunc(self, "BtnProbability") then
		self.btnProbability = UIControls.Button(self, "BtnProbability")

		self.btnProbability:addEventClick(self.onBtnProbabilityClick)

		if RegionUtils.isKR() then
			self.btnProbability:setVisible(true)
		end
	end
end

function HeroEquipUpGradeDlg:onBtnSuitListClick()
	local siftBoxDlg = UIManager.getUI("siftBoxDlg", true)

	if siftBoxDlg then
		siftBoxDlg:setIsHaveAll(true)
		siftBoxDlg:initFilterInfo(self.suitFilterMap, self.filterConfig, Slot(self.filterSuitMaterial, self))
		siftBoxDlg:setTitle(Lang.get(50274))
	end
end

function HeroEquipUpGradeDlg:filterSuitMaterial(filterCheckFunc, _filterConfig)
	self.checkFilterFunc = filterCheckFunc
	self.filterConfig = _filterConfig

	local tmpItems = {}

	if self.checkFilterFunc then
		self.items = CurAvatar:getUpgradeEquipMaterial(self.upgradeType, self.targetItem)

		for _, equip in ipairs(self.items) do
			if self.checkFilterFunc(equip) then
				table.insert(tmpItems, equip)
			end
		end
	end

	self.sortPanel:sortByCurConfig(tmpItems)

	if self.materialListPanel and self.materialListPanel.panelContentNone then
		self.materialListPanel.panelContentNone:setVisible(#tmpItems == 0)
	end

	local siftBoxDlg = UIManager.getUI("siftBoxDlg", nil, false)

	if siftBoxDlg then
		siftBoxDlg:setVisible(false)
	end
end

function HeroEquipUpGradeDlg:onBtnTipsClick()
	local infoNoticeId = self.upgradeType == Const.UPGRADE_TYPE_EQUIP and Const.INFO_NOTICE_EQUIPUPGRADE or Const.INFO_NOTICE_ARTIFACTUPGRADE

	UIManager.getUI("infoNotice", true):showSystemInfo(infoNoticeId)
end

function HeroEquipUpGradeDlg:updateMaterial(materialItem, isAdd)
	self.upgradePanel:updateMaterial(materialItem, isAdd)
end

function HeroEquipUpGradeDlg:giveBackMaterial(materialItem)
	self.materialListPanel:giveBackMaterial(materialItem)
end

function HeroEquipUpGradeDlg:onBtnProbabilityClick()
	JumpGuideManager.jump(186)
end

function HeroEquipUpGradeDlg:getAddMaterialCount()
	return self.upgradePanel:getAddMaterialCount()
end

function HeroEquipUpGradeDlg:onCloseClick()
	self:setVisible(false)
end

local function sortArtifactByWear(artifactA, artifactB)
	if artifactA.upgradePart ~= artifactB.upgradePart then
		if artifactA.upgradePart ~= nil then
			return 1
		else
			return 2
		end
	elseif artifactA.inWearing ~= artifactB.inWearing then
		if artifactA.inWearing == nil then
			return 1
		else
			return 2
		end
	else
		return 0
	end
end

local function sortArtifactByWearWithSameTop(artifactA, artifactB)
	if artifactA.upgradePart ~= artifactB.upgradePart then
		if artifactA.upgradePart ~= nil then
			return 1
		else
			return 2
		end
	elseif artifactA.inWearing ~= artifactB.inWearing then
		if artifactA.inWearing == nil then
			return 1
		else
			return 2
		end
	elseif artifactA.isSameIdNoBreakArtifact ~= artifactB.isSameIdNoBreakArtifact then
		if artifactA.isSameIdNoBreakArtifact > artifactB.isSameIdNoBreakArtifact then
			return 1
		else
			return 2
		end
	else
		return 0
	end
end

function HeroEquipUpGradeDlg:setData(upgradeType, targetItem, items, isFromBattle)
	if isFromBattle then
		self.mWindow.panelFund:setVisible(false)
	end

	self.isFromBattle = isFromBattle
	self.upgradeType = upgradeType

	if self.upgradeType ~= Const.UPGRADE_TYPE_EQUIP then
		self.btnSuitList:setVisible(false)
	end

	local configInfo = UPGRADE_INFO_CONFIG[self.upgradeType]
	local listTable = configInfo[1]
	local listPrefab = configInfo[2]
	local upgradeTable = configInfo[3]
	local upgradePrefab = configInfo[4]

	if self.materialListPanel then
		self.materialListPanel:destroy()
		self.upgradePanel:destroy()
	end

	self.materialListPanel = listTable(self, "BgItemList", listPrefab, 0, 0, true)
	self.upgradePanel = upgradeTable(self, "UpGradeInfoPanel", upgradePrefab, 0, 0, true)

	if self.upgradeType == Const.UPGRADE_TYPE_EQUIP then
		self.sortPanel:initSortInfo(EQUIP_UPGRADE_MATERIAL_SORT_MAP, true)
	else
		local maxBreak = targetItem.breakLevel >= targetItem:getMaxBreakLv()

		if maxBreak then
			self.sortPanel:initSortInfo(ARTIFACT_UPGRADE_MATERIAL_SORT_MAP, true, sortArtifactByWear)
		else
			self.sortPanel:initSortInfo(ARTIFACT_UPGRADE_MATERIAL_SORT_MAP, true, sortArtifactByWearWithSameTop)
		end
	end

	if self.upgradeType == Const.UPGRADE_TYPE_ARTIFACT and self.isFromBattle then
		self.materialListPanel.isFromBattle = true
	end

	self:refreshDataShow(targetItem, items)
end

function HeroEquipUpGradeDlg:clearMaterial(prop, total_xp)
	if self.upgradeType == Const.UPGRADE_TYPE_EQUIP then
		self.targetItem = CurAvatar.bagEquips[self.targetItem.gid]
	else
		self.targetItem = CurAvatar.bagArtifacts[self.targetItem.gid]
	end

	self.upgradePanel:clearMaterial(prop, total_xp)

	self.materialListPanel.beAddedToUpPanel = {}

	self:refreshMaterialList()
end

function HeroEquipUpGradeDlg:refreshMaterialList()
	self.items = CurAvatar:getUpgradeEquipMaterial(self.upgradeType, self.targetItem)

	if self.upgradeType == Const.UPGRADE_TYPE_ARTIFACT then
		local maxBreak = self.targetItem.breakLevel >= self.targetItem:getMaxBreakLv()

		if maxBreak then
			self.sortPanel.topFunc = sortArtifactByWear
		else
			self.sortPanel.topFunc = sortArtifactByWearWithSameTop
		end
	end

	if self.checkFilterFunc then
		local tmpItems = {}

		for _, equip in ipairs(self.items) do
			if self.checkFilterFunc(equip) then
				table.insert(tmpItems, equip)
			end
		end

		self.sortPanel:sortByCurConfig(tmpItems)
	else
		self.sortPanel:sortByCurConfig(self.items)
	end
end

function HeroEquipUpGradeDlg:updateSort(items)
	self.items = items

	self.materialListPanel:sortConfigRefresh(self.items)
end

function HeroEquipUpGradeDlg:playUpgradeEfx(isLvUp)
	local effectPath = isLvUp and "Effects/UI/efx_ui_Strengthen_04.prefab" or "Effects/UI/efx_ui_Strengthen02.prefab"

	self.upgradePanel.upgradeMaterialPanel.efxUpgrade:playEffectByPath(effectPath)

	local voicePath = "Audios/SFX/UI/ui_equip_up.ogg"

	CueManager.playUiSfx(voicePath)
	self.upgradePanel.upgradeMaterialPanel.efxUpgrade:setVisible(true)
end

function HeroEquipUpGradeDlg:refreshDataShow(targetItem, items)
	self.targetItem = targetItem
	self.items = items

	self.upgradePanel:setItem(self.targetItem)
	self:refreshMaterialList()
end

return HeroEquipUpGradeDlg
