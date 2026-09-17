PopFoolHeadCollectLayter = class("PopFoolHeadCollectLayter", function()
	return PopBaseLayer:create()
end)

local var_0_0 = 17109009
local var_0_1 = "roleimage/role/wuji/"
local item_data = require("data.item_data")
local item_manager = require("controller.item_manager")
local activity_main_conf = require("data.activity_modules.activity_main_conf")
local activity_manager = require("controller.activity_manager")
local var_0_6 = config._DEBUG and 0 or 1

function PopFoolHeadCollectLayter.create(arg_2_0, arg_2_1)
	local var_2_0 = PopFoolHeadCollectLayter.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopFoolHeadCollectLayter:init(arg_3_1)
	print("open poplayer : PopFoolHeadCollectLayter")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopFoolHeadCollectLayter.json" or "PopFoolHeadCollectLayter.ExportJson")

	self.rootLayer:setContentSize(GameDisplay:getScreenSize())
	self.rootLayer:setPositionY(0)
	self:addChild(self.rootLayer)

	self.canGet = true

	self:initData()
	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function PopFoolHeadCollectLayter:initData()
	self.datalist = {}

	for iter_5_0, iter_5_1 in pairs((string.split(require("data.task_data")[var_0_0].need_target_string, ","))) do
		local var_5_0 = item_manager:haveItem(tonumber(iter_5_1))

		if not var_5_0 then
			self.canGet = false
		end

		table.insert(self.datalist, {
			itemid = tonumber(iter_5_1),
			has = var_5_0
		})
	end
end

function PopFoolHeadCollectLayter:initUI()
	self:initBG()
	self:initBottomList()
	self:initListView()
	self:initBtns()
	self:playJoinInEffect()
end

function PopFoolHeadCollectLayter:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end, buttonsList, "PopFoolHeadCollectLayter/return_bg.png", {
		img = "PopFoolHeadCollectLayter/btn_return.png",
		pos = cc.p(100, 50)
	})

	self.bottomList:setName("bottomlist")
	self.rootLayer:addChild(self.bottomList, 10)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end

function PopFoolHeadCollectLayter:initBG()
	local var_9_0 = self.rootLayer:getChildByName("bg")

	var_9_0:loadTexture("mainScenebg/activity/branch171/Activity_Collect_171.jpg")
	var_9_0:setPositionY(GameDisplay.getScreenSize().height / 2 - GameDisplay.fix_y)
	var_9_0:setTouchEnabled(true)

	local var_9_1 = self.rootLayer:getChildByName("title")

	var_9_1:setPositionY(GameDisplay.getScreenSize().height - 80 - GameDisplay.fix_y)

	local var_9_2 = ccui.Button:create("PopFoolHeadCollectLayter/infoBtn.png", nil, "PopFoolHeadCollectLayter/infoBtn.png", var_0_6)

	var_9_2:setPosition(cc.p(380, 50))
	var_9_1:addChild(var_9_2)
	var_9_2:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "fool_head_ollect"
		})
	end)

	self.headView = self.rootLayer:getChildByName("headView")

	self.headView:setAnchorPoint(cc.p(0.5, 1))
	self.headView:setContentSize(cc.size(560, 610 + GameDisplay.height - 1136))
	self.headView:setPosition(cc.p(320, GameDisplay.getScreenSize().height - 130 - GameDisplay.fix_y))

	local var_9_3 = self.rootLayer:getChildByName("panel_bottom")

	var_9_3:setAnchorPoint(cc.p(0, 1))
	var_9_3:setPositionY(self.headView:getPositionY() - self.headView:getContentSize().height - 25)
end

function PopFoolHeadCollectLayter:initListView()
	self.headView:setItemsMargin(0)

	for iter_11_0 = 1, math.ceil(#self.datalist / 3) do
		local var_11_0 = self:createHeadPanel(iter_11_0)

		var_11_0:setScale(0.9)
		self.headView:pushBackCustomItem(var_11_0)
	end
end

function PopFoolHeadCollectLayter:createHeadPanel(arg_12_1)
	local var_12_0 = ccui.Layout:create()

	var_12_0:setContentSize(cc.size(640, 150))

	for iter_12_0 = 1, 3 do
		if self.datalist[(arg_12_1 - 1) * 3 + iter_12_0] then
			local var_12_1 = self:createHeadSprite(self.datalist[(arg_12_1 - 1) * 3 + iter_12_0])

			var_12_1:setPosition(cc.p(80 + 220 * (iter_12_0 - 1), 75))
			var_12_0:addChild(var_12_1)
		end
	end

	return var_12_0
end

function PopFoolHeadCollectLayter.createHeadSprite(arg_13_0, arg_13_1)
	local var_13_0 = ccui.ImageView:create("PopFoolHeadCollectLayter/head_bg.png", var_0_6)
	local var_13_1 = ccui.ImageView:create(var_0_1 .. item_data[arg_13_1.itemid].image_id .. ".png")

	var_13_1:setScale(0.6)
	var_13_1:setPosition(var_13_0:getContentSize().width / 2, var_13_0:getContentSize().height / 2 + 6)
	var_13_0:addChild(var_13_1)
	var_13_1:setTouchEnabled(true)
	var_13_1:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopItemLayer", {
			itemid = arg_13_1.itemid
		})
	end)

	if arg_13_1.has then
		var_13_0:setColor(cc.c3b(255, 255, 255))
	else
		var_13_0:setColor(cc.c3b(111, 111, 111))
	end

	return var_13_0
end

local function var_0_7()
	return item_manager:haveMedal(9104436)
end

function PopFoolHeadCollectLayter:initBtns()
	print(var_0_7())

	local var_16_0 = "PopFoolHeadCollectLayter/btn_null.png"

	if var_0_7() then
		var_16_0 = "PopFoolHeadCollectLayter/btn_got.png"
	elseif self.canGet then
		var_16_0 = "PopFoolHeadCollectLayter/btn_can_get.png"
	end

	local var_16_1 = self.rootLayer:getChildByName("panel_bottom"):getChildByName("btn_get")

	var_16_1:loadTextures(var_16_0, nil, var_16_0, var_0_6)
	var_16_1:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_0_7() then
			return
		end

		if not self.canGet then
			return
		end

		activity_manager:getTaskReward(171, var_0_0, function(arg_18_0, arg_18_1)
			if arg_18_0 ~= 1 then
				return
			end

			global_gain(arg_18_1)
			self:exit()
		end)
	end)
end

function PopFoolHeadCollectLayter:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function PopFoolHeadCollectLayter:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end
