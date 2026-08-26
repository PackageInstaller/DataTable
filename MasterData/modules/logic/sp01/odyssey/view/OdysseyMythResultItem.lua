-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyMythResultItem.lua

module("modules.logic.sp01.odyssey.view.OdysseyMythResultItem", package.seeall)

local OdysseyMythResultItem = class("OdysseyMythResultItem", LuaCompBase)

function OdysseyMythResultItem:init(go)
	self.go = go
	self._gohero = gohelper.findChild(go, "heroitemani")
	self._simageheroicon = gohelper.findChildSingleImage(go, "heroitemani/hero/charactericon")
	self._imagecareer = gohelper.findChildImage(go, "heroitemani/hero/career")
	self._gorank1 = gohelper.findChild(go, "heroitemani/hero/vertical/layout/rankobj/rank1")
	self._gorank2 = gohelper.findChild(go, "heroitemani/hero/vertical/layout/rankobj/rank2")
	self._gorank3 = gohelper.findChild(go, "heroitemani/hero/vertical/layout/rankobj/rank3")
	self._txtlv = gohelper.findChildText(go, "heroitemani/hero/vertical/layout/lv/lvnum")
	self._gostar1 = gohelper.findChild(go, "heroitemani/hero/vertical/#go_starList/star1")
	self._gostar2 = gohelper.findChild(go, "heroitemani/hero/vertical/#go_starList/star2")
	self._gostar3 = gohelper.findChild(go, "heroitemani/hero/vertical/#go_starList/star3")
	self._gostar4 = gohelper.findChild(go, "heroitemani/hero/vertical/#go_starList/star4")
	self._gostar5 = gohelper.findChild(go, "heroitemani/hero/vertical/#go_starList/star5")
	self._gostar6 = gohelper.findChild(go, "heroitemani/hero/vertical/#go_starList/star6")
	self._goequip = gohelper.findChild(go, "heroitemani/equip")
	self._imageequiprare = gohelper.findChildImage(go, "heroitemani/equip/moveContainer/equiprare")
	self._imageequipicon = gohelper.findChildImage(go, "heroitemani/equip/moveContainer/equipIcon")
	self._txtequiplvl = gohelper.findChildText(go, "heroitemani/equip/moveContainer/equiplv/txtequiplv")
	self._gotag = gohelper.findChild(go, "heroitemani/tags")
	self._goEmpty = gohelper.findChild(go, "empty")
	self._goBottomEquip = gohelper.findChild(go, "go_Equip")
end

function OdysseyMythResultItem:setData(heroMo, equipMo, index)
	self.heroMo = heroMo
	self.equipMo = equipMo
	self._index = index

	self:_refreshHero()
	self:_refreshEquip()
	self:_refreshBottomEquip()
	gohelper.setActive(self._gohero, true)
	gohelper.setActive(self._goEmpty, false)
end

function OdysseyMythResultItem:_refreshHero()
	local heroMo = self.heroMo

	if not heroMo then
		logError("heroMo is nil")

		return
	end

	local skinCO = FightConfig.instance:getSkinCO(heroMo.skin)
	local headIconMiddleResUrl = ResUrl.getHeadIconMiddle(skinCO.retangleIcon)

	self._simageheroicon:LoadImage(headIconMiddleResUrl)

	local careerSpriteName = "lssx_" .. tostring(heroMo.config.career)

	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, careerSpriteName)

	if not heroMo.level then
		local level = 0
		local showLevel, _ = HeroConfig.instance:getShowLevel(level)

		self._txtlv.text = showLevel

		self:_refreshLevelList()
		self:_refreshStarList()
	end
end

function OdysseyMythResultItem:_refreshEquip()
	local equipMo = self.equipMo

	if not equipMo then
		gohelper.setActive(self._goequip, false)

		return
	end

	local config = equipMo.config
	local equipIconSpriteName = config.icon

	UISpriteSetMgr.instance:setHerogroupEquipIconSprite(self._imageequipicon, equipIconSpriteName)

	local equipRareSprite = "bianduixingxian_" .. tostring(config.rare)

	UISpriteSetMgr.instance:setHeroGroupSprite(self._imageequiprare, equipRareSprite)

	local level = equipMo.level

	self._txtequiplvl.text = "LV." .. level
end

function OdysseyMythResultItem:_refreshLevelList()
	local heroMo = self.heroMo

	if heroMo then
		if not heroMo.level then
			local level = 0
			local _, rank = HeroConfig.instance:getShowLevel(level)

			for i = 1, 3 do
				local key = "_gorank" .. i

				gohelper.setActive(self[key], i == rank - 1)
			end
		end
	end
end

function OdysseyMythResultItem:_refreshStarList()
	local heroMo = self.heroMo

	if heroMo.config then
		if not heroMo.config.rare then
			local rare = -1

			for i = 1, 6 do
				local key = "_gostar" .. i

				gohelper.setActive(self[key], i <= rare + 1)
			end
		end
	end
end

function OdysseyMythResultItem:setResFunc(cb, obj)
	self._getResFunc = cb
	self._getResObj = obj
end

function OdysseyMythResultItem:_refreshBottomEquip()
	self._gobottomequipList = {}

	local parent = self._goBottomEquip.transform
	local mainCountConstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MainHeroEquipCount)
	local childCount = tonumber(mainCountConstCo.value)

	for i = 1, childCount do
		local child = self._getResFunc(self._getResObj, parent.gameObject)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(child.gameObject, OdysseyHeroGroupEquipItem)

		table.insert(self._gobottomequipList, item)
	end

	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local heroIndex = self._index
	local equipMo = curGroupMO:getOdysseyEquips(heroIndex - 1)

	for index, equipIdParam in ipairs(equipMo.equipUid) do
		local item = self._gobottomequipList[index]

		if not item then
			logError("奥德赛编队界面 装备索引超过上限 index: " .. tostring(index))
		else
			local equipId = tonumber(equipIdParam)

			item:setActive(true)
			item:setInfo(heroIndex, index, equipId, OdysseyEnum.BagType.OnlyDisplay)
			item:refreshUI()
		end
	end

	local itemCount = #self._gobottomequipList
	local equipCount = #equipMo.equipUid

	if equipCount < itemCount then
		for i = equipCount + 1, itemCount do
			local item = self._gobottomequipList[i]

			item:clear()
			item:setActive(false)
		end
	end
end

function OdysseyMythResultItem:onDestroy()
	self._simageheroicon:UnLoadImage()
end

return OdysseyMythResultItem
