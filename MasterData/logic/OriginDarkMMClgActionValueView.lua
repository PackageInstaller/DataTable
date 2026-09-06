-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmmclg/view/OriginDarkMMClgActionValueView.lua

module("logic.extensions.origindarkmmclg.view.OriginDarkMMClgActionValueView", package.seeall)

local OriginDarkMMClgActionValueView = class("OriginDarkMMClgActionValueView", ViewComponent)

function OriginDarkMMClgActionValueView:ctor()
	OriginDarkMMClgActionValueView.super.ctor(self)

	self.colorConfig = {
		[1] = "#060608",
		[2] = "#322C3F"
	}
end

function OriginDarkMMClgActionValueView:unbindEvents()
	OriginDarkMMClgActionValueView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnConfirm)
	GameUtil.rmClickHandler(self._btnCancel)
end

function OriginDarkMMClgActionValueView:bindEvents()
	OriginDarkMMClgActionValueView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnConfirm, self._onClickConfirm, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
end

function OriginDarkMMClgActionValueView:buildUI()
	OriginDarkMMClgActionValueView.super.buildUI(self)

	self._leftTableview = self:getGo("leftTable/leftTableview")
	self._leftTableCell = self:getGo("leftTable/tableCell")
	self.leftTableList = ScrollerList.create(self._leftTableview, self._leftTableCell, GameUtil.handler(self._updateLeftCell, self), GameUtil.handler(self._clearLeftCell, self))
	self._rightTable = self:getGo("rightTable")
	self.txtType = goutil.findChildTextComponent(self._rightTable, "txtType")
	self._rightTableview = self:getGo("rightTable/rightTableview")
	self._rightTableCell = self:getGo("rightTable/tableCell")
	self.rightTableList = ScrollerList.create(self._rightTableview, self._rightTableCell, GameUtil.handler(self._updateRightCell, self), GameUtil.handler(self._clearRightCell, self))
	self._txtNothing = self:getGo("rightTable/txtNothing")
	self._btnConfirm = self:getGo("btnConfirm")
	self._btnCancel = self:getGo("btnCancel")
	self._btnClose = self:getGo("btnClose")
end

function OriginDarkMMClgActionValueView:onEnter()
	OriginDarkMMClgActionValueView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
	self._maxTotalActionValue = self._fmtMo:getActionPoints()

	self:_refreshLeftTable()
	self:_refreshRightTable()

	self._backupActionValueData = clone(self._previousActionValueData)
end

function OriginDarkMMClgActionValueView:onExit()
	OriginDarkMMClgActionValueView.super.onExit(self)
	self.leftTableList:dispose()
	self.rightTableList:dispose()
end

function OriginDarkMMClgActionValueView:_refreshLeftTable()
	local list = {}
	local behaviourCfg = self._fmtMo:getBehaviourData() or {}

	for _, v in ipairs(behaviourCfg) do
		table.insert(list, v)
	end

	self.leftTableList:reloadData(list)
end

function OriginDarkMMClgActionValueView:_updateLeftCell(view, cell, data, tag)
	local go = cell.gameObject
	local image = go:GetComponent(ComponentType.Image)
	local behaviourIntroduction = goutil.findChildTextComponent(go, "behaviourIntroduction")
	local costNum = goutil.findChildTextComponent(go, "costNum")
	local colorIndex = (cell.index or 0) % #self.colorConfig + 1

	image.color = Framework.ColorUtil.ParseColor(self.colorConfig[colorIndex])
	behaviourIntroduction.text = data.desc
	costNum.text = data.cost
end

function OriginDarkMMClgActionValueView:_clearLeftCell(cell)
	local go = cell.gameObject
	local behaviourIntroduction = goutil.findChildTextComponent(go, "behaviourIntroduction")
	local costNum = goutil.findChildTextComponent(go, "costNum")

	behaviourIntroduction.text = ""
	costNum.text = ""
end

