-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackTalentDetailView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackTalentDetailView", package.seeall)

local Rouge2_BackpackTalentDetailView = class("Rouge2_BackpackTalentDetailView", BaseView)
local PercentColor = "#F3A055"
local BracketColor = "#5E7DD9"
local CostTalentColor_Enough = "#FFFFFF"
local CostTalentColor_Lack = "#D03E3E"

function Rouge2_BackpackTalentDetailView:onInitView()
	self._goDetail = gohelper.findChild(self.viewGO, "#go_Detail")
	self._txtTalentName = gohelper.findChildText(self.viewGO, "#go_Detail/#txt_TalentName")
	self._txtTalentDesc = gohelper.findChildText(self.viewGO, "#go_Detail/#scroll_Desc/Viewport/Content/#txt_TalentDesc")
	self._btnLock = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Detail/#btn_Lock", AudioEnum.Rouge2.ActiveTalent)
	self._goPreTips = gohelper.findChild(self.viewGO, "#go_Detail/#btn_Lock/layout/#go_PreTips")
	self._txtLockTips = gohelper.findChildText(self.viewGO, "#go_Detail/#btn_Lock/layout/#txt_LockTips")
	self._btnCanActive = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Detail/#btn_CanActive", AudioEnum.Rouge2.ActiveTalent)
	self._btnActive = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Detail/#btn_Active", AudioEnum.Rouge2.ActiveTalent)
	self._txtLock = gohelper.findChildText(self.viewGO, "#go_Detail/#btn_Lock/#txt_Lock")
	self._txtCost1 = gohelper.findChildText(self.viewGO, "#go_Detail/#btn_Lock/#txt_Cost")
	self._txtCost2 = gohelper.findChildText(self.viewGO, "#go_Detail/#btn_CanActive/#txt_Cost")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Detail/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BackpackTalentDetailView:addEvents()
	self._btnLock:AddClickListener(self._btnLockOnClick, self)
	self._btnCanActive:AddClickListener(self._btnCanActiveOnClick, self)
	self._btnActive:AddClickListener(self._btnActiveOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)

	local tabContainer = ViewMgr.instance:getContainer(ViewName.Rouge2_BackpackTabView)

	if tabContainer then
		self.addEventCb(self, tabContainer, ViewEvent.ToSwitchTab, self._toSwitchTab, self)
	end
end

function Rouge2_BackpackTalentDetailView:removeEvents()
	self._btnLock:RemoveClickListener()
	self._btnCanActive:RemoveClickListener()
	self._btnActive:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function Rouge2_BackpackTalentDetailView:_btnLockOnClick()
	if not self._isPreActive then
		GameFacade.showToast(ToastEnum.Rouge2PreTalentNotActive)

		return
	end

	if not self._isUnlock then
		GameFacade.showToast(ToastEnum.Rouge2TalentUnlockCondition)

		return
	end
end

function Rouge2_BackpackTalentDetailView:_btnCanActiveOnClick()
	if not self._isEnough then
		GameFacade.showToast(ToastEnum.Rouge2LackTalentPoint)

		return
	end

	self._lastTransformId = Rouge2_BackpackModel.instance:getLastTransformTalentId()
	self._rpcCallbackId = Rouge2_Rpc.instance:sendRouge2SummonerActiveTalentRequest(self._talentId, self._onReceiveRpc, self)
end

function Rouge2_BackpackTalentDetailView:_onReceiveRpc(_, resultCode)
	if resultCode ~= 0 then
		return
	end

	local curTransformId = Rouge2_BackpackModel.instance:getLastTransformTalentId()

	if self._lastTransformId and curTransformId and self._lastTransformId ~= curTransformId then
		local params = {
			preTalentId = self._lastTransformId,
			curTalentId = curTransformId
		}

		ViewMgr.instance:openView(ViewName.Rouge2_BackpackPetStageResultView, params)
	end

	self:closeThis()
end

function Rouge2_BackpackTalentDetailView:_btnActiveOnClick()
	GameFacade.showToast(ToastEnum.Rouge2TalentPointActive)
end

function Rouge2_BackpackTalentDetailView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_BackpackTalentDetailView:_editableInitView()
	SkillHelper.addHyperLinkClick(self._txtTalentDesc)

	self._listener = Rouge2_CommonItemDescModeListener.Get(self._goDetail, Rouge2_Enum.ItemDescModeDataKey.BackpackSkill)

	self._listener:initCallback(self.refreshItemDesc, self)
