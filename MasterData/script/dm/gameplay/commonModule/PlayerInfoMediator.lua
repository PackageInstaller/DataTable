-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/commonModule/PlayerInfoMediator.lua

PlayerInfoMediator = class("PlayerInfoMediator", DmPopupViewMediator, _M)

PlayerInfoMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
PlayerInfoMediator:has("_friendSystem", {
	is = "r"
}):injectWith("FriendSystem")
PlayerInfoMediator:has("_chatSystem", {
	is = "r"
}):injectWith("ChatSystem")

local kBtnHandlers = {
	["bg.btn_chat"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBtn"
	},
	["bg.btn_add"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBtn"
	},
	["bg.btn_Ok"] = {
		clickAudio = "Se_Click_Confirm",
		func = "onClickBtn"
	}
}
local constellationAge = {
	120,
	219,
	321,
	420,
	521,
	622,
	723,
	823,
	923,
	1024,
	1123,
	1222
}
local constellation = {
	"Aquarius",
	"Pisces",
	"Aries",
	"Taurus",
	"Gemini",
	"Cancer",
	"Leo",
	"Virgo",
	"Libra",
	"Scorpio",
	"Sagittarius",
	"Capricorn"
}

function PlayerInfoMediator:initialize()
	super.initialize(self)
end

function PlayerInfoMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function PlayerInfoMediator:onRemove()
	super.onRemove(self)
end

function PlayerInfoMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._bg = self:getView():getChildByName("bg")
	self._btnOkNode = self:getView():getChildByFullName("bg.btn_Ok")
	self._btnChatNode = self:getView():getChildByFullName("bg.btn_chat")
	self._btnAddNode = self:getView():getChildByFullName("bg.btn_add")
end

function PlayerInfoMediator:userInject()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._player = self._developSystem:getPlayer()
	self._masterSystem = self._developSystem:getMasterSystem()
end

function PlayerInfoMediator:enterWithData(data)
	local text = self._bg:getChildByFullName("Text_107")

	text:setAdditionalKerning(35)

	local bgNode = self._bg:getChildByFullName("tipnode")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onOkClicked, self)
		},
		title = Strings:get("RANK_PLAYER_VIEW_TITLE"),
		title1 = Strings:get("UITitle_EN_Wanjiaxinxi"),
		bgSize = {
			width = 840,
			height = 580
		}
	})

	self._record = data

	local extraData = {}

	extraData.gender = data:getGender()
	extraData.birthday = data:getBirthday()
	extraData.city = data:getCity()
	extraData.tags = data:getTags()
	self._baseData = extraData

	self:initRoleInfo()
	self:initBaseInfo()
	self:initTeamInfo()
end

function PlayerInfoMediator:addShieldView()
	if self:getView():getChildByName("shieldBtn") then
		return
	end

	local button = ccui.Button:create()

	button:addTo(self:getView()):center(self:getView():getContentSize())
	button:setTitleText("以后不想见到他")
	button:setTitleColor(cc.c3b(255, 0, 0))
	button:setName("shieldBtn")
	button:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._chatSystem:getChat():setShieldSender(self._record:getRid())
			self:dispatch(ShowTipEvent({
				tip = "以后不再收到他的消息",
				duration = 0.35
			}))
		end
	end)
	button:setScale(2)
end

function PlayerInfoMediator:initRoleInfo()
	local name = self._bg:getChildByFullName("name")
	local group = self._bg:getChildByFullName("group_name")
	local combat = self._bg:getChildByFullName("fighting_bg.fighting_number")
	local rank = self._bg:getChildByFullName("rank_bg.rank_content")
	local slogan = self._bg:getChildByName("slogan")
	local playerIconBg = self._bg:getChildByName("icon_top")
	local level = self._bg:getChildByName("level")

	self._masterIconBg = self._bg:getChildByFullName("teamInfo.icon_bottom")

	local vip = self._bg:getChildByFullName("vip_num")

	vip:setVisible(false)

	local friendImg = self._bg:getChildByFullName("friendImg")

	friendImg:setVisible(false)
	rank:setString(self._record:getRank())
	name:setString(self._record:getName())

	local clubName = self._record:getClubName()

	if clubName == nil or clubName == "" then
		clubName = Strings:get("ARENA_NO_RANK")
	end

	group:setString(clubName)
	combat:setString(self._record:getCombat())
	level:setString("Lv." .. self._record:getLevel())
	slogan:setString(self._record:getSlogan())
	slogan:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998, 1))

	local isFriend = self._friendSystem:checkIsFriend(self._record:getRid())

	friendImg:setVisible(isFriend)
	self:setButtonStatus()

	local headIcon = IconFactory:createPlayerIcon({
		frameStyle = 3,
		clipType = 1,
		headFrameScale = 0.415,
		id = self._record:getHeadId(),
		size = playerIconBg:getContentSize(),
		headFrameId = self._record:getHeadFrame()
	})

	headIcon:setScale(1.15)
	headIcon:addTo(playerIconBg):center(playerIconBg:getContentSize())
