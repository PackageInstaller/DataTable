-- chunkname: @/tmp/or_script/lua_compile/dm/utils/CommonUtils.lua

module("CommonUtils", package.seeall)

local cjson = require("cjson.safe")

function uploadData(data, callback)
	data.url = data.url or "http:192.168.1.79/saveLog.php"
	data.key = data.key or ""

	local postData = "key=" .. tostring(data.key)

	if data.type then
		postData = postData .. "&type=" .. tostring(data.type)
	end

	if data.rid then
		postData = postData .. "&rid=" .. tostring(data.rid)
	end

	postData = postData .. "&content=" .. tostring(data.content)

	local xhr = cc.XMLHttpRequest:new()

	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING

	xhr:open("POST", data.url)

	local function httpResponse()
		dump(xhr.response, "uploadData response")

		if callback then
			callback(xhr.response)
		end
	end

	xhr:registerScriptHandler(httpResponse)
	xhr:send(postData)
end

function getData(data, callback)
	data.url = data.url or "http:192.168.1.79/getLog.php"
	data.key = data.key or ""

	local postData = "key=" .. tostring(data.key)

	if data.type then
		postData = postData .. "&type=" .. tostring(data.type)
	end

	if data.rid then
		postData = postData .. "&rid=" .. tostring(data.rid)
	end

	local xhr = cc.XMLHttpRequest:new()

	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING

	xhr:open("POST", data.url)

	local function httpResponse()
		if callback then
			callback(xhr.response)
		end
	end

	xhr:registerScriptHandler(httpResponse)
	xhr:send(postData)
end

function getParticleByName(name)
	return (cc.ParticleSystemQuad:create(string.format("asset/particle/%s.plist", name)))
end

function getSavePathByName(imageName)
	local fileUtils = cc.FileUtils:getInstance()
	local savePath = fileUtils:getWritablePath() .. "localStorage"
	local saveFileName = savePath .. "/" .. imageName

	if fileUtils:isFileExist(saveFileName) then
		return saveFileName
	end

	return nil
end

function captureNode(startNode, scale, formate, imageName, imageFormate)
	local size = startNode:getContentSize()
	local oldScale = startNode:getScale()
	local oldPos = cc.p(startNode:getPosition())
	local oldAnchor = startNode:getAnchorPoint()

	startNode:setAnchorPoint(cc.p(0, 0))
	startNode:setPosition(0, 0)

	scale = scale or oldScale

	startNode:setScale(scale)
	cc.Director:getInstance():setNextDeltaTimeZero(true)

	local rtx = cc.RenderTexture:create(size.width * scale, size.height * scale, formate or cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)

	rtx:beginWithClear(0, 0, 0, 0)
	startNode:visit()
	rtx:endToLua()

	local texture = rtx:getSprite():getTexture()
	local sprite = cc.Sprite:createWithTexture(texture)

	sprite:setFlippedY(true)

	local fileUtils = cc.FileUtils:getInstance()

	if imageName then
		local savePath = fileUtils:getWritablePath() .. "localStorage"
		local saveFileName = "localStorage" .. "/" .. imageName

		if not fileUtils:isDirectoryExist(savePath) then
			fileUtils:createDirectory(savePath)
		end

		rtx:saveToFile(saveFileName, imageFormate or cc.IMAGE_FORMAT_JPEG, imageFormate == cc.IMAGE_FORMAT_PNG)
		print("save image fath:", savePath .. "/" .. imageName)
	end

	app.render()
	startNode:setAnchorPoint(oldAnchor)
	startNode:setPosition(oldPos)
	startNode:setScale(oldScale)

	return sprite
end

function renderTexture(data)
	local node = data.node

	if not data.fileName then
		local fileName

		if not data.size then
			local size = node:getContentSize()
			local rtx = cc.RenderTexture:create(size.width, size.height, data.formate or cc.TEXTURE2_D_PIXEL_FORMAT_RGB_A8888)

			rtx:beginWithClear(0, 0, 0, 0)
			node:visit()
			rtx:endToLua()

			local fileUtils = cc.FileUtils:getInstance()
			local savePath = fileUtils:getWritablePath() .. "localStorage"
			local saveFileName = "localStorage" .. "/" .. fileName
			local savePathName = savePath .. "/" .. fileName

			cc.Director:getInstance():getTextureCache():removeTextureForKey(savePathName)

			if fileUtils:isFileExist(savePathName) then
				fileUtils:removeFile(savePathName)
			end

			print(saveFileName, "renderTexture fath:")

			if fileName then
				if not fileUtils:isDirectoryExist(savePath) then
					fileUtils:createDirectory(savePath)
				end

				local status = rtx:saveToFile(saveFileName, data.format or cc.IMAGE_FORMAT_JPEG, data.format == cc.IMAGE_FORMAT_PNG)

				if status then
					if data.callback then
						data.callback(savePathName)
					end
				else
					print("save image error ")
				end
			end
		end
	end
