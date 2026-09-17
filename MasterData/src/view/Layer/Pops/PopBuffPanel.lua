PopBuffPanel = class("PopBuffPanel", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local FightBuffSp = require("view.Sprite.FightBuffSp")
local model_data = require("data.model_data")
local buff_data = require("data.buff_data")
local var_0_4 = cc.c4b(200, 59, 239, 150)

function PopBuffPanel.create(arg_2_0, arg_2_1)
	local var_2_0 = PopBuffPanel.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopBuffPanel:init(arg_3_1)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "BuffPanel.json" or "BuffPanel.ExportJson")

	self:addChild(self.rootlayer)
	self.rootlayer:setLocalZOrder(999)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bottom")

	self.rootpanel:setPositionY(GameDisplay.getScreenSize().height / 2)

	self.panelback = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_back")

	self.panelback:setTouchEnabled(false)

	self.panelplayer = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_player")
	self.panelenemy = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_enemy")
	self.btnplayer = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_player")
	self.btnenemy = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_enemy")

	self.panelplayer:setVisible(false)
	self.panelenemy:setVisible(false)

	self.imageBuffDetails = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_buff_details")
	self.listEnemy = ccui.Helper:seekWidgetByName(self.rootlayer, "ListView_enemy")

	self.btnplayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchBtn(1)
	end)
	self.btnenemy:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:switchBtn(2)
	end)
	self.showActions.extendVertical(self)
	self:createFullScreenMask(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_6_0:isBright() then
			return
		end

		arg_6_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if config._DEVELOP_MODE == "FIGHTDEV" then
				self:runAction(cc.RemoveSelf:create())
			else
				LayerManager:removePopLayer(self.__queueindex)

				if arg_3_1 and arg_3_1.exitcallback then
					arg_3_1.exitcallback()
				end
			end

			FightManager.resumeBattleField()
		end)
	end)
	self:switchBtn(1)
	self:initPlayer()
	self:initEnemies()
end

function PopBuffPanel.initBuffInfo(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	return function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_8_0.imageBuffDetail = arg_8_0.imageBuffDetails:clone()

		arg_8_0.imageBuffDetail:getChildByName("Label_name"):setString(buff_data[arg_8_1].name)
		arg_8_0.imageBuffDetail:getChildByName("Label_surplus_time"):setString(L_LEFT_TIME_SPACE .. string.format("%.1f", arg_8_3) .. L_TIME_TEXT_SIMPLE.Second)
		arg_8_0.imageBuffDetail:setPosition(cc.p(arg_8_4:getPositionX(), arg_8_4:getPositionY() + 160))

		local var_9_0 = ccui.ImageView:create("skill_new/skill/" .. buff_data[arg_8_1].buff_image .. ".png", var_0_0)

		var_9_0:setScale(0.8)
		var_9_0:setPosition(cc.p(arg_8_0.imageBuffDetail:getContentSize().width / 2 - 170, arg_8_0.imageBuffDetail:getContentSize().height / 2))

		if arg_8_2 ~= 1 then
			local var_9_1 = cc.Label:createWithTTF("x" .. arg_8_2, FONT_DES, 30)

			var_9_1:setPosition(cc.p(var_9_0:getContentSize().width / 2 + 40, var_9_0:getContentSize().height / 2 - 40))
			var_9_1:enableOutline(var_0_4, 1)
			var_9_1:enableShadow(var_0_4, cc.size(0, 0))
			var_9_0:addChild(var_9_1, 999)
		end

		arg_8_0.imageBuffDetail:addChild(var_9_0, 997)
		arg_8_0.rootpanel:addChild(arg_8_0.imageBuffDetail, 998)

		if arg_8_5 == true then
			local var_9_2 = ccui.ImageView:create("skill_new/buff_frame_down.png", var_0_0)

			var_9_2:setScale(2.5)
			var_9_2:setPosition(cc.p(arg_8_0.imageBuffDetail:getContentSize().width / 2 - 170, arg_8_0.imageBuffDetail:getContentSize().height / 2))
			arg_8_0.imageBuffDetail:addChild(var_9_2, 999)
		elseif arg_8_5 == false then
			local var_9_3 = ccui.ImageView:create("skill_new/buff_frame_up.png", var_0_0)

			var_9_3:setScale(2.5)
			var_9_3:setPosition(cc.p(arg_8_0.imageBuffDetail:getContentSize().width / 2 - 170, arg_8_0.imageBuffDetail:getContentSize().height / 2))
			arg_8_0.imageBuffDetail:addChild(var_9_3, 999)
		end

		local var_9_4 = RichTextPro:create()

		var_9_4:setMaxWidth(330)
		var_9_4:setSize(18)
		var_9_4:setLineSpace(1)
		var_9_4:setPosition(cc.p(arg_8_0.imageBuffDetail:getContentSize().width / 2 - 113, arg_8_0.imageBuffDetail:getContentSize().height / 2 + 13))
		var_9_4:setName("richText")
		var_9_4:setText((transSkillDesToRichText(arg_8_0:initBuffDetails(arg_8_1), cc.c3b(5, 185, 223))))
		var_9_4:setAnchorPoint(cc.p(0, 1))
		arg_8_0.imageBuffDetail:addChild(var_9_4, 999)

		local var_9_5 = cc.EventListenerTouchOneByOne:create()

		var_9_5:setSwallowTouches(false)
		var_9_5:registerScriptHandler(function(arg_10_0, arg_10_1)
			if arg_8_0.imageBuffDetail then
				arg_8_0.imageBuffDetail:removeFromParent()
			end

			return true
		end, cc.Handler.EVENT_TOUCH_BEGAN)
		var_9_5:registerScriptHandler(function(arg_11_0, arg_11_1)
			if arg_8_0.imageBuffDetail then
				arg_8_0.imageBuffDetail:removeFromParent()
			end
		end, cc.Handler.EVENT_TOUCH_ENDED)
		arg_8_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_9_5, arg_8_0.imageBuffDetail)
	end
