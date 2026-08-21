local LotteryTypeItem4 = BaseClass("LotteryTypeItem4", require("UI.Ctrl.Lottery.BaseLotteryItem"))
local M = LotteryTypeItem4

function M:_initView()

end

function M:Refresh(drawData)
    M.super.Refresh(self, drawData)
    if self._view.ssrNeedTime ~= nil then
        local num, max = self:GetSsrCountdownNumber(drawData)
        self._view.ssrNeedTime:SetText(string.format("最多<color=#FF8901>%d/%d</color>次必出SSR礼物", num, max))
    end
end

--激活
function M:SetActive(v)
    M.super.SetActive(self, v)
    if v then
        self:OnShow(v)
    else
        self._view.media:Stop()
    end
end

function M:OnShow(b)
    local cfg = self._lotteryCfg
    if cfg ~= nil and cfg.video ~= nil and #cfg.video > 0 then
        self._view.media:PlayByList(cfg.video, true, Bind(self, self.PlayVideoStart), nil)
    end
end

function M:PlayVideoStart(index)
    local luckDrawData = self._lotteryCfg
    local itemids = luckDrawData.itemIdVideo
    local targetItemId = itemids[index + 1]
    local itemData = ConfigHelper.GetCfg("item", targetItemId)
    --self._view.media:Stop()
    if itemData == nil then
        Logger.LogError("无效的ItemId:" .. targetItemId)
        return
    end
    self._view.item_name:SetText(itemData.name)
    self._view.item_icon:SetItemIcon(targetItemId)
end

return M
