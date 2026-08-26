-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinBuildingLevelUpListItem.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinBuildingLevelUpListItem", package.seeall)

local AssassinBuildingLevelUpListItem = class("AssassinBuildingLevelUpListItem", LuaCompBase)
local CurrencyNumColor_Full = "#FFFFFF"
local CurrencyNumColor_Empty = "#F54623"
local lockScreenKey = "AssassinBuildingLevelUpListItem"
local DelaySendLevelUpRpc = 0.3

function AssassinBuildingLevelUpListItem:init(go)
	self.go = go
	self._godone = gohelper.findChild(self.go, "go_done")
	self._golock = gohelper.findChild(self.go, "go_lock")
	self._gounlock = gohelper.findChild(self.go, "go_unlock")
	self._gounlockeffects = gohelper.findChild(self.go, "go_unlock/go_effects")
	self._golockeffects = gohelper.findChild(self.go, "go_lock/go_effects")
	self._godoneeffects = gohelper.findChild(self.go, "go_done/go_effects")
	self._goeffectitem = gohelper.findChild(self.go, "go_effectitem")
	self._btnlevelup = gohelper.findChildButtonWithAudio(self.go, "go_unlock/btn_levelup", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._gocost = gohelper.findChild(self.go, "go_unlock/go_cost")
	self._gocostitem = gohelper.findChild(self.go, "go_unlock/go_cost/go_costitem")
	self._txtcostnum = gohelper.findChildText(self.go, "go_unlock/go_cost/go_costitem/txt_num")
	self._simagecosticon = gohelper.findChildSingleImage(self.go, "go_unlock/go_cost/go_costitem/txt_num/image_icon")
	self._txtlv1 = gohelper.findChildText(self.go, "go_done/level/txt_Lv1")
	self._txtlv2 = gohelper.findChildText(self.go, "go_lock/level/txt_Lv2")
	self._txtpreLv = gohelper.findChildText(self.go, "go_unlock/level/txt_preLv")
	self._txtnextLv = gohelper.findChildText(self.go, "go_unlock/level/txt_nextLv")
	self._golevelupeffect = gohelper.findChild(self.go, "go_unlock/#leveing")
	self._gounlocktips = gohelper.findChildText(self.go, "go_lock/#go_unlockTips")
	self._txtunlocktips = gohelper.findChildText(self.go, "go_lock/#go_unlockTips/#txt_unlockTips")
	self._rewardItemTab = self:getUserDataTb_()
	self._rewardItemParentMap = self:getUserDataTb_()
	self._rewardItemParentMap[AssassinEnum.BuildingStatus.Locked] = self._golockeffects
	self._rewardItemParentMap[AssassinEnum.BuildingStatus.Unlocked] = self._gounlockeffects
	self._rewardItemParentMap[AssassinEnum.BuildingStatus.LevelUp] = self._godoneeffects
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)
	self._canvasgroup = gohelper.onceAddComponent(self.go, gohelper.Type_CanvasGroup)
end

function AssassinBuildingLevelUpListItem:addEventListeners()
	self._btnlevelup:AddClickListener(self._btnlevelupOnClick, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.UpdateCoinNum, self.refresh, self)
end

function AssassinBuildingLevelUpListItem:removeEventListeners()
	self._btnlevelup:RemoveClickListener()
end

function AssassinBuildingLevelUpListItem:_btnlevelupOnClick()
	if self._status ~= AssassinEnum.BuildingStatus.Unlocked then
		return
	end

	local isEnableLevelUp, nextLvBuildingId = self._mapMo:isBuildingLevelUp2NextLv(self._type)

	if not isEnableLevelUp then
		GameFacade.showToast(ToastEnum.CurrencyNotEnough)

		return
	end

	AssassinController.instance:dispatchEvent(AssassinEvent.OnLevelUpBuilding)

	self._levelUpFlow = FlowSequence.New()

	self._levelUpFlow:addWork(FunctionWork.New(self._lockScreen, self, true))
	self._levelUpFlow:addWork(FunctionWork.New(self._playAnim, self, self:_createAnimParam("leveup", nil, AudioEnum2_9.Dungeon.play_ui_unlockMode)))
	self._levelUpFlow:addWork(DelayDoFuncWork.New(self._sendRpc2LevelUpBuilding, self, DelaySendLevelUpRpc, nextLvBuildingId))
	self._levelUpFlow:addWork(FunctionWork.New(self._playAnim, self, self:_createAnimParam("open", 1)))
	self._levelUpFlow:addWork(FunctionWork.New(self._lockScreen, self, false))
	self._levelUpFlow:start()
end

function AssassinBuildingLevelUpListItem:_playAnim(animParam)
	if not animParam or string.nilorempty(animParam.name) then
		return
	end

	self._animator:Play(animParam.name, 0, animParam.normalizedTime)

	if animParam.audioId then
		AudioMgr.instance:trigger(animParam.audioId)
	end
end

function AssassinBuildingLevelUpListItem:_createAnimParam(clicpName, normalizedTime, audioId)
	normalizedTime = normalizedTime or 0

	return {
		name = clicpName,
		normalizedTime = normalizedTime,
		audioId = audioId
	}
end

function AssassinBuildingLevelUpListItem:_sendRpc2LevelUpBuilding(nextLvBuildingId)
	AssassinOutSideRpc.instance:sendBuildingLevelUpRequest(nextLvBuildingId, function(__, resultCode)
		if resultCode ~= 0 then
			return
		end

		local params = {
			buildingType = self._type
		}

		ViewMgr.instance:openView(ViewName.AssassinBuildingLevelUpSuccessView, params)
	end)
end

function AssassinBuildingLevelUpListItem:_destroyLevelUpFlow()
	if self._levelUpFlow then
		self._levelUpFlow:destroy()

		self._levelUpFlow = nil
	end
