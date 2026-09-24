local var_0_0 = {}
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.util_func
local var_0_6 = string.format
local var_0_7 = gameconfig.item_config
local var_0_8 = gameconfig.ship_config
local var_0_11 = table.insert
local var_0_12 = UnityEngine.Vector3
local var_0_13 = table.sort
local var_0_14 = gamecore.user
local var_0_15 = UnityEngine.Object.Instantiate

gamecore.UILoader:define("acquire_image", function(arg_1_0)
	function arg_1_0:Show_Info(arg_2_1)
		self:__init_panel(arg_2_1)

		self._control.main.confirm.text.text.text = var_0_2:getNowLang("ui_cbtn1")
		self._confirm_func = var_0_2:getNowLang("ui_cbtn1")
		self._control.main.top.title.text.text = var_0_2:getNowLang("ui_rewardtitle")

		self:setVisible(true)
	end

	function arg_1_0:__init_panel(arg_3_1)
		local var_3_0 = {}

		var_3_0 = arg_3_1.reward and next(arg_3_1.reward) and arg_3_1.reward or arg_3_1
		self._control.content = self._control.main.reduce_cd.rewards.scrollview.content

		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		self._control.main.top.title.three_point.gameObject:SetActive(true)
		self._control.main.reduce_cd:SetActive(true)
		self._control.main:SetActive(true)

		self._control.main.transform.localScale = var_0_12.New(1, 1, 1)

		self._control.main.confirm:SetActive(true)
		self._control.main.reduce_cd:SetActive(true)

		local var_3_1 = {
			self._control.main.reduce_cd.rewards.scrollview.content.reward_1,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_2,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_3,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_4,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_5,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_6,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_7,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_8,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_9,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_10,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_11,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_12,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_13,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_14,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_15,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_16,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_17,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_18,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_19,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_20,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_21,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_22,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_23,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_24,
			self._control.main.reduce_cd.rewards.scrollview.content.reward_25
		}
		local var_3_2 = var_3_1[1]

		for iter_3_0 = 1, 15 do
			var_3_1[iter_3_0].gameObject:SetActive(false)
		end

		local var_3_3 = {}
		local var_3_4 = {}

		for iter_3_1, iter_3_2 in pairs(var_3_0) do
			var_0_11(var_3_4, iter_3_2)
		end

		local var_3_6 = ""
		local var_3_7 = {}
		local var_3_8 = {}
		local var_3_9 = {}
		local var_3_10 = {}
		local var_3_11 = {}
		local var_3_12 = {}
		local var_3_13 = {}
		local var_3_14 = 1
		local var_3_15 = 1
		local var_3_16 = 1
		local var_3_17 = 1
		local var_3_18 = 1
		local var_3_19 = 1
		local var_3_20 = 1

		for iter_3_3, iter_3_4 in pairs(var_3_4) do
			if iter_3_4.type ~= 4 and iter_3_4.type ~= 1 and iter_3_4.type ~= 13 then
				var_0_11(var_3_3, iter_3_4)
			end

			if iter_3_4.type == 13 then
				local var_3_22 = var_0_8.find_object_by_cid(var_0_14:find_abyss_character_by_id(iter_3_4.id).cid)

				if var_3_22.cid == 10004418 then
					var_0_11(var_3_7, iter_3_4)

					var_3_14 = iter_3_4.id
				end

				if var_3_22.cid == 10004518 then
					var_0_11(var_3_8, iter_3_4)

					var_3_15 = iter_3_4.id
				end

				if var_3_22.cid == 10004618 then
					var_0_11(var_3_9, iter_3_4)

					var_3_16 = iter_3_4.id
				end

				if var_3_22.cid == 10004718 then
					var_0_11(var_3_10, iter_3_4)

					var_3_17 = iter_3_4.id
				end

				if var_3_22.cid == 10004818 then
					var_0_11(var_3_11, iter_3_4)

					var_3_18 = iter_3_4.id
				end

				if var_3_22.cid == 10004918 then
					var_0_11(var_3_12, iter_3_4)

					var_3_19 = iter_3_4.id
				end

				if var_3_22.cid == 10005018 then
					var_0_11(var_3_13, iter_3_4)

					var_3_20 = iter_3_4.id
				end
			end
		end

		if #var_3_7 ~= 0 then
			var_0_11(var_3_3, {
				is_new = false,
				type = 13,
				count = #var_3_7,
				id = var_3_14
			})
		end

		if #var_3_8 ~= 0 then
			var_0_11(var_3_3, {
				is_new = false,
				type = 13,
				count = #var_3_8,
				id = var_3_15
			})
		end

		if #var_3_9 ~= 0 then
			var_0_11(var_3_3, {
				is_new = false,
				type = 13,
				count = #var_3_9,
				id = var_3_16
			})
		end

		if #var_3_10 ~= 0 then
			var_0_11(var_3_3, {
				is_new = false,
				type = 13,
				count = #var_3_10,
				id = var_3_17
			})
		end

		if #var_3_11 ~= 0 then
			var_0_11(var_3_3, {
				is_new = false,
				type = 13,
				count = #var_3_11,
				id = var_3_18
			})
		end

		if #var_3_12 ~= 0 then
			var_0_11(var_3_3, {
				is_new = false,
				type = 13,
				count = #var_3_12,
				id = var_3_19
			})
		end

		if #var_3_13 ~= 0 then
			var_0_11(var_3_3, {
				is_new = false,
				type = 13,
				count = #var_3_13,
				id = var_3_20
			})
		end

		for iter_3_5, iter_3_6 in pairs(var_3_3) do
			if iter_3_6.type == 13 then
				iter_3_6.id = var_0_14:find_abyss_character_by_id(iter_3_6.id).cid
			end
		end

		var_0_13(var_3_3, function(arg_4_0, arg_4_1)
			return arg_4_0.id < arg_4_1.id
		end)

		if not self._recycle_obj_list then
			self._recycle_obj_list = {}
		else
			for iter_3_7, iter_3_8 in pairs(self._recycle_obj_list) do
				iter_3_8.gameObject:SetActive(false)
			end
		end

		for iter_3_9 = 1, #var_3_3 do
			if var_3_3[iter_3_9].type == 13 then
				local var_3_23 = var_0_8.find_object_by_cid(var_3_3[iter_3_9].id)

				if var_3_23 then
					var_3_6 = var_3_23.title
					var_3_1[iter_3_9].icon.image.sprite = self:loadSprite(var_0_6(var_0_4.icon.item_icon, var_3_23.cid))
				end

				var_3_1[iter_3_9].bg.image.sprite = self:loadSprite(var_0_4.abyss_ship_back_ground_0)
				var_3_1[iter_3_9].transform:Find("number"):GetComponent("Text").text = var_3_3[iter_3_9].count
			else
				if not var_3_1[iter_3_9] then
					var_3_1[iter_3_9] = self._recycle_obj_list[iter_3_9] or var_0_15(var_3_2, var_3_2.transform.parent)
					var_3_1[iter_3_9].name = "reward_" .. iter_3_9
					self._recycle_obj_list[iter_3_9] = var_3_1[iter_3_9]
				end

				local var_3_24 = var_3_1[iter_3_9].transform:Find("bg"):GetComponent("Image")
				local var_3_25 = var_3_1[iter_3_9].transform:Find("icon"):GetComponent("Image")

				if var_3_3[iter_3_9].type == 2 then
					var_3_6 = var_0_7.find_object_by_cid(var_3_3[iter_3_9].id).title
					var_3_24.sprite = self:loadSprite(var_0_4.ship_equip_pic.have_sign)
					var_3_25.sprite = self:loadSprite(var_0_6(var_0_4.icon.item_icon, var_3_3[iter_3_9].id))
					var_3_1[iter_3_9].transform:Find("number"):GetComponent("Text").text = var_3_3[iter_3_9].count
				elseif var_3_3[iter_3_9].type == 5 then
					local var_3_26 = gameconfig.furniture_config.find_object_by_cid(var_3_3[iter_3_9].id)

					var_3_24.sprite = self:loadSprite(var_0_4.ship_equip_pic.have_sign)
					var_3_25.sprite = self:loadSprite((var_0_4:get_ship_icon(var_0_4.furniture_s_img, var_3_26.icon)))
					var_3_1[iter_3_9].transform:Find("number"):GetComponent("Text").text = var_3_3[iter_3_9].count
					var_3_6 = var_3_26.title
				elseif var_3_3[iter_3_9].type == 6 then
					local var_3_27 = gameconfig.cook_book_config.find_object_by_cid(var_3_3[iter_3_9].id)

					var_3_24.sprite = self:loadSprite(var_0_4.ship_equip_pic.have_sign)
					var_3_25.sprite = self:loadSprite(var_0_6(var_0_4.cook_book_icon, var_3_27.icon))
					var_3_1[iter_3_9].transform:Find("number"):GetComponent("Text").text = var_3_3[iter_3_9].count
					var_3_6 = var_3_27.title
				end
			end

			var_3_1[iter_3_9].gameObject:SetActive(true)
			var_3_1[iter_3_9].transform:Find("title_mask"):GetComponent("TextHorizonScroller"):SetText(var_3_6)

			var_3_1[iter_3_9].transform:Find("number"):GetComponent("Text").text = var_3_3[iter_3_9].count == 1 and "" or var_0_5.get_simplify_num(var_3_3[iter_3_9].count)
		end

		if #var_3_3 <= 5 then
			self._control.main.reduce_cd.rewards.scrollview:GetComponent("ScrollRect").enabled = false
			self._control.main.confirm.rectTransform.anchoredPosition = Vector2(179.5, 46)

			self._control.main.main_bg_1:SetActive(true)
			self._control.main.main_bg_2:SetActive(false)
			self._control.main.main_bg_3:SetActive(false)

			self._control.main.main_bg_1.rectTransform.anchoredPosition = Vector2(272.8, 135)
			self._control.main.top.rectTransform.anchoredPosition = Vector2(272.8, 283.2)
			self._control.main.confirm.rectTransform.anchoredPosition = Vector2(179.5, 34)
			self._control.main.reduce_cd.rectTransform.anchoredPosition = Vector2(15, 87.34)
		elseif #var_3_3 > 5 and #var_3_3 <= 10 then
			self._control.main.reduce_cd.rewards.scrollview:GetComponent("ScrollRect").enabled = false
			self._control.main.confirm.rectTransform.anchoredPosition = Vector2(200, -90)

			self._control.main.main_bg_1:SetActive(false)
			self._control.main.main_bg_2:SetActive(true)
			self._control.main.main_bg_3:SetActive(false)

			self._control.main.main_bg_2.rectTransform.anchoredPosition = Vector2(272.85, 75)
			self._control.main.rectTransform.anchoredPosition = Vector2(0, 40)
			self._control.main.top.rectTransform.anchoredPosition = Vector2(272.8, 283.2)
			self._control.main.reduce_cd.rectTransform.anchoredPosition = Vector2(15, 87.34)
		elseif #var_3_3 > 10 and #var_3_3 <= 15 then
			self._control.main.reduce_cd.rewards.scrollview:GetComponent("ScrollRect").enabled = false
			self._control.main.confirm.rectTransform.anchoredPosition = Vector2(200, -120)

			self._control.main.main_bg_1:SetActive(false)
			self._control.main.main_bg_2:SetActive(false)
			self._control.main.main_bg_3:SetActive(true)

			self._control.main.main_bg_3.rectTransform.anchoredPosition = Vector2(272.8, 115)
			self._control.main.top.rectTransform.anchoredPosition = Vector2(272.8, 395)
			self._control.main.reduce_cd.rectTransform.anchoredPosition = Vector2(15, 195)
		else
			self._control.main.reduce_cd.rewards.scrollview:GetComponent("ScrollRect").enabled = true
			self._control.main.confirm.rectTransform.anchoredPosition = Vector2(200, -120)

			self._control.main.main_bg_1:SetActive(false)
			self._control.main.main_bg_2:SetActive(false)
			self._control.main.main_bg_3:SetActive(true)

			self._control.main.main_bg_3.rectTransform.anchoredPosition = Vector2(272.8, 115)
			self._control.main.top.rectTransform.anchoredPosition = Vector2(272.8, 395)
			self._control.main.reduce_cd.rectTransform.anchoredPosition = Vector2(15, 195)
		end
	end

	function arg_1_0:__init_more_awards(arg_5_1)
		self._control.main.confirm.rectTransform.anchoredPosition = Vector2(200, -120)

		self._control.main.main_bg_1:SetActive(false)
		self._control.main.main_bg_2:SetActive(false)
		self._control.main.main_bg_3:SetActive(true)

		self._control.main.main_bg_3.rectTransform.anchoredPosition = Vector2(272.8, 115)
		self._control.main.top.rectTransform.anchoredPosition = Vector2(272.8, 395)
		self._control.main.reduce_cd.rectTransform.anchoredPosition = Vector2(15, 195)
	end

	function arg_1_0:_play_into_se(arg_6_1)
		self:playSE(arg_6_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_7_0)
	local var_7_0 = var_0_3:class("acquire_image")

	gamecore.extend_obj(var_7_0)

	return var_7_0
end

return var_0_0
