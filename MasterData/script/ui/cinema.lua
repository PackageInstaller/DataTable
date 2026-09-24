local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type

gamecore.UILoader:define("cinema", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		self:_play_audio(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.living_bgm))
		self:_init_language()
	end

	function arg_1_0:_init_language()
		self._control.picture_book_btn.image.sprite = self:loadSprite(var_0_3.cinema_btn_url.picture_book_btn)
		self._control.review_btn.image.sprite = self:loadSprite(var_0_3.cinema_btn_url.review_btn)
		self._control.link_btn.image.sprite = self:loadSprite(var_0_3.cinema_btn_url.link_btn)
		self._control.tactics_collection_btn.image.sprite = self:loadSprite(var_0_3.cinema_btn_url.tactics_collection_btn)
	end

	function arg_1_0:_play_audio(arg_5_1)
		self:playBackgroundMusic(arg_5_1)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_6_0)
	return (var_0_2:class("cinema"))
end

return var_0_0
