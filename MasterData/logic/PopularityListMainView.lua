-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/popularitylist/view/PopularityListMainView.lua

module("logic.extensions.popularitylist.view.PopularityListMainView", package.seeall)

local PopularityListMainView = class("PopularityListMainView", ViewComponent)
local CardType = {
	Painter = 2,
	Pet = 1,
	Input = 3
}

function PopularityListMainView:buildUI()
	PopularityListMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "leftTime/txt")
	self._txtRemainTimes = goutil.findChildTextComponent(self.mainGO, "txtRemainTimes")
	self._txtPeriod = goutil.findChildTextComponent(self.mainGO, "period/txt")
	self._btnReward = goutil.findChild(self.mainGO, "btnReward")
	self._btnReward_redpoint = goutil.findChild(self.mainGO, "btnReward/redpoint")
	self._tabScrollerview = goutil.findChild(self.mainGO, "tabCol/tabScrollerview")
	self._tabScrollercell = goutil.findChild(self.mainGO, "tabCol/tabScrollercell")
	self._voteScrollerview = goutil.findChild(self.mainGO, "voteCol/voteScrollerview")
	self._voteScrollercell = goutil.findChild(self.mainGO, "voteCol/voteScrollercell")
	self.parentGo = self:getGo("horizontalCol")
	self.cell = self:getGo("horizontalColCell")
	self.page = PageStackComponent.New()

	self.page:init(self.parentGo, self.cell, 1600, 622, 5)
	self.page:setCallBack(GameUtil.handler(self.updateSkinCell, self), GameUtil.handler(self.selectSkinEnd, self), GameUtil.handler(self.clearSkinCell, self))

	self._horizontalCol = self:getGo("horizontalCol")
	self._voteCol = self:getGo("voteCol")
	self._tabScrollList = ScrollerList.create(self._tabScrollerview, self._tabScrollercell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._voteScrollList = ScrollerList.create(self._voteScrollerview, self._voteScrollercell, GameUtil.handler(self._updateVoteCell, self), GameUtil.handler(self._clearVoteCell, self))

	self._voteScrollList:regValueChanged(GameUtil.handler(self._onVoteScrollValueChanged, self))

	self._txtTipsGo = self:getGo("txtTips")
	self._txtVipTipsGo = self:getGo("txtVipTips")
	self._txtVipTipsGo2 = self:getGo("txtVipTips2")
	self._btnFameHall = self:getGo("btnFameHall")
	self._imgTitle = self:getGo("imgTitle")
	self._btnFameHall_redpoint = self:getGo("btnFameHall/redpoint")
end

function PopularityListMainView:bindEvents()
	PopularityListMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickBtnReward, self)
	GameUtil.addClickHandler(self._btnFameHall, self._onClickBtnFameHall, self)
end

function PopularityListMainView:unbindEvents()
	PopularityListMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReward)
	GameUtil.rmClickHandler(self._btnFameHall)
end

function PopularityListMainView:onEnter()
	PopularityListMainView.super.onEnter(self)

	self._activityId = PopularityListController.instance:getCurActivityId()

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失活动id")

		return
	end

	self.addGEvent(self, GlobalNotify.PM_FameHallVoteGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PopularityListGetSkinVoteCountsRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PopularityListSkinVoteRes, self._onVoteRes, self)

	local key = GameEnum.PopularityList.First .. self._activityId

	if checknumber(GameUtil.getUserData(key)) == 0 then
		UIStateManager.instance:push(ViewName.DialogueView, PopularityListConfig.instance:getTextValue("DIALOG_1"))
		GameUtil.saveUserData(key, 1)
	end

	self._curTabIndex = self._curTabIndex or 1
	self._actCfg = PopularityListConfig.instance:getPlActData(self._activityId)
	self._actCfg = PopularityListConfig.instance:getPlActData(self._activityId)
	self._fameHallCfg = FameHallVoteConfig.instance:getActCfg(self._actCfg.fameHallActId)

	RedPointController.instance:regRedPoint(self._btnReward_redpoint, RedPointModel.ID_Popularity_Login)
	self:_sendInfoReq()
	self:_startTimer()

	local titlePos = self._actCfg.titlePos

	if titlePos ~= nil then
		GameUtil.setLocalPos(self._imgTitle, titlePos[1], titlePos[2], 0)
	end

	GameUtil.SetActive(self._imgTitle, titlePos ~= nil)
	FameHallVoteController.instance:sendPM_FameHallVoteGetInfoReq(self._actCfg.fameHallActId)
