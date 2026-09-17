OldSubstitutionLayer = class("OldSubstitutionLayer", function()
	return cc.Layer:create()
end)

local net_dispatcher = require("network.net_dispatcher")
local item_manager = require("controller.item_manager")
local network = require("network.network")
local var_0_4 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local shop_data = require("data.shop_data")
local shop_manager = require("controller.shop_manager")
local account_manager = require("controller.account_manager")
local ItemSprite = require("view.Sprite.ItemSprite")
local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local levelmode_data = require("data.levelmode_data")
local alert_manager = require("controller.alert_manager")
local time_check_manager = require("controller.time_check_manager")
local drop_manager = require("controller.drop_manager")
local old_substitution_manager = require("controller.old_substitution_manager")
local var_0_19 = 601

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")

local var_0_20 = "OldSubstitutionLayer/"

local function var_0_21(arg_2_0)
	local var_2_0 = -1
	local var_2_1 = require("data.horcrux_data")[arg_2_0].horcruxt

	for iter_2_0, iter_2_1 in pairs((require("data.photofile_HelpGirl_data"))) do
		if arg_2_0 == iter_2_1.item_id then
			var_2_0 = iter_2_0

			break
		end
	end

	if var_2_0 == -1 then
		return
	end

	LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
		id = var_2_0,
		itemid = arg_2_0
	})
end

local function var_0_22(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = drop_manager:getDropMsg(arg_3_0)
	local var_3_1
	local var_3_2

	if not arg_3_2 then
		if var_3_0.gold ~= 0 then
			var_3_1 = "gold"
			var_3_2 = var_3_0.gold
		elseif var_3_0.diamond ~= 0 then
			var_3_1 = "diamond"
			var_3_2 = var_3_0.diamond
		elseif var_3_0.equips then
			for iter_3_0, iter_3_1 in pairs(var_3_0.equips) do
				var_3_1 = iter_3_1.dropid
				var_3_2 = iter_3_1.dropNum
			end
		end
	else
		var_3_1 = arg_3_2
		var_3_2 = arg_3_3
	end

	local var_3_4 = ccui.ImageView:create()

	if item_data[var_3_1].bag_item_type == kITEM_SKIN then
		var_3_4:loadTexture("roleimage/role1/" .. model_data[item_data[var_3_1].model].cute_role .. ".png")
		var_3_4:setScale(0.3)
	elseif item_data[var_3_1].bag_item_type == kITEM_HORCRUX then
		local var_3_5 = drop_manager:getAllDropsNotMerge(arg_3_0)[1].item_attr
		local var_3_6 = ccui.Layout:create()

		var_3_6:setName("starsPanel")
		var_3_6:setScale(1.75)
		var_3_6:setPositionY(58)
		var_3_6:setPositionX(200)
		var_3_4:addChild(var_3_6, 5)

		local var_3_7 = 0

		if var_3_5 then
			for iter_3_2, iter_3_3 in var_3_5:gmatch("([^&]+)=([^&]+)") do
				if iter_3_2 == "star" then
					var_3_7 = tonumber(iter_3_3)
				end
			end
		end

		for iter_3_4 = 1, var_3_7 do
			local var_3_8

			if config._DEBUG then
				var_3_8 = cc.Sprite:create("public/currency/weapon_star.png") or cc.Sprite:createWithSpriteFrameName("public/currency/weapon_star.png")
			end

			var_3_8:setPosition(25, (iter_3_4 - 1) * 24 - 30)
			var_3_6:addChild(var_3_8)
		end

		var_3_4:loadTexture("equipment/" .. item_data[var_3_1].image_id .. ".png")
		var_3_4:setScale(0.3)
	elseif item_data[var_3_1].bag_item_type == kITEM_COMPONENT then
		var_3_4:removeFromParent()

		var_3_4 = nil
		var_3_4 = componentManager:create_component_icon(var_3_1)

		;(nil):setPosition(cc.p(self.championBg:getContentSize().width / 2, self.championBg:getContentSize().height / 2 + 20))
		var_3_4:setScale(0.75)
	elseif item_data[var_3_1].image_id then
		var_3_4:loadTexture("equipment/" .. item_data[var_3_1].image_id .. ".png")
		var_3_4:setScale(0.75)
	end

	var_3_4:setTouchEnabled(arg_3_1)
	var_3_4:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_data[var_3_1].bag_item_type == kITEM_HORCRUX then
			var_0_21(var_3_1)
		else
			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_3_1
			})
		end
	end)

	return var_3_4, var_3_2, name
