-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightregress/view/SaintKnightRegressMainView.lua

module("logic.extensions.saintknightregress.view.SaintKnightRegressMainView", package.seeall)

local SaintKnightRegressMainView = class("SaintKnightRegressMainView", ViewComponent)

function SaintKnightRegressMainView:ctor()
	SaintKnightRegressMainView.super.ctor(self)
end

function SaintKnightRegressMainView:unbindEvents()
	SaintKnightRegressMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnInvite)
	GameUtil.rmClickHandler(self._btnAddress)
	GameUtil.rmClickHandler(self._btnBind)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnTask)
end

function SaintKnightRegressMainView:bindEvents()
	SaintKnightRegressMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnInvite, self._onClickInvite, self)
	GameUtil.addClickHandler(self._btnAddress, self._onClickAddress, self)
	GameUtil.addClickHandler(self._btnBind, self._onClickBind, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickLottery, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
end

function SaintKnightRegressMainView:buildUI()
	SaintKnightRegressMainView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnInvite = self:getGo("btnInvite")
	self._btnAddress = self:getGo("btnAddress")
	self._btnBind = self:getGo("btnBind")
	self._btnTip = self:getGo("btnTip")
	self._lotteryItemView = self:getGo("lottery/itemView")
	self._lotteryItemCell = self:getGo("lottery/itemView/itemCell")
	self._lotteryItemGroup = ItemGroup.New(self._lotteryItemView, self._lotteryItemCell)
	self._btnLottery = self:getGo("lottery/btnLottery")
	self._lotteryCon = self:getGo("lottery/lotteryCon")
	self._txtLotteryTimes = self:getTxt("lottery/times/txt")
	self._lotteryIcon = self:getGo("lottery/times/txt/icon")
	self._boolMask = self:getGo("boolMask")
	self._bollCell = self:getGo("boolMask/bollCell")
	self._iconBollCell = self:getGo("boolMask/bollCell/icon")
	self._txtBollNum = self:getTxt("boolMask/bollCell/txtNum")
	self._regressTableView = self:getGo("regressTableView")
	self._regressTableCell = self:getGo("regressTableView/tablecell")
	self._mask = self:getGo("regressTableView/mask")
	self._regressTableList = ScrollerList.create(self._regressTableView, self._regressTableCell, GameUtil.handler(self._updateRegressCell, self), GameUtil.handler(self._clearRegressCell, self))
	self._rewardCell = self:getGo("rewardCell")
	self._inviteTableView = self:getGo("inviteTableView")
	self._inviteTableViewPort = self:getGo("inviteTableView/viewport")
	self._inviteTablecell = self:getGo("inviteTableView/inviteTablecell")
	self._inviteTableList = ScrollerList.create(self._inviteTableView, self._inviteTablecell, GameUtil.handler(self._updateInviteCell, self), GameUtil.handler(self._clearInviteCell, self))
	self._myRegresssTag = self:getGo("myHeadInfo/regressTag")
	self._myActiveTag = self:getGo("myHeadInfo/activeTag")
	self._myHeadIcon = self:getGo("myHeadInfo/headIcon")
	self._txtMyUserName = self:getTxt("myHeadInfo/name/txt")
	self._txtTime = self:getTxt("time/txtTime")
	self._scoreTableCell = self:getGo("scoreTableView/scoreTableCell")
	self._scoreTableView = self:getGo("scoreTableView")
	self._scoreTableList = ScrollerList.create(self._scoreTableView, self._scoreTableCell, GameUtil.handler(self._updateScoreCell, self), GameUtil.handler(self._clearScoreCell, self))
	self._progressBar_1 = self:getSlider("scoreTableView/viewport/content/progressBar_1")
	self._progressBar_2 = self:getSlider("scoreTableView/viewport/content/progressBar_2")
	self._progressBar_3 = self:getSlider("scoreTableView/viewport/content/progressBar_3")
	self._goldBarCon = self:getGo("goldBar")
	self._btnTask = self:getGo("btnTask")
end

function SaintKnightRegressMainView:onExit()
	SaintKnightRegressMainView.super.onExit(self)
	self._lotteryItemGroup:dispose(self._clearLotteryItemCell, self)

	for k, v in pairs(self._rewardTableListDir) do
		v:dispose()

		self._rewardTableListDir[k] = nil
	end

	if self._lotterySpineObj then
		RoleObjectPool.instance:removeRole(self._lotterySpineObj)

		self._lotterySpineObj = nil
	end
end

function SaintKnightRegressMainView:onEnter()
	SaintKnightRegressMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SaintKnightRegressGetInfo, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_SaintKnightRegressLotteryRes, self._PM_SaintKnightRegressLotteryRes, self)

	self._rewardTableListDir = {}
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 483001
	end

	self._activityCfg = SaintKnightRegressConfig.instance:getActivityCfg(self._activityId)

	self:_initView()
	SaintKnightRegressAgent.instance:sendPM_SaintKnightRegressGetInfoReq(self._activityId)

	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
