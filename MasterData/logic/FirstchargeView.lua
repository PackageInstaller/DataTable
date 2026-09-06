-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/FirstchargeView.lua

module("logic.extensions.firstcharge.view.FirstchargeView", package.seeall)

local FirstchargeView = class("FirstchargeView", ViewComponent)

function FirstchargeView:ctor()
	FirstchargeView.super.ctor(self)
end

function FirstchargeView:buildUI()
	FirstchargeView.super.buildUI(self)

	self._mask = self:getGo("mask")
	self._goTop = self:getGo("mask/top")
	self._goTopBg = self:getGo("mask/top/bg")
	self._goTopLast = self:getGo("mask/top_Last")
	self._goTopFirst = self:getGo("mask/top_First")
	self._goTopFirstBG1 = self:getGo("mask/top_First/bg1")
	self._goTopFirstBG2 = self:getGo("mask/top_First/bg2")
	self._goEff = self:getGo("mask/eff")
	self._goBottom = self:getGo("mask/bottom")
	self._petInfoPos = self:getGo("mask/petInfoPos")
	self._goPlayCv = self:getGo("mask/btnPlayCv")
	self._goBubble = self:getGo("mask/btnPlayCv/bubble")
	self._goBtnReceive = self:getGo("mask/top/btnReceive")
	self._goBtnGotoCharge = self:getGo("mask/top/btnGotoCharge")
	self._goMark = self:getGo("mask/top/mark")
	self._goBtnReceiveLast = self:getGo("mask/top_Last/btnReceive")
	self._goBtnGotoChargeLast = self:getGo("mask/top_Last/btnGotoCharge")
	self._goMarkFirst = self:getGo("mask/top_First/mark")
	self._goBtnReceiveFirst = self:getGo("mask/top_First/btnReceive")
	self._goBtnGotoChargeFirst = self:getGo("mask/top_First/btnGotoCharge")
	self._goMark = self:getGo("mask/top/mark")
	self._goSkill = self:getGo("mask/petInfoPos/btnSkill")
	self._goChallenge = self:getGo("mask/petInfoPos/btnChallenge")
	self._btnChallengeLastGo = self:getGo("mask/top_Last/btnChallenge")
	self._redpointTop = self:getGo("mask/petInfoPos/btnChallenge/redpoint")
	self._redpointTopLast = self:getGo("mask/top_Last/btnChallenge/redpoint")
	self._btnClose = self:getBtn("mask/btnClose")
	self._btnSkill = self:getBtn("mask/petInfoPos/btnSkill")
	self._btnChallenge = self:getBtn("mask/petInfoPos/btnChallenge")
	self._btnChallengeLast = self:getBtn("mask/top_Last/btnChallenge")
	self._btnInfo = self:getBtn("mask/petInfoPos/btnInfo")
	self._btnPlayCv = self:getBtn("mask/btnPlayCv")
	self._btnReceive = self:getBtn("mask/top/btnReceive")
	self._btnGotoCharge = self:getBtn("mask/top/btnGotoCharge")
	self._btnReceiveLast = self:getBtn("mask/top_Last/btnReceive")
	self._btnReceiveFirst = self:getBtn("mask/top_First/btnReceive")
	self._btnGotoChargeLast = self:getBtn("mask/top_Last/btnGotoCharge")
	self._btnGotoChargeFirst = self:getBtn("mask/top_First/btnGotoCharge")
	self._btnItemCardPool = self:getBtn("mask/top_Last/itemList/itemCardPool/con")
	self._btnGo = self:getBtn("mask/top_Last/btnGo")
	self.txtTime = self:getTxt("mask/time/txt")
	self._sldProgress = self:getSlider("mask/bottom/sldProgress")
	self._goProgress = self:getGo("mask/bottom/sldProgress")
	self._txtProgress = self:getTxt("mask/top/progress")
	self._txtProgressLast = self:getTxt("mask/top_Last/progress")
	self._txtProgressFirst = self:getTxt("mask/top_First/progress")
	self._txtBtnReceive = self:getTxt("mask/top_First/btnReceive/Text")
	self._itemsFirst = {}

	for i = 1, 3 do
		local item = {}

		item.go = goutil.findChild(self._goTopFirst, "itemList/item_" .. i)
		item.mark = goutil.findChild(item.go, "imgReceive")
		item.cellList = {}

		for k = 1, 4 do
			item.cellList[k] = goutil.findChild(item.go, "con_" .. k)
		end

		self._itemsFirst[i] = item
	end

	self._items = {}

	for i = 1, 4 do
		local item = {}

		item.go = goutil.findChild(self._goTop, "itemList/item" .. i)
		item.con = goutil.findChild(item.go, "con")
		self._items[i] = item
	end

	self._itemsLast = {}

	for i = 1, 3 do
		local item = {}

		item.go = goutil.findChild(self._goTopLast, "itemList/item" .. i)
		item.con = goutil.findChild(item.go, "con")
		self._itemsLast[i] = item
	end

	self._tabs = {}

	for i = 1, 6 do
		local tab = {}

		tab.go = goutil.findChild(self._goBottom, "btnList/item_" .. i)
		tab.btn = goutil.findChild(tab.go, "btn")
		tab.con = goutil.findChild(tab.btn, "con")
		tab.mask = goutil.findChild(tab.go, "mask")
		tab.txtPrice = goutil.findChildTextComponent(tab.go, "txtPrice")
		tab.txtName = goutil.findChildTextComponent(tab.go, "txtName")
		tab.redPoint = goutil.findChild(tab.go, "redPoint")
		self._tabs[i] = tab
	end

	self._changeGroups = self:getGo("mask"):GetComponent(ComponentType.UIChangeGroup)
	self._petCom = self:getGo("mask/petcom/pet")
	self.petPhoto = PetPhotoShow.Get(self._petCom)
	self._bgReward = self:getGo("mask/bgReward")
	self._gifts = {}

	for i = 1, 2 do
		local gift = {}
		local go = goutil.findChild(self._bgReward, "com/btnGift" .. i)

		gift.go = go
		gift.btn = GameUtil.asBtn(go)
		gift.effCom = goutil.findChild(go, "eff")
		gift.eff = nil
		gift.txtName = goutil.findChildTextComponent(go, "txtName")
		gift.con = goutil.findChild(go, "con")
		gift.goodId = 0

		table.insert(self._gifts, gift)
	end

	self._jumpTos = {}

	for i = 1, 2 do
		local jumpTo = {}
		local go = goutil.findChild(self._bgReward, "com/btnJumpTo" .. i)

		jumpTo.go = go
		jumpTo.btn = GameUtil.asBtn(go)
		jumpTo.effCom = goutil.findChild(go, "eff")
		jumpTo.eff = nil
		jumpTo.txtName = goutil.findChildTextComponent(go, "txtName")
		jumpTo.con = goutil.findChild(go, "con")
		jumpTo.targetView = nil

		table.insert(self._jumpTos, jumpTo)
	end
