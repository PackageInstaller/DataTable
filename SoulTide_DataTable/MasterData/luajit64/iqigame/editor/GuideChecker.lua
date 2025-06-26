-- chunkname: @IQIGame\\Editor\\GuideChecker.lua

local GuideCheckerUIDefaultData = require("IQIGame.Editor.GuideCheckerUIDefaultData")
local GuideCheckerUIScene = require("IQIGame.Editor.GuideCheckerUIScene")

GuideChecker = {
	UICfgMap = {},
	CurrentScene = SceneID.MainCity
}

function GuideChecker.Init()
	for i, cfgData in pairsCfg(CfgUIConfigurationTable) do
		GuideChecker.UICfgMap[cfgData.UIName] = cfgData
	end
end

function GuideChecker.CheckUIAndSceneNodes()
	local uiNodes = {}

	for i, data in pairs(GuideSub) do
		local id = data.GuideSubID
		local sceneId = data.SceneID
		local isDynamic = data.IsDynamic

		if data.GuideSubShow ~= "" then
			table.insert(uiNodes, {
				id = id,
				sceneId = sceneId,
				path = data.GuideSubShow,
				isDynamic = isDynamic
			})
		end

		for typeI, typeDataArr in pairs(data.GuideUIType) do
			if typeDataArr[1] == "ClickArea" then
				table.insert(uiNodes, {
					id = id,
					sceneId = sceneId,
					path = typeDataArr[7],
					isDynamic = isDynamic
				})
			elseif typeDataArr[1] == "PlayEffect" then
				table.insert(uiNodes, {
					id = id,
					sceneId = sceneId,
					path = typeDataArr[4],
					isDynamic = isDynamic
				})
			elseif typeDataArr[1] == "ArrowPointing" then
				table.insert(uiNodes, {
					id = id,
					sceneId = sceneId,
					path = typeDataArr[6],
					isDynamic = isDynamic
				})
			end
		end
	end

	local sceneDataMap = {}
	local errorMessageMap = {}

	for i, data in pairs(uiNodes) do
		local slashStartIndex = string.find(data.path, "/")

		if slashStartIndex ~= nil then
			local uiCloneName = string.sub(data.path, 1, slashStartIndex - 1)
			local cloneStrIndex = string.find(uiCloneName, "%(Clone%)")
			local uiName
			local sceneId = data.sceneId

			if sceneId == nil then
				if cloneStrIndex ~= nil then
					sceneId = GuideCheckerUIScene.GetScene(uiName)
					uiName = string.sub(uiCloneName, 1, cloneStrIndex - 1)
				else
					errorMessageMap[data.id] = "<color=#ff8000>GuideSubID = " .. data.id .. " 可能使用了场景路径，但没有配置SceneID，该节点将被忽略。</color>"
				end
			else
				uiName = "None"
			end

			if uiName ~= nil then
				local uiNodesMap = sceneDataMap[sceneId]

				if uiNodesMap == nil then
					uiNodesMap = {}
					sceneDataMap[sceneId] = {}
				end

				local nodes = uiNodesMap[uiName]

				if nodes == nil then
					nodes = {}
					uiNodesMap[uiName] = nodes
				end

				local pathIndex = -1

				for nodesI, nodeData in pairs(nodes) do
					if nodeData.path == data.path then
						pathIndex = nodesI

						break
					end
				end

				if pathIndex == -1 then
					table.insert(nodes, {
						id = data.id,
						path = data.path,
						isDynamic = data.isDynamic
					})
				end
			end
		end
	end

	for id, errorStr in pairs(errorMessageMap) do
		logError(errorStr)
	end

	if GuideChecker.CheckUIQueue == nil then
		GuideChecker.CheckUIQueue = Queue.New()
	end

	GameEntry.LuaEvent:Subscribe(UIBecameVisibleEventArgs.EventId, GuideChecker.OnUIBecameVisible)
	GameEntry.LuaEvent:Subscribe(LoadSceneSuccessEventArgs.EventId, GuideChecker.OnLoadSceneSuccess)

	local tempArr = {}

	for sceneId, uiNodesMap in pairs(sceneDataMap) do
		for uiName, nodes in pairs(uiNodesMap) do
			table.insert(tempArr, {
				sceneId = sceneId,
				uiName = uiName,
				nodes = nodes
			})
		end
	end

	table.sort(tempArr, function(data1, data2)
		return data1.sceneId < data2.sceneId
	end)

	for i = 1, #tempArr do
		GuideChecker.CheckUIQueue:Enqueue(tempArr[i])
	end

	GuideChecker.__CheckOneData()
