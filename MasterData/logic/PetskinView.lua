-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petskin/view/PetskinView.lua

module("logic.extensions.petskin.view.PetskinView", package.seeall)

local PetskinView = class("PetskinView", ViewComponent)

PetskinView.TYPE_PET_MO = 1
PetskinView.TYPE_SHOP = 2

local Special_Map = {
	[18001] = true
}

function PetskinView:ctor()
	PetskinView.super.ctor(self)

	self._cacheV3 = Vector3.New(0, 0, 0)
end

function PetskinView:buildUI()
	PetskinView.super.buildUI(self)

	self._btnClose = self:getBtn("Left/btn_close")
	self.goldBarCon = self:getGo("goldBarCon")
	self.btnSkill = self:getGo("Middle/btns/btnSkill")
	self.btninfor = self:getGo("Middle/btns/btn_infor")
	self.btnPoster = self:getGo("Middle/btns/btnPoster")
	self.tagWear = self:getGo("info/tagWear")
	self.tagBuy = self:getGo("info/tagBuy")
	self.btnWear = self:getGo("info/btnWear")
	self.btnBuy = self:getGo("info/btnBuy")
	self.txtBuy = self:getTxt("info/btnBuy/Text")
	self.btnSkin = self:getGo("info/btnSkin")
	self.passive = self:getGo("passive")
	self.txtPassiveDesc = self:getTxt("passive/txtDesc")
	self.txtTime = self:getTxt("info/txtTime")
	self.txtAttr = self:getTxt("info/skillDesc/txtAttr")
	self.txLock = self:getTxt("info/skillDesc/txLock")
	self.txtDesc = self:getTxt("info/skillDesc/txtDesc")
	self._btnLeft = self:getBtn("Middle/btn_left")
	self._btnRight = self:getBtn("info/btn_right")
	self.right_red_point = self:getGo("info/btn_right/red_point")

	GameUtil.SetActive(self.right_red_point, false)

	self._btnSwitch = self:getBtn("Middle/btns/btnSwitch")
	self._switchOn = goutil.findChild(self._btnSwitch.gameObject, "on")
	self._switchOff = goutil.findChild(self._btnSwitch.gameObject, "off")

	local dragContent = self:getGo("mask/role/dragContent")
	local rawImg = goutil.findChild(dragContent, "role_image_1")

	self._rawImgDrag = RawImageDrag.New(dragContent, rawImg, true)

	self._rawImgDrag:setUpdateCallback(self._updateSelectCell, self)
	self._rawImgDrag:setClickCallback(self._onClickCell, self)

	self._dragContent = dragContent
	self._bubble = self:getGo("mask/role/bubble")
	self._maskImg = self:getGo("mask"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self._mask = self:getGo("mask"):GetComponent("Mask")
	self._maskImg.enabled = false
	self._mask.enabled = false

	local cell = self:getGo("info/skillDesc/cell")

	self.ScrollView = self:getGo("info/skillDesc/ScrollView")
	self.txtNoAttr = self:getGo("info/skillDesc/txtNoAttr")
	self._tableview = ScrollerList.create(self.ScrollView, cell, GameUtil.handler(self._updatePropCell, self))
	self.parentGo = self:getGo("info/con")
	self.cell = self:getGo("info/cell")
	self.page = PageStackComponent.New()

	self.page:init(self.parentGo, self.cell, 200, 172, 5)
	self.page:setCallBack(GameUtil.handler(self.updateSkinCell, self), GameUtil.handler(self.selectSkinEnd, self), GameUtil.handler(self.clearSkinCell, self))

	self._btnRename = self:getBtn("Middle/btns/btnRename")
	self._btnsSingleLine = self:getGo("Middle/btns"):GetComponent(ComponentType.UILayoutSingleLine)
	self._righttween = self:getGo("info"):GetComponent(ComponentType.TweenPosition)
	self._downtween = self:getGo("passive"):GetComponent(ComponentType.TweenPosition)
	self._lefttween = self:getGo("Middle"):GetComponent(ComponentType.TweenPosition)
	self._spineInterface = self:getGo("mask/role/spineInterface")
	self._extendView = self:getGo("mask/role/extendView")
	self._bg2Go = self:getGo("bg2")
	self.btnEnter = self:getGo("Middle/btns/btnEnter")
	self._btnStory = self:getGo("Middle/btns/btnStory")
	self._imgRedPointStory = self:getGo("Middle/btns/btnStory/imgRedPoint")
end

function PetskinView:bindEvents()
	PetskinView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnLeft:AddClickListener(function()
		self:_onClickSwitch(true)
	end, self)
	self._btnRight:AddClickListener(function()
		self:_onClickSwitch(false)
	end, self)
	self._btnSwitch:AddClickListener(function()
		self._isLihui = not self._isLihui

		self:_updateState()
	end)
	GameUtil.addClickHandler(self.btninfor, self.onClickZoom, self)
	GameUtil.addClickHandler(self.btnPoster, self.onClickPoster, self)
	GameUtil.addClickHandler(self.btnSkill, self.onSkillClick, self)
	GameUtil.addClickHandler(self.btnWear, self.onWearClick, self)
	GameUtil.addClickHandler(self.btnBuy, self.onBuyClick, self)
	GameUtil.addClickHandler(self.btnSkin, self.onClickSkin, self)
	GameUtil.addClickHandler(self.btnEnter, self.onClickSkinEnterEffect, self)
	GameUtil.addClickHandler(self._btnStory, self.onClickBtnStory, self)
	self._btnRename:AddClickListener(self._onClickbtnRename, self)
end

function PetskinView:unbindEvents()
	PetskinView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnSwitch:RemoveClickListener()
	GameUtil.rmClickHandler(self.btninfor)
	GameUtil.rmClickHandler(self.btnPoster)
	GameUtil.rmClickHandler(self.btnSkill)
	GameUtil.rmClickHandler(self.btnWear)
	GameUtil.rmClickHandler(self.btnBuy)
	GameUtil.rmClickHandler(self.btnSkin)
	GameUtil.rmClickHandler(self._btnStory)
	self._btnRename:RemoveClickListener()
end

function PetskinView:destroyUI()
	PetskinView.super.destroyUI(self)
end

function PetskinView:onEnter()
	PetskinView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.EndStory, self._onEndStory, self)
	self.addGEvent(self, GlobalNotify.PM_StoryPrizeTotalInfoRes, self._onStoryTotalInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_StoryPrizeGainPrizeRes, self._onStoryPrizeGainPrizeRes, self)
	self.addGEvent(self, GlobalNotify.SetPetSkinOtherNameRes, self._onSetPetSkinOtherNameRes, self)
	self.addGEvent(self, MsEnum.Notify_SpineInterfaceBagExtension, self._notify_SpineInterfaceBagExtension, self)
	self.addGEvent(self, BagModel.NotifyName_PetShowViewPlayPetAnim, self._onClickCell, self)

	self._isLihui = true
	self.currCfg = nil

	local param = self:getOpenParam() or {}
	local type = param[1]
	local data = param[2]
	local skinId = param[3]

	self.viewStatus = type
	self._petPhotoShows = {}

	self:_updateState()

	self._curIndex = 1

	if type == PetskinView.TYPE_PET_MO then
		self.petMo = data

		local list = BagPetsController.instance:getBagPets()

		if self.petMo == nil then
			self.petMo = list[1]
		end

		if skinId == nil then
			skinId = self.petMo.curFaceId
		end

		local skinList = PetSkinConfig.instance:getPetSkinListBySkinId(self.petMo.curFaceId) or {}

		self._curViewDatas = self:_filterSkinNotOpen(skinList)

		for i, v in ipairs(self._curViewDatas) do
			if v.skinId == skinId then
				self._curIndex = i
			end
		end
	else
		skinId = data

		local cfg = PetSkinConfig.instance:getPetSkinCfg(data)

		if cfg then
			local skinList = PetSkinConfig.instance:getPetSkinListBySkinId(skinId) or {}

			self._curViewDatas = self:_filterSkinNotOpen(skinList)

			for i, v in ipairs(self._curViewDatas) do
				if v.skinId == skinId then
					self._curIndex = i

					break
				end
			end
		else
			printError("没配置皮肤 id:" .. skinId)
			self:close()
		end
	end

	local count = 3

	if #self._curViewDatas == 1 then
		count = 1
	end

	self.page:setLimitCount((#self._curViewDatas > 5 or nil) and 5)
	self.page:reloadData(self._curViewDatas, self._curIndex)
	self._rawImgDrag:setDragEnabled(#self._curViewDatas > 1)
	self:centerOnIndex(self._curIndex, false)
	PetskinController.instance:sendGetInfo(function()
		self.page:reloadData(self._curViewDatas, self._curIndex)
		self:centerOnIndex(self._curIndex, false)
	end)
	GlobalDispatcher:addListener(GlobalNotify.BagPetChanged, self.UpdataPetChanged, self)

	self._isFold = false

	self:_resetNode()

	self._storyId = PetSkinConfig.instance:getStoryId(skinId)

	local hasGainPrize = StoryPrizeModel.instance:storyHasGainPrize(self._storyId)

	GameUtil.SetActive(self._btnStory, self._storyId > 0)
	GameUtil.SetActive(self._imgRedPointStory, not hasGainPrize)
end

function PetskinView:onEnterFinished()
	PetskinView.super.onEnterFinished(self)
end

function PetskinView:onExit()
	PetskinView.super.onExit(self)
	self.page:clearUI()
	self:stopTimer()
	RedPointController.instance:unregRedPoint(self.right_red_point)
	GlobalDispatcher:removeListener(GlobalNotify.BagPetChanged, self.UpdataPetChanged, self)
	self._tableview:dispose()
	PetCvController.instance:turnOffCurCv()
	self:_resetNode()
	self:_onUnReloadSpineInterfaceCompOfSkeletonAnimation()

	for _, v in pairs(self._petPhotoShows) do
		v:destroy()
	end

	self._petPhotoShows = nil
	self._curPetPhotoShow = nil
end

function PetskinView:onExitFinished()
	PetskinView.super.onExitFinished(self)
end

function PetskinView:_onClickClose()
	if self._isFold then
		self:onClickZoom()
	else
		self:close()
	end
end

function PetskinView:startTimer(time)
	self:stopTimer()

	self.limitTime = time

	self:onTimer()
	settimer(1, self.onTimer, self, true)
end

function PetskinView:stopTimer()
	self.limitTime = nil

	removetimer(self.onTimer, self)
end

function PetskinView:UpdataPetChanged()
	if self.viewStatus == PetskinView.TYPE_PET_MO and self.petMo then
		self.petMo = BagPetsController.instance:getPet(self.petMo.petId)
	end

	self:updateBtnStatus()
end

function PetskinView:onSkillClick()
	if self.currCfg then
		local skinId = self.currCfg.skinId
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:previewBattle(raceId, skinId)
		end
	end
end

function PetskinView:onClickZoom()
	if self.currCfg then
		self._isFold = not self._isFold

		if self._isFold and not self:_isInteractable(self.currCfg.skinId) then
			self._isFold = false

			local skinId = self.currCfg.skinId

			UIStateManager.instance:push(ViewName.PetDrawing, skinId)

			return
		end

		self:_stopTween()
		self:_startTween()
		self._rawImgDrag:setDragEnabled(not self._isFold)
		goutil.setActive(self._bg2Go, not self._isFold)
	end
end

function PetskinView:onClickPoster()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_PET_HAIBAO)

	if self.currCfg then
		local skinId = self.currCfg.skinId
		local list = PetSkinConfig.instance:getPosterList(skinId)

		if list and #list > 0 then
			local posterList = {}

			for i, posterCfg in ipairs(list) do
				table.insert(posterList, posterCfg.posterId)
			end

			local posterCfg = PetskinController.instance:getPosterCfg(skinId)

			if posterCfg then
				UIStateManager.instance:push(ViewName.PetskinposterView, posterCfg.posterId, posterList, skinId)
			elseif #posterList > 0 then
				UIStateManager.instance:push(ViewName.PetskinposterView, posterList[1], posterList, skinId)
			end
		end
	end
end

function PetskinView:_updateGoldBar()
	local list = {
		{
			showAdd = true,
			id = GameEnum.GoldType.Coin
		},
		{
			showAdd = true,
			id = GameEnum.GoldType.Diamond
		},
		{
			id = "8:17",
			showAdd = false
		}
	}

	MainUIController.instance:showGlodBar(self.goldBarCon, self._viewPresentor, list)
end

function PetskinView:_onClickSwitch(isLeft)
	if isLeft then
		if not (self._curIndex - 1) then
			local newIdx = self._curIndex + 1

			newIdx = 1 + (newIdx - 1) % #self._curViewDatas

			self:centerOnIndex(newIdx, true, isLeft)
		end
	end
end

function PetskinView:_updateState()
	self._showLihui = self._isLihui and self._hasLihui

	goutil.setActive(self._switchOn, self._isLihui)
	goutil.setActive(self._switchOff, not self._isLihui)
	goutil.setActive(self.btninfor.gameObject, self._showLihui)

	if self._curPetPhotoShow then
		self._curPetPhotoShow:switchState(self._showLihui)
	end

	self._btnsSingleLine:Layout()
end

function PetskinView:_updateSelectCell(idx, cell)
	local petPhotoShow = PetPhotoShow.Get(cell.gameObject)

	self._curPetPhotoShow = petPhotoShow

	self._curPetPhotoShow:setCallBackOnEffLoadedAfter(GameUtil.handler(self._onReloadSpineInterfaceCompOfSkeletonAnimation, self))
	self._curPetPhotoShow:setCallBackOnEffUnloadBefore(GameUtil.handler(self._onUnReloadSpineInterfaceCompOfSkeletonAnimation, self))

	self._petPhotoShows[cell.gameObject] = petPhotoShow

	local data = self._curViewDatas[idx]

	self._curIndex = idx
	self.currCfg = data

	local list = PetSkinConfig.instance:getPosterList(data.skinId)

	GameUtil.SetActive(self.btnPoster, list ~= nil and #list > 0)
	goutil.setActive(self._btnLeft.gameObject, #self._curViewDatas > 1)
	goutil.setActive(self._btnRight.gameObject, #self._curViewDatas > 1)

	local cfg = CharacterConfig.instance:getModelCo(checknumber(data.skinId))

	self._hasLihui = cfg ~= nil and not string.nilorempty(cfg.bustName)
	self._showLihui = self._isLihui and self._hasLihui

	goutil.setActive(self._btnSwitch.gameObject, self._hasLihui)
	goutil.setActive(self.btninfor.gameObject, self._showLihui)
	petPhotoShow:showPetEffect(data.skinId, self._showLihui)
	GameUtil.setLocalPos(self._dragContent, -200, 0, 0)

	local cfg = PetSkinConfig.instance:getPetSkinCfg(data.skinId)

	if cfg and not Special_Map[checknumber(data.skinId)] and (cfg.quality == 8 or cfg.quality == 10) then
		GameUtil.setLocalPos(self._dragContent, 0, 0, 0)
	end

	PetCvController.instance:turnOffCurCv()

	if self.page.targetIdx ~= idx then
		self.page:moveToIdx(idx, true, false)
	end

	self:updateBtnStatus()
end

function PetskinView:updateBtnStatus()
	local skinId = self.currCfg.skinId

	if PetSkinConfig.instance:isExistSkinGroup(self.currCfg.skinId) then
		local oriCfg = PetSkinConfig.instance:getMainSkinGroupCfgBySkinId(self.currCfg.skinId)

		skinId = oriCfg.skinId
	end

	local skinMo = PetskinModel.instance:getSkinMoById(skinId)
	local vipPrivilege = VipModel.instance:getPetSkinRenanePrivilege()

	if vipPrivilege then
		::label_25_0::

		local var_25_0 = self.currCfg.canSetOtherName

		if self.currCfg.canSetOtherName and skinMo then
			::label_25_1::

			local canRename = skinMo:isForeverSkin()
			local shenhuaSkin = {}

			for i, v in ipairs(self._curViewDatas) do
				if v.quality >= 10 then
					table.insert(shenhuaSkin, v)
				end
			end

			local canSetEnter = #shenhuaSkin > 0

			GameUtil.SetActive(self.btnWear, false)
			GameUtil.SetActive(self.btnBuy, false)
			GameUtil.SetActive(self.btnSkin, false)
			GameUtil.SetActive(self.tagWear, false)
			GameUtil.SetActive(self.tagBuy, false)
			GameUtil.SetActive(self._btnRename.gameObject, canRename)
			GameUtil.SetActive(self.btnEnter, canSetEnter)

			self.txtTime.text = ""
			self.txtDesc.text = ""

			local curArr = GameUtil.propToList({
				self.currCfg.propertyApp
			})

			GameUtil.SetActive(self.txtNoAttr, false)

			local desc = PetskinController.instance:getConditionDesc(self.currCfg)

			self.txLock.text = langPara("解锁条件:%s", desc)
			self.txtDesc.text = self.currCfg.desc

			self:stopTimer()
			GameUtil.SetActive(self.passive, not string.nilorempty(self.currCfg.buffDes))

			self.txtPassiveDesc.text = self.currCfg.buffDes

			local skinStatus = PetskinController.instance:checkHasSkinStatus(self.currCfg)

			if self.currCfg.presentType == "original" and self.petMo and self.petMo:isBorrowPet() then
				skinStatus = PetskinController.SKIN_STATUS_ORIGINAL
			end

			if self.viewStatus == PetskinView.TYPE_PET_MO then
				if skinStatus == PetskinController.SKIN_STATUS_HAD or skinStatus == PetskinController.SKIN_STATUS_ORIGINAL then
					if checknumber(self.petMo.curFaceId) == checknumber(self.currCfg.skinId) then
						GameUtil.SetActive(self.tagWear, true)
					else
						GameUtil.SetActive(self.btnWear, true)
					end
				elseif skinStatus == PetskinController.SKIN_STATUS_NOT then
					-- block empty
				else
					if skinStatus == PetskinController.SKIN_STATUS_OUTDATE then
						-- block empty
					elseif checknumber(self.petMo.curFaceId) == checknumber(self.currCfg.skinId) then
						GameUtil.SetActive(self.tagWear, true)
					else
						GameUtil.SetActive(self.btnWear, true)
					end

					self:updateLimitTime(skinStatus)
				end

				self:checkCanBuy(skinStatus)
				PetskinController.instance:deleteSkinRedPoint(self.currCfg.skinId)
			else
				self:updateLimitTime(skinStatus)
			end

			self._btnsSingleLine:Layout()
		end
	end
end

function PetskinView:onTimer()
	local time = checknumber(self.limitTime)
	local now = ServerTime.now()
	local limit = math.max(0, time - now)

	self.txtTime.text = langPara("剩余体验时间:<color=#00ff00>%s</color>", GameUtil.FormatTimeSymbol(limit, true))

	if limit <= 0 then
		self:stopTimer()
	end
end

function PetskinView:checkCanBuy(skinStatus)
	print(">>>>>>>>>>>>>>>>>>>  PetskinView:checkCanBuy(skinStatus)", skinStatus)
	GameUtil.SetActive(self.btnSkin, false)
	GameUtil.SetActive(self.btnBuy, false)
	GameUtil.SetActive(self.tagBuy, false)

	if skinStatus == PetskinController.SKIN_STATUS_HAD then
		local skinId = self.currCfg.skinId

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_PETSKIN_TRY_PRE .. skinId, false)
	elseif skinStatus == PetskinController.SKIN_STATUS_ORIGINAL then
		local skinId = self.currCfg.skinId

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_PETSKIN_TRY_PRE .. skinId, false)
	elseif skinStatus == PetskinController.SKIN_STATUS_NOT then
		self.txtBuy.text = lang("获取来源")

		GameUtil.SetActive(self.btnBuy, true)
		self:updateTrySkin()
	else
		self:updateTrySkin()
	end
end

function PetskinView:updateTrySkin()
	local skinId = self.currCfg.skinId
	local hasCfg = self:getFirstSkinCfg(skinId) ~= nil

	GameUtil.SetActive(self.btnSkin, hasCfg)
end

function PetskinView:getFirstSkinCfg(skinId)
	local cfg = PetSkinConfig.instance:getTryItemCfg(skinId)

	if cfg then
		local items = cfg.items
		local list = string.split(items, "#")

		for i, v in ipairs(list) do
			if MaterialMgr.getMatCount(v) > 0 then
				RedPointController.instance:setRedPointInfo(RedPointModel.ID_PETSKIN_TRY_PRE .. skinId, true)

				return v
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PETSKIN_TRY_PRE .. skinId, false)

	return nil
end

function PetskinView:updateLimitTime(time)
	self.txtTime.text = ""

	if self.currCfg and time > 0 then
		self:startTimer(time)
	end
end

function PetskinView:_onClickCell()
	if self.currCfg then
		local skinId = self.currCfg.skinId
		local pos = self._bubble.transform.position

		PetCvController.instance:playPetCv(skinId, nil, true, pos)

		if self._curPetPhotoShow then
			self._curPetPhotoShow:playShowAnim()
		end
	end
end

function PetskinView:centerOnIndex(idx, isSpring, isLeft)
	idx = checknumber(idx)

	if self._curViewDatas and idx >= 1 and idx <= #self._curViewDatas then
		self._rawImgDrag:setMaxNum(#self._curViewDatas)
		self._rawImgDrag:centerOnIndex(idx, isSpring, isLeft)
	else
		print("invalid idx = " .. tostring(idx))
	end
end

function PetskinView:clearSkinCell(cell)
	local icon = goutil.findChild(cell, "mask/skin")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(cell)

	local red_point = goutil.findChild(cell, "red_point")

	RedPointController.instance:unregRedPoint(red_point)
end

function PetskinView:updateSkinCell(page, cell, data, idx, isEnd)
	local icon = goutil.findChild(cell, "mask/skin")
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtState = goutil.findChildTextComponent(cell, "txtState")
	local top = goutil.findChild(cell, "top")
	local red_point = goutil.findChild(cell, "red_point")
	local quality = goutil.findChild(cell, "quality")
	local imgSex = goutil.findChild(cell, "imgSex")

	GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickSkinCell, self, idx, data.skinId))
	GameUtil.SetActive(quality, false)
	GameUtil.SetActive(imgSex, false)

	local skinId = data.skinId

	RedPointController.instance:regRedPoint(red_point, RedPointModel.ID_PETSKIN_PRE .. skinId, RedPointModel.ID_PETSKIN_TRY_PRE .. skinId)

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if modelCo == nil then
		printError(">>>>>>> 模型配置表没配, 检查他的 skinGroup 值 : " .. skinId)
	end

	uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	txtName.text = skinId
	txtState.text = lang("未拥有")

	local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if cfg then
		txtName.text = cfg.skinName

		local status = PetskinController.instance:checkHasSkinStatus(cfg)

		if status == PetskinController.SKIN_STATUS_HAD or status > 0 then
			txtState.text = lang("已拥有")
		elseif status == PetskinController.SKIN_STATUS_ORIGINAL then
			txtState.text = lang("原始皮肤")
		end

		if cfg.quality > 0 then
			GameUtil.SetActive(quality, true)
			GameUtil.setUIImageSpriteIdx(quality, cfg.quality)
		end

		if checknumber(cfg.isChangeSex) == 1 then
			GameUtil.SetActive(imgSex, true)
			GameUtil.SetActive(quality, false)
		end

		local oriSkinId = 0

		if PetSkinConfig.instance:isExistSkinGroup(cfg.skinId) then
			local oriCfg = PetSkinConfig.instance:getMainSkinGroupCfgBySkinId(cfg.skinId)

			oriSkinId = oriCfg.skinId
		else
			oriSkinId = cfg.skinId
		end

		local skinMo = PetskinModel.instance:getSkinMoById(oriSkinId)

		if skinMo and not string.nilorempty(skinMo:getOtherName()) then
			txtName.text = skinMo:getOtherName()
		end
	end

	if isEnd then
		GameUtil.SetActive(imgSelect, page.targetIdx == idx)
		GameUtil.SetActive(top, page.targetIdx ~= idx)
	else
		GameUtil.SetActive(imgSelect, false)
		GameUtil.SetActive(top, true)
	end
end

function PetskinView:onClickSkinCell(idx, skinId)
	if self.page.targetIdx ~= idx then
		self._needCenterOnIndexOnEnd = true

		self.page:moveToIdx(idx)

		self._storyId = PetSkinConfig.instance:getStoryId(skinId)

		local hasGainPrize = StoryPrizeModel.instance:storyHasGainPrize(self._storyId)

		GameUtil.SetActive(self._btnStory, self._storyId > 0)
		GameUtil.SetActive(self._imgRedPointStory, not hasGainPrize)
	end
end

function PetskinView:selectSkinEnd(page)
	if self._needCenterOnIndexOnEnd then
		self._needCenterOnIndexOnEnd = false

		self:centerOnIndex(page.targetIdx)
	end
end

function PetskinView:_updatePropCell(view, cell, data)
	local attrIconSpt = goutil.findChildComponent(cell, "attrIcon", "UIImageSpriteChange")
	local qhNameTxt = goutil.findChildTextComponent(cell, "attrName")
	local qhNowCountTxt = goutil.findChildTextComponent(cell, "txtNum")
	local name = data.name
	local value = data.value
	local idx = table.indexof(GameEnum.AttrTypeName, name)

	attrIconSpt:SetState(idx - 1)

	qhNameTxt.text = name
	qhNowCountTxt.text = GameUtil.getValueOrPercent(value)
end

function PetskinView:onWearClick()
	if self.petMo then
		local skinId = self.currCfg.skinId

		PetskinController.instance:sendWearSkin(self.petMo.petId, skinId)
	end
end

function PetskinView:onBuyClick()
	local skinId = self.currCfg.skinId

	MaterialMgr.openGetSource(MatType.PET_SKIN, skinId)
end

function PetskinView:onClickSkin()
	local content = lang("目前背包内有该皮肤的体验卡，可以马上进行试用，或者去背包使用。")

	TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
		local skinId = self.currCfg.skinId
		local item = self:getFirstSkinCfg(skinId)

		if item then
			local type, id = MaterialMgr.getMatParams(item)
			local mo = MaterialMgr.getModel(type, id)

			ItemBagController.instance:openUsePanel(mo)
		end
	end, function()
		FuncOpenController.instance:openFunc(7)
	end, lang("进行试用"), lang("前往背包"))
