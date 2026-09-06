-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/LegendView.lua

module("logic.extensions.legend.view.LegendView", package.seeall)

local LegendView = class("LegendView", ViewComponent)

function LegendView:ctor()
	LegendView.super.ctor(self)
end

function LegendView:buildUI()
	LegendView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnExplain = self:getBtn("btnExplain")
	self._bg = self:getGo("bg")
	self._rarePoint = self:getGo("name/rarePoint")
	self._txtName = self:getGo("name/txtName"):GetComponent(goutil.Type_UIText)
	self._txtRare = self:getTxt("name/txtRare")
	self._scrollView = self:getGo("ScrollView"):GetComponent("ScrollRectExt")
	self._content = self:getGo("ScrollView/Viewport/Content")
	self._item = self:getGo("ScrollView/item")

	self._item:SetActive(false)

	self._goIndependentCount = self:getGo("independentCount")
	self._goIndependentCountRectTrans = self._goIndependentCount:GetComponent(goutil.Type_RectTransform)
	self._independentTxt1 = self:getGo("independentCount/txt1"):GetComponent(goutil.Type_UIText)
	self._roleModel = self:getGo("roleModel")
	self._btnStart = self:getBtn("btnStart")
	self._btnIntroduce = self:getBtn("btnIntroduce")
	self._btnSkill = self:getBtn("btnSkill")
	self._btnSweep = self:getBtn("btnSweep")
	self._txtTitle = self:getGo("txtTitle"):GetComponent(goutil.Type_UIText)
	self._tableview = self:getGo("rewardList"):GetComponent("UITableview")
	self._tableCell = self:getGo("rewardList/item")

	self._tableCell:SetActive(false)

	self._goReward = self:getGo("reward")
	self._rewardPet = self:getGo("reward/rewardPet")
	self._txtReward = goutil.findChildTextComponent(self.mainGO, "reward/txtReward")
	self._btnRankReward = self:getBtn("btnRankReward")
	self._effectBtn = self:getGo("btnStart/effect")
	self._effectFullScreen = self:getGo("effect")
	self._verifyContainer = self:getGo("verifyContainer")
	self._tili = self:getGo("tili")
	self._txtTili = goutil.findChildTextComponent(self.mainGO, "NodePower/txtPower")
	self._btnFake1 = self:getBtn("fakeBtn1")
	self._btnFake2 = self:getBtn("fakeBtn2")
	self._sweepReward = self:getGo("sweepReward")
	self._sweepRewardItem = self:getGo("sweepReward/item")
	self._sweepRewardContainer = self:getGo("sweepReward/container")
	self._imgRecZdl = self:getGo("zdl/imgRecZdl"):GetComponent("UIImgNumeralText")
end

function LegendView:destroyUI()
	LegendView.super.destroyUI(self)
end

function LegendView:bindEvents()
	LegendView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnExplain:AddClickListener(self._onClickExplain, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnIntroduce:AddClickListener(self._onClickIntroduce, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnSweep:AddClickListener(self._onClickSweep, self)
	self._btnRankReward:AddClickListener(self._onClickReward, self)
	self._btnFake1:AddClickListener(self._onClickFakeUp, self)
	self._btnFake2:AddClickListener(self._onClickFakeDown, self)
end

function LegendView:unbindEvents()
	LegendView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnIntroduce:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnSweep:RemoveClickListener()
	self._btnRankReward:RemoveClickListener()
	self._btnFake1:RemoveClickListener()
	self._btnFake2:RemoveClickListener()
end

function LegendView:onEnter()
	LegendView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.LegendChallengeInfoRes, self._onLegendChallengeInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.LegendChallengeBuyIndependentTimesRes, self._onBuyIndependentTimesRes, self)
	GlobalDispatcher:addListener(MopupModel.SweepSuccessed, self._setChallengeCount, self)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._challengeId = self:getFirstParam()
	self._curSelectIndex = 1
	self._maxPassStage = 0
	self._timeInternal = 20
	self._timeRecord = self._timeInternal
	self._updateTime = LegendModel.instance:getUpdateTime()
	self._legendChallengeCfg = LegendConfig.instance:getLegendChallengeCfg(self._challengeId)

	goutil.setActive(self._sweepReward, false)
	self:_showRoleModel(self._legendChallengeCfg.raceId)
	LegendController.instance:setEnteredLegendView(self._challengeId)
	LegendController.instance:sendPM_LegendChallengeInfoReq(self._challengeId)
	self._goIndependentCount.gameObject:SetActive(self._legendChallengeCfg.openSweep)
	self:_setTili()
	self:_setBigBg()
	self:_setName()
	self:_setEffect()
end

function LegendView:onExit()
	LegendView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LegendChallengeInfoRes, self._onLegendChallengeInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.LegendChallengeBuyIndependentTimesRes, self._onBuyIndependentTimesRes, self)
	GlobalDispatcher:removeListener(MopupModel.SweepSuccessed, self._setChallengeCount, self)
	goutil.clearChildren(self._content)
	self:_resetRoleModel()

	self._scrollItemGos = nil
	self._scrollItemInfos = nil

	self:_clearSweepReward()
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}

	self._tableview:UnRegisterAllCallbacks()
	MaterialMgr.resetAll(self._rarePoint)
