-- chunkname: @IQIGame\\Scene\\MemoryStory\\Controller\\MemoryStoryHeroController.lua

local MemoryStoryElementController = require("IQIGame.Scene.MemoryStory.Controller.MemoryStoryElementController")
local m = {}

m = extend(MemoryStoryElementController, m)

function m.New(elementId)
	local obj = Clone(m)

	obj:__OnInit(elementId)

	return obj
end

function m:__OnInit(elementId)
	self:__Init(elementId)
end

return m
