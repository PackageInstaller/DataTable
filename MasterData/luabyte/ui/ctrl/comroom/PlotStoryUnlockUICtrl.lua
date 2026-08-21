local M = BaseClass("PlotStoryUnlockUICtrl", BaseUICtrl)

function M:Init()
    self.m_selectData = nil
    self.m_onCallback = Bind(self, self.OnClickCallback)
    self._view.btn_play:onClick(Bind(self, self.OnClickPlay))
    self._view.btn_unlock:onClick(Bind(self, self.OnClickUnlock))
    local ctrl = require("UI.Ctrl.ComRoom.PlotStoryUnlockItemCtrl")
    local view = require("UI.View.ComRoom.PlotStoryUnlockItemView")
    self._view.looplist:Init(ctrl, view)
    self._view.looplist:SetCreateItemCallback(Bind(self, self.OnCreateItem))
end

function M:OnEnter(group)
    local function checkUnlock(tbl)
        return PlotAtlasDataMgr:GetInstance():IsUnlockStoryBook(tbl.Id)
    end
    local list = {}
    for _, v in ipairs(group) do
        local cfg = v.Config
        table.insert(list, {
            Id = cfg.id,
            Config = cfg,
            Picture = cfg.personalPicture,
            IsSelect = false,
            IsUnlock = checkUnlock,
        })
    end
    table.sort(list, function(a, b)
        local aUnlock = a:IsUnlock()
        if aUnlock == b:IsUnlock() then
            return a.Id < b.Id
        else
            return aUnlock == true
        end
    end)
    local lastData
    for _, v in ipairs(list) do
        if lastData then
            lastData.NextPic = v.Picture -- 下一张图片
            v.LastPic = lastData.Picture -- 上一张图片
        end
        lastData = v
    end
    list[1].IsSelect = true
    self:_UpdatePanel(list[1])
    self._view.looplist:SetDataList(list)
end

function M:OnDispose()
    self.m_onCallback = nil
    M.super.OnDispose(self)
end

function M:OnCreateItem(ctrl)
    ctrl:SetCallback(self.m_onCallback)
end

function M:OnClickCallback(data)
    local id = data.Config.id
    for _, v in ipairs(self._view.looplist:GetDataList()) do
        v.IsSelect = v.Config.id == id
    end
    self:_UpdatePanel(data)
    self._view.looplist:UpdateList()
end

function M:OnClickPlay(go)
    if not self.m_selectData then return end
    local groupId = self.m_selectData.Config.groupId
    StoryDataMgr:GetInstance():TriggerStoryByGroup(groupId)
end

function M:OnClickUnlock(go)
    if not self.m_selectData then return end
    local cfg = self.m_selectData.Config
    local costId, costNum = cfg.cost[1], cfg.cost[2]
    local itemNum = ItemDataMgr:GetInstance():GetItemNumById(costId)
    if itemNum < costNum then
        GameHelper.TipsById(30171) -- 消耗不足
        GameHelper.PopItem(costId, 0, self._view, function() end)
        return
    end

    local storyName = ConfigHelper.GetLocalString(cfg.storyTitle)
    local itemName = ItemHelper.GetItemNameById(costId)
    local strfmt = ConfigHelper.GetLocalString(6314) -- "是否消耗%s*%d解锁剧情#%s#?"
    GameHelper.ConfirmPopupUI(string.format(strfmt, itemName, costNum, storyName), function(ok)
        if ok then
            PlotAtlasDataMgr:GetInstance():SendUnlockBookStory({ BookStoryId = cfg.id }, function()
                self._view.looplist:UpdateList()
                self:_UpdatePanel(self.m_selectData)
            end)
        end
    end)
end

function M:_UpdatePanel(data)
    self.m_selectData = data
    self._view.img_bannerM:SetPic(data.Picture)
    self._view.uiState:SetState(data:IsUnlock() and 1 or 2)
    self._view.rotateAni.enabled = data:IsUnlock() == true
    if string.isNullOrEmpty(data.LastPic) then
        self._view.img_bannerT:SetActive(false)
    else
        self._view.img_bannerT:SetActive(true)
        self._view.img_bannerT:SetPic(data.LastPic)
    end
    if string.isNullOrEmpty(data.NextPic) then
        self._view.img_bannerB:SetActive(false)
    else
        self._view.img_bannerB:SetActive(true)
        self._view.img_bannerB:SetPic(data.NextPic)
    end
end

return M
