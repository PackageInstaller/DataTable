local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.user
local var_0_5 = gameconfig.item_config
local var_0_6 = gamecore.Language
local var_0_7 = string.format
local var_0_8 = gameconfig.furniture_config
local var_0_9 = gameconfig.cook_book_config
local var_0_10 = gameconfig.ship_config
local var_0_11 = gameconfig.skin_config
local var_0_12 = Spine.Unity.SkeletonGraphic
local var_0_13 = UnityEngine.Shader
local var_0_14 = {
	open = "open",
	start = "stat",
	open_stand = "open_stand",
	stand = "stand"
}
local var_0_15 = {
	jump = "jump",
	open_box = "open_box1",
	stand = "stand1"
}

gamecore.UILoader:define("chest_open_layer", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:__onUpdate()
		if UnityEngine.Input.GetMouseButtonUp(0) then
			self._is_long_click_minus_btn = false
			self._is_long_click_plus_btn = false
		end

		if self._is_long_click_minus_btn then
			self:__click_minus_btn_event()
		end

		if self._is_long_click_plus_btn then
			self:__click_plus_btn_event()
		end
	end

	function arg_1_0.play_animation(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		if arg_4_4 then
			local var_4_0 = arg_4_1.state.Complete

			local function var_4_1()
				arg_4_4()

				arg_4_1.state.Complete = var_4_0
			end

			var_4_0 = arg_4_1.state.Complete + var_4_1
			arg_4_1.state.Complete = arg_4_1.state.Complete + var_4_1
			var_4_0 = var_4_0 - var_4_1
		end

		arg_4_1.AnimationState:SetAnimation(0, arg_4_2, arg_4_3)
	end

	function arg_1_0.play_skeGraphic_ani(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
		if arg_6_3 == "dance" and not arg_6_1.Skeleton.Data:FindAnimation(arg_6_3) then
			arg_6_3 = "stand1"
		end

		arg_6_1.AnimationState:SetAnimation(arg_6_2, arg_6_3, arg_6_5 or false)
		arg_6_1.AnimationState:Update(0)

		if arg_6_4 and not arg_6_5 then
			local var_6_0 = arg_6_1.AnimationState.Complete

			local function var_6_1()
				arg_6_4()

				arg_6_1.AnimationState.Complete = var_6_0
			end

			var_6_0 = arg_6_1.AnimationState.Complete + var_6_1
			arg_6_1.AnimationState.Complete = arg_6_1.AnimationState.Complete + var_6_1
			var_6_0 = var_6_0 - var_6_1
		end
	end

	function arg_1_0.show_layer(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		var_0_2:play_in_out_animation(arg_8_1, arg_8_2, arg_8_3)
	end

	function arg_1_0:set_sum_txt(arg_9_1)
		self._control.chest_info.sum.text.text = var_0_7("%02d", arg_9_1)
	end

	function arg_1_0:show_detail_by_cid()
		self._control.chest_info.quality.image.sprite = self:loadSprite(var_0_2:get_format_url(var_0_2.chest_b, self._now_click_chest_cid))
		self._control.chest_info.quality.icon.image.sprite = self:loadSprite(var_0_2:get_format_url(var_0_2.chest_icon, self._now_click_chest_cid))
		self._control.chest_info.scrollview.content.rectTransform.anchoredPosition = Vector2(self._control.chest_info.scrollview.content.rectTransform.anchoredPosition.x, 0)
		self._control.chest_info.scrollview.content.info_txt.text.text = var_0_5.find_object_by_cid(self._now_click_chest_cid).desc
		self._control.chest_info.name_txt.text.text = var_0_5.find_object_by_cid(self._now_click_chest_cid).title

		self:set_sum_txt(1)

		self._now_selected_chest_count = 1
		self._control.chest_info.have_sum.text.text = "" .. var_0_3:get_item_count(self._now_click_chest_cid)

		self:__show_max_get_furniture()
	end

	function arg_1_0.chest_click_event(arg_11_0, arg_11_1, arg_11_2)
		local var_11_0 = arg_11_1:Find("bg"):GetComponent("Button")

		var_11_0.onClick:RemoveAllListeners()
		var_11_0.onClick:AddListener(function()
			arg_11_0._now_click_chest_cid = arg_11_2

			arg_11_0:show_layer(arg_11_0._chest_layer_seq, false, function()
				arg_11_0._control.chest_layer:SetActive(false)
				arg_11_0:show_detail_by_cid()
				arg_11_0:show_layer(arg_11_0._chest_info_seq, true, nil)
			end)
		end)
	end

	function arg_1_0:init_chest_list()
		self._control.jump_warehouse:SetActive(false)

		self._open_box_once = false

		self._control.chest_layer:SetActive(true)
		self._control.chest_info:SetActive(false)
		self._control.chest_open:SetActive(false)
		self._control.chest_role_skip_btn:SetActive(false)
		self._control.chest_list:SetActive(false)
		self:show_layer(self._chest_layer_seq, true, nil)

		local var_14_0 = var_0_3:get_all_items_by_type(var_0_2.ship_item_type.chest)
		local var_14_1 = self._control.chest_layer.scrollview.content.transform:GetChild(0)

		for iter_14_0 = self._control.chest_layer.scrollview.content.transform.childCount, #var_14_0 - 1 do
			UnityEngine.Object.Instantiate(var_14_1.gameObject, self._control.chest_layer.scrollview.content.transform, false)
		end

		for iter_14_1 = 1, self._control.chest_layer.scrollview.content.transform.childCount do
			self._control.chest_layer.scrollview.content.transform:GetChild(iter_14_1 - 1).gameObject:SetActive(false)
		end

		for iter_14_2, iter_14_3 in ipairs(var_14_0) do
			if iter_14_3.count > 0 then
				local var_14_2 = self._control.chest_layer.scrollview.content.transform:GetChild(iter_14_2 - 1)

				var_14_2:Find("bg"):GetComponent("Image").sprite = self:loadSprite(var_0_2:get_format_url(var_0_2.chest_b, iter_14_3.id))
				var_14_2:Find("icon"):GetComponent("Image").sprite = self:loadSprite(var_0_2:get_format_url(var_0_2.chest_icon, iter_14_3.id))
				var_14_2:Find("count_txt"):GetComponent("Text").text = "" .. iter_14_3.count

				var_14_2:Find("name_bg"):GetComponent("TextScroller"):SetText(var_0_5.find_object_by_cid(iter_14_3.id).title)
				var_14_2.gameObject:SetActive(true)
				self:chest_click_event(var_14_2, iter_14_3.id)
			end
		end
	end

	function arg_1_0:init_chest_ske()
		self._chest_ske.skeletonDataAsset = self:loadSkeletonDataAsset(var_0_2:get_format_url(var_0_2.chest_ske, self._now_click_chest_cid <= 10342 and 1 or self._now_click_chest_cid <= 10742 and self._now_click_chest_cid > 10342 and 2 or self._now_click_chest_cid <= 10942 and self._now_click_chest_cid > 10742 and 3 or 4))

		self._chest_ske:Initialize(true)
	end

	function arg_1_0:show_chest_open()
		self:__show_max_get_furniture()

		if self._now_selected_chest_count <= 0 then
			self._control.jump_warehouse:SetActive(true)

			return
		end

		self._control.chest_info:SetActive(false)
		self._control.chest_open:SetActive(true)
		self._control.chest_role_skip_btn:SetActive(true)
		self:show_layer(self._chest_open_seq, true, nil)
		self:init_chest_ske()
		self:play_animation(self._chest_ske, var_0_14.start, false, function()
			self:play_animation(self._chest_ske, var_0_14.stand, true, nil)
		end)

		local var_16_0 = var_0_3:find_character_by_id(var_0_3:get_use_info_data().secretary)
		local var_16_1 = var_0_10.find_object_by_cid(var_16_0.cid).pic_id

		if var_16_0.skin ~= 0 then
			var_16_1 = var_0_11.find_object_by_cid(var_16_0.skin).icon
		end

		local var_16_2 = self:loadSkeletonDataAsset(var_0_2:get_ship_spine(var_0_2.common_icon.common_ship_q_asset, var_16_1))

		self._role_ske = self._role_obj:GetComponent(typeof(var_0_12)) or self._role_obj:AddComponent(typeof(var_0_12))
		self._role_ske.skeletonDataAsset = var_16_2
		self._role_ske.material = self:loadMaterial(var_0_2:get_ship_spine(var_0_2.common_icon.common_ship_q_mat, var_16_1))
		self._role_ske.material.shader = var_0_13.Find("Spine/SkeletonGraphic (Premultiply Alpha)")
		self._role_ske.initialSkinName = "normal"
		self._role_ske.startingLoop = false
		self._role_ske.startingAnimation = "stand1"
		self._role_ske.raycastTarget = false

		self._role_ske:Initialize(true)
		self:play_skeGraphic_ani(self._role_ske, 0, var_0_15.stand, nil, true)
	end

	function arg_1_0:click_chest_event(arg_18_1)
		self._open_box_once = true

		if arg_18_1 then
			self:play_animation(self._chest_ske, var_0_14.open_stand, true, nil)
			self:play_skeGraphic_ani(self._role_ske, 0, var_0_15.jump, nil, true)
			var_0_3:req_UseItemBox({
				id = self._now_click_chest_cid,
				count = self._now_selected_chest_count
			})
		else
			self:play_animation(self._chest_ske, var_0_14.open, false, function()
				self:play_animation(self._chest_ske, var_0_14.open_stand, false, function()
					self:play_animation(self._chest_ske, var_0_14.open_stand, true, nil)
					self:play_skeGraphic_ani(self._role_ske, 0, var_0_15.jump, nil, true)
					var_0_3:req_UseItemBox({
						id = self._now_click_chest_cid,
						count = self._now_selected_chest_count
					})
				end)
			end)
			self:play_skeGraphic_ani(self._role_ske, 0, var_0_15.open_box, function()
				self:play_skeGraphic_ani(self._role_ske, 0, var_0_15.stand, nil, true)
			end)
		end
	end

	function arg_1_0.init_chest_result_by_type(arg_22_0, arg_22_1, arg_22_2)
		local var_22_0 = {}

		if arg_22_2 == var_0_2.reward_type.furniture then
			local var_22_1 = var_0_8.find_object_by_cid(arg_22_1).icon

			var_22_0.bg_url = var_0_2:get_format_url(var_0_2.furniture_bg, var_0_8.find_object_by_cid(arg_22_1).star)
			var_22_0.icon_url = string.format(var_0_2.furniture_s_img, var_22_1, var_22_1)
			var_22_0.name = var_0_8.find_object_by_cid(arg_22_1).title
			var_22_0.is_special = var_0_8.find_object_by_cid(arg_22_1).star > 4
		elseif arg_22_2 == var_0_2.reward_type.cook_book then
			var_22_0.bg_url = var_0_2:get_format_url(var_0_2.food_quality_s, var_0_9.find_object_by_cid(arg_22_1).star)
			var_22_0.icon_url = var_0_2:get_format_url(var_0_2.cook_book_icon, var_0_9.find_object_by_cid(arg_22_1).icon)
			var_22_0.name = var_0_9.find_object_by_cid(arg_22_1).title
			var_22_0.is_special = var_0_9.find_object_by_cid(arg_22_1).star > 2
		end

		return var_22_0
	end

	function arg_1_0:init_chest_result(arg_23_1)
		self._box_result_tb = lx.clone_table(arg_23_1)

		self._control.chest_list.chest.gameObject:SetActive(true)

		self._chest_cell_list = {}

		for iter_23_0 = 1, #arg_23_1 do
			local var_23_0, var_23_1 = self:loadUIPrefab("chest_cell", self._control.chest_list.chest.rectTransform)

			var_23_0:setVisible(true)
			table.insert(self._chest_cell_list, var_23_1)
		end

		for iter_23_1, iter_23_2 in pairs(arg_23_1) do
			local var_23_2 = self:init_chest_result_by_type(iter_23_2.id, iter_23_2.type)

			self._chest_cell_list[iter_23_1].bg.image.sprite = self:loadSprite(var_23_2.bg_url)
			self._chest_cell_list[iter_23_1].bg.icon.image.sprite = self:loadSprite(var_23_2.icon_url)

			self._chest_cell_list[iter_23_1].bg.icon.image:SetNativeSize()
			self._chest_cell_list[iter_23_1].name_mask:GetComponent("TextScroller"):SetText(var_23_2.name)
			self._chest_cell_list[iter_23_1].new_lable.gameObject:SetActive(iter_23_2.is_new)
			self._chest_cell_list[iter_23_1].bg.lock_icon.gameObject:SetActive(iter_23_2.lock)
			self._chest_cell_list[iter_23_1].special_ske.gameObject:SetActive(var_23_2.is_special)
			self._chest_cell_list[iter_23_1].info_button.button.onClick:RemoveAllListeners()
			self._chest_cell_list[iter_23_1].info_button.button.onClick:AddListener(function()
				if iter_23_2.type == 5 then
					var_0_1:createInstance("furniture_detail_panel"):show({
						cid = iter_23_2.id,
						lock = iter_23_2.lock,
						id = iter_23_2.item_id
					})

					local var_24_0 = var_0_1:getInstance("chest_open_layer")

					if var_24_0 then
						var_0_1:getInstance("furniture_detail_panel")._panel.transform:GetComponent("Canvas").sortingOrder = var_24_0._panel.transform:GetComponent("Canvas").sortingOrder + 101
					end
				elseif iter_23_2.type == 6 then
					var_0_1:createInstance("restaurant_cookinfo"):show(1, iter_23_2.id, false, false, var_0_2.enter_restaurant_type.get_info)
				end
			end)
		end
	end

	function arg_1_0:chest_open_result(arg_25_1)
		self._control.chest_list:SetActive(true)
		self._control.chest_list.chest:SetActive(false)
		self:show_layer(self._chest_list_seq, true, function()
			self:init_chest_result(arg_25_1)
			self._control.chest_list.chest:SetActive(true)
		end)
	end

	function arg_1_0:__show_max_get_furniture()
		local var_27_0 = var_0_3:get_dormitory_furniture()
		local var_27_1 = var_0_3:get_furniture_warehouse_capacity()

		if var_27_1 - #var_27_0 <= self._now_selected_chest_count then
			self._now_selected_chest_count = var_27_1 - #var_27_0 or self._now_selected_chest_count
		end

		local var_27_2 = var_27_1 - #var_27_0 < 10

		self._control.chest_info.max_can_get_furniture_bg:SetActive(var_27_1 - #var_27_0 < 10)

		if var_27_2 then
			self._control.chest_info.max_can_get_furniture_bg.txt.text.text = var_27_1 - #var_27_0 > 0 and var_0_7(var_0_6:getNowLang("open_chest_tip"), var_27_1 - #var_27_0) or var_0_7(var_0_6:getNowLang("funitureisfull"))
		end
	end

	function arg_1_0:__click_minus_btn_event()
		local var_28_0 = var_0_3:get_furniture_warehouse_capacity() - #var_0_3:get_dormitory_furniture()
		local var_28_1 = var_0_3:get_item_count(self._now_click_chest_cid)
		local var_28_2 = var_28_1 > 10 and 10 or var_28_1

		var_28_2 = var_28_0 < (var_28_1 > 10 and 10 or var_28_1) and var_28_0 or var_28_2
		self._now_selected_chest_count = self._now_selected_chest_count - 1

		if self._now_selected_chest_count < 1 then
			self._now_selected_chest_count = var_28_0 > 0 and var_28_2 or 1
		end

		if var_28_0 ~= 0 then
			self:set_sum_txt(self._now_selected_chest_count)
		end
	end

	function arg_1_0:__click_plus_btn_event()
		local var_29_0 = var_0_3:get_furniture_warehouse_capacity() - #var_0_3:get_dormitory_furniture()
		local var_29_1 = var_0_3:get_item_count(self._now_click_chest_cid)
		local var_29_2 = var_29_1 > 10 and 10 or var_29_1

		var_29_2 = var_29_0 < (var_29_1 > 10 and 10 or var_29_1) and var_29_0 or var_29_2
		self._now_selected_chest_count = self._now_selected_chest_count + 1

		if var_29_2 < self._now_selected_chest_count then
			self._now_selected_chest_count = 1
		end

		if var_29_0 ~= 0 then
			self:set_sum_txt(self._now_selected_chest_count)
		end
	end

	function arg_1_0:refresh_lock_state(arg_30_1)
		if self._box_result_tb and next(self._box_result_tb) then
			for iter_30_0, iter_30_1 in pairs(self._box_result_tb) do
				if iter_30_1.item_id == arg_30_1.id then
					iter_30_1.lock = arg_30_1.lock

					self._chest_cell_list[iter_30_0].bg.lock_icon.gameObject:SetActive(iter_30_1.lock)
					self._chest_cell_list[iter_30_0].info_button.button.onClick:RemoveAllListeners()
					self._chest_cell_list[iter_30_0].info_button.button.onClick:AddListener(function()
						if iter_30_1.type == 5 then
							var_0_1:createInstance("furniture_detail_panel"):show({
								cid = iter_30_1.id,
								lock = iter_30_1.lock,
								id = iter_30_1.item_id
							})

							local var_31_0 = var_0_1:getInstance("chest_open_layer")

							if var_31_0 then
								var_0_1:getInstance("furniture_detail_panel")._panel.transform:GetComponent("Canvas").sortingOrder = var_31_0._panel.transform:GetComponent("Canvas").sortingOrder + 101
							end
						elseif iter_30_1.type == 6 then
							var_0_1:createInstance("restaurant_cookinfo"):show(1, iter_30_1.id, false, false, var_0_2.enter_restaurant_type.get_info)
						end
					end)
				end
			end
		end
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_constant()
		end

		self:init_chest_list()

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.chest_layer.bg_top.title.text.text = var_0_6:getNowLang("furniturebox")
		self._control.chest_info.title.text.text = var_0_6:getNowLang("chestopentitle")
		self._control.chest_info.detail_btn.txt.text.text = var_0_6:getNowLang("detailinfo")
		self._control.chest_info.open_sum.text.text = var_0_6:getNowLang("opencount")
		self._control.chest_info.use_btn.txt.text.text = var_0_6:getNowLang("use")
		self._control.jump_warehouse.title_node.title.text.text = var_0_6:getNowLang("jumpornot")
		self._control.jump_warehouse.tip.text.text = var_0_6:getNowLang("jumpcontent")
		self._control.jump_warehouse.coonfirm_btn.txt.text.text = var_0_6:getNowLang("ui_cbtn1")
		self._control.jump_warehouse.cancel_btn.txt.text.text = var_0_6:getNowLang("ui_cbtn2")
		self._control.chest_list.cofirm_btn.txt.text.text = var_0_6:getNowLang("confirm")
		self._control.chest_list.got_line.title.text.text = var_0_6:getNowLang("gotfurniture")
		self._control.chest_info.have_sum_txt.text.text = var_0_6:getNowLang("unequiptip1")
	end

	function arg_1_0:__init_constant()
		self._chest_layer_seq = self._control.chest_layer.uITweenSequence
		self._chest_info_seq = self._control.chest_info.uITweenSequence
		self._chest_list_seq = self._control.chest_list.uITweenSequence
		self._chest_open_seq = self._control.chest_open.uITweenSequence
		self._chest_ske = self._control.chest_open.chest_ske.skeletonAnimation
		self._role_obj = self._control.chest_open.role_ske.gameObject
		self._role_ske = nil
	end

	function arg_1_0:_play_into_se(arg_35_1)
		self:playSE(arg_35_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_36_0)
	local var_36_0 = var_0_1:class("chest_open_layer")

	var_36_0._is_already_init = false
	var_36_0._now_click_chest_cid = nil
	var_36_0._now_selected_chest_count = 0
	var_36_0._chest_layer_seq = nil
	var_36_0._chest_info_seq = nil
	var_36_0._chest_list_seq = nil
	var_36_0._chest_open_seq = nil
	var_36_0._chest_ske = nil
	var_36_0._role_ske = nil
	var_36_0._open_box_once = false
	var_36_0._is_long_click_minus_btn = false
	var_36_0._is_long_click_plus_btn = false
	var_36_0._box_result_tb = {}

	return var_36_0
end

return var_0_0
