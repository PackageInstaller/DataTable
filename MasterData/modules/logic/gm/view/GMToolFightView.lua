-- chunkname: @modules/logic/gm/view/GMToolFightView.lua

module("modules.logic.gm.view.GMToolFightView", package.seeall)

local GMToolFightView = class("GMToolFightView", BaseView)

function GMToolFightView:onInitView()
	self._toggleShowFightNum = gohelper.findChildToggle(self.viewGO, "viewport/content/item28/Toggle1")
	self._toggleShowFightUI = gohelper.findChildToggle(self.viewGO, "viewport/content/item28/Toggle2")
	self._btnFightLockLifeMySide = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item29/Button1")
	self._btnFightLockLifeEnemySide = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item29/Button2")
	self._btnAddHurtMySide = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item30/Button1")
	self._btnAddHurtEnemySide = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item30/Button2")
	self._btnReduceDamageMySide = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item31/Button1")
	self._btnReduceDamageEnemySide = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item31/Button2")
	self._inpCost = gohelper.findChildInputField(self.viewGO, "viewport/content/item32/inpText")
	self._btnAddCost = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item32/Button1")
	self._btnAddMySideExpoint = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item33/Button1")
	self._btnAddEnemySideExpoint = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item33/Button2")
	self._btnArrow = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item28/hideDetail/Arrow")
	self._hideTemplate = gohelper.findChild(self.viewGO, "viewport/content/item28/hideDetail/Template")
	self._clickMask = gohelper.findChild(self.viewGO, "viewport/content/item28/hideDetail/clickmask")
	self._itemGO = gohelper.findChild(self.viewGO, "viewport/content/item28/hideDetail/Template/Viewport/Item")
	self._contentGO = gohelper.findChild(self.viewGO, "viewport/content/item28/hideDetail/Template/Viewport/Content")
	self._itemList = {}

	gohelper.setActive(self._hideTemplate, false)
	gohelper.setActive(self._clickMask, false)
	gohelper.setActive(self._itemGO, false)
	recthelper.setHeight(self._hideTemplate.transform, 400)
end

function GMToolFightView:addEvents()
	self._toggleShowFightNum:AddOnValueChanged(self._onToggleShowFightNumChange, self)
	self._toggleShowFightUI:AddOnValueChanged(self._onToggleShowFightUIChange, self)
	self._btnFightLockLifeMySide:AddClickListener(self._onToggleMySideLockLifeChange, self)
	self._btnFightLockLifeEnemySide:AddClickListener(self._onToggleEnemySideLockLifeChange, self)
	self._btnAddHurtMySide:AddClickListener(self._onToggleMySideAddHurtChange, self)
	self._btnAddHurtEnemySide:AddClickListener(self._onToggleEnemySideAddHurtChange, self)
	self._btnReduceDamageMySide:AddClickListener(self._onToggleMySideDamageChange, self)
	self._btnReduceDamageEnemySide:AddClickListener(self._onToggleEnemySideDamageChange, self)
	self._btnAddCost:AddClickListener(self._onClickAddCost, self)
	self._btnAddMySideExpoint:AddClickListener(self._onClickAddMySideExpoint, self)
	self._btnAddEnemySideExpoint:AddClickListener(self._onClickEnemySideExpoint, self)
	self._btnArrow:AddClickListener(self._onClickArrow, self)
	gohelper.getClick(self._clickMask):AddClickListener(self._onClickMask, self)
end

function GMToolFightView:removeEvents()
	self._toggleShowFightNum:RemoveOnValueChanged()
	self._toggleShowFightUI:RemoveOnValueChanged()
	self._btnFightLockLifeMySide:RemoveClickListener()
	self._btnFightLockLifeEnemySide:RemoveClickListener()
	self._btnAddHurtMySide:RemoveClickListener()
	self._btnAddHurtEnemySide:RemoveClickListener()
	self._btnReduceDamageMySide:RemoveClickListener()
	self._btnReduceDamageEnemySide:RemoveClickListener()
	self._btnAddCost:RemoveClickListener()
	self._btnAddMySideExpoint:RemoveClickListener()
	self._btnAddEnemySideExpoint:RemoveClickListener()
	self._btnArrow:RemoveClickListener()
	gohelper.getClick(self._clickMask):RemoveClickListener()

	for i, item in ipairs(self._itemList) do
		gohelper.getClick(item):RemoveClickListener()
	end
end

