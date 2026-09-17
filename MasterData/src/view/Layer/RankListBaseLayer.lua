RankListBaseLayer = class("RankListBaseLayer", function()
	return cc.Layer:create()
end)

local net_dispatcher = require("network.net_dispatcher")
local chapter_data = require("data.chapter_data")
local network = require("network.network")
local var_0_3 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")

require("view.Sprite.BottomBtnList")
require("view.Sprite.AvatarSprite")

local level_manager = require("controller.level_manager")
local activity_hexagon_dispel_manager = require("controller.activity_hexagon_dispel_manager")
local var_0_9 = 630
local var_0_10 = 124

function RankListBaseLayer.create(arg_2_0, arg_2_1)
	return (RankListBaseLayer.new())
end

function RankListBaseLayer.initData(arg_3_0, arg_3_1)
	arg_3_0.mode = arg_3_1.mode
end

function RankListBaseLayer:initUI()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ArenaRankingPanel.json" or "ArenaRankingPanel.ExportJson")

	self:addChild(self.rootLayer)
	ccui.Helper:seekWidgetByName(self.rootLayer, "bg"):loadTexture("mainScenebg/rankbg.jpg")

	self.Panel_top = ccui.Helper:seekWidgetByName(self.rootLayer, "bg_top")
	self.bg = ccui.Helper:seekWidgetByName(self.rootLayer, "bg")

	self.bg:setAnchorPoint(cc.p(0.5, 0.5))
	self.bg:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))

	self.myrank = ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_my")

	self.myrank:setLocalZOrder(100)
	self.myrank:setVisible(false)
	self.myrank:setPositionY(self.myrank:getPositionY() + 18)

	self.RLScroll = ccui.Helper:seekWidgetByName(self.rootLayer, "scrollview")

	self.RLScroll:setVisible(false)

	local var_4_0 = GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT

	self.roleTableView = cc.TableView:create(cc.size(640, 900 + var_4_0))

	self.roleTableView:setPosition(cc.p(0, 168))
	self.roleTableView:setDelegate()
	self.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rootLayer:addChild(self.roleTableView)
	self.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.rootLayer:setName("self.roleTableView")

	self.tableviewhight = 900 + var_4_0
end

function RankListBaseLayer:init(arg_5_1)
	self:initData(arg_5_1)
	self:initUI()
	self:DisplayRankList()
	self:initBottomList()
	self:initMyRank()
	self:fullScreen(self.rootLayer)
end

function RankListBaseLayer:initMyRank()
	if not self.rank11 then
		level_manager:getPlayerLevelRank(self.mode, function(arg_7_0)
			self:MyRankNoShow(arg_7_0)
		end)
	else
		self:MyRankNoShow()
	end
end

function RankListBaseLayer:initBottomList()
	local var_8_0 = BottomBtnList:create(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)

	var_8_0:setName("bottomlist")
	self:addChild(var_8_0, 10)

	self.bottomList = var_8_0
end

local var_0_12 = {
	"arenascenenew/rank_1.png",
	"arenascenenew/rank_2.png",
	"arenascenenew/rank_3.png",
	"arenascenenew/rank_4.png"
}
local var_0_14 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_15 = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 0, 0, 150)
}

function RankListBaseLayer:createNode()
	local var_10_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_bg"):clone()

	var_10_0:setTouchEnabled(false)

	local var_10_1 = var_10_0:getChildByName("image_icon")

	var_10_1:setScale(0.65)
	var_10_1:setPositionX(var_10_1:getPositionX() - 30)

	local var_10_2 = cc.Label:createWithTTF("", FONT_DES, 22)

	var_10_2:setName("title_label")
	var_10_2:setAnchorPoint(cc.p(0, 0))

	local var_10_3 = var_10_0:getChildByName("label_name")

	var_10_2:setPosition(var_10_3:getPositionX(), var_10_0:getChildByName("label_No_0").getPositionY(var_10_3))
	var_10_0:addChild(var_10_2)

	return var_10_0
end

function RankListBaseLayer:updateNode(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = ccui.Helper:seekWidgetByName(arg_11_1, "label_name")
	local var_11_1 = ccui.Helper:seekWidgetByName(arg_11_1, "label_No")
	local var_11_2 = arg_11_1:getChildByName("image_icon")

	ccui.Helper:seekWidgetByName(arg_11_1, "label_No_0"):setString(os.date("%Y/%m/%d %X", arg_11_2.passtime))
	arg_11_1:getChildByName("title_label"):setString(L_PASS_TIME)
	var_11_1:setVisible(true)

	local var_11_3 = var_0_12[4]

	for iter_11_0 = 1, 3 do
		if arg_11_3 == iter_11_0 then
			var_11_3 = var_0_12[iter_11_0]

			var_11_1:setVisible(false)

			break
		end
	end

	arg_11_1:setBackGroundImage(var_11_3, var_0_3)
	var_11_2:loadTexture(not item_data[tonumber(arg_11_2.head_sculpture)] and "role/wuji/100.png" or "role/wuji/" .. item_data[tonumber(arg_11_2.head_sculpture)].image_id .. ".png")
	var_11_0:setString(arg_11_2.name)
	var_11_1:setString(arg_11_3)

	local var_11_5 = {}

	var_11_5[1] = arg_11_2.medal_1 or 0
	var_11_5[2] = arg_11_2.medal_2 or 0
	var_11_5[3] = arg_11_2.medal_3 or 0

	for iter_11_1 = 1, 3 do
		if var_11_5[iter_11_1] == 0 then
			arg_11_1:getChildByName("medal_" .. iter_11_1):setVisible(false)
		else
			local var_11_6 = arg_11_1:getChildByName("medal_" .. iter_11_1)

			var_11_6:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_bg"):getChildByName("medal_" .. iter_11_1):getPositionY() + 18)
			var_11_6:setVisible(true)

			if not var_11_6:getChildByName("medalname") then
				local var_11_7 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_11_7:setAnchorPoint(cc.p(0.5, 0.5))
				var_11_7:setPosition(cc.p(var_11_6:getContentSize().width / 2 + 10, var_11_6:getContentSize().height / 2))
				var_11_7:setName("medalname")
				var_11_6:addChild(var_11_7)
			end

			local var_11_8 = item_data[var_11_5[iter_11_1]] or item_data[9100011]

			var_11_6:loadTexture((var_11_8.bg or nil) and ("equipment/" .. var_11_8.bg .. ".png" or var_0_14[var_11_8.equip_quality]))
			var_11_6:getChildByName("medalname"):setString(var_11_8.name)
			var_11_6:getChildByName("medalname"):enableOutline(var_0_15[var_11_8.equip_quality], 1)
			var_11_6:getChildByName("medalname"):enableShadow(var_0_15[var_11_8.equip_quality], cc.size(0, 0))
			var_11_6:getChildByName("medalname"):setVisible(var_11_8.only_bg ~= 1)
		end
	end
end

function RankListBaseLayer:initTableView()
	self.roleTableView:registerScriptHandler(function(arg_14_0, arg_14_1)
		return var_0_9, var_0_10
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0:dequeueCell()

		if not var_13_0 then
			var_13_0 = cc.TableViewCell:create()

			local var_13_1 = self:createNode()

			var_13_1:setName("node")
			var_13_1:setPosition(cc.p(5, 0))
			self:updateNode(var_13_1, self.data[arg_13_1 + 1], arg_13_1 + 1)

			if arg_13_1 <= math.floor(self.tableviewhight / var_0_10) then
				var_13_1:setOpacity(0)
				var_13_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_13_1), cc.FadeIn:create(0.1)))
			else
				var_13_1:setOpacity(255)
			end

			var_13_0:addChild(var_13_1)
		else
			local var_13_2 = var_13_0:getChildByName("node")

			var_13_2:setOpacity(255)
			self:updateNode(var_13_2, self.data[arg_13_1 + 1], arg_13_1 + 1)
		end

		return var_13_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_15_0, arg_15_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()
end

function RankListBaseLayer:DisplayRankList()
	level_manager:getLevelRankList(self.mode, function(arg_17_0)
		self.data = arg_17_0

		self:initTableView()
	end)
end

function RankListBaseLayer:MyRankNoShow(arg_18_1)
	self.myrank:setVisible(true)

	local var_18_0 = self.myrank:getChildByName("label_No")
	local var_18_1 = self.myrank:getChildByName("no_ranking")
	local var_18_2 = self.myrank:getChildByName("label_name")
	local var_18_3 = self.myrank:getChildByName("image_icon")
	local var_18_4 = playermodel.nickname

	self.myrank:getChildByName("label_rankjifen"):setString(L_PASS_TIME)

	local var_18_5 = self.myrank:getChildByName("label_rankjifen"):getChildByName("Label_71")

	if arg_18_1 and arg_18_1.time then
		var_18_5:setString(arg_18_1.time)
	else
		var_18_5:setString("----")
	end

	var_18_5:setPositionY(var_18_5:getPositionY() + 5)
	var_18_3:loadTexture("roleimage/role/wuji/" .. item_data[playermodel.head_sculpture].image_id .. ".png")
	var_18_3:setScale(0.5)

	local var_18_6 = {}

	var_18_6[1] = playermodel.cur_medal[1] or 0
	var_18_6[2] = playermodel.cur_medal[2] or 0
	var_18_6[3] = playermodel.cur_medal[3] or 0

	for iter_18_0 = 1, 3 do
		if var_18_6[iter_18_0] == 0 then
			self.myrank:getChildByName("medal_" .. iter_18_0):setVisible(false)
		else
			local var_18_7 = self.myrank:getChildByName("medal_" .. iter_18_0)

			var_18_7:setPositionY(var_18_7:getPositionY() + 22)
			var_18_7:setVisible(true)

			if not var_18_7:getChildByName("medalname") then
				local var_18_8 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_18_8:setAnchorPoint(cc.p(0.5, 0.5))
				var_18_8:setPosition(cc.p(var_18_7:getContentSize().width / 2 + 10, var_18_7:getContentSize().height / 2))
				var_18_8:setName("medalname")
				var_18_7:addChild(var_18_8)
			end

			local var_18_9 = item_data[var_18_6[iter_18_0]] or item_data[9100011]

			var_18_7:loadTexture((var_18_9.bg or nil) and ("equipment/" .. var_18_9.bg .. ".png" or var_0_14[var_18_9.equip_quality]))
			var_18_7:getChildByName("medalname"):setString(var_18_9.name)
			var_18_7:getChildByName("medalname"):enableOutline(var_0_15[var_18_9.equip_quality], 1)
			var_18_7:getChildByName("medalname"):enableShadow(var_0_15[var_18_9.equip_quality], cc.size(0, 0))
			var_18_7:getChildByName("medalname"):setVisible(var_18_9.only_bg ~= 1)
		end
	end

	var_18_2:setString(var_18_4)

	if arg_18_1 then
		self.rank11 = arg_18_1.rank + 1
	end

	if not self.rank11 or self.rank11 == 0 then
		self.rank11 = L_SCORE_AREAN_NO_RANK
	end

	if self.rank11 and type(self.rank11) == "number" then
		if tonumber(self.rank11) <= 100 and tonumber(self.rank11) > 0 then
			var_18_0:setVisible(true)
			var_18_1:setVisible(false)
			var_18_0:setString(self.rank11)
		else
			var_18_0:setVisible(false)
			var_18_1:setVisible(true)
		end
	else
		var_18_0:setVisible(false)
		var_18_1:setVisible(true)
	end
