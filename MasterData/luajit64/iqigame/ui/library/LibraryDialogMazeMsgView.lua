-- chunkname: @IQIGame\\UI\\Library\\LibraryDialogMazeMsgView.lua

local LibraryDialogMazeMsgView = {
	index = 1,
	storyResToggleCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function LibraryDialogMazeMsgView.New(view)
	local obj = Clone(LibraryDialogMazeMsgView)

	obj:Init(view)

	return obj
end

function LibraryDialogMazeMsgView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextTitle, LibraryMazeUIApi:GetString("MsgViewTextTitle"))

	self.btnLeft = self.BtnLeft:GetComponent("Button")
	self.btnRight = self.BtnRight:GetComponent("Button")

	function self.delegateBtnLeft()
		self:OnBtnLeft()
	end

	function self.delegateBtnRight()
		self:OnBtnRight()
	end

	self.ToggleMould:SetActive(false)

	self.storyResTogglePool = UIObjectPool.New(10, function()
		local cellObj = UnityEngine.Object.Instantiate(self.ToggleMould)

		return cellObj
	end, function(currentCell)
		UnityEngine.Object.Destroy(currentCell)
	end)

	self:AddListener()
end

function LibraryDialogMazeMsgView:AddListener()
	self.btnRight.onClick:AddListener(self.delegateBtnRight)
	self.btnLeft.onClick:AddListener(self.delegateBtnLeft)
end

function LibraryDialogMazeMsgView:RemoveListener()
	self.btnRight.onClick:RemoveListener(self.delegateBtnRight)
	self.btnLeft.onClick:RemoveListener(self.delegateBtnLeft)
end

function LibraryDialogMazeMsgView:UpdateView()
	for i, v in pairs(self.storyResToggleCells) do
		v.transform:SetParent(nil, false)
		v:SetActive(false)
		self.storyResTogglePool:Release(v)
	end

	self.storyResToggleCells = {}

	for i = 1, #self.storyResDataTab do
		local storyRes = self.storyResDataTab[i]
		local toggleObj = self.storyResTogglePool:Obtain()

		toggleObj.transform:SetParent(self.Toggles.transform, false)
		toggleObj:SetActive(true)

		local cfg = CfgTownMazeStoryBookResTable[storyRes.cfgID]

		UGUIUtil.SetText(toggleObj.transform:Find("goDown/Text").gameObject, tostring(cfg.ChapterId))
		UGUIUtil.SetText(toggleObj.transform:Find("goUp/Text_01").gameObject, tostring(cfg.ChapterId))
		UGUIUtil.SetText(toggleObj.transform:Find("goUp/Text_02").gameObject, cfg.TabName)
		UGUIUtil.SetText(toggleObj.transform:Find("goUp/Text_03").gameObject, cfg.ChapterNum)

		toggleObj:GetComponent("Toggle").enabled = false
		self.storyResToggleCells[i] = toggleObj
	end

	self:ShowCurrentMsg()
end

function LibraryDialogMazeMsgView:ShowCurrentMsg()
	self.BtnRight:SetActive(self.index < #self.storyResDataTab)
	self.BtnLeft:SetActive(self.index > 1)

	for i = 1, #self.storyResToggleCells do
		local obj = self.storyResToggleCells[i]

		if self.index == i then
			obj:GetComponent("Toggle").isOn = true
		else
			obj:GetComponent("Toggle").isOn = false
		end
	end

	local storyRes = self.storyResDataTab[self.index]
	local cfg = CfgTownMazeStoryBookResTable[storyRes.cfgID]

	UGUIUtil.SetText(self.TextContent, cfg.TextDescribe)
end

function LibraryDialogMazeMsgView:SetDate(data)
	local townLibraryStoryData = data
	local resData = townLibraryStoryData:GetStoryResTab(Constant.LibraryStoryResType.MazeResType)

	self.storyResDataTab = {}

	for i = 1, #resData do
		local res = resData[i]

		if res.isLock then
			table.insert(self.storyResDataTab, res)
		end
	end

	self.index = 1

	self:UpdateView()
end

function LibraryDialogMazeMsgView:OnBtnLeft()
	self.index = self.index - 1

	if self.index < 1 then
		self.index = 1
	end

	self:ShowCurrentMsg()
end

function LibraryDialogMazeMsgView:OnBtnRight()
	self.index = self.index + 1

	if self.index > #self.storyResDataTab then
		self.index = #self.storyResDataTab
	end

	self:ShowCurrentMsg()
end

function LibraryDialogMazeMsgView:Open()
	self.View:SetActive(true)
end

function LibraryDialogMazeMsgView:Close()
	self.View:SetActive(false)
end

function LibraryDialogMazeMsgView:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.storyResToggleCells) do
		self.storyResTogglePool:Release(v)
	end

	self.storyResToggleCells = {}

	self.storyResTogglePool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibraryDialogMazeMsgView
