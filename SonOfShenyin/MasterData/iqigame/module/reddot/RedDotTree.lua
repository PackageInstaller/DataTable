-- chunkname: @IQIGame\\Module\\RedDot\\RedDotTree.lua

RedDotTree = RedDotTree or {}

local this = RedDotTree

RedDotTree.NodeData = {}

function RedDotTree.Init()
	for rdId, _ in pairs(CfgRedDotTable) do
		RedDotTree.NodeData[rdId] = RedDotNode.New(rdId)
	end

	for rdId, cfg in pairs(CfgRedDotTable) do
		local node = RedDotTree.NodeData[rdId]

		if cfg.ParentID ~= 0 then
			node.parentNode = RedDotTree.NodeData[cfg.ParentID]
		end
	end
end

function RedDotTree.Shutdown()
	RedDotTree.NodeData = {}
	this.root = nil
end

function RedDotTree.ChangeRedDotCnt(rdId, delta, isNotifyServer)
	local node = RedDotTree.NodeData[rdId]

	if node == nil then
		logError("红点系统 - ChangeRedDotCnt：rdId={0} is invalid.", rdId)

		return
	end

	node.redDotCnt = node.redDotCnt + delta

	node:refresh()

	if node.parentNode ~= nil then
		RedDotTree.ChangeRedDotCnt(node.parentNode.cid, delta, isNotifyServer)
	end
end

function RedDotTree.SetCallBack(rdId, obj)
	local node = RedDotTree.NodeData[rdId]

	if node == nil then
		logError("红点系统 - SetCallBack：rdId={0} is invalid.", rdId)

		return
	end

	if node.objs[obj:GetInstanceID()] == nil then
		node.objs[obj:GetInstanceID()] = obj

		node:refresh()
	else
		logError("红点系统 - SetCallBack：CID = {0} is existent.", rdId)

		return
	end
end

function RedDotTree.RemoveCallBack(rdId, obj)
	local node = RedDotTree.NodeData[rdId]

	if node == nil then
		logError("红点系统 - SetCallBack：rdId={0} is invalid.", rdId)

		return
	end

	node.objs[obj:GetInstanceID()] = nil
end