end

function SaintKnightRegressMainView:_initView()
	GameUtil.SetActive(self._boolMask, false)
	HeadItemController.instance:setHeadCellByInfo(self._myHeadIcon, RoleModel.instance:getHeadInfo())

	self._txtMyUserName.text = RoleModel.instance:getUserName()

	local matType, matId, matNum = MaterialMgr.getMatParams(self._activityCfg.lotteryCost)

	MaterialMgr.setIcon(self._lotteryIcon, matType, matId)

	self._txtLotteryTimes.text = matNum
	self._isReqing = false

	self:_setTopGoldBar()
end

function SaintKnightRegressMainView:_refreshView()
	self:_refreshLottery()

	local regressList = {}

	for i = 1, self._activityCfg.inviteCountLimit do
		table.insert(regressList, i)
	end

	self._regressTableList:reloadData(regressList)

	local inviteTaskCfgs = SaintKnightRegressConfig.instance:getInviteTaskCfgs(self._activityId)

	self._inviteTableList:reloadData(inviteTaskCfgs)

	local isRegressPlayer = SaintKnightRegressModel.instance:getIsRegressPlayer(self._activityId)

	GameUtil.SetActive(self._myRegresssTag, isRegressPlayer)
	GameUtil.SetActive(self._myActiveTag, not isRegressPlayer)
	GameUtil.SetActive(self._btnAddress, SaintKnightRegressModel.instance:getSuperPrizeId(self._activityId))

	local regressTaskCfgs = SaintKnightRegressConfig.instance:getTaskCountCfgs(self._activityId)

	self._scoreTableList:reloadData(regressTaskCfgs)

	local scoreList = {}

	for i, v in ipairs(regressTaskCfgs) do
		table.insert(scoreList, v.taskCount)
	end

	local maxScore = SaintKnightRegressModel.instance:getFinishRegressTaskCount(self._activityId, 1)

	self._scoreTableList:updateUnderSlider(self._progressBar_1, maxScore, scoreList)

	maxScore = SaintKnightRegressModel.instance:getFinishRegressTaskCount(self._activityId, 2)

	self._scoreTableList:updateUnderSlider(self._progressBar_2, maxScore, scoreList)

	maxScore = SaintKnightRegressModel.instance:getFinishRegressTaskCount(self._activityId, 3)

	self._scoreTableList:updateUnderSlider(self._progressBar_3, maxScore, scoreList)
end

function SaintKnightRegressMainView:_refreshLottery()
	GameUtil.SetActive(self._lotteryItemView, true)

	local prizeList = {}
	local normalPrizeCfgs = SaintKnightRegressConfig.instance:getNormalLotteryPrizeCfgs(self._activityId)

	for i, v in ipairs(normalPrizeCfgs) do
		table.insert(prizeList, {
			isNormal = true,
			cfg = v
		})
	end

	local superPrizeCfgs = SaintKnightRegressConfig.instance:getSuperLotteryPrizeCfgs(self._activityId)

	for i, v in ipairs(superPrizeCfgs) do
		table.insert(prizeList, {
			isNormal = false,
			cfg = v
		})
	end

	self._lotteryItemGroup:updateWithMoArray(prizeList, self._updateLotteryItemCell, self)
end

