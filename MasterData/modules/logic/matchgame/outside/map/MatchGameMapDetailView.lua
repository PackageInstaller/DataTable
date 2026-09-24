-- chunkname: @modules/logic/matchgame/outside/map/MatchGameMapDetailView.lua

module("modules.logic.matchgame.outside.map.MatchGameMapDetailView", package.seeall)

local MatchGameMapDetailView = class("MatchGameMapDetailView", BaseView)

function MatchGameMapDetailView:onInitView()
	self._txtLevelName = gohelper.findChildText(self.viewGO, "#go_leveldetail/levelnamebg/#txt_levelname")
	self._goRewardList = gohelper.findChild(self.viewGO, "#go_leveldetail/#go_reward")
	self._goRewardItem = gohelper.findChild(self.viewGO, "#go_leveldetail/#go_reward/#go_rewarditem")
	self._goStarList = gohelper.findChild(self.viewGO, "#go_leveldetail/levelnamebg/StarContainer/#go_StarList")
	self._goStarItem = gohelper.findChild(self.viewGO, "#go_leveldetail/levelnamebg/StarContainer/#go_StarList/#go_StarItem")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_enter")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameMapDetailView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnClickSelectMap, self.refreshUI, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnClickSelectEpisode, self.refreshUI, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnUpdateEpisodeInfo, self.refreshUI, self)
end

function MatchGameMapDetailView:removeEvents()
	self._btnEnter:RemoveClickListener()
end

function MatchGameMapDetailView:_btnEnterOnClick()
	if not self._selectEpisodeCo then
		return
	end

	MatchGameController.instance:openHeroGroupView(self._selectEpisodeId)
end

function MatchGameMapDetailView:_editableInitView()
	self._goRewardItem = self:getResInst(MatchGameEnum.MapRewardItemPrefabPath, self._goRewardList, "#go_RewardItem")

	gohelper.setActive(self._goRewardItem, false)

	self._actId = MatchGameModel.instance:getCurActId()
end

function MatchGameMapDetailView:onOpen()
	self:refreshUI()
end

function MatchGameMapDetailView:refreshUI()
	self._selectEpisodeId = MatchGameLevelModel.instance:getCurEpisodeId()
	self._selectEpisodeMo = MatchGameLevelModel.instance:getEpisodeInfoById(self._selectEpisodeId)
	self._selectEpisodeCo = lua_activity244_episode.configDict[self._selectEpisodeId]
	self._isPass = MatchGameLevelModel.instance:isEpisodePass(self._selectEpisodeId)
	self._txtLevelName.text = self._selectEpisodeCo and self._selectEpisodeCo.levelName

	self:refreshStars()
	self:refreshReward()
end

function MatchGameMapDetailView:refreshStars()
	local maxStarNum = MatchGameConfig.instance:getConstValue(self._actId, MatchGameEnum.ConstId.EpisodeStarNum, true)

	gohelper.CreateNumObjList(self._goStarList, self._goStarItem, maxStarNum, self._refreshStarItem, self)
end

function MatchGameMapDetailView:_refreshStarItem(goStar, index)
	local goLight = gohelper.findChild(goStar, "light")
	local isPass = self._selectEpisodeMo:isConditionPass(index)

	gohelper.setActive(goLight, isPass)
end

function MatchGameMapDetailView:refreshReward()
	local firstBonus = GameUtil.splitString2(self._selectEpisodeCo.firstBonus, true)
	local otherBonus = GameUtil.splitString2(self._selectEpisodeCo.bonus, true)
	local allBonus = {}

	tabletool.addValues(allBonus, firstBonus)
	tabletool.addValues(allBonus, otherBonus)

	self._firstBonusStartIndex = 1
	self._firstBonusEndIndex = #firstBonus

	gohelper.CreateObjList(self, self._refreshRewardItem, allBonus, self._goRewardList, self._goRewardItem, MatchGameMapRewardItem)
end

function MatchGameMapDetailView:_refreshRewardItem(rewardItem, rewardParam, index)
	local isFirstBonus = index >= self._firstBonusStartIndex and index <= self._firstBonusEndIndex
	local hasGet = isFirstBonus and self._isPass

	rewardItem:onUpdateMO(rewardParam, isFirstBonus, index, hasGet)
end

function MatchGameMapDetailView:onClose()
	return
end

function MatchGameMapDetailView:onDestroyView()
	return
end

return MatchGameMapDetailView
