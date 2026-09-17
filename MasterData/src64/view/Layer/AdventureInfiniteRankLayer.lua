AdventureInfiniteRankLayer = class("AdventureInfiniteRankLayer", function()
	return cc.Layer:create()
end)

local net_dispatcher = require("network.net_dispatcher")
local network = require("network.network")
local var_0_2 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")

require("view.Sprite.BottomBtnList")
require("view.Sprite.AvatarSprite")

local level_manager = require("controller.level_manager")
local souls_manager = require("controller.souls_manager")
local var_0_7 = 630
local var_0_8 = 124

function AdventureInfiniteRankLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = AdventureInfiniteRankLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function AdventureInfiniteRankLayer:init(arg_3_1)
	TopcostLayer.getInstance():hideTopcostLayer()

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ArenaRankingPanel.json" or "ArenaRankingPanel.ExportJson")

	self:addChild(self.rootLayer)

	self.score11 = arg_3_1.score or 0
	self.rank11 = arg_3_1.rank
	self.modetype = arg_3_1.modetype
	self.Panel_top = ccui.Helper:seekWidgetByName(self.rootLayer, "bg_top")

	ccui.Helper:seekWidgetByName(self.rootLayer, "bg"):loadTexture("mainScenebg/rankbg.jpg")

	self.bg = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")

	self.bg:setAnchorPoint(cc.p(0.5, 0.5))
	self.bg:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))

	self.myrank = ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_my")

	self.myrank:setLocalZOrder(100)
	self.myrank:setVisible(false)
	self.myrank:setPositionY(self.myrank:getPositionY() + 18)

	self.RLScroll = ccui.Helper:seekWidgetByName(self.rootLayer, "scrollview")

	self.RLScroll:setVisible(false)
	self:DisplayRankList()
	self:initBottomList()

	local var_3_0 = GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

	self.roleTableView = cc.TableView:create(cc.size(640, 900 + var_3_0))

	self.roleTableView:setPosition(cc.p(0, 168))
	self.roleTableView:setDelegate()
	self.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rootLayer:addChild(self.roleTableView)
	self.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.rootLayer:setName("self.roleTableView")

	self.tableviewhight = 900 + var_3_0

	self:MyRankNoShow()
	self:fullScreen(self.rootLayer)
end

function AdventureInfiniteRankLayer:initBottomList()
	local var_4_0 = BottomBtnList:create(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	var_4_0:setName("bottomlist")
	self:addChild(var_4_0, 10)

	self.bottomList = var_4_0
end

local var_0_10 = {
	"arenascenenew/rank_1.png",
	"arenascenenew/rank_2.png",
	"arenascenenew/rank_3.png",
	"arenascenenew/rank_4.png"
}
local var_0_12 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_13 = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 0, 0, 150)
}

function AdventureInfiniteRankLayer:createNode()
	local var_6_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_bg"):clone()

	var_6_0:setTouchEnabled(false)

	local var_6_1 = var_6_0:getChildByName("image_icon")

	var_6_1:setScale(0.65)
	var_6_1:setPositionX(var_6_1:getPositionX() - 30)
	var_6_1:setVisible(false)

	local var_6_2 = AvatarSprite:create(9200101)

	var_6_2:setPosition(cc.p(var_6_1:getPositionX() - 40, 0))
	var_6_2:setName("avatar_new")
	var_6_2:setScale(0.65)
	var_6_0:addChild(var_6_2)

	local var_6_3 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_6_3:setName("title_label")
	var_6_3:setAnchorPoint(cc.p(0, 0))

	local var_6_4 = var_6_0:getChildByName("label_name")

	var_6_3:setPosition(var_6_4:getPositionX(), var_6_0:getChildByName("label_No_0").getPositionY(var_6_4))
	var_6_0:addChild(var_6_3)

	return var_6_0
end

