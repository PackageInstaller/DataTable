-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunlunchallenge/view/KunLunChallengeExtremeView.lua

module("logic.extensions.kunlunchallenge.view.KunLunChallengeExtremeView", package.seeall)

local KunLunChallengeExtremeView = class("KunLunChallengeExtremeView", ViewComponent)
local ViewOpState = {}

ViewOpState.Normal = 1
ViewOpState.Shop = 2

local SaoGuangEffPaths = {}

SaoGuangEffPaths[1] = "20230929/kunluntiaozhan/fx_ui_kunluntiaozhan_saoguangzuo"
SaoGuangEffPaths[2] = "20230929/kunluntiaozhan/fx_ui_kunluntiaozhan_saoguang"
SaoGuangEffPaths[3] = "20230929/kunluntiaozhan/fx_ui_kunluntiaozhan_saoguangyou"

local SortNames = {}

SortNames.One = 1
SortNames.Two = 2

function KunLunChallengeExtremeView:buildUI()
	KunLunChallengeExtremeView.super.buildUI(self)

	self._uiView1 = goutil.findChild(self.mainGO, "uiView1")
	self._uiView2 = goutil.findChild(self.mainGO, "uiView2")
	self._btnClose = goutil.findChild(self._uiView2, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self._uiView2, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self._uiView2, "leftTop/txtTitle")
	self._con = goutil.findChild(self._uiView1, "con")
	self._btnDiscard = goutil.findChild(self._uiView1, "btnDiscard")
	self._btnDiscard_btn = goutil.findChild(self._uiView1, "btnDiscard/btn")
	self._btnAuto = goutil.findChild(self._uiView1, "btnAuto")
	self._btnAuto_btn = goutil.findChild(self._uiView1, "btnAuto/btn")
	self._btnClg = goutil.findChild(self._uiView1, "btnClg")
	self._btnClg_btn = goutil.findChild(self._uiView1, "btnClg/btn")
	self._bagCardColRtView = goutil.findChild(self._uiView1, "bagCardColRtView")
	self._bagCardColTriggerPlane = goutil.findChild(self._uiView1, "bagCardColTriggerPlane")
	self._handCardColRtView = goutil.findChild(self._uiView2, "handCardColRtView")
	self._handCardColTriggerPlane = goutil.findChild(self._uiView2, "handCardColTriggerPlane")
	self._bagCardCol = goutil.findChild(self.mainGO, "bagCardCol")
	self._bagCardCol_imgCenter = goutil.findChild(self.mainGO, "bagCardCol/imgCenter")
	self._bagCardCol_centerGo = goutil.findChild(self.mainGO, "bagCardCol/centerGo")
	self._bagCardCol_bagCardView = goutil.findChild(self.mainGO, "bagCardCol/bagCardView")
	self._bagCardCol_bagCardCell = goutil.findChild(self.mainGO, "bagCardCol/bagCardCell")

	GameUtil.SetActive(self._bagCardCol_bagCardCell, false)

	self._handCardCol = goutil.findChild(self.mainGO, "handCardCol")
	self._handCardCol_handCardView = goutil.findChild(self.mainGO, "handCardCol/handCardView")
	self._handCardCol_handCardCell = goutil.findChild(self.mainGO, "handCardCol/handCardCell")

	GameUtil.SetActive(self._handCardCol_handCardCell, false)

	local stageScrollerview = goutil.findChild(self._uiView1, "stageCol/stageScrollerview")
	local stageScrollercell = goutil.findChild(self._uiView1, "stageCol/stageScrollercell")

	self._stageScrollList = ScrollerList.create(stageScrollerview, stageScrollercell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._shopCardCol = goutil.findChild(self._uiView2, "shopCardCol")
	self._shopCardCol_imgMask = goutil.findChild(self._uiView2, "shopCardCol/imgMask")

	local shopCardScrollerview = goutil.findChild(self._uiView2, "shopCardCol/shopCardScrollerview")
	local shopCardScrollercell = goutil.findChild(self._uiView2, "shopCardCol/shopCardScrollercell")

	self._shopCardScrollList = ScrollerList.create(shopCardScrollerview, shopCardScrollercell, GameUtil.handler(self._updateShopCardCell, self), GameUtil.handler(self._clearShopCardCell, self))
	self._bagCardEffParent = goutil.findChild(self._uiView1, "bagCardEffParent")
	self._handCardEffView = goutil.findChild(self._uiView2, "handCardEffView")
	self._discardEffView = goutil.findChild(self._uiView2, "discardEffView")
	self._handCardEffGoList = GameUtil.getChildren(self._handCardEffView)
	self._discardEffGoList = GameUtil.getChildren(self._discardEffView)
end

function KunLunChallengeExtremeView:bindEvents()
	KunLunChallengeExtremeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnDiscard_btn, self._onClickBtnDiscard, self)
	GameUtil.addClickHandler(self._btnAuto_btn, self._onClickBtnAuto, self)
	GameUtil.addClickHandler(self._btnClg_btn, self._onClickBtnClg, self)
	GameUtil.addClickHandler(self._shopCardCol_imgMask, self._onClickShopCardColImgMask, self)
