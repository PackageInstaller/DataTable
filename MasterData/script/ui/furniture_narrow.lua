local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = string.format
local var_0_3 = UnityEngine.Vector2
local var_0_4 = UnityEngine.Vector3
local var_0_6 = gameenum.common_type

gamecore.UILoader:define("furniture_narrow", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:set_furniture_position(arg_3_1, arg_3_2)
		self._control.img.rectTransform.anchoredPosition = var_0_3(arg_3_1 * self._room_x_plus + self._config.width * self._room_x_plus / 2, arg_3_2 * self._room_y_plus)
	end

	function arg_1_0:set_furniture_scale(arg_4_1)
		self._control.img.rectTransform.sizeDelta = self._sprite_size * (self._room_scale_const * (1 - 0.1 * (arg_4_1 / var_0_6.dormitory_const.room_ground_y_amount)))
	end

	function arg_1_0:__init_panel(arg_5_1)
		self._data = arg_5_1.data
		self._config = arg_5_1.config

		local var_5_0 = 1

		if arg_5_1.type == 1 then
			var_5_0 = 0.3904
		elseif arg_5_1.type == 2 then
			var_5_0 = 0.43600000000000005
		elseif arg_5_1.type == 3 then
			var_5_0 = 0.528
		end

		self._initial_scale = var_5_0
		self._room_scale_const = var_0_6.dormitory_const.room_scale_const * var_5_0
		self._room_x_plus = var_0_6.dormitory_const.room_x_plus * var_5_0
		self._room_y_plus = var_0_6.dormitory_const.room_y_plus * var_5_0
		self._room_bg_x = var_0_6.dormitory_const.room_bg_x * var_5_0
		self._room_bg_wall_y = var_0_6.dormitory_const.room_bg_wall_y * var_5_0

		if self._config.furniture_type == var_0_6.furniture_pos_type.move_forbid then
			self:__set_fixed_furniture()
		else
			if self._config.furniture_type == var_0_6.furniture_pos_type.ceiling then
				self._control.img:GetComponent("RectTransform").pivot = var_0_3(0.5, 1)
			end

			self:__set_sprite()
			self:set_furniture_scale(self._data.point.y)
			self:set_furniture_position(self._data.point.x, self._data.point.y)
		end

		self:__set_special_furniture()
	end

	function arg_1_0:__set_special_furniture()
		if self._config.cid == var_0_6.dormitory_special_furniture_id.beautiful_vines then
			self._control.img.image:SetNativeSize()

			self._control.img.rectTransform.sizeDelta = var_0_3(self._sprite_size.x * 1.25 * self._initial_scale, self._sprite_size.y * 1.15 * self._initial_scale)
		end
	end

	function arg_1_0:__set_fixed_furniture()
		self._control.img.image.sprite = self:loadSprite(var_0_2(var_0_6.dormitory_const.room_bg_sprite_path, self._config.icon))

		self._control.img.image:SetNativeSize()

		if self._config.cid == 10103071 or self._config.cid == 10101271 then
			self._control.img.rectTransform.sizeDelta = var_0_3(self._control.img.rectTransform.sizeDelta.x, 396)
		end

		self._control.img.rectTransform.sizeDelta = self._control.img.rectTransform.sizeDelta * self._room_scale_const

		local var_7_0 = 0

		if self._config.type == var_0_6.furniture_kind_type.ceiling then
			var_7_0 = 576 * self._room_scale_const - self._control.img.rectTransform.sizeDelta.y
		elseif self._config.type == var_0_6.furniture_kind_type.wall then
			var_7_0 = self._room_bg_wall_y
		elseif self._config.type == var_0_6.furniture_kind_type.ground then
			var_7_0 = 0
		end

		self._control.img.rectTransform.anchoredPosition = var_0_3(self._room_bg_x, var_7_0)
	end

	function arg_1_0:__set_sprite()
		self._control.img.image.sprite = self:loadSprite(var_0_2(var_0_6.furniture_img, self._config.icon, self._config.icon, self._config.icon, ""))

		self._control.img.image:SetNativeSize()

		self._sprite_size = self._control.img.rectTransform.sizeDelta
		self._control.img.rectTransform.localRotation = var_0_4(0, self._data.rotate and 180 or 0, 0)
		self._control.img.image.alphaHitTestMinimumThreshold = var_0_6.dormitory_const.furniture_alpha_hit_min
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_9_0)
	local var_9_0 = var_0_1:class("furniture_narrow")

	var_9_0._data = {}
	var_9_0._config = {}
	var_9_0._sprite_size = var_0_3(0, 0)
	var_9_0._room_x_plus = nil
	var_9_0._room_y_plus = nil
	var_9_0._room_scale_const = nil
	var_9_0._room_bg_x = nil
	var_9_0._room_bg_wall_y = nil
	var_9_0._initial_scale = nil

	return var_9_0
end

return var_0_0
