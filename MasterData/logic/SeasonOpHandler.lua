-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/evt/SeasonOpHandler.lua

module("logic.extensions.season.model.evt.SeasonOpHandler", package.seeall)

local SeasonOpHandler = class("SeasonOpHandler")
local FreeMap = {
	[SeasonGridEvtModel.Op_View] = true,
	[SeasonGridEvtModel.Op_Mark] = true,
	[SeasonGridEvtModel.Op_UnMark] = true
}

function SeasonOpHandler:ctor()
	return
end

function SeasonOpHandler:checkNearByAndShowTips(fromGridX, fromGridY, toGridX, toGridY, evtType)
	return true
end

function SeasonOpHandler:_handleView(evtType, params)
	local seasonId = SeasonModel.instance:getSeasonId()
	local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, params.id) or {}
	local evtDetailConfig = {}

	if evtConfig.eventId then
		evtDetailConfig = SeasonConfig.instance:getMapEvtDetail(seasonId, evtType, evtConfig.eventId) or {}
	end

	if evtType == SeasonGridEvtTypes.EVT_CHALLENGE then
		SeasonPVEBossController.instance:handleOpViewChallenge(seasonId, evtConfig, evtDetailConfig)
	elseif evtType == SeasonGridEvtTypes.EVT_BOSS_DOPPELGANGER then
		UIStateManager.instance:push(ViewName.SeasonBossDetailView, {
			bHideSure = true,
			evtConfig = evtConfig,
			evtDetailConfig = evtDetailConfig
		})
	elseif evtType == SeasonGridEvtTypes.EVT_BOSS then
		SeasonPVEBossController.instance:_handleOpViewBossEvent(seasonId, evtConfig, evtDetailConfig)
	elseif evtType == SeasonGridEvtTypes.EVT_EMPTY then
		UIStateManager.instance:push(ViewName.SeasonDefaultGridShowView, {
			strDesc = lang("这是一个平平无奇的地块"),
			strTitle = langPara("普通地块(%s,%s)", params.toGridX, params.toGridY),
			strSure = lang("关闭"),
			evtConfig = evtConfig
		})
	elseif evtType == SeasonGridEvtTypes.EVT_MATERIAL then
		UIStateManager.instance:push(ViewName.SeasonDefaultGridShowView, {
			strDesc = evtDetailConfig.desc,
			strTitle = langPara("资源地块(%s,%s)", params.toGridX, params.toGridY),
			strSure = lang("关闭"),
			evtConfig = evtConfig,
			strPrize = evtDetailConfig.prize
		})
	elseif evtType == SeasonGridEvtTypes.EVT_PLOT then
		local stroyDesc = lang("一块散落的记忆碎片，记载着一些隐秘的往事\n(获得后查看详情）")

		UIStateManager.instance:push(ViewName.SeasonStoryGridShowView, {
			strDesc = (SeasonModel.instance:isOccupied(params.id) or nil) and evtDetailConfig.desc,
			strTitle = langPara("剧情地块(%s,%s)", params.toGridX, params.toGridY),
			strSure = lang("关闭"),
			evtConfig = evtConfig,
			strPrize = evtDetailConfig.prize,
			evtDetailConfig = evtDetailConfig
		})
	elseif evtType == SeasonGridEvtTypes.EVT_MEDAL then
		UIStateManager.instance:push(ViewName.SeasonMedalGridShowView, {
			strTitle = langPara("徽章地块(%s,%s)", params.toGridX, params.toGridY),
			strSure = lang("关闭"),
			evtConfig = evtConfig,
			evtDetailConfig = evtDetailConfig
		})
	elseif evtType == SeasonGridEvtTypes.EVT_CONVEY then
		local targetElementId = string.splitToNumber(evtConfig.linkObjIds, ",")[1]
		local targetGridId = SeasonPathFindingDataModel.instance:getGridIdByElementId(targetElementId)
		local cGridX, cGridY = SeasonPathFindingDataModel.instance:id2Grid(targetGridId)
		local var_3_0 = {}

		var_3_0.strDesc = string.format(evtDetailConfig.desc or "", cGridX, cGridY)
		var_3_0.evtConfig = evtConfig
		var_3_0.strTitle = langPara("传送地块(%s,%s)", params.toGridX, params.toGridY)
		var_3_0.strSure = lang("关闭")

		UIStateManager.instance:push(ViewName.SeasonDefaultGridShowView, var_3_0)
	elseif evtType == SeasonGridEvtTypes.EVT_RAINBOW then
		local targetElementId = string.splitToNumber(evtConfig.linkObjIds, ",")[1]
		local targetGridId = SeasonPathFindingDataModel.instance:getGridIdByElementId(targetElementId)
		local cGridX, cGridY = SeasonPathFindingDataModel.instance:id2Grid(targetGridId)
		local var_3_1 = {}

		var_3_1.strDesc = string.format(evtDetailConfig.desc or "", cGridX, cGridY)
		var_3_1.evtConfig = evtConfig
		var_3_1.strTitle = langPara("彩虹桥地块(%s,%s)", params.toGridX, params.toGridY)
		var_3_1.strSure = lang("关闭")

		UIStateManager.instance:push(ViewName.SeasonDefaultGridShowView, var_3_1)
	elseif evtType == SeasonGridEvtTypes.EVT_MAP_LOCK then
		UIStateManager.instance:push(ViewName.SeasonIlluStrateGridShowView, {
			strDesc = evtDetailConfig.desc,
			evtConfig = evtConfig,
			strTitle = langPara("机关地块(%s,%s)", params.toGridX, params.toGridY),
			strSure = lang("关闭")
		})
	elseif evtType == SeasonGridEvtTypes.EVT_WOODEN_STAKE then
		local title = not string.nilorempty(evtDetailConfig.titleName) and evtDetailConfig.titleName or "遗迹试炼"

		UIStateManager.instance:push(ViewName.SeasonIlluStrateGridShowView, {
			strDesc = evtDetailConfig.desc,
			evtConfig = evtConfig,
			strTitle = langPara("%s(%s,%s)", title, params.toGridX, params.toGridY),
			strSure = lang("关闭")
		})
	elseif evtType == SeasonGridEvtTypes.EVT_GAME then
		local title = not string.nilorempty(evtDetailConfig.titleName) and evtDetailConfig.titleName or "游戏地块"

		UIStateManager.instance:push(ViewName.SeasonIlluStrateGridShowView, {
			strDesc = evtDetailConfig.desc,
			evtConfig = evtConfig,
			strTitle = langPara("%s(%s,%s)", title, params.toGridX, params.toGridY),
			strSure = lang("关闭"),
			strPrize = evtDetailConfig.prize
		})
	elseif evtType == SeasonGridEvtTypes.EVT_CAMP then
		UIStateManager.instance:push(ViewName.SeasonCampEnterView)
	elseif evtType == SeasonGridEvtTypes.EVT_HIRE_PET then
		local title = not string.nilorempty(evtDetailConfig.titleName) and evtDetailConfig.titleName or "精灵殿地块"

		UIStateManager.instance:push(ViewName.SeasonHirePetGridShowView, {
			bHideSure = true,
			evtConfig = evtConfig,
			strTitle = langPara("%s(%s,%s)", title, params.toGridX, params.toGridY),
			evtDetailConfig = evtDetailConfig
		})
	elseif evtType == SeasonGridEvtTypes.EVT_DANCE_LION then
		local title = "狮头地块"

		UIStateManager.instance:push(ViewName.SeasonIlluStrateGridShowView, {
			strDesc = lang("获得点睛笔之后开启狮子头，之后行走到狮子头附近可以使用狮子头融化冰块。"),
			evtConfig = evtConfig,
			strTitle = langPara("%s(%s,%s)", title, params.toGridX, params.toGridY),
			strSure = lang("关闭")
		})
	elseif evtType == SeasonGridEvtTypes.EVT_FIND_KEY then
		if evtDetailConfig.isKey == true then
			local title = not string.nilorempty(evtDetailConfig.titleName) and evtDetailConfig.titleName or "钥匙地块"

			UIStateManager.instance:push(ViewName.SeasonIlluStrateGridShowView, {
				strDesc = evtDetailConfig.desc,
				evtConfig = evtConfig,
				strTitle = langPara("%s(%s,%s)", title, params.toGridX, params.toGridY),
				strSure = lang("关闭")
			})
		else
			local title = not string.nilorempty(evtDetailConfig.titleName) and evtDetailConfig.titleName or "桃门地块"

			UIStateManager.instance:push(ViewName.SeasonFindKeyGridShowView, {
				evtDetailConfig = evtDetailConfig,
				evtConfig = evtConfig,
				strTitle = langPara("%s(%s,%s)", title, params.toGridX, params.toGridY),
				strSure = lang("关闭")
			})
		end
	end
