-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/ItemBuryBao.lua

module("logic.extensions.burygame.view.ItemBuryBao", package.seeall)

local ItemBuryBao = class("ItemBuryBao", ItemBuryUnit)

function ItemBuryBao:ctor(parent, view)
	ItemBuryPit.super.ctor(self)
	print("new ItemBuryBao")

	self._go = parent

	local url = "20211028/zhiren_aoqi/zhiren_aoqi-ui_p.prefab"

	self._eff = UIEffectManager.instance:playEffect(view, url, self._go, 0, 0, true, nil, nil, self._onEffectLoaded, self)
end

function ItemBuryBao:_onEffectLoaded(uiEffect)
	print("ItemBuryBao loaded")
	uiEffect:setParent(self._go.transform)
	uiEffect:setScale(0.23)
	uiEffect:setLocalPos(-250, 0, 0)

	self._sg = uiEffect.effGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
	self._effLoaded = true

	self:_playAnimation()
end

function ItemBuryBao:startBury(x, y, z)
	self.x, self.y, self.z = x, y, z
	self._isAlive = true

	self:_playAnimation()
end

function ItemBuryBao:_playAnimation()
	if not self._isAlive or not self._effLoaded then
		return
	end

	Framework.TransformUtil.SetPos(self._go.transform, self.x, self.y, self.z)
	self._go:SetActive(true)

	local sg = self._sg

	if sg then
		local clipName = "1"

		sg.startingAnimation = clipName

		sg.AnimationState:SetAnimation(0, clipName, false)
		sg:Update(0)
	end

	self._remaingTime = 0.5
end

function ItemBuryBao:onTicking(deltaTime)
	if not self._isAlive or not self._effLoaded then
		return
	end

	self._remaingTime = self._remaingTime - deltaTime

	if self._remaingTime <= 0 then
		self:onDead()
	end
end

function ItemBuryBao:onDead()
	self._isAlive = false

	self._go:SetActive(false)
end

function ItemBuryBao:isDead()
	return not self._isAlive
end

function ItemBuryBao:onDestroy()
	UIEffectManager.instance:stopEffect(self._eff)

	self._eff = nil
	self._sg = nil
	self._isAlive = false
end

return ItemBuryBao
