---@class SSRTipsPanel : SSRTipsPanel_Generate
---##################### 【SSRTipsPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SSRTipsPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SSRTipsPanel = require "SSRTipsPanel_Generate"

function SSRTipsPanel:InitLogic(data)
    self.canskip = false
end

--function SSRTipsPanel:StartCreating(time)
--
--end

--function SSRTipsPanel:StartEnter(time)
--
--end

--function SSRTipsPanel:StartRemoving(time)
--
--end

--function SSRTipsPanel:StartExit(time)
--
--end

function SSRTipsPanel:OnOpen(data, initiative)
    self.nowRoleId = data.roleId
    self.closeFunc = data.closeFunc
    self.resultData = data.resultData
    self.animOverCallBack:SetCallBackOfName(function(name)
        if name == "Finish" then
            self.ui_Effect_ChouKaZhenYing:SetActive(true)
            DLuaTimer:DoAfter(1.5, function()
                self.closeFunc()
                UIMgr:closeSpecificUI(self)
            end)
        end
    end)
    self:SetUIVolume()
    self:setRoleNation()
end

--所属国家显示
function SSRTipsPanel:setRoleNation()
    local roleConfig = Config.GetCharacterInfo(self.nowRoleId)
    if not roleConfig then
        return
    end
    local roleNation = roleConfig.nation
    self["biao"..roleNation]:SetActive(true)
    self.animator:SetTrigger("ShowNation")
end

--设置相机的后处理
function SSRTipsPanel:SetUIVolume()
    --特效相关
    --local UICamera = UIMgr.uiCamera
    --local cameraData = UICamera:GetComponent(typeof(UnityEngine.Rendering.Universal.UniversalAdditionalCameraData))
    --if cameraData then
    --    cameraData.renderPostProcessing = true                      --后处理
    --    cameraData.volumeTrigger = self.uiVolume.transform          --特效触发器
    --    cameraData.volumeLayerMask = LayerMask.GetMask("UI")            --默认层和UI层
    --end
end

--function SSRTipsPanel:OnClose(initiative)
--
--end

--function SSRTipsPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function SSRTipsPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function SSRTipsPanel:mask_Button_onClick(mask)
    if self.canskip then
        self.closeFunc()
        UIMgr:closeSpecificUI(self)
    end
end

return SSRTipsPanel
