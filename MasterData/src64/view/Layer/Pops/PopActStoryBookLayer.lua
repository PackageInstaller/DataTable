PopActStoryBookLayer = class("PopActStoryBookLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local servant_data = require("data.servant_data")
local activity_manager = require("controller.activity_manager")
local activity_main_conf = require("data.activity_modules.activity_main_conf")
local var_0_5 = 2
local var_0_6 = 3

function PopActStoryBookLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopActStoryBookLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopActStoryBookLayer:init(arg_3_1)
	print("open poplayer : PopActStoryBookLayer")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopActStoryBookLayer.json" or "PopActStoryBookLayer.ExportJson")

	self.rootLayer:setContentSize(GameDisplay:getScreenSize())
	self.rootLayer:setPositionY(0)
	self:addChild(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	activity_manager:get_activity_story_info(173, 2)
	activity_manager:get_activity_story_info(173, 3)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("PopActStoryBookLayer")
		end
	end)
end

function PopActStoryBookLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("PopActStoryBookLayer", activity_manager.activityEventId.ACTIVITY_STORY_INFO_UPDATE, function(arg_6_0)
		print(dump(arg_6_0))

		if arg_6_0.showType == 2 then
			arg_5_0:updateSoulBtn(arg_6_0.dataList)
		elseif arg_6_0.showType == 3 then
			arg_5_0:updateAllBtn(arg_6_0.dataList)
		end
	end)
end

function PopActStoryBookLayer:initUI()
	self:initExitTouchEvent()
	self:playJoinInEffect()
end

function PopActStoryBookLayer:initExitTouchEvent()
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

	self.panelBg = self.rootLayer:getChildByName("panel_bg")

	self.panelBg:getChildByName("btn_close"):addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_10_0:isBright() then
			return
		end

		arg_10_0:setBright(false)
		self:exit()
	end)
end

local var_0_8 = {
	27720,
	27620,
	27820
}

function PopActStoryBookLayer:updateSoulBtn(arg_11_1)
	if not arg_11_1 or not next(arg_11_1) then
		return
	end

	for iter_11_0 = 1, 3 do
		local var_11_0 = self.panelBg:getChildByName("soul_" .. iter_11_0)
		local var_11_1 = self.panelBg:getChildByName("btn_show_" .. iter_11_0)
		local var_11_2 = self.panelBg:getChildByName("btn_soul_" .. iter_11_0)
		local var_11_3 = var_11_0:getChildByName("lock")
		local var_11_4 = var_11_0:getChildByName("lbl_name")

		var_11_3:getChildByName("lbl_name"):setString(arg_11_1[iter_11_0].name)
		var_11_4:setString(arg_11_1[iter_11_0].name)
		var_11_3:getChildByName("btn_twist"):addTouchEventListener(function(arg_12_0, arg_12_1)
			local var_12_0

			if arg_12_1 ~= ccui.TouchEventType.ended then
				do return end

				var_12_0 = {}
			end

			var_12_0.jump_to_system = activity_manager:get_activity_story_jump(173, arg_11_1[iter_11_0].id)

			goto_complete_system(var_12_0)
		end)

		if arg_11_1[iter_11_0].stat == var_0_5 or arg_11_1[iter_11_0].stat == var_0_6 then
			var_11_3:setVisible(true)
			var_11_1:loadTextures("PopActStoryBookLayer/btn_play_lock_1.png", nil, "PopActStoryBookLayer/btn_play_lock_1.png", var_0_0)
		else
			var_11_3:setVisible(false)
			var_11_1:loadTextures("PopActStoryBookLayer/btn_play_1.png", nil, "PopActStoryBookLayer/btn_play_lock_1.png", var_0_0)
		end

		var_11_2:addTouchEventListener(function(arg_13_0, arg_13_1)
			local var_13_0

			if arg_13_1 ~= ccui.TouchEventType.ended then
				do return end

				var_13_0 = {
					PhotoFileLayer = 1,
					contentType = {
						contentType = "file_player"
					},
					id = 101 + iter_11_0,
					modelid = servant_data[var_0_8[iter_11_0]].modelid
				}
			end

			var_13_0.servantid = var_0_8[iter_11_0]

			LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_13_0)
		end)

		local function var_11_5(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_11_1[iter_11_0].stat == var_0_5 or arg_11_1[iter_11_0].stat == var_0_6 then
				return
			end

			global_basic_scene:addChild(TalkLayer:create(arg_11_1[iter_11_0].talkid, nil, TALK_TYPE_FAVOR, "", function(arg_15_0, arg_15_1)
				activity_manager:get_activity_story_reward(173, arg_11_1[iter_11_0].id, nil, nil, arg_15_1)
			end), ZORDER_TALKLAYER)
		end

		var_11_1:addTouchEventListener(var_11_5)
		var_11_0:addTouchEventListener(var_11_5)
	end
end

function PopActStoryBookLayer:updateAllBtn(arg_16_1)
	if not arg_16_1 or not next(arg_16_1) then
		return
	end

	local var_16_0 = arg_16_1[1]
	local var_16_1 = self.panelBg:getChildByName("soul_book")
	local var_16_2 = var_16_1:getChildByName("lcok")
	local var_16_3 = var_16_2:getChildByName("Label")
	local var_16_4 = self.panelBg:getChildByName("btn_play_all")

	if arg_16_1[1].stat == var_0_5 or var_16_0.stat == var_0_6 then
		var_16_2:setVisible(true)
		var_16_4:loadTextures("PopActStoryBookLayer/btn_play_lock_2.png", nil, "PopActStoryBookLayer/btn_play_lock_2.png", var_0_0)
	else
		var_16_2:setVisible(false)
		var_16_4:loadTextures("PopActStoryBookLayer/btn_play_2.png", nil, "PopActStoryBookLayer/btn_play_lock_2.png", var_0_0)
	end

	local function var_16_5(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_16_0.stat == var_0_5 or var_16_0.stat == var_0_6 then
			return
		end

		global_basic_scene:addChild(TalkLayer:create(var_16_0.talkid, nil, TALK_TYPE_FAVOR, "", function(arg_18_0, arg_18_1)
			activity_manager:get_activity_story_reward(173, var_16_0.id, nil, nil, arg_18_1)
		end), ZORDER_TALKLAYER)
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "lbl_title"):setString(var_16_0.name)
	var_16_1:addTouchEventListener(var_16_5)
	var_16_4:addTouchEventListener(var_16_5)
end

function PopActStoryBookLayer:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function PopActStoryBookLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopActStoryBookLayer:initBg(arg_22_1)
	local var_22_0 = ccui.Layout:create()

	var_22_0:setTouchEnabled(true)
	var_22_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_22_0:setAnchorPoint(cc.p(0, 0))
	var_22_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_22_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_22_0:setBackGroundColor(cc.c3b(2, 5, 24))
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