end

function FirstchargeView:bindEvents()
	FirstchargeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnChallenge:AddClickListener(self._onClickBtnChallenge, self)
	self._btnChallengeLast:AddClickListener(self._onClickBtnChallengeLast, self)
	self._btnSkill:AddClickListener(self._onClickBtnSkill, self)
	self._btnInfo:AddClickListener(self._onClickBtnInfo, self)
	self._btnPlayCv:AddClickListener(self._onClickBtnPlayCv, self)
	self._btnItemCardPool:AddClickListener(self._onClickBtnItemCardPool, self)
	self._btnReceive:AddClickListener(self._onClickBtnReceive, self)
	self._btnGotoCharge:AddClickListener(self._onClickBtnGotoCharge, self)
	self._btnReceiveLast:AddClickListener(self._onClickBtnReceiveLast, self)
	self._btnReceiveFirst:AddClickListener(self._onClickBtnReceiveFirst, self)
	self._btnGotoChargeLast:AddClickListener(self._onClickBtnGotoCharge, self)
	self._btnGotoChargeFirst:AddClickListener(self._onClickBtnGotoCharge, self)
	self._btnGo:AddClickListener(self._onClickBtnReceiveLast, self)

	for i = 1, 6 do
		GameUtil.addClickHandler(self._tabs[i].btn, GameUtil.handler(self._onSwitchTop, self, i))
	end

	for i = 1, 2 do
		self._gifts[i].btn:AddClickListener(function()
			self:_onClickBtnGift(i)
		end, self)
		self._jumpTos[i].btn:AddClickListener(function()
			self:_onClickBtnJumpTo(i)
		end, self)
	end
end

