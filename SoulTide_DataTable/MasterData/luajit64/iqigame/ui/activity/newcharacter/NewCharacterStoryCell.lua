-- chunkname: @IQIGame\\UI\\Activity\\NewCharacter\\NewCharacterStoryCell.lua

local m = {
	numImg = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.numImg = {}

	for i = 0, self.SortChapter.transform.childCount - 1 do
		self.numImg[i + 1] = self.SortChapter.transform:GetChild(i).gameObject
	end

	UGUIUtil.SetText(self.TextStr1, ActivityNewDollStoryUIApi:GetString("TextStr1"))
	UGUIUtil.SetText(self.TextStr2, ActivityNewDollStoryUIApi:GetString("TextStr2"))

	function self.delegateBtnBox()
		self:OnBtnBox()
	end

	function self.delegateBtnSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnBox:GetComponent("Button").onClick:AddListener(self.delegateBtnBox)
	self.View:GetComponent("Button").onClick:AddListener(self.delegateBtnSelf)
end

function m:RemoveListener()
	self.BtnBox:GetComponent("Button").onClick:RemoveListener(self.delegateBtnBox)
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSelf)
end

function m:SetData(operateEventID, cfgData)
	self.operateEventID = operateEventID
	self.cfgStoryData = cfgData

	self:UpdateView()
end

function m:UpdateView()
	local path = UIGlobalApi.GetHarmoniousImagePath(self.cfgStoryData.CoverImage)

	AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.TextNum, self.cfgStoryData.Chapter)
	UGUIUtil.SetText(self.TextName, self.cfgStoryData.Name)

	self.state = ActiveNewCharacterModule.CheckNewCharacterStoryState(self.operateEventID, self.cfgStoryData.Id)

	if self.state == 3 then
		UGUIUtil.SetText(self.TextCondition, ActivityNewDollStoryUIApi:GetString("TextConditionScore", self.cfgStoryData.UnlockNeedScore))
	elseif self.state == 4 then
		UGUIUtil.SetText(self.TextCondition, ActivityNewDollStoryUIApi:GetString("TextConditionBefore"))
	elseif self.state == 2 then
		UGUIUtil.SetText(self.TextCondition, ActivityNewDollStoryUIApi:GetString("TextCondition"))
	end

	self.Condition:SetActive(self.state ~= 1)
	self.ImgCondition1:SetActive(self.state == 3 or self.state == 4)
	self.ImgCondition2:SetActive(self.state == 2)
	self.ImgState1:SetActive(self.state == 3 or self.state == 4)
	self.ImgState2:SetActive(self.state == 1)
	self.ImgState3:SetActive(self.state == 2)
	self.RedPoint:SetActive(self.state == 2)
	self.Locked:SetActive(self.state == 3 or self.state == 4)
	self:ShowNum()
end

function m:ShowNum()
	local numString = tostring(self.cfgStoryData.Chapter)
	local reverseLvString = string.reverse(numString)
	local index = 1

	for i = #self.numImg, 1, -1 do
		local numImgObj = self.numImg[i]
		local str = string.sub(reverseLvString, index, index)

		if str ~= "" then
			numImgObj:SetActive(true)
			AssetUtil.LoadImage(self, ActivityNewDollStoryUIApi:GetString("ImgChapterPath", tonumber(str)), numImgObj:GetComponent("Image"))
		else
			numImgObj:SetActive(false)
		end

		index = index + 1
	end
end

function m:OnBtnBox()
	local rewards = {}

	for i = 1, #self.cfgStoryData.ChapterReward, 2 do
		local rewardId = self.cfgStoryData.ChapterReward[i]
		local rewardNum = self.cfgStoryData.ChapterReward[i + 1]

		table.insert(rewards, {
			id = rewardId,
			num = rewardNum
		})
	end

	local state = self.state

	if state > 3 then
		state = 3
	end

	UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
		Rewards = rewards,
		State = state,
		GetCallback = function()
			self:CharacterStory(self.operateEventID, self.cfgStoryData.Id, self.state)
		end
	})
end

function m:OnBtnSelf()
	self:CharacterStory(self.operateEventID, self.cfgStoryData.Id, self.state)
end

function m:CharacterStory(operateEventID, storyId, state)
	if state == 3 then
		NoticeModule.ShowNotice(21045032)

		return
	end

	if state == 4 then
		NoticeModule.ShowNotice(21045033)

		return
	end

	if state == 1 then
		NoticeModule.ShowNotice(21040114, function()
			local cfg = CfgNewCharacterStoryTable[storyId]

			DialogModule.OpenDialog(cfg.ChapterDialog, false, false)
		end, nil, self)
	elseif state == 2 then
		ActiveNewCharacterModule.NewCharacterStory(operateEventID, storyId)
	end
end

function m:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
