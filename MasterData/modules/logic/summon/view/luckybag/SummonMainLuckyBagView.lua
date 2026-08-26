-- chunkname: @modules/logic/summon/view/luckybag/SummonMainLuckyBagView.lua

module("modules.logic.summon.view.luckybag.SummonMainLuckyBagView", package.seeall)

local SummonMainLuckyBagView = class("SummonMainLuckyBagView", BaseView)

function SummonMainLuckyBagView:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._gocharacteritem1 = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem1")
	self._gocharacteritem2 = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem2")
	self._btnsummon1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/summonbtns/summon1/#btn_summon1")
	self._simagecurrency1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/summonbtns/summon1/currency/#simage_currency1")
	self._txtcurrency11 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_1")
	self._txtcurrency12 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_2")
	self._gosummon10 = gohelper.findChild(self.viewGO, "#go_ui/summonbtns/summon10")
	self._btnsummon10 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/summonbtns/summon10/#btn_summon10")
	self._simagecurrency10 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/summonbtns/summon10/currency/#simage_currency10")
	self._txtcurrency101 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_1")
	self._txtcurrency102 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_2")
	self._gopageitem = gohelper.findChild(self.viewGO, "#go_ui/pageicon/#go_pageitem")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_ui/#go_lefttop")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_ui/#go_righttop")
	self._gosummonbtns = gohelper.findChild(self.viewGO, "#go_ui/summonbtns")
	self._goluckybagbtns = gohelper.findChild(self.viewGO, "#go_ui/#go_luckybagopen")
	self._goalreadyinvited = gohelper.findChild(self.viewGO, "#go_ui/#go_luckybagopen/#go_alreadyinvited")
	self._goinvite = gohelper.findChild(self.viewGO, "#go_ui/#go_luckybagopen/#go_invite")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "#go_ui/current/#txt_deadline")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	self._txttimes = gohelper.findChildText(self.viewGO, "#go_ui/#go_remaintimes/bg/#txt_times")
	self._goremaintimes = gohelper.findChild(self.viewGO, "#go_ui/#go_remaintimes")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonMainLuckyBagView:addEvents()
	self._btnsummon1:AddClickListener(self._btnsummon1OnClick, self)
	self._btnsummon10:AddClickListener(self._btnsummon10OnClick, self)
end

function SummonMainLuckyBagView:removeEvents()
	self._btnsummon1:RemoveClickListener()
	self._btnsummon10:RemoveClickListener()
end

SummonMainLuckyBagView.preloadList = {
	"singlebg/summon/heroversion_2_4/v2a4_fudai/v2a4_fudai_summon_fullbg1.png",
	"singlebg/summon/heroversion_2_4/v2a4_fudai/v2a4_fudai_summon_role1.png",
	"singlebg/summon/heroversion_2_4/v2a4_fudai/v2a4_fudai_summon_role2.png"
}

function SummonMainLuckyBagView:_editableInitView()
	self._pageitems = {}
	self._animRoot = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._simageline:LoadImage(ResUrl.getSummonHeroIcon("title_img_deco"))

	self._rectremaintimes = self._goremaintimes.transform

	self:initData()
	self:initSingleBg()
	self:initLuckyBagComp()
end

function SummonMainLuckyBagView:onDestroyView()
	for i = 1, self._luckyBagCount do
		local btn = self:getLuckyBagDetailBtn(i)

		if btn then
			btn:RemoveClickListener()
		end

		local useBtn = self:getLuckyBagUseBtn(i)

		if useBtn then
			useBtn:RemoveClickListener()
		end

		self["_simagerole" .. tostring(i)]:UnLoadImage()
		self["_simageshowicon" .. tostring(i)]:UnLoadImage()
	end

	self._simagecurrency1:UnLoadImage()
	self._simagecurrency10:UnLoadImage()
	self._simageline:UnLoadImage()

	if self._compFreeButton then
		self._compFreeButton:dispose()

		self._compFreeButton = nil
	end
end

function SummonMainLuckyBagView:onUpdateParam()
	return
end

function SummonMainLuckyBagView:onOpen()
	logNormal("SummonMainLuckyBagView:onOpen()")
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self.refreshView, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
	self:playEnterAnim()
	self:refreshView()
	self:checkAutoOpenLuckyBag()
	SummonController.instance:dispatchEvent(SummonEvent.LuckyBagViewOpen)
end

function SummonMainLuckyBagView:playEnterAnim()
	if SummonMainModel.instance:getFirstTimeSwitch() then
		SummonMainModel.instance:setFirstTimeSwitch(false)
		self._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
	else
		self._animRoot:Play(SummonEnum.SummonCharAnimationSwitch, 0, 0)
	end
