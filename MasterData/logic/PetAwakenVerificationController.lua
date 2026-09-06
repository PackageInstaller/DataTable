-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petawakenverification/controller/PetAwakenVerificationController.lua

module("logic.extensions.petawakenverification.controller.PetAwakenVerificationController", package.seeall)

local PetAwakenVerificationController = class("PetAwakenVerificationController", BaseController)

PetAwakenVerificationController.PETAWAKENVERDAYFIRSTCLICKREDPOINT = "PetAwakenVerDayFirstClickRedpoint"
PetAwakenVerificationController.PETAWAKENVERACTFIRSTCLICKREDPOINT = "PetAwakenVerActFirstClickRedpoint"

function PetAwakenVerificationController:ctor()
	return
end

function PetAwakenVerificationController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.dailyRefresh, self)
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self.startEnterGame, self)
	self:onReset()
end

function PetAwakenVerificationController:onReset()
	return
end

function PetAwakenVerificationController:onSendPetAwakenVerificationGetInfoReq(activityId)
	PetAwakenVerificationAgent.instance:sendPM_PetAwakenVerificationGetInfoReq(activityId)
end

function PetAwakenVerificationController:onHandlePetAwakenVerificationGetInfoRes(msg)
	PetAwakenVerificationModel.instance:onHandlePetAwakenVerificationGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PetAwakenVerificationOnUpdate)
end

function PetAwakenVerificationController:onSendPetAwakenVerificationGainPrizeReq(activityId, id, prizeId, petId)
	PetAwakenVerificationAgent.instance:sendPM_PetAwakenVerificationGainPrizeReq(activityId, id, prizeId, petId)
end

function PetAwakenVerificationController:onHandlePetAwakenVerificationGainPrizeRes(msg)
	PetAwakenVerificationModel.instance:onHandlePetAwakenVerificationGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PetAwakenVerificationGainPrize)
end

function PetAwakenVerificationController:startEnterGame()
	self:redPointRefresh()
end

function PetAwakenVerificationController:dailyRefresh()
	self:redPointRefresh()
end

function PetAwakenVerificationController:redPointRefresh()
	local activityDefineCfg = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.PetAwakenVer)

	for _, data in ipairs(activityDefineCfg) do
		local activityId = data.activityId
		local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.PetAwakenVer, activityId)

		if isInTime then
			self:ifPetAwakenVerificationDayFirstClickNeedRedThenShow(activityId)
			self:ifPetAwakenVerificationActFirstClickNeedRedThenShow(activityId)
		end
	end
end

function PetAwakenVerificationController:setPetAwakenVerificationDayFirstClickRedPoint(activityId, isActivated)
	isActivated = isActivated or false

	local key = self:getPetAwakenVerificationDayFirstClickRedPointKey(activityId)

	GameUtil.saveUserDayData(key, not isActivated)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PETAWAKENVERDAYFIRSTCLICK, isActivated)
end

function PetAwakenVerificationController:ifPetAwakenVerificationDayFirstClickNeedRedThenShow(activityId)
	local key = self:getPetAwakenVerificationDayFirstClickRedPointKey(activityId)

	local function handler(value)
		local isRecorded = value ~= nil and value ~= false
		local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.PetAwakenVer, activityId)
		local isActivated = not isRecorded and isInTime

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_PETAWAKENVERDAYFIRSTCLICK, isActivated)
	end

	GameUtil.getUserDayData(key, handler)
end

function PetAwakenVerificationController:getPetAwakenVerificationDayFirstClickRedPointKey(activityId)
	return PetAwakenVerificationController.PETAWAKENVERDAYFIRSTCLICKREDPOINT .. activityId
end

function PetAwakenVerificationController:setPetAwakenVerificationActFirstClickRedPoint(activityId, isActivated)
	isActivated = isActivated or false

	local key = self:getPetAwakenVerificationActFirstClickRedPointKey(activityId)

	GameUtil.saveUserData(key, not isActivated)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PETAWAKENVERACTFIRSTCLICK, isActivated)
end

function PetAwakenVerificationController:ifPetAwakenVerificationActFirstClickNeedRedThenShow(activityId)
	local key = self:getPetAwakenVerificationActFirstClickRedPointKey(activityId)

	local function handler(value)
		local isRecorded = value ~= nil and value ~= false
		local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.PetAwakenVer, activityId)
		local isActivated = not isRecorded and isInTime

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_PETAWAKENVERACTFIRSTCLICK, isActivated)
	end

	GameUtil.getUserData(key, handler)
end

function PetAwakenVerificationController:getPetAwakenVerificationActFirstClickRedPointKey(activityId)
	return PetAwakenVerificationController.PETAWAKENVERACTFIRSTCLICKREDPOINT .. activityId
end

function PetAwakenVerificationController:getPetAwakenAndPetIdByRaceId(raceId)
	local petMos = BagModel.instance:getBagPets()
	local petId = 0
	local maxAwakenLv = 0

	for _, mo in ipairs(petMos) do
		if raceId == mo.raceId and maxAwakenLv <= mo.awakeLevel then
			maxAwakenLv = mo.awakeLevel
			petId = mo.petId
		end
	end

	return petId, maxAwakenLv
end

function PetAwakenVerificationController:isPetAwakenActTimeTypeInTime(activityId, id)
	local petTimeType = self:getOnePetActTimeType(activityId, id)
	local actTimeType = self:getPetAwakenActTimeType(activityId)
	local isPetInTime = petTimeType == GameUtil.inTimePeriod
	local isActInTime = actTimeType == GameUtil.inTimePeriod

	return isPetInTime and isActInTime
