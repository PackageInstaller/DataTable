-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/model/ExpeditionTilingModel.lua

module("logic.extensions.expedition.model.ExpeditionTilingModel", package.seeall)

local ExpeditionTilingModel = class("ExpeditionTilingModel", BaseModel)
local json = require("cjson")
local levelEventId = {
	fightEventNum = ExpeditionModel.EventType.FIGHT,
	prizeEventNum = ExpeditionModel.EventType.PRIZE,
	bigPrizeEventNum = ExpeditionModel.EventType.TREASURE,
	shopEventNum = ExpeditionModel.EventType.SHOP,
	buffEventNum = ExpeditionModel.EventType.BUFF,
	petEventNum = ExpeditionModel.EventType.PET,
	reviveEventNum = ExpeditionModel.EventType.REVIVE
}
local levelEventOrder = {
	"fightEventNum",
	"prizeEventNum",
	"bigPrizeEventNum",
	"shopEventNum",
	"buffEventNum",
	"petEventNum",
	"reviveEventNum"
}

function ExpeditionTilingModel:onInit()
	return
end

function ExpeditionTilingModel:onReset()
	self:resetTilingMapInfos()
end

function ExpeditionTilingModel:parseGridData(grid)
	local info = {}

	info.eventId = grid.eventId
	info.eventIndex = grid.eventIndex
	info.progress = grid.progress
	info.eventInfo = GameUtil.jsonToTable(grid.eventInfo) or {}

	return info
end

function ExpeditionTilingModel:resetTilingMapInfos()
	self.tilingMapInfos = nil
	self.bindGridX = nil
	self.bindGridY = nil
	self.bindEvtIndex = nil
	self.sceneId = nil
	self.isInScene = nil
end

function ExpeditionTilingModel:setTilingMapGrid(bindGridX, bindGridY, bindEvtIndex)
	self.bindGridX = bindGridX
	self.bindGridY = bindGridY
	self.bindEvtIndex = bindEvtIndex
end

function ExpeditionTilingModel:setTilingMapSceneId(sceneId)
	self.sceneId = sceneId
end

function ExpeditionTilingModel:isInTilingMapScene()
	return self.sceneId ~= nil and self.isInScene ~= nil
end

function ExpeditionTilingModel:setInTilingMapScene(isInScene)
	self.isInScene = isInScene
end

function ExpeditionTilingModel:getTilingMapGrid()
	return self.bindGridX, self.bindGridY, self.bindEvtIndex
end

function ExpeditionTilingModel:isTilingMapValid(bindGridX, bindGridY, bindEvtIndex)
	return self.bindGridX == bindGridX and self.bindGridY == bindGridY and self.bindEvtIndex == bindEvtIndex and self.tilingMapInfos ~= nil and self.tilingMapInfos.gridMapId ~= -1
end

function ExpeditionTilingModel:hasGetTilingMapInfos()
	return self.tilingMapInfos ~= nil and self.tilingMapInfos.gridMapId ~= -1 and self.bindGridX ~= nil and self.bindGridY ~= nil and self.bindEvtIndex ~= nil
end

function ExpeditionTilingModel:getTilingMapInfos()
	return self.tilingMapInfos
end

function ExpeditionTilingModel:setTilingMapInfos(infos)
	self.tilingMapInfos = {}
	self.tilingMapInfos.gridMapId = infos.gridMapId
	self.tilingMapInfos.gridList = {}
	self.tilingMapInfos.canLeave = self:getCurEventId() == -1

	if infos and infos.gridList then
		for k, grid in ipairs(infos.gridList) do
			local info = self:parseGridData(grid)

			table.insert(self.tilingMapInfos.gridList, info)
		end
	end
end

function ExpeditionTilingModel:getFinishedTargetCount(evtType)
	if not self.tilingMapInfos or not self.tilingMapInfos.gridList then
		return 0
	end

	local count = 0

	for k, grid in ipairs(self.tilingMapInfos.gridList) do
		if grid.eventId == evtType and ExpeditionModel.instance:isEventCompeleted(grid.eventId, grid.progress) then
			count = count + 1
		end
	end

	return count
end

function ExpeditionTilingModel:getCurEventId()
	if not self.tilingMapInfos or not self.tilingMapInfos.gridList then
		return -1, 0
	end

	local mapConfig = ExpeditionConfig.instance:getMapGripCfg(self.tilingMapInfos.gridMapId)

	if not mapConfig then
		return -1, 0
	end

	for i = 1, #levelEventOrder do
		local count = mapConfig[levelEventOrder[i]]

		if count > 0 then
			local evtId = levelEventId[levelEventOrder[i]]

			if count > self:getFinishedTargetCount(evtId) then
				return evtId, count
			end
		end
	end

	return -1, 0
end

function ExpeditionTilingModel:getCurGridDatas()
	local evtId = self:getCurEventId()

	if evtId == -1 then
		return
	end

	local datas

	for k, grid in ipairs(self.tilingMapInfos.gridList) do
		if grid.eventId == evtId then
			datas = datas or {}

			table.insert(datas, grid)
		end
	end

	return datas
end

function ExpeditionTilingModel:getGridDatasByEventIndex(eventIndex)
	for k, grid in ipairs(self.tilingMapInfos.gridList) do
		if grid.eventIndex == eventIndex then
			return grid
		end
	end

	return nil
end

function ExpeditionTilingModel:updateTilingMapInfos(infos, canLeave)
	if not infos or not self.tilingMapInfos or not self.tilingMapInfos.gridList then
		return
	end

	for k, grid in ipairs(self.tilingMapInfos.gridList) do
		if grid.eventIndex == infos.eventIndex then
			grid.eventId = infos.eventId
			grid.progress = infos.progress
			grid.eventInfo = GameUtil.jsonToTable(infos.eventInfo) or {}

			break
		end
	end

	self.tilingMapInfos.canLeave = self:getCurEventId() == -1

	TilingSceneMgr.instance:updateExpEventMapConfig(self.sceneId)
end

function ExpeditionTilingModel:_checkCanLeave()
	if self.tilingMapInfos.canLeave then
		return
	end

	for i = 1, #self.tilingMapInfos.gridList do
		local gridData = self.tilingMapInfos.gridList[i]

		if not ExpeditionModel.instance:isEventCompeleted(gridData.eventId, gridData.progress) then
			return
		end
	end

	self.tilingMapInfos.canLeave = true
end

ExpeditionTilingModel.instance = ExpeditionTilingModel.New()

return ExpeditionTilingModel
