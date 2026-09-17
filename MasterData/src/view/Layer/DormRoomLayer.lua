DormRoomLayer = class("DormRoomLayer", function()
	return cc.Layer:create()
end)

local weapon_manager = require("controller.weapon_manager")
local item_manager = require("controller.item_manager")
local role_conversation_data = require("data.role_conversation_data")
local conversation_class_data = require("data.conversation_class_data")
local conversation_type_data = require("data.conversation_type_data")
local favorconversation_data = require("data.favorconversation_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local favor_data = require("data.favor_data")
local item_data = require("data.item_data")
local shop_data = require("data.shop_data")
local drop_data = require("data.drop_data")
local drop_manager = require("controller.drop_manager")
local ShowGirlLayer = require("view.Layer.ShowGirlLayer")
local ItemSprite = require("view.Sprite.ItemSprite")
local activity_manager = require("controller.activity_manager")
local goodwell_manager = require("controller.goodwell_manager")
local dormitory_manager = require("controller.dormitory_manager")
local audio_manager = require("controller.audio_manager")
local shop_manager = require("controller.shop_manager")
local playermodel = require("model.playermodel")
local var_0_21 = config._DEBUG and 0 or 1
local discount_manager = require("controller.discount_manager")
local var_0_23 = {}
local var_0_33 = {}
local var_0_34 = {
	"mainScenebg/dorm.jpg",
	"mainScenebg/dorm_dusk.jpg",
	"mainScenebg/dorm_night.jpg"
}
local var_0_35 = {
	PLOT = 4,
	NOUSED = 8,
	BUILDED = 12,
	BUILDING = 11,
	EXPLORING = 5,
	NEXTLOCK = 10,
	LOCK = 1,
	ATHOME = 3,
	LIVE = 7,
	TRAVELBACK = 6,
	UNLOCK = 2
}
local var_0_36 = {
	"Dormitory/favor_thing/tag_1.png",
	"Dormitory/favor_thing/tag_2.png",
	"Dormitory/favor_thing/tag_3.png"
}

setmetatable(var_0_36, {
	__index = function()
		return "Dormitory/favor_thing/tag_3.png"
	end
})

local var_0_37 = "Dormitory/favor_thing/lock_tag.png"
local var_0_38 = "Dormitory/favor_thing/complete_tag.png"
local var_0_39

function DormRoomLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = DormRoomLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function DormRoomLayer.getInstance()
	return var_0_39
end

function DormRoomLayer:init(arg_5_1)
	var_0_39 = self
	self.roomorder = arg_5_1.roomorder
	self.roomindex = arg_5_1.index

	local var_5_0 = DormitoryLayer.getInstance()

	if var_5_0 and var_5_0.rooms and var_5_0.rooms[self.roomorder] and var_5_0.rooms[self.roomorder].index then
		self.roomindex = var_5_0.rooms[self.roomorder].index
	end

	self.soulid = arg_5_1.soulid
	self.isout = arg_5_1.isout
	self.servant = major_factor_data[self.soulid].servant
	self.modelid = dormitory_manager:getSoulDressModelid(self.soulid) or major_factor_data[self.soulid].model
	self.updateDressCallback = arg_5_1.updateDressCallback
	self.exitCallback = arg_5_1.exitCallback

	local var_5_1 = self.modelid

	self.dialogTable = {}
	self.lineNum = 1
	self.iscanswitch = true
	self.instance = self

	local var_5_2 = ccui.Layout:create()

	var_5_2:setContentSize(cc.size(640, GameDisplay.height))
	var_5_2:setTouchEnabled(false)
	self:addChild(var_5_2, -1)

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(cc.size(640, GameDisplay.height))
	self.rootLayer:setTouchEnabled(false)
	self:addChild(self.rootLayer)

	local var_5_4 = tonumber(os.date("%H"))
	local var_5_5 = var_5_4 > 6 and var_5_4 < 15 and 1 or var_5_4 >= 15 and var_5_4 < 19 and 2 or 3

	self.background = ccui.ImageView:create(var_0_34[var_5_4 > 6 and var_5_4 < 15 and 1 or var_5_4 >= 15 and var_5_4 < 19 and 2 or 3])

	self.background:setPosition(GameDisplay.cx, GameDisplay.height / 2 - GameDisplay.fix_y)
	self.background:setTouchEnabled(false)
	self.rootLayer:addChild(self.background)

	self.effectPanel = ccui.Layout:create()

	self.effectPanel:setContentSize(cc.size(640, 1136))
	self.effectPanel:setTouchEnabled(false)
	self.effectPanel:setOpacity(0)
	self.rootLayer:addChild(self.effectPanel, 999)

	for iter_5_0, iter_5_1 in pairs(playermodel.dormRoomConfig) do
		if iter_5_1.soulid > 0 and not var_0_33[iter_5_1.soulid] then
			var_0_33[iter_5_1.soulid] = {
				AngryTimes = 0,
				TalkTimes = 0
			}
		end
	end

	self:initRoomUI()
	self:initRole()
	self:GirlFirstTalk(var_5_5)
	self:fullScreen()
	self:slideSwitchRoom()
	self:initArrow()
	self:initAutoGain()
	self:registerEvent()
	self:initAiChatBtn()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_39 = nil

			if self.buttonFavor then
				self.buttonFavor:release()
			end

			if arg_5_1 and arg_5_1.updateDressCallback and var_5_1 ~= self.modelid then
				arg_5_1.updateDressCallback()
			end

			if arg_5_1 and arg_5_1.exitCallback then
				arg_5_1.exitCallback()
			end

			activity_manager:releaseEventListenerByName("DormRoomLayer")

			self.instance = nil
		end
	end)
end

function DormRoomLayer:registerEvent()
	self:registerRechargeEventListener()
	activity_manager:registerEventListener("DormRoomLayer", activity_manager.activityEventId.ACTIVITY_DRESS_ONE_KEY, function(arg_8_0)
		self:updateCurDress(arg_8_0.soulid, arg_8_0.itemid)
	end)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("ON_SELECT_SKIN", function(arg_9_0)
		self.modelid = arg_9_0.modelid

		if not self.dressPanel:haveDress(self.modelid) then
			self:updateDressUI()
		end

		self.dressPanel:switchDress(self.modelid)
	end), self)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_10_0)
		self.dressPanel:switchDress(self.dressPanel.selectOrder)
	end), self)
end

function DormRoomLayer:registerRechargeEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_12_0)
		if self.curShowPanel == "Panel_gift" then
			-- block empty
		else
			self:initDressUI()

			self.curShowPanel = nil

			self.dressPanel:getChildByName("Button_dress_sure"):setVisible(true)
			self:switchShowPanelList("Panel_dress")
		end
	end), self)
end

function DormRoomLayer:switchRoom(arg_13_1)
	local var_13_0 = self.roomindex
	local var_13_1 = (self.roomindex - 1) % 4 + 1

	local function var_13_2()
		var_13_0 = var_13_0 + arg_13_1

		if var_13_0 < 1 then
			var_13_0 = #DormitoryLayer.getInstance().roomInfos
		elseif var_13_0 > #DormitoryLayer.getInstance().roomInfos then
			var_13_0 = 1
		end

		var_13_1 = (var_13_0 - 1) % 4 + 1
	end

	var_13_2()

	::label_13_0::

	local var_13_4
	local var_13_3

	if (function()
		if DormitoryLayer.getInstance().roomInfos[var_13_0].state == var_0_35.PLOT or DormitoryLayer.getInstance().roomInfos[var_13_0].state == var_0_35.ATHOME or DormitoryLayer.getInstance().roomInfos[var_13_0].state == var_0_35.TRAVELBACK then
			return false
		end

		return true
	end)() then
		repeat
			var_13_2()

			goto label_13_0
		until true

		function var_13_3()
			if DormitoryLayer.getInstance() and DormitoryLayer.getInstance().rooms and DormitoryLayer.getInstance().rooms[var_13_1] then
				ccui.Helper:seekWidgetByName(DormitoryLayer.getInstance().rooms[var_13_1], "Image_screen" .. var_13_1):update()
			end
		end

		var_13_4 = {
			soulid = DormitoryLayer.getInstance().roomInfos[self.roomindex].soulid,
			roomorder = (self.roomindex - 1) % 4 + 1,
			roomindex = self.roomindex,
			isout = DormitoryLayer.getInstance().roomInfos[self.roomindex].state == var_0_35.PLOT and true or false
		}
	end

	function var_13_4.updateDressCallback()
		if DormitoryLayer.getInstance() and DormitoryLayer.getInstance().rooms and DormitoryLayer.getInstance().rooms[var_13_1] and DormitoryLayer.getInstance().rooms[var_13_1].director then
			DormitoryLayer.getInstance().rooms[var_13_1].director:deleteSelf()

			DormitoryLayer.getInstance().rooms[var_13_1].director = Director.new_dorm(DormitoryLayer.getInstance().rooms[var_13_1].curSoul, DormitoryLayer.getInstance().rooms[var_13_1]:getChildByName("Panel_show"))

			DormitoryLayer.getInstance().rooms[var_13_1].director:startPlay()
		end
	end

	var_13_4.exitCallback = var_13_3

	self:updateRoom(var_13_4)
end

function DormRoomLayer:initAutoGain()
	if playermodel.dormRoomConfig[self.roomindex].favorpool == 0 then
		return
	end

	self.iscanswitch = false

	dormitory_manager:add_favor_from_pool(self.roomindex, function(arg_19_0, arg_19_1)
		if arg_19_0 == 1 then
			self:playFavorPoolAnimation(arg_19_1)
			self:updateFavorPoolUI()
		end

		self.iscanswitch = true
	end)
end

function DormRoomLayer:updateRoom(arg_20_1)
	self.roomorder = arg_20_1.roomorder

	if arg_20_1.roomindex then
		self.roomindex = arg_20_1.roomindex or DormitoryLayer.getInstance().rooms[self.roomorder].index
	end

	self.soulid = arg_20_1.soulid
	self.isout = arg_20_1.isout
	self.modelid = dormitory_manager:getSoulDressModelid(self.soulid) or major_factor_data[self.soulid].model
	self.dialogTable = {}
	self.lineNum = 1

	local var_20_2 = tonumber(os.date("%H"))
	local var_20_3 = var_20_2 > 6 and var_20_2 < 15 and 1 or var_20_2 >= 15 and var_20_2 < 19 and 2 or 3

	self.background:loadTexture(var_0_34[var_20_2 > 6 and var_20_2 < 15 and 1 or var_20_2 >= 15 and var_20_2 < 19 and 2 or 3])

	for iter_20_0, iter_20_1 in pairs(playermodel.dormRoomConfig) do
		if iter_20_1.soulid > 0 and not var_0_33[iter_20_1.soulid] then
			var_0_33[iter_20_1.soulid] = {
				AngryTimes = 0,
				TalkTimes = 0
			}
		end
	end

	self:updateRoomUI()
	self:updateRole()
	self:GirlFirstTalk(var_20_3)
	self:initAutoGain()
end

function DormRoomLayer:fullScreen()
	self.favorUI.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - self.favorUI:getPositionY(), TRANSFORM_UNIT.PX)

	self.favorUI:setPositionY(self.favorUI.full_posY)

	self.postCord.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, config._DESIGN_HEIGHT - self.postCord:getPositionY(), TRANSFORM_UNIT.PX)

	self.postCord:setPositionY(self.postCord.full_posY)

	self.favorPoolBnt.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.favorPoolBnt:getPositionY(), TRANSFORM_UNIT.PX)

	self.favorPoolBnt:setPositionY(self.favorPoolBnt.full_posY)

	self.sendGift.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.sendGift:getPositionY(), TRANSFORM_UNIT.PX)

	self.sendGift:setPositionY(self.sendGift.full_posY)

	self.giftPanel.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.giftPanel:getPositionY(), TRANSFORM_UNIT.PX)

	self.giftPanel:setPositionY(self.giftPanel.full_posY)

	self.changeDress.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.changeDress:getPositionY(), TRANSFORM_UNIT.PX)

	self.changeDress:setPositionY(self.changeDress.full_posY)

	self.dressPanel.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.dressPanel:getPositionY(), TRANSFORM_UNIT.PX)

	self.dressPanel:setPositionY(self.dressPanel.full_posY)

	self.favorThingPanel.full_posY = -GameDisplay.fix_y

	self.favorThingPanel:setPositionY(self.favorThingPanel.full_posY)
	self.favorThingPanel:getChildByName("bg"):setPositionY(self.favorThingPanel:getChildByName("bg"):getPositionY() + GameDisplay.fix_y)
	self.favorThingPanel:setContentSize(cc.size(self.favorThingPanel:getContentSize().width, GameDisplay.height))
end

function DormRoomLayer:GirlFirstTalk(arg_22_1)
	if self.isout then
		if self.uiPanel:getChildByName("talksp") then
			self.uiPanel:getChildByName("talksp"):setVisible(false)
		end
	else
		self.roleBnt:insertTalk(ROLE_CONVERSATION_TYPE.dormFirst)
	end
end

function DormRoomLayer:shake_screen(arg_23_1, arg_23_2)
	arg_23_1 = arg_23_1 or 2
	arg_23_2 = arg_23_2 or 5

	local var_23_0 = {}

	for iter_23_0 = 1, 3 do
		var_23_0[iter_23_0] = cc.Sequence:create(cc.MoveBy:create(0.05 / (iter_23_0 * iter_23_0), cc.p(arg_23_1 * 10 / iter_23_0, arg_23_2 * 10 / iter_23_0)), cc.MoveBy:create(0.05 / (iter_23_0 * iter_23_0), cc.p(-(arg_23_1 * 10 / iter_23_0), -(arg_23_2 * 10 / iter_23_0))), cc.MoveBy:create(0.05 / (iter_23_0 * iter_23_0), cc.p(-(arg_23_1 * 10 / iter_23_0), -(arg_23_2 * 10 / iter_23_0))), cc.MoveBy:create(0.05 / (iter_23_0 * iter_23_0), cc.p(arg_23_1 * 10 / iter_23_0, arg_23_2 * 10 / iter_23_0)))
	end

	self.background:runAction(cc.Sequence:create(var_23_0[1], var_23_0[2], var_23_0[3]))
end

function DormRoomLayer:playFavorUpAni()
	audio_manager:playeffectMusic(DORM_FAVOR_UPGRADE)

	local var_24_0 = L2Skeleton:create("spine/ui/e_haogan.json", "spine/ui/e_haogan.atlas")

	var_24_0:refreshSkeleton()
	var_24_0:setPosition(cc.p(320, 600))
	var_24_0:setVisible(true)
	var_24_0:play("e_haogan", false)
	var_24_0:registerListener(SP_ANIMATION_COMPLETE, function(arg_25_0)
		var_24_0:runAction(cc.RemoveSelf:create())
	end)
	self:addChild(var_24_0, 999)
