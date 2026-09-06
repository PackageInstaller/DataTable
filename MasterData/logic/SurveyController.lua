-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survey/controller/SurveyController.lua

module("logic.extensions.survey.controller.SurveyController", package.seeall)

local SurveyController = class("SurveyController", BaseController)

function SurveyController:init()
	self.SendInterval = ConstConfig.instance:getNumValueByKey("SendSurveyInterval")
	self._sendArray = {}

	self:onReset()

	self._isUseOnline = true

	local devJson = SDKManager.getDevJson()

	if string.nilorempty(devJson) then
		self._isUseOnline = false
	end
end

function SurveyController:onReset()
	self._allSurveyList = {}

	self:_disposeHttpCo()
	GameUtil.whenLocalDataInited(function()
		self:sendPM_SignForSdkSurveyReq()
	end)
end

function SurveyController:reportBehavior(behaviorId, ...)
	behaviorId = checknumber(behaviorId)

	if behaviorId == 0 then
		return
	end

	local key = behaviorId .. ""
	local behaviorParam = ...

	if behaviorParam ~= nil then
		behaviorParam = {
			...
		}

		for k, v in pairs(behaviorParam) do
			key = key .. "_" .. v
		end
	end

	local behaviorPB

	if self._sendArray[key] then
		behaviorPB = self._sendArray[key]
		behaviorPB.logCount = self._sendArray[key].logCount + 1
	else
		behaviorPB = SurveyExtension_pb.PM_Behavior()
		behaviorPB.behaviorId = behaviorId
		behaviorPB.logCount = 1

		if behaviorParam then
			for _, v in pairs(behaviorParam) do
				behaviorPB.behaviorParam:append(tostring(v))
			end
		end

		self._sendArray[key] = behaviorPB
	end
end

function SurveyController:startTick()
	if enableDebug then
		printInfo("启动行为统计----------------------")
	end

	Scheduler.addListener(self.SendInterval, self._checkSend, self, true)
end

function SurveyController:stopTick()
	if enableDebug then
		printInfo("停止行为统计----------------------")
	end

	Scheduler.removeListener(self._checkSend, self)
end

function SurveyController:_checkSend()
	local pbArray = {}

	for id, v in pairs(self._sendArray) do
		if v.logCount > 0 then
			local copy = SurveyExtension_pb.PM_Behavior()
			local serializeStr = v:SerializeToString()

			if enableDebug then
				printInfo("SurveyController:_checkSend() - report behavior info: id=" .. id .. ",logCount=" .. v.logCount)
			end

			copy:ParseFromString(serializeStr)
			table.insert(pbArray, #pbArray + 1, copy)

			self._sendArray[id].logCount = 0
		end
	end

	if #pbArray > 0 then
		SurveyAgent.instance:sendPM_RecordClientBehaviorReq(pbArray)
	end
end

function SurveyController:sendBehaviorRightNow(behaviorId, ...)
	behaviorId = checknumber(behaviorId)

	if behaviorId == 0 then
		return
	end

	local key = behaviorId .. ""
	local behaviorParam = ...

	if behaviorParam ~= nil then
		behaviorParam = {
			...
		}

		for k, v in pairs(behaviorParam) do
			key = key .. "_" .. v
		end
	end

	local behaviorPB = SurveyExtension_pb.PM_Behavior()

	behaviorPB.behaviorId = behaviorId
	behaviorPB.logCount = 1

	if behaviorParam then
		for _, v in pairs(behaviorParam) do
			behaviorPB.behaviorParam:append(tostring(v))
		end
	end

	local pbArray = {}

	table.insert(pbArray, behaviorPB)

	if #pbArray > 0 then
		SurveyAgent.instance:sendPM_RecordClientBehaviorReq(pbArray)
	end
end

function SurveyController:reqGetAllSurveyStates(handler, handlerTarget)
	SurveyAgent.instance:sendPM_GetAllSurveyStatesReq(self._onAllSurveyStateRes, self)
end

function SurveyController:_onAllSurveyStateRes(msg)
	return
end

function SurveyController:getAllSurveyList()
	return self._allSurveyList
end

function SurveyController:sendPM_SignForSdkSurveyReq()
	SurveyAgent.instance:sendPM_SignForSdkSurveyReq()
end

function SurveyController:onPM_SignForSdkSurveyReq(msg)
	local param = {}

	param.gameId = msg.gameId
	param.coChannelId = msg.coChannelId
	param.platformId = msg.platformId
	param.serverId = msg.serverId
	param.appCode = msg.appCode
	param.roleId = msg.roleId
	param.ext = msg.ext
	param.ext1 = msg.ext1
	param.ext2 = msg.ext2
	param.notifyUrl = msg.notifyUrl
	param.timestamp = checknumber(msg.timestamp)
	param.sign = msg.sign
	param.includeFinish = false

	self:sendGetHttpPosList(param, function(jsonString, url)
		local status, result = xpcall(function()
			local obj = GameUtil.jsonToTable(jsonString)

			if obj.code == 0 then
				self._allSurveyList = {}

				if obj.data and obj.data.surveyInfo and type(obj.data.surveyInfo) == "table" then
					self._allSurveyList = obj.data.surveyInfo
				end

				RedPointController.instance:setRedPointInfo(RedPointModel.ID_SURVEY_LIST, #self._allSurveyList > 0)
				GlobalDispatcher:dispatch(GlobalNotify.SURVEY_LIST_INFO_UPDATE)
			else
				printError(">>>>>问卷请求异常", url, obj.message)
			end
		end, function()
			printError(">>>>问卷返回解析异常", url)
		end)
	end)
end

function SurveyController:sendGetHttpPosList(param, callBack)
	local Type = System.Type
	local encodingType = Type.GetType("System.Text.Encoding,mscorlib")
	local utf8Property = tolua.getproperty(encodingType, "UTF8")
	local utf8Encoding = utf8Property:Get(nil, nil)
	local utf8Method = tolua.getmethod(utf8Encoding:GetType(), "GetBytes", typeof("System.String"))
	local dicType = typeof(System.Collections.Generic.Dictionary):MakeGenericType(typeof(System.String), typeof(System.String))
	local dicHeader = tolua.createinstance(dicType)

	dicHeader:Add("Content-Type", "application/json")

	local bodyJson = GameUtil.jsonToString(param)

	print(">>>>>>>>>>>>>问卷 Json ", bodyJson)

	local bytes = utf8Method:Call(utf8Encoding, bodyJson)
	local url = "https://survey.172tt.com/survey/v3/list"

	if not self._isUseOnline then
		url = "https://survey-user-test.100bt.com/survey/v3/list"
	end

	local header = dicHeader

	print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>问卷 url ", url)

	local www = UnityEngine.WWW(url, bytes, header)
	local startTime = os.clock()
	local timeout = 15

	self._httpCo = nil
	self._httpCo = coroutine.start(function()
		while not www.isDone do
			coroutine.step()

			if os.clock() - startTime > timeout then
				printError("问卷请求超时，未能在5秒内返回")
				self:_disposeHttpCo()

				return
			end
		end

		if www.isDone then
			print(">>>>>>>>>>>>>>>>>>问卷返回>>>>>>>>>\n", www.text)

			if callBack then
				callBack(www.text, url)
			end
		end

		self:_disposeHttpCo()
	end)
end

function SurveyController:_disposeHttpCo()
	if self._httpCo then
		coroutine.stop(self._httpCo)
	end

	self._httpCo = nil
end

SurveyController.instance = SurveyController.New()

return SurveyController
