local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local total_skill_data = require("data.total_skill_data")
local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local GuideFightConfig = require("view.Layer.NewGuide.GuideFightConfig")
local audio_manager = require("controller.audio_manager")
local array_manager = require("controller.array_manager")
local level_manager = require("controller.level_manager")
local horcrux_manager = require("controller.horcrux_manager")
local hexie_manager = require("controller.hexie_manager")
local l2utils = require("controller.l2utils")
local var_0_12 = config._DEBUG and 0 or 1
local var_0_13 = "role/fight/"
local var_0_14 = "expression/fight/"
local var_0_16 = {
	BAR_TOP1 = "FightLayer/xp_bar_top1.png",
	BAR_BG1 = "FightLayer/xp_bar_bg1.png",
	EFFECT_ATLAS_MID1 = "spine/ui/fight/mid/jinengqian.atlas",
	BAR_BG2 = "FightLayer/xp_bar_bg2.png",
	EFFECT_ATLAS_LEFT2 = "spine/ui/fight/left/jinenghou.atlas",
	BG3 = "FightLayer/role_bg3.png",
	FRAME2 = "FightLayer/role_frame2.png",
	STENCIL1 = "FightLayer/role_stencil1.png",
	BAR_TOP2 = "FightLayer/xp_bar_top2.png",
	BAR_TOP3 = "FightLayer/xp_bar_top3.png",
	BAR_TOP5 = "FightLayer/xp_bar_top5.png",
	LOCK_ROLE = "role/fight/lock_role.png",
	DEFAULT_ROLE = "role/fight/img_role_vacancy.png",
	BAR_BG3 = "FightLayer/xp_bar_bg3.png",
	EFFECT_ATLAS_LEFT1 = "spine/ui/fight/left/jinengqian.atlas",
	EFFECT_DATA_LEFT2 = "spine/ui/fight/left/jinenghou.json",
	BAR_MID3 = "FightLayer/xp_bar_mid3.png",
	STENCIL2 = "FightLayer/role_stencil2.png",
	BAR_TOP4 = "FightLayer/xp_bar_top4.png",
	EFFECT_DATA_MID1 = "spine/ui/fight/mid/jinengqian.json",
	FRAME3 = "FightLayer/role_frame3.png",
	BAR_MID1 = "FightLayer/xp_bar_mid1.png",
	BG1 = "FightLayer/role_bg1.png",
	EFFECT_DATA_MID2 = "spine/ui/fight/mid/jinenghou.json",
	FRAME1 = "FightLayer/role_frame1.png",
	BG2 = "FightLayer/role_bg2.png",
	BAR_MID2 = "FightLayer/xp_bar_mid2.png",
	STENCIL3 = "FightLayer/role_stencil3.png",
	EFFECT_ATLAS_MID2 = "spine/ui/fight/mid/jinenghou.atlas",
	EFFECT_DATA_LEFT1 = "spine/ui/fight/left/jinengqian.json"
}
local var_0_17 = {
	bg = {
		{
			flippX = false,
			visible = true,
			zorder = 1,
			texture = var_0_16.BG1,
			pos = cc.p(0, 0)
		},
		{
			flippX = false,
			visible = true,
			zorder = 1,
			texture = var_0_16.BG2,
			pos = cc.p(0, 0)
		},
		{
			flippX = false,
			visible = true,
			zorder = 1,
			texture = var_0_16.BG3,
			pos = cc.p(0, 0)
		},
		{
			flippX = true,
			visible = true,
			zorder = 1,
			texture = var_0_16.BG2,
			pos = cc.p(0, 0)
		},
		{
			flippX = true,
			visible = true,
			zorder = 1,
			texture = var_0_16.BG1,
			pos = cc.p(0, 0)
		}
	},
	frame = {
		{
			flippX = false,
			visible = true,
			zorder = 4,
			texture = var_0_16.FRAME1,
			pos = cc.p(0, 0)
		},
		{
			flippX = false,
			visible = true,
			zorder = 4,
			texture = var_0_16.FRAME2,
			pos = cc.p(0, 0)
		},
		{
			flippX = false,
			visible = true,
			zorder = 4,
			texture = var_0_16.FRAME3,
			pos = cc.p(0, 0)
		},
		{
			flippX = true,
			visible = true,
			zorder = 4,
			texture = var_0_16.FRAME2,
			pos = cc.p(0, 0)
		},
		{
			flippX = true,
			visible = true,
			zorder = 4,
			texture = var_0_16.FRAME1,
			pos = cc.p(0, 0)
		}
	}
}
local var_0_18 = {
	{
		flippX = false,
		texture = var_0_16.STENCIL1
	},
	{
		flippX = false,
		texture = var_0_16.STENCIL2
	},
	{
		flippX = false,
		texture = var_0_16.STENCIL3
	},
	{
		flippX = true,
		texture = var_0_16.STENCIL2
	},
	{
		flippX = true,
		texture = var_0_16.STENCIL1
	}
}
local var_0_19 = {
	{
		flippX = false,
		bg = var_0_16.BAR_BG1,
		mid = var_0_16.BAR_MID1,
		top = var_0_16.BAR_TOP1,
		pos = cc.p(0, -103)
	},
	{
		flippX = false,
		bg = var_0_16.BAR_BG2,
		mid = var_0_16.BAR_MID2,
		top = var_0_16.BAR_TOP2,
		pos = cc.p(0, -99)
	},
	{
		flippX = false,
		bg = var_0_16.BAR_BG3,
		mid = var_0_16.BAR_MID3,
		top = var_0_16.BAR_TOP3,
		pos = cc.p(0, -99)
	},
	{
		flippX = true,
		bg = var_0_16.BAR_BG2,
		mid = var_0_16.BAR_MID2,
		top = var_0_16.BAR_TOP4,
		pos = cc.p(0, -99)
	},
	{
		flippX = true,
		bg = var_0_16.BAR_BG1,
		mid = var_0_16.BAR_MID1,
		top = var_0_16.BAR_TOP5,
		pos = cc.p(0, -103)
	}
}
local var_0_20 = {
	{
		front = {
			flippX = true,
			zorder = 10,
			data = var_0_16.EFFECT_DATA_LEFT1,
			atlas = var_0_16.EFFECT_ATLAS_LEFT1
		},
		back = {
			flippX = true,
			zorder = 2,
			data = var_0_16.EFFECT_DATA_LEFT2,
			atlas = var_0_16.EFFECT_ATLAS_LEFT2
		}
	},
	{
		front = {
			flippX = true,
			zorder = 10,
			data = var_0_16.EFFECT_DATA_MID1,
			atlas = var_0_16.EFFECT_ATLAS_MID1
		},
		back = {
			flippX = true,
			zorder = 2,
			data = var_0_16.EFFECT_DATA_MID2,
			atlas = var_0_16.EFFECT_ATLAS_MID2
		}
	},
	{
		front = {
			flippX = true,
			zorder = 10,
			data = var_0_16.EFFECT_DATA_MID1,
			atlas = var_0_16.EFFECT_ATLAS_MID1
		},
		back = {
			flippX = true,
			zorder = 2,
			data = var_0_16.EFFECT_DATA_MID2,
			atlas = var_0_16.EFFECT_ATLAS_MID2
		}
	},
	{
		front = {
			flippX = false,
			zorder = 10,
			data = var_0_16.EFFECT_DATA_MID1,
			atlas = var_0_16.EFFECT_ATLAS_MID1
		},
		back = {
			flippX = false,
			zorder = 2,
			data = var_0_16.EFFECT_DATA_MID2,
			atlas = var_0_16.EFFECT_ATLAS_MID2
		}
	},
	{
		front = {
			flippX = false,
			zorder = 10,
			data = var_0_16.EFFECT_DATA_LEFT1,
			atlas = var_0_16.EFFECT_ATLAS_LEFT1
		},
		back = {
			flippX = false,
			zorder = 2,
			data = var_0_16.EFFECT_DATA_LEFT2,
			atlas = var_0_16.EFFECT_ATLAS_LEFT2
		}
	}
}

