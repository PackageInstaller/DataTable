-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyhoundingclg/view/FamilyHoudingClgMainView.lua

module("logic.extensions.familyhoundingclg.view.FamilyHoudingClgMainView", package.seeall)

local FamilyHoudingClgMainView = class("FamilyHoudingClgMainView", ViewComponent)

function FamilyHoudingClgMainView:buildUI()
	FamilyHoudingClgMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._partCol = goutil.findChild(self.mainGO, "partCol")
	self._partView = goutil.findChild(self.mainGO, "partCol/partView")
	self._partCell = goutil.findChild(self.mainGO, "partCol/partCell")

	GameUtil.SetActive(self._partCell, false)

	self._ruleCol = goutil.findChild(self.mainGO, "ruleCol")

	local rankScrollerview = goutil.findChild(self.mainGO, "ruleCol/rankScrollerview")
	local rankScrollercell = goutil.findChild(self.mainGO, "ruleCol/rankScrollercell")

	self._rankScrollList = ScrollerList.create(rankScrollerview, rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._emptyGo = goutil.findChild(self.mainGO, "ruleCol/emptyGo")
	self._emptyGo_txt = goutil.findChildTextComponent(self.mainGO, "ruleCol/emptyGo/txt")
	self._tipsCol = goutil.findChild(self.mainGO, "tipsCol")
	self._tipsCol_txt = goutil.findChildTextComponent(self.mainGO, "tipsCol/txt")
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "txtCount")
	self._btnFamily = goutil.findChild(self.mainGO, "ruleCol/btnFamily")
	self._btnPerson = goutil.findChild(self.mainGO, "ruleCol/btnPerson")
	self._btnDetail = goutil.findChild(self.mainGO, "ruleCol/btnDetail")
end

function FamilyHoudingClgMainView:bindEvents()
	FamilyHoudingClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnFamily, GameUtil.handler(self._onClickBtnChangeRank, self, FhcEnum.RankType_Family))
	GameUtil.addClickHandler(self._btnPerson, GameUtil.handler(self._onClickBtnChangeRank, self, FhcEnum.RankType_Persion))
	GameUtil.addClickHandler(self._btnDetail, self._onClickBtnDetail, self)
end

function FamilyHoudingClgMainView:unbindEvents()
	FamilyHoudingClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnFamily)
	GameUtil.rmClickHandler(self._btnPerson)
	GameUtil.rmClickHandler(self._btnDetail)
end

function FamilyHoudingClgMainView:onEnter()
	FamilyHoudingClgMainView.super.onEnter(self)
	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.handlePM_FamilyHounding_GetInfoRes, self._onUpdate, self)
	FamilyHoudingClgController.instance:sendPM_FamilyHounding_GetInfoReq()
end

function FamilyHoudingClgMainView:onExit()
	FamilyHoudingClgMainView.super.onExit(self)
	self:_onClear()
end

function FamilyHoudingClgMainView:_onSetUI()
	return
end

function FamilyHoudingClgMainView:_onUpdate()
	self._fhId = FamilyHoudingClgController.instance:getCurPlanId()
	self._planTimeData = FamilyHoudingClgConfig.instance:getFhPlanTimeData(self._fhId)

	self:_onUpdatePlaneUI()
	self:_onUpdatePartColUI()
	self:_onUpdateRuleColUI()
end

function FamilyHoudingClgMainView:_onClear()
	self:_onClearPartCol()
	self:_onClearRuleCol()
end

function FamilyHoudingClgMainView:_onUpdatePlaneUI()
	local curBuffId = FamilyHoudingClgController.instance:getCurBuffId()
	local buffData = FamilyHoudingClgConfig.instance:getFhBuffData(curBuffId)
	local nextBuffData = FamilyHoudingClgConfig.instance:getFhBuffData(curBuffId + 1)
	local formatTime = buffData and GameUtil.getFormatTimeByStamp(GameUtil.string2time(buffData.startTime), nil)
	local nextFormatTime = nextBuffData and GameUtil.getFormatTimeByStamp(GameUtil.string2time(nextBuffData.startTime), nil)
	local str1 = not string.nilorempty(formatTime) and not string.nilorempty(nextFormatTime) and string.format("祝福时间：%s-%s\n", formatTime, nextFormatTime) or not string.nilorempty(formatTime) and string.format("祝福时间：%s-永久\n", formatTime) or "祝福时间：永久\n"

	if buffData then
		if not buffData.desc then
			local buffDesc = ""
			local str2 = string.format("本期祝福：%s", buffDesc)

			self._tipsCol_txt.text = string.format("%s%s", str1, str2)

			local leftTimes = FamilyHoudingClgController.instance:getLeftChallengeTimes()
			local maxTimes = FamilyHoudingClgController.instance:getMaxChallengeTimes(self._fhId)

			self._txtCount.text = leftTimes <= 0 and string.format("挑战次数：<color=#eb4624>%s</color>/%s", leftTimes, maxTimes) or string.format("挑战次数：<color=#20b376>%s</color>/%s", leftTimes, maxTimes)

			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._tipsCol:GetComponent(goutil.Type_RectTransform))
		end
	end
