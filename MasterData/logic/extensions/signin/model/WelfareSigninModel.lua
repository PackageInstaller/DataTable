-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signin/model/WelfareSigninModel.lua

module("logic.extensions.signin.model.WelfareSigninModel", package.seeall)

local M = class("WelfareSigninModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self._signinAct = {}
end

function M:onReset()
	self._signinAct = {}
end

function M:updateSigninInfoLst(dataLst)
	local existActIdMap = {}

	if dataLst and #dataLst > 0 then
		for index, value in ipairs(dataLst) do
			self:updateSigninInfo(value, false)

			existActIdMap[value.activity] = 1
		end
	end

	for _activityId, _mo in pairs(self._signinAct) do
		if not existActIdMap[_activityId] and not _mo:getIsFakeData() then
			self._signinAct[_activityId] = nil

			printWarn(string.format("签到[%s]移除", _activityId))
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.SIGN_IN_INFO_CHANGE)
end

function M:updateSigninInfo(data, broadcastChange)
	local theMo

	if data == nil then
		return
	end

	local activityId = data.activity

	if not self._signinAct[activityId] then
		self._signinAct[activityId] = WelfareSigninMo.New()
	end

	theMo = self._signinAct[activityId]

	theMo:updateFromServer(data)

	if broadcastChange then
		GlobalDispatcher:dispatchEvent(EventType.SIGN_IN_INFO_CHANGE)
	end
end

function M:receiveReward(activityId, day)
	local signinMo = self._signinAct[activityId]

	signinMo:receiveReward(day)

	local clientDay = WelfareSigninUtil.server2ClientDay(day)

	GlobalDispatcher:dispatchEvent(EventType.SIGN_IN_RECEIVE_REWARD, activityId, clientDay)
end

function M:updateSigninInfoLstFromClient(dataLst)
	local existActIdMap = {}

	if dataLst and #dataLst > 0 then
		for index, value in ipairs(dataLst) do
			self:updateSigninInfoFromClient(value, false)

			existActIdMap[value:getActivity()] = 1
		end
	end

	for _activityId, _mo in pairs(self._signinAct) do
		if not existActIdMap[_activityId] and not _mo:getIsFakeData() then
			self._signinAct[_activityId] = nil

			printWarn(string.format("签到[%s]移除", _activityId))
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.SIGN_IN_INFO_CHANGE)
end

function M:updateSigninInfoFromClient(data, broadcastChange)
	if data == nil then
		return
	end

	local activityId = data:getActivity()

	if not self._signinAct[activityId] then
		self._signinAct[activityId] = WelfareSigninMo.New()
	end

	local theMo = self._signinAct[activityId]

	theMo:updateFromClient(data)

	if broadcastChange then
		GlobalDispatcher:dispatchEvent(EventType.SIGN_IN_INFO_CHANGE)
	end
end

function M:getSignInMo(activityId)
	return self._signinAct[activityId]
end

function M:printAllSignInAct()
	TableUtil.dump(self._signinAct)
end

function M:getDailySignInMo()
	local actId = WelfareSigninEnum.DailySignActId
	local actMo = self:getSignInMo(actId)

	if actMo == nil then
		printError(string.format("签到活动数据层无法找到[%d]的数据", actId))
	end

	return actMo
end

function M:getAllSignInMo()
	return self._signinAct
end

function M:getAllSevenSignInActMo()
	local list = {}

	if not WelfareUtil.isSystemOpen() then
		return list
	end

	local systemOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.WelfareSignInHistory, false)

	if not systemOpen then
		return list
	end

	local allMoLst = self:getAllSignInMo()

	for actId, welfareMo in pairs(allMoLst or {}) do
		if actId ~= WelfareSigninEnum.DailySignActId then
			local actMo = ActivityModel.instance:getActivityById(actId)

			if actMo and actMo:getIsOpen() then
				table.insert(list, welfareMo)
			end
		end
	end

	return list
end

function M:getSevenSignInActMoByFormula(formula)
	local theActMo
	local systemOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.WelfareSignInHistory, false)

	if not systemOpen then
		return theActMo
	end

	local allMoLst = self:getAllSignInMo()

	for actId, welfareMo in pairs(allMoLst or {}) do
		if actId ~= WelfareSigninEnum.DailySignActId then
			local actMo = ActivityModel.instance:getActivityById(actId)

			if actMo and actMo:getIsOpen() and actMo:getConfigId() == formula then
				theActMo = welfareMo

				break
			end
		end
	end

	return theActMo
