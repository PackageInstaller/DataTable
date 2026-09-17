MarryTalkLayer = class("MarryTalkLayer", function()
	return cc.Layer:create()
end)

local playermodel = require("model.playermodel")
local l2utils = require("controller.l2utils")
local audio_manager = require("controller.audio_manager")
local model_data = require("data.model_data")
local conversation_data = require("data.conversation_data")

require("view.Sprite.ConfirmDialogSprite")

local var_0_5 = config._DEBUG and 0 or 1
local TalkDesSprite

function MarryTalkLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = MarryTalkLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function MarryTalkLayer:init(arg_3_1)
	self.classification = arg_3_1.classification or 1001501
	self.finishCallback = arg_3_1.finishCallback

	audio_manager:switchLayerBGM(MARRY_BGM, true)

	self.layout_bg = ccui.Layout:create()

	self.layout_bg:setContentSize(GameDisplay.width, GameDisplay.height)
	self.layout_bg:setPosition(0, -GameDisplay.fix_y)
	self.layout_bg:setTouchEnabled(true)
	self:addChild(self.layout_bg)
	self:initData()
	self:initAnimation()
	self:initTalkSprite()
	self:animationStart()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			audio_manager:switchLayerBGM(LayerManager:getUILayerBgm())
		end
	end)
end

function MarryTalkLayer:initData()
	self.dialogTabel = {}

	for iter_5_0, iter_5_1 in pairs(conversation_data) do
		if iter_5_1.classification == self.classType then
			table.insert(self.dialogTabel, iter_5_1)
		end
	end
end

function MarryTalkLayer:initAnimation()
	self.startAni = L2Skeleton:create("spine/ui/marry/D1" .. ".json", "spine/ui/marry/D1" .. ".atlas", nil, true)

	self.startAni:refreshSkeleton()
	self.startAni:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.startAni, 0)

	self.boxAni = L2Skeleton:create("spine/ui/marry/H1-4" .. ".json", "spine/ui/marry/H1-4" .. ".atlas", nil, true)

	self.boxAni:setVisible(false)
	self.boxAni:refreshSkeleton()
	self.boxAni:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.boxAni, 2)

	self.flowerAni = L2Skeleton:create("spine/ui/marry/huaban" .. ".json", "spine/ui/marry/huaban" .. ".atlas", nil, true)

	self.flowerAni:refreshSkeleton()
	self.flowerAni:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.flowerAni, 3)
end

function MarryTalkLayer:animationStart()
	self.startAni:play("D1", false)
	self.startAni:registerListener(SP_ANIMATION_COMPLETE, function(arg_8_0)
		if arg_8_0.animation == "D1" then
			self:talkSceneRunning()
		end
	end)
	self.flowerAni:play("huaban", true)
end

function MarryTalkLayer:initTalkSprite()
	self.talkLayer = ccui.Layout:create()

	self.talkLayer:setContentSize(cc.size(640, GameDisplay.height))
	self.talkLayer:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.talkLayer, 1)

	self.talkSprite = TalkDesSprite:create({
		nobackground = 1,
		classification = self.classification,
		rootNode = self,
		talktype = TALK_TYPE_NORMAL,
		callback = function()
			self:animationEnding()
		end
	})

	self.talkSprite:setVisible(false)
	self.talkLayer:addChild(self.talkSprite)
end

function MarryTalkLayer:talkSceneRunning()
	self.talkSprite:setVisible(true)
	self.talkSprite:enterAin()
	self.talkSprite:ShowNext(nil, ccui.TouchEventType.ended)
end

function MarryTalkLayer:animationEnding()
	self.boxAni:setVisible(true)
	self.boxAni:play("H1", false)
	self.boxAni:registerListener(SP_ANIMATION_COMPLETE, function(arg_13_0)
		if arg_13_0.animation == "H1" then
			self.boxAni:play("H2", true)
		elseif arg_13_0.animation == "H3" then
			self.boxAni:play("H4", false)
		elseif arg_13_0.animation == "H4" then
			LayerManager:removePopLayer(self.__queueindex)

			if self.finishCallback then
				self.finishCallback()
			end
		end
	end)

	local var_12_0 = ccui.Layout:create()

	var_12_0:setTouchEnabled(true)
	var_12_0:setContentSize(cc.size(200, 200))
	var_12_0:setPosition(640 - var_12_0:getContentSize().width, -GameDisplay.fix_y + 70)
	self:addChild(var_12_0, 999)
	var_12_0:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_14_0.isLock then
			return
		end

		arg_14_0.isLock = true

		self.boxAni:play("H3", true)
		self.finger:setVisible(false)
	end)

	self.touchBox = var_12_0

	self:initFinger()
end

function MarryTalkLayer:initFinger()
	local var_15_0

	if config._DEBUG then
		var_15_0 = cc.Sprite:create("Guide/guide_finger.png") or cc.Sprite:createWithSpriteFrameName("Guide/guide_finger.png")
	end

	self.touchBox:addChild(var_15_0, 5)

	local var_15_1 = cc.p(80, 100)

	var_15_0:setAnchorPoint(cc.p(0, 1))
	var_15_0:setFlippedX(false)
	var_15_0:setPosition(cc.p(var_15_1.x + math.min(30, self.touchBox:getContentSize().width / 5), var_15_1.y + -1 * math.min(30, self.touchBox:getContentSize().height / 5)))
	var_15_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.1), cc.MoveBy:create(0.3, cc.p(10, -10)), cc.MoveBy:create(0.3, cc.p(-1 * 10, -1 * -10)))))

	self.finger = var_15_0
end

TalkDesSprite = class("TalkDesSprite", function()
	return cc.NodeGrid:create()
end)
TalkDesSprite.UIText = nil
TalkDesSprite.lineNum = nil
TalkDesSprite.dialogTabel = {}
TalkDesSprite.finishCallBack = nil

local function var_0_9(arg_17_0)
	local var_17_0, var_17_1 = arg_17_0:match("([^,]+),(.+)")

	return cc.p(checknumber(var_17_0), checknumber(var_17_1))
end

local function var_0_10(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1 or 0
	local var_18_1 = arg_18_2 or 0
	local var_18_2

	if arg_18_0 then
		::label_18_0::

		var_18_2 = model_data[arg_18_0] and model_data[arg_18_0].offset_x_l
	end

	local var_18_3

	if arg_18_0 then
		::label_18_1::

		var_18_3 = model_data[arg_18_0] and model_data[arg_18_0].offset_y_l
	end

	local var_18_4

	if arg_18_0 then
		::label_18_2::

		var_18_4 = model_data[arg_18_0] and model_data[arg_18_0].offset_x_m
	end

	local var_18_5

	if arg_18_0 then
		::label_18_3::

		var_18_5 = model_data[arg_18_0] and model_data[arg_18_0].offset_y_m
	end

	local var_18_6

	if arg_18_0 then
		::label_18_4::

		var_18_6 = model_data[arg_18_0] and model_data[arg_18_0].offset_x_r
	end

	local var_18_7

	if arg_18_0 then
		::label_18_5::

		var_18_7 = model_data[arg_18_0] and model_data[arg_18_0].offset_y_r
	end

	var_18_2 = var_18_2 or var_18_0
	var_18_3 = var_18_3 or var_18_1
	var_18_4 = var_18_4 or var_18_0
	var_18_5 = var_18_5 or var_18_1
	var_18_6 = var_18_6 or var_18_0

	local var_18_8

	if not var_18_7 then
		var_18_7 = var_18_1
		var_18_8 = arg_18_0 and model_data[arg_18_0] and model_data[arg_18_0].mainmidpos and var_0_9(model_data[arg_18_0].mainmidpos) or cc.p(320, -30)
	end

	return var_18_8, {
		left = {
			x = var_18_2,
			y = var_18_3
		},
		mid = {
			x = var_18_4,
			y = var_18_5
		},
		right = {
			x = var_18_6,
			y = var_18_7
		}
	}
end

function TalkDesSprite:create(arg_19_1)
	local var_19_0 = TalkDesSprite.new()

	var_19_0:init(arg_19_1)

	return var_19_0
end

function TalkDesSprite:init(arg_20_1)
	TalkLayerInstance = self
	self.rootNode = arg_20_1.rootNode
	self.initPostion = cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2)
	self.classification = arg_20_1.classification
	self.finishCallBack = arg_20_1.callback
	self.nobackground = arg_20_1.nobackground
	self.lineNum = 0
	self.waitPrintText = false
	self.next = true
	self.existRole = 0
	self.talkedTbl = {}
	self.reviewDialogTabel = {}

	self:initConversation(self.classification)
	self:initUI()
	self:registeTouchEvents()
	self:initRole()
	self:fullScreen()
	self:registerScriptHandler(function(arg_21_0)
		if arg_21_0 == "enter" then
			KeyCodeManager:setKeyCodeEventlock(true)
		elseif arg_21_0 == "exit" then
			TalkLayerInstance = nil

			self:openOrcloseAuto(false)
			KeyCodeManager:setKeyCodeEventlock(false)
			audio_manager:stopAllRoleSound()

			if self.classification == 3102002 then
				audio_manager:resumebackgroundMusic()
			end
		end
	end)
