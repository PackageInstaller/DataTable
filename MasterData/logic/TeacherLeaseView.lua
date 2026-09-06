-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/lease/TeacherLeaseView.lua

module("logic.extensions.tutorsystem.view.lease.TeacherLeaseView", package.seeall)

local TeacherLeaseView = class("TeacherLeaseView", ViewComponent)

function TeacherLeaseView:ctor()
	TeacherLeaseView.super.ctor(self)
end

function TeacherLeaseView:buildUI()
	TeacherLeaseView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtTipGo = goutil.findChild(self.mainGO, "txtTip")

	local petScrView = goutil.findChild(self.mainGO, "petScrView")
	local petScrCell = goutil.findChild(self.mainGO, "petScrCell")

	self._petScrollList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._petScrollList:setCenterMode(true)

	local tabScrView = goutil.findChild(self.mainGO, "tabCol/scrView")
	local tabScrCell = goutil.findChild(self.mainGO, "tabCol/scrCell")

	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._tabEmptyGo = goutil.findChild(self.mainGO, "tabCol/emptyGo")
	self._rewardCol = goutil.findChild(self.mainGO, "rewardCol")
	self._rewardIcon = goutil.findChild(self.mainGO, "rewardCol/rewardGo/icon")
	self._bubble = goutil.findChild(self.mainGO, "rewardCol/bubble")
	self._rewardGo = goutil.findChild(self.mainGO, "rewardCol/rewardGo")
	self._effParent = goutil.findChild(self.mainGO, "rewardCol/rewardGo/effParent")
	self._icon = goutil.findChild(self.mainGO, "rewardCol/rewardGo/icon")
	self._btnBubbleTips = goutil.findChild(self.mainGO, "btnBubbleTips")
	self._bubbleGo = goutil.findChild(self.mainGO, "btnBubbleTips/bubbleGo")
	self._customInput = UICustomInput.Get(self._btnBubbleTips)

	GameUtil.SetActive(self._bubble, false)
end

function TeacherLeaseView:bindEvents()
	TeacherLeaseView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBubbleTips, function()
		GameUtil.SetActive(self._bubbleGo, not GameUtil.GetActive(self._bubbleGo))
	end, self)
	self._customInput:AddListener(function()
		GameUtil.SetActive(self._bubbleGo, false)
	end, self)
end

function TeacherLeaseView:unbindEvents()
	TeacherLeaseView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBubbleTips)
	self._customInput:RemoveListener()
end

function TeacherLeaseView:destroyUI()
	TeacherLeaseView.super.destroyUI(self)
end

function TeacherLeaseView:onEnter()
	TeacherLeaseView.super.onEnter(self)
	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.TutorMainInfoRes, self._initData, self)
	self.addGEvent(self, GlobalNotify.TutorTeacherPetHireInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.TutorGainTeacherHirePetPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.TutorTeacherSetHirePetRes, self._onSendTeacherPetHireInfoReq, self)
	self:_initData()
end

function TeacherLeaseView:onExit()
	TeacherLeaseView.super.onExit(self)
	self._tabScrollList:dispose()
	self:_clearPetCells()
	self:_clearRewardCol()
	MaterialMgr.resetAll(self._rewardIcon)
end

