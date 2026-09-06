-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpMiningView.lua

module("logic.extensions.stknexp.view.StKnExpMiningView", package.seeall)

local StKnExpMiningView = class("StKnExpMiningView", ViewComponent)
local EachTriggerCd = 0.2

function StKnExpMiningView:ctor()
	StKnExpMiningView.super.ctor(self)

	self._sequences = {}
end

function StKnExpMiningView:buildUI()
	StKnExpMiningView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._con = self:getGo("con")
	self._txtOpenTime = self:getTxt("openTime/txt")

	local matScrView = self:getGo("matCol/scrView")
	local matScrCell = self:getGo("matCol/scrCell")

	self._matScrollList = ScrollerList.create(matScrView, matScrCell, GameUtil.handler(self._updateMatCell, self), GameUtil.handler(self._clearMatCell, self))
	self._btnMining = self:getGo("btnMining/btn")
	self._redBtnMining = self:getGo("btnMining/btn/redPoint")
	self._goldBarCon = self:getGo("btnMining/goldBarCon")
	self._btnLongPressHelper = BtnLongPressHelper.create(self._btnMining)
	self._floatwordCell = self:getGo("floatwordCol/cell")
	self._floatwordView = self:getGo("floatwordCol/view")

	GameUtil.SetActive(self._floatwordCell, false)

	self._bubbleTips = self:getGo("bubbleTips")
	self._txtBubbleTips = self:getTxt("bubbleTips/txt")
	self._adjustPosition = self._bubbleTips:GetComponent(ComponentType.UIAdjustPosition)
	self._customInputBubble = UICustomInput.Get(self._bubbleTips)
end

function StKnExpMiningView:bindEvents()
	StKnExpMiningView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	self._customInputBubble:AddListener(function(view, hover)
		if not hover then
			GameUtil.SetActive(self._bubbleTips, false)
		end
	end, self)
	self._btnLongPressHelper:addClickHandler(GameUtil.handler(self._onClickBtnMining, self))
	self._btnLongPressHelper:addPressStartHandler(GameUtil.handler(self._onBtnPressStart, self))
	self._btnLongPressHelper:addPressEndHandler(GameUtil.handler(self._onBtnPressEnd, self))
	self._btnLongPressHelper:addPressUpdateHandler(GameUtil.handler(self._onBtnPressUpdate, self))
end

function StKnExpMiningView:unbindEvents()
	StKnExpMiningView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	self._customInputBubble:RemoveListener()
	self._btnLongPressHelper:clearAllHandlers()
end

function StKnExpMiningView:onEnter()
	StKnExpMiningView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = StKnExpController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_SaintKnightExpeditionInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_SaintKnightExpeditionMiningRes, self._handlePM_SaintKnightExpeditionMiningRes, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._onMaterialCountChange, self)
	self.addGEvent(self, GlobalNotify.UpdataEnergyCount, self._onMaterialCountChange, self)
	GameUtil.SetActive(self._bubbleTips, false)
	self:_onSetUI()
	self:_onUpdate()
end

function StKnExpMiningView:onExit()
	StKnExpMiningView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnMining)
	self._matScrollList:dispose()
	self:_unloadSpine()
	self:_clearAllFloatword()
end

function StKnExpMiningView:destroyUI()
	StKnExpMiningView.super.destroyUI(self)
	self:_onDestorySpine()
end

function StKnExpMiningView:_onMaterialCountChange()
	StKnExpController.instance:updateRedInMining(self._activityId)
end

function StKnExpMiningView:_handlePM_SaintKnightExpeditionMiningRes()
	local count = 0

	self._oldExps = self._oldExps or {}

	for _, cultType in ipairs(StKnExpEnum.CultTypeList) do
		if not self._oldExps[cultType] then
			local old = 0
			local new = self._subMo:getCultExp(cultType)
			local diff = new - old

			if diff > 0 then
				count = count + 1

				local name = StKnExpEnum.CultNames[cultType]
				local fData = StKnExpConfig.instance:getFloatwordData(diff)
				local floatStr = fData and not string.nilorempty(fData.color) and string.format("<color=#%s>%s经验+%s</color>", fData.color, name, diff) or string.format("%s经验+%s", name, diff)
				local width = GameUtil.getWidth(self._floatwordView)
				local height = GameUtil.getHeight(self._floatwordView)
				local randomX = (math.random() - 0.5) * width
				local randomY = (math.random() - 0.5) * height
				local randomPos = Vector2.New(randomX, randomY)
				local delayTime = (count - 1) * 0.2

				self:_playFloatword(randomPos, floatStr, delayTime)
			end
		end
	end

	self:_onUpdate()
