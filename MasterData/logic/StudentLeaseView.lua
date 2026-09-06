-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tutorsystem/view/lease/StudentLeaseView.lua

module("logic.extensions.tutorsystem.view.lease.StudentLeaseView", package.seeall)

local StudentLeaseView = class("StudentLeaseView", ViewComponent)

function StudentLeaseView:ctor()
	StudentLeaseView.super.ctor(self)
end

function StudentLeaseView:buildUI()
	StudentLeaseView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "txtCount")
	self._petCol = goutil.findChild(self.mainGO, "petCol")
	self._petView = goutil.findChild(self.mainGO, "petCol/petView")
	self._petCell = goutil.findChild(self.mainGO, "petCol/petCell")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "tips/Viewport/Content/txtDesc")

	GameUtil.SetActive(self._petCell, false)
end

function StudentLeaseView:bindEvents()
	StudentLeaseView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function StudentLeaseView:unbindEvents()
	StudentLeaseView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function StudentLeaseView:destroyUI()
	StudentLeaseView.super.destroyUI(self)
end

function StudentLeaseView:onEnter()
	StudentLeaseView.super.onEnter(self)

	self._myUserId = RoleModel.instance:getUserId()
	self._petCount = TutorSystemConfig.instance:getTsTeacherHirePetMax()

	self:_onSetUI()
	self:_onUpdate()
	GlobalDispatcher:addListener(GlobalNotify.TutorStudentPetHireInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.TutorStudentHirePetRes, self._sendInfoReq, self)
	self:_sendInfoReq()
end

function StudentLeaseView:onExit()
	StudentLeaseView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorStudentPetHireInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.TutorStudentHirePetRes, self._sendInfoReq, self)
	self:_clearPetCells()
end

function StudentLeaseView:_sendInfoReq()
	TutorSystemController.instance:sendTutorStudentPetHireInfoReq()
end

function StudentLeaseView:_onSetUI()
	return
end

function StudentLeaseView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function StudentLeaseView:_onUpdateData()
	self:_onUpdatePetColData()
end

function StudentLeaseView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdatePetCol()
end

function StudentLeaseView:_onUpdatePlaneUI()
	local isHasHire = TutorSystemModel.instance:isHasHirePetInStuLease()
	local desc = ""

	if isHasHire then
		local hirePetInfo = TutorSystemModel.instance:getCurHirePetInfoInStuLease()
		local hirePetView = hirePetInfo.petView
		local hirePetCo = CharacterConfig.instance:getPetCo(hirePetView.raceId)
		local hirePetName = hirePetCo.name

		desc = desc .. "  " .. string.format("当前租借精灵：%s", hirePetName)

		local leftTimes = TutorSystemModel.instance:getCurHirePetLeftTimesInStuLease()

		desc = desc .. "  " .. string.format("剩余参战次数：%s", leftTimes)
	end

	local totalCanHireTimes = TutorSystemConfig.instance:getStudentTotalCanHireTimes()
	local totalHasHireTimes = TutorSystemModel.instance:getTotalHireTimesInStuLease()

	desc = desc .. "  " .. string.format("总租借次数：%s/%s", totalHasHireTimes, totalCanHireTimes)
	self._txtDesc.text = desc
end

function StudentLeaseView:_onUpdatePetColData()
	return
end

function StudentLeaseView:_onUpdatePetCol()
	local childList = GameUtil.getChildren(self._petView)

	for idx, go in ipairs(childList) do
		if idx > self._petCount then
			GameUtil.SetActive(go, false)
		end
	end

	for slotId = 1, self._petCount do
		if not childList[slotId] then
			local go = goutil.cloneAndSetParent(self._petCell, self._petView.transform)

			go.name = string.format("petCell_%d", slotId)

			self:_updatePetCell(go, slotId)
			GameUtil.SetActive(go, true)
		end
	end
end