end

function TalkDesSprite:enterAin()
	self.rolePanel:runAction(cc.FadeIn:create(0.5))
	self.rootLayout:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.FadeIn:create(0.4)))
end

function TalkDesSprite:initUI()
	self.rootLayout = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Talk.json" or "Talk.ExportJson")

	self:addChild(self.rootLayout, 1)
	self.rootLayout:setOpacity(0)
	ccui.Helper:seekWidgetByName(self.rootLayout, "panel_back"):setBackGroundColorOpacity(0)

	self.effect_layer = ccui.Helper:seekWidgetByName(self.rootLayout, "effect_panel")

	self.effect_layer:setLocalZOrder(1000)

	local var_23_0 = ccui.ImageView:create("PopChangeEquip/deLeft.png", var_0_5)

	var_23_0:setAnchorPoint(0.5, 0.5)
	var_23_0:setPosition(self.initPostion)
	var_23_0:setTouchEnabled(true)

	self.BackImagelayout = var_23_0

	self:addChild(self.BackImagelayout, -1)

	self.wordBack = ccui.Helper:seekWidgetByName(self.rootLayout, "word_back")

	self.wordBack:setLocalZOrder(10)

	self.SpeakerName = ccui.Helper:seekWidgetByName(self.rootLayout, "image_name_l")

	self.SpeakerName:setColor(cc.c3b(242, 248, 255))
	self.SpeakerName:setLocalZOrder(15)

	self.namedi = ccui.Helper:seekWidgetByName(self.rootLayout, "name_bgdi")

	self.namedi:setLocalZOrder(10)

	self.LastName = ccui.Helper:seekWidgetByName(self.rootLayout, "image_name_r")

	self.LastName:setColor(cc.c3b(242, 248, 255))
	self.LastName:setLocalZOrder(15)
	self.LastName:setVisible(false)

	self.dialog_content = ccui.Helper:seekWidgetByName(self.rootLayout, "dialog_content")
	self.button_review = ccui.Helper:seekWidgetByName(self.rootLayout, "button_review")
	self.buttonSkip = ccui.Helper:seekWidgetByName(self.rootLayout, "button_skip")
	self.review_area = ccui.Helper:seekWidgetByName(self.rootLayout, "review_area")

	self.review_area:removeFromParent()
	self.review_area:retain()

	self.review_list = ccui.Helper:seekWidgetByName(self.rootLayout, "review_list")

	self.review_list:removeFromParent()
	self.review_list:retain()

	self.UIText = cc.Label:createWithTTF("", FONT_NAME, 28)

	self.UIText:setMaxLineWidth(550)
	self.UIText:setPosition(cc.p(45, 180))
	self.UIText:setAnchorPoint(cc.p(0, 1))
	self.UIText:setLineHeight(35)
	self.UIText:setAdditionalKerning(3)
	self.UIText:setColor(cc.c3b(242, 242, 242))
	self.wordBack:addChild(self.UIText)

	self.myselectpanel = ccui.Helper:seekWidgetByName(self.rootLayout, "my_select_Panel")
	self.select1 = self.myselectpanel:getChildByName("btn_select_1")
	self.select2 = self.myselectpanel:getChildByName("btn_select_2")
	self.select = {
		self.select1,
		self.select2
	}
	self.btn_autoplay = ccui.Helper:seekWidgetByName(self.rootLayout, "button_autoplay")
	self.autoplay_ani1 = ccui.Helper:seekWidgetByName(self.rootLayout, "Image_5")
	self.autoplay_ani2 = ccui.Helper:seekWidgetByName(self.rootLayout, "Image_4")
	self.isautoplay = RoleDefault:getInstance():getBoolForKey("talkplayerisauto", false)
	self.nextbtn = ccui.Helper:seekWidgetByName(self.rootLayout, "btn_next")

	self.nextbtn:setVisible(false)

	local var_23_1 = GameDisplay.getScreenSize().height * 0.18 - 204

	self.nextbtn:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(609, 84 - var_23_1)), cc.DelayTime:create(0.2), cc.MoveTo:create(0.2, cc.p(609, 84 - var_23_1 + 12.5)))))
	self.button_review:setVisible(false)
	self.buttonSkip:setVisible(false)
	self.wordBack:setVisible(false)
	self.btn_autoplay:setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayout, "expression_l"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayout, "player_l"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayout, "expression_r"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayout, "player_r"):setVisible(false)
end

function TalkDesSprite:registeTouchEvents()
	self.btn_autoplay:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:updataAuoStatus() then
			self:openOrcloseAuto(true)
			AnalyticManager.clickAuto()
		else
			self:openOrcloseAuto(false)
		end
	end)

	local function var_24_0()
		self:exit()

		if self.finishCallBack then
			self.finishCallBack(self.classType)

			self.finishCallBack = nil
		end

		AnalyticManager.clickStory({
			look_story_type = "talkSkip",
			storyid = self.classType
		})
	end

	local function var_24_1()
		self:addChild(ConfirmDialogSprite:create("", L_SKIP_EVENT, {
			surecallback = function()
				var_24_0()
			end,
			cancelcallback = function()
				return
			end,
			parenttype = self.parenttype
		}), 999)
	end

	self.buttonSkip:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_24_1()
		AnalyticManager.clickStory({
			look_story_type = "clickSkip",
			storyid = self.classType
		})
	end)
	self.button_review:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isautoplay then
			self:openOrcloseAuto(false)
		end

		self:reviewConversation()
		AnalyticManager.clickStory({
			look_story_type = "clickPlayback",
			storyid = self.classType
		})
	end)
	self.rootLayout:addTouchEventListener(function(arg_33_0, arg_33_1)
		if self.waitPrintText then
			self:showAll(arg_33_0, arg_33_1)
		else
			self:ShowNext(arg_33_0, arg_33_1)
		end
	end)
end

function TalkDesSprite:initRole()
	self.rolePanel = ccui.Layout:create()

	self.rolePanel:setOpacity(0)
	self:addChild(self.rolePanel, 0)

	self.LeftPlayer = cc.Sprite:create()

	self.LeftPlayer:setAnchorPoint(cc.p(0.5, 0))
	self.rolePanel:addChild(self.LeftPlayer)

	self.LeftPlayerExpression = cc.Sprite:create()

	self.LeftPlayerExpression:setAnchorPoint(cc.p(0.5, 0))
	self.rolePanel:addChild(self.LeftPlayerExpression, 5)

	self.RightPlayer = cc.Sprite:create()

	self.RightPlayer:setAnchorPoint(cc.p(0.5, 0))
	self.rolePanel:addChild(self.RightPlayer)

	self.RightPlayerExpression = cc.Sprite:create()

	self.RightPlayerExpression:setAnchorPoint(cc.p(0.5, 0))
	self.rolePanel:addChild(self.RightPlayerExpression, 5)

	local var_34_0

	if self.dialogTabel[1] then
		var_34_0 = self.dialogTabel[1].offset_x or 0

		local var_34_1

		if self.dialogTabel[1] then
			var_34_1 = self.dialogTabel[1].offset_y or 0
		end
	end

	local var_34_2, var_34_3 = var_0_10(self.rootNode.modelid, var_34_0, var_34_1)

	self.LeftPlayer:setPosition(cc.p(-402 + var_34_3.mid.x, var_34_2.y + var_34_3.mid.y))
	self.LeftPlayerExpression:setPosition(cc.p(-402 + var_34_3.mid.x, var_34_2.y + var_34_3.mid.y))
	self.RightPlayer:setPosition(cc.p(1033 + var_34_3.mid.x, var_34_2.y + var_34_3.mid.y))
	self.RightPlayerExpression:setPosition(cc.p(1033 + var_34_3.mid.x, var_34_2.y + var_34_3.mid.y))

	if self.dialogTabel[1].speaker == "L" then
		self.lastMainPos = {
			x = -402 + var_34_3.mid.x,
			y = var_34_2.y + var_34_3.mid.y
		}
		self.lastSubPos = {
			x = 1033 + var_34_3.mid.x,
			y = var_34_2.y + var_34_3.mid.y
		}
		self.lastSubPosIn = {
			x = var_34_2.x + var_34_3.left.x,
			y = var_34_2.y + var_34_3.left.y
		}
	else
		self.lastMainPos = {
			x = 1033 + var_34_3.mid.x,
			y = var_34_2.y + var_34_3.mid.y
		}
		self.lastSubPos = {
			x = -402 + var_34_3.mid.x,
			y = var_34_2.y + var_34_3.mid.y
		}
		self.lastSubPosIn = {
			x = var_34_2.x + var_34_3.right.x,
			y = var_34_2.y + var_34_3.right.y
		}
	end
