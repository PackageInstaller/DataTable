-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallPropAddBall.lua

module("logic.extensions.pinball.view.PinBallPropAddBall", package.seeall)

local PinBallPropAddBall = class("PinBallPropAddBall", PinBallProp)

function PinBallPropAddBall:initExtParam(params)
	self._extParams = params

	local txtName = goutil.findChildTextComponent(self._propGo, "txtName")
	local addCount = 3

	if self._extParams then
		local paramArr = string.split(self._extParams, "_")

		addCount = checknumber(paramArr[1])
	end

	txtName.text = string.format("+%d", addCount)
end

function PinBallPropAddBall:_useProp()
	local addCount = 3

	if self._extParams then
		local paramArr = string.split(self._extParams, "_")

		addCount = checknumber(paramArr[1])
	end

	local boardData = PinBallBoardMgr.instance:getBoardData()
	local x = boardData.posX
	local y = boardData.topY + 40

	PinBallMgr.instance:createBall(addCount, x, y)
end

return PinBallPropAddBall
