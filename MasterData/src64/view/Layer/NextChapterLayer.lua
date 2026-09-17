NextChapterLayer = class("NextChapterLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local level_manager = require("controller.level_manager")
local chapter_data = require("data.chapter_data")
local model_data = require("data.model_data")
local array_manager = require("controller.array_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local playermodel = require("model.playermodel")
local drop_data = require("data.drop_data")
local item_data = require("data.item_data")
local monster_manager = require("controller.monster_manager")
local horcrux_manager = require("controller.horcrux_manager")
local total_skill_data = require("data.total_skill_data")

function NextChapterLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = NextChapterLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function NextChapterLayer:init(arg_3_1)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "NextChapter.json" or "NextChapter.ExportJson")

	LayerManager:createFullScreenMask(self, ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_back"):getBackGroundColorOpacity(), function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer()
	end)
	self:addChild(self.rootlayer)

	self.panelBottom = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_bottom")

	self.panelBottom:setAnchorPoint(cc.p(0.5, 0.5))
	self.panelBottom:setPosition(cc.p(320, 588))

	self.panelBack = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_back")

	self.panelBack:setBackGroundColorOpacity(0)
	self.panelBack:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:removePopLayer()
	end)

	self.mode = arg_3_1.mode
	self.curChapter = arg_3_1.curchapter + 1
	self.btnNextChapter = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_nextChapter")

	self.btnNextChapter:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_3_1.surecallback()
		LayerManager:removePopLayer()
	end)

	self.ChapterName = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_ChapterName")

	self.ChapterName:setString(level_manager:getChapterName(self.mode, self.curChapter))

	self.ChapterDesc = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_chapterDesc")

	self.ChapterDesc:setString(level_manager:getChapterDes(self.mode, self.curChapter))

	self.imageCuteBoss = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bossCute")
	self.labelEnemyName = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_bossName")
	self.labelArraryFightPower = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_arraryFightPower")

	self.labelArraryFightPower:setString(global_trans_number(fight_capacity_manager:getArrayFightCapacity((array_manager:getBattleArrayData(playermodel.curArray)))))
	self:initEnemyInfo(arg_3_1)
	self:initEarn()
	self:initDrop()
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" and self.panelDropOne then
			self.panelDropOne:release()
		end
	end)
end

function NextChapterLayer:initDrop()
	self.ListViewDrop = ccui.Helper:seekWidgetByName(self.rootlayer, "ListView_drop")

	self.ListViewDrop:setItemsMargin(30)

	self.panelDropOne = self.ListViewDrop:getChildByName("Panel_dropOne")

	self.panelDropOne:retain()
	self.panelDropOne:removeFromParent()

	local var_8_0 = self:getDropData()

	if var_8_0.gold > 0 then
		local var_8_1 = self.panelDropOne:clone()
		local var_8_2 = ItemSprite:createNewWithItemId("gold", var_8_0.gold)

		var_8_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_8_2:setPosition(cc.p(var_8_1:getContentSize().width * 0.5, var_8_1:getContentSize().height * 0.5))
		var_8_2:setScale(0.76)
		var_8_1:addChild(var_8_2)
		self.ListViewDrop:pushBackCustomItem(var_8_1)
	end

	if var_8_0.diamond > 0 then
		local var_8_3 = self.panelDropOne:clone()
		local var_8_4 = ItemSprite:createNewWithItemId("diamond", var_8_0.diamond)

		var_8_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_8_4:setPosition(cc.p(var_8_3:getContentSize().width * 0.5, var_8_3:getContentSize().height * 0.5))
		var_8_4:setScale(0.76)
		var_8_3:addChild(var_8_4)
		self.ListViewDrop:pushBackCustomItem(var_8_3)
	end

	for iter_8_0 = 1, #var_8_0.items do
		local var_8_5 = self.panelDropOne:clone()
		local var_8_6 = ItemSprite:createNewWithItemId(var_8_0.items[iter_8_0].itemid, var_8_0.items[iter_8_0].num)

		var_8_6:setAnchorPoint(cc.p(0.5, 0.5))
		var_8_6:setScale(0.76)
		var_8_6:setPosition(cc.p(var_8_5:getContentSize().width * 0.5, var_8_5:getContentSize().height * 0.5))
		var_8_5:addChild(var_8_6)

		var_8_5.item_type = "item"

		var_8_5:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:showDetailsofItems(var_8_0.items[iter_8_0].itemid, var_8_5.item_type)
		end)
		self.ListViewDrop:pushBackCustomItem(var_8_5)
	end
