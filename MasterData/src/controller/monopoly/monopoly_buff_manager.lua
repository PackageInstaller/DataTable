local MonopolyBuffManager = class("MonopolyBuffManager", (require("controller.base_manager")))

MonopolyBuffManager.MULTITON_MSG = "MonopolyBuffManager instancealready constructed!"
MonopolyBuffManager.BUFF_TYPE = {
	DEBUFF = 2,
	BUFF = 1
}
MonopolyBuffManager.BUFF_VALUE_TYPE = {
	BUILD_INCOME = 2,
	BUILD_COST_GOLD = 5
}

local var_0_1 = tostring

function MonopolyBuffManager:ctor()
	MonopolyBuffManager.super.ctor(self)

	self._data = {}
	self._config = require("data/monopoly_buff_conf_data")
end

function MonopolyBuffManager:getConfigById(arg_2_1)
	return self._config[arg_2_1]
end

function MonopolyBuffManager:requestInfo(arg_3_1)
	return
end

function MonopolyBuffManager:handlerInfo(arg_4_1)
	return
end

function MonopolyBuffManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function MonopolyBuffManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function MonopolyBuffManager:getBuffEvent(arg_7_1)
	if self.layer then
		self.layer:getBuffEvent(arg_7_1)
	end
end

function MonopolyBuffManager:getBuffInfo()
	local var_8_0 = require("controller.monopoly.monopoly_manager"):getInstance():getBuffs()
	local var_8_1 = {}

	for iter_8_0 = 1, #var_8_0 do
		local var_8_2 = clone(self:getConfigById((var_0_1(var_8_0[iter_8_0].id))))

		var_8_2.remain = var_8_0[iter_8_0].remain
		var_8_1[#var_8_1 + 1] = var_8_2
	end

	table.sort(var_8_1, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0.remain
		local var_9_1 = arg_9_1.remain

		if arg_9_0.buff_or_debuff ~= arg_9_1.buff_or_debuff then
			return arg_9_0.buff_or_debuff < arg_9_1.buff_or_debuff
		elseif var_9_0 ~= var_9_1 then
			return var_9_0 < var_9_1
		else
			return false
		end
	end)

	return var_8_1
end

function MonopolyBuffManager:removeBuffsEvent(arg_10_1)
	if self.layer then
		self.layer:removeBuffsEvent(arg_10_1)
	end
end

function MonopolyBuffManager:buffRemainEvent(arg_11_1)
	if self.layer then
		self.layer:updateBuff()
	end
end

return MonopolyBuffManager