end

function PopularityListMainView:onExit()
	PopularityListMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._btnReward_redpoint)
	removetimer(self._ticking, self)
	GlobalDispatcher:removeListener(GlobalNotify.PopularityListGetSkinVoteCountsRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PopularityListSkinVoteRes, self._sendInfoReq, self)
	self._tabScrollList:dispose()
	self._voteScrollList:dispose()
	self.page:clearUI()
	PopularityListController.instance:setHasVoted(false)

	self._selectId = 0
end

function PopularityListMainView:_sendInfoReq()
	PopularityListController.instance:sendPM_GetSkinVoteCountsReq(self._activityId)
end

function PopularityListMainView:_onVoteRes()
	PopularityListController.instance:setHasVoted(true)
	self:_sendInfoReq()
end

function PopularityListMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function PopularityListMainView:_onUpdateData()
	self._fameHallInfo = FameHallVoteModel.instance:getInfo(self._actCfg.fameHallActId)

	self:_onUpdateTabColData()
	self:_onUpdateVoteColData()
end

function PopularityListMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_onUpdateTabColUI()
	self:_onUpdateVoteColUI()
	self:_updateButtomTip()
	self:_updateRedPointUI()
end

function PopularityListMainView:_updateRedPointUI()
	GameUtil.SetActive(self._btnFameHall_redpoint, false)

	if self._fameHallInfo then
		local dailyVotePlayers = self._fameHallInfo.dailyVotePlayers
		local voteNum = #dailyVotePlayers
		local dailyVoteTimes = self._fameHallCfg.dailyVoteTimes
		local finishShowFameHall = dailyVoteTimes <= voteNum

		GameUtil.SetActive(self._btnFameHall_redpoint, not finishShowFameHall)
	end
end

function PopularityListMainView:_onUpdatePlaneUI()
	local tabInfo = self:_getTabViewInfo(self._curTabIndex)
	local data = tabInfo.data
	local remainTimes = PopularityListController.instance:getRemainTimes(self._activityId, data.type)

	self._txtRemainTimes.text = string.format("剩余投票次数:<color=#20B376FF>%s</color>次", remainTimes)

	local season = PopularityListController.instance:getWhatSeason(self._activityId)

	self._txtPeriod.text = string.format("第%s期", season)
end

function PopularityListMainView:_onUpdateTabColData()
	self._tabInfoList = {}

	local baseCfg = PopularityListConfig.instance:getPlBaseCfg(self._activityId)

	for _, data in pairs(baseCfg) do
		local info = {}

		info.data = data
		info.isNeedRed = PopularityListController.instance:getRemainTimes(self._activityId, data.type) > 0

		table.insert(self._tabInfoList, info)
	end

	table.sort(self._tabInfoList, function(a, b)
		if a.data.sortIdx == b.data.sortIdx then
			return false
		end

		return a.data.sortIdx < b.data.sortIdx
	end)

	self._curTabIndex = self._curTabIndex or 1
end

function PopularityListMainView:_getTabViewInfo(tabIndex)
	return self._tabInfoList[tabIndex]
end

function PopularityListMainView:_onUpdateTabColUI()
	self._tabScrollList:reloadData(self._tabInfoList)

	if self._curTabIndex > 0 then
		local idx = self._curTabIndex - 1
		local isMotion = true

		self._tabScrollList:MoveCellInView(idx, isMotion)
	end
end

