-- chunkname: @/tmp/or_script/lua_compile/cocos/cocosbuilder/CCBReaderLoad.lua

if cc.CCBReader == nil then
	return
end

ccb = ccb or {}

function CCBReaderLoad(strFilePath, proxy, owner)
	if proxy == nil then
		return nil
	end

	local ccbReader = proxy:createCCBReader()
	local node = ccbReader:load(strFilePath)

	if owner ~= nil then
		local ownerCallbackNames = ccbReader:getOwnerCallbackNames()
		local ownerCallbackNodes = ccbReader:getOwnerCallbackNodes()
		local ownerCallbackControlEvents = ccbReader:getOwnerCallbackControlEvents()

		for i = 1, table.getn(ownerCallbackNames) do
			local callbackName = ownerCallbackNames[i]
			local callbackNode = tolua.cast(ownerCallbackNodes[i], "cc.Node")

			if type(owner[callbackName]) == "function" then
				proxy:setCallback(callbackNode, owner[callbackName], ownerCallbackControlEvents[i])
			else
				print("Warning: Cannot find owner's lua function:" .. ":" .. callbackName .. " for ownerVar selector")
			end
		end

		local ownerOutletNames = ccbReader:getOwnerOutletNames()
		local ownerOutletNodes = ccbReader:getOwnerOutletNodes()

		for i = 1, table.getn(ownerOutletNames) do
			local outletName = ownerOutletNames[i]

			owner[outletName] = tolua.cast(ownerOutletNodes[i], "cc.Node")
		end
	end

	local nodesWithAnimationManagers = ccbReader:getNodesWithAnimationManagers()
	local animationManagersForNodes = ccbReader:getAnimationManagersForNodes()

	for i = 1, table.getn(nodesWithAnimationManagers) do
		local innerNode = tolua.cast(nodesWithAnimationManagers[i], "cc.Node")
		local animationManager = tolua.cast(animationManagersForNodes[i], "cc.CCBAnimationManager")
		local documentControllerName = animationManager:getDocumentControllerName()

		if documentControllerName == "" then
			-- block empty
		end

		if ccb[documentControllerName] ~= nil then
			ccb[documentControllerName].mAnimationManager = animationManager
		end

		local documentCallbackNames = animationManager:getDocumentCallbackNames()
		local documentCallbackNodes = animationManager:getDocumentCallbackNodes()
		local documentCallbackControlEvents = animationManager:getDocumentCallbackControlEvents()

		for i = 1, table.getn(documentCallbackNames) do
			local callbackName = documentCallbackNames[i]
			local callbackNode = tolua.cast(documentCallbackNodes[i], "cc.Node")

			if documentControllerName ~= "" and ccb[documentControllerName] ~= nil then
				if type(ccb[documentControllerName][callbackName]) == "function" then
					proxy:setCallback(callbackNode, ccb[documentControllerName][callbackName], documentCallbackControlEvents[i])
				else
					print("Warning: Cannot found lua function [" .. documentControllerName .. ":" .. callbackName .. "] for docRoot selector")
				end
			end
		end

		local documentOutletNames = animationManager:getDocumentOutletNames()
		local documentOutletNodes = animationManager:getDocumentOutletNodes()

		for i = 1, table.getn(documentOutletNames) do
			local outletName = documentOutletNames[i]
			local outletNode = tolua.cast(documentOutletNodes[i], "cc.Node")

			if ccb[documentControllerName] ~= nil then
				ccb[documentControllerName][outletName] = tolua.cast(outletNode, proxy:getNodeTypeName(outletNode))
			end
		end

		local keyframeCallbacks = animationManager:getKeyframeCallbacks()

		for i = 1, table.getn(keyframeCallbacks) do
			local callbackCombine = keyframeCallbacks[i]
			local beignIndex, endIndex = string.find(callbackCombine, ":")
			local callbackType = tonumber(string.sub(callbackCombine, 1, beignIndex - 1))
			local callbackName = string.sub(callbackCombine, endIndex + 1, -1)

			if callbackType == 1 and ccb[documentControllerName] ~= nil then
				local callfunc = cc.CallFunc:create(ccb[documentControllerName][callbackName])

				animationManager:setCallFuncForLuaCallbackNamed(callfunc, callbackCombine)
			elseif callbackType == 2 and owner ~= nil then
				local callfunc = cc.CallFunc:create(owner[callbackName])

				animationManager:setCallFuncForLuaCallbackNamed(callfunc, callbackCombine)
			end
		end

		local autoPlaySeqId = animationManager:getAutoPlaySequenceId()

		if autoPlaySeqId ~= -1 then
			animationManager:runAnimationsForSequenceIdTweenDuration(autoPlaySeqId, 0)
		end
	end

	return node
end

local function CCBuilderReaderLoad(strFilePath, proxy, owner)
	print("\n********** \n" .. "CCBuilderReaderLoad(strFilePath,proxy,owner)" .. " was deprecated please use " .. "CCBReaderLoad(strFilePath,proxy,owner)" .. " instead.\n**********")

	return CCBReaderLoad(strFilePath, proxy, owner)
end

rawset(_G, "CCBuilderReaderLoad", CCBuilderReaderLoad)
