local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = string.format
local var_0_5 = gameconfig.ship_config
local var_0_6 = gameconfig.skin_config
local var_0_7 = gamecore.user
local var_0_9 = next

gamecore.UILoader:define("marry_ok", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
		self:setVisible(true)

		self._is_evo = arg_2_5
		self._enter_type = arg_2_3 or ""
		self._now_index = arg_2_4 and arg_2_4 or nil

		self:__init_panel(arg_2_1, arg_2_2)
	end

	function arg_1_0:play_animation(arg_3_1, arg_3_2, arg_3_3)
		self:show_marry_anim(true)

		if arg_3_3 then
			local var_3_0 = self._skeleton_animation.state.Complete

			local function var_3_1()
				arg_3_3()

				self._skeleton_animation.state.Complete = var_3_0
			end

			var_3_0 = self._skeleton_animation.state.Complete + var_3_1
			self._skeleton_animation.state.Complete = self._skeleton_animation.state.Complete + var_3_1
			var_3_0 = var_3_0 - var_3_1
		end

		self._skeleton_animation.AnimationState:SetAnimation(0, arg_3_1, arg_3_2)
	end

	function arg_1_0:show_marry_anim(arg_5_1, arg_5_2)
		self._control.mask:SetActive(arg_5_1)

		if not arg_5_1 and arg_5_2 then
			local var_5_0 = var_0_5.find_object_by_cid(arg_5_2).pic_id

			self:playCV(var_0_4("%s/%s_vow.mp3", var_5_0, var_5_0), false, "cv")
		end
	end

	function arg_1_0:set_ship_info(arg_6_1, arg_6_2)
		local var_6_0

		if (arg_6_1 == 10002913 or arg_6_1 == 11002913) and self._enter_type ~= var_0_3.enter_marry_ok_type.ship_map then
			var_6_0 = var_0_3:get_ship_icon(var_0_3.ship_icon.model_normal_l, var_0_3.marry_one, var_0_3.marry_one)
		elseif (arg_6_1 == 10003013 or arg_6_1 == 11003013) and self._enter_type ~= var_0_3.enter_marry_ok_type.ship_map then
			var_6_0 = var_0_3:get_ship_icon(var_0_3.ship_icon.model_normal_l, var_0_3.marry_two, var_0_3.marry_two)
		elseif (arg_6_1 == 10001413 or arg_6_1 == 11001413) and self._enter_type ~= var_0_3.enter_marry_ok_type.ship_map then
			var_6_0 = var_0_3:get_ship_icon(var_0_3.ship_icon.model_normal_l, var_0_3.marry_three, var_0_3.marry_three)
		elseif arg_6_2 ~= nil then
			local var_6_1 = var_0_7:find_character_by_id(arg_6_2).skin

			if var_6_1 == 0 then
				local var_6_2 = var_0_5.find_object_by_cid(arg_6_1).pic_id

				var_6_0 = var_0_3:get_ship_icon(var_0_3.ship_icon.model_normal_l, var_6_2, var_6_2)
			else
				var_6_0 = var_0_3:get_ship_icon(var_0_3.ship_icon.model_normal_l, var_0_6.find_object_by_cid(var_6_1).skin_id)
			end
		elseif self._now_index and self._now_index ~= 0 then
			var_6_0 = var_0_3:get_ship_icon(var_0_3.ship_icon.model_normal_l, self._now_index, self._now_index)
		else
			local var_6_3 = var_0_5.find_object_by_cid(arg_6_1).pic_id

			var_6_0 = var_0_3:get_ship_icon(var_0_3.ship_icon.model_normal_l, var_6_3, var_6_3)
		end

		self._control.ship_role.transform.localScale = Vector3.New(1, 1, 1)

		local var_6_4, var_6_5 = self:loadSprite(var_6_0)

		self._control.ship_role.image.sprite = var_6_4

		if var_6_5 then
			var_0_3:hd_sprite_half_scale(self._control.ship_role.transform)
		end

		if self._is_evo then
			self._control.content.type_txt.text.text = var_0_1:getNowLang(var_0_3:get_ship_type_language_key(var_0_5.find_object_by_cid(arg_6_1 + 1000000).type, 2))
			self._control.content.name_txt.text.text = var_0_5.find_object_by_cid(arg_6_1 + 1000000).title
			self._control.content.scrollview.content.info_txt.text.text = var_0_5.find_object_by_cid(arg_6_1 + 1000000).vow
		else
			self._control.content.type_txt.text.text = var_0_1:getNowLang(var_0_3:get_ship_type_language_key(var_0_5.find_object_by_cid(arg_6_1).type, 2))
			self._control.content.name_txt.text.text = var_0_5.find_object_by_cid(arg_6_1).title
			self._control.content.scrollview.content.info_txt.text.text = var_0_5.find_object_by_cid(arg_6_1).vow
		end
	end

	function arg_1_0:__init_animation()
		self._skeleton_animation = self._control.mask.marry_anim:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
	end

	function arg_1_0:__init_panel(arg_8_1, arg_8_2)
		local var_8_0 = var_0_2:getInstance("ship_detail")

		if var_8_0 then
			var_8_0:setVisible(false)
		end

		self:__init_animation()
		self:play_animation("Married", false, function()
			if self._is_evo then
				self:show_marry_anim(false, arg_8_1 + 1000000)
			else
				self:show_marry_anim(false, arg_8_1)
			end
		end)
		self:set_ship_info(arg_8_1, arg_8_2)
		self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, "weding"))
	end

	function arg_1_0:_play_bgm()
		local var_10_0 = var_0_2:getInstance("home")
		local var_10_1 = var_0_7:get_to_six_year()

		if var_0_7:get_goto_abyss() then
			self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.abyss_activity_bgm))
		elseif var_0_7:get_goto_fear_sea() then
			self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.sixth_activity_bgm))
		elseif var_0_7:get_to_normal_fight() and not var_10_1 then
			local var_10_2 = var_0_2:getInstance("gotofight")

			if var_10_2 then
				var_10_2:_play_fight_bgm(var_10_2._now_lock_id)
			elseif var_10_0 then
				var_10_0:into_home_bgm()
			else
				var_10_0 = var_0_2:createInstance("home")

				var_10_0:into_home_bgm()
			end
		elseif var_10_1 then
			if var_0_7:get_now_six_bgm() then
				self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_7:get_now_six_bgm()))
			else
				self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.sixth_activity_bgm))
			end
		elseif var_0_7:get_to_cap() then
			self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.living_bgm))
		elseif var_0_7:get_to_school() then
			self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.school))
		elseif var_0_7:get_to_cook() then
			self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.restaurant))
		elseif var_0_7:get_to_shower() then
			local var_10_3 = var_0_2:getInstance("bathroom")

			if var_10_3 then
				var_10_3:_play_now_bgm()
			else
				self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.living_bgm))
			end
		elseif var_0_7:get_to_living() then
			local var_10_4 = var_0_2:getInstance("dormitory")

			if var_10_4 then
				if var_10_4._get_furniture_data then
					if var_0_9(var_10_4._get_furniture_data) then
						for iter_10_0, iter_10_1 in pairs(var_10_4._get_furniture_data) do
							var_10_4:_now_living_bgm(iter_10_1.cid)
						end
					else
						self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.living_bgm))
					end
				else
					self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.living_bgm))
				end
			else
				self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.living_bgm))
			end
		elseif var_0_7:get_to_score() then
			local var_10_5 = var_0_2:getInstance("score_push_map")

			if var_10_5 then
				self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_10_5._active_config.bgm))
			else
				self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_2:createInstance("score_push_map")._active_config.bgm))
			end
		elseif var_0_7:get_to_strike() then
			local var_10_6 = var_0_2:getInstance("strike_main")

			if var_10_6 then
				self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_10_6._active_config.bgm))
			else
				self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_2:createInstance("score_push_map")._active_config.bgm))
			end
		elseif var_10_0 then
			var_10_0:into_home_bgm()
		else
			var_0_2:createInstance("home"):into_home_bgm()
		end
	end

	function arg_1_0:_play_audio(arg_11_1)
		self:playBackgroundMusic(arg_11_1, true)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_12_0)
	local var_12_0 = var_0_2:class("marry_ok")

	var_12_0._skeleton_animation = nil
	var_12_0._enter_type = nil
	var_12_0._now_index = nil

	gamecore.extend_obj(var_12_0)

	return var_12_0
end

return var_0_0
