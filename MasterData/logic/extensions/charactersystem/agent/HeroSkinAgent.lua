-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/agent/HeroSkinAgent.lua

module("logic.extensions.charactersystem.agent.HeroSkinAgent", package.seeall)

local HeroSkinAgent = class("HeroSkinAgent", BaseAgent)

function HeroSkinAgent:sendHeroSkinInfoRequest(heroId)
	local req = HeroSkinExtension_pb.HeroSkinInfoRequest()

	req.heroId = heroId

	self:sendMsg(req)
end

function HeroSkinAgent:handleHeroSkinInfoReply(status, msg)
	if status == 0 then
		HeroSkinModel.instance:initAgent(msg.info)
		GlobalDispatcher:dispatchEvent(EventType.REFRESH_HERO_SKIN_EVENT)
	elseif enableErrorLog then
		printError("oops,something be wrong" .. tostring(status))
	end
end

function HeroSkinAgent:sendHeroSkinSetRequest(heroId, skinId)
	local req = HeroSkinExtension_pb.HeroSkinSetRequest()

	req.heroId = heroId
	req.skinId = skinId

	self:sendMsg(req)
	CriwareAudioFacade.instance:playVoiceByName(string.format("speech_%s_huanzhuan", heroId))
end

function HeroSkinAgent:handleHeroSkinSetReply(status, msg)
	if status == 0 then
		HeroSkinModel.instance:initAgent(msg.info)
		GlobalDispatcher:dispatchEvent(EventType.REFRESH_HERO_SKIN_EVENT)
	elseif enableErrorLog then
		printError("oops,something be wrong" .. tostring(status))
	end
end

function HeroSkinAgent:sendGetAllHeroSkinInfoRequest()
	local req = HeroSkinExtension_pb.GetAllHeroSkinInfoRequest()

	self:sendMsg(req)
end

function HeroSkinAgent:handleGetAllHeroSkinInfoReply(status, msg)
	if status == 0 then
		HeroSkinModel.instance:initAllUnlockSkins(msg.ownedSkinIds)
		GlobalDispatcher:dispatchEvent(EventType.REFRESH_ALL_UNLOCK_SKIN_EVENT)
	elseif enableErrorLog then
		printError("oops,something be wrong" .. tostring(status))
	end
end

HeroSkinAgent.instance = HeroSkinAgent.New()

return HeroSkinAgent