end

function Rouge2_BackpackTalentDetailView:onOpen()
	self:refreshDetail()
end

function Rouge2_BackpackTalentDetailView:onUpdateParam()
	self:refreshDetail()
end

function Rouge2_BackpackTalentDetailView:refreshDetail()
	self._talentId = self.viewParam and self.viewParam.talentId
	self._talentCo = Rouge2_CareerConfig.instance:getTalentConfig(self._talentId)
	self._unlockCondition = self._talentCo and self._talentCo.unlock
	self._txtTalentName.text = self._talentCo and self._talentCo.name

	self._listener:startListen()
	self:refreshStatus()
end

function Rouge2_BackpackTalentDetailView:refreshItemDesc(descMode)
	if not self._talentCo then
		self._txtTalentDesc.text = ""

		return
	end

	if descMode == Rouge2_Enum.ItemDescMode.Simply then
		if not self._talentCo.descSimply then
			local descStr = self._talentCo.desc
			local descList = string.split(descStr, "|") or {}
			local fullDescStr = table.concat(descList, "\n")

			self._txtTalentDesc.text = SkillHelper.buildDesc(fullDescStr, PercentColor, BracketColor)
		end
	end
end

function Rouge2_BackpackTalentDetailView:refreshStatus()
	self._status = Rouge2_BackpackModel.instance:getTalentStatus(self._talentId)

	self:refreshStatusUI()
end

function Rouge2_BackpackTalentDetailView:refreshStatusUI()
	if self._status ~= Rouge2_Enum.BagTalentStatus.Active then
		local canUsePointNum = Rouge2_BackpackModel.instance:getCanUseTalentPoint()

		if self._talentCo then
			if not self._talentCo.unlockCost then
				local cost = 0

				self._isEnough = cost <= canUsePointNum

				if self._isEnough then
					if not CostTalentColor_Enough then
						local costColor = CostTalentColor_Lack

						self._txtCost1.text = cost
						self._txtCost2.text = cost

						SLFramework.UGUI.GuiHelper.SetColor(self._txtCost1, costColor)
						SLFramework.UGUI.GuiHelper.SetColor(self._txtCost2, costColor)
					end
				end
			end
		end
	end

	gohelper.setActive(self._btnLock.gameObject, self._status == Rouge2_Enum.BagTalentStatus.Lock)
	gohelper.setActive(self._btnCanActive.gameObject, self._status == Rouge2_Enum.BagTalentStatus.UnlockNotActive or self._status == Rouge2_Enum.BagTalentStatus.UnlockCanActive)
	gohelper.setActive(self._btnActive.gameObject, self._status == Rouge2_Enum.BagTalentStatus.Active)
	self:refreshLockTips()
end

function Rouge2_BackpackTalentDetailView:refreshLockTips()
	self._isUnlock = Rouge2_MapUnlockHelper.checkIsUnlock(self._unlockCondition)

	gohelper.setActive(self._txtLockTips.gameObject, not self._isUnlock)

	if not self._isUnlock then
		self._txtLockTips.text = Rouge2_MapUnlockHelper.getLockTips(self._unlockCondition)
	end

	self._isPreActive = Rouge2_BackpackController.instance:isPreTalentActive(self._talentId)

	gohelper.setActive(self._goPreTips, not self._isPreActive)
end

function Rouge2_BackpackTalentDetailView:_onUpdateRougeInfo()
	self:refreshStatus()
end

function Rouge2_BackpackTalentDetailView:onClose()
	if self._rpcCallbackId then
		Rouge2_Rpc.instance:removeCallbackById(self._rpcCallbackId)

		self._rpcCallbackId = nil
	end

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSelectSkillTalent)
end

function Rouge2_BackpackTalentDetailView:_onCloseView(viewName)
	if viewName == ViewName.Rouge2_BackpackTabView then
		self:closeThis()
	end
end

function Rouge2_BackpackTalentDetailView:_toSwitchTab(containerId, tabId)
	if containerId ~= Rouge2_Enum.BackpackTabContainerId then
		return
	end

	if tabId ~= Rouge2_Enum.BagTabType.ActiveSkill then
		self:closeThis()
	end
end

return Rouge2_BackpackTalentDetailView
