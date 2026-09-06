-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/specialviews/ChuangkongPickAPet.lua

module("logic.extensions.challenge.view.specialviews.ChuangkongPickAPet", package.seeall)

local ChuangkongPickAPet = class("ChuangkongPickAPet", PickAPetInfoBase)

function ChuangkongPickAPet:ctor()
	ChuangkongPickAPet.super.ctor(self)

	self._gameType = PickAPetModel.GameType.ChuangkongUnion
	self._activityId = 0
	self._taskId = 0
	self._params = {}
end

function ChuangkongPickAPet:setActivityId(activityId)
	self._activityId = activityId
end

function ChuangkongPickAPet:setTaskId(taskId)
	self._taskId = taskId
end

function ChuangkongPickAPet:onGameOverCallback(callback)
	local num = PickAPetModel.instance:getCollect()
	local params = {}

	table.insert(params, num)

	local isSweep = false

	ChuangKongUnionAgent.instance:sendPM_CKUDoDailyTaskReq(self._activityId, self._taskId, isSweep, params)
	GameUtil.callBack(callback)
	self:doOnClose()
end

function ChuangkongPickAPet:getViewDesc()
	return "梵天真身"
end

function ChuangkongPickAPet:getIconName()
	return "icon_16000_fantian", "icon_10098_binglingwang"
end

return ChuangkongPickAPet