function TeacherLeaseView:_initData()
	self._tabInfoList = TutorSystemModel.instance:getStuInfoListAsTea() or {}
	self._tabIdx = Mathf.Min(1, #self._tabInfoList)

	self:_onSendTeacherPetHireInfoReq()
end

function TeacherLeaseView:_onSendTeacherPetHireInfoReq()
	local studentUserId = self:_getCurStudentUserId()

	if not string.nilorempty(studentUserId) then
		TutorSystemController.instance:sendTutorTeacherPetHireInfoReq(studentUserId)
	end
end

function TeacherLeaseView:_onSetUI()
	local matStr = TutorSystemConfig.instance:getTeacherSetHirePetPrize()
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

	MaterialMgr.setIcon(self._rewardIcon, matType, matId, nil, nil)
end

function TeacherLeaseView:_onUpdate()
	local list = {}
	local stuMaxCount = TutorSystemConfig.instance:getTsTeachStudentLimit()

	for i = 1, stuMaxCount do
		local info = self._tabInfoList[i]

		if info then
			table.insert(list, info)
		end
	end

	self._tabScrollList:reloadData(list)
	GameUtil.SetActive(self._tabEmptyGo, #list == 0)
	self:_onUpdatePetCol()
	self:_onUpdateRewardCol()
end

function TeacherLeaseView:_getCurStudentUserId()
	local info = self._tabInfoList[self._tabIdx]

	if info then
		return info.headInfo.headInfo.userId
	end
end

function TeacherLeaseView:_updateTabCell(view, cell, info, tag)
	local tabIdx = cell.index + 1
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")
	local tag = goutil.findChild(mainGo, "tag")
	local imgGou = goutil.findChild(mainGo, "tag/imgGou")
	local imgSelect = goutil.findChild(mainGo, "imgSelect")
	local redpoint = goutil.findChild(mainGo, "redpoint")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	GameUtil.SetActive(imgGou, tabIdx == self._tabIdx)
	GameUtil.SetActive(imgSelect, tabIdx == self._tabIdx)

	local isNeedRed = false
	local petCount = TutorSystemConfig.instance:getTsTeacherHirePetMax()

	for slotId = 1, petCount do
		local isHasPushPet = TutorSystemModel.instance:isHaveHirePetInSlotInTeaLease(info.headInfo.headInfo.userId, slotId)

		if not isHasPushPet then
			isNeedRed = true

			break
		end
	end

	GameUtil.SetActive(redpoint, isNeedRed)
	HeadItemController.instance:setHeadCellByInfo(headRoot, info.headInfo.headInfo, true)

	txtName.text = info.headInfo.headInfo.userName

	GameUtil.addClickHandler(btnSelect, function()
		self._tabIdx = tabIdx

		self:_onSendTeacherPetHireInfoReq()
	end)
end

function TeacherLeaseView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local headRoot = goutil.findChild(mainGo, "headRoot")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")

	HeadItemController.instance:resetHeadCell(headRoot)
	GameUtil.rmClickHandler(btnSelect)
end

function TeacherLeaseView:_onUpdatePetCol()
	local list = {}
	local petCount = TutorSystemConfig.instance:getTsTeacherHirePetMax()

	for slotId = 1, petCount do
		table.insert(list, slotId)
	end

	self._petScrollList:reloadData(list)
end

function TeacherLeaseView:_clearPetCells()
	self._petScrollList:dispose()
end

function TeacherLeaseView:_updatePetCell(view, cell, slotId, tag)
	local studentUserId = self:_getCurStudentUserId()
	local isHasPushPet = false
	local isHasLeaseTheSlot = false
	local hirePetInfo = false

	if studentUserId then
		isHasPushPet = TutorSystemModel.instance:isHaveHirePetInSlotInTeaLease(studentUserId, slotId)
		isHasLeaseTheSlot = TutorSystemModel.instance:isHasLeaseTheSlotByStuInTeaLease(studentUserId, slotId)
		hirePetInfo = TutorSystemModel.instance:getHirePetInfoInTeaLease(studentUserId, slotId)
	end

	local mainGo = cell.gameObject
	local petInfo = goutil.findChild(mainGo, "petInfo")
	local empty = goutil.findChild(mainGo, "empty")
	local iconIma = goutil.findChild(mainGo, "petInfo/mask/iconIma")
	local tag = goutil.findChild(mainGo, "petInfo/tag")
	local txtLevel = goutil.findChildTextComponent(mainGo, "petInfo/txtLevel")
	local nameTxt = goutil.findChildTextComponent(mainGo, "petInfo/nameTxt")
	local txtPower = goutil.findChildTextComponent(mainGo, "petInfo/power/txtPower")

	GameUtil.SetActive(petInfo, isHasPushPet)
	GameUtil.SetActive(empty, not isHasPushPet)
	GameUtil.SetActive(tag, isHasLeaseTheSlot)

	if isHasPushPet then
		local petView = hirePetInfo.petView
		local raceId = checknumber(petView.raceId)
		local skinId = checknumber(petView.curFaceId)

		if skinId == 0 then
			skinId = raceId
		end

		local attrIdx = PetSkinConfig.instance:getFisrtEleAttrIdx(raceId)

		attrIdx = attrIdx % 10 - 1

		GameUtil.setUIGroupIdx(petInfo, attrIdx)

		local modelCo = CharacterConfig.instance:getModelCo(skinId)

		uGuiUtil.setSpriteToImage(iconIma, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

		txtLevel.text = string.format("等级：%d", petView.curLv)
		txtPower.text = hirePetInfo.zdl
		nameTxt.text = CharacterConfig.instance:getPetName(raceId)
	else
		uGuiUtil.clearImage(iconIma)
	end

	GameUtil.addClickHandler(mainGo, function()
		if studentUserId == nil then
			return
		end

		if TutorSystemModel.instance:isHasLeaseTheSlotByStuInTeaLease(studentUserId, slotId) then
			FloatWordMgr.instance:show("该精灵被学生租用中")

			return
		end

		local petView = TutorSystemModel.instance:getHirePetViewInSlotInTeaLease(studentUserId, slotId)

		if petView == nil then
			return
		end

		UIStateManager.instance:push(ViewName.LeasePetSelectView, studentUserId, slotId)
	end)
	GameUtil.addClickHandler(empty, function()
		if studentUserId == nil then
			return
		end

		UIStateManager.instance:push(ViewName.LeasePetSelectView, studentUserId, slotId)
	end)
end

function TeacherLeaseView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local iconIma = goutil.findChild(mainGo, "petInfo/mask/iconIma")
	local empty = goutil.findChild(mainGo, "empty")

	uGuiUtil.clearImage(iconIma)
	GameUtil.rmClickHandler(mainGo)
	GameUtil.rmClickHandler(empty)
end

function TeacherLeaseView:_onUpdateRewardCol()
	self:_updateRewardGo()
end

function TeacherLeaseView:_clearRewardCol()
	UIEffectManager.instance:stopEffect(self._rewardEff)

	self._rewardEff = nil

	removetimer(self._hideBubble, self)
	GameUtil.rmClickHandler(self._rewardGo)
end

function TeacherLeaseView:_updateRewardGo()
	local studentUserId = self:_getCurStudentUserId()
	local isCanGet = false
	local isHasGain = false

	if studentUserId then
		isCanGet = TutorSystemController.instance:isCanGetPrizeInTeacherLease(studentUserId)
		isHasGain = TutorSystemController.instance:isHasGainPrizeInTeacherLease(studentUserId)
	end

	if isCanGet then
		local effParent = self._effParent
		local pathName = "fx_ui_fuli/fx_ui_fuli_lingqu"

		UIEffectManager.instance:stopEffect(self._rewardEff)

		if effParent and not string.nilorempty(pathName) then
			local path = pathName .. ".prefab"

			local function finishHandler(handlerTarget, eff)
				return
			end

			local function loadedHandler(handlerTarget, eff)
				eff:setClipping(effParent:GetComponent(goutil.Type_RectTransform))
				eff:setParent(effParent.transform)
				eff:setLocalPos(0, 0, 0)
				eff:setScale(1, 1, 1)

				eff.hideEffWhileNotOnTop = true
			end

			self._rewardEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, nil)
		end
	else
		UIEffectManager.instance:stopEffect(self._rewardEff)

		self._rewardEff = nil
	end

	GameUtil.SetActive(self._rewardCol, not isHasGain)
	GameUtil.SetActive(self._txtTipGo, not isHasGain)
	GameUtil.addClickHandler(self._rewardGo, function()
		if isCanGet then
			TutorSystemController.instance:sendTutorGainTeacherHirePetPrizeReq(studentUserId)
		else
			self:_showBubble()
		end
	end)
end

function TeacherLeaseView:_showBubble()
	GameUtil.SetActive(self._bubble, true)
	removetimer(self._hideBubble, self)
	settimer(2, self._hideBubble, self, false)
end

function TeacherLeaseView:_hideBubble()
	GameUtil.SetActive(self._bubble, false)
end

return TeacherLeaseView
