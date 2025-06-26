-- chunkname: @IQIGame\\UI\\LibraryMonsterInfoUI.lua

local LibraryMonsterInfoUI = Base:Extend("LibraryMonsterInfoUI", "IQIGame.Onigao.UI.LibraryMonsterInfoUI", {
	sortingOrder = 0,
	EntityId = 0,
	MonsterWeakCells = {},
	MonsterSkillCells = {},
	skillName = {},
	entityIds = {},
	BuffItems = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local LibraryMonsterWeakCell = require("IQIGame.UI.Library.LibraryMonsterWeakCell")
local BattleMonsterInfoBuffItem = require("IQIGame.UI.BattleMonsterInfo.BattleMonsterInfoBuffItem")
local LibraryMonsterSkillCell = require("IQIGame.UI.Library.LibraryMonsterSkillCell")

function LibraryMonsterInfoUI:OnInit()
	UGUIUtil.SetText(self.TextMonsterTitle1, LibraryMazeUIApi:GetString("TextMonsterTitle1", false))
	UGUIUtil.SetText(self.TextMonsterTitleEng1, LibraryMazeUIApi:GetString("TextMonsterTitle1", true))
	UGUIUtil.SetText(self.TextMonsterTitle2, LibraryMazeUIApi:GetString("TextMonsterTitle2", false))
	UGUIUtil.SetText(self.TextMonsterTitleEng2, LibraryMazeUIApi:GetString("TextMonsterTitle2", true))
	UGUIUtil.SetText(self.TextMonsterTitle3, LibraryMazeUIApi:GetString("TextMonsterTitle3", false))
	UGUIUtil.SetText(self.TextMonsterTitleEng3, LibraryMazeUIApi:GetString("TextMonsterTitle3", true))
	UGUIUtil.SetText(self.TextLock, LibraryMazeUIApi:GetString("TextLock"))
	UGUIUtil.SetText(self.TextTitle, LibraryUIApi:GetString("TextTitle", false))
	UGUIUtil.SetText(self.TextTitleEng, LibraryUIApi:GetString("TextTitle", true))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnLeft()
		self:OnBtnLeft()
	end

	function self.delegateBtnRight()
		self:OnBtnRight()
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
	self.MonsterSkillPool = UIObjectPool.New(8, function()
		local cell = LibraryMonsterSkillCell.New(UnityEngine.Object.Instantiate(self.SkillValue))

		return cell
	end, function(cell)
		cell:Dispose()

		local v = cell.View

		UnityEngine.Object.Destroy(v)
	end)

	for i = 1, 8 do
		local view = UnityEngine.Object.Instantiate(self.BuffItemPrefab)

		view.transform:SetParent(self.TextGrid.transform, false)

		local item = BattleMonsterInfoBuffItem.New(view)

		self.BuffItems[i] = item
	end
end

function LibraryMonsterInfoUI:GetPreloadAssetPaths()
	return nil
end

function LibraryMonsterInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LibraryMonsterInfoUI:IsManualShowOnOpen(userData)
	return false
end

function LibraryMonsterInfoUI:GetBGM(userData)
	return nil
end

function LibraryMonsterInfoUI:OnOpen(userData)
	self.index = userData[1]
	self.monsterRes = userData[2]
	self.libraryMonsterResData = self.monsterRes[self.index]

	self:UpDateView()
end

function LibraryMonsterInfoUI:OnClose(userData)
	self:HideEntity()
end

function LibraryMonsterInfoUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.delegateBtnRight)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function LibraryMonsterInfoUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRight)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function LibraryMonsterInfoUI:OnPause()
	return
end

function LibraryMonsterInfoUI:OnResume()
	return
end

function LibraryMonsterInfoUI:OnCover()
	return
end

function LibraryMonsterInfoUI:OnReveal()
	return
end

function LibraryMonsterInfoUI:OnRefocus(userData)
	return
end

function LibraryMonsterInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LibraryMonsterInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	local canvas = self.UIController.gameObject:GetComponent("Canvas")

	self.sortingOrder = canvas.sortingOrder + 1
end

function LibraryMonsterInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LibraryMonsterInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LibraryMonsterInfoUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.MonsterWeakCells) do
		self.MonsterWeakPool:Release(v)
	end

	self.MonsterWeakCells = {}

	self.MonsterWeakPool:Dispose()

	for i, v in pairs(self.MonsterSkillCells) do
		self.MonsterSkillPool:Release(v)
	end

	self.MonsterSkillCells = {}

	self.MonsterSkillPool:Dispose()

	for i = 1, #self.BuffItems do
		local item = self.BuffItems[i]

		item:Dispose()
	end

	self.BuffItems = nil
end

function LibraryMonsterInfoUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.LibraryMonsterInfoUI)
end

function LibraryMonsterInfoUI:OnBtnLeft()
	self.index = self.index - 1

	if self.index <= 0 then
		self.index = 1
	end

	self.libraryMonsterResData = self.monsterRes[self.index]

	self:UpDateView()
end

function LibraryMonsterInfoUI:OnBtnRight()
	self.index = self.index + 1

	if self.index > #self.monsterRes then
		self.index = #self.monsterRes
	end

	self.libraryMonsterResData = self.monsterRes[self.index]

	self:UpDateView()
