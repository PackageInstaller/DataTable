local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = gamecore.user
local var_0_3 = gamecore.Language
local var_0_5 = gamecore.prompt

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bottom_refresh_btn()
		self._control.bottom.refresh_btn.button.interactable = false

		if self._is_nf then
			var_0_2:req_MistRefreshChooseReq()
		else
			var_0_2:req_SixthRefreshChooseReq()
		end
	end

	function arg_1_0:__onClick_bottom_confirm_btn()
		local var_3_0 = {}
		local var_3_1 = false
		local var_3_2 = var_0_2:get_mist_combat_info()
		local var_3_3 = var_0_2:get_sixth_combat_info()

		for iter_3_0, iter_3_1 in ipairs(self._ship_and_buff_list) do
			if self._is_nf then
				if var_3_2.ship == nil or #var_3_2.ship == 0 then
					if iter_3_1._select_this and iter_3_1._is_ship then
						var_3_1 = true

						break
					end
				else
					var_3_1 = true
				end
			elseif var_3_3.ship == nil or #var_3_3.ship == 0 then
				if iter_3_1._select_this and iter_3_1._is_ship then
					var_3_1 = true

					break
				end
			else
				var_3_1 = true
			end
		end

		if not var_3_1 then
			var_0_5:show(var_0_3:getNowLang("sixth_first_enter"))

			return
		end

		for iter_3_2, iter_3_3 in ipairs(self._ship_and_buff_list) do
			if iter_3_3._select_this then
				var_0_1(var_3_0, iter_3_3._data.idx)
			end

			iter_3_3:__play_animation()
		end

		self:__play_fade_out_animation()

		if #var_3_0 > 0 then
			if self._is_nf then
				var_0_2:req_MistChooseReq(var_3_0)
			else
				var_0_2:req_SixthChooseReq(var_3_0)
			end
		end

		if self._is_nf then
			var_0_2:set_mist_open_sixth_select_and_buff("false")

			self._already_init = false
		else
			var_0_2:set_open_sixth_select_and_buff("false")

			self._already_init = false
		end
	end

	function arg_1_0:__onClick_bg()
		if self._control.skill_content.activeSelf then
			self:setVisible(false)

			for iter_4_0 = 1, self._control.skill_content.transform.childCount do
				self._control.skill_content.transform:GetChild(iter_4_0 - 1).gameObject:SetActive(false)
			end
		end
	end

	function arg_1_0:__onClick_bg_image()
		if self._control.skill_content.activeSelf then
			self:setVisible(false)

			for iter_5_0 = 1, self._control.skill_content.transform.childCount do
				self._control.skill_content.transform:GetChild(iter_5_0 - 1).gameObject:SetActive(false)
			end
		end
	end
end

function var_0_0.extend_obj(arg_6_0)
	return
end

return var_0_0
