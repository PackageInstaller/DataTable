AdventureNewDetailLayer = class("AdventureNewDetailLayer", function()
	return cc.Layer:create()
end)

local var_0_1 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")
require("view.Layer.BattleArrayLayerNew")

local activity_manager = require("controller.activity_manager")
local level_manager = require("controller.level_manager")
local array_manager = require("controller.array_manager")
local audio_manager = require("controller.audio_manager")
local monster_manager = require("controller.monster_manager")
local aiattack_manager = require("controller.aiattack_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local battlefield_status_data = require("data.battlefield_status_data")
local infinite_fight_manager = require("controller.infinite_fight_manager")
local role_false_level_manager = require("controller.role_false_level_manager")
local core_manager = require("controller.core_manager")
local var_0_18 = require("controller.formation.formation_manager"):getInstance()
local major_factor_data = require("data.major_factor_data")
local horcrux_data = require("data.horcrux_data")
local servant_data = require("data.servant_data")
local chapter_data = require("data.chapter_data")
local drop_data = require("data.drop_data")
local model_data = require("data.model_data")
local levelmode_data = require("data.levelmode_data")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_29 = {
	myself = cc.c3b(204, 222, 255),
	enemy = cc.c3b(189, 145, 254)
}
local var_0_30 = {
	"adventurenewlayer/tanchuang.png",
	"adventurenewlayer/tanchuang_awl.png",
	"adventurenewlayer/tanchuang_summer.png",
	"adventurenewlayer/modetype_2.png"
}
local var_0_31 = "adventurenewlayer/array_jiaose.png"
local var_0_32 = {
	cc.p(24, 11),
	(cc.p(24, -89))
}
local var_0_33 = {
	cc.size(270, 80),
	cc.size(270, 120),
	(cc.size(270, 234))
}
local var_0_34 = {
	cc.p(70, -55),
	cc.p(34, -106),
	(cc.p(68, -205))
}
local var_0_35
local var_0_36 = {
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
local var_0_37 = {}

local function var_0_38(arg_2_0)
	if arg_2_0 < 0 then
		return
	end

	return arg_2_0 > 86400 and string.format(L_TIME_FORMAT[1], math.floor(arg_2_0 / 86400), math.floor(arg_2_0 % 86400 / 3600)) or arg_2_0 > 3600 and string.format(L_TIME_FORMAT[2], math.floor(arg_2_0 / 3600), math.floor(arg_2_0 % 3600 / 60)) or string.format(L_TIME_FORMAT[5], math.floor(arg_2_0 / 60), math.floor(arg_2_0 % 60))
end

local function var_0_39(arg_3_0)
	if not chapter_data[arg_3_0] then
		return true
	end

	if chapter_data[arg_3_0].starttime and time_check_manager:getCurTime() <= os.time(parse_time(chapter_data[arg_3_0].starttime)) then
		return false
	end

	if chapter_data[arg_3_0].finishtime and time_check_manager:getCurTime() >= os.time(parse_time(chapter_data[arg_3_0].finishtime)) then
		return false
	end

	return true
end

function AdventureNewDetailLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = AdventureNewDetailLayer.new()

	var_4_0:initBg(arg_4_1)

	return var_4_0
end

function AdventureNewDetailLayer:init(arg_5_1)
	var_0_35 = self

	print("$$$$$$$$$$$$$111$$$$$$$$$$$", dump(arg_5_1))

	var_0_37 = IsOpenPrivilege() and {
		[2] = {
			1,
			1,
			1,
			1
		}
	} or {}
	self.msg = arg_5_1
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "AdventureNewDetailLayer.json" or "AdventureNewDetailLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setPositionY(50)
	self:addChild(self.rootLayer)

	self.topitem = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_topitem")
	self.noitem = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_topitem_wei")
	self.buttonitem = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_13")
	self.ListView_buttom = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_di")
	self.ListView_top = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_top")
	self.kaohebtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_kaohe")
	self.buybtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_goumai")
	self.imagecishu = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cishu")
	self.imagenoopen = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_noopen")
	self.zhanli = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_zhanli")
	self.zhupanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_1")
	self.bossimg = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_head")
	self.ticketPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_ticket")
	self.listview2 = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_29")
	self.items2 = ccui.Helper:seekWidgetByName(self.rootLayer, "items_citiao")
	self.citiaopanel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_cizhui")
	self.listview3 = ccui.Helper:seekWidgetByName(self.citiaopanel, "ListView_37")
	self.listview4 = ccui.Helper:seekWidgetByName(self.citiaopanel, "ListView_37_0")
	self.arraypanel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_array")
	self.array_edit = ccui.Helper:seekWidgetByName(self.arraypanel, "array_edit")
	self.role1 = ccui.Helper:seekWidgetByName(self.arraypanel, "pos_1")
	self.role2 = ccui.Helper:seekWidgetByName(self.arraypanel, "pos_2")
	self.role3 = ccui.Helper:seekWidgetByName(self.arraypanel, "pos_3")
	self.role4 = ccui.Helper:seekWidgetByName(self.arraypanel, "pos_4")
	self.role5 = ccui.Helper:seekWidgetByName(self.arraypanel, "pos_5")
	self.power = ccui.Helper:seekWidgetByName(self.arraypanel, "power")
	self.scores = ccui.Helper:seekWidgetByName(self.arraypanel, "power_0")
	self.titlescore = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_52")
	self.myrule = ccui.Helper:seekWidgetByName(self.citiaopanel, "img_my")
	self.enemyrule = ccui.Helper:seekWidgetByName(self.citiaopanel, "img_diren")
	self.roles = {
		self.role1,
		self.role2,
		self.role3,
		self.role4,
		self.role5
	}
	self.noopenmore = ccui.ImageView:create("adventurenewlayer/tishi_imag.png", var_0_1)

	self.noopenmore:setPosition(cc.p(self.imagenoopen:getContentSize().width / 2, self.imagenoopen:getContentSize().height / 2 - 36))
	self.imagenoopen:addChild(self.noopenmore)

	self.mode = arg_5_1.data.mode
	self.numchapter = arg_5_1.data.totalchapter
	self.advenName = arg_5_1.name
	self.ticke_tnum = arg_5_1.ticke_tnum
	self.ticket_item = arg_5_1.ticket_item
	self.isvisual = arg_5_1.isvisual
	self.score = arg_5_1.score
	self.isrepeat = arg_5_1.data.is_repeat_no_reward
	self.issummeradverture = arg_5_1.issummeradverture
	self.iscanrepeatchange = arg_5_1.data.is_once_fight
	self.isinfinite = arg_5_1.isinfinite
	self.activityId = arg_5_1.activityId
	self.showBuyTimeFunc = arg_5_1.showBuyTimeFunc
	self.is_activity_bossfight = arg_5_1.is_activity_bossfight
	self.canSweep = arg_5_1.canSweep
	self.sweepBtnFunc = arg_5_1.sweepBtnFunc

	if self.canSweep then
		self:initActivityDailyLevelSweepBtn()
	end

	if self.isinfinite then
		self.btnindex = 1

		self:hideInfinteSomeInfo()
		self:initInfintePanel()
		self:fullScreen(self.rootLayer)
		self:initArrayPanel()
		self:createBossInfoBtn()
		global_window_open_action(self.zhupanel)
	else
		if activity_manager:isLockActivityBossFight(self.mode) then
			self.zhupanel:loadTexture(var_0_30[1], var_0_1)
		elseif self.isvisual then
			if not self.issummeradverture then
				self.zhupanel:loadTexture(var_0_30[2], var_0_1)
			else
				self.zhupanel:loadTexture(var_0_30[3], var_0_1)
			end

			self.zhanli:setVisible(false)
			self.titlescore:setVisible(true)
		else
			self.zhupanel:loadTexture(var_0_30[1], var_0_1)
			self.zhanli:setVisible(true)
			self.titlescore:setVisible(false)
		end

		if levelmode_data[self.mode].modetype == 2 and levelmode_data[self.mode].trialtype == 4 then
			self.zhupanel:loadTexture(var_0_30[4], var_0_1)
		end

		self.curlevel = playermodel.levelmode[self.mode].status - 1

		if self.curlevel > self.numchapter then
			self.curlevel = self.numchapter
		end

		self.times = arg_5_1.times or 0
		self.show_time = arg_5_1.show_time
		self.cleanSweepBtn = nil

		self:initCleanSweepBtn()
		self:createTicketImage()

		local var_5_0 = require("data.leveldata.level_data_" .. self.mode)

		self.ticket = var_5_0[self.mode .. "-1-1"].ticket
		self.ticketnum = var_5_0[self.mode .. "-1-1"].ticketnum
		self.is_once_fight = var_5_0[self.mode .. "-1-1"].is_once_fight

		self.kaohebtn:addTouchEventListener(function(arg_6_0, arg_6_1)
			if arg_6_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.showBuyTimeFunc and self.times <= 0 and self.btnindex ~= self.curlevel + 1 then
				self.showBuyTimeFunc()

				return
			end

			if self.is_once_fight and self.is_once_fight == 1 and self.curlevel < playermodel.levelmode[self.mode].status - 1 then
				global_ShowBlockWords(L_ADVENTURE_IS_ONCE_FIGHT)

				return
			end

			if self.mode == aiattack_manager:get_levelmode_id() then
				self:dealChangeBtn_ai()
			else
				self:dealChangeBtn()
			end
		end)
		self.rootLayer:addTouchEventListener(function(arg_7_0, arg_7_1)
			if arg_7_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_window_close_action(self.zhupanel, function()
				if self.week_callback then
					self.week_callback()
				end

				LayerManager:removePopLayer()
			end)
		end)

		if arg_5_1.showlevel then
			self.showlevel = arg_5_1.showlevel
			self.btnindex = arg_5_1.showlevel
		else
			self.btnindex = self.curlevel == 0 and 1 or not var_0_39(self.mode .. "-" .. self.curlevel) and self.curlevel - 1 or self.curlevel
		end

		print(self.btnindex, arg_5_1.showlevel)
		self:initPanelList_H1(self.numchapter)
		self:initpanel(self.btnindex)
		self:fullScreen(self.rootLayer)
		self:initArrayPanel()
		self:createBossInfoBtn()
		global_window_open_action(self.zhupanel)
	end

	self.nodeServantRank = require("view.Sprite.NodeServantRankEntrance").showInLayer(self.zhupanel, {
		mode = self.mode,
		chapter = self.btnindex,
		fightType = require("controller.servant_rank_manager").getInstance().FIGHT_TYPE.PVE
	}, cc.p(450, 210))

	self:registerScriptHandler(function(arg_9_0)
		if arg_9_0 == "exit" then
			var_0_35 = nil
		end
	end)
end

function AdventureNewDetailLayer:updateBattleFiledInfo(arg_10_1)
	for iter_10_0 = 1, 3 do
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_kao" .. iter_10_0):setVisible(false)
	end

	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2, var_10_3 = level_manager:getChapterBattleFieldInfo(arg_10_1)

	for iter_10_1, iter_10_2 in ipairs(var_10_2) do
		if var_10_3[iter_10_1] and battlefield_status_data[var_10_3[iter_10_1]] and battlefield_status_data[var_10_3[iter_10_1]].targetside and battlefield_status_data[var_10_3[iter_10_1]].targetside == 1 then
			table.insert(var_10_0, iter_10_2)
		elseif var_10_3[iter_10_1] and battlefield_status_data[var_10_3[iter_10_1]] and battlefield_status_data[var_10_3[iter_10_1]].targetside and battlefield_status_data[var_10_3[iter_10_1]].targetside == 2 then
			table.insert(var_10_1, iter_10_2)
		end
	end

	if #var_10_0 ~= 0 and #var_10_1 == 0 then
		self.citiaopanel:setVisible(true)
		self.myrule:setVisible(true)
		self.enemyrule:setVisible(false)
		self.myrule:setPosition(var_0_32[1])
		self.listview3:setContentSize(var_0_33[3])
		self.listview3:setPosition(cc.p(var_0_34[3].x, var_0_34[3].y - 5))
	elseif #var_10_0 == 0 and #var_10_1 ~= 0 then
		self.citiaopanel:setVisible(true)
		self.myrule:setVisible(false)
		self.enemyrule:setVisible(true)
		self.enemyrule:setPosition(var_0_32[1])
		self.listview4:setContentSize(var_0_33[3])
		self.listview4:setPosition(cc.p(var_0_34[3].x, var_0_34[3].y - 5))
	elseif #var_10_0 ~= 0 and #var_10_1 ~= 0 then
		self.myrule:setVisible(true)
		self.enemyrule:setVisible(true)
		self.citiaopanel:setVisible(true)
		self.myrule:setPosition(var_0_32[1])
		self.enemyrule:setPosition(var_0_32[2])
		self.listview3:setContentSize(var_0_33[1])
		self.listview4:setContentSize(var_0_33[2])
		self.listview3:setPosition(var_0_34[1])
		self.listview4:setContentSize(var_0_33[2])
	else
		self.citiaopanel:setVisible(false)
	end

	self.listview3:removeAllChildren()
	self.listview4:removeAllChildren()
	self.listview3:setItemsMargin(0)
	self.listview4:setItemsMargin(0)

	if #var_10_1 > 0 then
		for iter_10_3, iter_10_4 in ipairs(var_10_1) do
			local var_10_4 = self.items2:clone()
			local var_10_5 = ccui.Helper:seekWidgetByName(var_10_4, "Label_text1")
			local var_10_6 = ccui.Helper:seekWidgetByName(var_10_4, "Image_11")

			var_10_5:getVirtualRenderer():setMaxLineWidth(250)
			var_10_5:setColor(var_0_29.enemy)
			var_10_5:setString(iter_10_4)

			if var_10_5:getContentSize().height > 30 then
				var_10_4:setContentSize(cc.size(270, var_10_5:getContentSize().height + 1))
				var_10_5:setPosition(cc.p(12, var_10_4:getContentSize().height))
				var_10_6:setPosition(cc.p(6, var_10_4:getContentSize().height - 10))
			end

			self.listview4:pushBackCustomItem(var_10_4)
		end
	end

	if #var_10_0 > 0 then
		for iter_10_5, iter_10_6 in ipairs(var_10_0) do
			local var_10_7 = self.items2:clone()
			local var_10_8 = ccui.Helper:seekWidgetByName(var_10_7, "Label_text1")
			local var_10_9 = ccui.Helper:seekWidgetByName(var_10_7, "Image_11")

			var_10_8:getVirtualRenderer():setMaxLineWidth(250)
			var_10_8:setColor(var_0_29.myself)
			var_10_8:setString(iter_10_6)

			if var_10_8:getContentSize().height > 30 then
				var_10_7:setContentSize(cc.size(270, var_10_8:getContentSize().height + 1))
				var_10_8:setPosition(cc.p(12, var_10_7:getContentSize().height))
				var_10_9:setPosition(cc.p(6, var_10_7:getContentSize().height - 10))
			end

			self.listview3:pushBackCustomItem(var_10_7)
		end
	end
end

function AdventureNewDetailLayer.createArrayRole(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return
	end

	local var_11_0 = servant_data[arg_11_1].modelid

	if not servant_data[arg_11_1].modelid then
		return
	end

	local var_11_1 = model_data[var_11_0].portrait_image
	local var_11_2 = ccui.ImageView:create("GUI/image.png", var_0_1)

	var_11_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_11_2:setScale(60 / var_11_2:getContentSize().height)
	var_11_2:setName("girlHeadImg")
	var_11_2:loadTexture(ROLE_PORTRAIT_PATH .. var_11_1 .. ".png")

	local function var_11_3(arg_12_0)
		GuideListener.showAllGuidesWithFullScreen(false)
		array_manager:resetHangupArray(arg_12_0)
		RoleDefault:getInstance():setIntegerForKey("adventurearray", arg_12_0)
		arg_11_0:updateArrayPanel()

		if activity_manager:isLockActivityBossFight(arg_11_0.mode) then
			arg_11_0:dealChangeBtn()
		end
	end

	local function var_11_4()
		if arg_11_0.updateArrayPanel then
			arg_11_0:updateArrayPanel()
		end
	end

	var_11_2:setTouchEnabled(true)
	var_11_2:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not activity_manager:canStartFightBoss(arg_11_0.mode, arg_11_0.btnindex) then
			global_ShowBlockWords(L_ACTIVITY_BOSS_FIGHT_LOCK)

			return
		end

		local var_14_0 = {
			mode = arg_11_0.mode
		}

		var_14_0.defaultIndex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)
		var_14_0.configtype = CONFIG_TYPE_MODE
		var_14_0.exitcallback = var_11_4
		var_14_0.configcallback = var_11_3

		var_0_18:pushFormationLayer(activity_manager:isLockActivityBossFight(arg_11_0.mode) and "FormationBossfightLayer" or "FormationMaterialLayer", var_14_0)
	end)

	return var_11_2
end

function AdventureNewDetailLayer:updateArrayPanel()
	self:updateArrayData()

	if not next(self.team) then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(self.team) do
		((config._DEBUG or nil) and (cc.Scale9Sprite:create(var_0_31) or cc.Scale9Sprite:createWithSpriteFrameName(var_0_31))):setAnchorPoint(cc.p(0.5, 0.5))

		local var_15_0 = ccui.Helper:seekWidgetByName(self.roles[iter_15_0], "level")
		local var_15_1 = ccui.Helper:seekWidgetByName(self.roles[iter_15_0], "class")
		local var_15_2 = ccui.Helper:seekWidgetByName(self.roles[iter_15_0], "level_bg")
		local var_15_3 = ccui.Helper:seekWidgetByName(self.roles[iter_15_0], "add_btn")

		if self.roles[iter_15_0]:getChildByName("girlHeadImg") then
			self.roles[iter_15_0]:getChildByName("girlHeadImg"):removeFromParent()
		end

		if iter_15_1.fight_girl then
			var_15_2:setVisible(true)
			var_15_1:setVisible(true)
			var_15_3:setVisible(false)
			var_15_1:loadTexture("Array/icon_" .. global_get_model_attr(servant_data[iter_15_1.fight_girl].modelid) .. ".png", var_0_1)
			var_15_1:setScale(0.65)
			var_15_0:setString("等级" .. core_manager:getCoreLv(iter_15_1.fight_girl))

			local var_15_4 = self:createArrayRole(iter_15_1.fight_girl)

			var_15_4:setPosition(cc.p(self.roles[iter_15_0]:getContentSize().width / 2, self.roles[iter_15_0]:getContentSize().height / 2))
			self.roles[iter_15_0]:addChild(var_15_4)

			if iter_15_1.locked then
				var_15_4:setColor(cc.c3b(115, 115, 115))
			else
				var_15_4:setColor(cc.c3b(255, 255, 255))
			end

			if role_false_level_manager:isRoleFalseLevelMember(iter_15_1.fight_girl, FIGHTTYPE_ADVENTURE, self.mode) then
				local var_15_5, var_15_6, var_15_7, var_15_8 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(iter_15_1.fight_girl, FIGHTTYPE_ADVENTURE, self.mode)
				local var_15_9 = core_manager:getServantCoreRank(iter_15_1.fight_girl)

				var_15_0:setOpacity(255)
				var_15_0:stopAllActions()
				var_15_0:setColor(cc.c3b(255, 255, 255))

				if var_15_5 == var_15_9 and playermodel.cores[iter_15_1.fight_girl].level == var_15_6 then
					-- block empty
				else
					local var_15_10 = var_15_6 + var_15_8

					if var_15_6 + var_15_8 > core_manager:getCoreMaxTotalLv() then
						var_15_10 = core_manager:getCoreMaxTotalLv()
					end

					var_15_0:setColor(cc.c3b(206, 255, 167))

					local var_15_11 = true

					var_15_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(2), cc.CallFunc:create(function(...)
						if var_15_11 then
							var_15_0:setString("等级固定中")
						else
							var_15_0:setString("等级" .. var_15_10)
						end

						var_15_11 = not var_15_11
					end), cc.FadeIn:create(2))))
				end
			end
		else
			var_15_2:setVisible(false)
			var_15_1:setVisible(false)
			var_15_3:setVisible(true)
		end

		local function var_15_12(arg_17_0)
			GuideListener.showAllGuidesWithFullScreen(false)
			array_manager:resetHangupArray(arg_17_0)
			RoleDefault:getInstance():setIntegerForKey("adventurearray", arg_17_0)
			self:updateArrayPanel()

			if activity_manager:isLockActivityBossFight(self.mode) then
				self:dealChangeBtn()
			end
		end

		local function var_15_13()
			if self.updateArrayPanel then
				self:updateArrayPanel()
			end
		end

		var_15_3:addTouchEventListener(function(arg_19_0, arg_19_1)
			if arg_19_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not activity_manager:canStartFightBoss(self.mode, self.btnindex) then
				global_ShowBlockWords(L_ACTIVITY_BOSS_FIGHT_LOCK)

				return
			end

			local var_19_0 = {
				mode = self.mode
			}

			var_19_0.defaultIndex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)
			var_19_0.configtype = CONFIG_TYPE_MODE
			var_19_0.exitcallback = var_15_13
			var_19_0.configcallback = var_15_12

			var_0_18:pushFormationLayer(activity_manager:isLockActivityBossFight(self.mode) and "FormationBossfightLayer" or "FormationMaterialLayer", var_19_0)
		end)
	end

	local var_15_14 = array_manager:getBattleArrayData((RoleDefault:getInstance():getIntegerForKey("adventurearray", playermodel.curArray)))

	self.power:setString(string.format(L_AVAON_VISUAL.array_power, global_trans_number((fight_capacity_manager:getArrayFightCapacity(self.team, nil, nil, FIGHTTYPE_ADVENTURE, self.mode)))))
	self:updateArrayScore()
	self:initpanel(self.btnindex)
