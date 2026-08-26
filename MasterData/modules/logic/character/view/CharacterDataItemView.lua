-- chunkname: @modules/logic/character/view/CharacterDataItemView.lua

module("modules.logic.character.view.CharacterDataItemView", package.seeall)

local CharacterDataItemView = class("CharacterDataItemView", BaseView)

function CharacterDataItemView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._simagecentericon = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_centericon")
	self._simagelefticon = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_lefticon")
	self._simagerighticon = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_righticon")
	self._simagerighticon2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_righticon2")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_mask")
	self._gopointercontainer = gohelper.findChild(self.viewGO, "content/bottom/#go_pointcontainer")
	self._gopointeritem = gohelper.findChild(self.viewGO, "content/bottom/#go_pointcontainer/#go_pointitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDataItemView:addEvents()
	return
end

function CharacterDataItemView:removeEvents()
	return
end

function CharacterDataItemView:onLeftPageClick()
	if not self.needShowPageBtn then
		return
	end

	if self.skinIndex <= 1 then
		return
	end

	self.skinIndex = self.skinIndex - 1
	self.skinId = self.skinList[self.skinIndex]

	self.contentAnimator:Play("switch_left", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_character_data_item_page)
end

function CharacterDataItemView:onRightPageClick()
	if not self.needShowPageBtn then
		return
	end

	if self.skinIndex >= self.skinLen then
		return
	end

	self.skinIndex = self.skinIndex + 1
	self.skinId = self.skinList[self.skinIndex]

	self.contentAnimator:Play("switch_right", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_character_data_item_page)
end

function CharacterDataItemView:initItem()
	self.itemList = self:getUserDataTb_()

	local item

	for i = 1, 3 do
		item = self:getUserDataTb_()
		item.itemGo = gohelper.findChild(self.viewGO, "content/itembg" .. i)
		item.animator = item.itemGo:GetComponent(typeof(UnityEngine.Animator))
		item.itemshow = gohelper.findChild(item.itemGo, "go_itemshow")
		item.itemlock = gohelper.findChild(item.itemGo, "go_itemlock")
		item.lockicon = gohelper.findChild(item.itemlock, "go_lockicon")
		item.unlocktxt = gohelper.findChildText(item.lockicon, "unlocktext")
		item.treasurego = gohelper.findChild(item.itemGo, "go_itemlock/go_treasure")
		item.goitemshow = gohelper.findChild(item.itemGo, "go_itemshow")
		item.title1 = gohelper.findChildText(item.itemGo, "go_itemshow/itemtxtbg/itemnamelist/itemname1")
		item.title2 = gohelper.findChildText(item.itemGo, "go_itemshow/itemtxtbg/itemnamelist/itemname2")
		item.titleen = gohelper.findChildText(item.itemGo, "go_itemshow/itemtxtbg/itemnamelist/itemnameen")
		item.text = gohelper.findChildText(item.itemGo, "go_itemshow/itemtxtbg/descScroll/Viewport/descContent/itemtext")
		item.icon = gohelper.findChildSingleImage(item.itemGo, "go_itemshow/itemicon")
		item.goimageestimate = gohelper.findChild(item.itemGo, "go_itemshow/itemtxtbg/estimate/image_estimate")
		item.imageestimate = gohelper.findChildImage(item.itemGo, "go_itemshow/itemtxtbg/estimate/image_estimate/image_estimate")
		item.txtestimate = gohelper.findChildText(item.itemGo, "go_itemshow/itemtxtbg/estimate/txt_estimate")
		item.treasurebtn = gohelper.findChildButtonWithAudio(item.itemlock, "clickarea")

		item.treasurebtn:AddClickListener(self._onTreasureBtnClick, self, i)
		table.insert(self.itemList, item)
	end
end

function CharacterDataItemView:_editableInitView()
	gohelper.setActive(self._gopointeritem, false)

	self.goContent = gohelper.findChild(self.viewGO, "content")

	self._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	self._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_fm_circle.png"))
	self._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	self._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	self._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	self._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	self:initItem()

	self._effectsList = self:getUserDataTb_()
	self._dataList = {}

	CharacterController.instance:registerCallback(CharacterEvent.HeroDataAddUnlockItemFail, self._unlockItemCallbackFail, self)
	CharacterController.instance:registerCallback(CharacterEvent.HeroDataAddUnlockItem, self._unlockItemCallback, self)
end

function CharacterDataItemView:onUpdateParam()
	self:_refreshUI()
end

function CharacterDataItemView:onOpen()
	gohelper.setActive(self.viewGO, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_pieces_open)

	self._heroId = CharacterDataModel.instance:getCurHeroId()
	self.heroMo = HeroModel.instance:getByHeroId(self._heroId)

	self:initSkinInfo()
	self:_statStart()
	self:_refreshUI()
end

function CharacterDataItemView.sortSkin(skin1, skin2)
	return skin1 < skin2
end

function CharacterDataItemView:initSkinInfo()
	local hadSkinList = self.heroMo.skinInfoList
	local configSkinList = CharacterDataConfig.instance:geCharacterSkinIdList(self._heroId)

	self.skinList = {
		CharacterDataConfig.DefaultSkinDataKey
	}

	local dataConfig = CharacterDataConfig.instance:getDataConfig()

	for _, skinInfo in ipairs(hadSkinList) do
		if tabletool.indexOf(configSkinList, skinInfo.skin) then
			local dataCo = dataConfig[self._heroId][skinInfo.skin]

			if dataCo and dataCo[CharacterEnum.CharacterDataItemType.Item] then
				table.insert(self.skinList, skinInfo.skin)
			end
		end
	end

	self.skinId = self.skinList[1]

	table.sort(self.skinList, CharacterDataItemView.sortSkin)

	self.skinIndex = 1
	self.skinLen = #self.skinList
	self.needShowPageBtn = self.skinLen > 1

	if self.needShowPageBtn then
		self.contentAnimator = self.goContent:GetComponent(typeof(UnityEngine.Animator))
		self.contentAnimatorEvent = self.goContent:GetComponent(typeof(ZProj.AnimationEventWrap))

		self.contentAnimatorEvent:AddEventListener("refresh", self._refreshUI, self)
	end

	self:initPointItem()
	self:initPageBtnItem()
end

function CharacterDataItemView:initPointItem()
	if not self.needShowPageBtn then
		return
	end

	self.pointItemList = self.pointItemList or self:getUserDataTb_()

	local pointerItem

	for index, skinId in ipairs(self.skinList) do
		pointerItem = self.pointItemList[index]

		if not self.pointItemList[index] then
			pointerItem = {
				go = gohelper.cloneInPlace(self._gopointeritem, "point_" .. index)
			}
			pointerItem.gonormalstar = gohelper.findChild(pointerItem.go, "#go_nomalstar")
			pointerItem.golightstar = gohelper.findChild(pointerItem.go, "#go_lightstar")
			pointerItem.click = gohelper.getClick(pointerItem.go)

			pointerItem.click:AddClickListener(self.pointOnClick, self, index)
			table.insert(self.pointItemList, pointerItem)
		end

		gohelper.setActive(pointerItem.go, true)
	end

	for i = #self.skinList + 1, #self.pointItemList do
		gohelper.setActive(self.pointItemList[i].go, false)
	end
end

function CharacterDataItemView:initPageBtnItem()
	self.btnLeftPage = gohelper.findChildClick(self.viewGO, "content/#btn_leftpage")
	self.btnRightPage = gohelper.findChildClick(self.viewGO, "content/#btn_rightpage")

	if not self.needShowPageBtn then
		return
	end

	self.btnLeftPage:AddClickListener(self.onLeftPageClick, self)
	self.btnRightPage:AddClickListener(self.onRightPageClick, self)
end

function CharacterDataItemView:pointOnClick(index)
	self.skinIndex = index
	self.skinId = self.skinList[self.skinIndex]

	self:_refreshUI()
end

function CharacterDataItemView:initDrag()
	if #self.skinList <= 1 then
		return
	end

	self._itemDrag = SLFramework.UGUI.UIDragListener.Get(self.goContent)

	self._itemDrag:AddDragBeginListener(self._onDragBegin, self)
	self._itemDrag:AddDragEndListener(self._onDragEnd, self)
end

function CharacterDataItemView:_onDragBegin(param, pointerEventData)
	self.startDragPosX = pointerEventData.position.x
end

function CharacterDataItemView:_onDragEnd(param, pointerEventData)
	local endDragPosX = pointerEventData.position.x

	if math.abs(endDragPosX - self.startDragPosX) > 30 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_character_view_switch)

		if endDragPosX > self.startDragPosX then
			self.skinIndex = self.skinIndex - 1

			if self.skinIndex < 1 then
				self.skinIndex = #self.skinList
			end
		else
			self.skinIndex = self.skinIndex + 1

			if self.skinIndex > #self.skinList then
				self.skinIndex = 1
			end
		end

		self.skinId = self.skinList[self.skinIndex]

		self:_refreshUI()
	end
