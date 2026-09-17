ActivityNewBossFightBaseLayer = class("ActivityNewBossFightBaseLayer", function()
	return cc.Layer:create()
end)

local var_0_0
local var_0_1 = config._DEBUG and 0 or 1
local Utility = require("common.Utility")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local activity_infinity_bossfight_conf = require("data.activity_infinity_bossfight_conf")
local playermodel = require("model.playermodel")
local levelmode_data = require("data.levelmode_data")
local level_manager = require("controller.level_manager")
local time_check_manager = require("controller.time_check_manager")
local adverture_random_manager = require("controller.adverture_random_manager")
local activity_manager = require("controller.activity_manager")
local var_0_12 = require("controller.formation.formation_manager"):getInstance()
local drop_manager = require("controller.drop_manager")
local network = require("network.network")
local var_0_15 = 640
local var_0_16 = 180

function ActivityNewBossFightBaseLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityNewBossFightBaseLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityNewBossFightBaseLayer:init(arg_3_1)
	self.rootlayer = cc.Layer:create()

	self:addChild(self.rootlayer)

	self.activityId = arg_3_1.activityId
	self.respath = "activitiesRes/activity" .. self.activityId .. "/bossfight/"
	self.bg = ccui.ImageView:create(self.respath .. "randomade_bg.png")

	self.bg:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - GameDisplay.fix_y)
	self.rootlayer:addChild(self.bg, -1)

	self.modetype = self.activityId * 10 + 1

	self:request(function()
		self:updateData()
		self:initUI()
	end)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			-- block empty
		elseif arg_5_0 == "enter" then
			FightManager:endFightActivityBossRound()
		end
	end)
end

local function var_0_17(arg_6_0)
	local var_6_5 = global_get_time_by_date(arg_6_0) - time_check_manager:getCurTime()
	local var_6_6 = math.floor(var_6_5 / 24 / 3600)
	local var_6_7 = math.floor((var_6_5 - var_6_6 * 24 * 3600) / 3600)
	local var_6_8 = math.floor((var_6_5 - var_6_6 * 24 * 3600 - var_6_7 * 3600) / 60)

	return 0 ~= 0 and string.format(L_TIME_TEXT[1], var_6_6, var_6_7) or var_6_7 ~= 0 and string.format(L_TIME_TEXT[2], var_6_7, var_6_8) or string.format(L_TIME_TEXT[3], var_6_8)
end

function ActivityNewBossFightBaseLayer:initUI()
	self:initTbleView()
	self:initTitle()
	self:initBottom()
	self:initRewardLayer()
end

function ActivityNewBossFightBaseLayer:request(arg_8_1)
	network:rpc("get_activity_infinity_bossfight_info", {
		activityid = self.activityId
	}, function(arg_9_0)
		print(dump(arg_9_0), "qqqqqqqqqqq")

		if arg_9_0.result == 1 then
			self.curRound = arg_9_0.round
			self.random_levelmode = arg_9_0.random_levelmode
			self.round_reward = arg_9_0.round_reward

			if arg_9_0.new_round then
				self:update(function()
					self:updateData()
					self:initUI()
				end)
			else
				arg_8_1()
			end
		end
	end)
end

function ActivityNewBossFightBaseLayer:update(arg_11_1)
	network:rpc("get_levelmode_by_modetype", {
		modetypes = {
			self.modetype
		}
	}, function(arg_12_0)
		playermodel:updateLevelMode(arg_12_0.mode)
		arg_11_1()
		self:updateData()
		self:updateUI()
	end)
end

