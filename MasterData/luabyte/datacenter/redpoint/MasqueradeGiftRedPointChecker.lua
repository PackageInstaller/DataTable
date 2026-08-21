-- 假面舞会纪念品红点
local M = BaseClass("MasqueradeGiftRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))
local ItemType = BagConst.ItemType
local MASQUERADEGIFT = "MASQUERADEGIFT"

function M:Check(id)
    if id == 0 then
        self.checkResult = self:CheckAllRedPoint()
    else
        self.checkResult = self:CheckARedPoint(id)
    end
    self.checkResult = self.checkResult and 1 or 0
end

function M:CheckAllRedPoint()
    local activityId = ActivityCopyDataMgr:GetInstance():GetActivity()
    local activityCopys = ConfigHelper.GetCfgsByLua("activityCopy", {activityId=activityId})
    if #activityCopys <= 0 then
        Logger.LogError("配置错误")
        return
    end
    local itemSubType = activityCopys[1].itemSubType
    local gifts = ConfigHelper.GetCfgsByLua("item", {type=ItemType.EIT_Show, subType=itemSubType})
    ItemDataMgr:GetInstance():GetAllItemDatas({ItemType.EIT_Show})
    for _, item in ipairs(gifts) do
        local id = item.id
        if self:CheckARedPoint(id) then
            return true
        end
    end
end

function M:CheckARedPoint(id)
    local itemNum = ItemDataMgr:GetInstance():GetItemNumById(id)
    if itemNum <= 0 then
        return false
    end
    if PlayerPrefTools.GetPlayerPrefsInt(MASQUERADEGIFT .. id, 0) == 0 then
        return true
    end
end

return M
