-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalPetCpTag.lua

module("logic.extensions.landlords.view.FalPetCpTag", package.seeall)

local FalPetCpTag = class("FalPetCpTag", CustomRightCell)

FalPetCpTag.prefabUrl = "ui/views/landlords/falpetcptag.prefab"

function FalPetCpTag:buildUI()
	self._imgCp = goutil.findChild(self.mainGO, "imgCp")
	self._icon = goutil.findChild(self.mainGO, "imgCp/icon")
end

function FalPetCpTag:setData(activityId, petMo)
	local petIdAsCp = petMo.falMo.petIdAsCp

	GameUtil.SetActive(self._imgCp, petIdAsCp > 0)

	local comp = self._icon:GetComponent("Image")

	if comp then
		comp.color = FightAgainstLandlordsController.instance:getColorByCpId(activityId, petMo.falMo.cpId)
	end
end

return FalPetCpTag
