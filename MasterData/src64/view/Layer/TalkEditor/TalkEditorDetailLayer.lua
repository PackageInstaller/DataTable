TalkEditorDetailLayer = class("TalkEditorDetailLayer", function()
	return cc.NodeGrid:create()
end)

local model_data = require("data.model_data")
local Utility = require("common.Utility")
local talkeditor_manager = require("controller.talkeditor_manager")
local utf8 = require("controller.utf8")
local var_0_4 = config._DEBUG and 0 or 1
local var_0_6 = TALKEDITOR.EDITOR_STATUS
local var_0_7 = {
	cc.size(1150, 140),
	(cc.size(310, 100))
}
local var_0_8 = {
	{
		name = "sceneEffect",
		key = 1,
		des = "场景效果 格式：闪屏time=counts(1=3) 震屏posx=posy(50=50) 变屏time=color(1=black/white) 转屏time=type(1/2 1是进屏2是出屏) 黑屏time(0.5) 移屏time=posx=posy(0.5=50=50) 缩屏time=scalex=scaley(0.5=0.8=0.8) "
	},
	{
		name = "playerEffect",
		key = 2,
		des = "立绘效果，格式：\n 立绘移动：time=posx=posy(0.5=50=50) \n立绘缩放：time=scalex=scaley(0.5=0.8=0.8) \n立绘震动：posx=posy=actiontype(50=50=2)\n(actiontype 1是once 2是loop)"
	},
	{
		name = "specialEffect",
		key = 3,
		des = "特殊效果，(注意：只能生效一种特效，所以其他特效一定要为空)格式：type(1 一次性的/2 进屏幕/3 出屏幕) "
	},
	{
		name = "otherxuanxiang",
		key = 4,
		des = "其它选项，是否允许跳过，是否允许立绘驻留"
	}
}

function TalkEditorDetailLayer.create(arg_2_0, arg_2_1)
	return (TalkEditorDetailLayer.new(arg_2_1))
end

function TalkEditorDetailLayer:ctor(arg_3_1)
	self.params = arg_3_1
	self.scheduler = cc.Director:getInstance():getScheduler()

	self:onLoad()
	self:init()
end

function TalkEditorDetailLayer:onLoad()
	TextureManager:loadLayerTextures({
		"TalkEditorLayer"
	})

	self.root = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "TalkEditorDetailLayer.json" or "TalkEditorDetailLayer.ExportJson")

	self:addChild(self.root)

	self.consolelayer = self.root:getChildByName("consolelayer")
	self.xuanxianglayer = self.root:getChildByName("xuanxianglayer")

	self.xuanxianglayer:setBackGroundImage("mainScenebg/talk_editor_detail_bg2.png")
	self.consolelayer:setPosition(cc.p(GameDisplay.width / 2, (GameDisplay.height + GameDisplay.fix_y) / 2))
	self.consolelayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.xuanxianglayer:setPosition(cc.p(GameDisplay.width / 2, (GameDisplay.height + GameDisplay.fix_y) / 2))
	self.xuanxianglayer:setAnchorPoint(cc.p(0.5, 0.5))

	self.btn_console_back = self.consolelayer:getChildByName("btn_back")
	self.btn_xuanxiang_back = self.xuanxianglayer:getChildByName("btn_back")

	self.btn_console_back:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:closeDetailPanel()
	end)
	self.btn_xuanxiang_back:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:closeDetailPanel()
	end)
	self.root:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:closeDetailPanel()
	end)
	self.consolelayer:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:updatePropertyDetailPanel()
	end)

	self.xuanxiang_switch = self.xuanxianglayer:getChildByName("xuanxiang_switch")
end

function TalkEditorDetailLayer:closeDetailPanel()
	self.root:setVisible(false)

	if self.editorStatus == var_0_6.CONSOLE then
		self:updateConsoleListInfo()
	elseif self.editorStatus == var_0_6.ADDXUANXIANG then
		self:updateXuanXiangListInfo()
	end

	if self.params.closeCallback then
		self.params.closeCallback({
			curItemInfo = self.curItemInfo
		})
	end
end

function TalkEditorDetailLayer:init()
	self:initInfo()
	self:lateUpdate(function()
		self:initPanel()
	end)
end