end

function captureNodeSystem(data)
	if not data.fileName then
		local fileName = "temp.png"

		if not data.scale then
			local scale = 1
			local fileUtils = cc.FileUtils:getInstance()
			local savePath = fileUtils:getWritablePath() .. "localStorage"
			local saveFileName = savePath .. "/" .. fileName

			cc.Director:getInstance():getTextureCache():removeTextureForKey(saveFileName)

			if fileUtils:isFileExist(saveFileName) then
				fileUtils:removeFile(saveFileName)
			end

			print(saveFileName, "captureNodeSystem path:")

			local image = cc.utils:captureNode(data.node, scale)

			if image and fileName then
				if not fileUtils:isDirectoryExist(savePath) then
					fileUtils:createDirectory(savePath)
				end

				local status = image:saveToFile(saveFileName)

				if status then
					if data.callback then
						data.callback(savePath, saveFileName)
					end
				else
					print("save image error ")
				end
			end
		end
	end
end

function captureScreen(data)
	if not data.fileName then
		local fileName = "temp.png"
		local fileUtils = cc.FileUtils:getInstance()
		local savePath = fileUtils:getWritablePath()
		local fileName = "localStorage" .. "/" .. fileName
		local saveFileName = savePath .. "/" .. fileName

		cc.Director:getInstance():getTextureCache():removeTextureForKey(saveFileName)
		print(saveFileName, "captureScreen path:")
		cc.utils:captureScreen(function(succeed, outputFile)
			if succeed then
				if data.callback then
					data.callback(saveFileName)
				end
			else
				print("captureScreen error")
			end
		end, fileName)
	end
end

function convertToBlurSprite(sprite, blurRadius, sampleNum, scale, noDouble)
	CustomShaderUtils.setBlurToNode(sprite, blurRadius or 8, sampleNum or 4)

	local formate = sprite:getTexture():getPixelFormat()
	local blurSprite = captureNode(sprite, scale or 0.5, formate)

	if not noDouble then
		CustomShaderUtils.setBlurToNode(blurSprite, blurRadius or 8, sampleNum or 4)

		blurSprite = captureNode(blurSprite, 1, formate)
	end

	local scaleTo = sprite:getContentSize().width * sprite:getScaleX() / (blurSprite:getContentSize().width * blurSprite:getScaleX())

	blurSprite:setScale(scaleTo)
	blurSprite:setName(sprite:getName())
	blurSprite:setLocalZOrder(sprite:getLocalZOrder())
	blurSprite:setPosition(sprite:getPosition())
	blurSprite:setAnchorPoint(sprite:getAnchorPoint())
	blurSprite:setColor(sprite:getColor())
	blurSprite:setRotation(sprite:getRotation())
	blurSprite:setSkewX(sprite:getSkewX())
	blurSprite:setSkewY(sprite:getSkewY())
	blurSprite:setOpacity(sprite:getOpacity())
	blurSprite:setBlendMode(sprite:getBlendMode())
	sprite:getParent():addChild(blurSprite)
	sprite:removeFromParent()

	return blurSprite
end

function findChild(levelRoot, name)
	local target = levelRoot:getChildByName(name)

	if target then
		return target
	end

	local childs = levelRoot:getChildren()

	for i = 1, #childs do
		local child = childs[i]

		target = findChild(child, name)

		if target then
			return target
		end
	end
end