end

function RankListBaseLayer:fullScreen(arg_19_1)
	arg_19_1:setContentSize((GameDisplay.getScreenSize()))
	arg_19_1:setPositionY(arg_19_1:getPositionY() - GameDisplay.fix_y)
	self.Panel_top:setPosition(cc.p(GameDisplay.getUiScreenSize().width / 2, GameDisplay.getUiScreenSize().height))
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end

SpringRankListLayer = class("SpringRankListLayer", function()
	return RankListBaseLayer:create()
end)

local spring_manager = require("controller.spring_manager")

function SpringRankListLayer.create(arg_21_0)
	local var_21_0 = SpringRankListLayer.new()

	var_21_0:init()

	return var_21_0
end

function SpringRankListLayer:init()
	self:initUI()
	self:DisplayRankList()
	self:initBottomList()
	self:initMyRank()
	self:fullScreen(self.rootLayer)
end

function SpringRankListLayer.DisplayRankList(arg_23_0)
	spring_manager:get_nianshou_rank_data(function(arg_24_0)
		arg_23_0.data = arg_24_0

		arg_23_0:initTableView()
	end)
end

function SpringRankListLayer.initMyRank(arg_25_0)
	spring_manager:get_nianshou_player_rank(function(arg_26_0)
		arg_25_0:MyRankNoShow(arg_26_0)
	end)
end

