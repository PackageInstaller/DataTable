-- chunkname: @modules/logic/equip/view/EquipStoryView.lua

module("modules.logic.equip.view.EquipStoryView", package.seeall)

local EquipStoryView = class("EquipStoryView", BaseView)

function EquipStoryView:onInitView()
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txtnameEn = gohelper.findChildText(self.viewGO, "#txt_name/#txt_nameen")
	self._goskillpos = gohelper.findChild(self.viewGO, "#go_skillpos")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipStoryView:addEvents()
	return
end

function EquipStoryView:removeEvents()
	return
end

function EquipStoryView:_editableInitView()
	self.txt_skilldesc = SLFramework.GameObjectHelper.FindChildComponent(self.viewGO, "desc/txt_skilldesc", typeof(TMPro.TextMeshProUGUI))
	self._viewAnim = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
end

function EquipStoryView:onOpen()
	self._equipMO = self.viewContainer.viewParam.equipMO

	if self._equipMO then
		self._equipId = self._equipMO.config.id or self.viewContainer.viewParam.equipId
	end

	if self._equipMO then
		self._config = self._equipMO.config or EquipConfig.instance:getEquipCo(self._equipId)
	end

	self._txtname.text = self._config.name
	self._txtnameEn.text = self._config.name_en
	self.txt_skilldesc.text = self._config.desc

	if self.viewContainer:getIsOpenLeftBackpack() then
		self.viewContainer.equipView:showTitleAndCenter()
	end

	self._viewAnim:Play(UIAnimationName.Open)
end

function EquipStoryView:onOpenFinish()
	return
end

function EquipStoryView:onClose()
	self:playCloseAnimation()
end

function EquipStoryView:playCloseAnimation()
	self._viewAnim:Play(UIAnimationName.Close)
end

return EquipStoryView
