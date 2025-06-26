-- chunkname: @IQIGame\\UI\\ChatBubbleUI.lua

local ChatBubbleUI = {
	chatBubbleDataList = {},
	chatBubbleCellPool = {}
}

ChatBubbleUI = Base:Extend("ChatBubbleUI", "IQIGame.Onigao.UI.ChatBubbleUI", ChatBubbleUI)

require("IQIGame.UIExternalApi.ChatBubbleUIApi")

local ChatBubbleRenderCell = require("IQIGame.UI.Chat.ChatBubble.ChatBubbleRenderCell")

function ChatBubbleUI:OnInit()
	UGUIUtil.SetText(self.TagLockText, ChatBubbleUIApi:GetString("TagLockText"))
	UGUIUtil.SetText(self.TextState, ChatBubbleUIApi:GetString("TextState"))
	UGUIUtil.SetTextInChildren(self.BtnUse, ChatBubbleUIApi:GetString("BtnUseLabel"))

	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateBtnUse()
		self:OnBtnUse()
	end

	function self.DelegateBtnSource()
		self:OnBtnSource()
	end

	function self.DelegateUpdateChatBubble()
		self:OnUpdateChatBubble()
	end

	function self.DelegateSettingChangeEvent()
		self:OnSettingChatBubbleChange()
	end

	local scrollList = self.ScrollArea:GetComponent("ScrollAreaList")

	function scrollList.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end
end

function ChatBubbleUI:GetPreloadAssetPaths()
	return nil
end

function ChatBubbleUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChatBubbleUI:IsManualShowOnOpen(userData)
	return false
end

function ChatBubbleUI:GetBGM(userData)
	return nil
end

function ChatBubbleUI:OnOpen(userData)
	self:UpdateView()
end

function ChatBubbleUI:OnClose(userData)
	return
end

function ChatBubbleUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnUse:GetComponent("Button").onClick:AddListener(self.DelegateBtnUse)
	self.BtnSource:GetComponent("Button").onClick:AddListener(self.DelegateBtnSource)
	EventDispatcher.AddEventListener(EventID.UpdateChatBubbleEvent, self.DelegateUpdateChatBubble)
	EventDispatcher.AddEventListener(EventID.PlayerSettingChangeEvent, self.DelegateSettingChangeEvent)
end

function ChatBubbleUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnUse:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnUse)
	self.BtnSource:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSource)
	EventDispatcher.RemoveEventListener(EventID.UpdateChatBubbleEvent, self.DelegateUpdateChatBubble)
	EventDispatcher.RemoveEventListener(EventID.PlayerSettingChangeEvent, self.DelegateSettingChangeEvent)
end

function ChatBubbleUI:OnPause()
	return
end

function ChatBubbleUI:OnResume()
	return
end

function ChatBubbleUI:OnCover()
	return
end

function ChatBubbleUI:OnReveal()
	return
end

function ChatBubbleUI:OnRefocus(userData)
	return
end

function ChatBubbleUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ChatBubbleUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChatBubbleUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChatBubbleUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChatBubbleUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.chatBubbleCellPool) do
		v:Dispose()
	end
end

function ChatBubbleUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function ChatBubbleUI:OnUpdateChatBubble()
	self:UpdateView()
end

function ChatBubbleUI:OnSettingChatBubbleChange()
	self:UpdateView()
end

function ChatBubbleUI:UpdateView()
	self.chatBubbleDataList = ChatBubbleModule.GetChatBubbles()

	for i, v in pairs(self.chatBubbleDataList) do
		if self.selectBubbleData ~= nil then
			if self.selectBubbleData.cid == v.cid then
				self.selectBubbleData = v

				break
			end
		elseif v.cid == ChatBubbleModule.GetCurrentUseChatBubble() then
			self.selectBubbleData = v

			break
		end
	end

	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.chatBubbleDataList)
	self:ShowSelectBubble()
end

function ChatBubbleUI:ShowSelectBubble()
	for i, v in pairs(self.chatBubbleCellPool) do
		v:SetSelect(v.chatBubbleData.cid == self.selectBubbleData.cid)
	end

	self.Lock:SetActive(not self.selectBubbleData.unlock)
	self.Unlock:SetActive(self.selectBubbleData.unlock)

	local path = UIGlobalApi.GetImagePath(self.selectBubbleData:GetConfigData().Icon)

	AssetUtil.LoadImage(self, path, self.SelectIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.SelectName, self.selectBubbleData:GetConfigData().Name)
	UGUIUtil.SetText(self.LockCondition, self.selectBubbleData:GetConfigData().GainWay)
	UGUIUtil.SetText(self.TextDes, self.selectBubbleData:GetConfigData().Description)
	UGUIUtil.SetText(self.LockText, self.selectBubbleData:GetConfigData().GainTip)
	self.BtnSource:SetActive(self.selectBubbleData:GetConfigData().BuyMallId ~= 0)
	self.BtnUse:SetActive(self.selectBubbleData.cid ~= ChatBubbleModule.GetCurrentUseChatBubble())
end

function ChatBubbleUI:OnSelectedGridCell(cell)
	self.selectBubbleData = self.chatBubbleDataList[cell.index + 1]

	self:ShowSelectBubble()
end

function ChatBubbleUI:OnRenderGridCell(cell)
	local chatBubbleData = self.chatBubbleDataList[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.chatBubbleCellPool[instanceID]

	if renderCell == nil then
		renderCell = ChatBubbleRenderCell.New(cell.gameObject)
		self.chatBubbleCellPool[instanceID] = renderCell
	end

	renderCell:SetData(chatBubbleData)
	renderCell:SetCurrentUse(ChatBubbleModule.GetCurrentUseChatBubble() == chatBubbleData.cid)
end

function ChatBubbleUI:OnBtnUse()
	if self.selectBubbleData.unlock and self.selectBubbleData.cid ~= ChatBubbleModule.GetCurrentUseChatBubble() then
		SettingModule.ChangeData(SettingModule.CHANGE_PLAYER_CHAT_BUBBLE, self.selectBubbleData.cid)
	end
end

function ChatBubbleUI:OnBtnSource()
	if self.selectBubbleData:GetConfigData().BuyMallId ~= 0 then
		UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
			mallCid = self.selectBubbleData:GetConfigData().BuyMallId
		})
	end
end

return ChatBubbleUI