end

function AdventureNewDetailLayer:updateArrayScore()
	if not self.isvisual and not self.isinfinite then
		self.scores:setVisible(false)

		return
	else
		self.scores:setVisible(true)

		if self.score then
			self.scores:setString(string.format(L_AVAON_VISUAL.array_score, global_trans_number(self.score)))
		else
			self.scores:setString("")
		end
	end
end

function AdventureNewDetailLayer:initArrayPanel()
	self:updateArrayPanel()

	local function var_21_0(arg_22_0)
		GuideListener.showAllGuidesWithFullScreen(false)
		array_manager:resetHangupArray(arg_22_0)
		RoleDefault:getInstance():setIntegerForKey("adventurearray", arg_22_0)
		self:updateArrayPanel()

		if activity_manager:isLockActivityBossFight(self.mode) then
			self:dealChangeBtn()
		end
	end

	local function var_21_1()
		if self.updateArrayPanel then
			self:updateArrayPanel()
		end
	end

	self.array_edit:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not activity_manager:canStartFightBoss(self.mode, self.btnindex) then
			global_ShowBlockWords(L_ACTIVITY_BOSS_FIGHT_LOCK)

			return
		end

		local var_24_0 = {
			mode = self.mode
		}

		var_24_0.defaultIndex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)
		var_24_0.configtype = CONFIG_TYPE_MODE
		var_24_0.exitcallback = var_21_1
		var_24_0.configcallback = var_21_0

		var_0_18:pushFormationLayer(activity_manager:isLockActivityBossFight(self.mode) and "FormationBossfightLayer" or "FormationMaterialLayer", var_24_0)
	end)
end

function AdventureNewDetailLayer:updateArrayData()
	self.team = activity_manager:isLockActivityBossFight(self.mode) and activity_manager:getActivityBossFightFormation(self.mode, self.btnindex) or require("controller.formation.formation_mode_manager"):getInstance():getFormationInfo()[1]
end

function AdventureNewDetailLayer:createTicketImage()
	if self.imagecishu:getChildByName("weekend_ticket") then
		self.imagecishu:getChildByName("weekend_ticket"):removeFromParent()
	end

	if not self.ticket_item then
		return
	end

	self.imagecishu:setOpacity(0)

	if self.times and self.times <= 0 and self.ticke_tnum > 0 then
		local var_26_0 = ccui.ImageView:create(ICON_PATH[self.mode], var_0_1)

		var_26_0:setPosition(cc.p(self.imagecishu:getContentSize().width / 2 - 30, self.imagecishu:getContentSize().height / 2))
		var_26_0:setName("weekend_ticket")
		self.imagecishu:addChild(var_26_0)
		self.imagecishu:setOpacity(0)
		self.imagecishu:setCascadeOpacityEnabled(false)
		ccui.Helper:seekWidgetByName(self.imagecishu, "Label_24"):setOpacity(0)

		local var_26_1 = cc.Label:createWithTTF("x" .. self.ticke_tnum, "fonts/number.ttf", 20)

		var_26_1:setAnchorPoint(cc.p(0, 0.5))
		var_26_1:setScale(1 / var_26_0:getScale())
		var_26_1:setPosition(cc.p(var_26_0:getContentSize().width / 2 + 33, var_26_0:getContentSize().height / 2))
		var_26_0:addChild(var_26_1)
	else
		self.imagecishu:setOpacity(255)
		ccui.Helper:seekWidgetByName(self.imagecishu, "Label_24"):setOpacity(255)
	end
end

function AdventureNewDetailLayer:dealChangeBtn(arg_27_1)
	if self.ticket and item_manager:getItemNumber(self.ticket) < self.ticketnum then
		global_ShowBlockWords("门票不足")

		return
	end

	local var_27_0 = self.mode
	local var_27_1 = self.btnindex
	local var_27_2, var_27_3 = level_manager:isModeValid(self.mode)

	if not var_27_2 then
		audio_manager:playeffectMusicTest("sound/invalid")
		global_ShowBlockWords(level_manager:getModeUnlockMsg(var_27_0, var_27_3))

		return
	end

	local function var_27_4(arg_28_0)
		if arg_28_0 == 1 then
			FightManager.refreshFightToType(FIGHTTYPE_ADVENTURE)
			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})
			self:exit()

			if self.msg.data.modetype == 2 then
				AnalyticManager.adver_wuzi_enter({
					wuzi_level = var_27_1
				})
			end

			if self.msg.data.modetype == 3 then
				AnalyticManager.adver_yuansu_enter_kaohe({
					yuansu_catage = self.msg.data.mode,
					yuansu_level = var_27_1
				})
			end

			if self.msg.data.modetype == 4 then
				AnalyticManager.adver_zhiye_enter({
					zhiye_catage = self.msg.data.mode,
					zhiye_level = var_27_1
				})
			end
		else
			if arg_28_0 == 2 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[2])
			elseif arg_28_0 == 3 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[3])
			elseif arg_28_0 == 4 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[4])
			elseif arg_28_0 == 5 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[5])
			end

			GuideListener.showAllGuidesWithFullScreen(true)
		end
	end

	local var_27_5 = RoleDefault:getInstance():getIntegerForKey("adventurearray", playermodel.curArray)

	GuideListener.showAllGuidesWithFullScreen(false)
	array_manager:resetHangupArray(var_27_5)
	RoleDefault:getInstance():setIntegerForKey("adventurearray", var_27_5)
	RoleDefault:getInstance():setIntegerForKey("lastadventurearray", var_27_5)
	array_manager:executeHangupArrayChange()

	if activity_manager:isLockActivityBossFight(var_27_0) then
		if not self:checkBossfightTeamIsvalid() then
			global_ShowBlockWords(L_ACTIVITY_BOSS_FIGHT_FO)
		elseif activity_manager:canStartFightBoss(var_27_0, self.btnindex) then
			level_manager:switchToAdventureMode(var_27_0, self.btnindex, var_27_4, var_27_5)
		else
			global_ShowBlockWords(L_ACTIVITY_BOSS_FIGHT_LOCK)
		end
	elseif self:checkTheTeamIsvalid() and self:checkIstempTeam() then
		level_manager:switchToAdventureMode(var_27_0, self.btnindex, var_27_4, var_27_5)
	end
end

function AdventureNewDetailLayer:checkBossfightTeamIsvalid()
	for iter_29_0 = 1, 5 do
		if self.team[iter_29_0] and self.team[iter_29_0].fight_girl then
			return true
		end
	end

	return false
end

function AdventureNewDetailLayer:checkTheTeamIsvalid()
	local var_30_0 = RoleDefault:getInstance():getIntegerForKey("adventurearray", playermodel.curArray)

	return array_manager:checkIsSameColorTeam(1, self.mode)
end

function AdventureNewDetailLayer:dealChangeBtn_ai()
	local var_31_0 = self.btnindex
	local var_31_1, var_31_2 = level_manager:isModeValid(self.mode)

	if not var_31_1 then
		audio_manager:playeffectMusicTest("sound/invalid")
		global_ShowBlockWords(level_manager:getModeUnlockMsg(self.mode, var_31_2))

		return
	end

	aiattack_manager:switchToAiAttack(self.mode, self.btnindex, function(arg_32_0)
		if arg_32_0 == 1 then
			FightManager.refreshFightToType(FIGHTTYPE_AIATTACK)
			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})

			if self.msg.data.modetype == 2 then
				AnalyticManager.adver_wuzi_enter({
					wuzi_level = var_31_0
				})
			end

			if self.msg.data.modetype == 3 then
				AnalyticManager.adver_yuansu_enter_kaohe({
					yuansu_catage = self.msg.data.mode,
					yuansu_level = var_31_0
				})
			end

			if self.msg.data.modetype == 4 then
				AnalyticManager.adver_zhiye_enter({
					zhiye_catage = self.msg.data.mode,
					zhiye_level = var_31_0
				})
			end
		else
			if arg_32_0 == 2 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[2])
			elseif arg_32_0 == 3 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[3])
			elseif arg_32_0 == 4 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[4])
			elseif arg_32_0 == 5 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[5])
			end

			GuideListener.showAllGuidesWithFullScreen(true)
		end
	end)
end

function AdventureNewDetailLayer:initpanel(arg_33_1)
	local var_33_0 = self.mode .. "-" .. arg_33_1

	self.zhanli:setString(L_FIGHT_CAPACITY_MSG.Recommend_Capacity .. global_trans_number(chapter_data[self.mode .. "-" .. arg_33_1].combat_limit or 0))

	if self.score then
		local var_33_1 = chapter_data[var_33_0].passscore or 0

		self.titlescore:setString("" .. global_trans_number(var_33_1))

		if arg_33_1 == self.numchapter and not self.issummeradverture then
			self.titlescore:setString("" .. global_trans_number(var_33_1) .. "(~)")
		end
	else
		self.titlescore:setString("")
	end

	local var_33_2 = monster_manager.getLevelBoss(self.mode, arg_33_1 .. "-1").majorlist.modelid

	self.bossinfomode = var_33_2

	self.bossimg:loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[var_33_2].cute_role .. ".png")
	self.bossimg:setScale(0.55)
	self.bossimg:setPosition(cc.p(102, 398))

	if not self.isvisual then
		self.citiaopanel:setVisible(false)

		local var_33_3 = level_manager:getChapterBattleFieldInfo(var_33_0)

		for iter_33_0 = 1, 3 do
			if var_33_3[iter_33_0] then
				ccui.Helper:seekWidgetByName(self.rootLayer, "Image_kao" .. iter_33_0):setVisible(true)
				ccui.Helper:seekWidgetByName(self.rootLayer, "Label_text" .. iter_33_0):setString(var_33_3[iter_33_0])
			else
				ccui.Helper:seekWidgetByName(self.rootLayer, "Image_kao" .. iter_33_0):setVisible(false)
			end
		end
	else
		self:updateBattleFiledInfo(var_33_0)
	end

	if not self.issummeradverture then
		local function var_33_4(arg_34_0)
			self:initPanelList_H2(self:DealDataForamte(arg_34_0), arg_33_1)
		end

		if self.mode == aiattack_manager:get_levelmode_id() then
			aiattack_manager:getAdventureDropInfo(self.mode, arg_33_1 .. "-1", var_33_4)
		else
			level_manager:getAdventureDropInfo(self.mode, arg_33_1 .. "-1", var_33_4)
		end
	end

	if self.mode == aiattack_manager:get_levelmode_id() then
		local var_33_5 = cc.Label:createWithTTF("通关后阵亡AI将不再返还", FONT_DES, 22)

		var_33_5:setPosition(420, 200)
		var_33_5:setColor(cc.c3b(253, 151, 32))
		self.zhupanel:addChild(var_33_5)

		if levelmode_data[self.mode].endtime then
			local var_33_6 = time_check_manager:getCurTime()
			local var_33_7 = os.time(parse_time(levelmode_data[self.mode].endtime))
			local var_33_8 = cc.Label:createWithTTF("据活动截止还剩:" .. (var_0_38((var_33_7 - var_33_6 > 0 or nil) and (var_33_7 - var_33_6 or 0)) or "00:00:00"), FONT_DES, 22)

			var_33_8:setColor(cc.c3b(253, 151, 32))
			var_33_8:setPosition(414, 240)
			self.zhupanel:addChild(var_33_8)
		end
	end
