-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/component/visualculling/BattleSceneVisualUnit.lua

module("logic.scene.component.visualculling.BattleSceneVisualUnit", package.seeall)

local M = class("BattleSceneVisualUnit")
local kOuterValue = 0.75
local kInnerValue = 0.5
local kDuration = 0.4

function M:ctor(gameObject)
	self._materialSetter = BatchMaterialSetter.Get(gameObject)
	self._blockObject = SpaceX.CameraBlockObject.Get(gameObject)

	self._materialSetter:SetFloat(ShaderConstants.ID_WSMaskID, self._blockObject.maskHeight)
	self._materialSetter:SetFloat(ShaderConstants.ID_Gradient, kInnerValue)
	self._materialSetter:SetFloat(ShaderConstants.ID_Transparency, 1)

	self._isEnableTransparency = false
end

function M:clear()
	self._materialSetter:Clear()
end

function M:getBlockObject()
	return self._blockObject
end

function M:setTransparencyEnable(enable)
	if self._isEnableTransparency == enable then
		return
	end

	self._isEnableTransparency = enable

	self._materialSetter:KillAll(true)

	if enable then
		self._materialSetter:DOFloat(ShaderConstants.ID_Transparency, 1, kOuterValue, kDuration)
	else
		self._materialSetter:DOFloat(ShaderConstants.ID_Transparency, kOuterValue, 1, kDuration)
	end
end

return M