end

function SeasonOpHandler:_handleMark(evtType, params)
	SeasonController.instance:trySetMark({
		params.id
	}, true)
end

function SeasonOpHandler:_handleUnMark(evtType, params)
	SeasonController.instance:trySetMark({
		params.id
	}, false)
end

function SeasonOpHandler:_handleMoveTo(evtType, params)
	local teamModel = SeasonTeamsModel.instance
	local teamId = teamModel:getCurrTeamId()
	local teamMo = teamModel:getTeam(teamId)

	if not teamMo then
		FloatWordMgr.instance:show(lang("队伍不存在"))
		SeasonAutoFightController.instance:stopAutoFight()

		return
	end

	local isPassAble = SeasonController.instance:isNeighbourAndPassable(params.fromGridX, params.fromGridY, params.toGridX, params.toGridY)

	if isPassAble and not self:checkCanMoveAndShowTips(params.id) then
		SeasonAutoFightController.instance:stopAutoFight()

		return
	end

	SeasonController.instance:applyClientMoveTo(params.toGridX, params.toGridY)
end

function SeasonOpHandler:checkCanMoveAndShowTips(id)
	if SeasonModel.instance:isOccupied(id) then
		return true
	end

	local teamModel = SeasonTeamsModel.instance
	local teamId = teamModel:getCurrTeamId()
	local teamMo = teamModel:getTeam(teamId)

	if not teamMo then
		FloatWordMgr.instance:show(lang("队伍不存在"))

		return false
	end

	local seasonId = SeasonModel.instance:getSeasonId()
	local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, id) or {}
	local evtType = evtConfig.eventType
	local evtDetailConfig = {}

	if evtConfig.eventId then
		evtDetailConfig = SeasonConfig.instance:getMapEvtDetail(seasonId, evtType, evtConfig.eventId) or {}
	end

	local cost = self:_getStrengthCost(seasonId, teamId, evtConfig.cost)

	if checknumber(cost) > 0 and teamMo.teamStrength < checknumber(cost) then
		FloatWordMgr.instance:show(lang("体力不足"))

		return false
	end

	if evtType == SeasonGridEvtTypes.EVT_WOODEN_STAKE then
		local woodenCfg = SeasonConfig.instance:getWoodenDamageConfigs(evtDetailConfig.seasonId, evtDetailConfig.damagePlanId)
		local mo = SeasonModel.instance:getMapInfoById(evtConfig.id)
		local totalCost = 0

		for i, cfg in ipairs(woodenCfg) do
			if mo and mo:getWoodenOldDamage() < cfg.damage then
				totalCost = totalCost + cfg.cost
			end
		end

		local woodenCost = self:_getStrengthCost(seasonId, teamId, totalCost)

		if woodenCost > teamMo.teamStrength then
			FloatWordMgr.instance:show(lang("体力不足"))

			return false
		end
	end

	if evtType == SeasonGridEvtTypes.EVT_FIND_KEY then
		local teamId = SeasonTeamsModel.instance:getCurrTeamId()

		if evtDetailConfig.isKey == false and not SeasonModel.instance:isGetKeyTeam(evtDetailConfig.keyGroupId, teamId) then
			FloatWordMgr.instance:show(lang("需要携带对应桃符的队伍方可占领当前地块"))

			return false
		end
	end

	return true
