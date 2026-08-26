-- chunkname: @modules/logic/versionactivity2_2/warmup/view/V2a2_WarmUpLeftView.lua

module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView", package.seeall)

local V2a2_WarmUpLeftView = class("V2a2_WarmUpLeftView", BaseView)

function V2a2_WarmUpLeftView:onInitView()
	self._middleGo = gohelper.findChild(self.viewGO, "Middle")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a2_WarmUpLeftView:addEvents()
	return
end

function V2a2_WarmUpLeftView:removeEvents()
	return
end

setNeedLoadModule("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day1", "V2a2_WarmUpLeftView_Day1")
setNeedLoadModule("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day2", "V2a2_WarmUpLeftView_Day2")
setNeedLoadModule("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day3", "V2a2_WarmUpLeftView_Day3")
setNeedLoadModule("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day4", "V2a2_WarmUpLeftView_Day4")
setNeedLoadModule("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day5", "V2a2_WarmUpLeftView_Day5")

function V2a2_WarmUpLeftView:_editableInitView()
	self._dayItemList = {}

	for i = 1, 5 do
		local go = gohelper.findChild(self._middleGo, "day" .. i)
		local clsDefine = _G["V2a2_WarmUpLeftView_Day" .. i]
		local item = clsDefine.New({
			parent = self,
			baseViewContainer = self.viewContainer
		})

		item:setIndex(i)
		item:_internal_setEpisode(i)
		item:init(go)

		self._dayItemList[i] = item
	end
end

function V2a2_WarmUpLeftView:onOpen()
	return
end

function V2a2_WarmUpLeftView:onClose()
	return
end

function V2a2_WarmUpLeftView:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_dayItemList")
end

function V2a2_WarmUpLeftView:onDataUpdateFirst()
	self._lastEpisodeId = nil

	if isDebugBuild then
		assert(self.viewContainer:getEpisodeCount() <= 5, "invalid config json_activity125 actId: " .. self.viewContainer:actId())
	end

	self:_getItem():onDataUpdateFirst()
end

function V2a2_WarmUpLeftView:onDataUpdate()
	self:setActiveByEpisode(self:_episodeId())
	self:_getItem():onDataUpdate()
end

function V2a2_WarmUpLeftView:onSwitchEpisode()
	self:setActiveByEpisode(self:_episodeId())
	self:_getItem():onSwitchEpisode()
end

function V2a2_WarmUpLeftView:setActiveByEpisode(episodeId)
	if self._lastEpisodeId then
		local item = self:_getItem(self._lastEpisodeId)

		item:setActive(false)
	end

	self._lastEpisodeId = episodeId

	self:_getItem(episodeId):setActive(true)
end

function V2a2_WarmUpLeftView:_episodeId()
	return self.viewContainer:getCurSelectedEpisode()
end

function V2a2_WarmUpLeftView:episode2Index(episodeId)
	return self.viewContainer:episode2Index(episodeId or self:_episodeId())
end

function V2a2_WarmUpLeftView:_getItem(episodeId)
	local index = self:episode2Index(episodeId)

	return self._dayItemList[index]
end

return V2a2_WarmUpLeftView
