-- chunkname: @modules/logic/sodache/view/inside/SodacheMapUnitView.lua

module("modules.logic.sodache.view.inside.SodacheMapUnitView", package.seeall)

local SodacheMapUnitView = class("SodacheMapUnitView", BaseView)

function SodacheMapUnitView:onInitView()
	self._units = {}
end

function SodacheMapUnitView:addEvents()
	self.viewContainer:registerCallback(SodacheEvent.OnSceneAssetInited, self._onSceneInit, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnUnitMoveStep, self._onUnitMove, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnAddUnits, self._onAddUnits, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnRemoveUnits, self._onRemoveUnits, self)
end

function SodacheMapUnitView:removeEvents()
	self.viewContainer:unregisterCallback(SodacheEvent.OnSceneAssetInited, self._onSceneInit, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnUnitMoveStep, self._onUnitMove, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnAddUnits, self._onAddUnits, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnRemoveUnits, self._onRemoveUnits, self)
end

function SodacheMapUnitView:_onSceneInit(unitRoot)
	self._unitRoot = unitRoot
	self._inSideMo = SodacheModel.instance:getInsideMo()

	for i, v in ipairs(self._inSideMo.unitBox.units) do
		self:addUnit(v)
	end

	self:addUnit(self._inSideMo.player)
end

function SodacheMapUnitView:addUnit(unitMo)
	if self._units[unitMo.uid] then
		logError("重复加载事件" .. unitMo.uid)

		return
	end

	local go = gohelper.create3d(self._unitRoot, tostring(unitMo.uid))

	self._units[unitMo.uid] = MonoHelper.addNoUpdateLuaComOnceToGo(go, SodacheUnitItem)

	self._units[unitMo.uid]:updateMo(unitMo)
end

function SodacheMapUnitView:_onUnitMove(uid, newPos, subPosId, reason, callback, callobj)
	if not self._units[uid] then
		if callback then
			callback(callobj)
		end

		return false
	end

	self._units[uid]:moveTo(newPos, subPosId, reason, callback, callobj)
end

function SodacheMapUnitView:_onAddUnits(units, unitBox)
	for k, v in ipairs(units) do
		if not self._units[v.uid] then
			self:addUnit(unitBox.unitsMap[v.uid])
		else
			self._units[v.uid]:updateMo(unitBox.unitsMap[v.uid])
		end
	end
end

function SodacheMapUnitView:_onRemoveUnits(uids)
	for k, v in ipairs(uids) do
		if self._units[v] then
			self._units[v]:destory()

			self._units[v] = nil
		end
	end
end

return SodacheMapUnitView
