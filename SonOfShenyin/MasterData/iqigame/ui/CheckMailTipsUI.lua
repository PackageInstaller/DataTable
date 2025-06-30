-- chunkname: @IQIGame\\UI\\CheckMailTipsUI.lua

local CheckMailTipsUI = {
	ItemList = {}
}

CheckMailTipsUI = Base:Extend("CheckMailTipsUI", "IQIGame.Onigao.UI.CheckMailTipsUI", CheckMailTipsUI)

local checkMailItemCell = require("IQIGame.UI.Mail.CheckMailItemCell")

function CheckMailTipsUI:OnInit()
	function self.DelegateCloseBtn()
		self:OnCloseBtnClick()
	end

	function self.DelegateDelSpecialMailEvent(mails)
		self:DelSpecialMailEvent(mails)
	end

	self.wrapContent = self.MailTipsItemContent:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	UGUIUtil.SetText(self.MailTipsTitle, MailUIApi:GetCheckMailTitle())
end

function CheckMailTipsUI:GetPreloadAssetPaths()
	return nil
end

function CheckMailTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CheckMailTipsUI:IsManualShowOnOpen(userData)
	return false
end

function CheckMailTipsUI:GetBGM(userData)
	return nil
end

function CheckMailTipsUI:OnOpen(userData)
	LuaUtility.SetGameObjectShow(self.MailTipsItemContent, false)

	self.showDelMailData = nil
	self.cueState = userData.type

	if userData.type == Constant.MailTips.SpaceNotEnough then
		UGUIUtil.SetText(self.MailTipsContent, MailUIApi:GetCheckMailSpcaeEnoughText())
	elseif userData.type == Constant.MailTips.ExpiringSoon then
		UGUIUtil.SetText(self.MailTipsContent, MailUIApi:GetCheckMailExpiringSoonText())
	elseif userData.type == Constant.MailTips.HasDelMail then
		self:GetSpecialMailEvent(userData.mails)
	end
end

function CheckMailTipsUI:OnClose(userData)
	return
end

function CheckMailTipsUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtn)
	EventDispatcher.AddEventListener(EventID.DeleteMailEvent, self.DelegateDelSpecialMailEvent)
end

function CheckMailTipsUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.DeleteMailEvent, self.DelegateDelSpecialMailEvent)
end

function CheckMailTipsUI:OnPause()
	return
end

function CheckMailTipsUI:OnResume()
	return
end

function CheckMailTipsUI:OnCover()
	return
end

function CheckMailTipsUI:OnReveal()
	return
end

function CheckMailTipsUI:OnRefocus(userData)
	return
end

function CheckMailTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CheckMailTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CheckMailTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CheckMailTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CheckMailTipsUI:OnDestroy()
	for k, v in pairs(self.ItemList) do
		v:Dispose()
	end

	self.ItemList = {}
end

function CheckMailTipsUI:OnCloseBtnClick()
	if self.cueState == Constant.MailTips.HasDelMail then
		MailModule.DelMail({
			self.showDelMailData.id
		}, false)

		return
	end

	if self.cueState ~= Constant.MailTips.ExpiringSoon then
		self.cueState = Constant.MailTips.ExpiringSoon

		if MailModule.GetIsExpiringSoon() then
			UGUIUtil.SetText(self.MailTipsContent, MailUIApi:GetCheckMailExpiringSoonText())

			return
		end
	end

	UIModule.CloseSelf(self)

	MailModule.isNotPrompt = true
end

function CheckMailTipsUI:GetSpecialMailEvent(mails)
	self.showDelMailData = mails[1]

	UGUIUtil.SetText(self.MailTipsContent, CfgMailTable[self.showDelMailData.cid].Content)
	LuaUtility.SetGameObjectShow(self.MailTipsItemContent, true)
	self.wrapContent:Refresh(#self.showDelMailData.itemList)
end

function CheckMailTipsUI:DelSpecialMailEvent(mails)
	UIModule.CloseSelf(self)

	self.showDelMailData = nil
	self.cueState = nil
	MailModule.isDelSpecialMail = true
end

function CheckMailTipsUI:OnRenderItem(cell)
	local itemData = ItemData.CreateByCIDAndNumber(self.showDelMailData.itemList[cell.index + 1].cid, self.showDelMailData.itemList[cell.index + 1].num)
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.ItemList[instanceId]

	if itemCell == nil then
		itemCell = checkMailItemCell.New(cell.gameObject)
		self.ItemList[instanceId] = itemCell
	end

	itemCell:SetData(itemData)
end

return CheckMailTipsUI
