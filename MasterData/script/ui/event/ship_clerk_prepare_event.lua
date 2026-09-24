local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.user
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.prompt
local var_0_6 = DG.Tweening.DOTween
local var_0_7 = lx.UserData

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_top_widget_return_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.back))
		self:setVisible(false)

		local var_2_0 = var_0_1:getInstance("home")

		if var_2_0 then
			var_2_0:setVisible(true)
			var_2_0:show()
			var_2_0:into_home_bgm()
		else
			local var_2_1 = var_0_1:creatInstance("home")

			var_2_1:show()
			var_2_1:into_home_bgm()
		end
	end

	function arg_1_0:__onScaleButtonClick_top_widget_secretary_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
		self._control.bg_2:SetActive(true)
		self._control.useragreement_msgbox:SetActive(true)
	end

	function arg_1_0:__onClick_right_list_broke_close()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))

		if self._middle_broken_flag == 0 then
			var_0_2:req_ChangeMiddleBrokenReq(1)
		else
			var_0_2:req_ChangeMiddleBrokenReq(0)
		end
	end

	function arg_1_0:__onClick_right_list_circulation()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))

		if self._rand_secretary_flag == 0 then
			var_0_2:req_ChangeRandSecretaryReq(1)
		else
			var_0_2:req_ChangeRandSecretaryReq(0)
		end
	end

	function arg_1_0:__onClick_right_list_resert_btn()
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.open))
		var_0_1:createInstance("msgbox"):show(var_0_4:getNowLang("secretary_reset"), function()
			var_0_2:req_ChangeSecretaryDataReq({
				lx.clone_table(var_0_2:get_team_all_data())[1][1].members[1]
			})
			var_0_5:show(var_0_4:getNowLang("resetsecrataryok"))
		end, nil, (var_0_4:getNowLang("secretary_title_1")))
	end

	function arg_1_0:__onClick_useragreement_msgbox_btn_back_back()
		self._control.useragreement_msgbox:SetActive(false)
		self._control.bg_2:SetActive(false)
	end

	function arg_1_0:__onClick_left_list_left_main_left_main_bg_all_layer_item_btn()
		local var_9_0 = var_0_2:get_secretary_info().members

		self._control.bg_2:SetActive(true)
		self:setVisible(false)

		local var_9_1 = var_0_1:getInstance("select_member")
		local var_9_2 = self:autoKillDOTween(var_0_6.Sequence())

		local function var_9_3()
			self._control.bg_2:SetActive(false)
		end

		if var_9_1 then
			var_9_1:show_by_type(var_0_3.enter_select_member_type.secretary_info_ship, var_9_0)
		else
			var_0_1:createInstance("select_member"):show_by_type(var_0_3.enter_select_member_type.secretary_info_ship, var_9_0)
		end

		var_9_2:AppendInterval(0.1)
		var_9_2:AppendCallback(var_9_3)
		var_9_2:Play()
	end

	function arg_1_0:__onLongClick_left_list_left_main_left_main_bg_all_layer_item_btn()
		local var_11_0 = tonumber(var_0_7:getKeyData("is_secretary_info_id"))

		if var_11_0 and var_11_0 > 0 and var_11_0 ~= self._data.id then
			var_0_7:setKeyData("is_secretary_info_id", self._data.id)
			self:_set_mian_secretary_list()
			var_0_5:show(var_0_4:getNowLang("secretary_set"))
			self._control.select_bg:SetActive(true)
		end
	end
end

function var_0_0.extend_obj(arg_12_0)
	return
end

return var_0_0
