-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/IceQiBuOperationSignInView.lua

module("logic.extensions.operationsignin.view.IceQiBuOperationSignInView", package.seeall)

local IceQiBuOperationSignInView = class("IceQiBuOperationSignInView", OperationSignInView)

function IceQiBuOperationSignInView:_getActivityId()
	local params = self:getOpenParam() or {}

	return checknumber(params[1])
end

return IceQiBuOperationSignInView
