-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/PetHpSlider.lua

module("logic.extensions.kingdragonchallenge.view.PetHpSlider", package.seeall)

local PetHpSlider = class("PetHpSlider", CustomRightCell)

PetHpSlider.prefabUrl = "ui/views/kingdragonchallenge/pethpslider.prefab"

function PetHpSlider:buildUI()
	self._hpSlider = Framework.SliderAdapter.GetFrom(self.mainGO, "bloodbar")
	self._fillChangeComp = goutil.findChildComponent(self.mainGO, "bloodbar/FillArea/Fill", ComponentType.UIImageColorChange)
end

function PetHpSlider:onUpdateHp(hpValue)
	hpValue = hpValue == 0 and 0 or math.max(0.1, hpValue)

	local level = Mathf.Clamp(math.floor(hpValue * 10) - 1, 0, 9)

	if self._fillChangeComp then
		self._fillChangeComp:SetState(level)
	end

	self._hpSlider:SetValue(hpValue)
end

return PetHpSlider
