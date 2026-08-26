-- chunkname: @modules/logic/versionactivity2_5/challenge/view/result/Act183SettlementView.lua

module("modules.logic.versionactivity2_5.challenge.view.result.Act183SettlementView", package.seeall)

local Act183SettlementView = class("Act183SettlementView", BaseView)

function Act183SettlementView:onInitView()
	self._gonormalbg = gohelper.findChild(self.viewGO, "root/bg")
	self._gohardbg = gohelper.findChild(self.viewGO, "root/hardbg")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._scrollbadge = gohelper.findChildScrollRect(self.viewGO, "root/left/#scroll_badge")
	self._goepisodeitem = gohelper.findChild(self.viewGO, "root/left/#scroll_badge/Viewport/Content/#go_episodeitem")
	self._simageplayericon = gohelper.findChildSingleImage(self.viewGO, "root/left/player/icon/#simage_playericon")
	self._txtname = gohelper.findChildText(self.viewGO, "root/left/player/#txt_name")
	self._txtdate = gohelper.findChildText(self.viewGO, "root/left/player/#txt_date")
	self._txtbossbadge = gohelper.findChildText(self.viewGO, "root/right/#txt_bossbadge")
	self._gobossheros = gohelper.findChild(self.viewGO, "root/right/#go_bossheros")
	self._goheroitem = gohelper.findChild(self.viewGO, "root/#go_heroitem")
	self._gobuffs = gohelper.findChild(self.viewGO, "root/right/buffs/#go_buffs")
	self._gobuffitem = gohelper.findChild(self.viewGO, "root/right/buffs/#go_buffs/#go_buffitem")
	self._simageboss = gohelper.findChildSingleImage(self.viewGO, "root/right/#simage_boss")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183SettlementView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Act183SettlementView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Act183SettlementView:_btncloseOnClick()
	self:closeThis()
end

function Act183SettlementView:_editableInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "root/left/#scroll_badge/Viewport/Content")
	self._heroIconTab = self:getUserDataTb_()
end

function Act183SettlementView:onUpdateParam()
	return
end

function Act183SettlementView:onOpen()
	self._activityId = self.viewParam and self.viewParam.activityId
	self._groupRecordMo = self.viewParam and self.viewParam.groupRecordMo

	self:refresh()
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_OpenSettlementView)
end

function Act183SettlementView:refresh()
	self:refreshAllSubEpisodeItems()
	self:refreshBossEpisodeItem()
	self:refreshPlayerInfo()
	self:refreshOtherInfo()
end

function Act183SettlementView:refreshAllSubEpisodeItems()
	local subEpisodes = self._groupRecordMo:getEpusideListByTypeAndPassOrder(Act183Enum.EpisodeType.Sub)

	for index, episodeMo in ipairs(subEpisodes) do
		local episodeItemGo = gohelper.cloneInPlace(self._goepisodeitem, "episode_" .. index)
		local episodeItem = MonoHelper.addNoUpdateLuaComOnceToGo(episodeItemGo, Act183SettlementSubEpisodeItem)

		episodeItem:setHeroTemplate(self._goheroitem)
		episodeItem:onUpdateMO(self._groupRecordMo, episodeMo)
	end
end

function Act183SettlementView:refreshBossEpisodeItem()
	local bossEpisodeRecordMos = self._groupRecordMo:getEpisodeListByType(Act183Enum.EpisodeType.Boss)
	local bossEpisodeRecordMo = bossEpisodeRecordMos and bossEpisodeRecordMos[1]
	local episodeItem = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, Act183SettlementBossEpisodeItem)

	episodeItem:setHeroTemplate(self._goheroitem)
	episodeItem:onUpdateMO(self._groupRecordMo, bossEpisodeRecordMo)
end

function Act183SettlementView:refreshPlayerInfo()
	self._txtname.text = self._groupRecordMo:getUserName()
	self._portraitId = self._groupRecordMo:getPortrait()
	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simageplayericon)

	self._liveHeadIcon:setLiveHead(self._portraitId)

	self._txtdate.text = TimeUtil.timestampToString(self._groupRecordMo:getFinishedTime() / 1000)
end

function Act183SettlementView:refreshOtherInfo()
	local groupType = self._groupRecordMo:getGroupType()

	gohelper.setActive(self._gohardbg, groupType == Act183Enum.GroupType.HardMain)
	gohelper.setActive(self._gonormalbg, groupType ~= Act183Enum.GroupType.HardMain)
end

function Act183SettlementView:releaseAllSingleImage()
	if self._heroIconTab then
		for simagecomp, _ in pairs(self._heroIconTab) do
			simagecomp:UnLoadImage()
		end
	end
end

function Act183SettlementView:onClose()
	self:releaseAllSingleImage()
	self._simageplayericon:UnLoadImage()
end

function Act183SettlementView:onDestroyView()
	return
end

return Act183SettlementView
