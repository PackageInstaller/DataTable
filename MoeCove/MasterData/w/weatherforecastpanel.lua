---@class WeatherForecastPanel : WeatherForecastPanel_Generate
---##################### 【WeatherForecastPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【WeatherForecastPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local WeatherForecastPanel = require "WeatherForecastPanel_Generate"
local DOGetter = DG.Tweening.Core.DOGetter_int
local DOSetter = DG.Tweening.Core.DOSetter_int
function WeatherForecastPanel:InitLogic(data)
    ---@type int
    self.spineId = 0
    ---@type CoveActingSystem.CoveSpine
    self.coveSpine = nil
    ---@type int[][]
    self.dialogs = nil
end

function WeatherForecastPanel:OnOpen(data, initiative)

    self.videoRoot.gameObject:SetActive(true)
    self.reportRoot.canvasGroup.alpha = 0
    local characterId, dialogs = CoveManager.instance():GetWeatherDialogue( Me:GetTodayAndTomorrowWeatherData())
 
    if self.spineId ~= 0 and self.spineId ~= characterId and (not IsNull(self.coveSpine)) then
        local temp = self.coveSpine
        self.coveSpine = nil
        GameObject.Destroy(temp.gameObject)
    end
    self.spineId = characterId
    self.dialogs = dialogs
    local spineName = "Role_" .. characterId
    local prefabPath = string.format(Config.PrefabPath.RoleSpine, spineName, spineName)
    self:LoadGameObjectAsync(prefabPath, BindCallback(self, self.OnLoadFinish, prefabPath))

    self:PlayOpenAnim()
end

function WeatherForecastPanel:PlayOpenAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("In")
    self.animOverCallBack:SetCallBack(function()
        self:OnAnimationCallback()
    end)
end

function WeatherForecastPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

function WeatherForecastPanel:OnClose(initiative)
    if self.dialoguesSeq ~= nil then
       self.dialoguesSeq:Kill()
       self.dialoguesSeq = nil 
    end
end

function WeatherForecastPanel:OnDestroy()
    if not IsNull(self.coveSpine) then
        local temp = self.coveSpine
        self.coveSpine = nil
        GameObject.Destroy(temp.gameObject)
    end

    if self.dialoguesSeq ~= nil then
       self.dialoguesSeq:Kill()
       self.dialoguesSeq = nil 
    end

    self.destroyed = true
    self.spineId = nil
    self.super:OnDestroy(self)
end

--function WeatherForecastPanel:OnRefresh(data)
--
--end

--[[
/autoRoot/content/closeBtn onClick 
--]]
function WeatherForecastPanel:closeBtn_ScaleButton_onClick(closeBtn)
    self.spineRoot:SetActive(false)
    self:playCloseAnim()
end

function WeatherForecastPanel:OnLoadFinish(path, obj)
    if self.destroyed then
        GameObject.Destroy(obj)
        return
    end
    local spineName = "Role_" .. self.spineId
    local prefabPath = string.format(Config.PrefabPath.RoleSpine, spineName, spineName)
    if path ~= prefabPath then
       GameObject.Destroy(obj)
       return
    end
    local spineObject = obj
    spineObject:SetParent(self.spineRoot.transform)
    spineObject.transform.localPosition = Vector3.zero
    spineObject.transform.localScale = Vector3.one
    --关闭spine物理效果
    local objSpine = spineObject:GetComponent("SkeletonGraphic")
    objSpine.PhysicsPositionInheritanceFactor = Vector2.zero

    --初始化点击事件
    ---@type CoveActingSystem.CoveSpine
    local coveSpine = spineObject:AddComponent(TypeInfo.CoveSpine)

    --初始化动画状态
    coveSpine:Play("idle_action", GE.RoleSpineActionType.Action, true)
    coveSpine:Play("idle", GE.RoleSpineActionType.Emote, true)
    coveSpine.useEndAnimation = true
    self.coveSpine = coveSpine
end

function WeatherForecastPanel:OnAnimationCallback(animaName)
    ---写入日期
    local serverTime = EngineUtil.ServerTime_DisplayTime()
    -- '!*t' 会返回一个包含 GMT 时间各个字段的 table
    local gmtTable = os.date("!*t", serverTime)

    local year = gmtTable.year
    local month = gmtTable.month
    local day = gmtTable.day
    local h = gmtTable.hour
    local m = gmtTable.min
    local s = gmtTable.sec

    local timeStr = string.format("%d年%d月%d日", year, month, day)
    self.timeText.text.text = timeStr

    self.curPlayIndex = 0
    self:PlayDialogues()
end

function WeatherForecastPanel:PlayDialogues()
    local index = self.curPlayIndex
    index = index + 1
    if index > #self.dialogs then
       return
    end
    local dlogs = self.dialogs[index]
    local sss =  ""
    local temp = 0
    local lastCount = 0

    local seq = DOTween.Sequence()
    local tmp = self.dialogueText.text
    tmp.text = ""
    for j = 1, #dlogs do
        local cfg = Config.GetWeatherReportInfo(dlogs[j])
        sss = sss .. cfg.text
        tmp.text = sss
        local count = tmp:GetCharacterCount()
        local tween = tmp:DoTextMesh(sss, cfg.duration)
        tween:OnStart(function()
            tmp.maxVisibleCharacters = lastCount
        end)
        tween:SetEase(DG.Tweening.Ease.Linear)
        seq:Append(tween)
        lastCount = count

        --加入spine动画
        local spineAction = cfg.spineAction
        for i = 1, #spineAction do
            local sa = spineAction[i]
            local trackIndex = sa[1]

            local animaNames = {sa[2]}
            local nextIndex = 3
            for j = 3, #sa do
                local t = sa[j]
                if type(t) == "string" then
                   table.insert(animaNames, t)
                else
                    nextIndex = j
                    break 
                end
            end

            local isLoop =  sa[nextIndex] or false
            local yeildTime = sa[nextIndex + 1] or 0
            if #animaNames == 1 then
                seq:InsertCallback(temp + yeildTime, function()
                    self.coveSpine:Play(animaNames[1], trackIndex, isLoop)
                end)
            else
                seq:InsertCallback(temp + yeildTime, function()
                    self.coveSpine:Play(animaNames[1], trackIndex, isLoop)
                    for ii = 2, #animaNames do
                        local t = animaNames[ii]
                        self.coveSpine:PlayQueue(animaNames[ii], trackIndex, isLoop)
                    end
                end)
            end
        end
        temp = temp + cfg.duration
    end
    tmp.maxVisibleCharacters = 0

    seq:AppendInterval(1)
    seq:OnComplete(function()
        self.dialoguesSeq = nil
        self.curPlayIndex = index
        self:PlayDialogues(index)
    end)
    if self.dialoguesSeq ~= nil then
       self.dialoguesSeq:Kill()
       self.dialoguesSeq = nil 
    end
    self.dialoguesSeq = seq
    ---播放spine 动画
end

return WeatherForecastPanel
