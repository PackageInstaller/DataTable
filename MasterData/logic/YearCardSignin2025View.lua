-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearCardSignin2025View.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearCardSignin2025View", package.seeall)

local YearCardSignin2025View = class("YearCardSignin2025View", YearCardSignin2023View)

function YearCardSignin2025View:ctor()
	YearCardSignin2025View.super.ctor(self)

	self.skinId = YearCardConfig.instance:getYearcardCommonValue("RaceId_2025", true)
end

function YearCardSignin2025View:buildUI()
	YearCardSignin2025View.super.buildUI(self)
end

return YearCardSignin2025View
