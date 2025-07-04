---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/3 13:59
---

local UILaunchAtkView = BaseClass("UILaunchAtkView",UIBaseView);
local base = UIBaseView;
local this = UILaunchAtkView

local sectionPfbName = "SubMenuItemButton"; -- 节预制体

local distance = 300;
local beClick;

local pfbName = "StorySectionItem"
local lockPfbName = "StorySectionLockItem"

local DiffImgName = {[1] = "初级",[2] = "中级",[3] = "高级"}; -- ignoreCN


--====================================战阵 阵型强化区域=====================================================

local function InitTeamBattleInfo(self,transform,battleArrayKind,battleArrayLevel,teamIntensId)
    local poke = transform:Find("Poke")
    local battleArray = transform:Find("BattleArray")
    poke.gameObject:SetActive(false)
    battleArray.gameObject:SetActive(false)

    if battleArrayKind ~= 0 and battleArrayLevel ~= 0 then
        battleArray.gameObject:SetActive(true)
        local value = battleArray:Find("Value")
        local text = battleArray:Find("Text"):GetComponent("Text")
        text.text = "第"..battleArrayLevel.."层" -- ignoreCN
        for i = 0,value.childCount - 1 do
            value:GetChild(i).gameObject:SetActive(battleArrayKind == (i + 1))
        end
    end

    if teamIntensId ~= 0 then
        poke.gameObject:SetActive(true)
        local value = poke:Find("Value")
        for i = 0,value.childCount - 1 do
            value:GetChild(i).gameObject:SetActive(teamIntensId == (i + 1))
        end
    end

end

local function InitTeamBattleArea(self,transform,zStoryLevel)
    local player = Game.Scene.Player
    local playerRoot = transform:Find("Player")
    local enemyRoot = transform:Find("Enemy")
    local teamNo = Game.Scene:GetComponent("AgainstComponent").CurTeamNo
    local playerTeam = player:GetComponent("TeamComponent"):Get(teamNo)

    InitTeamBattleInfo(self,playerRoot,playerBattleArrayType,playerBattleArrayLevel,playerTeam.EnhanceType)
    InitTeamBattleInfo(self,enemyRoot,zStoryLevel.BattleArrayKind,zStoryLevel.BattleArrayLevel,zStoryLevel.FormatIntens)
end


--================================敌人区域=====================================================
local function GetMonsterData(v,zStoryLevel) --获取敌人数据
    local temp_tab = {};
    temp_tab.TemplateId = v.id;
    temp_tab.Kind = (v.boss == nil and {2} or {1})[1];
    temp_tab.Level = v.level or zStoryLevel.Level;
    temp_tab.Stage = v.stage or zStoryLevel.Stage;
    temp_tab.Star = v.star or zStoryLevel.Star;
    temp_tab.JadePearlLevel = v.jadePearlLevel or zStoryLevel.JadePearl;
    return temp_tab;
end

local function InsertData(self,batch,zStoryLevel) --填充敌人boss数据
    for k,v in table.pairsByKeys(batch) do
        local tb = GetMonsterData(v,zStoryLevel);
        if tb.Kind == 1 then
            self.bossData = tb;
        else
            if table.first(self.monsterData,function(a) return a.TemplateId == tb.TemplateId end) == nil then
                table.insert(self.monsterData,tb);
            end
        end
    end
end

local function InitMonsterAvatar(self,gameObject,monsterData) --初始化敌人头像
    if monsterData ~= nil then
        gameObject:SetActive(true);
        UIUtil.SetCardSprite(gameObject:GetComponent("Image"),monsterData.TemplateId,1,CardPictureType.Little)
       -- UIUtil.SetSprite(gameObject:GetComponent("Image"), AtlasConfig.CardLittle,Z_Card[monsterData.TemplateId].IconName);
        UIUtil.AddBtnEvent(gameObject,function(go) UIUtil.OpenThingsDetailWindow({monster = monsterData, showType = 4}) end)
    else
        gameObject:SetActive(false);
    end
end

