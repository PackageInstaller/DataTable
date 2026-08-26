-- chunkname: @modules/ugui/icon/common/CommonMonsterItem.lua

module("modules.ugui.icon.common.CommonMonsterItem", package.seeall)

local CommonMonsterItem = class("CommonMonsterItem", LuaCompBase)

function CommonMonsterItem:init(go)
	self.go = go
	self._callback = nil
	self._callbackObj = nil
	self._btnClick = nil
	self._lvTxt = gohelper.findChildText(go, "lvltxt") or gohelper.findChildText(go, "verticalList/lvnum")
	self._nameCnTxt = gohelper.findChildText(go, "namecn")
	self._cardIcon = gohelper.findChildSingleImage(go, "charactericon")
	self._careerIcon = gohelper.findChildImage(go, "career")
	self._rareObj = gohelper.findChild(go, "rareobj")
	self._rareIconImage = gohelper.findChildImage(go, "cardrare")
	self._front = gohelper.findChildImage(go, "front")
	self._rankObj = gohelper.findChild(go, "rankobj")

	self:_initObj()
end

function CommonMonsterItem:_initObj()
	if self._rareObj then
		self._rareGos = self:getUserDataTb_()

		for i = 1, 5 do
			self._rareGos[i] = gohelper.findChild(self._rareObj, "rare" .. tostring(i))
		end
	end

	self._rankGOs = self:getUserDataTb_()

	for i = 1, 3 do
		local rankGO = gohelper.findChild(self._rankObj, "rank" .. i)

		table.insert(self._rankGOs, rankGO)
	end
end

function CommonMonsterItem:_fillStarContent(level)
	local _, rank = HeroConfig.instance:getShowLevel(level)

	for i = 1, 3 do
		local rankGO = self._rankGOs[i]

		gohelper.setActive(rankGO, i == rank - 1)
	end
end

function CommonMonsterItem:addClickListener(callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj
	self._btnClick = self._btnClick or SLFramework.UGUI.UIClickListener.Get(self.go)

	self._btnClick:AddClickListener(self._onItemClick, self)
end

function CommonMonsterItem:removeClickListener()
	self._callback = nil
	self._callbackObj = nil

	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end
end

function CommonMonsterItem:removeEventListeners()
	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end
end

function CommonMonsterItem:onUpdateMO(monsterCO)
	self._monsterCO = monsterCO
	self._lvTxt.text = HeroConfig.instance:getShowLevel(monsterCO.level)

	if self._nameCnTxt then
		self._nameCnTxt.text = monsterCO.name
	end

	local skinCO = FightConfig.instance:getSkinCO(monsterCO.skinId)

	if skinCO then
		self._cardIcon:LoadImage(ResUrl.getHeadIconLarge(skinCO.retangleIcon))
	end

	UISpriteSetMgr.instance:setCommonSprite(self._careerIcon, "lssx_" .. tostring(monsterCO.career))
	UISpriteSetMgr.instance:setHeroGroupSprite(self._front, "bg_pz00" .. "1")

	if self._rareObj then
		self:_fillRareContent(monsterCO.rare)
		gohelper.setActive(self._rareObj, monsterCO.rare >= 0)
	end

	if self._nameCnTxt then
		gohelper.setActive(self._nameCnTxt.gameObject, not string.nilorempty(monsterCO.name))
	end

	if self._rankObj then
		self:_fillStarContent(monsterCO.level)
	end
end

function CommonMonsterItem:_fillRareContent(value)
	for i = 1, 5 do
		gohelper.setActive(self._rareGos[i], i <= value)
	end
end

function CommonMonsterItem:_onItemClick()
	if self._callback then
		if self._callbackObj then
			self._callback(self._callbackObj, self._monsterCO)
		else
			self._callback(self._monsterCO)
		end
	end
end

function CommonMonsterItem:onDestroy()
	self._cardIcon:UnLoadImage()
end

return CommonMonsterItem
