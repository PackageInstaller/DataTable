-- chunkname: @modules/logic/ressplit/work/ResSplitRoomWork.lua

module("modules.logic.ressplit.work.ResSplitRoomWork", package.seeall)

local ResSplitRoomWork = class("ResSplitRoomWork", BaseWork)

function ResSplitRoomWork:onStart(context)
	local dic = ResSplitConfig.instance:getAppIncludeConfig()
	local excludeBuildingIds = {}
	local excludeBlockPackageIds = {}
	local includeRoomTheme = {}

	for i, v in pairs(dic) do
		for n, themeId in pairs(v.roomTheme) do
			includeRoomTheme[themeId] = true
		end
	end

	local themeConfigList = RoomConfig.instance:getThemeConfigList()

	for _, cfg in pairs(themeConfigList) do
		if includeRoomTheme[cfg.id] ~= true then
			local building = string.splitToNumber(cfg.building, "|")
			local packages = string.splitToNumber(cfg.packages, "|")

			for _, id in pairs(building) do
				excludeBuildingIds[id] = true
			end

			for _, id in pairs(packages) do
				excludeBlockPackageIds[id] = true
			end
		end
	end

	local markSaveBlockIds = {}
	local saveAB = {}
	local unsaveAB = {}

	for id, packageDict in pairs(lua_block_package_data.packageDict) do
		for _, v in pairs(packageDict) do
			if excludeBlockPackageIds[id] == nil then
				markSaveBlockIds[v.defineId] = true
			elseif markSaveBlockIds[v.defineId] == nil then
				markSaveBlockIds[v.defineId] = false
			end
		end
	end

	local markSaveBlockBigIds = {}

	for id, v in pairs(markSaveBlockIds) do
		local config = RoomConfig.instance:getBlockDefineConfig(id)
		local bigId = string.split(config.prefabPath, "/")[1]

		markSaveBlockBigIds[bigId] = not not (v or tonumber(bigId) == nil)
	end

	for i, v in pairs(markSaveBlockBigIds) do
		local abName = "room/block/" .. i

		if v then
			saveAB[abName] = true

			ResSplitModel.instance:setExclude(ResSplitEnum.InnerRoomAB, abName, true)
		else
			unsaveAB[abName] = true

			ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, abName, true)
		end
	end

	for id, v in pairs(excludeBuildingIds) do
		local config = RoomConfig.instance:getBuildingConfig(id)
		local abName = ResUrl.getRoomRes(config.path)

		unsaveAB[abName] = true

		ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, abName, true)
	end

	local buildList = RoomConfig.instance:getBuildingConfigList()

	for _, config in pairs(buildList) do
		if not tabletool.indexOf(excludeBuildingIds, config.id) then
			local abName = ResUrl.getRoomRes(config.path)

			unsaveAB[abName] = true

			ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, abName, true)
		end
	end

	buildList = RoomConfig.instance:getAllBuildingSkinList()

	for _, config in pairs(buildList) do
		if not tabletool.indexOf(excludeBuildingIds, config.buildingId) then
			local abName = ResUrl.getRoomRes(config.path)

			unsaveAB[abName] = true

			ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, abName, true)
		end
	end

	buildList = RoomConfig.instance:getVehicleConfigList()

	for _, config in pairs(buildList) do
		local abName = ResUrl.getRoomRes(config.path)

		unsaveAB[abName] = true

		ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, abName, true)
	end

	buildList = lua_room_skin.configList

	for _, config in pairs(lua_room_skin.configList) do
		if config.itemId ~= 0 then
			local abName = config.model

			unsaveAB[abName] = true

			ResSplitModel.instance:setExclude(ResSplitEnum.OutRoomAB, abName, true)
		end
	end

	local arr = SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.FullAssetRootDir .. "/scenes/m_s07_xiaowu/prefab", true)
	local fullAssetRootDir = SLFramework.FileHelper.GetUnityPath(SLFramework.FrameworkSettings.FullAssetRootDir)

	for i = 0, arr.Length - 1 do
		local path = arr[i]

		if not string.find(path, ".meta") and not string.find(path, "scenes/m_s07_xiaowu/prefab/block/") then
			local index = string.find(path, "scenes/m_s07_xiaowu/prefab")

			path = string.sub(path, index, string.len(path))

			if unsaveAB[path] == nil then
				saveAB[path] = true

				ResSplitModel.instance:setExclude(ResSplitEnum.InnerRoomAB, path, true)
			end
		end
	end

	self:onDone(true)
end

return ResSplitRoomWork
