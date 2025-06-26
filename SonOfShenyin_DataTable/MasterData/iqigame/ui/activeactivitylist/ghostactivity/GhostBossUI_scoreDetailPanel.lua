-- chunkname: @IQIGame\\UI\\ActiveActivityList\\GhostActivity\\GhostBossUI_scoreDetailPanel.lua

local GhostBossUI_scoreDetailPanel = {}
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local scoreItemClass = require("IQIGame/UI/ActiveActivityList/GhostActivity/GhostBossUI_scoreDetailPanel_scoreItem")

function GhostBossUI_scoreDetailPanel.New(go, mainView)
	local o = Clone(GhostBossUI_scoreDetailPanel)

	o:Initialize(go, mainView)

	return o
end

function GhostBossUI_scoreDetailPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function GhostBossUI_scoreDetailPanel:InitComponent()
	self.scoreItemPool = UIViewObjectPool.New(self.detailItem, self.Content.transform, function(_view)
		return scoreItemClass.New(_view)
	end)
end

function GhostBossUI_scoreDetailPanel:InitDelegate()
	function self.delegateOnClickCloseBtn()
		self:Hide()
	end
end

function GhostBossUI_scoreDetailPanel:AddListener()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickCloseBtn)
end

function GhostBossUI_scoreDetailPanel:RemoveListener()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCloseBtn)
end

function GhostBossUI_scoreDetailPanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function GhostBossUI_scoreDetailPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function GhostBossUI_scoreDetailPanel:Refresh(Data)
	self.cfgBossStageId = Data

	local cfgBossChapter = CfgUtil.GetCfgBossChapterDataWithID(self.cfgBossStageId)
	local len = #cfgBossChapter.PassedLevelScore

	self.scoreItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	for i = 1, len do
		local tabItem = self.scoreItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		tabItem:Show()
		tabItem:Refresh(cfgBossChapter.PassedLevelScore[i], cfgBossChapter.Id)
	end
end

function GhostBossUI_scoreDetailPanel:OnDestroy()
	self:RemoveListener()
end

return GhostBossUI_scoreDetailPanel
