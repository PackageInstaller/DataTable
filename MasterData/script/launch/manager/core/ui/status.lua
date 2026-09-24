local var_0_0 = {}
local var_0_1 = assert
local var_0_2 = string.format
local var_0_3 = math.floor
local var_0_4 = gamecore.UILoader
local var_0_5 = DG.Tweening.DOTween
local var_0_7 = 16.666666666666668

gamecore.UILoader:define("status", function(arg_1_0)
	function arg_1_0:newStatus(arg_2_1, arg_2_2)
		self:statusEnd()

		arg_2_2 = arg_2_2 or ""
		self._control.status_text.text.text = arg_2_1
		self._control.details.text.text = arg_2_2

		self:__set_progress_value(0)

		self._now_do = true

		self:setVisible(true)
	end

	function arg_1_0:setProgressTime(arg_3_1, arg_3_2)
		var_0_1(self._now_do)

		arg_3_2 = arg_3_2 or 100
		arg_3_2 = arg_3_2 < 0 and 0 or arg_3_2 > 100 and 100 or arg_3_2
		self._progress_target = arg_3_2 or 100

		if self._progress_target - self._progress_value > 0 then
			self._interval_time = arg_3_1 / (self._progress_target - self._progress_value)

			if self._interval_time < var_0_7 then
				self._interval_value = var_0_3(var_0_7 / self._interval_time)
				self._interval_time = var_0_7
			else
				self._interval_value = 1
			end
		end

		self:__status_auto_progress()
	end

	function arg_1_0:onProgressChange(arg_4_1, arg_4_2)
		var_0_1(self._now_do)

		arg_4_1 = arg_4_1 < 0 and 0 or arg_4_1 > 100 and 100 or arg_4_1
		arg_4_2 = arg_4_2 or ""

		if self._control.details.text:Equals(nil) then
			-- block empty
		else
			self._control.details.text.text = arg_4_2
		end

		self:__set_progress_value(arg_4_1)
	end

	function arg_1_0:statusEnd(arg_5_1)
		self:__clear_seq()
		self:__set_progress_value(100)

		self._now_do = false
		self._progress_target = nil
		self._interval_time = nil

		self:setVisible(not arg_5_1)
	end

	function arg_1_0.setProgressTargetFunc(arg_6_0, arg_6_1)
		arg_6_0._progress_target_func = arg_6_1
	end

	function arg_1_0:__onDestroy()
		self:__clear_seq()
	end

	function arg_1_0:__clear_seq()
		if self._seq then
			self._seq:Kill()

			self._seq = nil
		end
	end

	function arg_1_0:__status_auto_progress()
		if not self._interval_time then
			return
		end

		self:__clear_seq()

		local var_9_0 = self:autoKillDOTween(var_0_5.Sequence())

		var_9_0:AppendInterval(self._interval_time / 1000)
		var_9_0:AppendCallback(function()
			if self._progress_value < self._progress_target then
				self._progress_value = self._progress_value + self._interval_value

				if self._progress_value > self._progress_target then
					self._progress_value = self._progress_target
				end

				self:__set_progress_value(self._progress_value)
			end
		end)
		var_9_0:SetLoops(-1)
		var_9_0:Play()

		self._seq = var_9_0
	end

	function arg_1_0:__set_progress_value(arg_11_1)
		self._progress_value = var_0_3(arg_11_1)

		if self._control.progress.front:Equals(nil) then
			-- block empty
		else
			self._control.progress.front.image.fillAmount = arg_11_1 / 100
		end

		if self._control.percent:Equals(nil) then
			-- block empty
		else
			self._control.percent.text.text = var_0_2("%.2f%%", arg_11_1)
		end

		if self._progress_value == self._progress_target then
			local var_11_0 = self._progress_target_func

			self._progress_target_func = nil

			if self._progress_target_func then
				local var_11_1 = var_0_5.Sequence()

				var_11_1:AppendInterval(0.01)
				var_11_1:AppendCallback(function()
					var_11_1:Kill()
					var_11_0()
				end)
			end
		end
	end
end)

function var_0_0.create(arg_13_0)
	local var_13_0 = var_0_4:class("status")

	var_13_0._seq = nil
	var_13_0._now_do = false
	var_13_0._progress_target = 0
	var_13_0._progress_value = 0
	var_13_0._interval_time = nil
	var_13_0._interval_value = 1
	var_13_0._progress_target_func = nil

	return var_13_0
end

return var_0_0
