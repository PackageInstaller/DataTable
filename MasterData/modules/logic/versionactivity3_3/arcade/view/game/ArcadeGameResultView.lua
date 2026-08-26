-- chunkname: @modules/logic/versionactivity3_3/arcade/view/game/ArcadeGameResultView.lua

module("modules.logic.versionactivity3_3.arcade.view.game.ArcadeGameResultView", package.seeall)

local ArcadeGameResultView = class("ArcadeGameResultView", BaseView)

function ArcadeGameResultView:onInitView()
	self._gowin = gohelper.findChild(self.viewGO, "pointResult/Victory")
	self._gowinchess = gohelper.findChild(self.viewGO, "pointResult/Victory/#go_chess")
	self._gofail = gohelper.findChild(self.viewGO, "pointResult/Defeat")
	self._gofailchess = gohelper.findChild(self.viewGO, "pointResult/Defeat/#go_chess")
	self._goreward = gohelper.findChild(self.viewGO, "pointResult/#go_reward")
	self._gorewardItem = gohelper.findChild(self.viewGO, "pointResult/#go_reward/#go_rewardItem")
	self._gocollection = gohelper.findChild(self.viewGO, "Info/#go_item/#scroll_collection/viewport/content")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "Info/#go_item/#scroll_collection/viewport/content/#go_collectionitem")
	self._goweapon = gohelper.findChild(self.viewGO, "Info/#go_item/#go_weapon")
	self._goweaponItem = gohelper.findChild(self.viewGO, "Info/#go_item/#go_weapon/#go_weaponitem")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "Info/hero/mask/simage_icon")
	self._gohpbar = gohelper.findChild(self.viewGO, "Info/hero/#go_hp")
	self._gohpitem = gohelper.findChild(self.viewGO, "Info/hero/#go_hp/go_hpitem")
	self._gobase = gohelper.findChild(self.viewGO, "Info/hero/#go_base")
	self._gobaseItem = gohelper.findChild(self.viewGO, "Info/hero/#go_base/go_baseitem")
	self._txtroomnum = gohelper.findChildText(self.viewGO, "Info/#go_room/#txt_num")
	self._txtkillnum = gohelper.findChildText(self.viewGO, "Info/#go_kill/#txt_num")
	self._txtcoinsnum = gohelper.findChildText(self.viewGO, "Info/#go_coins/#txt_num")
	self._txttapenum = gohelper.findChildText(self.viewGO, "Info/#go_tape/#txt_num")
	self._gonewcharacter = gohelper.findChild(self.viewGO, "Info/#go_tips")
	self._imagelv = gohelper.findChildImage(self.viewGO, "Info/#go_lv/#image_lv")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeGameResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	NavigateMgr.instance:addEscape(ViewName.ArcadeGameResultView, self._btncloseOnClick, self)
end

function ArcadeGameResultView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function ArcadeGameResultView:_btncloseOnClick()
	if self._isReset then
		ArcadeGameController.instance:resetGame()
	else
		ArcadeController.instance:openHallView()
		ArcadeGameController.instance:closeGameView()
	end

	self:closeThis()
end

function ArcadeGameResultView:_editableInitView()
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
end

function ArcadeGameResultView:onUpdateParam()
	self._passLevelCount = 0
	self._killMonsterNum = 0
	self._allCoinNum = 0
	self._maxScore = 0
	self._bookAddScore = 0
	self._attrDict = {}
	self._collectionDataList = {}
	self._weaponDataList = {}

	if self.viewParam then
		self._isWin = self.viewParam.isWin
		self._isReset = self.viewParam.isReset
		self._characterId = self.viewParam.characterId
		self._passLevelCount = self.viewParam.passLevelCount
		self._killMonsterNum = self.viewParam.killMonsterNum
		self._allCoinNum = self.viewParam.allCoinNum
		self._maxScore = self.viewParam.maxScore
		self._attrDict = self.viewParam.attrDict
		self._collectionDataList = self.viewParam.collectionDataList
		self._weaponDataList = self.viewParam.weaponDataList
		self._hasUnlockCharacter = self.viewParam.hasUnlockCharacter
		self._bookAddScore = self.viewParam.bookAddScore
	end
end

