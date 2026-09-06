-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionSendRedPackView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionSendRedPackView", package.seeall)

local GoddessCompetitionSendRedPackView = class("GoddessCompetitionSendRedPackView", ViewComponent)
local PACK_TYPE_ONE = 1
local PACK_TYPE_TWO = 2

function GoddessCompetitionSendRedPackView:ctor()
	GoddessCompetitionSendRedPackView.super.ctor(self)
end

function GoddessCompetitionSendRedPackView:unbindEvents()
	GoddessCompetitionSendRedPackView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnChangePack)
	GameUtil.rmClickHandler(self._btnHideType)
	GameUtil.rmClickHandler(self._conBg)
	GameUtil.rmClickHandler(self._btnChangePet)
	GameUtil.rmClickHandler(self._btnSend)
	GameUtil.rmClickHandler(self._btnClose)
end

function GoddessCompetitionSendRedPackView:bindEvents()
	GoddessCompetitionSendRedPackView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChangePack, self._onClickChangePack, self)
	GameUtil.addClickHandler(self._btnHideType, self._onClickHideType, self)
	GameUtil.addClickHandler(self._conBg, self._onClickChangePet, self)
	GameUtil.addClickHandler(self._btnChangePet, self._onClickChangePet, self)
	GameUtil.addClickHandler(self._btnSend, self._onClickSend, self)
end

