-- chunkname: @modules/logic/fight/view/FightTechniqueSelectItem.lua

module("modules.logic.fight.view.FightTechniqueSelectItem", package.seeall)

local FightTechniqueSelectItem = class("FightTechniqueSelectItem", LuaCompBase)

function FightTechniqueSelectItem:init(go)
	self.go = go
	self._selectGos = self:getUserDataTb_()

	for i = 1, 2 do
		local go = gohelper.findChild(go, "item" .. i)

		table.insert(self._selectGos, go)
	end

	self._click = gohelper.getClickWithAudio(self.go)
end

function FightTechniqueSelectItem:updateItem(param)
	self._index = param.index
	self._id = param.id

	transformhelper.setLocalPos(self.go.transform, param.pos, 0, 0)
end

function FightTechniqueSelectItem:setView(view)
	self._view = view
end

function FightTechniqueSelectItem:setSelect(index)
	local isSelect = self._index == index

	gohelper.setActive(self._selectGos[1], isSelect)
	gohelper.setActive(self._selectGos[2], not isSelect)
end

function FightTechniqueSelectItem:addEventListeners()
	self._click:AddClickListener(self._onClickThis, self)
end

function FightTechniqueSelectItem:removeEventListeners()
	self._click:RemoveClickListener()
end

function FightTechniqueSelectItem:onDestroy()
	self._view = nil
end

function FightTechniqueSelectItem:_onClickThis()
	self._view:setSelect(self._index)
end

return FightTechniqueSelectItem