end

function SummonMainLuckyBagView:playerEnterAnimFromScene()
	self._animRoot:Play(SummonEnum.SummonCharAnimationEnter, 0, 0)
end

function SummonMainLuckyBagView:checkAutoOpenLuckyBag()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local poolId = curPool.id
	local luckyBagIdList = SummonConfig.instance:getSummonLuckyBag(poolId)

	if luckyBagIdList and next(luckyBagIdList) then
		for _, luckyBagId in ipairs(luckyBagIdList) do
			local isGot = SummonLuckyBagModel.instance:isLuckyBagGot(poolId, luckyBagId)

			if isGot and not SummonLuckyBagModel.instance:isLuckyBagOpened(poolId, luckyBagId) and SummonLuckyBagModel.instance:needAutoPopup(poolId, luckyBagId) then
				ViewMgr.instance:openView(ViewName.SummonLuckyBagChoice, {
					poolId = poolId,
					luckyBagId = luckyBagId
				})
				SummonLuckyBagModel.instance:recordAutoPopup(poolId, luckyBagId)

				break
			end
		end
	end
end

function SummonMainLuckyBagView:onClose()
	logNormal("SummonMainLuckyBagView:onClose()")
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onViewCloseFinish, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonFailed, self.onSummonFailed, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonReply, self.onSummonReply, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onViewCanPlayEnterAnim, self.playerEnterAnimFromScene, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onItemChanged, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onItemChanged, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self.refreshView, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onRemainTimeCountdown, self._refreshOpenTime, self)
end

function SummonMainLuckyBagView:initData()
	local curPool = SummonMainModel.instance:getCurPool()
	local poolId = curPool.id

	self._luckyBagList = SummonConfig.instance:getSummonLuckyBag(poolId)
	self._luckyBagCount = 2
	self._luckyBagUseDic = {}
end

