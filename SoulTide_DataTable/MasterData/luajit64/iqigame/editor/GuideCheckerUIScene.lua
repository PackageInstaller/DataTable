-- chunkname: @IQIGame\\Editor\\GuideCheckerUIScene.lua

local m = {}

m.UISceneMap = {}

function m.GetScene(uiName)
	local sceneId
	local cfgData = GuideChecker.UICfgMap[uiName]

	if cfgData ~= nil and cfgData.DefaultSceneID ~= 0 then
		sceneId = cfgData.DefaultSceneID
	else
		sceneId = m.UISceneMap[uiName]
	end

	if sceneId == nil then
		sceneId = SceneID.MainCity
	end

	return sceneId
end

return m