function GoddessCompetitionSendRedPackView:buildUI()
	GoddessCompetitionSendRedPackView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSend = self:getGo("btnSend")
	self._goldBarCon = self:getGo("goldBarCon")
	self._packType2 = self:getGo("packType2")
	self._petCon = self:getGo("con/icon")
	self._conBg = self:getGo("conBg")
	self._btnChangePet = self:getGo("btnChangePet")
	self._txtPetTips = self:getGo("txtPetTips")
	self._petName = self:getGo("petName")
	self._txtName = self:getTxt("petName/txtName")
	self._curScore = self:getGo("curScore")
	self._txtScore = self:getTxt("curScore/txtScore")
	self._btnHideType = self:getGo("btnHideType")
	self._btnChangePack = self:getGo("typeSelect/btnChangePack")
	self._typeTableview = self:getGo("typeSelect/typeTableview")
	self._typeTablecell = self:getGo("typeSelect/typeTableview/typeTablecell")
	self._typeTableList = ScrollerList.create(self._typeTableview, self._typeTablecell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._txtType = self:getTxt("typeSelect/btnChangePack/txtType")
	self._prizeTableCell = self:getGo("prizeTableCell")
	self._packType1 = self:getGo("packType1")
	self._prizeTableView1 = self:getGo("packType1/prizeTableView")
	self._prizeTableList1 = ScrollerList.create(self._prizeTableView1, self._prizeTableCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._txtAddScore1 = self:getTxt("packType1/txtAddScore")
	self._txtPackNum1 = self:getTxt("packType1/txtPackNum")
	self._txtDesc1 = self:getTxt("packType1/txtDesc")
	self._txtPackTotal = self:getTxt("packType1/txtPackTotal")
	self._packTotalCon = self:getGo("packType1/packTotalCon")
	self._packType2 = self:getGo("packType2")
	self._prizeTableView2 = self:getGo("packType2/prizeTableView1")
	self._prizeTableList2 = ScrollerList.create(self._prizeTableView2, self._prizeTableCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._prizeTableView3 = self:getGo("packType2/prizeTableView2")
	self._prizeTableList3 = ScrollerList.create(self._prizeTableView3, self._prizeTableCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._prizeTableView4 = self:getGo("packType2/prizeTableView3")
	self._prizeTableList4 = ScrollerList.create(self._prizeTableView4, self._prizeTableCell, GameUtil.handler(self._updateEmptyPrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._txtAddScore2 = self:getTxt("packType2/txtAddScore")
	self._txtPackNum2 = self:getTxt("packType2/txtPackNum")
	self._txtDesc2 = self:getTxt("packType2/txtDesc")
	self._costCon = self:getGo("txtCostNum/costCon")
	self._txtCostNum = self:getTxt("txtCostNum")
	self._txtHavePack = self:getTxt("havePack/txt")
	self._costTableView = self:getGo("goldBarCon/costTableView")
	self._costTableCell = self:getGo("goldBarCon/costTableView/costTableCell")
	self._costTableList = ScrollerList.create(self._costTableView, self._costTableCell, GameUtil.handler(self._updateCostCell, self), GameUtil.handler(self._clearCostCell, self))
end

function GoddessCompetitionSendRedPackView:onExit()
	GoddessCompetitionSendRedPackView.super.onExit(self)
	self:_onClickHideType()
	self._prizeTableList1:dispose()
	self._prizeTableList2:dispose()
	self._prizeTableList3:dispose()
	self._prizeTableList4:dispose()
	self._costTableList:dispose()
	uGuiUtil.clearImage(self._petCon)
	MaterialMgr.resetAll(self._packTotalCon)
end

function GoddessCompetitionSendRedPackView:onEnter()
	GoddessCompetitionSendRedPackView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_GoddessCompetitionSendRedPackRes, self._PM_GoddessCompetitionSendRedPackRes, self)
	self.addGEvent(self, GlobalNotify.GoddessCompetitionSelectGoddess, self._onSelectGoddessCallback, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._redPackId = checknumber(params[2])

	if self._redPackId == 0 then
		self._redPackId = 1
	end

	local baseInfo = GoddessCompetitionModel.instance:getCurActBaseInfo()

	self._stepId = baseInfo.curStepId
	self._curSelectGoddess = GoddessCompetitionController.instance:getLastSendGoddessId(self._activityId, self._stepId)

	if self._curSelectGoddess == 0 then
		self._curSelectGoddess = nil
	end

	self:_initView()
end

function GoddessCompetitionSendRedPackView:_initView()
	self:_onClickHideType()
	self:_refreshView()
	self:_setTopGoldBar()
end

function GoddessCompetitionSendRedPackView:_refreshView()
	self:_refreshPetInfo()

	local redPackCfg = GoddessCompetitionConfig.instance:getRedPackCfg(self._activityId, self._redPackId)

	GameUtil.SetActive(self._packType1, redPackCfg.type == PACK_TYPE_ONE)
	GameUtil.SetActive(self._packType2, redPackCfg.type == PACK_TYPE_TWO)

	local costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(redPackCfg.sendCost)

	MaterialMgr.resetAll(self._costCon)
	MaterialMgr.setIcon(self._costCon, costMatType, costMatId)

	self._txtCostNum.text = costMatNum

	local sendCount = GoddessCompetitionModel.instance:getRedPackSendCount(self._redPackId)
	local havePackNum = redPackCfg.dailySendTimesLimit - sendCount

	self._txtHavePack.text = langPara("今日剩余%d个", havePackNum)
end

function GoddessCompetitionSendRedPackView:_refreshPackType1(cfg)
	local basePopularity = checknumber(cfg.incPopularity)
	local base, double = GoddessCompetitionModel.instance:calcPopularityWithDoubleCardButBaseAndCard(basePopularity)

	self._txtAddScore1.text = double > 0 and base > 0 and string.format("%d+ %d", double, base) or base + double
	self._txtPackNum1.text = langPara("%d个", cfg.gainCount)

	local prizeArray = string.split(cfg.senderPrize, "#")

	self._prizeTableList1:reloadData(prizeArray)

	local redPackParams = string.split(cfg.param, "&")
	local redPackItems = string.split(redPackParams[1], "#")
	local matType, matId, matNum = MaterialMgr.getMatParams(redPackItems[1])

	self._txtPackTotal.text = matNum

	MaterialMgr.resetAll(self._packTotalCon)
	MaterialMgr.setIcon(self._packTotalCon, matType, matId)

	local msgTemplateCfg = ChatConfig.instance:getSystemMsgT(cfg.msgTemplate)
	local petName = "xxxx"

	if self._curSelectGoddess then
		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curSelectGoddess)

		petName = skinCfg.skinName
	end

	if msgTemplateCfg then
		self._txtDesc1.text = StringUtil.parseJsonParams(msgTemplateCfg.template, {
			amount = string.format("<color=#ff6a67>%d</color>", matNum),
			count = string.format("<color=#ff6a67>%d</color>", cfg.gainCount),
			faceName = string.format("<color=#ff6a67>%s</color>", petName)
		})
	end
end

function GoddessCompetitionSendRedPackView:_refreshPackType2(cfg)
	local basePopularity = checknumber(cfg.incPopularity)
	local base, double = GoddessCompetitionModel.instance:calcPopularityWithDoubleCardButBaseAndCard(basePopularity)

	self._txtAddScore2.text = double > 0 and base > 0 and string.format("%d+ %d", double, base) or base + double
	self._txtPackNum2.text = langPara("%d个", cfg.gainCount)

	local prizeArray = string.split(cfg.senderPrize, "#")

	self._prizeTableList2:reloadData(prizeArray)

	local redPackParams = string.split(cfg.param, "&")
	local minimumItems = string.split(redPackParams[1], "#")

	self._prizeTableList3:reloadData(minimumItems)

	local poolPlanId = checknumber(redPackParams[2])
	local poolCfgs = GoddessCompetitionConfig.instance:getPoolCfgs(poolPlanId)
	local itemStingList = {}

	for i, v in ipairs(poolCfgs) do
		table.insert(itemStingList, v.content)
	end

	local prizeItemList = MaterialMgr.combineItemsToList(itemStingList)

	self._prizeTableList4:reloadData(prizeItemList)

	local matType, matId, matNum = MaterialMgr.getMatParams(cfg.sendCost)
	local msgTemplateCfg = ChatConfig.instance:getSystemMsgT(cfg.msgTemplate)
	local petName = "xxxx"

	if self._curSelectGoddess then
		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curSelectGoddess)

		petName = skinCfg.skinName
	end

	if msgTemplateCfg then
		self._txtDesc2.text = StringUtil.parseJsonParams(msgTemplateCfg.template, {
			count = string.format("<color=#ff6a67>%d</color>", cfg.gainCount),
			faceName = string.format("<color=#ff6a67>%s</color>", petName)
		})
	end
end

function GoddessCompetitionSendRedPackView:_refreshPetInfo()
	if not self._curSelectGoddess then
		uGuiUtil.clearImage(self._petCon)
		GameUtil.SetActive(self._petCon, false)
		GameUtil.SetActive(self._curScore, false)
		GameUtil.SetActive(self._petName, false)
		GameUtil.SetActive(self._btnChangePet, false)
		GameUtil.SetActive(self._txtPetTips, true)
	else
		local modelCo = CharacterConfig.instance:getModelCo(checknumber(self._curSelectGoddess))

		if not modelCo then
			printError("t_model id not exist:" .. self._curSelectGoddess)

			return
		end

		uGuiUtil.clearImage(self._petCon)
		uGuiUtil.setSpriteToImage(self._petCon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
		GameUtil.SetActive(self._petCon, true)
		GameUtil.SetActive(self._petName, true)
		GameUtil.SetActive(self._btnChangePet, true)
		GameUtil.SetActive(self._curScore, true)
		GameUtil.SetActive(self._txtPetTips, false)

		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curSelectGoddess)

		self._txtName.text = skinCfg.skinName

		local list = GoddessCompetitionModel.instance:getCurGoddessList(self._stepId)
		local score = 0

		for i, v in ipairs(list) do
			if v.faceId == self._curSelectGoddess then
				score = v.popularity

				break
			end
		end

		self._txtScore.text = score
	end

	local redPackCfg = GoddessCompetitionConfig.instance:getRedPackCfg(self._activityId, self._redPackId)

	self._txtType.text = redPackCfg.name

	if redPackCfg.type == PACK_TYPE_ONE then
		self:_refreshPackType1(redPackCfg)
	elseif redPackCfg.type == PACK_TYPE_TWO then
		self:_refreshPackType2(redPackCfg)
	end
end

function GoddessCompetitionSendRedPackView:_updateTabCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChange = go:GetComponent(ComponentType.UIChangeGroup)
	local txtName = goutil.findChildTextComponent(go, "txtName")

	if data.redPackId == self._redPackId then
		imgChange:SetState(0)
	else
		imgChange:SetState(1)
	end

	txtName.text = data.name

	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickNewPack(data.redPackId)
	end)
end

function GoddessCompetitionSendRedPackView:_clearTabCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function GoddessCompetitionSendRedPackView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function GoddessCompetitionSendRedPackView:_clearPrizeCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function GoddessCompetitionSendRedPackView:_updateEmptyPrizeCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)

	local proxy = MaterialMgr.setCellByCfg(data, go)

	if proxy then
		proxy.binder:setNum(0)
	end
end

function GoddessCompetitionSendRedPackView:_setTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = false,
		id = GameEnum.GoldType.Diamond
	})
	table.insert(btn_list, {
		showAdd = false,
		id = GameEnum.GoldType.GodDiamondCoin
	})
	self._costTableList:reloadData(btn_list)
