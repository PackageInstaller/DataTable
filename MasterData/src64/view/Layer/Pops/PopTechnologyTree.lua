PopTechnologyTree = class("PopTechnologyTree", function()
	return PopBaseLayer:create()
end)

local activity_doubleholiday_manager = require("controller.activity_doubleholiday_manager")
local activity_manager = require("controller.activity_manager")
local item_manager = require("controller.item_manager")
local playermodel = require("model.playermodel")
local var_0_4 = 201912002
local var_0_5 = config._DEBUG and 0 or 1

function PopTechnologyTree.create(arg_2_0, arg_2_1)
	local var_2_0 = PopTechnologyTree.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopTechnologyTree:initBg(arg_3_1)
	local var_3_0 = ccui.Layout:create()

	var_3_0:setTouchEnabled(true)
	var_3_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_0:setAnchorPoint(cc.p(0, 0))
	var_3_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_3_0:setOpacity(0)
	var_3_0:setCascadeOpacityEnabled(false)
	self:addChild(var_3_0, -1)

	if arg_3_1 and arg_3_1.callback then
		self.callback = arg_3_1.callback
	end

	local var_3_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_3_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_1:setPositionX(var_3_0:getContentSize().width / 2)
	var_3_1:setPositionY(var_3_0:getContentSize().height / 2)
	var_3_0:addChild(var_3_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_4_0)
		self:addChild(arg_4_0, -2)
		arg_4_0:setPositionY(arg_4_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_3_1)
		var_3_0:setOpacity(200)
		var_3_0:setTouchEnabled(false)
	end)
end

function PopTechnologyTree:init(arg_5_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "DoubleHoliday_TechnologyTree.json" or "DoubleHoliday_TechnologyTree.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 2)

	self.selectTechnology = nil

	self:initUI()
	self:registerActivityEventListener()
	self:fullScreen()
	activity_doubleholiday_manager:getTechtreeInfoFormServer()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopTechnologyTree")

			if self.callback then
				self.callback()
			end
		end
	end)
end

function PopTechnologyTree.registerActivityEventListener(arg_7_0)
	activity_manager:registerEventListener("PopTechnologyTree", activity_manager.activityEventId.TECHNOLOGY_TREE_DATA_UPDATE, function(arg_8_0)
		arg_7_0:updatePanelTree()
		arg_7_0:updateSkillInfo()
		arg_7_0:initTitle()
	end)
	activity_manager:registerEventListener("PopTechnologyTree", activity_manager.activityEventId.TECHNOLOGY_LEVEL_UP_SECCESS, function(arg_9_0)
		arg_7_0:updatePanelTree()
		arg_7_0:updateSkillInfo()
		arg_7_0:initTitle()
	end)
end

function PopTechnologyTree:initUI()
	self.background = self.rootLayer:getChildByName("background")

	LayerManager:createFullScreenMask(self.rootLayer, 0, function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_11_0:isBright() then
			return
		end

		arg_11_0:setBright(false)
		self:exit()
	end)
	self:initTitle()
	self:initPanelTree()
	self:updateSkillInfo()
	self:initButtons()
	self:playJoinEffect()
end

function PopTechnologyTree:playJoinEffect()
	self.rootLayer:setCascadeOpacityEnabled(true)
	self.rootLayer:setScaleY(0.1)
	self.rootLayer:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1)))
end

function PopTechnologyTree:initTitle()
	local var_13_0 = self.background:getChildByName("panel_title")

	var_13_0:getChildByName("lab_title"):setString(L_ACTIVITY_DOULE_HOLIDAY.TECHNOLOGY_TREE)
	var_13_0:getChildByName("have_num"):setString(global_trans_number((item_manager:getItemNumber(var_0_4))))
end

function PopTechnologyTree:initPanelTree()
	self.treeNodes = {}

	local var_14_0 = self.background:getChildByName("panel_tree")

	for iter_14_0, iter_14_1 in pairs((activity_doubleholiday_manager:getAllTechnologyId())) do
		local var_14_1 = var_14_0:getChildByName("btn_" .. iter_14_1)

		var_14_1:getChildByName("skill_bg"):setVisible(false)
		var_14_1:setCascadeColorEnabled(true)
		var_14_1:setColor(cc.c3b(89, 89, 89))
		var_14_1:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_15_0:getTag() == self.selectTechnology then
				return
			end

			self:updateSelectTechnology(arg_15_0:getTag())
			self:updateSkillInfo()
		end)

		self.treeNodes[iter_14_1] = var_14_1
	end
end

function PopTechnologyTree:updatePanelTree()
	for iter_16_0, iter_16_1 in pairs((activity_doubleholiday_manager:getAllTechnologyId())) do
		self:updateTechnologyNode(iter_16_1)
	end
end

