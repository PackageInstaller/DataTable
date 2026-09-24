local var_0_0 = {}
local var_0_1 = string.format
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader

gamecore.UILoader:define("install", function(arg_1_0)
	function arg_1_0:onStartInstall(arg_2_1, arg_2_2, arg_2_3)
		if arg_2_2 < arg_2_1 then
			var_0_3:createInstance("install_msgbox"):showOne(var_0_2:get("存储空间不足，需要：") .. arg_2_3, exit_self_process, var_0_2:getNowLang("settingquitgame"))
		end

		self:setVisible(true)
	end

	function arg_1_0:onProgressChange(arg_3_1, arg_3_2, arg_3_3)
		self._control.foreground.fillAmount = arg_3_3 / 100
		self._control.details.text = var_0_1("%s/%s", tostring(arg_3_2), tostring(arg_3_1))
	end

	function arg_1_0.onInstallFailed(arg_4_0, arg_4_1)
		var_0_3:createInstance("install_msgbox"):showOne(var_0_2:get("安装失败,请检查您的存储空间是否不足。"), exit_self_process, var_0_2:getNowLang("settingquitgame"))
	end
end)

function var_0_0.create(arg_5_0)
	local var_5_0 = var_0_3:class("install")

	var_5_0:__registerControl("progress/foreground", UnityEngine.UI.Image, "foreground")
	var_5_0:__registerControl("status_text", UnityEngine.UI.Text)
	var_5_0:__registerControl("details", UnityEngine.UI.Text)

	return var_5_0
end

return var_0_0
