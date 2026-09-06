-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallPropAddBoardLen.lua

module("logic.extensions.pinball.view.PinBallPropAddBoardLen", package.seeall)

local PinBallPropAddBoardLen = class("PinBallPropAddBoardLen", PinBallProp)

function PinBallPropAddBoardLen:initExtParam(params)
	self._extParams = params

	local txtName = goutil.findChildTextComponent(self._propGo, "txtName")
	local len = 100

	if self._extParams then
		local paramArr = string.split(self._extParams, "_")

		len = checknumber(paramArr[1])
	end

	txtName.text = string.format("+%d", len)
end

function PinBallPropAddBoardLen:_useProp()
	local len = 100

	if self._extParams then
		local paramArr = string.split(self._extParams, "_")

		len = checknumber(paramArr[1])
	end

	PinBallBoardMgr.instance:addBoardLen(len)
end

return PinBallPropAddBoardLen
