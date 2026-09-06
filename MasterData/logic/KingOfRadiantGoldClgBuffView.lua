-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingofradiantgoldclg/view/KingOfRadiantGoldClgBuffView.lua

module("logic.extensions.kingofradiantgoldclg.view.KingOfRadiantGoldClgBuffView", package.seeall)

local KingOfRadiantGoldClgBuffView = class("KingOfRadiantGoldClgBuffView", ViewComponent)

function KingOfRadiantGoldClgBuffView:ctor()
	KingOfRadiantGoldClgBuffView.super.ctor(self)
end

function KingOfRadiantGoldClgBuffView:buildUI()
	KingOfRadiantGoldClgBuffView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnReset = self:getGo("info/btnReset")
	self._btnUpdate = self:getGo("info/btnUpdate")
	self._redBtnUpdate = self:getGo("info/btnUpdate/redpoint")
	self._txtCost = self:getTxt("info/txtCost")
	self._strTxtCost = self._txtCost.text
	self._txtEffect = self:getTxt("info/desc/txtEffect")
	self._txtNextLevel = self:getTxt("info/desc/txtNextLevel")
	self._buffCon = self:getGo("info/buff/icon/con")
	self._levelSld = self:getSlider("info/buff/levelSld")
	self._txtName = self:getTxt("info/buff/txtName")
	self._txtNumGoldBarCon = self:getTxt("goldBarCon/txtNum")
	self._iconGoldBarCon = self:getGo("goldBarCon/icon")
	self._buffView = self:getGo("buffView")
	self._buffCellList = {}

	for idx = 1, self._buffView.transform.childCount do
		local mainGo = self._buffView.transform:GetChild(idx - 1).gameObject
		local cell = {}

		cell._mainGo = mainGo
		cell._buffCon = goutil.findChild(mainGo, "icon/con")
		cell._levelSld = Framework.SliderAdapter.GetFrom(mainGo, "levelSld")
		cell._imgSelect = goutil.findChild(mainGo, "imgSelect")
		cell._txtName = goutil.findChildTextComponent(mainGo, "name/txt")
		cell._redPoint = goutil.findChild(mainGo, "redPoint")

		table.insert(self._buffCellList, cell)
	end
end

function KingOfRadiantGoldClgBuffView:bindEvents()
	KingOfRadiantGoldClgBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnUpdate, self._onClickBtnUpdate, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
end

function KingOfRadiantGoldClgBuffView:unbindEvents()
	KingOfRadiantGoldClgBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnUpdate)
	GameUtil.rmClickHandler(self._btnReset)
end

function KingOfRadiantGoldClgBuffView:onEnter()
	KingOfRadiantGoldClgBuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = KingOfRadiantGoldClgController.instance:getActivityType()

	local isInTime = KingOfRadiantGoldClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._clgMo = KingOfRadiantGoldClgController.instance:getClgMo(self._activityId)
	self._buffCfg = KingOfRadiantGoldClgConfig.instance:getBuffCfgs(self._activityId) or {}
	self._actData = KingOfRadiantGoldClgConfig.instance:getActData(self._activityId)
	self._costMatName = MaterialMgr.getMaterialsNameByCfg(self._actData and self._actData.fuwenItem)

	self.addGEvent(self, GlobalNotify.HandlePM_KingOfRadiantGoldClgInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_NotifyKingOfRadiantGoldClgFinishRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingOfRadiantGoldClgUpgradeBuffRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingOfRadiantGoldClgResetBuffRes, self._onUpdate, self)

	local matType, matId = MaterialMgr.getMatParams(self._actData.fuwenItem)

	MaterialMgr.setIcon(self._iconGoldBarCon, matType, matId, nil, nil)
	self:_onUpdate()
end

function KingOfRadiantGoldClgBuffView:onExit()
	KingOfRadiantGoldClgBuffView.super.onExit(self)
	MaterialMgr.clearIcon(self._iconGoldBarCon)
	self:_onClearBuffCol()
	self:_onClearBuffInfoCol()
end