end

function KunLunChallengeExtremeView:unbindEvents()
	KunLunChallengeExtremeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnDiscard_btn)
	GameUtil.rmClickHandler(self._btnAuto_btn)
	GameUtil.rmClickHandler(self._btnClg_btn)
	GameUtil.rmClickHandler(self._shopCardCol_imgMask)
end

function KunLunChallengeExtremeView:onEnter()
	KunLunChallengeExtremeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = KunLunChallengeController.instance:getActivityType()

	local isInTime = KunLunChallengeController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._klActData = KunLunChallengeConfig.instance:getKlActData(self._activityId)
	self._extClgMo = KunLunChallengeController.instance:getKunLunExtClgMo(self._activityId)
	self._viewOpState = ViewOpState.Normal
	self._rotationListComp = self._rotationListComp or RotationListComp.New()
	self._pathMo = self._pathMo or RotEllipticPathMo.New()

	self._pathMo:onLoad(300, 400, 3)

	local contentGo, centerGo = self._bagCardCol, self._bagCardCol_centerGo
	local rtView, triggerPlane = self._bagCardColRtView, self._bagCardColTriggerPlane

	self._rotationListComp:onEnter(contentGo, centerGo, rtView, triggerPlane)

	self._handCardColPhotoRaycastComp = PhotoRaycastComp.New()

	self._handCardColPhotoRaycastComp:onEnter(self._handCardColRtView, self._handCardColTriggerPlane)
	self._handCardColPhotoRaycastComp:showTarget(self._handCardCol, true)
	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.KunLunExtremeClgInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.KunLunExtremeClgSetCardRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.KunLunExtremeClgResetStageRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.NotifyKunLunExtremeClgFightEndRes, self._onUpdate, self)
	KunLunChallengeController.instance:sendPM_KunLunExtremeClgInfoReq(self._activityId)
end

function KunLunChallengeExtremeView:onExit()
	KunLunChallengeExtremeView.super.onExit(self)
	self:_clearAllDiscardEffAnim()
	self:_unLoadAllEff()
	self._rotationListComp:onExit()
	self._handCardColPhotoRaycastComp:onExit()

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self:_onClear()
end

function KunLunChallengeExtremeView:_onSetUI()
	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	self:_loadBagCardEff()
end

function KunLunChallengeExtremeView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function KunLunChallengeExtremeView:_onUpdateData()
	self._extClgMoTemp = self._extClgMo:deepcopy()
	self._stageIdList = {}

	local stageDataList = KunLunChallengeConfig.instance:getKlExtStageDataList(self._activityId)

	for index, data in ipairs(stageDataList) do
		local stageId = data.stageId

		table.insert(self._stageIdList, stageId)
	end

	local jumpStageId = checknumber(self._curSelectStageId)

	if self._curSelectStageId == nil then
		jumpStageId = self._extClgMo:getJumpStageId()

		if self._extClgMoTemp:isPassStage(jumpStageId) then
			for _, stageId in ipairs(self._stageIdList) do
				if not self._extClgMoTemp:isPassStage(stageId) then
					jumpStageId = stageId

					break
				end
			end
		end
	end

	self._curSelectStageId = Mathf.Clamp(jumpStageId, 1, #self._stageIdList)
end

function KunLunChallengeExtremeView:_onUpdateUI()
	self:_onUpdateStageColUI()
	self:_onUpdateHandCardColUI()
	self:_onUpdateBagCardColUI()
	self:_onUpdateShopCardColUI()
end

function KunLunChallengeExtremeView:_onClear()
	self:_onClearStageCol()
	self:_onClearHandCardCol()
	self:_onClearBagCardCol()
	self:_onClearShopCardCol()
end

function KunLunChallengeExtremeView:_getSkinId()
	return KunLunChallengeController.instance:getSkinId(self._activityId)
end

function KunLunChallengeExtremeView:_trySendReqSaveCardOfCurStage()
	local isNeedSendReq = false
	local oldCardIdList = self._extClgMo:getCardIdListOfStage(self._curSelectStageId)
	local newCardIdList = self._extClgMoTemp:getCardIdListOfStage(self._curSelectStageId)
	local isSame = true

	for i = 1, self._extClgMoTemp:getTotalNumOfCardInStage() do
		local oldCardId = oldCardIdList[i]
		local newCardId = newCardIdList[i]

		if checknumber(oldCardId) ~= checknumber(newCardId) then
			isSame = false

			break
		end
	end

	isNeedSendReq = not isSame

	if not isSame then
		KunLunChallengeController.instance:sendPM_KunLunExtremeClgSetCardReq(self._activityId, self._curSelectStageId, newCardIdList)
	end

	return isNeedSendReq
end

function KunLunChallengeExtremeView:_onUpdateStageColUI()
	self._stageScrollList:reloadData(self._stageIdList)

	local toIndex = 0

	for index, stageId in ipairs(self._stageIdList) do
		if self._curSelectStageId == stageId then
			toIndex = index - 1

			break
		end
	end

	local isMotion = true

	self._stageScrollList:MoveCellToCenter(toIndex, isMotion)
end

function KunLunChallengeExtremeView:_onClearStageCol()
	self._stageScrollList:dispose()
end

function KunLunChallengeExtremeView:_updateStageCell(view, cell, stageId, tag)
	local isPass = self._extClgMoTemp:isPassStage(stageId)
	local isSelected = self._curSelectStageId == stageId
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtStageId = goutil.findChildTextComponent(mainGo, "txtStageId")
	local imgPass = goutil.findChild(mainGo, "imgPass")

	txtStageId.text = stageId

	GameUtil.SetActive(imgPass, isPass)
	GameUtil.setUIGroupIdx(mainGo, isSelected and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickStageCell, self, stageId))
end

function KunLunChallengeExtremeView:_clearStageCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function KunLunChallengeExtremeView:_onClickStageCell(stageId)
	self._curSelectStageId = stageId

	self._extClgMo:clearJumpStageId()
	self:_onUpdateUI()
end

function KunLunChallengeExtremeView:_onUpdateShopCardColUI()
	GameUtil.SetActive(self._shopCardCol, self._viewOpState == ViewOpState.Shop)

	if self._viewOpState ~= ViewOpState.Shop then
		return
	end

	if self._curSelectGroupId <= 0 then
		return
	end

	local extCardCfg = KunLunChallengeConfig.instance:getKlExtCardCfg(self._activityId, self._curSelectGroupId)

	self._shopCardScrollList:reloadData(extCardCfg)
end

function KunLunChallengeExtremeView:_onClearShopCardCol()
	self._shopCardScrollList:dispose()
end

