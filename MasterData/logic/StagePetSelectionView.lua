-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/stage/StagePetSelectionView.lua

module("logic.extensions.powerland.view.stage.StagePetSelectionView", package.seeall)

local StagePetSelectionView = class("StagePetSelectionView", ViewComponent)
local petCellPosList = {
	{
		{
			0,
			0
		}
	},
	{
		{
			-250,
			0
		},
		{
			250,
			0
		}
	},
	{
		{
			-270,
			0
		},
		{
			0,
			0
		},
		{
			270,
			0
		}
	},
	{
		{
			-450,
			0
		},
		{
			-150,
			0
		},
		{
			150,
			0
		},
		{
			450,
			0
		}
	},
	{
		{
			-550,
			0
		},
		{
			-275,
			0
		},
		{
			0,
			0
		},
		{
			275,
			0
		},
		{
			550,
			0
		}
	}
}

function StagePetSelectionView:ctor()
	StagePetSelectionView.super.ctor(self)
end

function StagePetSelectionView:buildUI()
	StagePetSelectionView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._btnPet = goutil.findChild(self.mainGO, "btnPet")
	self._btnPetRed = goutil.findChild(self.mainGO, "btnPet/redPoint")
	self._btnTarget = goutil.findChild(self.mainGO, "btnTarget")
	self._btnTargetRed = goutil.findChild(self.mainGO, "btnTarget/redPoint")
	self._petView = goutil.findChild(self.mainGO, "petCol/petView")
	self._petCell = goutil.findChild(self.mainGO, "petCol/petCell")
	self._container = goutil.findChild(self.mainGO, "container")

	GameUtil.SetActive(self._btnPetRed, false)
	GameUtil.SetActive(self._btnTargetRed, false)
	GameUtil.SetActive(self._petCell, false)
end

function StagePetSelectionView:bindEvents()
	StagePetSelectionView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnPet, self._onClickBtnPet, self)
	GameUtil.addClickHandler(self._btnTarget, self._onClickBtnTarget, self)
end

function StagePetSelectionView:unbindEvents()
	StagePetSelectionView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnPet)
	GameUtil.rmClickHandler(self._btnTarget)
end

function StagePetSelectionView:destroyUI()
	StagePetSelectionView.super.destroyUI(self)
end

function StagePetSelectionView:onEnter()
	StagePetSelectionView.super.onEnter(self)

	self._activityId = PowerLandModel.instance:getCurActivityId()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.PowerLand, self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内( activityId = %d )", self._activityId)
		self:close()

		return
	end

	self._selectPetIdx = 0

	self:_onSetUI()
	self:_onUpdate()
	self:showTabAt(self._container, ViewName.TargetColConView)
	GlobalDispatcher:addListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PowerLandStageOverRes, self._handleChallengeRes, self)
end

function StagePetSelectionView:onExit()
	StagePetSelectionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PowerLandStageOverRes, self._handleChallengeRes, self)
	self:_clearPetCells()
	self:_clearSelectEff()
end

function StagePetSelectionView:_onSetUI()
	return
end

function StagePetSelectionView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function StagePetSelectionView:_onUpdateData()
	self._petIdList = {}
	self._petCount = 0

	local petIds = PowerLandModel.instance:getStageSelectPetIds()

	for _, petId in ipairs(petIds) do
		table.insert(self._petIdList, petId)
	end

	self._petCount = #self._petIdList
end

function StagePetSelectionView:_getPetId(petIdx)
	return (self._petIdList or nil) and (self._petIdList[petIdx] or 0)
end

function StagePetSelectionView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdatePetCol()
end

function StagePetSelectionView:_onUpdatePlaneUI()
	return
end

function StagePetSelectionView:_onUpdatePetCol()
	local childList = GameUtil.getChildren(self._petView)

	for idx, go in ipairs(childList) do
		if idx > self._petCount then
			GameUtil.SetActive(go, false)
		end
	end

	local posData = petCellPosList[self._petCount]

	if posData == nil then
		printError("错误,缺少位置参数")

		return
	end

	for petIdx = 1, self._petCount do
		if not childList[petIdx] then
			local cell = goutil.cloneAndSetParent(self._petCell, self._petView.transform)
			local petId = self:_getPetId(petIdx)
			local data = PowerLandConfig.instance:getPlPetDataByActId(self._activityId, petId)

			childList[petIdx].name = string.format("petCell_%d", petIdx)

			local posArr = posData[petIdx]

			GameUtil.setLocalPos(childList[petIdx], posArr[1], posArr[2], 0)
			self:_updatePetCell(childList[petIdx], data, petIdx)
			GameUtil.SetActive(childList[petIdx], true)
		end
	end
end

function StagePetSelectionView:_updatePetCell(cell, data, petIdx)
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

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickPetCell, self, mainGo, petMo, petIdx))
end

function StagePetSelectionView:_clearPetCells()
	local childList = GameUtil.getChildren(self._petView)

	for idx, go in ipairs(childList) do
		local mainGo = go
		local con = goutil.findChild(mainGo, "mask/con")

		uGuiUtil.clearImage(con)
		GameUtil.rmClickHandler(mainGo)
	end
end

function StagePetSelectionView:_onClickPetCell(mainGo, petMo, petIdx)
	if self._selectPetIdx == petIdx then
		self._selectPetIdx = 0

		self:_hideEff()
	else
		self._selectPetIdx = petIdx

		self:_addEffToGo(mainGo)
		CommonTipsMgr.instance:showMaxLvlPetTips(petMo.raceId, petMo.level, petMo.awakenLv, petMo.curFaceId)
	end
end

function StagePetSelectionView:_addEffToGo(go)
	local path = "fx_ui_yuanzheng/fx_ui_yuanzheng_xuanka.prefab"

	local function loadedHandler(target, eff)
		if eff == nil then
			return
		end

		if target == nil then
			return
		end

		if eff.effGo == nil then
			return
		end

		eff:setClipping(target:GetComponent(goutil.Type_RectTransform))
		eff:setParent(target.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1, 1, 1)
		GameUtil.SetActive(eff.effGo, true)
		GoUtil.SetSortingOrder(eff.effGo.gameObject, PowerLandModel.viewLayer.stagePetAnim)
	end

	if self._effSelect then
		loadedHandler(go, self._effSelect)
	else
		self._effSelect = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, false, nil, loadedHandler, go)
	end
end

function StagePetSelectionView:_hideEff()
	if self._effSelect then
		if self._effSelect then
			GameUtil.SetActive(self._effSelect, false)
		end
	end
end

function StagePetSelectionView:_clearSelectEff()
	UIEffectManager.instance:stopEffect(self._effSelect)

	self._effSelect = nil
end

function StagePetSelectionView:_onClickBtnSure()
	if self._selectPetIdx == 0 then
		FloatWordMgr.instance:show("未选择精灵哦~")
	elseif not self._isSending then
		local activityId = self._activityId
		local selectPetId = self._petIdList[self._selectPetIdx]
		local simpleForm

		PowerLandController.instance:onSendPowerLandChallengeReq(activityId, selectPetId, simpleForm)

		self._isSending = true
	end
end

function StagePetSelectionView:_handleChallengeRes()
	self._isSending = false

	FloatWordMgr.instance:show("选择精灵成功")
	self:close()
end

function StagePetSelectionView:_onClickBtnPet()
	UIStateManager.instance:push(ViewName.PetTargetShowView)
end

function StagePetSelectionView:_onClickBtnTarget()
	UIStateManager.instance:push(ViewName.TargetDetailsView)
end

return StagePetSelectionView
