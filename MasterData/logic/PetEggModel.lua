-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petegg/model/PetEggModel.lua

module("logic.extensions.petegg.model.PetEggModel", package.seeall)

local PetEggModel = class("PetEggModel", BaseModel)

function PetEggModel:ctor()
	PetEggModel.super.ctor(self)
	self:onReset()
end

function PetEggModel:onInit()
	return
end

function PetEggModel:onReset()
	self._isDataInited = false
	self._curSelect = -1
	self._hatchEggInfo = {}
end

function PetEggModel:setSelectEgg(id)
	self._curSelect = id
end

function PetEggModel:getSelectEgg()
	return self._curSelect
end

function PetEggModel:isDataInited()
	return self._isDataInited
end

function PetEggModel:setHatchInfo(info)
	self._hatchEggInfo = {}

	for i, v in ipairs(info) do
		self._hatchEggInfo[v.hatcherId] = v
	end
end

function PetEggModel:getHatchInfos()
	return self._hatchEggInfo
end

function PetEggModel:getHatchInfo(hatcherId)
	return self._hatchEggInfo[hatcherId]
end

function PetEggModel:isHatcherEmpty(hatcherId)
	return self._hatchEggInfo[hatcherId] == nil
end

function PetEggModel:onHatcherEmptyed(hatcherId)
	self._hatchEggInfo[hatcherId] = nil
end

function PetEggModel:getEggDataById(id)
	local datas = MaterialFacade.instance:getMaterialInfoByType(9)

	for k, v in ipairs(datas) do
		if v.id == id then
			return v
		end
	end

	return nil
end

function PetEggModel:getEggNum(id)
	local v = self:getEggDataById(id)

	if v then
		return v.num
	else
		return 0
	end
end

PetEggModel.instance = PetEggModel.New()

return PetEggModel