function TalkEditorDetailLayer:initInfo()
	self.editorStatus = self.params.editorStatus
	self.curItemInfo = self.params.curItemInfo
end

function TalkEditorDetailLayer:initPanel()
	self:updatePropertyDetailPanel()

	if self.editorStatus == var_0_6.CONSOLE then
		self.consolelayer:setVisible(true)
		self.xuanxianglayer:setVisible(false)
		self:initConsoleLayer()
	elseif self.editorStatus == var_0_6.ADDXUANXIANG then
		self.consolelayer:setVisible(false)
		self.xuanxianglayer:setVisible(true)
		self:initXuanxiangLayer()
	end
end

function TalkEditorDetailLayer:initXuanxiangLayer()
	local var_14_0 = {
		"title1",
		"title2"
	}

	for iter_14_0, iter_14_1 in pairs({
		"xuanxiang_1",
		"xuanxiang_2"
	}) do
		for iter_14_2, iter_14_3 in pairs(var_14_0) do
			local var_14_1 = self.xuanxianglayer:getChildByName(iter_14_1)
			local var_14_2 = var_14_1:getChildByName(iter_14_3)
			local var_14_3, var_14_4 = var_14_2:getChildByName("content").getPosition(var_14_1)
			local var_14_5 = self:getNewPropertyNode(iter_14_0, iter_14_2)

			var_14_5:setPosition(cc.p(var_14_3, var_14_4))
			var_14_5:setAnchorPoint(cc.p(0, 1))
			var_14_5:setName("newcontent")
			var_14_5:setCascadeOpacityEnabled(true)
			var_14_5:setOpacity(0)
			var_14_2:addChild(var_14_5)
		end
	end

	self:updateAddXuanXiangInfoPanel()
end

