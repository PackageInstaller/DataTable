-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterdepot/agent/HeroDepotAgent.lua

module("logic.extensions.characterdepot.agent.HeroDepotAgent", package.seeall)

local HeroDepotAgent = class("HeroDepotAgent", BaseAgent)
local json = require("cjson")

function HeroDepotAgent:ctor()
	HeroDepotAgent.super.ctor(self)
end

function HeroDepotAgent:sendLoadHerosRequest()
	local req = HeroExtension_pb.LoadHerosRequest()

	self:sendMsg(req)
end

function HeroDepotAgent:handleLoadHerosReply(status, msg)
	if status == 0 then
		HeroDepotModel.instance:initHeroData(msg)
		CharacterInformationController.instance:initHeroData(msg)
	else
		FloatWordMgr.instance:show(lang("tip_get_warehouse_error"))
	end
end

function HeroDepotAgent:sendAddHeroExpRequest(heroId, itemData)
	local req = HeroExtension_pb.AddHeroExpRequest()

	req.heroId = heroId
	req.useItems = json.encode(itemData or "")

	printWarn(req.useItems)
	self:sendMsg(req)
end

function HeroDepotAgent:handleAddHeroExpReply(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatchEvent(EventType.HERO_INFO_CHANGE)
	end
end

function HeroDepotAgent:handleHeroInfoPush(status, msg)
	if status == 0 then
		HeroDepotModel.instance:refreshHeroData(msg.hero, true)
	end
end

function HeroDepotAgent:sendHeroSkillEnhanceRequest(heroId)
	if type(heroId) ~= "number" then
		return
	end

	local req = HeroExtension_pb.HeroSkillEnhanceRequest()

	req.heroId = heroId

	self:sendMsg(req)
end

function HeroDepotAgent:handleHeroSkillEnhanceReply(status, msg)
	if status == 0 then
		SkillEnhanceModel.instance:updateSkillEnhanceInfos(msg)
	else
		SkillEnhanceModel.instance:clearAllRequestingCache()
	end
end

function HeroDepotAgent:handleHeroSkillEnhanceUpdatePush(status, msg)
	if status == 0 then
		SkillEnhanceModel.instance:updateSkillEnhanceInfos(msg)
	else
		SkillEnhanceModel.instance:clearAllRequestingCache()
	end
end

function HeroDepotAgent:sendLoadHeroWeightRequest()
	local req = HeroExtension_pb.LoadHeroWeightRequest()

	self:sendMsg(req)
end

function HeroDepotAgent:handleLoadHeroWeightReply(status, msg)
	if status == 0 then
		CharacterInformationModel.instance:onLoadHeroWeightReply(msg.info, msg.expiredMillis)
	end
end

HeroDepotAgent.instance = HeroDepotAgent.New()

return HeroDepotAgent