end

function AdventureNewDetailLayer.DealDataForamte(arg_35_0, arg_35_1)
	if not arg_35_1 then
		return
	end

	local var_35_0 = {
		gold = 0,
		diamond = 0,
		items = {}
	}

	for iter_35_0, iter_35_1 in ipairs(arg_35_1) do
		if iter_35_1.itemid == 1 and iter_35_1.count > 0 then
			var_35_0.gold = var_35_0.gold + iter_35_1.count
		elseif iter_35_1.itemid == 0 and iter_35_1.count > 0 then
			var_35_0.diamond = var_35_0.diamond + iter_35_1.count
		else
			table.insert(var_35_0.items, {
				itemid = iter_35_1.itemid,
				num = iter_35_1.count,
				rate = tonumber(iter_35_1.rate),
				is_random = iter_35_1.is_random
			})
		end
	end

	return var_35_0
end

function AdventureNewDetailLayer:updateButtomBtn(arg_36_1)
	if self.curlevel == 0 then
		if self.show_time and arg_36_1 == self.curlevel + 1 then
			self.kaohebtn:setVisible(true)
			self.imagecishu:setVisible(true)
			ccui.Helper:seekWidgetByName(self.imagecishu, "Label_24"):setString(L_ACTIVITY_ADV_1)
			self.imagecishu:loadTexture("adventurenewlayer/touming.png", var_0_1)
			self.imagenoopen:setVisible(false)
			self.buybtn:setVisible(false)
		elseif arg_36_1 == 1 and self.times and self.times > 0 then
			self.kaohebtn:setVisible(true)
			self.imagecishu:setVisible(true)
			self.imagecishu:loadTexture("adventurenewlayer/shengyucishu.png", var_0_1)
			ccui.Helper:seekWidgetByName(self.imagecishu, "Label_24"):setString(tostring(self.times))
			self.imagenoopen:setVisible(false)
			self.buybtn:setVisible(false)
		else
			self.kaohebtn:setVisible(false)
			self.imagecishu:setVisible(false)
			self.imagenoopen:setVisible(true)
			self.buybtn:setVisible(false)
			self.imagecishu:loadTexture("adventurenewlayer/shengyucishu.png", var_0_1)

			if self.ticket_item then
				self.kaohebtn:setVisible(true)
				self.imagecishu:setVisible(true)
				ccui.Helper:seekWidgetByName(self.imagecishu, "Label_24"):setString(tostring(0))
				self.imagenoopen:setVisible(false)
			end
		end
	elseif arg_36_1 <= self.curlevel + 1 then
		if self.show_time and arg_36_1 == self.curlevel + 1 then
			self.kaohebtn:setVisible(true)
			self.imagecishu:setVisible(true)
			ccui.Helper:seekWidgetByName(self.imagecishu, "Label_24"):setString(L_ACTIVITY_ADV_1)
			self.imagecishu:loadTexture("adventurenewlayer/touming.png", var_0_1)
			self.imagenoopen:setVisible(false)
			self.buybtn:setVisible(false)
		elseif self.times and self.times > 0 then
			self.kaohebtn:setVisible(true)
			self.imagecishu:setVisible(true)
			self.imagecishu:loadTexture("adventurenewlayer/shengyucishu.png", var_0_1)
			ccui.Helper:seekWidgetByName(self.imagecishu, "Label_24"):setString(tostring(self.times))
			self.imagenoopen:setVisible(false)
			self.buybtn:setVisible(false)
		else
			self.kaohebtn:setVisible(true)
			self.imagecishu:setVisible(true)
			self.imagecishu:loadTexture("adventurenewlayer/shengyucishu.png", var_0_1)
			ccui.Helper:seekWidgetByName(self.imagecishu, "Label_24"):setString(tostring(self.times))
			self.imagenoopen:setVisible(false)
			self.buybtn:setVisible(false)
		end
	else
		self.kaohebtn:setVisible(false)
		self.imagecishu:setVisible(false)
		self.imagenoopen:setVisible(true)
		self.buybtn:setVisible(false)
	end

	local var_36_0 = self.mode .. "-" .. arg_36_1 .. "-1"
	local var_36_1 = require("data.leveldata.level_data_" .. self.mode)

	self.ticket = var_36_1[self.mode .. "-" .. arg_36_1 .. "-1"].ticket
	self.ticketnum = var_36_1[var_36_0].ticketnum
	self.is_once_fight = var_36_1[var_36_0].is_once_fight

	if self.ticket then
		self.ticketPanel:getChildByName("Image_ticket"):loadTexture("equipment/" .. item_data[self.ticket].image_id .. ".png")
		self.ticketPanel:getChildByName("Label_ticketnum"):setString("X" .. self.ticketnum)

		if item_manager:getItemNumber(self.ticket) < self.ticketnum then
			self.ticketPanel:getChildByName("Label_ticketnum"):setColor(cc.c3b(255, 0, 0))
		else
			self.ticketPanel:getChildByName("Label_ticketnum"):setColor(cc.c3b(255, 255, 255))
		end

		self.imagecishu:setVisible(false)
		self.ticketPanel:setVisible(true)

		if self.curlevel == 0 then
			if arg_36_1 == 1 then
				self.kaohebtn:setVisible(true)
				self.imagenoopen:setVisible(false)
				self.buybtn:setVisible(false)
			else
				self.kaohebtn:setVisible(false)
				self.imagenoopen:setVisible(true)
				self.buybtn:setVisible(false)
				self.ticketPanel:setVisible(false)
			end
		elseif arg_36_1 <= self.curlevel + 1 then
			self.kaohebtn:setVisible(true)
			self.imagecishu:setVisible(false)
			ccui.Helper:seekWidgetByName(self.imagecishu, "Label_24"):setString(tostring(self.times))
			self.imagenoopen:setVisible(false)
			self.buybtn:setVisible(false)
		else
			self.kaohebtn:setVisible(false)
			self.imagecishu:setVisible(false)
			self.imagenoopen:setVisible(true)
			self.buybtn:setVisible(false)
			self.ticketPanel:setVisible(false)
		end
	else
		self.ticketPanel:setVisible(false)
	end

	local var_36_2 = playermodel.levelmode[self.mode].status
	local var_36_3 = self.imagecishu:getChildByName("name_tips")

	if not var_36_3 then
		var_36_3 = cc.Label:createWithTTF(L_SPECIAL_WEEKENDADVENTURELAYER.tips, "fonts/name.ttf", 18)

		var_36_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_36_3:setPosition(cc.p(self.imagecishu:getContentSize().width / 2, self.imagecishu:getContentSize().height / 2 - 40))
		var_36_3:setName("name_tips")
		var_36_3:setVisible(false)
		self.imagecishu:addChild(var_36_3)
	end

	if var_36_2 == arg_36_1 then
		var_36_3:setVisible(true)
	else
		var_36_3:setVisible(false)
	end

	if self.isvisual then
		if self.curlevel == 0 then
			if arg_36_1 == 1 then
				self.kaohebtn:setVisible(true)
				self.imagecishu:setVisible(false)
				ccui.Helper:seekWidgetByName(self.imagecishu, "Label_24"):setString("")
				self.imagenoopen:setVisible(false)
				self.buybtn:setVisible(false)
			else
				self.kaohebtn:setVisible(false)
				self.imagecishu:setVisible(false)
				self.imagenoopen:setVisible(true)
				self.buybtn:setVisible(false)
			end
		elseif arg_36_1 <= self.curlevel + 1 then
			if self.times > 0 then
				self.kaohebtn:setVisible(true)
				self.imagecishu:setVisible(false)
				ccui.Helper:seekWidgetByName(self.imagecishu, "Label_24"):setString("")
				self.imagenoopen:setVisible(false)
				self.buybtn:setVisible(false)
			end
		else
			self.kaohebtn:setVisible(false)
			self.imagecishu:setVisible(false)
			self.imagenoopen:setVisible(true)
			self.buybtn:setVisible(false)
		end

		self.imagecishu:setVisible(false)
	end

	if self.issummeradverture and self.iscanrepeatchange and arg_36_1 <= self.curlevel then
		self.kaohebtn:setVisible(false)
	end

	self:updateCleanSweepBtn(arg_36_1)
	self:updateActivityDailySweepBtn(arg_36_1)
end

function AdventureNewDetailLayer:updateTopBtn()
	for iter_37_0, iter_37_1 in pairs(self.topbtns) do
		if iter_37_1.index ~= self.btnindex then
			iter_37_1:getChildByName("Button_18"):setBright(true)
		else
			iter_37_1:getChildByName("Button_18"):setBright(false)
		end
	end
end

