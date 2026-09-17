FightHalo = class("FightHalo")
HALO_ALL_EMEMY = 1
HALO_ALL_PLAYER = 2
HALO_ENMEY_IN_AREA = 3
HALO_PLAYER_IN_AREA = 4

local trigger_manager = require("fight.trigger_manager")

function FightHalo.create(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	return (FightHalo.new(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6))
end

function FightHalo:ctor(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	self._listtype = arg_2_1
	self._source = arg_2_3
	self._statusadd = arg_2_2
	self._statusconfig = arg_2_5
	self._statustype = arg_2_5.exetype == 0 and REGISTER_STATUS or TRIGGER_STATUS

	self:initHaloConfig(arg_2_4, arg_2_6)

	self._influencelist = {}
	self._stack = 0

	self:addHalo()
end

function FightHalo:initHaloConfig(arg_3_1, arg_3_2)
	local var_3_0, var_3_1 = self._source:match("([^@]+)@(.+)")

	self._halotype = nil
	self._config = {}
	self._haloinfluence = arg_3_2.influence or 0
	self._halocd = nil

	if arg_3_2.public_cd then
		self._halocd = {
			cd = arg_3_2.public_cd,
			curcd = arg_3_2.public_cd
		}
	end

	local var_3_2 = arg_3_2.target
	local var_3_3 = arg_3_2.area

	if arg_3_2.target == 2 then
		if var_3_0 == "players" then
			self._halotype = HALO_ALL_PLAYER or HALO_ALL_EMEMY
		end

		self._config = {
			triggertbl = arg_3_1
		}
	elseif var_3_2 == 3 then
		if var_3_0 == "players" then
			self._halotype = HALO_PLAYER_IN_AREA or HALO_ENMEY_IN_AREA
		end

		self._config = {
			bound = {
				left = var_3_3.offset_left,
				right = var_3_3.offset_right
			},
			triggertbl = arg_3_1
		}
	elseif var_3_2 == 6 then
		if var_3_0 == "players" then
			self._halotype = HALO_ALL_EMEMY or HALO_ALL_PLAYER
		end

		self._config = {
			triggertbl = arg_3_1
		}
	elseif var_3_2 == 7 then
		if var_3_0 == "players" then
			self._halotype = HALO_ENMEY_IN_AREA or HALO_PLAYER_IN_AREA
		end

		self._config = {
			bound = {
				left = var_3_3.offset_left,
				right = var_3_3.offset_right
			},
			triggertbl = arg_3_1
		}
	elseif var_3_2 == 12 then
		if var_3_0 == "players" then
			self._halotype = HALO_ALL_PLAYER or HALO_ALL_ENEMY
		end

		self._config = {
			withoutself = true,
			triggertbl = arg_3_1
		}
	elseif var_3_2 == 13 then
		if var_3_0 == "players" then
			self._halotype = HALO_PLAYER_IN_AREA or HALO_ENMEY_IN_AREA
		end

		self._config = {
			withoutself = true,
			bound = {
				left = var_3_3.offset_left,
				right = var_3_3.offset_right
			},
			triggertbl = arg_3_1
		}
	end

	self._statusconfig.public_cd = self._halocd
end

function FightHalo:getHaloStack()
	return self._stack
end

function FightHalo:addHalo()
	self._stack = self._stack + 1

	for iter_5_0, iter_5_1 in pairs(self._influencelist) do
		self:addHaloInfluence(iter_5_0)
	end
end

function FightHalo:addHaloInfluence(arg_6_1)
	if self._statustype == TRIGGER_STATUS then
		self:registerHaloStatus(arg_6_1)

		return
	end

	local var_6_0 = self._statusconfig.execonfig.target

	if self._statusconfig.execonfig.target == OWNERSELF then
		self:registerHaloStatus(self._source)
	elseif var_6_0 == ALLTEAMMATE then
		local var_6_1 = FightManager.getCharacter(arg_6_1)

		if not var_6_1 or not var_6_1._instance then
			return
		end

		for iter_6_0, iter_6_1 in pairs((var_6_1:getAllTeammate())) do
			self:registerHaloStatus(iter_6_1.index)
		end
	elseif var_6_0 == ALLOPONENT then
		local var_6_2 = FightManager.getCharacter(arg_6_1)

		if not var_6_2 or not var_6_2._instance then
			return
		end

		for iter_6_2, iter_6_3 in pairs((var_6_2:getAllOponent())) do
			self:registerHaloStatus(iter_6_3.index)
		end
	else
		self:registerHaloStatus(arg_6_1)
	end
end

function FightHalo:registerHaloStatus(arg_7_1)
	if self._haloinfluence == 0 then
		local var_7_0 = FightManager.getCharacter(arg_7_1)

		if not var_7_0 or not var_7_0._instance then
			return
		end

		var_7_0:registerStatus(self._statusadd, self._listtype, self._source, self._statusconfig)
	elseif self._haloinfluence == 1 then
		local var_7_1 = FightManager.getCharacter(self._source)

		if not var_7_1 or not var_7_1._instance then
			return
		end

		var_7_1:registerStatus(self._statusadd, self._listtype, self._source, self._statusconfig)
	end
end

function FightHalo:removeHalo()
	self._stack = self._stack - 1

	for iter_8_0, iter_8_1 in pairs(self._influencelist) do
		self:removeHaloInfluence(iter_8_0)
	end

	return self._stack > 0
end

function FightHalo:removeHaloInfluence(arg_9_1)
	if self._statustype == TRIGGER_STATUS then
		self:unregisterHaloStatus(arg_9_1)

		return
	end

	local var_9_0 = self._statusconfig.execonfig.target

	if self._statusconfig.execonfig.target == OWNERSELF then
		self:unregisterHaloStatus(self._source)
	elseif var_9_0 == ALLTEAMMATE then
		local var_9_1 = FightManager.getCharacter(arg_9_1)

		if not var_9_1 or not var_9_1._instance then
			return
		end

		for iter_9_0, iter_9_1 in pairs((var_9_1:getAllTeammate())) do
			self:unregisterHaloStatus(iter_9_1.index)
		end
	elseif var_9_0 == ALLOPONENT then
		local var_9_2 = FightManager.getCharacter(arg_9_1)

		if not var_9_2 or not var_9_2._instance then
			return
		end

		for iter_9_2, iter_9_3 in pairs((var_9_2:getAllOponent())) do
			self:unregisterHaloStatus(iter_9_3.index)
		end
	else
		self:unregisterHaloStatus(arg_9_1)
	end
end

function FightHalo:unregisterHaloStatus(arg_10_1)
	if self._haloinfluence == 0 then
		local var_10_0 = FightManager.getCharacter(arg_10_1)

		if not var_10_0 or not var_10_0._instance then
			return
		end

		var_10_0:unregisterStatus(self._statusadd, self._listtype, self._source)
	else
		local var_10_1 = FightManager.getCharacter(self._source)

		if not var_10_1 or not var_10_1._instance then
			return
		end

		var_10_1:unregisterStatus(self._statusadd, self._listtype, self._source)
	end
end

function FightHalo:removeAllHalo()
	for iter_11_0, iter_11_1 in pairs(self._influencelist) do
		self:removeFromInfluenceList((FightManager.getCharacter(iter_11_0)))
	end

	self._stack = 0
end

function FightHalo:addToInfluenceList(arg_12_1)
	if not arg_12_1 or not arg_12_1._instance then
		return
	end

	if self._haloinfluence == 0 then
		for iter_12_0 = 1, self._stack do
			arg_12_1:registerStatus(self._statusadd, self._listtype, self._source, self._statusconfig)
		end
	elseif self._haloinfluence == 1 then
		local var_12_0 = FightManager.getCharacter(self._source)

		for iter_12_1 = 1, self._stack do
			var_12_0:registerStatus(self._statusadd, self._listtype, self._source, self._statusconfig)
		end
	end

	self._influencelist[arg_12_1.index] = true
end

function FightHalo:removeFromInfluenceList(arg_13_1)
	if not arg_13_1 or not arg_13_1._instance then
		return
	end

	if self._haloinfluence == 0 then
		for iter_13_0 = 1, self._stack do
			arg_13_1:unregisterStatus(self._statusadd, self._listtype, self._source)
		end
	elseif self._haloinfluence == 1 then
		local var_13_0 = FightManager.getCharacter(self._source)

		for iter_13_1 = 1, self._stack do
			var_13_0:unregisterStatus(self._statusadd, self._listtype, self._source)
		end
	end

	self._influencelist[arg_13_1.index] = nil
end

function FightHalo:onCharacterDied(arg_14_1)
	if self._influencelist[arg_14_1] then
		local var_14_0 = FightManager.getCharacter(arg_14_1)

		if var_14_0 then
			self:removeFromInfluenceList(var_14_0)
		else
			self._influencelist[arg_14_1] = nil
		end
	end
end

function FightHalo:update(arg_15_1)
	if self._halotype == HALO_ALL_EMEMY then
		self:updateHaloAllEnemy()
	elseif self._halotype == HALO_ALL_PLAYER then
		self:updateHaloAllPlayer()
	elseif self._halotype == HALO_ENMEY_IN_AREA then
		self:updateHaloEnemyInArea()
	elseif self._halotype == HALO_PLAYER_IN_AREA then
		self:updateHaloPlayerInArea()
	end

	if self._halocd and self._halocd.cd > self._halocd.curcd then
		self._halocd.curcd = self._halocd.curcd + arg_15_1
	end
end

function FightHalo:updateHaloAllEnemy()
	local var_16_0 = FightManager.getCharacter(self._source)

	if not var_16_0 then
		return
	end

	local var_16_1 = self._config.triggertbl

	for iter_16_0, iter_16_1 in pairs(FightManager.enemies) do
		if iter_16_1:getStatus() ~= STATUS_DIED and (not self._config.withoutself or self._source ~= iter_16_1.index) then
			if not self._influencelist[iter_16_1.index] then
				if not var_16_1 or trigger_manager.judge_conditions(var_16_1.conditions, var_16_1.param, var_16_1.target, var_16_0, iter_16_1) then
					self:addToInfluenceList(iter_16_1)
				end
			elseif var_16_1 and not trigger_manager.judge_conditions(var_16_1.conditions, var_16_1.param, var_16_1.target, var_16_0, iter_16_1) then
				self:removeFromInfluenceList(iter_16_1)
			end
		end
	end
end

function FightHalo:updateHaloAllPlayer()
	local var_17_0 = FightManager.getCharacter(self._source)

	if not var_17_0 then
		return
	end

	local var_17_1 = self._config.triggertbl

	for iter_17_0, iter_17_1 in pairs(FightManager.players) do
		if iter_17_1:getStatus() ~= STATUS_DIED and (not self._config.withoutself or self._source ~= iter_17_1.index) then
			if not self._influencelist[iter_17_1.index] then
				if not var_17_1 or trigger_manager.judge_conditions(var_17_1.conditions, var_17_1.param, var_17_1.target, var_17_0, iter_17_1) then
					self:addToInfluenceList(iter_17_1)
				end
			elseif var_17_1 and not trigger_manager.judge_conditions(var_17_1.conditions, var_17_1.param, var_17_1.target, var_17_0, iter_17_1) then
				self:removeFromInfluenceList(iter_17_1)
			end
		end
	end
end

function FightHalo:updateHaloEnemyInArea()
	local var_18_0 = FightManager.getCharacter(self._source)

	if not var_18_0 then
		return
	end

	local var_18_1 = var_18_0:getStandardPosition()

	for iter_18_0, iter_18_1 in pairs(FightManager.enemies) do
		if iter_18_1:getStatus() ~= STATUS_DIED and (not self._config.withoutself or self._source ~= iter_18_1.index) then
			if not self._influencelist[iter_18_1.index] then
				if iter_18_1:getStandardPosition() <= var_18_1 + self._config.bound.right and iter_18_1:getStandardPosition() >= var_18_1 - self._config.bound.left and (not self._config.triggertbl or trigger_manager.judge_conditions(self._config.triggertbl.conditions, self._config.triggertbl.param, self._config.triggertbl.target, var_18_0, iter_18_1)) then
					self:addToInfluenceList(iter_18_1)
				end
			elseif iter_18_1:getStandardPosition() > var_18_1 + self._config.bound.right or iter_18_1:getStandardPosition() < var_18_1 - self._config.bound.left or self._config.triggertbl and not trigger_manager.judge_conditions(self._config.triggertbl.conditions, self._config.triggertbl.param, self._config.triggertbl.target, var_18_0, iter_18_1) then
				self:removeFromInfluenceList(iter_18_1)
			end
		end
	end
end

function FightHalo:updateHaloPlayerInArea()
	local var_19_0 = FightManager.getCharacter(self._source)

	if not var_19_0 then
		return
	end

	local var_19_1 = var_19_0:getStandardPosition()

	for iter_19_0, iter_19_1 in pairs(FightManager.players) do
		if iter_19_1:getStatus() ~= STATUS_DIED and (not self._config.withoutself or self._source ~= iter_19_1.index) then
			if not self._influencelist[iter_19_1.index] then
				if iter_19_1:getStandardPosition() <= var_19_1 + self._config.bound.right and iter_19_1:getStandardPosition() >= var_19_1 - self._config.bound.left and (not self._config.triggertbl or trigger_manager.judge_conditions(self._config.triggertbl.conditions, self._config.triggertbl.param, self._config.triggertbl.target, var_19_0, iter_19_1)) then
					self:addToInfluenceList(iter_19_1)
				end
			elseif iter_19_1:getStandardPosition() > var_19_1 + self._config.bound.right or iter_19_1:getStandardPosition() < var_19_1 - self._config.bound.left or self._config.triggertbl and not trigger_manager.judge_conditions(self._config.triggertbl.conditions, self._config.triggertbl.param, self._config.triggertbl.target, var_19_0, iter_19_1) then
				self:removeFromInfluenceList(iter_19_1)
			end
		end
	end
end
