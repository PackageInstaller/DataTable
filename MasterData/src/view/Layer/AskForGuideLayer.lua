AskForGuideLayer = class("AskForGuideLayer", function()
	return cc.Layer:create()
end)

function AskForGuideLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = AskForGuideLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function AskForGuideLayer:init(arg_3_1)
	local var_3_0 = ccui.Layout:create()

	var_3_0:setContentSize(cc.size(640, 1600))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setCascadeOpacityEnabled(false)
	var_3_0:setBackGroundColorOpacity(180)
	var_3_0:setAnchorPoint(0.5, 0.5)
	var_3_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_3_0:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_3_0:setTouchEnabled(true)
	var_3_0:setLocalZOrder(1000)
	var_3_0:setVisible(true)
	self:addChild(var_3_0)

	local var_3_1 = ccui.ImageView:create("mainScenebg/other/guide_bg.png")

	var_3_1:setPosition(cc.p(320, 500 + GameDisplay.fix_y))
	self:addChild(var_3_1, 9999)

	local var_3_2 = cc.Label:createWithTTF("    班长是否了解魂器学院的玩法和内容？\n\n    选择我已了解后学院终端会关闭一部分引导", FONT_NAME, 28)

	var_3_2:setWidth(400)
	var_3_2:setPosition(cc.p(var_3_1:getContentSize().width / 2 - 100, var_3_1:getContentSize().height / 2 + 80))
	var_3_1:addChild(var_3_2)

	local var_3_3 = ccui.Button:create("mainScenebg/other/new_player_Btn.png")

	var_3_3:setPosition(cc.p(170, 280))
	var_3_1:addChild(var_3_3)

	local var_3_4 = ccui.Button:create("mainScenebg/other/old_player_btn.png")

	var_3_4:setPosition(cc.p(470, 280))
	var_3_1:addChild(var_3_4)

	self.newplayerBtn = var_3_3
	self.oldplayerBtn = var_3_4
end

function AskForGuideLayer:addNewPlayerTouchListener(arg_4_1)
	self.newplayerBtn:addTouchEventListener(arg_4_1)
end

function AskForGuideLayer:addOldPlayerTouchListener(arg_5_1)
	self.oldplayerBtn:addTouchEventListener(arg_5_1)
end
