local var_0_0 = lx
local var_0_1 = UnityEngine.GameObject
local var_0_2 = UnityEngine.Camera
local var_0_3 = UnityEngine.Input
local var_0_4 = gamecore.emotion_spine_mgr
local var_0_5 = gamecore.UILoader
local var_0_6 = UnityEngine.EventSystems.EventSystem
local var_0_8 = table.insert
local var_0_9 = table.remove
local var_0_11 = gamecore.play_spine_anim
local var_0_12 = UnityEngine.RectTransformUtility
local var_0_13 = gamecore.util_func

lx.define_class("click_spine_mgr", function(arg_1_0)
	function arg_1_0:run_once()
		if var_0_3.GetMouseButtonDown(0) then
			local var_2_0 = var_0_5:getInstance("home")

			if var_2_0 and var_2_0._panel.activeSelf then
				local var_2_1 = self:get_obj_name()

				log.print_r(var_2_1, "点击到的部位")

				if var_2_1 and self.name_func and var_2_1._panel.activeSelf then
					self.name_func(var_2_1)
				end
			end
		end
	end

	function arg_1_0:init(arg_3_1)
		if self.is_init then
			return
		end

		self._skeleton = arg_3_1:GetComponent("SkeletonGraphic")
		self._emotion_spine = var_0_4

		self._emotion_spine:init(self._skeleton, arg_3_1)

		self._play_anim = var_0_11:create()

		self._play_anim:init(self._skeleton)

		self._camera = var_0_1.Find("UICamera"):GetComponent(typeof(var_0_2))
		self.is_init = true
		self.name_func = nil
		self._uiroot_canvas_rect = var_0_13.get_ui_root_canvas_rect()
		self._ui_camera = var_0_13.get_ui_camera()
	end

	function arg_1_0:set_spine_name(arg_4_1)
		self._play_anim:play_spine_animation(arg_4_1)
	end

	function arg_1_0:init_emotion_track(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7, arg_5_8, arg_5_9)
		self._emotion_spine:init_emotion(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7, arg_5_8, arg_5_9)
	end

	function arg_1_0:set_emotion_name(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		self._emotion_spine:play_emotion(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	end

	function arg_1_0:set_other_emotion_name(arg_7_1, arg_7_2, arg_7_3)
		self._emotion_spine:play_other_emotion(arg_7_1, arg_7_2, arg_7_3)
	end

	function arg_1_0:play_anim(arg_8_1, arg_8_2, arg_8_3)
		self._skeleton.AnimationState:ClearTrack(0)
		self._skeleton.AnimationState:ClearTrack(2)

		local var_8_0 = self._skeleton.AnimationState:SetAnimation(arg_8_3, arg_8_1.action, arg_8_2)

		var_8_0.Complete = var_8_0.Complete + function()
			self._skeleton.AnimationState:AddAnimation(arg_8_3, "original", true, 0)

			if arg_8_1.face[1] and arg_8_1.face[1] ~= "" then
				local var_9_0 = self._skeleton.AnimationState:SetAnimation(2, arg_8_1.face[1], true)

				var_9_0.TrackTime = self._skeleton.AnimationState:GetCurrent(0).TrackTime
				var_9_0.Alpha = 0
			end
		end
	end

	function arg_1_0:get_obj_name()
		local var_10_0 = var_0_1.Find("UICamera"):GetComponent(typeof(var_0_2)):ScreenToWorldPoint(UnityEngine.Input.mousePosition)
		local var_10_1 = UnityEngine.Physics2D.RaycastAll(Vector2.New(var_10_0.x, var_10_0.y), Vector2.zero)
		local var_10_5, var_10_6 = var_0_12.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_3.mousePosition, self._ui_camera, nil)
		local var_10_8 = UnityEngine.Physics2D.RaycastAll(var_10_6, Vector2.zero)
		local var_10_9 = UnityEngine.Physics2D:Raycast(Vector2.zero)

		do return nil end

		if var_10_1.Length <= 0 then
			return nil
		elseif var_10_1.Length >= 1 then
			if self:__is_ui() then
				return nil
			else
				for iter_10_0 = 0, var_10_1.Length - 1 do
					local var_10_10 = var_10_1[iter_10_0].collider.gameObject.name

					if var_10_1[iter_10_0].collider.gameObject.name and var_10_10 ~= "" then
						return var_10_10
					end
				end
			end
		end
	end

	function arg_1_0.hava_data(arg_11_0, arg_11_1, arg_11_2)
		for iter_11_0, iter_11_1 in pairs(arg_11_1) do
			if iter_11_1 == arg_11_2 then
				return true
			end
		end

		return false
	end

	function arg_1_0:set_uned_obj(arg_12_1)
		if not arg_12_1:Equals(nil) and arg_12_1 and not self:hava_data(self._object_list, arg_12_1) then
			var_0_8(self._object_list, arg_12_1)
		end

		for iter_12_0 = #self._object_list, 1, -1 do
			if not self._object_list[iter_12_0] or self._object_list[iter_12_0]:Equals(nil) or type(self._object_list[iter_12_0]) == "table" then
				var_0_9(self._object_list, iter_12_0)
			end
		end
	end

	function arg_1_0.__r_is_ui(arg_13_0)
		return (var_0_6.current and var_0_6.current.isActiveAndEnabled and var_0_6.current.currentSelectedGameObject or nil) and true
	end

	function arg_1_0.clear(arg_14_0)
		arg_14_0.name_func = nil
		arg_14_0._object_list = {}

		var_0_4:reset_param()
	end
end)

function create()
	local var_15_0 = var_0_0.class("click_spine_mgr")

	var_15_0.is_init = false
	var_15_0._skeleton = nil
	var_15_0._camera = nil
	var_15_0._char_name = nil
	var_15_0._obj_list = {}
	var_15_0._emotion_spine = nil
	var_15_0._play_anim = nil
	var_15_0.name_func = nil
	var_15_0._object_list = {}

	return var_15_0
end

return create