function PopularityListMainView:_updateTabCell(view, cell, info, tag)
	local data = info.data
	local isNeedRed = info.isNeedRed
	local tabIndex = cell.index + 1
	local mainGo = cell.gameObject
	local imgSelect = goutil.findChild(mainGo, "imgSelect")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local redpoint = goutil.findChild(mainGo, "redpoint")

	GameUtil.SetActive(imgSelect, tabIndex == self._curTabIndex)
	GameUtil.SetActive(redpoint, isNeedRed)

	txtName.text = data.title or tabIndex

	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._clickTabCell, self, mainGo, tabIndex))
end

function PopularityListMainView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function PopularityListMainView:_clickTabCell(mainGo, tabIndex)
	if self._curTabIndex == tabIndex then
		return
	end

	PopularityListController.instance:setHasVoted(false)

	self._selectId = 0
	self._curTabIndex = tabIndex

	self:_onUpdateUI()
	self:_updateButtomTip()
end

function PopularityListMainView:_updateButtomTip()
	local tabInfo = self:_getTabViewInfo(self._curTabIndex)
	local data = tabInfo.data
	local type = data.type
	local cfg = PopularityListConfig.instance:getPlBaseData(self._activityId, type)
	local isVipPlan = cfg.vipTimesPlanId ~= 0

	GameUtil.SetActive(self._txtTipsGo, not isVipPlan)
	GameUtil.SetActive(self._txtVipTipsGo, isVipPlan)
	GameUtil.SetActive(self._txtVipTipsGo2, isVipPlan)
	GameUtil.SetActive(self._btnReward, not isVipPlan)
	GameUtil.SetActive(self._btnFameHall, self._actCfg.fameHallActId > 0 and not isVipPlan)
end

function PopularityListMainView:_onVoteScrollValueChanged(tableview)
	local viewPortTrans = tableview:GetViewport()
	local content = tableview:GetContent()
	local conX, _, _ = Framework.TransformUtil.GetLocalPos(content.transform, 0, 0, 0)
	local width = goutil.getWidth(viewPortTrans)
	local ofh = 20
	local hw = width * 0.5
	local R = ofh + hw * hw / ofh
	local r = R * 0.5
	local a = hw
	local b = -r + ofh
	local count = tableview:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableview:GetCellByIndex(i)

		if cell then
			local locx, locy, locz = Framework.TransformUtil.GetLocalPos(cell.transform, 0, 0, 0)
			local ofx = conX + locx
			local xx = ofx - a
			local ta = math.atan2(-b, xx)
			local yy = r * math.sin(ta) + b
			local angle = math.deg(ta)
			local cellContent = goutil.findChild(cell, "content")

			GameUtil.setLocalPos(cellContent.transform, 0, yy, 0)
			GameUtil.setLocalRotation(cellContent, 0, 0, angle - 90)
		end
	end
end

function PopularityListMainView:_onUpdateVoteColData()
	self._voteInfoListGroup = {}

	for tabIndex, tabInfo in ipairs(self._tabInfoList) do
		local itemCfg = PopularityListConfig.instance:getPlItemCfgByType(self._activityId, tabInfo.data.type)
		local infoList = {}

		for _, data in ipairs(itemCfg) do
			local info = {}

			info.data = data
			info.voteCount = PopularityListModel.instance:getVoteItemCount(self._activityId, data.id)
			info.rank = 0

			table.insert(infoList, info)
		end

		table.sort(infoList, function(a, b)
			if a.voteCount == b.voteCount then
				return false
			end

			return a.voteCount > b.voteCount
		end)

		local rankIdx = 1

		for i = 1, #infoList do
			if infoList[i].data.cardType ~= CardType.Input then
				infoList[i].rank = rankIdx
				rankIdx = rankIdx + 1
			end
		end

		for i = #infoList, 2, -1 do
			local j = Mathf.Random(1, i)

			infoList[i], infoList[j] = infoList[j], infoList[i]
		end

		self._voteInfoListGroup[tabIndex] = infoList
	end
