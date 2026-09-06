-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingkaya/view/KingKaYaExtView.lua

module("logic.extensions.kingkaya.view.KingKaYaExtView", package.seeall)

local KingKaYaExtView = class("KingKaYaExtView", ViewComponent)

function KingKaYaExtView:buildUI()
	KingKaYaExtView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._btnClg = goutil.findChild(self.mainGO, "btnClg")
	self._btnReset = goutil.findChild(self.mainGO, "btnReset")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "tips/scrView/Viewport/Content")

	local tabScrView = goutil.findChild(self.mainGO, "tabCol/scrView")
	local tabScrCell = goutil.findChild(self.mainGO, "tabCol/scrCell")

	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._leftFmtView = goutil.findChild(self.mainGO, "leftFmt/fmtView")
	self._rightFmtView = goutil.findChild(self.mainGO, "rightFmt/fmtView")
	self._txtCond = goutil.findChildTextComponent(self.mainGO, "rule/txtCond")
	self._petScrView = goutil.findChild(self.mainGO, "rule/petCol/scrView")
	self._petScrCell = goutil.findChild(self.mainGO, "rule/petCol/scrCell")
	self._imgEmptyPet = goutil.findChild(self.mainGO, "rule/petCol/imgEmpty")
	self._petScrollerList = ScrollerList.create(self._petScrView, self._petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._petScrollerList:setCenterMode(true)
end

function KingKaYaExtView:bindEvents()
	KingKaYaExtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
end

function KingKaYaExtView:unbindEvents()
	KingKaYaExtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnReset)
end

function KingKaYaExtView:onEnter()
	KingKaYaExtView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = KingKaYaController.instance:getActivityType()

	local isInTime = KingKaYaController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._kingKaYaMo = KingKaYaController.instance:getKingKaYaMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_KingKaYaGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingKaYaResetExtremeStageRes, self._handlePM_KingKaYaResetExtremeStageRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_Notify_KingKaYaExtremeChallengeEndRes, self._onUpdate, self)

	self._txtTips.text = KingKaYaConfig.instance:getCommonValue(self._activityId, "extClgTips")

	self:_sendInfoReq()
end

function KingKaYaExtView:onExit()
	KingKaYaExtView.super.onExit(self)
	self:_onClear()
end

function KingKaYaExtView:_handlePM_KingKaYaResetExtremeStageRes()
	FloatWordMgr.instance:show("重置成功")
	self:_onUpdate()
end

function KingKaYaExtView:_sendInfoReq()
	KingKaYaController.instance:sendPM_KingKaYaGetInfoReq(self._activityId)
end

function KingKaYaExtView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function KingKaYaExtView:_onClear()
	self:_onClearTabColUI()
	self:_onClearFmtColUI()
	self:_onClearRuleColUI()
end

function KingKaYaExtView:_onUpdateData()
	self._tabInfoList = {}

	local cfg = KingKaYaConfig.instance:getExtStageCfg(self._activityId)

	for index, data in ipairs(cfg or {}) do
		local info = {}

		info.index = index
		info.data = data
		info.stageId = data.stageId

		table.insert(self._tabInfoList, info)
	end

	local isNeedAuto = false

	self._curTabIdx = self._kingKaYaMo:getCurTabIdxInExt()

	local info = self._tabInfoList[self._curTabIdx]

	if info == nil then
		isNeedAuto = true
	elseif info and self._kingKaYaMo:isPassStageInExt(info.stageId) then
		isNeedAuto = true
	end

	if isNeedAuto then
		local maxIndex = 1

		for _, info in ipairs(self._tabInfoList) do
			maxIndex = info.index

			local isPass = self._kingKaYaMo:isPassStageInExt(info.stageId)

			if not isPass then
				break
			end
		end

		self:_updateCurTabIdx(Mathf.Clamp(maxIndex, 0, #self._tabInfoList))
	else
		self:_updateCurTabIdx(Mathf.Clamp(self._curTabIdx, 0, #self._tabInfoList))
	end
end

function KingKaYaExtView:_onUpdateUI()
	self:_onUpdateTabColUI()
	self:_onUpdateFmtColUI()
	self:_onUpdateRuleColUI()
end

function KingKaYaExtView:_getCurStageId()
	local info = self:_getCurTabInfo()

	return (info or nil) and (info.stageId or 0)
end

function KingKaYaExtView:_getCurTabInfo()
	return self._tabInfoList[self._curTabIdx]
end

function KingKaYaExtView:_updateCurTabIdx(value)
	self._curTabIdx = checknumber(value)

	self._kingKaYaMo:saveCurTabIdxInExt(self._curTabIdx)
end

function KingKaYaExtView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._tabInfoList)

	if #self._tabInfoList > 0 then
		local index = self._curTabIdx - 1

		self._tabScrollList:MoveCellToCenter(index, true)
	end
end

function KingKaYaExtView:_onClearTabColUI()
	self._tabScrollList:dispose()
end

function KingKaYaExtView:_updateTabCell(view, cell, info, tag)
	local tabIdx = info.index
	local data = info.data
	local stageId = info.stageId
	local isSelected = self._curTabIdx == tabIdx
	local isPass = self._kingKaYaMo:isPassStageInExt(stageId)
	local mainGo = cell.gameObject
	local root = goutil.findChild(mainGo, "root")
	local icon = goutil.findChild(mainGo, "root/mask/icon")
	local txtDesc = goutil.findChildTextComponent(mainGo, "desc/txt")
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local imgSelected = goutil.findChild(mainGo, "imgSelected")
	local imgPass = goutil.findChild(mainGo, "imgPass")
	local descStr = ""

	for signId, score in ipairs(data.winScoreRequirements) do
		local signData = KingKaYaConfig.instance:getSignData(self._activityId, signId)

		if signData then
			descStr = signId == #data.winScoreRequirements and descStr .. string.format("%s:<color=#f5e296>%s</color>", signData.desc, score) or descStr .. string.format("%s:<color=#f5e296>%s</color> ", signData.desc, score)
		end
	end

	txtDesc.text = descStr

	local modelCo = CharacterConfig.instance:getModelCo(data.skinId)

	if modelCo then
		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	else
		uGuiUtil.clearImage(icon)
	end

	GameUtil.SetActive(imgPass, isPass)
	GameUtil.SetGray(root, isPass)
	GameUtil.SetActive(imgSelected, isSelected)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickTabCell, self, tabIdx))
end

function KingKaYaExtView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "root/mask/icon")

	GameUtil.rmClickHandler(mainGo)
	uGuiUtil.clearImage(icon)
