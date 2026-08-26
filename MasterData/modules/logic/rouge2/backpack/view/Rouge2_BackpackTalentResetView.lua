-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackTalentResetView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackTalentResetView", package.seeall)

local Rouge2_BackpackTalentResetView = class("Rouge2_BackpackTalentResetView", BaseView)

function Rouge2_BackpackTalentResetView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Close")
	self._btnClose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Close2")
	self._goStageContent = gohelper.findChild(self.viewGO, "#go_Root/Scroll View/Viewport/Content")
	self._goStageItem = gohelper.findChild(self.viewGO, "#go_Root/Scroll View/Viewport/Content/#go_StageItem")
	self._btnConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Confirm", AudioEnum.Rouge2.ConfirmResetPetStage)
	self._goEnable = gohelper.findChild(self.viewGO, "#go_Root/#btn_Confirm/#go_Enable")
	self._goDisable = gohelper.findChild(self.viewGO, "#go_Root/#btn_Confirm/#go_Disable")
	self._goResetTips = gohelper.findChild(self.viewGO, "#go_Root/#btn_Confirm/#go_ResetTips")
	self._txtResetTips = gohelper.findChildText(self.viewGO, "#go_Root/#btn_Confirm/#go_ResetTips/#txt_ResetTips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BackpackTalentResetView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnClose2:AddClickListener(self._btnCloseOnClick, self)
	self._btnConfirm:AddClickListener(self._btnConfirmOnClick, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSelectTalentStage, self._onSelectTalentStage, self)
end

function Rouge2_BackpackTalentResetView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnClose2:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function Rouge2_BackpackTalentResetView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_BackpackTalentResetView:_btnConfirmOnClick()
	if not self._isSelectTalent then
		GameFacade.showToast(ToastEnum.Rouge2NotSelectAnyStage)

		return
	end

	if not self._isAnyStageTalentActive then
		GameFacade.showToast(ToastEnum.Rouge2TalentStageReset)

		return
	end

	if not self._isSelectTalentActive then
		logError("肉鸽局内天赋树阶段未激活")

		return
	end

	self._lastTransformId = Rouge2_BackpackModel.instance:getLastTransformTalentId()
	self._rpcCallbackId = Rouge2_Rpc.instance:sendRouge2SummonerResetTalentRequest(self._selectStage, self._onReceiveRpc, self)
end

function Rouge2_BackpackTalentResetView:_onReceiveRpc(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	if self._lastTransformId and self._selectTalentId and self._lastTransformId ~= self._selectTalentId then
		local params = {
			preTalentId = self._lastTransformId,
			curTalentId = self._selectTalentId
		}

		ViewMgr.instance:openView(ViewName.Rouge2_BackpackPetStageResultView, params)
	end

	self:closeThis()
end

function Rouge2_BackpackTalentResetView:_editableInitView()
	self._isSelectTalent = false
end

function Rouge2_BackpackTalentResetView:onOpen()
	self:refresh()
end

function Rouge2_BackpackTalentResetView:refresh()
	self._talentIdList = Rouge2_CareerConfig.instance:getTalentTransformIdList()

	gohelper.CreateObjList(self, self._refreshTalentStageItem, self._talentIdList, self._goStageContent, self._goStageItem, Rouge2_BackpackTalentStageResetItem)
	self:refreshConfirmBtn()
	self:refreshResetTips()
end

function Rouge2_BackpackTalentResetView:_refreshTalentStageItem(resetItem, talentCo, index)
	resetItem:onUpdateMO(talentCo, index)
end

function Rouge2_BackpackTalentResetView:_onSelectTalentStage(talentId)
	self._selectTalentId = talentId
	self._isSelectTalent = talentId and talentId ~= 0
	self._selectTalentCo = self._isSelectTalent and Rouge2_CareerConfig.instance:getTalentConfig(self._selectTalentId)

	if self._selectTalentCo then
		self._selectStage = self._selectTalentCo.stage + 1 or 0
	end

	self:refreshSelectTalentStatus()
end

function Rouge2_BackpackTalentResetView:refreshSelectTalentStatus()
	self._selectTalentStatus = self._isSelectTalent and Rouge2_BackpackModel.instance:getTalentStatus(self._selectTalentId)
	self._isSelectTalentActive = self._isSelectTalent and self._selectTalentStatus == Rouge2_Enum.BagTalentStatus.Active
	self._isAnyStageTalentActive = self._isSelectTalent and Rouge2_BackpackController.instance:isAnyStageTalentActive(self._selectStage)
	self._recycleTalentPoint = self._isSelectTalent and Rouge2_BackpackController.instance:getTalentResetRecycleTalentNum(self._selectStage)

	self:refreshResetTips()
	self:refreshConfirmBtn()
end

function Rouge2_BackpackTalentResetView:refreshResetTips()
	gohelper.setActive(self._goResetTips, self._isSelectTalentActive)

	if not self._isSelectTalentActive then
		return
	end

	self._txtResetTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_backpacktalentresetview_recycle"), self._recycleTalentPoint)
end

function Rouge2_BackpackTalentResetView:refreshConfirmBtn()
	local var_14_0 = self._isSelectTalent

	if self._isSelectTalent then
		var_14_0 = self._isAnyStageTalentActive

		if self._isAnyStageTalentActive then
			local isEnable = self._isSelectTalentActive

			gohelper.setActive(self._goEnable, isEnable)
			gohelper.setActive(self._goDisable, not isEnable)
		end
	end
end

function Rouge2_BackpackTalentResetView:_onUpdateRougeInfo()
	self:refreshSelectTalentStatus()
end

function Rouge2_BackpackTalentResetView:onClose()
	if self._rpcCallbackId then
		Rouge2_Rpc.instance:removeCallbackById(self._rpcCallbackId)

		self._rpcCallbackId = nil
	end
end

function Rouge2_BackpackTalentResetView:onDestroyView()
	return
end

return Rouge2_BackpackTalentResetView