end

function DormRoomLayer:initRoomUI()
	self.uiPanel = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "dorm_room_favor_bar.json" or "dorm_room_favor_bar.ExportJson")

	self.rootLayer:addChild(self.uiPanel, 998)

	self.postCord = ccui.Helper:seekWidgetByName(self.uiPanel, "Button_22")

	self.postCord:setVisible(false)

	self.favorUI = ccui.Helper:seekWidgetByName(self.uiPanel, "Image_favor")
	self.favor_bar = ccui.Helper:seekWidgetByName(self.favorUI, "ProgressBar_12")
	self.favor_exp = ccui.Helper:seekWidgetByName(self.favorUI, "Label_bar")
	self.favor_lv = ccui.Helper:seekWidgetByName(self.favorUI, "Label_lv")

	self.favor_lv:setColor(cc.c3b(255, 229, 247))
	self.favor_lv:enableOutline(cc.c4b(255, 47, 204, 255), 1)
	self.favor_bar:setTouchEnabled(true)
	self.favorUI:setOpacity(0)

	self.favorPoolBnt = ccui.Helper:seekWidgetByName(self.uiPanel, "Button_pool")
	self.favorPoolBar = ccui.Helper:seekWidgetByName(self.favorPoolBnt, "ProgressBar_pool")
	self.favorPoolLabel = ccui.Helper:seekWidgetByName(self.favorPoolBnt, "Label_percent")

	self.favorPoolBnt:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if playermodel.dormRoomConfig[self.roomindex].favorpool <= 0 then
			self:pop_img()

			return
		end

		if arg_27_0.isLock then
			return
		end

		arg_27_0.isLock = true

		dormitory_manager:add_favor_from_pool(self.roomindex, function(arg_28_0)
			if arg_28_0 == 1 then
				self:updateFavorPoolUI()
			end

			arg_27_0.isLock = false
		end)
	end)
	ccui.Helper:seekWidgetByName(self.uiPanel, "panel_favor_thing"):setVisible(false)

	self.favorThingPanel = ccui.Helper:seekWidgetByName(self.uiPanel, "panel_favor_thing"):clone()

	self:addChild(self.favorThingPanel, 3)

	self.favorThingBg = self.favorThingPanel:getChildByName("bg")

	self.favorThingBg:setTouchEnabled(true)
	self.favorThingPanel:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_window_close_action(self.favorThingBg, function()
			self.favorThingPanel:setVisible(false)
		end)
	end)
	ccui.Helper:seekWidgetByName(self.uiPanel, "panel_favor_thing"):removeFromParent()
	self.favorUI:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.favorThingInitTag and self.favorThingInitTag == true then
			self:uiFavorThingUpdate()
		else
			self:uiFavorThing()
		end
	end)
	self.favor_bar:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.favorThingInitTag and self.favorThingInitTag == true then
			self:uiFavorThingUpdate()
		else
			self:uiFavorThing()
		end
	end)
	self:initGiftUI()
	self:initDressUI()
	self:initMarryUI()
	self:updateFavorPoolUI()
	self:updateValentIcon()

	self.isCanChangePanel = true

	goodwell_manager:getSoulFavor(self.soulid, function(arg_33_0, arg_33_1)
		if not self.instance then
			return
		end

		if self.soulid ~= arg_33_1 then
			return
		end

		if arg_33_0 == 1 then
			self.favorUI:runAction(cc.Sequence:create(cc.CallFunc:create(function()
				self:updateFavorBar()
				self:updateFavorPoolUI()
			end), cc.FadeIn:create(0.5)))
		else
			self.favorUI:setOpacity(255)
		end
	end)
	ccui.Helper:seekWidgetByName(self.uiPanel, "Button_return"):addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer()
	end)

	if self.isout then
		self.sendGift:setVisible(false)
		self.changeDress:setVisible(false)
	end
end

function DormRoomLayer:updateRoomUI()
	self.giftPanel:setPositionX(640)
	self.giftPanel:setVisible(false)
	self.dressPanel:setPositionX(640)
	self.dressPanel:setVisible(false)
	ccui.Helper:seekWidgetByName(self.uiPanel, "Button_return"):setVisible(true)

	self.curShowPanel = nil

	self:updateGiftUI()
	self:updateDressUI()
	self:updateMarryUI()
	self:updateFavorPoolUI()
	self:updateValentIcon()

	self.isCanChangePanel = true

	self.favorUI:setOpacity(0)
	goodwell_manager:getSoulFavor(self.soulid, function(arg_37_0, arg_37_1)
		if not self.instance then
			return
		end

		if arg_37_1 ~= self.soulid then
			return
		end

		if arg_37_0 == 1 then
			self.favorUI:runAction(cc.Sequence:create(cc.CallFunc:create(function()
				self:updateFavorBar()
				self:updateFavorPoolUI()
			end), cc.FadeIn:create(0.5)))
		else
			self.favorUI:setOpacity(255)
		end
	end)

	if self.isout then
		global_ShowBlockWords(major_factor_data[self.soulid].easy_name .. L_DORM_TOUCH_EVENT_MSG.PLOT)
		self.sendGift:setVisible(false)
		self.changeDress:setVisible(false)
	else
		self.sendGift:setVisible(true)
		self.changeDress:setVisible(true)
	end
end

function DormRoomLayer:playFavorPoolAnimation(arg_39_1)
	arg_39_1 = arg_39_1 or ""

	local var_39_0 = cc.SpriteFrameCache:getInstance()

	var_39_0:addSpriteFrames("effect/aix.plist")

	local var_39_1 = cc.Sprite:createWithSpriteFrameName("aix1.png")

	var_39_1:setAnchorPoint(cc.p(0.5, 0))
	var_39_1:setName("frameAnimate")
	var_39_1:setPosition(self.favorPoolBnt:getPositionX(), self.favorPoolBnt:getPositionY() - 150)
	self.uiPanel:addChild(var_39_1)

	local var_39_2 = cc.Label:createWithTTF("+" .. arg_39_1 .. "好感币", FONT_BUTTON, 24)

	var_39_2:enableOutline(cc.c4b(193, 27, 146, 255), 1)
	var_39_2:setColor(cc.c3b(255, 255, 255))
	var_39_2:setPosition(self.favorPoolBnt:getPosition())
	self.uiPanel:addChild(var_39_2)

	local var_39_3 = cc.Animation:create()

	for iter_39_0 = 1, 15 do
		var_39_3:addSpriteFrame((var_39_0:getSpriteFrame(string.format("aix%d.png", iter_39_0))))
	end

	var_39_3:setDelayPerUnit(0.2)
	var_39_3:setRestoreOriginalFrame(false)
	var_39_1:runAction(cc.RepeatForever:create(cc.Animate:create(var_39_3)))
	var_39_1:runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(4, cc.p(0, 300 + GameDisplay.height - 1136)), cc.FadeTo:create(4, 80)), cc.RemoveSelf:create(), cc.CallFunc:create(function()
		if callback then
			callback()
		end
	end)))
	var_39_2:runAction(cc.Sequence:create(cc.Spawn:create(cc.MoveBy:create(4, cc.p(0, 300 + GameDisplay.height - 1136)), cc.FadeTo:create(4, 80)), cc.RemoveSelf:create()))
end

function DormRoomLayer:updateFavorPoolUI()
	self.favorPoolBar:setPercent(math.floor(playermodel.dormRoomConfig[self.roomindex].favorpool / (25 + playermodel.favor[self.soulid].favorlevel * 4) * 100))
	self.favorPoolLabel:setString(playermodel.dormRoomConfig[self.roomindex].favorpool .. "/" .. 25 + playermodel.favor[self.soulid].favorlevel * 4)
end

function DormRoomLayer:updateValentIcon()
	local var_42_0 = false
	local activity_return_manager = require("controller.activity_return_manager")

	if activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_TYPE_SEND_GIFT_FAVOR) then
		var_42_0 = true
	end

	if dormitory_manager:is_add_favor_double(self.soulid) then
		if not self.valentineIocn then
			self.valentineIocn = ccui.ImageView:create(var_42_0 and "Dormitory/valentine_icon_2.png" or "Dormitory/valentine_icon.png", var_0_21)

			self.valentineIocn:setAnchorPoint(cc.p(0.5, 1))
			self.valentineIocn:setPosition(self.sendGift:getContentSize().width / 2 - 10, 10)
			self.sendGift:addChild(self.valentineIocn)
		else
			self.valentineIocn:loadTexture(var_42_0 and "Dormitory/valentine_icon_2.png" or "Dormitory/valentine_icon.png", var_0_21)
		end
	elseif var_42_0 then
		if not self.valentineIocn then
			self.valentineIocn = ccui.ImageView:create("Dormitory/valentine_icon.png", var_0_21)

			self.valentineIocn:setAnchorPoint(cc.p(0.5, 1))
			self.valentineIocn:setPosition(self.sendGift:getContentSize().width / 2 - 10, 10)
			self.sendGift:addChild(self.valentineIocn)
		else
			self.valentineIocn:loadTexture("Dormitory/valentine_icon.png", var_0_21)
		end
	elseif dormitory_manager:is_more_send_gift() then
		if not self.valentineIocn then
			self.valentineIocn = ccui.ImageView:create("Dormitory/more_gift_icon.png", var_0_21)

			self.valentineIocn:setAnchorPoint(cc.p(0.5, 1))
			self.valentineIocn:setPosition(self.sendGift:getContentSize().width / 2 - 10, 10)
			self.sendGift:addChild(self.valentineIocn)
		else
			self.valentineIocn:loadTexture("Dormitory/more_gift_icon.png", var_0_21)
		end
	elseif self.valentineIocn then
		self.valentineIocn:removeFromParent()

		self.valentineIocn = nil
	end
end

function DormRoomLayer:switchShowPanelList(arg_43_1)
	print("switchShowPanelList", arg_43_1)

	if not self.isCanChangePanel then
		return
	end

	self.isCanChangePanel = false

	local var_43_0 = {
		Panel_gift = self.giftPanel,
		Panel_dress = self.dressPanel
	}

	GuideListener.swallowEvent(false)
	GuideListener.lockGuideTrigger(true)
	GuideListener.cleanCurGuides()

	if self.curShowPanel == "Panel_dress" then
		self.roleBnt:update(self.modelid)
		self.roleBnt:setTalkEnabled(true)

		if self.dressPanel.selectOrder then
			local var_43_1 = self.dressPanel:getChildByName("ScrollView"):getChildByName(self.dressPanel.selectOrder)

			if var_43_1 and var_43_1.entityid then
				var_43_1:getChildByName("heightLight"):removeFromParent()
			end

			self.dressPanel.selectOrder = nil
		end

		self.dressPanel:getChildByName("Button_dress_sure"):setVisible(false)
	end

	if self.curShowPanel then
		self.uiPanel:getChildByName("Button_return"):setVisible(true)

		if arg_43_1 == self.curShowPanel then
			var_43_0[arg_43_1]:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(-10, var_43_0[arg_43_1].full_posY)), cc.MoveTo:create(0.2, cc.p(640, var_43_0[arg_43_1].full_posY)), cc.Hide:create(), cc.CallFunc:create(function()
				self.isCanChangePanel = true
				self.curShowPanel = nil

				GuideListener.cleanCurGuides()
				GuideListener.swallowEvent(false)
				GuideListener.lockGuideTrigger(false)
				GuideListener.updateGuides(self)
			end)))
		else
			self.uiPanel:getChildByName("Button_return"):setVisible(false)
			var_43_0[self.curShowPanel]:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(-10, var_43_0[arg_43_1].full_posY)), cc.MoveTo:create(0.2, cc.p(640, var_43_0[arg_43_1].full_posY)), cc.Hide:create(), cc.CallFunc:create(function()
				var_43_0[arg_43_1]:runAction(cc.Sequence:create(cc.Show:create(), cc.MoveTo:create(0.2, cc.p(-10, var_43_0[arg_43_1].full_posY)), cc.MoveTo:create(0.1, cc.p(0, var_43_0[arg_43_1].full_posY)), cc.CallFunc:create(function()
					self.isCanChangePanel = true
					self.curShowPanel = arg_43_1

					GuideListener.cleanCurGuides()
					GuideListener.swallowEvent(false)
					GuideListener.lockGuideTrigger(false)
					GuideListener.updateGuides(self)
				end)))
			end)))
		end
	else
		self.uiPanel:getChildByName("Button_return"):setVisible(false)
		var_43_0[arg_43_1]:runAction(cc.Sequence:create(cc.Show:create(), cc.MoveTo:create(0.2, cc.p(-10, var_43_0[arg_43_1].full_posY)), cc.MoveTo:create(0.1, cc.p(0, var_43_0[arg_43_1].full_posY)), cc.CallFunc:create(function()
			self.isCanChangePanel = true
			self.curShowPanel = arg_43_1

			GuideListener.cleanCurGuides()
			GuideListener.swallowEvent(false)
			GuideListener.lockGuideTrigger(false)
			GuideListener.updateGuides(self)
		end)))
	end
end