end

function CharacterDataItemView:_refreshUI()
	self:refreshItem()
	self:refreshPointItem()
	self:refreshPageBtn()
end

function CharacterDataItemView:_unlockItemCallback(heroId, itemId)
	UIBlockMgr.instance:endBlock("playRewardsAnimtion")
	UIBlockMgrExtend.setNeedCircleMv(true)

	if itemId >= 2 and itemId <= 4 then
		self.itemList[itemId - 1].treasurebtn:RemoveClickListener()

		self._dataList[itemId - 1].isGetRewards = true
	end
end

function CharacterDataItemView:_unlockItemCallbackFail()
	UIBlockMgr.instance:endBlock("playRewardsAnimtion")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function CharacterDataItemView:refreshItem()
	local item, lockCO, islock, isGetRewards, unlockitems, tag, tip, data

	for i = 1, 3 do
		item = self.itemList[i]
		data = self._dataList[i]

		if not self._dataList[i] then
			data = {}
			self._dataList[i] = data
		end

		data.itemId = i + 1
		lockCO = CharacterDataConfig.instance:getCharacterDataCO(self._heroId, self.skinId, CharacterEnum.CharacterDataItemType.Item, i)
		islock = CharacterDataConfig.instance:checkLockCondition(lockCO)
		isGetRewards = HeroModel.instance:checkGetRewards(self._heroId, data.itemId)
		data.islock = islock
		data.isGetRewards = isGetRewards

		if islock then
			gohelper.setActive(item.itemshow, false)
			gohelper.setActive(item.itemlock, true)
			gohelper.setActive(item.lockicon, true)
			gohelper.setActive(item.treasurego, false)

			unlockitems = string.splitToNumber(lockCO.unlockConditine, "#")
			tag = {}
			tag = unlockitems[1] == CharacterDataConfig.unlockConditionEpisodeID and {
				DungeonConfig.instance:getEpisodeCO(unlockitems[2]).name
			} or unlockitems[1] == CharacterDataConfig.unlockConditionRankID and {
				unlockitems[2] - 1
			} or {
				unlockitems[2]
			}
			tip = ToastConfig.instance:getToastCO(lockCO.lockText).tips
			tip = GameUtil.getSubPlaceholderLuaLang(tip, tag)
			item.unlocktxt.text = tip
		else
			self:_setItemTitlePos(item.title1, item.title2, item.titleen, lockCO.title)

			item.titleen.text = lockCO.titleEn
			item.text.text = LuaUtil.replaceSpace(lockCO.text)

			self:_refreshEstimate(item, lockCO)
			item.icon:LoadImage(ResUrl.getCharacterDataPic(lockCO.icon))

			if string.nilorempty(lockCO.unlockRewards) then
				gohelper.setActive(item.itemshow, true)
				gohelper.setActive(item.itemlock, false)
			elseif isGetRewards then
				gohelper.setActive(item.itemshow, true)
				gohelper.setActive(item.itemlock, false)
			else
				self:addAniEffect(item.goitemshow, data.itemId, self._heroId)
				gohelper.setActive(item.itemshow, false)
				gohelper.setActive(item.itemlock, true)
				gohelper.setActive(item.lockicon, false)
				gohelper.setActive(item.treasurego, true)
				self:checkAndCloneMaterialIfNeed(item.treasurego, i)
			end
		end
	end