end

function LegendView:_onClickClose()
	self:close()
end

function LegendView:_onClickExplain()
	local cfgKey = "legendviewtip"

	ViewMgr.instance:open(ViewName.RulesView, cfgKey)
end

function LegendView:_onClickStart()
	if not self._scrollItemInfos then
		return
	end

	local itemInfo = self._scrollItemInfos[self._curSelectIndex]

	if itemInfo then
		local isUnlock = itemInfo.isUnlock

		if not isUnlock then
			if itemInfo.isArriveCondition then
				FloatWordMgr.instance:show("请先通关前面的关卡")
			else
				local unlockId = itemInfo.cfg.unlockId
				local cfg = FuncOpenConfig.instance:getFunctionOpenById(unlockId)

				if cfg then
					FloatWordMgr.instance:show(cfg.description)
				else
					FloatWordMgr.instance:show("本关卡尚未解锁")
				end
			end

			return
		end

		local independentCount = LegendModel.instance:getCurIndependentTimes(self._challengeId)

		if independentCount == 0 then
			FloatWordMgr.instance:show(string.format("今天%s的挑战次数用完了，明天再来吧", self._legendChallengeCfg.challengeName))

			return
		end

		LegendModel.instance:setCurOpenChallenge(self._challengeId, self._curSelectIndex)
		UIStateManager.instance:push(ViewName.LegendMissonView)
	end
end

function LegendView:_onClickIntroduce()
	local raceId = self._legendChallengeCfg.raceId

	CommonTipsMgr.instance:showMaxLvlPetTips(raceId)
end

function LegendView:_onClickSkill()
	local challengeId = self._challengeId

	UIJumper.instance:pushOneStack(self._viewPresentor.viewName, true, challengeId)

	local raceId = self._legendChallengeCfg.raceId

	PetbookController.instance:previewBattle(raceId, nil, false)
end

function LegendView:_onClickSweep()
	MopupModel.instance:clickLegenSweep(self._challengeId, self._curSelectIndex)
end

function LegendView:_onEndDrag(curSelectIndex)
	self._curSelectIndex = curSelectIndex + 1

	LegendModel.instance:setCurOpenChallenge(self._challengeId, self._curSelectIndex)
	self:_refreshRewardList()
	self:_updateStageListBg()
	self:_setBtnSweepState()
end

function LegendView:_onLegendChallengeInfoRes(msg)
	local isAllPass = LegendModel.instance:isChallengePass(self._challengeId)

	self:_initSweepReward(isAllPass and self._legendChallengeCfg.openSweep)
	self:_initShow()
	self:_setTili()
end

function LegendView:_onBuyIndependentTimesRes(msg)
	self:_setIndependentChallengeCount()
end

function LegendView:_initShow()
	self:_setIndependentChallengeCount()
	self:_setScrollList()
	self:_refreshRewardList()
	self:_setBtnSweepState()
	self:_setVerifyContainer()
end

function LegendView:_setIndependentChallengeCount()
	local curIndependentTime = LegendModel.instance:getCurIndependentTimes(self._challengeId)

	self._independentTxt1.text = "可扫荡次数：" .. string.format("%d/%d", curIndependentTime, self._legendChallengeCfg.dailyTimes)
end

function LegendView:_setChallengeCount()
	self:_setIndependentChallengeCount()
end

