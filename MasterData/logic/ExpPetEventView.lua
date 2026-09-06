-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpPetEventView.lua

module("logic.extensions.expedition.view.ExpPetEventView", package.seeall)

local ExpPetEventView = class("ExpPetEventView", FormationRightView)

function ExpPetEventView:ctor()
	ExpPetEventView.super.ctor(self)

	self._disableDrag = true
end

function ExpPetEventView:buildUI()
	ExpPetEventView.super.buildUI(self)

	self._bgMaskButton = self:getBtn("Canvas/bgMask")
	self._closeButton = self:getBtn("btnClose")
	self._btnSelect = self:getBtn("btnSelect")
	self._petsNode = self:getGo("SelectPets"):GetComponent("UILayoutSingleLine")
	self._bottomBgRectTrans = self:getGo("bottomBg"):GetComponent(goutil.Type_RectTransform)
	self._Nego_RightRectTrans = self:getGo("Nego_Right"):GetComponent(goutil.Type_RectTransform)
	self._btnArrow = self:getBtn("bottomBg/btnArrow")
	self._txtBottomGo = self:getGo("bottomBg/txt")
	self._imgBottomArrowRect = self:getGo("bottomBg/btnArrow"):GetComponent(goutil.Type_RectTransform)
	self._dragArrow = Framework.UIDragTrigger.Get(self._btnArrow.gameObject)
	self._bottomText = self:getGo("bottomBg/txt")
	self._petNums = self:getTxt("petNums")

	local bgCanvas = self:getGo("Canvas")

	GameUtil.expandRectTransform(bgCanvas.transform)
end

function ExpPetEventView:destroyUI()
	ExpPetEventView.super.destroyUI(self)
end

function ExpPetEventView:onExitFinished()
	ExpPetEventView.super.onExitFinished(self)

	self._canOpen = nil
	self._gridData = nil
	self._selectPetIds = nil
	self._selectIndex = nil
	self._replacePetId = nil
	self._curViewDatas = nil
	self._selectDatas = nil
	self._currDataIndex = nil

	local nodeCnt = self._petsNode.transform.childCount

	for i = 1, nodeCnt do
		local go = self._petsNode.transform:GetChild(i - 1).gameObject
		local btn = Framework.ButtonAdapter.Get(go)
		local icon = Framework.ImageBigBG.GetFrom(go, "mask/con")
		local rareCon = goutil.findChild(go, "con")

		icon:ClearImage()
		btn:RemoveClickListener()
		MaterialMgr.resetAll(rareCon)
	end
end

function ExpPetEventView:onEnterFinished()
	ExpPetEventView.super.onEnterFinished(self)
end

function ExpPetEventView:unbindEvents()
	self:_unbindUIEvents()
	self._btnSelect:RemoveClickListener()
	self._btnArrow:RemoveClickListener()
	self._closeButton:RemoveClickListener()
	self._bgMaskButton:RemoveClickListener()
	self._dragArrow:RemoveDragListener()
	self._dragArrow:RemoveEndDragListener()
end

function ExpPetEventView:bindEvents()
	self:_bindUIEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._bgMaskButton:AddClickListener(self._onClickClose, self)
	self._btnSelect:AddClickListener(self._onClickSelect, self)
	self._btnArrow:AddClickListener(self._onClickArrow, self)
	self._dragArrow:AddDragListener(self._onDragPetsView, self)
	self._dragArrow:AddEndDragListener(self._onEndDragPetsView, self)
end

function ExpPetEventView:onExit()
	self._endDragState = nil

	self:_stopSelectEffect()
	self._tableview:Travel(function(cell)
		ItemPet.Remove(cell.gameObject)
	end, nil)
	GlobalDispatcher:removeListener(GlobalNotify.OnSweepSelEventBack, self._onSweepSelEventBack, self)
	ExpPetEventView.super.onExit(self)
end

function ExpPetEventView:onEnter()
	ExpeditionFmtModel.instance:checkPetsDead()
	ExpPetEventView.super.onEnter(self)

	self._selectDatas = self._viewPresentor._openParam[1]
	self._canOpen = self._viewPresentor._openParam[2]
	self._isSweep = self._viewPresentor._openParam[3] or false

	self._closeButton.gameObject:SetActive(not self._isSweep)
	self._btnSelect.gameObject:SetActive(self._canOpen or false)
	self:_updateEventByIndex(1)
	GlobalDispatcher:addListener(GlobalNotify.OnSweepSelEventBack, self._onSweepSelEventBack, self)
end

function ExpPetEventView:_updateEventByIndex(index)
	self._currDataIndex = index
	self._gridData = self._selectDatas[index]

	self:_initBottomShow()
	self:_initPets()
	self:_updatePetsList()
end

