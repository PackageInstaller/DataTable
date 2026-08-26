-- chunkname: @modules/logic/equip/view/EquipSkillLevelUpView.lua

module("modules.logic.equip.view.EquipSkillLevelUpView", package.seeall)

local EquipSkillLevelUpView = class("EquipSkillLevelUpView", BaseView)

function EquipSkillLevelUpView:onInitView()
	self._txtcurleveldesc2 = gohelper.findChildText(self.viewGO, "#go_rootinfo/info/curleveldesc/#go_curbaseskill/#txt_curleveldesc2")
	self._txtnextleveldesc2 = gohelper.findChildText(self.viewGO, "#go_rootinfo/info/nextleveldesc/#go_nextbaseskill/#txt_nextleveldesc2")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gocurbaseskill = gohelper.findChild(self.viewGO, "#go_rootinfo/info/curleveldesc/#go_curbaseskill")
	self._txtcurlevel = gohelper.findChildText(self.viewGO, "#go_rootinfo/info/curleveldesc/#txt_curlevel")
	self._gonextbaseskill = gohelper.findChild(self.viewGO, "#go_rootinfo/info/nextleveldesc/#go_nextbaseskill")
	self._txtnextlevel = gohelper.findChildText(self.viewGO, "#go_rootinfo/info/nextleveldesc/#txt_nextlevel")
	self._gorootinfo = gohelper.findChild(self.viewGO, "#go_rootinfo")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipSkillLevelUpView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function EquipSkillLevelUpView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function EquipSkillLevelUpView:_btncloseOnClick()
	EquipController.instance:dispatchEvent(EquipEvent.onCloseEquipLevelUpView)
	self:closeThis()
end

function EquipSkillLevelUpView:_editableInitView()
	gohelper.setActive(self._txtcurleveldesc2.gameObject, false)
	gohelper.setActive(self._txtnextleveldesc2.gameObject, false)
end

function EquipSkillLevelUpView:onUpdateParam()
	return
end

function EquipSkillLevelUpView:onOpen()
	self._equip_mo = self.viewParam[1]
	self.last_refine_lv = self.viewParam[2]
	self._txtcurlevel.text = "<size=22>LV.</size>" .. self.last_refine_lv
	self._txtnextlevel.text = "<size=22>LV.</size>" .. self._equip_mo.refineLv

	local curSkillInfoTab = {
		rootGo = self._gocurbaseskill,
		txtBaseDes = self._txtcurleveldesc2,
		skillType = self._equip_mo.equipId,
		refineLv = self.last_refine_lv
	}
	local nextSkillInfoTab = {
		rootGo = self._gonextbaseskill,
		txtBaseDes = self._txtnextleveldesc2,
		skillType = self._equip_mo.equipId,
		refineLv = self._equip_mo.refineLv
	}

	self:_showBaseSkillDes(curSkillInfoTab)
	self:_showBaseSkillDes(nextSkillInfoTab)
end

function EquipSkillLevelUpView:_showBaseSkillDes(params)
	local skillBaseDesList = EquipHelper.getEquipSkillDescList(params.skillType, params.refineLv, "#D9A06F")

	if #skillBaseDesList == 0 then
		gohelper.setActive(params.rootGo, false)
	else
		gohelper.setActive(params.rootGo, true)

		local txt, itemGo

		for index, desc in ipairs(skillBaseDesList) do
			txt = gohelper.cloneInPlace(params.txtBaseDes.gameObject, "item_" .. index):GetComponent(gohelper.Type_TextMesh)
			txt.text = desc

			gohelper.setActive(txt.gameObject, true)
		end
	end
end

function EquipSkillLevelUpView:onClose()
	return
end

function EquipSkillLevelUpView:onDestroyView()
	return
end

return EquipSkillLevelUpView
