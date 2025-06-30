-- chunkname: @IQIGame\\UI\\MonsterAcademyChallengeDetailUI.lua

local MonsterAcademyChallengeDetailUI = {
	EntityId = 0,
	monsterTowerID = 0,
	monsterAttrCells = {}
}

MonsterAcademyChallengeDetailUI = Base:Extend("MonsterAcademyChallengeDetailUI", "IQIGame.Onigao.UI.MonsterAcademyChallengeDetailUI", MonsterAcademyChallengeDetailUI)

require("IQIGame.UIExternalApi.MonsterAcademyChallengeDetailUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterAcademyPlayerHeadView = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyPlayerHeadView")
local MonsterAcademyMonsterAttrCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyTower.MonsterAcademyMonsterAttrCell")

function MonsterAcademyChallengeDetailUI:OnInit()
	UGUIUtil.SetTextInChildren(self.BtnChallenge, MonsterAcademyChallengeDetailUIApi:GetString("BtnChallengeLabel"))
	UGUIUtil.SetText(self.TextCost, MonsterAcademyChallengeDetailUIApi:GetString("TextCost"))
	UGUIUtil.SetText(self.TitleAttributes, MonsterAcademyChallengeDetailUIApi:GetString("TitleAttributes"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnChallenge()
		self:OnBtnChallenge()
	end

	function self.delegateUpdateTowerEvent()
		self:OnUpdateTowerEvent()
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	self.playerHeadView = MonsterAcademyPlayerHeadView.New(self.PlayerInformation)

	self.AttributeModule:SetActive(false)

	self.monsterAttrPool = UIObjectPool.New(4, function()
		local cell = MonsterAcademyMonsterAttrCell.New(UnityEngine.Object.Instantiate(self.AttributeModule))

		return cell
	end, function(cell)
		cell:Dispose()
	end)
end

function MonsterAcademyChallengeDetailUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyChallengeDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademyChallengeDetailUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyChallengeDetailUI:GetBGM(userData)
	return nil
end

function MonsterAcademyChallengeDetailUI:OnOpen(userData)
	self.monsterTowerID = userData.TowerID
	self.currentLayer = userData.Layer

	self:UpdateView()
end

function MonsterAcademyChallengeDetailUI:OnClose(userData)
	self:HideEntity()
end

function MonsterAcademyChallengeDetailUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnChallenge:GetComponent("Button").onClick:AddListener(self.delegateBtnChallenge)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateTowerEvent, self.delegateUpdateTowerEvent)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function MonsterAcademyChallengeDetailUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnChallenge:GetComponent("Button").onClick:RemoveListener(self.delegateBtnChallenge)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateTowerEvent, self.delegateUpdateTowerEvent)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function MonsterAcademyChallengeDetailUI:OnPause()
	return
end

function MonsterAcademyChallengeDetailUI:OnResume()
	return
end

function MonsterAcademyChallengeDetailUI:OnCover()
	return
end

function MonsterAcademyChallengeDetailUI:OnReveal()
	return
end

function MonsterAcademyChallengeDetailUI:OnRefocus(userData)
	return
end

function MonsterAcademyChallengeDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademyChallengeDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyChallengeDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyChallengeDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyChallengeDetailUI:OnDestroy()
	self.playerHeadView:Dispose()

	for i, v in pairs(self.monsterAttrCells) do
		self.monsterAttrPool:Release(v)
	end

	self.monsterAttrCells = {}

	self.monsterAttrPool:Dispose()
end

function MonsterAcademyChallengeDetailUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function MonsterAcademyChallengeDetailUI:UpdateView()
	self.playerHeadView:UpdateView()
	UGUIUtil.SetText(self.TextLayer, MonsterAcademyChallengeDetailUIApi:GetString("TextLayer", self.currentLayer))

	local cfgMonsterTower = CfgGalgameMonstertowerTable[self.monsterTowerID]

	self.cfgMonsterMonster = CfgGalgameMonsterMonsterTable[cfgMonsterTower.Monster]

	UGUIUtil.SetText(self.TextMonsterName, self.cfgMonsterMonster.Name)

	if #cfgMonsterTower.Cost > 1 then
		local spend = cfgMonsterTower.Cost[2]
		local name = CfgGalgameMonsterItemTable[cfgMonsterTower.Cost[1]].Name

		UGUIUtil.SetText(self.TextCostValue, MonsterAcademyChallengeDetailUIApi:GetString("TextCostValue", name, spend))
		self.TextCost:SetActive(true)
	else
		UGUIUtil.SetText(self.TextCostValue, "")
		self.TextCost:SetActive(false)
	end

	self:ShowMonster(self.cfgMonsterMonster.EntityID)

	for i, v in pairs(self.monsterAttrCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.monsterAttrPool:Release(v)
	end

	self.monsterAttrCells = {}

	for i = 1, #self.cfgMonsterMonster.AttributeType do
		local attributeID = self.cfgMonsterMonster.AttributeType[i]
		local value = self.cfgMonsterMonster.AttributeValue[i]

		if value == nil then
			value = 0
		end

		local cell = self.monsterAttrPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.AttributeView.transform, false)
		cell:SetData(attributeID, value)
		table.insert(self.monsterAttrCells, cell)
	end
end

function MonsterAcademyChallengeDetailUI:ShowMonster(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.ImgMonster.transform, Vector3.zero)
end

function MonsterAcademyChallengeDetailUI:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function MonsterAcademyChallengeDetailUI:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = Vector3(self.cfgMonsterMonster.EntityScale[1], self.cfgMonsterMonster.EntityScale[2], self.cfgMonsterMonster.EntityScale[3])
		args.Entity.gameObject.transform.localPosition = Vector3(self.cfgMonsterMonster.EntityPosition[1], self.cfgMonsterMonster.EntityPosition[2], self.cfgMonsterMonster.EntityPosition[3])

		local SpineRenderers = args.Entity.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))
		local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			animation.state:SetAnimation(0, "idle", true)
		end

		if SpineRenderers ~= nil then
			local canvas = self.UIController:GetComponent("Canvas")

			for i = 0, SpineRenderers.Length - 1 do
				SpineRenderers[i].sortingOrder = canvas.sortingOrder + 1
			end
		end

		setGameObjectLayers(args.Entity.gameObject.transform, "UI")
	end
end

function MonsterAcademyChallengeDetailUI:OnUpdateTowerEvent()
	if self.monsterTowerID > 0 then
		self:UpdateView()
	end
end

function MonsterAcademyChallengeDetailUI:OnBtnChallenge()
	local cfgMonsterTower = CfgGalgameMonstertowerTable[self.monsterTowerID]

	if #cfgMonsterTower.Cost > 1 then
		local have = MonsterAcademyModule.GetItemNum(cfgMonsterTower.Cost[1])

		if have < cfgMonsterTower.Cost[2] then
			NoticeModule.ShowNotice(21045053)

			return
		end
	end

	MonsterAcademyModule.TowerFight(self.monsterTowerID)
end

return MonsterAcademyChallengeDetailUI
