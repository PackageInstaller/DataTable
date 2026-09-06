-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/MonthcardView2022.lua

module("logic.extensions.monthcard.view.MonthcardView2022", package.seeall)

local MonthcardView2022 = class("MonthcardView2022", MonthcardView)

function MonthcardView2022:_getCardId()
	return MonthCardModel.MonthCardId2022
end

return MonthcardView2022