end

function SeasonOpHandler:_getStrengthCost(seasonId, teamId, strengthCost, costTimes)
	local cost = checknumber(strengthCost)

	if cost == 0 then
		return cost
	end

	if SeasonBadgeModel.instance:isBadgeCollectComplete() then
		cost = cost * SeasonConfig.instance:getCommonValue("ALL_MEDAL_STRENGTH_DISCOUNT", true)
	end

	for i, v in ipairs(SeasonModel.instance:getTotalMapBuffInfo()) do
		local cfg = SeasonConfig.instance:getMapBuffCfg(seasonId, v.buffId)

		if cfg and not string.nilorempty(cfg.clazz) and cfg.clazz == "DecStrengthCost" and v.num > checknumber(costTimes) then
			local param = checknumber(cfg.param)

			cost = cost * (1 - param)
		end
	end

	if teamId then
		for i, v in ipairs(SeasonModel.instance:getMapBuffInfoByTeam(teamId)) do
			local cfg = SeasonConfig.instance:getMapBuffCfg(seasonId, v.buffId)

			if cfg and not string.nilorempty(cfg.clazz) and cfg.clazz == "DecStrengthCost" and v.num > checknumber(costTimes) then
				local param = checknumber(cfg.param)

				cost = cost * (1 - param)
			end
		end
	end

	return cost
