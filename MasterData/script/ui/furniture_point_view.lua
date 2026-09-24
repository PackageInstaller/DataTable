local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = string.format
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.item_config

gamecore.UILoader:define("furniture_point_view", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)

		self._reward_num = arg_2_1

		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		if not self._already_init then
			self._control.main.title.text.text = var_0_1:getNowLang("logget")
			self._control.main.confirm.text.text.text = var_0_1:getNowLang("ui_cbtn1")

			self:__init_item_reward_list()

			self._already_init = true
		end

		var_0_4:play_in_out_animation(self._control.bg.uITweenSequence, true)
		self:__reset_item_cell_state()
		self:__init_reward_data_list()
	end

	function arg_1_0:__init_item_reward_list()
		for iter_4_0 = 1, 6 do
			local var_4_0, var_4_1 = self:loadUIPrefab("mail_reward_item", self._control.main.main_item.scrollview.viewport.content.transform)

			self._reward_control_list[#self._reward_control_list + 1] = {
				obj = var_4_0,
				control = var_4_1
			}
		end
	end

	function arg_1_0:__init_reward_data_list()
		self._reward_control_list[1].obj:setVisible(true)

		self._reward_control_list[1].control.mask.reward.image.sprite = self:loadSprite(var_0_3(var_0_4.icon.item_icon, 18))

		self._reward_control_list[1].control.mask.reward.image:SetNativeSize()

		self._reward_control_list[1].control.number.text.text = self._reward_num
		self._reward_control_list[1].control.reward_des.item_name.text.text = var_0_5.find_object_by_cid(18).title
	end

	function arg_1_0:__reset_item_cell_state()
		for iter_6_0, iter_6_1 in pairs(self._reward_control_list) do
			iter_6_1.obj:setVisible(false)
		end
	end

	function arg_1_0:_play_into_se(arg_7_1)
		self:playSE(arg_7_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_8_0)
	local var_8_0 = var_0_2:class("furniture_point_view")

	var_8_0._already_init = false
	var_8_0._reward_num = 0
	var_8_0._reward_control_list = {}

	return var_8_0
end

return var_0_0
