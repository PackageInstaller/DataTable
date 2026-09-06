-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetSelectSortView.lua

module("logic.extensions.cutepet.view.CutePetSelectSortView", package.seeall)

local CutePetSelectSortView = class("CutePetSelectSortView", CutePetSortView)

function CutePetSelectSortView:_dispatchSortEvent(condition, isReverse)
	GlobalDispatcher:dispatch(GlobalNotify.CutePetSelectSortSelect, condition, isReverse)
end

return CutePetSelectSortView
