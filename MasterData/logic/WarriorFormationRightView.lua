-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/warriortower/view/WarriorFormationRightView.lua

module("logic.extensions.formation.view.WarriorFormationRightView", package.seeall)

local WarriorFormationRightView = class("WarriorFormationRightView", FormationRightView)
local TowerId2FilterId = {
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7
}

function WarriorFormationRightView:ctor()
	WarriorFormationRightView.super.ctor(self)
end

function WarriorFormationRightView:onEnter()
	WarriorFormationRightView.super.onEnter(self)
end

function WarriorFormationRightView:onExit()
	WarriorFormationRightView.super.onExit(self)
end

function WarriorFormationRightView:rankNow()
	local towerId = WTowerModel.instance:getTowerId()

	if towerId == WTowerModel.TowerType.Warrior then
		WarriorFormationRightView.super.rankNow(self)
	else
		if FormationController.instance:checkCanSort(self._curViewDatas) then
			local names, opt = WTowerModel.instance:GetSortParms()

			ArraySort.sortOn(self._curViewDatas, names, opt)
		end

		self._tableview:ReloadData()
	end
end

function WarriorFormationRightView:createFilterList()
	local data = PetFilterMgr.instance:getFilterData(PetFilterMgr.TYPE_WARRIOR)

	PetFilterMgr.instance:resetData(data)

	local towerId = WTowerModel.instance:getTowerId()
	local matchId = TowerId2FilterId[towerId]

	if matchId ~= 0 then
		for i = 1, 8 do
			data.raceSelectList[i] = matchId == i
			data.raceActiveList[i] = true
			data.raceClickAble[i] = false
		end
	end
end

function WarriorFormationRightView:_onClickPet(data)
	if data then
		if data.forbit then
			self:_onForbidDragTips(data)

			return
		end

		self._selectedPetId = data.petId

		GlobalDispatcher:dispatch(GlobalNotify.FormationClickPet)

		local towerId = WTowerModel.instance:getTowerId()
		local matchId = TowerId2FilterId[towerId]
		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(data.curFaceId)
		local isShenshi = skinCfg and checknumber(skinCfg.oracleSkillId) > 0

		if data.isMyPackPet then
			if PetSkinConfig.instance:checkHasMutiBody(data.raceId) then
				if matchId ~= 0 then
					TipsFacade.instance:openCommonTips(lang("当前模式不能切换双生精灵"))
				else
					BagPetsController.instance:sendChangePetBody(data)
				end
			elseif PetSkinConfig.instance:checkHasEleAttr(data.curFaceId, GameEnum.RaceType.Yuan) then
				if matchId ~= 0 then
					TipsFacade.instance:openCommonTips(lang("当前模式不能切换属性"))
				else
					UIStateManager.instance:push(ViewName.ChangeracepopView, self:_getCurFormation(), data)
				end
			elseif isShenshi then
				local list = self:getAllShowPetList()

				UIStateManager.instance:push(ViewName.OracleselectpopView, {
					data
				}, list)
			else
				CommonTipsMgr.instance:showPetTips(data)
			end
		elseif PetSkinConfig.instance:checkHasEleAttr(data.curFaceId, GameEnum.RaceType.Yuan) then
			if matchId ~= 0 then
				TipsFacade.instance:openCommonTips(lang("当前模式不能切换属性"))
			else
				UIStateManager.instance:push(ViewName.ChangeracepopView, self:_getCurFormation(), data)
			end
		else
			CommonTipsMgr.instance:showPetTips(data)
		end
	end
end

function WarriorFormationRightView:_OnClickAttr()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._Btn_Attr.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_WARRIOR, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function WarriorFormationRightView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_WARRIOR, cfg, rare, skinId)
end

function WarriorFormationRightView:getAllShowPetList()
	local pets = WarriorFormationRightView.super.getAllShowPetList(self) or {}
	local towerId = WTowerModel.instance:getTowerId()

	if towerId == WTowerModel.TowerType.Warrior then
		pets = PetHireModel.instance:appendListByHirePets(pets)
	end

	return pets
end

function WarriorFormationRightView:_getCurFormation()
	return WTowerModel.instance:_getCurFormation()
end

return WarriorFormationRightView
