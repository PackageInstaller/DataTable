-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/setting/view/SettingMediator.lua

SettingMediator = class("SettingMediator", DmPopupViewMediator, _M)

SettingMediator:has("_settingSystem", {
	is = "r"
}):injectWith("SettingSystem")
SettingMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.setUsr.btn_changename"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickChangeName"
	},
	["main.setUsr.btn_gameSet"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickGameValueSet"
	},
	["main.setUsr.btn_exit"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickExit"
	},
	["main.setUsr.changeHeadBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickChangeHeadImg"
	},
	["main.bgNode.close"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickClose"
	},
	["main.setUsr.btn_changeslogan"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickChangeSlogan"
	},
	["main.setUsr.areaBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickSetArea"
	},
	["main.setUsr.copyBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickCopyPlayerID"
	},
	["main.btn_chat"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBtn"
	},
	["main.btn_add"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBtn"
	},
	["main.btn_Ok"] = {
		clickAudio = "Se_Click_Confirm",
		func = "onClickBtn"
	},
	["main.setUsr.titleBg"] = {
		clickAudio = "Se_Click_Confirm",
		func = "onClickChangeTitle"
	}
}
local kHeroRarityBg = {
	[15] = {
		"wjxx_hbzs_sp1.png",
		"wjxx_hbzs_zhezhao1.png"
	},
	[14] = {
		"wjxx_hbzs_ssr1.png",
		"wjxx_hbzs_zhezhao1.png"
	},
	[13] = {
		"wjxx_hbzs_sr1.png",
		"wjxx_hbzs_zhezhao2.png"
	},
	[12] = {
		"wjxx_hbzs_r1.png",
		"wjxx_hbzs_zhezhao2.png"
	},
	[11] = {
		"wjxx_hbzs_r1.png",
		"wjxx_hbzs_zhezhao2.png"
	}
}

function SettingMediator:initialize()
	super.initialize(self)
end

function SettingMediator:dispose()
	super.dispose(self)
end

function SettingMediator:onRegister()
	super.onRegister(self)
	self:mapEventListeners()
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._friendSystem = self:getInjector():getInstance(FriendSystem)
	self._chatSystem = self:getInjector():getInstance(ChatSystem)
end

function SettingMediator:enterWithData(data)
	self:initNode()
	self:initData(data)
	self:showSettingView()
	self:showPlayerServerInfo()
	self:showHeroList()
	self:setButtonStatus()
end

function SettingMediator:initNode()
	self._view = self:getView()
	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByFullName("listView")
	self._usrNode = self._main:getChildByFullName("setUsr")
	self._sloganEditBox = self._main:getChildByFullName("setUsr.TextField")
	self._cellClone = self._main:getChildByFullName("roleStand_1")

	self._cellClone:setVisible(false)
end

function SettingMediator:initData(data)
	self._player = data.player
	self._record = data.record
	self._fromView = data.fromView or ""
	self._playerGender = self._player.gender
	self._playerArea = self._player.city
	self._clubName = self._player.clubName

	local rid = self._developSystem:getPlayer():getRid()

	self._isSelf = false

	if rid == self._player.id then
		self._isSelf = true
	end
end

function SettingMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHANGENAME_SUCC, self, self.showSettingView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHANGESLOGAN_SUCC, self, self.showSettingView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHANGEHEADIMG_SUCC, self, self.showSettingView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHANGEHEADFRAME_SUCC, self, self.showSettingView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.showSettingView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CHANGETITLE_SUCC, self, self.showSettingView)
end