end

function TalkDesSprite:setRootEnabled(arg_35_1)
	self.rootLayout:setTouchEnabled(arg_35_1)
	self.buttonSkip:setVisible(arg_35_1)
end

function TalkDesSprite:playTalkEffect(arg_36_1)
	local var_36_0 = false

	local function var_36_1(arg_37_0)
		self.wordBack:setVisible(arg_37_0)
		self.buttonSkip:setVisible(arg_37_0)
		self.SpeakerName:setVisible(arg_37_0)
		self.LastName:setVisible(arg_37_0)
		self.btn_autoplay:setVisible(arg_37_0)
	end

	local function var_36_2(arg_38_0)
		self.next = false
		var_36_0 = true

		self.effect_layer:setBackGroundColor(cc.c3b(0, 0, 0))
		self.effect_layer:setBackGroundColorOpacity(255)
		self.effect_layer:setOpacity(0)
		self.effect_layer:setVisible(true)
		var_36_1(false)
		self.effect_layer:runAction(cc.Sequence:create(cc.FadeIn:create(arg_38_0 / 2), cc.FadeOut:create(arg_38_0 / 2), cc.CallFunc:create(function()
			var_36_1(true)
		end), cc.CallFunc:create(arg_36_1)))
	end

	local function var_36_3(arg_40_0, arg_40_1)
		self.next = false
		var_36_0 = true

		var_36_1(false)

		if self.dialogTabel[self.lineNum].vioceover then
			if self.role_main then
				self.role_main:setPositionX(100000)
			end

			if self.role_sub then
				self.role_sub:setPositionX(100000)
			end

			if self.expression_main then
				self.expression_main:setPositionX(100000)
			end

			if self.expression_sub then
				self.expression_sub:setPositionX(100000)
			end

			self.button_review:setVisible(false)
		end

		local var_40_0 = {}

		for iter_40_0 = 1, 3 do
			var_40_0[iter_40_0] = cc.Sequence:create(cc.MoveBy:create(0.05 / (iter_40_0 * iter_40_0), cc.p(arg_40_0 * 10 / iter_40_0, arg_40_1 * 10 / iter_40_0)), cc.MoveBy:create(0.05 / (iter_40_0 * iter_40_0), cc.p(-(arg_40_0 * 10 / iter_40_0), -(arg_40_1 * 10 / iter_40_0))), cc.MoveBy:create(0.05 / (iter_40_0 * iter_40_0), cc.p(-(arg_40_0 * 10 / iter_40_0), -(arg_40_1 * 10 / iter_40_0))), cc.MoveBy:create(0.05 / (iter_40_0 * iter_40_0), cc.p(arg_40_0 * 10 / iter_40_0, arg_40_1 * 10 / iter_40_0)))
		end

		self:runAction(cc.Sequence:create(var_40_0[1], var_40_0[2], var_40_0[3], cc.CallFunc:create(function()
			var_36_1(true)
		end), cc.CallFunc:create(arg_36_1)))
	end

	local function var_36_4(arg_42_0)
		self.next = false
		var_36_0 = true

		self.effect_layer:setBackGroundColor(cc.c3b(255, 255, 255))
		self.effect_layer:setBackGroundColorOpacity(255)
		self.effect_layer:setOpacity(255)
		var_36_1(false)
		self.effect_layer:runAction(cc.Sequence:create(cc.Blink:create(arg_42_0, 1), cc.DelayTime:create(0.3), cc.FadeOut:create(0.3), cc.CallFunc:create(function()
			var_36_1(true)
		end), cc.CallFunc:create(arg_36_1)))
	end

	local function var_36_5(arg_44_0)
		self.next = false
		var_36_0 = true

		var_36_1(false)

		self.panel_access = ccui.Layout:create()

		self.panel_access:setContentSize(GameDisplay.getScreenSize())
		self.panel_access:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)

		if arg_44_0 == "black" then
			self.panel_access:setBackGroundColor(cc.c3b(0, 0, 0))
		else
			self.panel_access:setBackGroundColor(cc.c3b(255, 255, 255))
		end

		self.panel_access:setAnchorPoint(cc.p(0.5, 0.5))
		self.panel_access:setPosition(cc.p(self.panel_access:getContentSize().width / 2, self.panel_access:getContentSize().height / 2))
		self.rootLayout:addChild(self.panel_access, 10)
		self.panel_access:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(function()
			var_36_1(true)
		end), cc.CallFunc:create(arg_36_1)))
	end

	local function var_36_6(arg_46_0, arg_46_1, arg_46_2)
		self.next = false
		var_36_0 = true

		if not self.BackImagelayout then
			return
		end

		local var_46_0 = arg_46_0 or 0.5
		local var_46_1 = arg_46_1 or 1
		local var_46_2 = arg_46_2 or 1

		self.buttonSkip:setVisible(false)
		self.btn_autoplay:setVisible(false)
		self.BackImagelayout:setScale(var_46_0)
		self.BackImagelayout:runAction(cc.Sequence:create(cc.ScaleTo:create(var_46_2, var_46_1), cc.CallFunc:create(arg_36_1)))
	end

	local function var_36_7(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
		self.next = false
		var_36_0 = true

		if not self.BackImagelayout then
			return
		end

		local var_47_0 = arg_47_1 or 0
		local var_47_1 = arg_47_2 or 0
		local var_47_2 = arg_47_0 or 1
		local var_47_3 = arg_47_3 or 1

		self.buttonSkip:setVisible(false)
		self.btn_autoplay:setVisible(false)
		self.BackImagelayout:setScale(var_47_2)
		self.BackImagelayout:setPosition(self.initPostion)

		local var_47_4, var_47_5 = self.BackImagelayout:getPosition()

		self.BackImagelayout:runAction(cc.Sequence:create(cc.MoveTo:create(var_47_3, (cc.p(var_47_4 + var_47_0, var_47_5 + var_47_1))), cc.CallFunc:create(arg_36_1)))
	end

	if self.BackImagelayout then
		self.BackImagelayout:setPosition(self.initPostion)
		self.BackImagelayout:setScale(1)
		self.buttonSkip:setVisible(true)
	end

	if self.dialogTabel[self.lineNum].background and self.nobackground == nil then
		self.BackImagelayout:loadTexture("mainScenebg/" .. self.dialogTabel[self.lineNum].background .. ".jpg")
		self.BackImagelayout:setVisible(true)
	else
		self.BackImagelayout:setVisible(false)
	end

	if self.dialogTabel[self.lineNum].black_screen then
		if self.dialogTabel[self.lineNum].black_screen_time then
			var_36_2(self.dialogTabel[self.lineNum].black_screen_time)
		else
			var_36_2(0.5)
		end
	end

	if self.dialogTabel[self.lineNum].shock_screen then
		var_36_3(2, 5)
	end

	if self.dialogTabel[self.lineNum].splash_screen then
		var_36_4(self.dialogTabel[self.lineNum].splash_screen_time)
	end

	if self.dialogTabel[self.lineNum].color then
		var_36_5(self.dialogTabel[self.lineNum].color)
	end

	if self.dialogTabel[self.lineNum].zoom_scene then
		var_36_6(self.dialogTabel[self.lineNum].zoom_scene_init_scale, self.dialogTabel[self.lineNum].zoom_scene_end_scale, self.dialogTabel[self.lineNum].zoom_scene_time)
	end

	if self.dialogTabel[self.lineNum].move_scene then
		var_36_7(self.dialogTabel[self.lineNum].move_scene_scale, self.dialogTabel[self.lineNum].move_scene_offx, self.dialogTabel[self.lineNum].move_scene_offy, self.dialogTabel[self.lineNum].move_scene_time)
	end

	if false == false and arg_36_1 then
		arg_36_1()
	end
end

function TalkDesSprite:getRolePosTbl(arg_48_1, arg_48_2, arg_48_3)
	local var_48_2 = GameDisplay.fix_y

	if not TalkLayerInstance or TalkLayerInstance and not TalkLayerInstance.parenttype then
		var_48_2 = var_48_2 - GameDisplay.fix_y
	end

	local var_48_3 = {
		left = {
			inPos = {
				x = arg_48_1.x + arg_48_2.mid.x,
				y = arg_48_1.y + arg_48_2.mid.y + var_48_2
			},
			outPos = {
				x = -402,
				y = arg_48_1.y + arg_48_2.mid.y + var_48_2
			}
		},
		right = {
			inPos = {
				x = arg_48_1.x + arg_48_2.mid.x,
				y = arg_48_1.y + arg_48_2.mid.y + var_48_2
			},
			outPos = {
				x = 1033,
				y = arg_48_1.y + arg_48_2.mid.y + var_48_2
			}
		}
	}
	local var_48_4 = {
		left = {
			inPos = {
				x = arg_48_1.x - 200 + arg_48_2.left.x,
				y = arg_48_1.y + arg_48_2.left.y + var_48_2
			},
			outPos = {
				x = -402,
				y = arg_48_1.y + arg_48_2.left.y + var_48_2
			}
		},
		right = {
			inPos = {
				x = arg_48_1.x + 200 + arg_48_2.right.x,
				y = arg_48_1.y + arg_48_2.right.y + var_48_2
			},
			outPos = {
				x = 1033,
				y = arg_48_1.y + arg_48_2.right.y + var_48_2
			}
		}
	}

	if arg_48_3 and model_data[arg_48_3] and model_data[arg_48_3].is_big_role_image then
		self:adjustRoleAnchor(true)

		local var_48_5 = GameDisplay.getScreenSize().height / 2

		var_48_3 = {
			left = {
				inPos = {
					x = arg_48_1.x + arg_48_2.mid.x,
					y = var_48_5
				},
				outPos = {
					x = -402,
					y = var_48_5
				}
			},
			right = {
				inPos = {
					x = arg_48_1.x + arg_48_2.mid.x,
					y = var_48_5
				},
				outPos = {
					x = 1033,
					y = var_48_5
				}
			}
		}
		var_48_4 = {
			left = {
				inPos = {
					x = arg_48_1.x - 200 + arg_48_2.left.x,
					y = var_48_5
				},
				outPos = {
					x = -402,
					y = var_48_5
				}
			},
			right = {
				inPos = {
					x = arg_48_1.x + 200 + arg_48_2.right.x,
					y = var_48_5
				},
				outPos = {
					x = 1033,
					y = var_48_5
				}
			}
		}
	else
		self:adjustRoleAnchor(true)

		local var_48_6 = GameDisplay.getScreenSize().height / 2

		if not TalkLayerInstance or TalkLayerInstance and not TalkLayerInstance.parenttype then
			var_48_6 = var_48_6 - GameDisplay.fix_y
		end

		var_48_3 = {
			left = {
				inPos = {
					x = arg_48_1.x + arg_48_2.mid.x,
					y = var_48_6 + arg_48_2.mid.y
				},
				outPos = {
					x = -402,
					y = var_48_6 + arg_48_2.mid.y
				}
			},
			right = {
				inPos = {
					x = arg_48_1.x + arg_48_2.mid.x,
					y = var_48_6 + arg_48_2.mid.y
				},
				outPos = {
					x = 1033,
					y = var_48_6 + arg_48_2.mid.y
				}
			}
		}
		var_48_4 = {
			left = {
				inPos = {
					x = arg_48_1.x - 200 + arg_48_2.left.x,
					y = var_48_6 + arg_48_2.left.y
				},
				outPos = {
					x = -402,
					y = var_48_6 + arg_48_2.left.y
				}
			},
			right = {
				inPos = {
					x = arg_48_1.x + 200 + arg_48_2.right.x,
					y = var_48_6 + arg_48_2.right.y
				},
				outPos = {
					x = 1033,
					y = var_48_6 + arg_48_2.right.y
				}
			}
		}
	end

	return var_48_3, var_48_4
end

function TalkDesSprite:adjustRoleAnchor(arg_49_1)
	local var_49_0 = cc.p(0.5, 0)

	if arg_49_1 then
		var_49_0 = cc.p(0.5, 0.5)
	end

	self.LeftPlayer:setAnchorPoint(var_49_0)
	self.LeftPlayerExpression:setAnchorPoint(var_49_0)
	self.RightPlayer:setAnchorPoint(var_49_0)
	self.RightPlayerExpression:setAnchorPoint(var_49_0)
end

function TalkDesSprite:checkMyConservation()
	if self.dialogTabel[self.lineNum + 1].showName == L_EXPLORETALK_ME then
		self.wordBack:setVisible(true)
		self.button_review:setVisible(true)
		self.myselectpanel:setVisible(true)
		self:openOrcloseAuto(false)
		self.btn_autoplay:stopAllActions()
		self.autoplay_ani1:setVisible(false)
		self.autoplay_ani2:setVisible(false)
		self.select1:setVisible(false)
		self.select2:setVisible(false)
		self.nextbtn:setVisible(false)

		self.next = false

		self.SpeakerName:setVisible(true)
		self:dealMyConservation(self.dialogTabel[self.lineNum + 1])
	else
		table.insert(self.reviewDialogTabel, {
			showName = self.dialogTabel[self.lineNum + 1].showName,
			dec = self.dialogTabel[self.lineNum + 1].dec
		})

		self.next = true

		self.myselectpanel:setVisible(false)
		self.SpeakerName:setVisible(true)
	end
end

function TalkDesSprite:dealMyConservation(arg_51_1)
	local function var_51_0(arg_52_0, arg_52_1)
		if arg_52_0:getChildByName("richTextWord") then
			arg_52_0:getChildByName("richTextWord"):removeFromParent()
		end

		local var_52_0 = require("view.Sprite.RichTextPro"):create()

		var_52_0:setMaxWidth(560)
		var_52_0:setSize(28)
		var_52_0:setLineSpace(0)

		if not string.find(arg_52_1, "^%b<>.+%b<>$") then
			arg_52_1 = table.concat({
				"<p>",
				arg_52_1,
				"</p>"
			})
		end

		var_52_0:setText(arg_52_1, nil, true)

		local var_52_1, var_52_2 = var_52_0:getContentSize()

		if var_52_2 >= 58 then
			var_52_0:setPosition(cc.p(313 - var_52_1 / 2, 85))
		else
			var_52_0:setPosition(cc.p(313 - var_52_1 / 2, 70))
		end

		var_52_0:setName("richTextWord")
		arg_52_0:addChild(var_52_0, 100000)
	end

	local var_51_1 = {}

	for iter_51_0 = 1, 2 do
		if arg_51_1["dec_" .. iter_51_0] then
			table.insert(var_51_1, arg_51_1["dec_" .. iter_51_0])
		elseif iter_51_0 == 1 and arg_51_1.dec then
			table.insert(var_51_1, arg_51_1.dec)
		end
	end

	if #var_51_1 == 1 then
		self.select1:setVisible(true)
		self.select1:setPosition(cc.p(320, 568 + GameDisplay.fix_y))
		self.select2:setVisible(false)
		var_51_0(self.select1, var_51_1[1])
		self.select1:addTouchEventListener(function(arg_53_0, arg_53_1)
			if arg_53_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_51_1.next_classification_1 then
				self:dealSelectBtn(arg_51_1.next_classification_1, arg_51_1.dec_1)
			else
				table.insert(self.reviewDialogTabel, {
					showName = arg_51_1.showName,
					dec = arg_51_1.dec
				})

				self.lineNum = self.lineNum + 1

				self:ShowNext(nil, ccui.TouchEventType.ended)
			end
		end)
	else
		for iter_51_1 = 1, #var_51_1 do
			self.select[iter_51_1]:setVisible(true)
			var_51_0(self.select[iter_51_1], var_51_1[iter_51_1])

			if iter_51_1 == 1 then
				self.select1:setPosition(cc.p(320, 708 + GameDisplay.fix_y))
			else
				self.select2:setPosition(cc.p(320, 538 + GameDisplay.fix_y))
			end

			self.select[iter_51_1]:addTouchEventListener(function(arg_54_0, arg_54_1)
				if arg_54_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_51_1["next_classification_" .. iter_51_1] then
					self:dealSelectBtn(arg_51_1["next_classification_" .. iter_51_1], arg_51_1["dec_" .. iter_51_1])
				else
					table.insert(self.reviewDialogTabel, {
						showName = arg_51_1.showName,
						dec = arg_51_1.dec
					})

					self.lineNum = self.lineNum + 1

					self:ShowNext(nil, ccui.TouchEventType.ended)
				end
			end)
		end
	end
end

function TalkDesSprite:resetStatus()
	self.lineNum = 0
	self.waitPrintText = false
	self.next = true
end

function TalkDesSprite:dealSelectBtn(arg_56_1, arg_56_2)
	AnalyticManager.clickStory({
		look_story_type = "finishTalk",
		storyid = self.classType
	})
	table.insert(self.reviewDialogTabel, {
		showName = L_EXPLORETALK_ME,
		dec = arg_56_2
	})
	self:initConversation(arg_56_1)
	self.myselectpanel:setVisible(false)
	self:resetStatus()
	self:ShowNext(nil, ccui.TouchEventType.ended)

	if self.isautoplay then
		self:openOrcloseAuto(true)
	else
		self:openOrcloseAuto(false)
	end
end

function TalkDesSprite:updataAuoStatus()
	self.isautoplay = not self.isautoplay

	RoleDefault:getInstance():setBoolForKey("talkplayerisauto", self.isautoplay)

	return self.isautoplay
end

function TalkDesSprite:openOrcloseAuto11(arg_58_1)
	return
end

function TalkDesSprite:openOrcloseAuto(arg_59_1)
	local function var_59_0(arg_60_0)
		self.autoplay_ani1:setVisible(arg_60_0)
		self.autoplay_ani2:setVisible(not arg_60_0)
	end

	if arg_59_1 then
		if self.actScheduler then
			return
		else
			self:ShowNext(nil, ccui.TouchEventType.ended)
			self.btn_autoplay:loadTextures("public/talk/new_auto_dong.png", nil, nil, var_0_5)
			self.btn_autoplay:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.3), cc.CallFunc:create(function()
				var_59_0(false)
			end), cc.DelayTime:create(0.3), cc.CallFunc:create(function()
				var_59_0(true)
			end))))

			self.actScheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
				if self.music_obj then
					if self.music_obj:isFinished() then
						self:ShowNext(nil, ccui.TouchEventType.ended)
					end
				elseif self.next then
					local var_63_0 = cc.Node:create()

					self:addChild(var_63_0)
					var_63_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
						if self.next then
							self:ShowNext(nil, ccui.TouchEventType.ended)
						end
					end), cc.RemoveSelf:create()))
				end
			end, 1, false)
		end
	elseif self.actScheduler then
		self.btn_autoplay:stopAllActions()
		self.btn_autoplay:loadTextures("public/talk/new_auto.png", nil, nil, var_0_5)
		self.autoplay_ani1:setVisible(false)
		self.autoplay_ani2:setVisible(false)
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.actScheduler)

		self.actScheduler = nil
	end
