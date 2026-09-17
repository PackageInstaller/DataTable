ChestLayer = class("ChestLayer", function()
	return cc.Layer:create()
end)

local audio_manager = require("controller.audio_manager")

require("view.Sprite.GlobalFightSpeedup")

function ChestLayer.create(arg_2_0)
	local var_2_0 = ChestLayer.new()

	var_2_0:init()

	return var_2_0
end

function ChestLayer:update(arg_3_1)
	if self.timeCount > 14 then
		self:removeFromParent()

		return
	end

	self.timeCount = self.timeCount + arg_3_1

	local var_3_0 = self.chestani:getBone("Layer6"):getNodeToArmatureTransform()
	local var_3_1, var_3_2 = self.chestani:getPosition()

	self.chest:setPosition(cc.p(var_3_0[13] + var_3_1, var_3_0[14] + var_3_2))
end

function ChestLayer:init(arg_4_1, arg_4_2)
	self.timeCount = 0
	self.chest = ccui.Button:create("public/hunyin_role.png", "public/hunyin_role.png", "public/hunyin_role.png", config._DEBUG and 0 or 1)

	self.chest:setOpacity(0)
	self:addChild(self.chest, 1)
	ccs.ArmatureDataManager:getInstance():addArmatureFileInfo("ChestAni/ChestAni.ExportJson")

	self.chestani = ccs.Armature:create("ChestAni")

	self.chestani:setPosition(cc.p(270 + math.random() * 100, 368))
	self.chestani:getAnimation():play("ChestAni")
	self:addChild(self.chestani)
	self.chest:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 == ccui.TouchEventType.ended then
			if not arg_5_0:isBright() then
				return
			end

			arg_5_0:setBright(false)
			self:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.RemoveSelf:create()))
			audio_manager:playeffectMusic(BUTTON_EFFECT)

			local var_5_0 = GlobalFightSpeedup:create()

			if SmallFightLayer and SmallFightLayer.getInstance() then
				var_5_0:setPosition(cc.p(600, 160))
				SmallFightLayer.getInstance():addChild(var_5_0, 1)
			end

			global_ShowBlockWords(L_CHEST_LAYER.Text, RISE_WORDS_SUCCESS)
		end
	end)

	self.scheduleid = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_6_0)
		self:update(arg_6_0)
	end, 0, false)

	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduleid)
		end
	end)

	return true
end
