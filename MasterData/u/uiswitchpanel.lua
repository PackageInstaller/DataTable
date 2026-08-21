---@class UISwitchPanel : UISwitchPanel_Generate
---##################### 【UISwitchPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【UISwitchPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local UISwitchPanel = require "UISwitchPanel_Generate"

function UISwitchPanel:InitLogic(data)

end

--function UISwitchPanel:StartCreating(time)
--
--end

--function UISwitchPanel:StartEnter(time)
--
--end

--function UISwitchPanel:StartRemoving(time)
--
--end

--function UISwitchPanel:StartExit(time)
--
--end

function UISwitchPanel:OnOpen(data, initiative)
    local canvas = self.gameObject:GetOrAddComponent(TypeInfo.Canvas)
    canvas.overrideSorting = true
    canvas.sortingLayerName = "UI"
    -- local dt = 1

    self.animOverCallBack:SetCallBackOfName(function(str)
        if str == "SwitchIn" then
            if data.callBack then
                data.callBack()
            end
        end
    end)
    self.animator.enabled = true
    -- if data and data.isQuick then
        -- self.ef1:SetActive(false)
        -- self.ef2:SetActive(true)
        -- dt = 0.35
        -- self.ef2.effect.particleSystem:Simulate(0)
        -- self.ef2.effect.particleSystem:Play()
        self.animator:SetTrigger("SwitchIn")
    -- else
    --     self.animator:SetTrigger("SwitchIn")
    --     -- self.ef1:SetActive(true)
    --     -- self.ef2:SetActive(false)
    --     -- self.ef1.effect.particleSystem:Simulate(0)
    --     -- self.ef1.effect.particleSystem:Play()
    -- end
    -- DLuaTimer:DoAfter(dt, function()
    --     if data and data.isQuick then
    --         self.ef2.effect.particleSystem:Pause()
    --     else
    --         self.ef1.effect.particleSystem:Pause()
    --     end
    --     if data.callBack then
    --         data.callBack()
    --     end
    -- end)
end

--function UISwitchPanel:OnClose(initiative)
--
--end

--function UISwitchPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function UISwitchPanel:OnRefresh(data)
--
--end

--加载结束 外部调用
function UISwitchPanel:PlayOverAnim(callBack, isQuick)
    -- local dt = 1
    --  if isQuick then
    --     dt = 0.5
    --  end
    -- if self.ef1.activeSelf then
    --     self.ef1.effect.particleSystem:Play()
    -- else
    --     self.ef2.effect.particleSystem:Play()
    -- end
    -- DLuaTimer:DoAfter(dt, function()
    --     if callBack then
    --         callBack()
    --     end
    --     UIMgr:closeLoadingUI(self)
    -- end)
    self.animOverCallBack:SetCallBackOfName(function(str)
        if str == "SwitchOut" then
            if callBack then
                callBack()
            end
            UIMgr:closeLoadingUI(self)
        end
    end)
    self.animator.enabled = true
    -- if isQuick then
        self.animator:SetTrigger("SwitchOut")
    -- else
    --     self.animator:SetTrigger("SwitchOut")
    -- end
end

return UISwitchPanel
