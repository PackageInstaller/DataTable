local function var_0_0(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8)
	local var_1_0 = cc.EditBox:create(arg_1_7, (config._DEBUG or nil) and (cc.Scale9Sprite:create("public/panelbg/editBoxBG.png") or cc.Scale9Sprite:createWithSpriteFrameName("public/panelbg/editBoxBG.png")))

	var_1_0:setName(arg_1_0)
	var_1_0:setPosition(arg_1_8)
	var_1_0:setAnchorPoint(cc.p(0, 0.5))
	var_1_0:setFontName(arg_1_3)
	var_1_0:setPlaceholderFont(arg_1_3, arg_1_2)
	var_1_0:setFontSize(arg_1_2)
	var_1_0:setFontColor(cc.c3b(255, 255, 255))
	var_1_0:setPlaceHolder(arg_1_4)
	var_1_0:setPlaceholderFontColor(cc.c3b(255, 255, 255))
	var_1_0:setMaxLength(arg_1_5)
	var_1_0:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	var_1_0:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
	var_1_0:setInputFlag(arg_1_6)
	arg_1_1:addChild(var_1_0, 100)

	return var_1_0
end

local model_data = require("data.model_data")

local function var_0_2(arg_2_0)
	local var_2_0, var_2_1 = arg_2_0:match("([^,]+),(.+)")

	return cc.p(checknumber(var_2_0), checknumber(var_2_1))
end

local function var_0_3(arg_3_0)
	local var_3_0 = model_data[arg_3_0] and model_data[arg_3_0].offset_x_l
	local var_3_1 = model_data[arg_3_0] and model_data[arg_3_0].offset_y_l
	local var_3_2 = model_data[arg_3_0] and model_data[arg_3_0].offset_x_m
	local var_3_3 = model_data[arg_3_0] and model_data[arg_3_0].offset_y_m
	local var_3_4 = model_data[arg_3_0] and model_data[arg_3_0].offset_x_r
	local var_3_5 = model_data[arg_3_0] and model_data[arg_3_0].offset_y_r

	var_3_0 = var_3_0 or 0
	var_3_1 = var_3_1 or 0
	var_3_2 = var_3_2 or 0
	var_3_3 = var_3_3 or 0
	var_3_4 = var_3_4 or 0
	var_3_5 = var_3_5 or 0

	return {
		left = cc.p(var_3_0, var_3_1),
		mid = cc.p(var_3_2, var_3_3),
		right = cc.p(var_3_4, var_3_5)
	}
end

local var_0_4 = {
	left = cc.p(0, 0),
	mid = cc.p(0, 0),
	right = cc.p(0, 0)
}
local var_0_5
local var_0_6 = "mid"
local var_0_7 = {
	mid = 0,
	left = -200,
	right = 200
}

function TalkLayer:initDebugCom(arg_4_1)
	local var_4_0 = model_data[modelid] and model_data[modelid].mainmidpos and var_0_2(model_data[modelid].mainmidpos) or cc.p(320, -30)

	var_0_4 = var_0_3(arg_4_1)

	self.role_main:stopAllActions()
	self.role_main:setPosition(cc.p(var_4_0.x + var_0_4[var_0_6].x, var_4_0.y + var_0_4[var_0_6].y))

	local var_4_1 = ccs.GUIReader:getInstance():widgetFromJsonFile("MainLayerDebug.json")

	self:addChild(var_4_1, 10)

	local var_4_2 = var_0_0("input", var_4_1:getChildByName("Panel_1"), 30, "fonts/newkj.ttf", arg_4_1, 22, cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD, cc.size(100, 70), cc.p(80, 150))
	local var_4_3 = var_4_1:getChildByName("Panel_1")
	local var_4_4 = var_4_1:getChildByName("Panel_21")

	var_4_4:setVisible(true)

	var_0_5 = arg_4_1

	var_4_3:getChildByName("choose"):addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_5_0 = checkint(var_4_2:getText())

		if not model_data[var_5_0] then
			global_ShowBlockWords("modelid error")
		end

		self:changeShowModel(var_5_0)
	end)
	var_4_3:getChildByName("up"):addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_0_4[var_0_6].y = var_0_4[var_0_6].y + 1

		self:updatePosition(cc.p(0, 1))
	end)
	var_4_3:getChildByName("down"):addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_0_4[var_0_6].y = var_0_4[var_0_6].y - 1

		self:updatePosition(cc.p(0, -1))
	end)
	var_4_3:getChildByName("left"):addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_0_4[var_0_6].x = var_0_4[var_0_6].x - 1

		self:updatePosition(cc.p(-1, 0))
	end)
	var_4_3:getChildByName("right"):addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_0_4[var_0_6].x = var_0_4[var_0_6].x + 1

		self:updatePosition(cc.p(1, 0))
	end)
	var_4_3:getChildByName("output"):addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_0_5 then
			return
		end

		self:outPutOffset()
	end)
	var_4_4:getChildByName("left"):addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_0_6 == "left" then
			return
		end

		var_0_6 = "left"

		local var_11_0 = model_data[modelid] and model_data[modelid].mainmidpos and var_0_2(model_data[modelid].mainmidpos) or cc.p(320, -30)

		self.role_main:setPosition(cc.p(var_11_0.x + var_0_7[var_0_6] + var_0_4[var_0_6].x, var_11_0.y + var_0_4[var_0_6].y))
	end)
	var_4_4:getChildByName("mid"):addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_0_6 == "mid" then
			return
		end

		var_0_6 = "mid"

		local var_12_0 = model_data[modelid] and model_data[modelid].mainmidpos and var_0_2(model_data[modelid].mainmidpos) or cc.p(320, -30)

		self.role_main:setPosition(cc.p(var_12_0.x + var_0_7[var_0_6] + var_0_4[var_0_6].x, var_12_0.y + var_0_4[var_0_6].y))
	end)
	var_4_4:getChildByName("right"):addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_0_6 == "right" then
			return
		end

		var_0_6 = "right"

		local var_13_0 = model_data[modelid] and model_data[modelid].mainmidpos and var_0_2(model_data[modelid].mainmidpos) or cc.p(320, -30)

		self.role_main:setPosition(cc.p(var_13_0.x + var_0_7[var_0_6] + var_0_4[var_0_6].x, var_13_0.y + var_0_4[var_0_6].y))
	end)
end

function TalkLayer:changeShowModel(arg_14_1)
	var_0_5 = arg_14_1
	var_0_4 = var_0_3(arg_14_1)

	local var_14_0 = model_data[arg_14_1] and model_data[arg_14_1].mainmidpos and var_0_2(model_data[arg_14_1].mainmidpos) or cc.p(320, -30)

	self.role_main:setTexture("role/" .. model_data[arg_14_1].role_image .. ".png")
	self.role_main:setPosition(cc.p(var_14_0.x + var_0_7[var_0_6] + var_0_4[var_0_6].x, var_14_0.y + var_0_4[var_0_6].y))
end

function TalkLayer:updatePosition(arg_15_1)
	local var_15_0, var_15_1 = self.role_main:getPosition()

	self.role_main:setPosition(cc.p(var_15_0 + arg_15_1.x, var_15_1 + arg_15_1.y))
end

function TalkLayer.outPutOffset(arg_16_0)
	local var_16_0 = io.open("./TalkLayerPos.lua", "a+")

	var_16_0:write(dump({
		modelid = var_0_5,
		postype = var_0_6,
		offset = string.format("%d,%d", var_0_4[var_0_6].x, var_0_4[var_0_6].y)
	}, true) .. "\n")
	var_16_0:flush()
	var_16_0:close()
end

function TalkLayer.initTalkEditorMode(arg_17_0)
	arg_17_0.talkEditorMode = config._DEBUG == true and config._DEVELOP_MODE == "DATADEV" and config._DEBUG_DIALOGEDITOR == true
end

function TalkLayer:showCurTalk(arg_18_1, arg_18_2, arg_18_3)
	if self.talkEditorMode ~= true then
		return
	end

	function self:changeCurPageNum()
		if self.talkEditorMode ~= true then
			return
		end

		self.talkInfo.curClassitionInfo.curPageNum = math.max(arg_18_2 - 1, 0)
	end

	function self.loadConversationSaveTable(arg_20_0)
		local talkeditor_manager = require("controller.talkeditor_manager")

		arg_20_0.ConversationSaveTable = require("devtools.debug_console").updateMergeData("data.conversation_talkeditor_data")
	end

	return (self:create(arg_18_1, nil, TALK_TYPE_NORMAL, nil, arg_18_3))
end

function TalkLayer:isTalkEditorMode()
	return self.talkEditorMode == true
end

function TalkLayer.TalkEditorModeFullScreen(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in pairs(arg_22_1.uiNode:getChildren()) do
		if iter_22_1:getName() ~= "btn_autoplay" then
			iter_22_1.full_posY = arg_22_1.ScreenHeight - 1136 + iter_22_1:getPositionY()

			iter_22_1:setPositionY(iter_22_1.full_posY)
		else
			iter_22_1.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, iter_22_1:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

			iter_22_1:setPositionY(iter_22_1.full_posY)
		end
	end
end

function TalkLayer:loadDataFromEditorCache(arg_23_1, arg_23_2)
	if self.talkEditorMode ~= true then
		return
	end

	self:initCurTalkPropertyInfo(require("controller.talkeditor_manager"):getTalkDataList(arg_23_2), arg_23_1)
end