function SettingMediator:showSettingView()
	local layout = self._main

	layout:setVisible(true)

	local player = self._player
	local nameText = layout:getChildByFullName("setUsr.name_value")

	if self._isSelf then
		nameText:setString(self._developSystem:getPlayer():getNickName())
	else
		nameText:setString(player.nickname)
	end

	self._main:getChildByFullName("setUsr.btn_changename"):setVisible(self._isSelf)

	local idText = layout:getChildByFullName("setUsr.id_value")
	local idStr = string.split(player.id, "_")

	idText:setString(idStr[1])

	local levelText = layout:getChildByFullName("setUsr.level_value")

	levelText:setString(player.level)

	local maxLength = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Slogan_Max", "content")

	self._lastSlogan = self._isSelf and self._developSystem:getPlayer():getSlogan() or player.slogan

	self._main:getChildByFullName("setUsr.btn_changeslogan"):setVisible(self._isSelf)

	if self._sloganEditBox:getDescription() == "TextField" then
		self._sloganEditBox:setMaxLength(maxLength)
		self._sloganEditBox:setMaxLengthEnabled(true)
		self._sloganEditBox:setString(Strings:get(self._lastSlogan))
		self._sloganEditBox:setPlaceHolderColor(cc.c4b(255, 255, 255, 255))

		if self._isSelf then
			self._sloganEditBox = convertTextFieldToEditBox(self._sloganEditBox, nil, MaskWordType.CHAT)

			self._sloganEditBox:setReturnType(0)
			self._sloganEditBox:setInputMode(0)
			self._sloganEditBox:onEvent(function(eventName, sender)
				if eventName == "began" then
					self._sloganEditBox:setPlaceHolder("")
					self._sloganEditBox:setText("")
				elseif eventName == "ended" then
					self:changePlayerSlogan()
				elseif eventName == "return" then
					-- block empty
				elseif eventName == "changed" then
					-- block empty
				elseif eventName == "ForbiddenWord" then
					self._sloganEditBox:setText(self._lastSlogan)
					self:getEventDispatcher():dispatchEvent(ShowTipEvent({
						tip = Strings:get("Common_Tip1_1")
					}))
				elseif eventName == "Exceed" then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("Tips_WordNumber_Limit", {
							number = sender:getMaxLength()
						})
					}))
				end
			end)
		end
	end

	self._main:getChildByFullName("setUsr.changeHeadBtn"):setVisible(self._isSelf)

	local headImg, headFrame = player.headImg, player.headFrame

	if self._isSelf then
		headImg = self._developSystem:getPlayer():getHeadId()
		headFrame = self._developSystem:getPlayer():getCurHeadFrame()
	end

	local headicon, oldIcon = IconFactory:createPlayerIcon({
		clipType = 4,
		id = headImg,
		size = cc.size(93, 94),
		headFrameId = headFrame
	})
	local iconbg = layout:getChildByFullName("setUsr.headImg")

	iconbg:removeAllChildren()
	headicon:addTo(iconbg):center(iconbg:getContentSize())
	headicon:setScale(0.85)
	oldIcon:setScale(0.5)

	local fightLab = self._usrNode:getChildByName("fight")

	fightLab:setString(tostring(player.combat))

	local cityView = self._usrNode:getChildByName("area")

	self._main:getChildByFullName("setUsr.areaBtn"):setVisible(self._isSelf)
	self._main:getChildByFullName("setUsr.Image2"):setVisible(self._isSelf)

	if self._playerArea == nil or self._playerArea == "" then
		cityView:setString("")
	else
		local parts = string.split(self._playerArea, "-")
		local areaInfo = ConfigReader:getRecordById("PlayerPlace", parts[1])
		local str1 = Strings:get(areaInfo.Provinces)
		local cityInfo = areaInfo.City[tonumber(parts[2])]
		local str2 = Strings:get(cityInfo)

		cityView:setString(str1 .. "  " .. str2)
	end

	local clubName = self._usrNode:getChildByName("clubName")

	if self._clubName and self._clubName ~= "" then
		clubName:setString(self._clubName)
	else
		clubName:setString(Strings:get("Petrace_Text_78"))
	end

	self._main:getChildByFullName("setUsr.btn_exit"):setVisible(self._isSelf)
	self._main:getChildByFullName("setUsr.btn_gameSet"):setVisible(self._isSelf)

	local curTitleId = self._isSelf and self._developSystem:getPlayer():getCurTitleId() or player.title
	local titletips = self._usrNode:getChildByName("titletips")

	titletips:setVisible(curTitleId == "")

	local titleBg = self._usrNode:getChildByName("titleBg")

	titleBg:removeAllChildren()

	if curTitleId ~= "" then
		local icon = IconFactory:createTitleIcon({
			id = curTitleId
		})

		icon:addTo(titleBg):center(titleBg:getContentSize())
		icon:setScale(0.9)
	end

	local rtpkPanel = self._main:getChildByFullName("rtPK")
	local stageArenaPanel = self._main:getChildByFullName("leaderStage")
	local noRank = self._main:getChildByFullName("wuTag")

	rtpkPanel:setVisible(false)
	stageArenaPanel:setVisible(false)

	local rtpkRank = player.rtpkRank
	local stageArenaRank = player.stageArenaRank

	if rtpkRank == -1 and stageArenaRank == -1 then
		noRank:setVisible(true)
		rtpkPanel:setVisible(false)
		stageArenaPanel:setVisible(false)
	else
		noRank:setVisible(false)

		if rtpkRank > 0 then
			rtpkPanel:setVisible(true)

			local rtpkScore = player.rtpkScore
			local rTPKSystem = self:getInjector():getInstance(RTPKSystem)
			local info = rTPKSystem:getGradeConfigByScore(rtpkScore)
			local iconPanel = rtpkPanel:getChildByFullName("icon")
			local icon = IconFactory:createRTPKGradeIcon(info.Id, {
				hideName = true
			})

			icon:addTo(iconPanel):center(iconPanel:getContentSize()):offset(0, 10)
			icon:setScale(0.35)

			local name = rtpkPanel:getChildByFullName("tagName")

			name:setString(Strings:get(info.Name))

			if rtpkRank <= 3 then
				rtpkPanel:getChildByFullName("rankDi"):loadTexture(RankTopImage[rtpkRank], 1)
			else
				rtpkPanel:getChildByFullName("rank"):setString(rtpkRank)
			end
		end

		if stageArenaRank > 0 then
			stageArenaPanel:setVisible(true)

			local stageArenaScore = player.stageArenaScore
			local leadStageArenaSystem = self:getInjector():getInstance(LeadStageArenaSystem)

			stageArenaPanel:getChildByFullName("tagName"):setString(stageArenaScore)

			if stageArenaRank <= 3 then
				stageArenaPanel:getChildByFullName("rankDi"):loadTexture(RankTopImage[stageArenaRank], 1)
			else
				stageArenaPanel:getChildByFullName("rank"):setString(stageArenaRank)
			end
		end
	end

	if not rtpkPanel:isVisible() and stageArenaPanel:isVisible() then
		stageArenaPanel:setPositionX(rtpkPanel:getPositionX())
	end

	self._btnOkNode = self._main:getChildByFullName("btn_Ok")
	self._btnChatNode = self._main:getChildByFullName("btn_chat")
	self._btnAddNode = self._main:getChildByFullName("btn_add")

	self._btnOkNode:setVisible(not self._isSelf)
	self._btnChatNode:setVisible(not self._isSelf)
	self._btnAddNode:setVisible(not self._isSelf)

	if not self._isSelf then
		-- block empty
	end
