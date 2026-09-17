PopSwimVoteLayer = class("PopSwimVoteLayer", function()
	return PopBaseLayer:create()
end)

function PopSwimVoteLayer.create(arg_2_0, arg_2_1)
	print(dump(arg_2_1))

	local var_2_0 = PopSwimVoteLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

local var_0_0 = 1
local var_0_1 = 2
local activity_manager = require("controller.activity_manager")
local school_swim_manager = require("controller.school_swim_manager")
local model_data = require("data.model_data")
local var_0_5 = config._DEBUG and 0 or 1

function PopSwimVoteLayer:init(arg_3_1)
	print("open poplayer : PopSwimVoteLayer")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopSwimVoteLayer.json" or "PopSwimVoteLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.curStat = var_0_0

	self:initUI()
	self:registerEventListener()
	school_swim_manager:get_swim_daily_vote_info()
	school_swim_manager:get_swim_week_vote_info()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			if arg_3_1 and arg_3_1.callback then
				arg_3_1.callback()
			end

			activity_manager:releaseEventListenerByName("PopSwimVoteLayer")
		end
	end)
end

function PopSwimVoteLayer.registerEventListener(arg_5_0)
	activity_manager:registerEventListener("PopSwimVoteLayer", activity_manager.activityEventId.SWIM_DAILY_VOTE_UPDATE, function(arg_6_0)
		arg_5_0:updatePanelDaily()
	end)
	activity_manager:registerEventListener("PopSwimVoteLayer", activity_manager.activityEventId.SWIM_WEEK_VOTE_UPDATE, function(arg_7_0)
		if arg_7_0.ranklist and next(arg_7_0.ranklist) then
			arg_5_0.isWeekVote = true
		end

		arg_5_0.round = arg_7_0.num
		arg_5_0.weekchoose = arg_7_0.ranklist or {}

		arg_5_0:updatePanelWeek()
	end)
end

function PopSwimVoteLayer:initUI()
	self:addTouchEventMask()
	self:initExitTouchEvent()
	self:initPanelDaily()
	self:initPanelWeek()
	self:initSwitchBtn()
end

function PopSwimVoteLayer:addTouchEventMask()
	local var_9_0 = ccui.Layout:create()

	var_9_0:setContentSize(cc.size(640, 200))
	var_9_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_9_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_9_0:setBackGroundColorOpacity(0)
	var_9_0:setTouchEnabled(true)
	var_9_0:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_10_0:isBright() then
			return
		end

		arg_10_0:setBright(false)
		self:exit()
	end)
	self:addChild(var_9_0, 0)
end

function PopSwimVoteLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_12_0:isBright() then
			return
		end

		arg_12_0:setBright(false)
		self:exit()
	end)
end

function PopSwimVoteLayer:initPanelDaily()
	self.panelUp = self.rootLayer:getChildByName("panel_up")

	self.panelUp:setTouchEnabled(true)

	self.panelDaily = self.panelUp:getChildByName("panel_daily")

	self.panelDaily:getChildByName("lbl_vote"):setString(L_SWIM_VOTE_RATE)
	self.panelDaily:getChildByName("lbl_title"):setString(L_SWIM_SHOOSE_TITLE_MODLE)
	self.panelDaily:getChildByName("lbl_tip"):setString(L_SWIM_SHOOSE_TIP_MODLE)
	self.panelDaily:getChildByName("lbl_daliy_1"):setString(L_SWIM_VOTE_MODEL_DAILTY_1)
	self.panelDaily:getChildByName("lbl_daliy_2"):setString(L_SWIM_VOTE_MODEL_DAILTY_2)

	local var_13_0 = school_swim_manager:getVoteModelDrop()

	for iter_13_0 = 1, 2 do
		if var_13_0[iter_13_0] then
			local var_13_1 = self.panelDaily:getChildByName("img_reward_" .. iter_13_0)

			var_13_1:loadTexture("equipment/" .. var_13_0[iter_13_0].dropid .. ".png")
			var_13_1:setVisible(true)

			local var_13_2 = self.panelDaily:getChildByName("num_reward_" .. iter_13_0)

			var_13_2:setString("X" .. var_13_0[iter_13_0].dropNum)
			var_13_2:setVisible(true)
		else
			self.panelDaily:getChildByName("img_reward_" .. iter_13_0):setVisible(false)
			self.panelDaily:getChildByName("num_reward_" .. iter_13_0):setVisible(false)
		end
	end

	self.panelBtn = self.rootLayer:getChildByName("panel_btn")
	self.voteDailyBtn = self.panelBtn:getChildByName("btn_daily")

	local var_13_3 = ccui.Button:create("SwimMainLayer/btn_vote_detail.png", nil, "SwimMainLayer/btn_vote_detail.png", var_0_5)

	var_13_3:setPosition(cc.p(480, 435))
	self.panelDaily:addChild(var_13_3)
	var_13_3:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "swim_vote_daily"
		})
	end)
