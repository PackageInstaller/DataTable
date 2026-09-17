TalkEditor = class("TalkEditor", function()
	return cc.NodeGrid:create()
end)

local var_0_0
local var_0_1
local var_0_2
local var_0_3 = 150
local var_0_4 = 844
local var_0_5 = 253 - 150
local var_0_6 = config._DEBUG and 0 or 1
local var_0_7 = {
	NORMAL = "TalkEditorLayer/item_bg_normal.png",
	SELECTED = "TalkEditorLayer/item_bg_select.png"
}
local var_0_8 = TALKEDITOR.OperateType
local var_0_9 = TALKEDITOR.CONSOLE_LIST
local var_0_10 = TALKEDITOR.OperateTypeNameList
local var_0_11 = TALKEDITOR.OperateIndexNameList
local var_0_12 = TALKEDITOR.PropertyTypeList
local var_0_13 = {
	{
		name = "",
		key = "btn_console",
		des = ""
	},
	{
		name = "",
		key = "btn_xuanxiang",
		des = ""
	},
	{
		name = "",
		key = "btn_save",
		des = ""
	},
	{
		name = "",
		key = "btn_reset",
		des = ""
	},
	{
		name = "",
		key = "btn_preview",
		des = ""
	},
	{
		name = "bgm",
		key = "xuanxiang_music",
		des = "背景音乐，格式：qixi \n资源根路径：/res/sound/jvqingpeiyin/"
	},
	{
		name = "soundEffect",
		key = "xuanxiang_sounds",
		des = "音效，格式：240_atk \n资源根路径：/res/sound/jvqingpeiyin/"
	},
	{
		name = "background",
		key = "xuanxiang_background",
		des = "背景图片，格式：fightbg30 \n资源根路径：/res/mainScenebg/"
	},
	{
		name = "playerExpression",
		key = "xuanxiang_expression",
		des = "立绘表情，格式：kaixin \n参考设置项：expression/fanu/kaixin/haixiu/aichou \n(注意并不是填写了就一定会有效果，请检查对应学员model表中对应字段)"
	},
	{
		name = "playerId",
		key = "xuanxiang_player",
		des = "立绘标识，格式：2100 \n标识出处：学员model表中的id"
	},
	{
		name = "playerBubble",
		key = "xuanxiang_bubble",
		des = "心情气泡，格式：2 \n参考设置项（数字代表对应气泡）：1感叹号 2爱心 3星星 4音符 5三点 6汗滴 7生气 8问号"
	},
	{
		name = "playerLinesDubbing",
		key = "xuanxiang_dubbing",
		des = "台词配音，格式：1005_zy06 \n资源根路径：res/sound/role_voice/"
	},
	{
		name = "playerName",
		key = "xuanxiang_name",
		des = "名字，格式：霓昂 \n参考设置项：任意文字"
	},
	{
		name = "dialogType",
		key = "xuanxiang_talktype",
		des = "对话类型，格式：1 \n参考设置项（数字代表对应对话类型）： 1我 2学员 3旁白 4舞台提示"
	},
	{
		name = "",
		key = "toggleContaniner1",
		des = ""
	},
	{
		name = "",
		key = "toggleContaniner2",
		des = ""
	}
}
local var_0_14 = TALKEDITOR.EDITOR_STATUS
local var_0_15 = {
	"xuanxiang_music",
	"xuanxiang_sounds",
	"xuanxiang_background",
	"xuanxiang_expression",
	"xuanxiang_player",
	"xuanxiang_bubble",
	"xuanxiang_dubbing",
	"xuanxiang_name",
	"xuanxiang_talktype",
	"lines_input"
}
local var_0_16 = {
	"bgm",
	"soundEffect",
	"background",
	"playerExpression",
	"playerId",
	"playerBubble",
	"playerLinesDubbing",
	"playerName",
	"dialogType",
	"playerLines"
}
local var_0_17 = {
	TALKEDITOR.PropertyTypeList.BGM,
	TALKEDITOR.PropertyTypeList.BGM,
	TALKEDITOR.PropertyTypeList.Background,
	TALKEDITOR.PropertyTypeList.Expression,
	TALKEDITOR.PropertyTypeList.Player,
	TALKEDITOR.PropertyTypeList.Bubble,
	[9] = TALKEDITOR.PropertyTypeList.TalkType
}
local var_0_18 = {
	cc.size(350, 67),
	cc.size(210, 67),
	cc.size(350, 67),
	cc.size(350, 67),
	cc.size(200, 110),
	cc.size(210, 67),
	cc.size(350, 67),
	cc.size(210, 67),
	cc.size(210, 67)
}
local var_0_19 = {
	cc.p(215, 10),
	cc.p(165, 10),
	cc.p(215, 10),
	cc.p(215, 10),
	cc.p(215, 10),
	cc.p(165, 10),
	cc.p(215, 10),
	cc.p(165, 10),
	cc.p(165, 10)
}

function TalkEditor:InputEditBoxTextEventHandle(arg_2_1, arg_2_2)
	if arg_2_2 == "ended" then
		if self[arg_2_1]:getParent():getName() == "xuanxiang_player" then
			local var_2_0 = self[arg_2_1]:getParent()
			local var_2_1 = var_2_0:getChildByName("new_input"):getText()

			if not var_2_0 then
				var_2_1 = "2100"
			end

			local model_data = require("data.model_data")
			local var_2_3

			if model_data[var_2_1] then
				var_2_3 = model_data[var_2_1].name_Q or "霓昂"
			end

			self[arg_2_1]:setText(var_2_1)
			self.xuanxiang_name:setText(var_2_3)
		else
			self[arg_2_1]:setText(self[arg_2_1]:getParent():getChildByName("new_input"):getText())
		end

		self:saveToCacheAndRefresh()
	end
end

function TalkEditor:saveToCacheAndRefresh()
	if self.editorStatus ~= var_0_14.NORMAL then
		return
	end

	self:saveCurContentInfoToCache()
	self:updatePanel((var_0_0:getLastSelectIndex()))
end

function TalkEditor.create(arg_4_0)
	return (TalkEditor.new())
end

function TalkEditor:ctor()
	TextureManager:loadLayerTextures({
		"TalkEditorLayer"
	})
	TextureManager:loadLayerTextures({
		"EquipLayer"
	})

	self.scheduler = cc.Director:getInstance():getScheduler()
	self.layer = ccui.Layout:create()

	self.layer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
	self.layer:setBackGroundImage("mainScenebg/talk_editor_bg.png")
	self:addChild(self.layer)
	self:usualSchedulerWithCallback(function()
		self:onLoad()
		self:usualSchedulerWithCallback(function()
			self:init()
		end, 1)
	end, 0.5)
end

function TalkEditor:init()
	require("view.Layer.TalkLayer")
	require("view.Layer.TalkLayerDebug")
	TalkLayer:initTalkEditorMode()

	self.classId = nil
	self.curSelectNode = nil
	self.isShowingPropertyIndex = nil
	self.editorStatus = var_0_14.FREE
	self.ScreenWidth = 640
	self.ScreenHeight = 1388
	var_0_1 = require("data.conversation_talkeditor_data")
	var_0_0 = require("controller.talkeditor_manager")

	var_0_0:init()
	self:registerEventCallback()
	self:initUI()
end