end

function NextChapterLayer:showDetailsofItems(arg_10_1, arg_10_2)
	local function var_10_1()
		self.rootlayer:setVisible(true)
	end

	if arg_10_2 == "item" then
		if item_data[arg_10_1].bag_item_type == kITEM_HORCRUX then
			local var_10_2 = -1
			local horcrux_data = require("data.horcrux_data")

			for iter_10_0, iter_10_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if iter_10_1.model_id == horcrux_data[arg_10_1].model then
					var_10_2 = iter_10_0

					break
				end
			end

			if var_10_2 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_10_2,
				itemid = arg_10_1,
				callback = var_10_1
			})
			self.rootlayer:setVisible(false)
		elseif item_data[arg_10_1].bag_item_type == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = item_data[arg_10_1].servant,
				exitCallback = var_10_1
			})
			self.rootlayer:setVisible(false)
		elseif not global_basic_scene:getChildByName("OTHER_LAYER") then
			local var_10_4 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_10_1
			})
		end
	elseif arg_10_2 == "gold" then
		-- block empty
	elseif arg_10_2 == "diamond" then
		-- block empty
	end
end

function NextChapterLayer:getDropData()
	local var_12_1 = level_manager.loadLevelData(self.mode)
	local var_12_2 = {
		gold = 0,
		diamond = 0,
		items = {}
	}
	local var_12_3 = drop_data[chapter_data[self.mode .. "-" .. self.curChapter].bigbossdrop] or drop_data[chapter_data[self.mode .. "-" .. self.curChapter].equip_drop] or {}

	if var_12_3.gold then
		var_12_2.gold = var_12_2.gold + var_12_3.gold
	end

	if var_12_3.diamond then
		var_12_2.diamond = var_12_2.diamond + var_12_3.diamond
	end

	local var_12_4 = 1

	if var_12_3["drop_id" .. 1] then
		local var_12_5 = 1

		while var_12_3["drop_id" .. var_12_5] do
			var_12_2.items[var_12_4] = {
				itemid = var_12_3["drop_id" .. var_12_5],
				num = var_12_3["drop_num" .. var_12_5]
			}
			var_12_5 = var_12_5 + 1
			var_12_4 = var_12_4 + 1
		end
	end

	if var_12_3["dropmodel_id" .. 1] then
		local var_12_6 = 1

		while var_12_3["dropmodel_id" .. var_12_6] do
			if drop_data[var_12_3["dropmodel_id" .. var_12_6]].gold then
				var_12_2.gold = var_12_2.gold + drop_data[var_12_3["dropmodel_id" .. var_12_6]].gold
			end

			if drop_data[var_12_3["dropmodel_id" .. var_12_6]].diamond then
				var_12_2.diamond = var_12_2.diamond + drop_data[var_12_3["dropmodel_id" .. var_12_6]].diamond
			end

			if drop_data[var_12_3["dropmodel_id" .. var_12_6]]["drop_id" .. 1] then
				local var_12_7 = 1

				while drop_data[var_12_3["dropmodel_id" .. var_12_6]]["drop_id" .. var_12_7] do
					var_12_2.items[var_12_4] = {
						itemid = drop_data[var_12_3["dropmodel_id" .. var_12_6]]["drop_id" .. var_12_7],
						num = drop_data[var_12_3["dropmodel_id" .. var_12_6]]["drop_num" .. var_12_7]
					}
					var_12_7 = var_12_7 + 1
					var_12_4 = var_12_4 + 1
				end
			end

			if drop_data[var_12_3["dropmodel_id" .. var_12_6]]["rd_drop_id" .. 1] then
				local var_12_8 = 1

				while drop_data[var_12_3["dropmodel_id" .. var_12_6]]["rd_drop_id" .. var_12_8] do
					var_12_2.items[var_12_4] = {
						itemid = drop_data[var_12_3["dropmodel_id" .. var_12_6]]["rd_drop_id" .. var_12_8],
						num = drop_data[var_12_3["dropmodel_id" .. var_12_6]]["rd_drop_num" .. var_12_8]
					}
					var_12_8 = var_12_8 + 1
					var_12_4 = var_12_4 + 1
				end
			end

			var_12_6 = var_12_6 + 1
		end
	end

	if var_12_3["rd_drop_id" .. 1] then
		local var_12_9 = 1

		while var_12_3["rd_drop_id" .. var_12_9] do
			var_12_2.items[var_12_4] = {
				itemid = var_12_3["rd_drop_id" .. var_12_9],
				num = var_12_3["rd_drop_num" .. var_12_9]
			}
			var_12_9 = var_12_9 + 1
			var_12_4 = var_12_4 + 1
		end
	end

	if var_12_3["rd_dropmodel_id" .. 1] then
		local var_12_10 = 1

		while var_12_3["rd_dropmodel_id" .. var_12_10] do
			if drop_data[var_12_3["rd_dropmodel_id" .. var_12_10]].gold then
				var_12_2.gold = var_12_2.gold + drop_data[var_12_3["rd_dropmodel_id" .. var_12_10]].gold
			end

			if drop_data[var_12_3["rd_dropmodel_id" .. var_12_10]].diamond then
				var_12_2.diamond = var_12_2.diamond + drop_data[var_12_3["rd_dropmodel_id" .. var_12_10]].diamond
			end

			if drop_data[var_12_3["rd_dropmodel_id" .. var_12_10]]["drop_id" .. 1] then
				local var_12_11 = 1

				while drop_data[var_12_3["rd_dropmodel_id" .. var_12_10]]["drop_id" .. var_12_11] do
					var_12_2.items[var_12_4] = {
						itemid = drop_data[var_12_3["rd_dropmodel_id" .. var_12_10]]["drop_id" .. var_12_11],
						num = drop_data[var_12_3["rd_dropmodel_id" .. var_12_10]]["drop_num" .. var_12_11]
					}
					var_12_11 = var_12_11 + 1
					var_12_4 = var_12_4 + 1
				end
			end

			if drop_data[var_12_3["rd_dropmodel_id" .. var_12_10]]["rd_drop_id" .. 1] then
				local var_12_12 = 1

				while drop_data[var_12_3["rd_dropmodel_id" .. var_12_10]]["rd_drop_id" .. var_12_12] do
					var_12_2.items[var_12_4] = {
						itemid = drop_data[var_12_3["rd_dropmodel_id" .. var_12_10]]["rd_drop_id" .. var_12_12],
						num = drop_data[var_12_3["rd_dropmodel_id" .. var_12_10]]["rd_drop_num" .. var_12_12]
					}
					var_12_12 = var_12_12 + 1
					var_12_4 = var_12_4 + 1
				end
			end

			var_12_10 = var_12_10 + 1
		end
	end

	return var_12_2
