-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinfinitefutureclg/view/DivineinfinitefutureclgresultView.lua

module("logic.extensions.divineinfinitefutureclg.view.DivineinfinitefutureclgresultView", package.seeall)

local DivineinfinitefutureclgresultView = class("DivineinfinitefutureclgresultView", ViewComponent)

function DivineinfinitefutureclgresultView:ctor()
	DivineinfinitefutureclgresultView.super.ctor(self)
end

function DivineinfinitefutureclgresultView:unbindEvents()
	DivineinfinitefutureclgresultView.super.unbindEvents(self)
	self._btnCancel:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function DivineinfinitefutureclgresultView:bindEvents()
	DivineinfinitefutureclgresultView.super.bindEvents(self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function DivineinfinitefutureclgresultView:buildUI()
	DivineinfinitefutureclgresultView.super.buildUI(self)

	self._txtBtnSure = self:getTxt("btns/btnSure/txt")
	self._txtDesc = self:getTxt("txtDesc")
	self._txtLast = self:getTxt("txtLast")
	self._txtCurr = self:getTxt("txtCurr")
	self._btnCancel = self:getBtn("btns/btnCancel")
	self._btnSure = self:getBtn("btns/btnSure")
	self._singleLine = self:getGo("btns"):GetComponent(ComponentType.UILayoutSingleLine)
	self._txtTitle = self:getTxt("bg/txtTitle")
end

function DivineinfinitefutureclgresultView:onExit()
	DivineinfinitefutureclgresultView.super.onExit(self)
end

function DivineinfinitefutureclgresultView:onEnter()
	DivineinfinitefutureclgresultView.super.onEnter(self)

	self._fightEndMsg = self:getFirstParam()
	self._info = DivineinfinitefutureclgModel.instance:getInfo(self._fightEndMsg.activityId)
	self._gridId2Value = self._info.gridId2Value
	self._gridId2Value_kv = {}

	for i, v in ipairs(self._gridId2Value) do
		self._gridId2Value_kv[v.left] = v.right
	end

	self:_updateUI()
end

function DivineinfinitefutureclgresultView:_updateUI()
	local stageCfg = DivineinfinitefutureclgConfig.instance:getStageCfg(self._fightEndMsg.activityId, self._fightEndMsg.curFightStageId)

	self._txtTitle.text = stageCfg.title

	if not self._gridId2Value_kv[self._fightEndMsg.curFightGridId] then
		local lastNum = -1

		self._txtCurr.text = self._fightEndMsg.curFightValue
		self._txtLast.text = lastNum <= 0 and "无" or lastNum
		self._isKnow = self._fightEndMsg.curFightValue == lastNum or self._fightEndMsg.curFightValue <= 0
		self._txtDesc.text = ""

		if self._fightEndMsg.curFightValue <= 0 then
			self._txtDesc.text = "本次战斗结果为0不可保存"
		elseif lastNum < self._fightEndMsg.curFightValue then
			self._txtDesc.text = "是否确认保留本次结果？"
		elseif self._fightEndMsg.curFightValue == lastNum then
			self._txtDesc.text = "结果相同"
		end

		self._confirmNum = -1

		if self._fightEndMsg:HasField("confirmNum") and self._fightEndMsg.confirmNum > 0 then
			self._confirmNum = self._fightEndMsg.confirmNum
		end

		goutil.setActive(self._btnCancel.gameObject, not self._isKnow)

		self._txtBtnSure.text = self._isKnow and "知道了" or "确认"

		self._singleLine:Layout()
	end
end

function DivineinfinitefutureclgresultView:_onClickbtnCancel()
	if self._confirmNum > 0 then
		if not DivineinfinitefutureclgController.instance:checkIsInOpenTime(self._fightEndMsg.activityId) then
			local actCfg = DivineinfinitefutureclgConfig.instance:getActCfg(self._fightEndMsg.activityId)

			FloatWordMgr.instance:show(string.format("挑战在%s开启", actCfg.openTime))
		else
			DivineInfiniteFutureClgAgent:sendPM_DivineInfiniteFutureClgConfirmReq(self._fightEndMsg.activityId, self._confirmNum, false)
		end
	end

	BattleFacade.instance:endBattle()
end

function DivineinfinitefutureclgresultView:_onClickbtnSure()
	if self._confirmNum > 0 then
		if not DivineinfinitefutureclgController.instance:checkIsInOpenTime(self._fightEndMsg.activityId) then
			local actCfg = DivineinfinitefutureclgConfig.instance:getActCfg(self._fightEndMsg.activityId)

			FloatWordMgr.instance:show(string.format("挑战在%s开启", actCfg.openTime))
		else
			DivineInfiniteFutureClgAgent:sendPM_DivineInfiniteFutureClgConfirmReq(self._fightEndMsg.activityId, self._confirmNum, not self._isKnow)
		end
	end

	BattleFacade.instance:endBattle()
end

return DivineinfinitefutureclgresultView