function TalkEditor:onLoad()
	var_0_2 = require("common.Utility")

	require("view.Sprite.ConfirmDialogSprite")

	self.ConfigWidth = GameDisplay.width
	self.ConfigHeight = GameDisplay.height + GameDisplay.fix_y
	self.root = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "TalkEditor.json" or "TalkEditor.ExportJson")

	self.layer:addChild(self.root)

	self.listLayerNode = self.root:getChildByName("listlayer")
	self.contentLayerNode = self.root:getChildByName("contentlayer")
	self.propertyLayerNode = self.root:getChildByName("propertylayer")
	self.scrollbarNode = self.listLayerNode:getChildByName("scrollbar")

	self.scrollbarNode:setLocalZOrder(99)

	self.barNode = self.scrollbarNode:getChildByName("bar")

	self.barNode:setTouchEnabled(true)
	self.scrollbarNode:setTouchEnabled(true)

	self.barRangeMax = self.scrollbarNode:getContentSize().height
	self.barRangeMin = self.barNode:getContentSize().height

	self.barNode:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.moved then
			return
		end

		local var_10_0 = arg_10_0:getParent()
		local var_10_1 = math.min(math.max(var_10_0:convertToNodeSpace((arg_10_0:getTouchMovePosition())).y + arg_10_0:getContentSize().height / 2, arg_10_0:getContentSize().height), var_10_0:getContentSize().height)

		arg_10_0:setPositionY(var_10_1)

		if self.listViewNode then
			local var_10_2 = arg_10_0:getContentSize().height

			self.listViewNode:scrollToPercent(100 - (var_10_1 - var_10_2) / (var_10_0:getContentSize().height - var_10_2) * 100, nil, false)
		end
	end)
	self.scrollbarNode:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.began then
			return
		end

		local var_11_0 = arg_11_0:getParent()
		local var_11_1 = arg_11_0:getChildByName("bar")
		local var_11_2 = math.min(math.max(var_11_0:convertToNodeSpace((arg_11_0:getTouchBeganPosition())).y - var_11_1:getContentSize().height / 2, var_11_1:getContentSize().height), arg_11_0:getContentSize().height)

		var_11_1:setPositionY(var_11_2)

		if self.listViewNode then
			local var_11_3 = var_11_1:getContentSize().height

			self.listViewNode:scrollToPercent(100 - (var_11_2 - var_11_3) / (arg_11_0:getContentSize().height - var_11_3) * 100, nil, false)
		end
	end)

	self.classIdNode = self.listLayerNode:getChildByName("title_bg"):getChildByName("classid")

	self.classIdNode:setString("")

	self.btn_last = self.listLayerNode:getChildByName("btn_last")
	self.btn_next = self.listLayerNode:getChildByName("btn_next")
	self.btn_quick_new = self.listLayerNode:getChildByName("btn_quick_new")
	self.btn_new = self.contentLayerNode:getChildByName("btn_new")
	self.btn_read = self.contentLayerNode:getChildByName("btn_read")
	self.talkNode = self.contentLayerNode:getChildByName("talk")

	self.talkNode:setVisible(false)

	local var_9_0 = cc.size(280, 67)

	self.newPanelEditBox1 = var_0_2:getEditBox("TalkEditorLayer/input_bg.png", var_9_0, function(arg_12_0)
		if arg_12_0 == "ended" then
			self.curText1 = tonumber(self.newPanelEditBox1:getText())
		end
	end)

	self.newPanelEditBox1:setPosition(cc.p(60, 374))
	self.newPanelEditBox1:setAnchorPoint(cc.p(0, 0.5))
	self.newPanelEditBox1:setFontSize(16)
	self.newPanelEditBox1:setPlaceholderFont(FONT_TITLE, 32)
	self.newPanelEditBox1:setPlaceHolder("input num")
	self.newPanelEditBox1:setMaxLength(8)

	self.newPanelEditBox2 = var_0_2:getEditBox("TalkEditorLayer/input_bg.png", var_9_0, function(arg_13_0)
		if arg_13_0 == "ended" then
			self.curText2 = tonumber(self.newPanelEditBox2:getText())
		end
	end)

	self.newPanelEditBox2:setPosition(cc.p(60, 219))
	self.newPanelEditBox2:setAnchorPoint(cc.p(0, 0.5))
	self.newPanelEditBox2:setFontSize(16)
	self.newPanelEditBox2:setPlaceholderFont(FONT_TITLE, 32)
	self.newPanelEditBox2:setPlaceHolder("input num")
	self.newPanelEditBox2:setMaxLength(8)
	self.contentLayerNode:addChild(self.newPanelEditBox1)
	self.contentLayerNode:addChild(self.newPanelEditBox2)

	self.btn_console = self.propertyLayerNode:getChildByName("btn_console")
	self.btn_xuanxiang = self.propertyLayerNode:getChildByName("btn_xuanxiang")
	self.btn_save = self.propertyLayerNode:getChildByName("btn_save")
	self.btn_revoke = self.propertyLayerNode:getChildByName("btn_revoke")
	self.btn_reset = self.propertyLayerNode:getChildByName("btn_reset")
	self.btn_preview = self.propertyLayerNode:getChildByName("btn_preview")
	self.xuanxiang_music = self.propertyLayerNode:getChildByName("xuanxiang_music"):getChildByName("input")
	self.xuanxiang_sounds = self.propertyLayerNode:getChildByName("xuanxiang_sounds"):getChildByName("input")
	self.xuanxiang_background = self.propertyLayerNode:getChildByName("xuanxiang_background"):getChildByName("input")
	self.xuanxiang_expression = self.propertyLayerNode:getChildByName("xuanxiang_expression"):getChildByName("input")
	self.xuanxiang_player = self.propertyLayerNode:getChildByName("xuanxiang_player"):getChildByName("input")
	self.xuanxiang_bubble = self.propertyLayerNode:getChildByName("xuanxiang_bubble"):getChildByName("input")
	self.xuanxiang_dubbing = self.propertyLayerNode:getChildByName("xuanxiang_dubbing"):getChildByName("input")
	self.xuanxiang_name = self.propertyLayerNode:getChildByName("xuanxiang_name"):getChildByName("input")
	self.xuanxiang_talktype = self.propertyLayerNode:getChildByName("xuanxiang_talktype"):getChildByName("input")
	self.lines_input = self.propertyLayerNode:getChildByName("lines_input")

	self.lines_input:setVisible(false)

	local var_9_1 = self.propertyLayerNode:getChildByName("title_bg"):getChildByName("lines_title")

	var_9_1:setString("台词直接在对话面板上编辑")
	var_9_1:setAnchorPoint(cc.p(0, 1))
	var_9_1:setPosition(cc.p(20, 70))

	self.newlines_input = var_0_2:getEditBox("TalkEditorLayer/input_bg.png", cc.size(640, 270), function(arg_14_0)
		if arg_14_0 == "ended" then
			self.lines_input:setText(self.newlines_input:getText())
			self:saveToCacheAndRefresh()
		end
	end)

	self.newlines_input:setPosition(cc.p(0, 140))
	self.newlines_input:setAnchorPoint(cc.p(0, 1))
	self.newlines_input:setFont(FONT_NAME, 16)
	self.newlines_input:setPlaceholderFont(FONT_TITLE, 24)
	self.newlines_input:setPlaceHolder("input num")
	self.newlines_input:setMaxLength(8)
	self.newlines_input:setCascadeOpacityEnabled(true)
	self.newlines_input:setOpacity(0)
	self.newlines_input:setVisible(false)
	self.contentLayerNode:addChild(self.newlines_input)

	for iter_9_0, iter_9_1 in pairs(var_0_15) do
		if iter_9_1 ~= "lines_input" then
			local var_9_2, var_9_3 = self[iter_9_1]:getPosition()
			local var_9_4 = self:getNewPropertyNode(iter_9_0, iter_9_1)

			var_9_4:setPosition(cc.p(var_9_2 - 10, var_9_3 + 20))
			var_9_4:setAnchorPoint(cc.p(0, 0))
			var_9_4:setName("new_input")
			var_9_4:setPosition(var_0_19[iter_9_0])
			var_9_4:setCascadeOpacityEnabled(true)
			var_9_4:setOpacity(0)

			var_9_4.index = iter_9_0
			self["new" .. iter_9_1] = var_9_4

			self.propertyLayerNode:getChildByName(iter_9_1):addChild(var_9_4)
		end
	end

	self.toggleContaniner1 = self.propertyLayerNode:getChildByName("toggleContaniner1")
	self.toggleContaniner2 = self.propertyLayerNode:getChildByName("toggleContaniner2")
	self.toggleContaniner3 = self.propertyLayerNode:getChildByName("xuanxiang_player"):getChildByName("toggleContaniner")
	self.toggleNode = self.propertyLayerNode:getChildByName("xuanxiang_bubble"):getChildByName("toggle")

	self.toggleNode:setVisible(false)

	self.toggleNode = self.propertyLayerNode:getChildByName("xuanxiang_player"):getChildByName("toggle")

	local var_9_5 = ccui.Button:create("public/button/public_button_blue.png", nil, "public/button/public_button_blue.png", var_0_6)

	var_9_5:setName("btn_saveToExcel")
	var_9_5:setPosition(cc.p(300, 1100))
	self.propertyLayerNode:addChild(var_9_5)

	local var_9_6 = ccui.Text:create("导出到EXCEL", FONT_TITLE, 26)

	var_9_6:setName("name")
	var_9_6:setPosition(cc.p(110, 50))
	var_9_5:addChild(var_9_6)
	var_9_5:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("导出到excel")

		if self.editorStatus ~= var_0_14.NORMAL then
			return
		end

		var_0_0:saveToExcelFile()
		global_ShowBlockWords("导出成功，请注意查看" .. var_0_0:getCurExcelName(), nil, cc.p(self.ConfigWidth / 2 - 60, self.ConfigHeight / 2), 4)
	end)
	var_9_5:setVisible(self.editorStatus == var_0_14.NORMAL)

	local var_9_7 = ccui.Button:create("public/button/public_button_blue.png", nil, "public/button/public_button_blue.png", var_0_6)

	var_9_7:setName("btn_setting")
	var_9_7:setPosition(cc.p(300, 1100))
	self.propertyLayerNode:addChild(var_9_7)

	local var_9_8 = ccui.Text:create("设置", FONT_TITLE, 26)

	var_9_8:setName("name")
	var_9_8:setPosition(cc.p(110, 50))
	var_9_7:addChild(var_9_8)
	var_9_7:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.editorStatus ~= var_0_14.FREE then
			return
		end

		print("打开设置")

		self.editorStatus = var_0_14.SETTING

		self:openTalkSettingPanel({
			closeCallback = function()
				self.editorStatus = var_0_14.FREE
			end,
			editorStatus = self.editorStatus,
			curItemInfo = self.curItemInfo
		})
	end)
	var_9_5:setVisible(self.editorStatus == var_0_14.FREE)