function LegendView:_setScrollList()
	goutil.clearChildren(self._content)

	local cfgs = LegendConfig.instance:getLegendChallengeStageCfgList(self._challengeId)
	local stageNum = #cfgs

	self._scrollItemGos = {}
	self._scrollItemInfos = {}

	local maxUnLockAndPassIndex = 1
	local minUnLockAndNotPassIndex = stageNum + 1
	local isExistMin = false

	for i = 1, stageNum do
		local go = goutil.cloneAndSetParent(self._item, self._content.transform, "item" .. tostring(i))

		go:SetActive(true)

		self._scrollItemGos[i] = go

		local itemInfo = {}

		self._scrollItemInfos[i] = itemInfo
		itemInfo.index = i
		itemInfo.isPass = LegendModel.instance:isStagePass(self._challengeId, i)
		itemInfo.cfg = cfgs[i]

		if cfgs[i].unlockId > 0 then
			local isOpen = FuncOpenModel.instance:getFuncIsOpen(cfgs[i].unlockId)

			itemInfo.isUnlock = isOpen
			itemInfo.isArriveCondition = isOpen
		else
			itemInfo.isUnlock = true
			itemInfo.isArriveCondition = true
		end

		itemInfo.isSelect = self._curSelectIndex == i

		if itemInfo.isUnlock and not itemInfo.isPass and i < minUnLockAndNotPassIndex then
			isExistMin = true
			minUnLockAndNotPassIndex = i
		end

		if itemInfo.isUnlock and itemInfo.isPass and maxUnLockAndPassIndex < i then
			maxUnLockAndPassIndex = i
		end

		if itemInfo.isPass then
			self._maxPassStage = i
		end
	end

	self._curSelectIndex = isExistMin and minUnLockAndNotPassIndex or maxUnLockAndPassIndex

	LegendModel.instance:setCurOpenChallenge(self._challengeId, self._curSelectIndex)
	self:_sendMisionViewInfo(self._challengeId, self._curSelectIndex)

	for i, v in ipairs(self._scrollItemInfos) do
		if i > self._curSelectIndex then
			v.isUnlock = false
		end

		self:_updateItem(self._scrollItemGos[i], v)
	end

	self:_updateStageListBg()
	self._scrollView:initChildList(self._curSelectIndex - 1)
end

function LegendView:_sendMisionViewInfo(challengeId, stageId)
	if LegendModel.instance:isExistSupportPet() and not LegendModel.instance:isStagePass(challengeId, stageId) then
		LegendController.instance:sendSupportGetFormReq(challengeId, stageId)
	end
end

function LegendView:_updateStageListBg()
	for i, v in ipairs(self._scrollItemInfos) do
		v.isSelect = self._curSelectIndex == i

		self:_updateBgState(self._scrollItemGos[i], self._scrollItemInfos[i])
	end
end

function LegendView:_showRoleModel(raceId)
	local cfg = CharacterConfig.instance:getPetCo(raceId)
	local offset = CharactorFacade.instance:getLegendModelUIPosAndScale(raceId)
	local x, y, scale = 0, 0, 1
	local scaleY

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])

		if offset[4] then
			local var_23_0 = {}

			var_23_0[1] = offset[3] or 1
			var_23_0[2] = offset[4]
			var_23_0[3] = offset[4]
			scale = var_23_0
		else
			scale = offset[3] or 1
		end
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, cfg.faceIds, self._roleModel, scale, callback, nil, x, y)
end

function LegendView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function LegendView:_updateItem(go, data)
	local txtName1 = goutil.findChild(go, "bg/unSelect/txtName"):GetComponent(goutil.Type_UIText)
	local imgLock1 = goutil.findChild(go, "bg/unSelect/imgLock")
	local txtName2 = goutil.findChild(go, "bg/select/txtName"):GetComponent(goutil.Type_UIText)
	local imgLock2 = goutil.findChild(go, "bg/select/imgLock")
	local btnClick = goutil.findChild(go, "bg")

	self:_updateBgState(go, data)

	if data.index > 9 then
		txtName1.text = data.index or string.format("0%d", data.index)
	end

	imgLock1:SetActive(not data.isUnlock)

	txtName2.text = txtName1.text

	imgLock2:SetActive(not data.isUnlock)
end

function LegendView:_updateBgState(go, data)
	local unSelectBg = goutil.findChild(go, "bg/unSelect"):GetComponent("UIChangeGroup")
	local selectBg = goutil.findChild(go, "bg/select"):GetComponent("UIChangeGroup")

	unSelectBg.gameObject:SetActive(not data.isSelect)
	selectBg.gameObject:SetActive(data.isSelect)

	local state = data.isSelect and 1 or 0

	unSelectBg:SetState(state)
	selectBg:SetState(state)
end

function LegendView:_numInView()
	return #self._curViewDatas
end

function LegendView:_cellSize(view, idx)
	if idx + 1 == #self._curViewDatas then
		return 110, 90
	end

	return 90, 90
end

