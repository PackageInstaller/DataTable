---@class SkillRangePanel : SkillRangePanel_Generate
---##################### 【SkillRangePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SkillRangePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SkillRangePanel = require "SkillRangePanel_Generate"

function SkillRangePanel:InitLogic(data)
    self.bg.pointerListener.onPointerClickEvent = function ()
        UIMgr:closeUI(self)
    end
    self.bg.pointerListener.onPointerDownEvent = function ()
        self.skillRangeBox:SetActive(false)
    end
end

function SkillRangePanel:InitPanel()
    self:_CreateHasCatCell()
end

--设置技能范围格子
function SkillRangePanel:_CreateHasCatCell()
    local skillRange = Config.GetSkillRangeShowInfo(self.linkID)
    self:FillTemplateContent(self.rangeBox, self.rangeBoxList, 30, function (index,rangeBox)
        local defaultParam = skillRange.DefaultParam
        local rangeType = defaultParam[index]
        local isShow = rangeType == 1
        local isCenter = rangeType == 2
        --范围图标
        if isShow or isCenter then
            local rangePath = Config.SpritePath.SkillRangeIcon
            local iconPath = string.format(rangePath, rangeType)
            self:LoadSpriteAsync(iconPath, rangeBox.image)
        end

        rangeBox.image.enabled = isShow or isCenter
    end)

    self.skillRangeBox.transform.localPosition = Vector3.New(self.boxPos.x, self.boxPos.y, 0)
end

--function SkillRangePanel:StartCreating(time)
--
--end

--function SkillRangePanel:StartEnter(time)
--
--end

--function SkillRangePanel:StartRemoving(time)
--
--end

--function SkillRangePanel:StartExit(time)
--
--end

function SkillRangePanel:OnOpen(data, initiative)
    if initiative then
        self.linkID = data and tonumber(data.linkID) or 0
        self.boxPos = data and data.boxPos or Vector3.New(0, 0, 0)
        self:InitPanel()
    end
end

--function SkillRangePanel:OnClose(initiative)
--
--end

--function SkillRangePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function SkillRangePanel:OnRefresh(data)
--
--end

return SkillRangePanel
