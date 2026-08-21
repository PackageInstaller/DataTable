-- chunkname: @IQIGame\\UI\\Activity\\PicturePuzzle\\PicturePuzzleTaskCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(data)
	self.taskData = data

	local cfgTask = CfgMainQuestTable[self.taskData.cid]

	UGUIUtil.SetText(self.goTargetDesc, DailyPicturePuzzleMissionUIApi:GetString("growUpViewTargetDesc", cfgTask.Description, self.taskData.CurrentNum, self.taskData.TargetNum))

	local rewardDatum = {}

	for i, v in ipairs(cfgTask.Reward) do
		if i % 2 ~= 0 and v ~= 1101 and v ~= 1102 then
			rewardDatum[#rewardDatum + 1] = {
				v,
				cfgTask.Reward[i + 1]
			}
		end
	end

	self.Slot:SetActive(#rewardDatum > 0)

	if #rewardDatum > 0 then
		local itemTab = rewardDatum[1]
		local itemID = itemTab[1]
		local itemNum = itemTab[2]

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[itemID].Icon), self.ImgIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.TextNum, itemNum)
	end

	if self.taskData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK then
		if self.taskData.CurrentNum >= self.taskData.TargetNum then
			self.state = 2
		else
			self.state = 1
		end
	else
		self.state = 3
	end

	self.ImgTag:SetActive(self.state == 3)
	UGUIUtil.SetText(self.TextTag, DailyPicturePuzzleMissionUIApi:GetString("TextTag", self.state))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
