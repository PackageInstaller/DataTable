--战斗初始化数据

FightActionInitData = oo.class(FightActionBase);
local this = FightActionInitData;

function this:OnPlay()
    FightClient:Init(self.data,self.InitCallBack,self);    
end

function this:InitCallBack()
    self:Complete();
end

return this;
