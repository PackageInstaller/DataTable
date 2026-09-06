-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/demondescend/view/DemonDescendBuffView.lua

module("logic.extensions.demondescend.view.DemonDescendBuffView", package.seeall)

local DemonDescendBuffView = class("DemonDescendBuffView", ViewComponent)

function DemonDescendBuffView:buildUI()
	DemonDescendBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")

	local buffScrView = self:getGo("buffCol/scrView")
	local buffScrCell = self:getGo("buffCol/scrCell")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._unitScrollerListDic = {}
end

function DemonDescendBuffView:bindEvents()
	DemonDescendBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClikBtnSure, self)
end

function DemonDescendBuffView:unbindEvents()
	DemonDescendBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function DemonDescendBuffView:onEnter()
	DemonDescendBuffView.super.onEnter(self)

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
	self._activeBuffIds = self._subMo:getActiveBuffs()

	self.addGEvent(self, GlobalNotify.HandlePM_DemonDescendInfoRes, self._onUpdate, self)
	self:_onUpdate()
end

function DemonDescendBuffView:onExit()
	DemonDescendBuffView.super.onExit(self)
	self._subMo:saveActiveBuffs(self._activeBuffIds)
	self:_onClearBuffCol()
end

function DemonDescendBuffView:_onUpdate()
	self:_onUpdateBuffColUI()
end

function DemonDescendBuffView:_getCurActiveBuffNum(buffType)
	if self._activeBuffIds[buffType] then
		local num = 0

		for buffId, isActive in pairs(self._activeBuffIds[buffType]) do
			if isActive then
				num = num + 1
			end
		end

		return num
	else
		return 0
	end
end

function DemonDescendBuffView:_getNeedActiveBuffNum()
	return self._actData.bossChallengeBuffNum
end

function DemonDescendBuffView:_setActiveBuffId(buffType, buffId, isAdd)
	if isAdd then
		self._activeBuffIds[buffType] = self._activeBuffIds[buffType] or {}
		self._activeBuffIds[buffType][buffId] = true
	else
		self._activeBuffIds[buffType][buffId] = false
	end
end

function DemonDescendBuffView:_isActiveBuff(buffType, buffId)
	return (self._activeBuffIds[buffType] or nil) and (self._activeBuffIds[buffType][buffId] or false)
end

function DemonDescendBuffView:_isMaxActive(buffType)
	local cur = self:_getCurActiveBuffNum(buffType)
	local max = self:_getNeedActiveBuffNum()

	return max <= cur
end

function DemonDescendBuffView:_onUpdateBuffColUI()
	local infosList = {}
	local cfgs = DemonDescendConfig.instance:getBuffCfgs(self._activityId) or {}

	for buffType, cfg in ipairs(cfgs) do
		local info = {}

		info.buffType = buffType
		info.dataList = {}

		table.insertto(info.dataList, cfg)
		table.sort(info.dataList, function(a, b)
			local isUnlockA = self._subMo:isBuffUnlocked(a.buffId)
			local isUnlockB = self._subMo:isBuffUnlocked(b.buffId)

			if isUnlockA ~= isUnlockB then
				return isUnlockA
			end

			return a.buffId < b.buffId
		end)
		table.insert(infosList, info)
	end

	for buffType, cfg in ipairs(cfgs) do
		local num = self:_getCurActiveBuffNum(buffType)

		if num <= 0 then
			for _, data in ipairs(cfg) do
				if not self:_isMaxActive(buffType) and self._subMo:isBuffDefaultUnlocked(data.buffId) then
					self:_setActiveBuffId(buffType, data.buffId, true)

					break
				end
			end
		end
	end

	self._buffScrollerList:reloadData(infosList)
end

function DemonDescendBuffView:_onClearBuffCol()
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

