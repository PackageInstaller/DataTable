-- chunkname: @IQIGame\\UI\\UserInfo\\AchievementShowView.lua

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local m = {
	zoomRatio = 0.5
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.achievementItemPool = UIViewObjectPool.New(self.achieveImgPrefab, self.displayItemContent.transform)

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(userPlayer)
	self.achievementItemPool:ForItems(function(item)
		LuaUtility.SetGameObjectShow(item, false)
	end)

	local displayList = userPlayer.achieveShow

	for i = 1, #displayList do
		local achievementItem = self.achievementItemPool:GetFree(function(item)
			return not item.activeSelf
		end)

		achievementItem.transform.localScale = Vector3.New(1 * self.zoomRatio, 1 * self.zoomRatio, 1 * self.zoomRatio)

		LuaUtility.SetAnchoredPositionWithRectTransform(achievementItem:GetComponent("RectTransform"), displayList[i].x * self.zoomRatio, displayList[i].y * self.zoomRatio)

		local data = CfgUtil.GetItemCfgDataWithID(displayList[i].cid)

		LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(data.BigIcon), achievementItem:GetComponent("Image"), function()
			LuaUtility.SetImageNativeSizeWithGameObject(achievementItem)
		end)
		LuaUtility.SetGameObjectShow(achievementItem, true)
	end
end

function m:Show(userPlayer)
	self:SetData(userPlayer)
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
