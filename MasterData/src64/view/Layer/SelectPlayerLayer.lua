SelectPlayerLayer = class("SelectPlayerLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.AvatarSprite")

local account_manager = require("controller.account_manager")
local namegen = require("view.Layer.NameGen.namegen")
local level_manager = require("controller.level_manager")
local l2utils = require("controller.l2utils")
local model_data = require("data.model_data")
local var_0_5 = config._DEBUG and 0 or 1
local var_0_6 = false
local var_0_7 = {
	cc.p(320, 225),
	cc.p(300, 210),
	cc.p(340, 195)
}
local var_0_8 = {
	cc.c3b(255, 255, 255),
	cc.c3b(131, 131, 131),
	cc.c3b(148, 148, 148)
}
local var_0_9 = {
	3,
	2,
	1
}
local var_0_10 = {
	cc.p(320, 45),
	cc.p(320, -75)
}

function SelectPlayerLayer.create(arg_2_0)
	local var_2_0 = SelectPlayerLayer.new()

	var_2_0:init()

	return var_2_0
end

function SelectPlayerLayer:init()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SelectPlayerLayer.json" or "SelectPlayerLayer.ExportJson")

	self:addChild(self.rootLayer)

	self._touchlimit = false
	self.maxPlayerCount = math.max(6, account_manager:getAccountPlayerCount())

	self:initUI()
	self:initUserData()
	self:playInitAction()
end

function SelectPlayerLayer:playInitAction()
	local var_4_0 = cc.LayerColor:create(cc.c4b(0, 0, 0, 0), GameDisplay.width, GameDisplay.height)

	var_4_0:setAnchorPoint(cc.p(0, 0))
	var_4_0:setPosition(cc.p(0, 0))
	var_4_0:setName("mapcover")
	self:addChild(var_4_0, 100)
	var_4_0:runAction(cc.Sequence:create(cc.FadeIn:create(0.2), cc.DelayTime:create(0.1), cc.FadeOut:create(0.2), cc.RemoveSelf:create()))
	self.rootLayer:setVisible(false)
	self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.Show:create()))
	self.playerCardPool[1]:setPositionX(var_0_7[1].x + 60)
	self.playerCardPool[1]:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.MoveBy:create(0.2, cc.p(-80, 0)), cc.MoveBy:create(0.2, cc.p(20, 0))))
	self.playerCardPool[2]:setPositionX(var_0_7[2].x - 60)
	self.playerCardPool[2]:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.MoveBy:create(0.2, cc.p(60, 0))))
	self.playerCardPool[3]:setPositionX(var_0_7[3].x + 60)
	self.playerCardPool[3]:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.MoveBy:create(0.2, cc.p(-60, 0))))
end

function SelectPlayerLayer:initUI()
	self.panelPlayers = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_players")
	self.panelRole = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_role")

	local var_5_0 = cc.Sprite:create("mainScenebg/selectplayerbg.png")

	var_5_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self.rootLayer:addChild(var_5_0, -1)
	self:initPanelPlayers()
	self:initPanelRole()
	self:initButtonSure()

	local var_5_1 = cc.ParticleSystemQuad:create("effect/plist_createrole.plist")

	var_5_1:setPosition(cc.p(320, 0))
	self:addChild(var_5_1)
end

function SelectPlayerLayer:initUserData()
	local var_6_0 = account_manager:getUserPlayerIndex()

	if G_NEED_CREATE_NEW_PLAYER then
		for iter_6_0 = 1, 6 do
			if not account_manager.accountInfo.userinfo["playerid" .. iter_6_0] or account_manager.accountInfo.userinfo["playerid" .. iter_6_0] == 0 then
				var_6_0 = iter_6_0

				break
			end
		end

		G_NEED_CREATE_NEW_PLAYER = false
	end

	self.showingPos = var_6_0

	local var_6_1 = account_manager:getUserPlayeridByPos(var_6_0)

	self:updatePlayer(1, var_6_0)

	if not account_manager:isUserPlayerInfoCached(var_6_1) then
		self._touchlimit = true

		account_manager:getUserPlayerInfo(var_6_0, function(arg_7_0, arg_7_1)
			self._touchlimit = false

			if arg_7_0 == 1 then
				self:updatePlayerCard(1, {
					pos = var_6_0,
					playerid = var_6_1,
					player = arg_7_1
				})
			end

			self:reDrawRoleImage()
		end)
	else
		self:reDrawRoleImage()
	end

	self:updatePlayer(2, (var_6_0 + 1 > 4 or nil) and (var_6_0 - 3 or var_6_0 + 1))
	self:updatePlayer(3, (var_6_0 + 2 > 4 or nil) and (var_6_0 - 2 or var_6_0 + 2))
	self:redrawButtonSure()
end

function SelectPlayerLayer:initPanelPlayers()
	self.playerCardPool = {}
	self.showingCard = 1

	for iter_8_0 = 1, 3 do
		self.playerCardPool[iter_8_0] = self.panelPlayers:getChildByName("playercard" .. iter_8_0)

		self:initSlideEvent(self.playerCardPool[iter_8_0])
	end

	self:initNewPlayerPanel()
	self:initSwitchBtns()