function DormRoomLayer:initGiftUI()
	self.sendGift = ccui.Helper:seekWidgetByName(self.uiPanel, "Button_gift")

	self.sendGift:setLocalZOrder(9999)

	self.sendGift.isReady = false

	if dormitory_manager:checkIsCanSendGift(self.soulid) then
		AlertManager:add_alert_by_config(self.sendGift, true, {
			ALERT_SHOW_REDDOT,
			"",
			cc.p(self.sendGift:getContentSize().width, self.sendGift:getContentSize().height)
		})
	else
		AlertManager:add_alert_by_config(self.sendGift, false, {
			ALERT_SHOW_REDDOT,
			"",
			cc.p(self.sendGift:getContentSize().width, self.sendGift:getContentSize().height)
		})
	end

	self.sendGift:addTouchEventListener(function(arg_49_0, arg_49_1)
		if arg_49_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.sendGift.isReady then
			return
		end

		self:switchShowPanelList("Panel_gift")
	end)

	self.giftPanel = ccui.Helper:seekWidgetByName(self.uiPanel, "Panel_gift")
	self.btn = ccui.Button:create("public/button/give.png", "public/button/give.png", "public/button/give.png", var_0_21)

	self.btn:setContentSize(self.giftPanel:getChildByName("Button_gift_sure"):getContentSize())
	self.btn:setPosition(self.giftPanel:getChildByName("Button_gift_sure"):getPosition())
	self.giftPanel:addChild(self.btn, 999)
	self.btn:setOpacity(0)
	self.btn:setVisible(false)
	self.giftPanel:setPositionX(640)

	self.giftPanel.postype = "out"

	local var_48_0 = ccui.Layout:create()

	var_48_0:setTouchEnabled(false)
	var_48_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_48_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_48_0:setBackGroundColorOpacity(200)
	var_48_0:setCascadeOpacityEnabled(false)
	var_48_0:setPosition(390, 300)
	self.giftPanel:addChild(var_48_0)

	self.sendTimes = cc.Label:createWithTTF(string.format(L_DORMROOM_SEND_GIFT.Rest_Common, playermodel.gift_limit[self.soulid]), FONT_NAME, 20)

	self.sendTimes:setAnchorPoint(cc.p(0, 0))
	self.sendTimes:setPosition(0, 0)
	var_48_0:setContentSize(self.sendTimes:getContentSize())
	var_48_0:addChild(self.sendTimes)
	self.giftPanel:getChildByName("Button_cancel"):addTouchEventListener(function(arg_50_0, arg_50_1)
		if arg_50_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchShowPanelList("Panel_gift")
		self.uiPanel:getChildByName("Button_return"):setVisible(true)
	end)

	local var_48_1 = ccui.ImageView:create("public/currency/UI_battleEnd_diamond.png", var_0_21)

	var_48_1:setScale(0.8)
	var_48_1:setPosition(5, 30)
	var_48_1:setAnchorPoint(cc.p(1, 0.5))
	var_48_1:setName("diamond_icon")
	self.giftPanel:getChildByName("Button_gift_sure"):addChild(var_48_1)

	local var_48_2 = math.ceil((playermodel.gift_send_times[self.soulid] - GIFT_LIMIT + 1) / 10)
	local var_48_3 = cc.Label:createWithTTF(20 .. "×", FONT_NAME, 24)

	var_48_3:setAnchorPoint(cc.p(1, 0.5))
	var_48_3:setPositionX(var_48_1:getPositionX() - var_48_1:getBoundingBox().width + 10)
	var_48_3:setPositionY(var_48_1:getPositionY())
	var_48_3:setName("diamond_cost")
	self.giftPanel:getChildByName("Button_gift_sure"):addChild(var_48_3)

	local var_48_4 = ccui.Layout:create()

	var_48_4:setContentSize(cc.size(100, 50))
	var_48_4:setAnchorPoint(cc.p(1, 0.5))
	var_48_4:setPosition(0, 30)
	var_48_4:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_48_4:setBackGroundColor(cc.c3b(0, 0, 0))
	var_48_4:setBackGroundColorOpacity(160)
	var_48_4:setName("cost_bg")
	self.giftPanel:getChildByName("Button_gift_sure"):addChild(var_48_4, -1)

	self.giftPanel:getChildByName("Button_gift_sure").updateBnt = function(self)
		if self.giftPanel.selectOrder then
			if self.giftPanel:getChildByName("ScrollView"):getChildByName(self.giftPanel.selectOrder) then
				if self.giftPanel:getChildByName("ScrollView"):getChildByName(self.giftPanel.selectOrder).entityid then
					if item_data[self.giftPanel:getChildByName("ScrollView"):getChildByName(self.giftPanel.selectOrder).entityid].is_free_send then
						self:getChildByName("diamond_icon"):setVisible(false)
						self:getChildByName("diamond_cost"):setVisible(false)
						self:getChildByName("cost_bg"):setVisible(false)

						return
					end
				end
			end
		end

		if playermodel.gift_limit[self.soulid] <= 0 then
			local var_51_0 = self:getChildByName("diamond_cost")

			self:getChildByName("diamond_icon"):setVisible(true)
			var_51_0:setVisible(true)
			self:getChildByName("cost_bg"):setVisible(true)

			local var_51_1 = math.ceil((playermodel.gift_send_times[self.soulid] - GIFT_LIMIT + 1) / 10)

			var_51_0:setString(20 .. "×")
		else
			self:getChildByName("diamond_icon"):setVisible(false)
			self:getChildByName("diamond_cost"):setVisible(false)
			self:getChildByName("cost_bg"):setVisible(false)
		end
	end

	self.giftPanel:getChildByName("Button_gift_sure"):updateBnt()
	self.giftPanel:getChildByName("Button_gift_sure"):addTouchEventListener(function(arg_52_0, arg_52_1)
		if arg_52_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.giftPanel.selectOrder then
			return
		end

		local var_52_0 = self.giftPanel:getChildByName("ScrollView"):getChildByName(self.giftPanel.selectOrder)

		if var_52_0.usetype == "item" then
			arg_52_0:setTouchEnabled(false)

			local var_52_1 = self.giftPanel:getChildByName("ScrollView"):getChildByName(self.giftPanel.selectOrder).entityid

			local function var_52_2()
				dormitory_manager:sendGift(self.soulid, var_52_1, function(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
					if not self.instance then
						return
					end

					if arg_54_0 == 1 then
						self:updateGiftList(self.giftPanel.selectOrder)
						self:updateFavorBar()
						self:updateFavorPoolUI()

						if not arg_54_1 then
							self.roleBnt:insertTalk(arg_54_2)
						end

						self.sendTimes:setString(string.format(L_DORMROOM_SEND_GIFT.Rest_Common, playermodel.gift_limit[self.soulid]))

						if dormitory_manager:checkIsCanSendGift(self.soulid) then
							AlertManager:add_alert_by_config(self.sendGift, true, {
								ALERT_SHOW_REDDOT,
								"",
								cc.p(self.sendGift:getContentSize().width, self.sendGift:getContentSize().height)
							})
						else
							AlertManager:add_alert_by_config(self.sendGift, false, {
								ALERT_SHOW_REDDOT,
								"",
								cc.p(self.sendGift:getContentSize().width, self.sendGift:getContentSize().height)
							})
						end

						self.giftPanel:getChildByName("Button_gift_sure"):updateBnt()
					end

					arg_52_0:setTouchEnabled(true)
				end)
			end

			if not (function(arg_55_0)
				while item_data[arg_55_0]["free_send_soul_" .. 1] do
					if item_data[arg_55_0]["free_send_soul_" .. 1] == self.soulid then
						return true
					end
				end

				return false
			end)(var_52_1) then
				if not item_data[var_52_1].is_free_send and playermodel.gift_send_times[self.soulid] - GIFT_LIMIT == 0 then
					local var_52_3 = math.ceil((playermodel.gift_send_times[self.soulid] - GIFT_LIMIT + 1) / 10)
					local var_52_4 = {
						costtype = "diamond",
						is_need_pop_layer = 1,
						own = playermodel.diamond
					}

					var_52_4.cost = 20
					var_52_4.surecallback = var_52_2

					function var_52_4.cancelcallback()
						arg_52_0:setTouchEnabled(true)
					end

					var_52_4.labels = global_deepCopy(L_MORE_GIFT)
					var_52_4.labels.titleNewImage = "public/title/title_send_gift_times_lack.png"

					LayerManager:pushInLayer("PopDoLayer", var_52_4)
				else
					var_52_2()
				end
			else
				var_52_2()
			end
		elseif var_52_0.usetype == "shop" then
			print("shopitem,shoptype", dump(var_52_0.shopconfig.shopinfo), var_52_0.shopconfig.shoptype)
			self:shopPop(var_52_0.shopconfig.shopinfo, var_52_0.shopconfig.shoptype)
		end
	end)
	dormitory_manager:get_favor_gift_limit(self.soulid, function(arg_57_0)
		if not self.instance then
			return
		end

		if arg_57_0 ~= self.soulid then
			return
		end

		self.sendTimes:setString(string.format(L_DORMROOM_SEND_GIFT.Rest_Common, playermodel.gift_limit[self.soulid]))

		self.sendGift.isReady = true
	end)
	self:initGiftList()
end

function DormRoomLayer:updateGiftUI()
	self.sendGift.isReady = false

	if dormitory_manager:checkIsCanSendGift(self.soulid) then
		AlertManager:add_alert_by_config(self.sendGift, true, {
			ALERT_SHOW_REDDOT,
			"",
			cc.p(self.sendGift:getContentSize().width, self.sendGift:getContentSize().height)
		})
	else
		AlertManager:add_alert_by_config(self.sendGift, false, {
			ALERT_SHOW_REDDOT,
			"",
			cc.p(self.sendGift:getContentSize().width, self.sendGift:getContentSize().height)
		})
	end

	dormitory_manager:get_favor_gift_limit(self.soulid, function(arg_59_0)
		if not self.instance then
			return
		end

		if arg_59_0 ~= self.soulid then
			return
		end

		self.sendTimes:setString(string.format(L_DORMROOM_SEND_GIFT.Rest_Common, playermodel.gift_limit[self.soulid]))

		self.sendGift.isReady = true

		self.giftPanel:getChildByName("Button_gift_sure"):updateBnt()
	end)
	self.giftPanel:getChildByName("Button_gift_sure"):setVisible(false)
	self.giftPanel:getChildByName("ScrollView"):removeAllChildren()

	self.giftPanel.selectOrder = nil

	self:initGiftList()
end

function DormRoomLayer:initGiftList()
	local var_60_0 = self.giftPanel:getChildByName("ScrollView")
	local var_60_1, var_60_2 = dormitory_manager:getSoulGiftList(self.soulid)

	var_60_0:setInnerContainerSize(cc.size((#var_60_1 + #var_60_2) * 145 < var_60_0:getContentSize().width and var_60_0:getContentSize().width or (#var_60_1 + #var_60_2) * 145, var_60_0:getContentSize().height))

	function self.giftPanel:switchGift(arg_61_1)
		local var_61_0 = self.giftPanel:getChildByName("ScrollView")
		local var_61_1 = var_61_0:getChildByName(arg_61_1)

		if self.selectOrder then
			local var_61_3 = var_61_0:getChildByName(self.selectOrder)

			if var_61_3 and var_61_3.entityid then
				var_61_3:getChildByName("heightLight"):removeFromParent()
			end
		end

		local var_61_6 = ccui.Layout:create()
		local var_61_7 = {}

		for iter_61_0 = 1, 2 do
			if iter_61_0 == 1 then
				if config._DEBUG then
					var_61_7[iter_61_0] = cc.Sprite:create("public/box/new_item_bg_on2.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_bg_on2.png")
				end

				var_61_7[iter_61_0]:setScale(1.1)
				var_61_7[iter_61_0]:setOpacity(0)
				var_61_7[iter_61_0]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)))))
			else
				if config._DEBUG then
					var_61_7[iter_61_0] = cc.Sprite:create("public/box/new_item_bg_on2.png") or cc.Sprite:createWithSpriteFrameName("public/box/new_item_bg_on2.png")
				end

				var_61_7[iter_61_0]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)))))
			end

			var_61_7[iter_61_0]:setPosition(var_61_1:getContentSize().width / 2, var_61_1:getContentSize().height / 2)
			var_61_6:addChild(var_61_7[iter_61_0])
		end

		var_61_6:setName("heightLight")
		var_61_1:addChild(var_61_6)
		self.giftPanel:getChildByName("Button_gift_sure"):setVisible(true)

		if var_61_1.usetype == "shop" then
			-- block empty
		elseif var_61_1.usetype == "item" then
			self.giftPanel:getChildByName("Button_gift_sure"):setTouchEnabled(true)
			self.giftPanel:getChildByName("Button_gift_sure"):setColor(cc.c3b(255, 255, 255))
			self.btn:setVisible(false)

			local var_61_8 = self.giftPanel:getChildByName("Button_gift_sure")

			if item_data[var_61_1.entityid].is_free_send then
				var_61_8:getChildByName("diamond_icon"):setVisible(false)
				var_61_8:getChildByName("diamond_cost"):setVisible(false)
				var_61_8:getChildByName("cost_bg"):setVisible(false)
			elseif playermodel.gift_limit[self.soulid] <= 0 then
				var_61_8:getChildByName("diamond_icon"):setVisible(true)
				var_61_8:getChildByName("diamond_cost"):setVisible(true)
				var_61_8:getChildByName("cost_bg"):setVisible(true)
			else
				var_61_8:getChildByName("diamond_icon"):setVisible(false)
				var_61_8:getChildByName("diamond_cost"):setVisible(false)
				var_61_8:getChildByName("cost_bg"):setVisible(false)
			end
		end

		self.selectOrder = arg_61_1
	end

	for iter_60_0, iter_60_1 in pairs(var_60_1) do
		local var_60_3 = iter_60_0 + #var_60_2
		local var_60_4 = ItemSprite:createBigWithEntityId(iter_60_1)

		var_60_4:setName(iter_60_0 + #var_60_2)

		var_60_4.entityid = iter_60_1
		var_60_4.usetype = "item"

		var_60_4:setScale(170 / var_60_4:getContentSize().height)
		var_60_4:setAnchorPoint(cc.p(1, 0.5))
		var_60_4:setPosition((iter_60_0 + #var_60_2) * 133, var_60_0:getContentSize().height / 2 + 17)

		local var_60_5 = ccui.ImageView:create("Dormitory/favor_bottom.png", var_0_21)

		var_60_5:setScale9Enabled(true)
		var_60_5:setCapInsets(cc.rect(15, 0, 100, 45))
		var_60_5:setContentSize(cc.size(172, 55))
		var_60_5:setAnchorPoint(cc.p(0.5, 1))
		var_60_5:setPosition(var_60_4:getContentSize().width / 2, 3)
		var_60_4:addChild(var_60_5, 999)

		local var_60_6 = ccui.ImageView:create("Dormitory/pop_gift/heart.png", var_0_21)

		var_60_6:setPosition(var_60_5:getContentSize().width / 2 - 45, var_60_5:getContentSize().height / 2)
		var_60_5:addChild(var_60_6)
		assert(item_data[playermodel.items[iter_60_1].itemid].favor, string.format("itemid %s favor is nil", playermodel.items[iter_60_1].itemid))

		local var_60_7 = cc.Label:createWithTTF("+" .. item_data[playermodel.items[iter_60_1].itemid].favor, FONT_NAME, 26)

		var_60_7:setColor(cc.c3b(255, 255, 255))
		var_60_7:setAnchorPoint(cc.p(0, 0.5))
		var_60_7:setPosition(var_60_5:getContentSize().width / 2 - 10, var_60_5:getContentSize().height / 2)
		var_60_5:addChild(var_60_7)
		var_60_0:addChild(var_60_4)
		var_60_4:setTouchEnabled(true)
		var_60_4:addSpriteTouchEventListener(function(arg_62_0, arg_62_1)
			if arg_62_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.giftPanel:switchGift(var_60_3)
		end)
	end

	for iter_60_2, iter_60_3 in pairs(var_60_2) do
		local var_60_8 = iter_60_2
		local var_60_9 = ItemSprite:createNewWithItemId(iter_60_3.shopinfo.itemtype)

		var_60_9:setName(iter_60_2)

		var_60_9.shopconfig = iter_60_3
		var_60_9.entityid = iter_60_3.shopinfo.itemtype
		var_60_9.usetype = "shop"

		var_60_9:setScale(170 / var_60_9:getContentSize().height)
		var_60_9:setAnchorPoint(cc.p(1, 0.5))
		var_60_9:setPosition(iter_60_2 * 133, var_60_0:getContentSize().height / 2 + 17)

		local var_60_10 = ccui.Layout:create()

		var_60_10:setTouchEnabled(true)
		var_60_10:setContentSize(var_60_9:getContentSize())
		var_60_10:setAnchorPoint(cc.p(0.5, 0.5))
		var_60_10:setPosition(cc.p(var_60_9:getContentSize().width / 2, var_60_9:getContentSize().height / 2))
		var_60_10:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_60_10:setBackGroundColor(cc.c3b(0, 0, 0))
		var_60_10:setBackGroundColorOpacity(150)
		var_60_9:addChild(var_60_10, 999)

		local var_60_11 = ccui.ImageView:create("Dormitory/favor_bottom.png", var_0_21)

		var_60_11:setScale9Enabled(true)
		var_60_11:setCapInsets(cc.rect(15, 0, 100, 45))
		var_60_11:setContentSize(cc.size(172, 55))
		var_60_11:setAnchorPoint(cc.p(0.5, 1))
		var_60_11:setPosition(var_60_9:getContentSize().width / 2, 3)
		var_60_9:addChild(var_60_11, 999)

		local var_60_12 = ccui.ImageView:create("Dormitory/pop_gift/heart.png", var_0_21)

		var_60_12:setPosition(var_60_11:getContentSize().width / 2 - 45, var_60_11:getContentSize().height / 2)
		var_60_11:addChild(var_60_12)

		local var_60_13 = cc.Label:createWithTTF("+" .. item_data[iter_60_3.shopinfo.itemtype].favor, FONT_NAME, 26)

		var_60_13:setColor(cc.c3b(255, 255, 255))
		var_60_13:setAnchorPoint(cc.p(0, 0.5))
		var_60_13:setPosition(var_60_11:getContentSize().width / 2 - 10, var_60_11:getContentSize().height / 2)
		var_60_11:addChild(var_60_13)
		var_60_0:addChild(var_60_9)
		var_60_9:setTouchEnabled(true)
		var_60_10:addTouchEventListener(function(arg_63_0, arg_63_1)
			if arg_63_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.giftPanel:switchGift(var_60_8)

			local var_63_0 = self.giftPanel:getChildByName("ScrollView"):getChildByName(self.giftPanel.selectOrder)

			self:shopPop(var_63_0.shopconfig.shopinfo, var_63_0.shopconfig.shoptype)
		end)
	end

	if next(var_60_1) == nil and next(var_60_2) == nil then
		local var_60_14 = ccui.ImageView:create("Dormitory/go_gain_gift.png", var_0_21)

		var_60_14:setPosition(var_60_0:getContentSize().width / 2, var_60_0:getContentSize().height / 2)
		var_60_0:addChild(var_60_14)
		var_60_0:addTouchEventListener(function(arg_64_0, arg_64_1)
			if arg_64_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopGoGainLayer", {
				goto_back_system_id = 700,
				item = 6700102,
				itemName = L_DORMROOM_SEND_GIFT.itemName,
				methods = {
					systemid = 1505,
					des = L_DORMROOM_SEND_GIFT.Gain_Des
				}
			})
		end)
	elseif next(var_60_2) ~= nil and next(var_60_1) ~= nil then
		self.giftPanel:switchGift(2)
	else
		self.giftPanel:switchGift(1)
	end
end

function DormRoomLayer:updateGiftList(arg_65_1)
	local var_65_0 = self.giftPanel:getChildByName("ScrollView")
	local var_65_1 = var_65_0:getChildByName(arg_65_1)

	if item_manager:haveItem(var_65_1.entityid) then
		var_65_1:updateBigInfo()
	else
		var_65_0:removeAllChildren()

		self.giftPanel.selectOrder = nil

		self:initGiftList()
	end
end

function DormRoomLayer:initDressUI()
	self.changeDress = ccui.Helper:seekWidgetByName(self.uiPanel, "Button_dress")

	self.changeDress:setLocalZOrder(9999)
	self.changeDress:addTouchEventListener(function(arg_67_0, arg_67_1)
		if arg_67_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchShowPanelList("Panel_dress")
	end)

	self.dressPanel = ccui.Helper:seekWidgetByName(self.uiPanel, "Panel_dress")

	self:initDressList()
	self.dressPanel:setPositionX(640)

	self.dressPanel.postype = "out"

	self.dressPanel:getChildByName("Button_cancel"):loadTextures("public/button/return_btn_bottom.png", "public/button/return_btn.png", "public/button/return_btn.png", var_0_21)
	self.dressPanel:getChildByName("Button_cancel"):addTouchEventListener(function(arg_68_0, arg_68_1)
		if arg_68_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchShowPanelList("Panel_dress")
		self.uiPanel:getChildByName("Button_return"):setVisible(true)
	end)
	self.dressPanel:getChildByName("Button_dress_sure"):setVisible(false)
	self.dressPanel:getChildByName("Button_dress_sure"):addTouchEventListener(function(arg_69_0, arg_69_1)
		if arg_69_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.dressPanel.selectOrder then
			return
		end

		if self.dressPanel.selectOrder == self.modelid then
			return
		end

		local var_69_0

		if model_data[self.dressPanel.selectOrder].itemid then
			var_69_0 = model_data[self.dressPanel.selectOrder].itemid

			if not item_manager:haveItem(model_data[self.dressPanel.selectOrder].itemid) then
				local var_69_1, var_69_2 = (function(arg_70_0, arg_70_1)
					if not dormitory_manager.skinshops then
						return false
					end

					if not dormitory_manager.skinshops.skin then
						return false
					end

					if not dormitory_manager.skinshops.skin[arg_70_0] then
						return false
					end

					for iter_70_0, iter_70_1 in pairs(dormitory_manager.skinshops.skin[arg_70_0]) do
						if item_data[iter_70_1.shopinfo.itemtype].model == arg_70_1 then
							return iter_70_1.shopinfo, iter_70_1.shoptype
						end
					end

					return false
				end)(self.soulid, item_data[model_data[self.dressPanel.selectOrder].itemid].model)
				local var_69_3, var_69_4 = (function(arg_71_0, arg_71_1)
					if not dormitory_manager.skinshops then
						return false
					end

					if not dormitory_manager.skinshops.skin_package then
						return false
					end

					if not dormitory_manager.skinshops.skin_package[arg_71_0] then
						return false
					end

					for iter_71_0, iter_71_1 in pairs(dormitory_manager.skinshops.skin_package[arg_71_0]) do
						if item_data[iter_71_1.shopinfo.itemtype].mode_id then
							for iter_71_2, iter_71_3 in pairs((drop_manager:getEquipDrops(item_data[iter_71_1.shopinfo.itemtype].mode_id))) do
								if item_data[iter_71_3.dropid].model and item_data[iter_71_3.dropid].model == arg_71_1 then
									return iter_71_1.shopinfo, iter_71_1.shoptype
								end
							end
						elseif item_data[iter_71_1.shopinfo.itemtype].model == arg_71_1 then
							return iter_71_1.shopinfo, iter_71_1.shoptype
						end
					end

					return false
				end)(self.soulid, item_data[model_data[self.dressPanel.selectOrder].itemid].model)

				if var_69_1 then
					self:shopPop(var_69_1, var_69_2, "shopitem")
				elseif var_69_3 then
					self:shopPop(var_69_3, var_69_4, "giftitem")
				elseif item_data[model_data[self.dressPanel.selectOrder].itemid].skin_type == "marry" then
					LayerManager:pushInLayer("MarryPopLayer", {
						majorid = self.soulid,
						exitCallback = function()
							if DormRoomLayer and DormRoomLayer.getInstance() then
								DormRoomLayer.getInstance():updateDressUI()
								DormRoomLayer.getInstance():updateFavorBar()
							elseif DormRoomPopLayer and DormRoomPopLayer.getInstance() then
								DormRoomPopLayer.getInstance():updateDressUI()
								DormRoomPopLayer.getInstance():updateFavorBar()
							end
						end
					})
				elseif item_data[model_data[self.dressPanel.selectOrder].itemid].targetlayer1 then
					LayerManager:pushInLayer("PopGoGainLayer", {
						item = model_data[self.dressPanel.selectOrder].itemid
					})
				else
					global_ShowBlockWords(L_CURRENT_SKIN_UNBLE_TO_BUY)
				end

				return
			end
		else
			var_69_0 = -1
		end

		arg_69_0:setTouchEnabled(false)

		local var_69_5 = playermodel.dress[self.soulid] == -1 and major_factor_data[self.soulid].model or item_data[playermodel.dress[self.soulid]].model

		dormitory_manager:changeSoulDress(self.soulid, var_69_0, function(arg_73_0, arg_73_1)
			if arg_73_0 == 1 then
				if var_69_0 > 0 then
					self.modelid = item_data[var_69_0].model or major_factor_data[self.soulid].model
				end

				self:updateFavorBar()
				self:updateFavorPoolUI()

				local var_73_1 = self.dressPanel:getChildByName("ScrollView"):getChildByName(self.dressPanel.selectOrder)

				if var_73_1 and var_73_1.entityid then
					var_73_1:getChildByName("heightLight"):removeFromParent()

					if playermodel.dress[self.soulid] == var_73_1.entityid then
						var_73_1:getChildByName("used_skin"):setVisible(true)
					else
						var_73_1:getChildByName("used_skin"):setVisible(false)
					end
				end

				local var_73_2 = self.dressPanel:getChildByName("ScrollView"):getChildByName(var_69_5)

				if var_73_2 and var_73_2.entityid then
					if playermodel.dress[self.soulid] == var_73_2.entityid then
						var_73_2:getChildByName("used_skin"):setVisible(true)
					else
						var_73_2:getChildByName("used_skin"):setVisible(false)
					end
				end

				self.dressPanel.selectOrder = nil

				self.dressPanel:getChildByName("Button_dress_sure"):setVisible(false)
				self:switchShowPanelList("Panel_dress")

				if not arg_73_1 then
					self.roleBnt:insertTalk(ROLE_CONVERSATION_TYPE.changeDress)
				end
			end

			arg_69_0:setTouchEnabled(true)
		end)
	end)
end

function DormRoomLayer:selectDressOnGuide(arg_74_1)
	local var_74_0 = self.dressPanel:getChildByName("ScrollView")

	if not self.dressPanel:isVisible() or not var_74_0:isVisible() then
		return
	end

	local var_74_1 = var_74_0:getChildByName(arg_74_1)

	if not var_74_1 then
		return
	end

	var_74_0:jumpToPercentHorizontal(var_74_1:getPositionX() / var_74_0:getInnerContainerSize().width * 100)

	return var_74_1
end

function DormRoomLayer:ButtonDressSureOnGuide()
	if not self.dressPanel or not self.dressPanel:isVisible() then
		return
	end

	if self.dressPanel:getChildByName("Button_dress_sure") then
		if not self.dressPanel:getChildByName("Button_dress_sure"):isVisible() then
			return
		end
	end

	return self.dressPanel:getChildByName("Button_dress_sure")
end

function DormRoomLayer:updateCurDress(arg_76_1, arg_76_2)
	if arg_76_2 > 0 then
		self.modelid = item_data[arg_76_2].model or major_factor_data[self.soulid].model
	end

	self:updateFavorBar()
	self:updateFavorPoolUI()

	self.dressPanel.selectOrder = nil

	self.dressPanel:getChildByName("Button_dress_sure"):setVisible(false)
	self:switchShowPanelList("Panel_dress")

	if not isFavorUp then
		self.roleBnt:insertTalk(ROLE_CONVERSATION_TYPE.changeDress)
	end
end

function DormRoomLayer:updateDressUI()
	self.dressPanel:getChildByName("Button_dress_sure"):setVisible(false)
	self.dressPanel:getChildByName("ScrollView"):removeAllChildren()

	self.dressPanel.selectOrder = nil

	self:initDressList()
end

function DormRoomLayer:initDressList()
	local var_78_0 = 0
	local var_78_1 = -50
	local var_78_2 = self.dressPanel:getChildByName("ScrollView")
	local var_78_3 = dormitory_manager:getSoulDresses(self.soulid)

	while var_78_3[1] do
		local var_78_4

		if global_is_hide_skin_by_itemid(model_data[var_78_3[1]].itemid) then
			table.remove(var_78_3, 1)
		else
			var_78_4 = 1 + 1
		end
	end

	local var_78_5 = 1

	while var_78_3[var_78_5] do
		if var_78_3[var_78_5] == self.modelid then
			table.insert(var_78_3, 1, (table.remove(var_78_3, var_78_5)))

			break
		else
			var_78_5 = var_78_5 + 1
		end
	end

	var_78_2:setInnerContainerSize(cc.size(#var_78_3 * 130 < var_78_2:getContentSize().width and var_78_2:getContentSize().width or #var_78_3 * 130, var_78_2:getContentSize().height))

	for iter_78_0, iter_78_1 in pairs(var_78_3) do
		local var_78_6 = ccui.Button:create("Dormitory/dress_bg.png", "Dormitory/dress_bg.png", "Dormitory/dress_bg.png", var_0_21)

		var_78_6:setAnchorPoint(cc.p(1, 0.5))
		var_78_6:setScale(170 / var_78_6:getContentSize().height)
		var_78_6:setPosition(iter_78_0 * 130, var_78_2:getContentSize().height / 2)

		var_78_6.entityid = model_data[iter_78_1].itemid or -1

		var_78_6:setName(iter_78_1)
		var_78_2:addChild(var_78_6)

		local var_78_7 = ccui.Layout:create()

		var_78_7:setBackGroundImageColor(cc.c3b(255, 0, 0))
		var_78_7:setContentSize(cc.size(188, 244))
		var_78_7:setAnchorPoint(cc.p(0, 1))
		var_78_7:setPosition(cc.p(2, var_78_6:getContentSize().height - 3))
		var_78_7:setClippingEnabled(true)
		var_78_7:setBackGroundColor(cc.c3b(0, 0, 0))
		var_78_7:setName("clipLayer")
		var_78_6:addChild(var_78_7, 2)

		local var_78_8 = ccui.ImageView:create(PANEL_ROLE_IMAGE_PATH .. model_data[iter_78_1].role_image .. ".png")

		var_78_8:setScale(1)
		var_78_8:setAnchorPoint(cc.p(0.5, 0.5))
		var_78_8:setPosition(cc.p(var_78_7:getContentSize().width / 2 + var_78_0, var_78_7:getContentSize().height / 2 + var_78_1))
		var_78_8:setName("photo")
		var_78_7:addChild(var_78_8)
		assert(model_data[iter_78_1].main_name, "去揍策划, 此modelid:" .. iter_78_1 .. "没填main_name")

		local var_78_9 = cc.Label:createWithTTF(model_data[iter_78_1].main_name, FONT_NAME, 30)

		var_78_9:setPosition(cc.p(var_78_6:getContentSize().width / 2, 20))
		var_78_9:setName("nameLable")
		var_78_6:addChild(var_78_9)

		local var_78_10 = ccui.ImageView:create("Dormitory/used_skin.png", var_0_21)

		var_78_10:setPosition(cc.p(var_78_10:getContentSize().width / 2 + 15, var_78_6:getContentSize().height - var_78_10:getContentSize().height / 2 - 4))
		var_78_10:setName("used_skin")
		var_78_10:setVisible(false)
		var_78_10:setScale(math.max(var_78_6:getContentSize().height / 170, 1))
		var_78_6:addChild(var_78_10, 100)

		if playermodel.dress[self.soulid] == var_78_6.entityid then
			var_78_6:getChildByName("used_skin"):setVisible(true)
		else
			var_78_6:getChildByName("used_skin"):setVisible(false)
		end

		if var_78_6.entityid > 0 and not item_manager:haveItem(var_78_6.entityid) then
			var_78_6:setOpacity(180)

			local var_78_11
			local var_78_13 = false
			local var_78_14

			if dormitory_manager.skinshops.skin[self.soulid] and dormitory_manager.skinshops.skin[self.soulid][iter_78_1] then
				var_78_14 = dormitory_manager.skinshops.skin[self.soulid][iter_78_1]
			elseif dormitory_manager.skinshops.skin_package[self.soulid] and dormitory_manager.skinshops.skin_package[self.soulid][iter_78_1] then
				var_78_14 = dormitory_manager.skinshops.skin_package[self.soulid][iter_78_1]
			end

			if var_78_14 then
				if var_78_14.shopinfo.discount and var_78_14.shopinfo.discount < var_78_14.shopinfo.price or var_78_14.shopinfo.discount2 and var_78_14.shopinfo.discount2 < var_78_14.shopinfo.price2 then
					var_78_11 = "Dormitory/discount_logo.png"
					var_78_13 = true
				else
					var_78_11 = item_data[var_78_6.entityid].is_birth and "Dormitory/logo_bg.png" or shop_data[var_78_14.shopinfo.shopid].is_new and "Dormitory/logo_bg.png" or "Dormitory/logo_bg.png"
				end
			elseif item_data[var_78_6.entityid].is_birth then
				var_78_11 = "Dormitory/logo_bg.png"
			elseif item_data[var_78_6.entityid].targetlayer1 and item_data[var_78_6.entityid].targetlayer1 ~= "-1" then
				var_78_11 = "Dormitory/logo_bg.png"
			end

			if var_78_11 then
				local var_78_15 = ccui.ImageView:create(var_78_11, var_0_21)

				var_78_15:setAnchorPoint(cc.p(0, 1))
				var_78_15:setScale(var_78_6:getContentSize().height / 170)
				var_78_15:setPosition(0, var_78_6:getContentSize().height)
				var_78_6:addChild(var_78_15, 9)

				if var_78_13 == false then
					local var_78_16 = ccui.Text:create(item_data[var_78_6.entityid].logo_str or "", FONT_NAME, 22)

					var_78_16:setPosition(cc.p(30, 18))
					var_78_15:addChild(var_78_16)
				end
			end
		else
			var_78_6:setOpacity(255)
			print("没有推荐信息," .. "modelid======" .. iter_78_1 .. "id======" .. var_78_6.entityid)
		end

		var_78_6:addTouchEventListener(function(arg_79_0, arg_79_1)
			if arg_79_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self.isCanChangePanel then
				return
			end

			if self.dressPanel.selectOrder == iter_78_1 then
				return
			end

			if self.switchDressIslock then
				return
			end

			self.switchDressIslock = true

			self.dressPanel:switchDress(iter_78_1, function()
				self.switchDressIslock = false
			end)
		end)
	end

	function self.dressPanel.haveDress(arg_81_0, arg_81_1)
		return self.dressPanel:getChildByName("ScrollView"):getChildByName(arg_81_1) ~= nil
	end

	function self.dressPanel:switchDress(arg_82_1, arg_82_2)
		local var_82_0 = self.dressPanel:getChildByName("ScrollView")
		local var_82_1 = var_82_0:getChildByName(arg_82_1)

		self.dressPanel:getChildByName("Button_dress_sure"):setVisible(true)

		if arg_82_1 == self.modelid then
			self.roleBnt:setTalkEnabled(true)
			self.dressPanel:getChildByName("Button_dress_sure"):loadTextures("public/button/equipped_btn.png", "public/button/equipped_btn.png", "public/button/equipped_btn.png", var_0_21)
		else
			if model_data[arg_82_1].itemid and not item_manager:haveItem(model_data[arg_82_1].itemid) then
				if dormitory_manager.skinshops.skin[self.soulid] and dormitory_manager.skinshops.skin[self.soulid][arg_82_1] then
					self.dressPanel:getChildByName("Button_dress_sure"):loadTextures("public/button/buy_btn.png", "public/button/buy_btn.png", "public/button/buy_btn.png", var_0_21)
				else
					self.dressPanel:getChildByName("Button_dress_sure"):loadTextures("public/button/buy_btn.png", "public/button/buy_btn.png", "public/button/buy_btn.png", var_0_21)
				end

				self.roleBnt:setTalkEnabled((var_0_23[arg_82_1] or 0) < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
			else
				self.dressPanel:getChildByName("Button_dress_sure"):loadTextures("public/button/change_dress_btn.png", "public/button/change_dress_btn.png", "public/button/change_dress_btn.png", var_0_21)
				self.roleBnt:setTalkEnabled(true)
			end

			AnalyticManager.dorm_click_dress({
				soulid = self.soulid,
				itemid = model_data[arg_82_1].itemid
			})
		end

		if self.selectOrder then
			local var_82_2 = var_82_0:getChildByName(self.selectOrder)

			if var_82_2 and var_82_2.entityid then
				var_82_2:getChildByName("heightLight"):removeFromParent()
			end
		end

		local var_82_5 = ccui.Layout:create()
		local var_82_6 = {}

		for iter_82_0 = 1, 2 do
			if iter_82_0 == 1 then
				if config._DEBUG then
					var_82_6[iter_82_0] = cc.Sprite:create("Dormitory/new_item_bg_on2.png") or cc.Sprite:createWithSpriteFrameName("Dormitory/new_item_bg_on2.png")
				end

				var_82_6[iter_82_0]:setScale(1.1)
				var_82_6[iter_82_0]:setOpacity(0)
				var_82_6[iter_82_0]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)))))
			else
				if config._DEBUG then
					var_82_6[iter_82_0] = cc.Sprite:create("Dormitory/new_item_bg_on2.png") or cc.Sprite:createWithSpriteFrameName("Dormitory/new_item_bg_on2.png")
				end

				var_82_6[iter_82_0]:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Spawn:create(cc.FadeOut:create(0.6), cc.ScaleTo:create(0.6, 1.1)), cc.Spawn:create(cc.FadeIn:create(1), cc.ScaleTo:create(1, 1)), cc.Spawn:create(cc.FadeOut:create(1), cc.ScaleTo:create(1, 1.1)), cc.Spawn:create(cc.FadeIn:create(0.6), cc.ScaleTo:create(0.6, 1)))))
			end

			var_82_6[iter_82_0]:setPosition(var_82_1:getContentSize().width / 2 - 3, var_82_1:getContentSize().height / 2)
			var_82_5:addChild(var_82_6[iter_82_0])
		end

		var_82_5:setName("heightLight")
		var_82_1:addChild(var_82_5)

		if arg_82_1 ~= self.roleBnt._modelid then
			self.roleBnt:update(arg_82_1, arg_82_2)
		elseif arg_82_2 then
			arg_82_2()
		end

		self.selectOrder = arg_82_1

		GuideListener.cleanCurGuides()
		GuideListener.swallowEvent(false)
		GuideListener.lockGuideTrigger(false)
		GuideListener.updateGuides(self)
	end
