LevelRankListLayer = class("LevelRankListLayer", function()
	return cc.Layer:create()
end)

local net_dispatcher = require("network.net_dispatcher")
local chapter_data = require("data.chapter_data")
local network = require("network.network")
local var_0_3 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")

require("view.Sprite.BottomBtnList")
require("view.Sprite.AvatarSprite")

local level_manager = require("controller.level_manager")
local var_0_7 = 630
local var_0_8 = 124

function LevelRankListLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = LevelRankListLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function LevelRankListLayer:init(arg_3_1)
	TopcostLayer.getInstance():hideTopcostLayer()

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ArenaRankingPanel.json" or "ArenaRankingPanel.ExportJson")

	self:addChild(self.rootLayer)

	self.mode = arg_3_1.mode
	self.Panel_top = ccui.Helper:seekWidgetByName(self.rootLayer, "bg_top")

	local var_3_0 = cc.Label:createWithTTF(level_manager:getModeName(self.mode) .. "·" .. L_MODE_DIFFICULTY[4] .. chapter_data[self.mode .. "-10"].name, FONT_BUTTON, 24)

	var_3_0:setAnchorPoint(cc.p(1, 0.5))
	var_3_0:setColor(cc.c3b(179, 224, 255))
	var_3_0:setPosition(630, self.Panel_top:getContentSize().height / 2)
	self.Panel_top:addChild(var_3_0)
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

	local var_3_1 = GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

	self.roleTableView = cc.TableView:create(cc.size(640, 900 + var_3_1))

	self.roleTableView:setPosition(cc.p(0, 168))
	self.roleTableView:setDelegate()
	self.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rootLayer:addChild(self.roleTableView)
	self.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.rootLayer:setName("self.roleTableView")

	self.tableviewhight = 900 + var_3_1

	if not self.rank11 then
		level_manager:getPlayerLevelRank(self.mode, function(arg_4_0)
			self:MyRankNoShow(arg_4_0)
		end)
	else
		self:MyRankNoShow()
	end

	self:fullScreen(self.rootLayer)
end

function LevelRankListLayer:initBottomList()
	local var_5_0 = BottomBtnList:create(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)

	var_5_0:setName("bottomlist")
	self:addChild(var_5_0, 10)

	self.bottomList = var_5_0
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

function LevelRankListLayer:createNode()
	local var_7_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_bg"):clone()

	var_7_0:setTouchEnabled(false)

	local var_7_1 = var_7_0:getChildByName("image_icon")

	var_7_1:setScale(0.65)
	var_7_1:setPositionX(var_7_1:getPositionX() - 30)

	local var_7_2 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_7_2:setName("title_label")
	var_7_2:setAnchorPoint(cc.p(0, 0))

	local var_7_3 = var_7_0:getChildByName("label_name")

	var_7_2:setPosition(var_7_3:getPositionX(), var_7_0:getChildByName("label_No_0").getPositionY(var_7_3))
	var_7_0:addChild(var_7_2)

	return var_7_0
end

function LevelRankListLayer:updateNode(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = ccui.Helper:seekWidgetByName(arg_8_1, "label_name")
	local var_8_1 = ccui.Helper:seekWidgetByName(arg_8_1, "label_No")
	local var_8_2 = arg_8_1:getChildByName("avatar")

	ccui.Helper:seekWidgetByName(arg_8_1, "label_No_0"):setString(os.date("%Y/%m/%d %X", arg_8_2.passtime))
	arg_8_1:getChildByName("title_label"):setString(L_PASS_TIME)
	var_8_1:setVisible(true)

	local var_8_3 = var_0_10[4]

	for iter_8_0 = 1, 3 do
		if arg_8_3 == iter_8_0 then
			var_8_3 = var_0_10[iter_8_0]

			var_8_1:setVisible(false)

			break
		end
	end

	arg_8_1:setBackGroundImage(var_8_3, var_0_3)
	arg_8_1:getChildByName("image_icon"):setVisible(false)

	if not var_8_2 then
		var_8_2 = AvatarSprite:create(tonumber(arg_8_2.head_sculpture))

		var_8_2:setName("avatar")
		var_8_2:setScale(0.65)
		var_8_2:setPositionX(80)
		arg_8_1:addChild(var_8_2)
	else
		var_8_2:switchShowAvatar(tonumber(arg_8_2.head_sculpture))
	end

	var_8_0:setString(arg_8_2.name)
	var_8_1:setString(arg_8_3)

	local var_8_4 = {}

	var_8_4[1] = arg_8_2.medal_1 or 0
	var_8_4[2] = arg_8_2.medal_2 or 0
	var_8_4[3] = arg_8_2.medal_3 or 0

	for iter_8_1 = 1, 3 do
		if var_8_4[iter_8_1] == 0 then
			arg_8_1:getChildByName("medal_" .. iter_8_1):setVisible(false)
		else
			local var_8_5 = arg_8_1:getChildByName("medal_" .. iter_8_1)

			var_8_5:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_bg"):getChildByName("medal_" .. iter_8_1):getPositionY() + 18)
			var_8_5:setVisible(true)

			if not var_8_5:getChildByName("medalname") then
				local var_8_6 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_8_6:setAnchorPoint(cc.p(0.5, 0.5))
				var_8_6:setPosition(cc.p(var_8_5:getContentSize().width / 2 + 10, var_8_5:getContentSize().height / 2))
				var_8_6:setName("medalname")
				var_8_5:addChild(var_8_6)
			end

			local var_8_7 = item_data[var_8_4[iter_8_1]] or item_data[9100011]

			var_8_5:loadTexture((var_8_7.bg or nil) and ("equipment/" .. var_8_7.bg .. ".png" or var_0_12[var_8_7.equip_quality]))
			var_8_5:getChildByName("medalname"):setString(var_8_7.name)
			var_8_5:getChildByName("medalname"):enableOutline(var_0_13[var_8_7.equip_quality], 1)
			var_8_5:getChildByName("medalname"):enableShadow(var_0_13[var_8_7.equip_quality], cc.size(0, 0))
			var_8_5:getChildByName("medalname"):setVisible(var_8_7.only_bg ~= 1)
		end
	end
end

function LevelRankListLayer:initTableView()
	self.roleTableView:registerScriptHandler(function(arg_11_0, arg_11_1)
		return var_0_7, var_0_8
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_0:dequeueCell()

		if not var_10_0 then
			var_10_0 = cc.TableViewCell:create()

			local var_10_1 = self:createNode()

			var_10_1:setName("node")
			var_10_1:setPosition(cc.p(5, 0))
			self:updateNode(var_10_1, self.data[arg_10_1 + 1], arg_10_1 + 1)

			if arg_10_1 <= math.floor(self.tableviewhight / var_0_8) then
				var_10_1:setOpacity(0)
				var_10_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_10_1), cc.FadeIn:create(0.1)))
			else
				var_10_1:setOpacity(255)
			end

			var_10_0:addChild(var_10_1)
		else
			local var_10_2 = var_10_0:getChildByName("node")

			var_10_2:setOpacity(255)
			self:updateNode(var_10_2, self.data[arg_10_1 + 1], arg_10_1 + 1)
		end

		return var_10_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_12_0, arg_12_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()
