-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/slackoffgame/model/SlackOffGameModel.lua

module("logic.extensions.slackoffgame.view.SlackOffGameModel", package.seeall)

local SlackOffGameModel = class("SlackOffGameModel", BaseModel)

SlackOffGameModel.bigImgFolderUrl = "ui/icon/items"

function SlackOffGameModel:onInit()
	self:onReset()
end

function SlackOffGameModel:onReset()
	self._activityInfo = {}
	self._serverKey = {}
end

function SlackOffGameModel:onPM_SlackOffGameInfoRes(msg)
	local pb = GameUtil.pbToTable(msg)

	self._activityInfo[pb.activityId] = pb
end

function SlackOffGameModel:onPM_SlackOffGameStartRes(msg)
	local pb = GameUtil.pbToTable(msg)

	self._serverKey[pb.activityId] = pb.serverKey
end

function SlackOffGameModel:getActivityInfo(activityId)
	if self._activityInfo and self._activityInfo[activityId] then
		return self._activityInfo[activityId]
	end
end

function SlackOffGameModel:getServerKey(activityId)
	if self._serverKey and self._serverKey[activityId] then
		return self._serverKey[activityId]
	end

	return 0
end

SlackOffGameModel.instance = SlackOffGameModel.New()

return SlackOffGameModel
