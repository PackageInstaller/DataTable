-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/demondescend/view/DemonDescendBuffShopView.lua

module("logic.extensions.demondescend.view.DemonDescendBuffShopView", package.seeall)

local DemonDescendBuffShopView = class("DemonDescendBuffShopView", ViewComponent)

function DemonDescendBuffShopView:buildUI()
	DemonDescendBuffShopView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnReset = self:getGo("btnReset")
	self._goldBarCon = self:getGo("goldBarCon")

	local buffScrView = self:getGo("buffCol/scrView")
	local buffScrCell = self:getGo("buffCol/scrCell")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._unitScrollerListDic = {}
end

function DemonDescendBuffShopView:bindEvents()
	DemonDescendBuffShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onClikBtnReset, self)
end

function DemonDescendBuffShopView:unbindEvents()
	DemonDescendBuffShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReset)
end

function DemonDescendBuffShopView:onEnter()
	DemonDescendBuffShopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._isTrial = checkbool(params[2])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = DemonDescendController.instance:getSubMo(self._activityId)
	self._actData = DemonDescendConfig.instance:getActData(self._activityId)
	self._wineItem = self._subMo:getWineItem()
	self._isNeedReset = false

	self.addGEvent(self, GlobalNotify.HandlePM_DemonDescendUnlockBuffRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DemonDescendResetBuffRes, self._handlePM_DemonDescendResetBuffRes, self)

	local goldInfo = {
		showAdd = false,
		id = self._wineItem.matStr
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, {
		goldInfo
	})
	self:_onUpdate()
end

function DemonDescendBuffShopView:onExit()
	DemonDescendBuffShopView.super.onExit(self)
	self:_onClearBuffCol()
end

function DemonDescendBuffShopView:_handlePM_DemonDescendResetBuffRes()
	FloatWordMgr.instance:show(string.format("重置成功，已返还所有%s", self._wineItem.matName))
	self:_onUpdate()
end

function DemonDescendBuffShopView:_onUpdate()
	self._isNeedReset = false

	local cfgs = DemonDescendConfig.instance:getBuffCfgs(self._activityId) or {}

	for _, cfg in ipairs(cfgs) do
		for _, data in ipairs(cfg) do
			if self._subMo:isBuffUnlocked(data.buffId) and not self._subMo:isBuffDefaultUnlocked(data.buffId) then
				self._isNeedReset = true

				break
			end
		end
	end

	GameUtil.SetGray(self._btnReset, not self._isNeedReset)
	self:_onUpdateBuffColUI()
end

function DemonDescendBuffShopView:_onUpdateBuffColUI()
	local list = {}
	local cfgs = DemonDescendConfig.instance:getBuffCfgs(self._activityId) or {}

	for buffType, cfg in ipairs(cfgs) do
		table.insert(list, buffType)
	end

	self._buffScrollerList:reloadData(list)
end

function DemonDescendBuffShopView:_onClearBuffCol()
	self._buffScrollerList:dispose()
end

local Words = {
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L"
}

function DemonDescendBuffShopView:_updateBuffCell(view, cell, buffType, tag)
	local cfg = DemonDescendConfig.instance:getBuffCfg(self._activityId, buffType) or {}
	local mainGo = cell.gameObject
	local txtType = goutil.findChildTextComponent(mainGo, "txtType")
	local unitScrView = goutil.findChild(mainGo, "unitScrView")
	local unitScrCell = goutil.findChild(mainGo, "unitScrCell")

	txtType.text = Words[buffType]

	if not self._unitScrollerListDic[mainGo] then
		local scrollList = ScrollerList.create(unitScrView, unitScrCell, GameUtil.handler(self._updateUnitCell, self), GameUtil.handler(self._clearUnitCell, self))

		self._unitScrollerListDic[mainGo] = self._unitScrollerListDic[mainGo]

		self._unitScrollerListDic[mainGo]:dragNotifyParent()
		self._unitScrollerListDic[mainGo]:reloadData(cfg)
	end
end

function DemonDescendBuffShopView:_clearBuffCell(cell)
	local mainGo = cell.gameObject
	local scrollList = self._unitScrollerListDic[mainGo]

	if scrollList then
		scrollList:dispose()

		self._unitScrollerListDic[mainGo] = nil
	end
end

function DemonDescendBuffShopView:_updateUnitCell(view, cell, data, tag)
	local buffType = data.buffType
	local buffId = data.buffId
	local isUnlock = self._subMo:isBuffUnlocked(buffId)
	local cost = self._subMo:getCostToUnlockBuff(buffType, buffId)
	local mainGo = cell.gameObject
	local lockCell = goutil.findChild(mainGo, "lockCell")
	local tagLock = goutil.findChild(lockCell, "tagLock")
	local txtDesc = goutil.findChildTextComponent(lockCell, "txtDesc")
	local txtCost = goutil.findChildTextComponent(lockCell, "cost/txt")
	local iconCost = goutil.findChildImageComponent(lockCell, "iconCost")
	local unLockCell = goutil.findChild(mainGo, "unLockCell")
	local txtDescUnlock = goutil.findChildTextComponent(unLockCell, "txtDesc")

	GameUtil.SetActive(tagLock, not isUnlock)

	txtDesc.text = data.desc
	txtDescUnlock.text = data.desc
	txtCost.text = string.format("*%s", cost)

	MaterialMgr.setIcon(iconCost, self._wineItem.matType, self._wineItem.matId, nil, nil)

	iconCost.color = isUnlock and Framework.ColorUtil.ParseColor("#FFFFFFFF") or Framework.ColorUtil.ParseColor("#9F9F9FFF")

	GameUtil.SetActive(lockCell, not isUnlock)
	GameUtil.SetActive(unLockCell, isUnlock)
	GameUtil.addClickHandler(mainGo, function()
		if isUnlock then
			FloatWordMgr.instance:show("已解锁")

			return
		end

		if not self._subMo:isEnoughCostToUnlockBuff(buffType, buffId) then
			FloatWordMgr.instance:show(string.format("%s不足", self._wineItem.matName))

			return
		end

		DemonDescendController.instance:sendPM_DemonDescendUnlockBuffReq(self._activityId, buffId)
	end)
end

function DemonDescendBuffShopView:_clearUnitCell(cell)
	local mainGo = cell.gameObject
	local iconCost = goutil.findChildImageComponent(mainGo, "iconCost")

	MaterialMgr.clearIcon(iconCost)
	GameUtil.rmClickHandler(mainGo)
end

function DemonDescendBuffShopView:_onClikBtnReset()
	if not self._isNeedReset then
		FloatWordMgr.instance:show("无需重置")

		return
	end

	DemonDescendController.instance:sendPM_DemonDescendResetBuffReq(self._activityId)
end

return DemonDescendBuffShopView
