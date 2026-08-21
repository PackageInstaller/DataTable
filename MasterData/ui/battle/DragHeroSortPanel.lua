-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\DragHeroSortPanel.lua

local DragHeroSortPanel = Class("DragHeroSortPanel", UIControls.Panel)
local CommonSortPanel = require("UI/Common/CommonSortPanel")
local FilterTitleBtnPanel = require("UI/MainState/FilterTitleBtnPanel")

function DragHeroSortPanel:ctor()
	self:initUI()

	self.mEventHeroListChanged = nil
	self._slot4filterHero = Slot(self.onHeroFilter, self)
end

function DragHeroSortPanel:initUI()
	self.filterSelectPanel = self.mWindow.filterSelectPanel
	self.sortPanel = CommonSortPanel(self, self.mPath)
end

function DragHeroSortPanel:refreshHeros()
	self:_updateHeros()
	self:_filterHeros()

	self.sortPanel.mEventDataListChanged = self.mEventHeroListChanged

	self.sortPanel:sortByCurConfig(self.heros)
end

function DragHeroSortPanel:initSortPanel(sortMap, filterMap, topFunc)
	self.sortPanel:initSortInfo(sortMap or UIConst.HERO_DEFAULT_SORT_MAP, nil, topFunc)

	self.filterMap = filterMap

	if self.filterSelectPanel then
		local mapInfo = self.filterMap ~= nil and self.filterMap or UIConst.HERO_DEFAULT_FILTER_PANEL_MAP

		if UIControls.checkControlFunc(self, self.mPath .. "/SelectPanel") then
			self.filterTitleBtnPanel = FilterTitleBtnPanel(self, self.mPath .. "/SelectPanel", #mapInfo, self.filterSelectPanel, self._slot4filterHero, mapInfo)
		else
			self.filterSelectPanel:setFilterData(UIConst.HERO_DEFAULT_FILTER_PANEL_MAP[1], self._slot4filterHero, 1)
		end
	end

	self:refreshHeros()
end

function DragHeroSortPanel:_updateHeros()
	self._allHeros = {}

	if self.mParent and self.mParent.allHeros then
		for _, hero in ipairs(self.mParent.allHeros) do
			table.insert(self._allHeros, hero)
		end
	else
		for gid, hero in pairs(CurAvatar.heroDic) do
			table.insert(self._allHeros, hero)
		end
	end
end

function DragHeroSortPanel:_filterHeros()
	self.heros = {}

	for i, hero in ipairs(self._allHeros) do
		if self._filterFunc == nil or self._filterFunc(hero) then
			table.insert(self.heros, hero)
		end
	end
end

function DragHeroSortPanel:onHeroFilter(filterFunc, filterInfo)
	self._filterFunc = filterFunc
	self._curFilterInfo = filterInfo

	if not self._allHeros then
		self:_updateHeros()
	end

	self:_filterHeros()
	self.sortPanel:sortByCurConfig(self.heros)

	if self.mEventHeroListChanged then
		self.mEventHeroListChanged(self.heros, true)
	end

	UIManager.getUI("siftBoxDlg", false)
end

return DragHeroSortPanel