function SaintKnightRegressMainView:_updateRegressCell(view, cell, data, tag)
	local go = cell.gameObject
	local headInfoGo = goutil.findChild(go, "headInfo")
	local headCon = goutil.findChild(headInfoGo, "headIcon")
	local txtName = goutil.findChildTextComponent(headInfoGo, "name/txt")
	local btnTask = goutil.findChild(headInfoGo, "btnTask")
	local emptyPlayerGo = goutil.findChild(go, "empty")
	local regressPlayerInfo = SaintKnightRegressModel.instance:getRegressPlayerInfo(self._activityId, data)

	GameUtil.SetActive(headInfoGo, regressPlayerInfo ~= nil)
	GameUtil.SetActive(emptyPlayerGo, regressPlayerInfo == nil)

	if regressPlayerInfo then
		HeadItemController.instance:setHeadCellByInfo(headCon, regressPlayerInfo.headInfo, true)

		txtName.text = regressPlayerInfo.headInfo.userName
	end

	GameUtil.addClickHandler(emptyPlayerGo, self._onClickInvite, self)
	GameUtil.addClickHandler(btnTask, function()
		self:_onClickTask(regressPlayerInfo.headInfo)
	end, self)
end

function SaintKnightRegressMainView:_clearRegressCell(cell)
	return
end

function SaintKnightRegressMainView:_updateRewardCell(view, cell, data, tag)
	local go = cell.gameObject
	local effGo = goutil.findChild(go, "effect")
	local con = goutil.findChild(go, "item")
	local btnCanGet = goutil.findChild(go, "canGet")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local receivedGo = goutil.findChild(go, "received")
	local reachImgChange = goutil.findChildComponent(go, "imgReach", ComponentType.UIImageSpriteChange)
	local cfg = data.cfg

	txtScore.text = cfg.taskCount

	local finishCount = SaintKnightRegressModel.instance:getFinishRegressTaskCount(self._activityId, data.index)
	local isGain = SaintKnightRegressModel.instance:getGainRegressPrize(self._activityId, data.index, cfg.prizeId)

	GameUtil.SetActive(receivedGo, isGain)
	GameUtil.SetActive(btnCanGet, finishCount >= cfg.taskCount and not isGain)

	if finishCount >= cfg.taskCount and not isGain then
		self:_playEffect(effGo, self._mask)
	else
		self:_clearEffect(effGo)
	end

	if finishCount >= cfg.taskCount then
		GameUtil.setHeight(reachImgChange, 36)
		GameUtil.setWidth(reachImgChange, 36)
		reachImgChange:SetState(0)
	else
		GameUtil.setHeight(reachImgChange, 25)
		GameUtil.setWidth(reachImgChange, 25)
		reachImgChange:SetState(1)
	end

	GameUtil.addClickHandler(btnCanGet, function()
		self:_onClickGainRegressPrize(data.index, cfg.prizeId)
	end)
	MaterialMgr.setCellByCfg(cfg.prize, con)
end

function SaintKnightRegressMainView:_clearRewardCell(cell)
	local go = cell.gameObject
	local effGo = goutil.findChild(go, "effect")
	local con = goutil.findChild(go, "item")

	MaterialMgr.resetAll(con)
	self:_clearEffect(effGo)
end

function SaintKnightRegressMainView:_updateInviteCell(view, cell, data, tag)
	local go = cell.gameObject
	local effGo = goutil.findChild(go, "effect")
	local con = goutil.findChild(go, "item")
	local btnCanGet = goutil.findChild(go, "canGet")
	local txtScore = goutil.findChildTextComponent(go, "score/txtScore")
	local receivedGo = goutil.findChild(go, "received")

	txtScore.text = langPara("邀请%d人", data.inviteCount)

	local invitePlayerList = SaintKnightRegressModel.instance:getRegressPlayerList(self._activityId)
	local inviteCount = #invitePlayerList
	local isGainPrize = SaintKnightRegressModel.instance:isGainInvitePrize(self._activityId, data.taskId)

	GameUtil.SetActive(btnCanGet, inviteCount >= data.inviteCount and not isGainPrize)
	GameUtil.SetActive(receivedGo, isGainPrize)
	MaterialMgr.setCellByCfg(data.prize, con)

	if inviteCount >= data.inviteCount and not isGainPrize then
		self:_playEffect(effGo, self._inviteTableViewPort)
	else
		self:_clearEffect(effGo)
	end

	GameUtil.addClickHandler(btnCanGet, function()
		self:_onClickInvitePrize(data.taskId)
	end)
end

function SaintKnightRegressMainView:_clearInviteCell(cell)
	local go = cell.gameObject
	local effGo = goutil.findChild(go, "effect")
	local con = goutil.findChild(go, "item")

	MaterialMgr.resetAll(con)
	self:_clearEffect(effGo)
end

