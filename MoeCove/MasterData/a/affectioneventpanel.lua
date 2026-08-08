---@class AffectionEventPanel : AffectionEventPanel_Generate
---##################### 【AffectionEventPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【AffectionEventPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local AffectionEventPanel = require "AffectionEventPanel_Generate"
local FunctionOpenTable = require("common.table.lua.client.FunctionOpenTable")

local AffectionEventMode = {
    Select = 1, --选择模式
    Browse = 2, --浏览模式
}

function AffectionEventPanel:InitLogic(data)
    self.id = nil              --角色id
    self.eventId = nil         --事件id
    self.nowMode = nil         --当前模式 1：选择模式 2：浏览模式
    self.nowFinish = false     --当前完成状态
    self.nowShowSpineObj = nil --当前显示的spine对象
    self.optionCount = 0       --当前应显示的选项数量
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
end

--function AffectionEventPanel:StartCreating(time)
--
--end

--function AffectionEventPanel:StartEnter(time)
--
--end

--function AffectionEventPanel:StartRemoving(time)
--
--end

--function AffectionEventPanel:StartExit(time)
--
--end

function AffectionEventPanel:OnOpen(data, initiative)
    -- LuaLogger.ds("data", tablex.dump(data))
    self.id = data.id
    self.nowMode = data.mode or AffectionEventMode.Select
    self.eventId = data.eventId

    for i = 1, 3 do
        self["eventBtn_" .. i]:SetActive(false)
    end

    if self.nowMode == AffectionEventMode.Select then
        self:setView()
    elseif self.nowMode == AffectionEventMode.Browse then
        self:setBrowseModeView()
    end

    self:PlayEffect()
end

function AffectionEventPanel:setView()
    self.nowFinish = false
    --显示左侧角色
    self:setHeroView()
    self:resetBtnPos()
    self:setMsgView()
    local eventConfig = Config.GetHomeEventInfo(self.eventId)
    local choiceNum = eventConfig.choiceNum or 0
    if choiceNum > 3 then
        choiceNum = 3
    end
    self.optionCount = choiceNum
    for i = 1, 3 do
        local btn = self["eventBtn_" .. i]
        if i <= choiceNum then
            local index = i
            btn:SetActive(true)
            btn.eventChoseTxt.text.text = eventConfig["choice" .. index .. "Text"]
            btn.scaleButton.onClick:RemoveAllListeners()
            btn.scaleButton.onClick:AddListener(function()
                self:play2DSound(self.btnSoundPath)
                local eventEffevt = eventConfig["choice" .. index .. "Effect"]
                if eventConfig.eventType == GE.AffectionEventType.Normal then
                    self.eventMsgTxt.text.text = eventConfig["choice" .. index .. "TextFB"]
                    self:changeBtnView(index, true)
                    self:sendReq(index, function()
                        btn.exitBtn.scaleButton.onClick:RemoveAllListeners()
                        btn.exitBtn.scaleButton.onClick:AddListener(function()
                            self:play2DSound(self.btnSoundPath)
                            UIMgr:closeUI(self)
                        end)
                    end)
                elseif eventConfig.eventType == GE.AffectionEventType.Delegate then
                    for _, v in pairs(eventEffevt) do
                        if v[1] == GE.AffectionEventEffectType.Null then --搁置进入后续显示
                            self.eventMsgTxt.text.text = eventConfig["choice" .. index .. "TextFB"]
                            self:changeBtnView(index)
                            btn.confirmBtn:SetActive(false)
                            btn.exitBtn:SetActive(true)
                            btn.exitBtn.canvasGroup:DOFade(1, 0.2)
                            btn.exitBtn.scaleButton.onClick:RemoveAllListeners()
                            btn.exitBtn.scaleButton.onClick:AddListener(function()
                                self:play2DSound(self.btnSoundPath)
                                UIMgr:closeUI(self)
                            end)
                        elseif v[1] == GE.AffectionEventEffectType.GiveUp or
                            v[1] == GE.AffectionEventEffectType.IgnoreConditionEvent or
                            v[1] == GE.AffectionEventEffectType.CloseEvent then
                            self.eventMsgTxt.text.text = eventConfig["choice" .. index .. "TextFB"]
                            self:changeBtnView(index)
                            self:sendReq(index, function()
                                btn.confirmBtn:SetActive(false)
                                btn.exitBtn:SetActive(true)
                                btn.exitBtn.canvasGroup:DOFade(1, 0.2)
                                btn.exitBtn.scaleButton.onClick:RemoveAllListeners()
                                btn.exitBtn.scaleButton.onClick:AddListener(function()
                                    self:play2DSound(self.btnSoundPath)
                                    UIMgr:closeUI(self)
                                end)
                            end)
                        elseif v[1] == GE.AffectionEventEffectType.AcceptDelegate then
                            if eventConfig.eventType == GE.AffectionEventType.Delegate then
                                self:changeBtnView(index)
                                self:sendReq(index, function()
                                    UIMgr:closeUI(self)
                                    if eventConfig.complete[1] == GE.MissionFinishType.ClearLevel then --完成指定关卡，直接跳转进这场战斗
                                        --进战斗
                                        Me:setNowSelectLevel(eventConfig.complete[2][1])
                                        LoadingMgr:SetLoadingStart(function()
                                            StateMgr:ChangeToState(GameFlowState.BattleState)
                                        end, nil, nil, "AffectionEventPanel")
                                    else
                                        --TODO: 这里接其他模式的具体选项效果
                                    end
                                end)
                            else
                                self.eventMsgTxt.text.text = eventConfig["choice" .. index .. "TextFB"]
                                self:changeBtnView(index)
                                self:sendReq(index, function()
                                    btn.exitBtn:SetActive(false)
                                    btn.confirmBtn:SetActive(true)
                                    btn.confirmBtn.canvasGroup:DOFade(1, 0.2)
                                    btn.confirmBtn.scaleButton.onClick:RemoveAllListeners()
                                    btn.confirmBtn.scaleButton.onClick:AddListener(function()
                                        self:play2DSound(self.btnSoundPath)
                                        UIMgr:closeUI(self)
                                    end)
                                end)
                            end
                        end
                    end
                end
            end)

            btn.scaleButton.onPress = function(isPress)
                btn.pressImage:SetActive(isPress)
            end
        else
            -- choiceNum 不足 3 时，显式隐藏多余选项
            btn.scaleButton.onClick:RemoveAllListeners()
            btn:SetActive(false)
        end
    end
