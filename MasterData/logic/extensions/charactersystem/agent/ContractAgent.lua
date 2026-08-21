-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/agent/ContractAgent.lua

module("logic.extensions.charactersystem.agent.ContractAgent", package.seeall)

local ContractAgent = class("ContractAgent", BaseAgent)

function ContractAgent:ctor()
	ContractAgent.super.ctor(self)
end

function ContractAgent:sendHeroComposeRequest(itemId, multiple)
	local req = HeroBreakExtension_pb.HeroComposeRequest()

	req.itemId = itemId
	req.multiple = multiple

	self:sendMsg(req)
end

function ContractAgent:handleHeroComposeReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.CONTRACT_HERO_COMPOSE)
	end
end

function ContractAgent:sendHeroBreakUpRequest(heroId, useUniver)
	local req = HeroBreakExtension_pb.HeroBreakUpRequest()

	req.heroId = heroId
	req.useUniver = useUniver

	self:sendMsg(req)
end

function ContractAgent:handleHeroBreakUpReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.CONTRACT_BREAKUP)
	elseif enableErrorLog then
		printError("oops,something be wrong" .. tostring(status))
	end
end

ContractAgent.instance = ContractAgent.New()

return ContractAgent
