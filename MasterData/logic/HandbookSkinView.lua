-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/HandbookSkinView.lua

module("logic.extensions.handbook.view.HandbookSkinView", package.seeall)

local HandbookSkinView = class("HandbookSkinView", ViewComponent)
local UserLocalDataKey = "HandbookSkinView_"

function HandbookSkinView:ctor()
	HandbookSkinView.super.ctor(self)
end

function HandbookSkinView:buildUI()
	HandbookSkinView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnLeft = self:getBtn("btn_left")
	self._btnRight = self:getBtn("btn_right")
	self._imgJob = goutil.findChildComponent(self.mainGO, "job/icon", "UIImageSpriteChange")
	self._imgJob1 = goutil.findChildComponent(self.mainGO, "job1/icon", "UIImageSpriteChange")
	self._imgAttr = goutil.findChildComponent(self.mainGO, "attr/icon", "UIImageSpriteChange")
	self._Job = goutil.findChild(self.mainGO, "job")
	self._Job1 = goutil.findChild(self.mainGO, "job1")
	self._Attr = goutil.findChild(self.mainGO, "attr")
	self._btnToget = self:getBtn("btnToget")
	self._goToget = self:getGo("btnToget")
	self._btnShare = self:getBtn("btnShare")
	self._btnVideo = self:getBtn("btnVideo")
	self._btnZoom = self:getBtn("btnZoom")
	self._btnDrawing = self:getBtn("btnDrawing")
	self.commentBtn = self:getBtn("commentBtn")
	self._switchOn = goutil.findChild(self._btnDrawing.gameObject, "on")
	self._switchOff = goutil.findChild(self._btnDrawing.gameObject, "off")
	self.txt_name = goutil.findChildTextComponent(self.mainGO, "txt_name")
	self._skinName = goutil.findChildTextComponent(self.mainGO, "txt_skinName")
	self._rarePoint = self:getGo("imgRare")
	self._imgSex = goutil.findChildComponent(self.mainGO, "imgSex", "UIImageSpriteChange")
	self.txt_power = goutil.findChildTextComponent(self.mainGO, "power/txt_power")
	self._bubble = self:getGo("mask/role/bubble")
	self.txtEvname = goutil.findChildTextComponent(self.mainGO, "cv/txtEvname")
	self._btnVoice = self:getBtn("btnVoice")
	self._gocvName = goutil.findChild(self.mainGO, "cv")
	self._goVoice = goutil.findChild(self.mainGO, "btnVoice")
	self._Container = self:getGo("container")
	self._customInput = UICustomInput.Get(self._Container)
	self._ContainerPetTip = self:getGo("container_PetTip")

	local dragContent = self:getGo("mask/role/dragContent")
	local rawImg = goutil.findChild(dragContent, "role_image_1")

	self._rawImgDrag = RawImageDrag.New(dragContent, rawImg)

	self._rawImgDrag:setUpdateCallback(self._updateCell, self)
	self._rawImgDrag:setClickCallback(self._onClickCell, self)

	self._btnActive = self:getBtn("btnActive")
	self._txtActive = self:getTxt("btnActive/text")
	self._redActive = self:getGo("btnActive/red")
	self._effectList = {}
	self._btnSkinPet = self:getBtn("btnSkinPet")
	self._spineInterface = goutil.findChild(self.mainGO, "mask/spineInterface")
end

function HandbookSkinView:unbindEvents()
	HandbookSkinView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnToget:RemoveClickListener()
	self._btnShare:RemoveClickListener()
	self._btnVideo:RemoveClickListener()
	self._btnZoom:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnDrawing:RemoveClickListener()
	self.commentBtn:RemoveClickListener()
	self._btnVoice:RemoveClickListener()
	self._customInput:RemoveListener()
	self._btnActive:RemoveClickListener()
	self._btnSkinPet:RemoveClickListener()
end

