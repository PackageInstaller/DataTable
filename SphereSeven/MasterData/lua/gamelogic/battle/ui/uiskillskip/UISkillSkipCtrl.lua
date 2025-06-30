
local UISkillSkipCtrl = BaseClass("UISkillSkipCtrl",UIBaseCtrl)
local this = UISkillSkipCtrl
function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UISkillSkip)
end
function this.OnSkip()
    Game.Scene:GetComponent("BattleComponent"):SetBattleSkip()
end
return this