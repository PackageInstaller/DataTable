local ExpeditionBaseManager = class("ExpeditionBaseManager")
local var_0_1

function ExpeditionBaseManager:create()
	if var_0_1 == nil then
		var_0_1 = self.new()
	end

	return var_0_1
end

function ExpeditionBaseManager:ctor()
	return
end

function ExpeditionBaseManager:properties(arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		self[iter_3_0] = iter_3_1
	end
end

return ExpeditionBaseManager:create()
