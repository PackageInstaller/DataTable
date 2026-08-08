---@class UserPanel : UserPanel_Generate
---##################### 【UserPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【UserPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local UserPanel = require "UserPanel_Generate"
local utf8util = require "utf8util"

local function TruncateByDisplayWidth(text, maxWidth)
    text = text or ""
    local currentWidth = 0
    local chars = {}
    for _, code in utf8util.codes(text) do
        local charWidth = utf8util.runeLen(code) > 2 and 2 or 1
        if currentWidth + charWidth > maxWidth then
            return table.concat(chars) .. "..."
        end
        currentWidth = currentWidth + charWidth
        table.insert(chars, utf8util.char(code))
    end

    return text
end

function UserPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshHead, self.SetHead},
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
    }
    self.nowShowSpineObj = nil
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
end

--function UserPanel:StartCreating(time)
--
--end

--function UserPanel:StartEnter(time)
--
--end

--function UserPanel:StartRemoving(time)
--
--end

--function UserPanel:StartExit(time)
--
--end

function UserPanel:OnOpen(data, initiative)
    self:SetPoster()
    --显示头像
    self:SetHead()
    --显示签名
    self.signTxt.text.text = Me.userData.UserSign
    --显示UID
    self.uidTxt.text.text = Me.uid
    --显示用户名
    self.userNameTxt.text.text = Me:getUserName()
    --显示舰船数量
    self.shipCountTxt.text.text = tablex.size(ClientData:GetRoleList())
    --注册日期
    self.registerView.value.text.text = DLuaUtil.TimeStampToTimeStr(Me.borntime, false, 1)
    --累计登陆天数
    self.loginDayView.value.text.text = Me.userData.LoginDay
    --生日 额外记录
    self.brithdayView.value.text.text = "???"
    --显示等级和经验条
    self.levelTxt.text.text = "Lv."..Me:getUserLevel()
    local levelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.user, Me:getUserLevel())
    local nowExp = Me:getUserEXP() - levelData.exp_sum

    --等级已满特殊显示
    if levelData.max_level == Me:getUserLevel() and Me:getUserEXP() >= levelData.exp_sum then
        self.expTxt.text.text = "已达上限"
        self.expSlider.image.fillAmount = 0
    else
        self.expTxt.text.text = nowExp.."/"..levelData.exp
        self.expSlider.image.fillAmount = nowExp / levelData.exp
    end

    local LevelMainMax = Me:getLevelMainMax()
    local levelconfig = Config.GetPveLevelInfo(LevelMainMax)
    --战役记录 暂无
    local battleMsgText = TruncateByDisplayWidth(levelconfig.nameKey, 12)
    self.battleMsgTxt.text.text = battleMsgText
    --导航栏
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.UserPanel, self)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = false
        self.animator:SetTrigger("Out")
        self.animOverCallBack:SetCallBack(function()
            if data and data.mode and data.mode == 2 then
                CoveManager.instance():SetHomelandShowOrHide(true)
            end
            UIMgr:closeUI(self)
            self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = true
        end)
        self.customBackPanel.customBackPanel:ClearBackFunc()
    end)
    self.gMBtn.gameObject:SetActive(GV.GlobalConfig.ShowMainPanelTestBtn and EngineGlobal.CheckInEditor() == true)
end

--设置头像
function UserPanel:SetHead()
    local HeadConfig = Config.GetHeadportraitInfo(Me.head)
    if HeadConfig == nil then
        HeadConfig = Config.GetHeadportraitInfo(1000001)
    end
    local resourceFolder = nil
    if tonumber(HeadConfig.folder) ~= nil then
        resourceFolder = tostring(math.floor(tonumber(HeadConfig.folder)))
    else
        resourceFolder = HeadConfig.folder
    end
    self:LoadSpriteAsync(string.format(Config.SpritePath.IconRolePath, resourceFolder, HeadConfig.filename), function (s)
        self.headBox.headIconImg.image.sprite = s
        self.headBox.headIconImg.canvasGroup.alpha = 1
    end)
end

--设置看板娘
function UserPanel:SetPoster()
    UICommonUtils:ShowRolePicOrSpine(self, self.showCharacter, ClientData:GetPosterData().SkinId, function(spineObject)
        if UICommonUtils.Checkobj(self.nowShowSpineObj) then
                GameObject.Destroy(self.nowShowSpineObj)
        end
        self.nowShowSpineObj = spineObject
    end)
end

--function UserPanel:OnClose(initiative)
--
--end

--function UserPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function UserPanel:OnRefresh(data)
--
--end

--[[
/CustomBackPanel/Bg/HelpBtn onClick 
--]]
function UserPanel:helpBtn_ScaleButton_onClick(helpBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/EixtGameBtn onClick 
--]]
function UserPanel:eixtGameBtn_ScaleButton_onClick(eixtGameBtn)
    self:play2DSound(self.btnSoundPath)
    -- UIMgr:clearAllUI()
    StateMgr:ChangeToState(GameFlowState.LoginState)
