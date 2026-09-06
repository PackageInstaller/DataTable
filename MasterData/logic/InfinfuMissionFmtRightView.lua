-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinfuMissionFmtRightView.lua

module("logic.extensions.infinitefuture.view.InfinfuMissionFmtRightView", package.seeall)

local InfinfuMissionFmtRightView = class("InfinfuMissionFmtRightView", FormationRightView)

function InfinfuMissionFmtRightView:updateForbit(data)
	local isLock = InfinitefutureModel.instance:isBeLock(data.raceId)
	local inTeam = self:getInTeam(data)
	local hasUp = false
	local hasOneHire = self:getHasHireInTeam(data)
	local canNotUp, hasOne = false, false
	local canNotUpWithYuan = self:getYuanLimit(data)

	data:setPetForbit(not inTeam and (isLock or hasUp or hasOneHire or canNotUp or hasOne or canNotUpWithYuan))
end

function InfinfuMissionFmtRightView:_initAllPetList()
	local params = self:getOpenParam()
	local activityId = params[1]

	self._allPetList = InfinitefutureModel.instance:GetAllPetList(activityId)
end

function InfinfuMissionFmtRightView:_getCurFormation()
	local params = self:getOpenParam()

	return InfinitefutureModel.instance:GetCurFormation(params[1])
end

function InfinfuMissionFmtRightView:rankNow()
	if FormationController.instance:checkCanSort(self._curViewDatas) then
		local names, opt = BagModel.instance:GetSortParms(self:getPetAtCurFormationFunc())
		local tName = {
			function(mo)
				return InfinitefutureModel.instance:isBeLock(mo.raceId) and 1 or 0
			end
		}
		local tOpt = {
			ArraySort.NONE
		}

		table.insertto(names, tName, 2)
		table.insertto(opt, tOpt, 2)
		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._tableview:ReloadData()
end

return InfinfuMissionFmtRightView
