-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/corpr/view/CorPrIdentityMainView.lua

module("logic.extensions.corpr.view.CorPrIdentityMainView", package.seeall)

local CorPrIdentityMainView = class("CorPrIdentityMainView", ViewComponent)

function CorPrIdentityMainView:buildUI()
	CorPrIdentityMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._identityView = goutil.findChild(self.mainGO, "identityCol/identityView")
	self._identityCell = goutil.findChild(self.mainGO, "identityCol/identityCell")

	GameUtil.SetActive(self._identityCell, false)

	self._recordPos = self._identityView:GetComponent(typeof(TestRecordPos))
	self._identityCellList = {}
	self._stageEffList = {}
end

function CorPrIdentityMainView:bindEvents()
	CorPrIdentityMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function CorPrIdentityMainView:unbindEvents()
	CorPrIdentityMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function CorPrIdentityMainView:onEnter()
	CorPrIdentityMainView.super.onEnter(self)

	self._challengeId = CorPrChallengeConfig.instance:getCpCurChallengeId()

	if self._challengeId == 0 then
		printError("缺失挑战id")
	end

	GlobalDispatcher:addListener(GlobalNotify.CorPrChallengeGetInfoRes, self._onUpdate, self)
	CorPrChallengeController.instance:sendPM_CorrectPrincipleChallengeGetInfoReq(self._challengeId)

	self._selectIdentityId = 0
end

function CorPrIdentityMainView:onExit()
	CorPrIdentityMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.CorPrChallengeGetInfoRes, self._onUpdate, self)
	self:_onClearIdentityColUI()
end

function CorPrIdentityMainView:_onUpdate()
	self:_onUpdateIdentityColData()
	self:_onUpdateIdentityColUI()
end

function CorPrIdentityMainView:_onUpdateIdentityColData()
	self._identityInfoList = {}

	local cfg = CorPrChallengeConfig.instance:getCpIdentityCfg(self._challengeId)

	for idx, data in ipairs(cfg) do
		local info = {}

		info.data = data

		local result, tips = CorPrChallengeController.instance:getTryEnteryIdentityResultAndTips(self._challengeId, data.identityId)

		info.unlockResult = result
		info.unlockTips = tips
		self._identityInfoList[idx] = info
	end
end

function CorPrIdentityMainView:_onUpdateIdentityColUI()
	local curChallengeIdentityId = CorPrChallengeController.instance:getCurChallengeIdentityId(self._challengeId)

	for idx, info in ipairs(self._identityInfoList) do
		if not self._identityCellList[idx] then
			local cell = {}

			if cell._mainGo == nil then
				local mainGo = goutil.cloneAndSetParent(self._identityCell, self._identityView.transform, string.format("%s_%s", self._identityCell.name, idx))

				cell._mainGo = mainGo
				cell._changeGroup = mainGo:GetComponent(ComponentType.UIChangeGroup)
				cell._light = goutil.findChild(mainGo, "light")
				cell._black = goutil.findChild(mainGo, "black")
				cell._txtRewardAsGraphic = MaterialMgr.findGraphicText(mainGo, "txtReward/txt")
				cell._lock = goutil.findChild(mainGo, "black/lock")
				cell._txtLock = goutil.findChildTextComponent(mainGo, "black/lock/txt")
				cell._pass = goutil.findChild(mainGo, "black/pass")
				cell._effRoot = goutil.findChild(mainGo, "effRoot")
				self._identityCellList[idx] = cell
			end

			local isFighting = curChallengeIdentityId == info.data.identityId
			local isUnlock = info.unlockResult == GameEnum.ResultCode.Success
			local isPass = info.unlockResult == GameEnum.ResultCode.IsPass

			cell._changeGroup:SetState(idx - 1)

			local rewardStr = "未配置"

			if not string.nilorempty(info.data.prize) then
				local matType, matId, matNum = MaterialMgr.getMatParams(info.data.prize)
				local itemStr = string.format("<quad name=%s:%s| size=40 width=1 offsetY=-8/>", matType, matId)

				rewardStr = string.format("可获得：%s x %s", itemStr, matNum)
			end

			cell._txtRewardAsGraphic.text = rewardStr
			cell._txtLock.text = info.unlockTips

			local effParent = cell._effRoot
			local pathName = "20230120/zhenglitiaozhan/fx_ui_zhenglitiaozhan_kuang"

			UIEffectManager.instance:stopEffect(self._stageEffList[effParent])

			if isFighting and effParent and not string.nilorempty(pathName) then
				local path = pathName .. ".prefab"

				local function finishHandler(handlerTarget, eff)
					return
				end

				local function loadedHandler(handlerTarget, eff)
					eff:setParent(effParent.transform)
					eff:setLocalPos(0, 0, 0)
					eff:setScale(1, 1, 1)

					eff.hideEffWhileNotOnTop = true
				end

				local handlerTarget

				self._stageEffList[effParent] = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
			end

			GameUtil.SetActive(cell._lock, not isUnlock)
			GameUtil.SetActive(cell._pass, isPass)
			GameUtil.SetActive(cell._light, isFighting)
			GameUtil.SetActive(cell._black, not isFighting)

			if isFighting then
				local path = "corpr/board_zhengli_0" .. idx
				local bgGo = cell._light

				if not string.nilorempty(path) and bgGo then
					local spriteType = uGuiUtil.SpriteType.BigBg
					local spriteName = string.format("ui/bigbg/%s.png", path)

					local function func()
						return
					end

					uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
				end
			end

			GameUtil.addClickHandler(cell._mainGo, GameUtil.handler(self._onClickIdentityCell, self, cell, info))
		end
	end

	self._recordPos:LoadPlan(0)

	for k, v in ipairs(self._identityCellList) do
		self._identityCellList[k]._localPos = GameUtil.getLocalPos(self._identityCellList[k]._mainGo)
	end

	for idx, cell in ipairs(self._identityCellList) do
		GameUtil.SetActive(cell._mainGo, idx <= #self._identityInfoList)

		if idx <= #self._identityInfoList then
			self:_addPunchAnim(cell._mainGo)
		else
			self:_killTween(cell._mainGo)
		end
	end
end

function CorPrIdentityMainView:_onClearIdentityColUI()
	for idx, cell in pairs(self._identityCellList) do
		GameUtil.rmClickHandler(cell._mainGo)
		self:_killTween(cell._mainGo)
	end

	for k, v in pairs(self._stageEffList) do
		UIEffectManager.instance:stopEffect(v)

		self._stageEffList[k] = nil
	end
end

function CorPrIdentityMainView:_onClickIdentityCell(cell, info)
	FloatWordMgr.instance:show(info.unlockTips)

	if info.unlockResult ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.CorPrIdentityStageView, self._challengeId, info.data.identityId)
end

function CorPrIdentityMainView:_addPunchAnim(go)
	self:_killTween(go)

	local punch = Vector3.New(0, 30, 0)

	go.transform:DOLocalMove(punch, 2):From(true):SetEase(DG.Tweening.Ease.OutSine):SetLoops(-1, DG.Tweening.LoopType.Yoyo)
end

function CorPrIdentityMainView:_killTween(go)
	if not goutil.isNil(go) then
		go.transform:DOKill(true)
	end
end

function CorPrIdentityMainView:_onClickBtnTip()
	local tlData = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	TipsFacade.instance:openRulesView(tlData.ruleKey)
end

return CorPrIdentityMainView
