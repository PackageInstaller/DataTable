local var_0_0 = 0.2
local var_0_1 = {
	scaling = false,
	manuallocking = false,
	shaking = false,
	delaylocking = false,
	movingY = false,
	working = false,
	moving = false,
	waiting = true,
	lerp = 0.2,
	scaningmap = false,
	center = 400,
	bound = {
		left = 50,
		right = 100
	},
	buffer = {
		left = 0,
		right = 50
	},
	speed = {
		x = 0,
		y = 0
	}
}
local tween = require("fight.tween")

function var_0_1:init()
	var_0_1.map = self.map
	var_0_1.bg = self.bg
	var_0_1.working = true

	var_0_1.resetActionStatus()
end

function var_0_1.getBaseConfig()
	return {
		center = var_0_1.center,
		bound = var_0_1.bound,
		buffer = var_0_1.buffer
	}
end

function var_0_1.reset()
	var_0_1.working = true
	var_0_1.waiting = true
	var_0_1.focusindex = nil
	var_0_1.focusoffset = nil
	var_0_1.speed.x = 0
	var_0_1.speed.y = 0

	var_0_1.resetActionStatus()
	var_0_1.map:setScale(1)
	var_0_1.setSafeAnchor(0)
	var_0_1.resetBgAfterShake()
end

function var_0_1.stop()
	var_0_1.working = false
	var_0_1.waiting = true
	var_0_1.focusindex = nil
	var_0_1.focusoffset = nil
	var_0_1.speed.x = 0
	var_0_1.speed.y = 0

	var_0_1.resetActionStatus()
	var_0_1.resetBgAfterShake()
end

function var_0_1.isworking()
	if not var_0_1.working then
		return false
	end

	if not var_0_1.waiting then
		return true
	end

	if FightManager.getFightType() == FIGHTTYPE_TOWER or FightManager.getFightType() == FIGHTTYPE_EXPEDITION_TOWER then
		if FightManager.getFightState() == FIGHTSTATUS_FIGHTING then
			var_0_1.waiting = false

			return true
		else
			return false
		end
	else
		local var_5_0 = FightManager.getForestPlayer()

		if not var_5_0 then
			return false
		end

		if FightManager.players[var_5_0]:getForwardBound() > var_0_1.center or FightManager.getFightState() == FIGHTSTATUS_FIGHTING then
			var_0_1.waiting = false

			return true
		else
			return false
		end
	end
end

function var_0_1.update(arg_6_0)
	if not var_0_1.isworking() then
		return
	end

	var_0_1.speed.y = 0

	if var_0_1.updateActions(arg_6_0) then
		return
	end

	var_0_1.updateCameraSpeed(arg_6_0)
	var_0_1.move()
end

function var_0_1.updateActions(arg_7_0)
	if var_0_1.shaking then
		var_0_1.updateShake(arg_7_0)
	end

	if var_0_1.scaningmap then
		var_0_1.updateScanFightWorldMap(arg_7_0)
	end

	if var_0_1.delaylocking then
		var_0_1.updateDelayLock(arg_7_0)
	end

	if var_0_1.scaling then
		var_0_1.updateScale(arg_7_0)
	end

	if var_0_1.movingY then
		var_0_1.updateMoveY(arg_7_0)
	end

	if var_0_1.moving then
		var_0_1.updateMove(arg_7_0)

		return true
	end

	if var_0_1.delaylocking or var_0_1.manuallocking then
		var_0_1.speed.x = 0

		var_0_1.move()

		return true
	end

	return false
end

