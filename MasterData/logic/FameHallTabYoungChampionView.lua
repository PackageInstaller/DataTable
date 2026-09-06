-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/view/tab/FameHallTabYoungChampionView.lua

module("logic.extensions.famehall.view.tab.FameHallTabYoungChampionView", package.seeall)

local FameHallTabYoungChampionView = class("FameHallTabYoungChampionView", FameHallTabBaseView)

function FameHallTabYoungChampionView:_initData()
	self._seasonListData = {}

	local dataList = FameHallConfig.instance:getTeenChampionSeasonDataList()

	for i, v in ipairs(dataList) do
		local actCfg = ActivityDefineConfig.instance:getCfgByActivitYId(v.activityId)
		local time = GameUtil.string2time(actCfg.endTime)

		if time < ServerTime.now() then
			table.insert(self._seasonListData, {
				activityId = actCfg.activityId,
				index = i
			})
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

function FameHallTabYoungChampionView:getTitleName()
	return langPara("第%s届少年竞技王全服总冠军", GameUtil.getChineseNumber(self._curSelectSeason))
end

function FameHallTabYoungChampionView:getCellDesc(seasonId)
	return langPara("第%s届", GameUtil.getChineseNumber(seasonId))
end

return FameHallTabYoungChampionView
