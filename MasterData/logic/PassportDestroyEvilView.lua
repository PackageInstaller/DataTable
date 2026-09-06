-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/destroyevil/PassportDestroyEvilView.lua

module("logic.extensions.passport.view.destroyevil.PassportDestroyEvilView", package.seeall)

local PassportDestroyEvilView = class("PassportDestroyEvilView", ViewComponent)

function PassportDestroyEvilView:ctor()
	PassportDestroyEvilView.super.ctor(self)
end

function PassportDestroyEvilView:bindEvents()
	PassportDestroyEvilView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnBuyPassport, self._onClickBuyPassport, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
	GameUtil.addClickHandler(self._btnLock, self._onClickBuyPassport, self)
	GameUtil.addClickHandler(self._btnBuyLevel, self._onClickBuyLevel, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickPetInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnFind, self._onClickFind, self)
end

function PassportDestroyEvilView:unbindEvents()
	PassportDestroyEvilView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnBuyPassport)
	GameUtil.rmClickHandler(self._btnOneKey)
	GameUtil.rmClickHandler(self._btnLock)
	GameUtil.rmClickHandler(self._btnBuyLevel)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnFind)
	self:_rmExtraClickHandler()
end

function PassportDestroyEvilView:buildUI()
	PassportDestroyEvilView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._txtTime = self:getTxt("time/txt")
	self._effect = self:getGo("effect")
	self._goMid = self:getGo("mid")
	self._goTable = goutil.findChild(self._goMid, "tableview")
	self._goCell = goutil.findChild(self._goMid, "tablecell")
	self._extraPart = goutil.findChild(self._goMid, "extraPart")
	self._tableView = ScrollerList.create(self._goTable, {
		self._goCell,
		self._extraPart
	}, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableView:regGetTagByIdx(GameUtil.handler(self.getTagByData, self))
	self._tableView:regGetCellSize(GameUtil.handler(self.getCellSize, self))

	self._txtTip = self:getTxt("txtTip")
	self._objBtnLock = self:getGo("mid/LeftBottom/iconBottom/btnLock")
	self._btnLock = self:getBtn("mid/LeftBottom/iconBottom/btnLock")
	self._sldProgress = self:getSlider("mid/sldProgress")
	self._txtProgress = self:getTxt("mid/sldProgress/txtValue")
	self._txtLevel = self:getTxt("mid/txtProgress")
	self._btnFind = self:getBtn("mid/btnFind")
	self._btnBuyLevel = self:getBtn("mid/btnBuyLevel")
	self._goBtnBuyLevel = self:getGo("mid/btnBuyLevel")
	self._btnOneKey = self:getBtn("btn/btnOneKey")
	self._rpOneKey = goutil.findChild(self._btnOneKey, "imgredpoint")
	self._boBtnBuyPassport = self:getGo("btn/btnBuyPassport")
	self._btnBuyPassport = self:getBtn("btn/btnBuyPassport")
	self._petInfo = self:getGo("petInfo")
	self._pet = goutil.findChild(self._petInfo, "pet")
	self._txtDesc = self:getTxt("petInfo/tip/txtDesc")
	self._goBtnSkill = self:getGo("petInfo/btnSkill")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._goName = self:getGo("petInfo/name")
	self._txtName = self:getTxt("petInfo/name/txtName")
	self._rarePoint = self:getGo("petInfo/name/imgRare")
	self._goQuality = self:getGo("petInfo/name/imgSkinQuality")
	self._goBtnInfo = self:getGo("petInfo/name/btnInfo")
	self._btnInfo = self:getBtn("petInfo/name/btnInfo")
	self._btnFindRP = self:getGo("mid/btnFind/redpoint")
	self._btnOneKeyRP = self:getGo("btnOneKey/imgredpoint")
	self._btnReceiveRP = self:getGo("petInfo/tip/btnReceive/redpoint")
	self._viewRectTr = self:getGo("mid/tableview/Viewport"):GetComponent(goutil.Type_RectTransform)

	goutil.setActive(self._goQuality, false)
end

function PassportDestroyEvilView:onEnter()
	PassportDestroyEvilView.super.onEnter(self)

	self._passPortFuncId = 18

	GlobalDispatcher:addListener(GlobalNotify.PassportStateUpdate, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.PassportExtraPrizeUpdate, self._refreshView, self)
	RedPointController.instance:regRedPoint(self._rdTask, RedPointModel.ID_PASSPORT_DESTROYEVIL)
	PassportController.instance:sendGetInfoReq(self._passPortFuncId)

	self._activityId = DestroyEvilModel.instance:getActivityId()

	if self._activityId == nil or self._activityId == 0 then
		FloatWordMgr.instance:show(lang("不在活动时间内"))
		self:close()

		return
	end

	self._actCfg = DestroyEvilConfig.instance:getActivityCfg(self._activityId)
	self._timeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.DestroyEvil, self._activityId)

	local startTime = GameUtil.string2date(self._timeCfg.startTime)
	local endTime = GameUtil.string2date(self._timeCfg.endTime)

	self._txtTime.text = langPara("活动时间：%d.%d.%d-%d.%d", startTime.year, startTime.month, startTime.day, endTime.month, endTime.day)

	self._sldProgress:SetValue(0)

	self._txtProgress.text = ""

	goutil.setActive(self._extraPart, false)

	self._ableToClick = true
	self._skinId = nil
	self._proEffList = {}
