-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FormationView.lua

module("logic.extensions.formation.view.FormationView", package.seeall)

local FormationView = class("FormationView", ViewComponent)

function FormationView:ctor(hasSave)
	FormationView.super.ctor(self)

	self._hasSave = hasSave
end

function FormationView:bindEvents()
	if self._hasSave then
		self._backButton:AddClickListener(self._onClickClose, self)
	else
		self._backButton:AddClickListener(self._onClickSave, self)
	end

	self._saveButton:AddClickListener(self._onClickSave, self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnRecFormation:AddClickListener(self._onClickRecFormation, self)
	self._btnShare:AddClickListener(self._onClickShare, self)
	GameUtil.addClickHandler(self._BtnPet, self._onClickPet, self)
	self._btnSetDefense:AddClickListener(self._onClickbtnSetDefense, self)
end

function FormationView:unbindEvents()
	self._saveButton:RemoveClickListener()
	self._closeButton:RemoveClickListener()
	self._backButton:RemoveClickListener()
	self._btnRecFormation:RemoveClickListener()
	self._btnShare:RemoveClickListener()
	GameUtil.rmClickHandler(self._BtnPet)
	self._btnSetDefense:RemoveClickListener()
end

function FormationView:buildUI()
	self._backButton = self:getBtn("lefttop/btn_back")
	self._saveButton = self:getBtn("saveRoot/Btn_Save")
	self._closeButton = self:getBtn("saveRoot/Close")
	self._titleTxt1 = self:getGo("lefttop/txtTitle1"):GetComponent("Text")
	self._tipObj = self:getTxt("TxtTip")
	self._btnRecFormation = self:getBtn("btns/btnRecFormation")

	self:getGo("saveRoot"):SetActive(self._hasSave)

	self._btnShare = self:getBtn("btns/btnShare")
	self._BtnPet = self:getGo("Nego_Left/BtnPet")
	self._btnSingleLine = self:getGo("btns"):GetComponent(ComponentType.UILayoutSingleLine)
	self._btnSetDefense = self:getBtn("btns/btnSetDefense")

	goutil.setActive(self._btnSetDefense.gameObject, false)
end

function FormationView:destroyUI()
	return
end

function FormationView:onEnter()
	if FormationNewModel.instance:isInArena() then
		self._titleTxt1.text = "守 阵"

		self._tipObj.gameObject:SetActive(true)

		self._tipObj.text = "在竞技场中被挑战时，以此防守阵型应战"
	else
		self._titleTxt1.text = "布 阵"

		self._tipObj.gameObject:SetActive(false)
	end
end

function FormationView:onEnterFinished()
	self:_setMaxPetNum()
end

function FormationView:onExit()
	return
end

function FormationView:_onClickPet()
	MissionModel.instance:setIsPlayEnterAnim(false)
	UIStateManager.instance:push(ViewName.PetView)
end

function FormationView:_onClickClose()
	print("_onClickClose")
	self:close()
end

function FormationView:_onClickSave()
	print("_onClickSave")
	FormationController.instance:SaveFormationEx()
	self:_onClickClose()
end

function FormationView:_onClickRecFormation()
	function FuncOpenController.instance.onRecomentSelCallback(fightCreepsCfgs)
		FastFormation.instance:clean()

		for i = 1, #fightCreepsCfgs do
			local raceId = fightCreepsCfgs[i].raceId
			local petId = BagModel.instance:getPetIdByRaceId(raceId)

			if petId ~= nil then
				local posId = fightCreepsCfgs[i].posId

				FormationController.instance:ChangePosition(posId, petId)
			end
		end

		FormationController.instance:SaveFormationEx()
	end

	UIStateManager.instance:push(ViewName.PetNoticeView, 5)
end

function FormationView:_onClickShare()
	FormationController.instance:SaveFormationEx()
	UIStateManager.instance:open(ViewName.Share, GameEnum.ShareType.Formation, FormationNewModel.instance:GetCurTeamId())
end

function FormationView:_setMaxPetNum()
	MissionModel.instance:setMaxPetNum(self:_maxPetNum())
end

function FormationView:_maxPetNum()
	return 5
end

function FormationView:_onClickbtnSetDefense()
	UIStateManager.instance:push(ViewName.FormationsetdefenseView)
end

function FormationView:getFormationsetdefenseType()
	return nil
end

return FormationView