end

function SeasonOpHandler:_handleOpen(evtType, params)
	if not self:checkNearByAndShowTips(params.fromGridX, params.fromGridY, params.toGridX, params.toGridY, evtType) then
		return
	end

	self:_handleMoveTo(evtType, params)
end

function SeasonOpHandler:_handleFight(evtType, params)
	if not self:checkNearByAndShowTips(params.fromGridX, params.fromGridY, params.toGridX, params.toGridY, evtType) then
		return
	end

	self:_handleMoveTo(evtType, params)
end

function SeasonOpHandler:_handleGame(evtType, params)
	if not self:checkNearByAndShowTips(params.fromGridX, params.fromGridY, params.toGridX, params.toGridY, evtType) then
		return
	end

	self:_handleMoveTo(evtType, params)
end

function SeasonOpHandler:_handleAutoMove(evtType, params)
	if not self:checkNearByAndShowTips(params.fromGridX, params.fromGridY, params.toGridX, params.toGridY, evtType) then
		return
	end

	self:_handleMoveTo(evtType, params)
end

function SeasonOpHandler:_handleLaunchFire(evtType, params)
	if not self:checkNearByAndShowTips(params.fromGridX, params.fromGridY, params.toGridX, params.toGridY, evtType) then
		return
	end

	local mapMo = SeasonModel.instance:getMapInfoById(params.id)
	local array = mapMo:getLionUnlockArray()

	array = self:getOnALineObjects(params.id, array, mapMo:getRotateDir())

	if #array > 0 then
		self:_handleMoveTo(evtType, params)
	else
		FloatWordMgr.instance:show(lang("这个方向上没有目标"))
	end
end

function SeasonOpHandler:_handleRotateFire(evtType, params)
	local seasonModel = SeasonModel.instance
	local mapMo = seasonModel:getMapInfoById(params.id)

	if mapMo then
		mapMo:rotateDir()
	end

	GlobalDispatcher:dispatch(GlobalNotify.SeasonApplyClientRotateFire, {
		gridX = params.toGridX,
		gridY = params.toGridY,
		id = params.id
	})
end

function SeasonOpHandler:_handle(opType, evtType, params)
	if opType == SeasonGridEvtModel.Op_View then
		self:_handleView(evtType, params)
	elseif opType == SeasonGridEvtModel.Op_Mark then
		self:_handleMark(evtType, params)
	elseif opType == SeasonGridEvtModel.Op_UnMark then
		self:_handleUnMark(evtType, params)
	elseif opType == SeasonGridEvtModel.Op_MoveTo then
		self:_handleMoveTo(evtType, params)
	elseif opType == SeasonGridEvtModel.Op_Open then
		self:_handleOpen(evtType, params)
	elseif opType == SeasonGridEvtModel.Op_Fight then
		self:_handleFight(evtType, params)
	elseif opType == SeasonGridEvtModel.Op_Game then
		self:_handleGame(evtType, params)
	elseif opType == SeasonGridEvtModel.Op_AutoFight then
		self:_handleAutoMove(evtType, params)
	elseif opType == SeasonGridEvtModel.Op_LaunchFire then
		self:_handleLaunchFire(evtType, params)
	elseif opType == SeasonGridEvtModel.Op_RotateFire then
		self:_handleRotateFire(evtType, params)
	end
end

function SeasonOpHandler:_buildParams(toGridX, toGridY, id)
	local teamModel = SeasonTeamsModel.instance
	local teamId = teamModel:getCurrTeamId()
	local teamMo = teamModel:getTeam(teamId)
	local clientCurGridX, clientCurGridY = teamMo:getClientCurGridXY()

	return {
		teamId = teamId,
		fromGridX = clientCurGridX,
		fromGridY = clientCurGridY,
		toGridX = toGridX,
		toGridY = toGridY,
		id = id
	}
