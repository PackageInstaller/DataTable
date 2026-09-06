-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmoyanclg/view/KingMoYanClgResultPopView.lua

module("logic.extensions.ashlesslongyan.view.KingMoYanClgResultPopView", package.seeall)

local KingMoYanClgResultPopView = class("KingMoYanClgResultPopView", ViewComponent)

function KingMoYanClgResultPopView:buildUI()
	KingMoYanClgResultPopView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._btnCancel = goutil.findChild(self.mainGO, "btnCancel")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txtDesc")
end

function KingMoYanClgResultPopView:bindEvents()
	KingMoYanClgResultPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
end

function KingMoYanClgResultPopView:unbindEvents()
	KingMoYanClgResultPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function KingMoYanClgResultPopView:onEnter()
	KingMoYanClgResultPopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._moYanClgMo = KingMoYanClgController.instance:getKingMoYanClgMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_KingMoYanClgConfirmRes, self._handlePM_KingMoYanClgConfirmRes, self)

	local msg = self._moYanClgMo:getEndResMsg()

	if msg.isWin then
		local cur = msg.curUltimateTimes + msg.addUltimateTimes
		local curData = KingMoYanClgConfig.instance:getBuffDataByNum(self._activityId, cur)

		if curData then
			if not curData.buffId then
				local buffId = 0
				local nextData = KingMoYanClgConfig.instance:getBuffData(self._activityId, buffId + 1)

				self._txtDesc.text = string.format("王者末炎超杀次数：<color=#20b376>%s</color>次\n当前累计超杀次数：<color=#20b376>%s</color>次\n距离下次效果生效：<color=#20b376>%s</color>次", msg.addUltimateTimes, cur, (nextData or nil) and Mathf.Max(0, nextData.num - cur))
			end
		end
	else
		self._txtDesc.text = "无"
	end
end

function KingMoYanClgResultPopView:onExit()
	KingMoYanClgResultPopView.super.onExit(self)
end

function KingMoYanClgResultPopView:_handlePM_KingMoYanClgConfirmRes(status)
	BattleController.instance:endBattle()
end

function KingMoYanClgResultPopView:_onClickBtnSure()
	KingMoYanClgController.instance:sendPM_KingMoYanClgConfirmReq(self._activityId, true)
end

function KingMoYanClgResultPopView:_onClickBtnCancel()
	KingMoYanClgController.instance:sendPM_KingMoYanClgConfirmReq(self._activityId, false)
end

return KingMoYanClgResultPopView