local function InitMonsterArea(self,transform,zStoryLevel) --初始化敌人区域
    local againstComponent = Game.Scene:GetComponent("AgainstComponent");
    local bool1,batch1 = againstComponent:LoadBatch(zStoryLevel.Batch1);
    local bool2,batch2 = againstComponent:LoadBatch(zStoryLevel.Batch2);
    local bool3,batch3 = againstComponent:LoadBatch(zStoryLevel.Batch3);
    local boss = transform:Find("Boss/Avatar").gameObject
    local monsterRoot = transform:Find("MonsterList")
    
    self.bossData = nil
    self.monsterData = {}

    if bool1 then InsertData(self,batch1,zStoryLevel); end
    if bool2 then InsertData(self,batch2,zStoryLevel); end
    if bool3 then InsertData(self,batch3,zStoryLevel); end
    
    InitMonsterAvatar(self,boss,self.bossData)
    for i = 0,monsterRoot.childCount - 1 do
        InitMonsterAvatar(self,monsterRoot:GetChild(i):Find("Avatar").gameObject,self.monsterData[i + 1])
    end
end

--==========================================================================================

--====================================条件奖励区域======================================================
local function InitItemAvatar(self,transform,itemData,starNum) 
    if itemData == nil then transform.gameObject:SetActive(false) return end
   -- local star = transform:Find("Star")
   -- if star ~= nil then
   --     local starText = star:Find("Text"):GetComponent("Text")
   --     if starNum ~= nil then
   --         star.gameObject:SetActive(true)
   --         starText.text = starNum
   --     else
   --         star.gameObject:SetActive(false)
   --     end
   -- end
    local numText = transform:Find("Text"):GetComponent("Text")
    local avatar = transform:GetComponent("Image")
    local data = itemData.reward or itemData
    numText.text = "x"..(data.num or 1)
    local rewardType = data.type or 1   --奖励类型
    local templateId = data.id --模板Id

    UIPublic.InitItemIcon(avatar, nil, rewardType, templateId)
    UIUtil.AddBtnEvent(transform.gameObject, function()
        UIPublic.OpenThingsDetail(rewardType, templateId)
    end)
end

local function InitMustObtainArea(self,transform,zStoryLevel) --初始化必定奖励
    local conditionRewards = loadtable(zStoryLevel.ConditionRewards) --条件奖励 
    local firstPassRewards = loadtable(zStoryLevel.FirstPassRewards) --初通奖励 

    local itemRoot = transform:Find("ItemList")
    local firstPass = transform:Find("FirstPass/Avatar")

    InitItemAvatar(self,firstPass,firstPassRewards[1])
    for i = 0,itemRoot.childCount - 1 do
        local avatar = itemRoot:GetChild(i):Find("Avatar")
        InitItemAvatar(self,avatar,conditionRewards[i+1],i+1)
    end
end

local function InitOddObtainArea(self,transform,zStoryLevel) --初始化几率奖励
    local dropData = loadtable(zStoryLevel.DropRateRewards)
    local itemRoot = transform:Find("DropItemList")
    for i = 0,itemRoot.childCount -1 do
        local avatar = itemRoot:GetChild(i):Find("Avatar")
        InitItemAvatar(self,avatar,dropData[i+1])
    end
end


--==========================================================================================
--===================================奖励条件=====================================================

local function IsCompleteCondition(self,levelId)
    local diff = self.clientData.CurLevelDifficulty
    local curLevelId = levelId or self.clientData["CurLevelId_"..diff]
    local StoryLevelScores = Game.Scene.Player:GetComponent("StoryComponent"):GetLevelScores(self.clientData.CurChapterId)
    if StoryLevelScores[curLevelId] == nil then return {0,0,0} end
    if StoryLevelScores[curLevelId][self.clientData.CurLevelDifficulty] == nil then return {0,0,0} end
    local levelStory = StoryLevelScores[curLevelId][self.clientData.CurLevelDifficulty]
    return {levelStory.IsReachRewardCond1,levelStory.IsReachRewardCond2, levelStory.IsReachRewardCond3}
end

local function InitCondition(self,transform,conditionData,id,isComplete)
    local conditionText = transform:Find("Text"):GetComponent("Text")
   -- local star = transform:Find("Star1/Star2").gameObject
   -- star:SetActive(isComplete == 1)
    conditionText.text = id .."."..UIPublic.GetConditionStr(conditionData);
end