end

function TalkEditor:onBtnPropertySelectCallback(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = ""
	local var_18_1 = ""

	if arg_18_2 ~= nil then
		local var_18_2 = var_0_0:getSelectPropertyInfoByFilter(arg_18_1.propertytype)[arg_18_2]

		var_18_0 = var_18_2.name
		var_18_1 = var_18_2.value
	end

	local var_18_3 = arg_18_1.nodeKey

	self[arg_18_1.nodeKey]:setText(var_18_0)

	self["new" .. var_18_3].propertyText = var_18_1

	if arg_18_1.propertytype == var_0_12.Player then
		local var_18_4 = var_18_1 or "2100"
		local model_data = require("data.model_data")
		local var_18_6

		if model_data[var_18_1 or "2100"] then
			var_18_6 = model_data[var_18_4].name_Q or "霓昂"
		end

		self.xuanxiang_name:setText(var_18_6)

		self.newxuanxiang_name.propertyText = var_18_6
	elseif arg_18_1.propertytype == var_0_12.Bubble then
		self["new" .. var_18_3].propertyText = var_18_1 .. "=" .. (arg_18_3.actionType or 1)
	end

	self:saveToCacheAndRefresh()
end

function TalkEditor:openPropertySelectPanel(arg_19_1)
	self.editorStatus = var_0_14.SELECT

	local var_19_0 = {
		target = arg_19_1,
		closeCallback = function()
			self.editorStatus = var_0_14.NORMAL
			arg_19_1.isOpen = false
		end,
		selectCallback = function(arg_21_0, arg_21_1)
			self:onBtnPropertySelectCallback(arg_19_1, arg_21_0, arg_21_1)
		end,
		curItemInfo = self.curItemInfo
	}

	if self.propertySelectPanel then
		self.propertySelectPanel:setVisible(true)
		self.propertySelectPanel:ctor(var_19_0)
	else
		require("view.Layer.TalkEditor.TalkEditorSelectLayer")

		self.propertySelectPanel = TalkEditorSelectLayer:create(var_19_0)

		self.propertySelectPanel:setName("propertySelect")
		self.root:addChild(self.propertySelectPanel, 1)
	end
end

function TalkEditor.getNewPropertyNode(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0

	if var_0_17[arg_22_1] ~= nil then
		var_22_0 = ccui.Layout:create()

		var_22_0:setContentSize(var_0_18[arg_22_1])
		var_22_0:setTouchEnabled(true)

		var_22_0.isOpen = false
		var_22_0.propertytype = var_0_17[arg_22_1]
		var_22_0.nodeKey = arg_22_2

		var_22_0:addTouchEventListener(function(arg_23_0, arg_23_1)
			if arg_23_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_22_0.editorStatus ~= var_0_14.NORMAL then
				return
			end

			if arg_23_0.isOpen == true then
				return
			end

			arg_23_0.isOpen = true

			arg_22_0:openPropertySelectPanel(arg_23_0)
		end)
	else
		var_22_0 = var_0_2:getEditBox("TalkEditorLayer/input_bg.png", var_0_18[arg_22_1], function(arg_24_0)
			arg_22_0:InputEditBoxTextEventHandle(arg_22_2, arg_24_0)
		end)
		var_22_0.nodeKey = arg_22_2

		var_22_0:setFontSize(16)
		var_22_0:setPlaceholderFont(FONT_TITLE, 32)
		var_22_0:setPlaceHolder("")
		var_22_0:setMaxLength(8)
	end

	return var_22_0
end

function TalkEditor:initUI(arg_25_1)
	self:initTableViewPanel(arg_25_1)
end

function TalkEditor:setCurItemInfo(arg_26_1, arg_26_2)
	self.curItemInfo[arg_26_1] = arg_26_2
end

function TalkEditor:onTglContainer1Callback(arg_27_1)
	if self.curItemInfo == nil or next(self.curItemInfo) == nil then
		return
	end

	self:setCurItemInfo("operateObjectIndex", arg_27_1)
end

function TalkEditor:onTglContainer2Callback(arg_28_1)
	if self.curItemInfo == nil or next(self.curItemInfo) == nil then
		return
	end

	self:setCurItemInfo("operateObjectType", arg_28_1)
end

function TalkEditor:onTglContainer3Callback(arg_29_1)
	if self.curItemInfo == nil or next(self.curItemInfo) == nil then
		return
	end

	self:setCurItemInfo("playerPosType", (self:isShowPlayerNow() == true and 2 or 0) + (arg_29_1 - 1))
end

function TalkEditor:onToggleCallback(arg_30_1)
	if self.curItemInfo == nil or next(self.curItemInfo) == nil or self.talkNode:getChildByName("talkLayer") == nil then
		return
	end

	if arg_30_1 == false and self:isShowPlayerNow() == true then
		self.curItemInfo.playerPosType = self.curItemInfo.playerPosType - 2
	elseif arg_30_1 == true and self:isShowPlayerNow() == false then
		self.curItemInfo.playerPosType = self.curItemInfo.playerPosType + 2
	end
end

function TalkEditor:registerEventCallback()
	self:registerButtonEventCallback()
	self:registerKeyBoardEventCallback()
	self:registerMouseEventCallback()
end

function TalkEditor:releaseKeyCallback()
	if self.curSchedule ~= nil then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.curSchedule)

		self.curSchedule = nil
	end
end

function TalkEditor:updateCurInfo(arg_33_1, arg_33_2, arg_33_3)
	if self.curItemInfo == nil or next(self.curItemInfo) == nil then
		return
	end

	if self.curItemInfo.operateInfo == nil then
		self.curItemInfo.operateInfo = {}
	end

	local var_33_0 = self.curItemInfo.operateInfo

	if self.curItemInfo.operateInfo[arg_33_1] == nil then
		var_33_0[arg_33_1] = {}
	end

	if var_33_0[arg_33_1][arg_33_2] == nil then
		if arg_33_2 == var_0_8.Position then
			local var_33_1 = cc.p(0, 0)

			if self.talkNode:getChildByName("talkLayer") ~= nil then
				var_33_1.x, var_33_1.y = self.talkNode:getChildByName("talkLayer").talkInfo.curNodeInfo.mainPlayerNode:getChildByName("spineAni"):getPosition()

				if arg_33_1 == 1 then
					var_33_1.x = var_33_1.x - self.ScreenWidth / 2
					var_33_1.y = var_33_1.y - (self.ScreenHeight - 1136) / 2 - 550
				end
			end

			var_33_0[arg_33_1][arg_33_2] = var_33_1
		elseif arg_33_2 == var_0_8.Rotation then
			var_33_0[arg_33_1][arg_33_2] = 0
		elseif arg_33_2 == var_0_8.Scale then
			var_33_0[arg_33_1][arg_33_2] = 1
		elseif arg_33_2 == var_0_8.Opacity then
			var_33_0[arg_33_1][arg_33_2] = 255
		end
	end

	local var_33_2 = ""

	if arg_33_2 == var_0_8.Position then
		var_33_0[arg_33_1][arg_33_2] = cc.p(var_33_0[arg_33_1][arg_33_2].x + arg_33_3.x, var_33_0[arg_33_1][arg_33_2].y + arg_33_3.y)
		var_33_2 = string.format("%.2f=%.2f", var_33_0[arg_33_1][arg_33_2].x + arg_33_3.x, var_33_0[arg_33_1][arg_33_2].y + arg_33_3.y)
	elseif arg_33_2 == var_0_8.Rotation then
		var_33_0[arg_33_1][arg_33_2] = (var_33_0[arg_33_1][arg_33_2] + arg_33_3) % 360
		var_33_2 = string.format("%.2f", (var_33_0[arg_33_1][arg_33_2] + arg_33_3) % 360)
	elseif arg_33_2 == var_0_8.Scale then
		local var_33_3 = math.max(var_33_0[arg_33_1][arg_33_2] + arg_33_3, 0)

		var_33_0[arg_33_1][arg_33_2] = var_33_3
		var_33_2 = string.format("%.2f", var_33_3)
	elseif arg_33_2 == var_0_8.Opacity then
		local var_33_4 = math.min(math.max(var_33_0[arg_33_1][arg_33_2] + arg_33_3, 0), 255)

		var_33_0[arg_33_1][arg_33_2] = var_33_4
		var_33_2 = string.format("%.2f", var_33_4)
	end

	self.curItemInfo[var_0_11[arg_33_1] .. "_" .. var_0_10[arg_33_2]] = var_33_2

	self:updateTalkLayer(arg_33_1, arg_33_2, arg_33_3)
end

function TalkEditor:updateTalkLayer(arg_34_1, arg_34_2, arg_34_3)
	if self.curItemInfo.operateInfo == nil or self.talkNode:getChildByName("talkLayer") == nil then
		return
	end

	local var_34_0 = self.talkNode:getChildByName("talkLayer")
	local var_34_1

	if arg_34_1 == 1 then
		var_34_1 = var_34_0.talkInfo.curNodeInfo.mainPlayerNode
	elseif arg_34_1 == 2 then
		var_34_1 = var_34_0.bgNode
	elseif arg_34_1 == 3 then
		var_34_1 = var_34_0.talkInfo.curNodeInfo.mainPlayerNode:getChildByName("spineAni")
	end

	if arg_34_2 == var_0_8.Position then
		local var_34_2, var_34_3 = var_34_1:getPosition()

		var_34_1:setPosition((cc.p(var_34_2 + arg_34_3.x, var_34_3 + arg_34_3.y)))
	elseif arg_34_2 == var_0_8.Rotation then
		var_34_1:setRotation(var_34_1:getRotation() + arg_34_3)
	elseif arg_34_2 == var_0_8.Scale then
		if arg_34_1 == 3 then
			var_34_1:setScale(var_34_1._scaleX + arg_34_3, var_34_1._scaleY + arg_34_3)
		else
			var_34_1:setScale(var_34_1:getScale() + arg_34_3)
		end
	elseif arg_34_2 == var_0_8.Opacity then
		var_34_1:setOpacity((math.max(math.min((arg_34_1 == 3 and var_34_1._opacity or var_34_1:getOpacity()) + arg_34_3, 255), 0)))
		var_34_1:setCascadeOpacityEnabled(true)
	end
end

function TalkEditor.registerKeyBoardEventCallback(arg_35_0)
	local var_35_0 = cc.EventListenerKeyboard:create()

	var_35_0:registerScriptHandler(function(arg_36_0, arg_36_1)
		if arg_35_0.curSelectNode == nil then
			return
		end

		arg_35_0:releaseKeyCallback()

		local var_36_0 = arg_35_0.curItemInfo.operateObjectType
		local var_36_1 = arg_35_0.curItemInfo.operateObjectIndex

		if arg_35_0.curItemInfo.isOperateBubble == true then
			var_36_0 = var_0_8.Position
			var_36_1 = 3
		end

		if arg_36_0 == cc.KeyCode.KEY_LEFT_ARROW then
			arg_35_0.curSchedule = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_37_0)
				local var_37_0

				if var_36_0 == var_0_8.Position then
					var_37_0 = {
						y = 0,
						x = -arg_37_0 * 100
					}
				elseif var_36_0 == var_0_8.Rotation then
					var_37_0 = -arg_37_0 * 50
				elseif var_36_0 == var_0_8.Scale then
					var_37_0 = -arg_37_0
				elseif var_36_0 == var_0_8.Opacity then
					var_37_0 = -arg_37_0 * 50
				else
					return
				end

				arg_35_0:updateCurInfo(var_36_1, var_36_0, var_37_0)
			end, 0, false)
		elseif arg_36_0 == cc.KeyCode.KEY_RIGHT_ARROW then
			arg_35_0.curSchedule = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_38_0)
				local var_38_0

				if var_36_0 == var_0_8.Position then
					var_38_0 = {
						y = 0,
						x = arg_38_0 * 100
					}
				elseif var_36_0 == var_0_8.Rotation then
					var_38_0 = arg_38_0 * 50
				elseif var_36_0 == var_0_8.Scale then
					var_38_0 = arg_38_0
				elseif var_36_0 == var_0_8.Opacity then
					var_38_0 = arg_38_0 * 60
				else
					return
				end

				arg_35_0:updateCurInfo(var_36_1, var_36_0, var_38_0)
			end, 0, false)
		elseif arg_36_0 == cc.KeyCode.KEY_UP_ARROW then
			arg_35_0.curSchedule = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_39_0)
				local var_39_0

				if var_36_0 == var_0_8.Position then
					var_39_0 = {
						x = 0,
						y = arg_39_0 * 100
					}
				elseif var_36_0 == var_0_8.Rotation then
					var_39_0 = arg_39_0 * 50
				elseif var_36_0 == var_0_8.Scale then
					var_39_0 = arg_39_0
				elseif var_36_0 == var_0_8.Opacity then
					var_39_0 = arg_39_0 * 60
				else
					return
				end

				arg_35_0:updateCurInfo(var_36_1, var_36_0, var_39_0)
			end, 0, false)
		elseif arg_36_0 == cc.KeyCode.KEY_DOWN_ARROW then
			arg_35_0.curSchedule = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_40_0)
				local var_40_0

				if var_36_0 == var_0_8.Position then
					var_40_0 = {
						x = 0,
						y = -arg_40_0 * 100
					}
				elseif var_36_0 == var_0_8.Rotation then
					var_40_0 = -arg_40_0 * 50
				elseif var_36_0 == var_0_8.Scale then
					var_40_0 = -arg_40_0
				elseif var_36_0 == var_0_8.Opacity then
					var_40_0 = -arg_40_0 * 50
				else
					return
				end

				arg_35_0:updateCurInfo(var_36_1, var_36_0, var_40_0)
			end, 0, false)
		elseif arg_36_0 == cc.KeyCode.KEY_DELETE then
			local var_36_2 = var_0_0:getLastSelectIndex()

			if arg_35_0.curItemInfo.rightKeyOperateInfo == nil then
				arg_35_0.curItemInfo.rightKeyOperateInfo = {
					clickIndex = var_36_2
				}
			else
				arg_35_0.curItemInfo.rightKeyOperateInfo.clickIndex = var_36_2
			end

			arg_35_0:doDelete()
		end
	end, cc.Handler.EVENT_KEYBOARD_PRESSED)
	var_35_0:registerScriptHandler(function(arg_41_0, arg_41_1)
		if arg_41_0 == cc.KeyCode.KEY_LEFT_ARROW then
			arg_35_0:releaseKeyCallback()
		elseif arg_41_0 == cc.KeyCode.KEY_RIGHT_ARROW then
			arg_35_0:releaseKeyCallback()
		elseif arg_41_0 == cc.KeyCode.KEY_UP_ARROW then
			arg_35_0:releaseKeyCallback()
		elseif arg_41_0 == cc.KeyCode.KEY_DOWN_ARROW then
			arg_35_0:releaseKeyCallback()
		end
	end, cc.Handler.EVENT_KEYBOARD_RELEASED)
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(var_35_0, arg_35_0)
end

