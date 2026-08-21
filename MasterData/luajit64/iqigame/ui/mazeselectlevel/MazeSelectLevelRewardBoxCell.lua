-- chunkname: @IQIGame\\UI\\MazeSelectLevel\\MazeSelectLevelRewardBoxCell.lua

local m = {}

function m.New(go)
	local o = Clone(m)

	o:Initialize(go)

	return o
end

function m:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.goView = go

	function self.DelegateOnClickBtnGet()
		self:OnClickBtnGet()
	end

	self.goView:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnGet)

	self.Boxes = {}
	self.Effects = {}

	for i = 1, 3 do
		local boxGo = self["Box" .. i]
		local effectGo = self["Effect" .. i]

		if boxGo ~= nil then
			self.Boxes[i] = boxGo
			self.Effects[i] = effectGo
		end
	end
end

function m:RefreshView(taskUIData, maxTargetNum, index)
	self.data = taskUIData
	self.cfgTaskData = CfgMainQuestTable[self.data.cid]

	local type = MazeSelectLevelUIApi:GetString("RewardBoxType", index)

	if type > #self.Boxes then
		type = #self.Boxes
	end

	for i = 1, #self.Boxes do
		self.Boxes[i]:SetActive(i == type)
	end

	local currentBoxView = self.Boxes[type]

	self.goImgOpen = currentBoxView.transform:Find("Image_Open").gameObject
	self.goImgClose = currentBoxView.transform:Find("Image_Close").gameObject

	if self.goValue ~= nil then
		UGUIUtil.SetText(self.goValue, MazeSelectLevelUIApi:GetString("RewardBoxValue", self.data.TargetNum, maxTargetNum))
	end

	if self.data.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK then
		self:SetIsOpen(false)

		if self.data.CurrentNum >= self.data.TargetNum then
			self.state = 2
		else
			self.state = 3
		end
	elseif self.data.TaskStatus == TaskModule.TaskStatus.FINISH_TASK then
		self.state = 1

		self:SetIsOpen(true)
	end

	for i = 1, #self.Effects do
		self.Effects[i]:SetActive(i == type and self.state == 2)
	end
end

function m:OnDestroy()
	self.goView:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnGet)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

function m:SetIsOpen(isOpen)
	self.goImgClose:SetActive(not isOpen)
	self.goImgOpen:SetActive(isOpen)
end

function m:OnClickBtnGet()
	local rewards = {}

	for i, v in ipairs(self.cfgTaskData.Reward) do
		if i % 2 ~= 0 then
			rewards[#rewards + 1] = {
				id = v,
				num = self.cfgTaskData.Reward[i + 1]
			}
		end
	end

	UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
		Rewards = rewards,
		State = self.state,
		GetCallback = function()
			TaskModule.SendCommitTaskMsg(self.cfgTaskData.Id)
		end
	})
end

return m
