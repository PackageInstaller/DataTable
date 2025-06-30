-- chunkname: @IQIGame\\UI\\Main\\MainUI_HudPanel.lua

local MainUI_HudPanel = {}
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local nameItemClass = require("IQIGame/UI/Main/MainUI_HudPanel_nameItem")
local roomSelectPanelClass = require("IQIGame/UI/Main/MainUI_HudPanel_RoomSelectPanel")
local TagItemClass = require("IQIGame/UI/Main/MainUI_HudPanel_TagItem")

function MainUI_HudPanel.New(go, mainView)
	local o = Clone(MainUI_HudPanel)

	o:Initialize(go, mainView)

	return o
end

function MainUI_HudPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.nameItemDic = {}
	self.tageItemDic = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function MainUI_HudPanel:InitComponent()
	self.nameItemPool = UIViewObjectPool.New(self.NPCNamePrefab, self.npcNameRoot.transform, function(_view)
		return nameItemClass.New(_view, self)
	end)
	self.tagItemPool = UIViewObjectPool.New(self.npcTagPrefab, self.npcTagRoot.transform, function(_view)
		return TagItemClass.New(_view, self)
	end)
	self.roomSelectPanel = roomSelectPanelClass.New(self.SelectRoomRoot, self)

	self.roomSelectPanel:Hide()
	LuaUtility.SetGameObjectShow(self.locationInfoRoot, false)
	LuaUtility.SetGameObjectShow(self.directLeft, false)
	LuaUtility.SetGameObjectShow(self.branchLeft, false)
	LuaUtility.SetGameObjectShow(self.branch_RPGLeft, false)
	LuaUtility.SetGameObjectShow(self.branch_SaunterLeft, false)
	LuaUtility.SetGameObjectShow(self.directRight, false)
	LuaUtility.SetGameObjectShow(self.branchRight, false)
	LuaUtility.SetGameObjectShow(self.branch_RPGRight, false)
	LuaUtility.SetGameObjectShow(self.branch_SaunterRight, false)
end

function MainUI_HudPanel:InitDelegate()
	function self.showRoomSelectEvent(actionParams)
		self.roomSelectPanel:Show()
		self.roomSelectPanel:Refresh(actionParams)
	end

	function self.hideRoomSelectEvent()
		self.roomSelectPanel:Hide()
	end

	function self.showNpcTagEvent(mountPoint, actionType, compId)
		self:ShowNpcTag(mountPoint, actionType, compId)
	end

	function self.hidNpcTagEvent(mountPoint)
		self:HideNpcTag(mountPoint)
	end
end

function MainUI_HudPanel:AddListener()
	EventDispatcher.AddEventListener(EventID.MainUI_ShowRoomSelectEvent, self.showRoomSelectEvent)
	EventDispatcher.AddEventListener(EventID.MainUI_HideRoomSelectEvent, self.hideRoomSelectEvent)
	EventDispatcher.AddEventListener(EventID.MainUI_ShowNpcTagEvent, self.showNpcTagEvent)
	EventDispatcher.AddEventListener(EventID.MainUI_HideNpcTagEvent, self.hidNpcTagEvent)
	EventUtil.AddEventListener(self, EventID.MainUI_ShowHudDirectEvent)
	EventUtil.AddEventListener(self, EventID.MainUI_HideHudDirectEvent)
	EventUtil.AddEventListener(self, EventID.MainUI_ShowUIEffectEvent)
	EventUtil.AddEventListener(self, EventID.MainUI_ClearTagEvent)
	EventUtil.AddEventListener(self, EventID.MainUI_HudPanel_SetLocationInfoEvent)
	EventUtil.AddEventListener(self, EventID.MainUI_SetHudBranchShowEvent)
	EventUtil.AddEventListener(self, EventID.MainUI_SetHudBranch_RpgShowEvent)
	EventUtil.AddEventListener(self, EventID.MainUI_SetHudSaunterShowEvent)
	EventUtil.AddEventListener(self, EventID.MainUI_SetHudRegularDirShowEvent)