end

function DormRoomLayer:updateFavorBar()
	self.favor_exp:setString(playermodel.favor[self.soulid].favordegree .. "/" .. favor_data[playermodel.favor[self.soulid].favorlevel].experience)
	self.favor_lv:setString(playermodel.favor[self.soulid].favorlevel)
	self.favor_bar:setPercent(math.floor(100 * playermodel.favor[self.soulid].favordegree / favor_data[playermodel.favor[self.soulid].favorlevel].experience))

	if dormitory_manager:is_favor_max(self.soulid) then
		self.favor_exp:setString("满")
		self.favor_bar:setPercent(100)
	end
end

function DormRoomLayer:initRole()
	if self.isout then
		return
	end

	self.roleBnt = ShowGirlLayer:create(self.modelid, 2)

	self.rootLayer:addChild(self.roleBnt)
	self.roleBnt:setTouchTalkCallback(function()
		var_0_23[self.roleBnt._modelid] = var_0_23[self.roleBnt._modelid] and var_0_23[self.roleBnt._modelid] + 1 or 1

		if var_0_23[self.roleBnt._modelid] >= PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT and model_data[self.roleBnt._modelid].itemid and not item_manager:haveItem(model_data[self.roleBnt._modelid].itemid) then
			self.roleBnt:setTalkEnabled(false)
			global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)
		end
	end)
