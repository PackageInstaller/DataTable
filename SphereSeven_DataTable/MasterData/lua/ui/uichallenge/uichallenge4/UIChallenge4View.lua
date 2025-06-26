---
---

local UIChallenge4View = BaseClass("UIChallenge4View",UIBaseView);
local base = UIBaseView;
local this = UIChallenge4View

function this.OnCreate(self)
    base.OnCreate(self)
    self.backBtn = self.rc:GetObject("BackButton")
    self.txtTittle = self.backBtn.transform:Find("Text")
    UIUtil.AddBtnEvent(self.backBtn,function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIChallenge4)
    end,"Back")
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.txtTittle)
end

function this.OnEnable(self)
    base.OnEnable(self)
    self.canUseEnemyCards = {}   -- 可用随机敌人 Id
    self.canUseRoleCards = Game.Scene.Player:GetComponent("CardComponent").Cards
    for k,v in table.pairsByKeys(self.canUseRoleCards) do
        table.insert(self.canUseEnemyCards,v.TemplateId)
    end
    -- 添加已有角色怪物配置Id
    for k,v in table.pairsByKeys(Z_Card) do
        if v.Id > 1100 and v.Id < 1200 then
            table.insert(self.canUseEnemyCards, v.Id)
        end
    end
    self:OnRefresh()
end

function this.RandomEnemyConfig(self)
    -- local conf = {
    --     ["DiffLv"] = 4,
    --     ["FirstPassRewards"] = "{{reward={{type=1,id=3028,num=200}}}}",
    --     ["ConditionRewards"] = "{{cond=8,type=3,sub=1,compare=2,num=1}}",
    --     ["BattleArrayLevel"] = 2,
    --     ["HintLevel"] = 60,
    --     ["Id"] = 101,
    --     ["Bgm"] = "1,1",
    --     ["FormatIntens"] = 2,
    --     ["Batch1"] = "{{row=1,id=1109,num=3},{row=2,id=1120,num=1,pos=2},{row=2,id=1120,num=1,pos=8},{row=3,id=1110,num=1,pos=1},{row=3,id=1110,num=1,pos=7}}",
    --     ["BattleArrayKind"] = 3,
    --     ["JadePearl"] = 2,
    --     ["Star"] = 5,
    --     ["EnergyExpend"] = 5,
    --     ["Level"] = 30,
    -- }
    --------------------------------------------------------------------------------
    self.enemyConf = {}
    self.enemyConf.DiffLv = 4
    self.enemyConf.FirstPassRewards = {}
    self.enemyConf.ConditionRewards = {}
    self.enemyConf.BattleArrayLevel = 2
    self.enemyConf.HintLevel = 1
    self.enemyConf.Id = 1
    self.enemyConf.Bgm = "1"
    self.enemyConf.FormatIntens = 2
    local string =  "{"..
    "{row=1,id=self.canUseEnemyCards[%s],num=1,pos=6},"..
    "{row=2,id=self.canUseEnemyCards[%s],num=1,pos=2},"..
    "{row=2,id=self.canUseEnemyCards[%s],num=1,pos=8},"..
    "{row=3,id=self.canUseEnemyCards[%s],num=1,pos=1},"..
    "{row=3,id=self.canUseEnemyCards[%s],num=1,pos=7}".."}"
    self.enemyConf.Batch1 = string.format(string,
    math.random(1,#self.canUseEnemyCards),
    math.random(1,#self.canUseEnemyCards),
    math.random(1,#self.canUseEnemyCards),
    math.random(1,#self.canUseEnemyCards),
    math.random(1,#self.canUseEnemyCards))
    self.enemyConf.BattleArrayKind = 3
    self.enemyConf.JadePearl = 2
    self.enemyConf.Star = 5
    self.enemyConf.EnergyExpend = 0
    self.enemyConf.Level = 30
    print("----------------------->>>>>",table.dump(self.canUseEnemyCards))
end

function this.OnRefresh(self)
    self:RandomEnemyConfig()
end

function this.OnViewTop(self)
    base.OnViewTop(self)
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIComTop)
end

function this.OnDisViewTop(self)
    base.OnDisViewTop(self)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIComTop)
end

function this.OnAddListener(self)
    base.OnAddListener(self)

end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)

end

function this.OnDisable(self)
    base.OnDisable(self)
end

function this.OnDestroy(self)
    base.OnDestroy(self)
end


return this