PlayerItem = class("PlayerItem", function()
	return cc.Node:create()
end)

function PlayerItem.create(arg_2_0, arg_2_1)
	local var_2_0 = PlayerItem.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PlayerItem:init(arg_3_1)
	self._pos = arg_3_1

	self:initBasicUI()
	self:initEffects()
	self:initEventListener()
	self:initStatus()
end

function PlayerItem:initBasicUI()
	for iter_4_0, iter_4_1 in pairs(var_0_17) do
		self[iter_4_0] = ccui.ImageView:create(iter_4_1[self._pos].texture, var_0_12)

		self[iter_4_0]:setPosition(iter_4_1[self._pos].pos)
		self[iter_4_0]:setVisible(iter_4_1[self._pos].visible)
		self[iter_4_0]:setFlippedX(iter_4_1[self._pos].flippX)
		self[iter_4_0]:setName(iter_4_0)
		self:addChild(self[iter_4_0], iter_4_1[self._pos].zorder)
	end

	self:initRoleUI()
	self:initBarUI()
end

function PlayerItem:initRoleUI()
	self.role = cc.ClippingNode:create()

	self.role:setInverted(false)
	self.role:setAlphaThreshold(0.1)

	local var_5_0

	if config._DEBUG then
		var_5_0 = cc.Sprite:create(var_0_18[self._pos].texture) or cc.Sprite:createWithSpriteFrameName(var_0_18[self._pos].texture)
	end

	var_5_0:setFlippedX(var_0_18[self._pos].flippX)
	self.role:setStencil(var_5_0)

	local var_5_1 = ccui.ImageView:create(var_0_16.DEFAULT_ROLE)

	var_5_1:setName("role")
	var_5_1:setAnchorPoint(cc.p(0.5, 0))
	var_5_1:setPosition(cc.p(0, -var_5_0:getContentSize().height / 2))
	var_5_1:setScale(0.9)
	self.role:addChild(var_5_1)

	self.expression = ccui.ImageView:create()

	self.expression:setAnchorPoint(cc.p(0.5, 0))
	self.expression:setPosition(cc.p(0, -var_5_0:getContentSize().height / 2))
	self.expression:setScale(0.9)
	self.role:addChild(self.expression, 1)
	self:addChild(self.role, 3)

	function self.role:setRole(arg_6_1)
		self:getChildByName("role"):loadTexture(var_0_13 .. model_data[arg_6_1].role_image .. ".png")

		if not hexie_manager:canShowBroken() then
			l2utils:recoverShader(self:getChildByName("role"):getVirtualRenderer())
		end
	end

	function self.role:setDie(arg_7_1)
		if hexie_manager:canShowBroken() then
			self:getChildByName("role"):loadTexture(var_0_13 .. (model_data[arg_7_1].fight_broken_role or model_data[arg_7_1].broken_role) .. ".png")
		else
			l2utils:shaderDarkNode(self:getChildByName("role"):getVirtualRenderer())
		end
	end

	function self.role:setEmpty()
		self:getChildByName("role"):loadTexture(var_0_16.DEFAULT_ROLE)
	end

	function self.role:setLock()
		self:getChildByName("role"):loadTexture(var_0_16.LOCK_ROLE)
	end
