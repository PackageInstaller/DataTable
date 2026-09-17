PopCommunityChartReportLayer = class("PopCommunityChartReportLayer", function()
	return PopBaseLayer:create()
end)

require("view.Layer.PopLayer")

local item_data = require("data.item_data")
local community_system_manager = require("controller.community_system_manager")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local family_medal_data = require("data.family_medal_data")
local account_manager = require("controller.account_manager")
local activity_manager = require("controller.activity_manager")
local family_tag_data = require("data.family_tag_data")
local var_0_11 = {
	COMMUNITY_POPCOMMUNITYCHARTREPORT.tips1,
	COMMUNITY_POPCOMMUNITYCHARTREPORT.tips2,
	COMMUNITY_POPCOMMUNITYCHARTREPORT.tips3,
	COMMUNITY_POPCOMMUNITYCHARTREPORT.tips4,
	COMMUNITY_POPCOMMUNITYCHARTREPORT.tips5
}
local var_0_12 = {
	COMMUNITY_POPCOMMUNITYCHARTREPORT.tips6,
	COMMUNITY_POPCOMMUNITYCHARTREPORT.tips7,
	COMMUNITY_COMMUNITYMEMBERLAYER.tips17,
	COMMUNITY_POPCOMMUNITYCHARTREPORT.tips8
}
local var_0_13 = 5
local var_0_14 = "chat_system_layer/jubao_ms.png"

function PopCommunityChartReportLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopCommunityChartReportLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopCommunityChartReportLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopCommunityChartReportLayer.json" or "PopCommunityChartReportLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_1")
	self.btn_1 = ccui.Helper:seekWidgetByName(self.rootpanel, "btn_1")
	self.btn_2 = ccui.Helper:seekWidgetByName(self.rootpanel, "btn_2")
	self.btn_3 = ccui.Helper:seekWidgetByName(self.rootpanel, "btn_3")
	self.btn_4 = ccui.Helper:seekWidgetByName(self.rootpanel, "btn_4")
	self.btn_5 = ccui.Helper:seekWidgetByName(self.rootpanel, "btn_5")
	self.inputbg = ccui.Helper:seekWidgetByName(self.rootpanel, "Image_62")
	self.title1 = ccui.Helper:seekWidgetByName(self.rootpanel, "Label_46")
	self.title2 = ccui.Helper:seekWidgetByName(self.rootpanel, "Label_46_0")
	self.btn_sure = ccui.Helper:seekWidgetByName(self.rootpanel, "Button_30_0")
	self.btns = {
		self.btn_1,
		self.btn_2,
		self.btn_3,
		self.btn_4,
		self.btn_5
	}

	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)
	self:initUI()

	if arg_3_1 then
		self.data = arg_3_1.playerinfo or {}
	end

	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			-- block empty
		end
	end)
end

function PopCommunityChartReportLayer:initUI()
	self:initBtnText()
	self:initCreateNameInPutLayer()

	self.numselect = 0

	for iter_7_0, iter_7_1 in ipairs(self.btns) do
		iter_7_1.id = iter_7_0
		iter_7_1.selet = 0

		iter_7_1:addTouchEventListener(function(arg_8_0, arg_8_1)
			if arg_8_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.numselect >= var_0_13 then
				if arg_8_0.selet == 1 then
					arg_8_0.selet = 0
					self.numselect = self.numselect - 1
				else
					global_ShowBlockWords(string.format(COMMUNITY_POPCOMMUNITYCHARTREPORT.tips9, var_0_13))
				end
			elseif arg_8_0.selet == 1 then
				arg_8_0.selet = 0
				self.numselect = self.numselect - 1
			else
				arg_8_0.selet = 1
				self.numselect = self.numselect + 1
			end

			if arg_8_0.selet == 1 then
				arg_8_0:getChildByName("Image_28"):setVisible(true)
			else
				arg_8_0:getChildByName("Image_28"):setVisible(false)
			end
		end)
	end

	self.btn_sure:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_9_0(arg_10_0, arg_10_1)
			if arg_10_0 == 1 then
				global_ShowBlockWords(COMMUNITY_POPCOMMUNITYCHARTREPORT.tips10)
				self:exit()
			else
				global_ShowBlockWords(COMMUNITY_POPCOMMUNITYCHARTREPORT.tips11)
			end
		end

		if self:checkIsRight(self.editBoxName:getText()) then
			local var_9_1 = self:dealWithTheData()

			var_9_1.sign = self:makesign(var_9_1, "VlR1EES17kI4771kagAKV5Lnol8WdPvK")

			local var_9_3 = DeviceManager.createHTTPRequest(function(arg_11_0)
				local var_11_0 = arg_11_0.request

				if arg_11_0.name ~= "completed" then
					return
				end

				local var_11_1 = var_11_0:getResponseString()

				if var_11_0:getResponseStatusCode() ~= 200 then
					if var_9_0 then
						var_9_0(0, data)
					end

					return
				end

				local var_11_2 = json.decode((var_11_0:getResponseString()))

				if var_11_2.code then
					if var_11_2.code == 0 then
						if var_9_0 then
							var_9_0(1)
						end
					elseif var_9_0 then
						var_9_0(0)
					end

					return
				end
			end, (not config._JUBAO_DEBUG or nil) and "https://horcrux.aojiaostudio.com/major_vote", "POST")

			var_9_3:setPOSTData(json.encode(var_9_1))
			var_9_3:start()
		end
	end)