function SpringRankListLayer:updateNode(arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = ccui.Helper:seekWidgetByName(arg_27_1, "label_name")
	local var_27_1 = ccui.Helper:seekWidgetByName(arg_27_1, "label_No")
	local var_27_2 = arg_27_1:getChildByName("avatar")

	ccui.Helper:seekWidgetByName(arg_27_1, "label_No_0"):setString(arg_27_2.score)
	arg_27_1:getChildByName("title_label"):setString(NIANHOU_PT .. ":")
	var_27_1:setVisible(true)

	local var_27_3 = var_0_12[4]

	for iter_27_0 = 1, 3 do
		if arg_27_3 == iter_27_0 then
			var_27_3 = var_0_12[iter_27_0]

			var_27_1:setVisible(false)

			break
		end
	end

	arg_27_1:setBackGroundImage(var_27_3, var_0_3)
	arg_27_1:getChildByName("image_icon"):setVisible(false)

	if not var_27_2 then
		var_27_2 = AvatarSprite:create(tonumber(arg_27_2.head_sculpture))

		var_27_2:setName("avatar")
		var_27_2:setScale(0.65)
		var_27_2:setPositionX(80)
		arg_27_1:addChild(var_27_2)
	else
		var_27_2:switchShowAvatar(tonumber(arg_27_2.head_sculpture))
	end

	var_27_0:setString(arg_27_2.name)
	var_27_1:setString(arg_27_3)

	local var_27_4 = {}

	var_27_4[1] = arg_27_2.medal_1 or 0
	var_27_4[2] = arg_27_2.medal_2 or 0
	var_27_4[3] = arg_27_2.medal_3 or 0

	for iter_27_1 = 1, 3 do
		if var_27_4[iter_27_1] == 0 then
			arg_27_1:getChildByName("medal_" .. iter_27_1):setVisible(false)
		else
			local var_27_5 = arg_27_1:getChildByName("medal_" .. iter_27_1)

			var_27_5:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_bg"):getChildByName("medal_" .. iter_27_1):getPositionY() + 18)
			var_27_5:setVisible(true)

			if not var_27_5:getChildByName("medalname") then
				local var_27_6 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_27_6:setAnchorPoint(cc.p(0.5, 0.5))
				var_27_6:setPosition(cc.p(var_27_5:getContentSize().width / 2 + 10, var_27_5:getContentSize().height / 2))
				var_27_6:setName("medalname")
				var_27_5:addChild(var_27_6)
			end

			local var_27_7 = item_data[var_27_4[iter_27_1]] or item_data[9100011]

			var_27_5:loadTexture((var_27_7.bg or nil) and ("equipment/" .. var_27_7.bg .. ".png" or var_0_14[var_27_7.equip_quality]))
			var_27_5:getChildByName("medalname"):setString(var_27_7.name)
			var_27_5:getChildByName("medalname"):enableOutline(var_0_15[var_27_7.equip_quality], 1)
			var_27_5:getChildByName("medalname"):enableShadow(var_0_15[var_27_7.equip_quality], cc.size(0, 0))
			var_27_5:getChildByName("medalname"):setVisible(var_27_7.only_bg ~= 1)
		end
	end
end

function SpringRankListLayer:MyRankNoShow(arg_28_1)
	self.myrank:setVisible(true)

	local var_28_0 = self.myrank:getChildByName("label_No")
	local var_28_1 = self.myrank:getChildByName("no_ranking")
	local var_28_2 = self.myrank:getChildByName("label_name")
	local var_28_3 = self.myrank:getChildByName("image_icon")
	local var_28_4 = playermodel.nickname

	self.myrank:getChildByName("label_rankjifen"):setString(NIANHOU_PT .. ":")

	local var_28_5 = self.myrank:getChildByName("label_rankjifen"):getChildByName("Label_71")

	if arg_28_1 and arg_28_1.score then
		var_28_5:setString(arg_28_1.score)
	else
		var_28_5:setString("----")
	end

	var_28_5:setPositionY(var_28_5:getPositionY() + 5)
	var_28_3:setVisible(false)

	local var_28_6 = AvatarSprite:create(playermodel.head_sculpture)

	var_28_6:setScale(0.5)
	var_28_6:setPositionX(90)
	self.myrank:addChild(var_28_6)

	local var_28_7 = {}

	var_28_7[1] = playermodel.cur_medal[1] or 0
	var_28_7[2] = playermodel.cur_medal[2] or 0
	var_28_7[3] = playermodel.cur_medal[3] or 0

	for iter_28_0 = 1, 3 do
		if var_28_7[iter_28_0] == 0 then
			self.myrank:getChildByName("medal_" .. iter_28_0):setVisible(false)
		else
			local var_28_8 = self.myrank:getChildByName("medal_" .. iter_28_0)

			var_28_8:setPositionY(var_28_8:getPositionY() + 22)
			var_28_8:setVisible(true)

			if not var_28_8:getChildByName("medalname") then
				local var_28_9 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_28_9:setAnchorPoint(cc.p(0.5, 0.5))
				var_28_9:setPosition(cc.p(var_28_8:getContentSize().width / 2 + 10, var_28_8:getContentSize().height / 2))
				var_28_9:setName("medalname")
				var_28_8:addChild(var_28_9)
			end

			local var_28_10 = item_data[var_28_7[iter_28_0]] or item_data[9100011]

			var_28_8:loadTexture((var_28_10.bg or nil) and ("equipment/" .. var_28_10.bg .. ".png" or var_0_14[var_28_10.equip_quality]))
			var_28_8:getChildByName("medalname"):setString(var_28_10.name)
			var_28_8:getChildByName("medalname"):enableOutline(var_0_15[var_28_10.equip_quality], 1)
			var_28_8:getChildByName("medalname"):enableShadow(var_0_15[var_28_10.equip_quality], cc.size(0, 0))
			var_28_8:getChildByName("medalname"):setVisible(var_28_10.only_bg ~= 1)
		end
	end

	var_28_2:setString(var_28_4)

	if arg_28_1 then
		self.rank11 = arg_28_1.rank
	end

	if not self.rank11 or self.rank11 == 0 then
		self.rank11 = L_SCORE_AREAN_NO_RANK
	end

	if self.rank11 and type(self.rank11) == "number" then
		if tonumber(self.rank11) <= 999 and tonumber(self.rank11) > 0 then
			var_28_0:setVisible(true)
			var_28_1:setVisible(false)
			var_28_0:setString(self.rank11)
		else
			var_28_0:setVisible(false)
			var_28_1:setVisible(true)
		end
	else
		var_28_0:setVisible(false)
		var_28_1:setVisible(true)
	end
end

MajorRankListLayer = class("MajorRankListLayer", function()
	return RankListBaseLayer:create()
end)

function MajorRankListLayer.create(arg_30_0)
	local var_30_0 = MajorRankListLayer.new()

	var_30_0:init()

	return var_30_0
end

function MajorRankListLayer:init()
	self:initUI()
	self:DisplayRankList()
	self:initBottomList()
	self.Panel_top:loadTexture("arenascenenew/top_bg.png", var_0_3)

	local var_31_0 = ccui.ImageView:create("Activity_Marry/servant_rank_title.png", var_0_3)

	var_31_0:setAnchorPoint(cc.p(0, 1))
	var_31_0:setPosition(0, var_31_0:getContentSize().height)
	self.Panel_top:addChild(var_31_0)

	local var_31_1 = cc.Label:createWithTTF(L_MARRY_RANK_LIMIT, FONT_DES, 22)

	var_31_1:setAnchorPoint(cc.p(0, 0.5))
	var_31_1:setPosition(cc.p(self.Panel_top:getContentSize().width / 2 - 15, self.Panel_top:getContentSize().height / 2))
	self.Panel_top:addChild(var_31_1, 99)
	self:fullScreen(self.rootLayer)
end

function MajorRankListLayer.DisplayRankList(arg_32_0)
	valentineManager:get_servant_rank_data(function(arg_33_0)
		arg_32_0.data = arg_33_0

		arg_32_0:initTableView()
	end)
end

function MajorRankListLayer.updateNode(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = ccui.Helper:seekWidgetByName(arg_34_1, "label_No")
	local var_34_1 = arg_34_1:getChildByName("avatar")

	ccui.Helper:seekWidgetByName(arg_34_1, "label_No_0"):setString(arg_34_2.score)
	arg_34_1:getChildByName("title_label"):setString(L_VALENTINE_RANK_VALUE2 .. ":")
	var_34_0:setVisible(true)

	local var_34_2 = var_0_12[4]

	for iter_34_0 = 1, 3 do
		if arg_34_3 == iter_34_0 then
			var_34_2 = var_0_12[iter_34_0]

			var_34_0:setVisible(false)

			break
		end
	end

	arg_34_1:setBackGroundImage(var_34_2, var_0_3)
	arg_34_1:getChildByName("image_icon"):loadTexture("role/wuji/" .. tonumber(arg_34_2.head_sculpture) .. ".png")
	ccui.Helper:seekWidgetByName(arg_34_1, "label_name"):setString(arg_34_2.name)
	var_34_0:setString(arg_34_3)

	for iter_34_1 = 1, 3 do
		arg_34_1:getChildByName("medal_" .. iter_34_1):setVisible(false)
	end
end

function MajorRankListLayer:MyRankNoShow(arg_35_1)
	self.myrank:setVisible(true)

	local var_35_0 = self.myrank:getChildByName("label_No")
	local var_35_1 = self.myrank:getChildByName("no_ranking")
	local var_35_2 = self.myrank:getChildByName("label_name")
	local var_35_3 = self.myrank:getChildByName("image_icon")
	local var_35_4 = playermodel.nickname

	self.myrank:getChildByName("label_rankjifen"):setString(L_VALENTINE_RANK_VALUE1 .. ":")

	local var_35_5 = self.myrank:getChildByName("label_rankjifen"):getChildByName("Label_71")

	if arg_35_1 and arg_35_1.score then
		var_35_5:setString(arg_35_1.score)
	else
		var_35_5:setString("----")
	end

	var_35_5:setPositionY(var_35_5:getPositionY() + 5)
	var_35_3:setVisible(false)

	local var_35_6 = AvatarSprite:create(playermodel.head_sculpture)

	var_35_6:setScale(0.5)
	var_35_6:setPositionX(90)
	self.myrank:addChild(var_35_6)

	local var_35_7 = {}

	var_35_7[1] = playermodel.cur_medal[1] or 0
	var_35_7[2] = playermodel.cur_medal[2] or 0
	var_35_7[3] = playermodel.cur_medal[3] or 0

	for iter_35_0 = 1, 3 do
		if var_35_7[iter_35_0] == 0 then
			self.myrank:getChildByName("medal_" .. iter_35_0):setVisible(false)
		else
			local var_35_8 = self.myrank:getChildByName("medal_" .. iter_35_0)

			var_35_8:setPositionY(var_35_8:getPositionY() + 22)
			var_35_8:setVisible(true)

			if not var_35_8:getChildByName("medalname") then
				local var_35_9 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_35_9:setAnchorPoint(cc.p(0.5, 0.5))
				var_35_9:setPosition(cc.p(var_35_8:getContentSize().width / 2 + 10, var_35_8:getContentSize().height / 2))
				var_35_9:setName("medalname")
				var_35_8:addChild(var_35_9)
			end

			local var_35_10 = item_data[var_35_7[iter_35_0]] or item_data[9100011]

			var_35_8:loadTexture((var_35_10.bg or nil) and ("equipment/" .. var_35_10.bg .. ".png" or var_0_14[var_35_10.equip_quality]))
			var_35_8:getChildByName("medalname"):setString(var_35_10.name)
			var_35_8:getChildByName("medalname"):enableOutline(var_0_15[var_35_10.equip_quality], 1)
			var_35_8:getChildByName("medalname"):enableShadow(var_0_15[var_35_10.equip_quality], cc.size(0, 0))
			var_35_8:getChildByName("medalname"):setVisible(var_35_10.only_bg ~= 1)
		end
	end

	var_35_2:setString(var_35_4)

	if arg_35_1 then
		self.rank11 = arg_35_1.rank
	end

	if not self.rank11 or self.rank11 == 0 then
		self.rank11 = L_SCORE_AREAN_NO_RANK
	end

	if self.rank11 and type(self.rank11) == "number" then
		if tonumber(self.rank11) <= 999 and tonumber(self.rank11) > 0 then
			var_35_0:setVisible(true)
			var_35_1:setVisible(false)
			var_35_0:setString(self.rank11)
		else
			var_35_0:setVisible(false)
			var_35_1:setVisible(true)
		end
	else
		var_35_0:setVisible(false)
		var_35_1:setVisible(true)
	end
end

function MajorRankListLayer:initBottomList()
	local var_36_0 = BottomBtnList:create(function(arg_37_0, arg_37_1)
		if arg_37_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end, {
		{
			texture = "public/button/public_button_orange.png",
			name = "goTarget",
			word = L_ACTIVITY_VALENTINE_GOTO_LEVEL,
			handler = function()
				if not level_manager:isPlayerPassLevel(UNLOCK_LEVELTALK) then
					global_ShowBlockWords(L_TALKLEVEL_LOCK)
				else
					LayerManager:switchShowLayer("LevelTalkMapLayer")
				end
			end
		}
	})

	var_36_0:setName("bottomlist")
	self:addChild(var_36_0, 10)

	self.bottomList = var_36_0
end

SubRankListLayer = class("SubRankListLayer", function()
	return RankListBaseLayer:create()
end)

local substitution_manager = require("controller.substitution_manager")

function SubRankListLayer.create(arg_40_0, arg_40_1)
	local var_40_0 = SubRankListLayer.new()

	var_40_0:init(arg_40_1)

	return var_40_0
end

function SubRankListLayer:init(arg_41_1)
	self:initData(arg_41_1)
	self:initUI()
	self:DisplayRankList()
	self:initBottomList()
	self:initMyRank()
	self:fullScreen(self.rootLayer)
end

function SubRankListLayer:DisplayRankList()
	substitution_manager:get_substitution_ranklist(self.mode, function(arg_43_0)
		self.data = arg_43_0

		self:initTableView()
	end)
end

function SubRankListLayer:initMyRank()
	substitution_manager:get_player_substitution_rank(self.mode, function(arg_45_0)
		self:MyRankNoShow(arg_45_0)
	end)
end

function SubRankListLayer:MyRankNoShow(arg_46_1)
	self.myrank:setVisible(true)

	local var_46_0 = self.myrank:getChildByName("label_No")
	local var_46_1 = self.myrank:getChildByName("no_ranking")
	local var_46_2 = self.myrank:getChildByName("label_name")
	local var_46_3 = self.myrank:getChildByName("image_icon")
	local var_46_4 = self.myrank:getChildByName("Image_25")
	local var_46_5 = self.myrank:getChildByName("star")
	local var_46_6 = playermodel.nickname

	self.myrank:getChildByName("label_rankjifen"):setString("分数" .. ":")

	local var_46_7 = self.myrank:getChildByName("label_rankjifen"):getChildByName("Label_71")

	if arg_46_1 and arg_46_1.score then
		var_46_7:setString(global_trans_number(arg_46_1.score))
	else
		var_46_7:setString("----")
	end

	var_46_7:setPositionY(var_46_7:getPositionY() + 5)
	var_46_3:setVisible(false)

	local var_46_8 = AvatarSprite:create(playermodel.head_sculpture)

	var_46_8:setScale(0.5)
	var_46_8:setPositionX(90)
	self.myrank:addChild(var_46_8)
	var_46_5:setVisible(false)
	var_46_4:setVisible(false)

	local var_46_9 = {}

	var_46_9[1] = playermodel.cur_medal[1] or 0
	var_46_9[2] = playermodel.cur_medal[2] or 0
	var_46_9[3] = playermodel.cur_medal[3] or 0

	for iter_46_0 = 1, 3 do
		if var_46_9[iter_46_0] == 0 then
			self.myrank:getChildByName("medal_" .. iter_46_0):setVisible(false)
		else
			local var_46_10 = self.myrank:getChildByName("medal_" .. iter_46_0)

			var_46_10:setPositionY(var_46_10:getPositionY() + 22)
			var_46_10:setVisible(true)

			if not var_46_10:getChildByName("medalname") then
				local var_46_11 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_46_11:setAnchorPoint(cc.p(0.5, 0.5))
				var_46_11:setPosition(cc.p(var_46_10:getContentSize().width / 2 + 10, var_46_10:getContentSize().height / 2))
				var_46_11:setName("medalname")
				var_46_10:addChild(var_46_11)
			end

			local var_46_12 = item_data[var_46_9[iter_46_0]] or item_data[9100011]

			var_46_10:loadTexture((var_46_12.bg or nil) and ("equipment/" .. var_46_12.bg .. ".png" or var_0_14[var_46_12.equip_quality]))
			var_46_10:getChildByName("medalname"):setString(var_46_12.name)
			var_46_10:getChildByName("medalname"):enableOutline(var_0_15[var_46_12.equip_quality], 1)
			var_46_10:getChildByName("medalname"):enableShadow(var_0_15[var_46_12.equip_quality], cc.size(0, 0))
			var_46_10:getChildByName("medalname"):setVisible(var_46_12.only_bg ~= 1)
		end
	end

	var_46_2:setString(var_46_6)

	if arg_46_1 then
		self.rank11 = arg_46_1.rank
	end

	if not self.rank11 or self.rank11 == 0 then
		self.rank11 = L_SCORE_AREAN_NO_RANK
	end

	if self.rank11 and type(self.rank11) == "number" then
		if tonumber(self.rank11) <= 999 and tonumber(self.rank11) > 0 then
			var_46_0:setVisible(true)
			var_46_1:setVisible(false)
			var_46_0:setString(self.rank11)
		else
			var_46_0:setVisible(false)
			var_46_1:setVisible(true)
		end
	else
		var_46_0:setVisible(false)
		var_46_1:setVisible(true)
	end
end

function SubRankListLayer:getSubArrayData(arg_47_1, arg_47_2)
	substitution_manager:get_substitution_battlearray_data(self.mode, arg_47_1, arg_47_2)
end

function SubRankListLayer:updateNode(arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = ccui.Helper:seekWidgetByName(arg_48_1, "label_name")
	local var_48_1 = ccui.Helper:seekWidgetByName(arg_48_1, "label_No")
	local var_48_2 = arg_48_1:getChildByName("avatar")

	ccui.Helper:seekWidgetByName(arg_48_1, "Image_sub_array"):setVisible(true)

	local var_48_3 = arg_48_1

	ccui.Helper:seekWidgetByName(arg_48_1, "label_No_0"):setString(global_trans_number(arg_48_2.score))
	arg_48_1:getChildByName("title_label"):setString("分数" .. ":")
	var_48_1:setVisible(true)

	local var_48_4 = var_0_12[4]

	for iter_48_0 = 1, 3 do
		if arg_48_3 == iter_48_0 then
			var_48_4 = var_0_12[iter_48_0]

			var_48_1:setVisible(false)

			break
		end
	end

	arg_48_1:getChildByName("star_icon"):setVisible(false)
	arg_48_1:getChildByName("star"):setVisible(false)
	var_48_3:setBackGroundImage(var_48_4, var_0_3)
	arg_48_1:getChildByName("image_icon"):setVisible(false)

	if not var_48_2 then
		var_48_2 = AvatarSprite:create(tonumber(arg_48_2.head_sculpture))

		var_48_2:setName("avatar")
		var_48_2:setScale(0.65)
		var_48_2:setPositionX(80)
		arg_48_1:addChild(var_48_2)
	else
		var_48_2:switchShowAvatar(tonumber(arg_48_2.head_sculpture))
	end

	var_48_2:addTouchEventListener(function(arg_49_0, arg_49_1)
		local var_49_0

		if arg_49_1 ~= ccui.TouchEventType.ended then
			do return end

			var_49_0 = {
				pvptype = 4,
				playeruid = arg_48_2.playerid,
				submodemode = self.mode
			}
		end

		function var_49_0.callback()
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", var_49_0)
	end)

	local var_48_5 = var_48_2:getChildByName("ava_img")

	if not var_48_3:getChildByName("touch_btn") then
		local var_48_6 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", var_0_3)

		var_48_6:setAnchorPoint(cc.p(0, 0))
		var_48_6:setPosition(0, 0)
		var_48_6:setScaleX(var_48_3:getContentSize().width / var_48_6:getContentSize().width)
		var_48_6:setScaleY(var_48_3:getContentSize().height / var_48_6:getContentSize().height)
		var_48_6:setSwallowTouches(false)
		var_48_6:setName("touch_btn")
		var_48_3:addChild(var_48_6)
		var_48_6:setVisible(false)
	end

	var_48_3:getChildByName("Image_sub_array"):setVisible(false)
	var_48_0:setString(arg_48_2.name)
	var_48_1:setString(arg_48_3)

	local var_48_7 = {}

	var_48_7[1] = arg_48_2.medal_1 or 0
	var_48_7[2] = arg_48_2.medal_2 or 0
	var_48_7[3] = arg_48_2.medal_3 or 0

	for iter_48_1 = 1, 3 do
		if var_48_7[iter_48_1] == 0 then
			arg_48_1:getChildByName("medal_" .. iter_48_1):setVisible(false)
		else
			local var_48_8 = arg_48_1:getChildByName("medal_" .. iter_48_1)

			var_48_8:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_bg"):getChildByName("medal_" .. iter_48_1):getPositionY() + 18)
			var_48_8:setVisible(true)

			if not var_48_8:getChildByName("medalname") then
				local var_48_9 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_48_9:setAnchorPoint(cc.p(0.5, 0.5))
				var_48_9:setPosition(cc.p(var_48_8:getContentSize().width / 2 + 10, var_48_8:getContentSize().height / 2))
				var_48_9:setName("medalname")
				var_48_8:addChild(var_48_9)
			end

			local var_48_10 = item_data[var_48_7[iter_48_1]] or item_data[9100011]

			var_48_8:loadTexture((var_48_10.bg or nil) and ("equipment/" .. var_48_10.bg .. ".png" or var_0_14[var_48_10.equip_quality]))
			var_48_8:getChildByName("medalname"):setString(var_48_10.name)
			var_48_8:getChildByName("medalname"):enableOutline(var_0_15[var_48_10.equip_quality], 1)
			var_48_8:getChildByName("medalname"):enableShadow(var_0_15[var_48_10.equip_quality], cc.size(0, 0))
			var_48_8:getChildByName("medalname"):setVisible(var_48_10.only_bg ~= 1)
		end
	end
end

ActivityArtRankListLayer = class("ActivityArtRankListLayer", function()
	return RankListBaseLayer:create()
end)

function ActivityArtRankListLayer.create(arg_52_0, arg_52_1)
	local var_52_0 = ActivityArtRankListLayer.new()

	var_52_0:init(arg_52_1)

	return var_52_0
end

function ActivityArtRankListLayer:init(arg_53_1)
	arg_53_1 = arg_53_1 or {
		activityId = 132
	}
	self.activityId = arg_53_1.activityId

	self:initUI()
	self:DisplayRankList()
	self:initBottomList()
	self.Panel_top:loadTexture("arenascenenew/top_bg.png", var_0_3)

	local var_53_0 = ccui.ImageView:create("Activity_Valentine_Day/valentine_rank_title.png", var_0_3)

	var_53_0:setAnchorPoint(cc.p(0, 1))
	var_53_0:setPosition(0, var_53_0:getContentSize().height)
	self.Panel_top:addChild(var_53_0)
	self:fullScreen(self.rootLayer)
end

function ActivityArtRankListLayer.DisplayRankList(arg_54_0)
	activity_manager:getArtRankList(132, function(arg_55_0, arg_55_1)
		arg_54_0.data = arg_55_0

		arg_54_0:initTableView()
		arg_54_0:MyRankNoShow(arg_55_1)
		arg_54_0:updateBottonAlert()
	end)
end

function ActivityArtRankListLayer:updateNode(arg_56_1, arg_56_2, arg_56_3)
	local var_56_0 = ccui.Helper:seekWidgetByName(arg_56_1, "label_name")
	local var_56_1 = ccui.Helper:seekWidgetByName(arg_56_1, "label_No")
	local var_56_2 = arg_56_1:getChildByName("avatar")

	ccui.Helper:seekWidgetByName(arg_56_1, "label_No_0"):setString(arg_56_2.score)
	arg_56_1:getChildByName("title_label"):setString(L_VALENTINE_RANK_VALUE1 .. ":")
	var_56_1:setVisible(true)

	local var_56_3 = var_0_12[4]

	for iter_56_0 = 1, 3 do
		if arg_56_3 == iter_56_0 then
			var_56_3 = var_0_12[iter_56_0]

			var_56_1:setVisible(false)

			break
		end
	end

	arg_56_1:setBackGroundImage(var_56_3, var_0_3)
	arg_56_1:getChildByName("image_icon"):setVisible(false)

	if not var_56_2 then
		var_56_2 = AvatarSprite:create(tonumber(arg_56_2.head_sculpture))

		var_56_2:setName("avatar")
		var_56_2:setScale(0.65)
		var_56_2:setPositionX(80)
		arg_56_1:addChild(var_56_2)
	else
		var_56_2:switchShowAvatar(tonumber(arg_56_2.head_sculpture))
	end

	var_56_0:setString(arg_56_2.name)
	var_56_1:setString(arg_56_3)

	local var_56_4 = {}

	var_56_4[1] = arg_56_2.medal_1 or 0
	var_56_4[2] = arg_56_2.medal_2 or 0
	var_56_4[3] = arg_56_2.medal_3 or 0

	for iter_56_1 = 1, 3 do
		if var_56_4[iter_56_1] == 0 then
			arg_56_1:getChildByName("medal_" .. iter_56_1):setVisible(false)
		else
			local var_56_5 = arg_56_1:getChildByName("medal_" .. iter_56_1)

			var_56_5:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_bg"):getChildByName("medal_" .. iter_56_1):getPositionY() + 18)
			var_56_5:setVisible(true)

			if not var_56_5:getChildByName("medalname") then
				local var_56_6 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_56_6:setAnchorPoint(cc.p(0.5, 0.5))
				var_56_6:setPosition(cc.p(var_56_5:getContentSize().width / 2 + 10, var_56_5:getContentSize().height / 2))
				var_56_6:setName("medalname")
				var_56_5:addChild(var_56_6)
			end

			local var_56_7 = item_data[var_56_4[iter_56_1]] or item_data[9100011]

			var_56_5:loadTexture((var_56_7.bg or nil) and ("equipment/" .. var_56_7.bg .. ".png" or var_0_14[var_56_7.equip_quality]))
			var_56_5:getChildByName("medalname"):setString(var_56_7.name)
			var_56_5:getChildByName("medalname"):enableOutline(var_0_15[var_56_7.equip_quality], 1)
			var_56_5:getChildByName("medalname"):enableShadow(var_0_15[var_56_7.equip_quality], cc.size(0, 0))
			var_56_5:getChildByName("medalname"):setVisible(var_56_7.only_bg ~= 1)
		end
	end
end

function ActivityArtRankListLayer:MyRankNoShow(arg_57_1)
	self.myrank:setVisible(true)

	local var_57_0 = self.myrank:getChildByName("label_No")
	local var_57_1 = self.myrank:getChildByName("no_ranking")
	local var_57_2 = self.myrank:getChildByName("label_name")
	local var_57_3 = self.myrank:getChildByName("image_icon")
	local var_57_4 = playermodel.nickname

	self.myrank:getChildByName("label_rankjifen"):setString(L_VALENTINE_RANK_VALUE1 .. ":")

	local var_57_5 = self.myrank:getChildByName("label_rankjifen"):getChildByName("Label_71")

	if arg_57_1 and arg_57_1.score then
		var_57_5:setString(arg_57_1.score)
	else
		var_57_5:setString("----")
	end

	var_57_5:setPositionY(var_57_5:getPositionY() + 5)
	var_57_3:setVisible(false)

	local var_57_6 = AvatarSprite:create(playermodel.head_sculpture)

	var_57_6:setScale(0.5)
	var_57_6:setPositionX(90)
	self.myrank:addChild(var_57_6)

	local var_57_7 = {}

	var_57_7[1] = playermodel.cur_medal[1] or 0
	var_57_7[2] = playermodel.cur_medal[2] or 0
	var_57_7[3] = playermodel.cur_medal[3] or 0

	for iter_57_0 = 1, 3 do
		if var_57_7[iter_57_0] == 0 then
			self.myrank:getChildByName("medal_" .. iter_57_0):setVisible(false)
		else
			local var_57_8 = self.myrank:getChildByName("medal_" .. iter_57_0)

			var_57_8:setPositionY(var_57_8:getPositionY() + 22)
			var_57_8:setVisible(true)

			if not var_57_8:getChildByName("medalname") then
				local var_57_9 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_57_9:setAnchorPoint(cc.p(0.5, 0.5))
				var_57_9:setPosition(cc.p(var_57_8:getContentSize().width / 2 + 10, var_57_8:getContentSize().height / 2))
				var_57_9:setName("medalname")
				var_57_8:addChild(var_57_9)
			end

			local var_57_10 = item_data[var_57_7[iter_57_0]] or item_data[9100011]

			var_57_8:loadTexture((var_57_10.bg or nil) and ("equipment/" .. var_57_10.bg .. ".png" or var_0_14[var_57_10.equip_quality]))
			var_57_8:getChildByName("medalname"):setString(var_57_10.name)
			var_57_8:getChildByName("medalname"):enableOutline(var_0_15[var_57_10.equip_quality], 1)
			var_57_8:getChildByName("medalname"):enableShadow(var_0_15[var_57_10.equip_quality], cc.size(0, 0))
			var_57_8:getChildByName("medalname"):setVisible(var_57_10.only_bg ~= 1)
		end
	end

	var_57_2:setString(var_57_4)

	if arg_57_1 and arg_57_1.rank <= 0 then
		self.rank11 = arg_57_1.rank
	elseif arg_57_1 and arg_57_1.rank > 0 then
		self.rank11 = L_QIAN .. arg_57_1.proceed .. "%"
	end

	if not self.rank11 or type(self.rank11) == "number" and self.rank11 <= 0 then
		self.rank11 = L_SCORE_AREAN_NO_RANK
	end

	var_57_0:setScale(0.7)

	if self.rank11 then
		var_57_0:setVisible(true)
		var_57_1:setVisible(false)
		var_57_0:setString(self.rank11)
	else
		var_57_0:setVisible(false)
		var_57_1:setVisible(true)
	end
end

function ActivityArtRankListLayer:initBottomList()
	local function var_58_0(arg_60_0, arg_60_1)
		if arg_60_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityArtRewardLayer", {
			activityId = self.activityId,
			callback = function()
				if activity_manager:isArtRankListRewardCanGet(self.activityId) then
					self:DisplayRankList()
				end
			end
		})
	end

	local var_58_2 = BottomBtnList:create(function(arg_59_0, arg_59_1)
		if arg_59_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end, (not activity_manager:isRankListRewardCanGet(self.activityId) or nil) and {
		{
			texture = "public/button/public_button_orange.png",
			name = "goTarget",
			word = L_WATCH_REAWARD,
			handler = var_58_0
		}
	})

	var_58_2:setName("bottomlist")
	self:addChild(var_58_2, 10)

	self.bottomList = var_58_2
end

function ActivityArtRankListLayer:updateBottonAlert()
	local var_62_0 = self.bottomList:getChildByName("goTarget")

	if activity_manager:isArtRankListRewardCanGet(self.activityId) then
		global_add_alert_tag(var_62_0, {
			x = var_62_0:getContentSize().width - 10,
			y = var_62_0:getContentSize().height - 10
		})
	else
		global_remove_alert_tag(var_62_0)
	end
end

FlyChessRankListLayer = class("FlyChessRankListLayer", function()
	return RankListBaseLayer:create()
end)

function FlyChessRankListLayer.create(arg_64_0, arg_64_1)
	local var_64_0 = FlyChessRankListLayer.new()

	var_64_0:init(arg_64_1)

	return var_64_0
end

function FlyChessRankListLayer:init(arg_65_1)
	arg_65_1 = arg_65_1 or {
		activityId = 752
	}
	self.activityId = arg_65_1.activityId

	self:initUI()
	self:DisplayRankList()
	self:initBottomList()
	self:fullScreen(self.rootLayer)
end

function FlyChessRankListLayer:DisplayRankList()
	activity_manager:get_flychess_rank_list(self.activityId, function(arg_67_0, arg_67_1)
		self.data = arg_67_0

		self:initTableView()
		self:MyRankNoShow(arg_67_1)
	end)
end

function FlyChessRankListLayer:updateNode(arg_68_1, arg_68_2, arg_68_3)
	local var_68_0 = ccui.Helper:seekWidgetByName(arg_68_1, "label_name")
	local var_68_1 = ccui.Helper:seekWidgetByName(arg_68_1, "label_No")
	local var_68_2 = arg_68_1:getChildByName("avatar")

	ccui.Helper:seekWidgetByName(arg_68_1, "Image_sub_array"):setVisible(true)

	local var_68_3 = arg_68_1

	ccui.Helper:seekWidgetByName(arg_68_1, "label_No_0"):setString(global_trans_number(arg_68_2.score))
	arg_68_1:getChildByName("title_label"):setString("探索值" .. ":")
	var_68_1:setVisible(true)

	local var_68_4 = var_0_12[4]

	for iter_68_0 = 1, 3 do
		if arg_68_3 == iter_68_0 then
			var_68_4 = var_0_12[iter_68_0]

			var_68_1:setVisible(false)

			break
		end
	end

	arg_68_1:getChildByName("star_icon"):setVisible(false)
	arg_68_1:getChildByName("star"):setVisible(false)
	var_68_3:setBackGroundImage(var_68_4, var_0_3)
	arg_68_1:getChildByName("image_icon"):setVisible(false)

	if not var_68_2 then
		var_68_2 = AvatarSprite:create(tonumber(arg_68_2.head_sculpture))

		var_68_2:setName("avatar")
		var_68_2:setScale(0.65)
		var_68_2:setPositionX(80)
		arg_68_1:addChild(var_68_2)
	else
		var_68_2:switchShowAvatar(tonumber(arg_68_2.head_sculpture))
	end

	var_68_2:addTouchEventListener(function(arg_69_0, arg_69_1)
		if arg_69_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", {
			playeruid = arg_68_2.playerid
		})
	end)

	local var_68_5 = var_68_2:getChildByName("ava_img")

	if not var_68_3:getChildByName("touch_btn") then
		local var_68_6 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", var_0_3)

		var_68_6:setAnchorPoint(cc.p(0, 0))
		var_68_6:setPosition(0, 0)
		var_68_6:setScaleX(var_68_3:getContentSize().width / var_68_6:getContentSize().width)
		var_68_6:setScaleY(var_68_3:getContentSize().height / var_68_6:getContentSize().height)
		var_68_6:setSwallowTouches(false)
		var_68_6:setName("touch_btn")
		var_68_3:addChild(var_68_6)
		var_68_6:setVisible(false)
	end

	var_68_3:getChildByName("Image_sub_array"):setVisible(false)
	var_68_0:setString(arg_68_2.name)
	var_68_1:setString(arg_68_3)

	local var_68_7 = {}

	var_68_7[1] = arg_68_2.medal_1 or 0
	var_68_7[2] = arg_68_2.medal_2 or 0
	var_68_7[3] = arg_68_2.medal_3 or 0

	for iter_68_1 = 1, 3 do
		if var_68_7[iter_68_1] == 0 then
			arg_68_1:getChildByName("medal_" .. iter_68_1):setVisible(false)
		else
			local var_68_8 = arg_68_1:getChildByName("medal_" .. iter_68_1)

			var_68_8:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_bg"):getChildByName("medal_" .. iter_68_1):getPositionY() + 18)
			var_68_8:setVisible(true)

			if not var_68_8:getChildByName("medalname") then
				local var_68_9 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_68_9:setAnchorPoint(cc.p(0.5, 0.5))
				var_68_9:setPosition(cc.p(var_68_8:getContentSize().width / 2 + 10, var_68_8:getContentSize().height / 2))
				var_68_9:setName("medalname")
				var_68_8:addChild(var_68_9)
			end

			local var_68_10 = item_data[var_68_7[iter_68_1]] or item_data[9100011]

			var_68_8:loadTexture((var_68_10.bg or nil) and ("equipment/" .. var_68_10.bg .. ".png" or var_0_14[var_68_10.equip_quality]))
			var_68_8:getChildByName("medalname"):setString(var_68_10.name)
			var_68_8:getChildByName("medalname"):enableOutline(var_0_15[var_68_10.equip_quality], 1)
			var_68_8:getChildByName("medalname"):enableShadow(var_0_15[var_68_10.equip_quality], cc.size(0, 0))
			var_68_8:getChildByName("medalname"):setVisible(var_68_10.only_bg ~= 1)
		end
	end