end

function PassportDestroyEvilView:onExit()
	PassportDestroyEvilView.super.onExit(self)
	self._tableView:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PassportStateUpdate, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PassportExtraPrizeUpdate, self._refreshView, self)
	RedPointController.instance:unregRedPoint(self._rdTask)
	MaterialMgr.resetAll(self._rarePoint)

	self._model = nil
end

function PassportDestroyEvilView:_refreshView()
	self._curData = PassportModel.instance:getInfo(self._passPortFuncId)
	self._curData.rewardData = self:_getCurDataList()

	self._tableView:reloadData(self._curData.rewardData)

	local nextLevel = self._curData.nowUnlockLevel + 1
	local nowProgressKey = 0
	local nextProgressKey = 0

	if nextLevel == #self._curData.rewardData then
		nowProgressKey = checknumber(self._curData.rewardData[self._curData.nowUnlockLevel - 1].progressKey)
		nextProgressKey = checknumber(self._curData.rewardData[self._curData.nowUnlockLevel].progressKey)
	elseif self._curData.nowUnlockLevel == 0 then
		nowProgressKey = 0
		nextProgressKey = checknumber(self._curData.rewardData[nextLevel].progressKey)
	else
		nowProgressKey = checknumber(self._curData.rewardData[self._curData.nowUnlockLevel].progressKey)
		nextProgressKey = checknumber(self._curData.rewardData[nextLevel].progressKey)
	end

	local totalProgress = nextProgressKey - nowProgressKey
	local haveProgress = checknumber(self._curData.progress) - nowProgressKey

	self._sldProgress:SetValue(haveProgress / totalProgress)

	self._txtProgress.text = langPara("%d/%d", haveProgress, totalProgress)
	self._txtLevel.text = self._curData.progress
	self._txtTip.text = self._curData.funcCfg.progressTips

	goutil.setActive(self._btnBuy, self._curData.progressAbletToBuy > 0)
	self:_refreshOneKey()
	self:_refreshPayBtn()
	self._tableView:MoveCellToCenter(self._curData.unlockIndex)

	if not self._skinId and checknumber(self._curData.funcCfg.skinId) > 0 then
		self._skinId = self._curData.funcCfg.skinId
	end

	MaterialMgr.resetAll(self._rarePoint)

	if self._skinId then
		self._txtName.text = PetSkinConfig.instance:getPetSkinName(self._skinId)

		MaterialMgr.setCell(MatType.Rare, self._skinId, self._rarePoint)
	end
end

function PassportDestroyEvilView:_refreshPayBtn()
	GameUtil.SetActive(self._btnBuyPassport, not self._curData.hasPay)
	GameUtil.SetActive(self._btnLock, not self._curData.hasPay)
end

function PassportDestroyEvilView:_refreshOneKey()
	self._ableToGetOneKey = false

	for i = 1, self._curData.unlockIndex - 1 do
		if not self._curData.normalPrizeState[i] then
			self._ableToGetOneKey = true

			break
		end

		if self._curData.hasPay and not self._curData.superPrizeState[i] then
			self._ableToGetOneKey = true

			break
		end
	end

	GameUtil.SetActive(self._btnOneKey, self._ableToGetOneKey)
end

