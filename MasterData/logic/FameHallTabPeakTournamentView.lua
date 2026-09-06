-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/view/tab/FameHallTabPeakTournamentView.lua

module("logic.extensions.famehall.view.tab.FameHallTabPeakTournamentView", package.seeall)

local FameHallTabPeakTournamentView = class("FameHallTabPeakTournamentView", FameHallTabBaseView)

function FameHallTabPeakTournamentView:_initData()
	self._seasonListData = {}

	local dataList = PeakTournamentConfig.instance:getPeakActivityList()
	local index = 1

	for i, v in ipairs(dataList) do
		local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.PeakTournament, v.activityId)
		local time = GameUtil.string2time(actCfg.endTime)

		if time < ServerTime.now() and actCfg.activityId >= 217011 then
			table.insert(self._seasonListData, {
				activityId = actCfg.activityId,
				index = index
			})

			index = index + 1
		end
	end

	self._isInitData = false

	if #self._seasonListData <= 0 then
		table.insert(self._seasonListData, {
			index = 1,
			activityId = dataList[1].activityId
		})

		self._isInitData = true
	end

	self._curSelectSeason = #self._seasonListData

	self:_updateData()
end

function FameHallTabPeakTournamentView:getTitleName()
	return langPara("第%s赛季巅峰赛全服总冠军", GameUtil.getChineseNumber(self._curSelectSeason))
end

function FameHallTabPeakTournamentView:getCellDesc(seasonId)
	return langPara("第%s赛季", GameUtil.getChineseNumber(seasonId))
end

return FameHallTabPeakTournamentView
