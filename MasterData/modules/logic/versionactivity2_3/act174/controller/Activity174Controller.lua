-- chunkname: @modules/logic/versionactivity2_3/act174/controller/Activity174Controller.lua

module("modules.logic.versionactivity2_3.act174.controller.Activity174Controller", package.seeall)

local Activity174Controller = class("Activity174Controller", BaseController)

function Activity174Controller:onInit()
	return
end

function Activity174Controller:onInitFinish()
	return
end

function Activity174Controller:addConstEvents()
	return
end

function Activity174Controller:reInit()
	return
end

function Activity174Controller:openMainView(param)
	ViewMgr.instance:openView(ViewName.Act174MainView, param)
end

function Activity174Controller:openStoreView(actId)
	if not VersionActivityEnterHelper.checkCanOpen(actId) then
		return
	end

	self.actId = actId

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(actId, self._openStoreViewAfterRpc, self)
end

function Activity174Controller:_openStoreViewAfterRpc(cmd, resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.Act174StoreView, {
			actId = self.actId
		})
	end

	self.actId = nil
end

function Activity174Controller:openGameView()
	ViewMgr.instance:openView(ViewName.Act174GameView)
end

function Activity174Controller:openForcePickView(forceBagInfo)
	ViewMgr.instance:openView(ViewName.Act174ForcePickView, forceBagInfo)
end

function Activity174Controller:openFightReadyView()
	ViewMgr.instance:openView(ViewName.Act174FightReadyView)
end

function Activity174Controller:playFight(roundList, isRecord)
	local gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	local playerTeam = gameInfo:getTeamMoList()
	local fightInfo = gameInfo:getFightInfo()
	local enemyTeam = fightInfo.matchInfo.teamInfo
	local fightResInfos = fightInfo.fightResInfo

	if not roundList then
		roundList = {}

		for i = 1, #fightResInfos do
			roundList[#roundList + 1] = i
		end
	end

	if #roundList == 0 then
		self:openFightResultView()

		return
	end

	local chapterId = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.ChapterId].value)
	local episodeList = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)
	local episodeCfg = episodeList[math.random(1, #episodeList)]
	local winList = {}

	for i, v in ipairs(fightResInfos) do
		table.insert(winList, v.win)
	end

	local teamInfo = {
		player = playerTeam,
		enemy = enemyTeam,
		win = winList
	}

	FightMgr.instance:playDouQuQu(chapterId, episodeCfg.id, episodeCfg.battleId, roundList, isRecord, teamInfo)
	DungeonModel.instance:SetSendChapterEpisodeId(chapterId, episodeCfg.id)
end

function Activity174Controller:openFightResultView()
	ViewMgr.instance:openView(ViewName.Act174FightResultView)
end

function Activity174Controller:openEndLessView(viewParam)
	ViewMgr.instance:openView(ViewName.Act174EndLessView, viewParam)
end

function Activity174Controller:openSettlementView()
	ViewMgr.instance:openView(ViewName.Act174SettlementView)
end

function Activity174Controller:openItemTipView(viewParam)
	ViewMgr.instance:openView(ViewName.Act174ItemTipView, viewParam)
end

function Activity174Controller:openRoleInfoView(roleId, itemId, pos)
	ViewMgr.instance:openView(ViewName.Act174RoleInfo, {
		roleId = roleId,
		itemId = itemId,
		pos = pos
	})
end

function Activity174Controller:openBuffTipView(isEnemy, pos, isDown)
	pos = pos or Vector2.New(0, 0)

	ViewMgr.instance:openView(ViewName.Act174BuffTipView, {
		isEnemy = isEnemy,
		pos = pos,
		isDown = isDown
	})
end

function Activity174Controller:checkTeamDataWrong(actId)
	local gameInfo = Activity174Model.instance:getActInfo(actId):getGameInfo()
	local teamInfo = gameInfo:getTeamMoList()
	local turnConfig = Activity174Config.instance:getTurnCo(actId, gameInfo.gameCount)

	for i = 1, turnConfig.groupNum do
		local teamMo = teamInfo[i]

		if not teamMo or not teamMo:notEmpty() then
			return true
		end
	end

	return false
end

function Activity174Controller:syncLocalTeam2Server(actId)
	local teamInfo = Activity174Model.instance:getActInfo(actId):getGameInfo():getTeamMoList()

	Activity174Rpc.instance:sendChangeAct174TeamRequest(actId, teamInfo)
end

Activity174Controller.instance = Activity174Controller.New()

return Activity174Controller