function KingOfRadiantGoldClgBuffView:_onUpdate()
	self._curBuffId = checknumber(self._curBuffId)

	if self._curBuffId <= 0 or self._curBuffId > #self._buffCfg then
		self._curBuffId = Mathf.Clamp(self._curBuffId, Mathf.Min(1, #self._buffCfg), #self._buffCfg)

		for _, data in ipairs(self._buffCfg) do
			if self._clgMo:isCanUpdateBuff(data.buffId) then
				self._curBuffId = data.buffId

				break
			end
		end
	end

	self:_onUpdateBuffCol()
	self:_onUpdateBuffInfoCol()
end

function KingOfRadiantGoldClgBuffView:_onUpdateBuffCol()
	local length = Mathf.Max(#self._buffCfg, #self._buffCellList)

	for buffId = 1, length do
		local cell = self._buffCellList[buffId]

		if cell == nil then
			printError(string.format("配置超出，预制缺失buff( activityId:%s, buffId:%s )", self._activityId, buffId))

			break
		end

		local isNeedUpdate = buffId <= #self._buffCfg

		if isNeedUpdate then
			self:_updateBuffCell(cell, buffId)
		else
			self:_clearBuffCell(cell)
		end

		GameUtil.SetActive(cell._mainGo, isNeedUpdate)
	end
end

function KingOfRadiantGoldClgBuffView:_onClearBuffCol()
	for _, cell in pairs(self._buffCellList) do
		self:_clearBuffCell(cell)
	end
end

function KingOfRadiantGoldClgBuffView:_updateBuffCell(cell, buffId)
	local curLevel = self._clgMo:getBuffLevel(buffId)
	local maxLevel = self._clgMo:getBuffMaxLevel(buffId)
	local tempLv = Mathf.Max(curLevel, 1)
	local data = KingOfRadiantGoldClgConfig.instance:getBuffCfgData(self._activityId, buffId, tempLv)
	local isCanUpdateBuff = self._clgMo:isCanUpdateBuff(buffId)

	cell._txtName.text = data.name

	cell._levelSld:SetValue((maxLevel > 0 or nil) and curLevel / maxLevel)

	local url = GameUrl.getExpEventUrl(data.icon)

	uGuiUtil.setSpriteToImage(cell._buffCon, uGuiUtil.SpriteType.BigBg, url)
	GameUtil.SetActive(cell._imgSelect, self._curBuffId == buffId)
	GameUtil.SetActive(cell._redPoint, isCanUpdateBuff)
	GameUtil.SetGray(cell._buffCon, curLevel <= 0)
	GameUtil.addClickHandler(cell._mainGo, function()
		if self._curBuffId ~= buffId then
			self._curBuffId = buffId

			self:_onUpdate()
		end
	end, self)
end

function KingOfRadiantGoldClgBuffView:_clearBuffCell(cell)
	uGuiUtil.clearImage(cell._buffCon)
	GameUtil.rmClickHandler(cell._mainGo)
end

function KingOfRadiantGoldClgBuffView:_onUpdateBuffInfoCol()
	local buffId = self._curBuffId
	local curLevel = self._clgMo:getBuffLevel(buffId)
	local maxLevel = self._clgMo:getBuffMaxLevel(buffId)
	local tempLv = Mathf.Max(curLevel, 1)
	local nextLevel = Mathf.Min(curLevel + 1, maxLevel)
	local buffData = KingOfRadiantGoldClgConfig.instance:getBuffCfgData(self._activityId, buffId, tempLv)
	local nextBuffData = KingOfRadiantGoldClgConfig.instance:getBuffCfgData(self._activityId, buffId, nextLevel)

	self:_onClearBuffInfoCol()

	if buffData == nil then
		return
	end

	self._txtName.text = buffData.name

	local url = GameUrl.getExpEventUrl(buffData.icon)

	uGuiUtil.setSpriteToImage(self._buffCon, uGuiUtil.SpriteType.BigBg, url)
	self._levelSld:SetValue((maxLevel > 0 or nil) and curLevel / maxLevel)

	self._txtEffect.text = string.format("效果: %s", buffData.buffDesc)

	if curLevel < nextLevel then
		self._txtNextLevel.text = string.format("下一等级: %s", nextBuffData.buffDesc)
	end

	GameUtil.SetActive(self._txtNextLevel.gameObject, curLevel < maxLevel)

	if curLevel < nextLevel then
		self._txtCost.text = string.format(self._strTxtCost, self._costMatName, nextBuffData.cost)
	end

	GameUtil.SetActive(self._txtCost.gameObject, curLevel < maxLevel)

	local isCanUpdateBuff = self._clgMo:isCanUpdateBuff(buffId)
	local isCanResetBuff = self._clgMo:isCanResetBuff(buffId)

	GameUtil.SetGray(self._btnUpdate, not isCanUpdateBuff)
	GameUtil.SetGray(self._btnReset, not isCanResetBuff)
	GameUtil.SetActive(self._redBtnUpdate, isCanUpdateBuff)

	self._txtNumGoldBarCon.text = self._clgMo:getCurScore()
end

function KingOfRadiantGoldClgBuffView:_onClearBuffInfoCol()
	self._txtName.text = ""
	self._txtEffect.text = ""
	self._txtNextLevel.text = ""
	self._txtCost.text = ""

	uGuiUtil.clearImage(self._buffCon)
	GameUtil.SetGray(self._btnUpdate, false)
	GameUtil.SetGray(self._btnReset, false)
end

function KingOfRadiantGoldClgBuffView:_onClickBtnUpdate()
	local buffId = self._curBuffId
	local result = self._clgMo:getTryResultAndTipsUpdateBuff(true, buffId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	KingOfRadiantGoldClgController.instance:sendPM_KingOfRadiantGoldClgUpgradeBuffReq(self._activityId, buffId)
end

function KingOfRadiantGoldClgBuffView:_onClickBtnReset()
	local buffId = self._curBuffId
	local result = self._clgMo:getTryResultAndTipsResetBuff(true, buffId)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	KingOfRadiantGoldClgController.instance:sendPM_KingOfRadiantGoldClgResetBuffReq(self._activityId, buffId)
end

return KingOfRadiantGoldClgBuffView