function TalkEditor.registerMouseEventCallback(arg_42_0)
	local var_42_0 = cc.EventListenerMouse:create(1)

	var_42_0:registerScriptHandler(handler(arg_42_0, function(arg_43_0, arg_43_1)
		if arg_42_0.editorStatus ~= var_0_14.NORMAL then
			return
		end

		arg_42_0:updateListViewScrollValue(arg_43_1)
	end), cc.Handler.EVENT_MOUSE_SCROLL)
	var_42_0:registerScriptHandler(handler(arg_42_0, function(arg_44_0, arg_44_1)
		if arg_42_0.editorStatus ~= var_0_14.NORMAL then
			return
		end

		if arg_44_1:getMouseButton() == 1 then
			arg_42_0:onRightKeyCallback((cc.p(arg_44_1:getCursorX(), arg_44_1:getCursorY())))
		else
			if arg_42_0.listLayerNode:getChildByName("rightKeyPanel") then
				arg_42_0.listLayerNode:getChildByName("rightKeyPanel"):removeFromParent()
			end

			if arg_42_0:getChildByName("propertyDetailPanel") then
				arg_42_0:getChildByName("propertyDetailPanel"):removeFromParent()
			end
		end
	end), cc.Handler.EVENT_MOUSE_UP)
	var_42_0:registerScriptHandler(handler(arg_42_0, function(arg_45_0, arg_45_1)
		if arg_42_0.editorStatus ~= var_0_14.NORMAL then
			return
		end

		arg_42_0:onMouseMoveCallback(arg_45_1)
	end), cc.Handler.EVENT_MOUSE_MOVE)
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(var_42_0, arg_42_0)
end

function TalkEditor:onMouseMoveCallback(arg_46_1)
	local var_46_0 = cc.p(arg_46_1:getCursorX(), arg_46_1:getCursorY())
	local var_46_1 = self:checkIsCanShowProperty(var_46_0)

	if var_46_1 == nil then
		self.isShowingPropertyIndex = nil

		return
	elseif var_46_1 and var_46_1.index == self.isShowingPropertyIndex then
		return nil
	end

	self:showPropertyDetailPanel(var_46_1, var_46_0)
end