end

function MainUI_HudPanel:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.MainUI_ShowRoomSelectEvent, self.showRoomSelectEvent)
	EventDispatcher.RemoveEventListener(EventID.MainUI_HideRoomSelectEvent, self.hideRoomSelectEvent)
	EventDispatcher.RemoveEventListener(EventID.MainUI_ShowNpcTagEvent, self.showNpcTagEvent)
	EventDispatcher.RemoveEventListener(EventID.MainUI_HideNpcTagEvent, self.hidNpcTagEvent)
	EventUtil.ClearEventListener(self)
end

function MainUI_HudPanel:__OnMainUI_SetHudRegularDirShowEventHandler(dir, show)
	if dir == 1 then
		LuaUtility.SetGameObjectShow(self.directRegularLeft, show)
	elseif dir == 2 then
		LuaUtility.SetGameObjectShow(self.directRegularRight, show)
	end
end

function MainUI_HudPanel:__OnMainUI_SetHudSaunterShowEventHandler(dir, show)
	if dir == 1 then
		LuaUtility.SetGameObjectShow(self.branch_SaunterLeft, show)
	elseif dir == 2 then
		LuaUtility.SetGameObjectShow(self.branch_SaunterRight, show)
	end
end

function MainUI_HudPanel:__OnMainUI_SetHudBranch_RpgShowEventHandler(dir, show)
	if dir == 1 then
		LuaUtility.SetGameObjectShow(self.branch_RPGLeft, show)
	elseif dir == 2 then
		LuaUtility.SetGameObjectShow(self.branch_RPGRight, show)
	end
end

function MainUI_HudPanel:__OnMainUI_SetHudBranchShowEventHandler(dir, show)
	if dir == 1 then
		LuaUtility.SetGameObjectShow(self.branchLeft, show)
	elseif dir == 2 then
		LuaUtility.SetGameObjectShow(self.branchRight, show)
	end
end

function MainUI_HudPanel:__OnMainUI_ShowHudDirectEventHandler(type, show)
	if type == 1 then
		LuaUtility.SetGameObjectShow(self.directLeft, show)
	elseif type == 2 then
		LuaUtility.SetGameObjectShow(self.directRight, show)
	end
end

function MainUI_HudPanel:__OnMainUI_HudPanel_SetLocationInfoEventHandler(textTime, textMainSite, textBranchSite)
	LuaUtility.SetGameObjectShow(self.locationInfoRoot, true)
	LuaUtility.SetText(self.TextTime, textTime)
	LuaUtility.SetText(self.TextMainSite, textMainSite)
	LuaUtility.SetText(self.TextBranchSite, textBranchSite)
	LuaUtility.PlayAnimation(self.locationInfoRoot, "StoryUI_01")
end

function MainUI_HudPanel:__OnMainUI_ShowUIEffectEventHandler(actorId, effectId, pos)
	local path = UIGlobalApi.GetFxEffectPathByEntityId(effectId)

	LuaUtility.LoadAsset(self, path, function(owner, assetName, asset, duration, userData)
		local effect = GameObject.Instantiate(asset, self.UIEffectRoot.transform)

		LuaUtility.SetAnchoredPositionWithRectTransform(effect:GetComponent("RectTransform"), pos.x, pos.y)
		CommonDialogueActionUtil.AddEffect(actorId, effectId, effect)
		EventDispatcher.Dispatch(EventID.CommonDialogControl_OnActionComplete, Constant.CommonDialogActionType.PlayEffect)
	end)
end

function MainUI_HudPanel:__OnMainUI_ClearTagEventHandler()
	self.tagItemPool:ForItems(function(_item)
		_item:Hide()
		_item:Free()
	end)
end

