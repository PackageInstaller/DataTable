-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/giftbox/view/GiftBoxMainView.lua

module("logic.extensions.giftbox.view.GiftBoxMainView", package.seeall)

local GiftBoxMainView = class("GiftBoxMainView", ViewComponent)

function GiftBoxMainView:ctor()
	GiftBoxMainView.super.ctor(self)
end

function GiftBoxMainView:unbindEvents()
	GiftBoxMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnShare)
	GameUtil.rmClickHandler(self._btnGetLuck)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._petInfo)
	GameUtil.rmClickHandler(self._petTry)
	GameUtil.rmClickHandler(self._btnTips)
	GameUtil.rmClickHandler(self._btnShop)
end

function GiftBoxMainView:bindEvents()
	GiftBoxMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnShare, self._onClickShare, self)
	GameUtil.addClickHandler(self._btnGetLuck, self._onClickGetLuck, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._petInfo, self._onClickPetInfo, self)
	GameUtil.addClickHandler(self._petTry, self._onClickPetTry, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
end

function GiftBoxMainView:buildUI()
	GiftBoxMainView.super.buildUI(self)

	self._btnClose = self:getGo("static/btnClose")
	self._btnTips = self:getGo("static/btnTip")
	self._btnShare = self:getGo("btnShare")
	self._btnShop = self:getGo("btnShop")
	self._redPointShare = self:getGo("btnShare/redPoint")
	self._btnGetLuck = self:getGo("btnGetLuck")
	self._btnTask = self:getGo("btnTask")
	self._redPointTask = self:getGo("btnTask/redPoint")
	self._btnPrize = self:getGo("btnPrize")
	self._redPointPrize = self:getGo("btnPrize/redPoint")
	self._txtTime = self:getTxt("openTime/txt")
	self._tabTableView = self:getGo("boxTabCol/tabScrollerview")
	self._tabTableCell_1 = self:getGo("boxTabCol/tabScrollercell_1")
	self._tabTableCell_2 = self:getGo("boxTabCol/tabScrollercell_2")
	self._boxTableView = self:getGo("boxTableCol/boxScrollerview")
	self._boxTableCell = self:getGo("boxTableCol/boxScrollercell")
	self._unLockGo = self:getGo("boxTableCol/unLock")
	self._txtUnlock = self:getTxt("boxTableCol/unLock/txtDesc")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtScore = self:getTxt("txtScore")
	self._txtScoreTips = self:getTxt("txtScoreTips")
	self._petInfo = self:getBtn("petInfo/btnIntroduce")
	self._petTry = self:getBtn("petInfo/btnSkill")
	self._petRace = self:getGo("petInfo/pointRare")
	self._petGainGo = self:getGo("petInfo/receivedGo")
	self._con = self:getGo("static/bg/con")
	self._txtPetSkinName = self:getTxt("petInfo/txtName")
end

function GiftBoxMainView:onExit()
	GiftBoxMainView.super.onExit(self)
	self._tabTableList:dispose()
	self._boxTableList:dispose()

	if self._raceCon then
		RoleObjectPool.instance:removeRole(self._raceCon)
	end

	RedPointController.instance:unregRedPoint(self._redPointTask)
end

function GiftBoxMainView:onEnter()
	GiftBoxMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handleGB_GiftBoxGetInfoRes, self.refreshView, self)
	self.addGEvent(self, GlobalNotify.handleGB_GiftBoxOpenBoxRes, self.refreshView, self)
	self.addGEvent(self, GlobalNotify.handleGB_GiftBoxGainSharePrizeRes, self.refreshShareRedPoint, self)
	self.addGEvent(self, GlobalNotify.handleGB_GiftBoxGainLuckRes, self.refreshView, self)
	self.addGEvent(self, GlobalNotify.GiftBoxFirstShare, self.refreshView, self)

	self._tabTableList = ScrollerList.create(self._tabTableView, {
		self._tabTableCell_1,
		self._tabTableCell_2
	}, GameUtil.handler(self._updateTabTableCell, self), GameUtil.handler(self._clearTabTableCell, self))
	self._boxTableList = ScrollerList.create(self._boxTableView, self._boxTableCell, GameUtil.handler(self._updateBoxTableCell, self), GameUtil.handler(self._clearBoxTableCell, self))

	self._tabTableList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._tabTableList:regGetCellSize(self._getCellSizeCallBack)

	self._selectTabId = GiftBoxModel.instance:getSelectPool()
	self._actId = GiftBoxModel.instance:getCurActId()

	if checknumber(self._actId) <= 0 then
		FloatWordMgr.instance:show(lang("不在活动时间内"))
		self:close()

		return
	end

	self._actCfg = GiftBoxConfig.instance:getActCfgById(self._actId)
	self._poolCfgs = GiftBoxConfig.instance:getPoolCfgs(self._actId)

	if not goutil.isNil(self._con) then
		RoleObjectPool.instance:addRoleToParent(self._raceCon, self._actCfg.skinId, self._con)
	end

	MaterialMgr.resetAll(self._petRace)
	MaterialMgr.setCell(MatType.PetSkin_Rare, self._actCfg.skinId, self._petRace)
	self:_setTopGoldBar()
	GiftBoxAgent.instance:sendGB_GiftBoxGetInfoReq(self._actId)

	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.GiftBox, self._actId)

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self._actCfg.skinId)

	self._txtPetSkinName.text = skinCfg.skinName

	RedPointController.instance:regRedPoint(self._redPointTask, RedPointModel.ID_RECASTGLORYTASK)
