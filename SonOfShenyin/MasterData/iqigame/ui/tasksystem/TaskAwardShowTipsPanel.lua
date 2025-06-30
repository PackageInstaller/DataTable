-- chunkname: @IQIGame\\UI\\TaskSystem\\TaskAwardShowTipsPanel.lua

local TaskAwardShowTipsPanel = {
	rewardScrollViewCell = {}
}
local taskAwardItem = require("IQIGame.UI.TaskSystem.TaskAwardItem")

function TaskAwardShowTipsPanel.New(go)
	local o = Clone(TaskAwardShowTipsPanel)

	o:Initialize(go)

	return o
end

function TaskAwardShowTipsPanel:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function TaskAwardShowTipsPanel:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	for k, v in pairs(self.awardItemsList) do
		v:Dispose()
	end

	self.buttonMask = nil
	self.awardItemsList = {}
end

function TaskAwardShowTipsPanel:InitComponent()
	self.buttonMask = self.buttonMask:GetComponent("Button")
	self.awardItemsList = {}

	for i = 1, self.awardScroll.transform.childCount do
		local transAward = self.awardScroll.transform:GetChild(i - 1)
		local awardItem = taskAwardItem.New(transAward.gameObject)

		table.insert(self.awardItemsList, awardItem)
	end
end

function TaskAwardShowTipsPanel:InitDelegate()
	function self.buttonMaskDelegate()
		self:Show(false)
	end
end

function TaskAwardShowTipsPanel:AddListener()
	self.buttonMask.onClick:AddListener(self.buttonMaskDelegate)
end

function TaskAwardShowTipsPanel:RemoveListener()
	self.buttonMask.onClick:RemoveListener(self.buttonMaskDelegate)
end

function TaskAwardShowTipsPanel:OnDestroy()
	logError("废弃方法，请改用self:Dispose()")
	self:RemoveListener()
end

function TaskAwardShowTipsPanel:Show(show, data)
	LuaUtility.SetGameObjectShow(self.gameObject, show)

	if show then
		self:Refresh(data)
	end
end

function TaskAwardShowTipsPanel:RefreshAwardScroll()
	for i = 1, getCfgTableLength(self.awardItemsList) do
		self.awardItemsList[i]:Show(false)
	end

	for i = 1, getCfgTableLength(self.data) do
		if i > getCfgTableLength(self.awardItemsList) then
			local awardObject = UnityEngine.Object.Instantiate(self.Sample_AwardItem)

			awardObject.transform:SetParent(self.awardScroll.transform, false)

			local awardItem = taskAwardItem.New(awardObject.gameObject)

			table.insert(self.awardItemsList, awardItem)
		end

		self.awardItemsList[i]:Refresh(self.data[i])
		self.awardItemsList[i]:Show(true)
	end
end

function TaskAwardShowTipsPanel:Refresh(data)
	local ActionParamNormal = UIUtil.GetConfigArr(data.BaseData.ActionParam)
	local ActionParamLengthNormal = #ActionParamNormal
	local itemData = {}

	for i = 1, ActionParamLengthNormal do
		local cid = ActionParamNormal[i][1]
		local number = ActionParamNormal[i][2]

		itemData[i] = {
			ActionParam = ActionParamNormal[i],
			ItemData = ItemData.CreateByCIDAndNumber(cid, number)
		}
	end

	self.data = itemData

	self:RefreshAwardScroll()
end

return TaskAwardShowTipsPanel
