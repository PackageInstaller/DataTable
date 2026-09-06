-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/view/DivineInvincibleExtResultSureView.lua

module("logic.extensions.divineinvincible.view.DivineInvincibleExtResultSureView", package.seeall)

local DivineInvincibleExtResultSureView = class("DivineInvincibleExtResultSureView", ViewComponent)

function DivineInvincibleExtResultSureView:ctor()
	DivineInvincibleExtResultSureView.super.ctor(self)

	self._banRaceIds = {}
end

function DivineInvincibleExtResultSureView:buildUI()
	DivineInvincibleExtResultSureView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._btnCancel = goutil.findChild(self.mainGO, "btnCancel")
	self._txtCollect = self:getTxt("collect/txt")
	self._strTxtCollect = self._txtCollect.text
	self._lockEmpty = goutil.findChild(self.mainGO, "petCol/lockEmpty")

	local petScrView = goutil.findChild(self.mainGO, "petCol/scrView")
	local petScrCell = goutil.findChild(self.mainGO, "petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._petScrollerList:setCenterMode(true)

	self._oldPosView = self:getGo("oldPos/view")
	self._oldPosCell = self:getGo("oldPos/cell")
	self._newPosView = self:getGo("newPos/view")
	self._newPosCell = self:getGo("newPos/cell")

	GameUtil.SetActive(self._oldPosCell, false)
	GameUtil.SetActive(self._newPosCell, false)
end

function DivineInvincibleExtResultSureView:bindEvents()
	DivineInvincibleExtResultSureView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
end

function DivineInvincibleExtResultSureView:unbindEvents()
	DivineInvincibleExtResultSureView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function DivineInvincibleExtResultSureView:onEnter()
	DivineInvincibleExtResultSureView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._fmtMo = params[2]
	self._activityType = DivineInvincibleController.instance:getActivityType()
	self._formationMo = self._fmtMo:getCurFormation()
	self._clgMo = DivineInvincibleController.instance:getClgMo(self._activityId)
	self._actData = DivineInvincibleConfig.instance:getActData(self._activityId)
	self._extremeLockPetNum = self._actData.extremeLockPetNum
	self._needEleAttrIdxs = {}

	for posId = 1, 9 do
		local data = DivineInvincibleConfig.instance:getExtPassData(self._activityId, posId)
		local stateKey

		if data and not string.nilorempty(data.validator) then
			local arr = string.split(data.validator, "$")

			stateKey = arr[2]
		end

		if stateKey then
			self._needEleAttrIdxs[posId] = GameEnum.Races[stateKey] or -1
		end
	end

	self._fmtRaceMap = self._formationMo:getCurElementRelationMap()

	self.addGEvent(self, GlobalNotify.HandlePM_NotifyDivineInvincibleClgExtremeFightResultRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineInvincibleClgExtremeConfirmRes, self._handlePM_DivineInvincibleClgExtremeConfirmRes, self)
	self:_onUpdate()
end

function DivineInvincibleExtResultSureView:onExit()
	DivineInvincibleExtResultSureView.super.onExit(self)
	self:_onClearPetCol()
	self:_onClearOldPosCol()
	self:_onClearNewPosCol()
end

function DivineInvincibleExtResultSureView:_handlePM_DivineInvincibleClgExtremeConfirmRes(status)
	BattleController.instance:endBattle()
end

function DivineInvincibleExtResultSureView:_onUpdate()
	self._fightMsg = self._clgMo:getExtFightMsg()
	self._selectPosIds = {}
	self._selectCount = 0
	self._passInfos = {}

	local banPetIds = {}

	self._banPetMoList = {}

	if self._fightMsg then
		for i, v in ipairs(self._fightMsg.items) do
			self._passInfos[v.posId] = v

			table.insert(banPetIds, v.petId)
		end
	end

	for i = 1, #banPetIds do
		local petId = checknumber(banPetIds[i])

		if petId > 0 then
			local petMo = self._fmtMo:getPetMoById(petId)

			table.insert(self._banPetMoList, petMo)
		end
	end

	self:_onUpdateCollectTxt()
	self:_onUpdatePetColUI()
	self:_onUpdateOldPosCol()
	self:_onUpdateNewPosCol()
end

function DivineInvincibleExtResultSureView:_onUpdatePetColUI()
	self._petScrollerList:reloadData(self._banPetMoList)
	GameUtil.SetActive(self._lockEmpty, #self._banPetMoList == 0)
end

function DivineInvincibleExtResultSureView:_onClearPetCol()
	self._petScrollerList:dispose()
end

function DivineInvincibleExtResultSureView:_updatePetCell(view, cell, petMo, tag)
	local skinId = petMo.curFaceId
	local raceId = petMo:getDefineId()
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")

	if raceId > 0 then
		MaterialMgr.setIcon(con, MatType.Pet, skinId, nil, nil)
	else
		MaterialMgr.clearIcon(con)
	end

	GameUtil.addClickHandler(pet, function()
		CommonTipsMgr.instance:showPetTips(petMo, true)
	end)
end

function DivineInvincibleExtResultSureView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")

	MaterialMgr.clearIcon(con)
	GameUtil.rmClickHandler(pet)
end

function DivineInvincibleExtResultSureView:_onUpdateOldPosCol()
	local childCount = self._oldPosView.transform.childCount

	for posId = 1, 9 do
		local mainGo = posId <= childCount and self._oldPosView.transform:GetChild(posId - 1).gameObject or goutil.cloneAndSetParent(self._oldPosCell, self._oldPosView.transform, self._oldPosCell.name .. posId)

		GameUtil.SetActive(mainGo, true)

		local content = goutil.findChild(mainGo, "content")
		local imgFinish = goutil.findChild(mainGo, "content/imgFinish")
		local iconAtlas = goutil.findChild(mainGo, "content/tag/iconAtlas")
		local txtName = goutil.findChildTextComponent(mainGo, "content/tag/txtName")
		local txtCond = goutil.findChildTextComponent(mainGo, "content/txtCond")
		local txtPos = goutil.findChildComponent(mainGo, "content/txtPos", ComponentType.UIImgNumeralText)
		local data = DivineInvincibleConfig.instance:getExtPassData(self._activityId, posId)
		local curTimes = self._clgMo:getTimesInExtPass(posId)
		local needTimes = self._clgMo:getNeedTimesInExtPass(posId)
		local isFinish = self._clgMo:isFinishInExtPass(posId)
		local stateKey

		if not string.nilorempty(data.validator) then
			local arr = string.split(data.validator, "$")

			stateKey = arr[2]
		end

		GameUtil.SetActive(imgFinish, isFinish)
		txtPos:SetNum(posId)

		txtCond.text = needTimes <= curTimes and string.format("%s/%s", curTimes, needTimes) or string.format("<color=#FFFFFFFF>%s</color>/%s", curTimes, needTimes)

		GameUtil.SetActive(content, stateKey ~= nil)

		if stateKey then
			local state = (GameEnum.Races[stateKey] or 1) - 1

			GameUtil.setUIImageSpriteIdx(iconAtlas, state)

			txtName.text = stateKey
		end
	end
end

function DivineInvincibleExtResultSureView:_onClearOldPosCol()
	return
end

function DivineInvincibleExtResultSureView:_onUpdateCollectTxt()
	self._txtCollect.text = string.format(self._strTxtCollect, self._selectCount, self._extremeLockPetNum)
end

function DivineInvincibleExtResultSureView:_onUpdateNewPosCol()
	local childCount = self._newPosView.transform.childCount

	for posId = 1, 9 do
		local mainGo = posId <= childCount and self._newPosView.transform:GetChild(posId - 1).gameObject or goutil.cloneAndSetParent(self._newPosCell, self._newPosView.transform, self._newPosCell.name .. posId)

		GameUtil.SetActive(mainGo, true)

		local content = goutil.findChild(mainGo, "content")
		local imgFinish = goutil.findChild(mainGo, "content/imgFinish")
		local iconAtlas = goutil.findChild(mainGo, "content/tag/iconAtlas")
		local txtName = goutil.findChildTextComponent(mainGo, "content/tag/txtName")
		local txtCond = goutil.findChildTextComponent(mainGo, "content/txtCond")
		local txtPos = goutil.findChildComponent(mainGo, "content/txtPos", ComponentType.UIImgNumeralText)
		local selectTag = goutil.findChild(mainGo, "content/selectTag")
		local data = DivineInvincibleConfig.instance:getExtPassData(self._activityId, posId)
		local passInfo = self._passInfos[posId]
		local isEmpty = passInfo == nil

		if passInfo then
			if not passInfo.petId then
				local petId = 0

				if passInfo then
					if not passInfo.times then
						local curTimes = 0
						local petMo = self._fmtMo:getPetMoById(petId)

						if petMo then
							if not petMo.curFaceId then
								local skinId = 0
								local needTimes = self._clgMo:getNeedTimesInExtPass(posId)
								local eleAttrIdx = not isEmpty and PetSkinConfig.instance:getFisrtEleAttrIdx(skinId) or 0

								if self._fmtRaceMap[petId] then
									eleAttrIdx = self._fmtRaceMap[petId]
								end

								local isEnoughTimes = needTimes <= curTimes
								local isEnoughAttr = self._needEleAttrIdxs[posId] == eleAttrIdx

								GameUtil.SetActive(content, not isEmpty)
								GameUtil.SetActive(imgFinish, not isEmpty and isEnoughTimes and isEnoughAttr)
								GameUtil.SetActive(selectTag, self._selectPosIds[posId])
								txtPos:SetNum(posId)

								txtCond.text = string.format("%s", curTimes)

								if not isEmpty then
									local state = Mathf.Max(eleAttrIdx - 1, 0)

									GameUtil.setUIImageSpriteIdx(iconAtlas, state)
								end

								txtName.text = ConstString.RaceIdToTxt[eleAttrIdx]

								GameUtil.addClickHandler(mainGo, function()
									if self._selectPosIds[posId] then
										self._selectPosIds[posId] = nil
										self._selectCount = Mathf.Max(0, self._selectCount - 1)
									else
										local result = self:_getTryResultAndTipsSelectNewPos(true, posId)

										if result ~= GameEnum.ResultCode.Success then
											return
										end

										if self._selectCount >= self._extremeLockPetNum then
											FloatWordMgr.instance:show("已达可选上限")

											return
										end

										self._selectPosIds[posId] = true
										self._selectCount = self._selectCount + 1
									end

									GameUtil.SetActive(selectTag, self._selectPosIds[posId])
									self:_onUpdateCollectTxt()
								end)
							end
						end
					end
				end
			end
		end
	end
end

function DivineInvincibleExtResultSureView:_onClearNewPosCol()
	for posId = 1, self._newPosView.transform.childCount do
		local mainGo = self._newPosView.transform:GetChild(posId - 1).gameObject

		GameUtil.rmClickHandler(mainGo)
	end
end

function DivineInvincibleExtResultSureView:_getTryResultAndTipsSelectNewPos(isShowTips, posId)
	local tips
	local passInfo = self._passInfos[posId]
	local isEmpty = passInfo == nil

	if passInfo then
		if not passInfo.petId then
			local petId = 0

			if passInfo then
				if not passInfo.times then
					local curTimes = 0
					local petMo = self._fmtMo:getPetMoById(petId)

					if petMo then
						if not petMo.curFaceId then
							local skinId = 0
							local needTimes = self._clgMo:getNeedTimesInExtPass(posId)
							local eleAttrIdx = not isEmpty and PetSkinConfig.instance:getFisrtEleAttrIdx(skinId) or 0
							local isEnoughTimes = needTimes <= curTimes
							local isEnoughAttr = self._needEleAttrIdxs[posId] == ((self._fmtRaceMap[petId] or nil) and self._fmtRaceMap[petId])
							local result = GameEnum.ResultCode.Success
							local tips

							if isEmpty then
								result = GameEnum.ResultCode.Error
							elseif not isEnoughTimes then
								result = GameEnum.ResultCode.Error
								tips = "群攻次数不符合"
							elseif not isEnoughAttr then
								result = GameEnum.ResultCode.Error
								tips = "属性不符合"
							end

							if isShowTips then
								FloatWordMgr.instance:show(tips)
							end

							return result
						end
					end
				end
			end
		end
	end
end

function DivineInvincibleExtResultSureView:_onClickBtnSure()
	local list = {}

	for posId, boo in pairs(self._selectPosIds) do
		if boo then
			table.insert(list, posId)
		end
	end

	if #list > self._extremeLockPetNum then
		FloatWordMgr.instance:show("超过可选上限")

		return
	end

	local total = 0

	for posId = 1, 9 do
		if total < self._extremeLockPetNum then
			local result = self:_getTryResultAndTipsSelectNewPos(false, posId)

			if result == GameEnum.ResultCode.Success then
				total = total + 1
			end
		else
			break
		end
	end

	total = Mathf.Min(total, self._extremeLockPetNum)

	if total > #list then
		local tipsContent = "仍有可点亮的格子目标，是否保存当前选择且离开？"

		local function okFunc()
			DivineInvincibleController.instance:sendPM_DivineInvincibleClgExtremeConfirmReq(self._activityId, list)
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
	else
		DivineInvincibleController.instance:sendPM_DivineInvincibleClgExtremeConfirmReq(self._activityId, list)
	end
end

function DivineInvincibleExtResultSureView:_onClickBtnCancel()
	BattleController.instance:endBattle()
end

return DivineInvincibleExtResultSureView