end

local var_0_11 = cc.p(320, 265)
local var_0_12 = cc.p(115, 723)
local var_0_13 = cc.p(524, 428)
local var_0_14 = {
	"2100",
	"100",
	"1000",
	"2000",
	"200",
	"2200",
	"2100",
	"100",
	"1000",
	"2000",
	"200",
	"2200"
}
local var_0_15 = {
	9202101,
	9200101,
	9201001,
	9202001,
	9210001,
	9202201,
	9202101,
	9200101,
	9201001,
	9202001,
	9210001,
	9202201
}
local var_0_16 = {
	9202101,
	9200101,
	9201001,
	9202001,
	9210001,
	9202201,
	9202101,
	9200101,
	9201001,
	9202001,
	9210001,
	9202201
}

function SelectPlayerLayer:initPanelRole()
	local var_9_0 = self.panelRole:getChildByName("img_frame")

	var_9_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.height * 732 / 1136))
	var_9_0:setContentSize(cc.size(629, GameDisplay.height * 802 / 1136))
	self.panelRole:getChildByName("img_name"):setPosition(cc.p(524, GameDisplay.height * 428 / 1136))

	local var_9_1 = account_manager:getUserPlayerIndex()
	local var_9_2 = self.panelRole:getChildByName("img_order")

	var_9_2:loadTexture("SelectPlayerLayer/" .. var_9_1 .. ".png", var_0_5)
	var_9_2:setPosition(cc.p(522, GameDisplay.height * 1025 / 1136))

	local var_9_3 = cc.Sprite:create("role/" .. var_0_14[var_9_1] .. ".png")

	var_9_3:setName("role")
	var_9_3:setAnchorPoint(cc.p(0.5, 0))
	var_9_3:setScale(0.84)
	var_9_3:setPosition(cc.p(var_0_11.x, GameDisplay.height * var_0_11.y / 1136))
	self.panelRole:addChild(var_9_3, 2)

	local var_9_4 = cc.Sprite:create("role/" .. var_0_14[var_9_1] .. ".png")

	var_9_4:setName("shadow")
	var_9_4:setColor(cc.c3b(0, 0, 0))
	var_9_4:setAnchorPoint(cc.p(0.5, 0))
	var_9_4:setOpacity(127.5)
	var_9_4:setPosition(cc.p(var_9_3:getContentSize().width / 2 + 10, -10))
	var_9_3:addChild(var_9_4, -1)

	local var_9_5 = cc.Sprite:create("role/" .. var_0_14[var_9_1] .. ".png")

	var_9_5:setName("roleprojector")
	var_9_5:setPosition(var_0_12.x, GameDisplay.height * var_0_12.y / 1136)
	var_9_5:setOpacity(51)
	self.panelRole:addChild(var_9_5)
end

local function var_0_17(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7, arg_10_8)
	local var_10_0

	if config._DEBUG then
		var_10_0 = cc.Scale9Sprite:create("public/panelbg/editBoxBG.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/panelbg/editBoxBG.png")
	end

	local var_10_1 = ccui.Layout:create()

	var_10_1:setName("cutPanel")
	var_10_1:setContentSize(arg_10_7)
	var_10_1:setAnchorPoint(cc.p(0, 0.5))
	var_10_1:setPosition(arg_10_8)
	var_10_1:setClippingEnabled(true)
	arg_10_1:addChild(var_10_1, 22)

	local var_10_2 = cc.EditBox:create(arg_10_7, var_10_0)

	var_10_2:setName(arg_10_0)
	var_10_2:setPosition(0, 0)
	var_10_2:setAnchorPoint(cc.p(0, 0))
	var_10_2:setFontName(arg_10_3)
	var_10_2:setPlaceholderFont(arg_10_3, arg_10_2)
	var_10_2:setFontSize(arg_10_2)
	var_10_2:setFontColor(cc.c3b(255, 255, 255))
	var_10_2:setPlaceHolder(arg_10_4)
	var_10_2:setPlaceholderFontColor(cc.c3b(231, 237, 249))
	var_10_2:setMaxLength(arg_10_5)
	var_10_2:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	var_10_2:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
	var_10_2:setInputFlag(arg_10_6)

	if var_0_6 then
		var_10_2:setEnabled(false)
	end

	var_10_1:addChild(var_10_2, 5)

	return var_10_2
end

function SelectPlayerLayer:initNewPlayerPanel()
	for iter_11_0 = 1, 3 do
		local var_11_0 = self.playerCardPool[iter_11_0]:getChildByName("panel_newplayer")

		var_0_17("inputname", var_11_0, 22, "fonts/number.ttf", L_NAME_LENGTH_LIMIT, 20, cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD, cc.size(200, 30), cc.p(var_11_0:getContentSize().width / 2 - 195, -72))
		var_11_0:getChildByName("btn_random"):addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			arg_12_0:getParent():getChildByName("cutPanel"):getChildByName("inputname"):setText((namegen:GenerateName(math.random(1, 2) == 1)))
		end)
		var_11_0:getChildByName("label_info"):setString(L_LOGIN_PLAYER.congratulation)
	end
