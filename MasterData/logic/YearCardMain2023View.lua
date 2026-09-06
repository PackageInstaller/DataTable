-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardMain2023View.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardMain2023View", package.seeall)

local YearCardMain2023View = class("YearCardMain2023View", YearCardMain2022View)

function YearCardMain2023View:buildUI()
	YearCardMain2023View.super.buildUI(self)

	self._curActId = 8003
end

function YearCardMain2023View:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "yearcardRule2023")
end

return YearCardMain2023View
