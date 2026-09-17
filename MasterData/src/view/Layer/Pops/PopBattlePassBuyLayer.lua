PopBattlePassBuyLayer = class("PopBattlePassBuyLayer", function()
	return PopBaseLayer:create()
end)

function PopBattlePassBuyLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopBattlePassBuyLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local var_0_4 = 200
local var_0_5 = 3
local var_0_6 = config._DEBUG and 0 or 1

function PopBattlePassBuyLayer:init(arg_3_1)
	print("open poplayer : PopBattlePassBuyLayer")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopBpFastUpgradeLayer.json" or "PopBpFastUpgradeLayer.ExportJson")

	self.rootLayer:setContentSize(GameDisplay:getScreenSize())
	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootLayer)

	arg_3_1 = arg_3_1 or {}
	self.showType = arg_3_1.showType
	self.activityId = arg_3_1.activityId
	self.imagePath = arg_3_1.imagePath

	self:initUI()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopBattlePassBuyLayer")
		end
	end)
end

function PopBattlePassBuyLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("PopBattlePassBuyLayer", activity_manager.activityEventId.BATTLE_PASS_VIP_UPDATE, function(arg_6_0)
		arg_5_0:updateGotoBtn()
	end)
end

function PopBattlePassBuyLayer:initUI()
	ccui.Helper:seekWidgetByName(self.rootLayer, "left"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "right"):setVisible(false)

	local var_7_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "title")

	var_7_0:setVisible(false)

	local var_7_1 = cc.Label:createWithTTF(L_ACTIVITY_MARRY_LEVEL_2, FONT_TITLE, 22)

	var_7_1:setPosition(var_7_0:getPositionX() + 5, var_7_0:getPositionY())
	var_7_1:setColor(cc.c3b(73, 180, 255))
	var_7_0:getParent():addChild(var_7_1)

	self.titleLv = cc.Label:createWithTTF("", FONT_TITLE, 22)

	self.titleLv:setColor(cc.c3b(181, 92, 75))
	self.titleLv:setAnchorPoint(cc.p(1, 0.5))
	self.titleLv:setPosition(var_7_1:getPositionX() - var_7_1:getContentSize().width / 2, var_7_1:getPositionY())
	var_7_0:getParent():addChild(self.titleLv)

	local var_7_2 = ccui.Helper:seekWidgetByName(self.rootLayer, "lbl")

	var_7_2:setPositionX(var_7_2:getPositionX() - 10)

	self.finishLv = cc.Label:createWithTTF("", FONT_TITLE, 20)

	self.finishLv:setColor(cc.c3b(253, 253, 83))
	self.finishLv:setAnchorPoint(cc.p(0, 0.5))
	self.finishLv:setPosition(var_7_2:getPositionX() + var_7_2:getContentSize().width / 2, var_7_2:getPositionY())
	var_7_2:getParent():addChild(self.finishLv)
	self:initExitTouchEvent()
	self:updateGotoBtn()
	self:initSliber()
	self:initBtns()
end

function PopBattlePassBuyLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_9_0, arg_9_1)
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

function PopBattlePassBuyLayer:updateGotoBtn()
	self.panelBg = self.rootLayer:getChildByName("panel_bg")

	self.panelBg:setTouchEnabled(true)

	self.btngoto = self.panelBg:getChildByName("btn_level_up")

	self.btngoto:loadTextures(self.imagePath .. "/btn_level_up_vip.png", nil, self.imagePath .. "/btn_level_up_vip.png", var_0_6)
	self.btngoto:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
		LayerManager:pushInLayer("PopGetBianhuaBpVIPLayer", {
			activityId = self.activityId,
			imagePath = self.imagePath
		})
		LayerManager:removePopLayer(self.__queueindex)
	end)
	self.btngoto:setVisible(not activity_manager:isBattlePassSVIP(self.activityId))
end