function LegendView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function LegendView:_updateCell(view, cell, data)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	Framework.TransformUtil.SetLocalScale(parentGo.transform, 0.9, 0.9, 0.9)

	local imgFirstPass = goutil.findChild(cell.gameObject, "imgFirstPass")
	local imgPercent = goutil.findChild(cell.gameObject, "imgPercent")

	imgFirstPass:SetActive(data.isFirst)
	imgPercent:SetActive(false)
	MaterialMgr.setCellByCfg(data.rewardStr, parentGo)
end

function LegendView:_clearTableview(cell)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.resetAll(parentGo)
end

function LegendView:_refreshRewardList()
	local challengeId = self._challengeId
	local stageId = self._curSelectIndex
	local cfgStage = LegendConfig.instance:getLegendChallengeStageCfg(challengeId, stageId)
	local cfgTeam = LegendConfig.instance:getLegendChallengeTeamCfg(cfgStage.teamId)

	self._curViewDatas = {}

	if not LegendModel.instance:isStagePass(challengeId, stageId) and cfgTeam and not string.nilorempty(cfgTeam.firstPassPrize) then
		local items = string.split(cfgTeam.firstPassPrize, "#")
		local length = #items

		for i = 1, length do
			if not string.nilorempty(items[i]) then
				local index = #self._curViewDatas + 1
				local info = {}

				info.rewardStr = items[i]
				info.isFirst = true
				info.isPercent = false
				self._curViewDatas[index] = info
			end
		end
	end

	if cfgTeam and not string.nilorempty(cfgTeam.reward) then
		local str2 = MaterialMgr.changeItemStr(cfgTeam.reward)
		local rewardItems = string.split(str2, "#")
		local length2 = #rewardItems

		for i = 1, length2 do
			if not string.nilorempty(rewardItems[i]) then
				local index = #self._curViewDatas + 1
				local element = {}

				element.rewardStr = rewardItems[i]
				element.isFirst = false
				element.isPercent = not string.find(cfgTeam.reward, rewardItems[i])
				self._curViewDatas[index] = element
			end
		end
	end

	self._tableview:ReloadData()
	self:_refreshPetReward()
end

function LegendView:_refreshPetReward()
	local showTxt = ""
	local challengeId = self._challengeId
	local rewardStageId
	local cfgs = LegendConfig.instance:getLegendChallengeStageCfgList(challengeId)
	local minLevel = -1
	local firstPassPrize = ""

	for k, v in pairs(cfgs) do
		local cfgStage = LegendConfig.instance:getLegendChallengeStageCfg(challengeId, v.stageId)
		local cfgTeam = LegendConfig.instance:getLegendChallengeTeamCfg(cfgStage.teamId)
		local isPass = LegendModel.instance:isStagePass(challengeId, v.stageId)

		if cfgTeam and not string.nilorempty(cfgTeam.firstPassPrize) and not isPass and v.stageId >= self._curSelectIndex and (minLevel < 0 or minLevel > v.stageId) then
			showTxt = string.format("通关 第<color=#60ee85>%s</color>层", v.stageId)
			minLevel = v.stageId
			firstPassPrize = cfgTeam.firstPassPrize
		end
	end

	self._goReward:SetActive(showTxt ~= "")
	MaterialMgr.setCellByCfg(firstPassPrize, self._rewardPet)

	self._txtReward.text = showTxt
end

function LegendView:_getPetCfg()
	return CharacterConfig.instance:getPetCo(self._legendChallengeCfg.raceId)
end

