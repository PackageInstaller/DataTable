-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionParticleEffect.lua

module("logic.extensions.story.core.logic.sections.SectionParticleEffect", package.seeall)

local M = class("SectionParticleEffect", StorySectionBase)

function M:_OnInitCtor()
	self.m_targetPs = nil
	self.m_lastTime = 0
	self.m_positionHandle = StoryHandleFixPosition.New()
	self.m_rotationHandle = StoryHandleFixRotation.New()
end

function M:ReleaseData()
	self.m_lastTime = 0
	self.m_targetPs = nil
end

function M:OnSectionEnableInternal()
	local targetGo = self.parent.bindingTarget

	if goutil.isNil(targetGo) then
		return
	end

	self.m_playTime = 0

	self.parent.binder:SetPtrActive(targetGo.uid, true)
	goutil.setActive(targetGo.proxyTarget, true)

	self.m_targetPs = targetGo:GetComponentInChildren(typeof(UnityEngine.ParticleSystem), true)

	self:RefreshPRS()

	if self.m_targetPs then
		self.m_targetPs:Simulate(0, true, true)

		self.m_targetPs.time = 0

		self.m_targetPs:Play()
	end
end

function M:OnSectionDisableInternal()
	self:ReleaseData()

	local targetGo = self.parent.bindingTarget

	if targetGo then
		self.parent.binder:SetPtrActive(targetGo.uid, false)
		goutil.setActive(targetGo.proxyTarget, false)
	end
end

function M:OnStoryEvaluateInternal(time)
	if self.m_targetPs then
		local delt = time - self.m_lastTime

		if delt < 0 then
			delt = 0
		elseif delt > 2 then
			delt = 2
		end

		if not self.m_targetPs.isPlaying then
			self.m_targetPs:Play()
		end

		self.m_lastTime = time

		self.m_targetPs:Simulate(delt, true, false)
	end

	self:RefreshPRS()
end

function M:RefreshPRS()
	local efxGameObj = self.parent.bindingTarget

	self.m_positionHandle:Handle(self.config, efxGameObj, true)
	self.m_rotationHandle:Handle(self.config, efxGameObj, true)
end

return M