end

function DormRoomLayer:updateRole()
	if self.isout then
		if self.roleBnt then
			self.roleBnt:setVisible(false)
		end
	elseif self.roleBnt then
		self.roleBnt:setVisible(true)
		self.roleBnt:update(self.modelid)
		self.roleBnt:setTalkEnabled(true)
	else
		self.roleBnt = ShowGirlLayer:create(self.modelid, 2)

		self.rootLayer:addChild(self.roleBnt)
		self.roleBnt:setTouchTalkCallback(function()
			var_0_23[self.roleBnt._modelid] = var_0_23[self.roleBnt._modelid] and var_0_23[self.roleBnt._modelid] + 1 or 1

			if var_0_23[self.roleBnt._modelid] >= PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT and model_data[self.roleBnt._modelid].itemid and not item_manager:haveItem(model_data[self.roleBnt._modelid].itemid) then
				self.roleBnt:setTalkEnabled(false)
				global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)
			end
		end)
	end
end

function DormRoomLayer:initConversationTable(arg_88_1)
	self.dialogTable = {}
	self.lineNum = 1

	local var_88_0

	if arg_88_1 == ROLE_CONVERSATION_TYPE.dormDaily then
		self.talkType = "daily"
		var_88_0 = self.soulid * 10000 + arg_88_1 * 100 + playermodel.favor[self.soulid].favorlevel
	elseif arg_88_1 == ROLE_CONVERSATION_TYPE.dormFirst then
		self.talkType = "first"
		var_88_0 = self.soulid * 100 + arg_88_1
	elseif arg_88_1 == ROLE_CONVERSATION_TYPE.dormTouch then
		self.talkType = "touch"
		var_88_0 = self.soulid * 10000 + arg_88_1 * 100 + playermodel.favor[self.soulid].favorlevel
	elseif arg_88_1 == ROLE_CONVERSATION_TYPE.angry then
		self.talkType = "angry"
		var_88_0 = self.soulid * 100 + arg_88_1
	else
		self.talkType = "explore"
		var_88_0 = arg_88_1
	end

	local var_88_1 = {}

	assert(conversation_type_data[var_88_0], "ID:" .. var_88_0 .. "is nil")

	while conversation_type_data[var_88_0]["class" .. 1] do
		var_88_1[#var_88_1 + 1] = conversation_type_data[var_88_0]["class" .. 1]
	end

	local var_88_3 = var_88_1[math.random(1, #var_88_1)]

	while conversation_class_data[var_88_3]["conversation" .. 1] do
		table.insert(self.dialogTable, role_conversation_data[conversation_class_data[var_88_3]["conversation" .. 1]])
	end
end

function DormRoomLayer.playTalkEffect(arg_89_0, arg_89_1, arg_89_2)
	local var_89_0 = false

	if arg_89_1.black_screen then
		(function(arg_90_0)
			var_89_0 = true

			arg_89_0.effectPanel:setBackGroundColor(cc.c3b(0, 0, 0))
			arg_89_0.effectPanel:setBackGroundColorOpacity(255)
			arg_89_0.effectPanel:setOpacity(255)
			arg_89_0.effectPanel:runAction(cc.Sequence:create(cc.Blink:create(arg_90_0, 1), cc.FadeOut:create(arg_90_0), cc.CallFunc:create(arg_89_2)))
		end)(arg_89_1.black_screen_time)
	end

	if arg_89_1.shock_screen then
		(function(arg_91_0, arg_91_1)
			var_89_0 = true

			local var_91_0 = {}

			for iter_91_0 = 1, 3 do
				var_91_0[iter_91_0] = cc.Sequence:create(cc.MoveBy:create(0.05 / (iter_91_0 * iter_91_0), cc.p(arg_91_0 * 10 / iter_91_0, arg_91_1 * 10 / iter_91_0)), cc.MoveBy:create(0.05 / (iter_91_0 * iter_91_0), cc.p(-(arg_91_0 * 10 / iter_91_0), -(arg_91_1 * 10 / iter_91_0))), cc.MoveBy:create(0.05 / (iter_91_0 * iter_91_0), cc.p(-(arg_91_0 * 10 / iter_91_0), -(arg_91_1 * 10 / iter_91_0))), cc.MoveBy:create(0.05 / (iter_91_0 * iter_91_0), cc.p(arg_91_0 * 10 / iter_91_0, arg_91_1 * 10 / iter_91_0)))
			end

			arg_89_0.background:runAction(cc.Sequence:create(var_91_0[1], var_91_0[2], var_91_0[3], cc.CallFunc:create(arg_89_2)))
		end)(2, 5)
	end

	if arg_89_1.splash_screen then
		(function(arg_92_0)
			var_89_0 = true

			arg_89_0.effectPanel:setBackGroundColor(cc.c3b(255, 255, 255))
			arg_89_0.effectPanel:setBackGroundColorOpacity(255)
			arg_89_0.effectPanel:setOpacity(255)
			arg_89_0.effectPanel:runAction(cc.Sequence:create(cc.Blink:create(arg_92_0, 1), cc.FadeOut:create(arg_92_0), cc.CallFunc:create(arg_89_2)))
		end)(arg_89_1.splash_screen_time)
	end

	if false == false then
		arg_89_2()
	end
end

function DormRoomLayer:hideUIPanel()
	self.uiPanel:stopAllActions()
	self.uiPanel:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		self.uiPanel:getChildByName("Button_return"):setTouchEnabled(false)

		self.iscanswitch = false
	end), cc.FadeOut:create(1), cc.Hide:create()))
