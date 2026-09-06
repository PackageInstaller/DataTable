-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/YearCardSignin2026View.lua

module("logic.extensions.yearcard.view.yearcard2026.main.YearCardSignin2026View", package.seeall)

local YearCardSignin2026View = class("YearCardSignin2026View", YearCardSignin2023View)

function YearCardSignin2026View:ctor()
	YearCardSignin2026View.super.ctor(self)

	self.skinId = YearCardConfig.instance:getYearcardCommonValue("RaceId_2026", true)
end

function YearCardSignin2026View:buildUI()
	YearCardSignin2026View.super.buildUI(self)
end

function YearCardSignin2026View:_getActId()
	return YearCardConfig.instance:getNextActId()
end

return YearCardSignin2026View
