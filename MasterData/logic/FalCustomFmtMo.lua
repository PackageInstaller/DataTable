-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/model/FalCustomFmtMo.lua

module("logic.extensions.landlords.model.FalCustomFmtMo", package.seeall)

local FalCustomFmtMo = class("FalCustomFmtMo", ICustomFmtMo)

function FalCustomFmtMo:onInit()
	FalCustomFmtMo.super.onInit(self)
	self:initFormationMoAsRight()
end

function FalCustomFmtMo:onReset()
	FalCustomFmtMo.super.onReset(self)

	self.isShowBtnCutePet = false
end

function FalCustomFmtMo:updateCfg(activityId)
	self._falGameMo = FightAgainstLandlordsController.instance:getFalGameMo()
	self._activityId = activityId
	self._myUserId = FightAgainstLandlordsController.instance:getMyUserId()
end

function FalCustomFmtMo:updateData()
	self.isShowBtnSave = false
	self.isShowBtnFormation = false
	self.isShowBtnContractPet = true
	self.isShowBtnBuffForm = false
	self.isStartButtonAvailable = false
	self.isShowOneKey = false
	self.isShowClean = false
	self.ruleDescStr = ""

	self:setNeedUpPetCount(0)
	self:initPetList()
	self:_initRightPetMap()
	self:refreshMyFmts()

	for _, teamId in ipairs({
		0,
		1
	}) do
		local str = string.format("test+ --> teamId=%s, creepsIds=", teamId)
		local bagCreepsIdsAsSameTeam = self._falGameMo:getBagCreepsIdsAsSameTeam(teamId)

		for _, creepsId in ipairs(bagCreepsIdsAsSameTeam) do
			str = str .. string.format("%s,", creepsId)
		end

		print(str)
	end
end

function FalCustomFmtMo:sendFightMsg()
	return
end

function FalCustomFmtMo:onClickCloseBtn(handler)
	FloatWordMgr.instance:show("游戏中，无法返回")
end

function FalCustomFmtMo:initFightHandler()
	return
end

function FalCustomFmtMo:initPetList()
	self:clearAllPetList()

	local myTeamId = self._falGameMo:getMyTeamId()
	local userIdList = self._falGameMo:getUserIdListAsSameTeam(myTeamId)

	for _, userId in ipairs(userIdList) do
		local bagCreepsIds = self._falGameMo:getBagCreepsIdsAsUser(userId)

		for _, creepsId in ipairs(bagCreepsIds) do
			local petMo = self:_makePetMoAsFal(creepsId, userId, myTeamId)

			petMo.isSupportedPet = userId ~= self._myUserId

			self:addPetToList(petMo)
		end
	end
end

function FalCustomFmtMo:_initRightPetMap()
	if self._petMapAsRight == nil then
		self._petMapAsRight = {}
	end

	local myTeamId = self._falGameMo:getMyTeamId()
	local teamId = myTeamId == 0 and 1 or 0
	local userIdList = self._falGameMo:getUserIdListAsSameTeam(teamId)

	for _, userId in ipairs(userIdList) do
		local bagCreepsIds = self._falGameMo:getBagCreepsIdsAsUser(userId)

		for _, creepsId in ipairs(bagCreepsIds) do
			self._petMapAsRight[creepsId] = self:_makePetMoAsFal(creepsId, userId, teamId)
		end
	end
end

function FalCustomFmtMo:_makePetMoAsFal(petId, userId, teamId)
	local petMo = FightAgainstLandlordsModel.instance:getPetMoAsFal(petId)
	local bagCreepsIdsAsSameTeam = self._falGameMo:getBagCreepsIdsAsSameTeam(teamId)

	petMo.falMo = {}
	petMo.falMo.userId = userId
	petMo.falMo.roundId = 0

	local cpId, petIdAsCp = FightAgainstLandlordsController.instance:getPetIdAsCp(self._activityId, petId, bagCreepsIdsAsSameTeam)

	petMo.falMo.cpId = cpId
	petMo.falMo.petIdAsCp = petIdAsCp

	return petMo
end

function FalCustomFmtMo:onFilterPetShow(petMo)
	return not petMo.isSupportedPet
end

function FalCustomFmtMo:getMonsterConfigList()
	return {}
end

function FalCustomFmtMo:getFmtInfoConfig()
	local simpleForm = self:getSimpleFormByTeamId(1)

	return simpleForm.extParams
end

function FalCustomFmtMo:checkPetIsForbit(petMo)
	return (self._isForbit or nil) and not self:getFormationMoByTeamId(0):HasPet(petMo:getId())
end

function FalCustomFmtMo:showForbitPetAlert(petMo)
	if self._isForbit then
		FloatWordMgr.instance:show("目前不能布置精灵")
	end