function var_0_1.updateCameraSpeed(arg_8_0)
	local var_8_0, var_8_1 = var_0_1.getFocusObject()

	if not var_8_0 then
		var_0_1.speed.x = 0

		return
	end

	if var_8_0 > var_0_1.center + var_0_1.bound.right then
		var_0_1.speed.x = var_0_1.speed.x + (var_8_1 * arg_8_0 - var_0_1.speed.x) * var_0_0 + (var_8_0 - var_0_1.center) * arg_8_0 * var_0_0
	elseif var_8_0 < var_0_1.center - var_0_1.bound.left then
		var_0_1.speed.x = var_0_1.speed.x + (var_8_1 * arg_8_0 - var_0_1.speed.x) * var_0_0 + (var_8_0 - var_0_1.center) * arg_8_0
	elseif var_8_0 > var_0_1.center + var_0_1.buffer.right then
		if var_8_1 * arg_8_0 < 0 then
			var_0_1.speed.x = (var_8_0 - var_0_1.center) * arg_8_0 * var_0_0
		else
			speed_c = var_0_1.speed.x
			speed_c = speed_c + (var_8_1 * arg_8_0 - speed_c) * var_0_0
			var_0_1.speed.x = speed_c
		end
	elseif var_8_0 < var_0_1.center - var_0_1.buffer.left then
		if var_8_1 * arg_8_0 > 0 then
			var_0_1.speed.x = (var_8_0 - var_0_1.center) * arg_8_0 * var_0_0
		else
			speed_c = var_0_1.speed.x
			speed_c = speed_c + (var_8_1 * arg_8_0 - speed_c) * var_0_0
			var_0_1.speed.x = speed_c
		end
	else
		var_0_1.speed.x = 0
	end
end

function var_0_1.getFocusObject()
	if var_0_1.focusindex then
		local var_9_0 = FightManager.getCharacter(var_0_1.focusindex)

		if not var_9_0 then
			return nil
		end

		return var_9_0:getFocusForwardBound() + (var_0_1.center - 320) + var_9_0:getDirection() * (var_0_1.focusoffset or 0), (var_9_0:getSpeed())
	else
		local var_9_1 = FightManager.getCameraFocusPlayer()

		if not var_9_1 or not FightManager.players[var_9_1] then
			return nil
		end

		return FightManager.players[var_9_1]:getForwardBound(), (FightManager.players[var_9_1]:getSpeed())
	end
end

function var_0_1.getCameraSpeed()
	return var_0_1.speed.x
end

local var_0_3 = {
	1,
	1,
	0.6
}

function var_0_1.move()
	local var_11_0 = var_0_1.speed.x

	if var_0_1.speed.x ~= 0 then
		for iter_11_0, iter_11_1 in pairs(var_0_1.bg) do
			for iter_11_2 = 1, 3 do
				if var_11_0 > 0 then
					if iter_11_1[iter_11_2]:getPosition() <= -iter_11_1[iter_11_2]:getContentSize().width then
						iter_11_1[iter_11_2]:setPosition(cc.p(iter_11_1[iter_11_2]:getPositionX() + iter_11_1[iter_11_2]:getContentSize().width * 2, iter_11_1[iter_11_2]:getPositionY()))
					end
				elseif var_11_0 < 0 and iter_11_1[iter_11_2]:getPosition() >= iter_11_1[iter_11_2]:getContentSize().width then
					iter_11_1[iter_11_2]:setPosition(cc.p(iter_11_1[iter_11_2]:getPositionX() - iter_11_1[iter_11_2]:getContentSize().width * 2, iter_11_1[iter_11_2]:getPositionY()))
				end

				iter_11_1[iter_11_2]:setPosition(cc.p(iter_11_1[iter_11_2]:getPositionX() - var_11_0 * var_0_3[iter_11_2], iter_11_1[iter_11_2]:getPositionY()))
			end
		end

		FightManager.moveWorldMap(var_11_0)
	end

	if var_0_1.speed.y ~= 0 then
		var_0_1.map:setPositionY(var_0_1.map:getPositionY() - var_0_1.speed.y)
	end
end

function var_0_1:focus(arg_12_1, arg_12_2)
	arg_12_1 = arg_12_1 or 0.2

	var_0_1.moveTo(self:getFocusForwardBound() + (var_0_1.center - 320) + self:getDirection() * (arg_12_2 or 0), arg_12_1, "inOutQuad")

	var_0_1.focusindex = self.index
	var_0_1.focusoffset = arg_12_2