end

function M:HasDailySignInAct()
	local actId = WelfareSigninEnum.DailySignActId

	if not WelfareSigninUtil.getSignInActIsOpen(actId) then
		return false
	end

	local signInMo = WelfareSigninModel.instance:getSignInMo(actId)

	if signInMo == nil then
		return false
	end

	return true
end

function M:getTotalSigned(actId)
	local actMo = self:getSignInMo(actId)

	if actMo then
		return actMo:getTotalSigned()
	else
		return 0
	end
end

function M:isItemSigned(actId, actTyp, day)
	local isSigned = false
	local actMo

	if actTyp == WelfareSigninEnum.ActTyp.DailySignIn then
		actMo = self:getSignInMo(actId)
	elseif actTyp == WelfareSigninEnum.ActTyp.SevenDaySignIn then
		actMo = self:getSignInMo(actId)
	else
		isSigned = true

		printError(string.format("未定义签到活动类型[%d],当前day=%d", actTyp, day))

		return isSigned
	end

	if actMo then
		isSigned = actMo:isSigned(day)
	else
		isSigned = true
	end

	return isSigned
end

function M:isCanReceive(actId, day)
	local actMo = self:getSignInMo(actId)

	if actMo then
		return actMo:isCanReceive(day)
	end

	return false
end

function M:isReceived(actId, day)
	local actMo = self:getSignInMo(actId)

	if actMo then
		return actMo:isReceived(day)
	end

	return false
end

function M:isAllReceive(actId)
	local actMo = self:getSignInMo(actId)

	if actMo then
		return actMo:isAllReceive()
	end

	return true
end

function M:getItemSignedTimeStamp(actTyp, day)
	local timeStamp = 0

	if actTyp == WelfareSigninEnum.ActTyp.DailySignIn then
		local actMo = self:getDailySignInMo()

		if actMo then
			timeStamp = actMo:getDayTimeStamp(day)
		end
	end

	return timeStamp
end

function M:playVoice(voiceName, actId, callBackFunc, callBackHandler)
	if not string.nilorempty(voiceName) then
		CriwareAudioFacade.instance:stopSoundByName(voiceName)

		if not self._voiceCBTable then
			self._voiceCBTable = {}
		end

		self._voice = voiceName

		if not self._voiceCBTable[voiceName] then
			self._voiceCBTable[voiceName] = {}
		end

		self._voiceCBTable[voiceName][actId] = {
			needCallBack = true,
			actId = actId,
			func = callBackFunc,
			handler = callBackHandler
		}

		CriwareAudioFacade.instance:playVoiceByName(self._voice, nil, self.playVoiceFinish, self)
	end
end

function M:stopVoice(voiceName, actId)
	if not string.nilorempty(voiceName) then
		local obj = self:_getVoiceCbCache(voiceName, actId)

		for _, value in pairs(self._voiceCBTable[voiceName] or {}) do
			if value.actId == actId then
				value.needCallBack = false
			end
		end

		CriwareAudioFacade.instance:stopSoundByName(voiceName)
	end
end

function M:playVoiceFinish()
	local objLst = self._voiceCBTable[self._voice]

	if objLst then
		for _, info in pairs(objLst) do
			if info.needCallBack then
				local actId = info.actId
				local callBackHandler = info.handler
				local callBackFunc = info.func

				callBackFunc(callBackHandler, actId)
			end
		end
	end

	CriwareAudioFacade.instance:stopSoundByName(self._voice)

	self._voiceCBTable[self._voice] = nil
	self._voice = nil
end

function M:_getVoiceCbCache(voiceName, actId)
	if not string.nilorempty(voiceName) then
		if not self._voiceCBTable then
			self._voiceCBTable = {}
		end

		if not self._voiceCBTable[voiceName] then
			self._voiceCBTable[voiceName] = {}
		end

		return self._voiceCBTable[voiceName][actId]
	end

	return nil
end

function M:setCacheItemMOList(dataList)
	local len = dataList and #dataList or 0

	if len > 0 then
		if not self._cacheItemMOList then
			self._cacheItemMOList = {}
		end

		for _, value in ipairs(dataList) do
			table.insert(self._cacheItemMOList, value)
		end
	else
		self._cacheItemMOList = {}
	end
end

function M:getCacheItemMOList()
	return self._cacheItemMOList or {}
end

M.instance = M.New()

return M
