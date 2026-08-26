-- chunkname: @modules/logic/bossrush/view/v2a9/V2a9_BossRushSkillBackpackItem.lua

module("modules.logic.bossrush.view.v2a9.V2a9_BossRushSkillBackpackItem", package.seeall)

local V2a9_BossRushSkillBackpackItem = class("V2a9_BossRushSkillBackpackItem", AssassinBackpackItem)

function V2a9_BossRushSkillBackpackItem:onInitView()
	self._imageicon = gohelper.findChildImage(self.viewGO, "#simage_icon")
	self._goequip = gohelper.findChild(self.viewGO, "#go_equip")
	self._txtequipIndex = gohelper.findChildText(self.viewGO, "#go_equip/#txt_equipIndex")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._btnclick = gohelper.findChildClickWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a9_BossRushSkillBackpackItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function V2a9_BossRushSkillBackpackItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function V2a9_BossRushSkillBackpackItem:_btnclickOnClick()
	V2a9BossRushSkillBackpackListModel.instance:selectCell(self._index, true)

	local id = self._mo:getId()

	V2a9BossRushModel.instance:selectSpItemId(id)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnSelectV2a9SpItem)
end

function V2a9_BossRushSkillBackpackItem:_editableInitView()
	V2a9_BossRushSkillBackpackItem.super._editableInitView(self)
end

function V2a9_BossRushSkillBackpackItem:refresh()
	local id = self._mo:getId()

	AssassinHelper.setAssassinItemIcon(id, self._imageicon)

	self._txtnum.text = self._mo:getCount()

	local equipIndex = V2a9BossRushModel.instance:getEquipIndex(self._mo.stage, id)

	if equipIndex then
		self._txtequipIndex.text = equipIndex
	end

	gohelper.setActive(self._goequip, equipIndex and true or false)
end

return V2a9_BossRushSkillBackpackItem
