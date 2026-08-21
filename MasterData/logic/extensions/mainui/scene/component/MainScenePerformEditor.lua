-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/component/MainScenePerformEditor.lua

module("logic.extensions.mainui.scene.component.MainScenePerformEditor", package.seeall)

local M = class("MainScenePerformEditor", SceneComponentBase)

function M:onInit()
	return
end

function M:onEnterScene(sceneId, bornX, bornZ)
	self:_setEvent(true)
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	self:_loadInteractPoint()
end

function M:onExitScene()
	self:_setEvent(false)
end

function M:_setEvent(add)
	if add then
		-- block empty
	end
end

function M:onLeaveScene()
	self:_setEvent(false)
end

function M:onReturnScene()
	self:_setEvent(true)
end

function M:onReturnSceneFinished()
	self:_loadInteractPoint()
end

function M:_loadInteractPoint()
	local cfgMap = MainPerformConfig.instance:getInteractPointMap()
	local pointLst = {}

	for point, _ in pairs(cfgMap or {}) do
		table.insert(pointLst, point)
	end

	table.sort(pointLst, function(a, b)
		return b < a
	end)

	if not SceneFace.instance:isCurScene(SceneType.Room) then
		return
	end

	local curSceneFlow = SceneFace.instance:getCurSceneFlow()

	for _, point in ipairs(pointLst) do
		local posData = curSceneFlow.elementMgr:getInteractPointPosData(point)

		if posData then
			local info = {}

			info.point = point
			info.go = posData.go
			info.pos = {}
			info.pos.x = posData.pos.x or 0
			info.pos.y = posData.pos.y or 0
			info.pos.z = posData.pos.z or 0

			curSceneFlow.unitFactory:createInteractPoint(info)
		else
			printWarn(string.format("交互点[%s] 无法定位，不生成交互点辅助UI", point))
		end
	end
end

return M
