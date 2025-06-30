-- chunkname: @IQIGame\\UI\\Activity\\Sign\\SignCell.lua

local SignCell = {}

function SignCell.New(view)
	local obj = Clone(SignCell)

	obj:Init(view)

	return obj
end

function SignCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.imgDay = self.goDay:GetComponent("Image")
	self.icon = self.goIcon:GetComponent("Image")
	self.tfCountWhite = self.goCountWhite:GetComponent("Text")
	self.tfCountBlack = self.goCountBlack:GetComponent("Text")
	self.btnGet = self.goBtnGet:GetComponent("Button")

	function self.onClickBtnGetDelegate()
		self:OnClickBtnGet()
	end

	if self.goEffect then
		self.goEffect:SetActive(false)
	end
end

function SignCell:Refresh(day, taskData)
	self.day = day
	self.taskData = taskData
	self.cfgQuestData = CfgMainQuestTable[self.taskData.cid]

	self:RefreshMisc()
	self:RefreshState()
	self:OnAddListener()
end

function SignCell:OnHide()
	self:OnRemoveListener()
end

function SignCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function SignCell:OnAddListener()
	self:OnRemoveListener()
	self.btnGet.onClick:AddListener(self.onClickBtnGetDelegate)
end

function SignCell:OnRemoveListener()
	self.btnGet.onClick:RemoveListener(self.onClickBtnGetDelegate)
end

function SignCell:OnClickBtnGet()
	if self.taskData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and self.taskData.CurrentNum >= self.taskData.TargetNum then
		ActivitySignModule.GetReward(self.taskData.cid)
	else
		ItemModule.OpenTipByData(CfgItemTable[self.cfgQuestData.Reward[1]], true)
	end
end

function SignCell:RefreshMisc()
	local cfgItemData = CfgItemTable[self.cfgQuestData.Reward[1]]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.icon)
	AssetUtil.LoadImage(self, ActivityUIApi:GetString("signViewDayPath", self.day), self.imgDay)

	if self.goTextNum then
		UGUIUtil.SetText(self.goTextNum, self.day)
	end

	self.tfCountWhite.text = ActivityUIApi:GetString("signViewCount", self.cfgQuestData.Reward[2])
	self.tfCountBlack.text = self.tfCountWhite.text
end

function SignCell:RefreshState()
	local isGot = self.taskData.TaskStatus == TaskModule.TaskStatus.FINISH_TASK
	local isGetting = self.taskData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and self.taskData.CurrentNum >= self.taskData.TargetNum
	local isNot = self.taskData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and self.taskData.CurrentNum < self.taskData.TargetNum

	self.goSignGot:SetActive(isGot)
	self.goCountWhite:SetActive(isGetting)
	self.goCountBlack:SetActive(not isGetting)
	self.goBgNot:SetActive(isNot)
	self.goBgGot:SetActive(isGot)
	self.goBgGetting:SetActive(isGetting)
end

function SignCell:SetParent(transParent)
	self.View.transform:SetParent(transParent, false)
end

function SignCell:PlayGetRewardEffect()
	if self.goEffect then
		self.goEffect:SetActive(false)
		self.goEffect:SetActive(true)

		local timer = Timer.New(function()
			self.goEffect:SetActive(false)
		end, 1)

		timer:Start()
	end
end

return SignCell
