local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_6 = string.format
local var_0_7 = table.insert
local var_0_9 = gameconfig.support_config
local var_0_10 = lx.clone_table
local var_0_11 = gamecore.util_func
local var_0_12 = table.sort

gamecore.UILoader:define("supportlist", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0.updata_data(arg_3_0)
		local var_3_0, var_3_1, var_3_2 = var_0_3:get_support_notify()

		arg_3_0._support_data = var_0_9.get_sequence()
	end

	function arg_1_0:__onVisible(arg_4_1)
		if not arg_4_1 then
			return
		end

		self:updata_data()
		self:__init_panel()

		self._already_init = true
	end

	function arg_1_0:show()
		self:setVisible(true)
	end

	function arg_1_0:__init_panel()
		self._control.cardintroduce.mainintroduce.btn.btn_text.text.text = var_0_1:get("上阵")
		self._copy_data = var_0_10(self._support_data)

		self:__sort_copy_data()
		self:__init_support_list()
		self:__update_content()
	end

	function arg_1_0:__sort_copy_data()
		local var_7_0, var_7_1, var_7_2 = var_0_3:get_support_notify()
		local var_7_3 = {}
		local var_7_4 = {}
		local var_7_5 = {}

		for iter_7_0, iter_7_1 in pairs(self._copy_data) do
			if var_7_0 ~= iter_7_1.id then
				if var_7_2 >= iter_7_1.need_achievement then
					var_0_7(var_7_4, iter_7_1)
				else
					var_0_7(var_7_3, iter_7_1)
				end
			end
		end

		var_0_12(var_7_4, function(arg_8_0, arg_8_1)
			if arg_8_0.quality ~= arg_8_1.quality then
				return arg_8_0.quality > arg_8_1.quality
			else
				return arg_8_0.id < arg_8_1.id
			end
		end)
		var_0_12(var_7_3, function(arg_9_0, arg_9_1)
			if arg_9_0.need_achievement ~= arg_9_1.need_achievement then
				return arg_9_0.need_achievement < arg_9_1.need_achievement
			end
		end)

		for iter_7_2, iter_7_3 in pairs(self._copy_data) do
			if not var_7_0 then
				if iter_7_2 == var_0_9.find_object_by_sequence_index(1).id then
					var_0_7(var_7_5, iter_7_3)
				end
			elseif var_7_0 == iter_7_3.id then
				var_0_7(var_7_5, iter_7_3)
			end
		end

		for iter_7_4, iter_7_5 in pairs(var_7_4) do
			var_0_7(var_7_5, iter_7_5)
		end

		for iter_7_6, iter_7_7 in pairs(var_7_3) do
			var_0_7(var_7_5, iter_7_7)
		end

		self._copy_data = var_7_5
		var_7_0 = var_7_0 or var_0_9.find_object_by_sequence_index(1).id

		for iter_7_8, iter_7_9 in pairs(self._copy_data) do
			if var_7_0 and iter_7_9.id == var_7_0 then
				iter_7_9.select_status = true

				var_0_3:req_ReadRankSupportReq(iter_7_9.id)
				self:__update_left_panel(iter_7_8)
			else
				iter_7_9.select_status = false
			end
		end
	end

	function arg_1_0:__update_left_panel(arg_10_1)
		self._cur_click_index = arg_10_1
		self._support_config = self._copy_data[self._cur_click_index]
		self._control.cardintroduce.bg.image.sprite = self:loadSprite(var_0_6(var_0_5.l_card_bg, self._support_config.quality))
		self._control.cardintroduce.unknow.image.sprite = self:loadSprite(var_0_6(var_0_5.support_icon_list.support_l_icon, self._support_config.id))
		self._control.cardintroduce.mainintroduce.infoname.text.text = self._support_config.title

		local var_10_0, var_10_1, var_10_2 = var_0_3:get_support_notify()

		if var_10_2 >= self._support_config.need_achievement then
			self._control.cardintroduce.mainintroduce.btn.button.interactable = true
			self._control.cardintroduce.mainintroduce.cardcontent.text.text = var_0_11.convert_rich_text(self._support_config.effect_desc2)
			self._control.cardintroduce.mainintroduce.btn.image.sprite = self:loadSprite(var_0_5.common_icon.common_btn_bg_08)
			self._support_up = not not (var_10_0 and var_10_0 == self._support_config.id)

			if self._support_up then
				self._control.cardintroduce.mainintroduce.btn.btn_text.text.text = var_0_1:getNowLang("ui_support_card_status_3") or var_0_1:getNowLang("ui_support_card_status_1")
			end

			self._control.cardintroduce.mainintroduce.btn.btn_text.text.color = Color.New(0.3176470588235294, 0.3176470588235294, 0.3176470588235294)
		else
			self._control.cardintroduce.mainintroduce.btn.button.interactable = false
			self._control.cardintroduce.mainintroduce.cardcontent.text.text = var_0_11.convert_rich_text(self._support_config.unlock_desc)
			self._control.cardintroduce.mainintroduce.btn.image.sprite = self:loadSprite(var_0_5.common_icon.common_btn_bg_10)
			self._support_up = false
			self._control.cardintroduce.mainintroduce.btn.btn_text.text.text = var_0_1:getNowLang("ui_support_card_status_0")
			self._control.cardintroduce.mainintroduce.btn.btn_text.text.color = Color.New(1, 1, 1)
		end
	end

	function arg_1_0:__update_panel_info(arg_11_1)
		if not arg_11_1 then
			self:__sort_copy_data(arg_11_1)
		end

		self:__update_left_panel(self._cur_click_index)
		self:__update_content()
	end

	function arg_1_0:__init_support_list()
		if self._already_init then
			return
		end

		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.cardintroduce.allcards.mainlist_maybe.scrollview.viewport.content.endlessScrollView, self._control.cardintroduce.allcards.mainlist_maybe.scrollview.viewport.content, "single_supportcell", "supportlist", true)

		self._reusable_cell:init()
	end

	function arg_1_0:__update_content()
		self:__update_reusable_cell()
	end

	function arg_1_0:__update_reusable_cell()
		self._reusable_cell:set_data(self._copy_data)

		function self._reusable_cell:_set_func(arg_15_1)
			self:show(self._copy_data[arg_15_1 + 1], arg_15_1 + 1)
		end
	end

	function arg_1_0:__close_select_bg()
		for iter_16_0, iter_16_1 in pairs(self._copy_data) do
			iter_16_1.select_status = false
		end

		self:__update_reusable_cell()
	end

	function arg_1_0:_play_into_se(arg_17_1)
		self:playSE(arg_17_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_18_0)
	local var_18_0 = var_0_2:class("supportlist")

	var_18_0._already_init = false
	var_18_0._supporlist_table = {}
	var_18_0._support_up = false
	var_18_0._support_config = {}
	var_18_0._cur_click_index = 1

	return var_18_0
end

return var_0_0
