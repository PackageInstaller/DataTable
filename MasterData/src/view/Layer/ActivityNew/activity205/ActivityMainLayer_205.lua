local ActivityMainLayer_205 = class("ActivityMainLayer_205", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local activity_manager = require("controller.activity_manager")
local explore_manager = require("controller.explore_manager")
local time_check_manager = require("controller.time_check_manager")

function ActivityMainLayer_205:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_205.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther()

	return var_2_0
end

function ActivityMainLayer_205:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_205:initOther()
	self:initLockUI()

	if not RoleDefault:getInstance():getBoolForKey("act_205_story", false) then
		RoleDefault:getInstance():setBoolForKey("act_205_story", true)
		global_basic_scene:addChild(TalkLayer:create(30000001, nil, 1, "", nil))
	end
end

function ActivityMainLayer_205:initLockUI()
	local var_5_0 = {
		"btn_question_mask.png",
		"btn_question_mask.png",
		"btn_question_mask.png",
		"btn_question_mask.png"
	}
	local var_5_1 = {
		cc.p(0, 0),
		cc.p(0, 0),
		cc.p(3, 0),
		cc.p(0, 0),
		cc.p(3, 0)
	}
	local var_5_2 = time_check_manager:getCurTime()

	for iter_5_0, iter_5_1 in pairs({
		"btnQuestion1",
		"btnQuestion2",
		"btnQuestion3",
		"btnQuestion4"
	}) do
		if self[iter_5_1] and self[iter_5_1].locktime and var_5_2 < os.time(parse_time(self[iter_5_1].locktime)) then
			self[iter_5_1]:setBright(false)

			local var_5_3 = self[iter_5_1]:getChildByName("mask")

			if var_5_3 then
				var_5_3:removeFromParent()
			end

			local var_5_4 = ccui.ImageView:create(self._path .. var_5_0[iter_5_0])

			var_5_4:setAnchorPoint(cc.p(0, 0))
			var_5_4:setPosition(var_5_1[iter_5_0])
			self[iter_5_1]:addChild(var_5_4)

			if string.find(self[iter_5_1]:getName(), "btnQuestion") then
				local var_5_5 = ccui.Text:create(self[iter_5_1].title, FONT_DES, 20)

				var_5_5:setAnchorPoint(cc.p(1, 0))
				var_5_5:setPosition(cc.p(255, 43))
				var_5_5:setColor(cc.c3b(170, 255, 210))
				var_5_4:addChild(var_5_5)

				local var_5_6 = string_split(string_split(self[iter_5_1].locktime, " ")[1], "-")
				local var_5_7 = ccui.Text:create(string.format(L_DATE_TEXT .. "开启", var_5_6[2], var_5_6[3]), FONT_DES, 24)

				var_5_7:setAnchorPoint(cc.p(1, 0))
				var_5_7:setPosition(cc.p(255, 17))
				var_5_7:setColor(cc.c3b(170, 255, 210))
				var_5_4:addChild(var_5_7)

				local var_5_8 = ccui.ImageView:create(self._path .. "btn_question_lock.png")

				var_5_8:setAnchorPoint(cc.p(0, 0))
				var_5_8:setPosition(cc.p(260, 20))
				var_5_4:addChild(var_5_8)
			end
		end
	end
end

return ActivityMainLayer_205
