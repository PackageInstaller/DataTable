--
-- <代码文件解释说明>
--

---@class UIBattlePassView : UIBaseView
---@field model UIBattlePassModel
---@field ctrl UIBattlePassCtrl
local UIBattlePassView = BaseClass("UIBattlePassView",UIBaseView)
local base = UIBaseView
local this = UIBattlePassView

local ShowTaskType = {
    Daily = 1,
    Weekly = 2,
    Season = 3,
}

local TabType = {
    Reward = 1,
    Task = 2,
}

local RewardItemWidth
local TaskPfbName = "TaskItem"
local RewardPfbName = "BattlePassRewardItem"

function this:OnLangCreate()
    self.lastTimeText = LangUtil.BindText(self.langRc:GetObject("LastTimeText"))
    self.levelText = LangUtil.BindText(self.langRc:GetObject("LevelText"))
    self.expText = LangUtil.BindText(self.langRc:GetObject("ExpText"))
    LangUtil.BindText(self.langRc:GetObject("LevelNameText")).text = LangUtil.GetSysLang(1383) -- 通行證等級
    LangUtil.BindText(self.getAllButton.transform:Find("Text")).text = LangUtil.GetSysLang(311) -- 一键领取
    LangUtil.BindText(self.buyLevelButton.transform:Find("Text")).text = LangUtil.GetSysLang(1384) -- 购买等级
    LangUtil.BindText(self.unlockButton.transform:Find("Text")).text = LangUtil.GetSysLang(1385) -- 解锁高级奖励

    self.taskRefreshNoteText = LangUtil.BindText(self.langRc:GetObject("TaskRefreshNoteText"))

    self.logoImage = self.langRc:GetObject("LogoImage"):GetComponent("Image")
    self.bgImage = self.langRc:GetObject("BgImage"):GetComponent("Image")
    self.logoText = LangUtil.BindText(self.langRc:GetObject("LogoText"))
end

function this:OnTabClick(type)
    -- self.tabList[type].active = root:Find("Active").gameObject
    -- self.tabList[type].text = rLangUtil.BindText(root:Find("Text"))
    self.currentTab = type
    for key, value in pairs(self.tabList) do
        value.active:SetActive(key == type)
        if key == type then
            value.text.color = Color.New(87/255, 78/255, 66/255)
        else
            value.text.color = Color.New(136/255, 153/255, 191/255)
        end
    end

    if type == TabType.Reward then
        self.rewardRoot:SetActive(true)
        self.taskRoot:SetActive(false)

        local maxCount = table.count(Z_PassReward[self.model.pass.id]) - 1
        local hideCount = 0
        if self.model.pass.canReceiveNormal or self.model.pass.canReceiveSpecial then
            if self.model.pass.canReceiveNormal then
                hideCount = self.model.pass.normal_received_stage
            end
            if self.model.pass.canReceiveSpecial then
                hideCount = math.min(hideCount, self.model.pass.special_received_stage)
            end
        else
            if self.model.pass.level >= maxCount then
                hideCount = maxCount
            else
                hideCount = self.model.pass.level
            end
        end

        local posX = hideCount * RewardItemWidth

        coroutine.start(function()
            coroutine.waitforframes(5)
            if posX > self.rewardContentRect.rect.width - self.viewPortRect.rect.width then
                posX = self.rewardContentRect.rect.width - self.viewPortRect.rect.width
            end
            self.rewardContent.transform:DOLocalMoveX(-posX-10, 0)
        end)

        UIPublic.InitButton(self.getAllButton, self.model.pass.canReceiveNormal or self.model.pass.canReceiveSpecial)
        self.getAllButton.transform:Find("HintRoot").gameObject:SetActive(true)
    else
        self.rewardRoot:SetActive(false)
        self.taskRoot:SetActive(true)
        UIPublic.InitButton(self.getAllButton, table.any(self.tasks, function(task) return task.status == TaskStatus.TaskStatusCompleted end))
        self.getAllButton.transform:Find("HintRoot").gameObject:SetActive(false)
    end
end