end

local function var_0_23(arg_5_0)
	local var_5_0 = string.len(arg_5_0)
	local var_5_1
	local var_5_2 = 255

	if var_5_0 == 6 then
		var_5_1 = 1
	elseif var_5_0 == 7 then
		var_5_1 = 2
	else
		var_5_2 = (var_5_0 == 8 or var_5_0 == 9) and tonumber(string.sub(arg_5_0, var_5_0 - 1, var_5_0), 16) or var_5_2
	end

	if var_5_1 then
		return (cc.c4b(tonumber(string.sub(arg_5_0, var_5_1, var_5_1 + 1), 16) or 0, tonumber(string.sub(arg_5_0, var_5_1 + 2, var_5_1 + 3), 16) or 0, tonumber(string.sub(arg_5_0, var_5_1 + 4, var_5_1 + 5), 16) or 0, var_5_2))
	end
end

function OldSubstitutionLayer.create(arg_6_0, arg_6_1)
	local var_6_0 = OldSubstitutionLayer.new()

	var_6_0:init(arg_6_1)

	return var_6_0
end

function OldSubstitutionLayer:init(arg_7_1)
	self.mode = var_0_19

	self:initUI(arg_7_1)
	self:addTouchEvent()
	old_substitution_manager:get_player_old_substitution_data(function(arg_8_0)
		self.chapter = arg_8_0.chapter
		self.max_damage = arg_8_0.max_damage
		self.max_score = arg_8_0.max_score
		self.last_rank = arg_8_0.last_rank

		self:updateUI()
	end)
end

