-- chunkname: @IQIGame\\UI\\Library\\LibrarySoulInfoView.lua

local LibrarySoulInfoView = {
	actionIndex = 1,
	EntityId = 0,
	actionNames = {},
	entityIds = {}
}

function LibrarySoulInfoView.New(view)
	local obj = Clone(LibrarySoulInfoView)

	obj:Init(view)

	return obj
end

function LibrarySoulInfoView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateBtnSpine()
		self:OnBtnSpine()
	end

	function self.delegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.delegateSpineActionEnd()
		self:OnSpineActionEnd()
	end

	self:AddListener()
end

function LibrarySoulInfoView:AddListener()
	self.BtnSpine:GetComponent("Button").onClick:AddListener(self.delegateBtnSpine)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function LibrarySoulInfoView:RemoveListener()
	self.BtnSpine:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSpine)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.delegateOnShowElementEntitySuccess)
end

function LibrarySoulInfoView:Update(data)
	self.librarySoulData = data

	UGUIUtil.SetText(self.TextSoulName, self.librarySoulData.cfgInfo.Name)
	UGUIUtil.SetText(self.TextSoulEngName, self.librarySoulData.cfgInfo.EnglishName)
	UGUIUtil.SetText(self.TextSoulDes, self.librarySoulData.cfgInfo.SoulPresent)
	UGUIUtil.SetText(self.SoulHeight, LibrarySoulApi:GetString("SoulHeight", self.librarySoulData.cfgInfo.SoulHeight))
	UGUIUtil.SetText(self.SoulWeight, LibrarySoulApi:GetString("SoulWeight", self.librarySoulData.cfgInfo.SoulWeight))
	UGUIUtil.SetText(self.SoulConstellation, LibrarySoulApi:GetString("SoulConstellation", self.librarySoulData.cfgInfo.SoulConstellation))
	UGUIUtil.SetText(self.SoulDescribe, LibrarySoulApi:GetString("SoulDescribe", self.librarySoulData.cfgInfo.SoulDescribe))
	UGUIUtil.SetText(self.CVName, LibrarySoulApi:GetString("CVName", self.librarySoulData.cfgInfo.CVName))

	local soulData = SoulModule.GetSoulData(self.librarySoulData.cfgID)
	local cfgEntityID = soulData:GetCfgSoulRes3D().UIEntityId

	if cfgEntityID ~= nil then
		self:ShowSoulSpine(cfgEntityID)
	end

	local isHide = soulData:GetCfgSoul().HideCVName or false

	self.CVName:SetActive(not isHide)
end

function LibrarySoulInfoView:OnBtnSpine()
	if self.skeletonAnimationState then
		self.actionIndex = self.actionIndex + 1

		if self.actionIndex > #self.actionNames then
			self.actionIndex = 1
		end

		local activeName = self.actionNames[self.actionIndex]

		self.skeletonAnimationState:SetEmptyAnimation(0, 0)
		self.skeletonAnimationState:SetAnimation(0, activeName, false)

		self.skeletonAnimationState.Complete = self.skeletonAnimationState.Complete + self.delegateSpineActionEnd
	end
end

function LibrarySoulInfoView:ShowSoulSpine(elementEntityCid)
	self.actionNames = {}

	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	table.insert(self.entityIds, self.EntityId)
	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.Spine.transform, Vector3.zero)
end

function LibrarySoulInfoView:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function LibrarySoulInfoView:OnSpineActionEnd()
	self.skeletonAnimationState.Complete = self.skeletonAnimationState.Complete - self.delegateSpineActionEnd

	self.skeletonAnimationState:SetEmptyAnimation(0, 0)
	self.skeletonAnimationState:SetAnimation(0, "idle", true)
end

function LibrarySoulInfoView:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		LuaCodeInterface.GetSpineAnimationNames(args.Entity.gameObject, self.actionNames)

		self.skeletonAnimationState = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic)).AnimationState

		if self.skeletonAnimationState then
			self.skeletonAnimationState:SetEmptyAnimation(0, 0)
			self.skeletonAnimationState:SetAnimation(0, "idle", true)
		end
	else
		local pos = table.indexOf(self.entityIds, args.Entity.Id)

		if pos ~= -1 and args.Entity.Id ~= 0 then
			GameEntry.Entity:HideEntity(args.Entity.Id)
			table.remove(self.entityIds, pos)
		end
	end
end

function LibrarySoulInfoView:Open()
	self.View:SetActive(true)
end

function LibrarySoulInfoView:Close()
	self.View:SetActive(false)
	self:HideEntity()
end

function LibrarySoulInfoView:Dispose()
	self:RemoveListener()
	self:HideEntity()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibrarySoulInfoView
