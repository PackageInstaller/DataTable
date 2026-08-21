-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterportrait/view/CharacterPotraitView.lua

module("logic.extensions.characterportrait.view.CharacterPotraitView", package.seeall)

local M = class("CharacterPotraitView", ViewComponent)
local HideUITime = 5
local maxPositionX = 600
local minPositionX = -600
local maxPositionY = 1200
local minPositionY = -1200
local maxScale = 5
local minScale = 0.3

function M:buildUI()
	self._bg1 = self:getBigBg("character_check_view_-1001539103")
	self._bg2 = self:getBigBg("character_check_view_-516945746")
	self._btnReturn1 = self:getBtn("1&title_view_-878360263")
	self._btnReturn2 = self:getBtn("2&title_view_-878360263")
	self._btnHome1 = self:getBtn("1&title_view_1398742689")
	self._btnHome2 = self:getBtn("2&title_view_1398742689")
	self._bgSelect1Btn = self:getBtn("character_check_view_-1220961735")
	self._switch1Btn = self:getBtn("character_check_view_-185371537")
	self._share1Btn = self:getBtn("character_check_view_-184123415")
	self._bgSelect2Btn = self:getBtn("character_check_view_-1712609691")
	self._switch2Btn = self:getBtn("character_check_view_-1070651482")
	self._share2Btn = self:getBtn("character_check_view_-1059795768")
	self._uiPanelGo = self:getGo("character_check_view_917347283")
	self._horizonPanelGo = self:getGo("character_check_view_-924321666")
	self._verticalPanelGo = self:getGo("character_check_view_-1193114693")
	self._spinePanel1Go = self:getGo("character_check_view_-153700760")
	self._spinePanel2Go = self:getGo("character_check_view_-794757549")
	self._spine1Go = self:getGo("character_check_view_-1234479454")
	self._spine2Go = self:getGo("character_check_view_-1176349859")
	self._spinePanelGo = self:getGo("character_check_view_-199427464")

	goutil.addComponentOnce(self._spine1Go, UIComponentType.RawImage)

	self._photo1Unit = PhotoUnit.Get(self._spine1Go)
	self._photo2Unit = PhotoUnit.Get(self._spine2Go)
	self._photo2CenterPointGo = self:getGo("character_check_view_587468526")
	self._photo1CenterPointGo = self:getGo("character_check_view_1988913347")

	self:_buildUItouch()
	self:_buildBgUI()
end

function M:bindEvents()
	self._btnReturn1:AddClickListener(self._onClickReturn, self)
	self._btnReturn2:AddClickListener(self._onClickReturn, self)
	self._btnHome1:AddClickListener(self._onClickHome, self)
	self._btnHome2:AddClickListener(self._onClickHome, self)
	self._bgSelect1Btn:AddClickListener(self._onClickSelectBgBtn, self)
	self._switch1Btn:AddClickListener(self._onClickSwitchToVertical, self)
	self._share1Btn:AddClickListener(self._onClickShareBtn, self)
	self._bgSelect2Btn:AddClickListener(self._onClickSelectBgBtn, self)
	self._switch2Btn:AddClickListener(self._onClickSwitchToHorizon, self)
	self._share2Btn:AddClickListener(self._onClickShareBtn, self)
	self._bgCloseBtn:AddClickListener(self._onClickCloseBgBtn, self)
end

function M:_bindEvents()
	self._clickListener = Astral.UIGlobalTouchTrigger.Get(self._spinePanelGo)

	self._clickListener:AddGlobalListener(self._onDoClick, self)
end

function M:_unbindEvents()
	self._clickListener:RemoveGlobalListener()
end

function M:_onDoClick()
	self:_resetHideUiTimer()
end

