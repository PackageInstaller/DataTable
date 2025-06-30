-- chunkname: @IQIGame\\Scene\\Memory\\MemoryScene.lua

local MemoryScene = {
	elements = {},
	entityid2CfgDic = {}
}
local CameraCtrl = require("IQIGame.Scene.TownArea.CameraCtrl")
local Role = require("IQIGame.Scene.Memory.Role")
local NormalElement = require("IQIGame.Scene.Memory.Element.NormalElement")

function MemoryScene.New(view)
	local obj = Clone(MemoryScene)

	obj:Init(view)

	return obj
end

function MemoryScene:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.cameraCtrl = CameraCtrl.New()

	function self.onTimerDelegate()
		self:OnTimerUpdate()
	end

	function self.onShowElementSuccessDelegate(sender, args)
		self:OnShowElementSuccess(sender, args)
	end

	self:OnAddListener()
end

function MemoryScene:Refresh(cfgSceneData, cfgChapterData)
	self.cfgSceneData = cfgSceneData
	self.cfgChapterData = cfgChapterData
	self.entityid2CfgDic = {}

	self:InitCamera()
	self:ShowRole()
	self:ShowElements()
end

function MemoryScene:OnTimerUpdate()
	if self.cameraCtrl ~= nil then
		self.cameraCtrl:OnUpdate()
	end

	if self.role ~= nil then
		self.role:OnUpdate()

		if self.role.collider ~= nil then
			for i, v in pairs(self.elements) do
				if self.role == nil then
					return
				end

				if self.role.collider.bounds:Intersects(v.trigger.collider.bounds) then
					v.trigger:OnEnterArea()
				else
					v.trigger:OnExitArea()
				end

				v.trigger:OnInDistance(v.cfgEventData.Distance == 0 or Vector2.Distance(self.role.View.transform.localPosition, v.View.transform.localPosition) < v.cfgEventData.Distance)
			end
		end
	end
end

function MemoryScene:OnDestroy()
	self:OnRemoveListener()
	self.cameraCtrl:OnDestroy()
	self.role:OnDestroy()

	for i, v in pairs(self.elements) do
		v:OnDestroy()
	end

	self.role = nil
	self.cameraCtrl = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function MemoryScene:OnAddListener()
	GameEntry.Timer:AddFrameRender(1, self.onTimerDelegate, true)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowElementSuccessDelegate)
end

function MemoryScene:OnRemoveListener()
	GameEntry.Timer:RemoveRender(self.onTimerDelegate)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.onShowElementSuccessDelegate)
end

function MemoryScene:OnShowElementSuccess(sender, args)
	local cfgEventData = self.entityid2CfgDic[args.Entity.Id]

	if cfgEventData == nil then
		return
	end

	local go = GameEntry.Entity:GetEntity(args.Entity.Id).gameObject
	local oldScale = go.transform.localScale

	if cfgEventData.Direction then
		oldScale.x = -math.abs(oldScale.x)
	else
		oldScale.x = math.abs(oldScale.x)
	end

	go.transform.localScale = oldScale

	local element = NormalElement.New(go, self)

	self.elements[#self.elements + 1] = element

	element:Refresh(cfgEventData)
end

function MemoryScene:InitCamera()
	self.cameraCtrl:Refresh(self.cfgSceneData.BornPoint[1], self.goLimitLeft.transform.position, self.goLimitRight.transform.position, UnityEngine.Camera.main, 3.75)
end

function MemoryScene:ShowRole()
	local go = UnityEngine.Object.Instantiate(self.goRole)

	go.transform:SetParent(self.goElementRoot.transform, false)

	go.transform.localPosition = Vector2.New(self.cfgSceneData.BornPoint[1], self.cfgSceneData.BornPoint[2])

	local oldScale = go.transform.localScale

	if self.cfgSceneData.Direction then
		oldScale.x = -math.abs(oldScale.x)
	else
		oldScale.x = math.abs(oldScale.x)
	end

	go.transform.localScale = oldScale
	self.role = Role.New(go)

	self.role:Refresh(self.cfgChapterData, self.cameraCtrl)
end

function MemoryScene:ShowElements()
	for i, v in pairs(self.cfgSceneData.EventList) do
		local cfgEventData = CfgMemoryEventListTable[v]
		local entityId = GameEntry.Entity:GenerateEntityID()

		GameEntry.Entity:ShowElement(entityId, cfgEventData.Element, 0, self.goElementRoot.transform, Vector2.New(cfgEventData.Position[1], cfgEventData.Position[2]))

		self.entityid2CfgDic[entityId] = cfgEventData
	end
end

return MemoryScene
