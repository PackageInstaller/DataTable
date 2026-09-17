TalkEditorSettingLayer = class("TalkEditorSettingLayer", function()
	return cc.NodeGrid:create()
end)

local model_data = require("data.model_data")
local Utility = require("common.Utility")
local talkeditor_manager = require("controller.talkeditor_manager")
local utf8 = require("controller.utf8")

function TalkEditorSettingLayer.create(arg_2_0, arg_2_1)
	return (TalkEditorSettingLayer.new(arg_2_1))
end

function TalkEditorSettingLayer:ctor(arg_3_1)
	self.params = arg_3_1
	self.scheduler = cc.Director:getInstance():getScheduler()

	self:onLoad()
	self:init()
end

function TalkEditorSettingLayer:onLoad()
	if self.root then
		return
	end

	TextureManager:loadLayerTextures({
		"TalkEditorLayer"
	})

	self.root = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "TalkEditorSettingLayer.json" or "TalkEditorSettingLayer.ExportJson")

	self:addChild(self.root)
	self.root:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:closePropertySettingPanel()
	end)

	self.btn_close = self.root:getChildByName("btn_close")

	self.btn_close:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:closePropertySettingPanel()
	end)

	self.btn_save = self.root:getChildByName("btn_save")

	self.btn_save:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:saveSettingInfo()
		self:closePropertySettingPanel()
	end)

	self.item1Node = self.root:getChildByName("item1")

	local var_4_0 = self.item1Node:getChildByName("input")

	var_4_0:setVisible(true)
	var_4_0:setText(talkeditor_manager:getCurFolderName())

	self.btn_default1 = self.item1Node:getChildByName("btn_default")

	self.btn_default1:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_9_0 = "conversation_default_data"

		var_4_0:setText("conversation_default_data")
		self.excelInputNode:setText(var_9_0)
	end)

	self.folderInputNode = Utility:getEditBox("TalkEditorLayer/input_bg.png", cc.size(var_4_0:getContentSize().width, var_4_0:getContentSize().height), function(arg_8_0)
		if arg_8_0 == "ended" then
			var_4_0:setText((self.folderInputNode:getText()))
		end
	end)

	local var_4_1, var_4_2 = var_4_0:getPosition()

	self.folderInputNode:setPosition(cc.p(var_4_1, var_4_2 + 10))
	self.folderInputNode:setAnchorPoint(cc.p(0, 0.5))
	self.folderInputNode:setFontSize(16)
	self.folderInputNode:setPlaceholderFont(FONT_TITLE, 32)
	self.folderInputNode:setOpacity(0)
	self.folderInputNode:setCascadeOpacityEnabled(true)
	self.folderInputNode:setPlaceHolder("请设置脚本文件名:")
	self.folderInputNode:setText(talkeditor_manager:getCurFolderName())
	self.item1Node:addChild(self.folderInputNode)

	self.item2Node = self.root:getChildByName("item2")

	local var_4_3 = self.item2Node:getChildByName("input")

	var_4_3:setVisible(true)
	var_4_3:setText(talkeditor_manager:getCurExcelName())

	self.btn_default2 = self.item2Node:getChildByName("btn_default")

	self.btn_default2:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_11_0 = "【剧情】导表_剧情表_默认"

		var_4_3:setText("【剧情】导表_剧情表_默认")
		self.excelInputNode:setText(var_11_0)
	end)

	self.excelInputNode = Utility:getEditBox("TalkEditorLayer/input_bg.png", cc.size(var_4_3:getContentSize().width, var_4_3:getContentSize().height), function(arg_10_0)
		if arg_10_0 == "ended" then
			var_4_3:setText((self.excelInputNode:getText()))
		end
	end)

	local var_4_4, var_4_5 = var_4_3:getPosition()

	self.excelInputNode:setPosition(cc.p(var_4_4, var_4_5 + 10))
	self.excelInputNode:setAnchorPoint(cc.p(0, 0.5))
	self.excelInputNode:setFontSize(16)
	self.excelInputNode:setPlaceholderFont(FONT_TITLE, 32)
	self.excelInputNode:setOpacity(0)
	self.excelInputNode:setCascadeOpacityEnabled(true)
	self.excelInputNode:setPlaceHolder("请设置表格文件名:")
	self.item2Node:addChild(self.excelInputNode)
	self.excelInputNode:setText(talkeditor_manager:getCurExcelName())

	self.contentNode = self.root:getChildByName("content")

	self.contentNode:setString("信息：文件表格和脚本请注意一一对应！")
end

function TalkEditorSettingLayer:init()
	self:initInfo()
	self:lateUpdate(function()
		self:initPanel()
	end)
end

function TalkEditorSettingLayer.initInfo(arg_14_0)
	return
end

function TalkEditorSettingLayer.initPanel(arg_15_0)
	return
end

function TalkEditorSettingLayer:saveSettingInfo()
	local var_16_0 = self.item1Node:getChildByName("input")

	talkeditor_manager:setSettingInfo({
		folderName = var_16_0:getStringValue(),
		excelName = self.item2Node:getChildByName("input").getStringValue(var_16_0)
	})
end

function TalkEditorSettingLayer:closePropertySettingPanel()
	self:setVisible(false)

	if self.params.closeCallback then
		self.params.closeCallback()
	end
end

function TalkEditorSettingLayer:lateUpdate(arg_18_1)
	if self.cinemaScheduler ~= nil then
		self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

		self.cinemaScheduler = nil
	end

	self.cinemaScheduler = self.scheduler:scheduleScriptFunc(function()
		if self.cinemaScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

			self.cinemaScheduler = nil
		end

		if type(arg_18_1) == "function" then
			arg_18_1()
		end
	end, 0, false)
end