end

function PetAwakenVerificationController:getOnePetActTimeType(activityId, id)
	local verPetData = PetAwakenVerificationConfig.instance:getPetAwakenVerPetCfgById(activityId, id)

	return (self:getActTimeType(verPetData.startTime, verPetData.endTime))
end

function PetAwakenVerificationController:getPetAwakenActTimeType(activityId)
	local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.PetAwakenVer, activityId)
	local actTimeType = GameUtil.errorTimePeriod

	if actCfg == nil then
		return actTimeType
	end

	actTimeType = self:getActTimeType(actCfg.startTime, actCfg.endTime)

	return actTimeType
end

function PetAwakenVerificationController:getActTimeType(startTime, endTime)
	return not string.nilorempty(startTime) and not string.nilorempty(endTime) and GameUtil.getTimePeriodType(startTime, endTime) or GameUtil.errorTimePeriod
end

function PetAwakenVerificationController:regRedAboutPetAwken(go, key)
	if go == nil or string.nilorempty(key) then
		return
	end

	local paramData = PetAwakenVerificationConfig.instance:getPetAwakenVerParamDicCfgs(key)

	if string.nilorempty(paramData.value) then
		return
	end

	local params = string.split(paramData.value, "#")
	local activityId = checknumber(params[1])
	local id = checknumber(params[2])

	if activityId == 0 then
		return
	end

	local verPetGoToCfg = PetAwakenVerificationConfig.instance:getPetAwakenVerGoToCfgs(activityId)
	local isInTime = false

	if id == 0 then
		local actTimeType = self:getPetAwakenActTimeType(activityId)

		isInTime = actTimeType == GameUtil.inTimePeriod
	else
		isInTime = self:isPetAwakenActTimeTypeInTime(activityId, id)
	end

	if isInTime == false then
		return
	end

	local redArr = {}

	for _, data in ipairs(verPetGoToCfg) do
		local arr = string.split(data.redId, "#")

		for _, str in ipairs(arr) do
			if not string.nilorempty(str) then
				table.insert(redArr, str)
			end
		end
	end

	table.insert(redArr, 199)
	table.insert(redArr, RedPointModel.ID_PETAWAKENVERACTFIRSTCLICK)
	RedPointController.instance:unregRedPoint(go)
	RedPointController.instance:regRedPoint(go, unpack(redArr))
end

function PetAwakenVerificationController:unRegRedAboutPetAwken(go)
	if go == nil then
		return
	end

	RedPointController.instance:unregRedPoint(go)
end

function PetAwakenVerificationController:funcOpenHandler(activityId, id)
	activityId = checknumber(activityId)
	id = checknumber(id)

	local isCurActInTime = false
	local tips = "该精灵未开放觉醒验证"

	if activityId > 0 then
		if id > 0 then
			local verPetCfg = PetAwakenVerificationConfig.instance:getPetAwakenVerPetCfgById(activityId, id)

			if not string.nilorempty(verPetCfg.startTime) and not string.nilorempty(verPetCfg.endTime) then
				local startTime, endTime = GameUtil.string2time(verPetCfg.startTime), GameUtil.string2time(verPetCfg.endTime)
				local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

				tips = string.format("<size=20>该精灵在%02d-%02d-%02d %02d:00至%02d-%02d-%02d %02d:00\n期间开放觉醒验证</size>", startDate.year, startDate.month, startDate.day, startDate.hour, endDate.year, endDate.month, endDate.day, endDate.hour)
			end

			isCurActInTime = self:isPetAwakenActTimeTypeInTime(activityId, id)
		else
			local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.PetAwakenVer, activityId)

			if actCfg and not string.nilorempty(actCfg.startTime) and not string.nilorempty(actCfg.endTime) then
				local startTime, endTime = GameUtil.string2time(actCfg.startTime), GameUtil.string2time(actCfg.endTime)
				local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

				tips = string.format("<size=20>该精灵在%02d-%02d-%02d %02d:00至%02d-%02d-%02d %02d:00\n期间开放觉醒验证</size>", startDate.year, startDate.month, startDate.day, startDate.hour, endDate.year, endDate.month, endDate.day, endDate.hour)
			end

			local timeType = self:getPetAwakenActTimeType(activityId)

			isCurActInTime = timeType == GameUtil.inTimePeriod
		end
	else
		local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.PetAwakenVer)

		if actCfg then
			isCurActInTime = true
		end
	end

	if not isCurActInTime then
		FloatWordMgr.instance:show(tips)

		return
	end

	if activityId > 0 then
		if id > 0 then
			UIStateManager.instance:push(ViewName.XiaoNuoBirthView, ViewName.PetAwakenVerificationView, activityId, id)
		else
			UIStateManager.instance:push(ViewName.XiaoNuoBirthView, ViewName.PetAwakenVerificationView, activityId)
		end
	else
		UIStateManager.instance:push(ViewName.XiaoNuoBirthView, ViewName.PetAwakenVerificationView)
	end
end

function PetAwakenVerificationController:gotoPetAwakenByKey(key)
	local paramData = PetAwakenVerificationConfig.instance:getPetAwakenVerParamDicCfgs(key)

	if string.nilorempty(paramData.value) then
		return
	end

	local params = string.split(paramData.value, "#")
	local activityId = checknumber(params[1])
	local id = checknumber(params[2])

	FuncOpenController.instance:openFunc(493, activityId, id)
end

PetAwakenVerificationController.instance = PetAwakenVerificationController.New()

return PetAwakenVerificationController
