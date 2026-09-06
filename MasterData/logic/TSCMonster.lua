-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throwshells/view/TSCMonster.lua

module("logic.extensions.throwshells.view.TSCMonster", package.seeall)

local TSCMonster = class("TSCMonster", TSColliderCombine)

function TSCMonster:ctor(go, cfg)
	self.super.ctor(self, go)

	self._mainGo = go

	goutil.setActive(self._mainGo, true)

	local x, y, z = Framework.TransformUtil.GetLocalPos(go.transform, 0, 0, 0)

	self._cfg = cfg
	self._originPos = {
		x = x,
		y = y
	}
	self._curX = x
	self._curY = y
	self._blood = cfg.blood
	self._weaknessGo = goutil.findChild(self._mainGo, "weakness")

	if self._weaknessGo then
		local offsetPos = {
			x = x,
			y = y
		}

		self._weakness = TSColliderCombine.New(self._weaknessGo, offsetPos)
	end

	goutil.setActive(self._weaknessGo, false)

	self._resPath = "ui/views/throwshells/tsgmonster.prefab"

	getres(self._resPath, self._onPrefabResourcesLoaded, self)
	GlobalDispatcher:addListener(GlobalNotify.ThrowShellsRoundEnd, self._randomPosition, self)
end

function TSCMonster:_onPrefabResourcesLoaded(res)
	if res and res.IsSuccess then
		res:Retain()

		self._res = res
		self._monsterComp = goutil.cloneAndSetParent(res:GetMainAsset(), self._mainGo.transform)

		Framework.TransformUtil.SetLocalPos(self._monsterComp.transform, 0, 0, 0)

		self._sliderBlood = Framework.SliderAdapter.GetFrom(self._monsterComp, "bloodSlider")
		self._damgeShow = goutil.findChild(self._monsterComp, "damage")
		self._baojiShow = goutil.findChild(self._monsterComp, "baoji")
		self._txtDamageShow = goutil.findChild(self._monsterComp, "damage/imgNum"):GetComponent(typeof(UIImgNumeralText))
		self._goAnim = goutil.findChild(self._monsterComp, "animation")
		self._goWeakness = goutil.findChild(self._monsterComp, "weakness")

		local x, y = Framework.TransformUtil.GetLocalPos(self._weaknessGo.transform, 0, 0, 0)

		Framework.TransformUtil.SetLocalPos(self._goWeakness.transform, x, y, 0)
		self._sliderBlood:SetValue(1)
		goutil.setActive(self._damgeShow, false)
		goutil.setActive(self._baojiShow, false)

		local url = "character/" .. self._cfg.monsterSrc .. ".prefab"

		self._eff = UIEffectManager.instance:playEffect(self._view, {
			url
		}, self._goAnim, 0, 0, true, nil, nil, self._onEffectLoaded, self)
	end
end

function TSCMonster:_onEffectLoaded(uiEffect)
	uiEffect:setParent(self._goAnim.transform)
	uiEffect:setScale(checknumber(self._cfg.srcScale))
	uiEffect:setLocalPos()

	self._sg = uiEffect.effGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
	self._effLoaded = true

	self:playAnimation("idle", true)
end

function TSCMonster:checkCollide(pos, radius, damage)
	if self:isDie() then
		return false
	end

	local weakCollide = self._weakness:checkCollide(pos, radius)
	local collide = false

	if not weakCollide then
		collide = self.super.checkCollide(self, pos, radius)
	end

	local damageNum = 0

	if weakCollide then
		damageNum = damage * self._cfg.damageScale
	elseif collide then
		damageNum = damage
	end

	self._blood = math.max(0, self._blood - damageNum)

	if damageNum > 0 then
		self._txtDamageShow:SetText(damageNum)
		goutil.setActive(self._damgeShow, true)

		if weakCollide then
			goutil.setActive(self._baojiShow, true)
		end

		self._damageTween = TweenUtil.ValueTo(1, 0, 1.7, nil, function()
			goutil.setActive(self._damgeShow, false)
			goutil.setActive(self._baojiShow, false)
		end, self, DG.Tweening.Ease.Linear)

		self:_refreshBlood()

		if self._blood == 0 then
			self:playAnimation("die", false, function()
				self:onDestroy()
			end)
		else
			self:playAnimation("hit", false, function()
				self:playAnimation("idle", true)
			end)
		end
	end

	return collide or weakCollide
end

function TSCMonster:_refreshBlood()
	self._sliderBlood:SetValue(self._blood / self._cfg.blood)
	GlobalDispatcher:dispatch(GlobalNotify.ThrowShellsMonsterDamage, self._cfg.monsterId, self._blood)
end

function TSCMonster:onDestroy()
	self.super.onDestroy(self)
	goutil.setActive(self._mainGo, false)
	GlobalDispatcher:removeListener(GlobalNotify.ThrowShellsRoundEnd, self._randomPosition, self)

	self._weakness = nil

	if self._damageTween then
		self._damageTween:Kill(false)

		self._damageTween = nil
	end

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end

	removeresl(self._resPath, self._onPrefabResourcesLoaded, self)

	if self._res then
		self._res:Release()
	end

	self._res = nil

	if not goutil.isNil(self._mainGo) then
		goutil.destroy(self._mainGo)
	end

	self._mainGo = nil
end

function TSCMonster:_randomPosition()
	self._curX, self._curY = Framework.TransformUtil.GetLocalPos(self._mainGo.transform, 0, 0, 0)

	local offsetY = 0

	if self._cfg.yMove then
		for i = 1, 10 do
			local randomY = math.random(self._cfg.yMove[1], self._cfg.yMove[2])

			offsetY = self._originPos.y + randomY - self._curY

			if math.abs(self._originPos.y + randomY - self._curY) > self._cfg.interval then
				break
			end
		end
	end

	local offsetX = 0

	if self._cfg.xMove then
		for i = 1, 10 do
			local randomX = math.random(self._cfg.xMove[1], self._cfg.xMove[2])

			offsetX = self._originPos.x + randomX - self._curX

			if math.abs(self._originPos.x + randomX - self._curX) > self._cfg.interval then
				break
			end
		end
	end

	local offset = {
		x = offsetX,
		y = offsetY
	}

	self:move(offset)
	self._weakness:move(offset)

	self._curX = self._curX + offset.x
	self._curY = self._curY + offset.y

	Framework.TransformUtil.SetLocalPos(self._mainGo.transform, self._curX, self._curY, 0)
end

function TSCMonster:playAnimation(animName, loop, callBack)
	RoleObjectPool.instance:playAnimation(self._goAnim, animName, loop, callBack, true)
end

function TSCMonster:getPos()
	if self:isDie() then
		return nil
	else
		return {
			x = self._curX,
			y = self._curY
		}
	end
end

function TSCMonster:isDie()
	return self._blood == 0
end

return TSCMonster
