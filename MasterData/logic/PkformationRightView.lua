-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkformationRightView.lua

module("logic.extensions.pk.view.PkformationRightView", package.seeall)

local PkformationRightView = class("PkformationRightView", FormationRightView)

function PkformationRightView:_getCurFormation()
	return TraincampqiecuoModel.instance:getMyFormation()
end

function PkformationRightView:rankNow()
	local names, opt = BagModel.instance:GetSortParms(self:getPetAtCurFormationFunc())

	if FormationController.instance:checkCanSort(self._curViewDatas) then
		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._tableview:ReloadData()
end

return PkformationRightView