function ExpPetEventView:_initBottomShow()
	self._isShowBottom = false
	self._bottomBgRectTrans.anchoredPosition = Vector2.New(0, -137)
	self._Nego_RightRectTrans.anchoredPosition = Vector2.New(265.8, -146)
	self._btnArrow.transform.eulerAngles = Vector3.New(0, 0, 180)

	self._txtBottomGo:SetActive(true)
	self:_playBottomArrowAnim(true)
end

function ExpPetEventView:_setBottomShow(isShowList)
	self._isShowBottom = isShowList

	self._txtBottomGo:SetActive(not isShowList)
	self:_playBottomArrowAnim(not isShowList)
	self._bottomText:SetActive(not isShowList)

	if isShowList then
		self._bottomBgRectTrans:DOAnchorPosY(0, 0.2)
		self._Nego_RightRectTrans:DOAnchorPosY(0, 0.2)

		self._btnArrow.transform.eulerAngles = Vector3.New(0, 0, 0)
	else
		self._bottomBgRectTrans:DOAnchorPosY(-137, 0.2)
		self._Nego_RightRectTrans:DOAnchorPosY(-146, 0.2)

		self._btnArrow.transform.eulerAngles = Vector3.New(0, 0, 180)
	end
end

function ExpPetEventView:_playBottomArrowAnim(isPlay)
	if self._tweenBottomArrow then
		self._tweenBottomArrow:Kill()

		self._tweenBottomArrow = nil
	end

	if isPlay then
		self._imgBottomArrowRect.anchoredPosition = Vector2(0, 74)
		self._tweenBottomArrow = self._imgBottomArrowRect:DOAnchorPosY(82, 0.35):SetLoops(-1, DG.Tweening.LoopType.Yoyo)
	else
		self._imgBottomArrowRect.anchoredPosition = Vector2(0, 79.1)
	end
end

function ExpPetEventView:_updateCell(view, cell, data)
	data.isDead = ExpeditionModel.instance:isPetDead(data.petId)

	local component = ItemPet.AddOnce(cell.gameObject)

	self:updateForbit(data)
	component:Init(data)
	component:setSelected(false)

	local inTeamId = ExpeditionFmtModel.instance:getPetIdInTeamByRaceId(data.raceId)

	component:SetInTeam(inTeamId == data.petId)

	local imgSelected = goutil.findChild(cell, "ImgC_Selected")

	imgSelected:SetActive(self._selectedReplacePetId == data.petId)

	local childCnt = cell.transform.childCount - 1

	imgSelected.transform:SetSiblingIndex(childCnt)
end

function ExpPetEventView:updateForbit(data)
	data:setPetForbit(ExpeditionModel.instance:isPetDead(data.petId))
end

function ExpPetEventView:_RefreshPetList()
	self._curViewDatas = {}

	local pets = ExpeditionFmtModel.instance:getAllPets()

	table.walk(pets, function(v, k)
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end)
	self:rankNow()
end

function ExpPetEventView:rankNow()
	if FormationController.instance:checkCanSort(self._curViewDatas) then
		local names, opt = BagModel.instance:GetSortParms()

		names[1] = function(data)
			local res = 0

			if data ~= nil then
				if ExpeditionFmtModel.instance:getFormation():HasPet(data.petId) then
					res = 1
				end
			end

			return res
		end

		table.insert(names, 2, function(pet)
			local petStateData = ExpeditionModel.instance:getPetState(pet.petId)

			return (petStateData or nil) and petStateData.hpRate > 0
		end)
		table.insert(opt, 2, ArraySort.DESCENDING)
		ArraySort.sortOn(self._curViewDatas, names, opt)
	end

	self._tableview:ReloadData()
end

function ExpPetEventView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	local viewPos = uiCamera:ScreenToViewportPoint(pos)

	if viewPos.x < 0.5 and viewPos.y < 0.5 then
		pos.x = pos.x - 100
		pos.y = pos.y + 40
	end

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function ExpPetEventView:_onClickPet(data)
	self._selectedReplacePetId = data.petId

	self._tableview:ReloadData()
end

function ExpPetEventView:_initPets()
	self._selectPetIds = self._gridData.eventInfo.em
	self._selectIndex = nil
end

