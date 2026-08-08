---@class RepeatRewardPanel : RepeatRewardPanel_Generate
---##################### 【RepeatRewardPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【RepeatRewardPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local RepeatRewardPanel = require "RepeatRewardPanel_Generate"

function RepeatRewardPanel:InitLogic(data)

end

function RepeatRewardPanel:InitPanel()

    self:setSingleLevelReward()
    self:setAllRewardData()

    self.allReward.gameObject:SetActive(false)
    --self:setLayer()

    self.quickAnimaBtn.clickListener.onClickEvent = BindSelf(self, self.OnQuickAnimaBtnClick)
end

--function RepeatRewardPanel:StartCreating(time)
--
--end

--function RepeatRewardPanel:StartEnter(time)
--
--end

--function RepeatRewardPanel:StartRemoving(time)
--
--end

--function RepeatRewardPanel:StartExit(time)
--
--end

function RepeatRewardPanel:setLayer()
    for i = 1, 4 do
        self["image"..i].canvas.sortingLayerName = "UI"
        self["image"..i].canvas.sortingOrder = 10
    end
    self.customMsgPanel.customMsgPanel.canvas.sortingOrder = 11
    self.customMsgPanel.customMsgPanel.canvas.sortingLayerName = "UI"
end

function RepeatRewardPanel:OnOpen(data, initiative)
    self.levelId = data and data.levelId
    self.repeatNum = data and data.repeatNum
    self.rewardList = data and data.rewardList
    self.singleList = data and data.singleList
    self.extraRewardList = data and data.extraRewardList
    self.extraSingleList = data and data.extraSingleList
    self.loadProgress = {false, false}
    self:InitPanel()
end

--设置所有奖励数据
function RepeatRewardPanel:setAllRewardData()
    self.levelConfig = Config.GetPveLevelInfo(self.levelId)
    self.levelNameText.text.text = self.levelConfig.nameKey

    -- 玩家等级显示
    local userLevel = Me:getUserLevel()
    self.levelText.text.text = userLevel
    self.addExpText.text.text = "EXP+" .. (self.levelConfig.userExp * self.repeatNum)
    local levelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.user, userLevel)
    local nowExp = Me:getUserEXP() - levelData.exp_sum
    --等级已满特殊显示
    if levelData.max_level == Me:getUserLevel() and Me:getUserEXP() >= levelData.exp_sum then
        self.nowExpText.text.text = "已达上限"
        self.expSlider.slider.value = 0
    else
        self.nowExpText.text.text = nowExp.."/"..levelData.exp
        self.expSlider.slider.value = (nowExp - (self.levelConfig.userExp * self.repeatNum)) / levelData.exp
        self.expSlider.slider:DOValue(nowExp / levelData.exp, 1)
    end

    -- 总奖励显示
    local minNum = 0
    local extraExtraList = self.extraRewardList and clone(self.extraRewardList) or {}
    for _, rewardData in ipairs(extraExtraList) do
        rewardData.tipsText = LocalStrEnum.PveExtraRewardTag
        rewardData.isFrist = true
    end
    local rewardListSize = tablex.size(self.rewardList) + tablex.size(extraExtraList)
    local needRewardList = tablex.combine(self.rewardList, extraExtraList)
    local needBoxNum = math.max(rewardListSize, minNum)

    local allCustomBox = {}
    self:FillTemplateContent(self.customBox, self.allRewardList, needBoxNum, function(index, itemObj)
        local customBox = itemObj.customBox
        local rewardData = needRewardList[index]
        customBox:setMono(self)
        customBox:SetUIData(rewardData,{
            tipsText = rewardData and rewardData.tipsText,
        })
        table.insert(allCustomBox, customBox)
        customBox.gameObject:SetActive(false)
    end, function()
        self.loadProgress[2] = true
        self:CheckAllLoadComplete()
    end)

    self.allCustomBox = allCustomBox
end