function runActionEffect(actionNode, actionNodeName, csbName, animationsName, needloop, imagePath)
	local fullpath = "asset/ui/" .. csbName .. ".csb"
	local node = cc.CSLoader:createNode(fullpath)
	local action = cc.CSLoader:createTimeline(fullpath)
	local component = node:getChildByFullName(actionNodeName):getComponent("ComExtensionData")
	local actionTag = component:getActionTag()
	local actionNodeComponent = actionNode:getComponent("ComExtensionData")

	if not actionNodeComponent then
		actionNodeComponent = ccs.ComExtensionData:create()

		actionNode:addComponent(actionNodeComponent)
	end

	actionNodeComponent:setActionTag(actionTag)
	actionNode:runAction(action)

	needloop = needloop or false

	if animationsName then
		action:play(animationsName, needloop)
	else
		action:gotoFrameAndPlay(0, needloop)
	end

	if imagePath then
		node:getChildByFullName(actionNodeName):loadTextureNormal(imagePath, ccui.TextureResType.plistType)
		node:getChildByFullName(actionNodeName):loadTexturePressed(imagePath, ccui.TextureResType.plistType)
	end
end

function runActionEffectByRootNode(rootNode, csbName, animationsName)
	local fullpath = "asset/ui/" .. csbName .. ".csb"
	local node = cc.CSLoader:createNode(fullpath)
	local action = cc.CSLoader:createTimeline(fullpath)
	local allChilds = {
		node
	}
	local getAllChilds

	function getAllChilds(cache, tempNode)
		local childs = tempNode:getChildren()

		for i = 1, #childs do
			table.insert(cache, childs[i])
			getAllChilds(cache, childs[i])
		end
	end

	getAllChilds(allChilds, node)

	for i = 1, #allChilds do
		local child = allChilds[i]
		local childName = child:getName()
		local sameNameNode = cc.utils:findChildByNameRecursively(rootNode, childName)

		if sameNameNode then
			local component = child:getComponent("ComExtensionData")
			local actionTag = component:getActionTag()
			local actionNodeComponent = sameNameNode:getComponent("ComExtensionData")

			if not actionNodeComponent then
				actionNodeComponent = ccs.ComExtensionData:create()

				sameNameNode:addComponent(actionNodeComponent)
			end

			actionNodeComponent:setActionTag(actionTag)
		end
	end

	rootNode:runAction(action)

	if animationsName then
		action:play(animationsName, false)
	else
		action:gotoFrameAndPlay(0, false)
	end
end

function dumpObjTypeByRootNode(rootNode, log)
	log = log or {}

	local childs = rootNode:getChildren()

	for i = 1, #childs do
		local type = tolua.type(childs[i])

		if not log[type] then
			log[type] = true

			print("节点类型：", childs[i]:getName(), type, childs[i]:isCascadeOpacityEnabled())
			dumpObjTypeByRootNode(childs[i], log)
		end
	end
end

function foreachNodeDescendant(rootNode, callback)
	callback(rootNode)

	local childs = rootNode:getChildren()

	for i = 1, #childs do
		foreachNodeDescendant(childs[i], callback)
	end
end

function getCountNodeOfRootNode(rootNode)
	rootNode = rootNode or cc.Director:getInstance():getRunningScene()

	local baseNumber = 0
	local childs = rootNode:getChildren()

	baseNumber = baseNumber + #childs

	for i = 1, #childs do
		baseNumber = baseNumber + getCountNodeOfRootNode(childs[i])
	end

	return baseNumber
end

function saveDataToLocalByKey(data, key)
	assert(key, "必须输入存储数据的key值")

	local dataStr = cjson.encode(data)
	local fileUtils = cc.FileUtils:getInstance()

	if dataStr then
		local savePath = fileUtils:getWritablePath() .. "localStorage"
		local saveFileName = savePath .. "/" .. key

		if not fileUtils:isDirectoryExist(savePath) then
			fileUtils:createDirectory(savePath)
		end

		local file = io.open(saveFileName, "w")

		if file then
			file:write(dataStr)
			file:close()
			print("存储数据成功", saveFileName)
		else
			print("打开文件错误,存储数据失败")
		end
	end
end

function getDataFromLocalByKey(key)
	assert(key, "必须输入数据的key值")

	local fileUtils = cc.FileUtils:getInstance()
	local savePath = fileUtils:getWritablePath() .. "localStorage"
	local saveFileName = savePath .. "/" .. key

	if fileUtils:isFileExist(saveFileName) then
		local file = io.open(saveFileName, "r")

		if not file then
			print("未找到相应的数据")

			return
		end

		local dataStr = file:read("*a")

		file:close()

		if dataStr then
			return cjson.decode(dataStr)
		else
			print("读取文件失败")
		end
	end

	return nil
