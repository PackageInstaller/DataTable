-- chunkname: @modules/logic/sp02/paomian/enter/view/Sp02_PaoMainEnterHeroItem.lua

module("modules.logic.sp02.paomian.enter.view.Sp02_PaoMainEnterHeroItem", package.seeall)

local Sp02_PaoMainEnterHeroItem = class("Sp02_PaoMainEnterHeroItem", LuaCompBase)

function Sp02_PaoMainEnterHeroItem:init(go)
	self.go = go
	self._btnClick = gohelper.getClickWithDefaultAudio(self.go)
end

function Sp02_PaoMainEnterHeroItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Sp02_PaoMainEnterHeroItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Sp02_PaoMainEnterHeroItem:_btnClickOnClick()
	ViewMgr.instance:openView(ViewName.Sp02_HeroLibraryView, {
		heroList = self._heroCoList,
		selectIndex = self._index
	})
end

function Sp02_PaoMainEnterHeroItem:onUpdateMO(index, heroCo, heroCoList)
	self._index = index
	self._heroCo = heroCo
	self._heroCoList = heroCoList

	self:refreshUI()
end

function Sp02_PaoMainEnterHeroItem:refreshUI()
	return
end

function Sp02_PaoMainEnterHeroItem:onDestroy()
	return
end

return Sp02_PaoMainEnterHeroItem
