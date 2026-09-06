-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardInstallment2023View.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardInstallment2023View", package.seeall)

local YearCardInstallment2023View = class("YearCardInstallment2023View", YearCardInstallmentView)

function YearCardInstallment2023View:ctor()
	YearCardInstallment2023View.super.ctor(self)

	self._curCellCount = 2
end

return YearCardInstallment2023View
