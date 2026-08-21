--- 共用组件
local ChooseListCtrl = BaseClass("ChooseListCtrl",UIBaseComponent)
local M = ChooseListCtrl 

function M:__init()
    --構造函數中
    local toggle = nil 
    self._allToggles = {}
    self._ontoggleChangeHandler = Bind(self,self.OnToggleChange)
    --由於不確定數量，用一個較大的數，判空
    for i = 1 , 10 do 
        toggle = self._view["Toggle"..i]
        if not IsNull(toggle) then 
            toggle.onValueChanged:AddListener(self._ontoggleChangeHandler)
            table.insert(self._allToggles,toggle)
        end
    end
end

function M:OnDestroy()
    if self._allToggles then 
        for index, toggle in ipairs(self._allToggles) do
            if not IsNull(toggle) then 
                toggle.onValueChanged:RemoveListener(self._ontoggleChangeHandler)
            end
        end
    end
    M.super.OnDestroy(self)
end

function M:InitBtnInfo(funTab,onIdx)
    self._funTabCallbcks = funTab 
    for i = 1, #funTab do
        -- self._view["Toggle"..i].onValueChanged:AddListener(funTab[i])
        self._view["Toggle"..i]:SetIsOn(i==onIdx)
    end
end

function M:OnToggleChange(isOn)
    if isOn then 
        --，由於其父對象有toggleGroup，檢測所有的items的開關，然後給回調
        for index, toggle in ipairs(self._allToggles) do
            if toggle:GetActive() and toggle:GetIsOn() then 
                if self._funTabCallbcks[index] then 
                    self._funTabCallbcks[index](index,true)
                end
            end
        end
    end
end


--check是否顯示ITEM
function M:CheckDisplay(heroId)
    local geneArr = ConfigHelper.GetCfgsByLua("heroAi",{heroId = heroId})
    --并不是每個英雄都有基因，填表的有才有
    self._view["Toggle2"]:SetActive(geneArr and #geneArr > 0 )
end


return ChooseListCtrl