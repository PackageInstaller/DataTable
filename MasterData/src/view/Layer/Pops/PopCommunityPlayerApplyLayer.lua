PopCommunityPlayerApplyLayer = class("PopCommunityPlayerApplyLayer", function()
	return PopBaseLayer:create()
end)

require("view.Layer.PopLayer")

local item_data = require("data.item_data")
local community_system_manager = require("controller.community_system_manager")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local family_medal_data = require("data.family_medal_data")
local family_other_data = require("data.family_other_data")
local activity_manager = require("controller.activity_manager")
local family_tag_data = require("data.family_tag_data")
local var_0_9 = 640
local var_0_10 = 160

function PopCommunityPlayerApplyLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopCommunityPlayerApplyLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopCommunityPlayerApplyLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopCommunityPlayerApplyLayer.json" or "PopCommunityPlayerApplyLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.items = ccui.Helper:seekWidgetByName(self.rootLayer, "items")
	self.tablelayer = ccui.Helper:seekWidgetByName(self.rootLayer, "tablelayer")
	self.titlename = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_64")
	self.noinfo = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_25_0")
	self.applynumbg = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_70")
	self.num = ccui.Helper:seekWidgetByName(self.applynumbg, "Label_71")

	self.num:setString("")
	self.noinfo:getChildByName("Label_26"):setString(COMMUNITY_POPCOMMUNITYPLAYERAPPLYLAYER.tips1)
	self.noinfo:setVisible(false)
	self.titlename:setString(COMMUNITY_POPCOMMUNITYPLAYERAPPLYLAYER.tips2)

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
	self:getlistData()
	global_window_open_action(self.rootpanel)
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			-- block empty
		end
	end)
end

function PopCommunityPlayerApplyLayer.dealWiththeData(arg_7_0, arg_7_1)
	return
end

function PopCommunityPlayerApplyLayer.getlistData(arg_8_0)
	community_system_manager:get_family_player_applications(function(arg_9_0)
		if arg_9_0.result == 1 then
			arg_8_0.data = arg_9_0.list
		end

		arg_8_0:initUI()
	end)
end

function PopCommunityPlayerApplyLayer.createTableView(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = cc.TableView:create(arg_10_1)

	;(nil):setName(arg_10_2)
	var_10_0:setDelegate()
	var_10_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_10_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)

	return var_10_0
end

function PopCommunityPlayerApplyLayer:initUI()
	self:updateNumberApply()

	if self.tablelayer:getChildByName("tableview") then
		self.tablelayer:getChildByName("tableview"):removeFromParent()

		self.tableview1 = nil
	end

	if not self.data or not next(self.data) then
		self.noinfo:setVisible(true)

		return
	end

	self.noinfo:setVisible(false)

	self.tableview1 = self:createTableView(cc.size(self.tablelayer:getContentSize().width, self.tablelayer:getContentSize().height), "tableview")

	self.tablelayer:addChild(self.tableview1, 1)
	self.tableview1:setPosition(cc.p(0, 0))

	self.roleTableViewhight = self.tablelayer:getContentSize().height

	self:initTableViewMember()
end

function PopCommunityPlayerApplyLayer:createNode()
	return (self.items:clone())
end

