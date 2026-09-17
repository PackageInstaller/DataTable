PopSwimWeekResultLayer = class("PopSwimWeekResultLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")

local var_0_0 = config._DEBUG and 0 or 1
local model_data = require("data.model_data")
local school_swim_manager = require("controller.school_swim_manager")
local activity_manager = require("controller.activity_manager")

function PopSwimWeekResultLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopSwimWeekResultLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopSwimWeekResultLayer:init(arg_3_1)
	print("open poplayer : PopSwimWeekResultLayer")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopSwimResultLayer.json" or "PopSwimResultLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.swimId = arg_3_1 and arg_3_1.id

	self:initUI()
	self:updateUI()
	self:playEffect()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			school_swim_manager:check_swim_vote_reward()
		end
	end)
end

function PopSwimWeekResultLayer:initUI()
	self:initExitTouchEvent()
	self:initUIBeforePlayEffect()
	self:initTilte()
end

function PopSwimWeekResultLayer:initUIBeforePlayEffect()
	self.panelUp = self.rootLayer:getChildByName("panel_up")

	self.panelUp:setTouchEnabled(true)

	self.clip = self.panelUp:getChildByName("clip")
	self.wimmer = self.clip:getChildByName("winner")

	self.wimmer:setOpacity(0)
	self.wimmer:setAnchorPoint(0.5, 1)
	self.wimmer:setPositionY(580)

	for iter_6_0 = 1, 4 do
		local var_6_0 = self.clip:getChildByName("bottom_" .. iter_6_0)

		var_6_0:setPositionY(var_6_0:getPositionY() - 300)
		var_6_0:getChildByName("model_" .. iter_6_0):setScale(0.38)
		var_6_0:getChildByName("top_" .. iter_6_0):setVisible(false)
	end
end

function PopSwimWeekResultLayer:updateUI()
	local var_7_0 = school_swim_manager:getTeamList()

	self.wimmer:loadTexture("role/" .. model_data[var_7_0[1].captain].role_image .. ".png")

	local function var_7_1(arg_8_0, arg_8_1)
		for iter_8_0, iter_8_1 in pairs(arg_8_0) do
			if iter_8_1 == arg_8_1 then
				return iter_8_0
			end
		end
	end

	school_swim_manager:get_swim_round_rank(0, function(arg_9_0)
		for iter_9_0 = 1, #var_7_0 do
			local var_9_0 = self.clip:getChildByName("bottom_" .. iter_9_0)

			var_9_0:loadTexture("SwimMainLayer/bottom_" .. var_7_1(arg_9_0, var_7_0[iter_9_0].id) .. ".png", var_0_0)

			local var_9_1 = var_9_0:getChildByName("model_" .. iter_9_0)

			var_9_1:setPosition(cc.p(var_9_0:getContentSize().width / 2, var_9_0:getContentSize().height - 2))
			var_9_1:loadTexture("role1/" .. model_data[var_7_0[iter_9_0].captain].role_image .. ".png")

			local var_9_2 = var_9_0:getChildByName("top_" .. iter_9_0)

			var_9_2:loadTexture("SwimMainLayer/top_" .. var_7_1(arg_9_0, var_7_0[iter_9_0].id) .. ".png", var_0_0)
			var_9_2:setPosition(cc.p(var_9_1:getPositionX(), var_9_1:getPositionY() + 208))
		end
	end)
	school_swim_manager:get_swim_vote_reward(2, nil, function(arg_10_0)
		self.canExit = true

		local var_10_0 = self.panelUp:getChildByName("vote")
		local var_10_1 = self.panelUp:getChildByName("unvote")

		if not arg_10_0.items then
			var_10_0:setVisible(false)
			var_10_1:setVisible(true)
		elseif arg_10_0.reward == 2 then
			var_10_0:loadTexture("SwimMainLayer/vote_fail.png", var_0_0)
			var_10_0:setVisible(true)
			var_10_1:setVisible(false)

			for iter_10_0, iter_10_1 in pairs(arg_10_0.items) do
				local var_10_2 = ItemPurchaseSprite:createPurchaseItem(iter_10_1.dropid, iter_10_1.dropNum)

				var_10_2:setScale(0.6)
				var_10_2:setPosition(cc.p(225 + 120 * iter_10_0, 80))
				var_10_2:setTouchEnabled(true)
				var_10_2:setSwallowTouches(false)
				self.panelUp:addChild(var_10_2)
				var_10_2:addTouchEventListener(function(arg_11_0, arg_11_1)
					if arg_11_1 ~= ccui.TouchEventType.ended then
						return
					end

					showItemDetails(iter_10_1.dropid)
				end)
			end
		elseif arg_10_0.reward == 1 then
			var_10_0:loadTexture("SwimMainLayer/vote_succ.png", var_0_0)
			var_10_0:setVisible(true)
			var_10_1:setVisible(false)

			for iter_10_2, iter_10_3 in pairs(arg_10_0.items) do
				local var_10_3 = ItemPurchaseSprite:createPurchaseItem(iter_10_3.dropid, iter_10_3.dropNum)

				var_10_3:setScale(0.6)
				var_10_3:setPosition(cc.p(225 + 120 * iter_10_2, 80))
				var_10_3:setTouchEnabled(true)
				var_10_3:setSwallowTouches(false)
				self.panelUp:addChild(var_10_3)
				var_10_3:addTouchEventListener(function(arg_12_0, arg_12_1)
					if arg_12_1 ~= ccui.TouchEventType.ended then
						return
					end

					showItemDetails(iter_10_3.dropid)
				end)
			end
		end
	end)
