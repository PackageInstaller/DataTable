-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/view/TrainCampQieCuoPVEMissionView.lua

module("logic.extensions.traincampqiecuo.view.TrainCampQieCuoPVEMissionView", package.seeall)

local TrainCampQieCuoPVEMissionView = class("TrainCampQieCuoPVEMissionView", MissionView)

function TrainCampQieCuoPVEMissionView:ctor()
	TrainCampQieCuoPVEMissionView.super.ctor(self)
end

function TrainCampQieCuoPVEMissionView:buildUI()
	TrainCampQieCuoPVEMissionView.super.buildUI(self)

	local mPrefab = self:getPrefab(TrainCampQieCuoPVEMissionViewPresentor.ExtViewPrefab)

	self._pkNode = goutil.cloneAndSetParent(mPrefab, self.mainGO.transform, "pkNode")
	self._btnChangeTeam = Framework.ButtonAdapter.GetFrom(self._pkNode, "btnChangeTeam")
	self._btnModPower = Framework.ButtonAdapter.GetFrom(self._pkNode, "btnModPower")
	self._pkBtn = Framework.ButtonAdapter.GetFrom(self._pkNode, "pkBtn")
	self._goselectLeft = goutil.findChild(self._pkNode, "selectLeft")
	self._goselectRight = goutil.findChild(self._pkNode, "selectRight")
end

function TrainCampQieCuoPVEMissionView:bindEvents()
	TrainCampQieCuoPVEMissionView.super.bindEvents(self)
	self._pkBtn:AddClickListener(self._onClickStart, self)
	self._btnChangeTeam:AddClickListener(self._onClickbtnChangeTeam, self)
	self._btnModPower:AddClickListener(self._onClickbtnModPower, self)
end

function TrainCampQieCuoPVEMissionView:unbindEvents()
	TrainCampQieCuoPVEMissionView.super.unbindEvents(self)
	self._pkBtn:RemoveClickListener()
	self._btnChangeTeam:RemoveClickListener()
	self._btnModPower:RemoveClickListener()
end

function TrainCampQieCuoPVEMissionView:destroyUI()
	TrainCampQieCuoPVEMissionView.super.destroyUI(self)
end

function TrainCampQieCuoPVEMissionView:onEnter()
	self._currOpTeamType = TraincampqiecuoModel.instance:getPVEOpTeamType()
	self._lastOpTeamType = nil

	self:onEnterInherit()
	FastFormation.instance:setCurFormFunc(function()
		if self:_isMyOpTeamType() then
			return TraincampqiecuoModel.instance:getMyPVEFormation()
		else
			return TraincampqiecuoModel.instance:getOtherPVEFormation()
		end
	end)
	FastFormation.instance:setGetCurPetList(function()
		if self:_isMyOpTeamType() then
			return BagModel.instance:getPets()
		else
			return TraincampqiecuoModel.instance:getPetList()
		end
	end)

	self._nextOpTeamType = self:_isMyOpTeamType() and GameEnum.TrainQiecuoTeamOpType.Other or GameEnum.TrainQiecuoTeamOpType.My
	self._perPetPower = self:getFirstParam()

	self:_setMaskBlock(false)
	goutil.setActive(self._startBtn.gameObject, false)
	goutil.setActive(self._pkBtn.gameObject, true)
	self:_setDescStr(TraincampqiecuoConfig.instance:getCommonValue("PVE_NAME"))
	goutil.setActive(self._btnRule.gameObject, false)
	self:_setCurFormFunc()
end

function TrainCampQieCuoPVEMissionView:onExit()
	TrainCampQieCuoPVEMissionView.super.onExit(self)
	FastFormation.instance:setCurFormFunc(nil)
	FastFormation.instance:setGetCurPetList(nil)
end

function TrainCampQieCuoPVEMissionView:_enterBattle()
	local myForm = TraincampqiecuoModel.instance:getMyPVEFormation():createFormPb()
	local opForm = TraincampqiecuoModel.instance:getOtherPVELinkForm()

	BattleFacade.instance:startPk(true)
	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.QieCuo)
	TraincampqiecuoController.instance:sendPM_TC_PveReq(self._perPetPower, myForm, opForm, 1)
end

function TrainCampQieCuoPVEMissionView:_onClickbtnChangeTeam()
	self._lastOpTeamType = self._currOpTeamType
	self._currOpTeamType, self._nextOpTeamType = self._nextOpTeamType, self._currOpTeamType

	self:_setCurFormFunc()
end

function TrainCampQieCuoPVEMissionView:_setCurFormFunc()
	TraincampqiecuoModel.instance:setPVEOpTeamType(self._currOpTeamType)
	goutil.setActive(self._goselectLeft, self:_isMyOpTeamType())
	goutil.setActive(self._goselectRight, not self:_isMyOpTeamType())
	goutil.setActive(self._btnModPower.gameObject, not self:_isMyOpTeamType())
	GlobalDispatcher:dispatch(GlobalNotify.QiecuoPVEChangeTeamOp, self._currOpTeamType)
end

function TrainCampQieCuoPVEMissionView:_isMyOpTeamType()
	return self._currOpTeamType == GameEnum.TrainQiecuoTeamOpType.My
end

function TrainCampQieCuoPVEMissionView:_onClickbtnModPower()
	UIStateManager.instance:push(ViewName.TraincampqiecuomodpowerView, self._perPetPower, function(power)
		self._perPetPower = power

		GlobalDispatcher:dispatch(GlobalNotify.QiecuoPVEModPower, power)
	end)
end

function TrainCampQieCuoPVEMissionView:_getCurFormation()
	if self:_isMyOpTeamType() then
		return TraincampqiecuoModel.instance:getMyPVEFormation()
	else
		return TraincampqiecuoModel.instance:getOtherPVEFormation()
	end
end

function TrainCampQieCuoPVEMissionView:_onClickOneKey()
	MissionModel.instance:setForceResetOneKey(self._lastOpTeamType ~= self._currOpTeamType)

	self._lastOpTeamType = self._currOpTeamType

	TrainCampQieCuoPVEMissionView.super._onClickOneKey(self)
end

return TrainCampQieCuoPVEMissionView