end

function TalkDesSprite:ShowNext(arg_65_1, arg_65_2)
	if arg_65_2 ~= ccui.TouchEventType.ended then
		return
	end

	self.effect_layer:setVisible(false)
	self.btn_autoplay:setVisible(true)

	if self.panel_label then
		self.panel_label:setString("")
	end

	if self.BackImagelayout then
		self.BackImagelayout:stopAllActions()
	end

	audio_manager:stopAllRoleSound()

	if self.lineNum < #self.dialogTabel then
		if self.waitPrintText then
			if self.speaker == "vioceover" then
				self.effect_layer:setVisible(true)
				self.effect_layer:stopAllActions()
				self.panel_label:setString(self.dialogTabel[self.lineNum].dec)

				self.waitPrintText = false
				self.next = true
			else
				local var_65_0 = self.dialogTabel[self.lineNum].icon
				local var_65_1, var_65_2 = var_0_10(var_65_0, self.dialogTabel[self.lineNum].offset_x or 0, self.dialogTabel[self.lineNum].offset_y or 0)
				local var_65_3, var_65_4 = self:getRolePosTbl(var_65_1, var_65_2, var_65_0)

				if (self.dialogTabel[self.lineNum].speaker == "L" and 0 or 1) == 0 then
					self.UIText:stopAllActions()
				else
					self.UIText:stopAllActions()
				end

				self.waitPrintText = false
				self.next = true
			end

			return
		end

		if not self.dialogTabel[self.lineNum + 1].dec or self.dialogTabel[self.lineNum + 1].dec == "" then
			self.wordBack:setVisible(false)
			self.button_review:setVisible(false)
			self.btn_autoplay:setVisible(false)
			self.SpeakerName:setVisible(false)

			self.dialogTabel[self.lineNum + 1].dec = ""
		else
			self.wordBack:setVisible(true)
			self.button_review:setVisible(true)
			self.SpeakerName:setVisible(true)
			self.btn_autoplay:setVisible(true)
		end

		self:checkMyConservation()

		if self.next == false then
			return
		end

		self.next = false
		self.lineNum = self.lineNum + 1

		self:playTalkEffect(function()
			local var_66_0 = self.dialogTabel[self.lineNum].stay or 0
			local var_66_1 = self.dialogTabel[self.lineNum].icon
			local var_66_2, var_66_3 = var_0_10(var_66_1, self.dialogTabel[self.lineNum].offset_x or 0, self.dialogTabel[self.lineNum].offset_y or 0)
			local var_66_4, var_66_5 = self:getRolePosTbl(var_66_2, var_66_3, var_66_1)

			if not self.dialogTabel[self.lineNum].dec or self.dialogTabel[self.lineNum].dec == "" then
				self.wordBack:setVisible(false)
				self.button_review:setVisible(false)
				self.btn_autoplay:setVisible(false)
				self.SpeakerName:setVisible(false)

				self.dialogTabel[self.lineNum].dec = ""
			else
				self.wordBack:setVisible(true)
				self.button_review:setVisible(true)
				self.SpeakerName:setVisible(true)
				self.btn_autoplay:setVisible(true)
			end

			self.waitPrintText = true

			local var_66_6 = string.len(self.dialogTabel[self.lineNum].dec)
			local var_66_8 = self.dialogTabel[self.lineNum].speaker == "L" and 0 or 1
			local var_66_10 = self.lastIcon == self.dialogTabel[self.lineNum].icon and 0 or 0.3

			if var_66_1 and model_data[var_66_1] and model_data[var_66_1].is_big_role_image then
				var_66_10 = 0
			end

			local var_66_11 = cc.FadeIn:create(var_66_10)
			local var_66_12 = cc.FadeOut:create(var_66_10)

			if var_66_8 == 0 then
				self.role_main = self.LeftPlayer
				self.role_sub = self.RightPlayer
				self.expression_main = self.LeftPlayerExpression
				self.expression_sub = self.RightPlayerExpression
				self.inPos = "left"
				self.outPos = "right"
			else
				self.role_main = self.RightPlayer
				self.role_sub = self.LeftPlayer
				self.expression_main = self.RightPlayerExpression
				self.expression_sub = self.LeftPlayerExpression
				self.inPos = "right"
				self.outPos = "left"
			end

			l2utils:recoverShader(self.role_main)
			l2utils:recoverShader(self.expression_main)
			self.role_main:setLocalZOrder(3)
			self.expression_main:setLocalZOrder(3)
			self.role_sub:setLocalZOrder(0)
			self.expression_sub:setLocalZOrder(0)

			if self.dialogTabel[self.lineNum].scale then
				self.role_main:setScale(self.dialogTabel[self.lineNum].scale)
			else
				self.role_main:setScale(1)
			end

			local var_66_13 = self.dialogTabel[self.lineNum].vioceover

			self.speaker = not self.dialogTabel[self.lineNum].icon and ((not var_66_13 or var_66_13 ~= 1) and "player" or "vioceover") or self.lastIcon == self.dialogTabel[self.lineNum].icon and "old_role" or "new_role"

			local var_66_14 = {}

			var_66_14 = var_66_0 == 1 and var_66_5 or var_66_4

			local var_66_15 = cc.Spawn:create(var_66_11:clone(), cc.MoveTo:create(var_66_10, cc.p(var_66_14[self.inPos].inPos.x, var_66_14[self.inPos].inPos.y)))
			local var_66_16 = cc.Spawn:create(var_66_11:clone(), cc.MoveTo:create(var_66_10, cc.p(self.lastSubPosIn.x, self.lastSubPosIn.y)))
			local var_66_17
			local var_66_18

			if self.lastMainRole and self.role_main == self.lastMainRole then
				var_66_17 = cc.Spawn:create(var_66_12:clone(), cc.MoveTo:create(var_66_10, cc.p(self.lastMainPos.x, self.lastMainPos.y)))
				var_66_18 = cc.Spawn:create(var_66_12:clone(), cc.MoveTo:create(var_66_10, cc.p(self.lastSubPos.x, self.lastSubPos.y)))
			else
				var_66_17 = cc.Spawn:create(var_66_12:clone(), cc.MoveTo:create(var_66_10, cc.p(self.lastSubPos.x, self.lastSubPos.y)))
				var_66_18 = cc.Spawn:create(var_66_12:clone(), cc.MoveTo:create(var_66_10, cc.p(self.lastMainPos.x, self.lastMainPos.y)))
			end

			local function var_66_20()
				self.music_obj = nil

				if self.dialogTabel[self.lineNum].music then
					if not self.talkedTbl["sound/role_voice/" .. self.dialogTabel[self.lineNum].music] then
						self.talkedTbl["sound/role_voice/" .. self.dialogTabel[self.lineNum].music] = "sound/role_voice/" .. self.dialogTabel[self.lineNum].music

						audio_manager:playPlayerSoundTalkLayer("sound/role_voice/" .. self.dialogTabel[self.lineNum].music, false, nil, nil, function(arg_69_0)
							self.music_obj = arg_69_0
						end)
					end

					if self.classification == 3102002 then
						audio_manager:stopbackgroundMusic()
					end
				end
			end

			local function var_66_21()
				self.nextbtn:setVisible(false)

				local var_70_0 = self.dialogTabel[self.lineNum].dec

				if self.wordBack:getChildByName("richTextWord") then
					self.wordBack:getChildByName("richTextWord"):removeFromParent()
				end

				local var_70_1 = require("view.Sprite.RichTextPro"):create()

				var_70_1:setMaxWidth(560)
				var_70_1:setSize(28)
				var_70_1:setLineSpace(0)
				var_70_1:setplayAni(1)

				if not string.find(var_70_0, "^%b<>.+%b<>$") then
					var_70_0 = table.concat({
						"<p>",
						var_70_0,
						"</p>"
					})
				end

				var_70_1:setText(var_70_0, function()
					self.waitPrintText = false
					self.next = true

					if not self.isautoplay then
						self.nextbtn:setVisible(true)
					end
				end, true)
				var_70_1:setPosition(cc.p(40, 220))
				var_70_1:setName("richTextWord")
				self.wordBack:addChild(var_70_1, 100000)
			end

			local function var_66_22()
				self.SpeakerName:stopAllActions()
				self.UIText:stopAllActions()

				local var_72_0 = ""

				var_72_0 = L_EXPLORETALK_SHOWNAME.Show_Name[1] == self.dialogTabel[self.lineNum].showName and playermodel.nickname or self.dialogTabel[self.lineNum].showName

				if L_EXPLORETALK_SHOWNAME.Show_Name[2] == self.dialogTabel[self.lineNum].showName then
					var_72_0 = ""

					self.wordBack:loadTexture("public/talk/new_yourenkuang.png", var_0_5)
					self.namedi:setVisible(false)
				else
					self.wordBack:loadTexture("public/talk/new_yourenkuang.png", var_0_5)
					self.namedi:setVisible(true)
				end

				self.SpeakerName:setOpacity(0)
				self.SpeakerName:setString(var_72_0)
				self.SpeakerName:runAction(var_66_11:clone())
				var_66_21()
				var_66_20()
			end

			if self.speaker == "player" then
				(function()
					if self.existRole == 0 then
						var_66_22()
					elseif self.existRole == 1 then
						if var_66_0 == 1 then
							-- block empty
						else
							self.role_main:stopAllActions()
							self.role_sub:stopAllActions()
							self.expression_main:stopAllActions()
							self.expression_sub:stopAllActions()
							self.role_main:runAction(var_66_17:clone())
							self.expression_main:runAction(var_66_17:clone())
							self.role_sub:runAction(var_66_18:clone())
							self.expression_sub:runAction(var_66_18:clone())

							self.existRole = 0
						end

						var_66_22()
					elseif self.existRole == 2 then
						if var_66_0 == 1 then
							-- block empty
						else
							self.role_main:stopAllActions()
							self.role_sub:stopAllActions()
							self.expression_main:stopAllActions()
							self.expression_sub:stopAllActions()
							self.role_main:runAction(var_66_17:clone())
							self.expression_main:runAction(var_66_17:clone())
							self.role_sub:runAction(var_66_18:clone())
							self.expression_sub:runAction(var_66_18:clone())

							self.existRole = 0
						end

						var_66_22()
					end
				end)()
			elseif self.speaker == "old_role" then
				(function()
					if self.existRole == 0 then
						-- block empty
					elseif self.existRole == 1 then
						-- block empty
					elseif self.existRole ~= 2 or var_66_0 == 1 then
						-- block empty
					else
						self.role_sub:stopAllActions()
						self.expression_sub:stopAllActions()
						self.expression_sub:runAction(var_66_17:clone())
						self.role_sub:runAction(var_66_17:clone())
						self.role_main:runAction(var_66_15:clone())
						self.expression_main:runAction(var_66_15:clone())

						self.existRole = 1
					end

					var_66_22()
				end)()
			elseif self.speaker == "new_role" then
				(function()
					if self.existRole == 0 then
						if self.lineNum == 1 then
							self.role_main:stopAllActions()
							self.expression_main:stopAllActions()
							var_66_22()

							self.existRole = 1

							self.role_main:setPosition(cc.p(var_66_14[self.inPos].inPos.x, var_66_14[self.inPos].inPos.y))
							self.expression_main:setPosition(cc.p(var_66_14[self.inPos].inPos.x, var_66_14[self.inPos].inPos.y))
						else
							self.role_main:stopAllActions()
							self.expression_main:stopAllActions()
							self.role_main:setPosition(cc.p(var_66_14[self.inPos].outPos.x, var_66_14[self.inPos].outPos.y))
							self.expression_main:setPosition(cc.p(var_66_14[self.inPos].outPos.x, var_66_14[self.inPos].outPos.y))
							self.role_main:runAction(var_66_15:clone())
							self.expression_main:runAction(var_66_15:clone())
							var_66_22()

							self.existRole = 1
						end
					elseif self.existRole == 1 then
						if var_66_0 == 1 then
							self.role_main:stopAllActions()
							self.expression_main:stopAllActions()
							self.role_sub:stopAllActions()
							self.expression_sub:stopAllActions()
							self.role_main:setPosition(cc.p(var_66_14[self.inPos].outPos.x, var_66_14[self.inPos].outPos.y))
							self.expression_main:setPosition(cc.p(var_66_14[self.inPos].outPos.x, var_66_14[self.inPos].outPos.y))
							self.role_sub:runAction(var_66_16:clone())
							l2utils:shaderDarkNode(self.role_sub)
							l2utils:shaderDarkNode(self.expression_sub)
							self.expression_sub:runAction(var_66_16:clone())
							self.role_main:runAction(var_66_15:clone())
							self.expression_main:runAction(var_66_15:clone())
							var_66_22()

							self.existRole = 2
						else
							self.role_main:stopAllActions()
							self.expression_main:stopAllActions()
							self.role_sub:stopAllActions()
							self.expression_sub:stopAllActions()

							if self.lastMainRole and self.role_main == self.lastMainRole then
								local var_75_0 = cc.Sequence:create(cc.CallFunc:create(function()
									self.role_main:setPosition(cc.p(var_66_14[self.inPos].outPos.x, var_66_14[self.inPos].outPos.y))
									self.expression_main:setPosition(cc.p(var_66_14[self.inPos].outPos.x, var_66_14[self.inPos].outPos.y))
								end), var_66_15:clone())

								self.role_main:runAction(var_75_0:clone())
								self.expression_main:runAction(var_75_0:clone())
							else
								self.role_main:setPosition(cc.p(var_66_14[self.inPos].outPos.x, var_66_14[self.inPos].outPos.y))
								self.expression_main:setPosition(cc.p(var_66_14[self.inPos].outPos.x, var_66_14[self.inPos].outPos.y))
								self.role_main:runAction(var_66_15:clone())
								self.expression_main:runAction(var_66_15:clone())
							end

							self.role_sub:runAction(var_66_18:clone())
							self.expression_sub:runAction(var_66_18:clone())
							var_66_22()

							self.existRole = 1
						end
					elseif self.existRole == 2 then
						if var_66_0 == 1 then
							l2utils:shaderDarkNode(self.role_sub)
							l2utils:shaderDarkNode(self.expression_sub)

							self.existRole = 2
						else
							self.role_main:setPosition(cc.p(var_66_14[self.inPos].outPos.x, var_66_14[self.inPos].outPos.y))
							self.expression_main:setPosition(cc.p(var_66_14[self.inPos].outPos.x, var_66_14[self.inPos].outPos.y))
							self.role_main:stopAllActions()
							self.expression_main:stopAllActions()
							self.role_main:runAction(var_66_15:clone())
							self.expression_main:runAction(var_66_15:clone())
							self.role_sub:stopAllActions()
							self.expression_sub:stopAllActions()
							self.role_sub:runAction(var_66_18:clone())
							self.expression_sub:runAction(var_66_18:clone())

							self.existRole = 1
						end

						var_66_22()
					end
				end)()
			elseif self.speaker == "vioceover" then
				(function()
					local var_77_0 = string.len(self.dialogTabel[self.lineNum].dec)

					self.effect_layer:setBackGroundColor(cc.c3b(0, 0, 0))
					self.effect_layer:setBackGroundColorOpacity(255)
					self.effect_layer:setOpacity(255)

					if not self.panel_label then
						self.panel_label = cc.Label:createWithTTF("", FONT_DES, 36)

						self.panel_label:setAnchorPoint(cc.p(0, 1))
						self.panel_label:setMaxLineWidth(540)
						self.panel_label:setPosition(cc.p(50, 700 + GameDisplay.fix_y))
						self.effect_layer:addChild(self.panel_label)
					end

					self.waitPrintText = true

					self.effect_layer:runAction(cc.Sequence:create(cc.FadeIn:create(0.1), cc.ActionFloat:create(var_77_0 * 0.04 / 3, 0, var_77_0, function(arg_78_0)
						arg_78_0 = math.min(var_66_6, arg_78_0 + 1)

						self.panel_label:setString((utfsub(self.dialogTabel[self.lineNum].dec, arg_78_0)))

						if arg_78_0 >= var_66_6 then
							self.waitPrintText = false
							self.next = true
						end
					end)))
					self.effect_layer:setVisible(true)
					self.effect_layer:setTouchEnabled(false)
				end)()
			end

			local var_66_23

			if self.dialogTabel[self.lineNum].icon then
				if not model_data[self.dialogTabel[self.lineNum].icon] then
					print("modelid = " .. self.dialogTabel[self.lineNum].icon .. "not exist")
				end

				var_66_23 = "role/" .. model_data[self.dialogTabel[self.lineNum].icon].role_image .. ".png"
			end

			local var_66_24

			if self.dialogTabel[self.lineNum].expression then
				var_66_24 = "expression/" .. model_data[self.dialogTabel[self.lineNum].icon][self.dialogTabel[self.lineNum].expression] .. ".png"
			end

			if var_66_23 then
				self.role_main:setTexture(var_66_23)
				self.role_main:setVisible(true)
			elseif self.lastMainRole == self.role_main then
				self.role_main:setVisible(true)
			else
				self.role_main:setVisible(false)
			end

			if var_66_24 then
				self.expression_main:setVisible(true)
				self.expression_main:setTexture(var_66_24)
			else
				self.expression_main:setVisible(false)
			end

			local function var_66_25(arg_80_0, arg_80_1, arg_80_2)
				self.next = false
				isPlayEFfect = true

				local var_80_0 = cc.MoveTo:create(arg_80_0, cc.p(arg_80_1, arg_80_2))

				if var_66_8 == 0 then
					self.LeftPlayer:runAction(cc.Sequence:create(var_80_0:clone()))
					self.LeftPlayerExpression:runAction(var_80_0:clone())
				else
					self.RightPlayer:runAction(cc.Sequence:create(var_80_0:clone()))
					self.RightPlayerExpression:runAction(var_80_0:clone())
				end
			end

			local function var_66_26(arg_81_0, arg_81_1, arg_81_2)
				self.next = false
				isPlayEffect = true

				local var_81_0 = cc.ScaleTo:create(arg_81_0, arg_81_1, arg_81_2)

				if var_66_8 == 0 then
					self.LeftPlayer:runAction(cc.Sequence:create(var_81_0:clone()))
					self.LeftPlayerExpression:runAction(var_81_0:clone())
				else
					self.RightPlayer:runAction(cc.Sequence:create(var_81_0:clone()))
					self.RightPlayerExpression:runAction(var_81_0:clone())
				end
			end

			local function var_66_27(arg_82_0)
				self.next = false
				isPlayEFfect = true

				if arg_82_0 ~= 255 then
					self.LeftPlayer:setColor(cc.c3b(130, 130, 130))
					self.LeftPlayerExpression:setColor(cc.c3b(130, 130, 130))
					self.RightPlayer:setColor(cc.c3b(130, 130, 130))
					self.RightPlayerExpression:setColor(cc.c3b(130, 130, 130))
				else
					local var_82_0 = 255

					self.LeftPlayer:setColor(cc.c3b(255, 255, 255))
					self.LeftPlayerExpression:setColor(cc.c3b(var_82_0, var_82_0, var_82_0))
					self.RightPlayer:setColor(cc.c3b(var_82_0, var_82_0, var_82_0))
					self.RightPlayerExpression:setColor(cc.c3b(var_82_0, var_82_0, var_82_0))
				end
			end

			if self.dialogTabel[self.lineNum].shake_role then
				(function(arg_79_0, arg_79_1)
					self.next = false
					isPlayEffect = true

					local var_79_0 = {}

					for iter_79_0 = 1, 3 do
						var_79_0[iter_79_0] = cc.Sequence:create(cc.MoveBy:create(0.05 / (iter_79_0 * iter_79_0), cc.p(arg_79_0 * 10 / iter_79_0, arg_79_1 * 10 / iter_79_0)), cc.MoveBy:create(0.05 / (iter_79_0 * iter_79_0), cc.p(-(arg_79_0 * 10 / iter_79_0), -(arg_79_1 * 10 / iter_79_0))), cc.MoveBy:create(0.05 / (iter_79_0 * iter_79_0), cc.p(-(arg_79_0 * 10 / iter_79_0), -(arg_79_1 * 10 / iter_79_0))), cc.MoveBy:create(0.05 / (iter_79_0 * iter_79_0), cc.p(arg_79_0 * 10 / iter_79_0, arg_79_1 * 10 / iter_79_0)))
					end

					local var_79_1 = cc.DelayTime:create(0.3)

					if var_66_8 == 0 then
						self.LeftPlayer:runAction(cc.Sequence:create(var_79_1, var_79_0[1]:clone(), var_79_0[2]:clone(), var_79_0[3]:clone()))
						self.LeftPlayerExpression:runAction(cc.Sequence:create(var_79_1, var_79_0[1]:clone(), var_79_0[2]:clone(), var_79_0[3]:clone()))
					else
						self.RightPlayer:runAction(cc.Sequence:create(var_79_1, var_79_0[1]:clone(), var_79_0[2]:clone(), var_79_0[3]:clone()))
						self.RightPlayerExpression:runAction(cc.Sequence:create(var_79_1, var_79_0[1]:clone(), var_79_0[2]:clone(), var_79_0[3]:clone()))
					end
				end)(2, 5)
			end

			if self.dialogTabel[self.lineNum].opacity then
				var_66_27(self.dialogTabel[self.lineNum].opacity)
			else
				var_66_27(255)
			end

			if self.dialogTabel[self.lineNum].move_role then
				var_66_25(self.dialogTabel[self.lineNum].move_role_time or 0.3, self.dialogTabel[self.lineNum].move_role_pos_x, self.dialogTabel[self.lineNum].move_role_pos_y)
			end

			if self.dialogTabel[self.lineNum].zoom_role then
				var_66_26(self.dialogTabel[self.lineNum].zoom_role_time or 0.3, self.dialogTabel[self.lineNum].scale_x, self.dialogTabel[self.lineNum].scale_y)
			end

			self.lastIcon = self.dialogTabel[self.lineNum].icon
			self.lastMainRole = self.role_main
			self.lastMainPos = {
				x = var_66_14[self.inPos].outPos.x,
				y = var_66_14[self.inPos].outPos.y
			}
			self.lastSubPos = {
				x = var_66_14[self.outPos].outPos.x,
				y = var_66_14[self.outPos].outPos.y
			}
			self.lastSubPosIn = self.outPos == "left" and {
				x = var_66_5.right.inPos.x,
				y = var_66_5.right.inPos.y
			} or {
				x = var_66_5.left.inPos.x,
				y = var_66_5.left.inPos.y
			}

			if config._DEBUG_TALK then
				self:initDebugCom(self.dialogTabel[self.lineNum].icon)
			end
		end)
	else
		if self.waitPrintText then
			self.waitPrintText = false
			self.next = true

			return
		end

		self:exit()
		AnalyticManager.clickStory({
			look_story_type = "finishTalk",
			storyid = self.classType
		})

		if self.finishCallBack then
			self.finishCallBack(self.classType)

			self.finishCallBack = nil
		end
	end