end

function DormRoomLayer:showUIPanel()
	self.uiPanel:stopAllActions()
	self.uiPanel:runAction(cc.Sequence:create(cc.Show:create(), cc.FadeIn:create(1), cc.CallFunc:create(function()
		self.uiPanel:getChildByName("Button_return"):setTouchEnabled(true)

		self.iscanswitch = true
	end)))
end

local function var_0_40(arg_97_0)
	local var_97_0 = require("data.favor_thing_data")[arg_97_0]
	local var_97_1 = {}

	while var_97_0["level_" .. 1] do
		var_97_1[1] = {
			level = var_97_0["level_" .. 1],
			des = var_97_0["des_" .. 1],
			drop = var_97_0["drop_" .. 1],
			classification = {}
		}

		for iter_97_0 in var_97_0["classification_" .. 1]:gmatch("([^#]+)") do
			table.insert(var_97_1[1].classification, tonumber(iter_97_0))
		end
	end

	return var_97_1
end

function DormRoomLayer:uiFavorThing()
	self.favorThingPanel:setVisible(true)
	global_window_open_action(self.favorThingBg)

	local var_98_0 = self.favorThingBg:getChildByName("listview")
	local var_98_1 = self.favorThingBg:getChildByName("button_favor")

	var_98_0:setItemsMargin(5)
	var_98_0:setContentSize(cc.size(var_98_0:getContentSize().width, var_98_0:getContentSize().height + 15))
	var_98_0:setPositionY(var_98_0:getPositionY() - 15)
	var_98_1:retain()
	var_98_1:removeFromParent()

	self.buttonFavor = var_98_1
	self.favorThingSlot = {}
	self.favorThingInitTag = true

	local var_98_2 = var_0_40(self.soulid)

	;(function(arg_99_0, arg_99_1)
		for iter_99_0 = 1, #arg_99_0 do
			local var_99_0 = self.buttonFavor:clone()
			local var_99_1 = ccui.Helper:seekWidgetByName(var_99_0, "tag")
			local var_99_2 = ccui.Helper:seekWidgetByName(var_99_0, "label_des")
			local var_99_3 = ccui.Helper:seekWidgetByName(var_99_0, "Image_54")

			var_99_3:setScale9Enabled(true)
			var_99_1:loadTexture(var_0_36[iter_99_0], var_0_21)
			var_99_2:setString(arg_99_0[iter_99_0].des)

			local var_99_4 = 69
			local var_99_5 = 20
			local var_99_6 = drop_data[arg_99_0[iter_99_0].drop]

			if drop_data[arg_99_0[iter_99_0].drop].diamond and var_99_6.drop_id1 then
				var_99_3:setContentSize(cc.size(var_99_3:getContentSize().width, var_99_3:getContentSize().height + 40))

				var_99_4 = 75
				var_99_5 = 30
			end

			if var_99_6.diamond then
				local var_99_7 = ccui.ImageView:create(IMAGE_DIAMOND, var_0_21)

				var_99_7:setAnchorPoint(cc.p(0, 1))
				var_99_7:setPosition(cc.p(5, var_99_4))

				var_99_4 = var_99_4 - var_99_5

				var_99_3:addChild(var_99_7)

				local var_99_8 = cc.Label:createWithTTF("x" .. var_99_6.diamond, FONT_NAME, 18)

				var_99_8:setAnchorPoint(cc.p(0, 0.5))
				var_99_8:setPosition(cc.p(var_99_7:getContentSize().width + 1, var_99_7:getContentSize().height / 2))
				var_99_7:addChild(var_99_8)
			end

			if var_99_6.gold then
				local var_99_9 = ccui.ImageView:create(IMAGE_GOLD, var_0_21)

				var_99_9:setAnchorPoint(cc.p(0, 1))

				if not var_99_6.diamond or var_99_6.diamond == 0 then
					var_99_9:setPosition(cc.p(5, 65))
				else
					var_99_9:setPosition(cc.p(5, 35))
				end

				var_99_3:addChild(var_99_9)

				local var_99_10 = cc.Label:createWithTTF("x" .. var_99_6.gold, FONT_NAME, 18)

				var_99_10:setAnchorPoint(cc.p(0, 0.5))
				var_99_10:setPosition(cc.p(var_99_9:getContentSize().width, var_99_9:getContentSize().height / 2))
				var_99_9:addChild(var_99_10)
			end

			local var_99_11 = 1

			while var_99_6["drop_id" .. var_99_11] do
				local var_99_12 = ccui.ImageView:create("public/currency/" .. item_data[var_99_6["drop_id" .. var_99_11]].image_id .. ".png", var_0_21)

				var_99_12:setAnchorPoint(cc.p(0, 1))

				if item_data[var_99_6["drop_id" .. var_99_11]].image_id == 6800101 then
					var_99_12:setScale(0.3)
				else
					var_99_12:setScale(0.8)
				end

				var_99_12:setPosition(cc.p(15, var_99_4))
				var_99_3:addChild(var_99_12)

				local var_99_13 = cc.Label:createWithTTF("x" .. var_99_6["drop_num" .. var_99_11], FONT_NAME, 18)

				var_99_13:setAnchorPoint(cc.p(0, 0.5))
				var_99_13:setPosition(cc.p(var_99_12:getContentSize().width, var_99_12:getContentSize().height / 2))

				if item_data[var_99_6["drop_id" .. var_99_11]].image_id == 6800101 then
					var_99_13:setScale(3.3333333333333335)
				end

				var_99_12:addChild(var_99_13)

				var_99_11 = var_99_11 + 1
				var_99_4 = var_99_4 - 30
			end

			if playermodel.favor[self.soulid].favorlevel < arg_99_0[iter_99_0].level then
				local var_99_14 = ccui.Layout:create()

				var_99_14:setContentSize(cc.size(var_99_0:getContentSize().width - 10, var_99_0:getContentSize().height - 10))
				var_99_14:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
				var_99_14:setBackGroundColor(cc.c3b(0, 0, 0))
				var_99_14:setOpacity(120)
				var_99_14:setAnchorPoint(cc.p(0.5, 0.5))
				var_99_14:setPosition(cc.p(var_99_0:getContentSize().width / 2 + 2, var_99_0:getContentSize().height / 2 + 10 / 2))
				var_99_14:setTouchEnabled(false)
				var_99_14:setName("layout")
				var_99_0:addChild(var_99_14)

				local var_99_15 = ccui.ImageView:create(var_0_37, var_0_21)

				var_99_15:setAnchorPoint(cc.p(0.5, 0.5))
				var_99_15:setPosition(cc.p(43, var_99_0:getContentSize().height / 2 + 10))
				var_99_15:setCascadeOpacityEnabled(false)
				var_99_14:addChild(var_99_15)

				local var_99_16 = cc.Label:createWithTTF("", FONT_NAME, 24)

				var_99_16:setString("等级" .. arg_99_0[iter_99_0].level)
				var_99_16:setAnchorPoint(cc.p(0.5, 1))
				var_99_16:setPosition(cc.p(var_99_15:getContentSize().width / 2, -10))
				var_99_15:addChild(var_99_16)
				var_99_0:addTouchEventListener(function(arg_100_0, arg_100_1)
					if arg_100_1 ~= ccui.TouchEventType.ended then
						return
					end

					global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Button_Lock)
				end)
			else
				local var_99_17 = ccui.Layout:create()

				var_99_17:setContentSize(cc.size(var_99_3:getContentSize().width, var_99_3:getContentSize().height))
				var_99_17:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
				var_99_17:setBackGroundColor(cc.c3b(0, 0, 0))
				var_99_17:setOpacity(120)
				var_99_17:setAnchorPoint(cc.p(0.5, 0.5))
				var_99_17:setPosition(cc.p(var_99_3:getContentSize().width / 2, var_99_3:getContentSize().height / 2))
				var_99_3:addChild(var_99_17, 5)

				local var_99_18 = ccui.ImageView:create(var_0_38, var_0_21)

				var_99_18:setAnchorPoint(cc.p(0.5, 0.5))
				var_99_18:setPosition(cc.p(var_99_17:getContentSize().width / 2, var_99_17:getContentSize().height / 2))
				var_99_18:setCascadeOpacityEnabled(false)
				var_99_17:addChild(var_99_18)
				var_99_0:addTouchEventListener(function(arg_101_0, arg_101_1)
					if arg_101_1 ~= ccui.TouchEventType.ended then
						return
					end

					self:TalkPop(arg_99_0[iter_99_0].classification)
				end)
			end

			arg_99_1:pushBackCustomItem(var_99_0)

			self.favorThingSlot[iter_99_0] = var_99_0
		end
	end)(var_98_2, var_98_0)

	self.favorThingData = var_98_2
	self.favorThingPanel.soulid = self.soulid

	if config._DEBUG then
		local network = require("network.network")
		local var_98_4 = ccui.Button:create("GUI/button.png", nil, "GUI/button.png", var_0_21)

		var_98_4:setTitleText(L_DORMROOM_DEBUG_FAVOR)
		var_98_4:setPosition(320, 200)
		self.favorThingPanel:addChild(var_98_4)
		var_98_4:addTouchEventListener(function(arg_102_0, arg_102_1)
			if arg_102_1 ~= ccui.TouchEventType.ended then
				return
			end

			network:rpc("add_favor_degree", {
				favor = 100,
				soulid = self.soulid
			}, function(arg_103_0)
				if arg_103_0.result == 1 then
					if arg_103_0.favorlevel > playermodel.favor[self.soulid].favorlevel then
						self:triggerFavorUpTalk(self.soulid, playermodel.favor[self.soulid].favorlevel, arg_103_0.plotinfo)
					end

					playermodel.favor[self.soulid].favorlevel = arg_103_0.favorlevel
					playermodel.favor[self.soulid].favordegree = arg_103_0.favordegree

					self:updateFavorBar()
					self:updateFavorPoolUI()
				end
			end)
		end)
	end
end

