-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearCardPerWeek2025View.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearCardPerWeek2025View", package.seeall)

local YearCardPerWeek2025View = class("YearCardPerWeek2025View", YearCardPerWeek2023View)

function YearCardPerWeek2025View:ctor()
	YearCardPerWeek2025View.super.ctor(self)

	self._curPrizeNum = 8
end

function YearCardPerWeek2025View:buildUI()
	YearCardPerWeek2025View.super.buildUI(self)

	self.skinId = YearCardConfig.instance:getYearcardCommonValue("RaceId_2025", true)
	self._getedGo = self:getGo("reward/geted")
end

function YearCardPerWeek2025View:_refreshGetState(hasGain)
	GameUtil.SetActive(self._btnSure, not hasGain)
	GameUtil.SetActive(self._getedGo, hasGain)
end

return YearCardPerWeek2025View
