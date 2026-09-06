-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/model/FunArenaModel.lua

module("logic.extensions.funarena.model.FunArenaModel", package.seeall)

local FunArenaModel = class("FunArenaModel", BaseModel)

function FunArenaModel:ctor()
	return
end

function FunArenaModel:onInit()
	self:onReset()
end

function FunArenaModel:onReset()
	self.activityId = 0

	local handle = GameUtil.handler(self.getPetMo, self)

	self.formationMO = FormationMO.New(handle)
	self.petMoMap = {}
	self.myForm = {}
	self.hasServerForm = false
	self._infoRes = {
		fightRound = 0,
		lotteryTimes = 0,
		bestWinStreakTimes = 0,
		lotteryScore = 0,
		fightTimes = 0,
		winState = {},
		winStreakPrizeGainState = {},
		propsBuffIds = {},
		funcBuffIds = {},
		enemyList = {},
		canGainBuffIds = {}
	}
	self._formRes = {}
	self._fightRes = {
		fightRound = 0,
		bestWinStreakTimes = 0,
		fightTimes = 0,
		btlResult = {},
		canGainBuffIds = {},
		winState = {}
	}
	self._lotteryRes = {
		prizeId = 0,
		changeSetId = 0
	}
	self._winStreakPrizeRes = {
		changeSetId = 0
	}
	self._viewRankRes = {
		myRank = 0,
		rankList = {}
	}
end

function FunArenaModel:onHandleGetInfoRes(msg)
	self.activityId = checknumber(msg.activityId)

	self:handleFormMsgRes(msg, "myForm")

	self._infoRes.fightTimes = checknumber(msg.fightTimes)
	self._infoRes.fightRound = checknumber(msg.fightRound)
	self._infoRes.winState = msg.winState
	self._infoRes.bestWinStreakTimes = checknumber(msg.bestWinStreakTimes)
	self._infoRes.lotteryTimes = checknumber(msg.lotteryTimes)
	self._infoRes.lotteryScore = checknumber(msg.lotteryScore)
	self._infoRes.winStreakPrizeGainState = msg.winStreakPrizeGainState
	self._infoRes.propsBuffIds = msg.propsBuffIds
	self._infoRes.funcBuffIds = msg.funcBuffIds
	self._infoRes.enemyList = msg.enemyList
	self._infoRes.canGainBuffIds = msg.canGainBuffIds
end

function FunArenaModel:onHandleSetFormRes(msg)
	self.activityId = checknumber(msg.activityId)

	self:handleFormMsgRes(msg, "form")
end

function FunArenaModel:handleFormMsgRes(msg, field)
	self.petMoMap = self:createPetMoMap()

	local form = msg[field]

	self.myForm = form

	local isHasField = msg:HasField(field)

	if isHasField and form then
		self.hasServerForm = true

		self.formationMO:SetData(self.myForm)
	else
		self.hasServerForm = false

		self.formationMO:ResetPosition()
	end

	self:updateCurForm()
end

function FunArenaModel:getCurFormMo()
	return self.formationMO
end

function FunArenaModel:getCurForm()
	return self.myForm
end

function FunArenaModel:updateCurForm()
	local simpleForm = self.formationMO:createFormPb()

	simpleForm.formId = 0
	self.myForm = simpleForm
end

function FunArenaModel:createPetMoMap()
	local map = {}
	local petCfg = FunArenaConfig.instance:getPetCfgsById(self.activityId)

	for _, data in ipairs(petCfg) do
		local mo = self:createPetMo(data)

		if mo ~= nil then
			map[mo.petId] = mo
		end
	end

	return map
end

function FunArenaModel:createPetMo(data)
	local mo = BagPetMo.New()

	mo.isMyPackPet = false
	mo.raceId = data.raceId
	mo.petId = data.creepsId
	mo.level = data.lv
	mo.awakeLevel = data.talentLv
	mo.talentLevel = data.talentLv

	if checknumber(data.faceId) == 0 then
		mo.curFaceId = mo.raceId or checknumber(data.faceId)
	end

	mo:setAttrMo()

	mo.summonMasterId = checknumber(data.summonMasterId)
	mo.summonedPetId = checknumber(data.summonedPetId)
	mo.equipments = {}

	local petCfg = FunArenaConfig.instance:getPetCfgsById(self.activityId)

	if not string.nilorempty(petCfg.equipments) then
		local arr = string.split(petCfg.equipments, ":")

		for i, defineId in ipairs(arr) do
			local eqCfg = EquipmentConfig.instance:GetEquipDefineInfoById(defineId)
			local obj = {}

			obj.positionId = i
			obj.defineId = eqCfg.defineId
			obj.lv = 0
			obj.levelExt = 0

			table.insert(mo.equipments, obj)
		end
	end

	mo.hideZdl = true

	mo:calcAllAttr()

	return mo
end

function FunArenaModel:getPetMo(petId)
	local mo = self.petMoMap[petId]

	if petId > 0 and mo == nil and BagPetsController.instance:getReady() then
		self.petMoMap = self:createPetMoMap()
		mo = self.petMoMap[petId]
	end

	return mo
end

function FunArenaModel:getAllShowPetList()
	local list = {}
	local map = self.petMoMap

	for _, mo in pairs(map) do
		if mo:isExist() then
			table.insert(list, mo)
		end
	end

	return list
end

function FunArenaModel:onHandleFightRes(msg)
	self.activityId = checknumber(msg.activityId)
	self._fightRes.btlResult = msg.btlResult
	self._fightRes.canGainBuffIds = msg.canGainBuffIds
	self._fightRes.fightTimes = checknumber(msg.fightTimes)
	self._fightRes.fightRound = checknumber(msg.fightRound)
	self._fightRes.winState = msg.winState
	self._fightRes.bestWinStreakTimes = checknumber(msg.bestWinStreakTimes)
	self._infoRes.canGainBuffIds = msg.canGainBuffIds
	self._infoRes.fightTimes = checknumber(msg.fightTimes)
	self._infoRes.fightRound = checknumber(msg.fightRound)
	self._infoRes.winState = msg.winState
	self._infoRes.bestWinStreakTimes = checknumber(msg.bestWinStreakTimes)
	self._infoRes.funcBuffIds = {}
end

function FunArenaModel:onHandleLotteryRes(msg)
	MaterialController.instance:saveChangeSetToTemp(checknumber(msg.changeSetId))

	self.activityId = checknumber(msg.activityId)
	self._lotteryRes.prizeId = checknumber(msg.prizeId)
	self._lotteryRes.changeSetId = checknumber(msg.changeSetId)

	local challengeCfg = FunArenaConfig.instance:getChallengeCfgById(self.activityId)

	if challengeCfg then
		local lotteryCost = checknumber(challengeCfg.lotteryCost)

		self._infoRes.lotteryScore = self._infoRes.lotteryScore - lotteryCost
		self._infoRes.lotteryTimes = self._infoRes.lotteryTimes + 1
	end
end

function FunArenaModel:onHandleGainWinStreakPrizeRes(msg)
	self.activityId = checknumber(msg.activityId)
	self._winStreakPrizeRes.changeSetId = checknumber(msg.changeSetId)
end

function FunArenaModel:onHandleViewRankRes(msg)
	self.activityId = checknumber(msg.activityId)
	self._viewRankRes.myRank = checknumber(msg.myRank)
	self._viewRankRes.rankList = msg.rankList
end

FunArenaModel.instance = FunArenaModel.New()

return FunArenaModel
