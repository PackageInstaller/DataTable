-- chunkname: @IQIGame\\UIExternalApi\\MemoryStorySceneMainUIApi.lua

MemoryStorySceneMainUIApi = BaseLangApi:Extend()

function MemoryStorySceneMainUIApi:Init()
	self:RegisterApi("sceneName", self.GetSceneName)
	self:RegisterApi("GetTaskTitleText", self.GetTaskTitleText)
	self:RegisterApi("GetTaskTargetText", self.GetTaskTargetText)
	self:RegisterApi("GetTaskProgressText", self.GetTaskProgressText)
end

function MemoryStorySceneMainUIApi:GetSceneName(name)
	return name
end

function MemoryStorySceneMainUIApi:GetTaskTitleText(titleText, finish)
	return titleText
end

function MemoryStorySceneMainUIApi:GetTaskTargetText(targetText, finish)
	return targetText
end

function MemoryStorySceneMainUIApi:GetTaskProgressText(curProgress, totalProgress)
	return tostring(curProgress) .. "/" .. tostring(totalProgress)
end

MemoryStorySceneMainUIApi:Init()
