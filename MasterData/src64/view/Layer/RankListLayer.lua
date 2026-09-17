RankListLayer = class("RankListLayer", function()
	return cc.Layer:create()
end)

local net_dispatcher = require("network.net_dispatcher")
local network = require("network.network")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local friend_system_manager = require("controller.friend_system_manager")
local souls_manager = require("controller.souls_manager")

require("view.Sprite.BottomBtnList")
require("view.Sprite.AvatarSprite")

function RankListLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = RankListLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function RankListLayer:init(arg_3_1)
	TopcostLayer.getInstance():hideTopcostLayer()

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "RankList.json" or "RankList.ExportJson")

	self:addChild(self.rootLayer)

	self.Panel_top = ccui.Helper:seekWidgetByName(self.rootLayer, "bg_top")

	ccui.Helper:seekWidgetByName(self.rootLayer, "bg"):loadTexture("mainScenebg/rankbg.jpg")

	self.bg = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")

	self.bg:setAnchorPoint(cc.p(0.5, 0.5))
	self.bg:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))

	self.myrank = ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_my")
	self.RLScroll = ccui.Helper:seekWidgetByName(self.rootLayer, "scrollview")
	self.rank = ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_bg")

	self.rank:retain()
	self.rank:removeFromParent()
	self.RLScroll:removeAllChildren()
	self.RLScroll:setContentSize(cc.size(640, 907 + (GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT)))
	self.RLScroll:setInnerContainerSize(cc.size(640, 6240))
	self.RLScroll:setBounceEnabled(true)
	self:DisplayRankList()
	self:initBottomList()
	self:MyRankNoShow()
	self:fullScreen(self.rootLayer)
end

function RankListLayer:initBottomList()
	local var_4_0 = BottomBtnList:create(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_5_0 = cc.EventCustom:new("switchShowLayer")

		var_5_0.layerName = "ArenaLayer"

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_5_0)
	end)

	var_4_0:setName("bottomlist")
	self:addChild(var_4_0, 10)

	self.bottomList = var_4_0
end

local var_0_9 = {}
local var_0_10 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_11 = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 0, 0, 150)
}

function RankListLayer.DisplayRankList(arg_6_0)
	local var_6_0 = 120

	network:rpc("get_rank_data", {
		count = 50,
		start = 1
	}, function(arg_7_0)
		for iter_7_0 = 1, 50 do
			if arg_7_0.data[iter_7_0] then
				var_0_9[iter_7_0] = arg_6_0.rank:clone()

				local var_7_0 = var_0_9[iter_7_0]:getChildByName("panel_icon")
				local var_7_1 = ccui.Helper:seekWidgetByName(var_0_9[iter_7_0], "label_name")
				local var_7_2 = ccui.Helper:seekWidgetByName(var_0_9[iter_7_0], "label_No")
				local var_7_3 = var_7_0:getChildByName("avatar")
				local var_7_4 = ccui.Helper:seekWidgetByName(var_0_9[iter_7_0], "star")

				var_7_0:setTouchEnabled(false)

				if not var_7_3 then
					var_7_3 = AvatarSprite:create(tonumber(arg_7_0.data[iter_7_0].head_sculpture))

					var_0_9[iter_7_0]:addChild(var_7_3)
					var_7_3:setName("avatar")
					var_7_3:setScale(0.65)
					var_7_3:setPosition(cc.p(-10, 0))
				else
					var_7_3:switchShowAvatar(tonumber(arg_7_0.data[iter_7_0].head_sculpture))
				end

				var_0_9[iter_7_0]:addTouchEventListener(function(arg_8_0, arg_8_1)
					local var_8_0

					if arg_8_1 ~= ccui.TouchEventType.ended then
						do return end

						var_8_0 = {
							pvptype = 2,
							playeruid = arg_7_0.data[iter_7_0].playerid
						}
					end

					function var_8_0.callback()
						return
					end

					LayerManager:pushInLayer("PopFriendIntroduceLayer", var_8_0)
				end)
				var_7_3:addTouchEventListener(function(arg_10_0, arg_10_1)
					local var_10_0

					if arg_10_1 ~= ccui.TouchEventType.ended then
						do return end

						var_10_0 = {
							pvptype = 2,
							playeruid = arg_7_0.data[iter_7_0].playerid
						}
					end

					function var_10_0.callback()
						return
					end

					LayerManager:pushInLayer("PopFriendIntroduceLayer", var_10_0)
				end)
				var_7_0:getChildByName("image_icon"):setVisible(false)

				if not arg_7_0.data[iter_7_0].star then
					ccui.Helper:seekWidgetByName(var_0_9[iter_7_0], "Image_29"):setVisible(false)
					var_7_4:setVisible(false)
				else
					ccui.Helper:seekWidgetByName(var_0_9[iter_7_0], "Image_29"):setVisible(true)
					var_7_4:setVisible(true)
					var_7_4:setString(arg_7_0.data[iter_7_0].star)
				end

				var_7_1:setString(arg_7_0.data[iter_7_0].name)
				var_7_2:setString(arg_7_0.data[iter_7_0].rank)

				local var_7_5 = {}

				var_7_5[1] = arg_7_0.data[iter_7_0].medal_1 or 0
				var_7_5[2] = arg_7_0.data[iter_7_0].medal_2 or 0
				var_7_5[3] = arg_7_0.data[iter_7_0].medal_3 or 0

				for iter_7_1 = 1, 3 do
					if var_7_5[iter_7_1] == 0 then
						var_0_9[iter_7_0]:getChildByName("medal_" .. iter_7_1):setVisible(false)
					else
						local var_7_6 = var_0_9[iter_7_0]:getChildByName("medal_" .. iter_7_1)

						var_7_6:setVisible(true)

						if not var_7_6:getChildByName("medalname") then
							local var_7_7 = cc.Label:createWithTTF("", FONT_DES, 54)

							var_7_7:setAnchorPoint(cc.p(0.5, 0.5))
							var_7_7:setPosition(cc.p(var_7_6:getContentSize().width / 2 + 10, var_7_6:getContentSize().height / 2))
							var_7_7:setName("medalname")
							var_7_6:addChild(var_7_7)
						end

						local var_7_8 = item_data[var_7_5[iter_7_1]] or item_data[9100011]

						var_7_6:loadTexture((var_7_8.bg or nil) and ("equipment/" .. var_7_8.bg .. ".png" or var_0_10[var_7_8.equip_quality]))
						var_7_6:getChildByName("medalname"):setString(var_7_8.name)
						var_7_6:getChildByName("medalname"):enableOutline(var_0_11[var_7_8.equip_quality], 1)
						var_7_6:getChildByName("medalname"):enableShadow(var_0_11[var_7_8.equip_quality], cc.size(0, 0))
						var_7_6:getChildByName("medalname"):setVisible(var_7_8.only_bg ~= 1)
					end
				end
			end

			if var_0_9[iter_7_0] then
				var_0_9[iter_7_0]:setPosition(cc.p(34, 51 * var_6_0 - var_6_0 * iter_7_0 + 55 + 70))

				if var_0_9[iter_7_0] then
					arg_6_0.RLScroll:addChild(var_0_9[iter_7_0])
				end

				var_0_9[iter_7_0]:setOpacity(0)
			end
		end

		local function var_7_9(arg_12_0)
			if arg_12_0 > #var_0_9 then
				return
			end

			if arg_12_0 <= 10 then
				var_0_9[arg_12_0]:runAction(cc.Sequence:create(cc.FadeIn:create(0.01), cc.DelayTime:create(0.01), cc.CallFunc:create(function()
					var_7_9(arg_12_0 + 1)
				end)))
			else
				var_0_9[arg_12_0]:setOpacity(255)
				var_7_9(arg_12_0 + 1)
			end
		end

		if var_0_9 and #var_0_9 > 0 then
			var_7_9(1)
		end
	end)
