---
---

local UIChallengeCtrl = BaseClass("UIChallengeCtrl",UIBaseCtrl);

local function OnSectionChg(self,id,difficulty)
    UIData.SetSectionId(id,difficulty);
end

local function LaunchAtk(data)
    local ac = Game.Scene:GetComponent("AgainstComponent")
    ac:SetCurLevel(data)
    Game.Scene.SceneComponent:SwitchScene(SceneConfig.BattleScene)
end

local function OpenFormatWindow(self)
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIFormatNew);
end

local function OpenReadyWindow(self,data)
    UIUtil.OpenFormat(data);
end

local function OnOpenMonsterMessageWindow(monsterData)
    local showData = {};
    showData.monster = monsterData;
    showData.showType = 4;
    UIUtil.OpenThingsDetailWindow(showData);
end

local function OnOpenItemMessageWindow(gameObject)
    local showData = gameObject:GetComponent("BindData"):Get("showData");
    UIUtil.OpenThingsDetailWindow(showData);
end

local function CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIChallenge);
end

local function OpenIntensWindow()
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIMainIntens);
end

local function SendRestRequest(self,expendStarStone,isItem,diff,day)
    PublicRequest.SendOpenBattleModeRequest(expendStarStone,isItem,diff,day)
end

UIChallengeCtrl.LaunchAtk = LaunchAtk
UIChallengeCtrl.OpenIntensWindow = OpenIntensWindow
UIChallengeCtrl.OnSectionChg = OnSectionChg
UIChallengeCtrl.OnOpenMonsterMessageWindow = OnOpenMonsterMessageWindow
UIChallengeCtrl.OnOpenItemMessageWindow = OnOpenItemMessageWindow
UIChallengeCtrl.OpenFormatWindow = OpenFormatWindow
UIChallengeCtrl.CloseSelf = CloseSelf
UIChallengeCtrl.OpenReadyWindow = OpenReadyWindow
UIChallengeCtrl.SendRestRequest = SendRestRequest

return UIChallengeCtrl