end

local function var_0_6(arg_15_0)
	arg_15_0:loadTexture("SwimMainLayer/bg_choose.png", var_0_5)

	local var_15_0 = ccui.ImageView:create("SwimMainLayer/choose.png", var_0_5)

	var_15_0:setPosition(cc.p(64, arg_15_0:getContentSize().height / 2))
	var_15_0:setName("choose_img")
	arg_15_0:addChild(var_15_0)
	arg_15_0:getChildByName("img_vote"):loadTexture("SwimMainLayer/rate_choose.png", var_0_5)
end

local function var_0_7(arg_16_0)
	arg_16_0:loadTexture("SwimMainLayer/bg_unchoose.png", var_0_5)

	if arg_16_0:getChildByName("choose_img") then
		arg_16_0:getChildByName("choose_img"):removeFromParent()
	end

	arg_16_0:getChildByName("img_vote"):loadTexture("SwimMainLayer/rate_unchoose.png", var_0_5)
end

function PopSwimVoteLayer:updatePanelDaily()
	self.dailyBtns = {}
	self.dailyList = school_swim_manager:getVoteList()

	if not self.dailyList then
		self.voteDailyBtn:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_5)
		global_ShowBlockWords(L_SWIM_TIME_END_VOTE)
		LayerManager:removePopLayer(self.__queueindex)

		return
	end

	for iter_17_0 = 1, #self.dailyList do
		local var_17_0 = self.panelDaily:getChildByName("sprite_" .. iter_17_0)

		var_17_0:getChildByName("team"):setString(L_SWIM_TEAM_NAME_2[iter_17_0])
		var_17_0:getChildByName("name"):setString(self.dailyList[iter_17_0].modelName)
		var_17_0:getChildByName("vote"):setString(self.dailyList[iter_17_0].rates)

		local var_17_1 = var_17_0:getChildByName("clip")

		if var_17_1:getChildByName("img_captain") then
			var_17_1:getChildByName("img_captain"):removeFromParent()
		end

		local var_17_2 = ccui.ImageView:create("role/fight/" .. model_data[self.dailyList[iter_17_0].model].role_image .. ".png")

		var_17_2:setPosition(cc.p(var_17_1:getContentSize().width / 2, var_17_1:getContentSize().height / 2 - 5))
		var_17_2:setScale(0.95)
		var_17_2:setName("img_captain")
		var_17_1:addChild(var_17_2)

		if self.dailyList[iter_17_0].vote then
			self.isDailyVote = true

			var_0_6(var_17_0)
		end

		self.dailyBtns[iter_17_0] = var_17_0

		var_17_2:setTouchEnabled(true)
		var_17_2:addTouchEventListener(function(arg_18_0, arg_18_1)
			if arg_18_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.isDailyVote then
				global_ShowBlockWords(L_SWIM_VOTE_FAIL[1])

				return
			end

			if self.chooseDaily == iter_17_0 then
				return
			end

			self.chooseDaily = iter_17_0

			self:updateDailyModel()
		end)
	end

	self:updateDailyBtn()
end

local function var_0_8(arg_19_0)
	if not arg_19_0 then
		return ""
	end

	if arg_19_0 >= 3600 then
		return string.format(L_TIME_FORMAT_HOURMIN, math.floor(arg_19_0 / 3600), math.floor(arg_19_0 % 3600 / 60))
	else
		return string.format(L_TIME_FORMAT_MINSEC, math.floor(arg_19_0 / 60), math.floor(arg_19_0 % 60))
	end
end