end

function GuideChecker.__CheckOneData()
	local data = GuideChecker.CheckUIQueue:Peek()

	if data.sceneId ~= GuideChecker.CurrentScene then
		local cfgSceneListData = CfgSceneListTable[data.sceneId]

		GameEntry.Scene:LoadScene("Assets/01_Scenes/" .. cfgSceneListData.SceneFile .. ".unity", 1, data.sceneId)

		return
	end

	if data.uiName ~= "None" then
		if UIModule.HasUI(data.uiName) then
			data = GuideChecker.CheckUIQueue:Dequeue()

			GuideChecker.__CheckNodes(data)
		else
			local cfgData = GuideChecker.UICfgMap[data.uiName]
			local layer = Constant.UILayer.UI

			if cfgData ~= nil then
				layer = cfgData.UILayer
			end

			local userData = GuideCheckerUIDefaultData.GetUserData(data.uiName)

			UIModule.Open(data.uiName, layer, userData)
		end
	else
		data = GuideChecker.CheckUIQueue:Dequeue()

		GuideChecker.__CheckNodes(data)
	end
end

function GuideChecker.__CheckNodes(data)
	local dynamicNodeStr = ""

	for i, nodeData in pairs(data.nodes) do
		if nodeData.isDynamic then
			dynamicNodeStr = dynamicNodeStr .. "[GuideSubID = " .. nodeData.id .. ", path = " .. nodeData.path .. "] "
		end
	end

	if dynamicNodeStr ~= "" then
		if data.uiName == "None" then
			local cfgSceneListData = CfgSceneListTable[data.sceneId]

			logError("<color=#ff8000>场景 " .. cfgSceneListData.SceneFile .. " 包含动态节点，无法自动检测，建议手动检查。" .. dynamicNodeStr .. "</color>")
		else
			logError("<color=#ff8000>UI " .. data.uiName .. " 包含动态节点，无法自动检测，建议手动检查。" .. dynamicNodeStr .. "</color>")
		end
	end

	for i, nodeData in pairs(data.nodes) do
		local node = UnityEngine.GameObject.Find(nodeData.path)

		if node == nil and not nodeData.isDynamic then
			logError("[FATAL ERROR] 找不到节点：" .. nodeData.path .. ", GuideSubID = " .. nodeData.id .. "。")
		end
	end

	if GuideChecker.CheckUIQueue.Size > 0 then
		GuideChecker.__CheckOneData()
	else
		GameEntry.LuaEvent:Unsubscribe(UIBecameVisibleEventArgs.EventId, GuideChecker.OnUIBecameVisible)
		GameEntry.LuaEvent:Unsubscribe(LoadSceneSuccessEventArgs.EventId, GuideChecker.OnLoadSceneSuccess)
		logError("<color=#ff8000>检查完毕</color>")
	end
end

function GuideChecker.OnLoadSceneSuccess(sender, args)
	GuideChecker.CurrentScene = tonumber(args.UserData)

	local data = GuideChecker.CheckUIQueue:Peek()

	if data.sceneId == GuideChecker.CurrentScene then
		GuideChecker.__CheckOneData()
	end
end

function GuideChecker.OnUIBecameVisible(sender, args)
	local data = GuideChecker.CheckUIQueue:Peek()

	if args.UIName == data.uiName then
		local frameTimer = FrameTimer.New(function()
			data = GuideChecker.CheckUIQueue:Dequeue()

			GuideChecker.__CheckNodes(data)
		end, 1)

		frameTimer:Start()
	end
end
