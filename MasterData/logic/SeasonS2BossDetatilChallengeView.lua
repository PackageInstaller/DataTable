-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/seasonS2/SeasonS2BossDetatilChallengeView.lua

module("logic.extensions.season.view.seasonS2.SeasonS2BossDetatilChallengeView", package.seeall)

local SeasonS2BossDetatilChallengeView = class("SeasonS2BossDetatilChallengeView", SeasonBaseGridShowView)

function SeasonS2BossDetatilChallengeView:ctor()
	SeasonS2BossDetatilChallengeView.super.ctor(self)
end

function SeasonS2BossDetatilChallengeView:unbindEvents()
	SeasonS2BossDetatilChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function SeasonS2BossDetatilChallengeView:bindEvents()
	SeasonS2BossDetatilChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickSure, self)
end

function SeasonS2BossDetatilChallengeView:buildUI()
	SeasonS2BossDetatilChallengeView.super.buildUI(self)

	self._txtPower = self:getTxt("txtPower")
	self._teamViewsGo = self:getGo("enemy/tableview")
	self._teamGo = self:getGo("enemy/item")
	self._rewardViewsGo = self:getGo("rewardRace/tableview")
	self._rewardGo = self:getGo("rewardRace/item")
	self._raceCon = self:getGo("con")

	GameUtil.SetActive(self._teamGo, false)
	GameUtil.SetActive(self._rewardGo, false)

	self._teamScrollList = ScrollerList.create(self._teamViewsGo, self._teamGo, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
	self._rewardScrollList = ScrollerList.create(self._rewardViewsGo, self._rewardGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnClose = self:getBtn("btnClose")
	self._txtBuffTitle = self:getTxt("rewardRace/title/txtTitle")
end

function SeasonS2BossDetatilChallengeView:onExit()
	SeasonS2BossDetatilChallengeView.super.onExit(self)
	uGuiUtil.clearImage(self._raceCon)
	self._teamScrollList:dispose()
	self._rewardScrollList:dispose()

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end
end

function SeasonS2BossDetatilChallengeView:onEnter()
	SeasonS2BossDetatilChallengeView.super.onEnter(self)

	local params = self:getFirstParam()

	self._evtConfig = params.evtConfig
	self._evtDetailConfig = params.evtDetailConfig
	self._plusCfg = SeasonConfig.instance:getBossPlusCfg(self._evtConfig.seasonId, self._evtConfig.id)

	if self._txtTitle and self._plusCfg then
		self._txtTitle.text = self._plusCfg.txtTitle or ""
	end

	GameUtil.SetActive(self._btnChallenge, not params.bHideSure)
	uGuiUtil.clearImage(self._raceCon)

	if not string.nilorempty(self._plusCfg.imgRes) then
		uGuiUtil.setSpriteToImage(self._raceCon, nil, GameUrl.getBigbgFolderUrl("season", self._plusCfg.imgRes))
	end

	self:_showEnemy()
	self:_showRaceWithBuff()

	self._sureCallback = params.sureCallback
end

function SeasonS2BossDetatilChallengeView:_onClickSure()
	self:close()
	GameUtil.callBack(self._sureCallback)
end

function SeasonS2BossDetatilChallengeView:_showPetLiHui()
	local creeps = SeasonConfig.instance:getCreeps(self._evtDetailConfig.creepsMasterId)

	if self._raceObj then
		RoleObjectPool.instance:removeRole(self._raceObj)
	end

	local minPosId = 99999
	local creepCo

	for k, v in pairs(creeps) do
		if minPosId > v.posId then
			minPosId = v.posId
			creepCo = v
		end
	end

	if creepCo then
		local modelCfg = CharactorFacade.instance:getShareLihuiModelUIPosAndScale(creepCo.raceId)

		if not modelCfg[1] then
			if not modelCfg[2] then
				local y = 0

				if not modelCfg[3] then
					local scale = 1

					self._raceObj = RoleObjectPool.instance:addRoleToParent(self._raceObj, creepCo.raceId, self._raceCon, scale, nil, true, modelCfg[1], y)
				end
			end
		end
	end
end

function SeasonS2BossDetatilChallengeView:_showEnemy()
	local creepsMasterId = self._evtDetailConfig.creepsMasterId
	local creeps = SeasonConfig.instance:getCreeps(creepsMasterId)
	local list = {}

	for k, v in pairs(creeps) do
		local mo = FightingPowerPetMo.New()

		mo:fromChallengeCreepCo(v, creeps)
		table.insert(list, mo)
	end

	self._teamScrollList:reloadData(list)

	local creepsTeam = SeasonConfig.instance:getCreepTeam(creepsMasterId)

	if self._txtPower then
		self._txtPower.text = langPara("推荐战力：%s", creepsTeam.recommendZdl or 0)
	end
end

function SeasonS2BossDetatilChallengeView:_showRaceWithBuff()
	local list = {}

	if self._plusCfg then
		for i, v in ipairs(self._plusCfg.raceIdWithBuff) do
			table.insert(list, v)
		end

		self._txtBuffTitle.text = self._plusCfg.buffDesc
	end

	self._rewardScrollList:reloadData(list)
end

function SeasonS2BossDetatilChallengeView:_updateTeamCell(view, cell, data, tag)
	local proxy = MaterialMgr.setCellByMo(data, cell)

	if proxy then
		proxy.binder:setCallBack(function()
			CommonTipsMgr.instance:showPetTips(data)
		end)
	end
end

function SeasonS2BossDetatilChallengeView:_clearTeamCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function SeasonS2BossDetatilChallengeView:_updateRewardCell(view, cell, data, tag)
	MaterialMgr.resetAll(cell.gameObject)

	if checknumber(data) > 0 then
		MaterialMgr.setCell(MatType.Pet, data, cell.gameObject)
	end
end

function SeasonS2BossDetatilChallengeView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return SeasonS2BossDetatilChallengeView
