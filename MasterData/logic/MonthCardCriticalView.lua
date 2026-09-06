-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/MonthCardCriticalView.lua

module("logic.extensions.monthcard.view.MonthCardCriticalView", package.seeall)

local MonthCardCriticalView = class("MonthCardCriticalView", MonthcardView)

function MonthCardCriticalView:_getCardId()
	return MonthCardModel.MonthCardCritical
end

return MonthCardCriticalView
