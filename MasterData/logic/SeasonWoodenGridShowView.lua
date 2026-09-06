-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonWoodenGridShowView.lua

module("logic.extensions.season.view.SeasonWoodenGridShowView", package.seeall)

local SeasonWoodenGridShowView = class("SeasonWoodenGridShowView", SeasonBaseGridShowView)

function SeasonWoodenGridShowView:ctor()
	SeasonWoodenGridShowView.super.ctor(self)
end

function SeasonWoodenGridShowView:unbindEvents()
	SeasonWoodenGridShowView.super.unbindEvents(self)
end

function SeasonWoodenGridShowView:bindEvents()
	SeasonWoodenGridShowView.super.bindEvents(self)
end

function SeasonWoodenGridShowView:buildUI()
	SeasonWoodenGridShowView.super.buildUI(self)

	self._txtPlayerScore = self:getTxt("bottom/txtPlayerScore")
	self._txtRecommendZdl = self:getTxt("bottom/txtRecommendZdl")

	local playerRoot = self:getGo("bottom/playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._txtDesc = self:getTxt("bottom/txtDesc")
	self._petGo = self:getGo("con/pet")
end

function SeasonWoodenGridShowView:onExit()
	SeasonWoodenGridShowView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonMapEventInfoUpdate, self._updateAll, self)
	self._playerSliderMo:onExit()

	if self._petPhoto then
		self._petPhoto:clear()
	end

	self._loader = nil
end

function SeasonWoodenGridShowView:onEnter()
	SeasonWoodenGridShowView.super.onEnter(self)

	local params = self:getFirstParam()

	self._evtConfig = params.evtConfig
	self._evtDetailConfig = params.evtDetailConfig

	GlobalDispatcher:addListener(GlobalNotify.SeasonMapEventInfoUpdate, self._updateAll, self)

	self._txtTitle.text = lang("遗迹试炼")

	local targetRaceId = 0

	if self._evtDetailConfig.raceId then
		targetRaceId = checknumber(self._evtDetailConfig.raceId)
	else
		local creepsMasterId = self._evtDetailConfig.creepsMasterId
		local creeps = SeasonConfig.instance:getCreeps(creepsMasterId)

		for k, v in pairs(creeps) do
			if checknumber(k) > 0 then
				targetRaceId = v.raceId

				break
			end
		end
	end

	if targetRaceId > 0 then
		self:_showPetLiHui(targetRaceId)
	end

	if self._txtCost and self._evtConfig then
		self._cost = checknumber(self._evtConfig.cost)

		GameUtil.SetActive(self._txtCost, self._cost > 0)

		self._txtCost.text = self._cost
	else
		GameUtil.SetActive(self._txtCost, false)
	end

	self:_initRewardSlider()
	SeasonController.instance:sendGetEventInfoById(self._evtConfig.id)
end

function SeasonWoodenGridShowView:_showPetLiHui()
	local creeps = SeasonConfig.instance:getCreeps(self._evtDetailConfig.creepsMasterId)

	if self._petPhoto then
		self._petPhoto:clear()
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
		self._petPhoto = PetPhotoShow.Get(self._petGo)

		self._petPhoto:showPetEffect(creepCo.raceId, true, 4.3)

		local modelCfg = CharactorFacade.instance:getSeasonUIPosAndScale(creepCo.raceId)
		local x = checknumber(modelCfg[1]) / 360
		local y = checknumber(modelCfg[2]) / 360

		if not modelCfg[3] then
			self._petPhoto:setPetLocalPosAndScale(x, y, modelCfg[3])
		end
	end
end

function SeasonWoodenGridShowView:_initRewardSlider()
	local playerParam = {}

	playerParam.view = self
	playerParam.playerSliderCellClass = SeasonWoodenChallengeSliderCell
	playerParam.prizeCfgs = SeasonConfig.instance:getWoodenDamageConfigs(self._evtDetailConfig.seasonId, self._evtDetailConfig.damagePlanId)

	function playerParam.getPlayerProgress()
		local mo = SeasonModel.instance:getMapInfoById(self._evtConfig.id)

		return mo:getWoodenOldDamage()
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.damage
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return false
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		local mo = SeasonModel.instance:getMapInfoById(self._evtConfig.id)

		return mo:getWoodenOldDamage() >= rewardCfg.damage
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		return
	end

	function playerParam.parseGetProgress(rewardCfg)
		return rewardCfg.damage
	end

	playerParam.playerSliderEndOffset = 40
	playerParam.playerWidthSpace = 120

	self._playerSliderMo:initParam(playerParam, true)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function SeasonWoodenGridShowView:_updateAll()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()

	local mo = SeasonModel.instance:getMapInfoById(self._evtConfig.id)

	self._txtPlayerScore.text = mo:getWoodenOldDamage()

	local teamCfg = SeasonConfig.instance:getCreepTeam(self._evtDetailConfig.creepsMasterId)

	self._txtRecommendZdl.text = langPara("推荐战力：%d", teamCfg.recommendZdl)
end

return SeasonWoodenGridShowView
