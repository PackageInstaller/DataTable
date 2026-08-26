-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_FinishView.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_FinishView", package.seeall)

local Rouge2_FinishView = class("Rouge2_FinishView", BaseView)

function Rouge2_FinishView:onInitView()
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofailed = gohelper.findChild(self.viewGO, "#go_failed")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_FinishView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Rouge2_FinishView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Rouge2_FinishView:_btncloseOnClick()
	if self.sending then
		return
	end

	if self.closeed then
		return
	end

	self:closeThis()
end

function Rouge2_FinishView:_editableInitView()
	self.simageSuccess = gohelper.findChildSingleImage(self.viewGO, "#go_success")
	self.simageFail = gohelper.findChildSingleImage(self.viewGO, "#go_failed")
	self._txtSuccess = gohelper.findChildTextMesh(self.viewGO, "#go_success/txt_success")
	self._txtSuccessTip = gohelper.findChildTextMesh(self.viewGO, "#go_success/txt_successtips")
	self.succAnimator = self._gosuccess:GetComponent(gohelper.Type_Animator)
	self.failAnimator = self._gofailed:GetComponent(gohelper.Type_Animator)

	NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc)
end

function Rouge2_FinishView:onOpen()
	self.sending = true
	self.callbackId = Rouge2_Rpc.instance:sendRouge2EndRequest(self.onReceiveMsg, self)

	if self.viewParam then
		local success = self.viewParam.state == Rouge2_OutsideEnum.FinishEnum.Finish

		gohelper.setActive(self._gosuccess, success)
		gohelper.setActive(self._gofailed, not success)

		if success then
			AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_win)

			local endId = self.viewParam.endId

			self.simageSuccess:LoadImage("singlebg/rouge/team/rouge_team_successbg.png")

			local successDescStr = "p_rouge2_finishview_txt_success" .. endId
			local successDescTipsStr = "p_rouge2_finishview_txt_successtips" .. endId

			self._txtSuccess.text = luaLang(successDescStr)
			self._txtSuccessTip.text = luaLang(successDescTipsStr)
		else
			AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_lose)
			self.simageFail:LoadImage("singlebg/rouge/team/rouge_team_failbg.png")
		end
	end
end

function Rouge2_FinishView:onReceiveMsg()
	self.outsideInfoCallbackId = Rouge2OutsideRpc.instance:sendGetRouge2OutsideInfoRequest(self.onReceiveOutSideInfo, self)
end

function Rouge2_FinishView:onReceiveOutSideInfo()
	self.unlockInfoCallbackId = Rouge2OutsideRpc.instance:sendRouge2GetUnlockCollectionsRequest(self.onReceiveUnlockInfo, self)
end

function Rouge2_FinishView:onReceiveUnlockInfo()
	self.sending = false
end

function Rouge2_FinishView:onClose()
	self.closeed = true

	Rouge2_Rpc.instance:removeCallbackById(self.callbackId)
	Rouge2_Rpc.instance:removeCallbackById(self.unlockInfoCallbackId)
	Rouge2_Rpc.instance:removeCallbackById(self.outsideInfoCallbackId)

	local success = self.viewParam == Rouge2_OutsideEnum.FinishEnum.Finish

	if success then
		if not self.succAnimator then
			local animator = self.failAnimator

			animator:Play("close", 0, 0)
		end
	end
end

function Rouge2_FinishView:onDestroyView()
	self.simageSuccess:UnLoadImage()
	self.simageFail:UnLoadImage()
end

return Rouge2_FinishView
