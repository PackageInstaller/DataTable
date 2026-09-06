-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/view/DDKBullet.lua

module("logic.extensions.darkdragonknife.view.DDKBullet", package.seeall)

local DDKBullet = class("DDKBullet", BaseLuaOnce)

function DDKBullet:ctor(go)
	DDKBullet.super.ctor(self, go)
end

function DDKBullet:buildUI()
	DDKBullet.super.buildUI(self)

	self._transform = self.mainGO.transform
	self._radius = 20
	self._pos = {
		x = 0,
		y = 0
	}
	self._goEff = goutil.findChild(self.mainGO, "effect")
end

function DDKBullet:bindEvents()
	DDKBullet.super.bindEvents(self)
end

function DDKBullet:unbindEvents()
	DDKBullet.super.unbindEvents(self)
end

function DDKBullet:onEnter()
	DDKBullet.super.onEnter(self)
end

function DDKBullet:onExit()
	DDKBullet.super.onExit(self)

	if self._tweenMove then
		self._tweenMove:Kill(false)
	end

	if self._hitEffect then
		UIEffectManager.instance:stopEffect(self._hitEffect)

		self._hitEffect = nil
	end
end

function DDKBullet:beginMove(targetPos)
	if self._hitEffect then
		UIEffectManager.instance:stopEffect(self._hitEffect)

		self._hitEffect = nil
	end

	local hitUrl = "xiaoyouxi/xiaoanlongyouxi/fx_xiaoanlong_feixing.prefab"

	self._hitEffect = UIEffectManager.instance:playEffect(self._view, hitUrl, self._goEff, 0, 0, true, nil, nil, function(o, eff)
		eff:setLocalPos(0, 0, 0)
	end)

	self._hitEffect:setParent(self._goEff.transform)
	self._hitEffect:setScale(10)

	local x, y, z = Framework.TransformUtil.GetLocalPos(self._transform, 0, 0, 0)
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
		self:_damage()
	end, self, DG.Tweening.Ease.Linear)
end

function DDKBullet:setCfg(params, actorCfg, view)
	self._speed = 60
	self._damageVal = actorCfg.damage
	self._type = type
	self._view = view
end

function DDKBullet:_damage()
	GlobalDispatcher:dispatch(GlobalNotify.DarkDragonKnifeBulletAttack, self._damageVal, self.mainGO)
end

function DDKBullet:checkCollide(pos, radius, damage)
	return (radius > GameUtil.getVector2Distance(pos, self._pos) or nil) and true
end

return DDKBullet
