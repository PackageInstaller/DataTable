local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_6 = gameenum.common_type

gamecore.UILoader:define("friendinfo", function(arg_1_0)
	function arg_1_0.updata_data(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1, arg_3_2, arg_3_3)
		self:setVisible(true)

		self._friends_data = arg_3_1
		self._friends_index = arg_3_2

		self:__init_panel(arg_3_1, arg_3_2, arg_3_3)
	end

	function arg_1_0:__init_panel(arg_4_1, arg_4_2, arg_4_3)
		self._control.main.top_stick.gameObject:SetActive(false)

		if arg_4_3 == 1 then
			self._control.main.delfriend.gameObject:SetActive(true)

			self._control.main.delfriend.text.text.text = var_0_1:getNowLang("fbt5")
			self._is_frineds = true
			self._control.main.friendname.text.text = arg_4_1[arg_4_2 + 1].name
			self._control.main.uidnumb.text.text = arg_4_1[arg_4_2 + 1].account_id
			self._control.main.friendname.lv.text.text = "Lv." .. arg_4_1[arg_4_2 + 1].level
			self._control.main.rank.text.text = var_0_1:getNowLang("usertitle" .. 11 - arg_4_1[arg_4_2 + 1].exploit)
			self._control.main.rankicon.image.sprite = self:loadSprite(var_0_6:get_format_url(var_0_6.common_icon.friend_badge_path, arg_4_1[arg_4_2 + 1].exploit))

			self._control.main.top_stick.gameObject:SetActive(true)

			self._control.main.top_stick.text.text.text = arg_4_1[arg_4_2 + 1].top_time == 0 and var_0_1:getNowLang("top") or var_0_1:getNowLang("untop")
		else
			self._control.main.delfriend.gameObject:SetActive(false)

			self._is_frineds = false
			self._control.main.friendname.text.text = arg_4_1.name
			self._control.main.uidnumb.text.text = arg_4_1.account_id
			self._control.main.friendname.lv.text.text = "Lv." .. arg_4_1.level
			self._control.main.rank.text.text = var_0_1:getNowLang("usertitle" .. 11 - arg_4_1.exploit)
			self._control.main.rankicon.image.sprite = self:loadSprite(var_0_6:get_format_url(var_0_6.common_icon.friend_badge_path, arg_4_1.exploit))
		end

		self._control.main.visit.text.text.text = var_0_1:getNowLang("fbt4")

		local var_4_0 = var_0_2:getInstance("friendsmain")

		if var_4_0 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_4_0._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end
	end

	function arg_1_0:_play_into_se(arg_5_1)
		self:playSE(arg_5_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_6_0)
	local var_6_0 = var_0_2:class("friendinfo")

	var_6_0._have_data = nil
	var_6_0._havefriend_array = {}
	var_6_0._name = nil
	var_6_0._friendsnum = nil
	var_6_0._friends_data = nil
	var_6_0._friends_index = nil
	var_6_0._friends_uid = nil
	var_6_0._is_frineds = false

	return var_6_0
end

return var_0_0