end

function LevelRankListLayer:DisplayRankList()
	level_manager:getLevelRankList(self.mode, function(arg_14_0)
		self.data = arg_14_0

		self:initTableView()
	end)
end

function LevelRankListLayer:MyRankNoShow(arg_15_1)
	self.myrank:setVisible(true)

	local var_15_0 = self.myrank:getChildByName("label_No")
	local var_15_1 = self.myrank:getChildByName("no_ranking")
	local var_15_2 = self.myrank:getChildByName("label_name")
	local var_15_3 = self.myrank:getChildByName("image_icon")
	local var_15_4 = playermodel.nickname

	self.myrank:getChildByName("label_rankjifen"):setString(L_PASS_TIME)

	local var_15_5 = self.myrank:getChildByName("label_rankjifen"):getChildByName("Label_71")

	if arg_15_1 and arg_15_1.time then
		var_15_5:setString(arg_15_1.time)
	else
		var_15_5:setString("----")
	end

	var_15_5:setPositionY(var_15_5:getPositionY() + 5)
	var_15_3:setVisible(false)

	local var_15_6 = AvatarSprite:create(playermodel.head_sculpture)

	var_15_6:setScale(0.5)
	var_15_6:setPositionX(90)
	self.myrank:addChild(var_15_6)

	local var_15_7 = {}

	var_15_7[1] = playermodel.cur_medal[1] or 0
	var_15_7[2] = playermodel.cur_medal[2] or 0
	var_15_7[3] = playermodel.cur_medal[3] or 0

	for iter_15_0 = 1, 3 do
		if var_15_7[iter_15_0] == 0 then
			self.myrank:getChildByName("medal_" .. iter_15_0):setVisible(false)
		else
			local var_15_8 = self.myrank:getChildByName("medal_" .. iter_15_0)

			var_15_8:setPositionY(var_15_8:getPositionY() + 22)
			var_15_8:setVisible(true)

			if not var_15_8:getChildByName("medalname") then
				local var_15_9 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_15_9:setAnchorPoint(cc.p(0.5, 0.5))
				var_15_9:setPosition(cc.p(var_15_8:getContentSize().width / 2 + 10, var_15_8:getContentSize().height / 2))
				var_15_9:setName("medalname")
				var_15_8:addChild(var_15_9)
			end

			local var_15_10 = item_data[var_15_7[iter_15_0]] or item_data[9100011]

			var_15_8:loadTexture((var_15_10.bg or nil) and ("equipment/" .. var_15_10.bg .. ".png" or var_0_12[var_15_10.equip_quality]))
			var_15_8:getChildByName("medalname"):setString(var_15_10.name)
			var_15_8:getChildByName("medalname"):enableOutline(var_0_13[var_15_10.equip_quality], 1)
			var_15_8:getChildByName("medalname"):enableShadow(var_0_13[var_15_10.equip_quality], cc.size(0, 0))
			var_15_8:getChildByName("medalname"):setVisible(var_15_10.only_bg ~= 1)
		end
	end

	var_15_2:setString(var_15_4)

	if arg_15_1 then
		self.rank11 = arg_15_1.rank + 1
	end

	if not self.rank11 or self.rank11 == 0 then
		self.rank11 = L_SCORE_AREAN_NO_RANK
	end

	if self.rank11 and type(self.rank11) == "number" then
		if tonumber(self.rank11) <= 100 and tonumber(self.rank11) > 0 then
			var_15_0:setVisible(true)
			var_15_1:setVisible(false)
			var_15_0:setString(self.rank11)
		else
			var_15_0:setVisible(false)
			var_15_1:setVisible(true)
		end
	else
		var_15_0:setVisible(false)
		var_15_1:setVisible(true)
	end
end

function LevelRankListLayer:fullScreen(arg_16_1)
	arg_16_1:setContentSize((GameDisplay.getScreenSize()))
	arg_16_1:setPositionY(arg_16_1:getPositionY() - GameDisplay.fix_y)
	self.Panel_top:setPosition(cc.p(GameDisplay.getUiScreenSize().width / 2, GameDisplay.getUiScreenSize().height))
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end
