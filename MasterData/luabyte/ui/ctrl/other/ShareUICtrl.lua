local M = BaseClass("ShareUICtrl", BaseUICtrl)

function M:Init()
    self.m_desc = nil
    self.m_uiState = nil
    self.m_imgPath = nil
    self.m_texture2d = nil
    self.m_isSave = false
    self._view.btn_mask:onClick(Bind(self, self.Close))
    self._view.btn_qq:onClick(Bind(self, self.OnClickQQ))
    self._view.btn_save:onClick(Bind(self, self.OnClickSave))
    self._view.btn_qzone:onClick(Bind(self, self.OnClickQZone))
    self._view.btn_wechat:onClick(Bind(self, self.OnClickWeChat))
    self._view.btn_sinaweibo:onClick(Bind(self, self.OnClickSinaWeibo))
    self._view.btn_wechatMoments:onClick(Bind(self, self.OnClickWeChatMoments))

    local msgId = Proto.MessageId.ResponseGetShareReward
    local handler = Bind(self, self.OnRsGetShareReward)
    self.m_rsGetShareReward = NetPack:RegistResponse(msgId, handler)
end

function M:OnEnter(texture, desc, uiState)
    self.m_uiState = uiState
    self.m_texture2d = texture
    self.m_imgPath = GameHelper.GetSavePicPath()
    self.m_desc = ConfigHelper.GetLocalString(desc or 0)
    self._view.img_picture:SetTexture(texture)
end

function M:OnClose()
    local refMsg = Proto.MessageId.ResponseGetShareReward
    NetPack:UnRegistResponse(refMsg, self.m_rsGetShareReward)
    self.m_desc = nil
    self.m_isSave = nil
    self.m_uiState = nil
    self.m_imgPath = nil
    self.m_texture2d = nil
    self.m_rsGetShareReward = nil
end

function M:OnClickSave(go)
    if GameHelper.SaveScreenshot(self.m_texture2d) then
        GameHelper.Tips("图片保存成功！")
        self:Close()
    end
end

function M:OnClickWeChat(go)
    -- if not self.m_isSave then
    --     self.m_isSave = GameHelper.SaveScreenshot(self.m_texture2d)
    -- end
    -- ShareSDKMgr:ShareWeChat(self.m_desc, self.m_imgPath)
    ShareSDKMgr:ScreenshotAndroid(self.m_texture2d)
end

function M:OnClickWeChatMoments(go)
    -- if not self.m_isSave then
    --     self.m_isSave = GameHelper.SaveScreenshot(self.m_texture2d)
    -- end
    -- ShareSDKMgr:ShareWeChatMoments(self.m_desc, self.m_imgPath)
    ShareSDKMgr:ScreenshotAndroid(self.m_texture2d)
end

function M:OnClickQQ(go)
    -- if not self.m_isSave then
    --     self.m_isSave = GameHelper.SaveScreenshot(self.m_texture2d)
    -- end
    -- ShareSDKMgr:ShareQQ(self.m_desc, self.m_imgPath)
    ShareSDKMgr:ScreenshotAndroid(self.m_texture2d)
end

function M:OnClickQZone(go)
    -- if not self.m_isSave then
    --     self.m_isSave = GameHelper.SaveScreenshot(self.m_texture2d)
    -- end
    -- ShareSDKMgr:ShareQZone(self.m_desc, self.m_imgPath)
    ShareSDKMgr:ScreenshotAndroid(self.m_texture2d)
end

function M:OnClickSinaWeibo(go)
    -- if not self.m_isSave then
    --     self.m_isSave = GameHelper.SaveScreenshot(self.m_texture2d)
    -- end
    -- ShareSDKMgr:ShareSinaWeibo(self.m_desc, self.m_imgPath)
    ShareSDKMgr:ScreenshotAndroid(self.m_texture2d)
end

function M:OnRsGetShareReward(messageId, result, msg)
    if result ~= 0 then return end

    local ids, cnts = {}, {}
    for _, value in ipairs(msg.Awards) do
        if (value.Id > 0) and (value.Cnt > 0) then
            table.insert(ids, value.Id)
            table.insert(cnts, value.Cnt)
        end
    end

    IPlayerData:UpdateRewardTime(msg.GetRewardTime)
    self.m_uiState:SetState(IPlayerData:IsFirstTimeOfDay() and 1 or 2)

    self:Close()
    GameHelper.ShowGetItemsById(ids, cnts)
end

return M