end

function SettingMediator:showPlayerServerInfo()
	local starNum = self._usrNode:getChildByFullName("starLevel")
	local heroNum = self._usrNode:getChildByFullName("heroNum")
	local surfaceNum = self._usrNode:getChildByFullName("surfaceNum")
	local leaderNum = self._usrNode:getChildByFullName("leaderLab")

	starNum:setString(tostring(self._player.totalStar))
	heroNum:setString(tostring(self._player.totalHeroes))
	surfaceNum:setString(tostring(self._player.totalSurface))

	if self._player.leadStageId and self._player.leadStageId ~= "" then
		local info = ConfigReader:getRecordById("MasterLeadStage", self._player.leadStageId)

		leaderNum:setString(Strings:get(info.RomanNum) .. Strings:get(info.StageName))
	else
		leaderNum:setString("")
	end
end

function SettingMediator:showHeroList()
	for i = 1, 4 do
		if not self._main:getChildByFullName("cellClone" .. i) then
			local panel = self._cellClone:clone()

			panel:setVisible(true)
			panel:setName("cellClone" .. i)
			panel:addTo(self._main):posite(434 + (i - 1) * 150, 230)
		end
	end

	if self._isSelf then
		local myHeros = self._developSystem:getPlayer():getShowHeroes()

		for i = 1, 4 do
			local panel = self._main:getChildByFullName("cellClone" .. i)
			local jia = panel:getChildByFullName("jia")

			jia:setVisible(false)

			local role = panel:getChildByFullName("role")

			role:removeAllChildren()

			local starPanel = panel:getChildByFullName("starPanel")

			starPanel:setVisible(false)

			if myHeros[i] then
				local roleModel = IconFactory:getRoleModelByKey("HeroBase", myHeros[i])
				local heroData = self._heroSystem:getHeroById(myHeros[i])
				local showData = {}

				showData.model = (heroData or nil) and heroData:getModel()
				showData.maxStar = heroData:getMaxStar()
				showData.star = heroData:getStar()
				showData.litterStar = heroData:getLittleStar()
				showData.awakenLevel = heroData:getAwakenLevel()
				showData.rarity = heroData:getRarity()
				showData.level = heroData:getLevel()
				showData.identityAwakenLevel = heroData:getIdentityAwakenLevel()

				self:showHeroModel(showData, panel)
			else
				jia:setVisible(true)

				local imgDi = panel:getChildByFullName("di")

				imgDi:loadTexture("wjxx_hbzs_di3.png", 1)

				local imgMask = panel:getChildByFullName("mask")

				imgMask:setVisible(false)
			end

			role:addClickEventListener(function()
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

				local outSelf, delegate = self, {}

				function delegate:willClose(popupMediator, data)
					if data.ids then
						outSelf._settingSystem:changeShowHero(data.ids, function()
							if checkDependInstance(self) then
								outSelf:showHeroList()
							end
						end)
					end
				end

				local view = self:getInjector():getInstance("SetHeroShowView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, {
					selectIds = myHeros
				}, delegate))
			end)
		end
	else
		for i = 1, 4 do
			local panel = self._main:getChildByFullName("cellClone" .. i)
			local jia = panel:getChildByFullName("jia")

			jia:setVisible(false)

			local role = panel:getChildByFullName("role")

			role:removeAllChildren()

			local starPanel = panel:getChildByFullName("starPanel")

			starPanel:setVisible(false)

			local info = self._player.showHeroes[i]

			if info then
				local heroData = self._heroSystem:getHeroInfoById(info.heroId)
				local showData = {}

				showData.model = ConfigReader:getDataByNameIdAndKey("Surface", info.surfaceId, "Model")
				showData.maxStar = heroData.maxStar
				showData.star = info.star
				showData.litterStar = info.litterStar
				showData.awakenLevel = info.awakenLevel
				showData.rarity = info.rarity
				showData.level = info.level
				showData.identityAwakenLevel = info.identityAwakenLevel

				self:showHeroModel(showData, panel)
				role:addClickEventListener(function()
					AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

					local view = self:getInjector():getInstance("SetHeroShowDetailView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
					}, {
						heros = self._player.showHeroes,
						index = i
					}))
				end)
			else
				local imgDi = panel:getChildByFullName("di")

				imgDi:loadTexture("wjxx_hbzs_di3.png", 1)

				local imgMask = panel:getChildByFullName("mask")

				imgMask:setVisible(false)
			end
		end
	end