function FirstchargeView:unbindEvents()
	FirstchargeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnChallengeLast:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnPlayCv:RemoveClickListener()
	self._btnReceive:RemoveClickListener()
	self._btnGotoCharge:RemoveClickListener()
	self._btnReceiveLast:RemoveClickListener()
	self._btnGotoChargeLast:RemoveClickListener()
	self._btnGotoChargeFirst:RemoveClickListener()
	self._btnReceiveFirst:RemoveClickListener()
	self._btnItemCardPool:RemoveClickListener()
	self._btnGo:RemoveClickListener()

	for i = 1, 6 do
		GameUtil.rmClickHandler(self._tabs[i].btn)
	end

	for i = 1, 2 do
		self._gifts[i].btn:RemoveClickListener()
		self._jumpTos[i].btn:RemoveClickListener()
	end
end

function FirstchargeView:destroyUI()
	FirstchargeView.super.destroyUI(self)
end

function FirstchargeView:onEnterFinished()
	FirstchargeView.super.onEnterFinished(self)
end

function FirstchargeView:onExit()
	FirstchargeView.super.onExit(self)
	removetimer(self._onFinshAnimation, false)
	self:_clearRes()
	self:_hideLihui()
	self.petPhoto:clear()
	PetCvController.instance:turnOffCurCv()
	GlobalDispatcher:removeListener(PayShopAgent.NotifyPayShopItemBuySucRes, self.handlePayShopItemBuySucRes, self)
	GlobalDispatcher:removeListener(PayAgent.NotifyPayResultRes, self.handleNotifyPayResultRes, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._dailyReset, self)
	removetimer(self.updateTime, self)
end

function FirstchargeView:onExitFinished()
	FirstchargeView.super.onExitFinished(self)
end

function FirstchargeView:onEnter()
	FirstchargeView.super.onEnter(self)
	GameUtil.SetActive(self.mainGO, false)

	self._playingAni = false
	self._showIndex = nil

	FirstChargeController.instance:sendGetInfoReq(self._onRefreshUI, self)
	GlobalDispatcher:addListener(PayShopAgent.NotifyPayShopItemBuySucRes, self.handlePayShopItemBuySucRes, self)
	GlobalDispatcher:addListener(PayAgent.NotifyPayResultRes, self.handleNotifyPayResultRes, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._dailyReset, self)
end

function FirstchargeView:updateTime()
	local activityId = FirstChargeModel.instance:getCurActivityId()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.FirstCharge, activityId)
	local nowTime = ServerTime.now()
	local leftTime = endTime - nowTime

	leftTime = math.max(0, leftTime)
	self.txtTime.text = langPara("活动剩余时间：%s", GameUtil.FormatTimeSymbol(leftTime))
end

function FirstchargeView:_dailyReset()
	FirstChargeController.instance:sendGetInfoReq(self._updateProgress, self)
end

function FirstchargeView:_onClickBtnChallenge()
	if self._showPetId == nil then
		self:_updateShowPet()

		return
	end

	PetCvController.instance:turnOffCurCv()
	ViewAutoShowController.instance:saveCurModalView()
	FuncOpenController.instance:openFunc(149, self._showPetId)
end

function FirstchargeView:_onClickBtnChallengeLast()
	PetCvController.instance:turnOffCurCv()
	ViewAutoShowController.instance:saveCurModalView()
	FuncOpenController.instance:openFunc(149, 10313)
end

function FirstchargeView:_onClickBtnSkill()
	if self._showPetId == nil then
		self:_updateShowPet()

		return
	end

	PetCvController.instance:turnOffCurCv()
	PetbookController.instance:previewBattle(self._showPetId)
end

function FirstchargeView:_onClickBtnInfo()
	if self._showPetId == nil then
		self:_updateShowPet()

		return
	end

	PetCvController.instance:turnOffCurCv()
	ViewAutoShowController.instance:saveCurModalView()
	PetbookController.instance:openPetinfoView(self._showPetId)
end