end

function CharacterDataItemView:checkAndCloneMaterialIfNeed(treasurego, index)
	if self._cloneMaterialMap and self._cloneMaterialMap[index] then
		return
	end

	self._cloneMaterialMap = self._cloneMaterialMap or {}
	self._cloneMaterialMap[index] = true

	local image = gohelper.findChildImage(treasurego, "image")
	local material = image.material

	image.material = UnityEngine.Object.Instantiate(material)

	local materialPropsCtrl = image.gameObject:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	materialPropsCtrl.mas:Clear()
	materialPropsCtrl.mas:Add(image.material)
end

function CharacterDataItemView:refreshPointItem()
	if not self.pointItemList then
		return
	end

	for index, pointItem in ipairs(self.pointItemList) do
		gohelper.setActive(pointItem.gonormalstar, index ~= self.skinIndex)
		gohelper.setActive(pointItem.golightstar, index == self.skinIndex)
	end
end

function CharacterDataItemView:refreshPageBtn()
	if not self.needShowPageBtn then
		gohelper.setActive(self.btnLeftPage.gameObject, false)
		gohelper.setActive(self.btnRightPage.gameObject, false)

		return
	end

	gohelper.setActive(self.btnLeftPage.gameObject, self.skinIndex ~= 1)
	gohelper.setActive(self.btnRightPage.gameObject, self.skinIndex ~= self.skinLen)