end

function SettingMediator:showHeroModel(info, panel)
	local starPanel = panel:getChildByFullName("starPanel")
	local role = panel:getChildByFullName("role")
	local imgDi = panel:getChildByFullName("di")
	local imgMask = panel:getChildByFullName("mask")

	imgDi:loadTexture(kHeroRarityBg[info.rarity][1], 1)
	imgMask:loadTexture(kHeroRarityBg[info.rarity][2], 1)
	imgMask:setVisible(true)
	starPanel:setVisible(true)
	role:setVisible(true)

	local heroIcon = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe4_7",
		id = info.model
	})

	heroIcon:setScale(0.7)
	heroIcon:addTo(role):center(role:getContentSize())

	local starBg = starPanel:getChildByFullName("starBg")

	starBg:removeAllChildren()

	local starBgWidth = starBg:getContentSize().width
	local offsetX = (HeroStarCountMax - info.maxStar) * starBgWidth / 14

	for i = 1, info.maxStar do
		local path = i <= info.star and "img_yinghun_img_star_full.png" or i == info.star + 1 and info.litterStar and "img_yinghun_img_star_half.png" or "img_yinghun_img_star_empty.png"

		if info.awakenLevel > 0 then
			path = "jx_img_star.png"
		end

		local star = cc.Sprite:createWithSpriteFrameName((i <= (info.identityAwakenLevel or 0) or nil) and "yinghun_img_awake_star.png")

		star:addTo(starBg)
		star:setPosition(cc.p(offsetX + i / 7 * starBgWidth, 22))
		star:setScale(0.4)
	end

	starBg:setScale(0.9)

	local rarityBg = starPanel:getChildByFullName("rarityBg")

	rarityBg:removeAllChildren()

	local rarityAnim = IconFactory:getHeroRarityAnim(info.rarity)

	rarityAnim:addTo(rarityBg):posite(20, 34)
	rarityAnim:setScale(0.8)

	local levelImage = starPanel:getChildByName("levelImage")
	local level = starPanel:getChildByFullName("level")

	level:setString(Strings:get("Strenghten_Text78", {
		level = info.level
	}))

	local levelImageWidth = levelImage:getContentSize().width
	local levelWidth = level:getContentSize().width

	levelImage:setScaleX((levelWidth + 10) / levelImageWidth)
