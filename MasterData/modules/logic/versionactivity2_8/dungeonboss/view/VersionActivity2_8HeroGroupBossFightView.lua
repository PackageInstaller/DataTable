-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/view/VersionActivity2_8HeroGroupBossFightView.lua

module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8HeroGroupBossFightView", package.seeall)

local VersionActivity2_8HeroGroupBossFightView = class("VersionActivity2_8HeroGroupBossFightView", HeroGroupFightView)

function VersionActivity2_8HeroGroupBossFightView:_refreshBtns(isCostPower)
	VersionActivity2_8HeroGroupBossFightView.super._refreshBtns(self, isCostPower)
	gohelper.setActive(self._dropherogroup, false)
end

function VersionActivity2_8HeroGroupBossFightView:_onClickStart()
	local costs = string.split(self.episodeConfig.cost, "|")
	local cost1 = string.split(costs[1], "#")
	local value = tonumber((not cost1[3] or nil) and 0)
	local remainCount = self:_getfreeCount()
	local multiCost = value * ((self._multiplication or 1) - remainCount)

	if multiCost > CurrencyModel.instance:getPower() then
		CurrencyController.instance:openPowerView()

		return
	end

	local guideEpisodeId = 10104

	if HeroGroupModel.instance.episodeId == guideEpisodeId and not DungeonModel.instance:hasPassLevel(guideEpisodeId) then
		local list = HeroSingleGroupModel.instance:getList()
		local count = 0

		for i, v in ipairs(list) do
			if not v:isEmpty() then
				count = count + 1
			end
		end

		if count < 2 then
			GameFacade.showToast(ToastEnum.HeroSingleGroupCount)

			return
		end
	end

	self:_closemultcontent()
	GameFacade.showMessageBox(MessageBoxIdDefine.BossStoryTip1, MsgBoxEnum.BoxType.Yes_No, self._enterFight, nil, nil, self)
end

function VersionActivity2_8HeroGroupBossFightView:_saveHeroGroup()
	local episodeId = HeroGroupModel.instance.episodeId
	local heroGroupId = VersionActivity2_8BossConfig.instance:getHeroGroupId(episodeId)
	local heroGroupConfig = heroGroupId and lua_hero_group_type.configDict[heroGroupId]
	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local mainList = heroGroupMO:getMainList()
	local subList = heroGroupMO:getSubList()

	HeroGroupModel.instance:updateCustomHeroGroup(heroGroupConfig.id, heroGroupMO)

	local req = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

	FightParam.initFightGroup(req.fightGroup, heroGroupMO.clothId, mainList, subList, heroGroupMO:getAllHeroEquips(), heroGroupMO:getAllHeroActivity104Equips())
	HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(ModuleEnum.HeroGroupSnapshotType.Resources, heroGroupConfig.id, req)
end

function VersionActivity2_8HeroGroupBossFightView:_enterFight()
	if HeroGroupModel.instance.episodeId then
		self._closeWithEnteringFight = true

		local result = FightController.instance:setFightHeroSingleGroup()

		if result then
			self:_saveHeroGroup()
			self.viewContainer:dispatchEvent(HeroGroupEvent.BeforeEnterFight)

			local fightParam = FightModel.instance:getFightParam()

			if self._replayMode then
				fightParam.isReplay = true
				fightParam.multiplication = self._multiplication

				DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, self._multiplication, nil, true)
			else
				fightParam.isReplay = false
				fightParam.multiplication = 1

				DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, 1)
			end

			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

return VersionActivity2_8HeroGroupBossFightView