function HandbookSkinView:bindEvents()
	HandbookSkinView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnToget:AddClickListener(self._onClickToGet, self)
	self._btnShare:AddClickListener(function()
		ShareController.instance:share(1, {
			self._btnShare.gameObject
		}, nil, 200290)
	end)
	self._btnVideo:AddClickListener(self._onClickVideo, self)
	self._btnZoom:AddClickListener(self._onClickZoom, self)
	self._btnLeft:AddClickListener(function()
		self:_onClickSwitchPet(true)
	end, self)
	self._btnRight:AddClickListener(function()
		self:_onClickSwitchPet(false)
	end, self)
	self._btnDrawing:AddClickListener(self._onClickSwitchDrawing, self)
	self.commentBtn:AddClickListener(function()
		UIStateManager.instance:open(ViewName.PetComment, self.raceId)
	end, self)
	self._btnVoice:AddClickListener(self._onClickVoice, self)
	self._customInput:AddListener(self._onCloseCVviewCallback, self)
	self._btnActive:AddClickListener(self._activeBtnOnClick, self)
	self._btnSkinPet:AddClickListener(self._onClickAssociateSkinPet, self)
end

function HandbookSkinView:onEnter()
	HandbookSkinView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._skinId = checknumber(params[1])
	self._allList = params[2] or {}

	self._rawImgDrag:setDragEnabled(#self._allList > 0)

	self._showPetTip = GameUtil.getUserData(UserLocalDataKey .. "showPetTip")
	self._curIndex = 1

	for i, v in ipairs(self._allList) do
		if self._skinId == v.skinId then
			self.raceId = v.raceId
			self._curIndex = i

			break
		end
	end

	self._petPhotoShows = {}
	self.petCvViewOnShow = false
	self._isLihui = true

	local prize = ShareController.instance.activeByTimes(1, goutil.findChild(self._btnShare.gameObject, "bubble"))

	MaterialMgr.setCellByCfg(prize, goutil.findChild(self._btnShare.gameObject, "bubble/reward"))
	GlobalDispatcher:addListener(GlobalNotify.HandBookAttributeChange, self._showEffect, self)
	GlobalDispatcher:addListener(GlobalNotify.HandBookSkinInfo, self._refreshActiveBtn, self)
	self.addGEvent(self, PetbookController.NotifyName_HandBookPlayPetAnim, self._playPetAnim, self)
	self:centerOnIndex(self._curIndex, false)

	self._needGc = false

	settimer(10, self._onGcTime, self)

	if self._showPetTip then
		self:_showAssociateSkinPetTip()
	end
end

function HandbookSkinView:onEnterFinished()
	HandbookSkinView.super.onEnterFinished(self)
end

function HandbookSkinView:onExit()
	HandbookSkinView.super.onExit(self)
	self:_stopEffect()
	PetCvController.instance:turnOffCurCv(false)
	MaterialMgr.resetAll(self._rarePoint)
	self:_onUnReloadSpineInterfaceCompOfSkeletonAnimation()

	for _, v in pairs(self._petPhotoShows) do
		v:destroy()
	end

	self._petPhotoShows = nil
	self._curPetPhotoShow = nil

	GlobalDispatcher:removeListener(GlobalNotify.HandBookAttributeChange, self._showEffect, self)
	GlobalDispatcher:removeListener(GlobalNotify.HandBookSkinInfo, self._refreshActiveBtn, self)
	MaterialMgr.resetAll(goutil.findChild(self._btnShare.gameObject, "bubble/reward"))
	removetimer(self._onGcTime, self)
	self:showTabAt(self._ContainerPetTip)
	GameUtil.saveUserData(UserLocalDataKey .. "showPetTip", self._showPetTip)
	self:_onGcTime()
end

function HandbookSkinView:_onGcTime()
	if self._needGc then
		self._needGc = false

		ResGcMgr.instance:gc()
	end
end

function HandbookSkinView:onExitFinished()
	HandbookSkinView.super.onExitFinished(self)
end

function HandbookSkinView:_onClickClose()
	self:close()
end

function HandbookSkinView:_refresh()
	self._curIndex = self._curIndex or 1

	local obj = {}

	obj = #self._allList > 0 and self._allList[self._curIndex] or MaterialMgr.getMatCfg(MatType.PET_SKIN, self._skinId)
	self.raceId = obj.raceId
	self._skinId = obj.skinId

	local cfg = HandbookConfig.instance:getPetDetailsCfgById(self.raceId)

	goutil.setActive(self._switchOn, self._isLihui)
	goutil.setActive(self._switchOff, not self._isLihui)
	GameUtil.SetActive(self._btnDrawing, CharacterConfig.instance:CheckHasTowAsset(self.raceId))
	goutil.setActive(self._btnSkinPet.gameObject, true)

	cfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)

	if cfg then
		self:refreshJob(cfg)

		self.txt_name.text = cfg.name
		self._skinName.text = cfg.skinName

		self._imgSex:SetState(cfg.genderId - 1)

		local petCo = CharacterConfig.instance:getPetCo(self.raceId)
		local rare = GameEnum.PetRare.N

		rare = CharacterConfig.instance:getRareByAwakenLv(petCo.initAwakenLv, self.raceId)

		local proxy = MaterialMgr.setCell(MatType.PetSkin_Rare, self._skinId, self._rarePoint)
	end

	local maxMo = FightingPowerFormula.instance:getRealMaxFightingPowerPetMo(self.raceId)
	local cvName = PetSkinConfig.instance:getSkinCvName(self._skinId)
	local cvIsExist = not string.nilorempty(cvName)

	if cvIsExist then
		self.txtEvname.text = "CV." .. cvName

		goutil.setActive(self._gocvName, true)
		goutil.setActive(self._goVoice, true)
	else
		goutil.setActive(self._gocvName, false)
		goutil.setActive(self._goVoice, false)
	end

	local unproved = HandbookConfig.instance:getPetDetailsCfgById(self.raceId).unproved == 1

	goutil.setActive(self._goToget, not unproved)
	self:_updateSwitchBtnStatus()
	self:_refreshActiveBtn()
	self:_refreshTabView()