end

function SelectPlayerLayer:updatePlayer(arg_13_1, arg_13_2)
	local var_13_0 = account_manager:getUserPlayeridByPos(arg_13_2)
	local var_13_1 = {
		pos = arg_13_2
	}

	if var_13_0 and var_13_0 ~= 0 then
		var_13_1.playerid = var_13_0
		var_13_1.player = account_manager:getUserPlayerInfoByPlayerid(var_13_0)
	end

	self:updatePlayerCard(arg_13_1, var_13_1)
end

function SelectPlayerLayer:updatePlayerCard(arg_14_1, arg_14_2)
	if arg_14_2.playerid then
		self:updatePlayerCardWithPlayer(arg_14_1, arg_14_2)
	else
		self:updatePlayerCardWithOutPlayer(arg_14_1, arg_14_2)
	end
end

local var_0_18 = "SelectPlayerLayer/region1.png"
local var_0_19 = "SelectPlayerLayer/region2.png"
local var_0_20 = "SelectPlayerLayer/region3.png"

local function var_0_22(arg_16_0)
	local var_16_0, var_16_1, var_16_2 = arg_16_0:match("(%d+)-(%d+)-(%d+)")

	return string.format("%s(%s)", level_manager:getModeName(tonumber(var_16_0)), level_manager:getChapterName(tonumber(var_16_0), tonumber(var_16_1)))
end

function SelectPlayerLayer:updatePlayerCardWithPlayer(arg_17_1, arg_17_2)
	self.playerCardPool[arg_17_1]:getChildByName("panel_playerinfo"):setVisible(true)
	self.playerCardPool[arg_17_1]:getChildByName("panel_newplayer"):setVisible(false)
	self.playerCardPool[arg_17_1]:getChildByName("panel_lock"):setVisible(false)
	self.playerCardPool[arg_17_1]:loadTexture(var_0_18, var_0_5)

	local var_17_0 = self.playerCardPool[arg_17_1]:getChildByName("panel_playerinfo")

	if arg_17_2.player then
		self:updatePlayerHead(arg_17_2.player.head, arg_17_2.pos, var_17_0)
		var_17_0:getChildByName("img_head"):setVisible(false)
		var_17_0:getChildByName("label_name"):setString(arg_17_2.player.name)
		var_17_0:getChildByName("label_name"):setVisible(true)
		var_17_0:getChildByName("label_level"):setString(arg_17_2.player.grade)
		var_17_0:getChildByName("label_level"):setVisible(true)
		var_17_0:getChildByName("label_city"):setString(var_0_22(arg_17_2.player.level))
		var_17_0:getChildByName("label_city"):setVisible(true)
		var_17_0:getChildByName("label_playerid"):setString(arg_17_2.playerid)
		var_17_0:getChildByName("label_playerid"):setScale(0.86)
		var_17_0:getChildByName("label_class"):setString(PlAYER_CLASS[arg_17_2.player.class])
		var_17_0:getChildByName("label_class"):setVisible(true)
		var_17_0:getChildByName("label_rolenum"):setString(arg_17_2.player.rolenum)
		var_17_0:getChildByName("label_rolenum"):setVisible(true)
	else
		var_17_0:getChildByName("img_head"):setVisible(false)
		var_17_0:getChildByName("label_name"):setVisible(false)
		var_17_0:getChildByName("label_level"):setVisible(false)
		var_17_0:getChildByName("label_city"):setVisible(false)
		var_17_0:getChildByName("label_playerid"):setString(arg_17_2.playerid)
		var_17_0:getChildByName("label_playerid"):setScale(0.8)
		var_17_0:getChildByName("label_class"):setVisible(false)
		var_17_0:getChildByName("label_rolenum"):setVisible(false)
	end
end

