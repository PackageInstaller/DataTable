local SetAccountUICtrl = BaseClass("SetAccountUICtrl")

local M = SetAccountUICtrl

function M:__init(view)
    self._view = view
    self._view.btn_copy:onClick(Bind(self, self._OnClickCopyUID))
    self._view.bind:onClick(Bind(self, self._OnClickBind))
end

function M:_OnClickCopyUID(go)
    local uid = tostring(INetPack.accountId)
    GameHelper.CopyToClipboard(uid)
    GameHelper.Tips(ConfigHelper.GetLocalString(5176) .. uid)
end

function M:_OnClickBind(go)
    local packageName = CS.GameX.GameHelper.GetPackageName()
    local chan = 0
    if string.contains(packageName, "hykb") then
        chan = CS.GameX.EChannel.EChanHYKB
    elseif string.contains(packageName, "tap") then
        chan = CS.GameX.EChannel.EChanTap
    else
        return
    end
    -- SDKHelper.AuthAccount(chan, Bind(self, self._OnAuthBindSuc)) -- 新官包不反绑
end

function M:_OnAuthBindSuc(bindUID)
    if bindUID ~= nil and bindUID ~= "" then
        self._view.bindUID:SetActive(true)
        self._view.bind:SetActive(false)
        GameHelper.Tips(30253)
    else
        self._view.bind:SetActive(true)
    end
end

function M:Open()
    local packageName = CS.GameX.GameHelper.GetPackageName()
    self._view.ani.enabled = false
    self._view.bindUID:SetActive(false)
    self._view.bind:SetActive(false)
    local titleName = "好游快爆"
    local msgData = {}
    local needAuth = true
    if string.contains(packageName, "hykb") then
        titleName = "好游快爆"
        msgData.PlatformId = protocol.PlatformId.HYKB
    elseif string.contains(packageName, "tap") then
        titleName = "TapTap"
        msgData.PlatformId = protocol.PlatformId.TapTap
    else
        needAuth = false
    end

    self._view.txt_uid:SetText(tostring(INetPack.accountId))
    self._view.txt_date:SetText(GameHelper.TimeStampToString(IPlayerData.creatTick, "yyyy-MM-dd"))
    self._view.txt_title:SetTextFormat(30250, titleName)
    self._view.desc:SetTextFormat(30251, titleName)

    -- if self._getAccountBindHandler then
    --     NetPack:UnRegistResponse(Proto.MessageId.ResponseGetAccountBind, self._getAccountBindHandler)
    --     self._getAccountBindHandler = nil
    -- end
    -- local macro = CS.GameX.GameHelper.GetUnityMacro()
    -- if macro ~= "UNITY_ANDROID" or needAuth == false then
    self._view.channelArea:SetActive(false)
    --     return
    -- else
    --     self._view.channelArea:SetActive(true)
    -- end
    -- self._getAccountBindHandler = NetPack:RegistResponse(Proto.MessageId.ResponseGetAccountBind,
    --     Bind(self, self._OnGetAccountBind))
    -- NetPack:SendMessage(Proto.MessageId.RequestGetAccountBind, msgData)
end

function M:_OnGetAccountBind(messageId, result, msg)
    if self._getAccountBindHandler then
        NetPack:UnRegistResponse(Proto.MessageId.ResponseGetAccountBind, self._getAccountBindHandler)
        self._getAccountBindHandler = nil
    end
    if result ~= 0 then
        return
    end
    local openJson = msg.Data
    --GameHelper.Tips("openJson:" .. tostring(openJson))
    if openJson == nil or openJson == '' then
        self._view.bind:SetActive(true)
        return
    end
    local data = Json.decode(openJson)
    if data.oid ~= nil and data.oid ~= "" then
        self._view.bindUID:SetActive(true)
    else
        self._view.bind:SetActive(true)
    end
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
    end
    if self._getAccountBindHandler then
        NetPack:UnRegistResponse(Proto.MessageId.ResponseGetAccountBind, self._getAccountBindHandler)
    end
    self._getAccountBindHandler = nil
    self._view = nil
end

function M:RevertAll(active)

end

return SetAccountUICtrl