function DormRoomLayer:uiFavorThingUpdate()
	if self.favorThingPanel.soulid == self.soulid then
		for iter_104_0 = 1, #self.favorThingSlot do
			if playermodel.favor[self.soulid].favorlevel >= self.favorThingData[iter_104_0].level and self.favorThingSlot[iter_104_0]:getChildByName("layout") then
				self.favorThingSlot[iter_104_0]:getChildByName("layout"):removeFromParent()

				local var_104_0 = ccui.Helper:seekWidgetByName(self.favorThingSlot[iter_104_0], "Image_54")
				local var_104_1 = ccui.Layout:create()

				var_104_1:setContentSize(cc.size(var_104_0:getContentSize().width, var_104_0:getContentSize().height))
				var_104_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
				var_104_1:setBackGroundColor(cc.c3b(0, 0, 0))
				var_104_1:setOpacity(120)
				var_104_1:setAnchorPoint(cc.p(0.5, 0.5))
				var_104_1:setPosition(cc.p(var_104_0:getContentSize().width / 2, var_104_0:getContentSize().height / 2))
				var_104_0:addChild(var_104_1, 5)

				local var_104_2 = ccui.ImageView:create(var_0_38, var_0_21)

				var_104_2:setAnchorPoint(cc.p(0.5, 0.5))
				var_104_2:setPosition(cc.p(var_104_1:getContentSize().width / 2, var_104_1:getContentSize().height / 2))
				var_104_2:setCascadeOpacityEnabled(false)
				var_104_1:addChild(var_104_2)
				self.favorThingSlot[iter_104_0]:addTouchEventListener(function(arg_105_0, arg_105_1)
					if arg_105_1 ~= ccui.TouchEventType.ended then
						return
					end

					self:TalkPop(self.favorThingData[iter_104_0].classification)
				end)
			end
		end
	else
		self.favorThingPanel.soulid = self.soulid

		local var_104_3 = var_0_40(self.soulid)

		for iter_104_1 = 1, #self.favorThingSlot do
			local var_104_4 = ccui.Helper:seekWidgetByName(self.favorThingSlot[iter_104_1], "tag")
			local var_104_5 = ccui.Helper:seekWidgetByName(self.favorThingSlot[iter_104_1], "label_des")
			local var_104_6 = ccui.Helper:seekWidgetByName(self.favorThingSlot[iter_104_1], "Image_54")

			var_104_6:setScale9Enabled(true)
			var_104_4:loadTexture(var_0_36[iter_104_1], var_0_21)
			var_104_5:setString(var_104_3[iter_104_1].des)

			if self.favorThingSlot[iter_104_1]:getChildByName("layout") then
				self.favorThingSlot[iter_104_1]:getChildByName("layout"):removeFromParent()
			end

			var_104_6:removeAllChildren()

			local var_104_7 = 69
			local var_104_8 = 20
			local var_104_9 = drop_data[var_104_3[iter_104_1].drop]

			if drop_data[var_104_3[iter_104_1].drop].diamond and var_104_9.drop_id1 then
				var_104_6:setContentSize(cc.size(var_104_6:getContentSize().width, var_104_6:getContentSize().height + 40))

				var_104_7 = 75
				var_104_8 = 30
			end

			if var_104_9.diamond then
				local var_104_10 = ccui.ImageView:create(IMAGE_DIAMOND, var_0_21)

				var_104_10:setAnchorPoint(cc.p(0, 1))
				var_104_10:setPosition(cc.p(5, var_104_7))

				var_104_7 = var_104_7 - var_104_8

				var_104_6:addChild(var_104_10)

				local var_104_11 = cc.Label:createWithTTF("x" .. var_104_9.diamond, FONT_NAME, 18)

				var_104_11:setAnchorPoint(cc.p(0, 0.5))
				var_104_11:setPosition(cc.p(var_104_10:getContentSize().width + 1, var_104_10:getContentSize().height / 2))
				var_104_10:addChild(var_104_11)
			end

			if var_104_9.gold then
				local var_104_12 = ccui.ImageView:create(IMAGE_GOLD, var_0_21)

				var_104_12:setAnchorPoint(cc.p(0, 1))

				if not var_104_9.diamond or var_104_9.diamond == 0 then
					var_104_12:setPosition(cc.p(5, 65))
				else
					var_104_12:setPosition(cc.p(5, 35))
				end

				var_104_6:addChild(var_104_12)

				local var_104_13 = cc.Label:createWithTTF("x" .. var_104_9.gold, FONT_NAME, 18)

				var_104_13:setAnchorPoint(cc.p(0, 0.5))
				var_104_13:setPosition(cc.p(var_104_12:getContentSize().width, var_104_12:getContentSize().height / 2))
				var_104_12:addChild(var_104_13)
			end

			local var_104_14 = 1

			while var_104_9["drop_id" .. var_104_14] do
				local var_104_15 = ccui.ImageView:create("public/currency/" .. item_data[var_104_9["drop_id" .. var_104_14]].image_id .. ".png", var_0_21)

				var_104_15:setAnchorPoint(cc.p(0, 1))

				if item_data[var_104_9["drop_id" .. var_104_14]].image_id == 6800101 then
					var_104_15:setScale(0.3)
				else
					var_104_15:setScale(0.8)
				end

				var_104_15:setPosition(cc.p(15, var_104_7))
				var_104_6:addChild(var_104_15)

				local var_104_16 = cc.Label:createWithTTF("x" .. var_104_9["drop_num" .. var_104_14], FONT_NAME, 18)

				var_104_16:setAnchorPoint(cc.p(0, 0.5))
				var_104_16:setPosition(cc.p(var_104_15:getContentSize().width, var_104_15:getContentSize().height / 2))

				if item_data[var_104_9["drop_id" .. var_104_14]].image_id == 6800101 then
					var_104_16:setScale(3.3333333333333335)
				end

				var_104_15:addChild(var_104_16)

				var_104_14 = var_104_14 + 1
				var_104_7 = var_104_7 - 30
			end

			if playermodel.favor[self.soulid].favorlevel < var_104_3[iter_104_1].level then
				local var_104_17 = ccui.Layout:create()

				var_104_17:setContentSize(cc.size(self.favorThingSlot[iter_104_1]:getContentSize().width - 10, self.favorThingSlot[iter_104_1]:getContentSize().height - 10))
				var_104_17:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
				var_104_17:setBackGroundColor(cc.c3b(0, 0, 0))
				var_104_17:setOpacity(120)
				var_104_17:setAnchorPoint(cc.p(0.5, 0.5))
				var_104_17:setPosition(cc.p(self.favorThingSlot[iter_104_1]:getContentSize().width / 2 + 2, self.favorThingSlot[iter_104_1]:getContentSize().height / 2 + 10 / 2))
				var_104_17:setTouchEnabled(false)
				var_104_17:setName("layout")
				self.favorThingSlot[iter_104_1]:addChild(var_104_17)

				local var_104_18 = ccui.ImageView:create(var_0_37, var_0_21)

				var_104_18:setAnchorPoint(cc.p(0.5, 0.5))
				var_104_18:setPosition(cc.p(43, self.favorThingSlot[iter_104_1]:getContentSize().height / 2 + 10))
				var_104_18:setCascadeOpacityEnabled(false)
				var_104_17:addChild(var_104_18)

				local var_104_19 = cc.Label:createWithTTF("", FONT_NAME, 24)

				var_104_19:setString("等级" .. var_104_3[iter_104_1].level)
				var_104_19:setAnchorPoint(cc.p(0.5, 1))
				var_104_19:setPosition(cc.p(var_104_18:getContentSize().width / 2, -10))
				var_104_18:addChild(var_104_19)
				self.favorThingSlot[iter_104_1]:addTouchEventListener(function(arg_106_0, arg_106_1)
					if arg_106_1 ~= ccui.TouchEventType.ended then
						return
					end

					global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Button_Lock)
				end)
			else
				local var_104_20 = ccui.Layout:create()

				var_104_20:setContentSize(cc.size(var_104_6:getContentSize().width, var_104_6:getContentSize().height))
				var_104_20:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
				var_104_20:setBackGroundColor(cc.c3b(0, 0, 0))
				var_104_20:setOpacity(120)
				var_104_20:setAnchorPoint(cc.p(0.5, 0.5))
				var_104_20:setPosition(cc.p(var_104_6:getContentSize().width / 2, var_104_6:getContentSize().height / 2))
				var_104_6:addChild(var_104_20, 5)

				local var_104_21 = ccui.ImageView:create(var_0_38, var_0_21)

				var_104_21:setAnchorPoint(cc.p(0.5, 0.5))
				var_104_21:setPosition(cc.p(var_104_20:getContentSize().width / 2, var_104_20:getContentSize().height / 2))
				var_104_21:setCascadeOpacityEnabled(false)
				var_104_20:addChild(var_104_21)
				self.favorThingSlot[iter_104_1]:addTouchEventListener(function(arg_107_0, arg_107_1)
					if arg_107_1 ~= ccui.TouchEventType.ended then
						return
					end

					self:TalkPop(var_104_3[iter_104_1].classification)
				end)
			end
		end
	end

	self.favorThingPanel:setVisible(true)
	global_window_open_action(self.favorThingBg)
end

function DormRoomLayer:triggerFavorUpTalk(arg_108_1, arg_108_2, arg_108_3)
	local function var_108_0()
		if favor_data[arg_108_2]["favor_up_talk" .. arg_108_1] then
			self:hideUIPanel()
			global_basic_scene:addChild(TalkLayer:create(favor_data[arg_108_2]["favor_up_talk" .. arg_108_1], nil, TALK_TYPE_FAVOR, "", function()
				if arg_108_3 and next(arg_108_3) ~= nil then
					global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Favor_Event_End, cc.c3b(132, 239, 55))
					LayerManager:removePopLayer()

					if DormitoryLayer.getInstance() then
						DormitoryLayer.getInstance().roomInfos[DormitoryLayer.getInstance().rooms[self.roomorder].index].state = 4

						DormitoryLayer.getInstance().rooms[self.roomorder]:updateConfig()
					end

					self:showUIPanel()
				else
					self:showUIPanel()
				end
			end), ZORDER_TALKLAYER)
			AnalyticManager.trigger_favor_plot({
				soulid = self.soulid,
				favorlevel = playermodel.favor[self.soulid].favorlevel
			})
		end

		self:showUIPanel()
	end

	if GenerateRoleConversationClass(self.modelid, ROLE_CONVERSATION_TYPE.favorUpgrade) then
		self:hideUIPanel()
		self.roleBnt:insertTalk(ROLE_CONVERSATION_TYPE.favorUpgrade)
		self.roleBnt:setTalkCallback(var_108_0)
	else
		var_108_0()
	end
end

function DormRoomLayer.getResidueTime(arg_111_0, arg_111_1)
	if not arg_111_1 then
		return "-1"
	end

	local var_111_5 = global_get_time_by_date(arg_111_1) - playermodel.onlineTime
	local var_111_6 = math.floor(var_111_5 / 24 / 3600)
	local var_111_7 = math.floor((var_111_5 - var_111_6 * 24 * 3600) / 3600)
	local var_111_8 = math.floor((var_111_5 - var_111_6 * 24 * 3600 - var_111_7 * 3600) / 60)

	return var_111_6 ~= 0 and string.format(L_TIME_TEXT[1], var_111_6, var_111_7) or var_111_7 ~= 0 and string.format(L_TIME_TEXT[2], var_111_7, var_111_8) or string.format(L_TIME_TEXT[3], var_111_8)
end

