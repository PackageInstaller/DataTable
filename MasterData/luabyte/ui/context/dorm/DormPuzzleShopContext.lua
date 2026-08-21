local DormPuzzleShopContext = BaseClass("DormPuzzleShopContext", BaseContext)
local M = DormPuzzleShopContext
local tSort = table.sort
local tInsert = table.insert

function M:Init()
end

function M:Open(closeCallback)
    self.closeCallback = closeCallback
    self.mainActivityId = DormPuzzleActivityDataMgr:GetInstance().activityId
    local relationIds = ConfigHelper.GetCfgPropByLua("activity", self.mainActivityId, "relationId")
    self._activityId = relationIds[1]
    self.activityShop = ConfigHelper.GetCfgsByLua("activityShop", {activityId=self._activityId})
    tSort(self.activityShop, self._SortData)
    ActivityDataMgr:GetInstance():GetActivityRoleDatasAsyn(self._activityId, Bind(self, self._OnLoadTaskCallBack))
end

function M:_OnLoadTaskCallBack(cRoleActivitys)
    self.shopData = {}
    for _, activityShop in pairs(self.activityShop) do
        local cRoleActivity = self:_GetCRoleActivitys(cRoleActivitys, activityShop.id)
        local shopData = {}
        tInsert(self.shopData, shopData)
        shopData.activityShop = activityShop
        if cRoleActivity then
            shopData.buyNum = cRoleActivity.Value0
            shopData.canBuyNum = activityShop.times - cRoleActivity.Value0
        else
            shopData.buyNum = 0
            shopData.canBuyNum = activityShop.times
        end
        if shopData.canBuyNum <= 0 then
            shopData.sortIndex = 0
        else
            shopData.sortIndex = 1
        end
    end
    tSort(self.shopData, self.SortShopData)
    if not UIManager:GetInstance():IsShow(self.uiName) then
        self:_Show(self.shopData)
    else
        self:GetCtrl():RefreshShopItem(self.shopData)
    end
end

function M.SortShopData(data1, data2)
    if data1.sortIndex ~= data2.sortIndex then
        return data1.sortIndex > data2.sortIndex
    end
    return data1.activityShop.id < data2.activityShop.id
end

function M:_GetCRoleActivitys(cRoleActivitys, subActivityId)
    if not cRoleActivitys or #cRoleActivitys <= 0 then
        return
    end
    for _, cRoleActivity in pairs(cRoleActivitys) do
        if cRoleActivity.SubActivityId == subActivityId then
            return cRoleActivity
        end
    end
end

function M:GetConstId()
    local activityCopys = ConfigHelper.GetCfgsByLua("activityRoomFlip", {activityId=self.mainActivityId})
    if #activityCopys <= 0 then
        Logger.LogError("配置表错误")
    end
    return activityCopys[1].activityItem
end

function M:GetActivityId()
    return self._activityId or 0
end

function M:RefData()
    ActivityDataMgr:GetInstance():GetActivityRoleDatasAsyn(self._activityId, Bind(self, self._OnLoadTaskCallBack))
end

function M._SortData(data1, data2)
    return data1.order < data2.order
end

function M:OnClose()
    M.super.OnClose(self)
end

return DormPuzzleShopContext