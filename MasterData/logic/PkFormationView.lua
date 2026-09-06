-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkFormationView.lua

module("logic.extensions.pk.view.PkFormationView", package.seeall)

local PkFormationView = class("PkFormationView", FormationView)

function PkFormationView:ctor()
	PkFormationView.super.ctor(self)
end

function PkFormationView:destroyUI()
	PkFormationView.super.destroyUI(self)
end

function PkFormationView:onExitFinished()
	PkFormationView.super.onExitFinished(self)
end

function PkFormationView:onEnterFinished()
	PkFormationView.super.onEnterFinished(self)
end

function PkFormationView:unbindEvents()
	self._saveButton:RemoveClickListener()
end

function PkFormationView:bindEvents()
	self._saveButton:AddClickListener(self._onClickSave, self)
end

function PkFormationView:onExit()
	PkFormationView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ChangeToAttack, self._changeToAttack, self)
	removetimer(self._timer, self)
end

function PkFormationView:buildUI()
	self._timeValue = goutil.findChildTextComponent(self.mainGO, "Nego_Left/time/value")
	self._saveButton = self:getBtn("saveRoot/Btn_Save")
	self._btnSaveText = goutil.findChildTextComponent(self._saveButton.gameObject, "TxtC_Title")
end

function PkFormationView:onEnter()
	self.addGEvent(self, TrainCampQieCuoAgent.TC_SetDefenseFormRes, self.close, self)
	GlobalDispatcher:addListener(GlobalNotify.ChangeToAttack, self._changeToAttack, self)

	self._targetTickTime = TraincampqiecuoController.instance:getSetDefenseTargetTime()

	local time = self._targetTickTime - ServerTime.now()

	self._timeValue.text = string.format("%d秒", time)

	settimer(1, self._timer, self, true)
end

function PkFormationView:_timer()
	local leftTime = self._targetTickTime - ServerTime.now()

	if leftTime <= 0 then
		removetimer(self._timer, self)
		self:_onClickSave()
	else
		self._timeValue.text = string.format("%d秒", leftTime)
	end
end

function PkFormationView:_onClickClose()
	UIStateManager.instance:push(ViewName.PkFormationselectView)
	self:close()
end

function PkFormationView:_onClickSave()
	UIStateManager.instance:push(ViewName.PkFormationselectView, true)
	self:close()
end

function PkFormationView:_changeToAttack()
	UIStateManager.instance:push(ViewName.PkmissionView)
	self:close()
end

return PkFormationView
