-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/EffectUtil.lua

module("logic.battle.effect.EffectUtil", package.seeall)

local function findStringLastIndex(originString, pattern)
	local currentIndex = 0
	local lastIndex = -1

	repeat
		currentIndex = string.find(originString, pattern, currentIndex + 1, true)

		if not currentIndex then
			return lastIndex
		end

		lastIndex = currentIndex
	until false
end

local EffectUtil = class("EffectUtil")

function EffectUtil.setEffectUnitInfo(unit, effectCode)
	local effectCO = EffectConfig.instance:getEffectCO(effectCode)
	local resPath = EffectUtil.getEffectUrl(effectCode)

	unit.main:setEffectCode(effectCode)
	unit.lifeTime:setLifeTime(effectCO.time)
	unit.loader:load(resPath)
	unit.audio:setEffectAudioName(effectCO, unit)
end

function EffectUtil.playEffectWithClass(effectCode, effectClass, goParent)
	effectClass = effectClass or EffectUnit

	local unit = effectClass:createInstance()

	EffectUtil.setEffectUnitInfo(unit, effectCode)
	goutil.addChildToParent(unit.mainGO, goParent)

	return unit
end

function EffectUtil.playEffect(effectCode, goParent)
	local unit = EffectUnit:createInstance()

	EffectUtil.setEffectUnitInfo(unit, effectCode)
	goutil.addChildToParent(unit.mainGO, goParent)

	return unit
end

function EffectUtil.getEffectUrl(effectCode)
	local effectCO = EffectConfig.instance:getEffectCO(effectCode)

	if not effectCO then
		return false
	end

	if effectCO.is3d == 1 then
		local url = GameUrl.get3dEffectUrl(effectCO.resPath)

		return EffectUtil.getQualifiedUrl(url)
	end

	local url = GameUrl.getEffectUrl(effectCO.resPath)

	return EffectUtil.getQualifiedUrl(url)
end

function EffectUtil.getMountHeightFactor(effectCode)
	local effectCO = EffectConfig.instance:getEffectCO(effectCode)

	if not effectCO then
		return 0
	end

	return effectCO.mountHeight * 0.5
end

function EffectUtil.destroyEffect(unit)
	unit:destroy()
end

function EffectUtil.getAudioName(effectCode)
	local effectCO = EffectConfig.instance:getEffectCO(effectCode)

	return effectCO and effectCO.audioName
end

local rescache = Astral.LuaResourceCache.Instance

function EffectUtil.getQualifiedUrl(url)
	if rescache:ExistsResource(url) then
		return url
	end

	local index = findStringLastIndex(url, "/")

	if index then
		local dir = string.sub(url, 1, index)
		local name = string.sub(url, index, -8)
		local lable = GfxModel.instance:getEffectQualityLabel()
		local qUrl = string.format("%srun%s_%s.prefab", dir, name, lable)

		return rescache:ExistsResource(qUrl) and qUrl or url
	end

	return url
end

return EffectUtil