end

function KingKaYaExtView:_clickTabCell(tabIdx)
	self:_updateCurTabIdx(tabIdx)
	self:_onUpdateUI()
end

function KingKaYaExtView:_onUpdateFmtColUI()
	local stageId = self:_getCurStageId()
	local stageData = KingKaYaConfig.instance:getExtStageData(self._activityId, stageId)

	if stageData then
		if not stageData.creepsMasterId then
			local creepsMasterId = 0

			if stageData then
				if not stageData.selfPositionBuffs then
					local selfPositionBuffs = {}

					if stageData then
						if not stageData.enemyPositionBuffs then
							local enemyPositionBuffs = {}
							local enemyCreepsCfg = KingKaYaConfig.instance:getCreepsCfg(creepsMasterId) or {}
							local enmeyCreepsDataDic = {}

							for _, data in ipairs(enemyCreepsCfg) do
								enmeyCreepsDataDic[data.posId] = data
							end

							local buffs = {}

							buffs[GameEnum.BattleTeam.Left] = selfPositionBuffs
							buffs[GameEnum.BattleTeam.Right] = enemyPositionBuffs

							local creepsDataDics = {}

							creepsDataDics[GameEnum.BattleTeam.Left] = {}
							creepsDataDics[GameEnum.BattleTeam.Right] = enmeyCreepsDataDic

							local fmtViews = {}

							fmtViews[GameEnum.BattleTeam.Left] = self._leftFmtView
							fmtViews[GameEnum.BattleTeam.Right] = self._rightFmtView

							local fMo = FightingPowerPetMo.New()

							for index, battleTeam in ipairs(GameEnum.BattleTeamList) do
								local fmtView = fmtViews[battleTeam]

								for posId = 1, fmtView.transform.childCount do
									local signId = checknumber(buffs[battleTeam][posId])
									local signData = KingKaYaConfig.instance:getSignData(self._activityId, signId)
									local creepsData = creepsDataDics[battleTeam][posId]
									local go = fmtView.transform:GetChild(posId - 1)
									local pet = goutil.findChild(go, "pet")
									local con = goutil.findChild(go, "pet/con")
									local seatTag = goutil.findChild(go, "seatTag")
									local txtSeatTag = goutil.findChildTextComponent(go, "seatTag/txt")
									local iconSeatTag = goutil.findChild(go, "seatTag/icon")
									local markIcon = goutil.findChild(go, "markIcon")

									GameUtil.SetActive(pet, false)
									GameUtil.SetActive(seatTag, false)
									GameUtil.SetActive(markIcon, false)
									MaterialMgr.clearIcon(con)
									MaterialMgr.clearIcon(markIcon)
									uGuiUtil.clearImage(iconSeatTag)

									local petMo

									if creepsData then
										local fMo = FightingPowerPetMo.New()

										fMo:fromChallengeCreepCo(creepsData)

										petMo = fMo:toBaseBagPetMo()
									end

									if petMo then
										local skinId = petMo.curFaceId

										MaterialMgr.setIcon(con, MatType.Pet, skinId, nil, nil)
										GameUtil.addClickHandler(pet, function()
											CommonTipsMgr.instance:showPetTips(petMo)
										end)
										GameUtil.SetActive(pet, true)

										if signData then
											txtSeatTag.text = signData.desc

											GameUtil.SetActive(seatTag, true)

											local spriteName = string.format("%s.png", signData.iconPath)

											uGuiUtil.setSpriteToImage(markIcon, uGuiUtil.SpriteType.BigBg, spriteName)
											GameUtil.SetActive(markIcon, true)
										end
									elseif signData then
										txtSeatTag.text = signData.desc

										local spriteName = string.format("%s.png", signData.iconPath)

										uGuiUtil.setSpriteToImage(iconSeatTag, uGuiUtil.SpriteType.BigBg, spriteName)
										GameUtil.SetActive(seatTag, true)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function KingKaYaExtView:_onClearFmtColUI()
	local fmtViews = {}

	fmtViews[GameEnum.BattleTeam.Left] = self._leftFmtView
	fmtViews[GameEnum.BattleTeam.Right] = self._rightFmtView

	for index, BattleTeam in ipairs(GameEnum.BattleTeamList) do
		local fmtView = fmtViews[BattleTeam]

		for posId = 1, fmtView.transform.childCount do
			local go = fmtView.transform:GetChild(posId - 1)
			local pet = goutil.findChild(go, "pet")
			local con = goutil.findChild(go, "pet/con")
			local iconSeatTag = goutil.findChild(go, "seatTag/icon")
			local markIcon = goutil.findChild(go, "markIcon")

			MaterialMgr.clearIcon(con)
			uGuiUtil.clearImage(iconSeatTag)
			uGuiUtil.clearImage(markIcon)
			GameUtil.rmClickHandler(pet)
		end
	end
