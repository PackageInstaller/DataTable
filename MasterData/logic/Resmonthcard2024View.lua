-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/Resmonthcard2024View.lua

module("logic.extensions.monthcard.view.Resmonthcard2024View", package.seeall)

local Resmonthcard2024View = class("Resmonthcard2024View", ResMonthCardView)

function Resmonthcard2024View:_getCardId()
	return MonthCardModel.ResMonthCardId2024
end

function Resmonthcard2024View:_loadEffect()
	return
end

return Resmonthcard2024View
