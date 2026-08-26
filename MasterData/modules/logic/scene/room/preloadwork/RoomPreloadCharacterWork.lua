-- chunkname: @modules/logic/scene/room/preloadwork/RoomPreloadCharacterWork.lua

module("modules.logic.scene.room.preloadwork.RoomPreloadCharacterWork", package.seeall)

local RoomPreloadCharacterWork = class("RoomPreloadCharacterWork", BaseWork)

function RoomPreloadCharacterWork:onStart(context)
	local urlList = self:_getUrlList()

	if urlList and #urlList > 0 then
		self._loader = MultiAbLoader.New()

		for _, resPath in ipairs(urlList) do
			self._loader:addPath(resPath)
		end

		self._loader:setLoadFailCallback(self._onPreloadOneFail)
		self._loader:startLoad(self._onPreloadFinish, self)
	else
		self:onDone(true)
	end
end

function RoomPreloadCharacterWork:_onPreloadFinish(loader)
	self:onDone(true)
end

function RoomPreloadCharacterWork:_onPreloadOneFail(loader, assetItem)
	logError("RoomPreloadCharacterWork: 加载失败, url: " .. assetItem.ResPath)
end

function RoomPreloadCharacterWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function RoomPreloadCharacterWork:_getUrlList()
	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		return nil
	end

	local urlList = {
		RoomCharacterEnum.MaterialPath
	}
	local characterMOList = RoomCharacterModel.instance:getList()

	for _, roomCharacterMO in pairs(characterMOList) do
		self:_addListUrl(urlList, RoomResHelper.getCharacterPath(roomCharacterMO.skinId))
		self:_addListUrl(urlList, RoomResHelper.getCharacterCameraAnimABPath(roomCharacterMO.roomCharacterConfig.cameraAnimPath))
		self:_addListUrl(urlList, RoomResHelper.getCharacterEffectABPath(roomCharacterMO.roomCharacterConfig.effectPath))
		self:_addCharacterEffectUrl(urlList, roomCharacterMO.skinId)
	end

	return urlList
end

function RoomPreloadCharacterWork:_addListUrl(urlList, url)
	if not string.nilorempty(url) then
		table.insert(urlList, url)
	end
end

function RoomPreloadCharacterWork:_addCharacterEffectUrl(urlList, skinId)
	local cfgList = RoomConfig.instance:getCharacterEffectList(skinId)

	if cfgList then
		for i, cfg in ipairs(cfgList) do
			if not RoomCharacterEnum.maskInteractAnim[cfg.animName] then
				self:_addListUrl(urlList, RoomResHelper.getCharacterEffectABPath(cfg.effectRes))
			end
		end
	end
end

return RoomPreloadCharacterWork