function SummonMainLuckyBagView:initSingleBg()
	for i = 1, self._luckyBagCount do
		self["_simagerole" .. tostring(i)] = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_role" .. tostring(i))
		self["_simageshowicon" .. tostring(i)] = gohelper.findChildSingleImage(self.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/dec1", i))
	end
end

function SummonMainLuckyBagView:initLuckyBagComp()
	for i = 1, self._luckyBagCount do
		local name = "_btnluckybag" .. tostring(i)
		local btn = gohelper.findChildButtonWithAudio(self.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/btn_detail", i))

		if btn then
			self[name] = btn

			btn:AddClickListener(SummonMainLuckyBagView.onClickLuckyBagDetail, self, i)
		end

		local txtName = "_txtName" .. tostring(i)
		local goGotVfxName = "_gogotvfx" .. tostring(i)
		local goGotImageName = "_gogotimage" .. tostring(i)
		local goUseAnimName = "_animatorGet" .. tostring(i)
		local reddotName = "_reddot" .. tostring(i)

		self[txtName] = gohelper.findChildText(self.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/txt1", i))
		self[goGotVfxName] = gohelper.findChild(self.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/vx_light", i))
		self[goGotImageName] = gohelper.findChild(self.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/#simage_alreadyget", i))
		self[goUseAnimName] = gohelper.findChildComponent(self.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/#simage_alreadyget/go_hasget", i), gohelper.Type_Animator)

		local redDotParent = gohelper.findChild(self.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/#go_reddot", i))
		local uid = self._luckyBagList[i]

		self[reddotName] = RedDotController.instance:addRedDot(redDotParent, RedDotEnum.DotNode.V3a3SkinDiscountCompensate, uid)

		local btnUse = gohelper.findChildButton(self.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/#btn_use", i))

		if btnUse then
			local btnUseName = "#btn_use" .. tostring(i)

			self[btnUseName] = btnUse

			btnUse:AddClickListener(SummonMainLuckyBagView._btnopenluckbagOnClick, self, i)
		end

		local goHasGet = gohelper.findChild(self.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/#simage_alreadyget/go_hasget", i))

		if goHasGet then
			local goHasOpenName = "_gohasget" .. tostring(i)

			self[goHasOpenName] = goHasGet
		end

		local goOpenBg = gohelper.findChild(self.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/bg_opened", i))

		if goOpenBg then
			local goOpenBgName = "_goopenbg" .. tostring(i)

			self[goOpenBgName] = goOpenBg
		end

		local goNoOpenBg = gohelper.findChild(self.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/bg_unopen", i))

		if goNoOpenBg then
			local goNoOpenBgName = "_gonoopenbg" .. tostring(i)

			self[goNoOpenBgName] = goNoOpenBg
		end

		local iconStar = gohelper.findChildImage(self.viewGO, string.format("#go_ui/current/right/#go_characteritem%s/bg/icon_star", i))

		if iconStar then
			local iconStarName = "_iconstar" .. tostring(i)

			self[iconStarName] = iconStar
		end
	end
end

function SummonMainLuckyBagView:_btnopenluckbagOnClick(index)
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool or not self._luckyBagList then
		return
	end

	local luckyBagId = self._luckyBagList[index]

	if luckyBagId == nil then
		return
	end

	local poolId = curPool.id
	local isGot = SummonLuckyBagModel.instance:isLuckyBagGot(poolId, luckyBagId)

	if isGot and not SummonLuckyBagModel.instance:isLuckyBagOpened(poolId, luckyBagId) then
		ViewMgr.instance:openView(ViewName.SummonLuckyBagChoice, {
			poolId = poolId,
			luckyBagId = luckyBagId
		})
	end
end

function SummonMainLuckyBagView:_btnsummon1OnClick()
	if SummonController.instance:isInSummonGuide() then
		return
	end

	SummonMainController.instance:summon1Action()
end

function SummonMainLuckyBagView:_btnsummon10OnClick()
	if not self:checkRemainTimesEnough10() then
		return
	end

	SummonMainController.instance:summon10Action()
end

function SummonMainLuckyBagView:_summon10Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 10, false, true)
end

function SummonMainLuckyBagView:checkRemainTimesEnough10()
	local curPool = SummonMainModel.instance:getCurPool()

	if curPool then
		local gachaMaxTimes = SummonLuckyBagModel.instance:getGachaRemainTimes(curPool.id)

		if gachaMaxTimes >= 10 then
			return true
		else
			GameFacade.showToast(ToastEnum.SummonLuckyBagLessThanSummon10)

			return false
		end
	end
end

function SummonMainLuckyBagView:_summon1Confirm()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	SummonMainController.instance:sendStartSummon(curPool.id, 1, false, true)
end

function SummonMainLuckyBagView:onClickLuckyBagDetail(index)
	local pool = SummonMainModel.instance:getCurPool()

	if not pool then
		return
	end

	if not self._luckyBagList then
		return
	end

	local luckyBagId = self._luckyBagList[index]

	if luckyBagId then
		SummonMainController.instance:openSummonDetail(pool, luckyBagId)
	end
end

function SummonMainLuckyBagView:refreshView()
	self.summonSuccess = false

	local list = SummonMainModel.instance:getList()

	if not list or #list <= 0 then
		gohelper.setActive(self._goui, false)

		return
	end

	self:refreshPoolUI()
end

function SummonMainLuckyBagView:refreshPoolUI()
	local pool = SummonMainModel.instance:getCurPool()

	if not pool then
		return
	end

	self:refreshLuckyBagStatus(pool)
	self:refreshLuckyBagDetails(pool)
	self:_refreshOpenTime()
end

function SummonMainLuckyBagView:refreshLuckyBagDetails(poolCo)
	local luckyBagList = self._luckyBagList

	if luckyBagList and next(luckyBagList) then
		local len = #luckyBagList

		for i = 1, self._luckyBagCount do
			local btn = self:getLuckyBagDetailBtn(i)

			if btn ~= nil then
				gohelper.setActive(btn, i <= len)
			end

			local txtName = "_txtName" .. tostring(i)
			local txt = self[txtName]

			if txt ~= nil then
				gohelper.setActive(txt, i <= len)

				if i <= len then
					local luckyBagId = luckyBagList[i]
					local luckyBagCo = SummonConfig.instance:getLuckyBag(poolCo.id, luckyBagId)

					txt.text = luckyBagCo.name
				end
			end
		end
	end
end

SummonMainLuckyBagView.RemainTimesPosition = {
	NoLuckyBag = {
		x = -232.5,
		y = 113.9
	},
	ExistLuckyBag = {
		x = 140,
		y = 113.9
	}
}

function SummonMainLuckyBagView:refreshLuckyBagStatus(poolCo)
	local isGot = true

	for _, luckyBagId in ipairs(self._luckyBagList) do
		if not SummonLuckyBagModel.instance:isLuckyBagGot(poolCo.id, luckyBagId) then
			isGot = false

			break
		end
	end

	gohelper.setActive(self._goluckybagbtns, isGot)
	gohelper.setActive(self._gosummonbtns, not isGot)
	self:setLuckyBagIconVfx()

	if isGot then
		self:refreshGotStatus(poolCo)
	else
		self:refreshGachaStatus(poolCo)
	end
end

function SummonMainLuckyBagView:refreshGotStatus(poolCo)
	local isOpenCount = 0

	for _, luckyBagId in ipairs(self._luckyBagList) do
		if SummonLuckyBagModel.instance:isLuckyBagOpened(poolCo.id, luckyBagId) then
			isOpenCount = isOpenCount + 1
		end
	end

	local getCount = SummonLuckyBagModel.instance:getLuckyGodCount(poolCo.id)
	local bagCount = #self._luckyBagList
	local isAllGet = bagCount <= getCount
	local isAllOpen = bagCount <= isOpenCount

	gohelper.setActive(self._goalreadyinvited, isAllOpen)
	gohelper.setActive(self._goinvite, not isAllOpen)
	gohelper.setActive(self._goremaintimes, not isAllGet)

	if not isAllGet then
		local anchorPos = SummonMainLuckyBagView.RemainTimesPosition.ExistLuckyBag

		recthelper.setAnchor(self._rectremaintimes, anchorPos.x, anchorPos.y)
		self:refreshRemainTimes(poolCo)
	end
end

function SummonMainLuckyBagView:refreshGachaStatus(poolCo)
	self:refreshCost()
	self:refreshFreeSummonButton(poolCo)

	local anchorPos = SummonMainLuckyBagView.RemainTimesPosition.NoLuckyBag

	recthelper.setAnchor(self._rectremaintimes, anchorPos.x, anchorPos.y)
	self:refreshRemainTimes(poolCo)
end

function SummonMainLuckyBagView:setLuckyBagIconVfx()
	local curPool = SummonMainModel.instance:getCurPool()
	local poolId = curPool.id
	local redDotList = {}

	for i, luckyBagId in ipairs(self._luckyBagList) do
		local goGotVfxName = "_gogotvfx" .. tostring(i)
		local goGotImageName = "_gogotimage" .. tostring(i)
		local isOpen = SummonLuckyBagModel.instance:isLuckyBagOpened(poolId, luckyBagId)
		local isGet = SummonLuckyBagModel.instance:isLuckyBagGot(poolId, luckyBagId)
		local goVfx = self[goGotVfxName]

		gohelper.setActive(goVfx, isGet and not isOpen)
		gohelper.setActive(self[goGotImageName], true)

		local goHasGet = self:getLuckyBagHaveGetGo(i)
		local btnUse = self:getLuckyBagUseBtn(i)

		gohelper.setActive(goHasGet, isGet and isOpen)
		gohelper.setActive(btnUse, isGet and not isOpen)

		local goOpenBgName = "_goopenbg" .. tostring(i)
		local goOpenBg = self[goOpenBgName]
		local goNoOpenBgName = "_gonoopenbg" .. tostring(i)
		local goNoOpenBg = self[goNoOpenBgName]
		local iconStarName = "_iconstar" .. tostring(i)
		local iconStar = self[iconStarName]

		gohelper.setActive(goOpenBg, isOpen)
		gohelper.setActive(goNoOpenBg, not isOpen)

		local color = iconStar.color

		color.a = not isOpen and 1 or 0.5
		iconStar.color = color

		local singleInfo = {
			time = 0,
			id = luckyBagId,
			value = isGet and not isOpen and 1 or 0
		}

		table.insert(redDotList, singleInfo)

		if not isOpen or not isGet then
			self._luckyBagUseDic[i] = 0
		end

		if isOpen and isGet then
			local goUseAnimName = "_animatorGet" .. tostring(i)
			local animator = self[goUseAnimName]

			if animator then
				if self._luckyBagUseDic[i] ~= nil and self._luckyBagUseDic[i] == 0 then
					self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onViewCloseFinish, self)
					self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onViewCloseFinish, self)
				else
					animator:Play("go_hasget_idle", 0, 0)
				end
			end
		end
	end

	local reddotItemInfo = {
		replaceAll = true,
		defineId = RedDotEnum.DotNode.V3a3SkinDiscountCompensate,
		infos = redDotList
	}
	local redDotInfos = {
		reddotItemInfo
	}

	RedDotModel.instance:setRedDotInfo(redDotInfos)

	local refreshlist = {}
	local ids = RedDotModel.instance:_getAssociateRedDots(RedDotEnum.DotNode.V3a3SkinDiscountCompensate)

	for _, id in pairs(ids) do
		refreshlist[id] = true
	end

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, refreshlist)
end

function SummonMainLuckyBagView:onViewCloseFinish(viewName)
	if viewName == ViewName.CharacterGetView then
		local curPool = SummonMainModel.instance:getCurPool()
		local poolId = curPool.id

		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onViewCloseFinish, self)

		for i, luckyBagId in ipairs(self._luckyBagList) do
			local isOpen = SummonLuckyBagModel.instance:isLuckyBagOpened(poolId, luckyBagId)
			local isGet = SummonLuckyBagModel.instance:isLuckyBagGot(poolId, luckyBagId)

			if isOpen and isGet then
				local goUseAnimName = "_animatorGet" .. tostring(i)
				local animator = self[goUseAnimName]

				if animator then
					if self._luckyBagUseDic[i] ~= nil and self._luckyBagUseDic[i] == 0 then
						self._luckyBagUseDic[i] = 1

						animator:Play("go_hasget_in", 0, 0)
					else
						animator:Play("go_hasget_idle", 0, 0)
					end
				end
			end
		end
	end
end

function SummonMainLuckyBagView:refreshFreeSummonButton(poolCo)
	self._compFreeButton = self._compFreeButton or SummonFreeSingleGacha.New(self._btnsummon1.gameObject, poolCo.id)

	self._compFreeButton:refreshUI()
end

function SummonMainLuckyBagView:refreshRemainTimes(poolCo)
	local times = SummonConfig.getSummonSSRTimes(poolCo)
	local summonServerMO = SummonMainModel.instance:getPoolServerMO(poolCo.id)

	if summonServerMO and summonServerMO.luckyBagMO then
		local title = luaLang("summonluckybag_remain_count")
		local remainCount = math.max(0, times - summonServerMO.luckyBagMO.notSSRCount)

		self._txttimes.text = GameUtil.getSubPlaceholderLuaLangOneParam(title, remainCount)
	else
		self._txttimes.text = "-"
	end
end

function SummonMainLuckyBagView:refreshCost()
	local curPool = SummonMainModel.instance:getCurPool()

	if curPool then
		self:_refreshSingleCost(curPool.cost1, self._simagecurrency1, "_txtcurrency1")

		local gachaMaxTimes = SummonLuckyBagModel.instance:getGachaRemainTimes(curPool.id)

		if gachaMaxTimes and gachaMaxTimes >= 10 then
			ZProj.UGUIHelper.SetGrayscale(self._btnsummon10.gameObject, false)
			ZProj.UGUIHelper.SetGrayscale(self._simagecurrency10.gameObject, false)
		else
			ZProj.UGUIHelper.SetGrayscale(self._btnsummon10.gameObject, true)
			ZProj.UGUIHelper.SetGrayscale(self._simagecurrency10.gameObject, true)
		end

		self:_refreshSingleCost(curPool.cost10, self._simagecurrency10, "_txtcurrency10")
	end
end

function SummonMainLuckyBagView:_refreshSingleCost(costs, icon, numTxt)
	local cost_type, cost_id, cost_num = SummonMainModel.getCostByConfig(costs, true)
	local cost_icon = SummonMainModel.getSummonItemIcon(cost_type, cost_id)

	icon:LoadImage(cost_icon)

	local num = ItemModel.instance:getItemQuantity(cost_type, cost_id)

	self[numTxt .. "1"].text = luaLang("multiple") .. cost_num
	self[numTxt .. "2"].text = ""
end

function SummonMainLuckyBagView:_refreshOpenTime()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local poolMO = SummonMainModel.instance:getPoolServerMO(curPool.id)

	if poolMO ~= nil and poolMO.offlineTime ~= 0 and poolMO.offlineTime < TimeUtil.maxDateTimeStamp then
		local time = poolMO.offlineTime - ServerTime.now()

		self._txtdeadline.text = string.format(luaLang("summonmainequipprobup_deadline"), SummonModel.formatRemainTime(time))
	else
		self._txtdeadline.text = ""
	end
end

function SummonMainLuckyBagView:getLuckyBagDetailBtn(i)
	return self["_btnluckybag" .. tostring(i)]
end

function SummonMainLuckyBagView:getLuckyBagUseBtn(i)
	return self["#btn_use" .. tostring(i)]
end

function SummonMainLuckyBagView:getLuckyBagHaveGetGo(i)
	return self["_gohasget" .. tostring(i)]
end

function SummonMainLuckyBagView:onSummonFailed()
	self.summonSuccess = false

	self:refreshCost()
end

function SummonMainLuckyBagView:onSummonReply()
	self.summonSuccess = true
end

function SummonMainLuckyBagView:onItemChanged()
	if SummonController.instance.isWaitingSummonResult or self.summonSuccess then
		return
	end

	self:refreshCost()
end

return SummonMainLuckyBagView