function DemonDescendBuffView:_updateBuffCell(view, cell, info, tag)
	local buffType = info.buffType
	local dataList = info.dataList
	local cur = self:_getCurActiveBuffNum(buffType)
	local need = self:_getNeedActiveBuffNum()
	local mainGo = cell.gameObject
	local txtType = goutil.findChildTextComponent(mainGo, "txtType")
	local txtNum = goutil.findChildTextComponent(mainGo, "num/txt")
	local unitScrView = goutil.findChild(mainGo, "unitScrView")
	local unitScrCell = goutil.findChild(mainGo, "unitScrCell")

	txtType.text = Words[buffType]
	txtNum.text = string.format("%s/%s", cur, need)

	if not self._unitScrollerListDic[mainGo] then
		local scrollList = ScrollerList.create(unitScrView, unitScrCell, GameUtil.handler(self._updateUnitCell, self), GameUtil.handler(self._clearUnitCell, self))

		self._unitScrollerListDic[mainGo] = self._unitScrollerListDic[mainGo]

		self._unitScrollerListDic[mainGo]:dragNotifyParent()
		self._unitScrollerListDic[mainGo]:reloadData(dataList)
	end
end

function DemonDescendBuffView:_clearBuffCell(cell)
	local mainGo = cell.gameObject
	local scrollList = self._unitScrollerListDic[mainGo]

	if scrollList then
		scrollList:dispose()

		self._unitScrollerListDic[mainGo] = nil
	end
end

function DemonDescendBuffView:_updateUnitCell(view, cell, data, tag)
	local buffType = data.buffType
	local buffId = data.buffId
	local isUnlock = self._subMo:isBuffUnlocked(buffId)
	local isActive = self:_isActiveBuff(buffType, buffId)
	local mainGo = cell.gameObject
	local tagActive = goutil.findChild(mainGo, "tagActive")
	local tagLock = goutil.findChild(mainGo, "tagLock")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	GameUtil.SetActive(tagActive, isActive)
	GameUtil.SetActive(tagLock, not isUnlock)

	txtDesc.text = data.desc

	GameUtil.addClickHandler(mainGo, function()
		if not isUnlock then
			FloatWordMgr.instance:show("未解锁")

			return
		end

		local isActive = self:_isActiveBuff(buffType, buffId)
		local isToActive = not isActive

		if isToActive and self:_isMaxActive(buffType) then
			local isSuccessDel = false

			if self._activeBuffIds[buffType] then
				local cancelBuffId = 0

				for id, _ in pairs(self._activeBuffIds[buffType]) do
					if self:_isActiveBuff(buffType, id) then
						cancelBuffId = Mathf.Max(cancelBuffId, id)
					end
				end

				if cancelBuffId > 0 then
					self:_setActiveBuffId(buffType, cancelBuffId, false)

					isSuccessDel = true
				end
			end

			if not isSuccessDel then
				FloatWordMgr.instance:show("超过可选上限")

				return
			end
		end

		self:_setActiveBuffId(buffType, buffId, isToActive)
		self._buffScrollerList:updateCellInViewByIndex(buffType - 1)
	end)
end

function DemonDescendBuffView:_clearUnitCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function DemonDescendBuffView:_onClikBtnSure()
	local need = self:_getNeedActiveBuffNum()
	local isFitCount = #self._activeBuffIds > 0
	local buffIdList = {}

	for buffType, buffIds in pairs(self._activeBuffIds) do
		local count = 0
		local unlockCount = 0

		for buffId, isActive in pairs(buffIds) do
			if isActive then
				count = count + 1

				table.insert(buffIdList, buffId)
			end

			if self._subMo:isBuffUnlocked(buffId) then
				unlockCount = unlockCount + 1
			end
		end

		local min = Mathf.Min(unlockCount, need)

		if count < min then
			isFitCount = false

			break
		end
	end

	if not isFitCount then
		FloatWordMgr.instance:show("选择的buff数量不足")

		return
	end

	self:close()
	DemonDescendController.instance:enterBossBattle(self._activityId, buffIdList, self._isTrial)
end

return DemonDescendBuffView
