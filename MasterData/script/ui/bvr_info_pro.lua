local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_3 = UnityEngine.Screen
local var_0_4 = UnityEngine.Vector2
local var_0_5 = UnityEngine.Vector3
local var_0_6 = UnityEngine.Quaternion
local var_0_8 = DG.Tweening.DOTween
local var_0_9 = table.insert
local var_0_10 = gameconfig.equip_config
local var_0_11 = gameenum.common_type
local var_0_12 = lx.json_decode
local var_0_14 = string.format
local var_0_16 = gamecore.user
local var_0_18 = lx.json_encode
local var_0_20 = UnityEngine.Color

gamecore.UILoader:define("bvr_info_pro", function(arg_1_0)
	function arg_1_0.__onUpdate(arg_2_0)
		return
	end

	function arg_1_0:show(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7)
		if arg_3_6 then
			self._enemy_formation_id = arg_3_6
		end

		self._data = arg_3_3
		self._param = arg_3_1
		self._is_campaign_select_into = arg_3_5
		self._enemy_team_name = arg_3_7

		if arg_3_5 then
			self:__init_panel(arg_3_1, arg_3_2.monster_array, arg_3_3, arg_3_4)
		else
			self:__init_panel(arg_3_1.team_detail_data, arg_3_2, arg_3_3, arg_3_4)
		end

		self:setVisible(true)
	end

	function arg_1_0:__init_panel(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		self._now_battle_type = arg_4_4

		if self._is_campaign_select_into then
			self._campaign_select = var_0_1:getInstance("campaign_select")
		else
			self._fight_info = var_0_1:getInstance("fight_info")

			if self._fight_info._panel.activeSelf and (self._now_battle_type == var_0_11.fight_type.score_attack or self._now_battle_type == var_0_11.fight_type.ninth_attack) then
				self._fight_info:setVisible(false)
			end
		end

		self._stay_fight = false
		self._now_damage_info = var_0_12(arg_4_3.bvr_record)
		self._encode_damage_info = arg_4_3.bvr_record
		self._now_data_info = var_0_12(arg_4_3.record)

		self:set_decode_enemy_info(self._now_damage_info)

		self._enemy_data_info = self._now_data_info[4].param.data.enemy
		self._player_data_info = self._now_data_info[4].param.data.player
		self._start_attack_and_intercept = false
		self._enemy_start_missile_intercept = false
		self._team_info = arg_4_1

		local var_4_0 = {}

		if self._param.members then
			self._stay_fight = true
		end

		if not self._team_info then
			if self._param.members then
				for iter_4_0, iter_4_1 in pairs(self._param.members) do
					var_0_9(var_4_0, (var_0_16:find_character_by_id(iter_4_1)))
				end
			end

			self._team_info = var_4_0
		end

		self._enemy_info = arg_4_2

		self._control.bvr_camera.open:SetActive(true)

		self._worldCamera = var_0_1:getUIRoot().parent.transform:GetComponent("Canvas").worldCamera
		self._bvr_camera = self._control.bvr_camera:GetComponent("Camera")
		self._bvr_camera_two = self._control.bvr_camera_two:GetComponent("Camera")

		self:__set_camera_new_info()
		self:__set_normal_info()
		self:__set_back_btn_active()
		self:__set_player_team_init()
		self:__set_enemy_team_init()
		self:__set_find_enemy_radar_init(#self._enemy_info)
		self:__set_transition_time()

		if self._need_intercept then
			self._set_intercept_info = {}
			self._save_intercepted_missiles = {}

			for iter_4_2, iter_4_3 in pairs(self._now_damage_info) do
				if iter_4_3.atk_state == "intercept" then
					var_0_9(self._set_intercept_info, iter_4_3)
				end
			end

			self:__set_intercept_missiles_info()
		else
			self:__set_no_intercept_missiles_info()
		end

		self:__set_player_ships_header_ready()
		self:__init_start_fight()
		self:__init_end_first_fight()

		self._two_intercept_time = 1
	end

	function arg_1_0:__set_back_btn_active()
		if app:isPC() then
			self._control.back_btn:SetActive(true)
		end
	end

	function arg_1_0:set_decode_enemy_info(arg_6_1)
		self._set_report_info = self._set_report_info or {}
		self._all_damage_info = {}

		for iter_6_0, iter_6_1 in pairs(arg_6_1) do
			if not iter_6_1.damage or iter_6_1.atk_state == var_0_11.bvr_state_type.intercepted then
				iter_6_1.damage = 0
			end

			self:set_encode_info(iter_6_1.damage, iter_6_1.equip_name, iter_6_1.name, iter_6_1.id, iter_6_1.atk_state, iter_6_1.target)
		end

		self._encode_report_info = var_0_18(self._set_report_info)

		var_0_16:set_bvr_damage_info(self._encode_report_info)
	end

	function arg_1_0:set_encode_info(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
		self:set_encode_damamge_info("超视距攻击的数据", (var_0_14("伤害:%d, 携带的导弹型号:%s, 攻击者名字:%s, 攻击者id为:%d, 导弹的命中状态:%s, 攻击目标为:%d", arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)))
	end

	function arg_1_0:set_encode_damamge_info(arg_8_1, arg_8_2)
		self._record_index = self._record_index or 1
		self._set_report_info[self._record_index] = self._set_report_info[self._record_index] or {}
		self._set_report_info[self._record_index][arg_8_1] = self._set_report_info[self._record_index][arg_8_1] or {}

		var_0_9(self._set_report_info[self._record_index][arg_8_1], arg_8_2)

		self._record_index = self._record_index + 1
	end

	function arg_1_0:__set_num_ships_pos(arg_9_1)
		local var_9_0 = {
			var_0_5(0, 60, 0),
			var_0_5(0, 0, 0),
			var_0_5(0, -60, 0)
		}
		local var_9_1 = {
			var_0_5(0, 90, 0),
			var_0_5(0, 30, 0),
			var_0_5(0, -30, 0),
			var_0_5(0, -90, 0)
		}
		local var_9_2 = {
			var_0_5(0, 125, 0),
			var_0_5(0, 65, 0),
			var_0_5(0, 5, 0),
			var_0_5(0, -55, 0),
			var_0_5(0, -115, 0)
		}
		local var_9_3 = {
			var_0_5(0, 150, 0),
			var_0_5(0, 90, 0),
			var_0_5(0, 30, 0),
			var_0_5(0, -30, 0),
			var_0_5(0, -90, 0),
			var_0_5(0, -150, 0)
		}
		local var_9_4 = {
			var_0_5(30, 60, 0),
			var_0_5(-30, 60, 0),
			var_0_5(30, -60, 0),
			var_0_5(-30, -60, 0)
		}
		local var_9_5 = {
			var_0_5(30, 30, 0),
			var_0_5(-27, 50, 0),
			var_0_5(-27, 0, 0),
			var_0_5(-27, -50, 0),
			var_0_5(30, -30, 0)
		}
		local var_9_6 = {
			var_0_5(30, 60, 0),
			var_0_5(-30, 60, 0),
			var_0_5(30, 0, 0),
			var_0_5(-30, 0, 0),
			var_0_5(30, -60, 0),
			var_0_5(-30, -60, 0)
		}
		local var_9_7 = {
			var_0_5(0, 40, 0),
			var_0_5(30, 0, 0),
			var_0_5(-30, 0, 0),
			var_0_5(0, -40, 0)
		}
		local var_9_8 = {
			var_0_5(0, 60, 0),
			var_0_5(0, 0, 0),
			var_0_5(60, 0, 0),
			var_0_5(-60, 0, 0),
			var_0_5(0, -60, 0)
		}
		local var_9_9 = {
			var_0_5(0, 120, 0),
			var_0_5(0, 45, 0),
			var_0_5(55, 9, 0),
			var_0_5(-55, 9, 0),
			var_0_5(0, -30, 0),
			var_0_5(0, -105, 0)
		}
		local var_9_10 = {
			var_0_5(-40, 120, 0),
			var_0_5(-20, 45, 0),
			var_0_5(0, -30, 0),
			var_0_5(20, -105, 0)
		}
		local var_9_11 = {
			var_0_5(-40, 120, 0),
			var_0_5(-20, 45, 0),
			var_0_5(0, -30, 0),
			var_0_5(20, -105, 0),
			var_0_5(40, -180, 0)
		}
		local var_9_12 = {
			var_0_5(-60, 195, 0),
			var_0_5(-40, 120, 0),
			var_0_5(-20, 45, 0),
			var_0_5(0, -30, 0),
			var_0_5(20, -105, 0),
			var_0_5(40, -180, 0)
		}
		local var_9_13 = {
			var_0_5(45, 0, 0),
			var_0_5(15, 0, 0),
			var_0_5(-15, 0, 0),
			var_0_5(-45, 0, 0)
		}
		local var_9_14 = {
			var_0_5(50, 0, 0),
			var_0_5(25, 0, 0),
			var_0_5(0, 0, 0),
			var_0_5(-25, 0, 0),
			var_0_5(-50, 0, 0)
		}
		local var_9_15 = {
			var_0_5(-150, 0, 0),
			var_0_5(-100, 0, 0),
			var_0_5(-50, 0, 0),
			(var_0_5(0, 0, 0))
		}

		var_9_15[5] = var_0_5(50, -0, 0)
		var_9_15[6] = var_0_5(100, 0, 0)

		local var_9_16 = var_0_16:get_formation_id() or 1

		if var_9_16 == 1 then
			if arg_9_1 < 4 then
				for iter_9_0 = 1, arg_9_1 do
					self._player_team_info[iter_9_0].transform.localPosition = var_9_0[iter_9_0]
				end
			elseif arg_9_1 == 4 then
				for iter_9_1 = 1, arg_9_1 do
					self._player_team_info[iter_9_1].transform.localPosition = var_9_1[iter_9_1]
				end
			elseif arg_9_1 == 5 then
				for iter_9_2 = 1, arg_9_1 do
					self._player_team_info[iter_9_2].transform.localPosition = var_9_2[iter_9_2]
				end
			elseif arg_9_1 == 6 then
				for iter_9_3 = 1, arg_9_1 do
					self._player_team_info[iter_9_3].transform.localPosition = var_9_3[iter_9_3]
				end
			end
		elseif var_9_16 == 2 then
			if arg_9_1 == 4 then
				for iter_9_4 = 1, arg_9_1 do
					self._player_team_info[iter_9_4].transform.localPosition = var_9_4[iter_9_4]
				end
			elseif arg_9_1 == 5 then
				for iter_9_5 = 1, arg_9_1 do
					self._player_team_info[iter_9_5].transform.localPosition = var_9_5[iter_9_5]
				end
			elseif arg_9_1 == 6 then
				for iter_9_6 = 1, arg_9_1 do
					self._player_team_info[iter_9_6].transform.localPosition = var_9_6[iter_9_6]
				end
			end
		elseif var_9_16 == 3 then
			if arg_9_1 == 4 then
				for iter_9_7 = 1, arg_9_1 do
					self._player_team_info[iter_9_7].transform.localPosition = var_9_7[iter_9_7]
				end
			elseif arg_9_1 == 5 then
				for iter_9_8 = 1, arg_9_1 do
					self._player_team_info[iter_9_8].transform.localPosition = var_9_8[iter_9_8]
				end
			elseif arg_9_1 == 6 then
				for iter_9_9 = 1, arg_9_1 do
					self._player_team_info[iter_9_9].transform.localPosition = var_9_9[iter_9_9]
				end
			end
		elseif var_9_16 == 4 then
			if arg_9_1 == 4 then
				for iter_9_10 = 1, arg_9_1 do
					self._player_team_info[iter_9_10].transform.localPosition = var_9_10[iter_9_10]
				end
			elseif arg_9_1 == 5 then
				for iter_9_11 = 1, arg_9_1 do
					self._player_team_info[iter_9_11].transform.localPosition = var_9_11[iter_9_11]
				end
			elseif arg_9_1 == 6 then
				for iter_9_12 = 1, arg_9_1 do
					self._player_team_info[iter_9_12].transform.localPosition = var_9_12[iter_9_12]
				end
			end
		elseif var_9_16 == 5 then
			if arg_9_1 == 4 then
				for iter_9_13 = 1, arg_9_1 do
					self._player_team_info[iter_9_13].transform.localPosition = var_9_13[iter_9_13]
				end
			elseif arg_9_1 == 5 then
				for iter_9_14 = 1, arg_9_1 do
					self._player_team_info[iter_9_14].transform.localPosition = var_9_14[iter_9_14]
				end
			elseif arg_9_1 == 6 then
				for iter_9_15 = 1, arg_9_1 do
					self._player_team_info[iter_9_15].transform.localPosition = var_9_15[iter_9_15]
				end
			end
		end
	end

	function arg_1_0:__set_num_enemy_ships_pos(arg_10_1)
		local var_10_0 = {
			var_0_5(0, 40, 0),
			var_0_5(0, 0, 0),
			var_0_5(0, -40, 0)
		}
		local var_10_1 = {
			var_0_5(0, 70, 0),
			var_0_5(0, 30, 0),
			var_0_5(0, -10, 0),
			var_0_5(0, -50, 0)
		}
		local var_10_2 = {
			var_0_5(0, 80, 0),
			var_0_5(0, 40, 0),
			var_0_5(0, 0, 0),
			var_0_5(0, -40, 0),
			var_0_5(0, -80, 0)
		}
		local var_10_3 = {
			var_0_5(0, 100, 0),
			var_0_5(0, 60, 0),
			var_0_5(0, 20, 0),
			var_0_5(0, -20, 0),
			var_0_5(0, -60, 0),
			var_0_5(0, -100, 0)
		}
		local var_10_4 = {
			var_0_5(40, 40, 0),
			var_0_5(-40, 40, 0),
			var_0_5(-40, -40, 0),
			var_0_5(40, -40, 0)
		}
		local var_10_5 = {
			var_0_5(40, 80, 0),
			var_0_5(-40, 40, 0),
			var_0_5(40, 0, 0),
			var_0_5(-40, -40, 0),
			var_0_5(40, -80, 0)
		}
		local var_10_6 = {
			var_0_5(40, 80, 0),
			var_0_5(-40, 80, 0),
			var_0_5(40, 0, 0),
			var_0_5(-40, 0, 0),
			var_0_5(40, -80, 0),
			var_0_5(-40, -80, 0)
		}
		local var_10_7 = {
			var_0_5(0, 60, 0),
			var_0_5(50, 0, 0),
			var_0_5(-50, 0, 0),
			var_0_5(0, -60, 0)
		}
		local var_10_8 = {
			var_0_5(0, 60, 0),
			var_0_5(50, 0, 0),
			var_0_5(0, 0, 0),
			var_0_5(-50, 0, 0),
			var_0_5(0, -60, 0)
		}
		local var_10_9 = {
			var_0_5(0, 100, 0),
			var_0_5(0, 40, 0),
			var_0_5(0, -20, 0),
			var_0_5(0, -80, 0),
			var_0_5(50, 10, 0),
			var_0_5(-50, 10, 0)
		}
		local var_10_10 = {
			var_0_5(-30, 60, 0),
			var_0_5(-10, 20, 0),
			var_0_5(10, -20, 0),
			var_0_5(30, -60, 0)
		}
		local var_10_11 = {
			var_0_5(-40, 80, 0),
			var_0_5(-20, 40, 0),
			var_0_5(0, 0, 0),
			var_0_5(20, -40, 0),
			var_0_5(40, -80, 0)
		}
		local var_10_12 = {
			var_0_5(-50, 100, 0),
			var_0_5(-30, 60, 0),
			var_0_5(-10, 20, 0),
			var_0_5(10, -20, 0),
			var_0_5(30, -60, 0),
			var_0_5(50, -100, 0)
		}
		local var_10_13 = {
			var_0_5(-60, 0, 0),
			var_0_5(-20, 0, 0),
			var_0_5(20, 0, 0),
			var_0_5(60, 0, 0)
		}
		local var_10_14 = {
			var_0_5(-80, 0, 0),
			var_0_5(-40, 0, 0),
			var_0_5(0, 0, 0),
			var_0_5(40, 0, 0),
			var_0_5(80, 0, 0)
		}
		local var_10_15 = {
			var_0_5(-88, 0, 0),
			var_0_5(-53, 0, 0),
			var_0_5(-18, 0, 0),
			var_0_5(18, 0, 0),
			var_0_5(53, 0, 0),
			var_0_5(88, 0, 0)
		}

		for iter_10_0 = 1, arg_10_1 do
			self._enemy_radar_info[iter_10_0]:SetActive(true)
		end

		if not self._enemy_formation_id or self._enemy_formation_id == 1 then
			if arg_10_1 < 4 then
				for iter_10_1 = 1, arg_10_1 do
					self._enemy_radar_info[iter_10_1].transform.localPosition = var_10_0[iter_10_1]
				end
			elseif arg_10_1 == 4 then
				for iter_10_2 = 1, arg_10_1 do
					self._enemy_radar_info[iter_10_2].transform.localPosition = var_10_1[iter_10_2]
				end
			elseif arg_10_1 == 5 then
				for iter_10_3 = 1, arg_10_1 do
					self._enemy_radar_info[iter_10_3].transform.localPosition = var_10_2[iter_10_3]
				end
			elseif arg_10_1 == 6 then
				for iter_10_4 = 1, arg_10_1 do
					self._enemy_radar_info[iter_10_4].transform.localPosition = var_10_3[iter_10_4]
				end
			end
		elseif self._enemy_formation_id and self._enemy_formation_id ~= 1 then
			if self._enemy_formation_id == 2 then
				if arg_10_1 == 4 then
					for iter_10_5 = 1, arg_10_1 do
						self._enemy_radar_info[iter_10_5].transform.localPosition = var_10_4[iter_10_5]
					end
				elseif arg_10_1 == 5 then
					for iter_10_6 = 1, arg_10_1 do
						self._enemy_radar_info[iter_10_6].transform.localPosition = var_10_5[iter_10_6]
					end
				elseif arg_10_1 == 6 then
					for iter_10_7 = 1, arg_10_1 do
						self._enemy_radar_info[iter_10_7].transform.localPosition = var_10_6[iter_10_7]
					end
				end
			elseif self._enemy_formation_id == 3 then
				if arg_10_1 == 4 then
					for iter_10_8 = 1, arg_10_1 do
						self._enemy_radar_info[iter_10_8].transform.localPosition = var_10_7[iter_10_8]
					end
				elseif arg_10_1 == 5 then
					for iter_10_9 = 1, arg_10_1 do
						self._enemy_radar_info[iter_10_9].transform.localPosition = var_10_8[iter_10_9]
					end
				elseif arg_10_1 == 6 then
					for iter_10_10 = 1, arg_10_1 do
						self._enemy_radar_info[iter_10_10].transform.localPosition = var_10_9[iter_10_10]
					end
				end
			elseif self._enemy_formation_id == 4 then
				if arg_10_1 == 4 then
					for iter_10_11 = 1, arg_10_1 do
						self._enemy_radar_info[iter_10_11].transform.localPosition = var_10_10[iter_10_11]
					end
				elseif arg_10_1 == 5 then
					for iter_10_12 = 1, arg_10_1 do
						self._enemy_radar_info[iter_10_12].transform.localPosition = var_10_11[iter_10_12]
					end
				elseif arg_10_1 == 6 then
					for iter_10_13 = 1, arg_10_1 do
						self._enemy_radar_info[iter_10_13].transform.localPosition = var_10_12[iter_10_13]
					end
				end
			elseif self._enemy_formation_id == 5 then
				if arg_10_1 == 4 then
					for iter_10_14 = 1, arg_10_1 do
						self._enemy_radar_info[iter_10_14].transform.localPosition = var_10_13[iter_10_14]
					end
				elseif arg_10_1 == 5 then
					for iter_10_15 = 1, arg_10_1 do
						self._enemy_radar_info[iter_10_15].transform.localPosition = var_10_14[iter_10_15]
					end
				elseif arg_10_1 == 6 then
					for iter_10_16 = 1, arg_10_1 do
						self._enemy_radar_info[iter_10_16].transform.localPosition = var_10_15[iter_10_16]
					end
				end
			end
		end
	end

	function arg_1_0:__set_find_enemy_radar_init(arg_11_1)
		local var_11_0 = {
			self._control.bvr_camera.find_enemy_radar.radar.ship_1,
			self._control.bvr_camera.find_enemy_radar.radar.ship_2,
			self._control.bvr_camera.find_enemy_radar.radar.ship_3,
			self._control.bvr_camera.find_enemy_radar.radar.ship_4,
			self._control.bvr_camera.find_enemy_radar.radar.ship_5,
			self._control.bvr_camera.find_enemy_radar.radar.ship_6
		}

		self._enemy_radar_info = var_11_0

		for iter_11_0 = 1, 6 do
			var_11_0[iter_11_0]:SetActive(false)
			var_11_0[iter_11_0].icon:SetActive(false)
			var_11_0[iter_11_0].ship_lock:SetActive(false)
			var_11_0[iter_11_0].lock_now:SetActive(false)
		end

		for iter_11_1 = 1, arg_11_1 do
			var_11_0[iter_11_1]:SetActive(true)
		end

		for iter_11_2 = 1, #self._now_damage_info do
			var_11_0[self._now_damage_info[iter_11_2].target].icon:SetActive(true)
			var_11_0[self._now_damage_info[iter_11_2].target].ship_lock:SetActive(true)
			var_11_0[self._now_damage_info[iter_11_2].target].lock_now:SetActive(true)
		end

		self:__set_num_enemy_ships_pos(arg_11_1)
	end

	function arg_1_0:__set_intercept_one_enemy_ships_pos(arg_12_1)
		local var_12_0 = {
			var_0_5(2, 94, 0),
			var_0_5(3, 40, 0),
			var_0_5(3, -10, 0),
			var_0_5(3, -60, 0),
			var_0_5(3, -110, 0),
			var_0_5(3, -160, 0)
		}
		local var_12_1 = {
			var_0_5(27, 50, 0),
			var_0_5(-27, 50, 0),
			var_0_5(27, -50, 0),
			var_0_5(-27, -50, 0)
		}
		local var_12_2 = {
			var_0_5(27, 25, 0),
			var_0_5(-27, 50, 0),
			var_0_5(-27, 0, 0),
			var_0_5(27, -50, 0),
			var_0_5(-27, -25, 0)
		}
		local var_12_3 = {
			var_0_5(27, 50, 0),
			var_0_5(-27, 50, 0),
			var_0_5(-27, 0, 0),
			var_0_5(27, 0, 0),
			var_0_5(27, -50, 0),
			var_0_5(-27, -50, 0)
		}
		local var_12_4 = {
			var_0_5(0, 50, 0),
			var_0_5(27, 0, 0),
			var_0_5(-27, 0, 0),
			var_0_5(0, 50, 0)
		}
		local var_12_5 = {
			var_0_5(0, 50, 0),
			var_0_5(53, 0, 0),
			var_0_5(0, 0, 0),
			var_0_5(-53, 0, 0),
			var_0_5(0, 50, 0)
		}
		local var_12_6 = {
			var_0_5(0, 60, 0),
			var_0_5(0, -10, 0),
			var_0_5(0, -80, 0),
			var_0_5(0, -150, 0),
			var_0_5(60, -50, 0),
			var_0_5(-60, -50, 0)
		}
		local var_12_7 = {
			var_0_5(-60, 100, 0),
			var_0_5(-25, 50, 0),
			var_0_5(10, 0, 0),
			var_0_5(45, -50, 0)
		}
		local var_12_8 = {
			var_0_5(-60, 100, 0),
			var_0_5(-25, 50, 0),
			var_0_5(10, 0, 0),
			var_0_5(45, -50, 0),
			var_0_5(80, -100, 0)
		}
		local var_12_9 = {
			var_0_5(-60, 100, 0),
			var_0_5(-25, 50, 0),
			var_0_5(10, 0, 0),
			var_0_5(45, -50, 0),
			var_0_5(80, -100, 0),
			var_0_5(115, -150, 0)
		}
		local var_12_10 = {
			var_0_5(-90, 1.5, 0),
			var_0_5(-30, 0, 0),
			var_0_5(30, -1.5, 0),
			var_0_5(90, -3, 0)
		}
		local var_12_11 = {
			var_0_5(-120, 3, 0),
			var_0_5(-60, 1.5, 0),
			var_0_5(0, 0, 0),
			var_0_5(60, -1.5, 0),
			var_0_5(120, -3, 0)
		}
		local var_12_12 = {
			var_0_5(-150, 3, 0),
			var_0_5(-90, 1.5, 0),
			var_0_5(-30, 0, 0),
			var_0_5(30, -1.5, 0),
			var_0_5(90, -3, 0),
			var_0_5(150, -4.5, 0)
		}

		if not self._enemy_formation_id or self._enemy_formation_id == 1 then
			for iter_12_0 = 1, arg_12_1 do
				self._enemy_ship_team_intercept[iter_12_0].transform.localPosition = var_12_0[iter_12_0]
			end
		elseif self._enemy_formation_id and self._enemy_formation_id ~= 1 then
			if self._enemy_formation_id == 2 then
				if arg_12_1 == 4 then
					for iter_12_1 = 1, arg_12_1 do
						self._enemy_ship_team_intercept[iter_12_1].transform.localPosition = var_12_1[iter_12_1]
					end
				elseif arg_12_1 == 5 then
					for iter_12_2 = 1, arg_12_1 do
						self._enemy_ship_team_intercept[iter_12_2].transform.localPosition = var_12_2[iter_12_2]
					end
				elseif arg_12_1 == 6 then
					for iter_12_3 = 1, arg_12_1 do
						self._enemy_ship_team_intercept[iter_12_3].transform.localPosition = var_12_3[iter_12_3]
					end
				end
			elseif self._enemy_formation_id == 3 then
				if arg_12_1 == 4 then
					for iter_12_4 = 1, arg_12_1 do
						self._enemy_ship_team_intercept[iter_12_4].transform.localPosition = var_12_4[iter_12_4]
					end
				elseif arg_12_1 == 5 then
					for iter_12_5 = 1, arg_12_1 do
						self._enemy_ship_team_intercept[iter_12_5].transform.localPosition = var_12_5[iter_12_5]
					end
				elseif arg_12_1 == 6 then
					for iter_12_6 = 1, arg_12_1 do
						self._enemy_ship_team_intercept[iter_12_6].transform.localPosition = var_12_6[iter_12_6]
					end
				end
			elseif self._enemy_formation_id == 4 then
				if arg_12_1 == 4 then
					for iter_12_7 = 1, arg_12_1 do
						self._enemy_ship_team_intercept[iter_12_7].transform.localPosition = var_12_7[iter_12_7]
					end
				elseif arg_12_1 == 5 then
					for iter_12_8 = 1, arg_12_1 do
						self._enemy_ship_team_intercept[iter_12_8].transform.localPosition = var_12_8[iter_12_8]
					end
				elseif arg_12_1 == 6 then
					for iter_12_9 = 1, arg_12_1 do
						self._enemy_ship_team_intercept[iter_12_9].transform.localPosition = var_12_9[iter_12_9]
					end
				end
			elseif self._enemy_formation_id == 5 then
				if arg_12_1 == 4 then
					for iter_12_10 = 1, arg_12_1 do
						self._enemy_ship_team_intercept[iter_12_10].transform.localPosition = var_12_10[iter_12_10]
					end
				elseif arg_12_1 == 5 then
					for iter_12_11 = 1, arg_12_1 do
						self._enemy_ship_team_intercept[iter_12_11].transform.localPosition = var_12_11[iter_12_11]
					end
				elseif arg_12_1 == 6 then
					for iter_12_12 = 1, arg_12_1 do
						self._enemy_ship_team_intercept[iter_12_12].transform.localPosition = var_12_12[iter_12_12]
					end
				end
			end
		end
	end

	function arg_1_0:__set_intercept_num_enemy_ships_pos(arg_13_1)
		local var_13_0 = {
			var_0_5(0, 0, 0),
			var_0_5(0, -80, 0),
			var_0_5(0, -160, 0)
		}
		local var_13_1 = {
			var_0_5(0, 80, 0),
			var_0_5(0, 0, 0),
			var_0_5(0, -80, 0),
			var_0_5(0, -160, 0),
			var_0_5(0, -240, 0),
			var_0_5(0, -320, 0)
		}
		local var_13_2 = {
			var_0_5(0, -40, 0),
			var_0_5(-80, 0, 0),
			var_0_5(0, -80, 0),
			var_0_5(-80, -80, 0),
			var_0_5(-80, -156, 0)
		}
		local var_13_3 = {
			var_0_5(0, 0, 0),
			var_0_5(-80, 0, 0),
			var_0_5(0, -80, 0),
			var_0_5(-80, -80, 0),
			var_0_5(-80, -156, 0),
			var_0_5(0, -156, 0)
		}
		local var_13_4 = {
			var_0_5(-40, -40, 0),
			var_0_5(-100, -100, 0),
			var_0_5(20, 100, 0),
			var_0_5(-40, -160, 0)
		}
		local var_13_5 = {
			var_0_5(-20, 50, 0),
			var_0_5(-40, -100, 0),
			var_0_5(-100, -100, 0),
			var_0_5(20, -100, 0),
			var_0_5(-40, -160, 0)
		}
		local var_13_6 = {
			var_0_5(-40, 0, 0),
			var_0_5(-40, -80, 0),
			var_0_5(-40, -160, 0),
			var_0_5(-40, -240, 0),
			var_0_5(-120, -120, 0),
			var_0_5(40, -120, 0)
		}
		local var_13_7 = {
			var_0_5(-120, 0, 0),
			var_0_5(-80, -80, 0),
			var_0_5(-40, -160, 0),
			var_0_5(0, -240, 0),
			var_0_5(40, -320, 0)
		}
		local var_13_8 = {
			var_0_5(-160, 80, 0),
			var_0_5(-120, 0, 0),
			var_0_5(-80, -80, 0),
			var_0_5(-40, -160, 0),
			var_0_5(0, -240, 0),
			var_0_5(40, -320, 0)
		}
		local var_13_9 = {
			var_0_5(-200, -160, 0),
			var_0_5(-120, -160, 0),
			var_0_5(-40, -160, 0),
			var_0_5(40, -160, 0),
			var_0_5(120, -160, 0),
			var_0_5(200, -160, 0)
		}

		if arg_13_1 < 4 then
			for iter_13_0 = 1, arg_13_1 do
				self._enemy_ship_team_intercept[iter_13_0].transform.localPosition = var_13_0[iter_13_0]
			end
		elseif arg_13_1 >= 4 then
			if not self._enemy_formation_id or self._enemy_formation_id == 1 then
				for iter_13_1 = 1, arg_13_1 do
					self._enemy_ship_team_intercept[iter_13_1].transform.localPosition = var_13_1[iter_13_1]
				end
			elseif self._enemy_formation_id and self._enemy_formation_id ~= 1 then
				if self._enemy_formation_id == 2 then
					if arg_13_1 == 4 or arg_13_1 == 6 then
						for iter_13_2 = 1, arg_13_1 do
							self._enemy_ship_team_intercept[iter_13_2].transform.localPosition = var_13_3[iter_13_2]
						end
					elseif arg_13_1 == 5 then
						for iter_13_3 = 1, arg_13_1 do
							self._enemy_ship_team_intercept[iter_13_3].transform.localPosition = var_13_3[iter_13_3]
						end
					end
				elseif self._enemy_formation_id == 3 then
					if arg_13_1 == 4 then
						for iter_13_4 = 1, arg_13_1 do
							self._enemy_ship_team_intercept[iter_13_4].transform.localPosition = var_13_4[iter_13_4]
						end
					elseif arg_13_1 == 5 then
						for iter_13_5 = 1, arg_13_1 do
							self._enemy_ship_team_intercept[iter_13_5].transform.localPosition = var_13_5[iter_13_5]
						end
					elseif arg_13_1 == 6 then
						for iter_13_6 = 1, arg_13_1 do
							self._enemy_ship_team_intercept[iter_13_6].transform.localPosition = var_13_6[iter_13_6]
						end
					end
				elseif self._enemy_formation_id == 4 then
					if arg_13_1 == 4 or arg_13_1 == 5 then
						for iter_13_7 = 1, arg_13_1 do
							self._enemy_ship_team_intercept[iter_13_7].transform.localPosition = var_13_7[iter_13_7]
						end
					elseif arg_13_1 == 6 then
						for iter_13_8 = 1, arg_13_1 do
							self._enemy_ship_team_intercept[iter_13_8].transform.localPosition = var_13_8[iter_13_8]
						end
					end
				elseif self._enemy_formation_id == 5 then
					for iter_13_9 = 1, arg_13_1 do
						self._enemy_ship_team_intercept[iter_13_9].transform.localPosition = var_13_9[iter_13_9]
					end
				end
			end
		end
	end

	function arg_1_0:__set_transition_time()
		self._transition_time = 2
		self._transition_time = ({
			2,
			3,
			4,
			5,
			6,
			7
		})[#self._can_attack_ships.pre] or 2
	end

	function arg_1_0:__set_camera_new_info()
		var_0_1:getUIRoot().parent.transform:GetComponent("Canvas").worldCamera = self._bvr_camera
		self._control.bvr_camera.transform.localPosition = var_0_5(-1000, -728, -270)
		self._control.bvr_camera.animation.playAutomatically = false
	end

	function arg_1_0:__set_shadow_pos()
		self._control.shadow.transform.localRotation = var_0_6.Euler(-40, 0, 0)
		self._control.shadow.transform.localPosition = var_0_5(0, -var_0_3.width / 3, 188)
		self._control.shadow.rectTransform.sizeDelta = var_0_4(var_0_3.width, var_0_3.height)
		self._control.shadow.transform.localScale = var_0_5(1.5, 1.5, 1)
	end

	function arg_1_0:__set_normal_info()
		self._radar_inside_ani = self._control.player_ship_team.radar.radar_inside:GetComponent(typeof(UnityEngine.Animation))

		self._control.player_ship_team.radar:SetActive(false)

		self._control.player_ship_team.radar.transform.localScale = var_0_5(0, 0, 0.1)

		self._control.player_ship_team.radar.radar_inside.radar_wave:SetActive(false)
		self._control.player_ship_team:SetActive(false)
		self._control.player_ship_team.light:SetActive(false)
		self._control.bvr_camera.sea_info.player:SetActive(false)
		self._control.bvr_camera.sea_info.enemy:SetActive(false)
		self._control.player_ship_team.band_1:SetActive(false)
		self._control.player_ship_team.band_2:SetActive(false)
		self._control.enemy_ship_team.light:SetActive(false)
		self._control.enemy_ship_team.find_ani:SetActive(false)
		self._control.bvr_camera.find_enemy_radar:SetActive(false)
		self._control.bvr_camera_two:SetActive(false)
		self._control.intercpet_attack_video:SetActive(false)
		self._control.bvr_camera.player_bvr_list:SetActive(false)
		self:__set_ui_adaptation()

		local var_17_1 = var_0_1:getInstance("cover")

		if var_17_1 then
			var_17_1:setVisible(false)
		end

		self._control.intercpet_attack_video.bg.transform:DOScale(0, 0.1)
		self._control.bvr_camera.transition_1:SetActive(false)
		self._control.bvr_camera.transition_2:SetActive(false)
		self._control.missile_player_one:SetActive(false)
	end

	function arg_1_0:__set_ui_adaptation()
		self._control.bvr_camera.find_enemy_radar.transform.localPosition = var_0_5(186 * (var_0_3.width / var_0_3.height) - 20, self._control.bvr_camera.find_enemy_radar.transform.localPosition.y, self._control.bvr_camera.find_enemy_radar.transform.localPosition.z)
		self._control.bvr_camera.player_bvr_list.transform.localPosition = var_0_5(-212 * (var_0_3.width / var_0_3.height), self._control.bvr_camera.player_bvr_list.transform.localPosition.y, self._control.bvr_camera.player_bvr_list.transform.localPosition.z)
		self._control.bvr_camera.enemy_hp_list.transform.localPosition = var_0_5(129 * (var_0_3.width / var_0_3.height), self._control.bvr_camera.enemy_hp_list.transform.localPosition.y, self._control.bvr_camera.enemy_hp_list.transform.localPosition.z)
		self.three_missile_attack_pos = 45 * (var_0_3.width / var_0_3.height)

		if var_0_3.width / var_0_3.height < 1.35 then
			self.three_missile_attack_pos = self.three_missile_attack_pos * 2
			self._control.player_ship_team.transform.localPosition = var_0_5(self._control.player_ship_team.transform.localPosition.x + 60, self._control.player_ship_team.transform.localPosition.y, self._control.player_ship_team.transform.localPosition.z)
		end

		if var_0_3.width / var_0_3.height < 1.4 then
			self._control.intercpet_attack_video.transform.localPosition = var_0_5(-(var_0_3.width / var_0_3.height) * 100, 100, self._control.intercpet_attack_video.transform.localPosition.z)
		end
	end

	function arg_1_0:__set_player_team_init()
		self._all_missile = {}

		local var_19_0 = {
			self._control.player_ship_team.player_ship_1,
			self._control.player_ship_team.player_ship_2,
			self._control.player_ship_team.player_ship_3,
			self._control.player_ship_team.player_ship_4,
			self._control.player_ship_team.player_ship_5,
			self._control.player_ship_team.player_ship_6
		}

		self._player_team_info = var_19_0

		for iter_19_0, iter_19_1 in pairs(var_19_0) do
			iter_19_1:SetActive(false)
		end

		for iter_19_2, iter_19_3 in pairs(var_19_0) do
			iter_19_3:SetActive(false)
			iter_19_3.change:SetActive(false)

			for iter_19_4 = 1, iter_19_3.missile_arsenal.transform.childCount do
				var_0_9(self._all_missile, iter_19_3.missile_arsenal.transform:GetChild(iter_19_4 - 1).gameObject)
			end
		end

		for iter_19_5, iter_19_6 in pairs(self._all_missile) do
			iter_19_6:SetActive(false)

			iter_19_6.transform.localPosition = var_0_5(0, 20, -40)
			iter_19_6.transform.localRotation = var_0_6.Euler(0, -40, 90)
		end

		self._attack_info = {
			ship_index = {},
			missile_num = {},
			ship_cid = {},
			data_missile_attack = {
				{},
				{},
				{},
				{},
				{},
				{}
			}
		}

		local var_19_1 = {}
		local var_19_2 = {}

		for iter_19_7, iter_19_8 in pairs(self._player_data_info) do
			if iter_19_8.ship_type == 30 or iter_19_8.ship_type == 13 then
				var_0_9(var_19_2, iter_19_8.pos)
			end
		end

		if self._is_campaign_select_into then
			for iter_19_9, iter_19_10 in pairs(self._team_info) do
				if (iter_19_10.type == 30 or iter_19_10.type == 13) and self:__set_can_fire_ship(iter_19_10, true, self._player_data_info) then
					var_0_9(var_19_1, iter_19_10)
				end
			end
		else
			for iter_19_11, iter_19_12 in pairs(self._team_info) do
				if not self._stay_fight then
					if (iter_19_12.data.type == 30 or iter_19_12.data.type == 13) and self:__set_can_fire_ship(iter_19_12, false, self._player_data_info) then
						var_0_9(var_19_1, iter_19_12)
					end
				elseif (iter_19_12.type == 30 or iter_19_12.type == 13) and self:__set_can_fire_ship(iter_19_12, false, self._player_data_info) then
					var_0_9(var_19_1, iter_19_12)
				end
			end
		end

		for iter_19_13, iter_19_14 in pairs(var_19_1) do
			local var_19_4 = 0

			if self._is_campaign_select_into then
				for iter_19_15, iter_19_16 in pairs(iter_19_14.equips) do
					if iter_19_16.carry_type == 3 and var_0_10.find_object_by_cid(iter_19_16.id) then
						if var_0_10.find_object_by_cid(iter_19_16.id).bore_type == 41 then
							var_19_4 = var_19_4 + 2
						elseif iter_19_14.type == 13 then
							var_19_4 = var_19_4 + 2
						end
					end
				end
			elseif not self._stay_fight then
				for iter_19_17, iter_19_18 in pairs(iter_19_14.data.equips) do
					if iter_19_18.carry_type == 3 and var_0_10.find_object_by_cid(iter_19_18.id) then
						if var_0_10.find_object_by_cid(iter_19_18.id).bore_type == 41 then
							var_19_4 = var_19_4 + 2
						elseif iter_19_14.data.type == 13 then
							var_19_4 = var_19_4 + 2
						end
					end
				end
			else
				for iter_19_19, iter_19_20 in pairs(iter_19_14.equips) do
					if iter_19_20.carry_type == 3 and var_0_10.find_object_by_cid(iter_19_20.id) then
						if var_0_10.find_object_by_cid(iter_19_20.id).bore_type == 41 then
							var_19_4 = var_19_4 + 2
						elseif iter_19_14.type == 13 then
							var_19_4 = var_19_4 + 2
						end
					end
				end
			end

			if var_19_4 >= 2 then
				var_0_9(self._attack_info.missile_num, var_19_4)

				if self._is_campaign_select_into then
					var_0_9(self._attack_info.ship_cid, iter_19_14.cid)
				elseif not self._stay_fight then
					var_0_9(self._attack_info.ship_cid, iter_19_14.data.cid)
				else
					var_0_9(self._attack_info.ship_cid, iter_19_14.cid)
				end
			end
		end

		self._can_attack_ships = {
			pre = {},
			cid = {}
		}

		for iter_19_21, iter_19_22 in pairs(self._attack_info.ship_cid) do
			for iter_19_23, iter_19_24 in pairs(self._now_damage_info) do
				if iter_19_22 == iter_19_24.cid then
					var_0_9(self._can_attack_ships.cid, iter_19_24.cid)
				end
			end
		end

		for iter_19_25, iter_19_26 in pairs(self._attack_info.ship_index) do
			for iter_19_27, iter_19_28 in pairs(self._player_team_info) do
				if iter_19_26 == iter_19_27 then
					var_0_9(self._can_attack_ships.pre, iter_19_28)
				end
			end

			for iter_19_29, iter_19_30 in pairs(self._now_damage_info) do
				if iter_19_26 == iter_19_30.ship_index then
					var_0_9(self._attack_info.data_missile_attack[iter_19_26], iter_19_30)
				end
			end
		end

		self._all_attack_missile = {}

		for iter_19_31, iter_19_32 in pairs(self._can_attack_ships.pre) do
			for iter_19_33, iter_19_34 in pairs(self._attack_info.data_missile_attack) do
				if next(iter_19_34) then
					for iter_19_35 = 1, #iter_19_34 do
						var_0_9(self._all_attack_missile, iter_19_32.missile_arsenal.transform:GetChild(iter_19_35 - 1).gameObject)
					end
				end
			end
		end

		self._now_missiles = self._all_attack_missile
		self._new_video_intercept_player_missiles = {}
		self._new_intercept_player_missiles = {}
		self._all_intercept_player_missiles = {}

		for iter_19_36 = 1, self._control.intercept_attack_pro.missile_player.transform.childCount do
			self._control.intercept_attack_pro.missile_player.transform:GetChild(iter_19_36 - 1).gameObject:SetActive(false)
		end

		self._save_un_intercepted_missiles = {}

		local var_19_5 = 0
		local var_19_6 = 0

		for iter_19_37, iter_19_38 in pairs(self._now_damage_info) do
			if iter_19_38.atk_state == "miss" or iter_19_38.atk_state == "hit" then
				var_19_5 = var_19_5 + 1

				var_0_9(self._save_un_intercepted_missiles, iter_19_38)
			elseif iter_19_38.atk_state == "intercepted" then
				var_19_6 = var_19_6 + 1
			end
		end

		self._no_missile_attack = false
		self._set_attack_time = 2

		if #self._save_un_intercepted_missiles == 0 then
			self._no_missile_attack = true
		end

		self._intercepted_missile_num = var_19_6
		self._hit_missile_num = var_19_5

		for iter_19_39 = 1, var_19_5 do
			var_0_9(self._all_intercept_player_missiles, self._control.intercept_attack_pro.missile_player.transform:GetChild(iter_19_39 - 1).gameObject)
			var_0_9(self._new_intercept_player_missiles, self._control.missile_player_one.transform:GetChild(iter_19_39 - 1).gameObject)
			var_0_9(self._new_video_intercept_player_missiles, self._control.intercpet_attack_video.bg.missile_player_radar.transform:GetChild(iter_19_39 - 1).gameObject)
		end
	end

	function arg_1_0:__set_can_fire_ship(arg_20_1, arg_20_2)
		local var_20_0 = false

		if arg_20_2 then
			local var_20_1 = false
			local var_20_2 = false

			for iter_20_0, iter_20_1 in pairs(arg_20_1.equips) do
				if var_0_10.find_object_by_cid(iter_20_1.id) and var_0_10.find_object_by_cid(iter_20_1.id).type == 32 then
					var_20_2 = true

					break
				end
			end

			for iter_20_2, iter_20_3 in pairs(arg_20_1.equips) do
				if iter_20_3.carry_type == 3 and iter_20_3.num >= 2 and var_0_10.find_object_by_cid(iter_20_3.id) and var_0_10.find_object_by_cid(iter_20_3.id).bore_type == 41 then
					var_20_1 = true
				elseif arg_20_1.type == 13 then
					var_20_1 = true
				end
			end

			if var_20_1 and var_20_2 then
				var_20_0 = true
			end
		else
			local var_20_3 = false
			local var_20_4 = false

			if not self._stay_fight then
				for iter_20_4, iter_20_5 in pairs(arg_20_1.data.equips) do
					if var_0_10.find_object_by_cid(iter_20_5.id) and var_0_10.find_object_by_cid(iter_20_5.id).type == 32 then
						var_20_4 = true

						break
					end
				end

				for iter_20_6, iter_20_7 in pairs(arg_20_1.data.equips) do
					if iter_20_7.carry_type == 3 and var_0_10.find_object_by_cid(iter_20_7.id) then
						if var_0_10.find_object_by_cid(iter_20_7.id).bore_type == 41 then
							if iter_20_7.num >= 2 then
								var_20_3 = true
							elseif iter_20_7.num < 2 then
								for iter_20_8, iter_20_9 in pairs(self._now_damage_info) do
									if arg_20_1.data.cid == iter_20_9.cid then
										var_20_3 = true
									end
								end
							end
						elseif arg_20_1.data.type == 13 then
							if iter_20_7.num >= 2 then
								var_20_3 = true
							elseif iter_20_7.num < 2 then
								for iter_20_10, iter_20_11 in pairs(self._now_damage_info) do
									if arg_20_1.data.cid == iter_20_11.cid then
										var_20_3 = true
									end
								end
							end
						end
					end
				end

				if var_20_3 and var_20_4 then
					var_20_0 = true
				end
			else
				for iter_20_12, iter_20_13 in pairs(arg_20_1.equips) do
					if var_0_10.find_object_by_cid(iter_20_13.id) and var_0_10.find_object_by_cid(iter_20_13.id).type == 32 then
						var_20_4 = true

						break
					end
				end

				for iter_20_14, iter_20_15 in pairs(arg_20_1.equips) do
					if iter_20_15.carry_type == 3 and var_0_10.find_object_by_cid(iter_20_15.id) then
						if var_0_10.find_object_by_cid(iter_20_15.id).bore_type == 41 then
							if iter_20_15.num >= 2 then
								var_20_3 = true
							elseif iter_20_15.num < 2 then
								for iter_20_16, iter_20_17 in pairs(self._now_damage_info) do
									if arg_20_1.cid == iter_20_17.cid then
										var_20_3 = true
									end
								end
							end
						elseif arg_20_1.type == 13 then
							if iter_20_15.num >= 2 then
								var_20_3 = true
							elseif iter_20_15.num < 2 then
								for iter_20_18, iter_20_19 in pairs(self._now_damage_info) do
									if arg_20_1.cid == iter_20_19.cid then
										var_20_3 = true
									end
								end
							end
						end
					end
				end
			end

			if var_20_3 and var_20_4 then
				var_20_0 = true
			end
		end

		if var_20_0 then
			if arg_20_2 then
				for iter_20_20, iter_20_21 in pairs(self._player_data_info) do
					if iter_20_21.cid == arg_20_1.cid then
						var_0_9(self._attack_info.ship_index, iter_20_21.index)
					end
				end
			else
				for iter_20_22, iter_20_23 in pairs(self._player_data_info) do
					if not self._stay_fight then
						if iter_20_23.cid == arg_20_1.data.cid then
							var_0_9(self._attack_info.ship_index, iter_20_23.index)
						end
					elseif iter_20_23.cid == arg_20_1.cid then
						var_0_9(self._attack_info.ship_index, iter_20_23.index)
					end
				end
			end
		end

		return var_20_0
	end

	function arg_1_0:__set_enemy_team_init()
		self._control.enemy_ship_team.transform.localPosition = var_0_5(1100, 360, 0)
		self._control.intercept_attack_pro.enemy_intercept_ships.transform.localPosition = var_0_5(0, 100, 0)

		local var_21_0 = {
			self._control.enemy_ship_team.enemy_ship_1,
			self._control.enemy_ship_team.enemy_ship_2,
			self._control.enemy_ship_team.enemy_ship_3,
			self._control.enemy_ship_team.enemy_ship_4,
			self._control.enemy_ship_team.enemy_ship_5,
			self._control.enemy_ship_team.enemy_ship_6
		}

		self._enemy_team_info = var_21_0

		for iter_21_0, iter_21_1 in pairs(var_21_0) do
			iter_21_1:SetActive(false)
			iter_21_1.change:SetActive(false)
			iter_21_1.halo:SetActive(false)
			iter_21_1.aim:SetActive(false)
			iter_21_1.missile_intercept:SetActive(false)
			iter_21_1.missile_player_attack:SetActive(false)
		end

		local var_21_1 = {
			self._control.intercpet_attack_video.bg.enemy_ship_1,
			self._control.intercpet_attack_video.bg.enemy_ship_2,
			self._control.intercpet_attack_video.bg.enemy_ship_3,
			self._control.intercpet_attack_video.bg.enemy_ship_4,
			self._control.intercpet_attack_video.bg.enemy_ship_5,
			self._control.intercpet_attack_video.bg.enemy_ship_6
		}

		self._enemy_team_vdeio_info = var_21_1

		for iter_21_2, iter_21_3 in pairs(var_21_1) do
			iter_21_3:SetActive(false)
			iter_21_3.missile_intercept:SetActive(false)
			iter_21_3.missile_player_attack:SetActive(false)
		end

		self._control.intercept_attack_pro:SetActive(false)

		local var_21_2 = {
			self._control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_1,
			self._control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_2,
			self._control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_3,
			self._control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_4,
			self._control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_5,
			self._control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_6
		}

		self._enemy_team_intercept = self._control.intercept_attack_pro.enemy_intercept_ships
		self._enemy_ship_team_intercept = var_21_2

		for iter_21_4, iter_21_5 in pairs(var_21_2) do
			iter_21_5:SetActive(false)
			iter_21_5.change:SetActive(false)
			iter_21_5.aim:SetActive(false)
			iter_21_5.halo:SetActive(false)
			iter_21_5.halo.transform:DOScale(0.1, 0.1)
		end

		local var_21_3 = {
			self._control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_1.hp,
			self._control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_2.hp,
			self._control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_3.hp,
			self._control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_4.hp,
			self._control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_5.hp,
			self._control.intercept_attack_pro.enemy_intercept_ships.enemy_ship_6.hp
		}

		self._enemy_all_hp_info = var_21_3

		for iter_21_6, iter_21_7 in pairs(var_21_3) do
			iter_21_7:SetActive(false)
		end

		self._need_intercept = false

		for iter_21_8, iter_21_9 in pairs(self._now_damage_info) do
			if iter_21_9.atk_state == "intercepted" then
				self._need_intercept = true

				break
			end
		end

		if self._need_intercept then
			for iter_21_10, iter_21_11 in pairs(var_21_0) do
				iter_21_11.missile_intercept:SetActive(false)
				iter_21_11.missile_player_attack:SetActive(false)
			end
		end

		self._save_have_intercepted_ships = 0
		self._now_have_intercepted = 0
		self._all_enemy_is_die = false

		local var_21_4 = 0

		for iter_21_12, iter_21_13 in pairs(self._enemy_data_info) do
			if iter_21_13.now_hp == 0 then
				var_21_4 = var_21_4 + 1
			end
		end

		if var_21_4 == #self._enemy_data_info then
			self._all_enemy_is_die = true
		end
	end

	function arg_1_0:__set_no_intercept_missiles_info()
		self._all_enemy_missile_active = false

		self._control.missile_player_one:SetActive(false)
		self._control.intercpet_attack_video.bg.missile_player_radar:SetActive(false)
	end

	function arg_1_0:__set_intercept_missiles_info()
		self._save_have_intercepted_ships = 1

		local var_23_0 = {}
		local var_23_3 = {}

		for iter_23_0, iter_23_1 in pairs(self._enemy_data_info) do
			if iter_23_1.ship_type == 29 or iter_23_1.ship_type == 24 or iter_23_1.ship_type == 97 or iter_23_1.ship_type == 26 then
				var_0_9(var_23_0, iter_23_1)
			end
		end

		for iter_23_2, iter_23_3 in pairs(var_23_0) do
			local var_23_4 = 0

			for iter_23_4, iter_23_5 in pairs(iter_23_3.equips) do
				if var_0_10.find_object_by_cid(iter_23_5) and var_0_10.find_object_by_cid(iter_23_5).type == 33 then
					-- block empty
				end

				if var_0_10.find_object_by_cid(iter_23_5) and (var_0_10.find_object_by_cid(iter_23_5).type == 35 or var_0_10.find_object_by_cid(iter_23_5).type == 38) then
					var_23_4 = var_23_4 + 1
				end
			end

			var_23_3[iter_23_2] = {
				index = iter_23_3.index,
				equips_num = var_23_4
			}
		end

		self._small_intercepted_ship_info = var_23_3
		self._save_have_intercepted_ships = #var_23_0

		local var_23_7 = 1

		self._now_have_intercepted = var_23_3[1].equips_num
		self._all_enemy_missile_active = false

		local var_23_8 = 0

		for iter_23_6, iter_23_7 in pairs(var_23_3) do
			var_23_8 = var_23_8 + iter_23_7.equips_num
		end

		self._save_all_enemy_intercepted_missile = var_23_8

		for iter_23_8 = 1, #var_23_3 do
			if var_23_3[1].equips_num < self._intercepted_missile_num - var_23_3[1].equips_num then
				var_23_7 = var_23_7 + 1
			end
		end

		self._need_intercepted_ships = var_23_7

		self._control.missile_player_one:SetActive(false)
		self._control.intercpet_attack_video.bg.missile_player_radar:SetActive(false)
	end

	function arg_1_0:__set_player_ships_header_ready()
		self._all_missile_attack_ships_header = {}

		local var_24_0 = {
			self._control.bvr_camera.player_bvr_list.attack_header_1,
			self._control.bvr_camera.player_bvr_list.attack_header_2,
			self._control.bvr_camera.player_bvr_list.attack_header_3,
			self._control.bvr_camera.player_bvr_list.attack_header_4,
			self._control.bvr_camera.player_bvr_list.attack_header_5,
			self._control.bvr_camera.player_bvr_list.attack_header_6
		}

		self._all_missile_attack_ships_header = var_24_0

		for iter_24_0, iter_24_1 in pairs(var_24_0) do
			iter_24_1:SetActive(false)
			iter_24_1.header:SetActive(false)
			iter_24_1.missile:SetActive(false)
		end

		for iter_24_2 = 1, #var_24_0 do
			for iter_24_3 = 1, 3 do
				var_24_0[iter_24_2].missile.missile_use_info.transform:GetChild(iter_24_3 - 1).gameObject.transform:GetChild(0).gameObject:SetActive(false)

				var_24_0[iter_24_2].missile.missile_use_info.transform:GetChild(iter_24_3 - 1).gameObject.image.sprite = self:loadSprite(var_0_11.bvr_missile_type.missile_attack_close)

				var_24_0[iter_24_2].missile.missile_use_info.transform:GetChild(iter_24_3 - 1).gameObject.transform:GetChild(1).gameObject:SetActive(false)
			end
		end

		for iter_24_4, iter_24_5 in pairs(self._attack_info.data_missile_attack) do
			if next(iter_24_5) then
				for iter_24_6 = 1, #iter_24_5 do
					var_24_0[iter_24_4].missile.missile_use_info.transform:GetChild(iter_24_6 - 1).gameObject.image.sprite = self:loadSprite(var_0_11.bvr_missile_type.missile_attack_open)

					var_24_0[iter_24_4].missile.missile_use_info.transform:GetChild(iter_24_6 - 1).gameObject.transform:GetChild(0).gameObject:SetActive(true)
					var_24_0[iter_24_4].missile.missile_use_info.transform:GetChild(iter_24_6 - 1).gameObject.transform:GetChild(1).gameObject:SetActive(true)
				end
			end
		end
	end

	function arg_1_0:__init_start_fight()
		self._control.bvr_camera.sea_info.player:SetActive(true)
		self._control.player_ship_team:SetActive(true)

		for iter_25_0 = 1, #self._team_info do
			self._player_team_info[iter_25_0]:SetActive(true)
		end

		self:__set_num_ships_pos(#self._team_info)

		self._animation_seq = {}

		local var_25_0 = self:autoKillDOTween(var_0_8.Sequence())

		var_25_0:AppendInterval(1.5)
		self._radar_inside_ani:Play()
		self._control.player_ship_team.radar:SetActive(true)
		self._control.player_ship_team.radar.radar_inside.radar_wave:SetActive(true)
		self._control.bvr_camera.animation:Play()
		var_25_0:AppendCallback(function()
			self._control.player_ship_team.band_1:SetActive(true)
			self._control.player_ship_team.band_2:SetActive(false)
			self._control.player_ship_team.band_1.transform:DORotate(var_0_5(0, 0, 170), 1.5)
			self._control.player_ship_team.band_2.transform:DORotate(var_0_5(0, 0, 170), 1.5)
			self._control.player_ship_team.radar.transform:DOScale(1, 1)
			self._control.bvr_camera.find_enemy_radar:SetActive(true)
		end)
	end

	function arg_1_0:__init_end_first_fight()
		local var_27_0 = self:autoKillDOTween(var_0_8.Sequence())

		self._animation_seq = var_27_0

		local var_27_1 = self._control.missile_player_one.transform.childCount

		self._player_all_radar_missile, self._player_all_missile = self._control.intercpet_attack_video.bg.missile_player_radar.transform.childCount, self._control.missile_player_one.transform.childCount

		var_27_0:AppendInterval(5)
		var_27_0:AppendCallback(function()
			self._control.bvr_camera.player_bvr_list:SetActive(true)

			for iter_28_0, iter_28_1 in pairs(self._attack_info.ship_index) do
				self._all_missile_attack_ships_header[iter_28_1]:SetActive(true)
				self._all_missile_attack_ships_header[iter_28_1].header:SetActive(true)

				self._all_missile_attack_ships_header[iter_28_1].header.header_img.image.sprite = self:loadSprite(var_0_14(var_0_11.bvr_player_header, self._attack_info.ship_cid[iter_28_0]))
			end
		end)
		var_27_0:AppendInterval(#self._can_attack_ships.pre)
		var_27_0:AppendCallback(function()
			for iter_29_0, iter_29_1 in pairs(self._now_missiles) do
				iter_29_1:SetActive(true)
			end

			for iter_29_2, iter_29_3 in pairs(self._attack_info.ship_index) do
				self._player_team_info[iter_29_3].change:SetActive(true)
				self._player_team_info[iter_29_3].animation:Play()
			end
		end)
		var_27_0:AppendInterval(2 + #self._can_attack_ships.pre)
		var_27_0:AppendCallback(function()
			self._control.intercpet_attack_video:SetActive(true)

			self._control.intercpet_attack_video.bg.transform:DOScale(var_0_5(1, 0.1, 0), 0.2):SetAutoKill(true).onComplete = function()
				self._control.intercpet_attack_video.bg.transform:DOScale(var_0_5(1, 1, 0), 0.3)
			end

			self._control.bvr_camera.find_enemy_radar:SetActive(false)

			for iter_30_0 = 1, #self._enemy_info do
				self._enemy_team_vdeio_info[iter_30_0]:SetActive(true)
			end

			for iter_30_1, iter_30_2 in pairs(self._enemy_ship_team_intercept) do
				self._enemy_team_vdeio_info[iter_30_1].missile_intercept:SetActive(false)
				self._enemy_team_vdeio_info[iter_30_1].missile_player_attack:SetActive(false)

				for iter_30_3 = 1, 3 do
					self._enemy_team_vdeio_info[iter_30_1].missile_intercept.transform:GetChild(iter_30_3 - 1).gameObject:SetActive(false)
					self._enemy_team_vdeio_info[iter_30_1].missile_player_attack.transform:GetChild(iter_30_3 - 1).gameObject:SetActive(false)
				end
			end

			for iter_30_4 = 1, var_27_1 do
				self._control.intercpet_attack_video.bg.missile_player_radar.transform:GetChild(iter_30_4 - 1).gameObject:SetActive(false)
			end

			self._control.intercpet_attack_video.bg.missile_player_radar:SetActive(true)

			if self._intercepted_missile_num ~= 0 then
				for iter_30_5 = 1, self._intercepted_missile_num do
					if self._new_video_intercept_player_missiles[iter_30_5] then
						self._new_video_intercept_player_missiles[iter_30_5]:SetActive(true)
					end
				end
			elseif self._intercepted_missile_num == 0 then
				for iter_30_6 = 1, #self._save_un_intercepted_missiles do
					if self._new_video_intercept_player_missiles[iter_30_6] then
						self._new_video_intercept_player_missiles[iter_30_6]:SetActive(true)
					end
				end
			end

			local var_30_1 = {}
			local var_30_3 = 0

			if self._save_all_enemy_intercepted_missile and self._save_all_enemy_intercepted_missile > 0 then
				if #self._now_damage_info <= self._save_all_enemy_intercepted_missile then
					for iter_30_7, iter_30_8 in pairs(self._small_intercepted_ship_info) do
						if var_30_3 <= #self._now_damage_info then
							var_0_9(var_30_1, iter_30_8)

							var_30_3 = var_30_3 + iter_30_8.equips_num
						end
					end
				elseif self._hit_missile_num > 0 and self._intercepted_missile_num > 0 then
					for iter_30_9, iter_30_10 in pairs(self._small_intercepted_ship_info) do
						var_0_9(var_30_1, iter_30_10)
					end
				end

				for iter_30_11, iter_30_12 in pairs(self._attack_info.data_missile_attack) do
					if next(iter_30_12) then
						for iter_30_13, iter_30_14 in pairs(iter_30_12) do
							if iter_30_14.atk_state == "intercepted" then
								self._all_missile_attack_ships_header[iter_30_14.ship_index].missile.missile_use_info.transform:GetChild(iter_30_13 - 1).gameObject.transform:GetChild(1).gameObject.image.color = var_0_20.New(1, 0, 0)
							end
						end
					end
				end

				if #var_30_1 == 1 then
					if #self._now_damage_info <= var_30_1[1].equips_num then
						self._enemy_team_vdeio_info[var_30_1[1].index].missile_intercept:SetActive(true)
						self._enemy_team_vdeio_info[var_30_1[1].index].missile_player_attack:SetActive(true)

						if #self._now_damage_info <= var_30_1[1].equips_num then
							for iter_30_15 = 1, #self._now_damage_info do
								if self._now_damage_info[iter_30_15].atk_state == "intercepted" then
									self._enemy_team_vdeio_info[var_30_1[1].index].missile_intercept.transform:GetChild(iter_30_15 - 1).gameObject:SetActive(true)
									self._enemy_team_vdeio_info[var_30_1[1].index].missile_player_attack.transform:GetChild(iter_30_15 - 1).gameObject:SetActive(true)
								end
							end
						end
					end
				elseif #var_30_1 > 1 then
					if self._intercepted_missile_num % 3 == 0 and #var_30_1 == 2 and self._intercepted_missile_num < 6 then
						self._enemy_team_vdeio_info[var_30_1[1].index].missile_intercept:SetActive(true)
						self._enemy_team_vdeio_info[var_30_1[1].index].missile_player_attack:SetActive(true)

						for iter_30_16 = 1, 3 do
							self._enemy_team_vdeio_info[var_30_1[1].index].missile_intercept.transform:GetChild(iter_30_16 - 1).gameObject:SetActive(true)
							self._enemy_team_vdeio_info[var_30_1[1].index].missile_player_attack.transform:GetChild(iter_30_16 - 1).gameObject:SetActive(true)
						end
					elseif self._intercepted_missile_num % 3 == 0 and #var_30_1 >= 2 and self._intercepted_missile_num >= 6 then
						for iter_30_17 = 1, #var_30_1 do
							self._enemy_team_vdeio_info[var_30_1[iter_30_17].index].missile_intercept:SetActive(true)
							self._enemy_team_vdeio_info[var_30_1[iter_30_17].index].missile_player_attack:SetActive(true)

							for iter_30_18 = 1, 3 do
								self._enemy_team_vdeio_info[var_30_1[iter_30_17].index].missile_intercept.transform:GetChild(iter_30_18 - 1).gameObject:SetActive(true)
								self._enemy_team_vdeio_info[var_30_1[iter_30_17].index].missile_player_attack.transform:GetChild(iter_30_18 - 1).gameObject:SetActive(true)
							end
						end
					elseif self._intercepted_missile_num % 3 ~= 0 then
						for iter_30_19 = 1, #var_30_1 - 1 do
							self._enemy_team_vdeio_info[var_30_1[iter_30_19].index].missile_intercept:SetActive(true)
							self._enemy_team_vdeio_info[var_30_1[iter_30_19].index].missile_player_attack:SetActive(true)

							for iter_30_20 = 1, 3 do
								self._enemy_team_vdeio_info[var_30_1[iter_30_19].index].missile_intercept.transform:GetChild(iter_30_20 - 1).gameObject:SetActive(true)
								self._enemy_team_vdeio_info[var_30_1[iter_30_19].index].missile_player_attack.transform:GetChild(iter_30_20 - 1).gameObject:SetActive(true)
							end
						end

						self._enemy_team_vdeio_info[var_30_1[#var_30_1 - 1].index].missile_intercept:SetActive(true)
						self._enemy_team_vdeio_info[var_30_1[#var_30_1 - 1].index].missile_player_attack:SetActive(true)

						for iter_30_21 = 1, self._intercepted_missile_num % 3 do
							self._enemy_team_vdeio_info[var_30_1[#var_30_1 - 1].index].missile_intercept.transform:GetChild(iter_30_21 - 1).gameObject:SetActive(true)
							self._enemy_team_vdeio_info[var_30_1[#var_30_1 - 1].index].missile_player_attack.transform:GetChild(iter_30_21 - 1).gameObject:SetActive(true)
						end
					end
				end
			end

			if self._no_missile_attack then
				self._set_attack_time = self._set_attack_time + 0.5
			end
		end)
		var_27_0:AppendInterval(self._set_attack_time)
		var_27_0:AppendCallback(function()
			if self._no_missile_attack then
				local var_32_0 = var_0_1:getInstance("fight_info")

				if var_32_0 then
					var_32_0._control.bg.info_bg.enemy_info_bg.canvasGroup.blocksRaycasts = false
				end

				local var_32_1 = io.open(app:getSystem():getWritePath() .. "battlereport", "wb")

				var_32_1:write("[超视距打击信息]" .. "\n" .. self._encode_report_info .. "\n")
				var_32_1:close()
				var_0_1:createInstance("loading"):show(true, nil, false, "")
				var_0_1:createInstance("bvr_result"):show(self._data, self._is_campaign_select_into, self._enemy_data_info, self._now_battle_type, self._enemy_team_name)
				self:reset()
			end
		end)
		var_27_0:AppendInterval(0.1)
		var_27_0:AppendCallback(function()
			self._control.bvr_camera.transition_1:SetActive(false)
			self._control.bvr_camera.transition_2:SetActive(false)
			self._control.bvr_camera.transition_1:SetActive(true)
			self._control.bvr_camera.transition_2:SetActive(true)
			self._control.bvr_camera.transition_1.transition_child:GetComponent("ParticleSystem"):Play()
			self._control.bvr_camera.transition_2.transition_child:GetComponent("ParticleSystem"):Play()
		end)
		var_27_0:AppendInterval(1.1)
		var_27_0:AppendCallback(function()
			self._control.player_ship_team.band_1:SetActive(false)
			self._control.player_ship_team.band_2:SetActive(false)
			self._control.player_ship_team.radar:SetActive(false)
			self._control.player_ship_team.light:SetActive(false)

			for iter_34_0 = 1, #self._team_info do
				self._player_team_info[iter_34_0]:SetActive(false)
			end

			self._control.intercpet_attack_video:SetActive(false)
			self._control.bvr_camera.transition_1:SetActive(false)
			self._control.bvr_camera.transition_2:SetActive(false)

			self._control.intercept_attack_pro.missile_player.transform.localPosition = var_0_5(-(var_0_3.width / 2 + self._control.intercept_attack_pro.missile_player.rectTransform.rect.width) - 400, self._control.intercept_attack_pro.missile_player.transform.localPosition.y, self._control.intercept_attack_pro.missile_player.transform.localPosition.z)

			for iter_34_1 = 1, self._hit_missile_num do
				self._all_intercept_player_missiles[iter_34_1]:SetActive(true)
			end

			self._control.intercept_attack_pro:SetActive(true)

			for iter_34_2 = 1, #self._enemy_info do
				self._enemy_ship_team_intercept[iter_34_2]:SetActive(true)
			end

			self._enemy_team_intercept.transform.localPosition = var_0_5(120, self._enemy_team_intercept.transform.localPosition.y - 310, self._enemy_team_intercept.transform.localPosition.z)

			self:__set_intercept_one_enemy_ships_pos(#self._enemy_info)
		end)
		var_27_0:AppendInterval(0.1)
		var_27_0:AppendCallback(function()
			self._control.bvr_camera.enemy_hp_list:SetActive(false)

			self._start_attack_and_intercept = true

			for iter_35_0 = 1, #self._save_un_intercepted_missiles do
				if self._save_un_intercepted_missiles[iter_35_0].atk_state == "miss" then
					self._enemy_start_missile_intercept = true

					local var_35_0 = lan_rand(200, 300)

					self._all_intercept_player_missiles[iter_35_0].transform.localPosition = var_0_5(0, 0, 0)
					self._all_intercept_player_missiles[iter_35_0].transform:DOLocalMove(var_0_5(self._enemy_ship_team_intercept[self._save_un_intercepted_missiles[iter_35_0].target].transform.localPosition.x + Mathf.Abs(self._control.intercept_attack_pro.missile_player.transform.localPosition.x) + var_35_0, self._enemy_ship_team_intercept[self._save_un_intercepted_missiles[iter_35_0].target].transform.localPosition.y + var_35_0, Mathf.Abs(self._control.intercept_attack_pro.missile_player.transform.localPosition.z) - self.three_missile_attack_pos), 0.5 + iter_35_0 / 3):SetEase(DG.Tweening.Ease.InQuart):SetAutoKill(true).onComplete = function()
						self._all_intercept_player_missiles[iter_35_0]:SetActive(false)
					end
				elseif self._save_un_intercepted_missiles[iter_35_0].atk_state == "hit" then
					self._enemy_start_missile_intercept = true
					self._all_intercept_player_missiles[iter_35_0].transform.localPosition = var_0_5(0, 0, 0)
					self._all_intercept_player_missiles[iter_35_0].transform:DOLocalMove(var_0_5(self._enemy_ship_team_intercept[self._save_un_intercepted_missiles[iter_35_0].target].transform.localPosition.x + Mathf.Abs(self._control.intercept_attack_pro.missile_player.transform.localPosition.x) + 120, self._enemy_ship_team_intercept[self._save_un_intercepted_missiles[iter_35_0].target].transform.localPosition.y, Mathf.Abs(self._control.intercept_attack_pro.missile_player.transform.localPosition.z) - self.three_missile_attack_pos), 0.5 + iter_35_0 / 3):SetEase(DG.Tweening.Ease.InQuart):SetAutoKill(true).onComplete = function()
						self._all_intercept_player_missiles[iter_35_0]:SetActive(false)

						self._enemy_ship_team_intercept[self._save_un_intercepted_missiles[iter_35_0].target].ship_icon.image:DOColor(var_0_20.New(1, 0.8627450980392157, 0, 1), 1):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true).onComplete = function()
							self._enemy_ship_team_intercept[self._save_un_intercepted_missiles[iter_35_0].target].ship_icon.image:DOColor(var_0_20.New(1, 0, 0, 1), 2)
						end

						self._enemy_ship_team_intercept[self._save_un_intercepted_missiles[iter_35_0].target].halo:SetActive(true)

						self._enemy_ship_team_intercept[self._save_un_intercepted_missiles[iter_35_0].target].halo.transform:DOScale(1.2, 0.2):SetEase(DG.Tweening.Ease.InQuart):SetAutoKill(true).onComplete = function()
							self._enemy_ship_team_intercept[self._save_un_intercepted_missiles[iter_35_0].target].halo.image:DOFade(0, 0.5)

							self._save_surplus_array = {}
							self._start_hp_change = true
							self._change_length = 1
							self._change_time = 0
							self._end_time = 3
							self._end_num = 100

							self._enemy_all_hp_info[self._save_un_intercepted_missiles[iter_35_0].target]:SetActive(true)

							for iter_39_0 = 1, #self._enemy_data_info do
								self._save_surplus_array[iter_39_0] = 1 - self._enemy_data_info[iter_39_0].now_hp / self._enemy_data_info[iter_39_0].hp

								self._enemy_all_hp_info[iter_39_0].hp_bg.hp_2.uIFillAmountChangeEffect:SetNum(0, self._save_surplus_array[iter_39_0] * 100, 100)

								if self._enemy_data_info[iter_39_0].now_hp == 0 then
									self._enemy_ship_team_intercept[self._save_un_intercepted_missiles[iter_35_0].target].ship_icon.image.sprite = self:loadSprite(var_0_11.bvr_attack_enemy_icon.destroy)
									self._enemy_ship_team_intercept[self._save_un_intercepted_missiles[iter_35_0].target].ship_icon.image:DOFade(0, 1):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true).onComplete = function()
										self._enemy_ship_team_intercept[self._save_un_intercepted_missiles[iter_35_0].target].ship_icon:SetActive(false)
									end
								end
							end
						end
					end
				end
			end
		end)
		var_27_0:AppendInterval(4)
		var_27_0:AppendCallback(function()
			local var_41_0 = io.open(app:getSystem():getWritePath() .. "battlereport", "wb")

			var_41_0:write("[超视距打击信息]" .. "\n" .. self._encode_report_info .. "\n")
			var_41_0:close()

			if self._fight_info then
				self._fight_info._control.bg.info_bg.enemy_info_bg.canvasGroup.alpha = 0
			end

			var_0_1:createInstance("loading"):show(true, nil, false, "")

			if self._all_enemy_is_die then
				if self._campaign_select then
					var_0_1:destroyInstance("campaign_select")
				end

				if self._fight_info then
					self._fight_info._control.bg.info_bg.enemy_info_bg.canvasGroup.blocksRaycasts = false
					self._fight_info._control.bg.info_bg.enemy_info_bg.circuity_btn.button.interactable = true

					if self._fight_info._save_have_hd_sprite then
						var_0_11:hd_sprite_half_scale(self._fight_info._control.bg.info_bg.select_formation.left_widget.first_ship_pic.transform, true)
					end
				end

				var_0_16:req_QuitNightBattleReq()
				var_0_16:req_BattleFinishReq()
				self:reset()
			else
				if self._fight_info and (self._now_battle_type == var_0_11.fight_type.score_attack or self._now_battle_type == var_0_11.fight_type.ninth_attack) and not self._fight_info._panel.activeSelf then
					self._fight_info:setVisible(true)
				end

				var_0_1:createInstance("bvr_result"):show(self._data, self._is_campaign_select_into, self._enemy_data_info, self._now_battle_type, self._enemy_team_name)
				self:reset()
			end
		end)
	end

	function arg_1_0:reset()
		local var_42_0 = var_0_1:getInstance("cover")

		if var_42_0 then
			var_42_0:setVisible(true)
		else
			var_0_1:createInstance("cover"):setVisible(true)
		end

		if self._animation_seq then
			self._animation_seq:Kill()

			self._animation_seq = nil
		end

		var_0_1:getUIRoot().parent.transform:GetComponent("Canvas").worldCamera = self._worldCamera

		self:setVisible(false)
	end

	function arg_1_0.__play_animation(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
		arg_43_1.skeletonGraphic.AnimationState:SetAnimation(0, arg_43_2, arg_43_3)
	end

	function arg_1_0:_play_audio(arg_44_1)
		self:playBackgroundMusic(arg_44_1)
	end

	function arg_1_0:_play_into_se(arg_45_1)
		self:playSE(arg_45_1, false)
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_47_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_48_0)
	local var_48_0 = var_0_1:class("bvr_info_pro")

	var_48_0:__initia_lize()

	return var_48_0
end

return var_0_0