function PopCommunityPlayerApplyLayer:initTableViewMember()
	self.tableview1:registerScriptHandler(function(arg_15_0, arg_15_1)
		return var_0_9, var_0_10
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableview1:registerScriptHandler(function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0:dequeueCell()

		if not var_14_0 then
			var_14_0 = cc.TableViewCell:create()

			local var_14_1 = self:createNode()

			var_14_1:setName("node")
			var_14_1:setPosition(cc.p(3, 0))
			self:updateNode(var_14_1, self.data[arg_14_1 + 1])

			if arg_14_1 <= math.floor(self.roleTableViewhight / var_0_10) then
				var_14_1:setOpacity(0)
				var_14_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.1 * arg_14_1), cc.FadeIn:create(0.1)))
			else
				var_14_1:setOpacity(255)
			end

			var_14_0:addChild(var_14_1)
		else
			local var_14_2 = var_14_0:getChildByName("node")

			var_14_2:setOpacity(255)
			self:updateNode(var_14_2, self.data[arg_14_1 + 1])
		end

		return var_14_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableview1:registerScriptHandler(function(arg_16_0, arg_16_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableview1:reloadData()
end

function PopCommunityPlayerApplyLayer:updateNode(arg_17_1, arg_17_2)
	local var_17_0 = ccui.Helper:seekWidgetByName(ccui.Helper:seekWidgetByName(arg_17_1, "member_label"), "name")
	local var_17_1 = ccui.Helper:seekWidgetByName(ccui.Helper:seekWidgetByName(arg_17_1, "textlayer"), "Label_41")

	ccui.Helper:seekWidgetByName(arg_17_1, "name_lable"):setString(arg_17_2.family.familyname)
	ccui.Helper:seekWidgetByName(ccui.Helper:seekWidgetByName(arg_17_1, "lv_label"), "name"):setString(arg_17_2.family.level)
	var_17_0:setString(arg_17_2.family.member)

	if arg_17_2.family.max_member then
		var_17_0:setString("" .. arg_17_2.family.member .. "/" .. arg_17_2.family.max_member)
	end

	ccui.Helper:seekWidgetByName(ccui.Helper:seekWidgetByName(arg_17_1, "active_label"), "name"):setString(global_trans_number(arg_17_2.family.active))
	var_17_1:getVirtualRenderer():setMaxLineWidth(480)
	var_17_1:setString(arg_17_2.family.slogan)
	self:updateCommunityLable(arg_17_1, arg_17_2.family.tags)
	self:updateApplyStatus(arg_17_1, arg_17_2.status, arg_17_2.family.audit_type)
	self:updateImage(arg_17_1, arg_17_2.family.flag, arg_17_2.family)
end

function PopCommunityPlayerApplyLayer.updateCommunityLable(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = community_system_manager:deCodeTagsData(arg_18_2)

	for iter_18_0 = 1, 3 do
		if var_18_0 and var_18_0[iter_18_0] and arg_18_1:getChildByName("label_" .. iter_18_0) and family_tag_data[iter_18_0] then
			arg_18_1:getChildByName("label_" .. iter_18_0):setVisible(true)
			arg_18_1:getChildByName("label_" .. iter_18_0):getChildByName("name"):setString(family_tag_data[iter_18_0].des)
		else
			arg_18_1:getChildByName("label_" .. iter_18_0):setVisible(false)
		end
	end
end

function PopCommunityPlayerApplyLayer.updateApplyStatus(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if not arg_19_1 or not arg_19_2 then
		return
	end

	if arg_19_2 == 0 then
		arg_19_1:getChildByName("cancel"):setVisible(false)
		arg_19_1:getChildByName("free"):setVisible(false)
		arg_19_1:getChildByName("applying"):setVisible(true)
	elseif arg_19_2 == 1 then
		arg_19_1:getChildByName("cancel"):setVisible(true)
		arg_19_1:getChildByName("free"):setVisible(false)
		arg_19_1:getChildByName("applying"):setVisible(false)
	elseif arg_19_3 == 0 then
		arg_19_1:getChildByName("applying"):setVisible(false)
		arg_19_1:getChildByName("free"):setVisible(true)
		arg_19_1:getChildByName("cancel"):setVisible(false)
	else
		arg_19_1:getChildByName("applying"):setVisible(false)
		arg_19_1:getChildByName("free"):setVisible(false)
		arg_19_1:getChildByName("cancel"):setVisible(false)
	end
end

function PopCommunityPlayerApplyLayer:updateImage(arg_20_1, arg_20_2, arg_20_3)
	if not arg_20_1 or not arg_20_2 then
		return
	end

	self:initCommunityImage(arg_20_1:getChildByName("medal_btn"), arg_20_2)
	arg_20_1:getChildByName("Button_25"):setSwallowTouches(false)
	arg_20_1:getChildByName("Button_25"):addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_21_0

		if math.abs(arg_21_0:getTouchBeganPosition().y - arg_21_0:getTouchEndPosition().y) > 50 then
			do return end

			var_21_0 = {
				isApplyLayer = true
			}
		end

		function var_21_0.callback()
			self:getlistData()
		end

		var_21_0.data = arg_20_3

		LayerManager:pushInLayer("PopCommunityIntroduceLayer", var_21_0)
	end)
end

function PopCommunityPlayerApplyLayer.initCommunityImage(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_2 or not arg_23_1 then
		return
	end

	local var_23_0 = "equipment/family/communitymedal1.png"

	if family_medal_data[arg_23_2] then
		var_23_0 = "equipment/family/" .. family_medal_data[arg_23_2].image_id .. ".png"
	end

	arg_23_1:loadTextures(var_23_0, nil, var_23_0)
end

function PopCommunityPlayerApplyLayer:updateTableViewPanel()
	if not self.tableview1 or not self.data then
		return
	end

	local var_24_0, var_24_1 = GetTableViewShowCellIdx(tableview, {
		cellsize = cc.size(var_0_9, var_0_10),
		maxcount = #self.data
	})

	for iter_24_0 = var_24_0, var_24_1 do
		tableview:updateCellAtIndex(iter_24_0)
	end
end

function PopCommunityPlayerApplyLayer:updateNumberApply()
	if not self.data then
		-- block empty
	end

	self.num:setString(COMMUNITY_POPCOMMUNITYPLAYERAPPLYLAYER.tips3 .. #self.data .. "/" .. family_other_data.max_application.value)
end

function PopCommunityPlayerApplyLayer:initBg(arg_26_1)
	local var_26_0 = ccui.Layout:create()

	var_26_0:setTouchEnabled(true)
	var_26_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_26_0:setAnchorPoint(cc.p(0, 0))
	var_26_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_26_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_26_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_26_0:setOpacity(0)
	var_26_0:setCascadeOpacityEnabled(false)
	self:addChild(var_26_0, -1)

	local var_26_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_26_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_26_1:setPositionX(var_26_0:getContentSize().width / 2)
	var_26_1:setPositionY(var_26_0:getContentSize().height / 2)
	var_26_0:addChild(var_26_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_27_0)
		self:addChild(arg_27_0, -2)
		arg_27_0:setPositionY(arg_27_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_26_1)
		var_26_0:setOpacity(102)
		var_26_0:setTouchEnabled(false)
	end)
end

function PopCommunityPlayerApplyLayer:exit()
	self.hideActions.shrinkBoth(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end