end

--显示左侧角色
function AffectionEventPanel:setHeroView()
    local roleConfig = Config.GetCharacterInfo(self.id)
    local skinConfig = Config.GetCharacterSkinInfo(roleConfig.baseSkinID)
    UICommonUtils:ShowRolePicOrSpine(self, self.showCharacter, skinConfig.id, function(spineObject)
        if UICommonUtils.Checkobj(self.nowShowSpineObj) then
            GameObject.Destroy(self.nowShowSpineObj)
        end
        self.nowShowSpineObj = spineObject
        -- 根据皮肤类型选择正确的初始偏移，避免两次赋值互相覆盖
        local offsetY
        if skinConfig.spineKey and skinConfig.spineKey ~= "" then
            offsetY = skinConfig.spineOffset[2]
        else
            offsetY = skinConfig.imgOffset[2]
        end
        self.showCharacter.rectTransform.anchoredPosition = Vector2.New(0, offsetY)
    end)
end

--更改按钮列表显示 （隐藏除了这个index以外的按钮）
--@param index 选项索引
function AffectionEventPanel:changeBtnView(index, isNew)

    if isNew then
        if self.btn_seq ~= nil then
           self.btn_seq:Kill()
           self.btn_seq = nil 
        end
        local seq = DOTween.Sequence()
        for i = 1, 3 do
            ---@type AffectionEventPanel_Generate_eventBtn_1
            local btn = self["eventBtn_" .. i]
            if btn.gameObject.activeSelf == false then
                goto continue
            end
            btn.scaleButton.onClick:RemoveAllListeners()
            btn.scaleButton.interactable = false
            if i == index then
                goto continue
            end
            btn.canvasGroup.alpha = 1
            local tween = btn.canvasGroup:DOFade(0, 0.5)
            seq:Join(tween)
            ::continue::
        end
        ---@type AffectionEventPanel_Generate_eventBtn_1
        local btn = self["eventBtn_" .. index]
        ---@type UnityEngine.RectTransform
        local trs = btn.gameObject.transform
        local targetPosition = self.pos_1.transform.localPosition
        local tween = trs:DOLocalMove(targetPosition, 0.2)
        seq:Append(tween)
 
        btn.confirmBtn:SetActive(false)
        btn.exitBtn:SetActive(true)
        btn.exitBtn.canvasGroup.alpha = 0
        local tween = btn.exitBtn.canvasGroup:DOFade(1, 0.2)
        seq:Append(tween)
        seq:OnComplete(function()
            self.btn_seq = seq
        end)
        self.btn_seq = seq
    else
        for i = 1, 3 do
            self["eventBtn_" .. i].scaleButton.onClick:RemoveAllListeners()
            self["eventBtn_" .. i].scaleButton.interactable = false
            if i ~= index then
                self["eventBtn_" .. i].canvasGroup:DOFade(0, 0.2)
            else
                self["eventBtn_" .. i].canvasGroup.alpha = 1
                local targetPosition = self.pos_1.transform.position
                self["eventBtn_" .. i].transform:DOMove(targetPosition, 0.2) -- 移动到预制体的位置
            end
        end
    end

