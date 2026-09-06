-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonGridEvtModel.lua

module("logic.extensions.season.model.SeasonGridEvtModel", package.seeall)

local SeasonGridEvtModel = class("SeasonGridEvtModel", BaseModel)

SeasonGridEvtModel.Op_View = 1
SeasonGridEvtModel.Op_Mark = 2
SeasonGridEvtModel.Op_UnMark = 3
SeasonGridEvtModel.Op_MoveTo = 4
SeasonGridEvtModel.Op_Open = 5
SeasonGridEvtModel.Op_Fight = 6
SeasonGridEvtModel.Op_Game = 7
SeasonGridEvtModel.Op_AutoFight = 8
SeasonGridEvtModel.Op_LaunchFire = 9
SeasonGridEvtModel.Op_RotateFire = 10
SeasonGridEvtModel.OpNames = {
	[SeasonGridEvtModel.Op_View] = lang("查看"),
	[SeasonGridEvtModel.Op_Mark] = lang("标记"),
	[SeasonGridEvtModel.Op_UnMark] = lang("取消标记"),
	[SeasonGridEvtModel.Op_MoveTo] = lang("移动"),
	[SeasonGridEvtModel.Op_Open] = lang("开启"),
	[SeasonGridEvtModel.Op_Fight] = lang("战斗"),
	[SeasonGridEvtModel.Op_Game] = lang("游戏"),
	[SeasonGridEvtModel.Op_AutoFight] = lang("自动行走"),
	[SeasonGridEvtModel.Op_LaunchFire] = lang("发射火球"),
	[SeasonGridEvtModel.Op_RotateFire] = lang("旋转火球")
}

function SeasonGridEvtModel:ctor()
	return
end

function SeasonGridEvtModel:onInit()
	self:onReset()
end

function SeasonGridEvtModel:onReset()
	self._clickMaxGrid = SeasonConfig.instance:getCommonValue("TEAM_MOVE_MAX_GRID", true)
	self._bBlockOperate = false
end

function SeasonGridEvtModel:setBlockOperateState(bBlock)
	self._bBlockOperate = bBlock
end

function SeasonGridEvtModel:isBlockOperateState()
	return self._bBlockOperate
end

function SeasonGridEvtModel:isHasEvt(id)
	local seasonId = SeasonModel.instance:getSeasonId()
	local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, id)

	return evtConfig ~= nil
end

function SeasonGridEvtModel:isGridIsTransportLink(fromGrid, toGrid)
	if fromGrid ~= toGrid and toGrid ~= nil then
		local seasonId = SeasonModel.instance:getSeasonId()
		local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, fromGrid)

		if evtConfig then
			if evtConfig.eventType ~= SeasonGridEvtTypes.EVT_CONVEY then
				if evtConfig.eventType == SeasonGridEvtTypes.EVT_RAINBOW then
					local linkObjIds = string.splitToNumber(evtConfig.linkObjIds or "", ",")

					for _, linkElementId in ipairs(linkObjIds) do
						local linkGridId = SeasonPathFindingDataModel.instance:getGridIdByElementId(linkElementId)

						if linkGridId == toGrid then
							return true
						end
					end
				end
			end
		end
	end

	return false
end

function SeasonGridEvtModel:isGridCanDoEvent(teamMo, gridId)
	local seasonModel = SeasonModel.instance
	local mapMo = seasonModel:getMapInfoById(gridId)

	if mapMo and mapMo:isInitServerData() then
		local seasonId = seasonModel:getSeasonId()
		local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, gridId)

		if teamMo:isCanTransport() or not seasonModel:isOccupied(gridId) or self:checkIsCanStanDoing(evtConfig) then
			if evtConfig then
				if evtConfig.eventType == SeasonGridEvtTypes.EVT_BOSS_DOPPELGANGER or evtConfig.eventType == SeasonGridEvtTypes.EVT_BOSS then
					return SeasonPVEBossController.instance:isCanDoEvent(evtConfig)
				else
					return true
				end
			end
		end
	end

	return false
end

function SeasonGridEvtModel:checkIsCanStanDoing(evtConfig)
	if evtConfig then
		if evtConfig.eventType == SeasonGridEvtTypes.EVT_CONVEY then
			return true
		elseif evtConfig.eventType == SeasonGridEvtTypes.EVT_RAINBOW then
			return true
		elseif evtConfig.eventType == SeasonGridEvtTypes.EVT_DANCE_LION then
			return true
		end
	end

	return false
end

