---@class AS06MainPanel : AS06MainPanel_Generate
---##################### 【AS06MainPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【AS06MainPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local AS06MainPanel = require "AS06MainPanel_Generate"

function AS06MainPanel:InitLogic(data)

end

--function AS06MainPanel:StartCreating(time)
--
--end

--function AS06MainPanel:StartEnter(time)
--
--end

--function AS06MainPanel:StartRemoving(time)
--
--end

--function AS06MainPanel:StartExit(time)
--
--end

function AS06MainPanel:OnOpen(data, initiative)
    self:initData(data)
    self:refreshUI()
end

function AS06MainPanel:initData(data)
    self.activityCfgList = {}
    for _, groupId in pairs(data.groupList) do
        local cfgList = Config.GetActivitySecondaryInfoByGroup(groupId)
        if cfgList then
            for _, cfg in pairs(cfgList) do
                local curTime = DLuaUtil.GetGreenwichTime()
                if DLuaUtil.ParseConfigTime(cfg.StartTime) <= curTime and DLuaUtil.ParseConfigTime(cfg.EndTime) >= curTime then
                    table.insert(self.activityCfgList, cfg)
                end
            end
        end
    end
end

function AS06MainPanel:getCfgByType(type)
    for _, cfg in pairs(self.activityCfgList) do
        if cfg.type == type then
            return cfg
        end
    end
end

function AS06MainPanel:refreshUI()
    self.trialCfg = self:getCfgByType(GE.ActivitySecondaryType.Trial)
    self.trialBtn.gameObject:SetActive(self.trialCfg ~= nil)
    self.shopCfg = self:getCfgByType(GE.ActivitySecondaryType.Shop)
    self.shopBtn.gameObject:SetActive(self.shopCfg ~= nil)
    self.taskCfg = self:getCfgByType(GE.ActivitySecondaryType.Task)
    self.taskBtn.gameObject:SetActive(self.taskCfg ~= nil)
    self.levelCfg = self:getCfgByType(GE.ActivitySecondaryType.Level)
    self.goBtn.gameObject:SetActive(self.levelCfg ~= nil)
end

--function AS06MainPanel:OnClose(initiative)
--
--end

--function AS06MainPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function AS06MainPanel:OnRefresh(data)
--
--end

--[[
/AdjustRoot/BattleBtn onClick 
--]]
function AS06MainPanel:battleBtn_ScaleButton_onClick(battleBtn)

end

--[[
/AdjustRoot/SimulateBtn onClick 
--]]
function AS06MainPanel:simulateBtn_ScaleButton_onClick(simulateBtn)

end

--[[
/AdjustRoot/TaskBtn onClick 
--]]
function AS06MainPanel:taskBtn_ScaleButton_onClick(taskBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if not self.taskCfg then return end
    UIMgr:popUI("ActivityCommonTaskPanel", { tabIndexList = self.taskCfg.parameter })
end

--[[
/AdjustRoot/TrialBtn onClick 
--]]
function AS06MainPanel:trialBtn_ScaleButton_onClick(trialBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if not self.trialCfg then return end
    UIMgr:popUI("TrialPanel", self.trialCfg.parameter)
end

--[[
/AdjustRoot/ShopBtn onClick 
--]]
function AS06MainPanel:shopBtn_ScaleButton_onClick(shopBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if not self.shopCfg then return end
    UIMgr:popUI("ActivityCommonShopPanel", { shopIdList = self.shopCfg.parameter})
end

--[[
/GoBtn onClick 
--]]
function AS06MainPanel:goBtn_ScaleButton_onClick(goBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if not self.levelCfg then return end
    UIMgr:popUI("As06LevelPanel", {chapterId = self.levelCfg.parameter[1]})
end

return AS06MainPanel
