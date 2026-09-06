-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonglottery/view/NaiLongLotteryPlayView.lua

module("logic.extensions.nailonglottery.view.NaiLongLotteryPlayView", package.seeall)

local NaiLongLotteryPlayView = class("NaiLongLotteryPlayView", ViewComponent)

function NaiLongLotteryPlayView:buildUI()
	NaiLongLotteryPlayView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._itemView = self:getGo("lottery/itemView")
	self._itemCell = self:getGo("lottery/itemCell")
	self._btnShare = self:getGo("btnShare")
	self._redBtnShare = self:getGo("btnShare/redPoint")
	self._txtLotteryTimes = self:getTxt("lottery/times/txt")
	self._lotteryIcon = self:getGo("lottery/times/txt/icon")
	self._btnLottery = self:getGo("lottery/btnLottery")
	self._boolMask = self:getGo("boolMask")
	self._bollCell = self:getGo("boolMask/bollCell")
	self._iconBollCell = self:getGo("boolMask/bollCell/icon")
	self._clickMask = self:getGo("clickMask")
end

function NaiLongLotteryPlayView:bindEvents()
	NaiLongLotteryPlayView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnShare, self._onClickBtnShare, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickBtnLottery, self)
	GameUtil.addClickHandler(self._clickMask, self._onClickMask, self)
end

function NaiLongLotteryPlayView:unbindEvents()
	NaiLongLotteryPlayView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnShare)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._clickMask)
end

function NaiLongLotteryPlayView:onEnter()
	NaiLongLotteryPlayView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = NaiLongLotteryController.instance:getActivityType()

	local isInTime = NaiLongLotteryController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = NaiLongLotteryConfig.instance:getActData(self._activityId)
	self._naiLongLotteryMo = NaiLongLotteryController.instance:getNaiLongLotteryMo(self._activityId)
	self._changeSetId = nil
	self._isReqing = false

	GameUtil.SetActive(self._clickMask, false)
	GameUtil.SetActive(self._boolMask, false)
	self.addGEvent(self, GlobalNotify.HandlePM_ShareLotteryGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShareLotteryLotteryRes, self._handlePM_ShareLotteryLotteryRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShareLotteryShareRes, self._onUpdate, self)
	self:_onSetUI()
	self:_onUpdate()
end

function NaiLongLotteryPlayView:onExit()
	NaiLongLotteryPlayView.super.onExit(self)
	MaterialMgr.clearIcon(self._iconBollCell)
	MaterialMgr.clearIcon(self._lotteryIcon)
	self:_onClearItemCol()
end

function NaiLongLotteryPlayView:_handlePM_ShareLotteryLotteryRes(status, msg)
	if status ~= 0 then
		self._isReqing = false

		GameUtil.SetActive(self._clickMask, false)

		return
	end

	self._changeSetId = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(self._changeSetId)

	local prizeId = msg.prizeId
	local data = NaiLongLotteryConfig.instance:getPrizeData(self._activityId, prizeId)
	local matType, matId, matNum = MaterialMgr.getMatParams(data.prize)

	MaterialMgr.setIcon(self._iconBollCell, matType, matId, nil, nil)
	GameUtil.setUIGroupIdx(self._bollCell, data.qualityShowIdx)
	self:_playLotteryAnim()
end

function NaiLongLotteryPlayView:_onSetUI()
	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local matType, matId, matNum = MaterialMgr.getMatParams(self._actData.lotteryCost)

	MaterialMgr.setIcon(self._lotteryIcon, matType, matId, nil, nil)
end

function NaiLongLotteryPlayView:_onUpdate()
	self._isHavePrizeCanGain = self._naiLongLotteryMo:isHavePrizeCanGain()

	self:_onUpdateItemColUI()

	self._txtLotteryTimes.text = self._naiLongLotteryMo:getLotteryTimes()
end

function NaiLongLotteryPlayView:_onUpdateItemColUI()
	local cfg = NaiLongLotteryConfig.instance:getPrizeCfg(self._activityId) or {}

	GameUtil.updateCellsList(self._itemView, self._itemCell, cfg, self._updateItemCell, self)