end

function SettingMediator:changePlayerSlogan()
	local newStr = self._sloganEditBox:getText()

	if newStr == self._lastSlogan then
		return
	end

	if StringChecker.meaninglessString(newStr) then
		self._sloganEditBox:setText(self._lastSlogan)

		return
	end

	self._settingSystem:requestChangePlayerSlogan(newStr)
end

function SettingMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end

function SettingMediator:onClickGameValueSet()
	local view = self:getInjector():getInstance("GameValueSetView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}))
end

function SettingMediator:onClickChangeName(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local view = self:getInjector():getInstance("changeNameView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {}))
	end
end

function SettingMediator:onClickChangeSlogan(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._sloganEditBox:setText("")
		self._sloganEditBox:openKeyboard()
	end
end

function SettingMediator:onClickGameAnnounce(sender, eventType)
	if CommonUtils.GetSwitch("fn_announce_check_in") then
		local view = self:getInjector():getInstance("serverAnnounceViewNew")
		local delegate = {}

		function delegate:willClose(popupMediator, data)
			popupMediator:resetData()
		end

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			isDeductTime = 0
		}, delegate))
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("HeroStory_Team_UI1")
		}))
	end
end

function SettingMediator:onClickExit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local view = self:getInjector():getInstance("ExitGameView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {}))
	end
end

function SettingMediator:onClickChangeHeadImg(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		if GameConfigs.fn_change_head_img == false then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:get("PM02_UnlockTips")
			}))

			return
		end

		local view = self:getInjector():getInstance("ChangeHeadImgView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {}))
	end
end

function SettingMediator:commitPlayerInfo()
	local playerInfo = {}

	playerInfo.gender = self._playerGender
	playerInfo.city = self._playerArea
	playerInfo.birthday = self._playerBirthday
	playerInfo.tags = 0

	self._settingSystem:requestUpdatePlayerInfo(playerInfo, function()
		cc.UserDefault:getInstance():setStringForKey("playerCity", self._playerArea)
		self:showSettingView()
	end)
end

function SettingMediator:onClickSetArea()
	local view = self:getInjector():getInstance("SetAreaPopView")
	local delegate, outSelf = {}, self

	function delegate:willClose(_, data)
		if data then
			outSelf._playerArea = data.areaStr

			outSelf:commitPlayerInfo()
		end

		local regionData = outSelf._settingSystem:getRegionData()
		local a = string.split(outSelf._playerArea, "-")
		local b = regionData[a[1]]

		if not b then
			return
		end

		local c = b.FID

		if not c then
			return
		end

		local cityId = c[tonumber(a[2])]

		if not cityId then
			return
		end

		outSelf._settingSystem:requestWeatherData(cityId, function()
			outSelf:dispatch(Event:new(EVT_HOME_SET_CLIMATE))
		end)
	end

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		playerArea = self._playerArea
	}, delegate))
end

