-- chunkname: @modules/logic/season/model/Activity104EpisodeMo.lua

local Activity104EpisodeMo = pureTable("Activity104EpisodeMo")

function Activity104EpisodeMo:ctor()
	self.layer = 0
	self.state = 0
	self.readAfterStory = false
end

function Activity104EpisodeMo:init(info)
	self.layer = info.layer
	self.state = info.state
	self.readAfterStory = info.readAfterStory
end

function Activity104EpisodeMo:reset(info)
	self.layer = info.layer
	self.state = info.state
	self.readAfterStory = info.readAfterStory
end

function Activity104EpisodeMo:markStory(mark)
	self.readAfterStory = mark
end

return Activity104EpisodeMo
