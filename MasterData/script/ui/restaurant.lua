local var_0_0 = {}
local var_0_1 = Vector3
local var_0_2 = gamecore.user
local var_0_3 = gamecore.prompt
local var_0_4 = table.remove
local var_0_5 = table.insert
local var_0_6 = gamecore.Language
local var_0_7 = gamecore.UILoader
local var_0_8 = string.format
local var_0_9 = DG.Tweening.DOTween
local var_0_10 = gamecore.util_func
local var_0_11 = gameenum.common_type
local var_0_12 = gameconfig.ship_config
local var_0_13 = gameconfig.skin_config
local var_0_14 = gamecore.AudioManager
local var_0_17 = Spine.Unity.SkeletonGraphic
local var_0_18 = gameconfig.furniture_config
local var_0_19 = gameconfig.cook_book_config
local var_0_20 = gameconfig.cook_style_config
local var_0_21 = gameconfig.ship_pve_active_config
local var_0_22 = {
	normal2 = "normal2",
	start = "start",
	normal = "normal",
	eat = "eat"
}
local var_0_23 = {
	stand = "stand1",
	sit = "sit2",
	walk = "walk_slow"
}
local var_0_24 = {
	normal = "normal",
	bathroom = "bathroom"
}
local var_0_25 = {
	love = "love",
	love_end = "end"
}
local var_0_26 = {
	{
		Vector3.New(1280, 60),
		Vector3.New(1180, 60),
		Vector3.New(1180, -35),
		Vector3.New(1112, -35)
	},
	{
		Vector3.New(1390, 60),
		Vector3.New(815, 60),
		Vector3.New(815, -35),
		Vector3.New(870, -35)
	},
	{
		Vector3.New(1500, 60),
		Vector3.New(815, 60),
		Vector3.New(815, -35),
		Vector3.New(753, -35)
	},
	{
		Vector3.New(1610, 60),
		Vector3.New(457, 60),
		Vector3.New(457, -35),
		Vector3.New(510, -35)
	},
	{
		Vector3.New(1720, 60),
		Vector3.New(457, 60),
		Vector3.New(457, -35),
		Vector3.New(393, -35)
	},
	{
		Vector3.New(1830, 60),
		Vector3.New(75, 60),
		Vector3.New(75, -35),
		Vector3.New(145, -35)
	}
}
local var_0_27 = {
	{
		Vector3.New(1112, 18),
		Vector3.New(871, 18),
		Vector3.New(750, 18),
		Vector3.New(511, 18),
		Vector3.New(390, 18),
		Vector3.New(149, 18)
	},
	{
		Vector3.New(1112, -10),
		Vector3.New(871, -10),
		Vector3.New(750, -10),
		Vector3.New(511, -10),
		Vector3.New(390, -10),
		Vector3.New(149, -10)
	},
	{
		Vector3.New(1112, 10),
		Vector3.New(871, 10),
		Vector3.New(750, 10),
		Vector3.New(511, 10),
		Vector3.New(390, 10),
		Vector3.New(149, 10)
	}
}
local var_0_28 = {
	{
		Vector3.New(991, 27),
		Vector3.New(632, 27),
		Vector3.New(271, 27)
	},
	{
		Vector3.New(991, 53),
		Vector3.New(632, 53),
		Vector3.New(271, 53)
	},
	{
		Vector3.New(991, 35),
		Vector3.New(632, 35),
		Vector3.New(271, 35)
	}
}

