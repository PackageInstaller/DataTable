PopCommunityNoticesLayer = class("PopCommunityNoticesLayer", function()
	return PopBaseLayer:create()
end)

require("view.Layer.PopLayer")

local item_data = require("data.item_data")
local community_system_manager = require("controller.community_system_manager")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local var_0_6 = "community_system/joinCommunityLayer/two_change.png"

function PopCommunityNoticesLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopCommunityNoticesLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopCommunityNoticesLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopCommunityNoticesLayer.json" or "PopCommunityNoticesLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items")
	self.titlename = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_64")
	self.inputbg = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_27")
	self.surebtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_30")

	self.titlename:setString(COMMUNITY_POPCOMMUNITYNOTICESLAYER.tips1)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_1")

	self.rootpanel:setCascadeOpacityEnabled(false)
	self.rootpanel:setPositionY(590 + GameDisplay.fix_y)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)

	if arg_3_1 then
		self.callback = arg_3_1.callback or nil
	end

	if arg_3_1 then
		self.notices = arg_3_1.notice or nil
	end

	if arg_3_1 then
		self.familyid = arg_3_1.familyid or nil
	end

	if self.notices == "" then
		self.notices = COMMUNITY_POPCOMMUNITYNOTICESLAYER.tips1
	end

	self:initUI()
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			-- block empty
		end
	end)
end

function PopCommunityNoticesLayer:initUI()
	self.editBoxName = cc.EditBox:create(cc.size(500, 80), (config._DEBUG or nil) and (cc.Scale9Sprite:create(var_0_6) or cc.Scale9Sprite:createWithSpriteFrameName(var_0_6)))

	self.editBoxName:setPosition(cc.p(self.inputbg:getContentSize().width / 2, self.inputbg:getContentSize().height / 2))
	self.editBoxName:setPlaceHolder(self.notices)
	self.editBoxName:setText(self.notices)
	self.editBoxName:setPlaceholderFontColor(cc.c3b(255, 255, 255))
	self.editBoxName:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
	self.editBoxName:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	self.editBoxName:setOpacity(0)
	self.editBoxName:setFont(FONT_NAME, 24)
	self.editBoxName:setFontColor(cc.c3b(102, 153, 249))
	self.editBoxName:setMaxLength(480)
	self.inputbg:addChild(self.editBoxName)
	self.inputbg:setClippingEnabled(true)
	self.editBoxName:registerScriptEditBoxHandler(function(arg_8_0, arg_8_1)
		if arg_8_0 == "began" then
			arg_8_1:setText("")
		elseif arg_8_0 == "ended" then
			if not global_check_sensitive(arg_8_1:getText()) then
				global_ShowBlockWords(L_WORD_SENSITIVE)
				arg_8_1:setText("")
			end
		elseif arg_8_0 == "return" then
			-- block empty
		elseif arg_8_0 == "changed" then
			-- block empty
		end
	end)
	self.surebtn:getChildByName("Label_4"):setString(COMMUNITY_POPCOMMUNITYNOTICESLAYER.tips2)
	self.surebtn:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:checkIsRight(self.editBoxName:getText()) then
			community_system_manager:update_family_setting(self.familyid, {
				notice = self.editBoxName:getText()
			}, function(arg_10_0)
				if arg_10_0.result == 1 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYSETTINGLAYER.tips2)
					self:exit()
				elseif arg_10_0.result == 2 then
					global_ShowBlockWords(COMMUNITY_JOINCOMMUNITY.tips10)
				elseif arg_10_0.result == 3 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYSETTINGLAYER.nameig)
				elseif arg_10_0.result == 4 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYSETTINGLAYER.tips3)
				elseif arg_10_0.result == 5 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYSETTINGLAYER.tips4)
				elseif arg_10_0.result == 11 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYSETTINGLAYER.tips5)
				elseif arg_10_0.result == 12 then
					global_ShowBlockWords(COMMUNITY_COMMUNITYMEMBERLAYER.tips15)
				elseif arg_10_0.result == 13 then
					global_ShowBlockWords(COMMUNITY_POPCOMMUNITYDONATIONLAYER.tips11)
				elseif arg_10_0.result == 14 then
					global_ShowBlockWords(COMMUNITY_JOINCOMMUNITY.tips14)
				end
			end)
		end
	end)
end

function PopCommunityNoticesLayer.checkIsRight(arg_11_0, arg_11_1)
	if not arg_11_1 then
		global_ShowBlockWords(COMMUNITY_POPCOMMUNITYNOTICESLAYER.tips3)

		return false
	end

	if utfstrlen(arg_11_1) == 0 then
		global_ShowBlockWords(COMMUNITY_POPCOMMUNITYNOTICESLAYER.tips4)

		return false
	elseif utfstrlen(arg_11_1) > 30 then
		global_ShowBlockWords(COMMUNITY_COMMUNITYSETTINGLAYER.tips7)

		return false
	elseif not global_check_sensitive(arg_11_1) then
		global_ShowBlockWords(L_WORD_SENSITIVE)

		return false
	end

	return true
end

function PopCommunityNoticesLayer:initBg(arg_12_1)
	local var_12_0 = ccui.Layout:create()

	var_12_0:setTouchEnabled(true)
	var_12_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_12_0:setAnchorPoint(cc.p(0, 0))
	var_12_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_12_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_12_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_12_0:setOpacity(0)
	var_12_0:setCascadeOpacityEnabled(false)
	self:addChild(var_12_0, -1)

	local var_12_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_12_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_12_1:setPositionX(var_12_0:getContentSize().width / 2)
	var_12_1:setPositionY(var_12_0:getContentSize().height / 2)
	var_12_0:addChild(var_12_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_13_0)
		self:addChild(arg_13_0, -2)
		arg_13_0:setPositionY(arg_13_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_12_1)
		var_12_0:setOpacity(102)
		var_12_0:setTouchEnabled(false)
	end)
end

function PopCommunityNoticesLayer:exit(arg_14_1)
	self.hideActions.shrinkVertical(self, function()
		if self.callback then
			self.callback(self.editBoxName:getText())
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
