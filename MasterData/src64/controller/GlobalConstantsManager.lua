local GlobalConstantsManager = class("GlobalConstantsManager", (require("controller.base_manager")))

GlobalConstantsManager.MULTITON_MSG = "GlobalConstantsManager instancealready constructed!"

function GlobalConstantsManager:ctor()
	self.super.ctor(self)

	self.config = {}

	for iter_1_0, iter_1_1 in pairs((require("data.global_constants_data"))) do
		self.config[iter_1_1.id] = iter_1_1
	end
end

function GlobalConstantsManager:getValueById(arg_2_1)
	if self.config[arg_2_1] and self.config[arg_2_1].value then
		return self.config[arg_2_1].value
	end

	return nil
end

function GlobalConstantsManager:getConfigById(arg_3_1)
	if self.config[arg_3_1] then
		return self.config[arg_3_1]
	end

	return nil
end

return GlobalConstantsManager
