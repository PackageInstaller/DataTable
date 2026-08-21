---@class TaskPanel : TaskPanel_Generate
---##################### 【TaskPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【TaskPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local TaskPanel = require "TaskPanel_Generate"

function TaskPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
        {GameMsgType.MissionRefresh, function()
            if self.nowMode == 3 then
                self:DataInfo()
                self:SetAchieveInfoView()
                self:ChangeAchieveToggle(self.nowSelectAchieveBtn, true)
            end
        end},
	}
    self.nowMode = nil             --当前选中模式
    --LuaLogger.ds("self.nowMode 0 = ",self.nowMode)
    self.ToggleMode = {
        "dailyCommon","weekCommon","achieve"
    }
    --self.commonTaskToggle = {
    --    "day", "week"
    --}
    self.commonStr = "common"
    self.nowSelectCommonBtn = nil
    self.nowSelectAchieveBtn = nil
    self.commonToggleList = {}
    self.achieveToggleList = {}

    self.curShowTaskData = {}
    self.dayTaskTable = {}          --每日任务数据列表
    self.weekTaskTable = {}          --每周任务数据列表
    self.dayPointTaskTable = {}          --每日累计积分任务数据列表
    self.weekPointTaskTable = {}          --每周累计积分任务数据列表
    self.achieveTaskTable = {}          --成就任务数据列表
    self.endDayPointTaskId = 1002005
    self.endWeekPointTaskId = 2002005

    self.nowCommonMode = nil

    self.isNotRefreshCommonPoint = true

    -- 缓存高频使用的对象，避免切换页签时重复分配
    self._finishColor = Color.New(51/255, 166/255, 246/255)  -- 积分完成颜色
    self._normalColor = Color.New(137/255, 147/255, 152/255)  -- 积分完成颜色
    self._taskItemConfig = Config.GetConfigInfo("TaskItem")   -- TaskItem 配置引用
    self._taskNavData = { GE.NavigationType.TaskPanel }       -- 奖励图标 navData 复用
    self._pointRewardCustomData = { isGet = false, navType = GE.NavigationType.TaskPanel }
    self.finishTaskIdList = {}
    self.achfinishTaskIdList = {}
end

--function TaskPanel:StartCreating(time)
--
--end

--function TaskPanel:StartEnter(time)
--
--end

--function TaskPanel:StartRemoving(time)
--
--end

--function TaskPanel:StartExit(time)
--
--end

function TaskPanel:OnOpen(data, initiative)
    --LuaLogger.ds("getMissionList=====================", tablex.dump(Me:getMissionList()))
    --LuaLogger.ds("getAchieveLevel=====================", tablex.dump(Me:getAchieveLevel()))
    --LuaLogger.ds("getAchieveExp=====================", tablex.dump(Me:getAchieveExp()))
    if initiative then
        RedPointMgr:Register("TaskPanelDayTaskRedJudge", self, function(bool)
            self.dailyCommonBtn.redPoint:SetActive(bool)
        end)
        RedPointMgr:Register("TaskPanelWeekTaskRedJudge", self, function(bool)
            self.weekCommonBtn.redPoint:SetActive(bool)
        end)
        RedPointMgr:Register("TaskPanelAchieveTaskRedJudge", self, function(bool)
            self.achieveBtn.redPoint:SetActive(bool)
        end)
        RedPointMgr:Register("TaskPanelAchieveLevelRedJudge", self, function(bool)
            self.rewardMsgBtn.redPoint:SetActive(bool)
        end)
        --导航栏
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.TaskPanel, self)
        self.isNotRefreshCommonPoint = true
        self:DataInfo()
        self:bindList()

        if not self.nowMode then
            self:SetModeSelect( 1)
        else
            self:SetModeSelect( self.nowMode)
        end
       
        
        self:SetCommonInfoView()
        self:SetAchieveInfoView()
        if self.recoverDownTimer then
            DLuaTimer:RemoveTimer(self.recoverDownTimer)
        end
        self.recoverDownTimer = DLuaTimer:DoRepeatForever(60, function()
            self:UpdateTime()
        end)
    else
        self:Refresh()
    end
    self.customMsgPanel:SetActive(false)
    self:doOpenAni()
end

function TaskPanel:doOpenAni()
    self.imgBg.canvasGroup.alpha = 0
    self.boxBg.canvasGroup.alpha = 0
    self.imgBg.canvasGroup:DOFade(1, 0.2):SetEase(DG.Tweening.Ease.OutQuart):OnComplete(function()
        self.boxBg.canvasGroup:DOFade(1, 0.3)
        self.boxBg.rectTransform.anchoredPosition = Vector2.New(0, -100)
        self.boxBg.rectTransform:DOAnchorPosY(0, 0.3):SetEase(DG.Tweening.Ease.OutQuart)
    end)
end

