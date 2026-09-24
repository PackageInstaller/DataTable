local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = assert
local var_0_3 = {
	"__next__",
	"__prev__",
	"__list_who__"
}

function var_0_0.skip_name_list(arg_1_0)
	return var_0_3
end

lx.define_class("appendlist", function(arg_2_0)
	function arg_2_0.has(arg_3_0, arg_3_1)
		return arg_3_1.__list_who__ == arg_3_0
	end

	function arg_2_0:erase(arg_4_1)
		if arg_4_1 then
			if arg_4_1.__list_who__ ~= self then
				var_0_2(arg_4_1.__list_who__ == self)
			end

			self:__remove_node(arg_4_1)
		else
			self:erase_itr()
		end
	end

	function arg_2_0.__event_on__create_node(arg_5_0, arg_5_1)
		arg_5_1.__list_who__ = arg_5_0

		return arg_5_1
	end

	function arg_2_0.__event_on__remove_node(arg_6_0, arg_6_1)
		arg_6_1.__list_who__ = nil
	end

	function arg_2_0.__event_on__get_value(arg_7_0, arg_7_1)
		return arg_7_1
	end
end, "list_base")

function var_0_0.create(arg_8_0)
	return (var_0_1.class("appendlist", var_0_1.list_base:create()))
end

return var_0_0