end

--[[
/UserMsgPanel/HeadBox/ChangeHeadBtn onClick 
--]]
function UserPanel:changeHeadBtn_ScaleButton_onClick(changeHeadBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUICover("HeadChosePanel", {})
end

--[[
/UserMsgPanel/ChangeNameBtn onClick 
--]]
function UserPanel:changeNameBtn_ScaleButton_onClick(changeNameBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUI("MsgBox", {
        title = "修改名称", 
        type = MsgBoxType.ChangePlayerName,
        titleIcon = MsgTitleIconType.Pen,
        okCallback = function(nameText)
            self:play2DSound(self.btnSoundPath)
            local signTxt = ""
            signTxt = nameText
            if UICommonUtils.ToastLogicError(signTxt:len() > 0, ActionFailReason.NameTooShort) then
                return
            end
            if UICommonUtils.ToastLogicError(utf8util.len(signTxt) <= 7, ActionFailReason.NameTooLong) then
                return
            end
            signTxt = signTxt:trim()
            local checkRes = GV.GlobalConfig.HasForbiddenWord(signTxt)
            if checkRes ~= false then
                local msg = utf8util.gsub("\"$word\"不可使用", "%$(%w+)", checkRes)
                UICommonUtils.PopToast(msg)
                return
            end
            if UICommonUtils.ToastLogicError(not signTxt:find("['\"\\]") and not utf8util.hasEmoji(signTxt), ActionFailReason.NameContainsInvalidChar) then
                return
            end
            Me:changeNameReq({newName = signTxt}, function()
                --显示用户名
                self.userNameTxt.text.text = Me:getUserName()
                UICommonUtils.PopToast("更换成功")
            end)
        end}
    )
end

--[[
/UserMsgPanel/UidBg/CopyBtn onClick 
--]]
function UserPanel:copyBtn_ScaleButton_onClick(copyBtn)
    self:play2DSound(self.btnSoundPath)
    UnityEngine.GUIUtility.systemCopyBuffer = Me.uid
    UICommonUtils.PopToast("复制成功")
end

--[[
/UserMsgPanel/BtnList/CodeBtn onClick 
--]]
function UserPanel:codeBtn_ScaleButton_onClick(codeBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUI("MsgBox", {
        title = "兑换码", 
        type = MsgBoxType.Code,
        titleIcon = MsgTitleIconType.Code,
        okCallback = function(nameText)
            self:play2DSound(self.btnSoundPath)
            local signTxt = ""
            signTxt = nameText
            Me:getRedeemCodeAwardReq({code = signTxt}, function()
                --UICommonUtils.PopToast("领取成功")
            end)
        end}
    )
end

--[[
/UserMsgPanel/BtnList/CommunityBtn onClick 
--]]
function UserPanel:communityBtn_ScaleButton_onClick(communityBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/UserMsgPanel/BtnList/ShareBtn onClick 
--]]
function UserPanel:shareBtn_ScaleButton_onClick(shareBtn)
    if true or EngineGlobal.PublishCode5 == 100 then
        UICommonUtils.PopToast(LocalStrEnum.UnlockOpen)
        return
    end
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUICover("UserSharePanel")
end

--[[
/UserMsgPanel/BtnList/HelperBtn onClick 
--]]
function UserPanel:helperBtn_ScaleButton_onClick(helperBtn)
    self:play2DSound(self.btnSoundPath)
    Me:getSupportLinkReq(function(data)
        Application.OpenURL(data.link)
    end)
end

--[[
/GMBtn onClick 
--]]
function UserPanel:gMBtn_Button_onClick(gMBtn)
    UIMgr:popUI('GmPanel', {})
end

--[[
/AdjustRoot/UserMsgPanel/SignBg/ChangeSignBtn onClick 
--]]
function UserPanel:changeSignBtn_ScaleButton_onClick(changeSignBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUI("MsgBox", {
        title = "编辑签名", 
        type = MsgBoxType.ChangePlayerSign,
        titleIcon = MsgTitleIconType.Pen,
        okCallback = function(signText)
            self:play2DSound(self.btnSoundPath)
            local signTxt = ""
            signTxt = signText
            signTxt = signTxt:trim()
            local checkRes = GV.GlobalConfig.HasForbiddenWord(signTxt)
            if checkRes ~= false then
                local msg = utf8util.gsub("\"$word\"不可使用", "%$(%w+)", checkRes)
                UICommonUtils.PopToast(msg)
                return
            end
            if UICommonUtils.ToastLogicError(not signTxt:find("['\"\\]") and not utf8util.hasEmoji(signTxt), ActionFailReason.NameContainsInvalidChar) then
                return
            end
            Me:changeSignReq({signTxt = signTxt}, function()
                --显示签名
                self.signTxt.text.text = Me.userData.UserSign
                UICommonUtils.PopToast("更换成功")
            end)
        end}
    )
end

return UserPanel