end

function StKnExpMiningView:_onSetUI()
	local mat = self._subMo:getMiningCostMat()

	self:_loadSpine()

	local list = {}
	local tab = {
		showAdd = true,
		id = mat.matType .. ":" .. mat.matId,
		showAddCallBack = function()
			EnergyController.instance:openBuyView(mat.matId)
		end
	}

	table.insert(list, tab)
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)

	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	RedPointController.instance:regRedPoint(self._redBtnMining, RedPointModel.ID_STKNEXP_MINING)
end

function StKnExpMiningView:_onUpdate()
	self._matScrollList:reloadData(StKnExpEnum.CultTypeList)
end

function StKnExpMiningView:_updateMatCell(view, cell, cultType, tag)
	local exp = self._subMo:getCultExp(cultType)
	local cultData = self._subMo:getCultData(cultType, exp)
	local level = self._subMo:getCultLevel(cultType)

	if cultData then
		if not cultData.showLevel then
			local showLevel = 0
			local showData = StKnExpConfig.instance:getCultShowData(cultType, showLevel)
			local progress = self._subMo:getProgressByExp(cultType, exp)

			if showData == nil then
				printError(string.format("错误，showData为空，cultType:%s,showLevel:%s", cultType, showLevel))
			end

			local mainGo = cell.gameObject
			local qualityBg = goutil.findChild(mainGo, "qualityBg")
			local icon = goutil.findChild(mainGo, "icon")
			local txtLevel = goutil.findChildTextComponent(mainGo, "level/txt")
			local expSlider = goutil.findChildComponent(mainGo, "expSlider", ComponentType.Slider)
			local iconName = showData and showData.icon

			if not string.nilorempty(iconName) then
				local url = string.format("%s.png", iconName)

				uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, url)
			else
				uGuiUtil.clearImage(icon)
			end

			if showData then
				if not showData.quality then
					local quality = 0
					local state = 1 + quality

					GameUtil.setUIGroupIdx(qualityBg, state)

					expSlider.value = progress
					txtLevel.text = progress >= 1 and string.format("(Max)\n%s级", showLevel) or string.format("%s级", showLevel)

					GameUtil.addClickHandler(mainGo, function()
						self:_showBubbleTips(mainGo, cultType, showLevel)
					end, self)
				end
			end
		end
	end
end

function StKnExpMiningView:_clearMatCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(mainGo)
end

function StKnExpMiningView:_showBubbleTips(root, cultType, showLevel)
	local goOrPos = root
	local pos = goOrPos
	local sizeDelta = {
		0,
		0
	}

	if goOrPos and goOrPos.gameObject then
		local rect = goOrPos.gameObject:GetComponent("RectTransform")

		if rect ~= nil then
			sizeDelta = {
				rect.sizeDelta.x,
				rect.sizeDelta.y
			}
		end

		pos = goOrPos.gameObject.transform.position

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)
	end

	self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])

	local showData = StKnExpConfig.instance:getCultShowData(cultType, showLevel)

	self._txtBubbleTips.text = showData.desc

	GameUtil.SetActive(self._bubbleTips, true)
end

function StKnExpMiningView:_loadSpine()
	local spineRoot = self._con
	local view = self
	local spinePath = "character/zhiren_aoqiwakuang/zhiren_aoqiwakuang-ui_p.prefab"

	self._spineCtrl = self._spineCtrl or StKnExpMiningSpineCtrl.New()

	self._spineCtrl:onInit(spineRoot, view, spinePath)
end

function StKnExpMiningView:_unloadSpine()
	if self._spineCtrl then
		self._spineCtrl:onClear()
	end
end

function StKnExpMiningView:_onDestorySpine()
	if self._spineCtrl then
		self._spineCtrl:onDestory()

		self._spineCtrl = nil
	end
end

function StKnExpMiningView:_playAnimSpine(animName, isLoop)
	if self._spineCtrl and not string.nilorempty(animName) then
		local function onComplete(trackEntry)
			if isLoop then
				if self._isLoopingPlayAnim then
					self:_playAnimSpine(animName, isLoop)
				else
					self._spineCtrl:playDefaultAnim()
				end
			else
				self._spineCtrl:playDefaultAnim()
			end
		end

		self._spineCtrl:_playAnim(animName, false, onComplete, true)
	end
end