function SaintKnightRegressMainView:startLottery()
	local lotteryInfo = SaintKnightRegressModel.instance:getTempLotteryInfo()
	local prizeCfg

	if not lotteryInfo then
		return
	elseif lotteryInfo.prizeType == 1 then
		prizeCfg = SaintKnightRegressConfig.instance:getSuperLotteryPrizeCfg(self._activityId, lotteryInfo.prizeId)
	elseif lotteryInfo.prizeType == 2 then
		prizeCfg = SaintKnightRegressConfig.instance:getNormalLotteryPrizeCfg(self._activityId, lotteryInfo.prizeId)
	else
		return
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(prizeCfg.prize)

	MaterialMgr.setIcon(self._iconBollCell, matType, matId, nil, nil)

	if matNum >= 10000 then
		matNum = string.format("%dw", checkint(matNum / 10000))
	end

	self._txtBollNum.text = string.format("x%s", matNum)

	GameUtil.setUIGroupIdx(self._bollCell, lotteryInfo.prizeType == 1 and 1 or 0)
	self:_playLotteryAnim()
end

function SaintKnightRegressMainView:_playLotteryAnim()
	local animator = self.mainGO:GetComponent(ComponentType.Animator)
	local spinePath = "effect/prefabs/ui/20250530/shengqichoujiang/shengqichoujiang-ui_p.prefab"

	self._lotterySpineObj = RoleObjectPool.instance:addSpineToParent(self._lotterySpineObj, spinePath, self._lotteryCon, 1, function()
		GameUtil.SetActive(self._lotteryItemView, false)
		RoleObjectPool.instance:playAnimation(self._lotteryCon, "gundong", false, nil, true)
	end)

	local animationClips = animator.runtimeAnimatorController.animationClips
	local baseLayerName = animator:GetLayerName(0)

	for i = 0, animationClips.Length - 1 do
		local nameHash = string.format("%s.%s", baseLayerName, animationClips[i].name)

		nameHash = UnityEngine.Animator.StringToHash(nameHash)

		local smbList = animator:GetBehaviours(nameHash, 0)

		if smbList then
			for i = 0, smbList.Length - 1 do
				smbList[i]:AddListener(self._onStateChange, self)
			end
		end
	end

	GameUtil.SetActive(self._boolMask, true)

	local name = UnityEngine.Animator.StringToHash("saintknightlotteryplay")

	animator:Play(name, 0, 1)
end

