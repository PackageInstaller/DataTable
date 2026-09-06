-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/codeword/controller/CodeWordController.lua

module("logic.extensions.codeword.controller.CodeWordController", package.seeall)

local CodeWordController = class("CodeWordController", BaseController)
local ChannelIdPriority = {
	nil,
	2,
	1,
	nil,
	nil,
	nil,
	nil,
	3
}

function CodeWordController:onGetCodeWordInfoRes(msg)
	CodeWordModel.instance:onGetCodeWordInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GetCodeWordInfoRes)
end

function CodeWordController:onNotifyCodeWordPrizeRes(msg)
	CodeWordModel.instance:onNotifyCodeWordPrizeRes(msg)
	MaterialController.instance:setChangeSetPopup(msg.changeSetId)
	GlobalDispatcher:dispatch(GlobalNotify.NotifyCodeWordPrizeRes)
end

function CodeWordController:onNotifyCodeWordChangeRes(msg)
	CodeWordModel.instance:onNotifyCodeWordChangeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.NotifyCodeWordChangeRes)
end

function CodeWordController:getChannelIdByPriority(channelIds)
	table.sort(channelIds, function(a, b)
		return ChannelIdPriority[checknumber(a)] > ChannelIdPriority[checknumber(b)]
	end)

	return checknumber(channelIds[1]) or 2
end

function CodeWordController:isExistAvailableCfgInTime()
	local list = CodeWordConfig.instance:getWordGroupList()

	for i, v in ipairs(list) do
		if GameUtil.checkIsInTimePeriod(v.startTime, v.endTime) then
			return true
		end
	end

	return false
end

CodeWordController.instance = CodeWordController.New()

return CodeWordController
