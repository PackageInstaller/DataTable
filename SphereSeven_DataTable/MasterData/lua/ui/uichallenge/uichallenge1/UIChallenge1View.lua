---
---

local UIChallenge1View = BaseClass("UIChallenge1View",UIBaseView);
local base = UIBaseView;
local this = UIChallenge1View

local function InitItemList(self)
    for k,v in pairs(self.itemList) do
        local hint = v:Find("Hint").gameObject
        local btn = v:Find("Button").gameObject
        local surCountTxt = LangUtil.BindText(v:Find("SurCount"))
        local data = self.challengeDatas[k]
        local num = data["Num"..self.selectDiff] -- 打了的次数
        local maxCount = Z_Challenge[data.TemplateId].ChallengeNum
        surCountTxt.text = LangUtil.GetSysLang(526) .."："..(maxCount - num).."/"..maxCount
        hint:SetActive(num >= maxCount)
        UIPublic.InitButton(btn,num < maxCount)
        local levelId = Z_Challenge[data.TemplateId].LevelId + self.selectDiff
        LangUtil.BindText(v:Find("Button/AP")).text = "AP " .. Z_ChallengeLevel[levelId].EnergyExpend
    end
end

local function OnItem(self,id)
    local info ={infoId = id, TypeId = 1}
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIChallengeSectionInfo, info)
end

local function OnDiff(self,id)
    self.clientData:SetChallenge1Diff(id)
    self.selectDiff = id
    self:OnRefresh()
end

function this.OnCreate(self)
    base.OnCreate(self)
    self.backBtn = self.rc:GetObject("BackButton")
    
    local rewardRoo1 =  self.rc:GetObject("RewardList1").transform
    local rewardRoo2 =  self.rc:GetObject("RewardList2").transform

    for i = 0,rewardRoo1.childCount - 1 do
        local img =rewardRoo1:GetChild(i):GetComponent("Image")
        UIUtil.SetSprite(img,AtlasConfig.Item,GetItemIcon(Z_Item[1046 + i]),true)
    end

    for i = 0,rewardRoo2.childCount - 1 do
        local img =rewardRoo2:GetChild(i):GetComponent("Image")
        UIUtil.SetSprite(img,AtlasConfig.Item,GetItemIcon(Z_Item[1041 + i]),true)
    end

    self.itemList = {}
    UIUtil.AddBtnEvent(self.backBtn,function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIChallenge1) 
        --if UIManager:GetInstance():GetWindow(UIWindowNames.UIBattleMode) == nil then
        --local window =UIManager:GetInstance():GetWindow(UIWindowNames.UIHome)
        --local view =window.View
        --view:ToolTip()
        --end  
    end,"Back")
end

function this.OnLangCreate(self)
    local ActivityCom = Game.Scene.Player:GetComponent("GameEventComponent")
    LangUtil.BindText(self.backBtn.transform:Find("Text"))
    LangUtil.BindText(self.rc:GetObject("DiffText"))
    local intensBtn = self.rc:GetObject("Intens")
    local formatBtn = self.rc:GetObject("Format")
    LangUtil.GetSpriteLang(120, function(sprite) intensBtn:GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(19, function(sprite) formatBtn:GetComponent("Image").sprite = sprite end)
    UIUtil.AddBtnEvent(formatBtn, function()UIManager:GetInstance():OpenWindow(UIWindowNames.UIFormatNew)  end)
    UIUtil.AddBtnEvent(intensBtn, function()UIManager:GetInstance():OpenWindow(UIWindowNames.UIMainIntens)  end)
    local diffCtrl = self.rc:GetObject("DiffCtrl").transform

    self.diffSelectList = {}
    for i = 0,diffCtrl.childCount -1 do
        local child = diffCtrl:GetChild(i).gameObject
        self.diffSelectList[i + 1] = child.transform:GetChild(0).gameObject
        LangUtil.GetSpriteLang(112+(i*2),function(sprite)
            child:GetComponent("Image").sprite = sprite
        end)
        LangUtil.GetSpriteLang(113+(i*2),function(sprite)
            self.diffSelectList[i + 1]:GetComponent("Image").sprite = sprite
        end)
        UIUtil.AddBtnEvent(child,function()OnDiff(self,i+1)  end)
    end
    
    local content = self.rc:GetObject("Content").transform
    for i = 0,content.childCount -1 do
        local child = content:GetChild(i)
        self.itemList[i+1] = child
        local btn = child:Find("Button").gameObject
        LangUtil.BindText(content:GetChild(i).transform:Find("Title"))
        LangUtil.BindText(btn.transform:Find("Text")).text = LangUtil.GetSysLang(309)--挑战
        LangUtil.BindText(content:GetChild(i).transform:Find("Hint/Text")).text = LangUtil.GetSysLang(534)--每日4点时更新
        UIUtil.AddBtnEvent(btn,function()OnItem(self,i+1)  end)
        UIUtil.activityBUt(child.transform:Find("activityBut"),2,self.canvas.unity_canvas.sortingOrder,2)
    end
end


local function InitData(self)
    local challengeComponent = Game.Scene.Player:GetComponent("ChallengeComponent")
    self.challengeDatas = {}
    self.zChallengeList = {}
    for k,v in table.pairsByKeys(Z_Challenge) do
        if v.TypeId == 1 then
            self.zChallengeList[k] = v
        end
    end

    for k,v in table.pairsByKeys(self.zChallengeList) do
        table.insert(self.challengeDatas,challengeComponent.data["ChallengeInfo"..k])
    end
end

function this.OnEnable(self)
    base.OnEnable(self);
    self.clientData = ClientData:GetInstance()
    self.selectDiff =self.clientData:GetChallenge1Diff()
    InitData(self)
    self:OnRefresh()
end

function this.InitDiff(self)
    for k, v in pairs(self.diffSelectList) do
        v:SetActive(k == self.selectDiff)
    end
end

function this.OnRefresh(self)
    self:InitDiff()
    InitItemList(self)
end

local function OnTimeRest(self)
    InitData(self)
    self:OnRefresh()
end

function this.OnViewTop(self)
    base.OnViewTop(self)
end

function this.OnDisViewTop(self)
    base.OnDisViewTop(self)
end

function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddUIListener(UIMessageNames.ON_TIME_RESET, OnTimeRest)
    self:AddUIListener(UIMessageNames.ON_CHALLENGE_DIFF_CHG, OnTimeRest)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
    self:RemoveUIListener(UIMessageNames.ON_TIME_RESET)
    self:RemoveUIListener(UIMessageNames.ON_CHALLENGE_DIFF_CHG)
end

return this


