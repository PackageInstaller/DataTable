---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/5/24 16:58
---

local UITransitionView = BaseClass("UITransitionView",UIBaseView)
local base = UIBaseView
local this = UITransitionView


local function OnClickBattle(self)
    if self.zStorySection.Power > UIPublic.GetItemAmount( Z_Misc["POWER_ID"].Value[1]) then
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(1022))
        UIManager:GetInstance():OpenWindow(UIWindowNames.ToolTipAddPower)
        return
    end

    local storyInfo = self.clientData:GetStoryRecord(self.clientData.CurChapterId)
    local diff = storyInfo.Difficulty
    local sectionId = storyInfo.SectionId[diff]
    --local zStoryLevel = self.againstComponent:GetZStoryLevel(sectionId,diff)

    local level_packs = table.first(Game.Scene.Player:GetComponent("StoryComponent").level_packs, function(v)
                            return v.level_type == self.LevelType
                        end)
    local passTimes = 0

    if level_packs ~= nil then
        for _, value in ipairs(level_packs.levels) do
            if value.id == self.model.info.levelId then
                passTimes = value.pass_times
            end
        end
    end

    local launchAtkData = {}
    launchAtkData.Skip = (passTimes > 0)
    launchAtkData.CurLevelId = self.zStorySection.Id--sectionId
    launchAtkData.CurLevelDifficulty = diff
    launchAtkData.LevelType = self.LevelType
    launchAtkData.EnergyExpend = self.zStorySection.Power--Z_BattleLevel[Z_StorySection[sectionId].LevelId].EnergyExpend--zStoryLevel.EnergyExpend

    --launchAtkData
    UIUtil.OpenFormat({
        type = FormationOpenType.Battle,
        isSupport = true,
        confirmCallBack = function(extraParam)
            
            UIPublic.LaunchAtk(launchAtkData, extraParam)
            UIManager:GetInstance():CloseWindow(UIWindowNames.UIFormatNew)
        end
    })
    
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIStorySectionInfo)
    if self.model.info.callBack ~= nil then
        self.model.info.callBack()
    end
end

function this.AutoClickBattle(self)
    self.toggle.isOn = true
    OnClickBattle(self)
end

local function OnClickMop(self)
    if UIPublic.CheckOutOfLimit(RewardType.RewardTypeEquipment, 1) then --装备背包满了
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(1376))
        return
    end

    if self.completesCount < 3 then --没有完成全部条件时 不能扫荡
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(2171))
        return
    end

    UIManager:GetInstance():OpenWindow(UIWindowNames.UIUseItem, {
        costPower = self.zStorySection.Power,
        type = UseItemType.Power,
        levelType = self.model.info.levelTypeId,
        levelId = self.zStorySection.Id
    })
end

local function InitBot(self,zStorySection)
    LangUtil.GetSpriteLang(448 + self.Diff,function(sprite)
        self.DiffImager.sprite = sprite
    end)
    local apNumber = zStorySection.Power
    self.needEnergyTxt.text = apNumber
    self.needEnergyTxt1.text = apNumber
end

local function InitLeft(self,zStorySection)
    local enemyRoot = self.left:Find("MonsterPanel/EnemyRoot")

    local launchAtkData = {}
    launchAtkData.CurLevelId = zStorySection.Id
    launchAtkData.CurLevelDifficulty = diff
    launchAtkData.LevelType = self.LevelType
    UIBattelModeInfo.NewInitMonsterArea(enemyRoot, zStorySection.LevelId )
end

local function IsCompleteCondition(self, levelId)
    if self.levelServerInfo ~= nil then
        return {
            self.levelServerInfo.reached_goals[1], 
            self.levelServerInfo.reached_goals[2], 
            self.levelServerInfo.reached_goals[3]
        }
    else
        return {0,0,0}
    end
end

