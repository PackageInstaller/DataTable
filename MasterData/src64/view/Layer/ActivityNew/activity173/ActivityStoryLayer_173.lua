ActivityStoryLayer_173 = class("ActivityStoryLayer_173", function()
	return cc.Layer:create()
end)

local var_0_1 = 2
local var_0_2 = 3
local var_0_4 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")

function ActivityStoryLayer_173.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityStoryLayer_173.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityStoryLayer_173:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Activity_Story_173.json" or "Activity_Story_173.ExportJson")

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	activity_manager:get_activity_story_info(173, 1)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("ActivityStoryLayer_173")
		end
	end)
end

function ActivityStoryLayer_173.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("ActivityStoryLayer_173", activity_manager.activityEventId.ACTIVITY_STORY_INFO_UPDATE, function(arg_6_0)
		if arg_6_0.showType == 1 and not arg_6_0.chapter then
			arg_5_0:updateStory(arg_6_0.dataList)
		end
	end)
end

function ActivityStoryLayer_173:initUI()
	self:initBtnReturn()
	self:initTitle()
end

function ActivityStoryLayer_173:initBtnReturn()
	self.btnReturn = self.rootLayer:getChildByName("btn_return")

	self.btnReturn:setAnchorPoint(cc.p(0.5, 0))
	self.btnReturn:setPositionY(-GameDisplay.fix_y)
	self.btnReturn:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self.btnBook = self.rootLayer:getChildByName("btn_story_book")

	self.btnBook:setPositionY(self.btnBook:getPositionY() - GameDisplay.fix_y)
	self.btnBook:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActStoryBookLayer")
	end)
end

function ActivityStoryLayer_173:initTitle()
	self.btnDetail = self.rootLayer:getChildByName("btn_title")

	self.btnDetail:setPositionY(self.btnDetail:getPositionY() + GameDisplay.fix_y)
	self.btnDetail:addTouchEventListener(function(arg_12_0, arg_12_1)
		do return end

		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityStoryLayer_173"
		})
	end)
end

function ActivityStoryLayer_173:updateStory(arg_13_1)
	for iter_13_0 = 1, 5 do
		local var_13_0 = self.rootLayer:getChildByName("btn_story_" .. iter_13_0)
		local var_13_1 = var_13_0:getChildByName("des")

		var_13_1:setString(arg_13_1[iter_13_0].des)

		if true or arg_13_1[iter_13_0].stat ~= var_0_2 then
			if arg_13_1[iter_13_0].stat == var_0_1 then
				var_13_0:loadTextures("Activity_Story_173/btn_story_lock_" .. iter_13_0 .. ".png", nil, "Activity_Story_173/btn_story_lock_" .. iter_13_0 .. ".png", var_0_4)
				var_13_1:setVisible(true)

				goto label_13_0
			end
		end

		var_13_0:loadTextures("Activity_Story_173/btn_story_" .. iter_13_0 .. ".png", nil, "Activity_Story_173/btn_story_" .. iter_13_0 .. ".png", var_0_4)
		var_13_1:setVisible(false)

		::label_13_0::

		var_13_0:addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopActStoryInfoLayer", {
				index = iter_13_0
			})
		end)
	end
end