end

function PopularityListMainView:_onUpdateVoteColUI()
	local dataList = self._voteInfoListGroup[self._curTabIndex]
	local isVipPlan = self:_isVipPlan()

	GameUtil.SetActive(self._voteCol, not isVipPlan)
	GameUtil.SetActive(self._horizontalCol, isVipPlan)

	if isVipPlan then
		local count = 3

		if #dataList == 1 then
			count = 1
		end

		self.page:setLimitCount((#dataList > 5 or nil) and 5)
		self.page:reloadData(dataList, self._curIndex)
	else
		self._voteScrollList:reloadData(dataList)
	end

	local hasVoted = PopularityListController.instance:getHasVoted()
	local isVipPlan = self:_isVipPlan()

	if self._curTabIndex > 0 then
		local idx = Mathf.Max(checkint(#dataList / 2) - 1, 0)

		if not ((isVipPlan or nil) and not hasVoted) then
			for i, info in ipairs(dataList) do
				local data = info.data

				if data.id == self._selectId then
					idx = i
				end
			end

			self.page:moveToIdx(idx)
		end

		local isMotion = true

		self._voteScrollList:MoveCellToCenter(idx, isMotion)
	end
end

function PopularityListMainView:_updateVoteCell(view, cell, info, tag)
	local mainGo = cell.gameObject
	local painterMainGo = goutil.findChild(mainGo, "content/painter")
	local petMainGo = goutil.findChild(mainGo, "content/pet")
	local inputMainGo = goutil.findChild(mainGo, "content/input")

	GameUtil.SetActive(painterMainGo, false)
	GameUtil.SetActive(petMainGo, false)
	GameUtil.SetActive(inputMainGo, false)

	local cardType = info.data.cardType

	if cardType == CardType.Pet then
		self:_updateVoteCellAsPet(petMainGo, info)
	elseif cardType == CardType.Painter then
		self:_updateVoteCellAsPainter(painterMainGo, info)
	elseif cardType == CardType.Input then
		self:_updateVoteCellAsInput(inputMainGo, info)
	else
		printError(string.format("错误:没有设置卡片类型( yh-运营-画师皮肤投票.xlsx | export_投票名单 | activityId=%s, id=%s )", self._activityId, info.data.id))
	end
end

function PopularityListMainView:_clearVoteCell(cell)
	local mainGo = cell.gameObject
	local painterMainGo = goutil.findChild(mainGo, "content/painter")
	local petMainGo = goutil.findChild(mainGo, "content/pet")
	local inputMainGo = goutil.findChild(mainGo, "content/input")

	self:_clearVoteCellAsPainter(painterMainGo)
	self:_clearVoteCellAsPet(petMainGo)
	self:_clearVoteCellAsInput(inputMainGo)
end

function PopularityListMainView:_updateVoteCellAsPainter(mainGo, info)
	local data = info.data

	GameUtil.SetActive(mainGo, true)

	local con = goutil.findChild(mainGo, "con")
	local rankGo = goutil.findChild(mainGo, "rank")
	local txtRankNum = goutil.findChildTextComponent(mainGo, "rank/num/txt")
	local rankChangeGroup = goutil.findChildComponent(mainGo, "rank/num", ComponentType.UIChangeGroup)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local btnVote = goutil.findChild(mainGo, "btnVote")
	local btnVoteChange = btnVote:GetComponent(ComponentType.UIImageSpriteChange)
	local txtVoteNum = goutil.findChildTextComponent(mainGo, "txtVoteNum")
	local head = goutil.findChild(mainGo, "head/con")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local detailData = PopularityListConfig.instance:getPlItemDetailData(data.raceOrSkinId)

	if detailData == nil then
		printError("画师类型,但没有找到画师配置")

		return
	end

	local petName = self:_getPetName(info.data)

	txtName.text = petName
	txtVoteNum.text = info.voteCount

	local imgUrl = self:_getPetImgUrl(info.data)

	if not string.nilorempty(imgUrl) then
		uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, imgUrl)
	end

	local rank = info.rank

	if rank <= 3 then
		rankChangeGroup:SetState(rank - 1)

		txtRankNum.text = rank
	end

	GameUtil.SetActive(rankGo, rank <= 3)

	local isHasVote = PopularityListController.instance:isHasVoteTheItem(self._activityId, data.type, data.id)

	btnVoteChange:SetState(isHasVote and 1 or 0)

	txtDesc.text = detailData.painterStyle

	uGuiUtil.setSpriteToImage(head, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(detailData.painterIcon))
	GameUtil.addClickHandler(con, function()
		UIStateManager.instance:push(ViewName.PopularityPainterView, detailData.skinId)
	end)
	GameUtil.addClickHandler(btnVote, function()
		local isVipPlan = self:_isVipPlan()
		local result, tips = PopularityListController.instance:getVoteTheItemResultAndTips(self._activityId, data.type, data.id, isVipPlan)

		FloatWordMgr.instance:show(tips)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		local tipsContent = PopularityListConfig.instance:getTextValue("TEXT_4", detailData.painterName, petName, 1)

		local function okFunc()
			PopularityListController.instance:sendPM_SkinVoteReq(self._activityId, data.id)
		end

		local function cencelFunc()
			return
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), tipsContent, okFunc, cencelFunc, "确定", "取消")
	end)
end

function PopularityListMainView:_clearVoteCellAsPainter(mainGo)
	local con = goutil.findChild(mainGo, "con")
	local btnVote = goutil.findChild(mainGo, "btnVote")

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(con)
	GameUtil.rmClickHandler(btnVote)
end

function PopularityListMainView:_updateVoteCellAsPet(mainGo, info)
	local data = info.data

	GameUtil.SetActive(mainGo, true)

	local con = goutil.findChild(mainGo, "con")
	local rankGo = goutil.findChild(mainGo, "rank")
	local txtRankNum = goutil.findChildTextComponent(mainGo, "rank/num/txt")
	local rankChangeGroup = goutil.findChildComponent(mainGo, "rank/num", ComponentType.UIChangeGroup)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local btnVote = goutil.findChild(mainGo, "btnVote")
	local btnVoteChange = btnVote:GetComponent(ComponentType.UIImageSpriteChange)
	local txtVoteNum = goutil.findChildTextComponent(mainGo, "txtVoteNum")
	local head = goutil.findChild(mainGo, "head/con")
	local petName = self:_getPetName(info.data)

	txtName.text = petName
	txtVoteNum.text = info.voteCount

	local imgUrl = self:_getPetImgUrl(info.data)

	if not string.nilorempty(imgUrl) then
		uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, imgUrl)
	end

	local rank = info.rank

	if rank <= 3 then
		rankChangeGroup:SetState(rank - 1)

		txtRankNum.text = rank
	end

	GameUtil.SetActive(rankGo, rank <= 3)

	local isHasVote = PopularityListController.instance:isHasVoteTheItem(self._activityId, data.type, data.id)

	btnVoteChange:SetState(isHasVote and 1 or 0)
	GameUtil.addClickHandler(con, function()
		if data.raceOrSkinId > 0 then
			UIStateManager.instance:push(ViewName.PopularityPetView, data.raceOrSkinId)
		end
	end)
	GameUtil.addClickHandler(btnVote, function()
		local isVipPlan = self:_isVipPlan()
		local result, tips = PopularityListController.instance:getVoteTheItemResultAndTips(self._activityId, data.type, data.id, isVipPlan)

		FloatWordMgr.instance:show(tips)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		local isVipPlan = self:_isVipPlan()
		local tipsContent = PopularityListConfig.instance:getTextValue("TEXT_3", petName, 1)

		if isVipPlan then
			local arr = string.split(tipsContent, "\n")

			tipsContent = arr and arr[1] or ""
			tipsContent = tipsContent .. "\n注：同一只精灵可多次重复投票"
		end

		local function okFunc()
			PopularityListController.instance:sendPM_SkinVoteReq(self._activityId, data.id)
		end

		local function cencelFunc()
			return
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), tipsContent, okFunc, cencelFunc, "确定", "取消")
	end)