local function InitRight(self,zStorySection)
    local conditionRoot = self.right:Find("Conditions/Condition")
    local drop = self.right:Find("Drop/ScrollView/Viewport/Content")

    local condition = Z_BattleLevel[zStorySection.LevelId].PerfectConditions
    local completes = IsCompleteCondition(self,zStorySection.Id)

    if self.levelServerInfo ~= nil then
        if self.levelServerInfo.firstDropAvailable == true then --月塔相关特殊处理
            completes = {}
        end
    end
    

    conditionRoot.transform:Find("Condition1"):Find("Text"):GetComponent("Text").text = Z_BattleEndCondition[condition[1]].Description 
    conditionRoot.transform:Find("Condition2"):Find("Text"):GetComponent("Text").text = Z_BattleEndCondition[condition[2]].Description 
    conditionRoot.transform:Find("Condition3"):Find("Text"):GetComponent("Text").text = Z_BattleEndCondition[condition[3]].Description 

    conditionRoot.transform:Find("Condition1/Star1").gameObject:SetActive(table.count(table.choose(completes,function(k,v) return v == 1  end)) == 0)
    conditionRoot.transform:Find("Condition1/Star2").gameObject:SetActive(table.count(table.choose(completes,function(k,v) return v == 1  end)) ~= 0)
    conditionRoot.transform:Find("Condition2/Star1").gameObject:SetActive(table.count(table.choose(completes,function(k,v) return v == 2  end)) == 0)
    conditionRoot.transform:Find("Condition2/Star2").gameObject:SetActive(table.count(table.choose(completes,function(k,v) return v == 2  end)) ~= 0)
    conditionRoot.transform:Find("Condition3/Star1").gameObject:SetActive(table.count(table.choose(completes,function(k,v) return v == 3  end)) == 0)
    conditionRoot.transform:Find("Condition3/Star2").gameObject:SetActive(table.count(table.choose(completes,function(k,v) return v == 3  end)) ~= 0)

    self.completesCount = table.count(table.choose(completes,function(k,v) return v ~= 0 end))

    self.mopBtn.gameObject:SetActive(self.completesCount > 0)
    
    self.mopBtn.transform:Find("Mask").gameObject:SetActive(self.completesCount ~= 3)

    self.mopBtn.gameObject:SetActive(zStorySection.IsCloseSweep == 0)

    self.HalfSweepAp.gameObject:SetActive(zStorySection.IsHalfPower == 1)
    self.HalfAp.gameObject:SetActive(zStorySection.IsHalfPower == 1)
    
    for i = 0, 19 do
        drop:GetChild(i).gameObject:SetActive(false)
    end

    self.InitDropList(self, drop, Z_DropPreview[zStorySection.DropPreview])
end