end

--设置信息显示
function AffectionEventPanel:setMsgView()
    local eventConfig = Config.GetHomeEventInfo(self.eventId)
    self.eventTxt.text.text = eventConfig.eventTitle
    self.eventMsgTxt.text.text = eventConfig.eventText

--     local str = [[“呀啊——！有鬼、有鬼啊啊啊——！”
-- 桐发出足以穿透港区的尖叫，下意识使出一记漂亮的过肩摔。
-- ……躺在地上的我望着夜空，听着桐带着哭腔的道歉，不禁感叹：这就是用物理手段驱魔的“桐流”巫女吗，简直不要太酷了。Bling-Bang-Bang-Born……]]
-- self.eventMsgTxt.text.text = str
end

--设置浏览模式显示
function AffectionEventPanel:setBrowseModeView()
    self:setHeroView()
    self:resetBtnPos()
    --仅显示第一个选项，根据配置中的选项位置，加载对应的后续信息
    local eventConfig = Config.GetHomeEventInfo(self.eventId)
    local choseIndex = eventConfig.commissionButton
    self.eventTxt.text.text = eventConfig.eventTitle

    local taskData = Me:getMissionListById(self.eventId)
    self.eventBtn_1:SetActive(true)
    if taskData.state == GE.MissionState.Unclaimed then
        self.eventMsgTxt.text.text = eventConfig["choice" .. choseIndex .. "TextFB"]
        self.nowFinish = true
        self.eventBtn_1.scaleButton.onClick:RemoveAllListeners()
    else
        --未完成接入对应跳转
        self.eventBtn_1.scaleButton.onClick:RemoveAllListeners()
        self.eventBtn_1.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            UIMgr:closeUI(self)
            UIMgr:closeUI("AffectionEventListPanel")
            if eventConfig.complete[1] == GE.MissionFinishType.ClearLevel then --完成指定关卡，直接跳转进这场战斗
                Me:setNowSelectLevel(eventConfig.complete[2][1])
                LoadingMgr:SetLoadingStart(function()
                    StateMgr:ChangeToState(GameFlowState.BattleState)
                end, nil, nil, "AffectionEventPanel2")
            else
                --TODO: 这里接其他模式的具体选项一效果
            end
        end)
        self.eventMsgTxt.text.text = eventConfig.eventText
        self.nowFinish = false
    end

    self.eventBtn_1.eventChoseTxt.text.text = eventConfig["choice" .. choseIndex .. "Text"]
    self.optionCount = 1
    self.eventBtn_2:SetActive(false)
    self.eventBtn_3:SetActive(false)
    if self.nowFinish then
        --委托已完成，显示绿色确认按钮领取奖励
        self.eventBtn_1.exitBtn:SetActive(false)
        self.eventBtn_1.confirmBtn:SetActive(true)
        self.eventBtn_1.confirmBtn.canvasGroup:DOFade(1, 0.2)
        self.eventBtn_1.confirmBtn.scaleButton.onClick:RemoveAllListeners()
        self.eventBtn_1.confirmBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            local oldHeroData = Me:getPlayerHero(self.id)
            local oldLevel = oldHeroData and oldHeroData.affectionLevel or 0
            local oldExp = oldHeroData and oldHeroData.affectionExp or 0
            Me:delegateEventFinishReq({ id = self.eventId }, function(data)
                GameMsgMgr:sendEvent(GameMsgType.RefreshEventMsg)
                local newHeroData = Me:getPlayerHero(self.id)
                local newLevel = newHeroData and newHeroData.affectionLevel or oldLevel
                local newExp = newHeroData and newHeroData.affectionExp or oldExp
                local affectionChanged = (newLevel ~= oldLevel) or (newExp ~= oldExp)
                local doFinish = function()
                    UIMgr:closeUI(self)
                    local itemRewards = {}
                    if data.rewardList then
                        for _, r in ipairs(data.rewardList) do
                            if r.type ~= GE.RewardType.Affection then
                                table.insert(itemRewards, r)
                            end
                        end
                    end
                    if #itemRewards > 0 then
                        Me:ReceiveReward(itemRewards)
                    end
                end
                if affectionChanged then
                    self:playAffectionAnim(oldLevel, oldExp, newLevel, newExp, doFinish)
                else
                    doFinish()
                end
            end)
        end)
    else
        --委托未完成，显示红色退出按钮
        self.eventBtn_1.confirmBtn:SetActive(false)
        self.eventBtn_1.exitBtn:SetActive(true)
        self.eventBtn_1.exitBtn.canvasGroup:DOFade(1, 0.2)
        self.eventBtn_1.exitBtn.scaleButton.onClick:RemoveAllListeners()
        self.eventBtn_1.exitBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            UIMgr:closeUI(self)
        end)
    end
