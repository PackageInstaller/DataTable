local var_0_0 = lx
local var_0_2 = string.format
local var_0_3 = lx.json_encode
local var_0_5 = lx.UserData
local var_0_6 = gamecore.UILoader
local var_0_7 = string.gsub
local var_0_9 = string.sub

lx.define_class("Language", function(arg_1_0)
	function arg_1_0:setLanguage(arg_2_1, arg_2_2)
		self._language = arg_2_1

		self:saveLanguage()

		if not arg_2_2 then
			return
		end

		var_0_6:createInstance("msgbox"):showOne(self:get("系统语言切换成功，即将重启游戏。"), function()
			gamecore.SceneManager:restart()
		end, self:get("确认"))
	end

	function arg_1_0:getLanguage()
		return self._language
	end

	function arg_1_0.get(arg_5_0, arg_5_1)
		return arg_5_1
	end

	function arg_1_0:getNowLang(arg_6_1, arg_6_2)
		local var_6_0 = gameenum.language_table:get(arg_6_1, self._language)

		if arg_6_2 then
			var_6_0 = self:convert_rich_text(var_6_0)
		end

		return var_6_0
	end

	function arg_1_0.convert_rich_text(arg_7_0, arg_7_1)
		return (var_0_7(var_0_7(arg_7_1, "%^C[^%^]+", function(arg_8_0)
			return var_0_2("<color=#%s>%s</color>", var_0_9(arg_8_0, 3, 10), (var_0_9(arg_8_0, 19, #arg_8_0)))
		end), "{%d}", "%%s"))
	end

	function arg_1_0.get_chinese_text(arg_9_0, arg_9_1)
		return (var_0_7(var_0_7(arg_9_1, "%^C[^%^]+", function(arg_10_0)
			return (var_0_9(arg_10_0, 19, #arg_10_0))
		end), "{%d}", "%%s"))
	end

	function arg_1_0:saveLanguage()
		var_0_5:setKeyData("language", var_0_3({
			language = self._language
		}))
	end

	function arg_1_0.loadLanguage(arg_12_0)
		local var_12_0 = app:getSystem():getChannel()

		if var_12_0 == "hm_android_jp" or var_12_0 == "hm_ios_jp" then
			arg_12_0._language = "japanese"

			return
		end

		arg_12_0._language = "schinese"
	end
end)

return function()
	local var_13_0 = var_0_0.class("Language")

	var_13_0._language = "cn"

	return var_13_0
end
