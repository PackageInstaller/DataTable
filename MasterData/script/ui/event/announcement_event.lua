local var_0_0 = {}
local var_0_1 = gameenum.common_type
local var_0_3 = gamecore.UILoader
local var_0_5 = gamecore.AuditServerManager

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onToggle_fragment_mainfragment_toggle(arg_2_0)
		return
	end

	function arg_1_0.__doLoad_fragment_main_uni_web_view(arg_3_0)
		return
	end

	function arg_1_0.__doUpdateFrame_fragment_main_uni_web_view(arg_4_0)
		return
	end

	function arg_1_0:__onScaleButtonClick_fragment_returnbtn()
		self:_play_into_se(var_0_1:get_audio_url(var_0_1.common_icon.music_path, var_0_1.back))

		local var_5_0 = var_0_3:getInstance("home")

		if self._control.fragment.main.uni_web_view and not self._control.fragment.main.uni_web_view:Equals(nil) and not var_0_5:isAuditVersion() and self._control.fragment.main.uni_web_view:GetComponent("UniWebView") then
			self._control.fragment.main.uni_web_view:GetComponent("UniWebView"):Hide()
		end

		self._announc_seq:Pause()
		self:play_in_out_animation(false, function()
			if self._control then
				if self._control.fragment.mainfragment.toggle:GetComponent("Toggle").isOn == true then
					self.is_req_announcement = true

					var_0_3:destroyInstance("announcement")
				else
					self.is_req_announcement = false

					var_0_3:destroyInstance("announcement")
				end

				if var_5_0 then
					var_5_0:init_issignin()
				end
			else
				var_0_3:destroyInstance("announcement")
			end
		end)
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
