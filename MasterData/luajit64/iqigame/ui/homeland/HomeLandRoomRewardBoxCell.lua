-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandRoomRewardBoxCell.lua

local HomeLandRoomRewardBoxCell = {}

function HomeLandRoomRewardBoxCell.New(go, root)
	local o = Clone(HomeLandRoomRewardBoxCell)

	o:Initialize(go, root)

	return o
end

function HomeLandRoomRewardBoxCell:Initialize(go, root)
	self.goView = go

	LuaCodeInterface.BindOutlet(self.goView, self)

	function self.DelegateOnClickGoView()
		self:OnClickBtnGet()
	end

	AssetUtil.LoadImage(self, HomeLandRoomUIApi:GetString("RewardBoxPath", false), self.goImgOpen:GetComponent("Image"))
	AssetUtil.LoadImage(self, HomeLandRoomUIApi:GetString("RewardBoxPath", true), self.goImgClose:GetComponent("Image"))
	self.goEffectParent:SetActive(false)

	local orderComp = self.goEffectParent:GetComponent("SortedComponentOrder")
	local canvas = root.UIController:GetComponent("Canvas")

	orderComp.UIRootCanvas = canvas

	self:RefreshRedPoint(false)
	self.goView:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGoView)
end

function HomeLandRoomRewardBoxCell:RefreshState(state)
	self.goImgOpen:SetActive(false)
	self.goImgClose:SetActive(false)
	self.goEffectParent:SetActive(false)

	self.state = state

	if state == 1 then
		self.goImgClose:SetActive(true)
	elseif state == 2 then
		self.goImgClose:SetActive(true)
		self.goEffectParent:SetActive(true)
	elseif state == 3 then
		self.goImgOpen:SetActive(true)
	end
end

function HomeLandRoomRewardBoxCell:RefreshRedPoint(top)
	self.RedPoint:SetActive(top)
end

function HomeLandRoomRewardBoxCell:OnClickBtnGet()
	if self.clickCallBack then
		self.clickCallBack(self)
	end
end

function HomeLandRoomRewardBoxCell:OnDestroy()
	AssetUtil.UnloadAsset(self)

	self.clickCallBack = nil

	self.goView:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGoView)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return HomeLandRoomRewardBoxCell
