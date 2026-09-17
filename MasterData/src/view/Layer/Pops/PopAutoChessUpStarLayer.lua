PopAutoChessUpStarLayer = class("PopAutoChessUpStarLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")

local L2Actor = require("view.Sprite.L2Actor")
local var_0_1 = config._DEBUG and 0 or 1
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local favorfile_data = require("data.favorfile_data")
local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local servant_data = require("data.servant_data")
local core_manager = require("controller.core_manager")
local major_factor_data = require("data.major_factor_data")

local function var_0_10(arg_2_0)
	local var_2_0 = global_get_all_model_attrs(servant_data[arg_2_0].modelid)
	local var_2_1 = var_2_0.main

	if var_2_0.sub and next(var_2_0.sub) then
		for iter_2_0, iter_2_1 in ipairs(var_2_0.sub) do
			var_2_1 = var_2_1 .. "_" .. iter_2_1
		end
	end

	return var_2_1
end

function PopAutoChessUpStarLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = PopAutoChessUpStarLayer.new()

	var_3_0:initBg(arg_3_1)

	return var_3_0
end

function PopAutoChessUpStarLayer:init(arg_4_1)
	print("open poplayer : PopAutoChessUpStarLayer")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopAutoChessUpStarLayer.json" or "PopAutoChessUpStarLayer.ExportJson")

	self.rootLayer:setContentSize(GameDisplay:getScreenSize())
	self:addChild(self.rootLayer)

	arg_4_1 = arg_4_1 or {}
	self.activityId = arg_4_1.activityId or 323
	self.servantid = arg_4_1.servantid
	self.star = arg_4_1.star
	self.exitCallBack = arg_4_1.exitCallBack

	self:initUI()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			if self.exitCallBack then
				self.exitCallBack()
			end

			activity_manager:releaseEventListenerByName("PopAutoChessUpStarLayer")
		end
	end)
end

function PopAutoChessUpStarLayer.registerActivityEventListener(arg_6_0)
	activity_manager:registerEventListener("PopAutoChessUpStarLayer", activity_manager.activityEventId.AUTOCHESS_LIST_UPDATE, function(arg_7_0)
		LayerManager:removePopLayer(arg_6_0.__queueindex)
	end)
end

function PopAutoChessUpStarLayer:initUI()
	self.bg = self.rootLayer:getChildByName("bg")

	self:initExitTouchEvent()
	self:updateRoleSprite(self.bg:getChildByName("cur_role"), self.servantid, self.star)
	self.bg:getChildByName("name"):setString(major_factor_data[servant_data[self.servantid].major].easy_name)
	self:updateUpLable()
	self:updateUpNeedPanel()
	self:updateBtnSure()
end

function PopAutoChessUpStarLayer.updateRoleSprite(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_1 then
		return
	end

	local var_9_0 = arg_9_1:getChildByName("role")
	local var_9_1 = arg_9_1:getChildByName("icon")
	local var_9_2 = arg_9_1:getChildByName("breakout")
	local var_9_3 = arg_9_1:getChildByName("contract")

	if arg_9_2 then
		var_9_0:setLocalZOrder(-1)
		var_9_0:setScale(0.45)
		var_9_0:loadTexture("roleimage/role/shop_image/" .. model_data[servant_data[arg_9_2].modelid].role_image .. ".png")
		var_9_1:loadTexture(CAREER_ICON[servant_data[arg_9_2].career .. "_" .. var_0_10(arg_9_2)], var_0_1)
		var_9_2:loadTexture("public/rolebg/breakout_" .. core_manager:getServantCoreRank(arg_9_2) .. ".png", var_0_1)

		if playermodel.soulContract[arg_9_2] > 0 then
			var_9_3:loadTexture("public/rolebg/horcrux_+" .. playermodel.soulContract[arg_9_2] .. ".png", var_0_1)
		else
			var_9_3:setVisible(false)
		end
	else
		var_9_1:setVisible(false)
		var_9_2:setVisible(false)
		var_9_3:setVisible(false)
	end

	arg_9_1:getChildByName("lv"):setString(activity_manager:getAutoChessLvByStar(arg_9_3))

	for iter_9_0 = 1, 6 do
		arg_9_1:getChildByName("star_" .. iter_9_0):setVisible(iter_9_0 <= arg_9_3)
	end
end

function PopAutoChessUpStarLayer:updateUpLable()
	self.lblBg = self.bg:getChildByName("lblbg")

	for iter_10_0 = 1, 6 do
		self.lblBg:getChildByName("cur_" .. iter_10_0):setVisible(iter_10_0 <= self.star)
	end

	for iter_10_1 = 1, 6 do
		self.lblBg:getChildByName("after_" .. iter_10_1):setVisible(iter_10_1 <= self.star + 1)
	end

	local var_10_0 = self.lblBg:getChildByName("lbl_1")
	local var_10_1 = self.lblBg:getChildByName("lbl_2")
	local var_10_2 = self.lblBg:getChildByName("lbl_3")
	local var_10_3 = self.lblBg:getChildByName("lbl_4")

	self.lbl5 = self.lblBg:getChildByName("lbl_5")

	var_10_1:setString(L_GIRL_INFO_TABLE[2] .. activity_manager:getAutoChessLvByStar(self.star))
	var_10_3:setString("+" .. activity_manager:getAutoChessLvByStar(self.star + 1) - activity_manager:getAutoChessLvByStar(self.star))
	var_10_0:setString(L_AUTO_CHESS.content .. self.star)
	var_10_2:setString("+1")
	var_10_2:setPositionX(var_10_0:getPositionX() + var_10_0:getContentSize().width + 5)
	var_10_3:setPositionX(var_10_1:getPositionX() + var_10_1:getContentSize().width + 5)
end

function PopAutoChessUpStarLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_12_0:isBright() then
			return
		end

		arg_12_0:setBright(false)
		self:exit()
	end)

	local var_11_0 = ccui.Layout:create()

	var_11_0:setContentSize(cc.size(640, 100))
	var_11_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_11_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_11_0:setBackGroundColorOpacity(0)
	var_11_0:setTouchEnabled(true)
	var_11_0:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_13_0:isBright() then
			return
		end

		arg_13_0:setBright(false)
		self:exit()
	end)
	self:addChild(var_11_0, 0)
