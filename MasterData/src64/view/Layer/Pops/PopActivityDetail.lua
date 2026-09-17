PopActivityDetail = class("PopActivityDetail", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Layer.PopLayer")

local var_0_0 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local detail_data = require("data.detail_data")
local var_0_3 = "PopActivityDetail/info_"
local var_0_4 = {
	CANACTIVE = 4,
	HAVEACTIVATED = 0,
	UNLEVELUP = 3,
	UNACTIVE_NONE = 1,
	UNACTIVE_UNALL = 2,
	CANLEVELUP = 5
}

function PopActivityDetail.create(arg_2_0, arg_2_1)
	local var_2_0 = PopActivityDetail.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopActivityDetail:init(arg_3_1)
	self.msg = arg_3_1
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopActivityDetail.json" or "PopActivityDetail.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.callback = arg_3_1.callback
	self.key = arg_3_1.key
	self.type = arg_3_1.type

	self:initUI()
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" and self.callback then
			self.callback()
		end
	end)
end

function PopActivityDetail:initUI()
	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_1")

	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2 + 64)

	self.scrollpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView")

	self:initReturnListener()
	self:initStyle()
	self:checkDetailData()

	if self.key == "bond_detail" then
		self:initBondUI()
	elseif self.key == "bond_story" then
		self:initStoryUI()
	elseif self.key == "teamSkill" then
		self:initTeamSkillUI()
	elseif self.key == "teamRes" then
		self:initElementRestrainUI()

		return
	else
		self:initscrollPanel()
	end
end

function PopActivityDetail:checkDetailData()
	if not detail_data[self.key] then
		hx_print("detailData:  " .. self.key .. "  没填", CONSOLE_COLOR_PINK)
	end
end

function PopActivityDetail:initStyle()
	local var_7_0

	if detail_data[self.key] then
		var_7_0 = detail_data[self.key].title or "没填"

		if self.testTitle then
			var_7_0 = self.testTitle
		end
	end

	self.tip = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_7")

	self.tip:setString(var_7_0)

	if detail_data[self.key] and detail_data[self.key].style then
		self.rootpanel:loadTexture(var_0_3 .. detail_data[self.key].style .. ".png", var_0_0)
	end
end

function PopActivityDetail:initReturnListener()
	local function var_8_0(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end

	self.surebtn = ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure")

	self:createFullScreenMask(var_8_0, 120)
	self.surebtn:addTouchEventListener(var_8_0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "label"):setString(L_BUTTON_TEXT.Sure)
end

function PopActivityDetail:initBg(arg_10_1)
	local var_10_0 = ccui.Layout:create()

	var_10_0:setTouchEnabled(true)
	var_10_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_10_0:setAnchorPoint(cc.p(0, 0))
	var_10_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_10_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_10_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_10_0:setOpacity(0)
	var_10_0:setCascadeOpacityEnabled(false)
	self:addChild(var_10_0, -1)

	local var_10_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_10_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_10_1:setPositionX(var_10_0:getContentSize().width / 2)
	var_10_1:setPositionY(var_10_0:getContentSize().height / 2)
	var_10_0:addChild(var_10_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_11_0)
		self:addChild(arg_11_0, -2)
		arg_11_0:setPositionY(arg_11_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_10_1)
		var_10_0:setOpacity(102)
	end)
end

