-- chunkname: @IQIGame\\UI\\ExploreHall\\FishingActivity\\FishingActivityMain\\FishingActivityMainSkillView.lua

local m = {
	ReleaseSkillCD = 10000,
	ReleaseSkillPassTime = 0,
	Start = false,
	MaxInputNum = 7,
	SkillActionCells = {},
	PutList = {},
	SkillActionDirCells = {},
	SkillActionDataList = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local FishingActivityMainSkillActionShowCell = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivityMain.FishingActivityMainSkillActionShowCell")
local FishingActivitySkillActionDirCell = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivitySkillActionDirCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateSkillAction1()
		self:OnSkillAction1()
	end

	function self.DelegateSkillAction2()
		self:OnSkillAction2()
	end

	function self.DelegateSkillAction3()
		self:OnSkillAction3()
	end

	function self.DelegateSkillAction4()
		self:OnSkillAction4()
	end

	function self.DelegateBtnBack()
		self:OnBtnBack()
	end

	function self.DelegateBtnPut()
		self:OnBtnPut()
	end

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	self.SkillActionShowMould:SetActive(false)

	self.SkillActionCellPool = UIObjectPool.New(10, function()
		return FishingActivityMainSkillActionShowCell.New(UnityEngine.Object.Instantiate(self.SkillActionShowMould))
	end, function(cell)
		cell:Dispose()
	end)

	self.SkillActionMould:SetActive(false)

	self.SkillActionDirCellPool = UIObjectPool.New(10, function()
		return FishingActivitySkillActionDirCell.New(UnityEngine.Object.Instantiate(self.SkillActionMould))
	end, function(cell)
		cell:Dispose()
	end)
end

function m:AddListener()
	self.BtnSkillAction1:GetComponent("Button").onClick:AddListener(self.DelegateSkillAction1)
	self.BtnSkillAction2:GetComponent("Button").onClick:AddListener(self.DelegateSkillAction2)
	self.BtnSkillAction3:GetComponent("Button").onClick:AddListener(self.DelegateSkillAction3)
	self.BtnSkillAction4:GetComponent("Button").onClick:AddListener(self.DelegateSkillAction4)
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateBtnBack)
	self.BtnPut:GetComponent("Button").onClick:AddListener(self.DelegateBtnPut)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
end

function m:RemoveListener()
	self.BtnSkillAction1:GetComponent("Button").onClick:RemoveListener(self.DelegateSkillAction1)
	self.BtnSkillAction2:GetComponent("Button").onClick:RemoveListener(self.DelegateSkillAction2)
	self.BtnSkillAction3:GetComponent("Button").onClick:RemoveListener(self.DelegateSkillAction3)
	self.BtnSkillAction4:GetComponent("Button").onClick:RemoveListener(self.DelegateSkillAction4)
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnBack)
	self.BtnPut:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnPut)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	if not self.Start then
		return
	end

	self.ReleaseSkillPassTime = self.ReleaseSkillPassTime + realElapseSeconds * 1000

	self:RefreshCD()
end

function m:RefreshCD()
	local haveTime = (self.ReleaseSkillCD - self.ReleaseSkillPassTime) / 1000

	if haveTime <= 0 then
		haveTime = 0

		self:CheckResult()
	end

	UGUIUtil.SetText(self.TextEndTime, FishingActivityMainUIApi:GetString("TextEndTime", string.format("%0.1f", haveTime)))
end

function m:UpdateView()
	local UIController = self.View:GetComponentInParent(typeof(UIController))

	for i, v in pairs(self.SkillActionCells) do
		v.View:SetActive(false)
		v.View.transform:SetParent(UIController.transform, false)
		self.SkillActionCellPool:Release(v)
	end

	self.SkillActionCells = {}
	self.SkillActionDataList = FishingActivityModule.fishSkillActionDataList

	table.sort(self.SkillActionDataList, function(a, b)
		return a.cid < b.cid
	end)

	for i = 1, #self.SkillActionDataList do
		local skillActionData = self.SkillActionDataList[i]

		if skillActionData.isUnlock then
			local skillActionCell = self.SkillActionCellPool:Obtain()

			skillActionCell.View:SetActive(true)
			skillActionCell.View.transform:SetParent(self.SkillNode.transform, false)
			skillActionCell:SetData(skillActionData)
			table.insert(self.SkillActionCells, skillActionCell)
		end
	end

	self:RefreshInput()
end

function m:RefreshInput()
	local UIController = self.View:GetComponentInParent(typeof(UIController))

	for i, v in pairs(self.SkillActionDirCells) do
		v.View:SetActive(false)
		v.View.transform:SetParent(UIController.transform, false)
		self.SkillActionDirCellPool:Release(v)
	end

	self.SkillActionDirCells = {}

	for i = 1, #self.PutList do
		local dir = self.PutList[i]
		local dirCell = self.SkillActionDirCellPool:Obtain()

		dirCell.View:SetActive(true)
		dirCell.View.transform:SetParent(self.InputNode.transform, false)
		dirCell:SetData(dir)
		table.insert(self.SkillActionDirCells, dirCell)
	end
end

function m:OnSkillAction1()
	self:AddInput(1)
end

function m:OnSkillAction2()
	self:AddInput(2)
end

function m:OnSkillAction3()
	self:AddInput(3)
end

function m:OnSkillAction4()
	self:AddInput(4)
end

function m:AddInput(num)
	if #self.PutList >= self.MaxInputNum then
		return
	end

	table.insert(self.PutList, num)
	self:RefreshInput()
end

function m:OnBtnBack()
	local len = #self.PutList

	table.remove(self.PutList, len)
	self:RefreshInput()
end

function m:OnBtnPut()
	self:CheckResult()
end

function m:CheckResult()
	local skillActionData = self:CheckInputSkillAction()

	EventDispatcher.Dispatch(EventID.FishingActivityPlaySkillActionEvent, false, skillActionData)
	self:Close()
end

function m:CheckInputSkillAction()
	for i, v in pairs(self.SkillActionDataList) do
		if v.isUnlock and #v:GetCfgLvData().SkillAction == #self.PutList then
			local result = true

			for index = 1, #self.PutList do
				if v:GetCfgLvData().SkillAction[index] ~= self.PutList[index] then
					result = false

					break
				end
			end

			if result then
				return v
			end
		end
	end

	return nil
end

function m:OnBtnClose()
	self:CheckResult()
end

function m:Open()
	EventDispatcher.Dispatch(EventID.FishingActivityPlaySkillActionEvent, true)

	self.PutList = {}
	self.ReleaseSkillPassTime = 0
	self.Start = true

	self.View:SetActive(true)
	self:AddListener()
	self:UpdateView()
end

function m:Close()
	self.Start = false

	self.View:SetActive(false)
	self:RemoveListener()
end

function m:Dispose()
	self:Close()

	for i, v in pairs(self.SkillActionCells) do
		self.SkillActionCellPool:Release(v)
	end

	self.SkillActionCells = {}

	self.SkillActionCellPool:Dispose()

	for i, v in pairs(self.SkillActionDirCells) do
		self.SkillActionDirCellPool:Release(v)
	end

	self.SkillActionDirCells = {}

	self.SkillActionDirCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
