local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_4 = gameconfig.item_config
local var_0_6 = gameconfig.furniture_config
local var_0_7 = gameconfig.cook_book_config
local var_0_8 = gameconfig.ship_cg_config
local var_0_9 = gameconfig.chat_head_config
local var_0_10 = gameconfig.sixth_adjutant_config
local var_0_12 = gameconfig.combats_shop_config
local var_0_13 = gameenum.common_type

gamecore.UILoader:define("specificdetails", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)

		self._enter_type = arg_2_2

		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__init_panel(arg_3_1)
		self._control.lv.gameObject:SetActive(false)
		self._control.equip_details:SetActive(false)
		self._control.attrs:SetActive(false)
		self._control.details:SetActive(true)

		self._panel.transform:GetComponent("Canvas").sortingOrder = 605

		if self._enter_type == var_0_13.enter_icon_detail_type.upgradeawards or self._enter_type == var_0_13.enter_icon_detail_type.sign or self._enter_type == var_0_13.enter_icon_detail_type.bootyshop_item or self._enter_type == var_0_13.enter_icon_detail_type.combatshop_item then
			if var_0_4.find_object_by_cid(arg_3_1) == nil then
				print("空的")

				return
			end

			self._control.specificname_mask:GetComponent("TextHorizonScroller"):SetText(var_0_4.find_object_by_cid(arg_3_1).title)

			local var_3_0 = var_0_4.find_object_by_cid(arg_3_1)

			self._control.details.text.text = arg_3_1 % 100 == 43 and var_3_0.desc or var_3_0.desc
		elseif self._enter_type == var_0_13.enter_icon_detail_type.bootyshop_furniture or self._enter_type == var_0_13.enter_icon_detail_type.combatshop_furniture then
			self._control.specificname_mask:GetComponent("TextHorizonScroller"):SetText(var_0_6.find_object_by_cid(arg_3_1).title)

			self._control.details.text.text = var_0_6.find_object_by_cid(arg_3_1).desc
		elseif self._enter_type == var_0_13.enter_icon_detail_type.bootyshop_cook or self._enter_type == var_0_13.enter_icon_detail_type.combatshop_cook then
			self._control.specificname_mask:GetComponent("TextHorizonScroller"):SetText(var_0_7.find_object_by_cid(arg_3_1).title)

			self._control.details.text.text = var_0_7.find_object_by_cid(arg_3_1).desc
		elseif self._enter_type == var_0_13.enter_icon_detail_type.bootyshop_cg or self._enter_type == var_0_13.enter_icon_detail_type.combatshop_cg then
			self._control.specificname_mask:GetComponent("TextHorizonScroller"):SetText(var_0_8.find_object_by_cid(arg_3_1).title)

			self._control.details.text.text = var_0_8.find_object_by_cid(arg_3_1).desc
		elseif self._enter_type == var_0_13.enter_icon_detail_type.combatshop_head then
			self._control.specificname_mask:GetComponent("TextHorizonScroller"):SetText(var_0_9.find_object_by_cid(arg_3_1).title)

			self._control.details.text.text = var_0_9.find_object_by_cid(arg_3_1).desc
		elseif self._enter_type == var_0_13.enter_icon_detail_type.combatshop_adjutant then
			self._control.specificname_mask:GetComponent("TextHorizonScroller"):SetText(var_0_10.find_object_by_id(arg_3_1).title)

			self._control.details.text.text = var_0_10.find_object_by_id(arg_3_1).desc
		elseif self._enter_type == var_0_13.enter_icon_detail_type.combatshop_exp_card then
			local var_3_1 = var_0_12.find_object_by_id(4024)

			self._control.specificname_mask:GetComponent("TextHorizonScroller"):SetText(var_3_1.title)

			self._control.details.text.text = var_0_1:convert_rich_text(var_3_1.desc)
		elseif self._enter_type == var_0_13.enter_icon_detail_type.combatshop_tactics_card then
			local var_3_2 = var_0_12.find_object_by_id(4025)

			self._control.specificname_mask:GetComponent("TextHorizonScroller"):SetText(var_3_2.title)

			self._control.details.text.text = var_0_1:convert_rich_text(var_3_2.desc)
		elseif var_0_13.enter_icon_detail_type.combatshop_equip then
			self._control.specificname_mask:GetComponent("TextHorizonScroller"):SetText(arg_3_1.title)
			self._control.equip_details:SetActive(true)
			self._control.details:SetActive(false)
			self._control.attrs:SetActive(true)

			self._control.equip_details.text.text = arg_3_1.desc

			self:set_attr(arg_3_1)
		end
	end

	function arg_1_0:set_attr(arg_4_1)
		self._attr_contents = {}

		for iter_4_0 = 1, self._control.attrs.transform.childCount do
			table.insert(self._attr_contents, self._control.attrs.transform:GetChild(iter_4_0 - 1).gameObject)
		end

		for iter_4_1 = 1, #self._attr_contents do
			self._attr_contents[iter_4_1]:SetActive(false)
		end

		if not arg_4_1 or not next(arg_4_1) then
			return
		end

		for iter_4_2, iter_4_3 in ipairs((var_0_13:get_equip_attribute(arg_4_1.cid))) do
			if iter_4_2 <= #self._attr_contents then
				self._attr_contents[iter_4_2].title.text.text = var_0_13:get_equip_attribute_name(var_0_13.equip_attribute[iter_4_3.index])
				self._attr_contents[iter_4_2].num.text.text = var_0_13.equip_attribute[iter_4_3.index] == "range" and iter_4_3.count or iter_4_3.count > 0 and "+" .. iter_4_3.count or iter_4_3.count

				self._attr_contents[iter_4_2]:SetActive(true)
			end
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_5_0)
	local var_5_0 = var_0_2:class("specificdetails")

	var_5_0._enter_type = nil
	var_5_0._attr_contents = nil

	return var_5_0
end

return var_0_0
