BianhuaStoryLayer = class("BianhuaStoryLayer", function()
	return cc.Layer:create()
end)

local activity_bianhua_manager = require("controller.activity_bianhua_manager")
local explore_manager = require("controller.explore_manager")
local bianhua_activity_level_data = require("data.bianhua_activity_level_data")
local item_manager = require("controller.item_manager")
local level_manager = require("controller.level_manager")
local audio_manager = require("controller.audio_manager")
local time_check_manager = require("controller.time_check_manager")
local l2utils = require("controller.l2utils")
local playermodel = require("model.playermodel")
local bianhua_explore_list_data = require("data.bianhua_explore_list_data")
local var_0_10 = config._DEBUG and 0 or 1
local var_0_11
local var_0_13 = 1
local var_0_14 = 0
local var_0_15 = 1
local var_0_16 = 2
local var_0_17 = {
	[2] = {
		angle = -3,
		x = 0,
		y = 20
	},
	[3] = {
		angle = 2.07,
		x = 10,
		y = 20
	},
	[4] = {
		angle = -8.54,
		x = -5,
		y = 20
	}
}

function BianhuaStoryLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = BianhuaStoryLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function BianhuaStoryLayer.getInstance()
	return var_0_11
end

function BianhuaStoryLayer:init(arg_4_1)
	RoleDefault:getInstance():setBoolForKey("BianhuaStoryLayer_first", true)

	var_0_11 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Activity_bianhua_chapter.json" or "Activity_bianhua_chapter.ExportJson")

	self:addChild(self.rootLayer)
	self:initData()
	self:initUI()
	self:fullScreen()
	self:updateData()
end

function BianhuaStoryLayer.initData(arg_5_0)
	arg_5_0.levelId = 0
	arg_5_0.dailyCount = 0
	arg_5_0.buyCount = 0
	arg_5_0.aniState = var_0_14
	arg_5_0.finish = false
	arg_5_0.levelModeid = activity_bianhua_manager:getLevelModeid()
	arg_5_0.levelModeType = activity_bianhua_manager:getLevelModelModetype()
	arg_5_0.extraLevelData = activity_bianhua_manager:getExtraData()
	arg_5_0.ActivityID = activity_bianhua_manager:getActivityId()
	arg_5_0.unlockTime = activity_bianhua_manager:getUnlockTime()
	arg_5_0.freeDailyCount = activity_bianhua_manager:get_explore_daily_times()
	arg_5_0.buyDailyLimit = activity_bianhua_manager:get_explore_daily_buy_times()
	arg_5_0.hideTaskDes = activity_bianhua_manager:getHideTaskDes()
end

function BianhuaStoryLayer.updateData(arg_6_0)
	explore_manager:getTotalLevelInfoByServer(function()
		local var_7_0 = explore_manager:getExploreLevelInfo(1)

		arg_6_0:setLevelId(var_7_0.finish_step)
		arg_6_0:setIfChapterFinish(var_7_0)
		arg_6_0:updateUI()
	end)
end

function BianhuaStoryLayer:initUI()
	self.imgBg = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_bg")
	self.chapterShade = ccui.Helper:seekWidgetByName(self.rootLayer, "chapter_shade")
	self.ticketPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_ticket"):clone()
	self.chapterUI = {}

	self:initTitle()
	self:initChapterUI()
	self:initPhoneUI()
	self:initBottomBtnList()
	self:initBottomAddPanel()
end

function BianhuaStoryLayer:updateUI()
	self.ChapterMsg = self:getChapterMsg(self.levelId, function(arg_10_0)
		self:setChapterUnlock(arg_10_0)
	end)

	self:updateTicketNum()
	self:updateChapterInactive(self.ChapterMsg)
	self:updateChapterActive(self.ChapterMsg)
	self:updateChapterTitle(self.ChapterMsg)
	self:updateChapterRepeat(self.ChapterMsg)
	self:updateHideTaskInfo(self.ChapterMsg)
	self:updatePhone()
	self:updateBottomAddPanel()
