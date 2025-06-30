-- chunkname: @IQIGame\\UI\\GMOrder2\\GMSubmitPanel.lua

local GMSubmitPanel = {}
local GMInputItem = require("IQIGame.UI.GMOrder2.GMInputItem")

function GMSubmitPanel.New(go)
	local o = Clone(GMSubmitPanel)

	o:Initialize(go)

	return o
end

function GMSubmitPanel:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.transform = go.transform
	self.GMInputItemList = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function GMSubmitPanel:InitComponent()
	self.btnTrue = self.btnTrue:GetComponent("Button")
	self.btnCancel = self.btnCancel:GetComponent("Button")
	self.btnMask = self.btnMask:GetComponent("Button")
	self.inputScroll = self.inputScroll:GetComponent("ScrollAreaList")

	function self.inputScroll.onRenderCell(gridCell)
		self:OnInputScrollListRenderGridCell(gridCell)
	end
end

function GMSubmitPanel:InitDelegate()
	function self.BtnTrueClickDelegate()
		self:OnBtnTrueClick()
	end

	function self.BtnCancelClickDelegate()
		self:OnBtnCancelClick()
	end
end

function GMSubmitPanel:OnDestroy()
	self:RemoveListener()

	for _, v in pairs(self.GMInputItemList) do
		v:Dispose()
	end
end

function GMSubmitPanel:AddListener()
	self.btnTrue.onClick:AddListener(self.BtnTrueClickDelegate)
	self.btnCancel.onClick:AddListener(self.BtnCancelClickDelegate)
	self.btnMask.onClick:AddListener(self.BtnCancelClickDelegate)
end

function GMSubmitPanel:RemoveListener()
	self.btnTrue.onClick:RemoveListener(self.BtnTrueClickDelegate)
	self.btnCancel.onClick:RemoveListener(self.BtnCancelClickDelegate)
	self.btnMask.onClick:RemoveListener(self.BtnCancelClickDelegate)
end

function GMSubmitPanel:OnBtnTrueClick()
	if self.gmCfg.Id == 4206 then
		self:CheckConditionState()

		return
	end

	local str = self.cmdStr

	if self.ItemData then
		str = str .. " " .. self.ItemData.Id
	end

	for i = 1, #self.GMInputItemList do
		str = str .. " "
		str = str .. self.GMInputItemList[i]:GetInputText()
	end

	GMOrder2Module.SendCMD(str)
end

function GMSubmitPanel:OnBtnCancelClick()
	self:Close()
end

function GMSubmitPanel:CheckConditionState()
	local conditonStr = self.GMInputItemList[1]:GetInputText()
	local conditionTable = string.split(conditonStr, "|")
	local result = ""

	for i = 1, #conditionTable do
		local checkResult = tostring(ConditionModule.Check(tonumber(conditionTable[i])))

		result = result .. conditionTable[i] .. ":" .. checkResult .. "\n"
	end

	NoticeModule.ShowNoticeByType(Constant.NoticeType.BoxSingleButton, result)
end

function GMSubmitPanel:OnInputScrollListRenderGridCell(gridCell)
	local data = self.InputList[gridCell.index + 1]

	if data then
		local Item = GMInputItem.New(gridCell.gameObject)
		local val = self.inputDefault[gridCell.index + 1]

		if val == "date" then
			val = getDateText2(tonumber(PlayerModule.GetServerTime()))
		elseif val == "time" then
			val = getTimeText(tonumber(PlayerModule.GetServerTime()))
		else
			val = self.inputDefault[gridCell.index + 1]
		end

		Item:Refresh(data, val)
		table.insert(self.GMInputItemList, Item)
	end
end

function GMSubmitPanel:Show(userData, ItemData)
	self.InputList = userData.InputName
	self.cmdStr = userData.Cmd
	self.ItemData = ItemData
	self.inputDefault = userData.inputDefault
	self.GMInputItemList = {}
	self.gmCfg = userData

	if self.InputList then
		self.inputScroll:Refresh(#self.InputList)
	end

	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function GMSubmitPanel:Close()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

return GMSubmitPanel
