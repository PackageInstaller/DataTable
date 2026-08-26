-- chunkname: @modules/logic/summon/view/SummonPoolHistoryListItem.lua

module("modules.logic.summon.view.SummonPoolHistoryListItem", package.seeall)

local SummonPoolHistoryListItem = class("SummonPoolHistoryListItem", LuaCompBase)

function SummonPoolHistoryListItem:init(go)
	self._go = go
	self._name = gohelper.findChildText(go, "main/name/#txt_name")
	self._pooltype = gohelper.findChildText(go, "main/type/#txt_type")
	self._time = gohelper.findChildText(go, "main/time/#txt_time")
	self._imgstar = gohelper.findChildImage(go, "main/name/#txt_name/img_star")
	self._gomain = gohelper.findChild(go, "main")
end

function SummonPoolHistoryListItem:addEventListeners()
	return
end

function SummonPoolHistoryListItem:removeEventListeners()
	return
end

function SummonPoolHistoryListItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshItem()
end

function SummonPoolHistoryListItem:_refreshItem()
	if self._mo then
		local name, rare

		if not self._mo.isLuckyBag then
			name, rare = self:getNameAndRare(self._mo.gainId)
		else
			name, rare = self:getLuckyBagNameAndRare(self._mo.gainId, self._mo.poolId)
		end

		self._name.text = self:getStarName(name, rare)
		self._pooltype.text = self._mo.poolName
		self._time.text = self._mo.createTime

		gohelper.setActive(self._imgstar.gameObject, rare >= 4)

		rare = rare or 1

		if not SummonEnum.HistoryColor[rare] then
			local colorStr = SummonEnum.HistoryColor[1]

			if self._colorStr ~= colorStr then
				self._colorStr = colorStr

				SLFramework.UGUI.GuiHelper.SetColor(self._name, colorStr)

				if rare >= 4 then
					SLFramework.UGUI.GuiHelper.SetColor(self._imgstar, colorStr)
				end
			end
		end
	end

	gohelper.setActive(self._gomain, self._mo and true or false)
end

function SummonPoolHistoryListItem:getStarName(name, rare)
	local str = SummonEnum.HistoryNameStarFormat[rare]

	if str then
		return string.format(str, name)
	end

	return name
end

function SummonPoolHistoryListItem:getNameAndRare(gainId)
	local herocfg = HeroConfig.instance:getHeroCO(gainId)

	if herocfg then
		return herocfg.name, herocfg.rare
	end

	local equipcfg = EquipConfig.instance:getEquipCo(gainId)

	if equipcfg then
		return equipcfg.name, equipcfg.rare
	end

	return gainId .. "", 1
end

function SummonPoolHistoryListItem:getLuckyBagNameAndRare(gainId, poolId)
	local luckyBagCfg = SummonConfig.instance:getLuckyBag(poolId, gainId)

	if luckyBagCfg then
		return luckyBagCfg.name, SummonEnum.LuckyBagRare
	else
		return tostring(gainId), SummonEnum.LuckyBagRare
	end
end

function SummonPoolHistoryListItem:onDestroy()
	return
end

return SummonPoolHistoryListItem