end

function BianhuaStoryLayer:initTitle()
	local var_11_0 = TitleSprite:create("Activity_bianhua_Chapter/title.png", 2)

	var_11_0.title:setPositionX(0)
	var_11_0:setAnchorPoint(cc.p(0, 1))
	var_11_0:setPosition(0, SCREEN_HEIGHT)
	var_11_0:setName("titleBg")
	var_11_0:addChild(self.ticketPanel)
	self.ticketPanel:setVisible(false)
	self.ticketPanel:setPosition(cc.p(560, var_11_0:getContentSize().height / 2))
	self.ticketPanel:getChildByName("ticket_num"):setString(self.ticketNum)
	self.rootLayer:addChild(var_11_0, 5)
end

function BianhuaStoryLayer:initBottomBtnList()
	self.bottomlist = BottomBtnList:create(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()

		if callback then
			callback()
		end
	end, {})

	self:addChild(self.bottomlist, 5)
end

function BianhuaStoryLayer:initBottomAddPanel()
	local var_14_0 = ccui.Layout:create()

	var_14_0:setTouchEnabled(true)
	var_14_0:setContentSize(cc.size(320, 62))
	var_14_0:setAnchorPoint(cc.p(0, 0))
	var_14_0:setPosition(cc.p(320, 0))
	var_14_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_14_0:setName("bottomAddPanel")
	self.bottomlist:addChild(var_14_0)

	local var_14_1 = ccui.ImageView:create("Activity_bianhua_Chapter/new_changtimesdi.png", var_0_10)

	var_14_1:setPositionX(235)
	var_14_1:setPositionY(31)
	var_14_0:addChild(var_14_1)

	local var_14_2 = cc.Label:createWithTTF(L_ADVENTURER_RANDOMLAYER[8] .. "：   2", FONT_DES, 20)

	var_14_2:setPositionX(150)
	var_14_2:setPositionY(31)
	var_14_2:setName("surplusLabel")
	var_14_2:setColor(cc.c3b(14, 185, 255))
	var_14_0:addChild(var_14_2)
end

function BianhuaStoryLayer:updateBottomAddPanel()
	self.bottomlist:getChildByName("bottomAddPanel"):setVisible(false)
	self.bottomlist:getChildByName("bottomAddPanel"):getChildByName("surplusLabel"):setString(L_ADVENTURER_RANDOMLAYER[8] .. "：   " .. self.freeDailyCount - self:getTotalDailyTimes() + self:getBuyTimes())
end

function BianhuaStoryLayer.getBuyDailyhandel(arg_16_0, ...)
	return function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_17_1
		local var_17_0

		if arg_16_0:getBuyTimes() == arg_16_0.buyDailyLimit then
			global_ShowBlockWords("购买已达上限")

			do return end

			var_17_0 = activity_bianhua_manager:get_buy_times_cost(arg_16_0:getBuyTimes() + 1)
			var_17_1 = {
				costtype = "diamond"
			}
		end

		function var_17_1.surecallback()
			activity_bianhua_manager:activity_buy_explore_times(function(arg_19_0, arg_19_1)
				if arg_19_0 == 1 then
					arg_16_0:setBuyTimes(arg_19_1)
					arg_16_0:updateUI()
					AnalyticManager.BAH_buy_explore_times({
						buy_times = arg_19_1
					})
				elseif arg_19_0 == 3 then
					global_ShowBlockWords("购买已达上限")
				elseif arg_19_0 == 4 then
					global_ShowBlockWords("钻石不足")
				end
			end)
		end

		function var_17_1.cancelcallback()
			arg_17_0.bright = true
		end

		var_17_1.cost = var_17_0
		var_17_1.own = playermodel.diamond
		var_17_1.labels = {
			button = "确认购买",
			titleImage = "title_more_adventure_times.png",
			des = string.format("花费%d" .. L_DIAMOND .. "购买1次随机副本次数", var_17_0),
			more = string.format("%d" .. L_DIAMOND .. "回复1次~~~~", var_17_0)
		}

		LayerManager:pushInLayer("PopDoLayer", var_17_1)
	end