end

function PetskinView:_onClickbtnRename()
	local v = FriendConfig.instance:getCommonValue("NO_RENAME_PERIOD")
	local times = string.split(v, "#")

	if #times == 2 and GameUtil.checkIsInTimePeriod(times[1], times[2]) then
		FloatWordMgr.instance:show("改名功能正在进行技术维护，具体开放时间请留意公告！")

		return
	end

	if self.currCfg then
		local skinId = self.currCfg.skinId

		if PetSkinConfig.instance:isExistSkinGroup(self.currCfg.skinId) then
			local oriCfg = PetSkinConfig.instance:getMainSkinGroupCfgBySkinId(self.currCfg.skinId)

			skinId = oriCfg.skinId
		end

		UIStateManager.instance:push(ViewName.PetskinrenameView, skinId)
	end
end

function PetskinView:_onSetPetSkinOtherNameRes()
	self.page:reloadData(self._curViewDatas, self._curIndex)
end

function PetskinView:_filterSkinNotOpen(skinList)
	local result = {}

	for i, v in ipairs(skinList) do
		if v.isHide <= 0 and not PetskinController.instance:isClientNotShowIfNotForever(v.skinId) then
			if string.nilorempty(v.showTime) then
				table.insert(result, v)
			else
				local time = GameUtil.string2time(v.showTime)

				if time <= ServerTime.now() then
					table.insert(result, v)
				end
			end
		end
	end

	return result
