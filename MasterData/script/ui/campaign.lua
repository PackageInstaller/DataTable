local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_6 = UnityEngine.Vector2
local var_0_7 = gameconfig.map_campaign_config
local var_0_8 = table.insert
local var_0_9 = DG.Tweening.DOTween
local var_0_10 = lx.UserData

gamecore.UILoader:define("campaign", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)

		self._difficulty = arg_2_1 and arg_2_1 or 1

		local var_2_0 = var_0_3:get_account_id()
		local var_2_1 = var_0_3:get_server_name()

		if var_0_10:getKeyData("campaign" .. tostring(var_2_0) .. tostring(var_2_1)) == "1" or var_0_10:getKeyData("campaign" .. tostring(var_2_0) .. tostring(var_2_1)) == "2" then
			self._difficulty = tonumber(var_0_10:getKeyData("campaign" .. tostring(var_2_0) .. tostring(var_2_1)))
		end

		var_0_3:set_campaign_difficulty(self._difficulty)
		self:__init_panel()
	end

	function arg_1_0:destroy_panel()
		self:destroy()
	end

	function arg_1_0.__get_data_by_difficulty(arg_4_0, arg_4_1)
		local var_4_0 = {}

		for iter_4_0, iter_4_1 in ipairs(var_0_7.get_sequence()) do
			if iter_4_1.difficulty == arg_4_1 then
				var_0_8(var_4_0, iter_4_1.id)
			end
		end

		table.sort(var_4_0, function(arg_5_0, arg_5_1)
			return arg_5_0 < arg_5_1
		end)

		return var_4_0
	end

	function arg_1_0:__update_panel_type(arg_6_1)
		if arg_6_1 then
			self._difficulty = arg_6_1
		end

		local var_6_0 = self:__get_data_by_difficulty(self._difficulty)

		for iter_6_0 = 1, #self._item_tb do
			local var_6_1 = var_0_7.find_object_by_id(var_6_0[iter_6_0])

			self._item_tb[iter_6_0]:__updata_cell_info({
				config_data = var_6_1,
				difficulty = self._difficulty,
				cell_index = iter_6_0,
				map_id = var_6_1.map_id
			})
		end

		if self._difficulty == var_0_4.map_campaign_difficulty.normal then
			self._control.difficulty_text.text.text = var_0_1:getNowLang("pvecampaignhard") or var_0_1:getNowLang("pvecampaigneasy")
		end

		self._control.difficulty_btn.image.sprite = self:loadSprite((self._difficulty == var_0_4.map_campaign_difficulty.normal or nil) and (var_0_4.pve_campaign_hard_btn or var_0_4.pve_campaign_easy_btn))
		self._control.revent_txt.text.text = var_0_1:getNowLang("campaignreset")
	end

	function arg_1_0.__get_item_len(arg_7_0, arg_7_1)
		if not arg_7_1 or arg_7_1 == {} then
			return 0
		end

		return #arg_7_1
	end

	function arg_1_0:__create_campaign_item_to_num(arg_8_1)
		self._item_tb = self._item_tb or {}

		for iter_8_0 = 1, arg_8_1 - self:__get_item_len(self._item_tb) do
			local var_8_0 = self:loadUI("campaign_item")

			var_8_0._panel.transform:SetParent(self._control.scroll_view.viewport.content.transform, false)

			var_8_0._panel.transform.localPosition = var_0_6(1175, -15)

			self._control.scroll_view.viewport.content:GetComponent("UITweenSequence"):AddPlayMoveList(iter_8_0, var_8_0._panel.gameObject, 0.3, 245)
			self._control.scroll_view.viewport.content:GetComponent("UITweenSequence"):AddPlayMoveReverseList(iter_8_0, var_8_0._panel.gameObject, 0.3, 245)
			var_8_0:show()
			table.insert(self._item_tb, var_8_0)
		end
	end

	function arg_1_0:__init_panel(arg_9_1)
		local var_9_0 = true

		self:__create_campaign_item_to_num(5)
		self:__update_panel_type(self._difficulty)

		for iter_9_0, iter_9_1 in pairs((self:__get_data_by_difficulty(var_0_4.map_campaign_difficulty.difficult))) do
			local var_9_1 = var_0_7.find_object_by_id(iter_9_1)

			if var_9_1.need_campaign_level_id ~= 0 and var_0_3:is_campaijn_pass(var_9_1.need_campaign_level_id) then
				var_9_0 = false
			end
		end

		self._control.difficulty_btn:SetActive(not var_9_0)
		self._control.difficulty_text:SetActive(not var_9_0)

		self._control.user_core_bar.right_upon.dd_core.dd_txt.text.text = var_0_3:get_item_count(10441)
		self._control.user_core_bar.right_upon.ca_core.ca_txt.text.text = var_0_3:get_item_count(10341)
		self._control.user_core_bar.right_upon.bb_core.bb_txt.text.text = var_0_3:get_item_count(10241)
		self._control.user_core_bar.right_upon.cv_core.cv_txt.text.text = var_0_3:get_item_count(10141)
		self._control.user_core_bar.right_upon.ss_core.ss_txt.text.text = var_0_3:get_item_count(10541)
	end

	function arg_1_0:__play_scroll_animation()
		self:__clear_tweener()

		self._item_move_seq = self:autoKillDOTween(var_0_9.Sequence())

		for iter_10_0 = 1, 5 do
			self._item_move_seq:Append(self._item_tb[6 - iter_10_0]._panel:GetComponent("RectTransform"):DOAnchorPos(var_0_6(1751, -15), 0.1))
		end

		self._item_move_seq:Append(self._item_tb[5]._panel:GetComponent("RectTransform"):DOAnchorPos(var_0_6(1751, -15), 0):OnComplete(function()
			self:__update_panel_type(self._difficulty)
		end))

		for iter_10_1 = 1, 5 do
			self._item_move_seq:Append(self._item_tb[iter_10_1]._panel:GetComponent("RectTransform"):DOAnchorPos(var_0_6((iter_10_1 - 1) * 245, -15), 0.1))
		end

		self._item_move_seq:Play()
	end

	function arg_1_0:__clear_tweener()
		if self._item_move_seq and self._item_move_seq:IsPlaying() then
			self._item_move_seq:Kill()
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_13_0)
	local var_13_0 = var_0_2:class("campaign")

	var_13_0._data = nil
	var_13_0._item_tb = {}
	var_13_0._difficulty = var_0_4.map_campaign_difficulty.normal

	return var_13_0
end

return var_0_0