function TalkEditor:checkIsCanShowProperty(arg_47_1)
	local var_47_0

	for iter_47_0 = 1, #var_0_13 do
		local var_47_1 = self.propertyLayerNode:getChildByName(var_0_13[iter_47_0].key):getChildByName("btn_tip")

		if var_47_1 then
			if var_0_13[iter_47_0].rect == nil then
				local var_47_2 = var_47_1:getBoundingBox()
				local var_47_3 = cc.p(0, 0)

				var_47_3.x, var_47_3.y = var_47_1:getPosition()

				local var_47_4 = var_47_1:getParent():convertToWorldSpace(var_47_3)

				var_0_13[iter_47_0].rect = {
					x = var_47_4.x,
					y = var_47_4.y,
					width = var_47_2.width,
					height = var_47_2.height
				}
			end

			if var_0_13[iter_47_0].index == nil then
				var_0_13[iter_47_0].index = iter_47_0
			end

			if cc.rectContainsPoint(var_0_13[iter_47_0].rect, arg_47_1) == true then
				var_47_0 = var_0_13[iter_47_0]

				break
			end
		end
	end

	return var_47_0
end

function TalkEditor.isNewClassId(arg_48_0, arg_48_1)
	local var_48_0 = true

	for iter_48_0, iter_48_1 in pairs(var_0_1) do
		if iter_48_1.classId == arg_48_1 then
			var_48_0 = false

			break
		end
	end

	return var_48_0
end

function TalkEditor.isExistInCurFolder(arg_49_0, arg_49_1)
	local var_49_0 = true

	for iter_49_0, iter_49_1 in pairs((require("data." .. var_0_0:getCurFolderName()))) do
		if iter_49_1.classId == arg_49_1 then
			var_49_0 = false

			break
		end
	end

	return var_49_0
end

function TalkEditor:checkRightKeyEventIsLegal(arg_50_1)
	local var_50_0 = 0

	for iter_50_0 = 1, #var_0_0:getTalkDataList() do
		local var_50_1 = self.listViewNode:cellAtIndex(iter_50_0 - 1)

		if var_50_1 then
			local var_50_2 = var_50_1:getChildByName("item")
			local var_50_3 = var_50_2:getChildByName("bg")
			local var_50_4 = var_50_3:getBoundingBox()
			local var_50_5 = cc.p(0, 0)

			var_50_5.x, var_50_5.y = var_50_3:getPosition()

			local var_50_6 = var_50_2:convertToWorldSpace(var_50_5)

			if cc.rectContainsPoint({
				x = var_50_6.x,
				y = var_50_6.y,
				width = var_50_4.width,
				height = var_50_4.height
			}, arg_50_1) == true then
				var_50_0 = iter_50_0

				break
			end
		end
	end

	return var_50_0
end

function TalkEditor:onRightKeyCallback(arg_51_1)
	if self.curItemInfo == nil or next(self.curItemInfo) == nil then
		return
	end

	local var_51_0 = self:checkRightKeyEventIsLegal(arg_51_1)

	if var_51_0 == 0 then
		return
	end

	if self.curItemInfo.rightKeyOperateInfo == nil then
		self.curItemInfo.rightKeyOperateInfo = {
			clickIndex = var_51_0
		}
	else
		self.curItemInfo.rightKeyOperateInfo.clickIndex = var_51_0
	end

	if self.listLayerNode:getChildByName("rightKeyPanel") then
		self.listLayerNode:getChildByName("rightKeyPanel"):removeFromParent()
	end

	local var_51_1 = ccui.ImageView:create("TalkEditorLayer/rightkey_bg.png", var_0_6)

	var_51_1:setName("rightKeyPanel")
	var_51_1:setAnchorPoint(cc.p(0, 1))
	self.listLayerNode:addChild(var_51_1)
	var_51_1:setPosition(cc.p(arg_51_1.x + 20, arg_51_1.y - 140))

	for iter_51_0, iter_51_1 in pairs({
		{
			title = "复  制",
			key = "btn_copy"
		},
		{
			title = "粘  贴",
			key = "btn_paste"
		},
		{
			title = "删  除",
			key = "btn_delete"
		}
	}) do
		local var_51_2 = ccui.Text:create(iter_51_1.title, FONT_DES, 36)

		var_51_2:setColor(cc.c3b(0, 0, 0))
		var_51_2:setAnchorPoint(cc.p(0, 1))
		var_51_2:setPosition(cc.p(40, 265 - iter_51_0 * 70))
		var_51_2:setTouchEnabled(true)
		var_51_2:addTouchEventListener(function(arg_52_0, arg_52_1)
			if arg_52_1 ~= ccui.TouchEventType.ended then
				return
			end

			if iter_51_0 == 1 then
				self:doCopy(var_51_0)
			elseif iter_51_0 == 2 then
				self:doPaste(var_51_0)
			elseif iter_51_0 == 3 then
				self:doDelete(var_51_0)
			end
		end)
		var_51_1:addChild(var_51_2)
	end
end

function TalkEditor:doCopy()
	self.curItemInfo.rightKeyOperateInfo.copyIndex = self.curItemInfo.rightKeyOperateInfo.clickIndex

	global_ShowBlockWords("已复制", nil, cc.p(self.ConfigWidth / 2 - 60, self.ConfigHeight / 2))
end

function TalkEditor:doPaste(arg_54_1)
	if self.curItemInfo.rightKeyOperateInfo.copyIndex == nil then
		global_ShowBlockWords("请先复制", nil, cc.p(self.ConfigWidth / 2 - 60, self.ConfigHeight / 2))
	else
		var_0_0:pasteTalkEditorListInfo(self.curItemInfo.rightKeyOperateInfo.copyIndex, arg_54_1)

		self.curItemInfo.rightKeyOperateInfo = nil

		self:loadClassIdConversation(self.curItemInfo.classId, arg_54_1 + 1)
		global_ShowBlockWords("粘贴成功", nil, cc.p(self.ConfigWidth / 2 - 60, self.ConfigHeight / 2))
	end
end

function TalkEditor:doDelete()
	var_0_0:deleteTalkEditorListInfo(self.curItemInfo.rightKeyOperateInfo.clickIndex)

	self.curItemInfo.rightKeyOperateInfo = nil

	self:loadClassIdConversation(self.curItemInfo.classId, var_0_0:getLastSelectIndex() - 1)
	global_ShowBlockWords("删除成功", nil, cc.p(self.ConfigWidth / 2 - 60, self.ConfigHeight / 2))
end

function TalkEditor:switchNewPanelStatus(arg_56_1)
	arg_56_1 = arg_56_1 or false

	self.btn_new:setVisible(arg_56_1)
	self.btn_read:setVisible(arg_56_1)
	self.newPanelEditBox1:setVisible(arg_56_1)
	self.newPanelEditBox2:setVisible(arg_56_1)
	self.newlines_input:setVisible(not arg_56_1)
end

function TalkEditor:createNewClassIdConversation(arg_57_1)
	self:switchNewPanelStatus(false)

	self.classId = arg_57_1

	var_0_0:createNewConversation(arg_57_1)

	var_0_1 = require("devtools.debug_console").updateMergeData("data.conversation_talkeditor_data")

	self:initUI()
end

function TalkEditor:loadClassIdConversation(arg_58_1, arg_58_2)
	self:switchNewPanelStatus(false)

	self.classId = arg_58_1

	var_0_0:loadOldConversation(arg_58_1, arg_58_2)
	self:initUI({
		lastIndex = arg_58_2
	})
end