end

function BianhuaStoryLayer:initChapterUI()
	for iter_21_0 = 1, 5 do
		local var_21_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "chapter_" .. tostring(iter_21_0))

		self.chapterUI[iter_21_0] = {}
		self.chapterUI[iter_21_0].main = var_21_0
		self.chapterUI[iter_21_0].level = var_21_0:getChildByName("chapter_" .. tostring(iter_21_0) .. "_level")
		self.chapterUI[iter_21_0].name = var_21_0:getChildByName("chapter_" .. tostring(iter_21_0) .. "_name")
		self.chapterUI[iter_21_0].clear = var_21_0:getChildByName("chapter_" .. tostring(iter_21_0) .. "_clear")
		self.chapterUI[iter_21_0].outline = var_21_0:getChildByName("chapter_" .. tostring(iter_21_0) .. "_outline")
		self.chapterUI[iter_21_0].restart = var_21_0:getChildByName("chapter_" .. tostring(iter_21_0) .. "_restart")
		self.chapterUI[iter_21_0].active = var_21_0:getChildByName("chapter_" .. tostring(iter_21_0) .. "_active")
		self.chapterUI[iter_21_0].hide = var_21_0:getChildByName("chapter_" .. tostring(iter_21_0) .. "_hide")
	end

	self.chapterUI[5].name:setFontSize(35)
	self.chapterUI[2].name:setString(L_BIANHUA_CHAPTERNAME[2])
	self.chapterUI[3].name:setString(L_BIANHUA_CHAPTERNAME[3])
	self.chapterUI[4].name:setString(L_BIANHUA_CHAPTERNAME[4])
	self.chapterUI[5].name:setString(L_BIANHUA_CHAPTERNAME[5])
end

function BianhuaStoryLayer:initPhoneUI()
	local var_22_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "phone")

	self.phone = {}
	self.phone.main = var_22_0
	self.phone.active = ccui.Helper:seekWidgetByName(self.rootLayer, "phone_active")
	self.phone.outline = ccui.Helper:seekWidgetByName(self.rootLayer, "phone_outline")
	self.phone.shade = ccui.Helper:seekWidgetByName(self.rootLayer, "phone_shade")

	var_22_0:setVisible(false)
end

function BianhuaStoryLayer:updateTicketNum()
	self.ticketPanel:getChildByName("ticket_num"):setString(self.ticketNum)
end

