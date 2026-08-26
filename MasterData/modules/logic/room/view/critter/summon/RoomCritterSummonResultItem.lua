-- chunkname: @modules/logic/room/view/critter/summon/RoomCritterSummonResultItem.lua

module("modules.logic.room.view.critter.summon.RoomCritterSummonResultItem", package.seeall)

local RoomCritterSummonResultItem = class("RoomCritterSummonResultItem", ListScrollCellExtend)

function RoomCritterSummonResultItem:onInitView()
	self._goegg = gohelper.findChild(self.viewGO, "#go_egg")
	self._gocritter = gohelper.findChild(self.viewGO, "#go_critter")
	self._imagequality = gohelper.findChildImage(self.viewGO, "#go_critter/#image_quality")
	self._imagequalitylight = gohelper.findChildImage(self.viewGO, "#go_critter/#image_qualitylight")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_critter/#simage_icon")
	self._simagecard = gohelper.findChildSingleImage(self.viewGO, "#go_critter/#simage_card")
	self._btnopenEgg = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_openEgg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterSummonResultItem:addEvents()
	self._btnopenEgg:AddClickListener(self._btnopenEggOnClick, self)
end

function RoomCritterSummonResultItem:removeEvents()
	self._btnopenEgg:RemoveClickListener()
end

function RoomCritterSummonResultItem:_btnopenEggOnClick()
	if not self.critterMO or self:_isLockOp() then
		return
	end

	self:_setLockTime(0.5)

	if self._isOpenEgg then
		local isMaturity = self.critterMO:isMaturity()

		CritterController.instance:openRoomCritterDetailView(not isMaturity, self.critterMO)

		return
	end

	local param = {
		mode = RoomSummonEnum.SummonType.Summon,
		critterMo = self.critterMO
	}

	CritterSummonController.instance:openSummonGetCritterView(param, true)
	self:setOpenEgg(true)
end

function RoomCritterSummonResultItem:_isLockOp()
	if self._nextLockTime and self._nextLockTime > Time.time then
		return true
	end

	return false
end

function RoomCritterSummonResultItem:_setLockTime(lockTime)
	self._nextLockTime = Time.time + tonumber(lockTime)
end

function RoomCritterSummonResultItem:_editableInitView()
	self._iconRareScaleMap = {
		1.3,
		1.3,
		1.3,
		1.8,
		1.8
	}
	self._isOpenEgg = false
	self._eggDict = {}
	self._simageiconTrs = self._simageicon.transform
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	self:setOpenEgg(self._isOpenEgg)
end

function RoomCritterSummonResultItem:_editableAddEvents()
	return
end

function RoomCritterSummonResultItem:_editableRemoveEvents()
	return
end

function RoomCritterSummonResultItem:onUpdateMO(mo)
	self.critterMO = mo

	gohelper.setActive(self.viewGO, mo)
	self:_refreshUI()
end

function RoomCritterSummonResultItem:setOpenEgg(isOpen)
	if isOpen == true then
		self._isOpenEgg = true
	end

	gohelper.setActive(self._gocritter, self._isOpenEgg and self._isLaseOpenEgg)
end

function RoomCritterSummonResultItem:playAnim(isOpen)
	local temp = isOpen == true

	if self._isLaseOpenEgg == temp then
		return false
	end

	self._isLaseOpenEgg = temp

	local eggComp = self._eggDict[self._lastRate]

	if eggComp then
		if self._isLaseOpenEgg then
			eggComp:playOpenAnim()
		else
			eggComp:playIdleAnim()
		end
	end

	gohelper.setActive(self._gocritter, self._isLaseOpenEgg)
	self._animatorPlayer:Play(self._isLaseOpenEgg and "open" or "close", nil, nil)
	self:_setLockTime(0.5)

	return true
end

function RoomCritterSummonResultItem:isOpenEgg()
	return self._isOpenEgg
end

function RoomCritterSummonResultItem:onSelect(isSelect)
	return
end

RoomCritterSummonResultItem._EGG_NAME_DICT = {
	"roomcrittersummonresult_egg1.prefab",
	"roomcrittersummonresult_egg1.prefab",
	"roomcrittersummonresult_egg1.prefab",
	"roomcrittersummonresult_egg2.prefab",
	"roomcrittersummonresult_egg3.prefab"
}

function RoomCritterSummonResultItem:_setShowCompByRare(rare)
	if self._lastRate == rare then
		return
	end

	self._lastRate = rare

	if not self._eggDict[rare] then
		local eggRes = CritterEnum.QualityEggSummomResNameMap[rare]

		if eggRes then
			local path = ResUrl.getRoomCritterEggPrefab(eggRes)
			local childGO = self._view:getResInst(path, self._goegg)

			transformhelper.setLocalScale(childGO.transform, 0.55, 0.55, 0.55)

			local eggComp = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, RoomGetCritterEgg)

			eggComp.eggRare = rare
			self._eggDict[rare] = eggComp

			if self._isLaseOpenEgg then
				eggComp:playOpenAnim()
			else
				eggComp:playIdleAnim()
			end
		end
	end

	for trare, eggComp in pairs(self._eggDict) do
		gohelper.setActive(eggComp.go, trare == rare)
	end
end

function RoomCritterSummonResultItem:openEggAnim()
	return
end

function RoomCritterSummonResultItem:_refreshUI()
	if not self.critterMO then
		return
	end

	local rare = CritterConfig.instance:getCritterRare(self.critterMO.defineId)

	if rare then
		UISpriteSetMgr.instance:setCritterSprite(self._imagequality, CritterEnum.QualityEggImageNameMap[rare])
		UISpriteSetMgr.instance:setCritterSprite(self._imagequalitylight, CritterEnum.QualityEggLightImageNameMap[rare])

		if not self._iconRareScaleMap[rare] then
			do
				local scale = 1

				transformhelper.setLocalScale(self._simageiconTrs, scale, scale, scale)
				self:_setShowCompByRare(rare)
			end

			local iconName = CritterConfig.instance:getCritterHeadIcon(self.critterMO:getSkinId())

			if not string.nilorempty(iconName) then
				self._simageicon:LoadImage(ResUrl.getCritterLargeIcon(iconName))
			end

			local rareCfg = CritterConfig.instance:getCritterRareCfg(rare)

			if rareCfg then
				self._simagecard:LoadImage(ResUrl.getRoomCritterIcon(rareCfg.cardRes))
			end
		end
	end
end

function RoomCritterSummonResultItem:onDestroyView()
	self._simageicon:UnLoadImage()
	self._simagecard:UnLoadImage()

	for _, eggComp in pairs(self._eggDict) do
		eggComp:onDestroy()
	end
end

return RoomCritterSummonResultItem
