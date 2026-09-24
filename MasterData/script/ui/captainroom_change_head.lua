local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.user
local var_0_6 = gameconfig.chat_head_config
local var_0_7 = table.sort
local var_0_8 = string.sub
local var_0_9
local var_0_10

gamecore.UILoader:define("captainroom_change_head", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0.show_head_layer(arg_4_0, arg_4_1)
		var_0_3:play_in_out_animation(var_0_9, arg_4_1, function()
			if not arg_4_1 then
				arg_4_0._control.bg:SetActive(false)
				arg_4_0:setVisible(false)
			end
		end)
	end

	function arg_1_0:__update_cell()
		local var_6_0 = {}
		local var_6_1 = var_0_4:get_captainroom_head()
		local var_6_2, var_6_3 = var_0_6.get_sequence()

		for iter_6_0, iter_6_1 in ipairs(var_6_2) do
			if iter_6_1.get_type == 0 then
				table.insert(var_6_0, iter_6_1.cid)
			end
		end

		self._reusable_cell:set_data(var_0_10)

		function self._reusable_cell:_set_func(arg_7_1)
			local var_7_0 = var_0_10[arg_7_1 + 1]
			local var_7_1 = false

			for iter_7_0, iter_7_1 in pairs(var_6_1) do
				if iter_7_1 == var_7_0.cid then
					var_7_1 = true
				end
			end

			for iter_7_2, iter_7_3 in pairs(var_6_0) do
				if iter_7_3 == var_7_0.cid then
					var_7_1 = true
				end
			end

			self.icon.image.sprite = self:loadSprite(var_0_3:get_format_url(var_0_3.captainroom_head, var_7_0.icon))

			if not var_7_1 then
				self.icon.image.material = self:loadMaterial(var_0_3.common_icon.icon_gray_material)
			end

			local var_7_3 = var_0_4:get_use_info_data()

			self.icon_select:SetActive(var_7_3.chat_head == var_7_0.cid)

			if var_7_3.chat_head == var_7_0.cid then
				self._now_click_icon = self
			end

			self.lock:SetActive(not var_7_1)
			self.bg_line2:SetActive(arg_7_1 % 4 == 0)
			self.icon.button.onClick:RemoveAllListeners()
			self.icon.button.onClick:AddListener(function()
				self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))

				self._now_click_icon_cid = var_7_0.cid
				self._old_click_icon = self._now_click_icon
				self._now_click_icon = self

				if self._old_click_icon then
					self._old_click_icon.icon_select:SetActive(false)
				end

				self._now_click_icon.icon_select:SetActive(true)

				if var_7_1 then
					var_0_4:req_ChangeChatHeadReq(var_7_0.cid)
				else
					self._control.bg.icon_tip.content.text.text = var_0_8(var_7_0.get_desc, 19, -1)

					self._control.bg.icon_tip:SetActive(true)
					self._control.bg.icon_tip.content.nonBreakingSpaceTextComponent:SetMyText()
				end
			end)
		end
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_constant()
			self:__update_cell()
		end

		self:show_head_layer(true)

		self._is_already_init = true

		if var_0_1:getInstance("user_info") then
			self._panel.transform:GetComponent("Canvas").sortingOrder = 1001
		end
	end

	function arg_1_0:__init_language()
		self._control.bg.bg_container.title.text.text = var_0_2:getNowLang("usericontitle")
		self._control.bg.icon_tip.title.text.text = var_0_2:getNowLang("usericontipcondition")
	end

	function arg_1_0:__init_constant()
		var_0_9 = self._control.bg.uITweenSequence

		if not self._reusable_cell then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.bg.scrollview.viewport.content.endlessScrollView, self._control.bg.scrollview.viewport.content, "single_user_icon", "captainroom_change_head")

			self._reusable_cell:init()
		end

		var_0_10 = var_0_6.get_sequence()

		var_0_7(var_0_10, function(arg_12_0, arg_12_1)
			return arg_12_0.cid < arg_12_1.cid
		end)
	end

	function arg_1_0:_play_into_se(arg_13_1)
		self:playSE(arg_13_1, false)
	end

	function arg_1_0.__onReset(arg_14_0)
		arg_14_0._is_already_init = false
		arg_14_0._now_click_icon_cid = nil
		arg_14_0._old_click_icon = nil
		arg_14_0._now_click_icon = nil
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_15_0)
	local var_15_0 = var_0_1:class("captainroom_change_head")

	var_15_0._is_already_init = false
	var_15_0._reusable_cell = nil
	var_15_0._now_click_icon_cid = nil
	var_15_0._old_click_icon = nil
	var_15_0._now_click_icon = nil

	return var_15_0
end

return var_0_0
