-- chunkname: @modules/common/others/LuaMixScrollViewExtended.lua

module("modules.common.others.LuaMixScrollViewExtended", package.seeall)

local LuaMixScrollView = LuaMixScrollView

LuaMixScrollView.__onUpdateCell = LuaMixScrollView._onUpdateCell

function LuaMixScrollView:setDynamicGetItem(callback, callbackObj)
	self._dynamicGetCallback = callback
	self._dynamicGetCallbackObj = callbackObj
	self._useDynamicGetItem = true
end

function LuaMixScrollView:_onUpdateCell(cellGO, index, type, param)
	if not self._useDynamicGetItem then
		LuaMixScrollView.__onUpdateCell(self, cellGO, index, type, param)

		return
	end

	local mo = self._model:getByIndex(index + 1)
	local prefabInstName, cellClass, prefabUrl = self._dynamicGetCallback(self._dynamicGetCallbackObj, mo)

	prefabInstName = prefabInstName or LuaListScrollView.PrefabInstName
	cellClass = cellClass or self._param.cellClass
	prefabUrl = prefabUrl or self._param.prefabUrl

	local transform = cellGO.transform
	local childCount = transform.childCount

	for i = 1, childCount do
		local child = transform:GetChild(i - 1)

		gohelper.setActive(child, child.name == prefabInstName)
	end

	local luaCellComp = self:_getLuaCellComp(cellGO, prefabInstName, cellClass, prefabUrl)

	luaCellComp._index = index + 1

	luaCellComp:onUpdateMO(mo, type, param)
end

function LuaMixScrollView:_getLuaCellComp(cellGO, prefabInstName, cellClass, prefabUrl)
	local prefabInstGO = gohelper.findChild(cellGO, prefabInstName)
	local luaCellComp

	if prefabInstGO then
		luaCellComp = MonoHelper.getLuaComFromGo(prefabInstGO, cellClass)
	else
		if self._param.prefabType == ScrollEnum.ScrollPrefabFromRes then
			prefabInstGO = self:getResInst(prefabUrl, cellGO, prefabInstName)
		elseif self._param.prefabType == ScrollEnum.ScrollPrefabFromView then
			prefabInstGO = gohelper.clone(self._cellSourceGO, cellGO, prefabInstName)

			gohelper.setActive(prefabInstGO, true)
		else
			logError("LuaMixScrollView prefabType not support: " .. self._param.prefabType)
		end

		luaCellComp = MonoHelper.addNoUpdateLuaComOnceToGo(prefabInstGO, cellClass)

		luaCellComp:initInternal(prefabInstGO, self)

		self._cellCompDict[luaCellComp] = true
	end

	return luaCellComp
end

function LuaMixScrollView.activateExtend()
	return
end

return LuaMixScrollView