end

function GiftBoxMainView:refreshView()
	self:refreshTabView()
	self:refreshBoxView()

	local boxCfgs = GiftBoxConfig.instance:getBoxTypeCfgs(self._actId)
	local maxBoxType = self._actCfg.superBoxType
	local boxCfg = GiftBoxConfig.instance:getBoxTypeCfg(maxBoxType)
	local superPrezeInfo = GiftBoxModel.instance:getSuperPrizeInfo()
	local superPrizeCfg = GiftBoxConfig.instance:getSuperPrizeCfg(boxCfg.superPrizePlanId)
	local isGainAllSuper = true

	for i, v in ipairs(superPrizeCfg) do
		if not superPrezeInfo[maxBoxType] or not superPrezeInfo[maxBoxType][v.prizeId] then
			isGainAllSuper = false

			break
		end
	end

	self._txtScore.text = langPara("当前欧气值：<color=#E8382FFF>%d</color>", GiftBoxModel.instance:getScore())

	if isGainAllSuper == true then
		self._txtScoreTips.text = lang("你已成为欧皇！现在可以分享欧气给其他小奥奇了")
	else
		local superRateCfg = GiftBoxConfig.instance:getSuperPrizeRate(boxCfg.ratePlan)
		local rate = 0

		for i, v in ipairs(superRateCfg) do
			if v.score <= GiftBoxModel.instance:getScore() then
				rate = v.rate
			else
				break
			end
		end

		self._txtScoreTips.text = langPara("%s%d%%概率开出惊喜大奖", boxCfg.name, rate * 100)
	end

	GameUtil.SetActive(self._petGainGo, MaterialModel.instance:getMaterialsNumber(MatType.PET_SKIN, self._actCfg.skinId) >= 1)
	GameUtil.SetActive(self._redPointShare, GiftBoxController.instance:isCanShareLuck(self._actId) and not GiftBoxModel.instance:getFirstOpenShare(self._actId))
	self:refreshShareRedPoint()
end

function GiftBoxMainView:refreshTabView()
	self._tabTableList:reloadData(self._poolCfgs)
end

function GiftBoxMainView:refreshBoxView()
	self._boxPlanId = self._poolCfgs[self._selectTabId].boxPlanId

	local boxCfgs = GiftBoxConfig.instance:getBoxCfgs(self._boxPlanId)

	self._boxTableList:reloadData(boxCfgs)

	local isPoolOpen = GiftBoxModel.instance:isMatchPoolCondition(self._selectTabId - 1, self._poolCfgs[self._selectTabId].openCondition)

	GameUtil.SetActive(self._unLockGo, not isPoolOpen)

	if not isPoolOpen then
		self._txtUnlock.text = self:_getPoolConditionText(self._poolCfgs[self._selectTabId].openCondition)
	end