end

function FalCustomFmtMo:setForbitType(isToForbit)
	self._isForbit = isToForbit
end

function FalCustomFmtMo:getTeamAndFormation(creepCfg)
	local fmtMo = self:getFormationMoByTeamId(1)
	local teams, formations, speed = fmtMo:getTeamAndFormation()

	ArraySort.sortOn(teams, "position")

	return teams, formations
end

function FalCustomFmtMo:getExtendViewName()
	return ViewName.FalChallengeExView
end

function FalCustomFmtMo:refreshMyFmts()
	local fmtMo = self:getFormationMoByTeamId(self._falGameMo:getMyTeamId())
	local posIdList = {}

	for posId, petId in ipairs(fmtMo:GetPositions()) do
		if petId > 0 then
			table.insert(posIdList, posId)
		end
	end

	MissionModel.instance:setFixedPos(posIdList)
end

function FalCustomFmtMo:updateCellTop(cell, petMo)
	local luaCls = FalPetCpTag
	local url = FalPetCpTag.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		proxy.binder:setData(self._activityId, petMo)
	end
end

function FalCustomFmtMo:setNeedUpPetCount(count)
	self.needUpPetCount = count

	MissionModel.instance:setMaxPetNum(self.needUpPetCount)
end

function FalCustomFmtMo:_updateFmt()
	GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab)
end

function FalCustomFmtMo:onFmoSetDown()
	GlobalDispatcher:dispatch(GlobalNotify.NotifyCpAndBuffUpdateInFalFmt)
end

function FalCustomFmtMo:getFormationMoByTeamId(teamId)
	if teamId == 0 then
		return self:getCurFormation()
	else
		return self._formationMoAsRight
	end
end

function FalCustomFmtMo:getSimpleFormByTeamId(teamId)
	if teamId == 0 then
		return self:getCurSimpleForm()
	else
		return CustomFmtController.instance:createFormPb(self:getFormationMoByTeamId(teamId))
	end
end

function FalCustomFmtMo:updateFormationMoBySimpleForm(simpleForm, teamId)
	if teamId == 0 then
		self:_updateLeftFormationMo(simpleForm)
	else
		self:_updateRightFormationMo(simpleForm)
	end

	self:updateFmtPetMoBySimpleForm(teamId)
end

function FalCustomFmtMo:_updateLeftFormationMo(simpleForm)
	self:getFormationMoByTeamId(0):SetData(simpleForm)
	self:refreshMyFmts()
end

function FalCustomFmtMo:_updateRightFormationMo(simpleForm)
	self:getFormationMoByTeamId(1):SetData(simpleForm)
end

function FalCustomFmtMo:updateFmtPetMoBySimpleForm(teamId)
	local petMoList = self:getPetMoListOfFmt(teamId)

	for _, petMo in ipairs(petMoList) do
		petMo.falMo.roundId = self._falGameMo:getRoundId()
	end
end

function FalCustomFmtMo:initFormationMoAsRight()
	self._formationMoAsRight = FormationMO.New(GameUtil.handler(self.getPetMoByIdAsRight, self))
end

function FalCustomFmtMo:getPetMoByIdAsRight(petId)
	if self._petMapAsRight == nil then
		self:_initRightPetMap()
	end

	if self._petMapAsRight then
		return self._petMapAsRight[petId]
	end

	return nil
end

function FalCustomFmtMo:getPetIdListOfFmt(teamId)
	local fmtMo = self:getFormationMoByTeamId(teamId)

	return fmtMo:getHasPets()
end

function FalCustomFmtMo:getPetMoListOfFmt(teamId)
	local petMoList = {}
	local fmtMo = self:getFormationMoByTeamId(teamId)

	for _, petId in ipairs(fmtMo:getHasPets()) do
		local petMo

		petId = checknumber(petId)

		if petId > 0 then
			petMo = fmtMo:_getPet(petId)
		end

		if petMo then
			table.insert(petMoList, petMo)
		end
	end

	return petMoList
end

function FalCustomFmtMo:getAllPetNumInFmt(teamId)
	local petIdList = self:getPetIdListOfFmt(teamId)

	return #petIdList
end

function FalCustomFmtMo:getMyPetNumInFmt(userId, roundId)
	roundId = checknumber(roundId)

	local petNum = 0
	local petMoList = self:getPetMoListOfFmt(self._falGameMo:getTeamId(userId))

	for _, petMo in ipairs(petMoList) do
		if petMo.falMo.userId == userId then
			if roundId == 0 then
				petNum = petNum + 1
			elseif petMo.falMo.roundId ~= roundId then
				petNum = petNum + 1
			end
		end
	end

	return petNum
end

return FalCustomFmtMo
