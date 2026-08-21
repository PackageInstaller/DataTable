local M = BaseClass("MusicBoxCtrl",BaseUICtrl)

function M:Init()
    self._view.bg:onClick(Bind(self, self.OnClickBG))
    self._clickCallback = Bind(self, self._OnItemClick)
    self._finishCallback = nil-- Bind(self, self._OnVoiceFinish)

end

function M:OnEnter()
    self._view.cell:SetActive(false)
    
    local musicCfg = ConfigHelper.GetCfgs("music") --heroData:GetHeroCfg()
    self.allItem = {}
    for i = 1, #musicCfg do
        local item = self._view.cell:Instantiate()
        table.insert(self.allItem, item)
        item:SetVoice(musicCfg[i], self._clickCallback, i)
        item:SetActive(true)
    end
    
    local enterEvent = ConfigHelper.GetSystemParam(369)
    GameHelper.PlayAudioById(enterEvent)

end

function M:OnClickBG()
    self:Close()
end

function M:_OnItemClick(item)
    if item == nil then
        return 
    end
    if item == self._playingItem then
        
        return 
    end
    if self._playingItem then
        self._playingItem:StopVoice()
        self._playingItem:ClearCallBack()
        
        if item == self._playingItem then
            self._playingItem = nil
            return 
        end
    end
    
    item:PlayVoice(self._finishCallback)
    self._playingItem = item
end

function M:_OnVoiceFinish()
    if self._playingItem then
        self._playingItem:StopVoice()
        self._playingItem = nil
    end
    
end

function M:OnClose()
    local enterEvent = ConfigHelper.GetSystemParam(368)
    GameHelper.PlayAudioById(enterEvent)
end

return M