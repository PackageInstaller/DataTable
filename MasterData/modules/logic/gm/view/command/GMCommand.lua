-- chunkname: @modules/logic/gm/view/command/GMCommand.lua

module("modules.logic.gm.view.command.GMCommand", package.seeall)

local GMCommand = class("GMCommand")

function GMCommand.processCmd(cmdName, ...)
	if GMCommand[cmdName] then
		GMCommand[cmdName](...)
	end
end

function GMCommand.decryptSuccess()
	Role37PuzzleModel.instance:Finish(true)
end

function GMCommand.v3a7towerhp(id, hp)
	TowerV3a7Controller.instance:dispatchEvent(TowerV3a7Event.GMModifyChessHp, tonumber(id), tonumber(hp))
end

function GMCommand.dungeon(chapterIndex, episodeIndex)
	local episodeId

	chapterIndex = tonumber(chapterIndex) or 0
	episodeIndex = tonumber(episodeIndex)

	local chapterCo = lua_chapter.configDict[100 + chapterIndex]

	if chapterCo then
		local episodeList = DungeonConfig.instance:getChapterNonSpEpisodeCOList(chapterCo.id)

		episodeId = episodeList and episodeList[episodeIndex] and episodeList[episodeIndex].id
	end

	if episodeId then
		GMRpc.instance:sendGMRequest(string.format("set dungeon %d", episodeId))
	end
end

function GMCommand.weather(reportId)
	reportId = tonumber(reportId)

	WeatherController.instance:setReportId(reportId)
end

function GMCommand.printreport()
	local report = WeatherController.instance._curReport

	if report then
		print("report id:", report.id)
	end
end

function GMCommand.mainheromode(param)
	local showInScene = tonumber(param) == 1
	local mainViewContainer = ViewMgr.instance:getContainer(ViewName.MainView)

	if mainViewContainer then
		mainViewContainer:getMainHeroView():debugShowMode(showInScene)
	end
end

function GMCommand.weekwalksettlement(param)
	ViewMgr.instance:closeView(ViewName.GMToolView)

	local type = tonumber(param)

	if type == 1 then
		WeekWalkController.instance:openWeekWalkShallowSettlementView()
	end

	if type == 2 then
		WeekWalkController.instance:openWeekWalkDeepLayerNoticeView()
	end

	if type == 3 then
		local info = WeekWalkModel.instance:getInfo()

		info.isPopDeepSettle = true

		WeekWalkController.instance:openWeekWalkShallowSettlementView()
	end

	if type == 4 then
		WeekWalk_2Controller.instance:openWeekWalk_2DeepLayerNoticeView()
	end

	if type == 5 then
		local info = WeekWalkModel.instance:getInfo()

		info.isPopDeepSettle = true

		local info = WeekWalk_2Model.instance:getInfo()

		info.isPopSettle = true

		WeekWalkController.instance:openWeekWalkShallowSettlementView()
	end
end

function GMCommand.finishLayer(startIndex, endIndex)
	local cmdList = {
		"set weekwalkElement 101 10117 3",
		"set weekwalkElement 102 30130 1",
		"set weekwalkElement 103 50117 3",
		"set weekwalkElement 104 201152 1",
		"set weekwalkElement 105 40412 3",
		"set weekwalkElement 201 10129 2",
		"set weekwalkElement 202 30121 3",
		"set weekwalkElement 203 50218 1",
		"set weekwalkElement 204 201151 1",
		"set weekwalkElement 205 40419 1"
	}

	startIndex = tonumber(startIndex)
	endIndex = tonumber(endIndex)

	if startIndex < 1 or startIndex > #cmdList then
		return
	end

	if endIndex < 1 or endIndex > #cmdList then
		return
	end

	for i = startIndex, endIndex do
		local cmd = cmdList[i]

		GMRpc.instance:sendGMRequest(cmd)
	end
end

function GMCommand.clearTrialData(battleId)
	if battleId then
		local prefsKey = PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. battleId

		PlayerPrefsHelper.deleteKey(prefsKey)
	else
		for id in pairs(lua_battle.configDict) do
			local prefsKey = PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. id

			PlayerPrefsHelper.deleteKey(prefsKey)
		end
	end
end

function GMCommand.enterSurvival(copyId)
	GMSubViewSurvival.enterSurvival(_, tonumber(copyId))
end

return GMCommand
