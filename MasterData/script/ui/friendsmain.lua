local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = string.format
local var_0_5 = gameenum.common_type
local var_0_6 = table.insert
local var_0_7 = table.remove
local var_0_8 = gamecore.prompt
local var_0_9 = DG.Tweening.DOTween
local var_0_10 = gameconfig.chat_head_config
local var_0_12 = UnityEngine.Vector2
local var_0_13 = next
local var_0_14 = gameconfig.config_config
local var_0_15 = table.sort
local var_0_16 = {
	btnthree = "btnthree",
	btnfour = "btnfour",
	btnone = "btnone",
	btntwo = "btntwo"
}

gamecore.UILoader:define("friendsmain", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell_have then
			self._reusable_cell_have:update()
		end

		if self._reusable_cell_add then
			self._reusable_cell_add:update()
		end

		if self._reusable_cell_recommend then
			self._reusable_cell_recommend:update()
		end
	end

	function arg_1_0:updata_data()
		self._have_data = var_0_3:get_friend_list()
		self._applyfor_data = var_0_3:recommend_friend_list()

		self:__set_addfriends_data()
		self:__set__now_data(self._now_label)
		self:set_scroll_position()
	end

	function arg_1_0:show(arg_4_1)
		self._enter_type = arg_4_1

		self:set_friends_max()
		self:setVisible(true)
		self:updata_data()
		self:__init_panel()

		self._already_init = true
	end

	function arg_1_0.set_friends_max(arg_5_0)
		arg_5_0._friends_max = tonumber(var_0_14.find_object_by_type("friends_limit").value)
		arg_5_0.friend_request_limit = tonumber(var_0_14.find_object_by_type("friend_request_limit").value)
	end

	function arg_1_0.button_flag(arg_6_0, arg_6_1)
		arg_6_0._button_isuse = arg_6_1
	end

	function arg_1_0.button_four(arg_7_0, arg_7_1)
		arg_7_0._button_four = arg_7_1
	end

	function arg_1_0.__onVisible(arg_8_0, arg_8_1)
		if not arg_8_1 then
			return
		end
	end

	function arg_1_0:__init_panel()
		self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.open))
		self:__init_addfriends_list()
		self:__init_havefriends_list()
		self:__init_recommendfriends_list()
		self:__init_select()

		self._control.maintop.topmenu.topbtn.btnone.text.text.text = var_0_1:getNowLang("fbt1")
		self._control.maintop.topmenu.topbtn.btntwo.text.text.text = var_0_1:getNowLang("fbt2")
		self._control.maintop.topmenu.topbtn.btnthree.text.text.text = var_0_1:getNowLang("fbt3")
		self._control.maintop.topmenu.topbtn.btnfour.text.text.text = var_0_1:getNowLang("fbt6")
		self._control.maintop.friendsinfo.friednsnum.ftext.text.text = var_0_1:getNowLang("friendnumlabel")
		self._control.maintop.friendsinfo.friednsnum.maxnum.text.text = self._friends_max
		self._control.infoline.tip.text.text = var_0_1:getNowLang("friendtiplabel2")
		self._control.mainapplyfor.undealwith.undealtext.text.text = var_0_1:getNowLang("friendnntreatedlabel")
		self._control.mainapplyfor.undealwith.allrefuse.text.text.text = var_0_1:getNowLang("refuseall")
		self._control.makefriends.addfriends.main.myuid.text.text = var_0_1:getNowLang("ui_addfriendtip2")
		self._control.makefriends.addfriends.main.applyfor.text.text = var_0_1:getNowLang("ui_addfriendtip1")
		self._control.makefriends.addfriends.main.send.text.text.text = var_0_1:getNowLang("ad_tip1")
		self._control.makefriends.addfriends.main.inputfieldmaybe.placeholder.text.text = var_0_1:getNowLang("addfriendinfo")
		self._control.makefriends.addfriends.main.inputfieldmaybe.inputField.text = nil
		self._control.makefriends.addfriends.main.rejectoption.text.text = var_0_1:getNowLang("ui_addfriendtip3")
		self._control.maintop.refresh.refreshbtn.text.text.text = var_0_1:getNowLang("ui_refresh")
		self._control.makefriends.addfriends.main.uidnumb.text.text = var_0_3:get_account_id()

		local var_9_0 = var_0_3:get_use_recommend_off()

		if var_9_0 == nil then
			var_9_0 = true
		end

		self._control.makefriends.addfriends.main.toggle:GetComponent("Toggle").isOn = not var_9_0

		self:_tip_have()
		self._control.maintop.refresh:SetActive(false)

		if self._is_play_bg then
			var_0_5:play_in_out_animation(self._control.bg.uITweenSequence, true)
		end
	end

	function arg_1_0:__apply_array()
		self._havefriend_array = {}

		for iter_10_0, iter_10_1 in pairs(self._have_data) do
			var_0_6(self._havefriend_array, iter_10_1)
		end

		self._addfriend_array = {}

		for iter_10_2, iter_10_3 in pairs(self._applyfor_data) do
			var_0_6(self._addfriend_array, iter_10_3)
		end
	end

	function arg_1_0:_tip_have()
		self:__apply_array()

		local var_11_0 = var_0_2:getInstance("home")

		if var_11_0 then
			var_11_0:update_friend_float()
		end

		var_0_3:set_new_friend_req_flag(false)

		if #self._addfriend_array == 0 or self._addfriend_array == nil then
			self._control.maintop.topmenu.topbtn.tip.gameObject:SetActive(false)
		else
			self._control.maintop.topmenu.topbtn.tip.gameObject:SetActive(true)
		end
	end

	function arg_1_0:__init_select()
		self:__apply_array()

		if self._now_content then
			self._now_content.toggle.isOn = false
		end

		if #self._havefriend_array == 0 or self._havefriend_array == nil then
			self:__select_one("btnthree", true)
			self._control.mainrecfriend:SetActive(false)
		else
			self:__select_one("btnone", true)
			self._control.mainrecfriend:SetActive(false)
		end

		self._now_content.toggle.isOn = true
	end

	function arg_1_0:__select_one(arg_13_1, arg_13_2)
		if self._now_label == arg_13_1 and not arg_13_2 then
			return
		end

		self._now_label = arg_13_1

		if self._now_content then
			self._last_content = self._now_content

			self:__set_title_style(self._now_content, false)
		end

		self:__set_current_content(arg_13_1)
		self:__set_title_style(self._now_content, true)
		self._control.maintop.refresh:SetActive(false)

		if self._is_play then
			if self._last_content then
				var_0_5:play_in_out_animation(self._last_content.uITweenSequence, false, function()
					var_0_5:play_in_out_animation(self._now_content.uITweenSequence, true, function()
						if self._now_label == "btnfour" then
							self._control.maintop.refresh:SetActive(true)
						end
					end)
				end)
			else
				var_0_5:play_in_out_animation(self._now_content.uITweenSequence, true)
			end
		end

		self:__set__now_data(self._now_label)
	end

	function arg_1_0:__set_current_content(arg_16_1)
		if arg_16_1 == var_0_16.btnone then
			self._now_content = self._control.maintop.topmenu.topbtn.btnone
			self._control.infoline.tip.text.text = var_0_1:getNowLang("friendtiplabel2")
		elseif arg_16_1 == var_0_16.btntwo then
			self._now_content = self._control.maintop.topmenu.topbtn.btntwo
			self._control.infoline.tip.text.text = var_0_1:getNowLang("friendtiplabel1")
		elseif arg_16_1 == var_0_16.btnthree then
			self._now_content = self._control.maintop.topmenu.topbtn.btnthree
			self._control.infoline.tip.text.text = var_0_1:getNowLang("friendtiplabel1")
		elseif arg_16_1 == var_0_16.btnfour then
			self._now_content = self._control.maintop.topmenu.topbtn.btnfour
			self._control.infoline.tip.text.text = var_0_1:getNowLang("friendtiplabel3")
		end
	end

	function arg_1_0.__set_title_style(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_2 then
			arg_17_1.text.text.fontSize = 30
			arg_17_1.text.text.color = Color.New(1, 1, 1)
		else
			arg_17_1.text.text.fontSize = 26
			arg_17_1.text.text.color = Color.New(0.5490196078431373, 0.5490196078431373, 0.5490196078431373)
		end
	end

	function arg_1_0:__set__now_data(arg_18_1)
		if arg_18_1 == var_0_16.btnone then
			self:__get_data_by_index(1)
			self:__update_cell_have()

			self._control.mainmid.mid.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_12(1.3, 0)
			self._current_panel_index = 1
		elseif arg_18_1 == var_0_16.btntwo then
			self:__get_data_by_index(2)
			self:__update_cell_add()

			self._current_panel_index = 2
		elseif arg_18_1 == var_0_16.btnfour then
			self:__get_data_by_index(3)
			self:__update_cell_recommend()

			self._control.mainrecfriend.mian.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_12(1.3, 0)
			self._current_panel_index = 4
		end
	end

	function arg_1_0:__init_addfriends_list()
		if self._already_init then
			return
		end

		self._reusable_cell_add = gamecore.reusable_cell:create(self, self._control.mainapplyfor.applyfor.scrollview.viewport.content.endlessScrollView, self._control.mainapplyfor.applyfor.scrollview.viewport.content, "friendcell", "friendsmain")

		self._reusable_cell_add:init()
	end

	function arg_1_0:__init_havefriends_list()
		if self._already_init then
			return
		end

		self._reusable_cell_have = gamecore.reusable_cell:create(self, self._control.mainmid.mid.scrollview.viewport.content.endlessScrollView, self._control.mainmid.mid.scrollview.viewport.content, "friendcell", "friendsmain")

		self._reusable_cell_have:init()
	end

	function arg_1_0:__init_recommendfriends_list()
		if self._already_init then
			return
		end

		self._reusable_cell_recommend = gamecore.reusable_cell:create(self, self._control.mainrecfriend.mian.scrollview.viewport.content.endlessScrollView, self._control.mainrecfriend.mian.scrollview.viewport.content, "friendcell", "friendsmain")

		self._reusable_cell_recommend:init()
	end

	function arg_1_0:__update_cell_have()
		local var_22_0 = self._now_data

		self._user_have_friends = self._now_data
		self._control.maintop.friendsinfo.friednsnum.nownum.text.text = #self._now_data

		if #self._now_data < self._friends_max then
			self._control.maintop.friendsinfo.friednsnum.nownum.text.color = Color.New(255, 255, 255)
			self._control.maintop.friendsinfo.friednsnum.xiegang.text.color = Color.New(255, 255, 255)
			self._control.maintop.friendsinfo.friednsnum.maxnum.text.color = Color.New(255, 255, 255)
		elseif #self._now_data == self._friends_max then
			self._control.maintop.friendsinfo.friednsnum.nownum.text.color = Color.New(255, 0, 0)
			self._control.maintop.friendsinfo.friednsnum.xiegang.text.color = Color.New(255, 0, 0)
			self._control.maintop.friendsinfo.friednsnum.maxnum.text.color = Color.New(255, 0, 0)
		end

		var_0_15(self._now_data, function(arg_23_0, arg_23_1)
			if arg_23_0.new_state ~= arg_23_1.new_state then
				return arg_23_0.new_state > arg_23_1.new_state
			elseif arg_23_0.top_time ~= arg_23_1.top_time then
				return arg_23_0.top_time > arg_23_1.top_time
			else
				return arg_23_0.time < arg_23_1.time
			end
		end)
		self._reusable_cell_have:set_data(self._now_data)

		function self._reusable_cell_have:_set_func(arg_24_1)
			local var_24_0 = var_0_10.find_object_by_cid(var_22_0[arg_24_1 + 1].head).icon

			self.main.head.newimg.gameObject:SetActive(false)
			self.main.logintime.btn.gameObject:SetActive(false)
			self.main.unknow.gameObject:SetActive(false)
			self.main.unknowtwo.gameObject:SetActive(false)
			self.main.acceptorrefuse.gameObject:SetActive(false)
			self.main.acceptorrefuse.gameObject:SetActive(false)
			self.main.top_img.gameObject:SetActive(var_22_0[arg_24_1 + 1].top_time ~= 0)

			self.main.playername.playername_1.text.text = var_22_0[arg_24_1 + 1].name

			self.main.playername:GetComponent("TextHorizonScroller"):SetText(var_22_0[arg_24_1 + 1].name)

			self.main.lv.text.text = "(LV." .. var_22_0[arg_24_1 + 1].level .. ")"
			self.main.introduction.text.text.text = var_22_0[arg_24_1 + 1].signature
			self.main.logintime.recently.text.text = var_0_1:getNowLang("friendlogintimetip")

			if var_22_0[arg_24_1 + 1].new_state then
				if var_22_0[arg_24_1 + 1].new_state == 1 then
					self.main.head.newimg.gameObject:SetActive(true)

					if self._newfrind == true then
						var_0_3:req_getneworoldfriendreq()

						self._newfrind = false
					end
				else
					self.main.head.newimg.gameObject:SetActive(false)
				end
			end

			self.main.rankimg.image.sprite = self:loadSprite(var_0_5:get_format_url(var_0_5.common_icon.friend_badge_path, var_22_0[arg_24_1 + 1].exploit))

			local var_24_1 = lx.ServerTime:getUtcTime() - var_22_0[arg_24_1 + 1].last_login_time

			if var_24_1 < 60 then
				self.main.logintime.time.text.text = var_0_1:getNowLang("recently")
			elseif var_24_1 >= 60 and var_24_1 < 3600 then
				self.main.logintime.time.text.text = math.floor(var_24_1 / 60) .. var_0_1:getNowLang("timeminutesago")
			elseif var_24_1 >= 3600 and var_24_1 < 86400 then
				self.main.logintime.time.text.text = math.floor(var_24_1 / 3600) .. var_0_1:getNowLang("timehoursago")
			elseif var_24_1 >= 86400 and var_24_1 < 2592000 then
				self.main.logintime.time.text.text = math.floor(var_24_1 / 86400) .. var_0_1:getNowLang("daysago")
			elseif var_24_1 >= 2592000 and var_24_1 < 31104000 then
				self.main.logintime.time.text.text = math.floor(var_24_1 / 2592000) .. var_0_1:getNowLang("monthago")
			elseif var_24_1 >= 31104000 then
				self.main.logintime.time.text.text = math.floor(var_24_1 / 31104000) .. var_0_1:getNowLang("yearsago")
			end

			self.main.head.img.image.sprite = self:loadSprite(var_0_4(var_0_5.friends_head, var_24_0))

			self.main.acceptorrefuse.refuse.button.onClick:RemoveAllListeners()
			self.main.info.button.onClick:AddListener(function()
				self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.open))

				self.scrollbar_value_f = self._control.mainmid.mid.scrollview.scrollbarvertical:GetComponent("Scrollbar").value

				var_0_2:createInstance("friendinfo"):show(var_22_0, arg_24_1, var_0_5.can_into)
			end)
		end
	end

	function arg_1_0:__update_cell_add()
		local var_26_0 = self._now_data

		self._user_add_friends = self._now_data
		self._control.mainapplyfor.undealwith.undealnum.text.text = #self._now_data

		if #self._now_data < self._apply_friends_max then
			self._control.mainapplyfor.undealwith.undealnum.text.color = Color.New(255, 255, 255)
			self._control.mainapplyfor.undealwith.xiegang.text.color = Color.New(255, 255, 255)
			self._control.mainapplyfor.undealwith.undealallnum.text.color = Color.New(255, 255, 255)
		elseif #self._now_data == self._apply_friends_max then
			self._control.mainapplyfor.undealwith.undealnum.text.color = Color.New(255, 0, 0)
			self._control.mainapplyfor.undealwith.xiegang.text.color = Color.New(255, 0, 0)
			self._control.mainapplyfor.undealwith.undealallnum.text.color = Color.New(255, 0, 0)
		end

		self._reusable_cell_add:set_data(self._now_data)

		function self._reusable_cell_add:_set_func(arg_27_1)
			self.main.head.newimg.gameObject:SetActive(false)
			self.main.info.gameObject:SetActive(false)
			self.main.logintime.gameObject:SetActive(false)
			self.main.unknow.gameObject:SetActive(false)
			self.main.unknowtwo.gameObject:SetActive(false)
			self.main.acceptorrefuse.gameObject:SetActive(true)

			self.main.acceptorrefuse.accept.text.text.text = var_0_1:getNowLang("accept")
			self.main.acceptorrefuse.refuse.text.text.text = var_0_1:getNowLang("refuse")
			self.main.head.img.image.sprite = self:loadSprite(var_0_4(var_0_5.friends_head, var_0_10.find_object_by_cid(var_26_0[arg_27_1 + 1].head).icon))
			self.main.playername.playername_1.text.text = var_26_0[arg_27_1 + 1].name

			self.main.playername:GetComponent("TextHorizonScroller"):SetText(var_26_0[arg_27_1 + 1].name)

			self.main.lv.text.text = "(LV." .. var_26_0[arg_27_1 + 1].level .. ")"
			self.main.introduction.text.text.text = var_26_0[arg_27_1 + 1].signature

			self.main.acceptorrefuse.accept.button.onClick:RemoveAllListeners()
			self.main.acceptorrefuse.accept.button.onClick:AddListener(function()
				self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.open))

				if self._user_have_friends ~= nil and #self._user_have_friends == 60 then
					var_0_8:show(var_0_1:getNowLang("friend_full"))
				else
					var_0_3:req_agreefriendreq(var_26_0[arg_27_1 + 1].account_id)
				end

				self:updata_data()
			end)
			self.main.acceptorrefuse.refuse.button.onClick:RemoveAllListeners()
			self.main.acceptorrefuse.refuse.button.onClick:AddListener(function()
				self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.open))
				var_0_3:req_removefriendreq(var_26_0[arg_27_1 + 1].account_id)
				self:updata_data()
			end)
		end
	end

	function arg_1_0:__update_cell_recommend()
		local var_30_0 = self._now_data

		self._reusable_cell_recommend:set_data(self._now_data)

		if not self._now_data or #self._now_data == 0 then
			return
		end

		self._havefriend_new_array = {}

		function self._reusable_cell_recommend:_set_func(arg_31_1)
			local var_31_0 = var_30_0[arg_31_1 + 1] and var_0_10.find_object_by_cid(var_30_0[arg_31_1 + 1].head or 10000161).icon or var_0_10.find_object_by_cid(10000161).icon

			self.main.head.newimg.gameObject:SetActive(false)
			self.main.logintime.gameObject:SetActive(false)
			self.main.unknow.gameObject:SetActive(false)
			self.main.unknowtwo.gameObject:SetActive(true)
			self.main.acceptorrefuse.gameObject:SetActive(false)

			self.main.unknowtwo.btn.text.text.text = var_0_1:getNowLang("ad_tip1")

			if var_30_0[arg_31_1 + 1] and var_0_13(var_30_0[arg_31_1 + 1]) then
				self.main.playername.playername_1.text.text = var_30_0[arg_31_1 + 1].name
			else
				return
			end

			self.main.playername:GetComponent("TextHorizonScroller"):SetText(var_30_0[arg_31_1 + 1].name)

			self.main.lv.text.text = "(LV." .. var_30_0[arg_31_1 + 1].level .. ")"
			self.main.introduction.text.text.text = var_30_0[arg_31_1 + 1].signature
			self.main.rankimg.image.sprite = self:loadSprite(var_0_5:get_format_url(var_0_5.common_icon.friend_badge_path, var_30_0[arg_31_1 + 1].exploit))
			self.main.head.img.image.sprite = self:loadSprite(var_0_4(var_0_5.friends_head, var_31_0))

			self.main.unknowtwo.btn.button.onClick:RemoveAllListeners()
			self.main.unknowtwo.btn.button.onClick:AddListener(function()
				self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.open))

				self._cell_copy = self.main.transform.parent

				if not arg_31_1 then
					return
				end

				self._cell_index = arg_31_1 + 1

				if self._button_isuse == false then
					return
				end

				self._button_isuse = false

				if #var_30_0 == self._friends_max then
					var_0_8:show(var_0_1:getNowLang("friend_full"))
				elseif var_30_0[arg_31_1 + 1] then
					var_0_3:req_addfriendreq(var_30_0[arg_31_1 + 1].account_id)
				end
			end)
			self.main.info.button.onClick:RemoveAllListeners()
			self.main.info.button.onClick:AddListener(function()
				self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.open))
				var_0_2:createInstance("friendinfo"):show(var_30_0[arg_31_1 + 1], arg_31_1, var_0_5.can_not)
			end)
		end
	end

	function arg_1_0:init_move(arg_34_1)
		local var_34_0 = self:autoKillDOTween(var_0_9.Sequence())

		var_34_0:Append(arg_34_1:DOBlendableLocalMoveBy(Vector3.New(1227, 0), 0.15):SetEase(DG.Tweening.Ease.Linear))
		var_34_0:AppendCallback(function()
			var_0_7(self._now_data, self._cell_index)
		end)
		var_34_0:Play()
		var_34_0:AppendInterval(0.3)
		var_34_0:AppendCallback(function()
			self:__update_cell_recommend()

			self._control.mainrecfriend.mian.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_12(1.3, 0)
		end)
	end

	function arg_1_0:__set_addfriends_data()
		self:__apply_array()

		self._data_by_type = {
			self._havefriend_array,
			self._addfriend_array,
			self._recommend_data
		}
	end

	function arg_1_0:__get_data_by_index(arg_38_1)
		self._now_data = self._data_by_type[arg_38_1]

		return self._now_data
	end

	function arg_1_0:__is_already_init()
		return self._already_init
	end

	function arg_1_0:set_lookable(arg_40_1)
		self._canvas_group = self._canvas_group or self._panel.transform:GetComponent("CanvasGroup")
		self._canvas_group.alpha = arg_40_1 and 1 or 0
		self._canvas_group.blocksRaycasts = arg_40_1 or false

		self:setVisible(true)
	end

	function arg_1_0.play_into_home_bgm(arg_41_0)
		local var_41_0 = var_0_2:getInstance("home")

		if not var_41_0 then
			var_41_0 = var_0_2:createInstance("home")

			var_41_0:show()
			var_41_0:setVisible(false)
		else
			var_41_0:into_home_bgm()
		end
	end

	function arg_1_0:__onReset()
		self._now_label = var_0_16.btnone

		if self._now_content then
			self._now_content.toggle.isOn = false

			self:__set_title_style(self._now_content, false)
		end

		self._now_content = self._control.maintop.topmenu.topbtn.btnone
		self._last_content = self._control.maintop.topmenu.topbtn.btnone
		self._control.mainmid.mid.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_12(0, 0)
		self._control.mainapplyfor.applyfor.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_12(0, 0)
		self._control.mainrecfriend.mian.scrollview.viewport.content.rectTransform.anchoredPosition = var_0_12(0, 0)
		self._control.makefriends.addfriends.main.inputfieldmaybe.inputField.text = ""
	end

	function arg_1_0:_play_into_se(arg_43_1)
		self:playSE(arg_43_1, false)
	end

	function arg_1_0:set_scroll_position()
		if self.scrollbar_value_f ~= 1 then
			self._control.mainmid.mid.scrollview.scrollbarvertical:GetComponent("Scrollbar").value = self.scrollbar_value_f
		end

		if self.scrollbar_value_a ~= 1 then
			self._control.mainapplyfor.applyfor.scrollview.scrollbarvertical:GetComponent("Scrollbar").value = self.scrollbar_value_a
		end

		if self.scrollbar_value_r ~= 1 then
			self._control.mainrecfriend.mian.scrollview.scrollbarvertical:GetComponent("Scrollbar").value = self.scrollbar_value_r
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_45_0)
	local var_45_0 = var_0_2:class("friendsmain")

	var_45_0._already_init = false
	var_45_0._last_content = nil
	var_45_0._now_label = nil
	var_45_0._now_content = nil
	var_45_0._reusable_cell_add = nil
	var_45_0._reusable_cell_have = nil
	var_45_0._reusable_cell_recommend = nil
	var_45_0._now_data = {}
	var_45_0._data_by_type = {}
	var_45_0._friend_uid = nil
	var_45_0._button_isuse = true
	var_45_0._have_data = nil
	var_45_0._applyfor_data = nil
	var_45_0._addfriend_array = {}
	var_45_0._recommend_data = {}
	var_45_0._havefriend_array = {}
	var_45_0._button_four = true
	var_45_0._havefriend_new_array = {}
	var_45_0._cell_copy = nil
	var_45_0._cell_index = nil
	var_45_0._rec_data = nil
	var_45_0._enter_type = nil
	var_45_0._user_have_friends = nil
	var_45_0._user_add_friends = nil
	var_45_0._friends_max = 60
	var_45_0._apply_friends_max = 100
	var_45_0._newfrind = true
	var_45_0._is_play = true
	var_45_0._is_play_bg = true
	var_45_0.scrollbar_value_f = 1
	var_45_0.scrollbar_value_a = 1
	var_45_0.scrollbar_value_r = 1

	return var_45_0
end

return var_0_0