function this:OnTaskTypeClick(type)
    self.currentTaskType = type
    for key, value in pairs(self.taskTabList) do
        value.active:SetActive(key == type)
    end

    if self.taskTabList[type].noteSysLangKey ~= nil then
        self.taskRefreshNoteText.text = LangUtil.GetSysLang(self.taskTabList[type].noteSysLangKey)
    else
        self.taskRefreshNoteText.text = ""
    end
    self:RefreshTaskData()
end

function this:RefreshBigReward(refresh)
    local zPassRewad = Z_PassReward[self.model.pass.id]
    local count = self.currentRewardLastShowIndex
    if count == table.count(Z_PassReward[self.model.pass.id]) - 1 then
        -- count 表示所有等级数(奖励表中除去最后一个)
        local rewardCount1 = 0
        local rewardCount2 = 0
        if self.model.pass.level > count then
            if self.model.pass.canReceiveNormal then
                if self.model.pass.normal_received_stage <= count then
                    rewardCount1 = self.model.pass.level - count
                else
                    rewardCount1 = self.model.pass.level - self.model.pass.normal_received_stage
                end
            end
            if self.model.pass.canReceiveSpecial then
                if self.model.pass.special_received_stage <= count then
                    rewardCount2 = self.model.pass.level - count
                else
                    rewardCount2 = self.model.pass.level - self.model.pass.special_received_stage
                end
            end
        end

        local bigRewardIndex = count + 1
        -- 最后一个 后面就显示最后的
        self.bigBattlePassRewardItemRoot:SetActive(true)
        self.currentBigRewardIndex = bigRewardIndex
        self:InitRewardItemData(
            {
                data = zPassRewad[bigRewardIndex],
                go = self.bigBattlePassRewardItem,
                index = bigRewardIndex,
            },
            true,
            true,
            rewardCount1,
            rewardCount2
        )
    else
            local bigRewardIndex
            for i = self.currentRewardLastShowIndex, table.count(zPassRewad) - 1 do
                if zPassRewad[i].IsBigReward == 1 then
                    bigRewardIndex = i
                    break
                end
            end

            if refresh or (bigRewardIndex ~= nil and bigRewardIndex ~= self.currentBigRewardIndex) then
                self.bigBattlePassRewardItemRoot:SetActive(true)
                self.currentBigRewardIndex = bigRewardIndex
                self:InitRewardItemData(
                    {
                        data = zPassRewad[bigRewardIndex],
                        go = self.bigBattlePassRewardItem,
                        index = bigRewardIndex,
                    },
                    true
                )
            elseif bigRewardIndex == nil then
                self.currentBigRewardIndex = nil
                self.bigBattlePassRewardItemRoot:SetActive(false)
            end
    end
end

---@param self UIBattlePassView
local function OnRewardScrollValueChanged(self)
    return function(pos)
        -- 在这里编写处理滚动事件的逻辑
        -- pos 参数表示滚动位置，是一个 Vector2 类型的值，pos.x 和 pos.y 分别表示水平和垂直方向上的滚动位置
        
        -- 访问 self 变量
        -- 例如，如果你想要在垂直方向上滚动位置超过一定阈值时触发事件，你可以这样做：


        -- local pos = scale * ( 总的content - 显示区域 ) + 显示区域 - 半个item
        -- local count = math.floor(pos / (宽度+间隔)) + 1
        local endPos = pos.x * ( self.rewardContentRect.rect.width - self.viewPortRect.rect.width ) + self.viewPortRect.rect.width - RewardItemWidth/2
        local count = math.floor(endPos / RewardItemWidth) + 1
        if count > table.count(Z_PassReward[self.model.pass.id]) - 1 then
            count = table.count(Z_PassReward[self.model.pass.id]) - 1
        end
        
        if count == table.count(Z_PassReward[self.model.pass.id]) - 1 and count ~= self.currentRewardLastShowIndex then
            self.currentRewardLastShowIndex = count
            self:RefreshBigReward()
        elseif count ~= self.currentRewardLastShowIndex then
            self.currentRewardLastShowIndex = count
            self:RefreshBigReward()
        end
    end
