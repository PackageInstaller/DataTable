-- chunkname: @modules/logic/open/model/OpenModel.lua

module("modules.logic.open.model.OpenModel", package.seeall)

local OpenModel = class("OpenModel", BaseModel)

function OpenModel:onInit()
	self._unlocks = {}
end

function OpenModel:reInit()
	self._unlocks = {}
end

function OpenModel:setOpenInfo(info)
	for _, v in ipairs(info) do
		local id = tonumber(v.id)
		local isOpen = v.isOpen

		if VersionValidator.instance:isInReviewing() then
			local co = OpenConfig.instance:getOpenCo(id)

			isOpen = isOpen and co.verifingHide == 0
		end

		self._unlocks[id] = isOpen
	end
end

function OpenModel:updateOpenInfo(info)
	for _, v in ipairs(info) do
		local id = tonumber(v.id)
		local isOpen = v.isOpen

		if VersionValidator.instance:isInReviewing() then
			local co = OpenConfig.instance:getOpenCo(id)

			isOpen = isOpen and co.verifingHide == 0
		end

		self._unlocks[id] = isOpen
	end
end

function OpenModel:updateOneOpenInfo(info)
	local id = tonumber(info.id)
	local isOpen = info.isOpen

	if VersionValidator.instance:isInReviewing() then
		local co = OpenConfig.instance:getOpenCo(id)

		isOpen = isOpen and co.verifingHide == 0
	end

	self._unlocks[id] = isOpen
end

function OpenModel:isFunctionUnlock(id)
	local co = OpenConfig.instance:getOpenCo(id)

	if co and VersionValidator.instance:isInReviewing() and co.verifingHide == 1 then
		return false
	end

	return self._unlocks[tonumber(id)]
end

function OpenModel:isFuncBtnShow(id)
	local co = OpenConfig.instance:getOpenCo(id)

	if VersionValidator.instance:isInReviewing() and co.verifingHide == 1 then
		return false
	end

	if tonumber(co.isOnline) == 0 then
		return false
	end

	return tonumber(co.isAlwaysShowBtn) > 0 or self._unlocks[id]
end

function OpenModel:getFuncUnlockDesc(id)
	local openCo = OpenConfig.instance:getOpenCo(id)
	local descId = openCo.dec

	if descId == 2003 then
		if VersionValidator.instance:isInReviewing() then
			if not openCo.verifingEpisodeId then
				local episodeId = openCo.episodeId

				if not episodeId or episodeId == 0 then
					return descId
				end

				local episodeDisplay = DungeonConfig.instance:getEpisodeDisplay(episodeId)

				return descId, episodeDisplay
			end
		end
	end

	return descId
end

OpenModel.instance = OpenModel.New()

return OpenModel
