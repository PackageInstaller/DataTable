---@class ActivityRoleChoose : ActivityRoleChoose_Generate
---##################### 【ActivityRoleChoose Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ActivityRoleChoose Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ActivityRoleChoose = require "ActivityRoleChoose_Generate"

function ActivityRoleChoose:InitLogic(data)
    self.msgEventHandler = {
        --刷新任务按钮状态
        {GameMsgType.MissionRefresh, self.RefreshUI},
    }
end

--function ActivityRoleChoose:StartCreating(time)
--
--end

--function ActivityRoleChoose:StartEnter(time)
--
--end

--function ActivityRoleChoose:StartRemoving(time)
--
--end

--function ActivityRoleChoose:StartExit(time)
--
--end

-- {
--     activityId = int    --活动ID
-- }
function ActivityRoleChoose:OnOpen(data, initiative)
    if initiative then
        self._activtiyId = data.activityId
        self._selectedIndex = 0
        --初始化
        local activityCfg = Config.GetActivityInfo(self._activtiyId)
        local taskgroup = activityCfg.TaskGroup[1]
        local taskList = Config.GetTaskInfoByTaskTypeAndGroup(GE.MissionType.HeroExchange, taskgroup)
        self._exchangeTaskList = {}
        for k, v in pairs(taskList) do
            if v.type == 2 then
                table.insert(self._exchangeTaskList, v)
            end
        end
        table.sort(self._exchangeTaskList, function (a, b)
            return a.id < b.id
        end)
        self:RefreshUI()
        self:RefreshTickets()
    end
end

function ActivityRoleChoose:RefreshUI()
    --检查选中的任务是否已完成
    local taskCfg = self._exchangeTaskList[self._selectedIndex]
    if taskCfg and Me:getMissionListById(taskCfg.id).state == GE.MissionState.Received then
        self._selectedIndex = 0
    end
    local finishedCount = 0
    for i = 1, 4, 1 do
        local role = self["role" .. i]
        local taskCfg = self._exchangeTaskList[i]
        --选中
        role.selected:SetActive(self._selectedIndex == i)
        if taskCfg then
            local missionData = Me:getMissionListById(taskCfg.id)
            --已领取状态
            role.mask:SetActive(missionData.state == GE.MissionState.Received)
            if missionData.state == GE.MissionState.Received then
                finishedCount = finishedCount + 1
            end
            role.detail.scaleButton.onClick:RemoveAllListeners()
            role.detail.scaleButton.onClick:AddListener(function ()
                UIMgr:popUI("DockRolePanel", {uiMode = 3, characterId = taskCfg.Award[1][2]})
            end)
        end
    end
    --活动兑换完成隐藏按钮
    self.tips:SetActive(finishedCount < 4)
    self.disable:SetActive(self._selectedIndex == 0)
end

function ActivityRoleChoose:RefreshTickets()
    --持有兑换数量
    local ticketNum = Me:getItemNumById(100015)
    self.remainNum.text.text = LocalStrEnum.Exchange_RemainTimes .. ticketNum
end

--- 选中
function ActivityRoleChoose:onSelectIndex(index)
    --重复点击
    if self._selectedIndex == index then
       return 
    end
    --点击角色已领取
    local taskCfg = self._exchangeTaskList[index]
    local missionData = Me:getMissionListById(taskCfg.id)
    if missionData.state == GE.MissionState.Received then
        return
    end
    self._selectedIndex = index
    self:RefreshUI()
end

--function ActivityRoleChoose:OnClose(initiative)
--
--end

--function ActivityRoleChoose:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function ActivityRoleChoose:OnRefresh(data)
--
--end

--[[
/bg onClick 背景遮罩
--]]
function ActivityRoleChoose:bg_Button_onClick(bg)
    UIMgr:closeSpecificUI(self)
    local ActivityRoleExchange = UIMgr:GetUI("ActivityRoleExchange")
    if ActivityRoleExchange then
        ActivityRoleExchange:SetExchangeBtnState(true)
    end
end

--[[
/role1/detail onClick 
--]]
function ActivityRoleChoose:detail_ScaleButton_onClick(detail)

end

--[[
/tips/exchangeBtn onClick 兑换角色
--]]
function ActivityRoleChoose:exchangeBtn_ScaleButton_onClick(exchangeBtn)
    if self._selectedIndex and self._selectedIndex ~= 0 then
        local Data = {
            type = MsgBoxType.OKCancel,
            title = LocalStrEnum.Exchange_Title,
            content = string.format(LocalStrEnum.Exchange_Desc, 
                Config.GetCharacterInfo(self._exchangeTaskList[self._selectedIndex].Award[1][2]).name),
            okCallback = function()
                Me:SubmitClaimMissionRewardReq({self._exchangeTaskList[self._selectedIndex].id}, function (data)
                    self:RefreshTickets()
                    local ActivityRoleExchange = UIMgr:GetUI("ActivityRoleExchange")
                    if ActivityRoleExchange then
                        ActivityRoleExchange:RefreshTickets()
                    end
                end)
            end,
        }
        UIMgr:popUI("MsgBox", Data)
    end
end

--[[
/role1 onClick 
--]]
function ActivityRoleChoose:role1_Button_onClick(role1)
    self:onSelectIndex(1)
end

--[[
/role2 onClick 
--]]
function ActivityRoleChoose:role2_Button_onClick(role2)
    self:onSelectIndex(2)
end

--[[
/role3 onClick 
--]]
function ActivityRoleChoose:role3_Button_onClick(role3)
    self:onSelectIndex(3)
end

--[[
/role4 onClick 
--]]
function ActivityRoleChoose:role4_Button_onClick(role4)
    self:onSelectIndex(4)
end

--[[
/tips/exchangeBtn/disable onClick 
--]]
function ActivityRoleChoose:disable_ScaleButton_onClick(disable)

end

return ActivityRoleChoose