function TalkEditorDetailLayer:initConsoleLayer()
	local var_15_0 = talkeditor_manager:getConsoleDataList()

	if var_15_0 == nil then
		return
	end

	local var_15_1 = #var_15_0
	local var_15_2 = 1960
	local var_15_3 = 100

	local function var_15_4(arg_16_0)
		return var_15_2, var_15_3 + 140 * math.ceil(#var_15_0[arg_16_0 + 1].list / 4)
	end

	if self.consoleViewNode ~= nil then
		self.consoleViewNode:removeFromParent()

		self.consoleViewNode = nil
	end

	self.consoleViewNode = Utility:getTableView(var_15_1, var_15_4, cc.size(1960, 1050), function(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_1 + 1
		local var_17_1 = arg_17_0:dequeueCell()

		if var_17_1 == nil then
			var_17_1 = cc.TableViewCell:new()
		end

		local var_17_2 = var_17_1:getChildByName("item")

		if var_17_2 then
			var_17_2:removeFromParent()
		end

		local var_17_4 = self:getConsoleItemNode(3)

		var_17_4:setVisible(true)

		local var_17_5, var_17_6 = var_15_4(arg_17_1)

		var_17_4:setContentSize(cc.size(var_17_5, var_17_6))
		var_17_4:setName("item")

		local var_17_7 = var_17_4:getChildByName("title")

		var_17_7:setString(var_15_0[arg_17_1 + 1].title)
		var_17_7:setPosition(cc.p(0, var_17_6 - var_15_3))
		var_17_7:setTouchEnabled(true)
		var_17_7:addTouchEventListener(function(arg_18_0, arg_18_1)
			if arg_18_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_18_0 = cc.p(0, 0)

			var_18_0.x, var_18_0.y = arg_18_0:getPosition()
			var_18_0.x = var_18_0.x + 700
			var_18_0.y = var_18_0.y - 80

			self:showPropertyDetailPanel(var_0_8[var_17_0], (arg_18_0:getParent():convertToWorldSpace(var_18_0)))
		end)
		var_17_1:addChild(var_17_4)

		if var_17_4:getChildByName("listLayer") then
			var_17_4:getChildByName("listLayer"):removeFromParent()
		end

		local var_17_8 = ccui.Layout:create()

		var_17_8:setName("listLayer")
		var_17_8:setContentSize(cc.size(var_17_5, var_17_6))
		var_17_4:addChild(var_17_8)

		for iter_17_0 = 1, #var_15_0[arg_17_1 + 1].list do
			local var_17_9 = var_15_0[arg_17_1 + 1].list[iter_17_0]
			local var_17_10 = self:getConsoleItemNode(var_15_0[arg_17_1 + 1].itemtype)

			var_17_10:setVisible(true)
			var_17_10:getChildByName("title"):setString(var_17_9.title)
			var_17_8:addChild(var_17_10)
			var_17_10:setPosition(cc.p(250 + (iter_17_0 - 1) % 4 * 450, var_17_6 - var_15_3 - (math.floor((iter_17_0 - 1) / 4) + 1) * 130))

			var_17_10.nInfo = var_17_9

			if var_15_0[arg_17_1 + 1].itemtype == TALKEDITOR.CONSOLE_ITEM_TYPE.XUANXIANG_BOX then
				local var_17_11 = ccui.TextField:create("input..", FONT_DES, 36)

				var_17_11:setName("input")
				var_17_11:setPosition(cc.p(0, 35))
				var_17_11:setAnchorPoint(cc.p(0, 0))
				var_17_11:setTouchSize(cc.size(288, 36))
				var_17_11:setContentSize(cc.size(288, 36))
				var_17_11:setColor(cc.c3b(0, 0, 0))
				var_17_10:addChild(var_17_11)
				var_17_11:setText(var_17_9.value)

				local var_17_12, var_17_13 = var_17_11:getPosition()
				local var_17_14 = Utility:getEditBox("TalkEditorLayer/input_bg.png", cc.size(170, 100), function(arg_19_0, arg_19_1)
					self:InputConsoleEditBoxTextEventHandle(arg_19_0, arg_19_1)
				end)

				var_17_14:setFontSize(16)
				var_17_14:setPlaceholderFont(FONT_TITLE, 32)
				var_17_14:setPlaceHolder("")
				var_17_14:setMaxLength(8)
				var_17_14:setPosition(cc.p(var_17_12, var_17_13 + 15))
				var_17_14:setAnchorPoint(cc.p(0, 0.5))
				var_17_14:setName("newinput")
				var_17_14:setCascadeOpacityEnabled(true)
				var_17_14:setOpacity(0)
				var_17_14:setText(var_17_9.value)
				var_17_10:addChild(var_17_14)
			elseif var_15_0[arg_17_1 + 1].itemtype == TALKEDITOR.CONSOLE_ITEM_TYPE.CHECK_BOX then
				Utility:setToggleCallback(var_17_10, function(arg_20_0)
					var_17_10.tglStatus = arg_20_0
				end, var_17_9.value == 1 and true or false)
			end
		end

		return var_17_1
	end, function()
		return
	end)

	local var_15_5 = self.consolelayer:getContentSize().width

	self.consoleViewNode:setPosition(cc.p(64, 17))
	self.consoleViewNode:setVisible(true)
	self.consoleViewNode:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.consolelayer:addChild(self.consoleViewNode)
end

function TalkEditorDetailLayer:updateConsoleListInfo()
	if self.consoleViewNode == nil then
		return
	end

	local var_22_0 = talkeditor_manager:getConsoleDataList()

	if var_22_0 == nil then
		return
	end

	for iter_22_0 = 1, #var_22_0 do
		local var_22_1 = self.consoleViewNode:cellAtIndex(iter_22_0 - 1):getChildByName("item"):getChildByName("listLayer")

		for iter_22_1 = 1, #var_22_0[iter_22_0].list do
			local var_22_3 = var_22_1:getChildren()

			if var_22_0[iter_22_0].itemtype == TALKEDITOR.CONSOLE_ITEM_TYPE.XUANXIANG_BOX then
				talkeditor_manager:setConsoleListInfo(iter_22_0, iter_22_1, var_22_3[iter_22_1]:getChildByName("input"):getStringValue())
			elseif var_22_0[iter_22_0].itemtype == TALKEDITOR.CONSOLE_ITEM_TYPE.CHECK_BOX then
				talkeditor_manager:setConsoleListInfo(iter_22_0, iter_22_1, var_22_3[iter_22_1].tglStatus == true and 1 or 0)
			end
		end
	end
end

function TalkEditorDetailLayer:updateXuanXiangListInfo()
	if self.curItemInfo == nil or next(self.curItemInfo) == nil then
		return
	end

	if self.xuanxiang_switch.index == 1 then
		local var_23_0 = self.xuanxianglayer:getChildByName("xuanxiang_1")
		local var_23_1 = self.xuanxianglayer:getChildByName("xuanxiang_2")

		self:setCurItemInfo("Lines1", var_23_0:getChildByName("title1"):getChildByName("content"):getStringValue())
		self:setCurItemInfo("Lines2", var_23_1:getChildByName("title1"):getChildByName("content"):getStringValue())
		self:setCurItemInfo("nextClassId1", tonumber(var_23_0:getChildByName("title2"):getChildByName("content"):getStringValue()))
		self:setCurItemInfo("nextClassId2", tonumber(var_23_1:getChildByName("title2"):getChildByName("content"):getStringValue()))

		self.curItemInfo.dialogType = 1
	else
		self:setCurItemInfo("Lines1", nil)
		self:setCurItemInfo("Lines2", nil)
		self:setCurItemInfo("nextClassId1", nil)
		self:setCurItemInfo("nextClassId2", nil)

		self.curItemInfo.dialogType = 2
	end
end

function TalkEditorDetailLayer:updatePropertyDetailPanel()
	if self.editorStatus ~= var_0_6.NORMAL and self:getChildByName("propertyDetailPanel") then
		self:getChildByName("propertyDetailPanel"):removeFromParent()
	end
end

function TalkEditorDetailLayer:getConsoleItemNode(arg_25_1)
	if arg_25_1 == TALKEDITOR.CONSOLE_ITEM_TYPE.CHECK_BOX then
		return self.consolelayer:getChildByName("checkBox"):clone()
	elseif arg_25_1 == TALKEDITOR.CONSOLE_ITEM_TYPE.XUANXIANG_BOX then
		local var_25_0 = self.consolelayer:getChildByName("xuanxiangBox")

		if var_25_0:getChildByName("input") then
			var_25_0:getChildByName("input"):removeFromParent()
		end

		return self.consolelayer:getChildByName("xuanxiangBox"):clone()
	else
		return self.consolelayer:getChildByName("item"):clone()
	end
end

function TalkEditorDetailLayer:updateAddXuanXiangInfoPanel()
	if self.curItemInfo == nil or self.xuanxiang_switch == nil then
		return
	end

	self.xuanxiang_switch.index = self.curItemInfo.dialogType == 1 and 1 or 2

	Utility:setTglContainerCallback(self.xuanxiang_switch, function(arg_27_0)
		self.xuanxiang_switch.index = arg_27_0
	end, self.xuanxiang_switch.index)

	local var_26_0 = self.xuanxianglayer:getChildByName("xuanxiang_1")
	local var_26_1 = self.xuanxianglayer:getChildByName("xuanxiang_2")

	var_26_0:getChildByName("title1"):getChildByName("content"):setText(self.curItemInfo.Lines1)
	var_26_1:getChildByName("title1"):getChildByName("content"):setText(self.curItemInfo.Lines2)
	var_26_0:getChildByName("title2"):getChildByName("content"):setText(self.curItemInfo.nextClassId1)
	var_26_1:getChildByName("title2"):getChildByName("content"):setText(self.curItemInfo.nextClassId2)
end

function TalkEditorDetailLayer:setCurItemInfo(arg_28_1, arg_28_2)
	self.curItemInfo[arg_28_1] = arg_28_2
end

function TalkEditorDetailLayer.getNewPropertyNode(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = Utility:getEditBox("TalkEditorLayer/input_bg.png", var_0_7[arg_29_2], function(arg_30_0)
		arg_29_0:InputEditBoxTextEventHandle(arg_30_0, arg_29_1, arg_29_2)
	end)

	var_29_0:setFontSize(16)
	var_29_0:setPlaceholderFont(FONT_TITLE, 32)
	var_29_0:setPlaceHolder("")
	var_29_0:setMaxLength(8)

	return var_29_0
end

function TalkEditorDetailLayer:InputEditBoxTextEventHandle(arg_31_1, arg_31_2, arg_31_3)
	if arg_31_1 == "ended" then
		local var_31_0 = self.xuanxianglayer:getChildByName("xuanxiang_" .. arg_31_2)
		local var_31_1 = var_31_0:getChildByName("title" .. arg_31_3)

		var_31_1:getChildByName("content"):setText((var_31_1:getChildByName("newcontent").getText(var_31_0)))
	end
end

function TalkEditorDetailLayer.InputConsoleEditBoxTextEventHandle(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_1 == "ended" then
		local var_32_0 = arg_32_2:getParent()

		var_32_0:getChildByName("input"):setText((var_32_0:getChildByName("newinput"):getText()))
	end
end

function TalkEditorDetailLayer:lateUpdate(arg_33_1)
	if self.cinemaScheduler ~= nil then
		self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

		self.cinemaScheduler = nil
	end

	self.cinemaScheduler = self.scheduler:scheduleScriptFunc(function()
		if self.cinemaScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

			self.cinemaScheduler = nil
		end

		if type(arg_33_1) == "function" then
			arg_33_1()
		end
	end, 0, false)
end

function TalkEditorDetailLayer:showPropertyDetailPanel(arg_35_1, arg_35_2)
	local var_35_0 = self:convertToNodeSpace(arg_35_2)

	self.isShowingPropertyIndex = arg_35_1.index

	if self:getChildByName("propertyDetailPanel") then
		self:getChildByName("propertyDetailPanel"):removeFromParent()
	end

	local var_35_1 = ccui.ImageView:create("EquipLayer/popup_buff_details.png", var_0_4)

	var_35_1:setPosition(cc.p(var_35_0.x, var_35_0.y + 30))
	var_35_1:setScale9Enabled(true)
	var_35_1:setAnchorPoint(cc.p(1, 0))
	var_35_1:setCapInsets(cc.rect(20, 20, 20, 20))
	var_35_1:setName("propertyDetailPanel")
	self:addChild(var_35_1)
	self:usualSchedulerWithCallback(function()
		if self:getChildByName("propertyDetailPanel") then
			self:getChildByName("propertyDetailPanel"):runAction(cc.RemoveSelf:create())
		end
	end, 4)

	local var_35_2 = 400
	local var_35_3 = var_35_1:getContentSize().height
	local var_35_4 = cc.Label:createWithTTF("", FONT_W5, 30)

	var_35_4:setMaxLineWidth(400)
	var_35_4:setVisible(false)
	var_35_1:addChild(var_35_4)
	var_35_4:setString(arg_35_1.des)

	local var_35_5 = 0 + 26 + var_35_4:getContentSize().height + 6

	if var_35_3 < var_35_5 then
		var_35_1:setContentSize(cc.size(var_35_1:getContentSize().width, var_35_5))
	else
		var_35_5 = var_35_3
	end

	local var_35_7 = cc.Label:createWithTTF(arg_35_1.name, FONT_W5, 24)

	var_35_7:setAnchorPoint(cc.p(0, 1))
	var_35_7:setColor(cc.c3b(64, 240, 95))
	var_35_7:setPosition(cc.p(20, var_35_5))
	var_35_1:addChild(var_35_7)

	local var_35_8 = cc.Label:createWithTTF(arg_35_1.des, FONT_W5, 24)

	var_35_8:setColor(cc.c3b(220, 235, 241))
	var_35_8:setAnchorPoint(cc.p(0, 1))
	var_35_8:setMaxLineWidth(var_35_2)
	var_35_8:setPosition(cc.p(4, var_35_5 - 26))
	var_35_8:setVisible(false)
	var_35_1:addChild(var_35_8)

	local var_35_9 = RichTextPro:create()

	var_35_9:setMaxWidth(var_35_2)
	var_35_9:setSize(24)

	var_35_9.fontName = FONT_W5

	var_35_9:setColor(cc.c3b(220, 251, 241))
	var_35_9:setLineSpace(0)
	var_35_9:setText((transSkillDesToRichText(arg_35_1.des)))
	var_35_9:setPosition(cc.p(20, var_35_5 - 26))
	var_35_1:addChild(var_35_9)
end

function TalkEditorDetailLayer:usualSchedulerWithCallback(arg_37_1, arg_37_2)
	arg_37_2 = arg_37_2 or 1

	if self.usualScheduler ~= nil then
		self.scheduler:unscheduleScriptEntry(self.usualScheduler)
	end

	self.usualScheduler = self.scheduler:scheduleScriptFunc(function()
		if self.usualScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.usualScheduler)
		end

		if type(arg_37_1) == "function" then
			arg_37_1()
		end
	end, arg_37_2, false)
end
