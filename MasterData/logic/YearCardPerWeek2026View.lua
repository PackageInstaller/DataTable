-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/YearCardPerWeek2026View.lua

module("logic.extensions.yearcard.view.yearcard2026.main.YearCardPerWeek2026View", package.seeall)

local YearCardPerWeek2026View = class("YearCardPerWeek2026View", YearCardPerWeek2023View)

function YearCardPerWeek2026View:ctor()
	YearCardPerWeek2026View.super.ctor(self)

	self._curPrizeNum = 6
end

function YearCardPerWeek2026View:buildUI()
	YearCardPerWeek2026View.super.buildUI(self)

	self.skinId = YearCardConfig.instance:getYearcardCommonValue("RaceId_2026", true)
	self._getedGo = self:getGo("reward/geted")
end

function YearCardPerWeek2026View:_refreshGetState(hasGain)
	GameUtil.SetActive(self._btnSure, not hasGain)
	GameUtil.SetActive(self._getedGo, hasGain)
end

function YearCardPerWeek2026View:_getActId()
	return YearCardConfig.instance:getNextActId()
end

return YearCardPerWeek2026View