function StudentLeaseView:_updatePetCell(go, slotId)
	local mainGo = go.gameObject
	local petInfo = goutil.findChild(mainGo, "petInfo")
	local empty = goutil.findChild(mainGo, "empty")
	local selectGo = goutil.findChild(mainGo, "petInfo/selectGo")
	local iconIma = goutil.findChild(mainGo, "petInfo/mask/iconIma")
	local tag = goutil.findChild(mainGo, "petInfo/tag")
	local txtTag = goutil.findChildTextComponent(mainGo, "petInfo/tag/txt")
	local txtWarCountGo = goutil.findChild(mainGo, "petInfo/txtWarCount")
	local maskLock = goutil.findChild(mainGo, "petInfo/maskLock")
	local txtWarCount = goutil.findChildTextComponent(mainGo, "petInfo/txtWarCount/txt")
	local txtLevel = goutil.findChildTextComponent(mainGo, "petInfo/txtLevel")
	local nameTxt = goutil.findChildTextComponent(mainGo, "petInfo/nameTxt")
	local txtPower = goutil.findChildTextComponent(mainGo, "petInfo/power/txtPower")
	local btnUp = goutil.findChild(mainGo, "btnUp")
	local isHasPushPet = TutorSystemModel.instance:isHasPushPetToSlotInStuLease(slotId)
	local isHiringPet = TutorSystemModel.instance:isHiringThePetInSlotInStuLease(slotId)
	local isExceedThisPetTimes = TutorSystemController.instance:isExceedThisPetLeaseTimesInStuLease(slotId)

	GameUtil.SetActive(petInfo, isHasPushPet)
	GameUtil.SetActive(empty, not isHasPushPet)
	GameUtil.SetActive(txtWarCountGo, isHiringPet)

	if isHiringPet then
		txtTag.text = "正在租借"
	elseif isExceedThisPetTimes and not isHiringPet then
		txtTag.text = "已达上限"
	end

	GameUtil.SetActive(tag, isHiringPet or isExceedThisPetTimes)
	GameUtil.SetActive(maskLock, isExceedThisPetTimes and not isHiringPet)

	local result = self:getTryUpPetClgResultAndTips(false, slotId)

	GameUtil.SetActive(btnUp, result == GameEnum.ResultCode.Success)

	if isHasPushPet then
		local petView = TutorSystemModel.instance:getHirePetViewInStuLease(slotId)

		if checknumber(petView.curFaceId) > 0 then
			if not petView.curFaceId then
				local skinId = petView.raceId
				local petName = PetSkinConfig.instance:getPetSkinName(skinId)
				local attrIdx = PetSkinConfig.instance:getFisrtEleAttrIdx(checknumber(skinId))

				attrIdx = attrIdx % 10 - 1

				GameUtil.setUIGroupIdx(petInfo, attrIdx)

				local modelCo = CharacterConfig.instance:getModelCo(petView.curFaceId)

				uGuiUtil.setSpriteToImage(iconIma, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

				txtLevel.text = string.format("等级：%d", petView.curLv)
				txtPower.text = TutorSystemModel.instance:getHirePetZdlInStuLease(slotId)

				local leftFightTimes = TutorSystemModel.instance:getCurHirePetLeftTimesInStuLease()

				txtWarCount.text = string.format("可参战：<color=#20b376>%d</color>", leftFightTimes)
				nameTxt.text = petName
			end
		end
	end

	GameUtil.addClickHandler(petInfo, GameUtil.handler(self._onClickPetCell, self, mainGo, slotId))
	GameUtil.addClickHandler(empty, function()
		FloatWordMgr.instance:show("老师还未添加相应的租借精灵")
	end)
	GameUtil.addClickHandler(btnUp, GameUtil.handler(self._onClickBtnUp, self, mainGo, slotId))
end

function StudentLeaseView:_clearPetCells()
	local childList = GameUtil.getChildren(self._petView)

	for idx, go in ipairs(childList) do
		local mainGo = go
		local empty = goutil.findChild(mainGo, "empty")
		local petInfo = goutil.findChild(mainGo, "petInfo")
		local iconIma = goutil.findChild(mainGo, "petInfo/mask/iconIma")

		uGuiUtil.clearImage(iconIma)
		GameUtil.rmClickHandler(petInfo)
		GameUtil.rmClickHandler(empty)
	end
end

function StudentLeaseView:_onClickPetCell(mainGo, slotId)
	local result = self:getTrySelectPetClgResultAndTips(true, slotId)

	if result == GameEnum.ResultCode.Success then
		self._selectSlotId = slotId

		self:_onUpdate()
	end
end

function StudentLeaseView:_onClickBtnUp(mainGo, slotId)
	local result = self:getTryUpPetClgResultAndTips(true, slotId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local function okFunc()
		TutorSystemController.instance:sendTutorStudentHirePetReq(slotId)
	end

	if TutorSystemController.instance:isExceedCanLeaseTimesInStuLease() then
		local text = "当前正在租借精灵，是否更换精灵"

		TipsFacade.instance:openPopupWindow("通知", text, okFunc, nil, "确定", "取消")
	else
		okFunc()
	end
end

function StudentLeaseView:getTrySelectPetClgResultAndTips(isNeedTips, slotId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if TutorSystemModel.instance:getHirePetViewInStuLease(slotId) == nil then
		result = GameEnum.ResultCode.Error
		tips = "老师还未在此放置精灵"
	elseif TutorSystemModel.instance:isHiringThePetInSlotInStuLease(slotId) then
		result = GameEnum.ResultCode.Error
		tips = "该精灵正在租借中，可前往布阵界面进行租借使用"
	elseif TutorSystemController.instance:isExceedTotalLeaseTimesInStuLease() then
		result = GameEnum.ResultCode.Error
		tips = "当前总租借次数已满"
	elseif TutorSystemController.instance:isExceedThisPetLeaseTimesInStuLease(slotId) then
		result = GameEnum.ResultCode.Error
		tips = "该精灵租借次数已满"
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function StudentLeaseView:getTryUpPetClgResultAndTips(isNeedTips, slotId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if TutorSystemController.instance:isExceedTotalLeaseTimesInStuLease() then
		result = GameEnum.ResultCode.Error
		tips = "当前总租借次数已满"
	elseif slotId == 0 then
		result = GameEnum.ResultCode.Error
		tips = "还未选择精灵"
	elseif not TutorSystemModel.instance:isHasPushPetToSlotInStuLease(slotId) then
		result = GameEnum.ResultCode.Error
		tips = "选择的精灵为空"
	elseif TutorSystemController.instance:isExceedThisPetLeaseTimesInStuLease(slotId) then
		result = GameEnum.ResultCode.Error
		tips = "该精灵租借次数已满"
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function StudentLeaseView:_handleChallengeRes()
	FloatWordMgr.instance:show("选择精灵成功")
	self:close()
end

function StudentLeaseView:_onClickBtnCancel()
	self:close()
end

return StudentLeaseView
