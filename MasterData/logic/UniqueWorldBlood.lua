-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/view/UniqueWorldBlood.lua

module("logic.extensions.uniqueworld.view.UniqueWorldBlood", package.seeall)

local UniqueWorldBlood = class("UniqueWorldBlood", CustomRightCell)

UniqueWorldBlood.prefabUrl = "ui/views/uniqueworld/uniqueworldblood.prefab"

function UniqueWorldBlood:buildUI()
	self._dead = goutil.findChild(self.mainGO, "dead")
	self._bloodBar = goutil.findChild(self.mainGO, "bloodbar"):GetComponent(ComponentType.Slider)
	self._bloodChangeComp = goutil.findChild(self.mainGO, "bloodbar/FillArea/Fill"):GetComponent(ComponentType.UIImageColorChange)
	self._txtBlood = goutil.findChildTextComponent(self.mainGO, "txtBlood")
end

function UniqueWorldBlood:clearUI()
	self._bloodBar.value = 1
end

function UniqueWorldBlood:updateUI(hpWanPercent)
	local val = hpWanPercent / 10000

	if val < 0.01 and val > 0 then
		val = 0.01
	end

	self._bloodBar.value = val
	self._txtBlood.text = string.format("%d%%", val * 100)

	GameUtil.SetActive(self._dead, hpWanPercent <= 0)
	GameUtil.SetActive(self._bloodBar.gameObject, hpWanPercent > 0)
	GameUtil.SetActive(self._txtBlood.gameObject, hpWanPercent > 0)
end

return UniqueWorldBlood
