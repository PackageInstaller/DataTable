-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionShakeCamera.lua

module("logic.extensions.story.core.logic.sections.SectionShakeCamera", package.seeall)

local M = class("SectionShakeCamera", StorySectionBase)
local kMainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()

function M:_OnInitCtor()
	self.m_lastTime = 0
	self.m_posFrom = nil
	self.m_shakeCameraHandle = StoryHandleShakeCamera.New()
	self.m_camProxyInst = nil
end

function M:OnSectionEnableInternal()
	local targetGo = self.parent.bindingTarget

	if targetGo then
		self.m_camProxyInst = targetGo:GetComponent(typeof(StoryEngine.StoryGameObjectInstProxy))

		local shakeCode = self.config:GetArgValue(StoryArgKeyConst.CameraShakeCode)
		local shakeTimeType = self.config:GetArgValueEnum(StoryArgKeyConst.CameraShakeTime)
		local needStopShake = self.config:GetArgValueBoolean(StoryArgKeyConst.CameraStopShake)

		self.m_shakeCameraHandle:HandleEnter(self.m_camProxyInst.target, shakeCode, shakeTimeType, needStopShake)
	end

	local entry = StoryController.instance:getCurStoryEntry()

	self._bgContainObj = entry.bgRootContain

	if not self._bgContainObj or goutil.isNil(self._bgContainObj) then
		return
	end

	self._bgContainObj.transform:SetParent(entry.scene2D.transform)
	StoryUtils.ResetTransform(self._bgContainObj)
end

function M:OnSectionDisableInternal()
	if self.m_camProxyInst then
		local needStopShake = self.config:GetArgValueBoolean(StoryArgKeyConst.CameraStopShake)

		self.m_shakeCameraHandle:HandleExit(self.m_camProxyInst.target, needStopShake)
	end

	self.m_camProxyInst = nil

	local entry = StoryController.instance:getCurStoryEntry()

	self._bgContainObj = entry.bgRootContain

	if not self._bgContainObj or goutil.isNil(self._bgContainObj) then
		return
	end

	self._bgContainObj.transform:SetParent(kMainCamera.transform)
end

return M