function KunLunChallengeExtremeView:_updateShopCardCell(view, cell, data, tag)
	local cardId = data.cardId
	local groupId = self._extClgMoTemp:getGroupIdOfCardBelong(cardId)
	local useStageId = self._extClgMoTemp:getUseStageId(cardId)
	local isHasUse = self._extClgMoTemp:isHasUseOfCard(cardId)
	local isSelected = self._extClgMoTemp:isHasUseOfCardInStage(self._curSelectStageId, cardId)
	local mainGo = cell.gameObject
	local buff_icon = goutil.findChild(mainGo, "buff/icon")
	local txtGroup = goutil.findChildTextComponent(mainGo, "txtGroup")
	local buffDesc = goutil.findChild(mainGo, "buffDesc")
	local buffDesc_txt = goutil.findChildTextComponent(mainGo, "buffDesc/txt")
	local imgUse = goutil.findChild(mainGo, "imgUse")
	local imgUse_txt = goutil.findChildTextComponent(mainGo, "imgUse/txt")
	local path

	self:_loadBigBg(buff_icon, (not string.nilorempty(data.iconPath) or nil) and string.format("ui/icon/%s", data.iconPath))

	buffDesc_txt.text = data.desc

	GameUtil.SetActive(buffDesc, true)

	if isSelected then
		GameUtil.setUIGroupIdx(mainGo, 1)
		GameUtil.SetActive(imgUse, false)
	else
		GameUtil.setUIGroupIdx(mainGo, 0)
		GameUtil.SetActive(imgUse, isHasUse)

		imgUse_txt.text = string.format("第%s关已使用", useStageId)
	end

	txtGroup.text = groupId

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickShopCardCell, self, data.cardId))
end

function KunLunChallengeExtremeView:_clearShopCardCell(cell)
	local mainGo = cell.gameObject
	local buff_icon = goutil.findChild(mainGo, "buff/icon")

	self:_unLoadBigBg(buff_icon)
	GameUtil.rmClickHandler(mainGo)
end

function KunLunChallengeExtremeView:_onClickShopCardCell(cardId)
	local stageId = self._curSelectStageId
	local curCardIdList = self._extClgMoTemp:getCardIdListOfStage(stageId)

	if self._extClgMoTemp:isPassStage(stageId) then
		FloatWordMgr.instance:show("本关卡已锁定")

		return
	end

	local index = table.indexof(curCardIdList, cardId)

	if index == false then
		if not self._extClgMoTemp:isHasUseOfCard(cardId) then
			local seatIndex = self._extClgMoTemp:getSameGroupCardIndex(stageId, cardId)

			if seatIndex > 0 then
				local addIndex = self._extClgMoTemp:addCardToStage(stageId, cardId, seatIndex)

				self:_loadHandCardEff(addIndex)
			else
				local leftNum = self._extClgMoTemp:getLeftNumOfCardInStage(stageId)

				if leftNum > 0 then
					local addIndex = self._extClgMoTemp:addCardToStage(stageId, cardId)

					self:_loadHandCardEff(addIndex)
				else
					FloatWordMgr.instance:show("没有可填入的槽位")
				end
			end
		end
	else
		self._extClgMoTemp:addCardToStage(stageId, 0, index)
	end

	self:_onUpdateUI()
end

function KunLunChallengeExtremeView:_onUpdateHandCardColUI()
	local parentTran = self._handCardCol_handCardView.transform
	local childGo = self._handCardCol_handCardCell
	local childCount = self._extClgMoTemp:getTotalNumOfCardInStage()
	local children = GameUtil.getChildren(parentTran)

	for index, mainGo in ipairs(children) do
		GameUtil.SetActive(mainGo, index <= childCount)
	end

	local cardIdList = self._extClgMoTemp:getCardIdListOfStage(self._curSelectStageId)

	for index = 1, childCount do
		local mainGo = children[index]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, index))
		end

		GameUtil.SetActive(mainGo, true)
		self:_updateHandCardCell(mainGo, checknumber(cardIdList[index]), index)
	end
end

function KunLunChallengeExtremeView:_onClearHandCardCol()
	local children = GameUtil.getChildren(self._handCardCol_handCardView.transform)

	for index, mainGo in ipairs(children) do
		self:_clearHandCardCell(mainGo)
	end
end

