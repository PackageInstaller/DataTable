-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/view/DivineMiZongClgBuffView.lua

module("logic.extensions.divinemizongclg.view.DivineMiZongClgBuffView", package.seeall)

local DivineMiZongClgBuffView = class("DivineMiZongClgBuffView", ViewComponent)

function DivineMiZongClgBuffView:ctor()
	DivineMiZongClgBuffView.super.ctor(self)
end

function DivineMiZongClgBuffView:buildUI()
	DivineMiZongClgBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnUpdate = self:getGo("btnUpdate")

	local buffScrView = self:getGo("buffCol/scrView")
	local buffScrCell = self:getGo("buffCol/scrCell")

	self._buffScrollerList = ScrollerList.create(buffScrView, buffScrCell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
	self._descCol = self:getGo("descCol")
	self._curDescCell = self:getGo("descCol/cur")
	self._nextDescCell = self:getGo("descCol/next")
	self._maxDescCell = self:getGo("descCol/max")
	self._updateTag = self:getGo("descCol/updateTag")
	self._txtCost = self:getTxt("txtCost")
	self._txtWith = self:getTxt("txtWith")
	self._iconCost = self:getGo("iconCost")
end

function DivineMiZongClgBuffView:bindEvents()
	DivineMiZongClgBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnUpdate, self._onClickBtnUpdate, self)
end

function DivineMiZongClgBuffView:unbindEvents()
	DivineMiZongClgBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnUpdate)
end

function DivineMiZongClgBuffView:onEnter()
	DivineMiZongClgBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._clgMo = DivineMiZongClgController.instance:getClgMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_DivineMiZongClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineMiZongClgUpgradeBuffRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineMiZongClgResetBuffRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineMiZongClgGainPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineMiZongClgGainBuffItemRes, self._onUpdate, self)
	self:_onUpdate()
end

function DivineMiZongClgBuffView:onExit()
	DivineMiZongClgBuffView.super.onExit(self)
	MaterialMgr.clearIcon(self._iconCost)
	self:_onClearBuffCol()
	self:_onClearDescCol()
end

function DivineMiZongClgBuffView:_onUpdate()
	self._curBuffType = self._curBuffType or 1

	local isFit = false
	local cfgs = DivineMiZongClgConfig.instance:getBuffCfgs(self._activityId) or {}

	for buffType, cfg in ipairs(cfgs) do
		if self._curBuffType == buffType then
			isFit = true

			break
		end
	end

	if not isFit then
		local key, value = next(cfgs)

		self._curBuffType = key
	end

	self:_onUpdateBuffColUI()
	self:_onUpdateDescColUI()
end

function DivineMiZongClgBuffView:_onUpdateBuffColUI()
	local buffDataList = {}
	local cfgs = DivineMiZongClgConfig.instance:getBuffCfgs(self._activityId) or {}

	for buffType, cfg in ipairs(cfgs) do
		local level = self._clgMo:getBuffLevel(buffType)
		local data = DivineMiZongClgConfig.instance:getBuffData(self._activityId, buffType, level)

		if data then
			table.insert(buffDataList, data)
		end
	end

	self._buffScrollerList:reloadData(buffDataList)
end

function DivineMiZongClgBuffView:_onClearBuffCol()
	self._buffScrollerList:dispose()
end

function DivineMiZongClgBuffView:_updateBuffCell(view, cell, data, tag)
	local result = self._clgMo:getTryResultAndTipsUpdateBuff(false, data.buffType)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local tagSelect = goutil.findChild(mainGo, "tagSelect")
	local redPoint = goutil.findChild(mainGo, "redPoint")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local txtLevel = goutil.findChildTextComponent(mainGo, "txtLevel")
	local iconUrl = string.format("%s.png", data.iconUrl)

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, iconUrl)

	txtDesc.text = data.buffDesc
	txtLevel.text = string.format("LV.%s", data.buffLevel)

	GameUtil.SetActive(tagSelect, self._curBuffType == data.buffType)
	GameUtil.SetActive(redPoint, result == GameEnum.ResultCode.Success)
	GameUtil.addClickHandler(mainGo, function()
		if self._curBuffType == data.buffType then
			return
		end

		self._curBuffType = data.buffType

		self:_onUpdate()
	end, self)
end

function DivineMiZongClgBuffView:_clearBuffCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(mainGo)
end

function DivineMiZongClgBuffView:_onUpdateDescColUI()
	local buffType = self._curBuffType
	local curLevel = self._clgMo:getBuffLevel(buffType)
	local nextLevel = curLevel + 1
	local maxLevel = self._clgMo:getMaxBuffLevel(buffType)

	GameUtil.SetActive(self._updateTag, curLevel < maxLevel)
	self:_onClearDescCol()

	if curLevel < maxLevel then
		self:_updateDescCell(self._curDescCell, buffType, curLevel)
		self:_updateDescCell(self._nextDescCell, buffType, nextLevel)

		local cost = self._clgMo:getUpdateBuffCostNum(buffType, nextLevel)

		self._txtCost.text = string.format("%s", cost)
	else
		self:_updateDescCell(self._maxDescCell, buffType, curLevel)

		self._txtCost.text = "无"
	end

	local mat = self._clgMo:getUpgradeItem()

	MaterialMgr.setIcon(self._iconCost, mat.matType, mat.matId, nil, nil)

	self._txtWith.text = string.format("拥有：%s", self._clgMo:getUpgradeItemNum())

	local result = self._clgMo:getTryResultAndTipsUpdateBuff(false, buffType)

	GameUtil.SetGray(self._btnUpdate, result ~= GameEnum.ResultCode.Success)
end

function DivineMiZongClgBuffView:_onClearDescCol()
	self:_clearDescCell(self._curDescCell)
	self:_clearDescCell(self._nextDescCell)
	self:_clearDescCell(self._maxDescCell)
end

function DivineMiZongClgBuffView:_updateDescCell(mainGo, buffType, level)
	local data = DivineMiZongClgConfig.instance:getBuffData(self._activityId, buffType, level)
	local txtLevel = goutil.findChildTextComponent(mainGo, "txtLevel")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")

	GameUtil.SetActive(mainGo, true)

	txtLevel.text = string.format("LV.%s", data.buffLevel)
	txtDesc.text = data.buffDesc
end

function DivineMiZongClgBuffView:_clearDescCell(mainGo)
	GameUtil.SetActive(mainGo, false)
end

function DivineMiZongClgBuffView:_onClickBtnUpdate()
	local result = self._clgMo:getTryResultAndTipsUpdateBuff(true, self._curBuffType)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	DivineMiZongClgController.instance:sendPM_DivineMiZongClgUpgradeBuffReq(self._activityId, self._curBuffType)
end

return DivineMiZongClgBuffView