end

function FlyChessRankListLayer:MyRankNoShow(arg_71_1)
	self.myrank:setVisible(true)

	local var_71_0 = self.myrank:getChildByName("label_No")
	local var_71_1 = self.myrank:getChildByName("no_ranking")
	local var_71_2 = self.myrank:getChildByName("label_name")
	local var_71_3 = self.myrank:getChildByName("image_icon")
	local var_71_4 = self.myrank:getChildByName("Image_25")
	local var_71_5 = self.myrank:getChildByName("star")
	local var_71_6 = playermodel.nickname

	self.myrank:getChildByName("label_rankjifen"):setString("探索值" .. ":")

	local var_71_7 = self.myrank:getChildByName("label_rankjifen"):getChildByName("Label_71")

	if arg_71_1 and arg_71_1.score then
		var_71_7:setString(global_trans_number(arg_71_1.score))
	else
		var_71_7:setString("----")
	end

	var_71_7:setPositionY(var_71_7:getPositionY() + 5)
	var_71_3:setVisible(false)

	local var_71_8 = AvatarSprite:create(playermodel.head_sculpture)

	var_71_8:setScale(0.5)
	var_71_8:setPositionX(90)
	self.myrank:addChild(var_71_8)
	var_71_5:setVisible(false)
	var_71_4:setVisible(false)

	local var_71_9 = {}

	var_71_9[1] = playermodel.cur_medal[1] or 0
	var_71_9[2] = playermodel.cur_medal[2] or 0
	var_71_9[3] = playermodel.cur_medal[3] or 0

	for iter_71_0 = 1, 3 do
		if var_71_9[iter_71_0] == 0 then
			self.myrank:getChildByName("medal_" .. iter_71_0):setVisible(false)
		else
			local var_71_10 = self.myrank:getChildByName("medal_" .. iter_71_0)

			var_71_10:setPositionY(var_71_10:getPositionY() + 22)
			var_71_10:setVisible(true)

			if not var_71_10:getChildByName("medalname") then
				local var_71_11 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_71_11:setAnchorPoint(cc.p(0.5, 0.5))
				var_71_11:setPosition(cc.p(var_71_10:getContentSize().width / 2 + 10, var_71_10:getContentSize().height / 2))
				var_71_11:setName("medalname")
				var_71_10:addChild(var_71_11)
			end

			local var_71_12 = item_data[var_71_9[iter_71_0]] or item_data[9100011]

			var_71_10:loadTexture((var_71_12.bg or nil) and ("equipment/" .. var_71_12.bg .. ".png" or var_0_14[var_71_12.equip_quality]))
			var_71_10:getChildByName("medalname"):setString(var_71_12.name)
			var_71_10:getChildByName("medalname"):enableOutline(var_0_15[var_71_12.equip_quality], 1)
			var_71_10:getChildByName("medalname"):enableShadow(var_0_15[var_71_12.equip_quality], cc.size(0, 0))
			var_71_10:getChildByName("medalname"):setVisible(var_71_12.only_bg ~= 1)
		end
	end

	var_71_2:setString(var_71_6)

	if arg_71_1 then
		self.rank11 = arg_71_1.rank
	end

	if not self.rank11 or self.rank11 == 0 then
		self.rank11 = L_SCORE_AREAN_NO_RANK
	end

	if self.rank11 and type(self.rank11) == "number" then
		if tonumber(self.rank11) <= 999 and tonumber(self.rank11) > 0 then
			var_71_0:setVisible(true)
			var_71_1:setVisible(false)
			var_71_0:setString(self.rank11)
		else
			var_71_0:setVisible(false)
			var_71_1:setVisible(true)
		end
	else
		var_71_0:setVisible(false)
		var_71_1:setVisible(true)
	end
