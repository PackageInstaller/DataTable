-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/model/GalleryMemory.lua

GalleryMemory = class("GalleryMemory", objectlua.Object, _M)

GalleryMemory:has("_id", {
	is = "rw"
})
GalleryMemory:has("_status", {
	is = "rw"
})
GalleryMemory:has("_date", {
	is = "rw"
})
GalleryMemory:has("_lockTip", {
	is = "rw"
})

function GalleryMemory:initialize(id, owner)
	super.initialize(self)

	self._id = id
	self._config = nil
	self._status = 0
	self._date = ""
	self._lockTip = ""
end

function GalleryMemory:sync(data)
	if data.finishTime then
		self._date = data.finishTime
	end

	if data.memoryStatus then
		self._status = data.memoryStatus
	end
end

function GalleryMemory:setConfig()
	self._config = self._config or ConfigReader:requireRecordById("GalleryMemory", self._id)
end

function GalleryMemory:getTitle()
	self:setConfig()

	return Strings:get(self._config.Name) or ""
end

function GalleryMemory:getENTitle()
	self:setConfig()

	return Strings:get(self._config.Englishname) or ""
end

function GalleryMemory:getDesc()
	self:setConfig()

	return Strings:get(self._config.Desc)
end

function GalleryMemory:getNumber()
	self:setConfig()

	return self._config.Num
end

function GalleryMemory:getTime()
	self:setConfig()

	return Strings:get(self._config.Time) or ""
end

local iconPath = {
	[GalleryMemoryType.STORY] = "asset/ui/gallery/galleryMemoryStory/",
	[GalleryMemoryType.HERO] = "asset/ui/gallery/galleryMemoryHero/",
	[GalleryMemoryType.ACTIVI] = "asset/ui/gallery/galleryMemoryActive/"
}

function GalleryMemory:getIcon()
	self:setConfig()

	return string.format(iconPath[self:getType()] .. "%s.png", self._config.Listpicture)
end

function GalleryMemory:getPicture()
	self:setConfig()

	return string.format("asset/scene/%s.jpg", self._config.Picture)
end

function GalleryMemory:getCondition()
	self:setConfig()

	return self._config.Condition
end

function GalleryMemory:getType()
	self:setConfig()

	return self._config.Type
end

function GalleryMemory:getDate()
	return self._date
end

function GalleryMemory:getUnlock()
	return self._status == 1
end

function GalleryMemory:getCanshow()
	self:setConfig()

	return self._config.Screen ~= 1
end

function GalleryMemory:getStoryLink()
	self:setConfig()

	return self._config.StoryLink or ""
end