function SelectPlayerLayer.updatePlayerHead(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = tonumber(arg_18_1 or var_0_15[arg_18_2])
	local var_18_1 = arg_18_3:getChildByName("avatar")
	local var_18_2 = arg_18_3:getChildByName("img_head")

	if not var_18_1 then
		var_18_1 = AvatarSprite:create(var_18_0)

		var_18_1:setPosition(cc.p(var_18_2:getPositionX() - 80, var_18_2:getPositionY() - 70))
		var_18_1:setName("avatar")
		var_18_1:setScale(0.84)
		arg_18_3:addChild(var_18_1)
	else
		var_18_1:switchShowAvatar(var_18_0)
	end
end

function SelectPlayerLayer:updatePlayerCardWithOutPlayer(arg_19_1, arg_19_2)
	if account_manager:canCreateNewPlayer(arg_19_2.pos) then
		self:updatePlayerCardWithNew(arg_19_1, arg_19_2)
	else
		self:updatePlayerCardWithLock(arg_19_1, arg_19_2)
	end
end

function SelectPlayerLayer:updatePlayerCardWithNew(arg_20_1, arg_20_2)
	local var_20_0 = self.playerCardPool[arg_20_1]

	self.playerCardPool[arg_20_1]:getChildByName("panel_playerinfo"):setVisible(false)
	var_20_0:getChildByName("panel_newplayer"):setVisible(true)
	var_20_0:getChildByName("panel_lock"):setVisible(false)
	var_20_0:loadTexture(var_0_19, var_0_5)
	var_20_0:getChildByName("panel_newplayer"):getChildByName("cutPanel"):getChildByName("inputname"):setText((namegen:GenerateName(math.random(1, 2) == 1)))
end

local var_0_23 = {
	0,
	0,
	0,
	0
}

function SelectPlayerLayer:updatePlayerCardWithLock(arg_21_1, arg_21_2)
	self.playerCardPool[arg_21_1]:getChildByName("panel_playerinfo"):setVisible(false)
	self.playerCardPool[arg_21_1]:getChildByName("panel_newplayer"):setVisible(false)
	self.playerCardPool[arg_21_1]:getChildByName("panel_lock"):setVisible(true)
	self.playerCardPool[arg_21_1]:loadTexture(var_0_20, var_0_5)

	local var_21_0 = arg_21_2.pos or 4
	local var_21_1 = self.playerCardPool[arg_21_1]:getChildByName("panel_lock")
	local var_21_2 = var_21_1:getChildByName("label_info")

	var_21_2:setString(string.format(L_LOGIN_PLAYER.unlock, PlAYER_CLASS[var_0_23[var_21_0] / 100]))

	local var_21_3 = var_21_1:getChildByName("img_lock")

	var_21_3:setPositionX(var_21_2:getPositionX() - var_21_2:getContentSize().width / 2 - var_21_3:getContentSize().width / 2)
end

function SelectPlayerLayer:initSwitchBtns()
	self.panelPlayers:getChildByName("btn_left"):addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._touchlimit then
			return
		end

		self._touchlimit = true

		self:tryLoadRightCardAndSwitchLeft()
	end)
	self.panelPlayers:getChildByName("btn_right"):addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._touchlimit then
			return
		end

		self._touchlimit = true

		self:tryLoadLeftCardAndSwitchRight()
	end)
end

function SelectPlayerLayer.initSlideEvent(arg_25_0, arg_25_1)
	arg_25_1:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_25_0._touchlimit then
			return
		end

		local var_26_0 = arg_26_0:getTouchBeganPosition().x - arg_26_0:getTouchEndPosition().x

		if var_26_0 > 250 then
			arg_25_0._touchlimit = true

			arg_25_0:tryLoadRightCardAndSwitchLeft()
		elseif var_26_0 < -250 then
			arg_25_0._touchlimit = true

			arg_25_0:tryLoadLeftCardAndSwitchRight()
		end
	end)
	arg_25_1:getChildByName("panel_playerinfo"):setTouchEnabled(false)
	arg_25_1:getChildByName("panel_newplayer"):setTouchEnabled(false)
	arg_25_1:getChildByName("panel_lock"):setTouchEnabled(false)
end

function SelectPlayerLayer:tryLoadRightCardAndSwitchLeft()
	local var_27_0

	if self.showingCard + 2 > 3 then
		var_27_0 = self.showingCard - 1 or self.showingCard + 2

		local var_27_1

		if self.showingPos + (self.maxPlayerCount - 1) > self.maxPlayerCount then
			var_27_1 = self.showingPos - 1 or self.showingPos + (self.maxPlayerCount - 1)
		end
	end

	local var_27_2 = account_manager:getUserPlayeridByPos(var_27_1)

	if var_27_2 and not account_manager:isUserPlayerInfoCached(var_27_2) then
		account_manager:getUserPlayerInfo(var_27_1, function(arg_28_0, arg_28_1)
			if arg_28_0 == 1 then
				self:updatePlayerCard(var_27_0, {
					pos = var_27_1,
					playerid = var_27_2,
					player = arg_28_1
				})
			else
				self:updatePlayer(var_27_0, var_27_1)
			end

			self:switchLeftCard()
		end)
	else
		self:updatePlayer(var_27_0, var_27_1)
		self:switchLeftCard()
	end
end

function SelectPlayerLayer:tryLoadLeftCardAndSwitchRight()
	local var_29_0

	if self.showingCard + 1 > 3 then
		var_29_0 = self.showingCard - 2 or self.showingCard + 1

		local var_29_1

		if self.showingPos + 1 > self.maxPlayerCount then
			var_29_1 = self.showingPos - (self.maxPlayerCount - 1) or self.showingPos + 1
		end
	end

	local var_29_2 = account_manager:getUserPlayeridByPos(var_29_1)

	if var_29_2 and not account_manager:isUserPlayerInfoCached(var_29_2) then
		account_manager:getUserPlayerInfo(var_29_1, function(arg_30_0, arg_30_1)
			if arg_30_0 == 1 then
				self:updatePlayerCard(var_29_0, {
					pos = var_29_1,
					playerid = var_29_2,
					player = arg_30_1
				})
			else
				self:updatePlayer(var_29_0, var_29_1)
			end

			self:switchRightCard()
		end)
	else
		self:updatePlayer(var_29_0, var_29_1)
		self:switchRightCard()
	end
