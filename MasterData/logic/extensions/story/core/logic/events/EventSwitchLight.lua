-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventSwitchLight.lua

module("logic.extensions.story.core.logic.events.EventSwitchLight", package.seeall)

local M = class("EventSwitchLight", StoryEventBase)

function M:_OnInitCtor()
	return
end

function M:OnEventExecuteInternal()
	local info = self.binder:FindIDPtr(StoryConstDef.CharacterLightTag)

	if not info then
		return
	end

	local inst = info.targetObj

	if goutil.isNil(inst) then
		return
	end

	local characterRefId = self.config:GetArgValue(StoryArgKeyConst.RefTargetID)
	local m_proxyInst = self.binder:GetGameObjectInstProxy(characterRefId)

	if not m_proxyInst then
		return
	end

	local characterTarget = m_proxyInst.target

	if goutil.isNil(characterTarget) then
		return
	end

	if not goutil.isNil(inst) then
		local light = SpaceX.CharacterMainLightUtil.Get(inst.target)
		local colorStr = self.config:GetArgValue(StoryArgKeyConst.LightColor)
		local intensity = self.config:GetArgValueNumber(StoryArgKeyConst.LightIntensity)
		local getter = StoryRotationArgGetter.New()

		getter:UpdateAsset(self.config)

		local localRotation = Vector3.New()

		if getter.rotValid then
			localRotation = getter.rotation
		end

		light:BindCharacter(characterTarget, colorStr, intensity, getter.rotation.x, getter.rotation.y, getter.rotation.z)
	end

	self.binder:SetProxyPtrActive(StoryConstDef.CharacterLightTag, true)
	goutil.setActive(inst.proxyTarget, true)
end

return M
