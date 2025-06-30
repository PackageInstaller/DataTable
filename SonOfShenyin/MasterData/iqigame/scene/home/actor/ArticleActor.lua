-- chunkname: @IQIGame\\Scene\\Home\\Actor\\ArticleActor.lua

local HomeActor = require("IQIGame/Scene/Home/Actor/HomeActor")
local m = Clone(HomeActor)

function m:CreatePrefab(prefabPath, parentTrans)
	self:LoadPrefab(prefabPath, parentTrans)
end

function m:LoadPrefab(prefabPath, parent)
	AssetUtil.LoadAsset(self, prefabPath, function(_, _assetUrl, _asset, _duration, _userData)
		self:__OnPrefabLoadSuccess(_asset, parent)
	end, function(_assetName, _status, _errorMessage, _userData)
		logError("家园系统加载Part失败 {0} -> {1}", self.actorCid, prefabPath)
	end)
end

function m:__OnPrefabLoadSuccess(asset, parent)
	self.gameObject = GameObject.Instantiate(asset)
	self.transform = self.gameObject.transform
	self.transform.parent = parent
	self.parentTrans = parent

	self:InitComponents()
end

function m:InitComponents()
	local componentData = WorldMapModule.GetComponentDataWithId(self.actorCid)

	self.gameObject.name = tostring(self.actorCid)

	if componentData.pos then
		self.transform.localPosition = componentData.pos
	else
		self.transform.localPosition = Vector3.zero
	end

	self.transform.localScale = Vector3.one
	self.collider = self.gameObject:GetComponent(typeof(UnityEngine.BoxCollider))

	if not self.collider then
		logError(string.format("【RPG】角色 id = %s,没有碰撞组件", self:GetComponentId()))
	end

	self.collider.isTrigger = true
	self.actorComponent = self.gameObject:AddComponent(typeof(IQIGame.Onigao.Game.Home.HomeActor))

	self.actorComponent:InitActorData(Constant.HomeSceneActorType.Article, self.componentId)

	self.name = componentData:GetCfg().Name
	self.nameMountPoint = self.transform:Find("Ui/namePoint")
	self.dialogMountPoint = self.transform:Find("Ui/dialogPoint")
	self.selectMountPoint = self.transform:Find("Ui/selectPoint")
	self.tagMountPoint = self.transform:Find("Ui/tagPoint")

	self:__OnActorPrepareReady()
end

function m:GetNameMountPoint()
	return self.nameMountPoint
end

function m:GetDialogMountPoint()
	return self.dialogMountPoint
end

function m:GetSelectMountPoint()
	return self.selectMountPoint
end

function m:GetTagMountPoint()
	return self.tagMountPoint
end

function m:GetName()
	return self.name
end

function m:GetComponentId()
	return self.componentId
end

function m:GetRootGameObject()
	return self.gameObject
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
	self.controller:InitAction()
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
	EventDispatcher.Dispatch(EventID.MainUI_HideNpcTagEvent, self:GetTagMountPoint())
	EventDispatcher.Dispatch(EventID.MainUI_HideNpcNameEvent, self:GetNameMountPoint())
end

function m:GetActive()
	return self.gameObject.activeSelf
end

function m:StartTalk(args)
	self.controller:ChangeStateByName(Constant.RPGActorFSMState.Chat, args)
end

function m:ChangeModel(skinId)
	GameObject.Destroy(self:GetRootGameObject())

	self.gameObject = nil

	local skinConfig = CfgHomeRoomPartSkinTable[skinId]

	self:LoadPrefab(skinConfig.PrefabPath, self.parentTrans)
end

function m:ChangeDirection(direction)
	if direction == 1 then
		self.gameObject.transform.localRotation = Vector3.New(0, 180, 0)
	elseif direction == 2 then
		self.gameObject.transform.localRotation = Vector3.New(0, 0, 0)
	end
end

function m:__OnDispose()
	EventDispatcher.Dispatch(EventID.MainUI_FreeNpcNameEvent, self:GetNameMountPoint())
	EventDispatcher.Dispatch(EventID.MainUI_HideNpcTagEvent, self:GetTagMountPoint())
	AssetUtil.UnloadAsset(self)
	GameObject.Destroy(self:GetRootGameObject())

	self.gameObject = nil
end

return m
