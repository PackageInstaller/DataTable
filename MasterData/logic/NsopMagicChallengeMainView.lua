-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newsummonpetobtain/view/NsopMagicChallengeMainView.lua

module("logic.extensions.newsummonpetobtain.view.NsopMagicChallengeMainView", package.seeall)

local NsopMagicChallengeMainView = class("NsopMagicChallengeMainView", ViewComponent)

function NsopMagicChallengeMainView:buildUI()
	NsopMagicChallengeMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._ruleScrollerview = goutil.findChild(self.mainGO, "ruleCol/ruleScrollerview")
	self._ruleScrollercell = goutil.findChild(self.mainGO, "ruleCol/ruleScrollercell")
	self._txtMaxScore = goutil.findChildTextComponent(self.mainGO, "ruleCol/txtMaxScore")
	self._tabScrollerview = goutil.findChild(self.mainGO, "tabCol/tabScrollerview")
	self._tabScrollercell = goutil.findChild(self.mainGO, "tabCol/tabScrollercell")
	self._fmtCol = goutil.findChild(self.mainGO, "fmtCol")
	self._fmtCell1 = goutil.findChild(self.mainGO, "fmtCol/fmtCell1")
	self._fmtCell2 = goutil.findChild(self.mainGO, "fmtCol/fmtCell2")
	self._ruleScrollList = ScrollerList.create(self._ruleScrollerview, self._ruleScrollercell, GameUtil.handler(self._updateRuleCell, self), GameUtil.handler(self._clearRuleCell, self))
	self._tabScrollList = ScrollerList.create(self._tabScrollerview, self._tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._bgEff = nil
end

function NsopMagicChallengeMainView:bindEvents()
	NsopMagicChallengeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function NsopMagicChallengeMainView:unbindEvents()
	NsopMagicChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function NsopMagicChallengeMainView:_getActivityId()
	return NewSummonPetObtainController.instance:getBeiduoActivityId()
end

function NsopMagicChallengeMainView:onEnter()
	NsopMagicChallengeMainView.super.onEnter(self)

	self._activityId = self:_getActivityId()

	if self._activityId == 0 then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.NewSummonPetObtainGetBalanceTierRes, self._handleBalanceTierRes, self)
	GlobalDispatcher:addListener(GlobalNotify.AllBalanceStageInfoReadky, self._onUpdate, self)
	NewSummonPetObtainController.instance:sendPM_NewSummonPetObtainGetBalanceTierReq(self._activityId)
end

function NsopMagicChallengeMainView:onExit()
	NsopMagicChallengeMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.NewSummonPetObtainGetBalanceTierRes, self._handleBalanceTierRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.AllBalanceStageInfoReadky, self._onUpdate, self)
	self._tabScrollList:dispose()
	self._ruleScrollList:dispose()
	self:_onClearFmtColUI()
end

function NsopMagicChallengeMainView:destroyUI()
	NsopMagicChallengeMainView.super.destroyUI(self)
end

function NsopMagicChallengeMainView:_handleBalanceTierRes()
	self._curTier = NewSummonPetObtainModel.instance:getCurTierInBL()
	self._tierData = NewSummonPetObtainConfig.instance:getNspoTierDataById(self._activityId, self._curTier)
	self._stageCfg = NewSummonPetObtainConfig.instance:getNspoStageCfg(self._tierData.stagePlanId)
	self._curStagePlanId = self._tierData.stagePlanId

	if self._curStageId == nil then
		self._curStageId = NewSummonPetObtainModel.instance:getCurStageId()
	end

	if self._curStageId == nil or self._curStageId > #self._stageCfg then
		self._curStageId = 1

		NewSummonPetObtainModel.instance:saveCurStageId(self._curStageId)
	end

	NewSummonPetObtainController.instance:updateBalanceMainViewInfo(self._activityId, self._curTier)
end

function NsopMagicChallengeMainView:_onSetUI()
	return
end

function NsopMagicChallengeMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function NsopMagicChallengeMainView:_onUpdateData()
	return
end

function NsopMagicChallengeMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateTabColUI()
	self:_onUpdateRuleColUI()
	self:_onUpdateFmtColUI()
end

