-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/model/plane/PlaneAction.lua

PlaneAction = PlaneAction or {}

local defaultTime = 600

function PlaneAction:getCompositePlaneAction(config, extraData, func)
	if not config then
		return
	end

	local compositeActions = {}

	for i = 1, #config do
		local data = config[i]
		local actionList = {}

		for j = 1, #data do
			local action = PlaneAction:getSinglePlaneAction(data[j], extraData)

			if action then
				actionList[#actionList + 1] = action
			end
		end

		if #actionList > 0 then
			compositeActions[#compositeActions + 1] = cc.Sequence:create(unpack(actionList))
		end
	end

	if #compositeActions > 0 then
		compositeActions[#compositeActions + 1] = cc.CallFunc:create(function()
			if func then
				func()
			end
		end)

		return cc.Sequence:create(unpack(compositeActions))
	end
end

function PlaneAction:getTargetPos(posData)
	local director = cc.Director:getInstance()
	local winSize = director:getWinSize()

	return cc.p(winSize.width * posData[1], winSize.height * posData[2])
end

local easeActionFunc = {
	EaseOut = function(action, time)
		return cc.EaseOut:create(action, time)
	end,
	EaseIn = function(action, time)
		return cc.EaseIn:create(action, time)
	end,
	EaseInOut = function(action, time)
		return cc.EaseInOut:create(action, time)
	end,
	EaseSineIn = function(action, time)
		return cc.EaseSineIn:create(action, time)
	end,
	EaseSineOut = function(action, time)
		return cc.EaseSineOut:create(action, time)
	end,
	EaseSineInOut = function(action, time)
		return cc.EaseSineInOut:create(action, time)
	end,
	EaseExponentialIn = function(action, time)
		return cc.EaseExponentialIn:create(action, time)
	end,
	EaseExponentialOut = function(action, time)
		return cc.EaseExponentialOut:create(action, time)
	end,
	EaseExponentialInOut = function(action, time)
		return cc.EaseExponentialInOut:create(action, time)
	end
}

function PlaneAction:getSinglePlaneAction(config, extraData, func)
	local owner = extraData.owner
	local meberType = extraData.type
	local action
	local factor = config.factor
	local time = (factor.time or defaultTime) / 1000

	if config.type == PlaneActionType.kMove then
		if not factor.point1 then
			local posConfig = {}
			local pos

			if #posConfig == 2 then
				pos = PlaneAction:getTargetPos(factor.point1)
			elseif #posConfig == 1 then
				local winSize = cc.Director:getInstance():getWinSize()
				local posX = posConfig[1] == 0 and 0 or winSize.width

				pos = cc.p(posX, owner:getPositionY())
			end

			if meberType == PlaneMemberType.kPlayerButtle then
				local director = cc.Director:getInstance()
				local winSizeWidth = director:getWinSize().width
				local speed = winSizeWidth / time

				time = (winSizeWidth - owner:getPositionX()) / speed
			elseif meberType == PlaneMemberType.kEnemyButtle then
				local director = cc.Director:getInstance()
				local winSizeWidth = director:getWinSize().width
				local speed = winSizeWidth / time

				time = owner:getPositionX() / speed
			end

			if pos then
				action = cc.MoveTo:create(time, pos)
			end
		end
	elseif config.type == PlaneActionType.kBezier then
		local bezire = {
			PlaneAction:getTargetPos(factor.point1),
			PlaneAction:getTargetPos(factor.point2),
			PlaneAction:getTargetPos(factor.point3)
		}

		action = cc.BezierTo:create(time, bezire)
	end

	if action then
		if config.accelerateType and easeActionFunc[config.accelerateType] then
			action = easeActionFunc[config.accelerateType](action, time)
		end

		return cc.Sequence:create(action, cc.CallFunc:create(function()
			if func then
				func()
			end
		end))
	end
end
