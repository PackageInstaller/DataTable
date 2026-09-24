local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language

gamecore.UILoader:define("cardbook", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:play_in_out_animation(arg_3_1, arg_3_2, arg_3_3)
		arg_3_3 = arg_3_3 or self._control.bg.uITweenSequence

		if arg_3_1 then
			arg_3_3:Play(function()
				if arg_3_2 then
					arg_3_2()
				end
			end)
		else
			arg_3_3:PlayReverse(function()
				if arg_3_2 then
					arg_3_2()
				end
			end)
		end
	end

	function arg_1_0:__init_panel()
		self._control.top.title_txt.text.text = var_0_2:getNowLang("leaderboardtitle")
		self._control.scrollview.content.rank_btn_1.title.text.text = var_0_2:getNowLang("leaderboardtype1")
		self._control.scrollview.content.rank_btn_2.title.text.text = var_0_2:getNowLang("leaderboardtype2")
		self._control.scrollview.content.rank_btn_3.title.text.text = var_0_2:getNowLang("leaderboardtype3")
		self._control.scrollview.content.rank_btn_4.title.text.text = var_0_2:getNowLang("leaderboardtype4")

		self:play_in_out_animation(true)
	end

	function arg_1_0:_play_into_se(arg_7_1)
		self:playSE(arg_7_1, false)
	end

	function arg_1_0.__onReset(arg_8_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_9_0)
	return (var_0_1:class("cardbook"))
end

return var_0_0