function AdventureNewDetailLayer:initPanelList_H1(arg_38_1)
	if not arg_38_1 then
		return
	end

	self.topbtns = {}

	self.ListView_top:setItemsMargin(0)

	for iter_38_0 = 1, arg_38_1 do
		local var_38_0 = self.mode .. "-" .. iter_38_0
		local var_38_1

		if iter_38_0 <= self.curlevel + 1 then
			var_38_1 = self.topitem:clone()

			local var_38_2 = ccui.Helper:seekWidgetByName(var_38_1, "Label_20")

			var_38_1.index = iter_38_0
			var_38_1:getChildByName("Button_18").index = iter_38_0

			if self.advenName then
				if self.advenName == "bianhua" then
					var_38_2:setString(L_ADVANTURE .. iter_38_0)
				end
			else
				var_38_2:setString(L_ADVENTURE_EXAMINE .. iter_38_0)
			end
		else
			var_38_1 = self.noitem:clone()

			var_38_1:getChildByName("Button_18"):loadTextures("adventurenewlayer/weijiesuo.png", nil, "adventurenewlayer/kaohe1.png", var_0_1)

			local var_38_3 = ccui.Helper:seekWidgetByName(var_38_1, "Label_20")

			var_38_1.index = iter_38_0
			var_38_1:getChildByName("Button_18").index = iter_38_0

			if self.advenName then
				if self.advenName == "bianhua" then
					var_38_3:setString(L_ADVANTURE .. iter_38_0)
				end
			else
				var_38_3:setString(L_ADVENTURE_EXAMINE .. iter_38_0)
			end
		end

		var_38_1:getChildByName("Button_18"):addTouchEventListener(function(arg_39_0, arg_39_1)
			if arg_39_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.btnindex = arg_39_0.index

			self:updateTopBtn()
			self:initpanel(iter_38_0)
			self:updateButtomBtn(arg_39_0.index)
			self:updateArrayPanel()
			self.nodeServantRank:updateData({
				chapter = self.btnindex
			})
		end)
		var_38_1:setVisible(var_0_39(var_38_0))
		table.insert(self.topbtns, var_38_1)
		self.ListView_top:pushBackCustomItem(var_38_1)
	end

	local function var_38_4(arg_40_0)
		local var_40_0 = self.ListView_top:getInnerContainer()

		var_40_0:setPositionX(var_40_0:getPositionX() - arg_40_0 - 10)
	end

	local var_38_5 = 120

	self:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
		if self.curlevel > 1 then
			var_38_4(((self.showlevel or self.curlevel) - 1) * var_38_5)
		end
	end)))
	self:updateTopBtn()
	self:updateButtomBtn(self.btnindex)
end

function AdventureNewDetailLayer:createUpIcon(arg_42_1)
	local activity_return_manager = require("controller.activity_return_manager")

	if activity_return_manager:is_have_catchup_buff(activity_return_manager.BUFF_TYPES.BUFF_TYPE_ADVENTURE_DROP) then
		local var_42_1 = ccui.ImageView:create("public/panelbg/img_getup.png", var_0_1)

		var_42_1:setName("imgCatchUp")
		arg_42_1:addChild(var_42_1, 5)
		var_42_1:setPosition(arg_42_1:getContentSize().width - 30, 75)
		var_42_1:setVisible(levelmode_data[self.mode].modetype == 2 or levelmode_data[self.mode].modetype == 1031)
	end
end

function AdventureNewDetailLayer:initPanelList_H2(arg_43_1, arg_43_2)
	self.ListView_buttom:removeAllChildren()
	self.ListView_buttom:setItemsMargin(0)

	self.awardalls = {}
	self.dropData = arg_43_1

	local var_43_0 = arg_43_1 or self.dropData

	if (arg_43_1 or self.dropData).gold > 0 then
		local var_43_1 = self.buttonitem:clone()
		local var_43_2 = ItemSprite:createNewWithItemId("gold", var_43_0.gold)

		var_43_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_43_2:setPosition(cc.p(var_43_1:getContentSize().width * 0.5, var_43_1:getContentSize().height * 0.5))
		var_43_2:setScale(0.6)
		var_43_1:addChild(var_43_2)
		self:createUpIcon(var_43_2)
		self.ListView_buttom:pushBackCustomItem(var_43_1)
		table.insert(self.awardalls, var_43_1)
	end

	if var_43_0.diamond > 0 then
		local var_43_3 = self.buttonitem:clone()
		local var_43_4 = ItemSprite:createNewWithItemId("diamond", var_43_0.diamond)

		var_43_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_43_4:setPosition(cc.p(var_43_3:getContentSize().width * 0.5, var_43_3:getContentSize().height * 0.5))
		var_43_4:setScale(0.6)
		var_43_3:addChild(var_43_4)
		self:createUpIcon(var_43_4)
		self.ListView_buttom:pushBackCustomItem(var_43_3)
		table.insert(self.awardalls, var_43_3)
	end

	for iter_43_0 = 1, #var_43_0.items do
		local var_43_5 = self.buttonitem:clone()
		local var_43_6 = ItemSprite:createNewWithItemId(var_43_0.items[iter_43_0].itemid, var_43_0.items[iter_43_0].num)

		var_43_6:setAnchorPoint(cc.p(0.5, 0.5))
		var_43_6:setScale(0.6)
		var_43_6:setPosition(cc.p(var_43_5:getContentSize().width * 0.5, var_43_5:getContentSize().height * 0.5))
		var_43_5:addChild(var_43_6)

		var_43_5.item_type = "item"

		self:createUpIcon(var_43_6)

		if var_43_0.items[iter_43_0].rate and var_43_0.items[iter_43_0].rate ~= 1 then
			local var_43_7 = ccui.ImageView:create("public/box/wordBg.png", var_0_1)

			var_43_7:setPositionX(var_43_5:getContentSize().width - var_43_7:getContentSize().width / 2 - 7)
			var_43_7:setPositionY(var_43_5:getContentSize().height - var_43_7:getContentSize().height / 2 - 5)
			var_43_5:addChild(var_43_7)

			local var_43_8 = cc.Label:createWithTTF(var_43_0.items[iter_43_0].rate * 100 .. "%", FONT_DES, 18)

			var_43_8:setPositionX(var_43_7:getContentSize().width / 2)
			var_43_8:setPositionY(var_43_7:getContentSize().height / 2)
			var_43_7:addChild(var_43_8)
		end

		if var_43_0.items[iter_43_0].is_random then
			local var_43_9 = ccui.ImageView:create("public/panelbg/act_random.png", var_0_1)

			var_43_9:setScale(0.5)
			var_43_9:setPositionX(var_43_5:getContentSize().width - var_43_9:getContentSize().width / 2 + 45)
			var_43_9:setPositionY(var_43_5:getContentSize().height - var_43_9:getContentSize().height / 2 + 18)
			var_43_5:addChild(var_43_9)
		end

		var_43_5:addTouchEventListener(function(arg_44_0, arg_44_1)
			if arg_44_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:showDetailsofItems(var_43_0.items[iter_43_0].itemid, var_43_5.item_type)
		end)
		self.ListView_buttom:pushBackCustomItem(var_43_5)
		table.insert(self.awardalls, var_43_5)
	end

	if self.isvisual and self.isrepeat and next(self.awardalls) and self.curlevel ~= 0 and arg_43_2 <= self.curlevel then
		for iter_43_1, iter_43_2 in ipairs(self.awardalls) do
			local var_43_10 = ccui.Layout:create()

			var_43_10:setContentSize(cc.size(iter_43_2:getContentSize().width - 16, iter_43_2:getContentSize().height - 16))
			var_43_10:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
			var_43_10:setCascadeOpacityEnabled(false)
			var_43_10:setBackGroundColorOpacity(190)
			var_43_10:setAnchorPoint(0.5, 0.5)
			var_43_10:setPosition(cc.p(iter_43_2:getContentSize().width / 2, iter_43_2:getContentSize().height / 2))
			var_43_10:setBackGroundColor(cc.c3b(0, 0, 0))
			var_43_10:setTouchEnabled(false)
			var_43_10:setName("sucess_award")
			iter_43_2:addChild(var_43_10, 1000)

			local var_43_11 = ccui.ImageView:create("public/panelbg/fragment_tic_new.png", var_0_1)

			var_43_11:setScale(0.6)
			var_43_11:setAnchorPoint(cc.p(0.5, 0.5))
			var_43_11:setName("sucess_img")
			var_43_11:setPosition(cc.p(var_43_10:getContentSize().width / 2 + 22, var_43_10:getContentSize().height - 114))
			var_43_10:addChild(var_43_11)
		end
	end

	local var_43_12 = activity_manager:getActivityLevelDrop(self.activityId, self.mode)

	if var_43_12 and var_43_12.num > 0 then
		local var_43_13 = self.buttonitem:clone()
		local var_43_14 = ItemSprite:createNewWithItemId(var_43_12.itemid, var_43_12.num)

		var_43_14:setAnchorPoint(cc.p(0.5, 0.5))
		var_43_14:setScale(0.6)
		var_43_14:setPosition(cc.p(var_43_13:getContentSize().width * 0.5, var_43_13:getContentSize().height * 0.5))
		var_43_13:addChild(var_43_14)

		var_43_13.item_type = "item"

		local var_43_15 = ccui.ImageView:create("public/panelbg/act_add.png", var_0_1)

		var_43_15:setScale(0.5)
		var_43_15:setPositionX(var_43_13:getContentSize().width - var_43_15:getContentSize().width / 2 + 45)
		var_43_15:setPositionY(var_43_13:getContentSize().height - var_43_15:getContentSize().height / 2 + 18)
		var_43_13:addChild(var_43_15)
		var_43_13:addTouchEventListener(function(arg_45_0, arg_45_1)
			if arg_45_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:showDetailsofItems(var_43_12.itemid)
		end)
		self.ListView_buttom:pushBackCustomItem(var_43_13)
	end
end

function AdventureNewDetailLayer:showDetailsofItems(arg_46_1, arg_46_2)
	local function var_46_1()
		self.rootLayer:setVisible(true)
	end

	if arg_46_2 == "item" then
		if item_data[arg_46_1].bag_item_type == kITEM_HORCRUX then
			local var_46_2 = -1
			local horcrux_data = require("data.horcrux_data")

			for iter_46_0, iter_46_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if iter_46_1.model_id == horcrux_data[arg_46_1].model then
					var_46_2 = iter_46_0

					break
				end
			end

			if var_46_2 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_46_2,
				itemid = arg_46_1,
				callback = var_46_1
			})
			self.rootLayer:setVisible(false)
		elseif item_data[arg_46_1].bag_item_type == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = item_data[arg_46_1].servant,
				exitCallback = var_46_1
			})
			self.rootLayer:setVisible(false)
		elseif not self:getChildByName("OTHER_LAYER") then
			local var_46_4 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_46_1
			})
		end
	elseif arg_46_2 == "gold" then
		-- block empty
	elseif arg_46_2 == "diamond" then
		-- block empty
	end
end