function SettingMediator:onClickCopyPlayerID()
	local player = self._player
	local idStr = string.split(player.id, "_")

	if app.getDevice and app.getDevice() then
		app.getDevice():copyStringToClipboard(idStr[1])
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Setting_Copy_Suc")
		}))
	end
end

function SettingMediator:onClickCode()
	local view = self:getInjector():getInstance("SettingCodeExchangeView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}))
end

function SettingMediator:onClickBuyMonthCard()
	local activitySystem = self:getInjector():getInstance("ActivitySystem")

	activitySystem:tryEnter({
		id = "MonthCard"
	})
end

function SettingMediator:onClickChangeTitle(sender, eventType)
	local view = self:getInjector():getInstance("PlayerTitleView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}))
end

function SettingMediator:onClickBtn(sender)
	local name = sender:getName()

	if name == "ok" then
		self:onOkClicked()
	elseif name == "sendMsg" then
		self:onSendMsgClicked()
	elseif name == "addFriend" then
		self:onAddFriendClicked()
	elseif name == "removeFriend" then
		self:onRemoveFriendClicked()
	elseif name == "addShield" then
		self:onAddShieldClicked()
	elseif name == "removeShield" then
		self:onRemoveShieldClicked()
	elseif name == "agreeFriendApply" then
		self:onAgreeFriendApplyClicked()
	end
end

function SettingMediator:setButtonStatus()
	if self._isSelf then
		return
	end

	local chatBtn = self._main:getChildByName("btn_chat")
	local btnOk = self._main:getChildByName("btn_Ok")
	local friendBtn = self._main:getChildByName("btn_add")
	local isShield = self._record:getBlock()
	local isFriend = self._friendSystem:checkIsFriend(self._record:getRid())

	if isShield then
		chatBtn:setVisible(false)
		btnOk:setVisible(false)
		self:setButton(self._btnAddNode, Strings:get("RANK_REMOVE_SHIELD"), Strings:get("RANK_REMOVE_SHIELD_EN"), "removeShield")
		friendBtn:setPositionX(btnOk:getPositionX())

		return
	end

	if isFriend then
		self:setButton(self._btnChatNode, Strings:get("SettingUI_05"), Strings:get("RANK_ADD_SHIELD_EN"), "addShield")
		self:setButton(self._btnOkNode, Strings:get("RANK_REMOVE_FRIEND"), Strings:get("RANK_REMOVE_FRIEND_EN"), "removeFriend")
		self:setButton(self._btnAddNode, Strings:get("RANK_CHAT"), Strings:get("UIFRIEND_EN_Faxiaoxi"), "sendMsg")
	else
		self:setButton(self._btnChatNode, Strings:get("SettingUI_05"), Strings:get("RANK_ADD_SHIELD_EN"), "addShield")
		self:setButton(self._btnOkNode, Strings:get("RANK_CHAT"), Strings:get("UIFRIEND_EN_Faxiaoxi"), "sendMsg")
		dump(self._fromView, "self._formView-_")

		if self._fromView == "friendApply" then
			self:setButton(self._btnAddNode, Strings:get("Friend_UI47"), Strings:get("UIFRIEND_EN_Jiahaoyou"), "agreeFriendApply")
		else
			self:setButton(self._btnAddNode, Strings:get("RANK_ADD_FRIEND"), Strings:get("UIFRIEND_EN_Jiahaoyou"), "addFriend")
		end
	end
end

function SettingMediator:setButton(view, txt, txten, name)
	view:getChildByName("txt"):setString(txt)
	view:setName(name)
end

function SettingMediator:onSendMsgClicked()
	if self._record.lastView ~= "friendChatView" then
		local var_38_0 = {
			rid = self._record:getRid(),
			nickname = self._record:getNickName(),
			level = self._record:getLevel(),
			combat = self._record:getCombat(),
			headImage = self._record:getHeadId(),
			vipLevel = self._record:getVipLevel(),
			heroes = self._record:getHeroes(),
			master = self._record:getMaster(),
			clubName = self._record:getClubName(),
			slogan = self._record:getSlogan(),
			online = self._record:getOnline(),
			lastOfflineTime = self._record:getLastOfflineTime(),
			isFriend = self._record:getIsFriend()
		}

		var_38_0.close = self._record:getIsFriend() == 1 and self._record:getFamiliarity() or nil
		var_38_0.leadStageId = self._record:getLeadStageId()
		var_38_0.leadStageLevel = self._record:getLeadStageLevel()

		local data = var_38_0

		self._friendSystem:addRecentFriend(data)

		local data = {
			subTabType = 2,
			selectFriendIndex = 1,
			tabType = kFriendType.kRecent
		}

		self._friendSystem:tryEnter(data)
	end

	self:close()
end

function SettingMediator:onAddFriendClicked()
	local record = Friend:new()

	record:synchronize({
		rid = self._record:getRid(),
		nickname = self._record:getNickName(),
		vip = self._record:getVipLevel(),
		level = self._record:getLevel(),
		combat = self._record:getCombat(),
		headImage = self._record:getHeadId(),
		clubName = self._record:getClubName()
	})

	local view = self:getInjector():getInstance("FriendAddPopView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, record))
	self:close()
end

function SettingMediator:onOkClicked()
	self:close()
end

function SettingMediator:onRemoveFriendClicked()
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == AlertResponse.kOK then
			outSelf._friendSystem:requestDeleteFriend(outSelf._record:getRid(), function()
				outSelf:getEventDispatcher():dispatchEvent(ShowTipEvent({
					duration = 0.35,
					tip = Strings:get("Friend_Remove_Friend_Succ")
				}))
				outSelf:close()
			end)
		elseif data.response == AlertResponse.kCancel then
			-- block empty
		end
	end

	local data = {
		title = Strings:get("UPDATE_UI7"),
		title1 = Strings:get("UITitle_EN_Tishi"),
		content = Strings:get("Friend_UI33"),
		sureBtn = {},
		cancelBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data, delegate))
end

function SettingMediator:onAddShieldClicked()
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == AlertResponse.kOK then
			outSelf:requestBlockUser(outSelf._record:getRid(), false)
		elseif data.response == AlertResponse.kCancel then
			-- block empty
		end
	end

	local data = {
		title = Strings:get("UPDATE_UI7"),
		title1 = Strings:get("UITitle_EN_Tishi"),
		content = Strings:get("RANK_ADD_SHIELD_CONTENT"),
		sureBtn = {},
		cancelBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data, delegate))
end

function SettingMediator:onRemoveShieldClicked()
	local friendCount = self._friendSystem:getFriendModel():getFriendCount(kFriendType.kGame)
	local maxCount = self._friendSystem:getFriendModel():getMaxFriendsCount()

	if self._chatSystem:getBlockUserFriendStatus(self._record:getRid()) and maxCount <= friendCount then
		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == AlertResponse.kOK then
				outSelf:requestBlockUser(outSelf._record:getRid(), true)
			elseif data.response == AlertResponse.kCancel then
				-- block empty
			end
		end

		local data = {
			title = Strings:get("UPDATE_UI7"),
			title1 = Strings:get("UITitle_EN_Tishi"),
			content = Strings:get("RANK_REMOVE_SHIELD_FRIENDFULL_CONTENT"),
			sureBtn = {},
			cancelBtn = {}
		}
		local view = self:getInjector():getInstance("AlertView")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data, delegate))
	else
		self:requestBlockUser(self._record:getRid(), true)
	end
end

function SettingMediator:requestBlockUser(shieldId, status)
	local function callback(data)
		if data then
			if self._chatSystem:getBlockUserStatus(shieldId) then
				local var_49_0 = Strings:get("Chat_ShieldSuccess_Tips")

				if not var_49_0 then
					var_49_0 = Strings:get("Chat_ShieldCancel_Tips")

					local tips = var_49_0

					self:getEventDispatcher():dispatchEvent(ShowTipEvent({
						duration = 0.35,
						tip = tips
					}))
					self._friendSystem:requestFriendsMainInfo()
					self:close()
				end
			end
		end
	end

	local block = status and {} or {
		shieldId
	}
	local unblock = status and {
		shieldId
	} or {}

	self._chatSystem:requestBlockUser(block, unblock, callback)
end

function SettingMediator:onAgreeFriendApplyClicked()
	self._friendSystem:requestAgreeFriend(self._record:getRid())
	self:close()
end
