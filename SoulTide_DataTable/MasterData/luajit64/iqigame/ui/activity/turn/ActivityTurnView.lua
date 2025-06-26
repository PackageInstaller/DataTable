-- chunkname: @IQIGame\\UI\\Activity\\Turn\\ActivityTurnView.lua

local m = {
	rotData = {
		slowDownS = 0,
		currentV = 0,
		currentS = 0,
		circleDown = 3,
		v0 = 720,
		targetS = 0,
		bRot = false,
		acc = 0
	},
	OpenTipBtnHandler = {}
}

function m.New(go, mainView, eventID)
	local o = Clone(m)

	o:Initialize(go, mainView, eventID)

	return o
end

function m:Initialize(go, mainView, eventID)
	LuaCodeInterface.BindOutlet(go, self)

	self.goView = go
	self.mainView = mainView
	self.eventID = eventID
	self.btnTurn = self.goBtnTurn:GetComponent("Button")
	self.toggleRule = self.goToggleRule:GetComponent("Toggle")
	self.toggleRecord = self.goToggleRecord:GetComponent("Toggle")
	self.arrow = self.goCellRoot.transform:Find("Move")
	self.arrIcon = {}
	self.sprite5Bg = {}

	local itemRoot = self.goCellRoot.transform:Find("Panel")

	for i = 1, 16 do
		local t = itemRoot.transform:GetChild(i - 1)

		table.insert(self.arrIcon, {
			txt = t:Find("Text_01"):GetComponent("Text"),
			bg = t:Find("Image_Color"):GetComponent("Image"),
			icon = t:Find("Image_Icon"):GetComponent("Image")
		})

		if i < 6 then
			self.sprite5Bg[i] = self.arrIcon[i].bg.sprite
		end

		t.gameObject:SetActive(false)
	end

	function self.onClickBtnTurnDelegate()
		self:OnClickBtnTurn()
	end

	function self.onValueChangedDelegate_rule()
		self:OnValueChanged_rule()
	end

	function self.onValueChangedDelegate_record()
		self:OnValueChanged_record()
	end

	function self.onUpdateTurnDelegate()
		self:OnUpdateTurnData()
	end

	function self.onTurnResultDelegate()
		self:onTurnResult()
	end

	function self.delegateBtnTip()
		self:OnBtnTip()
	end

	function self.delegateUpdateOperations()
		self:OnUpdateOperations()
	end

	if not self.handle_fixedUpdate then
		self.handle_fixedUpdate = FixedUpdateBeat:CreateListener(self.FixedUpdate, self)
	end

	self.goToggleRule.transform:Find("goUp/Text_01"):GetComponent("Text").text = ActivityUIApi:GetString("turn_toggleRule")
	self.goToggleRule.transform:Find("goDown/Text_01"):GetComponent("Text").text = ActivityUIApi:GetString("turn_toggleRule")
	self.goToggleRecord.transform:Find("goUp/Text_01"):GetComponent("Text").text = ActivityUIApi:GetString("turn_toggleRecord")
	self.goToggleRecord.transform:Find("goDown/Text_01"):GetComponent("Text").text = ActivityUIApi:GetString("turn_toggleRecord")
	self.goBtnTurn.transform:Find("Text_01"):GetComponent("Text").text = ActivityUIApi:GetString("turn_btnTurn")
	self.goBtnTurn.transform:Find("Text_02"):GetComponent("Text").text = ActivityUIApi:GetString("turn_btnTurn2")
	self.goView.transform:Find("Name_Panel/Text_01"):GetComponent("Text").text = ActivityUIApi:GetString("turn_txtTitle")
	self.goView.transform:Find("Name_Panel/Text_02"):GetComponent("Text").text = ActivityUIApi:GetString("turn_txtDate")
	self.goTxtTips:GetComponent("Text").text = ActivityUIApi:GetString("turn_turnTips")
	self.txtTurnTimes = self.goTxtLeftTimes:GetComponent("Text")
	self.rtContent = self.goRecords.transform:Find("Viewport/Content").transform
