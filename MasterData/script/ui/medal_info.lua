local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.medal_config
local var_0_6 = string.format
local var_0_7 = table.sort
local var_0_9 = lx.json_decode
local var_0_10 = gamecore.Language

gamecore.UILoader:define("medal_info", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		self:setVisible(true)
		self:set_medal_info(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		self:play_in_out_animation(true)
	end

	function arg_1_0.get_txt(arg_3_0, arg_3_1)
		return (string.gsub(arg_3_1, "%^C[^%^]+", function(arg_4_0)
			return string.format("<color=#%s>%s</color>", string.sub(arg_4_0, 3, 10), (string.sub(arg_4_0, 19, #arg_4_0)))
		end))
	end

	function arg_1_0.sort_rule(arg_5_0, arg_5_1)
		var_0_7(arg_5_1, function(arg_6_0, arg_6_1)
			return arg_6_0.id < arg_6_1.id
		end)

		return arg_5_1
	end

	function arg_1_0:set_medal_info(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
		self._control.bg_container.progress:SetActive(true)
		self._control.cover:SetActive(false)

		local var_7_4 = var_0_5.find_object_by_id(arg_7_1)
		local var_7_5 = var_0_1:get_all_medal_by_id(arg_7_1)
		local var_7_6 = self:sort_rule(var_7_4.sub_title)
		local var_7_7 = self:sort_rule(var_7_4.c_desc_1)
		local var_7_8 = self:sort_rule(var_7_4.c_desc_2)
		local var_7_9 = self:sort_rule(var_7_4.condition)

		self._control.bg_container.medal_icon_bg.medal_icon.image.sprite = self:loadSprite(var_0_6(var_0_4.medal_icon[1], arg_7_1, arg_7_2))
		self._control.bg_container.medal_info_text.text.text = var_0_10:getNowLang("medaltitle")
		self._control.bg_container.medal_name_text.text.text = var_7_4.title
		self._control.bg_container.describe_condition.text.text = var_0_10:getNowLang("medaltip1")
		self._control.bg_container.describe_condition.condition_text.text.text = self:get_txt(var_7_4.c_desc_1[arg_7_2].value)
		self._control.bg_container.describe_medal.text.text = var_0_10:getNowLang("medaltip2")
		self._control.bg_container.describe_medal.describe_text.text.text = var_0_10:convert_rich_text(var_0_9(var_7_4.introduce_1)["1"])
		lv_btn_list = {
			self._control.bg_container.btn.lv_btn_1,
			self._control.bg_container.btn.lv_btn_2,
			self._control.bg_container.btn.lv_btn_3,
			self._control.bg_container.btn.lv_btn_4,
			self._control.bg_container.btn.lv_btn_5,
			self._control.bg_container.btn.lv_btn_6
		}

		for iter_7_0 = 1, #var_7_4.sub_title do
			lv_btn_list[iter_7_0].lv_text.text.text = var_7_6[iter_7_0].value

			if not var_7_5[iter_7_0 - 1] then
				lv_btn_list[iter_7_0].lv_text.text.text = "--"
			end

			if iter_7_0 == 1 then
				lv_btn_list[iter_7_0].lv_text.text.text = var_7_6[iter_7_0].value
			end
		end

		if arg_7_4 then
			for iter_7_1 = 1, #var_7_4.sub_title do
				lv_btn_list[iter_7_1].lv_text.text.text = "--"

				if iter_7_1 <= arg_7_2 then
					lv_btn_list[iter_7_1].lv_text.text.text = var_7_6[iter_7_1].value
				end
			end
		end

		self._control.bg_container.progress.finish_text:SetActive(false)
		self._control.bg_container.progress.progress_text:SetActive(true)

		self._control.bg_container.progress.progress_text.text.text = var_0_10:getNowLang("medalgainexp") .. tostring(arg_7_3) .. " / " .. var_7_4.condition[arg_7_2].value
		self._control.bg_container.progress.progress_text.medal_progress:GetComponent("Slider").value = arg_7_3 / var_7_4.condition[arg_7_2].value

		for iter_7_2 = 1, #var_7_5 do
			if var_7_5[iter_7_2].level == arg_7_2 then
				self._control.bg_container.progress.finish_text:SetActive(true)
				self._control.bg_container.progress.progress_text:SetActive(false)

				self._control.bg_container.progress.finish_text.text.text = lx.split(lx.Time:getDateString(var_7_5[iter_7_2].time), " ")[1] .. var_0_10:getNowLang("logget")
			end
		end

		for iter_7_3 = 1, var_7_4.rls_level do
			lv_btn_list[iter_7_3].button.onClick:RemoveAllListeners()
			lv_btn_list[iter_7_3].button.onClick:AddListener(function()
				self:set_medal_info(var_7_4.id, iter_7_3, arg_7_3)
			end)
		end
	end

	function arg_1_0.init_medal_info(arg_9_0)
		for iter_9_0 = 1, 6 do
			lv_btn_list[iter_9_0].lv_text.text.text = "--"

			lv_btn_list[iter_9_0].button.onClick:RemoveAllListeners()
		end
	end

	function arg_1_0:__init_panel(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
		self:set_medal_info(arg_10_1, arg_10_2, arg_10_3, arg_10_4)

		self._is_already_init = true
	end

	function arg_1_0:_play_into_se(arg_11_1)
		self:playSE(arg_11_1, false)
	end

	function arg_1_0:play_in_out_animation(arg_12_1, arg_12_2)
		if arg_12_1 then
			self._control.bg_shadw.uITweenSequence:Play(function()
				if arg_12_2 then
					arg_12_2()
				end
			end)
		else
			self._control.bg_shadw.uITweenSequence:PlayReverse(function()
				if arg_12_2 then
					arg_12_2()
				end
			end)
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_15_0)
	local var_15_0 = var_0_3:class("medal_info")

	var_15_0._is_already_init = false
	var_15_0._medal_id = nil

	return var_15_0
end

return var_0_0
