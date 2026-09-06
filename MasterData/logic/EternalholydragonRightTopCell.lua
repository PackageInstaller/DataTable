-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalholydragon/view/EternalholydragonRightTopCell.lua

module("logic.extensions.eternalholydragon.view.EternalholydragonRightTopCell", package.seeall)

local EternalholydragonRightTopCell = class("EternalholydragonRightTopCell", CustomRightCell)

EternalholydragonRightTopCell.prefabUrl = ExpeditionMissionViewPresentor.itemExpPet

function EternalholydragonRightTopCell:buildUI()
	self._bloodbar = Framework.SliderAdapter.GetFrom(self.mainGO, "bloodbar")
	self._vigourbar = Framework.SliderAdapter.GetFrom(self.mainGO, "vigourbar")

	goutil.setActive(self._vigourbar.gameObject, false)
end

function EternalholydragonRightTopCell:setData(petMo)
	local info = EternalholydragonModel.instance:getPetInfo(petMo.petId)

	self._bloodbar:SetValue((info or nil) and info.value / petMo._maxHp)
end

function EternalholydragonRightTopCell:dispose()
	return
end

return EternalholydragonRightTopCell