end

OldSubRankListLayer = class("OldSubRankListLayer", function()
	return RankListBaseLayer:create()
end)

local old_substitution_manager = require("controller.old_substitution_manager")

function OldSubRankListLayer.create(arg_73_0, arg_73_1)
	local var_73_0 = OldSubRankListLayer.new()

	var_73_0:init(arg_73_1)

	return var_73_0
end

function OldSubRankListLayer:init(arg_74_1)
	self.type = arg_74_1.type or "daily"

	self:initUI()
	self:DisplayRankList()
	self:initBottomList()
	self:fullScreen(self.rootLayer)
end

function OldSubRankListLayer:DisplayRankList()
	old_substitution_manager:get_old_substitute_rank_list(self.type, function(arg_76_0, arg_76_1)
		self.data = arg_76_0

		self:initTableView()
		self:MyRankNoShow(arg_76_1)
	end)
end

function OldSubRankListLayer:updateNode(arg_77_1, arg_77_2, arg_77_3)
	local var_77_0 = ccui.Helper:seekWidgetByName(arg_77_1, "label_name")
	local var_77_1 = ccui.Helper:seekWidgetByName(arg_77_1, "label_No")
	local var_77_2 = arg_77_1:getChildByName("avatar")

	ccui.Helper:seekWidgetByName(arg_77_1, "Image_sub_array"):setVisible(true)

	local var_77_3 = arg_77_1

	ccui.Helper:seekWidgetByName(arg_77_1, "label_No_0"):setString(global_trans_number(arg_77_2.score))
	arg_77_1:getChildByName("title_label"):setString("分数" .. ":")
	var_77_1:setVisible(true)

	local var_77_4 = var_0_12[4]

	for iter_77_0 = 1, 3 do
		if arg_77_3 == iter_77_0 then
			var_77_4 = var_0_12[iter_77_0]

			var_77_1:setVisible(false)

			break
		end
	end

	arg_77_1:getChildByName("star_icon"):setVisible(false)
	arg_77_1:getChildByName("star"):setVisible(false)
	var_77_3:setBackGroundImage(var_77_4, var_0_3)
	arg_77_1:getChildByName("image_icon"):setVisible(false)

	if not var_77_2 then
		var_77_2 = AvatarSprite:create(tonumber(arg_77_2.head_sculpture))

		var_77_2:setName("avatar")
		var_77_2:setScale(0.65)
		var_77_2:setPositionX(80)
		arg_77_1:addChild(var_77_2)
	else
		var_77_2:switchShowAvatar(tonumber(arg_77_2.head_sculpture))
	end

	var_77_2:addTouchEventListener(function(arg_78_0, arg_78_1)
		if arg_78_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", {
			playeruid = arg_77_2.playerid
		})
	end)

	local var_77_5 = var_77_2:getChildByName("ava_img")

	if not var_77_3:getChildByName("touch_btn") then
		local var_77_6 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", var_0_3)

		var_77_6:setAnchorPoint(cc.p(0, 0))
		var_77_6:setPosition(0, 0)
		var_77_6:setScaleX(var_77_3:getContentSize().width / var_77_6:getContentSize().width)
		var_77_6:setScaleY(var_77_3:getContentSize().height / var_77_6:getContentSize().height)
		var_77_6:setSwallowTouches(false)
		var_77_6:setName("touch_btn")
		var_77_3:addChild(var_77_6)
		var_77_6:setVisible(false)
	end

	var_77_3:getChildByName("Image_sub_array"):setVisible(false)
	var_77_0:setString(arg_77_2.name)
	var_77_1:setString(arg_77_3)

	local var_77_7 = {}

	var_77_7[1] = arg_77_2.medal_1 or 0
	var_77_7[2] = arg_77_2.medal_2 or 0
	var_77_7[3] = arg_77_2.medal_3 or 0

	for iter_77_1 = 1, 3 do
		if var_77_7[iter_77_1] == 0 then
			arg_77_1:getChildByName("medal_" .. iter_77_1):setVisible(false)
		else
			local var_77_8 = arg_77_1:getChildByName("medal_" .. iter_77_1)

			var_77_8:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_bg"):getChildByName("medal_" .. iter_77_1):getPositionY() + 18)
			var_77_8:setVisible(true)

			if not var_77_8:getChildByName("medalname") then
				local var_77_9 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_77_9:setAnchorPoint(cc.p(0.5, 0.5))
				var_77_9:setPosition(cc.p(var_77_8:getContentSize().width / 2 + 10, var_77_8:getContentSize().height / 2))
				var_77_9:setName("medalname")
				var_77_8:addChild(var_77_9)
			end

			local var_77_10 = item_data[var_77_7[iter_77_1]] or item_data[9100011]

			var_77_8:loadTexture((var_77_10.bg or nil) and ("equipment/" .. var_77_10.bg .. ".png" or var_0_14[var_77_10.equip_quality]))
			var_77_8:getChildByName("medalname"):setString(var_77_10.name)
			var_77_8:getChildByName("medalname"):enableOutline(var_0_15[var_77_10.equip_quality], 1)
			var_77_8:getChildByName("medalname"):enableShadow(var_0_15[var_77_10.equip_quality], cc.size(0, 0))
			var_77_8:getChildByName("medalname"):setVisible(var_77_10.only_bg ~= 1)
		end
	end
