-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaoxiaoleskin/view/XiaoxiaoleSkinView.lua

module("logic.extensions.xiaoxiaoleskin.view.XiaoxiaoleSkinView", package.seeall)

local XiaoxiaoleSkinView = class("XiaoxiaoleSkinView", ViewComponent)
local RIGHT_HIDE_LOCAL_X = 1079
local RIGHT_SHOW_LOCAL_X = 431.9
local CON_HIDE_X = 279
local CON_SHOW_X = 0
local BG_HIDE_X = 1064
local BG_SHOW_X = 544

function XiaoxiaoleSkinView:ctor()
	XiaoxiaoleSkinView.super.ctor(self)

	self._horizontal = 6
	self._vertical = 6
	self._petIconOnClicks = {}
end

function XiaoxiaoleSkinView:unbindEvents()
	XiaoxiaoleSkinView.super.unbindEvents(self)
	self._customInput:RemoveListener()
	self._btnTip:RemoveClickListener()

	for _, val in ipairs(self._gridList) do
		for _, v in ipairs(val) do
			v.btn:RemoveClickListener()
		end
	end

	GameUtil.rmClickHandler(self._btnToggle)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnJumpWandererPass)
	GameUtil.rmClickHandler(self._btnQuan)
end

function XiaoxiaoleSkinView:bindEvents()
	XiaoxiaoleSkinView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._btnTip:AddClickListener(self._tipOnClick, self)

	for _, val in ipairs(self._gridList) do
		for _, v in ipairs(val) do
			v.btn:AddClickListener(function()
				self:_gridOnClick(v)
			end, self)
		end
	end

	GameUtil.addClickHandler(self._btnToggle, function()
		local skip = BagPetSkinController.instance:getAutoSkipStartAni()

		BagPetSkinController.instance:setAutoSkipStartAni(not skip)
		GameUtil.SetActive(self._imgSelectToggle, not skip)
	end)
	GameUtil.addClickHandler(self._btnLottery, self._onClickBtnLottery, self)
	GameUtil.addClickHandler(self._btnHide, self._onClickBtnHide, self)
	GameUtil.addClickHandler(self._btnJumpWandererPass, self._onClickJumpWandererPass, self)
	GameUtil.addClickHandler(self._btnQuan, self._onClickQuanSelect, self)
end

function XiaoxiaoleSkinView:onExit()
	XiaoxiaoleSkinView.super.onExit(self)
	removetimer(self._finishEvent, self)
	self._petIconList:dispose()
	self._rewardList:dispose()
	self:_refreshGrid()
	self:_unLoadSpine()

	self._petIconOnClicks = {}

	MaterialMgr.resetAll(self._con)
	self:_clearEffect()

	if self._moveTween then
		self._moveTween:Kill(true)

		self._moveTween = nil
	end

	if self._moveTweenCon then
		self._moveTweenCon:Kill(true)

		self._moveTweenCon = nil
	end

	uGuiUtil.clearImage(self._bg)
end