end

function GiftBoxMainView:refreshShareRedPoint()
	local prizeCfgs = GiftBoxConfig.instance:getGainLuckPrizeCfg(self._actId)
	local haveSharePrize = false

	for i, v in ipairs(prizeCfgs) do
		if GiftBoxModel.instance:isCanGetProgressReward(v.peopleNum, v.prizeId) == true then
			haveSharePrize = true

			break
		end
	end

	GameUtil.SetActive(self._redPointPrize, haveSharePrize)
end

function GiftBoxMainView:_getPoolConditionText(openCondition)
	local conditionList = string.split(openCondition, "#")
	local stringList = {}

	for i, v in ipairs(conditionList) do
		local conditionInfo = string.split(v, ":")
		local targetType = checknumber(conditionInfo[1])
		local needCount = checknumber(conditionInfo[2])
		local boxTypeCfg = GiftBoxConfig.instance:getBoxTypeCfg(targetType)
		local desc = langPara("<color=#E8382FFF>%d</color>个%s", needCount, boxTypeCfg.name)

		table.insert(stringList, desc)
	end

	local boxDesc = table.concat(stringList, "、")

	return langPara("在上一层中\n开启%s后\n即可解锁本层", boxDesc)
end

function GiftBoxMainView:_updateTabTableCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local gainAllGo = goutil.findChild(go, "gainAll")
	local btnClick = go
	local isGainAll = true
	local boxPlanId = self._poolCfgs[data.poolId].boxPlanId
	local boxCfgs = GiftBoxConfig.instance:getBoxCfgs(boxPlanId)

	for i, v in ipairs(boxCfgs) do
		if not GiftBoxModel.instance:getBoxInfo(data.poolId, v.boxId) then
			isGainAll = false

			break
		end
	end

	GameUtil.SetActive(gainAllGo, isGainAll)

	txtName.text = langPara("第%s层", GameUtil.getChineseNumber(data.poolId))

	GameUtil.addClickHandler(btnClick, function()
		self:_onClickTab(data.poolId)
	end)
end

function GiftBoxMainView:_clearTabTableCell(cell)
	local btnClick = cell.gameObject

	GameUtil.rmClickHandler(btnClick)
end

function GiftBoxMainView:_getTagByIdx(data, idx)
	if idx == self._selectTabId - 1 then
		return 1
	else
		return 2
	end
end

function GiftBoxMainView:_getCellSizeCallBack(idx)
	if idx == self._selectTabId then
		local width = GameUtil.getWidth(self._tabTableCell_1)
		local height = GameUtil.getHeight(self._tabTableCell_1)

		return width, height
	else
		local width = GameUtil.getWidth(self._tabTableCell_2)
		local height = GameUtil.getHeight(self._tabTableCell_2)

		return width, height
	end
end

function GiftBoxMainView:_updateBoxTableCell(view, cell, data, tag)
	local go = cell.gameObject
	local itemCon = goutil.findChild(go, "boxCon/prizeCon")
	local imgBox = goutil.findChild(go, "boxCon/imgBox")
	local btnBox = goutil.findChild(go, "boxCon/imgBox")
	local imgBgChange = goutil.findChildComponent(go, "boxCon/imgBg", "UIImageSpriteChange")
	local imgBoxChange = goutil.findChildComponent(go, "boxCon/imgBox", "UIImageSpriteChange")
	local txtBoxName = goutil.findChildTextComponent(go, "boxCon/imgBox/txt")

	MaterialMgr.resetAll(itemCon)
	GameUtil.rmClickHandler(btnBox)

	local boxInfo = GiftBoxModel.instance:getBoxInfo(self._selectTabId, data.boxId)
	local isGain = boxInfo ~= nil
	local boxCfg = GiftBoxConfig.instance:getBoxTypeCfg(data.boxType)

	if txtBoxName then
		txtBoxName.text = boxCfg.name
	end

	imgBgChange:SetState(data.boxType - 1)
	imgBoxChange:SetState(data.boxType - 1)

	if isGain == true then
		GameUtil.SetActive(imgBox, false)
		GameUtil.SetActive(itemCon, true)

		if checknumber(boxInfo.superPrizeId) > 0 then
			local superPrizeCfg = GiftBoxConfig.instance:getSuperPrizeCfg(boxCfg.superPrizePlanId)
			local prizeCfg = superPrizeCfg[boxInfo.superPrizeId]

			MaterialMgr.setCellByCfg(prizeCfg.prize, itemCon)
		else
			local normalPrizeCfg = GiftBoxConfig.instance:getNormalPrizeCfg(data.normalPrizePlanId)
			local prizeCfg = normalPrizeCfg[boxInfo.normalPrizeId]

			MaterialMgr.setCellByCfg(prizeCfg.prize, itemCon)
		end
	else
		GameUtil.SetActive(imgBox, true)
		GameUtil.SetActive(itemCon, false)
		GameUtil.addClickHandler(btnBox, function()
			self:_onClickBox(self._selectTabId, data.boxId)
		end)
	end
