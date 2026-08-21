-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/dice/RogueDiceCompTrigger.lua

module("logic.extensions.roguelike.unit.comp.dice.RogueDiceCompTrigger", package.seeall)

local M = class("RogueDiceCompTrigger")

function M:ctor(go)
	self._go = go.gameObject
	self._goTailEffect = goutil.findChild(go, "paotuan_tx_yanwei")
	self._goFaceEffect = goutil.findChild(go, "paotuan_tx_touzimian")
	self._goFaceChange = goutil.findChild(go, "paotuan_tx_touzimian/touzi_change")
	self._goSelectEffect = goutil.findChild(go, "paotuan_fx_select")
	self._colliderGos = {}
end

function M:OnDestroy()
	self:_clearColliderEffect()
	self:_clearExtraEffect()
end

function M:enableTail(isEnable)
	if not self._goTailEffect then
		return
	end

	goutil.setActive(self._goTailEffect, isEnable)
end

function M:showColliderEffect(isActive)
	goutil.setActive(self._goColliderEffect, false)

	if isActive then
		local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr
		local go = goutil.clone(diceMgr:getColliderEffectInst())

		goutil.setActive(go, false)

		go.transform.position = self._go.transform.position
		go.transform.parent = nil

		goutil.setActive(go, true)
		table.insert(self._colliderGos, go)
		settimer(1, self._clearOneColliderEffect, self, false)
	end
end

function M:_clearOneColliderEffect()
	local go = self._colliderGos[1]

	if go then
		goutil.destroy(go)
		table.remove(self._colliderGos, 1)
	end
end

function M:_clearColliderEffect()
	for k, v in pairs(self._colliderGos) do
		goutil.destroy(v)
	end

	self._colliderGos = nil
end

function M:showExtraEffect(isActive)
	if isActive then
		local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr
		local go = goutil.clone(diceMgr:getExtraPatternEffectInst())

		goutil.setActive(go, false)

		go.transform.position = self._go.transform.position
		go.transform.parent = nil
		self._extraEffect = go

		goutil.setActive(go, true)
		settimer(1, self._clearExtraEffect, self, false)
	end
end

function M:showSelectEffect()
	goutil.setActive(self._goSelectEffect, false)
	goutil.setActive(self._goSelectEffect, true)
end

function M:_clearExtraEffect()
	if self._extraEffect then
		goutil.destroy(self._extraEffect)

		self._extraEffect = nil
	end
end

function M:showFaceEffect(pattern)
	goutil.setActive(self._goFaceEffect, false)

	local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr
	local materialSetter = MaterialSetter.Get(self._goFaceChange)

	materialSetter:SetGameObject(self._goFaceChange)

	local texture = diceMgr:getDicePatternTexture(pattern)

	materialSetter:SetTexture(UnityEngine.Shader.PropertyToID("_BaseMap"), texture)
	goutil.setActive(self._goFaceEffect, true)
end

function M:reset()
	goutil.setActive(self._goColliderEffect, false)
	goutil.setActive(self._goTailEffect, false)
	goutil.setActive(self._goFaceEffect, false)
	goutil.setActive(self._goSelectEffect, false)
end

function M:OnTriggerEnter(collider)
	if collider.name == self._go.name or collider.name == "trigger" or self._go.transform.position.y < 1 then
		return
	end
end

function M:OnTriggerExit(collider)
	if collider.name == self._go.name or collider.name == "trigger" or self._go.transform.position.y < 1 then
		return
	end
end

return M
