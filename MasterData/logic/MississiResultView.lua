-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mississi/MississiResultView.lua

module("logic.extensions.timelimitedchallenge.view.mississi.MississiResultView", package.seeall)

local MississiResultView = class("MississiResultView", ViewComponent)

function MississiResultView:buildUI()
	MississiResultView.super.buildUI(self)

	self._btnOk = self:getBtn("btnOk")
	self._txtTip = self:getTxt("content/top/txtTip")
	self._down = self:getGo("content/dowm")
	self._itemsGroup = self:getGo("content/dowm/rewards/itemsGroup")
	self._txtTitle = self:getTxt("txtTitle")
	self._txt = MaterialMgr.findGraphicText(self.mainGO, "content/dowm/rewards/item")
end

function MississiResultView:bindEvents()
	MississiResultView.super.bindEvents(self)
	self._btnOk:AddClickListener(self._onClickClose, self)
end

function MississiResultView:unbindEvents()
	MississiResultView.super.unbindEvents(self)
	self._btnOk:RemoveClickListener()
end

function MississiResultView:onEnter()
	MississiResultView.super.onEnter(self)

	self._tipsKey = self:getFirstParam()
	self.model = MississiModel.instance

	self:refreshUI()
end

function MississiResultView:onExit()
	MississiResultView.super.onExit(self)
end

function MississiResultView:refreshUI()
	if self.model._isCurStageWin then
		local curTeamInfo = self.model._curTeamInfo

		self._txtTip.text = lang("击败敌阵全部精灵，破阵成功！\n") .. langPara(self._tipsKey, curTeamInfo.activeNum)
	else
		self._txtTitle.text = lang("战斗失败")
		self._txtTip.text = lang("未能击败敌阵全部精灵！")
	end

	local ciMatStr = self.model.ciMatStr

	if GameUtil.isEmptyString(ciMatStr) then
		GameUtil.SetActive(self._down, false)
	else
		GameUtil.SetActive(self._down, true)

		self._txt.text = ciMatStr
	end
end

function MississiResultView:_onClickClose()
	self:close()
	BattleController.instance:endBattle()
end

return MississiResultView
