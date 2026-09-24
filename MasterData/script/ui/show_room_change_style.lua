local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_7 = gameconfig.item_config

gamecore.UILoader:define("show_room_change_style", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)

		self._now_index = arg_2_1
	end

	function arg_1_0:play_in_animation(arg_3_1)
		self._control.move_tween.uITweenSequence:Play(function()
			if arg_3_1 then
				arg_3_1()
			end
		end)
	end

	function arg_1_0:play_out_animation(arg_5_1)
		self._control.move_tween.uITweenSequence:PlayReverse(function()
			if arg_5_1 then
				arg_5_1()
			end
		end)
	end

	function arg_1_0:set_showroom_by_style(arg_7_1)
		self._control.change_style_framework.use_btn_lock:SetActive(false)
		self._control.change_style_framework.use_btn:SetActive(true)

		if arg_7_1 == 10146 then
			self._control.change_style_framework.content.style_default:GetComponent("Toggle").isOn = true
			self._control.change_style_framework.content.style_default.text.text.text = string.format("<color=#%s>%s</color>", "ffffff", var_0_2:getNowLang("styledesc0"))
			self._control.change_style_framework.content.style_1.text.text.text = string.format("<color=#%s>%s</color>", "666666", var_0_2:getNowLang("captainroomstyle2"))
		end

		if arg_7_1 == 10246 then
			self._control.change_style_framework.use_btn_lock:SetActive(false)
			self._control.change_style_framework.use_btn:SetActive(true)

			self._control.change_style_framework.content.style_1:GetComponent("Toggle").isOn = true
			self._control.change_style_framework.content.style_default.text.text.text = string.format("<color=#%s>%s</color>", "666666", var_0_2:getNowLang("styledesc0"))
			self._control.change_style_framework.content.style_1.text.text.text = string.format("<color=#%s>%s</color>", "ffffff", var_0_2:getNowLang("captainroomstyle2"))
		end

		self._now_selected_style = arg_7_1
		self._control.change_style_framework.style_bg.image.sprite = self:loadSprite(var_0_4.show_room_style_icon[arg_7_1])

		local var_7_0 = app:getSystem():getChannel()

		self._control.change_style_framework.style_bg.tip_1.text.text = var_0_7.find_object_by_cid(arg_7_1).desc

		if #self._is_have_style == 1 then
			self._control.change_style_framework.use_btn_lock:SetActive(true)
			self._control.change_style_framework.use_btn:SetActive(false)

			self._control.change_style_framework.style_bg.tip_1.text.text = var_0_7.find_object_by_cid(arg_7_1).drop_desc
		end
	end

	function arg_1_0.use_showroom_by_style(arg_8_0, arg_8_1)
		var_0_3:getInstance("show_room"):set_user_style_data(arg_8_1)
		var_0_1:req_ChangeBoxroomStyleReq(arg_8_1)
	end

	function arg_1_0:__init_panel(arg_9_1)
		self:play_in_animation()

		self._is_have_style = var_0_1:get_player_show_room_style_data()
		self._control.change_style_framework.content.style_default:GetComponent("Toggle").isOn = true

		self:set_showroom_by_style(arg_9_1)

		self._control.change_style_framework.changestyle.text.text = var_0_2:getNowLang("changestyle")
		self._control.change_style_framework.styleselect.text.text = var_0_2:getNowLang("styleselect")
		self._control.change_style_framework.use_btn.use.text.text = var_0_2:getNowLang("use")
	end

	function arg_1_0:_play_into_se(arg_10_1)
		self:playSE(arg_10_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_11_0)
	local var_11_0 = var_0_3:class("show_room_change_style")

	var_11_0._is_already_init = false
	var_11_0._now_selected_style = 0
	var_11_0._is_have_style = {}
	var_11_0._now_index = nil

	return var_11_0
end

return var_0_0
