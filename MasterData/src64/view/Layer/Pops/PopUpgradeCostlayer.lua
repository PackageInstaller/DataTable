PopUpgradeCostlayer = class("PopUpgradeCostlayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local audio_manager = require("controller.audio_manager")
local item_data = require("data.item_data")
local item_manager = require("controller.item_manager")

function PopUpgradeCostlayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopUpgradeCostlayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopUpgradeCostlayer:init(arg_3_1)
	print("msg==", dump(arg_3_1))

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Jinjie.json" or "Jinjie.ExportJson")

	self:addChild(self.rootLayer)

	self.msg = arg_3_1

	self:initUI()
end

function PopUpgradeCostlayer:initUI()
	local var_4_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_back")

	var_4_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_4_0:setPosition(cc.p(320, 568))

	self.rootPanel = var_4_0

	self:initTouchEventListener()
	self:initTitle()
	self:initLabels()
	self:updateMaterials()
	self:initSureBtn()
	self:initCost()
	self:fullScreen(self.rootLayer)
	self:ActionofAccess()
end

function PopUpgradeCostlayer:initTouchEventListener()
	ccui.Helper:seekWidgetByName(self.rootLayer, "panel_upgrade"):addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_25"):addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
end

function PopUpgradeCostlayer:initTitle()
	local var_8_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")
	local var_8_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "title")

	if self.msg.imageTitle then
		local var_8_2 = ccui.ImageView:create(self.msg.imageTitle, var_0_0)

		var_8_2:setAnchorPoint(0, 0)
		var_8_2:setPosition(cc.p(var_8_0:getPositionX() - var_8_0:getContentSize().width / 2, var_8_0:getPositionY() + var_8_0:getContentSize().height / 2 - 5))
		ccui.Helper:seekWidgetByName(self.rootLayer, "panel_back"):addChild(var_8_2)
		var_8_1:setVisible(false)
	elseif self.msg.title then
		var_8_1:setString(self.msg.title)
	end

	local var_8_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "use_bg")
	local var_8_4 = var_8_3:getChildByName("icon")

	var_8_3:setVisible(false)
	var_8_4:setPositionX(var_8_4:getPositionX() - 8)
	var_8_4:loadTexture("public/currency/2000000.png", var_0_0)

	self.lblNum = var_8_3:getChildByName("lbl_num")

	self.lblNum:setString(item_manager:getItemNumber(ALMIGHTY_WEAPON))

	self.chooseNum = 0

	var_8_3:setTouchEnabled(true)
	var_8_3:getChildByName("btn_add"):addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopGoGainLayer", {
			item = ALMIGHTY_WEAPON
		})
	end)

	while not self.touchEventFlag and item_manager:getItemNumber(ALMIGHTY_WEAPON) - self.chooseNum > 0 do
		self:addAlmightyWeapon()
	end

	self:updateBtnFlag()
end

function PopUpgradeCostlayer:addAlmightyWeapon()
	for iter_10_0, iter_10_1 in ipairs(self.msg.materials) do
		if iter_10_1.ownnum < iter_10_1.neednum then
			iter_10_1.id = ALMIGHTY_WEAPON

			if item_manager:getItemNumber(ALMIGHTY_WEAPON) > self.chooseNum then
				iter_10_1.ownnum = iter_10_1.neednum
				self.chooseNum = self.chooseNum + 1

				break
			end
		end
	end

	table.sort(self.msg.materials, function(arg_11_0, arg_11_1)
		if arg_11_0.id == arg_11_1.id then
			return false
		end

		if arg_11_0.id == ALMIGHTY_WEAPON then
			return true
		end

		if arg_11_1.id == ALMIGHTY_WEAPON then
			return false
		end

		return false
	end)
	self:updateMaterials()
	self.lblNum:setString(item_manager:getItemNumber(ALMIGHTY_WEAPON) - self.chooseNum)
	self:updateBtnFlag()
end

