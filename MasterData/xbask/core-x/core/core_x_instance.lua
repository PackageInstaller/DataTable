if _G.__core_x_instance__ then
	return
end

_G.__core_x_instance__ = {
	define_class_check_repeat = {},
	all_instance = {},
	all_class = {},
	all_method_meta_info = {},
	virtual_call = {},
	hot_update = {
		is_hot_update = false,
		hot_do_prefix = {}
	},
	other_module = {}
}