end

function var_0_1.unfocus()
	var_0_1.focusindex = nil
	var_0_1.focusoffset = nil
end

function var_0_1.resetActionStatus()
	var_0_1.moving = false
	var_0_1.movingY = false
	var_0_1.scaling = false
	var_0_1.delaylocking = false
	var_0_1.shaking = false
	var_0_1.manuallocking = false
	var_0_1.scaningmap = false
end

function var_0_1.lockCameraManual(arg_15_0)
	if var_0_1.focusindex then
		return
	end

	if var_0_1.scaningmap then
		return
	end

	if not FightManager.isWorldMapExist() then
		return
	end

	if not FightManager.isInCameraValidWorldMap(arg_15_0) then
		return
	end

	var_0_1.moveTo(FightManager.convertToGLSpace(arg_15_0), 0.1, "linear")

	var_0_1.manuallocking = true
end

function var_0_1.unlockCameraManual()
	var_0_1.manuallocking = false
end

local var_0_4 = 0
local var_0_5

function var_0_1.scanFightWorldMap(arg_17_0)
	if not FightManager.isWorldMapExist() then
		return
	end

	var_0_5 = arg_17_0
	var_0_4 = 0
	var_0_1.scaningmap = true

	var_0_1.lockcamera(1)
end

function var_0_1.updateScanFightWorldMap(arg_18_0)
	if not FightManager.isWorldMapExist() then
		var_0_4 = 0
		var_0_1.scaningmap = false
	end

	local var_18_0 = var_0_4

	var_0_4 = var_0_4 + arg_18_0

	if var_18_0 < 2 and var_0_4 >= 2 then
		var_0_1.moveTo(FightManager.convertToGLSpace(FightManager.getWorldMapSize()), 6, "inOutQuad")
	elseif var_18_0 < 8 and var_0_4 >= 8 then
		local var_18_1, var_18_2 = var_0_1.getFocusObject()

		if var_18_1 then
			var_0_1.moveTo(var_18_1, 3, "inOutQuad")
		else
			var_0_4 = 0
			var_0_1.scaningmap = false

			if var_0_5 then
				var_0_5()

				var_0_5 = nil
			end
		end
	elseif var_0_4 >= 11 then
		var_0_4 = 0
		var_0_1.scaningmap = false

		if var_0_5 then
			var_0_5()

			var_0_5 = nil
		end
	end
end

function var_0_1.isScaningFightWoldMap()
	return var_0_1.scaningmap
end

local var_0_6
local var_0_7
local var_0_8
local var_0_9
local var_0_10
local var_0_11
local var_0_12
local var_0_13

function var_0_1.moveTo(arg_20_0, arg_20_1, arg_20_2)
	var_0_6 = cc.p(0, 0)
	var_0_7 = cc.p(arg_20_0 - var_0_1.center, 0)
	var_0_8 = cc.p(0, 0)
	var_0_9 = tween.new(arg_20_1, var_0_6, var_0_7, arg_20_2)
	var_0_1.moving = true
end

