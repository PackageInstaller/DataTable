-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/MonthcardBackView.lua

module("logic.extensions.monthcard.view.MonthcardBackView", package.seeall)

local MonthcardBackView = class("MonthcardBackView", MonthcardView)

function MonthcardBackView:onEnter()
	MonthcardBackView.super.onEnter(self)
	GameUtil.SetActive(self._backInfoGo, true)
end

function MonthcardBackView:_getCardId()
	return MonthCardModel.MonthCardBackId
end

return MonthcardBackView