end

function PopBuffPanel.initBuffDetails(arg_12_0, arg_12_1)
	local var_12_0 = buff_data[arg_12_1].detail .. "，" .. string.format(L_BUFF_CONTANT_TIME, tostring(buff_data[arg_12_1].time))

	var_12_0 = buff_data[arg_12_1].appendable ~= 1 and var_12_0 .. "，" .. string.format(L_BUFF_SUPERPOSITION, buff_data[arg_12_1].appendable) or var_12_0 .. "。"

	if buff_data[arg_12_1].cleanable == 0 or buff_data[arg_12_1].cleanable == 1 then
		var_12_0 = var_12_0 .. L_BUFF_DISPEL_FORBID
	end

	return var_12_0
end

function PopBuffPanel:initPlayer()
	self.imageBuffBottom = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_buff_bottom")

	local var_13_0 = 277
	local var_13_1 = 649
	local var_13_2 = self.imageBuffBottom:getContentSize().height + 10

	for iter_13_0 = 1, FORMATION_SHOW_GIRL_NUM do
		local var_13_3 = self.imageBuffBottom:clone()

		if not FightManager.players[iter_13_0] then
			var_13_3:getChildByName("Image_head_image"):setVisible(false)
			var_13_3:getChildByName("Image_nodata"):setVisible(true)
			var_13_3:getChildByName("Image_failed"):setVisible(false)
		else
			var_13_3:getChildByName("Image_head_image"):loadTexture("roleimage/role/wuji/" .. model_data[FightManager.players[iter_13_0].model:getAttribute("modelid")].head_image .. ".png")
			var_13_3:getChildByName("Image_head_image"):setScale(0.5)

			if FightManager.players[iter_13_0]:getState() ~= STATE_DIED then
				for iter_13_1, iter_13_2 in pairs(FightManager.players[iter_13_0]:getAllBuffs(1)) do
					if not buff_data[iter_13_2.id].image_show or buff_data[iter_13_2.id].image_show == 1 then
						local var_13_4 = FightBuffSp:create(iter_13_2.id, iter_13_2:getBuffCount(), nil, 1)

						var_13_4:getChildByName("sp"):addTouchEventListener(self:initBuffInfo(var_13_4:getID(), var_13_4:getBuffCount(), iter_13_2:getBuffTime(), var_13_3, false))

						local var_13_5 = ccui.Layout:create()

						var_13_5:setTouchEnabled(false)
						var_13_5:setContentSize(cc.size(60, 60))
						var_13_5:setAnchorPoint(cc.p(0.5, 0.5))
						var_13_5:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
						var_13_5:addChild(var_13_4, 999)
						var_13_4:setPosition(cc.p(var_13_5:getContentSize().width / 2, var_13_5:getContentSize().height / 2))
						var_13_3:getChildByName("ListView_good_buff"):pushBackCustomItem(var_13_5)
					end
				end

				for iter_13_3, iter_13_4 in pairs(FightManager.players[iter_13_0]:getAllBuffs(0)) do
					if not buff_data[iter_13_4.id].image_show or buff_data[iter_13_4.id].image_show == 1 then
						local var_13_6 = FightBuffSp:create(iter_13_4.id, iter_13_4:getBuffCount(), nil, 0)

						var_13_6:getChildByName("sp"):addTouchEventListener(self:initBuffInfo(var_13_6:getID(), var_13_6:getBuffCount(), iter_13_4:getBuffTime(), var_13_3, true))

						local var_13_7 = ccui.Layout:create()

						var_13_7:setTouchEnabled(false)
						var_13_7:setContentSize(cc.size(60, 60))
						var_13_7:setAnchorPoint(cc.p(0.5, 0.5))
						var_13_7:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
						var_13_7:addChild(var_13_6, 999)
						var_13_6:setPosition(cc.p(var_13_7:getContentSize().width / 2, var_13_7:getContentSize().height / 2))
						var_13_3:getChildByName("ListView_bad_buff"):pushBackCustomItem(var_13_7)
					end
				end
			else
				var_13_3:getChildByName("ListView_good_buff"):removeAllItems()
				var_13_3:getChildByName("ListView_bad_buff"):removeAllItems()
				var_13_3:getChildByName("Image_head_image"):setVisible(false)
				var_13_3:getChildByName("Image_nodata"):setVisible(false)
				var_13_3:getChildByName("Image_failed"):setVisible(true)
			end
		end

		var_13_3:setPosition(cc.p(var_13_0, var_13_1))
		self.panelplayer:addChild(var_13_3, 999)

		var_13_1 = var_13_1 - var_13_2
	end
