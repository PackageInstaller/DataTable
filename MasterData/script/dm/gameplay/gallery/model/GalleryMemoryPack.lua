-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/model/GalleryMemoryPack.lua

GalleryMemoryPack = class("GalleryMemoryPack", objectlua.Object, _M)

GalleryMemoryPack:has("_id", {
	is = "rw"
})
GalleryMemoryPack:has("_status", {
	is = "rw"
})
GalleryMemoryPack:has("_date", {
	is = "rw"
})
GalleryMemoryPack:has("_lockTip", {
	is = "rw"
})

function GalleryMemoryPack:initialize(id, owner)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:requireRecordById("GalleryMemoryStory", id)
	self._status = 0
	self._date = ""
	self._lockTip = ""
	self._forceUnlock = 0
end

function GalleryMemoryPack:sync(data)
	if data.finishTime then
		self._date = data.finishTime
	end

	if data.memoryStatus then
		self._status = data.memoryStatus
	end
end

function GalleryMemoryPack:getTitle()
	return Strings:get(self._config.Name) or ""
end

function GalleryMemoryPack:getCondition()
	return self._config.Condition
end

function GalleryMemoryPack:getNumber()
	return self._config.Num
end

local iconPath = "asset/ui/gallery/galleryMemoryStory/"

function GalleryMemoryPack:getIcon()
	return string.format(iconPath .. "%s.png", self._config.Listpicture)
end

function GalleryMemoryPack:getType()
	return self._config.Type
end

function GalleryMemoryPack:getActiviType()
	return self._config.ActiviType
end

function GalleryMemoryPack:getStorys()
	return self._config.Story
end

function GalleryMemoryPack:getDate()
	return self._date
end

function GalleryMemoryPack:getUnlock()
	return self._forceUnlock == 1 or self._status == 1
end

function GalleryMemoryPack:getForceUnlock()
	return self._forceUnlock == 1
end

function GalleryMemoryPack:setForceUnlock(value)
	return self._forceUnlock == value
end
