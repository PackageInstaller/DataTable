AdventureRankingPanel = class("AdventureRankingPanel", function()
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
local var_0_6 = 630
local var_0_7 = 124

function AdventureRankingPanel.create(arg_2_0, arg_2_1)
	local var_2_0 = AdventureRankingPanel.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function AdventureRankingPanel:init(arg_3_1)
	TopcostLayer.getInstance():hideTopcostLayer()

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "AdventureRankingPanel.json" or "AdventureRankingPanel.ExportJson")

	self:addChild(self.rootLayer)

	if arg_3_1 then
		self.modetype = arg_3_1.modetype or nil
	end

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

	level_manager:get_adventure_score(nil, self.modetype, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		if arg_4_0 == 1 then
			self:MyRankNoShow(arg_4_1, arg_4_3)
		end
	end)
	self.myrank:getChildByName("label_rankjifen"):setString(L_AVAON_VISUAL.score_tips)
	self:fullScreen(self.rootLayer)
end

function AdventureRankingPanel:initBottomList()
	local var_5_0 = BottomBtnList:create(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer("AdventurerVisualLayer")
	end)

	var_5_0:setName("bottomlist")
	self:addChild(var_5_0, 10)

	self.bottomList = var_5_0
end

local var_0_9 = {
	"adventure_score/rank_1.png",
	"adventure_score/rank_2.png",
	"adventure_score/rank_3.png",
	"adventure_score/rank_4.png"
}
local var_0_11 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_12 = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 0, 0, 150)
}

function AdventureRankingPanel:createNode()
	local var_7_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_bg"):clone()

	var_7_0:setTouchEnabled(false)

	local var_7_1 = var_7_0:getChildByName("image_icon")

	var_7_1:setScale(0.65)
	var_7_1:setPositionX(var_7_1:getPositionX() - 30)
	var_7_1:setVisible(false)

	local var_7_2 = AvatarSprite:create(9200101)

	var_7_2:setPosition(cc.p(var_7_1:getPositionX() - 40, 0))
	var_7_2:setName("avatar_new")
	var_7_2:setScale(0.65)
	var_7_0:addChild(var_7_2)

	local var_7_3 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_7_3:setName("title_label")
	var_7_3:setAnchorPoint(cc.p(0, 0))

	local var_7_4 = var_7_0:getChildByName("label_name")

	var_7_3:setPosition(var_7_4:getPositionX(), var_7_0:getChildByName("label_No_0").getPositionY(var_7_4))
	var_7_0:addChild(var_7_3)

	return var_7_0
end

function AdventureRankingPanel.updateNode(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = ccui.Helper:seekWidgetByName(arg_8_1, "label_No")
	local var_8_1 = arg_8_1:getChildByName("image_icon")
	local var_8_2 = arg_8_1:getChildByName("avatar_new")
	local var_8_3 = ccui.Helper:seekWidgetByName(arg_8_1, "label_No_0")

	arg_8_1:getChildByName("title_label"):setString(L_AVAON_VISUAL.score_tips)
	var_8_3:setString(global_trans_number(arg_8_2.score))
	var_8_3:setString(false)
	var_8_0:setVisible(true)

	local var_8_4 = var_0_9[4]

	for iter_8_0 = 1, 3 do
		if arg_8_2.rank == iter_8_0 then
			var_8_4 = var_0_9[iter_8_0]

			var_8_0:setVisible(false)

			break
		end
	end

	arg_8_1:setBackGroundImage(var_8_4, var_0_2)
	var_8_2:switchShowAvatar(tonumber(arg_8_2.head_sculpture))
	var_8_2:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_9_0

		if arg_8_2.playerid <= 0 then
			do return end

			var_9_0 = {
				playeruid = arg_8_2.playerid
			}
		end

		function var_9_0.callback()
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", var_9_0)
	end)
	ccui.Helper:seekWidgetByName(arg_8_1, "label_name"):setString(arg_8_2.name)
	var_8_0:setString(arg_8_2.rank)

	local var_8_5 = {}

	var_8_5[1] = arg_8_2.medal_1 or 0
	var_8_5[2] = arg_8_2.medal_2 or 0
	var_8_5[3] = arg_8_2.medal_3 or 0

	for iter_8_1 = 1, 3 do
		if var_8_5[iter_8_1] == 0 then
			arg_8_1:getChildByName("medal_" .. iter_8_1):setVisible(false)
		else
			local var_8_6 = arg_8_1:getChildByName("medal_" .. iter_8_1)

			var_8_6:setVisible(true)

			if not var_8_6:getChildByName("medalname") then
				local var_8_7 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_8_7:setAnchorPoint(cc.p(0.5, 0.5))
				var_8_7:setPosition(cc.p(var_8_6:getContentSize().width / 2 + 10, var_8_6:getContentSize().height / 2))
				var_8_7:setName("medalname")
				var_8_6:addChild(var_8_7)
			end

			local var_8_8 = item_data[var_8_5[iter_8_1]] or item_data[9100011]

			var_8_6:loadTexture((var_8_8.bg or nil) and ("equipment/" .. var_8_8.bg .. ".png" or var_0_11[var_8_8.equip_quality]))
			var_8_6:getChildByName("medalname"):setString(var_8_8.name)
			var_8_6:getChildByName("medalname"):enableOutline(var_0_12[var_8_8.equip_quality], 1)
			var_8_6:getChildByName("medalname"):enableShadow(var_0_12[var_8_8.equip_quality], cc.size(0, 0))
			var_8_6:getChildByName("medalname"):setVisible(var_8_8.only_bg ~= 1)
		end
	end