end

function NaiLongLotteryPlayView:_onClearItemCol()
	GameUtil.clearCells(self._itemView, self._clearItemCell, self)
end

function NaiLongLotteryPlayView:_updateItemCell(mainGo, data, index)
	local prizeId = data.prizeId
	local isHasGainFinish = self._naiLongLotteryMo:getLeftPrizeGainTimes(prizeId) <= 0
	local matType, matId, matNum = MaterialMgr.getMatParams(data.prize)
	local icon = goutil.findChild(mainGo, "icon")
	local imgGain = goutil.findChild(mainGo, "imgGain")
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")

	if data.pos then
		local pos = data.pos

		if not pos[3] then
			local x, y, scale = checknumber(pos[1]), checknumber(pos[2]), 1

			GameUtil.setLocalPos(mainGo, x, y, 0)
			GameUtil.setLocalScale(mainGo, pos[3], pos[3], pos[3])
		end
	end

	MaterialMgr.setIcon(icon, matType, matId, nil, nil)
	GameUtil.SetActive(imgGain, isHasGainFinish)

	local quality = MaterialMgr.getGoodsQuality(matType, matId)

	GameUtil.setUIGroupIdx(mainGo, data.qualityShowIdx)

	local num = self._naiLongLotteryMo:getLeftPrizeGainTimes(prizeId)

	txtNum.text = string.format("x%s", num)

	GameUtil.SetActive(txtNum.gameObject, num > 0)
	GameUtil.addClickHandler(mainGo, function()
		CommonTipsMgr.instance:openMaterialTips(mainGo, matType, matId, matNum)
	end)
end

function NaiLongLotteryPlayView:_clearItemCell(mainGo)
	local icon = goutil.findChild(mainGo, "icon")

	MaterialMgr.clearIcon(icon)
	GameUtil.rmClickHandler(mainGo)
end

function NaiLongLotteryPlayView:_playLotteryAnim()
	local animator = self.mainGO:GetComponent(ComponentType.Animator)
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

	local name = UnityEngine.Animator.StringToHash("nailonglotteryplay")

	animator:Play(name, 0, 1)
end

function NaiLongLotteryPlayView:_onStateChange(state, animator, animatorStateInfo, layerIndex)
	local name = UnityEngine.Animator.StringToHash("nailonglotteryplay")

	if animatorStateInfo.shortNameHash == name and state == AnimatorListener.STATE_EXIT then
		MaterialMgr.clearIcon(self._iconBollCell)

		if self._changeSetId then
			MaterialController.instance:showChangeSetInTemp(self._changeSetId)

			self._changeSetId = nil
			self._isReqing = false

			GameUtil.SetActive(self._boolMask, false)
			GameUtil.SetActive(self._clickMask, false)
			self:_onUpdate()
		end
	end
end

function NaiLongLotteryPlayView:_onClickBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function NaiLongLotteryPlayView:_onClickBtnShare()
	UIStateManager.instance:push(ViewName.NaiLongLotteryShareView, self._activityId)
end

function NaiLongLotteryPlayView:_onClickBtnLottery()
	if self._isReqing then
		FloatWordMgr.instance:show("抽奖中")

		return
	end

	if not self._isHavePrizeCanGain then
		FloatWordMgr.instance:show("所有奖励已获取")

		return
	end

	if self._naiLongLotteryMo:getLotteryTimes() <= 0 then
		FloatWordMgr.instance:show("可抽奖次数不足")

		return
	end

	local costNum = self._naiLongLotteryMo:getLotteryCostNum()
	local matName = MaterialMgr.getMaterialsNameByCfg(self._actData.lotteryCost)
	local tipsContent = string.format("是否确认消耗%s个【%s】进行扭蛋抽奖？", costNum, matName)

	local function okFunc()
		self._isReqing = true

		GameUtil.SetActive(self._clickMask, true)
		NaiLongLotteryController.instance:sendPM_ShareLotteryLotteryReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

function NaiLongLotteryPlayView:_onClickMask()
	FloatWordMgr.instance:show("抽奖中")
end

return NaiLongLotteryPlayView
