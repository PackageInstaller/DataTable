-- chunkname: @modules/logic/bossrush/view/v3a2/V3a5_BossRush_HandBookGroupItem.lua

module("modules.logic.bossrush.view.v3a2.V3a5_BossRush_HandBookGroupItem", package.seeall)

local V3a5_BossRush_HandBookGroupItem = class("V3a5_BossRush_HandBookGroupItem", ListScrollCellExtend)

function V3a5_BossRush_HandBookGroupItem:onInitView()
	self._txttitle = gohelper.findChildText(self.viewGO, "title/#txt_title")
	self._gobossroot = gohelper.findChild(self.viewGO, "#go_bossroot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a5_BossRush_HandBookGroupItem:addEvents()
	return
end

function V3a5_BossRush_HandBookGroupItem:removeEvents()
	return
end

function V3a5_BossRush_HandBookGroupItem:_editableInitView()
	self._items = self:getUserDataTb_()
end

function V3a5_BossRush_HandBookGroupItem:_editableAddEvents()
	self.addEventCb(self, BossRushController.instance, BossRushEvent.V3a2_BossRush_HandBook_SelectMonster, self._onSelectMonster, self)
end

function V3a5_BossRush_HandBookGroupItem:_editableRemoveEvents()
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.V3a2_BossRush_HandBook_SelectMonster, self._onSelectMonster, self)
end

function V3a5_BossRush_HandBookGroupItem:onUpdateMO(mo)
	self._txttitle.text = mo.config.name

	if not self._itemRes then
		local res = BossRushEnum.ResPath.v3a2_bossrush_handbookitem

		self._itemRes = self.viewContainer:getRes(res)
	end

	if mo.bossGroup then
		local claimIndex = self:_getClaimBouns(mo.bossGroup)

		gohelper.CreateObjList(self, self._createItem, mo.bossGroup, self._gobossroot, self._itemRes, V3a2_BossRush_HandBookItem)
	end
end

function V3a5_BossRush_HandBookGroupItem:_getClaimBouns(bossGroup)
	if bossGroup then
		for i, mo in ipairs(bossGroup) do
			if mo:hasClaimBonus() then
				return i
			end
		end

		return 0
	end
end

function V3a5_BossRush_HandBookGroupItem:_createItem(obj, data, index)
	obj:onUpdateMO(data)

	self._items[index] = obj
end

function V3a5_BossRush_HandBookGroupItem:_onSelectMonster()
	for _, item in ipairs(self._items) do
		item:refreshSelect()
	end
end

function V3a5_BossRush_HandBookGroupItem:onDestroyView()
	return
end

return V3a5_BossRush_HandBookGroupItem