end


function this:OnCreate()
    base.OnCreate(self)

    UIPublic.SetBackButton(
        self.rc:GetObject("ReturnButton"),
        UIWindowNames.UIBattlePass,
        577
    )

    self.expBar = self.rc:GetObject("ExpBar"):GetComponent("Scrollbar")

    self.getAllButton = self.rc:GetObject("GetAllButton")
    UIUtil.AddBtnEvent(self.getAllButton, function()
        if self.currentTab == TabType.Reward then
            local beginLevel = self.model.pass.normal_received_stage + 1
            local endLevel = self.model.pass.level
            PublicRequest.SendRequest(
                PROTOCOL.ReceivePassRewardsReq,
                {
                    pass_id = self.model.pass.id,
                },
                function(response)
                    UIManager:GetInstance():OpenWindow(UIWindowNames.UIBattlePassReward,
                        {
                            beginLevel = beginLevel,
                            endLevel = endLevel,
                            passId = self.model.pass.id,
                            response = response,
                        }
                    )
                end,
                function(error)
                    Logger.LogError(error)
                end
            )
        else
            local exp = self.model.pass.progress
            PublicRequest.SendRequest(
                PROTOCOL.TaskSubmitByGroupReq,
                {
                    type = TaskType.TaskTypePass,
                    groups = self.currentTaskGroups,
                },
                function(response, error)
                    if error == 0 then
                        local upExp = 0
                        local rewards = {}
                        for index, value in ipairs(response.reward_result) do
                            if value.type == RewardType.RewardTypePassProgress
                                    or value.type == RewardType.RewardTypePassProgressWithAddition then
                                upExp = upExp + value.count
                            elseif value.type ~= RewardType.RewardTypePassMembership then
                                table.insert(rewards, value)
                            end
                        end
                        if table.count(rewards) > 0 then
                            UIPublic.OpenRewardUI(rewards, nil, nil, function()
                                self:CheckIsLevelUp( self.model.pass.id, exp, upExp)
                            end)
                        else
                            self:CheckIsLevelUp( self.model.pass.id, exp, upExp)
                        end
                    end
                end
            )
        end
    end)

    self.buyLevelButton = self.rc:GetObject("BuyLevelButton")
    UIUtil.AddBtnEvent(self.buyLevelButton, function()
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIBattlePassBuyLevel, {passId = self.model.pass.id})
    end)

    self.unlockButton = self.rc:GetObject("UnlockButton")
    UIUtil.AddBtnEvent(self.unlockButton, function()
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIBattlePassBuyPass, {passId = self.model.pass.id})
    end)

    self.currentTab = TabType.Reward
    self.tabList = {
        {
            root = self.rc:GetObject("RewardButton"),
            syslangKey = 1271, -- 奖励
            hintKey = "PassReward",
        },
        {
            root = self.rc:GetObject("TaskButton"),
            syslangKey = 86, -- 任务
            hintKey = "PassTask",
        }
    }

    for index, type in pairs(TabType) do
        local root = self.tabList[type].root.transform
        self.tabList[type].active = root:Find("Active").gameObject
        self.tabList[type].text = LangUtil.BindText(root:Find("Text"))
        self.tabList[type].text.text = LangUtil.GetSysLang(self.tabList[type].syslangKey)
        LangUtil.BindText(root:Find("Active/Text")).text = LangUtil.GetSysLang(self.tabList[type].syslangKey)
        UIUtil.AddBtnEvent(root, function()
            self:OnTabClick(type)
        end)
    end

    self.rewardRoot = self.rc:GetObject("RewardRoot")
    self.taskRoot = self.rc:GetObject("TaskRoot")

    self.currentTaskType = ShowTaskType.Daily
    local taskTabLayout = self.rc:GetObject("TaskTabLayout").transform
    self.taskTabList = {
        {
            syslangKey = 306, -- 日常
            noteSysLangKey = 1389, -- 每日4点后重置任务
        },
        {
            syslangKey = 1387, -- 每周任务
            noteSysLangKey = 1390, -- 每周一4点后重置任务
        },
        {
            syslangKey = 1388, -- 赛季任务
            noteSysLangKey = nil,
        }
    }
    for i = 0, taskTabLayout.childCount - 1 do
        local index = i + 1
        local child = taskTabLayout:GetChild(i)
        self.taskTabList[index].active = child:Find("Active").gameObject
        self.taskTabList[index].text = LangUtil.BindText(child:Find("Text"))
        self.taskTabList[index].text.text = LangUtil.GetSysLang(self.taskTabList[index].syslangKey)
        self.taskTabList[index].hint = child:Find("Hint").gameObject
        LangUtil.BindText(child:Find("Active/Text")).text = LangUtil.GetSysLang(self.taskTabList[index].syslangKey)
        UIUtil.AddBtnEvent(child, function()
            self:OnTaskTypeClick(index)
        end)
    end

    self.rewardContent = self.rc:GetObject("RewardContent").transform
    self.bigBattlePassRewardItem = self.rc:GetObject("BigBattlePassRewardItem")
    self.bigBattlePassRewardItemRoot = self.rc:GetObject("BigBattlePassRewardItemRoot")
    self.bigBattlePassRewardItemRoot:SetActive(false)
    self.bigBattlePassRewardItemRect = self.bigBattlePassRewardItem:GetComponent("RectTransform")
    self.battlePassRewardItemList = {}
    self.rewardScroll = VerticalScroll.New()
    self.rewardContentRect = self.rewardContent:GetComponent("RectTransform")
    self.rewardContentLayout = self.rewardContent:GetComponent("HorizontalLayoutGroup")
    self.viewPortRect = self.rc:GetObject("RewardViewPort"):GetComponent("RectTransform")
    self.rawBattlePassRewardItemRect = self.rc:GetObject("RawBattlePassRewardItem"):GetComponent("RectTransform")

    self.rewardScrollRect = self.rc:GetObject("RewardScrollView"):GetComponent("ScrollRect")
    self.rewardScrollRect.onValueChanged:AddListener(OnRewardScrollValueChanged(self))

    self.currentTaskGroups = {}
    self.taskScroll = VerticalScroll.New()
    self.taskScrollView = self.rc:GetObject("TaskScrollView")
    self.taskScroll:Clear()
    self.taskScroll:ScrollInit({}, self.taskScrollView, TaskPfbName, function (arg)
        self:InitTaskItemData(arg)
    end)

    self.currentRewardLastShowIndex = 0
    self.currentBigRewardIndex = nil
    RewardItemWidth = self.rewardContentLayout.spacing + self.rawBattlePassRewardItemRect.rect.width

    self.logoTextRoot = self.rc:GetObject("LogoTextRoot")
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnTabClick(self.currentTab)
    self:OnTaskTypeClick(self.currentTaskType)
    self:OnRefresh()
