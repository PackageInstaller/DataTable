-- 语音
local RoleProfileVoiceCtrl = BaseClass("RoleProfileVoiceCtrl", UIBaseComponent)
local M = RoleProfileVoiceCtrl
local tInsert = table.insert
local tSort = table.sort

function M:__init()
    self._allItems = {}
    self._clickCallback = Bind(self, self._OnItemClick)
    self._finishCallback = Bind(self, self._OnVoiceFinish)
    self._playingItem = nil
end

function M:SetHeroData(heroData)
    self._view.item:SetActive(false)
    
    for i, v in ipairs(self._allItems) do
        v:SetActive(false)
    end
    
    local heroCfg = ConfigHelper.GetCfgByLua("heroPersona", heroData:GetSkinId()) --heroData:GetHeroCfg()
    local storyStage = heroData.story
    self._view.voiceWordGo:SetActive(false)
    local breaklv = heroData:GetBreakLevel()
    local tempVoiceLimit = {}
    
    for i = 1, #heroCfg.voiceLimit do
        local tempData = { id = i, value = heroCfg.voiceLimit[i] }
        tInsert(tempVoiceLimit, tempData)
    end
    
    tSort(tempVoiceLimit, self._Sort)
    local item = nil
    
    for i = 1, #tempVoiceLimit do
        if i <= #self._allItems then
            item = self._allItems[i]
        else
            item = self._view.item:Instantiate()
            tInsert(self._allItems, item)
        end
        
        item:SetVoice(heroCfg, tempVoiceLimit[i].id, breaklv, self._clickCallback, i)
        item:SetActive(true)
    end
end

function M._Sort(data1, data2)
    return data1.value < data2.value
end

function M:_OnItemClick(item)
    if item == nil then
        return 
    end
    
    if self._playingItem then
        self._playingItem:StopVoice()
        self._playingItem:ClearCallBack()
        
        if item == self._playingItem then
            self._view.voiceWordGo:SetActive(false)
            self._playingItem = nil
            return 
        end
    end
    
    item:PlayVoice(self._finishCallback)
    self._playingItem = item
    self._view.voiceWordGo:SetActive(true)
    self._view.voiceWords:SetText(item:GetWord())
end

function M:_OnVoiceFinish()
    if self._playingItem then
        self._playingItem:StopVoice()
        self._playingItem = nil
    end
    
    self._view.voiceWordGo:SetActive(false)
end

return RoleProfileVoiceCtrl
