-- chunkname: @IQIGame\\Scene\\Guild\\GuildPlayer.lua

local GuildPlayer = {
	entityId = 0,
	isWorking = false
}
local GuildPlayerAI = require("IQIGame.Scene.Guild.GuildPlayerAI")

function GuildPlayer.New(view)
	local obj = Clone(GuildPlayer)

	obj:Init(view)

	return obj
end

function GuildPlayer:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.ai = GuildPlayerAI.New(self.View)

	function self.onShowSpineSuccessDelegate(sender, args)
		self:OnShowSpineSuccess(sender, args)
	end
end

function GuildPlayer:Refresh(pod, position, walkArea, trans)
	self.guildMemberPOD = pod

	self.View.transform:SetParent(trans, false)

	self.View.transform.localPosition = position
	self.walkArea = walkArea

	if self.guildMemberPOD.player.showGirlDressId == nil then
		self.guildMemberPOD.player.showGirlDressId = 33000110
	end

	local cfgDressData = CfgDressTable[self.guildMemberPOD.player.showGirlDressId]

	self.cfgSoulResData = CfgSoulResTable[cfgDressData.SoulResID]

	self.Type2:SetActive(self.guildMemberPOD.position == Constant.GuildPosition.Guild_Vice_President)
	self.Type1:SetActive(self.guildMemberPOD.position == Constant.GuildPosition.Guild_President)
	UGUIUtil.SetTextInChildren(self.TextType1, GuildMainUIApi:GetString("TextType1"))
	UGUIUtil.SetTextInChildren(self.TextType2, GuildMainUIApi:GetString("TextType2"))
	UGUIUtil.SetText(self.TextName, self.guildMemberPOD.player.pName)
	self:SetActive(true)
	self:ShowSpine()
	self:OnAddListener()
end

function GuildPlayer:OnUpdate()
	self.ai:OnUpdate()
end

function GuildPlayer:OnHide()
	self:OnRemoveListener()
	self:DisposeEntity()
	self.ai:OnHide()
end

function GuildPlayer:OnDestroy()
	self:OnHide()
	self.ai:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
	self.ai = nil
end

function GuildPlayer:OnAddListener()
	self:OnRemoveListener()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowSpineSuccessDelegate)
end

function GuildPlayer:OnRemoveListener()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowSpineSuccessDelegate)
end

function GuildPlayer:OnShowSpineSuccess(sender, args)
	if self.entityId ~= args.Entity.Id then
		return
	end

	local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

	animation.state:SetAnimation(0, "idle", true)

	if self.guildMemberPOD.position == Constant.GuildPosition.Guild_Ordinary_Members then
		self.ai:StartAI(animation, self.walkArea)
	end

	local spineRenderers = args.Entity:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

	for j = 0, spineRenderers.Length - 1 do
		local renderer = spineRenderers[j]

		renderer.enabled = true
	end

	local renderers = args.Entity:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for i = 0, renderers.Length - 1 do
		renderers[i].enabled = true
	end
end

function GuildPlayer:ShowSpine()
	self:DisposeEntity()

	self.entityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowElement(self.entityId, self.cfgSoulResData.HomelandEntityId, 0, self.goSpineRoot.transform, Vector3.zero)
end

function GuildPlayer:DisposeEntity()
	if self.entityId ~= 0 then
		GameEntry.Entity:HideEntity(self.entityId)

		self.entityId = 0
	end
end

function GuildPlayer:SetActive(vs)
	if not vs then
		self:OnHide()
	end

	self.isWorking = vs

	self.View:SetActive(vs)
end

return GuildPlayer
