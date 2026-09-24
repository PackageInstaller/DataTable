local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = UnityEngine.Vector2
local var_0_4 = gamecore.Language
local var_0_5 = gameenum.common_type
local var_0_6 = gameconfig.ship_config
local var_0_8 = gameconfig.ship_research_config
local var_0_9 = gamecore.util_func
local var_0_10 = table.insert
local var_0_11 = string.format
local var_0_12 = gameconfig.equip_config
local var_0_13 = gameconfig.item_config
local var_0_14 = gamecore.prompt
local var_0_15 = gameconfig.research_equip_config

gamecore.UILoader:define("research_development", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end

		if self._do_not_to_research then
			self:set_click_info()
		end
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)

		self._now_ship_id = arg_3_1

		self:now_research_id(self._now_ship_id)

		self._equie_info = var_0_2:get_equip_task_info()

		self:__init_panel()
		self:set_research_ship_all_stage(arg_3_1)
		self:_update_now_stage_info()
	end

	function arg_1_0:__init_panel()
		self:_init_equip_list()
		self:__init_data()
		self:_init_language()
		self:set_init_info()
		self:_init_score_list()
		self:__update_reusable_cell()
		self:updata_ship_task_state()

		self._click_stage = 1
	end

	function arg_1_0:set_init_info()
		self._control.ship_icon.transform.localScale = Vector3.New(1, 1, 1)

		local var_5_0 = var_0_8.find_object_by_id(self._now_ship_id)
		local var_5_1 = var_0_6.find_object_by_cid(var_5_0.ship_id)
		local var_5_2 = var_0_9:use_big_break_painting(var_5_1, var_0_5.ship_icon_type.model_l, false)
		local var_5_3, var_5_4 = self:loadSprite(var_0_5:get_ship_icon(var_5_2, var_5_1.pic_id))

		if var_5_4 then
			self._control.ship_icon.rectTransform.anchoredPosition = Vector3(var_5_0.position[1], var_5_0.position[2], 0)
			self._control.ship_icon.transform.localScale = Vector3.New(0.5 * var_5_0.size, 0.5 * var_5_0.size, 1)
		else
			self._control.ship_icon.rectTransform.anchoredPosition = Vector3(var_5_0.position[1], var_5_0.position[2], 0)
			self._control.ship_icon.transform.localScale = Vector3.New(1 * var_5_0.size, 1 * var_5_0.size, 1)
		end

		self._control.ship_icon.image.sprite = self:loadSprite(var_0_5:get_ship_icon(var_5_2, var_5_1.pic_id))

		for iter_5_0, iter_5_1 in pairs(self.__equip_bg_list) do
			iter_5_1.gameObject:SetActive(false)
		end

		for iter_5_2, iter_5_3 in pairs(self.__equip_list) do
			iter_5_3.gameObject:SetActive(false)
		end

		for iter_5_4, iter_5_5 in pairs(self.__aquip_txt_bg_list) do
			iter_5_5.gameObject:SetActive(false)
		end

		self._equip_conf_list = {}

		for iter_5_6, iter_5_7 in pairs(var_5_0.equipment) do
			if iter_5_7 then
				self.__equip_bg_list[iter_5_6].gameObject:SetActive(true)
				self.__equip_list[iter_5_6].gameObject:SetActive(true)

				local var_5_6 = var_0_12.find_object_by_cid(var_0_15.find_object_by_id(iter_5_7).equipment_id)

				self.__equip_list[iter_5_6].image.sprite = self:loadSprite(var_0_11(var_0_5.equip_icon.large, var_5_6.pic_id))
				self.__equip_bg_list[iter_5_6].image.sprite = self:loadSprite(var_0_11(var_0_5.research_equip_back_normal, var_5_6.star))
				self._equip_conf_list[iter_5_7] = var_5_6
			end
		end

		for iter_5_8, iter_5_9 in pairs(self.__equip_finish_list) do
			if self._equp_all_info[iter_5_8] and self._equp_all_info[iter_5_8].status == 1 then
				iter_5_9.image.sprite = self:loadSprite(var_0_5.research_task_image.finish)

				self.__aquip_select_list[iter_5_8].gameObject:SetActive(true)
			end
		end

		for iter_5_10, iter_5_11 in pairs(self.__equip_ongoing_list) do
			if self._equp_all_info[iter_5_10] and self._equp_all_info[iter_5_10].status == 0 and iter_5_10 == 1 then
				iter_5_11.image.sprite = self:loadSprite(var_0_5.research_task_image.ongoing)

				self.__equip_ongoing_list[iter_5_10].gameObject:SetActive(true)
				self.__equip_finish_list[iter_5_10].gameObject:SetActive(false)
				self.__aquip_select_list[iter_5_10].gameObject:SetActive(true)
			end
		end

		self:update_set_research_equip_task_info()
		self._control.detail_shadow.gameObject:SetActive(false)
	end

	function arg_1_0:__show_equip_att(arg_6_1)
		self._equip_attr = self._equip_attr or self:loadUI("equip_attr")

		if self._equip_conf_list[arg_6_1] then
			self._control.detail_shadow.gameObject:SetActive(true)
			self._equip_attr:setVisible(true)
			self._equip_attr:show(self._equip_conf_list[arg_6_1])
		end
	end

	function arg_1_0:__init_data()
		self.__equip_bg_list = {
			self._control.research_bureau_bg.left.ship_research.aquip_bg_1,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_2,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_3,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_4
		}
		self.__equip_finish_list = {
			self._control.research_bureau_bg.left.ship_research.aquip_bg_1.aquip_finish_1,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_2.aquip_finish_2,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_3.aquip_finish_3,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_4.aquip_finish_4
		}
		self.__equip_ongoing_list = {
			self._control.research_bureau_bg.left.ship_research.aquip_bg_1.aquip_ongoing_1,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_2.aquip_ongoing_2,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_3.aquip_ongoing_3,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_4.aquip_ongoing_4
		}
		self.__equip_list = {
			self._control.research_bureau_bg.left.ship_research.aquip_bg_1.aquip_1,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_2.aquip_2,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_3.aquip_3,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_4.aquip_4
		}
		self.__aquip_txt_list = {
			self._control.research_bureau_bg.left.ship_research.aquip_bg_1.can_receive_image_1.aquip_txt_1,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_2.can_receive_image_2.aquip_txt_2,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_3.can_receive_image_3.aquip_txt_3,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_4.can_receive_image_4.aquip_txt_4
		}
		self.__aquip_txt_bg_list = {
			self._control.research_bureau_bg.left.ship_research.aquip_bg_1.can_receive_image_1,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_2.can_receive_image_2,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_3.can_receive_image_3,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_4.can_receive_image_4
		}
		self.__aquip_choose_list = {
			self._control.research_bureau_bg.left.ship_research.aquip_bg_1.choose_1,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_2.choose_2,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_3.choose_3,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_4.choose_4
		}
		self.__aquip_select_list = {
			self._control.research_bureau_bg.left.ship_research.aquip_bg_1.select_btn_1,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_2.select_btn_2,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_3.select_btn_3,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_4.select_btn_4
		}
		self.__ship_task_list = {
			self._control.research_bureau_bg.right.ship_show.ship_research_1,
			self._control.research_bureau_bg.right.ship_show.ship_research_2,
			self._control.research_bureau_bg.right.ship_show.ship_research_3,
			self._control.research_bureau_bg.right.ship_show.ship_research_4
		}
		self.__ship_task_time_img_list = {
			self._control.research_bureau_bg.right.ship_show.ship_research_1.ship_time_img_1,
			self._control.research_bureau_bg.right.ship_show.ship_research_2.ship_time_img_2,
			self._control.research_bureau_bg.right.ship_show.ship_research_3.ship_time_img_3,
			self._control.research_bureau_bg.right.ship_show.ship_research_4.ship_time_img_4
		}
		self.__ship_task_time_img_list_2 = {
			self._control.research_bureau_bg.right.ship_show.ship_research_1.countdown_1,
			self._control.research_bureau_bg.right.ship_show.ship_research_2.countdown_2,
			self._control.research_bureau_bg.right.ship_show.ship_research_3.countdown_3,
			self._control.research_bureau_bg.right.ship_show.ship_research_4.countdown_4
		}
		self.__ship_stage_task_name_list = {
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_1.ship_task_name_1,
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_2.ship_task_name_2,
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_3.ship_task_name_3
		}
		self.__ship_stage_task_name_list_3 = {
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_1.name_1_level,
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_2.name_2_level,
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_3.name_3_level
		}
		self.__ship_stage_task_finish_name_list = {
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_1.ship_task_finish_name_1,
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_2.ship_task_finish_name_2,
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_3.ship_task_finish_name_3
		}
		self.__ship_stage_task_progress_time_list = {
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_1.ship_progress_bg_1.ship_progress_time_1,
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_2.ship_progress_bg_2.ship_progress_time_2,
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_3.ship_progress_bg_3.ship_progress_time_3
		}
		self.__ship_stage_ship_task_text_list = {
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_1.ship_task_text_1,
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_2.ship_task_text_2,
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_3.ship_task_text_3
		}
		self.__ship_stage_ship_task_finish_list = {
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_1.ship_task_finish_1,
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_2.ship_task_finish_2,
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_3.ship_task_finish_3
		}
		self.__ship_stage_start_btn_list = {
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_1.ship_start_btn_1,
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_2.ship_start_btn_2,
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_3.ship_start_btn_3
		}
		self.__ship_stage_start_btn_text_list = {
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_1.ship_start_btn_1.ship_start_btn_txt_1,
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_2.ship_start_btn_2.ship_start_btn_txt_2,
			self._control.research_bureau_bg.right.ship_show.ship_research.ship_task.ship_task_3.ship_start_btn_3.ship_start_btn_txt_3
		}
		self.__equip_task_name_list = {
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_1.task_name_1,
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_2.task_name_2,
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_3.task_name_3
		}
		self.__equip_task_name_list_2 = {
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_1.name_1_task_name_1,
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_2.name_2_task_name_2,
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_3.name_3_task_name_3
		}
		self.__equip_finish_name_list = {
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_1.task_finish_name_1,
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_2.task_finish_name_2,
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_3.task_finish_name_3
		}
		self.__equip_progress_time_list = {
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_1.progress_bg_1.progress_time_1,
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_2.progress_bg_2.progress_time_2,
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_3.progress_bg_3.progress_time_3
		}
		self.__equip_task_text_list = {
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_1.task_text_1,
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_2.task_text_2,
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_3.task_text_3
		}
		self.__equip_start_btn_list = {
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_1.start_btn_1,
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_2.start_btn_2,
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_3.start_btn_3
		}
		self.__equip_start_btn_txt_list = {
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_1.start_btn_1.start_btn_txt_1,
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_2.start_btn_2.start_btn_txt_2,
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_3.start_btn_3.start_btn_txt_3
		}
		self.__equip_task_finish_list = {
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_1.task_finish_1,
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_2.task_finish_2,
			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_3.task_finish_3
		}
		self.__ship_task_finish_list = {
			self._control.research_bureau_bg.right.ship_show.ship_research_1.ship_finish_img_1,
			self._control.research_bureau_bg.right.ship_show.ship_research_2.ship_finish_img_2,
			self._control.research_bureau_bg.right.ship_show.ship_research_3.ship_finish_img_3,
			self._control.research_bureau_bg.right.ship_show.ship_research_4.ship_finish_img_4
		}
		self.__ship_research_title = {
			self._control.research_bureau_bg.right.ship_show.ship_research_1.ship_research_image_1.ship_research_title_1,
			self._control.research_bureau_bg.right.ship_show.ship_research_2.ship_research_image_2.ship_research_title_2,
			self._control.research_bureau_bg.right.ship_show.ship_research_3.ship_research_image_3.ship_research_title_3
		}
		self.__ship_research_tage_title = {
			self._control.research_bureau_bg.right.ship_show.ship_research_1.ship_research_image_1,
			self._control.research_bureau_bg.right.ship_show.ship_research_2.ship_research_image_2,
			self._control.research_bureau_bg.right.ship_show.ship_research_3.ship_research_image_3
		}
		self.__equip_progress_bg_list = {
			self._control.research_bureau_bg.left.ship_research.aquip_bg_1.equip_progress_bg_1,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_2.equip_progress_bg_2,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_3.equip_progress_bg_3,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_4.equip_progress_bg_4
		}
		self.__equip_progress_list = {
			self._control.research_bureau_bg.left.ship_research.aquip_bg_1.equip_progress_1,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_2.equip_progress_2,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_3.equip_progress_3,
			self._control.research_bureau_bg.left.ship_research.aquip_bg_4.equip_progress_4
		}

		self._control.research_bureau_bg.right.ship_show:SetActive(true)
		self._control.research_bureau_bg.right.equip_show:SetActive(false)
		self.__ship_task_list[1].ship_finish_img_1:SetActive(false)
		self.__ship_task_list[2].ship_finish_img_2:SetActive(false)
		self.__ship_task_list[3].ship_finish_img_3:SetActive(false)
		self.__ship_task_list[4].ship_finish_img_4:SetActive(false)

		for iter_7_0 = 1, 4 do
			self.__ship_task_time_img_list_2[iter_7_0]:SetActive(false)
		end
	end

	function arg_1_0:_init_language()
		self._control.research_bureau_bg.top.title_txt.text.text = var_0_4:getNowLang("return")

		for iter_8_0, iter_8_1 in pairs(self.__ship_stage_task_finish_name_list) do
			iter_8_1.text.text = var_0_4:getNowLang("questprogress")
		end

		self._control.finish_bg.finish_text.text.text = var_0_4:getNowLang("questprogress") .. ":"

		self._control.research_bureau_bg.right.equip_show.equip_bg.equip_finish:SetActive(false)
		self._control.research_bureau_bg.right.ship_show.ship_research.ship_finish:SetActive(false)
		self._control.research_bureau_bg.right.equip_show.equip_bg.equip.finish_1_img:SetActive(false)

		for iter_8_2, iter_8_3 in pairs(self.__equip_finish_name_list) do
			iter_8_3.text.text = var_0_4:getNowLang("questprogress")
		end

		for iter_8_4, iter_8_5 in pairs(self.__aquip_txt_list) do
			iter_8_5.text.text = var_0_4:getNowLang("can_receive")
		end

		self._control.research_bureau_bg.right.ship_show.ship_research.ship_finish.ship_get_btn.ship_get_txt_1.text.text = var_0_4:getNowLang("mailgetbtn")
		self._control.research_bureau_bg.right.ship_show.ship_research.ship_finish.ship_get_btn.ship_show_txt_1.text.text = var_0_4:getNowLang("receive_ship")
		self._control.research_bureau_bg.right.equip_show.equip_bg.equip_finish.equip_get_btn.equip_show_txt_1.text.text = var_0_4:getNowLang("receive_equipment")
		self._control.research_bureau_bg.right.equip_show.equip_bg.equip_finish.equip_get_btn.equip_get_txt_1.text.text = var_0_4:getNowLang("mailgetbtn")

		self:__init_set_research_develop_panel()

		for iter_8_6, iter_8_7 in pairs(self.__aquip_choose_list) do
			iter_8_7.gameObject:SetActive(false)
		end

		self._control.research_bureau_bg.state.have_state.have_state_txt.text.text = var_0_4:getNowLang("owned") .. "!"
		self._control.research_bureau_bg.right.ship_show.ship_research_2.unlock_image_2.unlock_txt_2.text.text = var_0_4:getNowLang("countdown")
		self._control.research_bureau_bg.right.ship_show.ship_research_3.unlock_image_3.unlock_txt_3.text.text = var_0_4:getNowLang("countdown")
	end

	function arg_1_0:__init_set_research_develop_panel()
		self.research_stage_1_y = var_0_5.research_development_pos.research_stage_1_y
		self.research_stage_1_x = var_0_5.research_development_pos.research_stage_1_x

		local var_9_0 = var_0_2:get_now_research_ship_id()

		if var_9_0 then
			local var_9_1 = var_0_8.find_object_by_id(var_9_0)

			if var_9_1.stage >= 3 then
				self._control.research_bureau_bg.right.ship_show.ship_research_2.select_btn_2:SetActive(true)
				self._control.research_bureau_bg.right.ship_show.ship_research_2.unlock_image_2:SetActive(false)
				self._control.research_bureau_bg.right.ship_show.ship_research_3.unlock_image_3:SetActive(false)
				self._control.research_bureau_bg.right.ship_show.ship_research_3.select_btn_3:SetActive(true)
			elseif var_9_1.stage >= 2 then
				self._control.research_bureau_bg.right.ship_show.ship_research_2.select_btn_2:SetActive(true)
				self._control.research_bureau_bg.right.ship_show.ship_research_2.unlock_image_2:SetActive(false)
				self._control.research_bureau_bg.right.ship_show.ship_research_2.unlock_image_2:SetActive(false)
				self._control.research_bureau_bg.right.ship_show.ship_research_3.unlock_image_3:SetActive(false)
			else
				self._control.research_bureau_bg.right.ship_show.ship_research_2.select_btn_2:SetActive(false)
				self._control.research_bureau_bg.right.ship_show.ship_research_3.select_btn_3:SetActive(false)
				self._control.research_bureau_bg.right.ship_show.ship_research_2.unlock_image_2:SetActive(false)
				self._control.research_bureau_bg.right.ship_show.ship_research_3.unlock_image_3:SetActive(false)
			end
		end
	end

	function arg_1_0:update_set_research_ship_task_info(arg_10_1)
		self._research_ship_info = var_0_8.find_object_by_id(arg_10_1)
		self.__ship_stage_ship_task_text_list[1].text.text = var_0_9.convert_rich_text(self._research_ship_info.task1_desc)
		self.__ship_stage_ship_task_text_list[2].text.text = var_0_9.convert_rich_text(self._research_ship_info.task2_desc)
		self.__ship_stage_ship_task_text_list[3].text.text = var_0_9.convert_rich_text(self._research_ship_info.task3_desc)
		self.__ship_stage_start_btn_text_list[1].text.text = self._research_ship_info.task1.type < 5 and var_0_4:getNowLang("submit") or var_0_4:getNowLang("questgo")
		self.__ship_stage_start_btn_text_list[2].text.text = self._research_ship_info.task2.type < 5 and var_0_4:getNowLang("submit") or var_0_4:getNowLang("questgo")
		self.__ship_stage_start_btn_text_list[3].text.text = self._research_ship_info.task3.type < 5 and var_0_4:getNowLang("submit") or var_0_4:getNowLang("questgo")
		self._control.research_bureau_bg.state.start_btn_text.text.text = self._research_ship_info.stage_name
		self._control.research_bureau_bg.state.state_image_2.image.sprite = self:loadSprite(var_0_5.research_stage.stage_2)

		for iter_10_0 = 1, 3 do
			self.__ship_stage_ship_task_finish_list[iter_10_0]:SetActive(false)
		end

		for iter_10_1 = 1, 3 do
			self.__ship_stage_start_btn_list[iter_10_1]:SetActive(true)
		end

		local var_10_0 = var_0_2:get_ship_task_info()

		self.__ship_stage_task_name_list_3[1]:GetComponent("TextHorizonScroller"):SetText(self._research_ship_info.task1_name)
		self.__ship_stage_task_name_list_3[2]:GetComponent("TextHorizonScroller"):SetText(self._research_ship_info.task2_name)
		self.__ship_stage_task_name_list_3[3]:GetComponent("TextHorizonScroller"):SetText(self._research_ship_info.task3_name)

		self.__reseach_ship_progress_sum = 0

		for iter_10_2, iter_10_3 in pairs(var_10_0) do
			if iter_10_3.id == arg_10_1 then
				if iter_10_3.task_num_1 > self._research_ship_info.task1.num then
					iter_10_3.task_num_1 = self._research_ship_info.task1.num
				end

				if iter_10_3.task_num_2 > self._research_ship_info.task2.num then
					iter_10_3.task_num_2 = self._research_ship_info.task2.num
				end

				if iter_10_3.task_num_3 > self._research_ship_info.task3.num then
					iter_10_3.task_num_3 = self._research_ship_info.task3.num
				end

				if self._research_ship_info.stage == 1 then
					local var_10_4 = iter_10_3.task_num_1 * 100 / self._research_ship_info.task1.num
					local var_10_5 = iter_10_3.task_num_2 * 100 / self._research_ship_info.task2.num
					local var_10_6 = iter_10_3.task_num_3 * 100 / self._research_ship_info.task3.num

					if iter_10_3.task_num_1 * 100 / self._research_ship_info.task1.num > 0 and var_10_4 < 2 then
						var_10_4 = 1
					end

					if var_10_5 > 0 and var_10_5 < 2 then
						var_10_5 = 1
					end

					if var_10_6 > 0 and var_10_6 < 2 then
						var_10_6 = 1
					end

					self.__ship_stage_task_progress_time_list[1].text.text = math.floor(var_10_4) .. "%"
					self.__ship_stage_task_progress_time_list[2].text.text = math.floor(var_10_5) .. "%"
					self.__ship_stage_task_progress_time_list[3].text.text = math.floor(var_10_6) .. "%"
					self.__reseach_ship_progress_sum = (iter_10_3.task_num_1 / self._research_ship_info.task1.num + iter_10_3.task_num_2 / self._research_ship_info.task2.num + iter_10_3.task_num_3 / self._research_ship_info.task3.num) / 3

					if iter_10_3.task_num_1 >= self._research_ship_info.task1.num then
						self.__ship_stage_ship_task_finish_list[1].gameObject:SetActive(true)
						self.__ship_stage_start_btn_list[1].gameObject:SetActive(false)
					end

					if iter_10_3.task_num_2 >= self._research_ship_info.task2.num then
						self.__ship_stage_ship_task_finish_list[2].gameObject:SetActive(true)
						self.__ship_stage_start_btn_list[2].gameObject:SetActive(false)
					end

					if iter_10_3.task_num_3 >= self._research_ship_info.task3.num then
						self.__ship_stage_ship_task_finish_list[3].gameObject:SetActive(true)
						self.__ship_stage_start_btn_list[3].gameObject:SetActive(false)
					end
				elseif self._research_ship_info.stage == 2 then
					local var_10_7 = iter_10_3.task_num_1 * 100 / self._research_ship_info.task1.num
					local var_10_8 = iter_10_3.task_num_2 * 100 / self._research_ship_info.task2.num
					local var_10_9 = iter_10_3.task_num_3 * 100 / self._research_ship_info.task3.num

					if iter_10_3.task_num_1 * 100 / self._research_ship_info.task1.num > 0 and var_10_7 < 2 then
						var_10_7 = 1
					end

					if var_10_8 > 0 and var_10_8 < 2 then
						var_10_8 = 1
					end

					if var_10_9 > 0 and var_10_9 < 2 then
						var_10_9 = 1
					end

					self.__ship_stage_task_progress_time_list[1].text.text = math.floor(var_10_7) .. "%"
					self.__ship_stage_task_progress_time_list[2].text.text = math.floor(var_10_8) .. "%"
					self.__ship_stage_task_progress_time_list[3].text.text = math.floor(var_10_9) .. "%"
					self.__reseach_ship_progress_sum = (iter_10_3.task_num_1 / self._research_ship_info.task1.num + iter_10_3.task_num_2 / self._research_ship_info.task2.num + iter_10_3.task_num_3 / self._research_ship_info.task3.num) / 3

					if iter_10_3.task_num_1 == self._research_ship_info.task1.num then
						self.__ship_stage_ship_task_finish_list[1].gameObject:SetActive(true)
						self.__ship_stage_start_btn_list[1].gameObject:SetActive(false)
					end

					if iter_10_3.task_num_2 == self._research_ship_info.task2.num then
						self.__ship_stage_ship_task_finish_list[2].gameObject:SetActive(true)
						self.__ship_stage_start_btn_list[2].gameObject:SetActive(false)
					end

					if iter_10_3.task_num_3 == self._research_ship_info.task3.num then
						self.__ship_stage_ship_task_finish_list[3].gameObject:SetActive(true)
						self.__ship_stage_start_btn_list[3].gameObject:SetActive(false)
					end
				elseif self._research_ship_info.stage == 3 then
					local var_10_10 = iter_10_3.task_num_1 * 100 / self._research_ship_info.task1.num
					local var_10_11 = iter_10_3.task_num_2 * 100 / self._research_ship_info.task2.num
					local var_10_12 = iter_10_3.task_num_3 * 100 / self._research_ship_info.task3.num

					if iter_10_3.task_num_1 * 100 / self._research_ship_info.task1.num > 0 and var_10_10 < 2 then
						var_10_10 = 1
					end

					if var_10_11 > 0 and var_10_11 < 2 then
						var_10_11 = 1
					end

					if var_10_12 > 0 and var_10_12 < 2 then
						var_10_12 = 1
					end

					self.__ship_stage_task_progress_time_list[1].text.text = math.floor(var_10_10) .. "%"
					self.__ship_stage_task_progress_time_list[2].text.text = math.floor(var_10_11) .. "%"
					self.__ship_stage_task_progress_time_list[3].text.text = math.floor(var_10_12) .. "%"
					self.__reseach_ship_progress_sum = (iter_10_3.task_num_1 / self._research_ship_info.task1.num + iter_10_3.task_num_2 / self._research_ship_info.task2.num + iter_10_3.task_num_3 / self._research_ship_info.task3.num) / 3

					if iter_10_3.task_num_1 == self._research_ship_info.task1.num then
						self.__ship_stage_ship_task_finish_list[1].gameObject:SetActive(true)
						self.__ship_stage_start_btn_list[1].gameObject:SetActive(false)
					end

					if iter_10_3.task_num_2 == self._research_ship_info.task2.num then
						self.__ship_stage_ship_task_finish_list[2].gameObject:SetActive(true)
						self.__ship_stage_start_btn_list[2].gameObject:SetActive(false)
					end

					if iter_10_3.task_num_3 == self._research_ship_info.task3.num then
						self.__ship_stage_ship_task_finish_list[3].gameObject:SetActive(true)
						self.__ship_stage_start_btn_list[3].gameObject:SetActive(false)
					end
				end

				if iter_10_3.complete_time > 0 then
					self._do_not_to_research = true
					self._now_stage = self._research_ship_info.stage
					self._start_time = iter_10_3.complete_time + var_0_5.research_ship_time
				end
			end
		end

		local var_10_13 = self._control.research_bureau_bg.right.ship_show.ship_research

		self._control.research_bureau_bg.right.ship_show.ship_research.ship_top.ship_time_img.image.fillAmount = self.__reseach_ship_progress_sum

		if self.__reseach_ship_progress_sum < 1 then
			var_10_13.ship_top.ship_finish_img:SetActive(false)

			var_10_13.ship_top.ship_research_image.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.ongoing)
		else
			var_10_13.ship_top.ship_finish_img:SetActive(true)

			var_10_13.ship_top.ship_research_image.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.finish)
		end

		local var_10_14 = {}

		for iter_10_4, iter_10_5 in pairs(var_10_0) do
			if var_0_8.find_object_by_id(iter_10_5.id).num == self._research_ship_info.num then
				var_0_10(var_10_14, iter_10_5)
			end
		end

		for iter_10_6, iter_10_7 in pairs(var_10_14) do
			self.__ship_research_title[iter_10_6].text.text = var_0_8.find_object_by_id(iter_10_7.id).stage_name
		end

		var_10_13.ship_top.ship_research_image.ship_research_title.text.text = self._research_ship_info.stage_name

		local var_10_15 = var_0_2:get_unlock_ship_info()

		self._control.research_bureau_bg.state.have_state:SetActive(false)
		self._control.research_bureau_bg.right.ship_show.ship_research.ship_finish:SetActive(false)

		if var_10_15 and next(var_10_15) then
			local var_10_16 = var_0_8.find_object_by_id(arg_10_1)

			if self:have_ship(var_10_0, var_10_16, var_10_15) then
				self._control.research_bureau_bg.state.have_state:SetActive(true)
			else
				local var_10_17 = {}

				for iter_10_8, iter_10_9 in pairs(var_10_0) do
					if var_0_8.find_object_by_id(iter_10_9.id).num == var_10_16.num then
						var_0_10(var_10_17, iter_10_9)
					end
				end

				if var_10_16.stage == #var_10_17 and self.__reseach_ship_progress_sum >= 1 then
					self._control.research_bureau_bg.right.ship_show.ship_research.ship_finish:SetActive(true)
				else
					self._control.research_bureau_bg.right.ship_show.ship_research.ship_finish:SetActive(false)
				end
			end
		else
			local var_10_18 = {}
			local var_10_19 = var_0_8.find_object_by_id(arg_10_1)

			for iter_10_10, iter_10_11 in pairs(var_10_0) do
				if var_0_8.find_object_by_id(iter_10_11.id).num == var_10_19.num then
					var_0_10(var_10_18, iter_10_11)
				end
			end

			if var_10_19.stage == #var_10_18 and self.__reseach_ship_progress_sum >= 1 then
				self._control.research_bureau_bg.right.ship_show.ship_research.ship_finish:SetActive(true)
			else
				self._control.research_bureau_bg.right.ship_show.ship_research.ship_finish:SetActive(false)
			end
		end
	end

	function arg_1_0.have_ship(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		local var_11_0 = {}

		for iter_11_0, iter_11_1 in pairs(arg_11_1) do
			if var_0_8.find_object_by_id(iter_11_1.id).num == arg_11_2.num then
				var_0_10(var_11_0, iter_11_1)
			end
		end

		local var_11_1 = false

		for iter_11_2, iter_11_3 in pairs(arg_11_3) do
			if iter_11_3 == var_11_0[1].id then
				var_11_1 = true

				return true
			end
		end

		return var_11_1
	end

	function arg_1_0:update_set_research_equip_task_info(arg_12_1)
		self.equie_task_id = {}
		self.equie_ongoing_task_id = {}

		for iter_12_0 = 1, #self.__equip_finish_list do
			self.__equip_finish_list[iter_12_0]:SetActive(false)
		end

		self._equie_info = var_0_2:get_equip_task_info()

		local var_12_0 = var_0_2:get_unlock_equips_info()

		self:updata_equip_info()
	end

	function arg_1_0:updata_equip_info()
		self:__update_equip_state()

		local var_13_0 = var_0_8.find_object_by_id(self._now_ship_id)
		local var_13_1 = var_0_2:get_unlock_equips_info()

		if self._equie_info and next(self._equie_info) then
			if var_13_1 and next(var_13_1) then
				local var_13_2 = var_0_2:get_equip_task_info()
				local var_13_6 = 0

				for iter_13_0, iter_13_1 in pairs(self._equie_info) do
					for iter_13_2 = 1, 4 do
						if iter_13_1.id == var_13_0.equipment[iter_13_2] and iter_13_1.status == 1 and var_0_9.have_data(var_13_1, iter_13_1.id) then
							self.__equip_finish_list[iter_13_2].gameObject:SetActive(true)
							self.__aquip_txt_bg_list[iter_13_2].gameObject:SetActive(false)
							self.__equip_ongoing_list[iter_13_2].gameObject:SetActive(false)
							self.__equip_progress_list[iter_13_2].gameObject:SetActive(false)
							self.__equip_progress_bg_list[iter_13_2].gameObject:SetActive(false)
						elseif iter_13_1.id == var_13_0.equipment[iter_13_2] and iter_13_1.status == 0 and not var_0_9.have_data(var_13_1, iter_13_1.id) then
							self.__equip_finish_list[iter_13_2].gameObject:SetActive(false)
							self.__aquip_txt_bg_list[iter_13_2].gameObject:SetActive(false)
							self.__equip_ongoing_list[iter_13_2].gameObject:SetActive(true)
							self.__equip_progress_list[iter_13_2].gameObject:SetActive(true)
							self.__equip_progress_bg_list[iter_13_2]:SetActive(true)

							local var_13_7 = var_0_15.find_object_by_id(iter_13_1.id)

							for iter_13_3, iter_13_4 in pairs(var_13_2) do
								if iter_13_1.id == iter_13_4.id then
									if iter_13_1.task_num_1 >= var_13_7.task1.num then
										iter_13_1.task_num_1 = var_13_7.task1.num
									end

									if iter_13_1.task_num_2 >= var_13_7.task2.num then
										iter_13_1.task_num_2 = var_13_7.task2.num
									end

									if iter_13_1.task_num_3 >= var_13_7.task3.num then
										iter_13_1.task_num_3 = var_13_7.task3.num
									end

									var_13_6 = (iter_13_1.task_num_1 / var_13_7.task1.num + iter_13_1.task_num_2 / var_13_7.task2.num + iter_13_1.task_num_3 / var_13_7.task3.num) / 3
								end
							end

							self.__equip_progress_list[iter_13_2].image.fillAmount = var_13_6
						elseif iter_13_1.id == var_13_0.equipment[iter_13_2] and iter_13_1.status == 1 and not var_0_9.have_data(var_13_1, iter_13_1.id) then
							self.__equip_finish_list[iter_13_2].gameObject:SetActive(false)
							self.__aquip_txt_bg_list[iter_13_2].gameObject:SetActive(true)
							self.__equip_ongoing_list[iter_13_2].gameObject:SetActive(false)
							self.__equip_progress_list[iter_13_2].gameObject:SetActive(true)
							self.__equip_progress_bg_list[iter_13_2].gameObject:SetActive(true)

							local var_13_8 = var_0_15.find_object_by_id(iter_13_1.id)

							for iter_13_5, iter_13_6 in pairs(var_13_2) do
								if iter_13_1.id == iter_13_6.id then
									if iter_13_1.task_num_1 >= var_13_8.task1.num then
										iter_13_1.task_num_1 = var_13_8.task1.num
									end

									if iter_13_1.task_num_2 >= var_13_8.task2.num then
										iter_13_1.task_num_2 = var_13_8.task2.num
									end

									if iter_13_1.task_num_3 >= var_13_8.task3.num then
										iter_13_1.task_num_3 = var_13_8.task3.num
									end

									var_13_6 = (iter_13_1.task_num_1 / var_13_8.task1.num + iter_13_1.task_num_2 / var_13_8.task2.num + iter_13_1.task_num_3 / var_13_8.task3.num) / 3
								end
							end

							self.__equip_progress_list[iter_13_2].image.fillAmount = var_13_6
						end
					end
				end
			else
				self:equip_show_state()
			end
		end
	end

	function arg_1_0:__update_equip_state()
		local var_14_2 = 1
		local var_14_3 = self:get_ship_research_max_info()

		for iter_14_0, iter_14_1 in pairs((var_0_2:get_ship_task_info())) do
			if var_14_3 == iter_14_1.id then
				local var_14_4 = var_0_8.find_object_by_id(iter_14_1.id).stage

				if iter_14_1.status == 1 and var_14_4 > 1 then
					var_14_2 = var_14_4
				elseif iter_14_1.status == 0 and var_14_4 > 1 then
					var_14_2 = var_14_4 - 1
				end
			end
		end

		local var_14_5 = {}

		for iter_14_2 = 1, var_14_2 do
			var_0_10(var_14_5, iter_14_2)
		end

		if not var_0_9.have_data(var_14_5, 0) then
			var_0_10(var_14_5, 0)
		end

		for iter_14_3, iter_14_4 in pairs(var_0_8.find_object_by_id(var_14_3).equipment) do
			if self:__have_data(var_14_5, var_0_15.find_object_by_id(iter_14_4).condition.stage) then
				self.__equip_ongoing_list[iter_14_3].image.sprite = self:loadSprite(var_0_5.research_task_image.ongoing)

				self.__equip_progress_list[iter_14_3]:SetActive(true)
				self.__equip_progress_bg_list[iter_14_3]:SetActive(true)
			else
				self.__equip_progress_list[iter_14_3]:SetActive(false)
				self.__equip_progress_bg_list[iter_14_3]:SetActive(false)

				self.__equip_ongoing_list[iter_14_3].image.sprite = self:loadSprite(var_0_5.research_task_image.lock)
			end
		end
	end

	function arg_1_0.__have_data(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = false

		if arg_15_1 and next(arg_15_1) then
			for iter_15_0, iter_15_1 in pairs(arg_15_1) do
				if iter_15_1 == arg_15_2 then
					var_15_0 = true

					return true
				end
			end
		end

		return var_15_0
	end

	function arg_1_0:equip_show_state()
		local var_16_0 = var_0_8.find_object_by_id(self._now_ship_id)
		local var_16_1 = var_0_2:get_equip_task_info()
		local var_16_5 = 0

		for iter_16_0, iter_16_1 in pairs(self._equie_info) do
			if iter_16_1.id == var_16_0.equipment[1] and iter_16_1.status == 1 then
				self.__equip_finish_list[1].gameObject:SetActive(false)
				self.__aquip_txt_bg_list[1].gameObject:SetActive(true)
				self.__equip_ongoing_list[1].gameObject:SetActive(false)
				self.__equip_progress_bg_list[1]:SetActive(true)

				self.__equip_bg_list[1].equip_progress_1.image.fillAmount = 1
			elseif iter_16_1.id == var_16_0.equipment[1] and iter_16_1.status == 0 then
				self.__equip_finish_list[1].gameObject:SetActive(false)
				self.__equip_finish_list[2].gameObject:SetActive(false)
				self.__equip_finish_list[3].gameObject:SetActive(false)
				self.__equip_finish_list[4].gameObject:SetActive(false)
				self.__equip_progress_bg_list[1]:SetActive(true)

				local var_16_6 = var_0_15.find_object_by_id(iter_16_1.id)

				for iter_16_2, iter_16_3 in pairs(var_16_1) do
					if iter_16_1.id == iter_16_3.id then
						if iter_16_1.task_num_1 >= var_16_6.task1.num then
							iter_16_1.task_num_1 = var_16_6.task1.num
						end

						if iter_16_1.task_num_2 >= var_16_6.task2.num then
							iter_16_1.task_num_2 = var_16_6.task2.num
						end

						if iter_16_1.task_num_3 >= var_16_6.task3.num then
							iter_16_1.task_num_3 = var_16_6.task3.num
						end

						var_16_5 = (iter_16_1.task_num_1 / var_16_6.task1.num + iter_16_1.task_num_2 / var_16_6.task2.num + iter_16_1.task_num_3 / var_16_6.task3.num) / 3
					end
				end

				self.__equip_bg_list[1].equip_progress_1.image.fillAmount = var_16_5
			end

			if iter_16_1.id == var_16_0.equipment[2] and iter_16_1.status == 1 then
				self.__equip_finish_list[2].gameObject:SetActive(false)
				self.__aquip_txt_bg_list[2].gameObject:SetActive(true)
				self.__equip_ongoing_list[2].gameObject:SetActive(false)
				self.__equip_progress_bg_list[2]:SetActive(true)

				self.__equip_bg_list[2].equip_progress_2.image.fillAmount = 1
			elseif iter_16_1.id == var_16_0.equipment[2] and iter_16_1.status == 0 then
				self.__equip_finish_list[2].gameObject:SetActive(false)
				self.__equip_finish_list[3].gameObject:SetActive(false)
				self.__equip_finish_list[4].gameObject:SetActive(false)
				self.__equip_ongoing_list[2].gameObject:SetActive(true)

				self.__equip_ongoing_list[1].image.sprite = self:loadSprite(var_0_5.research_task_image.ongoing)

				local var_16_7 = var_0_15.find_object_by_id(iter_16_1.id)

				self.__equip_ongoing_list[2].image.sprite = var_0_8.find_object_by_id((self:get_ship_research_max_info())).stage >= var_16_7.condition.stage and self:loadSprite(var_0_5.research_task_image.ongoing) or self:loadSprite(var_0_5.research_task_image.lock)

				for iter_16_4, iter_16_5 in pairs(var_16_1) do
					if iter_16_1.id == iter_16_5.id then
						if iter_16_1.task_num_1 >= var_16_7.task1.num then
							iter_16_1.task_num_1 = var_16_7.task1.num
						end

						if iter_16_1.task_num_2 >= var_16_7.task2.num then
							iter_16_1.task_num_2 = var_16_7.task2.num
						end

						if iter_16_1.task_num_3 >= var_16_7.task3.num then
							iter_16_1.task_num_3 = var_16_7.task3.num
						end

						var_16_5 = (iter_16_1.task_num_1 / var_16_7.task1.num + iter_16_1.task_num_2 / var_16_7.task2.num + iter_16_1.task_num_3 / var_16_7.task3.num) / 3
					end
				end

				self.__equip_bg_list[2].equip_progress_2.image.fillAmount = var_16_5
			end

			if iter_16_1.id == var_16_0.equipment[3] and iter_16_1.status == 1 then
				self.__equip_finish_list[3].gameObject:SetActive(false)
				self.__aquip_txt_bg_list[3].gameObject:SetActive(true)
				self.__equip_ongoing_list[3].gameObject:SetActive(false)
			elseif iter_16_1.id == var_16_0.equipment[3] and iter_16_1.status == 0 then
				self.__equip_finish_list[3].gameObject:SetActive(false)
				self.__equip_finish_list[4].gameObject:SetActive(false)
				self.__equip_ongoing_list[3].gameObject:SetActive(true)
				self.__equip_ongoing_list[3].gameObject:SetActive(true)

				local var_16_8 = var_0_15.find_object_by_id(iter_16_1.id)

				self.__equip_ongoing_list[3].image.sprite = var_0_8.find_object_by_id((self:get_ship_research_max_info())).stage >= var_16_8.condition.stage and self:loadSprite(var_0_5.research_task_image.ongoing) or self:loadSprite(var_0_5.research_task_image.lock)

				for iter_16_6, iter_16_7 in pairs(var_16_1) do
					if iter_16_1.id == iter_16_7.id then
						if iter_16_1.task_num_1 >= var_16_8.task1.num then
							iter_16_1.task_num_1 = var_16_8.task1.num
						end

						if iter_16_1.task_num_2 >= var_16_8.task2.num then
							iter_16_1.task_num_2 = var_16_8.task2.num
						end

						if iter_16_1.task_num_3 >= var_16_8.task3.num then
							iter_16_1.task_num_3 = var_16_8.task3.num
						end

						var_16_5 = (iter_16_1.task_num_1 / var_16_8.task1.num + iter_16_1.task_num_2 / var_16_8.task2.num + iter_16_1.task_num_3 / var_16_8.task3.num) / 3
					end
				end

				self.__equip_bg_list[3].equip_progress_3.image.fillAmount = var_16_5
			end

			if #var_16_0.equipment >= 4 and iter_16_1.id == var_16_0.equipment[4] and iter_16_1.status == 1 then
				self.__equip_finish_list[4].gameObject:SetActive(false)
				self.__aquip_txt_bg_list[4].gameObject:SetActive(true)
				self.__equip_ongoing_list[4].gameObject:SetActive(false)
			elseif #var_16_0.equipment >= 4 and iter_16_1.id == var_16_0.equipment[4] and iter_16_1.status == 0 then
				self.__equip_finish_list[4].gameObject:SetActive(false)
				self.__equip_ongoing_list[4].gameObject:SetActive(true)

				local var_16_9 = var_0_15.find_object_by_id(iter_16_1.id)

				self.__equip_ongoing_list[4].gameObject:SetActive(true)

				self.__equip_ongoing_list[4].image.sprite = var_0_8.find_object_by_id((self:get_ship_research_max_info())).stage >= var_16_9.condition.stage and self:loadSprite(var_0_5.research_task_image.ongoing) or self:loadSprite(var_0_5.research_task_image.lock)

				for iter_16_8, iter_16_9 in pairs(var_16_1) do
					if iter_16_1.id == iter_16_9.id then
						if iter_16_1.task_num_1 >= var_16_9.task1.num then
							iter_16_1.task_num_1 = var_16_9.task1.num
						end

						if iter_16_1.task_num_2 >= var_16_9.task2.num then
							iter_16_1.task_num_2 = var_16_9.task2.num
						end

						if iter_16_1.task_num_3 >= var_16_9.task3.num then
							iter_16_1.task_num_3 = var_16_9.task3.num
						end

						var_16_5 = (iter_16_1.task_num_1 / var_16_9.task1.num + iter_16_1.task_num_2 / var_16_9.task2.num + iter_16_1.task_num_3 / var_16_9.task3.num) / 3
					end
				end

				self.__equip_bg_list[4].equip_progress_4.image.fillAmount = var_16_5
			end
		end
	end

	function arg_1_0:_init_equip_list()
		self._equp_all_info = {}

		for iter_17_0, iter_17_1 in pairs((var_0_2:get_equip_task_info())) do
			local var_17_0 = var_0_8.find_object_by_id(self._now_ship_id)

			if #var_17_0.equipment == 1 and var_17_0.equipment[1] == iter_17_1.id then
				var_0_10(self._equp_all_info, iter_17_1)
			end

			if #var_17_0.equipment == 2 then
				if var_17_0.equipment[1] == iter_17_1.id then
					var_0_10(self._equp_all_info, iter_17_1)
				end

				if var_17_0.equipment[2] == iter_17_1.id then
					var_0_10(self._equp_all_info, iter_17_1)
				end
			end

			if #var_17_0.equipment == 3 then
				if var_17_0.equipment[1] == iter_17_1.id then
					var_0_10(self._equp_all_info, iter_17_1)
				end

				if var_17_0.equipment[2] == iter_17_1.id then
					var_0_10(self._equp_all_info, iter_17_1)
				end

				if var_17_0.equipment[3] == iter_17_1.id then
					var_0_10(self._equp_all_info, iter_17_1)
				end
			end

			if #var_17_0.equipment == 4 then
				if var_17_0.equipment[1] == iter_17_1.id then
					var_0_10(self._equp_all_info, iter_17_1)
				end

				if var_17_0.equipment[2] == iter_17_1.id then
					var_0_10(self._equp_all_info, iter_17_1)
				end

				if var_17_0.equipment[3] == iter_17_1.id then
					var_0_10(self._equp_all_info, iter_17_1)
				end

				if var_17_0.equipment[4] == iter_17_1.id then
					var_0_10(self._equp_all_info, iter_17_1)
				end
			end
		end
	end

	function arg_1_0:_init_score_list()
		if not self._reusable_cell then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.left.task.scrollview.viewport.content.endlessScrollView, self._control.left.task.scrollview.viewport.content, "research_need_item", "research_development")

			self._reusable_cell:init()
		end
	end

	function arg_1_0:__update_reusable_cell(arg_19_1, arg_19_2)
		local var_19_0 = {}

		if arg_19_1 == 1 then
			var_19_0 = var_0_5.ship_evo_item
		elseif arg_19_1 == 2 then
			var_19_0 = var_0_5.ship_blueprint_item
		elseif arg_19_1 then
			var_19_0 = arg_19_1
		end

		if not var_19_0 and not next(var_19_0) then
			return
		end

		if #var_19_0 <= 3 then
			self._control.left.task.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_3(34, 0)
			self._control.left.task.scrollview:GetComponent("ScrollRect").enabled = false
		else
			self._control.left.task.scrollview:GetComponent("ScrollRect").enabled = true
		end

		self._reusable_cell:set_data(var_19_0)

		function self._reusable_cell:_set_func(arg_20_1)
			self.item_bg.now_txt.text.text = 0

			local var_20_0 = var_0_13.find_object_by_cid(var_19_0[arg_20_1 + 1])

			self.item_bg.have_name.text.text = var_0_4:getNowLang("unequiptip1")
			self.item_bg.item_name.text.text = var_20_0.title

			self:__init_score_data(self, var_19_0[arg_20_1 + 1])

			if self._sum_score_info and next(self._sum_score_info) then
				for iter_20_0, iter_20_1 in pairs(self._sum_score_info) do
					if iter_20_1.cid == var_20_0.cid then
						self.item_bg.now_txt.text.text = iter_20_1.num
					end
				end
			end

			local var_20_1 = var_0_2:get_item_count(var_20_0.cid)

			self.item_bg.have_txt.text.text = var_0_9.get_simplify_num(var_20_1)
			self.item_bg.icon.image.sprite = self:loadSprite(var_0_11(var_0_5.icon.item_icon, var_20_0.cid))

			self.item_bg.add_btn.pointerDownAndLongClickEvent.onPointerDown:RemoveAllListeners()
			self.item_bg.add_btn.pointerDownAndLongClickEvent.onPointerDown:AddListener(function()
				if self._sum_score_num + self._already_select_num >= arg_19_2.num then
					var_0_14:show(var_0_4:getNowLang("number_max"))

					return
				end

				if self._sum_blueprint_num + self._already_select_num >= arg_19_2.num then
					var_0_14:show(var_0_4:getNowLang("number_max"))

					return
				end

				if self._sum_ship_build_num + self._already_select_num >= arg_19_2.num then
					var_0_14:show(var_0_4:getNowLang("number_max"))

					return
				end

				self:updata_score_or_blueprint_num(self, var_19_0[arg_20_1 + 1], arg_20_1, true, var_20_1)
				self:__update_ship_show(arg_19_1, arg_19_2, var_19_0[arg_20_1 + 1])
			end)
			self.item_bg.add_btn.pointerDownAndLongClickEvent.onLongClick:RemoveAllListeners()
			self.item_bg.add_btn.pointerDownAndLongClickEvent.onLongClick:AddListener(function()
				if self._sum_score_num + self._already_select_num >= arg_19_2.num then
					return
				end

				if self._sum_blueprint_num + self._already_select_num >= arg_19_2.num then
					return
				end

				if self._sum_ship_build_num + self._already_select_num >= arg_19_2.num then
					return
				end

				self:updata_score_or_blueprint_num(self, var_19_0[arg_20_1 + 1], arg_20_1, true, var_20_1)
				self:__update_ship_show(arg_19_1, arg_19_2, var_19_0[arg_20_1 + 1])
			end)
			self.item_bg.subtract_btn.pointerDownAndLongClickEvent.onPointerDown:RemoveAllListeners()
			self.item_bg.subtract_btn.pointerDownAndLongClickEvent.onPointerDown:AddListener(function()
				self:updata_score_or_blueprint_num(self, var_19_0[arg_20_1 + 1], arg_20_1, false)
				self:__update_ship_show(arg_19_1, arg_19_2, var_19_0[arg_20_1 + 1])
			end)
			self.item_bg.subtract_btn.pointerDownAndLongClickEvent.onLongClick:RemoveAllListeners()
			self.item_bg.subtract_btn.pointerDownAndLongClickEvent.onLongClick:AddListener(function()
				self:updata_score_or_blueprint_num(self, var_19_0[arg_20_1 + 1], arg_20_1, false)
				self:__update_ship_show(arg_19_1, arg_19_2, var_19_0[arg_20_1 + 1])
			end)
			self.item_bg.max_core_btn.button.onClick:RemoveAllListeners()
			self.item_bg.max_core_btn.button.onClick:AddListener(function()
				if self._sum_score_num + self._already_select_num >= arg_19_2.num then
					var_0_14:show(var_0_4:getNowLang("number_max"))

					return
				end

				if self._sum_blueprint_num + self._already_select_num >= arg_19_2.num then
					var_0_14:show(var_0_4:getNowLang("number_max"))

					return
				end

				self:updata_score_or_blueprint_num(self, var_19_0[arg_20_1 + 1], arg_20_1, false, var_20_1, true, arg_19_2.num - self._already_select_num)
				self:__update_ship_show(arg_19_1, arg_19_2, var_19_0[arg_20_1 + 1])
			end)
		end
	end

	function arg_1_0:__update_ship_show(arg_26_1, arg_26_2, arg_26_3)
		local var_26_0 = 0

		if arg_26_1 == 1 then
			self:update_core_task_info(arg_26_2)
		elseif arg_26_1 == 2 then
			self:update_blueprint_task_info(arg_26_2)
		elseif arg_26_1 == 3 then
			self:update_ship_build_task_info(arg_26_2)
		elseif arg_26_1[1] then
			var_26_0 = arg_26_1[1]
		end

		if var_26_0 == arg_26_3 then
			if arg_26_3 < 20000 and arg_26_3 > 1000 then
				self:update_core_task_info(arg_26_2)
				self:set_score_btn_state()
			elseif arg_26_3 < 1000 then
				self:update_ship_build_task_info(arg_26_2)
				self:set_ship_build_btn_state()
			elseif arg_26_3 > 20000 then
				self:set_blueprint_btn_state()
				self:update_blueprint_task_info(arg_26_2)
			end
		elseif arg_26_3 < 20000 and arg_26_3 > 1000 then
			self:set_score_btn_state()
		elseif arg_26_3 < 1000 then
			self:set_ship_build_btn_state()
		elseif arg_26_3 > 20000 then
			self:set_blueprint_btn_state()
		end
	end

	function arg_1_0:__update_equip_drawing_cell(arg_27_1)
		local var_27_0 = {}

		var_0_10(var_27_0, arg_27_1)

		if not var_27_0 and not next(var_27_0) then
			return
		end

		self._control.left.task.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_3(34, 0)
		self._control.left.task.scrollview:GetComponent("ScrollRect").enabled = false

		self._reusable_cell:set_data(var_27_0)

		function self._reusable_cell:_set_func(arg_28_1)
			self.item_bg.now_txt.text.text = 0

			local var_28_0 = var_0_13.find_object_by_cid(var_27_0[arg_28_1 + 1].item_id)

			self.item_bg.have_name.text.text = var_0_4:getNowLang("unequiptip1")
			self.item_bg.item_name.text.text = var_28_0.title

			self:__init_score_data(self, var_27_0[arg_28_1 + 1].item_id)

			if self._sum_equip_drawing_info and next(self._sum_equip_drawing_info) then
				for iter_28_0, iter_28_1 in pairs(self._sum_equip_drawing_info) do
					if iter_28_1.cid == var_28_0.cid then
						self.item_bg.now_txt.text.text = iter_28_1.num
					end
				end
			end

			local var_28_1 = var_0_2:get_item_count(var_28_0.cid)

			self.item_bg.have_txt.text.text = var_0_9.get_simplify_num(var_28_1)
			self.item_bg.icon.image.sprite = self:loadSprite(var_0_11(var_0_5.icon.item_icon, var_28_0.cid))

			self.item_bg.add_btn.pointerDownAndLongClickEvent.onPointerDown:RemoveAllListeners()
			self.item_bg.add_btn.pointerDownAndLongClickEvent.onPointerDown:AddListener(function()
				if self._sum_equip_drawing_num + self._already_select_num >= arg_27_1.num then
					var_0_14:show(var_0_4:getNowLang("number_max"))

					return
				end

				self:updata_equip_drawing_num(self, var_27_0[arg_28_1 + 1].item_id, arg_28_1, true, var_28_1)
				self:update_equip_drawing_task_info(arg_27_1)
				self:set_equip_drawing_btn_state()
			end)
			self.item_bg.add_btn.pointerDownAndLongClickEvent.onLongClick:RemoveAllListeners()
			self.item_bg.add_btn.pointerDownAndLongClickEvent.onLongClick:AddListener(function()
				if self._sum_score_num + self._already_select_num >= arg_27_1.num then
					return
				end

				if self._sum_blueprint_num + self._already_select_num >= arg_27_1.num then
					return
				end

				if self._sum_equip_drawing_num + self._already_select_num >= arg_27_1.num then
					return
				end

				self:updata_equip_drawing_num(self, var_27_0[arg_28_1 + 1].item_id, arg_28_1, true, var_28_1)
				self:update_equip_drawing_task_info(arg_27_1)
				self:set_equip_drawing_btn_state()
			end)
			self.item_bg.subtract_btn.pointerDownAndLongClickEvent.onPointerDown:RemoveAllListeners()
			self.item_bg.subtract_btn.pointerDownAndLongClickEvent.onPointerDown:AddListener(function()
				self:updata_equip_drawing_num(self, var_27_0[arg_28_1 + 1].item_id, arg_28_1, false)
				self:update_equip_drawing_task_info(arg_27_1)
				self:set_equip_drawing_btn_state()
			end)
			self.item_bg.subtract_btn.pointerDownAndLongClickEvent.onLongClick:RemoveAllListeners()
			self.item_bg.subtract_btn.pointerDownAndLongClickEvent.onLongClick:AddListener(function()
				self:updata_equip_drawing_num(self, var_27_0[arg_28_1 + 1].item_id, arg_28_1, false)
				self:update_equip_drawing_task_info(arg_27_1)
				self:set_equip_drawing_btn_state()
			end)
			self.item_bg.max_core_btn.button.onClick:RemoveAllListeners()
			self.item_bg.max_core_btn.button.onClick:AddListener(function()
				if self._sum_score_num + self._already_select_num >= arg_27_1.num then
					var_0_14:show(var_0_4:getNowLang("number_max"))

					return
				end

				if self._sum_blueprint_num + self._already_select_num >= arg_27_1.num then
					var_0_14:show(var_0_4:getNowLang("number_max"))

					return
				end

				self:update_equip_drawing_task_info(arg_27_1)
				self:set_equip_drawing_btn_state()
			end)
		end
	end

	function arg_1_0:__update_item_cell(arg_34_1)
		local var_34_0 = {}

		var_0_10(var_34_0, arg_34_1)

		if not var_34_0 and not next(var_34_0) then
			return
		end

		self._control.left.task.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_3(34, 0)
		self._control.left.task.scrollview:GetComponent("ScrollRect").enabled = false

		self._reusable_cell:set_data(var_34_0)

		function self._reusable_cell:_set_func(arg_35_1)
			self.item_bg.now_txt.text.text = 0

			local var_35_0 = var_0_13.find_object_by_cid(var_34_0[arg_35_1 + 1].item_id)

			self.item_bg.have_name.text.text = var_0_4:getNowLang("unequiptip1")
			self.item_bg.item_name.text.text = var_35_0.title

			self:__init_score_data(self, var_34_0[arg_35_1 + 1].item_id)

			if self._sum_equip_drawing_info and next(self._sum_equip_drawing_info) then
				for iter_35_0, iter_35_1 in pairs(self._sum_equip_drawing_info) do
					if iter_35_1.cid == var_35_0.cid then
						self.item_bg.now_txt.text.text = iter_35_1.num
					end
				end
			end

			local var_35_1 = var_0_2:get_item_count(var_35_0.cid)

			self.item_bg.have_txt.text.text = var_0_9.get_simplify_num(var_35_1)
			self.item_bg.icon.image.sprite = self:loadSprite(var_0_11(var_0_5.icon.item_icon, var_35_0.cid))

			self.item_bg.add_btn.pointerDownAndLongClickEvent.onPointerDown:RemoveAllListeners()
			self.item_bg.add_btn.pointerDownAndLongClickEvent.onPointerDown:AddListener(function()
				if self._sum_item_num + self._already_select_num >= arg_34_1.num then
					var_0_14:show(var_0_4:getNowLang("number_max"))

					return
				end

				self:__updata_item_num(self, var_34_0[arg_35_1 + 1], arg_35_1, true, var_35_1)
				self:_update_item_task_info(arg_34_1)
				self:set_item_btn_state()
			end)
			self.item_bg.add_btn.pointerDownAndLongClickEvent.onLongClick:RemoveAllListeners()
			self.item_bg.add_btn.pointerDownAndLongClickEvent.onLongClick:AddListener(function()
				if self._sum_score_num + self._already_select_num >= arg_34_1.num then
					return
				end

				if self._sum_blueprint_num + self._already_select_num >= arg_34_1.num then
					return
				end

				if self._sum_ship_build_num + self._already_select_num >= arg_34_1.num then
					return
				end

				if self._sum_item_num + self._already_select_num >= arg_34_1.num then
					return
				end

				self:__updata_item_num(self, var_34_0[arg_35_1 + 1], arg_35_1, true, var_35_1)
				self:_update_item_task_info(arg_34_1)
				self:set_item_btn_state()
			end)
			self.item_bg.subtract_btn.pointerDownAndLongClickEvent.onPointerDown:RemoveAllListeners()
			self.item_bg.subtract_btn.pointerDownAndLongClickEvent.onPointerDown:AddListener(function()
				self:__updata_item_num(self, var_34_0[arg_35_1 + 1], arg_35_1, false, var_35_1)
				self:_update_item_task_info(arg_34_1)
				self:set_item_btn_state()
			end)
			self.item_bg.subtract_btn.pointerDownAndLongClickEvent.onLongClick:RemoveAllListeners()
			self.item_bg.subtract_btn.pointerDownAndLongClickEvent.onLongClick:AddListener(function()
				self:__updata_item_num(self, var_34_0[arg_35_1 + 1], arg_35_1, false)
				self:_update_item_task_info(arg_34_1)
				self:set_item_btn_state()
			end)
			self.item_bg.max_core_btn.button.onClick:RemoveAllListeners()
			self.item_bg.max_core_btn.button.onClick:AddListener(function()
				if self._sum_item_num + self._already_select_num >= arg_34_1.num then
					var_0_14:show(var_0_4:getNowLang("number_max"))

					return
				end

				self:__updata_item_num(self, var_34_0[arg_35_1 + 1], arg_35_1, false, var_35_1, true, arg_34_1.num - self._already_select_num)
				self:_update_item_task_info(arg_34_1)
				self:set_item_btn_state()
			end)
		end
	end

	function arg_1_0:__init_score_data(arg_41_1, arg_41_2)
		if self._type_layer == 1 and self._sum_score_num == 0 then
			arg_41_1.item_bg.now_txt.text.text = 0
		elseif self._type_layer == 2 and self._sum_blueprint_num == 0 then
			arg_41_1.item_bg.now_txt.text.text = 0
		elseif self._type_layer == 3 and self._sum_equip_drawing_num == 0 then
			arg_41_1.item_bg.now_txt.text.text = 0
		elseif self._type_layer == 4 and self._sum_ship_build_num == 0 then
			arg_41_1.item_bg.now_txt.text.text = 0
		end
	end

	function arg_1_0:updata_score_or_blueprint_num(arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5, arg_42_6, arg_42_7)
		if arg_42_2 == 10141 and arg_42_4 == true and not arg_42_6 then
			self.score_1 = self.score_1 + 1

			if arg_42_5 < self.score_1 then
				self.score_1 = arg_42_5

				var_0_14:show(var_0_4:getNowLang("inadequate"))

				return
			end

			arg_42_1.item_bg.now_txt.text.text = self.score_1
		elseif arg_42_2 == 10141 and not arg_42_4 and not arg_42_6 then
			self.score_1 = self.score_1 - 1

			if self.score_1 < 0 then
				self.score_1 = 0

				return
			end

			arg_42_1.item_bg.now_txt.text.text = self.score_1
		elseif arg_42_2 == 10141 and not arg_42_4 and arg_42_6 then
			arg_42_7 = self.score_1 == 0 and arg_42_7 - (self.score_1 + self.score_2 + self.score_3 + self.score_4 + self.score_5) or arg_42_7 - (self.score_2 + self.score_3 + self.score_4 + self.score_5)
			self.score_1 = arg_42_5 < arg_42_7 and arg_42_5 or arg_42_7
			arg_42_1.item_bg.now_txt.text.text = self.score_1
		end

		if arg_42_2 == 10241 and arg_42_4 and not arg_42_6 then
			self.score_2 = self.score_2 + 1

			if arg_42_5 < self.score_2 then
				self.score_2 = arg_42_5

				var_0_14:show(var_0_4:getNowLang("inadequate"))

				return
			end

			arg_42_1.item_bg.now_txt.text.text = self.score_2
		elseif arg_42_2 == 10241 and not arg_42_4 and not arg_42_6 then
			self.score_2 = self.score_2 - 1

			if self.score_2 < 0 then
				self.score_2 = 0

				return
			end

			arg_42_1.item_bg.now_txt.text.text = self.score_2
		elseif arg_42_2 == 10241 and not arg_42_4 and arg_42_6 then
			arg_42_7 = self.score_2 == 0 and arg_42_7 - (self.score_1 + self.score_2 + self.score_3 + self.score_4 + self.score_5) or arg_42_7 - (self.score_1 + self.score_3 + self.score_4 + self.score_5)
			self.score_2 = arg_42_5 < arg_42_7 and arg_42_5 or arg_42_7
			arg_42_1.item_bg.now_txt.text.text = self.score_2
		end

		if arg_42_2 == 10341 and arg_42_4 and not arg_42_6 then
			self.score_3 = self.score_3 + 1

			if arg_42_5 < self.score_3 then
				self.score_3 = arg_42_5

				var_0_14:show(var_0_4:getNowLang("inadequate"))

				return
			end

			arg_42_1.item_bg.now_txt.text.text = self.score_3
		elseif arg_42_2 == 10341 and not arg_42_4 and not arg_42_6 then
			self.score_3 = self.score_3 - 1

			if self.score_3 < 0 then
				self.score_3 = 0

				return
			end

			arg_42_1.item_bg.now_txt.text.text = self.score_3
		elseif arg_42_2 == 10341 and not arg_42_4 and arg_42_6 then
			arg_42_7 = self.score_3 == 0 and arg_42_7 - (self.score_1 + self.score_2 + self.score_3 + self.score_4 + self.score_5) or arg_42_7 - (self.score_1 + self.score_2 + self.score_4 + self.score_5)
			self.score_3 = arg_42_5 < arg_42_7 and arg_42_5 or arg_42_7
			arg_42_1.item_bg.now_txt.text.text = self.score_3
		end

		if arg_42_2 == 10441 and arg_42_4 and not arg_42_6 then
			self.score_4 = self.score_4 + 1

			if arg_42_5 < self.score_4 then
				self.score_4 = arg_42_5

				var_0_14:show(var_0_4:getNowLang("inadequate"))

				return
			end

			arg_42_1.item_bg.now_txt.text.text = self.score_4
		elseif arg_42_2 == 10441 and not arg_42_4 and not arg_42_6 then
			self.score_4 = self.score_4 - 1

			if self.score_4 < 0 then
				self.score_4 = 0

				return
			end

			arg_42_1.item_bg.now_txt.text.text = self.score_4
		elseif arg_42_2 == 10441 and not arg_42_4 and arg_42_6 then
			arg_42_7 = self.score_4 == 0 and arg_42_7 - (self.score_1 + self.score_2 + self.score_3 + self.score_4 + self.score_5) or arg_42_7 - (self.score_1 + self.score_2 + self.score_3 + self.score_5)
			self.score_4 = arg_42_5 < arg_42_7 and arg_42_5 or arg_42_7
			arg_42_1.item_bg.now_txt.text.text = self.score_4
		end

		if arg_42_2 == 10541 and arg_42_4 and not arg_42_6 then
			self.score_5 = self.score_5 + 1

			if arg_42_5 < self.score_5 then
				self.score_5 = arg_42_5

				var_0_14:show(var_0_4:getNowLang("inadequate"))

				return
			end

			arg_42_1.item_bg.now_txt.text.text = self.score_5
		elseif arg_42_2 == 10541 and not arg_42_4 and not arg_42_6 then
			self.score_5 = self.score_5 - 1

			if self.score_5 < 0 then
				self.score_5 = 0

				return
			end

			arg_42_1.item_bg.now_txt.text.text = self.score_5
		elseif arg_42_2 == 10541 and not arg_42_4 and arg_42_6 then
			arg_42_7 = self.score_5 == 0 and arg_42_7 - (self.score_1 + self.score_2 + self.score_3 + self.score_4 + self.score_5) or arg_42_7 - (self.score_1 + self.score_2 + self.score_3 + self.score_4)
			self.score_5 = arg_42_5 < arg_42_7 and arg_42_5 or arg_42_7
			arg_42_1.item_bg.now_txt.text.text = self.score_5
		end

		if arg_42_2 == 20141 and arg_42_4 and not arg_42_6 then
			self.blueprint_1 = self.blueprint_1 + 1

			if arg_42_5 < self.blueprint_1 then
				self.blueprint_1 = arg_42_5

				var_0_14:show(var_0_4:getNowLang("inadequate"))

				return
			end

			arg_42_1.item_bg.now_txt.text.text = self.blueprint_1
		elseif arg_42_2 == 20141 and not arg_42_4 and not arg_42_6 then
			self.blueprint_1 = self.blueprint_1 - 1

			if self.blueprint_1 < 0 then
				self.blueprint_1 = 0

				return
			end

			arg_42_1.item_bg.now_txt.text.text = self.blueprint_1
		elseif arg_42_2 == 20141 and not arg_42_4 and arg_42_6 then
			arg_42_7 = self.blueprint_1 == 0 and arg_42_7 - (self.blueprint_1 + self.blueprint_2 + self.blueprint_3) or arg_42_7 - (self.blueprint_2 + self.blueprint_3)
			self.blueprint_1 = arg_42_5 < arg_42_7 and arg_42_5 or arg_42_7
			arg_42_1.item_bg.now_txt.text.text = self.blueprint_1
		end

		if arg_42_2 == 20241 and arg_42_4 and not arg_42_6 then
			self.blueprint_2 = self.blueprint_2 + 1

			if arg_42_5 < self.blueprint_2 then
				self.blueprint_2 = arg_42_5

				var_0_14:show(var_0_4:getNowLang("inadequate"))

				return
			end

			arg_42_1.item_bg.now_txt.text.text = self.blueprint_2
		elseif arg_42_2 == 20241 and not arg_42_4 and not arg_42_6 then
			self.blueprint_2 = self.blueprint_2 - 1

			if self.blueprint_2 < 0 then
				self.blueprint_2 = 0

				return
			end

			arg_42_1.item_bg.now_txt.text.text = self.blueprint_2
		elseif arg_42_2 == 20241 and not arg_42_4 and arg_42_6 then
			arg_42_7 = self.blueprint_2 == 0 and arg_42_7 - (self.blueprint_1 + self.blueprint_2 + self.blueprint_3) or arg_42_7 - (self.blueprint_1 + self.blueprint_3)
			self.blueprint_2 = arg_42_5 < arg_42_7 and arg_42_5 or arg_42_7
			arg_42_1.item_bg.now_txt.text.text = self.blueprint_2
		end

		if arg_42_2 == 20341 and arg_42_4 and not arg_42_6 then
			self.blueprint_3 = self.blueprint_3 + 1

			if arg_42_5 < self.blueprint_3 then
				self.blueprint_3 = arg_42_5

				var_0_14:show(var_0_4:getNowLang("inadequate"))

				return
			end

			arg_42_1.item_bg.now_txt.text.text = self.blueprint_3
		elseif arg_42_2 == 20341 and not arg_42_4 and not arg_42_6 then
			self.blueprint_3 = self.blueprint_3 - 1

			if self.blueprint_3 < 0 then
				self.blueprint_3 = 0

				return
			end

			arg_42_1.item_bg.now_txt.text.text = self.blueprint_3
		elseif arg_42_2 == 20341 and not arg_42_4 and arg_42_6 then
			arg_42_7 = self.blueprint_3 == 0 and arg_42_7 - (self.blueprint_1 + self.blueprint_2 + self.blueprint_3) or arg_42_7 - (self.blueprint_1 + self.blueprint_2)
			self.blueprint_3 = arg_42_5 < arg_42_7 and arg_42_5 or arg_42_7
			arg_42_1.item_bg.now_txt.text.text = self.blueprint_3
		end

		self:add_score_data(arg_42_2)

		self._sum_score_num = self.score_1 + self.score_2 + self.score_3 + self.score_4 + self.score_5
		self._sum_blueprint_num = self.blueprint_1 + self.blueprint_2 + self.blueprint_3
		self._sum_ship_build_num = self.ship_build_1
	end

	function arg_1_0:__updata_item_num(arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5, arg_43_6, arg_43_7)
		if arg_43_4 == true and not arg_43_6 then
			self._sum_item_num = self._sum_item_num + 1

			if arg_43_5 < self._sum_item_num then
				self._sum_item_num = arg_43_5

				var_0_14:show(var_0_4:getNowLang("inadequate"))

				return
			end

			arg_43_1.item_bg.now_txt.text.text = self._sum_item_num
		elseif not arg_43_4 and not arg_43_6 then
			self._sum_item_num = self._sum_item_num - 1

			if self._sum_item_num < 0 then
				self._sum_item_num = 0

				return
			end

			arg_43_1.item_bg.now_txt.text.text = self._sum_item_num
		elseif arg_43_6 and (self._sum_item_num ~= 0 or true) then
			self._sum_item_num = arg_43_5 < arg_43_7 and arg_43_5 or arg_43_7
			arg_43_1.item_bg.now_txt.text.text = self._sum_item_num
		end

		if self._sum_item_info and next(self._sum_item_info) then
			self._sum_item_info[1].num = self._sum_item_num
		else
			var_0_10(self._sum_item_info, {
				cid = arg_43_2.item_id,
				num = self._sum_item_num
			})
		end
	end

	function arg_1_0:__add_item_type(arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5, arg_44_6, arg_44_7)
		if arg_44_1 == arg_44_2 and arg_44_3 == true and not arg_44_4 then
			self.ship_build_1 = self.ship_build_1 + 1

			if arg_44_5 < self.ship_build_1 then
				self.ship_build_1 = arg_44_5

				var_0_14:show(var_0_4:getNowLang("inadequate"))

				return
			end

			arg_44_6.item_bg.now_txt.text.text = self.ship_build_1
		elseif arg_44_1 == arg_44_2 and not arg_44_3 and not arg_44_4 then
			self.ship_build_1 = self.ship_build_1 - 1

			if self.ship_build_1 < 0 then
				self.ship_build_1 = 0

				return
			end

			arg_44_6.item_bg.now_txt.text.text = self.ship_build_1
		elseif arg_44_1 == arg_44_2 and not arg_44_3 and arg_44_4 then
			arg_44_7 = self.ship_build_1 == 0 and arg_44_7 - self.ship_build_1 or arg_44_7
			self.ship_build_1 = arg_44_5 < arg_44_7 and arg_44_5 or arg_44_7
			arg_44_6.item_bg.now_txt.text.text = self.ship_build_1
		end
	end

	function arg_1_0:updata_equip_drawing_num(arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5, arg_45_6, arg_45_7)
		if arg_45_2 == 10141 then
			self:__add_item_score_show(arg_45_2, arg_45_4, arg_45_6, arg_45_5, arg_45_1, 10141, arg_45_7, self.score_1)
		elseif arg_45_2 == 10241 then
			self:__add_item_score_show(arg_45_2, arg_45_4, arg_45_6, arg_45_5, arg_45_1, 10241, arg_45_7, self.score_2)
		elseif arg_45_2 == 10341 then
			self:__add_item_score_show(arg_45_2, arg_45_4, arg_45_6, arg_45_5, arg_45_1, 10341, arg_45_7, self.score_3)
		elseif arg_45_2 == 10441 then
			self:__add_item_score_show(arg_45_2, arg_45_4, arg_45_6, arg_45_5, arg_45_1, 10441, arg_45_7, self.score_4)
		elseif arg_45_2 == 10541 then
			self:__add_item_score_show(arg_45_2, arg_45_4, arg_45_6, arg_45_5, arg_45_1, 10541, arg_45_7, self.score_5)
		elseif arg_45_2 == 20141 then
			self:__add_item_blueprint_show(arg_45_2, arg_45_4, arg_45_6, arg_45_5, arg_45_1, 20141, arg_45_7, self.blueprint_1)
		elseif arg_45_2 == 20241 then
			self:__add_item_blueprint_show(arg_45_2, arg_45_4, arg_45_6, arg_45_5, arg_45_1, 20241, arg_45_7, self.blueprint_2)
		elseif arg_45_2 == 20341 then
			self:__add_item_blueprint_show(arg_45_2, arg_45_4, arg_45_6, arg_45_5, arg_45_1, 20341, arg_45_7, self.blueprint_3)
		end

		if self.blueprint_1 > 0 then
			self._sum_equip_drawing_num = self.blueprint_1
		elseif self.blueprint_2 > 0 then
			self._sum_equip_drawing_num = self.blueprint_2
		elseif self.blueprint_3 > 0 then
			self._sum_equip_drawing_num = self.blueprint_3
		elseif self.equip_drawing_1 > 0 then
			self._sum_equip_drawing_num = self.equip_drawing_1
		elseif self.score_1 > 0 then
			self._sum_equip_drawing_num = self.score_1
		elseif self.score_2 > 0 then
			self._sum_equip_drawing_num = self.score_2
		elseif self.score_3 > 0 then
			self._sum_equip_drawing_num = self.score_3
		elseif self.score_4 > 0 then
			self._sum_equip_drawing_num = self.score_4
		elseif self.score_5 > 0 then
			self._sum_equip_drawing_num = self.score_5
		end

		if self.blueprint_1 == 0 and self.blueprint_2 == 0 and self.blueprint_3 == 0 and self.equip_drawing_1 == 0 and self.score_1 == 0 and self.score_2 == 0 and self.score_3 == 0 and self.score_4 == 0 and self.score_5 == 0 then
			self._sum_equip_drawing_num = 0
		end
	end

	function arg_1_0.__add_item_score_show(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5, arg_46_6, arg_46_7, arg_46_8)
		if arg_46_1 == arg_46_6 and arg_46_2 == true and not arg_46_3 then
			arg_46_8 = arg_46_8 + 1

			if arg_46_4 < arg_46_8 then
				arg_46_8 = arg_46_4

				var_0_14:show(var_0_4:getNowLang("inadequate"))

				return
			end

			arg_46_5.item_bg.now_txt.text.text = arg_46_8
		elseif arg_46_1 == arg_46_6 and not arg_46_2 and not arg_46_3 then
			arg_46_8 = arg_46_8 - 1

			if arg_46_8 < 0 then
				arg_46_8 = 0
			end

			arg_46_5.item_bg.now_txt.text.text = arg_46_8
		elseif arg_46_1 == arg_46_6 and not arg_46_2 and arg_46_3 then
			arg_46_7 = arg_46_8 == 0 and arg_46_7 - arg_46_8 or arg_46_7
			arg_46_8 = arg_46_4 < arg_46_7 and arg_46_4 or arg_46_7
			arg_46_5.item_bg.now_txt.text.text = arg_46_8
		end

		if arg_46_6 == 10141 then
			arg_46_0.score_1 = arg_46_8
		elseif arg_46_6 == 10241 then
			arg_46_0.score_2 = arg_46_8
		elseif arg_46_6 == 10341 then
			arg_46_0.score_3 = arg_46_8
		elseif arg_46_6 == 10441 then
			arg_46_0.score_4 = arg_46_8
		elseif arg_46_6 == 10541 then
			arg_46_0.score_5 = arg_46_8
		end
	end

	function arg_1_0.__add_item_blueprint_show(arg_47_0, arg_47_1, arg_47_2, arg_47_3, arg_47_4, arg_47_5, arg_47_6, arg_47_7, arg_47_8)
		if arg_47_1 == arg_47_6 and arg_47_2 == true and not arg_47_3 then
			arg_47_8 = arg_47_8 + 1

			if arg_47_4 < arg_47_8 then
				arg_47_8 = arg_47_4

				var_0_14:show(var_0_4:getNowLang("inadequate"))

				return
			end

			arg_47_5.item_bg.now_txt.text.text = arg_47_8
		elseif arg_47_1 == arg_47_6 and not arg_47_2 and not arg_47_3 then
			arg_47_8 = arg_47_8 - 1

			if arg_47_8 < 0 then
				arg_47_8 = 0
			end

			arg_47_5.item_bg.now_txt.text.text = arg_47_8
		elseif arg_47_1 == arg_47_6 and not arg_47_2 and arg_47_3 then
			arg_47_7 = arg_47_8 == 0 and arg_47_7 - arg_47_8 or arg_47_7
			arg_47_8 = arg_47_4 < arg_47_7 and arg_47_4 or arg_47_7
			arg_47_5.item_bg.now_txt.text.text = arg_47_8
		end

		if arg_47_6 == 20141 then
			arg_47_0.blueprint_1 = arg_47_8
		elseif arg_47_6 == 20241 then
			arg_47_0.blueprint_2 = arg_47_8
		elseif arg_47_6 == 20341 then
			arg_47_0.blueprint_3 = arg_47_8
		end
	end

	function arg_1_0:update_core_task_info(arg_48_1, arg_48_2)
		self._control.submit_core_bg.top_txt.text.text = arg_48_1 and arg_48_1.item_id and var_0_4:getNowLang("submit") .. var_0_13.find_object_by_cid(arg_48_1.item_id).title or var_0_4:getNowLang("submit_core")
		self._control.right.submit_title_bg.submit_title_txt.text.text = var_0_4:getNowLang("core_need")
		self._control.submit_core_bg.start_btn.start_btn_txt.text.text = var_0_4:getNowLang("submit_core")

		if arg_48_2 then
			self._control.right.need_node.need_text.text.text = var_0_9.convert_rich_text(arg_48_2)
		end

		self._control.right.progress_bg.need_sum_txt.text.text = arg_48_1.num

		local var_48_0 = var_0_2:get_research_ship_id()

		for iter_48_0, iter_48_1 in pairs((var_0_2:get_ship_task_info())) do
			if iter_48_1.id == self._now_ship_id then
				if var_48_0 == 1 then
					self._already_select_num = iter_48_1.task_num_1

					local var_48_1 = iter_48_1.task_num_1 / arg_48_1.num * 100

					if iter_48_1.task_num_1 / arg_48_1.num * 100 < 1 and var_48_1 > 0 then
						var_48_1 = 1
					end

					self._control.right.progress_bg.have_txt.text.text = var_0_9.get_simplify_num(iter_48_1.task_num_1 + self._sum_score_num) .. " /"
					self._control.finish_bg.finish_txt.text.text = var_0_9.get_simplify_num((math.floor(var_48_1))) .. "%"
					self._control.right.need_bg.need_now_img.image.fillAmount = iter_48_1.task_num_1 / arg_48_1.num + self._sum_score_num / arg_48_1.num
					self._control.right.need_bg.now_img.image.fillAmount = iter_48_1.task_num_1 / arg_48_1.num
				elseif var_48_0 == 2 then
					local var_48_2 = iter_48_1.task_num_2 / arg_48_1.num * 100

					if iter_48_1.task_num_2 / arg_48_1.num * 100 < 1 and var_48_2 > 0 then
						var_48_2 = 1
					end

					self._already_select_num = iter_48_1.task_num_2
					self._control.right.progress_bg.have_txt.text.text = var_0_9.get_simplify_num(iter_48_1.task_num_2 + self._sum_score_num) .. " /"
					self._control.finish_bg.finish_txt.text.text = var_0_9.get_simplify_num((math.floor(var_48_2))) .. "%"
					self._control.right.need_bg.need_now_img.image.fillAmount = iter_48_1.task_num_2 / arg_48_1.num + self._sum_score_num / arg_48_1.num
					self._control.right.need_bg.now_img.image.fillAmount = iter_48_1.task_num_2 / arg_48_1.num
				elseif var_48_0 == 3 then
					local var_48_3 = iter_48_1.task_num_3 / arg_48_1.num * 100

					if iter_48_1.task_num_3 / arg_48_1.num * 100 < 1 and var_48_3 > 0 then
						var_48_3 = 1
					end

					self._already_select_num = iter_48_1.task_num_3
					self._control.right.progress_bg.have_txt.text.text = var_0_9.get_simplify_num(iter_48_1.task_num_3 + self._sum_score_num) .. " /"
					self._control.finish_bg.finish_txt.text.text = var_0_9.get_simplify_num((math.floor(var_48_3))) .. "%"
					self._control.right.need_bg.need_now_img.image.fillAmount = iter_48_1.task_num_3 / arg_48_1.num + self._sum_score_num / arg_48_1.num
					self._control.right.need_bg.now_img.image.fillAmount = iter_48_1.task_num_3 / arg_48_1.num
				end
			end
		end
	end

	function arg_1_0:update_ship_build_task_info(arg_49_1, arg_49_2)
		if arg_49_1.item_id then
			local var_49_0 = var_0_13.find_object_by_cid(arg_49_1.item_id)

			self._control.right.submit_title_bg.submit_title_txt.text.text = arg_49_1.item_id > 10000 and arg_49_1.item_id < 20000 and var_0_4:getNowLang("core_need") or arg_49_1.item_id > 20000 and var_0_4:getNowLang("core_need2") or var_0_4:getNowLang("core_need2")
			self._control.submit_core_bg.top_txt.text.text = var_0_4:getNowLang("submit") .. var_49_0.title
		else
			self._control.right.submit_title_bg.submit_title_txt.text.text = var_0_4:getNowLang("core_need2")
			self._control.submit_core_bg.top_txt.text.text = var_0_4:getNowLang("submit") .. var_0_4:getNowLang("shipblueprint")
		end

		self._control.submit_core_bg.start_btn.start_btn_txt.text.text = var_0_4:getNowLang("submit")

		if arg_49_2 then
			self._control.right.need_node.need_text.text.text = var_0_9.convert_rich_text(arg_49_2)
		end

		self._control.right.progress_bg.need_sum_txt.text.text = arg_49_1.num

		local var_49_1 = var_0_2:get_research_ship_id()

		for iter_49_0, iter_49_1 in pairs((var_0_2:get_ship_task_info())) do
			if iter_49_1.id == self._now_ship_id then
				if var_49_1 == 1 then
					self._already_select_num = iter_49_1.task_num_1

					local var_49_2 = iter_49_1.task_num_1 / arg_49_1.num * 100

					if iter_49_1.task_num_1 / arg_49_1.num * 100 < 1 and var_49_2 > 0 then
						var_49_2 = 1
					end

					self._control.right.progress_bg.have_txt.text.text = var_0_9.get_simplify_num(iter_49_1.task_num_1 + self._sum_ship_build_num) .. " /"
					self._control.finish_bg.finish_txt.text.text = var_0_9.get_simplify_num((math.floor(var_49_2))) .. "%"
					self._control.right.need_bg.need_now_img.image.fillAmount = iter_49_1.task_num_1 / arg_49_1.num + self._sum_ship_build_num / arg_49_1.num
					self._control.right.need_bg.now_img.image.fillAmount = iter_49_1.task_num_1 / arg_49_1.num
				elseif var_49_1 == 2 then
					local var_49_3 = iter_49_1.task_num_2 / arg_49_1.num * 100

					if iter_49_1.task_num_2 / arg_49_1.num * 100 < 1 and var_49_3 > 0 then
						var_49_3 = 1
					end

					self._already_select_num = iter_49_1.task_num_2
					self._control.right.progress_bg.have_txt.text.text = var_0_9.get_simplify_num(iter_49_1.task_num_2 + self._sum_ship_build_num) .. " /"
					self._control.finish_bg.finish_txt.text.text = var_0_9.get_simplify_num((math.floor(var_49_3))) .. "%"
					self._control.right.need_bg.need_now_img.image.fillAmount = iter_49_1.task_num_2 / arg_49_1.num + self._sum_ship_build_num / arg_49_1.num
					self._control.right.need_bg.now_img.image.fillAmount = iter_49_1.task_num_2 / arg_49_1.num
				elseif var_49_1 == 3 then
					local var_49_4 = iter_49_1.task_num_3 / arg_49_1.num * 100

					if iter_49_1.task_num_3 / arg_49_1.num * 100 < 1 and var_49_4 > 0 then
						var_49_4 = 1
					end

					self._already_select_num = iter_49_1.task_num_3
					self._control.right.progress_bg.have_txt.text.text = var_0_9.get_simplify_num(iter_49_1.task_num_3 + self._sum_ship_build_num) .. " /"
					self._control.finish_bg.finish_txt.text.text = var_0_9.get_simplify_num((math.floor(var_49_4))) .. "%"
					self._control.right.need_bg.need_now_img.image.fillAmount = iter_49_1.task_num_3 / arg_49_1.num + self._sum_ship_build_num / arg_49_1.num
					self._control.right.need_bg.now_img.image.fillAmount = iter_49_1.task_num_3 / arg_49_1.num
				end
			end
		end
	end

	function arg_1_0:_update_item_task_info(arg_50_1, arg_50_2)
		if arg_50_1.item_id then
			self._control.right.submit_title_bg.submit_title_txt.text.text = var_0_4:getNowLang("core_need")
			self._control.submit_core_bg.top_txt.text.text = var_0_4:getNowLang("submit") .. var_0_4:getNowLang("shopitem")
		end

		self._control.submit_core_bg.start_btn.start_btn_txt.text.text = var_0_4:getNowLang("submit")

		if arg_50_2 then
			self._control.right.need_node.need_text.text.text = var_0_9.convert_rich_text(arg_50_2)
		end

		self._control.right.progress_bg.need_sum_txt.text.text = arg_50_1.num

		local var_50_0
		local var_50_1 = var_0_2:get_research_ship_id()
		local var_50_2

		if self._type_layer == 6 then
			var_50_0 = var_0_2:get_ship_task_info()
			var_50_2 = self._now_ship_id
		else
			var_50_0 = var_0_2:get_equip_task_info()
			var_50_1 = var_0_2:get_research_equip_stage()
			var_50_2 = self._now_equip_id
		end

		for iter_50_0, iter_50_1 in pairs(var_50_0) do
			if iter_50_1.id == var_50_2 then
				if var_50_1 == 1 then
					self._already_select_num = iter_50_1.task_num_1

					local var_50_3 = iter_50_1.task_num_1 / arg_50_1.num * 100

					if iter_50_1.task_num_1 / arg_50_1.num * 100 < 1 and var_50_3 > 0 then
						var_50_3 = 1
					end

					self._control.right.progress_bg.have_txt.text.text = var_0_9.get_simplify_num(iter_50_1.task_num_1 + self._sum_item_num) .. " /"
					self._control.finish_bg.finish_txt.text.text = var_0_9.get_simplify_num((math.floor(var_50_3))) .. "%"
					self._control.right.need_bg.need_now_img.image.fillAmount = iter_50_1.task_num_1 / arg_50_1.num + self._sum_item_num / arg_50_1.num
					self._control.right.need_bg.now_img.image.fillAmount = iter_50_1.task_num_1 / arg_50_1.num
				elseif var_50_1 == 2 then
					local var_50_4 = iter_50_1.task_num_2 / arg_50_1.num * 100

					if iter_50_1.task_num_2 / arg_50_1.num * 100 < 1 and var_50_4 > 0 then
						var_50_4 = 1
					end

					self._already_select_num = iter_50_1.task_num_2
					self._control.right.progress_bg.have_txt.text.text = var_0_9.get_simplify_num(iter_50_1.task_num_2 + self._sum_item_num) .. " /"
					self._control.finish_bg.finish_txt.text.text = var_0_9.get_simplify_num((math.floor(var_50_4))) .. "%"
					self._control.right.need_bg.need_now_img.image.fillAmount = iter_50_1.task_num_2 / arg_50_1.num + self._sum_item_num / arg_50_1.num
					self._control.right.need_bg.now_img.image.fillAmount = iter_50_1.task_num_2 / arg_50_1.num
				elseif var_50_1 == 3 then
					local var_50_5 = iter_50_1.task_num_3 / arg_50_1.num * 100

					if iter_50_1.task_num_3 / arg_50_1.num * 100 < 1 and var_50_5 > 0 then
						var_50_5 = 1
					end

					self._already_select_num = iter_50_1.task_num_3
					self._control.right.progress_bg.have_txt.text.text = var_0_9.get_simplify_num(iter_50_1.task_num_3 + self._sum_item_num) .. " /"
					self._control.finish_bg.finish_txt.text.text = var_0_9.get_simplify_num((math.floor(var_50_5))) .. "%"
					self._control.right.need_bg.need_now_img.image.fillAmount = iter_50_1.task_num_3 / arg_50_1.num + self._sum_item_num / arg_50_1.num
					self._control.right.need_bg.now_img.image.fillAmount = iter_50_1.task_num_3 / arg_50_1.num
				end
			end
		end
	end

	function arg_1_0:update_equip_drawing_task_info(arg_51_1, arg_51_2)
		local var_51_0 = var_0_13.find_object_by_cid(arg_51_1.item_id)

		self._control.submit_core_bg.top_txt.text.text = var_0_4:getNowLang("submit") .. var_51_0.title
		self._control.right.submit_title_bg.submit_title_txt.text.text = var_51_0.cid > 10000 and var_51_0.cid < 20000 and var_0_4:getNowLang("core_need") or (var_51_0.cid < 10000 or var_51_0.cid > 20000) and var_0_4:getNowLang("core_need2") or var_0_4:getNowLang("core_need2")
		self._control.submit_core_bg.start_btn.start_btn_txt.text.text = var_0_4:getNowLang("submit")

		if arg_51_2 then
			self._control.right.need_node.need_text.text.text = var_0_9.convert_rich_text(arg_51_2)
		end

		self._control.right.progress_bg.need_sum_txt.text.text = arg_51_1.num

		local var_51_1 = var_0_2:get_research_equip_stage()

		for iter_51_0, iter_51_1 in pairs((var_0_2:get_equip_task_info())) do
			if iter_51_1.id == self._now_equip_id then
				if var_51_1 == 1 then
					self._already_select_equip_num = iter_51_1.task_num_1

					local var_51_2 = iter_51_1.task_num_1 / arg_51_1.num * 100

					if iter_51_1.task_num_1 / arg_51_1.num * 100 < 1 and var_51_2 > 0 then
						var_51_2 = 1
					end

					self._already_select_num = iter_51_1.task_num_1
					self._control.right.progress_bg.have_txt.text.text = var_0_9.get_simplify_num(iter_51_1.task_num_1 + self._sum_equip_drawing_num) .. " /"
					self._control.finish_bg.finish_txt.text.text = var_0_9.get_simplify_num((math.floor(var_51_2))) .. "%"
					self._control.right.need_bg.need_now_img.image.fillAmount = iter_51_1.task_num_1 / arg_51_1.num + self._sum_equip_drawing_num / arg_51_1.num
					self._control.right.need_bg.now_img.image.fillAmount = iter_51_1.task_num_1 / arg_51_1.num
				elseif var_51_1 == 2 then
					local var_51_3 = iter_51_1.task_num_2 / arg_51_1.num * 100

					if iter_51_1.task_num_2 / arg_51_1.num * 100 < 1 and var_51_3 > 0 then
						var_51_3 = 1
					end

					self._already_select_equip_num = iter_51_1.task_num_2
					self._control.right.progress_bg.have_txt.text.text = var_0_9.get_simplify_num(iter_51_1.task_num_2 + self._sum_equip_drawing_num) .. " /"
					self._already_select_num = iter_51_1.task_num_2
					self._control.finish_bg.finish_txt.text.text = var_0_9.get_simplify_num((math.floor(var_51_3))) .. "%"
					self._control.right.need_bg.need_now_img.image.fillAmount = iter_51_1.task_num_2 / arg_51_1.num + self._sum_equip_drawing_num / arg_51_1.num
					self._control.right.need_bg.now_img.image.fillAmount = iter_51_1.task_num_2 / arg_51_1.num
				elseif var_51_1 == 3 then
					local var_51_4 = iter_51_1.task_num_3 / arg_51_1.num * 100

					if iter_51_1.task_num_3 / arg_51_1.num * 100 < 1 and var_51_4 > 0 then
						var_51_4 = 1
					end

					self._already_select_num = iter_51_1.task_num_3
					self._control.right.progress_bg.have_txt.text.text = var_0_9.get_simplify_num(iter_51_1.task_num_3 + self._sum_equip_drawing_num) .. " /"
					self._control.finish_bg.finish_txt.text.text = var_0_9.get_simplify_num((math.floor(var_51_4))) .. "%"
					self._control.right.need_bg.need_now_img.image.fillAmount = iter_51_1.task_num_3 / arg_51_1.num + self._sum_equip_drawing_num / arg_51_1.num
					self._control.right.need_bg.now_img.image.fillAmount = iter_51_1.task_num_3 / arg_51_1.num
				end
			end
		end
	end

	function arg_1_0:add_score_data(arg_52_1)
		local var_52_0 = {}

		if self._sum_score_info and next(self._sum_score_info) then
			for iter_52_0, iter_52_1 in ipairs(self._sum_score_info) do
				var_0_10(var_52_0, iter_52_1.cid)
			end

			if var_0_9.have_data(var_52_0, arg_52_1) then
				for iter_52_2, iter_52_3 in ipairs(self._sum_score_info) do
					if arg_52_1 == iter_52_3.cid and arg_52_1 == 10141 then
						iter_52_3.num = self.score_1
					elseif arg_52_1 == iter_52_3.cid and arg_52_1 == 10241 then
						iter_52_3.num = self.score_2
					elseif arg_52_1 == iter_52_3.cid and arg_52_1 == 10341 then
						iter_52_3.num = self.score_3
					elseif arg_52_1 == iter_52_3.cid and arg_52_1 == 10441 then
						iter_52_3.num = self.score_4
					elseif arg_52_1 == iter_52_3.cid and arg_52_1 == 10541 then
						iter_52_3.num = self.score_5
					end
				end
			elseif arg_52_1 == 10141 then
				var_0_10(self._sum_score_info, {
					cid = arg_52_1,
					num = self.score_1
				})
			elseif arg_52_1 == 10241 then
				var_0_10(self._sum_score_info, {
					cid = arg_52_1,
					num = self.score_2
				})
			elseif arg_52_1 == 10341 then
				var_0_10(self._sum_score_info, {
					cid = arg_52_1,
					num = self.score_3
				})
			elseif arg_52_1 == 10441 then
				var_0_10(self._sum_score_info, {
					cid = arg_52_1,
					num = self.score_4
				})
			elseif arg_52_1 == 10541 then
				var_0_10(self._sum_score_info, {
					cid = arg_52_1,
					num = self.score_5
				})
			end
		elseif arg_52_1 == 10141 then
			var_0_10(self._sum_score_info, {
				cid = arg_52_1,
				num = self.score_1
			})
		elseif arg_52_1 == 10241 then
			var_0_10(self._sum_score_info, {
				cid = arg_52_1,
				num = self.score_2
			})
		elseif arg_52_1 == 10341 then
			var_0_10(self._sum_score_info, {
				cid = arg_52_1,
				num = self.score_3
			})
		elseif arg_52_1 == 10441 then
			var_0_10(self._sum_score_info, {
				cid = arg_52_1,
				num = self.score_4
			})
		elseif arg_52_1 == 10541 then
			var_0_10(self._sum_score_info, {
				cid = arg_52_1,
				num = self.score_5
			})
		end
	end

	function arg_1_0:update_blueprint_task_info(arg_53_1, arg_53_2)
		self._control.submit_core_bg.top_txt.text.text = var_0_4:getNowLang("submit_core2")
		self._control.right.submit_title_bg.submit_title_txt.text.text = var_0_4:getNowLang("core_need2")
		self._control.submit_core_bg.start_btn.start_btn_txt.text.text = var_0_4:getNowLang("submit_core2")

		if arg_53_2 then
			self._control.right.need_node.need_text.text.text = var_0_9.convert_rich_text(arg_53_2)
		end

		self._control.right.progress_bg.need_sum_txt.text.text = arg_53_1.num

		for iter_53_0, iter_53_1 in pairs((var_0_2:get_ship_task_info())) do
			if iter_53_1.id == self._now_ship_id then
				local var_53_0 = var_0_2:get_research_ship_id()

				if var_53_0 == 1 then
					local var_53_1 = iter_53_1.task_num_1 / arg_53_1.num * 100

					if iter_53_1.task_num_1 / arg_53_1.num * 100 < 1 and var_53_1 > 0 then
						var_53_1 = 1
					end

					self._already_select_num = iter_53_1.task_num_1
					self._control.right.progress_bg.have_txt.text.text = var_0_9.get_simplify_num(iter_53_1.task_num_1 + self._sum_blueprint_num) .. " /"
					self._control.finish_bg.finish_txt.text.text = var_0_9.get_simplify_num((math.floor(var_53_1))) .. "%"
					self._control.right.need_bg.need_now_img.image.fillAmount = iter_53_1.task_num_1 / arg_53_1.num + self._sum_blueprint_num / arg_53_1.num
					self._control.right.need_bg.now_img.image.fillAmount = iter_53_1.task_num_1 / arg_53_1.num
				elseif var_53_0 == 2 then
					local var_53_2 = iter_53_1.task_num_2 / arg_53_1.num * 100

					if iter_53_1.task_num_2 / arg_53_1.num * 100 < 1 and var_53_2 > 0 then
						var_53_2 = 1
					end

					self._already_select_num = iter_53_1.task_num_2
					self._control.right.progress_bg.have_txt.text.text = var_0_9.get_simplify_num(iter_53_1.task_num_2 + self._sum_blueprint_num) .. " /"
					self._control.finish_bg.finish_txt.text.text = var_0_9.get_simplify_num((math.floor(var_53_2))) .. "%"
					self._control.right.need_bg.need_now_img.image.fillAmount = iter_53_1.task_num_2 / arg_53_1.num + self._sum_blueprint_num / arg_53_1.num
					self._control.right.need_bg.now_img.image.fillAmount = iter_53_1.task_num_2 / arg_53_1.num
				elseif var_53_0 == 3 then
					local var_53_3 = iter_53_1.task_num_3 / arg_53_1.num * 100

					if iter_53_1.task_num_3 / arg_53_1.num * 100 < 1 and var_53_3 > 0 then
						var_53_3 = 1
					end

					self._already_select_num = iter_53_1.task_num_3
					self._control.right.progress_bg.have_txt.text.text = var_0_9.get_simplify_num(iter_53_1.task_num_3 + self._sum_blueprint_num) .. " /"
					self._control.finish_bg.finish_txt.text.text = var_0_9.get_simplify_num((math.floor(var_53_3))) .. "%"
					self._control.right.need_bg.need_now_img.image.fillAmount = iter_53_1.task_num_3 / arg_53_1.num + self._sum_blueprint_num / arg_53_1.num
					self._control.right.need_bg.now_img.image.fillAmount = iter_53_1.task_num_3 / arg_53_1.num
				end
			end
		end
	end

	function arg_1_0:update_equip_task_info(arg_54_1)
		self._now_equip_id = arg_54_1.id

		self._control.research_bureau_bg.right.equip_show.equip_bg.equip_finish:SetActive(false)
		self._control.research_bureau_bg.right.ship_show:SetActive(false)
		self._control.research_bureau_bg.right.equip_show:SetActive(true)

		local var_54_0

		if arg_54_1 and next(arg_54_1) then
			var_54_0 = var_0_12.find_object_by_cid(arg_54_1.equipment_id)
		end

		self._control.research_bureau_bg.right.equip_show.equip_bg.equip.name_level.name_level_1.text.text = var_54_0.title

		self._control.research_bureau_bg.right.equip_show.equip_bg.equip.name_level:GetComponent("TextHorizonScroller"):SetText(var_54_0.title)
		self.__equip_task_name_list_2[1]:GetComponent("TextHorizonScroller"):SetText(arg_54_1.task1_name)
		self.__equip_task_name_list_2[2]:GetComponent("TextHorizonScroller"):SetText(arg_54_1.task2_name)
		self.__equip_task_name_list_2[3]:GetComponent("TextHorizonScroller"):SetText(arg_54_1.task3_name)

		self.__equip_start_btn_txt_list[1].text.text = arg_54_1.task1.type < 3 and var_0_4:getNowLang("submit") or var_0_4:getNowLang("questgo")
		self.__equip_start_btn_txt_list[2].text.text = arg_54_1.task2.type < 3 and var_0_4:getNowLang("submit") or var_0_4:getNowLang("questgo")
		self.__equip_start_btn_txt_list[3].text.text = arg_54_1.task3.type < 3 and var_0_4:getNowLang("submit") or var_0_4:getNowLang("questgo")
		self.__equip_task_text_list[1].text.text = var_0_9.convert_rich_text(arg_54_1.task1_desc)
		self.__equip_task_text_list[2].text.text = var_0_9.convert_rich_text(arg_54_1.task2_desc)
		self.__equip_task_text_list[3].text.text = var_0_9.convert_rich_text(arg_54_1.task3_desc)

		local var_54_1 = {}
		local var_54_2 = var_0_8.find_object_by_id(self._now_ship_id)

		for iter_54_0, iter_54_1 in pairs((var_0_2:get_equip_task_info())) do
			if var_0_9.have_data(var_54_2.equipment, iter_54_1.id) then
				var_0_10(var_54_1, iter_54_1)
			end
		end

		self.__reseach_equip_progress_sum = 0

		for iter_54_2, iter_54_3 in pairs(var_54_1) do
			local var_54_3 = var_0_15.find_object_by_id(iter_54_3.id)

			if iter_54_3.task_num_1 >= var_54_3.task1.num then
				iter_54_3.task_num_1 = var_54_3.task1.num
			end

			if iter_54_3.task_num_2 >= var_54_3.task2.num then
				iter_54_3.task_num_2 = var_54_3.task2.num
			end

			if iter_54_3.task_num_3 >= var_54_3.task3.num then
				iter_54_3.task_num_3 = var_54_3.task3.num
			end

			if iter_54_3.id == self._now_equip_id and var_54_3.equipment_id == arg_54_1.equipment_id then
				local var_54_7 = iter_54_3.task_num_1 * 100 / var_54_3.task1.num
				local var_54_8 = iter_54_3.task_num_2 * 100 / var_54_3.task2.num
				local var_54_9 = iter_54_3.task_num_3 * 100 / var_54_3.task3.num

				if iter_54_3.task_num_1 * 100 / var_54_3.task1.num > 0 and var_54_7 < 2 then
					var_54_7 = 1
				end

				if var_54_8 > 0 and var_54_8 < 2 then
					var_54_8 = 1
				end

				if var_54_9 > 0 and var_54_9 < 2 then
					var_54_9 = 1
				end

				self.__equip_progress_time_list[1].text.text = math.floor(var_54_7) .. "%"
				self.__equip_progress_time_list[2].text.text = math.floor(var_54_8) .. "%"
				self.__equip_progress_time_list[3].text.text = math.floor(var_54_9) .. "%"
				self.__reseach_equip_progress_sum = (iter_54_3.task_num_1 / var_54_3.task1.num + iter_54_3.task_num_2 / var_54_3.task2.num + iter_54_3.task_num_3 / var_54_3.task3.num) / 3
				self._control.research_bureau_bg.right.equip_show.equip_bg.equip.equip_all_time.image.fillAmount = self.__reseach_equip_progress_sum
				self._control.research_bureau_bg.right.equip_show.equip_bg.equip.equip_all_time_bg.image.sprite = self.__reseach_equip_progress_sum >= 1 and self:loadSprite(var_0_5.research_equip_task_image.finish) or self:loadSprite(var_0_5.research_equip_task_image.ongoing)

				if iter_54_3.task_num_1 >= var_54_3.task1.num then
					self.__equip_task_finish_list[1].gameObject:SetActive(true)
					self.__equip_start_btn_list[1].gameObject:SetActive(false)
				else
					self.__equip_task_finish_list[1].gameObject:SetActive(false)
					self.__equip_start_btn_list[1].gameObject:SetActive(true)
				end

				if iter_54_3.task_num_2 >= var_54_3.task2.num then
					self.__equip_task_finish_list[2].gameObject:SetActive(true)
					self.__equip_start_btn_list[2].gameObject:SetActive(false)
				else
					self.__equip_task_finish_list[2].gameObject:SetActive(false)
					self.__equip_start_btn_list[2].gameObject:SetActive(true)
				end

				if iter_54_3.task_num_3 >= var_54_3.task3.num then
					self.__equip_task_finish_list[3].gameObject:SetActive(true)
					self.__equip_start_btn_list[3].gameObject:SetActive(false)
				else
					self.__equip_task_finish_list[3].gameObject:SetActive(false)
					self.__equip_start_btn_list[3].gameObject:SetActive(true)
				end

				if iter_54_3.status == 1 then
					self._control.research_bureau_bg.right.equip_show.equip_bg.equip.finish_1_img:SetActive(true)
				else
					self._control.research_bureau_bg.right.equip_show.equip_bg.equip.finish_1_img:SetActive(false)
				end
			end
		end

		local var_54_11 = var_0_2:get_unlock_equips_info()

		if var_54_11 and next(var_54_11) then
			for iter_54_4, iter_54_5 in pairs(var_54_11) do
				if self.equip_stage == 1 and var_54_1[1].status == 1 then
					local var_54_12 = var_0_15.find_object_by_id(var_54_1[1].id)

					self._equip_task_id = var_54_1[1].id

					if var_0_9.have_data(var_54_11, var_54_1[1].id) then
						self._control.research_bureau_bg.right.equip_show.equip_bg.equip_finish:SetActive(false)
					else
						self._control.research_bureau_bg.right.equip_show.equip_bg.equip_finish:SetActive(true)
					end
				elseif self.equip_stage == 2 and var_54_1[2].status == 1 then
					local var_54_13 = var_0_15.find_object_by_id(var_54_1[2].id)

					self._equip_task_id = var_54_1[2].id

					if var_0_9.have_data(var_54_11, var_54_1[2].id) then
						self._control.research_bureau_bg.right.equip_show.equip_bg.equip_finish:SetActive(false)
					else
						self._control.research_bureau_bg.right.equip_show.equip_bg.equip_finish:SetActive(true)
					end
				elseif self.equip_stage == 3 and var_54_1[3].status == 1 then
					local var_54_14 = var_0_15.find_object_by_id(var_54_1[3].id)

					self._equip_task_id = var_54_1[3].id

					if var_0_9.have_data(var_54_11, var_54_1[3].id) then
						self._control.research_bureau_bg.right.equip_show.equip_bg.equip_finish:SetActive(false)
					else
						self._control.research_bureau_bg.right.equip_show.equip_bg.equip_finish:SetActive(true)
					end
				elseif self.equip_stage == 4 and var_54_1[4].status == 1 then
					local var_54_15 = var_0_15.find_object_by_id(var_54_1[4].id)

					self._equip_task_id = var_54_1[4].id

					if var_0_9.have_data(var_54_11, var_54_1[4].id) then
						self._control.research_bureau_bg.right.equip_show.equip_bg.equip_finish:SetActive(false)
					else
						self._control.research_bureau_bg.right.equip_show.equip_bg.equip_finish:SetActive(true)
					end
				end
			end
		elseif self.equip_stage == 1 and var_54_1[1].status == 1 then
			local var_54_16 = var_0_15.find_object_by_id(var_54_1[1].id)

			self._equip_task_id = var_54_1[1].id

			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_finish:SetActive(true)
		elseif self.equip_stage == 2 and var_54_1[2].status == 1 then
			local var_54_17 = var_0_15.find_object_by_id(var_54_1[2].id)

			self._equip_task_id = var_54_1[2].id

			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_finish:SetActive(true)
		elseif self.equip_stage == 3 and var_54_1[3].status == 1 then
			local var_54_18 = var_0_15.find_object_by_id(var_54_1[3].id)

			self._equip_task_id = var_54_1[3].id

			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_finish:SetActive(true)
		elseif self.equip_stage == 4 and var_54_1[4].status == 1 then
			local var_54_19 = var_0_15.find_object_by_id(var_54_1[4].id)

			self._equip_task_id = var_54_1[4].id

			self._control.research_bureau_bg.right.equip_show.equip_bg.equip_finish:SetActive(true)
		end
	end

	function arg_1_0:updata_equip_show_state()
		self._control.research_bureau_bg.right.equip_show.equip_bg.equip_finish:SetActive(false)
	end

	function arg_1_0:updata_ship_task_state()
		if var_0_1:getInstance("select_member") then
			var_0_1:destroyInstance("select_member")
		end

		self:__init_stage_data()

		self._now_ship_info = {}

		self._control.research_bureau_bg.right.ship_show.ship_research:SetActive(true)

		local var_56_0 = var_0_8.find_object_by_id(self._now_ship_id)

		for iter_56_0, iter_56_1 in pairs((var_0_2:get_ship_task_info())) do
			if var_0_8.find_object_by_id(iter_56_1.id).num == var_56_0.num then
				var_0_10(self._now_ship_info, iter_56_1)
			end
		end

		self.__ship_task_list[1].ship_finish_img_1:SetActive(self._now_ship_info[1].status > 0)
		self.__ship_task_list[2].ship_finish_img_2:SetActive(self._now_ship_info[2].status > 0)
		self.__ship_task_list[3].ship_finish_img_3:SetActive(self._now_ship_info[3].status > 0)

		if #self._now_ship_info >= 4 then
			self.__ship_task_list[4].ship_finish_img_4:SetActive(self._now_ship_info[4].status > 0)
		end

		if #self._now_ship_info == 3 then
			self.__ship_task_list[4]:SetActive(false)
		end

		self:update_set_research_ship_task_info(self._now_ship_id)

		local var_56_1 = lx.ServerTime:getUtcTime()

		if self._research_ship_info.stage == 1 then
			self:__onClick_research_bureau_bg_right_ship_show_ship_research_1_select_btn_1()
			self._control.research_bureau_bg.right.ship_show.ship_research_1.select_btn_1:SetActive(true)
			self._control.research_bureau_bg.right.ship_show.ship_research_2.select_btn_2:SetActive(false)

			self._control.research_bureau_bg.right.ship_show.ship_research_1.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)
			self._control.research_bureau_bg.right.ship_show.ship_research_2.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.lock)
			self._control.research_bureau_bg.right.ship_show.ship_research_3.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.lock)
			self._control.research_bureau_bg.right.ship_show.ship_research_4.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.lock)
			self._control.research_bureau_bg.right.ship_show.ship_research_2.ship_research_image_2.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.lock)
			self._control.research_bureau_bg.right.ship_show.ship_research_3.ship_research_image_3.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.lock)
			self._control.research_bureau_bg.right.ship_show.ship_research_4.ship_research_image_4.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.lock)

			self._control.research_bureau_bg.right.ship_show.ship_research_3.select_btn_3:SetActive(false)
			self._control.research_bureau_bg.right.ship_show.ship_research_4.select_btn_4:SetActive(false)
		elseif self._research_ship_info.stage == 2 then
			self:__onClick_research_bureau_bg_right_ship_show_ship_research_2_select_btn_2()
			self._control.research_bureau_bg.right.ship_show.ship_research_1.select_btn_1:SetActive(true)
			self._control.research_bureau_bg.right.ship_show.ship_research_2.select_btn_2:SetActive(true)

			self._control.research_bureau_bg.right.ship_show.ship_research_1.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)
			self._control.research_bureau_bg.right.ship_show.ship_research_2.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)
			self._control.research_bureau_bg.right.ship_show.ship_research_3.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.lock)
			self._control.research_bureau_bg.right.ship_show.ship_research_4.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.lock)
			self._control.research_bureau_bg.right.ship_show.ship_research_1.ship_research_image_1.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.finish)
			self._control.research_bureau_bg.right.ship_show.ship_research_2.ship_research_image_2.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.ongoing)
			self._control.research_bureau_bg.right.ship_show.ship_research_3.ship_research_image_3.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.lock)

			self._control.research_bureau_bg.right.ship_show.ship_research_3.select_btn_3:SetActive(false)
			self._control.research_bureau_bg.right.ship_show.ship_research_4.select_btn_4:SetActive(false)
		elseif self._research_ship_info.stage == 3 then
			self:__onClick_research_bureau_bg_right_ship_show_ship_research_3_select_btn_3()
			self._control.research_bureau_bg.right.ship_show.ship_research_1.select_btn_1:SetActive(true)
			self._control.research_bureau_bg.right.ship_show.ship_research_2.select_btn_2:SetActive(true)
			self._control.research_bureau_bg.right.ship_show.ship_research_3.select_btn_3:SetActive(true)

			self._control.research_bureau_bg.right.ship_show.ship_research_1.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)
			self._control.research_bureau_bg.right.ship_show.ship_research_2.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)
			self._control.research_bureau_bg.right.ship_show.ship_research_3.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)
			self._control.research_bureau_bg.right.ship_show.ship_research_4.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.lock)
			self._control.research_bureau_bg.right.ship_show.ship_research_1.ship_research_image_1.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.finish)
			self._control.research_bureau_bg.right.ship_show.ship_research_2.ship_research_image_2.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.finish)
			self._control.research_bureau_bg.right.ship_show.ship_research_3.ship_research_image_3.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.finish)

			self._control.research_bureau_bg.right.ship_show.ship_research_4.select_btn_4:SetActive(false)
		elseif self._research_ship_info.stage == 4 then
			self:__onClick_research_bureau_bg_right_ship_show_ship_research_4_select_btn_4()
		end
	end

	function arg_1_0:__init_stage_data()
		for iter_57_0 = 1, 4 do
			self.__ship_task_time_img_list[iter_57_0].image.fillAmount = 0
			self.__ship_task_time_img_list_2[iter_57_0].image.fillAmount = 0
		end
	end

	function arg_1_0:set_click_info()
		local var_58_0 = lx.ServerTime:getUtcTime()
		local var_58_1 = self:get_ship_research_max_info(self._now_ship_id)
		local var_58_2 = var_0_8.find_object_by_id(var_58_1)

		for iter_58_0, iter_58_1 in ipairs((var_0_2:get_ship_task_info())) do
			if iter_58_1.id == var_58_1 then
				self._start_time = iter_58_1.complete_time + var_0_5.research_ship_time
			end
		end

		local var_58_3 = self._control.research_bureau_bg.right.ship_show

		if var_58_2.stage == 2 then
			var_58_3.ship_research_3.unlock_image_3.unlock_time_txt_3.text.text = var_0_9.secondsToTime(self._start_time - var_58_0)
		end

		if self._now_stage == 1 then
			if self._start_time - var_58_0 > 0 then
				var_58_3.ship_research_2.unlock_image_2:SetActive(true)

				for iter_58_2 = 1, 4 do
					if iter_58_2 == 2 then
						self.__ship_task_time_img_list_2[iter_58_2]:SetActive(true)
					else
						self.__ship_task_time_img_list_2[iter_58_2]:SetActive(false)
					end
				end

				var_58_3.ship_research_2.unlock_image_2.unlock_time_txt_2.text.text = var_0_9.secondsToTime(self._start_time - var_58_0)

				var_58_3.ship_research_3.select_btn_3:SetActive(false)
				var_58_3.ship_research_4.select_btn_4:SetActive(false)

				var_58_3.ship_research_1.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)

				if var_58_2.stage > self._now_stage and var_58_2.stage == 1 then
					var_58_3.ship_research_2.unlock_image_2:SetActive(false)
					var_58_3.ship_research_2.select_btn_2:SetActive(true)
					self.__ship_task_time_img_list_2[2]:SetActive(false)

					var_58_3.ship_research_2.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)
				elseif var_58_2.stage == 2 then
					var_58_3.ship_research_2.unlock_image_2:SetActive(false)
					var_58_3.ship_research_2.select_btn_2:SetActive(true)
					self.__ship_task_time_img_list_2[2]:SetActive(false)
					self.__ship_task_time_img_list_2[3]:SetActive(true)

					var_58_3.ship_research_2.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish_2)
				elseif var_58_2.stage == 3 then
					self.__ship_task_time_img_list_2[2]:SetActive(false)
					var_58_3.ship_research_2.unlock_image_2:SetActive(false)
					var_58_3.ship_research_2.unlock_image_2:SetActive(false)
					var_58_3.ship_research_3.unlock_image_3:SetActive(false)
					var_58_3.ship_research_3.select_btn_3:SetActive(true)
					self.__ship_task_time_img_list_2[3]:SetActive(false)

					self._now_ship_id = self._research_ship_all_task[3]
					var_58_3.ship_research_2.ship_research_image_2.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.finish)
					var_58_3.ship_research_3.ship_research_image_3.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.finish)
				else
					var_58_3.ship_research_2.ship_research_image_2.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.lock)
					var_58_3.ship_research_2.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish_2)
				end

				self:updata_equip_info()
			else
				self.__ship_task_time_img_list_2[2]:SetActive(false)

				for iter_58_3 = 1, 4 do
					self.__ship_task_time_img_list_2[iter_58_3]:SetActive(false)
				end

				var_58_3.ship_research_2.unlock_image_2:SetActive(false)

				var_58_3.ship_research_1.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)
				var_58_3.ship_research_2.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)

				self:updata_equip_info()

				local var_58_4 = self:get_ship_research_max_info()
				local var_58_5 = var_0_8.find_object_by_id(var_58_4)

				for iter_58_4, iter_58_5 in pairs((var_0_2:get_ship_task_info())) do
					var_58_3.ship_research_2.ship_research_image_2.image.sprite = (var_58_5.num == 1 and iter_58_5.id == var_58_4 + 1 and iter_58_5.status == 1 or var_58_5.num == 2 and iter_58_5.id == var_58_4 + 1 and iter_58_5.status == 1) and self:loadSprite(var_0_5.research_equip_task_image.finish) or self:loadSprite(var_0_5.research_equip_task_image.ongoing)
				end

				var_58_3.ship_research_2.select_btn_2:SetActive(true)

				self._now_ship_id = self._research_ship_all_task[2]

				if var_58_2.stage > self._now_stage and var_58_2.stage ~= 3 then
					var_58_3.ship_research_3.unlock_image_3:SetActive(false)
					var_58_3.ship_research_3.select_btn_3:SetActive(true)

					self._now_ship_id = self._research_ship_all_task[3]
					var_58_3.ship_research_2.ship_research_image_2.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.finish)
					var_58_3.ship_research_3.ship_research_image_3.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.ongoing)
				elseif var_58_2.stage == 3 then
					var_58_3.ship_research_3.unlock_image_3:SetActive(false)
					var_58_3.ship_research_3.select_btn_3:SetActive(true)

					self._now_ship_id = self._research_ship_all_task[3]
					var_58_3.ship_research_2.ship_research_image_2.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.finish)
					var_58_3.ship_research_3.ship_research_image_3.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.finish)
				end

				if var_0_2:get_come_in_nums() == 2 then
					var_0_2:req_ResearchBoatIdReq(self._now_ship_id)
				end

				self._do_not_to_research = false
			end
		elseif self._now_stage == 2 then
			if self._start_time - var_58_0 > 0 then
				self.__ship_task_time_img_list_2[3]:SetActive(true)

				for iter_58_6 = 1, 4 do
					if iter_58_6 == 3 then
						self.__ship_task_time_img_list_2[iter_58_6]:SetActive(true)
					else
						self.__ship_task_time_img_list_2[iter_58_6]:SetActive(false)
					end
				end

				if var_58_2.stage == 1 then
					-- block empty
				elseif var_58_2.stage == 2 then
					var_58_3.ship_research_3.unlock_image_3.unlock_time_txt_3.text.text = var_0_9.secondsToTime(self._start_time - var_58_0)

					var_58_3.ship_research_3.unlock_image_3:SetActive(true)
					var_58_3.ship_research_3.select_btn_3:SetActive(false)

					var_58_3.ship_research_2.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)
					var_58_3.ship_research_3.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish_2)

					var_58_3.ship_research_4.select_btn_4:SetActive(false)
				elseif var_58_2.stage == 3 then
					self.__ship_task_time_img_list_2[3]:SetActive(false)
				end

				self:updata_equip_info()
			else
				for iter_58_7 = 1, 4 do
					self.__ship_task_time_img_list_2[iter_58_7]:SetActive(false)
				end

				var_58_3.ship_research_3.unlock_image_3:SetActive(false)
				var_58_3.ship_research_1.select_btn_1:SetActive(true)

				var_58_3.ship_research_1.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)
				var_58_3.ship_research_2.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)
				var_58_3.ship_research_3.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)
				var_58_3.ship_research_2.ship_research_image_2.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.finish)
				var_58_3.ship_research_3.ship_research_image_3.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.ongoing)

				var_58_3.ship_research_2.select_btn_2:SetActive(true)
				var_58_3.ship_research_3.select_btn_3:SetActive(true)

				self._now_ship_id = self._research_ship_all_task[3]
				self._do_not_to_research = false

				if var_58_2.stage > self._now_stage then
					var_58_3.ship_research_3.unlock_image_3:SetActive(false)
					var_58_3.ship_research_3.select_btn_3:SetActive(true)

					var_58_3.ship_research_2.ship_research_image_2.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.finish)
					var_58_3.ship_research_3.ship_research_image_3.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.finish)
				end

				if var_0_2:get_come_in_nums() == 2 then
					var_0_2:req_ResearchBoatIdReq(self._now_ship_id)
				end

				self:updata_equip_info()
			end
		elseif self._now_stage == 3 then
			if self._start_time - var_58_0 > 0 then
				for iter_58_8 = 1, 4 do
					if iter_58_8 == 4 then
						self.__ship_task_time_img_list_2[iter_58_8]:SetActive(true)
					else
						self.__ship_task_time_img_list_2[iter_58_8]:SetActive(false)
					end
				end

				var_58_3.ship_research_3.unlock_image_3.unlock_time_txt_3.text.text = var_0_9.secondsToTime(self._start_time - var_58_0)
				var_58_3.ship_research_3.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)

				var_58_3.ship_research_4.unlock_image_4:SetActive(true)
				var_58_3.ship_research_4.select_btn_4:SetActive(false)
				self:updata_equip_info()
			else
				for iter_58_9 = 1, 4 do
					self.__ship_task_time_img_list_2[iter_58_9]:SetActive(false)
				end

				var_58_3.ship_research_4.unlock_image_4:SetActive(false)
				var_58_3.ship_research_1.select_btn_1:SetActive(true)
				var_58_3.ship_research_2.select_btn_2:SetActive(true)

				var_58_3.ship_research_1.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)
				var_58_3.ship_research_2.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)
				var_58_3.ship_research_3.image.sprite = self:loadSprite(var_0_5.research_ship_task_image.finish)

				var_58_3.ship_research_3.select_btn_3:SetActive(true)
				var_58_3.ship_research_4.select_btn_4:SetActive(true)

				if #self._research_ship_all_task >= 4 then
					self._now_ship_id = self._research_ship_all_task[4]

					self:updata_equip_info()
				end

				self._do_not_to_research = false
			end
		end
	end

	function arg_1_0:set_research_ship_all_stage(arg_59_1)
		self._research_ship_all_task = {}

		local var_59_0 = var_0_8.find_object_by_id(arg_59_1)

		for iter_59_0, iter_59_1 in pairs((var_0_2:get_ship_task_info())) do
			if var_59_0.num == var_0_8.find_object_by_id(iter_59_1.id).num then
				var_0_10(self._research_ship_all_task, iter_59_1.id)
			end
		end
	end

	function arg_1_0:now_research_id(arg_60_1)
		local var_60_0 = var_0_8.find_object_by_id(arg_60_1)

		self.__now_ship_all_id = {}

		for iter_60_0, iter_60_1 in pairs((var_0_2:get_ship_task_info())) do
			if var_60_0.num == var_0_8.find_object_by_id(iter_60_1.id).num then
				var_0_10(self.__now_ship_all_id, iter_60_1)
			end
		end
	end

	function arg_1_0:_update_now_stage_info()
		for iter_61_0, iter_61_1 in pairs((var_0_2:get_ship_task_info())) do
			for iter_61_2, iter_61_3 in pairs(self.__now_ship_all_id) do
				if iter_61_3.id == iter_61_1.id then
					local var_61_1 = var_0_8.find_object_by_id(iter_61_1.id)

					if var_61_1.task1.num < iter_61_1.task_num_1 then
						iter_61_1.task_num_1 = var_61_1.task1.num
					end

					if var_61_1.task2.num < iter_61_1.task_num_2 then
						iter_61_1.task_num_2 = var_61_1.task2.num
					end

					if var_61_1.task3.num < iter_61_1.task_num_3 then
						iter_61_1.task_num_3 = var_61_1.task3.num
					end

					self.__ship_task_time_img_list[iter_61_2].image.fillAmount = (iter_61_1.task_num_1 / var_61_1.task1.num + iter_61_1.task_num_2 / var_61_1.task2.num + iter_61_1.task_num_3 / var_61_1.task3.num) / 3

					if (iter_61_1.task_num_1 / var_61_1.task1.num + iter_61_1.task_num_2 / var_61_1.task2.num + iter_61_1.task_num_3 / var_61_1.task3.num) / 3 == 1 then
						self.__ship_task_finish_list[iter_61_2]:SetActive(true)

						self._control.research_bureau_bg.right.ship_show.ship_research_2.ship_research_image_2.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.finish)

						if iter_61_2 == 1 then
							self._control.research_bureau_bg.right.ship_show.ship_research_1.ship_research_image_1.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.finish)
						end

						if iter_61_2 == 2 then
							self._control.research_bureau_bg.right.ship_show.ship_research_2.ship_research_image_2.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.finish)
						end

						if iter_61_2 == 3 then
							self._control.research_bureau_bg.right.ship_show.ship_research_3.ship_research_image_3.image.sprite = self:loadSprite(var_0_5.research_equip_task_image.finish)
						end
					end
				end
			end
		end
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0:_play_into_se(arg_63_1)
		self:playSE(arg_63_1, false)
	end

	function arg_1_0.__initia_lize(arg_64_0)
		arg_64_0.score_1 = 0
		arg_64_0.score_2 = 0
		arg_64_0.score_3 = 0
		arg_64_0.score_4 = 0
		arg_64_0.score_5 = 0
		arg_64_0.blueprint_1 = 0
		arg_64_0.blueprint_2 = 0
		arg_64_0.blueprint_3 = 0
		arg_64_0.equip_drawing_1 = 0
		arg_64_0.ship_build_1 = 0
		arg_64_0._sum_score_num = 0
		arg_64_0._sum_blueprint_num = 0
		arg_64_0._sum_equip_drawing_num = 0
		arg_64_0._sum_ship_build_num = 0
		arg_64_0._sum_score_info = {}
		arg_64_0._sum_equip_drawing_info = {}
		arg_64_0._sum_blueprint_info = {}
		arg_64_0._sum_ship_build_info = {}
		arg_64_0._already_select_num = 0
		arg_64_0._equip_task_id = 1
		arg_64_0._is_open_select_member = false
		arg_64_0._already_select_equip_num = 0
		arg_64_0._do_not_to_research = false
		arg_64_0._sum_item_info = {}
		arg_64_0._sum_item_num = 0
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_65_0)
	local var_65_0 = var_0_1:class("research_development")

	var_65_0:__initia_lize()

	var_65_0._equie_info = {}
	var_65_0._now_equip_id = 1
	var_65_0._research_ship_info = {}
	var_65_0.score_1 = 0
	var_65_0.score_2 = 0
	var_65_0.score_3 = 0
	var_65_0.score_4 = 0
	var_65_0.score_5 = 0
	var_65_0.blueprint_1 = 0
	var_65_0.blueprint_2 = 0
	var_65_0.blueprint_3 = 0
	var_65_0.equip_drawing_1 = 0
	var_65_0.ship_build_1 = 0
	var_65_0._sum_score_num = 0
	var_65_0._sum_blueprint_num = 0
	var_65_0._sum_equip_drawing_num = 0
	var_65_0._sum_score_info = {}
	var_65_0._sum_blueprint_info = {}
	var_65_0._sum_equip_drawing_info = {}
	var_65_0._already_select_num = 0
	var_65_0.start_type = 1
	var_65_0.equip_stage = 1
	var_65_0._equip_task_id = 1
	var_65_0._ship_opean_or_false = true
	var_65_0._do_not_to_research = false
	var_65_0._now_stage = nil
	var_65_0._start_time = 1
	var_65_0._click_stage = 1
	var_65_0.research_stage_1_y = 0
	var_65_0.research_stage_1_x = 0
	var_65_0.__now_ship_all_id = {}
	var_65_0._equip_conf_list = {}
	var_65_0._is_open_select_member = false
	var_65_0.item_info = false
	var_65_0._sum_item_info = {}
	var_65_0._sum_item_num = 0

	return var_65_0
end

return var_0_0
