-- chunkname: @modules/logic/matchgame/outside/map/MatchGameChallengeMapView.lua

module("modules.logic.matchgame.outside.map.MatchGameChallengeMapView", package.seeall)

local MatchGameChallengeMapView = class("MatchGameChallengeMapView", BaseView)

function MatchGameChallengeMapView:onInitView()
	self._simageBg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._txtFloor = gohelper.findChildText(self.viewGO, "#go_title/#txt_Floor")
	self._txtMapName = gohelper.findChildText(self.viewGO, "#go_title/#txt_MapName")
	self._btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reward")
	self._goRewardRedDot = gohelper.findChild(self.viewGO, "#btn_reward/#go_rewardredpoint")
	self._goMapContent = gohelper.findChild(self.viewGO, "#go_mapcontent")
	self._goBossItem = gohelper.findChild(self.viewGO, "#go_mapcontent/#go_levelitem")
	self._goScoreLayout = gohelper.findChild(self.viewGO, "#go_leveldetail/layout")
	self._txtScore = gohelper.findChildText(self.viewGO, "#go_leveldetail/layout/#txt_score")
	self._txtBossName = gohelper.findChildText(self.viewGO, "#go_leveldetail/bossnamebg/#txt_bossname")
	self._goRewardIcon = gohelper.findChild(self.viewGO, "#go_leveldetail/#go_reward/#go_rewarditem/#go_icon")
	self._goHasGet = gohelper.findChild(self.viewGO, "#go_leveldetail/#go_reward/#go_rewarditem/#go_hasget")
	self._txtRewardName = gohelper.findChildText(self.viewGO, "#go_leveldetail/#go_reward/#txt_reward")
	self._txtRewardDesc = gohelper.findChildText(self.viewGO, "#go_leveldetail/#go_reward/#txt_desc")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_enter")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameChallengeMapView:addEvents()
	self._btnReward:AddClickListener(self._btnRewardOnClick, self)
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnUpdateEpisodeInfo, self._onUpdateEpisodeInfo, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnClickSelectMap, self._onClickSelectMap, self)
end

function MatchGameChallengeMapView:removeEvents()
	self._btnReward:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
end

function MatchGameChallengeMapView:_btnRewardOnClick()
	MatchGameController.instance:openRewardView(MatchGameEnum.RewardType.Challenge)
end

function MatchGameChallengeMapView:_btnEnterOnClick()
	local isOpen = MatchGameModel.instance:checkEpisodeOpen(self._curEpisodeId, true)

	if not isOpen then
		return
	end

	MatchGameController.instance:openHeroGroupView(self._curEpisodeId)
end

function MatchGameChallengeMapView:_editableInitView()
	self._actId = MatchGameModel.instance:getCurActId()
	self._challengeMo = MatchGameModel.instance.challengeMo
	self._animReward = gohelper.onceAddComponent(self._btnReward.gameObject, gohelper.Type_Animation)

	MatchGameLevelModel.instance:initMapType(MatchGameEnum.LevelType.Challenge)
	RedDotController.instance:addRedDot(self._goRewardRedDot, RedDotEnum.DotNode.MatchGameChallengeReward)
end

function MatchGameChallengeMapView:onOpen()
	self:refreshUI()
end

function MatchGameChallengeMapView:refreshUI()
	self:refreshChapterBg()
	self:refreshRewardEntry()
	self:refreshBossItemList()
	self:tickUpdateBossInfo()
end

function MatchGameChallengeMapView:refreshChapterBg()
	local curChapterId = MatchGameLevelModel.instance:getCurChapterId()
	local curChapterCo = lua_activity244_chapter.configDict[curChapterId]
	local bgName = curChapterCo and curChapterCo.chapterImage

	self._simageBg:LoadImage(ResUrl.getMatchGameSingleBg(bgName))
end

function MatchGameChallengeMapView:refreshRewardEntry()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.MatchGameChallengeReward) then
		self._animReward:Play("btn_tipreward_loop")
	else
		self._animReward:Play("btn_tipreward")
	end
end

function MatchGameChallengeMapView:refreshBossItemList()
	if not self._mapListComp then
		local listParam = SimpleListParam.New()

		listParam.cellClass = MatchGameMapBossItem

		local scrollParam = {
			listParam = listParam,
			viewContainer = self.viewContainer
		}

		self._mapListComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goMapContent, SimpleListComp, scrollParam)

		self._mapListComp:setRes(self._goBossItem)
		self._mapListComp:setOnSelectChange(self._onSelectBossItem, self)
		self._mapListComp:onCreate()
	end

	local episodeList = MatchGameLevelModel.instance:getCurEpisodeCos()
	local selectIndex = self:_calcSelectIndex(episodeList)

	self._mapListComp:setData(episodeList)
	self._mapListComp:setSelect(selectIndex)
