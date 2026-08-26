-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsUpFlow.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsUpFlow", package.seeall)

local StoryBgEffsUpFlow = class("StoryBgEffsUpFlow", StoryBgEffsBase)

function StoryBgEffsUpFlow:ctor()
	StoryBgEffsUpFlow.super.ctor(self)
end

function StoryBgEffsUpFlow:init(bgCo)
	StoryBgEffsUpFlow.super.init(self, bgCo)

	self._matPath = "ui/materials/dynamic/storybg_distort.mat"

	table.insert(self._resList, self._matPath)

	self._bgImgGo = StoryViewMgr.instance:getStoryFrontBgImgGo()
	self._bgFrontImg = self._bgImgGo:GetComponent(gohelper.Type_Image)
	self._effLoaded = false
	self._cfg = bgCo
end

function StoryBgEffsUpFlow:start(callback, callbackObj)
	StoryBgEffsUpFlow.super.start(self)

	self._finishedCallback = callback
	self._finishedCallbackObj = callbackObj

	self:loadRes()
end

function StoryBgEffsUpFlow:onLoadFinished()
	StoryBgEffsUpFlow.super.onLoadFinished(self)

	self._effLoaded = true
	self._bgFrontImg.material = self._loader:getAssetItem(self._matPath):GetResource()
end

function StoryBgEffsUpFlow:reset(bgCo)
	StoryBgEffsUpFlow.super.reset(self, bgCo)

	if not self._effLoaded then
		return
	end

	self._bgFrontImg.material = self._loader:getAssetItem(self._matPath):GetResource()
end

function StoryBgEffsUpFlow:destroy()
	if self._bgFrontImg then
		self._bgFrontImg.material = nil
		self._bgFrontImg = nil
	end

	if self._effectGo then
		gohelper.destroy(self._effectGo)

		self._effectGo = nil
	end

	StoryBgEffsUpFlow.super.destroy(self)

	self._finishedCallback = nil
	self._finishedCallbackObj = nil
end

return StoryBgEffsUpFlow
