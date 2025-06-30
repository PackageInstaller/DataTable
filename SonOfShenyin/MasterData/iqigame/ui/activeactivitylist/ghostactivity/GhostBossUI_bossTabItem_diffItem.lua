-- chunkname: @IQIGame\\UI\\ActiveActivityList\\GhostActivity\\GhostBossUI_bossTabItem_diffItem.lua

local GhostBossUI_bossTabItem_diffItem = {}

function GhostBossUI_bossTabItem_diffItem.New(go, mainView)
	local o = Clone(GhostBossUI_bossTabItem_diffItem)

	o:Initialize(go, mainView)

	return o
end

function GhostBossUI_bossTabItem_diffItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function GhostBossUI_bossTabItem_diffItem:InitComponent()
	return
end

function GhostBossUI_bossTabItem_diffItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function GhostBossUI_bossTabItem_diffItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function GhostBossUI_bossTabItem_diffItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function GhostBossUI_bossTabItem_diffItem:OnClickButtonClick()
	if not self.isUnLock then
		return
	end

	EventDispatcher.Dispatch(EventID.GhostActivity_OnBossItemSelectEvent, self)
end

function GhostBossUI_bossTabItem_diffItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function GhostBossUI_bossTabItem_diffItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function GhostBossUI_bossTabItem_diffItem:Selected()
	LuaUtility.SetGameObjectShow(self.Select, true)
	LuaUtility.SetGameObjectShow(self.UnSelect, false)
end

function GhostBossUI_bossTabItem_diffItem:UnSelected()
	LuaUtility.SetGameObjectShow(self.Select, false)
	LuaUtility.SetGameObjectShow(self.UnSelect, true)
end

function GhostBossUI_bossTabItem_diffItem:Refresh(Data, chapterData, index)
	self.data = Data
	self.index = index
	self.chapterData = chapterData
	self.isUnLock = ConditionModule.CheckConditionIsAllPass(self.data.UnlockConditionId)

	LuaUtility.SetGameObjectShow(self.lockRoot, not self.isUnLock)
	LuaUtility.SetText(self.selectSubActivityName, self.data.Name)
	LuaUtility.SetText(self.unSelectSubActivityName, self.data.Name)
	self:UnSelected()
end

function GhostBossUI_bossTabItem_diffItem:GetChapterData()
	return self.chapterData
end

function GhostBossUI_bossTabItem_diffItem:GetCfgBossStageData()
	return self.data
end

function GhostBossUI_bossTabItem_diffItem:OnDestroy()
	return
end

return GhostBossUI_bossTabItem_diffItem
