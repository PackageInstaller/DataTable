---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/3 13:59
---

local UILordTowerModel = BaseClass("UILordTowerModel",UIBaseModel)
local base = UIBaseModel;

local function OnCreate(self)
    self.cur_completed_sectionId = nil;
    self.completed_sectionId_1 = nil;
    self.completed_sectionId_2 = nil;
    self.completed_sectionId_3 = nil;
    self.completed_sectionId_4 = nil;
    --self.level_scores = nil;
    self.chapter_section_data = nil;
    self.diffculty = 1;
    self.map = {};
    self.select_data = nil;
end

local function OnEnable(self)
    base.OnEnable(self);
    self:OnRefresh();
end

local function GetChapterSectionData(self)
    local data_tab = {};
    local chapter_section_tab = {};
    local completed_section_id = self["completed_sectionId_"..ClientData:GetInstance().CurLordTowerDifficulty]

    for k,v in table.pairsByKeys(Z_LordTower) do
        if k <= completed_section_id then
            table.insert(data_tab,v);
        end
        if completed_section_id == 0 then
            table.insert(data_tab,v);
            break;
        end
    end

    if completed_section_id ~= 0  then
        if data_tab[#data_tab].NextSectionId ~= 0 then
            table.insert(data_tab,Z_LordTower[data_tab[#data_tab].NextSectionId]);
        end
    end

    local againstComponent = Game.Scene:GetComponent("AgainstComponent");
    for i = 1,#data_tab do
        local chapter_id = data_tab[i].ChapterId;
        if chapter_section_tab[chapter_id] == nil then
            chapter_section_tab[chapter_id] = {};
        end
        if chapter_section_tab[chapter_id].Section == nil then
            chapter_section_tab[chapter_id].Section = {};
        end
        local temp_tab = data_tab[i];
        temp_tab.Diffculty = table.clone(againstComponent:GetZLordTowerLevel(data_tab[i].Id,self.diffculty));
        table.insert(chapter_section_tab[chapter_id].Section,temp_tab);
    end
    return chapter_section_tab;
end


local function IsMeetDiffcutyCondition(self,dif)
    return Game.Scene.Player.Level >= dif *10
end

local function GetSelectData(self,sectionId)
    local data_tab = {};
    data_tab[1] = IsMeetDiffcutyCondition(self,1,sectionId);
    data_tab[2] = IsMeetDiffcutyCondition(self,2,sectionId);
    data_tab[3] = IsMeetDiffcutyCondition(self,3,sectionId);
    data_tab[4] = IsMeetDiffcutyCondition(self,4,sectionId);
    return data_tab;
end

local function OnRefresh(self)
    local storyComponent = Game.Scene.Player:GetComponent("StoryComponent");
    if ClientData:GetInstance().OpenAll == 1 then
        self.completed_sectionId_1 = 110
        self.completed_sectionId_2 = 110
        self.completed_sectionId_3 = 110
        self.completed_sectionId_4 = 110
    else
        self.completed_sectionId_1 = storyComponent.TowerA
        self.completed_sectionId_2 = storyComponent.TowerB
        self.completed_sectionId_3 = storyComponent.TowerC
        self.completed_sectionId_4 = storyComponent.TowerD
    end

    self.TowerHistoryA = storyComponent.TowerHistoryA
    self.TowerHistoryB = storyComponent.TowerHistoryB
    self.TowerHistoryC = storyComponent.TowerHistoryC
    self.TowerHistoryD = storyComponent.TowerHistoryD
    
    --self.level_scores = storyComponent.StoryLevelScores;
    self.chapter_section_data = GetChapterSectionData(self)
end

local function GetHistory(self)
    if self.TowerHistoryD > 0 then
        return self.TowerHistoryD, 4
    end
    if self.TowerHistoryC > 0 then
        return self.TowerHistoryC, 3
    end
    if self.TowerHistoryB > 0 then
        return self.TowerHistoryB, 2
    end
    if self.TowerHistoryA > 0 then
        return self.TowerHistoryA, 1
    end
end

local function OnLordTowerDiffChg(self)
    self:OnRefresh()
    self:UIBroadcast(UIMessageNames.ON_LORD_TOWER_DIFF_CHG)
end

local function OnAddListener(self)
    base.OnAddListener(self);
    self:AddDataListener(DataMessageNames.ON_LORD_TOWER_DIFF_CHG,OnLordTowerDiffChg)
end

local function OnRemoveListener(self)
    base.OnRemoveListener(self);
    self:RemoveDataListener(DataMessageNames.ON_LORD_TOWER_DIFF_CHG)
end

local function OnDisable(self)
    base.OnDisable(self);
    self.completed_sectionId_1 = nil;
    self.completed_sectionId_2 = nil;
    self.completed_sectionId_3 = nil;
    self.completed_sectionId_4 = nil
    --self.level_scores = nil;
    self.chapter_section_data = nil;
end

local function OnDestroy(self)
    base.OnDestroy(self);
end

UILordTowerModel.GetSelectData = GetSelectData
UILordTowerModel.OnCreate = OnCreate
UILordTowerModel.OnEnable = OnEnable
UILordTowerModel.OnRefresh = OnRefresh
UILordTowerModel.OnAddListener = OnAddListener
UILordTowerModel.OnRemoveListener = OnRemoveListener
UILordTowerModel.OnDisable = OnDisable
UILordTowerModel.OnDestroy = OnDestroy
UILordTowerModel.GetHistory = GetHistory

return UILordTowerModel