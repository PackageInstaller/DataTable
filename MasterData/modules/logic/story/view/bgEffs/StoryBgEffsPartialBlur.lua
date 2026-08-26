-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsPartialBlur.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsPartialBlur", package.seeall)

local StoryBgEffsPartialBlur = class("StoryBgEffsPartialBlur", StoryBgEffsBase)

function StoryBgEffsPartialBlur:ctor()
	StoryBgEffsPartialBlur.super.ctor(self)
end

function StoryBgEffsPartialBlur:init(bgCo)
	StoryBgEffsPartialBlur.super.init(self, bgCo)

	self._blurPrefabPath = "effects/prefabs/story/v3a7_mle_localblur.prefab"

	table.insert(self._resList, self._blurPrefabPath)

	self._effLoaded = false
end

function StoryBgEffsPartialBlur:start(callback, callbackObj)
	StoryBgEffsPartialBlur.super.start(self)

	self._captureGo = PostProcessingMgr.instance:getCaptureView()
	self._capture = self._captureGo:GetComponent(typeof(UrpCustom.UIGaussianEffect))

	self:loadRes()
end

function StoryBgEffsPartialBlur:onLoadFinished()
	self._effLoaded = true

	StoryBgEffsPartialBlur.super.onLoadFinished(self)
	StoryTool.enablePostProcess(true)

	local prefabAssetItem = self._loader:getAssetItem(self._blurPrefabPath)
	local frontGo = StoryViewMgr.instance:getStoryFrontView()

	self._blurGo = gohelper.clone(prefabAssetItem:GetResource(), frontGo)

	if self._capture then
		self._capture.enabled = true
		self._capture.blurWeight = 1
		self._capture.blurFactor = 1
		self._capture.keepToScreen = true
	end
end

function StoryBgEffsPartialBlur:reset(bgCo)
	StoryBgEffsPartialBlur.super.reset(self, bgCo)
	StoryTool.enablePostProcess(true)

	if not self._effLoaded then
		return
	end
end

function StoryBgEffsPartialBlur:destroy()
	StoryBgEffsPartialBlur.super.destroy(self)

	if self._capture then
		self._capture.enabled = false
		self._capture.blurWeight = 1
		self._capture.blurFactor = 1
		self._capture.keepToScreen = false
	end
end

return StoryBgEffsPartialBlur
