-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/view/DDKMonster.lua

module("logic.extensions.darkdragonknife.view.DDKMonster", package.seeall)

local DDKMonster = class("DDKMonster", BaseLuaOnce)
local MELEE_ATTACK_TIME = 2.499
local MELEE_ATTACK_TIMESCALE = 0.33
local FAR_ATTACK_TIME = 2.499
local FAR_ATTACK_TIMESCALE = 0.33
local HIT_TIME = 0.667
local cfgRefl = {
	[DDragonKModel.ACTOR_TYPE_MELEE] = {
		speed = "nearSpeed"
	},
	[DDragonKModel.ACTOR_TYPE_DISTANT] = {
		speed = "farSpeed"
	}
}

function DDKMonster:ctor(go)
	DDKMonster.super.ctor(self, go)
end

function DDKMonster:buildUI()
	DDKMonster.super.buildUI(self)

	self._sliderBlood = Framework.SliderAdapter.GetFrom(self.mainGO, "bloodSlider")
	self._goBloodSlider = self:getGo("bloodSlider")
	self._transform = self.mainGO.transform
	self._hp = 0
	self._radius = math.ceil(self._transform.sizeDelta.x / 2)
	self._pos = {
		x = 0,
		y = 0
	}
	self._damgeShow = self:getGo("damage")
	self._txtDamageShow = self:getGo("damage/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self._goAnim = self:getGo("animation")
	self._goEff = self:getGo("effect")
end

function DDKMonster:onExit()
	DDKMonster.super.onExit(self)

	if self._tweenMove then
		self._tweenMove:Kill(false)

		self._tweenMove = nil
	end

	if self._damageTween then
		self._damageTween:Kill(false)

		self._damageTween = nil
	end

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end

	removetimer(self._meleeDamage, self)
	removetimer(self._farDamage, self)
	removetimer(self._playIdleAfterHit, self)

	self._sg = nil
end

function DDKMonster:onPause()
	if self._tweenMove then
		self._tweenMove:Kill(false)

		self._tweenMove = nil
	end

	if self._damageTween then
		self._damageTween:Kill(false)

		self._damageTween = nil
	end

	self:playAnimation(self._actorCfg.moveAni, true)
	removetimer(self._meleeDamage, self)
	removetimer(self._farDamage, self)
	removetimer(self._playIdleAfterHit, self)
end

function DDKMonster:_onEffectLoaded(uiEffect)
	uiEffect:setParent(self._goAnim.transform)

	if self._type == DDragonKModel.ACTOR_TYPE_MELEE then
		uiEffect:setScale(0.1)
	else
		uiEffect:setScale(0.2)
	end

	uiEffect:setLocalPos()

	self._sg = uiEffect.effGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
	self._effLoaded = true

	self:playAnimation(self._actorCfg.moveAni, true)
end

function DDKMonster:beginMove(targetPos)
	local x, y, z = Framework.TransformUtil.GetLocalPos(self._transform, 0, 0, 0)

	if self._type == DDragonKModel.ACTOR_TYPE_MELEE then
		Framework.TransformUtil.SetLocalScale(self._goAnim.transform, x > 0 and 1 or -1, 1, 1)
	else
		Framework.TransformUtil.SetLocalScale(self._goAnim.transform, x > 0 and -1 or 1, 1, 1)
	end

	self._pos.x = x
	self._pos.y = y

	local diffx = targetPos.x - x
	local diffy = targetPos.y - y
	local absX = math.abs(x - targetPos.x)
	local absY = math.abs(y - targetPos.y)
	local distance = math.sqrt(absX * absX + absY * absY)
	local time = distance / self._speed

	self._tweenMove = TweenUtil.ValueTo(0, 1, time, function(val)
		local x1 = x + diffx * val
		local y1 = y + diffy * val

		self._pos.x = x1
		self._pos.y = y1

		Framework.TransformUtil.SetLocalPos(self.mainGO.transform, x1, y1, 0)
	end, function()
		self:_beginAttack()
	end, self, DG.Tweening.Ease.Linear)
end

function DDKMonster:setCfg(type, gameCfg, actorCfg, view)
	self._view = view
	self._speed = gameCfg[cfgRefl[type].speed]
	self._damageVal = actorCfg.damage
	self._type = type
	self._maxBlood = actorCfg.blood
	self._curBlood = actorCfg.blood
	self._actorCfg = actorCfg

	self._sliderBlood:SetValue(1)
	goutil.setActive(self._damgeShow, false)
	goutil.setActive(self._goBloodSlider, false)

	local url = self._actorCfg.animation

	self._eff = UIEffectManager.instance:playEffect(self._view, url, self._goAnim, 0, 0, true, nil, nil, self._onEffectLoaded, self)
end

function DDKMonster:_beginAttack()
	if self._type == DDragonKModel.ACTOR_TYPE_MELEE then
		self:playAnimation(self._actorCfg.atkAni, true, MELEE_ATTACK_TIMESCALE)
		settimer(MELEE_ATTACK_TIME, self._meleeDamage, self, true)
	else
		self:playAnimation(self._actorCfg.atkAni, true, FAR_ATTACK_TIMESCALE)
		settimer(FAR_ATTACK_TIME, self._farDamage, self, true)
	end
end

function DDKMonster:_farDamage()
	local x, y, z = Framework.TransformUtil.GetLocalPos(self._transform, 0, 0, 0)
	local params = {
		pos = {
			x = x,
			y = y
		}
	}

	GlobalDispatcher:dispatch(GlobalNotify.DarkDragonKnifeBornBullet, params)
end

function DDKMonster:_meleeDamage()
	GlobalDispatcher:dispatch(GlobalNotify.DarkDragonKnifeDamage, self._damageVal)
end

function DDKMonster:checkCollide(pos, radius, damage)
	return (radius > GameUtil.getVector2Distance(pos, self._pos) or nil) and true
end

function DDKMonster:knifeDamage(damage)
	self:playAnimation(self._actorCfg.hitAni, false)
	goutil.setActive(self._goBloodSlider, true)
	goutil.setActive(self._damgeShow, true)
	self._txtDamageShow:SetText(damage)

	self._damageTween = TweenUtil.ValueTo(1, 0, 1.7, function(val)
		return
	end, function()
		goutil.setActive(self._damgeShow, false)
	end, self, DG.Tweening.Ease.Linear)

	local dead = damage >= self._curBlood

	self._curBlood = math.max(self._curBlood - damage, 0)

	self._sliderBlood:SetValue(self._curBlood / self._maxBlood)

	return dead
end

function DDKMonster:playAnimation(animName, loop, timeScale, callBack, reStart)
	local graphic = self._sg

	if graphic then
		local sk = graphic.skeletonDataAsset

		if sk ~= nil then
			local data = sk:GetAnimationStateData()
			local skd = data.SkeletonData
			local ani = skd:FindAnimation(animName)

			if reStart then
				graphic.AnimationState:ClearTracks()
			end

			if ani ~= nil then
				if animName == "hit" then
					removetimer(self._playIdleAfterHit, self)
					settimer(HIT_TIME, self._playIdleAfterHit, self, false)
				end

				graphic.startingAnimation = animName
				graphic.AnimationState.TimeScale = timeScale and timeScale or 1

				graphic.AnimationState:SetAnimation(0, animName, loop)
				graphic:Update(0)

				local onComplete

				function onComplete()
					GameUtil.callBack(callBack)

					graphic.AnimationState.Complete = graphic.AnimationState.Complete - onComplete
				end

				graphic.AnimationState.Complete = graphic.AnimationState.Complete + onComplete
			end
		end
	end
end

function DDKMonster:_playIdleAfterHit()
	removetimer(self._playIdleAfterHit, self)
	self:playAnimation(self._actorCfg.moveAni, true)
end

function DDKMonster:getPos()
	return self._pos
end

return DDKMonster
