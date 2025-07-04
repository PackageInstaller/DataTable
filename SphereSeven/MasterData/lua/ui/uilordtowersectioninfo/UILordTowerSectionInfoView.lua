---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/5/24 16:58
---

local UILordTowerSectionInfoView = BaseClass("UILordTowerSectionInfoView",UIBaseView);
local base = UIBaseView
local this = UILordTowerSectionInfoView
local levelNames = {[1]="A",[2]="B",[3]="C",[4]="D"}
local maxLevel = 110

local function OnClickMop(self)
    local item = table.first(Game.Scene.Player:GetComponent("ItemComponent").Items,function(v) return v.TemplateId == 3013 end)
    local zStoryLevel = self.againstComponent:GetZLordTowerLevel(self.selectLevel,self.selectDiff)
    local KilEnemyNum = UIBattelModeInfo.GetMonsterTotalNum(zStoryLevel)
    
    local launchAtkData = {}
    launchAtkData.Skip = true
    launchAtkData.CurLevelId = self.selectLevel
    launchAtkData.CurLevelDifficulty = self.selectDiff
    launchAtkData.LevelType = LevelType.LevelTypeMonthlyTower
    launchAtkData.EnergyExpend = zStoryLevel.EnergyExpend
    Game.Scene:GetComponent("AgainstComponent"):SetCurLevel(launchAtkData)

    local sendFastData ={Energy = self.zStoryLevel.EnergyExpend, info = "UILordTowerSectionInfo"}
    sendFastData.maxNum = 1
    Game.Scene.Player:GetComponent("StoryComponent"):SendFastPass(sendFastData,function(itemNum)
        coroutine.start(function()
            local reqData = {}
            reqData.LevelTypeInfo = 4 
            reqData.LevelId = self.selectLevel
            reqData.Difficulty = self.selectDiff
            
            reqData.IsReachRewardCond1 = 1
            reqData.IsSweep = 1
            local g2cBattleSettle = coroutine.yieldstart(Game.Scene.Session.CoCall, nil,  Game.Scene.Session,
                    OuterOpcode.Name2Code.ETModel_C2M_BattleSettle, reqData);
            if g2cBattleSettle.Error == ErrorCode.ERR_Success then
                UIUtil.RemoveItem(item.Id,itemNum)
                UIUtil.BattleSettle(g2cBattleSettle, reqData)
                local storyComponent = Game.Scene.Player:GetComponent("StoryComponent")
                local strTab = {"A","B","C","D"}
                if storyComponent["TowerHistory"..strTab[reqData.Difficulty]] < reqData.LevelId then
                    storyComponent["TowerHistory"..strTab[reqData.Difficulty]] = reqData.LevelId
                end
                storyComponent["Tower"..strTab[reqData.Difficulty]] = reqData.LevelId
                local zLordTower = table.first(Z_LordTower,function(v) return v.Id == reqData.LevelId  end)
                if zLordTower.NextSectionId ~= 0 then
                    ClientData:GetInstance():SetLordTowerLevel(zLordTower.NextSectionId,reqData.Difficulty)
                end
                UIManager:GetInstance():CloseWindow(UIWindowNames.UILordTowerSectionInfo)
                DataManager:GetInstance():Broadcast(DataMessageNames.ON_LORD_TOWER_DIFF_CHG)
            else
                UIUtil.ToolTipFourth(LangUtil.GetServerError(g2cBattleSettle.Error))
            end
        end)
    end)
end

local function InitSectionPanel(self,zStoryLevel)
    self.clientData:SetLordTowerLevel(zStoryLevel.Id)
    local zSection = table.first(Z_LordTower,function(v) return zStoryLevel.Id == v.LevelId  end)
    self.selectLevel = zSection.Id
    self.APTxt.text = "AP ".. zStoryLevel.EnergyExpend
    self.ApQuickTxt.text = "AP ".. zStoryLevel.EnergyExpend
    self.titleTxt.text = zSection.LevelTitle
    self.LevelText.text = LangUtil.GetSysLang(500) .. zStoryLevel.HintLevel
    --self.isPass:SetActive(zSection.Id <= self.storyComponent["Tower"..levelNames[self.selectDiff]])
    local icon =  self.itemRoot:Find("Icon/Value"):GetComponent("Image")
    local bg = self.itemRoot:Find("Icon/Bg"):GetComponent("Image")

    local ranReward = loadtable(zStoryLevel.RanRewards)[1]
    if ranReward.id == nil and ranReward.type == GoodsKind.Item then
        ranReward.id = ranReward.ranIds[1]
    end
    local rewardInfo = UIPublic.GetRewardData(ranReward.type, ranReward.id)
    rewardInfo.spriteName = zStoryLevel.RewardIcon
    if not string.IsNullOrEmpty(zStoryLevel.Desc) then
        rewardInfo.desc = zStoryLevel.Desc
    end
    if self.storyComponent["TowerHistory"..levelNames[self.selectDiff]] < zStoryLevel.Id then
        UIPublic.InitButton(self.quickBtn,false)
    else
        UIPublic.InitButton(self.quickBtn,true)
        UIUtil.AddBtnEvent(self.quickBtn,function() OnClickMop(self)  end)
    end

    self.desc.text = rewardInfo.desc
    self.num.text = ranReward.num..(ranReward.ranNum == nil and "" or "~"..(ranReward.num + ranReward.ranNum - 1))
    UIPublic.InitItemIcon(icon, bg, ranReward.type, ranReward.id, {spriteName = rewardInfo.spriteName})

    local launchAtkData = {}
    launchAtkData.CurLevelId = self.selectLevel
    launchAtkData.CurLevelDifficulty = self.selectDiff
    launchAtkData.LevelType = LevelType.LevelTypeMonthlyTower
    UIBattelModeInfo.InitMonsterArea(self.monsterRoot, zStoryLevel, launchAtkData)
