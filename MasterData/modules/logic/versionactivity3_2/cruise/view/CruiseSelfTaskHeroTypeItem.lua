-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseSelfTaskHeroTypeItem.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseSelfTaskHeroTypeItem", package.seeall)

local CruiseSelfTaskHeroTypeItem = class("CruiseSelfTaskHeroTypeItem", LuaCompBase)

function CruiseSelfTaskHeroTypeItem:init(go)
	self.go = go
	self._gotitle = gohelper.findChild(go, "go_title")
	self._txttitle = gohelper.findChildText(go, "go_title/bg/txt_title")
	self._goheros = gohelper.findChild(go, "go_heros")
	self._goheroitem = gohelper.findChild(go, "go_heros/go_heroitem")

	gohelper.setActive(self._goheroitem, false)

	self._heroItems = {}
end

function CruiseSelfTaskHeroTypeItem:refresh(typeCo)
	self._typeConfig = typeCo

	gohelper.setActive(self.go, true)

	self._txttitle.text = self._typeConfig.type

	self:_refreshHeros()
end

function CruiseSelfTaskHeroTypeItem:_refreshHeros()
	local heros = string.splitToNumber(self._typeConfig.heroId, "#")

	for i = 1, #heros do
		if not self._heroItems[i] then
			local go = gohelper.cloneInPlace(self._goheroitem)

			self._heroItems[i] = CruiseSelfTaskHeroTypeHeroItem.New()

			self._heroItems[i]:init(go)
		end

		self._heroItems[i]:refresh(heros[i])
	end
end

function CruiseSelfTaskHeroTypeItem:destroy()
	if self._heroItems then
		for _, heroItem in pairs(self._heroItems) do
			heroItem:destroy()
		end

		self._heroItems = nil
	end
end

return CruiseSelfTaskHeroTypeItem
