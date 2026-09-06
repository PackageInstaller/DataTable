-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/tiling/TilingElem.lua

module("logicscene.scene.tiling.TilingElem", package.seeall)

local TilingElem = class("TilingElem")
local ExpedElemMap = {
	[ExpeditionModel.EventType.FIGHT] = TilingElemScene.Monster,
	[ExpeditionModel.EventType.PET] = TilingElemScene.Pets,
	[ExpeditionModel.EventType.BUFF] = TilingElemScene.Buff,
	[ExpeditionModel.EventType.PRIZE] = TilingElemScene.Box,
	[ExpeditionModel.EventType.REVIVE] = TilingElemScene.RevivePos,
	[ExpeditionModel.EventType.SHOP] = TilingElemScene.Businessman,
	[ExpeditionModel.EventType.TREASURE] = TilingElemScene.HugeBox
}

function TilingElem:ctor()
	self.bindExpGridData = nil
	self.position = nil
end

function TilingElem:fromExpedGridData(gridData)
	self.bindExpGridData = gridData
	self.elemData = SceneConfig.instance:getRandomTilingElem((gridData.eventId == ExpeditionModel.EventType.FIGHT and gridData.progress == 1 or nil) and TilingElemScene.Buff)

	if self.elemData.scene == TilingElemScene.Monster then
		self.elemData = clone(self.elemData)

		local skinId = ExpeditionFmtModel.instance:getFightingMonsterRaceId(self.bindExpGridData.eventInfo)
		local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

		self.elemData.assetPath = string.gsub(GameUrl.getSpineUrl(modelCo.resName), ".prefab", "")

		local modelCfg = CharactorFacade.instance:getFormationModelUIPosAndScale(modelCo.id)

		if not modelCfg[3] then
			self.elemData.scale = modelCfg[3] * 0.35
			self.elemData.speed = 0
			self.elemData.shadowScale = math.min(modelCo.shadowScale[1], modelCo.shadowScale[2])
		end
	end
end

return TilingElem