function PassportDestroyEvilView:_getCurDataList()
	local dataList = {}

	self._prizeNums = 0
	self._curData.nowUnlockLevel = 0

	for index, v in ipairs(self._curData.prizeCfgs) do
		local data = {}

		data.id = index
		data.progressKey = v.thresholdParam
		data.freePrize = v.freePrize
		data.payedPrize = v.payedPrize
		data.freeState = self._curData.normalPrizeState[index]
		data.superState = self._curData.superPrizeState[index]
		data.isLast = false

		table.insert(dataList, data)

		self._prizeNums = self._prizeNums + 1

		if self._curData.progress >= checknumber(v.thresholdParam) then
			self._curData.nowUnlockLevel = data.id
		end
	end

	table.insert(dataList, {})

	dataList[#dataList].isLast = true

	return dataList
end

function PassportDestroyEvilView:_updateCell(view, goCell, data, tag)
	if tag == 1 then
		local cell = self:_clearCell(goCell)

		cell.txtProgrss.text = data.progressKey

		if not string.nilorempty(data.freePrize) then
			local reward = data.freePrize
			local item = cell.itemList[1]

			self:_setRewardItem(item, reward, data, data.freeState, false)
		end

		local superRewardsCount = 0

		if not string.nilorempty(data.payedPrize) then
			local rewards = string.split(data.payedPrize, "#")
			local reward_1 = rewards[1]
			local item_1 = cell.itemList[2]

			goutil.setActive(item_1.go, reward_1)

			if reward_1 then
				superRewardsCount = 1

				self:_setRewardItem(item_1, reward_1, data, data.superState, true)
			end

			local reward_2 = rewards[2]
			local item_2 = cell.itemList[3]

			goutil.setActive(item_2.go, reward_2)

			if reward_2 then
				superRewardsCount = 2

				self:_setRewardItem(item_2, reward_2, data, data.superState, true)
			end
		end

		cell.itemsLayout.layoutOption = superRewardsCount == 2 and UILayoutSingleLine.LayoutOption.VerticalCenter or UILayoutSingleLine.LayoutOption.TopDown

		cell.itemsLayout:Layout()
	elseif tag == 2 then
		local extraCfg = PassportConfig.instance:getExtraPrizeCfgByActId(self._curData.actId)

		self:_rmExtraClickHandler()

		self._btnGetExtra = goutil.findChildButtonComponent(goCell, "btnGet")
		self._btnRuleExtra = goutil.findChildButtonComponent(goCell, "btnRule")

		GameUtil.addClickHandler(self._btnGetExtra, GameUtil.handler(self._onClickGetExtra, self, goCell))
		GameUtil.addClickHandler(self._btnRuleExtra, self._onClickRuleExtra, self)

		local txtProgressExtra = goutil.findChildTextComponent(goCell, "txtProgress")

		txtProgressExtra.text = self._curData.usefulProgress .. "/" .. extraCfg.consumeProcess
	end
end

function PassportDestroyEvilView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtProgrss = goutil.findChildTextComponent(cell.go, "txtProgress")

	local goLayout = goutil.findChild(cell.go, "layout")

	if goLayout then
		cell.itemsLayout = goLayout:GetComponent(ComponentType.UILayoutSingleLine)
	end

	cell.itemList = {}

	for i = 1, 3 do
		local itemcell = {}

		itemcell.go = i == 1 and goutil.findChild(cell.go, "item_" .. i) or goutil.findChild(cell.go, "layout/item_" .. i)

		if not itemcell.go then
			return cell
		end

		itemcell.rp = goutil.findChild(itemcell.go, "redPoint")
		itemcell.recieve = goutil.findChild(itemcell.go, "recieve")
		itemcell.imgPassed = goutil.findChild(itemcell.recieve, "imgPassed")
		itemcell.item = goutil.findChild(itemcell.go, "cellPoint")

		MaterialMgr.resetAll(itemcell.item)
		goutil.setActive(itemcell.recieve, false)
		goutil.setActive(itemcell.rp, false)

		cell.itemList[i] = itemcell

		UIEffectManager.instance:stopEffect(self._proEffList[itemcell.go])

		self._proEffList[itemcell.go] = nil
	end

	return cell
end

function PassportDestroyEvilView:_rmExtraClickHandler()
	if self._btnGetExtra then
		GameUtil.rmClickHandler(self._btnGetExtra)

		self._btnGetExtra = nil
	end

	if self._btnRuleExtra then
		GameUtil.rmClickHandler(self._btnRuleExtra)

		self._btnRuleExtra = nil
	end
end

function PassportDestroyEvilView:_setRewardItem(item, reward, data, isReceive, isSuper)
	local proxy = MaterialMgr.setCellByCfg(reward, item.item)
	local isUnlock = data.id <= self._curData.nowUnlockLevel and not isReceive

	if isSuper then
		isUnlock = isUnlock and self._curData.hasPay
	end

	goutil.setActive(item.recieve, isReceive)
	goutil.setActive(item.imgPassed, isReceive)

	if isUnlock then
		goutil.setActive(item.rp, true)
		proxy:setAutoTips(false)
		proxy:setCallBack(function()
			PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, isSuper)
		end)
	else
		proxy:setAutoTips(true)
	end

	self:_setItemEffect(isUnlock, item.go, item.item)
