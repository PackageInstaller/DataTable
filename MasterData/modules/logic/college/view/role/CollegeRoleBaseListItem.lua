-- chunkname: @modules/logic/college/view/role/CollegeRoleBaseListItem.lua

module("modules.logic.college.view.role.CollegeRoleBaseListItem", package.seeall)

local CollegeRoleBaseListItem = class("CollegeRoleBaseListItem", ListScrollCellExtend)

function CollegeRoleBaseListItem:onInitView()
	self._imageQuality = gohelper.findChildImage(self.viewGO, "#image_Quality")
	self._simageHead = gohelper.findChildSingleImage(self.viewGO, "#simage_Head")
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self._goDispatch = gohelper.findChild(self.viewGO, "#go_Dispatch")
	self._goInTeam = gohelper.findChild(self.viewGO, "#go_InTeam")
	self._goLike = gohelper.findChild(self.viewGO, "#go_Like")
	self._goLvUp = gohelper.findChild(self.viewGO, "#go_LvUp")
	self._goTeamNum = gohelper.findChild(self.viewGO, "#go_TeamNum")
	self._txtTeamNum = gohelper.findChildText(self.viewGO, "#go_TeamNum/#txt_TeamNum")
	self._txtLevel = gohelper.findChildText(self.viewGO, "#txt_Level")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Click")
	self._isSelect = false

	self:initBgRareEffect()
end

function CollegeRoleBaseListItem:initInternal(go, view)
	CollegeRoleBaseListItem.super.initInternal(self, go, view)

	self._model = self._view._model
end

function CollegeRoleBaseListItem:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function CollegeRoleBaseListItem:removeEvents()
	self._btnClick:RemoveClickListener()
end

function CollegeRoleBaseListItem:_btnClickOnClick()
	if self._isSelect or not self._model then
		return
	end

	local isSelect = not self._isSelect

	self._model:selectCell(self._index, isSelect)
	CollegeController.instance:dispatchEvent(CollegeEvent.SelectCharacter, self._mo, isSelect)
end

function CollegeRoleBaseListItem:onUpdateMO(mo)
	self:reset()
	self:updateData(mo)
	self:refreshUI()
end

function CollegeRoleBaseListItem:reset()
	gohelper.setActive(self._goDispatch, false)
	gohelper.setActive(self._goLike, false)
	gohelper.setActive(self._goLvUp, false)
	gohelper.setActive(self._goTeamNum, false)
	gohelper.setActive(self._goInTeam, false)
end

function CollegeRoleBaseListItem:updateData(mo)
	self._mo = mo
	self._co = mo.co
	self._uid = mo.uid
	self._id = mo.id
	self._level = mo.level
	self._cost = mo.cost
	self._isMaxLv = mo.isMaxLv
end

function CollegeRoleBaseListItem:refreshUI()
	self:refreshCommonUI()
	self:refreshOtherUI()
end

function CollegeRoleBaseListItem:refreshCommonUI()
	self:refreshBgRareEffect(self._co.rarity)

	self._txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_malllevelupview_level"), self._level)

	gohelper.setActive(self._goSelected, self._isSelect)
	CollegeIconHelper.setActorIcon(self._id, self._simageHead, self._imageQuality)
end

function CollegeRoleBaseListItem:refreshOtherUI()
	return
end

function CollegeRoleBaseListItem:onSelect(isSelect)
	if self._isSelect == isSelect then
		return
	end

	self._isSelect = isSelect

	self:refreshUI()
end

function CollegeRoleBaseListItem:initBgRareEffect()
	self._rareEffectTab = self:getUserDataTb_()
	self._rareEffectTab[3] = gohelper.findChild(self._imageQuality.gameObject, "vx_ssr")
	self._rareEffectTab[2] = gohelper.findChild(self._imageQuality.gameObject, "vx_sr")
end

function CollegeRoleBaseListItem:refreshBgRareEffect(rarity)
	rarity = rarity or 0

	for i, goEffect in pairs(self._rareEffectTab) do
		gohelper.setActive(goEffect, i == rarity)
	end
end

function CollegeRoleBaseListItem:onDestroyView()
	self._simageHead:UnLoadImage()
end

return CollegeRoleBaseListItem
