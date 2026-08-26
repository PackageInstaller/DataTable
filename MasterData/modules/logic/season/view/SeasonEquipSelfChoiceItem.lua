-- chunkname: @modules/logic/season/view/SeasonEquipSelfChoiceItem.lua

module("modules.logic.season.view.SeasonEquipSelfChoiceItem", package.seeall)

local SeasonEquipSelfChoiceItem = class("SeasonEquipSelfChoiceItem", ListScrollCellExtend)

function SeasonEquipSelfChoiceItem:init(go)
	SeasonEquipSelfChoiceItem.super.init(self, go)

	self._gocard = gohelper.findChild(self.viewGO, "go_card")
	self._goselect = gohelper.findChild(self.viewGO, "go_select")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_detail")
end

function SeasonEquipSelfChoiceItem:addEvents()
	self._btndetail:AddClickListener(self.onClickDetail, self)
end

function SeasonEquipSelfChoiceItem:removeEvents()
	self._btndetail:RemoveClickListener()
end

function SeasonEquipSelfChoiceItem:onUpdateMO(mo)
	self._mo = mo
	self._cfg = mo.cfg

	self:refreshUI()
end

function SeasonEquipSelfChoiceItem:refreshUI()
	self:checkCreateIcon()
	self.icon:updateData(self._cfg.equipId)
	gohelper.setActive(self._goselect, Activity104SelfChoiceListModel.instance.curSelectedItemId == self._cfg.equipId)
end

function SeasonEquipSelfChoiceItem:checkCreateIcon()
	if not self.icon then
		local path = self._view.viewContainer:getSetting().otherRes[2]
		local go = self._view:getResInst(path, self._gocard, "icon")

		self.icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, SeasonCelebrityCardEquip)

		self.icon:setClickCall(self.onClickSelf, self)
		self.icon:setLongPressCall(self.onLongPress, self)
	end
end

function SeasonEquipSelfChoiceItem:showDetailTips()
	local data = {
		actId = self._view.viewParam.actId
	}

	MaterialTipController.instance:showMaterialInfoWithData(MaterialEnum.MaterialType.EquipCard, self._cfg.equipId, data)
end

function SeasonEquipSelfChoiceItem:onClickSelf()
	if Activity104SelfChoiceListModel.instance.curSelectedItemId ~= self._cfg.equipId then
		Activity104EquipSelfChoiceController.instance:changeSelectCard(self._cfg.equipId)
	end
end

function SeasonEquipSelfChoiceItem:onLongPress()
	self:showDetailTips()
end

function SeasonEquipSelfChoiceItem:onClickDetail()
	self:showDetailTips()
end

function SeasonEquipSelfChoiceItem:onDestroyView()
	if self.icon then
		self.icon:disposeUI()
	end
end

return SeasonEquipSelfChoiceItem