function ExpPetEventView:_updatePetsList()
	local petIds = self._selectPetIds

	self:_updatePets(petIds)
	self._tableview:ReloadData()
	self._petNums.gameObject:SetActive(self._isSweep)

	if self._isSweep then
		self._petNums.text = string.format("扫荡后精灵选择数量（%d/%d）", self._currDataIndex, #self._selectDatas)
	end
end

function ExpPetEventView:_updatePets(petIds)
	self._selectIndex = nil
	self._selectedReplacePetId = nil

	local petNum = #petIds
	local transform = self._petsNode.transform
	local childCount = transform.childCount

	while childCount < petNum do
		local go = goutil.cloneAndSetParent(transform:GetChild(0).gameObject, transform)

		Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)

		childCount = childCount + 1
	end

	for i = 1, petNum do
		local raceId = petIds[i]
		local petCO = CharacterConfig.instance:getPetCo(raceId)
		local petInfoCo = CharacterConfig.instance:getPetInfoCo(raceId)
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(true)

		local txtName = goutil.findChildTextComponent(go, "txtName")
		local desc = goutil.findChildTextComponent(go, "desc")

		desc.text = petInfoCo.stragegy
		txtName.text = petCO.name

		local btn = Framework.ButtonAdapter.Get(go)

		btn:AddClickListener(function()
			self:_onClickSelectCard(i, go)
		end)

		local bigBg = Framework.ImageBigBG.GetFrom(go, "mask/con")
		local rareCon = goutil.findChild(go, "con")
		local attrIcon = goutil.findChildComponent(go, "attrbg/Img_attr", ComponentType.UIImageSpriteChange)
		local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCO.faceIds))

		bigBg:SetImage(GameUrl.getPetImgUrl(modelCo.cardName))
		MaterialMgr.resetAll(rareCon)
		MaterialMgr.setCell(MatType.Rare, raceId, rareCon)

		if attrIcon then
			local race = PetSkinConfig.instance:getFisrtEleAttrIdx(checknumber(petCO.faceIds))

			race = math.fmod(race, 10)

			local targetValue = race - 1

			attrIcon:SetState(targetValue)
		end
	end

	for i = petNum + 1, childCount do
		local go = transform.transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	self._petsNode:Layout()
end

function ExpPetEventView:_onClickSelectCard(i, go)
	self:_playSelectEffect(go)

	self._selectIndex = i
end

function ExpPetEventView:_playSelectEffect(go)
	self:_stopSelectEffect()

	local eff = UIEffectManager.instance:playEffectBrief(self, "fx_ui_yuanzheng/fx_ui_yuanzheng_xuanka.prefab", go.transform, true)

	eff:setParent(go.transform)
	eff:setLocalPos(0, 0, 0)
	eff:setScale(1)
	eff:setSortingOrder(220)

	self._selectEff = eff
end

function ExpPetEventView:_stopSelectEffect()
	if self._selectEff then
		UIEffectManager.instance:stopEffect(self._selectEff)

		self._selectEff = nil
	end
end

function ExpPetEventView:_onClickClose()
	if self._isSweep then
		return
	end

	self:close()
end

function ExpPetEventView:_onClickArrow()
	local isShow = not self._isShowBottom

	self:_setBottomShow(isShow)
end

function ExpPetEventView:_onDragPetsView(eventData)
	local posx, posy = Framework.TransformUtil.GetAnchoredPos(self._bottomBgRectTrans, nil, nil)

	posy = posy + eventData.delta.y
	posy = math.max(math.min(posy, 0), -137)

	Framework.TransformUtil.SetAnchoredPos(self._bottomBgRectTrans, posx, posy)

	posx, posy = Framework.TransformUtil.GetAnchoredPos(self._Nego_RightRectTrans, nil, nil)
	posy = posy + eventData.delta.y
	posy = math.max(math.min(posy + eventData.delta.y, 0), -146)

	Framework.TransformUtil.SetAnchoredPos(self._Nego_RightRectTrans, posx, posy + eventData.delta.y)

	self._endDragState = eventData.delta.y > 0

	if posy <= -146 then
		self:_setBottomShow(false)
	elseif posy >= 0 then
		self:_setBottomShow(true)
	else
		self._bottomText:SetActive(false)
	end
end

function ExpPetEventView:_onEndDragPetsView()
	self:_setBottomShow(self._endDragState or false)
end

function ExpPetEventView:_onClickSelect()
	if not self._selectIndex then
		FloatWordMgr.instance:show("请选择精灵")

		return
	end

	local selectedId = self._selectPetIds[self._selectIndex]
	local replacePetId = self._selectedReplacePetId
	local gridData = self._gridData
	local evtParams = ExpeditionExtension_pb.PM_ExpeditionEventParam()

	evtParams.selectedId = selectedId
	evtParams.replacedId = replacePetId or 0

	if not self._isSweep then
		self:close()
		ExpeditionAgent.instance:sendPM_ExpeditionDoGridEventReq(gridData.eventIndex, evtParams)

		return
	end

	ExpeditionAgent.instance:sendPM_ExpeditionDoSweepEventReq(gridData.eventIndex, evtParams)
end

function ExpPetEventView:_onSweepSelEventBack(newGridData)
	local currDataIndex = self._currDataIndex + 1

	if currDataIndex <= #self._selectDatas then
		self:_updateEventByIndex(currDataIndex)
	else
		self:close()
		ExpeditionController.instance:checkSweepEvents()
	end
end

return ExpPetEventView