function FirstchargeView:_onClickBtnPlayCv()
	if self._showPetId == nil then
		self:_updateShowPet()

		return
	end

	local pos = self._goBubble.transform.position

	if self._showIndex == 1 then
		self._firstCvs = self._firstCvs or self:_getFirstCvAfterFiltr(self._showPetId, {
			4
		})

		local cvId = self._firstCvs[math.random(#self._firstCvs)]

		PetCvController.instance:_playPetCvByIndex(self._showPetId, cvId, true, pos)
	else
		PetCvController.instance:playPetCv(self._showPetId, nil, true, pos)
	end
end

function FirstchargeView:_getFirstCvAfterFiltr(raceId, removeCvs)
	local cfgs = CharacterConfig.instance:getPetCvCfg(raceId) or {}
	local playCvIds = {}

	for i = 1, #cfgs do
		table.insert(playCvIds, i)
	end

	local _rmcv = removeCvs or {}

	for i = 1, #_rmcv do
		table.removebyvalue(playCvIds, _rmcv[i])
	end

	return playCvIds
end

function FirstchargeView:_onClickBtnItemCardPool()
	local annuityId = PayShopModel.instance:getCurAnnuityId()
	local data = PayShopModel.instance:getAnnuityInfo(annuityId)
	local cfg = PayShopConfig.instance:getAnnuityCfgById(annuityId)

	if data and data.money >= cfg.price then
		FloatWordMgr.instance:show("【万象·次元圣龙】专属UP召唤已开启")
	else
		FloatWordMgr.instance:show("成功激活年费卡后，\n将开启【万象·次元圣龙】专属UP召唤")
	end
end

function FirstchargeView:_onClickBtnGift(id)
	if not self._gifts[id].goodId then
		self:_updateGift()

		return
	end

	PetCvController.instance:turnOffCurCv()

	local data = {
		id = self._gifts[id].goodId,
		times = PayShopModel.instance:getMibaoBuyTimesById(self._gifts[id].goodId)
	}

	UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data)
end

function FirstchargeView:_onClickBtnJumpTo(id)
	local target = self._jumpTos[id].targetView

	if string.nilorempty(target) then
		self:_updateJumpTo()

		return
	end

	PetCvController.instance:turnOffCurCv()
	GotoMgr.gotoByString(target)
end

function FirstchargeView:_onClickBtnReceive()
	local actId = FirstChargeModel.instance:getCurActivityId()

	if self._showIndex == nil and not self._showCfg.whetherGet then
		return
	end

	FirstChargeController.instance:sendGetPrizeReq(actId, self._showIndex - 1, nil, self._updateProgress, self)
end

function FirstchargeView:_onClickBtnReceiveFirst()
	local actId = FirstChargeModel.instance:getCurActivityId()

	if self._showIndex == nil and not self._showCfg.whetherGet then
		return
	end

	if FirstChargeModel.instance:getIsAbleToSign(self._showCfg.consumeMoney) then
		FirstChargeController.instance:sendGetPrizeReq(actId, self._showIndex - 1, self._showCfg.consumeMoney, self._updateProgress, self)
	else
		FloatWordMgr.instance:show("明日再来")
	end
end

function FirstchargeView:_onClickBtnGotoCharge()
	PetCvController.instance:turnOffCurCv()
	ViewAutoShowController.instance:saveCurModalView()
	PayShopController.instance:openView("GodDiamond")
end

function FirstchargeView:_onClickBtnReceiveLast()
	PetCvController.instance:turnOffCurCv()
	ViewAutoShowController.instance:saveCurModalView()
	UIStateManager.instance:push(ViewName.YearCardMainView)
end

function FirstchargeView:_onRefreshUI()
	self:_clearRes()

	self._cfgs = FirstChargeModel.instance:getCurActCfgs()
	self._totalLevel = #self._cfgs

	if self._cfgs then
		for i = 1, self._totalLevel do
			local resPath = string.nilorempty(self._cfgs[i].iconLevel) or self._cfgs[i].iconLevel

			uGuiUtil.setSpriteToImage(self._tabs[i].con, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(self._cfgs[i].iconLevel))

			self._tabs[i].txtName.text = self._cfgs[i].descLevel
			self._tabs[i].txtPrice.text = self._cfgs[i].consumeMoney / 100 .. "元"

			GameUtil.SetActive(self._tabs[i].go, true)
		end

		GameUtil.setWidth(self._goProgress, 1200 - 1200 / self._totalLevel)
		GameUtil.SetActive(self._goTop, false)
		GameUtil.SetActive(self._goTopFirst, false)
		GameUtil.SetActive(self._goTopLast, false)
		self:_updateProgress()
		self:_loadEffs()
	else
		self:close()
	end

	local actId = FirstChargeModel.instance:getCurActivityId()

	if checknumber(actId) == 8001 then
		GameUtil.SetActive(self._goTopFirstBG1, true)
		GameUtil.SetActive(self._goTopFirstBG2, false)
	else
		GameUtil.SetActive(self._goTopFirstBG1, false)
		GameUtil.SetActive(self._goTopFirstBG2, true)
	end

	local isAutoOpen = checkint(self:getFirstParam()) > 0
	local playerPrefsKey = "firstCharge_" .. FirstChargeModel.instance:getCurActivityId() .. LoginModel.instance.userId

	playerPrefsKey = isAutoOpen and playerPrefsKey .. "_1" or playerPrefsKey .. "_0"

	local isFirstOpen = UnityEngine.PlayerPrefs.GetInt(playerPrefsKey)

	if isFirstOpen == 0 then
		GameUtil.SetActive(self.mainGO, false)

		self._playingAni = true

		AnimationPlayer.play("storyconfig/animations/shouchong_panduola.txt", nil, self._onStartAnimation, self)
		UnityEngine.PlayerPrefs.SetInt(playerPrefsKey, 1)
		PetCvController.instance:_playPetCvByIndex(10309, 4, false, self._goPlayCv.transform.position)
	end

	self:updateTime()
	removetimer(self.updateTime, self)
	settimer(1, self.updateTime, self)
end

function FirstchargeView:_onStartAnimation()
	removetimer(self._onFinshAnimation, false)
	settimer(0.5, self._onFinshAnimation, self, false)
end

function FirstchargeView:_onFinshAnimation()
	GameUtil.SetActive(self.mainGO, true)

	self._playingAni = false

	if self._showIndex == 1 then
		self:_showLihui()
	end
end

function FirstchargeView:_updateProgress()
	local curmoney = FirstChargeModel.instance:getChargeMoney()
	local _matchaIndex

	for i = 1, self._totalLevel do
		local hasMatch = curmoney >= self._cfgs[i].consumeMoney
		local hasGian = FirstChargeModel.instance:getHasGainGiftByIndex(i)

		GameUtil.SetActive(self._tabs[i].mask, hasGian)
		GameUtil.SetActive(self._tabs[i].redPoint, hasMatch and not hasGian)

		self._tabs[i].hasMatch = hasMatch
		self._tabs[i].hasGian = hasGian

		if not _matchaIndex then
			if hasMatch and not hasGian then
				_matchaIndex = i
			elseif not hasMatch then
				_matchaIndex = i
			end
		end
	end

	_matchaIndex = _matchaIndex or self._totalLevel

	local showTip = string.format("所有充值均计入首充，已累计：%s元", curmoney / 100)

	self._txtProgress.text = showTip
	self._txtProgressLast.text = showTip
	self._txtProgressFirst.text = showTip

	self:_updateShowBtn()

	if self._showIndex then
		local tem = self._showIndex

		self._showIndex = nil

		self:_onSwitchTop(tem)
	elseif _matchaIndex then
		self:_onSwitchTop(_matchaIndex)
	end

	local val = 0
	local stepVal = 1 / (self._totalLevel - 1)

	for i = 1, self._totalLevel - 1 do
		if curmoney < self._cfgs[i].consumeMoney then
			break
		elseif curmoney >= self._cfgs[i + 1].consumeMoney then
			val = val + stepVal
		else
			local valAdd = stepVal * (curmoney - self._cfgs[i].consumeMoney) / (self._cfgs[i + 1].consumeMoney - self._cfgs[i].consumeMoney)

			val = val + valAdd
		end
	end

	self._sldProgress:SetValue(val)
end

function FirstchargeView:_onSwitchTop(showIndex)
	if self._showIndex == showIndex then
		return
	end

	PetCvController.instance:turnOffCurCv()

	self._showIndex = showIndex

	FirstChargeModel.instance:setShowIndex(self._showIndex)

	self._showCfg = self._cfgs[self._showIndex]

	if not self._showCfg then
		printError("活动首充配置下标设置错误")

		return
	end

	self:_hideLihui()
	uGuiUtil.clearImage(self._goTopBg)

	if self._showIndex == 1 then
		GameUtil.SetActive(self._goTop, false)
		GameUtil.SetActive(self._goTopLast, false)
		GameUtil.SetActive(self._goTopFirst, true)

		if not self._playingAni then
			GameUtil.SetActive(self.mainGO, true)
			self:_showLihui()
		end
	elseif self._showCfg.isYear then
		GameUtil.SetActive(self._goTop, false)
		GameUtil.SetActive(self._goTopLast, true)
		GameUtil.SetActive(self._goTopFirst, false)

		if not self._playingAni then
			GameUtil.SetActive(self.mainGO, true)

			if self._showIndex == 1 then
				self:_showLihui()
			end
		end
	else
		uGuiUtil.setSpriteToImage(self._goTopBg, uGuiUtil.SpriteType.BigBg, GameUrl.getFirstChargeBGUrl(self._showCfg.BG), self.handlerAfterLoadBG, self)
		GameUtil.SetActive(self._goTop, true)
		GameUtil.SetActive(self._goTopFirst, false)
		GameUtil.SetActive(self._goTopLast, false)
	end

	self:_updateGift()
	self:_updateJumpTo()
	self:_updateShowPet()
	self:_updateShowPrize()
	self:_updateShowBtn()
	self:_updatePlayEff()

	if self._effSelect and self._effSelect.effGo then
		self._effSelect.effGo.transform:SetParent(self._tabs[self._showIndex].go.transform)
		GameUtil.setLocalPos(self._effSelect.effGo.transform, 0, 0, 0)
	end

	self._changeGroups:SetState(self._showIndex - 1)
end

function FirstchargeView:_showLihui()
	goutil.setActive(self._petCom, true)
	self.petPhoto:setPreAnim("ui_jiemian")
	self.petPhoto:showPetEffect(10309, true, 2.4)
	self.petPhoto:setPetLocalPosAndScale(-0.45, -1.5, 1.45)
end

function FirstchargeView:_hideLihui()
	self.petPhoto:clear()
	goutil.setActive(self._petCom, false)
end

function FirstchargeView:handlerAfterLoadBG()
	local image = self._goTopBg:GetComponent(goutil.Type_UIImage)

	if image then
		image:SetNativeSize()
	end

	if not self._playingAni then
		GameUtil.SetActive(self.mainGO, true)

		if self._showIndex == 1 then
			self:_showLihui()
		end
	end
end

function FirstchargeView:_updateGift()
	goutil.setActive(self._bgReward, false)
	self:_updateGiftState(self._gifts[1], self._showCfg.goodsId, self._showCfg.nameGoods)
	self:_updateGiftState(self._gifts[2], self._showCfg.goodsId2, self._showCfg.nameGoods2)
	self:_updateGiftTabState()
end

function FirstchargeView:_updateGiftTabState()
	if self._showIndex ~= 5 then
		GameUtil.setLocalPos(self._bgReward, 490, 254, 0)
	else
		GameUtil.setLocalPos(self._bgReward, 520, 270, 0)
	end

	local tagNum = 0

	for i = 1, 2 do
		if GameUtil.GetActive(self._gifts[i].go) then
			tagNum = tagNum + 1
		end

		if GameUtil.GetActive(self._jumpTos[i].go) then
			tagNum = tagNum + 1
		end
	end

	if tagNum == 1 then
		goutil.setActive(self._bgReward, true)
		GameUtil.setHeight(self._bgReward, 280)
	elseif tagNum == 2 then
		goutil.setActive(self._bgReward, true)
		GameUtil.setHeight(self._bgReward, 320)
	end
end

function FirstchargeView:_updateGiftState(gift, goodId, goodName)
	if gift.goodId ~= goodId then
		gift.goodId = goodId

		self:_resetGiftState(gift)

		if goodId > 0 and PayShopModel.instance:getMibaoTotalBuyTimesById(goodId) == 0 then
			local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(goodId)

			uGuiUtil.setSpriteToImage(gift.con, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(goodsCfg.icon), function()
				GameUtil.SetActive(gift.go, true)
				self:_updateGiftTabState()
			end, self)

			gift.txtName.text = goodName

			local effPath = "fx_ui_shouchong/fx_ui_shouchong_lijian.prefab"

			gift.eff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true, nil, nil, function(target, eff)
				eff.hideEffWhileNotOnTop = true

				eff:setParent(gift.effCom.transform)
				Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
				eff:setScale(1)
				Framework.TransformUtil.SetLocalRotation(eff.effGo.transform, 0, 0, 0)
			end)
		end
	elseif PayShopModel.instance:getMibaoTotalBuyTimesById(goodId) > 0 then
		self:_resetGiftState(gift)
	end
