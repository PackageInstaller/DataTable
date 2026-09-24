local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_7 = table.insert
local var_0_8 = next

gamecore.UILoader:define("equip_attr", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_attrs_contents()
		self:show_equip_detail(arg_2_1)
	end

	function arg_1_0:set_attr(arg_3_1)
		for iter_3_0 = 1, #self._attr_contents do
			self._attr_contents[iter_3_0]:SetActive(false)
		end

		if not arg_3_1 or not var_0_8(arg_3_1) then
			return
		end

		for iter_3_1, iter_3_2 in ipairs((var_0_4:get_equip_attribute(arg_3_1.cid))) do
			if iter_3_1 <= #self._attr_contents then
				self._attr_contents[iter_3_1].title.text.text = var_0_4:get_equip_attribute_name(var_0_4.equip_attribute[iter_3_2.index])
				self._attr_contents[iter_3_1].num.text.text = var_0_4.equip_attribute[iter_3_2.index] == "range" and iter_3_2.count or iter_3_2.count > 0 and "+" .. iter_3_2.count or iter_3_2.count

				self._attr_contents[iter_3_1]:SetActive(true)
			end
		end
	end

	function arg_1_0:show_equip_detail(arg_4_1)
		self:set_attr(arg_4_1)

		self._control.name_mask.equipname.text.text = arg_4_1.title

		self._control.name_mask.textHorizonScroller:SetText(arg_4_1.title)

		self._control.content.text.text = arg_4_1.desc
	end

	function arg_1_0:__init_attrs_contents()
		local var_5_0 = var_0_2:getInstance("equip_list")
		local var_5_1 = var_0_2:getInstance("ship_detail")

		self._panel.transform:GetComponent("Canvas").sortingOrder = var_5_0 and var_5_0._panel.transform:GetComponent("Canvas").sortingOrder + 1 or var_5_1 and var_5_1._panel.transform:GetComponent("Canvas").sortingOrder + 1 or 503

		if self._is_already_init then
			return
		end

		local var_5_3 = self._control.attrs

		for iter_5_0 = 1, self._control.attrs.transform.childCount do
			var_0_7(self._attr_contents, var_5_3.transform:GetChild(iter_5_0 - 1).gameObject)
		end

		self._is_already_init = true
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_6_0)
	local var_6_0 = var_0_2:class("equip_attr")

	var_6_0._is_already_init = false
	var_6_0._attr_contents = {}

	gamecore.extend_obj(var_6_0)

	return var_6_0
end

return var_0_0