end

function SelectPlayerLayer:switchRightCard()
	self._touchlimit = true

	local var_31_0 = {
		self.playerCardPool[self.showingCard]
	}

	var_31_0[2] = self.playerCardPool[(self.showingCard + 1 > 3 or nil) and (self.showingCard - 2 or self.showingCard + 1)]
	var_31_0[3] = self.playerCardPool[(self.showingCard + 2 > 3 or nil) and (self.showingCard - 1 or self.showingCard + 2)]

	local var_31_1 = {
		function()
			var_31_0[1]:setPosition(var_0_7[3])
			var_31_0[1]:setOpacity(255)
			var_31_0[1]:setColor(var_0_8[3])
			var_31_0[1]:setLocalZOrder(var_0_9[3])
		end,
		function()
			var_31_0[2]:setColor(var_0_8[1])
			var_31_0[2]:setLocalZOrder(var_0_9[1])

			self._touchlimit = false

			if self.showingCard + 1 > 3 then
				self.showingCard = self.showingCard - 2 or self.showingCard + 1
			end

			if self.showingPos + 1 > self.maxPlayerCount then
				self.showingPos = self.showingPos - (self.maxPlayerCount - 1) or self.showingPos + 1
			end

			local var_33_0

			if self.showingCard + 2 > 3 then
				var_33_0 = self.showingCard - 1 or self.showingCard + 2

				local var_33_1

				if self.showingPos + 2 > self.maxPlayerCount then
					var_33_1 = self.showingPos - (self.maxPlayerCount - 2) or self.showingPos + 2
				end
			end

			self:updatePlayer(var_33_0, var_33_1)
		end,
		function()
			var_31_0[3]:setColor(var_0_8[2])
			var_31_0[3]:setLocalZOrder(var_0_9[2])
		end
	}
	local var_31_2 = {
		cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(300, 0)), cc.FadeOut:create(0.2)), cc.CallFunc:create(var_31_1[1])),
		cc.Sequence:create(cc.DelayTime:create(0.2), cc.MoveTo:create(0.2, var_0_7[1]), cc.CallFunc:create(var_31_1[2])),
		cc.Sequence:create(cc.DelayTime:create(0.2), cc.MoveTo:create(0.2, var_0_7[2]), cc.CallFunc:create(var_31_1[3]))
	}

	for iter_31_0 = 1, 3 do
		var_31_0[iter_31_0]:runAction(var_31_2[iter_31_0])
	end

	self:btnSureOnSwitchRight()
	self:switchRoleImage("right")
end

function SelectPlayerLayer:switchLeftCard()
	self._touchlimit = true

	local var_35_0 = {
		self.playerCardPool[self.showingCard]
	}

	var_35_0[2] = self.playerCardPool[(self.showingCard + 1 > 3 or nil) and (self.showingCard - 2 or self.showingCard + 1)]
	var_35_0[3] = self.playerCardPool[(self.showingCard + 2 > 3 or nil) and (self.showingCard - 1 or self.showingCard + 2)]

	local var_35_1 = {
		function()
			var_35_0[1]:setColor(var_0_8[2])
			var_35_0[1]:setLocalZOrder(var_0_9[2])
		end,
		function()
			var_35_0[2]:setColor(var_0_8[3])
			var_35_0[2]:setLocalZOrder(var_0_9[3])
		end,
		function()
			var_35_0[3]:setColor(var_0_8[1])
			var_35_0[3]:setLocalZOrder(var_0_9[1])
			var_35_0[3]:setPosition(cc.p(var_0_7[1].x + 300, var_0_7[1].y))

			if self.showingCard + 2 > 3 then
				self.showingCard = self.showingCard - 1 or self.showingCard + 2
			end
		end,
		function()
			self._touchlimit = false

			if self.showingPos + (self.maxPlayerCount - 1) > self.maxPlayerCount then
				self.showingPos = self.showingPos - 1 or self.showingPos + (self.maxPlayerCount - 1)
			end
		end
	}
	local var_35_2 = {
		cc.Sequence:create(cc.MoveTo:create(0.2, var_0_7[2]), cc.CallFunc:create(var_35_1[1])),
		cc.Sequence:create(cc.MoveTo:create(0.2, var_0_7[3]), cc.CallFunc:create(var_35_1[2])),
		cc.Sequence:create(cc.Hide:create(), cc.DelayTime:create(0.2), cc.CallFunc:create(var_35_1[3]), cc.Show:create(), cc.MoveTo:create(0.2, var_0_7[1]), cc.CallFunc:create(var_35_1[4]))
	}

	for iter_35_0 = 1, 3 do
		var_35_0[iter_35_0]:runAction(var_35_2[iter_35_0])
	end

	self:btnSureOnSwitchLeft()
	self:switchRoleImage("left")
end