function AdventureNewDetailLayer.getDropData(arg_48_0, arg_48_1)
	local var_48_0 = {
		gold = 0,
		diamond = 0,
		items = {}
	}
	local var_48_1 = drop_data[arg_48_1] or {}

	if var_48_1.gold then
		var_48_0.gold = var_48_0.gold + var_48_1.gold
	end

	if var_48_1.diamond then
		var_48_0.diamond = var_48_0.diamond + var_48_1.diamond
	end

	local var_48_2 = 1

	if var_48_1["drop_id" .. 1] then
		local var_48_3 = 1

		while var_48_1["drop_id" .. var_48_3] do
			var_48_0.items[var_48_2] = {
				itemid = var_48_1["drop_id" .. var_48_3],
				num = var_48_1["drop_num" .. var_48_3],
				rate = var_48_1["drop_rate" .. var_48_3]
			}
			var_48_3 = var_48_3 + 1
			var_48_2 = var_48_2 + 1
		end
	end

	if var_48_1["dropmodel_id" .. 1] then
		local var_48_4 = 1

		while var_48_1["dropmodel_id" .. var_48_4] do
			if drop_data[var_48_1["dropmodel_id" .. var_48_4]].gold then
				var_48_0.gold = var_48_0.gold + drop_data[var_48_1["dropmodel_id" .. var_48_4]].gold
			end

			if drop_data[var_48_1["dropmodel_id" .. var_48_4]].diamond then
				var_48_0.diamond = var_48_0.diamond + drop_data[var_48_1["dropmodel_id" .. var_48_4]].diamond
			end

			if drop_data[var_48_1["dropmodel_id" .. var_48_4]]["drop_id" .. 1] then
				local var_48_5 = 1

				while drop_data[var_48_1["dropmodel_id" .. var_48_4]]["drop_id" .. var_48_5] do
					var_48_0.items[var_48_2] = {
						itemid = drop_data[var_48_1["dropmodel_id" .. var_48_4]]["drop_id" .. var_48_5],
						num = drop_data[var_48_1["dropmodel_id" .. var_48_4]]["drop_num" .. var_48_5]
					}
					var_48_5 = var_48_5 + 1
					var_48_2 = var_48_2 + 1
				end
			end

			if drop_data[var_48_1["dropmodel_id" .. var_48_4]]["rd_drop_id" .. 1] then
				local var_48_6 = 1

				while drop_data[var_48_1["dropmodel_id" .. var_48_4]]["rd_drop_id" .. var_48_6] do
					var_48_0.items[var_48_2] = {
						itemid = drop_data[var_48_1["dropmodel_id" .. var_48_4]]["rd_drop_id" .. var_48_6],
						num = drop_data[var_48_1["dropmodel_id" .. var_48_4]]["rd_drop_num" .. var_48_6]
					}
					var_48_6 = var_48_6 + 1
					var_48_2 = var_48_2 + 1
				end
			end

			var_48_4 = var_48_4 + 1
		end
	end

	if var_48_1["rd_drop_id" .. 1] then
		local var_48_7 = 1

		while var_48_1["rd_drop_id" .. var_48_7] do
			var_48_0.items[var_48_2] = {
				itemid = var_48_1["rd_drop_id" .. var_48_7],
				num = var_48_1["rd_drop_num" .. var_48_7]
			}
			var_48_7 = var_48_7 + 1
			var_48_2 = var_48_2 + 1
		end
	end

	if var_48_1["rd_dropmodel_id" .. 1] then
		local var_48_8 = 1

		while var_48_1["rd_dropmodel_id" .. var_48_8] do
			if drop_data[var_48_1["rd_dropmodel_id" .. var_48_8]].gold then
				var_48_0.gold = var_48_0.gold + drop_data[var_48_1["rd_dropmodel_id" .. var_48_8]].gold
			end

			if drop_data[var_48_1["rd_dropmodel_id" .. var_48_8]].diamond then
				var_48_0.diamond = var_48_0.diamond + drop_data[var_48_1["rd_dropmodel_id" .. var_48_8]].diamond
			end

			if drop_data[var_48_1["rd_dropmodel_id" .. var_48_8]]["drop_id" .. 1] then
				local var_48_9 = 1

				while drop_data[var_48_1["rd_dropmodel_id" .. var_48_8]]["drop_id" .. var_48_9] do
					var_48_0.items[var_48_2] = {
						itemid = drop_data[var_48_1["rd_dropmodel_id" .. var_48_8]]["drop_id" .. var_48_9],
						num = drop_data[var_48_1["rd_dropmodel_id" .. var_48_8]]["drop_num" .. var_48_9]
					}
					var_48_9 = var_48_9 + 1
					var_48_2 = var_48_2 + 1
				end
			end

			if drop_data[var_48_1["rd_dropmodel_id" .. var_48_8]]["rd_drop_id" .. 1] then
				local var_48_10 = 1

				while drop_data[var_48_1["rd_dropmodel_id" .. var_48_8]]["rd_drop_id" .. var_48_10] do
					var_48_0.items[var_48_2] = {
						itemid = drop_data[var_48_1["rd_dropmodel_id" .. var_48_8]]["rd_drop_id" .. var_48_10],
						num = drop_data[var_48_1["rd_dropmodel_id" .. var_48_8]]["rd_drop_num" .. var_48_10]
					}
					var_48_10 = var_48_10 + 1
					var_48_2 = var_48_2 + 1
				end
			end

			var_48_8 = var_48_8 + 1
		end
	end

	return var_48_0
end

function AdventureNewDetailLayer:createBossInfoBtn()
	local var_49_0 = ccui.Button:create("adventurenewlayer/btn_more.png", nil, "adventurenewlayer/btn_more.png", var_0_1)

	var_49_0:setPosition(cc.p(self.zhupanel:getContentSize().width / 2 - 170, self.zhupanel:getContentSize().height / 2 - 40))
	self.zhupanel:addChild(var_49_0, 100)

	local var_49_3 = {
		id = model_data[self.bossinfomode].photofile_model,
		modelid = self.bossinfomode,
		contentType = {
			contentType = var_0_36[model_data[self.bossinfomode].photofile_type]
		}
	}

	var_49_0:addTouchEventListener(function(arg_50_0, arg_50_1)
		if arg_50_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_49_3.modelid = self.bossinfomode
		var_49_3.contentType = {
			contentType = var_0_36[model_data[self.bossinfomode].photofile_type]
		}
		var_49_3.id = model_data[self.bossinfomode].photofile_model

		if var_0_36[model_data[self.bossinfomode].photofile_type] == "file_player" or var_0_36[model_data[self.bossinfomode].photofile_type] == "file_enemy1" or var_0_36[model_data[self.bossinfomode].photofile_type] == "file_enemy6" or var_0_36[model_data[self.bossinfomode].photofile_type] == "file_enemy8" or var_0_36[model_data[self.bossinfomode].photofile_type] == "file_enemy10" or var_0_36[model_data[self.bossinfomode].photofile_type] == "file_enemy12" or var_0_36[model_data[self.bossinfomode].photofile_type] == "file_teacher" or var_0_36[model_data[self.bossinfomode].photofile_type] == "file_nightmare_xmasfile" then
			LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_49_3)
		else
			LayerManager:pushInLayer("PhotoFileHelpGirlLayer", var_49_3)
		end
	end)
end

function AdventureNewDetailLayer:fullScreen(arg_51_1)
	arg_51_1:setContentSize((GameDisplay.getScreenSize()))
	arg_51_1:setPositionY(arg_51_1:getPositionY() - GameDisplay.fix_y)
	self.zhupanel:setPositionY(self.zhupanel:getPositionY() + GameDisplay.fix_y)
end

function AdventureNewDetailLayer.initBg(arg_52_0, arg_52_1)
	require("controller.formation.formation_mode_manager"):getInstance():requestInfo(arg_52_1.data.mode, RoleDefault:getInstance():getIntegerForKey("adventurearray", playermodel.curArray), function(arg_53_0)
		if arg_53_0.result == 1 then
			local var_53_0 = ccui.Layout:create()

			var_53_0:setTouchEnabled(true)
			var_53_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
			var_53_0:setAnchorPoint(cc.p(0, 0))
			var_53_0:setPosition(cc.p(0, -GameDisplay.fix_y))
			var_53_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
			var_53_0:setBackGroundColor(cc.c3b(2, 5, 24))
			var_53_0:setOpacity(0)
			var_53_0:setCascadeOpacityEnabled(false)
			arg_52_0:addChild(var_53_0, -1)

			local var_53_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

			var_53_1:setAnchorPoint(cc.p(0.5, 0.5))
			var_53_1:setPositionX(var_53_0:getContentSize().width / 2)
			var_53_1:setPositionY(var_53_0:getContentSize().height / 2)
			var_53_0:addChild(var_53_1)
			require("controller.l2utils"):captureScreenGaussBlur(function(arg_54_0)
				arg_52_0:addChild(arg_54_0, -2)
				arg_54_0:setPositionY(arg_54_0:getPositionY() - GameDisplay.fix_y)
				arg_52_0:init(arg_52_1)
				var_53_0:setOpacity(102)
				var_53_0:setTouchEnabled(false)
			end)
		end
	end)
end

function AdventureNewDetailLayer:exit()
	global_window_close_action(self.zhupanel, function()
		LayerManager:removePopLayer()
	end)
end

function AdventureNewDetailLayer:hideInfinteSomeInfo()
	self.zhupanel:loadTexture(var_0_30[3], var_0_1)
	self.zhanli:setVisible(false)
	self.titlescore:setVisible(true)
	self.imagecishu:setVisible(false)
	self.ticketPanel:setVisible(false)

	for iter_57_0 = 1, 3 do
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_kao" .. iter_57_0):setVisible(false)
	end
end

function AdventureNewDetailLayer:initInfintePanel()
	self.titlescore:setString(global_trans_number(self.score))

	self.bossinfomode = self.msg.data.show_boss

	if self.bossinfomode then
		self.bossimg:loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[self.bossinfomode].cute_role .. ".png")
		self.bossimg:setScale(0.6)
		self.bossimg:setPosition(cc.p(102, 412))
		self.bossimg:setVisible(true)
	else
		self.bossimg:setVisible(false)
	end

	self:updateInfiniteBattleFiledInfo()
	self.ListView_top:setItemsMargin(0)

	local var_58_0 = self.topitem:clone()

	ccui.Helper:seekWidgetByName(var_58_0, "Label_20"):setString(L_ADVANTURE .. 1)
	self.ListView_top:pushBackCustomItem(var_58_0)
	self.kaohebtn:addTouchEventListener(function(arg_59_0, arg_59_1)
		if arg_59_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:dealInfinteChangeBtn()
	end)
	self.rootLayer:addTouchEventListener(function(arg_60_0, arg_60_1)
		if arg_60_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_window_close_action(self.zhupanel, function()
			LayerManager:removePopLayer()
		end)
	end)
