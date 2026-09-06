-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/scroller/PassportScrollerTenSevenView.lua

module("logic.extensions.passport.view.scroller.PassportScrollerTenSevenView", package.seeall)

local PassportScrollerTenSevenView = class("PassportScrollerTenSevenView", PassportScrollerView)

function PassportScrollerTenSevenView:_getPassId()
	local passId = 0
	local data = self:getFirstParam()

	if data then
		if type(data) == "table" then
			passId = checkint(data.parameter)
		elseif type(data) == "number" or type(data) == "string" then
			passId = checkint(data)
		end
	end

	return passId
end

return PassportScrollerTenSevenView
