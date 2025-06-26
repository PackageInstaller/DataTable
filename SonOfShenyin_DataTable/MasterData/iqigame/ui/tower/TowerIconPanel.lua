-- chunkname: @IQIGame\\UI\\Tower\\TowerIconPanel.lua

local TowerIconPanel = {}

function TowerIconPanel.New(gameObjectTemplate, parentTransform, towerID)
	local tbl = Clone(TowerIconPanel)
	local obj = TowerIconPanel.Instantiate(gameObjectTemplate, parentTransform)

	tbl.towerID = towerID
	tbl.towerName = CfgTowerChapterTable[towerID].Name

	tbl:OnInit(obj)

	return tbl
end

function TowerIconPanel.Instantiate(gameObjectTemplate, parentTransform)
	local gameObject = UnityEngine.GameObject.Instantiate(gameObjectTemplate, parentTransform)

	gameObject:SetActive(true)

	return gameObject
end

function TowerIconPanel:OnInit(gameObject)
	self.gameObject = gameObject

	LuaCodeInterface.BindOutlet(gameObject, self)

	function self.delegateOnClickOpenTowerDetailButton()
		self:OnClickOpenTowerDetailButton()
	end

	self:OnAddListeners()
end

function TowerIconPanel:OnOpen(userData)
	self.gameObject:SetActive(true)
	self:Refresh()
end

function TowerIconPanel:OnClose(userData)
	self.gameObject:SetActive(false)
end

function TowerIconPanel:Refresh()
	UGUIUtil.SetText(self.NameText, CfgTowerChapterTable[self.towerID].Name)

	if ConditionModule.Check(CfgTowerChapterTable[self.towerID].UnlockConditionId) then
		local lowerNotPassStage = TowerChapterModule.GetTowerLowestNotPassedStage(self.towerID)

		if getTableLength(lowerNotPassStage) == 0 then
			UGUIUtil.SetText(self.CurrentLevelText, ClimbTowerApi:GetAllLevelPassedTips())
		else
			UGUIUtil.SetText(self.CurrentLevelText, ClimbTowerApi:GetLowestNotPassedLevelTips(lowerNotPassStage.Level))
		end

		UGUIUtil.SetText(self.MaxLevelText, TowerChapterModule.GetTowerHighestStage(self.towerID).Level)
		self.UnlockedBgImage:SetActive(true)
		self.LockedBgImage:SetActive(false)
	else
		UGUIUtil.SetText(self.CurrentLevelText, self:UnlockConditionTips(self.towerID))
		self.UnlockedBgImage:SetActive(false)
		self.LockedBgImage:SetActive(true)
	end
end

function TowerIconPanel:UnlockConditionTips(towerID)
	return CfgConditionTable[CfgTowerChapterTable[towerID].UnlockConditionId].Name
end

function TowerIconPanel:Dispose()
	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function TowerIconPanel:OnAddListeners()
	self.gameObject:GetComponent("Button").onClick:AddListener(self.delegateOnClickOpenTowerDetailButton)
end

function TowerIconPanel:OnRemoveListeners()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickOpenTowerDetailButton)
end

function TowerIconPanel:OnClickOpenTowerDetailButton()
	logDebug("TowerIconPanel:OnClickOpenTowerDetailButton() self.towerID=" .. self.towerID)
	EventDispatcher.Dispatch(EventID.OpenTowerDetailEvent, self.towerID)
end

return TowerIconPanel
