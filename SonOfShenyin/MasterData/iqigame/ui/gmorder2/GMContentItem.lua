-- chunkname: @IQIGame\\UI\\GMOrder2\\GMContentItem.lua

local GMContentItem = {}

function GMContentItem.New(go)
	local o = Clone(GMContentItem)

	o:Initialize(go)

	return o
end

function GMContentItem:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.transform = go.transform

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function GMContentItem:InitComponent()
	self.btnAdd = self.btnAdd:GetComponent("Button")
	self.imgItem = self.imgItem:GetComponent("Image")
	self.numSlider = self.numSlider:GetComponent("Slider")

	LuaUtility.SetGameObjectShow(self.imgItem.gameObject, false)
end

function GMContentItem:InitDelegate()
	function self.OnClickDelegate()
		self:_OnClick()
	end

	function self.onNumSliderValueChangeDelegate(value)
		self:_OnNumSliderValueChange(value)
	end

	function self.delegateOnClickButtonAddLimit()
		self:OnClickButtonAddLimit()
	end

	function self.delegateOnClickButtonDevLimit()
		self:OnClickButtonDevLimit()
	end
end

function GMContentItem:OnDestroy()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function GMContentItem:AddListener()
	self.btnAdd.onClick:AddListener(self.OnClickDelegate)
	self.buttonAddLimit:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonAddLimit)
	self.buttonDevLimit:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonDevLimit)
	self.numSlider.onValueChanged:AddListener(self.onNumSliderValueChangeDelegate)
end

function GMContentItem:RemoveListener()
	self.btnAdd.onClick:RemoveListener(self.OnClickDelegate)
	self.buttonAddLimit:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonAddLimit)
	self.buttonDevLimit:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonDevLimit)
	self.numSlider.onValueChanged:RemoveListener(self.onNumSliderValueChangeDelegate)
end

function GMContentItem:OnClickButtonAddLimit()
	local n = self.numSlider.maxValue * 10

	if n >= 999999 then
		return
	end

	local num = self.numSlider.value * 10

	self.numSlider.value = num
	self.num = num

	LuaUtility.SetText(self.textNum, num)

	self.numSlider.maxValue = n
	self.numSlider.minValue = -n
end

function GMContentItem:OnClickButtonDevLimit()
	local n = self.numSlider.maxValue / 10

	if n < 10 then
		return
	end

	local num = math.ceil(self.numSlider.value / 10)

	self.numSlider.value = num
	self.num = num

	LuaUtility.SetText(self.textNum, num)

	self.numSlider.maxValue = n
	self.numSlider.minValue = -n
end

function GMContentItem:_OnClick()
	local tb = {}

	tb.cfg = self.data
	tb.num = self.num

	EventDispatcher.Dispatch(EventID.GMContentClick, tb)
end

function GMContentItem:_OnNumSliderValueChange(value)
	LuaUtility.SetText(self.textNum, value)

	self.num = value
end

function GMContentItem:Refresh(Data, conditionType)
	self.data = Data
	self.numSlider.value = 1
	self.num = 1

	if Data.Id then
		UGUIUtil.SetText(self.textID, Data.Id)
	end

	if Data.Name then
		UGUIUtil.SetText(self.textName, Data.Name)
	end

	if Data.ItemTips then
		UGUIUtil.SetText(self.textDes, Data.ItemTips)
	end

	if Data.Icon and Data.Icon ~= "" then
		local path

		if conditionType == GMConditionType.ItemTable then
			path = UIGlobalApi.GetIconPath(Data.Icon)
		elseif conditionType ~= GMConditionType.PlotDupStage and conditionType ~= GMConditionType.BossStage and conditionType ~= GMConditionType.TowerStage and conditionType ~= GMConditionType.DailyDupStage and conditionType == GMConditionType.EquipDupStage then
			-- block empty
		end

		if path then
			AssetUtil.LoadImage(self, path, self.imgItem)
			LuaUtility.SetGameObjectShow(self.imgItem.gameObject, true)
		end
	else
		LuaUtility.SetGameObjectShow(self.imgItem.gameObject, false)
	end

	LuaUtility.SetGameObjectShow(self.numPanel, conditionType == GMConditionType.ItemTable or conditionType == GMConditionType.GlobalBuff)

	if conditionType == GMConditionType.GlobalBuff then
		self.numSlider.maxValue = 1
		self.numSlider.minValue = -1
	else
		self.numSlider.maxValue = 10
		self.numSlider.minValue = -10
	end
end

return GMContentItem