function PopSwimVoteLayer:updateDailyBtn()
	if self.isDailyVote then
		self.voteDailyBtn:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_5)
		self.voteDailyBtn:getChildByName("vote"):setString(L_SWIM_VOTE_FAIL[1])
	elseif not school_swim_manager:isTimeToVoteDaily() then
		self.voteDailyBtn:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_5)
		self.voteDailyBtn:getChildByName("vote"):setString(L_SWIM_VOTE_FAIL[2])
	else
		self.voteDailyBtn:loadTextures("public/button/public_button_orange_big.png", nil, "public/button/public_button_orange_big.png", var_0_5)
		self.voteDailyBtn:getChildByName("vote"):setString(L_SWIM_VOTE_FAIL[5])
	end

	self.voteDailyBtn:getChildByName("time"):setString(school_swim_manager:isTimeToVoteDaily() and L_SWIM_END_TIME .. var_0_8(school_swim_manager:getNextSwimStartTime()) or L_SWIM_START_TIME .. var_0_8(school_swim_manager:getNextVoteTime()))
	self.voteDailyBtn:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.isDailyVote then
			return
		end

		if not self.chooseDaily then
			return
		end

		if not school_swim_manager:isTimeToVoteDaily() then
			return
		end

		school_swim_manager:swim_vote_daily(self.chooseDaily)
	end)
end

function PopSwimVoteLayer:updateDailyModel()
	for iter_22_0 = 1, #self.dailyBtns do
		if iter_22_0 == self.chooseDaily then
			var_0_6(self.dailyBtns[iter_22_0])
		else
			var_0_7(self.dailyBtns[iter_22_0])
		end
	end
end

local function var_0_9(arg_23_0, arg_23_1)
	arg_23_0:loadTexture("SwimMainLayer/bg_choose.png", var_0_5)

	local var_23_0 = ccui.ImageView:create("SwimMainLayer/choose.png", var_0_5)

	var_23_0:setPosition(cc.p(64, arg_23_0:getContentSize().height / 2))
	var_23_0:setName("choose_img")
	arg_23_0:addChild(var_23_0)

	local var_23_1 = ccui.ImageView:create("SwimMainLayer/vote_" .. arg_23_1 .. ".png", var_0_5)

	var_23_1:setPosition(cc.p(123, 250))
	var_23_1:setAnchorPoint(cc.p(1, 1))
	var_23_1:setName("vote_index")
	arg_23_0:addChild(var_23_1)
	arg_23_0:getChildByName("img_vote"):loadTexture("SwimMainLayer/rate_choose.png", var_0_5)
end

local function var_0_10(arg_24_0)
	arg_24_0:loadTexture("SwimMainLayer/bg_unchoose.png", var_0_5)

	if arg_24_0:getChildByName("choose_img") then
		arg_24_0:getChildByName("choose_img"):removeFromParent()
	end

	if arg_24_0:getChildByName("vote_index") then
		arg_24_0:getChildByName("vote_index"):removeFromParent()
	end

	arg_24_0:getChildByName("img_vote"):loadTexture("SwimMainLayer/rate_unchoose.png", var_0_5)
end

