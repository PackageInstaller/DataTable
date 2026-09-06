-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pethire/model/PetHireMo.lua

module("logic.extensions.pethire.model.PetHireMo", package.seeall)

local PetHireMo = class("PetHireMo", MaterialMo)

PetHireMo.SUB_TYPE_NORMAL = 0
PetHireMo.SUB_TYPE_MASTER = 1
PetHireMo.SUB_TYPE_BUDDY = 2

function PetHireMo:ctor()
	PetHireMo.super.ctor(self)

	self.petId = 0
	self.petType = 0
	self.petView = nil
	self.subType = 0
end

return PetHireMo
