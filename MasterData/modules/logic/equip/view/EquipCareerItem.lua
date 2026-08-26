-- chunkname: @modules/logic/equip/view/EquipCareerItem.lua

module("modules.logic.equip.view.EquipCareerItem", package.seeall)

local EquipCareerItem = class("EquipCareerItem", UserDataDispose)

function EquipCareerItem:onInitView(go, clickCallback, clickCallbackObj)
	self:__onInit()

	self.go = go
	self.selectedBg = gohelper.findChild(self.go, "BG")
	self.txt = gohelper.findChildText(self.go, "txt")
	self.icon = gohelper.findChildImage(self.go, "icon")
	self.clickCallback = clickCallback
	self.clickCallbackObj = clickCallbackObj
	self.click = gohelper.getClick(self.go)

	self.click:AddClickListener(self.onClick, self)
	gohelper.setActive(self.go, true)
end

function EquipCareerItem:onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)

	if self.clickCallback then
		if self.clickCallbackObj then
			self.clickCallback(self.clickCallbackObj, self.careerMo)
		else
			self.clickCallback(self.careerMo)
		end
	end
end

function EquipCareerItem:onUpdateMO(careerMo)
	self.careerMo = careerMo

	if self.careerMo.txt then
		self.txt.text = self.careerMo.txt

		gohelper.setActive(self.txt.gameObject, true)
	else
		gohelper.setActive(self.txt.gameObject, false)
	end

	if self.careerMo.iconName then
		UISpriteSetMgr.instance:setCommonSprite(self.icon, self.careerMo.iconName)
		gohelper.setActive(self.icon.gameObject, true)
	else
		gohelper.setActive(self.icon.gameObject, false)
	end
end

function EquipCareerItem:refreshSelect(selectedCareer)
	local isSelect = self.careerMo.career == selectedCareer

	gohelper.setActive(self.selectedBg, isSelect)
	ZProj.UGUIHelper.SetColorAlpha(self.icon, isSelect and 1 or 0.4)
end

function EquipCareerItem:onDestroyView()
	self.click:RemoveClickListener()
	self:__onDispose()
end

return EquipCareerItem
