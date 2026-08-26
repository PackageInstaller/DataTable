-- chunkname: @modules/logic/antique/model/AntiqueModel.lua

module("modules.logic.antique.model.AntiqueModel", package.seeall)

local AntiqueModel = class("AntiqueModel", BaseModel)

function AntiqueModel:onInit()
	self._antiqueList = {}
end

function AntiqueModel:reInit()
	self._antiqueList = {}
end

function AntiqueModel:getAntique(id)
	return self._antiqueList[id]
end

function AntiqueModel:getAntiqueList()
	return self._antiqueList
end

function AntiqueModel:setAntiqueInfo(infos)
	self._antiqueList = {}

	for _, v in ipairs(infos) do
		local mo = AntiqueMo.New()

		mo:init(v)

		self._antiqueList[tonumber(v.antiqueId)] = mo
	end
end

function AntiqueModel:updateAntiqueInfo(infos)
	for _, v in ipairs(infos) do
		if not self._antiqueList[v.antiqueId] then
			local mo = AntiqueMo.New()

			mo:init(v)

			self._antiqueList[tonumber(v.antiqueId)] = mo
		else
			self._antiqueList[v.antiqueId]:reset(v)
		end
	end
end

function AntiqueModel:getAntiqueGetTime(antiqueId)
	return self._antiqueList[antiqueId] or 0
end

function AntiqueModel:getAntiques()
	return self._antiqueList
end

function AntiqueModel:isAntiqueUnlock()
	return next(self._antiqueList)
end

AntiqueModel.instance = AntiqueModel.New()

return AntiqueModel
