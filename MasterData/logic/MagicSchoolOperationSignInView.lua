-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolOperationSignInView.lua

module("logic.extensions.magicschool.view.MagicSchoolOperationSignInView", package.seeall)

local MagicSchoolOperationSignInView = class("MagicSchoolOperationSignInView", OperationSignInView)

function MagicSchoolOperationSignInView:_getActivityId()
	local params = self:getOpenParam() or {}

	return checknumber(params[1])
end

return MagicSchoolOperationSignInView
