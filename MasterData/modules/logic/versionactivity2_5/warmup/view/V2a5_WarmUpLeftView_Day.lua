-- chunkname: @modules/logic/versionactivity2_5/warmup/view/V2a5_WarmUpLeftView_Day.lua

module("modules.logic.versionactivity2_5.warmup.view.V2a5_WarmUpLeftView_Day", package.seeall)

local V2a5_WarmUpLeftView_Day = class("V2a5_WarmUpLeftView_Day", RougeSimpleItemBase)

function V2a5_WarmUpLeftView_Day:ctor(ctorParam)
	self:__onInit()
	V2a5_WarmUpLeftView_Day.super.ctor(self, ctorParam)
end

function V2a5_WarmUpLeftView_Day:_editableInitView()
	V2a5_WarmUpLeftView_Day.super._editableInitView(self)
end

function V2a5_WarmUpLeftView_Day:_internal_setEpisode(episodeId)
	self._episodeId = episodeId
end

function V2a5_WarmUpLeftView_Day:setActive(isActive)
	gohelper.setActive(self.viewGO, isActive)
end

function V2a5_WarmUpLeftView_Day:onDestroyView()
	V2a5_WarmUpLeftView_Day.super.onDestroyView(self)
	self:__onDispose()
end

return V2a5_WarmUpLeftView_Day