end

function FirstchargeView:_resetGiftState(gift)
	GameUtil.SetActive(gift.go, false)
	uGuiUtil.clearImage(gift.con)

	if gift.eff then
		UIEffectManager.instance:stopEffect(gift.eff)

		gift.eff = nil
	end
end

function FirstchargeView:_updateJumpTo()
	goutil.setActive(self._bgReward, false)
	self:_updateJumpToState(self._jumpTos[1], self._showCfg.jumpTo1, self._showCfg.iconJumpTo1, self._showCfg.tipJumpTo1)
	self:_updateJumpToState(self._jumpTos[2], self._showCfg.jumpTo2, self._showCfg.iconJumpTo2, self._showCfg.tipJumpTo2)
	self:_updateGiftTabState()
end

function FirstchargeView:_updateJumpToState(jumpTo, target, icon, tip)
	if jumpTo.targetView ~= target then
		jumpTo.targetView = target

		self:_resetGiftState(jumpTo)

		if not GameUtil.isEmptyString(target) then
			uGuiUtil.setSpriteToImage(jumpTo.con, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(icon), function()
				GameUtil.SetActive(jumpTo.go, true)
				self:_updateGiftTabState()
			end, self)

			jumpTo.txtName.text = tip

			local effPath = "fx_ui_shouchong/fx_ui_shouchong_lijian.prefab"

			jumpTo.eff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true, nil, nil, function(target, eff)
				eff.hideEffWhileNotOnTop = true

				eff:setParent(jumpTo.effCom.transform)
				Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
				eff:setScale(1)
				Framework.TransformUtil.SetLocalRotation(eff.effGo.transform, 0, 0, 0)
			end)
		end
	end