function BianhuaStoryLayer:updateChapterActive(arg_24_1)
	local var_24_0 = 1

	while var_24_0 < arg_24_1.nowChapter.id do
		self.chapterUI[var_24_0].main:setTouchEnabled(false)
		self.chapterUI[var_24_0].outline:setVisible(false)

		if self.chapterUI[var_24_0].active then
			self.chapterUI[var_24_0].active:setVisible(true)
		end

		if self.chapterUI[var_24_0].name then
			self.chapterUI[var_24_0].name:setVisible(true)
		end

		if self.chapterUI[var_24_0].decoration then
			self.chapterUI[var_24_0].decoration:setVisible(true)
		end

		if self.chapterUI[var_24_0].clear then
			self.chapterUI[var_24_0].clear:setVisible(true)
		end

		if self.chapterUI[var_24_0].unlock then
			self.chapterUI[var_24_0].unlock:setVisible(false)
		end

		var_24_0 = var_24_0 + 1
	end

	if not self.chapterUI[arg_24_1.nowChapter.id].unlocktag then
		if self.chapterUI[arg_24_1.nowChapter.id].active then
			self.chapterUI[var_24_0].active:setVisible(true)
		end

		if self.chapterUI[arg_24_1.nowChapter.id].name then
			self.chapterUI[var_24_0].name:setVisible(true)
		end

		if self.chapterUI[arg_24_1.nowChapter.id].decoration then
			self.chapterUI[var_24_0].decoration:setVisible(true)
		end

		if self.chapterUI[arg_24_1.nowChapter.id].unlock then
			self.chapterUI[var_24_0].unlock:setVisible(false)
		end

		if self.chapterUI[arg_24_1.nowChapter.id].clear then
			self.chapterUI[var_24_0].clear:setVisible(false)
		end
	end

	self.chapterUI[arg_24_1.nowChapter.id].main:setVisible(true)
	self.chapterUI[arg_24_1.nowChapter.id].main:setTouchEnabled(false)
	self.chapterUI[arg_24_1.nowChapter.id].main:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_24_1.nowChapter.finishType == "talk" then
			self:gotoTalk(arg_24_1)
		elseif arg_24_1.nowChapter.finishType == "explore" then
			self:gotoExplore(arg_24_1)
		end
	end)

	if not self:getIfChapterFinish() and not self.chapterUI[var_24_0].unlocktag then
		self.chapterUI[arg_24_1.nowChapter.id].main:setTouchEnabled(true)
		self.chapterUI[arg_24_1.nowChapter.id].outline:setVisible(true)
		self.chapterUI[arg_24_1.nowChapter.id].outline:setOpacity(0)
		self.chapterUI[arg_24_1.nowChapter.id].outline:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1, 255), cc.DelayTime:create(0.2), cc.FadeTo:create(1, 0))))
	elseif self:getIfChapterFinish() then
		self.chapterUI[arg_24_1.nowChapter.id].clear:setVisible(true)
		self.chapterUI[arg_24_1.nowChapter.id].outline:setVisible(false)
	end
end

function BianhuaStoryLayer:updateChapterInactive(arg_26_1)
	local var_26_0 = self:getUnlockTime()

	while 2 <= 4 do
		local var_26_1 = global_get_time_by_date(var_26_0[2])
		local var_26_2 = ""

		print("---------", 2, var_26_1, time_check_manager:getCurTime(), self.chapterUI[2].unlock)

		if var_26_1 > time_check_manager:getCurTime() then
			self.chapterUI[2].unlocktag = true
			var_26_2 = global_format_time_by_date(var_26_0[2], 1)
			var_26_2 = var_26_2 .. "\n" .. string.format(L_AREAN_UNLOCK, L_BIANHUA_CHAPTERNAME[2 - 1])
		else
			self.chapterUI[2].unlocktag = false
			var_26_2 = string.format(L_AREAN_UNLOCK, L_BIANHUA_CHAPTERNAME[2 - 1])
		end

		if not self.chapterUI[2].unlock then
			self.chapterUI[2].unlock = cc.Label:createWithTTF("", "fonts/name.ttf", 19)

			self.chapterUI[2].unlock:setColor(cc.c3b(255, 255, 255))
			self.chapterUI[2].unlock:setHorizontalAlignment(cc.TEXT_ALIGNMENT_CENTER)
			self.chapterUI[2].unlock:setString(var_26_2)
			self.chapterUI[2].unlock:setAnchorPoint(cc.p(0.5, 0.5))
			self.chapterUI[2].unlock:setPosition(self.chapterUI[2].main:getContentSize().width / 2 + var_0_17[2].x, self.chapterUI[2].main:getContentSize().height / 2 + var_0_17[2].y)
			self.chapterUI[2].unlock:setRotation(var_0_17[2].angle)
			self.chapterUI[2].main:addChild(self.chapterUI[2].unlock, 6)
		else
			self.chapterUI[2].unlock:setString(var_26_2)
		end
	end
end

