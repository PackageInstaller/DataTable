-- chunkname: @modules/logic/fight/view/FightToughBattleSkillView.lua

module("modules.logic.fight.view.FightToughBattleSkillView", package.seeall)

local FightToughBattleSkillView = class("FightToughBattleSkillView", BaseViewExtended)

function FightToughBattleSkillView:onInitView()
	self._item = gohelper.findChild(self.viewGO, "#scroll_List/Viewport/Content/#go_Items")
end

function FightToughBattleSkillView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceStart, self._onRoundSequenceStart, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.StartPlayClothSkill, self._onRoundSequenceStart, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, self._onRoundSequenceFinish, self)
end

function FightToughBattleSkillView:removeEvents()
	return
end

function FightToughBattleSkillView:_onRoundSequenceStart()
	gohelper.setActive(self.viewGO, false)
	FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, FightRightElementEnum.Elements.CharSupport)
end

function FightToughBattleSkillView:_onRoundSequenceFinish()
	gohelper.setActive(self.viewGO, true)
	FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.CharSupport, self.height)
end

function FightToughBattleSkillView:onOpen()
	local fightParam = FightModel.instance:getFightParam()
	local chapterId = fightParam.chapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

	if not chapterCo or chapterCo.type ~= DungeonEnum.ChapterType.ToughBattle then
		return
	end

	local episodeId = fightParam.episodeId

	if not episodeId then
		return
	end

	self._isAct = ToughBattleConfig.instance:isActEpisodeId(episodeId)

	self:refreshView()
end

function FightToughBattleSkillView:refreshView()
	local info = self:getInfo()

	if not info then
		FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, FightRightElementEnum.Elements.CharSupport)

		return
	end

	local passIds = info.passChallengeIds
	local allCos = {}
	local allUseTrial = {}
	local fightGroup = FightModel.instance.last_fightGroup

	if fightGroup then
		for _, trialInfo in ipairs(fightGroup.trialHeroList) do
			allUseTrial[trialInfo.trialId] = true
		end
	end

	if self._isAct then
		for _, id in ipairs(passIds) do
			local co = lua_activity158_challenge.configDict[id]

			if co then
				self:addHeroId(allCos, co.heroId, allUseTrial)
			end
		end
	else
		for _, id in ipairs(passIds) do
			local co = lua_siege_battle.configDict[id]

			if co then
				self:addHeroId(allCos, co.heroId, allUseTrial)
			end
		end
	end

	local itemHeight = FightRightElementEnum.ElementsSizeDict[FightRightElementEnum.Elements.CharSupport]

	self.height = #allCos * itemHeight.y

	gohelper.CreateObjList(self, self.createItem, allCos, self._item.transform.parent.gameObject, self._item, FightToughBattleSkillItem)
	FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.CharSupport, self.height)
end

function FightToughBattleSkillView:addHeroId(list, heroId, allUseTrial)
	local co = lua_siege_battle_hero.configDict[heroId]

	if not co then
		return
	end

	if co.type == ToughBattleEnum.HeroType.Hero and not allUseTrial[tonumber(co.param)] then
		return
	end

	table.insert(list, co)
end

function FightToughBattleSkillView:createItem(obj, data, index)
	obj:setCo(data)
end

function FightToughBattleSkillView:getInfo()
	if self._isAct then
		local info = ToughBattleModel.instance:getActInfo()

		if info then
			return info
		end

		Activity158Rpc.instance:sendGet158InfosRequest(VersionActivity1_9Enum.ActivityId.ToughBattle, self.onRecvMsg, self)
	else
		local info = ToughBattleModel.instance:getStoryInfo()

		if info then
			return info
		end

		SiegeBattleRpc.instance:sendGetSiegeBattleInfoRequest(self.onRecvMsg, self)
	end
end

function FightToughBattleSkillView:onRecvMsg(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:refreshView()
end

return FightToughBattleSkillView
