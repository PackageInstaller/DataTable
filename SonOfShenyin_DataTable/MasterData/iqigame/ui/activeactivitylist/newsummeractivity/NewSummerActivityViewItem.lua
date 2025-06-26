-- chunkname: @IQIGame\\UI\\ActiveActivityList\\NewSummerActivity\\NewSummerActivityViewItem.lua

local RewardItemCell = {}

function RewardItemCell.New(view)
	local o = Clone(RewardItemCell)

	o:Initialize(view)

	return o
end

function RewardItemCell:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go

	function self.DelegateOnClickRewarItem()
		self:OnClickRewarItem()
	end

	self:AddListener()
end

function RewardItemCell:AddListener()
	self.rewardItemImg:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRewarItem)
end

function RewardItemCell:RemoveListener()
	self.rewardItemImg:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRewarItem)
end

function RewardItemCell:SetData(itemCid, itemNum, taskSystemData)
	self:Show()

	self.itemCid = itemCid
	self.itemNum = itemNum

	local itemCfg = CfgUtil.GetItemCfgDataWithID(itemCid)

	self.taskPod = taskSystemData

	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(itemCfg.Icon), self.rewardItemImg:GetComponent("Image"))
	LuaUtility.SetText(self.rewardNumText, itemNum)
	LuaUtility.SetGameObjectShow(self.receivedImg, self.taskPod.status == Constant.TaskStatus.hadGot)
	LuaUtility.SetGameObjectShow(self.canGetImg, self.taskPod.status == Constant.TaskStatus.hasDone)
end

function RewardItemCell:OnClickRewarItem()
	if self.taskPod.status == Constant.TaskStatus.hadGot or self.taskPod.status == Constant.TaskStatus.doing then
		local itemData = ItemData.CreateByCIDAndNumber(self.itemCid, self.itemNum)

		ItemModule.OpenTipByData(itemData, true, false)
	end
end

function RewardItemCell:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function RewardItemCell:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function RewardItemCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

local ItemCell = {}

function ItemCell.New(view)
	local obj = Clone(ItemCell)

	obj:Init(view)

	return obj
end

function ItemCell:Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.rewardItems = {}

	table.insert(self.rewardItems, RewardItemCell.New(self.item1))
	table.insert(self.rewardItems, RewardItemCell.New(self.item2))
	self.gameObject.gameObject:SetActive(true)

	function self.canGetImgBtnDelegate()
		self:canGetImgBtnClick()
	end

	self.gameObject:GetComponent("Button").onClick:AddListener(self.canGetImgBtnDelegate)
end

function ItemCell:SetData(taskSystemData)
	self.taskData = taskSystemData

	local _itemIndex = 1

	ForArrayCustomStep(taskSystemData.BaseData.ActionParam, function(_index, _itemCid)
		local itemCnt = taskSystemData.BaseData.ActionParam[_index + 1]
		local itemCell = self.rewardItems[_itemIndex]

		if itemCell == nil then
			return true
		end

		itemCell:SetData(_itemCid, itemCnt, taskSystemData)

		_itemIndex = _itemIndex + 1
	end, 2)

	if taskSystemData.status == Constant.TaskStatus.doing then
		LuaUtility.SetGameObjectShow(self.receivedParent, false)
		LuaUtility.SetGameObjectShow(self.nofinishParent, true)
		LuaUtility.SetGameObjectShow(self.canGetParent, false)
	elseif taskSystemData.status == Constant.TaskStatus.hadGot then
		LuaUtility.SetGameObjectShow(self.receivedParent, true)
		LuaUtility.SetGameObjectShow(self.nofinishParent, false)
		LuaUtility.SetGameObjectShow(self.canGetParent, false)
	elseif taskSystemData.status == Constant.TaskStatus.hasDone then
		LuaUtility.SetGameObjectShow(self.receivedParent, false)
		LuaUtility.SetGameObjectShow(self.nofinishParent, false)
		LuaUtility.SetGameObjectShow(self.canGetParent, true)
	end
end

function ItemCell:canGetImgBtnClick()
	if self.taskData.status == Constant.TaskStatus.hadGot then
		return
	end

	if self.taskData.status == Constant.TaskStatus.doing then
		NoticeModule.ShowNotice(54000)

		return
	end

	TaskSystemModule.SubmitTask({
		self.taskData.cid
	})
end

function ItemCell:Dispose()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.canGetImgBtnDelegate)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return ItemCell
