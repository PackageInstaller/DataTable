-- chunkname: @IQIGame\\UI\\MailUI.lua

local MailUI = Base:Extend("MailUI", "IQIGame.Onigao.UI.MailUI", {
	currentSelect = 1,
	isOpen = false
})
local MailMouldCell = require("IQIGame.UI.Mail.MailMouldCell")
local NewMouldCell = require("IQIGame.UI.Mail.NewMouldCell")

function MailUI:OnInit()
	self:Init()
end

function MailUI:GetPreloadAssetPaths()
	return nil
end

function MailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MailUI:OnOpen(userData)
	self.btnBack.enabled = false
	self.currentSelect = 1
	self.toggles[self.currentSelect].isOn = true

	self:IsShowPanel()
	TownLibraryModule.OpenLibrary(function()
		self:UpdateNewsRed()
	end)
end

function MailUI:OnClose(userData)
	self.isOpen = false
end

function MailUI:OnPause()
	return
end

function MailUI:OnResume()
	return
end

function MailUI:OnCover()
	return
end

function MailUI:OnReveal()
	return
end

function MailUI:OnRefocus(userData)
	return
end

function MailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MailUI:OnLoadSucceed(assetName, asset, duration, userData)
	if userData == "Mail_mould" then
		self.mailMouldPrefab = asset
	elseif userData == "CommonSlotUI" then
		self.commonSlotPrefab = asset

		self:CreateItems()
	end

	self:IsShowPanel()
end

function MailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	MailMouldCell.DisposeIn(self)
	NewMouldCell.DisposeIn(self)
end

function MailUI:Init()
	self.btnBack = self.BtnBack:GetComponent("Button")
	self.btnDel = self.BtnDel:GetComponent("Button")
	self.btnDelOnce = self.BtnDelOnce:GetComponent("Button")
	self.btnAuto = self.BtnAuto:GetComponent("Button")
	self.btnReceive = self.BtnReceive:GetComponent("Button")
	self.tweenPosition = self.Frame:GetComponent("TweenPosition")
	self.scrollPageList = self.goScrollList:GetComponent("ScrollAreaList")

	function self.scrollPageList.onRenderCell(gridCell)
		self:OnUpDateMailCell(gridCell)
	end

	function self.scrollPageList.onSelectedCell(gridCell)
		self:OnSelectMailCell(gridCell)
	end

	self.scrollNewPageList = self.NewScrollList:GetComponent("ScrollAreaList")

	function self.scrollNewPageList.onRenderCell(gridCell)
		self:OnUpDateNewCell(gridCell)
	end

	function self.scrollNewPageList.onSelectedCell(gridCell)
		self:OnSelectNewCell(gridCell)
	end

	function self.delegateTweenClose()
		self:OnTweenPositionFinished()
	end

	function self.delegateTweenOpen()
		self:OnTweenPositionOPen()
	end

	function self.delegateClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.delegateClickBtnDel()
		self:OnClickBtnDel()
	end

	function self.delegateClickBtnDelOnce()
		self:OnClickBtnDelOnce()
	end

	function self.delegateClickBtnAuto()
		self:OnClickBtnAuto()
	end

	function self.delegateClickBtnReceive()
		self:OnClickBtnReceive()
	end

	function self.delegateGetAllMails()
		self:OnGetAllMails()
	end

	function self.delegateMailDataChange(mailId)
		self:OnMailDataChange(mailId)
	end

	function self.delegateDeleteMail(mails)
		self:OnDelegateDeleteMail(mails)
	end

	function self.DelegateOnClickCloseContentBtn()
		self:OnClickCloseContentBtn()
	end

	function self.delegateOnToggleChange(isOn)
		self:OnToggleChange(isOn)
	end

	function self.delegateUpdateLibraryNews(newData)
		self:OnUpdateLibraryNews(newData)
	end

	self:LoadMailMouldPrefab()
	self:LoadCommonSlotPrefab()

	self.startPos = Vector3.New(self.tweenPosition.from.x, self.tweenPosition.from.y, self.tweenPosition.from.z)
	self.endPos = Vector3.New(self.tweenPosition.to.x, self.tweenPosition.to.y, self.tweenPosition.to.z)
	self.tweenSpeed = self.tweenPosition.duration
	self.toggles = {}

	for i = 1, 2 do
		self["Toggle" .. i]:GetComponent("ToggleHelperComponent").text = MailUIApi:GetString("ToggleStr", i)

		local toggle = self["Toggle" .. i]:GetComponent("Toggle")

		toggle.group = self.ToggleGroup:GetComponent("ToggleGroup")
		toggle.isOn = false
		self.toggles[i] = toggle
	end

	UGUIUtil.SetText(self.NullText, MailUIApi:GetString("NullText", 1))
	UGUIUtil.SetText(self.NewNullText, MailUIApi:GetString("NullText", 2))

	self.BtnDel.transform:Find("Text"):GetComponent("Text").text = MailUIApi:GetString("goBtnDeleteAll")
	self.BtnAuto.transform:Find("Text"):GetComponent("Text").text = MailUIApi:GetString("goBtnGetAll")
	self.BtnReceive.transform:Find("Text"):GetComponent("Text").text = MailUIApi:GetString("goBtnGet")
	self.BtnDelOnce.transform:Find("Text"):GetComponent("Text").text = MailUIApi:GetString("goBtnDeleteOnce")

	UGUIUtil.SetText(self.TipText, MailUIApi:GetString("TipText"))