end

--重置按钮位置
function AffectionEventPanel:resetBtnPos()
    for i = 1, 3 do
        self["eventBtn_" .. i].scaleButton.interactable = true
        self["eventBtn_" .. i].canvasGroup.alpha = 1
        local targetPosition = self["pos_" .. i].transform.position
        self["eventBtn_" .. i].transform.position = targetPosition -- 直接设置位置
        self["eventBtn_" .. i].confirmBtn.canvasGroup.alpha = 0
        self["eventBtn_" .. i].confirmBtn:SetActive(false)
        self["eventBtn_" .. i].exitBtn.canvasGroup.alpha = 0
        self["eventBtn_" .. i].exitBtn:SetActive(false)
    end
    self.affectionLevelUp:SetActive(false)
    self.affectionLevelUp.canvasGroup.alpha = 0
end

--发送协议
---@param index integer  选项索引
---@param onAnimComplete function 好感度动画播放完成后的回调
function AffectionEventPanel:sendReq(index, onAnimComplete)
    -- 记录请求前的好感度数据
    local oldHeroData = Me:getPlayerHero(self.id)
    local oldLevel = oldHeroData and oldHeroData.affectionLevel or 0
    local oldExp = oldHeroData and oldHeroData.affectionExp or 0
    Me:acceptAffectionEventReq({ id = self.eventId, selectIndex = index }, function(data)
        self["eventBtn_" .. index].scaleButton.onClick:RemoveAllListeners()
        GameMsgMgr:sendEvent(GameMsgType.RefreshEventMsg)
        -- 获取请求后的最新好感度数据
        local newHeroData = Me:getPlayerHero(self.id)
        local newLevel = newHeroData and newHeroData.affectionLevel or oldLevel
        local newExp = newHeroData and newHeroData.affectionExp or oldExp
        -- 播放好感度动画，动画结束后执行回调并下发物品奖励
        local affectionChanged = (newLevel ~= oldLevel) or (newExp ~= oldExp)
        local doFinish = function()
            if onAnimComplete then onAnimComplete() end
            -- 过滤好感度类型，只下发实际物品奖励
            local itemRewards = {}
            -- LuaLogger.ds("data.rewardList",tablex.dump(data.rewardList))
            if data.rewardList then
                for _, r in ipairs(data.rewardList) do
                    if r.type ~= GE.RewardType.Affection then
                        table.insert(itemRewards, r)
                    end
                end
            end
            if #itemRewards > 0 then
                Me:ReceiveReward(itemRewards)
            end
        end
        if affectionChanged then
            self:playAffectionAnim(oldLevel, oldExp, newLevel, newExp, doFinish)
        else
            doFinish()
        end
    end)
end

--播放好感度进度动画
---@param oldLevel integer 动画前好感度等级
---@param oldExp integer   动画前好感度经验
---@param newLevel integer 动画后好感度等级
---@param newExp integer   动画后好感度经验
---@param onComplete function 动画播放完成回调
---@param heroId integer|nil 目标角色id（默认self.id，预留多角色扩展）
function AffectionEventPanel:playAffectionAnim(oldLevel, oldExp, newLevel, newExp, onComplete, heroId)
    self.affectionLevelUp:SetActive(true)
    self.affectionLevelUp.effect:SetActive(false)
    local DOGetter = DG.Tweening.Core.DOGetter_int
    local DOSetter = DG.Tweening.Core.DOSetter_int
   

    if self.level_seq ~= nil then
        self.level_seq:Kill()
        self.level_seq = nil
    end
    local seq = DOTween.Sequence()
    local cg = self.affectionLevelUp.canvasGroup
    cg.alpha = 0
    local tween = cg:DOFade(1, 0.2)
    seq:Append(tween)

    for i = oldLevel, newLevel do
        local newLevelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.affection, i)

        local sv = 0
        if i == oldLevel then
            sv = oldExp
        end
        local maxVal = newLevelData.exp
        local ev = maxVal
        if i == newLevel then
           ev = newExp 
        end
        local time = ((ev - sv) / maxVal) * 0.5
        local v = 0
        local tween = DOTween.To(DOGetter(function()
            return v
        end), DOSetter(function(x)
            v = x
            self.affectionExpTxt.text.text = x .. "/" .. maxVal
            self.affectionExp.image.material:SetFloat("_FillAmount", x/maxVal)
        end), ev, time)
        tween:OnStart(function()
            self.affectionLevelTxt.text.text = tostring(i)
            if i ~= oldLevel then
                self.affectionLevelUp.effect:SetActive(true)
            end
        end)
        tween:OnComplete(function()
            self.affectionLevelUp.effect:SetActive(false)
        end)
        tween:SetEase(DG.Tweening.Ease.Linear)
        seq:Append(tween)
    end

    seq:OnComplete(function()
        self.level_seq = nil
        if onComplete ~= nil then
            onComplete()
        end
    end)
    self.level_seq = seq
