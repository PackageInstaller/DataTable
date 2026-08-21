local M = BaseClass("CreateAccountUICtrl", BaseUICtrl)
local socket = require("Common.Tools.socket")
local msgName = UIMessageNames.CREATE_ACCOUNT_SUCCESS

function M:Init()
    self._isFirstCreate = false
    self._isItem        = false -- 是否道具改名
    self._animName      = "AccountExitTrigger"
    self._nickLimit     = GameHelper.GetParamters(251)
    self._view.btn_cancel:onClick(Bind(self, self.Close))
    self._view.namefileld:onClick(Bind(self, self.OnInputSelect))
    self._view.btn_confirm:onClick(Bind(self, self.OnClickRename))
    self._view.rectConfirm:onClick(Bind(self, self.OnConfirmClick))
    self._view.rectRandom:onClick(Bind(self, self.OnRandomNameClick))
    self._view.btn_random:onClick(Bind(self, self.OnRandomNameClick))
    self._createCallback = Bind(self, self._CreateAccountClose)
    local handler = Bind(self, self.OnCreateAccountSuccessEvent)
    self._createAccountSuccessEvent = EventMgr:AddListener(msgName, handler)
end

function M:OnDispose()
    self._animName = nil
    self._createCallback = nil
    EventMgr:RemoveListener(msgName, self._createAccountSuccessEvent)
    M.super.OnDispose(self)
end

function M:OnEnter(isItem)
    self._isItem = isItem or false
    ITimeMgr:ChangeTimeMode(EnumConst.TimeMode.BattlePause)
    if self._isItem then
        self._view.node_uiState:SetState(2)
        -- 毫秒级的随机种子
        local timeStr = tostring(socket.gettime())
        math.randomseed(timeStr:reverse():sub(1, 7) * 100)
        self._view.txt_limitTips:SetActive(false)
        self._view.txt_curName:SetText(IPlayerData.NickName)
        math.random(100000000)
    else
        self._view.node_uiState:SetState(1)
        local timeStr = tostring(socket.gettime())
        local seed = tonumber(timeStr:reverse():sub(1, 7)) * 100 + INetPack.accountId % 1000000
        math.randomseed(seed)
        self:_SetRandomName()
    end
end

function M:_SetRandomName()
    local randomName = StoryHelper.GetCnRandomName()
    if randomName then
        if self._isItem then
            self._view.namefileld:SetText(randomName)
        else
            self._view.inputName:SetText(randomName)
        end
    end
end

function M:OnRandomNameClick()
    self:_SetRandomName()
end

function M:OnConfirmClick()
    if not string.isNullOrEmpty(IPlayerData.NickName) and
        not string.startswith(IPlayerData.NickName, "guest_")
    then
        -- 已经创角并取过名字
        self:OnTriggerStoryAnimation()
        return
    end

    local playerName = self._view.inputName:GetText()
    if self:_CheckPlayerName(playerName) then
        StoryDataMgr:GetInstance():RequestRename(playerName, false)
    end
end

function M:OnClickRename()
    local playerName = self._view.namefileld:GetText()
    if self:_CheckPlayerName(playerName) then
        StoryDataMgr:GetInstance():RequestRename(playerName, true)
    else
        self._view.txt_limitTips:SetActive(true)
    end
end

function M:OnCreateAccountSuccessEvent(roleName)
    local content = ConfigHelper.GetLocalString(161)
    content = string.format(content, roleName)
    self._view.txtTips:SetText(content)
    self._isFirstCreate = true
    self:OnTriggerStoryAnimation()
end

function M:OnTriggerStoryAnimation()
    self._view.animTrigger:SetTrigger(self._animName)
    self._view.animTrigger:SetAnimEndCallback(self._createCallback)
end

function M:OnInputSelect()
    self._view.txt_limitTips:SetActive(false)
end

function M:_CreateAccountClose()
    self:Close()
    StoryDataMgr:GetInstance():NextStory()
end

function M:_CheckPlayerName(playerName)
    local minNum = self._nickLimit[0]
    local maxNum = self._nickLimit[1]
    local result = GameHelper.CheckInputLimit(minNum, maxNum, playerName)
    if result < 0 then
        GameHelper.TipsById(946)
        self._view.txt_limitTips:SetText(946)
        return false
    end

    if result > 0 then
        GameHelper.TipsById(947)
        self._view.txt_limitTips:SetText(947)
        return false
    end

    if ConfigHelper.CheckBlockWord(playerName) then
        GameHelper.TipsById(666)
        self._view.txt_limitTips:SetText(666)
        return false
    end

    return true
end

function M:OnClose()
    ITimeMgr:ChangeTimeMode(EnumConst.TimeMode.BattleSingle)
    if self._isFirstCreate then
        self._isFirstCreate = nil
        -- UIContextMgr:GetInstance():Show("CreateRoleRewardUI")
    end
end

return M
