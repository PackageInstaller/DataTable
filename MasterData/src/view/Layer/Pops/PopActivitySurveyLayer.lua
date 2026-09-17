PopActivitySurveyLayer = class("PopActivitySurveyLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0
local mail_data = require("data.mail_data")
local drop_data = require("data.drop_data")
local activity_survey_data = require("data.activity_survey_data")
local drop_manager = require("controller.drop_manager")
local var_0_5 = config._DEBUG and 0 or 1
local network = require("network.network")

function PopActivitySurveyLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopActivitySurveyLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopActivitySurveyLayer:init(arg_3_1)
	print("open poplayer : PopActivitySurveyLayer", dump(arg_3_1))

	arg_3_1 = arg_3_1 or {}
	self.surveytype = arg_3_1.type or var_0_0
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopActivitySurveyLayer.json" or "PopActivitySurveyLayer.ExportJson")

	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
	self.rootLayer:setPositionY(self.rootLayer:getPositionY() - GameDisplay.fix_y)
	self:addChild(self.rootLayer)
	self:initUI()
	network:rpc("activity_survey_get_surveylist", {
		activityid = SURVEY_ACTIVITYID
	}, function(arg_4_0)
		if not tolua.isnull(self) then
			self.dataList = {}

			for iter_4_0, iter_4_1 in ipairs(arg_4_0.list) do
				if activity_survey_data[iter_4_1.surveyid].type == self.surveytype then
					table.insert(self.dataList, activity_survey_data[iter_4_1.surveyid])

					self.dataList[#self.dataList].done = iter_4_1.done
					self.dataList[#self.dataList].valid = iter_4_1.valid
				end
			end

			print(dump(self.dataList))
			self:updateUI()
		end
	end)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_0 = self.surveytype
		end
	end)
end

function PopActivitySurveyLayer:initUI()
	self:initExitTouchEvent()
	self:initImageByType()
	self:playJoinInEffect()
end

function PopActivitySurveyLayer:initExitTouchEvent()
	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_8_0:isBright() then
			return
		end

		arg_8_0:setBright(false)
		self:exit()
	end)

	self.btnReturn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_46")

	if self.btnReturn then
		self.btnReturn:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_9_0:isBright() then
				return
			end

			arg_9_0:setBright(false)
			self:exit()
		end)
	end

	self.bg = self.rootLayer:getChildByName("bg")

	self.bg:setTouchEnabled(true)
	self.bg:setPositionY(self.bg:getPositionY() + GameDisplay.fix_y)
end

function PopActivitySurveyLayer:initImageByType()
	self.bg:loadTexture("PopActivitySurveyLayer/bg_" .. self.surveytype .. ".png", var_0_5)

	if self.btnReturn then
		self.btnReturn:loadTextures("PopActivitySurveyLayer/btn_close_" .. self.surveytype .. ".png", nil, "PopActivitySurveyLayer/btn_close_" .. self.surveytype .. ".png", var_0_5)
	end

	self.listView = self.bg:getChildByName("listview")
	self.tempCell = self.bg:getChildByName("cell_1")

	self.tempCell:loadTexture("PopActivitySurveyLayer/cell_bg_" .. self.surveytype .. ".png", var_0_5)
	self.tempCell:getChildByName("mask"):loadTexture("PopActivitySurveyLayer/mask_" .. self.surveytype .. ".png", var_0_5)
end

function PopActivitySurveyLayer:updateUI()
	self.listView:removeAllItems()

	for iter_11_0, iter_11_1 in ipairs(self.dataList) do
		self.listView:pushBackCustomItem((self:createNewSprite(iter_11_0)))
	end

	self.tempCell:setVisible(false)
end

function PopActivitySurveyLayer:createNewSprite(arg_12_1)
	local var_12_0 = self.dataList[arg_12_1]
	local var_12_1 = self.tempCell:clone()
	local var_12_2 = var_12_1:getChildByName("mask")
	local var_12_3 = var_12_1:getChildByName("btn")

	var_12_1:setVisible(true)
	var_12_1:getChildByName("num"):setString(string.format("%02d", arg_12_1))
	var_12_1:getChildByName("desc"):setString(var_12_0.name)
	var_12_2:setTouchEnabled(true)
	var_12_2:loadTexture("PopActivitySurveyLayer/mask_" .. self.surveytype .. ".png", var_0_5)

	if var_12_0.done then
		var_12_2:setVisible(true)
		var_12_3:loadTextures("PopActivitySurveyLayer/btn_done_" .. self.surveytype .. ".png", nil, "PopActivitySurveyLayer/btn_done_" .. self.surveytype .. ".png", var_0_5)
	else
		var_12_2:setVisible(false)
		var_12_3:loadTextures("PopActivitySurveyLayer/btn_go_" .. self.surveytype .. ".png", nil, "PopActivitySurveyLayer/btn_go_" .. self.surveytype .. ".png", var_0_5)
	end

	local var_12_4 = mail_data[var_12_0.mail_id].dropid
	local var_12_5 = var_12_1:getChildByName("item_bg")

	var_12_5:setScale(0.4)
	var_12_5:loadTexture("public/box/new_item_bg5.png", var_0_5)

	local var_12_6 = var_12_5:getChildByName("item")

	var_12_6:setScale(1.35)
	var_12_6:setPosition(cc.p(90, 145))
	var_12_6:loadTexture("equipment/1000000.png")

	local var_12_7 = var_12_5:getChildByName("Label_50")

	var_12_7:setPosition(cc.p(90, 20))
	var_12_7:setScale(2.5)
	var_12_7:setColor(cc.c3b(0, 0, 0))
	var_12_7:setString("x" .. drop_data[var_12_4].diamond)
	var_12_3:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_12_0.valid then
			global_ShowBlockWords(var_12_0.name)

			return
		end

		if not arg_13_0:isBright() then
			return
		end

		arg_13_0:setBright(false)
		DeviceManager.openURL(var_12_0.hyperlink)
		network:rpc("activity_survey_finish", {
			activityid = SURVEY_ACTIVITYID,
			surveyid = var_12_0.id
		}, function(arg_14_0)
			return
		end)

		self.dataList[arg_12_1].done = true

		AnalyticManager.go_activity_survey({
			surveyid = var_12_0.id
		})
		self:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
			self:updateUI()
		end)))
	end)

	return var_12_1
end

function PopActivitySurveyLayer:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function PopActivitySurveyLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopActivitySurveyLayer:initBg(arg_19_1)
	local var_19_0 = ccui.Layout:create()

	var_19_0:setTouchEnabled(true)
	var_19_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_19_0:setAnchorPoint(cc.p(0, 0))
	var_19_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_19_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_19_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_19_0:setOpacity(0)
	self:addChild(var_19_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_20_0)
		self:addChild(arg_20_0, -2)
		arg_20_0:setPositionY(arg_20_0:getPositionY() - GameDisplay.fix_y)

		local var_20_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_20_0:setAnchorPoint(cc.p(0, 0))
		var_20_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_20_0, -1)
		self:init(arg_19_1)
		var_19_0:setOpacity(102)
		var_19_0:setTouchEnabled(false)
	end)
end