end

local function OnClickReadyButton(self) --点击出击准备
    local sectionId = self.selectLevel
    local diff = self.selectDiff
    local zStoryLevel = self.againstComponent:GetZLordTowerLevel(sectionId,diff)
    local launchAtkData = {}
    launchAtkData.Skip = true
    launchAtkData.CurLevelId = sectionId
    launchAtkData.CurLevelDifficulty = diff
    launchAtkData.LevelType = LevelType.LevelTypeMonthlyTower
    launchAtkData.EnergyExpend = zStoryLevel.EnergyExpend
    UIManager:GetInstance():CloseWindow(UIWindowNames.UILordTowerSectionInfo)
    UIUtil.OpenFormat(launchAtkData)
    
end


function this.OnCreate(self)
    base.OnCreate(self);
    self.isPass = self.rc:GetObject("IsPass").gameObject
    self.itemRoot = self.rc:GetObject("ItemRoot").transform
    self.monsterRoot = self.rc:GetObject("MonsterRoot").transform
    local readyBtn = self.rc:GetObject("AtkButton")
    self.quickBtn = self.rc:GetObject("QuickButton")
    local eventBg = self.rc:GetObject("EventBg")
    
    UIUtil.AddBtnEvent(self.rc:GetObject("CloseButton"),function(go) UIManager:GetInstance():CloseWindow(UIWindowNames.UILordTowerSectionInfo) end)
    EventTriggerListener.Get(eventBg).onLuaClick = function() UIManager:GetInstance():CloseWindow(UIWindowNames.UILordTowerSectionInfo) end
    UIUtil.AddBtnEvent(readyBtn,function(go) OnClickReadyButton(self) end)
end

function this.OnLangCreate(self)
    local readyBtn = self.rc:GetObject("AtkButton")
    LangUtil.BindText(self.rc:GetObject("TitleText")).text = LangUtil.GetSysLang(501)--关卡情报
    LangUtil.BindText(self.rc:GetObject("MonsterText")).text = LangUtil.GetSysLang(497)
    LangUtil.BindText(self.itemRoot.transform:Find("Text")).text = LangUtil.GetSysLang(498)
    LangUtil.BindText(readyBtn.transform:Find("Text")).text = LangUtil.GetSysLang(98)--出击
    LangUtil.BindText(self.quickBtn.transform:Find("Text")).text = LangUtil.GetSysLang(872)--速戦
    self.LevelText = LangUtil.BindText(self.rc:GetObject("LevelText"))
    self.num = LangUtil.BindText(self.itemRoot:Find("Icon/Amount"))
    self.desc = LangUtil.BindText(self.itemRoot:Find("Desc"))
    self.titleTxt = LangUtil.BindText(self.rc:GetObject("Title"))
    self.APTxt = LangUtil.BindText(self.rc:GetObject("Ap"))
    self.ApQuickTxt = LangUtil.BindText(self.rc:GetObject("ApQuick"))
end

function this.OnEnable(self)
    base.OnEnable(self)
    self.player = Game.Scene.Player
    self.clientData = ClientData:GetInstance()
    self.againstComponent = Game.Scene:GetComponent("AgainstComponent")
    self.storyComponent =  self.player:GetComponent("StoryComponent")
    local info = self.model.info
    self.selectDiff = info.selectDiff
    self.zStoryLevel = info.zStoryLevel
    self:OnRefresh();
end



function this.OnRefresh(self)
    InitSectionPanel(self,self.zStoryLevel)
end


function this.OnAddListener(self)
    base.OnAddListener(self)
   
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
   
end

function this.OnDisable(self)
    base.OnDisable(self);
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;

