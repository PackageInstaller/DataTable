local GamesPopupCtrl = BaseClass("GamesPopupCtrl", BaseUICtrl)
local M = GamesPopupCtrl


function M:_SendMsg(msgName)
    EventMgr:Broadcast(msgName)
    self:Close()
end


function M:_IsPlayReward()
    self._distoryData = GamesDataMgr:GetInstance():GameDistroy(self._id) 
    if self._distoryData == nil then
        return false
    end

    if not TimeUtil.IsToday(self._distoryData.RewardTime) then
        return true
    end

    if self._distoryData.RewardCount >= 5 then
        return false
    end

    return true
end


function M:OnEnter(id, type, score)
    self._id = id
    self._type = type
    self._score = score or 0
    self:_SetUI()
    self:_Drama()
end


function M:_SetUI()
    self._view.closeText:SetActive((self._type == SmaillGamesType.GamesState.Close))
    self._view.endText:SetActive((self._type == SmaillGamesType.GamesState.End))
    local text = string.format('游戏分数：%s', tostring(self._score))
    self._view.Tips:SetText(text)

    text = self._type == SmaillGamesType.GamesState.Close and 56 or 10910	
    self._view.okText:SetText(text)

    text = self._type == SmaillGamesType.GamesState.Close and 323 or 10911		
    self._view.cancelText:SetText(text)
end


function M:_Drama()
    if self:_IsPlayReward() then
        self:_PlayRewardDrama()
        return
    end
    self:_PlayHeartenDrama()
end


function M:_PlayRewardDrama()
    Logger.Log('应该播放奖励剧情。。。。')
end


function M:_PlayHeartenDrama()
    Logger.Log('应该播放鼓励剧情。。。。。。。。')
end


function M:Init() 
    self._view.okBtn:onClick(Bind(self, self._OnClickOK))
    self._view.closeBtn:onClick(Bind(self, self._OnClickClose))
end


function M:_OnClickOK()
    local msg = self._type == SmaillGamesType.GamesState.Close and UIMessageNames.GAME_CLOSE or UIMessageNames.GAME_RESTART
    self:_SendMsg(msg)
end


function M:_OnClickClose()
    local msg = self._type == SmaillGamesType.GamesState.Close and UIMessageNames.GAME_RETURN or UIMessageNames.GAME_CLOSE
    self:_SendMsg(msg)
end


function M:OnDispose()
    if self._delayTimer then
        self._delayTimer:Stop()
    end

    self._delayTimer = nil
    self._animationTime = nil
    M.super.OnDispose(self)
end





return GamesPopupCtrl
