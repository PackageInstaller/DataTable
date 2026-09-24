local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_4 = string.format
local var_0_5 = gameenum.common_type
local var_0_6 = gameconfig.teacher_config
local var_0_7 = DG.Tweening.DOTween

gamecore.UILoader:define("teacher_get", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:_change_teacher(arg_2_1)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__init_panel(arg_3_1)
		if arg_3_1 == 10029071 then
			var_0_5:play_in_out_animation(self._control.bg.uITweenSequence, true, function()
				self:play_talk_in_animation_one(true, function()
					self._control.talkone.label_txt.text.text = ""

					local var_5_0 = self:autoKillDOTween(var_0_7.Sequence())

					var_5_0:Append(self._control.talkone.canvasGroup:DOFade(1, 0.3))

					local var_5_1 = 1

					if self.teacher_talk then
						var_5_1 = #self.teacher_talk * 0.03
					end

					var_5_0:AppendCallback(function()
						self._control.talkone.label_txt.text:DOText(self.teacher_talk, var_5_1)
					end)
					var_5_0:AppendInterval(var_5_1 + 0.5)
					var_5_0:Append(self._control.talkone.canvasGroup:DOFade(0, 0.2):OnComplete(function()
						var_5_0:Kill()

						var_5_0 = nil
					end))
					var_5_0:Play()
					self:play_talk_in_animation_one(false)
				end)
			end)
		elseif arg_3_1 == 10030571 then
			var_0_5:play_in_out_animation(self._control.bg.uITweenSequence, true, function()
				self:play_talk_in_animation_two(true, function()
					self._control.talktwo.label_txt.text.text = ""

					local var_9_0 = self:autoKillDOTween(var_0_7.Sequence())

					var_9_0:Append(self._control.talktwo.canvasGroup:DOFade(1, 0.3))

					local var_9_1 = 2

					if self.teacher_talk then
						var_9_1 = #self.teacher_talk * 0.03
					end

					var_9_0:AppendCallback(function()
						self._control.talktwo.label_txt.text:DOText(self.teacher_talk, var_9_1)
					end)
					var_9_0:AppendInterval(var_9_1 + 0.5)
					var_9_0:Append(self._control.talktwo.canvasGroup:DOFade(0, 0.2):OnComplete(function()
						var_9_0:Kill()

						var_9_0 = nil
					end))
					var_9_0:Play()
					self:play_talk_in_animation_two(false)
				end)
			end)
		end
	end

	function arg_1_0:play_talk_in_animation_one(arg_12_1, arg_12_2)
		var_0_5:play_in_out_animation(self._control.emptyone.uITweenSequence, arg_12_1, arg_12_2)
	end

	function arg_1_0:play_talk_in_animation_two(arg_13_1, arg_13_2)
		var_0_5:play_in_out_animation(self._control.emptytwo.uITweenSequence, arg_13_1, arg_13_2)
	end

	function arg_1_0:_change_teacher(arg_14_1)
		local var_14_0 = 0

		if arg_14_1 == 10029071 then
			self._control.teacher.image.sprite = self:loadSprite(var_0_4(var_0_5.buy_spoils_teacher, 10000273))
			var_14_0 = 10000273
		elseif arg_14_1 == 10030571 then
			self._control.teacher.image.sprite = self:loadSprite(var_0_4(var_0_5.buy_spoils_teacher, 10000373))
			var_14_0 = 10000373
		end

		self.teacher_talk = var_0_6.find_object_by_cid(var_14_0).get_desc
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_15_0)
	local var_15_0 = var_0_2:class("teacher_get")

	var_15_0._teahcer_cid = nil
	var_15_0._teacher_talk = nil
	var_15_0._one_seq = nil
	var_15_0._two_seq = nil

	return var_15_0
end

return var_0_0