end

function OldSubRankListLayer:MyRankNoShow(arg_80_1)
	self.myrank:setVisible(true)

	local var_80_0 = self.myrank:getChildByName("label_No")
	local var_80_1 = self.myrank:getChildByName("no_ranking")
	local var_80_2 = self.myrank:getChildByName("label_name")
	local var_80_3 = self.myrank:getChildByName("image_icon")
	local var_80_4 = self.myrank:getChildByName("Image_25")
	local var_80_5 = self.myrank:getChildByName("star")
	local var_80_6 = playermodel.nickname

	self.myrank:getChildByName("label_rankjifen"):setString("分数" .. ":")

	local var_80_7 = self.myrank:getChildByName("label_rankjifen"):getChildByName("Label_71")

	if arg_80_1 and arg_80_1.score then
		var_80_7:setString(global_trans_number(arg_80_1.score))
	else
		var_80_7:setString("----")
	end

	var_80_7:setPositionY(var_80_7:getPositionY() + 5)
	var_80_3:setVisible(false)

	local var_80_8 = AvatarSprite:create(playermodel.head_sculpture)

	var_80_8:setScale(0.5)
	var_80_8:setPositionX(90)
	self.myrank:addChild(var_80_8)
	var_80_5:setVisible(false)
	var_80_4:setVisible(false)

	local var_80_9 = {}

	var_80_9[1] = playermodel.cur_medal[1] or 0
	var_80_9[2] = playermodel.cur_medal[2] or 0
	var_80_9[3] = playermodel.cur_medal[3] or 0

	for iter_80_0 = 1, 3 do
		if var_80_9[iter_80_0] == 0 then
			self.myrank:getChildByName("medal_" .. iter_80_0):setVisible(false)
		else
			local var_80_10 = self.myrank:getChildByName("medal_" .. iter_80_0)

			var_80_10:setPositionY(var_80_10:getPositionY() + 22)
			var_80_10:setVisible(true)

			if not var_80_10:getChildByName("medalname") then
				local var_80_11 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_80_11:setAnchorPoint(cc.p(0.5, 0.5))
				var_80_11:setPosition(cc.p(var_80_10:getContentSize().width / 2 + 10, var_80_10:getContentSize().height / 2))
				var_80_11:setName("medalname")
				var_80_10:addChild(var_80_11)
			end

			local var_80_12 = item_data[var_80_9[iter_80_0]] or item_data[9100011]

			var_80_10:loadTexture((var_80_12.bg or nil) and ("equipment/" .. var_80_12.bg .. ".png" or var_0_14[var_80_12.equip_quality]))
			var_80_10:getChildByName("medalname"):setString(var_80_12.name)
			var_80_10:getChildByName("medalname"):enableOutline(var_0_15[var_80_12.equip_quality], 1)
			var_80_10:getChildByName("medalname"):enableShadow(var_0_15[var_80_12.equip_quality], cc.size(0, 0))
			var_80_10:getChildByName("medalname"):setVisible(var_80_12.only_bg ~= 1)
		end
	end

	var_80_2:setString(var_80_6)

	if arg_80_1 then
		self.rank11 = arg_80_1.rank
	end

	if not self.rank11 or self.rank11 == 0 then
		self.rank11 = L_SCORE_AREAN_NO_RANK
	end

	if self.rank11 and type(self.rank11) == "number" then
		if tonumber(self.rank11) <= 999 and tonumber(self.rank11) > 0 then
			var_80_0:setVisible(true)
			var_80_1:setVisible(false)
			var_80_0:setString(self.rank11)
		else
			var_80_0:setVisible(false)
			var_80_1:setVisible(true)
		end
	else
		var_80_0:setVisible(false)
		var_80_1:setVisible(true)
	end
