-- chunkname: @modules/logic/versionactivity2_5/challenge/view/result/Act183ReportListItem.lua

module("modules.logic.versionactivity2_5.challenge.view.result.Act183ReportListItem", package.seeall)

local Act183ReportListItem = class("Act183ReportListItem", ListScrollCellExtend)

function Act183ReportListItem:onInitView()
	self._gotime = gohelper.findChild(self.viewGO, "#go_time")
	self._txttime = gohelper.findChildText(self.viewGO, "#go_time/#txt_time")
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._gohard = gohelper.findChild(self.viewGO, "#go_hard")
	self._goepisodes = gohelper.findChild(self.viewGO, "#go_episodes")
	self._goepisodeitem = gohelper.findChild(self.viewGO, "#go_episodes/#go_episodeitem")
	self._goherogroup = gohelper.findChild(self.viewGO, "#go_herogroup")
	self._goitem1 = gohelper.findChild(self.viewGO, "#go_herogroup/#go_item1")
	self._goitem2 = gohelper.findChild(self.viewGO, "#go_herogroup/#go_item2")
	self._goitem3 = gohelper.findChild(self.viewGO, "#go_herogroup/#go_item3")
	self._goitem4 = gohelper.findChild(self.viewGO, "#go_herogroup/#go_item4")
	self._goitem5 = gohelper.findChild(self.viewGO, "#go_herogroup/#go_item5")
	self._goheroitem = gohelper.findChild(self.viewGO, "#go_herogroup/#go_heroitem")
	self._imagebossicon = gohelper.findChildImage(self.viewGO, "#go_boss/#image_bossicon")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_detail")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183ReportListItem:addEvents()
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
end

function Act183ReportListItem:removeEvents()
	self._btndetail:RemoveClickListener()
end

function Act183ReportListItem:_btndetailOnClick()
	local activityId = Act183ReportListModel.instance:getActivityId()
	local params = {
		activityId = activityId,
		groupRecordMo = self._mo
	}

	Act183Controller.instance:openAct183SettlementView(params)
end

function Act183ReportListItem:_editableInitView()
	self._heroItemTab = self:getUserDataTb_()
end

function Act183ReportListItem:_editableAddEvents()
	return
end

function Act183ReportListItem:_editableRemoveEvents()
	return
end

function Act183ReportListItem:onUpdateMO(mo)
	self._mo = mo
	self._txttime.text = TimeUtil.timestampToString(self._mo:getFinishedTime() / 1000)
	self._type = self._mo:getGroupType()

	gohelper.setActive(self._gonormal, self._type == Act183Enum.GroupType.NormalMain)
	gohelper.setActive(self._gohard, self._type == Act183Enum.GroupType.HardMain)

	local subEpisodes = self._mo:getEpusideListByTypeAndPassOrder(Act183Enum.EpisodeType.Sub)

	gohelper.CreateObjList(self, self.refreshSingleSubEpisodeItem, subEpisodes or {}, self._goepisodes, self._goepisodeitem)

	local bossEpisode = self._mo:getBossEpisode()
	local bossEpisodeId = bossEpisode and bossEpisode:getEpisodeId()

	Act183Helper.setEpisodeReportIcon(bossEpisodeId, self._imagebossicon)
	self:refreshBossEpisodeHeros()
end

function Act183ReportListItem:refreshSingleSubEpisodeItem(obj, episodeRecordMo, index)
	local episodeId = episodeRecordMo:getEpisodeId()
	local passOrder = episodeRecordMo:getPassOrder()
	local imageindex = gohelper.findChildImage(obj, "image_index")
	local imageicon = gohelper.findChildImage(obj, "image_icon")

	UISpriteSetMgr.instance:setChallengeSprite(imageindex, "v2a5_challenge_result_level_" .. passOrder)
	Act183Helper.setEpisodeReportIcon(episodeId, imageicon)
end

function Act183ReportListItem:refreshBossEpisodeHeros()
	local bossEpisodes = self._mo:getEpisodeListByType(Act183Enum.EpisodeType.Boss)
	local bossEpisode = bossEpisodes and bossEpisodes[1]

	if not bossEpisode then
		return
	end

	local heroMos = bossEpisode:getHeroMos()

	for i = 1, Act183Enum.BossEpisodeMaxHeroNum do
		local heroItem = self:_getOrCreateHeroItem(i)
		local heroMo = heroMos and heroMos[i]
		local hasHero = heroMo ~= nil

		gohelper.setActive(heroItem.viewGO, true)
		gohelper.setActive(heroItem.gohas, hasHero)
		gohelper.setActive(heroItem.goempty, not hasHero)

		if hasHero then
			local iconUrl = heroMo:getHeroIconUrl()

			heroItem.simageheroicon:LoadImage(iconUrl)
		end
	end
end

function Act183ReportListItem:_getOrCreateHeroItem(index)
	local heroItem = self._heroItemTab[index]

	if not heroItem then
		heroItem = self:getUserDataTb_()

		local goparent = self["_goitem" .. index]

		if gohelper.isNil(goparent) then
			logError("缺少挂点 : " .. index)
		end

		heroItem.viewGO = gohelper.clone(self._goheroitem, goparent, "hero")
		heroItem.gohas = gohelper.findChild(heroItem.viewGO, "go_has")
		heroItem.goempty = gohelper.findChild(heroItem.viewGO, "go_empty")
		heroItem.simageheroicon = gohelper.findChildSingleImage(heroItem.viewGO, "go_has/bg/simage_heroicon")
		self._heroItemTab[index] = heroItem
	end

	return heroItem
end

function Act183ReportListItem:releaseAllHeroItems()
	if self._heroItemTab then
		for _, heroItem in pairs(self._heroItemTab) do
			heroItem.simageheroicon:UnLoadImage()
		end
	end
end

function Act183ReportListItem:onSelect(isSelect)
	return
end

function Act183ReportListItem:onDestroyView()
	self:releaseAllHeroItems()
end

return Act183ReportListItem
