-- chunkname: @modules/logic/versionactivity1_2/jiexika/rpc/Activity114Rpc.lua

module("modules.logic.versionactivity1_2.jiexika.rpc.Activity114Rpc", package.seeall)

local Activity114Rpc = class("Activity114Rpc", BaseRpc)

function Activity114Rpc:sendGet114InfosRequest(actId, callback, callbackObj)
	local req = Activity114Module_pb.Get114InfosRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callbackObj)
end

function Activity114Rpc:onReceiveGet114InfosReply(resultCode, msg)
	if resultCode == 0 then
		Activity114Model.instance:onGetInfo(msg.activityId, msg.infos)
		Activity114FeaturesModel.instance:onFeatureListUpdate(msg.infos.features)
		Activity114TaskModel.instance:onGetTaskList(msg.act114Tasks)
	end
end

function Activity114Rpc:onReceiveAct114InfoPush(resultCode, msg)
	if resultCode == 0 then
		Activity114Model.instance:onGetInfo(msg.activityId, msg.infos)
		Activity114FeaturesModel.instance:onFeatureListUpdate(msg.infos.features)
	end
end

function Activity114Rpc:onReceiveAct114TaskPush(resultCode, msg)
	if resultCode == 0 then
		if Activity114Model.instance:isEnd() then
			return
		end

		Activity114TaskModel.instance:onTaskListUpdate(msg.act114Tasks, msg.deleteTasks)
	end
end

function Activity114Rpc:receiveTaskReward(actId, taskId)
	local req = Activity114Module_pb.ReceiveAct114TaskRewardRequest()

	req.activityId = actId
	req.taskId = taskId

	self:sendMsg(req)
end

function Activity114Rpc:onReceiveReceiveAct114TaskRewardReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity114Rpc:_clearNewUnLock()
	Activity114Model.instance.newUnLockFeature = {}
	Activity114Model.instance.newUnLockMeeting = {}
	Activity114Model.instance.newUnLockTravel = {}
end

function Activity114Rpc:eduRequest(actId, attrId, callback, callobj)
	local req = Activity114Module_pb.Act114EducateRequest()

	req.activityId = actId
	req.attrId = attrId

	self:_clearNewUnLock()
	self:sendMsg(req, callback, callobj)
end