function KunLunChallengeExtremeView:_updateHandCardCell(mainGo, cardId, index)
	local groupId = self._extClgMoTemp:getGroupIdOfCardBelong(cardId)
	local isPass = self._extClgMoTemp:isPassStage(self._curSelectStageId)
	local isSelected = self._curSelectGroupId == groupId
	local buff_icon = goutil.findChild(mainGo, "buff/icon")
	local txtGroup = goutil.findChildTextComponent(mainGo, "txtGroup")
	local imgReduce = goutil.findChild(mainGo, "imgReduce")
	local buffDesc = goutil.findChild(mainGo, "buffDesc")
	local buffDesc_txt = goutil.findChildTextComponent(mainGo, "buffDesc/txt")
	local isNilCard = checknumber(cardId) == 0

	if isNilCard then
		self:_unLoadBigBg(buff_icon)
		GameUtil.SetActive(buffDesc, false)
		GameUtil.SetActive(imgReduce, false)
		GameUtil.SetActive(txtGroup.gameObject, false)
	else
		local cardData = KunLunChallengeConfig.instance:getKlExtCardDataById(self._activityId, cardId)
		local path

		self:_loadBigBg(buff_icon, (not string.nilorempty(cardData.iconPath) or nil) and string.format("ui/icon/%s", cardData.iconPath))

		buffDesc_txt.text = cardData.desc

		GameUtil.SetActive(buffDesc, true)
		GameUtil.SetActive(imgReduce, not isPass)

		txtGroup.text = groupId

		GameUtil.SetActive(txtGroup.gameObject, true)
	end

	if self._viewOpState == ViewOpState.Normal then
		GameUtil.setUIGroupIdx(mainGo, 0)
	elseif self._viewOpState == ViewOpState.Shop then
		GameUtil.setUIGroupIdx(mainGo, isSelected and 1 or 0)
	end

	self._handCardColPhotoRaycastComp:addPointerClickHandler(mainGo, GameUtil.handler(self._onClickHandCardCell, self, cardId, index))
	self._handCardColPhotoRaycastComp:addPointerClickHandler(imgReduce, GameUtil.handler(self._onClickHandCardCellImgReduce, self, cardId, index))
end

function KunLunChallengeExtremeView:_clearHandCardCell(mainGo)
	local buff_icon = goutil.findChild(mainGo, "buff/icon")
	local imgReduce = goutil.findChild(mainGo, "imgReduce")

	self:_unLoadBigBg(buff_icon)
	self._handCardColPhotoRaycastComp:rmPointerClickHandler(mainGo)
	self._handCardColPhotoRaycastComp:rmPointerClickHandler(imgReduce)
end

function KunLunChallengeExtremeView:_onClickHandCardCell(cardId, index)
	local isPass = self._extClgMoTemp:isPassStage(self._curSelectStageId)

	if not isPass and cardId > 0 then
		self._curSelectGroupId = self._extClgMoTemp:getGroupIdOfCardBelong(cardId)
		self._viewOpState = ViewOpState.Shop

		self:_onUpdateUI()
	end
end

function KunLunChallengeExtremeView:_onClickHandCardCellImgReduce(cardId, index)
	local stageId = self._curSelectStageId
	local isPass = self._extClgMoTemp:isPassStage(stageId)

	if not isPass and cardId > 0 then
		self._extClgMoTemp:addCardToStage(stageId, 0, index)

		if self._viewOpState ~= ViewOpState.Shop then
			self:_loadDiscardEff(index)
		end
	end

	local isNeedSendReq = self:_trySendReqSaveCardOfCurStage()

	if not isNeedSendReq then
		self:_onUpdateUI()
	end
end