end

function MailUI:LoadMailMouldPrefab()
	local prefabPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_MailUI/Mail_mould")

	AssetUtil.LoadAsset(self, prefabPath, self.OnLoadSucceed, self.OnLoadFailed, "Mail_mould")
end

function MailUI:LoadCommonSlotPrefab()
	local prefabPath = AssetPath.Get(GlobalKey.UIPrefabPath, "Common/CommonSlotUI")

	AssetUtil.LoadAsset(self, prefabPath, self.OnLoadSucceed, self.OnLoadFailed, "CommonSlotUI")
end

function MailUI:IsShowPanel()
	if self.isOpen == false and self.mailMouldPrefab ~= nil and self.commonSlotPrefab ~= nil then
		EventDispatcher.Dispatch(EventID.PlayMailPanelEffect, 1)

		self.tweenPosition = TweenPosition.Begin(self.Frame, self.tweenSpeed, self.endPos)

		self.tweenPosition:SetOnFinished(self.delegateTweenOpen)

		self.btnBack.enabled = false
		self.isOpen = true

		MailModule.GetAllMails()
		self:ShowContent(false)
		self:ShowTab()
	end
end

function MailUI:OnAddListeners()
	self.btnBack.onClick:AddListener(self.delegateClickBtnBack)
	self.btnDel.onClick:AddListener(self.delegateClickBtnDel)
	self.btnAuto.onClick:AddListener(self.delegateClickBtnAuto)
	self.btnReceive.onClick:AddListener(self.delegateClickBtnReceive)
	self.btnDelOnce.onClick:AddListener(self.delegateClickBtnDelOnce)
	self.CloseContentBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseContentBtn)
	EventDispatcher.AddEventListener(EventID.GetAllMailsEvent, self.delegateGetAllMails)
	EventDispatcher.AddEventListener(EventID.MailDataChangeEvent, self.delegateMailDataChange)
	EventDispatcher.AddEventListener(EventID.DeleteMailEvent, self.delegateDeleteMail)
	EventDispatcher.AddEventListener(EventID.UpdateLibraryNewsEvent, self.delegateUpdateLibraryNews)

	for i, v in pairs(self.toggles) do
		v.onValueChanged:AddListener(self.delegateOnToggleChange)
	end
end

function MailUI:OnRemoveListeners()
	self.btnBack.onClick:RemoveListener(self.delegateClickBtnBack)
	self.btnDel.onClick:RemoveListener(self.delegateClickBtnDel)
	self.btnAuto.onClick:RemoveListener(self.delegateClickBtnAuto)
	self.btnReceive.onClick:RemoveListener(self.delegateClickBtnReceive)
	self.btnDelOnce.onClick:RemoveListener(self.delegateClickBtnDelOnce)
	self.CloseContentBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseContentBtn)
	EventDispatcher.RemoveEventListener(EventID.GetAllMailsEvent, self.delegateGetAllMails)
	EventDispatcher.RemoveEventListener(EventID.MailDataChangeEvent, self.delegateMailDataChange)
	EventDispatcher.RemoveEventListener(EventID.DeleteMailEvent, self.delegateDeleteMail)
	EventDispatcher.RemoveEventListener(EventID.UpdateLibraryNewsEvent, self.delegateUpdateLibraryNews)

	for i, v in pairs(self.toggles) do
		v.onValueChanged:RemoveListener(self.delegateOnToggleChange)
	end
end

function MailUI:CreateItems()
	self.itemsTab = {}

	for i = 1, 10 do
		local itemObj = UnityEngine.Object.Instantiate(self.commonSlotPrefab)

		itemObj.transform:SetParent(self.GridItem.transform, false)
		itemObj:SetActive(false)

		self.itemsTab[i] = itemObj
	end
end

