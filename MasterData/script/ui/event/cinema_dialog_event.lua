local var_0_0 = {}
local var_0_3 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_playback_btn()
		self.is_now_playback = true

		self._control.back_play:SetActive(true)

		self._control.back_play.scrollview.viewport.content.rectTransform.anchoredPosition = Vector2(self._control.back_play.scrollview.viewport.content.rectTransform.anchoredPosition.x, 30000)
		self._control.back_play.picture_book_text.text.text = var_0_3:getNowLang("ui_4th_dialog_log")

		if self.now_dotext then
			self.now_dotext:Pause()
		end
	end

	function arg_1_0:__onClick_auto_btn()
		self:set_auto_event()
	end

	function arg_1_0:__onClick_skip_btn()
		self:set_exit_bgm()
		self:set_skip_event()
	end

	function arg_1_0:__onClick_back_play_return_btn()
		self.is_now_playback = false

		self._control.back_play:SetActive(false)

		if self.now_dotext then
			self.now_dotext:Play()
		end
	end

	function arg_1_0:__onClick_cilck_btn()
		self:set_onclick_event()
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
