-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/ItemBuryPit.lua

module("logic.extensions.burygame.view.ItemBuryPit", package.seeall)

local ItemBuryPit = class("ItemBuryPit", ItemBuryUnit)
local AnimIndex = {}

AnimIndex.One = 1
AnimIndex.Two = 2
AnimIndex.Three = 3

local UrlDic = {}

UrlDic[AnimIndex.One] = "fx_ui_yirenzhixia/mairenxiaoyouxi/beimai/yge-ui_p.prefab"
UrlDic[AnimIndex.Two] = "fx_ui_yirenzhixia/mairenxiaoyouxi/beimai_lailisi/beimai_lailisi-ui_p.prefab"
UrlDic[AnimIndex.Three] = "fx_ui_yirenzhixia/mairenxiaoyouxi/xiaonuoyouling/xiaonuoyouling-ui_p.prefab"

local AnimationDicts = {}

AnimationDicts[AnimIndex.One] = {
	[GameEnum.BuryPitEnum.DEAD] = {
		{
			disappear = "gui_xia",
			appear = "gui",
			idle = "gui_ding",
			dead = "gg"
		}
	},
	[GameEnum.BuryPitEnum.CHICK] = {
		{
			disappear = "4_xia",
			appear = "4",
			idle = "4_ding",
			dead = "jg"
		}
	},
	[GameEnum.BuryPitEnum.DUCK] = {
		{
			disappear = "1_xia",
			appear = "1",
			idle = "1_ding",
			dead = "yg"
		},
		{
			disappear = "2_xia",
			appear = "2",
			idle = "2_ding",
			dead = "yg"
		},
		{
			disappear = "3_xia",
			appear = "3",
			idle = "3_ding",
			dead = "yg"
		}
	}
}
AnimationDicts[AnimIndex.Two] = {
	[GameEnum.BuryPitEnum.DEAD] = {
		{
			disappear = "she_down",
			appear = "she_up",
			idle = "she_ilde",
			dead = "she_hit"
		}
	},
	[GameEnum.BuryPitEnum.CHICK] = {
		{
			disappear = "xiaonuo_down",
			appear = "xiaonuo_up",
			idle = "xiaonuo_idle",
			dead = "xiaonuo_hit"
		}
	},
	[GameEnum.BuryPitEnum.DUCK] = {
		{
			disappear = "xiaonuo_down",
			appear = "xiaonuo_up",
			idle = "xiaonuo_idle",
			dead = "xiaonuo_hit"
		},
		{
			disappear = "xiaonuo_down",
			appear = "xiaonuo_up",
			idle = "xiaonuo_idle",
			dead = "xiaonuo_hit"
		},
		{
			disappear = "xiaonuo_down",
			appear = "xiaonuo_up",
			idle = "xiaonuo_idle",
			dead = "xiaonuo_hit"
		}
	}
}
AnimationDicts[AnimIndex.Three] = {
	[GameEnum.BuryPitEnum.DEAD] = {
		{
			disappear = "gui_down",
			appear = "gui_up",
			idle = "gui_idle",
			dead = "gui_hit"
		}
	},
	[GameEnum.BuryPitEnum.CHICK] = {
		{
			disappear = "xiaonuo_down",
			appear = "xiaonuo_up",
			idle = "xiaonuo_idle",
			dead = "xiaonuo_hit"
		}
	},
	[GameEnum.BuryPitEnum.DUCK] = {
		{
			disappear = "xiaonuo_down",
			appear = "xiaonuo_up",
			idle = "xiaonuo_idle",
			dead = "xiaonuo_hit"
		},
		{
			disappear = "xiaonuo_down",
			appear = "xiaonuo_up",
			idle = "xiaonuo_idle",
			dead = "xiaonuo_hit"
		},
		{
			disappear = "xiaonuo_down",
			appear = "xiaonuo_up",
			idle = "xiaonuo_idle",
			dead = "xiaonuo_hit"
		}
	}
}

local BuryPitStateEnum = {
	Dead = 4,
	Idle = 2,
	Dispear = 3,
	Appear = 1,
	None = 0
}
local appearTime = 0.667
local disappearTime = 0.5
local deadTime = 0.833