gamecore.UILoader:define("restaurant", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)
		var_0_2:set_to_cook(true)

		arg_2_1 = arg_2_1 or var_0_11.enter_restaurant_type.myself
		self._enter_type = arg_2_1
		self._friend_data = arg_2_2

		self:__init_panel()
		self:__preload_ship()
	end

	function arg_1_0:__onUpdate()
		if self._start_buff then
			local var_3_0 = self._buff_info.end_time - lx.ServerTime:getUtcTime()
			local var_3_1 = ""

			if var_3_0 > 59 then
				var_3_1 = var_0_8("%dm", var_3_0 / 60)
			elseif var_3_0 <= 59 and var_3_0 >= 0 then
				var_3_1 = var_0_8("%ds", var_3_0)
			else
				self._start_buff = false

				self._control.buff_btn:SetActive(false)
			end

			self._control.buff_btn.time.text.text = var_3_1
		end
	end

	function arg_1_0:__judge_ship_can_selected(arg_4_1, arg_4_2)
		local var_4_0 = var_0_10.dict_lenght(arg_4_1)

		if var_4_0 <= 0 then
			return arg_4_2
		end

		local var_4_1 = lan_rand(1, var_4_0)

		arg_4_1 = var_0_10.dict_to_array(arg_4_1)

		local var_4_2 = arg_4_1[var_4_1]
		local var_4_3 = true
		local var_4_4 = var_0_12.find_object_by_cid(var_0_2:find_character_by_id(self._user_data.chef).cid)
		local var_4_5 = var_0_12.find_object_by_cid(arg_4_1[var_4_1].cid)

		if var_4_5.cid == var_4_4.cid or var_4_5.evo_cid == var_4_4.evo_cid then
			var_4_3 = false
		end

		for iter_4_0, iter_4_1 in pairs(arg_4_2) do
			local var_4_6 = var_0_12.find_object_by_cid(iter_4_1.cid)

			if var_4_6.cid == var_4_5.cid or var_4_6.evo_cid == var_4_5.evo_cid then
				var_4_3 = false
			end
		end

		if var_4_3 then
			var_0_5(arg_4_2, var_4_2)

			if #arg_4_2 >= 6 then
				return arg_4_2
			end
		end

		var_0_4(arg_4_1, var_4_1)

		if var_4_0 <= 0 then
			return arg_4_2
		end

		return self:__judge_ship_can_selected(arg_4_1, arg_4_2)
	end

	function arg_1_0:__random()
		local var_5_0 = self:__judge_ship_can_selected(var_0_2:get_character_list(), {})

		return var_5_0 and var_0_10.little_clone(var_5_0) or {}
	end

	function arg_1_0.__play_animation(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		if arg_6_4 then
			local var_6_0 = arg_6_1.state.Complete

			local function var_6_1()
				arg_6_4()

				arg_6_1.state.Complete = var_6_0
			end

			var_6_0 = arg_6_1.state.Complete + var_6_1
			arg_6_1.state.Complete = arg_6_1.state.Complete + var_6_1
			var_6_0 = var_6_0 - var_6_1
		end

		if arg_6_1.AnimationState ~= nil then
			arg_6_1.AnimationState:SetAnimation(0, arg_6_2, arg_6_3)
		end
	end

	function arg_1_0:__init_ske(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		local var_8_0
		local var_8_1

		if arg_8_3 then
			var_8_0 = var_0_12.find_object_by_cid(arg_8_3).pic_id
			var_8_1 = arg_8_4
		else
			local var_8_2 = var_0_2:find_character_by_id(arg_8_2)

			var_8_0 = var_0_12.find_object_by_cid(var_8_2.cid).pic_id
			var_8_1 = var_8_2.skin
		end

		if var_8_1 ~= 0 then
			var_8_0 = var_0_13.find_object_by_cid(var_8_1).icon
		end

		arg_8_1.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(var_0_11:get_ship_spine(var_0_11.common_icon.common_ship_q_asset, var_8_0))
		arg_8_1.skeletonGraphic.material = self:loadMaterial(var_0_11:get_ship_spine(var_0_11.common_icon.common_ship_q_mat, var_8_0))
		arg_8_1.skeletonGraphic.initialSkinName = var_0_24.normal

		arg_8_1.skeletonGraphic:Initialize(true)
	end

	function arg_1_0:__show_restaurant_last(arg_9_1)
		for iter_9_0, iter_9_1 in pairs(self._last_list) do
			iter_9_1:SetActive(false)
		end

		self._last_list[arg_9_1]:SetActive(true)

		local var_9_0 = app:getSystem():getChannel()

		if arg_9_1 == 2 and (var_9_0 == "hm_android_jp" or var_9_0 == "hm_ios_jp") then
			self._control.type_2.last_name.rectTransform.anchoredPosition = Vector2(818, 620)
		end
	end

	function arg_1_0:__cookbook_anim()
		self:__canvas_render_mode(false)

		if self._cook_seq then
			self._cook_seq:Kill()

			self._cook_seq = nil
		end

		self._control.food_list.rectTransform.anchoredPosition = var_0_1.New(self._control.food_list.rectTransform.anchoredPosition.x, 50, self._control.food_list.rectTransform.anchoredPosition.z)
		self._cook_seq = self:autoKillDOTween(var_0_9.Sequence())

		self._cook_seq:Append(self._control.food_list.rectTransform:DOLocalMoveY(75, 9):SetEase(DG.Tweening.Ease.Linear))
		self._cook_seq:Append(self._control.food_list.rectTransform:DOLocalMoveY(50, 9):SetEase(DG.Tweening.Ease.Linear))
		self._cook_seq:SetLoops(-1)
	end

	function arg_1_0.__canvas_render_mode(arg_11_0, arg_11_1)
		var_0_7:getUIRoot().parent.transform:GetComponent("Canvas").pixelPerfect = arg_11_1
	end

	function arg_1_0:__set_furniture_by_style()
		local var_12_0 = 1

		var_12_0 = (self._now_style_id == 11145 or self._now_style_id == 11245 or self._now_style_id == 11345) and 1 or self._now_style_id == 11445 and 2 or self._now_style_id == 11545 and 3 or var_12_0

		local var_12_1 = var_0_20.find_object_by_cid(self._now_style_id).chair

		for iter_12_0, iter_12_1 in ipairs(self._chair_list) do
			iter_12_1.image.sprite = self:loadSprite(var_0_11:get_ship_icon(var_0_11.furniture_img, var_0_18.find_object_by_cid(var_12_1).icon))

			iter_12_1.image:SetNativeSize()

			iter_12_1.transform.localPosition = var_0_27[var_12_0][iter_12_0]
		end

		local var_12_2 = var_0_20.find_object_by_cid(self._now_style_id).table

		for iter_12_2, iter_12_3 in ipairs(self._table_list) do
			iter_12_3.image.sprite = self:loadSprite(var_0_11:get_ship_icon(var_0_11.furniture_img, var_0_18.find_object_by_cid(var_12_2).icon))

			iter_12_3.image:SetNativeSize()

			iter_12_3.transform.localPosition = var_0_28[var_12_0][iter_12_2]
		end
	end

	function arg_1_0:__ship_enter_anim()
		self:__anim_seq(1, 100, 95, 68)
		self:__anim_seq(2, 575, 95, 55)
		self:__anim_seq(3, 685, 95, 62)
		self:__anim_seq(4, 1153, 95, 53)
		self:__anim_seq(5, 1263, 95, 64)
		self:__anim_seq(6, 1750, 95, 70)
	end

	function arg_1_0:__anim_seq(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		if not self._my_role_list[arg_14_1] then
			return
		end

		local var_14_0 = 40
		local var_14_1 = self._my_role_list[arg_14_1].transform
		local var_14_2 = self._my_role_list[arg_14_1].transform:Find("player"):GetComponent(typeof(var_0_17))

		self:__play_animation(var_14_2, var_0_23.walk, true, nil)

		local var_14_3 = self:autoKillDOTween(var_0_9.Sequence())

		self._girl_seq_list[arg_14_1] = var_14_3

		var_14_3:Append(self._my_role_list[arg_14_1].transform:DOLocalMove(var_0_26[arg_14_1][2], arg_14_2 / var_14_0):SetEase(DG.Tweening.Ease.Linear))
		var_14_3:Append(self._my_role_list[arg_14_1].transform:DOLocalMove(var_0_26[arg_14_1][3], arg_14_3 / var_14_0):SetEase(DG.Tweening.Ease.Linear))
		var_14_3:AppendCallback(function()
			if not var_14_1:Equals(nil) then
				var_14_1:SetAsLastSibling()

				if arg_14_1 % 2 == 0 then
					var_14_1.rotation = var_0_1.New(0, 180, 0)
				end
			end
		end)
		var_14_3:Append(self._my_role_list[arg_14_1].transform:DOLocalMove(var_0_26[arg_14_1][4], arg_14_4 / var_14_0):SetEase(DG.Tweening.Ease.Linear))
		var_14_3:AppendCallback(function()
			self:__play_animation(var_14_2, var_0_23.sit, true, nil)
		end)
		var_14_3:Play()
	end

	function arg_1_0:__init_eat_role_list()
		self._my_role_list = {}

		local var_17_1 = self:__random()

		for iter_17_0, iter_17_1 in ipairs(self._girl_list) do
			if var_17_1[iter_17_0] then
				var_0_5(self._my_role_list, iter_17_1)
				self:__add_skelegraphic(iter_17_1, var_17_1[iter_17_0].id)
			end
		end
	end

	function arg_1_0:__add_skelegraphic(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
		local var_18_0
		local var_18_1

		if arg_18_3 then
			var_18_0 = var_0_12.find_object_by_cid(arg_18_3).pic_id
			var_18_1 = arg_18_4
		else
			local var_18_2 = var_0_2:find_character_by_id(arg_18_2)

			var_18_0 = var_0_12.find_object_by_cid(var_18_2.cid).pic_id
			var_18_1 = var_18_2.skin
		end

		local var_18_3 = self:createGameObject((var_0_11:get_ship_spine(var_0_11.dormitory_const.ship_spine_prefab_path, (var_18_1 ~= 0 or nil) and var_0_13.find_object_by_cid(var_18_1).icon)))

		var_18_3.name = "player"

		var_18_3.transform:SetParent(arg_18_1.transform, false)
		table.insert(self._character_spine_list, var_18_3)
	end

	function arg_1_0:play_cooking_result_ani()
		self._food_animation_step = 2

		local var_19_0 = self:autoKillDOTween(var_0_9.Sequence())

		self._control.cooking_bg.cook_result:SetActive(true)

		local var_19_1 = self._control.cooking_bg.cook_result.transform

		self._control.cooking_bg.cook_result.transform.localScale = var_0_1(0, 0, 0)

		var_19_0:Append(self._control.cooking_bg.cook_result.transform:DOScale(var_0_1(1.3, 1.3, 1.3), 0.1):SetAutoKill(true))
		var_19_0:Append(self._control.cooking_bg.cook_result.transform:DOScale(var_0_1(0.8, 0.8, 0.8), 0.1):SetAutoKill(true))
		var_19_0:Append(self._control.cooking_bg.cook_result.transform:DOScale(var_0_1(1, 1, 1), 0.1):SetAutoKill(true))
		self._control.cooking_bg.cook_tip:SetActive(true)
		var_19_0:AppendInterval(2)
		var_19_0:AppendCallback(function()
			var_19_0:Append(var_19_1:DOScale(var_0_1(0, 0, 0), 0.2):SetAutoKill(true))
			self._control.cooking_bg.cook_tip:SetActive(false)
			var_19_0:Kill()
		end)
		var_19_0:Play()
	end

	function arg_1_0:play_cooking2_result_ani()
		local var_21_0 = self:autoKillDOTween(var_0_9.Sequence())

		self._control.cooking_skip_bg.cook_result:SetActive(true)

		local var_21_1 = self._control.cooking_skip_bg.cook_result.transform

		self._control.cooking_skip_bg.cook_result.transform.localScale = var_0_1(0, 0, 0)

		var_21_0:Append(self._control.cooking_skip_bg.cook_result.transform:DOScale(var_0_1(1.3, 1.3, 1.3), 0.1):SetAutoKill(true))
		var_21_0:Append(self._control.cooking_skip_bg.cook_result.transform:DOScale(var_0_1(0.8, 0.8, 0.8), 0.1):SetAutoKill(true))
		var_21_0:Append(self._control.cooking_skip_bg.cook_result.transform:DOScale(var_0_1(1, 1, 1), 0.1):SetAutoKill(true))
		self._control.cooking_skip_bg.cook_tip:SetActive(true)
		var_21_0:AppendInterval(2)
		var_21_0:AppendCallback(function()
			var_21_0:Append(var_21_1:DOScale(var_0_1(0, 0, 0), 0.2):SetAutoKill(true))
			self._control.cooking_skip_bg.cook_tip:SetActive(false)
			var_21_0:Kill()
		end)
		var_21_0:Play()
	end

	function arg_1_0:__role_love_anim()
		for iter_23_0, iter_23_1 in ipairs(self._my_role_list) do
			local var_23_0 = iter_23_1.love.skeletonGraphic
			local var_23_1 = self:autoKillDOTween(var_0_9.Sequence())

			self._love_seq_list[iter_23_0] = var_23_1

			var_23_1:AppendCallback(function()
				iter_23_1.love:SetActive(true)
				self:__play_animation(var_23_0, var_0_25.love, false, nil)
			end)
			var_23_1:AppendInterval(0.667)
			var_23_1:AppendCallback(function()
				self:__play_animation(var_23_0, var_0_25.love_end, false, nil)
			end)
			var_23_1:AppendInterval(0.367)
			var_23_1:AppendCallback(function()
				iter_23_1.love:SetActive(false)
			end)
			var_23_1:Play()
		end
	end

	function arg_1_0.__get_txt(arg_27_0, arg_27_1)
		return (string.gsub(arg_27_1, "%^C[^%^]+", function(arg_28_0)
			return string.format("<color=#%s>%s</color>", string.sub(arg_28_0, 3, 10), (string.sub(arg_28_0, 19, #arg_28_0)))
		end))
	end

	function arg_1_0:sort_cookbook_by_rule()
		local var_29_0 = var_0_2:get_restaurant_use_cookbook()
		local var_29_1 = {}

		for iter_29_0, iter_29_1 in ipairs(self._use_cookbook_list) do
			local var_29_3 = false

			for iter_29_2, iter_29_3 in pairs(var_29_0) do
				if iter_29_1.id == iter_29_3.id then
					var_29_3 = true

					break
				end
			end

			if var_29_3 then
				var_0_5(var_29_1, iter_29_1)
			end
		end

		for iter_29_4, iter_29_5 in ipairs(var_29_0) do
			local var_29_4 = false

			for iter_29_6, iter_29_7 in pairs(var_29_1) do
				if iter_29_5.id == iter_29_7.id then
					var_29_4 = true

					break
				end
			end

			if not var_29_4 then
				var_0_5(var_29_1, iter_29_5)
			end
		end

		self._use_cookbook_list = var_29_1

		return var_29_1
	end

	function arg_1_0:__show_restaurant_last_count()
		self._now_last_count = (self._enter_type == var_0_11.enter_restaurant_type.friend or self._enter_type == var_0_11.enter_restaurant_type.cardbook_and_no_friend or self._enter_type == var_0_11.enter_restaurant_type.cardbook or self._enter_type == var_0_11.enter_restaurant_type.tower) and self._user_data.friend_cook_count or self._user_data.cook_count

		for iter_30_0, iter_30_1 in pairs(self._last_list) do
			if iter_30_1.activeSelf then
				iter_30_1.last_count.image.sprite = self:loadSprite(var_0_11:get_format_url(var_0_11.restaurant_last, self._now_style_id .. "_" .. 3 - self._now_last_count))
			end
		end

		if self._enter_type == var_0_11.enter_restaurant_type.friend then
			self._control.goodat_btn:SetActive(false)
		else
			self._control.goodat_btn:SetActive(true)
		end
	end

	function arg_1_0:set_chef()
		if self._enter_type == var_0_11.enter_restaurant_type.friend or self._enter_type == var_0_11.enter_restaurant_type.tower and self._friend_data._is_friend or self._enter_type == var_0_11.enter_restaurant_type.cardbook and self._friend_data._is_friend then
			self._control.cooker:SetActive(true)
			self:__init_ske(self._control.cooker, nil, self._friend_data.cook.chef, self._friend_data.cook.skin)
		elseif self._enter_type == var_0_11.enter_restaurant_type.cardbook and not self._friend_data._is_friend or self._enter_type == var_0_11.enter_restaurant_type.cardbook_and_no_friend or self._enter_type == var_0_11.enter_restaurant_type.tower and not self._friend_data._is_friend then
			self._control.cooker:SetActive(false)

			return
		else
			self._control.cooker:SetActive(true)
			self:__init_ske(self._control.cooker, self._user_data.chef)
		end
	end

	function arg_1_0:set_buff()
		self._start_buff = false
		self._buff_info = var_0_2:get_restaurant_cookbook_buff()

		if self._buff_info then
			if lx.ServerTime:getUtcTime() < self._buff_info.end_time then
				self._buff_end_time = self._buff_info.end_time
				self._start_buff = true

				self._control.buff_btn:SetActive(true)
			else
				self._control.buff_btn:SetActive(false)
			end
		else
			self._control.buff_btn:SetActive(false)
		end
	end

	function arg_1_0:set_popular()
		local var_33_0
		local var_33_1 = 0

		var_33_0 = self._enter_type == var_0_11.enter_restaurant_type.friend and self._friend_data.cook.popularity or var_0_2:get_use_info_data().cook_popularity

		for iter_33_0, iter_33_1 in ipairs(self._restaurant_style_config) do
			if iter_33_0 > #self._restaurant_style_config - 1 then
				if var_33_0 >= iter_33_1.total_popularity then
					var_33_1 = #self._restaurant_style_config
				end

				break
			end

			if var_33_0 >= iter_33_1.total_popularity and var_33_0 < self._restaurant_style_config[iter_33_0 + 1].total_popularity then
				var_33_1 = iter_33_0
			end
		end

		local var_33_2 = 0
		local var_33_3 = 0

		if var_33_1 < #self._restaurant_style_config then
			if self._restaurant_style_config[var_33_1].total_popularity < var_33_0 and var_33_0 < self._restaurant_style_config[var_33_1 + 1].total_popularity then
				var_33_2 = var_33_0 - self._restaurant_style_config[var_33_1].total_popularity
				var_33_3 = self._restaurant_style_config[var_33_1 + 1].popularity
			elseif var_33_0 == self._restaurant_style_config[var_33_1].total_popularity then
				var_33_2 = 0
				var_33_3 = self._restaurant_style_config[var_33_1 + 1].popularity
			end
		elseif var_33_1 == #self._restaurant_style_config then
			var_33_2 = var_33_0 - self._restaurant_style_config[var_33_1 - 1].total_popularity
			var_33_3 = self._restaurant_style_config[var_33_1].popularity or var_33_3
		end

		self._control.popular_bg.bar.image.fillAmount = var_33_2 / var_33_3
		self._control.popular_bg.popular_num.text.text = var_33_2 .. "/" .. var_33_3
	end

	function arg_1_0:__set_cookbook_used()
		local var_34_0

		for iter_34_0, iter_34_1 in pairs(self._food_list) do
			iter_34_1:SetActive(false)
		end

		if self._enter_type == var_0_11.enter_restaurant_type.friend or self._enter_type == var_0_11.enter_restaurant_type.tower and self._friend_data._is_friend or self._enter_type == var_0_11.enter_restaurant_type.cardbook and self._friend_data._is_friend then
			var_34_0 = self._friend_data.cook.cookbook
		elseif self._enter_type == var_0_11.enter_restaurant_type.cardbook and not self._friend_data._is_friend or self._enter_type == var_0_11.enter_restaurant_type.cardbook_and_no_friend or self._enter_type == var_0_11.enter_restaurant_type.tower and not self._friend_data._is_friend then
			return
		else
			var_34_0 = var_0_2:get_restaurant_use_cookbook()
		end

		if #var_34_0 == 0 then
			return
		end

		self._now_cookbook_list = var_34_0

		for iter_34_2, iter_34_3 in ipairs(var_34_0) do
			local var_34_1 = var_0_19.find_object_by_cid(iter_34_3.id)

			self._food_list[iter_34_2].icon.image.sprite = self:loadSprite(var_0_11:get_format_url(var_0_11.cook_book_icon, var_34_1.icon))

			self._food_list[iter_34_2].icon.image:SetNativeSize()
			self._food_list[iter_34_2].food_name_mask:GetComponent("TextHorizonScroller"):SetText(var_34_1.title)

			self._food_list[iter_34_2].food_name_mask.food_name_1.text.text = var_34_1.title

			self._food_list[iter_34_2]:SetActive(true)
		end

		self:__cookbook_anim()
	end

	function arg_1_0:set_restaurant_style()
		self._user_data = var_0_2:get_use_info_data()
		self._now_style_id = (self._enter_type == var_0_11.enter_restaurant_type.friend or self._enter_type == var_0_11.enter_restaurant_type.tower and self._friend_data._is_friend or self._enter_type == var_0_11.enter_restaurant_type.cardbook and self._friend_data._is_friend) and self._friend_data.cook.style or (self._enter_type == var_0_11.enter_restaurant_type.cardbook or self._enter_type == var_0_11.enter_restaurant_type.cardbook_and_no_friend or self._enter_type == var_0_11.enter_restaurant_type.tower) and 11145 or self._user_data.cook_style
		self._control.bg.image.sprite = self:loadSprite(var_0_11:get_format_url(var_0_11.restaurant_bg, self._now_style_id))
		self._control.restaurant_bar.image.sprite = self:loadSprite(var_0_11:get_format_url(var_0_11.restaurant_bar, self._now_style_id))

		local var_35_0 = 0
		local var_35_1 = var_0_20.find_object_by_cid(self._now_style_id).type

		if var_35_1 == 1 then
			var_35_0 = 1

			self:destroy_sea()
		elseif var_35_1 == 2 then
			var_35_0 = 2

			self:destroy_sea()
		else
			var_35_0 = 3

			if not self._sea_obj then
				self._sea_obj = self:createGameObject(var_0_11.common_icon.cookbook_1145)

				self._sea_obj.transform:SetParent(self._control.sea_anim.transform, false)
			end
		end

		self:__show_restaurant_last(var_35_0)
		self:__show_restaurant_last_count()
		self:__set_furniture_by_style()
	end

	function arg_1_0:destroy_sea()
		if self._sea_obj then
			self:destroyGameObject(self._sea_obj)

			self._sea_obj = nil
		end
	end

	function arg_1_0:__reset_role(arg_37_1)
		if arg_37_1 == 1 then
			self:__init_eat_role_list()

			for iter_37_0, iter_37_1 in ipairs(self._my_role_list) do
				iter_37_1.transform.localPosition = var_0_26[iter_37_0][1]
				iter_37_1.transform.rotation = var_0_1.New(0, 0, 0)

				iter_37_1.transform:SetAsFirstSibling()
			end

			self:__ship_enter_anim()
		elseif arg_37_1 == 2 then
			for iter_37_2, iter_37_3 in pairs(self._girl_seq_list) do
				iter_37_3.timeScale = 0
			end

			for iter_37_4, iter_37_5 in pairs(self._love_seq_list) do
				iter_37_5.timeScale = 0
			end
		elseif arg_37_1 == 3 then
			for iter_37_6, iter_37_7 in pairs(self._girl_seq_list) do
				iter_37_7.timeScale = 1
			end

			for iter_37_8, iter_37_9 in pairs(self._love_seq_list) do
				iter_37_9.timeScale = 1
			end
		else
			if self._girl_seq_list and #self._girl_seq_list == 0 then
				return
			end

			for iter_37_10, iter_37_11 in pairs(self._girl_seq_list or {}) do
				iter_37_11:Kill()
			end

			if self._love_seq_list and #self._love_seq_list == 0 then
				return
			end

			for iter_37_12, iter_37_13 in pairs(self._love_seq_list or {}) do
				iter_37_13:Kill()
			end
		end
	end

	function arg_1_0:__show_buff_info(arg_38_1)
		self._control.tip_bg:SetActive(arg_38_1)

		if not arg_38_1 then
			return
		end

		local var_38_0 = var_0_19.find_object_by_cid(self._buff_info.id)

		self._control.tip_bg.title.title_1.text.text = var_38_0.title

		self._control.tip_bg.title:GetComponent("TextHorizonScroller"):SetText(var_38_0.title)

		self._control.tip_bg.content.text.text = self:__get_txt(var_38_0.effect_desc)
	end

	function arg_1_0:show_cooking_result(arg_39_1)
		self._control.cooking_bg.cook_skip_btn:SetActive(true)

		self.cook_result_type = arg_39_1
		self._food_animation_step = 1

		local var_39_0 = self._control.cooking_bg.anim_bg.cook_anim.skeletonAnimation

		self._control.cooking_bg.cook_result.image.sprite = self:loadSprite(var_0_11:get_format_url(var_0_11.cooking_result, arg_39_1 - 1))
		self._control.cooking_bg.anim_bg.cook_anim.skeletonAnimation.skeletonDataAsset = self:loadSkeletonDataAsset(var_0_11:get_cookbook_spine(var_0_11.common_icon.common_cookbook_asset, var_0_19.find_object_by_cid(self._food_cid).animation))

		self._control.cooking_bg.anim_bg.cook_anim.skeletonAnimation:Initialize(true)
		self._control.cooking_bg.anim_bg.cook_anim.skeletonAnimation:ClearState()
		self._control.cooking_bg:SetActive(true)

		self._control.cooking_bg.anim_bg.cook_anim.meshRenderer.sortingOrder = self._control.cooking_bg.canvas.sortingOrder + 1
		self._control.cooking_bg.cook_result.canvas.sortingOrder = self._control.cooking_bg.canvas.sortingOrder + 1
		self._control.cooking_bg.cook_tip.canvas.sortingOrder = self._control.cooking_bg.canvas.sortingOrder + 1

		self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.eatstart))
		self._control.cooking_bg.anim_bg:SetActive(true)
		self:__play_animation(self._control.cooking_bg.anim_bg.cook_anim.skeletonAnimation, var_0_22.start, false, function()
			self:__play_animation(var_39_0, var_0_22.normal, false, function()
				if arg_39_1 == 1 then
					self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.eatb))

					self._control.cooking_bg.cook_tip.text.color = Color.New(1, 0, 0)
					self._control.cooking_bg.cook_tip.text.text = var_0_6:getNowLang("bufftimeless")
				elseif arg_39_1 == 2 then
					self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.eata))

					self._control.cooking_bg.cook_tip.text.text = ""
				else
					self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.eats))

					self._control.cooking_bg.cook_tip.text.color = Color.New(0, 1, 0)
					self._control.cooking_bg.cook_tip.text.text = var_0_6:getNowLang("bufftimemore")
				end

				self:play_cooking_result_ani()
				self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.eat))
				self:__play_animation(var_39_0, var_0_22.eat, false, function()
					self:__play_animation(var_39_0, var_0_22.normal2, false, function()
						var_39_0.skeletonDataAsset = nil

						self._control.cooking_bg:SetActive(false)
						self:__role_love_anim()
					end)
				end)
			end)
		end)

		self._user_data = var_0_2:get_use_info_data()

		local var_39_1 = 1
		local var_39_2 = var_0_21.find_object_by_id(57)

		if var_39_2 then
			local var_39_3 = lx.ServerTime:getUtcTime()

			if var_39_3 >= var_39_2.start_time and var_39_3 <= var_39_2.end_time then
				var_39_1 = 2
			end
		end

		if not self._friend_data then
			self._user_data.cook_popularity = self._user_data.cook_popularity + 1 * var_39_1
		else
			self._friend_data.cook.popularity = self._friend_data.cook.popularity + 1 * var_39_1
		end

		self:set_popular()
		self:set_buff()
		self:__show_restaurant_last_count()
	end

	function arg_1_0:skip_animation_one()
		var_0_14:init()
		self:_play_audio(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.restaurant))
		self._control.cooking_bg:SetActive(false)
		self._control.cooking_bg.cook_skip_btn:SetActive(false)

		self._control.cooking_bg.anim_bg.cook_anim.skeletonAnimation.skeletonDataAsset = nil

		local var_44_0 = self._control.cooking_skip_bg.anim_bg.cook_anim.skeletonAnimation

		var_44_0.skeletonDataAsset = self:loadSkeletonDataAsset(var_0_11:get_cookbook_spine(var_0_11.common_icon.common_cookbook_asset, var_0_19.find_object_by_cid(self._food_cid).animation))

		var_44_0:Initialize(true)
		var_44_0:ClearState()

		self._control.cooking_skip_bg.anim_bg.cook_anim.meshRenderer.sortingOrder = self._control.cooking_bg.canvas.sortingOrder + 1
		self._control.cooking_skip_bg.cook_result.canvas.sortingOrder = self._control.cooking_bg.canvas.sortingOrder + 1
		self._control.cooking_skip_bg.cook_tip.canvas.sortingOrder = self._control.cooking_bg.canvas.sortingOrder + 1

		self._control.cooking_skip_bg:SetActive(true)
		self._control.cooking_skip_bg.cook_close_btn:SetActive(true)

		self._control.cooking_skip_bg.cook_result.image.sprite = self:loadSprite(var_0_11:get_format_url(var_0_11.cooking_result, self.cook_result_type - 1))

		if self.cook_result_type == 1 then
			self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.eatb))

			self._control.cooking_skip_bg.cook_tip.text.color = Color.New(1, 0, 0)
			self._control.cooking_skip_bg.cook_tip.text.text = var_0_6:getNowLang("bufftimeless")
		elseif self.cook_result_type == 2 then
			self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.eata))

			self._control.cooking_skip_bg.cook_tip.text.text = ""
		else
			self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.eats))

			self._control.cooking_skip_bg.cook_tip.text.color = Color.New(0, 1, 0)
			self._control.cooking_skip_bg.cook_tip.text.text = var_0_6:getNowLang("bufftimemore")
		end

		self:play_cooking2_result_ani()
		self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.eat))
		self:__play_animation(var_44_0, var_0_22.eat, false, function()
			self:__play_animation(var_44_0, var_0_22.normal2, false, function()
				var_44_0.skeletonDataAsset = nil

				self._control.cooking_skip_bg:SetActive(false)
				self:__role_love_anim()
			end)
		end)
	end

	function arg_1_0:skip_animation_two()
		var_0_14:init()

		self._control.cooking_skip_bg.anim_bg.cook_anim.skeletonAnimation.skeletonDataAsset = nil
		self._control.cooking_skip_bg.anim_bg.cook_anim.skeletonAnimation.skeletonDataAsset = nil

		self._control.cooking_bg:SetActive(false)
		self._control.cooking_skip_bg:SetActive(false)
		self:__role_love_anim()
		self._control.cooking_skip_bg.cook_close_btn:SetActive(false)
		self:_play_audio(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.restaurant))
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_constant()
			self:__init_images()
			self:__init_language()
			self:__init_restaurant_style_config()
			self:_play_audio(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.restaurant))
		end

		if self._enter_type == var_0_11.enter_restaurant_type.cardbook and not self._friend_data._is_friend or self._enter_type == var_0_11.enter_restaurant_type.cardbook_and_no_friend or self._enter_type == var_0_11.enter_restaurant_type.tower and not self._friend_data._is_friend then
			var_0_3:show(var_0_6:getNowLang("no_friend"))
		end

		if self._enter_type == var_0_11.enter_restaurant_type.friend or self._enter_type == var_0_11.enter_restaurant_type.cardbook_and_no_friend or self._enter_type == var_0_11.enter_restaurant_type.cardbook or self._enter_type == var_0_11.enter_restaurant_type.tower then
			self._control.setting_btn:SetActive(false)
			self._control.choice_btn:SetActive(false)
			self._control.home_btn:SetActive(false)

			if gamecore.util_func.check_channel_is_en() then
				gamecore.util_func.setTextHorizonInfo(self._control.collect_btn.title_mask, var_0_6:getNowLang("display_room"))
			else
				self._control.collect_btn.title_mask:SetActive(false)
			end

			self._control.collect_btn.image.sprite = self:loadSprite(var_0_11:get_format_url(var_0_11.friend_restaurant_btn, 0))

			local var_48_0 = self._control.collect_btn:GetComponent("Button").spriteState

			var_48_0.highlightedSprite = self:loadSprite(var_0_11.friend_restaurant_btn)
			var_48_0.pressedSprite = self:loadSprite(var_0_11.friend_restaurant_btn_pressed)
			self._control.collect_btn:GetComponent("Button").spriteState = var_48_0
		else
			self._control.setting_btn:SetActive(true)
			self._control.choice_btn:SetActive(true)
			self._control.home_btn:SetActive(true)
			self._control.collect_btn:SetActive(false)
		end

		self._user_data = var_0_2:get_use_info_data()

		self:set_restaurant_style()
		self:set_chef()
		self:set_buff()
		self:set_popular()
		self:__set_cookbook_used()

		if self._enter_type == var_0_11.enter_restaurant_type.cook_setting then
			self:__reset_role(3)
		else
			self:__reset_role(1)
		end

		self._is_already_init = true
	end

	function arg_1_0.__preload_ship(arg_49_0)
		var_0_7:createInstance("select_member"):__init_ship_list()
	end

	function arg_1_0:__init_images()
		self._control.cooking_bg.cook_result.image.sprite = self:loadSprite(var_0_11:get_format_url(var_0_11.cooking_result, 0))
		self._control.type_1.last_name.image.sprite = self:loadSprite(var_0_11:get_format_url(var_0_11.restaurant_icon, "restaurant_last_count_11145"))
		self._control.type_2.last_name.image.sprite = self:loadSprite(var_0_11:get_format_url(var_0_11.restaurant_icon, "restaurant_last_count_11445"))
		self._control.type_3.last_name.image.sprite = self:loadSprite(var_0_11:get_format_url(var_0_11.restaurant_icon, "restaurant_last_count_11545"))
	end

	function arg_1_0:__init_constant()
		self._last_list = {
			self._control.type_1,
			self._control.type_2,
			self._control.type_3
		}
		self._chair_list = {
			self._control.furniture.chair_1,
			self._control.furniture.chair_2,
			self._control.furniture.chair_3,
			self._control.furniture.chair_4,
			self._control.furniture.chair_5,
			self._control.furniture.chair_6
		}
		self._table_list = {
			self._control.furniture.table_1,
			self._control.furniture.table_2,
			self._control.furniture.table_3
		}
		self._food_list = {
			self._control.food_list.food_1,
			self._control.food_list.food_2,
			self._control.food_list.food_3
		}
		self._seq_cook_result = self._control.cooking_bg.uITweenSequence
		self._girl_list = {
			self._control.furniture.girl_1,
			self._control.furniture.girl_2,
			self._control.furniture.girl_3,
			self._control.furniture.girl_4,
			self._control.furniture.girl_5,
			self._control.furniture.girl_6
		}
		self._girl_seq_list = {}
		self._love_seq_list = {}
	end

	function arg_1_0:__init_language()
		self._control.setting_btn.txt.text.text = var_0_6:getNowLang("settingmenu")
		self._control.choice_btn.txt.text.text = var_0_6:getNowLang("changedecoration")
		self._control.goodat_btn.txt.text.text = var_0_6:getNowLang("foodmenudetailtitle")
		self._control.popular_bg.popular_title.text.text = var_0_6:getNowLang("popular")
	end

	function arg_1_0:__init_restaurant_style_config()
		local var_53_1

		self._restaurant_style_config, var_53_1 = var_0_20.get_sequence()

		table.sort(self._restaurant_style_config, function(arg_54_0, arg_54_1)
			return arg_54_0.cid < arg_54_1.cid
		end)
	end

	function arg_1_0:_play_audio(arg_55_1)
		self:playBackgroundMusic(arg_55_1)
	end

	function arg_1_0:_play_into_se(arg_56_1)
		self:playSE(arg_56_1, false)
	end

	function arg_1_0:__onReset()
		self._is_already_init = false
		self._friend_data = nil

		if self._cook_seq then
			self._cook_seq:Kill()

			self._cook_seq = nil
		end

		self._now_style_id = 0
		self._now_last_count = 0
		self._start_buff = false
		self._buff_info = {}
		self._restaurant_style_config = {}
		self._now_cookbook_list = {}
		self._food_cid = nil
		self._food_animation_step = 0
		self._my_role_list = {}
		self._user_data = {}
		self._cook_seq = nil
		self._use_cookbook_list = {}

		self:destroy_sea()

		for iter_57_0, iter_57_1 in pairs(self._character_spine_list) do
			self:destroyGameObject(iter_57_1)
		end

		self._character_spine_list = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_58_0)
	local var_58_0 = var_0_7:class("restaurant")

	var_58_0._is_already_init = false
	var_58_0._enter_type = nil
	var_58_0._friend_data = nil
	var_58_0._now_style_id = 0
	var_58_0._now_last_count = 0
	var_58_0._start_buff = false
	var_58_0._buff_info = {}
	var_58_0._restaurant_style_config = {}
	var_58_0._now_cookbook_list = {}
	var_58_0._food_cid = nil
	var_58_0._my_role_list = {}
	var_58_0._user_data = {}
	var_58_0._cook_seq = nil
	var_58_0._use_cookbook_list = {}
	var_58_0._character_spine_list = {}
	var_58_0._cook_result_type = nil
	var_58_0._food_animation_step = 0

	return var_58_0
end

return var_0_0