end

function SeasonOpHandler:handle(opType, toGridX, toGridY)
	local data = SeasonPathFindingDataModel.instance
	local seasonModel = SeasonModel.instance
	local id = data:grid2Id(toGridX, toGridY)
	local seasonId = seasonModel:getSeasonId()
	local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, id) or {}
	local teamModel = SeasonTeamsModel.instance
	local teamId = teamModel:getCurrTeamId()
	local teamMo = teamModel:getTeam(teamId)

	if not FreeMap[opType] then
		local mapMo = seasonModel:getMapInfoById(id)

		if mapMo:isLock() then
			FloatWordMgr.instance:show(lang("地块已被锁定"))
			SeasonAutoFightController.instance:stopAutoFight()

			return
		end

		if teamMo:isServerLocked() then
			FloatWordMgr.instance:show(lang("队伍已被锁定"))
			SeasonAutoFightController.instance:stopAutoFight()

			return
		end

		if SeasonGridEvtModel.instance:isBlockOperateState() or teamMo:isClientLocked() then
			FloatWordMgr.instance:show(lang("请稍后再试"))
			SeasonAutoFightController.instance:stopAutoFight()

			return
		end
	end

	local params = self:_buildParams(toGridX, toGridY, id)

	self:_handle(opType, evtConfig.eventType or SeasonGridEvtTypes.EVT_EMPTY, params)
	self:_handleReportBehavior(opType, evtConfig.eventType, evtConfig.eventId)
end

function SeasonOpHandler:_handleReportBehavior(opType, eventType, eventId)
	if opType == SeasonGridEvtModel.Op_MoveTo and eventType == SeasonGridEvtTypes.EVT_CONVEY then
		SurveyController.instance:reportBehavior(SurveyBehaviorID.SeasonTransfer)
	elseif opType == SeasonGridEvtModel.Op_Open and eventType == SeasonGridEvtTypes.EVT_MAP_LOCK then
		SurveyController.instance:reportBehavior(SurveyBehaviorID.SeasonPlotAttr, eventId)
	end
end

function SeasonOpHandler:getOnALineObjects(sourceId, objIdArr, dirIdx)
	local x1, y1 = SeasonPathFindingDataModel.instance:id2Grid(sourceId)
	local arr = {}

	for i, v in ipairs(objIdArr or {}) do
		local x2, y2 = SeasonPathFindingDataModel.instance:id2Grid(v)
		local is_on_a_line, dir = self:checkIsOnALine(x1, y1, x2, y2)

		if is_on_a_line and dirIdx == dir then
			table.insert(arr, v)
		end
	end

	table.sort(arr, function(a, b)
		local xa, ya = SeasonPathFindingDataModel.instance:id2Grid(a)
		local xb, yb = SeasonPathFindingDataModel.instance:id2Grid(b)

		if dirIdx == 1 then
			return ya < yb
		elseif dirIdx == 4 then
			return yb < ya
		elseif dirIdx == 2 or dirIdx == 3 then
			return xa < xb
		elseif dirIdx == 5 or dirIdx == 6 then
			return xb < xa
		else
			return false
		end
	end)

	return arr
end

function SeasonOpHandler:checkIsOnALine(x1, y1, x2, y2)
	if x1 == x2 then
		if y1 < y2 then
			return true, 1
		else
			return true, 4
		end
	else
		local posX1, posY1 = self:_toPos(x1, y1)
		local posX2, posY2 = self:_toPos(x2, y2)
		local k = (posY2 - posY1) / (posX2 - posX1)

		if k == 1 then
			if x1 < x2 then
				return true, 2
			else
				return true, 5
			end
		elseif k == -1 then
			if x1 < x2 then
				return true, 3
			else
				return true, 6
			end
		end
	end

	return false, 0
end

function SeasonOpHandler:_toPos(gridX, gridY)
	local gridXT, gridYT = gridX, gridY
	local posX = gridXT * 1
	local posY = gridXT % 2 + gridYT * 2

	return posX, posY
end

SeasonOpHandler.instance = SeasonOpHandler.New()

return SeasonOpHandler