function OldSubstitutionLayer:initUI(arg_9_1)
	self.rootLayer = ccui.ImageView:create("mainScenebg/oldSubstitutionLayer_bg.png")

	self:addChild(self.rootLayer)
	self.rootLayer:setAnchorPoint(0, 0)
	self.rootLayer:setPositionY(-GameDisplay.fix_y)

	local var_9_0 = ccui.Button:create(var_0_20 .. "title.png", nil, var_0_20 .. "title.png", var_0_4)

	self.rootLayer:addChild(var_9_0, 2)
	var_9_0:setAnchorPoint(0, 1)
	var_9_0:setPosition(20, GameDisplay.height)
	var_9_0:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "oldSubstitution"
		})
	end)

	local var_9_1 = ccui.ImageView:create(var_0_20 .. "top.png", var_0_4)

	self.rootLayer:addChild(var_9_1)
	var_9_1:setAnchorPoint(0, 1)
	var_9_1:setPositionY(GameDisplay.height)

	local var_9_2 = ccui.Button:create(var_0_20 .. "rank_btn.png", nil, var_0_20 .. "rank_btn.png", var_0_4)

	self.rootLayer:addChild(var_9_2, 3)
	var_9_2:setAnchorPoint(1, 1)
	var_9_2:setPosition(620, GameDisplay.height - 20)

	self.rank_btn = var_9_2

	local var_9_3 = ccui.Button:create(var_0_20 .. "shop_btn.png", nil, var_0_20 .. "shop_btn.png", var_0_4)

	self.rootLayer:addChild(var_9_3, 2)
	var_9_3:setAnchorPoint(1, 1)
	var_9_3:setPosition(620, GameDisplay.height - 140)

	self.shop_btn = var_9_3

	local var_9_4 = ccui.Button:create(var_0_20 .. "daliy_rank_btn.png", nil, var_0_20 .. "daliy_rank_btn.png", var_0_4)

	self.rootLayer:addChild(var_9_4, 2)
	var_9_4:setAnchorPoint(1, 1)
	var_9_4:setPosition(620, GameDisplay.height - 220)

	self.daily_rank_btn = var_9_4

	local var_9_5 = ccui.Button:create(var_0_20 .. "weekly_rank_btn.png", nil, var_0_20 .. "weekly_rank_btn.png", var_0_4)

	self.rootLayer:addChild(var_9_5, 2)
	var_9_5:setAnchorPoint(1, 1)
	var_9_5:setPosition(620, GameDisplay.height - 300)

	self.weekly_rank_btn = var_9_5

	local var_9_6 = ccui.ImageView:create(var_0_20 .. "boss_title.png", var_0_4)

	self.rootLayer:addChild(var_9_6, 2)
	var_9_6:setAnchorPoint(1, 1)
	var_9_6:setPosition(700, 800)

	local var_9_7 = cc.Label:createWithTTF("敬请期待~", FONT_DES, 45)

	var_9_7:setPosition(30, 15)
	var_9_7:setAnchorPoint(0, 0)
	var_9_6:addChild(var_9_7)

	self.label_boss_name = var_9_7

	local var_9_8 = ccui.ImageView:create(var_0_20 .. "max_score_title.png", var_0_4)

	self.rootLayer:addChild(var_9_8, 2)
	var_9_8:setAnchorPoint(1, 1)
	var_9_8:setPosition(640, 700)

	local var_9_9 = ccui.ImageView:create(var_0_20 .. "score_bg.png", var_0_4)

	self.rootLayer:addChild(var_9_9, 2)
	var_9_9:setAnchorPoint(1, 1)
	var_9_9:setPosition(600, 630)

	local var_9_10 = cc.Label:createWithTTF("", FONT_DES, 28)

	var_9_10:setPosition(30, 2)
	var_9_10:setAnchorPoint(0, 0)
	var_9_9:addChild(var_9_10)

	self.max_score_label = var_9_10

	local var_9_11 = cc.Label:createWithTTF("造成伤害额外增加", FONT_DES, 26)

	var_9_11:setPosition(32, 30)
	self.rootLayer:addChild(var_9_11, 2)
	var_9_11:setAnchorPoint(1, 1)
	var_9_11:setPosition(620, 550)

	self.attr_label = var_9_11

	self.attr_label:setVisible(false)

	local var_9_12 = ccui.ImageView:create("public/career_icon/wind.png", var_0_4)

	self.rootLayer:addChild(var_9_12, 2)
	var_9_12:setAnchorPoint(1, 1)
	var_9_12:setPosition(390, 570)

	self.attr_icon = var_9_12

	self.attr_icon:setVisible(false)

	local var_9_13 = ccui.Button:create(var_0_20 .. "bottom_bg.png", nil, var_0_20 .. "bottom_bg.png", var_0_4)

	self.rootLayer:addChild(var_9_13, 2)
	var_9_13:setAnchorPoint(0, 0)

	local var_9_14 = ccui.Button:create(var_0_20 .. "return_btn.png", nil, var_0_20 .. "return_btn.png", var_0_4)

	var_9_13:addChild(var_9_14)
	var_9_14:setAnchorPoint(0, 0)
	var_9_14:setPosition(10, 10)

	self.return_btn = var_9_14

	local var_9_15 = ccui.ImageView:create(var_0_20 .. "rewardListBg.png", var_0_4)

	self.rootLayer:addChild(var_9_15, 2)
	var_9_15:setPosition(320, 360)

	self.rewardListView = ccui.ListView:create()

	self.rewardListView:setDirection(ccui.ScrollViewDir.horizontal)
	self.rewardListView:setContentSize(cc.size(640, 120))
	self.rewardListView:setPosition(cc.p(0, 60))
	var_9_15:addChild(self.rewardListView)
	self.rewardListView:setBackGroundColorOpacity(100)
	self.rewardListView:setBounceEnabled(true)
	self.rewardListView:setName("rewardList")

	local var_9_16 = ccui.ImageView:create(var_0_20 .. "reward_icon.png", var_0_4)

	var_9_15:addChild(var_9_16)
	var_9_16:setPosition(0, 185)
	var_9_16:setAnchorPoint(0, 0)

	local var_9_17 = cc.Label:createWithTTF("下一奖励伤害需求:", FONT_DES, 28)

	var_9_17:setAnchorPoint(0, 0)
	var_9_17:setPosition(110, 185)
	var_9_15:addChild(var_9_17)
	var_9_17:setColor(var_0_23("73A8CE"))

	local var_9_18 = cc.Label:createWithTTF("敬请期待~", FONT_DES, 28)

	var_9_18:setAnchorPoint(0, 0)
	var_9_18:setPosition(350, 185)
	var_9_15:addChild(var_9_18)

	self.next_score_label = var_9_18

	var_9_18:setColor(var_0_23("DB5ED7"))

	local var_9_19 = ccui.Button:create(var_0_20 .. "fight_btn.png", nil, var_0_20 .. "fight_btn.png", var_0_4)

	self.rootLayer:addChild(var_9_19, 2)
	var_9_19:setPosition(320, 170)

	self.fight_btn = var_9_19

	local var_9_20 = cc.Label:createWithTTF("剩余时间：", FONT_DES, 22)

	var_9_20:setPosition(300, GameDisplay.height - 25)
	var_9_20:setAnchorPoint(0, 1)
	self.rootLayer:addChild(var_9_20)

	self.remain_time_label = var_9_20

	var_9_20:setColor(var_0_23("457FA7"))

	local var_9_21 = cc.Label:createWithTTF("无", FONT_DES, 18)

	var_9_21:setPosition(300, GameDisplay.height - 55)
	var_9_21:setAnchorPoint(0, 1)
	self.rootLayer:addChild(var_9_21)

	self.remain_time = var_9_21

	var_9_21:setColor(var_0_23("457FA7"))

	local var_9_22 = ccui.Button:create(var_0_20 .. "daliy_reward_btn.png", nil, var_0_20 .. "daliy_reward_btn.png", var_0_4)

	self.rootLayer:addChild(var_9_22, 2)
	var_9_22:setAnchorPoint(1, 1)
	var_9_22:setPosition(620, GameDisplay.height - 220)

	self.daliy_reward_btn = var_9_22

	self.daliy_reward_btn:setVisible(false)