local function InitConditionsArea(self,transform,zStoryLevel) --初始化奖励条件
    local conditionRewards = loadtable(zStoryLevel.ConditionRewards)
    local conditionRoot = transform:Find("bg/Condition")
    local sweepHint = self.fightBtn.transform:Find("Hint").gameObject
    local completeInfo = IsCompleteCondition(self)
    local complete = transform:Find("bg/Complete").gameObject
    complete:SetActive(table.all(completeInfo,function(v) return v == 1  end))
    for i = 0,conditionRoot.childCount -1 do
        local id = i + 1
        InitCondition(self,conditionRoot:GetChild(i),conditionRewards[id],id,completeInfo[id])
    end
    local _bool = table.all(completeInfo,function(v) return v == 1  end)
    sweepHint:SetActive(not _bool)
    self.fightBtn:GetComponent("Button").enabled = _bool

    if _bool then
        self.fightBtn:GetComponent("Image").color =Color.New(1,1,1)
    else
        self.fightBtn:GetComponent("Image").color =Color.New(0.4,0.4,0.4)
    end
end

local function InitPanelDiffButton(self)
    self.diffBtn.transform:Find("Text"):GetComponent("Text").text = DiffImgName[self.clientData.CurLevelDifficulty]
end

--==========================================================================================
local function InitSectionInfoPanel(self,active) --刷新章节信息面板
    local diff = self.clientData.CurLevelDifficulty
    local sectionId = self.clientData["CurLevelId_"..diff]
    local guide=Game.Scene:GetComponent("GuideComponent")
    if guide.GuideRun then
        diff=1
        sectionId=102
    end
    local zStorySection = Z_StorySection[sectionId]
    self.sectionInfoPanel:SetActive(false)
    self.teamBattleInfo.gameObject:SetActive(false)
    if zStorySection.LevelId == 0 and active then
        local data = {}
        data.StoryScript = zStorySection.StoryScript
        data.Id = zStorySection.Id
        self.ctrl:PlaySectionStory(data,diff);
    elseif zStorySection.LevelId ~= 0 then
        local zStoryLevel = Game.Scene:GetComponent("AgainstComponent"):GetZStoryLevel(sectionId,diff)
        local transform = self.sectionInfoPanel.transform
        local titleTxt = transform:Find("LevelTitle"):GetComponent("Text") --关卡标题
        local energyTxt = transform:Find("EnergyOutput"):GetComponent("Text") --体力消耗
        local monsterArea = transform:Find("MonsterIntellig") --敌人区域
        local mustObtainArea = transform:Find("MustObtain") --必定奖励区域
        local oddsObtainArea = transform:Find("OddsObtain") --几率奖励区域
        local conditionsArea = transform:Find("Conditions") --奖励条件区域
        local teamBattleInfo = self.teamBattleInfo --战阵 阵型强化区域
        titleTxt.text = zStorySection.Name --关卡标题
        energyTxt.text = "体力消耗:".. zStoryLevel.EnergyExpend --体力 -- ignoreCN
        coroutine.start(function()
            InitTeamBattleArea(self,teamBattleInfo,zStoryLevel)
            InitMonsterArea(self,monsterArea,zStoryLevel)
            InitMustObtainArea(self,mustObtainArea,zStoryLevel)
            InitOddObtainArea(self,oddsObtainArea,zStoryLevel)
            InitConditionsArea(self,conditionsArea,zStoryLevel) --初始化奖励条件
            InitPanelDiffButton(self) --初始化界面难度按钮
            self.sectionInfoPanel:SetActive(true)
            self.teamBattleInfo.gameObject:SetActive(true)
            UIPublic.SetPopWindowScale(self.sectionInfoPanel.transform,true);
            UIPublic.SetPopWindowScale(self.teamBattleInfo,true);
        end)
    end
end


local function OnClickSectionButton(self,sectionId,active) --点击节
    for k,v in pairs(self.secList) do
        v.gameObject.transform:Find("ActiveImage").gameObject:SetActive(sectionId == v.Id)
    end
    
    local localDiff = self.clientData.CurLevelDifficulty
    self.clientData:SetCurLevel(sectionId,localDiff)
    Game.Scene:GetComponent("AgainstComponent"):SetCurLevel({LevelType = LevelType.LevelTypeStory,CurLevelId =sectionId })
    InitSectionInfoPanel(self,active)
