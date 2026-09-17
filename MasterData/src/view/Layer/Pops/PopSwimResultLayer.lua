PopSwimResultLayer = class("PopSwimResultLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")

local var_0_0 = config._DEBUG and 0 or 1
local model_data = require("data.model_data")
local school_swim_manager = require("controller.school_swim_manager")
local activity_manager = require("controller.activity_manager")

function PopSwimResultLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopSwimResultLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopSwimResultLayer:init(arg_3_1)
	print("open poplayer : PopSwimResultLayer")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopSwimResultLayer.json" or "PopSwimResultLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.swimId = arg_3_1.id

	self:initUI()
	self:registerEventListener()
	school_swim_manager:get_specific_swim_match(self.swimId)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopSwimResultLayer")
		end
	end)
end

function PopSwimResultLayer.registerEventListener(arg_5_0)
	activity_manager:registerEventListener("PopSwimResultLayer", activity_manager.activityEventId.SWIM_COMPETITION_LIST_UPDATE, function(arg_6_0)
		arg_5_0:updateUI()
		arg_5_0:playEffect()
	end)
end

function PopSwimResultLayer:initUI()
	self:initExitTouchEvent()
	self:initUIBeforePlayEffect()
	self:initTilte()
end

function PopSwimResultLayer:initUIBeforePlayEffect()
	self.panelUp = self.rootLayer:getChildByName("panel_up")

	self.panelUp:setTouchEnabled(true)

	self.clip = self.panelUp:getChildByName("clip")
	self.wimmer = self.clip:getChildByName("winner")

	self.wimmer:setOpacity(0)
	self.wimmer:setAnchorPoint(0.5, 1)
	self.wimmer:setPositionY(580)

	for iter_8_0 = 1, 4 do
		local var_8_0 = self.clip:getChildByName("bottom_" .. iter_8_0)

		var_8_0:setPositionY(var_8_0:getPositionY() - 300)
		var_8_0:getChildByName("model_" .. iter_8_0):setScale(0.38)
		var_8_0:getChildByName("top_" .. iter_8_0):setVisible(false)
	end
end

function PopSwimResultLayer:updateUI()
	local var_9_0 = school_swim_manager:getshowSwimData().teams

	self.wimmer:loadTexture("role/" .. model_data[var_9_0[1].player].role_image .. ".png")

	for iter_9_0 = 1, #var_9_0 do
		local var_9_1 = self.clip:getChildByName("bottom_" .. iter_9_0)

		var_9_1:loadTexture("SwimMainLayer/bottom_" .. var_9_0[iter_9_0].rank .. ".png", var_0_0)

		local var_9_2 = var_9_1:getChildByName("model_" .. iter_9_0)

		var_9_2:setPosition(cc.p(var_9_1:getContentSize().width / 2, var_9_1:getContentSize().height - 2))
		var_9_2:loadTexture("role1/" .. model_data[var_9_0[iter_9_0].player].role_image .. ".png")

		local var_9_3 = var_9_1:getChildByName("top_" .. iter_9_0)

		var_9_3:loadTexture("SwimMainLayer/top_" .. var_9_0[iter_9_0].rank .. ".png", var_0_0)
		var_9_3:setPosition(cc.p(var_9_2:getPositionX(), var_9_2:getPositionY() + 208))
	end

	local var_9_4 = school_swim_manager:getSwimVoteDropList(self.swimId)
	local var_9_5 = self.panelUp:getChildByName("vote")
	local var_9_6 = self.panelUp:getChildByName("unvote")

	if not var_9_4 then
		var_9_5:setVisible(false)
		var_9_6:setVisible(true)
	elseif #var_9_4 == 1 then
		var_9_5:loadTexture("SwimMainLayer/vote_fail.png", var_0_0)
		var_9_5:setVisible(true)
		var_9_6:setVisible(false)

		local var_9_7 = ItemPurchaseSprite:createPurchaseItem(var_9_4[1].dropid, var_9_4[1].dropNum)

		var_9_7:setScale(0.6)
		var_9_7:setPosition(cc.p(400, 80))
		var_9_7:setTouchEnabled(true)
		var_9_7:setSwallowTouches(false)
		self.panelUp:addChild(var_9_7)
		var_9_7:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(var_9_4[1].dropid)
		end)
	elseif #var_9_4 == 2 then
		var_9_5:loadTexture("SwimMainLayer/vote_succ.png", var_0_0)
		var_9_5:setVisible(true)
		var_9_6:setVisible(false)

		for iter_9_1, iter_9_2 in pairs(var_9_4) do
			local var_9_8 = ItemPurchaseSprite:createPurchaseItem(iter_9_2.dropid, iter_9_2.dropNum)

			var_9_8:setScale(0.6)
			var_9_8:setPosition(cc.p(225 + 120 * iter_9_1, 80))
			var_9_8:setTouchEnabled(true)
			var_9_8:setSwallowTouches(false)
			self.panelUp:addChild(var_9_8)
			var_9_8:addTouchEventListener(function(arg_11_0, arg_11_1)
				if arg_11_1 ~= ccui.TouchEventType.ended then
					return
				end

				showItemDetails(iter_9_2.dropid)
			end)
		end
	end

	school_swim_manager:get_swim_vote_reward(1, self.swimId, function(arg_12_0)
		self.canExit = true
	end)
end

function PopSwimResultLayer:initTilte()
	self.title = self.panelUp:getChildByName("lbl_title")

	self.title:setString(school_swim_manager:getShowSwimDes(self.swimId))

	self.panelBtn = self.rootLayer:getChildByName("panel_btn")

	local var_13_0 = self.panelBtn:getChildByName("btn_daily")

	var_13_0:getChildByName("btn_show_swim"):setString(L_SWIM_VOTE_BTN_SHOW)
	var_13_0:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.canExit ~= true then
			return
		end

		LayerManager:switchShowLayer("SchoolSwimLayer", {
			swimId = swimId
		})
	end)
end

function PopSwimResultLayer:playEffect()
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

function PopSwimResultLayer:initExitTouchEvent()
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

function PopSwimResultLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		if self.canExit ~= true then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopSwimResultLayer:initBg(arg_22_1)
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