function BianhuaStoryLayer:updateChapterTitle(arg_27_1)
	for iter_27_0 = 1, arg_27_1.nowChapter.id - 1 do
		if self.chapterUI[iter_27_0].level then
			self.chapterUI[iter_27_0].level:setVisible(true)
			self.chapterUI[iter_27_0].level:setString(arg_27_1.chapterTitle[iter_27_0])
		end
	end

	if self.chapterUI[arg_27_1.nowChapter.id].level and not self.chapterUI[arg_27_1.nowChapter.id].unlocktag then
		self.chapterUI[arg_27_1.nowChapter.id].level:setVisible(true)
		self.chapterUI[arg_27_1.nowChapter.id].level:setString(arg_27_1.chapterTitle[arg_27_1.nowChapter.id])
	end
end

function BianhuaStoryLayer:updateChapterRepeat(arg_28_1)
	local var_28_0 = arg_28_1.repeatLevel

	while 2 <= #arg_28_1.repeatLevel and 2 <= 4 do
		local var_28_1 = self.chapterUI[2]

		self.chapterUI[2].restart:setVisible(true)

		self.chapterUI[2].flag = 2

		self.chapterUI[2].restart:addTouchEventListener(function(arg_29_0, arg_29_1)
			if arg_29_1 ~= ccui.TouchEventType.ended then
				return
			end

			print("进入无限本")
			explore_manager:begin_explore({
				frameType = "bianhua",
				type = "activity",
				returnLayer = "BianhuaStoryLayer",
				activity_explore_id = var_28_0[var_28_1.flag].id,
				activityid = self.ActivityID,
				cancelCallback = function(arg_30_0)
					if arg_30_0 == 2 then
						global_ShowBlockWords(L_EXPLORE_ERROR_NEW[2])
					elseif arg_30_0 == 3 then
						global_ShowBlockWords(L_EXPLORE_ERROR_NEW[3])
					elseif arg_30_0 == 4 then
						global_ShowBlockWords(L_EXPLORE_ERROR_NEW[4])
					elseif arg_30_0 == 5 then
						global_ShowBlockWords(L_EXPLORE_ERROR_NEW[5])
					elseif arg_30_0 == 7 then
						global_ShowBlockWords(L_EXPLORE_ERROR_NEW[7])
					elseif arg_30_0 == 0 then
						global_ShowBlockWords(L_EXPLORE_ERROR_NEW[0])
					end
				end
			})
		end)
		self.chapterUI[2].main:setTouchEnabled(true)
		self.chapterUI[2].main:addTouchEventListener(function(arg_31_0, arg_31_1)
			if arg_31_1 ~= ccui.TouchEventType.ended then
				return
			end

			print("进入无限本")
			explore_manager:begin_explore({
				frameType = "bianhua",
				type = "activity",
				returnLayer = "BianhuaStoryLayer",
				activity_explore_id = var_28_0[var_28_1.flag].id,
				activityid = self.ActivityID,
				cancelCallback = function(arg_32_0)
					if arg_32_0 == 2 then
						global_ShowBlockWords(L_EXPLORE_ERROR_NEW[2])
					elseif arg_32_0 == 3 then
						global_ShowBlockWords(L_EXPLORE_ERROR_NEW[3])
					elseif arg_32_0 == 4 then
						global_ShowBlockWords(L_EXPLORE_ERROR_NEW[4])
					elseif arg_32_0 == 5 then
						global_ShowBlockWords(L_EXPLORE_ERROR_NEW[5])
					elseif arg_32_0 == 7 then
						global_ShowBlockWords(L_EXPLORE_ERROR_NEW[7])
					elseif arg_32_0 == 0 then
						global_ShowBlockWords(L_EXPLORE_ERROR_NEW[0])
					end
				end
			})
		end)
	end
end

function BianhuaStoryLayer:updateHideTaskInfo(arg_33_1)
	while 2 <= #arg_33_1.repeatLevel and 2 <= 4 do
		local var_33_0 = self.chapterUI[2]

		self.chapterUI[2].hide:setVisible(true)
		self.chapterUI[2].hide:addTouchEventListener(function(arg_34_0, arg_34_1)
			if arg_34_1 ~= ccui.TouchEventType.ended then
				return
			end

			print("弹出隐藏成就tips")
			self:createHidePanel(var_33_0.flag)
		end)
	end
