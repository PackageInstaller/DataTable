local RoleDevelopListCtrl = BaseClass("RoleDevelopListCtrl", UIBaseComponent)
local M = RoleDevelopListCtrl
local UIHeroItemClassCtrl = require("UI.Ctrl.RoleDevelop.UIHeroItemClassCtrl")
local UIHeroItemClassView = require("UI.View.RoleDevelop.UIHeroItemClassView")
local tInsert = table.insert

function M:__init()
    self._view.btnOpen:onClick(Bind(self, self.OnClickProfessionBtn)) -- 展示两列
    self._view.btnClose:onClick(Bind(self, self.OnBtnCloseClick)) -- 展示一列
    self.grid1 = self._view.grid1
    self.grid1:Init(UIHeroItemClassCtrl, UIHeroItemClassView)
    self.grid2 = self._view.grid2
    self.grid2:Init(UIHeroItemClassCtrl, UIHeroItemClassView)
    self._view.tabList:Init(0, Bind(self, self._OnClickTab))
end

function M:UpdateData(RoleDevelopMainCtrl)
    self.RoleDevelopMainCtrl = RoleDevelopMainCtrl
end

function M:OnEnable()
    -- 1:显示1列 2：显示两列
    self.state = self.state or 1
    self._view.tf1:SetActive(self.state == 1)
    self._view.tf2:SetActive(self.state == 2)
end

function M:OnClickProfessionBtn()
    self.state = 2
    self.RoleDevelopMainCtrl:ToggleListState(false)
    EventMgr:Broadcast(UIMessageNames.ROLE_LIST_POS, 1)
    self.RoleDevelopMainCtrl:SetMainPos(2)

    self._view.tf1:SetActive(self.state == 1)
    self._view.tf2:SetActive(self.state == 2)
    self:_OnClickTab(self.selelctIdx or 0)
end

function M:OnBtnCloseClick()
    self.RoleDevelopMainCtrl:ToggleListState(true)
    EventMgr:Broadcast(UIMessageNames.ROLE_LIST_POS, 2)
    self.RoleDevelopMainCtrl:SetMainPos(1)
    self.state = 1
    self:RefHeroList(self.heroDatas)
end

-- 刷新英雄列表
function M:RefHeroList(heroDatas, index)
    self.heroDatas = heroDatas
    self._view.tf1:SetActive(self.state == 1)
    self._view.tf2:SetActive(self.state == 2)
    self:SetDataList(heroDatas, index)
end

function M:SetDataList(heroDatas, index)
    if self.state == 1 then
        self.grid1:SetDataList(heroDatas)
        if index then
            self.grid1:SetVerticalNormalizedByIndex(index)
        end
    elseif self.state == 2 then
        self.grid2:SetDataList(heroDatas)
        if index then
            self.grid2:SetVerticalNormalizedByIndex(index)
        end
    end
end

function M:UpdateList()
    if self.state == 1 then
        self.grid1:UpdateList()
    elseif self.state == 2 then
        self.grid2:UpdateList()
    end
end

function M:RefrehItem()
    local list
    if self.state == 1 then
        list = self.grid1:GetItems()
    elseif self.state == 2 then
        list = self.grid2:GetItems()
    end

    for _, item in pairs(list or {}) do
        item:RefrehItem()
    end
end

function M:_OnClickTab(idx)
    if self.state == 1 then
        return
    end
    self.selelctIdx = idx
    if idx == 0 then
        self:SetDataList(self.heroDatas)
    else
        local teamHeroList = {}

        for _, heroData in pairs(self.heroDatas) do
            if idx == heroData.profession then
                tInsert(teamHeroList, heroData)
            end
        end

        self:SetDataList(teamHeroList)
    end
end

function M:SetRedPointState(state)
    self:RefrehItem()
end

function M:OnDestroy()
    self.RoleDevelopMainCtrl = nil
    M.super.OnDestroy(self)
end

return RoleDevelopListCtrl
