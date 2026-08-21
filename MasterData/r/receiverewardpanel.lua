---@class ReceiveRewardPanel : ReceiveRewardPanel_Generate
---##################### 【ReceiveRewardPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ReceiveRewardPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ReceiveRewardPanel = require "ReceiveRewardPanel_Generate"

function ReceiveRewardPanel:InitLogic(data)
   self.rewardList = {}
    local canvas = self.gameObject:GetOrAddComponent(TypeInfo.Canvas)
    canvas.overrideSorting = true
    canvas.sortingLayerName = "UI"
end

--function ReceiveRewardPanel:StartCreating(time)
--
--end

--function ReceiveRewardPanel:StartEnter(time)
--
--end

--function ReceiveRewardPanel:StartRemoving(time)
--
--end

--function ReceiveRewardPanel:StartExit(time)
--
--end

function ReceiveRewardPanel:OnOpen(data, initiative)
    self.rewardList = data.rewardList or {}
    self.closeFunc = data.closeFunc
    self:SetView()
    self:SetPostProcessing()

    local btnSoundPath = string.format(Config.AudioPath.SE, "pointsuccess")
    self:play2DSound(btnSoundPath)

end

function ReceiveRewardPanel:SetView()
    local boxCount = tablex.size(self.rewardList)
    if boxCount <= 10 then
        self.content.transform.pivot = Vector2.New(0.5, 0.5)
    else
        self.content.transform.pivot = Vector2.New(0.5, 1)
    end
    ---@type CustomBox[]
    self.customBoxs = {}
    self:FillTemplateContent(self.customBox, self.content, boxCount, function(index, itemObj)
        local customBox = itemObj.customBox
        local rewardData = self.rewardList[index]

        customBox:setMono(self)
        customBox:SetUIData(rewardData, {showItemName = true})

        customBox.rectTransform.localScale = Vector3.zero
        self.customBoxs[index] = customBox
    end, function()
        self:PlayEffect()
    end)
end

--刷新格子信息
---@param customBox UnityEngine.GameObject  通用格子
---@param customData table  通用格子的信息
---@param typeIndex integer 通用格子的类型
---@param rewardId integer  通用格子的ID
function ReceiveRewardPanel:refreshBoxStata(customBox, customData, typeIndex, rewardId)
    local serverData = nil
    if typeIndex == GE.RewardType.Weapon then
        serverData = Me:getWeaponDataById(rewardId)
    elseif typeIndex == GE.RewardType.Equipment then
        serverData = Me:getEquipDataByid(rewardId)
    end
    customData.isLock = serverData.isLock
    customBox:setMono(self)
    customBox:refreshUI(customData)
end

--设置相机的后处理
function ReceiveRewardPanel:SetPostProcessing()
    --特效相关
    --local UICamera = UIMgr.uiCamera
    --
    --local cameraData = UICamera:GetComponent(typeof(UnityEngine.Rendering.Universal.UniversalAdditionalCameraData))
    --if cameraData then
    --    cameraData.renderPostProcessing = true                      --后处理
    --    cameraData.volumeTrigger = self.uiVolume.transform          --特效触发器
    --    cameraData.volumeLayerMask = LayerMask.GetMask("UI")            --默认层和UI层
    --end
end

--function ReceiveRewardPanel:OnClose(initiative)
--
--end

function ReceiveRewardPanel:OnDestroy()
	if self.seq ~= nil then
        
        self.seq:Kill()
        self.seq = nil
    end
    self.super:OnDestroy(self)
end

--function ReceiveRewardPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function ReceiveRewardPanel:mask_Button_onClick(mask)
    if self.isPlaying == true or self.isPlaying == nil then
       return 
    end
    self.mask.button.interactable = false
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeCurrentUI(self)
        self.mask.button.interactable = true
        if self.closeFunc then
            self.closeFunc()
            self.closeFunc = nil
        end
    end)
end

--[[
/ItemBox onClick 
--]]
function ReceiveRewardPanel:itemBox_ScaleButton_onClick(itemBox)

end

function ReceiveRewardPanel:PlayEffect()
    self.isPlaying = true
    self.blueBg.canvasGroup.blocksRaycasts = false
    self.blueBg.canvasGroup.interactable = false
    self.tipsText:SetActive(false)
    self.content.rectTransform.anchoredPosition = Vector3.zero
    local seq = DOTween.Sequence()

    local viewHeight = self.scrollView.rectTransform.rect.height
    local top = self.content.gridLayoutGroup.padding.top
    local bottom = self.content.gridLayoutGroup.padding.bottom
    local itemHeight = self.content.gridLayoutGroup.cellSize.y
    local spacingX = self.content.gridLayoutGroup.spacing.y
    local lenCount = 5
    local subSeq = DOTween.Sequence()
    for i = 1, #self.customBoxs do
        local index = i
        local customBox = self.customBoxs[i]
        local trs = customBox.rectTransform
        local tween = trs:DOScale(1, 0.5)
        tween:SetEase(DG.Tweening.Ease.OutBack)
        tween:OnStart(function()
            trs.gameObject:SetActive(true)
            customBox:ShowEffect() 
            local rowIndex = math.floor((index-1) / lenCount) + 1

            local contentBottomPos = rowIndex * (itemHeight + spacingX) -spacingX + bottom + top - viewHeight
            contentBottomPos = math.max(0, contentBottomPos)

            UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.content.rectTransform)
            UnityEngine.Canvas.ForceUpdateCanvases()
            if (index - 1) % lenCount == 0 and contentBottomPos ~= 0 then  
                local tween = self.content.rectTransform:DOAnchorPosY(contentBottomPos, 0.2)
                tween:SetEase(DG.Tweening.Ease.OutQuad)
            end
        end)
        subSeq:Insert((i-1)*0.1, tween) 
    end
    seq:AppendInterval(0.5)
    seq:Append(subSeq)
    seq:OnComplete(function()
        self.blueBg.canvasGroup.blocksRaycasts = true
        self.blueBg.canvasGroup.interactable = true
        self.tipsText:SetActive(true)
        self.isPlaying = false
        self.seq = nil
    end)
    self.seq = seq
end

return ReceiveRewardPanel
