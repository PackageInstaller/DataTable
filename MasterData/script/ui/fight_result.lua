local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.insert
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.UILoader
local var_0_5 = string.format
local var_0_6 = UnityEngine.Vector2
local var_0_7 = DG.Tweening.DOTween
local var_0_8 = gameenum.common_type
local var_0_10 = gameconfig.ship_level_config

gamecore.UILoader:define("fight_result", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:play_in_animation(arg_3_1)
		if self and self._control then
			self._control.bg.uITweenSequence:Play(function()
				if arg_3_1 then
					arg_3_1()
				end
			end)
		end
	end

	function arg_1_0:play_out_animation(arg_5_1)
		if self and self._control then
			self._control.bg.uITweenSequence:PlayReverse(function()
				if arg_5_1 then
					arg_5_1()
				end
			end)
		end
	end

	function arg_1_0:__init_panel(arg_7_1)
		self._team_id = arg_7_1.team
		self._reward_list = arg_7_1.reward
		self._is_big = arg_7_1.is_big
		self._expedition_id = arg_7_1.id
		self._expedition_exp_info = {
			self._control.left.every_exp.main_one,
			self._control.left.every_exp.main_two,
			self._control.left.every_exp.main_three,
			self._control.left.every_exp.main_four,
			self._control.left.every_exp.main_five,
			self._control.left.every_exp.main_six
		}

		self:play_in_animation()
		self:__show_user_info()
		self:__show_team_list()
		self:__show_reward_list()
		self:__show_success_img()
	end

	function arg_1_0:__show_user_info()
		self._control.top.player_name.text.text = var_0_1:get_name()
		self._control.top.player_level.text.text = var_0_5("Lv.%d", var_0_1:get_use_info_data().level)
		self._control.top.title_txt.text.text = var_0_3:getNowLang("pveexplorefinished")

		local var_8_0 = 0

		for iter_8_0, iter_8_1 in pairs(self._reward_list) do
			if iter_8_1.id == 6 then
				var_8_0 = iter_8_1.count
			end
		end

		if var_8_0 > 0 then
			self._control.top.fight_results:SetActive(true)
			self._control.top.fight_results.addexp.fontJump:Anim(var_8_0)
		end
	end

	function arg_1_0:__show_team_list()
		for iter_9_0 = 1, #self._expedition_exp_info do
			self._expedition_exp_info[iter_9_0]:SetActive(false)
		end

		local var_9_0 = 0

		for iter_9_1, iter_9_2 in pairs(self._reward_list) do
			if iter_9_2.id == 7 then
				var_9_0 = iter_9_2.count
			end
		end

		self._expedition_level = var_0_1:get_expedition_level()
		self._collect_item_list = {}

		for iter_9_3, iter_9_4 in pairs(var_0_1:get_team_by_id(self._team_id).members) do
			local var_9_1 = self:loadUI("fight_result_ship")

			var_9_1._panel.transform:SetParent(self._control.left.ship_list.transform, false)
			var_0_2(self._collect_item_list, var_9_1._panel)
			var_9_1:show({
				index = iter_9_3,
				ship_id = iter_9_4
			})
			self:expedition_exp_move(iter_9_3, iter_9_4, var_9_0)
		end

		self._control.left.fleet_name.text.text = var_0_3:getNowLang(var_0_5("fleetid%d", self._team_id))
	end

	function arg_1_0:expedition_exp_move(arg_10_1, arg_10_2, arg_10_3)
		self._expedition_exp_info[arg_10_1]:SetActive(true)
		self._expedition_exp_info[arg_10_1].extra:SetActive(false)

		self._expedition_exp_info[arg_10_1].remainword.text.text = var_0_3:getNowLang("upgradeneedexp")
		self._expedition_exp_info[arg_10_1].transform.localPosition = var_0_6(-415, self._expedition_exp_info[arg_10_1].transform.localPosition.y)
		self.exp_seq = self:autoKillDOTween(var_0_7.Sequence())

		self.exp_seq:Append(self._expedition_exp_info[arg_10_1].transform:DOBlendableLocalMoveBy(Vector3.New(216, 0), 0.3 + arg_10_1 / 10):SetEase(DG.Tweening.Ease.Linear))
		self.exp_seq:SetLoops(1)
		self.exp_seq:Play()

		local var_10_0 = var_0_1:find_character_by_id(arg_10_2)

		if self._expedition_level and next(self._expedition_level) and var_10_0.level ~= self._expedition_level[arg_10_2] then
			self:level_up(false, 0, 1, arg_10_1)
		end

		if var_10_0.level < 110 then
			self._expedition_exp_info[arg_10_1].addexp.fontJump:Anim(arg_10_3)

			self._expedition_exp_info[arg_10_1].remainexp.text.text = (var_0_10.find_object_by_level(var_10_0.level) and var_0_10.find_object_by_level(var_10_0.level).exp or 0) - var_10_0.exp
		else
			self._expedition_exp_info[arg_10_1].addexp.fontJump:Anim(0)

			self._expedition_exp_info[arg_10_1].remainexp.text.text = 0
		end
	end

	function arg_1_0:level_up(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
		local var_11_0 = self:autoKillDOTween(var_0_7.Sequence())
		local var_11_1

		var_11_0:AppendInterval(arg_11_2)
		var_11_0:AppendCallback(function()
			var_11_1 = self:createGameObject("data/effect/prefab/level_up.prefab")

			var_11_1.transform:SetParent(self._collect_item_list[arg_11_4].transform, false)

			local var_12_0 = var_11_1.transform:Find("up"):GetComponent(typeof(Spine.Unity.SkeletonGraphic))

			var_12_0.material.shader = var_0_8.shader_tint

			var_12_0.AnimationState:SetAnimation(0, "Level_up", false)
		end)
		var_11_0:Play()
	end

	function arg_1_0:__show_reward_list()
		self._control.left.award.res_title.text.text = var_0_3:getNowLang("pveexploreresultres")
		self._control.left.award.item_title.text.text = var_0_3:getNowLang("pveexploreresultequip")
		self._control.left.award.award_good.canvasGroup.alpha = 0

		local var_13_0 = 0
		local var_13_1 = 0
		local var_13_2 = 0
		local var_13_3 = 0

		for iter_13_0, iter_13_1 in pairs(self._reward_list) do
			if iter_13_1.id == var_0_8.ship_item_cid.oil then
				var_13_0 = iter_13_1.count
			elseif iter_13_1.id == var_0_8.ship_item_cid.bullet then
				var_13_1 = iter_13_1.count
			elseif iter_13_1.id == var_0_8.ship_item_cid.steel then
				var_13_2 = iter_13_1.count
			elseif iter_13_1.id == var_0_8.ship_item_cid.alum then
				var_13_3 = iter_13_1.count
			elseif iter_13_1.id ~= var_0_8.ship_item_cid.experience and iter_13_1.id ~= var_0_8.ship_item_cid.ship_experience then
				local var_13_4 = var_0_5(var_0_8.icon.item_icon, iter_13_1.id)

				self._control.left.award.award_good.good_icon_background.image.sprite = self:loadSprite(var_0_5(var_0_8.buy_spoils_equip_bg, 5))
				self._control.left.award.award_good.good_icon.image.sprite = self:loadSprite(var_13_4)
				self._control.left.award.award_good.good_num_txt.text.text = var_0_5("%d", iter_13_1.count)
				self._control.left.award.award_good.good_name_txt_back.image.sprite = self:loadSprite(var_0_8.get_award_expedition_image)

				if iter_13_1.id == var_0_8.ship_item_cid.equip_blueprint then
					self._control.left.award.award_good.good_name_txt_back.good_name_txt.text.text = var_0_3:getNowLang("item741")
				elseif iter_13_1.id == var_0_8.ship_item_cid.ship_blueprint then
					self._control.left.award.award_good.good_name_txt_back.good_name_txt.text.text = var_0_3:getNowLang("shipblueprint")
				elseif iter_13_1.id == var_0_8.ship_item_cid.fast_build then
					self._control.left.award.award_good.good_name_txt_back.good_name_txt.text.text = var_0_3:getNowLang("acceleratedbuild")
				elseif iter_13_1.id == var_0_8.ship_item_cid.ship_serviceprint then
					self._control.left.award.award_good.good_name_txt_back.good_name_txt.text.text = var_0_3:getNowLang("quickrepairtool")
				end

				self._control.left.award.award_good.canvasGroup.alpha = 1
			end
		end

		self._control.left.award.oil.oil_txt.text.text = tostring(var_13_0)
		self._control.left.award.bullet.bullet_txt.text.text = tostring(var_13_1)
		self._control.left.award.steel.steel_txt.text.text = tostring(var_13_2)
		self._control.left.award.alum.alum_txt.text.text = tostring(var_13_3)
	end

	function arg_1_0:__show_success_img()
		self._control.right.continue_txt.text.text = var_0_3:getNowLang("ui_combatresultcontinuetip")
		self._control.right.success_img.image.sprite = self:loadSprite((self._is_big or nil) and var_0_8.big_success_image)

		self._control.right.success_img.image:SetNativeSize()
	end

	function arg_1_0:__onReset()
		if self._collect_item_list then
			for iter_15_0, iter_15_1 in pairs(self._collect_item_list) do
				self:destroyGameObject(iter_15_1)
			end
		end

		self._expedition_exp_info = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_16_0)
	local var_16_0 = var_0_4:class("fight_result")

	var_16_0._team_id = -1
	var_16_0._reward_list = nil
	var_16_0._is_big = false
	var_16_0._expedition_id = nil
	var_16_0._expedition_level = nil

	return var_16_0
end

return var_0_0
