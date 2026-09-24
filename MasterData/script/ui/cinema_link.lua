local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.cinema_link_list_config
local var_0_6 = table.insert

gamecore.UILoader:define("cinema_link", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:__init_link_config(arg_3_1)
		local var_3_0, var_3_1 = var_0_5:get_sequence()
		local var_3_2 = var_0_1:get_player_story_unlock_data()
		local var_3_3 = {}

		for iter_3_0 = 1, #var_3_2 do
			if var_3_2[iter_3_0].type == 2 then
				var_0_6(var_3_3, var_3_2[iter_3_0].id)
			end
		end

		local var_3_4 = {
			self._control.link_1,
			self._control.link_2,
			self._control.link_3,
			self._control.link_4,
			self._control.link_5,
			self._control.link_6,
			self._control.link_7,
			self._control.link_8,
			self._control.link_9,
			self._control.link_10,
			self._control.link_11,
			self._control.link_12,
			self._control.link_13,
			self._control.link_14,
			self._control.link_15,
			self._control.link_16,
			self._control.link_17,
			self._control.link_18
		}

		for iter_3_1 = 1, #var_3_4 do
			if var_3_0[18 * arg_3_1 + iter_3_1] and var_3_0[18 * arg_3_1 + iter_3_1].release == 1 then
				var_3_4[iter_3_1].icon:SetActive(true)
				var_3_4[iter_3_1].txt:SetActive(true)
				var_3_4[iter_3_1].lock:SetActive(true)

				var_3_4[iter_3_1].txt.text.text = var_3_0[18 * arg_3_1 + iter_3_1].title
				var_3_4[iter_3_1].txt.text.color = Color.New(0.20392156862745098, 0.20392156862745098, 0.20392156862745098, 1)
				var_3_4[iter_3_1].image.sprite = self:loadSprite(var_0_4.cinema_link[2])
				var_3_4[iter_3_1].icon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.cinema_link_icon[1], var_3_0[18 * arg_3_1 + iter_3_1].id))

				local var_3_5 = var_0_1:get_character_list()
				local var_3_6 = var_0_1:get_skin_list()
				local var_3_7 = {}

				for iter_3_2 = 1, #var_3_0[18 * arg_3_1 + iter_3_1].condition do
					var_0_6(var_3_7, false)

					if var_3_0[18 * arg_3_1 + iter_3_1].condition[iter_3_2].type == 1 then
						for iter_3_3, iter_3_4 in ipairs(var_3_5) do
							if (iter_3_4.cid == var_3_0[18 * arg_3_1 + iter_3_1].condition[iter_3_2].cid or iter_3_4.cid == var_3_0[18 * arg_3_1 + iter_3_1].condition[iter_3_2].cid + 1000000) and iter_3_4.love >= var_3_0[18 * arg_3_1 + iter_3_1].condition[iter_3_2].num * 100 then
								var_3_7[iter_3_2] = true
							end
						end
					end

					if var_3_0[18 * arg_3_1 + iter_3_1].condition[iter_3_2].type == 2 and var_0_1:skin_have_exist(var_3_0[18 * arg_3_1 + iter_3_1].condition[iter_3_2].cid) then
						var_3_7[iter_3_2] = true
					end

					if var_3_0[18 * arg_3_1 + iter_3_1].condition[iter_3_2].type == 4 and var_0_1:is_map_pass(var_3_0[18 * arg_3_1 + iter_3_1].condition[iter_3_2].cid) == true then
						var_3_7[iter_3_2] = true
					end
				end

				for iter_3_5 = 1, #var_3_7 do
					if var_3_7[iter_3_5] == false then
						var_3_4[iter_3_1].lock:SetActive(true)

						var_3_4[iter_3_1].image.sprite = self:loadSprite(var_0_4.cinema_link[2])

						break
					end

					var_3_4[iter_3_1].lock:SetActive(false)

					var_3_4[iter_3_1].image.sprite = self:loadSprite(var_0_4.cinema_link[1])
				end

				for iter_3_6 = 1, #var_3_3 do
					if var_3_3[1] and var_3_3[iter_3_6] == var_3_0[18 * arg_3_1 + iter_3_1].id then
						var_3_4[iter_3_1].lock:SetActive(false)

						var_3_4[iter_3_1].image.sprite = self:loadSprite(var_0_4.cinema_link[1])
					end
				end

				var_3_4[iter_3_1].button.onClick:RemoveAllListeners()
				var_3_4[iter_3_1].button.onClick:AddListener(function()
					var_0_3:createInstance("cinema_link_info"):show(var_3_0[18 * arg_3_1 + iter_3_1])
				end)
			else
				var_3_4[iter_3_1].icon:SetActive(false)

				var_3_4[iter_3_1].txt.text.text = var_0_2:getNowLang("shipnotopen")
				var_3_4[iter_3_1].image.sprite = self:loadSprite(var_0_4.cinema_link[3])
			end
		end
	end

	function arg_1_0:__init_panel()
		self:__init_link_config(0)

		self._control.bg_book.image.sprite = self:loadSprite(var_0_4.cinema_link_bg)
		self._control.bg_book.previous.image.sprite = self:loadSprite(var_0_4.cinema_link_previous)
		self._control.bg_book.next.image.sprite = self:loadSprite(var_0_4.cinema_link_next)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_6_0)
	return (var_0_3:class("cinema_link"))
end

return var_0_0
