-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\DragEquipSortPanel.lua

local DragEquipSortPanel = Class("DragEquipSortPanel", UIControls.Panel)
local CommonSortPanel = require("UI/Common/CommonSortPanel")
local FilterTitleBtnPanel = require("UI/MainState/FilterTitleBtnPanel")

function DragEquipSortPanel:ctor(...)
	self:initUI()

	self._slot4filterEquip = Slot(self.onEquipFilter, self)
	self.mEventEquipListChanged = nil
end

function DragEquipSortPanel:initUI(...)
	self.filterSelectPanel = self.mWindow.filterSelectPanel
	self.sortPanel = CommonSortPanel(self, self.mPath)
end

function DragEquipSortPanel:refreshEquips(...)
	self:_updateEquips()
	self:_filterEquips()

	self.sortPanel.mEventDataListChanged = self.mEventEquipListChanged

	self.sortPanel:sortByCurConfig(self.equips)
end

function DragEquipSortPanel:initSortPanel(sortMap, filterMap, topFunc)
	self.sortPanel:initSortInfo(sortMap or UIConst.EQUIP_DEFAULT_SORT_MAP, nil, topFunc)

	self.filterMap = filterMap

	if self.filterSelectPanel then
		local mapInfo = self.filterMap ~= nil and self.filterMap or UIConst.HERO_DEFAULT_FILTER_PANEL_MAP

		if UIControls.checkControlFunc(self, self.mPath .. "/SelectPanel") then
			self.filterTitleBtnPanel = FilterTitleBtnPanel(self, self.mPath .. "/SelectPanel", #mapInfo, self.filterSelectPanel, self._slot4filterEquip, mapInfo)
		else
			self.filterSelectPanel:setFilterData(UIConst.EQUIP_FILTER_GROUP_MAP, self._slot4filterEquip, 1)
		end
	end

	self:refreshEquips()
end

function DragEquipSortPanel:_updateEquips()
	self._allEquips = {}

	if self.mParent and self.mParent.allEquips then
		for _, equip in ipairs(self.mParent.allEquips) do
			table.insert(self._allEquips, equip)
		end
	else
		for gid, equip in pairs(CurAvatar.bagEquips) do
			table.insert(self._allEquips, equip)
		end
	end
end

function DragEquipSortPanel:_filterEquips()
	self.equips = {}

	for i, equip in ipairs(self._allEquips) do
		if self._filterFunc == nil or self._filterFunc(equip) then
			table.insert(self.equips, equip)
		end
	end
end

function DragEquipSortPanel:onEquipFilter(filterFunc, filterInfo)
	self._filterFunc = filterFunc
	self._curFilterInfo = filterInfo

	if not self._allEquips then
		self:_updateEquips()
	end

	self:_filterEquips()
	self.sortPanel:sortByCurConfig(self.equips)

	if self.mEventEquipListChanged then
		self.mEventEquipListChanged(self.equips, true)
	end
end

return DragEquipSortPanel