end

local function InitSectionButton(self,secListData) --初始节按钮
    local gameObject = secListData.gameObject
    local transform = gameObject.transform
    local sectionId = secListData.Id
    local clear0 = transform:Find("0").gameObject
    local clear1 = transform:Find("ActiveImage/1").gameObject
    transform:Find("Text"):GetComponent("Text").text = Z_StorySection[sectionId].Name
   
    if not secListData.IsVir then
        gameObject:GetComponent("Button").enabled = true
        gameObject:GetComponent("Image").color = Color.New(1,1,1)
        UIUtil.AddBtnEvent(gameObject,function(go) OnClickSectionButton(self,sectionId,true)  end)
    else
        gameObject:GetComponent("Image").color = Color.New(1,1,1,0.6)
        gameObject:GetComponent("Button").enabled = false
    end
    
    local completes = IsCompleteCondition(self,sectionId)
    local _bool = table.all(completes,function(v) return v == 1  end)
    clear0:SetActive(_bool)
    clear1:SetActive(_bool)
    
end

local function InitSectionContent(self)
    self.secList = {}
    self.sectionView:SetActive(false)
    ListChildPool:GetInstance():ClearContent(self.secContent)
    coroutine.start(function()
        for k,v in table.pairsByKeys(self.sectionData) do
            ListChildPool:GetInstance():GetChild(sectionPfbName,self.secContent,function(gameObject) 
                local secData = {}
                secData.gameObject = gameObject
                gameObject.transform:SetAsFirstSibling()
                secData.Id = v.Id
                secData.IsVir = false
                table.insert(self.secList, secData)
                InitSectionButton(self,secData)
            end)
        end
        local lastData = self.secList[#self.secList]  --获取后2关
        local virTab = {}  
        for k,v in table.pairsByKeys(Z_StorySection) do
            if v.ChapterId == 1 and v.Id > lastData.Id and v.Id <=  (lastData.Id + 2) then
                table.insert(virTab,v)
            end
        end
        for k,v in table.pairsByKeys(virTab) do
            ListChildPool:GetInstance():GetChild(sectionPfbName,self.secContent,function(gameObject)
                local secData = {}
                secData.gameObject = gameObject
                gameObject.transform:SetAsFirstSibling()
                secData.Id = v.Id
                secData.IsVir = true
                table.insert(self.secList, secData)
                InitSectionButton(self,secData)
            end)
        end
        local diff = self.clientData.CurLevelDifficulty
        local curLevelId = self.clientData["CurLevelId_"..diff]
        OnClickSectionButton(self,curLevelId)
        coroutine.waitforframes(2)
        local selectData = table.first(self.secList,function(v) return v.Id == curLevelId end)
        if selectData ~= nil then
            local select = selectData.gameObject
            local index = select.transform:GetSiblingIndex();
            local childCount = select.transform.parent.childCount;
            self.sectionView:GetComponent("ScrollRect"):DOVerticalNormalizedPos(1- index/childCount,0);
        else
            self.sectionView:GetComponent("ScrollRect"):DOVerticalNormalizedPos(0,0);
        end
        self.sectionView:SetActive(true)
    end)
end

local function OnClickReadyButton(self) --点击出击准备
    local diff = self.clientData.CurLevelDifficulty
    local curLevelId = self.clientData["CurLevelId_"..diff]
    local sectionId = curLevelId
    local zStoryLevel = Game.Scene:GetComponent("AgainstComponent"):GetZStoryLevel(sectionId,diff)
    local launchAtkData = {}
    launchAtkData.Skip = self.toggle:GetComponent("Toggle").isOn;
    launchAtkData.CurLevelId = sectionId
    launchAtkData.CurLevelDifficulty = diff
    launchAtkData.LevelType = LevelType.LevelTypeStory
    launchAtkData.EnergyExpend = zStoryLevel.EnergyExpend
   -- launchAtkData.parent = UIWindowNames.UILaunchAtkBg
  --  UIManager:GetInstance():CloseWindow(UIWindowNames.UILaunchAtkBg)
    self.ctrl:OpenReadyWindow(launchAtkData);
end

local function OnClickFightButton(self) --点击扫荡
    local diff = self.clientData.CurLevelDifficulty
    local curLevelId = self.clientData["CurLevelId_"..diff]
    local sectionId = curLevelId
    local zStoryLevel = Game.Scene:GetComponent("AgainstComponent"):GetZStoryLevel(sectionId,diff)
    if zStoryLevel.EnergyExpend > Game.Scene.Player.Energy then
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(1022));--"体力不足"
        return;
    end
    local send_data = {};
    send_data.LevelTypeInfo = 0;
    send_data.LevelId = sectionId
    send_data.Difficulty = diff
    send_data.IsReachRewardCond1 = 1;
    send_data.IsReachRewardCond2 = 1;
    send_data.IsReachRewardCond3 = 1;
    send_data.IsSweep = 1;
    self.ctrl:SendMopUpRequest(send_data);
