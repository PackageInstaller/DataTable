-- chunkname: @IQIGame\\UI\\ActiveActivityList\\GhostActivity\\GhostBossUI_scoreDetailPanel_scoreItem.lua

local GhostBossUI_scoreDetailPanel_scoreItem = {}

function GhostBossUI_scoreDetailPanel_scoreItem.New(go, mainView)
	local o = Clone(GhostBossUI_scoreDetailPanel_scoreItem)

	o:Initialize(go, mainView)

	return o
end

function GhostBossUI_scoreDetailPanel_scoreItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function GhostBossUI_scoreDetailPanel_scoreItem:InitComponent()
	return
end

function GhostBossUI_scoreDetailPanel_scoreItem:InitDelegate()
	return
end

function GhostBossUI_scoreDetailPanel_scoreItem:AddListener()
	return
end

function GhostBossUI_scoreDetailPanel_scoreItem:RemoveListener()
	return
end

function GhostBossUI_scoreDetailPanel_scoreItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function GhostBossUI_scoreDetailPanel_scoreItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function GhostBossUI_scoreDetailPanel_scoreItem:Refresh(Data, chapterId)
	self.data = Data
	self.chapterId = chapterId

	LuaUtility.SetText(self.ScoreNum, self.data)
	LuaUtility.SetText(self.ScoreText, BossChapterModule.GetMarkWithScore(self.chapterId, self.data))
end

function GhostBossUI_scoreDetailPanel_scoreItem:OnDestroy()
	return
end

return GhostBossUI_scoreDetailPanel_scoreItem