end

function FirstchargeView:_updateShowPet()
	GameUtil.SetActive(self._petInfoPos, false)
	GameUtil.SetActive(self._goPlayCv, false)

	self._showPetId = nil

	if self._showCfg.petId ~= 0 then
		self._showPetId = self._showCfg.petId

		if not self._showCfg.posSkill then
			GameUtil.setLocalPos(self._petInfoPos, self._showCfg.posSkill[1], self._showCfg.posSkill[2], 0)

			local isShowSkill = not PetCollegeConfig.instance:raceId2ChallengeId(self._showPetId)

			GameUtil.SetActive(self._goSkill, isShowSkill)
			GameUtil.SetActive(self._goChallenge, not isShowSkill)
			GameUtil.SetActive(self._petInfoPos, true)
			GameUtil.SetActive(self._goPlayCv, true)
		end
	end

	self:_updateChallengeRedPoint()
end

function FirstchargeView:_updateShowPrize()
	for i = 1, 4 do
		MaterialMgr.resetAll(self._items[i].con)
		GameUtil.SetActive(self._items[i].go, false)
	end

	for i = 1, 3 do
		MaterialMgr.resetAll(self._itemsLast[i].con)
		GameUtil.SetActive(self._itemsLast[i].go, false)
	end

	for i = 1, 3 do
		for k = 1, 4 do
			MaterialMgr.resetAll(self._itemsFirst[i].cellList[k])
		end
	end

	if not self._showCfg.gift then
		local showPrizeStr = ""
		local showPrizes = MaterialMgr.changeItemStrArr(showPrizeStr)

		if self._showIndex == 1 then
			for i = 1, 3 do
				local cfg = FirstChargeConfig.instance:getActSignCfgsById(FirstChargeModel.instance:getCurActivityId(), self._showCfg.consumeMoney, i)

				showPrizes = MaterialMgr.changeItemStrArr(cfg.prize)

				for k = 1, 4 do
					MaterialMgr.setCellByCfg(showPrizes[k], self._itemsFirst[i].cellList[k])
				end
			end
		elseif self._showCfg.isYear then
			for i = 1, #showPrizes do
				MaterialMgr.setCellByCfg(showPrizes[i], self._itemsLast[i].con)
				GameUtil.SetActive(self._itemsLast[i].go, true)
			end
		else
			for i = 1, #showPrizes do
				if showPrizes[i] and self._items[i] then
					MaterialMgr.setCellByCfg(showPrizes[i], self._items[i].con)
					GameUtil.SetActive(self._items[i].go, true)
				end
			end
		end
	end