end

function GoddessCompetitionSendRedPackView:_updateCostCell(view, cell, data, tag)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local matType, matId, matNum = MaterialMgr.getMatParams(data.id)
	local bagNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	MaterialMgr.resetAll(icon)
	MaterialMgr.setIcon(icon, matType, matId)

	txtNum.text = bagNum

	if data.id == GameEnum.GoldType.Diamond then
		txtNum.text = RoleModel.instance:getPresentDiamond() + RoleModel.instance:getPayDiamond()
	end
end

function GoddessCompetitionSendRedPackView:_clearCostCell(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	MaterialMgr.resetAll(icon)
end

function GoddessCompetitionSendRedPackView:_onClickChangePack()
	local redPackCfgs = GoddessCompetitionConfig.instance:getRedPackCfgs(self._activityId)

	self._typeTableList:reloadData(redPackCfgs)
	GameUtil.SetActive(self._btnHideType, true)
	GameUtil.SetActive(self._typeTableview, true)
end

function GoddessCompetitionSendRedPackView:_onClickHideType()
	GameUtil.SetActive(self._btnHideType, false)
	GameUtil.SetActive(self._typeTableview, false)
end

function GoddessCompetitionSendRedPackView:_onClickNewPack(redPackId)
	self:_onClickHideType()

	if self._redPackId ~= redPackId then
		self._redPackId = redPackId

		self:_refreshView()
	end
end

function GoddessCompetitionSendRedPackView:_onClickChangePet()
	UIStateManager.instance:push(ViewName.GoddessCompetitionSendRedPackPetSelectView, self._activityId, self._stepId)
end

function GoddessCompetitionSendRedPackView:_onSelectGoddessCallback(msg)
	self._curSelectGoddess = msg.goddessId

	self:_refreshPetInfo()
end

function GoddessCompetitionSendRedPackView:_onClickSend()
	local redPackCfg = GoddessCompetitionConfig.instance:getRedPackCfg(self._activityId, self._redPackId)
	local havePack = redPackCfg.dailySendTimesLimit - GoddessCompetitionModel.instance:getRedPackSendCount(self._redPackId) > 0

	if not havePack then
		FloatWordMgr.instance:show(lang("今日已无可发送次数"))

		return
	end

	local isInCompetitionTime = GoddessCompetitionController.instance:isInCompetitionTime(self._activityId)

	if not isInCompetitionTime then
		FloatWordMgr.instance:show("活动已结束")

		return
	end

	if not self._curSelectGoddess then
		FloatWordMgr.instance:show(lang("请先选择你要助力的女神"))

		return
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(redPackCfg.sendCost)
	local matName = MaterialMgr.getMaterialsName(matType, matId)

	if MaterialModel.instance:IsEnough(matType, matId, matNum) == true then
		local content = langPara("确定要花费%d%s,\n发送%d个%s吗？", matNum, matName, redPackCfg.gainCount, redPackCfg.name)

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
			GoddessCompetitionAgent.instance:sendPM_GoddessCompetitionSendRedPackReq(self._activityId, self._curSelectGoddess, self._redPackId)
			GoddessCompetitionController.instance:saveLastSendGoddessId(self._activityId, self._stepId, self._curSelectGoddess)
		end)
	else
		MaterialMgr.openGetSourceByStr(redPackCfg.sendCost)
	end
end

function GoddessCompetitionSendRedPackView:_PM_GoddessCompetitionSendRedPackRes()
	self:close()
end

return GoddessCompetitionSendRedPackView
