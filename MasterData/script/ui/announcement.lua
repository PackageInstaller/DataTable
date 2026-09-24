local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = DG.Tweening.DOTween
local var_0_6 = gameenum.common_type
local var_0_7 = UnityEngine.Vector2
local var_0_8 = lx.UserData
local var_0_9 = gamecore.AuditServerManager

gamecore.UILoader:define("announcement", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		if arg_2_1 then
			self:setVisible(true)
		else
			self:setVisible(false)
		end

		self._panel.transform:GetComponent("Canvas").sortingOrder = 590

		self:__init_move()
		self:__init_panel()
		self._control.fragment.mainfragment.toggle.toggle.onValueChanged:AddListener(function(arg_3_0)
			if self._control.fragment.mainfragment.toggle:GetComponent("Toggle").isOn == true then
				var_0_3:req_announcement(true)
				var_0_8:setKeyData("announcement", (lx.Time:getDateString()))
				var_0_8:setKeyData("announcement_1", nil)

				return
			else
				var_0_3:req_announcement(false)
				var_0_8:setKeyData("announcement", nil)
				var_0_8:setKeyData("announcement_1", (lx.Time:getDateString()))

				return
			end
		end)

		arg_2_2 = arg_2_2 or false

		if arg_2_2 and var_0_8:getKeyData("announcement_1") == "" then
			self._control.fragment.mainfragment.toggle:GetComponent("Toggle").isOn = true
		end
	end

	function arg_1_0:play_in_out_animation(arg_4_1, arg_4_2)
		if arg_4_1 then
			self._control.mask.uITweenSequence:Play(function()
				if arg_4_2 then
					arg_4_2()
				end
			end)
		else
			self._control.mask.uITweenSequence:PlayReverse(function()
				if arg_4_2 then
					arg_4_2()
				end
			end)
		end
	end

	function arg_1_0:set_announcement_url()
		if var_0_9:isAuditVersion() then
			return
		end

		self.now_url = app:getNotice().notice_url

		if not self.now_url or self.now_url == "" or var_0_9:isAuditVersion() then
			return
		end

		if self._control.fragment.main.uni_web_view and not self._control.fragment.main.uni_web_view:Equals(nil) and not self._control.fragment.main.uni_web_view.rectTransform:Equals(nil) then
			self._control.fragment.main.uni_web_view.uniWebView.ReferenceRectTransform = self._control.fragment.main.uni_web_view.rectTransform

			self._control.fragment.main.uni_web_view:GetComponent("UniWebView"):Load(self.now_url)
		end
	end

	function arg_1_0:__init_panel()
		self:play_in_out_animation(true, function()
			if var_0_9:isAuditVersion() then
				self._control.fragment.main.gameObject:SetActive(false)
			else
				self._control.fragment.main.gameObject:SetActive(true)
			end

			self:set_announcement_url()
		end)

		self._control.fragment.mainfragment.title.text.text = var_0_1:getNowLang("ui_newstitle")
		self._control.fragment.mainfragment.tips.text.text = var_0_1:getNowLang("ui_newstip")

		var_0_3:set_close_announcement(false)
	end

	function arg_1_0:__init_move()
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.open))

		self._control.fragment.mainfragment.mask.glow.rectTransform.anchoredPosition = var_0_7(-1100, 0)
		self._announc_seq = self:autoKillDOTween(var_0_4.Sequence())

		self._announc_seq:Append(self._control.fragment.mainfragment.mask.glow.transform:DOBlendableLocalMoveBy(var_0_7.New(4000, 0), 4):SetEase(DG.Tweening.Ease.Linear))
		self._announc_seq:SetLoops(-1)
		self._announc_seq:Play()
	end

	function arg_1_0:_play_into_se(arg_11_1)
		self:playSE(arg_11_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_12_0)
	local var_12_0 = var_0_2:class("announcement")

	var_12_0._announc_seq = nil
	var_12_0.is_req_announcement = true

	return var_12_0
end

return var_0_0
