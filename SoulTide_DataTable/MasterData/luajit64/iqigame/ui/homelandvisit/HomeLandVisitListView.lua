-- chunkname: @IQIGame\\UI\\HomeLandVisit\\HomeLandVisitListView.lua

local HomeLandVisitListView = {
	homeLandVisitRenderPool = {}
}
local HomeLandVisitRender = require("IQIGame.UI.HomeLandVisit.HomeLandVisitRender")

function HomeLandVisitListView.__New(ui, rootParent)
	local o = Clone(HomeLandVisitListView)

	o:InitView(ui, rootParent)

	return o
end

function HomeLandVisitListView:InitView(ui, rootParent)
	self.rootUI = ui
	self.rootParent = rootParent

	LuaCodeInterface.BindOutlet(self.rootUI, self)

	self.scrollComponent = self.rootUI:GetComponent("ScrollAreaList")

	function self.scrollComponent.onRenderCell(cell)
		self:OnRenderVisit(cell)
	end

	function self.DelegateOnPlayerHeadFrameLoaded()
		self:OnPlayerHeadFrameLoaded()
	end
end

function HomeLandVisitListView:AddEventListener()
	EventDispatcher.AddEventListener(EventID.PlayerHeadFrameLoaded, self.DelegateOnPlayerHeadFrameLoaded)
end

function HomeLandVisitListView:RemoveEventListener()
	EventDispatcher.RemoveEventListener(EventID.PlayerHeadFrameLoaded, self.DelegateOnPlayerHeadFrameLoaded)
end

function HomeLandVisitListView:UpDateView()
	self.friendDates = FriendModule.GetFriends(Constant.FriendType.TYPE_FRIEND)

	self.scrollComponent:Refresh(#self.friendDates)

	local isShow = #self.friendDates > 0

	self.rootUI:SetActive(isShow)
	self.rootParent.EmptyView:SetActive(not isShow)
end

function HomeLandVisitListView:OnRenderVisit(cell)
	local friendData = self.friendDates[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.homeLandVisitRenderPool[instanceID]

	if renderCell == nil then
		renderCell = HomeLandVisitRender.New(cell.gameObject)
		self.homeLandVisitRenderPool[instanceID] = renderCell
	end

	renderCell:SetDate(friendData)
end

function HomeLandVisitListView:OnPlayerHeadFrameLoaded()
	local mask = self.rootUI:GetComponent(typeof(UnityEngine.UI.RectMask3D))

	mask:SetDirtyTarget()
end

function HomeLandVisitListView:Dispose()
	for i, v in pairs(self.homeLandVisitRenderPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function HomeLandVisitListView:Open()
	self.rootUI:SetActive(true)
	self:AddEventListener()
	self:UpDateView()
end

function HomeLandVisitListView:Close()
	self.rootUI:SetActive(false)
	self:RemoveEventListener()
end

return HomeLandVisitListView
