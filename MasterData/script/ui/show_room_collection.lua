local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.item_config
local var_0_8 = table.insert
local var_0_10 = UnityEngine.Input
local var_0_13 = gamecore.util_func
local var_0_14 = UnityEngine.RectTransformUtility
local var_0_15 = DG.Tweening.DOTween
local var_0_16 = UnityEngine.Color
local var_0_17 = 1
local var_0_18 = 0
local var_0_19 = next

gamecore.UILoader:define("show_room_collection", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell_1 then
			self._reusable_cell_1:update()
		end

		if self._reusable_cell_2 then
			self._reusable_cell_2:update()
		end

		if var_0_10.GetMouseButton(0) and var_0_17 == 2 then
			var_0_18 = Time.deltaTime + var_0_18

			if var_0_18 > 0.6 then
				self:on_point_down_event()
			end
		end

		if var_0_10.GetMouseButtonUp(0) then
			if self.use_area_num then
				self:on_area_point_up_event(self.use_area_num)
			end

			self:on_point_up_event()
		end
	end

	function arg_1_0:colliection_move_in_animation(arg_4_1, arg_4_2)
		self:set_opposite_ui_open(arg_4_1)
		var_0_4:play_in_out_animation(self._control.move_in_tween.uITweenSequence, arg_4_1, arg_4_2)

		self._control.scrollview_1.viewport.content.transform.anchoredPosition = Vector2(0, 0)
		self._control.scrollview_2.viewport.content.transform.anchoredPosition = Vector2(0, 0)
	end

	function arg_1_0:set_opposite_ui_open(arg_5_1)
		self._control.btn_l.gameObject:SetActive(not arg_5_1)
		self._control.btn_r.gameObject:SetActive(arg_5_1)
	end

	function arg_1_0:get_cell_by_now_lable()
		local var_6_0

		var_6_0 = self._now_label == 1 and self._reusable_cell_1 or self._now_label == 2 and self._reusable_cell_2 or var_6_0

		return var_6_0
	end

	function arg_1_0.__is_collection_ship_type_all(arg_7_0, arg_7_1)
		if arg_7_1 == nil or arg_7_1 == 0 then
			return true
		end

		if type(arg_7_1) == "table" then
			if not var_0_19(arg_7_1) then
				return true
			end

			for iter_7_0, iter_7_1 in pairs(arg_7_1) do
				if iter_7_1 == 0 then
					return true
				end
			end
		end

		return false
	end

	function arg_1_0:__get_collection_ship_type_text(arg_8_1)
		if self:__is_collection_ship_type_all(arg_8_1) then
			return var_0_2:getNowLang("shiptypedetailall")
		end

		if type(arg_8_1) == "table" then
			local var_8_0 = {}

			for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
				var_0_8(var_8_0, var_0_2:getNowLang("shiptypedetail" .. iter_8_1))
			end

			if var_0_19(var_8_0) then
				return table.concat(var_8_0, "")
			end

			for iter_8_2, iter_8_3 in pairs(arg_8_1) do
				var_0_8(var_8_0, var_0_2:getNowLang("shiptypedetail" .. iter_8_3))
			end

			return table.concat(var_8_0, "")
		end

		return var_0_2:getNowLang("shiptypedetail" .. arg_8_1)
	end

	function arg_1_0.__collection_value_match_filter(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_1 == nil or arg_9_2 == nil then
			return false
		end

		local function var_9_0(arg_10_0, arg_10_1)
			if type(arg_10_0) == "table" then
				for iter_10_0, iter_10_1 in pairs(arg_10_0) do
					if iter_10_1 == arg_10_1 then
						return true
					end
				end

				return false
			end

			return arg_10_0 == arg_10_1
		end

		if type(arg_9_2) == "table" then
			for iter_9_0, iter_9_1 in pairs(arg_9_2) do
				if var_9_0(arg_9_1, iter_9_1) then
					return true
				end
			end

			return false
		end

		return var_9_0(arg_9_1, arg_9_2)
	end

	function arg_1_0:__collection_ship_type_match_filter(arg_11_1, arg_11_2)
		if self:__is_collection_ship_type_all(arg_11_1) then
			return true
		end

		return self:__collection_value_match_filter(arg_11_1, arg_11_2)
	end

	function arg_1_0:__collection_country_match_filter(arg_12_1, arg_12_2)
		return self:__collection_value_match_filter(arg_12_1, arg_12_2)
	end

	function arg_1_0:show_scroll_by_index(arg_13_1)
		if arg_13_1 == 1 then
			self._control.collectionstyle_text.text.text = var_0_2:getNowLang("desktopcollection")

			self._control.scrollview_1:SetActive(true)
			self._control.scrollview_2:SetActive(false)
			self:colliection_move_in_animation(false)

			self._now_label = 1
		else
			self._control.collectionstyle_text.text.text = var_0_2:getNowLang("wallcollection")

			self._control.scrollview_1:SetActive(false)
			self._control.scrollview_2:SetActive(true)
			self:colliection_move_in_animation(true)

			self._now_label = 2
		end
	end

	function arg_1_0.__get_all_effect_main_keyword(arg_14_0, arg_14_1)
		if not arg_14_1 then
			return
		end

		local var_14_0 = {}

		for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
			var_14_0[iter_14_1.name] = iter_14_1.value
		end

		return var_14_0
	end

	function arg_1_0:init_cell()
		if self._already_init then
			return
		end

		self._reusable_cell_1 = gamecore.reusable_cell:create(self, self._control.scrollview_1.viewport.content.endlessScrollView, self._control.scrollview_1.viewport.content, "single_collection_cell", "show_room_collection")

		self._reusable_cell_1:init()

		self._reusable_cell_2 = gamecore.reusable_cell:create(self, self._control.scrollview_2.viewport.content.endlessScrollView, self._control.scrollview_2.viewport.content, "single_collection_cell", "show_room_collection")

		self._reusable_cell_2:init()
	end

	function arg_1_0:init_collection_cell_list()
		local var_16_0 = self:get_cell_by_now_lable()
		local var_16_1

		if self._now_label == 1 then
			var_16_1 = self.collection_desk_config_list or self.collection_wall_config_list
		end

		var_16_0:set_data(var_16_1)

		function var_16_0:_set_func(arg_17_1)
			local var_17_0 = var_16_1[arg_17_1 + 1]

			self.name_scroller:GetComponent("TextHorizonScroller"):SetText(var_16_1[arg_17_1 + 1].title)

			self.icon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.collection_use_icon[1], var_17_0.cid))

			if var_17_0.effect_desc then
				if self._now_label == 1 and var_0_19(var_17_0.buff_effect) then
					local var_17_2 = var_17_0.buff_effect
					local var_17_3 = var_0_2:getNowLang("country" .. var_17_0.buff_effect.country)
					local var_17_4 = self:__get_collection_ship_type_text(var_17_0.buff_effect.ship_type)
					local var_17_5 = var_0_2:getNowLang(string.lower(var_17_0.buff_effect.attr))

					self.buff_tips_txt.text.text = var_17_0.effect_desc

					if self:__is_collection_ship_type_all(var_17_2.ship_type) and var_17_2.country == 0 then
						self.buff_tips_txt.text.text = var_0_2:getNowLang("country0") .. var_0_2:getNowLang("leaderboardship")
					end

					self.buff_tips_1_txt:SetActive(false)
				end
			end

			if var_17_0.effect_desc == "" or var_17_0.effect_desc == "0" or var_17_0.effect_desc == 0 then
				self.buff_tips_txt.text.text = "---"
				self.buff_tips_1_txt.text.text = ""
			end

			self.describe.button.onClick:RemoveAllListeners()
			self.describe.button.onClick:AddListener(function()
				self:set_collection_info(var_17_0.cid)
			end)
			self.describe.pointerDownUpEvent.onPointerDown:RemoveAllListeners()
			self.describe.pointerDownUpEvent.onPointerDown:AddListener(function()
				var_0_17 = 2
				self._control.drag_icon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.collection_use_icon[1], var_17_0.cid))

				self._control.drag_icon:GetComponent("Image"):SetNativeSize()

				self.chose_collection_cid = var_17_0.cid
				self._drag_index = 1
			end)
		end

		self._country_toggle_data = {
			all = true
		}
		self._type_toggle_data = {
			all = true
		}
		self._effect_toggle_data = {
			all = true
		}
		self._control.type_btn.type_txt.text.text = var_0_2:getNowLang("questall")

		self:_reset_type_layer()
	end

	function arg_1_0.set_collection_info(arg_20_0, arg_20_1)
		var_0_3:createInstance("collection_info"):show(arg_20_1)
	end

	function arg_1_0:on_point_enter_event(arg_21_1)
		self.collection_area_list = {
			self._control.collection_move.collection_desk.desktop_1.desk_area_1,
			self._control.collection_move.collection_desk.desktop_2.desk_area_2,
			self._control.collection_move.collection_desk.desktop_3.desk_area_3,
			self._control.collection_move.collection_wall.showcase_l.wall_area_1,
			self._control.collection_move.collection_wall.showcase_l.wall_area_2,
			self._control.collection_move.collection_wall.showcase_l.wall_area_3,
			self._control.collection_move.collection_wall.showcase_l.wall_area_4,
			self._control.collection_move.collection_wall.showcase_l.wall_area_5,
			self._control.collection_move.collection_wall.showcase_l.wall_area_6,
			self._control.collection_move.collection_wall.showcase_r.wall_area_1,
			self._control.collection_move.collection_wall.showcase_r.wall_area_2,
			self._control.collection_move.collection_wall.showcase_r.wall_area_3,
			self._control.collection_move.collection_wall.showcase_r.wall_area_4,
			self._control.collection_move.collection_wall.showcase_r.wall_area_5,
			self._control.collection_move.collection_wall.showcase_r.wall_area_6
		}

		if seq then
			seq:Kill()
		end

		if var_0_17 == 2 and arg_21_1 then
			self.collection_area_list[arg_21_1]:GetComponent("Image").color = var_0_16(1, 1, 1, 1)
			self.use_collection_cid = self.chose_collection_cid
			self.use_area_num = arg_21_1
		end
	end

	function arg_1_0:on_point_exit_event(arg_22_1)
		self.exit_index = arg_22_1
		self.collection_area_list[self.exit_index]:GetComponent("Image").color = var_0_16(1, 1, 1, 0)
		seq = self:autoKillDOTween(var_0_15.Sequence())

		seq:AppendInterval(0.1)
		seq:AppendCallback(function()
			self.use_collection_cid = nil
			self.use_area_num = nil
		end)
		seq:AppendInterval(0.5)
		seq:AppendCallback(function()
			seq:Kill()
		end)
		seq:Play()
	end

	function arg_1_0:on_area_point_up_event(arg_25_1)
		if self._drag_index == 2 then
			if not self.collection_image_list[arg_25_1].activeSelf then
				self.collection_image_list[self._drag_num]:SetActive(false)
				self.show_room_collection_list[self._drag_num]:SetActive(false)
			else
				self.show_room_collection_list[self._drag_num].image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.collection_use_icon[1], (tonumber(string.sub(self.collection_image_list[arg_25_1]:GetComponent("Image").sprite.name, 12)))))

				self.show_room_collection_list[self._drag_num]:GetComponent("Image"):SetNativeSize()
			end
		end

		self.collection_image_list[arg_25_1].image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.collection_use_icon[1], self.use_collection_cid))

		self.collection_image_list[arg_25_1]:SetActive(true)

		self.show_room_collection_list[arg_25_1].image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.collection_use_icon[1], self.use_collection_cid))

		self.show_room_collection_list[arg_25_1]:GetComponent("Image"):SetNativeSize()
		self.show_room_collection_list[arg_25_1]:SetActive(true)

		self.now_drag_collection_data = {
			id = self.use_collection_cid,
			index = arg_25_1
		}

		if arg_25_1 > 0 and arg_25_1 <= 3 and var_0_1:get_collection_state() then
			var_0_1:req_ChangeDeskCollectionReq(self.now_drag_collection_data)
			var_0_1:set_collection_state(false)
		end

		if arg_25_1 > 3 then
			self.now_drag_collection_data = {
				id = self.use_collection_cid,
				index = arg_25_1 - 3
			}

			var_0_1:req_ChangeWallCollectionReq(self.now_drag_collection_data)
		end

		for iter_25_0 = 1, 15 do
			self.collection_image_list[iter_25_0]:GetComponent("Image").raycastTarget = true
		end

		self._drag_index = 0

		self:__update_cell()
	end

	function arg_1_0:collection_onclick_event(arg_26_1)
		self.collection_image_list[arg_26_1]:SetActive(false)
		self.show_room_collection_list[arg_26_1]:SetActive(false)

		self.now_drag_collection_data = {
			id = 0,
			index = arg_26_1
		}

		if arg_26_1 > 0 and arg_26_1 <= 3 then
			var_0_1:req_ChangeDeskCollectionReq(self.now_drag_collection_data)
		end

		if arg_26_1 > 3 then
			self.now_drag_collection_data = {
				id = 0,
				index = arg_26_1 - 3
			}

			var_0_1:req_ChangeWallCollectionReq(self.now_drag_collection_data)
		end

		self:__update_cell()
	end

	function arg_1_0:collection_drag_event(arg_27_1)
		self._drag_id = tonumber(string.sub(self.collection_image_list[arg_27_1]:GetComponent("Image").sprite.name, 12))
		self._drag_index = 2
		self._drag_num = arg_27_1
		var_0_17 = 2
		self._control.drag_icon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.collection_use_icon[1], self._drag_id))

		self._control.drag_icon:GetComponent("Image"):SetNativeSize()

		self.chose_collection_cid = self._drag_id
	end

	function arg_1_0:on_point_down_event()
		self.set_point_is_config_true = true

		self._control.drag_icon:SetActive(true)

		self._control.scrollview_1:GetComponent("ScrollRect").enabled = false
		self._control.scrollview_2:GetComponent("ScrollRect").enabled = false

		local var_28_0, var_28_1 = var_0_14.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_10.mousePosition, self._ui_camera, nil)

		if var_28_0 then
			self._control.drag_icon.rectTransform.anchoredPosition = var_28_1
		end

		for iter_28_0 = 1, 15 do
			self.collection_image_list[iter_28_0]:GetComponent("Image").raycastTarget = false
		end
	end

	function arg_1_0:on_point_up_event()
		self._drag_index = 0
		var_0_17 = 1
		var_0_18 = 0

		self._control.drag_icon:SetActive(false)

		self._control.scrollview_1:GetComponent("ScrollRect").enabled = true
		self._control.scrollview_2:GetComponent("ScrollRect").enabled = true
		self.chose_collection_cid = nil

		for iter_29_0 = 1, 15 do
			self.collection_image_list[iter_29_0]:GetComponent("Image").raycastTarget = true
		end

		if self.set_point_is_config_true then
			self._control.scrollview_1.viewport.content.transform.anchoredPosition = Vector2(0, 0)
			self._control.scrollview_2.viewport.content.transform.anchoredPosition = Vector2(0, 0)
			self.set_point_is_config_true = false
		end
	end

	function arg_1_0:set_movecollection_data(arg_30_1)
		if arg_30_1 == 1 then
			self._control.collection_move.rectTransform.anchoredPosition = Vector2(0, 0)
			self._control.collectionstyle_text.text.text = var_0_2:getNowLang("desktopcollection")

			self._control.scrollview_1:SetActive(true)
			self._control.scrollview_2:SetActive(false)
			self._control.btn_l.gameObject:SetActive(true)
			self._control.btn_r.gameObject:SetActive(false)
			self._control.type_btn.gameObject:SetActive(true)

			self._now_label = 1
		end

		if arg_30_1 == 2 then
			self._control.collection_move.rectTransform.anchoredPosition = Vector2(1500, 0)
			self._control.collectionstyle_text.text.text = var_0_2:getNowLang("wallcollection")

			self._control.scrollview_1:SetActive(false)
			self._control.scrollview_2:SetActive(true)
			self._control.btn_r.gameObject:SetActive(true)
			self._control.btn_l.gameObject:SetActive(false)
			self._control.type_btn.gameObject:SetActive(false)

			self._now_label = 2
		end
	end

	function arg_1_0:get_user_collection_data()
		self.collection_desk_config_list = {}
		self.collection_wall_config_list = {}
		self.user_desk_collection_list = var_0_1:get_all_items_by_type(43)
		self.user_wall_collection_list = var_0_1:get_all_items_by_type(44)

		for iter_31_0 = 1, #self.user_desk_collection_list do
			var_0_8(self.collection_desk_config_list, (var_0_5.find_object_by_cid(tonumber(self.user_desk_collection_list[iter_31_0].id))))
		end

		for iter_31_1 = 1, #self.user_wall_collection_list do
			var_0_8(self.collection_wall_config_list, (var_0_5.find_object_by_cid(tonumber(self.user_wall_collection_list[iter_31_1].id))))
		end
	end

	function arg_1_0:get_user_use_collection_data()
		self.user_use_desk_collection_list = {}
		self.user_use_wall_collection_list = {}
		self.user_use_desk_collection_list = var_0_1:get_player_desk_collection_data()
		self.user_use_wall_collection_list = var_0_1:get_player_wall_collection_data()

		for iter_32_0 = 1, #self.user_use_desk_collection_list do
			if self.user_use_desk_collection_list[iter_32_0].id ~= 0 and self.user_use_desk_collection_list[iter_32_0].index ~= 0 then
				self.collection_image_list[self.user_use_desk_collection_list[iter_32_0].index].image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.collection_use_icon[1], self.user_use_desk_collection_list[iter_32_0].id))

				self.collection_image_list[self.user_use_desk_collection_list[iter_32_0].index]:SetActive(true)
			end
		end

		for iter_32_1 = 1, #self.user_use_wall_collection_list do
			if self.user_use_wall_collection_list[iter_32_1].id ~= 0 and self.user_use_wall_collection_list[iter_32_1].index + 3 ~= 0 then
				self.collection_image_list[self.user_use_wall_collection_list[iter_32_1].index + 3].image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.collection_use_icon[1], self.user_use_wall_collection_list[iter_32_1].id))

				self.collection_image_list[self.user_use_wall_collection_list[iter_32_1].index + 3]:SetActive(true)
			end
		end
	end

	function arg_1_0:__init_filter_type_list()
		self._toggle_country_group = {
			all = self._control.type_layer.country_group.toggle_group.all,
			C_country = self._control.type_layer.country_group.toggle_group.C_country,
			E_country = self._control.type_layer.country_group.toggle_group.E_country,
			F_country = self._control.type_layer.country_group.toggle_group.F_country,
			G_country = self._control.type_layer.country_group.toggle_group.G_country,
			I_country = self._control.type_layer.country_group.toggle_group.I_country,
			J_country = self._control.type_layer.country_group.toggle_group.J_country,
			S_country = self._control.type_layer.country_group.toggle_group.S_country,
			U_country = self._control.type_layer.country_group.toggle_group.U_country,
			other_country = self._control.type_layer.country_group.toggle_group.other_country
		}
		self._toggle_country_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"C_country",
			"E_country",
			"F_country",
			"G_country",
			"I_country",
			"J_country",
			"S_country",
			"U_country",
			"other_country"
		}, self._toggle_country_group)
		self._toggle_type_group = {
			all = self._control.type_layer.type_group.toggle_group.all,
			CV = self._control.type_layer.type_group.toggle_group.CV,
			CVL = self._control.type_layer.type_group.toggle_group.CVL,
			AV = self._control.type_layer.type_group.toggle_group.AV,
			BB = self._control.type_layer.type_group.toggle_group.BB,
			BBV = self._control.type_layer.type_group.toggle_group.BBV,
			BC = self._control.type_layer.type_group.toggle_group.BC,
			CA = self._control.type_layer.type_group.toggle_group.CA,
			CAV = self._control.type_layer.type_group.toggle_group.CAV,
			CLT = self._control.type_layer.type_group.toggle_group.CLT,
			CL = self._control.type_layer.type_group.toggle_group.CL,
			BM = self._control.type_layer.type_group.toggle_group.BM,
			DD = self._control.type_layer.type_group.toggle_group.DD,
			SSG = self._control.type_layer.type_group.toggle_group.SSG,
			SS = self._control.type_layer.type_group.toggle_group.SS,
			SC = self._control.type_layer.type_group.toggle_group.SC,
			AP = self._control.type_layer.type_group.toggle_group.AP,
			ASDG = self._control.type_layer.type_group.toggle_group.ASDG,
			AADG = self._control.type_layer.type_group.toggle_group.AADG,
			KP = self._control.type_layer.type_group.toggle_group.KP,
			CG = self._control.type_layer.type_group.toggle_group.CG,
			CBG = self._control.type_layer.type_group.toggle_group.CBG,
			BBG = self._control.type_layer.type_group.toggle_group.BBG,
			BG = self._control.type_layer.type_group.toggle_group.BG
		}
		self._toggle_type_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"CV",
			"CVL",
			"AV",
			"BB",
			"BBV",
			"BC",
			"CA",
			"CAV",
			"CLT",
			"CL",
			"BM",
			"DD",
			"SSG",
			"SS",
			"SC",
			"AP",
			"ASDG",
			"AADG",
			"KP",
			"CG",
			"CBG",
			"BBG",
			"BG"
		}, self._toggle_type_group)
		self._toggle_size_group = {
			all = self._control.type_layer.size_group.toggle_group.all,
			large = self._control.type_layer.size_group.toggle_group.large,
			middle = self._control.type_layer.size_group.toggle_group.middle,
			small = self._control.type_layer.size_group.toggle_group.small,
			maip = self._control.type_layer.size_group.toggle_group.maip,
			protect = self._control.type_layer.size_group.toggle_group.protect
		}
		self._toggle_size_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"large",
			"middle",
			"small",
			"maip",
			"protect"
		}, self._toggle_size_group)
		self._toggle_effect_group = {
			all = self._control.type_layer.effect_group.toggle_group.all,
			atk = self._control.type_layer.effect_group.toggle_group.atk,
			def = self._control.type_layer.effect_group.toggle_group.def,
			torpedo = self._control.type_layer.effect_group.toggle_group.torpedo,
			air_def = self._control.type_layer.effect_group.toggle_group.air_def,
			hit = self._control.type_layer.effect_group.toggle_group.hit,
			miss = self._control.type_layer.effect_group.toggle_group.miss,
			antisub = self._control.type_layer.effect_group.toggle_group.antisub,
			speed = self._control.type_layer.effect_group.toggle_group.speed,
			radar = self._control.type_layer.effect_group.toggle_group.radar,
			luck = self._control.type_layer.effect_group.toggle_group.luck
		}
		self._toggle_effect_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"atk",
			"def",
			"torpedo",
			"air_def",
			"hit",
			"miss",
			"antisub",
			"speed",
			"radar",
			"luck"
		}, self._toggle_effect_group)
	end

	function arg_1_0:__init_panel(arg_34_1)
		local var_34_0 = var_0_3:getInstance("show_room")

		self:set_movecollection_data(arg_34_1)
		self:get_user_collection_data()

		if arg_34_1 == 1 and self._reusable_cell_1 == nil then
			self:init_cell()
		end

		if arg_34_1 == 2 and self._reusable_cell_2 == nil then
			self:init_cell()
		end

		self:__init_language()
		self:__init_filter_type_list()
		self:init_collection_cell_list()

		self._uiroot_canvas_rect = var_0_13.get_ui_root_canvas_rect()
		self._ui_camera = var_0_13.get_ui_camera()
		self.collection_image_list = {
			self._control.collection_move.collection_desk.desktop_1.image_1,
			self._control.collection_move.collection_desk.desktop_2.image_2,
			self._control.collection_move.collection_desk.desktop_3.image_3,
			self._control.collection_move.collection_wall.showcase_l.image_1,
			self._control.collection_move.collection_wall.showcase_l.image_2,
			self._control.collection_move.collection_wall.showcase_l.image_3,
			self._control.collection_move.collection_wall.showcase_l.image_4,
			self._control.collection_move.collection_wall.showcase_l.image_5,
			self._control.collection_move.collection_wall.showcase_l.image_6,
			self._control.collection_move.collection_wall.showcase_r.image_1,
			self._control.collection_move.collection_wall.showcase_r.image_2,
			self._control.collection_move.collection_wall.showcase_r.image_3,
			self._control.collection_move.collection_wall.showcase_r.image_4,
			self._control.collection_move.collection_wall.showcase_r.image_5,
			self._control.collection_move.collection_wall.showcase_r.image_6
		}
		self.show_room_collection_list = {
			var_34_0._control.collect.desktop_l.collect_wall_icon_1,
			var_34_0._control.collect.desktop.collect_wall_icon_2,
			var_34_0._control.collect.desktop_r.collect_wall_icon_3,
			var_34_0._control.collect.showcase_l.collect_wall_icon_1,
			var_34_0._control.collect.showcase_l.collect_wall_icon_2,
			var_34_0._control.collect.showcase_l.collect_wall_icon_3,
			var_34_0._control.collect.showcase_l.collect_wall_icon_4,
			var_34_0._control.collect.showcase_l.collect_wall_icon_5,
			var_34_0._control.collect.showcase_l.collect_wall_icon_6,
			var_34_0._control.collect.showcase_r.collect_wall_icon_1,
			var_34_0._control.collect.showcase_r.collect_wall_icon_2,
			var_34_0._control.collect.showcase_r.collect_wall_icon_3,
			var_34_0._control.collect.showcase_r.collect_wall_icon_4,
			var_34_0._control.collect.showcase_r.collect_wall_icon_5,
			var_34_0._control.collect.showcase_r.collect_wall_icon_6
		}

		self:get_user_use_collection_data()
	end

	function arg_1_0:__init_language()
		self._control.type_layer.filter_type.type_txt.text.text = var_0_2:getNowLang("type")
		self._control.type_layer.btn_series.cancel_btn.cancel.text.text = var_0_2:getNowLang("cancel")
		self._control.type_layer.btn_series.confirm_btn.confirm.text.text = var_0_2:getNowLang("confirm")
		self._control.type_btn.type.text.text = var_0_2:getNowLang("type")
		self._control.type_btn.type_txt.text.text = var_0_2:getNowLang("questall")

		for iter_35_0, iter_35_1 in ipairs({
			self._control.type_layer.country_group.toggle_group.all,
			self._control.type_layer.country_group.toggle_group.J_country,
			self._control.type_layer.country_group.toggle_group.G_country,
			self._control.type_layer.country_group.toggle_group.E_country,
			self._control.type_layer.country_group.toggle_group.U_country,
			self._control.type_layer.country_group.toggle_group.I_country,
			self._control.type_layer.country_group.toggle_group.F_country,
			self._control.type_layer.country_group.toggle_group.S_country,
			self._control.type_layer.country_group.toggle_group.C_country,
			self._control.type_layer.country_group.toggle_group.other_country
		}) do
			iter_35_1.Label.text.text = var_0_2:getNowLang("country" .. iter_35_0 - 1)
		end

		for iter_35_2, iter_35_3 in pairs(var_0_4.filter_type) do
			self._control.type_layer.type_group.toggle_group[iter_35_2].Label.text.text = iter_35_2 == "CLT" and var_0_2:getNowLang("shiptype9") or var_0_2:getNowLang(string.format("shiptype%s", iter_35_3))
		end

		self._control.type_layer.effect_group.toggle_group.all.Label.text.text = var_0_2:getNowLang("shipbigtype0")
		self._control.type_layer.effect_group.toggle_group.atk.Label.text.text = var_0_2:getNowLang("atk")
		self._control.type_layer.effect_group.toggle_group.def.Label.text.text = var_0_2:getNowLang("def")
		self._control.type_layer.effect_group.toggle_group.torpedo.Label.text.text = var_0_2:getNowLang("torpedo")
		self._control.type_layer.effect_group.toggle_group.air_def.Label.text.text = var_0_2:getNowLang("air_def")
		self._control.type_layer.effect_group.toggle_group.hit.Label.text.text = var_0_2:getNowLang("hit")
		self._control.type_layer.effect_group.toggle_group.miss.Label.text.text = var_0_2:getNowLang("miss")
		self._control.type_layer.effect_group.toggle_group.antisub.Label.text.text = var_0_2:getNowLang("antisub")
		self._control.type_layer.effect_group.toggle_group.speed.Label.text.text = var_0_2:getNowLang("speed")
		self._control.type_layer.effect_group.toggle_group.radar.Label.text.text = var_0_2:getNowLang("radar")
		self._control.type_layer.effect_group.toggle_group.luck.Label.text.text = var_0_2:getNowLang("luck")
		self._control.type_layer.size_group.toggle_group.all.Label.text.text = var_0_2:getNowLang("shipbigtype0")
		self._control.type_layer.size_group.toggle_group.large.Label.text.text = var_0_2:getNowLang("shipbigtype1")
		self._control.type_layer.size_group.toggle_group.middle.Label.text.text = var_0_2:getNowLang("shipbigtype2")
		self._control.type_layer.size_group.toggle_group.small.Label.text.text = var_0_2:getNowLang("shipbigtype3")
		self._control.type_layer.size_group.toggle_group.maip.Label.text.text = var_0_2:getNowLang("guard_type1")
		self._control.type_layer.size_group.toggle_group.protect.Label.text.text = var_0_2:getNowLang("guard_type2")
	end

	function arg_1_0:__set_desk_collection_filter(arg_36_1)
		if self._country_toggle_data.all and self._type_toggle_data.all and self._effect_toggle_data.all then
			return arg_36_1
		end

		local var_36_0 = {}

		for iter_36_0, iter_36_1 in pairs(arg_36_1) do
			local var_36_1 = false

			if not self._country_toggle_data.all then
				for iter_36_2, iter_36_3 in pairs(self._country_toggle_data) do
					if iter_36_2 ~= "all" and self:__collection_country_match_filter(iter_36_1.buff_effect.country, var_0_4.filter_country[iter_36_2]) then
						var_36_1 = true

						break
					end
				end
			else
				var_36_1 = true
			end

			local var_36_2 = false

			if not self._type_toggle_data.all then
				for iter_36_4, iter_36_5 in pairs(self._type_toggle_data) do
					if iter_36_4 ~= "all" and self:__collection_ship_type_match_filter(iter_36_1.buff_effect.ship_type, var_0_4.filter_type[iter_36_4]) then
						var_36_2 = true

						break
					end
				end
			else
				var_36_2 = true
			end

			local var_36_3 = false

			if not self._effect_toggle_data.all then
				for iter_36_6, iter_36_7 in pairs(self._effect_toggle_data) do
					if iter_36_6 ~= "all" and iter_36_6 == iter_36_1.buff_effect.attr then
						var_36_3 = true

						break
					end
				end
			else
				var_36_3 = true
			end

			if var_36_1 and var_36_2 and var_36_3 then
				var_0_8(var_36_0, iter_36_1)
			end
		end

		return var_36_0
	end

	function arg_1_0:__update_cell()
		local var_37_0 = self:get_cell_by_now_lable()
		local var_37_1 = self:__set_desk_collection_filter((self._now_label == 1 or nil) and (self.collection_desk_config_list or self.collection_wall_config_list))

		var_37_0:set_data(var_37_1)

		function var_37_0:_set_func(arg_38_1)
			local var_38_0 = var_37_1[arg_38_1 + 1]

			self.name_scroller:GetComponent("TextHorizonScroller"):SetText(var_37_1[arg_38_1 + 1].title)

			self.icon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.collection_use_icon[1], var_38_0.cid))

			if var_38_0.effect_desc then
				if self._now_label == 1 and var_0_19(var_38_0.buff_effect) then
					local var_38_2 = var_38_0.buff_effect
					local var_38_3 = var_0_2:getNowLang("country" .. var_38_0.buff_effect.country)
					local var_38_4 = self:__get_collection_ship_type_text(var_38_0.buff_effect.ship_type)
					local var_38_5 = var_0_2:getNowLang(string.lower(var_38_0.buff_effect.attr))

					self.buff_tips_txt.text.text = var_38_0.effect_desc

					if self:__is_collection_ship_type_all(var_38_2.ship_type) and var_38_2.country == 0 then
						self.buff_tips_txt.text.text = var_0_2:getNowLang("country0") .. var_0_2:getNowLang("leaderboardship")
					end

					self.buff_tips_1_txt:SetActive(false)
				end
			end

			if var_38_0.effect_desc == "" or var_38_0.effect_desc == "0" or var_38_0.effect_desc == 0 then
				self.buff_tips_txt.text.text = "---"
				self.buff_tips_1_txt.text.text = ""
			end

			self.describe.button.onClick:RemoveAllListeners()
			self.describe.button.onClick:AddListener(function()
				self:set_collection_info(var_38_0.cid)
			end)
			self.describe.pointerDownUpEvent.onPointerDown:RemoveAllListeners()
			self.describe.pointerDownUpEvent.onPointerDown:AddListener(function()
				var_0_17 = 2
				self._control.drag_icon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.collection_use_icon[1], var_38_0.cid))

				self._control.drag_icon:GetComponent("Image"):SetNativeSize()

				self.chose_collection_cid = var_38_0.cid
				self._drag_index = 1
			end)
		end
	end

	function arg_1_0:__onReset()
		if self._toggle_type_group then
			self._toggle_type_group.all.toggle.isOn = true
		end

		if self._toggle_country_group then
			self._toggle_country_group.all.toggle.isOn = true
		end

		if self._toggle_country_group_obj then
			self._toggle_country_group_obj:toggleOn("all", self._toggle_country_group.all.toggle.isOn)
		end

		if self._toggle_type_group_obj then
			self._toggle_type_group_obj:toggleOn("all", self._toggle_type_group.all.toggle.isOn)
		end

		if self._toggle_effect_group then
			self._toggle_effect_group.all.toggle.isOn = true
		end

		if self._toggle_effect_group_obj then
			self._toggle_effect_group_obj:toggleOn("all", self._toggle_effect_group.all.toggle.isOn)
		end

		self._toggle_country_group_obj = nil
		self._toggle_country_group = nil
		self._toggle_size_group_obj = nil
		self._toggle_size_group = nil
		self._toggle_type_group_obj = nil
		self._toggle_type_group = nil
		self._toggle_effect_group_obj = nil
		self._toggle_effect_group = nil
		self._country_toggle_data = {
			all = true
		}
		self._type_toggle_data = {
			all = true
		}
		self._effect_toggle_data = {
			all = true
		}
		self._need_revert = false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_42_0)
	local var_42_0 = var_0_3:class("show_room_collection")

	var_42_0._is_already_init = false
	var_42_0._reusable_cell_1 = nil
	var_42_0._reusable_cell_2 = nil
	var_42_0._now_label = nil
	var_42_0.chose_collection_cid = nil
	var_42_0.use_collection_cid = nil
	var_42_0.use_area_num = nil
	var_42_0.collection_image_list = {}
	var_42_0.user_desk_collection_list = {}
	var_42_0.user_wall_collection_list = {}
	var_42_0.user_use_desk_collection_list = {}
	var_42_0.user_use_wall_collection_list = {}
	var_42_0.collection_desk_config_list = {}
	var_42_0.collection_wall_config_list = {}
	var_42_0.now_drag_collection_data = {}
	var_42_0.show_room_collection_list = {}
	var_42_0.exit_index = nil
	var_42_0._drag_index = 0
	var_42_0._drag_id = 0
	var_42_0._drag_num = 0
	var_42_0.set_point_is_config_true = false
	var_42_0.collection_area_list = {}
	var_42_0._toggle_country_group_obj = nil
	var_42_0._toggle_country_group = nil
	var_42_0._toggle_effect_group_obj = nil
	var_42_0._toggle_effect_group = nil
	var_42_0._toggle_size_group_obj = nil
	var_42_0._toggle_size_group = nil
	var_42_0._toggle_type_group_obj = nil
	var_42_0._toggle_type_group = nil
	var_42_0._country_toggle_data = {
		all = true
	}
	var_42_0._type_toggle_data = {
		all = true
	}
	var_42_0._effect_toggle_data = {
		all = true
	}
	var_42_0._temp_effect_data = 0

	return var_42_0
end

return var_0_0
