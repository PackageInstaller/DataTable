--- 共用组件
local RoleListCtrl = BaseClass("RoleListCtrl", UIBaseComponent)
local M = RoleListCtrl
local UIHeroItemClassCtrl = require("UI.Ctrl.RoleDevelop.UIHeroItemClassCtrl")
local UIHeroItemClassView = require("UI.View.RoleDevelop.UIHeroItemClassView")
local tInsert = table.insert

function M:__init()
    self._view.btnOpen:onClick(Bind(self, self.OnClickProfessionBtn))
    self._view.btnClose:onClick(Bind(self, self._OnBtnCloseClick))
    self.grid1 = self._view.grid1
    self.grid1:Init(UIHeroItemClassCtrl, UIHeroItemClassView)
    self.grid2 = self._view.grid2
    self.grid2:Init(UIHeroItemClassCtrl, UIHeroItemClassView)
    self._view.tabList:Init(0, Bind(self, self._OnClickTab))
    self.buttonStateChangeCallback = nil
end

function M:OnEnable()
    self.state = 1
    self._view.tf1:SetActive(true)
    self._view.tf2:SetActive(false)
    
end

function M:OnClickProfessionBtn()
    self.state = 2
    if self.buttonStateChangeCallback then 
        self.buttonStateChangeCallback(self.state)
    end
    self:RefHeroList(self.heroDatas)
end

function M:_OnBtnCloseClick()
    self.state = 1
    if self.buttonStateChangeCallback then 
        self.buttonStateChangeCallback(self.state)
    end
    self:RefHeroList(self.heroDatas)
end

--刷新英雄列表
function M:RefHeroList(heroDatas)
    self.heroDatas = heroDatas
    self._view.tf1:SetActive(self.state == 1)
    self._view.tf2:SetActive(self.state == 2)
    self:SetDataList(heroDatas)
end

function M:SetDataList(heroDatas)
    if self.state == 1 then
        self.grid1:SetDataList(heroDatas)
    elseif self.state == 2 then
        self.grid2:SetDataList(heroDatas)
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

return RoleListCtrl
