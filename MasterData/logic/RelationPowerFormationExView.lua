-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/relationpower/view/RelationPowerFormationExView.lua

module("logic.extensions.relationpower.view.RelationPowerFormationExView", package.seeall)

local RelationPowerFormationExView = class("RelationPowerFormationExView", ViewComponent)

function RelationPowerFormationExView:ctor()
	RelationPowerFormationExView.super.ctor(self)
end

function RelationPowerFormationExView:buildUI()
	RelationPowerFormationExView.super.buildUI(self)

	self._petScrollercell = goutil.findChild(self.mainGO, "petCol/petScrollercell")
	self._petScrollerview = goutil.findChild(self.mainGO, "petCol/petScrollerview")
	self._petScrollList = ScrollerList.create(self._petScrollerview, self._petScrollercell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "descCol/txtTips")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "descCol/txtDesc")
	self._imgRecZdl = goutil.findChild(self.mainGO, "descCol/txtTips/imgRecZdl"):GetComponent(ComponentType.UIImgNumeralText)
end

function RelationPowerFormationExView:bindEvents()
	RelationPowerFormationExView.super.bindEvents(self)
end

function RelationPowerFormationExView:unbindEvents()
	RelationPowerFormationExView.super.unbindEvents(self)
end

function RelationPowerFormationExView:destroyUI()
	RelationPowerFormationExView.super.destroyUI(self)
end

function RelationPowerFormationExView:onEnter()
	RelationPowerFormationExView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._activityId = self._customFmtMo:getActivityId()
	self._formId = self._customFmtMo:getVerifyFormId()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.RelationPower, self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._verifyData = RelationPowerConfig.instance:getFormCfgByFormId(self._activityId, self._formId)

	self:_onSetUI()
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.RelationPowerFmtUpdateVerify, self._handleVerifyFmtUpdate, self)
	self.addGEvent(self, GlobalNotify.RelationPowerVerify, self._handleVerifyVerifyFormZdlRes, self)
	settimer(0.3, self._onTicking, self)
end

function RelationPowerFormationExView:onExit()
	RelationPowerFormationExView.super.onExit(self)
	removetimer(self._onTicking, self)
	self:_onClearPetCol()
end

function RelationPowerFormationExView:_sendVerifyReq()
	self._customFmtMo:fmtVerifyReq()
end

function RelationPowerFormationExView:_handleVerifyFmtUpdate()
	self._isNeedUpdateUI = true
	self._isNeedVerify = true
end

function RelationPowerFormationExView:_handleVerifyVerifyFormZdlRes()
	self._isNeedUpdateUI = true
end

function RelationPowerFormationExView:_onSetUI()
	return
end

function RelationPowerFormationExView:_onUpdate()
	self:_onUpdatePetColUI()
	self:_onUpdateDescColUI()
end

function RelationPowerFormationExView:_onTicking()
	if self._isNeedUpdateUI == true then
		self._isNeedUpdateUI = false

		self:_onUpdate()
	end

	if self._isNeedVerify == true then
		self._isNeedVerify = false

		self:_sendVerifyReq()
	end
end

function RelationPowerFormationExView:_onUpdatePetColUI()
	local petInfoList = {}

	for _, raceId in ipairs(self._verifyData.raceIds) do
		local info = {}

		info.raceId = raceId
		info.isExist = BagModel.instance:isExistRaceId(raceId)
		info.isUpFmt = self._customFmtMo:isUpFmt(raceId)

		table.insert(petInfoList, info)
	end

	self._petScrollList:reloadData(petInfoList)
end

function RelationPowerFormationExView:_onClearPetCol()
	self._petScrollList:dispose()
end

function RelationPowerFormationExView:_updatePetCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local raceId = info.raceId
	local isExist = info.isExist
	local isUpFmt = info.isUpFmt
	local descData = RelationPowerConfig.instance:getGotoCfgByRaceId(self._activityId, raceId)
	local imgPet = goutil.findChild(mainGo, "petIcon/img/pet")
	local btnUpZdl = goutil.findChild(mainGo, "btnUpZdl")
	local btnGoGet = goutil.findChild(mainGo, "btnGoGet")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtZdl = goutil.findChildTextComponent(mainGo, "txtZdl")
	local tagNotGet = goutil.findChild(mainGo, "tagNotGet")
	local tagNotUp = goutil.findChild(mainGo, "tagNotUp")
	local tagUp = goutil.findChild(mainGo, "tagUp")

	MaterialMgr.setIcon(imgPet, MatType.Pet, raceId, nil, nil)
	GameUtil.SetActive(tagNotGet, not isExist)
	GameUtil.SetActive(tagUp, isExist and isUpFmt)
	GameUtil.SetActive(tagNotUp, isExist and not isUpFmt)

	local petName
	local petData = CharacterConfig.instance:getPetCo(raceId)

	txtName.text = string.format("%s", (petData or nil) and petData.name)
	txtZdl.text = string.format("精灵战力：<color=#F82330FF>%s</color>", isExist and self._customFmtMo:getPetZdlInListByRaceId(raceId) or "0")

	local isNeedBtnGoGet = not isExist and not string.nilorempty(descData and descData.goGetKey)

	GameUtil.SetActive(btnGoGet, isNeedBtnGoGet)

	if isNeedBtnGoGet then
		GameUtil.addClickHandler(btnGoGet, GameUtil.handler(self._onClickPetGoGet, self, descData and descData.goGetKey))
	end

	local isNeedBtnUpZdl = isExist and not string.nilorempty(descData and descData.upZdlKey)

	GameUtil.SetActive(btnUpZdl, isNeedBtnUpZdl)

	if isNeedBtnUpZdl then
		GameUtil.addClickHandler(btnUpZdl, GameUtil.handler(self._onClickPetUpZdl, self, descData and descData.upZdlKey))
	end
end

function RelationPowerFormationExView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local imgPet = goutil.findChild(mainGo, "petIcon/img/pet")
	local btnUpZdl = goutil.findChild(mainGo, "btnUpZdl")
	local btnGoGet = goutil.findChild(mainGo, "btnGoGet")

	MaterialMgr.resetAll(imgPet)
	GameUtil.rmClickHandler(btnUpZdl)
	GameUtil.rmClickHandler(btnGoGet)
end

function RelationPowerFormationExView:_onClickPetUpZdl(jumpStr)
	if not string.nilorempty(jumpStr) then
		GotoMgr.gotoByString(jumpStr)
	end
end

function RelationPowerFormationExView:_onClickPetGoGet(jumpStr)
	if not string.nilorempty(jumpStr) then
		GotoMgr.gotoByString(jumpStr)
	end
end

function RelationPowerFormationExView:_onUpdateDescColUI()
	local fmtZdl = 0
	local overPercent = 0

	if not self._customFmtMo:isEmptyFmt() then
		fmtZdl = RelationPowerModel.instance:getCurVerifyFormZdl()
		overPercent = RelationPowerModel.instance:getCurVerifyFormOverPercent()
	end

	self._imgRecZdl:SetNum(fmtZdl)

	self._txtDesc.text = string.format("当前阵容战力已超过全服<color=#F82330FF>%s%%</color>的玩家", overPercent)
end

return RelationPowerFormationExView