end

function HandbookSkinView:refreshJob(cfg)
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(cfg.raceId)

	self._imgJob:SetState(firstJobIdx - 1)

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(cfg.raceId)

	race = math.fmod(race, 10)

	local targetValue = race - 1

	self._imgAttr:SetState(targetValue)
	GameUtil.asBtn(self._Attr):RemoveClickListener()
	GameUtil.asBtn(self._Attr):AddClickListener(function()
		CommonTipsMgr.instance:openMaterialTips(self._Attr, MatType.Race, race)
	end)
	GameUtil.asBtn(self._Job):RemoveClickListener()
	GameUtil.asBtn(self._Job):AddClickListener(function()
		local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(cfg.raceId)

		CommonTipsMgr.instance:openMaterialTips(self._Job, MatType.Job, firstJobIdx)
	end)
	goutil.setActive(self._imgJob1.transform.parent.gameObject, false)
	goutil.setActive(self._imgJob.transform.parent.gameObject, true)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(cfg.raceId)

	if secondJobIdx > 20 then
		goutil.setActive(self._imgJob1.transform.parent.gameObject, true)
		self._imgJob1:SetState(secondJobIdx - 1 - 20)
		GameUtil.asBtn(self._Job1):RemoveClickListener()
		GameUtil.asBtn(self._Job1):AddClickListener(function()
			CommonTipsMgr.instance:openMaterialTips(self._Job1, MatType.Job, secondJobIdx)
		end)
	end

	local isSkinGroup = cfg.skinGroup > 0

	goutil.setActive(self._Job, not isSkinGroup)
	goutil.setActive(self._Job1, secondJobIdx > 20 and not isSkinGroup)
