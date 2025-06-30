-- chunkname: @IQIGame\\UI\\Activity\\Moon\\MoonLogin\\MoonLoginView.lua

local MoonLoginView = {
	cellPool = {}
}
local MoonLoginCell = require("IQIGame.UI.Activity.Moon.MoonLogin.MoonLoginCell")

function MoonLoginView.New(view)
	local obj = Clone(MoonLoginView)

	obj:Init(view)

	return obj
end

function MoonLoginView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	local count = #ActiveModule.GetMoonTaskDatum()

	for i = 1, count do
		if i == 1 then
			self.cellPool[i] = MoonLoginCell.New(self.goCell)
		else
			local go = UnityEngine.Object.Instantiate(self.goCell)

			go.transform:SetParent(self.goCell.transform.parent, false)

			self.cellPool[i] = MoonLoginCell.New(go)
		end
	end

	self.goTitle1:GetComponent("Text").text = ActivityUIApi:GetString("moonLogin_title1")
	self.goTitle2:GetComponent("Text").text = ActivityUIApi:GetString("moonLogin_title2")
	self.goTitle3:GetComponent("Text").text = ActivityUIApi:GetString("moonLogin_title3")
	self.goDesc1:GetComponent("Text").text = ActivityUIApi:GetString("moonLogin_desc1")
	self.goDesc2:GetComponent("Text").text = ActivityUIApi:GetString("moonLogin_desc2")
end

function MoonLoginView:Open()
	self.View:SetActive(true)
	self:RefreshCells()
end

function MoonLoginView:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function MoonLoginView:OnHide()
	for i, v in pairs(self.cellPool) do
		v:OnHide()
	end
end

function MoonLoginView:OnDestroy()
	for i, v in pairs(self.cellPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function MoonLoginView:OnTaskUpdate()
	self:RefreshCells()
end

function MoonLoginView:RefreshCells()
	local taskDatum = ActiveModule.GetMoonTaskDatum()

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

return MoonLoginView
