--创建角色
FightActionAddCard = oo.class(FightActionBase);
local this = FightActionAddCard;


function this:SetData(fightActionData)
    FightActionBase.SetData(self,fightActionData);
    self:Preload(fightActionData);
end
--预加载角色
function this:Preload(datas)   
    CharacterMgr:PreloadCharacters(datas,self.OnPreloadCallBack,self)
end
--预加载完成回调
function this:OnPreloadCallBack()
    self.preloadComplete = 1;
    self:ApplyCreate();
end

function this:OnPlay()
    self.isStart = 1;
    self:ApplyCreate();
end

function this:OnClean()
    self.isFightEnter = nil;
    self.isStart = nil;
    self.preloadComplete = nil;
end



--设置为战斗开场
function this:SetAsFightEnter()
    self.isFightEnter = 1;
end

function this:ApplyCreate()

    if(self.preloadComplete == nil or self.isStart == nil)then
        return;
    end
   CharacterMgr:CreateCharacters(self.data);
   

   FightClient:ApplyFightStart();
   self:Complete(); 
end

return this;