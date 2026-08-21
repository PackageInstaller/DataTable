-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/demo/view/TimeText.lua

module("logic.common.entitas.demo.view.TimeText", package.seeall)

local M = class("TimeText", IGameTickListener)

function M:ctor(container)
	self._go = container.gameObject
end

function M:Awake()
	self._context = Contexts.sharedInstance.game

	local entity = self._context:CreateEntity()

	entity:addTickListener(self)

	self._entity = entity
	self._text = self._go:GetComponent("Text")
end

function M:OnDestroy()
	self._context:destroy_entity(self._entity)
end

function M:OnGameTick(entity, cureentTick)
	local frameNum = 6
	local sec = math.floor(cureentTick / frameNum % frameNum)
	local min = math.floor(cureentTick / frameNum / frameNum)
	local secText = sec > 9 and sec or sec
	local minText = min > 9 and min or "0" .. min

	self._text.text = minText .. ":" .. secText
end

return M