end

function PetskinView:_resetNode()
	self:_stopTween()
	self:_startTween(0)
	goutil.setActive(self._bg2Go, true)
end

function PetskinView:_stopTween()
	self._lefttween:Stop()
	self._righttween:Stop()
	self._downtween:Stop()
end

function PetskinView:_setCacheV3(x, y)
	self._cacheV3.x = x
	self._cacheV3.y = y
end

function PetskinView:_startTween(time)
	time = time or 0.3

	local positions = {
		{
			tween = self._lefttween,
			start = {
				640,
				0
			},
			end_ = {
				0,
				0
			}
		},
		{
			tween = self._righttween,
			start = {
				-660,
				-51
			},
			end_ = {
				0,
				-51
			}
		},
		{
			tween = self._downtween,
			start = {
				-199.8,
				120
			},
			end_ = {
				-199.8,
				-80
			}
		}
	}

	for _, pos in ipairs(positions) do
		self:_easySetTween(pos.tween, pos.start, pos.end_)

		pos.tween.time = time

		pos.tween:Begin()
	end
end

function PetskinView:_easySetTween(tweenComp, posStartList, posEndList)
	if self._isFold then
		self:_setCacheV3(posStartList[1], posStartList[2])

		tweenComp.from = self._cacheV3

		self:_setCacheV3(posEndList[1], posEndList[2])

		tweenComp.to = self._cacheV3
	else
		self:_setCacheV3(posEndList[1], posEndList[2])

		tweenComp.from = self._cacheV3

		self:_setCacheV3(posStartList[1], posStartList[2])

		tweenComp.to = self._cacheV3
	end
