-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/PetShowViewNew.lua

module("logic.extensions.bag.view.PetShowViewNew", package.seeall)

local PetShowViewNew = class("PetShowViewNew", ViewComponent)
local TabConst = {
	CutePet = 7,
	PetShowInfo = 1,
	SourceTrace = 8,
	PetSkillView = 2,
	PetEquip = 4,
	Hoshigami = 5,
	HolyStripe = 6,
	Stargodplus = 3
}
local STACK_LIST = {
	ViewName.PetShowInfo,
	[3] = ViewName.StargodplusmainView,
	[4] = ViewName.PetEquip,
	ViewName.PetSkillView,
	[TabConst.Hoshigami] = ViewName.HoshigamimainView,
	[TabConst.HolyStripe] = ViewName.HolyStripeMainView,
	[TabConst.CutePet] = ViewName.CutePetEquipView,
	[TabConst.SourceTrace] = ViewName.SourceTraceMainView
}
local TabAndFuncId = {
	nil,
	196,
	194,
	50,
	nil,
	603,
	910,
	[TabConst.SourceTrace] = 196
}
local tabCount = 8

function PetShowViewNew:ctor()
	PetShowViewNew.super.ctor(self)

	self.petEquipIndex = 4
	self.holyStripeIndex = 6
	self._cacheV3 = Vector3.New(0, 0, 0)
end

function PetShowViewNew:destroyUI()
	PetShowViewNew.super.destroyUI(self)
end

function PetShowViewNew:onExitFinished()
	PetShowViewNew.super.onExitFinished(self)
end

function PetShowViewNew:onEnterFinished()
	PetShowViewNew.super.onEnterFinished(self)
end

function PetShowViewNew:unbindEvents()
	PetShowViewNew.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnToHome:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self._btnSkin:RemoveClickListener()
	self._btnExit:RemoveClickListener()
	self._btnSwitch:RemoveClickListener()
	self._strategyBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnActive)
	GameUtil.rmClickHandler(self.btnInfo)
	GameUtil.rmClickHandler(self.btnShowMore)
	GameUtil.rmClickHandler(self.btnBodyChange)
	GameUtil.rmClickHandler(self._shareBtn)
	GameUtil.rmClickHandler(self._btnPosterPreview)
	GameUtil.rmClickHandler(self._btnTop)
	GameUtil.rmClickHandler(self._btnTip)

	if self._tabs then
		for i, v in ipairs(self._tabs) do
			self._tabs[i].button:RemoveClickListener()
		end
	end
end

function PetShowViewNew:bindEvents()
	PetShowViewNew.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnToHome:AddClickListener(self._onClickToHome, self)
	self._btnLeft:AddClickListener(function()
		self:_onClickSwitch(true)
	end, self)
	self._btnRight:AddClickListener(function()
		self:_onClickSwitch(false)
	end, self)
	self._btnDetail:AddClickListener(function()
		self:_onClickDetail(true, true)
	end)
	self._btnExit:AddClickListener(function()
		self:_onClickDetail(false, true)
	end)
	self._btnSkin:AddClickListener(self._onClickSkin, self)
	self._btnSwitch:AddClickListener(function()
		self._isLihui = not self._isLihui

		self:_updateState()
	end)
	GameUtil.addClickHandler(self._shareBtn, self._onClickShare, self)
	self._strategyBtn:AddClickListener(self._onClickStrategy, self)
	GameUtil.addClickHandler(self.btnActive, self.clickActive, self)
	GameUtil.addClickHandler(self.btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self.btnShowMore, self._onClickShowMore, self)
	GameUtil.addClickHandler(self.btnBodyChange, self._onClickChangeBody, self)
	GameUtil.addClickHandler(self._btnPosterPreview, self._onClickPosterPreview, self)
	GameUtil.addClickHandler(self._btnTop, self._onClickBtnTop, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)

	if self._tabs then
		for i, v in ipairs(self._tabs) do
			self._tabs[i].button:AddClickListener(function()
				self:_onClickTab(i)
			end)
		end
	end
end

function PetShowViewNew:onExit()
	PetShowViewNew.super.onExit(self)

	for _, v in pairs(self._roles) do
		RoleObjectPool.instance:removeRole(v)
	end

	self._roles = {}

	self:_closeBubbleView()
	self:_onClickDetail(false, false)
	PetCvController.instance:turnOffCurCv()

	if self._tweenFadeOut then
		self._tweenFadeOut:Kill(false)
	end

	self:_clearRawImgDrag()
	MaterialMgr.resetAll(self._rareCon)
	MaterialMgr.resetAll(self._shareProxy)

	self._btnMoreShowDataList = {}
	self._btnDataList = {}

	for i, v in pairs(self._tabs) do
		v.changeGroup:SetState(0)
	end

	self._isFold = false

	self:_resetNode()
end