end

--进度条填充动画辅助方法
---@param from number 起始填充值 [0,1]
---@param to number   目标填充值 [0,1]
---@param duration number 动画时长（秒）
---@param onComplete function 完成回调
function AffectionEventPanel:_animFill(from, to, duration, onComplete)
    local step = 0.02
    local times = math.ceil(duration / step)
    local elapsed = 0
    self.affectionExp.image.material:SetFloat("_FillAmount", from)
    DLuaTimer:DoRepeat(step, times, function()
        elapsed = elapsed + step
        local t = math.min(elapsed / duration, 1.0)
        self.affectionExp.image.material:SetFloat("_FillAmount", from + (to - from) * t)
    end)
    DLuaTimer:DoAfter(duration + step, function()
        self.affectionExp.image.material:SetFloat("_FillAmount", to)
        if onComplete then onComplete() end
    end)
end

function AffectionEventPanel:OnClose(initiative)
    if initiative then
        self:resetBtnPos()
    end
end

function AffectionEventPanel:OnDestroy()
	if self.level_seq ~= nil then
        self.level_seq:Kill()
        self.level_seq = nil
    end

    if self.open_seq ~= nil then
       self.open_seq:Kill()
       self.open_seq = nil 
    end
    if self.btn_seq ~= nil then
        self.btn_seq:Kill()
        self.btn_seq = nil 
    end

    self.super:OnDestroy(self)
end

--function AffectionEventPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick
--]]
function AffectionEventPanel:mask_Button_onClick(mask)
    self:play2DSound(self.btnSoundPath)
    UIMgr:closeUI(self)
end

function AffectionEventPanel:PlayEffect()

    local tmp = self.eventMsgTxt.text
    tmp:ForceMeshUpdate()
    local totalChars = tmp:GetCharacterCount()
    tmp.maxVisibleCharacters = 0
    -- 以配置的选项数量为准，避免依赖 activeSelf 导致未配置选项被重新显示
    local optionCount = self.optionCount or 0
    if optionCount > 3 then
        optionCount = 3
    end
    for i = 1, 3 do
        ---@type AffectionEventPanel_Generate_eventBtn_1
        local btn = self["eventBtn_" .. i]
        btn:SetActive(false)
    end
    if self.open_seq ~= nil then
       self.open_seq:Kill()
       self.open_seq = nil 
    end
    local seq = DOTween.Sequence()
    local rTrs = self.dialogueInfo.rectTransform
    rTrs.localScale = Vector3.zero
    local tween = rTrs:DOScale(1, 0.2)
    seq:Append(tween)

    local DOGetter = DG.Tweening.Core.DOGetter_int
    local DOSetter = DG.Tweening.Core.DOSetter_int
    local tween = DOTween.To(DOGetter(function()
            return tmp.maxVisibleCharacters
        end), DOSetter(function(x)
            tmp.maxVisibleCharacters = x
        end), totalChars, 0.5)
    tween:OnComplete(function()
        tmp.maxVisibleCharacters = 99999
    end)
    tween:SetEase(DG.Tweening.Ease.Linear)
    seq:Append(tween)

    local sub_seq = DOTween.Sequence()
    for i = 1, optionCount do
        ---@type AffectionEventPanel_Generate_eventBtn_1
        local btn = self["eventBtn_" .. i]
        ---@type UnityEngine.RectTransform
        local trs = btn.transform
        local pos = trs.anchoredPosition
        pos.x = 100
        trs.anchoredPosition = pos
        local tween = trs:DOAnchorPosX(0, 0.5)
        tween:OnStart(function()
            btn:SetActive(true)
        end)
        sub_seq:Insert((i-1)*0.1, tween)
    end
    seq:Append(sub_seq)
    seq:OnComplete(function()
        self.open_seq = nil
    end)
    self.open_seq = seq
end

return AffectionEventPanel