end

function RankListLayer:MyRankNoShow()
	local var_14_0 = self.myrank:getChildByName("label_No")
	local var_14_1 = self.myrank:getChildByName("label_name")
	local var_14_2 = self.myrank:getChildByName("panel_icon")
	local var_14_3 = var_14_2:getChildByName("avatar")
	local var_14_4 = self.myrank:getChildByName("star")
	local var_14_5 = playermodel.nickname

	var_14_2:getChildByName("image_icon"):setVisible(false)
	var_14_0:setString("查询中...")

	if not var_14_3 then
		local var_14_6 = AvatarSprite:create(playermodel.head_sculpture)

		var_14_2:addChild(var_14_6)
		var_14_6:setName("avatar")
		var_14_6:setPosition(cc.p(58, 60))
	else
		var_14_3:switchShowAvatar(tonumber(msg.data[i].head_sculpture))
	end

	local var_14_7 = {}

	var_14_7[1] = playermodel.cur_medal[1] or 0
	var_14_7[2] = playermodel.cur_medal[2] or 0
	var_14_7[3] = playermodel.cur_medal[3] or 0

	for iter_14_0 = 1, 3 do
		if var_14_7[iter_14_0] == 0 then
			self.myrank:getChildByName("medal_" .. iter_14_0):setVisible(false)
		else
			local var_14_8 = self.myrank:getChildByName("medal_" .. iter_14_0)

			var_14_8:setVisible(true)

			if not var_14_8:getChildByName("medalname") then
				local var_14_9 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_14_9:setAnchorPoint(cc.p(0.5, 0.5))
				var_14_9:setPosition(cc.p(var_14_8:getContentSize().width / 2 + 10, var_14_8:getContentSize().height / 2))
				var_14_9:setName("medalname")
				var_14_8:addChild(var_14_9)
			end

			local var_14_10 = item_data[var_14_7[iter_14_0]] or item_data[9100011]

			var_14_8:loadTexture((var_14_10.bg or nil) and ("equipment/" .. var_14_10.bg .. ".png" or var_0_10[var_14_10.equip_quality]))
			var_14_8:getChildByName("medalname"):setString(var_14_10.name)
			var_14_8:getChildByName("medalname"):enableOutline(var_0_11[var_14_10.equip_quality], 1)
			var_14_8:getChildByName("medalname"):enableShadow(var_0_11[var_14_10.equip_quality], cc.size(0, 0))
			var_14_8:getChildByName("medalname"):setVisible(var_14_10.only_bg ~= 1)
		end
	end

	var_14_4:setString(souls_manager:get_total_contract_attr())
	var_14_1:setString(var_14_5)
	network:rpc("get_player_rank", nil, function(arg_15_0)
		if arg_15_0.rank then
			local var_15_0 = tonumber(arg_15_0.rank)

			if var_15_0 < 0 then
				var_14_0:setString(L_PVP_RESULT_NO_RANK)
			else
				var_14_0:setString(var_15_0)
			end
		else
			var_14_0:setString(L_PVP_RESULT_NO_RANK)
		end
	end)
end

function RankListLayer:fullScreen(arg_16_1)
	arg_16_1:setContentSize((GameDisplay.getScreenSize()))
	arg_16_1:setPositionY(arg_16_1:getPositionY() - GameDisplay.fix_y)
	self.Panel_top:setPosition(cc.p(GameDisplay.getUiScreenSize().width / 2, GameDisplay.getUiScreenSize().height))
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end