end

function CharacterDataItemView:_onTreasureBtnClick(index)
	local data = self._dataList[index]

	if data.islock then
		local lockCo = CharacterDataConfig.instance:getCharacterDataCO(self._heroId, self.heroMo.skin, CharacterEnum.CharacterDataItemType.Item, index)
		local unlockitems = string.splitToNumber(lockCo.unlockConditine, "#")

		GameFacade.showToast(lockCo.lockText, unlockitems[1] == CharacterDataConfig.unlockConditionEpisodeID and DungeonConfig.instance:getEpisodeCO(unlockitems[2]).name or unlockitems[1] == CharacterDataConfig.unlockConditionRankID and unlockitems[2] - 1 or unlockitems[2])
	elseif not data.isGetRewards then
		local item = self.itemList[index]

		gohelper.setActive(item.itemshow, true)
		gohelper.setActive(item.itemlock, false)
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("playRewardsAnimtion")
		self:playAniEffect(data.itemId)
		item.animator:Play(UIAnimationName.Unlock)
		TaskDispatcher.runDelay(function()
			HeroRpc.instance:sendItemUnlockRequest(self._heroId, data.itemId)
		end, nil, 2)
	end
end

function CharacterDataItemView:_refreshEstimate(item, lockCO)
	local estimateParam = lockCO.estimate

	if string.nilorempty(estimateParam) then
		gohelper.setActive(item.goimageestimate.gameObject, false)

		item.txtestimate.text = luaLang("notestimate")
	else
		gohelper.setActive(item.goimageestimate.gameObject, true)

		local estimates = string.split(estimateParam, "#")
		local estimateType = estimates[1]
		local estimateNumber = estimates[2]

		UISpriteSetMgr.instance:setUiCharacterSprite(item.imageestimate, "fh" .. tostring(estimateType))

		item.txtestimate.text = string.format("%s", tostring(estimateNumber))
	end
end

function CharacterDataItemView:addAniEffect(goitemshow, id, heroId)
	local unlockItemIdList = HeroModel.instance:getByHeroId(heroId).itemUnlock

	if self:checkItemIsLock(unlockItemIdList, id) and not self._effectsList[id] then
		self._effectsList[id] = self:getUserDataTb_()

		local graphics = goitemshow:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true)

		if graphics then
			local iter = graphics:GetEnumerator()

			while iter:MoveNext() do
				if not gohelper.findChildTextMesh(iter.Current.gameObject, "") then
					local effect = UIEffectManager.instance:getUIEffect(iter.Current.gameObject, typeof(Coffee.UIEffects.UIDissolve))

					table.insert(self._effectsList[id], effect)
				end
			end
		end

		for i, effect in ipairs(self._effectsList[id]) do
			effect.width = 0.2
			effect.softness = 1
			effect.color = "#956C4B"
			effect.effectFactor = 0
		end
	end
end

