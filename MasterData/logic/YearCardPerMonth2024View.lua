-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/main/YearCardPerMonth2024View.lua

module("logic.extensions.yearcard.view.yearcard2024.main.YearCardPerMonth2024View", package.seeall)

local YearCardPerMonth2024View = class("YearCardPerMonth2024View", YearCardPerMonth2023View)

function YearCardPerMonth2024View:buildUI()
	YearCardPerMonth2024View.super.buildUI(self)

	self.skinId = 18001
	self._petCon2Raw = self:getGo("bg/petCon2"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self._petCon1_1Raw = self:getGo("bg/petCon1_1"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self._petCon1_2Raw = self:getGo("bg/petCon1_1/petCon1_2"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self._roleList = {
		{
			skinId = 18001,
			rawImgs = {
				self._petCon1_1Raw,
				self._petCon1_2Raw
			}
		},
		[0] = {
			skinId = 14022,
			rawImgs = {
				self._petCon2Raw
			}
		}
	}
	self._yearCardChangeRole = YearCardChangeRole.New()

	self._yearCardChangeRole:setData(self._roleList)
	self._yearCardChangeRole:setTxtName(self._txtName)
	self._yearCardChangeRole:setView(self)
end

function YearCardPerMonth2024View:onEnter()
	YearCardPerMonth2024View.super.onEnter(self)
	self._yearCardChangeRole:onEnter()
end

function YearCardPerMonth2024View:onExit()
	YearCardPerMonth2024View.super.onExit(self)
	self._yearCardChangeRole:onExit()
end

function YearCardPerMonth2024View:_updateMonthCell(view, goCell, data, tag)
	YearCardPerMonth2024View.super._updateMonthCell(self, view, goCell, data, tag)

	local dateStart = GameUtil.string2date(data.startTime)
	local dateEnd = GameUtil.time2date(YearCardModel.instance:getEndTime(self._curActId))
	local txtTime = goutil.findChildTextComponent(goCell, "time/txtTime")
	local str = "商城48神钻将于24.12.27 5:00后全部过期"

	txtTime.text = "领取时间：" .. string.format("%d.%02d.%02d 05:00-%d.%02d.%02d 05:00\n%s", dateStart.year, dateStart.month, dateStart.day, dateEnd.year, dateEnd.month, dateEnd.day, str)
end

return YearCardPerMonth2024View
