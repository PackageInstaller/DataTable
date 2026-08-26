-- chunkname: @modules/logic/season/view/SeasonMarketShowLevelItem.lua

module("modules.logic.season.view.SeasonMarketShowLevelItem", package.seeall)

local SeasonMarketShowLevelItem = class("SeasonMarketShowLevelItem", LuaCompBase)

function SeasonMarketShowLevelItem:init(go, index, targetIndex, maxIndex)
	self.go = go
	self.index = index
	self.targetIndex = targetIndex
	self.maxIndex = maxIndex
	self._goline = gohelper.findChild(go, "#go_line")
	self._goselected = gohelper.findChild(go, "#go_selected")
	self._txtselectindex = gohelper.findChildText(go, "#go_selected/#txt_selectindex")
	self._gopass = gohelper.findChild(go, "#go_pass")
	self._animatorPass = self._gopass:GetComponent(typeof(UnityEngine.Animator))
	self._txtpassindex = gohelper.findChildText(go, "#go_pass/#txt_passindex")
	self._gounpass = gohelper.findChild(go, "#go_unpass")
	self._txtunpassindex = gohelper.findChildText(go, "#go_unpass/#txt_unpassindex")
	self.point = gohelper.findChild(go, "#go_unpass/point")

	gohelper.setActive(self.go, true)
	gohelper.setActive(self._goline, false)
	gohelper.setActive(self._gopass, false)
	gohelper.setActive(self._gounpass, false)
	gohelper.setActive(self._goselected, false)
end

function SeasonMarketShowLevelItem:show()
	gohelper.setActive(self._goline, self.index < self.maxIndex)
	gohelper.setActive(self._gopass, self.targetIndex > self.index)
	gohelper.setActive(self._gounpass, self.targetIndex < self.index)
	gohelper.setActive(self._goselected, self.targetIndex == self.index)

	self._txtselectindex.text = string.format("%02d", self.index)
	self._txtpassindex.text = string.format("%02d", self.index)
	self._txtunpassindex.text = string.format("%02d", self.index)

	if self.index + 1 == self.targetIndex or self.targetIndex == self.index then
		self._animatorPass:Play(UIAnimationName.Open, 0, 0)
	else
		self._animatorPass:Play(UIAnimationName.Idle, 0, 0)
	end
end

function SeasonMarketShowLevelItem:destroy()
	return
end

return SeasonMarketShowLevelItem
