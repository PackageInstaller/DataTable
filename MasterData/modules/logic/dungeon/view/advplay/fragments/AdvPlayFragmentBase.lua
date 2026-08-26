-- chunkname: @modules/logic/dungeon/view/advplay/fragments/AdvPlayFragmentBase.lua

module("modules.logic.dungeon.view.advplay.fragments.AdvPlayFragmentBase", package.seeall)

local AdvPlayFragmentBase = class("AdvPlayFragmentBase", SimpleListItem)

function AdvPlayFragmentBase:onSelectChange(isSelect)
	gohelper.setActive(self.viewGO, isSelect)
end

return AdvPlayFragmentBase
