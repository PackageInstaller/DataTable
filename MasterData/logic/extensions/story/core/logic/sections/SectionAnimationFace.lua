-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionAnimationFace.lua

module("logic.extensions.story.core.logic.sections.SectionAnimationFace", package.seeall)

local M = class("SectionAnimationFace", StorySectionBase)
local kMainColorID = UnityEngine.Shader.PropertyToID("_BaseColor")
local rescache = Astral.LuaResourceCache.Instance

function M:_OnInitCtor()
	self._playerAdapter = nil
	self._loader = nil
	self._clipUrl = nil
	self._blushGo = false
	self._blushBindNode = false
	self._lastTime = 0
end

function M:OnSectionEnableInternal()
	local targetGo = self.parent.bindingTarget

	if goutil.isNil(targetGo) then
		return
	end

	local inst = targetGo:GetComponent(typeof(StoryEngine.StoryGameObjectInstProxy))
	local storyCache = StoryBoneCache.Get(inst.target)

	self._blushBindNode = storyCache and storyCache.blushGo or nil
	self._playerAdapter = MorpherPlayerAdapter.Get(inst.target)

	if not self._playerAdapter then
		return
	end

	self._blushUrl = StoryLogicResPathUtils.GetBlushPath()

	local characterName = inst.target.name

	characterName = string.gsub(characterName, "-show", "")

	if string.nilorempty(characterName) then
		return
	end

	self._showBlush = self.config:GetArgValueBoolean(StoryArgKeyConst.ShowBlush)

	self:PlayFaceAnim(characterName)
	self:_loadClipFile()
end

function M:PlayFaceAnim(characterName)
	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if not _storyEntry then
		return
	end

	local eyeClipName = self.config:GetArgValue(StoryArgKeyConst.Eye)
	local eyeBrowClipName = self.config:GetArgValue(StoryArgKeyConst.EyeBrow)
	local mouthClipName = self.config:GetArgValue(StoryArgKeyConst.Mouth)
	local eyeClipFilePath = StoryLogicResPathUtils.GetCharacterFaceAnimPath(characterName, eyeClipName)
	local eyeBrowClipFilePath = StoryLogicResPathUtils.GetCharacterFaceAnimPath(characterName, eyeBrowClipName)
	local mouthClipFilePath = StoryLogicResPathUtils.GetCharacterFaceAnimPath(characterName, mouthClipName)
	local eyeclip, eyeBrowClip, mouthClip

	if not string.nilorempty(eyeClipFilePath) and rescache:ExistsResource(eyeClipFilePath) then
		eyeclip = _storyEntry:getStageRes(eyeClipFilePath)
	end

	if not string.nilorempty(eyeBrowClipFilePath) and rescache:ExistsResource(eyeBrowClipFilePath) then
		eyeBrowClip = _storyEntry:getStageRes(eyeBrowClipFilePath)
	end

	if not string.nilorempty(mouthClipFilePath) and rescache:ExistsResource(mouthClipFilePath) then
		mouthClip = _storyEntry:getStageRes(mouthClipFilePath)
	end

	local timeRange = self:TimeRange()
	local isHoldFace = self.config:GetArgValueBoolean(StoryArgKeyConst.IsHoldFace)
	local endWeight = 0

	if isHoldFace then
		endWeight = 1
	end

	self._playerAdapter:PlayFace(eyeclip, eyeBrowClip, mouthClip, timeRange.x, timeRange.y, 0.2, 0.2, 0, endWeight)

	local eyeWeight = self.config:GetArgValueNumber(StoryArgKeyConst.EyeFloat)
	local eyeBrowWeight = self.config:GetArgValueNumber(StoryArgKeyConst.EyeBrowFloat)
	local mouthWeight = self.config:GetArgValueNumber(StoryArgKeyConst.MouthFloat)

	self._playerAdapter:SetLayerWeight("eye", eyeWeight)
	self._playerAdapter:SetLayerWeight("eyebrow", eyeBrowWeight)
	self._playerAdapter:SetLayerWeight("facemouth", mouthWeight)
end

function M:OnSectionDisableInternal()
	if self._tweenDelay then
		self._tweenDelay:Kill(false)

		self._tweenDelay = nil
	end

	self:_doBlushAlpha(false)

	local isHoldFace = self.config:GetArgValueBoolean(StoryArgKeyConst.IsHoldFace)

	if not isHoldFace and self._playerAdapter and self._playerAdapter.HasMorpherPlayer then
		self._playerAdapter:StopFace(true)
	end

	self._tweenDelay = DoTweenUtil.DelayedCall(0.5, function()
		if self._blushGo and not goutil.isNil(self._blushGo) then
			goutil.destroy(self._blushGo)

			self._blushGo = false
		end
	end)

	self:_closeLoader()
end

function M:OnStoryEvaluateInternal(time)
	local targetGo = self.parent.bindingTarget

	if goutil.isNil(targetGo) then
		return
	end

	self._playerAdapter:Evaluate("eye", time)
	self._playerAdapter:Evaluate("eyebrow", time)
	self._playerAdapter:Evaluate("facemouth", time)
end

function M:_closeLoader()
	if self._loader then
		self._loader:dispose()
	end

	self._loader = nil
end

function M:_loadClipFile()
	self:_closeLoader()

	self._loader = StoryLoader.New()

	self._loader:addUrl(self._blushUrl)
	self._loader:startLoad(self._loadComplete, self)
end

function M:_loadComplete(res)
	if not self._playerAdapter then
		return
	end

	local blushRes = self._loader:GetRes(self._blushUrl)
	local blushPrefab = blushRes:GetMainAsset()

	if blushPrefab and not goutil.isNil(self._blushBindNode) then
		self._blushGo = goutil.cloneAndSetParent(blushPrefab, self._blushBindNode.transform, blushPrefab.name)
		self._blushMaterialSetter = MaterialSetter.Get(self._blushGo)

		self._blushMaterialSetter:SetGameObject(self._blushGo)

		if self._showBlush then
			self:_doBlushAlpha(self._showBlush)
		end

		goutil.setActive(self._blushGo, self._showBlush)
	end
end

function M:_doBlushAlpha(showBlush)
	if self._blushMaterialSetter then
		if showBlush then
			self._blushMaterialSetter:SetColor(kMainColorID, "#FFFFFF00")
		end

		self._blushMaterialSetter:DOAlpha(kMainColorID, showBlush and 1 or 0, 0.5)
	end
end

return M