end

local function InitDiffButton(self,gameObject,isOpen,id) --初始化难度按钮
    --UIUtil.AddBtnEvent(gameObject,function(go)
    --    if self.clientData.CurLevelDifficulty ~= id then
    --        local diff = self.clientData.CurLevelDifficulty
    --        local curLevelId = self.clientData["CurLevelId_"..diff]
    --        self.clientData:SetCurLevel(curLevelId,id)
    --        local text = self.diffBtn.transform:Find("Text"):GetComponent("Text")
    --        text.text = DiffImgName[id]
    --        InitSectionInfoPanel(self)
    --    end
    --    self.selectPanel:SetActive(false)
    --    self.diffBtn.transform:Find("Active").gameObject:SetActive(false)
    --end)
    --gameObject.transform:Find("Active").gameObject:SetActive(id == self.clientData.CurLevelDifficulty)
    --gameObject.transform:Find("Text"):GetComponent("Text").color = (isOpen and {Color.New(1,1,1)} or {Color.New(0.3,0.3,0.3)})[1]
    --gameObject:GetComponent("Button").enabled = isOpen
end


local function OnClickDiffButton(self) --点击难度
    local diff = self.clientData.CurLevelDifficulty
    local curLevelId = self.clientData["CurLevelId_"..diff]
    self.selectPanel:SetActive(true)
    self.diffBtn.transform:Find("Active").gameObject:SetActive(true)
    local btnRoot =  self.selectPanel.transform:Find("bg")
    local diffInfoTab = self.model:GetSelectData(curLevelId)
    for i = 0,btnRoot.childCount -1 do
        local btn = btnRoot:GetChild(i).gameObject
        InitDiffButton(self,btn,diffInfoTab[i + 1],i + 1)
    end
end

local function ActiveAnimation(self)
    local transform = self.sectionView.transform
    transform:DOLocalMoveX(transform.localPosition.x + distance,0)
    transform:DOLocalMoveX(self.sectionViewPosX,0.5)
    DataManager:GetInstance():Broadcast(DataMessageNames.ON_UI_TOP_CHG);
end


local function InitDiffList(self)
    local diff = self.clientData.CurLevelDifficulty
    if (diff == 3 and self.model.completed_sectionId_2 <  self.model.maxSection )or
            (diff == 2 and self.model.completed_sectionId_1 <  self.model.maxSection ) then
        self.clientData:SetCurLevel(101,1)
        diff = 1
    end

    for k,v in pairs(self.diffList) do
        local _bool = k == diff
        local transform = v.transform
        local active = transform:Find("Active").gameObject
        local button = v:GetComponent("Button")
        active:SetActive(_bool)
        button.enabled = not _bool
    end
end

local function OnClickDiff(self,Id)
    if Id == 2 then
        if self.model.completed_sectionId_1 < self.model.maxSection then
            UIUtil.ToolTipFourth("难度二未开启") -- ignoreCN
            return
        end
    elseif Id == 3 then
        if self.model.completed_sectionId_2 < self.model.maxSection then
            UIUtil.ToolTipFourth("难度三未开启") -- ignoreCN
            return
        end
    end

    self.clientData:SetCurLevel(nil,Id)
    self:OnRefresh()

    table.csenuObject(self.secContent.transform,function(v)
        local img = v:GetComponent("Image")
        if  img~= nil and img.color.A == 1 then
            img:DOFade(0,0)
            img:DOFade(1,0.5)
        end
    end)
    
    UIPublic.SetPopWindowScale(self.sectionView.transform,true,nil,sectionPfbName);
