local WeaponBreakAnimationLayer = class("WeaponBreakAnimationLayer", (require("view.Layer.BaseUILayer")))
local audio_manager = require("controller.audio_manager")
local model_manager = require("controller.model_manager")
local component_manager = require("controller.component_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local weapon_manager = require("controller.weapon_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_9 = config._DEBUG and 0 or 1

function WeaponBreakAnimationLayer:ctor()
	WeaponBreakAnimationLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/weapon_break_animation_manager"):getInstance()
	self._isQuit = false
end

function WeaponBreakAnimationLayer:create(arg_2_1)
	local var_2_0 = WeaponBreakAnimationLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function WeaponBreakAnimationLayer:onEnter()
	WeaponBreakAnimationLayer.super.onEnter(self)
	audio_manager:playeffectMusic("weapon_starup")
end

function WeaponBreakAnimationLayer:onExit()
	WeaponBreakAnimationLayer.super.onExit(self)

	if not self._isQuit then
		self._isQuit = true

		local var_4_0 = model_manager.new()

		var_4_0:initPlayerAttribute(self._servantId)

		local var_4_1, var_4_2 = component_manager:getSoulComponentlist(self._servantId)

		var_4_0:updateComponentAttr(var_4_1)
		fight_capacity_manager:displaySoulAttrChangeValue(nil, nil, var_4_0)
	end
end

function WeaponBreakAnimationLayer:init(arg_5_1)
	self._servantId = arg_5_1.servantId

	self:initLayer()
	self:initListener()

	return true
end

function WeaponBreakAnimationLayer:initLayer()
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:_setBack()
	var_6_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_6_0:setBackGroundColorOpacity(220)
	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	local var_6_1 = playermodel.items[playermodel.weaponId[self._servantId]]
	local var_6_2 = L2Skeleton:create("spine/ui/weapon_up_quality/weapon_up.json", "spine/ui/weapon_up_quality/weapon_up.atlas")

	var_6_2:refreshSkeleton()
	var_6_2:setSlotTexture("wuqi", "diergewuqi", "weaponIcon/" .. item_data[playermodel.items[playermodel.weaponId[self._servantId]].itemid].image_id .. ".png")
	var_6_2:setSlotTexture("wuqi", "wuqishengjiewuqi", "weaponIcon/weapon_blue_shadow/" .. item_data[playermodel.items[playermodel.weaponId[self._servantId]].itemid].image_id .. ".png")
	var_6_2:setSlotTexture("wuqikuang", "wuqishengjiewuqikuang", "weaponIcon/weapon_bg_red.png")
	var_6_2.skeletonAnimation:setPosition(cc.p(var_6_0:size().w / 2, var_6_0:size().h / 2 + 60))
	var_6_2:play("weapon_up", false)
	var_6_0:addChild(var_6_2, 10000)

	local function var_6_3()
		local var_7_0 = {}

		for iter_7_0 = 1, item_data[var_6_1.itemid].max_star do
			local var_7_1 = ccui.ImageView:create("public/currency/weapon_star_empty.png", var_0_9)

			var_7_1:setPosition(cc.p(var_6_0:size().w / 2 + (iter_7_0 - (item_data[var_6_1.itemid].max_star + 1) / 2) * (var_7_1:getContentSize().width - 10), 620))
			table.insert(var_7_0, var_7_1)
			var_7_1:setVisible(false)
			var_6_0:addChild(var_7_1, 100000)
		end

		for iter_7_1, iter_7_2 in pairs(var_7_0) do
			var_7_0[iter_7_1]:setScale(8)
			var_7_0[iter_7_1]:runAction(cc.Sequence:create(cc.DelayTime:create(iter_7_1 / 30), cc.CallFunc:create(function()
				var_7_0[iter_7_1]:setVisible(true)
			end), cc.Spawn:create(cc.RotateBy:create(0.55, 72), cc.Sequence:create(cc.ScaleTo:create(0.15, 1, 1), cc.ScaleTo:create(0.25, 2, 2), cc.ScaleTo:create(0.15, 1, 1)))))
		end
	end

	local var_6_4 = false

	var_6_0:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		var_6_3()
		var_6_2:play("weapon_up_stay", true)

		var_6_4 = true
	end), cc.DelayTime:create(2), cc.CallFunc:create(function()
		KeyCodeManager:onKeyReleasedCallFunc()

		if not self._isQuit then
			self._isQuit = true

			local var_10_0 = model_manager.new()

			var_10_0:initPlayerAttribute(self._servantId)

			local var_10_1, var_10_2 = component_manager:getSoulComponentlist(self._servantId)

			var_10_0:updateComponentAttr(var_10_1)

			if playermodel.haveServant[self._servantId] and playermodel.weaponId[self._servantId] then
				var_10_0:updateWeaponAttr((weapon_manager:getWeaponConfig(playermodel.items[playermodel.weaponId[self._servantId]])))
			end

			fight_capacity_manager:displaySoulAttrChangeValue(nil, nil, var_10_0)
		end
	end)))
end

function WeaponBreakAnimationLayer:initListener()
	self._root:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function WeaponBreakAnimationLayer:updateLayer()
	return
end

function WeaponBreakAnimationLayer:updateRed()
	return
end

return WeaponBreakAnimationLayer
