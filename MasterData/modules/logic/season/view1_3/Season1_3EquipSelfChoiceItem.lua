-- chunkname: @modules/logic/season/view1_3/Season1_3EquipSelfChoiceItem.lua

module("modules.logic.season.view1_3.Season1_3EquipSelfChoiceItem", package.seeall)

local Season1_3EquipSelfChoiceItem = class("Season1_3EquipSelfChoiceItem", ListScrollCellExtend)

function Season1_3EquipSelfChoiceItem:init(go)
	Season1_3EquipSelfChoiceItem.super.init(self, go)

	self._gocard = gohelper.findChild(self.viewGO, "go_card")
	self._goselect = gohelper.findChild(self.viewGO, "go_select")
	self._gotag = gohelper.findChild(self.viewGO, "tag")
	self._txtcount = gohelper.findChildTextMesh(self.viewGO, "tag/bg/#txt_count")
end

function Season1_3EquipSelfChoiceItem:addEvents()
	return
end

function Season1_3EquipSelfChoiceItem:removeEvents()
	return
end

function Season1_3EquipSelfChoiceItem:onUpdateMO(mo)
	self._mo = mo
	self._cfg = mo.cfg

	self:refreshUI()
end

function Season1_3EquipSelfChoiceItem:refreshUI()
	self:checkCreateIcon()
	self.icon:updateData(self._cfg.equipId)
	gohelper.setActive(self._goselect, Activity104SelfChoiceListModel.instance.curSelectedItemId == self._cfg.equipId)

	local count = Activity104Model.instance:getItemCount(self._cfg.equipId, self._view.viewParam.actId)

	self._txtcount.text = tostring(count)
end

function Season1_3EquipSelfChoiceItem:checkCreateIcon()
	if not self.icon then
		local path = self._view.viewContainer:getSetting().otherRes[2]
		local go = self._view:getResInst(path, self._gocard, "icon")

		self.icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, Season1_3CelebrityCardEquip)

		self.icon:setClickCall(self.onClickSelf, self)
		self.icon:setLongPressCall(self.onLongPress, self)
	end
end

function Season1_3EquipSelfChoiceItem:showDetailTips()
	local data = {
		actId = self._view.viewParam.actId
	}

	MaterialTipController.instance:showMaterialInfoWithData(MaterialEnum.MaterialType.EquipCard, self._cfg.equipId, data)
end

function Season1_3EquipSelfChoiceItem:onClickSelf()
	if Activity104SelfChoiceListModel.instance.curSelectedItemId ~= self._cfg.equipId then
		Activity104EquipSelfChoiceController.instance:changeSelectCard(self._cfg.equipId)
	end
end

function Season1_3EquipSelfChoiceItem:onLongPress()
	self:showDetailTips()
end

function Season1_3EquipSelfChoiceItem:onDestroyView()
	if self.icon then
		self.icon:disposeUI()
	end
end

return Season1_3EquipSelfChoiceItem