end

function PlayerInfoMediator:initBaseInfo()
	local genderView = self._bg:getChildByName("gender")
	local birthdayView = self._bg:getChildByName("birthdayImg")
	local areaView = self._bg:getChildByName("areaImg")
	local playerBaseData = self._baseData

	if not playerBaseData then
		return
	end

	genderView:ignoreContentAdaptWithSize(true)

	if playerBaseData.gender == 1 then
		genderView:setVisible(true)
		genderView:loadTexture("sz_icon_nan.png", ccui.TextureResType.plistType)
	elseif playerBaseData.gender == 2 then
		genderView:setVisible(true)
		genderView:loadTexture("sz_icon_nv.png", ccui.TextureResType.plistType)
	else
		genderView:setVisible(false)
	end

	if playerBaseData.birthday and playerBaseData.birthday ~= "" then
		birthdayView:setVisible(true)

		local birthdayTab, constellationStr = self:parseTimeStr(playerBaseData.birthday)

		birthdayView:getChildByName("birthday"):setString(tostring(birthdayTab.month) .. Strings:get("Setting_UI_Month") .. tostring(birthdayTab.day) .. Strings:get("Setting_UI_Day") .. " " .. constellationStr)
	else
		birthdayView:setVisible(false)
	end

	if playerBaseData.city and playerBaseData.city ~= "" then
		areaView:setVisible(true)

		local parts = string.split(playerBaseData.city, "-")
		local areaInfo = ConfigReader:getRecordById("PlayerPlace", parts[1])
		local str1 = Strings:get(areaInfo.Provinces)
		local cityInfo = areaInfo.City[tonumber(parts[2])]
		local str2 = Strings:get(cityInfo)

		areaView:getChildByName("area"):setString(str1 .. " " .. str2)
	else
		areaView:setVisible(false)
	end

	if playerBaseData.tags and playerBaseData.tags ~= "" then
		local cjson = require("cjson.safe")
		local playerTags = cjson.decode(playerBaseData.tags)
		local playerTagsArray = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Tag", "content")
		local cloneCell = self:getView():getChildByName("cell")

		for k, v in ipairs(playerTags) do
			local _cell = cloneCell:clone()

			_cell:getChildByName("text"):setString(Strings:get(playerTagsArray[v]))
			_cell:addTo(self._bg)
			_cell:setPosition(cc.p(454 + 86 * (k - 1), 412))
		end
	end
end

function PlayerInfoMediator:initTeamInfo()
	local master = self._record:getMaster()

	if master and master[1] then
		local roleModel = self._masterSystem:getMasterLeadStageModel(master[1], self._record:getLeadStageId() or "")
		local info = {
			frameId = "bustframe4_5",
			id = roleModel
		}
		local masterIcon = IconFactory:createRoleIconSpriteNew(info)

		masterIcon:setAnchorPoint(cc.p(0, 0))
		masterIcon:setPosition(cc.p(0, 0))
		self._masterIconBg:addChild(masterIcon)

		local teamBg = self._bg:getChildByFullName("teamInfo")
		local text = teamBg:getChildByName("text")

		text:setTextColor(cc.c4b(164, 164, 164, 33.15))
		text:enableOutline(cc.c4b(255, 255, 255, 255), 2)

		local heros = self._record:getHeroes()

		for k, v in ipairs(heros) do
			local petBg = teamBg:getChildByName("pet_" .. k)
			local var_11_0 = {
				id = v[1],
				quality = tonumber(v[4]),
				rarity = tonumber(v[5])
			}

			var_11_0.awakenLevel = tonumber(v[7]) or 0

			local heroInfo = var_11_0

			if self._record:getRid() == self._player:getRid() then
				local heroModel = self._heroSystem:getHeroById(v[1])

				heroInfo.roleModel = heroModel:getModel()
			elseif v[6] and v[6] ~= "" then
				heroInfo.roleModel = ConfigReader:getDataByNameIdAndKey("Surface", v[6], "Model")
			end

			local petNode = IconFactory:createHeroLargeNotRemoveIcon(heroInfo, {
				hideLevel = true,
				hideStar = true,
				hideName = true
			})

			petNode:setScale(0.35)
			petNode:addTo(petBg):center(petBg:getContentSize())
			petNode:setPositionY(petNode:getPositionY() - 5)
		end

		local node = self._bg:getChildByFullName("teamInfo.node_leadStage")

		node:removeAllChildren()

		local icon = IconFactory:createLeadStageIconHor(self._record:getLeadStageId(), self._record:getLeadStageLevel())

		if icon then
			icon:addTo(node)
		end
	end