function NsopMagicChallengeMainView:_onUpdatePlaneUI()
	return
end

function NsopMagicChallengeMainView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._stageCfg)
	self._tabScrollList:MoveCellInView(0, true)
end

function NsopMagicChallengeMainView:_updateTabCell(view, cell, data, tag)
	local index = cell.index + 1
	local mainGo = cell.gameObject
	local changeGroup = mainGo:GetComponent(ComponentType.UIChangeGroup)
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local btn = goutil.findChild(mainGo, "btn")
	local isSelected = self._curStageId == index

	changeGroup:SetState(isSelected and 1 or 0)

	txtName.text = string.format("第%s战", index)

	GameUtil.addClickHandler(btn, GameUtil.handler(self._clickTabCell, self, index))
end

function NsopMagicChallengeMainView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function NsopMagicChallengeMainView:_clickTabCell(index)
	if self._curStageId == index then
		return
	else
		self._curStageId = index

		NewSummonPetObtainModel.instance:saveCurStageId(self._curStageId)
	end

	self:_onUpdate()
end

function NsopMagicChallengeMainView:_onUpdateRuleColUI()
	local infoList = {}
	local stageData = self._stageCfg[self._curStageId]

	for _, ruleId in ipairs(stageData.ruleList) do
		local info = {
			ruleId = ruleId,
			data = NewSummonPetObtainConfig.instance:getNspoRuleData(ruleId),
			blackRuleInfo = NewSummonPetObtainModel.instance:getBalanceInfoInBS(self._curStageId, ruleId, true),
			writeRuleInfo = NewSummonPetObtainModel.instance:getBalanceInfoInBS(self._curStageId, ruleId, false)
		}

		table.insert(infoList, info)
	end

	self._ruleScrollList:reloadData(infoList)
	self._ruleScrollList:MoveCellInView(0, true)

	self._txtMaxScore.text = self:_getMaxScoreStr()
end

function NsopMagicChallengeMainView:_updateRuleCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local txtScore = goutil.findChildTextComponent(mainGo, "score/txtScore")
	local txtCond = goutil.findChildTextComponent(mainGo, "desc/txtCond")
	local txtDesc = goutil.findChildTextComponent(mainGo, "desc/txtDesc")
	local txtTip = goutil.findChild(mainGo, "desc/txtTip")
	local imgNo = goutil.findChild(mainGo, "imgNo")
	local imgYes = goutil.findChild(mainGo, "imgYes")

	txtScore.text = string.format("%s积分", info.data.score)
	txtCond.text = info.data.txtCondDesc

	local descStr = ""
	local isActivedTxtTip = false
	local isEnough = false
	local ruleParams = info.data.ruleParams

	if info.data.ruleHandler == "SurvivalSameAttributeNum" or info.data.ruleHandler == "SameAttributeNum" then
		local attrMapGroup = {}

		for groupIdx, infoStr in ipairs({
			info.blackRuleInfo,
			info.writeRuleInfo
		}) do
			local attrMap = {}

			attrMapGroup[groupIdx] = attrMap

			if not string.nilorempty(infoStr) then
				for _, noteStr in ipairs(string.split(infoStr, ",")) do
					local temp = string.split(noteStr, "=")

					attrMap[temp[1]] = checknumber(temp[2])
				end
			end
		end

		local map = {}

		for groupIdx, attrMap in ipairs(attrMapGroup) do
			for attr, count in pairs(attrMap) do
				map[attr] = true
			end
		end

		local minCount = checknumber(ruleParams.num)
		local tempCount = -1
		local isEqual = ruleParams.equal == "true"
		local enoughNum = 0
		local lineStr = ""

		for attr, _ in pairs(map) do
			lineStr = ""
			isLineRight = true
			isFieldRight = true
			tempCount = -1

			for groupIdx, attrMap in ipairs(attrMapGroup) do
				local count = checknumber(attrMap[attr])

				if tempCount == -1 then
					tempCount = count
				end

				isFieldRight = isEqual and count == minCount or minCount <= count and count == tempCount
				tempCount = count
				isLineRight = isLineRight and isFieldRight
				lineStr = groupIdx == 1 and (count == 0 and "?" or string.format("%s只%s", count, attr)) or count == 0 and (isFieldRight and lineStr .. "=?" or lineStr .. "=?") or isFieldRight and lineStr .. string.format("=%s只%s", count, attr) or lineStr .. string.format("=%s只%s", count, attr)
			end

			if isLineRight then
				lineStr = string.format("<color=#75F859FF>%s</color>", lineStr)
				enoughNum = enoughNum + 1
			end

			descStr = string.nilorempty(descStr) and lineStr or descStr .. "\n" .. lineStr
		end

		isEnough = enoughNum > 0
		isActivedTxtTip = true
	else
		local blackStr, writeStr = "?", "?"

		if not string.nilorempty(info.blackRuleInfo) then
			blackStr = info.blackRuleInfo
		end

		if not string.nilorempty(info.writeRuleInfo) then
			writeStr = info.writeRuleInfo
		end

		descStr = string.format("%s = %s", blackStr, writeStr)

		if blackStr ~= "?" and writeStr ~= "?" then
			isEnough = blackStr == writeStr
		end
	end

	txtDesc.text = descStr

	GameUtil.SetActive(txtTip, isActivedTxtTip)
	GameUtil.SetActive(imgYes, isEnough)
	GameUtil.SetActive(imgNo, not GameUtil.GetActive(imgYes))
