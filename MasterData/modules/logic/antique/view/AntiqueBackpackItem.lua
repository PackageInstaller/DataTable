-- chunkname: @modules/logic/antique/view/AntiqueBackpackItem.lua

module("modules.logic.antique.view.AntiqueBackpackItem", package.seeall)

local AntiqueBackpackItem = class("AntiqueBackpackItem", ListScrollCellExtend)

function AntiqueBackpackItem:init(go)
	self.go = go
	self._itemIcon = IconMgr.instance:getCommonItemIcon(go)
end

function AntiqueBackpackItem:addEvents()
	return
end

function AntiqueBackpackItem:removeEvents()
	return
end

function AntiqueBackpackItem:onUpdateMO(mo)
	self._mo = mo

	self._itemIcon:setMOValue(MaterialEnum.MaterialType.Antique, mo.id, 1)
	self._itemIcon:isShowCount(false)
	self._itemIcon:isShowName(true)
end

function AntiqueBackpackItem:onDestroyView()
	TaskDispatcher.cancelTask(self._showItem, self)
end

return AntiqueBackpackItem