end

function FirstchargeView:_updateShowBtn()
	if self._showIndex == nil then
		return
	end

	if self._showIndex == 1 then
		if self._tabs[self._showIndex].hasMatch then
			GameUtil.SetActive(self._goBtnGotoChargeFirst, false)

			if FirstChargeModel.instance:getIsHasAllSign(self._showCfg.consumeMoney) then
				GameUtil.SetActive(self._goBtnReceiveFirst, false)
				GameUtil.SetActive(self._goMarkFirst, true)
			else
				GameUtil.SetActive(self._goMarkFirst, false)
				GameUtil.SetActive(self._goBtnReceiveFirst, true)
			end

			self._txtBtnReceive.text = FirstChargeModel.instance:getIsAbleToSign(self._showCfg.consumeMoney) and "领取" or "明日再来"
		else
			GameUtil.SetActive(self._goBtnReceiveFirst, false)
			GameUtil.SetActive(self._goBtnGotoChargeFirst, true)
			GameUtil.SetActive(self._goMarkFirst, false)
		end

		for i = 1, 3 do
			goutil.setActive(self._itemsFirst[i].mark, FirstChargeModel.instance:getIsHasSign(self._showCfg.consumeMoney, i))
		end
	elseif self._showCfg.isYear then
		if self._tabs[self._showIndex].hasMatch then
			GameUtil.SetActive(self._goBtnReceiveLast, not self._tabs[self._showIndex].hasGian)
			GameUtil.SetActive(self._goBtnGotoChargeLast, false)
		else
			GameUtil.SetActive(self._goBtnReceiveLast, false)
			GameUtil.SetActive(self._goBtnGotoChargeLast, true)
		end
	elseif self._tabs[self._showIndex].hasMatch then
		GameUtil.SetActive(self._goBtnReceive, not self._tabs[self._showIndex].hasGian)
		GameUtil.SetActive(self._goMark, self._tabs[self._showIndex].hasGian)
		GameUtil.SetActive(self._goBtnGotoCharge, false)
	else
		GameUtil.SetActive(self._goMark, false)
		GameUtil.SetActive(self._goBtnReceive, false)
		GameUtil.SetActive(self._goBtnGotoCharge, true)
	end