function MailUI:OnGetAllMails()
	self.BtnDelOnce.gameObject:SetActive(self.currentSelectMail ~= nil)

	self.tableMails = {}

	local unreadNum = 0

	for k, v in pairs(MailModule.mailDic) do
		self.tableMails[#self.tableMails + 1] = v

		if not v.isRead then
			unreadNum = unreadNum + 1
		end
	end

	self.scrollPageList:Refresh(#self.tableMails)
	self.BtnReceive:SetActive(false)

	if self.currentSelectMail ~= nil then
		self.currentSelectMail:OnTogChange(true)
		self:OnMailDataChange(self.currentSelectMail.mailData.Id)
	end

	UGUIUtil.SetText(self.TotalNumText, MailUIApi:GetString("TotalNumText", #self.tableMails, 50))
	UGUIUtil.SetText(self.UnreadNumText, MailUIApi:GetString("UnreadNumText", unreadNum))

	local isHaveMail = #self.tableMails > 0

	self.ListMail:SetActive(isHaveMail)
	self.Null:SetActive(not isHaveMail)
	self.Tips:SetActive(isHaveMail)
	self:ShowTab()
end

function MailUI:OnDelegateDeleteMail(mails)
	if self.currentSelectMail ~= nil then
		local id = self.currentSelectMail.mailData.Id

		for i, mailID in pairs(mails) do
			if mailID == id then
				self.currentSelectMail:OnTogChange(false)

				self.currentSelectMail = nil

				break
			end
		end
	end

	self:OnGetAllMails()
	self:ShowContent(false)
end

function MailUI:OnUpDateMailCell(cell)
	local mailData = self.tableMails[cell.index + 1]

	if mailData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local item = cell.gameObject
	local itemCell = MailMouldCell.PackageOrReuseView(self, item)

	itemCell:SetItem(mailData)
end

function MailUI:OnSelectMailCell(cell)
	local item = cell.gameObject
	local itemCell = MailMouldCell.PackageOrReuseView(self, item)

	if self.currentSelectMail ~= nil and self.currentSelectMail.isSelected == true then
		self.currentSelectMail:SelectState(false)
	end

	self.currentSelectMail = itemCell

	self.currentSelectMail:SelectState(true)

	if self.currentSelectMail.mailData ~= nil then
		if self.currentSelectMail.mailData.isRead == false then
			MailModule.ReadMail(self.currentSelectMail.mailData.Id)
		else
			self:OnMailDataChange(self.currentSelectMail.mailData.Id)
		end
	end
end

function MailUI:OnMailDataChange(mailId)
	local mailData = MailModule.GetMailByMailID(mailId)

	if self.currentSelectMail ~= nil and self.currentSelectMail.mailData.Id == mailId then
		self.currentSelectMail:SetItem(mailData)
	end

	self.BtnDelOnce:SetActive(self.currentSelectMail ~= nil)

	if mailData ~= nil then
		self.TextMailName:GetComponent("Text").text = MailUIApi:GetString("mailTitle2", mailData.title)

		local mailTime

		if mailData.expireTime <= 0 then
			mailTime = MailUIApi:GetString("mailTime", 1)
		else
			local cd = mailData.expireTime - PlayerModule.GetServerTime()

			if cd > 0 then
				mailTime = MailUIApi:GetString("mailTime", 2, getTimeDurationText(cd, 2))
			else
				mailTime = MailUIApi:GetString("mailTime", 3)
			end
		end

		self.goSendTimeTitle:GetComponent("Text").text = MailUIApi:GetString("createTime", getDateText(mailData.createTime))
		self.TextSender:GetComponent("Text").text = MailUIApi:GetString("sender", mailData.sender)
		self.TextContent:GetComponent("Text").text = MailUIApi:GetString("content", mailData.content)

		local tag = mailData.isHasItem == true

		self.BtnReceive:SetActive(tag)
		self.BtnDelOnce:SetActive(not tag)
		self:ShowPageItem()
	else
		self.BtnReceive:SetActive(false)
	end

	self:ShowContent(self.currentSelectMail ~= nil)
	self:ShowUnreadNum()
end

function MailUI:ShowUnreadNum()
	local unreadNum = 0

	for k, v in pairs(MailModule.mailDic) do
		if not v.isRead then
			unreadNum = unreadNum + 1
		end
	end

	UGUIUtil.SetText(self.TotalNumText, MailUIApi:GetString("TotalNumText", #self.tableMails, 50))
	UGUIUtil.SetText(self.UnreadNumText, MailUIApi:GetString("UnreadNumText", unreadNum))
end

function MailUI:ShowPageItem()
	for i = 1, #self.itemsTab do
		self.itemsTab[i]:SetActive(false)
	end

	self.Item:SetActive(false)

	local itemObj

	if self.currentSelectMail ~= nil then
		local isShowItem = false
		local mailData = MailModule.GetMailByMailID(self.currentSelectMail.mailData.Id)

		if mailData ~= nil and mailData.itemList ~= nil then
			local realItemList = {}

			for i, v in ipairs(mailData.itemList) do
				if CfgItemTable[v.cid].IsPanelShow then
					realItemList[#realItemList + 1] = v
				end
			end

			for k = 1, #self.itemsTab do
				if realItemList[k] ~= nil then
					itemObj = self.itemsTab[k]

					itemObj:SetActive(true)

					local itemData = CfgItemTable[realItemList[k].cid]
					local itemCell = ItemCell.PackageOrReuseView(self, itemObj)

					itemCell:SetItem(itemData)
					itemCell:SetNum(realItemList[k].num)

					isShowItem = true
				end
			end
		end

		self.Item:SetActive(isShowItem)
	end

	self.GridItem:GetComponent("GrayComponent"):SetGray(not self.currentSelectMail.mailData.isHasItem)
end

function MailUI:OnTweenPositionOPen()
	self.tweenPosition:RemoveOnFinished(self.delegateTweenOpen)

	self.btnBack.enabled = true
end

function MailUI:OnClickBtnBack()
	self.tweenPosition = TweenPosition.Begin(self.Frame, self.tweenSpeed, self.startPos)

	EventDispatcher.Dispatch(EventID.PlayMailPanelEffect, 2)
	self.tweenPosition:SetOnFinished(self.delegateTweenClose)
end

function MailUI:OnTweenPositionFinished()
	self.tweenPosition:RemoveOnFinished(self.delegateTweenClose)
	UIModule.Close(Constant.UIControllerName.MailUI)
end

function MailUI:OnClickBtnDel()
	local mailList = {}

	for i, v in pairs(MailModule.mailDic) do
		if v.isRead == true and v.isHasItem == false then
			mailList[#mailList + 1] = v.Id
		end
	end

	if #mailList == 0 then
		NoticeModule.ShowNotice(21044000)

		return
	end

	MailModule.DelMail(mailList)
end

function MailUI:OnClickBtnDelOnce()
	if self.currentSelectMail ~= nil then
		local mailList = {
			self.currentSelectMail.mailData.Id
		}

		MailModule.DelMail(mailList)
	end
end

function MailUI:OnClickBtnAuto()
	local mailList = {}

	for i, v in pairs(MailModule.mailDic) do
		if v.isHasItem == true then
			mailList[#mailList + 1] = v.Id
		end
	end

	if #mailList == 0 then
		NoticeModule.ShowNotice(21044001)

		return
	end

	MailModule.PickUp(mailList)
end

function MailUI:OnClickBtnReceive()
	if self.currentSelectMail ~= nil and self.currentSelectMail.mailData.isHasItem == true then
		local mailList = {
			self.currentSelectMail.mailData.Id
		}

		MailModule.PickUp(mailList)
	end
end

function MailUI:OnClickCloseContentBtn()
	self:ShowContent(false)
end

function MailUI:ShowContent(value)
	self.ContentPanel:SetActive(value)
	self.ListPanel:SetActive(not value)

	if not value and self.currentSelectMail ~= nil then
		self.currentSelectMail:SelectState(false)

		self.currentSelectMail = nil
	end
end

function MailUI:OnToggleChange(isOn)
	if isOn then
		local index

		for i = 1, #self.toggles do
			local toggle = self.toggles[i]

			if toggle.isOn == true then
				index = i

				break
			end
		end

		if self.currentSelect ~= index then
			self.currentSelect = index

			self:ShowTab()
		end
	end
end

function MailUI:ShowTab()
	if self.currentSelect == 1 then
		self.NewListPanel:SetActive(false)
		self.MailPanel:SetActive(true)
	elseif self.currentSelect == 2 then
		TownLibraryModule.OpenLibrary(function()
			self.MailPanel:SetActive(false)

			self.tableNews = TownLibraryModule.GetUnLockNews()

			self.scrollNewPageList:Refresh(#self.tableNews)

			local showNew = #self.tableNews > 0

			self.NewListPanel:SetActive(showNew)
			self.NewNull:SetActive(not showNew)
		end)
	end
end

function MailUI:OnUpDateNewCell(cell)
	local newData = self.tableNews[cell.index + 1]

	if newData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local item = cell.gameObject
	local itemCell = NewMouldCell.PackageOrReuseView(self, item)

	itemCell:SetItem(newData)
end

function MailUI:OnSelectNewCell(cell)
	local newData = self.tableNews[cell.index + 1]

	if newData then
		UIModule.Open(Constant.UIControllerName.LibraryNewsPaperUI, Constant.UILayer.UI, newData)
	end
end

function MailUI:UpdateNewsRed()
	local isRed = TownLibraryModule.GetRedPoint(Constant.LibraryTaskType.TaskTypeNews)

	self.ImgRedNews:SetActive(isRed)
end

function MailUI:OnUpdateLibraryNews(newDate)
	self:ShowTab()
	self:UpdateNewsRed()
end

return MailUI
