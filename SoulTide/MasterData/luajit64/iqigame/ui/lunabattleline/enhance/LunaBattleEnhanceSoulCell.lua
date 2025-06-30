-- chunkname: @IQIGame\\UI\\LunaBattleLine\\Enhance\\LunaBattleEnhanceSoulCell.lua

local m = {
	EntityId = 0,
	ClassTags = {},
	TypeTags = {}
}

function m.New(view, onSelect, onPickSoul)
	local obj = Clone(m)

	obj:Init(view, onSelect, onPickSoul)

	return obj
end

function m:Init(view, onSelect, onPickSoul)
	self.View = view
	self.OnSelectCallback = onSelect
	self.OnPickSoulCallback = onPickSoul

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnMainToggleValueChanged(isOn)
		self:OnMainToggleValueChanged(isOn)
	end

	function self.DelegateOnClickEmptyView()
		self:OnClickEmptyView()
	end

	function self.DelegateOnClickChangeBtn()
		self:OnClickChangeBtn()
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	for i = 1, 2 do
		local tagGo = UnityEngine.Object.Instantiate(self.TagPrefab)

		tagGo.transform:SetParent(self.TagGrid.transform, false)

		self.ClassTags[i] = tagGo
	end

	for i = 1, 2 do
		local tagGo = UnityEngine.Object.Instantiate(self.TagPrefab)

		tagGo.transform:SetParent(self.TagGrid.transform, false)

		self.TypeTags[i] = tagGo
	end

	local toggleHelper = self.PositionToggle:GetComponent("ToggleHelperComponent")

	toggleHelper:SetTexts(LunaBattleLineEnhanceFormationUIApi:GetString("SoulCellPositionToggleTexts"))
	self:AddListeners()
end

function m:AddListeners()
	self.ToggleGO:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnMainToggleValueChanged)
	self.EmptyView:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEmptyView)
	self.ChangeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChangeBtn)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:RemoveListeners()
	self.ToggleGO:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnMainToggleValueChanged)
	self.EmptyView:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEmptyView)
	self.ChangeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChangeBtn)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:SetData(soulPrefab)
	self.SoulPrefab = soulPrefab

	self.EmptyView:SetActive(soulPrefab == nil)
	self.NormalView:SetActive(soulPrefab ~= nil)
	self:TryHideEntity()

	if soulPrefab == nil then
		return
	end

	local cfgDressData = CfgDressTable[soulPrefab.dress3DCid]
	local cfgSoulResData = CfgSoulResTable[cfgDressData.SoulResID]

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.EntityId, cfgSoulResData.UIEntityId, 0, self.SpineNode.transform, Vector3.zero, nil, false)

	local cfgSkillGroupData = CfgSkillGroupTable[soulPrefab.skillGroupId]

	for i = 1, #self.ClassTags do
		local tagGo = self.ClassTags[i]
		local isActive = i <= #cfgSkillGroupData.SoulClass

		tagGo.transform:GetChild(0).gameObject:SetActive(isActive)

		if isActive then
			UGUIUtil.SetTextInChildren(tagGo, MiscApi:GetString("SoulClass", cfgSkillGroupData.SoulClass[i]))
			AssetUtil.LoadImage(self, MiscApi:GetString("SoulClassBgImage", cfgSkillGroupData.SoulClass[i]), tagGo:GetComponentInChildren(typeof(UnityEngine.UI.Image)))
		end
	end

	for i = 1, #self.TypeTags do
		local tagGo = self.TypeTags[i]
		local isActive = i <= #cfgSkillGroupData.SkillTag

		tagGo.transform:GetChild(0).gameObject:SetActive(isActive)

		if isActive then
			UGUIUtil.SetTextInChildren(tagGo, MiscApi:GetString("SkillTag", cfgSkillGroupData.SkillTag[i]))
			AssetUtil.LoadImage(self, MiscApi:GetString("SkillTagBgImage", cfgSkillGroupData.SkillTag[i]), tagGo:GetComponentInChildren(typeof(UnityEngine.UI.Image)))
		end
	end

	UGUIUtil.SetText(self.PowerText, tostring(soulPrefab.power))

	local toggle = self.PositionToggle:GetComponent("Toggle")

	toggle.isOn = soulPrefab.position == 1
end

function m:TryHideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.SpineGO = nil
		self.EntityId = 0
	end
end

function m:IsSelect()
	local toggle = self.ToggleGO:GetComponent("Toggle")

	return toggle.isOn
end

function m:Select()
	local toggle = self.ToggleGO:GetComponent("Toggle")

	toggle.isOn = true
end

function m:OnMainToggleValueChanged(isOn)
	if isOn then
		if self.OnSelectCallback ~= nil then
			self.OnSelectCallback(self)
		end

		self:PlaySpineAnimation("walk")
	else
		self:PlaySpineAnimation("idle")
	end
end

function m:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		self.SpineGO = args.Entity.gameObject

		local toggle = self.ToggleGO:GetComponent("Toggle")

		self:PlaySpineAnimation(toggle.isOn and "walk" or "idle")
	end
end

function m:PlaySpineAnimation(animationName)
	if self.SpineGO == nil then
		return
	end

	local skeletonGraphic = self.SpineGO:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

	if skeletonGraphic == nil then
		return
	end

	if skeletonGraphic.AnimationState ~= nil then
		local animData = skeletonGraphic.AnimationState.Data.SkeletonData:FindAnimation(animationName)

		if animData ~= nil then
			skeletonGraphic.AnimationState:ClearTrack(0)
			skeletonGraphic.Skeleton:SetToSetupPose()
			skeletonGraphic.AnimationState:SetAnimation(0, animationName, true)
		end
	else
		local soulCid

		if self.SoulPrefab ~= nil then
			soulCid = self.SoulPrefab.soulCid
		end

		logError("Play animation error, state is null. Animation name: " .. animationName .. " soulCid: " .. tostring(soulCid))
	end
end

function m:OnClickEmptyView()
	self:ChooseSoulInPool()
end

function m:OnClickChangeBtn()
	self:ChooseSoulInPool()
end

function m:ChooseSoulInPool()
	if self.OnPickSoulCallback ~= nil then
		self.OnPickSoulCallback(self)
	end
end

function m:GetPosition()
	local toggle = self.PositionToggle:GetComponent("Toggle")

	if toggle.isOn then
		return 1
	else
		return 2
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()

	for i = 1, #self.ClassTags do
		self.ClassTags[i] = nil
	end

	for i = 1, #self.TypeTags do
		self.TypeTags[i] = nil
	end

	self:TryHideEntity()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnSelectCallback = nil
	self.OnPickSoulCallback = nil
	self.SoulPrefab = nil
end

return m
