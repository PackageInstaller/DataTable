StoryModesLayer = class("StoryModesLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")

local alert_manager = require("controller.alert_manager")
local time_check_manager = require("controller.time_check_manager")
local var_0_2
local var_0_3 = config._DEBUG and 0 or 1
local var_0_4 = {
	{
		layerName = "BianhuaStoryLayer",
		imgPath = "StoryModesLayer/bianhua.png",
		starttime = IS_SHOW_ACTIVITY_STORY and "2020-09-22 00:00:00" or "2030-09-22 00:00:00"
	},
	{
		starttime = "2020-09-22 00:00:00",
		layerName = "AvalonStoryLayer",
		imgPath = "StoryModesLayer/avalon.png"
	},
	{
		starttime = "2020-09-22 00:00:00",
		layerName = "LamiaStoryLayer",
		imgPath = "StoryModesLayer/lamiya.png"
	}
}
local var_0_5

function StoryModesLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = StoryModesLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function StoryModesLayer.getInstance()
	return var_0_2
end

function StoryModesLayer:init(arg_4_1)
	var_0_2 = self
	var_0_5 = {}

	for iter_4_0, iter_4_1 in ipairs(var_0_4) do
		if not iter_4_1.starttime or iter_4_1.starttime and time_check_manager:getCurTime() >= global_get_time_by_date(iter_4_1.starttime) then
			table.insert(var_0_5, iter_4_1)
		end
	end

	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootLayer)

	self.topPanel = TitleSprite:create("StoryModesLayer/title.png", 2)

	self.topPanel:setPosition(cc.p(0, GameDisplay.getUiScreenSize().height - 56))
	self.rootLayer:addChild(self.topPanel)

	self.bottomPanel = BottomBtnList:create((arg_4_1 and arg_4_1.returncallback or nil) and (arg_4_1.returncallback or function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer("AdventureLayer")
	end))

	self.rootLayer:addChild(self.bottomPanel, 0)
	self:initList()
end

local var_0_6 = 640
local var_0_7 = 300

function StoryModesLayer:initList()
	self.roleTableViewhight = GameDisplay.height - self.topPanel:getContentSize().height - self.bottomPanel:getContentSize().height
	self.roleTableView = cc.TableView:create(cc.size(640, self.roleTableViewhight))

	self.roleTableView:setPosition(cc.p(0, 90))
	self.roleTableView:setDelegate()
	self.roleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.rootLayer:addChild(self.roleTableView)
	self.roleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.roleTableView:registerScriptHandler(function(arg_8_0, arg_8_1)
		return var_0_6, var_0_7
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0:dequeueCell()

		if not var_7_0 then
			var_7_0 = cc.TableViewCell:create()

			var_7_0:setName("cell_node")

			local var_7_1 = self:createNode(arg_7_1 + 1)

			var_7_1.index = arg_7_1 + 1

			var_7_1:setName("btn_node_" .. arg_7_1 + 1)
			var_7_1:setPosition(cc.p(var_0_6 / 2, 0))

			if arg_7_1 <= math.floor(self.roleTableViewhight / var_0_7) then
				var_7_1:setOpacity(0)
				var_7_1:runAction(cc.Sequence:create(cc.DelayTime:create(0.05 * arg_7_1), cc.FadeIn:create(0.1)))
			else
				var_7_1:setOpacity(255)
			end

			var_7_0:addChild(var_7_1)
		else
			local var_7_2 = var_7_0:getChildByName("btn_node_" .. arg_7_1 + 1)

			var_7_2:setOpacity(255)

			var_7_2.index = arg_7_1 + 1

			self:updateNode(var_7_2, arg_7_1 + 1)
		end

		return var_7_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.roleTableView:registerScriptHandler(function(arg_9_0, arg_9_1)
		return #var_0_5
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.roleTableView:reloadData()
end

function StoryModesLayer:createNode(arg_10_1)
	local var_10_0 = var_0_5[arg_10_1].layerName
	local var_10_1 = ccui.Button:create(var_0_5[arg_10_1].imgPath, "", var_0_5[arg_10_1].imgPath, var_0_3)

	var_10_1:setAnchorPoint(cc.p(0.5, 0))
	var_10_1:setSwallowTouches(false)
	var_10_1:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_11_0:getTouchBeganPosition().y - arg_11_0:getTouchEndPosition().y) > 50 then
			return
		end

		LayerManager:switchShowLayer(var_10_0)
	end)
	self:checkAlert(var_10_1, var_0_5[arg_10_1].layerName)

	return var_10_1
end

function StoryModesLayer:updateNode(arg_12_1, arg_12_2)
	arg_12_1:loadTextures(var_0_5[arg_12_2].imgPath, "", var_0_5[arg_12_2].imgPath, var_0_3)
	self:checkAlert(arg_12_1, var_0_5[arg_12_2].layerName)
end

function StoryModesLayer.checkAlert(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {
		BianhuaStoryLayer = function()
			if not RoleDefault:getInstance():getBoolForKey("BianhuaStoryLayer_first", false) then
				alert_manager:add_new_mark(arg_13_1, true, cc.p(arg_13_1:getContentSize().width - 20, arg_13_1:getContentSize().height - 15))
			end
		end
	}

	if var_13_0[arg_13_2] then
		var_13_0[arg_13_2]()
	end
end
