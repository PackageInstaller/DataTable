-- chunkname: @IQIGame\\UI\\TransformUI\\ChangeBagPanel_ItemView.lua

local ChangeBagPanel_ItemView = {}
local CompoundContent_NeedItemViewClass = require("IQIGame.UI.TransformUI.CompoundContent_NeedItemView")

function ChangeBagPanel_ItemView.New(go, mainView)
	local o = Clone(ChangeBagPanel_ItemView)

	o:Initialize(go, mainView)

	return o
end

function ChangeBagPanel_ItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMember()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function ChangeBagPanel_ItemView:InitMember()
	self.ItemViewArray = {}
end

function ChangeBagPanel_ItemView:InitComponent()
	return
end

function ChangeBagPanel_ItemView:InitDelegate()
	function self.delegateOnClickBtnGo()
		self:OnClickBtnGo()
	end
end

function ChangeBagPanel_ItemView:AddListener()
	self.btnGo:GetComponent("Button").onClick:AddListener(self.delegateOnClickBtnGo)
end

function ChangeBagPanel_ItemView:RemoveListener()
	self.btnGo:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickBtnGo)
end

function ChangeBagPanel_ItemView:OnDestroy()
	self:RemoveListener()

	local len = #self.ItemViewArray

	for i = 1, len do
		self.ItemViewArray[i]:OnDestroy()
	end

	self.ItemViewArray = {}

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function ChangeBagPanel_ItemView:OnClickBtnGo()
	if not ConditionModule.Check(self.Data.TransCondition) then
		NoticeModule.ShowNotice(70008)

		return
	end

	self.mainView:SetSelectCombinationID(self.Data.Id, self)
	EventDispatcher.Dispatch(EventID.TransformUIChangeRecipeRefresh, self.Data.Id)
	self:SetSelect()
end

function ChangeBagPanel_ItemView:Refresh(Data)
	self.Data = Data

	self:RefreshItems()

	if self.mainView:GetSelectCombinationID() == self.Data.Id then
		LuaUtility.SetGameObjectShow(self.selectState, true)
		self.mainView:SetSelectCombinationID(self.Data.Id, self)
	else
		LuaUtility.SetGameObjectShow(self.selectState, false)
	end

	self:CheckLock()
end

function ChangeBagPanel_ItemView:RefreshItems()
	local data = self.Data.Combination
	local len = #data
	local index = 1

	for i = 1, len - 1, 2 do
		local tb = {}

		tb.Id = data[i]
		tb.Count = data[i + 1]

		if data[i] ~= Constant.ItemCid.GOLD then
			local view = self:_GetItem(index)

			view:Refresh(tb)
			view:Show()

			index = index + 1
		end
	end

	if index > 1 then
		self.ItemViewArray[index - 1]:HideAddImage()
	end

	len = #self.ItemViewArray

	for i = index, len do
		self.ItemViewArray[i]:Hide()
	end
end

function ChangeBagPanel_ItemView:_GetItem(index)
	if not self.ItemViewArray[index] then
		local o = GameObject.Instantiate(self.mainView:GetCommonSlot(), self.itemGrid.transform)

		self.ItemViewArray[index] = CompoundContent_NeedItemViewClass.New(o, self)
	end

	return self.ItemViewArray[index]
end

function ChangeBagPanel_ItemView:SetSelect()
	LuaUtility.SetGameObjectShow(self.selectState, true)
end

function ChangeBagPanel_ItemView:CancelSelect()
	LuaUtility.SetGameObjectShow(self.selectState, false)
end

function ChangeBagPanel_ItemView:CheckLock()
	LuaUtility.SetGameObjectShow(self.lockState, not ConditionModule.Check(self.Data.TransCondition))
end

return ChangeBagPanel_ItemView