end

function BianhuaStoryLayer:updatePhone()
	local var_35_0 = self:getExtraLevelData()

	if self:isPhoneLight(self:getLevelId()) then
		self.phone.active:setVisible(true)

		if not self.phone.levelDetail then
			self.phone.levelTitle = cc.Label:createWithTTF("", "fonts/yanwenzi.ttf", 29)

			self.phone.levelTitle:setColor(cc.c3b(77, 127, 150))
			self.phone.levelTitle:setString(L_BIANHUA_STORY[1])
			self.phone.levelTitle:setAnchorPoint(cc.p(0.5, 0.5))
			self.phone.levelTitle:setPosition(self.phone.main:getContentSize().width / 2 + 2, self.phone.main:getContentSize().height / 2)
			self.phone.levelTitle:setRotation(5)
			self.phone.main:addChild(self.phone.levelTitle, 6)
		end

		local var_35_1, var_35_2 = activity_bianhua_manager:getTicketData()

		if var_35_2 < self:getTicketNum() then
			self.phone.outline:setVisible(true)
			self.phone.outline:setOpacity(0)
			self.phone.outline:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeTo:create(1, 255), cc.DelayTime:create(0.2), cc.FadeTo:create(1, 0))))
		else
			self.phone.outline:setVisible(false)
		end
	end

	self.phone.main:setTouchEnabled(true)
	self.phone.main:addTouchEventListener(function(arg_36_0, arg_36_1)
		if arg_36_1 ~= ccui.TouchEventType.ended then
			return
		end

		cclog("这次临时关闭")
	end)
end

function BianhuaStoryLayer:updateChangeAni(arg_37_1)
	if self:getAniState() == var_0_15 then
		self.chapterUI[arg_37_1.nowChapter.id - 1].clear:setScale(5)

		if self.chapterUI[arg_37_1.nowChapter.id - 1].restart then
			self.chapterUI[arg_37_1.nowChapter.id - 1].restart:setOpacity(0)
		end

		self.chapterUI[arg_37_1.nowChapter.id - 1].clear:runAction(cc.Sequence:create(cc.ScaleTo:create(0.5, 1)))

		if self.chapterUI[arg_37_1.nowChapter.id - 1].restart then
			self.chapterUI[arg_37_1.nowChapter.id - 1].restart:runAction(cc.Sequence:create(cc.FadeTo:create(150, 255)))
		end
	end
end

function BianhuaStoryLayer:gotoTalk(arg_38_1)
	local var_38_0 = self:getTalkConfig(arg_38_1.nowChapter.cur_step)

	print("对话——————————————————————————————", dump(var_38_0))

	local function var_38_1()
		print("刷新UI回调")
		self:updateData()
	end

	global_basic_scene:addChild(TalkLayer:create(var_38_0.talkid, nil, 1, "", function()
		explore_manager:pushExploreLevel(var_0_13, var_38_1)
	end))
end

function BianhuaStoryLayer:gotoExplore(arg_41_1)
	local var_41_0 = self:getExploreConfig(arg_41_1.nowChapter.cur_step)

	print("探险——————————————————————————————", dump(var_41_0))
	explore_manager:begin_explore({
		frameType = "bianhua",
		type = "level",
		returnLayer = "BianhuaStoryLayer",
		classid = var_0_13,
		cur_step = var_41_0.levelid,
		cancelCallback = function(arg_42_0)
			if arg_42_0 == 2 then
				global_ShowBlockWords(L_EXPLORE_ERROR_NEW[2])
			elseif arg_42_0 == 3 then
				global_ShowBlockWords(L_EXPLORE_ERROR_NEW[3])
			elseif arg_42_0 == 4 then
				global_ShowBlockWords(L_EXPLORE_ERROR_NEW[4])
			elseif arg_42_0 == 5 then
				global_ShowBlockWords(L_EXPLORE_ERROR_NEW[5])
			elseif arg_42_0 == 0 then
				global_ShowBlockWords(L_EXPLORE_ERROR_NEW[0])
			end
		end
	})
end

function BianhuaStoryLayer:createHidePanel(arg_43_1)
	local var_43_0 = ccui.Layout:create()

	var_43_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_43_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_43_0:setAnchorPoint(0, 0)
	var_43_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_43_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_43_0:setBackGroundColorOpacity(180)
	self.rootLayer:addChild(var_43_0, 99)

	local var_43_1 = ccui.Layout:create()

	var_43_1:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_43_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_43_1:setAnchorPoint(0.5, 0.5)
	var_43_1:setPosition(var_43_0:getContentSize().width / 2, var_43_0:getContentSize().height / 2)
	var_43_0:addChild(var_43_1, 2)

	local var_43_2 = ccui.ImageView:create("Activity_bianhua_Chapter/hide_panel.png", var_0_10)

	var_43_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_43_2:setPosition(var_43_0:getContentSize().width / 2, var_43_0:getContentSize().height / 2)

	local var_43_3 = cc.Label:createWithTTF("", "fonts/name.ttf", 22)

	var_43_3:setDimensions(240, 100)
	var_43_3:setAnchorPoint(cc.p(0, 0.5))
	var_43_3:setColor(cc.c3b(0, 0, 0))
	var_43_3:setPosition(140, var_43_2:getContentSize().height / 2 + 10)
	var_43_3:setString(self.hideTaskDes[arg_43_1][1])
	var_43_2:addChild(var_43_3)

	local var_43_4 = cc.Label:createWithTTF("", "fonts/name.ttf", 22)

	var_43_4:setDimensions(240, 100)
	var_43_4:setAnchorPoint(cc.p(0, 0.5))
	var_43_4:setColor(cc.c3b(0, 0, 0))
	var_43_4:setPosition(140, var_43_2:getContentSize().height / 2 - 105)
	var_43_4:setString(self.hideTaskDes[arg_43_1][2])
	var_43_2:addChild(var_43_4)
	var_43_0:setTouchEnabled(true)
	var_43_1:setTouchEnabled(false)
	var_43_2:setScale(0)
	var_43_0:addChild(var_43_2, 10)
	var_43_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.2), cc.ScaleTo:create(0.1, 1), cc.CallFunc:create(function()
		var_43_0:addTouchEventListener(function(arg_45_0, arg_45_1)
			if arg_45_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_43_1:setTouchEnabled(true)
			var_43_2:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1.2), cc.ScaleTo:create(0.2, 0), cc.CallFunc:create(function()
				var_43_0:runAction(cc.RemoveSelf:create())
			end)))
		end)
	end)))
end

function BianhuaStoryLayer:fullScreen()
	local var_47_0 = self.rootLayer:getChildByName("titleBg")

	var_47_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 0, TRANSFORM_UNIT.PX)

	var_47_0:setPositionY(var_47_0.full_posY)

	self.imgBg.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, GameDisplay.height * 0.48, TRANSFORM_UNIT.PX)

	self.imgBg:setPositionY(self.imgBg.full_posY)

	self.bottomlist.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomlist:getPositionY(), TRANSFORM_UNIT.PX)

	self.bottomlist:setPositionY(self.bottomlist.full_posY)
end

function BianhuaStoryLayer.setLevelId(arg_48_0, arg_48_1)
	arg_48_0.levelId = arg_48_1
end

function BianhuaStoryLayer:getLevelId()
	return self.levelId
end

function BianhuaStoryLayer.setTotalDailyTimes(arg_50_0, arg_50_1)
	arg_50_0.dailyCount = arg_50_1
end

function BianhuaStoryLayer:getTotalDailyTimes()
	return self.dailyCount
end

function BianhuaStoryLayer.setBuyTimes(arg_52_0, arg_52_1)
	arg_52_0.buyCount = arg_52_1
end

function BianhuaStoryLayer:getBuyTimes()
	return self.buyCount
