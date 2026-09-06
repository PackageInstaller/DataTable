-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/SeniorFormationView.lua

module("logic.extensions.formation.view.SeniorFormationView", package.seeall)

local SeniorFormationView = class("SeniorFormationView", FormationView)

function SeniorFormationView:unbindEvents()
	SeniorFormationView.super.unbindEvents(self)
	self._backButton:RemoveClickListener()
	self._saveButton:RemoveClickListener()
end

function SeniorFormationView:bindEvents()
	SeniorFormationView.super.bindEvents(self)
	self._backButton:AddClickListener(self._onClickClose, self)
	self._saveButton:AddClickListener(self._onClickSave, self)
end

function SeniorFormationView:buildUI()
	SeniorFormationView.super.buildUI(self)

	self._saveRoot = self:getGo("saveRoot")

	goutil.setActive(self._saveRoot, true)
	goutil.setActive(self._btnRecFormation.gameObject, false)
	self._btnSingleLine:Layout()
end

function SeniorFormationView:onExit()
	SeniorFormationView.super.onExit(self)
	FormationNewModel.instance:RecoverFmtFromServerData()
end

function SeniorFormationView:_reqSaveCurForm(handler, handlerTarget)
	SeniorArenaController.instance:reqSaveMyForm(false, handler, handlerTarget)
end

function SeniorFormationView:_onClickSave()
	self:_reqSaveCurForm()
end

function SeniorFormationView:_onClickClose()
	self:close()
end

function SeniorFormationView:_onClickRecFormation()
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

return SeniorFormationView