function KunLunChallengeExtremeView:_onUpdateBagCardColUI()
	local parentTran = self._bagCardCol_bagCardView.transform
	local childGo = self._bagCardCol_bagCardCell
	local cardGroupDataList = KunLunChallengeConfig.instance:getKlExtCardGroupDataList(self._activityId)
	local childCount = #cardGroupDataList
	local children = GameUtil.getChildren(parentTran)
	local oldShowGoNum = 0
	local newShowGoNum = 0

	for index, mainGo in ipairs(children) do
		if GameUtil.GetActive(mainGo) then
			oldShowGoNum = oldShowGoNum + 1
		end

		GameUtil.SetActive(mainGo, index <= childCount)
	end

	for index, cardGroupData in ipairs(cardGroupDataList) do
		local mainGo = children[index]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, index))
		end

		GameUtil.SetActive(mainGo, true)

		newShowGoNum = newShowGoNum + 1

		self:_updateBagCardCell(mainGo, cardGroupData.groupId)
	end

	local isNeedLoad = oldShowGoNum ~= newShowGoNum or not self._rotationListComp:isLoaded()

	if isNeedLoad then
		local objList = {}

		for idx = 0, parentTran.childCount - 1 do
			local obj = parentTran:GetChild(idx).gameObject

			table.insert(objList, obj)
		end

		local objCount = #objList
		local stepCount = self._pathMo:getPointCount()
		local stepList = {}

		for i = 1, objCount do
			stepList[i] = checkint(stepCount / objCount * (i - 1))
		end

		local stepDelta = 1

		self._rotationListComp:onLoad(objList, self._pathMo, stepList, stepDelta)
	end
end

function KunLunChallengeExtremeView:_onClearBagCardCol()
	local parentTran = self._bagCardCol_bagCardView.transform
	local children = GameUtil.getChildren(parentTran)

	for index, mainGo in ipairs(children) do
		self:_clearBagCardCell(mainGo)
	end
end

function KunLunChallengeExtremeView:_updateBagCardCell(mainGo, groupId)
	local cardGroupData = KunLunChallengeConfig.instance:getKlExtCardGroupData(self._activityId, groupId)
	local leftNumOfCardInGroup = self._extClgMoTemp:getLeftNumOfCardInGroup(groupId)
	local buff_icon = goutil.findChild(mainGo, "buff/icon")
	local txtGroup = goutil.findChildTextComponent(mainGo, "txtGroup")
	local txtTips_txt = goutil.findChildTextComponent(mainGo, "txtTips/txt")

	txtGroup.text = groupId
	txtTips_txt.text = leftNumOfCardInGroup

	local path

	self:_loadBigBg(buff_icon, (not string.nilorempty(cardGroupData.iconPath) or nil) and string.format("ui/icon/%s", cardGroupData.iconPath))
	self._rotationListComp:addPointerClickHandler(mainGo, GameUtil.handler(self._onClickBagCardCell, self, groupId))
end

function KunLunChallengeExtremeView:_clearBagCardCell(mainGo)
	local buff_icon = goutil.findChild(mainGo, "buff/icon")

	self:_unLoadBigBg(buff_icon)
	self._rotationListComp:rmPointerClickHandler(mainGo)
end

function KunLunChallengeExtremeView:_onClickBagCardCell(groupId)
	if self._curSelectGroupId == groupId then
		return
	end

	self._curSelectGroupId = groupId
	self._viewOpState = ViewOpState.Shop

	self:_onUpdateUI()
end

function KunLunChallengeExtremeView:_loadCardIcon(bgGo, iconName)
	local cardData = KunLunChallengeConfig.instance:getKlExtCardDataById(self._activityId, cardId)
	local path

	self:_loadBigBg(bgGo, (cardData or nil) and string.format("ui/icon/%s", cardData.iconPath))
end

function KunLunChallengeExtremeView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function KunLunChallengeExtremeView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function KunLunChallengeExtremeView:_loadBagCardEff()
	local effKey = self:_getBagCardEffKey()

	self:_loadEff(effKey, self._bagCardEffParent, "20230929/kunluntiaozhan/fx_ui_kunluntiaozhan_guang", true, SortNames.One)
end

function KunLunChallengeExtremeView:_getBagCardEffKey()
	return "bagCardEff"
end

function KunLunChallengeExtremeView:_loadHandCardEff(idx)
	local go = self._handCardEffGoList[idx]
	local path = SaoGuangEffPaths[idx]

	if not goutil.isNil(go) then
		local effKey = self:_getHandCardEffKey(idx)

		self:_loadEff(effKey, go, path, false, SortNames.Two)
	end
