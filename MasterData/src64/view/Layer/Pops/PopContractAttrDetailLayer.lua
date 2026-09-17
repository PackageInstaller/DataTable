PopContractAttrDetailLayer = class("PopContractAttrDetailLayer", function()
	return PopBaseLayer:create()
end)

function PopContractAttrDetailLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopContractAttrDetailLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopContractAttrDetailLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopContractAttrDetailLayer.json" or "PopContractAttrDetailLayer.ExportJson")

	self.rootLayer:setContentSize((cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y)))
	self.rootLayer:setPositionY(self.rootLayer:getPositionY() - GameDisplay.fix_y)

	self.rootpanel = self.rootLayer

	self:addChild(self.rootLayer)

	self.initInfo = arg_3_1 or {}

	print(dump(self.initInfo))
	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function PopContractAttrDetailLayer:initUI()
	self:addTouchEventMask()
	self:initLabels()
	self:initBtn()
	self:playJoinEffect()
end

function PopContractAttrDetailLayer:addTouchEventMask()
	self.rootLayer:setTouchEnabled(true)

	self.bg = self.rootLayer:getChildByName("bg")

	self.bg:setPositionY(self.bg:getPositionY() + GameDisplay.fix_y)
	self.rootLayer:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_7_0:isBright() then
			return
		end

		arg_7_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
end

function PopContractAttrDetailLayer:playJoinEffect()
	self.rootLayer:setScaleY(0.1)
	self.rootLayer:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 1)))
end

function PopContractAttrDetailLayer:initLabels()
	for iter_10_0, iter_10_1 in ipairs(L_POPCONTRACTATTRDETAILLAYER) do
		self.bg:getChildByName("Label_" .. iter_10_0):setString(iter_10_1)
	end

	local souls_manager = require("controller.souls_manager")
	local var_10_1 = souls_manager:get_total_contract_attr()

	self.bg:getChildByName("Label_attr"):setString(var_10_1)
	self.bg:getChildByName("Label_up"):setString(100 * CONTRACT_ATTR_ADD * var_10_1 .. "%")
	self.bg:getChildByName("Label_lv"):setString(souls_manager:get_can_up_level() .. "级")
end

function PopContractAttrDetailLayer:initBtn()
	local var_11_0 = self.rootLayer:getChildByName("Button_29")

	var_11_0:setPositionY(var_11_0:getPositionY() + GameDisplay.fix_y)
	var_11_0:setVisible(not self.initInfo.unShowbtn)
	var_11_0:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("AfkLevelLayer")
	end)
end

function PopContractAttrDetailLayer:initBg(arg_13_1)
	local var_13_0 = ccui.Layout:create()

	var_13_0:setTouchEnabled(true)
	var_13_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_13_0:setAnchorPoint(cc.p(0, 0))
	var_13_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_13_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_13_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_13_0:setOpacity(0)
	var_13_0:setCascadeOpacityEnabled(false)
	self:addChild(var_13_0, -1)

	local var_13_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_13_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_13_1:setPositionX(var_13_0:getContentSize().width / 2)
	var_13_1:setPositionY(var_13_0:getContentSize().height / 2)
	var_13_0:addChild(var_13_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_14_0)
		self:addChild(arg_14_0, -2)
		arg_14_0:setPositionY(arg_14_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_13_1)
		var_13_0:setOpacity(102)
		var_13_0:setTouchEnabled(false)
	end)
end
