local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_6 = table.insert
local var_0_7 = {
	[2001] = gameconfig.character_story_1_config,
	[2002] = gameconfig.character_story_2_config,
	[2003] = gameconfig.character_story_3_config,
	[2004] = gameconfig.character_story_4_config,
	[2005] = gameconfig.character_story_5_config,
	[2006] = gameconfig.character_story_6_config,
	[2007] = gameconfig.character_story_7_config,
	[2008] = gameconfig.character_story_8_config,
	[2009] = gameconfig.character_story_9_config,
	[2010] = gameconfig.character_story_10_config
}

gamecore.UILoader:define("cinema_link_info", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:set_link_info_data(arg_3_1)
		local var_3_0 = {
			self._control.lock.txt_1,
			self._control.lock.txt_2,
			self._control.lock.txt_3,
			self._control.lock.txt_4
		}

		self._control.lock.txt_1:SetActive(false)
		self._control.lock.txt_2:SetActive(false)
		self._control.lock.txt_3:SetActive(false)
		self._control.lock.txt_4:SetActive(false)

		local var_3_1 = var_0_1:get_player_story_unlock_data()
		local var_3_2 = var_0_1:get_character_list()
		local var_3_3 = var_0_1:get_skin_list()
		local var_3_4 = {}
		local var_3_5 = {}

		self._control.unlock:SetActive(false)
		self._control.lock:SetActive(true)
		self._control.bg_container:SetActive(true)
		self._control.tps:SetActive(false)

		for iter_3_0 = 1, #var_3_1 do
			if var_3_1[iter_3_0].type == 2 then
				var_0_6(var_3_4, var_3_1[iter_3_0].id)
			end
		end

		if var_3_4[1] then
			for iter_3_1 = 1, #var_3_4 do
				if arg_3_1.id == var_3_4[iter_3_1] then
					self._control.unlock:SetActive(true)
					self._control.lock:SetActive(false)
				end
			end
		end

		self._control.lock.btn:GetComponent("Button").interactable = false
		self._control.bg_container.chara_icon.mask.drawing.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.story_icon[2], arg_3_1.pic))
		self._control.bg_container.medal_icon_bg.medal_icon.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_4.cinema_link_icon[1], arg_3_1.id))
		self._control.bg_container.grey.image.sprite = self:loadSprite(var_0_4.cinema_link_info_grey)
		self._control.bg_container.medal_name_text.text.text = arg_3_1.title
		self._control.unlock.describe.text.text = arg_3_1.desc

		for iter_3_2 = 1, #arg_3_1.condition do
			var_3_0[iter_3_2]:SetActive(true)

			var_3_0[iter_3_2].text.text = string.format("<color=#%s>%s</color>", "656565", arg_3_1.condition_desc[iter_3_2])
			var_3_0[iter_3_2].determine.image.sprite = self:loadSprite(var_0_4.cinema_determine[1])
		end

		for iter_3_3 = 1, #arg_3_1.condition do
			var_0_6(var_3_5, false)

			if arg_3_1.condition[iter_3_3].type == 1 then
				for iter_3_4, iter_3_5 in pairs(var_3_2) do
					if (iter_3_5.cid == arg_3_1.condition[iter_3_3].cid or iter_3_5.cid == arg_3_1.condition[iter_3_3].cid + 1000000) and iter_3_5.love >= arg_3_1.condition[iter_3_3].num * 100 then
						var_3_0[iter_3_3].text.text = string.format("<color=#%s>%s</color>", "2791F6", arg_3_1.condition_desc[iter_3_3])
						var_3_0[iter_3_3].determine.image.sprite = self:loadSprite(var_0_4.cinema_determine[2])
						var_3_5[iter_3_3] = true
					end
				end
			end

			if arg_3_1.condition[iter_3_3].type == 2 and var_0_1:skin_have_exist(arg_3_1.condition[iter_3_3].cid) then
				var_3_0[iter_3_3].text.text = string.format("<color=#%s>%s</color>", "2791F6", arg_3_1.condition_desc[iter_3_3])
				var_3_0[iter_3_3].determine.image.sprite = self:loadSprite(var_0_4.cinema_determine[2])
				var_3_5[iter_3_3] = true
			end

			if arg_3_1.condition[iter_3_3].type == 4 and var_0_1:find_task_state(arg_3_1.condition[iter_3_3].cid) == 2 then
				var_3_0[iter_3_3].text.text = string.format("<color=#%s>%s</color>", "2791F6", arg_3_1.condition_desc[iter_3_3])
				var_3_0[iter_3_3].determine.image.sprite = self:loadSprite(var_0_4.cinema_determine[2])
				var_3_5[iter_3_3] = true
			end
		end

		for iter_3_6 = 1, #var_3_5 do
			if var_3_5[iter_3_6] == false then
				self._control.lock.btn:GetComponent("Button").interactable = false

				return
			end

			self._control.lock.btn:GetComponent("Button").interactable = true
		end
	end

	function arg_1_0:go_story_event(arg_4_1)
		self._control.tps.main.title.text.text = arg_4_1.title

		self._control.tps.transform:DOScale(1, 0.3)
		self._control.lock:SetActive(false)
		self._control.unlock:SetActive(false)
		self._control.bg_container:SetActive(false)
		self._control.tps:SetActive(true)
		var_0_1:req_UnlockShipStoryReq({
			id = arg_4_1.id
		})
	end

	function arg_1_0:go_dialog_event(arg_5_1)
		if arg_5_1 then
			local var_5_0, var_5_1 = var_0_7[arg_5_1.id]:get_sequence()

			var_0_3:createInstance("cinema_dialog"):show(arg_5_1.id, var_5_0[1].step, var_5_0[1].step + #var_5_0 - 1)
			var_0_3:destroyInstance("cinema_link_info")
			var_0_3:getInstance("cinema_link"):show()
		else
			local var_5_2 = var_0_3:createInstance("cinema_review")

			var_5_2:show(2)

			var_5_2._control.btn_group.chara_story_btn:GetComponent("Toggle").isOn = true

			self:setVisible(false)
			var_0_3:destroyInstance("cinema_link_info")
			var_0_3:destroyInstance("cinema_link")
		end
	end

	function arg_1_0:__init_panel(arg_6_1)
		self:set_link_info_data(arg_6_1)

		self.now_link_info = arg_6_1
		self._control.bg_container.medal_info_text.text.text = var_0_2:getNowLang("cinema_writer_info_title")
		self._control.lock.btn.txt.text.text = var_0_2:getNowLang("cinema_guankanjuqing")
		self._control.unlock.btn.unlock_txt.text.text = var_0_2:getNowLang("cinema_qianwanghuigu")
		self._control.tps.main.txt.text.text = var_0_2:getNowLang("ui_cinema_first_play_content")
		self._control.tps.main.confirm.text.text.text = var_0_2:getNowLang("space_confirm")
		self._control.tps.main.back.text.text.text = var_0_2:getNowLang("space_cancel")
		self._control.lock.condition_txt.text.text = var_0_2:getNowLang("cinema_jiesuotiaojian")
	end

	function arg_1_0.__onReset(arg_7_0)
		arg_7_0.now_link_info = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_8_0)
	local var_8_0 = var_0_3:class("cinema_link_info")

	var_8_0.now_link_info = {}

	return var_8_0
end

return var_0_0
