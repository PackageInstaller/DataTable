---@class CreateRolePanel : CreateRolePanel_Generate
---##################### 【CreateRolePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【CreateRolePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local CreateRolePanel = require "CreateRolePanel_Generate"
local utf8util = require "utf8util"
local Random = UnityEngine.Random

function CreateRolePanel:InitLogic(data)
    self.needEmptyTips = true
end

--function CreateRolePanel:StartCreating(time)
--
--end

--function CreateRolePanel:StartEnter(time)
--
--end

--function CreateRolePanel:StartRemoving(time)
--
--end

--function CreateRolePanel:StartExit(time)
--
--end

function CreateRolePanel:OnOpen(data, initiative)
    if initiative then
        self.callBack = data.callBack
        self:Refresh()
        self:SetLongPressFunc()
    end
end

function CreateRolePanel:SetLongPressFunc()
    self.longPressDuration = 2.5  -- 2.5秒满值
    self.pressStartTime = nil
    self.loginSEPlayed = false
    self.okBtn.clickLongPressListener.onDown = function()
        self.pressStartTime = Time.time  -- 记录开始时间
        self.progressBar.image.fillAmount = 0
        self.loginSEPlayed = false
    end
    self.okBtn.clickLongPressListener.onLongpress = function()

        if not self.loginSEPlayed then
            self:PlayLoginSE()
            self.loginSEPlayed = true
        end

        self.longPressTimer = DLuaTimer:DoRepeatForever(0.01, function()
            if self.pressStartTime == nil then
                DLuaTimer:RemoveTimer(self.longPressTimer)
                self.longPressTimer = nil
                return
            end
            local elapsed = Time.time - self.pressStartTime
            local fill = math.min(elapsed / self.longPressDuration, 1)
            self.progressBar.image.fillAmount = fill
            if self.progressBar.image.fillAmount >= 1 then
                self.pressStartTime = nil
                self:DoRegisterUser()
                DLuaTimer:RemoveTimer(self.longPressTimer)
                self.longPressTimer = nil
            end
        end)
    end
    self.okBtn.clickLongPressListener.onUp = function()
        self.pressStartTime = nil
        self.progressBar.image.fillAmount = 0  -- 重置进度条
        if self.longPressTimer then
            DLuaTimer:RemoveTimer(self.longPressTimer)
            self.longPressTimer = nil
        end
        self:StopLoginSE()
        self.loginSEPlayed = false
    end
end

function CreateRolePanel:SetRoleData()
    self.okBtn:SetActive(false)
    --测试版本随机用户头像
    --local headID = Random.Range(1, 10)
    local sex = SexType.Male
    local name = self.nameField.inputField.text
    local born = -1
    if string.len(name) > 0 then -- todo:进一步限制，如其他字符
        -- 国内版本姓名只能是中文
        if GV.GlobalConfig.IsNameOnlyChinese() and not utf8util.isOnlyChinese(name) then
            UICommonUtils.PopToast(LocalStrEnum.NameShouldBeChinese)
            return
        end

        name = name:trim()
        if UICommonUtils.ToastLogicError(name:len()>0, ActionFailReason.NameTooShort) then
            return
        end

        local checkRes = GV.GlobalConfig.HasForbiddenWord(name)
        if checkRes ~= false then
            local msg = utf8util.gsub("\"$word\"不可使用", "%$(%w+)", checkRes)
            UICommonUtils.PopToast(msg)
            return
        end

        if UICommonUtils.ToastLogicError(utf8util.len(name)<=7, ActionFailReason.NameTooLong) then
            return
        end

        -- 不能有空白字符、标点符号、emoji
        -- 看不少人还是会起类似Mr.这种名字的，所以只是引号以及反斜杠不让用了
        if UICommonUtils.ToastLogicError(not name:find("['\"\\]") and not utf8util.hasEmoji(name), ActionFailReason.NameContainsInvalidChar) then
            return
        end
        
        --local bornConfig = Config.GetBornInfo(born)
        --if bornConfig == nil then
        --    UICommonUtils.PopToast(LocalStrEnum.BornNotSelect)
        --    return
        --end

        self.initProp = {
            name = name,
            sex = sex,
            born = born,
            head = Config.GetConfigInfo("HeadportraitStart")[1],
            distinct_id = SDKMgr:getDistinctId(),
        }
        self.okBtn:SetActive(true)
        self.noNameBtn:SetActive(false)
    else
        self.noNameBtn:SetActive(true)
        UICommonUtils.PopToast(LocalStrEnum.NameCannotBeEmpty)
        self.needEmptyTips = false
    end
end

function CreateRolePanel:PlayLoginSE()
    local btnSoundPath = string.format(Config.AudioPath.SE, "logon_1")
    self.SE = self:play2DSound(btnSoundPath)
end

function CreateRolePanel:StopLoginSE()
    if self.SE then
        AudioMgr:stopSE(self.SE)
        self.SE = nil
    end
end

--创建角色
function CreateRolePanel:DoRegisterUser()
    GameNetHandler:SendWaitMessage("user.RegisterUserReq", self.initProp, function (data)
        if data.ret == 0 then
            self.animator.enabled = true
            self.animator:SetTrigger("Out")
            local btnSoundPath = string.format(Config.AudioPath.SE, "logon_2")
            self:play2DSound(btnSoundPath)
            self.animOverCallBack:SetCallBack(function()
                self.callBack(true)
                -- UIMgr:closeUI(self)
            end)
        end
    end)
end

--取随机名
function CreateRolePanel:DoRandomName()
    local randomData = Config.GetAllConfig("RandomNameTable")
    local max1 = 0
    local max2 = 0
    for k, v in pairs(randomData) do
        if v.Name1 ~= "" then
            max1 = max1 + 1
        end
        if v.Name2 ~= "" then
            max2 = max2 + 1
        end
    end
    local name = ""
    local maxAttempts = 50
    for _ = 1, maxAttempts do
        local num1 = math.floor(Random.Range(1, max1))
        local num2 = math.floor(Random.Range(1, max2))
        local name1 = Config.GetRandomNameInfo(num1).Name1 or ""
        local name2 = Config.GetRandomNameInfo(num2).Name2 or ""
        name = name1 .. name2
        if GV.GlobalConfig.HasForbiddenWord(name) == false then
            break
        end
    end
    self.nameField.inputField.text = name
end

--function CreateRolePanel:OnClose(initiative)
--
--end

--function CreateRolePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function CreateRolePanel:OnRefresh(data)
--
--end

--[[
/PanelBg/NameField onEndEdit 
--]]
function CreateRolePanel:nameField_InputField_onEndEdit(nameField,content)
    self:SetRoleData()
end

--[[
/PanelBg/NameField onValueChanged 
--]]
function CreateRolePanel:nameField_InputField_onValueChanged(nameField,content)

end

--[[
/RandomNameBtn onClick 
--]]
function CreateRolePanel:randomNameBtn_ScaleButton_onClick(randomNameBtn)
    self:DoRandomName()
    self:SetRoleData()
end

--[[
/Fingerprint/NoNameBtn onClick 
--]]
function CreateRolePanel:noNameBtn_Button_onClick(noNameBtn)
    if self.needEmptyTips then
        UICommonUtils.PopToast(LocalStrEnum.NameCannotBeEmpty)
    else
        self.needEmptyTips = true
    end
end

return CreateRolePanel