end

function this:Update()
    local seconds = self.model.gameEventModule.endTime - TimeUtil.GetServerTime()
    local tb = TimeUtil.ConvertTimeForm(seconds)
    if tb.day > 0 then
        self.lastTimeText.text = LangUtil.GetSysLang(1326) .. string.format("%d"..LangUtil.GetSysLang(2005).." %02d:%02d:%02d", tb.day, tb.hour, tb.minute, tb.second)
    else
        self.lastTimeText.text = LangUtil.GetSysLang(1326) .. string.format("%02d:%02d:%02d", tb.hour, tb.minute, tb.second)
    end
end

function this:RefreshData()
    self.levelText.text = self.model.pass.level
    self.expText.text = "EXP " .. self.model.pass.currentExp .. "/" .. self.model.pass.config.ProgressPerStage
    self.expBar.size = self.model.pass.currentExp / self.model.pass.config.ProgressPerStage
    self.buyLevelButton:SetActive(self.model.pass.config.MaxBuyLevelLimit > self.model.pass.level)
    self.unlockButton:SetActive(self.model.pass.membership == PassMembership.PassMembershipNormal)
    if self.currentTab == TabType.Reward then
        UIPublic.InitButton(self.getAllButton, self.model.pass.canReceiveNormal or self.model.pass.canReceiveSpecial)
    end
