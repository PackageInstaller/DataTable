local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = lx.UserData
local var_0_3 = UnityEngine.Input
local var_0_5 = table.insert
local var_0_6 = table.remove
local var_0_7 = gamecore.Language
local var_0_8 = gamecore.UILoader
local var_0_9 = UnityEngine.Vector2
local var_0_10 = string.format
local var_0_11 = DG.Tweening.DOTween
local var_0_14 = lx.clone_table
local var_0_16 = gameenum.common_type
local var_0_19 = gamecore.AuditServerManager
local var_0_22 = {
	"single_announcement_one",
	"single_announcement_two",
	"single_announcement_three",
	"single_announcement_four",
	"single_announcement_five"
}

gamecore.UILoader:define("announcement_rework", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._allow_mouse_move and not var_0_19:isAuditVersion() then
			if var_0_3.GetMouseButtonDown(0) then
				self._start_pos = var_0_3.mousePosition
			end

			if var_0_3.GetMouseButtonUp(0) then
				self._end_pos = var_0_3.mousePosition

				if self._start_pos and self._end_pos then
					self:__set_mouse_move_event()
				end
			end
		end
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)
		self:__init_light_move()
		self:__init_panel(arg_3_1.info)
		self._control.main_info.toggle.toggle.onValueChanged:RemoveAllListeners()
		self._control.main_info.toggle.toggle.onValueChanged:AddListener(function(arg_4_0)
			if self._control.main_info.toggle:GetComponent("Toggle").isOn == true then
				var_0_1:req_announcement(true)
				var_0_2:setKeyData("announcement", (lx.Time:getDateString()))
				var_0_2:setKeyData("announcement_1", nil)

				return
			else
				var_0_1:req_announcement(false)
				var_0_2:setKeyData("announcement", nil)
				var_0_2:setKeyData("announcement_1", (lx.Time:getDateString()))

				return
			end
		end)

		if var_0_2:getKeyData("announcement_1") == "" then
			self._control.main_info.toggle:GetComponent("Toggle").isOn = true
		end

		self._control.main_info.toggle.tips.text.text = var_0_7:getNowLang("ui_newstip")
	end

	function arg_1_0:__start_activity_pic_fade_animation()
		if self._activity_pic_seq then
			for iter_5_0, iter_5_1 in pairs(self._activity_pic_seq) do
				if iter_5_1 then
					iter_5_1:Kill()
				end
			end
		end

		self._activity_pic_seq = {}
		self._now_pic_num = 1

		local var_5_0 = #self._announcememnt_pic_name

		if self._control.main_info.viewport.content.activity_pic and self._control.main_info.viewport.content.activity_pic.activeSelf then
			if self._control.main_info.viewport.content.activity_pic.image then
				self._control.main_info.viewport.content.activity_pic.image.color = UnityEngine.Color.New(self._control.main_info.viewport.content.activity_pic.image.color.r, self._control.main_info.viewport.content.activity_pic.image.color.g, self._control.main_info.viewport.content.activity_pic.image.color.b, 0)

				local var_5_1 = self:autoKillDOTween(var_0_11.Sequence())

				var_5_1:Append(self._control.main_info.viewport.content.activity_pic.image:DOFade(1, 0.5):SetEase(DG.Tweening.Ease.InQuad))
				var_5_1:AppendInterval(5)
				var_5_1:Append(self._control.main_info.viewport.content.activity_pic.image:DOFade(0, 0.5):SetEase(DG.Tweening.Ease.OutQuad))
				var_5_1:AppendCallback(function()
					self._now_pic_num = self._now_pic_num == var_5_0 and 1 or self._now_pic_num + 1
					self._control.main_info.viewport.content.activity_pic.image.sprite = self:loadSprite(var_0_10(var_0_16.announcement_pic, self._announcememnt_pic_name[self._now_pic_num]))
				end)
				var_5_1:SetLoops(-1)
				var_5_1:Play()
				var_0_5(self._activity_pic_seq, var_5_1)
			end
		end
	end

	function arg_1_0:__init_panel(arg_7_1)
		self._control.main_info:SetActive(true)
		self._control.main_info.viewport:SetActive(true)

		for iter_7_0, iter_7_1 in pairs(var_0_22) do
			self._control.main_info.viewport.content.single_announcement[iter_7_1]:SetActive(false)
		end

		self._control.main_info.viewport.content.activity_pic.active_text:SetActive(false)

		local var_7_0 = var_0_14(arg_7_1)

		if var_7_0[1].id == 0 then
			if var_7_0[1].text_pic_id ~= "0" then
				self._control.main_info.viewport.content.activity_pic.image.sprite = self:loadSprite(var_0_10(var_0_16.announcement_pic, var_7_0[1].text_pic_id))

				self._control.main_info.viewport.content.activity_pic:SetActive(true)
			end

			var_0_6(var_7_0, 1)
		end

		self._announcememnt_pic_name = {}
		self._announcememnt_info = var_0_14(var_7_0)

		for iter_7_2, iter_7_3 in pairs(var_7_0) do
			if iter_7_2 <= #var_7_0 then
				self._control.main_info.viewport.content.single_announcement[var_0_22[iter_7_2]]:SetActive(true)

				self._control.main_info.viewport.content.single_announcement[var_0_22[iter_7_2]].type_text.text.text = "【" .. iter_7_3.type .. "】"

				self._control.main_info.viewport.content.single_announcement[var_0_22[iter_7_2]].title:GetComponent("TextHorizonScroller"):SetText(iter_7_3.title)

				if iter_7_3.is_new == "1" then
					self._control.main_info.viewport.content.single_announcement[var_0_22[iter_7_2]].is_new:SetActive(true)
				else
					self._control.main_info.viewport.content.single_announcement[var_0_22[iter_7_2]].is_new:SetActive(false)
				end

				if iter_7_3.text_pic_id ~= "0" then
					var_0_5(self._announcememnt_pic_name, iter_7_3.text_pic_id)
				end
			end
		end

		if self._announcememnt_pic_name and next(self._announcememnt_pic_name) then
			self._control.main_info.viewport.content.activity_pic.image.sprite = self:loadSprite(var_0_10(var_0_16.announcement_pic, self._announcememnt_pic_name[1]))

			if #self._announcememnt_pic_name > 1 then
				self:__start_activity_pic_fade_animation()
			end
		end
	end

	function arg_1_0:set_detail_info(arg_8_1)
		self._single_announcement_show = true

		local var_8_0 = var_0_14(self._announcememnt_info[arg_8_1])

		self._control.detail_info.detail_announcement.type_text.text.text = "【" .. var_8_0.type .. "】"

		self._control.detail_info.detail_announcement.title:GetComponent("TextHorizonScroller"):SetText(var_8_0.title)

		self._control.detail_info.announcement_text.viewport.content.Text.text.text = var_0_7:convert_rich_text(var_8_0.text)

		if var_8_0.link ~= "0" then
			UnityEngine.Application.OpenURL(var_8_0.link)
		end

		if var_8_0.active_text ~= "0" then
			self._control.main_info.viewport.content.activity_pic.active_text:SetActive(true)

			self._control.main_info.viewport.content.activity_pic.active_text.text.text = var_0_7:convert_rich_text(var_8_0.active_text)
		end
	end

	function arg_1_0:__set_scroll_to_top()
		self._scroll_bar = self._scroll_bar or self._control.detail_info.announcement_text.scrollbarvertical:GetComponent("Scrollbar")
		self._scroll_bar.value = 1
	end

	function arg_1_0:_play_into_se(arg_10_1)
		self:playSE(arg_10_1, false)
	end

	function arg_1_0:__init_light_move()
		self:_play_into_se(var_0_16:get_audio_url(var_0_16.common_icon.music_path, var_0_16.open))

		self._control.mask_light.glow.rectTransform.anchoredPosition = var_0_9(-1100, 0)
		self._announc_seq = self:autoKillDOTween(var_0_11.Sequence())

		self._announc_seq:Append(self._control.mask_light.glow.transform:DOBlendableLocalMoveBy(var_0_9.New(4000, 0), 4):SetEase(DG.Tweening.Ease.Linear))
		self._announc_seq:SetLoops(-1)
		self._announc_seq:Play()
	end

	function arg_1_0:__set_mouse_move_event()
		if not self._announcememnt_pic_name or #self._announcememnt_pic_name == 0 then
			return
		end

		if self._control.main_info.scrollbarvertical:GetComponent("Scrollbar").value < 0.51 then
			return
		end

		local var_12_0 = self._end_pos.x - self._start_pos.x

		if 160 >= math.abs(self._end_pos.x - self._start_pos.x) then
			return
		elseif var_12_0 < -300 or 160 < self._end_pos.y - self._start_pos.y then
			self._now_pic_num = self._now_pic_num == #self._announcememnt_pic_name and 1 or self._now_pic_num + 1
			self._control.main_info.viewport.content.activity_pic.image.sprite = self:loadSprite(var_0_10(var_0_16.announcement_pic, self._announcememnt_pic_name[self._now_pic_num]))
		elseif 160 < var_12_0 or self._end_pos.y - self._start_pos.y < -300 then
			self._now_pic_num = self._now_pic_num == 1 and #self._announcememnt_pic_name or self._now_pic_num - 1
			self._control.main_info.viewport.content.activity_pic.image.sprite = self:loadSprite(var_0_10(var_0_16.announcement_pic, self._announcememnt_pic_name[self._now_pic_num]))
		end
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0:__initia_lize()
		if self._activity_pic_seq then
			for iter_14_0, iter_14_1 in pairs(self._activity_pic_seq) do
				if iter_14_1 then
					iter_14_1:Kill()
				end
			end

			self._activity_pic_seq = {}
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_15_0)
	local var_15_0 = var_0_8:class("announcement_rework")

	var_15_0:__initia_lize()

	var_15_0._announcememnt_info = {}
	var_15_0._activity_pic_seq = {}
	var_15_0._announcememnt_pic_name = {}
	var_15_0._now_pic_num = 1
	var_15_0._allow_mouse_move = true
	var_15_0._single_announcement_show = false

	return var_15_0
end

return var_0_0
