Guide3Layer = class("Guide3Layer", function()
	return cc.Layer:create()
end)

function Guide3Layer:ctor()
	local var_2_0 = cc.Director:getInstance():getWinSize()

	self.size = var_2_0

	require("view.Layer.ModelTalkLayer")

	local var_2_1 = ModelTalkLayer:create()

	self:addChild(var_2_1)
	var_2_1:SetTalkLayer(2, function()
		local var_3_0 = cc.Sprite:create("guide/guidShade.png")

		var_3_0:setPosition(var_2_0.width / 2, var_2_0.height / 2)
		var_3_0:setOpacity(0)

		self.clip = require("view.Sprite.ClipSprite").create()

		self:addChild(self.clip)
		self:guideFinger()
		self:event()
	end)
	setSwallowTouchesListenner(self)
end

function Guide3Layer.guideFinger(arg_4_0)
	setFinger(arg_4_0, cc.p(320, 100))
end

function Guide3Layer:event()
	local var_5_0 = ccui.Layout:create()

	var_5_0:setTouchEnabled(true)
	var_5_0:setSize(640, 1136)
	self:addChild(var_5_0)
	var_5_0:addTouchEventListener(function(arg_6_0, arg_6_1)
		if ccui.TouchEventType.ended == arg_6_1 then
			local var_6_0 = self:getChildByTag(FingerSpriteID)
			local var_6_1 = var_6_0:getBoundingBox()

			if cc.rectContainsPoint(cc.rect(var_6_0:getPositionX() - var_6_1.width / 2, var_6_0:getPositionY() - var_6_1.height / 2, var_6_1.width * 1.5, var_6_1.height * 1.5), (arg_6_0:getTouchEndPosition())) then
				PRIORITY_FORCE = 3

				l2d.LAppLive2DManager:getInstance():doModelMotion("player", config.sayHello, 0, PRIORITY_FORCE)
				self:setVisible(false)
				global_basic_scene:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
					self:runAction(cc.RemoveSelf:create(true))
					global_guideRun(TRIGGER_specific, 2)
				end)))
			end
		end
	end)
	var_5_0:setSwallowsTouches(false)
end

function Guide3Layer.create(arg_8_0)
	return (Guide3Layer.new())
end

return Guide3Layer
