-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/YearCardPerMonth2026View.lua

module("logic.extensions.yearcard.view.yearcard2026.main.YearCardPerMonth2026View", package.seeall)

local YearCardPerMonth2026View = class("YearCardPerMonth2026View", YearCardPerMonth2023View)

function YearCardPerMonth2026View:buildUI()
	YearCardPerMonth2026View.super.buildUI(self)

	self.skinId = YearCardConfig.instance:getYearcardCommonValue("RaceId_2026", true)
end

function YearCardPerMonth2026View:_updateMonthCell(view, goCell, data, tag)
	YearCardPerMonth2026View.super._updateMonthCell(self, view, goCell, data, tag)

	local txtTime = goutil.findChildTextComponent(goCell, "time/txtTime")
	local dateStart = GameUtil.string2date(data.startTime)
	local dateEnd = GameUtil.time2date(YearCardModel.instance:getEndTime(self._curActId))
	local str = "商城48神钻抵扣券将于27.02.01 5:00后全部过期"

	txtTime.text = "领取时间：" .. string.format("%d.%02d.%02d 05:00-%d.%02d.%02d 05:00\n%s", dateStart.year, dateStart.month, dateStart.day, dateEnd.year, dateEnd.month, dateEnd.day, str)
end

function YearCardPerMonth2026View:_getActId()
	return YearCardConfig.instance:getNextActId()
end

return YearCardPerMonth2026View
