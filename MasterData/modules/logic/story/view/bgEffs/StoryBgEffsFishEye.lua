-- chunkname: @modules/logic/story/view/bgEffs/StoryBgEffsFishEye.lua

module("modules.logic.story.view.bgEffs.StoryBgEffsFishEye", package.seeall)

local StoryBgEffsFishEye = class("StoryBgEffsFishEye", StoryBgEffsBase)

function StoryBgEffsFishEye:ctor()
	StoryBgEffsFishEye.super.ctor(self)
end

function StoryBgEffsFishEye:init(bgCo)
	StoryBgEffsFishEye.super.init(self, bgCo)

	self._matPath = "ui/materials/dynamic/story_fisheye.mat"

	table.insert(self._resList, self._matPath)
end

function StoryBgEffsFishEye:onLoadFinished()
	StoryBgEffsFishEye.super.onLoadFinished(self)

	local mat = self:_getMat()

	if not mat then
		return
	end

	local imagebg = StoryViewMgr.instance:getStoryBgImage()
	local imagebgtop = StoryViewMgr.instance:getStoryBgImageTop()

	if imagebg then
		imagebg.material = mat
	end

	if imagebgtop then
		imagebgtop.material = mat
	end
end

function StoryBgEffsFishEye:reset(bgCo)
	StoryBgEffsFishEye.super.reset(self, bgCo)
end

function StoryBgEffsFishEye:_getMat()
	local item = self._loader:getAssetItem(self._matPath)

	return item and item:GetResource(self._matPath) or nil
end

function StoryBgEffsFishEye:destroy()
	StoryBgEffsFishEye.super.destroy(self)
end

return StoryBgEffsFishEye
