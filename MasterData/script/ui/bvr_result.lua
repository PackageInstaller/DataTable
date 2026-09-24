local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameconfig.monster_config
local var_0_4 = gameenum.common_type
local var_0_5 = DG.Tweening.DOTween
local var_0_6 = gamecore.SceneManager
local var_0_7 = gamecore.user
local var_0_8 = string.format

gamecore.UILoader:define("bvr_result", function(arg_1_0)
	function arg_1_0.__onUpdate(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
		local var_3_0 = var_0_1:getInstance("loading")

		if var_3_0 then
			var_3_0:show(false)
		end

		self:setVisible(true)

		self._data = arg_3_1
		self.is_campaign = arg_3_2
		self._enemydata = arg_3_3
		self._battle_type = arg_3_4
		self._enemy_team_name = arg_3_5

		self:__init_panel(arg_3_1, arg_3_2, arg_3_3)
	end

	function arg_1_0:__init_panel(arg_4_1, arg_4_2, arg_4_3)
		if arg_4_2 then
			self._campaign_select = var_0_1:getInstance("campaign_select")
		else
			self._fight_info = var_0_1:getInstance("fight_info")
		end

		self._control.top.title_txt.text.text = var_0_2:getNowLang("beyond_line_of_sight_result")
		self._control.right.fleet_name.text.text = self._enemy_team_name

		self:_set_player_info()
		self:_set_enemy_list()
		self:_set_enemy_now_info(arg_4_3)
		self:_into_fight()
	end

	function arg_1_0:_set_player_info()
		self._control.top.player_name.text.text = var_0_7:get_name()
		self._control.top.player_level.text.text = "LV." .. var_0_7:get_use_info_data().level
	end

	function arg_1_0:_set_enemy_list()
		local var_6_0 = {
			self._control.right.ship_list.fight_result_ship_1,
			self._control.right.ship_list.fight_result_ship_2,
			self._control.right.ship_list.fight_result_ship_3,
			self._control.right.ship_list.fight_result_ship_4,
			self._control.right.ship_list.fight_result_ship_5,
			self._control.right.ship_list.fight_result_ship_6
		}

		self._enemy_list = var_6_0

		for iter_6_0, iter_6_1 in pairs(var_6_0) do
			iter_6_1:SetActive(false)
			iter_6_1.ship_flag:SetActive(false)

			iter_6_1.ship_name.ship_name_1.text.text = ""
			iter_6_1.ship_name.ship_name_2.text.text = ""

			iter_6_1.sink:SetActive(false)
			iter_6_1.ship_flag:SetActive(false)
			iter_6_1.smoke:SetActive(false)
		end
	end

	function arg_1_0:_set_enemy_now_info(arg_7_1)
		self._enemy_list[1].ship_flag:SetActive(true)

		for iter_7_0 = 1, #arg_7_1 do
			self._enemy_list[iter_7_0]:SetActive(true)

			local var_7_0 = var_0_3.find_object_by_id(arg_7_1[iter_7_0].cid)

			self._enemy_list[iter_7_0].ship_hp.hp_bar.image.fillAmount = arg_7_1[iter_7_0].now_hp / arg_7_1[iter_7_0].hp

			if arg_7_1[iter_7_0].now_hp / arg_7_1[iter_7_0].hp >= 0.5 then
				self._enemy_list[iter_7_0].ship_hp.hp_bar.image.sprite = self:loadSprite(var_0_4.battle_settlement_hp_normal)
			elseif arg_7_1[iter_7_0].now_hp / arg_7_1[iter_7_0].hp >= 0.25 and arg_7_1[iter_7_0].now_hp / arg_7_1[iter_7_0].hp < 0.5 then
				self._enemy_list[iter_7_0].ship_hp.hp_bar.image.sprite = self:loadSprite(var_0_4.battle_settlement_hp_mid)
			elseif arg_7_1[iter_7_0].now_hp / arg_7_1[iter_7_0].hp < 0.25 then
				self._enemy_list[iter_7_0].ship_hp.hp_bar.image.sprite = self:loadSprite(var_0_4.battle_settlement_hp_low)
			end

			self._enemy_list[iter_7_0].ship.ship_icon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.battle_settlement_normal, var_7_0.pic_id))
			self._enemy_list[iter_7_0].ship.ship_bg.image.sprite = self:loadSprite(var_0_8(var_0_4.battle_settlement_bg, var_7_0.star == 0 and 1 or var_7_0.star))
			self._enemy_list[iter_7_0].ship_name.ship_name_1.text.text = var_7_0.title

			self._enemy_list[iter_7_0].ship_name:GetComponent("TextHorizonScroller"):SetText(var_7_0.title)

			self._enemy_list[iter_7_0].ship_level.level_num.text.text = "Lv." .. var_7_0.level
			self._enemy_list[iter_7_0].ship_type.type_name.text.text = var_0_2:getNowLang(var_0_4:get_ship_type_language_key(var_7_0.type, 1))

			if arg_7_1[iter_7_0].now_hp / arg_7_1[iter_7_0].hp <= 0 then
				self._enemy_list[iter_7_0].sink:SetActive(true)

				self._enemy_list[iter_7_0].sink.sink_word.text.text = var_0_2:getNowLang("ui_combatresultbreak3")

				self._enemy_list[iter_7_0].smoke:SetActive(true)
				self:smoke_e(false, 0, -1, iter_7_0)
			end
		end
	end

	function arg_1_0:smoke_e(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		local var_8_0 = self:autoKillDOTween(var_0_5.Sequence())
		local var_8_1

		var_8_0:AppendInterval(arg_8_2)
		var_8_0:AppendCallback(function()
			var_8_1 = self:createGameObject("data/effect/prefab/smoke.prefab")

			var_8_1.transform:SetParent(self._enemy_list[arg_8_4].smoke.rectTransform, false)
			var_8_1.transform:GetChild(0).transform:GetComponent(typeof(Spine.Unity.SkeletonGraphic)).AnimationState:SetAnimation(0, "Smoke_L", true)
		end)
		var_8_0:Play()
	end

	function arg_1_0:_into_fight()
		self._animation_seq = {}

		local var_10_0 = self:autoKillDOTween(var_0_5.Sequence())

		var_10_0:AppendInterval(4)
		var_10_0:AppendCallback(function()
			self:setVisible(false)
			var_0_6:loadScene(var_0_4:get_battle_scene_name(), function()
				var_0_1:destroyStateUISet("game")
				var_0_1:createInstance(var_0_4:get_battle_name()):show(self._battle_type)
			end)
		end)
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0:__initia_lize()
		if self._animation_seq then
			for iter_14_0, iter_14_1 in pairs(self._animation_seq) do
				iter_14_1:Kill()
			end
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_15_0)
	local var_15_0 = var_0_1:class("bvr_result")

	var_15_0:__initia_lize()

	return var_15_0
end

return var_0_0
