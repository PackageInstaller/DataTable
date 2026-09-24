local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_6 = gamecore.user
local var_0_7 = gamecore.SceneManager
local var_0_8 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_back()
		self:reset()
		self._fight_info:setVisible(true)
	end

	function arg_1_0:__onClick_back_btn()
		local var_3_0 = var_0_1:getInstance("fight_info")

		if var_3_0 then
			var_3_0._control.bg.info_bg.enemy_info_bg.canvasGroup.alpha = 0
		end

		if self._all_enemy_is_die then
			if self._campaign_select then
				var_0_1:destroyInstance("campaign_select")
			end

			if var_3_0 then
				var_3_0._control.bg.info_bg.enemy_info_bg.canvasGroup.blocksRaycasts = false
				var_3_0._control.bg.info_bg.enemy_info_bg.circuity_btn.button.interactable = true

				if var_3_0._save_have_hd_sprite then
					var_0_8:hd_sprite_half_scale(var_3_0._control.bg.info_bg.select_formation.left_widget.first_ship_pic.transform, true)
				end
			end

			local var_3_1 = io.open(app:getSystem():getWritePath() .. "battlereport", "wb")

			var_0_6:req_QuitNightBattleReq()
			var_0_6:req_BattleFinishReq()
			self:reset()
		else
			self:reset()
			var_0_7:loadScene(var_0_8:get_battle_scene_name(), function()
				var_0_1:destroyStateUISet("game")
				var_0_1:createInstance(var_0_8:get_battle_name()):show(self._now_battle_type)
			end)
		end
	end
end

function var_0_0.extend_obj(arg_5_0)
	return
end

return var_0_0