--设置单个关卡奖励
function RepeatRewardPanel:setSingleLevelReward()

    ---@type RepeatRewardPanel_Generate_singleRewardBox[]
    local rewardList = {}

    local temp = {}

    self:FillTemplateContent(self.singleRewardBox, self.singleRewardList, self.repeatNum, function(aIndex, rewardBox)
        if aIndex >= 10 then
            rewardBox.countText.text.text = aIndex
        else
            rewardBox.countText.text.text = "0"..aIndex
        end
        local oneRewardList = self.singleList[aIndex].list
        local oneExtraList = {}
        if self.extraSingleList and self.extraSingleList[aIndex] then
            oneExtraList = clone(self.extraSingleList[aIndex].list)
        end
        for _, rewardData in ipairs(oneExtraList) do
            rewardData.tipsText = LocalStrEnum.PveExtraRewardTag
            rewardData.isFrist = true
        end
        local needRewardList = tablex.combine(oneRewardList, oneExtraList)
        self:FillTemplateContent(self.customBox, rewardBox.itemBoxList, #needRewardList, function(index, itemObj)
            local customBox = itemObj.customBox
            local rewardData = needRewardList[index]
            customBox:setMono(self)
            customBox:SetUIData(rewardData,{
                tipsText = rewardData and rewardData.tipsText,
            })
        end, function()
            temp[aIndex] = true
            local allFinish = true
            for i = 1, self.repeatNum do
                if temp[i] == nil then
                    allFinish = false
                   break 
                end
            end
            if allFinish then
                self.loadProgress[1] = true
                self:CheckAllLoadComplete()
            end
        end)
        rewardBox.gameObject:SetActive(false)
        table.insert(rewardList, rewardBox)
    end)
    self.repeateRewardList = rewardList
end

function RepeatRewardPanel:CheckAllLoadComplete()
    for i = 1, #self.loadProgress do
        if not self.loadProgress[i] then
            return
        end
    end
    self:PlayEffect()
end

function RepeatRewardPanel:PlayEffect()

    ---@type RepeatRewardPanel_Generate_singleRewardBox[]
    local rewardList = self.repeateRewardList

    for i = 1, #rewardList do
        local temp = rewardList[i]
        temp.gameObject:SetActive(false)
    end

    ---@type CustomBox[]
    local allCustomBox = self.allCustomBox
    for i = 1, #allCustomBox do
        allCustomBox[i].gameObject:SetActive(false)
    end
    self.allReward.gameObject:SetActive(false)
    self.quickAnimaBtn.gameObject:SetActive(true)

    self.tweens = {}

    local seq = DOTween.Sequence()
    seq:AppendInterval(0.1)
    local defScale = Vector3.zero
    for i = 1, #rewardList do
        local rewardBox = rewardList[i]
        local child = rewardBox.itemBoxList.transform
        local childCount = child.childCount
        seq:AppendCallback(function()
            rewardBox.gameObject:SetActive(true)
            UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.singleRewardList.rectTransform)

            UnityEngine.Canvas.ForceUpdateCanvases()

            local viewSize = self.scrollView.rectTransform.rect.height
            local contentSize = self.singleRewardList.rectTransform.rect.height
            
            local isfull = contentSize > viewSize

            local DOGetter = DG.Tweening.Core.DOGetter_float
            local DOSetter = DG.Tweening.Core.DOSetter_float

            if isfull then
                local sVal = self.scrollView.scrollRect.verticalNormalizedPosition
                local tween = DOTween.To(DOGetter(function()
                        return sVal
                    end), DOSetter(function(x)
                      self.scrollView.scrollRect.verticalNormalizedPosition = x
                    end), 0, 0.5)
                tween:SetEase(DG.Tweening.Ease.OutQuad)
                table.insert(self.tweens, seq)
            else
                self.scrollView.scrollRect.verticalNormalizedPosition = 1
            end
        end)

        for j = 0, childCount - 1, 1 do
            local trs = child:GetChild(j)
            trs.localScale = defScale
            local tween = trs:DOScale(0.75, 0.5)
            tween:SetEase(DG.Tweening.Ease.OutBack)
            --tween:SetDelay(0.1)
            seq:Join(tween)
        end
        seq:AppendInterval(0.1)
    end
    seq:AppendInterval(0.1)
    seq:OnComplete(function()
        self.seq1 = nil
        self.seq2:Play()
    end)
    self.seq1 = seq
    
    local seq = DOTween.Sequence()
    seq:AppendInterval(0.1)
    local trs = self.allReward.rectTransform
    self.allReward.gameObject:SetActive(true)
    self.oKBtn.gameObject:SetActive(false)
    trs.localScale = Vector3.New(0, 1, 1)
    local tween = trs:DOScale(Vector3.one, 0.2)
    seq:AppendInterval(0.1)
    seq:Append(tween)
    seq:AppendInterval(0.5)
    for i = 1, #allCustomBox do
        local customBox = allCustomBox[i]
        local trs = customBox.rectTransform
        trs.localScale = defScale
        local tween = trs:DOScale(0.75, 0.5)
        tween:SetEase(DG.Tweening.Ease.OutBack)
        tween:OnStart(function()
            trs.gameObject:SetActive(true)
        
            customBox:ShowEffect() 
            UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.allRewardList.rectTransform)
            UnityEngine.Canvas.ForceUpdateCanvases()
            local viewSize = self.scrollView2.rectTransform.rect.width
            local contentSize = self.allRewardList.rectTransform.rect.width
            
            local isfull = contentSize > viewSize

            local DOGetter = DG.Tweening.Core.DOGetter_float
            local DOSetter = DG.Tweening.Core.DOSetter_float

            if isfull then
                local sVal = self.scrollView2.scrollRect.horizontalNormalizedPosition
                local tween = DOTween.To(DOGetter(function()
                        return sVal
                    end), DOSetter(function(x)
                      self.scrollView2.scrollRect.horizontalNormalizedPosition = x
                    end), 1, 0.2)
                tween:SetEase(DG.Tweening.Ease.OutQuad)
                table.insert(self.tweens, seq)
            else
                self.scrollView2.scrollRect.horizontalNormalizedPosition = 0
            end
        end)
        tween:SetDelay(0.1)
        seq:Join(tween)
    end
    local trs = self.oKBtn.gameObject.transform
    trs.localScale = Vector3.one * 2
    local tween = trs:DOScale(1, 0.2)
    tween:SetEase(DG.Tweening.Ease.OutBack)
    tween:OnStart(function()
        trs.gameObject:SetActive(true)
    end)
    seq:Append(tween)
    seq:OnComplete(function()
        self.quickAnimaBtn.gameObject:SetActive(false)
        self.seq2 = nil
    end)
    seq:Pause()
    ---@type DG.Tweening.Sequence
    self.seq2 = seq