function SelectPlayerLayer:btnSureOnSwitchLeft()
	local var_40_0

	if self.showingPos + (self.maxPlayerCount - 1) > self.maxPlayerCount then
		var_40_0 = self.showingPos - 1 or self.showingPos + (self.maxPlayerCount - 1)
	end

	local var_40_1 = self.panelPlayers:getChildByName("btn_sure")

	if account_manager:getUserPlayeridByPos(var_40_0) then
		var_40_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, var_0_10[2]), cc.CallFunc:create(function()
			var_40_1:getChildByName("Label_5"):setString(L_LOGIN_PLAYER.button_in)
		end), cc.MoveTo:create(0.2, var_0_10[1])))
	elseif account_manager:canCreateNewPlayer(var_40_0) then
		var_40_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, var_0_10[2]), cc.CallFunc:create(function()
			var_40_1:getChildByName("Label_5"):setString(L_LOGIN_PLAYER.button_in)
		end), cc.MoveTo:create(0.2, var_0_10[1])))
	else
		var_40_1:runAction(cc.MoveTo:create(0.2, var_0_10[2]))
	end
end

function SelectPlayerLayer:btnSureOnSwitchRight()
	local var_43_0

	if self.showingPos + 1 > self.maxPlayerCount then
		var_43_0 = self.showingPos - (self.maxPlayerCount - 1) or self.showingPos + 1
	end

	local var_43_1 = self.panelPlayers:getChildByName("btn_sure")

	if account_manager:getUserPlayeridByPos(var_43_0) then
		var_43_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, var_0_10[2]), cc.CallFunc:create(function()
			var_43_1:getChildByName("Label_5"):setString(L_LOGIN_PLAYER.button_in)
		end), cc.MoveTo:create(0.2, var_0_10[1])))
	elseif account_manager:canCreateNewPlayer(var_43_0) then
		var_43_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, var_0_10[2]), cc.CallFunc:create(function()
			var_43_1:getChildByName("Label_5"):setString(L_LOGIN_PLAYER.button_in)
		end), cc.MoveTo:create(0.2, var_0_10[1])))
	else
		var_43_1:runAction(cc.MoveTo:create(0.2, var_0_10[2]))
	end
end

function SelectPlayerLayer:initButtonSure()
	self.panelPlayers:getChildByName("btn_sure"):addTouchEventListener(function(arg_47_0, arg_47_1)
		if arg_47_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self._touchlimit then
			return
		end

		if account_manager:getUserPlayeridByPos(self.showingPos) then
			self:onTouchEnterGame()
		elseif account_manager:canCreateNewPlayer(self.showingPos) then
			self:onTouchAddPlayer()
		end
	end)
end

function SelectPlayerLayer:redrawButtonSure()
	local var_48_0 = self.panelPlayers:getChildByName("btn_sure")

	if account_manager:getUserPlayeridByPos(self.showingPos) then
		var_48_0:setPosition(var_0_10[1])
		var_48_0:getChildByName("Label_5"):setString(L_LOGIN_PLAYER.button_in)
	elseif account_manager:canCreateNewPlayer(self.showingPos) then
		var_48_0:setPosition(var_0_10[1])
		var_48_0:getChildByName("Label_5"):setString(L_LOGIN_PLAYER.button_in)
	else
		var_48_0:setPosition(var_0_10[2])
	end
end

function SelectPlayerLayer:onTouchEnterGame()
	local function var_49_0(arg_50_0)
		AnalyticManager.entergame(account_manager:collectPlayerInfoOnLogin(arg_50_0))
		require("view.Scene.LoadingScene")
		cc.Director:getInstance():replaceScene(LoadingScene:createScene(arg_50_0))
	end

	self._touchlimit = true

	account_manager:login(self.showingPos, function(arg_51_0, arg_51_1)
		if arg_51_0 == 1 then
			var_49_0(arg_51_1)
		else
			self._touchlimit = false

			if arg_51_1 then
				self:showErrMsg(arg_51_1)
			end
		end
	end)
end