--数据初始化
function TaskPanel:DataInfo()
    self.dayTaskTable = {}
    self.weekTaskTable = {} 
    self.achieveTaskTable = {}
    self.allAchieveTaskTable = {}
    self.dayPointTaskTable = {}
    self.weekPointTaskTable = {}
    local missionList = Me:getMissionList()
    for k, v in pairs(missionList) do
        local taskConfig = Config.GetTaskTableInfo(v.id)
        if taskConfig then
            local temp = {
                server = v, config = taskConfig
            }
            if taskConfig.taskType == GE.MissionType.EveryDay then
                if taskConfig.type == GE.DayTaskType.DayCommon then
                    if temp.server.state ~= GE.MissionState.Lock then
                        table.insert(self.dayTaskTable, temp)
                    end
                elseif taskConfig.type == GE.DayTaskType.DayPoint then
                    table.insert(self.dayPointTaskTable, temp)
                end
            elseif taskConfig.taskType == GE.MissionType.EveryWeek then
                if taskConfig.type == GE.WeekTaskType.WeekCommon then
                    if temp.server.state ~= GE.MissionState.Lock then
                        table.insert(self.weekTaskTable, temp)
                    end
                elseif taskConfig.type == GE.WeekTaskType.WeekPoint then
                    table.insert(self.weekPointTaskTable, temp)
                end
            elseif taskConfig.taskType == GE.MissionType.Achieve then
                if not self.achieveTaskTable[taskConfig.type] then
                    self.achieveTaskTable[taskConfig.type] = {}
                end
                if temp.server.state ~= GE.MissionState.Lock then
                    table.insert(self.achieveTaskTable[taskConfig.type], temp)
                end
            end
        end
    end
    local tempAchieveTable = Config.GetTaskInfoByTaskType(GE.MissionType.Achieve)
    for _, v in pairs(tempAchieveTable) do
        if not self.allAchieveTaskTable[v.type] then
            self.allAchieveTaskTable[v.type] = {}
        end
        table.insert(self.allAchieveTaskTable[v.type], v)
    end

    table.sort(self.dayPointTaskTable, function(a, b)
        return a.server.id < b.server.id
    end)

    table.sort(self.weekPointTaskTable, function(a, b)
        return a.server.id < b.server.id
    end)

    table.sort(self.weekTaskTable, function(a, b)
        if a.server.state == b.server.state then
            return a.server.id < b.server.id
        else
            return a.server.state < b.server.state
        end
    end)
    table.sort(self.dayTaskTable, function(a, b)
        if a.server.state == b.server.state then
            return a.server.id < b.server.id
        else
            return a.server.state < b.server.state
        end
    end)

    for key, value in pairs(self.achieveTaskTable) do
        table.sort(value, function(a, b)
            if a.server.state == b.server.state then
                return a.server.id < b.server.id
            else
                return a.server.state < b.server.state
            end
        end)
    end
end

--刷新界面信息
function TaskPanel:Refresh()
    self:DataInfo()
    self:SetCommonInfoView()
    self:SetAchieveInfoView()

    self:ChangeCommonToggle(self.nowMode, true)
    self:ChangeAchieveToggle(self.nowSelectAchieveBtn, true)
end

--设置模式选择
function TaskPanel:SetModeSelect(mode)
    if mode == self.nowMode then
        return false
    end
    self.nowMode = mode
    for key, value in pairs(self.ToggleMode) do
        if self.nowMode == key then
            if key < 3 then
                self[value.."Btn"].isOn:SetActive(true)
                self[value.."Btn"].isOff:SetActive(false)
                self[self.commonStr.."Panel"]:SetActive(self.nowMode < 3)
            else
                self[value.."Btn"].isOn:SetActive(true)
                self[value.."Btn"].isOff:SetActive(false)
                self[value.."Panel"]:SetActive(true)
            end
        else
            if key < 3 then
                self[value.."Btn"].isOn:SetActive(false)
                self[value.."Btn"].isOff:SetActive(true)
                self[self.commonStr.."Panel"]:SetActive(self.nowMode < 3)
            else
                self[value.."Btn"].isOn:SetActive(false)
                self[value.."Btn"].isOff:SetActive(true)
                self[value.."Panel"]:SetActive(false)
            end
        end
    end
    return true
end

--常规模式初始化
function TaskPanel:SetCommonInfoView(isUpdate)
    self:ChangeCommonToggle(1)
end

--更改常规模式内toggle
function TaskPanel:ChangeCommonToggle(index, isUpdate)
    if self.nowMode == 1 then
        self.curShowTaskData = self.dayTaskTable
        self:SetCommonView(self.dayTaskTable, self.dayPointTaskTable, self.endDayPointTaskId)
        --self.tipsTxt.text.text = "-日活跃度奖励-"
    else
        self.curShowTaskData = self.weekTaskTable
        self:SetCommonView(self.weekTaskTable, self.weekPointTaskTable, self.endWeekPointTaskId)
        --self.tipsTxt.text.text = "-周活跃度奖励-"
    end
    
    self:UpdateTime()
end

