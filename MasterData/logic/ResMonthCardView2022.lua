-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/ResMonthCardView2022.lua

module("logic.extensions.monthcard.view.ResMonthCardView2022", package.seeall)

local ResMonthCardView2022 = class("ResMonthCardView2022", ResMonthCardView)

function ResMonthCardView2022:_getCardId()
	return MonthCardModel.ResMonthCardId2022
end

return ResMonthCardView2022
