-- chunkname: @modules/logic/scene/shelter/comp/bubble/SurvivalBubbleComp.lua

module("modules.logic.scene.shelter.comp.bubble.SurvivalBubbleComp", package.seeall)

local SurvivalBubbleComp = class("SurvivalBubbleComp", BaseSceneComp)

function SurvivalBubbleComp:onSceneStart(sceneId, levelId)
	self.id = 0
	self.bubbleDic = {}
end

function SurvivalBubbleComp:onScenePrepared()
	return
end

function SurvivalBubbleComp:onSceneClose()
	for i, v in pairs(self.bubbleDic) do
		v:disable()
		v:__onDispose()
	end

	tabletool.clear(self.bubbleDic)

	self.playerBubbleId = nil
end

function SurvivalBubbleComp:showBubble(transform, survivalBubbleParam)
	local id = self:getId()
	local survivalBubble = SurvivalBubble.New(id, self)

	survivalBubble:__onInit()
	survivalBubble:setData(survivalBubbleParam, transform)

	self.bubbleDic[id] = survivalBubble

	survivalBubble:enable()
	self:dispatchEvent(SurvivalEvent.OnShowBubble, {
		id = id,
		survivalBubble = survivalBubble
	})

	return id
end

function SurvivalBubbleComp:removeBubble(id)
	if not self.bubbleDic[id] then
		return
	end

	self.bubbleDic[id]:disable()
	self.bubbleDic[id]:__onDispose()

	self.bubbleDic[id] = nil

	self:dispatchEvent(SurvivalEvent.OnRemoveBubble, {
		id = id
	})
end

function SurvivalBubbleComp:isBubbleShow(id)
	return self.bubbleDic[id]
end

function SurvivalBubbleComp:getBubble(id)
	return self.bubbleDic[id]
end

function SurvivalBubbleComp:showPlayerBubble(param)
	if not self:isPlayerBubbleShow() then
		local playerEntity = SurvivalMapHelper.instance:getShelterEntity(SurvivalEnum.ShelterUnitType.Player, 0)

		self.playerBubbleId = self:showBubble(playerEntity.trans, param)

		playerEntity:stopMove()
	end
end

function SurvivalBubbleComp:isPlayerBubbleShow()
	return self.playerBubbleId and self:isBubbleShow(self.playerBubbleId)
end

function SurvivalBubbleComp:removePlayerBubble()
	if self:isPlayerBubbleShow() then
		self:removeBubble(self.playerBubbleId)

		self.playerBubbleId = nil
	end
end

function SurvivalBubbleComp:isPlayerBubbleIntercept()
	local survivalBubbleComp = SurvivalMapHelper.instance:getSurvivalBubbleComp()

	if survivalBubbleComp:isPlayerBubbleShow() then
		survivalBubbleComp:removePlayerBubble()

		return true
	end
end

function SurvivalBubbleComp:getId()
	self.id = self.id + 1

	return self.id
end

return SurvivalBubbleComp