end

function NsopMagicChallengeMainView:_clearRuleCell(cell)
	return
end

function NsopMagicChallengeMainView:_getMaxScoreStr()
	local maxScore = NewSummonPetObtainModel.instance:getMaxScoreTodayInBS(self._curStageId)

	return string.format("历史最高分：<color=#d64a4b>%s</color>", maxScore)
end

function NsopMagicChallengeMainView:_onUpdateFmtColUI()
	self:_updateFmtCell(self._fmtCell1, true)
	self:_updateFmtCell(self._fmtCell2, false)
end

function NsopMagicChallengeMainView:_onClearFmtColUI()
	self:_clearFmtCell(self._fmtCell1)
	self:_clearFmtCell(self._fmtCell2)
end

function NsopMagicChallengeMainView:_updateFmtCell(mainGo, isBlack)
	local creepsCfg = NewSummonPetObtainConfig.instance:getNspoCreepsCfg(isBlack and self._stageCfg[self._curStageId].blackCreepsMasterId or self._stageCfg[self._curStageId].whiteCreepsMasterId)
	local pass = goutil.findChild(mainGo, "pass")
	local btnFormation = goutil.findChild(mainGo, "btnFormation")
	local fmtView = goutil.findChild(mainGo, "fmtCol/fmtView")

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")
		local creepsData

		for _, cData in ipairs(creepsCfg) do
			if cData.posId == posId then
				creepsData = cData

				break
			end
		end

		if creepsData then
			local skinId = checknumber(creepsData.faceId)

			if skinId == 0 then
				skinId = creepsData.raceId
			end

			local proxy = MaterialMgr.setCell(MatType.Pet, skinId, icon)

			if proxy then
				proxy.binder:setClickCallBack(nil)
			end
		else
			MaterialMgr.resetAll(icon)
		end
	end

	GameUtil.addClickHandler(btnFormation, GameUtil.handler(self._onClickFmtCell, self, isBlack))
end

function NsopMagicChallengeMainView:_clearFmtCell(mainGo)
	local fmtView = goutil.findChild(mainGo, "fmtCol/fmtView")

	for posId = 1, fmtView.transform.childCount do
		local go = fmtView.transform:GetChild(posId - 1)
		local icon = goutil.findChild(go, "icon")

		MaterialMgr.resetAll(icon)
	end
end

function NsopMagicChallengeMainView:_onClickFmtCell(isBlack)
	UIJumper.instance:saveCurStack()
	NewSummonPetObtainController.instance:enterBattleAsBS(self._activityId, self._curStagePlanId, self._curStageId, isBlack)
end

function NsopMagicChallengeMainView:_onClickBtnTip()
	local ruleKey = NewSummonPetObtainConfig.instance:getNspoCommonValue(self._activityId, "NSOP_CHALLENGE_RULE_KEY")

	TipsFacade.instance:openRulesView(ruleKey)
end

return NsopMagicChallengeMainView
