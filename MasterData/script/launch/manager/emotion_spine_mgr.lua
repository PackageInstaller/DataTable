local var_0_0 = lx
local var_0_1 = UnityEngine.Time
local var_0_2 = Mathf
local var_0_3 = gamecore.UILoader

lx.define_class("emotion_spine_mgr", function(arg_1_0)
	function arg_1_0.reset_param(arg_2_0)
		arg_2_0._spine_anim_list = {}
		arg_2_0._skeleton = nil
		arg_2_0._anim_state = nil
		arg_2_0._origin_anim = nil
		arg_2_0._stay_anim = nil
		arg_2_0._default_alpha = 0.3
		arg_2_0._origin_alpha = nil
		arg_2_0._stay_curve = nil
		arg_2_0._stay_speed_curve = nil
		arg_2_0._y_scale_curve = nil
		arg_2_0._keys = nil
		arg_2_0._length = nil
		arg_2_0._is_curve = false
		arg_2_0._origin_scale = nil
		arg_2_0._scale = {}
		arg_2_0._obj = nil
		arg_2_0._time = 0
	end

	function arg_1_0:run_once()
		local var_3_0 = var_0_3:getInstance("main_wnd")

		if var_3_0 and var_3_0._panel.activeSelf and self._is_curve then
			if not self._obj or tostring(self._obj) == nil or tostring(self._obj) == "null" then
				return
			end

			self._time = self._time + var_0_1.deltaTime
			self._stay_anim.Alpha = var_0_2.Max(0, self._origin_alpha - self._stay_curve:Evaluate(self._time))
			self._origin_anim.TimeScale = self._stay_speed_curve:Evaluate(self._time)
			self._scale.y = self._origin_scale.y + self._y_scale_curve:Evaluate(self._time)
			self._obj.transform.localScale = self._scale

			if self._time >= self._keys[self._length - 1].time then
				self._time = 0
				self._is_curve = false
				self._origin_anim.TimeScale = 1
				self._stay_anim.Alpha = self._default_alpha
				self._obj.transform.localScale = self._origin_scale
			end
		end
	end

	function arg_1_0.init(arg_4_0, arg_4_1, arg_4_2)
		arg_4_0._skeleton = arg_4_1
		arg_4_0._obj = arg_4_2
	end

	function arg_1_0:init_emotion(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7, arg_5_8, arg_5_9)
		self._spine_anim_list = {}
		self._anim_state = self._skeleton.AnimationState

		local var_5_0 = self._skeleton.Skeleton.Data.Animations:ToArray()
		local var_5_1 = {}

		for iter_5_0 = 0, var_5_0.Length - 1 do
			var_5_1[tostring(var_5_0[iter_5_0].Name)] = var_5_1[tostring(var_5_0[iter_5_0].Name)] or var_5_0[iter_5_0]
		end

		self._spine_anim_list = var_5_1

		if not self:hava_key(var_5_1, arg_5_3) or not self:hava_key(var_5_1, arg_5_7) then
			self._spine_anim_list = {}

			return
		end

		self._origin_anim = self._anim_state:SetAnimation(arg_5_2, arg_5_3, arg_5_5)
		self._origin_anim.Alpha = arg_5_4
		self._stay_anim = self._anim_state:SetAnimation(arg_5_6, arg_5_7, arg_5_9)
		self._stay_anim.Alpha = arg_5_8
		self._default_alpha = arg_5_8
		self._stay_curve = arg_5_1.stayCurve
		self._stay_speed_curve = arg_5_1.staySpeedCurve
		self._y_scale_curve = arg_5_1.yScaleCurve
		self._keys = self._stay_curve.keys
		self._length = self._stay_curve.length

		if not self._obj then
			return
		end

		self._origin_scale = self._obj.transform.localScale

		for iter_5_1, iter_5_2 in pairs(self._origin_scale) do
			self._scale[iter_5_1] = self._scale[iter_5_1] or iter_5_2
		end
	end

	function arg_1_0:set_alpha(arg_6_1)
		self._origin_alpha = 0.7
		self._stay_anim.Alpha = arg_6_1
	end

	function arg_1_0:play_emotion(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
		log.print_r(arg_7_1, "轨道2（表情）:   ")

		if self._spine_anim_list then
			if not self:hava_key(self._spine_anim_list, arg_7_1) then
				return
			end
		else
			return
		end

		local var_7_1 = false
		local var_7_2 = gamecore.user:get_role_drawing_char()

		if var_7_2 and var_7_2.cid == 192 then
			var_7_1 = true
		end

		if var_7_1 then
			self._anim_state:ClearTrack(2)
			self._anim_state:SetAnimation(2, "stay", false)
		end

		self:set_alpha(arg_7_2)
		self._anim_state:SetAnimation(2, arg_7_1, arg_7_3)

		self._anim_state:GetCurrent(2).TrackTime = self._anim_state:GetCurrent(0).TrackTime

		local var_7_3 = self._anim_state:GetCurrent(2)

		var_7_3.Alpha = 0

		if self._anim_state:GetCurrent(0) then
			log.print_r(self._anim_state:GetCurrent(0).Animation.Name, "\t\t0轨道动画名称")
			log.print_r(self._anim_state:GetCurrent(0).Alpha, "\t\t0轨道动画alpha")
		end

		if self._anim_state:GetCurrent(1) then
			log.print_r(self._anim_state:GetCurrent(1).Animation.Name, "\t\t1轨道动画名称")
			log.print_r(self._anim_state:GetCurrent(1).Alpha, "\t\t1轨道动画alpha")
		end

		if self._anim_state:GetCurrent(2) then
			log.print_r(self._anim_state:GetCurrent(2).Animation.Name, "\t\t2轨道动画名称")
			log.print_r(self._anim_state:GetCurrent(2).Alpha, "\t\t2轨道动画alpha")
		end

		if arg_7_1 == "original" then
			return
		elseif var_7_1 then
			var_7_3.Alpha = 1
		end

		if arg_7_4 then
			self._is_curve = true
		end
	end

	function arg_1_0:play_other_emotion(arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = 1

		if 1 == 30 then
			var_8_0 = 1
		end

		if self._spine_anim_list then
			if not self:hava_key(self._spine_anim_list, arg_8_1) then
				return
			end
		else
			return
		end

		self:set_alpha(arg_8_2)

		local var_8_1 = self._skeleton.skeletonDataAsset:GetAnimationStateData()
		local var_8_2 = self._skeleton.AnimationState:GetCurrent(var_8_0)

		if var_8_1 and var_8_2 then
			var_8_1.SetMix(var_8_2.Animation.Name, arg_8_1, 1)
		end

		self._anim_state = self._skeleton.AnimationState

		self._anim_state:SetAnimation(var_8_0, arg_8_1, arg_8_3)

		self._anim_state:GetCurrent(var_8_0).Alpha = 0
		self._is_curve = true
	end

	function arg_1_0.hava_key(arg_9_0, arg_9_1, arg_9_2)
		for iter_9_0, iter_9_1 in pairs(arg_9_1) do
			if iter_9_0 == arg_9_2 then
				return true
			end
		end

		return false
	end
end)

return function()
	local var_10_0 = var_0_0.class("emotion_spine_mgr")

	var_10_0:reset_param()

	return var_10_0
end
