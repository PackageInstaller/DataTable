local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_return_btn()
		self:setVisible(false)

		local var_2_0 = var_0_1:createInstance("living_areas")

		var_2_0:show()
		var_2_0:_play_audio(var_0_2:get_audio_url(var_0_2.common_icon.music_path, "dormitory"))
	end

	function arg_1_0:__onClick_home_btn()
		self:setVisible(false)

		local var_3_0 = var_0_1:createInstance("home")

		var_3_0:show()
		var_3_0:into_home_bgm()
	end

	function arg_1_0:__onClick_picture_book_btn()
		self:setVisible(false)
		var_0_1:createInstance("cinema_picture_book"):show(1)
	end

	function arg_1_0:__onClick_review_btn()
		self:setVisible(false)
		var_0_1:createInstance("cinema_review"):show(1)
	end

	function arg_1_0:__onClick_link_btn()
		self:setVisible(false)
		var_0_1:createInstance("cinema_link"):show()
	end

	function arg_1_0.__onClick_tactics_collection_btn(arg_7_0)
		local var_7_0 = var_0_1:createInstance("tactics_collection")

		if var_7_0 then
			var_7_0:show()
		end
	end
end

function var_0_0.extend_obj(arg_8_0)
	return
end

return var_0_0