end

function PopAutoChessUpStarLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopAutoChessUpStarLayer:initBg(arg_16_1)
	local var_16_0 = ccui.Layout:create()

	var_16_0:setTouchEnabled(true)
	var_16_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_16_0:setAnchorPoint(cc.p(0, 0))
	var_16_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_16_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_16_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_16_0:setOpacity(0)
	self:addChild(var_16_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_17_0)
		self:addChild(arg_17_0, -2)
		arg_17_0:setPositionY(arg_17_0:getPositionY() - GameDisplay.fix_y)

		local var_17_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_17_0:setAnchorPoint(cc.p(0, 0))
		var_17_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_17_0, -1)
		self:init(arg_16_1)
		var_16_0:setOpacity(102)
		var_16_0:setTouchEnabled(false)
	end)
end

function PopAutoChessUpStarLayer:updateBtnSure()
	local var_18_0 = self.rootLayer:getChildByName("btn_upstar")

	if self.star >= 6 then
		self.lbl5:setColor(cc.c3b(254, 83, 26))
		self.lbl5:setString(L_AUTO_CHESS.maxstar)
		var_18_0:setVisible(false)
	elseif activity_manager:getMaxStarByContrant(self.activityId, (math.max(playermodel.soulContract[self.servantid], 0))) <= self.star then
		self.lbl5:setColor(cc.c3b(254, 83, 26))

		local var_18_1 = math.max(playermodel.soulContract[self.servantid], 0)

		self.lbl5:setString(string.format(L_AUTO_CHESS.maxUpStar, var_18_1, (activity_manager:getMaxStarByContrant(self.activityId, var_18_1))))
		var_18_0:loadTextures("PopAutoChessUpStarLayer/btn_upstar_off.png", nil, "PopAutoChessUpStarLayer/btn_upstar_off.png", var_0_1)
	elseif not self.tag then
		self.lbl5:setColor(cc.c3b(254, 83, 26))
		self.lbl5:setString(string.format(L_AUTO_CHESS.cantUpStar))
		var_18_0:loadTextures("PopAutoChessUpStarLayer/btn_upstar_off.png", nil, "PopAutoChessUpStarLayer/btn_upstar_off.png", var_0_1)
	else
		self.lbl5:setVisible(false)
		var_18_0:loadTextures("PopAutoChessUpStarLayer/btn_upstar_on.png", nil, "PopAutoChessUpStarLayer/btn_upstar_on.png", var_0_1)
	end

	var_18_0:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:activity_autochess_upstar(self.activityId, self.servantid, self.star)
	end)
end

function PopAutoChessUpStarLayer:updateUpNeedPanel()
	if self.star >= 6 then
		return
	end

	local var_20_0 = self.bg:getChildByName("cur_role_1")
	local var_20_1, var_20_2, var_20_3 = activity_manager:getAutoChessUpstarNeedList(self.activityId, self.servantid, self.star + 1)

	self.tag = var_20_2

	local var_20_4 = ccui.ListView:create()

	var_20_4:setContentSize(cc.size(460, 200))
	var_20_4:setItemsMargin(10)
	var_20_4:setDirection(cc.SCROLLVIEW_DIRECTION_BOTH)
	var_20_4:setAnchorPoint(0, 0)
	var_20_4:setPosition(cc.p(30, 20))
	self.bg:addChild(var_20_4, 6)

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		local var_20_5 = var_20_0:clone()

		self:updateRoleSprite(var_20_5, iter_20_1.id, iter_20_1.star)
		var_20_4:pushBackCustomItem(var_20_5)
	end

	if var_20_3 then
		for iter_20_2 = 1, var_20_3 do
			local var_20_6 = var_20_0:clone()

			self:updateRoleSprite(var_20_6, nil, self.star)
			var_20_4:pushBackCustomItem(var_20_6)
		end
	end
end
