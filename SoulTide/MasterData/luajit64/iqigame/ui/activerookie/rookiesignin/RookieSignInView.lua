-- chunkname: @IQIGame\\UI\\ActiveRookie\\RookieSignIn\\RookieSignInView.lua

local RookieSignInView = {
	cellPool = {},
	signPool = {}
}
local RookieSignInCell = require("IQIGame.UI.ActiveRookie.RookieSignIn.RookieSignInCell")

function RookieSignInView.New(go)
	local o = Clone(RookieSignInView)

	o:Initialize(go)

	return o
end

function RookieSignInView:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.goView = go
	self.imgBar = self.goBar:GetComponent("Image")

	for i = 1, 8 do
		if i == 1 then
			self.cellPool[i] = RookieSignInCell.New(self.goCell)
		else
			local go = UnityEngine.Object.Instantiate(self.goCell)

			go.transform:SetParent(self.goCell.transform.parent, false)

			self.cellPool[i] = RookieSignInCell.New(go)
		end
	end

	self.goTip1Parent.transform:Find("Text_01"):GetComponent("Text").text = ActiveRookieUIApi:GetString("day3Tip1")
	self.goTip1Parent.transform:Find("Text_02"):GetComponent("Text").text = ActiveRookieUIApi:GetString("day3Tip2")
	self.goTip2Parent.transform:Find("Text_01"):GetComponent("Text").text = ActiveRookieUIApi:GetString("day8Tip1")
	self.goTip2Parent.transform:Find("Text_02"):GetComponent("Text").text = ActiveRookieUIApi:GetString("day8Tip2")
	self.progressList = ActiveRookieUIApi:GetString("progressList")
end

function RookieSignInView:Open()
	self.goView:SetActive(true)
	self:RefreshCells()
	self:AddListener()
end

function RookieSignInView:Close()
	self:OnHide()
	self.goView:SetActive(false)
end

function RookieSignInView:OnHide()
	self:RemoveListener()

	for i, v in pairs(self.cellPool) do
		v:OnHide()
	end
end

function RookieSignInView:OnDestroy()
	for i, v in pairs(self.cellPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

function RookieSignInView:AddListener()
	return
end

function RookieSignInView:RemoveListener()
	return
end

function RookieSignInView:OnTaskUpdate(id)
	self:RefreshCells()
end

function RookieSignInView:RefreshCells()
	local taskDatum = ActiveModule.GetSignInTaskDatum()

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

	self:RefreshBar(curIndex)
end

function RookieSignInView:RefreshBar(curIndex)
	local progress = self.progressList[curIndex]

	self.imgBar.fillAmount = progress
end

return RookieSignInView