end


local function OnReadyClose(self)
   
end

local function OnCloseButton(self)
    self.sectionInfoPanel:SetActive(false)
    for k,v in pairs(self.secList) do
        v.gameObject.transform:Find("ActiveImage").gameObject:SetActive(false)
    end
    OnReadyClose(self)
end

function this.OnCreate(self)
    base.OnCreate(self);
    self.secContent = self.rc:GetObject("SectionList")
    self.selectPanel = self.rc:GetObject("SelectBg")
    self.sectionInfoPanel = self.rc:GetObject("LevelIntellig")
    self.sectionView = self.rc:GetObject("Scroll View")
    self.close_btn = self.rc:GetObject("Close")
    self.teamBattleInfo = self.rc:GetObject("TeamBattleInfo").transform
    self.sectionViewPosX = self.sectionView.transform.localPosition.x
    local diffCtrl = self.rc:GetObject("DiffCtrl").transform
    self.diffList = {}
    
    for i = 0,diffCtrl.childCount -1 do
        self.diffList[i+1] = diffCtrl:GetChild(i).gameObject
        UIUtil.AddBtnEvent(self.diffList[i+1],function(go)
            OnClickDiff(self,i+1)
        end)
    end

    self.backBtn = self.rc:GetObject("ReturnButton")
    self.intensBtn = self.rc:GetObject("IntensButton")
    self.formatBtn = self.rc:GetObject("FormatButton")
    self.toggle = self.rc:GetObject("Toggle")
    self.diffBtn = self.rc:GetObject("DiffButton")
    self.fightBtn = self.rc:GetObject("FightButton")
    self.readyBtn = self.rc:GetObject("ReadyButton")

    UIUtil.AddBtnEvent(self.backBtn,function(go) self.ctrl:CloseSelf() end)
    UIUtil.AddBtnEvent(self.intensBtn,function(go)
     --   UIManager:GetInstance():CloseWindow(UIWindowNames.UILaunchAtkBg)
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIMainIntens,UIWindowNames.UILaunchAtkBg)
    end)
    UIUtil.AddBtnEvent(self.formatBtn,function(go)
       -- UIManager:GetInstance():CloseWindow(UIWindowNames.UILaunchAtkBg)
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIFormatNew)
    end)
    UIUtil.AddBtnEvent(self.diffBtn,function(go)  OnClickDiffButton(self)  end)
    UIUtil.AddBtnEvent(self.fightBtn,function(go) OnClickFightButton(self) end)
    UIUtil.AddBtnEvent(self.readyBtn,function(go) OnClickReadyButton(self) end)
    EventTriggerListener.Get(self.selectPanel.transform:Find("EventBg").gameObject).onLuaClick = function(go)
        self.selectPanel:SetActive(false)
        self.diffBtn.transform:Find("Active").gameObject:SetActive(false)
    end
    self.selectPanel:SetActive(false)
    UIUtil.AddBtnEvent(self.close_btn,function()OnCloseButton(self)  end)
end

function this.OnEnable(self)
    base.OnEnable(self);
    self:OnRefresh()
end


function this.OnRefresh(self)
    print("--刷新数据")
    self._bool = true
    self.secList = {}
    self.clientData = ClientData:GetInstance()
    InitDiffList(self)
    self.sectionData = self.model:GetCurSectionData()
    InitSectionContent(self)
end

local function OnLaunchOpen(self)
   
end


function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddUIListener(UIMessageNames.UILAUNCHATK_ON_STORY_MAIN_CHG,self.OnRefresh);
    self:AddUIListener(UIMessageNames.ON_LAUNCH_OPEN,OnLaunchOpen);
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
    self:RemoveUIListener(UIMessageNames.UILAUNCHATK_ON_STORY_MAIN_CHG);
    self:RemoveUIListener(UIMessageNames.ON_LAUNCH_OPEN);
end

function this.OnDisable(self)
    base.OnDisable(self);
    ListChildPool:GetInstance():ClearContent(self.secContent)
    self.secList = {}
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this