end

function AssassinBuildingLevelUpListItem:onUpdateMO(mo, index)
	self:_lockScreen(false)
	self:_destroyLevelUpFlow()

	self._config = mo
	self._index = index

	self:checkIsNeedPlayOpenAnim()
	self:refresh()
end

function AssassinBuildingLevelUpListItem:refresh()
	self:refreshStatus()
	self:refreshRewards()
	self:refreshCosts()
end

function AssassinBuildingLevelUpListItem:refreshStatus()
	self._mapMo = AssassinOutsideModel.instance:getBuildingMapMo()
	self._status = self._mapMo:getBuildingStatus(self._config.id)
	self._type = self._config.type
	self._level = self._config.level

	gohelper.setActive(self._godone, self._status == AssassinEnum.BuildingStatus.LevelUp)
	gohelper.setActive(self._golock, self._status == AssassinEnum.BuildingStatus.Locked)
	gohelper.setActive(self._gounlock, self._status == AssassinEnum.BuildingStatus.Unlocked)

	self._txtlv1.text = self._level
	self._txtlv2.text = self._level
	self._txtpreLv.text = self._level - 1
	self._txtnextLv.text = self._level

	local isEnableLevelUp = self._mapMo:isBuildingLevelUp2NextLv(self._type)

	gohelper.setActive(self._golevelupeffect, isEnableLevelUp)

	if self._status == AssassinEnum.BuildingStatus.Locked then
		self._txtunlocktips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("assassinbuildinglevelupview_unlocktips"), self._config.unlockDesc)
	end
end

function AssassinBuildingLevelUpListItem:refreshRewards()
	self._descList = string.split(self._config.desc, "#")
	self._effectDescList = string.split(self._config.effectDesc, "#")
	self._effectIconUrlList = string.split(self._config.itemIcon, "#")

	local useMap = {}
	local goparent = self._rewardItemParentMap[self._status]

	for i = 1, #self._descList do
		local rewardItem = self:_getOrCreateSingleRewardItem(i, goparent)

		self:_refreshSingleRewardItem(rewardItem, self._descList[i], self._effectDescList[i], self._effectIconUrlList[i], i)

		useMap[rewardItem] = true
	end

	for _, rewardItem in pairs(self._rewardItemTab) do
		if not useMap[rewardItem] then
			gohelper.setActive(rewardItem.go, false)
		end
	end
end

function AssassinBuildingLevelUpListItem:_getOrCreateSingleRewardItem(index, goparent)
	local rewardItem = self._rewardItemTab[index]

	if not rewardItem then
		rewardItem = self:getUserDataTb_()
		rewardItem.go = gohelper.clone(self._goeffectitem, goparent, "effect_" .. index)
		rewardItem.tran = rewardItem.go.transform
		rewardItem.txtdesc = gohelper.findChildText(rewardItem.go, "txt_desc")
		rewardItem.txteffectdesc = gohelper.findChildText(rewardItem.go, "txt_effectdesc")
		rewardItem.imageicon = gohelper.findChildImage(rewardItem.go, "image_icon")
		self._rewardItemTab[index] = rewardItem
	else
		rewardItem.tran:SetParent(goparent.transform)
	end

	return rewardItem
end

function AssassinBuildingLevelUpListItem:_refreshSingleRewardItem(rewardItem, desc, effectDesc, effectIconUrl, index)
	gohelper.setActive(rewardItem.go, true)

	rewardItem.txteffectdesc.text = effectDesc
	rewardItem.txtdesc.text = desc

	UISpriteSetMgr.instance:setSp01AssassinSprite(rewardItem.imageicon, effectIconUrl)
end

function AssassinBuildingLevelUpListItem:refreshCosts()
	local curCoinNum = AssassinController.instance:getCoinNum()
	local targetCoinNum = self._config.cost
	local isFull = targetCoinNum <= curCoinNum

	self._txtcostnum.text = targetCoinNum

	SLFramework.UGUI.GuiHelper.SetColor(self._txtcostnum, (isFull or nil) and (CurrencyNumColor_Full or CurrencyNumColor_Empty))
end

function AssassinBuildingLevelUpListItem:_playOpenAnim()
	self:setVisible(true)
	self:_lockScreen(false)
	self:_playAnim(self:_createAnimParam("open"))
	AssassinBuildingLevelUpListModel.instance:onItemPlayOpenAnimDone()
end

function AssassinBuildingLevelUpListItem:checkIsNeedPlayOpenAnim()
	local needPlayAnimCount = AssassinBuildingLevelUpListModel.instance:getNeedPlayOpenAnimItemCount()
	local needPlayOpenAnim = needPlayAnimCount >= self._index

	self:setVisible(not needPlayOpenAnim)

	if needPlayOpenAnim then
		self:_lockScreen(true)
		TaskDispatcher.cancelTask(self._playOpenAnim, self)
		TaskDispatcher.runDelay(self._playOpenAnim, self, AssassinEnum.BuildingDelayOpenAnim * (self._index - 1))
	end
end

function AssassinBuildingLevelUpListItem:_lockScreen(lock)
	AssassinHelper.lockScreen(lockScreenKey, lock)
end

function AssassinBuildingLevelUpListItem:setVisible(isVisible)
	self._canvasgroup.alpha = isVisible and 1 or 0
	self._canvasgroup.interactable = isVisible
	self._canvasgroup.blocksRaycasts = isVisible
end

function AssassinBuildingLevelUpListItem:onDestroy()
	self._simagecosticon:UnLoadImage()
	self:_lockScreen(false)
	self:_destroyLevelUpFlow()
	TaskDispatcher.cancelTask(self._playOpenAnim, self)
end

return AssassinBuildingLevelUpListItem
