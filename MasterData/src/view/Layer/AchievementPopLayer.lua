AchievementPopLayer = class("AchievementPopLayer", function()
	return cc.Layer:create()
end)

local autopop_manager = require("controller.autopop_manager")
local item_data = require("data.item_data")
local audio_manager = require("controller.audio_manager")
local var_0_3 = 1
local var_0_6 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_7 = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 0, 0, 150)
}

function AchievementPopLayer.create(arg_2_0)
	local var_2_0 = AchievementPopLayer.new()

	var_2_0:init()

	return var_2_0
end

function AchievementPopLayer:init()
	self.status = var_0_3
	self.touchEnable = true

	local var_3_0 = ccui.Layout:create()

	var_3_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_0:setName("fullScreenMask")
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_3_0:setBackGroundColorOpacity(180)
	var_3_0:setPosition(0, 0)
	var_3_0:setTouchEnabled(true)
	var_3_0:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.touchEnable == false then
			return
		end

		self.touchEnable = false

		self:stopAllActions()

		if self:queueEmpty() == false then
			self:runAction(cc.RemoveSelf:create())

			return
		end

		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
			autopop_manager:deachievementQueue()

			if autopop_manager:getAchievementStatus() ~= var_0_3 then
				self:runAction(cc.RemoveSelf:create())
				self:stopAllActions()
			else
				self:judgeShow()
			end
		end), cc.CallFunc:create(function()
			if self:queueEmpty() ~= false then
				self:showAchievementPop(self.queue[1].title, self.queue[1].content, (tonumber(self.queue[1].medal or "9100011")))
			end

			self.touchEnable = true
		end)))
	end)
	self:addChild(var_3_0)

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "AchievementPopLayer.json" or "AchievementPopLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self.rootLayer:setPosition(GameDisplay.fix_x, GameDisplay.fix_y)
	self:addChild(self.rootLayer)

	self.panel = var_3_0
	self.panelContent = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_content")
	self.title = ccui.Helper:seekWidgetByName(self.rootLayer, "label_title")
	self.content = ccui.Helper:seekWidgetByName(self.rootLayer, "label_content")
	self.icon_bg = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_9")

	if config._DEBUG then
		self.effectLight = cc.Scale9Sprite:create("AchievementPop/effect_light.png") or cc.Scale9Sprite:createWithSpriteFrameName("AchievementPop/effect_light.png")
	end

	self.effectLight:setPosition(cc.p(320, 750))
	self.rootLayer:addChild(self.effectLight, 5)
	self.panelContent:setPositionY(85)

	self.icon = self:createMedalIcon(9100011)

	self.icon:setPosition(cc.p(self.icon_bg:getContentSize().width / 2, self.icon_bg:getContentSize().height / 2))
	self.icon_bg:addChild(self.icon)

	self.queue = autopop_manager:getachievementQueue()

	self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		if self:queueEmpty() == true then
			self:judgeShow()
		else
			self:runAction(cc.RemoveSelf:create())
		end
	end), cc.DelayTime:create(0.6)))
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" and callback then
			callback()
		end
	end)
end

function AchievementPopLayer:judgeShow()
	if self:queueEmpty() == false then
		self:runAction(cc.RemoveSelf:create())

		return
	end

	local var_9_0 = self.queue[1].title
	local var_9_1 = self.queue[1].content
	local var_9_2 = tonumber(self.queue[1].medal or "9100011")

	self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		self:showAchievementPop(var_9_0, var_9_1, var_9_2)
	end), cc.DelayTime:create(3), cc.CallFunc:create(function()
		autopop_manager:deachievementQueue()

		if autopop_manager:getAchievementStatus() ~= var_0_3 then
			self:runAction(cc.RemoveSelf:create())
		else
			self:judgeShow()
		end
	end)))
end

function AchievementPopLayer:queueEmpty()
	if next(self.queue) ~= nil then
		return true
	else
		return false
	end
end

function AchievementPopLayer:showAchievementPop(arg_13_1, arg_13_2, arg_13_3)
	self.panel:setVisible(true)
	self.panel:setOpacity(255)
	self.effectLight:setVisible(false)
	self.effectLight:setOpacity(255)
	self.panelContent:setVisible(false)
	self.title:setString(arg_13_1)
	self.content:setString(arg_13_2)

	if arg_13_3 then
		self.icon:setTexture(var_0_6[item_data[arg_13_3].equip_quality])
		self.icon:getChildByName("medal"):setString(item_data[arg_13_3].name)
	end

	self:showAction()
end

function AchievementPopLayer:showAction()
	audio_manager:playeffectMusicTest("sound/achievement")
	self.effectLight:setVisible(true)
	self.effectLight:setCapInsets(cc.rect(70, 50, 5, 20))
	self.effectLight:setPreferredSize(cc.size(800, 118))
	self.effectLight:setScale(0.1, 1)
	self.effectLight:runAction(cc.Sequence:create(cc.ScaleTo:create(0.3, 1, 1), cc.FadeOut:create(0.5)))
	self.panel:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		self.panelContent:setVisible(true)
		self.panelContent:setScale(0.8)
		self.panelContent:runAction(cc.ScaleTo:create(0.5, 1, 1))
	end), cc.DelayTime:create(2), cc.FadeOut:create(0.5)))
end

function AchievementPopLayer.createMedalIcon(arg_16_0, arg_16_1)
	local var_16_0 = cc.Sprite:create(var_0_6[item_data[arg_16_1].equip_quality])

	var_16_0:setCascadeOpacityEnabled(true)

	local var_16_1 = cc.Label:createWithTTF(item_data[arg_16_1].name, FONT_DES, 54)

	var_16_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_16_1:setPosition(cc.p(var_16_0:getContentSize().width / 2, var_16_0:getContentSize().height / 2))
	var_16_1:enableOutline(var_0_7[item_data[arg_16_1].equip_quality], 1)
	var_16_1:enableShadow(var_0_7[item_data[arg_16_1].equip_quality], cc.size(0, 0))
	var_16_1:setName("medal")
	var_16_0:addChild(var_16_1)

	return var_16_0
end
