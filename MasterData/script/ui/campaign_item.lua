local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.UILoader
local var_0_5 = string.format
local var_0_6 = gameenum.common_type
local var_0_7 = gameconfig.workshop_config
local var_0_8 = gameconfig.ship_rule_config
local var_0_9 = gameconfig.map_campaign_config

gamecore.UILoader:define("campaign_item", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0.__init_panel(arg_3_0, arg_3_1)
		return
	end

	function arg_1_0:__updata_cell_info(arg_4_1, arg_4_2)
		self._config_data = arg_4_1.config_data
		self._difficulty = arg_4_1.difficulty
		self._map_id = arg_4_1.map_id

		local var_4_0 = true

		if self._config_data then
			if self._difficulty == var_0_6.map_campaign_difficulty.normal then
				if self._config_data.need_pve_level_id ~= 0 then
					if var_0_1:is_map_pass(self._config_data.need_pve_level_id) then
						var_4_0 = false
					end
				else
					var_4_0 = false
				end
			elseif self._difficulty == var_0_6.map_campaign_difficulty.difficult then
				if self._config_data.need_campaign_level_id ~= 0 then
					if var_0_1:is_campaijn_pass(self._config_data.need_campaign_level_id) then
						var_4_0 = false
					end
				else
					var_4_0 = false
				end
			end

			self._control.bg.bg_btn.map_img.award_txt.text.text = var_0_3:getNowLang("warresultrewardtitle")
			self._control.bg.bg_btn.map_img.icon_btn.image.sprite = self:loadSprite(var_0_5(var_0_6.icon.item_icon, self._config_data.product_item))
			self._control.bg.lock.canvasGroup.alpha = var_4_0 and 1 or 0
			self._control.bg.lock.canvasGroup.blocksRaycasts = var_4_0
			self._control.bg.lock.lock_info.text.text = self._config_data.unlock_desc

			local var_4_1 = ""

			if arg_4_1.map_id then
				local var_4_2 = 0

				for iter_4_0, iter_4_1 in pairs((var_0_1:get_workshop_data())) do
					local var_4_3 = var_0_7.find_object_by_id(iter_4_1.id)

					if var_4_3 and var_4_3.effect then
						for iter_4_2, iter_4_3 in pairs(var_4_3.effect) do
							if iter_4_3.type == 5 and iter_4_3.num4 == arg_4_1.config_data.product_item then
								var_4_2 = var_4_2 + iter_4_3.num
							end
						end
					end
				end

				var_4_1 = "+" .. tostring(var_4_2) .. "%"

				if var_4_2 > 0 then
					self._control.bg.bg_btn.map_img.map_up_rate_txt:SetActive(true)
				else
					self._control.bg.bg_btn.map_img.map_up_rate_txt:SetActive(false)
				end
			end

			self._control.bg.bg_btn.map_img.map_up_rate_txt.text.text = var_4_1
			self._control.bg.bg_btn.map_img.map_rate_txt.text.text = self._config_data.item_drop_desc

			self._control.bg.bg_btn.map_img.map_info_txt:GetComponent("TextHorizonScroller"):SetText(self._config_data.item_drop_name)

			self._control.bg.bg_btn.map_img.map_info_txt.map_info_txt_1.text.text = self._config_data.item_drop_name
			self._control.bg.bottom_bg.item_name_mask.item_name_txt.text.text = self._config_data.title

			self._control.bg.bottom_bg.item_name_mask.textHorizonScroller:SetText(self._config_data.title)

			local var_4_4 = var_0_1:get_campaign_count()

			self._control.bg.bottom_bg.item_num_txt.text.text = self.__during_activity() and var_0_5("%s/%s", 12 - var_4_4, 12) or var_0_5("%s/%s", (8 - var_4_4 <= 0 or nil) and 0, 8)
			self._control.bg.bg_btn.map_img.oil_txt.text.text = self._config_data.product_award[4].count
			self._control.bg.bg_btn.map_img.bullet_txt.text.text = self._config_data.product_award[3].count
			self._control.bg.bg_btn.map_img.steel_txt.text.text = self._config_data.product_award[2].count
			self._control.bg.bg_btn.map_img.alum_txt.text.text = self._config_data.product_award[1].count
			self._control.bg.bg_btn.map_img.image.sprite = self:loadSprite(var_0_5(var_0_6.pve_compaign_map, arg_4_1.cell_index, self._difficulty))
		end

		self._control.bg.uITweenSequence:Play(function()
			if arg_4_2 then
				arg_4_2()
			end
		end)
	end

	function arg_1_0.__during_activity(arg_6_0)
		local var_6_0 = var_0_1:get_campaign_refresh_time() or lx.ServerTime:getUtcTime()
		local var_6_1 = var_0_8.find_object_by_id(10)

		return var_6_1.content.startTime <= var_6_0 and var_6_0 < var_6_1.content.endTime
	end

	function arg_1_0:__check_remake_ship()
		local var_7_0 = var_0_1:get_campaign_members(self._map_id)
		local var_7_1 = false

		if var_7_0 and next(var_7_0) then
			for iter_7_0, iter_7_1 in ipairs(var_0_9.find_object_by_id(self._map_id).fleet_rule) do
				if iter_7_1 > 0 and var_7_0[iter_7_0] and var_7_0[iter_7_0] > 0 then
					local var_7_2 = var_0_1:find_character_by_id(var_7_0[iter_7_0])

					if not var_7_2 or var_7_2.type ~= iter_7_1 then
						var_7_0[iter_7_0] = 0
						var_7_1 = true
					end
				end
			end
		end

		if var_7_1 then
			var_0_1:req_CampaignTeamSaveReq({
				id = self._map_id,
				members = var_7_0
			})
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_8_0)
	local var_8_0 = var_0_4:class("campaign_item")

	var_8_0._data = nil
	var_8_0._map_id = nil
	var_8_0._difficulty = nil
	var_8_0._config_data = {}

	return var_8_0
end

return var_0_0
