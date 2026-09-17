SwimMainLayer = class("SwimMainLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.BottomBtnList")

local var_0_0 = config._DEBUG and 0 or 1
local var_0_1 = 160
local model_data = require("data.model_data")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local school_swim_manager = require("controller.school_swim_manager")

function SwimMainLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = SwimMainLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function SwimMainLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SwimMainLayer.json" or "SwimMainLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initUI()
	self:fullScreen()
	self:registerEventListener()
	school_swim_manager:get_swim_info()
	school_swim_manager:check_swim_vote_reward()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("SwimMainLayer")

			if self.scheduler then
				time_check_manager:removeUpdatePool(self.scheduler)

				self.scheduler = nil
			end
		end
	end)
end

function SwimMainLayer.registerEventListener(arg_5_0)
	activity_manager:registerEventListener("SwimMainLayer", activity_manager.activityEventId.SWIM_TEAM_INFO_UPDATE, function(arg_6_0)
		arg_5_0:updateTimeLbl()
		arg_5_0:updateTeamPanel()
	end)
	activity_manager:registerEventListener("SwimMainLayer", activity_manager.activityEventId.SWIM_COMPETITION_STATE_UPDATE, function(arg_7_0)
		if arg_7_0.showType == "week" then
			LayerManager:pushInLayer("PopSwimWeekResultLayer")

			return
		end

		if not arg_7_0.id or arg_7_0.id < 1 then
			return
		end

		LayerManager:pushInLayer("PopSwimResultLayer", {
			id = arg_7_0.id
		})
	end)
end

function SwimMainLayer:initUI()
	self:initBottomList()
	self:initbtnPanel()
	self:initTeamPanel()
	self:updateVoteAlert()
end

function SwimMainLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self.bottomList:setName("bottomlist")
	self.rootLayer:addChild(self.bottomList, 100)

	local var_9_0 = ccui.ImageView:create("SwimMainLayer/icon_time.png", var_0_0)

	var_9_0:setPosition(cc.p(360, 30))
	self.bottomList:addChild(var_9_0)

	self.lblTime = cc.Label:createWithTTF(L_SWIM_START_TIME_2, FONT_TITLE, 24)

	self.lblTime:setAnchorPoint(cc.p(0, 0.5))
	self.lblTime:setPosition(cc.p(380, 30))
	self.bottomList:addChild(self.lblTime)
end

function SwimMainLayer:initbtnPanel()
	self.btnPanel = self.rootLayer:getChildByName("panel_btn")

	self.btnPanel:getChildByName("btn_manual"):addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "SwimDetail"
		})
	end)
	self.btnPanel:getChildByName("btn_info"):addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopSwimTeamInfoLayer")
	end)
	self.btnPanel:getChildByName("btn_vote"):addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopSwimVoteLayer", {
			callback = function()
				self:updateVoteAlert()
			end
		})
	end)
	self.btnPanel:getChildByName("btn_record"):addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopSwimRecordLayer")
	end)
end

function SwimMainLayer:initTeamPanel()
	self.teamPanel = self.rootLayer:getChildByName("panel_up")

	for iter_17_0 = 1, 2 do
		self.teamPanel:getChildByName("lbl_name_" .. iter_17_0):setString(L_SWIM_NAME)
		self.teamPanel:getChildByName("lbl_title_" .. iter_17_0):setString(L_SWIM_MAIN_LAYER_TITLE)
	end

	self.teamPanel:getChildByName("lbl_week_des"):setString(L_WEEK_RECORD_DES)
end