function PopSwimVoteLayer:initPanelWeek()
	self.panelWeek = self.panelUp:getChildByName("panel_week")

	self.panelWeek:getChildByName("lbl_vote"):setString(L_SWIM_SCORE)
	self.panelWeek:getChildByName("lbl_title"):setString(L_SWIM_SHOOSE_TITLE_TEAM)
	self.panelWeek:getChildByName("lbl_tip"):setString(L_SWIM_SHOOSE_TIP_TEAM)
	self.panelWeek:getChildByName("lbl_daliy_2"):setString(L_SWIM_VOTE_WEEK_DAILTY_1)

	self.teamSprites = {}

	local var_25_0 = school_swim_manager:getTeamListSortById()

	for iter_25_0 = 1, #var_25_0 do
		local var_25_1 = self.panelWeek:getChildByName("sprite_" .. iter_25_0)

		var_25_1:getChildByName("team"):setString(L_SWIM_TEAM_NAME_2[iter_25_0])
		var_25_1:getChildByName("name"):setString(var_25_0[iter_25_0].name)
		var_25_1:getChildByName("vote"):setString(var_25_0[iter_25_0].score)

		local var_25_2 = var_25_1:getChildByName("clip")
		local var_25_3 = ccui.ImageView:create("role/fight/" .. model_data[var_25_0[iter_25_0].captain].role_image .. ".png")

		var_25_3:setPosition(cc.p(var_25_2:getContentSize().width / 2, var_25_2:getContentSize().height / 2 - 5))
		var_25_3:setScale(0.95)
		var_25_3:setName("img_captain")
		var_25_2:addChild(var_25_3)

		self.teamSprites[iter_25_0] = var_25_1
	end

	local var_25_4 = school_swim_manager:getVoteWeekDrop()

	for iter_25_1 = 1, 2 do
		if var_25_4[iter_25_1] then
			local var_25_5 = self.panelWeek:getChildByName("img_reward_" .. iter_25_1)

			var_25_5:loadTexture("equipment/" .. var_25_4[iter_25_1].dropid .. ".png")
			var_25_5:setVisible(true)

			local var_25_6 = self.panelWeek:getChildByName("num_reward_" .. iter_25_1)

			var_25_6:setString("X" .. var_25_4[iter_25_1].dropNum)
			var_25_6:setVisible(true)
		else
			self.panelWeek:getChildByName("img_reward_" .. iter_25_1):setVisible(false)
			self.panelWeek:getChildByName("num_reward_" .. iter_25_1):setVisible(false)
		end
	end

	self.panelBtn = self.rootLayer:getChildByName("panel_btn")
	self.voteWeekBtn = self.panelBtn:getChildByName("btn_week")

	self.voteWeekBtn:setVisible(false)

	local var_25_7 = ccui.Button:create("SwimMainLayer/btn_vote_detail.png", nil, "SwimMainLayer/btn_vote_detail.png", var_0_5)

	var_25_7:setPosition(cc.p(480, 435))
	self.panelWeek:addChild(var_25_7)
	var_25_7:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "swim_vote_week"
		})
	end)
end

function PopSwimVoteLayer:updateWeekTeam()
	for iter_27_0, iter_27_1 in pairs(self.teamSprites) do
		var_0_10(iter_27_1)
	end

	for iter_27_2 = 1, #self.weekchoose do
		var_0_9(self.teamSprites[self.weekchoose[iter_27_2]], iter_27_2)
	end
end

function PopSwimVoteLayer:updatePanelWeek()
	self:updateWeekTeam()

	for iter_28_0, iter_28_1 in pairs(self.teamSprites) do
		iter_28_1:getChildByName("clip"):addTouchEventListener(function(arg_29_0, arg_29_1)
			if arg_29_1 ~= ccui.TouchEventType.ended then
				return
			end

			if iter_28_1.isChoosed then
				iter_28_1.isChoosed = false

				self:removeVote(iter_28_0)
				self:updateWeekTeam()

				return
			end

			if self.isWeekVote then
				return
			end

			if not school_swim_manager:canWeekVote() then
				return
			end

			self.weekchoose[#self.weekchoose + 1] = iter_28_0
			iter_28_1.isChoosed = true

			self:updateWeekTeam()
		end)
	end

	self:updateWeekBtn()
end

function PopSwimVoteLayer:removeVote(arg_30_1)
	local var_30_0

	for iter_30_0, iter_30_1 in pairs(self.weekchoose) do
		if iter_30_1 == arg_30_1 then
			var_30_0 = iter_30_0
		end
	end

	table.remove(self.weekchoose, var_30_0)
end

function PopSwimVoteLayer:updateWeekBtn()
	if self.isWeekVote then
		self.voteWeekBtn:loadTextures("public/button/public_button_orange_big.png", nil, "public/button/public_button_orange_big.png", var_0_5)
		self.voteWeekBtn:getChildByName("vote"):setString(L_SWIM_VOTE_FAIL[4])
	elseif not school_swim_manager:canWeekVote() then
		self.voteWeekBtn:loadTextures("public/button/public_button_gray_long.png", nil, "public/button/public_button_gray_long.png", var_0_5)
		self.voteWeekBtn:getChildByName("vote"):setString(L_SWIM_VOTE_FAIL[2])
	else
		self.voteWeekBtn:loadTextures("public/button/public_button_orange_big.png", nil, "public/button/public_button_orange_big.png", var_0_5)
		self.voteWeekBtn:getChildByName("vote"):setString(L_SWIM_VOTE_FAIL[5])
	end

	self.voteWeekBtn:addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not school_swim_manager:canWeekVote() then
			return
		end

		if self.isWeekVote then
			self.weekchoose = {}
			self.isWeekVote = false

			self:updateWeekTeam()
			self.voteWeekBtn:getChildByName("vote"):setString(L_SWIM_VOTE_FAIL[5])

			for iter_32_0, iter_32_1 in pairs(self.teamSprites) do
				iter_32_1.isChoosed = false
			end

			return
		end

		if #self.weekchoose ~= 4 then
			global_ShowBlockWords(L_SWIM_VOTE_FAIL[3])

			return
		end

		school_swim_manager:swim_vote_week(self.weekchoose, self.round)
	end)