end

function NextChapterLayer:initEnemyInfo(arg_13_1)
	self.bossTeam = self:GetBossOrEnemyInfo()

	if self.bossTeam.boss then
		self.labelEnemyName:setString(self.bossTeam.boss.name)
		self.labelEnemyName:setLocalZOrder(999)
		self.imageCuteBoss:loadTexture("roleimage/role1/" .. self.bossTeam.boss.icon .. ".png")
	else
		self.labelEnemyName:setString(self.bossTeam.monster[1].name)
		self.labelEnemyName:setLocalZOrder(999)
		self.imageCuteBoss:loadTexture("roleimage/role1/" .. self.bossTeam.monster[1].icon .. ".png")
	end

	self.labelEnemyName:setPosition(cc.p(self.imageCuteBoss:getPositionX(), self.imageCuteBoss:getPositionY() - self.imageCuteBoss:getContentSize().height / 4 - 10))
	self.imageCuteBoss:setScale(0.5)

	self.fightPowerSum = 0

	if self.bossTeam.boss then
		self.fightPowerSum = self.fightPowerSum + fight_capacity_manager:getEnemyFightCapacity(self.mode, self.bossTeam.boss.id) * 0.8
	end

	if self.bossTeam.monster then
		for iter_13_0 = 1, #self.bossTeam.monster do
			self.fightPowerSum = self.fightPowerSum + fight_capacity_manager:getEnemyFightCapacity(self.mode, self.bossTeam.monster[iter_13_0].id) * 0.8
		end
	end

	if chapter_data[self.mode .. "-" .. self.curChapter].combat_limit then
		self.fightPowerSum = chapter_data[self.mode .. "-" .. self.curChapter].combat_limit
		self.fightPowerSum = self.mode == 1 and tonumber(string.split(chapter_data[self.mode .. "-" .. self.curChapter].name, "-")[1]) <= 5 and self.fightPowerSum * 0.5 or self.fightPowerSum * 0.75
	end

	local var_13_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_bossFightPowerGreen")
	local var_13_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_bossFightPowerRed")

	roleArray = array_manager:getBattleArrayData(playermodel.curArray)

	if fight_capacity_manager:getArrayFightCapacity(roleArray) > self.fightPowerSum then
		var_13_0:setString(global_trans_number(self.fightPowerSum))
	else
		var_13_1:setString(global_trans_number(self.fightPowerSum))
	end

	local var_13_2 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_chapterFightPower")

	if fight_capacity_manager:getArrayFightCapacity(roleArray) > self.fightPowerSum then
		var_13_2:loadTexture("nextChapter/img_capacity_chapter_easy.png", var_0_0)
		var_13_0:setPosition(cc.p(var_13_2:getPositionX() + var_13_2:getContentSize().width / 2, var_13_2:getPositionY() - 3))
	else
		var_13_2:loadTexture("nextChapter/img_capacity_chapter_hard.png", var_0_0)
		var_13_1:setPosition(cc.p(var_13_2:getPositionX() + var_13_2:getContentSize().width / 2, var_13_2:getPositionY() - 3))
	end
