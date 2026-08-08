---@class LevelDetailPanel : LevelDetailPanel_Generate
---##################### 【LevelDetailPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【LevelDetailPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local LevelDetailPanel = require "LevelDetailPanel_Generate"

function LevelDetailPanel:InitLogic(data)
    self.showLevelId = 0
end

function LevelDetailPanel:InitPanel()
    self:setLevelData()
end

--function LevelDetailPanel:StartCreating(time)
--
--end

--function LevelDetailPanel:StartEnter(time)
--
--end

--function LevelDetailPanel:StartRemoving(time)
--
--end

--function LevelDetailPanel:StartExit(time)
--
--end

function LevelDetailPanel:OnOpen(data, initiative)
    if initiative then
        self.showLevelId = data and data.levelId
        self:setLevelData()
    end
end

function LevelDetailPanel:setLevelData()
    local levelConfig = Config.GetPveLevelInfo(self.showLevelId)
    local levelData = Me:getLevelDataByid(self.showLevelId)
    local isFinishList = {}
    for _, v in pairs(levelData and levelData.achieveList or {}) do
        isFinishList[v] = 1
    end
    local achieveList = levelConfig.achieve
    self:FillTemplateContent(self.achBox, self.achievementList, #achieveList, function (index,achBox)
        local achieveId = achieveList[index]
        achBox.achievementDesc.text.text = achieveId
        achBox.isComplete:SetActive(isFinishList[achieveId])
    end)
    LuaLogger.ds("!!!^^^^!!!!", tablex.dump(achieveList))
end

--function LevelDetailPanel:OnClose(initiative)
--
--end

--function LevelDetailPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function LevelDetailPanel:OnRefresh(data)
--
--end

--[[
/CloseBgBtn onClick 
--]]
function LevelDetailPanel:closeBgBtn_Button_onClick(closeBgBtn)
    UIMgr:closeUI(self)
end

--[[
/DetailBg/CloseBtn onClick 
--]]
function LevelDetailPanel:closeBtn_ScaleButton_onClick(closeBtn)
    UIMgr:closeUI(self)
end

--[[
/DetailBg/EnemyToggle onValueChanged 
--]]
function LevelDetailPanel:enemyToggle_Toggle_onValueChanged(enemyToggle,isOn)
    self.achievementToggle.toggle.isOn = not isOn
    self.enemyData:SetActive(isOn)
end

--[[
/DetailBg/AchievementToggle onValueChanged 
--]]
function LevelDetailPanel:achievementToggle_Toggle_onValueChanged(achievementToggle,isOn)
    self.enemyToggle.toggle.isOn = not isOn
    self.achievementData:SetActive(isOn)
end

return LevelDetailPanel