end

function AdventureRankingPanel:initTableView()
	self.roleTableView:registerScriptHandler(function(arg_13_0, arg_13_1)
		return var_0_6, var_0_7
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0:dequeueCell()

		if not var_12_0 then
			var_12_0 = cc.TableViewCell:create()

			local var_12_1 = self:createNode()

			var_12_1:setName("node")
			var_12_1:setPosition(cc.p(5, 0))
			self:updateNode(var_12_1, self.data[arg_12_1 + 1], arg_12_1 + 1)

			if arg_12_1 <= math.floor(self.tableviewhight / var_0_7) then
				var_12_1:setOpacity(0)
				var_12_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_12_1), cc.FadeIn:create(0.1)))
			else
				var_12_1:setOpacity(255)
			end

			var_12_0:addChild(var_12_1)
		else
			local var_12_2 = var_12_0:getChildByName("node")

			var_12_2:setOpacity(255)
			self:updateNode(var_12_2, self.data[arg_12_1 + 1], arg_12_1 + 1)
		end

		return var_12_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_14_0, arg_14_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()
end

function AdventureRankingPanel:DisplayRankList()
	level_manager:get_adventure_score_ranklist(nil, self.modetype, 1, 50, function(arg_16_0, arg_16_1)
		if arg_16_0 == 1 then
			self.data = arg_16_1

			self:initTableView()
		end
	end)
end

function AdventureRankingPanel:MyRankNoShow(arg_17_1, arg_17_2)
	self.myrank:setVisible(true)

	local var_17_0 = self.myrank:getChildByName("label_No")
	local var_17_1 = self.myrank:getChildByName("no_ranking")
	local var_17_2 = self.myrank:getChildByName("image_icon")
	local var_17_3 = self.myrank:getChildByName("label_rankjifen"):getChildByName("Label_71")

	var_17_3:setString(global_trans_number(arg_17_1))
	var_17_3:setPositionY(var_17_3:getPositionY() + 5)
	var_17_2:setVisible(false)

	local var_17_4 = AvatarSprite:create(tonumber(playermodel.head_sculpture))

	var_17_4:setPosition(cc.p(var_17_2:getPositionX() - 40, 0))
	var_17_4:setName("icon_bg_new")
	var_17_4:setScale(0.5)
	self.myrank:addChild(var_17_4)

	local var_17_5 = {}

	var_17_5[1] = playermodel.cur_medal[1] or 0
	var_17_5[2] = playermodel.cur_medal[2] or 0
	var_17_5[3] = playermodel.cur_medal[3] or 0

	for iter_17_0 = 1, 3 do
		if var_17_5[iter_17_0] == 0 then
			self.myrank:getChildByName("medal_" .. iter_17_0):setVisible(false)
		else
			local var_17_6 = self.myrank:getChildByName("medal_" .. iter_17_0)

			var_17_6:setVisible(true)

			if not var_17_6:getChildByName("medalname") then
				local var_17_7 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_17_7:setAnchorPoint(cc.p(0.5, 0.5))
				var_17_7:setPosition(cc.p(var_17_6:getContentSize().width / 2 + 10, var_17_6:getContentSize().height / 2))
				var_17_7:setName("medalname")
				var_17_6:addChild(var_17_7)
			end

			local var_17_8 = item_data[var_17_5[iter_17_0]] or item_data[9100011]

			var_17_6:loadTexture((var_17_8.bg or nil) and ("equipment/" .. var_17_8.bg .. ".png" or var_0_11[var_17_8.equip_quality]))
			var_17_6:getChildByName("medalname"):setString(var_17_8.name)
			var_17_6:getChildByName("medalname"):enableOutline(var_0_12[var_17_8.equip_quality], 1)
			var_17_6:getChildByName("medalname"):enableShadow(var_0_12[var_17_8.equip_quality], cc.size(0, 0))
			var_17_6:getChildByName("medalname"):setVisible(var_17_8.only_bg ~= 1)
		end
	end

	self.myrank:getChildByName("label_name"):setString(playermodel.nickname)

	if arg_17_2 then
		self.rank11 = arg_17_2
	end

	if not self.rank11 or self.rank11 == 0 then
		self.rank11 = L_SCORE_AREAN_NO_RANK
	end

	if self.rank11 and type(self.rank11) == "number" then
		if tonumber(self.rank11) <= 100 and tonumber(self.rank11) > 0 then
			var_17_0:setVisible(true)
			var_17_1:setVisible(false)
			var_17_0:setString(self.rank11)
		else
			var_17_0:setVisible(false)
			var_17_1:setVisible(true)
		end
	else
		var_17_0:setVisible(false)
		var_17_1:setVisible(true)
	end
end

function AdventureRankingPanel:fullScreen(arg_18_1)
	arg_18_1:setContentSize((GameDisplay.getScreenSize()))
	arg_18_1:setPositionY(arg_18_1:getPositionY() - GameDisplay.fix_y)
	self.Panel_top:setPosition(cc.p(GameDisplay.getUiScreenSize().width / 2, GameDisplay.getUiScreenSize().height))
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end
