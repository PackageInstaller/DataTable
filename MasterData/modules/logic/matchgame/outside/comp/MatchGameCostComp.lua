-- chunkname: @modules/logic/matchgame/outside/comp/MatchGameCostComp.lua

module("modules.logic.matchgame.outside.comp.MatchGameCostComp", package.seeall)

local MatchGameCostComp = class("MatchGameCostComp", LuaCompBase)

function MatchGameCostComp.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, MatchGameCostComp)
end

function MatchGameCostComp:init(go)
	self.go = go
	self._isInitDone = false
	self._isLoadDone = false
	self._isTitleVisible = true
	self._loader = PrefabInstantiate.Create(self.go)

	self._loader:startLoad(MatchGameEnum.CostItemPrefabPath, self._onLoadPrefabDone, self)
end

function MatchGameCostComp:_onLoadPrefabDone(loader)
	self._goCost = loader:getInstGO()
	self._goTitle = gohelper.findChild(self._goCost, "#go_Root/Title")
	self._goRoot = gohelper.findChild(self._goCost, "#go_Root")
	self._goList = gohelper.findChild(self._goCost, "#go_Root/#go_List")
	self._goCostItem = gohelper.findChild(self._goCost, "#go_Root/#go_List/#go_CostItem")
	self._isLoadDone = true

	self:refreshUI()
end

function MatchGameCostComp:onUpdateMO(costList)
	self._costList = costList
	self._isInitDone = true

	self:refreshUI()
end

function MatchGameCostComp:refreshUI()
	if not self._isLoadDone or not self._isInitDone then
		return
	end

	gohelper.setActive(self._goTitle, self._isTitleVisible)
	gohelper.CreateObjList(self, self._refreshCostItem, self._costList, self._goList, self._goCostItem, MatchGameCostItem)
end

function MatchGameCostComp:_refreshCostItem(costItem, costInfo, index)
	costItem:onUpdateMO(costInfo, index)
end

function MatchGameCostComp:setTitleVisible(isVisible)
	if self._isTitleVisible == isVisible then
		return
	end

	self._isTitleVisible = isVisible

	self:refreshUI()
end

function MatchGameCostComp:onDestroy()
	self._loader = nil
end

return MatchGameCostComp
