-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/Monthcardback2024View.lua

module("logic.extensions.monthcard.view.Monthcardback2024View", package.seeall)

local Monthcardback2024View = class("Monthcardback2024View", MonthcardView)

function Monthcardback2024View:onEnter()
	Monthcardback2024View.super.onEnter(self)
	GameUtil.SetActive(self._backInfoGo, true)
end

function Monthcardback2024View:_getCardId()
	return MonthCardModel.MonthCardBackId2024
end

return Monthcardback2024View
