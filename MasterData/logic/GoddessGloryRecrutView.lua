-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddessGloryRecrutView.lua

module("logic.extensions.goddessglory.view.GoddessGloryRecrutView", package.seeall)

local GoddessGloryRecrutView = class("GoddessGloryRecrutView", FormationRightView)

function GoddessGloryRecrutView:ctor()
	GoddessGloryRecrutView.super.ctor(self)

	self._disableDrag = true
end

function GoddessGloryRecrutView:buildUI()
	GoddessGloryRecrutView.super.buildUI(self)

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

	local bgCanvas = self:getGo("Canvas")

	GameUtil.expandRectTransform(bgCanvas.transform)
end

function GoddessGloryRecrutView:bindEvents()
	self:_bindUIEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._bgMaskButton:AddClickListener(self._onClickClose, self)
	self._btnSelect:AddClickListener(self._onClickSelect, self)
	self._btnArrow:AddClickListener(self._onClickArrow, self)
	self._dragArrow:AddDragListener(self._onDragPetsView, self)
	self._dragArrow:AddEndDragListener(self._onEndDragPetsView, self)
end

function GoddessGloryRecrutView:unbindEvents()
	self:_unbindUIEvents()
	self._btnSelect:RemoveClickListener()
	self._btnArrow:RemoveClickListener()
	self._closeButton:RemoveClickListener()
	self._bgMaskButton:RemoveClickListener()
	self._dragArrow:RemoveDragListener()
	self._dragArrow:RemoveEndDragListener()
end

function GoddessGloryRecrutView:onEnter()
	GoddessGloryRecrutView.super.onEnter(self)

	self._events = self._viewPresentor._openParam[1]
	self._selectPetIds = self._events.petIds

	self:_updateEvent()
end

function GoddessGloryRecrutView:onExit()
	self._endDragState = nil
	self._events = nil

	self:_stopSelectEffect()
	self._tableview:Travel(function(cell)
		ItemPet.Remove(cell.gameObject)
	end, nil)
	GoddessGloryRecrutView.super.onExit(self)
end

function GoddessGloryRecrutView:onExitFinished()
	GoddessGloryRecrutView.super.onExitFinished(self)

	self._selectPetIds = nil
	self._curViewDatas = nil
	self._selectData = nil
	self._selectIndex = nil

	local nodeCnt = self._petsNode.transform.childCount

	for i = 1, nodeCnt do
		local go = self._petsNode.transform:GetChild(i - 1).gameObject
		local btn = Framework.ButtonAdapter.Get(go)
		local icon = Framework.ImageBigBG.GetFrom(go, "mask/con")
		local rareCon = goutil.findChild(go, "con")
		local costIcon = goutil.findChild(go, "txtCost/icon")

		MaterialMgr.resetAll(costIcon)
		icon:ClearImage()
		btn:RemoveClickListener()
		MaterialMgr.resetAll(rareCon)
	end
end

function GoddessGloryRecrutView:_updateEvent()
	self:_initBottomShow()
	self:_updatePetsList()
end

function GoddessGloryRecrutView:_initBottomShow()
	self._isShowBottom = false
	self._bottomBgRectTrans.anchoredPosition = Vector2.New(0, -137)
	self._Nego_RightRectTrans.anchoredPosition = Vector2.New(265.8, -146)
	self._btnArrow.transform.eulerAngles = Vector3.New(0, 0, 180)

	self._txtBottomGo:SetActive(true)
	self:_playBottomArrowAnim(true)
end

function GoddessGloryRecrutView:_setBottomShow(isShowList)
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

function GoddessGloryRecrutView:_playBottomArrowAnim(isPlay)
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

function GoddessGloryRecrutView:_updateCell(view, cell, data)
	data.isDead = false

	local component = ItemPet.AddOnce(cell.gameObject)

	self:updateForbit(data)
	component:Init(data)
	component:setSelected(false)

	local challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()
	local stageId = GoddessGloryModel.instance:getCurStageId()
	local inTeamId = GoddessGloryFmtModel.instance:getPetIdInTeamByRaceId(challengeId, stageId, data.raceId)

	component:SetInTeam(inTeamId == data.petId)

	local imgSelected = goutil.findChild(cell, "ImgC_Selected")

	imgSelected:SetActive(self._selectedReplacePetId == data.petId)

	local childCnt = cell.transform.childCount - 1

	imgSelected.transform:SetSiblingIndex(childCnt)
end

