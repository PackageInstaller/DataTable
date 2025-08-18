-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroEquipWearDlg.lua

local HeroEquipListChild = require("UI/Hero/HeroEquipListChild")
local HeroArtifactListChild = require("UI/Hero/HeroArtifactListChild")
local SingleEquipTipsChild = require("UI/Common/Tips/SingleEquipTipsChild")
local SingleArtifactTipsChild = require("UI/Common/Tips/SingleArtifactTipsChild")
local CommonSortPanel = require("UI/Common/CommonSortPanel")
local EQUIP_WEAR_SORT_MAP = {
	{
		name = "sortDefineQuality",
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
local ARTIFACT_WEAR_SORT_MAP = {
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
	}
}
local strClassName = "HeroEquipWearDlg"
local HeroEquipWearDlg = Class(strClassName, UIControls.Window)

function HeroEquipWearDlg:ctor()
	self:initUI()
end

function HeroEquipWearDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnOffWear = UIControls.Button(self, "WearInfoPanel/BtnFun1")

	self.btnOffWear:addEventClick(self.onBtnOffWearClick)

	self.imgWearState = UIControls.Image(self, "WearInfoPanel/ImgState")
	self.btnWear = UIControls.Button(self, "WearInfoPanel/BtnFun2")

	self.btnWear:addEventClick(self.onBtnWearClick)

	self.sortPanel = CommonSortPanel(self, "BgItemList/TabFunPanel")
	self.sortPanel.mEventDataListChanged = Slot(self.updateSort, self)
	self.btnTips = UIControls.Button(self, "BtnTips")
	self.suitFilterMap = CurAvatar:initSuitFilterMapInfo()

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnFilter = UIControls.Button(self, "BgItemList/TabFunPanel/BtnFilter")

	self.btnFilter:addEventClick(self.onBtnFilterClick)

	self.imgNoneLeft = UIControls.Image(self, "WearInfoPanel/InfoPanel1/BgNothing")
	self.imgNoneRight = UIControls.Image(self, "WearInfoPanel/InfoPanel2/BgNothing")
	self.textNohting = UIControls.Label(self, "WearInfoPanel/InfoPanel1/BgNothing/Text")
	self.textUnChoose = UIControls.Label(self, "WearInfoPanel/InfoPanel2/BgNothing/Text")
end

function HeroEquipWearDlg:onBtnTipsClick()
	local infoNoticeId = self.wearType == Const.WEAR_TYPE_EQUIP and Const.INFO_NOTICE_EQUIP_WEAR or Const.INFO_NOTICE_ARTIFACT_WEAR

	UIManager.getUI("infoNotice", true):showSystemInfo(infoNoticeId)
end

local WEAR_INFO_CONFIG = {
	{
		HeroEquipListChild,
		"EquipListWearPanel",
		SingleEquipTipsChild,
		"EquipInfoWearPanel",
		"gridEquip"
	},
	{
		HeroArtifactListChild,
		"BadgeListWearPanel",
		SingleArtifactTipsChild,
		"BadgeInfoWearPanel",
		"gridArtifact"
	}
}

local function confirmOffEquip(obj)
	RPC.equipOff(obj.inWearing, {
		obj.subType - 1
	})
end

function HeroEquipWearDlg:onBtnOffWearClick()
	if self.wearType == Const.WEAR_TYPE_EQUIP then
		local wearEquip = self.hero:getEquipBySubType(self.filterAttr)

		if self.isFromEditPlan and wearEquip then
			local willReplaceGid = wearEquip.gid
			local gidList = self.hero:getEquipGidList()

			for i, gid in ipairs(gidList) do
				if gid == willReplaceGid then
					table.remove(gidList, i)
				end
			end

			CurAvatar:changeWearPartPlanData(self.hero, gidList, nil, nil, true)
			self:setVisible(false)
		else
			RPC.equipOff(self.hero.gid, {
				self.filterAttr - 1
			})
		end
	end

	if self.wearType == Const.WEAR_TYPE_ARTIFACT then
		if self.isFromEditPlan then
			CurAvatar:changeWearPartPlanData(self.hero, nil, 0, nil, true)
			self:setVisible(false)
		else
			local artifact = self.hero:getArtifact()

			if artifact then
				RPC.artifactOff(self.hero.gid, artifact.gid)
			end
		end
	end
end

local function confirmWearEquip(wearInfo)
	if wearInfo.equipGids and #wearInfo.equipGids > 0 then
		RPC.equipWear(wearInfo.heroGid, wearInfo.equipGids)
	end
end

function HeroEquipWearDlg:onBtnWearClick()
	if self.wearType == Const.WEAR_TYPE_EQUIP and self.selectTipsChild then
		local willWearEquip = self.selectTipsChild.gridEquip.object

		if self.isFromEditPlan then
			local willReplaceGid = 0

			if self.wearTipsChild then
				willReplaceGid = self.wearTipsChild.gridEquip.object.gid
			end

			local gidList = self.hero:getEquipGidList()

			for i, gid in ipairs(gidList) do
				if gid == willReplaceGid then
					table.remove(gidList, i)
				end
			end

			table.insert(gidList, willWearEquip.gid)
			CurAvatar:changeWearPartPlanData(self.hero, gidList, nil, nil, true)
			self:setVisible(false)
		else
			local heroWearInfo = {}

			heroWearInfo.heroGid = self.hero.gid
			heroWearInfo.equipGids = {
				willWearEquip.gid
			}

			local tempEquips = self.hero:getEquips()
			local beReplacedEquip = tempEquips[willWearEquip.part]

			RPC.equipWear(self.hero.gid, {
				willWearEquip.gid
			})
		end
	end

	if self.wearType == Const.WEAR_TYPE_ARTIFACT and self.selectTipsChild then
		if self.isFromEditPlan then
			local willReplaceGid = 0

			if self.wearTipsChild then
				willReplaceGid = self.wearTipsChild.gridArtifact.object.gid
			end

			CurAvatar:changeWearPartPlanData(self.hero, nil, self.selectTipsChild.gridArtifact.object.gid, nil, true)
			self:setVisible(false)
		else
			RPC.artifactWear(self.hero.gid, self.selectTipsChild.gridArtifact.object.gid)
		end
	end
end

function HeroEquipWearDlg:setData(wearType, hero, filterAttr, isFromEditPlan, dataList, isFromBattle)
	if isFromBattle then
		self.mWindow.panelFund:setVisible(false)
	end

	self.hero = hero
	self.wearType = wearType
	self.filterAttr = filterAttr
	self.isFromEditPlan = isFromEditPlan
	self.isFromBattle = isFromBattle

	local tableList = WEAR_INFO_CONFIG[self.wearType][1]
	local prefabName = WEAR_INFO_CONFIG[self.wearType][2]

	if self.panelDataList then
		self.panelDataList:destroy()
	end

	local sortMap = self.wearType == Const.WEAR_TYPE_EQUIP and EQUIP_WEAR_SORT_MAP or ARTIFACT_WEAR_SORT_MAP

	self.sortPanel:initSortInfo(sortMap)

	self.panelDataList = tableList(self, "BgItemList", "System/Hero/" .. prefabName, 0, 0, true)

	if self.wearType == Const.WEAR_TYPE_EQUIP then
		for _, equip in ipairs(dataList) do
			equip:setSortDefineQuality(self.hero.id)
		end
	end

	self.btnFilter:setVisible(self.wearType == Const.WEAR_TYPE_EQUIP)

	self.totalDataList = dataList

	self:refreshData(dataList)

	if self.wearType == Const.WEAR_TYPE_EQUIP then
		self.textUnChoose:setText(Lang.get(75777))
		self.textNohting:setText(Lang.get(75776))
	else
		self.textUnChoose:setText(Lang.get(75779))
		self.textNohting:setText(Lang.get(75778))
	end
end

function HeroEquipWearDlg:refreshData(dataList)
	self:refreshEquipList(dataList)
	self:refreshDataInfo()
end

function HeroEquipWearDlg:refreshEquipList(dataList)
	if dataList then
		self.dataList = dataList
	end

	self.sortPanel:sortByCurConfig(self.dataList)
end

function HeroEquipWearDlg:onBtnFilterClick()
	local siftBoxDlg = UIManager.getUI("siftBoxDlg", true)

	if siftBoxDlg then
		siftBoxDlg:setIsHaveAll(true)
		siftBoxDlg:initFilterInfo(self.suitFilterMap, self.filterConfig, Slot(self.filterSuitMaterial, self))
		siftBoxDlg:setTitle(Lang.get(50274))
	end
end

function HeroEquipWearDlg:filterSuitMaterial(filterCheckFunc, _filterConfig)
	self.checkFilterFunc = filterCheckFunc
	self.filterConfig = _filterConfig

	local tmpItems = {}

	if self.checkFilterFunc then
		for _, equip in ipairs(self.totalDataList) do
			if self.checkFilterFunc(equip) then
				table.insert(tmpItems, equip)
			end
		end
	end

	self:refreshEquipList(tmpItems)

	if self.panelDataList and self.panelDataList.panelContentNone then
		self.panelDataList.panelContentNone:setVisible(#tmpItems == 0)
	end

	local siftBoxDlg = UIManager.getUI("siftBoxDlg", nil, false)

	if siftBoxDlg then
		siftBoxDlg:setVisible(false)
	end
end

function HeroEquipWearDlg:updateSort(datas)
	self.dataList = datas

	self.panelDataList:setData(self.dataList)
end

function HeroEquipWearDlg:refreshDataInfo()
	local item

	if self.wearType == Const.WEAR_TYPE_EQUIP then
		item = self.hero:getEquipBySubType(self.filterAttr)
	else
		item = self.hero:getArtifact()
	end

	if item then
		self.imgNoneLeft:setVisible(false)

		if self.wearTipsChild then
			self.wearTipsChild:destroy()
		end

		local childTable = WEAR_INFO_CONFIG[self.wearType][3]
		local prefabName = WEAR_INFO_CONFIG[self.wearType][4]

		self.wearTipsChild = childTable(self, "WearInfoPanel/InfoPanel1", "System/Hero/" .. prefabName, 0, 0, true)

		self.wearTipsChild:setItem(item)

		local gridName = WEAR_INFO_CONFIG[self.wearType][5]

		if self.selectTipsChild and self.selectTipsChild[gridName].object.gid == item.gid then
			self.selectTipsChild:destroy()

			self.selectTipsChild = nil
		end
	elseif self.wearTipsChild then
		self.wearTipsChild:destroy()

		self.wearTipsChild = nil
	end

	self.btnOffWear:setVisible(self.wearTipsChild ~= nil)
	self.imgWearState:setVisible(self.wearTipsChild ~= nil)
	self.btnWear:setVisible(self.selectTipsChild ~= nil)
end

function HeroEquipWearDlg:setSelectItem(item)
	self.imgNoneRight:setVisible(false)

	if not self.selectTipsChild then
		local childTable = WEAR_INFO_CONFIG[self.wearType][3]
		local prefabName = WEAR_INFO_CONFIG[self.wearType][4]

		self.selectTipsChild = childTable(self, "WearInfoPanel/InfoPanel2", "System/Hero/" .. prefabName, 0, 0, true)
	end

	if self.wearType == Const.WEAR_TYPE_EQUIP then
		self.selectTipsChild:setItem(item, self.hero:getEquips())
		self.selectTipsChild:setSpSuitNum(self.hero:getEquips(), self.hero)
	else
		self.selectTipsChild:setItem(item)
	end

	self.btnWear:setVisible(true)
end

function HeroEquipWearDlg:onCloseClick()
	self:setVisible(false)
end

return HeroEquipWearDlg