end

function getPathByType(type, name)
	if type == "SCENE" then
		return "asset/scene/" .. name
	elseif type == "STORY_ROOT" then
		return "asset/story/" .. name
	elseif type == "STORY_FACE" then
		return "asset/story/face/" .. name
	elseif type == "STORY_ALPHA" then
		return "asset/sceneStory/" .. name
	end

	return name
end

function bindNodeToActionNode(nodeToActionNodeMap, dependNode)
	for k, v in pairs(nodeToActionNodeMap) do
		local node = k
		local targetNode = v

		targetNode.originalPos = cc.p(targetNode:getPosition())
		targetNode.originalScaleX = targetNode:getScaleX()
		targetNode.originalScaleY = targetNode:getScaleY()
		node.originalPos = cc.p(node:getPosition())
		node.originalScaleX = node:getScaleX()
		node.originalScaleY = node:getScaleY()
		node.originalColor = node:getColor()
		node.originalSkewX = node:getSkewX()
		node.originalSkewY = node:getSkewY()
		node.originalRotationSkewX = node:getRotationSkewX()
		node.originalRotationSkewY = node:getRotationSkewY()
		node.originalOpacity = node:getOpacity()
		node.originalColorTransform = node:getColorTransform()
		node.originalVisible = node:isVisible()
		node.originalBrightness = node:getBrightness()
		node.originalContrast = node:getContrast()
		node.originalSaturation = node:getSaturation()
		node.originalHue = node:getHue()
		node.originalBlendMode = node:getBlendMode()
	end

	local action

	local function startBind()
		if action then
			dependNode:stopAction(action)
		end

		local function refresh()
			for k, v in pairs(nodeToActionNodeMap) do
				local node = k
				local targetNode = v

				if not tolua.isnull(k) and not tolua.isnull(v) then
					local pos = cc.pAdd(node.originalPos, cc.pSub(cc.p(targetNode:getPosition()), targetNode.originalPos))

					node:setPosition(pos)
					node:setSkewX(targetNode:getSkewX())
					node:setSkewY(targetNode:getSkewY())
					node:setRotationSkewY(targetNode:getRotationSkewY())
					node:setRotationSkewX(targetNode:getRotationSkewX())
					node:setScaleX(node.originalScaleX * targetNode:getScaleX())
					node:setScaleY(node.originalScaleY * targetNode:getScaleY())
					node:setColor(targetNode:getColor())
					node:setOpacity(targetNode:getOpacity())
					node:setColorTransform(targetNode:getColorTransform())
					node:setVisible(node.originalVisible and targetNode:isVisible())
					node:setBrightness(targetNode:getBrightness())
					node:setContrast(targetNode:getContrast())
					node:setSaturation(targetNode:getSaturation())
					node:setHue(targetNode:getHue())
					node:setBlendMode(targetNode:getBlendMode())
				end
			end
		end

		action = schedule(dependNode, refresh, 0.03333333333333333)

		refresh()
	end

	local function stopBind(recover)
		if recover then
			for k, v in pairs(nodeToActionNodeMap) do
				local node = k

				node:setPosition(node.originalPos)
				node:setSkewX(node.originalScaleX)
				node:setSkewY(node.originalScaleY)
				node:setRotationSkewY(node.originalRotationSkewX)
				node:setRotationSkewX(node.originalRotationSkewY)
				node:setScaleX(node.originalScaleX)
				node:setScaleY(node.originalScaleY)
				node:setColor(node.originalColor)
				node:setOpacity(node.originalOpacity)
				node:setColorTransform(node.originalColorTransform)
				node:setVisible(node.originalVisible)
				node:setBrightness(node.originalBrightness)
				node:setContrast(node.originalContrast)
				node:setSaturation(node.originalSaturation)
				node:setHue(node.originalHue)
				node:setBlendMode(node.originalHue)
			end
		end

		if action then
			dependNode:stopAction(action)

			action = nil
		end
	end

	return startBind, stopBind
end

