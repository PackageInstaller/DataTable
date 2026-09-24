local var_0_0 = {}
local var_0_1 = gamecore.prompt
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.user
local var_0_6 = gameconfig.tactics_config
local var_0_7 = DG.Tweening.DOTween

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_baseboard_return_btn()
		self._is_select_ship = false
		self._ship_data = nil

		self:setVisible(false)
	end

	function arg_1_0:__onClick_select_ship()
		self:setVisible(false)

		local var_3_0 = var_0_3:getInstance("school")

		var_3_0._control.mask_cover_image:SetActive(true)

		local var_3_1 = self:autoKillDOTween(var_0_7.Sequence())

		var_3_1:AppendInterval(0.3)
		var_3_1:AppendCallback(function()
			var_3_0._control.mask_cover_image:SetActive(false)
		end)
		var_3_1:Play()

		local var_3_2 = var_0_3:getInstance("select_member")

		if not var_3_2 then
			var_3_2 = var_0_3:createInstance("select_member")
			var_3_2.content_pos = nil
		end

		var_3_2:show_by_type(var_0_4.enter_select_member_type.college, (var_0_5:get_total_study_student_info()))
	end

	function arg_1_0:__show_item_detail_info(arg_5_1)
		if self._ship_data == nil then
			var_0_1:show(var_0_2:getNowLang("selectshipfirst"))

			return
		end

		if self:__get_study_level_limit_info(arg_5_1) then
			local var_5_0 = arg_5_1 <= 3 and self._attack_tactics_table[arg_5_1] or arg_5_1 <= 6 and self._defense_tactics_table[arg_5_1 - 3] or self._special_tactics_table[arg_5_1 - 6]
			local var_5_1
			local var_5_2 = false

			if self._ship_data.all_tactics ~= nil and #self._ship_data.all_tactics ~= 0 then
				for iter_5_0, iter_5_1 in pairs(self._ship_data.all_tactics) do
					local var_5_3 = var_0_6.find_object_by_cid(iter_5_1.id) or var_0_6.find_object_by_cid(iter_5_1.cid)

					if var_5_3 and var_5_0.tactics_id == var_5_3.tactics_id then
						var_5_2 = true
						var_5_0 = var_5_3
						var_5_1 = iter_5_1
						var_5_1.sid = self._ship_data.id
						var_5_1.cid = var_5_0.cid

						break
					end
				end
			end

			if not var_5_2 then
				var_5_1 = {
					exp = 0,
					cid = var_5_0.cid,
					sid = self._ship_data.id
				}
			end

			if not self._is_select_ship then
				var_0_1:show(var_0_2:getNowLang("selectshipfirst"))
			elseif not self._tactics_item_panel[arg_5_1].control.select.activeSelf then
				var_0_3:createInstance("class_info_view"):show(var_5_1, "selectshipfirst")
			end
		end
	end

	function arg_1_0:__get_study_level_limit_info(arg_6_1)
		local var_6_0 = true

		if arg_6_1 == 1 or arg_6_1 == 2 or arg_6_1 == 3 then
			if self._level_limit_prompt_list[1].activeSelf then
				var_6_0 = false
			end
		elseif arg_6_1 == 4 or arg_6_1 == 5 or arg_6_1 == 6 then
			if self._level_limit_prompt_list[2].activeSelf then
				var_6_0 = false
			end
		elseif (arg_6_1 == 7 or arg_6_1 == 8 or arg_6_1 == 9) and self._level_limit_prompt_list[3].activeSelf then
			var_6_0 = false
		end

		return var_6_0
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