function Activity114Rpc:onReceiveAct114EducateReply(resultCode, msg)
	if resultCode == 0 then
		local eventCo = Activity114Model.instance:getEventParams("eventCo")

		if not eventCo then
			return
		end

		if msg.isSuccess then
			if not Activity114Enum.Result.Success then
				local result = Activity114Enum.Result.Fail

				Activity114Model.instance:setEventParams("result", result)

				local storyId

				if msg.isSuccess then
					local arr = string.splitToNumber(eventCo.config.successStoryId, "#")

					if Activity114Model.instance.playedEduSuccessStory and arr then
						tabletool.removeValue(arr, Activity114Model.instance.playedEduSuccessStory)
					end

					if arr and #arr > 0 then
						storyId = arr[math.random(1, #arr)]
					end

					Activity114Model.instance.playedEduSuccessStory = storyId
				else
					storyId = eventCo.config.failureStoryId
				end

				Activity114Model.instance:setEventParams("storyId", storyId)
			end
		end
	end
end

function Activity114Rpc:travelRequest(actId, travelId)
	local req = Activity114Module_pb.Act114TravelRequest()

	req.activityId = actId
	req.travelId = travelId

	self:_clearNewUnLock()
	self:sendMsg(req)
end

function Activity114Rpc:onReceiveAct114TravelReply(resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:closeView(ViewName.Activity114TravelView)

		local mo = Activity114Model.instance.unLockTravelDict[msg.travelId]
		local co = Activity114Config.instance:getTravelCoList(Activity114Model.instance.id)[msg.travelId]

		if mo.hasSpecialEvent and co.specialEvents > 0 then
			local context = {
				type = Activity114Enum.EventType.Meet,
				eventId = co.specialEvents
			}

			Activity114Model.instance:beginEvent(context)

			return
		end

		local unLockEvents = Activity114Model.instance.unLockEventDict
		local events = string.splitToNumber(co.events, "#")
		local context = {
			type = Activity114Enum.EventType.Travel,
			eventId = mo.isBlock ~= 1 and events[mo.times + 1] and unLockEvents[events[mo.times + 1]] or co.residentEvent
		}

		Activity114Model.instance:beginEvent(context)
	end
end

function Activity114Rpc:meetRequest(actId, meetingId)
	local req = Activity114Module_pb.Act114MeetingRequest()

	req.activityId = actId
	req.meetingId = meetingId

	self:_clearNewUnLock()
	self:sendMsg(req)
end

function Activity114Rpc:onReceiveAct114MeetingReply(resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:closeView(ViewName.Activity114MeetView)

		local mo = Activity114Model.instance.unLockMeetingDict[msg.meetingId]
		local co = Activity114Config.instance:getMeetingCoList(Activity114Model.instance.id)[msg.meetingId]
		local events = string.splitToNumber(co.events, "#")
		local context = {
			type = Activity114Enum.EventType.Meet,
			eventId = events[mo.times + 1]
		}

		Activity114Model.instance:beginEvent(context)
	end
end

function Activity114Rpc:checkRequest(actId, isCheck, callback, callobj)
	local req = Activity114Module_pb.CheckEventRequest()

	req.activityId = actId
	req.isCheck = isCheck

	self:sendMsg(req, callback, callobj)
end

function Activity114Rpc:onReceiveCheckEventReply(resultCode, msg)
	if resultCode == 0 then
		local eventCo = Activity114Model.instance:getEventParams("eventCo")

		if not eventCo then
			return
		end

		local result, diceResult

		if eventCo.config.isCheckEvent == 0 then
			diceResult = nil
			result = Activity114Enum.Result.Success
		elseif msg.dices[1] then
			diceResult = msg.dices
			result = msg.isSuccess and Activity114Enum.Result.Success or Activity114Enum.Result.Fail
		else
			diceResult = nil
			result = Activity114Enum.Result.None
		end

		Activity114Model.instance:setEventParams("diceResult", diceResult)
		Activity114Model.instance:setEventParams("result", result)

		if Activity114Model.instance.serverData.testEventId <= 0 then
			ViewMgr.instance:closeView(ViewName.Activity114EventSelectView)
		else
			ViewMgr.instance:dispatchEvent(ViewEvent.OnCloseView, ViewName.Activity114EventSelectView)
		end
	end
end

function Activity114Rpc:keyDayRequest(actId, callback, callobj)
	local req = Activity114Module_pb.Act114KeyDayRequest()

	req.activityId = actId

	self:_clearNewUnLock()
	self:sendMsg(req, callback, callobj)
end

function Activity114Rpc:onReceiveAct114KeyDayReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity114Rpc:answerRequest(actId, choice, callback, callobj)
	local req = Activity114Module_pb.Act114TestRequest()

	req.activityId = actId
	req.choice = choice

	self:sendMsg(req, callback, callobj)
end

function Activity114Rpc:onReceiveAct114TestReply(resultCode, msg)
	if resultCode == 0 then
		Activity114Model.instance.serverData.currentTest = msg.currentTest

		if msg.successStatus ~= Activity114Enum.Result.NoFinish then
			Activity114Model.instance:setEventParams("result", msg.successStatus)
			Activity114Model.instance:setEventParams("totalScore", msg.score)
			ViewMgr.instance:closeView(ViewName.Activity114EventSelectView)
		else
			Activity114Model.instance:setEventParams("answerIds", Activity114Model.instance.serverData.testIds)
		end
	end
end

function Activity114Rpc:resetRequest(actId)
	local req = Activity114Module_pb.Act114ResetRequest()

	req.activityId = actId

	Activity114Model.instance:setResetRound()
	self:sendMsg(req)
end

function Activity114Rpc:onReceiveAct114ResetReply(resultCode, msg)
	if resultCode == 0 then
		Activity114Model.instance:endStat(false, true)
		Activity114Model.instance:beginStat()

		Activity114Model.instance.playedEduSuccessStory = nil

		Activity114Controller.instance:dispatchEvent(Activity114Event.OnEnterSchoolUpdate)
	end
end

function Activity114Rpc:restRequest(actId)
	local req = Activity114Module_pb.Act114RestRequest()

	req.activityId = actId

	self:_clearNewUnLock()

	Activity114Model.instance.preServerData = Activity114Model.instance.serverData

	self:sendMsg(req)
end

function Activity114Rpc:onReceiveAct114RestReply(resultCode, msg)
	if resultCode == 0 then
		local eventCo = Activity114Config.instance:getRestEventCo(msg.activityId, msg.successStatus)

		if not eventCo then
			logError("没有洁西卡休息事件配置" .. msg.activityId .. "  ++++ " .. msg.successStatus)

			return
		end

		local context = {
			type = Activity114Enum.EventType.Rest,
			eventId = eventCo.config.id,
			result = msg.successStatus,
			preAttention = Activity114Model.instance.preServerData.attention,
			nowDay = Activity114Model.instance.preServerData.day,
			nowRound = Activity114Model.instance.preServerData.round
		}

		Activity114Model.instance:beginEvent(context)
	end

	Activity114Model.instance.preServerData = nil
end

function Activity114Rpc:beforeBattle(actId)
	local req = Activity114Module_pb.BeforeAct114BattleRequest()

	req.activityId = actId

	self:sendMsg(req)
end

function Activity114Rpc:onReceiveBeforeAct114BattleReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity114Rpc:enterSchool(actId)
	local req = Activity114Module_pb.EnterSchoolRequest()

	req.activityId = actId

	self:sendMsg(req)
end

function Activity114Rpc:onReceiveEnterSchoolReply(resultCode, msg)
	if resultCode == 0 then
		Activity114Model.instance.serverData.isEnterSchool = true
	end
end

function Activity114Rpc:markRoundStory(actId, callback, callobj)
	local req = Activity114Module_pb.MarkRoundStoryRequest()

	req.activityId = actId

	self:sendMsg(req, callback, callobj)
end

function Activity114Rpc:onReceiveMarkRoundStoryReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function Activity114Rpc:markMeetingPlayUnlock(actId, mettingId)
	local req = Activity114Module_pb.MarkMeetingPlayUnlockRequest()

	req.activityId = actId
	req.meetingId = mettingId

	self:sendMsg(req)
end

function Activity114Rpc:onReceiveMarkMeetingPlayUnlockReply(resultCode, msg)
	if resultCode == 0 then
		local mo = Activity114Model.instance.unLockMeetingDict[msg.meetingId]

		mo.isPlayUnlock = 1

		Activity114Controller.instance:dispatchEvent(Activity114Event.UnLockRedDotUpdate)
	end
end

function Activity114Rpc:markTravelPlayUnlock(actId, travelId)
	local req = Activity114Module_pb.MarkTravelPlayUnlockRequest()

	req.activityId = actId
	req.travelId = travelId

	self:sendMsg(req)
end

function Activity114Rpc:onReceiveMarkTravelPlayUnlockReply(resultCode, msg)
	if resultCode == 0 then
		local mo = Activity114Model.instance.unLockTravelDict[msg.travelId]

		mo.isPlayUnlock = 1

		Activity114Controller.instance:dispatchEvent(Activity114Event.UnLockRedDotUpdate)
	end
end

function Activity114Rpc:markPhotoRed(actId)
	local req = Activity114Module_pb.MarkUnlockNewPhotoRedDotRequest()

	req.activityId = actId

	self:sendMsg(req)
end

function Activity114Rpc:onReceiveMarkUnlockNewPhotoRedDotReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

Activity114Rpc.instance = Activity114Rpc.New()

return Activity114Rpc
