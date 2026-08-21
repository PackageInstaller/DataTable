--人设
local RoleProfilePersonaCtrl = BaseClass("RoleProfilePersonaCtrl", UIBaseComponent)
local M = RoleProfilePersonaCtrl

function M:__init()
    self._allItems = {}
end

function M:SetHeroData(heroData)
    local heroCfg = ConfigHelper.GetCfgByLua("heroPersona", heroData:GetSkinId()) --heroData:GetHeroCfg()
    local breakLv = heroData:GetBreakLevel()
    self._view.item:SetActive(false)
    for i, item in ipairs(self._allItems) do
        item:SetActive(false)
    end
    local item = nil
    for i = 1, #heroCfg.personLimit do --personInformation
        if i < #self._allItems then
            item = self._allItems[i]
        else
            item = self._view.item:Instantiate()
            table.insert(self._allItems, item)
        end
        item:SetActive(true)
        item:SetPersonItemInfo(heroCfg, breakLv, i)
    end
end

return RoleProfilePersonaCtrl