function uploadDataToBugly(title, dataStr)
	if app.pkgConfig.enableBugTracer ~= false then
		local curVersion = app:getAssetsManager():getCurrentVersion()

		if curVersion <= 0 then
			curVersion = "dev"
		end

		if device.platform ~= "mac" and device.platform ~= "windows" then
			dpsBugTracer.reportLuaError("[" .. curVersion .. "] LUA ERROR: " .. title, "", dataStr)
		end
	end

	if DEBUG == 2 or app.pkgConfig.showLuaError == 1 then
		app.showMessageBox(dataStr, title)
	end
end

function playMovieClipByTimes(anim, times, callback, isRemove)
	local num = 0

	anim:addEndCallback(function(cid, mc)
		num = num + 1

		if num == times then
			mc:stop()

			if isRemove then
				mc:removeFromParent(true)
			end

			if callback then
				callback()
			end
		end
	end)
end

function playSpineByTimes(anim, times, name, callback, isRemove)
	local num = 0

	anim:playAnimation(0, name, true)

	if times == -1 then
		return
	end

	anim:unregisterSpineEventHandler(sp.EventType.ANIMATION_COMPLETE)
	anim:registerSpineEventHandler(function(event)
		if event.animation ~= name then
			anim:unregisterSpineEventHandler(sp.EventType.ANIMATION_COMPLETE)

			return
		end

		if event.type == "complete" then
			num = num + 1

			if num == times then
				anim:unregisterSpineEventHandler(sp.EventType.ANIMATION_COMPLETE)

				if isRemove then
					anim:removeFromParent(true)
				end

				if callback then
					callback()
				end
			end
		end
	end, sp.EventType.ANIMATION_COMPLETE)
end

function GetSwitch(switchKey)
	return GameConfigs[switchKey] ~= false
end

function GetSwitchString(switchKey)
	if GameConfigs[switchKey] ~= nil then
		return tostring(GameConfigs[switchKey])
	else
		return ""
	end
end

function GetPurchaseCD()
	local cd = tonumber(GameConfigs.shop_purchase_cd)

	if not cd then
		return 0
	end

	return cd
end

function GetDeliverCD()
	local cd = tonumber(GameConfigs.shop_deliver_cd)

	if not cd then
		return 0
	end

	return cd
end

function randomByWeight(weightList, dataList)
	local list = {}

	for i = 1, #weightList do
		list[#list + 1] = {
			index = i,
			value = weightList[i]
		}
	end

	table.sort(list, function(a, b)
		return a.value < b.value
	end)

	local sum = 0

	for i = 1, #list do
		sum = sum + list[i].value
		list[i].sum = sum
	end

	local remoteTimeMillis = DmGame:getInstance()._injector:getInstance("GameServerAgent"):remoteTimeMillis()
	local random = Random:new(remoteTimeMillis)
	local idx = random:random(1, sum)
	local index = 1

	for i = 1, #list do
		if idx <= list[i].sum then
			index = list[i].index

			break
		end
	end

	return dataList[index], index
end

function SetServerRegion(region)
	cc.UserDefault:getInstance():setStringForKey(UserDefaultKey.kLocalRegionServer, region)
	cc.UserDefault:getInstance():flush()
end

function GetServerRegion()
	local region = cc.UserDefault:getInstance():getStringForKey(UserDefaultKey.kLocalRegionServer)

	if not region or region == "" then
		local localUTC = TimeUtil:getLocalUTC()

		region = localUTC >= -11 and localUTC <= -2 and "NA" or localUTC >= -1 and localUTC <= 4 and "EU" or "AS"

		cc.UserDefault:getInstance():setStringForKey(UserDefaultKey.kLocalRegionServer, region)
	end

	local globalServer = ParseGlobalServer()

	if type(globalServer) == "table" then
		if not globalServer[region] then
			region = table.keys(globalServer)[1]
		end

		if GameConfigs.fn_europe_region_select and globalServer[GameConfigs.fn_europe_region_select] then
			region = GameConfigs.fn_europe_region_select
		end
	end

	return region
end

function ParseGlobalServer()
	if not GameConfigs.webApiRoot then
		local globalServer = GameConfigs.globalSever
		local serverData = cjson.decode(globalServer)

		globalServer = serverData or globalServer

		return globalServer
	end
end

function GetGlobalServer()
	local globalServer = ParseGlobalServer()

	if not globalServer then
		return nil
	end

	if type(globalServer) == "string" then
		return globalServer
	end

	local region = CommonUtils.GetServerRegion()

	return globalServer[region]
end
