-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/EffectUnitBase.lua

module("logic.battle.effect.EffectUnitBase", package.seeall)

local EffectUnitBase = class("EffectUnitBase", IReusable)

function EffectUnitBase:createInstance()
	return self.New()
end

function EffectUnitBase:NewObject(...)
	return self.New(...)
end

function EffectUnitBase:ctor()
	self.mainGO = goutil.create("EffectUnitBase", false)
	self._compList = {}

	self:_initComponents()
	self:_notifyComponents(BattleFunctionName.onInit)
end

function EffectUnitBase:reuse()
	self:_notifyComponents(BattleFunctionName.onReuse)
end

function EffectUnitBase:reset()
	self:_notifyComponents(BattleFunctionName.onReset)
end

function EffectUnitBase:destroy()
	self:_notifyComponents(BattleFunctionName.onDestroy)
	goutil.destroy(self.mainGO)

	self.mainGO = false
end

function EffectUnitBase:internalEffectLoaded()
	self:_notifyComponents(BattleFunctionName.onResourceLoaded)
end

function EffectUnitBase:_initComponents()
	return
end

function EffectUnitBase:_addComponent(compName, compClass)
	local compInst = compClass.New(self)

	compInst.unit = self
	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function EffectUnitBase:_notifyComponents(functionName)
	for _, component in pairs(self._compList) do
		local func = component[functionName]

		if func then
			func(component)
		end
	end
end

return EffectUnitBase