function ActivityNewBossFightBaseLayer:updateData(arg_13_1)
	if not activity_infinity_bossfight_conf then
		return
	end

	self.rewardlist = {}

	local var_13_0 = 1

	while activity_infinity_bossfight_conf[self.activityId]["round_" .. var_13_0] do
		self.rewardlist[var_13_0] = {}
		self.rewardlist[var_13_0].round = activity_infinity_bossfight_conf[self.activityId]["round_" .. var_13_0]
		self.rewardlist[var_13_0].drop = activity_infinity_bossfight_conf[self.activityId]["drop_" .. var_13_0]
		var_13_0 = var_13_0 + 1
	end

	self.roundCount = var_13_0

	local var_13_1 = {}

	for iter_13_0 in string.gmatch(activity_infinity_bossfight_conf[self.activityId].resettime or nil, "[^,]+") do
		table.insert(var_13_1, iter_13_0)
	end

	local var_13_2 = 0
	local var_13_3 = ""

	for iter_13_1, iter_13_2 in pairs(var_13_1) do
		if global_get_time_by_date(iter_13_2) < time_check_manager:getCurTime() and global_get_time_by_date(var_13_1[iter_13_1 + 1]) > time_check_manager:getCurTime() then
			var_13_3 = var_0_17(var_13_1[iter_13_1 + 1])
			var_13_2 = iter_13_1

			break
		end
	end

	self.finishTime = var_13_3
	self.curStage = var_13_2
	self.totalStage = #var_13_1 - 1
	self.bossList = activity_manager:getBossFightLevelList(self.activityId)

	table.sort(self.bossList, function(arg_14_0, arg_14_1)
		return arg_14_0.order < arg_14_1.order
	end)

	self.curlevel = 0
	self.levelList = {}
	self.boss = {}

	for iter_13_3, iter_13_4 in ipairs(self.bossList) do
		if iter_13_3 < 6 then
			table.insert(self.boss, iter_13_4)
		elseif iter_13_3 >= 6 and self.random_levelmode == iter_13_4.mode then
			iter_13_4.order = 6

			table.insert(self.boss, iter_13_4)
		end
	end

	for iter_13_5, iter_13_6 in pairs(self.boss) do
		table.insert(self.levelList, level_manager:isPlayerPassLevel({
			mode = iter_13_6.mode,
			chapter = iter_13_6.totalchapter
		}))
	end

	print(dump(self.levelList), "llllllllll")

	for iter_13_7, iter_13_8 in pairs(self.levelList) do
		if not iter_13_8 then
			self.curlevel = iter_13_7

			break
		end
	end

	print(self.curlevel, "cccc")

	if arg_13_1 then
		arg_13_1()
	end
end

function ActivityNewBossFightBaseLayer:initTitle()
	local var_15_0 = ccui.ImageView:create(self.respath .. "banner.png", var_0_0)

	var_15_0:setAnchorPoint(0, 1)
	var_15_0:setPosition(0, GameDisplay.top - GameDisplay.fix_y)
	self.rootlayer:addChild(var_15_0)

	local var_15_1 = ccui.ImageView:create(self.respath .. "title.png", var_0_0)

	var_15_1:setPosition(200, 165)
	var_15_0:addChild(var_15_1)

	local var_15_2 = ccui.ImageView:create(self.respath .. "time.png", var_0_0)

	var_15_2:setPosition(200, 50)
	var_15_0:addChild(var_15_2)

	local var_15_3

	if self.curStage then
		var_15_3 = self.curStage or 0

		local var_15_4

		if self.totalStage then
			var_15_4 = self.totalStage or 0

			local var_15_5

			if self.finishTime then
				var_15_5 = self.finishTime or 0

				local var_15_6

				if self.curRound then
					var_15_6 = self.curRound or 0
				end
			end
		end
	end

	local var_15_7 = cc.Label:createWithTTF(string.format(L_ACTRECHARGETP[1], var_15_3, var_15_4), FONT_NAME, 22)

	var_15_2:addChild(var_15_7)
	var_15_7:setPosition(70, 20)

	self.stageLabel = var_15_7

	local var_15_8 = cc.Label:createWithTTF(var_15_5 .. L_ACTRECHARGETP[2], FONT_NAME, 22)

	var_15_2:addChild(var_15_8)
	var_15_8:setPosition(250, 20)

	local var_15_9 = ccui.ImageView:create(self.respath .. "round_bg.png", var_0_0)

	var_15_9:setAnchorPoint(0, 0.5)
	var_15_9:setPosition(0, var_15_0:getPositionY() - 20 - var_15_0:getContentSize().height)
	self.rootlayer:addChild(var_15_9)

	local var_15_10 = cc.Label:createWithTTF(string.format(L_ACTRECHARGETP[3], var_15_6), FONT_NAME, 22)

	var_15_10:setPosition(320, 16)
	var_15_9:addChild(var_15_10)
end

function ActivityNewBossFightBaseLayer:updateTitle()
	self.stageLabel:setString(cc.Label:createWithTTF(string.format(L_ACTRECHARGETP[1], self.curStage, self.totalStage), FONT_NAME, 22))
end

function ActivityNewBossFightBaseLayer:initBottom()
	local var_17_0 = ccui.ImageView:create(self.respath .. "ade_back_bg.png", var_0_0)

	var_17_0:setAnchorPoint(0, 0)
	var_17_0:setPosition(0, -GameDisplay.fix_y)
	self.rootlayer:addChild(var_17_0)

	local var_17_1 = ccui.Button:create(self.respath .. "ade_back.png", nil, self.respath .. "ade_back.png", var_0_0)

	var_17_1:setPosition(50, 35)
	var_17_0:addChild(var_17_1)
	var_17_1:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	local var_17_2 = ccui.Button:create(self.respath .. "btn_rank.png", nil, self.respath .. "btn_rank.png", var_0_0)

	var_17_2:setPosition(390, 35)
	var_17_0:addChild(var_17_2)
	var_17_2:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("ActivityBossFightRankLayer", {
			activityid = self.activityId,
			maxScore = self.curRound
		})
	end)

	local var_17_3 = ccui.Button:create(self.respath .. "btn_reward.png", nil, self.respath .. "btn_reward.png", var_0_0)

	var_17_3:setPosition(550, 35)
	var_17_0:addChild(var_17_3)
	var_17_3:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.layout:setVisible(true)
		self.layout:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 1.1), cc.ScaleTo:create(0.1, 1, 1)))
	end)