end

function OldSubstitutionLayer:addTouchEvent(arg_11_1)
	self.return_btn:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.fight_btn:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_13_0

		if not self.chapter then
			global_ShowBlockWords("目前没有在进行的极限拟练哦~")

			do return end

			var_13_0 = {
				fight_type = "SUBSTITUTION",
				level = 1,
				mode = var_0_19,
				chapter = self.chapter,
				callback = function()
					return
				end
			}
		end

		function var_13_0.adventuresurecallback()
			LayerManager:pushInLayer("FormationOldSubstituteLayer", {
				returnlayer = "AdventureLayer",
				mode = var_0_19,
				cancelcallback = callback
			})
		end

		var_13_0.initindex = curArray

		LayerManager:pushInLayer("LevelDetailLayer", var_13_0)
	end)
	self.daily_rank_btn:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.chapter then
			global_ShowBlockWords("目前没有在进行的极限拟练哦~")

			return
		end

		self:updateRankRewardLayout("daily")
	end)
	self.weekly_rank_btn:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.chapter then
			global_ShowBlockWords("目前没有在进行的极限拟练哦~")

			return
		end

		self:updateRankRewardLayout("weekly")
	end)
	self.daliy_reward_btn:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.chapter then
			global_ShowBlockWords("目前没有在进行的极限拟练哦~")

			return
		end

		if not self.last_rank then
			global_ShowBlockWords("暂无可以领取的每日排名奖励哦~")

			return
		end

		old_substitution_manager:get_old_substitute_daily_reward(function(arg_19_0)
			if arg_19_0.result == 1 then
				if arg_19_0.item_res then
					global_gain(arg_19_0.item_res)
				end

				self.last_rank = nil

				self.daliy_reward_btn:setVisible(false)
				self.daily_rank_btn:setVisible(true)
			else
				global_ShowBlockWords("暂无可以领取的每日排名奖励哦~")
			end
		end)
	end)
	self.rank_btn:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.chapter then
			global_ShowBlockWords("目前没有在进行的极限拟练哦~")

			return
		end

		LayerManager:pushInLayer("OldSubRankListLayer", {
			type = "weekly"
		})
	end)
	self.shop_btn:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.chapter then
			global_ShowBlockWords("目前没有在进行的极限拟练哦~")

			return
		end

		local var_21_0 = old_substitution_manager:get_old_substitution_shop()

		if var_21_0 then
			local var_21_1 = {
				"1-" .. var_21_0
			}

			LayerManager:switchShowLayer("MarketLayer", {
				singleMarket = var_21_1,
				showType = var_21_1[1]
			})
		end
	end)
end

function OldSubstitutionLayer:getBossList()
	self.bossInfo = {}
	self.bossInfo = {
		modelid = level_manager.getCurMonsterData(self.mode, level_manager.getCurMonsterTeamData(self.mode, level_manager.getCurLevelData(self.mode, "1-" .. self.chapter).boss_team).boss).modelid,
		mode = self.mode
	}

	print("self.bossInfo======", dump(self.bossInfo))
end