end

function m:Update(elapseSeconds, realElapseSeconds)
	return
end

function m:FixedUpdate()
	self:Update_rot(self.arrow.transform, Time.fixedDeltaTime)
end

function m:SetTurnBtnAndTimes()
	local value = self:GetTurnCount()

	self.goBtnTurn:SetActive(value > 0)

	self.btnTurn.interactable = value > 0
	self.txtTurnTimes.text = ActivityUIApi:GetString("turn_remainTimes", value)
end

function m:OnUpdateTurnData()
	self.mainView.Mask:SetActive(false)

	if ActivityTurnModule.records ~= nil then
		self.coRecordAnim = coroutine.start(function()
			local length = #ActivityTurnModule.records
			local loop = length > self.rtContent.childCount
			local i = 1

			while i <= length do
				coroutine.wait(3)
				self:ScrollCell(ActivityTurnModule.records[i])

				i = i + 1

				if i == length + 1 and loop then
					i = 1
				end
			end
		end)
	end

	if ActivityTurnModule.items ~= nil then
		for i, v in pairs(self.arrIcon) do
			local id = ActivityTurnModule.items[i].id
			local count = ActivityTurnModule.items[i].count
			local path = UIGlobalApi.IconPath .. CfgItemTable[id].Icon

			AssetUtil.LoadImage(self, path, v.icon)

			v.txt.text = count
			v.bg.sprite = self.sprite5Bg[CfgItemTable[id].Quality]

			v.bg.transform.parent.gameObject:SetActive(true)

			local btn = v.icon.transform:GetComponent("Button")

			if LuaCodeInterface.GameObjIsDestroy(btn) then
				btn = v.icon.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

				local itemData = ItemData.CreateByCIDAndNumber(id, count)

				self.OpenTipBtnHandler[btn:GetInstanceID()] = function()
					ItemModule.OpenTipByData(itemData, true)
				end

				btn.onClick:AddListener(self.OpenTipBtnHandler[btn:GetInstanceID()])

				v.icon.raycastTarget = true
			end
		end
	end
end

function m:GetTurnCount()
	local count = 0
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(self.eventID)

	if operationEventDataPOD and operationEventDataPOD.dataCfgId > 0 then
		local cfgActiveTurntableGlobalData = CfgActiveTurntableGlobalTable[operationEventDataPOD.dataCfgId]
		local freeCount = 0

		if operationEventDataPOD.turntableDataPOD then
			freeCount = cfgActiveTurntableGlobalData.DailyFreeChance - operationEventDataPOD.turntableDataPOD.dailyFreeDrawCount

			if freeCount > 0 then
				count = freeCount
			end
		end

		if count == 0 then
			local haveItemNum = WarehouseModule.GetItemNumByCfgID(cfgActiveTurntableGlobalData.CostItem)

			count = math.floor(haveItemNum / cfgActiveTurntableGlobalData.CostNum)
		end
	end

	return count
end

function m:Open()
	self.goView:SetActive(true)

	self.toggleRule.interactable = true
	self.toggleRule.isOn = false
	self.toggleRecord.interactable = false
	self.toggleRecord.isOn = true

	self.goTxtRule.transform.parent.parent.gameObject:SetActive(self.toggleRule.isOn)
	self.goRecords:SetActive(self.toggleRecord.isOn)
	self:SetTurnBtnAndTimes()
	ActivityTurnModule.EnterActive()
	self:AddEventListener()
	self.mainView.Mask:SetActive(true)
	self:CreateCells()
	self:UpdateView()
end

function m:Close()
	self.goView:SetActive(false)
	self:OnHide()
	self:CreateCells()
end

function m:OnHide()
	self:RemoveEventListener()
	coroutine.stop(self.coRecordAnim)
end

function m:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.arrIcon) do
		local btn = v.icon.transform:GetComponent("Button")

		if not LuaCodeInterface.GameObjIsDestroy(btn) then
			btn.onClick:RemoveListener(self.OpenTipBtnHandler[btn:GetInstanceID()])
		end
	end

	self.mainView = nil

	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