function SeasonGridEvtModel:getOpGroups(id)
	local teamModel = SeasonTeamsModel.instance
	local seasonModel = SeasonModel.instance
	local gridX, gridY = SeasonPathFindingDataModel.instance:id2Grid(id)
	local seasonId = seasonModel:getSeasonId()
	local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, id) or {}

	if not evtConfig.eventType then
		local eventType = SeasonGridEvtTypes.EVT_EMPTY
		local evtDetailConfig = {}

		if evtConfig.eventId then
			evtDetailConfig = SeasonConfig.instance:getMapEvtDetail(seasonId, eventType, evtConfig.eventId) or {}
		end

		local teamId = teamModel:getCurrTeamId()
		local teamMo = teamModel:getTeam(teamId)
		local serverCurGridX, serverCurGridY = teamMo:getServerCurGridXY()

		if serverCurGridX == nil and serverCurGridY == nil then
			return
		end

		local isInMoveRange = SeasonController.instance:checkIfCanMoveByOccupied(serverCurGridX, serverCurGridY, gridX, gridY)
		local isGridWalkable = SeasonPathFindingDataModel.instance:isGridWalkable(gridX, gridY)
		local isMark = seasonModel:isMark(id)
		local mapMo = seasonModel:getMapInfoById(id)
		local isOccupied = seasonModel:isOccupied(id)

		if mapMo then
			if mapMo._fogState == SeasonMapDataMO.Fog_Within then
				local fogId = SeasonPathFindingDataModel.instance:getElementIdByGridId(SeasonLayerTypes.LAYER_FOG, id)
				local targetGridId = SeasonConfig.instance:getFogRelateToGridElementId(seasonId, fogId)
				local tx, ty = SeasonPathFindingDataModel.instance:id2Grid(targetGridId)

				TipsFacade.instance:openCommonTips(langPara("请先解锁地块(%s,%s)", tx, ty))

				return
			end

			local fogId = SeasonPathFindingDataModel.instance:getElementIdByGridId(SeasonLayerTypes.LAYER_FOG, id)
			local targetGridId = SeasonConfig.instance:getFogRelateToGridElementId(seasonId, fogId)

			if checknumber(targetGridId) > 0 then
				gridMo = seasonModel:getMapInfoById(targetGridId)
				evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, targetGridId)

				if evtConfig.eventType == SeasonGridEvtTypes.EVT_DANCE_LION and gridMo:isLionUnlock(id) == false then
					local tx, ty = SeasonPathFindingDataModel.instance:id2Grid(targetGridId)

					TipsFacade.instance:openCommonTips(langPara("请先前往地块(%s,%s)解锁该地块", tx, ty))

					return
				end
			end
		end

		local isSameGrid = serverCurGridX == gridX and serverCurGridY == gridY
		local bossMo = seasonModel.bossMo

		if not isGridWalkable then
			TipsFacade.instance:openCommonTips(lang("该区域为不可行动区域"))

			return
		end

		if not mapMo or not mapMo:isInitServerData() then
			FloatWordMgr.instance:show(lang("还没加载完地块信息，请稍等"))

			return
		end

		local opGroups = {}

		table.insert(opGroups, SeasonGridEvtModel.Op_View)

		if isMark then
			table.insert(opGroups, SeasonGridEvtModel.Op_UnMark)
		else
			table.insert(opGroups, SeasonGridEvtModel.Op_Mark)
		end

		if isInMoveRange and self:isGridCanDoEvent(teamMo, id) then
			if eventType == SeasonGridEvtTypes.EVT_CHALLENGE and not isOccupied then
				table.insert(opGroups, SeasonGridEvtModel.Op_Fight)
			elseif eventType == SeasonGridEvtTypes.EVT_GAME and not isOccupied then
				table.insert(opGroups, SeasonGridEvtModel.Op_Game)
			elseif eventType == SeasonGridEvtTypes.EVT_MAP_LOCK and not isOccupied then
				table.insert(opGroups, SeasonGridEvtModel.Op_Open)
			elseif eventType == SeasonGridEvtTypes.EVT_WOODEN_STAKE and not isOccupied then
				table.insert(opGroups, SeasonGridEvtModel.Op_Fight)
			elseif eventType == SeasonGridEvtTypes.EVT_DANCE_LION then
				table.insert(opGroups, SeasonGridEvtModel.Op_LaunchFire)
				table.insert(opGroups, SeasonGridEvtModel.Op_RotateFire)
			elseif eventType == SeasonGridEvtTypes.EVT_CAMP then
				-- block empty
			elseif eventType == SeasonGridEvtTypes.EVT_BOSS_DOPPELGANGER then
				local pointIds = SeasonPVEBossController.instance:getDoppelgangerReadOnlyPointIds() or {}

				if not bossMo:isDoppelgangerLockByGridId(id) then
					table.insert(opGroups, SeasonGridEvtModel.Op_Fight)
				end
			elseif eventType == SeasonGridEvtTypes.EVT_BOSS then
				table.insert(opGroups, SeasonGridEvtModel.Op_Fight)
			elseif not isSameGrid then
				table.insert(opGroups, SeasonGridEvtModel.Op_MoveTo)
			elseif self:checkIsCanStanDoing(evtConfig) then
				table.insert(opGroups, SeasonGridEvtModel.Op_MoveTo)
			end
		elseif eventType == SeasonGridEvtTypes.EVT_BOSS_DOPPELGANGER and SeasonPVEBossController.instance:getDoppelgangerPhaseId() == bossMo.phaseId then
			-- block empty
		elseif not isSameGrid then
			if isInMoveRange then
				table.insert(opGroups, SeasonGridEvtModel.Op_MoveTo)
			end
		elseif self:checkIsCanStanDoing(evtConfig) then
			table.insert(opGroups, SeasonGridEvtModel.Op_MoveTo)
		end

		if opGroups == nil or #opGroups == 0 then
			TipsFacade.instance:openCommonTips(lang("该区域为不可行动区域"))
		end

		if opGroups and #opGroups == 2 and isMark and not isSameGrid then
			table.insert(opGroups, SeasonGridEvtModel.Op_AutoFight)
		end

		return opGroups
	end
end

SeasonGridEvtModel.instance = SeasonGridEvtModel.New()

return SeasonGridEvtModel