function OldSubstitutionLayer:updateUI()
	self:getBossList()

	if not self.image_boss then
		local var_23_0 = ccui.ImageView:create()

		self.rootLayer:addChild(var_23_0)
		var_23_0:setAnchorPoint(0, 1)
		var_23_0:setPosition(0, GameDisplay.height - 80)

		self.image_boss = var_23_0
	end

	if model_data[self.bossInfo.modelid].role_image then
		self.image_boss:loadTexture("role/" .. model_data[self.bossInfo.modelid].role_image .. ".png")
	else
		self.image_boss:loadTexture("role1/" .. model_data[self.bossInfo.modelid].cute_role .. ".png")
	end

	self.modelid = self.bossInfo.modelid

	self.image_boss:setPosition(cc.p(self.image_boss:getPositionX() + (model_data[self.modelid].substitution_offset_x or 0), self.image_boss:getPositionY() + (model_data[self.modelid].substitution_offset_y or 0)))
	self.label_boss_name:setString(model_data[self.bossInfo.modelid].name)
	self.max_score_label:setString(global_trans_number(self.max_damage))

	local var_23_1 = "无"

	self.rewardListView:removeAllChildren()

	for iter_23_0, iter_23_1 in ipairs((require("data.old_substitute_awards_data"))) do
		local var_23_2 = ccui.Layout:create()

		var_23_2:setContentSize(cc.size(100, 100))

		local var_23_3 = ccui.ImageView:create(var_0_20 .. "reward_bg.png", var_0_4)

		var_23_3:setPosition(cc.p(50, 40))

		local var_23_4, var_23_5 = var_0_22(iter_23_1.dropid, true, nil, nil)

		var_23_4:setPosition(40, 65)
		var_23_4:setScale(var_23_4:getScale() * 0.6)
		var_23_3:addChild(var_23_4)
		var_23_2:addChild(var_23_3)

		local var_23_6 = cc.Label:createWithTTF("x" .. var_23_5, FONT_DES, 18)

		var_23_6:setPosition(50, 35)
		var_23_3:addChild(var_23_6)

		local var_23_7 = cc.Label:createWithTTF(global_trans_number(iter_23_1.percent), FONT_DES, 18)

		var_23_7:setPosition(40, 10)
		var_23_3:addChild(var_23_7)
		self.rewardListView:pushBackCustomItem(var_23_2)
		var_23_2:setName("item" .. iter_23_0)

		if iter_23_0 <= self.max_score then
			local var_23_8 = ccui.ImageView:create("public/panelbg/fragment_tic_new.png", var_0_4)

			var_23_8:setAnchorPoint(cc.p(0.5, 0.5))
			var_23_8:setPosition(cc.p(75, 75))
			var_23_8:setScale(0.5)
			var_23_3:addChild(var_23_8, 2)
		end

		if iter_23_0 == self.max_score + 1 then
			var_23_1 = global_trans_number(iter_23_1.percent)
		end
	end

	self.next_score_label:setString(var_23_1)

	if self.last_rank then
		self.daliy_reward_btn:setVisible(true)
		self.daily_rank_btn:setVisible(false)
	else
		self.daliy_reward_btn:setVisible(false)
		self.daily_rank_btn:setVisible(true)
	end

	local var_23_9 = old_substitution_manager:get_old_substitution_remaintime()

	if var_23_9 then
		self.remain_time:setString((Global_format_time_str(var_23_9)))
	end

	local var_23_10 = old_substitution_manager:get_old_substitution_showAttr()

	if var_23_10 then
		self.attr_label:setVisible(true)
		self.attr_icon:loadTexture("public/career_icon/" .. var_23_10 .. ".png", var_0_4)
		self.attr_icon:setVisible(true)
	else
		self.attr_label:setVisible(false)
		self.attr_icon:setVisible(false)
	end
end