end

function TalkDesSprite:showAll(arg_83_1, arg_83_2)
	if arg_83_2 ~= ccui.TouchEventType.ended then
		return
	end

	local var_83_0 = self.dialogTabel[self.lineNum].dec

	if not self.dialogTabel[self.lineNum].dec then
		return
	end

	if self.wordBack:getChildByName("richTextWord") then
		self.wordBack:getChildByName("richTextWord"):removeFromParent()
	end

	local var_83_1 = require("view.Sprite.RichTextPro"):create()

	var_83_1:setMaxWidth(560)
	var_83_1:setSize(28)
	var_83_1:setLineSpace(0)

	if not string.find(var_83_0, "^%b<>.+%b<>$") then
		var_83_0 = table.concat({
			"<p>",
			var_83_0,
			"</p>"
		})
	end

	var_83_1:setText(var_83_0, callback, true)
	var_83_1:setPosition(cc.p(40, 220))
	var_83_1:setName("richTextWord")
	self.wordBack:addChild(var_83_1, 100000)

	self.waitPrintText = false
	self.next = true

	if not self.isautoplay then
		self.nextbtn:setVisible(true)
	end
end

function TalkDesSprite:initConversation(arg_84_1)
	self.lineNum = 0
	self.dialogTabel = {}
	self.effectTable = {}
	self.classType = arg_84_1

	for iter_84_0, iter_84_1 in pairs(conversation_data) do
		if iter_84_1.classification == self.classType then
			table.insert(self.dialogTabel, iter_84_1)
		end
	end

	table.sort(self.dialogTabel, function(arg_85_0, arg_85_1)
		return arg_85_0.id < arg_85_1.id
	end)
	AnalyticManager.clickStory({
		look_story_type = "enterTalk",
		storyid = arg_84_1
	})
