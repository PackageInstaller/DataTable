-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\HeroEquipBuildDlg.lua

local CommonSortPanel = require("UI/Common/CommonSortPanel")
local EquipBuildListChild = require("UI/Equip/EquipBuildListChild")
local EquipBuildInfoPanel = require("UI/Equip/EquipBuildInfoPanel")
local FilterTitleBtnPanel = require("UI/MainState/FilterTitleBtnPanel")
local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local ResEquipTowerCustomEquipEffect = require("ClientData/ResEquipTowerCustomEquipEffect")
local strClassName = "HeroEquipBuildDlg"
local HeroEquipBuildDlg = Class(strClassName, UIControls.Window)
local BUILD_CONFIG = {
	{
		EquipBuildListChild,
		{
			"System/Hero/EquipListPanel",
			"System/Hero/HeroStoneListPanel"
		},
		EquipBuildInfoPanel,
		"System/Hero/EquipPowerUpPanel"
	}
}
local EQUIP_BUILD_SORT_MAP = {
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

function HeroEquipBuildDlg:ctor()
	self:initUI()
end

function HeroEquipBuildDlg:initUI()
	self.btnSuitList = UIControls.Button(self, "BgItemList/TabFunPanel/BtnFilter", "Text")

	self.btnSuitList:addEventClick(self.onBtnSuitListClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.sortEquipPanel = CommonSortPanel(self, "BgItemList/TabFunPanel")
	self.sortEquipPanel.mEventDataListChanged = Slot(self.updateSort, self)
	self.sortStonePanel = CommonSortPanel(self, "BgItemList/Bg1/ListFunPanel")
	self.sortStonePanel.mEventDataListChanged = Slot(self.updateSort, self)
	self.filterSelectPanel = FilterSelectPanel(self, "BgItemList/ListSelectPanel")

	local mapInfo = UIConst.HERO_DEFAULT_FILTER_PANEL_MAP

	self.filterTitleBtnPanel = FilterTitleBtnPanel(self, "BgItemList/Bg1/ListFunPanel/SelectPanel", #mapInfo, self.filterSelectPanel, Slot(self.onStoneFilter, self), mapInfo)
	self.panelSelect = UIControls.Panel(self, "BgItemList/Bg1")
	self.noContent = UIControls.Panel(self, "BgItemList/EquipListPanel/NoContent")
	self.suitFilterMap = CurAvatar:initSuitFilterMapInfo()
end

function HeroEquipBuildDlg:refreshItemList(listType)
	if listType then
		self.listType = listType
	end

	if self.listType == Const.BUILD_PANEL_TYPE_EQUIP then
		self.panelSelect:setVisible(false)
		self.filterSelectPanel:setVisible(false)
		self.sortEquipPanel:setVisible(true)
		self.sortEquipPanel:initSortInfo(EQUIP_BUILD_SORT_MAP)

		if self.targetStone then
			self.items = CurAvatar:getBuildEquipByStone(self.targetStone.resData.extend_args1)
		else
			self.items = CurAvatar:getAllCanBuildEquip()
		end

		self.sortPanel = self.sortEquipPanel

		self.panelEquipDataList:setVisible(true)
		self.panelStoneDataList:setVisible(false)

		self.panelDataList = self.panelEquipDataList

		if self.checkFilterEquipFunc then
			local tmpItems = {}

			for _, equip in ipairs(self.items) do
				if self.checkFilterEquipFunc(equip) then
					table.insert(tmpItems, equip)
				end
			end

			self.items = tmpItems
		end
	else
		self.sortEquipPanel:setVisible(false)
		self.sortStonePanel:setVisible(true)
		self.sortStonePanel:initSortInfo(UIConst.HERO_DEFAULT_SORT_MAP)
		self.panelSelect:setVisible(true)

		if self.targetEquip and self.targetEquip.defineEffectId and self.targetEquip.defineEffectId ~= 0 then
			self.items = CurAvatar:getBuildStoneBySpeEquip(self.targetEquip.defineEffectId)
		else
			self.items = CurAvatar:getAllBuildStone()
		end

		self.sortPanel = self.sortStonePanel

		self.panelEquipDataList:setVisible(false)
		self.panelStoneDataList:setVisible(true)

		self.panelDataList = self.panelStoneDataList

		if self.checkFilterStoneFunc then
			local tmpItems = {}

			for _, item in ipairs(self.items) do
				if ResEquipTowerCustomEquipEffect[item.resData.extend_args1] then
					local heroId = ResEquipTowerCustomEquipEffect[item.resData.extend_args1][1].hero_id
					local fakeHero = BaseObject.GetObject(heroId)

					if self.checkFilterStoneFunc(fakeHero) then
						table.insert(tmpItems, item)
					end
				end
			end

			self.items = tmpItems
		end
	end

	self.sortPanel.curSortBtn = nil

	self.sortPanel:sortByCurConfig(self.items)

	if utils.getTableElemCount(self.items) == 0 then
		self.noContent:setVisible(true)
	else
		self.noContent:setVisible(false)
	end

	self:refreshEquipBuildInfoShow()
end

function HeroEquipBuildDlg:setData(listType, targetItem, isFromBattle)
	if isFromBattle then
		self.mWindow.panelFund:setVisible(false)
	end

	self.isFromBattle = isFromBattle
	self.listType = listType

	if targetItem.itemType == Const.ITEM_TYPE_EQUIP then
		self.targetEquip = targetItem
	else
		self.targetStone = targetItem
	end

	local buildConfig = BUILD_CONFIG[1]
	local tableList = buildConfig[1]
	local prefabEquipName = buildConfig[2][1]

	self.panelEquipDataList = tableList(self, "BgItemList", prefabEquipName, 0, 0, true)

	local prefabStoneName = buildConfig[2][2]

	self.panelStoneDataList = tableList(self, "BgItemList", prefabStoneName, 0, 0, true)

	local buildTable = buildConfig[3]
	local buildPanelPrefab = buildConfig[4]

	self.buildPanel = buildTable(self, "UpGradeInfoPanel", buildPanelPrefab, 0, 0, true)

	self:refreshItemList()
end

function HeroEquipBuildDlg:setBuildType()
	if self.targetEquip and self.targetEquip:isDefineHeroEquip() then
		self.buildType = Const.BUILD_TYPE_SPECIAL_QUIALITY_UP
	else
		self.buildType = Const.BUILD_TYPE_NORMAL
	end
end

function HeroEquipBuildDlg:updateSort(items)
	self.items = items

	self.panelDataList:sortConfigRefresh(self.items)
end

function HeroEquipBuildDlg:setSelectItem(item)
	if self.targetEquip and self.targetEquip == item then
		self:clearEquip()

		return
	end

	if self.targetStone and self.targetStone == item then
		self:clearStone()

		return
	end

	if item.itemType == Const.ITEM_TYPE_EQUIP then
		self.targetEquip = item
	else
		self.targetStone = item
	end

	self:refreshEquipBuildInfoShow()
end

function HeroEquipBuildDlg:clearEquip()
	self.targetEquip = nil

	self:refreshEquipBuildInfoShow()
	self.panelDataList:clearSelectGrid()
end

function HeroEquipBuildDlg:clearStone()
	self.targetStone = nil

	self:refreshEquipBuildInfoShow()
	self.panelDataList:clearSelectGrid()
end

function HeroEquipBuildDlg:refreshEquipBuildInfoShow()
	self:setBuildType()
	self.buildPanel:setItem(self.targetEquip, self.targetStone)
end

function HeroEquipBuildDlg:onEquipBuild(newEquip)
	self.targetEquip = newEquip

	self.buildPanel:onEquipBuild(newEquip)
end

function HeroEquipBuildDlg:onStoneFilter(filterCheckFunc)
	self.checkFilterStoneFunc = filterCheckFunc

	local tmpItems = {}

	if self.checkFilterStoneFunc then
		if self.targetEquip and self.targetEquip.defineEffectId and self.targetEquip.defineEffectId ~= 0 then
			self.items = CurAvatar:getBuildStoneBySpeEquip(self.targetEquip.defineEffectId)
		else
			self.items = CurAvatar:getAllBuildStone()
		end

		for _, item in ipairs(self.items) do
			if ResEquipTowerCustomEquipEffect[item.resData.extend_args1] then
				local heroId = ResEquipTowerCustomEquipEffect[item.resData.extend_args1][1].hero_id
				local fakeHero = BaseObject.GetObject(heroId)

				if self.checkFilterStoneFunc(fakeHero) then
					table.insert(tmpItems, item)
				end
			end
		end
	end

	self.sortPanel:sortByCurConfig(tmpItems)
end

function HeroEquipBuildDlg:onBtnSuitListClick()
	local siftBoxDlg = UIManager.getUI("siftBoxDlg", true)

	if siftBoxDlg then
		siftBoxDlg:setIsHaveAll(true)
		siftBoxDlg:initFilterInfo(self.suitFilterMap, self.filterConfig, Slot(self.filterSuitMaterial, self))
		siftBoxDlg:setTitle(Lang.get(50274))
	end
end

function HeroEquipBuildDlg:filterSuitMaterial(filterCheckFunc, _filterConfig)
	self.checkFilterEquipFunc = filterCheckFunc
	self.filterConfig = _filterConfig

	local tmpItems = {}

	if self.checkFilterEquipFunc then
		if self.targetStone then
			self.items = CurAvatar:getBuildEquipByStone(self.targetStone.resData.extend_args1)
		else
			self.items = CurAvatar:getAllCanBuildEquip()
		end

		for _, equip in ipairs(self.items) do
			if self.checkFilterEquipFunc(equip) then
				table.insert(tmpItems, equip)
			end
		end
	end

	self.sortPanel:sortByCurConfig(tmpItems)

	local siftBoxDlg = UIManager.getUI("siftBoxDlg", nil, false)

	if siftBoxDlg then
		siftBoxDlg:setVisible(false)
	end
end

function HeroEquipBuildDlg:onBtnCloseClick()
	self:setVisible(false)
end

function HeroEquipBuildDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_BUILDEQUIP)
end

return HeroEquipBuildDlg
