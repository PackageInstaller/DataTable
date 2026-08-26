-- chunkname: @modules/logic/towercompose/view/result/TowerComposeResultSlotBodyModItem.lua

module("modules.logic.towercompose.view.result.TowerComposeResultSlotBodyModItem", package.seeall)

local TowerComposeResultSlotBodyModItem = class("TowerComposeResultSlotBodyModItem", LuaCompBase)

function TowerComposeResultSlotBodyModItem:ctor()
	return
end

function TowerComposeResultSlotBodyModItem:init(go)
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

function TowerComposeResultSlotBodyModItem:_addEvents()
	return
end

function TowerComposeResultSlotBodyModItem:_removeEvents()
	return
end

function TowerComposeResultSlotBodyModItem:refresh(modId)
	self._modId = modId

	gohelper.setActive(self.go, true)
	gohelper.setActive(self.imageModColorIcon.gameObject, self._modId > 0)
	self.modIconComp:refreshMod(modId, self._imageskillicon, self.imageModColorIcon, self.imageModLvColorIcon, self.materialModIcon, self.materialModLvIcon)
end

function TowerComposeResultSlotBodyModItem:destroy()
	self:_removeEvents()
end

return TowerComposeResultSlotBodyModItem