function PopBattlePassBuyLayer:initSliber()
	self.slider = self.panelBg:getChildByName("slider")

	self.slider:setPercent(0)

	self.upLevel = 1
	self.maxupLevel = activity_manager:getBattlePassMaxLevel(self.activityId) - activity_manager:getCurBattlePassLevel(self.activityId)

	if self.showType == "inherit" then
		self.maxupLevel = math.min(self.maxupLevel, item_manager:getItemNumber((activity_manager:getBpLevelInheritItem(self.activityId))))
	end

	self.slider:loadSlidBallTextures("public/button/blue_slider_node.png", "public/button/blue_slider_node.png", "public/button/blue_slider_node.png", var_0_6)
	self.slider:addEventListener(function(arg_13_0, arg_13_1)
		local var_13_0 = (function()
			for iter_14_0 = self.maxupLevel, 1, -1 do
				if math.floor(arg_13_0:getPercent() * (self.maxupLevel - 1)) >= 100 * (iter_14_0 - 1) then
					return iter_14_0
				elseif iter_14_0 == 1 then
					return 1
				end
			end
		end)()

		if self.upLevel == var_13_0 then
			return
		end

		self.upLevel = var_13_0

		self:updateGiftView()
	end)
	self:updateGiftView()
end

function PopBattlePassBuyLayer:initBtns()
	self.panelBg:getChildByName("btn_buy"):addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not activity_manager:canLevelUp(self.activityId, self.upLevel) then
			global_ShowBlockWords(L_BUY_BATTLEPASS_LEVEL[3])

			return
		end

		if not self.showType and playermodel.diamond < activity_manager:getLevelUpCost(self.activityId, self.upLevel) then
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 1
			})

			return
		end

		if self.upLevel == 0 then
			global_ShowBlockWords(L_LEVEL_UP_ZERO)

			return
		end

		activity_manager:buyActivityLevel(self.activityId, self.upLevel, self.showType == "inherit")
		self:exit()
	end)
	self.panelBg:getChildByName("btn_add"):addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		print(self.upLevel, self.maxupLevel, activity_manager:canLevelUp(self.activityId, self.upLevel + 1))

		if self.upLevel >= self.maxupLevel then
			return
		end

		if not activity_manager:canLevelUp(self.activityId, self.upLevel + 1) then
			return
		end

		self.upLevel = self.upLevel + 1

		self.slider:setPercent((self.upLevel - 1) / (self.maxupLevel - 1) * 100)
		self:updateGiftView()
	end)
	self.panelBg:getChildByName("btn_jian"):addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.upLevel <= 1 then
			return
		end

		if not activity_manager:canLevelUp(self.activityId, self.upLevel - 1) then
			return
		end

		self.upLevel = self.upLevel - 1

		self.slider:setPercent((self.upLevel - 1) / (self.maxupLevel - 1) * 100)
		self:updateGiftView()
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "right"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "left"):setVisible(false)
end