function StKnExpMiningView:_playFloatword(pos, value, delayTime)
	local mainGo = self:_fetchFloatwordGo()
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	self:_clearFloatwordAnim(mainGo)

	txtDesc.text = string.format("<size=%s>%s</size>", Mathf.Random(21, 25), value)

	local sequence = DG.Tweening.DOTween.Sequence()

	self._sequences[mainGo] = sequence

	local targeGo = mainGo

	GameUtil.setLocalPos(mainGo, pos.x, pos.y, 0)
	GameUtil.SetActive(targeGo, false)

	local toPos = GameUtil.getLocalPos(targeGo)

	toPos.y = toPos.y + 68

	local tweenerMove = targeGo.transform:DOLocalMove(toPos, 0.4)

	tweenerMove:SetEase(DG.Tweening.Ease.OutCubic)
	sequence:AppendInterval(delayTime)
	sequence:AppendCallback(function()
		GameUtil.SetActive(targeGo, true)
	end)
	sequence:Append(tweenerMove)
	sequence:AppendInterval(Mathf.Random(0, 1000) / 1000)
	sequence:OnComplete(function()
		GameUtil.SetActive(targeGo, false)
		self:_clearFloatword(mainGo)
	end)
end

function StKnExpMiningView:_clearAllFloatword()
	for _, mainGo in ipairs(self._sequences) do
		self:_clearFloatword(mainGo)
	end

	if self._floatwordGoPool then
		self._floatwordGoPool:clear()

		self._floatwordGoPool = nil
	end
end

function StKnExpMiningView:_clearFloatword(mainGo)
	self:_clearFloatwordAnim(mainGo)
	self._returnFloatwordGo(mainGo)
end

function StKnExpMiningView:_clearFloatwordAnim(mainGo)
	if self._sequences[mainGo] then
		self._sequences[mainGo]:Kill(true)

		self._sequences[mainGo] = nil
	end
end

function StKnExpMiningView:_fetchFloatwordGo()
	if self._floatwordGoPool == nil then
		self:_creatFloatwordPool()
	end

	return self._floatwordGoPool:fetchObject()
end

function StKnExpMiningView:_returnFloatwordGo(go)
	if self._floatwordGoPool then
		self._floatwordGoPool:returnObject(go)
	end
end

function StKnExpMiningView:_creatFloatwordPool()
	if self._floatwordGoPool ~= nil then
		return
	end

	local function createFunc()
		local go = goutil.cloneAndSetParent(self._floatwordCell, self._floatwordView.transform, self._floatwordCell.name)

		GameUtil.SetActive(go, false)

		return go
	end

	local function disposeFunc(go)
		goutil.destroy(go)
	end

	local function resetFunc(go)
		GameUtil.SetActive(go, false)
		goutil.addChildToParent(go, self._floatwordView)
	end

	self._floatwordGoPool = ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

function StKnExpMiningView:_onBtnPressStart()
	self._deltaTime = 0
end

function StKnExpMiningView:_onBtnPressEnd(pressTime)
	self._isLoopingPlayAnim = false
end

function StKnExpMiningView:_onBtnPressUpdate(deltaTime, pressTime)
	self._deltaTime = self._deltaTime + deltaTime

	if self._deltaTime < EachTriggerCd then
		return
	end

	self._deltaTime = 0

	local result = self._subMo:getTryResultAndTipsMining(false)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	if not self._isLoopingPlayAnim then
		self._isLoopingPlayAnim = true

		self:_playAnimSpine("wakuang", true)
	end

	self._oldExps = {}

	for _, cultType in ipairs(StKnExpEnum.CultTypeList) do
		self._oldExps[cultType] = self._subMo:getCultExp(cultType)
	end

	StKnExpController.instance:sendPM_SaintKnightExpeditionMiningReq(self._activityId)
end

function StKnExpMiningView:_onClickBtnMining()
	self._isLoopingPlayAnim = false

	local result = self._subMo:getTryResultAndTipsMining(true)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	self._oldExps = {}

	for _, cultType in ipairs(StKnExpEnum.CultTypeList) do
		self._oldExps[cultType] = self._subMo:getCultExp(cultType)
	end

	self:_playAnimSpine("wakuang", false)
	StKnExpController.instance:sendPM_SaintKnightExpeditionMiningReq(self._activityId)
end

function StKnExpMiningView:_onClickBtnTip()
	local value = StKnExpConfig.instance:getActDataValue(self._activityId, "miningRuleKey", false)

	TipsFacade.instance:openRulesView(value)
end

return StKnExpMiningView