function PopUpgradeCostlayer:updateBtnFlag()
	self.touchEventFlag = true

	for iter_12_0, iter_12_1 in pairs(self.msg.materials) do
		if iter_12_1.ownnum < iter_12_1.neednum or iter_12_1.neednum == 0 then
			self.touchEventFlag = false
		end
	end

	local var_12_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure")

	if self.touchEventFlag then
		var_12_0:loadTextures("public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", var_0_0)
	elseif self.msg.shopBuyCallback then
		var_12_0:loadTextures("public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", var_0_0)
	else
		var_12_0:loadTextures("public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", "public/button/public_button_gray_long.png", var_0_0)
	end
end

function PopUpgradeCostlayer:initLabels()
	local var_13_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_intro")
	local var_13_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "label_intro")

	var_13_1:setVisible(false)
	var_13_0:getChildByName("value_new"):setVisible(false)

	local var_13_2, var_13_3 = var_13_1:getPosition()

	if self.msg.labels then
		for iter_13_0, iter_13_1 in ipairs(self.msg.labels) do
			if iter_13_1.name ~= L_LAB_LEVEL then
				local var_13_4 = var_13_1:clone()
				local var_13_5 = var_13_0:getChildByName("value_new"):clone()

				var_13_5:setVisible(true)
				var_13_4:setVisible(true)
				var_13_4:setPosition(cc.p(var_13_2, var_13_3 - 30 * (iter_13_0 - 1)))
				var_13_0:addChild(var_13_4)
				var_13_4:setString(iter_13_1.name)
				var_13_5:setString(iter_13_1.newvalue)
				var_13_5:setPositionX(var_13_4:getPositionX() + var_13_4:getContentSize().width)
				var_13_5:setPositionY(var_13_4:getPositionY())
				var_13_0:addChild(var_13_5)
			end
		end
	end
end