function ArcadeGameResultView:onOpen()
	self:onUpdateParam()
	self:setRewardItems()
	self:setCollections()
	self:setWeapons()
	self:setHP()
	self:setAttr()

	self._txttapenum.text = self._bookAddScore

	gohelper.setActive(self._gonewcharacter, self._hasUnlockCharacter)

	local characterIcon = ArcadeConfig.instance:getCharacterIcon2(self._characterId)
	local characterIconPath = ResUrl.getEliminateIcon(characterIcon)

	self._simageheroicon:LoadImage(characterIconPath, self.onLoadCharacterIconFinished, self)

	self._txtroomnum.text = self._passLevelCount
	self._txtkillnum.text = self._killMonsterNum
	self._txtcoinsnum.text = self._allCoinNum

	local icon = ArcadeConfig.instance:getArcadeGradeIcon(self._maxScore)

	UISpriteSetMgr.instance:setV3a3EliminateSprite(self._imagelv, icon)
	gohelper.setActive(self._gowin, self._isWin)
	gohelper.setActive(self._gofail, not self._isWin)

	if self._isWin then
		AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_win)
	else
		AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_over)
	end

	self._animator:Play(self._isWin and "open" or "open1")
	UIBlockMgr.instance:startBlock(ArcadeEnum.BlockKey.ResultView)
	TaskDispatcher.cancelTask(self._onBlockTimeEnd, self)
	TaskDispatcher.runDelay(self._onBlockTimeEnd, self, TimeUtil.OneSecond)
end

function ArcadeGameResultView:_onBlockTimeEnd()
	UIBlockMgr.instance:endBlock(ArcadeEnum.BlockKey.ResultView)
end

function ArcadeGameResultView:onLoadCharacterIconFinished()
	if not self._simageheroicon then
		return
	end

	self._simageheroicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()

	local posArr = ArcadeConfig.instance:getCharacterIcon2Offset(self._characterId)
	local posX = posArr and tonumber(posArr[1])
	local posY = posArr and tonumber(posArr[2])
	local trans = self._simageheroicon.transform

	if posX and posY then
		transformhelper.setLocalPosXY(trans, posX, posY)
	end

	local scaleArr = ArcadeConfig.instance:getCharacterIcon2Scale(self._characterId)
	local scaleX = scaleArr and tonumber(scaleArr[1])
	local scaleY = scaleArr and tonumber(scaleArr[2])

	if posX and posY then
		transformhelper.setLocalScale(trans, scaleX, scaleY, 1)
	end
end

function ArcadeGameResultView:setRewardItems()
	local resIdList = {
		ArcadeGameEnum.CharacterResource.Cassette,
		ArcadeGameEnum.CharacterResource.Diamond
	}

	gohelper.CreateObjList(self, self._onCreateRewardItem, resIdList, self._goreward, self._gorewardItem)
end

function ArcadeGameResultView:_onCreateRewardItem(obj, data, index)
	local id = data

	if self._attrDict then
		if not self._attrDict[id] then
			local count = 0

			if id == ArcadeGameEnum.CharacterResource.Cassette then
				count = count + self._bookAddScore
			end

			local imageicon = gohelper.findChildImage(obj, "icon")
			local txtnum = gohelper.findChildText(obj, "#txt_num")
			local icon = ArcadeConfig.instance:getAttributeIcon(id)

			UISpriteSetMgr.instance:setV3a3EliminateSprite(imageicon, icon)

			txtnum.text = count

			gohelper.setActive(obj, count > 0)
		end
	end
end

function ArcadeGameResultView:setCollections()
	self:_clearCollectionItems()
	gohelper.CreateObjList(self, self._onCreateCollectionItem, self._collectionDataList, self._gocollection, self._gocollectionitem)
end

function ArcadeGameResultView:_onCreateCollectionItem(obj, data, index)
	local collectionId = data.id
	local collectionItem = self:getUserDataTb_()

	collectionItem.go = obj
	collectionItem.simageIcon = gohelper.findChildSingleImage(obj, "#image_icon")

	local icon = ArcadeConfig.instance:getCollectionIcon(collectionId)
	local iconPath = ResUrl.getEliminateIcon(icon)

	collectionItem.simageIcon:LoadImage(iconPath)

	collectionItem.txtNum = gohelper.findChildText(obj, "#txt_num")
	collectionItem.txtNum.text = data.durability or ""
	self._collectionItemDict[data] = collectionItem
end

function ArcadeGameResultView:setWeapons()
	self:_clearWeaponItems()
	gohelper.CreateObjList(self, self._onCreateWeaponItem, self._weaponDataList, self._goweapon, self._goweaponItem)
end

