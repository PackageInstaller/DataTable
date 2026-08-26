-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/factory/VersionActivity1_8FactoryBlueprintPartItem.lua

module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryBlueprintPartItem", package.seeall)

local VersionActivity1_8FactoryBlueprintPartItem = class("VersionActivity1_8FactoryBlueprintPartItem", LuaCompBase)
local UNLOCK_ANIM_TIME = 0.87

function VersionActivity1_8FactoryBlueprintPartItem:ctor(componentId)
	self.actId = Activity157Model.instance:getActId()
	self.componentId = componentId
end

function VersionActivity1_8FactoryBlueprintPartItem:init(go)
	self.go = go
	self.trans = self.go.transform
	self._statusAnimator = gohelper.findChildComponent(self.go, "status", typeof(UnityEngine.Animator))
	self._golock = gohelper.findChild(self.go, "status/#go_lock")
	self._golockicon = gohelper.findChild(self.go, "status/#go_lock/#go_lockedicon")
	self._goberepaired = gohelper.findChild(self.go, "status/#go_lock/#go_berepaired")
	self._btnrepair = gohelper.findChildClickWithDefaultAudio(self.go, "status/#go_lock/#go_berepaired/#btn_repair")
	self._goberepairedreddot = gohelper.findChild(self.go, "status/#go_lock/#go_berepaired/#go_reddot")
	self._txtrepairtip = gohelper.findChildText(self.go, "status/#go_lock/#go_berepaired/bg/#txt_num")
	self._imagerepairicon = gohelper.findChildImage(self.go, "status/#go_lock/#go_berepaired/bg/icon")
	self._gonormal = gohelper.findChild(self.go, "status/#go_normal")
	self._btnpart = gohelper.findChildClickWithDefaultAudio(self.go, "#btn_part")
	self._gobtnpart = self._btnpart.gameObject

	local strPartItem = Activity157Config.instance:getAct157Const(self.actId, Activity157Enum.ConstId.FactoryRepairPartItem)
	local partItemParam = strPartItem and string.splitToNumber(strPartItem, "#")

	if partItemParam then
		local currencyCfg = CurrencyConfig.instance:getCurrencyCo(partItemParam[2])
		local currencyIcon = currencyCfg and currencyCfg.icon

		if currencyIcon then
			UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagerepairicon, currencyIcon .. "_1", true)
		end
	end

	RedDotController.instance:addRedDot(self._goberepairedreddot, RedDotEnum.DotNode.V1a8DungeonFactoryCanRepair, self.componentId)
end

function VersionActivity1_8FactoryBlueprintPartItem:addEventListeners()
	self._btnrepair:AddClickListener(self._btnrepairOnClick, self)
	self._btnpart:AddClickListener(self._btnpartOnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
end

function VersionActivity1_8FactoryBlueprintPartItem:removeEventListeners()
	self._btnrepair:RemoveClickListener()
	self._btnpart:RemoveClickListener()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
end

function VersionActivity1_8FactoryBlueprintPartItem:_btnrepairOnClick()
	local isCanRepair = Activity157Model.instance:isCanRepairComponent(self.componentId)

	if isCanRepair then
		Activity157Controller.instance:enterFactoryRepairGame(self.componentId)
	else
		GameFacade.showToast(ToastEnum.V1a8Activity157RepairNotEnoughItem)
	end
end

function VersionActivity1_8FactoryBlueprintPartItem:_btnpartOnClick()
	local isRepaired = Activity157Model.instance:isRepairComponent(self.componentId)

	if not isRepaired then
		GameFacade.showToast(ToastEnum.V1a8Activity157NotRepairPreComponent)
	end
end

function VersionActivity1_8FactoryBlueprintPartItem:_onCurrencyChange(changeIds)
	local partId = CurrencyEnum.CurrencyType.V1a8FactoryPart

	if not changeIds[partId] then
		return
	end

	self:refreshRepairTip()
end

function VersionActivity1_8FactoryBlueprintPartItem:refresh()
	local isRepaired = Activity157Model.instance:isRepairComponent(self.componentId)

	if isRepaired then
		local prefsKey = VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedFactoryComponentUnlockANim .. self.componentId
		local hasPlayed = Activity157Model.instance:getHasPlayedAnim(prefsKey)

		if hasPlayed then
			self:setUnlocked()
		else
			self:playUnlockAnim(prefsKey)
		end
	else
		self:refreshLockedStatus()
	end
end

function VersionActivity1_8FactoryBlueprintPartItem:setUnlocked()
	gohelper.setActive(self._gonormal, true)
	gohelper.setActive(self._golock, false)
	gohelper.setActive(self._gobtnpart, false)
end

function VersionActivity1_8FactoryBlueprintPartItem:refreshLockedStatus()
	local isPreComponentRepaired = Activity157Model.instance:isPreComponentRepaired(self.componentId)

	gohelper.setActive(self._gonormal, false)
	gohelper.setActive(self._golock, true)
	gohelper.setActive(self._golockicon, not isPreComponentRepaired)
	gohelper.setActive(self._gobtnpart, not isPreComponentRepaired)
	gohelper.setActive(self._goberepaired, isPreComponentRepaired)

	if isPreComponentRepaired then
		self:refreshRepairTip()
	end
end

function VersionActivity1_8FactoryBlueprintPartItem:refreshRepairTip()
	local type, id, quantity = Activity157Config.instance:getComponentUnlockCondition(self.actId, self.componentId)
	local curQuantity = ItemModel.instance:getItemQuantity(type, id)
	local color = "#F5744D"

	if quantity and quantity <= curQuantity then
		color = "#88CB7F"

		ZProj.UGUIHelper.SetGrayscale(self._btnrepair.gameObject, false)
	else
		ZProj.UGUIHelper.SetGrayscale(self._btnrepair.gameObject, true)
	end

	self._txtrepairtip.text = string.format("<color=%s>%s</color>/%s", color, curQuantity, quantity or 0)
end

function VersionActivity1_8FactoryBlueprintPartItem:playUnlockAnim(prefsKey)
	if not self.componentId then
		return
	end

	self:refreshLockedStatus()
	self._statusAnimator:Play("unlock", 0, 0)
	Activity157Model.instance:setHasPlayedAnim(prefsKey)
	AudioMgr.instance:trigger(AudioEnum.UI.Act157UnlockFactoryComponent)
	TaskDispatcher.cancelTask(self.setUnlocked, self)
	TaskDispatcher.runDelay(self.setUnlocked, self, UNLOCK_ANIM_TIME)
end

function VersionActivity1_8FactoryBlueprintPartItem:destroy()
	TaskDispatcher.cancelTask(self.setUnlocked, self)
end

function VersionActivity1_8FactoryBlueprintPartItem:onDestroy()
	TaskDispatcher.cancelTask(self.setUnlocked, self)
end

return VersionActivity1_8FactoryBlueprintPartItem