function PopUpgradeCostlayer:updateMaterials()
	local var_14_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_cost")
	local var_14_1 = ccui.Helper:seekWidgetByName(var_14_0, "equip_4")

	var_14_1:setVisible(false)
	var_14_0:getChildByName("ListView_38"):removeAllChildren()

	local var_14_2, var_14_3 = var_14_1:getPosition()
	local var_14_4 = 110

	if self.msg.materials then
		for iter_14_0, iter_14_1 in ipairs(self.msg.materials) do
			local var_14_5 = iter_14_1.entityid and iter_14_1.entityid > 0 and ItemSprite:createBigWithEntityId(iter_14_1.entityid) or ItemSprite:createNewWithItemId(iter_14_1.id, iter_14_1.ownnum, nil, nil, nil, nil, iter_14_1.neednum)
			local var_14_6 = var_14_1:clone()

			var_14_6:setVisible(true)
			var_14_6:setPosition(cc.p(var_14_2 + var_14_4 * (iter_14_0 - (#self.msg.materials + 1) / 2), var_14_3))
			var_14_5:setPosition(cc.p(var_14_6:getContentSize().width / 2, var_14_6:getContentSize().height / 2))
			var_14_6:addChild(var_14_5)

			if iter_14_1.ownnum < iter_14_1.neednum or iter_14_1.neednum == 0 then
				self.touchEventFlag = false

				var_14_5:getChildByName("layout"):getChildByName("icon"):setOpacity(180)
				var_14_5:setOpacity(180)
				var_14_5:setCascadeOpacityEnabled(false)
			end

			if iter_14_1.ownnum >= iter_14_1.neednum then
				var_14_6:setLocalZOrder(2)
				var_14_6:addTouchEventListener(function(arg_15_0, arg_15_1)
					if arg_15_1 ~= ccui.TouchEventType.ended then
						return
					end

					LayerManager:pushInLayer("PopItemLayer", {
						itemid = iter_14_1.id,
						entityid = iter_14_1.entityid
					})
				end)
			else
				var_14_6:setLocalZOrder(0)
				var_14_6:getChildByName("image_add"):setLocalZOrder(2)
				var_14_6:addTouchEventListener(function(arg_16_0, arg_16_1)
					if arg_16_1 ~= ccui.TouchEventType.ended then
						return
					end

					LayerManager:pushInLayer("PopGoGainLayer", {
						item = iter_14_1.id
					})
				end)
			end

			var_14_0:getChildByName("ListView_38"):pushBackCustomItem(var_14_6)
		end
	end
end

function PopUpgradeCostlayer:initSureBtn()
	local var_17_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_back")
	local var_17_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "button_sure")

	var_17_1:loadTextures("public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", "public/button/public_button_orange_long.png", var_0_0)

	if self.msg.bntstr then
		var_17_1:getChildByName("Label_21"):setString(self.msg.bntstr)
	else
		var_17_1:setVisible(false)
	end

	var_17_1:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.touchEventFlag ~= false then
			if self.msg.surecallback then
				self.msg.surecallback()
			end
		elseif self.msg.shopBuyCallback then
			LayerManager:removePopLayer(self.__queueindex)

			local var_18_0 = self.msg.curStar

			self.msg.shopBuyCallback(function()
				require("controller.condition_trigger_packs_manager"):check_trigger_condition({
					shop_type = WEAPOM_PACKS,
					curStar = var_18_0
				})
			end)
		else
			global_ShowBlockWords(L_CONDITON_NO_ENOUGH)
			audio_manager:playeffectMusicTest("sound/invalid")
		end
	end)

	if self.msg.surecallback2 then
		var_17_1:setPositionX(460)

		local var_17_3 = ccui.Button:create("public/button/public_button_big_blue_y.png", nil, "public/button/public_button_big_blue_y.png", var_0_0)
		local var_17_4 = cc.Label:createWithTTF(self.msg.bnt2str or L_BUTTON_TEXT.Can_cel, FONT_BUTTON, 28)

		var_17_4:setPositionX(var_17_3:getContentSize().width / 2 + 2)
		var_17_4:setPositionY(var_17_3:getContentSize().height / 2 + 4)
		var_17_4:setColor(cc.c3b(55, 55, 55))
		var_17_3:setScale(0.9)
		var_17_3:setPositionX(180)
		var_17_3:setPositionY(var_17_1:getPositionY())
		var_17_3:addChild(var_17_4)
		var_17_0:addChild(var_17_3)
		var_17_3:addTouchEventListener(function(arg_20_0, arg_20_1)
			if arg_20_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:exit()
		end)
	end

	self:updateBtnFlag()
end

function PopUpgradeCostlayer:initCost()
	local var_21_0 = ccui.Helper:seekWidgetByName(ccui.Helper:seekWidgetByName(self.rootLayer, "panel_cost"), "label_cost_num_gold")

	var_21_0:setVisible(false)
	var_21_0:setPositionX(0)

	if self.msg.costDes then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_costDes"):setString(self.msg.costDes)
	end

	if self.msg.gold_cost then
		var_21_0:setVisible(true)
		var_21_0:setString(global_trans_number(self.msg.gold_cost))
	end

	if self.msg.energy_cost then
		var_21_0:setVisible(true)
		var_21_0:setString(var_21_0:getString() .. " " .. L_PLAYER_DATA_TYPE.Energy .. ":" .. self.msg.energy_cost)
	end

	if self.msg.cost_icon_path then
		if string.find(msg.cost_icon_path, "equipment/") then
			ccui.Helper:seekWidgetByName(var_21_0, "image_gold"):loadTexture(self.msg.cost_icon_path)
		else
			ccui.Helper:seekWidgetByName(var_21_0, "image_gold"):loadTexture("public/currency/UI_battleEnd_diamond.png", var_0_0)
		end
	end
end

function PopUpgradeCostlayer:ActionofAccess()
	self.rootPanel:setOpacity(0)
	self.rootPanel:setScale(1, 0.001)
	self.rootPanel:runAction((cc.Sequence:create(cc.Blink:create(0.15, 1), cc.Spawn:create(cc.FadeIn:create(0.1), cc.ScaleTo:create(0.1, 1, 1)))))
end

function PopUpgradeCostlayer.fullScreen(arg_23_0, arg_23_1)
	arg_23_1:setContentSize((GameDisplay.getScreenSize()))
	arg_23_1:setPositionY(arg_23_1:getPositionY() - GameDisplay.fix_y)
	arg_23_1:getChildByName("panel_back"):setPositionY(arg_23_1:getChildByName("panel_back"):getPositionY() + GameDisplay.fix_y)
end

function PopUpgradeCostlayer:exit()
	global_window_close_action(self.rootPanel, function()
		if self.msg.cancelcallback then
			self.msg.cancelcallback()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
