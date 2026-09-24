-- chunkname: @modules/logic/matchgame/outside/map/MatchGameMapBossItem.lua

module("modules.logic.matchgame.outside.map.MatchGameMapBossItem", package.seeall)

local MatchGameMapBossItem = class("MatchGameMapBossItem", SimpleListItem)

function MatchGameMapBossItem:onInit(viewGO)
	self._goOpen = gohelper.findChild(self.viewGO, "#go_open")
	self._simageMapArea = gohelper.findChildSingleImage(self.viewGO, "#go_open/#simage_maparea")
	self._imageMapArea = gohelper.findChildImage(self.viewGO, "#go_open/#simage_maparea")
	self._goBest = gohelper.findChild(self.viewGO, "#go_open/#go_best")
	self._txtMaxScore = gohelper.findChildText(self.viewGO, "#go_open/#go_best/#txt_best")
	self._goLock = gohelper.findChild(self.viewGO, "#go_lock")
	self._txtTime = gohelper.findChildText(self.viewGO, "#go_lock/#txt_time")
	self._goBest2 = gohelper.findChild(self.viewGO, "#go_lock/#go_best")
	self._txtMaxScore2 = gohelper.findChildText(self.viewGO, "#go_lock/#go_best/#txt_best")
end

function MatchGameMapBossItem:onAddListeners()
	return
end

function MatchGameMapBossItem:onRemoveListeners()
	return
end

function MatchGameMapBossItem:_onClickItem()
	if self._isCurrent then
		return
	end

	local isUnlock = MatchGameLevelModel.instance:isEpisodeUnlock(self._episodeId)

	if not isUnlock then
		if self._episodeMo then
			if not self._episodeMo.nextRoundTime then
				local nextRoundTime = 0

				if nextRoundTime > 0 then
					local remainTime = TimeUtil.SecondToActivityTimeFormat(nextRoundTime / 1000 - ServerTime.now())

					GameFacade.showToast(ToastEnum.MatchGameChallengeEpisodeTime, remainTime)
				else
					GameFacade.showToastString(luaLang("matchgamebossitem_end"))
				end

				return
			end
		end
	end

	MatchGameLevelModel.instance:switchEpisode(self._episodeId)
end

function MatchGameMapBossItem:onItemShow(co)
	self._config = co
	self._episodeId = co.id
	self._episodeMo = MatchGameModel.instance:getEpisodeInfoById(self._episodeId)

	self:refreshUI()
	self:updatePosition()
end

function MatchGameMapBossItem:updatePosition()
	local goPos = gohelper.findChild(self.viewContainer.viewGO, "#go_mapcontent/pos" .. self.itemIndex)

	if gohelper.isNil(goPos) then
		logError(string.format("三消挑战模式关卡挂点不存在 index = %s", self.itemIndex))

		return
	end

	local posX, posY = recthelper.getAnchor(goPos.transform)

	recthelper.setAnchor(self.transform, posX, posY)
end

function MatchGameMapBossItem:refreshUI()
	local bgName = string.format("matchgame_map_bossarea%02d", self.itemIndex)

	self._simageMapArea:LoadImage(ResUrl.getMatchGameSingleBg(bgName), self._setNativeSize, self)

	self._isUnlock = MatchGameLevelModel.instance:isEpisodeUnlock(self._episodeId)

	gohelper.setActive(self._goLock, not self._isUnlock)
	gohelper.setActive(self._goOpen, self._isUnlock)

	if self._episodeMo then
		if not self._episodeMo.maxScore then
			local maxScore = 0
			local showMaxScore = maxScore > 0

			gohelper.setActive(self._goBest, showMaxScore)
			gohelper.setActive(self._goBest2, showMaxScore)

			if showMaxScore then
				local maxScoreStr = BossRushConfig.instance:getScoreStr(maxScore)

				maxScoreStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("matchgamechallengemapview_maxscore"), maxScoreStr)
				self._txtMaxScore.text = maxScoreStr
				self._txtMaxScore2.text = maxScoreStr
			end

			self:_refreshRemainTime()
			TaskDispatcher.cancelTask(self._refreshRemainTime, self)

			if self._episodeMo then
				if not self._episodeMo.nextRoundTime then
					local nextRoundTime = 0

					if nextRoundTime > 0 then
						TaskDispatcher.runRepeat(self._refreshRemainTime, self, 30)
					end
				end
			end
		end
	end
end

function MatchGameMapBossItem:_setNativeSize()
	self._imageMapArea:SetNativeSize()
end

function MatchGameMapBossItem:_refreshRemainTime()
	local nextRoundTime = self._episodeMo.nextRoundTime

	if nextRoundTime < 0 then
		self._txtTime.text = luaLang("matchgamebossitem_end")
	else
		local leftSecond = nextRoundTime / 1000 - ServerTime.now()

		self._txtTime.text = TimeUtil.SecondToActivityTimeFormat(leftSecond)
	end
end

function MatchGameMapBossItem:onDestroy()
	self._simageMapArea:UnLoadImage()
	TaskDispatcher.cancelTask(self._refreshRemainTime, self)
end

return MatchGameMapBossItem