end

function AdventureNewDetailLayer:updateInfiniteBattleFiledInfo()
	local var_62_0 = {}
	local var_62_1 = {}
	local var_62_2 = {}

	if self.msg.data.fildinfo then
		for iter_62_0 in self.msg.data.fildinfo:gmatch("([^,]+)") do
			var_62_2[#var_62_2 + 1] = tonumber(iter_62_0)
		end

		for iter_62_1, iter_62_2 in ipairs(var_62_2) do
			if battlefield_status_data[iter_62_2] and battlefield_status_data[iter_62_2].des and battlefield_status_data[iter_62_2].targetside then
				if battlefield_status_data[iter_62_2].targetside == 1 then
					table.insert(var_62_0, battlefield_status_data[iter_62_2].des)
				elseif battlefield_status_data[iter_62_2].targetside == 2 then
					table.insert(var_62_1, battlefield_status_data[iter_62_2].des)
				end
			end
		end
	end

	if #var_62_0 ~= 0 and #var_62_1 == 0 then
		self.citiaopanel:setVisible(true)
		self.myrule:setVisible(true)
		self.enemyrule:setVisible(false)
		self.myrule:setPosition(var_0_32[1])
		self.listview3:setContentSize(var_0_33[3])
		self.listview3:setPosition(cc.p(var_0_34[3].x, var_0_34[3].y - 5))
	elseif #var_62_0 == 0 and #var_62_1 ~= 0 then
		self.citiaopanel:setVisible(true)
		self.myrule:setVisible(false)
		self.enemyrule:setVisible(true)
		self.enemyrule:setPosition(var_0_32[1])
		self.listview4:setContentSize(var_0_33[3])
		self.listview4:setPosition(cc.p(var_0_34[3].x, var_0_34[3].y - 5))
	elseif #var_62_0 ~= 0 and #var_62_1 ~= 0 then
		self.myrule:setVisible(true)
		self.enemyrule:setVisible(true)
		self.citiaopanel:setVisible(true)
		self.myrule:setPosition(var_0_32[1])
		self.enemyrule:setPosition(var_0_32[2])
		self.listview3:setContentSize(var_0_33[1])
		self.listview4:setContentSize(var_0_33[2])
		self.listview3:setPosition(var_0_34[1])
		self.listview4:setPosition(cc.p(var_0_34[3].x, var_0_34[2].y + 10))
	else
		self.citiaopanel:setVisible(false)
	end

	self.listview3:removeAllChildren()
	self.listview4:removeAllChildren()
	self.listview3:setItemsMargin(0)
	self.listview4:setItemsMargin(0)

	if #var_62_1 > 0 then
		for iter_62_3, iter_62_4 in ipairs(var_62_1) do
			local var_62_3 = self.items2:clone()
			local var_62_4 = ccui.Helper:seekWidgetByName(var_62_3, "Label_text1")
			local var_62_5 = ccui.Helper:seekWidgetByName(var_62_3, "Image_11")

			var_62_4:getVirtualRenderer():setMaxLineWidth(250)
			var_62_4:setColor(var_0_29.enemy)
			var_62_4:setString(iter_62_4)

			if var_62_4:getContentSize().height > 30 then
				var_62_3:setContentSize(cc.size(270, var_62_4:getContentSize().height + 1))
				var_62_4:setPosition(cc.p(12, var_62_3:getContentSize().height))
				var_62_5:setPosition(cc.p(6, var_62_3:getContentSize().height - 10))
			end

			self.listview4:pushBackCustomItem(var_62_3)
		end
	end

	if #var_62_0 > 0 then
		for iter_62_5, iter_62_6 in ipairs(var_62_0) do
			local var_62_6 = self.items2:clone()
			local var_62_7 = ccui.Helper:seekWidgetByName(var_62_6, "Label_text1")
			local var_62_8 = ccui.Helper:seekWidgetByName(var_62_6, "Image_11")

			var_62_7:getVirtualRenderer():setMaxLineWidth(250)
			var_62_7:setColor(var_0_29.myself)
			var_62_7:setString(iter_62_6)

			if var_62_7:getContentSize().height > 30 then
				var_62_6:setContentSize(cc.size(270, var_62_7:getContentSize().height + 1))
				var_62_7:setPosition(cc.p(12, var_62_6:getContentSize().height))
				var_62_8:setPosition(cc.p(6, var_62_6:getContentSize().height - 10))
			end

			self.listview3:pushBackCustomItem(var_62_6)
		end
	end
end

function AdventureNewDetailLayer:dealInfinteChangeBtn()
	local var_63_0, var_63_1 = level_manager:isModeValid(self.mode)

	if not var_63_0 then
		audio_manager:playeffectMusicTest("sound/invalid")
		global_ShowBlockWords(level_manager:getModeUnlockMsg(self.mode, var_63_1))

		return
	end

	local function var_63_2(arg_64_0)
		if arg_64_0 == 1 then
			FightManager.refreshFightToType(FIGHTTYPE_INFINITE)
			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})
			self:exit()
		else
			if arg_64_0 == 0 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_INFINITE_LAYER.noinfinite)
			elseif arg_64_0 == 2 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[2])
			elseif arg_64_0 == 3 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[3])
			elseif arg_64_0 == 4 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_INFINITE_LAYER.noarray)
			end

			GuideListener.showAllGuidesWithFullScreen(true)
		end
	end

	local var_63_3 = RoleDefault:getInstance():getIntegerForKey("adventurearray", playermodel.curArray)
	local var_63_4 = self:getTeamInfo(var_63_3)

	GuideListener.showAllGuidesWithFullScreen(false)
	array_manager:resetHangupArray(var_63_3)
	RoleDefault:getInstance():setIntegerForKey("adventurearray", var_63_3)
	array_manager:executeHangupArrayChange()

	if self:checkTheTeamIsvalid() then
		infinite_fight_manager:switch_to_infinitemode(self.mode, nil, var_63_2)
	end
end

function AdventureNewDetailLayer.getTeamInfo(arg_65_0, arg_65_1)
	if not arg_65_1 then
		return
	end

	local var_65_0 = playermodel.arrays[arg_65_1]
	local var_65_1 = {}

	for iter_65_0 = 1, 4 do
		var_65_1["pos_" .. iter_65_0] = var_65_0["pos_" .. iter_65_0] and var_65_0["pos_" .. iter_65_0] or {
			pos = iter_65_0
		}
	end

	local formation_mode_manager = require("controller.formation.formation_mode_manager")
	local var_65_3 = formation_mode_manager:getInstance():getFormationInfo()[1]

	if not formation_mode_manager then
		var_65_3 = {}
	end

	print(dump(var_65_3))

	local var_65_4 = {}

	for iter_65_1, iter_65_2 in pairs(var_65_3) do
		if type(iter_65_1) == "number" then
			var_65_4["pos_" .. iter_65_2.pos] = iter_65_2
		end
	end

	return var_65_4
end

function AdventureNewDetailLayer:createUPInfoBtn()
	local var_66_0 = ccui.Button:create("adventurenewlayer/btn_more.png", nil, "adventurenewlayer/btn_more.png", var_0_1)

	var_66_0:setPosition(cc.p(self.zhupanel:getContentSize().width / 2 + 100, self.zhupanel:getContentSize().height / 2 - 40))
	self.zhupanel:addChild(var_66_0, 100)
	var_66_0:addTouchEventListener(function(arg_67_0, arg_67_1)
		if arg_67_1 ~= ccui.TouchEventType.ended then
			return
		end

		level_manager:get_infinite_score_up_list(self.mode, function(arg_68_0)
			if arg_68_0.result == 1 then
				LayerManager:pushInLayer("PopAdventureInfiniteUpLayer", {
					uplist = arg_68_0.list
				})
			end
		end)
	end)
end

function AdventureNewDetailLayer:checkIstempTeam()
	local var_69_0 = 0

	if self.team then
		for iter_69_0, iter_69_1 in pairs(self.team) do
			if iter_69_1.fight_girl then
				var_69_0 = var_69_0 + 1
			end
		end
	end

	if var_69_0 == 0 then
		global_ShowBlockWords(L_TEAM_Array_WARNING.Type_Adventure[1], RISE_WORDS_FAIL)
	end

	return var_69_0 > 0
end