function m:AddEventListener()
	self:RemoveEventListener()
	self.btnTurn.onClick:AddListener(self.onClickBtnTurnDelegate)
	self.toggleRule.onValueChanged:AddListener(self.onValueChangedDelegate_rule)
	self.toggleRecord.onValueChanged:AddListener(self.onValueChangedDelegate_record)
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.delegateBtnTip)
	EventDispatcher.AddEventListener(EventID.UpdateTurnEvent, self.onUpdateTurnDelegate)
	EventDispatcher.AddEventListener(EventID.TurnResultEvent, self.onTurnResultDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
	FixedUpdateBeat:AddListener(self.handle_fixedUpdate)
end

function m:RemoveEventListener()
	self.btnTurn.onClick:RemoveListener(self.onClickBtnTurnDelegate)
	self.toggleRule.onValueChanged:RemoveListener(self.onValueChangedDelegate_rule)
	self.toggleRecord.onValueChanged:RemoveListener(self.onValueChangedDelegate_record)
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.delegateBtnTip)
	EventDispatcher.RemoveEventListener(EventID.UpdateTurnEvent, self.onUpdateTurnDelegate)
	EventDispatcher.RemoveEventListener(EventID.TurnResultEvent, self.onTurnResultDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
	FixedUpdateBeat:RemoveListener(self.handle_fixedUpdate)
end

function m:OnClickBtnTurn()
	ActivityTurnModule.Draw(self.eventID)
end

function m:onTurnResult()
	self.btnTurn.interactable = false

	self:BeginDrawAnim(self.arrow.transform)
end

function m:onRotComplete()
	self:SetTurnBtnAndTimes()

	local item = ActivityTurnModule.items[ActivityTurnModule.rewardIndex]

	if item.rare >= 4 then
		UIModule.Open(Constant.UIControllerName.Activity01InfoUI, Constant.UILayer.UI, self.eventID)
	else
		local itemData = ItemData.CreateByCIDAndNumber(item.id, item.count)

		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, {
			itemData
		})
	end
end

function m:OnValueChanged_rule()
	if not self.toggleRule.isOn then
		return
	end

	self.toggleRule.interactable = false

	self.goTxtRule.transform.parent.parent.gameObject:SetActive(true)

	self.toggleRecord.interactable = true
	self.toggleRecord.isOn = false

	local txts = self.goRecords:GetComponentsInChildren(typeof(UnityEngine.UI.Text))

	for i = 0, txts.Length - 1 do
		txts[i].enabled = false
	end
end

function m:OnValueChanged_record()
	if not self.toggleRecord.isOn then
		return
	end

	self.toggleRule.interactable = true
	self.toggleRule.isOn = false

	self.goTxtRule.transform.parent.parent.gameObject:SetActive(false)

	self.toggleRecord.interactable = false

	local txts = self.goRecords:GetComponentsInChildren(typeof(UnityEngine.UI.Text))

	for i = 0, txts.Length - 1 do
		txts[i].enabled = true
	end
end

function m:BeginDrawAnim(tr)
	local index = ActivityTurnModule.rewardIndex - 1
	local data = self.rotData

	tr.rotation = Quaternion.identity
	data.bRot = true
	data.currentV = data.v0
	data.currentS = 0

	local angle = 360 * (1 + index) / 16

	data.slowDownS = angle + 360
	data.targetS = angle + 1440
	data.acc = -data.v0 * data.v0 / 2 / (360 * data.circleDown)
end

function m:Update_rot(tr, deltaTime)
	local data = self.rotData

	if data.bRot then
		tr:Rotate(Vector3.back, data.currentV * deltaTime)

		data.currentS = data.currentS + data.currentV * deltaTime

		if data.currentS >= data.slowDownS then
			data.currentV = data.currentV + data.acc * deltaTime

			if data.currentV < 0 then
				data.bRot = false

				self:onRotComplete()
			end
		end
	end
