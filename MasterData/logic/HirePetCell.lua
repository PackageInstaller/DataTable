-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/pet/HirePetCell.lua

module("logic.extensions.material.proxy.pet.HirePetCell", package.seeall)

local HirePetCell = class("HirePetCell", PetCell)

function HirePetCell:setData(info)
	local petMo = PetHireModel.instance:getPetMoById(info.petId)

	HirePetCell.super.setData(self, petMo)
	self.target:SetActive(true)
end

function HirePetCell:setCfgData(hireCo)
	local petCo = MaterialMgr.getMatCfg(MatType.Pet, hireCo.raceId)

	HirePetCell.super.setCfgData(self, petCo)

	if checknumber(hireCo.faceId) > 0 then
		self:setSkin(hireCo.faceId)
	end

	self.target:SetActive(true)
end

function HirePetCell:_OnClick()
	print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>            HirePetCell:_OnClick()   ", self.data, self.autoTips, self.callback)

	if self.autoTips and self.data then
		-- block empty
	end

	GameUtil.callBack(self.callback, self)
end

return HirePetCell