function AdventureNewDetailLayer:initCleanSweepBtn()
	local var_70_0 = self.kaohebtn:getParent()

	if var_70_0 then
		self.cleanSweepBtn = TempWidget:CreateTempBtn("adventurenewlayer/clean_sweep_btn.png")

		self.cleanSweepBtn:hide()
		var_70_0:addChild(self.cleanSweepBtn)
		self.cleanSweepBtn:move(150, self.kaohebtn:getPositionY() - 50)

		self.cleanSweepBtn._childData = {}
		self.cleanSweepBtn._selectTimes = 1

		self.cleanSweepBtn:_addEvent(function(arg_71_0)
			if self.times <= 0 then
				local function var_71_0()
					return
				end

				local function var_71_1()
					level_manager:buyAdventureDailyTime(self.msg.data.modetype, function(arg_74_0, arg_74_1, arg_74_2)
						if arg_74_0 == 1 then
							if not var_0_35 then
								return
							end

							global_ShowBlockWords(L_BUY_TIMES_SUCCESS)

							self.times = arg_74_2

							self:updateTimesChange()

							if self.msg.buySuccessFun then
								self.msg.buySuccessFun(arg_74_0, arg_74_1, arg_74_2)
							end
						elseif arg_74_0 == 2 then
							global_ShowBlockWords(L_DIAMOND_LACK)
						elseif arg_74_0 == 3 then
							global_ShowBlockWords(L_BUY_TIMES_LIMITED)
						elseif arg_74_0 == 4 then
							global_ShowBlockWords(L_BUY_TIMES_OVERSIZE)
						end

						if var_71_0 then
							var_71_0()
						end
					end)
				end

				level_manager:getBuyAdventureDailyTimeInfo(self.msg.data.modetype, function(arg_75_0, arg_75_1, arg_75_2)
					if arg_75_0 == 1 then
						local var_75_0 = {
							costtype = "diamond",
							surecallback = var_71_1,
							cancelcallback = function()
								if var_71_0 then
									var_71_0()
								end
							end,
							cost = arg_75_1,
							own = playermodel.diamond,
							labels = {
								titleImage = "title_more_adventure_times.png",
								button = L_BUY_TIMES_MSG_MODETYPE_2.button,
								des = string.format(L_BUY_TIMES_MSG_MODETYPE_2.des, arg_75_1),
								more = string.format(L_BUY_TIMES_MSG_MODETYPE_2.more, arg_75_1)
							}
						}

						LayerManager:pushInLayer("PopDoLayer", var_75_0)

						if self.msg.data.modetype == 2 then
							AnalyticManager.adver_wuzi_buy({
								cost_diamond = var_75_0.cost
							})
						end

						if self.msg.data.modetype == 3 then
							AnalyticManager.adver_yuansu_buy({
								cost_diamond = var_75_0.cost
							})
						end

						if self.msg.data.modetype == 4 then
							AnalyticManager.adver_zhiye_buy({
								cost_diamond = var_75_0.cost
							})
						end
					elseif arg_75_0 == 4 then
						global_ShowBlockWords(L_BUY_TIMES_OVERSIZE)
					else
						global_ShowBlockWords(L_BUY_TIMES_LIMITED)

						if var_71_0 then
							var_71_0()
						end
					end
				end)
			else
				if self.cleanSweepBtn._selectTimes > self.times then
					global_ShowBlockWords("挑战次数不足")

					return
				end

				infinite_fight_manager:requestCleanSweep(self.mode, self.btnindex, self.cleanSweepBtn._selectTimes, function(arg_77_0)
					if arg_77_0.result == 1 then
						if not var_0_35 then
							return
						end

						self.times = arg_77_0.times

						self:updateTimesChange()

						if self.msg.buySuccessFun then
							self.msg.buySuccessFun(arg_77_0.times)
						end
					end
				end)
			end
		end)
		setmetatable({
			[0] = "public/currency/UI_battleEnd_diamond.png",
			"public/currency/UI_battleEnd_gold.png",
			"public/currency/arenascene_dot_1.png",
			"public/currency/explorecoin.png",
			[1500001] = "public/currency/1500001_1.png",
			[100] = "public/currency/rmb_white.png"
		}, {
			__index = function(arg_78_0, arg_78_1)
				return "equipment/" .. require("data.item_data")[arg_78_1].image_id .. ".png"
			end
		})

		local var_70_1 = TempWidget:CreateTempLabel(0, FONT_TITLE, 26, self.cleanSweepBtn)

		var_70_1:move(cc.p(self.cleanSweepBtn:size().w / 2 + 15, self.cleanSweepBtn:size().h / 2))
		var_70_1:_setColor("000000")

		self.cleanSweepBtn._childData.cleanSweepNumText = var_70_1

		local var_70_2 = ccui.Slider:create()

		var_70_2:setName("slider")
		var_70_2:loadBarTexture("public/panelbg/blue_slider_bottom.png", var_0_1)
		var_70_2:loadProgressBarTexture("public/panelbg/blue_slider_bar.png", var_0_1)
		var_70_2:loadSlidBallTextures("public/button/blue_slider_node.png", "public/button/blue_slider_node.png", "public/button/blue_slider_node.png", var_0_1)
		var_70_2:setPercent(0)

		if self.times <= 1 then
			var_70_2:setPercent(100)
		else
			var_70_2:setPercent(1 / self.times * 100)
		end

		self.cleanSweepBtn._childData.slider = var_70_2

		var_70_2:addEventListener(function(arg_79_0, arg_79_1)
			if arg_79_1 == ccui.SliderEventType.percentChanged then
				if self.times > 1 then
					self.cleanSweepBtn._selectTimes = math.ceil(self.times * arg_79_0:getPercent() / 100)
				end

				self.cleanSweepBtn._updateTimesChangeFun()
			elseif arg_79_1 == ccui.SliderEventType.slideBallUp then
				if self.times > 1 then
					self.cleanSweepBtn._selectTimes = math.ceil(self.times * arg_79_0:getPercent() / 100)
				end

				self.cleanSweepBtn._updateTimesChangeFun()
			elseif arg_79_1 == ccui.SliderEventType.slideBallDown then
				-- block empty
			elseif arg_79_1 == ccui.SliderEventType.slideBallCancel then
				if self.times > 1 then
					self.cleanSweepBtn._selectTimes = math.ceil(self.times * arg_79_0:getPercent() / 100)
				end

				self.cleanSweepBtn._updateTimesChangeFun()
			end
		end)
		self.cleanSweepBtn:addChild(var_70_2)
		var_70_2:setPosition(cc.p(self.cleanSweepBtn:getContentSize().width / 2, 105))

		local var_70_3 = TempWidget:CreateTempBtn("public/button/add_blue_btn.png", self.cleanSweepBtn)

		var_70_3:setScale(0.9)
		var_70_3:_addSuperEvent(function(arg_80_0, arg_80_1)
			if self.times <= 1 then
				return
			end

			if arg_80_0 == TempWidget.Click then
				self.cleanSweepBtn._selectTimes = self.cleanSweepBtn._selectTimes + 1

				if self.cleanSweepBtn._selectTimes > self.times then
					self.cleanSweepBtn._selectTimes = self.times
				end

				self.cleanSweepBtn._updateTimesChangeFun()
			elseif arg_80_0 == TempWidget.Press then
				self.cleanSweepBtn._selectTimes = self.cleanSweepBtn._selectTimes + 1

				if self.cleanSweepBtn._selectTimes > self.times then
					self.cleanSweepBtn._selectTimes = self.times
				end

				self.cleanSweepBtn._updateTimesChangeFun()
			end
		end, {
			bAutoStop = false
		})
		var_70_3:move(cc.p(self.cleanSweepBtn:size().w - 10, 105))

		local var_70_4 = TempWidget:CreateTempBtn("public/button/sub_blue_btn.png", self.cleanSweepBtn)

		var_70_4:setScale(0.9)
		var_70_4:_addSuperEvent(function(arg_81_0, arg_81_1)
			if self.times <= 1 then
				return
			end

			if arg_81_0 == TempWidget.Click then
				self.cleanSweepBtn._selectTimes = self.cleanSweepBtn._selectTimes - 1

				if self.cleanSweepBtn._selectTimes <= 1 then
					self.cleanSweepBtn._selectTimes = 1
				end

				self.cleanSweepBtn._updateTimesChangeFun()
			elseif arg_81_0 == TempWidget.Press then
				self.cleanSweepBtn._selectTimes = self.cleanSweepBtn._selectTimes - 1

				if self.cleanSweepBtn._selectTimes <= 1 then
					self.cleanSweepBtn._selectTimes = 1
				end

				self.cleanSweepBtn._updateTimesChangeFun()
			end
		end, {
			bAutoStop = false
		})
		var_70_4:move(cc.p(10, 105))

		function self.cleanSweepBtn._updateTimesChangeFun()
			if self.cleanSweepBtn._selectTimes > self.times then
				self.cleanSweepBtn._selectTimes = self.times
			end

			if self.cleanSweepBtn._selectTimes <= 0 then
				self.cleanSweepBtn._selectTimes = 1
			end

			self.cleanSweepBtn._childData.cleanSweepNumText:setString(self.cleanSweepBtn._selectTimes)

			if self.times <= 1 then
				self.cleanSweepBtn._childData.slider:setPercent(100)
			else
				self.cleanSweepBtn._childData.slider:setPercent(self.cleanSweepBtn._selectTimes / self.times * 100)
			end

			ccui.Helper:seekWidgetByName(self.imagecishu, "Label_24"):setString(self.times)
		end

		self.cleanSweepBtn._updateTimesChangeFun()
	end
end

function AdventureNewDetailLayer:updateCleanSweepBtn(arg_83_1)
	if not self.cleanSweepBtn then
		return
	end

	local var_83_0 = self.msg.data.modetype

	if arg_83_1 < playermodel.levelmode[self.mode].status and var_83_0 and self.msg.data.trialtype and var_0_37[var_83_0] and var_0_37[var_83_0][self.msg.data.trialtype] then
		self.cleanSweepBtn:show()
		self.kaohebtn:setPosition(cc.p(420, self.cleanSweepBtn:getPositionY()))
		self.imagecishu:setPosition(cc.p(420, self.cleanSweepBtn:getPositionY() - 64))
	else
		self.cleanSweepBtn:hide()
		self.kaohebtn:setPosition(cc.p(279, -194))
		self.imagecishu:setPosition(cc.p(284, -258))
	end
end

function AdventureNewDetailLayer:updateTimesChange()
	self.cleanSweepBtn._updateTimesChangeFun()
end

function AdventureNewDetailLayer:initActivityDailyLevelSweepBtn()
	local var_85_0 = self.kaohebtn:getParent()

	if var_85_0 then
		self.sweepBtn = ccui.Button:create("adventurenewlayer/sweep_btn.png", nil, "adventurenewlayer/sweep_btn.png", var_0_1)

		var_85_0:addChild(self.sweepBtn)
		self.sweepBtn:setPosition(160, self.kaohebtn:getPositionY())
		self.sweepBtn:addTouchEventListener(function(arg_86_0, arg_86_1)
			if arg_86_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not self:checkIstempTeam() then
				global_ShowBlockWords("编队信息出现错误！")

				return
			end

			if self.showBuyTimeFunc and self.times <= 0 and self.btnindex ~= self.curlevel + 1 then
				self.showBuyTimeFunc()

				return
			end

			if self.is_once_fight and self.is_once_fight == 1 and self.curlevel < playermodel.levelmode[self.mode].status - 1 then
				global_ShowBlockWords(L_ADVENTURE_IS_ONCE_FIGHT)

				return
			end

			local var_86_0 = {}

			for iter_86_0, iter_86_1 in ipairs(self.team) do
				if iter_86_1.fight_girl then
					table.insert(var_86_0, {
						servantid = iter_86_1.fight_girl
					})
				end
			end

			if self.sweepBtnFunc then
				arg_86_0:setBright(false)
				self.sweepBtnFunc(self.mode, self.btnindex, var_86_0, function(arg_87_0)
					if arg_87_0.result == 1 then
						self.times = self.times - 1

						self:updateButtomBtn(self.btnindex)
					end

					arg_86_0:setBright(true)
				end)
			end
		end)
	end
end

function AdventureNewDetailLayer:updateActivityDailySweepBtn(arg_88_1)
	if not self.canSweep then
		return
	end

	if arg_88_1 <= self.curlevel then
		self.sweepBtn:setVisible(true)
		self.kaohebtn:setPositionX(420)
	else
		self.sweepBtn:setVisible(false)
		self.kaohebtn:setPositionX(290)
	end
end