function var_0_1.moveBy(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_0 = arg_21_0 or 0
	arg_21_1 = arg_21_1 or 0

	if arg_21_0 ~= 0 then
		var_0_6 = cc.p(0, 0)
		var_0_7 = cc.p(arg_21_0, 0)
		var_0_8 = cc.p(0, 0)
		var_0_9 = tween.new(arg_21_2, var_0_6, var_0_7, arg_21_3)
		var_0_1.moving = true
	end

	if arg_21_1 ~= 0 then
		var_0_10 = cc.p(0, 0)
		var_0_11 = cc.p(0, arg_21_1)
		var_0_12 = cc.p(0, 0)
		var_0_13 = tween.new(arg_21_2, var_0_10, var_0_11, arg_21_3)
		var_0_1.movingY = true
	end
end

function var_0_1.updateMove(arg_22_0)
	if var_0_9:update(arg_22_0) then
		var_0_1.moving = false
	end

	var_0_1.speed.x = var_0_6.x - var_0_8.x
	var_0_8.x = var_0_6.x

	var_0_1.move()
end

function var_0_1.updateMoveY(arg_23_0)
	if var_0_13:update(arg_23_0) then
		var_0_1.movingY = false
	end

	var_0_1.speed.y = var_0_1.speed.y + var_0_10.y - var_0_12.y
	var_0_12.y = var_0_10.y
end

local var_0_14
local var_0_15
local var_0_16 = 0
local var_0_17

function var_0_1.scaleTo(arg_24_0, arg_24_1, arg_24_2)
	arg_24_1 = arg_24_1 or 0.2
	var_0_14 = cc.p(var_0_1.map:getScaleX(), (var_0_1.map:getScaleY()))
	var_0_15 = cc.p(arg_24_0, arg_24_0)

	if arg_24_2 then
		var_0_16 = arg_24_2 / 700 or 0
	end

	var_0_17 = tween.new(arg_24_1, var_0_14, var_0_15, "inOutQuad")
	var_0_1.scaling = true
end

function var_0_1.updateScale(arg_25_0)
	if var_0_17:update(arg_25_0) then
		var_0_1.scaling = false
	end

	local var_25_0 = var_0_1.map:getScaleY()

	var_0_1.map:setScaleX(var_0_14.x)
	var_0_1.map:setScaleY(var_0_14.y)
	var_0_1.moveAnchor(var_0_16 or 0, var_25_0 - var_0_14.y)
end

local var_0_18 = GameDisplay.height * ORIGIN_FIGHT_HEIGHT / GameDisplay.origin_design_y - GameDisplay.fix_y

function var_0_1.moveAnchor(arg_26_0, arg_26_1)
	var_0_1.speed.y = var_0_1.speed.y + arg_26_0 * (GameDisplay.height - var_0_18) * arg_26_1
end

function var_0_1.setSafeAnchor(arg_27_0)
	var_0_1.map:setPositionY(arg_27_0 * (GameDisplay.height - var_0_18) * (1 - var_0_1.map:getScaleY()))
end

var_0_1.scale = var_0_1.scaleTo

local var_0_19 = 0

function var_0_1.lockcamera(arg_28_0)
	var_0_19 = arg_28_0
	var_0_1.delaylocking = true
end

function var_0_1.updateDelayLock(arg_29_0)
	var_0_19 = var_0_19 - arg_29_0

	if var_0_19 <= 0 then
		var_0_1.delaylocking = false
		var_0_19 = 0
	end
end

function var_0_1.unlockcamera()
	var_0_19 = 0
	var_0_1.delaylocking = false
end

local var_0_20
local var_0_21
local var_0_22
local var_0_23

function var_0_1:shake(arg_31_1, arg_31_2)
	arg_31_2 = arg_31_2 or 0.5
	arg_31_1 = arg_31_1 or 5
	var_0_20 = cc.p(0, 0)
	var_0_21 = cc.p(0, 0)
	var_0_22 = var_0_22 or cc.p(0, 0)
	var_0_23 = tween.new(arg_31_2, var_0_20, var_0_21, "shake", {
		x = {
			self.x,
			arg_31_1
		},
		y = {
			self.y,
			arg_31_1
		}
	})
	var_0_1.shaking = true
end

function var_0_1.updateShake(arg_32_0)
	if var_0_23:update(arg_32_0) then
		var_0_1.shaking = false
	end

	var_0_22.x = var_0_20.x
	var_0_22.y = var_0_20.y

	var_0_1.map:setPosition(cc.p(var_0_1.map:getPositionX() + (var_0_20.x - var_0_22.x), var_0_1.map:getPositionY() + (var_0_20.y - var_0_22.y)))
end

function var_0_1.resetBgAfterShake()
	var_0_1.map:setPosition(cc.p(320, 0))
end

return var_0_1
