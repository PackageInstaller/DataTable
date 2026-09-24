local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = {
	"__next__",
	"__prev__"
}

function var_0_0.skip_name_list(arg_1_0)
	return var_0_2
end

lx.define_class("list", function(arg_2_0)
	function arg_2_0:has(arg_3_1)
		for iter_3_0 in self:eachs() do
			if iter_3_0 == arg_3_1 then
				return true
			end
		end

		return false
	end

	function arg_2_0:erase()
		self:erase_itr()
	end
end, "list_base")

function var_0_0.create(arg_5_0)
	return (var_0_1.class("list", var_0_1.list_base:create()))
end

return var_0_0