end

---@param data CustomMsgData
function RepeatRewardPanel:OpenCustomMsgPanel(data)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.customMsgPanel:SetActive(true)
    self.customMsgPanel.customMsgPanel:setMono(self)
    self.customMsgPanel.customMsgPanel:SetView(data)
end

--刷新格子信息
---@param customBox UnityEngine.GameObject  通用格子
---@param customData table  通用格子的信息
---@param typeIndex integer 通用格子的类型
---@param rewardId integer  通用格子的ID
function RepeatRewardPanel:refreshBoxStata(customBox, customData, typeIndex, rewardId)
    local serverData = nil
    if typeIndex == GE.RewardType.Weapon then
        serverData = Me:getWeaponDataById(rewardId)
    elseif typeIndex == GE.RewardType.Equipment then
        serverData = Me:getEquipDataByid(rewardId)
    end
    customData.isLock = serverData.isLock
    customBox:refreshUI(customData)
end

function RepeatRewardPanel:OnQuickAnimaBtnClick()
    if self.seq1 ~= nil then
        self.seq1:Complete(true)
        self.seq1 = nil
        return
    end

    if self.seq2 ~= nil then
       self.seq2:Complete(true)
       self.seq2 = nil
       self.quickAnimaBtn.gameObject:SetActive(false)
    end
end

function RepeatRewardPanel:OnDestroy()
	if self.tweens ~= nil then
        for i = 1, #self.tweens do
            self.tweens[i]:Kill()
        end
        self.tweens = nil
    end

    if self.seq1 ~= nil then
       self.seq1:Kill()
    end
    if self.seq2 ~= nil then
       self.seq2:Kill()
    end
    self.super:OnDestroy(self)
end

--function RepeatRewardPanel:OnRefresh(data)
--
--end

--[[
/OKBtn onClick 
--]]
function RepeatRewardPanel:OnClose(initiative)
    UIMgr:endDepositToast(GE.DepositToastType.BattleRepeat)
end

function RepeatRewardPanel:oKBtn_ScaleButton_onClick(oKBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    UIMgr:closeSpecificUI(self)
end

return RepeatRewardPanel
