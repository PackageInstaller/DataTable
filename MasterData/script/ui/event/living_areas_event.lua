local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.PreloadManager
local var_0_4 = gameenum.common_type
local var_0_5 = DG.Tweening.DOTween

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_background_captainroom_btn()
		self:setVisible(false)
		var_0_2:createInstance("captainroom"):show()
	end

	function arg_1_0:__onClick_background_captainroom_title_btn()
		self:setVisible(false)
		var_0_2:createInstance("captainroom"):show()
	end

	function arg_1_0:__onClick_background_collection_btn()
		self:setVisible(false)
		var_0_2:createInstance("show_room"):show(nil, var_0_4.show_room_enter_type.living_areas, true)
	end

	function arg_1_0:__onClick_background_bathroom_title_btn()
		self:setVisible(false)
		var_0_2:createInstance("bathroom"):show()
	end

	function arg_1_0:__onClick_background_bathroom_btn()
		self:setVisible(false)
		var_0_2:createInstance("bathroom"):show()
	end

	function arg_1_0:__onClick_background_room_btn()
		self:__show_dormitory_view()
	end

	function arg_1_0:__onClick_background_room_title_btn()
		self:__show_dormitory_view()
	end

	function arg_1_0:__show_dormitory_view()
		local var_9_0 = var_0_2:createInstance("dormitory")

		local function var_9_1()
			local var_10_0 = var_0_2:createInstance("dorm_warehouse")

			var_10_0:set_sort_data()
			var_10_0:show()
			var_10_0:setVisible(false)
		end

		local var_9_2 = 0

		for iter_9_0, iter_9_1 in pairs((var_0_1:get_dormitory_furniture())) do
			if iter_9_1.room == 0 then
				var_9_2 = var_9_2 + 1
			end
		end

		if var_9_2 == 0 then
			self:setVisible(false)
			var_9_0:show(var_9_1)

			return
		end

		local var_9_3 = 0

		local function var_9_4()
			var_9_3 = var_9_3 + 1

			if var_9_3 == var_9_2 then
				self:setVisible(false)
				var_9_0:show(var_9_1)
			end
		end

		for iter_9_2, iter_9_3 in pairs(var_0_1:get_dormitory_furniture()) do
			if iter_9_3.room == 0 then
				var_9_4()
			end
		end

		self.seq = self:autoKillDOTween(var_0_5.Sequence())

		for iter_9_4, iter_9_5 in pairs(var_0_1:get_dormitory_furniture()) do
			if iter_9_5.room == 0 then
				self.seq:AppendInterval(0.01)
				self.seq:AppendCallback(function()
					var_0_3:preload_dormitory_asset(iter_9_5)

					if iter_9_4 == var_9_2 and self.seq then
						self.seq:Kill()

						self.seq = nil
					end
				end)
			end
		end
	end

	function arg_1_0:__onClick_background_school_btn()
		self:setVisible(false)
		var_0_2:createInstance("school"):show()
	end

	function arg_1_0:__onClick_background_school_title_btn()
		self:setVisible(false)
		var_0_2:createInstance("school"):show()
	end

	function arg_1_0:__onClick_background_restaurant_btn()
		self:setVisible(false)
		var_0_2:createInstance("restaurant"):show()
	end

	function arg_1_0:__onClick_background_restaurant_title_btn()
		self:setVisible(false)
		var_0_2:createInstance("restaurant"):show()
	end

	function arg_1_0:__onClick_background_cinema_btn()
		self:setVisible(false)
		var_0_2:createInstance("cinema"):show()
	end

	function arg_1_0:__onClick_background_cinema_title_btn()
		self:setVisible(false)
		var_0_2:createInstance("cinema"):show()
	end

	function arg_1_0:__onClick_close_btn()
		local var_19_0 = var_0_2:createInstance("home")

		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back))

		self._already_init = false

		var_0_2:destroyInstance("living_areas")
		var_19_0:show()
		var_19_0:into_home_bgm()
	end

	function arg_1_0:__onClick_background_living_support_btn()
		self:setVisible(false)
		var_0_2:createInstance("supportroom"):show()
	end
end

function var_0_0.extend_obj(arg_21_0)
	return
end

return var_0_0
