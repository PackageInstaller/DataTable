-- chunkname: @IQIGame\\Scene\\TownArea\\EventEntry.lua

local EventEntry = {
	entityId = 0
}
local AI = require("IQIGame.Scene.TownArea.AI")

function EventEntry.New(view)
	local obj = Clone(EventEntry)

	obj:Init(view)

	return obj
end

function EventEntry:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ai = AI.New(self.View)

	function self.onClickBtnSelfDelegate()
		self:OnClickBtnSelf()
	end

	function self.onShowSpineSuccessDelegate(sender, args)
		self:OnShowSpineSuccess(sender, args)
	end
end

function EventEntry:Refresh(townFunctionData, position, walkArea)
	self.townFunctionData = townFunctionData
	self.walkArea = walkArea

	self:SetActive(true)

	self.View.transform.localPosition = position

	self:RefreshMisc()
	self:ShowSpine()
	self:OnAddListener()
end

function EventEntry:OnUpdate()
	self.ai:OnUpdate()
end

function EventEntry:OnHide()
	self:OnRemoveListener()
	self:DisposeEntity()
	self.ai:OnHide()
end

function EventEntry:OnDestroy()
	self:OnHide()
	self.ai:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.ai = nil
end

function EventEntry:OnAddListener()
	self:OnRemoveListener()

	if self.goBtnSelf ~= nil then
		EventTriggerListener.Get(self.goBtnSelf).onClick = self.onClickBtnSelfDelegate
	end

	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowSpineSuccessDelegate)
end

function EventEntry:OnRemoveListener()
	if self.goBtnSelf ~= nil then
		EventTriggerListener.Get(self.goBtnSelf).onClick = nil
	end

	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowSpineSuccessDelegate)
end

function EventEntry:OnClickBtnSelf()
	TownModule.ExecutionEvent(self.townFunctionData)
end

function EventEntry:OnShowSpineSuccess(sender, args)
	if self.entityId ~= args.Entity.Id then
		return
	end

	local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

	animation.state:SetAnimation(0, "idle", true)
	self.ai:StartAI(animation, self.walkArea)
end

function EventEntry:RefreshMisc()
	self.goSignStory:SetActive(self.townFunctionData.functionType == TownModule.TOWN_FUNCTION_SOUL_NEW_STORY)
	self.goSignShopping:SetActive(self.townFunctionData.functionType == TownModule.TOWN_FUNCTION_SHOPPING)
end

function EventEntry:ShowSpine()
	local cfgEntityID

	if self.townFunctionData.functionType == TownModule.TOWN_FUNCTION_SOUL_NEW_STORY then
		local soulData = SoulModule.GetSoulData(self.townFunctionData.newStoryInfo.cfgSoulNewStory.SoulId)

		cfgEntityID = soulData:GetCfgSoulRes3D().HomelandEntityId
	elseif self.townFunctionData.functionType == TownModule.TOWN_FUNCTION_SHOPPING then
		cfgEntityID = self.townFunctionData.cfgTownEvent.TownSpine
	end

	self:DisposeEntity()

	if cfgEntityID == nil or cfgEntityID <= 0 then
		return
	end

	self.entityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.entityId, cfgEntityID, 0, self.goSpineRoot.transform, Vector3.zero)
end

function EventEntry:DisposeEntity()
	if self.entityId ~= 0 then
		GameEntry.Entity:HideEntity(self.entityId)

		self.entityId = 0
	end
end

function EventEntry:SetActive(vs)
	if not vs then
		self:OnHide()
	end

	self.isWorking = vs

	self.View:SetActive(vs)
end

return EventEntry
