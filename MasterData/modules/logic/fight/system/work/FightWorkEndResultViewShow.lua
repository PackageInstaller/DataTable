-- chunkname: @modules/logic/fight/system/work/FightWorkEndResultViewShow.lua

module("modules.logic.fight.system.work.FightWorkEndResultViewShow", package.seeall)

local FightWorkEndResultViewShow = class("FightWorkEndResultViewShow", BaseWork)

function FightWorkEndResultViewShow:onStart()
	FightController.instance:checkFightQuitTipViewClose()

	local curSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	local episode_config = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)
	local is_sp_episode = false
	local chapter_config
	local isAssassinStealthEpisode = false

	if episode_config then
		is_sp_episode = episode_config.type == DungeonEnum.EpisodeType.Sp
		isAssassinStealthEpisode = episode_config.type == DungeonEnum.EpisodeType.Assassin2Stealth

		local chapterId = episode_config.chapterId

		chapter_config = DungeonConfig.instance:getChapterCO(chapterId)

		if chapterId == DungeonEnum.ChapterId.BossStory then
			VersionActivity2_8BossModel.instance:setFocusElement(true)

			if curSendEpisodeId ~= VersionActivity2_8BossEnum.StoryBossLastEpisode then
				self:_done()

				return
			end
		end
	end

	if curSendEpisodeId then
		::label_1_0::

		local elementEpisodeId = DungeonConfig.instance:getElementEpisode(curSendEpisodeId)

		if isAssassinStealthEpisode or elementEpisodeId and not is_sp_episode then
			self:_done()

			return
		end

		if self:_needHideEntity() then
			FightHelper.hideAllEntity()
			FightMsgMgr.sendMsg(FightMsgId.ReleaseAllEntrustedEntity)
			FightController.instance:dispatchEvent(FightEvent.ReleaseAllEntrustedEntity)
		end

		local fightRecordMO = FightModel.instance:getRecordMO()
		local fightResult = fightRecordMO.fightResult
		local weekWalk2Win

		if episode_config and episode_config.type == DungeonEnum.EpisodeType.WeekWalk_2 then
			weekWalk2Win = WeekWalk_2Model.instance:isWin()

			if fightResult == FightEnum.FightResult.Succ then
				fightResult = FightEnum.FightResult.Fail
			end
		end

		if FightModel.instance:isShowSettlement() == false then
			self:_done()
		elseif fightResult == FightEnum.FightResult.Succ then
			self:showSuccView()
		elseif fightResult == FightEnum.FightResult.Fail or fightResult == FightEnum.FightResult.Abort or fightRecordMO.fightResult == FightEnum.FightResult.OutOfRoundFail then
			if episode_config and episode_config.type == DungeonEnum.EpisodeType.RoleStoryChallenge and fightResult ~= FightEnum.FightResult.Abort then
				self:showSuccView()
			elseif is_sp_episode and fightResult ~= FightEnum.FightResult.Abort then
				ViewMgr.instance:openView(ViewName.FightFailTipsView, {
					show_scene_dissolve_effect = true,
					fight_result = fightResult
				})
			elseif episode_config and episode_config.type == DungeonEnum.EpisodeType.TowerLimited then
				self:showSuccView()
			elseif weekWalk2Win then
				self:showSuccView()
			elseif episode_config and episode_config.type == DungeonEnum.EpisodeType.Odyssey then
				local mo = OdysseyModel.instance:getFightResultInfo()

				if mo and mo:checkFightTypeIsMyth() and mo:canShowMythSuccess() then
					self:showSuccView()
				elseif mo and mo:checkFightTypeIsConquer() and FightModel.instance:getCurWaveId() > 1 then
					self:showSuccView()
				else
					self:showFailView()
				end
			else
				if fightResult == FightEnum.FightResult.OutOfRoundFail then
					if BossRushController.instance:isInBossRushDungeon() then
						FightController.instance:registerCallback(FightEvent.OnResultViewClose, self._done, self)
						BossRushController.instance:openResultPanel()

						return
					end

					ViewMgr.instance:openView(ViewName.FightFailTipsView, {
						fight_result = fightResult,
						callback = function()
							self:showFailView()
						end
					})

					return
				end

				self:showFailView()
			end
		end
	end
end

function FightWorkEndResultViewShow:showSuccView()
	FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Victory)
	PopupController.instance:setPause("fightsuccess", true)
	FightController.instance:registerCallback(FightEvent.OnResultViewClose, self._done, self)
	self:_showSuccView()
end

function FightWorkEndResultViewShow:_showSuccView()
	local episode_config = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if episode_config then
		if episode_config.type == DungeonEnum.EpisodeType.Season then
			Activity104Controller.instance:openSeasonSettlementView()

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.SeasonRetail or episode_config.type == DungeonEnum.EpisodeType.SeasonTrial then
			PopupController.instance:setPause("fightsuccess", false)
			Activity104Controller.instance:openSeasonFightSuccView()

			return
		elseif ToughBattleConfig.instance:isActStage2EpisodeId(DungeonModel.instance.curSendEpisodeId) or ToughBattleConfig.instance:isStage1EpisodeId(DungeonModel.instance.curSendEpisodeId) then
			ViewMgr.instance:openView(ViewName.ToughBattleFightSuccView)

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.SeasonSpecial then
			Activity104Controller.instance:openSeasonSettlementView()

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.Season123 then
			Season123Controller.instance:openSeason123SettlementView()

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.Season123Retail or episode_config.type == DungeonEnum.EpisodeType.Season123Trial then
			PopupController.instance:setPause("fightsuccess", false)
			Season123Controller.instance:openSeasonFightSuccView()

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.RoleStoryChallenge then
			ViewMgr.instance:openView(ViewName.RoleStoryFightSuccView)

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.Act1_6DungeonBoss then
			ViewMgr.instance:openView(ViewName.VersionActivity1_6BossFightSuccView)

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.Cachot then
			local rogueEndingInfo = V1a6_CachotModel.instance:getRogueEndingInfo()

			if rogueEndingInfo then
				self:_done()

				return
			end
		elseif episode_config.type == DungeonEnum.EpisodeType.Rouge then
			ViewMgr.instance:openView(ViewName.RougeFightSuccessView)

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.Rouge2 then
			ViewMgr.instance:openView(ViewName.Rouge2_FightSuccessView)

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.Rouge2Boss then
			ViewMgr.instance:openView(ViewName.Rouge2_BossBattleResultPanel)

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.Season166Base or episode_config.type == DungeonEnum.EpisodeType.Season166Train then
			Season166Controller.instance:openResultPanel()

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.TowerBoss or episode_config.type == DungeonEnum.EpisodeType.TowerBossTeach then
			ViewMgr.instance:openView(ViewName.TowerBossResultView)

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.TowerPermanent or episode_config.type == DungeonEnum.EpisodeType.TowerLimited then
			ViewMgr.instance:openView(ViewName.TowerPermanentResultView)

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.Act183 then
			ViewMgr.instance:openView(ViewName.Act183FightSuccView)

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.Act191 then
			Activity191Controller.instance:openResultPanel(true)

			return
		elseif VersionActivity2_9DungeonHelper.isTargetActEpisode(episode_config.id, VersionActivity2_9Enum.ActivityId.Dungeon) then
			VersionActivity2_9DungeonController.instance:openFightSuccView()

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.Odyssey then
			OdysseyController.instance:openFightSuccView()

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.TowerDeep then
			local canShowResultView, result = TowerPermanentDeepModel.instance:checkCanShowResultView()

			if canShowResultView and result == TowerDeepEnum.FightResult.Succ then
				ViewMgr.instance:openView(ViewName.TowerDeepResultView)
			else
				self:_done()
			end

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.TowerCompose then
			local needShowTowerCompose = TowerComposeModel.instance:checkCanShowResultView()

			if needShowTowerCompose then
				TowerComposeController.instance:openTowerComposeResultView()
			else
				TowerComposeController.instance:openTowerComposeNormalResultView()
			end

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.Abyss then
			AbyssController.instance:openFightSuccView()

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.AtomicDungeon then
			AtomicDungeonController.instance:openAtomicDungeonFightSuccView()

			return
		elseif VersionActivity2_9DungeonHelper.isTargetActEpisode(episode_config.id, VersionActivity3_10Enum.ActivityId.Dungeon) then
			VersionActivity3_10DungeonController.instance:openFightSuccView()

			return
		end
	end

	if BossRushController.instance:isInBossRushDungeon() then
		BossRushController.instance:openResultPanel()

		return
	end

	ViewMgr.instance:openView(ViewName.FightSuccView)