function ArcadeGameResultView:_onCreateWeaponItem(obj, data, index)
	local weaponItem = self:getUserDataTb_()

	weaponItem.go = obj
	weaponItem.gohas = gohelper.findChild(obj, "has")
	weaponItem.imagedurability = gohelper.findChildImage(obj, "has/image_durability")
	weaponItem.simageIcon = gohelper.findChildSingleImage(obj, "has/#image_icon")
	weaponItem.goempty = gohelper.findChild(obj, "empty")

	local weaponId = data.id

	if weaponId then
		local icon = ArcadeConfig.instance:getCollectionIcon(weaponId)
		local iconPath = ResUrl.getEliminateIcon(icon)

		weaponItem.simageIcon:LoadImage(iconPath)

		local durabilityProgress = 1
		local useTimes = data.useTimes
		local durability = data.durability

		if useTimes and durability and durability > 0 then
			local remainDurability = math.max(0, durability - useTimes)

			durabilityProgress = remainDurability / durability
		end

		weaponItem.imagedurability.fillAmount = durabilityProgress
	end

	gohelper.setActive(weaponItem.gohas, weaponId)
	gohelper.setActive(weaponItem.goempty, not weaponId)

	self._weaponItemList[index] = weaponItem
end

function ArcadeGameResultView:setHP()
	if not self._attrDict[ArcadeGameEnum.BaseAttr.hpCap] then
		local maxShowCount = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.MaxShowHpCount, true)

		self.showHpCount = math.min(self._attrDict[ArcadeGameEnum.BaseAttr.hpCap], maxShowCount)

		gohelper.CreateNumObjList(self._gohpbar, self._gohpitem, self.showHpCount, self._onCreateHpItem, self)
	end
end

function ArcadeGameResultView:_onCreateHpItem(obj, index)
	local golight = gohelper.findChild(obj, "light")
	local imagehp = gohelper.findChildImage(obj, "light")

	if not self._attrDict[ArcadeGameEnum.BaseAttr.hp] then
		local curHp = 0
		local belongHpSeqIndex = ArcadeGameHelper.getHPSeqIndex(curHp, self.showHpCount, index)

		if belongHpSeqIndex and belongHpSeqIndex >= 0 then
			local imgIndex = ArcadeConfig.instance:getHpColorImgIndex(belongHpSeqIndex)
			local img = string.format("v3a3_eliminate_heart_%s", imgIndex)

			UISpriteSetMgr.instance:setV3a3EliminateSprite(imagehp, img)
			gohelper.setActive(golight, true)
		else
			gohelper.setActive(golight, false)
		end

		local gohpnum = gohelper.findChild(obj, "go_hpNum")
		local txthpnum = gohelper.findChildText(obj, "go_hpNum/#txt_num")
		local isLastHpItem = index == self.showHpCount

		if isLastHpItem then
			txthpnum.text = curHp
		end

		gohelper.setActive(gohpnum, isLastHpItem)
	end
end

function ArcadeGameResultView:setAttr()
	local showAttrList = {
		ArcadeGameEnum.BaseAttr.attack,
		ArcadeGameEnum.BaseAttr.defense,
		ArcadeGameEnum.CharacterResource.RespawnTimes
	}

	gohelper.CreateObjList(self, self._onCreateAttrItem, showAttrList, self._gobase, self._gobaseItem)
end

function ArcadeGameResultView:_onCreateAttrItem(obj, data, index)
	local imagebase = gohelper.findChildImage(obj, "#txt_num/#image_base")
	local icon = ArcadeConfig.instance:getAttributeIcon(data)

	UISpriteSetMgr.instance:setV3a3EliminateSprite(imagebase, icon)

	local txtNum = gohelper.findChildText(obj, "#txt_num")

	if not self._attrDict[data] then
		txtNum.text = self._attrDict[data]
	end
end

function ArcadeGameResultView:setCharacterInfo()
	return
end

function ArcadeGameResultView:onClose()
	TaskDispatcher.cancelTask(self._onBlockTimeEnd, self)
	UIBlockMgr.instance:endBlock(ArcadeEnum.BlockKey.ResultView)
end

function ArcadeGameResultView:_clearCollectionItems()
	if self._collectionItemDict then
		for _, collectionItem in pairs(self._collectionItemDict) do
			collectionItem.simageIcon:UnLoadImage()
		end
	end

	self._collectionItemDict = {}
end

function ArcadeGameResultView:_clearWeaponItems()
	if self._weaponItemList then
		for _, weaponItem in ipairs(self._weaponItemList) do
			weaponItem.simageIcon:UnLoadImage()
		end
	end

	self._weaponItemList = {}
end

function ArcadeGameResultView:onDestroyView()
	self._simageheroicon:UnLoadImage()
end

return ArcadeGameResultView