end

function PassportDestroyEvilView:_setItemEffect(isShow, mainGo, effGo)
	UIEffectManager.instance:stopEffect(self._proEffList[mainGo])

	self._proEffList[mainGo] = nil

	if isShow then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

		local function func(_, eff)
			eff:setParent(effGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
			eff:setClipping(self._viewRectTr)
		end

		self._proEffList[mainGo] = UIEffectManager.instance:playEffect(self, effPath, effGo, 0, 0, true, false, nil, func, nil)
	end
end

function PassportDestroyEvilView:_onClickHelp()
	ViewMgr.instance:open(ViewName.RulesView, self._curData.funcCfg.rule)
end

function PassportDestroyEvilView:_onClickOneKey()
	if self._ableToGetOneKey then
		PassportController.instance:sendOneKeyGainPrizeReq(self._curData.actId, self._curData.funcId)

		return
	end

	if not self._curData.hasPay and self._curData.nowUnlockLevel > 0 then
		self:_onClickBuyPassport()

		return
	end

	FloatWordMgr.instance:show(lang("当前无可领取奖励"))
end

function PassportDestroyEvilView:_onClickBuyPassport()
	local data1, data2, data3, num = PassportModel.instance:getCurDataList(nil, self._curData.funcId)

	if not self._curData.hasPay then
		UIStateManager.instance:push(ViewName.PassportDestroyEvilBuyView, self._curData.actCfg, self._curData.funcCfg)
	else
		FloatWordMgr.instance:show("已经购买过进阶战令了")
	end
end

function PassportDestroyEvilView:_onClickGetExtra()
	if self._curData then
		local extraCfg = PassportConfig.instance:getExtraPrizeCfgByActId(self._curData.actId)

		self._extraPrize = string.split(extraCfg.prize, "#")[1]

		if self._curData.usefulProgress >= extraCfg.consumeProcess then
			PassportController.instance:sendGainExtraPrize(self._curData.actId, self._curData.funcId)
		else
			CommonTipsMgr.instance:openTipsByConfStr(self._btnGetExtra.gameObject, self._extraPrize)
		end
	end
end

function PassportDestroyEvilView:_onClickRuleExtra()
	UIStateManager.instance:push(ViewName.RulesView, "zhanling_rule")
end

function PassportDestroyEvilView:_onClickBuyLevel()
	if self._curData then
		if self._curData.progressAbletToBuy <= 0 then
			FloatWordMgr.instance:show("已经达到最大购买等级次数, 无法再购买等级")
		elseif checkint(self._curData.progress) >= checkint(self._curData.rewardData[#self._curData.rewardData - 1].progressKey) then
			FloatWordMgr.instance:show("已经达到最大等级, 无法再购买等级")
		end
	end
end

function PassportDestroyEvilView:_onClickPetInfo()
	if self._skinId then
		PetbookController.instance:openPetinfoView(self._skinId)
	end
end

function PassportDestroyEvilView:_onClickSkill()
	if self._skinId then
		PetbookController.instance:previewBattle(self._skinId)
	end
end

function PassportDestroyEvilView:_onClickFind()
	UIStateManager.instance:push(ViewName.DestroyEvilMainView)
end

function PassportDestroyEvilView:getTagByData(data, idx)
	return data.isLast and 2 or 1
end

function PassportDestroyEvilView:getCellSize(view, idx)
	if self._curData.rewardData[idx + 1].isLast then
		return 216, 432
	end

	return 124, 432
end

return PassportDestroyEvilView
