-- chunkname: @modules/logic/equip/view/EquipTeamHeroGroupItem.lua

module("modules.logic.equip.view.EquipTeamHeroGroupItem", package.seeall)

local EquipTeamHeroGroupItem = class("EquipTeamHeroGroupItem", BaseChildView)

function EquipTeamHeroGroupItem:onInitView()
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_info/#simage_icon")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._imagerare = gohelper.findChildImage(self.viewGO, "#go_info/#rare")
	self._txtequipnamecn = gohelper.findChildText(self.viewGO, "#go_info/#txt_equipnamecn")
	self._txtequipnameen = gohelper.findChildText(self.viewGO, "#go_info/#txt_equipnameen")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_info/#simage_bg")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipTeamHeroGroupItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function EquipTeamHeroGroupItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function EquipTeamHeroGroupItem:_btnclickOnClick()
	if self._equipMO then
		EquipController.instance:openEquipTeamShowView({
			self._equipMO.uid,
			true
		})
	end
end

function EquipTeamHeroGroupItem:_editableInitView()
	self._rareLineColor = {
		"#DCF5D5",
		"#9EB7D7",
		"#7D5B7E",
		"#D2D79E",
		"#D6A181"
	}
end

function EquipTeamHeroGroupItem:onUpdateParam()
	return
end

function EquipTeamHeroGroupItem:onOpen()
	local teamEquipList = EquipTeamListModel.instance:getTeamEquip()
	local equipId = teamEquipList[1]

	self._equipMO = EquipModel.instance:getEquip(equipId)

	self:showEquip()
end

function EquipTeamHeroGroupItem:setHeroGroupType()
	self._heroGroupType = true
end

function EquipTeamHeroGroupItem:showEquip()
	local showEquip = self._equipMO ~= nil

	gohelper.setActive(self._simageicon.gameObject, showEquip)

	if showEquip then
		self._simageicon:LoadImage(ResUrl.getEquipSuit(self._equipMO.config.icon))
		self._simagebg:LoadImage(ResUrl.getEquipBg("bg_xinxiangzhezhao.png"))

		self._txtequipnamecn.text = self._equipMO.config.name
		self._txtequipnameen.text = self._equipMO.config.name_en

		SLFramework.UGUI.GuiHelper.SetColor(self._imagerare, self._rareLineColor[self._equipMO.config.rare])
	end

	gohelper.setActive(self._goinfo, showEquip)
end

function EquipTeamHeroGroupItem:onClose()
	return
end

function EquipTeamHeroGroupItem:onDestroyView()
	self._simageicon:UnLoadImage()
	self._simagebg:UnLoadImage()
end

return EquipTeamHeroGroupItem
