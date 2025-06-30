-- chunkname: @IQIGame\\UI\\Activity\\NationalDay\\NationalDayView.lua

local NationalDayView = {
	cellPool = {}
}
local NationalDayCell = require("IQIGame.UI.Activity.NationalDay.NationalDayCell")

function NationalDayView.New(view)
	local obj = Clone(NationalDayView)

	obj:Init(view)

	return obj
end

function NationalDayView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	local count = #ActiveModule.GetNationalDayTaskDatum()

	for i = 1, count do
		if i == 1 then
			self.cellPool[i] = NationalDayCell.New(self.goCell)
		else
			local go = UnityEngine.Object.Instantiate(self.goCell)

			go.transform:SetParent(self.goCell.transform.parent, false)

			self.cellPool[i] = NationalDayCell.New(go)
		end
	end

	self.goTitle1:GetComponent("Text").text = ActivityUIApi:GetString("nationalDay_title1")
	self.goTitle2:GetComponent("Text").text = ActivityUIApi:GetString("nationalDay_title2")
	self.goTitle3:GetComponent("Text").text = ActivityUIApi:GetString("nationalDay_title3")
	self.goDesc1:GetComponent("Text").text = ActivityUIApi:GetString("nationalDay_desc1")
	self.goDesc2:GetComponent("Text").text = ActivityUIApi:GetString("nationalDay_desc2")
end

function NationalDayView:Open()
	self.View:SetActive(true)
	self:RefreshCells()
end

function NationalDayView:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function NationalDayView:OnHide()
	for i, v in pairs(self.cellPool) do
		v:OnHide()
	end
end

function NationalDayView:OnDestroy()
	for i, v in pairs(self.cellPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function NationalDayView:OnTaskUpdate()
	self:RefreshCells()
end

function NationalDayView:RefreshCells()
	local taskDatum = ActiveModule.GetNationalDayTaskDatum()

	if #taskDatum < #self.cellPool then
		return
	end

	local curIndex = 0

	for i, v in ipairs(taskDatum) do
		if v.TaskStatus == TaskModule.TaskStatus.FINISH_TASK then
			curIndex = curIndex + 1
		elseif v.CurrentNum >= v.TargetNum then
			curIndex = curIndex + 1
		end
	end

	if curIndex == 0 then
		curIndex = 1
	end

	for i, v in ipairs(self.cellPool) do
		v:Refresh(taskDatum[i], i, curIndex)
	end
end

return NationalDayView