end

HexagonRankListLayer = class("HexagonRankListLayer", function()
	return RankListBaseLayer:create()
end)

function HexagonRankListLayer.create(arg_82_0, arg_82_1)
	local var_82_0 = HexagonRankListLayer.new()

	var_82_0:init(arg_82_1)

	return var_82_0
end

function HexagonRankListLayer:init(arg_83_1)
	arg_83_1 = arg_83_1 or {
		activityId = 752
	}
	self.activityId = arg_83_1.activityId

	self:initUI()
	self:DisplayRankList()
	self:initBottomList()
	self:fullScreen(self.rootLayer)
end

function HexagonRankListLayer:DisplayRankList()
	activity_hexagon_dispel_manager:get_hexagon_score_rank_list(self.activityId, function(arg_85_0, arg_85_1)
		self.data = arg_85_0

		self:initTableView()
		self:MyRankNoShow(arg_85_1)
	end)
end

function HexagonRankListLayer:updateNode(arg_86_1, arg_86_2, arg_86_3)
	local var_86_0 = ccui.Helper:seekWidgetByName(arg_86_1, "label_name")
	local var_86_1 = ccui.Helper:seekWidgetByName(arg_86_1, "label_No")
	local var_86_2 = arg_86_1:getChildByName("avatar")

	ccui.Helper:seekWidgetByName(arg_86_1, "Image_sub_array"):setVisible(true)

	local var_86_3 = arg_86_1

	ccui.Helper:seekWidgetByName(arg_86_1, "label_No_0"):setString(global_trans_number(arg_86_2.score))
	arg_86_1:getChildByName("title_label"):setString("得分:")
	var_86_1:setVisible(true)

	local var_86_4 = var_0_12[4]

	for iter_86_0 = 1, 3 do
		if arg_86_3 == iter_86_0 then
			var_86_4 = var_0_12[iter_86_0]

			var_86_1:setVisible(false)

			break
		end
	end

	arg_86_1:getChildByName("star_icon"):setVisible(false)
	arg_86_1:getChildByName("star"):setVisible(false)
	var_86_3:setBackGroundImage(var_86_4, var_0_3)
	arg_86_1:getChildByName("image_icon"):setVisible(false)

	if not var_86_2 then
		var_86_2 = AvatarSprite:create(tonumber(arg_86_2.head_sculpture))

		var_86_2:setName("avatar")
		var_86_2:setScale(0.65)
		var_86_2:setPositionX(80)
		arg_86_1:addChild(var_86_2)
	else
		var_86_2:switchShowAvatar(tonumber(arg_86_2.head_sculpture))
	end

	var_86_2:addTouchEventListener(function(arg_87_0, arg_87_1)
		if arg_87_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", {
			playeruid = arg_86_2.playerid
		})
	end)

	local var_86_5 = var_86_2:getChildByName("ava_img")

	if not var_86_3:getChildByName("touch_btn") then
		local var_86_6 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", var_0_3)

		var_86_6:setAnchorPoint(cc.p(0, 0))
		var_86_6:setPosition(0, 0)
		var_86_6:setScaleX(var_86_3:getContentSize().width / var_86_6:getContentSize().width)
		var_86_6:setScaleY(var_86_3:getContentSize().height / var_86_6:getContentSize().height)
		var_86_6:setSwallowTouches(false)
		var_86_6:setName("touch_btn")
		var_86_3:addChild(var_86_6)
		var_86_6:setVisible(false)
	end

	var_86_3:getChildByName("Image_sub_array"):setVisible(false)
	var_86_0:setString(arg_86_2.name)
	var_86_1:setString(arg_86_3)

	local var_86_7 = {}

	var_86_7[1] = arg_86_2.medal_1 or 0
	var_86_7[2] = arg_86_2.medal_2 or 0
	var_86_7[3] = arg_86_2.medal_3 or 0

	for iter_86_1 = 1, 3 do
		if var_86_7[iter_86_1] == 0 then
			arg_86_1:getChildByName("medal_" .. iter_86_1):setVisible(false)
		else
			local var_86_8 = arg_86_1:getChildByName("medal_" .. iter_86_1)

			var_86_8:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_bg"):getChildByName("medal_" .. iter_86_1):getPositionY() + 18)
			var_86_8:setVisible(true)

			if not var_86_8:getChildByName("medalname") then
				local var_86_9 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_86_9:setAnchorPoint(cc.p(0.5, 0.5))
				var_86_9:setPosition(cc.p(var_86_8:getContentSize().width / 2 + 10, var_86_8:getContentSize().height / 2))
				var_86_9:setName("medalname")
				var_86_8:addChild(var_86_9)
			end

			local var_86_10 = item_data[var_86_7[iter_86_1]] or item_data[9100011]

			var_86_8:loadTexture((var_86_10.bg or nil) and ("equipment/" .. var_86_10.bg .. ".png" or var_0_14[var_86_10.equip_quality]))
			var_86_8:getChildByName("medalname"):setString(var_86_10.name)
			var_86_8:getChildByName("medalname"):enableOutline(var_0_15[var_86_10.equip_quality], 1)
			var_86_8:getChildByName("medalname"):enableShadow(var_0_15[var_86_10.equip_quality], cc.size(0, 0))
			var_86_8:getChildByName("medalname"):setVisible(var_86_10.only_bg ~= 1)
		end
	end
end

function HexagonRankListLayer:MyRankNoShow(arg_89_1)
	self.myrank:setVisible(true)

	local var_89_0 = self.myrank:getChildByName("label_No")
	local var_89_1 = self.myrank:getChildByName("no_ranking")
	local var_89_2 = self.myrank:getChildByName("label_name")
	local var_89_3 = self.myrank:getChildByName("image_icon")
	local var_89_4 = self.myrank:getChildByName("Image_25")
	local var_89_5 = self.myrank:getChildByName("star")
	local var_89_6 = playermodel.nickname

	self.myrank:getChildByName("label_rankjifen"):setString("得分:")

	local var_89_7 = self.myrank:getChildByName("label_rankjifen"):getChildByName("Label_71")

	if arg_89_1 and arg_89_1.score then
		var_89_7:setString(global_trans_number(arg_89_1.score))
	else
		var_89_7:setString("----")
	end

	var_89_7:setPositionY(var_89_7:getPositionY() + 5)
	var_89_3:setVisible(false)

	local var_89_8 = AvatarSprite:create(playermodel.head_sculpture)

	var_89_8:setScale(0.5)
	var_89_8:setPositionX(90)
	self.myrank:addChild(var_89_8)
	var_89_5:setVisible(false)
	var_89_4:setVisible(false)

	local var_89_9 = {}

	var_89_9[1] = playermodel.cur_medal[1] or 0
	var_89_9[2] = playermodel.cur_medal[2] or 0
	var_89_9[3] = playermodel.cur_medal[3] or 0

	for iter_89_0 = 1, 3 do
		if var_89_9[iter_89_0] == 0 then
			self.myrank:getChildByName("medal_" .. iter_89_0):setVisible(false)
		else
			local var_89_10 = self.myrank:getChildByName("medal_" .. iter_89_0)

			var_89_10:setPositionY(var_89_10:getPositionY() + 22)
			var_89_10:setVisible(true)

			if not var_89_10:getChildByName("medalname") then
				local var_89_11 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_89_11:setAnchorPoint(cc.p(0.5, 0.5))
				var_89_11:setPosition(cc.p(var_89_10:getContentSize().width / 2 + 10, var_89_10:getContentSize().height / 2))
				var_89_11:setName("medalname")
				var_89_10:addChild(var_89_11)
			end

			local var_89_12 = item_data[var_89_9[iter_89_0]] or item_data[9100011]

			var_89_10:loadTexture((var_89_12.bg or nil) and ("equipment/" .. var_89_12.bg .. ".png" or var_0_14[var_89_12.equip_quality]))
			var_89_10:getChildByName("medalname"):setString(var_89_12.name)
			var_89_10:getChildByName("medalname"):enableOutline(var_0_15[var_89_12.equip_quality], 1)
			var_89_10:getChildByName("medalname"):enableShadow(var_0_15[var_89_12.equip_quality], cc.size(0, 0))
			var_89_10:getChildByName("medalname"):setVisible(var_89_12.only_bg ~= 1)
		end
	end

	var_89_2:setString(var_89_6)

	if arg_89_1 then
		self.rank11 = arg_89_1.rank
	end

	if not self.rank11 or self.rank11 == 0 then
		self.rank11 = L_SCORE_AREAN_NO_RANK
	end

	if self.rank11 and type(self.rank11) == "number" then
		if tonumber(self.rank11) <= 999 and tonumber(self.rank11) > 0 then
			var_89_0:setVisible(true)
			var_89_1:setVisible(false)
			var_89_0:setString(self.rank11)
		else
			var_89_0:setVisible(false)
			var_89_1:setVisible(true)
		end
	else
		var_89_0:setVisible(false)
		var_89_1:setVisible(true)
	end
