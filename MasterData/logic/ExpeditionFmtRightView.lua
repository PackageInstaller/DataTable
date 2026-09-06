-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/ExpeditionFmtRightView.lua

module("logic.extensions.formation.view.ExpeditionFmtRightView", package.seeall)

local ExpeditionFmtRightView = class("ExpeditionFmtRightView", FormationRightView)

function ExpeditionFmtRightView:onEnter()
	ExpeditionFmtRightView.super.onEnter(self)
	settimer(0, self._updateCellOrders, self, -1)
end

function ExpeditionFmtRightView:onExit()
	ExpeditionFmtRightView.super.onExit(self)
	removetimer(self._updateCellOrders, self)
end

function ExpeditionFmtRightView:_updateCellOrders()
	local cnt = self._tableview:GetVisibleCount() - 1

	for i = 0, cnt do
		local cell = self._tableview:GetCellByIndex(i)
		local petState = goutil.findChild(cell.gameObject, "PetState")

		if petState then
			petState.transform:SetAsLastSibling()
		end
	end
end

function ExpeditionFmtRightView:updateForbit(data)
	local inTeamId = ExpeditionFmtModel.instance:getPetIdInTeamByRaceId(data.raceId)
	local petStateData = ExpeditionModel.instance:getPetState(data.petId)
	local canNotUp, hasOne = false, false
	local canNotUpWithYuan = self:getYuanLimit(data)

	data:setPetForbit(checknumber(inTeamId) > 0 and inTeamId ~= data.petId and ((petStateData or nil) and petStateData.hpRate <= 0 or hasOne or canNotUp or canNotUpWithYuan))
end

function ExpeditionFmtRightView:_getCurFormation()
	return ExpeditionFmtModel.instance:getFormation()
end

function ExpeditionFmtRightView:_updateCell(view, cell, data)
	data.isDead = ExpeditionModel.instance:isPetDead(data.petId)

	ExpeditionFmtRightView.super._updateCell(self, view, cell, data)

	local inTeamId = ExpeditionFmtModel.instance:getPetIdInTeamByRaceId(data.raceId)
	local component = ItemPet.AddOnce(cell.gameObject)

	component:SetInTeam(inTeamId == data.petId)
	self:_updatePetState(cell, data)
end

function ExpeditionFmtRightView:_updatePetState(cell, data)
	local petState = goutil.findChild(cell.gameObject, "PetState")

	if not petState then
		petState = self._viewPresentor:getResInstance(ExpeditionMissionViewPresentor.itemExpPet)

		if not petState then
			return
		end

		petState.transform:SetParent(cell.transform)
		Framework.TransformUtil.SetLocalPos(petState.transform, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(petState.transform, 1, 1, 1)

		petState.name = "PetState"
	end

	local bloodbar = Framework.SliderAdapter.GetFrom(petState, "bloodbar")
	local vigourbar = Framework.SliderAdapter.GetFrom(petState, "vigourbar")
	local petStateData = ExpeditionModel.instance:getPetState(data.petId)
	local hpVal = 1
	local vigourVal = 0

	if petStateData then
		hpVal = petStateData.hpRate
		vigourVal = petStateData.vigour / BattleModel.MaxVigour
	end

	bloodbar:SetValue(hpVal)
	vigourbar:SetValue(vigourVal)
end

function ExpeditionFmtRightView:rankNow()
	if FormationController.instance:checkCanSort(self._curViewDatas) then
		local names, opt = ExpeditionController.instance:getExpedSortParams()

		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._tableview:ReloadData()
end

function ExpeditionFmtRightView._sortFuncWithDead(pet)
	local petStateData = ExpeditionModel.instance:getPetState(pet.petId)

	return (petStateData or nil) and petStateData.hpRate > 0
end

function ExpeditionFmtRightView:_initAllPetList()
	self._allPetList = ExpeditionFmtModel.instance:getAllPets()
end

function ExpeditionFmtRightView:_onForbidDragTips(petData)
	local petStateData = ExpeditionModel.instance:getPetState(petData.petId)

	if (petStateData or nil) and petStateData.hpRate <= 0 then
		FloatWordMgr.instance:show(lang("精灵已经阵亡！"))
	else
		local canNotUp, hasOne = self:getSummonLimit(petData)

		if canNotUp then
			local mo = self:getPetMoById(petData.summonMasterId)

			FloatWordMgr.instance:show(langPara("该精灵被召唤师%s契约绑定，不能单独上阵", (mo or nil) and mo.name))

			return
		end

		local canNotUpYuan = self:getYuanLimit(petData)

		if canNotUpYuan then
			FloatWordMgr.instance:show(lang("已达到上阵限制，源属性精灵最多上阵两只"))

			return
		end

		FloatWordMgr.instance:show(lang("该精灵不能上阵"))
	end
end

return ExpeditionFmtRightView
