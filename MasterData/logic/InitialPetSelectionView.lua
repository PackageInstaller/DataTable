-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/InitialPetSelectionView.lua

module("logic.extensions.powerland.view.InitialPetSelectionView", package.seeall)

local InitialPetSelectionView = class("InitialPetSelectionView", ViewComponent)

function InitialPetSelectionView:ctor()
	InitialPetSelectionView.super.ctor(self)
end

function InitialPetSelectionView:buildUI()
	InitialPetSelectionView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._btnChange = goutil.findChild(self.mainGO, "btnChange")
	self._btnChangeTxtNum = goutil.findChildTextComponent(self.mainGO, "btnChange/txtNum/txt")
	self._btnTarget = goutil.findChild(self.mainGO, "btnTarget")
	self._petScrollerview = goutil.findChild(self.mainGO, "petCol/petScrollerview")
	self._petScrollercell = goutil.findChild(self.mainGO, "petCol/petScrollercell")
	self._petScrollList = ScrollerList.create(self._petScrollerview, self._petScrollercell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._container = goutil.findChild(self.mainGO, "container")
end

function InitialPetSelectionView:bindEvents()
	InitialPetSelectionView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnChange, self._onClickBtnChange, self)
	GameUtil.addClickHandler(self._btnTarget, self._onClickBtnTarget, self)
end

function InitialPetSelectionView:unbindEvents()
	InitialPetSelectionView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnChange)
	GameUtil.rmClickHandler(self._btnTarget)
end

function InitialPetSelectionView:destroyUI()
	InitialPetSelectionView.super.destroyUI(self)
end

function InitialPetSelectionView:onEnter()
	InitialPetSelectionView.super.onEnter(self)

	self._activityId = PowerLandModel.instance:getCurActivityId()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.PowerLand, self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内( activityId = %d )", self._activityId)
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PowerLandRefreshPetRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PowerLandStartChallengeRes, self._enterScence, self)
	self:_onSetUI()
	self:_onUpdate()
	self:showTabAt(self._container, ViewName.TargetColConView)
end

function InitialPetSelectionView:onExit()
	InitialPetSelectionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandRefreshPetRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandStartChallengeRes, self._enterScence, self)
	self._petScrollList:dispose()
end

function InitialPetSelectionView:_onSetUI()
	return
end

function InitialPetSelectionView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function InitialPetSelectionView:_onUpdateData()
	return
end

function InitialPetSelectionView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdatePetScrollerList()
end

function InitialPetSelectionView:_onUpdatePlaneUI()
	self._btnChangeTxtNum.text = PowerLandModel.instance:getLeavePetRefreshCount()
end

function InitialPetSelectionView:_onUpdatePetScrollerList()
	local dataList = {}
	local petIdList = PowerLandModel.instance:getCanFormPetIds()

	for _, petId in ipairs(petIdList) do
		local data = PowerLandConfig.instance:getPlPetDataByActId(self._activityId, petId)

		table.insert(dataList, data)
	end

	self._petScrollList:reloadData(dataList)
end

function InitialPetSelectionView:_updatePetCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local bg = goutil.findChild(mainGo, "bg")
	local attr = goutil.findChild(mainGo, "attr")
	local con = goutil.findChild(mainGo, "mask/con")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local jobbg = goutil.findChild(mainGo, "jobbg")
	local job = goutil.findChild(mainGo, "jobbg/job")
	local jobbg1 = goutil.findChild(mainGo, "jobbg1")
	local job1 = goutil.findChild(mainGo, "jobbg1/job1")
	local targetCol = goutil.findChild(mainGo, "targetCol")
	local petMo = PowerLandModel.instance:getPetMo(data.creepsId)
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)

	GameUtil.setUIImageSpriteIdx(job, firstJobIdx - 1)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(petMo.curFaceId)

	if secondJobIdx > 20 then
		GameUtil.SetActive(jobbg1, true)
		GameUtil.setUIImageSpriteIdx(job1, secondJobIdx - 20 - 1)
	else
		GameUtil.SetActive(jobbg1, false)
	end

	txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, petMo.curFaceId)

	local attrIdx = PetSkinConfig.instance:getFisrtEleAttrIdx(petMo.curFaceId)

	attrIdx = attrIdx % 10 - 1

	GameUtil.setUIImageSpriteIdx(attr, attrIdx)
	GameUtil.setUIImageSpriteIdx(bg, attrIdx)

	local modelCo = CharacterConfig.instance:getModelCo(petMo.curFaceId)

	uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	for i = 1, targetCol.transform.childCount do
		local trans = targetCol.transform:GetChild(i - 1)

		GameUtil.SetActive(trans.gameObject, i <= #data.targetIds)
	end

	for idx, targetId in ipairs(data.targetIds) do
		local targetIcon = goutil.findChild(targetCol, string.format("target_%s/icon", idx))
		local targetData
		local fmtTargetInfo = PowerLandModel.instance:getFmtTargetInfo()
		local level = fmtTargetInfo:getTargetLevel(targetId)
		local targetData = PowerLandConfig.instance:getRealPlTargetData(targetId, level)

		if targetIcon then
			local path = targetData.iconPath
			local bgGo = targetIcon

			if not string.nilorempty(path) and bgGo then
				local spriteType = uGuiUtil.SpriteType.BigBg
				local spriteName = string.format("ui/icon/expevents/%s.png", path)

				local function func()
					return
				end

				uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
			end
		else
			printError(string.format("助战精灵id%d,对应印记的预制无法寻到.( idx=%d )", data.creepsId, idx))
		end
	end

	local function handler()
		CommonTipsMgr.instance:showMaxLvlPetTips(data.raceId, data.lv, data.awakenLv, data.faceId)
	end

	GameUtil.addClickHandler(mainGo, handler)
end

function InitialPetSelectionView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(mainGo)
end

function InitialPetSelectionView:_onClickBtnSure()
	PowerLandController.instance:onSendPowerLandStartChallengeReq(self._activityId)
end

function InitialPetSelectionView:_enterScence()
	self:close()
	UIStateManager.instance:push(ViewName.PowerLandScenceView)
end

function InitialPetSelectionView:_onClickBtnChange()
	local refreshCount = PowerLandModel.instance:getLeavePetRefreshCount()

	if refreshCount > 0 then
		PowerLandController.instance:onSendPowerLandRefreshReq(self._activityId)
	else
		FloatWordMgr.instance:show("没有刷新次数啦")
	end
end

function InitialPetSelectionView:_onClickBtnTarget()
	UIStateManager.instance:push(ViewName.TargetDetailsView)
end

return InitialPetSelectionView
