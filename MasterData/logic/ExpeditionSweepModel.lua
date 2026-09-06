-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/model/ExpeditionSweepModel.lua

module("logic.extensions.expedition.model.ExpeditionSweepModel", package.seeall)

local ExpeditionSweepModel = class("ExpeditionSweepModel", BaseModel)
local ViewsPriority = {
	[ViewName.ExpBattleEvent] = 1,
	[ViewName.ExpBuffEvent] = 2,
	[ViewName.ExpPetEvent] = 3,
	[ViewName.ExpPrizeEvent] = 4,
	[ViewName.ExpReviveEvent] = 5,
	[ViewName.ExpShopEvent] = 6
}

function ExpeditionSweepModel:onInit()
	self:onReset()
end

function ExpeditionSweepModel:onReset()
	self._sweepEvents = nil
end

function ExpeditionSweepModel:getSweepOpenedLevel()
	return ExpeditionConfig.instance:getConstInt("sweepNeedLv")
end

function ExpeditionSweepModel:isLevelSweepable()
	if ExpeditionModel.instance:isToLevelEnded() then
		return false
	end

	local info = ExpeditionModel.instance:getInfo()

	if not info then
		return false
	end

	if info.xAxis ~= 0 or info.yAxis ~= 0 or info.nextXAixs ~= 0 or info.nextYAixs ~= 0 then
		return false
	end

	if ExpeditionTilingModel.instance:hasGetTilingMapInfos() then
		return false
	end

	local lvCo = ExpeditionConfig.instance:getNextLevelCo(info.level + 1)

	if GoldenDiamondCardModel.instance.isUser == true and lvCo and lvCo.level <= GoldenDiamondCardConfig.instance:getPrivilegeDefaultValue(GoldenDiamondCardModel.PrivilegeType.ExpMapSweepLevel) then
		return true
	end

	return lvCo and lvCo.canSweep
end

function ExpeditionSweepModel:setSweepEvents(sweepEvents)
	local infoSweepEvents = {}

	for i = 1, #sweepEvents do
		local gridData = sweepEvents[i]

		if not ExpeditionModel.instance:isEventCompeleted(gridData.eventId, gridData.progress) then
			local viewName = ExpeditionController.instance:getViewNameByEventData(gridData)

			if viewName then
				infoSweepEvents[viewName] = infoSweepEvents[viewName] or {}

				local info = ExpeditionTilingModel.instance:parseGridData(gridData)

				table.insert(infoSweepEvents[viewName], info)
			end
		end
	end

	self._sweepEvents = {}

	for k, v in pairs(infoSweepEvents) do
		table.insert(self._sweepEvents, {
			viewName = k,
			gridDatas = v
		})
	end

	table.sort(self._sweepEvents, function(x, y)
		local xPriority = ViewsPriority[x.viewName]
		local yPriority = ViewsPriority[y.viewName]

		return xPriority - yPriority < 0
	end)
end

function ExpeditionSweepModel:existSweepEvents()
	return self._sweepEvents and #self._sweepEvents > 0
end

function ExpeditionSweepModel:getNextSweepEvents()
	if self:existSweepEvents() then
		return self._sweepEvents[1]
	end
end

function ExpeditionSweepModel:onDoSweepEvent(msg)
	local newGridData = self:updateSweepEvent(msg.evetGrid)

	if not newGridData then
		return
	end

	if ExpeditionModel.instance:isEventCompeleted(newGridData.eventId, newGridData.progress) then
		self:removeSweepEvent(newGridData)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnSweepSelEventBack, newGridData)
end

function ExpeditionSweepModel:updateSweepEvent(evetGrid)
	if not self:existSweepEvents() then
		return
	end

	local found

	for i = 1, #self._sweepEvents do
		for j = 1, #self._sweepEvents[i].gridDatas do
			local gData = self._sweepEvents[i].gridDatas[j]

			if gData.eventId == evetGrid.eventId and gData.eventIndex == evetGrid.eventIndex then
				self._sweepEvents[i].gridDatas[j] = ExpeditionTilingModel.instance:parseGridData(evetGrid)
				found = self._sweepEvents[i].gridDatas[j]

				break
			end
		end

		if found then
			break
		end
	end

	return found
end

function ExpeditionSweepModel:removeSweepEvent(evetGrid)
	if not self:existSweepEvents() then
		return
	end

	local found

	for i = 1, #self._sweepEvents do
		for j = 1, #self._sweepEvents[i].gridDatas do
			local gData = self._sweepEvents[i].gridDatas[j]

			if gData.eventId == evetGrid.eventId and gData.eventIndex == evetGrid.eventIndex then
				found = self._sweepEvents[i].gridDatas[j]

				table.remove(self._sweepEvents[i].gridDatas, j)

				if #self._sweepEvents[i].gridDatas == 0 then
					table.remove(self._sweepEvents, i)
				end

				break
			end
		end

		if found then
			break
		end
	end

	return found
end

function ExpeditionSweepModel:onSweepLevelBack(msg)
	self:setSweepEvents(msg.sweepEvents)
end

function ExpeditionSweepModel:resetSweepsInfo()
	for k, v in pairs(ViewsPriority) do
		ViewMgr.instance:close(k)
	end

	self._sweepEvents = {}
end

ExpeditionSweepModel.instance = ExpeditionSweepModel.New()

return ExpeditionSweepModel
