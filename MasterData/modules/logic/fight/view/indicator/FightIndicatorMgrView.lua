-- chunkname: @modules/logic/fight/view/indicator/FightIndicatorMgrView.lua

module("modules.logic.fight.view.indicator.FightIndicatorMgrView", package.seeall)

local FightIndicatorMgrView = class("FightIndicatorMgrView", BaseView)

FightIndicatorMgrView.IndicatorId2Behaviour = {
	[FightEnum.IndicatorId.Season] = FightIndicatorView,
	[FightEnum.IndicatorId.FightSucc] = FightSuccIndicator,
	[FightEnum.IndicatorId.Season1_2] = FightIndicatorView,
	[FightEnum.IndicatorId.Id4140004] = FightIndicatorView4140004,
	[FightEnum.IndicatorId.Act1_6DungeonBoss] = VersionActivity1_6_BossFightIndicatorView,
	[FightEnum.IndicatorId.Id6181] = FightIndicatorView6181,
	[FightEnum.IndicatorId.Id6182] = FightIndicatorView6182,
	[FightEnum.IndicatorId.Id6201] = FightIndicatorView6201,
	[FightEnum.IndicatorId.Id6202] = FightIndicatorView6202
}

function FightIndicatorMgrView:onInitView()
	self.indicatorId2View = {}
end

function FightIndicatorMgrView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnIndicatorChange, self.onIndicatorChange, self)
end

function FightIndicatorMgrView:removeEvents()
	self.removeEventCb(self, FightController.instance, FightEvent.OnIndicatorChange, self.onIndicatorChange, self)
end

function FightIndicatorMgrView:checkNeedInitFightSuccIndicator()
	local WinConditionType = 8
	local fightParam = FightModel.instance:getFightParam()
	local episodeId = fightParam and fightParam.episodeId

	if episodeId then
		::label_4_0::

		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

		if episodeId then
			::label_4_1::

			local winCondition = DungeonConfig.instance:getEpisodeCondition(episodeId)

			if winCondition then
				::label_4_2::

				local winList = FightStrUtil.instance:getSplitString2Cache(winCondition, false, "|", "#")

				if BossRushController.instance:isInBossRushFight() then
					self:createBehaviour(FightEnum.IndicatorId.V1a4_BossRush_ig_ScoreTips, 0)
				elseif VersionActivity1_6DungeonBossModel.instance:isInBossFight() then
					self:createBehaviour(FightEnum.IndicatorId.Act1_6DungeonBoss, 0)
				end

				if winList then
					for _, one in ipairs(winList) do
						local winType = tonumber(one[1])

						if winType == WinConditionType then
							self:createBehaviour(tonumber(one[2]), tonumber(one[3]) or 0)

							return
						end
					end
				end
			end
		end
	end
end

function FightIndicatorMgrView:onOpen()
	self:checkNeedInitFightSuccIndicator()
end

function FightIndicatorMgrView:createBehaviour(indicatorId, totalIndicatorNum)
	local behaviour = FightIndicatorMgrView.IndicatorId2Behaviour[indicatorId]
	local indicatorView

	if behaviour then
		indicatorView = behaviour.New()
		indicatorView.viewContainer = self.viewContainer

		indicatorView:initView(self, indicatorId, totalIndicatorNum)
		indicatorView:startLoadPrefab()

		self.indicatorId2View[indicatorId] = indicatorView
	else
		return nil
	end

	return indicatorView
end

function FightIndicatorMgrView:onIndicatorChange(indicatorId)
	local indicatorView = self.indicatorId2View[indicatorId]

	indicatorView = indicatorView or self:createBehaviour(indicatorId)

	if indicatorView then
		indicatorView:onIndicatorChange()
	end
end

function FightIndicatorMgrView:onDestroyView()
	for _, indicatorView in pairs(self.indicatorId2View) do
		indicatorView:onDestroy()
	end
end

return FightIndicatorMgrView
