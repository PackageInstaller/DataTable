ActivityPopBaseLayer = class("ActivityPopBaseLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local var_0_1 = config._DEBUG and "activityresource/activitypop/" or "activityui/activitypop/"
local var_0_2 = "ActivityPop_"
local activity_manager = require("controller.activity_manager")

function ActivityPopBaseLayer.createforchild(arg_2_0)
	return (ActivityPopBaseLayer.new())
end

function ActivityPopBaseLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ActivityPopBaseLayer.new()

	var_3_0:initGaussBg(arg_3_1)

	return var_3_0
end

function ActivityPopBaseLayer:init(arg_4_1)
	self._id = arg_4_1.id
	self._exitcallback = arg_4_1.exitcallback

	self:loadActivityPopAssets(self._id)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(var_0_1 .. ((config._DEBUG or nil) and (var_0_2 .. self._id .. ".json" or var_0_2 .. self._id .. ".ExportJson")))

	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(self.rootLayer, 1)

	self.rootpanel = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")

	self.rootpanel:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self.rootpanel:setTouchEnabled(true)
	self.showActions.extendVertical(self)
	self.rootLayer:addTouchEventListener(function(arg_5_0, arg_5_1)
		return
	end)
	self:initActivityPopCompnents()
end

function ActivityPopBaseLayer.loadActivityPopAssets(arg_6_0, arg_6_1)
	if config._DEBUG then
		return
	end

	TextureManager:loadPopLayerTextures({
		var_0_1 .. var_0_2 .. arg_6_1
	})
end

function ActivityPopBaseLayer:initActivityPopCompnents()
	self:initActivityPopBtnInfo()
	self:initActivityPopBtnInfo2()
	self:initActivityPopBtnGoto()
	self:initActivityPopBtnClose()
	self:initActivityPopBtnGetStar()
end

function ActivityPopBaseLayer:initActivityPopBtnInfo()
	self.btnInfo = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_info")

	if not self.btnInfo then
		return
	end

	self.btnInfo:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:onButtonInfo()
	end)
end

function ActivityPopBaseLayer:initActivityPopBtnInfo2()
	self.btnInfo2 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_info2")

	if not self.btnInfo2 then
		return
	end

	self.btnInfo2:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:onButtonInfo2()
	end)
end

function ActivityPopBaseLayer:initActivityPopBtnGoto()
	self.btnGoto = ccui.Helper:seekWidgetByName(self.rootpanel, "btn_goto")

	if not self.btnGoto then
		return
	end

	self.btnGoto:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:onButtonSure()
	end)
end

function ActivityPopBaseLayer:initActivityPopBtnClose()
	self.btnClose = ccui.Helper:seekWidgetByName(self.rootpanel, "btn_close")

	if not self.btnClose then
		return
	end

	self.btnClose:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.hideActions.shrinkVertical(self, function()
			if self._exitcallback then
				self._exitcallback()
			end

			LayerManager:removePopLayer(self.__queueindex)
			AnalyticManager.clickPopWindowsX({
				windowid = self._id
			})
		end)
	end)
end

function ActivityPopBaseLayer:initActivityPopBtnGetStar()
	local var_17_0 = {
		["270001"] = "https://apps.apple.com/cn/app/id1455051196",
		["270048"] = "https://www.taptap.com/app/42949/review"
	}
	local var_17_1 = DeviceManager:getChannelID()

	self.btnGetStar = ccui.Helper:seekWidgetByName(self.rootpanel, "btn_getStar")

	if not self.btnGetStar then
		return
	end

	if not var_17_0[var_17_1] then
		self.btnGetStar:setVisible(false)
		self.btnGoto:setPositionX((self.btnGoto:getPositionX() + self.btnGetStar:getPositionX()) / 2)

		return
	else
		self.btnGoto:setVisible(false)
		self.btnGetStar:setPositionX((self.btnGoto:getPositionX() + self.btnGetStar:getPositionX()) / 2)
		self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("APPENTERFOREGROUND", function(arg_18_0)
			self:runAction(cc.Sequence:create(cc.DelayTime:create((math.max(0, arg_18_0.backtime - 10))), cc.CallFunc:create(function()
				self.hideActions.shrinkVertical(self, function()
					if self._exitcallback then
						self._exitcallback()
					end

					self:onGetPopDrop()
					LayerManager:removePopLayer(self.__queueindex)
					AnalyticManager.ActivityPopBaseLayer({
						getreward = true,
						popid = self._id,
						channelid = var_17_1
					})
				end)
			end)))
		end), self)
	end

	self.btnGetStar:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_17_1 == "270049" and cc.Native:hasInstalledTapTap() then
			DeviceManager.openURL(var_17_0[var_17_1])
		elseif var_17_0[var_17_1] then
			DeviceManager.openURL(var_17_0[var_17_1])
		end

		AnalyticManager.ActivityPopBaseLayer({
			openUrl = true,
			popid = self._id,
			channelid = var_17_1
		})
	end)
