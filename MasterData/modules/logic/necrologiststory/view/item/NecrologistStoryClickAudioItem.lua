-- chunkname: @modules/logic/necrologiststory/view/item/NecrologistStoryClickAudioItem.lua

module("modules.logic.necrologiststory.view.item.NecrologistStoryClickAudioItem", package.seeall)

local NecrologistStoryClickAudioItem = class("NecrologistStoryClickAudioItem", NecrologistStoryClickPictureItem)

function NecrologistStoryClickAudioItem:onClickClick()
	if self:isDone() then
		return
	end

	self._isFinish = true

	self:refreshState()
	ViewMgr.instance:openView(ViewName.V3A4_RoleStoryAudioView, {
		audioId = self.audioId,
		audioTime = self.audioTime
	})
end

function NecrologistStoryClickAudioItem:onAddEvent()
	NecrologistStoryClickAudioItem.super.onAddEvent(self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
end

function NecrologistStoryClickAudioItem:onRemoveEvent()
	NecrologistStoryClickAudioItem.super.onRemoveEvent(self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
end

function NecrologistStoryClickAudioItem:onCloseViewFinish(viewName)
	if viewName ~= ViewName.V3A4_RoleStoryAudioView then
		return
	end

	self:onPlayFinish(true)
end

function NecrologistStoryClickAudioItem:onPlayStory()
	self._isFinish = false

	local storyConfig = self:getStoryConfig()

	self.txtContent.text = NecrologistStoryHelper.getDescByConfig(storyConfig)

	local storyParam = string.split(storyConfig.param, "#")

	self.audioId = tonumber(storyParam[1])
	self.audioTime = tonumber(storyParam[2])

	local picRes = storyParam[3]

	self.simageNormal:LoadImage(ResUrl.getNecrologistStoryPicBg(picRes), self.onSimageNormalLoaded, self)
	self.simageFinished:LoadImage(ResUrl.getNecrologistStoryPicBg(picRes), self.onSimageFinishedLoaded, self)
	self:refreshState()
end

return NecrologistStoryClickAudioItem
