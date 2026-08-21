-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/unit/herounit/AirWorkUnitCompUIProxy.lua

module("logic.extensions.airworkshop.flow.defflow.unit.herounit.AirWorkUnitCompUIProxy", package.seeall)

local M = class("AirWorkUnitCompUIProxy", BattleUnitCompBase)

M.SignEnum = {
	LOCKED = 1,
	KILL = 3,
	PROTECT = 4,
	ASSISTANT = 2
}

local kCenterCls = UIAirWorkUnitPropertyInCenter
local kCenterRes = ResName.AirWorkShop_air_workshop_scene_unit_operator

function M:onInit()
	self._uiFollow = self._unit.uiFollow
	self._uiBloodFollow = self._unit.uiBloodFollow
	self._uiPropertyTop = false
	self._uiPropertyCenter = false
	self._uiPropertyBottom = false
	self._visible = true

	self:onReuse()
end

function M:onReuse()
	self._visible = true
	self._uiPropertyCenter = kCenterCls:createInstance()

	self._uiFollow:addFollowGameObject(UIFollowType.Center, self._uiPropertyCenter.rootGO)
	self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
end

function M:onReset()
	self._uiFollow:removeFollowGameObject(UIFollowType.Center, self._uiPropertyCenter.rootGO)
	self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	self._uiPropertyCenter:returnSelf()

	self._uiPropertyCenter = false
	self._visible = false
end

function M:onDestroy()
	self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)

	if self._uiPropertyCenter then
		self._uiFollow:removeFollowGameObject(UIFollowType.Center, self._uiPropertyCenter.rootGO)
		self._uiPropertyCenter:returnSelf()
	end

	self._uiFollow = nil
	self._uiBloodFollow = nil
	self._uiPropertyCenter = nil
end

function M:rebuildUI()
	self._uiPropertyCenter:setUrl(kCenterRes)
	self._uiPropertyCenter:setUnit(self._unit)
end

function M:refresh()
	self._uiPropertyCenter:setUnit(self._unit)
end

function M:_onMeshModelLoaded()
	self:setVisible(self._visible)
end

function M:setVisible(visible)
	self._visible = visible

	self._uiPropertyCenter:setVisible(visible)
end

function M:setCenterVisible(visible)
	self._uiPropertyCenter:setVisible(visible)
end

function M:setOperatorVisible(visible)
	self._uiPropertyCenter:setOperatorVisible(visible)
end

function M:doFade(isFade, duration)
	return
end

return M
