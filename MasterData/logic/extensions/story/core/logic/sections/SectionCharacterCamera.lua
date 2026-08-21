-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionCharacterCamera.lua

module("logic.extensions.story.core.logic.sections.SectionCharacterCamera", package.seeall)

local M = class("SectionCharacterCamera", StorySectionBase)

M.hideOtherCamTags = {
	StoryPtrTag.CharacterCamera
}

function M:_OnInitCtor()
	self.m_followTarget = nil
	self.m_handle = StoryHandleSwitchCamera.New()
end

function M:OnSectionEnableInternal()
	local tempBinder = self.parent.binder
	local targetUID = self.config:GetArgValue(StoryArgKeyConst.CharacterCamTarget)
	local awakeShowCamUID = self.config:GetArgValue(StoryArgKeyConst.CharacterCamAwakeShow)
	local fov = self.config:GetArgValueNumber(StoryArgKeyConst.CharacterCameraFOV)
	local targetProxyInst = tempBinder:GetGameObjectInstProxy(targetUID)

	if targetProxyInst then
		self.m_followTarget = targetProxyInst.proxyTarget

		self:UpdatePos(self.m_followTarget)
	end

	local targetGo = self.parent.bindingTarget

	if targetGo then
		tempBinder:SetProxyPtrActive(targetGo.uid, true)
	end

	self.m_handle:Handle(awakeShowCamUID, tempBinder, M.hideOtherCamTags, fov)
	self.m_handle:SetCameraFOV(awakeShowCamUID, tempBinder, fov)
end

function M:OnSectionDisableInternal()
	local tempBinder = self.parent.binder
	local targetGo = self.parent.bindingTarget

	if targetGo then
		local resetPos = self.config:GetArgValueBoolean(StoryArgKeyConst.FreeCamDirResetPos)

		if resetPos then
			return
		end

		tempBinder:SetProxyPtrActive(targetGo.uid, false)
	end
end

function M:OnStoryEvaluateInternal(time)
	if not self.m_followTarget then
		return
	end

	self:UpdatePos(self.m_followTarget)
end

function M:UpdatePos(followTarget)
	if not followTarget then
		return
	end

	local targetGo = self.parent.bindingTarget

	if not targetGo then
		return
	end

	local offset = self.config:GetArgValueVector3(StoryArgKeyConst.CharacterCamTargetOffsetPos)
	local getter = StoryRotationArgGetter.New()

	getter:UpdateAsset(self.config)

	local localRotation = Vector3.New()

	if getter.rotValid then
		localRotation = getter.rotation
	end

	local posX, posY, posZ = GameUtils.getLocalPos(followTarget)
	local rx, ry, rz = GameUtils.getLocalRotation(followTarget)

	GameUtils.setLocalPos(targetGo.proxyTarget, posX, posY, posZ)
	GameUtils.setLocalRotation(targetGo.proxyTarget, rx, ry, rz)
	GameUtils.setLocalPos(targetGo.target, offset.x, offset.y, offset.z)
	GameUtils.setLocalRotation(targetGo.target, localRotation.x, localRotation.y, localRotation.z)
end

return M