function AdventureInfiniteRankLayer.updateNode(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = ccui.Helper:seekWidgetByName(arg_7_1, "label_No")
	local var_7_1 = arg_7_1:getChildByName("image_icon")
	local var_7_2 = arg_7_1:getChildByName("avatar_new")
	local var_7_3 = arg_7_1:getChildByName("star_icon")
	local var_7_4 = arg_7_1:getChildByName("star")

	arg_7_1:getChildByName("title_label"):setString(L_AVAON_VISUAL.score_tips .. ":")
	ccui.Helper:seekWidgetByName(arg_7_1, "label_No_0"):setString(global_trans_number(arg_7_2.score))
	var_7_0:setVisible(true)

	local var_7_5 = var_0_10[4]

	for iter_7_0 = 1, 3 do
		if arg_7_2.rank == iter_7_0 then
			var_7_5 = var_0_10[iter_7_0]

			var_7_0:setVisible(false)

			break
		end
	end

	arg_7_1:setBackGroundImage(var_7_5, var_0_2)
	var_7_2:switchShowAvatar(tonumber(arg_7_2.head_sculpture))
	var_7_2:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_8_0

		if arg_7_2.playerid <= 0 then
			do return end

			var_8_0 = {
				playeruid = arg_7_2.playerid
			}
		end

		function var_8_0.callback()
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", var_8_0)
	end)
	ccui.Helper:seekWidgetByName(arg_7_1, "label_name"):setString(arg_7_2.name)
	var_7_0:setString(arg_7_2.rank)

	local var_7_6 = {}

	var_7_6[1] = arg_7_2.medal_1 or 0
	var_7_6[2] = arg_7_2.medal_2 or 0
	var_7_6[3] = arg_7_2.medal_3 or 0

	for iter_7_1 = 1, 3 do
		if var_7_6[iter_7_1] == 0 then
			arg_7_1:getChildByName("medal_" .. iter_7_1):setVisible(false)
		else
			local var_7_7 = arg_7_1:getChildByName("medal_" .. iter_7_1)

			var_7_7:setVisible(true)

			if not var_7_7:getChildByName("medalname") then
				local var_7_8 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_7_8:setAnchorPoint(cc.p(0.5, 0.5))
				var_7_8:setPosition(cc.p(var_7_7:getContentSize().width / 2 + 10, var_7_7:getContentSize().height / 2))
				var_7_8:setName("medalname")
				var_7_7:addChild(var_7_8)
			end

			local var_7_9 = item_data[var_7_6[iter_7_1]] or item_data[9100011]

			var_7_7:loadTexture((var_7_9.bg or nil) and ("equipment/" .. var_7_9.bg .. ".png" or var_0_12[var_7_9.equip_quality]))
			var_7_7:getChildByName("medalname"):setString(var_7_9.name)
			var_7_7:getChildByName("medalname"):enableOutline(var_0_13[var_7_9.equip_quality], 1)
			var_7_7:getChildByName("medalname"):enableShadow(var_0_13[var_7_9.equip_quality], cc.size(0, 0))
			var_7_7:getChildByName("medalname"):setVisible(var_7_9.only_bg ~= 1)
		end
	end

	if not arg_7_2.star then
		var_7_3:setVisible(false)
		var_7_4:setVisible(false)
	else
		var_7_3:setVisible(true)
		var_7_4:setVisible(true)
		var_7_4:setString(arg_7_2.star)
	end
end

function AdventureInfiniteRankLayer:initTableView()
	self.roleTableView:registerScriptHandler(function(arg_12_0, arg_12_1)
		return var_0_7, var_0_8
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_0:dequeueCell()

		if not var_11_0 then
			var_11_0 = cc.TableViewCell:create()

			local var_11_1 = self:createNode()

			var_11_1:setName("node")
			var_11_1:setPosition(cc.p(5, 0))
			self:updateNode(var_11_1, self.data[arg_11_1 + 1])

			if arg_11_1 <= math.floor(self.tableviewhight / var_0_8) then
				var_11_1:setOpacity(0)
				var_11_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_11_1), cc.FadeIn:create(0.1)))
			else
				var_11_1:setOpacity(255)
			end

			var_11_0:addChild(var_11_1)
		else
			local var_11_2 = var_11_0:getChildByName("node")

			var_11_2:setOpacity(255)
			self:updateNode(var_11_2, self.data[arg_11_1 + 1])
		end

		return var_11_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_13_0, arg_13_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()
