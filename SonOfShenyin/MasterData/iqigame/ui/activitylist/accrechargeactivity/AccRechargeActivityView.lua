-- chunkname: @IQIGame\\UI\\ActivityList\\AccRechargeActivity\\AccRechargeActivityView.lua

local ActivityViewBase = require("IQIGame/UI/ActivityList/ActivityViewBase")
local AccRechargeActivityViewItem = require("IQIGame/UI/ActivityList/AccRechargeActivity/AccRechargeActivityViewItem")
local m = Clone(ActivityViewBase)

function m:__Init()
	self.areaItemList = {}
	self.scrollAreaListCom = self.ScrollAreaList:GetComponent("ScrollAreaList")

	function self.scrollAreaListCom.onRenderCell(cell)
		self:__OnRenderListItem(cell)
	end
end

function m:__OnRenderListItem(itemCell)
	local insID = itemCell.gameObject:GetInstanceID()
	local item = self.areaItemList[insID]

	if item == nil then
		item = AccRechargeActivityViewItem.New(itemCell.gameObject)
		self.areaItemList[insID] = item
	end

	local index = itemCell.index + 1

	item:Show(self.dataList[index])
end

function m:__SetData(activityListCfg)
	self.activityListCfg = activityListCfg

	local activityCid = self.activityListCfg.ActivityID[1]
	local activityPOD = ActivityModule.GetActivityPodByID(activityCid)

	self.ActivityTitle:GetComponent("Text").text = self.activityListCfg.Name
	self.DescText:GetComponent("Text").text = self.activityListCfg.Desc
	self.TotalRechargeNum:GetComponent("Text").text = activityPOD.activityRecharge.totalRecharge
	self.dataList = {}

	ForPairs(CfgActivityChargeTable, function(_cid, _cfg)
		if _cfg.Activityid ~= activityCid then
			return
		end

		table.insert(self.dataList, _cfg)
	end)
	table.sort(self.dataList, function(a, b)
		return a.RechargeLevel < b.RechargeLevel
	end)
	self.scrollAreaListCom:Refresh(#self.dataList)
end

function m:__AddListeners()
	EventUtil.AddEventListener(self, EventID.OnActivityRechargeDataChange, self.__OnDataChange)
end

function m:__RemoveListeners()
	EventUtil.ClearEventListener(self)
end

function m:__OnDataChange()
	self:__SetData(self.activityListCfg)
end

function m:__Dispose()
	ForPairs(self.areaItemList, function(_, _itemCell)
		_itemCell:Dispose()
	end)

	self.activityListCfg = nil
	self.dataList = nil
	self.scrollAreaListCom.onRenderCell = nil
	self.scrollAreaListCom = nil
end

return m
