-- chunkname: @IQIGame\\Scene\\MemoryStory\\MemoryStoryMap.lua

local PathNodeData = require("IQIGame.Scene.MemoryStory.MemoryStoryPathNode")
local m = {
	PathNodeList = {},
	effectIdTab = {}
}

function m.New(path, callback)
	local obj = Clone(m)

	obj:__Init(path, callback)

	return obj
end

function m:GetPathNode(nodeId)
	return self.PathNodeList[nodeId]
end

function m:GetFreeElementRoot()
	local go = UnityEngine.GameObject.New()

	self:MountElement(go.transform, nil)

	return go
end

function m:MountElement(elemTrans, position)
	elemTrans:SetParent(self.elementRoot.transform, false)

	if position ~= nil then
		elemTrans.localPosition = position
	end
end

function m:GetMapLimitPos()
	local top = self.LimitTop.transform.position.y
	local right = self.LimitRight.transform.position.x
	local bottom = self.LimitBottom.transform.position.y
	local left = self.LimitLeft.transform.position.x

	return top, right, bottom, left
end

function m:__Init(path, callback)
	self.prepareSuccessEvent = callback

	self:__PrepareLoad(path)
end

function m:__PrepareLoad(path)
	self.curMapPath = UIGlobalApi.GetArtPath(path)

	function self.loadStorySceneSuccessEventProxy(source, assetName, asset, duration, innerUserData)
		self:__OnLoadStorySceneSuccessEventHandler(source, assetName, asset, duration, innerUserData)
	end

	AssetUtil.LoadAsset(self, self.curMapPath, self.loadStorySceneSuccessEventProxy)
end

function m:__OnLoadStorySceneSuccessEventHandler(source, assetName, asset, duration, innerUserData)
	if assetName ~= self.curMapPath then
		return
	end

	local sceneGo = UnityEngine.Object.Instantiate(asset)

	self:__PrepareSceneData(sceneGo)
end

function m:__PrepareSceneData(view)
	self.SceneView = view

	LuaCodeInterface.BindOutlet(self.SceneView, self)
	self:__PreparePathNode()
	self:__OnPrepareSuccess()
end

function m:__PreparePathNode()
	self.PathNodeList = {}

	local cnt = self.pointRoot.transform.childCount

	for i = 0, cnt - 1 do
		local trans = self.pointRoot.transform:GetChild(i)
		local node = PathNodeData.New(trans)

		self.PathNodeList[node.NodeId] = node
	end
end

function m:__OnPrepareSuccess()
	if self.prepareSuccessEvent ~= nil then
		self:prepareSuccessEvent()

		self.prepareSuccessEvent = nil
	end
end

function m:__PlayEffect(effectCid, delay)
	local effectId = GameEntry.Effect:PlayMountPointEffect(effectCid, Constant.MountPoint.PointRoot, 0, self.goElementRoot, delay, 0, LayerMask.NameToLayer("Default"), LuaCodeInterface.SortingLayerNameToID("Element"), Constant.Unity.SortingOrderMaxValue, 1, false)

	self:__AddEffectId(effectCid, effectId)
end

function m:__RemoveEffect(effectCid)
	local effects = self.effectIdTab[effectCid]

	if effects == nil then
		return
	end

	for i = 1, #effects do
		GameEntry.Effect:StopEffect(effects[i])
	end

	self.effectIdTab[effectCid] = nil
end

function m:__RemoveAllEffect()
	for effectCid, effectIds in pairs(self.effectIdTab) do
		for i = 1, #effectIds do
			GameEntry.Effect:StopEffect(effectIds[i])
		end
	end

	self.effectIdTab = {}
end

function m:__AddEffectId(effectCid, effectId)
	local tab = self.effectIdTab[effectCid]

	if tab == nil then
		tab = {}

		table.insert(tab, effectId)
	end

	self.effectIdTab[effectCid] = tab
end

function m:OnDestroy()
	self:__RemoveAllEffect()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.SceneView, self)

	if self.SceneView ~= nil then
		UnityEngine.GameObject.Destroy(self.SceneView.gameObject)

		self.SceneView = nil
	end

	self.PathNodeList = nil
end

return m