function this.InitDropList(self, transform, data)
    if data == nil then data = {} end
    local itemList = {}

    local levelInfoData = self.levelServerInfo

    if levelInfoData == nil or levelInfoData.pass_times == 0 then
        self.pairsItem(self,data.FirstDropId, 1,itemList, false)
    elseif self.model.info.levelTypeId == LevelType.LevelTypeSevenStar then
        self.pairsItem(self,data.FirstDropId, 1,itemList, levelInfoData.PassTimes ~= 0)
    elseif self.model.info.levelTypeId == LevelType.LevelTypeStory then
        self.pairsItem(self,data.FirstDropId, 1,itemList, levelInfoData.pass_times ~= 0)
    elseif self.model.info.levelTypeId == LevelType.LevelTypeGameEvent then
        self.pairsItem(self,data.FirstDropId, 1,itemList, levelInfoData.pass_times ~= 0)
    elseif self.model.info.levelTypeId == LevelType.LevelTypeMonthlyTower then
        self.pairsItem(self,data.FirstDropId, 1,itemList, levelInfoData.firstDropAvailable ~= true)
    elseif self.model.info.levelTypeId == LevelType.LevelTypeTower then
        self.pairsItem(self,data.FirstDropId, 1,itemList, levelInfoData.firstDropAvailable ~= true)
    else
        self.pairsItem(self,data.FirstDropId, 1,itemList, levelInfoData.passTimes ~= 0)
    end

    if levelInfoData == nil or #levelInfoData.reached_goals ~= 3 then
        self.pairsItem(self,data.FirstPerfectDropId, 2,itemList, false)
    else
        self.pairsItem(self,data.FirstPerfectDropId, 2,itemList, #levelInfoData.reached_goals == 3)
    end
    
    self.pairsItem(self,data.NormalDropId, 3 ,itemList, false)
    self.pairsItem(self,data.ExtraDropId, 4, itemList, false)

    if #itemList == 0 then
        return
    end

    for index, value in ipairs(itemList) do
        local itemTransform = transform:GetChild(index - 1)
        itemTransform.gameObject:SetActive(true)
        local FirstDropImage = itemTransform:Find("FirstDropImage")
        local PerfectDropImage = itemTransform:Find("PerfectDropImage")
        local NormalDropImage = itemTransform:Find("NormalDropImage")
        local Avatar = itemTransform:Find("Panel/Avatar"):GetComponent("Image")
        local BG = itemTransform:Find("Panel/Bg"):GetComponent("Image")
        local Clear = itemTransform:Find("Clear")

        if value.itemType == 1 then
            FirstDropImage.gameObject:SetActive(true)
            PerfectDropImage.gameObject:SetActive(false)
            NormalDropImage.gameObject:SetActive(false)
        elseif value.itemType == 2 then
            FirstDropImage.gameObject:SetActive(false)
            PerfectDropImage.gameObject:SetActive(true)
            NormalDropImage.gameObject:SetActive(false)
        elseif value.itemType == 3 then
            FirstDropImage.gameObject:SetActive(false)
            PerfectDropImage.gameObject:SetActive(false)
            NormalDropImage.gameObject:SetActive(true)
        else
            FirstDropImage.gameObject:SetActive(false)
            PerfectDropImage.gameObject:SetActive(false)
            NormalDropImage.gameObject:SetActive(false)
        end

        UIPublic.InitItemIconNew(Avatar, BG, value.RewardType, value.RewardId)
        Clear.gameObject:SetActive(value.isClear)

        UIUtil.AddBtnEvent(itemTransform, function()
            local showData ={}
            showData.tempId = value.RewardId
            showData.showType = ShowType.Item
            UIUtil.OpenThingsDetailWindow(showData)
        end)
    end
end

function this.pairsItem(self, dropList, type, itemList, isClear)
    if dropList == nil or #dropList ==0 then
        return
    end

    for _, dropId in ipairs(dropList) do
        local rewardList = Z_Reward[dropId]
        if rewardList == nil then
            print(dropId .. "在reward表中不存在")
            break
        end
        for _, value in ipairs(rewardList) do
            local item = {
                RewardId = value.ObjId,
                RewardType = value.Type,
                itemType = type,
                isClear = isClear
            }
            local isExist = table.any(itemList, function(v) 
                if  v.itemType == 1 then
                    return false
                elseif v.RewardId == value.RewardId and v.itemType == type then
                    return true
                else
                    return false
                end
    
            end)
            if not isExist then
                table.insert(itemList, item)
            end
        end
    end
end


function this.OnLangCreate(self)
    self.titleTxt = LangUtil.BindText(self.langRc:GetObject("Title3Text"))
    self.LevelText = LangUtil.BindText(self.langRc:GetObject("LevelText"))
    self.needEnergyTxt = LangUtil.BindText(self.battleBtn:Find("NeedEnegy/NeedEnegyText"))
    self.needEnergyTxt1 = LangUtil.BindText(self.mopBtn:Find("NeedEnegy/NeedEnegyText"))
end

function this.OnCreate(self)
    base.OnCreate(self)
    local rc = self.rc
    local closeBtn = rc:GetObject("CloseButton")
    local eventBg = rc:GetObject("EventBg")
    self.left = rc:GetObject("Left").transform
    self.right = rc:GetObject("Right").transform
    local bot = rc:GetObject("Bot").transform

    self.battleBtn = bot:Find("BattleButton")
    self.mopBtn = bot:Find("MopButton")
    self.toggle = bot:Find("SkipToggle"):GetComponent("Toggle")
    self.DiffImager = bot:Find("Diff"):GetComponent("Image")
    self.HalfSweepAp = bot:Find("HalfSweepAp"):GetComponent("Image")
    self.HalfAp = bot:Find("HalfAp"):GetComponent("Image")

    UIUtil.AddBtnEvent(self.battleBtn,function()OnClickBattle(self)end)
    UIUtil.AddBtnEvent(self.mopBtn,function()OnClickMop(self)end)
    
    local func = function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIStorySectionInfo)
        if self.model.info.callBack ~= nil then
            self.model.info.callBack()
        end
    end
    EventTriggerListener.Get(eventBg).onLuaClick = function()func() end
    UIUtil.AddBtnEvent(closeBtn,function()func() end)
end

function this.OnEnable(self)
    base.OnEnable(self)
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIComTop)
    self.comTopView = UIManager:GetInstance():GetWindow(UIWindowNames.UIComTop).View
    self.comTopView:InitComTop(self, self:GetName())

    self.gameObject:SetActive(false)
    self.againstComponent = Game.Scene:GetComponent("AgainstComponent")
    self.toggle.isOn = self.againstComponent.StorySkip
    self.player = Game.Scene.Player
    self.clientData = ClientData:GetInstance()
    self.info = self.model.info
    self:OnRefresh()
    self.gameObject:SetActive(true)
end

