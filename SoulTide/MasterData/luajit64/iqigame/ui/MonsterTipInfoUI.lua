-- chunkname: @IQIGame\\UI\\MonsterTipInfoUI.lua

local MonsterTipInfoUI = Base:Extend("MonsterTipInfoUI", "IQIGame.Onigao.UI.MonsterTipInfoUI", {
	sortingOrder = 0,
	EntityId = 0,
	MonsterWeakCells = {},
	BuffItems = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local LibraryMonsterWeakCell = require("IQIGame.UI.Library.LibraryMonsterWeakCell")
local BattleMonsterInfoBuffItem = require("IQIGame.UI.BattleMonsterInfo.BattleMonsterInfoBuffItem")

function MonsterTipInfoUI:OnInit()
	UGUIUtil.SetText(self.TextMonsterTitle1, LibraryMazeUIApi:GetString("TextMonsterTitle1", false))
	UGUIUtil.SetText(self.TextMonsterTitleEng1, LibraryMazeUIApi:GetString("TextMonsterTitle1", true))
	UGUIUtil.SetText(self.TextMonsterTitle2, LibraryMazeUIApi:GetString("TextMonsterTitle2", false))
	UGUIUtil.SetText(self.TextMonsterTitleEng2, LibraryMazeUIApi:GetString("TextMonsterTitle2", true))
	UGUIUtil.SetText(self.TextMonsterTitle3, LibraryMazeUIApi:GetString("TextMonsterTitle3", false))
	UGUIUtil.SetText(self.TextMonsterTitleEng3, LibraryMazeUIApi:GetString("TextMonsterTitle3", true))
	UGUIUtil.SetText(self.TextTitle, LibraryUIApi:GetString("TextTitle", false))
	UGUIUtil.SetText(self.TextTitleEng, LibraryUIApi:GetString("TextTitle", true))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	self.MonsterWeakPool = UIObjectPool.New(5, function()
		local cell = LibraryMonsterWeakCell.New(UnityEngine.Object.Instantiate(self.MouldWeak))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	for i = 1, 8 do
		local view = UnityEngine.Object.Instantiate(self.BuffItemPrefab)

		view.transform:SetParent(self.TextGrid.transform, false)

		local item = BattleMonsterInfoBuffItem.New(view)

		self.BuffItems[i] = item
	end
end

function MonsterTipInfoUI:GetPreloadAssetPaths()
	return nil
end

function MonsterTipInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterTipInfoUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterTipInfoUI:GetBGM(userData)
	return nil
end

function MonsterTipInfoUI:OnOpen(userData)
	self.monsterID = userData

	self:UpDateView()
end

function MonsterTipInfoUI:OnClose(userData)
	self:HideEntity()
end

function MonsterTipInfoUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function MonsterTipInfoUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function MonsterTipInfoUI:OnPause()
	return
end

function MonsterTipInfoUI:OnResume()
	return
end

function MonsterTipInfoUI:OnCover()
	return
end

function MonsterTipInfoUI:OnReveal()
	return
end

function MonsterTipInfoUI:OnRefocus(userData)
	return
end

function MonsterTipInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterTipInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	local canvas = self.UIController.gameObject:GetComponent("Canvas")

	self.sortingOrder = canvas.sortingOrder + 1
end

function MonsterTipInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterTipInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterTipInfoUI:OnDestroy()
	for i, v in pairs(self.MonsterWeakCells) do
		self.MonsterWeakPool:Release(v)
	end

	self.MonsterWeakCells = {}

	self.MonsterWeakPool:Dispose()

	for i = 1, #self.BuffItems do
		local item = self.BuffItems[i]

		item:Dispose()
	end

	self.BuffItems = nil
end

function MonsterTipInfoUI:UpDateView()
	self.InfoView:SetActive(false)
	self.InfoView:SetActive(true)

	if self.monsterID > 0 then
		local cfgMonster = CfgMonsterTable[self.monsterID]

		self.cfgMonsterRes = CfgTownMonsterBookResTable[cfgMonster.ArchivesID]

		if self.cfgMonsterRes then
			UGUIUtil.SetText(self.TextNpcName, self.cfgMonsterRes.TabName)
			UGUIUtil.SetText(self.Text1, self.cfgMonsterRes.MonsterDescribe)
			self:ShowMonster(self.cfgMonsterRes.EntityID)

			local buffCidStacks = self.cfgMonsterRes.MonsterInitialBuff
			local resistantBuffs = BattleMonsterInfoUIApi:GetString("ResistantBuffs")
			local existingResistantBuffs = {}

			for i = 1, #buffCidStacks, 2 do
				local buffData = {
					CID = buffCidStacks[i],
					Stack = buffCidStacks[i + 1]
				}

				if table.indexOf(resistantBuffs, buffData.CID) ~= -1 then
					table.insert(existingResistantBuffs, buffData)
				end
			end

			table.sort(existingResistantBuffs, function(buffData1, buffData2)
				return buffData1.CID < buffData2.CID
			end)

			for i = 1, #self.BuffItems do
				local item = self.BuffItems[i]
				local buffData = existingResistantBuffs[i]

				if buffData ~= nil then
					item:SetData(buffData.CID, buffData.Stack)
				else
					item:SetData(nil)
				end
			end

			for i = 0, self.SkillGrid.transform.childCount - 1 do
				local obj = self.SkillGrid.transform:GetChild(0).gameObject

				UnityEngine.GameObject.DestroyImmediate(obj)
			end

			for i = 1, #self.cfgMonsterRes.MonsterSkillShow do
				local skillId = self.cfgMonsterRes.MonsterSkillShow[i]
				local cfgSkill = CfgSkillTable[skillId]
				local objSkillName = UnityEngine.Object.Instantiate(self.SkillName)

				objSkillName:SetActive(true)
				UGUIUtil.SetText(objSkillName.transform:Find("Text").gameObject, cfgSkill.Name)
				objSkillName.transform:SetParent(self.SkillGrid.transform, false)

				local objSkillDes = UnityEngine.Object.Instantiate(self.SkillValue)

				objSkillDes:SetActive(true)
				UGUIUtil.SetText(objSkillDes.transform:Find("Text").gameObject, LibraryMazeUIApi:GetString("EffectText", cfgSkill.EffectText))
				objSkillDes.transform:SetParent(self.SkillGrid.transform, false)
			end

			for i, v in pairs(self.MonsterWeakCells) do
				v.View.transform:SetParent(self.UIController.transform, false)
				self.MonsterWeakPool:Release(v)
			end

			self.MonsterWeakCells = {}

			for i = 1, #cfgMonster.WeakType do
				local weakType = cfgMonster.WeakType[i]
				local cell = self.MonsterWeakPool:Obtain()

				cell.View:SetActive(true)
				cell.View.transform:SetParent(self.WeakGrid.transform, false)
				cell:SetData(weakType)
				table.insert(self.MonsterWeakCells, cell)
			end
		end
	end
end

function MonsterTipInfoUI:ShowMonster(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.MonsterPos.transform, Vector3.zero)
end

function MonsterTipInfoUI:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function MonsterTipInfoUI:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = Vector3(self.cfgMonsterRes.EntityScale[1], self.cfgMonsterRes.EntityScale[2], self.cfgMonsterRes.EntityScale[3])
		args.Entity.gameObject.transform.localPosition = Vector3(self.cfgMonsterRes.EntityPosition[1], self.cfgMonsterRes.EntityPosition[2], self.cfgMonsterRes.EntityPosition[3])
		self.SpineRenderers = args.Entity.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			animation.state:SetAnimation(0, "idle", true)
		end

		self:UpdateSpineSortingOrder()
		setGameObjectLayers(args.Entity.gameObject.transform, "UI")
	end
end

function MonsterTipInfoUI:UpdateSpineSortingOrder()
	if self.SpineRenderers ~= nil then
		for i = 0, self.SpineRenderers.Length - 1 do
			self.SpineRenderers[i].sortingOrder = self.sortingOrder
		end
	end
end

function MonsterTipInfoUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.MonsterTipInfoUI)
end

return MonsterTipInfoUI
