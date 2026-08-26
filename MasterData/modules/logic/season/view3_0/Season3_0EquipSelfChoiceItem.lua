-- chunkname: @modules/logic/season/view3_0/Season3_0EquipSelfChoiceItem.lua

module("modules.logic.season.view3_0.Season3_0EquipSelfChoiceItem", package.seeall)

local Season3_0EquipSelfChoiceItem = class("Season3_0EquipSelfChoiceItem", ListScrollCellExtend)

function Season3_0EquipSelfChoiceItem:init(go)
	Season3_0EquipSelfChoiceItem.super.init(self, go)

	self._gocard = gohelper.findChild(self.viewGO, "go_card")
	self._goselect = gohelper.findChild(self.viewGO, "go_select")
	self._gotag = gohelper.findChild(self.viewGO, "tag")
	self._txtcount = gohelper.findChildTextMesh(self.viewGO, "tag/bg/#txt_count")
end

function Season3_0EquipSelfChoiceItem:addEvents()
	return
end

function Season3_0EquipSelfChoiceItem:removeEvents()
	return
end

function Season3_0EquipSelfChoiceItem:onUpdateMO(mo)
	self._mo = mo
	self._cfg = mo.cfg

	self:refreshUI()
end

function Season3_0EquipSelfChoiceItem:refreshUI()
	self:checkCreateIcon()
	self.icon:updateData(self._cfg.equipId)
	gohelper.setActive(self._goselect, Activity104SelfChoiceListModel.instance.curSelectedItemId == self._cfg.equipId)

	local count = Activity104Model.instance:getItemCount(self._cfg.equipId, self._view.viewParam.actId)

	self._txtcount.text = tostring(count)
end

function Season3_0EquipSelfChoiceItem:checkCreateIcon()
	if not self.icon then
		local path = self._view.viewContainer:getSetting().otherRes[2]
		local go = self._view:getResInst(path, self._gocard, "icon")

		self.icon = MonoHelper.addNoUpdateLuaComOnceToGo(go, Season3_0CelebrityCardEquip)

		self.icon:setClickCall(self.onClickSelf, self)
		self.icon:setLongPressCall(self.onLongPress, self)
	end
end

function Season3_0EquipSelfChoiceItem:showDetailTips()
	local data = {
		actId = self._view.viewParam.actId
	}

	MaterialTipController.instance:showMaterialInfoWithData(MaterialEnum.MaterialType.EquipCard, self._cfg.equipId, data)
end

function Season3_0EquipSelfChoiceItem:onClickSelf()
	if Activity104SelfChoiceListModel.instance.curSelectedItemId ~= self._cfg.equipId then
		Activity104EquipSelfChoiceController.instance:changeSelectCard(self._cfg.equipId)
	end
end

function Season3_0EquipSelfChoiceItem:onLongPress()
	self:showDetailTips()
end

function Season3_0EquipSelfChoiceItem:onDestroyView()
	if self.icon then
		self.icon:disposeUI()
	end
end

return Season3_0EquipSelfChoiceItem