end

function PetskinView:_notify_SpineInterfaceBagExtension(eventParams)
	if self._spineInterfaceComp then
		self._extendViewPresentor = self._spineInterfaceComp:openExtension(self._extendView, self._viewPresentor, eventParams)
	end
end

function PetskinView:_closeSpineInterfaceExtension()
	if self._extendViewPresentor then
		ViewMgr.instance:close(self._extendViewPresentor.viewName)

		self._extendViewPresentor = nil
	end
end

function PetskinView:_onReloadSpineInterfaceCompOfSkeletonAnimation(photoShow)
	local skinId

	self._spineInterfaceComp, skinId = SpineInterfaceComp.reloadPhotoShow(self._spineInterfaceComp, self._spineInterface, photoShow, true)

	GameUtil.SetActive(self._spineInterface, self:_isInteractable(skinId))
end

function PetskinView:_onUnReloadSpineInterfaceCompOfSkeletonAnimation()
	self:_closeSpineInterfaceExtension()

	if self._spineInterfaceComp then
		self._spineInterfaceComp:unload()
	end
end

function PetskinView:_isSpineInterfaceCompLoaded()
	return self._spineInterfaceComp and self._spineInterfaceComp:isLoaded() or false
end

function PetskinView:_isInteractable(skinId)
	return PetSkinConfig.instance:isSkinInteractable(skinId) and self:_isSpineInterfaceCompLoaded()