end

function PopSwimVoteLayer:initSwitchBtn()
	self.switchBtnDaily = self.panelUp:getChildByName("btn_daily")
	self.switchBtnWeek = self.panelUp:getChildByName("btn_week")

	self.switchBtnDaily:addTouchEventListener(function(arg_34_0, arg_34_1)
		if arg_34_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curStat == var_0_0 then
			return
		end

		if self.isPlayEffect then
			return
		end

		self.switchBtnDaily:loadTextures("SwimMainLayer/btn_vote_daily_on.png", nil, "SwimMainLayer/btn_vote_daily_on.png", var_0_5)
		self.switchBtnWeek:loadTextures("SwimMainLayer/btn_vote_week.png", nil, "SwimMainLayer/btn_vote_week.png", var_0_5)

		self.curStat = var_0_0

		self:playSwitchEffect(self.panelWeek, self.panelDaily)
		self.voteDailyBtn:setVisible(true)
		self.voteWeekBtn:setVisible(false)
	end)
	self.switchBtnWeek:addTouchEventListener(function(arg_35_0, arg_35_1)
		if arg_35_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curStat == var_0_1 then
			return
		end

		if self.isPlayEffect then
			return
		end

		self.switchBtnDaily:loadTextures("SwimMainLayer/btn_vote_daily.png", nil, "SwimMainLayer/btn_vote_daily.png", var_0_5)
		self.switchBtnWeek:loadTextures("SwimMainLayer/btn_vote_week_on.png", nil, "SwimMainLayer/btn_vote_week_on.png", var_0_5)

		self.curStat = var_0_1

		self:playSwitchEffect(self.panelDaily, self.panelWeek)
		self.voteDailyBtn:setVisible(false)
		self.voteWeekBtn:setVisible(true)
	end)
end

function PopSwimVoteLayer:playSwitchEffect(arg_36_1, arg_36_2)
	self.isPlayEffect = true
	arg_36_1 = arg_36_1 or self.panelDaily
	arg_36_2 = arg_36_2 or self.panelWeek

	local var_36_0 = 0.2

	arg_36_2:setOpacity(0)
	arg_36_2:setVisible(true)
	arg_36_1:runAction(cc.Sequence:create(cc.FadeOut:create(var_36_0), cc.CallFunc:create(function()
		self.isPlayEffect = false

		arg_36_1:setVisible(false)
	end)))
	arg_36_2:runAction(cc.Sequence:create(cc.DelayTime:create(var_36_0), cc.FadeIn:create(var_36_0)))
end

function PopSwimVoteLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopSwimVoteLayer:initBg(arg_40_1)
	local var_40_0 = ccui.Layout:create()

	var_40_0:setTouchEnabled(true)
	var_40_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_40_0:setAnchorPoint(cc.p(0, 0))
	var_40_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_40_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_40_0:setOpacity(0)
	self:addChild(var_40_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_41_0)
		self:addChild(arg_41_0, -2)
		arg_41_0:setPositionY(arg_41_0:getPositionY() - GameDisplay.fix_y)

		local var_41_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_41_0:setAnchorPoint(cc.p(0, 0))
		var_41_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_41_0, -1)
		self:init(arg_40_1)
		var_40_0:setOpacity(102)
		var_40_0:setTouchEnabled(false)
	end)
end
