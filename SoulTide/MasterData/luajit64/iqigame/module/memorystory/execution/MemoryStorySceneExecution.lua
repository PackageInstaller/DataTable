-- chunkname: @IQIGame\\Module\\MemoryStory\\Execution\\MemoryStorySceneExecution.lua

local Execution = {}

Execution[MemoryStoryExecutionModule.ExecuteType.PlayEffect] = function(element, cfg)
	return
end
Execution[MemoryStoryExecutionModule.ExecuteType.Transfer] = function(element, cfg)
	MemoryStoryModule.StopHeroMove()

	local pointId = tonumber(cfg.Parameter[1])
	local forward = tonumber(cfg.Parameter[2]) == 1 and true or false

	MemoryStoryModule.TransferPoint(pointId, forward)
end
Execution[MemoryStoryExecutionModule.ExecuteType.ChangeScene] = function(element, cfg)
	local sceneId = tonumber(cfg.Parameter[1])

	MemoryStoryModule.ChangeStoryScene(sceneId)
end
Execution[MemoryStoryExecutionModule.ExecuteType.StoryEnd] = function(element, cfg)
	MemoryStoryModule.StopHeroMove()

	local cid = tonumber(cfg.Parameter[1])

	if MemoryStoryModule.MemoryEntryType == MemoryStoryModule.EntryType.Memory and MemoryModule.currentSoulChapterInfo.isGetReward == false then
		MemoryModule.RequestExperienceMemory(MemoryModule.currentSoulChapterInfo.cid)
	end

	MemoryStoryModule.OnStoryEnd(cid)
end
Execution[MemoryStoryExecutionModule.ExecuteType.RequestExperienceMemory] = function(element, cfg)
	local cid = tonumber(cfg.Parameter[1])

	MemoryModule.RequestExperienceMemory(cid)
end
Execution[MemoryStoryExecutionModule.ExecuteType.AddElement] = function(element, cfg)
	local elementId = tonumber(cfg.Parameter[1])

	MemoryStoryModule.AddElement(elementId)
end
Execution[MemoryStoryExecutionModule.ExecuteType.RemoveElement] = function(element, cfg)
	local elementId = tonumber(cfg.Parameter[1])

	MemoryStoryModule.RemoveElement(elementId)
end
Execution[MemoryStoryExecutionModule.ExecuteType.PlayAnimation] = function(element, cfg)
	local elementId = tonumber(cfg.Parameter[1])
	local anim = tostring(cfg.Parameter[2])
	local delay = tonumber(cfg.Parameter[3])
	local loop = tonumber(cfg.Parameter[4]) == 1 and true or false

	MemoryStoryModule.PlayAnimation(elementId, anim, delay, loop)
end
Execution[MemoryStoryExecutionModule.ExecuteType.Outline] = function(element, cfg)
	local elementId = tonumber(cfg.Parameter[1])
	local active = tonumber(cfg.Parameter[2]) == 1 and true or false

	MemoryStoryModule.SetElementOutlineActive(elementId, active)
end
Execution[MemoryStoryExecutionModule.ExecuteType.OutLineLight] = function(element, cfg)
	local elementId = tonumber(cfg.Parameter[1])
	local active = tonumber(cfg.Parameter[2]) == 1 and true or false

	MemoryStoryModule.SetElementOutlineLightActive(elementId, active)
end
Execution[MemoryStoryExecutionModule.ExecuteType.PlayElementEffect] = function(element, cfg)
	local elementId = tonumber(cfg.Parameter[1])
	local effectCid = tonumber(cfg.Parameter[2])
	local delay = tonumber(cfg.Parameter[3])

	MemoryStoryModule.PlayElementEffect(elementId, effectCid, delay)
end
Execution[MemoryStoryExecutionModule.ExecuteType.StopElementEffect] = function(element, cfg)
	local elementId = tonumber(cfg.Parameter[1])
	local effectCid = tonumber(cfg.Parameter[2])

	MemoryStoryModule.StopElementEffect(elementId, effectCid)
end
Execution[MemoryStoryExecutionModule.ExecuteType.PlayerSceneEffect] = function(element, cfg)
	local effectCid = tonumber(cfg.Parameter[1])
	local delay = tonumber(cfg.Parameter[2])

	MemoryStoryModule.PlaySceneEffect(effectCid, delay)
end
Execution[MemoryStoryExecutionModule.ExecuteType.StopSceneEffect] = function(element, cfg)
	local effectCid = tonumber(cfg.Parameter[1])

	MemoryStoryModule.StopSceneEffect(effectCid)
end
Execution[MemoryStoryExecutionModule.ExecuteType.HeroAutoMove] = function(element, cfg)
	local xDir = tonumber(cfg.Parameter[1])
	local yDir = tonumber(cfg.Parameter[2])

	MemoryStoryModule.AutoMoveHero(Vector2.New(xDir, yDir))
end
Execution[MemoryStoryExecutionModule.ExecuteType.CameraLookAt] = function(element, cfg)
	local x = tonumber(cfg.Parameter[1])
	local y = tonumber(cfg.Parameter[2])
	local interpolation = tonumber(cfg.Parameter[3])

	MemoryStoryModule.CameraLookAt(Vector2.New(x, y), interpolation)
end
Execution[MemoryStoryExecutionModule.ExecuteType.CameraLookAtHero] = function(element, cfg)
	local interpolation = tonumber(cfg.Parameter[1])

	MemoryStoryModule.CameraLookAtHero(interpolation)
end
Execution[MemoryStoryExecutionModule.ExecuteType.Transfiguration] = function(element, cfg)
	local elementId = tonumber(cfg.Parameter[1])
	local entityId = tonumber(cfg.Parameter[2])

	MemoryStoryModule.Transfiguration(elementId, entityId)
end

return Execution
