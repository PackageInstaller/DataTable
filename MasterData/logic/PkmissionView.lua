-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkmissionView.lua

module("logic.extensions.pk.view.PkmissionView", package.seeall)

local PkmissionView = class("PkmissionView", MissionView)

function PkmissionView:ctor()
	PkmissionView.super.ctor(self)
end

function PkmissionView:buildUI()
	PkmissionView.super.buildUI(self)

	local res = rescache:GetResourceNoLoadIfNotExists("ui/views/pk/pkmissionview.prefab")
	local mainAsset = res:GetMainAsset()

	self._pkNode = goutil.cloneAndSetParent(mainAsset, self.mainGO.transform, "pkNode")
	self._pkBtn = Framework.ButtonAdapter.GetFrom(self._pkNode, "pkBtn")
	self._pkBtnText = goutil.findChildTextComponent(self._pkBtn, "txtCd")
	self._board = goutil.findChild(self._pkNode, "board")
end

function PkmissionView:bindEvents()
	PkmissionView.super.bindEvents(self)
	self._pkBtn:AddClickListener(self._onClickStart, self)
end

function PkmissionView:unbindEvents()
	PkmissionView.super.unbindEvents(self)
	self._pkBtn:RemoveClickListener()
end

function PkmissionView:destroyUI()
	PkmissionView.super.destroyUI(self)
end

function PkmissionView:onEnter()
	self.addGEvent(self, TrainCampQieCuoAgent.TC_ReadyFightRes, self._onReadyFightRes, self)
	self:onEnterInherit()
	self:_setMaskBlock(false)

	self._fmtChanged = false

	goutil.setActive(self._startBtn.gameObject, false)
	goutil.setActive(self._pkBtn.gameObject, true)

	local time = TraincampqiecuoController:getAttackReadyTime()

	self._pkBtnText.text = string.format("%d秒", time)
	self._targetTickTime = time + ServerTime.now()

	settimer(1, self._timer, self, true)
	goutil.setActive(self._closeButton.gameObject, false)

	local opHeadInfo = TraincampqiecuoModel.instance:getOpUserHeadInfo()

	self:_setDescStr(opHeadInfo.userName)
	goutil.setActive(self._btnRule.gameObject, false)
	goutil.setActive(self._board, false)
end

function PkmissionView:onEnterFinished()
	PkmissionView.super.onEnterFinished(self)
end

function PkmissionView:onExit()
	PkmissionView.super.onExit(self)
	removetimer(self._timer, self)
end

function PkmissionView:onExitFinished()
	PkmissionView.super.onExitFinished(self)
end

function PkmissionView:_enterBattle()
	if self._completed then
		FloatWordMgr.instance:show("等待对面设置攻阵")

		return
	end

	removetimer(self._timer, self)

	if not FormationController.instance:SaveFormationEx(function()
		TrainCampQieCuoAgent.instance:sendPM_TC_ReadyFightReq()
		self:_onReadyFightRes()
	end) then
		BattleFacade.instance:startPk()
		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.QieCuo)
		TrainCampQieCuoAgent.instance:sendPM_TC_ReadyFightReq()
	end
end

function PkmissionView:_timer()
	if self._completed then
		removetimer(self._timer, self)

		self._pkBtnText.text = "请等待"

		return
	end

	local leftTime = self._targetTickTime - ServerTime.now()

	if leftTime <= 0 then
		self:_enterBattle()
	else
		self._pkBtnText.text = string.format("%d秒", leftTime)
	end
end

function PkmissionView:_onReadyFightRes()
	self._pkBtnText.text = "等待对面设置攻阵"
	self._completed = true

	goutil.setActive(self._board, true)
end

function PkmissionView:_onClickClose()
	TrainCampQieCuoAgent.instance:sendPM_TC_LeaveGameReq()
	PkmissionView.super._onClickClose(self)
end

return PkmissionView