end

function PlayerItem:initBarUI()
	local var_10_0 = var_0_19[self._pos]

	self.xpbarnode = cc.Node:create()

	self.xpbarnode:setPosition(var_10_0.pos)
	self:addChild(self.xpbarnode)

	local var_10_1 = ccui.ImageView:create(var_10_0.bg, var_0_12)

	var_10_1:setFlippedX(var_10_0.flippX)
	self.xpbarnode:addChild(var_10_1)

	local var_10_2

	if config._DEBUG then
		var_10_2 = cc.Sprite:create(var_10_0.mid) or cc.Sprite:createWithSpriteFrameName(var_10_0.mid)
	end

	var_10_2:setFlippedX(var_10_0.flippX)

	self.midbar = cc.ProgressTimer:create(var_10_2)

	self.midbar:setBarChangeRate(cc.p(1, 0))
	self.midbar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.midbar:setMidpoint(cc.p(0, 0))
	self.xpbarnode:addChild(self.midbar, 1)

	self.topbar = cc.ProgressTimer:create((config._DEBUG or nil) and (cc.Sprite:create(var_10_0.top) or cc.Sprite:createWithSpriteFrameName(var_10_0.top)))

	self.topbar:setBarChangeRate(cc.p(1, 0))
	self.topbar:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	self.topbar:setMidpoint(cc.p(0, 0))
	self.xpbarnode:addChild(self.topbar, 2)
	self.midbar:setPercentage(0)
	self.topbar:setPercentage(0)