end

function PopularityListMainView:_clearVoteCellAsPet(mainGo)
	local con = goutil.findChild(mainGo, "con")
	local btnVote = goutil.findChild(mainGo, "btnVote")

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(con)
	GameUtil.rmClickHandler(btnVote)
end

function PopularityListMainView:_updateVoteCellAsInput(mainGo, info)
	local data = info.data

	GameUtil.SetActive(mainGo, true)

	local con = goutil.findChild(mainGo, "con")

	GameUtil.addClickHandler(con, function()
		local isVipPlan = self:_isVipPlan()
		local result, tips = PopularityListController.instance:getVoteTheItemResultAndTips(self._activityId, data.type, data.id, isVipPlan)

		FloatWordMgr.instance:show(tips)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		UIStateManager.instance:push(ViewName.PopularityInputView, self._activityId, data.id)
	end)
end

function PopularityListMainView:_clearVoteCellAsInput(mainGo)
	local con = goutil.findChild(mainGo, "con")

	GameUtil.rmClickHandler(con)
end

function PopularityListMainView:_updateVoteCellAsLandscape(mainGo, info, page, idx, isEnd)
	local data = info.data

	GameUtil.SetActive(mainGo, true)

	local con = goutil.findChild(mainGo, "con")
	local rankGo = goutil.findChild(mainGo, "rank")
	local txtRankNum = goutil.findChildTextComponent(mainGo, "rank/num/txt")
	local rankChangeGroup = goutil.findChildComponent(mainGo, "rank/num", ComponentType.UIChangeGroup)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local btnVote = goutil.findChild(mainGo, "btnVote")
	local btnVoteChange = btnVote:GetComponent(ComponentType.UIImageSpriteChange)
	local txtVoteNum = goutil.findChildTextComponent(mainGo, "txtVoteNum")
	local head = goutil.findChild(mainGo, "head/con")
	local top = goutil.findChild(mainGo, "top")
	local petName = self:_getPetName(info.data)

	txtName.text = petName
	txtVoteNum.text = info.voteCount

	local imgUrl = self:_getLandscapeImgUrl(info.data)

	if not string.nilorempty(imgUrl) then
		uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, imgUrl)
	end

	local rank = info.rank

	if rank <= 3 then
		rankChangeGroup:SetState(rank - 1)

		txtRankNum.text = rank
	end

	GameUtil.SetActive(rankGo, rank <= 3)

	local isHasVote = PopularityListController.instance:isHasVoteTheItem(self._activityId, data.type, data.id)

	btnVoteChange:SetState(isHasVote and 1 or 0)

	if isEnd then
		GameUtil.SetActive(top, page.targetIdx ~= idx)
	else
		GameUtil.SetActive(top, true)
	end

	GameUtil.addClickHandler(con, function()
		if data.raceOrSkinId > 0 then
			UIStateManager.instance:push(ViewName.PopularityPetView, data.raceOrSkinId)
		end
	end)
	GameUtil.addClickHandler(btnVote, function()
		local isVipPlan = self:_isVipPlan()
		local result, tips = PopularityListController.instance:getVoteTheItemResultAndTips(self._activityId, data.type, data.id, isVipPlan)

		FloatWordMgr.instance:show(tips)

		if result ~= GameEnum.ResultCode.Success then
			return
		end

		local isVipPlan = self:_isVipPlan()
		local tipsContent = PopularityListConfig.instance:getTextValue("TEXT_3", petName, 1)

		if isVipPlan then
			local arr = string.split(tipsContent, "\n")

			tipsContent = arr and arr[1] or ""
			tipsContent = tipsContent .. "\n注：同一只精灵可多次重复投票"
		end

		local function okFunc()
			PopularityListController.instance:sendPM_SkinVoteReq(self._activityId, data.id)
		end

		local function cencelFunc()
			return
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), tipsContent, okFunc, cencelFunc, "确定", "取消")
	end)