end

function FirstchargeView:_updateChallengeRedPoint()
	local isShowRedPoint = PetCollegeModel.instance:canBattleByRaceId(10313)

	GameUtil.SetActive(self._redpointTopLast, isShowRedPoint)

	isShowRedPoint = self._showPetId and PetCollegeModel.instance:canBattleByRaceId(self._showPetId)

	GameUtil.SetActive(self._redpointTop, isShowRedPoint)
end

function FirstchargeView:_updatePlayEff()
	UIEffectManager.instance:stopEffect(self._effPlay)

	self._effPlay = nil

	local actId = FirstChargeModel.instance:getCurActivityId()

	if checknumber(actId) == 8001 then
		return
	end

	if GameUtil.isEmptyString(self._showCfg.showEff) then
		return
	end

	local effResPath = "fx_ui_shouchong/" .. self._showCfg.showEff .. ".prefab"

	self._effPlay = UIEffectManager.instance:playEffect(self, effResPath, self._goEff, 0, 0, true, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(self._goEff.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)

		eff.hideEffWhileNotOnTop = true
	end)

	GameUtil.SetActive(self._goEff, true)
end

function FirstchargeView:_loadEffs()
	local effResPath = "fx_ui_shouchong/fx_ui_leichong_shouchong.prefab"

	self._effSelect = UIEffectManager.instance:playEffect(self, effResPath, self._tabs[self._showIndex].go, 0, 0, true, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(self._tabs[self._showIndex].go.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)

		eff.hideEffWhileNotOnTop = true
	end)
end

function FirstchargeView:_clearRes()
	uGuiUtil.clearImage(self._goTopBg)
	GameUtil.SetActive(self._goEff, false)

	for i = 1, 6 do
		uGuiUtil.clearImage(self._tabs[i].con)
		GameUtil.SetActive(self._tabs[i].go, false)
	end

	for i = 1, 4 do
		MaterialMgr.resetAll(self._items[i].con)
	end

	for i = 1, 3 do
		MaterialMgr.resetAll(self._itemsLast[i].con)
	end

	UIEffectManager.instance:stopEffect(self._effSelect)
	UIEffectManager.instance:stopEffect(self._effPlay)

	self._effPlay = nil
	self._effSelect = nil

	for i = 1, 2 do
		self:_resetGiftState(self._gifts[i])

		self._gifts[i].goodId = nil

		self:_resetGiftState(self._jumpTos[i])

		self._jumpTos[i].targetView = nil
	end
end

function FirstchargeView:handleNotifyPayResultRes(status, msg)
	if status == 0 then
		FirstChargeController.instance:sendGetInfoReq(self._updateProgress, self)
	end
end

function FirstchargeView:handlePayShopItemBuySucRes(status, msg)
	if status == 0 then
		self:_updateGift()
	end
end

return FirstchargeView
