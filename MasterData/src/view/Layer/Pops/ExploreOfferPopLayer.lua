local ExploreOfferPopLayer = class("ExploreOfferPopLayer", function()
	return cc.Layer:create()
end)
local playermodel = require("model.playermodel")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local array_manager = require("controller.array_manager")
local explore_manager = require("controller.explore_manager")
local role_false_level_manager = require("controller.role_false_level_manager")
local item_data = require("data.item_data")
local model_data = require("data.model_data")
local total_skill_data = require("data.total_skill_data")
local servant_data = require("data.servant_data")
local npc_fightconfig_data = require("data.npc_fightconfig_data")
local npc_data = require("data.npc_data")
local time_check_manager = require("controller.time_check_manager")
local var_0_13 = require("controller.formation.formation_manager"):getInstance()
local item_manager = require("controller.item_manager")
local var_0_15 = config._DEBUG and 0 or 1
local var_0_16 = "ExploreOfferLayer/"
local LocalEvent = require("common.LocalEvent")
local Utility = require("common.Utility")

function ExploreOfferPopLayer:create(arg_2_1)
	local var_2_0 = ExploreOfferPopLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function ExploreOfferPopLayer:initBg(arg_3_1)
	local var_3_0 = ccui.Layout:create()

	var_3_0:setTouchEnabled(true)
	var_3_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_0:setAnchorPoint(cc.p(0, 0))
	var_3_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_3_0:setOpacity(0)
	self:addChild(var_3_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_4_0)
		self:addChild(arg_4_0, -2)
		arg_4_0:setPositionY(arg_4_0:getPositionY() - GameDisplay.fix_y)

		local var_4_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_4_0:setAnchorPoint(cc.p(0, 0))
		var_4_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_4_0, -1)
		self:init(arg_3_1)
		var_3_0:setOpacity(102)
		var_3_0:setTouchEnabled(false)
	end)
end

function ExploreOfferPopLayer:init(arg_5_1)
	self.offerInfo = arg_5_1
	self.offerid = arg_5_1.offerid
	self.aimid = arg_5_1.aimid
	self.sureCallback = arg_5_1.sureCallback
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(GameDisplay.width, GameDisplay.height)
	self.rootLayer:setPosition(0, -GameDisplay.fix_y)
	self:addChild(self.rootLayer)
	self.rootLayer:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)

	self.isRefresh = cc.UserDefault:getInstance():getIntegerForKey("refreshOfferTime", 0) > time_check_manager:getCurTime()

	self:initArrayData()
	self:initUI()
end

function ExploreOfferPopLayer:initArrayData()
	local var_7_0 = explore_manager:getExploreAimInfo(self.aimid)
	local var_7_1 = not not (var_7_0.hp_inherit and var_7_0.hp_inherit == 1)

	self.is_hp_inherit = not not (var_7_0.hp_inherit and var_7_0.hp_inherit == 1)
	self.arrayInfo = {}

	local var_7_3, var_7_4 = explore_manager:getCurrentFixArray(self.aimid)
	local var_7_5 = explore_manager:isFixArray(self.aimid)

	if var_7_1 or not var_7_1 then
		playermodel:initExploreArraysHpInherit()
	end

	if var_7_5 then
		self.is_array_fix = true

		for iter_7_0, iter_7_1 in ipairs(var_7_4) do
			self.arrayInfo[iter_7_0] = iter_7_1
		end

		playermodel:updateExploreArrays(1, self.arrayInfo)
	else
		self.arrayInfo = array_manager:getBattleArrayData((RoleDefault:getInstance():getIntegerForKey("explore_array_id", 1)))
	end
end

function ExploreOfferPopLayer:updateArrayData(arg_10_1)
	if type(arg_10_1) == "number" then
		if not self.is_array_fix then
			self.arrayInfo = self.is_hp_inherit and array_manager:getBattleArrayDataHpInherit(arg_10_1) or array_manager:getBattleArrayData(arg_10_1)
		end
	elseif type(arg_10_1) == "table" then
		print(">>>>>>>>>", dump(arg_10_1))

		local var_10_0 = explore_manager:getExploreAimInfo(self.aimid)

		self.arrayInfo = {}

		for iter_10_0 = 1, FORMATION_SHOW_GIRL_NUM do
			if arg_10_1[iter_10_0].npcid then
				local var_10_1 = {
					npcid = arg_10_1[iter_10_0].npcid
				}

				var_10_1.fight_girl = arg_10_1[iter_10_0].girlInfo.servantId or arg_10_1[iter_10_0].girlInfo.npcsoulid
				var_10_1.pos = iter_10_0
				self.arrayInfo[iter_10_0] = var_10_1
			elseif arg_10_1[iter_10_0].girlInfo then
				local var_10_2 = {
					fight_girl = arg_10_1[iter_10_0].girlInfo.servantId
				}

				if arg_10_1[iter_10_0].horcruxInfo then
					var_10_2.assist_girl = arg_10_1[iter_10_0].horcruxInfo.entityid or nil
				end

				var_10_2.pos = iter_10_0
				var_10_2.pos_lock = var_10_0["pos_unlock" .. iter_10_0] ~= 1
				self.arrayInfo[iter_10_0] = var_10_2
			else
				self.arrayInfo[iter_10_0] = {
					pos = iter_10_0,
					pos_lock = var_10_0["pos_unlock" .. iter_10_0] ~= 1 and true or false
				}
			end
		end

		print(dump(self.arrayInfo))
	end