end

function BianhuaStoryLayer.setAniState(arg_54_0, arg_54_1)
	arg_54_0.aniState = arg_54_1
end

function BianhuaStoryLayer:getAniState()
	return self.aniState
end

function BianhuaStoryLayer:getExtraLevelData()
	return self.extraLevelData
end

function BianhuaStoryLayer:setChapterUnlock(arg_57_1)
	local var_57_0 = self:getLevelId()
	local var_57_1 = RoleDefault:getInstance():getIntegerForKey("ActivityBianhuaChapter", arg_57_1.nowChapter.id)

	if var_57_1 then
		if var_57_1 < arg_57_1.nowChapter.id then
			RoleDefault:getInstance():setIntegerForKey("ActivityBianhuaChapter", arg_57_1.nowChapter.id)
			self:setAniState(var_0_15)
		elseif RoleDefault:getInstance():getIntegerForKey("ActivityBianhuaLevel", var_57_0) < var_57_0 then
			RoleDefault:getInstance():setIntegerForKey("ActivityBianhuaLevel", var_57_0)
			self:setAniState(var_0_16)
		else
			self:setAniState(var_0_14)
		end
	end
end

function BianhuaStoryLayer:setIfChapterFinish(arg_58_1)
	if arg_58_1.finish_step == self:getDataLength() then
		self.finish = true
	end
end

function BianhuaStoryLayer:getIfChapterFinish()
	return self.finish
end

function BianhuaStoryLayer:getUnlockTime()
	return self.unlockTime
end

function BianhuaStoryLayer.setTicketNum(arg_61_0)
	arg_61_0.ticketNum = item_manager:getItemNumber((activity_bianhua_manager:getTicketData()))
end

function BianhuaStoryLayer:getTicketNum()
	return self.ticketNum
end

function BianhuaStoryLayer.getChapterMsg(arg_63_0, arg_63_1)
	local var_63_0 = {
		nowChapter = {},
		chapterTitle = {},
		repeatLevel = {}
	}
	local var_63_1 = 1

	local function var_63_2(arg_64_0)
		return arg_64_0 == 1 and 1 or arg_64_0 >= 2 and arg_64_0 <= 4 and 2 or arg_64_0 >= 5 and arg_64_0 <= 7 and 3 or arg_64_0 >= 8 and arg_64_0 <= 10 and 4 or 5
	end

	while bianhua_explore_list_data[var_0_13]["step" .. var_63_1] and var_63_1 <= arg_63_1 + 1 do
		var_63_0.nowChapter.finishType = bianhua_explore_list_data[var_0_13]["step" .. var_63_1 .. "_type"] == 1 and "explore" or "talk"
		var_63_0.nowChapter.id = var_63_2(var_63_1)
		var_63_0.nowChapter.cur_step = var_63_1
		var_63_0.nowChapter.finish_step = arg_63_1

		if bianhua_explore_list_data[var_0_13]["step" .. var_63_1 .. "_des"] then
			var_63_0.chapterTitle[var_63_2(var_63_1)] = bianhua_explore_list_data[var_0_13]["step" .. var_63_1 .. "_des"]
		end

		var_63_1 = var_63_1 + 1
	end

	print(dump(var_63_0))

	return var_63_0
end

function BianhuaStoryLayer.getTalkConfig(arg_65_0, arg_65_1)
	return {
		talkid = bianhua_explore_list_data[var_0_13]["step" .. arg_65_1],
		levelid = arg_65_1
	}
end

function BianhuaStoryLayer.getExploreConfig(arg_66_0, arg_66_1)
	return {
		aimid = bianhua_explore_list_data[var_0_13]["step" .. arg_66_1],
		levelid = arg_66_1
	}
end

function BianhuaStoryLayer.isPhoneLight(arg_67_0, arg_67_1)
	return false
end

function BianhuaStoryLayer.getDataLength(arg_68_0)
	return bianhua_explore_list_data[var_0_13].total_step
end