end

local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = 3
local var_0_7 = 4
local var_0_8 = 5

function ActivityPopBaseLayer:onButtonInfo()
	local var_22_0 = activity_manager:get_activity_pop_showinfo(self._id)

	if not var_22_0 then
		return
	end

	if var_22_0.showtype == var_0_4 then
		self:onPopShowServant(var_22_0)
	elseif var_22_0.showtype == var_0_5 then
		self:onPopShowDetail(var_22_0)
	elseif var_22_0.showtype == var_0_7 then
		self:onJumpTo(var_22_0)
	elseif var_22_0.showtype == var_0_6 then
		self:onGetPopDrop()
	elseif var_22_0.showtype == var_0_8 then
		self:onGetPopRecharge()
	end
end

function ActivityPopBaseLayer:onButtonInfo2()
	local var_23_0 = activity_manager:get_activity_pop_showinfo2(self._id)

	if not var_23_0 then
		return
	end

	if var_23_0.showtype == var_0_4 then
		self:onPopShowServant(var_23_0)
	elseif var_23_0.showtype == var_0_5 then
		self:onPopShowDetail(var_23_0)
	elseif var_23_0.showtype == var_0_7 then
		self:onJumpTo(var_23_0)
	elseif showinfo.showtype == var_0_6 then
		self:onGetPopDrop()
	end
end

function ActivityPopBaseLayer.onPopShowServant(arg_24_0, arg_24_1)
	LayerManager:pushInLayer("SoulsLayer", {
		defaultDisplayType = "preview",
		showtype = SHOW_TYPE_DROP_PREVIEW,
		cursoul = arg_24_1.showservant
	})
end

function ActivityPopBaseLayer.onPopShowDetail(arg_25_0, arg_25_1)
	LayerManager:pushInLayer("PopActivityDetail", {
		key = arg_25_1.showkey
	})
end

function ActivityPopBaseLayer.onJumpTo(arg_26_0, arg_26_1)
	if not arg_26_1.showkey and arg_26_1.showurl then
		DeviceManager.openURL(arg_26_1.showurl)

		return
	end

	goto_complete_system({
		jump_to_system = arg_26_1.showkey
	})
end

function ActivityPopBaseLayer:onButtonSure()
	local var_27_0 = activity_manager:get_activity_pop_showinfo(self._id)

	if not var_27_0 then
		return
	end

	AnalyticManager.clickPopWindowsbtn({
		showtype = var_27_0.showtype
	})

	if var_27_0.showtype == var_0_6 then
		self:onGetPopDrop()
	elseif var_27_0.showtype == var_0_8 then
		self:onGetPopRecharge()
	else
		self:onButtonGoTo()
	end
end

function ActivityPopBaseLayer:onButtonGoTo()
	local var_28_0 = activity_manager:get_activity_pop_jump(self._id)

	if not var_28_0 then
		return
	end

	if string.find(var_28_0, "http") then
		DeviceManager.openURL(var_28_0)

		return
	end

	local var_28_1 = {
		jump_to_system = var_28_0
	}

	var_28_1.config = system_jump_config[SYSTEMID[var_28_0]] and system_jump_config[SYSTEMID[var_28_0]].config

	goto_complete_system(var_28_1)
end

function ActivityPopBaseLayer:onGetPopDrop()
	if self._getingdrop then
		return
	end

	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("ON_GET_POP_DROP", function(arg_30_0)
		if arg_30_0.id ~= self._id then
			return
		end

		if arg_30_0.result then
			local var_30_0 = config._DEBUG and var_0_1 .. var_0_2 .. self._id .. "/btn_got.png" or var_0_2 .. self._id .. "/btn_got.png"

			self.btnGoto:loadTextures(var_30_0, var_30_0, var_30_0, var_0_0)
		end
	end), self)

	if activity_manager:get_activity_pop_drop(self._id) then
		self._getingdrop = true
	end
end

function ActivityPopBaseLayer:onGetPopRecharge()
	if self._getingrecharge then
		return
	end

	local var_31_0

	if self._gotrecharge then
		do return end

		var_31_0 = self:getEventDispatcher()
	end

	var_31_0:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_32_0)
		if arg_32_0.id ~= activity_manager:get_activity_pop_rechargeid(self._id) then
			return
		end

		local var_32_0 = config._DEBUG and var_0_1 .. var_0_2 .. self._id .. "/btn_got.png" or var_0_2 .. self._id .. "/btn_got.png"

		self.btnGoto:loadTextures(var_32_0, var_32_0, var_32_0, var_0_0)

		self._gotrecharge = true
	end), self)
	var_31_0:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_fail", function(arg_33_0)
		if arg_33_0.id ~= activity_manager:get_activity_pop_rechargeid(self._id) then
			return
		end

		self._getingrecharge = false
	end), self)

	if activity_manager:get_activity_pop_recharge(self._id) then
		self._getingrecharge = true
	end
end
