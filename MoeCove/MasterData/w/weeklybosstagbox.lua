---@class WeeklyBossTagBox : WeeklyBossTagBox_Generate
---##################### 【WeeklyBossTagBox Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【WeeklyBossTagBox Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local WeeklyBossTagBox = require "WeeklyBossTagBox_Generate"

---@class TagBoxData
---@field defaultDesc string? 默认描述文本枚举
---@field isSelected boolean? 是否选中
---@field tagId integer 标签id
---@field clickFunc function? 点击回调函数
---@field isActive boolean? 是否符合激活条件

function WeeklyBossTagBox:InitLogic(data)

end

--危境攻坚标签格子通用逻辑
---@param boxData TagBoxData
function WeeklyBossTagBox:setTagBoxData(boxData)
    self.defaultDesc = boxData.defaultDesc
    local isSelected = boxData.isSelected or false
    self.isSelect:SetActive(isSelected)
    local tagId = boxData.tagId
    self:setTagBoxDataById(tagId)
    local clickFunc = boxData.clickFunc
    self.scaleButton.onClick:RemoveAllListeners()
    self.scaleButton.onClick:AddListener(function()
        if clickFunc then
            clickFunc()
        end
    end)
    if boxData.isActive ~= nil then
        self.notMeetRequirement:SetActive(not boxData.isActive)
        self.notMeetRequirementTag:SetActive(not boxData.isActive)
    end
end

--根据tagId设置数据
function WeeklyBossTagBox:setTagBoxDataById(tagId)
    self.haveSelectTag:SetActive(tagId ~= nil)
    self.notSelectTag:SetActive(not tagId and true or false)
    if tagId and tagId ~= 0 then
        local tagConfig = Config.GetPveBossBattleEffectInfo(tagId)
        self.tagDesc.text.text = tagConfig.EffectDesc
        self.upTag:SetActive(tagConfig.ScoreAddition > 0)
        local ptcTxt = string.format("%s%%", tostring(tagConfig.ScoreAddition * 100))
        self.upPtc.text.text = "+" .. ptcTxt
        self.downTag:SetActive(tagConfig.ScoreAddition < 0)
        self.downPtc.text.text = ptcTxt
    else
        self.upTag:SetActive(false)
        self.downTag:SetActive(false)
        self.tipsText.text.text = LocalStrEnum.BossBattleEffectSelect
        self.typeText.text.text = self.defaultDesc and LocalStrEnum[self.defaultDesc] or ""
    end
    DLuaTimer:DoAfter(0.01, function()
        if self.tagDesc.text.textBounds.size.y > 40 then
            self.tagDesc.rectTransform.anchoredPosition = Vector2.New(0, -5)
            self.tagDesc.text.alignment = TMPro.TextAlignmentOptions.Left
        else
            self.tagDesc.rectTransform.anchoredPosition = Vector2.New(0, 0)
            self.tagDesc.text.alignment = TMPro.TextAlignmentOptions.Center
        end
    end)
end

--危境攻坚标签格子刷新方法
function WeeklyBossTagBox:refreshTagBoxData(tagId)
    self:setTagBoxDataById(tagId)
end

--刷新选中状态方法
function WeeklyBossTagBox:refreshSelectState(isSelected)
    self.isSelect:SetActive(isSelected)
end

--显示特殊取消选中格子样式
---comment
---@param clickFunc function
function WeeklyBossTagBox:showCancelSelectBox(clickFunc)
    self.emptyTag:SetActive(true)
    self.emptyText.text.text = LocalStrEnum.BossBattleEffectEmpty
    self.scaleButton.onClick:RemoveAllListeners()
    self.scaleButton.onClick:AddListener(function()
        if clickFunc then
            clickFunc()
        end
    end)
end

--function WeeklyBossTagBox:OnDestroy()
--	self.super:OnDestroy(self)
--end

return WeeklyBossTagBox