end

function AdventureInfiniteRankLayer:DisplayRankList()
	level_manager:get_adventure_score_ranklist(nil, self.modetype, 1, 100, function(arg_15_0, arg_15_1)
		if arg_15_0 == 1 then
			self.data = arg_15_1

			self:initTableView()
		end
	end)
end

function AdventureInfiniteRankLayer:MyRankNoShow()
	self.myrank:setVisible(true)

	local var_16_0 = self.myrank:getChildByName("label_No")
	local var_16_1 = self.myrank:getChildByName("no_ranking")
	local var_16_2 = self.myrank:getChildByName("image_icon")
	local var_16_3 = self.myrank:getChildByName("label_rankjifen"):getChildByName("Label_71")

	self.myrank:getChildByName("label_rankjifen"):setString(L_AVAON_VISUAL.score_tips .. ":")
	var_16_3:setString(self.score11)
	var_16_3:setPositionY(var_16_3:getPositionY() + 5)
	var_16_2:setVisible(false)

	local var_16_4 = AvatarSprite:create(tonumber(playermodel.head_sculpture))

	var_16_4:setPosition(cc.p(var_16_2:getPositionX() - 40, 0))
	var_16_4:setName("icon_bg_new")
	var_16_4:setScale(0.5)
	self.myrank:addChild(var_16_4)

	local var_16_5 = {}

	var_16_5[1] = playermodel.cur_medal[1] or 0
	var_16_5[2] = playermodel.cur_medal[2] or 0
	var_16_5[3] = playermodel.cur_medal[3] or 0

	for iter_16_0 = 1, 3 do
		if var_16_5[iter_16_0] == 0 then
			self.myrank:getChildByName("medal_" .. iter_16_0):setVisible(false)
		else
			local var_16_6 = self.myrank:getChildByName("medal_" .. iter_16_0)

			var_16_6:setVisible(true)

			if not var_16_6:getChildByName("medalname") then
				local var_16_7 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_16_7:setAnchorPoint(cc.p(0.5, 0.5))
				var_16_7:setPosition(cc.p(var_16_6:getContentSize().width / 2 + 10, var_16_6:getContentSize().height / 2))
				var_16_7:setName("medalname")
				var_16_6:addChild(var_16_7)
			end

			local var_16_8 = item_data[var_16_5[iter_16_0]] or item_data[9100011]

			var_16_6:loadTexture((var_16_8.bg or nil) and ("equipment/" .. var_16_8.bg .. ".png" or var_0_12[var_16_8.equip_quality]))
			var_16_6:getChildByName("medalname"):setString(var_16_8.name)
			var_16_6:getChildByName("medalname"):enableOutline(var_0_13[var_16_8.equip_quality], 1)
			var_16_6:getChildByName("medalname"):enableShadow(var_0_13[var_16_8.equip_quality], cc.size(0, 0))
			var_16_6:getChildByName("medalname"):setVisible(var_16_8.only_bg ~= 1)
		end
	end

	self.myrank:getChildByName("label_name"):setString(playermodel.nickname)
	self.myrank:getChildByName("star"):setString(souls_manager:get_total_contract_attr())

	if self.rank11 and type(self.rank11) == "number" then
		if tonumber(self.rank11) <= 100 and tonumber(self.rank11) > 0 then
			var_16_0:setVisible(true)
			var_16_1:setVisible(false)
			var_16_0:setString("" .. self.rank11)
		else
			var_16_0:setVisible(false)
			var_16_1:setVisible(true)
		end
	else
		var_16_0:setVisible(false)
		var_16_1:setVisible(true)
	end
end

function AdventureInfiniteRankLayer:fullScreen(arg_17_1)
	arg_17_1:setContentSize((GameDisplay.getScreenSize()))
	arg_17_1:setPositionY(arg_17_1:getPositionY() - GameDisplay.fix_y)
	self.Panel_top:setPosition(cc.p(GameDisplay.getUiScreenSize().width / 2, GameDisplay.getUiScreenSize().height))
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end