function PetShowViewNew:buildUI()
	PetShowViewNew.super.buildUI(self)

	self._canvasGo = self:getGo("canvas")

	goutil.setActive(self._canvasGo, true)

	self._btnClose = self:getBtn("Left/btn_close")
	self._btnToHome = self:getBtn("Left/btn_home")
	self._rolePoint = self:getGo("lefttween/role_point")
	self._tabs = {}

	for i = 1, tabCount do
		local button = self:getBtn(string.format("righttween/yeqian/tab_%s", i))

		self._tabs[i] = {}
		self._tabs[i].button = button
		self._tabs[i].btn = button.gameObject:GetComponent("Button")
		self._tabs[i].changeGroup = button.gameObject:GetComponent(typeof(UIChangeGroup))

		if i == self.petEquipIndex then
			self._tabs[i].signGo = goutil.findChild(button.gameObject, "showSignGo")
		end
	end

	self._Container = self:getGo("container")
	self.imgMaskGo = self:getGo("imgMask")
	self._btnLeft = self:getBtn("lefttween/btn_left")
	self._btnRight = self:getBtn("righttween/btn_right")
	self._btnSwitch = self:getBtn("lefttween/con/con/btnSwitch")
	self.commentBtn = self:getBtn("lefttween/commentBtn")
	self._strategyBtn = self:getBtn("lefttween/con/con/strategyBtn")
	self._switchOn = goutil.findChild(self._btnSwitch.gameObject, "on")
	self._switchOff = goutil.findChild(self._btnSwitch.gameObject, "off")
	self._roleContainer = self:getGo("mask/role")

	local x, y, z = Framework.TransformUtil.GetLocalPos(self._roleContainer.transform, 0, 0, 0)

	self._initX = x
	self._spineMask = self:getGo("mask/spineMask")
	self._bubble = self:getGo("mask/role/bubble")
	self._btnDetail = self:getBtn("lefttween/btn_infor")
	self._btnSkin = self:getBtn("lefttween/con/con/btnSkin")
	self.skin_red = self:getGo("lefttween/con/con/btnSkin/red_point")
	self._btnTop = self:getGo("lefttween/con/con/btnTop")
	self._btnTopImgChangeComp = self:getGo("lefttween/con/con/btnTop/icon"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtBtnTop = self:getTxt("lefttween/con/con/btnTop/Text")
	self.btnActive = self:getGo("lefttween/con/con/btnActive")
	self.btnActiveOn = self:getGo("lefttween/con/con/btnActive/on")
	self.btnActiveOff = self:getGo("lefttween/con/con/btnActive/off")
	self.btnInfo = self:getGo("lefttween/btnInfo")
	self.btnBodyChange = self:getBtn("lefttween/con/con/btnBodyChange")
	self._shareBtn = self:getBtn("lefttween/con/con/shareBtn")
	self._btnPosterPreview = self:getGo("lefttween/con/con/btnPosterPreview")
	self.btnShowMore = self:getBtn("lefttween/con/con/btnShowMore")
	self.arrow = self:getGo("lefttween/con/con/btnShowMore/arrow")
	self._left = goutil.findChild(self.mainGO, "Left")
	self._middle = goutil.findChild(self.mainGO, "lefttween")
	self._detailAnim = goutil.findChildComponent(self.mainGO, "role", "Animator")
	self._btnExit = self:getBtn("btnExit")

	self:_onClickDetail(false, false)

	self._roles = {}
	self._redPoints = {}

	for i = 1, tabCount do
		self._redPoints[i] = goutil.findChild(self._tabs[i].btn.gameObject, "red_point")
	end

	self._canvas = goutil.findChildComponent(self.mainGO, "canvas", "Canvas")

	local canvas = UGUIToolHelper.FindCanvas(self.mainGO)

	self._canvas.sortingOrder = canvas.sortingOrder - 2
	self._luopan = self:getGo("canvas/bg")
	self._info = self:getGo("lefttween/info")
	self._stars = PetStarItem.New(goutil.findChild(self._info, "stars"))
	self._txtName = goutil.findChildTextComponent(self._info, "txt_name")
	self._rareCon = goutil.findChild(self._info, "con")
	self.goldBarCon = self:getGo("goldBarCon")
	self._blocked = self:getGo("block")

	local dragContent = self:getGo("mask/role/dragContent")
	local rawImg = goutil.findChild(dragContent, "role_image_1")

	self._rawImgDrag = RawImageDrag.New(dragContent, rawImg)

	self._rawImgDrag:setUpdateCallback(self._updateCell, self)
	self._rawImgDrag:setClickCallback(self._onClickCell, self)

	self._showSignGo = goutil.findChild(self.mainGO, "righttween/yeqian/tab_3/showSignGo")

	goutil.setActive(self._info, false)

	self._extendView = self:getGo("mask/role/extendView")
	self._spineInterface = self:getGo("mask/role/spineInterface")
	self._btnTip = self:getGo("Left/btnTip")
	self._righttween = self:getGo("righttween"):GetComponent(ComponentType.TweenPosition)
	self._lefttween = self:getGo("lefttween"):GetComponent(ComponentType.TweenPosition)
	self._foldMaskGo = self:getGo("foldMask")

	goutil.setActive(self._foldMaskGo, false)
end

function PetShowViewNew:_buildRawImgDrag()
	self._petPhotoShows = {}
end

function PetShowViewNew:_clearRawImgDrag()
	self:_onUnReloadSpineInterfaceCompOfSkeletonAnimation()

	for _, v in ipairs(self._petPhotoShows) do
		v:destroy()
	end

	self._petPhotoShows = nil
	self._curPetPhotoShow = nil
end

function PetShowViewNew:_updateBlocked(isBlocked)
	print("update blocked = " .. tostring(isBlocked))
	goutil.setActive(self._blocked, isBlocked)
end

function PetShowViewNew:_onPetSelect()
	self:_updateRedPoints()

	self._curIndex = BagPetsController.instance:getPetIndex()

	self:_updateCell(self._curIndex, self._rawImgDrag._curImg)
end

function PetShowViewNew:_updateRedPoints()
	local curPetId = BagPetsController.instance:GetCurPetId()

	goutil.setActive(self._showSignGo, false)

	for i = 1, tabCount do
		local redPoint = self._redPoints[i]
		local isActive = false

		if i == 2 then
			isActive = BagPetsController.instance:getIfPetSkillUpgrade(curPetId)
		elseif i == 3 then
			isActive = StargodplusModel.instance:checkPetCanEquipById(curPetId)

			if not isActive then
				local canUp = StargodplusModel.instance:checkPetCanUpgradeEquipById(curPetId)

				goutil.setActive(self._showSignGo, canUp)
			end
		elseif i == self.petEquipIndex then
			isActive = PetEquipController.instance:GetPetAllEquipRedPoint(curPetId, PetEquipModel.PetEquipRedType.Wear) or PetEquipController.instance:GetPetAllEquipRedPoint(curPetId, PetEquipModel.PetEquipRedType.TuPo)

			local isSign = PetEquipController.instance:GetPetAllEquipRedPoint(curPetId, PetEquipModel.PetEquipRedType.Strengthen)

			if self._tabs[self.petEquipIndex] and self._tabs[self.petEquipIndex].signGo then
				goutil.setActive(self._tabs[self.petEquipIndex].signGo, isSign)
			end
		elseif i == self.holyStripeIndex and FormationGroupModel.instance:checkIsInTeam(curPetId) then
			isActive = HolyStripeModel.instance:petHaveRetPoint(curPetId)
		end

		goutil.setActive(redPoint, isActive)
	end
end

function PetShowViewNew:UpdataPetChanged(ids)
	self:showPetView()

	local petId = BagPetsController.instance:GetCurPetId()

	for id, value in pairs(ids or {}) do
		if id and value and id == petId then
			self:UpdataEquipRedPoint(petId)

			break
		end
	end
end

function PetShowViewNew:UpdataEquipRedPoint(petId)
	if self._redPoints == nil or self._redPoints[self.petEquipIndex] == nil then
		return
	end

	if not petId then
		::label_21_0::

		local curPetId = BagPetsController.instance:GetCurPetId()
		local isActive = PetEquipController.instance:GetPetAllEquipRedPoint(curPetId, PetEquipModel.PetEquipRedType.Wear) or PetEquipController.instance:GetPetAllEquipRedPoint(curPetId, PetEquipModel.PetEquipRedType.TuPo)
		local isSign = PetEquipController.instance:GetPetAllEquipRedPoint(curPetId, PetEquipModel.PetEquipRedType.Strengthen)

		if self._tabs[self.petEquipIndex] and self._tabs[self.petEquipIndex].signGo then
			goutil.setActive(self._tabs[self.petEquipIndex].signGo, isSign)
		end

		goutil.setActive(self._redPoints[self.petEquipIndex], isActive)
	end
end

function PetShowViewNew:onEnter()
	PetShowViewNew.super.onEnter(self)

	self._btnDataList = {}
	self._btnMoreShowDataList = {}

	self:_addBtnManager()

	self._bInitedOnceList = false

	self:_buildRawImgDrag()
	MopupModel.instance:setPetTalentUpCostStr()

	self._isLihui = true
	self._isPoster = false
	self._isShowBtns = false
	self._isFold = false

	self:_updateState()

	self._curIndex = 1
	self.curTabIdx = BagPetsController.instance:getPetShowTab()

	local params = self._viewPresentor:getOpenParam()

	if params ~= nil then
		local idx = params[1]

		if idx ~= nil then
			if checknumber(idx) > 0 then
				self.curTabIdx = idx

				BagPetsController.instance:setPetShowTab(idx)
			else
				for k, v in pairs(STACK_LIST) do
					if v == idx then
						self.curTabIdx = k

						BagPetsController.instance:setPetShowTab(idx)

						break
					end
				end
			end
		end

		local raceId = params[2]

		if raceId ~= nil and type(raceId) == "number" then
			self._firstRaceId = raceId
		end
	else
		self._firstRaceId = nil
	end

	self:updateList(true)
	self:_updateBlocked(false)
	self:_updateTabs()
	self.addGEvent(self, GlobalNotify.PET_VIEW_CHANGE_TAB, self._showTab, self)
	self.addGEvent(self, GlobalNotify.BagPetAttrChanged, self.updateList, self)
	self.addGEvent(self, GlobalNotify.BagPetsInit, self.updateList, self)
	self.addGEvent(self, GlobalNotify.PlayBubble, self._playBubble, self)
	self.addGEvent(self, GlobalNotify.PET_EQUIP_CHANGES, self.UpdataEquipRedPoint, self)
	self.addGEvent(self, GlobalNotify.BagPetChanged, self.UpdataPetChanged, self)
	self.addGEvent(self, GlobalNotify.PetRedPointUpdate, self._updateRedPoints, self)
	self.addGEvent(self, GlobalNotify.OnPetSelect, self._onPetSelect, self)
	self.addGEvent(self, GlobalNotify.PetShowViewBlocked, self._updateBlocked, self)
	self.addGEvent(self, PetStrategyConfig.LEFTBTN, self._onClickSwitch, self)
	self.addGEvent(self, PetStrategyConfig.RIGHTBTN, self._onClickSwitch, self)
	self.addGEvent(self, GlobalNotify.PetSkinDataInited, self.showPetView, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self.showPetView, self)
	self.addGEvent(self, GlobalNotify.OnMofangLvUp, self._updateTabs, self)
	self.addGEvent(self, BagModel.NotifyName_PetShowViewPlayPetAnim, self._playPetAnimAndBubble, self)
	self.addGEvent(self, MsEnum.Notify_SpineInterfaceBagExtension, self._notify_SpineInterfaceBagExtension, self)
	self:_resetNode()
end

function PetShowViewNew:_updateGoldBar(idx)
	local tabIdx = BagPetsController.instance:getPetShowTab(idx)
	local btnList

	if tabIdx == TabConst.SourceTrace then
		btnList = {}

		local mo = BagPetsController.instance:GetCurPetMo()
		local matList = SourceTraceController.instance:getSourceTraceUnlockMat(mo.raceId)

		for i, v in ipairs(matList) do
			table.insert(btnList, {
				showAdd = true,
				id = v
			})
		end
	else
		btnList = {
			{
				showAdd = true,
				id = GameEnum.GoldType.Coin
			}
		}
	end

	MainUIController.instance:showGlodBar(self.goldBarCon, self._viewPresentor, btnList)
end

function PetShowViewNew:_updateTabs()
	for i, tab in pairs(TabAndFuncId) do
		local tab = self._tabs[i].btn.gameObject
		local lock = goutil.findChild(tab, "lock")
		local isOpen, tips = self:getTabIsOpen(i)

		goutil.setActive(lock, not isOpen)
	end

	local mo = BagPetsController.instance:GetCurPetMo()
	local isSourceTrace = PetSkinConfig.instance:checkHasJob(mo.curFaceId, GameEnum.JobZhDefine.SourceTrace)

	GameUtil.SetActive(self._tabs[TabConst.PetSkillView].btn.gameObject, not isSourceTrace)
	GameUtil.SetActive(self._tabs[TabConst.SourceTrace].btn.gameObject, isSourceTrace)
end

function PetShowViewNew:_onClickCell()
	print("CLICK CELL")
	self:_playPetAnimAndBubble()
end

function PetShowViewNew:_playPetAnimAndBubble()
	if self._isInfo then
		local mo = BagPetsController.instance:GetCurPetMo()
		local pos = self._bubble.transform.position

		PetCvController.instance:playPetCv(mo.curFaceId, nil, true, pos)

		if self._curPetPhotoShow then
			self._curPetPhotoShow:playShowAnim()
		end
	end
end

function PetShowViewNew:_playBubble(content)
	BubbleController.instance:OpenView(content, self._bubble.transform.position)
end

function PetShowViewNew:_closeBubbleView()
	BubbleController.instance:CloseView()
end

function PetShowViewNew:_GetSkeletonGraphic(character)
	return goutil.findChild(self._curCharacter, "skeleton"):GetComponent("SkeletonGraphic")
end

function PetShowViewNew:_showTab(idx)
	self:onShowView(idx)
end

function PetShowViewNew:updateList(isForce)
	self:_RefreshPetList(isForce)
end

function PetShowViewNew:_RefreshPetList(isForce)
	local petId

	if not self._bInitedOnceList then
		self._bInitedOnceList = true
	elseif self._curIndex > 0 and self._curViewDatas and #self._curViewDatas > 0 then
		local mo = self._curViewDatas[self._curIndex]

		if mo then
			petId = mo.petId
		end
	end

	local list = BagModel.instance:getCurPetViewList()

	self._curViewDatas = list and list or BagPetsController.instance:getBagAndBorrowPets()

	if not self._firstRaceId then
		petId = petId or BagPetsController.instance:GetCurPetId()
	else
		for i, v in ipairs(self._curViewDatas) do
			if self._firstRaceId == v.raceId then
				petId = v.petId

				break
			end
		end

		self._firstRaceId = nil
	end

	if petId == nil then
		if #self._curViewDatas > 0 then
			self._curIndex = 1
		end
	elseif petId ~= nil then
		for i, v in ipairs(self._curViewDatas) do
			if petId == v.petId then
				self._curIndex = i

				break
			end
		end
	end

	local mo = self._curViewDatas[self._curIndex]

	if mo then
		BagPetsController.instance:SetCurPetId(mo.petId)
	end

	if isForce == true or self._showPetId ~= mo.petId then
		self:centerOnIndex(self._curIndex, false)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnPetSelect)
	end