function GMToolFightView:onOpen()
	self.initDone = false

	self:refreshToggleStatus()

	self.initDone = true
end

function GMToolFightView:refreshToggleStatus()
	self._toggleShowFightNum.isOn = PlayerPrefsHelper.getNumber(PlayerPrefsKey.FightShowFightNum, 1) == 1

	local isOn = true
	local list = GMFightShowState.getList()

	for i, mo in ipairs(list) do
		local status = GMFightShowState.getStatus(mo.valueKey)

		if not status then
			isOn = false

			break
		end
	end

	self._toggleShowFightUI.isOn = isOn
end

function GMToolFightView:_onToggleShowFightNumChange()
	if not self.initDone then
		return
	end

	local isOn = self._toggleShowFightNum.isOn

	FightFloatMgr.instance:setCanShowFightNumUI(isOn)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.FightShowFightNum, isOn and 1 or 0)
end

function GMToolFightView:_onToggleShowFightUIChange()
	if not self.initDone then
		return
	end

	self:_oneKeySetStatus(self._toggleShowFightUI.isOn)
	FightController.instance:dispatchEvent(FightEvent.GMHideFightView)
end

function GMToolFightView:_onToggleMySideLockLifeChange()
	GMRpc.instance:sendGMRequest("fight lockLife 0")
end

function GMToolFightView:_onToggleEnemySideLockLifeChange()
	GMRpc.instance:sendGMRequest("fight lockLife 1")
end

function GMToolFightView:_onToggleMySideAddHurtChange()
	GMRpc.instance:sendGMRequest("fight addHurt 0")
end

function GMToolFightView:_onToggleEnemySideAddHurtChange()
	GMRpc.instance:sendGMRequest("fight addHurt 1")
end

function GMToolFightView:_onToggleMySideDamageChange()
	GMRpc.instance:sendGMRequest("fight reduceDamage 0")
end

function GMToolFightView:_onToggleEnemySideDamageChange()
	GMRpc.instance:sendGMRequest("fight reduceDamage 1")
end

function GMToolFightView:_onClickAddCost()
	local cost = self._inpCost:GetText()

	GMRpc.instance:sendGMRequest(string.format("fight addPower %s 0", cost))
end

function GMToolFightView:_onClickAddMySideExpoint()
	GMRpc.instance:sendGMRequest("fight addExpoint 5 0")
end

function GMToolFightView:_onClickEnemySideExpoint()
	GMRpc.instance:sendGMRequest("fight addExpoint 5 1")
end

function GMToolFightView:_onClickArrow()
	gohelper.setActive(self._hideTemplate, true)
	gohelper.setActive(self._clickMask, true)

	local list = GMFightShowState.getList()

	for i, mo in ipairs(list) do
		local item = self._itemList[i]

		if not item then
			item = gohelper.clone(self._itemGO, self._contentGO, "item" .. i)

			table.insert(self._itemList, item)
		end

		gohelper.setActive(item, true)

		gohelper.findChildText(item, "Item Label").text = i .. mo.desc

		gohelper.setActive(gohelper.findChild(item, "Item Checkmark"), GMFightShowState.getStatus(mo.valueKey))
		gohelper.getClick(item):AddClickListener(self._onClickItem, self, mo)
	end

	for i = #list + 1, #self._itemList do
		gohelper.setActive(self._itemList[i], false)
	end
end

function GMToolFightView:_oneKeySetStatus(newStatus)
	local list = GMFightShowState.getList()

	for i, mo in ipairs(list) do
		local item = self._itemList[i]

		GMFightShowState.setStatus(mo.valueKey, newStatus)
		gohelper.setActive(gohelper.findChild(item, "Item Checkmark"), newStatus)
	end

	FightController.instance:dispatchEvent(FightEvent.GMHideFightView)
end

function GMToolFightView:_onClickItem(mo)
	local item = self._itemList[mo.id]
	local oldStatus = GMFightShowState.getStatus(mo.valueKey)
	local newStatus = oldStatus == nil or oldStatus == false

	GMFightShowState.setStatus(mo.valueKey, newStatus)
	gohelper.setActive(gohelper.findChild(item, "Item Checkmark"), newStatus)
	FightController.instance:dispatchEvent(FightEvent.GMHideFightView)
end

function GMToolFightView:_onClickMask()
	gohelper.setActive(self._hideTemplate, false)
	gohelper.setActive(self._clickMask, false)
end

return GMToolFightView
