-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/util/RendererFeatureUtil.lua

module("logic.scene.util.RendererFeatureUtil", package.seeall)

local RendererFeatureUtil = class("RendererFeatureUtil")
local renderMap = {}

function RendererFeatureUtil.toggleRendererFeature(name, enable, key)
	local signalAmount = renderMap[name]

	if not signalAmount then
		signalAmount = SignalAmount.New()
		renderMap[name] = signalAmount
	end

	if enable then
		signalAmount:addUnique(key)
	else
		signalAmount:remove(key)
	end

	local isOn = signalAmount:isActive()

	SpaceX.RendererFeatureUtils.ToggleRendererFeature(isOn, name)
end

return RendererFeatureUtil
