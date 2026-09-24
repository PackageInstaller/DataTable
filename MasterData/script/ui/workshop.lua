local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = table.insert
local var_0_6 = table.sort
local var_0_7 = string.format
local var_0_8 = gameconfig.workshop_config
local var_0_9 = gamecore.util_func
local var_0_10 = UnityEngine.Vector2
local var_0_11 = gamecore.prompt
local var_0_12 = next
local var_0_13 = Color.New(0.984313725490196, 0.09803921568627451, 0.4117647058823529, 1)
local var_0_14 = Color.New(0.027450980392156862, 0.5019607843137255, 0.984313725490196, 1)

gamecore.UILoader:define("workshop", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:__preload_map_fragment()
		self._obj_pool = {}

		for iter_3_0, iter_3_1 in ipairs({
			{
				preload_count = 15,
				preload_obj_name = "workshop_map_node"
			},
			{
				preload_count = 15,
				preload_obj_name = "workshop_map_arrow"
			}
		}) do
			self._obj_pool[iter_3_1.preload_obj_name] = {}

			for iter_3_2 = 1, iter_3_1.preload_count do
				local var_3_0, var_3_1 = self:loadUIPrefab(iter_3_1.preload_obj_name, self._control.obj_pool_root.transform)

				var_3_0:setVisible(true)

				self._obj_pool[iter_3_1.preload_obj_name][#self._obj_pool[iter_3_1.preload_obj_name] + 1] = {
					using = false,
					prefabObj = var_3_0,
					prefabContorl = var_3_1
				}
			end
		end
	end

	function arg_1_0:__load_map_fragment_with_pool(arg_4_1, arg_4_2)
		local var_4_0 = false
		local var_4_1

		function set_rect(arg_5_0)
			if arg_5_0.bg then
				arg_5_0.bg.transform.parent:GetComponent("RectTransform").offsetMax = var_0_10(0, 0)
				arg_5_0.bg.transform.parent:GetComponent("RectTransform").offsetMin = var_0_10(0, 0)
			elseif arg_5_0.arrow then
				arg_5_0.arrow.transform.parent:GetComponent("RectTransform").offsetMax = var_0_10(0, 0)
				arg_5_0.arrow.transform.parent:GetComponent("RectTransform").offsetMin = var_0_10(0, 0)
			end
		end

		for iter_4_0, iter_4_1 in ipairs(self._obj_pool[arg_4_1]) do
			if iter_4_1.using == false then
				var_4_0 = true
				var_4_1 = self._obj_pool[arg_4_1][iter_4_0]

				break
			end
		end

		if var_4_0 then
			var_4_1.using = true

			var_4_1.prefabObj._panel.transform:SetParent(arg_4_2)
			set_rect(var_4_1.prefabContorl)
			var_4_1.prefabObj:setVisible(true)

			return var_4_1.prefabObj, var_4_1.prefabContorl
		else
			local var_4_2, var_4_3 = self:loadUIPrefab(arg_4_1, arg_4_2)

			self._obj_pool[arg_4_1][#self._obj_pool[arg_4_1] + 1] = {
				using = true,
				prefabObj = var_4_2,
				prefabContorl = var_4_3
			}

			set_rect(var_4_3)
			var_4_2:setVisible(true)

			return var_4_2, var_4_3
		end
	end

	function arg_1_0:__hide_all_map_fragment_to_pool()
		for iter_6_0, iter_6_1 in pairs(self._obj_pool) do
			for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
				if iter_6_3.using then
					iter_6_3.prefabObj._panel.transform:SetParent(self._control.obj_pool_root.transform)

					iter_6_3.using = false
				end
			end
		end
	end

	function arg_1_0:_play_audio(arg_7_1)
		self:playBackgroundMusic(arg_7_1)
	end

	function arg_1_0:_play_into_se(arg_8_1)
		self:playSE(arg_8_1, false)
	end

	function arg_1_0:__set_arrow_btn_state(arg_9_1, arg_9_2)
		if arg_9_1 == 1 then
			self._control.ship_scroll_view.lattice_scroll_view.last_page_btn.button.interactable = not arg_9_2
		else
			self._control.ship_scroll_view.lattice_scroll_view.next_page_btn.button.interactable = not arg_9_2
		end
	end

	function arg_1_0.__get_txt(arg_10_0, arg_10_1)
		return (string.gsub(arg_10_1, "%^C[^%^]+", function(arg_11_0)
			return string.format("<color=#%s>%s</color>", string.sub(arg_11_0, 3, 10), (string.sub(arg_11_0, 19, #arg_11_0)))
		end))
	end

	function arg_1_0:__set_workshop_score()
		self._now_ship_type_score = var_0_1:get_score_by_ship_type(self._ship_type_list[self._ship_ton][self._init_chapter_index].value)
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.score.text.text = self._now_ship_type_score
	end

	function arg_1_0:__set_icon_by_captater()
		self._control.chapter_scroll_view.curve_scroll_rect.select_bg_img.select_icon.image.sprite = self:loadSprite(var_0_7(var_0_4.workshop_const.chapter_icon, self._allShipTonTb[self._ship_type_list[self._ship_ton][self._init_chapter_index].value][1][1].bg_ship))
		self._control.ship_scroll_view.lattice_scroll_view.ship_title.icon.image.sprite = self:loadSprite(var_0_7(var_0_4.workshop_const.role_icon, self._allShipTonTb[self._ship_type_list[self._ship_ton][self._init_chapter_index].value][1][1].bg_work))
		self._control.ship_scroll_view.lattice_scroll_view.image.sprite = self:loadSprite(var_0_7(var_0_4.workshop_const.workshop_bg, self._allShipTonTb[self._ship_type_list[self._ship_ton][self._init_chapter_index].value][1][1].bg))
	end

	function arg_1_0:__set_scroll_view()
		local var_14_0 = 0
		local var_14_1 = 0
		local var_14_2 = 0
		local var_14_4 = var_0_1:get_workshop_data()

		for iter_14_0, iter_14_1 in pairs(self._ship_map_data_list) do
			for iter_14_2, iter_14_3 in pairs(iter_14_1.node.configs) do
				if var_14_0 < iter_14_3.position[1] then
					var_14_0 = iter_14_3.position[1]
				end

				if var_14_1 > iter_14_3.position[2] then
					var_14_1 = iter_14_3.position[2]
				end

				if var_14_2 < iter_14_3.position[2] then
					var_14_2 = iter_14_3.position[2]
				end
			end
		end

		local var_14_5 = self._control.ship_scroll_view.lattice_scroll_view
		local var_14_6 = self._control.ship_scroll_view.lattice_scroll_view.viewport.content.rectTransform
		local var_14_7 = var_0_4.workshop_const.scroll_view_width
		local var_14_8 = 0

		var_14_6.sizeDelta = var_0_10(var_0_4.workshop_const.scroll_view_width, 0)
		var_14_6.offsetMin = var_0_10(var_14_6.offsetMin.x, 0)
		var_14_6.offsetMax = var_0_10(var_14_6.offsetMax.y, 0)
		var_14_5.scrollRect.enabled = var_14_0 > var_0_4.workshop_const.workshop_width_max - 1 or var_14_2 - var_14_1 > var_0_4.workshop_const.workshop_height_max - 1

		if var_14_0 > var_0_4.workshop_const.workshop_width_max - 1 then
			var_14_7 = var_14_7 + (var_14_0 + 1 - var_0_4.workshop_const.workshop_width_max == 1 and 100 or (var_14_0 + 1 - var_0_4.workshop_const.workshop_width_max - 1) * 150 + 100)
		end

		if var_14_2 - var_14_1 > var_0_4.workshop_const.workshop_height_max - 1 then
			var_14_8 = var_14_8 + (var_14_2 + 1 - var_14_1 - var_0_4.workshop_const.workshop_height_max) * 100
		end

		var_14_5.scrollRect.horizontal = var_14_7 ~= var_0_4.workshop_const.scroll_view_width
		var_14_5.scrollRect.vertical = var_14_8 ~= 0
		var_14_6.sizeDelta = var_0_10(var_14_7, var_14_8)
		var_14_6.anchoredPosition = var_0_10(0, var_14_6.anchoredPosition.y)
	end

	function arg_1_0:__play_top_menu_in_animation()
		self._control.top_menu.top_menu_mask.image.raycastTarget = true
		self._control.top_menu.rectTransform.anchoredPosition = var_0_10(self._control.top_menu.rectTransform.anchoredPosition.x, 100)
		self._control.top_menu.rectTransform:DOAnchorPos(var_0_10(self._control.top_menu.rectTransform.anchoredPosition.x, 0), 0.4):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0.2):SetAutoKill(true).onComplete = function()
			self._control.top_menu.top_menu_mask.image.raycastTarget = false
		end
	end

	function arg_1_0:__play_top_menu_out_animation()
		self._control.top_menu.top_menu_mask.image.raycastTarget = true
		self._control.top_menu.rectTransform.anchoredPosition = var_0_10(self._control.top_menu.rectTransform.anchoredPosition.x, 0)
		self._control.top_menu.rectTransform:DOAnchorPos(var_0_10(self._control.top_menu.rectTransform.anchoredPosition.x, 100), 0.5):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true).onComplete = function()
			self:__destroy_panel()
		end

		self:__play_chapter_panel_out_animation()
	end

	function arg_1_0:__play_chapter_panel_out_animation(arg_19_1)
		arg_19_1 = arg_19_1 or function()
			return
		end

		local var_19_0 = 0.3

		self._in_out_tweener1 = self._control.chapter_scroll_view.curve_scroll_rect.rectTransform:DOAnchorPos(var_0_10(-900, -100), 0.3):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true)
		self._control.ship_scroll_view.lattice_scroll_view.rectTransform.anchoredPosition = var_0_10(140, -95)
		self._in_out_tweener2 = self._control.ship_scroll_view.lattice_scroll_view.rectTransform:DOAnchorPos(var_0_10(1100, -95), var_19_0):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0):SetAutoKill(true)

		function self._in_out_tweener2.onComplete()
			arg_19_1()
		end
	end

	function arg_1_0:__play_chapter_panel_in_animation()
		self._control.chapter_scroll_view.curve_scroll_rect.rectTransform.anchoredPosition = var_0_10(-900, -100)
		self._in_out_tweener1 = self._control.chapter_scroll_view.curve_scroll_rect.rectTransform:DOAnchorPos(var_0_10(-500, -100), 0.3):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0.2):SetAutoKill(true)
		self._control.ship_scroll_view.lattice_scroll_view.rectTransform.anchoredPosition = var_0_10(1100, -95)
		self._in_out_tweener2 = self._control.ship_scroll_view.lattice_scroll_view.rectTransform:DOAnchorPos(var_0_10(140, -95), 0.3):SetEase(DG.Tweening.Ease.OutCirc):SetDelay(0.2):SetAutoKill(true)
	end

	function arg_1_0:__clear_tweener()
		if self._in_out_tweener1 then
			self._in_out_tweener1.onComplete = nil

			self._in_out_tweener1:Kill()
		end

		if self._in_out_tweener2 then
			self._in_out_tweener2.onComplete = nil

			self._in_out_tweener2:Kill()
		end
	end

	function arg_1_0:__load_chapter_scroll_view()
		local var_24_0 = self._control.chapter_scroll_view
		local var_24_1 = 3
		local var_24_2 = {}

		for iter_24_0 = 1, 3 do
			var_24_2[#var_24_2 + 1] = "---"
		end

		for iter_24_1, iter_24_2 in ipairs(self._ship_type_list[self._ship_ton]) do
			var_24_2[#var_24_2 + 1] = var_0_2:getNowLang(iter_24_2.simplified_lan)
		end

		for iter_24_3 = 1, 3 do
			var_24_2[#var_24_2 + 1] = "---"
		end

		for iter_24_4 = 1, #var_24_2 do
			local var_24_3
			local var_24_4

			if self._chapterItemControl_list[iter_24_4] then
				var_24_3 = self._chapterItemControl_list[iter_24_4].chapterItemObj
				var_24_4 = self._chapterItemControl_list[iter_24_4].chapterItemControl
			else
				var_24_3, var_24_4 = self:loadUIPrefab("chapter_scroll_item", self._control.chapter_scroll_view.curve_scroll_rect.viewport.edge_mask.content.transform)
				self._chapterItemControl_list[#self._chapterItemControl_list + 1] = {
					chapterItemObj = var_24_3,
					chapterItemControl = var_24_4
				}
			end

			var_24_3:setVisible(true)

			var_24_4.item_text.text.text = var_24_2[iter_24_4]
		end

		for iter_24_5 = #var_24_2 + 1, #self._chapterItemControl_list do
			UnityEngine.Object.Destroy(self._chapterItemControl_list[iter_24_5].chapterItemObj._panel)

			self._chapterItemControl_list[iter_24_5] = nil
		end

		self._init_chapter_index = 1
		self._control.chapter_scroll_view.curve_scroll_rect.viewport.edge_mask.content.rectTransform.anchoredPosition = var_0_10(self._control.chapter_scroll_view.curve_scroll_rect.viewport.edge_mask.content.rectTransform.anchoredPosition.x, 0)
		self._control.chapter_scroll_view.curve_scroll_rect.select_bg_img.select_text.text.text = var_24_2[4]

		self._control.chapter_scroll_view.curve_scroll_rect.curveScrollRect.onItemSelect:RemoveAllListeners()
		self._control.chapter_scroll_view.curve_scroll_rect.curveScrollRect.onItemSelect:AddListener(function(arg_25_0)
			self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.move_map_page))

			self._init_chapter_index = arg_25_0
			var_24_0.curve_scroll_rect.select_bg_img.select_text.text.text = var_24_2[arg_25_0 + var_24_1]

			self:__set_icon_by_captater()
			self:__hide_all_map_fragment_to_pool()
			self:__init_workshop_panel()
			self:__set_scroll_view()
		end)
		self._control.chapter_scroll_view.curve_scroll_rect.curveScrollRect:Init((self._init_chapter_index - 1) * 80, #var_24_2)

		self._control.chapter_scroll_view.curve_scroll_rect.viewport.edge_mask.content.rectTransform.anchoredPosition = var_0_10(self._control.chapter_scroll_view.curve_scroll_rect.viewport.edge_mask.content.rectTransform.anchoredPosition, -1)
	end

	function arg_1_0:__reset_layer()
		self.__workshop_data = var_0_1:get_workshop_data()
		self._control.ship_scroll_view.lattice_scroll_view.ship_title.title_node.title.text.text = var_0_2:getNowLang(self._ship_type_list[self._ship_ton][self._init_chapter_index].simplified_lan) .. var_0_2:getNowLang("those")
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.title.text.text = var_0_2:getNowLang(self._ship_type_list[self._ship_ton][self._init_chapter_index].simplified_lan) .. var_0_2:getNowLang("scientific_research_value") .. "："
		self._last_click_node = nil

		self:__reset_node_desc()
		self:__set_workshop_score()
	end

	function arg_1_0:__reset_node_desc()
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.desc_bg:SetActive(false)
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_1:SetActive(false)
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2:SetActive(false)

		self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3.txt1.text.text = "------"
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3.txt2.text.text = var_0_2:getNowLang("workshop_max_grade")
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3.txt1.text.color = Color.New(0, 0, 0, 1)

		self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3:SetActive(false)
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.cancel:SetActive(false)
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.confirm:SetActive(false)
	end

	function arg_1_0.__reset_node(arg_28_0, arg_28_1)
		arg_28_1.bg.unlock_bg:SetActive(true)
		arg_28_1.bg.unlock:SetActive(true)
		arg_28_1.bg.processing:SetActive(false)
		arg_28_1.bg.processed:SetActive(false)
		arg_28_1.bg.upgrade:SetActive(false)
		arg_28_1.bg.icon:SetActive(false)
		arg_28_1.bg.selected:SetActive(false)
		arg_28_1.bg.grade_info:SetActive(false)
	end

	function arg_1_0:__init_workshop_panel()
		self:__reset_layer()

		if not self._allShipTonTb[self._ship_type_list[self._ship_ton][self._init_chapter_index].value] then
			self._default_click_node = nil

			return
		end

		local var_29_1 = self._allShipTonTb[self._ship_type_list[self._ship_ton][self._init_chapter_index].value]

		for iter_29_0, iter_29_1 in pairs(self._allShipTonTb[self._ship_type_list[self._ship_ton][self._init_chapter_index].value]) do
			var_0_6(iter_29_1, function(arg_30_0, arg_30_1)
				return arg_30_0.id < arg_30_1.id
			end)
		end

		self:__set_map_layer(var_29_1)
	end

	function arg_1_0:__set_map_layer(arg_31_1)
		self._ship_map_data_list = {}

		for iter_31_0, iter_31_1 in ipairs(arg_31_1) do
			local var_31_0, var_31_1 = self:__load_map_fragment_with_pool("workshop_map_node", self._control.ship_scroll_view.lattice_scroll_view.viewport.content.map_content.transform)

			var_31_0._panel.gameObject.name = "node" .. iter_31_1[1].id
			var_31_1.bg.rectTransform.anchoredPosition = var_0_10(var_0_4.workshop_const.right_side + var_0_4.workshop_const.node_width * iter_31_1[1].position[1], -var_0_4.workshop_const.node_height * iter_31_1[1].position[2])
			var_31_1.bg.icon.image.sprite = self:loadSprite(var_0_7(var_0_4.workshop_const.attr_icon, iter_31_1[1].icon))

			local var_31_2 = {}

			for iter_31_2, iter_31_3 in pairs(iter_31_1[2].unlock_id) do
				local var_31_3, var_31_4 = self:__load_map_fragment_with_pool("workshop_map_arrow", self._control.ship_scroll_view.lattice_scroll_view.viewport.content.map_content.transform)

				var_31_3._panel.transform.name = iter_31_1[1].id .. "-->" .. var_0_8.find_object_by_id(iter_31_3).id
				var_31_2[iter_31_3] = {
					id = iter_31_3,
					control = var_31_4,
					config = var_0_8.find_object_by_id(iter_31_3)
				}
			end

			if self._ship_map_data_list[iter_31_1[1].id] == nil then
				self._ship_map_data_list[iter_31_1[1].id] = {}
			end

			self._ship_map_data_list[iter_31_1[1].id] = {
				node = {
					id = iter_31_1[1].id,
					configs = iter_31_1,
					control = var_31_1
				},
				arrows = var_31_2
			}
		end

		self:__draw_map_arrow()
		self:__get_node_config()
		self:__show_node_info(self._default_click_node)
	end

	function arg_1_0:__draw_map_arrow()
		for iter_32_0, iter_32_1 in pairs(self._ship_map_data_list) do
			for iter_32_2, iter_32_3 in pairs(iter_32_1.arrows) do
				local var_32_0
				local var_32_1
				local var_32_2
				local var_32_3

				if iter_32_1.node.configs[1].position[1] < iter_32_3.config.position[1] and iter_32_1.node.configs[1].position[2] == iter_32_3.config.position[2] then
					var_32_0 = iter_32_1.node.control.bg.rectTransform.anchoredPosition.x + (self._ship_map_data_list[iter_32_3.config.id].node.control.bg.rectTransform.anchoredPosition.x - iter_32_1.node.control.bg.rectTransform.anchoredPosition.x) / 2
					var_32_1 = iter_32_1.node.control.bg.rectTransform.anchoredPosition.y - var_0_4.workshop_const.size / 2 + var_0_4.workshop_const.arrow_width / 2
					var_32_2 = (iter_32_3.config.position[1] - iter_32_1.node.configs[1].position[1] - 1) * var_0_4.workshop_const.node_width + var_0_4.workshop_const.dis * 2 + (var_0_4.workshop_const.node_width - var_0_4.workshop_const.size)
					var_32_3 = var_0_4.workshop_const.arrow_width
				end

				if iter_32_1.node.configs[1].position[1] > iter_32_3.config.position[1] and iter_32_1.node.configs[1].position[2] == iter_32_3.config.position[2] then
					var_32_0 = iter_32_1.node.control.bg.rectTransform.anchoredPosition.x + (self._ship_map_data_list[iter_32_3.config.id].node.control.bg.rectTransform.anchoredPosition.x - iter_32_1.node.control.bg.rectTransform.anchoredPosition.x) / 2
					var_32_1 = iter_32_1.node.control.bg.rectTransform.anchoredPosition.y - var_0_4.workshop_const.size / 2 + var_0_4.workshop_const.arrow_width / 2
					var_32_2 = (iter_32_1.node.configs[1].position[1] - iter_32_3.config.position[1] - 1) * var_0_4.workshop_const.node_width + var_0_4.workshop_const.dis * 2 + (var_0_4.workshop_const.node_width - var_0_4.workshop_const.size)
					var_32_3 = var_0_4.workshop_const.arrow_width
				end

				if iter_32_1.node.configs[1].position[1] == iter_32_3.config.position[1] and iter_32_1.node.configs[1].position[2] > iter_32_3.config.position[2] then
					var_32_0 = iter_32_1.node.control.bg.rectTransform.anchoredPosition.x
					var_32_1 = self._ship_map_data_list[iter_32_3.config.id].node.control.bg.rectTransform.anchoredPosition.y - 80
					var_32_2 = var_0_4.workshop_const.arrow_width
					var_32_3 = (iter_32_1.node.configs[1].position[2] - iter_32_3.config.position[2] - 1) * var_0_4.workshop_const.node_height + var_0_4.workshop_const.dis * 2
				end

				if iter_32_1.node.configs[1].position[1] == iter_32_3.config.position[1] and iter_32_1.node.configs[1].position[2] < iter_32_3.config.position[2] then
					var_32_0 = iter_32_1.node.control.bg.rectTransform.anchoredPosition.x
					var_32_1 = iter_32_1.node.control.bg.rectTransform.anchoredPosition.y - 80
					var_32_2 = var_0_4.workshop_const.arrow_width
					var_32_3 = (iter_32_3.config.position[2] - iter_32_1.node.configs[1].position[2] - 1) * var_0_4.workshop_const.node_height + var_0_4.workshop_const.dis * 2
				end

				iter_32_3.control.arrow.rectTransform.anchoredPosition = var_0_10(var_32_0, var_32_1)
				iter_32_3.control.arrow.rectTransform.sizeDelta = var_0_10(var_32_2, var_32_3)
			end
		end
	end

	function arg_1_0:__get_node_config()
		local var_33_0 = var_0_1:get_workshop_data()

		for iter_33_0, iter_33_1 in pairs(self._ship_map_data_list) do
			iter_33_1.node.first_array = iter_33_1.node.configs[1]
			iter_33_1.node.base_array = iter_33_1.node.configs[2]
			iter_33_1.node.base_lock = iter_33_1.node.configs[2].id
		end

		self:__set_map_node()
		self:__set_map_arrow()
	end

	function arg_1_0.__get_server_data_info(arg_34_0, arg_34_1)
		local var_34_0 = {}

		for iter_34_0, iter_34_1 in pairs(arg_34_1) do
			var_0_5(var_34_0, (var_0_8.find_object_by_id(iter_34_1)))
		end

		return var_34_0
	end

	function arg_1_0.__get_data_base_id(arg_35_0, arg_35_1)
		local var_35_0 = {}

		for iter_35_0, iter_35_1 in pairs(arg_35_1) do
			var_0_5(var_35_0, iter_35_1.base_id)
		end

		return var_35_0
	end

	function arg_1_0.__set_upgrade(arg_36_0, arg_36_1, arg_36_2)
		for iter_36_0, iter_36_1 in pairs(arg_36_1) do
			if iter_36_1 == arg_36_2.base_id then
				return arg_36_2.unlock_id
			end
		end
	end

	function arg_1_0:__set_more_upgrade(arg_37_1, arg_37_2)
		for iter_37_0, iter_37_1 in pairs(arg_37_2) do
			if iter_37_1 == arg_37_1 then
				self.__start_lock_two_num = self.__start_lock_two_num + 1
			end
		end
	end

	function arg_1_0:__lock_id_max(arg_38_1)
		local var_38_0 = var_0_8.find_object_by_id(arg_38_1)

		for iter_38_0, iter_38_1 in pairs(self.__workshop_data) do
			local var_38_1 = var_0_8.find_object_by_id(iter_38_1.id)

			if var_38_0.base_id == var_38_1.base_id and var_38_1.next_id == 0 then
				return false
			end
		end

		return true
	end

	function arg_1_0:__set_map_node()
		local var_39_0 = var_0_4.workshop_const
		local var_39_3 = var_0_1:get_workshop_data()
		local var_39_4 = self:__get_data_base_id((self:__get_server_data_info((var_0_1:get_all_workshop_id()))))

		self.__all_base_id = var_39_4

		local var_39_5 = {}
		local var_39_6 = {}

		for iter_39_0, iter_39_1 in pairs(self._ship_map_data_list) do
			self:__reset_node(iter_39_1.node.control)

			iter_39_1.node.control.bg.unlock.txt.text.text = var_0_2:getNowLang("ui_4th_shop_sort_lock")
			iter_39_1.node.control.bg.unlock.txt.text.color = Color.New(0, 0, 0)
		end

		for iter_39_2, iter_39_3 in pairs(self._ship_map_data_list) do
			local var_39_7 = var_0_8.find_object_by_id(iter_39_3.node.id)
			local var_39_8 = iter_39_3.node.control

			iter_39_3.node.control.bg.icon.image.color = var_39_0.unlock_icon_color
			self.__is_lock = self:__set_upgrade(var_39_4, iter_39_3.node.configs[2])

			if self.__is_lock then
				if #self.__is_lock == 1 then
					local var_39_12 = var_0_8.find_object_by_id(self.__is_lock[1])
					local var_39_13 = var_0_8.find_object_by_id(self.__is_lock[1]).next_id
					local var_39_14 = var_0_8.find_object_by_id(var_39_13).demand
					local var_39_15 = var_0_8.find_object_by_id(var_39_13).need_score
					local var_39_16

					for iter_39_4, iter_39_5 in pairs(var_39_3) do
						if var_39_12.base_id == var_0_8.find_object_by_id(iter_39_4).base_id then
							var_39_16 = iter_39_4
						end
					end

					local var_39_17 = {}

					for iter_39_6, iter_39_7 in pairs(var_39_12.pre_ids) do
						var_0_5(var_39_17, iter_39_7)
					end

					if #var_39_17 == 1 then
						self._ship_map_data_list[self.__is_lock[1]].node.control.bg.unlock:SetActive(false)
						self._ship_map_data_list[self.__is_lock[1]].node.control.bg.upgrade:SetActive(false)

						if var_39_14 <= self._now_ship_ton_item_count and self._ship_map_data_list[self.__is_lock[1]].node.configs[2].need_score <= self._now_ship_type_score then
							local var_39_18 = self:__lock_id_max(self.__is_lock[1])

							self._ship_map_data_list[self.__is_lock[1]].node.control.bg.upgrade:SetActive(true)
							self._ship_map_data_list[self.__is_lock[1]].node.control.bg.unlock:SetActive(false)

							if not var_39_18 then
								self._ship_map_data_list[self.__is_lock[1]].node.control.bg.upgrade:SetActive(false)
							end
						end
					elseif #var_39_17 > 1 then
						self.__start_lock_two_num = 0

						for iter_39_8, iter_39_9 in pairs(var_39_17) do
							self:__set_more_upgrade(var_0_8.find_object_by_id(iter_39_9).base_id, var_39_4)
						end

						self._ship_map_data_list[self.__is_lock[1]].node.control.bg.upgrade:SetActive(false)

						if self.__start_lock_two_num < #var_39_17 then
							self._ship_map_data_list[self.__is_lock[1]].node.control.bg.unlock:SetActive(true)
						elseif self.__start_lock_two_num == #var_39_17 and var_39_14 <= self._now_ship_ton_item_count and self._ship_map_data_list[self.__is_lock[1]].node.configs[2].need_score <= self._now_ship_type_score then
							self._ship_map_data_list[self.__is_lock[1]].node.control.bg.upgrade:SetActive(true)
							self._ship_map_data_list[self.__is_lock[1]].node.control.bg.unlock:SetActive(false)

							if not self:__lock_id_max(self.__is_lock[1]) then
								self._ship_map_data_list[self.__is_lock[1]].node.control.bg.upgrade:SetActive(false)
							end
						elseif self.__start_lock_two_num == #var_39_17 and self._ship_map_data_list[self.__is_lock[1]].node.configs[2].need_score <= self._now_ship_type_score and var_39_14 > self._now_ship_ton_item_count then
							self._ship_map_data_list[self.__is_lock[1]].node.control.bg.upgrade:SetActive(false)
							self._ship_map_data_list[self.__is_lock[1]].node.control.bg.unlock:SetActive(false)

							if not self:__lock_id_max(self.__is_lock[1]) then
								self._ship_map_data_list[self.__is_lock[1]].node.control.bg.upgrade:SetActive(false)
							end
						end
					end

					if var_39_16 then
						local var_39_19 = var_0_8.find_object_by_id(var_39_16).next_id

						if var_39_19 ~= 0 and var_0_8.find_object_by_id(var_39_19).demand > self._now_ship_ton_item_count then
							self._ship_map_data_list[self.__is_lock[1]].node.control.bg.upgrade:SetActive(false)
						end
					end
				elseif #self.__is_lock > 1 then
					for iter_39_10, iter_39_11 in pairs(self.__is_lock) do
						local var_39_20 = var_0_8.find_object_by_id(iter_39_11)
						local var_39_22 = var_0_8.find_object_by_id(iter_39_11).next_id
						local var_39_23 = var_0_8.find_object_by_id(var_39_22).demand
						local var_39_24 = var_0_8.find_object_by_id(var_39_22).need_score
						local var_39_26 = var_0_9.dict_lenght(var_39_20.pre_ids)

						if not self._ship_map_data_list[iter_39_11].node.control.bg.upgrade.activeSelf then
							self._ship_map_data_list[iter_39_11].node.control.bg.upgrade:SetActive(false)
						end

						if not self._ship_map_data_list[iter_39_11].node.control.bg.unlock.activeSelf then
							self._ship_map_data_list[iter_39_11].node.control.bg.unlock:SetActive(false)
						end

						local var_39_27

						for iter_39_12, iter_39_13 in pairs(var_39_3) do
							if var_39_20.base_id == var_0_8.find_object_by_id(iter_39_12).base_id then
								var_39_27 = iter_39_12
							end
						end

						if var_39_26 == 1 then
							if var_39_23 <= self._now_ship_ton_item_count and self._now_ship_type_score >= var_39_20.score then
								self._ship_map_data_list[iter_39_11].node.control.bg.upgrade:SetActive(true)
								self._ship_map_data_list[iter_39_11].node.control.bg.unlock:SetActive(false)

								if not self:__lock_id_max(self.__is_lock[iter_39_10]) then
									self._ship_map_data_list[iter_39_11].node.control.bg.upgrade:SetActive(false)
								end
							elseif var_39_23 > self._now_ship_ton_item_count and self._now_ship_type_score >= var_39_20.score then
								self._ship_map_data_list[iter_39_11].node.control.bg.unlock:SetActive(false)
								self._ship_map_data_list[iter_39_11].node.control.bg.upgrade:SetActive(false)
							end
						elseif var_39_26 > 1 then
							self._ship_map_data_list[iter_39_11].node.control.bg.unlock:SetActive(true)

							local var_39_28 = 0

							for iter_39_14, iter_39_15 in pairs(var_39_20.pre_ids) do
								local var_39_29 = var_0_8.find_object_by_id(iter_39_15).base_id

								for iter_39_16, iter_39_17 in pairs(self.__all_base_id) do
									if iter_39_17 == var_39_29 then
										var_39_28 = var_39_28 + 1
									end
								end
							end

							if var_39_28 ~= var_39_26 then
								self._ship_map_data_list[iter_39_11].node.control.bg.upgrade:SetActive(false)
							else
								self._ship_map_data_list[iter_39_11].node.control.bg.unlock:SetActive(false)
								self._ship_map_data_list[iter_39_11].node.control.bg.upgrade:SetActive(true)

								if not self:__lock_id_max(self.__is_lock[iter_39_10]) then
									self._ship_map_data_list[iter_39_11].node.control.bg.upgrade:SetActive(false)
								end
							end
						end

						if var_39_27 then
							local var_39_30 = var_0_8.find_object_by_id(var_39_27).next_id

							if var_39_30 ~= 0 and var_0_8.find_object_by_id(var_39_30).demand > self._now_ship_ton_item_count then
								self._ship_map_data_list[iter_39_11].node.control.bg.upgrade:SetActive(false)
							end
						end
					end
				elseif not var_0_12(iter_39_3.node.configs[1].pre_ids) then
					var_39_8.bg.upgrade:SetActive(false)
					var_39_8.bg.unlock:SetActive(false)

					if self._now_ship_ton_item_count >= iter_39_3.node.configs[2].demand then
						var_39_8.bg.upgrade:SetActive(true)
					end
				end
			elseif not self.__is_lock and not var_0_12(iter_39_3.node.configs[1].pre_ids) then
				var_39_8.bg.upgrade:SetActive(false)
				var_39_8.bg.unlock:SetActive(false)

				if self._now_ship_ton_item_count >= iter_39_3.node.configs[2].demand then
					var_39_8.bg.upgrade:SetActive(true)
				end
			end

			for iter_39_18, iter_39_19 in pairs(iter_39_3.node.configs) do
				local var_39_31 = var_0_8.find_object_by_id(iter_39_19.id)
				local var_39_32

				if var_39_31.next_id ~= 0 then
					var_39_32 = var_0_8.find_object_by_id(var_39_31.next_id)
				end

				if not var_0_12(var_39_3) then
					if not var_0_12(iter_39_19.pre_ids) and iter_39_19.id == iter_39_3.node.id then
						var_0_5(var_39_5, iter_39_3.node.id)

						if #var_39_5 == 1 then
							var_39_8.bg.unlock:SetActive(false)
							var_39_8.bg.selected:SetActive(true)
							var_39_8.bg.unlock_bg:SetActive(true)

							if var_39_31 ~= 0 and self._now_ship_ton_item_count >= var_39_32.demand and self._now_ship_type_score >= var_39_31.score then
								var_39_8.bg.upgrade:SetActive(true)
							end
						elseif #var_39_5 > 1 then
							for iter_39_20, iter_39_21 in pairs(var_39_5) do
								self._ship_map_data_list[iter_39_21].node.control.bg.selected:SetActive(false)
							end

							self._ship_map_data_list[self:__set_min(var_39_5)].node.control.bg.selected:SetActive(true)
						end
					end
				elseif var_0_12(var_39_3) then
					for iter_39_22, iter_39_23 in pairs(var_39_3) do
						if iter_39_19.id == iter_39_23.id then
							var_39_8.bg.processing:SetActive(true)
							var_39_8.bg.unlock:SetActive(false)
							var_39_8.bg.unlock_bg:SetActive(false)

							var_39_8.bg.icon.image.color = var_39_0.processing_icon_color

							var_39_8.bg.grade_info:SetActive(true)

							var_39_8.bg.grade_info.txt.text.text = "LV" .. " " .. var_0_8.find_object_by_id(iter_39_23.id).level

							if var_39_31.next_id ~= 0 and var_39_32 then
								if self._now_ship_type_score >= var_39_31.score and self._now_ship_ton_item_count >= var_39_32.demand then
									var_39_8.bg.upgrade:SetActive(true)
								end
							elseif var_39_31.next_id == 0 then
								var_39_8.bg.processing:SetActive(false)
								var_39_8.bg.processed:SetActive(true)
								var_39_8.bg.upgrade:SetActive(false)

								var_39_8.bg.icon.image.color = var_39_0.processed_icon_color
							end
						end
					end
				end
			end

			var_39_8.bg.icon:SetActive(true)
			var_39_8.bg.button.onClick:RemoveAllListeners()
			var_39_8.bg.button.onClick:AddListener(function()
				self:__show_node_info(iter_39_3)
			end)

			for iter_39_24, iter_39_25 in pairs(iter_39_3.node.configs) do
				if iter_39_25.pre_id == 0 then
					var_0_5(var_39_6, iter_39_2)
				end
			end
		end

		if var_0_12(var_39_6) and #var_39_6 == 1 then
			self._default_click_node = self._ship_map_data_list[var_39_6[1]]
		elseif var_0_12(var_39_6) and #var_39_6 > 1 then
			self._default_click_node = self._ship_map_data_list[self:__set_min(var_39_6)]
		end
	end

	function arg_1_0.__set_min(arg_41_0, arg_41_1)
		local var_41_0 = {}

		for iter_41_0, iter_41_1 in pairs(arg_41_1) do
			var_0_5(var_41_0, iter_41_1)
		end

		local var_41_1 = var_41_0[1]

		for iter_41_2, iter_41_3 in pairs(var_41_0) do
			if iter_41_3 < var_41_1 then
				var_41_1 = iter_41_3
			end
		end

		return var_41_1
	end

	function arg_1_0.__arrow_lock(arg_42_0, arg_42_1, arg_42_2)
		for iter_42_0, iter_42_1 in pairs(arg_42_1) do
			if iter_42_1 == arg_42_2.base_id then
				return arg_42_2
			end
		end
	end

	function arg_1_0:__set_map_arrow()
		self._now_server_data = var_0_1:get_workshop_data()

		for iter_43_0, iter_43_1 in pairs(self._ship_map_data_list) do
			local var_43_0 = var_0_8.find_object_by_id(iter_43_1.node.id)

			if var_0_12(iter_43_1.arrows) then
				for iter_43_2, iter_43_3 in pairs(iter_43_1.arrows) do
					local var_43_1
					local var_43_2 = not not self:__arrow_lock(self.__all_base_id, var_43_0)

					if iter_43_1.node.configs[1].position[1] < iter_43_3.config.position[1] and iter_43_1.node.configs[1].position[2] == iter_43_3.config.position[2] then
						var_43_1 = not var_43_2 and var_0_4.workshop_const.workshop_inactive_right or var_0_4.workshop_const.workshop_activation_right
					end

					if iter_43_1.node.configs[1].position[1] > iter_43_3.config.position[1] and iter_43_1.node.configs[1].position[2] == iter_43_3.config.position[2] then
						var_43_1 = not var_43_2 and var_0_4.workshop_const.workshop_inactive_left or var_0_4.workshop_const.workshop_activation_left
					end

					if iter_43_1.node.configs[1].position[1] == iter_43_3.config.position[1] and iter_43_1.node.configs[1].position[2] > iter_43_3.config.position[2] then
						var_43_1 = not var_43_2 and var_0_4.workshop_const.workshop_inactive_up or var_0_4.workshop_const.workshop_activation_up
					end

					if iter_43_1.node.configs[1].position[1] == iter_43_3.config.position[1] and iter_43_1.node.configs[1].position[2] < iter_43_3.config.position[2] then
						var_43_1 = not var_43_2 and var_0_4.workshop_const.workshop_inactive_down or var_0_4.workshop_const.workshop_activation_down
					end

					if var_43_1 then
						iter_43_3.control.arrow.image.sprite = self:loadSprite(var_43_1)
					end
				end
			end
		end
	end

	function arg_1_0.__get_click_info(arg_44_0, arg_44_1, arg_44_2)
		local var_44_0 = var_0_8.find_object_by_id(arg_44_1.id).base_id

		for iter_44_0, iter_44_1 in pairs(arg_44_2) do
			if var_44_0 == var_0_8.find_object_by_id(iter_44_1.id).base_id then
				return iter_44_1.id
			end
		end

		return arg_44_1.id
	end

	function arg_1_0:__lock_num_func(arg_45_1, arg_45_2)
		for iter_45_0, iter_45_1 in pairs(arg_45_2) do
			if iter_45_1 == arg_45_1 then
				if self.__lock_num then
					self.__lock_num = self.__lock_num + 1
				end

				if self.__start_lock_num then
					self.__start_lock_num = self.__start_lock_num + 1
				end
			end
		end
	end

	function arg_1_0:__is_have_pre(arg_46_1, arg_46_2)
		local var_46_0 = var_0_8.find_object_by_id(arg_46_2)
		local var_46_1 = var_0_8.find_object_by_id(var_46_0.next_id)
		local var_46_2 = {}

		for iter_46_0, iter_46_1 in pairs(var_46_0.pre_ids) do
			var_0_5(var_46_2, iter_46_1)
		end

		if not var_0_12(var_46_0.pre_ids) then
			return false
		end

		if var_0_12(var_46_2) then
			if #var_46_2 == 1 then
				local var_46_3 = var_0_8.find_object_by_id(var_46_2[1])

				if not var_0_12(var_46_3.pre_ids) then
					if not var_0_12((var_0_1:get_workshop_data())) then
						return true
					else
						for iter_46_2, iter_46_3 in pairs(arg_46_1) do
							if iter_46_3 == var_46_3.base_id then
								return false
							end
						end

						return true
					end
				else
					for iter_46_4, iter_46_5 in pairs(arg_46_1) do
						if iter_46_5 == var_46_3.base_id then
							return false
						end
					end

					return true
				end
			else
				self.__lock_num = 0

				for iter_46_6, iter_46_7 in pairs(var_46_2) do
					self:__lock_num_func(var_0_8.find_object_by_id(iter_46_7).base_id, arg_46_1)
				end

				if self.__lock_num == #var_46_2 then
					return false
				end

				return true
			end
		end

		return false
	end

	function arg_1_0:__show_node_info(arg_47_1)
		local var_47_1 = var_0_1:get_workshop_data()
		local var_47_3 = self:__is_have_pre(self.__all_base_id, arg_47_1.node.id)

		self:__reset_node_desc()

		if self._last_click_node then
			self._last_click_node.node.control.bg.selected:SetActive(false)
		end

		arg_47_1.node.control.bg.selected:SetActive(true)

		self._last_click_node = arg_47_1

		self._control.ship_scroll_view.lattice_scroll_view.ship_info.desc_bg:SetActive(true)

		if not var_0_12(var_47_1) then
			local var_47_4 = var_0_8.find_object_by_id(arg_47_1.node.first_array.next_id)

			self._control.ship_scroll_view.lattice_scroll_view.ship_info.desc_bg.scrollview.desc.text.text = self:__get_txt(arg_47_1.node.first_array.effect_desc)
			self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt3.text.text = var_47_4.demand

			if self._now_ship_type_score < arg_47_1.node.first_array.score then
				self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_1:SetActive(true)

				self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt2.text.color = var_0_13
				self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt3.text.color = var_0_13
				self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_1.txt2.text.text = arg_47_1.node.first_array.score
			else
				self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2:SetActive(true)

				if self._now_ship_ton_item_count < var_47_4.demand then
					self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt2.text.color = var_0_13
					self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt3.text.color = var_0_13

					self._control.ship_scroll_view.lattice_scroll_view.ship_info.cancel:SetActive(true)

					if var_47_3 then
						self._control.ship_scroll_view.lattice_scroll_view.ship_info.confirm:SetActive(false)
						self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2:SetActive(false)
						self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3:SetActive(true)
						self._control.ship_scroll_view.lattice_scroll_view.ship_info.cancel:SetActive(true)

						self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3.txt1.text.text = var_0_2:getNowLang("workshop_tip1")
						self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3.txt1.text.color = var_0_13
					end
				else
					self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt2.text.color = var_0_14
					self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt3.text.color = var_0_14

					self._control.ship_scroll_view.lattice_scroll_view.ship_info.confirm:SetActive(true)

					if var_47_3 then
						self._control.ship_scroll_view.lattice_scroll_view.ship_info.confirm:SetActive(false)
						self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2:SetActive(false)
						self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3:SetActive(true)
						self._control.ship_scroll_view.lattice_scroll_view.ship_info.cancel:SetActive(true)

						self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3.txt1.text.text = var_0_2:getNowLang("workshop_tip1")
						self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3.txt1.text.color = var_0_13
					end
				end
			end
		else
			local var_47_5 = self:__get_click_info(arg_47_1.node, var_47_1)

			self.__now_next_id = var_0_8.find_object_by_id(var_47_5).next_id

			local var_47_6 = var_0_8.find_object_by_id(var_47_5).pre_ids

			for iter_47_0, iter_47_1 in pairs(arg_47_1.node.configs) do
				if var_47_5 == iter_47_1.id then
					self._control.ship_scroll_view.lattice_scroll_view.ship_info.desc_bg.scrollview.desc.text.text = self:__get_txt(arg_47_1.node.configs[iter_47_0].effect_desc)

					if arg_47_1.node.configs[iter_47_0].next_id ~= 0 then
						local var_47_7 = var_0_8.find_object_by_id(arg_47_1.node.configs[iter_47_0].next_id)

						self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt3.text.text = var_0_8.find_object_by_id(self.__now_next_id).demand

						if not var_0_12(var_47_6) then
							self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2:SetActive(true)

							if self._now_ship_ton_item_count < var_47_7.demand then
								self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt2.text.color = var_0_13
								self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt3.text.color = var_0_13

								self._control.ship_scroll_view.lattice_scroll_view.ship_info.cancel:SetActive(true)
							elseif self._now_ship_ton_item_count >= var_47_7.demand then
								self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt2.text.color = var_0_14
								self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt3.text.color = var_0_14

								self._control.ship_scroll_view.lattice_scroll_view.ship_info.confirm:SetActive(true)
							end
						elseif var_0_12(var_47_6) and self._now_ship_type_score < arg_47_1.node.configs[iter_47_0 + 1].need_score then
							self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_1:SetActive(true)

							self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_1.txt2.text.text = arg_47_1.node.configs[iter_47_0 + 1].need_score

							self._control.ship_scroll_view.lattice_scroll_view.ship_info.cancel:SetActive(true)

							if var_47_3 then
								self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_1:SetActive(false)
								self._control.ship_scroll_view.lattice_scroll_view.ship_info.confirm:SetActive(false)
								self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2:SetActive(false)
								self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3:SetActive(true)

								self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3.txt1.text.text = var_0_2:getNowLang("workshop_tip1")
								self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3.txt1.text.color = var_0_13
							end
						else
							self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2:SetActive(true)

							if self._now_ship_ton_item_count < var_47_7.demand then
								self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt2.text.color = var_0_13
								self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt3.text.color = var_0_13

								self._control.ship_scroll_view.lattice_scroll_view.ship_info.cancel:SetActive(true)
							elseif self._now_ship_ton_item_count >= var_47_7.demand then
								self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt2.text.color = var_0_14
								self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt3.text.color = var_0_14

								self._control.ship_scroll_view.lattice_scroll_view.ship_info.confirm:SetActive(true)

								if var_47_3 then
									self._control.ship_scroll_view.lattice_scroll_view.ship_info.confirm:SetActive(false)
									self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2:SetActive(false)
									self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3:SetActive(true)
									self._control.ship_scroll_view.lattice_scroll_view.ship_info.cancel:SetActive(true)

									self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3.txt1.text.text = var_0_2:getNowLang("workshop_tip1")
									self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3.txt1.text.color = var_0_13
								end
							end
						end
					else
						self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3:SetActive(true)
					end
				end
			end
		end
	end

	function arg_1_0:__add_scroll_view_listener()
		self._control.ship_scroll_view.lattice_scroll_view.scrollRect.onValueChanged:RemoveAllListeners()
		self._control.ship_scroll_view.lattice_scroll_view.scrollRect.onValueChanged:AddListener(function()
			return
		end)
	end

	function arg_1_0:upgrade_workshop_resp()
		var_0_3:createInstance("loading"):show(false)
		var_0_11:show(var_0_2:getNowLang("workshop_tip2"))

		self._now_ship_ton_item_count = var_0_1:get_workshop_item_count(self._ship_ton)
		self._control.top_menu.money_bg.num.text.text = self._now_ship_ton_item_count

		self:__set_workshop_score()
		self:__get_node_config()

		local var_50_0 = {}

		for iter_50_0, iter_50_1 in pairs(self._ship_map_data_list) do
			if var_0_8.find_object_by_id(iter_50_1.node.id).base_id == self._last_click_node.node.configs[1].base_id then
				var_50_0 = iter_50_1

				break
			end
		end

		self:__show_node_info(var_50_0)

		self.__click_upgrade_button_state = 0
	end

	function arg_1_0.__get_map_data(arg_51_0)
		return
	end

	function arg_1_0:__select_top_toggle(arg_52_1)
		if arg_52_1 == self._ship_ton then
			return
		end

		self._ship_ton = arg_52_1
		self._now_ship_ton_item_count = var_0_1:get_workshop_item_count(self._ship_ton)
		self._control.top_menu.money_bg.num.text.text = self._now_ship_ton_item_count
		self._control.top_menu.money_bg.icon.image.sprite = self:loadSprite(var_0_7(var_0_4.workshop_const.workshop_item_icon, self._ship_ton))
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.icon.image.sprite = self:loadSprite(var_0_7(var_0_4.workshop_const.workshop_item_icon, self._ship_ton))

		self:__clear_tweener()
		self:__load_chapter_scroll_view()
		self:__hide_all_map_fragment_to_pool()
		self:__init_workshop_panel()
		self:__set_icon_by_captater()
		self:__set_scroll_view()
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_constant()
			self:__init_language()
			self:__preload_map_fragment()

			self._is_already_init = true
		end

		local var_53_0 = var_0_3:getInstance("home")

		if var_53_0 then
			var_53_0:setVisible(false)
		end

		self._init_chapter_index = 1
		self._control.top_menu.tab_toggle[var_0_7("tab_%d", 1)].toggle.isOn = true
		self._ship_ton = nil

		self:__select_top_toggle(var_0_4.ship_ton.small)
		self:__set_icon_by_captater()
		self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.workshop_bgm))
		self:__play_top_menu_in_animation()
		self:__play_chapter_panel_in_animation()
	end

	function arg_1_0.__destroy_panel(arg_54_0)
		local var_54_0 = var_0_3:createInstance("main_menu")

		var_54_0:show(false)
		var_54_0:reset()
		var_0_3:destroyInstance("workshop")
	end

	function arg_1_0:__init_language()
		self._control.top_menu.tab_toggle.tab_1.sbt1.text.text = var_0_2:getNowLang("shipton1")
		self._control.top_menu.tab_toggle.tab_2.sbt2.text.text = var_0_2:getNowLang("shipton2")
		self._control.top_menu.tab_toggle.tab_3.sbt3.text.text = var_0_2:getNowLang("shipton3")
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.desc_bg.title.text.text = var_0_2:getNowLang("workshop_effect")
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_1.txt1.text.text = var_0_2:getNowLang("need_scientific_meet")
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt1.text.text = var_0_2:getNowLang("workshop_need")
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3.txt1.text.text = "------"
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_3.txt2.text.text = var_0_2:getNowLang("workshop_max_grade")
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.cancel.txt.text.text = var_0_2:getNowLang("workshop_process")
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.confirm.txt.text.text = var_0_2:getNowLang("workshop_process")
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.condition_2.txt2.text.text = "x"
		self._control.ship_scroll_view.lattice_scroll_view.ship_info.desc_bg.title.text.text = var_0_2:getNowLang("ui_4th_buff_type_0")
	end

	function arg_1_0:__init_constant()
		local var_56_0 = {}
		local var_56_1 = {}
		local var_56_2, var_56_3 = var_0_8.get_sequence()

		for iter_56_0, iter_56_1 in pairs(var_56_2) do
			if var_56_1[iter_56_1.ship_type] == nil then
				var_56_1[iter_56_1.ship_type] = {}
			end

			if var_56_1[iter_56_1.ship_type][iter_56_1.base_id] == nil then
				var_56_1[iter_56_1.ship_type][iter_56_1.base_id] = {}
			end

			var_0_5(var_56_1[iter_56_1.ship_type][iter_56_1.base_id], iter_56_1)
		end

		for iter_56_2, iter_56_3 in pairs(var_56_1) do
			if var_56_0[iter_56_2] == nil then
				var_56_0[iter_56_2] = {}
			end

			for iter_56_4, iter_56_5 in pairs(iter_56_3) do
				var_0_5(var_56_0[iter_56_2], iter_56_5)
			end
		end

		self._allShipTonTb = var_56_0
		self._ship_type_list = {
			{},
			{},
			{}
		}

		local var_56_4 = {}

		for iter_56_6, iter_56_7 in pairs(var_56_2) do
			var_56_4[iter_56_7.ship_type] = iter_56_7.ship_type
		end

		for iter_56_8, iter_56_9 in pairs(var_56_4) do
			for iter_56_10, iter_56_11 in pairs(var_0_4.ship_type_rule) do
				if iter_56_8 == iter_56_11.value then
					var_0_5(self._ship_type_list[iter_56_11.size], {
						full_lan = iter_56_11.full_lan,
						size = iter_56_11.size,
						simplified_lan = iter_56_11.simplified_lan,
						value = iter_56_11.value
					})
				end
			end
		end

		for iter_56_12, iter_56_13 in pairs(self._ship_type_list) do
			var_0_6(iter_56_13, function(arg_57_0, arg_57_1)
				return var_56_0[arg_57_0.value][1][1].id < var_56_0[arg_57_1.value][1][1].id
			end)
		end
	end

	function arg_1_0:__onReset()
		self:__hide_all_map_fragment_to_pool()

		self._ship_ton = nil

		self:__onToggle_top_menu_tab_toggle_tab_1()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_59_0)
	local var_59_0 = var_0_3:class("workshop")

	var_59_0._is_already_init = false
	var_59_0._ship_type_list = {
		{},
		{},
		{}
	}
	var_59_0._obj_pool = {}
	var_59_0._ship_ton = nil
	var_59_0._init_chapter_index = nil
	var_59_0._chapter_scroll_view = nil
	var_59_0._chapterItemControl_list = {}
	var_59_0._map_scroll_view_control = nil
	var_59_0._allShipTonTb = {}
	var_59_0._ship_map_data_list = {}
	var_59_0._now_ship_ton_item_count = 0
	var_59_0._last_click_node = nil
	var_59_0._now_click_node_data = {}
	var_59_0._now_ship_type_score = 0
	var_59_0._default_click_node = nil
	var_59_0._now_server_data = {}
	var_59_0.__server_data = {}
	var_59_0.__is_lock = nil
	var_59_0.__all_base_id = {}
	var_59_0.__all_id = {}
	var_59_0.__now_next_id = nil
	var_59_0.__lock_num = nil
	var_59_0.__start_lock_num = nil
	var_59_0.__start_lock_two_num = nil
	var_59_0.__workshop_data = nil
	var_59_0.__click_upgrade_button_state = 0

	return var_59_0
end

return var_0_0