function SelectPlayerLayer:onTouchAddPlayer()
	local var_52_0 = self.playerCardPool[self.showingCard]:getChildByName("panel_newplayer"):getChildByName("cutPanel"):getChildByName("inputname"):getText()

	print("AddPlayer: ", self.showingPos, var_52_0)

	for iter_52_0 = 1, subStringGetTotalIndex(var_52_0) do
		if (string.byte(var_52_0, iter_52_0) > 57 or string.byte(var_52_0, iter_52_0) < 48) and (string.byte(var_52_0, iter_52_0) > 122 or string.byte(var_52_0, iter_52_0) < 97) and (string.byte(var_52_0, iter_52_0) > 90 or string.byte(var_52_0, iter_52_0) < 65) and string.byte(var_52_0, iter_52_0) < 127 then
			global_ShowBlockWords(L_NICKNAME_WARNING.Nickname_illegal)

			return
		end
	end

	if string.find(var_52_0, "#") then
		var_52_0 = string.gsub(var_52_0, "#", "")
	end

	if not self:checkmsg(var_52_0) then
		global_ShowBlockWords(L_NICKNAME_WARNING.Nickname_illegal)

		return
	end

	if subStringGetTotalIndex(var_52_0) > 7 then
		global_ShowBlockWords(L_LOGIN_PLAYER.name_too_long)

		return
	end

	if subStringGetTotalIndex(var_52_0) == 0 then
		var_52_0 = nil
	end

	local function var_52_1(arg_53_0)
		AnalyticManager.entergame(account_manager:collectPlayerInfoOnLogin(arg_53_0))

		local playermodel = require("model.playermodel")

		playermodel:setInitShowGirl(var_0_14[self.showingPos] or "2100")
		playermodel:setInitHeadSoul(var_0_16[self.showingPos] or 9202201)
		require("view.Scene.LoadingScene")
		cc.Director:getInstance():replaceScene(LoadingScene:createScene(arg_53_0))
	end

	local function var_52_2(arg_54_0, arg_54_1)
		if arg_54_0 == 1 then
			var_52_1(arg_54_1)
		else
			self._touchlimit = false

			if arg_54_1 then
				self:showErrMsg(arg_54_1)

				local var_54_0 = account_manager:getUserPlayeridByPos(self.showingPos)

				if var_54_0 and account_manager:isUserPlayerInfoCached(var_54_0) then
					self:updatePlayerCard(self.showingCard, {
						pos = self.showingPos,
						playerid = var_54_0,
						player = account_manager:getUserPlayerInfoByPlayerid(var_54_0)
					})
				end
			end
		end
	end

	self._touchlimit = true

	AnalyticManager.create_new_player({
		return_back_create = G_NEED_CREATE_NEW_PLAYER and true or false
	})
	account_manager:addAndLogin(self.showingPos, var_52_0, var_52_2)
end

function SelectPlayerLayer.checkmsg(arg_55_0, arg_55_1)
	if SensitiveChecker then
		return SensitiveChecker.censorStr(arg_55_1) ~= nil
	else
		return global_is_words_pass_against(arg_55_1)
	end
end

function SelectPlayerLayer.showErrMsg(arg_56_0, arg_56_1)
	local var_56_0 = cc.Director:getInstance()
	local var_56_1 = var_56_0:getRunningScene()
	local var_56_2 = ccui.ImageView:create("public/panelbg/bg_pop_small.png", config._DEBUG and 0 or 1)

	var_56_2.setPosition(var_56_0, 320, GameDisplay.height / 2)
	var_56_1:addChild(var_56_2, 999)

	local var_56_3 = cc.Label:createWithTTF(arg_56_1, "fonts/number.ttf", 27)

	var_56_3:setPosition(var_56_2:getContentSize().width / 2, var_56_2:getContentSize().height / 2)
	var_56_2:addChild(var_56_3)

	local var_56_4 = ccui.Button:create("public/button/public_button_orange_long.png", nil, "public/button/public_button_orange_long.png", config._DEBUG and 0 or 1)

	var_56_4:setPosition(var_56_2:getContentSize().width / 2, -var_56_4:getContentSize().height / 2 - 10)
	var_56_2:addChild(var_56_4)
	var_56_4:addTouchEventListener(function(arg_57_0, arg_57_1)
		if arg_57_1 ~= ccui.TouchEventType.ended then
			return false
		end

		var_56_2:runAction(cc.RemoveSelf:create())
	end)

	local var_56_5 = cc.Label:createWithTTF(L_ITEM_SURE_BTN, "fonts/newkj.ttf", 28)

	var_56_5:setColor(cc.c3b(0, 0, 0))
	var_56_5:setPosition(var_56_4:getContentSize().width / 2 - 5, var_56_4:getContentSize().height / 2 - 5)
	var_56_4:addChild(var_56_5)
end

function SelectPlayerLayer:reDrawRoleImage()
	local var_58_0 = var_0_14[self.showingPos] or "2100"
	local var_58_1 = account_manager:getUserPlayeridByPos(self.showingPos)

	if var_58_1 then
		local var_58_2 = account_manager:getUserPlayerInfoByPlayerid(var_58_1)

		if var_58_2 then
			var_58_0 = var_58_2.showgirl
		end
	end

	local var_58_3 = self.panelRole:getChildByName("role")

	var_58_3:setTexture("role/" .. model_data[var_58_0].role_image .. ".png")

	local var_58_4 = model_data[var_58_0].selectplayer_offset_x or 0
	local var_58_5 = model_data[var_58_0].selectplayer_offset_y or 0

	hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)
	hx_print(string.format("使用偏移modelData[%s].selectplayer_offset_x, modelData[%s].selectplayer_offset_y (%s,%s)", var_58_0, var_58_0, var_58_4, var_58_5), CONSOLE_COLOR_GREEN)
	hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)

	local var_58_6 = var_58_3:getChildByName("shadow")
	local var_58_7 = self.panelRole:getChildByName("roleprojector")

	if model_data[var_58_0].is_big_role_image then
		var_58_3:setScale(1)
		var_58_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_58_3:setPosition(cc.p(GameDisplay.cx + var_58_4, GameDisplay.cy + var_58_5))
		var_58_6:setVisible(false)
		var_58_7:setVisible(false)
	else
		var_58_3:setAnchorPoint(cc.p(0.5, 0))
		var_58_3:setScale(0.84)
		var_58_3:setPosition(cc.p(var_0_11.x + var_58_4, GameDisplay.height * var_0_11.y / 1136 + var_58_5))
		var_58_6:setVisible(true)
		var_58_6:setTexture("role/" .. model_data[var_58_0].role_image .. ".png")
		var_58_6:setPosition(cc.p(var_58_3:getContentSize().width / 2 + 10, -10))
		var_58_7:setVisible(true)
		var_58_7:setTexture("role/" .. model_data[var_58_0].role_image .. ".png")
	end

	self.panelRole:getChildByName("img_name"):getChildByName("label_name"):setString(model_data[var_58_0].name_Q or model_data[var_58_0].main_name)
	self.panelRole:getChildByName("img_order"):loadTexture("SelectPlayerLayer/" .. self.showingPos .. ".png", var_0_5)