end

function HandbookSkinView:centerOnIndex(idx, isSpring, isLeft)
	idx = checknumber(idx)

	local len = #self._allList

	if idx >= 1 and idx <= len then
		self._rawImgDrag:setMaxNum(len)
		self._rawImgDrag:centerOnIndex(idx, isSpring, isLeft)
	end

	self:_refresh()
end

function HandbookSkinView:_updateCell(idx, cell)
	if idx ~= self._curIndex then
		self._curIndex = idx

		self:_refresh()
		PetCvController.instance:turnOffCurCv()
	end

	local obj = {}

	obj = #self._allList > 0 and self._allList[self._curIndex] or MaterialMgr.getMatCfg(MatType.PET_SKIN, self._skinId)
	self.raceId = obj.raceId
	self._skinId = obj.skinId

	if not self._petPhotoShows[cell.gameObject] then
		local petPhotoShow = PetPhotoShow.Get(cell.gameObject)

		self._petPhotoShows[cell.gameObject] = self._petPhotoShows[cell.gameObject]

		self._petPhotoShows[cell.gameObject]:setCallBackOnEffLoadedAfter(GameUtil.handler(self._onReloadSpineInterfaceCompOfSkeletonAnimation, self))
		self._petPhotoShows[cell.gameObject]:setCallBackOnEffUnloadBefore(GameUtil.handler(self._onUnReloadSpineInterfaceCompOfSkeletonAnimation, self))
		PetbookModel.instance:setSelectedPet(self._skinId)

		local params = self:getOpenParam()

		if params then
			params[1] = self._skinId

			UIStateManager.instance:updateParms(self._viewPresentor.viewName, params)
		end

		self._petPhotoShows[cell.gameObject]:showPetEffect(self._skinId, self._isLihui, 4, "handbook")

		self._needGc = true
		self._curPetPhotoShow = self._petPhotoShows[cell.gameObject]
	end
end

function HandbookSkinView:_onClickCell()
	self:_playPetAnim()
end

function HandbookSkinView:_playPetAnim()
	if self._skinId > 0 then
		PetCvController.instance:playPetCv(self._skinId, nil, true, self._bubble.transform.position)
	end

	if self._curPetPhotoShow then
		self._curPetPhotoShow:playShowAnim()
	end
end

function HandbookSkinView:_onClickSwitchPet(isLeft)
	if self._isTweening then
		return
	end

	if isLeft then
		if not (self._curIndex - 1) then
			local temp = self._curIndex + 1
			local len = #self._allList

			if temp < 1 or len < temp then
				return
			end

			local obj = {}

			obj = #self._allList > 0 and self._allList[self._curIndex] or MaterialMgr.getMatCfg(MatType.PET_SKIN, self._skinId)
			self.raceId = obj.raceId
			self._skinId = obj.skinId

			self:centerOnIndex(temp, true, isLeft)

			if self._showPetTip then
				self:_showAssociateSkinPetTip()
			end
		end
	end
end

function HandbookSkinView:_updateSwitchBtnStatus()
	local len = #self._allList

	goutil.setActive(self._btnLeft.gameObject, len > 0 and self._curIndex > 1)
	goutil.setActive(self._btnRight.gameObject, len > 0 and len > self._curIndex)
end

function HandbookSkinView:_onClickToGet()
	MaterialMgr.openGetSource(MatType.PET_SKIN, self._skinId)
end

function HandbookSkinView:_onClickVideo()
	PetbookController.instance:previewBattle(self.raceId, self._skinId)
end

function HandbookSkinView:_onClickZoom()
	UIStateManager.instance:push(ViewName.PetDrawing, self._skinId)
end

function HandbookSkinView:_onClickSwitchDrawing()
	self._isLihui = not self._isLihui

	self:centerOnIndex(self._curIndex, false)
end

function HandbookSkinView:_onClickVoice()
	self.petCvViewOnShow = true

	self:_refresh()