function CharacterDataItemView:playAniEffect(id)
	local effects = self._effectsList[id]

	if not effects then
		return
	end

	for _, effect in ipairs(self._effectsList[id]) do
		effect.effectFactor = 1
	end

	self._tweenIds = self._tweenIds or {}

	if self._tweenIds[id] then
		ZProj.TweenHelper.KillById(self._tweenIds[id])

		self._tweenIds[id] = nil
	end

	self._tweenIds[id] = ZProj.TweenHelper.DOTweenFloat(0, 2.85, 2.85, function(value)
		if value >= 0.35 then
			local effects = self._effectsList[id]

			if not effects then
				return
			end

			for i, effect in ipairs(effects) do
				effect.effectFactor = 1 - (value - 0.35) / 2.5
			end
		end
	end)
end

function CharacterDataItemView:checkItemIsLock(list, id)
	for _, k in pairs(list) do
		if k == id then
			return false
		end
	end

	return true
end

function CharacterDataItemView:_statStart()
	self._viewTime = ServerTime.now()
end

function CharacterDataItemView:_statEnd()
	if not self._heroId then
		return
	end

	if self._viewTime then
		local duration = ServerTime.now() - self._viewTime
		local var_33_0 = self.viewParam and (type(self.viewParam) == "table" and self.viewParam.fromHandbookView or false)
		local isHandbook = true

		goto label_33_0

		::label_33_0::

		CharacterController.instance:statCharacterData(StatEnum.EventName.ReadHeroItem, self._heroId, nil, duration, isHandbook)
	end

	self._viewTime = nil
end

function CharacterDataItemView:_setItemTitlePos(line1, line2, txtTitleEn, title)
	local titleList = not string.nilorempty(title) and string.split(title, "\n") or {}
	local targetLine1PosX = -1.18
	local targetTitleEnPosX = -23.2
	local targetLine1PosY = 13.2
	local targetTitleEnPosY = -30.17

	if GameUtil.getTabLen(titleList) > 1 then
		local line1PosX = {
			-21.7,
			-21.7,
			-24.8,
			-24.8
		}
		local line2PosX = {
			62.1,
			52.221,
			60.6,
			46.9
		}
		local titelEnPosX = {
			-52.32,
			-81.1,
			-73.4,
			-73.4
		}
		local titleLen = GameUtil.utf8len(GameUtil.trimInput(title))

		if titleLen - 6 <= 4 then
			if not (titleLen - 6) then
				local posIndex = 4

				targetLine1PosX = line1PosX[posIndex]
				targetTitleEnPosX = titelEnPosX[posIndex]
				targetLine1PosY = 30
				targetTitleEnPosY = -47.03

				local targetLine2PosX = line2PosX[posIndex]

				recthelper.setAnchorX(line2.transform, targetLine2PosX)

				line2.text = titleList[2]
			end
		end
	else
		line2.text = ""
	end

	line1.text = titleList[1]

	recthelper.setAnchor(line1.transform, targetLine1PosX, targetLine1PosY)
	recthelper.setAnchor(txtTitleEn.transform, targetTitleEnPosX, targetTitleEnPosY)
end

function CharacterDataItemView:onClose()
	gohelper.setActive(self.viewGO, false)
	self:_statEnd()
end

function CharacterDataItemView:onDestroyView()
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroDataAddUnlockItemFail, self._unlockItemCallbackFail, self)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroDataAddUnlockItem, self._unlockItemCallback, self)

	if self._itemDrag then
		self._itemDrag:RemoveDragBeginListener()
		self._itemDrag:RemoveDragEndListener()
	end

	self._simagebg:UnLoadImage()
	self._simagecentericon:UnLoadImage()
	self._simagelefticon:UnLoadImage()
	self._simagerighticon:UnLoadImage()
	self._simagerighticon2:UnLoadImage()
	self._simagemask:UnLoadImage()

	for _, item in ipairs(self.itemList) do
		item.icon:UnLoadImage()
		item.treasurebtn:RemoveClickListener()
	end

	if self.pointItemList then
		for _, pointerItem in ipairs(self.pointItemList) do
			pointerItem.click:RemoveClickListener()
		end
	end

	if self._tweenIds then
		for _, tweenId in pairs(self._tweenIds) do
			ZProj.TweenHelper.KillById(tweenId)
		end

		self._tweenIds = nil
	end

	if self.needShowPageBtn then
		self.btnLeftPage:RemoveClickListener()
		self.btnRightPage:RemoveClickListener()
		self.contentAnimatorEvent:RemoveAllEventListener()
	end
end

return CharacterDataItemView