end

function GiftBoxMainView:_clearBoxTableCell(cell)
	local go = cell.gameObject
	local itemCon = goutil.findChild(go, "boxCon/prizeCon")
	local btnBox = goutil.findChild(go, "boxCon/imgBox")

	MaterialMgr.resetAll(itemCon)
	GameUtil.rmClickHandler(btnBox)
end

function GiftBoxMainView:_setTopGoldBar()
	local btn_list = {}
	local poolCfg = GiftBoxConfig.instance:getPoolCfg(self._actId, self._selectTabId)
	local boxPlanCfg = GiftBoxConfig.instance:getBoxCfgs(poolCfg.boxPlanId)

	table.insert(btn_list, {
		showAdd = false,
		id = boxPlanCfg[1].cost
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function GiftBoxMainView:_onClickTab(poolId)
	self._selectTabId = poolId

	GiftBoxModel.instance:setSelectPool(poolId)
	self:refreshTabView()
	self:refreshBoxView()
	self._tabTableList:MoveCellToBegin(self._selectTabId - 1, true)
end

function GiftBoxMainView:_onClickBox(poolId, boxId)
	local poolCfg = GiftBoxConfig.instance:getPoolCfg(self._actId, poolId)
	local boxCfgs = GiftBoxConfig.instance:getBoxCfgs(poolCfg.boxPlanId)
	local boxCfg = GiftBoxConfig.instance:getBoxTypeCfg(boxCfgs[boxId].boxType)
	local matType, matId, matNum = MaterialMgr.getMatParams(boxCfgs[boxId].cost)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local content = langPara("确认是否消耗%s*%d开启%s", matName, matNum, boxCfg.name)

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
		GiftBoxAgent.instance:sendGB_GiftBoxOpenBoxReq(self._actId, poolId, boxId)
	end)
end

function GiftBoxMainView:_onClickShare()
	if GiftBoxController.instance:isCanShareLuck(self._actId) then
		UIStateManager.instance:push(ViewName.GiftBoxSharePopView, self._actId)
	else
		UIStateManager.instance:push(ViewName.GiftBoxLowLuckTipView)
	end
end

function GiftBoxMainView:_onClickGetLuck()
	UIStateManager.instance:push(ViewName.GiftBoxShareListView, self._actId)
end

function GiftBoxMainView:_onClickTask()
	UIStateManager.instance:push(ViewName.GiftBoxTaskView, self._actId)
end

function GiftBoxMainView:_onClickPrize()
	UIStateManager.instance:push(ViewName.GiftBoxPrizeShowView, self._actId)
end

function GiftBoxMainView:_onClickPetInfo()
	ViewAutoShowController.instance:saveCurModalView()
	UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, self._actCfg.skinId)
end

function GiftBoxMainView:_onClickPetTry()
	PetbookController.instance:previewBattleWithSkinId(self._actCfg.skinId)
end

function GiftBoxMainView:_onClickShop()
	GotoMgr.gotoByString("mibao#shengrihui6")
end

function GiftBoxMainView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "giftbox_rule_main")
end

return GiftBoxMainView
