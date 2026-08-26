-- chunkname: @modules/logic/bossrush/view/v2a9/V2a9_BossRushSkillBackpackView.lua

module("modules.logic.bossrush.view.v2a9.V2a9_BossRushSkillBackpackView", package.seeall)

local V2a9_BossRushSkillBackpackView = class("V2a9_BossRushSkillBackpackView", BaseView)

function V2a9_BossRushSkillBackpackView:onInitView()
	self._goinfo = gohelper.findChild(self.viewGO, "root/#go_info")
	self._txtname = gohelper.findChildText(self.viewGO, "root/#go_info/#txt_name")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/#go_info/#simage_icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/#go_info/#simage_icon/#txt_num")
	self._gofightEff = gohelper.findChild(self.viewGO, "root/#go_info/ScrollView/Viewport/#go_layoutEff/#go_fightEff")
	self._txtfightEffDesc = gohelper.findChildText(self.viewGO, "root/#go_info/ScrollView/Viewport/#go_layoutEff/#go_fightEff/#txt_fightEffDesc")
	self._gostealthEff = gohelper.findChild(self.viewGO, "root/#go_info/ScrollView/Viewport/#go_layoutEff/#go_stealthEff")
	self._txtstealthEffDesc = gohelper.findChildText(self.viewGO, "root/#go_info/ScrollView/Viewport/#go_layoutEff/#go_stealthEff/#txt_stealthEffDesc")
	self._goremove = gohelper.findChild(self.viewGO, "root/#go_info/change/#go_remove")
	self._goequip = gohelper.findChild(self.viewGO, "root/#go_info/change/#go_equip")
	self._goban = gohelper.findChild(self.viewGO, "root/#go_info/change/#go_ban")
	self._btnchange = gohelper.findChildClickWithAudio(self.viewGO, "root/#go_info/change/#btn_change")
	self._goIsEquiped = gohelper.findChild(self.viewGO, "root/#go_info/#go_Equip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a9_BossRushSkillBackpackView:addEvents()
	self._btnchange:AddClickListener(self._btnchangeOnClick, self)
	self.addEventCb(self, BossRushController.instance, BossRushEvent.OnSelectV2a9SpItem, self.onSelectItem, self)
end

function V2a9_BossRushSkillBackpackView:removeEvents()
	self._btnchange:RemoveClickListener()
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.OnSelectV2a9SpItem, self.onSelectItem, self)
end

function V2a9_BossRushSkillBackpackView:_btnchangeOnClick()
	V2a9BossRushModel.instance:changeEquippedSelectItem(self._stage, self.refreshView, self)
end

function V2a9_BossRushSkillBackpackView:onSelectItem()
	self:refreshSelectedItemInfo()
end

function V2a9_BossRushSkillBackpackView:_editableInitView()
	return
end

function V2a9_BossRushSkillBackpackView:onOpen()
	local episodeId = HeroGroupModel.instance.episodeId
	local co = BossRushConfig.instance:getEpisodeCoByEpisodeId(episodeId)

	self._stage = co.stage

	V2a9BossRushSkillBackpackListModel.instance:initSelect()
	self:refreshSelectedItemInfo()
end

function V2a9_BossRushSkillBackpackView:refreshSelectedItemInfo()
	local selectedItemId = V2a9BossRushModel.instance:getSelectedItemId()

	if not selectedItemId then
		gohelper.setActive(self._goinfo, false)

		return
	end

	self._txtname.text = AssassinConfig.instance:getAssassinItemName(selectedItemId)

	AssassinHelper.setAssassinItemIcon(selectedItemId, self._imageicon)

	self._txtnum.text = AssassinItemModel.instance:getAssassinItemCount(selectedItemId)

	local fightEffDesc = AssassinConfig.instance:getAssassinItemFightEffDesc(selectedItemId)
	local hasFightEff = not string.nilorempty(fightEffDesc)

	if hasFightEff then
		self._txtfightEffDesc.text = fightEffDesc
	end

	gohelper.setActive(self._gofightEff, hasFightEff)

	local stealthEffDesc = AssassinConfig.instance:getAssassinItemStealthEffDesc(selectedItemId)
	local hasStealthEff = not string.nilorempty(stealthEffDesc)

	if hasStealthEff then
		self._txtstealthEffDesc.text = stealthEffDesc
	end

	gohelper.setActive(self._gostealthEff, hasStealthEff)
	self:refreshBtn()
end

function V2a9_BossRushSkillBackpackView:refreshBtn()
	local isFullEquip = V2a9BossRushModel.instance:isFullEquip(self._stage)
	local id = V2a9BossRushModel.instance:getSelectedItemId()
	local isEquip = V2a9BossRushModel.instance:isEquip(self._stage, id)

	gohelper.setActive(self._goremove, isEquip)
	gohelper.setActive(self._goequip, not isFullEquip and not isEquip)
	gohelper.setActive(self._goban, isFullEquip and not isEquip)
	gohelper.setActive(self._goIsEquiped, isEquip)
	gohelper.setActive(self._goinfo, true)
end

function V2a9_BossRushSkillBackpackView:refreshView()
	self:refreshBtn()
	V2a9BossRushSkillBackpackListModel.instance:onModelUpdate()
end

function V2a9_BossRushSkillBackpackView:onClose()
	return
end

function V2a9_BossRushSkillBackpackView:onDestroyView()
	return
end

return V2a9_BossRushSkillBackpackView
