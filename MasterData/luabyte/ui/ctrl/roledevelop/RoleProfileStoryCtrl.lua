-- 档案 （故事）
local RoleProfileStoryCtrl = BaseClass("RoleProfileStoryCtrl", UIBaseComponent)
local M = RoleProfileStoryCtrl
local tInsert = table.insert

function M:__init()
    self._allItems = {}
    self._lastFeelingCfg = nil
end

function M:SetHeroData(heroData)
    self.heroData = heroData
    self.personalCfg = ConfigHelper.GetCfg("heroPersona", heroData:GetSkinId())
    self._view.item:SetActive(false)
    self._view.describleContainer:SetActive(false)

    for i, v in ipairs(self._allItems) do
        v:SetActive(false)
    end

    self:_RereshPanel()
end

function M:_OnClickItem(idx)
    UIContextMgr:GetInstance():Show("RoleStoryPop", self.heroData, idx, Bind(self, self._RereshPanel))
end

function M:_CheckItemState(index)
    local limitLv = self.personalCfg.storyLimit[index]
    local status = self.storyLv & (1 << limitLv)
    return status > 0
end

function M:_RereshPanel()
    self.storyLv = self.heroData:GetPersonalityStory()
    local callback
    for i = 1, #self.personalCfg.storyLimit do
        local item = self._allItems[i]
        if not item then
            item = self._view.item:Instantiate()
            tInsert(self._allItems, item)
        end

        item.gameObject.name = "item" .. i
        local state = self:_CheckItemState(i)
        local breakLv = self.heroData:GetBreakLevel()
        local isOpen = breakLv >= self.personalCfg.storyLimit[i]

        if isOpen then
            callback = Bind(self, self._OnClickItem)
        else
            callback = nil
        end
        item:SetInfo(self.personalCfg, callback, state, isOpen, i)
        item:SetSiblingIndex(i)
        item:SetActive(true)
    end
    for i = #self.personalCfg.storyLimit + 1, #self._allItems do
        self._allItems[i]:SetActive(false)
    end
end

return RoleProfileStoryCtrl
