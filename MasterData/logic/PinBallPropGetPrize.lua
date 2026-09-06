-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallPropGetPrize.lua

module("logic.extensions.pinball.view.PinBallPropGetPrize", package.seeall)

local PinBallPropGetPrize = class("PinBallPropGetPrize", PinBallProp)

function PinBallPropGetPrize:initExtParam(params)
	self._prizeIcon = goutil.findChild(self._propGo, "icon")
	self._extParams = params

	local txtName = goutil.findChildTextComponent(self._propGo, "txtName")
	local prizeId = 1
	local num = 1

	if self._extParams then
		local paramArr = string.split(self._extParams, "_")

		prizeId = checknumber(paramArr[1])
		num = math.max(checknumber(paramArr[2]), 1)
	end

	local activityId = PinBallController.instance:getActId()
	local prizeCfg = PinBallConfig.instance:getExtPrizeCfgById(activityId, prizeId)
	local matType, matId, matNum = MaterialMgr.getMatParams(prizeCfg.prize)

	txtName.text = string.format("%d", num)

	MaterialMgr.setIcon(self._prizeIcon, matType, matId, nil, nil)
end

function PinBallPropGetPrize:_useProp()
	local prizeId = 1
	local num = 1

	if self._extParams then
		local paramArr = string.split(self._extParams, "_")

		prizeId = checknumber(paramArr[1])
		num = math.max(checknumber(paramArr[2]), 1)
	end

	PinBallPropMgr.instance:addCurCollectPrizeMap(prizeId, num)
	GlobalDispatcher:dispatch(GlobalNotify.PinBallAddExtPrizeNum)
end

function PinBallPropGetPrize:reset()
	self._canUpdate = false

	if self._propGo then
		GameUtil.SetActive(self._propGo, false)
	end

	MaterialMgr.clearIcon(self._prizeIcon)
end

return PinBallPropGetPrize