end

function FightWorkEndResultViewShow:showFailView()
	FightAudioMgr.instance:setSwitch(FightEnum.AudioSwitch.Losing)
	FightController.instance:registerCallback(FightEvent.OnResultViewClose, self._done, self)

	local episode_config = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if episode_config then
		if Activity104Model.instance:isSeasonEpisodeType(episode_config.type) then
			Activity104Controller.instance:openSeasonFightFailView()

			return
		elseif Season123Controller.isSeason123EpisodeType(episode_config.type) then
			Season123Controller.instance:openSeasonFightFailView()

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.Act1_6DungeonBoss then
			ViewMgr.instance:openView(ViewName.VersionActivity1_6BossFightSuccView)

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.Season166Base then
			Season166Controller.instance:openResultPanel()

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.Act191 then
			Activity191Controller.instance:openResultPanel(false)

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.TowerDeep then
			local canShowResultView, result = TowerPermanentDeepModel.instance:checkCanShowResultView()

			if canShowResultView and result == TowerDeepEnum.FightResult.Fail then
				ViewMgr.instance:openView(ViewName.TowerDeepResultView)
			else
				self:_done()
			end

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.Rouge2 then
			local curEvent = Rouge2_MapModel.instance:getCurEvent()

			if curEvent and curEvent.type == Rouge2_MapEnum.EventType.NormalFight then
				ViewMgr.instance:openView(ViewName.Rouge2_FightSuccessView)

				return
			end
		elseif episode_config.type == DungeonEnum.EpisodeType.Rouge2Boss then
			ViewMgr.instance:openView(ViewName.Rouge2_BossBattleResultPanel)

			return
		elseif episode_config.type == DungeonEnum.EpisodeType.TowerCompose then
			local needShowTowerCompose = TowerComposeModel.instance:checkCanShowResultView()

			if needShowTowerCompose then
				TowerComposeController.instance:openTowerComposeResultView()

				return
			end
		elseif AtomicDungeonModel.instance:checkIsHardFightEpisode(episode_config.id) then
			AtomicDungeonController.instance:openAtomicDungeonHardFightResultView()

			return
		end
	end

	if BossRushController.instance:isInBossRushDungeon() then
		if ActivityHelper.isOpen(BossRushConfig.instance:getActivityId()) then
			BossRushController.instance:openResultPanel()
		else
			FightController.onResultViewClose()
		end

		return
	end

	ViewMgr.instance:openView(ViewName.FightFailView)
end

function FightWorkEndResultViewShow:_needHideEntity()
	local episode_config = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if episode_config and episode_config.type == DungeonEnum.EpisodeType.Season then
		return false
	end

	return true
end

function FightWorkEndResultViewShow:_done()
	self:onDone(true)
end

function FightWorkEndResultViewShow:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnResultViewClose, self._done, self)
	PopupController.instance:setPause("fightsuccess", false)
end

return FightWorkEndResultViewShow
