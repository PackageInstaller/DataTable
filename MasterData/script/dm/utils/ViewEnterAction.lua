-- chunkname: @/tmp/or_script/lua_compile/dm/utils/ViewEnterAction.lua

ViewEnterAction = ViewEnterAction or {}
ViewEnterActionType = {
	kFadeIn = "fadeIn",
	kWidthOff = "widthOff",
	kHeightOff = "widthOff"
}

function ViewEnterAction:runScroll(actionType, children, finishCallback)
	actionType = actionType or ViewEnterActionType.kFadeIn

	if ViewEnterAction[actionType] then
		ViewEnterAction[actionType](self, children, finishCallback)
	end
end

function ViewEnterAction:fadeIn(children, finishCallback)
	local time = 0.2

	time = time / 2

	for i = 1, #children do
		local cell = children[i]

		cell:stopAllActions()
		cell:setColorTransform(ColorTransform(1, 1, 1, 0))
		cell:runAction(DelayAction:create(function()
			cell:runAction(cc.Sequence:create(CascadeFadeTo:create(time, 1), cc.CallFunc:create(function()
				if i == #children and finishCallback then
					finishCallback()
				end

				if #children == i then
					-- block empty
				end
			end)))
		end, (i - 1) * 0.08))
	end
end

function ViewEnterAction:widthOff(children, finishCallback)
	local time = 0.16

	time = time / 2

	for i = 1, #children do
		local cell = children[i]
		local offsetX = 110

		cell:stopAllActions()
		cell:setColorTransform(ColorTransform(1, 1, 1, 0))
		cell:runAction(DelayAction:create(function()
			cell:offset(offsetX, 0)
			cell:runAction(cc.Sequence:create(CascadeFadeTo:create(time, 1), cc.CallFunc:create(function()
				if i == #children and finishCallback then
					finishCallback()
				end

				if #children == i then
					-- block empty
				end
			end)))

			local moveBy = cc.EaseSineOut:create(cc.MoveBy:create(time, cc.p(-offsetX, 0)))

			cell:runAction(moveBy)
		end, 0.01 + (i - 1) * 0.04))
	end
end

function ViewEnterAction:heightOff(children, finishCallback, param)
	param = param or {
		time = 0.036,
		count = 3
	}

	local frameTime = 0.036 or param.time

	frameTime = frameTime / 2

	for i = 1, #children do
		local cell = children[i]
		local offsetY = 160

		cell:stopAllActions()
		cell:setColorTransform(ColorTransform(1, 1, 1, 0))
		cell:runAction(DelayAction:create(function()
			cell:offset(0, -offsetY)

			local action1 = cc.EaseOut:create(cc.MoveBy:create(7 * frameTime, cc.p(0, 176)), 1.3)
			local action2 = cc.EaseOut:create(CascadeFadeTo:create(7 * frameTime, 1), 1.3)
			local spawn = cc.Spawn:create(action1, action2)
			local action3 = cc.EaseOut:create(cc.MoveBy:create(6 * frameTime, cc.p(0, -16)), 1.3)
			local callback = cc.CallFunc:create(function()
				if i == #children and finishCallback then
					finishCallback()
				end

				if #children == i then
					-- block empty
				end
			end)
			local seq = cc.Sequence:create(spawn, action3, callback)

			cell:runAction(seq)
		end, (i - 1) * (frameTime * param.count)))
	end
end

function ViewEnterAction:runOffSet(node, param, finishCallback)
	param = param or {
		time = 0.2,
		offPos = cc.p(0, 0)
	}

	local initPos = cc.p(node:getPosition())

	if not param.offPos then
		local offPos = cc.p(0, 0)

		if not param.time then
			local time = 0.2

			time = time / 2

			node:setColorTransform(ColorTransform(1, 1, 1, 0))
			node:runAction(CascadeFadeTo:create(time, 1))
			node:offset(param.offPos.x, param.offPos.y)

			local moveUpAct = cc.MoveTo:create(time, initPos)
			local callbackFunc = cc.CallFunc:create(function()
				if finishCallback then
					finishCallback()
				end
			end)

			node:runAction(cc.Sequence:create(moveUpAct, callbackFunc))
		end
	end
end

function ViewEnterAction:runScale(node, param, finishCallback)
	param = param or {
		scale = {
			0,
			0
		}
	}

	if not param.scale[1] then
		local scaleX = 1

		if not param.scale[2] then
			local scaleY = 1

			if not param.time then
				local time = 0.2

				time = time / 2

				local scaleTo = cc.ScaleTo:create(time, scaleX, scaleY)
				local callbackFunc = cc.CallFunc:create(function()
					if finishCallback then
						finishCallback()
					end
				end)

				node:runAction(cc.Sequence:create(scaleTo, callbackFunc))
			end
		end
	end
end

function ViewEnterAction:runFadeIn(node, param, finishCallback)
	param = param or {
		time = 0.3,
		initPos = cc.p(node:getPosition()),
		offPos = cc.p(0, 0)
	}

	if not param.time then
		local time = 0.3

		time = time / 2

		node:setColorTransform(ColorTransform(1, 1, 1, 0))
		node:runAction(CascadeFadeTo:create(time, 1))

		local delay = cc.DelayTime:create(time)
		local callbackFunc = cc.CallFunc:create(function()
			if finishCallback then
				finishCallback()
			end
		end)

		node:runAction(cc.Sequence:create(delay, callbackFunc))
	end
end