function PopBattlePassBuyLayer:updateGiftView()
	self.dataList = activity_manager:getLevelupCanGetDrop(self.activityId, self.upLevel)

	local var_19_0 = activity_manager:getCurBattlePassLevel(self.activityId) - 1

	self.panelBg:getChildByName("lbl"):setString("等级" .. var_19_0 .. " --→")
	self.finishLv:setString("等级" .. var_19_0 + self.upLevel)
	self.titleLv:setString(self.upLevel)

	if not self.costNum then
		local var_19_2 = ccui.ImageView:create((self.showType == "inherit" or nil) and ("equipment/" .. item_data[activity_manager:getBpLevelInheritItem(self.activityId)].image_id .. ".png" or "equipment/1000000.png"))

		var_19_2:setPosition(270, 190)
		var_19_2:setScale(0.4)
		self.rootLayer:addChild(var_19_2)

		self.costNum = cc.Label:createWithTTF(activity_manager:getLevelUpCost(self.activityId, self.upLevel), FONT_NAME, 28)

		self.costNum:setPosition(340, 190)
		self.costNum:setColor(cc.c3b(252, 237, 242))
		self.rootLayer:addChild(self.costNum)
	else
		self.costNum:setString(activity_manager:getLevelUpCost(self.activityId, self.upLevel))
	end

	if self.tableView then
		self.tableView:removeFromParent()
	end

	self.tableView = cc.TableView:create(cc.size(600, 530))

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setAnchorPoint(cc.p(0, 0))
	self.tableView:setPosition(0, 310)
	self.tableView:setDelegate()
	self.rootLayer:addChild(self.tableView)
	self.tableView:registerScriptHandler(function(arg_21_0, arg_21_1)
		return 600, var_0_4
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0:dequeueCell()

		if not var_20_0 then
			var_20_0 = cc.TableViewCell:create()

			for iter_20_0 = 1, var_0_5 do
				if self.dataList[arg_20_1 + 1][iter_20_0] then
					local var_20_2 = self:createSprite(self.dataList[arg_20_1 + 1][iter_20_0])

					var_20_2:setName("sprite" .. iter_20_0)
					var_20_2:setAnchorPoint(cc.p(0.5, 0.5))
					var_20_2:setPosition(cc.p(110 + 210 * (iter_20_0 - 1), var_0_4 / 2))
					var_20_0:addChild(var_20_2)
				end
			end

			local var_20_3 = cc.Label:createWithTTF("---等级" .. var_19_0 + arg_20_1 + 1 .. "---", FONT_NAME, 24)

			var_20_3:setPosition(320, var_0_4 - 20)
			var_20_3:setName("lv_label")
			var_20_0:addChild(var_20_3)
		else
			for iter_20_1 = 1, var_0_5 do
				local var_20_4 = var_20_0:getChildByName("sprite" .. iter_20_1)

				if var_20_4 then
					var_20_4:removeFromParent()
				end

				local var_20_5

				if self.dataList[arg_20_1 + 1][iter_20_1] then
					if not var_20_5 then
						var_20_5 = self:createSprite(self.dataList[arg_20_1 + 1][iter_20_1])

						var_20_5:setName("sprite" .. iter_20_1)
						var_20_5:setAnchorPoint(cc.p(0.5, 0.5))
						var_20_5:setPosition(cc.p(110 + 210 * (iter_20_1 - 1), var_0_4 / 2))
						var_20_0:addChild(var_20_5)
					else
						var_20_5:setVisible(true)
						var_20_5:setPosition(cc.p(110 + 210 * (iter_20_1 - 1), var_0_4 / 2))
						self:updateSprite(var_20_5, self.dataList[arg_20_1 + 1][iter_20_1])
					end
				elseif var_20_5 then
					var_20_5:setVisible(false)
				end
			end

			var_20_0:getChildByName("lv_label"):setString("---等级" .. var_19_0 + arg_20_1 + 1 .. "---")
		end

		return var_20_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_22_0, arg_22_1)
		return #self.dataList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:reloadData()
end

function PopBattlePassBuyLayer.createSprite(arg_23_0, arg_23_1)
	local var_23_0 = ItemPurchaseSprite:createPurchaseItem(arg_23_1.dropid, arg_23_1.dropNum)

	var_23_0:setScale(0.8)
	var_23_0:getChildByName("wordBg"):loadTexture("public/box/word_pink_bg.png", var_0_6)
	var_23_0:getChildByName("numLabel"):setString("等级" .. arg_23_1.level)

	return var_23_0
end

function PopBattlePassBuyLayer.updateSprite(arg_24_0, arg_24_1, arg_24_2)
	arg_24_1:updatePurchaseItemByItemid(arg_24_2.dropid, arg_24_2.dropNum)
	arg_24_1:getChildByName("numLabel"):setString("等级" .. arg_24_2.level)
end

function PopBattlePassBuyLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopBattlePassBuyLayer:initBg(arg_27_1)
	local var_27_0 = ccui.Layout:create()

	var_27_0:setTouchEnabled(true)
	var_27_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_27_0:setAnchorPoint(cc.p(0, 0))
	var_27_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_27_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_27_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_27_0:setOpacity(0)
	self:addChild(var_27_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_28_0)
		self:addChild(arg_28_0, -2)
		arg_28_0:setPositionY(arg_28_0:getPositionY() - GameDisplay.fix_y)

		local var_28_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_28_0:setAnchorPoint(cc.p(0, 0))
		var_28_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_28_0, -1)
		self:init(arg_27_1)
		var_27_0:setOpacity(102)
		var_27_0:setTouchEnabled(false)
	end)
end