end

function PopularityListMainView:_clearVoteCellAsLandscape(mainGo)
	local con = goutil.findChild(mainGo, "con")
	local btnVote = goutil.findChild(mainGo, "btnVote")

	uGuiUtil.clearImage(con)
	GameUtil.rmClickHandler(con)
	GameUtil.rmClickHandler(btnVote)
end

function PopularityListMainView:_getPetName(data)
	local petName = ""

	if not string.nilorempty(data.petName) then
		petName = data.petName
	elseif data.raceOrSkinId > 0 then
		petName = PetSkinConfig.instance:getPetSkinName(data.raceOrSkinId)
	end

	return petName
end

function PopularityListMainView:_getPetImgUrl(data)
	local imgUrl = ""

	if not string.nilorempty(data.posterPath) then
		imgUrl = string.format("ui/bigbg/%s.png", data.posterPath)
	elseif data.raceOrSkinId > 0 then
		imgUrl = GameUrl.getLotteryPetImgUrl(data.raceOrSkinId)
	end

	return imgUrl
end

function PopularityListMainView:_getLandscapeImgUrl(data)
	local imgUrl = ""

	if not string.nilorempty(data.posterPath) then
		imgUrl = string.format("ui/bigbg/views/huodong/pifuhuashi/%s.png", data.posterPath)
	elseif data.raceOrSkinId > 0 then
		imgUrl = GameUrl.getLotteryPetImgUrl(data.raceOrSkinId)
	end

	return imgUrl