end

function PetShowViewNew:centerOnIndex(idx, isSpring, isLeft)
	idx = checknumber(idx)

	if self._curViewDatas and idx >= 1 and idx <= #self._curViewDatas then
		self._rawImgDrag:setMaxNum(#self._curViewDatas)
		self._rawImgDrag:centerOnIndex(idx, isSpring, isLeft)
	else
		print("invalid idx = " .. tostring(idx))
	end
end

function PetShowViewNew:clickActive()
	local data = BagPetsController.instance:GetCurPetMo()
	local isShow = PetskinController.instance:getCanShowPoster(data.curFaceId)

	isShow = not isShow

	PetskinController.instance:setCanShowPoster(data.curFaceId, isShow)
	self:showPetView()
end

function PetShowViewNew:_updateState()
	self._showLihui = self._isLihui and self._hasLihui

	goutil.setActive(self._switchOn, self._isLihui)
	goutil.setActive(self._switchOff, not self._isLihui)

	if not self._showLihui and self._curShowSpine ~= nil and self._curShowAnim ~= nil then
		self._curShowSpine:setSpine(self._curShowAnim, {
			"idle"
		})
	end

	if self._curPetPhotoShow then
		self._curPetPhotoShow:showShadow(true)
		self._curPetPhotoShow:switchState(self._showLihui)
	end
end

function PetShowViewNew:_updateCell(idx, cell)
	local petPhotoShow = PetPhotoShow.Get(cell.gameObject)

	petPhotoShow:showShadow(true)

	local data = self._curViewDatas[idx]

	if not data then
		return
	end

	self._curIndex = idx
	self._showPetId = data.petId

	self:_onSelectIdChange()

	if self.curTabIdx == TabConst.SourceTrace or self.curTabIdx == TabConst.PetSkillView then
		local mo = BagPetsController.instance:GetCurPetMo()
		local isSourceTrace = PetSkinConfig.instance:checkHasJob(mo.curFaceId, GameEnum.JobZhDefine.SourceTrace)

		self.curTabIdx = isSourceTrace == true and TabConst.SourceTrace or TabConst.PetSkillView
	end

	self:_showTab(self.curTabIdx)
	self:_updateRedPoints()
	GameUtil.SetActive(self._btnLeft.gameObject, self._isInfo and self._curIndex > 1)
	GameUtil.SetActive(self._btnRight.gameObject, self._isInfo and self._curIndex < #self._curViewDatas)

	self._curPetPhotoShow = petPhotoShow

	self._curPetPhotoShow:setCallBackOnEffLoadedAfter(GameUtil.handler(self._onReloadSpineInterfaceCompOfSkeletonAnimation, self))
	self._curPetPhotoShow:setCallBackOnEffUnloadBefore(GameUtil.handler(self._onUnReloadSpineInterfaceCompOfSkeletonAnimation, self))
	self:showPetView()

	local awakenType = CharacterConfig.instance:getPetAwakenType(data.raceId, data.awakenLv)

	table.insert(self._petPhotoShows, petPhotoShow)
	self._stars:updateStar(data.awakenLv)
	GlobalDispatcher:dispatch(PetStrategyConfig.UPDATE, self._curIndex > 1, self._curIndex < #self._curViewDatas)
end

function PetShowViewNew:showPetView()
	self._isPoster = false

	GameUtil.SetActive(self.imgMaskGo, self._isInfo)
	self:_updateOneBtnsCon(self.btnActive.gameObject, false)

	local data = BagPetsController.instance:GetCurPetMo()

	if not data then
		return
	end

	local isShow = PetskinController.instance:getCanShowPoster(data.curFaceId)

	GameUtil.SetActive(self._btnTip, PetSkinConfig.instance:checkHasJob(data.curFaceId, GameEnum.CareerType.Zhaohuanshi) or checknumber(data.contractSkillId) > 0)

	if self._curPetPhotoShow then
		local posterCfg = PetskinController.instance:getPosterCfg(data.curFaceId)

		if posterCfg and self._isInfo then
			self:_updateOneBtnsCon(self.btnActive.gameObject, true)
			GameUtil.SetActive(self.btnActiveOn, isShow)
			GameUtil.SetActive(self.btnActiveOff, not isShow)

			if isShow then
				self._isPoster = true

				GameUtil.SetActive(self.imgMaskGo, false)

				local isChange = PetskinModel.instance:getIsUnlockDyPoster(posterCfg.posterId)

				self._curPetPhotoShow:showPetPoster(posterCfg.posterId, isChange)
			else
				self._curPetPhotoShow:showPetEffect(data.curFaceId, self._showLihui, nil, nil)
			end
		else
			self._curPetPhotoShow:showPetEffect(data.curFaceId, self._showLihui, nil, nil)
		end

		self._curPetPhotoShow:showShadow(true)
	end

	self:_updateOneBtnsCon(self.btnBodyChange.gameObject, self._isInfo and PetSkinConfig.instance:checkHasMutiBody(data.curFaceId))
	self:_btnsDefaultState()
	self:_updateTabs()
end

function PetShowViewNew:onShowView(idx)
	local name = STACK_LIST[idx]

	if name == nil then
		FloatWordMgr.instance:show(ConstString.NotRelease)

		return
	end

	if self._tabs[idx] then
		for i = 1, #self._tabs do
			local btn = self._tabs[i].btn

			btn.interactable = i ~= idx
		end
	end

	self._tabs[self.curTabIdx].changeGroup:SetState(0)

	self.curTabIdx = idx

	self._tabs[self.curTabIdx].changeGroup:SetState(1)
	BagPetsController.instance:setPetShowTab(idx)

	local params = self._viewPresentor:getOpenParam()

	if params then
		params[1] = idx

		UIStateManager.instance:updateParms(self._viewPresentor.viewName, params)
	end

	goutil.setActive(self._middle, name ~= ViewName.HoshigamimainView)
	self:showTabAt(self._Container, name)

	local isInfo = idx == 1

	self._isInfo = isInfo

	GameUtil.SetActive(self._spineMask, not isInfo)

	self._isPoster = false

	self:showPetView()

	local x, y, z = Framework.TransformUtil.GetLocalPos(self._roleContainer.transform, 0, 0, 0)

	if isInfo then
		if not self._initX then
			local target = self._initX - 400

			self._tweenFadeOut = TweenUtil.ValueTo(0, 1, 0.3, function(val)
				Framework.TransformUtil.SetLocalPos(self._roleContainer.transform, x + (target - x) * val, 0, 0)
			end, function()
				return
			end, self)

			local mo = BagPetsController.instance:GetCurPetMo()

			self._txtName.text = mo.name

			local proxy = MaterialMgr.setCell(MatType.Rare, mo.raceId, self._rareCon)

			proxy.binder:setRare(mo.rare)
			goutil.setActive(self._luopan, isInfo)
			GameUtil.SetActive(self.btnInfo, isInfo)

			local skinId = mo.curFaceId
			local cfg = CharacterConfig.instance:getModelCo(checknumber(skinId))

			self._hasLihui = cfg ~= nil and not string.nilorempty(cfg.bustName)
			self._showLihui = self._isLihui and self._hasLihui

			GameUtil.SetActive(self._spineInterface, self:_isInteractable(skinId))
			GameUtil.SetActive(self._btnLeft.gameObject, self._isInfo and self._curIndex > 1)
			GameUtil.SetActive(self._btnRight.gameObject, self._isInfo and self._curIndex < #self._curViewDatas)

			local skinList = PetSkinConfig.instance:getPetSkinListBySkinId(mo.curFaceId)
			local posterList = PetSkinConfig.instance:getPosterList(skinId)

			goutil.setActive(self._btnSwitch.gameObject, false)
			self:_updateOneBtnsCon(self._btnTop.gameObject, name == ViewName.PetShowInfo)
			self:_updateOneBtnsCon(self._btnSkin.gameObject, isInfo and skinList and #skinList > 1)
			self:_updateOneBtnsCon(self._btnSwitch.gameObject, false)
			self:_updateOneBtnsCon(self._strategyBtn.gameObject, PetStrategyConfig.instance:getStrategyById(mo.raceId) and name == ViewName.PetShowInfo)
			self:_updateOneBtnsCon(self._shareBtn.gameObject, isInfo and ShareController.instance.isOpenShare() and not mo:isBorrowPet())
			self:_updateOneBtnsCon(self._btnPosterPreview.gameObject, posterList and #posterList > 0 and name == ViewName.PetShowInfo)

			local canShowSkin = BagModel.instance:getHasSkin(mo.petId)

			goutil.setActive(self.skin_red, canShowSkin)

			local isTop = BagPetsController.instance:getPetIsTop(mo.petId)

			self._btnTopImgChangeComp:SetState(isTop and 1 or 0)

			self._txtBtnTop.text = isTop and "取消" or "置顶"

			if BootstrapPjaqGameConfigMgr.isReview then
				self:_updateOneBtnsCon(self._btnSkin.gameObject, false)
			end

			if not self._isInfo then
				self._isLihui = true

				self:_updateState()
				PetCvController.instance:turnOffCurCv()
			end

			self:_updateGoldBar()
			self:_btnsDefaultState()
		end
	end
end

function PetShowViewNew:_getPetStarViewName()
	local mo = BagPetsController.instance:GetCurPetMo()
end

function PetShowViewNew:_onClickClose()
	if not self._isFold then
		self:close()
	else
		self:_onClickInfo()
	end
end

function PetShowViewNew:_onClickToHome()
	UIStateManager.instance:clear(true)
end

function PetShowViewNew:_onClickSkin()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_PET_SKIN)

	local mo = BagPetsController.instance:GetCurPetMo()

	UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_PET_MO, mo)
end

function PetShowViewNew:_onSelectIdChange()
	local mo = self._curViewDatas[self._curIndex]

	BagPetsController.instance:SetCurPetId(mo.petId)
	GlobalDispatcher:dispatch(GlobalNotify.OnPetSelect, mo)
	self:_closeBubbleView()
end

function PetShowViewNew:getTabIsOpen(idx)
	local funcId = TabAndFuncId[idx]

	if funcId ~= nil then
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

		print("funcId = " .. funcId .. "isOpen = " .. tostring(FuncOpenModel.instance:getFuncIsOpen(funcId)))

		if not FuncOpenModel.instance:getFuncIsOpen(funcId) then
			local lockTips = cfg.lockedTips

			if string.nilorempty(lockTips) then
				lockTips = "还没到开启条件"
			end

			return false, lockTips
		end
	end

	return true
end

function PetShowViewNew:_onClickTab(idx)
	local isOpen, tips = self:getTabIsOpen(idx)

	if not isOpen then
		FloatWordMgr.instance:show(tips)
	else
		self:_showTab(idx)
	end
end

function PetShowViewNew:_onClickSwitch(isLeft)
	if isLeft then
		if not (self._curIndex - 1) then
			local newIdx = self._curIndex + 1

			self:centerOnIndex(newIdx, true, isLeft)
		end
	end
end

function PetShowViewNew:_onClickDetail(isIn, isAnim)
	return
end

function PetShowViewNew:_onClickInfo()
	self._isFold = not self._isFold

	GlobalDispatcher:dispatch(GlobalNotify.PetShowViewNodeFold, self._isFold)
	self:_stopTween()
	self:_startTween()
	goutil.setActive(self.goldBarCon, not self._isFold)
	self._rawImgDrag:setDragEnabled(not self._isFold)
end

function PetShowViewNew:_onClickStrategy()
	local mo = BagPetsController.instance:GetCurPetMo()

	if PetStrategyConfig.instance:getStrategyById(mo.raceId) then
		UIStateManager.instance:push(ViewName.PetStrategyView, mo, self._curIndex > 1, self._curIndex < #self._curViewDatas)
	else
		FloatWordMgr.instance:show(string.format("没有%s的攻略信息", mo.name))
	end
end

function PetShowViewNew:_onClickChangeBody()
	local mo = BagPetsController.instance:GetCurPetMo()

	BagPetsController.instance:sendChangePetBody(mo)
end

function PetShowViewNew:_addBtnManager()
	self:_addBtnGo(self.btnBodyChange.gameObject)
	self:_addBtnGo(self._btnSkin.gameObject)
	self:_addBtnGo(self._btnTop.gameObject)
	self:_addBtnGo(self.btnActive.gameObject)
	self:_addBtnGo(self._strategyBtn.gameObject)
	self:_addBtnGo(self._btnSwitch.gameObject)
	self:_addBtnGo(self._shareBtn.gameObject)
	self:_addBtnGo(self._btnPosterPreview.gameObject)
end

function PetShowViewNew:_addBtnGo(go)
	local btnData = {}

	btnData.go = go
	btnData.active = false

	table.insert(self._btnDataList, btnData)
end

function PetShowViewNew:_updateOneBtnsCon(go, active)
	for i, v in ipairs(self._btnDataList) do
		if v.go == go then
			v.active = active
		end
	end
end

function PetShowViewNew:_btnsDefaultState()
	table.clear(self._btnMoreShowDataList)

	local index = 0

	for i, v in ipairs(self._btnDataList) do
		if v.active == true then
			index = index + 1

			if index <= 3 then
				GameUtil.SetActive(v.go, true)
			else
				GameUtil.SetActive(v.go, self._isShowBtns)
				table.insert(self._btnMoreShowDataList, v.go)
			end
		else
			GameUtil.SetActive(v.go, false)
		end
	end

	GameUtil.SetActive(self.btnShowMore, index > 3)
	GameUtil.setLocalScale(self.arrow, self._isShowBtns and 1 or -1, 1, 1)
end

function PetShowViewNew:_onClickShowMore()
	self._isShowBtns = not self._isShowBtns

	for _, v in ipairs(self._btnMoreShowDataList) do
		GameUtil.SetActive(v, self._isShowBtns)
	end

	GameUtil.setLocalScale(self.arrow, self._isShowBtns and 1 or -1, 1, 1)
end

function PetShowViewNew:_notify_SpineInterfaceBagExtension(eventParams)
	if self._spineInterfaceComp then
		self._extendViewPresentor = self._spineInterfaceComp:openExtension(self._extendView, self._viewPresentor, eventParams)
	end
end

function PetShowViewNew:_closeSpineInterfaceExtension()
	if self._extendViewPresentor then
		ViewMgr.instance:close(self._extendViewPresentor.viewName)

		self._extendViewPresentor = nil
	end
end

function PetShowViewNew:_onReloadSpineInterfaceCompOfSkeletonAnimation(photoShow)
	local skinId

	self._spineInterfaceComp, skinId = SpineInterfaceComp.reloadPhotoShow(self._spineInterfaceComp, self._spineInterface, photoShow, true)

	GameUtil.SetActive(self._spineInterface, self:_isInteractable(skinId))
end

function PetShowViewNew:_onUnReloadSpineInterfaceCompOfSkeletonAnimation()
	self:_closeSpineInterfaceExtension()

	if self._spineInterfaceComp then
		self._spineInterfaceComp:unload()
	end
end

function PetShowViewNew:_isSpineInterfaceCompLoaded()
	return self._spineInterfaceComp and self._spineInterfaceComp:isLoaded() or false
end

function PetShowViewNew:_isInteractable(skinId)
	if self:_isSpineInterfaceCompLoaded() and self._isInfo then
		local posterCfg = CharacterConfig.instance:getPosterModelCo(skinId)

		if posterCfg ~= nil or PetSkinConfig.instance:isSkinInteractable(skinId) then
			return true
		end
	end

	return false
end

function PetShowViewNew:_onClickShare()
	ShareController.instance:share(1, {
		self._shareBtn.gameObject
	}, nil, 200321)
end

function PetShowViewNew:_onClickPosterPreview()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_PET_HAIBAO)

	local mo = BagPetsController.instance:GetCurPetMo()
	local skinId = mo.curFaceId
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

function PetShowViewNew:_onClickBtnTop()
	local mo = BagPetsController.instance:GetCurPetMo()
	local isTop = BagPetsController.instance:getPetIsTop(mo.petId)
	local afterClickTopState = not isTop

	BagPetsController.instance:setPetIsTop(mo.petId, afterClickTopState)
	self._btnTopImgChangeComp:SetState(afterClickTopState and 1 or 0)

	self._txtBtnTop.text = afterClickTopState and "取消" or "置顶"
end

function PetShowViewNew:_onClickBtnTip()
	local ruleList = {}

	for i = 1, 3 do
		local obj = {}

		obj.url = GameUrl.getBigbgFolderUrl("contract", "board_zhaohuanshitujian_guize0" .. i)

		table.insert(ruleList, obj)
	end

	TipsFacade.instance:openImageRuleView(ruleList)
end

function PetShowViewNew:_resetNode()
	goutil.setActive(self.goldBarCon, true)
	goutil.setActive(self._foldMaskGo, false)
	self:_stopTween()
	self:_startTween(0)
end

function PetShowViewNew:_stopTween()
	self._lefttween:Stop()
	self._righttween:Stop()
end

function PetShowViewNew:_setCacheV3(x, y)
	self._cacheV3.x = x
	self._cacheV3.y = y
end

function PetShowViewNew:_startTween(time)
	local time = time or 0.3
	local startPos = {
		640,
		0
	}
	local endPos = {
		0,
		0
	}
	local rightStartPos = {
		-640,
		0
	}

	if self._isFold then
		self:_setCacheV3(startPos[1], startPos[2])

		self._lefttween.from = self._cacheV3

		self:_setCacheV3(endPos[1], endPos[2])

		self._lefttween.to = self._cacheV3

		self:_setCacheV3(rightStartPos[1], rightStartPos[2])

		self._righttween.from = self._cacheV3

		self:_setCacheV3(endPos[1], endPos[2])

		self._righttween.to = self._cacheV3
	else
		self:_setCacheV3(startPos[1], startPos[2])

		self._lefttween.to = self._cacheV3

		self:_setCacheV3(endPos[1], endPos[2])

		self._lefttween.from = self._cacheV3

		self:_setCacheV3(rightStartPos[1], rightStartPos[2])

		self._righttween.to = self._cacheV3

		self:_setCacheV3(endPos[1], endPos[2])

		self._righttween.from = self._cacheV3
	end

	self._lefttween.time = time
	self._righttween.time = time

	self._lefttween:Begin()
	self._righttween:Begin()
end

return PetShowViewNew
