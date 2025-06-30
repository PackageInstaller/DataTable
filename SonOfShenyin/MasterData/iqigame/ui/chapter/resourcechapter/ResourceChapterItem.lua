-- chunkname: @IQIGame\\UI\\Chapter\\ResourceChapter\\ResourceChapterItem.lua

local m = {
	isUnLock = false
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateEnterBtnClick()
		self:OnEnterBtnClick()
	end

	self.MainItemCell = ItemCell.New(self.MainRewardSlot, true, false)
	self.AddedItemCell = ItemCell.New(self.AddedRewardSlot, true, false)

	UGUIUtil.SetText(self.MainRewardTitle, ChapterUIApi:GetRewardTitle(1))
	UGUIUtil.SetText(self.AddedRewardTitle, ChapterUIApi:GetRewardTitle(2))
	UGUIUtil.SetText(self.RewardTitle, ChapterUIApi:GetRewardTitle(2))
	UGUIUtil.SetText(self.OpenTitleText, ChapterUIApi:GetOpenTitle())
	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateEnterBtnClick)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateEnterBtnClick)
end

function m:SetData(data)
	self.data = data
	self.dataCfg = data:GetCfg()

	UGUIUtil.SetText(self.ChapterNameText, self.dataCfg.Name)
	UGUIUtil.SetText(self.OpenTimeText, ActivityModule.GetActivityDesc(self.dataCfg.ActivityId))

	local itemdata = ItemData.CreateByCIDAndNumber(CfgDropLibTable[self.dataCfg.StageReward[1]].DropShowItem[1], 0)

	self.MainItemCell:SetItem(itemdata)
	LuaUtility.SetGameObjectShow(self.AddedReward, false)
	self:RefreshUnLockState()
end

function m:RefreshUnLockState()
	self.isUnLock = ConditionModule.Check(self.dataCfg.UnlockConditionId)

	self.Unlock:SetActive(self.isUnLock)
	self.Lock:SetActive(not self.isUnLock)

	if not self.isUnLock then
		UGUIUtil.SetText(self.UnlockConditionText, CfgConditionTable[self.dataCfg.UnlockConditionId].Name)
	else
		self.NoOpen:SetActive(not ActivityModule.IsOpenByTime(self.dataCfg.ActivityId))
		self.RewardInfoParent:SetActive(ActivityModule.IsOpenByTime(self.dataCfg.ActivityId))
	end
end

function m:LoadImg(path, obj)
	AssetUtil.LoadImage(self, path, obj:GetComponent("Image"))
end

function m:OnEnterBtnClick()
	if not self.isUnLock then
		NoticeModule.ShowNotice(49005)

		return
	end

	if not ActivityModule.IsOpenByTime(self.dataCfg.ActivityId) then
		NoticeModule.ShowNotice(51012)

		return
	end

	UIModule.Open(Constant.UIControllerName.GameLevelUI, Constant.UILayer.UI, self.data.passStatus)
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