end

function SelectPlayerLayer:switchRoleImage(arg_59_1)
	local var_59_0 = arg_59_1 == "left" and (self.showingPos + (self.maxPlayerCount - 1) > self.maxPlayerCount and self.showingPos - 1 or self.showingPos + (self.maxPlayerCount - 1)) or self.showingPos + 1 > self.maxPlayerCount and self.showingPos - (self.maxPlayerCount - 1) or self.showingPos + 1
	local var_59_1 = var_0_14[var_59_0] or "2100"
	local var_59_2 = account_manager:getUserPlayeridByPos(var_59_0)

	if var_59_2 then
		local var_59_3 = account_manager:getUserPlayerInfoByPlayerid(var_59_2)

		if var_59_3 then
			var_59_1 = var_59_3.showgirl
		end
	end

	local var_59_4 = self.panelRole:getChildByName("role")
	local var_59_5 = self.panelRole:getChildByName("roleprojector")
	local var_59_6 = self.panelRole:getChildByName("img_name")
	local var_59_7 = self.panelRole:getChildByName("img_order")

	var_59_6:runAction(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(var_0_13.x + GameDisplay.width, GameDisplay.height * var_0_13.y / 1136)), cc.CallFunc:create(function()
		var_59_6:getChildByName("label_name"):setString(model_data[var_59_1].name_Q or model_data[var_59_1].main_name)
	end), cc.MoveTo:create(0.2, cc.p(var_0_13.x, GameDisplay.height * var_0_13.y / 1136))))
	var_59_7:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		var_59_7:loadTexture("SelectPlayerLayer/" .. var_59_0 .. ".png", var_0_5)
	end), cc.FadeIn:create(0.2)))
	l2utils:removeNodeShake(var_59_4)
	l2utils:shakeNode(var_59_4, {
		scanlinethreshold = 0.025,
		scanlinedrift = 25,
		waitframe = 0,
		driftpixel = 0,
		driftfac = 0.1,
		shakeframe = 30
	})
	var_59_4:setName("role_to_remove")
	var_59_4:stopAllActions()
	var_59_4:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.FadeOut:create(0.2), cc.RemoveSelf:create()))

	if var_59_4:getChildByName("shadow") then
		var_59_4:getChildByName("shadow"):setVisible(false)
	end

	local var_59_8 = cc.Sprite:create("role/" .. model_data[var_59_1].role_image .. ".png")

	var_59_8:setName("role")
	var_59_8:setVisible(false)
	self.panelRole:addChild(var_59_8, 2)

	if model_data[var_59_1].is_big_role_image then
		var_59_5:setVisible(false)
		var_59_8:setAnchorPoint(cc.p(0.5, 0.5))
		var_59_8:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	else
		var_59_5:setVisible(false)
		var_59_5:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
			var_59_5:setTexture("role/" .. model_data[var_59_1].role_image .. ".png")
		end), cc.Show:create()))

		local var_59_9 = model_data[var_59_1].selectplayer_offset_x or 0
		local var_59_10 = model_data[var_59_1].selectplayer_offset_y or 0

		var_59_8:setAnchorPoint(cc.p(0.5, 0))
		var_59_8:setScale(0.84)
		var_59_8:setPosition(cc.p(var_0_11.x + var_59_9, GameDisplay.height * var_0_11.y / 1136 + var_59_10))

		local var_59_11 = cc.Sprite:create("role/" .. model_data[var_59_1].role_image .. ".png")

		var_59_11:setName("shadow")
		var_59_11:setColor(cc.c3b(0, 0, 0))
		var_59_11:setAnchorPoint(cc.p(0.5, 0))
		var_59_11:setOpacity(127.5)
		var_59_11:setPosition(cc.p(var_59_8:getContentSize().width / 2 + 10, -10))
		var_59_8:addChild(var_59_11, -1)
	end

	l2utils:shakeNode(var_59_8, {
		scanlinethreshold = 0.025,
		scanlinedrift = 25,
		waitframe = 12,
		restoreframe = 30,
		driftpixel = 0,
		shakeframe = 0,
		driftfac = 0.1
	})
	var_59_8:setOpacity(0)
	var_59_8:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.Show:create(), cc.FadeIn:create(0.2), cc.DelayTime:create(0.3), cc.CallFunc:create(function()
		l2utils:removeNodeShake(var_59_8)
	end)))
end
