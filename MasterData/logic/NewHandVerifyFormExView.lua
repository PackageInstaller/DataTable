-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewHandVerifyFormExView.lua

module("logic.extensions.newhandwelfare.view.NewHandVerifyFormExView", package.seeall)

local NewHandVerifyFormExView = class("NewHandVerifyFormExView", ViewComponent)

function NewHandVerifyFormExView:ctor()
	NewHandVerifyFormExView.super.ctor(self)
end

function NewHandVerifyFormExView:buildUI()
	NewHandVerifyFormExView.super.buildUI(self)

	self._petScrollercell = goutil.findChild(self.mainGO, "petCol/petScrollercell")
	self._petScrollerview = goutil.findChild(self.mainGO, "petCol/petScrollerview")
	self._petScrollList = ScrollerList.create(self._petScrollerview, self._petScrollercell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._imgRecZdl = self:getGo("txtTips/imgRecZdl"):GetComponent(ComponentType.UIImgNumeralText)
end

function NewHandVerifyFormExView:bindEvents()
	NewHandVerifyFormExView.super.bindEvents(self)
end

function NewHandVerifyFormExView:unbindEvents()
	NewHandVerifyFormExView.super.unbindEvents(self)
end

function NewHandVerifyFormExView:destroyUI()
	NewHandVerifyFormExView.super.destroyUI(self)
end

function NewHandVerifyFormExView:onEnter()
	NewHandVerifyFormExView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._bondTeamId = self._customFmtMo:getBondTeamId()
	self._teamData = NewhandwelfareConfig.instance:getBondTeamData(self._bondTeamId)

	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandleNewHandWelfareVerifyFmtUpdate, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandleNewHandWelfareGetBoundInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandleNewHandWelfareSubmitFormZdlRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandleNewHandWelfareGainBoundPrizeRes, self._onUpdate, self)
	settimer(0.1, self._onTicking, self)
end

function NewHandVerifyFormExView:onExit()
	NewHandVerifyFormExView.super.onExit(self)
	removetimer(self._onTicking, self)
	self:_onClearPetCol()
end

function NewHandVerifyFormExView:_sendVerifyReq()
	self._customFmtMo:fmtVerifyReq()
end

function NewHandVerifyFormExView:_handleVerifyFmtUpdate()
	self._isNeedUpdateUI = true
	self._isNeedVerify = true
end

function NewHandVerifyFormExView:_handleVerifyVerifyFormZdlRes()
	self._isNeedUpdateUI = true
end

function NewHandVerifyFormExView:_onUpdate()
	self:_onUpdatePetColUI()
	self:_onUpdateDescColUI()
end

function NewHandVerifyFormExView:_onTicking()
	if self._isNeedUpdateUI == true then
		self._isNeedUpdateUI = false

		self:_onUpdate()
	end

	if self._isNeedVerify == true then
		self._isNeedVerify = false

		self:_sendVerifyReq()
	end
end

function NewHandVerifyFormExView:_onUpdatePetColUI()
	local petInfoList = {}

	if not self._teamData.bondRaceIds then
		for _, raceId in ipairs(self._teamData.bondRaceIds) do
			local info = {}

			info.raceId = raceId
			info.isExist = BagModel.instance:isExistRaceId(raceId)
			info.isUpFmt = self._customFmtMo:isUpFmt(raceId)

			table.insert(petInfoList, info)
		end

		self._petScrollList:reloadData(petInfoList)
	end
end

function NewHandVerifyFormExView:_onClearPetCol()
	self._petScrollList:dispose()
end

function NewHandVerifyFormExView:_updatePetCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local raceId = info.raceId
	local isExist = info.isExist
	local isUpFmt = info.isUpFmt
	local descData = NewhandwelfareConfig.instance:getBondTeamDescData(self._bondTeamId, raceId)

	if descData == nil then
		printError(string.format("bondTeamId:%s, raceId:%s -> 缺失精灵配置( export_验证阵容精灵详细  in  x新手福利.xlsx  )", self._bondTeamId, raceId))
	end

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
		GameUtil.addClickHandler(btnGoGet, GameUtil.handler(self._onClickPetGoGet, self, descData.goGetKey))
	end

	local isNeedBtnUpZdl = isExist and not string.nilorempty(descData and descData.upZdlKey)

	GameUtil.SetActive(btnUpZdl, isNeedBtnUpZdl)

	if isNeedBtnUpZdl then
		GameUtil.addClickHandler(btnUpZdl, GameUtil.handler(self._onClickPetUpZdl, self, descData.upZdlKey))
	end
end

function NewHandVerifyFormExView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local imgPet = goutil.findChild(mainGo, "petIcon/img/pet")
	local btnUpZdl = goutil.findChild(mainGo, "btnUpZdl")
	local btnGoGet = goutil.findChild(mainGo, "btnGoGet")

	MaterialMgr.resetAll(imgPet)
	GameUtil.rmClickHandler(btnUpZdl)
	GameUtil.rmClickHandler(btnGoGet)
end

function NewHandVerifyFormExView:_onClickPetUpZdl(jumpStr)
	if not string.nilorempty(jumpStr) then
		GotoMgr.gotoByString(jumpStr)
	end
end

function NewHandVerifyFormExView:_onClickPetGoGet(jumpStr)
	if not string.nilorempty(jumpStr) then
		GotoMgr.gotoByString(jumpStr)
	end
end

function NewHandVerifyFormExView:_onUpdateDescColUI()
	self._imgRecZdl:SetNum((not self._customFmtMo:isEmptyFmt() or nil) and MissionModel.instance:getLeftPower())
end

return NewHandVerifyFormExView
