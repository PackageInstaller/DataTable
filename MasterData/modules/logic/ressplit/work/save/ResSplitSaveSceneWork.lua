-- chunkname: @modules/logic/ressplit/work/save/ResSplitSaveSceneWork.lua

module("modules.logic.ressplit.work.save.ResSplitSaveSceneWork", package.seeall)

local ResSplitSaveSceneWork = class("ResSplitSaveSceneWork", BaseWork)

function ResSplitSaveSceneWork:onStart(context)
	local saveIds = {
		[13101] = true,
		[90001] = true,
		[501] = true,
		[601] = true,
		[101] = true
	}

	if ResSplitEnum.SplitAllScene then
		for sceneId, config in pairs(lua_scene.configDict) do
			if sceneId ~= 601 and saveIds[sceneId] == true then
				local levelCOs = SceneConfig.instance:getSceneLevelCOs(sceneId)

				for _, levelCO in ipairs(levelCOs) do
					ResSplitSaveHelper.addSceneRes(levelCO.id)
				end
			end
		end
	end

	self:onDone(true)
end

return ResSplitSaveSceneWork