end

function this:RefreshRewardData()
    coroutine.start(function()
        for index = 1, table.count(Z_PassReward[self.model.pass.id])-1 do
            local go = self.battlePassRewardItemList[index]
            if go == nil then
                go = GameObjectPool:GetInstance():CoGetGameObjectAsync(HomeSceneItemPath.."/".. RewardPfbName ..".prefab");
                go.transform:SetParent(self.rewardContent)
                go.transform.localScale = Vector3.one
                self.battlePassRewardItemList[index] = go
            end
            go:SetActive(true)
    
            self:InitRewardItemData(
                {
                    data = Z_PassReward[self.model.pass.id][index],
                    index = index,
                    go = go,
                }
            )
        end
        for i = table.count(Z_PassReward[self.model.pass.id]), #self.battlePassRewardItemList do
            self.battlePassRewardItemList[i]:SetActive(false)
        end
    end)
end

function this:InitRewardItemData(arg, isBigReward, isFinal, rewardCount1, rewardCount2)
    ---@type {Id:number, NormalRewards:string, SpecialRewards:string}
    local data = arg.data
    local object = arg.go
    local index = arg.index
    local transform = object.transform
    ---@type ReferenceCollector
    local rc = transform:GetComponent("ReferenceCollector")
    
    if isFinal then
        LangUtil.BindText(rc:GetObject("LevelText")).text = LangUtil.GetSysLang(1407)
    else
        LangUtil.BindText(rc:GetObject("LevelText")).text = index .. LangUtil.GetSysLang(1392) -- xx級
    end
    local isLevel = self.model.pass.level >= index

    if rewardCount1 == nil or rewardCount1 == 0 then
        LangUtil.BindText(rc:GetObject("RewardCountText1")).text = ""
    else
        LangUtil.BindText(rc:GetObject("RewardCountText1")).text = "x" .. rewardCount1
    end

    if rewardCount2 == nil or rewardCount2 == 0 then
        LangUtil.BindText(rc:GetObject("RewardCountText2")).text = ""
    else
        LangUtil.BindText(rc:GetObject("RewardCountText2")).text = "x" .. rewardCount2
    end

    if isBigReward then 
        rc:GetObject("TopBg1"):SetActive(true)
        rc:GetObject("TopBg2"):SetActive(false)
        rc:GetObject("LevelImage1"):SetActive(true)
        rc:GetObject("LevelImage2"):SetActive(false)
    else
        rc:GetObject("TopBg1"):SetActive(isLevel)
        rc:GetObject("TopBg2"):SetActive(not isLevel)
        rc:GetObject("LevelImage1"):SetActive(isLevel)
        rc:GetObject("LevelImage2"):SetActive(not isLevel)
    end

    UIPublic.InitRewardItem({
        rewardId = data.NormalRewards,
        itemPrefab = rc:GetObject("ItemPrefab"),
        isShowCount = true,
        isShowThingsDetail = true,
    })

    -- 是否购买解锁
    local isUnlock = self.model.pass.membership == PassMembership.PassMembershipSpecial or self.model.pass.membership == PassMembership.PassMembershipPremium
    if isBigReward then
        rc:GetObject("MaskImage"):SetActive(false)
        rc:GetObject("BottomBg1"):SetActive(true)
        rc:GetObject("BottomBg2"):SetActive(false)

        if isFinal then
            rc:GetObject("Mask"):SetActive(false)
            rc:GetObject("Mask1"):SetActive(rewardCount1 == nil or rewardCount1 == 0)
            rc:GetObject("Mask2"):SetActive(rewardCount2 == nil or rewardCount2 == 0)
        else
            rc:GetObject("Mask"):SetActive(false)
            rc:GetObject("Mask1"):SetActive(index <= self.model.pass.special_received_stage or not isUnlock or not isLevel)
            rc:GetObject("Mask2"):SetActive(index <= self.model.pass.special_received_stage or not isUnlock or not isLevel)
        end
    else
        rc:GetObject("MaskImage"):SetActive(not isUnlock)
        rc:GetObject("BottomBg1"):SetActive(isUnlock and isLevel)
        rc:GetObject("BottomBg2"):SetActive(not isUnlock or not isLevel)

        rc:GetObject("Mask"):SetActive(index <= self.model.pass.normal_received_stage)
        rc:GetObject("Mask1"):SetActive(index <= self.model.pass.special_received_stage)
        rc:GetObject("Mask2"):SetActive(index <= self.model.pass.special_received_stage)
    end

    if isFinal then
        rc:GetObject("IsGet"):SetActive(false)
        rc:GetObject("IsGet1"):SetActive(false)
        rc:GetObject("IsGet2"):SetActive(false)
    else
        rc:GetObject("IsGet"):SetActive(index <= self.model.pass.normal_received_stage)
        rc:GetObject("IsGet1"):SetActive(index <= self.model.pass.special_received_stage)
        rc:GetObject("IsGet2"):SetActive(index <= self.model.pass.special_received_stage)
    end
    
    local zReward = Z_Reward[data.SpecialRewards]
    if zReward[1] ~= nil then
        rc:GetObject("ItemPrefab1"):SetActive(true)
        UIPublic.InitRewardItem({
            type = zReward[1].Type,
            id = zReward[1].ObjId,
            count = zReward[1].Count,
            itemPrefab = rc:GetObject("ItemPrefab1"),
            isShowCount = true,
            isShowThingsDetail = true,
        })
        rc:GetObject("Lock1"):SetActive(not isUnlock)
    else
        rc:GetObject("ItemPrefab1"):SetActive(false)
        rc:GetObject("Lock1"):SetActive(false)
    end
    if zReward[2] ~= nil then
        rc:GetObject("ItemPrefab2"):SetActive(true)
        UIPublic.InitRewardItem({
            type = zReward[2].Type,
            id = zReward[2].ObjId,
            count = zReward[2].Count,
            itemPrefab = rc:GetObject("ItemPrefab2"),
            isShowCount = true,
            isShowThingsDetail = true,
        })
        rc:GetObject("Lock2"):SetActive(not isUnlock)
    else
        rc:GetObject("ItemPrefab2"):SetActive(false)
        rc:GetObject("Lock2"):SetActive(false)
    end