function PopTechnologyTree:updateTechnologyNode(arg_17_1)
	local var_17_0 = self.treeNodes[arg_17_1]
	local var_17_1 = activity_doubleholiday_manager:getTecLevel(arg_17_1)
	local var_17_2 = self.treeNodes[arg_17_1]:getChildByName("skill_bg")

	if var_17_1 == 0 then
		var_17_0:setColor(cc.c3b(89, 89, 89))
		var_17_2:setVisible(false)
	else
		var_17_0:setColor(cc.c3b(255, 255, 255))
		var_17_2:setVisible(true)
		var_17_2:getChildByName("skill_lv"):setString(var_17_1 .. "/" .. activity_doubleholiday_manager:queryTechnologyData(arg_17_1, "level"))
	end

	local var_17_3 = var_17_0:getChildByName("can_lv_up_img")

	if var_17_3 then
		var_17_3:removeFromParent()
	end

	if activity_doubleholiday_manager:canTecLevelUp(arg_17_1) then
		local var_17_4 = ccui.ImageView:create("PopTechnologyTree/can_Lvup_img.png", var_0_5)

		var_17_4:setPosition(cc.p(var_17_0:getContentSize().width / 2, var_17_0:getContentSize().height / 2))
		var_17_4:setName("can_lv_up_img")
		var_17_0:setColor(cc.c3b(255, 255, 255))
		var_17_0:addChild(var_17_4)
	end
end

function PopTechnologyTree:updateSkillInfo()
	local var_18_0 = self.background:getChildByName("panel_info")
	local var_18_1 = var_18_0:getChildByName("lab_name")
	local var_18_2 = var_18_0:getChildByName("lab_info")

	if self.selectTechnology == nil then
		var_18_1:setString(L_ACTIVITY_DOULE_HOLIDAY.TECHNOLOGY_TREE)
		var_18_2:setString(L_ACTIVITY_DOULE_HOLIDAY.CHECK_FOR_GET)
	else
		var_18_1:setString((activity_doubleholiday_manager:queryTechnologyData(self.selectTechnology, "name")))
		var_18_2:setString((activity_doubleholiday_manager:queryTechnologyData(self.selectTechnology, "desc")))
	end
end

function PopTechnologyTree:updateSelectTechnology(arg_19_1)
	local var_19_0 = self.background:getChildByName("panel_tree")
	local var_19_1 = var_19_0:getChildByName("select_img")

	if not arg_19_1 and var_19_1 then
		var_19_1:removeFromParent()
	elseif arg_19_1 and not var_19_1 then
		var_19_1 = ccui.ImageView:create("PopTechnologyTree/select_img.png", var_0_5)

		var_19_1:setPosition(cc.p(self.treeNodes[arg_19_1]:getPositionX(), self.treeNodes[arg_19_1]:getPositionY()))
		var_19_1:setName("select_img")
		var_19_0:addChild(var_19_1)
	elseif arg_19_1 and var_19_1 then
		var_19_1:setPosition(cc.p(self.treeNodes[arg_19_1]:getPositionX(), self.treeNodes[arg_19_1]:getPositionY()))
	end

	self.background:getChildByName("button_sure"):setVisible(arg_19_1 ~= nil)

	if arg_19_1 then
		self.labCostNum:setString(activity_doubleholiday_manager:queryTechnologyData(arg_19_1, "cost") or 0)
	end

	self.selectTechnology = arg_19_1
end

function PopTechnologyTree:initButtons()
	local var_20_0 = self.background:getChildByName("button_sure")

	var_20_0:setVisible(false)
	var_20_0:getChildByName("btn_lv_up"):addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_doubleholiday_manager:levelUpTechnologyFromSever(self.selectTechnology)
	end)
	self.background:getChildByName("panel_tree"):getChildByName("btn_go_back"):addTouchEventListener(function(arg_22_0, arg_22_1)
		local var_22_0

		if arg_22_1 ~= ccui.TouchEventType.ended then
			do return end

			var_22_0 = {
				costtype = "diamond"
			}
		end

		function var_22_0.surecallback()
			activity_doubleholiday_manager:resetTreeFromSever()
		end

		var_22_0.labels = {
			button = L_BUTTON_TEXT.Sure,
			title = L_ACTIVITY_DOULE_HOLIDAY.HUI_SHUO,
			des = string.format(L_ACTIVITY_DOULE_HOLIDAY.HUI_SHUO_DESC, activity_doubleholiday_manager:getResetTecCost())
		}
		var_22_0.cost = activity_doubleholiday_manager:getResetTecCost()
		var_22_0.own = playermodel.diamond

		LayerManager:pushInLayer("PopDoLayer", var_22_0)
	end)

	self.labCostNum = var_20_0:getChildByName("img_cost"):getChildByName("lab_cost_num")
end

function PopTechnologyTree:exit()
	self.rootLayer:setCascadeOpacityEnabled(true)
	self.rootLayer:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0.1), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopTechnologyTree:fullScreen()
	self.background:setPositionY(GameDisplay.height * 0.53)
end