end

function m:CreateCells()
	for i = 1, self.rtContent.childCount - 1 do
		local t = self.rtContent:GetChild(self.rtContent.childCount - i)

		UnityEngine.Object.Destroy(t.gameObject)
	end

	self.goCell = self.rtContent:GetChild(0).gameObject
	self.goCell.transform:GetChild(0):GetComponent("Text").enabled = true
	self.scrollViewH = self.goRecords.transform.rect.h
	self.rtContent.anchoredPosition = Vector2.zero
	self.rtContent.sizeDelta = Vector2(0, self.scrollViewH)
	self.cellPos = self.goCell:GetComponent("RectTransform").anchoredPosition

	local rtCell = self.goCell:GetComponent("RectTransform")

	self.cellH = rtCell.sizeDelta.y
	self.cellPos.y = -self.scrollViewH / 2 + self.cellH / 2
	rtCell.anchoredPosition = self.cellPos
	self.goCell.name = "cell 0"
	self.goCell.transform:GetChild(0):GetComponent("Text").text = ""
	self.cellPos.y = self.cellPos.y + self.cellH

	local i = 0

	while self.cellPos.y - self.cellH / 2 < self.scrollViewH / 2 + self.cellH do
		local rt = UnityEngine.Object.Instantiate(self.goCell):GetComponent("RectTransform")

		rt:SetParent(self.rtContent)

		rt.localScale = Vector3.one
		rt.localPosition = Vector3.zero
		rt.anchoredPosition = self.cellPos
		rt.gameObject.name = "cell " .. i + 1

		self:SetData(rt, "")

		i = i + 1
		self.cellPos.y = self.cellPos.y + self.cellH
	end
end

function m:ScrollCell(str)
	local tf0 = self.rtContent:GetChild(0)
	local tf = self.rtContent:GetChild(self.rtContent.childCount - 1)

	tf:SetAsFirstSibling()

	self.cellPos.y = tf0:GetComponent("RectTransform").anchoredPosition.y - self.cellH
	tf:GetComponent("RectTransform").anchoredPosition = self.cellPos

	local size = self.rtContent.sizeDelta

	size.y = size.y + self.cellH * 2
	self.rtContent.sizeDelta = size
	self.rtContent.anchoredPosition = Vector2(0, self.rtContent.anchoredPosition.y + self.cellH)

	m:SetData(tf, str)
	m:Scroll(self.rtContent, self.rtContent.anchoredPosition.y + self.cellH)
end

function m:SetData(tfCell, str)
	local txt = tfCell:GetChild(0):GetComponent("Text")

	txt.text = str
end

function m:Scroll(tf, y)
	local tween = TweenPosition.Begin(tf.gameObject, 0.5, Vector2(0, y))
end

function m:OnBtnTip()
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(self.eventID)

	if operationEventDataPOD and operationEventDataPOD.dataCfgId > 0 then
		local cfgActiveTurntableGlobalData = CfgActiveTurntableGlobalTable[operationEventDataPOD.dataCfgId]

		UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, cfgActiveTurntableGlobalData.Desc)
	end
end

function m:OnUpdateOperations()
	self:UpdateView()
end

function m:UpdateView()
	if not ActiveOperationEventModule.CheckIsOpen(self.eventID) then
		return false
	end

	local operationEventPOD = ActiveOperationEventModule.GetActiveOperationData(self.eventID)

	if operationEventPOD then
		UGUIUtil.SetText(self.TextTime, ActivityUIApi:GetString("ActivityTurnTime", getCustomDateTimeText(operationEventPOD.startTime, "MonthToMinuteFormat"), getCustomDateTimeText(operationEventPOD.endTime, "MonthToMinuteFormat")))

		local cfgActiveTurntableGlobalData = CfgActiveTurntableGlobalTable[operationEventPOD.dataCfgId]

		self.goTxtRule:GetComponent("Text").text = cfgActiveTurntableGlobalData.Desc
	end
end

return m