function M:unbindEvents()
	self._btnReturn1:RemoveClickListener()
	self._btnReturn2:RemoveClickListener()
	self._bgSelect1Btn:RemoveClickListener()
	self._switch1Btn:RemoveClickListener()
	self._share1Btn:RemoveClickListener()
	self._bgSelect2Btn:RemoveClickListener()
	self._switch2Btn:RemoveClickListener()
	self._share2Btn:RemoveClickListener()
	self._bgCloseBtn:RemoveClickListener()
end

function M:_onClickHome()
	self:close()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:onEnter()
	self._isMultiDrag = false
	self._singlePointerId = -999
	self._isHorizon = true
	self._isUiHide = false
	self._isBgSelectOpen = false

	local param = self:getFirstParam()

	self._heroData = param.hero
	self._skinId = param.skinid

	self:_onClickSwitchToHorizon()
	self:_initBgPanel()
	self:_refreshBackground(true)
	self:_bindEvents()
	self:_resetHideUiTimer()
end

function M:_resetHideUiTimer()
	removetimer(self._hideUI, self)
	settimer(HideUITime, self._hideUI, self, false)
end

function M:_hideUI()
	if self._isBgSelectOpen then
		return
	end

	removetimer(self._hideUI, self)
	goutil.setActive(self._uiPanelGo, false)

	self._isUiHide = true
end

function M:_showUI()
	self._isUiHide = false

	goutil.setActive(self._uiPanelGo, true)
end

function M:_refreshBackground(needRefreshImg)
	local bgCO = BackpackConfig.instance:getItemInfoByItemId(self._curSelectBgId)

	self._bgText.text = bgCO.name
	self._bgDescTxt.text = bgCO.desc
	self._bgGetWayTxt.text = bgCO.getway

	IconLoader.setSprite(self._bgIconImg, IconType.Background, bgCO.icon)

	if needRefreshImg then
		self._bg1:SetImage(string.format("ui/bigbg/charactersystem/background/%d_1.png", self._curUseBgId), nil, self)
		self._bg2:SetImage(string.format("ui/bigbg/charactersystem/background/%d_2.png", self._curUseBgId), nil, self)
	end
end

function M:onExit()
	self:_unbindEvents()
	removetimer(self._hideUI, self)
	self._photo1Unit:clear()
	self._photo2Unit:clear()
	self._bg1:ClearImage()
	self._bg2:ClearImage()
end

function M:_onClickSelectBgBtn()
	self._isBgSelectOpen = true

	if self._isHorizon then
		goutil.addChildToParent(self._bgPanelGo, self._bg1PanelGo)
	else
		goutil.addChildToParent(self._bgPanelGo, self._bg2PanelGo)
	end

	goutil.setActive(self._bgPanelGo, true)
end

function M:_onClickSwitchToHorizon()
	self._isHorizon = true

	goutil.setActive(self._horizonPanelGo, true)
	goutil.setActive(self._verticalPanelGo, false)
	goutil.setActive(self._spinePanel1Go, true)
	goutil.setActive(self._spinePanel2Go, false)
	goutil.setActive(self._bgPanelGo, false)
	goutil.setActive(self._bg1.gameObject, true)
	goutil.setActive(self._bg2.gameObject, false)

	self._isBgSelectOpen = false

	local transform = self._photo1CenterPointGo.transform
	local cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	local paramTable = {
		isShowEgg = true,
		isShowEnter = true,
		photo = self._photo1Unit,
		modelId = self._heroData:getModelId(),
		cutCenterPos = cutCenterPos,
		iconType = IconType.CharaterBust,
		heroId = self._heroData:getId(),
		skinId = self._skinId
	}

	SpineCutShowLoader.showSpineLihuiPhoto(paramTable)
	Astral.TransformUtil.SetLocalPos(self._spinePanelGo.transform, 0, 0, 0)
	Astral.TransformUtil.SetLocalScale(self._spinePanelGo.transform, 1, 1, 1)
end

