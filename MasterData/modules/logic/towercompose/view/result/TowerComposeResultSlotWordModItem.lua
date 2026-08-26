-- chunkname: @modules/logic/towercompose/view/result/TowerComposeResultSlotWordModItem.lua

module("modules.logic.towercompose.view.result.TowerComposeResultSlotWordModItem", package.seeall)

local TowerComposeResultSlotWordModItem = class("TowerComposeResultSlotWordModItem", LuaCompBase)

function TowerComposeResultSlotWordModItem:ctor()
	return
end

function TowerComposeResultSlotWordModItem:init(go)
	self.go = go
	self._imageskillbg = gohelper.findChildImage(self.go, "#image_skillbg")
	self._imageskillicon = gohelper.findChildImage(self.go, "#image_skillicon")
	self.imageModColorIcon = gohelper.findChildImage(self.go, "#image_skillicon_01")
	self.materialModIcon = UnityEngine.Object.Instantiate(self.imageModColorIcon.material)
	self.imageModLvColorIcon = gohelper.findChildImage(self.go, "#image_skillicon_02")
	self.materialModLvIcon = UnityEngine.Object.Instantiate(self.imageModLvColorIcon.material)
	self.imageModColorIcon.material = self.materialModIcon
	self.imageModLvColorIcon.material = self.materialModLvIcon
	self.modIconComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.go, TowerComposeModIconComp)

	self:_addEvents()
end

function TowerComposeResultSlotWordModItem:_addEvents()
	return
end

function TowerComposeResultSlotWordModItem:_removeEvents()
	return
end

function TowerComposeResultSlotWordModItem:refresh(modId)
	self._modId = modId

	gohelper.setActive(self.go, true)
	gohelper.setActive(self.imageModColorIcon.gameObject, self._modId > 0)
	self.modIconComp:refreshMod(modId, self._imageskillicon, self.imageModColorIcon, self.imageModLvColorIcon, self.materialModIcon, self.materialModLvIcon)
end

function TowerComposeResultSlotWordModItem:destroy()
	self:_removeEvents()
end

return TowerComposeResultSlotWordModItem