end

function KunLunChallengeExtremeView:_getHandCardEffKey(idx)
	return string.format("handCardEff_%s", idx)
end

function KunLunChallengeExtremeView:_loadDiscardEff(idx)
	local go = self._discardEffGoList[idx]

	if not goutil.isNil(go) then
		local effKey = self:_getDiscardEffKey(idx)

		local function loadCallBack(handlerTarget, eff)
			eff:setPos(Framework.TransformUtil.GetPos(go.transform, 0, 0, 0))

			local formPos = GameUtil.getPos(go)
			local toPos = GameUtil.getPos(self._bagCardEffParent)
			local key = self:_getDiscardEffAnimKey(idx)

			local function completeFunc()
				self:_loadGuiWeiEff(idx, toPos)
			end

			self:_playDiscardEffAnim(formPos, toPos, eff.effGo, key, completeFunc)
		end

		self:_loadEff(effKey, go, "20230929/kunluntiaozhan/fx_ui_kunluntiaozhan_tuowei", false, SortNames.Two, loadCallBack)
	end
end

function KunLunChallengeExtremeView:_getDiscardEffKey(idx)
	return string.format("discardEff_%s", idx)
end

function KunLunChallengeExtremeView:_loadGuiWeiEff(idx, pos)
	local effKey = self:_getGuiWeiEffKey(idx)
	local go = self._discardEffGoList[idx]

	local function loadCallBack(handlerTarget, eff)
		eff:setPos(pos.x, pos.y, pos.z)
	end

	self:_loadEff(effKey, go, "20230929/kunluntiaozhan/fx_ui_kunluntiaozhan_guiwei", false, SortNames.Two, loadCallBack)
end

function KunLunChallengeExtremeView:_getGuiWeiEffKey(idx)
	return string.format("guiWeiEff_%s", idx)
end

function KunLunChallengeExtremeView:_loadEff(key, effParent, pathName, isLoop, sortName, loadCallBack)
	if isLoop == nil then
		isLoop = true
	end

	if self._effPool == nil then
		self._effPool = {}
	end

	self:_unLoadEff(key)

	if not goutil.isNil(effParent) and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true

			if sortName ~= nil then
				self:_setGoSortingOrder(eff.effGo.gameObject, sortName)
			end

			GameUtil.callBack(loadCallBack, handlerTarget, eff)
		end

		local handlerTarget

		self._effPool[key] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, isLoop, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function KunLunChallengeExtremeView:_unLoadEff(key)
	if self._effPool then
		UIEffectManager.instance:stopEffect(self._effPool[key])
	end
end

function KunLunChallengeExtremeView:_unLoadAllEff()
	if self._effPool then
		for k, v in pairs(self._effPool) do
			self:_unLoadEff(k)
		end
	end
end

function KunLunChallengeExtremeView:_getDiscardEffAnimKey(idx)
	return string.format("discardEffAnim_%s", idx)
end

function KunLunChallengeExtremeView:_playDiscardEffAnim(formPos, toPos, mainGo, key, finishCallBack)
	local function completeFunc()
		self:_clearDiscardEffAnim(key)
		GameUtil.callBack(finishCallBack)
	end

	GameUtil.setPos(mainGo, formPos.x, formPos.y, formPos.z)

	if self._discardEffTweenerPool == nil then
		self._discardEffTweenerPool = {}
	end

	local tweener = mainGo.transform:DOMove(toPos, 0.3)

	tweener:SetEase(DG.Tweening.Ease.OutSine)
	tweener:OnComplete(completeFunc)

	self._discardEffTweenerPool[key] = tweener
end

function KunLunChallengeExtremeView:_clearDiscardEffAnim(key)
	if self._discardEffTweenerPool then
		self._discardEffTweenerPool[key]:Kill(false)

		self._discardEffTweenerPool[key] = nil
	end
end

function KunLunChallengeExtremeView:_clearAllDiscardEffAnim()
	if self._discardEffTweenerPool then
		for key, v in pairs(self._discardEffTweenerPool) do
			self:_clearDiscardEffAnim(key)
		end
	end
