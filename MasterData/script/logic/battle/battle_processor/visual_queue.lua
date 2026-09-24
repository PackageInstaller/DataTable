local var_0_0 = {}
local var_0_4 = table.insert

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.init_visual_queue(arg_2_0)
		arg_2_0._tween_seq_queue = {}
		arg_2_0._tween_seq_queue_head = 1
		arg_2_0._tween_seq_queue_ass = 0
		arg_2_0._tween_seq_queue_init = true
	end

	function arg_1_0:enqueue_visual(arg_3_1)
		if not arg_3_1 or not self._tween_seq_queue_init then
			return
		end

		self._tween_seq_queue_ass = self._tween_seq_queue_ass + 1

		var_0_4(self._tween_seq_queue, self._tween_seq_queue_ass, arg_3_1)
	end

	function arg_1_0:dequeue_visual()
		if not self._tween_seq_queue_init then
			return
		end

		self._tween_seq_queue[self._tween_seq_queue_head] = nil
		self._tween_seq_queue_head = self._tween_seq_queue_head + 1

		return self._tween_seq_queue[self._tween_seq_queue_head]
	end

	function arg_1_0:dequeue_visual_and_kill()
		local var_5_0 = self:dequeue_visual()

		if var_5_0 then
			var_5_0:Kill()
		end
	end

	function arg_1_0:is_visual_queue_empty()
		return not self._tween_seq_queue_init or self._tween_seq_queue_head > self._tween_seq_queue_ass
	end

	function arg_1_0:kill_all_visual()
		while not self:is_visual_queue_empty() do
			self:dequeue_visual_and_kill()
		end
	end
end

function var_0_0.extend_obj(arg_8_0)
	arg_8_0._tween_seq_queue = {}
	arg_8_0._tween_seq_queue_init = false
	arg_8_0._tween_seq_queue_head = 1
	arg_8_0._tween_seq_queue_ass = 1
end

return var_0_0