end

function PetskinView:onClickSkinEnterEffect()
	local list = {}

	for i, v in ipairs(self._curViewDatas) do
		if v.quality >= 10 then
			table.insert(list, v)
		end
	end

	UIStateManager.instance:push(ViewName.PetSkinEnterEffectSetView, list)
end

function PetskinView:onClickBtnStory()
	local hasGetedTotalInfo = StoryPrizeController.instance:hasGetedTotalInfo()

	if not hasGetedTotalInfo then
		FloatWordMgr.instance:show("数据同步中，请稍后再观看剧情")

		return
	end

	local storyPrizeCfg = StoryPrizeConfig.instance:getStoryPrizeCfg(self._storyId)
	local hasGainPrize = StoryPrizeModel.instance:storyHasGainPrize(self._storyId)

	if storyPrizeCfg and not hasGainPrize then
		StoryPrizeController.instance:sendPM_StoryPrizeGainPrizeReq(self._storyId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PushStory, self._storyId, StoryModel.StoryType.SCCopy)
end

function PetskinView:_onStoryTotalInfoRes()
	local hasGainPrize = StoryPrizeModel.instance:storyHasGainPrize(self._storyId)

	GameUtil.SetActive(self._imgRedPointStory, not hasGainPrize)
end

function PetskinView:_onStoryPrizeGainPrizeRes()
	local hasGainPrize = StoryPrizeModel.instance:storyHasGainPrize(self._storyId)

	GameUtil.SetActive(self._imgRedPointStory, not hasGainPrize)
end

function PetskinView:_onEndStory()
	local storyPrizeCfg = StoryPrizeConfig.instance:getStoryPrizeCfg(self._storyId)
	local hasGainPrize = StoryPrizeModel.instance:storyHasGainPrize(self._storyId)

	if storyPrizeCfg and not hasGainPrize then
		local prize = storyPrizeCfg.prize
		local list = {}
		local matType, matId, matNum = MaterialMgr.getMatParams(prize)
		local mo = MaterialModel.instance:createMo(matType, matId, matNum)

		table.insert(list, mo)

		local obj = {}

		obj.items = list
		obj.ci = 0

		MaterialController.instance:addInList(MaterialController.TYPE_ITEMSET, obj)
		MaterialController.instance:checkAndOpenDisplay()
		StoryPrizeModel.instance:setStoryHasGainPrize(self._storyId, true)
	end

	GameUtil.SetActive(self._imgRedPointStory, not hasGainPrize)
end

return PetskinView