function PopActivityDetail:exit()
	self.hideActions.shrinkBoth(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopActivityDetail:initscrollPanel()
	local var_14_0 = self.testWords or detail_data[self.key].text or "<p>" .. self.key .. "没填</p>"

	if not var_14_0:find("<p>") and not var_14_0:find("</p>") then
		var_14_0 = "<p>" .. self.key .. "</p>"
	end

	local var_14_1 = require("view.Sprite.RichTextPro"):create()

	var_14_1:setMaxWidth(450)
	var_14_1:setText(var_14_0)

	local var_14_2 = var_14_1:getContentHeight()

	var_14_1:setAnchorPoint(cc.p(0, 1))
	self.scrollpanel:addChild(var_14_1)

	local var_14_3 = self.scrollpanel:getContentSize()

	self.scrollpanel:setContentSize(cc.size(var_14_3.width + 20, var_14_3.height))

	local var_14_4 = var_14_1:getContentHeight()

	if var_14_4 > 770 then
		self.scrollpanel:setInnerContainerSize(cc.size(580, var_14_4 + 150))
		var_14_1:setPositionY(var_14_4 + 150)
	else
		self.scrollpanel:setInnerContainerSize(cc.size(580, 770))
	end

	var_14_1:setPosition(cc.p(0, self.scrollpanel:getInnerContainerSize().height))
end

function PopActivityDetail:initBondUI()
	local bond_manager = require("controller.bond_manager")
	local var_15_1 = {
		[0] = "BondLayer/bondDetail/level1.png",
		"BondLayer/bondDetail/level2.png",
		"BondLayer/bondDetail/level3.png",
		"BondLayer/bondDetail/level4.png"
	}

	self.itemNode = ccui.Layout:create()

	self.itemNode:setTouchEnabled(true)
	self.itemNode:setName("item")
	self.rootpanel:addChild(self.itemNode)

	local var_15_2 = ccui.ImageView:create()

	var_15_2:setName("icon")
	var_15_2:setPosition(cc.p(0, 50))
	self.itemNode:addChild(var_15_2)

	local var_15_3 = ccui.Text:create("", "fonts/name.ttf", 24)

	var_15_3:setName("name")
	var_15_3:setAnchorPoint(cc.p(0, 0.5))
	var_15_3:setPosition(cc.p(50, 70))
	self.itemNode:addChild(var_15_3)

	local var_15_4 = ccui.Text:create("", "fonts/name.ttf", 20)

	var_15_4:setAnchorPoint(cc.p(0, 0.5))
	var_15_4:setPosition(cc.p(50, 40))
	var_15_4:setName("des")
	self.itemNode:addChild(var_15_4)
	self.itemNode:setVisible(false)

	local var_15_5 = ccui.Button:create("BondLayer/operate_active.png", "BondLayer/operate_active.png", "BondLayer/operate_active.png", var_0_0)

	var_15_5:setName("btn_operate")
	var_15_5:setPosition(cc.p(360, 50))
	var_15_5:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("跳转到羁绊系统")
		self.hideActions.shrinkBoth(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
		LayerManager:pushInLayer("BondLayer", {
			jumpToBond = 1,
			bondExitCallback = function()
				LayerManager:switchShowLayer("FightLayer", {
					jumpToBattleArray = true
				})
			end
		})
		AnalyticManager.clickActivityEntranceType({
			jumpid = 1002,
			enterType = "BondLayer"
		})
	end)
	self.itemNode:addChild(var_15_5)

	local var_15_6 = self.rootpanel:getChildByName("button_sure")

	self.rootpanel:getChildByName("ScrollView"):setVisible(false)
	var_15_6:getChildByName("label"):setString(L_BOND_TIPS.DETAIL_PANEL.GOTO_BOND)
	self.rootpanel:getChildByName("Label_7"):setString(L_BOND_TIPS.DETAIL_PANEL.TITLE)
	var_15_6:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("跳转到羁绊系统")
		self.hideActions.shrinkBoth(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
		LayerManager:pushInLayer("BondLayer", {
			jumpToBond = 1,
			bondExitCallback = function()
				LayerManager:switchShowLayer("FightLayer", {
					jumpToBattleArray = true
				})
			end
		})
		AnalyticManager.clickActivityEntranceType({
			jumpid = 1002,
			enterType = "BondLayer"
		})
	end)

	local var_15_7

	if self.type == 1 then
		var_15_7 = bond_manager:getEnemyBondInfo()

		var_15_6:setVisible(false)
	else
		var_15_7 = bond_manager:getBondInfo()

		var_15_6:setVisible(true)
	end

	if var_15_7 == nil then
		return
	end

	local var_15_8 = var_15_7

	if self.listViewNode ~= nil then
		self.listViewNode:removeFromParent()
	end

	self.listViewNode = self:getTableView(var_15_8, #var_15_7, cc.size(470, 100), cc.size(470, 770), function(arg_22_0, arg_22_1, arg_22_2)
		local var_22_0 = arg_22_2[arg_22_1 + 1]
		local var_22_2 = arg_22_0:dequeueCell()

		if var_22_2 == nil then
			var_22_2 = cc.TableViewCell:new()
		end

		local var_22_3 = var_22_2:getChildByName("item")

		if var_22_3 == nil then
			var_22_3 = self.itemNode:clone()

			var_22_2:addChild(var_22_3)
			var_22_3:setPosition(cc.p(50, 0))
			var_22_3:setName("item")
			var_22_3:setVisible(true)
		end

		local var_22_4 = var_22_3:getChildByName("icon")
		local var_22_5 = var_22_3:getChildByName("name")
		local var_22_6 = var_22_3:getChildByName("des")
		local var_22_7 = var_22_3:getChildByName("btn_operate")

		var_22_5:setPositionY(64)
		var_22_6:setPositionY(34)
		var_22_4:loadTexture(var_15_1[var_22_0.curLevel], var_0_0)
		var_22_5:setString(var_22_0.name)
		var_22_6:setString(var_22_0.des)

		if var_22_0.curLevel == 0 then
			var_22_5:setColor(cc.c3b(148, 144, 154))
			var_22_6:setColor(cc.c3b(196, 187, 221))
		else
			if var_22_0.curLevel < 3 then
				var_22_5:setColor(cc.c3b(237, 240, 255))
			else
				var_22_5:setColor(cc.c3b(254, 255, 237))
			end

			var_22_6:setColor(cc.c3b(255, 216, 133))
		end

		var_22_7:setVisible((var_22_0.bondStatus == var_0_4.CANACTIVE or var_22_0.bondStatus == var_0_4.CANLEVELUP) and self.type ~= 1)

		if var_22_0.bondStatus == var_0_4.CANACTIVE then
			var_22_7:loadTextures("BondLayer/operate_active.png", "BondLayer/operate_active.png", "BondLayer/operate_active.png", var_0_0)
		elseif var_22_0.bondStatus == var_0_4.CANLEVELUP then
			var_22_7:loadTextures("BondLayer/operate_level.png", "BondLayer/operate_level.png", "BondLayer/operate_level.png", var_0_0)
		end

		return var_22_2
	end, function(arg_23_0, arg_23_1)
		print("click ")
	end)

	self.listViewNode:setPosition(cc.p(26, 35))
	self.listViewNode:setTouchEnabled(true)
	self.rootpanel:addChild(self.listViewNode, 1)

	local var_15_9 = ccui.Layout:create()

	var_15_9:setPosition(cc.p(26, 35))
	var_15_9:setContentSize(cc.size(444, 770))
	var_15_9:setTouchEnabled(true)
	self.rootpanel:addChild(var_15_9)
	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkBoth(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
end

function PopActivityDetail.getTableView(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6)
	local var_26_0 = arg_26_3.width
	local var_26_1 = arg_26_3.height
	local var_26_2 = cc.TableView:create(arg_26_4)

	var_26_2:setVisible(true)
	var_26_2:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_26_2:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_26_2:setDelegate()
	var_26_2:registerScriptHandler(function(arg_27_0)
		return arg_26_2
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_26_2:registerScriptHandler(function(arg_28_0)
		arg_26_0:scrollViewDidScroll(arg_28_0)
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	var_26_2:registerScriptHandler(function(arg_29_0, arg_29_1)
		arg_26_6(arg_29_0, arg_29_1)
	end, cc.TABLECELL_TOUCHED)
	var_26_2:registerScriptHandler(function(arg_30_0, arg_30_1)
		return var_26_0, var_26_1
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_26_2:registerScriptHandler(function(arg_31_0, arg_31_1)
		return arg_26_5(arg_31_0, arg_31_1, arg_26_1)
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_26_2:reloadData()
	var_26_2:setAnchorPoint(cc.p(0, 1))

	return var_26_2
end

function PopActivityDetail.scrollViewDidScroll(arg_32_0, arg_32_1)
	return
end

function PopActivityDetail:initElementRestrainUI()
	self.testTitle = self.msg.testTitle

	local var_33_0 = self.testTitle or "没填"

	self.tip = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_7")

	self.tip:setString(var_33_0)

	self.scrollpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView")

	local var_33_1 = ccui.ImageView:create("Activity_halloween/info_res.png", var_0_0)

	var_33_1:setName("content")
	var_33_1:setPosition(cc.p(self.scrollpanel:getContentSize().width / 2, 490))
	var_33_1:setAnchorPoint(cc.p(0.5, 0.5))
	self.scrollpanel:addChild(var_33_1)

	local function var_33_2(arg_34_0, arg_34_1)
		if arg_34_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkBoth(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end

	self.surebtn = ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure")

	self:createFullScreenMask(var_33_2, 120)
	self.surebtn:addTouchEventListener(var_33_2)
end

function PopActivityDetail:initStoryUI()
	self.testTitle = self.msg.testTitle
	self.testWords = self.msg.testWords
	self.scrollpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView")

	local var_36_0 = self.testTitle or "没填"

	self.tip = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_7")

	self.tip:setString(var_36_0)

	local var_36_1 = self.testWords or "<p>" .. self.key .. "没填</p>"

	if not var_36_1:find("<p>") and not var_36_1:find("</p>") then
		var_36_1 = "<p>" .. self.key .. "</p>"
	end

	local var_36_2 = require("view.Sprite.RichTextPro"):create()

	var_36_2:setMaxWidth(450)
	var_36_2:setText(var_36_1)

	local var_36_3 = var_36_2:getContentHeight()

	var_36_2:setAnchorPoint(cc.p(0, 1))
	self.scrollpanel:addChild(var_36_2)

	local var_36_4 = self.scrollpanel:getContentSize()

	self.scrollpanel:setContentSize(cc.size(var_36_4.width + 20, var_36_4.height))

	local var_36_5 = var_36_2:getContentHeight()

	if var_36_5 > 770 then
		self.scrollpanel:setInnerContainerSize(cc.size(580, var_36_5 + 150))
		var_36_2:setPositionY(var_36_5 + 150)
	else
		self.scrollpanel:setInnerContainerSize(cc.size(580, 770))
	end

	var_36_2:setPosition(cc.p(0, self.scrollpanel:getInnerContainerSize().height))
end

function PopActivityDetail:initTeamSkillUI()
	local var_37_0 = self.msg.teamSkill

	self.scrollpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView")

	local var_37_1 = self.testTitle or L_POPACTDETAIL[1]

	self.tip = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_7")

	self.tip:setString(var_37_1)

	local var_37_2 = ccui.ImageView:create("PopActivityDetail/team_skill.png", var_0_0)

	var_37_2:setAnchorPoint(cc.p(0, 1))
	self.scrollpanel:addChild(var_37_2)

	local var_37_3 = cc.Label:createWithTTF(L_POPACTDETAIL[2], FONT_TITLE, 16)

	var_37_3:setPosition(cc.p(var_37_2:getContentSize().width / 2 - 4, var_37_2:getContentSize().height / 2))
	var_37_2:addChild(var_37_3)

	local var_37_4 = 60

	for iter_37_0, iter_37_1 in pairs(var_37_0) do
		local var_37_5 = ccui.ImageView:create("BaseFormationLayer/icon_" .. iter_37_1.icon .. ".png", var_0_0)

		var_37_5:setPositionX(60)
		var_37_5:setScale(1.2)
		var_37_5:setName("icon" .. iter_37_0)
		self.scrollpanel:addChild(var_37_5)

		local var_37_6 = cc.Label:createWithTTF(iter_37_1.des, FONT_TITLE, 24)

		var_37_6:setAnchorPoint(cc.p(0, 0.5))
		var_37_6:setPositionX(135)
		var_37_6:setName("sklLbl" .. iter_37_0)
		self.scrollpanel:addChild(var_37_6)

		var_37_4 = var_37_4 + var_37_6:getContentSize().height + 40
	end

	local var_37_7 = ccui.ImageView:create("PopActivityDetail/skill_all.png", var_0_0)

	var_37_7:setAnchorPoint(cc.p(0, 1))
	self.scrollpanel:addChild(var_37_7)

	local var_37_8 = cc.Label:createWithTTF(L_POPACTDETAIL[3], FONT_TITLE, 25)

	var_37_8:setPosition(cc.p(var_37_7:getContentSize().width / 2 - 4, var_37_7:getContentSize().height / 2))
	var_37_7:addChild(var_37_8)

	local var_37_9 = self.testWords or detail_data[self.key].text or "<p>" .. self.key .. L_POPACTDETAIL[4]

	if not var_37_9:find("<p>") and not var_37_9:find("</p>") then
		var_37_9 = "<p>" .. self.key .. "</p>"
	end

	local var_37_10 = require("view.Sprite.RichTextPro"):create()

	var_37_10:setMaxWidth(450)
	var_37_10:setText(var_37_9)

	local var_37_11 = var_37_10:getContentHeight()

	var_37_10:setAnchorPoint(cc.p(0, 1))
	self.scrollpanel:addChild(var_37_10)

	local var_37_12 = self.scrollpanel:getContentSize()

	self.scrollpanel:setContentSize(cc.size(var_37_12.width + 20, var_37_12.height))

	local var_37_13 = var_37_10:getContentHeight() + var_37_4

	if var_37_13 > 770 then
		self.scrollpanel:setInnerContainerSize(cc.size(580, var_37_13 + 200))
		var_37_10:setPositionY(var_37_13 + 150)
	else
		self.scrollpanel:setInnerContainerSize(cc.size(580, 770))
	end

	var_37_2:setPosition(cc.p(-10, self.scrollpanel:getInnerContainerSize().height - 2))

	local var_37_14 = 60

	for iter_37_2, iter_37_3 in pairs(var_37_0) do
		local var_37_15 = self.scrollpanel:getChildByName("icon" .. iter_37_2)
		local var_37_16 = self.scrollpanel:getChildByName("sklLbl" .. iter_37_2)

		var_37_16:setPositionY(self.scrollpanel:getInnerContainerSize().height - var_37_14)
		var_37_15:setPositionY(self.scrollpanel:getInnerContainerSize().height - var_37_14)

		var_37_14 = var_37_14 + var_37_16:getContentSize().height + 40
	end

	var_37_7:setPosition(cc.p(0, self.scrollpanel:getInnerContainerSize().height - var_37_14 + 16))
	var_37_10:setPosition(cc.p(0, self.scrollpanel:getInnerContainerSize().height - var_37_14))
end
