-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingshikongllongzun/view/DivineKingShiKongLongZunBlood.lua

module("logic.extensions.divinekingshikongllongzun.view.DivineKingShiKongLongZunBlood", package.seeall)

local DivineKingShiKongLongZunBlood = class("DivineKingShiKongLongZunBlood", CustomRightCell)

DivineKingShiKongLongZunBlood.prefabUrl = "ui/views/divinekingshikongllongzun/divinekingshikonglongzunblood.prefab"

function DivineKingShiKongLongZunBlood:buildUI()
	self._slider = goutil.findChildComponent(self.mainGO, "slider", ComponentType.Slider)
	self._txtBlood = goutil.findChildTextComponent(self.mainGO, "slider/txtBlood")
end

function DivineKingShiKongLongZunBlood:setSliderRate(bloodRate)
	GameUtil.SetActive(self._slider.gameObject, true)

	self._slider.value = bloodRate / 100
	self._txtBlood.text = string.format("%d%%", bloodRate)
end

function DivineKingShiKongLongZunBlood:clearSlider()
	GameUtil.SetActive(self._slider.gameObject, false)
end

return DivineKingShiKongLongZunBlood
