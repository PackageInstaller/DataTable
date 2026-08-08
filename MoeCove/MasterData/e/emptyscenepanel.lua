---@class EmptyScenePanel : EmptyScenePanel_Generate
---##################### 【EmptyScenePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【EmptyScenePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local EmptyScenePanel = require "EmptyScenePanel_Generate"

function EmptyScenePanel:InitLogic(data)

    self.returnButton.transform:GetChild(0):GetComponent(TypeInfo.TextMeshProUGUI).text = "继续"
    self.button1.transform:GetChild(0):GetComponent(TypeInfo.TextMeshProUGUI).text = "释放GC"
    self.button2.transform:GetChild(0):GetComponent(TypeInfo.TextMeshProUGUI).text = "重回战斗"
    self.button3.transform:GetChild(0):GetComponent(TypeInfo.TextMeshProUGUI).text = "重回港区"
    self.button4.transform:GetChild(0):GetComponent(TypeInfo.TextMeshProUGUI).text = "快照01"
    self.button5.transform:GetChild(0):GetComponent(TypeInfo.TextMeshProUGUI).text = "快照02并比对"
end

--function EmptyScenePanel:StartCreating(time)
--
--end

--function EmptyScenePanel:StartEnter(time)
--
--end

--function EmptyScenePanel:StartRemoving(time)
--
--end

--function EmptyScenePanel:StartExit(time)
--
--end

--function EmptyScenePanel:OnOpen(data, initiative)
--
--end

--function EmptyScenePanel:OnClose(initiative)
--
--end

--function EmptyScenePanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function EmptyScenePanel:OnRefresh(data)
--
--end

--[[
/Button1 onClick 
--]]
function EmptyScenePanel:button1_Button_onClick(button1)
    print("1111")
    LuaMgr.Instance:ClearMemory()
end

--[[
/Button2 onClick 
--]]
function EmptyScenePanel:button2_Button_onClick(button2)
    print("2222")
    StateMgr:ChangeToState(GameFlowState.BattleState)
end

--[[
/Button3 onClick 
--]]
function EmptyScenePanel:button3_Button_onClick(button3)
    print("3333")
    StateMgr:ChangeToState(GameFlowState.GameState)
end

--[[
/Button4 onClick 
--]]
function EmptyScenePanel:button4_Button_onClick(button4)
    print("4444")
    Shot01()
end

--[[
/Button5 onClick 
--]]
function EmptyScenePanel:button5_Button_onClick(button5)
    print("5555")
    Shot02()
end

--[[
/ReturnButton onClick 
--]]
function EmptyScenePanel:returnButton_Button_onClick(returnButton)
    LuaLogger.ds("EmptyScenePanel:returnButton_Button_onClick")
    local callBack = LoadingMgr._pendingCallback
    local needGalo = LoadingMgr._pendingNeedGalo
    LoadingMgr._pendingCallback = nil
    LoadingMgr._pendingNeedGalo = nil
    UIMgr:popLoadingUI("InterludeLoadingPanel",{call = callBack, needGalo = needGalo})
    -- StateMgr:BackLastState()
    -- if pendingCb then
    --     pendingCb()
    -- end
end

return EmptyScenePanel
