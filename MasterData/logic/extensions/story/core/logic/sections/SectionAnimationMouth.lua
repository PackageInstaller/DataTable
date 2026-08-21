-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionAnimationMouth.lua

module("logic.extensions.story.core.logic.sections.SectionAnimationMouth", package.seeall)

local M = class("SectionAnimationMouth", StorySectionBase)

function M:_OnInitCtor()
	self._playerAdapter = nil
	self._loader = nil
end

function M:OnSectionEnableInternal()
	local targetGo = self.parent.bindingTarget

	if goutil.isNil(targetGo) then
		return
	end

	local inst = targetGo:GetComponent(typeof(StoryEngine.StoryGameObjectInstProxy))

	self._playerAdapter = MorpherPlayerAdapter.Get(inst.target)

	if not self._playerAdapter then
		return
	end

	if self._playerAdapter.HasMorpherPlayer then
		self._playerAdapter:StopMouth(true)
	end

	local clipName = self.config:GetArgValue(StoryArgKeyConst.RefAssetsMouth)

	if string.nilorempty(clipName) then
		return
	end

	local storyId = StoryController.instance:getCurStoryEntry():getStoryId()
	local clipFilePath = StoryLogicResPathUtils.GetMouthAnimationClipPath(storyId, clipName)

	self:_loadClipFile(clipFilePath)
end

function M:OnStoryEvaluateInternal(time)
	local targetGo = self.parent.bindingTarget

	if goutil.isNil(targetGo) then
		return
	end

	self._playerAdapter:Evaluate("mouth", time)
end

function M:OnSectionDisableInternal()
	self:_closeLoader()

	if self._playerAdapter and self._playerAdapter.HasMorpherPlayer then
		self._playerAdapter:StopMouth(true)
	end
end

function M:_closeLoader()
	if self._loader then
		self._loader:dispose()
	end

	self._loader = nil
end

function M:_loadClipFile(clipFilePath)
	self:_closeLoader()

	if string.nilorempty(clipFilePath) then
		return
	end

	if Astral.LuaResourceCache.Instance:ExistsResource(clipFilePath) then
		self._loader = StoryLoader.New()

		self._loader:addUrl(clipFilePath, self._loadComplete, self)
		self._loader:startLoad()
	elseif IsInEditorMode then
		if enableErrorLog then
			printError("口型动画资源丢失:", clipFilePath)
		end
	elseif enableWarnLog then
		printWarn("口型动画资源丢失:", clipFilePath)
	end
end

function M:_loadComplete(res)
	if not self._playerAdapter then
		return
	end

	local clipRes = res:GetMainAsset()

	if not clipRes then
		return
	end

	local timeRange = self:TimeRange()

	self._playerAdapter:PlayMouth(clipRes, timeRange.x, timeRange.y)
end

return M