end

function ExploreOfferPopLayer:initUI()
	local var_11_0 = ccui.ImageView:create(var_0_16 .. "pop_bg.png", var_0_15)

	var_11_0:setTouchEnabled(true)
	var_11_0:setScale9Enabled(true)
	var_11_0:setCapInsets(cc.rect(0, 210, var_11_0:getContentSize().width, 40))
	var_11_0:setContentSize(cc.size(var_11_0:getContentSize().width, var_11_0:getContentSize().height + self:getBgMoreHeight()))
	var_11_0:setPosition(GameDisplay.width / 2, GameDisplay.height / 2 + 100)
	self.rootLayer:addChild(var_11_0)

	self.bg = var_11_0

	self:initTitle()
	self:initDes()
	self:initOfferDrops()
	self:initMapDrops()
	self:initTeam()
	self:initSureBtn()
	self:updateBtnStatus()
end

function ExploreOfferPopLayer:initTitle()
	local var_12_0 = ccui.ImageView:create(var_0_16 .. "pop_title" .. self.offerInfo.equip_quality .. ".png", var_0_15)

	var_12_0:setAnchorPoint(cc.p(0, 1))
	var_12_0:setPosition(10, self.bg:getContentSize().height - 10)
	var_12_0:setName("titlebg")
	self.bg:addChild(var_12_0)

	local var_12_1 = ccui.ImageView:create(ROLE_HEAD_IMAGE_PATH .. self.offerInfo.head .. ".png")

	var_12_1:setScale(0.35)
	var_12_1:setPosition(71, 81)
	var_12_1:setName("headImg")
	var_12_0:addChild(var_12_1)

	local var_12_2 = cc.Label:createWithTTF(self.offerInfo.title, FONT_NAME, 24)

	var_12_2:setAnchorPoint(cc.p(0, 0))
	var_12_2:setPosition(120, 90)
	var_12_2:setName("titleLabel")
	var_12_0:addChild(var_12_2)

	local var_12_3 = cc.Label:createWithTTF(L_EQUIPLAYER[6] .. self.offerInfo.level_limit, FONT_NAME, 20)

	var_12_3:setAnchorPoint(cc.p(0, 1))
	var_12_3:setPosition(120, 90)
	var_12_3:setName("levelLabel")
	var_12_0:addChild(var_12_3)

	local var_12_4 = ccui.Button:create(var_0_16 .. "btn_refresh.png", nil, var_0_16 .. "btn_refresh.png", var_0_15)

	var_12_4:setPosition(var_12_0:getContentSize().width - var_12_4:getContentSize().width / 2 - 5, var_12_0:getContentSize().height - var_12_4:getContentSize().height / 2 - 5)
	var_12_0:addChild(var_12_4)
	Utility:addClickEventListener(var_12_4, function()
		local var_13_0 = {
			5,
			5,
			10,
			15,
			20,
			25
		}
		local var_13_1 = {
			costtype = "diamond",
			surecallback = function()
				explore_manager:refresh_offer(self.offerInfo.offerid, function(arg_15_0)
					if arg_15_0 == 1 then
						self:updateLayout()

						if not self.isRefresh then
							local var_15_0 = os.date("*t", (time_check_manager:getCurTime()))

							cc.UserDefault:getInstance():setIntegerForKey("refreshOfferTime", (os.time({
								hour = 23,
								min = 59,
								sec = 59,
								year = var_15_0.year,
								month = var_15_0.month,
								day = var_15_0.day
							})))

							self.isRefresh = true
						end
					end

					LocalEvent:triggerEvent(LocalEvent.EVENT_IDS.UPDATE_OFFERS)
				end)
			end
		}
		local var_13_2 = {
			titleImage = "title_default.png"
		}

		if self.isRefresh then
			var_13_2.button = L_DAILY_WEEKLY_REFRESH or L_FREE_REFARSH
		end

		var_13_1.labels = var_13_2
		var_13_1.desRichTexts = self:generateRefreshStrs()

		if self.isRefresh then
			var_13_1.cost = var_13_0[self.offerInfo.equip_quality] or nil
		end

		var_13_1.own = playermodel.diamond

		LayerManager:pushInLayer("PopDoLayer", var_13_1)
	end)

	if self.offerInfo.offerType == "special" then
		var_12_4:setVisible(false)
	end

	self:updateBossSkill()
end

function ExploreOfferPopLayer:generateRefreshStrs()
	return {
		{
			{
				str = L_DAILY_WEEKLY_REFRESH
			},
			{
				str = self.offerInfo.title,
				color = cc.c3b(0, 240, 255)
			}
		},
		{
			{
				str = L_EXPLORE_OFFER_POP[1]
			},
			{
				str = ({
					"C",
					"C",
					"B",
					"A",
					"S",
					"X"
				})[self.offerInfo.equip_quality],
				color = cc.c3b(0, 240, 255)
			},
			{
				str = L_EXPLORE_OFFER_POP[2]
			}
		}
	}