end

function KunLunChallengeExtremeView:_setGoSortingOrder(mainGo, sortName)
	GoUtil.SetSortingOrder(mainGo, sortName == SortNames.One and self._uiView1:GetComponent("Canvas").sortingOrder or sortName == SortNames.Two and self._uiView2:GetComponent("Canvas").sortingOrder or UGUIToolHelper.GetNodeCanvansSortingOrder(mainGo))
end

function KunLunChallengeExtremeView:_onClickBtnTip()
	local key = KunLunChallengeConfig.instance:getClientCommonValue(self._activityId, "KUNLUNCHALLENGE_RULE_EXTREME_KEY", false)

	TipsFacade.instance:openRulesView(key)
end

function KunLunChallengeExtremeView:_onClickBtnDiscard()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local result, tips = self._extClgMo:getTryDiscardCardResultAndTips(self._curSelectStageId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local isPass = self._extClgMoTemp:isPassStage(self._curSelectStageId)

	if isPass then
		local title = "提示"
		local text = "挑战成功的关卡是否确认进行弃牌操作，弃牌后该关卡状态重置"
		local okFuncText = "确定"
		local cancelFuncText = "取消"
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		local function okFunc()
			for idx, cardId in ipairs(self._extClgMoTemp:getCardIdListOfStage(self._curSelectStageId)) do
				if cardId > 0 then
					self:_loadDiscardEff(idx)
				end
			end

			KunLunChallengeController.instance:sendPM_KunLunExtremeClgResetStageReq(self._activityId, self._curSelectStageId)
		end

		local function cencelFunc()
			return
		end

		TipsFacade.instance:openPopupWindow(title, text, okFunc, cencelFunc, okFuncText, cancelFuncText, alignment)
	else
		for idx, cardId in ipairs(self._extClgMoTemp:getCardIdListOfStage(self._curSelectStageId)) do
			if cardId > 0 then
				self:_loadDiscardEff(idx)
			end
		end

		local totalNum = self._extClgMoTemp:getTotalNumOfCardInStage()
		local list = {}

		for i = 1, totalNum do
			table.insert(list, 0)
		end

		KunLunChallengeController.instance:sendPM_KunLunExtremeClgSetCardReq(self._activityId, self._curSelectStageId, list)
	end
end

function KunLunChallengeExtremeView:_onClickBtnAuto()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local stageId = self._curSelectStageId
	local result, tips = self._extClgMo:getTryAutoCardResultAndTips(stageId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local autoFullCardIdList = self._extClgMoTemp:getAutoFullCardIdList(stageId)
	local oldCardIdList = self._extClgMoTemp:getCardIdListOfStage(stageId)
	local addIndexs = {}

	for index, oldCardId in ipairs(oldCardIdList) do
		local newCardId = autoFullCardIdList[index]

		if oldCardId ~= newCardId then
			table.insert(addIndexs, index)
		end
	end

	if #addIndexs > 0 then
		KunLunChallengeController.instance:sendPM_KunLunExtremeClgSetCardReq(self._activityId, stageId, autoFullCardIdList)

		for _, index in ipairs(addIndexs) do
			self:_loadHandCardEff(index)
		end
	else
		FloatWordMgr.instance:show("没有符合条件的卡牌 请手动选择")
	end
end

function KunLunChallengeExtremeView:_onClickBtnClg()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local stageId = self._curSelectStageId
	local result, tips = self._extClgMo:getTryEnterExtFmtResultAndTips(stageId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	self._extClgMo:setJumpStageId(stageId)
	KunLunChallengeController.instance:enterBattleOfExtClg(self._activityId, stageId)
end

function KunLunChallengeExtremeView:_onClickShopCardColImgMask()
	self._viewOpState = ViewOpState.Normal
	self._curSelectGroupId = 0

	local isNeedSendReq = self:_trySendReqSaveCardOfCurStage()

	if not isNeedSendReq then
		self:_onUpdateUI()
	end
end

return KunLunChallengeExtremeView
