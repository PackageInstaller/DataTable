-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/view/tab/FameHallTabRankRaceView.lua

module("logic.extensions.famehall.view.tab.FameHallTabRankRaceView", package.seeall)

local FameHallTabRankRaceView = class("FameHallTabRankRaceView", FameHallTabBaseView)

function FameHallTabRankRaceView:_initData()
	self._seasonListData = {}

	local dataList = RankRaceConfig.instance:getSeasonTimeCfgList()
	local firstIndex = 0
	local firstActivity = 202324
	local index = 1

	for i, v in ipairs(dataList) do
		if i ~= #dataList and firstActivity <= v.seasonId and GameUtil.string2time(dataList[i + 1].startTime) < ServerTime.now() then
			table.insert(self._seasonListData, {
				activityId = v.seasonId,
				index = index,
				seasonId = i
			})

			index = index + 1
		end

		if v.seasonId == firstActivity then
			firstIndex = i
		end
	end

	self._isInitData = false

	if #self._seasonListData <= 0 then
		table.insert(self._seasonListData, {
			index = 1,
			activityId = firstActivity,
			seasonId = firstIndex
		})

		self._isInitData = true
	end

	self._curSelectSeason = #self._seasonListData

	self:_updateData()
end

function FameHallTabRankRaceView:getTitleName()
	local params = self:getFirstParam()
	local data = self._seasonListData[self._curSelectSeason]
	local seasonId = 1

	if data then
		seasonId = data.seasonId
	end

	if params.typeId == 4 then
		return langPara("第%s赛季经典排位赛第一名", GameUtil.getChineseNumber(seasonId))
	elseif params.typeId == 5 then
		return langPara("第%s赛季极限排位赛第一名", GameUtil.getChineseNumber(seasonId))
	else
		return FameHallTabRankRaceView.super.getTitleName()
	end
end

function FameHallTabRankRaceView:getCellDesc(index)
	local data = self._seasonListData[index]
	local seasonId = 1

	if data then
		seasonId = data.seasonId
	end

	return langPara("第%s赛季", GameUtil.getChineseNumber(index))
end

function FameHallTabRankRaceView:_refreshView()
	FameHallTabRankRaceView.super._refreshView(self)

	local seasonId = self._seasonListData[self._curSelectSeason].seasonId

	goutil.setActive(self._rankScoreGo, seasonId >= 46)

	self._txtRankScore.text = checknumber(self._extParam)
end

return FameHallTabRankRaceView