end

function LibraryMonsterInfoUI:UpDateView()
	self.InfoView:SetActive(false)
	self.InfoView:SetActive(true)
	self.BtnLeft:SetActive(self.index > 1)
	self.BtnRight:SetActive(self.index < #self.monsterRes)

	if self.libraryMonsterResData then
		UGUIUtil.SetText(self.TextNpcName, self.libraryMonsterResData.cfgInfo.TabName)
		UGUIUtil.SetText(self.Text1, self.libraryMonsterResData.cfgInfo.MonsterDescribe)
		self.Lock:SetActive(not self.libraryMonsterResData.isLock)
		self:ShowMonster(self.libraryMonsterResData.cfgInfo.EntityID)

		if self.libraryMonsterResData.isLock then
			self.MonsterLock:SetActive(false)
			self.LockView:SetActive(false)
			self.InfoView:SetActive(true)

			local buffCidStacks = self.libraryMonsterResData.cfgInfo.MonsterInitialBuff
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

			for i, v in pairs(self.skillName) do
				UnityEngine.Object.Destroy(v)
			end

			self.skillName = {}

			for i, v in pairs(self.MonsterSkillCells) do
				v.View.transform:SetParent(self.UIController.transform, false)
				v.View:SetActive(false)
				self.MonsterSkillPool:Release(v)
			end

			self.MonsterSkillCells = {}

			for i = 1, #self.libraryMonsterResData.cfgInfo.MonsterSkillShow do
				local skillId = self.libraryMonsterResData.cfgInfo.MonsterSkillShow[i]
				local cfgSkill = CfgSkillTable[skillId]
				local objSkillName = UnityEngine.Object.Instantiate(self.SkillName)

				objSkillName:SetActive(true)
				UGUIUtil.SetText(objSkillName.transform:Find("Text").gameObject, cfgSkill.Name)
				objSkillName.transform:SetParent(self.SkillGrid.transform, false)
				table.insert(self.skillName, objSkillName)

				local cell = self.MonsterSkillPool:Obtain()

				cell.View:SetActive(true)
				cell.View.transform:SetParent(self.SkillGrid.transform, false)
				cell:SetData(cfgSkill.EffectText)
				table.insert(self.MonsterSkillCells, cell)
			end
		else
			self.MonsterLock:SetActive(true)
			self.LockView:SetActive(true)
			self.InfoView:SetActive(false)

			self.MonsterLock.transform.localScale = LibraryMazeUIApi:GetString("MonsterImgScale")

			local iconPath = UIGlobalApi.GetImagePath(self.libraryMonsterResData.cfgInfo.MonsterImage)

			AssetUtil.LoadImage(self, iconPath, self.ImgMonsterLock:GetComponent("Image"))
			self.ImgMonsterLock:GetComponent("ImageGroupGrayComponent"):EnableGray(true)
		end

		for i, v in pairs(self.MonsterWeakCells) do
			v.View.transform:SetParent(self.UIController.transform, false)
			v.View:SetActive(false)
			self.MonsterWeakPool:Release(v)
		end

		self.MonsterWeakCells = {}

		for i = 1, #self.libraryMonsterResData.cfgInfo.WeakType do
			local weakType = self.libraryMonsterResData.cfgInfo.WeakType[i]
			local cell = self.MonsterWeakPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.WeakGrid.transform, false)
			cell:SetData(weakType)
			table.insert(self.MonsterWeakCells, cell)
		end
	end
end

function LibraryMonsterInfoUI:ShowMonster(elementEntityCid)
	self:HideEntity()

	if self.libraryMonsterResData.isLock then
		self.EntityId = GameEntry.Entity:GenerateEntityID()

		table.insert(self.entityIds, self.EntityId)
		GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.MonsterPos.transform, Vector3.zero)
	end
end

function LibraryMonsterInfoUI:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function LibraryMonsterInfoUI:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = Vector3(self.libraryMonsterResData.cfgInfo.EntityScale[1], self.libraryMonsterResData.cfgInfo.EntityScale[2], self.libraryMonsterResData.cfgInfo.EntityScale[3])
		args.Entity.gameObject.transform.localPosition = Vector3(self.libraryMonsterResData.cfgInfo.EntityPosition[1], self.libraryMonsterResData.cfgInfo.EntityPosition[2], self.libraryMonsterResData.cfgInfo.EntityPosition[3])
		self.SpineRenderers = args.Entity.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			if self.libraryMonsterResData.isLock then
				animation.state:SetAnimation(0, "idle", true)
			else
				animation.AnimationName = nil
			end
		end

		self:UpdateSpineSortingOrder()
		setGameObjectLayers(args.Entity.gameObject.transform, "UI")
	else
		local pos = table.indexOf(self.entityIds, args.Entity.Id)

		if pos ~= -1 and args.Entity.Id ~= 0 then
			GameEntry.Entity:HideEntity(args.Entity.Id)
			table.remove(self.entityIds, pos)
		end
	end
end

function LibraryMonsterInfoUI:UpdateSpineSortingOrder()
	if self.SpineRenderers ~= nil then
		for i = 0, self.SpineRenderers.Length - 1 do
			self.SpineRenderers[i].sortingOrder = self.sortingOrder
		end
	end
end

return LibraryMonsterInfoUI