end

--- 任务

local function SortTasks(tasks)
    ---@param a Task
    ---@param b Task
    table.sort(tasks,function(a,b)
        if a.status ~= b.status then
            if a.status == TaskStatus.TaskStatusCompleted then
                -- a 完成, b 其他
                return true
            elseif a.status == TaskStatus.TaskStatusProgressing then
                -- a 进行中.  b 完成(false), 其他(true)
                return b.status ~= TaskStatus.TaskStatusCompleted
            else
                -- a 已领取 排在最后
                return false
            end
        end
        return a.Id < b.Id
    end)
    return tasks
end

function this:RefreshTaskData()
    ---@type TaskComponent
    local taskComponent = Game.Scene.Player:GetComponent("TaskComponent")

    self.tasks = {}
    self.currentTaskGroups = {}
    if self.currentTaskType == ShowTaskType.Daily then
        self.currentTaskGroups = self.model.pass.config.DailyTaskGroups
    elseif self.currentTaskType == ShowTaskType.Weekly then
        self.currentTaskGroups = self.model.pass.config.WeeklyTaskGroups
    elseif self.currentTaskType == ShowTaskType.Season then
        self.currentTaskGroups = self.model.pass.config.TaskGroups
    end
    for _, taskGroupId in ipairs(self.currentTaskGroups) do
        local retTasks = taskComponent:GetTasks(TaskType.TaskTypePass, taskGroupId)
        for _, task in ipairs(retTasks) do
            table.insert(self.tasks, task)
        end
    end

    self.tasks = SortTasks(self.tasks)
    self.taskScroll:RefreshData(self.tasks)
    self.taskScroll:MoveTop()

    if self.currentTab == TabType.Task then
        UIPublic.InitButton(self.getAllButton, table.any(self.tasks, function(task) return task.status == TaskStatus.TaskStatusCompleted end))
    end
end


