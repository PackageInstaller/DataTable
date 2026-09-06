-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/codeword/model/CodeWordModel.lua

module("logic.extensions.codeword.model.CodeWordModel", package.seeall)

local CodeWordModel = class("CodeWordModel", BaseModel)

CodeWordModel.channelTxt = {}

function CodeWordModel:onInit()
	self:onReset()
end

function CodeWordModel:onReset()
	self._infoList = {}
end

function CodeWordModel:onGetCodeWordInfoRes(msg)
	self._infoList = GameUtil.pbToTable(msg.infoList) or {}
end

function CodeWordModel:onNotifyCodeWordChangeRes(msg)
	self._infoList = GameUtil.pbToTable(msg.infoList) or {}
end

function CodeWordModel:onNotifyCodeWordPrizeRes(msg)
	for i, v in ipairs(self._infoList) do
		if msg.groupId == v.groupId and msg.id == v.id then
			v.dailyTimes = msg.dailyTimes
		end
	end
end

function CodeWordModel:getInfoList()
	return self._infoList
end

function CodeWordModel:getChannelTxtName(channelId)
	local id = checknumber(channelId)

	if id == 2 then
		return "本服"
	elseif id == 3 then
		return "家族"
	elseif id == 8 then
		return "全服"
	else
		return "nil"
	end
end

function CodeWordModel:getDailyTimes(groupId, id)
	for i, v in ipairs(self._infoList) do
		if groupId == v.groupId and id == v.id then
			return v.dailyTimes
		end
	end

	return 0
end

function CodeWordModel:getTotalPrizeTime(groupId, id)
	for i, v in ipairs(self._infoList) do
		if groupId == v.groupId and id == v.id then
			return v.totalPrizeTimes
		end
	end

	return 0
end

CodeWordModel.instance = CodeWordModel.New()

return CodeWordModel