end

function PlayerInfoMediator:parseTimeStr(timeStr)
	local _tab = {}
	local _str
	local strTab = string.split(timeStr, "-")

	_tab.year = tonumber(strTab[1])
	_tab.month = tonumber(strTab[2])
	_tab.day = tonumber(strTab[3])

	local tag = 0
	local _compData = _tab.month * 100 + _tab.day

	for k, v in ipairs(constellationAge) do
		if v <= _compData then
			tag = tag + 1
		end
	end

	if tag == 0 then
		tag = 12
	end

	return _tab, (Strings:get(constellation[tag]))
end

function PlayerInfoMediator:onSendMsgClicked()
	if self._record.lastView ~= "friendChatView" then
		local var_13_0 = {
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

		var_13_0.close = self._record:getIsFriend() == 1 and self._record:getFamiliarity() or nil
		var_13_0.leadStageId = self._record:getLeadStageId()
		var_13_0.leadStageLevel = self._record:getLeadStageLevel()

		local data = var_13_0

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

function PlayerInfoMediator:onAddFriendClicked()
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

function PlayerInfoMediator:onOkClicked()
	self:close()
end

function PlayerInfoMediator:onRemoveFriendClicked()
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

function PlayerInfoMediator:onAddShieldClicked()
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

function PlayerInfoMediator:onRemoveShieldClicked()
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

function PlayerInfoMediator:requestBlockUser(shieldId, status)
	local function callback(data)
		if data then
			if self._chatSystem:getBlockUserStatus(shieldId) then
				local var_24_0 = Strings:get("Chat_ShieldSuccess_Tips")

				if not var_24_0 then
					var_24_0 = Strings:get("Chat_ShieldCancel_Tips")

					local tips = var_24_0

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

function PlayerInfoMediator:onClickBtn(sender)
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
	end
end

function PlayerInfoMediator:setButtonStatus()
	local chatBtn = self._bg:getChildByName("btn_chat")
	local btnOk = self._bg:getChildByName("btn_Ok")
	local friendBtn = self._bg:getChildByName("btn_add")

	chatBtn:setVisible(true)
	btnOk:setVisible(true)
	friendBtn:setVisible(true)

	if self._record:getRid() == self._player:getRid() then
		chatBtn:setVisible(false)
		btnOk:setVisible(false)
		self:setButton(self._btnAddNode, Strings:get("Common_button1"), Strings:get("UITitle_EN_Queding"), "ok")
		friendBtn:setPositionX(btnOk:getPositionX())

		return
	end

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
		self:setButton(self._btnChatNode, Strings:get("RANK_ADD_SHIELD"), Strings:get("RANK_ADD_SHIELD_EN"), "addShield")
		self:setButton(self._btnOkNode, Strings:get("RANK_REMOVE_FRIEND"), Strings:get("RANK_REMOVE_FRIEND_EN"), "removeFriend")
		self:setButton(self._btnAddNode, Strings:get("RANK_CHAT"), Strings:get("UIFRIEND_EN_Faxiaoxi"), "sendMsg")
	else
		self:setButton(self._btnChatNode, Strings:get("RANK_ADD_SHIELD"), Strings:get("RANK_ADD_SHIELD_EN"), "addShield")
		self:setButton(self._btnOkNode, Strings:get("RANK_CHAT"), Strings:get("UIFRIEND_EN_Faxiaoxi"), "sendMsg")
		self:setButton(self._btnAddNode, Strings:get("RANK_ADD_FRIEND"), Strings:get("UIFRIEND_EN_Jiahaoyou"), "addFriend")
	end
end

function PlayerInfoMediator:setButton(view, txt, txten, name)
	view:getChildByName("txt"):setString(txt)
	view:getChildByName("txten"):setString("")
	view:setName(name)
end