function M:_onClickSwitchToVertical()
	self._isHorizon = false

	goutil.setActive(self._horizonPanelGo, false)
	goutil.setActive(self._verticalPanelGo, true)
	goutil.setActive(self._spinePanel1Go, false)
	goutil.setActive(self._spinePanel2Go, true)
	goutil.setActive(self._bgPanelGo, false)
	goutil.setActive(self._bg1.gameObject, false)
	goutil.setActive(self._bg2.gameObject, true)

	self._isBgSelectOpen = false

	local transform = self._photo2CenterPointGo.transform
	local cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	local paramTable = {
		isShowEgg = true,
		isShowEnter = true,
		photo = self._photo2Unit,
		modelId = self._heroData:getModelId(),
		cutCenterPos = cutCenterPos,
		iconType = IconType.CharaterBust,
		heroId = self._heroData:getId()
	}

	SpineCutShowLoader.showSpineLihuiPhoto(paramTable)
	Astral.TransformUtil.SetLocalPos(self._spinePanelGo.transform, 0, 0, 0)
	Astral.TransformUtil.SetLocalScale(self._spinePanelGo.transform, 1, 1, 1)
end

function M:_buildBgUI()
	self._bg1PanelGo = self:getGo("character_check_view_-1785683975")
	self._bg2PanelGo = self:getGo("character_check_view_-978033659")
	self._bgPanelGo = self:getGo("0&background_tips_-1137449664")
	self._bgCloseBtn = self:getBtn("0&background_tips_-1548373151")
	self._bgText = self:getText("0&background_tips_-1414765056")
	self._bgDescTxt = self:getText("0&background_tips_-592524545")
	self._bgGetWayTxt = self:getText("0&background_tips_-480163162")
	self._bgIconImg = self:getImage("0&background_tips_-247954070")
	self._bgScrollGo = self:getGo("0&background_tips_-497568020")
	self._bgScroll = Astral.ScrollRectLoop.Get(self._bgScrollGo)

	ScrollRectLoopExtension.InitData(self._bgScroll, self._onBgCellUpdate, self, nil, self)

	self._bgScroll.TotalCellNum = 0
end

function M:setLocalStorage(id)
	local playerId = PlayerModel.instance:getId()
	local key = "portraitBg" .. playerId

	Astral.LocalStorage.Instance:SetInt(key, id)
end

function M:getLocalStorage()
	local playerId = PlayerModel.instance:getId()
	local key = "portraitBg" .. playerId

	return Astral.LocalStorage.Instance:GetInt(key, 1601001)
end

function M:_initBgPanel()
	self._curUseBgId = self:getLocalStorage()
	self._curSelectBgId = self._curUseBgId

	local bgList = BackpackConfig.instance:getItemsInfoByTS(16, 1)

	self._itemList = {}

	for i, v in pairs(bgList) do
		local itemData = {}

		itemData.co = v
		itemData.hasGot = ItemModel.instance:getItemCountByItemId(v.id) > 0

		if v.id == 1601001 then
			itemData.hasGot = true
		end

		table.insert(self._itemList, itemData)
	end

	table.sort(self._itemList, function(item1, item2)
		if item1.hasGot == item2.hasGot then
			return item1.co.id < item2.co.id
		else
			return item1.hasGot
		end
	end)

	self._bgScroll.TotalCellNum = #self._itemList
end

function M:_onBgCellUpdate(cellRect, curIndex, prevIndex)
	curIndex = curIndex + 1

	local obj

	if cellRect.childCount == 0 then
		local path = ResName.Background_background_item
		local prefab = self._viewPresentor:getResInstance(path)

		obj = Astral.GameObjectUtil.CloneAndSetParent(prefab, cellRect.transform, nil)
	else
		obj = cellRect:GetChild(0).gameObject
	end

	local data = self._itemList[curIndex]
	local shower = Astral.LuaComponentContainer.Add(obj, HeroBackgroundCellComp)

	shower:setUseAndSelectFaceId(self._curUseBgId, self._curSelectBgId)
	shower:updateData(data, curIndex)
	shower:setClickCallBack(self._clickBgCallBack, self)
