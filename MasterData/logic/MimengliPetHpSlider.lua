-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimengliPetHpSlider.lua

module("logic.extensions.kingdragonchallenge.view.MimengliPetHpSlider", package.seeall)

local MimengliPetHpSlider = class("MimengliPetHpSlider", CustomRightCell)

MimengliPetHpSlider.prefabUrl = "ui/views/timelimitedchallenge/mimengli/mimenglipethpslider.prefab"

function MimengliPetHpSlider:buildUI()
	self._hpSlider = Framework.SliderAdapter.GetFrom(self.mainGO, "bloodbar")
	self._fillChangeComp = goutil.findChildComponent(self.mainGO, "bloodbar/FillArea/Fill", ComponentType.UIImageColorChange)
	self._img = goutil.findChild(self.mainGO, "img")
	self._iconGo = goutil.findChild(self.mainGO, "img/iconGo")
end

function MimengliPetHpSlider:onUpdateHp(hpValue, petMo, map)
	hpValue = hpValue == 0 and 0 or math.max(0.1, hpValue)

	local level = Mathf.Clamp(math.floor(hpValue * 10) - 1, 0, 9)

	if self._fillChangeComp then
		self._fillChangeComp:SetState(level)
	end

	self._hpSlider:SetValue(hpValue)
	GameUtil.SetActive(self._img, false)

	if petMo and map then
		local key = PetSkinConfig.instance:getFirstJobKey(petMo:getDefineId())
		local idx = checknumber(map[key])

		GameUtil.SetActive(self._img, idx > 0)
		GameUtil.setUIImageSpriteIdx(self._iconGo, idx - 1)
	end
end

return MimengliPetHpSlider