function ItemBuryPit:ctor(go, view)
	ItemBuryPit.super.ctor(self)

	self._go = go

	local btn = Framework.ButtonAdapter.GetFrom(go, "Button")

	self._graphic = btn:GetComponent(typeof(UnityEngine.UI.Graphic))
	self._effPoint = goutil.findChild(go, "effPoint")
	self._animIndex = AnimIndex.Three

	local url = UrlDic[self._animIndex]

	self._eff = UIEffectManager.instance:playEffect(view, url, self._effPoint, 0, 0, true, nil, nil, self._onEffectLoaded, self)

	btn:AddClickListener(self._onClickPit, self)

	self._hitPoint = goutil.findChild(go, "hitPoint")
	self._boomPoint = goutil.findChild(go, "boomPoint")
	self._view = view
end

function ItemBuryPit:_onEffectLoaded(uiEffect)
	uiEffect:setParent(self._effPoint.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos()

	self._sg = uiEffect.effGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
	self._effLoaded = true

	self:_tryAppearPit()
end

function ItemBuryPit:_playAnimation(clipName, loop)
	local sg = self._sg

	if sg then
		print("play animation clipName = " .. clipName .. " loop = " .. tostring(loop))

		sg.startingAnimation = clipName

		sg.AnimationState:SetAnimation(0, clipName, loop)
		sg:Update(0)
	end
end

function ItemBuryPit:init(posId, data)
	self._pitType = data.pitType
	self._duration = data.duration
	self._posId = posId
	self._isAlive = true
	self._tickedTime = 0

	local dic = AnimationDicts[self._animIndex]
	local plans = dic[self._pitType]

	self._plan = plans[math.random(1, #plans)]
	self._graphic.raycastTarget = true

	self:_tryAppearPit()
end

function ItemBuryPit:_tryAppearPit()
	if not self._isAlive or not self._effLoaded then
		return
	end

	self._state = BuryPitStateEnum.Appear

	self:_playAnimation(self._plan.appear, false)

	self._remaingTime = appearTime
end

function ItemBuryPit:_onClickPit()
	if self._state == BuryPitStateEnum.Dead then
		return
	end

	self._graphic.raycastTarget = false

	local x, y, z = Framework.TransformUtil.GetPos(self._hitPoint.transform, 0, 0, 0)
	local x1, y1, z1 = Framework.TransformUtil.GetPos(self._boomPoint.transform, 0, 0, 0)

	GlobalDispatcher:dispatch(GlobalNotify.BuryPitSuccess, self._pitType, x, y, z, x1, y1, z1)
	self:_playAnimation(self._plan.dead, false)

	self._state = BuryPitStateEnum.Dead
	self._remaingTime = deadTime
end

function ItemBuryPit:onTicking(deltaTime)
	if not self._isAlive or not self._effLoaded then
		return
	end

	self._remaingTime = self._remaingTime - deltaTime

	if self._remaingTime <= 0 then
		if self._state == BuryPitStateEnum.Appear then
			self:_playAnimation(self._plan.idle, true)

			self._state = BuryPitStateEnum.Idle
			self._remaingTime = self._duration
		elseif self._state == BuryPitStateEnum.Idle then
			self:_playAnimation(self._plan.disappear, false)

			self._state = BuryPitStateEnum.Dispear
			self._remaingTime = disappearTime
		elseif self._state == BuryPitStateEnum.Dispear or self._state == BuryPitStateEnum.Dead then
			self:onDead()
		end
	end
end

function ItemBuryPit:onDead()
	self._isAlive = false

	self._go:SetActive(false)
end

function ItemBuryPit:isDead()
	return not self._isAlive
end

function ItemBuryPit:getPosId()
	return checknumber(self._posId)
end

function ItemBuryPit:getMainGo()
	return self._go
end

function ItemBuryPit:onDestroy()
	UIEffectManager.instance:stopEffect(self._eff)

	self._eff = nil
	self._sg = nil
	self._isAlive = false

	goutil.destroy(self._go, true)
end

return ItemBuryPit
