-- chunkname: @IQIGame\\UI\\FloatNoticeUI.lua

local FloatNoticeUI = {
	CHECK_DURATION = 0.1,
	CheckCountdownTimer = 0,
	ObjPool = {},
	DisplayingItems = {}
}

FloatNoticeUI = Base:Extend("FloatNoticeUI", "IQIGame.Onigao.UI.FloatNoticeUI", FloatNoticeUI)

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local FloatNoticeNormalItem = require("IQIGame.UI.FloatNotice.FloatNoticeNormalItem")
local FloatNoticeGetItemItem = require("IQIGame.UI.FloatNotice.FloatNoticeGetItemItem")
local FloatNoticeMazeLimitTimeItem = require("IQIGame.UI.FloatNotice.FloatNoticeMazeLimitTimeItem")

function FloatNoticeUI:OnInit()
	self.ObjPool[Constant.Notice.FloatTypeNormal] = UIObjectPool.New(4, function()
		return FloatNoticeNormalItem.New(UnityEngine.Object.Instantiate(self.NormalPrefab))
	end, function(item)
		local v = item.View

		item:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.ObjPool[Constant.Notice.FloatTypeGetItem] = UIObjectPool.New(4, function()
		return FloatNoticeGetItemItem.New(UnityEngine.Object.Instantiate(self.GetItemPrefab))
	end, function(item)
		local v = item.View

		item:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.ObjPool[Constant.Notice.FloatTypeMazeLimitTimeChange] = UIObjectPool.New(4, function()
		return FloatNoticeMazeLimitTimeItem.New(UnityEngine.Object.Instantiate(self.MazeLimitTimePrefab))
	end, function(item)
		local v = item.View

		item:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
end

function FloatNoticeUI:GetPreloadAssetPaths()
	return nil
end

function FloatNoticeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FloatNoticeUI:OnOpen(userData)
	return
end

function FloatNoticeUI:OnClose(userData)
	for i = 1, #self.DisplayingItems do
		local item = self.DisplayingItems[i]

		self:ReleaseItem(item)
	end

	self.DisplayingItems = {}
end

function FloatNoticeUI:OnAddListeners()
	return
end

function FloatNoticeUI:OnRemoveListeners()
	return
end

function FloatNoticeUI:OnPause()
	return
end

function FloatNoticeUI:OnResume()
	return
end

function FloatNoticeUI:OnCover()
	return
end

function FloatNoticeUI:OnReveal()
	return
end

function FloatNoticeUI:OnRefocus(userData)
	return
end

function FloatNoticeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	local itemNum = #self.DisplayingItems

	for i = itemNum, 1, -1 do
		local item = self.DisplayingItems[i]

		if item.IsExpired then
			table.remove(self.DisplayingItems, i)
			self:ReleaseItem(item)
		end
	end

	itemNum = #self.DisplayingItems

	for i = 1, itemNum do
		local item = self.DisplayingItems[i]

		item:Update(elapseSeconds, realElapseSeconds)
	end

	if self.CheckCountdownTimer <= 0 then
		self.CheckCountdownTimer = FloatNoticeUI.CHECK_DURATION

		local floatNoticeData = NoticeModule.PopFloatNoticeData()

		if floatNoticeData ~= nil then
			self:AddItem(floatNoticeData.type, floatNoticeData.param)
		elseif itemNum == 0 then
			UIModule.CloseSelf(self)
		end
	else
		self.CheckCountdownTimer = self.CheckCountdownTimer - elapseSeconds
	end
end

function FloatNoticeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FloatNoticeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FloatNoticeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FloatNoticeUI:OnDestroy()
	for i = 1, #self.DisplayingItems do
		local item = self.DisplayingItems[i]

		self:ReleaseItem(item, true)
	end

	self.DisplayingItems = nil

	for i, pool in pairs(self.ObjPool) do
		pool:Dispose()
	end
end

function FloatNoticeUI:AddItem(type, param)
	local pool = self.ObjPool[type]
	local item = pool:Obtain()

	item:Reset()
	item.View:SetActive(true)
	item.View.transform:SetParent(self.Container.transform, false)
	item:Refresh(param)
	table.insert(self.DisplayingItems, item)

	local itemNum = #self.DisplayingItems

	for i = itemNum - 1, 1, -1 do
		local lItem = self.DisplayingItems[i]

		if i >= itemNum - 3 then
			lItem:FinishMoving()
			lItem:MoveUp((itemNum - i) * (item.View.transform.sizeDelta.y + 10))
		end

		if i <= itemNum - 3 then
			lItem:AboutToOutOfSight()
		end
	end
end

function FloatNoticeUI:ReleaseItem(item, isDestroy)
	item.View:SetActive(false)

	if not isDestroy then
		item.View.transform:SetParent(self.UIController.transform, false)
	end

	local pool = self.ObjPool[item.Type]

	pool:Release(item)
end

return FloatNoticeUI
