local var_0_0 = {}
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:MailUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__mail__action(iter_2_1.info, iter_2_1.action)
		end
	end

	function arg_1_0:__mail__action(arg_3_1, arg_3_2)
		if arg_3_2 == var_0_3.update_modify then
			self:update_mail_info(arg_3_1)
		elseif arg_3_2 == var_0_3.update_add then
			self:add_mail_info(arg_3_1)
		elseif arg_3_2 == var_0_3.update_remove then
			self:remove_mail_info(arg_3_1)
		end
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