end

function PlayerItem:initEffects()
	self._xpshowing = false
	self.effectFront = L2Skeleton:create(var_0_20[self._pos].front.data, var_0_20[self._pos].front.atlas)

	self.effectFront:refreshSkeleton()

	if var_0_20[self._pos].front.flippX then
		self.effectFront:setScale(-1, 1)
	end

	self.effectFront:setVisible(false)
	self:addChild(self.effectFront, var_0_20[self._pos].front.zorder)
	self.effectFront:registerListener(SP_ANIMATION_COMPLETE, function(arg_12_0)
		if arg_12_0.animation == "jinengzhunbei" then
			self.effectFront:play("jineng")
		elseif arg_12_0.animation == "jinengshifang" then
			self.effectFront:setVisible(false)
			self:hideXPEffect()
		end
	end)

	self.effectBack = L2Skeleton:create(var_0_20[self._pos].back.data, var_0_20[self._pos].back.atlas)

	self.effectBack:refreshSkeleton()

	if var_0_20[self._pos].back.flippX then
		self.effectBack:setScale(-1, 1)
	end

	self.effectBack:setVisible(false)
	self:addChild(self.effectBack, var_0_20[self._pos].back.zorder)
	self.effectBack:registerListener(SP_ANIMATION_COMPLETE, function(arg_13_0)
		if arg_13_0.animation == "jinengzhunbei" then
			self.effectBack:play("jineng")
		elseif arg_13_0.animation == "jinengshifang" then
			self.effectBack:setVisible(false)
		end
	end)
end

function PlayerItem:playXPEffect()
	if self._xpshowing then
		return
	end

	self.effectFront:setVisible(true)
	self.effectBack:setVisible(true)
	self.effectFront:play("jinengzhunbei")
	self.effectBack:play("jinengzhunbei")
	self:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.1), cc.ScaleTo:create(0.2, 1)))

	self._xpshowing = true
end

function PlayerItem:useXPEffect()
	self.effectFront:play("jinengshifang")
	self.effectBack:play("jinengshifang")
end

function PlayerItem:hideXPEffect()
	if not self._xpshowing then
		return
	end

	self.effectFront:setVisible(false)
	self.effectBack:setVisible(false)

	self._xpshowing = false
end

function PlayerItem:initEventListener()
	self.bg:setTouchEnabled(true)
	self.bg:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 == ccui.TouchEventType.began then
			self:setScale(1.1)
		elseif arg_18_1 ~= ccui.TouchEventType.moved then
			self:setScale(1)
		end

		if arg_18_1 == ccui.TouchEventType.ended then
			if self._waiting then
				return
			end

			if self._fighting then
				if FightManager.getCharacter(self.index):checkSkillStatus("xp") then
					self._waiting = true

					FightManager.getCharacter(self.index):useSkillManual("xp")
					self:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.CallFunc:create(function()
						self._waiting = nil
					end)))
				end
			end
		end
	end)
end

function PlayerItem:initStatus()
	self._lockrole = not level_manager:isPlayerPassLevel(BATTLEARRAY_SOUL_UNLOCK[self._pos])

	if self._lockrole then
		self.role:setLock()
	end

	self.modelid = nil
	self.index = nil
	self._fighting = nil
	self._maxrage = 0
	self._die = false
	self._status = nil