local function SetButton(transform,Id)
    for i = 0 ,transform.childCount - 1 do
        local child = transform:GetChild(i).gameObject
        child:SetActive(Id == i+1)
    end
end

function this:CheckIsLevelUp(passId, exp, upExp)
    local config = Z_Pass[passId]
    local level = exp // config.ProgressPerStage
    local newLevel = (exp + upExp) // config.ProgressPerStage
    if newLevel > level then
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIBattlePassLevelUp, {
            level = newLevel,
            passId = passId
        })   
    end
end

function this:InitTaskItemData(arg)
    ---@type Task
    local task = arg.data
    local object = arg.go
    local transform = object.transform
    ---@type ReferenceCollector
    local rc = transform:GetComponent("ReferenceCollector")

    local avatar = rc:GetObject("Avatar"):GetComponent("Image")
    local itemBg = rc:GetObject("ItemBg"):GetComponent("Image")
    local itemRoot = rc:GetObject("ItemRoot")

    local slider = rc:GetObject("Slider"):GetComponent("Slider")
    local progress_Text = LangUtil.BindText(rc:GetObject("ProgressText"),FontType.All_Number)
    local des_Text = LangUtil.BindText(rc:GetObject("DesText")) 
    local button = rc:GetObject("Buttons").gameObject
    local itemNum = LangUtil.BindText(rc:GetObject("NumTxt"),FontType.All_Number)
    local hint = rc:GetObject("Hint").gameObject
    hint:SetActive(false)

    button.gameObject:SetActive(true)
   
    des_Text.text = task.config.Desc
    if task.Count > task.target then
        task.Count = task.target
    end
    progress_Text.text = task.Count.."/".. task.target
    slider.value = task.Count / task.target

    if task.status == TaskStatus.TaskStatusReceived then --任务完成 领取完成
        button.gameObject:SetActive(true)
        button:GetComponent("Button").enabled = false
        LangUtil.GetSpriteLang(543, function(sprite) button.transform:GetChild(3):GetComponent("Image").sprite = sprite end)
        SetButton(button.transform,4)
    elseif task.status == TaskStatus.TaskStatusCompleted then --任务完成  未领取
        button.gameObject:SetActive(true)
        button:GetComponent("Button").enabled = true
        LangUtil.BindText(button.transform:Find("Lq/Text")).text= LangUtil.GetSysLang(310)
        UIUtil.AddBtnEvent(button,function(go) 
            local exp = self.model.pass.progress
                ---@param response protocol.TaskSubmitResp
                PublicRequest.SendRequest(
                    PROTOCOL.TaskSubmitReq,
                    {
                        type = TaskType.TaskTypePass,
                        task_id = task.Id,
                    },
                    function(response, error)
                        local upExp = 0
                        local rewards = {}
                        for index, value in ipairs(response.reward_result) do
                            if value.type == RewardType.RewardTypePassProgress
                                or value.type == RewardType.RewardTypePassProgressWithAddition then
                                upExp = upExp + value.count
                            elseif value.type ~= RewardType.RewardTypePassMembership then
                                table.insert(rewards, value)
                            end
                        end
                        if table.count(rewards) > 0 then
                            UIPublic.OpenRewardUI(rewards, nil, nil, function()
                                self:CheckIsLevelUp( self.model.pass.id, exp, upExp)
                            end)
                        else
                            self:CheckIsLevelUp( self.model.pass.id, exp, upExp)
                        end
                    end
                )
            button:GetComponent("Button").enabled = false
        end)
        SetButton(button.transform,1)
    else --未完成  未领取
        button:GetComponent("Button").enabled = true
        LangUtil.BindText(button.transform:Find("Jx/Text")).text= LangUtil.GetSysLang(309)
        LangUtil.BindText(button.transform:Find("Tz/Text")).text= LangUtil.GetSysLang(309)

        local zLevelJump = Z_LevelJump[task.config.LevelJump[1]]
        if zLevelJump == nil or zLevelJump[1] == nil then
            SetButton(button.transform, nil)
        else
            local isUnlock = UIPublic.CheckJumpLevel(zLevelJump[1].JumpType, zLevelJump[1].Arg1, zLevelJump[1].Arg2)
            local mask = button.transform:Find("Jx/Mask").gameObject
            mask:SetActive(not isUnlock)
            SetButton(button.transform,2)
            UIUtil.AddBtnEventNoBug(button, function()
                if isUnlock then
                    UIPublic.JumpLevel(zLevelJump[1].JumpType, zLevelJump[1].Arg1, zLevelJump[1].Arg2)
                end
            end)
        end
    end
    
    local rewards = Z_Reward[task.config.RewardId]
    local id, count, type

    local goldCount, goldType
    if rewards ~= nil then
        for _, value in ipairs(rewards) do
            if value.ObjId ~= GOLD_ID then
                id = value.ObjId
                count = value.Count
                type = value.Type
                break
            else
                goldCount = value.Count
                goldType = value.Type
            end
        end
    end

    if id == nil then
        id = GOLD_ID
        count = goldCount
        type = goldType
    end

    if id == nil then
        itemRoot:SetActive(false)
    else
        itemRoot:SetActive(true)
        UIPublic.InitItemIconNew(avatar, itemBg, type, id, count, true, false)
        itemNum.text = count
    end
