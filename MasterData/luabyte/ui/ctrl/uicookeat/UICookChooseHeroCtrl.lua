-- baoruichang
-- 餐桌选择英雄吃饭界面
-- 预制体 RestaurantChooseHero
local UICookChooseHeroCtrl = BaseClass("UICookChooseHeroCtrl", BaseUICtrl)
local M = UICookChooseHeroCtrl
local UICookItemHeroCtrl = require("UI.Ctrl.UICookEat.UICookItemHeroCtrl")
local UICookItemHeroView = require("UI.View.UICookEat.UICookItemHeroView")
local tInsert = table.insert
local tIndexof = table.indexof
local tSort = table.sort
local tRemove = table.remove

function M:Init()
    self._view.btnClose:onClick(Bind(self, self._OnCloseClick))
    self._view.btnOk:onClick(Bind(self, self._OnOkClick))
    self._view.btnCancel:onClick(Bind(self, self._OnCancelClick))
    self.grid = self._view.scrollHero
    self.grid:Init(UICookItemHeroCtrl, UICookItemHeroView)
    self.grid:SetCreateItemCallback(Bind(self, self.OnCreatHeroItem))
end

function M:OnEnter(callBack, nullNum)
    local allHeros = IHeroDataMgr:GetHerosByProfessinal(0)
    self.heroDatas = {}
    self.callBack = callBack
    -- self.nullNum = nullNum or RestaurantDataMgr:GetInstance():GetNullPosNum()
    self.nullNum = nullNum
    local system167 = ConfigHelper.GetSystemParams(167)
    for i = 0, allHeros.Count - 1 do
        local heroData = allHeros[i]
        local heroId = heroData:GetHeroId()
        local heroStudioData = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
        local tempHeroData = {}
        tempHeroData.heroId = heroId
        tempHeroData.nowEater = heroStudioData:GetEater()
        tempHeroData.maxEater = self:GetHeroMaxEater(heroId)
        tempHeroData.completion = tempHeroData.nowEater / tempHeroData.maxEater -- 饱食率 用来排序
        tempHeroData.heroBreak = heroData:GetHeroBreak()
        if tempHeroData.completion < 1 and table.arrayContains(system167, heroId) then
            tInsert(self.heroDatas, tempHeroData)
        end
    end

    -- 选中的英雄
    self.selectHeros = {}
    tSort(self.heroDatas, self.SortFun)
    self._view.tfTips:SetActive(#self.heroDatas <= 0)
    self.grid:SetDataList(self.heroDatas)
end

-- 点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M.SortFun(data1, data2)
    if data1.completion ~= data2.completion then
        return data1.completion < data2.completion
    end
    return data1.heroId < data2.heroId
end

function M:GetHeroMaxEater(heroId)
    return ConfigHelper.GetCfgPropByLua("hero", heroId, "eater")
end

function M:OnCreatHeroItem(UICookItemHeroCtrl)
    UICookItemHeroCtrl:SetSelectCallback(Bind(self, self.OnSelectHero))
end

function M:OnSelectHero(heroId)
    local clickHeroData
    for _, heroData in pairs(self.heroDatas) do
        if heroData.heroId == heroId then
            clickHeroData = heroData
            break
        end
    end
    local index = tIndexof(self.selectHeros, heroId)
    if index then
        tRemove(self.selectHeros, index)
        clickHeroData.select = nil
    else
        if #self.selectHeros >= self.nullNum then
            local removeHeroId = self.selectHeros[1]
            tRemove(self.selectHeros, 1)
            for _, heroData in pairs(self.heroDatas) do
                if heroData.heroId == removeHeroId then
                    heroData.select = nil
                    break
                end
            end
        end
        tInsert(self.selectHeros, heroId)
        clickHeroData.select = true
    end
    self.grid:UpdateList()
end

function M:_OnCloseClick()
    self:Close()
end

function M:_OnOkClick()
    if self.callBack then
        self.callBack(self.selectHeros)
    end
    self:Close()
end

function M:_OnCancelClick()
    self.selectHeros = {}
    for _, tempHeroData in pairs(self.heroDatas) do
        tempHeroData.select = nil
    end
    self.grid:UpdateList()
end

return UICookChooseHeroCtrl