end

function PlayerItem:registerFightBinding(arg_21_1, arg_21_2, arg_21_3)
	self.index = arg_21_2
	self._maxrage = arg_21_3
	self._fighting = true
	self._die = false
	self._status = nil
	self._playing = false

	self.midbar:stopAllActions()
	self.topbar:stopAllActions()
	self.midbar:setPercentage(0)
	self.topbar:setPercentage(0)

	if self.modelid ~= arg_21_1 then
		self.modelid = arg_21_1

		self:updateRoleInfo()
	end
end

function PlayerItem:unregisterFightBinding()
	self.index = nil
	self._fighting = false
	self._die = false
	self._maxrage = 0
	self._status = nil
	self._playing = false

	self.midbar:setPercentage(0)
	self.topbar:setPercentage(0)
	self:hideXPEffect()
end

function PlayerItem:updatePlayerInfo(arg_23_1)
	arg_23_1 = arg_23_1 or {}
	self.modelid = arg_23_1.modelid

	self:updateRoleInfo()
	self.midbar:setPercentage(0)
	self.topbar:setPercentage(0)
end

function PlayerItem:updateRoleInfo()
	if self.modelid then
		self.role:setRole(self.modelid)
	else
		self.role:setEmpty()
	end

	self:hideExpression()
end

function PlayerItem:playerDie()
	if self.modelid then
		self.role:setDie(self.modelid)
		self:hideExpression()

		self._die = true
		self._playing = false

		self:hideXPEffect()
		self.midbar:setPercentage(0)
		self.topbar:setPercentage(0)
	end
end

function PlayerItem:relive()
	self:updateRoleInfo()

	self._die = false
	self._playing = false

	self:hideXPEffect()
end

function PlayerItem:showExpression(arg_27_1)
	if self._status == arg_27_1 then
		return
	end

	if not self.modelid then
		return
	end

	self._status = arg_27_1

	self.expression:setVisible(true)
	self.expression:loadTexture(var_0_14 .. model_data[self.modelid][arg_27_1] .. ".png")
end

function PlayerItem:hideExpression()
	self.expression:setVisible(false)

	self._status = "hide"
end

function PlayerItem:updateRage(arg_29_1, arg_29_2)
	if self._die then
		return
	end

	if arg_29_1 == 1 then
		if self._playing then
			return
		end

		self.midbar:stopAllActions()
		self.topbar:stopAllActions()
		self.midbar:runAction(cc.ProgressTo:create(0.1, arg_29_2 / self._maxrage * 100))
		self.topbar:runAction(cc.ProgressTo:create(0.2, arg_29_2 / self._maxrage * 100))

		if arg_29_2 < self._maxrage then
			self:hideExpression()
			self:hideXPEffect()
		else
			self:showExpression("fanu")
			self:playXPEffect()

			if FightManager.needGuideUseXP() then
				GuideListener.triggerGuideFight(GUIDE_FIGHT_USEXP_CLASS, self)
			end

			audio_manager:playeffectMusic(XP_READY_EFFECT)
		end
	elseif arg_29_1 == 2 then
		self:hideExpression()
		self:useXPEffect()
		self.midbar:stopAllActions()
		self.topbar:stopAllActions()

		self._playing = true

		self.topbar:runAction(cc.ProgressTo:create(1, 0))
		self.midbar:runAction(cc.Sequence:create(cc.ProgressTo:create(1.5, 0), cc.CallFunc:create(function()
			self._playing = false
		end)))
	elseif arg_29_1 == 3 then
		self:playerDie()
		self.midbar:runAction(cc.ProgressTo:create(1.5, 0))
		self.topbar:runAction(cc.ProgressTo:create(1, 0))
	end
end

function PlayerItem:getXPPercent()
	return self.midbar:getPercentage()
end

PlayerItem.updateSkillCD = PlayerItem.updateRage