end

function TalkDesSprite:reviewConversation()
	local var_86_1 = self.review_list:clone()

	var_86_1:setVisible(true)
	var_86_1:setContentSize(GameDisplay.getScreenSize())

	if self.parenttype and self.parenttype == 1 then
		var_86_1:setPositionY(var_86_1:getPositionY() - GameDisplay.fix_y)
	end

	local var_86_2 = self.review_area:clone()

	var_86_2:setContentSize(cc.size(640, 66))
	var_86_1:pushBackCustomItem(var_86_2)

	for iter_86_0 = 1, #self.reviewDialogTabel do
		local var_86_3 = self.review_area:clone()

		var_86_3:setVisible(true)

		local var_86_4 = cc.Label:createWithTTF("", FONT_DES, 24)

		var_86_4:setAnchorPoint(cc.p(0, 0))

		if self.reviewDialogTabel[iter_86_0].showName then
			var_86_4:setString(self.reviewDialogTabel[iter_86_0].showName .. ":" or playermodel.nickname .. ":" or L_EXPLORETALK_SHOWNAME.Show_Name[2] .. ":")
		else
			var_86_4:setString(L_EXPLORETALK_SHOWNAME.Show_Name[2] .. ":")
		end

		if var_86_4:getString() == L_EXPLORETALK_ME .. ":" then
			var_86_4:setString(L_MONITOR .. ":")
		end

		var_86_3:addChild(var_86_4)

		local var_86_6 = self.reviewDialogTabel[iter_86_0].dec
		local var_86_7 = require("view.Sprite.RichTextPro"):create()

		var_86_7:setMaxWidth(460)
		var_86_7:setSize(24)
		var_86_7:setLineSpace(0)

		if not string.find(var_86_6, "^%b<>.+%b<>$") then
			var_86_6 = table.concat({
				"<p>",
				var_86_6,
				"</p>"
			})
		end

		var_86_7:setText(var_86_6, nil, true)
		var_86_7:setPosition(cc.p(40, 200))
		var_86_3:addChild(var_86_7, 100000)

		local var_86_8 = var_86_7:getContentHeight()

		var_86_4:setPosition(cc.p(50, var_86_8 - 3))
		var_86_7:setPosition(cc.p(var_86_4:getPositionX() + var_86_4:getContentSize().width, var_86_4:getPositionY() + 24))
		var_86_3:setContentSize(cc.size(640, var_86_8 + var_86_4:getContentSize().height))
		var_86_1:pushBackCustomItem(var_86_3)
	end

	var_86_1:pushBackCustomItem(self.review_area)
	self:addChild(var_86_1)
	var_86_1:addTouchEventListener(function(arg_87_0, arg_87_1)
		if arg_87_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_87_0:getTouchBeganPosition().y - arg_87_0:getTouchEndPosition().y) < 10 then
			var_86_1:runAction(cc.RemoveSelf:create())

			if self.isautoplay then
				self:openOrcloseAuto(true)
			end
		end
	end)