end

--- 刷新
function this:OnRefresh()

    coroutine.start(function () 
        self.bgImage.sprite = AtlasManager:GetInstance():CoLoadImageAsync(string.format("UI/BattlePass/%s.png", self.model.pass.config.BgImage))
        self.logoImage.sprite = AtlasManager:GetInstance():CoLoadImageAsync(string.format("UI/BattlePass/%s.png", self.model.pass.config.LogoImage))
        self.logoImage:SetNativeSize()
        self.logoText.text = self.model.pass.config.LogoText
        self.logoTextRoot:SetActive(not string.IsNullOrEmpty(self.model.pass.config.LogoText))
    end)

    ---@type HintComponent
    local hintComponent = Game.Scene:GetComponent("HintComponent")
    local eventHint = hintComponent.SingleActivity:GetChild(self.model.gameEventModule.eventId)
    local moduleHint
    if eventHint ~= nil then
        moduleHint = eventHint:GetChild(self.model.gameEventModule.moduleId)
    end
    for index, type in pairs(TabType) do
        local root = self.tabList[type].root.transform
        local hintObject = root:Find("Hint").gameObject
        local hint = moduleHint:GetChild(self.tabList[type].hintKey)
        if hint ~= nil then
            hint:AddObject(hintObject, "tab")
        end
    end

    local taskHint = moduleHint:GetChild("PassTask")
    for index, value in pairs(self.taskTabList) do
        local hint = taskHint:GetChild(index)
        if hint~=nil then
            hint:AddObject(value.hint, "tab")
        else
            value.hint:SetActive(false)
        end
    end

    local rewardHint = moduleHint:GetChild("PassReward")
    if rewardHint ~= nil then
        rewardHint:AddObject(self.getAllButton.transform:Find("HintRoot/Hint").gameObject, "receive")
    end
    self:RefreshData()
    self:RefreshRewardData()
end

---@param self UIBattlePassView
local function ON_PASS_UPDATE_PUSH(self)
    self:RefreshRewardData()
    self:RefreshBigReward(true)
    self:RefreshData()
end

---@param self UIBattlePassView
local function ON_TASK_UPDATE(self, type)
    if type ~= TaskType.TaskTypePass then
        return
    end
    self:RefreshTaskData()
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddUIListener(UIMessageNames.ON_PASS_UPDATE_PUSH, ON_PASS_UPDATE_PUSH)
    self:AddUIListener(UIMessageNames.ON_TASK_UPDATE, ON_TASK_UPDATE)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveUIListener(UIMessageNames.ON_PASS_UPDATE_PUSH)
    self:RemoveUIListener(UIMessageNames.ON_TASK_UPDATE)
end

function this:OnDisable()
    base.OnDisable(self)
end

function this:OnDestroy()
    base.OnDestroy(self)
    self.taskScroll:Dispose()
end

return this
