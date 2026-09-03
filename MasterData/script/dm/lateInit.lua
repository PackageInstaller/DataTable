-- chunkname: @/tmp/or_script/lua_compile/dm/lateInit.lua

local maxAvailableMemoryScale = 2

if DEBUG ~= 2 and app.getDevice then
	local totalMemorySize = app.getDevice():getTotalMemorySize() / 1024 / 1024

	if device.platform == "android" then
		GameConfigs.battleSceneMode = totalMemorySize < 7.2
		maxAvailableMemoryScale = math.ceil(totalMemorySize - 2)
	else
		GameConfigs.battleSceneMode = totalMemorySize < 1.2
		maxAvailableMemoryScale = math.ceil(totalMemorySize)
	end

	maxAvailableMemoryScale = maxAvailableMemoryScale < 1 and 1 or maxAvailableMemoryScale
	maxAvailableMemoryScale = maxAvailableMemoryScale > 3 and 3 or maxAvailableMemoryScale
end

local textureCache = cc.Director:getInstance():getTextureCache()

if textureCache.enableAutoGC ~= nil then
	textureCache:setInitAutoGCThreshold(maxAvailableMemoryScale * 100 * 1024 * 1024)
	textureCache:setMaxAutoGCThreshold(maxAvailableMemoryScale * 120 * 1024 * 1024)
	textureCache:setInitMemorySafetyZone(maxAvailableMemoryScale * 70 * 1024 * 1024)
	textureCache:setMaxMemorySafetyZone(maxAvailableMemoryScale * 90 * 1024 * 1024)
	textureCache:setMinAutoGCInterval(600)
	textureCache:setResetInterval(600)
	textureCache:setResidentFactor(5)
	textureCache:enableAutoGC()
end

local director = cc.Director:getInstance()
local view = director:getOpenGLView()

view:setMultipleTouchEnabled(true)

if GAME_EASY_DEBUG and GameConfigs.easyDebugProjectPath then
	local fileUtils = cc.FileUtils:getInstance()
	local searchPath = fileUtils:getSearchPaths()

	table.insert(searchPath, 1, GameConfigs.easyDebugProjectPath .. "/Resources")
	table.insert(searchPath, 1, GameConfigs.easyDebugProjectPath .. "/")
	fileUtils:setSearchPaths(searchPath)

	if GameConfigs.easyDebugLogPath then
		if not fileUtils:isDirectoryExist(GameConfigs.easyDebugLogPath) then
			fileUtils:createDirectory(GameConfigs.easyDebugLogPath)
		end

		local file = io.open(GameConfigs.easyDebugLogPath .. "log.txt", "w")

		if file then
			file:setvbuf("line")

			local oldPrint = _G.print

			function _G.print(...)
				local arg = {
					...
				}

				for i = 1, #arg do
					arg[i] = tostring(arg[i])
				end

				local str = table.concat(arg, ",")

				file:write(str .. "\n")
				oldPrint(...)
			end
		else
			print("打开easyDebugLog文件失败")
		end
	end

	if not GameConfigs.closeFileChangeListener then
		pcall(loadfile(GameConfigs.easyDebugProjectPath .. "/tools/EasyDebugTools/DevReloadUtil.lua"))
	end
end