function OriginDarkMMClgActionValueView:_refreshRightTable()
	self._previousActionValueData = clone(self._fmtMo.actionValueData)
	self._previousActionValueData.currentPetList = self._previousActionValueData.currentPetList or {}

	if not self._previousActionValueData.totalActionValue then
		local actionPoints = 0

		self.txtType.text = langPara("当前剩余总行动值：%d", self._previousActionValueData.totalActionValue)

		local list = {}
		local formationMo = self._fmtMo:getCurFormation()
		local pets = formationMo:getHasPets() or {}
		local currentPetMap = {}

		for _, petId in ipairs(pets) do
			currentPetMap[petId] = true
		end

		local removedActionValue = 0

		for petId, actionValue in pairs(self._previousActionValueData.currentPetList) do
			if not currentPetMap[petId] then
				removedActionValue = removedActionValue + (tonumber(actionValue) or 0)
				self._previousActionValueData.currentPetList[petId] = nil
			end
		end

		if removedActionValue > 0 then
			self._previousActionValueData.totalActionValue = self._previousActionValueData.totalActionValue + removedActionValue

			self._fmtMo:saveActionValueData(self._previousActionValueData)

			self._backupActionValueData = clone(self._previousActionValueData)
			actionPoints = self._previousActionValueData.totalActionValue
			self.txtType.text = langPara("当前剩余总行动值：%d", self._previousActionValueData.totalActionValue)
		end

		GameUtil.SetActive(self._txtNothing, #pets == 0)

		for _, petId in ipairs(pets) do
			local var_10_1 = {
				petId = petId
			}

			var_10_1.currentActionValue = self._previousActionValueData.currentPetList[petId] or 0

			table.insert(list, var_10_1)
		end

		self.rightTableList:reloadData(list)
	end
end

function OriginDarkMMClgActionValueView:_updateRightCell(view, cell, data, tag)
	local petMo = self._fmtMo:getPetMoById(data.petId)
	local go = cell.gameObject
	local headIcon = goutil.findChild(go, "head/headIcon")
	local actionValue = goutil.findChild(go, "actionValue")
	local txt = goutil.findChildTextComponent(actionValue, "txt")
	local batchBuyRoot = goutil.findChild(go, "actionValue/batchBuyRoot")
	local iptItem = Framework.InputFieldAdapter.GetFrom(batchBuyRoot, "IptItem")
	local btnMs = goutil.findChild(batchBuyRoot, "Marks/BtnMs")
	local btnAdd = goutil.findChild(batchBuyRoot, "Marks/BtnAdd")
	local btnM10 = goutil.findChild(batchBuyRoot, "Marks/BtnM10")
	local btnA10 = goutil.findChild(batchBuyRoot, "Marks/BtnA10")

	if not self._previousActionValueData.currentPetList then
		if not self._previousActionValueData.currentPetList[data.petId] then
			local currentActionValue = 0

			local function getCurrentInputValue()
				return tonumber(iptItem:GetText()) or currentActionValue
			end

			GameUtil.rmClickHandler(btnMs)
			GameUtil.rmClickHandler(btnAdd)
			GameUtil.rmClickHandler(btnM10)
			GameUtil.rmClickHandler(btnA10)
			iptItem:RemoveOnValueChanged()

			txt.text = langPara("行动值：%d/%d", currentActionValue, self._maxTotalActionValue)

			local proxy = MaterialMgr.setCellByMo(petMo, headIcon)

			if proxy and proxy.binder then
				proxy.binder:setCallBack(function()
					CommonTipsMgr.instance:showPetTips(petMo)
				end)
			end

			Framework.TransformUtil.SetLocalScale(headIcon.transform, 0.75, 0.75, 1)
			iptItem:SetText(tostring(currentActionValue))
			GameUtil.addClickHandler(btnMs, function()
				iptItem:SetText(tostring(getCurrentInputValue() - 1))
			end, self)
			GameUtil.addClickHandler(btnAdd, function()
				iptItem:SetText(tostring(getCurrentInputValue() + 1))
			end, self)
			GameUtil.addClickHandler(btnM10, function()
				iptItem:SetText(tostring(getCurrentInputValue() - 10))
			end, self)
			GameUtil.addClickHandler(btnA10, function()
				iptItem:SetText(tostring(getCurrentInputValue() + 10))
			end, self)
			iptItem:AddOnValueChanged(function()
				self:_onActionValueChanged(data.petId, tonumber(iptItem:GetText()) or 0, iptItem, txt)
			end, self)
		end
	end
end

function OriginDarkMMClgActionValueView:_onActionValueChanged(petId, changeNum, iptItem, txt)
	if self._isUpdating then
		return
	end

	self._isUpdating = true
	changeNum = math.floor(tonumber(changeNum) or 0)

	if not self._previousActionValueData.currentPetList[petId] then
		local currentActionValue = 0

		if not self._previousActionValueData.totalActionValue then
			local totalActionValue = 0
			local maxAllowedValue = currentActionValue + totalActionValue

			if changeNum < 0 then
				changeNum = 0
			elseif maxAllowedValue < changeNum then
				changeNum = maxAllowedValue
			end

			iptItem:SetText(tostring(changeNum))

			txt.text = langPara("行动值：%d/%d", changeNum, self._maxTotalActionValue)
			self._isUpdating = false

			local delta = changeNum - currentActionValue

			if delta == 0 then
				return
			end

			local nextTotalActionValue = totalActionValue - delta

			self._previousActionValueData.currentPetList[petId] = changeNum
			self._previousActionValueData.totalActionValue = nextTotalActionValue
			self.txtType.text = langPara("当前剩余总行动值：%d", nextTotalActionValue)
		end
	end
end

function OriginDarkMMClgActionValueView:_clearRightCell(cell)
	local go = cell.gameObject
	local headIcon = goutil.findChild(go, "head/headIcon")
	local batchBuyRoot = goutil.findChild(go, "actionValue/batchBuyRoot")
	local iptItem = Framework.InputFieldAdapter.GetFrom(batchBuyRoot, "IptItem")
	local btnMs = goutil.findChild(batchBuyRoot, "Marks/BtnMs")
	local btnAdd = goutil.findChild(batchBuyRoot, "Marks/BtnAdd")
	local btnM10 = goutil.findChild(batchBuyRoot, "Marks/BtnM10")
	local btnA10 = goutil.findChild(batchBuyRoot, "Marks/BtnA10")

	GameUtil.rmClickHandler(btnMs)
	GameUtil.rmClickHandler(btnAdd)
	GameUtil.rmClickHandler(btnM10)
	GameUtil.rmClickHandler(btnA10)
	iptItem:RemoveOnValueChanged()
	MaterialMgr.resetAll(headIcon)
end

function OriginDarkMMClgActionValueView:_hasZeroActionValuePet()
	local formationMo = self._fmtMo:getCurFormation()
	local pets = formationMo and formationMo:getHasPets() or {}

	if not self._previousActionValueData.currentPetList then
		local currentPetList = {}

		for _, petId in ipairs(pets) do
			if checknumber(currentPetList[petId]) <= 0 then
				return true
			end
		end

		return false
	end
end

function OriginDarkMMClgActionValueView:_confirmActionValueChange()
	self._backupActionValueData = clone(self._previousActionValueData)

	self._fmtMo:saveActionValueData(self._previousActionValueData)
	TipsFacade.instance:openCommonTips(lang("行动值已更新"))
	self:_refreshRightTable()
	self:close()
end

function OriginDarkMMClgActionValueView:_onClickConfirm()
	if not self:_hasZeroActionValuePet() then
		self:_confirmActionValueChange()

		return
	end

	TipsFacade.instance:openPopupWindowNoCancelWithTogByDayKey(lang("提示"), lang("尚有精灵未分配行动值，战斗中将无法行动"), GameUtil.handler(self._confirmActionValueChange, self), nil, OriginDarkMMClgModel.instance:getZeroActionValueConfirmKey(), UnityEngine.TextAnchor.MiddleCenter)
end

function OriginDarkMMClgActionValueView:_onClickCancel()
	self._fmtMo.actionValueData = clone(self._backupActionValueData)

	TipsFacade.instance:openCommonTips(lang("行动值已恢复"))
	self:close()
end

return OriginDarkMMClgActionValueView