function OldSubstitutionLayer:updateRankRewardLayout(arg_24_1)
	local var_24_0
	local var_24_1
	local old_sub_dailyrank_awards_data

	if arg_24_1 == "daily" then
		var_24_0 = "每日排名奖励"
		var_24_1 = "daily_layout"
		old_sub_dailyrank_awards_data = require("data.old_sub_dailyrank_awards_data")
	elseif arg_24_1 == "weekly" then
		var_24_0 = "每周排名奖励"
		var_24_1 = "weekly_layout"
		old_sub_dailyrank_awards_data = require("data.old_sub_weeklyrank_awards_data")
	end

	if self[var_24_1] then
		self[var_24_1]:setVisible(true)

		return
	end

	local var_24_3 = ccui.Layout:create()

	var_24_3:setContentSize(cc.size(640, 1600))
	var_24_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_24_3:setCascadeOpacityEnabled(false)
	var_24_3:setBackGroundColorOpacity(122)
	var_24_3:setAnchorPoint(0.5, 0.5)
	var_24_3:setBackGroundColor(cc.c3b(0, 0, 0))
	var_24_3:setPosition(GameDisplay.cx, GameDisplay.cy)
	var_24_3:setTouchEnabled(true)
	var_24_3:setLocalZOrder(1000)
	self:addChild(var_24_3)

	self[var_24_1] = var_24_3

	local var_24_4 = ccui.ImageView:create(var_0_20 .. "rank_reward_bg.png", var_0_4)

	self[var_24_1]:addChild(var_24_4)
	var_24_4:setPosition(320, 700)
	var_24_4:setTouchEnabled(true)

	local var_24_5 = ccui.ImageView:create(var_0_20 .. "rank_reward_title.png", var_0_4)

	self[var_24_1]:addChild(var_24_5)
	var_24_5:setAnchorPoint(0.5, 0)
	var_24_5:setPosition(320, 700 + var_24_4:getContentSize().height / 2 - 20)

	local var_24_6 = cc.Label:createWithTTF("", FONT_DES, 34)

	var_24_6:setPosition(var_24_5:getContentSize().width / 2, var_24_5:getContentSize().height / 2)
	var_24_5:addChild(var_24_6)
	var_24_6:setString(var_24_0)

	local var_24_7 = cc.Label:createWithTTF("当前排名：", FONT_DES, 26)

	var_24_7:setAnchorPoint(0, 1)
	var_24_7:setPosition(20, var_24_4:getContentSize().height - 20)
	var_24_4:addChild(var_24_7)

	local var_24_8 = cc.Label:createWithTTF("", FONT_DES, 26)

	var_24_8:setAnchorPoint(0, 1)
	var_24_8:setPosition(145, var_24_4:getContentSize().height - 20)
	var_24_4:addChild(var_24_8)
	var_24_8:setColor(var_0_23("00FFC6"))
	old_substitution_manager:get_old_substitute_player_rank(function(arg_25_0)
		if arg_25_0.rank and arg_25_0.rank > 0 then
			var_24_8:setString(string.format("第%d名", arg_25_0.rank))
		else
			var_24_8:setString("未上榜")
		end
	end)

	local var_24_9 = cc.TableView:create(cc.size(var_24_4:getContentSize().width - 40, var_24_4:getContentSize().height - 150))

	var_24_9:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_24_9:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_24_9:setPosition(20, 75)
	var_24_9:setDelegate()
	var_24_4:addChild(var_24_9)

	local function var_24_10(arg_26_0, arg_26_1)
		local var_26_0 = ccui.Layout:create()

		var_26_0:setTag(100)

		local var_26_1 = ccui.Layout:create()

		var_26_1:setContentSize(cc.size(460, 120))
		var_26_1:setPosition(cc.p(50, -45))
		var_26_0:addChild(var_26_1)
		var_26_1:setName("droplist")
		var_26_1:setLayoutType(ccui.LayoutType.horizontal)

		for iter_26_0, iter_26_1 in pairs(drop_manager:getDropMsg(arg_26_0.dropid).equips) do
			local var_26_2 = ccui.Layout:create()

			var_26_2:setContentSize(cc.size(100, 100))

			local var_26_3 = ccui.ImageView:create(var_0_20 .. "reward_bg.png", var_0_4)

			var_26_3:setPosition(cc.p(50, 62))

			local var_26_4, var_26_5 = var_0_22(arg_26_0.dropid, true, iter_26_1.dropid, iter_26_1.dropNum)

			var_26_4:setPosition(40, 65)
			var_26_4:setScale(var_26_4:getScale() * 0.6)
			var_26_3:addChild(var_26_4)
			var_26_2:addChild(var_26_3)

			local var_26_6 = cc.Label:createWithTTF("x" .. var_26_5, FONT_DES, 18)

			var_26_6:setPosition(40, 10)
			var_26_3:addChild(var_26_6)
			var_26_1:addChild(var_26_2)
			var_26_2:setPositionX(iter_26_0 * 100 - 80)
		end

		local var_26_7 = ccui.ImageView:create(var_0_20 .. "rank_first_bg.png", var_0_4)

		var_26_0:addChild(var_26_7)
		var_26_7:setAnchorPoint(0, 0)
		var_26_7:setPosition(35, 80)
		var_26_7:setName("rankTitlebg")

		local var_26_8 = ({
			"rank_first_bg.png",
			"rank_second_bg.png",
			"rank_third_bg.png"
		})[arg_26_1]

		if not var_26_8 then
			var_26_7:setVisible(false)
		else
			var_26_7:loadTexture(var_0_20 .. var_26_8, var_0_4)
			var_26_7:setVisible(true)
		end

		local var_26_9 = cc.Label:createWithTTF("", FONT_DES, 26)

		var_26_9:setAnchorPoint(0, 0)
		var_26_9:setPosition(65, 90)
		var_26_0:addChild(var_26_9)
		var_26_9:setString(not arg_26_0.max_rank and string.format("第%d名及以后", arg_26_0.min_rank) or arg_26_0.min_rank == arg_26_0.max_rank and string.format("第%d名", arg_26_0.min_rank) or string.format("第%d-%d名", arg_26_0.min_rank, arg_26_0.max_rank))
		var_26_9:setName("rankTitle")

		return var_26_0
	end

	local function var_24_11(arg_27_0, arg_27_1, arg_27_2)
		local var_27_0 = arg_27_0:getChildByName("droplist")

		var_27_0:removeAllChildren()

		for iter_27_0, iter_27_1 in pairs(drop_manager:getDropMsg(arg_27_1.dropid).equips) do
			local var_27_1 = ccui.Layout:create()

			var_27_1:setContentSize(cc.size(100, 100))

			local var_27_2 = ccui.ImageView:create(var_0_20 .. "reward_bg.png", var_0_4)

			var_27_2:setPosition(cc.p(50, 62))

			local var_27_3, var_27_4 = var_0_22(arg_27_1.dropid, true, iter_27_1.dropid, iter_27_1.dropNum)

			var_27_3:setPosition(40, 65)
			var_27_3:setScale(var_27_3:getScale() * 0.6)
			var_27_2:addChild(var_27_3)
			var_27_1:addChild(var_27_2)

			local var_27_5 = cc.Label:createWithTTF("x" .. var_27_4, FONT_DES, 18)

			var_27_5:setPosition(40, 10)
			var_27_2:addChild(var_27_5)
			var_27_0:addChild(var_27_1)
			var_27_1:setPositionX(iter_27_0 * 100 - 80)
		end

		local var_27_6 = arg_27_0:getChildByName("rankTitlebg")
		local var_27_7 = arg_27_0:getChildByName("rankTitle")
		local var_27_8 = ({
			"rank_first_bg.png",
			"rank_second_bg.png",
			"rank_third_bg.png"
		})[arg_27_2]

		if not var_27_8 then
			var_27_6:setVisible(false)
		else
			var_27_6:loadTexture(var_0_20 .. var_27_8, var_0_4)
			var_27_6:setVisible(true)
		end

		var_27_7:setString(not arg_27_1.max_rank and string.format("第%d名及以后", arg_27_1.min_rank) or arg_27_1.min_rank == arg_27_1.max_rank and string.format("第%d名", arg_27_1.min_rank) or string.format("第%d-%d名", arg_27_1.min_rank, arg_27_1.max_rank))
	end

	var_24_9:registerScriptHandler(function(arg_29_0, arg_29_1)
		return var_24_4:getContentSize().width - 40, 180
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_24_9:registerScriptHandler(function(arg_28_0, arg_28_1)
		local var_28_0 = arg_28_0:dequeueCell()

		if not var_28_0 then
			var_28_0 = cc.TableViewCell:create()

			local var_28_2 = var_24_10(old_sub_dailyrank_awards_data[arg_28_1 + 1], arg_28_1 + 1)

			var_28_2:setPosition(cc.p(0, 65))
			var_28_0:addChild(var_28_2)
		else
			var_24_11(var_28_0:getChildByTag(100), old_sub_dailyrank_awards_data[arg_28_1 + 1], arg_28_1 + 1)
		end

		return var_28_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_24_9:registerScriptHandler(function(arg_30_0, arg_30_1)
		return #old_sub_dailyrank_awards_data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_24_9:reloadData()
	var_24_3:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_24_3:setVisible(false)
	end)
end
