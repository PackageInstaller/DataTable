-- chunkname: @IQIGame\\UI\\Library\\LibraryRewardCell.lua

local LibraryRewardCell = {}

function LibraryRewardCell:AddListener()
	self.btnGetReward1.onClick:AddListener(self.delegateBtnGetReward1)
	self.btnGetReward2.onClick:AddListener(self.delegateBtnGetReward2)
	self.btnGetReward3.onClick:AddListener(self.delegateBtnGetReward3)
end

function LibraryRewardCell:RemoveListener()
	self.btnGetReward1.onClick:RemoveListener(self.delegateBtnGetReward1)
	self.btnGetReward2.onClick:RemoveListener(self.delegateBtnGetReward2)
	self.btnGetReward3.onClick:RemoveListener(self.delegateBtnGetReward3)
end

function LibraryRewardCell.New(view, root)
	local obj = Clone(LibraryRewardCell)

	obj:Init(view, root)

	return obj
end

function LibraryRewardCell:Init(view, root)
	self.View = view
	self.rootUI = root

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextBtn1, LibraryRewardUIApi:GetString("TextBtn1"))
	UGUIUtil.SetText(self.TextBtn2, LibraryRewardUIApi:GetString("TextBtn2"))
	UGUIUtil.SetText(self.TextBtn3, LibraryRewardUIApi:GetString("TextBtn3"))

	self.btnGetReward1 = self.BtnGetReward1:GetComponent("Button")
	self.btnGetReward2 = self.BtnGetReward2:GetComponent("Button")
	self.btnGetReward3 = self.BtnGetReward3:GetComponent("Button")

	function self.delegateBtnGetReward1()
		self:OnBtnGetReward1()
	end

	function self.delegateBtnGetReward2()
		self:OnBtnGetReward2()
	end

	function self.delegateBtnGetReward3()
		self:OnBtnGetReward3()
	end

	self:AddListener()
end

function LibraryRewardCell:SetData(data)
	self.taskData = data

	self:UpdateView()
end

function LibraryRewardCell:UpdateView()
	if self.taskData then
		UGUIUtil.SetText(self.TextCondition, LibraryRewardUIApi:GetString("TextCondition", self.taskData.TargetNum, self.taskData.CurrentNum >= self.taskData.TargetNum))

		local rewardObj = self.Grid.transform:GetChild(0).gameObject

		rewardObj:SetActive(false)

		for i = 1, self.Grid.transform.childCount - 1 do
			local obj = self.Grid.transform:GetChild(i).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		local cfgMainQuest = CfgMainQuestTable[self.taskData.cid]

		for i = 1, #cfgMainQuest.Reward, 2 do
			local itemID = cfgMainQuest.Reward[i]
			local num = cfgMainQuest.Reward[i + 1]
			local itemData = CfgItemTable[itemID]
			local itemObj = UnityEngine.Object.Instantiate(rewardObj)

			itemObj.transform:SetParent(self.Grid.transform, false)
			itemObj:SetActive(true)

			local itemCell = ItemCell.PackageOrReuseView(self, itemObj)

			itemCell:SetItem(itemData)
			itemCell:SetNum(num)
		end

		self.BtnGetReward1:SetActive(false)
		self.BtnGetReward2:SetActive(false)
		self.BtnGetReward3:SetActive(false)

		if self.taskData.TaskStatus == TaskModule.TaskStatus.FINISH_TASK then
			self.BtnGetReward1:SetActive(true)
		elseif self.taskData.CurrentNum >= self.taskData.TargetNum then
			self.BtnGetReward2:SetActive(true)
		else
			self.BtnGetReward3:SetActive(true)
		end
	end
end

function LibraryRewardCell:OnBtnGetReward1()
	return
end

function LibraryRewardCell:OnBtnGetReward2()
	self.rootUI.isGetReward = true

	TaskModule.SendCommitTaskMsg(self.taskData.cid)
end

function LibraryRewardCell:OnBtnGetReward3()
	NoticeModule.ShowNotice(21040129)
end

function LibraryRewardCell:Clear()
	self.View:SetActive(false)
end

function LibraryRewardCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibraryRewardCell
