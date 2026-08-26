-- chunkname: @modules/logic/rouge/map/view/finish/RougeFinishView.lua

module("modules.logic.rouge.map.view.finish.RougeFinishView", package.seeall)

local RougeFinishView = class("RougeFinishView", BaseView)

function RougeFinishView:onInitView()
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofailed = gohelper.findChild(self.viewGO, "#go_failed")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeFinishView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RougeFinishView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function RougeFinishView:_btncloseOnClick()
	if self.sending then
		return
	end

	if self.closeed then
		return
	end

	self:closeThis()
end

function RougeFinishView:_editableInitView()
	self.simageSuccess = gohelper.findChildSingleImage(self.viewGO, "#go_success")
	self.simageFail = gohelper.findChildSingleImage(self.viewGO, "#go_failed")
	self.succAnimator = self._gosuccess:GetComponent(gohelper.Type_Animator)
	self.failAnimator = self._gofailed:GetComponent(gohelper.Type_Animator)

	NavigateMgr.instance:addEscape(self.viewName, RougeMapHelper.blockEsc)
end

function RougeFinishView:onOpen()
	self.sending = true
	self.callbackId = RougeRpc.instance:sendRougeEndRequest(self.onReceiveMsg, self)

	local success = self.viewParam == RougeMapEnum.FinishEnum.Finish

	gohelper.setActive(self._gosuccess, success)
	gohelper.setActive(self._gofailed, not success)

	if success then
		AudioMgr.instance:trigger(AudioEnum.UI.VictoryOpen)
		self.simageSuccess:LoadImage("singlebg/rouge/team/rouge_team_successbg.png")
	else
		AudioMgr.instance:trigger(AudioEnum.UI.FailOpen)
		self.simageFail:LoadImage("singlebg/rouge/team/rouge_team_failbg.png")
	end
end

function RougeFinishView:onReceiveMsg()
	self.sending = false
end

function RougeFinishView:onClose()
	self.closeed = true

	RougeRpc.instance:removeCallbackById(self.callbackId)

	local success = self.viewParam == RougeMapEnum.FinishEnum.Finish

	if success then
		if not self.succAnimator then
			local animator = self.failAnimator

			animator:Play("close", 0, 0)

			local season = RougeOutsideModel.instance:season()

			RougeOutsideRpc.instance:sendRougeGetNewReddotInfoRequest(season)
		end
	end
end

function RougeFinishView:onDestroyView()
	self.simageSuccess:UnLoadImage()
	self.simageFail:UnLoadImage()
end

return RougeFinishView
