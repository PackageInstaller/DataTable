-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/formationmodel/SeasonPveFmtMo.lua

module("logic.extensions.season.model.formationmodel.SeasonPveFmtMo", package.seeall)

local SeasonPveFmtMo = class("SeasonPveFmtMo", ICustomFmtMo)
local TotalPveTeamCount = 3

function SeasonPveFmtMo:onReset()
	SeasonPveFmtMo.super.onReset(self)

	self.isShowBtnCutePet = false
	self.isShowPetBag = false
end

function SeasonPveFmtMo:initParams(id, eventType, eventId, gridId)
	self.isShowTab = false
	self._teamId = id
	self.curTabIndex = id
	self.curEventType = checknumber(eventType)
	self.curEventId = eventId
	self.curGridId = gridId

	local seasonId = SeasonModel.instance:getSeasonId()
	local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, self.curGridId) or {}

	self.battleCost = checknumber(evtConfig.cost)
	self._isBossChallenge = self.curEventType == SeasonGridEvtTypes.EVT_BOSS

	if self._isBossChallenge == true then
		self:setBossTeamSortList(SeasonPVEBossController.instance:getBossTeamSortList())
	end

	self:updatePetList()
	self:updatetFightEvent()
	SeasonController.instance:sendGetHolyStripesinfo(self.curTabIndex)
	SeasonController.instance:sendGetCutePetInfo(self.curTabIndex)
end

function SeasonPveFmtMo:getCostNum()
	return self.battleCost
end

function SeasonPveFmtMo:isBossChallenge()
	return self._isBossChallenge
end

function SeasonPveFmtMo:getBossTeamSortList()
	return self._bossTeamSortList
end

function SeasonPveFmtMo:setBossTeamSortList(list)
	self._bossTeamSortList = list
end

function SeasonPveFmtMo:updatetFightEvent()
	self.creepsTeam = {}
	self.creeps = {}

	local seasonId = SeasonModel.instance:getSeasonId()
	local config = SeasonConfig.instance:getMapEvtDetail(seasonId, self.curEventType, self.curEventId) or {}
	local creepsMasterId = config.creepsMasterId

	self.creepsTeam = SeasonConfig.instance:getCreepTeam(creepsMasterId)
	self.creeps = SeasonConfig.instance:getCreeps(creepsMasterId)
	self.topTitleStr = ""
	self.ruleDescStr = ""

	if self.creepsTeam then
		self.topTitleStr = self.creepsTeam.name
		self.ruleDescStr = self.creepsTeam.description
	end
end

function SeasonPveFmtMo:updatePetList()
	local list = SeasonTeamsModel.instance:getTeams() or {}

	self.maxTabCount = #list

	self:clearAllPetList()

	self.bagpetListMap = {}

	for i, seasonFormationTeamMo in ipairs(list) do
		local petList = seasonFormationTeamMo:getPetMoList() or {}

		for j, petMo in ipairs(petList) do
			petList[j] = SeasonPetsModel.instance:calcPetAttr(petMo, seasonFormationTeamMo)
		end

		self.bagpetListMap[i] = petList
	end

	for i, seasonFormationTeamMo in ipairs(list) do
		local fmo = self.forMationMap[i]

		if fmo and seasonFormationTeamMo.form then
			fmo:SetData(seasonFormationTeamMo.form)
		else
			fmo:ResetPosition()
		end
	end
end

function SeasonPveFmtMo:getExtendViewName()
	return ViewName.SeasonfmttabextView
end

function SeasonPveFmtMo:getFormationExtendViewName()
	return ViewName.SeasonfmteditView
end

function SeasonPveFmtMo:sendMakeContract(summonMasterId, summonedPetId)
	local curTab = self.curTabIndex

	SeasonController.instance:sendSummonPetInfo(curTab, summonMasterId, summonedPetId)
end

function SeasonPveFmtMo:sendCancelContract(summonMasterId, summonedPetId)
	local curTab = self.curTabIndex

	SeasonController.instance:sendSummonPetInfo(curTab, summonMasterId, summonedPetId)
end

function SeasonPveFmtMo:checkIsSummonMasterPetsNotInBag(petMo, limitLvl)
	return true
end

function SeasonPveFmtMo:getSummonPetLimitLvl(petMo, limitLvl)
	return 0
end

function SeasonPveFmtMo:initFormationMo()
	self.forMationMap = {}

	for i = 1, TotalPveTeamCount do
		self.forMationMap[i] = FormationMO.New(GameUtil.handler(self.getPetMoById, self))
	end
end

function SeasonPveFmtMo:getCurFormation()
	self.formationMo = self.forMationMap[self.curTabIndex]

	return self.forMationMap[self.curTabIndex]
end

function SeasonPveFmtMo:getMonsterConfigList()
	return self.creeps
end

function SeasonPveFmtMo:getFmtInfoConfig()
	return self.creepsTeam
end

function SeasonPveFmtMo:initFightHandler()
	local function handler()
		if self._isBossChallenge == true then
			local formationMo = self.forMationMap[self._teamId]
			local power, speed = formationMo:getPowerAndSpeed()
			local simpleForm = CustomFmtController.instance:createFormPb(formationMo)
			local teamMo = SeasonTeamsModel.instance:getTeam(self._teamId)

			if teamMo then
				teamMo:resetFormPb(simpleForm)

				teamMo.teamZdl = power
			end

			SeasonEvtHandler.instance:applyTriggerEvt(self.curGridId, {
				form = simpleForm,
				teamIndex = self._teamId
			})
		else
			local formationMo = self:getCurFormation()
			local power, speed = formationMo:getPowerAndSpeed()
			local simpleForm = self:getCurSimpleForm()
			local teamMo = SeasonTeamsModel.instance:getTeam(self.curTabIndex)

			if teamMo then
				teamMo:resetFormPb(simpleForm)

				teamMo.teamZdl = power
			end

			SeasonEvtHandler.instance:applyTriggerEvt(self.curGridId, {
				form = simpleForm,
				teamIndex = self.curTabIndex
			})
		end
	end

	self:setFightHandler(handler, nil)
end

function SeasonPveFmtMo:initSaveHandler()
	return
end

function SeasonPveFmtMo:onClickCloseBtn(handler)
	SeasonPveFmtMo.super.onClickCloseBtn(self, handler)
	self:sendSaveMsg()
end

function SeasonPveFmtMo:sendSaveMsg()
	local formationMo = self:getCurFormation()
	local curTab = self.curTabIndex
	local power, speed = formationMo:getPowerAndSpeed()
	local teamMo = SeasonTeamsModel.instance:getTeam(self.curTabIndex)

	if teamMo then
		teamMo.teamZdl = power
	end

	SeasonController.instance:sendSaveTeamForm(curTab, formationMo)
end

function SeasonPveFmtMo:initPetList()
	if not self.bagpetListMap[self.curTabIndex] then
		for i, petMo in ipairs(self.bagpetListMap[self.curTabIndex]) do
			self:addPetToList(petMo)
		end
	end
end

function SeasonPveFmtMo:resetPetList()
	self:clearAllPetList()
end

function SeasonPveFmtMo:refreshPetList(changePetMoMap)
	return
end

function SeasonPveFmtMo:jumpToTabIndex(idx)
	self:sendSaveMsg()
	self:clearAllPetList()
	SeasonPveFmtMo.super.jumpToTabIndex(self, idx)
	SeasonController.instance:sendGetHolyStripesinfo(idx)
	SeasonController.instance:sendGetCutePetInfo(idx)
end

return SeasonPveFmtMo