end

function ExploreOfferPopLayer:updateTitleUI()
	local var_17_0 = self.bg:getChildByName("titlebg")

	var_17_0:loadTexture(var_0_16 .. "pop_title" .. self.offerInfo.equip_quality .. ".png", var_0_15)
	var_17_0:getChildByName("headImg"):loadTexture(ROLE_HEAD_IMAGE_PATH .. self.offerInfo.head .. ".png")
	var_17_0:getChildByName("titleLabel"):setString(self.offerInfo.title)
	var_17_0:getChildByName("levelLabel"):setString(L_EQUIPLAYER[6] .. self.offerInfo.level_limit)
	self:updateBossSkill()
end

function ExploreOfferPopLayer:updateBossSkill()
	self.skillIcons = self.skillIcons or {}

	for iter_18_0, iter_18_1 in ipairs(self.skillIcons) do
		iter_18_1:removeFromParent()
	end

	self.skillIcons = {}

	local var_18_0 = self.bg:getChildByName("titlebg")
	local var_18_1 = self.offerInfo.boss_modelid
	local var_18_2 = self:getBossSkillList(self.offerInfo.boss_modelid)

	if var_18_2 then
		local var_18_3 = cc.Label:createWithTTF(L_BOSS_SKILL, FONT_NAME, 18)

		var_18_3:setPosition(495, 60)
		var_18_0:addChild(var_18_3)

		for iter_18_2, iter_18_3 in ipairs(var_18_2) do
			local var_18_4 = self:createClipRing("skill_new/skill/" .. total_skill_data[iter_18_3].icon .. ".png", 0.5)

			var_18_4:setPosition(500 - (iter_18_2 - 1) * 50, 25)
			var_18_0:addChild(var_18_4)
			var_18_4:setTouchEnabled(true)
			var_18_4:addTouchEventListener(function(arg_19_0, arg_19_1)
				if arg_19_1 ~= ccui.TouchEventType.ended then
					return
				end

				local var_19_0 = {
					photofile_nightmare_xmasfile_data = "file_nightmare_xmasfile",
					photofile_ai3_data = "file_enemy4",
					photofile_ai1_data = "file_enemy2",
					photofile_data = "file_player",
					photofile_foundationai_data = "file_enemy9",
					photofile_foundation_data = "file_enemy8",
					photofile_ai2_data = "file_enemy3",
					photofile_activity_data = "file_enemy12",
					photofile_military_data = "file_enemy6",
					photofile_talk_level_data = "photofile_talk_level_data",
					photofile_militaryai_data = "file_enemy7",
					photofile_killer_data = "file_enemy10",
					photofile_ai4_data = "file_enemy5",
					photofile_ai5_data = "file_enemy_ai5",
					photofile_xmasfile_data = "file_enemy1",
					photofile_activityai_data = "file_enemy11"
				}
				local var_19_3 = {
					id = model_data[var_18_1].photofile_model,
					modelid = iter_18_3,
					contentType = {
						contentType = var_19_0[model_data[var_18_1].photofile_type]
					},
					modelid = var_18_1
				}

				var_19_3.contentType = {
					contentType = var_19_0[model_data[var_18_1].photofile_type]
				}
				var_19_3.id = model_data[var_18_1].photofile_model

				if var_19_0[model_data[var_18_1].photofile_type] == "file_player" or var_19_0[model_data[var_18_1].photofile_type] == "file_enemy1" or var_19_0[model_data[var_18_1].photofile_type] == "file_enemy6" or var_19_0[model_data[var_18_1].photofile_type] == "file_enemy8" or var_19_0[model_data[var_18_1].photofile_type] == "file_enemy10" or var_19_0[model_data[var_18_1].photofile_type] == "file_enemy12" or var_19_0[model_data[var_18_1].photofile_type] == "file_teacher" or var_19_0[model_data[var_18_1].photofile_type] == "file_nightmare_xmasfile" then
					LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_19_3)
				else
					LayerManager:pushInLayer("PhotoFileHelpGirlLayer", var_19_3)
				end
			end)

			self.skillIcons[#self.skillIcons + 1] = var_18_4
		end
	end
end

function ExploreOfferPopLayer:initDes()
	local var_20_0 = cc.Label:createWithTTF(self.offerInfo.client, FONT_NAME, 18)

	var_20_0:setAnchorPoint(cc.p(0, 0.5))
	var_20_0:setPosition(120, self.bg:getContentSize().height - 160)
	var_20_0:setName("nameLabel")
	self.bg:addChild(var_20_0)

	local var_20_1 = cc.Label:createWithTTF(self.offerInfo.des, FONT_NAME, 18)

	var_20_1:setMaxLineWidth(410)
	var_20_1:setAnchorPoint(cc.p(0, 1))
	var_20_1:setPosition(120, self.bg:getContentSize().height - 183)
	var_20_1:setName("desLabel")
	self.bg:addChild(var_20_1)
	self:updateLimits()
end

function ExploreOfferPopLayer:updateDesUI()
	self.bg:getChildByName("nameLabel"):setString(self.offerInfo.client)
	self.bg:getChildByName("desLabel"):setString(self.offerInfo.des)
	self:updateLimits()
end

function ExploreOfferPopLayer:updateLimits()
	self.nodeLimits = self.nodeLimits or {}

	for iter_22_0, iter_22_1 in ipairs(self.nodeLimits) do
		iter_22_1:removeFromParent()
	end

	self.nodeLimits = {}

	local var_22_0 = explore_manager:getOfferConditions(self.offerid)

	if var_22_0 and next(var_22_0) ~= nil then
		local var_22_1 = ccui.ImageView:create(var_0_16 .. "pop_line.png", var_0_15)

		var_22_1:setPosition(self.bg:getContentSize().width / 2, desLabel:getPositionY() - desLabel:getContentSize().height - 5)
		self.bg:addChild(var_22_1)

		self.nodeLimits[#self.nodeLimits + 1] = var_22_1

		for iter_22_2, iter_22_3 in ipairs(var_22_0) do
			local var_22_2
			local var_22_3

			if iter_22_3.limit_type == 1 then
				for iter_22_4, iter_22_5 in ipairs(iter_22_3.attrs) do
					local var_22_4 = self:createClipRing("public/career_icon/" .. iter_22_5 .. ".png", 0.6)

					var_22_2 = 35 + (iter_22_4 - 1) * (var_22_4:getContentSize().width + 5)
					var_22_3 = var_22_1:getPositionY() - 40 - (iter_22_2 - 1) * (var_22_4:getContentSize().height + 5)

					var_22_4:setPosition(var_22_2, var_22_3)
					self.bg:addChild(var_22_4)

					self.nodeLimits[#self.nodeLimits + 1] = var_22_4
				end
			elseif iter_22_3.limit_type == 2 then
				for iter_22_6, iter_22_7 in ipairs(iter_22_3.models) do
					local var_22_5 = self:createClipRing(ROLE_HEAD_IMAGE_PATH .. model_data[servant_data[iter_22_7].modelid].head_image .. ".png", 0.2)

					var_22_2 = 35 + (iter_22_6 - 1) * (var_22_5:getContentSize().width + 5)
					var_22_3 = var_22_1:getPositionY() - 40 - (iter_22_2 - 1) * (var_22_5:getContentSize().height + 5)

					var_22_5:setPosition(var_22_2, var_22_3)
					self.bg:addChild(var_22_5)

					self.nodeLimits[#self.nodeLimits + 1] = var_22_5
				end
			end

			local var_22_6 = cc.Label:createWithTTF(L_EXPLORE_OFFER_LIMIT, FONT_NAME, 18)

			var_22_6:setColor(cc.c3b(255, 153, 108))
			var_22_6:setAnchorPoint(cc.p(0, 0))
			var_22_6:setPosition(var_22_2 + 26, var_22_3)
			self.bg:addChild(var_22_6)

			self.nodeLimits[#self.nodeLimits + 1] = var_22_6

			local var_22_7 = cc.Label:createWithTTF(iter_22_3.limit_des, FONT_NAME, 18)

			var_22_7:setAnchorPoint(cc.p(0, 1))
			var_22_7:setPosition(var_22_2 + 26, var_22_3)
			self.bg:addChild(var_22_7)

			self.nodeLimits[#self.nodeLimits + 1] = var_22_7
		end
	end
end

function ExploreOfferPopLayer:initOfferDrops()
	local var_23_0 = explore_manager:getOfferTaskDrops(self.offerid)
	local var_23_1 = ccui.ScrollView:create()

	var_23_1:setDirection(ccui.ScrollViewDir.horizontal)
	var_23_1:setContentSize(cc.size(self.bg:getContentSize().width - 30, 130))
	var_23_1:setPosition(15, 184)
	var_23_1:setInnerContainerSize(cc.size(#var_23_0 * 95, var_23_1:getContentSize().height))
	var_23_1:setName("itemList")
	self.bg:addChild(var_23_1)
	self:updateDrops(var_23_0)
end

function ExploreOfferPopLayer:updateDropsUI()
	local var_24_0 = self.bg:getChildByName("itemList")
	local var_24_1 = explore_manager:getOfferTaskDrops(self.offerid)

	var_24_0:setContentSize(cc.size(self.bg:getContentSize().width - 30, 130))
	var_24_0:setInnerContainerSize(cc.size(#var_24_1 * 95, var_24_0:getContentSize().height))
	var_24_0:removeAllChildren()
	self:updateDrops(var_24_1)
end

function ExploreOfferPopLayer:updateDrops(arg_25_1)
	local var_25_0 = self.bg:getChildByName("itemList")

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		local var_25_1 = iter_25_1.dropid
		local var_25_2 = ccui.ImageView:create("public/box/" .. item_data[iter_25_1.dropid].equip_quality .. ".png", var_0_15)

		var_25_2:setScale(0.9)
		var_25_2:setAnchorPoint(cc.p(0, 0.5))
		var_25_2:setPosition((iter_25_0 - 1) * 95, var_25_0:getContentSize().height / 2)
		var_25_0:addChild(var_25_2)
		var_25_2:setTouchEnabled(true)
		var_25_2:addTouchEventListener(function(arg_26_0, arg_26_1)
			if arg_26_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_25_1
			})
		end)

		local var_25_3 = ItemNoBgSprite:create(iter_25_1.dropid)

		var_25_3:setScale(80 / var_25_3:getChildByName("icon"):getContentSize().width)
		var_25_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_25_3:setPosition(var_25_2:getContentSize().width / 2, var_25_2:getContentSize().height / 2)
		var_25_2:addChild(var_25_3)

		local var_25_4 = ccui.ImageView:create(var_0_16 .. "pop_num_bg.png", var_0_15)

		var_25_4:setScale(1.1)
		var_25_4:setAnchorPoint(cc.p(1, 0))
		var_25_4:setPosition(var_25_2:getContentSize().width, 0)
		var_25_2:addChild(var_25_4)

		local var_25_5 = cc.Label:createWithTTF("×" .. iter_25_1.dropNum, FONT_NAME, 18)

		var_25_5:setColor(cc.c3b(0, 0, 0))
		var_25_5:setAnchorPoint(cc.p(1, 0))
		var_25_5:setPosition(var_25_4:getContentSize().width - 3, 0)
		var_25_4:addChild(var_25_5)
	end
end

function ExploreOfferPopLayer:initMapDrops()
	local var_27_0 = explore_manager:getOfferMapDrops(self.offerid)
	local var_27_1 = ccui.ScrollView:create()

	var_27_1:setDirection(ccui.ScrollViewDir.horizontal)
	var_27_1:setContentSize(cc.size(self.bg:getContentSize().width - 30, 150))
	var_27_1:setPosition(15, 10)
	var_27_1:setInnerContainerSize(cc.size(#var_27_0 * 95, var_27_1:getContentSize().height))
	var_27_1:setName("itemListMap")
	self.bg:addChild(var_27_1)
	self:updateMapDrops(var_27_0)
end

function ExploreOfferPopLayer:updateMapDropsUI()
	local var_28_0 = self.bg:getChildByName("itemListMap")
	local var_28_1 = explore_manager:getOfferMapDrops(self.offerid)

	var_28_0:setContentSize(cc.size(self.bg:getContentSize().width - 30, 150))
	var_28_0:setInnerContainerSize(cc.size(#var_28_1 * 95, var_28_0:getContentSize().height))
	var_28_0:removeAllChildren()
	self:updateMapDrops(var_28_1)
end

function ExploreOfferPopLayer:updateMapDrops(arg_29_1)
	local var_29_0 = self.bg:getChildByName("itemListMap")

	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		local var_29_1 = iter_29_1.dropid
		local var_29_2 = ccui.ImageView:create("public/box/" .. item_data[iter_29_1.dropid].equip_quality .. ".png", var_0_15)

		var_29_2:setScale(0.9)
		var_29_2:setAnchorPoint(cc.p(0, 0.5))
		var_29_2:setPosition((iter_29_0 - 1) * 95, var_29_0:getContentSize().height / 2)
		var_29_0:addChild(var_29_2)
		var_29_2:setTouchEnabled(true)
		var_29_2:addTouchEventListener(function(arg_30_0, arg_30_1)
			if arg_30_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_29_1
			})
		end)

		local var_29_3 = ItemNoBgSprite:create(iter_29_1.dropid)

		var_29_3:setScale(80 / var_29_3:getChildByName("icon"):getContentSize().width)
		var_29_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_29_3:setPosition(var_29_2:getContentSize().width / 2, var_29_2:getContentSize().height / 2)
		var_29_2:addChild(var_29_3)
	end
end

function ExploreOfferPopLayer:initTeam()
	local var_31_0 = ccui.ImageView:create(var_0_16 .. "pop_team_bg.png", var_0_15)

	var_31_0:setAnchorPoint(cc.p(0.5, 1))
	var_31_0:setPosition(self.bg:getContentSize().width / 2, -5)
	self.bg:addChild(var_31_0)

	local var_31_1 = cc.Label:createWithTTF("", FONT_NAME, 20)

	var_31_1:setAnchorPoint(cc.p(0, 0))
	var_31_1:setPosition(50, 120)
	var_31_0:addChild(var_31_1)

	self.teamFightPowerLabel = var_31_1

	local var_31_2 = ccui.Button:create(var_0_16 .. "array_bianji.png", nil, var_0_16 .. "array_bianji.png", var_0_15)

	var_31_2:setPosition(496, 80)
	var_31_0:addChild(var_31_2)
	var_31_2:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:registerArrayBtnEvent()
	end)

	local var_31_3 = {
		88
	}

	for iter_31_0 = 2, FORMATION_SHOW_GIRL_NUM do
		var_31_3[iter_31_0] = var_31_3[1] + (iter_31_0 - 1) * 82
	end

	self.roles = {}

	for iter_31_1 = 1, FORMATION_SHOW_GIRL_NUM do
		local var_31_4 = ccui.Button:create(var_0_16 .. "array_jiaose.png", var_0_16 .. "array_jiaose.png", var_0_16 .. "array_jiaose.png", var_0_15)

		var_31_4:setPosition(var_31_3[iter_31_1], 80)
		var_31_4:setScale(0.8)
		var_31_0:addChild(var_31_4, 5 - iter_31_1)

		self.roles[iter_31_1] = var_31_4

		local var_31_5 = ccui.Button:create(var_0_16 .. "array_add.png", var_0_16 .. "array_add.png", var_0_16 .. "array_add.png", var_0_15)

		var_31_5:setPosition(var_31_4:getContentSize().width / 2, var_31_4:getContentSize().height / 2)
		var_31_4:addChild(var_31_5)

		local var_31_6 = ccui.ImageView:create("GUI/image.png", var_0_15)

		var_31_6:setPosition(var_31_4:getContentSize().width / 2, var_31_4:getContentSize().height / 2)
		var_31_6:setScale(0.7)
		var_31_4:addChild(var_31_6)

		local var_31_7 = ccui.ImageView:create(var_0_16 .. "array_level_di.png", var_0_15)

		var_31_7:setAnchorPoint(cc.p(0, 0))
		var_31_4:addChild(var_31_7)

		local var_31_8 = ccui.ImageView:create("public/career_icon/light.png", var_0_15)

		var_31_8:setAnchorPoint(cc.p(0.5, 0))
		var_31_8:setScale(0.5)
		var_31_8:setPosition(10, 0)
		var_31_7:addChild(var_31_8)

		local var_31_9 = cc.Label:createWithTTF("", FONT_NAME, 16)

		var_31_9:setAnchorPoint(cc.p(1, 0))
		var_31_9:setPosition(var_31_7:getContentSize().width - 5, 0)
		var_31_7:addChild(var_31_9)
		var_31_4:addTouchEventListener(function(arg_33_0, arg_33_1)
			if arg_33_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:registerArrayBtnEvent()
		end)
		var_31_5:addTouchEventListener(function(arg_34_0, arg_34_1)
			if arg_34_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:registerArrayBtnEvent()
		end)

		var_31_4.addBtn = var_31_5
		var_31_4.headImg = var_31_6
		var_31_4.bottomBg = var_31_7
		var_31_4.attrImg = var_31_8
		var_31_4.levelLabel = var_31_9
	end

	self:updateTeam()
end

function ExploreOfferPopLayer:updateTeam()
	if not next(self.arrayInfo) then
		return
	end

	for iter_35_0, iter_35_1 in ipairs(self.roles) do
		local var_35_0 = iter_35_1.headImg
		local var_35_1 = iter_35_1.levelLabel

		if self.arrayInfo[iter_35_0] and self.arrayInfo[iter_35_0].fight_girl then
			iter_35_1.addBtn:setVisible(false)
			var_35_0:setVisible(true)
			iter_35_1.bottomBg:setVisible(true)

			local var_35_2
			local var_35_3
			local var_35_4

			if self.arrayInfo[iter_35_0].npcid then
				var_35_2 = explore_manager:getCurArrayModel(self.arrayInfo[iter_35_0])
				var_35_3 = global_get_model_attr(var_35_2)
				var_35_4 = npc_fightconfig_data[self.arrayInfo[iter_35_0].npcid].level and npc_fightconfig_data[self.arrayInfo[iter_35_0].npcid].rank * 100 + npc_fightconfig_data[self.arrayInfo[iter_35_0].npcid].level or 1
			else
				local core_manager = require("controller.core_manager")

				var_35_2 = servant_data[self.arrayInfo[iter_35_0].fight_girl].modelid
				var_35_3 = global_get_model_attr(servant_data[self.arrayInfo[iter_35_0].fight_girl].modelid)
				var_35_4 = core_manager:getCoreLv(self.arrayInfo[iter_35_0].fight_girl)
			end

			var_35_0:loadTexture(ROLE_PORTRAIT_PATH .. model_data[var_35_2].portrait_image .. ".png")
			iter_35_1.attrImg:loadTexture("public/career_icon/" .. var_35_3 .. ".png", var_0_15)
			var_35_1:setString(L_EQUIPLAYER[6] .. var_35_4)

			if not self.arrayInfo[iter_35_0].npcid and role_false_level_manager:isRoleFalseLevelMember(self.arrayInfo[iter_35_0].fight_girl, FIGHTTYPE_EXPLORE) then
				local var_35_6, var_35_7, var_35_8, var_35_9 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(self.arrayInfo[iter_35_0].fight_girl, FIGHTTYPE_EXPLORE)

				var_35_1:setOpacity(255)
				var_35_1:stopAllActions()
				var_35_1:setColor(cc.c3b(206, 255, 167))

				local var_35_10 = true

				var_35_1:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(2), cc.CallFunc:create(function(...)
					if var_35_10 then
						var_35_1:setString(L_EXPLORE_OFFER_POP[3])
					else
						var_35_1:setString(L_EQUIPLAYER[6] .. var_35_7)
					end

					var_35_10 = not var_35_10
				end), cc.FadeIn:create(2))))
			else
				var_35_1:stopAllActions()
			end
		else
			iter_35_1.addBtn:setVisible(true)
			var_35_0:setVisible(false)
			iter_35_1.bottomBg:setVisible(false)
		end
	end

	self.teamFightPowerLabel:setString(string.format(L_AVAON_VISUAL.array_power, global_trans_number((fight_capacity_manager:getArrayFightCapacity(self.arrayInfo, nil, nil, FIGHTTYPE_EXPLORE)))))
end

function ExploreOfferPopLayer:registerArrayBtnEvent()
	local function var_37_0(arg_38_0)
		self:updateArrayData(arg_38_0)
		self:updateTeam()
	end

	local function var_37_1(arg_39_0)
		self:updateArrayData(arg_39_0)
		self:updateTeam()
	end

	local var_37_2 = {}

	if self.is_array_fix then
		var_37_2.fix_array = self.arrayInfo or nil
	end

	var_37_2.initindex = RoleDefault:getInstance():getIntegerForKey("explore_array_id", 1)

	if self.is_hp_inherit then
		var_37_2.configtype = CONFIG_TYPE_EXPLORE_HP_INHERIT or CONFIG_TYPE_EXPLORE
	end

	var_37_2.configcallback = var_37_0
	var_37_2.virtualcallbak = var_37_1
	var_37_2.is_hp_inherit = self.is_hp_inherit

	if self.is_array_fix then
		local var_37_3 = {}

		if self.is_array_fix then
			var_37_3.fix_array = self.arrayInfo or nil
		end

		var_37_3.initindex = RoleDefault:getInstance():getIntegerForKey("explore_array_id", 1)

		if self.is_hp_inherit then
			var_37_3.configtype = CONFIG_TYPE_EXPLORE_HP_INHERIT or CONFIG_TYPE_EXPLORE
		end

		var_37_3.configCallback = var_37_0
		var_37_3.is_hp_inherit = self.is_hp_inherit
		var_37_3.customConfigexitCallback = var_37_1

		var_0_13:pushFormationLayer("FormationSpecialExploreLayer", var_37_3)
	else
		local var_37_4 = {}

		if self.is_array_fix then
			var_37_4.fix_array = self.arrayInfo or nil
		end

		var_37_4.initindex = RoleDefault:getInstance():getIntegerForKey("explore_array_id", 1)

		if self.is_hp_inherit then
			var_37_4.configtype = CONFIG_TYPE_EXPLORE_HP_INHERIT or CONFIG_TYPE_EXPLORE
		end

		var_37_4.configCallback = var_37_0
		var_37_4.customConfigexitCallback = var_37_1
		var_37_4.is_hp_inherit = self.is_hp_inherit

		var_0_13:pushFormationLayer("FormationExploreLayer", var_37_4)
	end
end

function ExploreOfferPopLayer:initSureBtn()
	self.sureBtn = ccui.Button:create(var_0_16 .. "pop_sure_button" .. ".png", nil, var_0_16 .. "pop_sure_button" .. ".png", var_0_15)

	self.sureBtn:setPosition(self.bg:getContentSize().width / 2, -240)
	self.bg:addChild(self.sureBtn)

	local var_40_0 = ccui.ImageView:create("public/currency/electric.png", var_0_15)

	var_40_0:setPosition(self.sureBtn:getContentSize().width / 2 - 80, self.sureBtn:getContentSize().height + var_40_0:getContentSize().height - 30)
	self.sureBtn:addChild(var_40_0)

	local var_40_1 = cc.Label:createWithTTF(L_COST_POWER .. self.offerInfo.power_cost, FONT_NAME, 20)

	var_40_1:setAnchorPoint(cc.p(0, 0.52))
	var_40_1:setPosition(var_40_0:getPositionX() + var_40_0:getBoundingBox().width / 2, var_40_0:getPositionY())
	self.sureBtn:addChild(var_40_1)
	self.sureBtn:addTouchEventListener(function(arg_41_0, arg_41_1)
		if arg_41_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_41_0, var_41_1 = self:checkCondition()

		if not var_41_0 then
			global_ShowBlockWords(var_41_1)

			return
		end

		if self.sureCallback then
			self.sureCallback(self.offerid, self.arrayInfo)
		end
	end)
end

function ExploreOfferPopLayer:updateBtnStatus()
	if not self.btnMop then
		self.btnMop = ccui.Button:create(var_0_16 .. "btn_mop_up.png", nil, var_0_16 .. "btn_mop_up.png", var_0_15)

		self.btnMop:setPosition(self.bg:getContentSize().width / 2 - 135, -240)
		self.bg:addChild(self.btnMop)
		Utility:addClickEventListener(self.btnMop, handler(self, self.onBtnMopUp))
	end

	local var_42_0 = IsOpenPrivilege()

	self.btnMop:setVisible(var_42_0)

	if var_42_0 then
		self.sureBtn:setPositionX(self.bg:getContentSize().width / 2 + 135)
	else
		self.sureBtn:setPositionX(self.bg:getContentSize().width / 2)
	end
end

function ExploreOfferPopLayer:onBtnMopUp(arg_43_1)
	if not explore_manager:queryAimCanMopUp(self.aimid) then
		global_ShowBlockWords(L_EXPLORE_OFFER_TIPS[1])
	end

	explore_manager:do_explore_mop_up(4, self.offerid, function(arg_44_0)
		if arg_44_0 == 1 then
			LayerManager:removePopLayer(self.__queueindex)
			item_manager:deleteItem(ELECTRIC, self.offerInfo.power_cost)
			LocalEvent:triggerEvent(LocalEvent.EVENT_IDS.UPDATE_OFFERS)
		else
			print("扫荡失败")
			global_ShowBlockWords(L_EXPLORE_OFFER_TIPS[arg_44_0] or L_EXPLORE_OFFER)
		end
	end)
end

function ExploreOfferPopLayer:getBossSkillList(arg_45_1)
	local var_45_0 = {}

	if model_data[arg_45_1].passive then
		table.insert(var_45_0, model_data[arg_45_1].passive)
	end

	if model_data[arg_45_1].XP then
		table.insert(var_45_0, model_data[arg_45_1].XP)
	end

	return next(var_45_0) ~= nil and var_45_0 or nil
end

function ExploreOfferPopLayer:getBgMoreHeight()
	local var_46_0 = explore_manager:getOfferConditions(self.offerid)

	if not var_46_0 then
		return 0
	end

	if next(var_46_0) == nil then
		return 0
	end

	return #var_46_0 * 60
end

function ExploreOfferPopLayer:createClipRing(arg_47_1, arg_47_2)
	local var_47_0 = ccui.ImageView:create(var_0_16 .. "skill_bg.png", var_0_15)
	local var_47_1 = cc.ClippingNode:create()

	var_47_1:setPosition(var_47_0:getContentSize().width / 2, var_47_0:getContentSize().height / 2)
	var_47_1:setInverted(false)
	var_47_1:setAlphaThreshold(0.5)
	var_47_0:addChild(var_47_1)

	local var_47_2

	if config._DEBUG then
		var_47_2 = cc.Sprite:create(var_0_16 .. "skill_mask.png") or cc.Sprite:createWithSpriteFrameName(var_0_16 .. "skill_mask.png")
	end

	var_47_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_47_1:setStencil(var_47_2)

	local var_47_3 = ccui.ImageView:create(arg_47_1, (not arg_47_1:find("role/") or nil) and (var_0_15 or 0))

	var_47_3:setScale(arg_47_2 or 1)
	var_47_1:addChild(var_47_3)

	return var_47_0
end

function ExploreOfferPopLayer:checkCondition()
	local var_48_0 = explore_manager:getOfferConditions(self.offerid)

	if not var_48_0 then
		return true
	end

	if next(var_48_0) == nil then
		return true
	end

	local var_48_1 = {}
	local var_48_2 = {}

	for iter_48_0, iter_48_1 in pairs(var_48_0) do
		if iter_48_1.limit_type == 1 then
			for iter_48_2, iter_48_3 in ipairs(iter_48_1.attrs) do
				var_48_1[iter_48_3] = true
			end
		elseif iter_48_1.limit_type == 2 then
			for iter_48_4, iter_48_5 in ipairs(iter_48_1.models) do
				var_48_2[iter_48_5] = 0
			end
		end
	end

	for iter_48_6, iter_48_7 in pairs(self.arrayInfo) do
		if iter_48_7.fight_girl and not iter_48_7.npcid then
			if not var_48_1[global_get_model_attr(servant_data[iter_48_7.fight_girl].modelid)] then
				return false, L_OFFER_CONDITION_ERROE1
			end

			if var_48_2[iter_48_7.fight_girl] then
				var_48_2[iter_48_7.fight_girl] = 1
			end
		end
	end

	for iter_48_8, iter_48_9 in pairs(var_48_2) do
		if iter_48_9 == 0 then
			return false, L_OFFER_CONDITION_ERROE2
		end
	end

	return true
end

function ExploreOfferPopLayer:updateLayout()
	local var_49_0 = explore_manager:getOfferList(self.offerInfo.offerType)
	local var_49_1 = var_49_0[Utility:indexOf(var_49_0, function(arg_50_0)
		return arg_50_0.index == self.offerInfo.index
	end)]

	if not var_49_0[Utility:indexOf(var_49_0, function(arg_50_0)
		return arg_50_0.index == self.offerInfo.index
	end)] then
		var_49_1 = {}
	end

	self.offerInfo = var_49_1
	self.offerid = var_49_1.offerid
	self.aimid = var_49_1.aimid

	self:initArrayData()
	self:updateTitleUI()
	self:updateDesUI()
	self:updateDropsUI()
	self:updateMapDropsUI()
	self:updateBtnStatus()
	self:updateTeam()
end

return ExploreOfferPopLayer