end

function TalkDesSprite:setBackGroundOpacity(arg_88_1)
	ccui.Helper:seekWidgetByName(self.rootLayout, "panel_back"):setBackGroundColorOpacity(arg_88_1)
end

function TalkDesSprite:fullScreen()
	parent = self.rootLayout

	local var_89_0 = GameDisplay.getScreenSize()

	for iter_89_0, iter_89_1 in pairs({
		panel_1 = parent,
		panel_2 = parent:getChildByName("background"),
		panel_3 = parent:getChildByName("effect_panel"),
		panel_4 = parent:getChildByName("panel_access_effect"),
		panel_6 = parent:getChildByName("my_select_Panel")
	}) do
		iter_89_1:setContentSize(var_89_0)

		if iter_89_0 == "panel_1" and self.parenttype and self.parenttype == 1 then
			iter_89_1:setPositionY(iter_89_1:getPositionY() - GameDisplay.fix_y)
		elseif iter_89_0 == "panel_2" and not self.parenttype then
			iter_89_1:setPositionY(iter_89_1:getPositionY() + GameDisplay.fix_y)
		end
	end

	local var_89_1 = GameDisplay.getScreenSize().height - config._DESIGN_HEIGHT

	self.wordBack:setPositionY(var_89_0.height * 0.18)

	local var_89_3 = var_89_0.height * 0.18 - 204

	if self.parenttype and self.parenttype == 1 then
		-- block empty
	else
		self.wordBack:setPositionY(self.wordBack:getPositionY() - GameDisplay.fix_y)
	end

	self.SpeakerName:setPositionY(self.wordBack:getPositionY() + 30)
	self.LastName:setPositionY(self.wordBack:getPositionY() + 30)
	self.btn_autoplay:setPositionY(var_89_0.height * 0.18 + 30)
	self.nextbtn:setPositionY(84 - var_89_3)

	self.displayPos = global_get_node_display_posy(parent, {
		button_review = {
			posY = 38,
			focusName = "button_review",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PX
		},
		button_skip = {
			posY = 38,
			focusName = "button_skip",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PX
		}
	})

	for iter_89_2, iter_89_3 in pairs(self.displayPos) do
		local var_89_6 = ccui.Helper:seekWidgetByName(parent, iter_89_2)

		if var_89_6 then
			if self.parenttype and self.parenttype == 1 then
				var_89_6:setPositionY(iter_89_3)
			elseif iter_89_2 == "button_review" or iter_89_2 == "button_skip" then
				var_89_6:setPositionY(GameDisplay.top - GameDisplay.notch_height - 38)
			else
				var_89_6:setPositionY(iter_89_3)
			end
		end
	end
end

function TalkDesSprite:exit()
	ccui.Helper:seekWidgetByName(self.rootLayout, "panel_back"):setVisible(false)
	self.expression_main:setVisible(false)
end
