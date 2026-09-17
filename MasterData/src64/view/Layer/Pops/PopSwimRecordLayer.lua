PopSwimRecordLayer = class("PopSwimRecordLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")

local var_0_0 = 110
local var_0_1 = config._DEBUG and 0 or 1
local model_data = require("data.model_data")
local school_swim_manager = require("controller.school_swim_manager")
local activity_manager = require("controller.activity_manager")
local var_0_5 = {}

var_0_5[1] = "SwimMainLayer/record_vote_succ.png"
var_0_5[2] = "SwimMainLayer/record_vote_fail.png"
var_0_5[3] = "SwimMainLayer/record_unvote.png"

function PopSwimRecordLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopSwimRecordLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopSwimRecordLayer:init(arg_3_1)
	print("open poplayer : PopSwimRecordLayer")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopSwimRecordLayer.json" or "PopSwimRecordLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerEventListener()
	school_swim_manager:get_swim_record()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopSwimRecordLayer")
		end
	end)
end

function PopSwimRecordLayer.registerEventListener(arg_5_0)
	activity_manager:registerEventListener("PopSwimRecordLayer", activity_manager.activityEventId.SWIM_RECORD_LIST_UPDATE, function(arg_6_0)
		arg_5_0.voteList = arg_6_0.voteList

		arg_5_0:updateVoteView()
	end)
	activity_manager:registerEventListener("PopSwimRecordLayer", activity_manager.activityEventId.SWIM_COMPETITION_LIST_UPDATE, function(arg_7_0)
		LayerManager:switchShowLayer("SchoolSwimLayer")
	end)
end

function PopSwimRecordLayer:initUI()
	self:initExitTouchEvent()
	self:initTilte()
end

function PopSwimRecordLayer:initTilte()
	self.panelUp = self.rootLayer:getChildByName("panel_up")

	self.panelUp:setTouchEnabled(true)

	for iter_9_0 = 1, 2 do
		self.panelUp:getChildByName("lbl_title_" .. iter_9_0):setString(L_SWIM_RECORD_TITLE)
	end
end

function PopSwimRecordLayer:updateVoteView()
	if not self.voteList or not next(self.voteList) then
		return
	end

	if self.voteView then
		self.voteView:reloadData()

		return
	end

	self.voteView = cc.TableView:create(cc.size(640, 746))

	self.voteView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.voteView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.voteView:setAnchorPoint(cc.p(0, 0))
	self.voteView:setPosition(-21, 53)
	self.voteView:setDelegate()
	self.panelUp:addChild(self.voteView)
	self.voteView:registerScriptHandler(function(arg_12_0, arg_12_1)
		return 640, var_0_0
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.voteView:registerScriptHandler(function(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_0:dequeueCell()

		if not var_11_0 then
			var_11_0 = cc.TableViewCell:create()

			local var_11_2 = self:createVoteSprite(self.voteList[#self.voteList - arg_11_1], arg_11_1 + 1)

			var_11_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_11_2:setPosition(cc.p(320, var_0_0 / 2))
			var_11_0:addChild(var_11_2)
			var_11_0:setLocalZOrder(999 - 10 * arg_11_1)
		else
			self:updateVoteSprite(var_11_0:getChildByTag(100), self.voteList[#self.voteList - arg_11_1], arg_11_1 + 1)
			var_11_0:setLocalZOrder(999 - 10 * arg_11_1)
		end

		return var_11_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.voteView:registerScriptHandler(function(arg_13_0, arg_13_1)
		return #self.voteList
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.voteView:reloadData()
end

function PopSwimRecordLayer.createVoteSprite(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = ccui.ImageView:create("SwimMainLayer/sp_bg.png", var_0_1)

	var_14_0:setTag(100)

	local var_14_1 = ccui.ImageView:create(var_0_5[arg_14_1.vote], var_0_1)

	var_14_1:setPosition(cc.p(80, 50))
	var_14_1:setName("img_vote")
	var_14_0:addChild(var_14_1)

	local var_14_2 = cc.Label:createWithTTF(school_swim_manager:getShowSwimDes(arg_14_1.id), FONT_TITLE, 24)

	var_14_2:setPosition(cc.p(170, 47))
	var_14_2:setAnchorPoint(cc.p(0, 0.5))
	var_14_2:setName("label_time")
	var_14_0:addChild(var_14_2)

	local var_14_3 = ccui.Button:create("SwimMainLayer/btn_show.png", nil, "SwimMainLayer/btn_show.png", var_0_1)

	var_14_3:setPosition(cc.p(500, 50))
	var_14_3:setName("btn_show")
	var_14_0:addChild(var_14_3)
	var_14_3:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		school_swim_manager:get_specific_swim_match(arg_14_1.id)
	end)

	return var_14_0
end

function PopSwimRecordLayer.updateVoteSprite(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_1:getChildByName("img_vote"):loadTexture(var_0_5[arg_16_2.vote], var_0_1)
	arg_16_1:getChildByName("label_time"):setString(school_swim_manager:getShowSwimDes(arg_16_2.id))
	arg_16_1:getChildByName("btn_show"):addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		school_swim_manager:get_specific_swim_match(arg_16_2.id)
	end)
end

function PopSwimRecordLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_19_0, arg_19_1)
		if self.isPlayEffect then
			return
		end

		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_19_0:isBright() then
			return
		end

		arg_19_0:setBright(false)
		self:exit()
	end)
end

function PopSwimRecordLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopSwimRecordLayer:initBg(arg_22_1)
	local var_22_0 = ccui.Layout:create()

	var_22_0:setTouchEnabled(true)
	var_22_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_22_0:setAnchorPoint(cc.p(0, 0))
	var_22_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_22_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_22_0:setOpacity(0)
	self:addChild(var_22_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_23_0)
		self:addChild(arg_23_0, -2)
		arg_23_0:setPositionY(arg_23_0:getPositionY() - GameDisplay.fix_y)

		local var_23_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_23_0:setAnchorPoint(cc.p(0, 0))
		var_23_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_23_0, -1)
		self:init(arg_22_1)
		var_22_0:setOpacity(102)
		var_22_0:setTouchEnabled(false)
	end)
end