function DormRoomLayer.shopPop(arg_112_0, arg_112_1, arg_112_2, arg_112_3, arg_112_4)
	local var_112_1 = {
		function()
			return playermodel.gold
		end,
		[0] = function()
			return playermodel.diamond
		end,
		function()
			return playermodel.honor
		end,
		function()
			return playermodel.explorecoin
		end,
		[100] = function()
			return 0
		end
	}

	setmetatable(var_112_1, {
		__index = function(arg_118_0, arg_118_1)
			return function()
				return item_manager:getItemNumber(arg_118_1)
			end
		end
	})

	local var_112_2 = {
		"public/currency/UI_battleEnd_gold.png",
		[0] = "public/currency/UI_battleEnd_diamond.png",
		"public/currency/arenascene_dot_1.png",
		"public/currency/explorecoin.png",
		[1500001] = "public/currency/1500001_1.png",
		[100] = "public/currency/rmb_white.png"
	}

	setmetatable(var_112_2, {
		__index = function(arg_120_0, arg_120_1)
			return "public/currency/" .. item_data[arg_120_1].image_id .. ".png"
		end
	})

	local var_112_3 = {
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "HandOfMidasLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_GOLD
			})
		end,
		[0] = function()
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})
		end,
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ArenaLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_HORNOR
			})
		end,
		function()
			LayerManager:pushInLayer("PopGoLayer", {
				targetlayer = "ExploreMapLayer",
				labels = L_POPLAYER_SHOP_LABELS.SHOP_CURRENCY_EXPLORECOIN
			})
		end,
		[6800601] = function()
			LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
				targetlayer = "PopSupermarketLayer"
			})
		end
	}

	setmetatable(var_112_3, {
		__index = function(arg_126_0, arg_126_1)
			return function(arg_127_0)
				if not item_data[arg_127_0].targetlayer1 then
					global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[arg_126_1].name))

					return
				end

				if arg_127_0 then
					LayerManager:pushInLayer("PopGoGainLayer", {
						item = arg_127_0
					})
				end

				require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
			end
		end
	})

	local var_112_4 = {}

	local function var_112_5(arg_128_0)
		local var_128_0 = var_112_4

		if arg_128_0.result == 1 then
			if not arg_128_0.selectCoupon then
				shop_manager:shop_buy(var_112_4.shoptype, var_112_4.shopitem.shopid, function(arg_129_0)
					if arg_129_0 == 1 then
						arg_112_1.have_bought = arg_112_1.have_bought + var_128_0.curbuyTime
						arg_112_1.sell_out = arg_112_1.buy_limit and arg_112_1.buy_limit <= arg_112_1.have_bought

						if var_128_0.shopitem.bag_item_type == kITEM_SKIN or var_128_0.shopitem.bag_item_type == kITEM_SKIN_GIFT then
							arg_112_0.dressPanel:getChildByName("ScrollView"):getChildByName(item_data[var_128_0.shopitem.itemid].model):setOpacity(255)
							arg_112_0.dressPanel:getChildByName("Button_dress_sure"):loadTextures("public/button/change_dress_btn.png", "public/button/change_dress_btn.png", "public/button/change_dress_btn.png", var_0_21)
							arg_112_0.roleBnt:setTalkEnabled(true)
							AnalyticManager.dorm_buy_dress_success({
								soulid = arg_112_0.soulid,
								itemid = var_128_0.shopitem.itemid
							})
						else
							arg_112_0.giftPanel:getChildByName("ScrollView"):removeAllChildren()

							arg_112_0.giftPanel.selectOrder = nil

							arg_112_0:initGiftList()
						end

						if item_data[var_128_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_128_0.itemid), 1000)
						end

						if var_128_0.callback then
							var_128_0.callback()
						end
					elseif arg_129_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
						audio_manager:playeffectMusicTest("sound/invalid")
					elseif arg_129_0 == 3 then
						var_112_3[var_128_0.shopitem.currency]()
					end
				end, var_112_4.curbuyTime, function()
					LayerManager:removePopLayer()
				end)
			else
				shop_manager:shop_buy_with_ticket(var_112_4.shoptype, var_112_4.shopitem.shopid, function(arg_131_0)
					if arg_131_0 == 1 then
						arg_112_1.have_bought = arg_112_1.have_bought + var_128_0.curbuyTime
						arg_112_1.sell_out = arg_112_1.buy_limit and arg_112_1.buy_limit <= arg_112_1.have_bought

						if var_128_0.shopitem.bag_item_type == kITEM_SKIN or var_128_0.shopitem.bag_item_type == kITEM_SKIN_GIFT then
							arg_112_0.dressPanel:getChildByName("ScrollView"):getChildByName(item_data[var_128_0.shopitem.itemid].model):setOpacity(255)
							arg_112_0.dressPanel:getChildByName("Button_dress_sure"):loadTextures("public/button/change_dress_btn.png", "public/button/change_dress_btn.png", "public/button/change_dress_btn.png", var_0_21)
							arg_112_0.roleBnt:setTalkEnabled(true)
							AnalyticManager.dorm_buy_dress_success({
								soulid = arg_112_0.soulid,
								itemid = var_128_0.shopitem.itemid
							})
						else
							arg_112_0.giftPanel:getChildByName("ScrollView"):removeAllChildren()

							arg_112_0.giftPanel.selectOrder = nil

							arg_112_0:initGiftList()
						end

						if item_data[var_128_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_128_0.itemid), 1000)
						end

						if var_128_0.callback then
							var_128_0.callback()
						end
					elseif arg_131_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
						audio_manager:playeffectMusicTest("sound/invalid")
					elseif arg_131_0 == 3 then
						var_112_3[var_128_0.shopitem.currency]()
					end
				end, var_112_4.curbuyTime, function()
					LayerManager:removePopLayer()
				end, arg_128_0.selectCoupon, 1)
			end
		end
	end

	local function var_112_6(arg_133_0)
		if not arg_133_0.currency2 or discount_manager:getLastPriceByItem(arg_133_0.itemid, arg_133_0.currency2, arg_133_0.discount2) < arg_133_0.discount2 then
			return true
		end

		return false
	end

	local function var_112_7(arg_140_0)
		local var_140_0 = {}

		if arg_140_0.currency2 then
			var_140_0.currency2 = arg_140_0.currency2
			var_140_0.costIcon2 = var_112_2[arg_140_0.currency2]
			var_140_0.cost2 = arg_140_0.discount2 or arg_140_0.price2
			var_140_0.cost_old2 = arg_140_0.price2
			var_140_0.discount2 = arg_140_0.discount2
		end

		var_140_0.name = item_data[arg_140_0.itemtype].name
		var_140_0.itemid = arg_140_0.itemtype
		var_140_0.shopid = arg_140_0.shopid
		var_140_0.costIcon = var_112_2[arg_140_0.currency]
		var_140_0.currency = arg_140_0.currency
		var_140_0.isnewitem = arg_140_0.isnewitem
		var_140_0.discountfinish = arg_140_0.discountfinish
		var_140_0.cost = arg_140_0.discount or arg_140_0.price
		var_140_0.quality = item_data[arg_140_0.itemtype].equip_quality or 1
		var_140_0.cost_old = arg_140_0.price
		var_140_0.bag_item_type = item_data[arg_140_0.itemtype].bag_item_type
		var_140_0.item_attr = arg_140_0.item_attr
		var_140_0.finish_time = arg_140_0.finish_time
		var_140_0.discount = arg_140_0.discount
		var_140_0.buy_limit = arg_140_0.buy_limit or 1000000
		var_140_0.have_bought = arg_140_0.have_bought or 0
		var_140_0.sell_out = arg_140_0.buy_limit and arg_140_0.buy_limit <= arg_140_0.have_bought
		var_140_0.tag = arg_140_0.tag or 0
		var_140_0.pos = arg_140_0.pos
		var_140_0.purchaseid = arg_140_0.productid

		return var_140_0
	end

	if arg_112_1.currency == 100 then
		(function(arg_136_0)
			local var_136_0 = {
				itemid = arg_136_0.itemid,
				item_attr = arg_136_0.item_attr
			}
			local var_136_1 = {
				costtype = arg_136_0.costIcon
			}

			var_136_1.costnum = arg_136_0.discount or arg_136_0.cost
			var_136_0.slidecost = var_136_1

			function var_136_0:ShopSliderCallback(arg_137_1, arg_137_2)
				if arg_137_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_136_0.have_bought >= arg_136_0.buy_limit then
					global_ShowBlockWords(L_MARKET_MSG.Sold_Out)
					audio_manager:playeffectMusicTest("sound/invalid")

					return
				end

				self:setTouchEnabled(false)
				shop_manager:shop_purchase(arg_136_0.shopid, arg_136_0.purchaseid, function(arg_138_0)
					if arg_138_0 == 1 then
						arg_112_1.have_bought = arg_112_1.have_bought + curbuyTime
						arg_112_1.sell_out = arg_112_1.buy_limit and arg_112_1.buy_limit <= arg_112_1.have_bought

						if arg_136_0.bag_item_type == kITEM_SKIN or arg_136_0.bag_item_type == kITEM_SKIN_GIFT then
							arg_112_0.dressPanel:getChildByName("ScrollView"):getChildByName(item_data[arg_136_0.itemid].model):setOpacity(255)
							arg_112_0.roleBnt:setTalkEnabled(true)
						else
							arg_112_0.giftPanel:getChildByName("ScrollView"):removeAllChildren()

							arg_112_0.giftPanel.selectOrder = nil

							arg_112_0:initGiftList()
						end

						LayerManager:removePopLayer(arg_112_0.__queueindex)

						if item_data[var_136_0.itemid].bag_item_type == kITEM_SKIN then
							require("view.Layer.GetRoleAnimationLayer")
							cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_136_0.itemid), 1000)
						end

						if arg_112_2 == 6 then
							for iter_138_0, iter_138_1 in pairs({
								{
									entityid = var_136_0.itemid
								}
							}) do
								net:rpc("use_gift_bag", {
									num = 1,
									entityid = iter_138_1.entityid
								}, function(arg_139_0)
									print(dump(arg_139_0))

									if arg_139_0.result == 1 then
										global_gain(arg_139_0)
										item_manager:deleteItem(iter_138_1.entityid, 1)
									else
										global_ShowBlockWords(L_MARKET_MSG.Gift_Bag_Lack)
									end
								end)
							end
						else
							LayerManager:pushInLayer("PopPurchaseResultLayer", {
								items = {
									{
										dropNum = 1,
										dropid = var_136_0.itemid,
										entityid = var_136_0.itemid
									}
								}
							})
						end
					elseif arg_138_0 == 2 then
						global_ShowBlockWords(L_MARKET_MSG.Goods_Sended)
						audio_manager:playeffectMusicTest("sound/invalid")
					end

					if arg_137_2 then
						arg_137_2(arg_138_0)
					end
				end)
			end

			if arg_112_2 == 4 or arg_112_2 == 6 then
				arg_112_0:showBuyPop(var_136_0, nil, arg_112_3)
			else
				print("暂时没给非服装商城做人民币支付")
			end

			arg_136_0.isnewitem = false
		end)(var_112_7(arg_112_1))
	else
		(function(arg_134_0)
			local var_134_0 = {
				itemid = arg_134_0.itemid,
				item_attr = arg_134_0.item_attr
			}

			var_134_0.limitNum = arg_134_0.buy_limit and (arg_134_0.buy_limit - arg_134_0.have_bought >= SHOP_NORMAL_BUY_LIMIT_NUM and SHOP_NORMAL_BUY_LIMIT_NUM or arg_134_0.buy_limit - arg_134_0.have_bought) or SHOP_NORMAL_BUY_LIMIT_NUM

			local var_134_1

			if var_112_6(arg_134_0) then
				var_134_1 = math.floor(var_112_1[arg_134_0.currency]() / arg_134_0.cost)
				var_134_0.currency = arg_134_0.currency
			else
				var_134_1 = math.floor(var_112_1[arg_134_0.currency2]() / arg_134_0.cost2)
				var_134_0.currency = arg_134_0.currency2
			end

			if var_134_1 > var_134_0.limitNum then
				var_134_0.limitNum = var_134_0.limitNum or var_134_1
			end

			local var_134_2 = arg_112_0:getResidueTime(arg_134_0.finish_time)

			if var_134_2 ~= "-1" then
				var_134_0.limit_time = L_MARKET_MSG.Rest_Time .. var_134_2
			end

			var_134_0.slidecost = {}

			if var_112_6(arg_134_0) then
				var_134_0.slidecost.costtype = arg_134_0.costIcon
				var_134_0.slidecost.costnum = arg_134_0.discount or arg_134_0.cost
				var_134_0.slidecost.nowHave = var_112_1[arg_134_0.currency]()
				var_134_0.slidecost.cost_old = arg_134_0.cost_old or var_134_0.slidecost.costnum
			else
				var_134_0.slidecost.costtype = arg_134_0.costIcon2
				var_134_0.slidecost.costnum = arg_134_0.discount2 or arg_134_0.cost2
				var_134_0.slidecost.nowHave = var_112_1[arg_134_0.currency2]()
				var_134_0.slidecost.cost_old = arg_134_0.cost_old2 or var_134_0.slidecost.costnum
			end

			function var_134_0:ShopSliderCallback(arg_135_1, arg_135_2, arg_135_3)
				if arg_135_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not self:isBright() then
					return
				end

				local var_135_0 = self.nowNum or 1

				var_112_4 = {
					curbuyTime = var_135_0,
					shoptype = arg_112_2,
					itemid = var_134_0.itemid,
					callback = arg_135_2,
					shopitem = arg_134_0
				}

				if not arg_135_3 and var_112_6(arg_134_0) and arg_134_0.cost > var_112_1[arg_134_0.currency]() then
					LayerManager:removePopLayer()
					var_112_3[arg_134_0.currency](arg_134_0.currency)

					return
				end

				self:setTouchEnabled(false)
				var_112_5({
					result = 1,
					selectCoupon = arg_135_3
				})
			end

			var_134_0.hideGainButton = true

			if arg_134_0.have_bought and arg_134_0.buy_limit then
				var_134_0.limit_buy_num = arg_134_0.buy_limit - arg_134_0.have_bought
				var_134_0.have_bought_num = arg_134_0.have_bought
			end

			arg_112_0:showBuyPop(var_134_0, arg_112_2, arg_112_3)

			arg_134_0.isnewitem = false
		end)(var_112_7(arg_112_1))
	end
end

function DormRoomLayer.showBuyPop(arg_141_0, arg_141_1, arg_141_2, arg_141_3)
	arg_141_1.couponList = discount_manager:getCanUseCoupin(arg_141_1.itemid, arg_141_1.currency, arg_141_1.costnum or arg_141_1.slidecost.costnum, arg_141_2)

	if not arg_141_2 then
		LayerManager:pushInLayer("PopGoodsLayer", arg_141_1)
	elseif arg_141_3 == "shopitem" then
		LayerManager:pushInLayer("PopGoodsLayer", arg_141_1)
	elseif arg_141_3 == "giftitem" then
		if arg_141_1.couponList and next(arg_141_1.couponList) then
			LayerManager:pushInLayer("PopGoodsLayer", arg_141_1)
		else
			LayerManager:pushInLayer("PopSkinPackage", arg_141_1)
		end
	else
		LayerManager:pushInLayer("PopGoodsLayer", arg_141_1)
	end
end

function DormRoomLayer:TalkPop(arg_142_1)
	local var_142_0 = ccui.Layout:create()

	var_142_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
	var_142_0:setTouchEnabled(true)
	var_142_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_142_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_142_0:setBackGroundColorOpacity(255)
	var_142_0:setPositionY(0 - GameDisplay.fix_y)
	self:addChild(var_142_0, 999)

	local var_142_1

	var_142_0:addTouchEventListener(function(arg_143_0, arg_143_1)
		if arg_143_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_142_1 then
			var_142_1()

			var_142_1 = nil
		end
	end)

	local var_142_2 = cc.Label:createWithTTF("", FONT_BUTTON, 36)

	var_142_2:setPosition(320, 800)
	var_142_0:addChild(var_142_2)

	local var_142_3
	local var_142_4 = 1

	local function var_142_6()
		var_142_4 = var_142_4 + 1

		if arg_142_1[var_142_4] then
			var_142_2:setString(string.format(L_TALK_STRING, var_142_4))

			function var_142_1()
				var_142_3 = TalkLayer:create(arg_142_1[var_142_4], nil, TALK_TYPE_NORMAL, "", var_142_6)

				global_basic_scene:addChild(var_142_3, 5)
			end
		else
			var_142_0:runAction(cc.RemoveSelf:create())
		end
	end

	var_142_3 = TalkLayer:create(arg_142_1[1], nil, TALK_TYPE_FAVOR, "", nil)

	global_basic_scene:addChild(nil, 5)
end

function DormRoomLayer:pop_img()
	local var_146_0 = self:getChildByName("pop_img")

	if not var_146_0 then
		var_146_0 = ccui.ImageView:create("Dormitory/pop_img.png", var_0_21)

		var_146_0:setPosition(320, 500)
		var_146_0:setName("pop_img")
		self:addChild(var_146_0, 999)
	end

	var_146_0:stopAllActions()
	var_146_0:setScaleY(1)
	var_146_0:setOpacity(255)
	var_146_0:runAction((cc.Spawn:create(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeTo:create(2 - 0.5, 50)), cc.Sequence:create(cc.DelayTime:create(2 - 0.5), cc.ScaleTo:create(0.1, 1, 0), cc.RemoveSelf:create()))))
end

function DormRoomLayer:slideSwitchRoom()
	local var_147_0 = ccui.Layout:create()

	var_147_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.rootLayer:addChild(var_147_0, 2)

	local var_147_1 = cc.EventListenerTouchOneByOne:create()

	var_147_1:registerScriptHandler(function(arg_148_0, arg_148_1)
		var_147_1:setSwallowTouches(false)

		if self.iscanswitch then
			return true
		else
			return false
		end
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_147_1:registerScriptHandler(function(arg_149_0, arg_149_1)
		local var_149_0 = var_147_0:convertToNodeSpace(arg_149_0:getStartLocation())
		local var_149_1 = var_147_0:convertToNodeSpace(arg_149_0:getLocation())

		if math.abs(var_149_0.x - var_149_1.x) > 280 then
			var_147_1:setSwallowTouches(true)

			if var_149_0.x > var_149_1.x then
				self:switchRoom(1)
			else
				self:switchRoom(-1)
			end
		else
			var_147_1:setSwallowTouches(false)
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_147_1, var_147_0)
end

function DormRoomLayer:initArrow()
	local var_150_0 = ccui.Button:create("SelectPlayerLayer/arrow_createrole.png", "SelectPlayerLayer/arrow_createrole.png", "SelectPlayerLayer/arrow_createrole.png", var_0_21)

	var_150_0:setAnchorPoint(cc.p(0, 0.5))
	var_150_0:setFlippedX(true)
	var_150_0:setPosition(10, GameDisplay.height / 2)
	self.uiPanel:addChild(var_150_0)
	var_150_0:addTouchEventListener(function(arg_151_0, arg_151_1)
		if arg_151_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.iscanswitch then
			return
		end

		self:switchRoom(-1)
	end)

	local var_150_1 = ccui.Button:create("SelectPlayerLayer/arrow_createrole.png", "SelectPlayerLayer/arrow_createrole.png", "SelectPlayerLayer/arrow_createrole.png", var_0_21)

	var_150_1:setAnchorPoint(cc.p(1, 0.5))
	var_150_1:setPosition(GameDisplay.width - 10, GameDisplay.height / 2)
	self.uiPanel:addChild(var_150_1)
	var_150_1:addTouchEventListener(function(arg_152_0, arg_152_1)
		if arg_152_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.iscanswitch then
			return
		end

		self:switchRoom(1)
	end)
end

function DormRoomLayer:initMarryUI()
	self.marryBnt = ccui.Button:create("Dormitory/marry_entrance.png", nil, "Dormitory/marry_entrance.png", var_0_21)

	self.marryBnt:setPosition(240, GameDisplay.height - 60 - GameDisplay.fix_y)
	self.favorUI:getParent():addChild(self.marryBnt)
	self.marryBnt:addTouchEventListener(function(arg_154_0, arg_154_1)
		local var_154_0

		if arg_154_1 ~= ccui.TouchEventType.ended then
			do return end

			var_154_0 = {
				majorid = self.soulid
			}
		end

		function var_154_0.exitCallback()
			if not tolua.isnull(self) then
				self:updateDressUI()
				self:updateFavorBar()
			end
		end

		LayerManager:pushInLayer("MarryPopLayer", var_154_0)
	end)
	self.marryBnt:setVisible(dormitory_manager:can_show_marry_ui(self.soulid))
	self.marryBnt:setVisible(playermodel.haveSuit[self.soulid])
end

function DormRoomLayer:updateMarryUI()
	self.marryBnt:setVisible(dormitory_manager:can_show_marry_ui(self.soulid))
	self.marryBnt:setVisible(playermodel.haveSuit[self.soulid])
end

function DormRoomLayer:initAiChatBtn()
	self.aichatBtn = ccui.Button:create("Dormitory/aichat_btn.png", nil, "Dormitory/aichat_btn.png", var_0_21)

	self.aichatBtn:setPosition(550, GameDisplay.height - 80 - GameDisplay.fix_y)
	self.rootLayer:addChild(self.aichatBtn)
	self.aichatBtn:addTouchEventListener(function(arg_158_0, arg_158_1)
		if arg_158_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("AIchatLayer", {
			servant = self.servant
		})
	end)
end