function MainUI_HudPanel:__OnMainUI_HideHudDirectEventHandler()
	LuaUtility.SetGameObjectShow(self.directLeft, false)
	LuaUtility.SetGameObjectShow(self.directRight, false)
	LuaUtility.SetGameObjectShow(self.branchLeft, false)
	LuaUtility.SetGameObjectShow(self.branchRight, false)
	LuaUtility.SetGameObjectShow(self.branch_RPGLeft, false)
	LuaUtility.SetGameObjectShow(self.branch_RPGRight, false)
	LuaUtility.SetGameObjectShow(self.branch_SaunterLeft, false)
	LuaUtility.SetGameObjectShow(self.branch_SaunterRight, false)
	LuaUtility.SetGameObjectShow(self.directRegularLeft, false)
	LuaUtility.SetGameObjectShow(self.directRegularRight, false)
end

function MainUI_HudPanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function MainUI_HudPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function MainUI_HudPanel:GetCanvas()
	return self.gameObject:GetComponent(typeof(UnityEngine.Canvas))
end

function MainUI_HudPanel:GetRoot()
	return self.Root
end

function MainUI_HudPanel:ShowNpcName(mountPoint, nameString, componentId)
	if LuaUtility.GameObjectIsNullOrEmpty(mountPoint) then
		return
	end

	local instanceId = mountPoint.gameObject:GetInstanceID()

	if self.nameItemDic[instanceId] then
		self.nameItemDic[instanceId]:Show()
		self.nameItemDic[instanceId]:Refresh(mountPoint, nameString, componentId)

		return
	end

	local item = self.nameItemPool:GetFree(function(_item)
		return _item:GetIsFree()
	end)

	item:Show()
	item:Refresh(mountPoint, nameString, componentId)

	self.nameItemDic[instanceId] = item
end

function MainUI_HudPanel:FreeNpcName(mountPoint)
	if LuaUtility.GameObjectIsNullOrEmpty(mountPoint) then
		return
	end

	local item = self.nameItemDic[mountPoint.gameObject:GetInstanceID()]

	if not item then
		return
	end

	item:Hide()

	item.isFree = true
end

function MainUI_HudPanel:HideNpcName(mountPoint)
	if LuaUtility.GameObjectIsNullOrEmpty(mountPoint) then
		return
	end

	local item = self.nameItemDic[mountPoint.gameObject:GetInstanceID()]

	if not item then
		return
	end

	item:Hide()
end

function MainUI_HudPanel:ShowNpcTag(mountPoint, actionType, compId)
	if LuaUtility.GameObjectIsNullOrEmpty(mountPoint) then
		return
	end

	local instanceId = mountPoint.gameObject:GetInstanceID()

	if self.tageItemDic[instanceId] then
		self.tageItemDic[instanceId]:Show()
		self.tageItemDic[instanceId]:Refresh(mountPoint, actionType, compId)

		return
	end

	local item = self.tagItemPool:GetFree(function(_item)
		return _item:GetIsFree()
	end)

	item:Show()
	item:Refresh(mountPoint, actionType, compId)

	if self.tageItemDic[instanceId] then
		logError(string.format("【RPG_标签】标签显示可能出现错误，多个标签指向同一个instanceID。ComponentID = %s,instanceId = %s", compId, instanceId))
	end

	self.tageItemDic[instanceId] = item
end

function MainUI_HudPanel:HideNpcTag(mountPoint)
	if LuaUtility.GameObjectIsNullOrEmpty(mountPoint) then
		return
	end

	local instanceId = mountPoint.gameObject:GetInstanceID()
	local item = self.tageItemDic[instanceId]

	if not item then
		return
	end

	item:Hide()
end

function MainUI_HudPanel:OnDestroy()
	self:RemoveListener()
	self.nameItemPool:Dispose(function(item)
		item:OnDestroy()
	end)

	self.nameItemDic = {}

	self.tagItemPool:Dispose(function(item)
		item:OnDestroy()
	end)

	self.tageItemDic = {}

	AssetUtil.UnloadAsset(self)
end

return MainUI_HudPanel
