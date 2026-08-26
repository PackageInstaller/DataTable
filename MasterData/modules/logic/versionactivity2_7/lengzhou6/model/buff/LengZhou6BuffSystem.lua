-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/buff/LengZhou6BuffSystem.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.buff.LengZhou6BuffSystem", package.seeall)

local LengZhou6BuffSystem = class("LengZhou6BuffSystem")
local buffId = 0

local function getBuffId()
	buffId = buffId + 1

	return buffId
end

function LengZhou6BuffSystem:addBuffToPlayer(buffConfigId)
	local player = LengZhou6GameModel.instance:getPlayer()

	if player then
		local buff = player:getBuffByConfigId(buffConfigId)

		if buff ~= nil then
			buff:addCount(1)
		else
			local buff = LengZhou6BuffUtils.instance.createBuff(buffConfigId)

			buff:init(getBuffId(), buffConfigId)
			player:addBuff(buff)
		end
	end

	LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.RefreshBuffItem)
end

function LengZhou6BuffSystem:addBuffToEnemy(buffConfigId)
	local enemy = LengZhou6GameModel.instance:getEnemy()

	if enemy then
		local buff = enemy:getBuffByConfigId(buffConfigId)

		if buff ~= nil then
			buff:addCount(1)
		else
			local buff = LengZhou6BuffUtils.instance.createBuff(buffConfigId)

			buff:init(getBuffId(), buffConfigId)
			enemy:addBuff(buff)
		end
	end

	LengZhou6GameController.instance:dispatchEvent(LengZhou6Event.RefreshBuffItem)
end

LengZhou6BuffSystem.instance = LengZhou6BuffSystem.New()

return LengZhou6BuffSystem
