local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local model_data = require("data.model_data")
local tween = require("fight.tween")

GuideExplain = class("GuideExplain", function()
	return ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "GuideCom.json" or "GuideCom.ExportJson")
end)

function GuideExplain.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
	local var_2_0 = GuideExplain.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)

	return var_2_0
end

function GuideExplain:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7)
	arg_3_2 = arg_3_2 or 13100

	self:createHeadIcon(arg_3_2, arg_3_3)
	self:initGuidePos(arg_3_4, arg_3_5, arg_3_6)
	self:initPanelParams(arg_3_1)
	self:playSound(arg_3_7)
	self:show()
end

local function var_0_5(arg_4_0)
	if not arg_4_0 then
		return nil
	end

	local var_4_0, var_4_1 = arg_4_0:match("([^,]+),(.+)")

	return cc.p(checknumber(var_4_0), checknumber(var_4_1))
end

function GuideExplain.createHeadIcon(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = var_0_5(arg_5_2) or cc.p(-210, -395)
	local var_5_1 = ccui.Helper:seekWidgetByName(arg_5_0, "roleimage")

	var_5_1:loadTexture(ROLE_IMAGE_PATH .. model_data[arg_5_1].role_image .. ".png")
	var_5_1:setPosition(var_5_0)
	ccui.Helper:seekWidgetByName(arg_5_0, "rolename"):setString(model_data[arg_5_1].name)
end

function GuideExplain.initPanelParams(arg_6_0, arg_6_1)
	local var_6_0 = ccui.Helper:seekWidgetByName(arg_6_0, "wordpanel")

	if string.find(arg_6_1, "^%b<>.+%b<>$") then
		arg_6_0.isrichtext = true

		local var_6_1 = require("view.Sprite.RichTextPro"):create()

		var_6_1:setMaxWidth(400)
		var_6_1:setName("word")
		var_6_1:setSize(24)
		var_6_1:setLineSpace(0)
		var_6_1:setText(arg_6_1, nil, true)

		local var_6_2, var_6_3 = var_6_1:getContentSize()

		var_6_1:setPosition(cc.p(50, var_6_0:getChildByName("wordbg"):getContentSize().height / 2 + var_6_3 / 2))
		var_6_0:getChildByName("wordbg"):addChild(var_6_1, 100000)
	else
		arg_6_0.isrichtext = false

		local var_6_4 = cc.Label:createWithTTF(arg_6_1, "fonts/number.ttf", 24)

		var_6_4:setName("word")
		var_6_4:setAnchorPoint(cc.p(0, 0.5))
		var_6_4:setPosition(cc.p(50, var_6_0:getChildByName("wordbg"):getContentSize().height / 2))
		var_6_4:setMaxLineWidth(400)
		var_6_4:setVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		var_6_4:setHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
		var_6_4:setLineBreakWithoutSpace(true)
		var_6_0:getChildByName("wordbg"):addChild(var_6_4)
	end
end

function GuideExplain:initGuidePos(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_3 then
		self:setPosition(var_0_5(arg_7_3))

		return
	end

	if not arg_7_1 then
		self:setPositionY(200)

		return
	end

	if arg_7_1.y - arg_7_2.height / 2 > 686 then
		self:setPositionY(200)
	else
		self:setPositionY(arg_7_1.y + arg_7_2.height / 2 + 50)
	end
end

function GuideExplain:show()
	local var_8_0 = ccui.Helper:seekWidgetByName(self, "wordpanel")
	local var_8_1 = var_8_0:getContentSize()
	local var_8_2 = {
		width = 0
	}
	local var_8_3 = tween.new(0.6, var_8_2, {
		width = var_8_1.width
	}, "outBounce")

	var_8_0:setContentSize(cc.size(0, var_8_1.height))
	self:scheduleUpdateWithPriorityLua(function(arg_9_0)
		if var_8_3:update(arg_9_0) then
			self:unscheduleUpdate()
		end

		var_8_0:setContentSize(cc.size(var_8_2.width, var_8_1.height))
	end, 0)
end

local var_0_6 = {}

function GuideExplain.playSound(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	var_0_6[playermodel.playerid] = var_0_6[playermodel.playerid] or {}

	if not var_0_6[arg_10_1] then
		audio_manager:stopAllRoleSound()

		var_0_6[arg_10_1] = arg_10_1

		audio_manager:playPlayerSound("sound/role_voice/" .. arg_10_1)
	end
end
