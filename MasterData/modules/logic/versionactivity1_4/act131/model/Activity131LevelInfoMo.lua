-- chunkname: @modules/logic/versionactivity1_4/act131/model/Activity131LevelInfoMo.lua

module("modules.logic.versionactivity1_4.act131.model.Activity131LevelInfoMo", package.seeall)

local Activity131LevelInfoMo = pureTable("Activity131LevelInfoMo")

function Activity131LevelInfoMo:ctor()
	self.episodeId = 0
	self.state = 0
	self.progress = 0
	self.act131Elements = {}
end

function Activity131LevelInfoMo:init(info)
	self.episodeId = info.episodeId
	self.state = info.state
	self.progress = info.progress
	self.act131Elements = {}

	for _, v in ipairs(info.act131Elements) do
		local elementMo = Activity131ElementMo.New()

		elementMo:init(v)
		table.insert(self.act131Elements, elementMo)
	end

	table.sort(self.act131Elements, Activity131LevelInfoMo.sortById)
end

function Activity131LevelInfoMo:updateInfo(info)
	if self.state ~= info.state then
		self.state = info.state

		Activity131Controller.instance:dispatchEvent(Activity131Event.FirstFinish, info.episodeId)
	end

	self.progress = info.progress
	self.act131Elements = {}

	for _, v in ipairs(info.act131Elements) do
		local elementMo = Activity131ElementMo.New()

		elementMo:init(v)
		table.insert(self.act131Elements, elementMo)
	end

	table.sort(self.act131Elements, Activity131LevelInfoMo.sortById)
end

function Activity131LevelInfoMo.sortById(a, b)
	return a.elementId < b.elementId
end

return Activity131LevelInfoMo
