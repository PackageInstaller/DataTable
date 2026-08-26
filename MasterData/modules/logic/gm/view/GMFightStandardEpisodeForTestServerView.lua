-- chunkname: @modules/logic/gm/view/GMFightStandardEpisodeForTestServerView.lua

module("modules.logic.gm.view.GMFightStandardEpisodeForTestServerView", package.seeall)

local GMFightStandardEpisodeForTestServerView = class("GMFightStandardEpisodeForTestServerView", FightBaseView)

function GMFightStandardEpisodeForTestServerView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self.hideEnterBtn = gohelper.findChildButtonWithAudio(self.viewGO, "hideEnterBtn")
	self.chapterContent = gohelper.findChild(self.viewGO, "leftviewport/content")
	self.chapterItem = gohelper.findChild(self.viewGO, "leftviewport/item")
	self.episodeContent = gohelper.findChild(self.viewGO, "rightviewport/content")
	self.episodeItem = gohelper.findChild(self.viewGO, "rightviewport/item")
	self.chapterItemList = self:com_registViewItemList(self.chapterItem, GMFightStandardEpisodeForTestServerViewChapterItem, self.chapterContent)
	self.episodeItemList = self:com_registViewItemList(self.episodeItem, GMFightStandardEpisodeForTestServerViewEpisodeItem, self.episodeContent)
	self.episodeDic = {}

	for k, config in pairs(lua_episode.configDict) do
		local chapterConfig = lua_chapter.configDict[config.chapterId]

		if chapterConfig.type == 97 then
			self.episodeDic[config.chapterId] = self.episodeDic[config.chapterId] or {}

			table.insert(self.episodeDic[config.chapterId], config)
		end
	end
end

function GMFightStandardEpisodeForTestServerView:addEvents()
	self:com_registClick(self._btnClose, self.closeThis)
	self:com_registClick(self.hideEnterBtn, self.hideEnter)
end

function GMFightStandardEpisodeForTestServerView:hideEnter()
	self:closeThis()

	GMFightStandardEpisodeForTestServerView.hideEnterBtn = true

	FightController.instance:dispatchEvent(FightEvent.HideKolStdStageEnterBtn)
end

function GMFightStandardEpisodeForTestServerView:removeEvents()
	return
end

function GMFightStandardEpisodeForTestServerView:onClickChapterItem(config)
	if not self.episodeDic[config.id] then
		table.sort(self.episodeDic[config.id], function(a, b)
			return a.id < b.id
		end)
		self.episodeItemList:setDataList(self.episodeDic[config.id])
	end
end

function GMFightStandardEpisodeForTestServerView:onOpen()
	local chapterList = {}

	for k, v in pairs(lua_chapter.configDict) do
		if v.type == 97 then
			table.insert(chapterList, v)
		end
	end

	table.sort(chapterList, function(a, b)
		return a.id < b.id
	end)
	self.chapterItemList:setDataList(chapterList)
end

function GMFightStandardEpisodeForTestServerView:onClose()
	return
end

return GMFightStandardEpisodeForTestServerView