function this.OnDisable(self)
    base.OnDisable(self)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIComTop)
    self.againstComponent.StorySkip = self.toggle.isOn
end

function this.OnRefresh(self, info)
    local zStorySection -- 获取主线关卡服务器数据
    if self.model.info.levelTypeId == LevelType.LevelTypeStory or self.model.info.levelTypeId == LevelType.LevelTypeGameEvent then
        if self.model.info.levelTypeId == LevelType.LevelTypeStory then
            zStorySection = Z_StorySection[self.model.info.levelId]
        else
            zStorySection = Z_GameEventsLevel[self.model.info.levelId]
        end
        self.LevelType = self.model.info.levelTypeId
        self.Diff = zStorySection.Difficulty
        local storyComponent = Game.Scene.Player:GetComponent("StoryComponent")
        self.levelServerInfo = nil 
        if storyComponent.StoryChapters[self.model.info.levelTypeId] ~= nil then
            if storyComponent.StoryChapters[self.model.info.levelTypeId].CompletedSections[tonumber(zStorySection.ChapterId)] ~= nil then
                if storyComponent.StoryChapters[self.model.info.levelTypeId].CompletedSections[tonumber(zStorySection.ChapterId)].StoryLevelScoreInfoList[zStorySection.Id] ~= nil then
                    self.levelServerInfo = storyComponent.StoryChapters[self.model.info.levelTypeId].CompletedSections[tonumber(zStorySection.ChapterId)].StoryLevelScoreInfoList[zStorySection.Id]
                end
            end
        end
    elseif self.model.info.levelTypeId == LevelType.LevelTypeChallenge then -- 获取挑战关卡服务器数据
        zStorySection = Z_Challenge[self.model.info.levelId]
        self.LevelType = LevelType.LevelTypeChallenge
        self.Diff = zStorySection.Diff
        local commonLevelComponent = Game.Scene.Player:GetComponent("CommonLevelComponent")
        self.levelServerInfo = commonLevelComponent.CommonLevels[LevelType.LevelTypeChallenge][zStorySection.TypeId][zStorySection.Id]

        for _, levelInfo in ipairs(commonLevelComponent.CommonLevels[LevelType.LevelTypeChallenge][zStorySection.TypeId]) do
            if levelInfo.id == zStorySection.Id then
                self.levelServerInfo = levelInfo
            end
        end

    elseif self.model.info.levelTypeId == LevelType.LevelTypeSevenStar then -- 获取七星关卡服务器数据
        zStorySection = Z_SevenStar[self.model.info.levelId]
        self.LevelType = LevelType.LevelTypeSevenStar
        self.Diff = zStorySection.Diff
        local sevenStarComponent = Game.Scene.Player:GetComponent("SevenStarComponent")
        self.levelServerInfo = sevenStarComponent.Days[zStorySection.ChapterId][zStorySection.Day][zStorySection.Diff]

    elseif self.model.info.levelTypeId == LevelType.LevelTypeTower then -- 获取永久塔服务器数据
        zStorySection = Z_LordTower[self.model.info.levelId]
        self.LevelType = LevelType.LevelTypeTower
        self.Diff = 1
        local commonLevelComponent = Game.Scene.Player:GetComponent("CommonLevelComponent")

        for _, levelInfo in ipairs(commonLevelComponent.CommonLevels[LevelType.LevelTypeTower]) do
            if levelInfo.id == zStorySection.Id then
                self.levelServerInfo = levelInfo
            end
        end
    elseif self.model.info.levelTypeId == LevelType.LevelTypeMonthlyTower then -- 获取月塔服务器数据
        zStorySection = Z_MonthlyTowerLevel[self.model.info.levelId]
        self.LevelType = LevelType.LevelTypeMonthlyTower
        self.Diff = 1
        local commonLevelComponent = Game.Scene.Player:GetComponent("CommonLevelComponent")

        for _, levelInfo in ipairs(commonLevelComponent.CommonLevels[LevelType.LevelTypeMonthlyTower]) do
            if levelInfo.id == zStorySection.Id then
                self.levelServerInfo = levelInfo
            end
        end
    end

    self.zStorySection = zStorySection

    --local zStoryLevel = self.againstComponent:GetZStoryLevel(sectionId,diff)
    self.titleTxt.text = zStorySection.Name
    self.LevelText.text = zStorySection.Number--LangUtil.GetSysLang(500) .. zStoryLevel.HintLevel
    InitBot(self,zStorySection)
    InitLeft(self,zStorySection)
    InitRight(self,zStorySection)
end





return this