end

function NextChapterLayer:initEarn()
	self.earn = self:getEarnData()
	self.panel_content = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_content")
	self.labelEarn = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_earn")

	local var_14_0 = 0
	local var_14_1 = 0
	local var_14_2 = {}
	local var_14_3 = {}

	if self.earn.gold ~= 0 then
		local var_14_4 = self.labelEarn:clone()
		local var_14_5 = ccui.ImageView:create(IMAGE_GOLD, var_0_0)

		var_14_2[#var_14_2 + 1] = var_14_5

		self.panel_content:addChild(var_14_5)
		var_14_4:setString("+" .. self.earn.gold * 6 .. "/M")
		var_14_4:setColor(cc.c3b(234, 232, 226))

		var_14_3[#var_14_3 + 1] = var_14_4

		var_14_4:setName("goldLabel")
		self.panel_content:addChild(var_14_4)

		var_14_1 = var_14_1 + 1
	end

	if self.earn.exp ~= 0 then
		local var_14_6 = self.labelEarn:clone()
		local var_14_7 = ccui.ImageView:create("BossFightPreview/award_exp.png", var_0_0)

		var_14_2[#var_14_2 + 1] = var_14_7

		self.panel_content:addChild(var_14_7)
		var_14_6:setString("+" .. self.earn.exp * 6 .. "/M")
		var_14_6:setColor(cc.c3b(234, 232, 226))

		var_14_3[#var_14_3 + 1] = var_14_6

		var_14_6:setName("expLabel")
		self.panel_content:addChild(var_14_6)

		var_14_1 = var_14_1 + 1
	end

	if self.earn.strengthpoint ~= 0 then
		local var_14_8 = self.labelEarn:clone()
		local var_14_9 = ccui.ImageView:create(IMAGE_STRENGTHPOINT, var_0_0)

		var_14_2[#var_14_2 + 1] = var_14_9

		self.panel_content:addChild(var_14_9)

		var_14_0 = var_14_0 + var_14_9:getContentSize().width + 5

		var_14_8:setString("+" .. self.earn.strengthpoint * 6 .. "/M")
		var_14_8:setColor(cc.c3b(234, 232, 226))

		var_14_3[#var_14_3 + 1] = var_14_8

		var_14_8:setName("strengthPointLabel")
		self.panel_content:addChild(var_14_8)

		var_14_1 = var_14_1 + 1
	end

	if self.earn.increase_icon ~= 0 then
		local var_14_10 = ccui.ImageView:create("nextChapter/" .. self.earn.increase_icon .. ".png", var_0_0)

		var_14_10:setAnchorPoint(cc.p(0.5, 1))

		var_14_2[#var_14_2 + 1] = var_14_10

		self.panel_content:addChild(var_14_10)

		local var_14_11 = var_14_0 + var_14_10:getContentSize().width + 5

		var_14_1 = var_14_1 + 1
	end

	if var_14_1 ~= 0 then
		local var_14_13 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_content"):getContentSize().height / 2 + (var_14_2[1]:getContentSize().height / 2 + 10) * var_14_1

		for iter_14_0 = 1, var_14_1 do
			var_14_2[iter_14_0]:setPosition(cc.p(68, var_14_13))

			var_14_13 = var_14_13 - var_14_2[1]:getContentSize().height / 2 - 20

			if var_14_3[iter_14_0] then
				var_14_3[iter_14_0]:setPosition(cc.p(68, var_14_13))

				var_14_13 = var_14_13 - var_14_2[1]:getContentSize().height / 2 - 20
			end
		end
	else
		local var_14_14 = ccui.ImageView:create("nextChapter/img_nothing.png", var_0_0)

		var_14_14:setPosition(self.panel_content:getContentSize().width / 2, self.panel_content:getContentSize().height / 2)
		self.panel_content:addChild(var_14_14, 999)
	end
end

function NextChapterLayer:getEarnData()
	local var_15_0 = {
		exp = 0,
		gold = 0,
		strengthpoint = 0,
		increase_icon = 0
	}
	local var_15_2 = level_manager.loadLevelData(self.mode)

	if self.curChapter == 1 then
		if chapter_data[self.mode .. "-" .. self.curChapter].gold then
			var_15_0.gold = chapter_data[self.mode .. "-" .. self.curChapter].gold
		end

		if chapter_data[self.mode .. "-" .. self.curChapter].exp then
			var_15_0.exp = chapter_data[self.mode .. "-" .. self.curChapter].exp
		end

		if chapter_data[self.mode .. "-" .. self.curChapter].strengthpoint then
			var_15_0.strengthpoint = chapter_data[self.mode .. "-" .. self.curChapter].strengthpoint
		end

		if chapter_data[self.mode .. "-" .. self.curChapter].increase_icon then
			var_15_0.increase_icon = chapter_data[self.mode .. "-" .. self.curChapter].increase_icon
		end
	else
		local var_15_3 = chapter_data[self.mode .. "-" .. self.curChapter - 1]

		if chapter_data[self.mode .. "-" .. self.curChapter].gold then
			var_15_0.gold = chapter_data[self.mode .. "-" .. self.curChapter].gold - var_15_3.gold
		end

		if chapter_data[self.mode .. "-" .. self.curChapter].exp then
			var_15_0.exp = chapter_data[self.mode .. "-" .. self.curChapter].exp - var_15_3.exp
		end

		if chapter_data[self.mode .. "-" .. self.curChapter].strengthpoint then
			var_15_0.strengthpoint = chapter_data[self.mode .. "-" .. self.curChapter].strengthpoint - var_15_3.strengthpoint
		end

		if chapter_data[self.mode .. "-" .. self.curChapter].increase_icon then
			var_15_0.increase_icon = chapter_data[self.mode .. "-" .. self.curChapter].increase_icon
		end
	end

	return var_15_0
end

local function var_0_12(arg_16_0)
	return global_get_model_attr(arg_16_0)
end

local function var_0_13(arg_17_0)
	local var_17_0 = {}

	var_17_0.name = model_data[arg_17_0.modelid].main_name or model_data[arg_17_0.modelid].name
	var_17_0.icon = model_data[arg_17_0.modelid].cute_role
	var_17_0.quality = model_data[arg_17_0.modelid].monster_level
	var_17_0.level = arg_17_0.level or "?"
	var_17_0.modelid = arg_17_0.modelid
	var_17_0.id = arg_17_0.id
	var_17_0.attr = var_0_12(arg_17_0.modelid)

	local var_17_1 = horcrux_manager:getMonsterHorcruxAssistConfig(arg_17_0)

	var_17_0.affix = {}

	if var_17_1 then
		for iter_17_0, iter_17_1 in ipairs(var_17_1.skills) do
			var_17_0.affix[iter_17_0] = {
				id = iter_17_1,
				name = total_skill_data[iter_17_1].name,
				des = string.format("%s。", total_skill_data[iter_17_1].description),
				icon = total_skill_data[iter_17_1].icon
			}
		end
	end

	return var_17_0
end

function NextChapterLayer:GetBossOrEnemyInfo()
	local var_18_0 = level_manager:isMainChapterOrFeederChapter(self.mode) and monster_manager.getChapterBigBossAll(self.mode, self.mode .. "-" .. self.curChapter) or self.initconfig.fight_type == "EXPLORE" and exploreManager:initBossListInfo(self.curChapter .. "-" .. self.level) or monster_manager.getLevelBossAll(self.mode, self.curChapter .. "-" .. self.level)
	local var_18_1 = {}

	if var_18_0.boss then
		var_18_1.boss = var_0_13(var_18_0.boss.majorlist)
	end

	if var_18_0.monster and next(var_18_0.monster) then
		var_18_1.monster = {}

		for iter_18_0, iter_18_1 in ipairs(var_18_0.monster) do
			table.insert(var_18_1.monster, var_0_13(iter_18_1.majorlist))
		end
	end

	return var_18_1
end

function NextChapterLayer.exit(arg_19_0)
	LayerManager:removePopLayer()
end