end

function HandbookSkinView:_onCloseCVviewCallback(hover)
	if not hover and self.petCvViewOnShow then
		self.petCvViewOnShow = false

		AudioVoicePlayer.instance:playVoiceByEvt(nil)
		self:_refresh()
	end
end

function HandbookSkinView:_showEffect(raceId)
	self:_stopEffect()

	local petCo = CharacterConfig.instance:getPetCo(raceId)
	local manualBenefitId = petCo.manualBenefitId
	local cfg = HandbookConfig.instance:getBenefitCfg(manualBenefitId, 0)
	local needToUpgradeParam = {
		cfg.formulaPropertyType
	}

	for k, v in pairs(needToUpgradeParam) do
		local index = HandbookModel.ATTTYPE_MAP[v]

		if checknumber(index) > 0 then
			local effPath = INDEX_TO_PATH[index]

			self._effectList[index] = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, false, nil, nil, function(finishHandlerTarget, eff)
				Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
			end)

			self._effectList[index]:setParent(self._goEffectList[index].transform)
			self._effectList[index]:setScale(1)

			self._effectList[index].hideEffWhileNotOnTop = true
		end
	end
end

function HandbookSkinView:_stopEffect()
	for i = 1, 4 do
		if self._effectList[i] then
			UIEffectManager.instance:stopEffect(self._effectList[i])
		end
	end
end

function HandbookSkinView:_refreshActiveBtn()
	local isActive, isGray = PetbookModel.instance:skinIsActiveAndState(self._skinId)

	if isActive then
		GameUtil.SetGray(self._btnActive, not isGray)
		goutil.setActive(self._redActive, isGray)
	end

	goutil.setActive(self._btnActive.gameObject, isActive)
end

function HandbookSkinView:_activeBtnOnClick()
	local isActive, isGray = PetbookModel.instance:skinIsActiveAndState(self._skinId)

	if isGray then
		PetManualAgent.instance:sendPetSkinActivateReq(self._skinId)
	else
		FloatWordMgr.instance:show("暂未获得该皮肤")
	end
end

function HandbookSkinView:_refreshTabView()
	if self.petCvViewOnShow then
		self:showTabAt(self._Container, ViewName.PetcvView)
	else
		self:showTabAt(self._Container, name)
	end
end

function HandbookSkinView:_onClickAssociateSkinPet()
	self._showPetTip = not self._showPetTip

	if self._showPetTip then
		self:_showAssociateSkinPetTip()
	else
		self:showTabAt(self._ContainerPetTip)
	end

	GameUtil.saveUserData(UserLocalDataKey .. "showPetTip", self._showPetTip)
end

function HandbookSkinView:_showAssociateSkinPetTip()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)

	if cfg then
		local cfgPetSkinList = PetSkinConfig.instance:getPetSkinListBySkinGroup(cfg.skinGroup)

		if TableUtil.isTableEmpty(cfgPetSkinList) then
			table.insert(cfgPetSkinList, cfg)
		end

		local pos = self._btnSkinPet.transform.position
		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)

		self:showTabAt(self._ContainerPetTip, ViewName.AssociatePetTipView, cfgPetSkinList, pos, {
			50,
			300
		})
	end
end

function HandbookSkinView:_onReloadSpineInterfaceCompOfSkeletonAnimation(photoShow)
	self._spineInterfaceComp = SpineInterfaceComp.reloadPhotoShow(self._spineInterfaceComp, self._spineInterface, photoShow, true)
end

function HandbookSkinView:_onUnReloadSpineInterfaceCompOfSkeletonAnimation()
	if self._spineInterfaceComp then
		self._spineInterfaceComp:unload()
	end
end

function HandbookSkinView:_isSpineInterfaceCompLoaded()
	return self._spineInterfaceComp and self._spineInterfaceComp:isLoaded() or false
end

return HandbookSkinView
