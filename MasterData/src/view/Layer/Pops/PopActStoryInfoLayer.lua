PopActStoryInfoLayer = class("PopActStoryInfoLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local activity_main_conf = require("data.activity_modules.activity_main_conf")
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3
local var_0_6 = 4

function PopActStoryInfoLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopActStoryInfoLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopActStoryInfoLayer:init(arg_3_1)
	print("open poplayer : PopActStoryInfoLayer")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopActStoryInfoLayer.json" or "PopActStoryInfoLayer.ExportJson")

	self.rootLayer:setContentSize(GameDisplay:getScreenSize())
	self.rootLayer:setPositionY(0)
	self:addChild(self.rootLayer)

	self.index = arg_3_1.index

	self:initUI()
	self:registerActivityEventListener()
	activity_manager:get_activity_story_info(173, 1, self.index)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopActStoryInfoLayer")
		end
	end)
end

function PopActStoryInfoLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("PopActStoryInfoLayer", activity_manager.activityEventId.ACTIVITY_STORY_INFO_UPDATE, function(arg_6_0)
		if arg_6_0.showType == 1 and arg_6_0.chapter then
			arg_5_0:updateStoryBtn(arg_6_0.dataList)
		end
	end)
end

function PopActStoryInfoLayer:initUI()
	self:initExitTouchEvent()
	self:playJoinInEffect()
end

function PopActStoryInfoLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_9_0:isBright() then
			return
		end

		arg_9_0:setBright(false)
		self:exit()
	end)

	self.panelBg = self.rootLayer:getChildByName("bg")

	self.panelBg:setTouchEnabled(true)
	self.panelBg:getChildByName("title"):loadTexture("PopActStoryInfoLayer/title" .. self.index .. ".png", var_0_0)
end

function PopActStoryInfoLayer:updateStoryBtn(arg_10_1)
	for iter_10_0 = 1, 5 do
		local var_10_0 = self.panelBg:getChildByName("btn_" .. iter_10_0)
		local var_10_1 = var_10_0:getChildByName("icon")
		local var_10_2 = var_10_0:getChildByName("line")
		local var_10_3 = var_10_0:getChildByName("sp")
		local var_10_4 = var_10_0:getChildByName("title")
		local var_10_5 = var_10_0:getChildByName("des")

		if arg_10_1[iter_10_0] then
			var_10_0:setVisible(true)

			if arg_10_1[iter_10_0].stat == var_0_3 or arg_10_1[iter_10_0].stat == var_0_6 then
				var_10_5:setColor(cc.c3b(54, 66, 102))
				var_10_4:setColor(cc.c3b(54, 66, 102))
				var_10_0:loadTextures("PopActStoryInfoLayer/sp_bg_1.png", nil, "PopActStoryInfoLayer/sp_bg_1.png", var_0_0)
			else
				var_10_5:setColor(cc.c3b(182, 198, 245))
				var_10_4:setColor(cc.c3b(182, 198, 245))
				var_10_0:loadTextures("PopActStoryInfoLayer/sp_bg_2.png", nil, "PopActStoryInfoLayer/sp_bg_2.png", var_0_0)
			end

			if arg_10_1[iter_10_0].stat == var_0_6 then
				var_10_1:loadTexture("PopActStoryInfoLayer/icon_2.png", var_0_0)
				var_10_2:loadTexture("PopActStoryInfoLayer/line_2.png", var_0_0)
			else
				var_10_1:loadTexture("PopActStoryInfoLayer/icon_1.png", var_0_0)
				var_10_2:loadTexture("PopActStoryInfoLayer/line_1.png", var_0_0)
			end

			var_10_3:loadTexture("PopActStoryInfoLayer/sp_" .. self.index .. ".png", var_0_0)
			var_10_4:setString(arg_10_1[iter_10_0].name)
			var_10_5:setString(arg_10_1[iter_10_0].simple or "")
			var_10_2:setVisible(arg_10_1[iter_10_0 + 1] ~= nil)
			var_10_0:addTouchEventListener(function(arg_11_0, arg_11_1)
				if arg_11_1 ~= ccui.TouchEventType.ended then
					return
				end

				if arg_10_1[iter_10_0].stat == var_0_5 then
					return
				end

				if arg_10_1[iter_10_0].stat == var_0_4 then
					return
				end

				global_basic_scene:addChild(TalkLayer:create(arg_10_1[iter_10_0].talkid, nil, TALK_TYPE_FAVOR, "", function(arg_12_0, arg_12_1)
					activity_manager:get_activity_story_reward(173, arg_10_1[iter_10_0].id, 1, (arg_10_1[iter_10_0 + 1] ~= nil or nil) and (self.index or nil), arg_12_1)
				end), ZORDER_TALKLAYER)
			end)
		else
			var_10_0:setVisible(false)
		end
	end
end

function PopActStoryInfoLayer:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function PopActStoryInfoLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopActStoryInfoLayer:initBg(arg_16_1)
	local var_16_0 = ccui.Layout:create()

	var_16_0:setTouchEnabled(true)
	var_16_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_16_0:setAnchorPoint(cc.p(0, 0))
	var_16_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_16_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_16_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_16_0:setOpacity(0)
	self:addChild(var_16_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_17_0)
		self:addChild(arg_17_0, -2)
		arg_17_0:setPositionY(arg_17_0:getPositionY() - GameDisplay.fix_y)

		local var_17_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_17_0:setAnchorPoint(cc.p(0, 0))
		var_17_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_17_0, -1)
		self:init(arg_16_1)
		var_16_0:setOpacity(102)
		var_16_0:setTouchEnabled(false)
	end)
end
