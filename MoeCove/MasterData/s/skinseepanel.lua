---@class SkinSeePanel : SkinSeePanel_Generate
---##################### 【SkinSeePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SkinSeePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SkinSeePanel = require "SkinSeePanel_Generate"

function SkinSeePanel:InitLogic(data)

end

--function SkinSeePanel:StartCreating(time)
--
--end

--function SkinSeePanel:StartEnter(time)
--
--end

--function SkinSeePanel:StartRemoving(time) 
--
--end

--function SkinSeePanel:StartExit(time)
--
--end

function SkinSeePanel:OnOpen(data, initiative)
    self.roleId = data.roleID
    self.skinId = data.skinId
    self.skinConfig = Config.GetCharacterSkinInfo(self.skinId)
    self.customBackPanel.customBackPanel.backMainlBtn:SetActive(false)
    self.customBackPanel.customBackPanel.helpBtn:SetActive(false)
    self.customBackPanel.customBackPanel.resource:SetActive(false)
    self:SetView()
end

function SkinSeePanel:SetView()
    self.scaleVelocity = 0
    local skinConfig = self.skinConfig
    UICommonUtils:ShowRolePicOrSpine(self, self.showCharacter, self.skinId, function(spineObject)
        if UICommonUtils.Checkobj(self.nowShowSpineObj) then
             GameObject.Destroy(self.nowShowSpineObj)
        end
        self.nowShowSpineObj = spineObject
        local offsetY
        if skinConfig.spineKey and skinConfig.spineKey ~= "" then
            offsetY = skinConfig.spineOffset[2]
        else
            offsetY = skinConfig.imgOffset[2]
        end
        self.showCharacter.rectTransform.anchoredPosition = Vector2(0, offsetY)
    end)
    -- local needRate
    -- if skinConfig.spineKey and skinConfig.spineKey ~= "" then
    --     needRate = skinConfig.spineRate
    -- else
    --     needRate = skinConfig.imgRateF
    -- end
    -- self.showCharacter.rectTransform.localScale = Vector2.New(needRate, needRate)
    -- 根据皮肤类型选择正确的初始偏移，避免两次赋值互相覆盖
    
    
end

--function SkinSeePanel:OnClose(initiative)
--
--end

--function SkinSeePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function SkinSeePanel:OnRefresh(data)
--
--end

return SkinSeePanel