end

function PopBuffPanel:initEnemies()
	self.imageBuffBottom = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_buff_bottom")

	local var_14_0 = 277
	local var_14_1 = 649
	local var_14_2 = self.imageBuffBottom:getContentSize().height + 10

	print("#FightManager.enemies==", #FightManager.enemies, dump(FightManager.enemies))

	for iter_14_0 = 1, #FightManager.enemies do
		local var_14_3 = self.imageBuffBottom:clone()

		if not FightManager.enemies[iter_14_0] then
			var_14_3:getChildByName("Image_head_image"):setVisible(false)
			var_14_3:getChildByName("Image_nodata"):setVisible(true)
			var_14_3:getChildByName("Image_failed"):setVisible(false)
		else
			var_14_3:getChildByName("Image_head_image"):loadTexture("roleimage/role/wuji/" .. model_data[FightManager.enemies[iter_14_0].model:getAttribute("modelid")].head_image .. ".png")
			var_14_3:getChildByName("Image_head_image"):setScale(0.5)

			if FightManager.enemies[iter_14_0]:getState() ~= STATE_DIED then
				var_14_3:getChildByName("Image_head_image"):setVisible(true)
				var_14_3:getChildByName("Image_failed"):setVisible(false)

				for iter_14_1, iter_14_2 in pairs(FightManager.enemies[iter_14_0]:getAllBuffs(1)) do
					if buff_data[iter_14_2.id].image_show ~= 0 then
						local var_14_4 = FightBuffSp:create(iter_14_2.id, iter_14_2:getBuffCount(), nil, 1)

						var_14_4:getChildByName("sp"):addTouchEventListener(self:initBuffInfo(var_14_4:getID(), var_14_4:getBuffCount(), iter_14_2:getBuffTime(), var_14_3, false))

						local var_14_5 = ccui.Layout:create()

						var_14_5:setTouchEnabled(false)
						var_14_5:setContentSize(cc.size(60, 60))
						var_14_5:setAnchorPoint(cc.p(0.5, 0.5))
						var_14_5:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
						var_14_5:addChild(var_14_4, 999)
						var_14_4:setPosition(cc.p(var_14_5:getContentSize().width / 2, var_14_5:getContentSize().height / 2))
						var_14_3:getChildByName("ListView_good_buff"):pushBackCustomItem(var_14_5)
					end
				end

				for iter_14_3, iter_14_4 in pairs(FightManager.enemies[iter_14_0]:getAllBuffs(0)) do
					if buff_data[iter_14_4.id].image_show ~= 0 then
						local var_14_6 = FightBuffSp:create(iter_14_4.id, iter_14_4:getBuffCount(), nil, 0)

						var_14_6:getChildByName("sp"):addTouchEventListener(self:initBuffInfo(var_14_6:getID(), var_14_6:getBuffCount(), iter_14_4:getBuffTime(), var_14_3, true))

						local var_14_7 = ccui.Layout:create()

						var_14_7:setTouchEnabled(false)
						var_14_7:setContentSize(cc.size(60, 60))
						var_14_7:setAnchorPoint(cc.p(0.5, 0.5))
						var_14_7:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
						var_14_7:addChild(var_14_6, 999)
						var_14_6:setPosition(cc.p(var_14_7:getContentSize().width / 2, var_14_7:getContentSize().height / 2))
						var_14_3:getChildByName("ListView_bad_buff"):pushBackCustomItem(var_14_7)
					end
				end
			else
				var_14_3:getChildByName("ListView_good_buff"):removeAllItems()
				var_14_3:getChildByName("ListView_bad_buff"):removeAllItems()
				var_14_3:getChildByName("Image_head_image"):setVisible(false)
				var_14_3:getChildByName("Image_nodata"):setVisible(false)
				var_14_3:getChildByName("Image_failed"):setVisible(true)
			end
		end

		if #FightManager.enemies > FORMATION_SHOW_GIRL_NUM then
			self.listEnemy:pushBackCustomItem(var_14_3)
		else
			var_14_3:setPosition(cc.p(var_14_0, var_14_1))
			self.panelenemy:addChild(var_14_3, 999)
		end

		var_14_1 = var_14_1 - var_14_2
	end

	if #FightManager.enemies < FORMATION_SHOW_GIRL_NUM then
		for iter_14_5 = 1, FORMATION_SHOW_GIRL_NUM - #FightManager.enemies do
			local var_14_8 = self.imageBuffBottom:clone()

			var_14_8:getChildByName("Image_head_image"):setVisible(false)
			var_14_8:getChildByName("Image_nodata"):setVisible(true)
			var_14_8:getChildByName("Image_failed"):setVisible(false)
			var_14_8:setPosition(cc.p(var_14_0, var_14_1))

			var_14_1 = var_14_1 - var_14_2

			self.panelenemy:addChild(var_14_8, 999)
		end
	end
end

function PopBuffPanel:switchBtn(arg_15_1)
	if self.index == arg_15_1 then
		return
	end

	self.index = arg_15_1

	if self.index == 1 then
		self.btnplayer:loadTextures("BuffPanel/btn_buff_on.png", "BuffPanel/btn_buff_on.png", "BuffPanel/btn_buff_on.png", var_0_0)
		self.btnenemy:loadTextures("BuffPanel/btn_enemy_buff.png", "BuffPanel/btn_enemy_buff.png", "BuffPanel/btn_enemy_buff.png", var_0_0)
		self.panelplayer:setVisible(true)
		self.panelenemy:setVisible(false)
	else
		self.btnplayer:loadTextures("BuffPanel/btn_buff.png", "BuffPanel/btn_buff.png", "BuffPanel/btn_buff.png", var_0_0)
		self.btnenemy:loadTextures("BuffPanel/btn_enemy_buff_on.png", "BuffPanel/btn_enemy_buff_on.png", "BuffPanel/btn_enemy_buff_on.png", var_0_0)
		self.panelplayer:setVisible(false)
		self.panelenemy:setVisible(true)
	end
end