end

function PopCommunityChartReportLayer.makesign(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		table.insert(var_12_0, iter_12_0)
	end

	table.sort(var_12_0)

	local var_12_1 = ""

	for iter_12_2 = 1, #var_12_0 do
		var_12_1 = var_12_1 .. var_12_0[iter_12_2] .. "=" .. arg_12_1[var_12_0[iter_12_2]]
	end

	return cc.Crypto:MD5(var_12_1 .. arg_12_2, false, false)
end

function PopCommunityChartReportLayer:initBtnText(arg_13_1)
	self.title1:setString(var_0_12[1])
	self.title2:setString(var_0_12[2])
	self.btn_sure:getChildByName("Label_4"):setString(var_0_12[3])

	for iter_13_0, iter_13_1 in ipairs(self.btns) do
		iter_13_1:getChildByName("Image_28"):setVisible(false)
		iter_13_1:getChildByName("Label_27"):setString(var_0_11[iter_13_0])
	end
end

function PopCommunityChartReportLayer:dealWithTheData()
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in ipairs(self.btns) do
		var_14_0 = var_14_0 + iter_14_1.selet * 2^(iter_14_0 - 1)
	end

	local var_14_1 = account_manager:getServerID() and "s" .. account_manager:getServerID() or nil

	return {
		command = "chat_report",
		serverid = var_14_1,
		playerid = playermodel.playerid,
		nickname = playermodel.nickname,
		targetplayerid = self.data.targetplayerid,
		targetnickname = self.data.targetnickname,
		reporttype = var_14_0,
		reportdesc = self.editBoxName:getText(),
		reportcontent = self.data.chartcontace1
	}
end

function PopCommunityChartReportLayer:initCreateNameInPutLayer()
	self.editBoxName = cc.EditBox:create(cc.size(608, 64), (config._DEBUG or nil) and (cc.Scale9Sprite:create(var_0_14) or cc.Scale9Sprite:createWithSpriteFrameName(var_0_14)))

	self.editBoxName:setPosition(cc.p(self.inputbg:getContentSize().width / 2, self.inputbg:getContentSize().height / 2 - 5))
	self.editBoxName:setPlaceHolder(var_0_12[4])
	self.editBoxName:setPlaceholderFontColor(cc.c3b(255, 255, 255))
	self.editBoxName:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
	self.editBoxName:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	self.editBoxName:setOpacity(0)
	self.editBoxName:setFont(FONT_NAME, 24)
	self.editBoxName:setFontColor(cc.c3b(102, 153, 249))
	self.editBoxName:setMaxLength(600)
	self.inputbg:addChild(self.editBoxName)
	self.editBoxName:registerScriptEditBoxHandler(function(arg_16_0, arg_16_1)
		if arg_16_0 == "began" then
			arg_16_1:setText("")
		elseif arg_16_0 == "ended" then
			if not global_check_sensitive(arg_16_1:getText()) then
				global_ShowBlockWords(L_WORD_SENSITIVE)
				arg_16_1:setText("")
			end
		elseif arg_16_0 == "return" then
			-- block empty
		elseif arg_16_0 == "changed" then
			-- block empty
		end
	end)
end

function PopCommunityChartReportLayer.checkIsRight(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return true
	end

	if utfstrlen(arg_17_1) > 30 then
		global_ShowBlockWords(COMMUNITY_COMMUNITYSETTINGLAYER.tips7)

		return false
	else
		return true
	end
end

function PopCommunityChartReportLayer:initBg(arg_18_1)
	local var_18_0 = ccui.Layout:create()

	var_18_0:setTouchEnabled(true)
	var_18_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_18_0:setAnchorPoint(cc.p(0, 0))
	var_18_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_18_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_18_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_18_0:setOpacity(0)
	var_18_0:setCascadeOpacityEnabled(false)
	self:addChild(var_18_0, -1)

	local var_18_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_18_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_18_1:setPositionX(var_18_0:getContentSize().width / 2)
	var_18_1:setPositionY(var_18_0:getContentSize().height / 2)
	var_18_0:addChild(var_18_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_19_0)
		self:addChild(arg_19_0, -2)
		arg_19_0:setPositionY(arg_19_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_18_1)
		var_18_0:setOpacity(102)
		var_18_0:setTouchEnabled(false)
	end)
end

function PopCommunityChartReportLayer:exit()
	self.hideActions.shrinkBoth(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end
