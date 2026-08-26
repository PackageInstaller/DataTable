-- chunkname: @modules/logic/handbook/view/HandBookCharacterSwitchViewEffect.lua

module("modules.logic.handbook.view.HandBookCharacterSwitchViewEffect", package.seeall)

local HandBookCharacterSwitchViewEffect = class("HandBookCharacterSwitchViewEffect", BaseView)

function HandBookCharacterSwitchViewEffect:onInitView()
	self._simagecoverbg1 = gohelper.findChildSingleImage(self.viewGO, "#go_center/handbookcharacterview/#go_cover/#simage_coverbg1")
	self._simagepeper55bg = gohelper.findChildSingleImage(self.viewGO, "#go_center/handbookcharacterview/#go_cover/#simage_peper55bg")
	self._simagepeper55left = gohelper.findChildSingleImage(self.viewGO, "#go_center/handbookcharacterview/#go_cover/#simage_peper55bg/#simge_peper55left")
	self._simagepeper55right = gohelper.findChildSingleImage(self.viewGO, "#go_center/handbookcharacterview/#go_cover/#simage_peper55bg/#simge_peper55right")
	self._gocorvercharacter4 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_corvercharacter4")
	self._gocorvercharacter5 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_corvercharacter5")
	self._gocorvercharacter6 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_corvercharacter6")
	self._gocorvercharacter7 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_corvercharacter7")
	self._gofrpos4 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_frpos4")
	self._gofrpos5 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_frpos5")
	self._gofrpos6 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_frpos6")
	self._gofrpos7 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_frpos7")
	self._gocharacter1 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_character1")
	self._gocharacter2 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_character2")
	self._gocharacter3 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_character3")
	self._gocharacter4 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_character4")
	self._gocharacter5 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_character5")
	self._gocharacter6 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_character6")
	self._gocharacter7 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_character7")
	self._gosepos1 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_sepos1")
	self._gosepos2 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_sepos2")
	self._gosepos3 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_sepos3")
	self._gosepos4 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_sepos4")
	self._gosepos5 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_sepos5")
	self._gosepos6 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_sepos6")
	self._gosepos7 = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_sepos7")
	self._goupleft = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_upleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandBookCharacterSwitchViewEffect:addEvents()
	return
end

function HandBookCharacterSwitchViewEffect:removeEvents()
	return
end

function HandBookCharacterSwitchViewEffect:_editableInitView()
	self._simagepeperleft01 = gohelper.findChildSingleImage(self.viewGO, "#go_center/handbookcharacterview/peper_left01")
	self._simagepeperright01 = gohelper.findChildSingleImage(self.viewGO, "#go_center/handbookcharacterview/peper_right01")
	self._simagepeperleft = gohelper.findChildSingleImage(self.viewGO, "#go_center/handbookcharacterview/#go_leftpage/peper_left")
	self._simagepagebgright = gohelper.findChildSingleImage(self.viewGO, "#go_center/handbookcharacterview/#go_rightpage/peper_right")
	self._simagepagebgleft = gohelper.findChildSingleImage(self.viewGO, "#go_center/handbookcharacterview/#simage_pagebg/peper_left")
	self._simagepeperright = gohelper.findChildSingleImage(self.viewGO, "#go_center/handbookcharacterview/#simage_pagebg/peper_right")
	self._gocoverleft = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_cover/left")
	self._prefabPosList = {}
	self._allTypePosList = {}
	self._goTrsList = self:getUserDataTb_()

	local characterGos = {
		self._gocharacter1,
		self._gocharacter2,
		self._gocharacter3,
		self._gocharacter4,
		self._gocharacter5,
		self._gocharacter6,
		self._gocharacter7,
		self._gocorvercharacter4,
		self._gocorvercharacter5,
		self._gocorvercharacter6,
		self._gocorvercharacter7
	}
	local posGos = {
		self._gosepos1,
		self._gosepos2,
		self._gosepos3,
		self._gosepos4,
		self._gosepos5,
		self._gosepos6,
		self._gosepos7,
		self._gofrpos4,
		self._gofrpos5,
		self._gofrpos6,
		self._gofrpos7
	}

	for i, characterGo in ipairs(characterGos) do
		local trs = characterGo.transform
		local x, y, z = transformhelper.getLocalPos(trs)

		table.insert(self._prefabPosList, {
			x = x,
			y = y,
			z = z
		})
		table.insert(self._goTrsList, trs)
	end

	for i, posGo in ipairs(posGos) do
		local x, y, z = transformhelper.getLocalPos(posGo.transform)

		table.insert(self._allTypePosList, {
			x = x,
			y = y,
			z = z
		})
		gohelper.setActive(posGo, false)
	end
end

function HandBookCharacterSwitchViewEffect:reallyOpenView(heroType)
	self.heroType = heroType

	self:_refresh()
end

function HandBookCharacterSwitchViewEffect:_refresh()
	local isCurAll = self:_isAllHeroType()

	if self._isLastAllHeroType == isCurAll then
		return
	end

	self._isLastAllHeroType = isCurAll

	if isCurAll then
		if not self._allTypePosList then
			local posList = self._prefabPosList

			for i, trs in ipairs(self._goTrsList) do
				local p = posList[i]

				transformhelper.setLocalPos(trs, p.x, p.y, p.z)
			end

			local resParam = self:_getBGParam()
			local leftResPath = ResUrl.getHandbookCharacterIcon(resParam.left)
			local rightResPath = ResUrl.getHandbookCharacterIcon(resParam.right)

			self._simagepeper55left:LoadImage(leftResPath)
			self._simagepeperleft01:LoadImage(leftResPath)
			self._simagepeperleft:LoadImage(leftResPath)
			self._simagepagebgleft:LoadImage(leftResPath)
			self._simagepeper55right:LoadImage(rightResPath)
			self._simagepeperright01:LoadImage(rightResPath)
			self._simagepeperright:LoadImage(rightResPath)
			self._simagepagebgright:LoadImage(rightResPath)
			gohelper.setActive(self._simagecoverbg1, not isCurAll)
			gohelper.setActive(self._gocoverleft, not isCurAll)
			gohelper.setActive(self._simagepeper55bg, isCurAll)
			gohelper.setActive(self._goupleft, isCurAll)
		end
	end
end

function HandBookCharacterSwitchViewEffect:_isAllHeroType()
	return self.heroType == HandbookEnum.HeroType.AllHero
end

function HandBookCharacterSwitchViewEffect:_getBGParam()
	return HandbookEnum.BookBGRes[self.heroType] or HandbookEnum.BookBGRes[HandbookEnum.HeroType.Common]
end

function HandBookCharacterSwitchViewEffect:onUpdateParam()
	return
end

function HandBookCharacterSwitchViewEffect:onOpen()
	self.addEventCb(self, HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, self.reallyOpenView, self)
	self:_refresh()
end

function HandBookCharacterSwitchViewEffect:onClose()
	self.removeEventCb(self, HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, self.reallyOpenView, self)
end

function HandBookCharacterSwitchViewEffect:onDestroyView()
	self._simagepeper55left:UnLoadImage()
	self._simagepeperleft01:UnLoadImage()
	self._simagepeperleft:UnLoadImage()
	self._simagepagebgleft:UnLoadImage()
	self._simagepeper55right:UnLoadImage()
	self._simagepeperright01:UnLoadImage()
	self._simagepeperright:UnLoadImage()
	self._simagepagebgright:UnLoadImage()
end

return HandBookCharacterSwitchViewEffect