end

function FamilyHoudingClgMainView:_onUpdatePartColUI()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)
	local childGo = self._partCell
	local cfg = FamilyHoudingClgConfig.instance:getFhBossCfg(self._fhId)

	if cfg then
		if not #cfg then
			local length = 0

			if cfg then
				for idx, data in ipairs(cfg) do
					local mainGo = children[idx]

					if mainGo == nil then
						mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))

						if not data.rukouPos then
							local pos = {}
							local x, y = checknumber(pos[1]), checknumber(pos[2])

							GameUtil.setLocalPos(mainGo, x, y, 0)
						end
					end

					self:_updatePartCell(mainGo, data)
				end
			end

			for idx = 1, parentTran.childCount do
				local mainGo = parentTran:GetChild(idx - 1)

				if idx <= length then
					GameUtil.SetActive(mainGo, true)
				else
					self:_clearPartCell(mainGo)
					GameUtil.SetActive(mainGo, false)
				end
			end
		end
	end
end

function FamilyHoudingClgMainView:_onClearPartCol()
	local parentTran = self._partView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		self:_clearPartCell(mainGo)
	end
end

function FamilyHoudingClgMainView:_updatePartCell(mainGo, data)
	local dayIndex = data.dayIndex
	local isUnlock = FamilyHoudingClgController.instance:isInDayIndex(dayIndex)
	local imgHead = goutil.findChild(mainGo, "imgHead")
	local icon = goutil.findChild(mainGo, "imgHead/icon")
	local imgLock = goutil.findChild(mainGo, "imgHead/imgLock")
	local imgLock_txt = goutil.findChildTextComponent(mainGo, "imgHead/imgLock/txt")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local imgNow = goutil.findChild(mainGo, "imgNow")

	imgLock_txt.text = data.lockTips
	txtName.text = data.name

	local modelCo = CharacterConfig.instance:getModelCo(data.skinId)
	local path = GameUrl.getCharacterIconUrl(modelCo.headName)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, path)
	GameUtil.SetActive(imgLock, not isUnlock)
	GameUtil.SetActive(imgNow, isUnlock)
	GameUtil.addClickHandler(imgHead, GameUtil.handler(self._onClickPartCell, self, dayIndex))
end

function FamilyHoudingClgMainView:_clearPartCell(mainGo)
	local imgHead = goutil.findChild(mainGo, "imgHead")
	local icon = goutil.findChild(mainGo, "imgHead/icon")

	GameUtil.rmClickHandler(imgHead)
	uGuiUtil.clearImage(icon)
end

function FamilyHoudingClgMainView:_onClickPartCell(dayIndex)
	local result, tips = FamilyHoudingClgController:getTryEnterStageViewResultAndTips(self._fhId, dayIndex)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.FamilyHoudingClgStageView, self._fhId, dayIndex)
end

function FamilyHoudingClgMainView:_onUpdateRuleColUI()
	self._curRankType = self._curRankType or FhcEnum.RankType_Family

	GameUtil.setUIGroupIdx(self._btnFamily, self._curRankType == FhcEnum.RankType_Family and 0 or 1)
	GameUtil.setUIGroupIdx(self._btnPerson, self._curRankType == FhcEnum.RankType_Persion and 0 or 1)

	local rankInfoList = FamilyHoudingClgController.instance:getRankInfoListOfTopN(self._curRankType)

	self._rankScrollList:reloadData(rankInfoList)

	local isEmpty = #rankInfoList <= 0

	GameUtil.SetActive(self._emptyGo, isEmpty)

	if self._curRankType == FhcEnum.RankType_Family then
		self._emptyGo_txt.text = "暂无家族上榜"
	elseif self._curRankType == FhcEnum.RankType_Persion then
		self._emptyGo_txt.text = "暂无人上榜"
	end
end

function FamilyHoudingClgMainView:_onClearRuleCol()
	self._rankScrollList:dispose()
end

function FamilyHoudingClgMainView:_updateRankCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local rank = info.rank
	local name = info.name
	local score = info.score
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")

	txtRank.text = info.rank

	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	txtName.text = name
	txtScore.text = score
end

function FamilyHoudingClgMainView:_clearRankCell(cell)
	return
end

function FamilyHoudingClgMainView:_onClickBtnChangeRank(rankType)
	self._curRankType = rankType

	self:_onUpdateRuleColUI()
end

function FamilyHoudingClgMainView:_onClickBtnDetail()
	UIStateManager.instance:push(ViewName.FamilyHoudingClgTabFrameView, self._fhId)
end

function FamilyHoudingClgMainView:_onClickBtnTip()
	local key = FamilyHoudingClgConfig.instance:getFhCommonValue(self._fhId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

return FamilyHoudingClgMainView
