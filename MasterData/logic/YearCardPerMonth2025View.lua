-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearCardPerMonth2025View.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearCardPerMonth2025View", package.seeall)

local YearCardPerMonth2025View = class("YearCardPerMonth2025View", YearCardPerMonth2023View)

function YearCardPerMonth2025View:buildUI()
	YearCardPerMonth2025View.super.buildUI(self)

	self.skinId = YearCardConfig.instance:getYearcardCommonValue("RaceId_2025", true)
end

function YearCardPerMonth2025View:_updateMonthCell(view, goCell, data, tag)
	YearCardPerMonth2025View.super._updateMonthCell(self, view, goCell, data, tag)

	local txtTime = goutil.findChildTextComponent(goCell, "time/txtTime")
	local dateStart = GameUtil.string2date(data.startTime)
	local dateEnd = GameUtil.time2date(YearCardModel.instance:getEndTime(self._curActId))
	local str = "商城48神钻抵扣券将于26.02.01 5:00后全部过期"

	txtTime.text = "领取时间：" .. string.format("%d.%02d.%02d 05:00-%d.%02d.%02d 05:00\n%s", dateStart.year, dateStart.month, dateStart.day, dateEnd.year, dateEnd.month, dateEnd.day, str)
end

return YearCardPerMonth2025View