function XiaoxiaoleSkinView:buildUI()
	XiaoxiaoleSkinView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
	self._txtTipDesc = self:getTxt("left/tip/txt")
	self._tipInLeft = self:getGo("left/tip")
	self._petInfo = self:getGo("petInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._petName = self:getTxt("petInfo/txtName")
	self._rare = self:getGo("petInfo/rare")
	self._btnToggle = self:getGo("btnToggle")
	self._imgSelectToggle = self:getGo("btnToggle/imgSelect")
	self._right = self:getGo("right")
	self._txtTime = self:getTxt("time/txtTime")
	self._oldCost = self:getTxt("right/cost/oldCost")
	self._nowCost = self:getTxt("right/cost/nowCost")
	self._txtTips = self:getTxt("right/lotteryTip/txtTips")
	self._bg = self:getGo("bg")
	self._con = self:getGo("left/con")
	self._bg2 = self:getGo("bg2")
	self._goldBarCon = self:getGo("goldBarCon")
	self._gridListGo = self:getGo("right/game")
	self._gridListCell = self:getGo("right/gameGrid")
	self._petIconListGo = self:getGo("pet/petIconList")
	self._petIconCell = self:getGo("pet/petIconCell")
	self._rewardListGo = self:getGo("reward/rewardList")
	self._rewardItem = self:getGo("reward/rewardItem")
	self._bigPriezeGo = self:getGo("bigPrieze")
	self._customInput = UICustomInput.Get(self._bigPriezeGo)
	self._adjustPosition = self._bigPriezeGo:GetComponent("UIAdjustPosition")
	self._prizeItemCon1 = self:getGo("bigPrieze/prizeItemCon1")
	self._prizeItemCon2 = self:getGo("bigPrieze/prizeItemCon2")
	self._rewardList = ScrollerList.create(self._rewardListGo, self._rewardItem, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._petIconList = ScrollerList.create(self._petIconListGo, self._petIconCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	self._petIconList:regGetCellSize(function()
		return 100, 100
	end)

	self._gridList = {}

	for i = 1, self._vertical do
		self._gridList[i] = {}

		for j = 1, self._horizontal do
			local list = {}

			list.go = goutil.cloneAndSetParent(self._gridListCell, self._gridListGo.transform)
			list.go.name = "gameGrid_" .. i
			list.xAxis = j - 1
			list.yAxis = i - 1
			list.mask = goutil.findChild(list.go, "qualityBg")
			list.icon = goutil.findChild(list.go, "icon")
			list.quality = goutil.findChild(list.go, "qualityBg"):GetComponent("UIImageSpriteChange")
			list.specialIcon = goutil.findChild(list.go, "specialIcon")
			list.num = goutil.findChildTextComponent(list.go, "num/txt")
			list.numGo = goutil.findChild(list.go, "num")
			list.btn = GameUtil.asBtn(list.go)
			list.isBuy = false

			goutil.setActive(list.go, true)
			goutil.setActive(list.numGo, false)

			self._gridList[i][j] = list
		end
	end

	self._spineInterface = goutil.findChild(self.mainGO, "left/spineInterface")
	self._txtTitle = self:getTxt("reward/txtTitle")
	self._btnHide = self:getGo("right/btnHide")
	self._btnLottery = self:getGo("btnLottery")
	self._txtLotteryNum = self:getTxt("btnLottery/txtLotteryNum")
	self._cost = self:getGo("cost")
	self._costRect = self:getGo("cost/cost"):GetComponent(goutil.Type_RectTransform)
	self._txtCostNow = self:getTxt("cost/cost/txtCostNow")
	self._iconNow = self:getGo("cost/cost/iconNow")
	self._iconOld = self:getGo("cost/cost/iconOld")
	self._txtCostOld = self:getTxt("cost/cost/txtCostOld")
	self._btnJumpWandererPass = self:getGo("btnJumpWandererPass")
	self._btnQuan = self:getGo("btnQuan")
	self._imgSelect = self:getGo("btnQuan/imgSelect")
end

function XiaoxiaoleSkinView:onEnter()
	XiaoxiaoleSkinView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._isFliping = false
	self._petIconSelecetId = 0
	self._openingLotteryPanel = false
	self._effList = {}
	self._rightPosXList = {
		RIGHT_HIDE_LOCAL_X,
		RIGHT_SHOW_LOCAL_X
	}
	self._rightPosIdx = 1
	self._conPosXList = {
		CON_HIDE_X,
		CON_SHOW_X
	}
	self._conPosIdx = 1
	self._bgPosXList = {
		BG_HIDE_X,
		BG_SHOW_X
	}
	self._bgPosIdx = 1

	local objList = {}
	local actCfg = ScratchLotteryConfig.instance:getCfgById(self._activityId) or {}

	table.insert(objList, {
		id = "204:2",
		showAdd = true
	})
	table.insert(objList, {
		showAdd = true,
		id = actCfg.coupon
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)

	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.ScratchLottery, self._activityId)

	self:_scratchLotteryInfoReq()
	self:_initLotteryUI()
	self:_refreshPetSkinShow()
	goutil.setActive(self._gridListCell, false)

	local skip = BagPetSkinController.instance:getAutoSkipStartAni()

	GameUtil.SetActive(self._imgSelectToggle, skip)
	self.addGEvent(self, GlobalNotify.ScratchLotteryGetInfoRes, self._refreshInfo, self)
	self.addGEvent(self, GlobalNotify.ScratchLotteryNewGameRes, self._refreshGrid, self)
	self.addGEvent(self, GlobalNotify.ScratchLotteryDigRes, self._scratchLotteryDigRes, self)
	GameUtil.SetActive(self._btnJumpWandererPass, false)

	local activityId = WandererpassController.CURR_ACTIVITY_ID

	if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		GameUtil.SetActive(self._btnJumpWandererPass, true)
	end

	self:_updateCoupon()
end

function XiaoxiaoleSkinView:_updateCoupon(isShowTips)
	GameUtil.SetActive(self._btnQuan, false)

	local actCfg = ScratchLotteryConfig.instance:getCfgById(self._activityId) or {}

	if not string.nilorempty(actCfg.coupon) then
		GameUtil.SetActive(self._btnQuan, true)

		if not MaterialMgr.getMatEnough(actCfg.coupon) then
			GameUtil.SetActive(self._imgSelect, false)
			WandererpassController.instance:setCouponSelect(self._activityId, false)

			if isShowTips then
				TipsFacade.instance:openCommonTips(langPara("%s不足", MaterialMgr.getMaterialsNameByCfg(actCfg.coupon)))
			end
		else
			local boo = WandererpassController.instance:getCouponSelect(self._activityId)

			GameUtil.SetActive(self._imgSelect, boo)
		end
	else
		WandererpassController.instance:setCouponSelect(self._activityId, false)
		GameUtil.SetActive(self._btnJumpWandererPass, false)
	end
end

function XiaoxiaoleSkinView:_initLotteryUI()
	GameUtil.setLocalPos(self._con, CON_HIDE_X, 0, 0)
	GameUtil.SetActive(self._right, false)
	GameUtil.SetActive(self._cost, false)
	GameUtil.SetActive(self._btnLottery, true)
end

function XiaoxiaoleSkinView:_gridOnClick(v)
	if self._isFliping then
		return
	end

	local gird = self._gridList[v.yAxis + 1][v.xAxis + 1]

	if gird.isBuy then
		FloatWordMgr.instance:show("已获得该物品")

		return
	end

	local time = ScratchLotteryModel.instance:getDigTimes(self._activityId) + 1
	local costCfg = ScratchLotteryConfig.instance:getCostByTimes(self._activityId, time)

	if costCfg == nil then
		printError(string.format("costCfg == nil ( activityId = %s, time = %s )", self._activityId, time))

		return
	end

	local extPrizeType, extPrizeId, extPrizeNum = MaterialMgr.getMatParams(costCfg.cost)
	local extName = MaterialMgr.getMaterialsName(extPrizeType, extPrizeId)

	self:_updateCoupon()

	local boo = WandererpassController.instance:getCouponSelect(self._activityId)

	if boo then
		local activityId = WandererpassController.CURR_ACTIVITY_ID

		if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
			local actCfg = ScratchLotteryConfig.instance:getCfgById(self._activityId) or {}
			local mt, id, num = MaterialMgr.getMatParams(actCfg.coupon)
			local name = MaterialMgr.getMaterialsNameByCfg(actCfg.coupon)
			local content = langPara("确定消耗%sx%s，直接进行本次抽奖？\n可抵消%s%s", name, num, extPrizeNum, extName)

			TipsFacade.instance:openPopupWindow(lang("tip"), content, function()
				ScratchLotteryModel.instance:setLastSpecialPrizeCount(self._activityId)
				ScratchLotteryAgent.instance:sendPM_ScratchLotteryDigReq(self._activityId, v.xAxis, v.yAxis, boo)
			end)

			return
		end
	end

	local function okFunc()
		local haveNum = MaterialModel.instance:getMaterialsNumber(extPrizeType, extPrizeId) or 0

		if extPrizeType == MatType.Diamond_Consume then
			extPrizeType = MatType.Diamond
			extPrizeId = MatType.Diamond_Binding
		end

		if ((extPrizeType == MatType.Diamond or nil) and RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()) < checknumber(extPrizeNum) then
			local cfg = MaterialMgr.getMatCfg(extPrizeType, extPrizeId)

			if cfg then
				FloatWordMgr.instance:show(langPara("所需%s不足！", cfg.name))
			else
				FloatWordMgr.instance:show(lang("所需货币不足！"))
			end
		else
			ScratchLotteryModel.instance:setLastSpecialPrizeCount(self._activityId)
			ScratchLotteryAgent.instance:sendPM_ScratchLotteryDigReq(self._activityId, v.xAxis, v.yAxis, boo)
		end
	end

	local function cencelFunc()
		return
	end

	local tipsContent = string.format("是否消耗%s*%s，购买金币*1000并获赠1把水晶镐，直接翻开格子", extName, extPrizeNum)

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

function XiaoxiaoleSkinView:_updateTabCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local select = goutil.findChild(cell, "select")
	local withTag = goutil.findChild(cell, "withTag")
	local index = cell.index + 1

	MaterialMgr.setIcon(icon, MatType.PET_SKIN, data)

	local isWith = MaterialMgr.isWithInSkinPrize(MatType.PET_SKIN, data)

	goutil.setActive(withTag, isWith)

	local function onClick()
		self._petIconSelecetId = index

		local bgImg = ScratchLotteryConfig.instance:getPetBgImg(data)
		local modelCfg = ScratchLotteryConfig.instance:getPetPos(data)

		self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, data, self._con, modelCfg[3], nil, true, modelCfg[1], modelCfg[2])

		self:_loadSpine(data)

		if not string.nilorempty(bgImg) then
			uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, bgImg)
		end

		self:setPetInfo(data)
		self._petIconList:refresh()
	end

	self._petIconOnClicks[index] = self._petIconOnClicks[index] or onClick

	if self._petIconSelecetId == 0 then
		GameUtil.callBack(onClick)
		self:_setPetListOpenOrClose()
	end

	goutil.setActive(select, index == self._petIconSelecetId)
	GameUtil.asBtn(cell.gameObject):RemoveClickListener()
	GameUtil.asBtn(cell.gameObject):AddClickListener(function()
		if index == self._petIconSelecetId then
			return
		end

		GameUtil.callBack(onClick)
	end, self)
end

function XiaoxiaoleSkinView:_clearTabCell(cell)
	return
end

function XiaoxiaoleSkinView:_setPetListOpenOrClose()
	local skinIds = ScratchLotteryConfig.instance:getShowPetSkinId(self._activityId)

	if #skinIds <= 1 then
		goutil.setActive(self._petIconListGo, false)
	end
end

function XiaoxiaoleSkinView:_refreshPetSkinShow()
	local skinIds = ScratchLotteryConfig.instance:getShowPetSkinId(self._activityId)

	goutil.setActive(self._petIconListGo, true)
	self._petIconList:reloadData(skinIds)
end

function XiaoxiaoleSkinView:_rollSkinShow()
	if #self._petIconOnClicks <= 1 then
		return
	end

	self._petIconSelecetId = self._petIconSelecetId + 1

	if self._petIconSelecetId > #self._petIconOnClicks then
		self._petIconSelecetId = 1
	end

	if self._petIconOnClicks[self._petIconSelecetId] then
		GameUtil.callBack(self._petIconOnClicks[self._petIconSelecetId])
	end
end

function XiaoxiaoleSkinView:setPetInfo(petId)
	MaterialMgr.resetAll(self._rare)

	local petCo = PetSkinConfig.instance:getPetSkinCfg(petId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, petId, self._rare)

	self._petName.text = petCo.skinName

	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnInfo:AddClickListener(function()
		local skinId = petCo.skinId

		if skinId > 0 then
			PetbookController.instance:openSkinViewNoSetAttr(skinId)
		else
			printError("缺失skinId")
		end
	end, self)
	self._btnSkill:AddClickListener(function()
		local skinId = petId

		if skinId then
			local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

			if cfg then
				local raceId = cfg.raceId

				PetbookController.instance:previewBattle(raceId, skinId)
			end
		end
	end, self)
end

function XiaoxiaoleSkinView:_updateCell(view, cell, data)
	local itemCon = goutil.findChild(cell, "itemCon")
	local tag = goutil.findChild(cell, "tag")
	local prizeData1 = {}
	local prizeData2 = {}

	prizeData1.cfgStr = data.bigReward
	prizeData2.cfgStr = data.normalReward
	prizeData1.showRate = data.bigReardShowRate
	prizeData2.showRate = data.normalReardShowRate
	prizeData1.hitBigPrize = data.hitBigPrize
	prizeData2.hitBigPrize = data.hitBigPrize

	goutil.setActive(tag, data.hitBigPrize)
	GameUtil.asBtn(itemCon):RemoveClickListener()
	GameUtil.asBtn(itemCon):AddClickListener(function()
		self:_adjustView(itemCon)
		self:_setBigPrieze(self._prizeItemCon1, prizeData1)
		self:_setBigPrieze(self._prizeItemCon2, prizeData2)
		goutil.setActive(self._bigPriezeGo, true)
	end)
end

function XiaoxiaoleSkinView:_clearCell(cell)
	local itemCon = goutil.findChild(cell, "itemCon")

	GameUtil.asBtn(itemCon):RemoveClickListener()
end

function XiaoxiaoleSkinView:_refreshUi()
	local cfg = ScratchLotteryModel.instance:getBigPrizeCfgById(self._activityId) or {}
	local count = ScratchLotteryModel.instance:getSpecialPrizeCount(self._activityId)

	for i, v in ipairs(cfg) do
		v.hitBigPrize = i <= count
	end

	self._rewardList:reloadData(cfg)
	goutil.setActive(self._bigPriezeGo, false)

	local time = ScratchLotteryModel.instance:getDigTimes(self._activityId) + 1
	local costCfg = ScratchLotteryConfig.instance:getCostByTimes(self._activityId, time)
	local extPrizeType, extPrizeId, extPrizeNum = MaterialMgr.getMatParams(costCfg.cost)
	local matype, id, num = MaterialMgr.getMatParams(costCfg.fakeCost)
	local desc = ScratchLotteryConfig.instance:getActivityDescById(self._activityId)
	local desc1 = ScratchLotteryConfig.instance:getActivityDesc1ById(self._activityId)
	local costCfgs = ScratchLotteryConfig.instance:getCostCfgs(self._activityId)

	goutil.setActive(self._oldCost.gameObject, extPrizeNum ~= num)

	self._oldCost.text = num
	self._nowCost.text = extPrizeNum
	self._txtTips.text = string.format(desc, time - 1)
	self._txtTipDesc.text = desc1
	self._txtTitle.text = string.format("金色宝箱已开%d/%d", count, checknumber(#cfg))

	GameUtil.SetActive(self._tipInLeft, not string.nilorempty(desc1))

	self._txtLotteryNum.text = string.format("已抽<color=#1BCF84>%d/%d</color>次", time - 1, #costCfgs)

	goutil.setActive(self._txtCostOld.gameObject, extPrizeNum ~= num)
	goutil.setActive(self._iconOld.gameObject, extPrizeNum ~= num)

	self._txtCostOld.text = num
	self._txtCostNow.text = extPrizeNum

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._costRect)
end

function XiaoxiaoleSkinView:_setBigPrieze(prizeItemCon, data)
	local prizeItem = goutil.findChild(prizeItemCon, "prizeItem")
	local receive = goutil.findChild(prizeItemCon, "receive")
	local txtRare = goutil.findChildTextComponent(prizeItemCon, "txtRare")

	MaterialMgr.resetAll(prizeItem)
	MaterialMgr.setCellByCfg(data.cfgStr, prizeItem)
	goutil.setActive(receive, data.hitBigPrize)

	txtRare.text = string.format("%s%%", data.showRate)
end

function XiaoxiaoleSkinView:_clearBigPrieze(prizeItemCon)
	MaterialMgr.resetAll(prizeItem)
end

function XiaoxiaoleSkinView:_scratchLotteryDigRes()
	self:_refreshInfo(true)
end

function XiaoxiaoleSkinView:_refreshInfo(isFlip)
	local pos = {}

	pos = isFlip and (ScratchLotteryModel.instance:getGamePosition(self._activityId) or {}) or ScratchLotteryModel.instance:getInfoPosition(self._activityId) or {}

	if ScratchLotteryModel.instance:getDigTimes(self._activityId) < ScratchLotteryModel.instance:getBuyTimesLen(self._activityId) then
		self:_refreshUi()
	end

	if TableUtil.isTableEmpty(pos) then
		return
	end

	for i, v in ipairs(pos) do
		local gird = self._gridList[v.yAxis + 1][v.xAxis + 1]

		goutil.setActive(gird.icon.gameObject, false)

		if gird then
			if v.prizeId == ScratchLotteryModel.PrizeType.special then
				local path = GameUrl.getItemIconUrl("icon_xxlpfbx")

				uGuiUtil.clearImage(gird.specialIcon)
				uGuiUtil.setSpriteToImage(gird.specialIcon, uGuiUtil.SpriteType.BigBg, path)
				gird.quality:SetState(2)
			elseif v.prizeId < 0 then
				local path = GameUrl.getItemIconUrl("icon_zhadan_02")

				uGuiUtil.clearImage(gird.specialIcon)
				uGuiUtil.setSpriteToImage(gird.specialIcon, uGuiUtil.SpriteType.BigBg, path)
				gird.quality:SetState(1)
			else
				local prizeCfg = ScratchLotteryConfig.instance:getPrizeById(self._activityId, v.prizeId)
				local params = string.split(prizeCfg, ":")

				MaterialMgr.setIcon(gird.icon, params[1], params[2])

				gird.num.text = params[3]

				gird.quality:SetState(1)
				goutil.setActive(gird.icon.gameObject, true)
				goutil.setActive(gird.numGo, true)
			end

			if isFlip then
				local path = v.prizeId < 0 and "fx_ui_pifuchoujiang_2" or "fx_ui_pifuchoujiang_1"
				local eff = XiaoxiaoleSkinController.instance:playEffect(self, gird.go, path, false, function()
					return
				end)

				table.insert(self._effList, eff)
			end
		end

		gird.isBuy = true
	end

	if isFlip then
		self._isFliping = true

		removetimer(self._finishEvent, self)
		settimer(0.5, self._finishEvent, self, false)
	end
end

function XiaoxiaoleSkinView:_finishEvent()
	local isShow = false
	local isNext = ScratchLotteryModel.instance:getNextRound(self._activityId)
	local pos = ScratchLotteryModel.instance:getGamePosition(self._activityId) or {}

	for i, v in ipairs(pos) do
		if v.prizeId == ScratchLotteryModel.PrizeType.special then
			isShow = true

			break
		end
	end

	if isNext then
		self:_refreshGrid(true)
	elseif isShow then
		local name = ScratchLotteryModel.instance:getNormalRewardName(self._activityId)

		UIStateManager.instance:push(ViewName.XiaoxiaoleSkinPopupView, name)
	end

	self:_clearEffect()

	if isNext then
		if not MaterialController.CI_SHOW_TYPE_POPUP then
			local showType = MaterialController.CI_SHOW_TYPE_FLY

			XiaoxiaoleSkinController.instance:showChangeSetInTemp(showType, self._activityId)

			self._isFliping = false
		end
	end
end

function XiaoxiaoleSkinView:_clearEffect()
	for i, v in ipairs(self._effList) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._effList = {}
end

function XiaoxiaoleSkinView:_refreshGrid(isNeedRes)
	for _, val in ipairs(self._gridList) do
		for _, v in ipairs(val) do
			goutil.setActive(v.icon.gameObject, false)
			goutil.setActive(v.numGo, false)
			MaterialMgr.resetAll(v.icon)
			uGuiUtil.clearImage(v.specialIcon)

			v.num.text = ""

			v.quality:SetState(0)

			v.isBuy = false
		end
	end

	if isNeedRes then
		self:_scratchLotteryInfoReq()
	end
end

function XiaoxiaoleSkinView:_scratchLotteryInfoReq()
	ScratchLotteryAgent.instance:sendPM_ScratchLotteryInfoReq(self._activityId)
end

function XiaoxiaoleSkinView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function XiaoxiaoleSkinView:_adjustView(go)
	local pos, sizeDelta = self:_getPosAndSizeDelta(go)

	self.pos = pos
	self.sizeDelta = sizeDelta

	if pos then
		Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
		self._adjustPosition:AdjustScreenPosition(self.pos, self.sizeDelta[1], -self.sizeDelta[2])
	else
		Framework.TransformUtil.SetLocalPos(self._bigPriezeGo.transform, 0, 0, 0)
	end
end

function XiaoxiaoleSkinView:_tipOnClick()
	UIStateManager.instance:push(ViewName.RulesView, "xiaoxiaoleskinview")
end

function XiaoxiaoleSkinView:_onCustomInputCallback(hover)
	if not hover then
		goutil.setActive(self._bigPriezeGo, false)
	end
end

function XiaoxiaoleSkinView:_loadSpine(skinId)
	self:_unLoadSpine()

	if checknumber(skinId) <= 0 then
		return
	end

	local callBack = GameUtil.handler(self._onReloadSpineInterfaceCompOfSkeletonGraphic, self, skinId)
	local modelCfg = ScratchLotteryConfig.instance:getPetPos(skinId)

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, skinId, self._con, modelCfg[3], callBack, true, modelCfg[1], modelCfg[2])
end

function XiaoxiaoleSkinView:_unLoadSpine()
	self._roleObj = RoleObjectPool.instance:removeRole(self._roleObj)

	self:_onUnReloadSpineInterfaceCompOfSkeletonGraphic()
end

function XiaoxiaoleSkinView:_onReloadSpineInterfaceCompOfSkeletonGraphic(skinId, spineGo, loader)
	local spineGoRect = spineGo:GetComponent(goutil.Type_RectTransform)

	self._spineInterfaceComp = SpineInterfaceComp.reloadSpineGo(self._spineInterfaceComp, self._spineInterface, skinId, spineGo, spineGoRect)
end

function XiaoxiaoleSkinView:_onUnReloadSpineInterfaceCompOfSkeletonGraphic()
	if self._spineInterfaceComp then
		self._spineInterfaceComp:unload()
	end
end

function XiaoxiaoleSkinView:_isSpineInterfaceCompLoaded()
	return self._spineInterfaceComp and self._spineInterfaceComp:isLoaded() or false
end

function XiaoxiaoleSkinView:_changeRightPos()
	local rightPosListLen = #self._rightPosXList

	self._rightPosIdx = self._rightPosIdx % rightPosListLen + 1

	local rightPosX = self._rightPosXList[self._rightPosIdx]
	local vec = Vector3.New(rightPosX, 4.4, 0)
	local paths = {
		vec
	}

	self._moveTween = TweenUtil.DOTweenMovePath(self._right.transform, false, paths, 0.5, function()
		if not self._openingLotteryPanel then
			GameUtil.SetActive(self._right.gameObject, false)
		end
	end, nil, DG.Tweening.Ease.Linear)
end

function XiaoxiaoleSkinView:_changeConPos()
	local conPosListLen = #self._conPosXList

	self._conPosIdx = self._conPosIdx % conPosListLen + 1

	local rightPosX = self._conPosXList[self._conPosIdx]
	local vec = Vector3.New(rightPosX, 16, 0)
	local paths = {
		vec
	}

	self._moveTweenCon = TweenUtil.DOTweenMovePath(self._con.transform, false, paths, 0.5, nil, nil, DG.Tweening.Ease.Linear)
end

function XiaoxiaoleSkinView:_changeBgPos()
	local bgPosListLen = #self._bgPosXList

	self._bgPosIdx = self._bgPosIdx % bgPosListLen + 1

	local rightPosX = self._bgPosXList[self._bgPosIdx]
	local vec = Vector3.New(rightPosX, 0, 0)
	local paths = {
		vec
	}

	self._moveTweenCon = TweenUtil.DOTweenMovePath(self._bg2.transform, false, paths, 0.5, nil, nil, DG.Tweening.Ease.Linear)
end

function XiaoxiaoleSkinView:_onClickBtnLottery()
	self._openingLotteryPanel = true

	self:_changeRightPos()
	self:_changeConPos()
	self:_changeBgPos()
	GameUtil.SetActive(self._cost, true)
	GameUtil.SetActive(self._btnLottery, false)
	GameUtil.SetActive(self._right, true)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._costRect)
end

function XiaoxiaoleSkinView:_onClickBtnHide()
	self._openingLotteryPanel = false

	self:_changeRightPos()
	self:_changeConPos()
	self:_changeBgPos()
	GameUtil.SetActive(self._cost, false)
	GameUtil.SetActive(self._btnLottery, true)
end

function XiaoxiaoleSkinView:_onClickJumpWandererPass()
	local activityId = WandererpassController.CURR_ACTIVITY_ID

	UIStateManager.instance:push(ViewName.WandererpassmainView, activityId, 2)
end

function XiaoxiaoleSkinView:_onClickQuanSelect()
	local boo = WandererpassController.instance:getCouponSelect(self._activityId)

	WandererpassController.instance:setCouponSelect(self._activityId, not boo)
	self:_updateCoupon(true)
end

return XiaoxiaoleSkinView
