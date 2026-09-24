local var_0_0 = {}
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_8 = gamecore.user
local var_0_10 = string.format
local var_0_13 = gameconfig.item_config
local var_0_14 = gameconfig.map_config

gamecore.UILoader:define("support_info", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)

		self._config_data = arg_2_1
		self._map_id = arg_2_2

		self:__init_panel()
	end

	function arg_1_0.uplevel(arg_3_0, arg_3_1)
		arg_3_0._can_send_req = arg_3_1
	end

	function arg_1_0:__init_panel()
		self._can_send_req = true

		self:_update_panel_info()
	end

	function arg_1_0:_update_panel_info()
		self._control.title_name.text.text = self._config_data.title
		self._support_info_data = var_0_8:get_supportInfo_data(self._map_id)
		self._control.up_text.text.text = var_0_2:getNowLang("skillupgrade")
		self._control.support_text.text.text = var_0_2:getNowLang("supportlevel")

		local var_5_0

		if self._support_info_data and next(self._support_info_data) then
			var_5_0 = self._support_info_data.level or 1
		end

		local var_5_1 = not not (self._support_info_data and next(self._support_info_data))

		self._control.big_icon.image.sprite = self:loadSprite(var_0_4.support_image_icon["support_image_" .. self._config_data.type])
		self._control.lock_info.text.text = var_5_1 and "" or var_0_14.find_object_by_id(self._map_id).support_open_desc
		self._control.lv_txt.text.text = var_5_1 and var_0_10("%s%s", var_0_2:getNowLang("levelprefix"), var_5_0) or "----"

		self._control.lock_bg:SetActive(not var_5_1)
		self._control.lock_under_right:SetActive(not var_5_1)

		if var_5_0 <= #self._config_data.levelUp then
			local var_5_3 = self._config_data.levelUp[var_5_0][1].id
			local var_5_4 = self._config_data.levelUp[var_5_0][1].count
			local var_5_5 = var_0_13.find_object_by_cid(self._config_data.levelUp[var_5_0][1].id)

			self._control.support_infocount.text.text = var_5_1 and var_0_10(var_0_2:getNowLang("cansupportnum"), var_5_0) or ""

			self._control.icon_btn:SetActive(var_5_1)
			self._control.icon_bg:SetActive(var_5_1)
			self._control.levelup_btn:SetActive(true)
			self._control.up_text:SetActive(true)

			self._control.icon_btn.image.sprite = self:loadSprite(var_0_10(var_0_4.icon.item_icon, var_5_3))

			self._control.levelup_btn.button.onClick:RemoveAllListeners()
			self._control.icon_btn.button.onClick:RemoveAllListeners()

			if var_5_1 then
				self._control.levelup_btn.button.onClick:AddListener(function()
					if self._can_send_req then
						var_0_8:req_supportLevelUpReq(self._map_id)
						self:uplevel(false)
					end
				end)
			end

			self._control.heart_count.text.text = var_5_1 and var_0_10("%s/%s", var_0_8:get_item_count(var_5_3), var_5_4) or "----"

			self._control.icon_btn.button.onClick:AddListener(function()
				var_0_3:createInstance("item_tip"):show(var_5_5)
			end)

			self._control.support_heart.text.text = var_5_5.title
			self._control.open_text.text.text = ""
		else
			self._control.support_infocount.text.text = var_0_2:getNowLang("cansupportall")

			self._control.levelup_btn:SetActive(false)
			self._control.icon_btn:SetActive(false)
			self._control.icon_bg:SetActive(false)
			self._control.up_text:SetActive(false)

			self._control.support_heart.text.text = ""
			self._control.heart_count.text.text = ""
			self._control.open_text.text.text = var_0_2:getNowLang("supportlevelmax")
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_8_0)
	local var_8_0 = var_0_3:class("support_info")

	arg_8_0.map_id = nil

	gamecore.extend_obj(var_8_0)

	return var_8_0
end

return var_0_0