end

function PopularityListMainView:_startTimer()
	if self._activityId == 0 then
		return
	end

	local activityType = PopularityListController.instance:getCurActivityType()

	self._startStamp, self._endStamp = ActivityDefineController:getStartTimeAndEndTime(activityType, self._activityId)

	settimer(1, self._ticking, self)
end

function PopularityListMainView:_ticking()
	local leftStamp = self._endStamp - ServerTime.now()

	self._txtLeftTime.text = leftStamp > 0 and PopularityListConfig.instance:getTextValue("TEXT_1", GameUtil.FormatTimeSymbol(leftStamp)) or lang("text_activity_end")
end

function PopularityListMainView:clearSkinCell(cell)
	return
end

function PopularityListMainView:updateSkinCell(page, cell, info, idx, isEnd)
	local mainGo = cell.gameObject
	local landscapeMainGo = goutil.findChild(mainGo, "content/landscape")

	GameUtil.SetActive(landscapeMainGo, false)
	self:_updateVoteCellAsLandscape(landscapeMainGo, info, page, idx, isEnd)
	GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickSkinCell, self, idx, info.data))
end

function PopularityListMainView:onClickSkinCell(idx, data)
	if self.page.targetIdx ~= idx then
		self._needCenterOnIndexOnEnd = true

		self.page:moveToIdx(idx)

		self._selectId = data.id
	end
end

function PopularityListMainView:selectSkinEnd(page)
	if self._needCenterOnIndexOnEnd then
		self._needCenterOnIndexOnEnd = false
	end
end

function PopularityListMainView:_isVipPlan()
	local tabInfo = self:_getTabViewInfo(self._curTabIndex)
	local data = tabInfo.data
	local type = data.type
	local cfg = PopularityListConfig.instance:getPlBaseData(self._activityId, type)

	return cfg.vipTimesPlanId ~= 0
end

function PopularityListMainView:_onClickBtnTip()
	local key = PopularityListConfig.instance:getPlCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

function PopularityListMainView:_onClickBtnReward()
	UIStateManager.instance:push(ViewName.PopularityVersionLoginView)
end

function PopularityListMainView:_onClickBtnFameHall()
	UIStateManager.instance:push(ViewName.FameHallVoteView, self._actCfg.fameHallActId)
end

return PopularityListMainView
