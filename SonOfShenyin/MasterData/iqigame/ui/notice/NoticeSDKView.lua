-- chunkname: @IQIGame\\UI\\Notice\\NoticeSDKView.lua

local m = {
	noticeToggleList = {}
}

function m.New(view, uiController)
	local obj = Clone(m)

	obj:Init(view, uiController)

	return obj
end

function m:Init(view, uiController)
	self.View = view
	self.UIController = uiController

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateTabClick(isOn)
		self:OnClickTab(isOn)
	end

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.scrollList.onRenderEnd()
		self:OnRenderCellEnd()
	end

	self.HeadImageComponent = self.HeadImage:GetComponent("Image")
	self.ViewScrollViewCom = self.ViewScrollView:GetComponent("ScrollRect")

	self:AddListeners()
end

function m:AddListeners()
	for k, v in pairs(self.noticeToggleList) do
		v:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateTabClick)
	end
end

function m:RemoveListeners()
	for k, v in pairs(self.noticeToggleList) do
		v:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateTabClick)
	end
end

function m:SetData(noticeData)
	self.NoticeDatas = noticeData

	table.sort(self.NoticeDatas, function(a, b)
		return a.sort < b.sort
	end)
	self.scrollList:Refresh(#self.NoticeDatas)
end

function m:OnRenderGridCell(cell)
	local noticeData = self.NoticeDatas[cell.index + 1]

	self.noticeToggleList[cell.index + 1] = cell.gameObject
	cell.gameObject:GetComponent("ToggleHelperComponent").text = noticeData.title

	local IsRead = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.Notice_IsNew .. noticeData.id)
	local isNew = IsRead == ""

	cell.transform:Find("Tag").gameObject:SetActive(isNew)
end

function m:OnRenderCellEnd()
	self:AddListeners()

	if #self.NoticeDatas > 0 then
		self.noticeToggleList[1]:GetComponent("Toggle").isOn = true

		self:ShowTab(1)
	end
end

function m:OnClickTab(isOn)
	if isOn then
		local currentTarget = self.UIController:GetCurrentTarget()

		for i = 1, #self.noticeToggleList do
			if self.noticeToggleList[i] == currentTarget then
				self:ShowTab(i)

				return
			end
		end
	end
end

function m:ShowTab(index)
	self.HeadImage:SetActive(false)

	local selectNotice = self.NoticeDatas[index]
	local IsRead = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.Notice_IsNew .. selectNotice.id)

	if IsRead == "" then
		PlayerPrefsUtil.SetString("", Constant.PlayerPrefsConst.Notice_IsNew .. selectNotice.id, "true")
	end

	self.noticeToggleList[index].transform:Find("Tag").gameObject:SetActive(false)
	UGUIUtil.SetText(self.TextContent, selectNotice.content)

	self.ViewScrollViewCom.verticalNormalizedPosition = 1

	EventDispatcher.Dispatch(EventID.CheckNoticeEvent, self.NoticeDatas)

	if selectNotice.imageUrl == "" or selectNotice.imageUrl == nil then
		self.HeadImage:SetActive(false)
	elseif LoginModule.NoticeCacheList[selectNotice.id] then
		self:SetNoticeImg(LoginModule.NoticeCacheList[selectNotice.id])
	else
		HttpModule.RequestGetTexture(selectNotice.imageUrl, function(sprite)
			LoginModule.NoticeCacheList[selectNotice.id] = sprite

			self:SetNoticeImg(sprite)
		end, function(info)
			self.HeadImage:SetActive(false)
		end)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.Content.transform)
end

function m:SetNoticeImg(sprite)
	if not self.HeadImage.activeSelf then
		self.HeadImage:SetActive(true)
	end

	local ratio = sprite.rect.w / 810

	self.HeadImageComponent.sprite = sprite

	LuaUtility.SetSizeDeltaWithRectTransform(self.HeadImageComponent:GetComponent("RectTransform"), sprite.rect.w / ratio, sprite.rect.h / ratio)
end

function m:Reset()
	LuaUtility.SetGameObjectShow(self.HeadImage, false)
	UGUIUtil.SetText(self.TextContent, "")
end

function m:Show()
	self:Reset()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
	self:RemoveListeners()
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