end

function MatchGameChallengeMapView:_calcSelectIndex(episodeCoList)
	if episodeCoList then
		for i, episodeCo in ipairs(episodeCoList) do
			if self._challengeMo:isEpisodeOpen(episodeCo.id) then
				return i
			end
		end
	end

	return 1
end

function MatchGameChallengeMapView:_onSelectBossItem(bossItem, selectIndex)
	self._curEpisodeCo = bossItem.data
	self._curEpisodeId = self._curEpisodeCo and self._curEpisodeCo.id

	MatchGameLevelModel.instance:setCurEpisode(self._curEpisodeId)
	self:refreshBossDetail()
end

function MatchGameChallengeMapView:refreshBossDetail()
	local chapterCo = lua_activity244_chapter.configDict[self._curEpisodeCo.chapterId]

	self._txtFloor.text = chapterCo and chapterCo.chapterName
	self._txtBossName.text = self._curEpisodeCo and self._curEpisodeCo.levelName
	self._txtMapName.text = self._curEpisodeCo and self._curEpisodeCo.levelName

	if self._challengeMo then
		if not self._challengeMo.totalScore then
			local totalScore = 0

			self._txtScore.text = BossRushConfig.instance:getScoreStr(totalScore)

			self:refreshReward()
		end
	end
end

function MatchGameChallengeMapView:refreshReward()
	self._rewardIcon = self._rewardIcon or IconMgr.instance:getCommonPropItemIcon(self._goRewardIcon)

	local lastScore, lastRewardCo = MatchGameConfig.instance:getRewardTotalScore(self._actId, MatchGameEnum.RewardType.Challenge)
	local lastRewardId = lastRewardCo and lastRewardCo.rewardId
	local rewardCoList = DungeonConfig.instance:getRewardItems(lastRewardId)

	if rewardCoList and #rewardCoList > 0 then
		local itemType = rewardCoList and rewardCoList[1][1]
		local itemId = rewardCoList and rewardCoList[1][2]
		local quantity = rewardCoList and rewardCoList[1][3]

		self._rewardIcon:setMOValue(itemType, itemId, quantity)
		self._rewardIcon:setCountFontSize(46)

		local rewardCo = ItemModel.instance:getItemConfigAndIcon(itemType, itemId)
		local rewardName = rewardCo and rewardCo.name

		self._txtRewardName.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("matchgamechallengemapview_rewardname"), rewardName)
	else
		logError(string.format("三消挑战关卡奖励配置不存在  rewardId = %s", lastRewardId))
	end

	local lastScoreFormat = BossRushConfig.instance:getScoreStr(lastScore)

	self._txtRewardDesc.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("matchgamechallengemapview_rewarddesc"), lastScoreFormat)

	local status = MatchGameModel.instance:getRewardStatus(MatchGameEnum.RewardType.Challenge, lastRewardCo)

	gohelper.setActive(self._goHasGet, status == MatchGameEnum.RewardItemStatus.Gained)
end

function MatchGameChallengeMapView:_onClickSelectMap()
	self:refreshUI()
end

function MatchGameChallengeMapView:tickUpdateBossInfo()
	TaskDispatcher.cancelTask(self._sendRpc2UpdateBossInfo, self)

	if self._challengeMo then
		local nextBossUpdateTime = self._challengeMo.nextRoundTime

		if nextBossUpdateTime and nextBossUpdateTime > ServerTime.now() then
			local delaySeconds = math.ceil(nextBossUpdateTime / 1000 - ServerTime.now())

			TaskDispatcher.runDelay(self._sendRpc2UpdateBossInfo, self, delaySeconds)
		end
	end
end

function MatchGameChallengeMapView:_sendRpc2UpdateBossInfo()
	self._callbackId = MatchGameRpc.instance:sendGetAct244InfoRequest(self._actId, self.refreshUI, self)
end

function MatchGameChallengeMapView:_onUpdateEpisodeInfo()
	self:refreshUI()
end

function MatchGameChallengeMapView:_onCloseView(viewName)
	if viewName == ViewName.MatchGameChallengeRewardView then
		self:refreshRewardEntry()
		self:refreshReward()
	end
end

function MatchGameChallengeMapView:onClose()
	if self._callbackId then
		MatchGameRpc.instance:removeCallbackById(self._callbackId)

		self._callbackId = nil
	end
end

function MatchGameChallengeMapView:onDestroyView()
	self._simageBg:UnLoadImage()
	TaskDispatcher.cancelTask(self._sendRpc2UpdateBossInfo, self)
end

return MatchGameChallengeMapView
