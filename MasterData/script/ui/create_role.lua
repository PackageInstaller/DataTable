local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = UnityEngine.Vector2

gamecore.UILoader:define("create_role", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:select_init_ship()
		var_0_3:req_InitShip(self._start_ship)
	end

	function arg_1_0:__init_panel()
		self._control.ship_type_detail.ship_type_name.text.text = var_0_1:getNowLang("shiptypedetail12")
		self._control.ship_type_detail.ship_role_name.text.text = var_0_1:getNowLang("createrolename1")
		self._control.title.signinselectshipconfirm.text.text = var_0_1:getNowLang("createroletitle")
		self._control.role.desc_bg.text.text.text = var_0_1:getNowLang("initshipdesc1")
		self._control.select_role.create_next_btn.ui_create_next.text.text = var_0_1:getNowLang("ui_create_next")
		self._control.select_role.account_merge_btn.ui_aaccount_merge.text.text = var_0_1:getNowLang("ui_account_merge")
		self._control.input_name.start_game_btn.startgame.text.text = var_0_1:getNowLang("startgame")
		self._control.account_merge.merge_frame.content.enterrolecode.text.text = var_0_1:getNowLang("enterrolecode")
		self._control.account_merge.merge_frame.content.enterrolecodeinfo.text.text = var_0_1:getNowLang("enterrolecodeinfo", true)
		self._control.account_merge.merge_frame.content.confirm_btn.confirm.text.text = var_0_1:getNowLang("confirm")
		self._control.account_merge.merge_frame.content.InputField.enteryourrolecode.text.text = var_0_1:getNowLang("enteryourrolecode")
		self._control.input_name.InputField.Placeholder.text.text = var_0_1:getNowLang("inputusername")
		self._control.input_name.InputField.inputField.text = self:__get_name()

		local var_4_0 = app:getSystem():getChannel()

		if var_4_0 == "hm_android_jp" or var_4_0 == "hm_ios_jp" then
			self._control.select_role.account_merge_btn.ui_aaccount_merge.rectTransform.anchoredPosition = var_0_4(88, 0)
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_5_0)
	return (var_0_2:class("create_role"))
end

return var_0_0
