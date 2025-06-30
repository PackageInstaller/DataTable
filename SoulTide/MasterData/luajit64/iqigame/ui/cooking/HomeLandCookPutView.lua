-- chunkname: @IQIGame\\UI\\Cooking\\HomeLandCookPutView.lua

local HomeLandCookPutView = {}
local HomeLandCookPutItemCell = require("IQIGame.UI.Cooking.HomeLandCookPutItemCell")
local CookReadyView = require("IQIGame.UI.Cooking.CookReadyView")
local CookNowView = require("IQIGame.UI.Cooking.CookNowView")
local CookFinishView = require("IQIGame.UI.Cooking.CookFinishView")
local HomeLandCookPanView = require("IQIGame.UI.Cooking.HomeLandCookPanView")

function HomeLandCookPutView.__New(ui)
	local o = Clone(HomeLandCookPutView)

	o:InitView(ui)

	return o
end

function HomeLandCookPutView:InitView(ui)
	self.goView = ui

	self.goView:SetActive(false)
	LuaCodeInterface.BindOutlet(self.goView, self)

	self.cookReadyView = CookReadyView.New(self.Ready, self)
	self.cookNowView = CookNowView.New(self.Now, self)
	self.cookFinishView = CookFinishView.New(self.Finish, self)
	self.cookPanView = HomeLandCookPanView.New(self.CookPan)
	self.cookingPutItems = {}

	for i = 1, 4 do
		local putItem = HomeLandCookPutItemCell.__New(self["Pos" .. i], i)

		function putItem.removeItemCallBack(index, itemID)
			self:RemovePutItem(index, itemID)
		end

		self.cookingPutItems[i] = putItem
	end
end

function HomeLandCookPutView:AddEventListener()
	return
end

function HomeLandCookPutView:RemoveEventListener()
	return
end

function HomeLandCookPutView:RemovePutItem(index, itemCid)
	self.queueData:RemoveItem(index)
	self:UpdatePutItemCell()
end

function HomeLandCookPutView:GetPutInNumByCid(cid)
	local num = 0

	if self.queueData.status == 0 or self.queueData.status == nil then
		for i = 1, #self.queueData.items do
			if self.queueData.items[i] == cid then
				num = num + 1
			end
		end
	end

	return num
end

function HomeLandCookPutView:UpdateView(queueData, emptyQueueNum, cfgBuildingID)
	if queueData == nil then
		return
	end

	self.cookFinishView:Close()
	self.cookNowView:Close()
	self.cookReadyView:Close()

	self.cfgBuildingID = cfgBuildingID
	self.emptyQueueNum = emptyQueueNum
	self.queueData = queueData

	self.cookPanView:UpdateSate(self.queueData)
	self.Item:SetActive(false)

	self.isCanPut = false

	if self.queueData.unlock then
		if self.queueData.status == 0 then
			self.isCanPut = true

			self.Item:SetActive(false)
			self.cookReadyView:Open()
		elseif self.queueData.status == 1 then
			self.Item:SetActive(true)
			self.cookNowView:Open()
		elseif self.queueData.status == 2 then
			self.cookFinishView:Open()
		end
	end

	self:UpdatePutItemCell()
end

function HomeLandCookPutView:UpdatePutItemCell()
	for i = 1, #self.cookingPutItems do
		local putItemCell = self.cookingPutItems[i]
		local itemID = self.queueData.items[i]

		putItemCell:UpdateItem(itemID, self.isCanPut)
	end

	self.cookReadyView:UpDateText(GetFormatTime(0))
	self.cookPanView:ShowRewardIcon(nil)

	if #self.queueData.items >= 4 then
		local menuData = CookingModule.GetMenuDataByID(self.queueData.cid)

		if menuData then
			self.cookNowView.getItemStr = menuData.cfgInfo.CookName

			self.cookReadyView:UpDateText(GetFormatTime(menuData.cfgInfo.CookTimes))
			self.cookPanView:ShowRewardIcon(menuData)
		end
	end
end

function HomeLandCookPutView:OnOpen()
	self:AddEventListener()
	self.goView:SetActive(true)
end

function HomeLandCookPutView:OnClose()
	self:RemoveEventListener()
	self.goView:SetActive(false)
end

function HomeLandCookPutView:OnDestroy()
	for i, v in pairs(self.cookingPutItems) do
		v:Dispose()
	end

	if self.timerCD then
		self.timerCD:Stop()
	end

	self.timerCD = nil

	AssetUtil.UnloadAsset(self)
	self.cookNowView:Dispose()
	self.cookReadyView:Dispose()
	self.cookFinishView:Dispose()
	self.cookPanView:Dispose()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

function HomeLandCookPutView:OnBtnClean()
	self.queueData:CleanItem()
	self:UpdatePutItemCell()
end

return HomeLandCookPutView