end

function M:_clickBgCallBack(index)
	local itemData = self._itemList[index]

	self._curSelectBgId = itemData.co.id

	local needRrefreshImg = false

	if itemData.hasGot then
		self:setLocalStorage(self._curSelectBgId)

		self._curUseBgId = self._curSelectBgId
		needRrefreshImg = true
	end

	self:_refreshBackground(needRrefreshImg)
	self._bgScroll:UpdateCells()
end

function M:_onClickCloseBgBtn()
	self._isBgSelectOpen = false

	goutil.setActive(self._bgPanelGo, false)
end

function M:_buildUItouch()
	self._touchGo = self:getGo("character_check_view_1147907000")
	self._raycastProxy = RaycastProxy.Get(self._touchGo)

	self._raycastProxy:SetClickListener(self._onRayCastHit, self)
	self._raycastProxy:SetBeginDragListener(self._onBeginDrag, self)
	self._raycastProxy:SetDragListener(self._onDrag, self)
	self._raycastProxy:SetEndDragListener(self._onEndDrag, self)

	self._compositeTouch = UICompositeTouch.Get(self._touchGo)

	local multiTouch = MultiTouchChecker.New()

	multiTouch:AddMultiDragListener(self._onMultiDragListener, self)
	self._compositeTouch:AddChecker(multiTouch)
end

function M:destroyUI()
	self._raycastProxy:RemoveClickListener()
	self._raycastProxy:RemoveBeginDragListener()
	self._raycastProxy:RemoveDragListener()
	self._raycastProxy:RemoveEndDragListener()

	self._raycastProxy = nil

	self._compositeTouch:ClearCheckerList()

	self._compositeTouch = nil
end

function M:_onRayCastHit()
	if self._isBgSelectOpen then
		self._isBgSelectOpen = false

		goutil.setActive(self._bgPanelGo, false)

		return
	end

	if self._isUiHide then
		self:_showUI()
	else
		self:_hideUI()
	end
end

function M:_onBeginDrag(x, y, pointerId)
	if self._singlePointerId > 0 then
		self._singlePointerId = -999

		return
	end

	self._singleDragingId = pointerId
	self._startDragGoX = self._spinePanelGo.transform.localPosition.x
	self._startDragGoY = self._spinePanelGo.transform.localPosition.y
	self._startDragScreenX = x
	self._startDragScreenY = y
end

function M:_onDrag(x, y, pointerId)
	if self._isMultiDrag then
		return
	end

	if self._singleDragingId ~= pointerId then
		return
	end

	printWarn("_onDrag", x, y)
	self:_resetHideUiTimer()

	local dx = x - self._startDragScreenX
	local dy = y - self._startDragScreenY
	local positionX = self._startDragGoX + dx
	local positionY = self._startDragGoY + dy

	positionX, positionY = self:_limitPostion(positionX, positionY)

	Astral.TransformUtil.SetLocalPos(self._spinePanelGo.transform, positionX, positionY, 0)
end

function M:_limitPostion(positionX, positionY)
	local scale = self._spinePanelGo.transform.localScale.x

	if scale < 1 then
		scale = 1
	end

	if self._isHorizon then
		positionX = positionX > maxPositionX * scale and maxPositionX * scale or positionX
		positionX = positionX < minPositionX * scale and minPositionX * scale or positionX
		positionY = positionY > maxPositionY * scale and maxPositionY * scale or positionY

		if positionY < minPositionY * scale then
			positionY = minPositionY * scale or positionY
		end
	else
		positionX = positionX > maxPositionY * scale and maxPositionY * scale or positionX
		positionX = positionX < minPositionY * scale and minPositionY * scale or positionX
		positionY = positionY > maxPositionX * scale and maxPositionX * scale or positionY
		positionY = positionY < minPositionX * scale and minPositionX * scale or positionY
	end

	return positionX, positionY