end

WorldBossRankListLayer = class("WorldBossRankListLayer", function()
	return RankListBaseLayer:create()
end)

function WorldBossRankListLayer.create(arg_91_0, arg_91_1)
	local var_91_0 = WorldBossRankListLayer.new()

	var_91_0:init(arg_91_1)

	return var_91_0
end

function WorldBossRankListLayer:init(arg_92_1)
	self.activityId = arg_92_1.activityId
	self.stage = arg_92_1.stage

	self:initUI()
	self:DisplayRankList()
	self:initBottomList()
	self:fullScreen(self.rootLayer)
end

function WorldBossRankListLayer:DisplayRankList()
	activity_manager:get_worldboss_rank_list(self.activityId, self.stage, 1, 100, function(arg_94_0)
		self.data = arg_94_0.data

		self:initTableView()
		self:MyRankNoShow({
			score = arg_94_0.max_score,
			rank = arg_94_0.rank
		})
	end)
end

function WorldBossRankListLayer:updateNode(arg_95_1, arg_95_2, arg_95_3)
	local var_95_0 = ccui.Helper:seekWidgetByName(arg_95_1, "label_name")
	local var_95_1 = ccui.Helper:seekWidgetByName(arg_95_1, "label_No")
	local var_95_2 = arg_95_1:getChildByName("avatar")

	ccui.Helper:seekWidgetByName(arg_95_1, "Image_sub_array"):setVisible(true)

	local var_95_3 = arg_95_1

	ccui.Helper:seekWidgetByName(arg_95_1, "label_No_0"):setString(global_trans_number(arg_95_2.score))
	arg_95_1:getChildByName("title_label"):setString("得分:")
	var_95_1:setVisible(true)

	local var_95_4 = var_0_12[4]

	for iter_95_0 = 1, 3 do
		if arg_95_3 == iter_95_0 then
			var_95_4 = var_0_12[iter_95_0]

			var_95_1:setVisible(false)

			break
		end
	end

	arg_95_1:getChildByName("star_icon"):setVisible(false)
	arg_95_1:getChildByName("star"):setVisible(false)
	var_95_3:setBackGroundImage(var_95_4, var_0_3)
	arg_95_1:getChildByName("image_icon"):setVisible(false)

	if not var_95_2 then
		var_95_2 = AvatarSprite:create(tonumber(arg_95_2.head_sculpture))

		var_95_2:setName("avatar")
		var_95_2:setScale(0.65)
		var_95_2:setPositionX(80)
		arg_95_1:addChild(var_95_2)
	else
		var_95_2:switchShowAvatar(tonumber(arg_95_2.head_sculpture))
	end

	var_95_2:addTouchEventListener(function(arg_96_0, arg_96_1)
		if arg_96_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopFriendIntroduceLayer", {
			playeruid = arg_95_2.playerid
		})
	end)

	local var_95_5 = var_95_2:getChildByName("ava_img")

	if not var_95_3:getChildByName("touch_btn") then
		local var_95_6 = ccui.Button:create("public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", "public/box/new_item_bg_touming.png", var_0_3)

		var_95_6:setAnchorPoint(cc.p(0, 0))
		var_95_6:setPosition(0, 0)
		var_95_6:setScaleX(var_95_3:getContentSize().width / var_95_6:getContentSize().width)
		var_95_6:setScaleY(var_95_3:getContentSize().height / var_95_6:getContentSize().height)
		var_95_6:setSwallowTouches(false)
		var_95_6:setName("touch_btn")
		var_95_3:addChild(var_95_6)
		var_95_6:setVisible(false)
	end

	var_95_3:getChildByName("Image_sub_array"):setVisible(false)
	var_95_0:setString(arg_95_2.name)
	var_95_1:setString(arg_95_3)

	local var_95_7 = {}

	var_95_7[1] = arg_95_2.medal_1 or 0
	var_95_7[2] = arg_95_2.medal_2 or 0
	var_95_7[3] = arg_95_2.medal_3 or 0

	for iter_95_1 = 1, 3 do
		if var_95_7[iter_95_1] == 0 then
			arg_95_1:getChildByName("medal_" .. iter_95_1):setVisible(false)
		else
			local var_95_8 = arg_95_1:getChildByName("medal_" .. iter_95_1)

			var_95_8:setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "ranking_bg"):getChildByName("medal_" .. iter_95_1):getPositionY() + 18)
			var_95_8:setVisible(true)

			if not var_95_8:getChildByName("medalname") then
				local var_95_9 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_95_9:setAnchorPoint(cc.p(0.5, 0.5))
				var_95_9:setPosition(cc.p(var_95_8:getContentSize().width / 2 + 10, var_95_8:getContentSize().height / 2))
				var_95_9:setName("medalname")
				var_95_8:addChild(var_95_9)
			end

			local var_95_10 = item_data[var_95_7[iter_95_1]] or item_data[9100011]

			var_95_8:loadTexture((var_95_10.bg or nil) and ("equipment/" .. var_95_10.bg .. ".png" or var_0_14[var_95_10.equip_quality]))
			var_95_8:getChildByName("medalname"):setString(var_95_10.name)
			var_95_8:getChildByName("medalname"):enableOutline(var_0_15[var_95_10.equip_quality], 1)
			var_95_8:getChildByName("medalname"):enableShadow(var_0_15[var_95_10.equip_quality], cc.size(0, 0))
			var_95_8:getChildByName("medalname"):setVisible(var_95_10.only_bg ~= 1)
		end
	end
end

function WorldBossRankListLayer:MyRankNoShow(arg_98_1)
	self.myrank:setVisible(true)

	local var_98_0 = self.myrank:getChildByName("label_No")
	local var_98_1 = self.myrank:getChildByName("no_ranking")
	local var_98_2 = self.myrank:getChildByName("label_name")
	local var_98_3 = self.myrank:getChildByName("image_icon")
	local var_98_4 = self.myrank:getChildByName("Image_25")
	local var_98_5 = self.myrank:getChildByName("star")
	local var_98_6 = playermodel.nickname

	self.myrank:getChildByName("label_rankjifen"):setString("得分:")

	local var_98_7 = self.myrank:getChildByName("label_rankjifen"):getChildByName("Label_71")

	if arg_98_1 and arg_98_1.score then
		var_98_7:setString(global_trans_number(arg_98_1.score))
	else
		var_98_7:setString("----")
	end

	var_98_7:setPositionY(var_98_7:getPositionY() + 5)
	var_98_3:setVisible(false)

	local var_98_8 = AvatarSprite:create(playermodel.head_sculpture)

	var_98_8:setScale(0.5)
	var_98_8:setPositionX(90)
	self.myrank:addChild(var_98_8)
	var_98_5:setVisible(false)
	var_98_4:setVisible(false)

	local var_98_9 = {}

	var_98_9[1] = playermodel.cur_medal[1] or 0
	var_98_9[2] = playermodel.cur_medal[2] or 0
	var_98_9[3] = playermodel.cur_medal[3] or 0

	for iter_98_0 = 1, 3 do
		if var_98_9[iter_98_0] == 0 then
			self.myrank:getChildByName("medal_" .. iter_98_0):setVisible(false)
		else
			local var_98_10 = self.myrank:getChildByName("medal_" .. iter_98_0)

			var_98_10:setPositionY(var_98_10:getPositionY() + 22)
			var_98_10:setVisible(true)

			if not var_98_10:getChildByName("medalname") then
				local var_98_11 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_98_11:setAnchorPoint(cc.p(0.5, 0.5))
				var_98_11:setPosition(cc.p(var_98_10:getContentSize().width / 2 + 10, var_98_10:getContentSize().height / 2))
				var_98_11:setName("medalname")
				var_98_10:addChild(var_98_11)
			end

			local var_98_12 = item_data[var_98_9[iter_98_0]] or item_data[9100011]

			var_98_10:loadTexture((var_98_12.bg or nil) and ("equipment/" .. var_98_12.bg .. ".png" or var_0_14[var_98_12.equip_quality]))
			var_98_10:getChildByName("medalname"):setString(var_98_12.name)
			var_98_10:getChildByName("medalname"):enableOutline(var_0_15[var_98_12.equip_quality], 1)
			var_98_10:getChildByName("medalname"):enableShadow(var_0_15[var_98_12.equip_quality], cc.size(0, 0))
			var_98_10:getChildByName("medalname"):setVisible(var_98_12.only_bg ~= 1)
		end
	end

	var_98_2:setString(var_98_6)

	if arg_98_1 then
		self.rank11 = arg_98_1.rank
	end

	if not self.rank11 or self.rank11 == 0 then
		self.rank11 = L_SCORE_AREAN_NO_RANK
	end

	if self.rank11 and type(self.rank11) == "number" then
		if tonumber(self.rank11) <= 999 and tonumber(self.rank11) > 0 then
			var_98_0:setVisible(true)
			var_98_1:setVisible(false)
			var_98_0:setString(self.rank11)
		else
			var_98_0:setVisible(false)
			var_98_1:setVisible(true)
		end
	else
		var_98_0:setVisible(false)
		var_98_1:setVisible(true)
	end
end
