---@class AutoChessMainPanel : AutoChessMainPanel_Generate
---##################### 【AutoChessMainPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【AutoChessMainPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
---@class AutoChessMainPanel : AutoChessMainPanel_Generate
---##################### 【AutoChessMainPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【AutoChessMainPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local AutoChessMainPanel = require "AutoChessMainPanel_Generate"
local AutoChessManager = AutoChessManager.instance()
local AutoChessMap = AutoChessManager.map
local FunType = {

    SetStartPos = 1,
    SetEndPos = 2,
    SetBlock = 3,

}

function AutoChessMainPanel:InitLogic(data)
    self.startPos = {x = 1, y = 1}
    self.endPos =  {x = 6, y = 1}

end

--function AutoChessMainPanel:StartCreating(time)
--
--end

--function AutoChessMainPanel:StartEnter(time)
--
--end

--function AutoChessMainPanel:StartRemoving(time)
--
--end

--function AutoChessMainPanel:StartExit(time)
--
--end

function AutoChessMainPanel:OnOpen(data, initiative)
    self:SetUpdateInterval(0)
end

--function AutoChessMainPanel:OnClose(initiative)
--
--end

--function AutoChessMainPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function AutoChessMainPanel:OnRefresh(data)
--
--end

function AutoChessMainPanel:LateUpdate()
    

            
    if Input.GetMouseButtonDown(0) then
        if EventSystem.current:IsPointerOverGameObject() then
            return
        end
        local mousePos = Input.mousePosition
        self:ExcutePoint(mousePos.x, mousePos.y)
    end

end

--[[
/setStartPos onValueChanged 
--]]
function AutoChessMainPanel:setStartPos_Toggle_onValueChanged(setStartPos,isOn)
    self.funType = FunType.SetStartPos
end

--[[
/setEndPos onValueChanged 
--]]
function AutoChessMainPanel:setEndPos_Toggle_onValueChanged(setEndPos,isOn)
    self.funType = FunType.SetEndPos
end

--[[
/setBlock onValueChanged 
--]]
function AutoChessMainPanel:setBlock_Toggle_onValueChanged(setBlock,isOn)
    self.funType = FunType.SetBlock
end

--[[
/findPathBtn onClick 
--]]
function AutoChessMainPanel:findPathBtn_Button_onClick(findPathBtn)
    local path = AutoChessMap:FindPath(self.startPos.x, self.startPos.y, self.endPos.x, self.endPos.y)
    AutoChessManager:ttt(Vector3.New(self.startPos.x, 0, self.startPos.y),Vector3.New(self.endPos.x, 0, self.endPos.y))
end

function AutoChessMainPanel:ExcutePoint(mouseX, mouseY)

    local mx, my = AutoChessManager:MousePosToWorldPos(mouseX, mouseY)
    LuaLogger.ds("===>>> x:" .. mx .. " y:" .. my)
    local gx, gy = AutoChessManager:WorldPosToGridPos(mx, my)
    if self.funType == 1 then
       self.startPos = {x = gx, y = gy}
    elseif self.funType == FunType.SetEndPos then
        self.endPos = {x = gx, y = gy}
    elseif self.funType == FunType.SetBlock then
        local val = AutoChessMap:GetMapBlockVal(gx, gy)
        if val == nil then
           return 
        end
        if val == 0 then
           val = 1
        else
            val = 0 
        end
        AutoChessMap:SetMapBlockVal(gx, gy, val)
    end

    AutoChessMap:SetSelectMapActive(gx, gy)
end

--[[
/createEntityBtn onClick 
--]]
function AutoChessMainPanel:createEntityBtn_Button_onClick(createEntityBtn)

    local idStr = self.inputField.tMP_InputField.text
    local id = tonumber(idStr)
    if id == nil then
        return
    end

    local curPos = AutoChessMap.selectGrid
    if curPos == nil or curPos.x == 0 then
        return
    end

    local side = curPos.x > 0

    ---@type AutoChessEntityInfo
    local entityInfo = {
        entityType = GE.EntityType.Player,
        id = id,
        uid = AutoChessManager:GetEntityUID(),
        side = 1,
        gridPos = {x = curPos.x, y = curPos.y},
        buffs = {}
    }
    AutoChessManager:CreateEntity(entityInfo)
end

--[[
/grid/saveMapBtn onClick 
--]]
function AutoChessMainPanel:saveMapBtn_Button_onClick(saveMapBtn)
    AutoChessManager:SaveBattleInfo()
end

--[[
/grid/startBattleBtn onClick 
--]]
function AutoChessMainPanel:startBattleBtn_Button_onClick(startBattleBtn)
    AutoChessManager:StartBattle()
end

--[[
/grid/AITextBtn onClick 
--]]
function AutoChessMainPanel:aITextBtn_Button_onClick(aITextBtn)
    AutoChessManager:StartAIBattle()
end



--[[
/grid/LogBtn onClick 
--]]
function AutoChessMainPanel:logBtn_Button_onClick(logBtn)
	local AILog = require("AILog")
	if not AILog.IsEnabled() then
		UICommonUtils.PopToast("AI 日志已关闭（AIConst.ENABLE_AI_LOG）")
		return
	end
	if not AILog.IsRecording() then
		UICommonUtils.PopToast("请先点击 AI 开战后再导出日志")
		return
	end
	local path = require("AIModule").ExportLog()
	if path == nil then
		UICommonUtils.PopToast("日志导出失败")
		LuaLogger.es("[AILog] 中途导出失败")
		return
	end
	LuaLogger.ds(string.format("[AILog] 中途导出 -> %s", path))
	UICommonUtils.PopToast("AI 日志已导出")
end

return AutoChessMainPanel
