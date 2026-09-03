-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/service/GalleryService.lua

GalleryService = class("GalleryService", Service, _M)

local opType = {}

opType.requestGalleryPartyReward = 27001
opType.requestGalleryAlbumSave = 27002
opType.requestGalleryAlbumDelete = 27003
opType.requestSendGift = 27004
opType.requestHeroDate = 27005
opType.requestUpdateAfkList = 27006
opType.requestDoAfkEvent = 27007
opType.requestGalleryHeroReward = 27009
opType.requestMessageCompose = 27011
opType.requestMessageLevelUp = 27012

function GalleryService:initialize()
	super.initialize(self)
end

function GalleryService:dispose()
	super.dispose(self)
end

function GalleryService:requestMessageCompose(params, callback, notShowWaiting)
	local request = self:newRequest(opType.requestMessageCompose, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function GalleryService:requestMessageLevelUp(params, callback, notShowWaiting)
	local request = self:newRequest(opType.requestMessageLevelUp, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function GalleryService:requestGalleryPartyReward(params, callback, notShowWaiting)
	local request = self:newRequest(opType.requestGalleryPartyReward, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function GalleryService:requestGalleryAlbumSave(params, callback, notShowWaiting)
	local request = self:newRequest(opType.requestGalleryAlbumSave, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function GalleryService:requestGalleryAlbumDelete(params, callback, notShowWaiting)
	local request = self:newRequest(opType.requestGalleryAlbumDelete, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function GalleryService:requestSendGift(params, callback, notShowWaiting)
	local request = self:newRequest(opType.requestSendGift, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function GalleryService:requestHeroDate(params, callback, notShowWaiting)
	local request = self:newRequest(opType.requestHeroDate, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function GalleryService:requestUpdateAfkList(params, callback, notShowWaiting)
	local request = self:newRequest(opType.requestUpdateAfkList, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function GalleryService:requestDoAfkEvent(params, callback, notShowWaiting)
	local request = self:newRequest(opType.requestDoAfkEvent, params, callback)

	self:sendRequest(request, not notShowWaiting)
end

function GalleryService:requestGalleryHeroReward(params, callback, notShowWaiting)
	local request = self:newRequest(opType.requestGalleryHeroReward, params, callback)

	self:sendRequest(request, not notShowWaiting)
end
