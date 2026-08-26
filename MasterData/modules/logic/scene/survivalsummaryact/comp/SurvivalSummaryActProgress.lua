-- chunkname: @modules/logic/scene/survivalsummaryact/comp/SurvivalSummaryActProgress.lua

module("modules.logic.scene.survivalsummaryact.comp.SurvivalSummaryActProgress", package.seeall)

local SurvivalSummaryActProgress = class("SurvivalSummaryActProgress", BaseSceneComp)

function SurvivalSummaryActProgress:ctor()
	return
end

function SurvivalSummaryActProgress:onSceneStart(sceneId, levelId)
	self.weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	local shelterMapId = self.weekInfo.shelterMapId

	self.mapCo = lua_survival_shelter.configDict[shelterMapId]
	self.npcDataList = {}

	local npcList = SurvivalMapModel.instance.resultData:getFirstNpcMos()

	for k, v in ipairs(npcList) do
		local data = {
			id = v.id,
			resource = v.co.resource,
			config = v.co
		}

		table.insert(self.npcDataList, data)
	end
end

function SurvivalSummaryActProgress:onScenePrepared()
	self.sceneGo = GameSceneMgr.instance:getCurScene().level:getSceneGo()
	self.npcRoot = gohelper.create3d(self.sceneGo, "NpcRoot")

	local playerPos = string.splitToNumber(self.mapCo.orderPosition, ",")
	local pos = SurvivalHexNode.New(playerPos[1], playerPos[2])

	self.playerEntity = SurvivalSummaryActPlayerEntity.Create(pos, self.mapCo.toward, self.sceneGo)
	self.npcList = {}

	local npcPosList = GameUtil.splitString2(self.mapCo.npcPosition, true, "#", ",")

	for i, v in ipairs(self.npcDataList) do
		local pos = npcPosList[i]

		if pos then
			local npc = SurvivalSummaryActNpcEntity.Create(self.npcDataList[i].resource, self.npcRoot, SurvivalHexNode.New(pos[1], pos[2]))

			table.insert(self.npcList, npc)
		else
			logError("npc很多，配置位置不够")
		end
	end
end

function SurvivalSummaryActProgress:onSceneClose(...)
	return
end

return SurvivalSummaryActProgress