function GoddessGloryRecrutView:updateForbit(data)
	return
end

function GoddessGloryRecrutView:_RefreshPetList()
	local challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()
	local stageId = GoddessGloryModel.instance:getCurStageId()

	self._curViewDatas = {}

	local pets = GoddessGloryPetsModel.instance:getAllPets(challengeId, stageId)

	table.walk(pets, function(v, k)
		if self:onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end)
	self:rankNow()
end

function GoddessGloryRecrutView:_getPosAndSizeDelta(go)
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

function GoddessGloryRecrutView:_onClickPet(data)
	self._selectedReplacePetId = data.petId

	self._tableview:ReloadData()
end

function GoddessGloryRecrutView:_updatePetsList()
	self:_updatePets()
	self._tableview:ReloadData()
end

function GoddessGloryRecrutView:_updatePets()
	local petIds = self._selectPetIds
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
		local supportCo = GoddessGloryConfig.instance:getSupportPetCo(petIds[i])
		local raceId = supportCo.raceId
		local petCO = CharacterConfig.instance:getPetCo(raceId)
		local go = transform:GetChild(i - 1).gameObject
		local evtCo = GoddessGloryConfig.instance:getEventCo(self._events.eventId)

		go:SetActive(true)

		local txtName = goutil.findChildTextComponent(go, "txtName")

		txtName.text = petCO.name

		local btn = Framework.ButtonAdapter.Get(go)

		btn:AddClickListener(function()
			self:_onClickSelectCard(i, go)
		end)

		local bigBg = Framework.ImageBigBG.GetFrom(go, "mask/con")
		local rareCon = goutil.findChild(go, "con")
		local attrIcon = goutil.findChildComponent(go, "attrbg/Img_attr", ComponentType.UIImageSpriteChange)
		local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCO.faceIds))
		local txtCost = goutil.findChildTextComponent(go, "txtCost")
		local costIcon = goutil.findChild(go, "txtCost/icon")

		txtCost.text = tostring(evtCo.cost)

		MaterialMgr.resetAll(costIcon)
		MaterialMgr.setIcon(costIcon, MatType.Item_Fake, GoddessGloryModel.instance:getEnergyItemId())
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

function GoddessGloryRecrutView:_onClickSelectCard(i, go)
	self:_playSelectEffect(go)

	self._selectIndex = i
end

function GoddessGloryRecrutView:_playSelectEffect(go)
	self:_stopSelectEffect()

	local eff = UIEffectManager.instance:playEffectBrief(self, "fx_ui_yuanzheng/fx_ui_yuanzheng_xuanka.prefab", go.transform, true)

	eff:setParent(go.transform)
	eff:setLocalPos(0, 0, 0)
	eff:setScale(1)
	eff:setSortingOrder(220)

	self._selectEff = eff
end

function GoddessGloryRecrutView:_stopSelectEffect()
	if self._selectEff then
		UIEffectManager.instance:stopEffect(self._selectEff)

		self._selectEff = nil
	end
end

function GoddessGloryRecrutView:_onClickClose()
	self:close()
end

function GoddessGloryRecrutView:_onClickArrow()
	local isShow = not self._isShowBottom

	self:_setBottomShow(isShow)
end

function GoddessGloryRecrutView:_onDragPetsView(eventData)
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

function GoddessGloryRecrutView:_onEndDragPetsView()
	self:_setBottomShow(self._endDragState or false)
end

function GoddessGloryRecrutView:_onClickSelect()
	if not self._selectIndex then
		FloatWordMgr.instance:show("请选择精灵")

		return
	end

	local evtCo = GoddessGloryConfig.instance:getEventCo(self._events.eventId)
	local challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()
	local stageId = GoddessGloryModel.instance:getCurStageId()
	local stageMO = GoddessGloryModel.instance:getGoddessGloryStage(challengeId, stageId)

	if stageMO == nil then
		FloatWordMgr.instance:show("请稍候[-37189]")

		return
	end

	if stageMO:getEnergy() < evtCo.cost then
		FloatWordMgr.instance:show("当前能量不足")

		return
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), string.format("是否消耗%s能量招募该精灵？", evtCo.cost), function()
		local selectId = self._selectPetIds[self._selectIndex]
		local eventId = self._events.instanceId

		self:close()
		GoddessGloryController.instance:requestGoddessGloryDoEvent(challengeId, stageId, eventId, selectId)
	end, function()
		return
	end, "确定", "取消")
end

return GoddessGloryRecrutView
