---@class SeaMapScenesPanel : SeaMapScenesPanel_Generate
---##################### 【SeaMapScenesPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SeaMapScenesPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SeaMapScenesPanel = require "SeaMapScenesPanel_Generate"

function SeaMapScenesPanel:InitLogic(data)

end

--function SeaMapScenesPanel:StartCreating(time)
--
--end

--function SeaMapScenesPanel:StartEnter(time)
--
--end

--function SeaMapScenesPanel:StartRemoving(time)
--
--end

--function SeaMapScenesPanel:StartExit(time)
--
--end

--function SeaMapScenesPanel:OnOpen(data, initiative)
--
--end

--function SeaMapScenesPanel:OnClose(initiative)
--
--end

--function SeaMapScenesPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function SeaMapScenesPanel:OnRefresh(data)
--
--end

--[[
/ImgBg onClick 
--]]
function SeaMapScenesPanel:imgBg_Button_onClick(imgBg)

end

--[[
/img onClick 
--]]
function SeaMapScenesPanel:img_Button_onClick(img)

end

--[[
/backBtn onClick 
--]]
function SeaMapScenesPanel:backBtn_ScaleButton_onClick(backBtn)
    StateMgr:ChangeToState(GameFlowState.GameState)
    UIMgr:closeUI(self)
end

return SeaMapScenesPanel