end

function KingKaYaExtView:_onUpdateRuleColUI()
	local stageId = self:_getCurStageId()
	local stageData = KingKaYaConfig.instance:getExtStageData(self._activityId, stageId)

	if stageData then
		if not stageData.winScoreRequirements then
			local winScoreRequirements = {}
			local condStr = ""

			for signId, score in ipairs(winScoreRequirements) do
				local signData = KingKaYaConfig.instance:getSignData(self._activityId, signId)

				condStr = signId < #winScoreRequirements and condStr .. string.format("%s≥<color=#f5e296>%s</color> ", signData.desc, score) or condStr .. string.format("%s≥<color=#f5e296>%s</color>", signData.desc, score)
			end

			self._txtCond.text = condStr

			local lockRaceIds = self._kingKaYaMo:getLockRaceIdsInExtStage(stageId)

			self._petScrollerList:reloadData(lockRaceIds)
			GameUtil.SetActive(self._imgEmptyPet, #lockRaceIds <= 0)

			if self._btnClg then
				local result, _ = self:getTryStartStageClgResultAndTips(self._activityId, stageId)

				GameUtil.SetGray(self._btnClg, result ~= GameEnum.ResultCode.Success)
			end
		end
	end
end

function KingKaYaExtView:_onClearRuleColUI()
	self._petScrollerList:dispose()
end

function KingKaYaExtView:_updatePetCell(view, cell, raceId, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setIcon(item, MatType.Pet, raceId, nil, nil)

	local function callBack()
		local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, 1, 1, raceId)

		CommonTipsMgr.instance:showPetTips(tmpMo, true)
	end

	GameUtil.addClickHandler(mainGo, callBack)
end

function KingKaYaExtView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.clearIcon(item)
	GameUtil.rmClickHandler(mainGo)
end

function KingKaYaExtView:_onClickBtnClg()
	local stageId = self:_getCurStageId()
	local result, tips = self:getTryStartStageClgResultAndTips(self._activityId, stageId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.KingKaYaMainView, nil, self._activityId)
	UIJumper.instance:pushOneStack(ViewName.KingKaYaExtView, nil, self._activityId)
	KingKaYaController.instance:enterBattleInExt(self._activityId, stageId)
end

function KingKaYaExtView:_onClickBtnReset()
	local stageId = self:_getCurStageId()
	local result, tips = self:getTryResetStageClgResultAndTips(self._activityId, stageId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local tipsContent = "是否将该关卡重置为未挑战，且解除本关的精灵封印"

	local function okFunc()
		KingKaYaController.instance:sendPM_KingKaYaResetExtremeStageReq(self._activityId, stageId)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

function KingKaYaExtView:_onClickBtnTip()
	local key = KingKaYaConfig.instance:getCommonValue(self._activityId, "ruleKeyExt")

	TipsFacade.instance:openRulesView(key)
end

function KingKaYaExtView:getTryStartStageClgResultAndTips(activityId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local mo = KingKaYaController.instance:getKingKaYaMo(activityId)

	if not KingKaYaController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在开启期限内"
	elseif mo:isPassAllStageInExt() then
		result = GameEnum.ResultCode.Error
		tips = "所有关卡已通关"
	elseif mo:isPassStageInExt(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	end

	return result, tips
end

function KingKaYaExtView:getTryResetStageClgResultAndTips(activityId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local mo = KingKaYaController.instance:getKingKaYaMo(activityId)

	if not KingKaYaController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在开启期限内"
	elseif mo:isPassAllStageInExt() then
		result = GameEnum.ResultCode.Error
		tips = "所有关卡已通关"
	elseif not mo:isPassStageInExt(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "关卡未通关，无需重置"
	end

	return result, tips
end

return KingKaYaExtView
