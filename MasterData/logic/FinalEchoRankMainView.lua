-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/finalecho/view/FinalEchoRankMainView.lua

module("logic.extensions.finalecho.view.FinalEchoRankMainView", package.seeall)

local FinalEchoRankMainView = class("FinalEchoRankMainView", TabFrameWorkMainView)

function FinalEchoRankMainView:_getFrameId()
	return 17
end

function FinalEchoRankMainView:_getDefaultHeadTabIdOfJump()
	return checknumber(self:getFirstParam())
end

return FinalEchoRankMainView
