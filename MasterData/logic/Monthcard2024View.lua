-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/Monthcard2024View.lua

module("logic.extensions.monthcard.view.Monthcard2024View", package.seeall)

local Monthcard2024View = class("Monthcard2024View", MonthcardView)

function Monthcard2024View:_getCardId()
	return MonthCardModel.MonthCardId2024
end

return Monthcard2024View
