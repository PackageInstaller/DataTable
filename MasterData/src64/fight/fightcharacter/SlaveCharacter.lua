SlaveCharacter = class("SlaveCharacter", function(arg_1_0)
	return FightCharacter:create(arg_1_0, "slave")
end)

local model_manager = require("controller.model_manager")
local total_skill_data = require("data.total_skill_data")

local function var_0_2(arg_2_0, arg_2_1)
	local var_2_0 = model_manager.new()

	if arg_2_0.modelid then
		var_2_0:initSlaveCharacter(arg_2_0.modelid, arg_2_1:getAttribute("passiveLevel"))
	else
		var_2_0:initSlaveCharacter(arg_2_0.modelconf, arg_2_1:getAttribute("passiveLevel"))
	end

	return var_2_0
end

function SlaveCharacter.create(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = require("fight.slave." .. arg_3_2)
	local var_3_1 = SlaveCharacter.new((var_0_2(var_3_0, arg_3_1)))

	var_3_1:initSlave(arg_3_1, var_3_0)

	return var_3_1
end

function SlaveCharacter:initSlave(arg_4_1, arg_4_2)
	self._master = arg_4_1

	self:switchDirection(self._master:getDirection())

	self._slavedir = self._direction
	self._slaveoffset = arg_4_2.slave_offset
	self._slavezorder = arg_4_2.slave_zorder or 1

	self:setPosition(cc.p(self._slaveoffset.x * self._slavedir, self._slaveoffset.y))
	self:setLocalZOrder(self._slavezorder)
	self:initSlaveBasicHandlers()
end

function SlaveCharacter:joinFight(arg_5_1, arg_5_2)
	self.index = "slave" .. arg_5_1 .. "_" .. arg_5_2

	self:registerSlavePassiveSkill()
end

function SlaveCharacter:registerSlavePassiveSkill()
	local var_6_0 = self:getAttribute("passiveskill")

	if not var_6_0 then
		return
	end

	local var_6_1 = total_skill_data[var_6_0]

	while var_6_1["skill" .. 1] do
		self.statuspool:registerPassiveskill(var_6_1["skill" .. 1])
	end
end

function SlaveCharacter:getState()
	return self._master:getState()
end

function SlaveCharacter:getStatus()
	return self._master:getState()
end

function SlaveCharacter:getAttribute(arg_9_1)
	if self.model:isSlaveAttribute(arg_9_1) then
		return self.model:getAttribute(arg_9_1)
	else
		local var_9_0 = self._master:getAttribute(arg_9_1)

		if type(var_9_0) == "number" then
			return var_9_0 * self.model:getSlaveAttrFac(arg_9_1)
		else
			return var_9_0
		end
	end
end

function SlaveCharacter.addAttribute(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	return
end

function SlaveCharacter.setAttribute(arg_11_0, arg_11_1, arg_11_2)
	return
end

function SlaveCharacter.resetAttribute(arg_12_0, arg_12_1, arg_12_2)
	return
end

function SlaveCharacter.addExternAttribute(arg_13_0, arg_13_1, arg_13_2)
	return
end

function SlaveCharacter.refreshExternAttribute(arg_14_0)
	return
end

function SlaveCharacter:beHitted(arg_15_1)
	return self._master:beHitted(arg_15_1)
end

function SlaveCharacter:getRecovery(arg_16_1)
	return self._master:getRecovery(arg_16_1)
end

function SlaveCharacter:getStandardPosition()
	return self._master:getStandardPosition() + self._slavedir * self:getPositionX()
end

function SlaveCharacter:get2DPosition()
	local var_18_0, var_18_1 = self._master:get2DPosition()

	return var_18_0 + self._slavedir * self:getPositionX(), var_18_1 + self:getPositionY()
end

function SlaveCharacter:getAllOponent()
	return self._master:getAllOponent()
end

function SlaveCharacter:getAllTeammate()
	return self._master:getAllTeammate()
end

function SlaveCharacter:getAreaOponent(...)
	return self._master:getAreaOponent(...)
end

function SlaveCharacter:getAreaTeammate(...)
	return self._master:getAreaTeammate(...)
end

function SlaveCharacter:getNearestOponentPos()
	return self._master:getNearestOponentPos()
end

function SlaveCharacter:getCharacterHatred(arg_24_1)
	return self._master:getCharacterHatred(arg_24_1)
end

function SlaveCharacter:keepMoving()
	if self._lockmove then
		return
	end

	if self._playing then
		return
	end

	if not self._running then
		self._running = true
		self._distance = 0

		self.skeleton:setTimeScale(1)
		self:play("run")
	end
end

function SlaveCharacter:updateBehavior(arg_26_1)
	if self._movingForward then
		self._movingForward = false

		self.logic:updateFight()
	end
end

function SlaveCharacter:lock_target_pool(arg_27_1)
	if arg_27_1 == "all" then
		return true
	end

	local var_27_0 = arg_27_1 == "teammate" and 0 or 1

	if self.statuspool:checkStatus("addict") then
		var_27_0 = 1 - var_27_0
	end

	self._locktargetpool = var_27_0 == 0 and (self._master.charactertype == "player" and "players" or "enemies") or self._master.charactertype == "player" and "enemies" or "players"

	return true
end

function SlaveCharacter:addRageOnAttack(arg_28_1)
	self._master:addRageOnAttack(arg_28_1)
end

function SlaveCharacter:addRageByValue(arg_29_1)
	self._master:addRageByValue(arg_29_1)
end

function SlaveCharacter:update(arg_30_1)
	if self._globallock then
		return
	end

	if self._pause then
		return
	end

	self:updateHandlers(arg_30_1)
end
