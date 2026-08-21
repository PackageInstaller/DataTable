-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/mgr/RogueGameShieldMgr.lua

module("logic.extensions.roguelike.flow.component.mgr.RogueGameShieldMgr", package.seeall)

local RogueShieldTrigger = class("RogueShieldTrigger")

function RogueShieldTrigger:ctor(container)
	local go = container.gameObject

	self._go = go
end

function RogueShieldTrigger:getGo()
	return self._go
end

function RogueShieldTrigger:setEnterCallback(callback)
	self._collisionEnterCallback = callback
end

function RogueShieldTrigger:setExitCallback(callback)
	self._collisionExitCallback = callback
end

function RogueShieldTrigger:OnTriggerEnter(collider)
	if self._collisionEnterCallback then
		self._collisionEnterCallback(collider)
	end
end

function RogueShieldTrigger:OnTriggerExit(collider)
	if self._collisionExitCallback then
		self._collisionExitCallback(collider)
	end
end

local M = class("RogueGameShieldMgr", IRogueFlowComp)
local kSceneRoot = SceneMgr.instance:getSceneRoot()
local kShieldRoot = goutil.create("Shield")

goutil.addChildToParent(kShieldRoot, kSceneRoot)

local kDestroyAniName = "end"
local kIdleAniName = "idle"
local kShieldEffectPath = GameUrl.get3dEffectUrl("scene/other/paotuan/paotuan_fx_hudun")
local kShieldHitEffectPath = GameUrl.get3dEffectUrl("scene/other/paotuan/paotuan_fx_hudun_hit")

function M:onInit()
	self._diceObjs = {}
	self._allDiceObjs = {}
	self._diceCallbacks = {}
	self._resDict = {}
	self._attackType = -1
	self._resLoader = MultiResLoader.New()

	local resPaths = {}

	table.insert(resPaths, kShieldEffectPath)
	table.insert(resPaths, kShieldHitEffectPath)

	local resLoader = self._resLoader

	resLoader:setResPaths(resPaths)
	resLoader:load(self._onAllAdditionalLoaded, self._onAdditionalLoaded, self)
end

function M:_onAdditionalLoaded(res)
	if res.IsSuccess then
		res:Retain()

		self._resDict[res.ResPath] = res
	end
end

function M:_onAllAdditionalLoaded(loader)
	self._resLoader:clear()
end

function M:getRes(resPath)
	return self._resDict[resPath]
end

function M:getAsset(resPath)
	return self:getRes(resPath):GetAsset(nil, nil)
end

function M:getShieldEffectInst()
	return self:getAsset(kShieldEffectPath)
end

function M:getShieldHitEffectInst()
	return self:getAsset(kShieldHitEffectPath)
end

function M:onStart()
	return
end

function M:setCurAttackType(attackType)
	self._attackType = attackType
end

function M:createMonsterShield()
	if not self._monsterShield then
		local rolePos = RogueMgr.instance:getMapMgr():getRealMapRolePos()
		local inst = goutil.cloneAndSetParent(self:getShieldEffectInst(), kShieldRoot.transform)
		local pos = Vector3.New(rolePos.x + 8, 0, rolePos.z)

		inst.transform.position = pos

		local angle = inst.transform.eulerAngles

		angle.y = 180
		inst.transform.eulerAngles = angle
		self._monsterShield = inst
		self._monsterShieldAni = goutil.addComponentOnce(inst, typeof(Astral.GUITimelineAniLua))

		local trigger = Astral.CollisionLuaComponentContainer.Add(goutil.findChild(inst, "collision_shield"), RogueShieldTrigger)

		trigger:setEnterCallback(function(collider)
			if self._attackType ~= 0 then
				return
			end

			self:showBoundEffect(collider, trigger:getGo().transform)
		end)

		local goEnd = goutil.findChild(inst, "end")

		goutil.setActive(goEnd, false)
		goutil.setActive(goutil.findChild(inst, "idle"), true)
	end

	return self._monsterShield
end

function M:destroyMonsterShield()
	if self._monsterShield then
		goutil.destroy(self._monsterShield)

		self._monsterShield = nil
	end
end

function M:showDestroyMonsterShieldAni()
	if self._monsterShield then
		local goEnd = goutil.findChild(self._monsterShield, "end")
		local goIdle = goutil.findChild(self._monsterShield, "idle")

		goutil.setActive(goIdle, false)
		goutil.setActive(goEnd, true)
		self._monsterShieldAni:StopTimelineAni()
		self._monsterShieldAni:PlayAniByName(kDestroyAniName)
		settimer(1, function()
			self:destroyMonsterShield()
		end, self, false)
	end
end

function M:showBoundEffect(collider, transform)
	local go = goutil.cloneAndSetParent(self:getShieldHitEffectInst(), kShieldRoot.transform)

	go.transform.position = collider:ClosestPoint(transform.position)

	local lookAtTarget = goutil.findChild(transform.parent.gameObject, "idle")

	go.transform:LookAt(lookAtTarget.transform.position)
	settimer(2, function()
		goutil.destroy(go)
	end, self, false)
end

function M:createRoleShield()
	if not self._roleShield then
		local rolePos = RogueMgr.instance:getMapMgr():getRealMapRolePos()
		local inst = goutil.cloneAndSetParent(self:getShieldEffectInst(), kShieldRoot.transform)
		local pos = Vector3.New(rolePos.x - 8, 0, rolePos.z)

		inst.transform.position = pos
		self._roleShield = inst
		self._roleShieldAni = goutil.addComponentOnce(inst, typeof(Astral.GUITimelineAniLua))

		local trigger = Astral.CollisionLuaComponentContainer.Add(goutil.findChild(inst, "collision_shield"), RogueShieldTrigger)

		trigger:setEnterCallback(function(collider)
			if self._attackType ~= 1 then
				return
			end

			self:showBoundEffect(collider, trigger:getGo().transform)
		end)

		local goEnd = goutil.findChild(inst, "end")

		goutil.setActive(goEnd, false)
		goutil.setActive(goutil.findChild(inst, "idle"), true)
	end

	return self._roleShield
end

function M:destroyRoleShield()
	if self._roleShield then
		goutil.destroy(self._roleShield)

		self._roleShield = nil
	end
end

function M:showDestroyRoleShieldAni()
	if self._roleShield then
		local goEnd = goutil.findChild(self._roleShield, "end")
		local goIdle = goutil.findChild(self._roleShield, "idle")

		goutil.setActive(goIdle, false)
		goutil.setActive(goEnd, true)
		self._roleShieldAni:StopTimelineAni()
		self._roleShieldAni:PlayAniByName(kDestroyAniName)
		settimer(1, function()
			self:destroyRoleShield()
		end, self, false)
	end
end

function M:onClear()
	self._resLoader:clear()

	self._diceObjs = {}
	self._allDiceObjs = {}

	self:clear()
	goutil.clearChildren(kShieldRoot)
end

function M:clear()
	self:destroyRoleShield()
	self:destroyMonsterShield()

	self._attackType = -1
end

return M
