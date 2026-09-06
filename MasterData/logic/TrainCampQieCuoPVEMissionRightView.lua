-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/view/TrainCampQieCuoPVEMissionRightView.lua

module("logic.extensions.traincampqiecuo.view.TrainCampQieCuoPVEMissionRightView", package.seeall)

local TrainCampQieCuoPVEMissionRightView = class("TrainCampQieCuoPVEMissionRightView", FormationRightView)

function TrainCampQieCuoPVEMissionRightView:onEnter()
	self.addGEvent(self, GlobalNotify.FormationChangeFinish, self._OnTeamChanged, self)

	self._currOpTeamType = TraincampqiecuoModel.instance:getPVEOpTeamType()

	self.addGEvent(self, GlobalNotify.QiecuoPVEChangeTeamOp, self._onQiecuoPVEChangeTeamOp, self)
	TrainCampQieCuoPVEMissionRightView.super.onEnter(self)
end

function TrainCampQieCuoPVEMissionRightView:_onQiecuoPVEChangeTeamOp()
	self._currOpTeamType = TraincampqiecuoModel.instance:getPVEOpTeamType()

	self:_initAllPetList()
	self:_RefreshPetList()
end

function TrainCampQieCuoPVEMissionRightView:_initAllPetList()
	self._allPetList = self._currOpTeamType == GameEnum.TrainQiecuoTeamOpType.My and BagPetsController.instance:getFightBagPet() or TraincampqiecuoModel.instance:getPetList()
end

function TrainCampQieCuoPVEMissionRightView:_getCurFormation()
	if self._currOpTeamType == GameEnum.TrainQiecuoTeamOpType.My then
		return TraincampqiecuoModel.instance:getMyPVEFormation()
	else
		return TraincampqiecuoModel.instance:getOtherPVEFormation()
	end
end

function TrainCampQieCuoPVEMissionRightView:rankNow()
	if self._currOpTeamType == GameEnum.TrainQiecuoTeamOpType.My then
		if FormationController.instance:checkCanSort(self._curViewDatas) then
			local names, opt = BagModel.instance:GetSortParms(self:getPetAtCurFormationFunc())

			ArraySort.sortOn(self._curViewDatas, names, opt)
		end
	else
		ArraySort.sortOn(self._curViewDatas, "petId", ArraySort.DESCENDING)
	end

	self._tableview:ReloadData()
end

function TrainCampQieCuoPVEMissionRightView:_loadCharacter(pet)
	self._Character = goutil.cloneAndSetParent(self._Nego_Character, self._Nego_Character.transform.parent)

	self._Character:SetActive(true)

	self._Character.transform.position = uGuiUtil.GetTouchWorldPosition()

	local modelCfg = CharactorFacade.instance:getFormationModelUIPosAndScale(pet.curFaceId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, pet.curFaceId, goutil.findChild(self._Character, "petContainer"), (not TraincampqiecuoModel.instance:isMyPVEOPTeamType() or nil) and {
					-scale,
					scale,
					scale
				}, nil, false, modelCfg[1], y)
			end
		end
	end
end

return TrainCampQieCuoPVEMissionRightView
