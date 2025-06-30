-- chunkname: @IQIGame\\Module\\Scene\\SceneManager.lua

SceneManager = {
	IsProcessing = false
}

function SceneManager.ChangeScene(sceneId)
	if SceneManager.IsProcessing then
		return
	end

	SceneManager.IsProcessing = true

	GameEntry.LuaEvent:FireNow(nil, ChangeSceneEventArgs():Fill(sceneId))
end