end

function M:_limitScale()
	if self._currentScale > maxScale then
		self._currentScale = maxScale
	elseif self._currentScale < minScale then
		self._currentScale = minScale
	end
end

function M:_onEndDrag(x, y, pointerId)
	self._startDragX = nil
	self._startDragY = nil

	if self._singleDragingId == pointerId then
		self._singleDragingId = -999
	end

	self._isMultiDrag = false
end

function M:_onMultiDragListener(centerX, centerY, scale, distance, isFirstMultiDrag)
	self._isMultiDrag = true

	self:_resetHideUiTimer()

	if isFirstMultiDrag then
		local position = goutil.screenToLocalPos(Vector2.New(centerX, centerY), self.mainGO.transform)

		printWarn("isFirstMultiDrag", centerX, centerY, 0, 0)

		local positionX = self._spinePanelGo.transform.localPosition.x - position.x
		local positionY = self._spinePanelGo.transform.localPosition.y - position.y

		positionX, positionY = self:_limitPostion(positionX, positionY)
		self._multiDragTargetX = positionX
		self._multiDragTargetY = positionY
		self._lastDistance = distance
		self._currentScale = self._spinePanelGo.transform.localScale.x
	end

	local dDistance = distance - self._lastDistance

	self._lastDistance = distance
	self._scaleChange = 1 + dDistance / 2000

	if self._scaleChange < 0.5 then
		self._scaleChange = 0.5
	end

	self._currentScale = self._currentScale * self._scaleChange

	self:_limitScale()
	Astral.TransformUtil.SetLocalScale(self._spinePanelGo.transform, self._currentScale, self._currentScale, 1)
	self:_slowMoveToCenterWhenMultiDrag()
end

function M:_slowMoveToCenterWhenMultiDrag()
	local positionX, positionY

	self._multiDragTargetX = self._multiDragTargetX * self._scaleChange
	self._multiDragTargetY = self._multiDragTargetY * self._scaleChange
	self._multiDragTargetX, self._multiDragTargetY = self:_limitPostion(self._multiDragTargetX, self._multiDragTargetY)

	local dx = self._multiDragTargetX - self._spinePanelGo.transform.localPosition.x * self._scaleChange
	local dy = self._multiDragTargetY - self._spinePanelGo.transform.localPosition.y * self._scaleChange

	printWarn("_slowMoveToCenterWhenMultiDrag", self._scaleChange, self._multiDragTargetX, self._multiDragTargetY, "====", dx, dy, "!!!!", self._spinePanelGo.transform.localPosition.x, self._spinePanelGo.transform.localPosition.y)

	if math.abs(dx) < 50 then
		positionX = self._multiDragTargetX
	elseif math.abs(dx) < 500 then
		if dx < 0 then
			positionX = self._spinePanelGo.transform.localPosition.x * self._scaleChange - 50
		else
			positionX = self._spinePanelGo.transform.localPosition.x * self._scaleChange + 50
		end
	else
		positionX = self._spinePanelGo.transform.localPosition.x * self._scaleChange + dx / 10
	end

	if math.abs(dy) < 50 then
		positionY = self._multiDragTargetY
	elseif math.abs(dy) < 500 then
		if dy < 0 then
			positionY = self._spinePanelGo.transform.localPosition.y * self._scaleChange - 50
		else
			positionY = self._spinePanelGo.transform.localPosition.y * self._scaleChange + 50
		end
	else
		positionY = self._spinePanelGo.transform.localPosition.y * self._scaleChange + dy / 10
	end

	positionX, positionY = self:_limitPostion(positionX, positionY)

	Astral.TransformUtil.SetLocalPos(self._spinePanelGo.transform, positionX, positionY, 0)
end

function M:_onClickReturn()
	self:back()
end

function M:_onClickShareBtn()
	return
end

return M
