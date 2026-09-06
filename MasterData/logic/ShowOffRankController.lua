-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showoff/controller/ShowOffRankController.lua

module("logic.extensions.showoff.controller.ShowOffRankController", package.seeall)

local ShowOffRankController = class("ShowOffRankController", BaseController)

function ShowOffRankController:onInit()
	self:onReset()
end

function ShowOffRankController:onReset()
	return
end

function ShowOffRankController:sendGetRankInfo(rankId, member)
	member = checknumber(member) == 0 and "" or tostring(member)

	ShowOffRankAgent.instance:sendPM_ShowOffRankViewReq(rankId, member)
end

function ShowOffRankController:onGetRankInfo(msg)
	ShowOffRankModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.SHOW_OFF_RANK_INFO_UPDATE)
end

ShowOffRankController.instance = ShowOffRankController.New()

return ShowOffRankController
