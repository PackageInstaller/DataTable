---@class UIQuickSwitchPanel : UIQuickSwitchPanel_Generate
---##################### 【UIQuickSwitchPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【UIQuickSwitchPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local UIQuickSwitchPanel = require "UIQuickSwitchPanel_Generate"

function UIQuickSwitchPanel:InitLogic(data)

end

--function UIQuickSwitchPanel:StartCreating(time)
--
--end

--function UIQuickSwitchPanel:StartEnter(time)
--
--end

--function UIQuickSwitchPanel:StartRemoving(time)
--
--end

--function UIQuickSwitchPanel:StartExit(time)
--
--end

function UIQuickSwitchPanel:OnOpen(data, initiative)
    -- LuaLogger.ds("UIQuickSwitchPanel:OnOpen", data.callBack)
    local canvas = self.gameObject:GetOrAddComponent(TypeInfo.Canvas)
    canvas.overrideSorting = true
    canvas.sortingLayerName = "UI"
    self.animator.enabled = true
    self.animator:SetTrigger("In")
    self.animOverCallBack:SetCallBack(function()
        -- LuaLogger.ds("UIQuickSwitchPanel:OnOpen animOverCallBack")
        if data.callBack then
            data.callBack()
        end
    end)
end

--function UIQuickSwitchPanel:OnClose(initiative)
--
--end

--function UIQuickSwitchPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function UIQuickSwitchPanel:OnRefresh(data)
--
--end

--加载结束 外部调用
function UIQuickSwitchPanel:PlayOverAnim(callBack)
    --LuaLogger.ds("UIQuickSwitchPanel:PlayOverAnim", callBack)
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBackOfName(function(name)
        --LuaLogger.ds("UIQuickSwitchPanel:PlayOverAnim animOverCallBack")
        if name == "OutCallback" then
            if callBack then
                callBack()
            end
            UIMgr:closeLoadingUI(self)
        end
    end)
end

return UIQuickSwitchPanel