function SwimMainLayer:updateTeamPanel()
	self.teamList = school_swim_manager:getTeamList()

	if not self.teamList or not next(self.teamList) then
		return
	end

	if self.teamView then
		self:updateShowingCells()

		return
	end

	self.teamView = cc.TableView:create(cc.size(640, 600))

	self.teamView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.teamView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.teamView:setAnchorPoint(cc.p(0, 0))
	self.teamView:setPosition(-5, 53)
	self.teamView:setDelegate()
	self.teamPanel:addChild(self.teamView)
	self.teamView:registerScriptHandler(function(arg_20_0, arg_20_1)
		return 640, var_0_1
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.teamView:registerScriptHandler(function(arg_19_0, arg_19_1)
		local var_19_0 = arg_19_0:dequeueCell()

		if not var_19_0 then
			var_19_0 = cc.TableViewCell:create()

			local var_19_2 = self:createTeamSprite(self.teamList[arg_19_1 + 1], arg_19_1 + 1)

			var_19_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_19_2:setPosition(cc.p(320, var_0_1 / 2))
			var_19_0:addChild(var_19_2)
			var_19_0:setLocalZOrder(999 - 10 * arg_19_1)
		else
			self:updateTeamSprite(var_19_0:getChildByTag(100), self.teamList[arg_19_1 + 1], arg_19_1 + 1)
			var_19_0:setLocalZOrder(999 - 10 * arg_19_1)
		end

		return var_19_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.teamView:registerScriptHandler(function(arg_21_0, arg_21_1)
		return #self.teamList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.teamView:reloadData()
end

local function var_0_6(arg_22_0)
	if not arg_22_0 or not next(arg_22_0) then
		return ""
	end

	local var_22_0 = ""

	for iter_22_0 = 1, #arg_22_0 do
		var_22_0 = var_22_0 .. arg_22_0[iter_22_0] .. "/"
	end

	return string.format(L_SWIM_RANK_LIST, var_22_0)
end

function SwimMainLayer.createTeamSprite(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = ccui.ImageView:create("SwimMainLayer/sprite_bg.png", var_0_0)

	var_23_0:setTag(100)

	local var_23_1 = ccui.ImageView:create("role1/" .. model_data[arg_23_1.captain].role_image .. ".png")

	var_23_1:setPosition(cc.p(55, 105))
	var_23_1:setScale(0.34)
	var_23_1:setName("img_captain")
	var_23_0:addChild(var_23_1)

	local var_23_2 = cc.Label:createWithTTF(string.format(L_SWIM_TEAM_NAMES[arg_23_1.id], arg_23_1.name), FONT_TITLE, 22)

	var_23_2:setAnchorPoint(cc.p(0, 0.5))
	var_23_2:setPosition(cc.p(133, 100))
	var_23_2:setName("lbl_team_name")
	var_23_0:addChild(var_23_2)

	local var_23_3 = cc.Label:createWithTTF(L_SWIM_SCORE .. arg_23_1.score, FONT_TITLE, 20)

	var_23_3:setAnchorPoint(cc.p(1, 0.5))
	var_23_3:setColor(cc.c3b(255, 219, 111))
	var_23_3:setPosition(cc.p(420, 100))
	var_23_3:setName("lbl_score")
	var_23_0:addChild(var_23_3)

	local var_23_4 = cc.Label:createWithBMFont("fonts/friend_system_resume.fnt", arg_23_2)

	var_23_4:setPosition(cc.p(510, 90))
	var_23_4:setName("lbl_rank")
	var_23_0:addChild(var_23_4)

	local var_23_5 = cc.Label:createWithTTF(string.format(L_SWIM_BUFF_DES, arg_23_1.buffName, arg_23_1.buffDes), FONT_TITLE, 16)

	var_23_5:setAnchorPoint(cc.p(0, 1))
	var_23_5:setPosition(cc.p(130, 75))
	var_23_5:setName("lbl_buff")
	var_23_5:setColor(cc.c3b(106, 191, 251))
	var_23_5:setMaxLineWidth(300)
	var_23_0:addChild(var_23_5)

	local var_23_6 = cc.Label:createWithTTF(var_0_6(arg_23_1.ranklist), FONT_TITLE, 20)

	var_23_6:setPosition(cc.p(10, 10))
	var_23_6:setAnchorPoint(cc.p(0, 0.5))
	var_23_6:setName("lbl_rank_list")
	var_23_0:addChild(var_23_6)

	return var_23_0
end

function SwimMainLayer.updateTeamSprite(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_1:setTag(100)
	arg_24_1:getChildByName("img_captain"):loadTexture("role1/" .. model_data[arg_24_2.captain].role_image .. ".png")
	arg_24_1:getChildByName("lbl_team_name"):setString(string.format(L_SWIM_TEAM_NAMES[arg_24_2.id], arg_24_2.name))
	arg_24_1:getChildByName("lbl_score"):setString(L_SWIM_SCORE .. arg_24_2.score)
	arg_24_1:getChildByName("lbl_rank"):setString(arg_24_3)
	arg_24_1:getChildByName("lbl_buff"):setString(string.format(L_SWIM_BUFF_DES, arg_24_2.buffName, arg_24_2.buffDes))
	arg_24_1:getChildByName("lbl_rank_list"):setString(var_0_6(arg_24_2.ranklist))
end

function SwimMainLayer:updateShowingCells()
	local var_25_0, var_25_1 = GetTableViewShowCellIdx(self.teamView, {
		cellsize = cc.size(CELL_WIDTH, CELL_HEIGHT),
		maxcount = self.curtaskListLen
	})

	for iter_25_0 = var_25_0, var_25_1 do
		self.teamView:updateCellAtIndex(iter_25_0)
	end
end

local function var_0_7(arg_26_0)
	if arg_26_0 >= 86400 then
		return string.format(L_TIME_TEXT[1], math.floor(arg_26_0 / 86400), math.floor(arg_26_0 % 86400 / 3600))
	elseif arg_26_0 >= 3600 then
		return string.format(L_TIME_TEXT[2], math.floor(arg_26_0 / 3600), math.floor(arg_26_0 % 3600 / 60))
	else
		return string.format(L_TIME_TEXT[3], math.floor(arg_26_0 / 60), math.floor(arg_26_0 % 60))
	end
end

function SwimMainLayer:updateTimeLbl()
	local var_27_0 = school_swim_manager:getNextSwimStartTime()

	if not var_27_0 then
		self.lblTime:setString(L_SWIM_TIME_END_VOTE)

		return
	end

	self.scheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_27_0, function(arg_28_0)
		self.lblTime:setString(L_SWIM_START_TIME_2 .. var_0_7(arg_28_0))

		if arg_28_0 <= 0 and self.scheduler then
			school_swim_manager:check_swim_vote_reward()
			time_check_manager:removeUpdatePool(self.scheduler)

			self.scheduler = nil
		end
	end)))
end

function SwimMainLayer:updateVoteAlert()
	if school_swim_manager:canVote() then
		global_add_alert_tag(self.btnPanel:getChildByName("btn_vote"), {
			x = 65,
			y = 275
		})
	else
		global_remove_alert_tag(self.btnPanel:getChildByName("btn_vote"))
	end
end

function SwimMainLayer:fullScreen()
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
	self.teamPanel:setPositionY(GameDisplay.height * 0.63 - GameDisplay.fix_y)
	self.btnPanel:setPositionY(GameDisplay.height * 0.05 - GameDisplay.fix_y)
end
