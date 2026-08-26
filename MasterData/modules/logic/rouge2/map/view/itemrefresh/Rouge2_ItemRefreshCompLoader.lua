-- chunkname: @modules/logic/rouge2/map/view/itemrefresh/Rouge2_ItemRefreshCompLoader.lua

module("modules.logic.rouge2.map.view.itemrefresh.Rouge2_ItemRefreshCompLoader", package.seeall)

local Rouge2_ItemRefreshCompLoader = class("Rouge2_ItemRefreshCompLoader", LuaCompBase)

function Rouge2_ItemRefreshCompLoader.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_ItemRefreshCompLoader)
end

function Rouge2_ItemRefreshCompLoader:init(go)
	self.go = go
	self._isDone = false
	self._loader = PrefabInstantiate.Create(self.go)

	self._loader:startLoad(Rouge2_Enum.ResPath.ItemRefreshComp, self._loadRefreshCompDone, self)
end

function Rouge2_ItemRefreshCompLoader:addEventListeners()
	return
end

function Rouge2_ItemRefreshCompLoader:removeEventListeners()
	return
end

function Rouge2_ItemRefreshCompLoader:_loadRefreshCompDone(loader)
	local goRefreshComp = loader:getInstGO()

	if gohelper.isNil(goRefreshComp) then
		return
	end

	self._refreshComp = MonoHelper.addNoUpdateLuaComOnceToGo(goRefreshComp, Rouge2_ItemRefreshComp)

	self:_reallyInitRefreshCallback()
	self._refreshComp:show(self._visible)

	self._isDone = true
end

function Rouge2_ItemRefreshCompLoader:initRefreshCallback(callback, callbackObj)
	self._refreshCb = callback
	self._refreshCbObj = callbackObj

	self:_reallyInitRefreshCallback()
end

function Rouge2_ItemRefreshCompLoader:_reallyInitRefreshCallback()
	if not self._refreshComp then
		return
	end

	self._refreshComp:initRefreshCallback(self._refreshCb, self._refreshCbObj)
end

function Rouge2_ItemRefreshCompLoader:show(visible)
	self._visible = visible

	if not self._loader or not self._refreshComp then
		return
	end

	self._refreshComp:show(self._visible)
end

function Rouge2_ItemRefreshCompLoader:onDestroy()
	self._loader = nil
	self._refreshComp = nil
	self._refreshCb = nil
	self._refreshCbObj = nil
end

return Rouge2_ItemRefreshCompLoader
