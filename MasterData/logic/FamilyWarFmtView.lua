-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyWarFmtView.lua

module("logic.extensions.newfamily.view.war.FamilyWarFmtView", package.seeall)

local FamilyWarFmtView = class("FamilyWarFmtView", FormationView)

function FamilyWarFmtView:onEnter()
	self._oriTeamId = FormationNewModel.instance:GetCurTeamId()

	FormationNewModel.instance:SetCurTeamId(FormationNewModel.familyWarTeamId)
	FamilyWarFmtView.super.onEnter(self)
	GameUtil.SetActive(self._tipObj, true)

	self._tipObj.text = "守阵阵容将血量提升1100%，同时恢复血量将无法使用"
end

function FamilyWarFmtView:buildUI()
	FamilyWarFmtView.super.buildUI(self)
	GameUtil.SetActive(self._btnShare, false)
	GameUtil.SetActive(self._btnRecFormation, false)
	self._btnSingleLine:Layout()
end

function FamilyWarFmtView:onExit()
	FormationNewModel.instance:SetCurTeamId(self._oriTeamId)
	FamilyWarFmtView.super.onExit(self)
end

function FamilyWarFmtView:_onClickSave()
	FamilyWarController.instance:csRequestFamilyBattleSetFormationReq()
	self:_onClickClose()
end

return FamilyWarFmtView
