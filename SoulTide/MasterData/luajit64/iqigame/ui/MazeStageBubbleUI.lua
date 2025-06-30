-- chunkname: @IQIGame\\UI\\MazeStageBubbleUI.lua

local MazeStageBubbleUI = Base:Extend("MazeStageBubbleUI", "IQIGame.Onigao.UI.MazeStageBubbleUI", {
	DURATION = 2,
	DialogObjListMap = {},
	PointTransCache = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function MazeStageBubbleUI:OnInit()
	function self.DelegateOnMazeStageShowBubble(type, bubbleId, pointNames)
		self:OnMazeStageShowBubble(type, bubbleId, pointNames)
	end

	function self.DelegateOnMazeStageHideBubble(type, bubbleId, pointName)
		self:OnMazeStageHideBubble(type, bubbleId, pointName)
	end

	self.TypeObjectPool = {}
	self.TypeObjectPool[1] = UIObjectPool.New(2, function()
		return UnityEngine.Object.Instantiate(self.Dialog1Prefab)
	end, function(gameObj)
		UnityEngine.Object.Destroy(gameObj)
	end)
	self.TypeObjectPool[2] = UIObjectPool.New(2, function()
		return UnityEngine.Object.Instantiate(self.Dialog2Prefab)
	end, function(gameObj)
		UnityEngine.Object.Destroy(gameObj)
	end)
	self.TypeObjectPool[3] = UIObjectPool.New(2, function()
		return UnityEngine.Object.Instantiate(self.Dialog3Prefab)
	end, function(gameObj)
		UnityEngine.Object.Destroy(gameObj)
	end)
	self.Canvas = self.UIController:GetComponent("Canvas")
end

function MazeStageBubbleUI:GetPreloadAssetPaths()
	return nil
end

function MazeStageBubbleUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeStageBubbleUI:IsManualShowOnOpen(userData)
	return false
end

function MazeStageBubbleUI:GetBGM(userData)
	return nil
end

function MazeStageBubbleUI:OnOpen(userData)
	return
end

function MazeStageBubbleUI:OnClose(userData)
	self:ClearAll()
end

function MazeStageBubbleUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.MazeStageShowBubble, self.DelegateOnMazeStageShowBubble)
	EventDispatcher.AddEventListener(EventID.MazeStageHideBubble, self.DelegateOnMazeStageHideBubble)
end

function MazeStageBubbleUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.MazeStageShowBubble, self.DelegateOnMazeStageShowBubble)
	EventDispatcher.RemoveEventListener(EventID.MazeStageHideBubble, self.DelegateOnMazeStageHideBubble)
end

function MazeStageBubbleUI:OnPause()
	return
end

function MazeStageBubbleUI:OnResume()
	return
end

function MazeStageBubbleUI:OnCover()
	return
end

function MazeStageBubbleUI:OnReveal()
	return
end

function MazeStageBubbleUI:OnRefocus(userData)
	return
end

function MazeStageBubbleUI:OnUpdate(elapseSeconds, realElapseSeconds)
	for type, list in pairs(self.DialogObjListMap) do
		for i = 1, #list do
			self:UpdatePosition(list[i].gameObject, list[i].pointName)
		end
	end
end

function MazeStageBubbleUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeStageBubbleUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeStageBubbleUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeStageBubbleUI:OnDestroy()
	for type, pool in pairs(self.TypeObjectPool) do
		pool:Dispose()
	end

	self.TypeObjectPool = nil
	self.Canvas = nil
end

function MazeStageBubbleUI:ClearAll()
	for type, list in pairs(self.DialogObjListMap) do
		local pool = self.TypeObjectPool[type]

		for i = 1, #list do
			local dialogObj = list[i].gameObject

			dialogObj:SetActive(false)
			dialogObj.transform:SetParent(self.UIController.transform, false)
			pool:Release(dialogObj)
		end
	end

	self.DialogObjListMap = {}

	for pointName, transform in pairs(self.PointTransCache) do
		self.PointTransCache[pointName] = nil
	end
end

function MazeStageBubbleUI:OnMazeStageShowBubble(type, bubbleId, pointNames)
	if type <= 0 then
		logError("气泡类型错误：" .. type)

		return
	end

	if bubbleId <= 0 then
		logError("气泡id错误：" .. bubbleId)

		return
	end

	for i = 1, #pointNames do
		local pointName = pointNames[i]

		if string.trim(pointName) == "" then
			logError("气泡跟随节点名称错误：" .. pointName)

			return
		end

		if MazeModule.MazeStageModule.CurrentStageObj.transform:Find(pointName) == nil then
			logError("找不到气泡跟随节点：" .. pointName)

			return
		end
	end

	local cfgMazeStageBubbleData = CfgMazeStageBubbleTable[bubbleId]
	local pool = self.TypeObjectPool[type]

	for i = 1, #pointNames do
		local pointName = pointNames[i]
		local dialogObj = pool:Obtain()

		dialogObj:SetActive(true)
		dialogObj.transform:SetParent(self.DialogRoot.transform, false)
		UGUIUtil.SetTextInChildren(dialogObj, cfgMazeStageBubbleData.Text)

		self.DialogObjListMap[type] = self.DialogObjListMap[type] or {}

		table.insert(self.DialogObjListMap[type], {
			type = type,
			bubbleId = bubbleId,
			pointName = pointName,
			gameObject = dialogObj
		})

		self.PointTransCache[pointName] = MazeModule.MazeStageModule.CurrentStageObj.transform:Find(pointName)

		self:UpdatePosition(dialogObj, pointName)
	end
end

function MazeStageBubbleUI:UpdatePosition(dialogObj, pointName)
	local pointTrans

	if pointName ~= "" then
		pointTrans = self.PointTransCache[pointName]
	end

	if pointTrans ~= nil then
		local screenPoint = MazeModule.MazeScene.MainCamera:WorldToScreenPoint(pointTrans.position)
		local uiWorldPoint = self.Canvas.worldCamera:ScreenToWorldPoint(screenPoint)

		uiWorldPoint.z = dialogObj.transform.position.z
		dialogObj.transform.position = uiWorldPoint
	end

	if pointName ~= "" and pointTrans == nil then
		logError("找不到迷宫舞台气泡的挂点：" .. pointName)
	end
end

function MazeStageBubbleUI:OnMazeStageHideBubble(type, bubbleId, pointName)
	local pointCount = {}

	for lType, list in pairs(self.DialogObjListMap) do
		for i = #list, 1, -1 do
			local data = list[i]

			if (type == 0 or data.type == type) and (bubbleId == 0 or data.bubbleId == bubbleId) and (pointName == nil or data.pointName == pointName) then
				local dialogObj = data.gameObject

				dialogObj:SetActive(false)
				dialogObj.transform:SetParent(self.UIController.transform, false)

				local pool = self.TypeObjectPool[data.type]

				pool:Release(dialogObj)
				table.remove(list, i)
			else
				pointCount[data.pointName] = pointCount[data.pointName] or 0
				pointCount[data.pointName] = pointCount[data.pointName] + 1
			end
		end
	end

	for lPointName, transform in pairs(self.PointTransCache) do
		if pointCount[lPointName] == nil then
			self.PointTransCache[lPointName] = nil
		end
	end
end

return MazeStageBubbleUI