function SaintKnightRegressMainView:_playEffect(effGo, clippingGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(clippingGo.transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function SaintKnightRegressMainView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function SaintKnightRegressMainView:_onStateChange(state, animator, animatorStateInfo, layerIndex)
	local name = UnityEngine.Animator.StringToHash("saintknightlotteryplay")

	if animatorStateInfo.shortNameHash == name and state == AnimatorListener.STATE_EXIT then
		MaterialMgr.clearIcon(self._iconBollCell)
		GameUtil.SetActive(self._boolMask, false)

		self._isReqing = false

		self:_refreshView()

		if self._lotterySpineObj then
			RoleObjectPool.instance:removeRole(self._lotterySpineObj)

			self._lotterySpineObj = nil
		end

		local lotteryInfo = SaintKnightRegressModel.instance:getTempLotteryInfo()

		if lotteryInfo.changeSetId then
			MaterialController.instance:showChangeSetInTemp(lotteryInfo.changeSetId)
		elseif lotteryInfo.prizeType == 1 then
			SaintKnightRegressController.instance:openAddressView(self._activityId)
		end
	end
end

function SaintKnightRegressMainView:_updateLotteryItemCell(cell, data, index)
	local go = cell.mainGO
	local isHasGainFinish = false
	local cfg = data.cfg
	local matType, matId, matNum = MaterialMgr.getMatParams(cfg.prize)

	go.name = "cell_" .. index

	local icon = goutil.findChild(go, "icon")
	local imgGain = goutil.findChild(go, "imgGain")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local pos = cfg.pos

	if not pos[3] then
		local x, y, scale = checknumber(pos[1]), checknumber(pos[2]), 1

		GameUtil.setLocalPos(go, x, y, 0)
		GameUtil.setLocalScale(go, pos[3], pos[3], pos[3])
		MaterialMgr.setIcon(icon, matType, matId, nil, nil)
		GameUtil.SetActive(imgGain, isHasGainFinish)

		local quality = MaterialMgr.getGoodsQuality(matType, matId)

		GameUtil.setUIGroupIdx(go, not data.isNormal and 1 or 0)
		GameUtil.SetActive(txtNum.gameObject, matNum > 0)
		GameUtil.addClickHandler(go, function()
			CommonTipsMgr.instance:openMaterialTips(go, matType, matId)
		end)

		if matNum >= 10000 then
			matNum = string.format("%dw", checkint(matNum / 10000))
		end

		txtNum.text = string.format("x%s", matNum)
	end
end

function SaintKnightRegressMainView:_clearLotteryItemCell(cell)
	local go = cell.mainGO
	local icon = goutil.findChild(go, "icon")

	MaterialMgr.clearIcon(icon)
	GameUtil.rmClickHandler(go)
end

function SaintKnightRegressMainView:_updateScoreCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local rewardCell_1 = goutil.findChild(go, "rewardCell_1")
	local rewardCell_2 = goutil.findChild(go, "rewardCell_2")
	local rewardCell_3 = goutil.findChild(go, "rewardCell_3")

	self:_updateRewardCell(view, rewardCell_1, {
		index = 1,
		cfg = data
	}, tag)
	self:_updateRewardCell(view, rewardCell_2, {
		index = 2,
		cfg = data
	}, tag)
	self:_updateRewardCell(view, rewardCell_3, {
		index = 3,
		cfg = data
	}, tag)

	txtScore.text = data.taskCount
end

function SaintKnightRegressMainView:_clearScoreCell(cell)
	local go = cell.gameObject
	local rewardCell_1 = goutil.findChild(go, "rewardCell_1")
	local rewardCell_2 = goutil.findChild(go, "rewardCell_2")
	local rewardCell_3 = goutil.findChild(go, "rewardCell_3")

	self:_clearRewardCell(rewardCell_1)
	self:_clearRewardCell(rewardCell_2)
	self:_clearRewardCell(rewardCell_3)
end

function SaintKnightRegressMainView:_setTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = false,
		id = self._activityCfg.lotteryCost
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function SaintKnightRegressMainView:_onClickInvite()
	UIStateManager.instance:push(ViewName.SaintKnightRegressInviteView, self._activityId)
end

function SaintKnightRegressMainView:_onClickAddress()
	SaintKnightRegressController.instance:openAddressView(self._activityId)
end

function SaintKnightRegressMainView:_onClickBind()
	UIStateManager.instance:push(ViewName.SaintKnightRegressBindView, self._activityId)
end

function SaintKnightRegressMainView:_onClickClose()
	if self._isReqing then
		FloatWordMgr.instance:show("抽奖中")

		return
	end

	self:close()
end

function SaintKnightRegressMainView:_onClickTip()
	TipsFacade.instance:openRulesView("saint_knight_regress_rule")
end

function SaintKnightRegressMainView:_onClickLottery()
	if self._isReqing then
		FloatWordMgr.instance:show("抽奖中")

		return
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(self._activityCfg.lotteryCost)
	local matName = MaterialMgr.getMaterialsNameByCfg(self._activityCfg.lotteryCost)

	if MaterialModel.instance:IsEnough(matType, matId, matNum) then
		local tipsContent = string.format("是否确认消耗%s个【%s】进行扭蛋抽奖？", matNum, matName)

		local function okFunc()
			self._isReqing = true

			GameUtil.SetActive(self._clickMask, true)
			SaintKnightRegressAgent.instance:sendPM_SaintKnightRegressLotteryReq(self._activityId)
		end

		TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
	else
		FloatWordMgr.instance:show("所需道具不足")
	end
end

function SaintKnightRegressMainView:_onClickGainRegressPrize()
	SaintKnightRegressAgent.instance:sendPM_SaintKnightRegressOneKeyGainPrizeReq(self._activityId)
end

function SaintKnightRegressMainView:_onClickInvitePrize()
	SaintKnightRegressAgent.instance:sendPM_SaintKnightRegressOneKeyGainPrizeReq(self._activityId)
end

function SaintKnightRegressMainView:_onClickTask(regressPlayerInfo)
	if regressPlayerInfo then
		UIStateManager.instance:push(ViewName.SaintKnightRegressTaskView, self._activityId, regressPlayerInfo.userId, regressPlayerInfo.userName)
	else
		UIStateManager.instance:push(ViewName.SaintKnightRegressTaskView, self._activityId, RoleModel.instance:getUserId())
	end
end

function SaintKnightRegressMainView:_PM_SaintKnightRegressLotteryRes()
	self:startLottery()
end

return SaintKnightRegressMainView