function TalkEditor:registerButtonEventCallback()
	self.btn_new:addTouchEventListener(function(arg_60_0, arg_60_1)
		if arg_60_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curText1 == nil then
			global_ShowBlockWords("输入为空", nil, cc.p(self.ConfigWidth / 2 - 60, self.ConfigHeight / 2))
		elseif not self:isNewClassId(self.curText1) and self:isExistInCurFolder(self.curText1) then
			local var_60_0 = ConfirmDialogSprite:create("对话表中存在该id", "覆盖之前数据请选择确定，否则请取消", {
				surecallback = function()
					self:createNewClassIdConversation(self.curText1)
				end
			})
			local var_60_1 = var_60_0.rootLayer:getChildByName("Panel_Back")

			var_60_1:setPosition(cc.p(self.ConfigWidth / 2 + 260, self.ConfigHeight - 150))
			var_60_1:setAnchorPoint(cc.p(1, 1))
			self.root:addChild(var_60_0, 99)
			var_60_0:setName("dialog")
		elseif not self:isNewClassId(self.curText1) and not self:isExistInCurFolder(self.curText1) then
			global_ShowBlockWords("对话已存在但不在当前目录，请注意", nil, cc.p(self.ConfigWidth / 2 - 60, self.ConfigHeight / 2))
		else
			self:createNewClassIdConversation(self.curText1)
		end
	end)
	self.btn_read:addTouchEventListener(function(arg_62_0, arg_62_1)
		if arg_62_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curText2 == nil then
			global_ShowBlockWords("输入为空", nil, cc.p(self.ConfigWidth / 2 - 60, self.ConfigHeight / 2))
		elseif not self:isNewClassId(self.curText2) and not self:isExistInCurFolder(self.curText1) then
			global_ShowBlockWords("对话已存在但不在当前目录，请注意", nil, cc.p(self.ConfigWidth / 2 - 60, self.ConfigHeight / 2))
		elseif not self:isNewClassId(self.curText2) and self:isExistInCurFolder(self.curText1) then
			self:loadClassIdConversation(self.curText2)
		else
			local var_62_0 = ConfirmDialogSprite:create("对话表中不存在该id", "新建请选择确定，否则请取消", {
				surecallback = function()
					self:createNewClassIdConversation(self.curText2)
				end
			})
			local var_62_1 = var_62_0.rootLayer:getChildByName("Panel_Back")

			var_62_1:setPosition(cc.p(self.ConfigWidth / 2 + 260, self.ConfigHeight - 150))
			var_62_1:setAnchorPoint(cc.p(1, 1))
			self.root:addChild(var_62_0, 99)
			var_62_0:setName("dialog")
		end
	end)
	self.btn_save:addTouchEventListener(function(arg_64_0, arg_64_1)
		if arg_64_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.editorStatus ~= var_0_14.NORMAL then
			return
		end

		self:saveCurContentInfo()
	end)
	self.btn_console:addTouchEventListener(function(arg_65_0, arg_65_1)
		if arg_65_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.editorStatus ~= var_0_14.NORMAL then
			return
		end

		self.editorStatus = var_0_14.CONSOLE

		self:openTalkDetailPanel({
			closeCallback = function(self)
				self.editorStatus = var_0_14.NORMAL
				self.curItemInfo = self.curItemInfo

				self:updatePropertyInfoPanel()
				self:saveToCacheAndRefresh()
			end,
			editorStatus = self.editorStatus,
			curItemInfo = self.curItemInfo
		})
	end)
	self.btn_xuanxiang:addTouchEventListener(function(arg_67_0, arg_67_1)
		if arg_67_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.editorStatus ~= var_0_14.NORMAL then
			return
		end

		self.editorStatus = var_0_14.ADDXUANXIANG

		self:openTalkDetailPanel({
			closeCallback = function(self)
				self.editorStatus = var_0_14.NORMAL
				self.curItemInfo = self.curItemInfo

				self:updatePropertyInfoPanel()
				self:saveToCacheAndRefresh()
			end,
			editorStatus = self.editorStatus,
			curItemInfo = self.curItemInfo
		})
	end)
	self.btn_last:addTouchEventListener(function(arg_69_0, arg_69_1)
		if arg_69_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_69_0 = var_0_0:getLastSelectIndex()

		if var_69_0 == nil then
			return
		end

		self:onBtnSelectCallback((math.max(var_69_0 - 1, 1)))
		self:scrollToIndex()
	end)
	self.btn_next:addTouchEventListener(function(arg_70_0, arg_70_1)
		if arg_70_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_70_0 = var_0_0:getLastSelectIndex()
		local var_70_1 = var_0_0:getTalkDataList()

		var_70_0 = var_70_0 or 0

		if #var_70_1 < 1 then
			return
		end

		self:onBtnSelectCallback((math.min(var_70_0 + 1, #var_70_1)))
		self:scrollToIndex()
	end)
	self.btn_revoke:addTouchEventListener(function(arg_71_0, arg_71_1)
		if arg_71_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curItemInfo == nil or next(self.curItemInfo) == nil then
			global_ShowBlockWords("当前无对话，请先创建/加载", nil, cc.p(self.ConfigWidth / 2 - 60, self.ConfigHeight / 2))

			return
		end

		local var_71_0 = ConfirmDialogSprite:create(L_RESET[2], L_RESET[6], {
			name = "equip",
			surecallback = function()
				var_0_1 = require("devtools.debug_console").updateMergeData("data.conversation_talkeditor_data")

				self:loadClassIdConversation(self.curItemInfo.classId)
			end
		})
		local var_71_1 = var_71_0.rootLayer:getChildByName("Panel_Back")

		var_71_1:setPosition(cc.p(self.ConfigWidth / 2 + 260, self.ConfigHeight - 150))
		var_71_1:setAnchorPoint(cc.p(1, 1))
		self.root:addChild(var_71_0, 99)
		var_71_0:setName("dialog")
	end)
	self.btn_reset:addTouchEventListener(function(arg_73_0, arg_73_1)
		if arg_73_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curItemInfo == nil or next(self.curItemInfo) == nil then
			global_ShowBlockWords("当前无对话，请先创建/加载", nil, cc.p(self.ConfigWidth / 2 - 60, self.ConfigHeight / 2))

			return
		end

		local var_73_0 = ConfirmDialogSprite:create(L_RESET[2], L_RESET[6], {
			name = "equip",
			surecallback = function()
				var_0_1 = require("devtools.debug_console").updateMergeData("data.conversation_talkeditor_data")

				self:loadClassIdConversation(self.curItemInfo.classId)
			end
		})
		local var_73_1 = var_73_0.rootLayer:getChildByName("Panel_Back")

		var_73_1:setPosition(cc.p(self.ConfigWidth / 2 + 260, self.ConfigHeight - 150))
		var_73_1:setAnchorPoint(cc.p(1, 1))
		self.root:addChild(var_73_0, 99)
		var_73_0:setName("dialog")
	end)
	self.btn_preview:addTouchEventListener(function(arg_75_0, arg_75_1)
		if arg_75_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_75_0 = self.curItemInfo

		if self.curItemInfo == nil or next(var_75_0) == nil then
			global_ShowBlockWords("当前无对话，请先创建/加载", nil, cc.p(self.ConfigWidth / 2 - 60, self.ConfigHeight / 2))

			return
		end

		if self.talkNode:getChildByName("talkLayer") then
			self.talkNode:getChildByName("talkLayer"):removeFromParent()
		end

		local var_75_1 = TalkLayer:showCurTalk(var_75_0.classId, 1, function()
			self.listLayerNode:setVisible(true)
			self.propertyLayerNode:setVisible(true)
			self.talkNode:getChildByName("mask"):setVisible(true)

			self.editorStatus = var_0_14.NORMAL
		end)

		var_75_1:setName("talkLayer")
		self.talkNode:addChild(var_75_1, 0)
		self.talkNode:setVisible(true)
		self.talkNode:getChildByName("mask"):setVisible(false)
		self.listLayerNode:setVisible(false)
		self.propertyLayerNode:setVisible(false)

		self.editorStatus = var_0_14.PREVIEW
	end)
	self.btn_quick_new:addTouchEventListener(function(arg_77_0, arg_77_1)
		if arg_77_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curItemInfo == nil or next(self.curItemInfo) == nil then
			global_ShowBlockWords("当前无对话，请先创建/加载", nil, cc.p(self.ConfigWidth / 2 - 60, self.ConfigHeight / 2))

			return
		end

		self:onBtnQuickNewCallback()
	end)
end

function TalkEditor:openTalkDetailPanel(arg_78_1)
	if self.detailPanel then
		self.detailPanel:setVisible(true)
		self.detailPanel:ctor(arg_78_1)
	else
		require("view.Layer.TalkEditor.TalkEditorDetailLayer")

		self.detailPanel = TalkEditorDetailLayer:create(arg_78_1)

		self.detailPanel:setName("propertyDetail")
		self.root:addChild(self.detailPanel, 1)
	end

	self.editorStatus = arg_78_1.editorStatus
end

function TalkEditor:openTalkSettingPanel(arg_79_1)
	if self.settingPanel then
		self.settingPanel:setVisible(true)
		self.settingPanel:ctor(arg_79_1)
	else
		require("view.Layer.TalkEditor.TalkEditorSettingLayer")

		self.settingPanel = TalkEditorSettingLayer:create(arg_79_1)

		self.settingPanel:setName("setting")
		self.root:addChild(self.settingPanel, 1)
	end

	self.editorStatus = arg_79_1.editorStatus
end

function TalkEditor:updateListViewScrollValue(arg_80_1)
	if self.percent == nil then
		return
	end

	self.percent = math.min(self.percent + arg_80_1:getScrollY() * 2, 100)
	self.percent = math.max(self.percent, 0)

	self.listViewNode:scrollToPercent(self.percent, nil, false)
end

function TalkEditor.getItemNode(arg_81_0)
	local var_81_0 = ccui.Layout:create()

	var_81_0:setContentSize(cc.size(var_0_4, var_0_5))

	local var_81_2 = ccui.Button:create(var_0_7.NORMAL, nil, nil, var_0_6)

	var_81_2:setAnchorPoint(cc.p(0, 0))
	var_81_2:setSwallowTouches(false)
	var_81_2:setScale9Enabled(true)
	var_81_2:setContentSize(cc.size(var_0_4, var_0_5))
	var_81_2:setName("bg")
	var_81_0:addChild(var_81_2)
	var_81_0:setAnchorPoint(cc.p(0, 0))

	local var_81_3 = ccui.Text:create("", FONT_DES, 36)

	var_81_3:setName("title")
	var_81_3:setPosition(cc.p(20, 230 - var_0_3))
	var_81_2:addChild(var_81_3)

	local var_81_4 = ccui.Text:create("", FONT_DES, 36)

	var_81_4:setName("content")
	var_81_4:setPosition(cc.p(15, 200 - var_0_3))
	var_81_4:ignoreContentAdaptWithSize(false)
	var_81_4:setContentSize(cc.size(800, 200))
	var_81_4:setAnchorPoint(cc.p(0, 1))
	var_81_2:addChild(var_81_4)

	return var_81_0
end

function TalkEditor:onBtnQuickNewCallback()
	local var_82_0 = #var_0_0:getTalkDataList()

	var_0_0:createNewConversation(self.classId, var_82_0 + 1)
	self:initUI({
		lastIndex = var_82_0
	})
end

function TalkEditor:onBtnSelectCallback(arg_83_1)
	local var_83_0 = var_0_0:getLastSelectIndex()

	if arg_83_1 == nil then
		return
	elseif var_83_0 then
		local var_83_1 = self.listViewNode:cellAtIndex(var_83_0 - 1)

		if var_83_1 then
			local var_83_2 = var_83_1:getChildByName("item")

			if var_83_2 then
				local var_83_3 = var_83_2:getChildByName("bg")

				var_83_3:loadTextures(var_0_7.NORMAL, nil, nil, var_0_6)
				var_83_3:getChildByName("title"):setColor(cc.c3b(255, 255, 255))
				var_83_3:getChildByName("content"):setColor(cc.c3b(255, 255, 255))
			end
		end
	end

	var_0_0:selectListIndex(arg_83_1)

	local var_83_4 = self.listViewNode:cellAtIndex(arg_83_1 - 1)

	if var_83_4 then
		local var_83_5 = var_83_4:getChildByName("item"):getChildByName("bg")

		var_83_5:loadTextures(var_0_7.SELECTED, nil, nil, var_0_6)
		var_83_5:getChildByName("title"):setColor(cc.c3b(0, 0, 0))
		var_83_5:getChildByName("content"):setColor(cc.c3b(0, 0, 0))
	end

	self:updatePanel(arg_83_1)
end

function TalkEditor:isShowPlayerNow()
	if self.curItemInfo == nil or next(self.curItemInfo) == nil or self.curItemInfo.playerPosType / 2 < 1 then
		return false
	end

	return true
end

function TalkEditor:updatePanel(arg_85_1)
	self.curItemInfo = cloneconf(var_0_0:getTalkDataList(arg_85_1))

	self:updatePropertyInfoPanel()
	self:updateContentInfoPanel()
	var_0_0:updateConsoleListInfo(self.curItemInfo)
end

function TalkEditor:updatePropertyInfoPanel()
	if self.curItemInfo == nil or next(self.curItemInfo) == nil then
		return
	end

	self.classIdNode:setString(self.classId)

	for iter_86_0, iter_86_1 in pairs(var_0_15) do
		local var_86_0 = self.curItemInfo[var_0_16[iter_86_0]] or ""
		local var_86_1 = var_0_17[self["new" .. iter_86_1].index]

		if var_0_17[self["new" .. iter_86_1].index] == nil then
			self["new" .. iter_86_1]:setText(var_86_0)
			self[iter_86_1]:setText(var_86_0)
		else
			self[iter_86_1]:setText((var_0_0:getShowPropertyInfo(var_86_1, var_86_0)))

			self["new" .. iter_86_1].propertyText = var_86_1 == var_0_12.Bubble and (self.curItemInfo.playerBubble ~= nil and self.curItemInfo.playerBubble ~= "" and self.curItemInfo.playerBubble .. "=" .. (self.curItemInfo.Bubble_ActionType or 1) or "") or var_86_0
		end
	end

	local var_86_3 = self

	var_0_2:setTglContainerCallback(self.toggleContaniner1, function(arg_87_0)
		var_86_3:onTglContainer1Callback(arg_87_0)
	end, 1)
	var_0_2:setTglContainerCallback(self.toggleContaniner2, function(arg_88_0)
		var_86_3:onTglContainer2Callback(arg_88_0)
	end, 1)
	var_0_2:setToggleCallback(self.toggleNode, function(arg_89_0)
		var_86_3:onToggleCallback(arg_89_0)
	end, self:isShowPlayerNow())
	var_0_2:setTglContainerCallback(self.toggleContaniner3, function(arg_90_0)
		var_86_3:onTglContainer3Callback(arg_90_0)
	end, self.curItemInfo.playerPosType % 2 + 1)

	local var_86_4 = self.propertyLayerNode:getChildByName("btn_saveToExcel")
	local var_86_5 = self.propertyLayerNode:getChildByName("btn_setting")

	var_86_4:setVisible(self.editorStatus == var_0_14.NORMAL)
	var_86_5:setVisible(self.editorStatus == var_0_14.FREE)
end

function TalkEditor:updateCurSelectNode()
	if self.talkNode:getChildByName("talkLayer") == nil then
		return
	end

	local var_91_0 = self.talkNode:getChildByName("talkLayer"):getChildByName("Talk"):getChildByName("panel")

	self.curSelectNode = self.curItemInfo.operateObjectIndex == 1 and var_91_0:getChildByName("leftPlayer") or var_91_0:getChildByName("bg")
end

function TalkEditor:updateContentInfoPanel()
	if self.curItemInfo == nil or next(self.curItemInfo) == nil then
		return
	end

	if self.talkNode:getChildByName("talkLayer") then
		self.talkNode:getChildByName("talkLayer"):removeFromParent()
	end

	local var_92_0 = TalkLayer:showCurTalk(self.curItemInfo.classId, self.curItemInfo.index)

	var_92_0:setName("talkLayer")
	self.talkNode:addChild(var_92_0, 0)
	self.talkNode:setVisible(true)
	self:updateCurSelectNode()
end

function TalkEditor:initTableViewPanel(arg_93_1)
	local var_93_0 = var_0_0:getTalkDataList()

	if var_93_0 == nil or next(var_93_0) == nil then
		return
	end

	self.editorStatus = var_0_14.NORMAL

	if self.listViewNode ~= nil then
		self.listViewNode:removeFromParent()

		self.listViewNode = nil
	end

	self.listViewNode = var_0_2:getTableView(#var_93_0, function(arg_94_0)
		return var_0_4, var_0_5
	end, cc.size(var_0_4, GameDisplay.height - 100 - 300), function(arg_95_0, arg_95_1)
		local var_95_0 = arg_95_0:dequeueCell()

		if var_95_0 == nil then
			var_95_0 = cc.TableViewCell:new()
		end

		local var_95_1 = var_95_0:getChildByName("item")

		if var_95_1 then
			var_95_1:removeFromParent()
		end

		local var_95_3 = self:getItemNode()

		var_95_0:addChild(var_95_3)
		var_95_3:setName("item")

		local var_95_4 = var_95_3:getChildByName("bg")

		var_95_4.clickCount = 0
		var_95_4.index = arg_95_1 + 1

		var_95_4:addTouchEventListener(function(arg_96_0, arg_96_1)
			if arg_96_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_96_0:getTouchBeganPosition().y - arg_96_0:getTouchEndPosition().y) > 50 then
				return
			end

			arg_96_0.clickCount = arg_96_0.clickCount + 1

			if arg_96_0.clickCount >= 2 then
				arg_96_0.clickCount = 0

				self:lateUpdate(function()
					self:onBtnQuickNewCallback()
				end)
			elseif arg_96_0.clickCount >= 1 then
				self:onBtnSelectCallback(arg_96_0.index)
			end

			self:usualSchedulerWithCallback(function()
				arg_96_0.clickCount = 0
			end, 0.2)
		end)

		local var_95_5 = var_95_4:getChildByName("title")

		var_95_5:setString(var_93_0[arg_95_1 + 1].index)

		local var_95_6 = var_95_4:getChildByName("content")

		var_95_6:setString(var_0_2:getFormatString(var_93_0[arg_95_1 + 1].content, 20, "..."))

		if var_0_0:getLastSelectIndex() == arg_95_1 + 1 then
			var_95_4:loadTextures(var_0_7.SELECTED, nil, nil, var_0_6)
			var_95_5:setColor(cc.c3b(0, 0, 0))
			var_95_6:setColor(cc.c3b(0, 0, 0))
			self:updatePanel(arg_95_1 + 1)
		else
			var_95_4:loadTextures(var_0_7.NORMAL, nil, nil, var_0_6)
			var_95_5:setColor(cc.c3b(255, 255, 255))
			var_95_6:setColor(cc.c3b(255, 255, 255))
		end

		return var_95_0
	end, function()
		return
	end, function(arg_100_0)
		return
	end)

	self.listViewNode:setPosition(cc.p(0, 172))
	self.listViewNode:setVisible(true)
	self.listViewNode:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.listLayerNode:addChild(self.listViewNode)
	self:lateUpdate(function()
		self:scrollToIndex(arg_93_1 and arg_93_1.lastIndex)
	end)
end

function TalkEditor:usualSchedulerWithCallback(arg_102_1, arg_102_2)
	arg_102_2 = arg_102_2 or 1

	if self.usualScheduler ~= nil then
		self.scheduler:unscheduleScriptEntry(self.usualScheduler)
	end

	self.usualScheduler = self.scheduler:scheduleScriptFunc(function()
		if self.usualScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.usualScheduler)
		end

		if type(arg_102_1) == "function" then
			arg_102_1()
		end
	end, arg_102_2, false)
end

function TalkEditor:lateUpdate(arg_104_1)
	if self.cinemaScheduler ~= nil then
		self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

		self.cinemaScheduler = nil
	end

	self.cinemaScheduler = self.scheduler:scheduleScriptFunc(function()
		if self.cinemaScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

			self.cinemaScheduler = nil
		end

		if type(arg_104_1) == "function" then
			arg_104_1()
		end
	end, 0, false)
end

function TalkEditor:scrollToIndex(arg_106_1)
	local var_106_0 = arg_106_1 or var_0_0:getLastSelectIndex()
	local var_106_1 = var_0_0:getTalkDataList()

	var_106_0 = var_106_0 or #var_106_1
	self.percent = 0

	self.listViewNode:scrollToPercent(math.min(100, math.floor(100 * math.max(var_106_0, 4) / #var_106_1)), nil, false)
end

function TalkEditor:initCurClassitionInfo(arg_107_1)
	local var_107_0 = self.talkEditorInfo.curClassitionInfo

	if self.talkEditorInfo.curClassitionInfo.isHaved == true then
		local var_107_2 = cc.clampf(arg_107_1 == nil and 1 or var_107_0.curPageNum + arg_107_1, 1, var_107_0.totalPageNum)
		local var_107_3 = require("data.model_data")[self.talkEditorInfo.curTalkTable[var_107_2].playerId]

		var_107_0.curPageNum = var_107_2
		var_107_0.bgPath = "mainScenebg/" .. self.talkEditorInfo.curTalkTable[var_107_2].background .. ".jpg"
		var_107_0.rolePath = "role/" .. self.talkEditorInfo.curTalkTable[var_107_2].playerId .. ".png"
		var_107_0.expressionPath = "expression/" .. var_107_3[self.talkEditorInfo.curTalkTable[var_107_2].playerExpression] .. ".png"
		var_107_0.roleType = self.talkEditorInfo.curTalkTable[var_107_2].playerPosType
		var_107_0.dec = self.talkEditorInfo.curTalkTable[var_107_2].playerLines
		var_107_0.playerName = var_107_3.name

		if self.talkEditorInfo.curTalkTable[var_107_2].playerPosType % 2 == 0 then
			local var_107_4 = self.talkEditorInfo.curTalkTable[var_107_2].leftPlayer_Position or self.talkEditorInfo.curTalkTable[var_107_2].rightPlayer_Position

			if var_107_4 ~= nil then
				local var_107_5 = string.split(var_107_4, "=")

				var_107_0.playerPos = cc.p(tonumber(var_107_5[1]), tonumber(var_107_5[2]))
			end
		end
	end
end

function TalkEditor:saveCurContentInfoToCache()
	if self.curItemInfo == nil or next(self.curItemInfo) == nil then
		global_ShowBlockWords("当前无对话，请先创建/加载", nil, cc.p(self.ConfigWidth / 2 - 60, self.ConfigHeight / 2))

		return
	end

	for iter_108_0 = 1, #var_0_15 do
		if var_0_17[iter_108_0] == nil then
			self.curItemInfo[var_0_16[iter_108_0]] = self[var_0_15[iter_108_0]]:getStringValue()
		elseif var_0_17[iter_108_0] == var_0_12.Bubble then
			local var_108_0 = string_split(self["new" .. var_0_15[iter_108_0]].propertyText, "=")

			self.curItemInfo[var_0_16[iter_108_0]] = var_108_0[1]
			self.curItemInfo.Bubble_ActionType = var_108_0[2]
		else
			self.curItemInfo[var_0_16[iter_108_0]] = self["new" .. var_0_15[iter_108_0]].propertyText
		end
	end

	local var_108_1 = var_0_0:getConsoleDataList()

	for iter_108_1 = 1, #var_0_9 do
		if iter_108_1 == 3 then
			local var_108_2 = false

			for iter_108_2 = 1, #var_0_9[iter_108_1].list do
				if var_0_9[iter_108_1].list[iter_108_2].value ~= nil and var_0_9[iter_108_1].list[iter_108_2].value ~= "" then
					var_108_2 = true
					self.curItemInfo.specialEffect = iter_108_2 .. "=" .. var_0_9[iter_108_1].list[iter_108_2].value

					break
				end
			end

			if var_108_2 == false then
				self.curItemInfo.specialEffect = nil
			end
		else
			for iter_108_3 = 1, #var_0_9[iter_108_1].list do
				if var_0_9[iter_108_1].list[iter_108_3].status == 1 then
					self.curItemInfo[var_0_9[iter_108_1].keyList[iter_108_3]] = var_0_9[iter_108_1].list[iter_108_3].value
				end
			end
		end
	end

	var_0_0:setTalkEditorListInfo(var_0_0:getLastSelectIndex(), self.curItemInfo)
end

function TalkEditor:saveCurContentInfo()
	self:saveToCacheAndRefresh()
	var_0_0:saveInfoToFile()
	global_ShowBlockWords("保存成功 " .. os.date(), nil, cc.p(self.ConfigWidth / 2 - 60, self.ConfigHeight / 2))

	var_0_1 = require("devtools.debug_console").updateMergeData("data.conversation_talkeditor_data")

	self:initUI()
end

function TalkEditor:showPropertyDetailPanel(arg_110_1, arg_110_2)
	local var_110_0 = self:convertToNodeSpace(arg_110_2)

	self.isShowingPropertyIndex = arg_110_1.index

	if self:getChildByName("propertyDetailPanel") then
		self:getChildByName("propertyDetailPanel"):removeFromParent()
	end

	local var_110_1 = ccui.ImageView:create("EquipLayer/popup_buff_details.png", var_0_6)

	var_110_1:setPosition(cc.p(var_110_0.x, var_110_0.y + 30))
	var_110_1:setScale9Enabled(true)
	var_110_1:setAnchorPoint(cc.p(1, 0))
	var_110_1:setCapInsets(cc.rect(20, 20, 20, 20))
	var_110_1:setName("propertyDetailPanel")
	self:addChild(var_110_1)
	self:usualSchedulerWithCallback(function()
		if self:getChildByName("propertyDetailPanel") then
			self:getChildByName("propertyDetailPanel"):runAction(cc.RemoveSelf:create())
		end
	end, 4)

	local var_110_2 = 400
	local var_110_3 = var_110_1:getContentSize().height
	local var_110_4 = cc.Label:createWithTTF("", FONT_W5, 30)

	var_110_4:setMaxLineWidth(400)
	var_110_4:setVisible(false)
	var_110_1:addChild(var_110_4)
	var_110_4:setString(arg_110_1.des)

	local var_110_5 = 0 + 26 + var_110_4:getContentSize().height + 6

	if var_110_3 < var_110_5 then
		var_110_1:setContentSize(cc.size(var_110_1:getContentSize().width, var_110_5))
	else
		var_110_5 = var_110_3
	end

	local var_110_7 = cc.Label:createWithTTF(arg_110_1.name, FONT_W5, 24)

	var_110_7:setAnchorPoint(cc.p(0, 1))
	var_110_7:setColor(cc.c3b(64, 240, 95))
	var_110_7:setPosition(cc.p(20, var_110_5))
	var_110_1:addChild(var_110_7)

	local var_110_8 = cc.Label:createWithTTF(arg_110_1.des, FONT_W5, 24)

	var_110_8:setColor(cc.c3b(220, 235, 241))
	var_110_8:setAnchorPoint(cc.p(0, 1))
	var_110_8:setMaxLineWidth(var_110_2)
	var_110_8:setPosition(cc.p(4, var_110_5 - 26))
	var_110_8:setVisible(false)
	var_110_1:addChild(var_110_8)

	local var_110_9 = RichTextPro:create()

	var_110_9:setMaxWidth(var_110_2)
	var_110_9:setSize(24)

	var_110_9.fontName = FONT_W5

	var_110_9:setColor(cc.c3b(220, 251, 241))
	var_110_9:setLineSpace(0)
	var_110_9:setText((transSkillDesToRichText(arg_110_1.des)))
	var_110_9:setPosition(cc.p(20, var_110_5 - 26))
	var_110_1:addChild(var_110_9)
end
