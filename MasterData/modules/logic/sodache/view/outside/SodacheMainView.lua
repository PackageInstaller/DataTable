-- chunkname: @modules/logic/sodache/view/outside/SodacheMainView.lua

module("modules.logic.sodache.view.outside.SodacheMainView", package.seeall)

local SodacheMainView = class("SodacheMainView", BaseView)

function SodacheMainView:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "TopLeft/#btn_Task")
	self._goTaskReddot = gohelper.findChild(self.viewGO, "TopLeft/#btn_Task/#go_TaskReddot")
	self._btnHandBook = gohelper.findChildButtonWithAudio(self.viewGO, "TopLeft/#btn_HandBook")
	self._goHandBookReddot = gohelper.findChild(self.viewGO, "TopLeft/#btn_HandBook/#go_HandBookReddot")
	self._btnStore = gohelper.findChildButtonWithAudio(self.viewGO, "Store/#btn_Store")
	self._txtCurrencyNum = gohelper.findChildText(self.viewGO, "Store/#txt_CurrencyNum")
	self._imageProgress = gohelper.findChildImage(self.viewGO, "AdventureRank/Level/#image_Progress")
	self._txtLevel = gohelper.findChildText(self.viewGO, "AdventureRank/Level/#txt_Level")
	self._txtAdd = gohelper.findChildText(self.viewGO, "AdventureRank/Level/#txt_Add")
	self._btnAdventureRank = gohelper.findChildButtonWithAudio(self.viewGO, "AdventureRank/#btn_AdventureRank")
	self._goAdventureReddot = gohelper.findChild(self.viewGO, "AdventureRank/#go_AdventureReddot")
	self._goTips = gohelper.findChild(self.viewGO, "#go_Tips")
	self._txtTips = gohelper.findChildText(self.viewGO, "#go_Tips/#txt_Tips")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheMainView:addEvents()
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
	self._btnHandBook:AddClickListener(self._btnHandBookOnClick, self)
	self._btnStore:AddClickListener(self._btnStoreOnClick, self)
	self._btnAdventureRank:AddClickListener(self._btnAdventureRankOnClick, self)
end

function SodacheMainView:removeEvents()
	self._btnTask:RemoveClickListener()
	self._btnHandBook:RemoveClickListener()
	self._btnStore:RemoveClickListener()
	self._btnAdventureRank:RemoveClickListener()
end

function SodacheMainView:_btnTaskOnClick()
	ViewMgr.instance:openView(ViewName.SodacheTaskView)
end

function SodacheMainView:_btnHandBookOnClick()
	ViewMgr.instance:openView(ViewName.SodacheHandbookView)
end

function SodacheMainView:_btnStoreOnClick()
	SodacheController.instance:openStoreView(VersionActivity3_7Enum.ActivityId.SodacheStore)
end

function SodacheMainView:_btnAdventureRankOnClick()
	ViewMgr.instance:openView(ViewName.SodacheLevelView)
end

function SodacheMainView:_editableInitView()
	self.animLevel = gohelper.findChildAnim(self.viewGO, "AdventureRank/Level")
	self.matProgress = UnityEngine.Object.Instantiate(self._imageProgress.material)
	self._imageProgress.material = self.matProgress
	self.goCoin = gohelper.findChild(self.viewGO, "#go_topright/currencyview")
	self.currencyComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.goCoin, SodacheCurrencyComp, {
		bagType = SodacheEnum.BagType.Outside
	})
	self.outsideMo = SodacheModel.instance:getOutsideMo()

	local bagMo = self.outsideMo:getBag(SodacheEnum.BagType.Outside)

	if bagMo.coinChange then
		local count = bagMo:getItemQuantity(SodacheEnum.CurrencyId.Coin) - bagMo.coinChange

		self.currencyComp:setCount(count)
	end

	self.reddotTask = RedDotController.instance:addNotEventRedDot(self._goTaskReddot, self.checkTaskReddot, self)
end

function SodacheMainView:onOpen()
	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString("music_vocal_filter"), AudioMgr.instance:getIdFromString("accompaniment"))
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnTaskChange, self.refreshTaskReddot, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)
	self:refreshCurrency()

	self.propMo = self.outsideMo.prop
	self.nextLvlCfg = lua_sodache_level.configDict[self.propMo.level + 1]

	if self.propMo.oldLevel then
		self:playLevelUp()
		self:refreshLevel()
	elseif self.nextLvlCfg and self.propMo.oldExp then
		self._txtLevel.text = self.propMo.level

		local value = self.propMo.oldExp / self.nextLvlCfg.cosume

		SodacheUtil.setMaterialValue(self.matProgress, value)
	else
		self:refreshLevel()
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnGuideLevel, self.checkLv)
	TaskDispatcher.runDelay(self.delayPlayChangeAnim, self, 0.75)
end

function SodacheMainView:onClose()
	AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString("music_vocal_filter"), AudioMgr.instance:getIdFromString("original"))
end

function SodacheMainView:onDestroyView()
	if not ViewMgr.instance:isOpen(ViewName.SodacheMapView) then
		SodacheMapUtil.instance:clear()
	end

	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	if self.matProgress then
		UnityEngine.Object.Destroy(self.matProgress)
	end

	TaskDispatcher.cancelTask(self.delayPlayChangeAnim, self)
end

function SodacheMainView.checkLv(param)
	local needLv = tonumber(param) or 0
	local propMo = SodacheModel.instance:getOutsideMo().prop

	if needLv <= propMo.level then
		return true
	end
end

function SodacheMainView:refreshLevel()
	self._txtLevel.text = self.propMo.level

	SodacheUtil.setMaterialValue(self.matProgress, self.nextLvlCfg and self.propMo.exp / self.nextLvlCfg.cosume or 1)
end

function SodacheMainView:refreshCurrency()
	local mo = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Sodache)

	self._txtCurrencyNum.text = mo.quantity
end

function SodacheMainView:playLevelUp()
	ViewMgr.instance:openView(ViewName.SodacheLevelUpView)
end

function SodacheMainView:delayPlayChangeAnim()
	if self.nextLvlCfg and self.propMo.oldExp then
		local s = self.propMo.oldExp / self.nextLvlCfg.cosume
		local e = self.propMo.exp / self.nextLvlCfg.cosume
		local addExp = self.propMo.exp - self.propMo.oldExp

		self._txtAdd.text = string.format("+%d", addExp)

		self.animLevel:Play("add", 0, 0)

		local duration = (e - s) * SodacheEnum.LevelProgressTime

		self.tweenId = ZProj.TweenHelper.DOTweenFloat(s, e, duration, self._frameCall, self._endCall, self, nil, EaseType.Linear)
	end

	local bagMo = self.outsideMo:getBag(SodacheEnum.BagType.Outside)
	local coinChange = bagMo.coinChange

	if coinChange then
		self.currencyComp:playAddAnim(coinChange)
		bagMo:clearCoinChange()
	end
end

function SodacheMainView:_frameCall(value)
	SodacheUtil.setMaterialValue(self.matProgress, value)
end

function SodacheMainView:_endCall()
	self:refreshLevel()
	self.propMo:clearOldExp()
end

function SodacheMainView:checkTaskReddot()
	return (self.outsideMo and self.outsideMo.taskBox:hasRewardToGet() or nil) and true
end

function SodacheMainView:refreshTaskReddot()
	self.reddotTask:refreshRedDot()
end

return SodacheMainView