function LegendView:_setBigBg()
	local elements = PetSkinConfig.instance:getAllElementAttrs(self._legendChallengeCfg.raceId)
	local resName = LegendModel.instance:getTexNameByRaceTypes(elements[1])

	uGuiUtil.setSpriteToImage(self._bg.gameObject, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/legend/%s.png", resName))
end

function LegendView:_setName()
	local cfg = self:_getPetCfg()

	self._txtName.text = cfg.name
	self._txtRare.text = MatType.RareName[rare]

	MaterialMgr.resetAll(self._rarePoint)
	MaterialMgr.setCell(MatType.Rare, cfg.raceId, self._rarePoint)
end

function LegendView:_setEffect()
	local cfg = self:_getPetCfg()
	local btnEffectPath = "fx_ui_chuanshuotiaozhan/fx_ui_chuanshuotiaozhan_tiaozhan.prefab"
	local elements = PetSkinConfig.instance:getAllElementAttrs(self._legendChallengeCfg.raceId)
	local fullScreenEffectPath = LegendModel.instance:getEffectPath(elements[1])
	local effect1 = UIEffectManager.instance:playEffect(self, btnEffectPath, self._effectBtn.transform, 0, 0, true, false)

	effect1:setParent(self._effectBtn.transform)
	effect1:setScale(1)

	local effect2 = UIEffectManager.instance:playEffect(self, fullScreenEffectPath, self._effectFullScreen.transform, 0, 0, true, false)

	effect2:setParent(self._effectFullScreen.transform)
	effect2:setScale(1)

	self._effectList = {}

	table.insert(self._effectList, effect1)
	table.insert(self._effectList, effect2)
end

function LegendView:_clearEffect()
	if self._effectList then
		for i, v in ipairs(self._effectList) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._effectList = nil
	end
end

function LegendView:_setBtnSweepState()
	local isPass = LegendModel.instance:isChallengePass(self._challengeId)

	self._btnSweep.gameObject:SetActive(isPass)
	self._btnStart.gameObject:SetActive(not isPass)
end

function LegendView:_setVerifyContainer()
	if self._legendChallengeCfg == nil then
		return
	end

	local verifyPlanId = self:_getVerifyPlanId(self._challengeId, self._curSelectIndex)

	LegendModel.instance:setVerifyPlanId(verifyPlanId)

	local isPass = LegendModel.instance:isChallengePass(self._challengeId)

	if verifyPlanId ~= 0 and not isPass then
		PetverifyController.instance:showEnterView(self._viewPresentor, self._verifyContainer, verifyPlanId)
	end
end

function LegendView:_getVerifyPlanId(challengeId, stageId)
	local cfgStage = LegendConfig.instance:getLegendChallengeStageCfg(challengeId, stageId)

	return (cfgStage or nil) and (cfgStage.verifyPlanId or 0)
end

function LegendView:_setTili()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = true,
		id = GameEnum.GoldType.Tili
	})

	if self._legendChallengeCfg and self._legendChallengeCfg.openSweep then
		table.insert(btn_list, {
			showAdd = true,
			id = GameEnum.GoldType.SweepTicket
		})
		Framework.TransformUtil.SetAnchoredPos(self._goIndependentCountRectTrans, -450, -36)
	else
		Framework.TransformUtil.SetAnchoredPos(self._goIndependentCountRectTrans, -240, -36)
	end

	MainUIController.instance:showGlodBar(self._tili, self._viewPresentor, btn_list)

	local challengeId = self._challengeId
	local stageId = self._curSelectIndex
	local cfgStage = LegendConfig.instance:getLegendChallengeStageCfg(challengeId, stageId)
	local cfgTeam = LegendConfig.instance:getLegendChallengeTeamCfg(cfgStage.teamId)

	self._txtTili.text = cfgTeam.strengthConsumption

	self._imgRecZdl:SetText(tostring(cfgTeam.recommendZdl))
end

function LegendView:_onClickReward()
	UIStateManager.instance:push(ViewName.LegendprizeView, self._challengeId)
end

function LegendView:_onClickFakeUp()
	if self._curSelectIndex ~= #self._scrollItemInfos then
		FloatWordMgr.instance:show("请先通关前面的关卡！")
	end
end

function LegendView:_onClickFakeDown()
	if self._curSelectIndex ~= 1 then
		FloatWordMgr.instance:show("此关卡已通关！")
	end
end

function LegendView:_initSweepReward(isOpen)
	goutil.setActive(self._sweepReward, false)
	self:_clearSweepReward()

	if isOpen then
		local rewardStr = self._legendChallengeCfg.reward
		local rewardStr = MaterialMgr.changeItemStr(rewardStr)

		if string.nilorempty(rewardStr) then
			return
		end

		local strList = string.split(rewardStr, "#")
		local itemGo = self._sweepRewardItem

		self._sweepGos = {}

		for i, v in ipairs(strList) do
			if not string.nilorempty(v) then
				local go = goutil.cloneAndSetParent(itemGo, self._sweepRewardContainer.transform, "item" .. i)

				goutil.setActive(go, true)

				local node = goutil.findChild(go, "node")

				MaterialMgr.setCellByCfg(v, node)
				table.insert(self._sweepGos, go)
			end
		end
	end
end

function LegendView:_clearSweepReward()
	if self._sweepGos then
		for i, go in ipairs(self._sweepGos) do
			local node = goutil.findChild(go, "node")

			MaterialMgr.resetAll(node)
		end
	end

	goutil.clearChildren(self._sweepRewardContainer)

	self._sweepGos = nil
end

return LegendView