function TaskPanel:bindList()
    self.taskLoopList.loopListView2:InitListView(#self.curShowTaskData, function(listView, index)
        local loopListViewItem2 = listView:GetShownItemByItemIndex(index)
        if loopListViewItem2 == nil then
            loopListViewItem2 = listView:NewListViewItem("CommonTaskBox")
        end
        local itemObj = loopListViewItem2.gameObject
        EngineUtil.FillPeer(self.commonTaskBox, itemObj)
        local taskData = self.curShowTaskData[index + 1]
        local taskProgressTarget = Me:getTaskProgressTarget(taskData.server.id, GE.MissionSystemType.task)
        itemObj.taskMsgTxt.text.text = taskData.config.TaskSynopsis

        local showTaskProgress = taskData.server.progress < taskProgressTarget and taskData.server.progress or taskProgressTarget
        if showTaskProgress == taskProgressTarget then
            itemObj.taskNameTxt.text.text = string.format("%s  (<color=#1b83d9>%s</color><color=#838383>/%s</color>)", taskData.config.taskName, showTaskProgress, taskProgressTarget)
        else
            itemObj.taskNameTxt.text.text = string.format("%s  (<color=#e8703b>%s</color><color=#838383>/%s</color>)", taskData.config.taskName, showTaskProgress, taskProgressTarget)
        end

        local taskIcon = string.format(Config.SpritePath.TaskIcon, taskData.config.icon)
        self:LoadSpriteAsync(taskIcon, itemObj.taskIcon.image)

        itemObj.pointFull:SetActive(showTaskProgress == taskProgressTarget)
        itemObj.taskPoint.image.fillAmount = showTaskProgress / taskProgressTarget
        itemObj.inProgressText:SetActive(taskData.server.state == GE.MissionState.Progress)
        itemObj.finishText:SetActive(taskData.server.state == GE.MissionState.Received)
        itemObj.bgGet:SetActive(taskData.server.state == GE.MissionState.Received)
        --itemObj.mask:SetActive(taskData.server.state == GE.MissionState.Received)
        itemObj.btn.button.onClick:RemoveAllListeners()
        if taskData.server.state == GE.MissionState.Unclaimed then
            itemObj.bgReceive:SetActive(true)
            itemObj.btn.button.onClick:AddListener(function()
                self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
                local missionId = {
                    taskData.server.id
                }
                Me:GetMissionRewardReq(missionId, function(data)
                    self.isNotRefreshCommonPoint = false
                    self:Refresh()
                    self:RefreshCommonPoint()
                end)
            end)
        else
            itemObj.bgReceive:SetActive(false)
        end

        if taskData.server.state == GE.MissionState.Progress and taskData.config.TurnTo ~= 0 then
            itemObj.bgTo:SetActive(true)
            itemObj.btn.button.onClick:AddListener(function()
                self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
                local canTurnTo = UICommonUtils.CanUseSkipJudge(taskData.config.TurnTo, true)
                if canTurnTo then
                    UICommonUtils.CommonTurnTo(taskData.config.TurnTo)
                end
            end)
        else
            itemObj.bgTo:SetActive(false)
        end

        -- 奖励图标：利用 FillPeer 幂等特性，将子节点引用缓存在 peer 上，
        -- 复用时跳过 FillTemplateContent 的 C# 场景树遍历
        local awardList = taskData.config.Award
        local awardCount = #awardList
        local rewardCount = awardCount + 1
        local extraItem = {GE.RewardType.ItemProp, self._taskItemConfig[self.nowMode], taskData.config.extraScore}
        local navData = self._taskNavData
        local cachedItems = itemObj._rewardItems
        if cachedItems and #cachedItems == rewardCount then
            for k = 1, rewardCount do
                local rewardItem = cachedItems[k]
                local rewardData = k <= awardCount and awardList[k] or extraItem
                if rewardItem._lastId ~= rewardData[2] or rewardItem._lastCount ~= rewardData[3] then
                    rewardItem._lastId = rewardData[2]
                    rewardItem._lastCount = rewardData[3]
                    rewardItem.customBox:SetUIData(rewardData, navData)
                end
            end
        else
            cachedItems = {}
            itemObj._rewardItems = cachedItems
            self:FillTemplateContent(self.customBox, itemObj.rewardList, rewardCount, function(k, rewardObj)
                cachedItems[k] = rewardObj
                local rewardData = k <= awardCount and awardList[k] or extraItem
                rewardObj._lastId = rewardData[2]
                rewardObj._lastCount = rewardData[3]
                rewardObj.customBox:setMono(self)
                rewardObj.customBox:SetUIData(rewardData, navData)
            end)
        end
        return loopListViewItem2
    end)

    -- 提升到外层闭包，避免每个 Cell 回调重复查表
    local taskItemConfig3 = self._taskItemConfig[3]
    local navData = self._taskNavData
    
    self.achieveLoopList.loopListView2:InitListView(1, function(listView, index)
        local loopListViewItem2 = listView:GetShownItemByItemIndex(index)
        if loopListViewItem2 == nil then
            loopListViewItem2 = listView:NewListViewItem("TaskBox")
        end
        local itemObj = loopListViewItem2.gameObject
        EngineUtil.FillPeer(self.taskBox, itemObj)
    --EngineUtil.CreatCircularScrollView(self.achieveList.uICircularScrollView, self.taskBox, showCount, function(index, taskBox)
        local taskTable = self.achieveTaskTable[self.nowSelectAchieveBtn] or {}
        local taskData = taskTable[index + 1]
        if not taskData then return loopListViewItem2 end
        local awardList = taskData.config.Award
        local awardCount = #awardList
        local rewardCount = awardCount + 1
        local extraItem = {GE.RewardType.ItemProp, taskItemConfig3, taskData.config.extraScore}

        -- FillPeer 对已有 peer 的 Cell 是幂等 no-op，其 peer 表在复用时完整保留。
        -- 利用这一点将奖励子节点缓存在 peer 上，滚动时完全跳过 FillTemplateContent
        -- 内部的 GetChild / SetActive / FillPeer 等 C# 遍历，只做 SetUIData 数据更新。
        local cachedItems = itemObj._rewardItems
        if cachedItems and #cachedItems == rewardCount then
            -- 快速路径：对比 id+count，数据未变则跳过 SetUIData（含 3次 LoadSpriteAsync + 20+ SetActive）
            for k = 1, rewardCount do
                local itemObj = cachedItems[k]
                local rewardData = k <= awardCount and awardList[k] or extraItem
                if itemObj._lastId ~= rewardData[2] or itemObj._lastCount ~= rewardData[3] then
                    itemObj._lastId = rewardData[2]
                    itemObj._lastCount = rewardData[3]
                    itemObj.customBox:SetUIData(rewardData, navData)
                end
            end
        else
            -- 首次或奖励数量变化：正常走 FillTemplateContent，并缓存子节点引用
            cachedItems = {}
            itemObj._rewardItems = cachedItems
            self:FillTemplateContent(self.customBox, itemObj.rewardList, rewardCount, function(k, itemObj)
                cachedItems[k] = itemObj
                local rewardData = k <= awardCount and awardList[k] or extraItem
                itemObj._lastId = rewardData[2]
                itemObj._lastCount = rewardData[3]
                itemObj.customBox:setMono(self)
                itemObj.customBox:SetUIData(rewardData, navData)
            end)
        end

        local taskProgressTarget = Me:getTaskProgressTarget(taskData.server.id, GE.MissionSystemType.task)
        itemObj.taskMsgTxt.text.text = taskData.config.TaskSynopsis
        local showTaskProgress = taskData.server.progress < taskProgressTarget and taskData.server.progress or taskProgressTarget
        if showTaskProgress == taskProgressTarget then
            itemObj.taskNameTxt.text.text = string.format("%s  (<color=#1b83d9>%s</color><color=#838383>/%s</color>)", taskData.config.taskName, showTaskProgress, taskProgressTarget)
        else
            itemObj.taskNameTxt.text.text = string.format("%s  (<color=#e8703b>%s</color><color=#838383>/%s</color>)", taskData.config.taskName, showTaskProgress, taskProgressTarget)
        end
        local taskIcon = string.format(Config.SpritePath.TaskIcon, taskData.config.icon)
        self:LoadSpriteAsync(taskIcon, itemObj.taskIcon.image)
        itemObj.pointFull:SetActive(showTaskProgress == taskProgressTarget)
        itemObj.taskPoint.image.fillAmount = showTaskProgress / taskProgressTarget
        itemObj.inProgressText:SetActive(taskData.server.state == GE.MissionState.Progress)
        itemObj.finishText:SetActive(taskData.server.state == GE.MissionState.Received)
        itemObj.bgGet:SetActive(taskData.server.state == GE.MissionState.Received)
        --taskBox.mask:SetActive(taskData.server.state == GE.MissionState.Received)
        itemObj.btn.button.onClick:RemoveAllListeners()
        if taskData.server.state == GE.MissionState.Unclaimed then
            itemObj.bgReceive:SetActive(true)
            itemObj.btn.button.onClick:AddListener(function()
                self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
                local missionId = {taskData.server.id}
                Me:GetMissionRewardReq(missionId, function(data)
                    self:Refresh()
                end)
            end)
        else
            itemObj.bgReceive:SetActive(false)
        end
        if taskData.server.state == GE.MissionState.Progress and taskData.config.TurnTo ~= 0 then
            itemObj.bgTo:SetActive(true)
            itemObj.btn.button.onClick:AddListener(function()
                self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
                local canTurnTo = UICommonUtils.CanUseSkipJudge(taskData.config.TurnTo, true)
                if canTurnTo then
                    UICommonUtils.CommonTurnTo(taskData.config.TurnTo)
                end
            end)
        else
            itemObj.bgTo:SetActive(false)
        end
        return loopListViewItem2
    end)
end

--更新时间
function TaskPanel:UpdateTime()
    local timeDiff = 0
    if self.nowMode == 1 then
        timeDiff = DLuaUtil.GetTimeDiff(ClientData:GetNextResetTime(), Me.servertime)
    else
        timeDiff = DLuaUtil.getNextWeekRemainingTime(Me.servertime, Me:getTimeZone())
    end

    if timeDiff.day == 0 then
        self.timeTxt.text.text = timeDiff.hour.."时"..timeDiff.min.."分"
    else
        self.timeTxt.text.text = timeDiff.day.."天"..timeDiff.hour.."时"
    end
end

function TaskPanel:RefreshCommonPoint(ccc)
    if self.isNotRefreshCommonPoint then
        return
    end
    local endTaskId, pointDataTable
    if self.nowMode == 1 then
        endTaskId = self.endDayPointTaskId
        pointDataTable = self.dayPointTaskTable
    else
        endTaskId = self.endWeekPointTaskId
        pointDataTable = self.weekPointTaskTable
    end
    local endPointTaskData = Me:getMissionListById(endTaskId)
    if not endPointTaskData then
        return
    end

    local nowPoint = endPointTaskData.progress
    if ccc ~= nil then nowPoint = ccc end
    local taskProgressTarget = Me:getTaskProgressTarget(endTaskId, GE.MissionSystemType.task)

    local lastPoint = self.nowPointTxt.text.text
    lastPoint = tonumber(lastPoint)
    lastPoint = lastPoint or 0

    self.maxPointTxt.text.text = "/"..taskProgressTarget

    local fillValue = math.min(nowPoint, 20) * 0.5 + math.max(nowPoint - 20, 0) * 1.125
    fillValue = fillValue / 100

    local GetNowPoint = function(val)
        local v = val * 100
        local np = 0
        if v <= 10 then
            np = v * 2
        else
            np = (v - 10) / 1.125 + 20
        end
        return np
    end
    --todo动画

    self.tweenTable = {}
    local jg = {20, 40, 60, 80, 100}

    for i = 1, #jg do
        ---@type TaskPanel_Generate_rewardBtn1
        local rewardBtn = self["rewardBtn"..i]
        rewardBtn.markEffect:SetActive(false)
    end

    local slider = self.pointSlider.slider
    slider:DOKill()
    local pl = fillValue - slider.value
    pl = pl * 2
    local lastVal = GetNowPoint(slider.value)

    local tweenUpdate = function(isComplete)
        local nv = GetNowPoint(slider.value)
        if isComplete then
            nv = nowPoint
        end
        local index = 0
        for i = 1, #jg do
            local jgi = jg[i]
            if lastVal < jgi and nv >= jgi then
                index = i
                break
            end
        end
        lastVal = nv
        self.nowPointTxt.text.text = tostring(math.floor(nv)) 
        if index == 0 then
            return
        end
        ---@type TaskPanel_Generate_rewardBtn1
        local rewardBtn = self["rewardBtn"..index]
        if rewardBtn == nil then
            return
        end
        rewardBtn.mark.gameObject:SetActive(true)
        rewardBtn.mark_gray.gameObject:SetActive(false)
        self:setPointReward(rewardBtn, pointDataTable[index].config.Award, true)
        rewardBtn.arrowImg.image.color = Color.New(51/255,166/255, 246/255)

        rewardBtn.finishImage.gameObject:SetActive(true)
        rewardBtn.finishImage.image:DOKill()
        rewardBtn.finishImage.image.fillAmount = 0
        local tween = rewardBtn.finishImage.image:DOFillAmount(1, 0.3):OnComplete(function()
            rewardBtn.finishImage.image:DOFade(0, 0.2)
        end)
        rewardBtn.markEffect:SetActive(true)
        table.insert(self.tweenTable,tween)
    end
    local fillTween = self.pointSlider.slider:DOValue(fillValue, pl):OnUpdate(tweenUpdate):OnComplete(function()
        tweenUpdate(true)
    end)
    table.insert(self.tweenTable,fillTween)
    local vv = nowPoint / 100
    local imgTewwn = self.pointProgressImg.image:DOFillAmount(vv, pl)
    table.insert(self.tweenTable,imgTewwn)
end

--设置普通模式显示
function TaskPanel:SetCommonView(dataTale, pointDataTable, endTaskId)
    if self.isNotRefreshCommonPoint then
        if self.tweenTable then
            for k , tween in pairs(self.tweenTable) do
                if tween ~= nil then
                    tween:Kill()
                end
            end
            self.tweenTable = {}
        end
        local endPointTaskData = Me:getMissionListById(endTaskId)
        if endPointTaskData then
            --LuaLogger.e(tablex.dump(endPointTaskData))
            --点位显示
            local nowPoint = endPointTaskData.progress
            local taskProgressTarget = Me:getTaskProgressTarget(endTaskId,GE.MissionSystemType.task)
            self.nowPointTxt.text.text = nowPoint
            self.maxPointTxt.text.text = "/"..taskProgressTarget
            local tempIndexInt, tempIndexFrac = math.modf(nowPoint/20)

            local fillValue = math.min(nowPoint, 20) * 0.5 + math.max(nowPoint - 20, 0) * 1.125
            fillValue = fillValue / 100
            self.pointSlider.slider.value = fillValue
            self.pointProgressImg.image.fillAmount = (nowPoint / 100)

            for i = 1, 5 do
                ---@type TaskPanel_Generate_rewardBtn1
                local rewardBtn = self["rewardBtn"..i]
                local isFinish = i <= tempIndexInt
                -- isFinish 未变时跳过 SetActive / color 等 C# 调用
                if rewardBtn._lastIsFinish ~= isFinish then
                    rewardBtn._lastIsFinish = isFinish
                    rewardBtn.mark.gameObject:SetActive(isFinish)
                    rewardBtn.mark_gray.gameObject:SetActive(not isFinish)
                    rewardBtn.arrowImg.image.color = isFinish and self._finishColor or self._normalColor
                    rewardBtn.finishImage.gameObject:SetActive(isFinish)
                end
                rewardBtn.finishImage.image.fillAmount = 0
                self:setPointReward(rewardBtn, pointDataTable[i].config.Award, isFinish)
            end
        end
    end
    -- 使用 # 替代 tablex.size：curShowTaskData 由 table.insert 构建，是顺序表
    self.taskLoopList.loopListView2:SetListItemCount(#self.curShowTaskData)
    self.taskLoopList.loopListView2:RefreshAllShownItem2()
    --判断当前常规模式下的哪个模式，对应模式整理一套一键领取的列表
    self.finishTaskIdList = {}
    for _, value in pairs(self.curShowTaskData) do
        if value then
            if value.server.state == GE.MissionState.Unclaimed then
                table.insert(self.finishTaskIdList, value.server.id)
            end
        end
    end
    self.commonGetBtn:SetActive(#self.finishTaskIdList > 0)
    self.commonGetDisable:SetActive(#self.finishTaskIdList == 0)
end

function TaskPanel:setPointReward(itemRoot, rewardList, isReceive)
    -- 复用缓存表，避免每次调用都分配新 customData（切换页签时会调用 5 次）
    local customData = self._pointRewardCustomData
    customData.isGet = isReceive
    for i = 1, 3 do
        local item = itemRoot["r"..i]
        local rd = rewardList[i]
        if rd then
            item:SetActive(true)
            -- id / count / isGet 均未变时跳过 SetUIData（内含 3 次 LoadSpriteAsync + 20+ SetActive）
            if item._lastId ~= rd[2] or item._lastCount ~= rd[3] or item._lastIsGet ~= isReceive then
                item._lastId    = rd[2]
                item._lastCount = rd[3]
                item._lastIsGet = isReceive
                item.customBox:setMono(self)
                item.customBox:SetUIData(rd, customData)
            end
        else
            item:SetActive(false)
        end
    end
end

--主线模式初始化
function TaskPanel:SetMainInfoView()
    
end

--成就模式初始化
function TaskPanel:SetAchieveInfoView()
    for i = 1, 4 do
        local taskToggleBtn = self.achievePanel["taskToggleBtn"..i]
        self.achieveToggleList[i] = taskToggleBtn
        taskToggleBtn:SetActive(true)
        taskToggleBtn.offTxt.text.text = LocalStrEnum[GE.MissionDetailTypeName[i]] 
        taskToggleBtn.onTxt.text.text = LocalStrEnum[GE.MissionDetailTypeName[i]] 
        local archiveCount = tablex.size(self.allAchieveTaskTable[i])
        local completeCount = self:GetAchieveCompletedByMissionState(i)
        --LuaLogger.ds("archiveCount = ",completeCount,",",archiveCount)
        taskToggleBtn.offNum.text.text = completeCount .."/"..archiveCount
        taskToggleBtn.onNum.text.text = completeCount .."/"..archiveCount
        taskToggleBtn.redPoint:SetActive(RedPointMgr:TaskPanelAchieveToggleRedJudge(i))
        taskToggleBtn.scaleButton.onClick:RemoveAllListeners()
        taskToggleBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
            self:ChangeAchieveToggle(i)
        end)
    end

    local nowAchieveLevel = Me:getAchieveLevel()

    local oldLevel = self.achieveLevelTxt.text.text
    if string.isNullOrEmpty(oldLevel) then
       oldLevel = nil
    else
        oldLevel = tonumber(oldLevel)
    end
    if oldLevel ~= nil and oldLevel ~= nowAchieveLevel then
        self.achieveLevelEffect.gameObject:SetActive(true)
    else
        self.achieveLevelEffect.gameObject:SetActive(false)
    end

    self.achieveLevelTxt.text.text = nowAchieveLevel
    self.achieveLevelTxtUnder.text.text = nowAchieveLevel
    local levelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.achieve, nowAchieveLevel)
    local nowExp = Me:getAchieveExp() - levelData.exp_sum 
    local needExp = levelData.exp_sum - nowExp
    --self.expMsgTxt.text.text = "还需累积"..needExp.."经验达到下一等级"
    self.nowExpTxt.text.text = nowExp
    self.maxExpTxt.text.text = "/"..levelData.exp
    --self.achieveExpSlider.slider.value = nowExp / levelData.exp
    local maxCount = self:GetAchieveMaxCount()
    local maxComplete = self:GetAchieveCompletedByMissionState(0)
    self.completeMaxNum.text.text = maxComplete
    self.maxNum.text.text = "/"..maxCount
    
    --TODO: 处理奖励预览
    local nextLevelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.achieve, nowAchieveLevel + 1)
    if nextLevelData and nextLevelData.levelup_extra and next(nextLevelData.levelup_extra) then
        local rewardList = Config.GetTaskTableInfo(nextLevelData.levelup_extra[1]).Award
        if rewardList and next(rewardList) then
            self:FillTemplateContent(self.customBox, self.rewardMsgList, tablex.size(rewardList), function(index, itemObj)
                itemObj.transform.localScale = Vector3.New(0.75,0.75,1)
                local customBox = itemObj.customBox
                --[[local data = {
                    id = rewardList[index][2],
                    itemType = GE.ItemTypeIndex.item,
                    itemNum = rewardList[index][3],
                    navType = GE.NavigationType.TaskPanel,
                }]]
                customBox:setMono(self)
                customBox:SetUIData(rewardList[index], {navType = GE.NavigationType.TaskPanel})
            end)
        end
    else
        -- --TODO: 这里判断是否满级
        -- if nextLevelData.exp == 0 and nextLevelData.exp_sum == Me:getAchieveExp() then
        --     self.expMsgTxt.text.text = ""
        -- end
    end
    if self.nowSelectAchieveBtn == nil then
        self:ChangeAchieveToggle(1)
    end
    self:setAchieveList()
end

-- 获取最大成就数量
function TaskPanel:GetAchieveMaxCount()
    local archiveCount = 0
    if self.allAchieveTaskTable then
        for k , v in pairs(self.allAchieveTaskTable) do
            archiveCount = archiveCount + tablex.size(v)
        end
    end
    return archiveCount
end

-- 获取已完成的成就数量，missionDetailTypeMissionDetailType == 0 时取得的是不论类型的总完成数量
function TaskPanel:GetAchieveCompletedByMissionState(missionDetailType)
    local archiveCount = 0
    if self.achieveTaskTable then
        if missionDetailType ~= 0 then
            local achiveTable = self.achieveTaskTable[missionDetailType]
            if achiveTable then
                for k , v in pairs(achiveTable) do
                    if v.server.state == GE.MissionState.Received then
                        archiveCount = archiveCount + 1
                    end
                end
            end
        else
            for k , v in pairs(self.achieveTaskTable) do
                if v then
                    for j , l in pairs(v) do
                        if l.server.state == GE.MissionState.Received then
                            archiveCount = archiveCount + 1
                        end
                    end
                end
            end
        end
        
    end
    return archiveCount
end

--更改成就模式内toggle
function TaskPanel:ChangeAchieveToggle(index, isUpdate)
    if self.nowSelectAchieveBtn == index and not isUpdate then
        return
    end
    self.nowSelectAchieveBtn = index
    for k,v in pairs(self.achieveToggleList) do
        if self.nowSelectAchieveBtn == k then
            v.isOff:SetActive(false)
            v.isOn:SetActive(true)
        else
            v.isOff:SetActive(true)
            v.isOn:SetActive(false)
        end
    end
    self:setAchieveList()
end

--设置成就显示
function TaskPanel:setAchieveList()
    local taskTable = self.achieveTaskTable[self.nowSelectAchieveBtn]
    local showCount = #taskTable

    self.achfinishTaskIdList = {}
    if taskTable then
        for _, value in pairs(taskTable) do
            if value then
                if value.server.state == GE.MissionState.Unclaimed then
                    table.insert(self.achfinishTaskIdList, value.server.id)
                end
            end
        end
    end
    self.achieveGetBtn:SetActive(#self.achfinishTaskIdList > 0)
    self.achieveGetDisable:SetActive(#self.achfinishTaskIdList == 0)

    self.achieveLoopList.loopListView2:SetListItemCount(showCount)
    self.achieveLoopList.loopListView2:RefreshAllShownItem2()
end

--获取待领取的积分任务
function TaskPanel:GetPointTaskUnclaimed()
    local missionId = {}
    if self.nowMode == 1 then
        for _, value in pairs(self.dayPointTaskTable) do
            if value.server.state == GE.MissionState.Unclaimed then
                table.insert(missionId, value.server.id)
            end
        end
    elseif self.nowMode == 2 then
        for _, value in pairs(self.weekPointTaskTable) do
            if value.server.state == GE.MissionState.Unclaimed then
                table.insert(missionId, value.server.id)
            end
        end
    end
    return missionId
end

--获取已领取的积分任务
function TaskPanel:GetPointTaskReceived()
    local missionId = {}
    if self.nowMode == 1 then
        for _, value in pairs(self.dayPointTaskTable) do
            if value.server.state == GE.MissionState.Received then
                table.insert(missionId, value.server.id)
            end
        end
    elseif self.nowMode == 2 then
        for _, value in pairs(self.weekPointTaskTable) do
            if value.server.state == GE.MissionState.Received then
                table.insert(missionId, value.server.id)
            end
        end
    end
    return missionId
end

--function TaskPanel:OnClose(initiative)
--
--end

function TaskPanel:OnDestroy()
	if self.recoverDownTimer then
        DLuaTimer:RemoveTimer(self.recoverDownTimer)
    end
    self.super:OnDestroy(self)
end

--function TaskPanel:OnRefresh(data)
--
--end

--[[
/BackPanel/BackMainlBtn onClick 
--]]
function TaskPanel:backMainlBtn_ScaleButton_onClick(backMainlBtn)

end

--[[
/BackPanel/HelpBtn onClick 
--]]
function TaskPanel:helpBtn_ScaleButton_onClick(helpBtn)

end

--[[
/BoxBg/ToggleList/AchieveBtn onClick 
--]]
function TaskPanel:achieveBtn_ScaleButton_onClick(achieveBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    local isRefresh = self:SetModeSelect(3)
    if not isRefresh then
        return
    end
    self.commonPanel.canvasGroup:DOFade(0, 0.1):SetEase(DG.Tweening.Ease.OutQuart):OnComplete(function()
        self.achievePanel.canvasGroup:DOFade(1, 0.1):SetEase(DG.Tweening.Ease.OutQuart)
    end)
    
end

--[[
/BoxBg/AchievePanel/PointBg/RewardBg/RewardMsgBtn onClick 
--]]
function TaskPanel:rewardMsgBtn_ScaleButton_onClick(rewardMsgBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    UIMgr:popUICover("AchieveRewardPanel", {nowMode = self.nowMode})
end

--[[
/Custom/CustomBox/EquipBtn onClick 
--]]
function TaskPanel:equipBtn_ScaleButton_onClick(equipBtn)

end

--[[
/Custom/TaskToggleBtn onClick 
--]]
function TaskPanel:taskToggleBtn_ScaleButton_onClick(taskToggleBtn)

end

--[[
/BoxBg/CommonPanel/CommonGetBtn onClick 
--]]
function TaskPanel:commonGetBtn_ScaleButton_onClick(commonGetBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    if self.finishTaskIdList and next(self.finishTaskIdList) then
        Me:GetMissionRewardReq(self.finishTaskIdList, function(data)
            self.isNotRefreshCommonPoint = false
            self:Refresh()
            self:RefreshCommonPoint()
        end)
    end
end

--[[
/BoxBg/AchievePanel/AchieveGetBtn onClick 
--]]
function TaskPanel:achieveGetBtn_ScaleButton_onClick(achieveGetBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    if self.achfinishTaskIdList and next(self.achfinishTaskIdList) then
        Me:GetMissionRewardReq(self.achfinishTaskIdList, function(data)
            self:Refresh()
        end)
    end
end

--[[
/BoxBg/ToggleList/DailyCommonBtn onClick 
--]]
function TaskPanel:dailyCommonBtn_ScaleButton_onClick(dailyCommonBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self.isNotRefreshCommonPoint = true
    local isRefresh = self:SetModeSelect(1)
    if not isRefresh then
        return
    end
    self:ChangeCommonToggle(1)
    self.achievePanel.canvasGroup:DOFade(0, 0.1):SetEase(DG.Tweening.Ease.OutQuart)
    self.commonPanel.canvasGroup:DOFade(0, 0.1):SetEase(DG.Tweening.Ease.OutQuart):OnComplete(function()
        self.commonPanel.canvasGroup:DOFade(1, 0.1):SetEase(DG.Tweening.Ease.OutQuart)
    end)
end

--[[
/BoxBg/ToggleList/WeekCommonBtn onClick 
--]]
function TaskPanel:weekCommonBtn_ScaleButton_onClick(weekCommonBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    self.isNotRefreshCommonPoint = true
    local isRefresh = self:SetModeSelect(2)
    if not isRefresh then
        return
    end
    self:ChangeCommonToggle(2)
    self.achievePanel.canvasGroup:DOFade(0, 0.1):SetEase(DG.Tweening.Ease.OutQuart)
    self.commonPanel.canvasGroup:DOFade(0, 0.1):SetEase(DG.Tweening.Ease.OutQuart):OnComplete(function()
        self.commonPanel.canvasGroup:DOFade(1, 0.1):SetEase(DG.Tweening.Ease.OutQuart)
    end)
end

--[[
/BoxBg/CommonPanel/PointGetBtn onClick 
--]]
function TaskPanel:pointGetBtn_ScaleButton_onClick(pointGetBtn)
    
end

--[[
/BoxBg/CommonPanel/PointBg/PointSlider onValueChanged 
--]]
function TaskPanel:pointSlider_Slider_onValueChanged(pointSlider,value)

end

--[[
/BoxBg/AchievePanel/TaskBg/AchieveLoopList/Viewport/Content/TaskBox/TaskGetBtn onClick 
--]]
function TaskPanel:taskGetBtn_ScaleButton_onClick(taskGetBtn)

end

--[[
/BoxBg/AchievePanel/TaskBg/AchieveLoopList/Viewport/Content/TaskBox/TaskInBtn onClick 
--]]
function TaskPanel:taskInBtn_ScaleButton_onClick(taskInBtn)

end

--[[
/BoxBg/AchievePanel/ToggleList/TaskToggleBtn1 onClick 
--]]
function TaskPanel:taskToggleBtn1_ScaleButton_onClick(taskToggleBtn1)

end

--[[
/BoxBg/AchievePanel/ToggleList/TaskToggleBtn2 onClick 
--]]
function TaskPanel:taskToggleBtn2_ScaleButton_onClick(taskToggleBtn2)

end

--[[
/BoxBg/AchievePanel/ToggleList/TaskToggleBtn3 onClick 
--]]
function TaskPanel:taskToggleBtn3_ScaleButton_onClick(taskToggleBtn3)

end

--[[
/BoxBg/AchievePanel/ToggleList/TaskToggleBtn4 onClick 
--]]
function TaskPanel:taskToggleBtn4_ScaleButton_onClick(taskToggleBtn4)

end

--[[
/BoxBg/AchievePanel/ToggleList/TaskToggleBtn5 onClick 
--]]
function TaskPanel:taskToggleBtn5_ScaleButton_onClick(taskToggleBtn5)

end

--[[
/BoxBg/CommonPanel/TaskLoopList/Viewport/Content/CommonTaskBox/BgReceive/Button onClick 
--]]
function TaskPanel:button_Button_onClick(button)

end

--[[
/BoxBg/CommonPanel/TaskLoopList/Viewport/Content/CommonTaskBox/BgReceive onClick 
--]]
function TaskPanel:bgReceive_ScaleButton_onClick(bgReceive)

end

--[[
/BoxBg/CommonPanel/TaskLoopList/Viewport/Content/CommonTaskBox/BgTo onClick 
--]]
function TaskPanel:bgTo_ScaleButton_onClick(bgTo)

end

--[[
/BoxBg/CommonPanel/TaskLoopList/Viewport/Content/CommonTaskBox/BgReceive onClick 
--]]
function TaskPanel:bgReceive_Button_onClick(bgReceive)

end

--[[
/BoxBg/CommonPanel/TaskLoopList/Viewport/Content/CommonTaskBox/BgTo onClick 
--]]
function TaskPanel:bgTo_Button_onClick(bgTo)

end

--[[
/BoxBg/CommonPanel/TaskLoopList/Viewport/Content/CommonTaskBox/Btn onClick 
--]]
function TaskPanel:btn_Button_onClick(btn)

end

return TaskPanel
