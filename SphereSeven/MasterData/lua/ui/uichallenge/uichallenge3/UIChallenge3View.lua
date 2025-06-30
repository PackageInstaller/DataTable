---
---

local UIChallenge3View = BaseClass("UIChallenge3View",UIBaseView);
local base = UIBaseView;
local this = UIChallenge3View

--local maxCount = 1
--local diff = 1


local function InitItemList(self)
    for k,v in pairs(self.itemList) do
        local hint = v:Find("Hint").gameObject
        local btn = v:Find("Button").gameObject
        local surCountTxt = LangUtil.BindText(v:Find("SurCount"))
        local data = self.challengeDatas[k]
        local num = data["Num"..self.selectDiff] -- 打了的次数
        local maxCount = Z_Challenge[data.TemplateId].ChallengeNum
        surCountTxt.text = LangUtil.GetSysLang(526).."："..(maxCount - num).."/"..maxCount
        hint:SetActive(num >= maxCount)
        UIPublic.InitButton(btn,num < maxCount)
        local levelId = Z_Challenge[data.TemplateId].LevelId + self.selectDiff
        LangUtil.BindText(v:Find("Button/AP")).text = "AP " ..Z_ChallengeLevel[levelId].EnergyExpend
    end
end

local function OnItem(self,id)
    local info ={infoId = id, TypeId = 3}
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIChallengeSectionInfo, info)
end



function this.OnCreate(self)
    base.OnCreate(self)
    self.backBtn = self.rc:GetObject("BackButton")
    
   
    local paint = self.rc:GetObject("Paint"):GetComponent("Image")

    local content = self.rc:GetObject("Content").transform
    for i = 1, content.childCount do
        local rewardImg =  self.rc:GetObject(string.format("Reward%s",i)):GetComponent("Image")
    end

    self.itemList = {}

    UIUtil.AddBtnEvent(self.backBtn,function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIChallenge3) 
        --if UIManager:GetInstance():GetWindow(UIWindowNames.UIBattleMode) == nil then
        --local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIHome)
        --local view =window.View
        --view:ToolTip()
        --end  
    end,"Back")
   
    --UIPublic.SetPainting(Z_Card[1029],paint,false,1,3)
    self.face = UILandlady.New(paint, 1007, self.rc:GetObject("Lines"))
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.backBtn.transform:Find("Text"))
    --LangUtil.BindText(self.rc:GetObject("Text"))
    LangUtil.BindText(self.rc:GetObject("DiffText"))
    local leftPanel = self.rc:GetObject("Left");
    local intensBtn = self.rc:GetObject("Intens")
    local formatBtn = self.rc:GetObject("Format")
    LangUtil.GetSpriteLang(120, function(sprite) intensBtn:GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(19, function(sprite) formatBtn:GetComponent("Image").sprite = sprite end)
    UIUtil.AddBtnEvent(formatBtn,function()UIManager:GetInstance():OpenWindow(UIWindowNames.UIFormatNew)  end)
    UIUtil.AddBtnEvent(intensBtn,function()UIManager:GetInstance():OpenWindow(UIWindowNames.UIMainIntens)  end)
    local content = self.rc:GetObject("Content").transform
    for i = 0,content.childCount - 1 do
        local child = content:GetChild(i)
        self.itemList[i+1] = child
        local btn = child:Find("Button").gameObject
        LangUtil.BindText(content:GetChild(i).transform:Find("Title"))
        LangUtil.BindText(btn.transform:Find("Text")).text = LangUtil.GetSysLang(309)--挑战
        LangUtil.BindText(content:GetChild(i).transform:Find("Hint/Text")).text = LangUtil.GetSysLang(534)--每日4点时更新
        UIUtil.AddBtnEvent(btn,function()OnItem(self,i+1)  end)
    end
    local diffSelect = leftPanel.transform:Find("DiffCtrl/4")
    LangUtil.GetSpriteLang(118, function(sprite)
        diffSelect:GetComponent("Image").sprite = sprite
    end)
    LangUtil.GetSpriteLang(119, function(sprite)
        diffSelect:GetChild(0):GetComponent("Image").sprite = sprite
    end)
end

local function InitData(self)
    local challengeComponent = Game.Scene.Player:GetComponent("ChallengeComponent")
    self.challengeDatas = {}
    self.zChallengeList = {}
    for k,v in table.pairsByKeys(Z_Challenge) do
        if v.TypeId == 3 then
            self.zChallengeList[k] = v
        end
    end

    for k,v in table.pairsByKeys(self.zChallengeList) do
        table.insert(self.challengeDatas,challengeComponent.data["ChallengeInfo"..k])
    end
end

function this.OnEnable(self)
    base.OnEnable(self);
    self.selectDiff = 4
    --Game.Scene:GetComponent("SoundComponent"):PlayCardIdSound(SoundType.Extra1,1029)
    self.face:CoPlay()
    InitData(self)
    self:OnRefresh()
end

function this.OnRefresh(self)
    InitItemList(self)
end

function this.OnViewTop(self)
    base.OnViewTop(self)
end

function this.OnDisViewTop(self)
    base.OnDisViewTop(self)
end

local function OnTimeRest(self)
    InitData(self)
    self:OnRefresh()
end

function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddUIListener(UIMessageNames.ON_TIME_RESET,OnTimeRest)
    self:AddUIListener(UIMessageNames.ON_CHALLENGE_DIFF_CHG, OnTimeRest)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
    self:RemoveUIListener(UIMessageNames.ON_TIME_RESET)
    self:RemoveUIListener(UIMessageNames.ON_CHALLENGE_DIFF_CHG)
end

function this.OnDisable(self)
    base.OnDisable(self);
    Game.Scene:GetComponent("SoundComponent"):MainStop()
    self.face:Disable()
end

function this.OnDisViewTop(self)
    base.OnDisViewTop(self)
    self.face:Stop()
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end


return this


