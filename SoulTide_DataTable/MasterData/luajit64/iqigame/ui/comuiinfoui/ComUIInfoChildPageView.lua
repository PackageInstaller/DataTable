-- chunkname: @IQIGame\\UI\\ComUIInfoUI\\ComUIInfoChildPageView.lua

local ComUIInfoChildPageView = {}

function ComUIInfoChildPageView.New(view, parent)
	local obj = Clone(ComUIInfoChildPageView)

	obj:Init(view, parent)

	return obj
end

function ComUIInfoChildPageView:Init(view, parent)
	self.View = view
	self.parent = parent

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateBtnRight()
		self:OnBtnRight()
	end
end

function ComUIInfoChildPageView:OnAddListeners()
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.delegateBtnRight)
end

function ComUIInfoChildPageView:OnRemoveListeners()
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRight)
end

function ComUIInfoChildPageView:SetData(tabData, index, totalPage)
	self.tabData = tabData
	self.index = index
	self.totalPage = totalPage

	for i = 0, self.Point.transform.childCount - 1 do
		local obj = self.Point.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	local pagePrefab = self.parent.UIController:GetPreloadedAsset(UIGlobalApi.GetUIPrefab(tabData[1]))

	self.pageObj = UnityEngine.Object.Instantiate(pagePrefab)

	LuaCodeInterface.BindOutlet(self.pageObj, self)
	self.pageObj.transform:SetParent(self.Point.transform, false)

	for i = 1, #self.tabData[2] do
		local str = self.tabData[2][i]
		local textObj = self["Text_" .. i]

		if textObj then
			UGUIUtil.SetText(textObj.gameObject, str)
		end
	end

	self.BtnRight:SetActive(self.index < self.totalPage)
	self:OnAddListeners()
end

function ComUIInfoChildPageView:OnBtnRight()
	if self.nextPageCallBack then
		self.nextPageCallBack(self.index)
	end
end

function ComUIInfoChildPageView:Dispose()
	self:OnRemoveListeners()

	self.nextPageCallBack = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	LuaCodeInterface.ClearOutlet(self.pageObj, self)

	self.View = nil
end

return ComUIInfoChildPageView
