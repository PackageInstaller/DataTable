---
---

local UIChallenge2View = BaseClass("UIChallenge2View",UIBaseView);
local base = UIBaseView;
local this = UIChallenge2View

--local maxCount = 5
--local diff = 1

local function InitItemList(self)
    for k,v in pairs(self.itemList) do
        local hint = v:Find("Hint").gameObject
        local btn = v:Find("Button").gameObject
        local surCountTxt = LangUtil.BindText(v:Find("Image/SurCount"))
        local data = self.challengeDatas[k]
        local num = data["Num"..self.selectDiff] -- 打了的次数
        local maxCount = Z_Challenge[data.TemplateId].ChallengeNum
        surCountTxt.text = LangUtil.GetSysLang(526).."："..(maxCount - num).."/"..maxCount
        hint:SetActive(num >= maxCount)
        UIPublic.InitButton(btn,num < maxCount)
        local levelId = Z_Challenge[data.TemplateId].LevelId + self.selectDiff
        LangUtil.BindText(v:Find("Button/AP")).text = "AP ".. Z_ChallengeLevel[levelId].EnergyExpend
    end
end

local function OnItem(self,id)
    if id == 1 then
        UIManager:GetInstance():OpenWindow(UIWindowNames.UICommonLevel,
        {
            levelType = LevelType.LevelTypeChallenge,
            challengeType = ChallengeType.Exp
        })
    else
        UIManager:GetInstance():OpenWindow(UIWindowNames.UICommonLevel,{
            levelType = LevelType.LevelTypeChallenge,
            challengeType = ChallengeType.Gold
        })
    end
    -- local info ={infoId = id, TypeId = 2}
    -- UIManager:GetInstance():OpenWindow(UIWindowNames.UIChallengeSectionInfo, info)

    -- if id == 1 then
    --     coroutine.start(function ()
    --         self.face:CoPlaySound(1010)
    --     end)
    --     --self.soundComponent:PlayCardIdSound(SoundType.Extra2,1026)
    -- else
    --     coroutine.start(function ()
    --         self.face:CoPlaySound(1009)
    --     end)
    --     --self.soundComponent:PlayCardIdSound(SoundType.Extra3,1027)
    -- end
end

local function OnDiff(self,id)
    self.clientData:SetChallenge2Diff(id)
    self.selectDiff = id
    self:OnRefresh()
end


function this.OnCreate(self)
    base.OnCreate(self)
    self.backBtn = self.rc:GetObject("BackButton")
    
    local reward1Img =  self.rc:GetObject("Reward1"):GetComponent("Image")
    local reward2Img =  self.rc:GetObject("Reward2"):GetComponent("Image")
    
    UIUtil.SetSprite(reward1Img,AtlasConfig.Item,GetItemIcon(Z_Item[tonumber(Z_Misc["GOLD_ID"].Value[1])]))
    UIUtil.SetSprite(reward2Img,AtlasConfig.Item,GetItemIcon(Z_Item[tonumber(Z_Misc["EXP_ID"].Value[1])]))
    
    --self.curDiff =  self.rc:GetObject("CurDiff").transform
    self.itemList = {}
    
    UIPublic.SetBackButton(
        self.backBtn,
        UIWindowNames.UIChallenge2,
        429
    )

    UIPublic.SetHelpButton(self.rc:GetObject("HelpButton"), UIWindowNames.UIChallenge2)

    self.face = UILandlady.New(nil, 1008, self.rc:GetObject("Lines"))
end

function this.OnLangCreate(self)
    local ActivityCom = Game.Scene.Player:GetComponent("GameEventComponent")
    local intensBtn = self.rc:GetObject("Intens")
    local formatBtn = self.rc:GetObject("Format")
    LangUtil.GetSpriteLang(120, function(sprite) intensBtn:GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(19, function(sprite) formatBtn:GetComponent("Image").sprite = sprite end)
    LangUtil.BindText(self.rc:GetObject("DiffText"))
    UIUtil.AddBtnEvent(formatBtn,function()
        self.face:Stop()
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIFormatNew) 
    end)
    UIUtil.AddBtnEvent(intensBtn,function()
        self.face:Stop()
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIMainIntens) 
    end)
    local diffCtrl = self.rc:GetObject("DiffCtrl").transform
    local content = self.rc:GetObject("Content").transform
    self.diffSelectList = {}
    for i = 0,diffCtrl.childCount -1 do
        local child = diffCtrl:GetChild(i).gameObject
        self.diffSelectList[i + 1]  = child.transform:GetChild(0).gameObject
        LangUtil.GetSpriteLang(112+(i*2),function(sprite)
            child:GetComponent("Image").sprite = sprite
        end)
        LangUtil.GetSpriteLang(113+(i*2),function(sprite)
            self.diffSelectList[i + 1].transform:GetComponent("Image").sprite = sprite
        end)
        UIUtil.AddBtnEvent(child,function()OnDiff(self,i+1)  end)
    end

    for i = 0,content.childCount -1 do
        local child = content:GetChild(i)
        self.itemList[i+1] = child
        local btn = child:Find("Button").gameObject
        LangUtil.BindText(content:GetChild(i).transform:Find("Title"))
        --LangUtil.BindText(btn.transform:Find("Text")).text = LangUtil.GetSysLang(309)--挑战
        --LangUtil.BindText(content:GetChild(i).transform:Find("Hint/Text")).text = LangUtil.GetSysLang(534)--每日4点时更新
        UIUtil.AddBtnEvent(btn,function()OnItem(self,i+1)  end)
        
        UIUtil.activityBUt(child.transform:Find("activityBut"),2,self.canvas.unity_canvas.sortingOrder,3) 
        
        
    end
end


local function InitData(self)
    local challengeComponent = Game.Scene.Player:GetComponent("ChallengeComponent")
    self.challengeDatas = {}
    self.zChallengeList = {}
    for k,v in table.pairsByKeys(Z_Challenge) do
        if v.TypeId == 2 then
            self.zChallengeList[k] = v
        end
    end

    -- for k,v in table.pairsByKeys(self.zChallengeList) do
    --     table.insert(self.challengeDatas,challengeComponent.data["ChallengeInfo"..k])
    -- end
end

function this.OnEnable(self)
    base.OnEnable(self);
    self.clientData = ClientData:GetInstance()
    self.selectDiff =self.clientData:GetChallenge2Diff()
    self.soundComponent = Game.Scene:GetComponent("SoundComponent")
    --self.soundComponent:PlayCardIdSound(SoundType.Extra2,1027)
    InitData(self)
    self:OnRefresh()
    coroutine.start(function ()
        self.face:CoPlaySound(1008)
    end)
end

function this.InitDiff(self)
    for k, v in pairs(self.diffSelectList) do
        v:SetActive(k  == self.selectDiff)
    end
end

function this.OnRefresh(self)
    self:InitDiff()
    --InitItemList(self)
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
    self.soundComponent:MainStop()
    self.face:Disable()
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end


return this