end

function ActivityNewBossFightBaseLayer:updateUI()
	for iter_21_0 = 1, #self.boss do
		self.bossTableView:updateCellAtIndex(iter_21_0 - 1)
	end

	for iter_21_1 = 1, self.roundCount do
		self.rewardTableView:updateCellAtIndex(iter_21_1 - 1)
	end

	self.bossTableView:reloadData()
	self.rewardTableView:reloadData()
	self:updateTitle()
end

function ActivityNewBossFightBaseLayer:initTbleView()
	local var_22_0 = cc.TableView:create(cc.size(640, 740 + GameDisplay.fix_y * 2))

	var_22_0:setPosition(cc.p(0, 180 - GameDisplay.fix_y))
	var_22_0:setDelegate()
	var_22_0:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_22_0:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.bg:addChild(var_22_0)

	self.bossTableView = var_22_0

	var_22_0:registerScriptHandler(function(arg_24_0, arg_24_1)
		return var_0_15, var_0_16
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_22_0:registerScriptHandler(function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_0:dequeueCell()

		if not var_23_0 then
			var_23_0 = cc.TableViewCell:create()

			local var_23_1 = self:createNode(arg_23_1 + 1)

			var_23_1:setName("node")
			var_23_1:setPosition(cc.p(var_0_15 / 2, var_0_16 / 2))
			var_23_0:addChild(var_23_1)
		else
			local var_23_2 = var_23_0:getChildByName("node")

			var_23_2:setOpacity(255)
			self:updateNode(var_23_2, arg_23_1 + 1)
		end

		return var_23_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_22_0:registerScriptHandler(function(arg_25_0, arg_25_1)
		return #self.boss
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_22_0:reloadData()
end

function ActivityNewBossFightBaseLayer:createNode(arg_26_1)
	local var_26_0 = cc.Node:create()
	local var_26_1 = self.boss[arg_26_1]

	if not self.boss[arg_26_1] then
		return var_26_0
	end

	local var_26_2 = "fire"

	for iter_26_0, iter_26_1 in pairs(model_data[var_26_1.show_boss]) do
		if ATTR_INDEX[iter_26_0] and ATTR_INDEX[iter_26_0] >= 0 then
			var_26_2 = iter_26_0
		end
	end

	local var_26_3 = ccui.ImageView:create(self.respath .. "boss_bg.png")

	var_26_3:setAnchorPoint(0.5, 0.5)
	var_26_0:addChild(var_26_3)

	local var_26_4 = ccui.ImageView:create(self.respath .. "unlock.png")

	var_26_4:setName("unlockImg")
	var_26_4:setLocalZOrder(999)
	var_26_0:addChild(var_26_4)

	local var_26_5 = ccui.ImageView:create(self.respath .. "lock.png")

	var_26_5:setPosition(220, 80)
	var_26_4:addChild(var_26_5)

	local var_26_6 = cc.Label:createWithTTF(L_BOSSFIGHTLAYER[1], FONT_NAME, 28)

	var_26_6:setPosition(340, 80)
	var_26_4:addChild(var_26_6)

	local var_26_7 = ccui.ImageView:create(self.respath .. "monster.png")

	var_26_7:setPosition(-230, 5)
	var_26_7:setName("monsterbg")
	var_26_0:addChild(var_26_7)

	local var_26_8 = ccui.Button:create()

	var_26_8:loadTextures(CUTE_ROLE_IMAGE_PATH .. model_data[var_26_1.show_boss].cute_role .. ".png", nil, CUTE_ROLE_IMAGE_PATH .. model_data[var_26_1.show_boss].cute_role .. ".png")
	var_26_8:setScale(0.4)
	var_26_8:setPosition(80, 80)
	var_26_8:setName("bossImg")
	var_26_7:addChild(var_26_8)

	local var_26_9 = cc.Label:createWithTTF(model_data[var_26_1.show_boss].name, FONT_NAME, 28)

	var_26_9:setColor(cc.c3b(169, 76, 76))
	var_26_9:setAnchorPoint(0, 0)
	var_26_9:setPosition(-85, 42)
	var_26_9:setName("bossName")
	var_26_0:addChild(var_26_9)

	local var_26_10 = ccui.ImageView:create(self.respath .. "attr_bg.png")

	var_26_10:setPosition(-120, 60)
	var_26_10:setName("attrBg")
	var_26_0:addChild(var_26_10)

	local var_26_11 = ccui.ImageView:create("public/career_icon/" .. var_26_2 .. ".png", var_0_1)

	var_26_11:setPosition(24, 24)
	var_26_11:setScale(0.7, 0.7)
	var_26_11:setName("attrImg")
	var_26_10:addChild(var_26_11)

	local var_26_12 = cc.Label:createWithTTF("0" .. arg_26_1, FONT_NAME, 32)

	var_26_12:setPosition(270, 57)
	var_26_12:setName("numLabel")
	var_26_0:addChild(var_26_12)

	local var_26_13 = ccui.Button:create(self.respath .. "btn_change.png", nil, self.respath .. "btn_finish.png", var_0_0)

	var_26_13:setPosition(240, -30)
	var_26_13:setName("challenge")
	var_26_0:addChild(var_26_13)
	var_26_13:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_27_0()
			if tolua.isnull(arg_27_0) then
				return
			end

			arg_27_0:setBright(true)
		end

		RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", var_26_1.modetype)
		self:dealChangeBtn(var_26_1.mode, var_26_1.levelperchapter, var_27_0)
	end)

	if arg_26_1 < self.curlevel then
		var_26_13:setBright(false)
		var_26_13:setTouchEnabled(false)
	end

	if arg_26_1 > self.curlevel then
		var_26_4:setVisible(true)
		var_26_13:setTouchEnabled(false)
	else
		var_26_4:setVisible(false)
	end

	local var_26_14 = 1
	local var_26_15 = 0

	while var_26_1["show_item" .. var_26_14] do
		local var_26_17 = var_26_1["show_item" .. var_26_14]

		if not item_data[var_26_1["show_item" .. var_26_14]].equip_quality then
			break
		end

		local var_26_18 = ccui.ImageView:create()

		var_26_18:setPosition(-160 + var_26_14 * 90, -27)
		var_26_18:setName("item" .. var_26_14)
		var_26_0:addChild(var_26_18)

		local var_26_19 = type(var_26_17) == "string" and ccui.Button:create("public/box/1.png", "public/box/1.png", nil, var_0_1) or ccui.Button:create("public/box/" .. item_data[var_26_1["show_item" .. var_26_14]].equip_quality .. ".png", "public/box/" .. item_data[var_26_1["show_item" .. var_26_14]].equip_quality .. ".png", nil, var_0_1)

		var_26_19:setAnchorPoint(cc.p(0.5, 0.5))
		var_26_19:setPosition(cc.p(0, 0))
		var_26_19:setTouchEnabled(true)
		var_26_19:setSwallowTouches(false)
		var_26_19:setPosition(cc.p(var_26_18:getContentSize().width / 2, var_26_18:getContentSize().height / 2 + 4))
		var_26_19:setName("awarditem")
		var_26_18:addChild(var_26_19, 1)

		local var_26_20
		local var_26_21

		if item_data[var_26_17].bag_item_type == kITEM_SCULTURE then
			var_26_21 = AvatarSprite:create(var_26_17)
		elseif item_data[var_26_17].bag_item_type == kITEM_MEDAL then
			var_26_21 = ItemSprite:create_medal_icon(var_26_17)
		elseif item_data[var_26_17].bag_item_type == kITEM_COMPONENT then
			var_26_21 = componentManager:create_component_icon(var_26_17, nil, nil)
		elseif item_data[var_26_17].image_id then
			var_26_20 = "equipment/" .. item_data[var_26_17].image_id .. ".png"
		end

		var_26_21 = var_26_21 or ccui.ImageView:create(var_26_20)

		var_26_21:setPosition(cc.p(var_26_19:getContentSize().width / 2, var_26_19:getContentSize().height / 2))
		var_26_21:setName("ItemSprite")

		local var_26_22 = math.min(var_26_21:getContentSize().width, var_26_21:getContentSize().height)
		local var_26_23 = 80 / var_26_22

		if var_26_17 and item_data[var_26_17] and item_data[var_26_17].bag_item_type == kITEM_SCULTURE then
			var_26_23 = 130 / var_26_22

			var_26_21:setPosition(cc.p(0, 10))
		end

		var_26_21:setScale(var_26_23)
		var_26_19:addChild(var_26_21)

		local var_26_24 = ccui.ImageView:create(self.respath .. "get.png", var_0_0)

		var_26_24:setPosition(cc.p(var_26_19:getContentSize().width / 2, var_26_19:getContentSize().height / 2))
		var_26_24:setName("getImg")
		var_26_19:addChild(var_26_24)

		if arg_26_1 < self.curlevel then
			var_26_24:setVisible(true)
		else
			var_26_24:setVisible(false)
		end

		var_26_19:addTouchEventListener(function(arg_29_0, arg_29_1)
			if arg_29_1 ~= ccui.TouchEventType.ended then
				return
			end

			showItemDetails(var_26_17)
		end)

		var_26_14 = var_26_14 + 1
		var_26_15 = var_26_15 + 1
	end

	return var_26_0
end

function ActivityNewBossFightBaseLayer:updateNode(arg_30_1, arg_30_2)
	local var_30_0 = self.boss[arg_30_2]
	local var_30_1 = "fire"

	for iter_30_0, iter_30_1 in pairs(model_data[self.boss[arg_30_2].show_boss]) do
		if ATTR_INDEX[iter_30_0] and ATTR_INDEX[iter_30_0] >= 0 then
			var_30_1 = iter_30_0
		end
	end

	arg_30_1:getChildByName("monsterbg"):getChildByName("bossImg"):loadTextures(CUTE_ROLE_IMAGE_PATH .. model_data[self.boss[arg_30_2].show_boss].cute_role .. ".png", nil, CUTE_ROLE_IMAGE_PATH .. model_data[self.boss[arg_30_2].show_boss].cute_role .. ".png")
	arg_30_1:getChildByName("bossName"):setString(model_data[self.boss[arg_30_2].show_boss].name)
	arg_30_1:getChildByName("numLabel"):setString("0" .. arg_30_2)
	arg_30_1:getChildByName("attrBg"):getChildByName("attrImg"):loadTexture("public/career_icon/" .. var_30_1 .. ".png", var_0_1)
	arg_30_1:getChildByName("challenge"):setTouchEnabled(true)
	arg_30_1:getChildByName("challenge"):setBright(true)

	if arg_30_2 < self.curlevel then
		arg_30_1:getChildByName("challenge"):setBright(false)
		arg_30_1:getChildByName("challenge"):setTouchEnabled(false)
	end

	if arg_30_2 > self.curlevel then
		arg_30_1:getChildByName("unlockImg"):setVisible(true)
		arg_30_1:getChildByName("challenge"):setTouchEnabled(false)
	else
		arg_30_1:getChildByName("unlockImg"):setVisible(false)
	end

	arg_30_1:getChildByName("challenge"):addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_31_0()
			if tolua.isnull(arg_31_0) then
				return
			end

			arg_31_0:setBright(true)
		end

		RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", var_30_0.modetype)
		self:dealChangeBtn(var_30_0.mode, var_30_0.levelperchapter, var_31_0)
	end)

	while arg_30_1:getChildByName("item" .. 1) do
		local var_30_2 = arg_30_1:getChildByName("item" .. 1):getChildByName("awarditem")
		local var_30_3

		if var_30_2 then
			var_30_3 = var_30_2:getChildByName("getImg")
		end

		if var_30_3 then
			if arg_30_2 < self.curlevel then
				var_30_3:setVisible(true)
			else
				var_30_3:setVisible(false)
			end
		end
	end
end

function ActivityNewBossFightBaseLayer.dealChangeBtn(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = arg_33_1
	local var_33_1 = arg_33_2
	local var_33_2, var_33_3 = level_manager:isModeValid(arg_33_1)

	if not var_33_2 then
		audioManager:playeffectMusicTest("sound/invalid")
		global_ShowBlockWords(level_manager:getModeUnlockMsg(arg_33_1, var_33_3))

		return
	end

	local function var_33_4(arg_34_0)
		if arg_34_0 == 1 then
			if playermodel.curMode then
				for iter_34_0, iter_34_1 in pairs(arg_33_0.boss) do
					if iter_34_1.mode == playermodel.curMode then
						FightManager.startFightActivityBossRound(arg_33_0.curRound)
					end
				end
			end

			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})
			FightManager.refreshFightToType(FIGHTTYPE_ADVENTURE)
		else
			if arg_34_0 == 2 then
				audioManager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[2])
			elseif arg_34_0 == 3 then
				audioManager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[3])
			elseif arg_34_0 == 4 then
				audioManager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[4])
			elseif arg_34_0 == 5 then
				audioManager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[5])
			elseif arg_34_0 == 6 then
				audioManager:playeffectMusicTest("sound/invalid")

				if chapterData["" .. var_33_0 .. "-" .. var_33_1] and chapterData["" .. var_33_0 .. "-" .. var_33_1].boss_combat then
					global_ShowBlockWords(L_ADVENTURE_WARNING[6] .. chapterData["" .. var_33_0 .. "-" .. var_33_1].boss_combat .. L_ADVENTURE_WARNING[7])
				end
			end

			GuideListener.showAllGuidesWithFullScreen(true)
		end
	end

	local function var_33_5(arg_35_0)
		GuideListener.showAllGuidesWithFullScreen(false)
		RoleDefault:getInstance():setIntegerForKey("adventurearray", arg_35_0)
		RoleDefault:getInstance():setIntegerForKey("lastadventurearray", arg_35_0)
		level_manager:switchToAdventureMode(var_33_0, var_33_1, var_33_4, arg_35_0)
	end

	LayerManager:pushInLayer("LevelDetailLayer", {
		fight_type = "ADVENTURE",
		level = 1,
		mode = arg_33_1,
		chapter = arg_33_2,
		callback = arg_33_3,
		adventuresurecallback = function()
			local var_36_0 = {
				mode = var_33_0
			}

			var_36_0.defaultIndex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)
			var_36_0.configcallback = var_33_5
			var_36_0.exitcallback = arg_33_3

			var_0_12:pushFormationLayer("FormationElementsLayer", var_36_0)
		end,
		initindex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)
	})
