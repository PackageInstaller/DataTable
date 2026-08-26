-- chunkname: @modules/logic/ressplit/work/ResSplitSceneWork.lua

module("modules.logic.ressplit.work.ResSplitSceneWork", package.seeall)

local ResSplitSceneWork = class("ResSplitSceneWork", BaseWork)

function ResSplitSceneWork:onStart(context)
	local saveIds = {
		[13101] = true,
		[90001] = true,
		[501] = true,
		[601] = true,
		[101] = true
	}

	if ResSplitEnum.SplitAllScene then
		for sceneId, config in pairs(lua_scene.configDict) do
			if sceneId ~= 601 then
				local isExcludeScene = saveIds[sceneId] ~= true
				local levelCOs = SceneConfig.instance:getSceneLevelCOs(sceneId)

				for _, levelCO in ipairs(levelCOs) do
					ResSplitHelper.addSceneRes(levelCO.id, isExcludeScene)
				end
			end
		end
	end

	local arr = SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.FullAssetRootDir .. "/scenes/m_s06_summon", true)

	for i = 0, arr.Length - 1 do
		local path = arr[i]

		if not string.find(path, ".meta") and string.find(path, ".prefab") then
			local index = string.find(path, "scenes/m_s06_summon")

			path = string.sub(path, index, string.len(path))

			ResSplitModel.instance:setExclude(ResSplitEnum.InnerSceneAB, path, true)
			ResSplitModel.instance:setExclude(ResSplitEnum.OutSceneAB, path, false)
		end
	end

	local assLen = string.len(SLFramework.FrameworkSettings.AssetRootDir) + 1
	local allScenePrefab = SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.FullAssetRootDir .. "/scenes/")

	for i = 0, allScenePrefab.Length - 1 do
		local path = allScenePrefab[i]

		if not string.find(path, ".meta") and string.find(path, ".prefab") and string.find(path, "Assets/ZResourcesLib/scenes/v") then
			local index = string.find(path, SLFramework.FrameworkSettings.AssetRootDir)
			local p = string.sub(path, index + assLen, string.len(path))

			ResSplitModel.instance:setExclude(ResSplitEnum.OutSceneAB, p, true)
		end
	end

	self:onDone(true)
end

return ResSplitSceneWork