end

function PopSwimWeekResultLayer:initTilte()
	self.title = self.panelUp:getChildByName("lbl_title")

	self.title:setString(L_SWIM_REWARD_TITLE_WEEK)

	self.panelBtn = self.rootLayer:getChildByName("panel_btn")

	local var_13_0 = self.panelBtn:getChildByName("btn_daily")

	var_13_0:getChildByName("btn_show_swim"):setString(L_SWIM_WEEK_RECORE[2])
	var_13_0:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.canExit ~= true then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopSwimWeekResultLayer:playEffect()
	self.isPlayEffect = true

	self.wimmer:runAction(cc.Sequence:create(cc.FadeTo:create(0.5, 76.5), cc.CallFunc:create(function()
		return
	end)))

	for iter_15_0 = 1, 4 do
		local var_15_0 = self.clip:getChildByName("bottom_" .. iter_15_0)

		var_15_0:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(0, 300))))

		local var_15_1 = var_15_0:getChildByName("top_" .. iter_15_0)

		var_15_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
			var_15_1:setVisible(true)

			self.isPlayEffect = false
		end)))
	end
end

function PopSwimWeekResultLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_19_0, arg_19_1)
		if self.isPlayEffect then
			return
		end

		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_19_0:isBright() then
			return
		end

		arg_19_0:setBright(false)
		self:exit()
	end)
end

function PopSwimWeekResultLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		if self.canExit ~= true then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopSwimWeekResultLayer:initBg(arg_22_1)
	local var_22_0 = ccui.Layout:create()

	var_22_0:setTouchEnabled(true)
	var_22_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_22_0:setAnchorPoint(cc.p(0, 0))
	var_22_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_22_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_22_0:setOpacity(0)
	self:addChild(var_22_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_23_0)
		self:addChild(arg_23_0, -2)
		arg_23_0:setPositionY(arg_23_0:getPositionY() - GameDisplay.fix_y)

		local var_23_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_23_0:setAnchorPoint(cc.p(0, 0))
		var_23_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_23_0, -1)
		self:init(arg_22_1)
		var_22_0:setOpacity(102)
		var_22_0:setTouchEnabled(false)
	end)
end