end

function ActivityNewBossFightBaseLayer:initRewardLayer()
	local var_37_0 = ccui.Layout:create()

	var_37_0:setContentSize(cc.size(640, 1600))
	var_37_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_37_0:setCascadeOpacityEnabled(true)
	var_37_0:setBackGroundColorOpacity(128)
	var_37_0:setAnchorPoint(0.5, 0.5)
	var_37_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_37_0:setPosition(GameDisplay.cx, GameDisplay.cy + 200 - GameDisplay.fix_y * 3)
	var_37_0:setTouchEnabled(true)
	var_37_0:setLocalZOrder(1000)
	var_37_0:setName("layout")
	var_37_0:setVisible(false)
	self.rootlayer:addChild(var_37_0)

	self.layout = var_37_0
	self.rewardPath = self.respath .. "reward/"

	local var_37_1 = ccui.ImageView:create(self.rewardPath .. "bg.png", var_0_0)

	var_37_1:setPosition(320, GameDisplay.height / 2 + GameDisplay.fix_y)
	var_37_0:addChild(var_37_1)

	local var_37_2 = ccui.Button:create(self.rewardPath .. "btn_close.png", nil, self.rewardPath .. "btn_close.png", var_0_0)

	var_37_2:setPosition(600, 980)
	var_37_2:setLocalZOrder(999)
	var_37_1:addChild(var_37_2)
	var_37_2:addTouchEventListener(function(arg_38_0, arg_38_1)
		if arg_38_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_37_0:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0), cc.CallFunc:create(function()
			self.layout:setVisible(false)
		end)))
	end)

	local var_37_3 = cc.Label:createWithTTF(L_BOSSFIGHTLAYER[2], FONT_NAME, 22)

	var_37_3:setPosition(320, 800)
	var_37_1:addChild(var_37_3)

	local var_37_4 = cc.TableView:create(cc.size(600, 700))

	var_37_4:setPosition(cc.p(10, 50))
	var_37_4:setDelegate()
	var_37_4:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_37_4:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)

	self.rewardTableView = var_37_4

	var_37_1:addChild(var_37_4)
	var_37_4:registerScriptHandler(function(arg_41_0, arg_41_1)
		return 600, 200
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_37_4:registerScriptHandler(function(arg_40_0, arg_40_1)
		local var_40_0 = arg_40_0:dequeueCell()

		if not var_40_0 then
			var_40_0 = cc.TableViewCell:create()

			local var_40_1 = self:createRewardNode(arg_40_1 + 1)

			var_40_1:setName("node")
			var_40_1:setAnchorPoint(cc.p(0, 0))
			var_40_1:setPosition(cc.p(0, 70))
			var_40_0:addChild(var_40_1)
		else
			local var_40_2 = var_40_0:getChildByName("node")

			var_40_2:setOpacity(255)
			self:updateRewardNode(var_40_2, arg_40_1 + 1)
		end

		return var_40_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_37_4:registerScriptHandler(function(arg_42_0, arg_42_1)
		return self.roundCount - 1
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_37_4:reloadData()
end

function ActivityNewBossFightBaseLayer:createRewardNode(arg_43_1)
	local var_43_0 = cc.Node:create()
	local var_43_1 = self.rewardlist[arg_43_1].round
	local var_43_2 = cc.Label:createWithTTF(string.format(L_BOSSFIGHTLAYER[5], self.rewardlist[arg_43_1].round), FONT_NAME, 24)

	var_43_2:setName("desLabel")
	var_43_2:setColor(cc.c3b(243, 199, 139))
	var_43_2:setAnchorPoint(0, 0)
	var_43_2:setPosition(80, 90)
	var_43_0:addChild(var_43_2)

	local var_43_3 = 2

	if self.rewardlist[arg_43_1].round < self.curRound then
		var_43_3 = 0
	end

	for iter_43_0, iter_43_1 in pairs(self.round_reward) do
		if self.rewardlist[arg_43_1].round == iter_43_1 then
			var_43_3 = 1
		end
	end

	local var_43_4 = ccui.ImageView:create(self.rewardPath .. "cell_bg.png", var_0_0)

	var_43_4:setAnchorPoint(0, 0)
	var_43_4:setPosition(80, -50)
	var_43_4:setName("bg")
	var_43_0:addChild(var_43_4)

	local var_43_5 = ccui.ImageView:create(self.rewardPath .. "progress_bg.png", var_0_0)

	var_43_5:setPosition(cc.p(50, 0))
	var_43_0:addChild(var_43_5)

	local var_43_6 = cc.ProgressTimer:create(cc.Sprite:create(self.rewardPath .. "progress_fill.png") or cc.Sprite:createWithSpriteFrameName(self.rewardPath .. "progress_fill.png"))

	var_43_6:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	var_43_6:setMidpoint(cc.p(0.5, 1))
	var_43_6:setBarChangeRate(cc.p(0, -1))
	var_43_6:setPosition(cc.p(50, 0))
	var_43_6:setName("progress")
	var_43_0:addChild(var_43_6)

	if var_43_3 == 0 or var_43_3 == 1 then
		var_43_6:setPercentage(100)
	else
		var_43_6:setPercentage(0)
	end

	if arg_43_1 == #self.round_reward + 1 then
		-- block empty
	end

	local var_43_8 = ccui.ImageView:create(var_43_3 == 0 and self.rewardPath .. "mstar.png" or self.rewardPath .. "star.png", var_0_0)

	var_43_8:setName("star")
	var_43_8:setPosition(50, 100)
	var_43_8:setLocalZOrder(99)
	var_43_0:addChild(var_43_8)

	local var_43_9 = drop_manager:getDropMsg(self.rewardlist[arg_43_1].drop)

	for iter_43_2 = 1, 3 do
		local var_43_10 = ItemSpriteActivityRecharge:createSignItem()

		var_43_10:setName("sp" .. iter_43_2)
		var_43_10:setPosition(60 + (iter_43_2 - 1) * 95, var_43_4:getContentSize().height / 2)
		var_43_4:addChild(var_43_10)
		var_43_10:setInfoTouchEvent(true)
		var_43_10:setSwallowTouches(false)
		var_43_10:setVisible(false)
	end

	table.sort(var_43_9.equips, function(arg_44_0, arg_44_1)
		return arg_44_0._index < arg_44_1._index
	end)

	local var_43_11 = {}

	if var_43_9.diamond > 0 then
		table.insert(var_43_11, {
			itemid = "diamond",
			num = var_43_9.diamond,
			name = L_DIAMOND
		})
	end

	if var_43_9.gold > 0 then
		table.insert(var_43_11, {
			itemid = "gold",
			num = var_43_9.gold,
			name = L_GOLD
		})
	end

	local var_43_12 = {}

	for iter_43_3, iter_43_4 in pairs(var_43_9.equips) do
		table.insert(var_43_12, {
			itemid = iter_43_4.dropid,
			num = iter_43_4.dropNum,
			name = item_data[iter_43_4.dropid].name
		})
	end

	for iter_43_5, iter_43_6 in pairs(var_43_12) do
		table.insert(var_43_11, iter_43_6)
	end

	if var_43_11 then
		for iter_43_7, iter_43_8 in pairs(var_43_11) do
			var_43_4:getChildByName("sp" .. iter_43_7):updateSignItemByItemid(var_43_11[iter_43_7].itemid, var_43_11[iter_43_7].num)
			var_43_4:getChildByName("sp" .. iter_43_7):setVisible(true)
		end
	end

	local var_43_13 = ccui.Button:create()

	if var_43_3 == 0 then
		var_43_13:loadTextures(self.rewardPath .. "btn_get.png", nil, self.rewardPath .. "btn_get.png", var_0_0)
	elseif var_43_3 == 1 then
		var_43_13:loadTextures(self.rewardPath .. "btn_reward_on.png", nil, self.rewardPath .. "btn_reward_on.png", var_0_0)
		var_43_13:setTouchEnabled(false)
	elseif var_43_3 == 2 then
		var_43_13:loadTextures(self.rewardPath .. "btn_reward_off.png", nil, self.rewardPath .. "btn_reward_off.png", var_0_0)
		var_43_13:setTouchEnabled(false)
	end

	var_43_13:setPosition(500, 0)
	var_43_13:setName("btnGet")
	var_43_0:addChild(var_43_13)
	var_43_13:addTouchEventListener(function(arg_45_0, arg_45_1)
		if arg_45_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:getReward(var_43_1)
	end)

	if var_43_3 == 0 then
		var_43_13:setBright(false)
	else
		var_43_13:setBright(true)
	end

	return var_43_0
end

function ActivityNewBossFightBaseLayer:updateRewardNode(arg_46_1, arg_46_2)
	local var_46_0 = self.rewardlist[arg_46_2].round

	arg_46_1:getChildByName("desLabel"):setString(string.format(L_BOSSFIGHTLAYER[5], self.rewardlist[arg_46_2].round))

	local var_46_1 = 2

	if self.rewardlist[arg_46_2].round < self.curRound then
		var_46_1 = 0
	end

	for iter_46_0, iter_46_1 in pairs(self.round_reward) do
		if self.rewardlist[arg_46_2].round == iter_46_1 then
			var_46_1 = 1
		end
	end

	local var_46_2 = arg_46_1:getChildByName("progress")

	if var_46_1 == 0 or var_46_1 == 1 then
		var_46_2:setPercentage(100)
		var_46_2:setVisible(true)
	else
		var_46_2:setPercentage(0)
		var_46_2:setVisible(false)
	end

	arg_46_1:getChildByName("star"):loadTexture(var_46_1 == 0 and self.rewardPath .. "mstar.png" or self.rewardPath .. "star.png", var_0_0)

	local var_46_4 = arg_46_1:getChildByName("btnGet")

	var_46_4:setTouchEnabled(true)

	if var_46_1 == 0 then
		var_46_4:loadTextures(self.rewardPath .. "btn_get.png", nil, self.rewardPath .. "btn_get.png", var_0_0)
	elseif var_46_1 == 1 then
		var_46_4:loadTextures(self.rewardPath .. "btn_reward_on.png", nil, self.rewardPath .. "btn_reward_on.png", var_0_0)
		var_46_4:setTouchEnabled(false)
	elseif var_46_1 == 2 then
		var_46_4:loadTextures(self.rewardPath .. "btn_reward_off.png", nil, self.rewardPath .. "btn_reward_off.png", var_0_0)
		var_46_4:setTouchEnabled(false)
	end

	var_46_4:addTouchEventListener(function(arg_47_0, arg_47_1)
		if arg_47_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:getReward(var_46_0)
	end)

	local var_46_5 = drop_manager:getDropMsg(self.rewardlist[arg_46_2].drop)
	local var_46_6 = arg_46_1:getChildByName("bg")

	table.sort(var_46_5.equips, function(arg_48_0, arg_48_1)
		return arg_48_0._index < arg_48_1._index
	end)

	local var_46_7 = {}

	if var_46_5.diamond > 0 then
		table.insert(var_46_7, {
			itemid = "diamond",
			num = var_46_5.diamond,
			name = L_DIAMOND
		})
	end

	if var_46_5.gold > 0 then
		table.insert(var_46_7, {
			itemid = "gold",
			num = var_46_5.gold,
			name = L_GOLD
		})
	end

	local var_46_8 = {}

	for iter_46_2, iter_46_3 in pairs(var_46_5.equips) do
		table.insert(var_46_8, {
			itemid = iter_46_3.dropid,
			num = iter_46_3.dropNum,
			name = item_data[iter_46_3.dropid].name
		})
	end

	for iter_46_4, iter_46_5 in pairs(var_46_8) do
		table.insert(var_46_7, iter_46_5)
	end

	if var_46_7 then
		for iter_46_6, iter_46_7 in pairs(var_46_7) do
			var_46_6:getChildByName("sp" .. iter_46_6):updateSignItemByItemid(var_46_7[iter_46_6].itemid, var_46_7[iter_46_6].num)
			var_46_6:getChildByName("sp" .. iter_46_6):setVisible(true)
		end
	end
end

function ActivityNewBossFightBaseLayer:getReward(arg_49_1)
	network:rpc("get_activity_infinity_bossfight_reward", {
		activityid = self.activityId,
		index = arg_49_1
	}, function(arg_50_0)
		print(dump(arg_50_0), "mmmmmmmmmmm")

		if arg_50_0.result == 1 then
			if arg_50_0.items and #arg_50_0.items > 0 then
				global_gain({
					items = arg_50_0.items,
					gold = arg_50_0.gold,
					diamond = arg_50_0.diamond
				})
				self:request(function()
					self:updateUI()
				end)
			end
		elseif arg_50_0.result == 2 then
			global_ShowBlockWords(L_BOSSFIGHTLAYER[3])
		elseif arg_50_0.result == 3 then
			global_ShowBlockWords(L_BOSSFIGHTLAYER[4])
		end
	end)
end
