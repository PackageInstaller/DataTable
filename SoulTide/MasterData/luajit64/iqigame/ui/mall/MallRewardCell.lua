-- chunkname: @IQIGame\\UI\\Mall\\MallRewardCell.lua

local MallRewardCell = {
	itemCellPool = {}
}

function MallRewardCell.New(go)
	local o = Clone(MallRewardCell)

	o:Initialize(go)

	return o
end

function MallRewardCell:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.tfName = self.goName:GetComponent("Text")
	self.tfProgressCur = self.goProgressCur:GetComponent("Text")
	self.tfProgressTotal = self.goProgressTotal:GetComponent("Text")
	self.imgBar = self.goBar:GetComponent("Image")
	self.btnGet = self.goBtnGet:GetComponent("Button")

	function self.onClickBtnGetDelegate()
		self:OnClickBtnGet()
	end

	self.itemCellPool[1] = ItemCell.PackageOrReuseView(self, self.goItemParent.transform:Find("Item_One/Slot/CommonSlotUI").gameObject)
	self.itemCellPool[2] = ItemCell.PackageOrReuseView(self, self.goItemParent.transform:Find("Item_Two/Slot_01/CommonSlotUI").gameObject)
	self.itemCellPool[3] = ItemCell.PackageOrReuseView(self, self.goItemParent.transform:Find("Item_Two/Slot_02/CommonSlotUI").gameObject)
	self.goTopDesc:GetComponent("Text").text = MallUIApi:GetString("rewardCellTopDesc")
	self.goOverDesc:GetComponent("Text").text = MallUIApi:GetString("rewardCellOverDesc")
	self.goBtnGet.transform:Find("Text"):GetComponent("Text").text = MallUIApi:GetString("rewardCellBtnGetTxt")
	self.goBottomDesc:GetComponent("Text").text = MallUIApi:GetString("rewardCellBottomDesc")

	self:OnAddListener()
end

function MallRewardCell:Refresh(taskData, index, progressIndex)
	self.taskData = taskData
	self.index = index
	self.progressIndex = progressIndex
	self.cfgMainQuestData = CfgMainQuestTable[self.taskData.cid]

	self:RefreshMisc()
	self:RefreshProgressBlock()
	self:RefreshRewardBlock()
end

function MallRewardCell:OnHide()
	return
end

function MallRewardCell:OnDestroy()
	self:OnRemoveListener()

	for i, v in pairs(self.itemCellPool) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function MallRewardCell:OnAddListener()
	self.btnGet.onClick:AddListener(self.onClickBtnGetDelegate)
end

function MallRewardCell:OnRemoveListener()
	self.btnGet.onClick:RemoveListener(self.onClickBtnGetDelegate)
end

function MallRewardCell:OnClickBtnGet()
	TaskModule.SendCommitTaskMsg(self.cfgMainQuestData.Id)
end

function MallRewardCell:RefreshMisc()
	self.tfName.text = MallUIApi:GetString("rewardCellName", self.cfgMainQuestData.Name)

	self.goNormalBlock:SetActive(self.taskData.TaskStatus ~= TaskModule.TaskStatus.FINISH_TASK)
	self.goGettedBlock:SetActive(self.taskData.TaskStatus == TaskModule.TaskStatus.FINISH_TASK)
	self.goBtnGet:SetActive(self.taskData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and self.taskData.CurrentNum >= self.taskData.TargetNum)
end

function MallRewardCell:RefreshProgressBlock()
	self.goProgressBlock:SetActive(self.index == self.progressIndex)

	self.tfProgressCur.text = MallUIApi:GetString("rewardCellProgressCur", self.taskData.CurrentNum)
	self.tfProgressTotal.text = MallUIApi:GetString("rewardCellProgressTotal", self.taskData.TargetNum)
	self.imgBar.fillAmount = self.taskData.CurrentNum / self.taskData.TargetNum
end

function MallRewardCell:RefreshRewardBlock()
	local dataList = {}

	for i, v in ipairs(self.cfgMainQuestData.Reward) do
		if i % 2 ~= 0 then
			dataList[#dataList + 1] = {
				v,
				self.cfgMainQuestData.Reward[i + 1]
			}
		end
	end

	for i, v in ipairs(dataList) do
		self.itemCellPool[i]:SetItemByCID(v[1], v[2])
	end
end

return MallRewardCell
