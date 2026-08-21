-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/agent/RogueExploreAgent.lua

module("logic.extensions.roguelike.agent.RogueExploreAgent", package.seeall)

local M = class("RogueExploreAgent", BaseAgent)

function M:sendStartRequest(equipId, roleIds, scriptId, diffLevelIndex)
	local msg = RoguelikeExtension_pb.StartRequest()

	msg.equip = equipId or 0

	for k, v in pairs(roleIds or {}) do
		table.insert(msg.hero, v)
	end

	msg.script = scriptId

	local cos = RoguelikeConfig.instance:getScriptDiffCo(scriptId)

	diffLevelIndex = diffLevelIndex + 1

	local diffLevel = cos[diffLevelIndex] and cos[diffLevelIndex].level or 0

	msg.level = diffLevel

	self:sendMsg(msg)
end

function M:handleStartReply(status, msg)
	if status == 0 then
		RogueExploreModel.instance:updateCurScriptNo(msg.script)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_TEAM_UP_SUCCESS)
	end
end

function M:sendEndSelectRequest(id)
	local msg = RoguelikeExtension_pb.EndSelectRequest()

	msg.id = id

	self:sendMsg(msg)
end

function M:handleEndSelectReply(status, msg)
	if status == 0 then
		-- block empty
	end
end

function M:handleScriptPush(status, msg)
	if status == 0 then
		RogueExploreModel.instance:updateCurScriptNo(msg.info)
	end
end

function M:sendEndSelectCardRequest(index)
	local msg = RoguelikeExtension_pb.EndSelectCardRequest()

	msg.index = index

	self:sendMsg(msg)
end

function M:handleEndSelectCardReply(status)
	if status == 0 then
		-- block empty
	end
end

function M:sendStartCardSelectHeroRequest(roleId)
	local msg = RoguelikeExtension_pb.StartCardSelectHeroRequest()

	msg.hero = roleId

	self:sendMsg(msg)
end

function M:handleStartCardSelectHeroReply(status)
	if status == 0 then
		-- block empty
	end
end

function M:sendSortRequest(roleIds)
	local msg = RoguelikeExtension_pb.SortRequest()

	for k, v in pairs(roleIds) do
		table.insert(msg.hero, v)
	end

	self:sendMsg(msg)
end

function M:handleSortReply(status)
	if status == 0 then
		FloatWordMgr.instance:show(lang("编队保存成功"))
		RogueMgr.instance:getRogueFlow().model:updateRoleSort()
		RogueMgr.instance:getRogueFlow().mapMgr:setRoleSpine()
	end
end

M.instance = M.New()

return M
