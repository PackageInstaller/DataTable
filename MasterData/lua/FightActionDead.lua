--战斗死亡

FightActionDead = oo.class(FightActionBase);
local this = FightActionDead;

function this:OnPlay()    
--    _G.testTime = CSAPI.GetTime();
--    LogError("死亡表现开始" .. CSAPI.GetTime());


    local camera_dis_fix = 0;

    for _,id in ipairs(self.data.deads)do
        local character = CharacterMgr:Get(id);
        if(character)then            
            character.PlayDead();        
            self.deadList = self.deadList or {};
            self.deadList[id] = character;     

            camera_dis_fix = math.max(camera_dis_fix, character.GetCameraAddHeight());
        end       
    end    

    if(self.deadList == nil)then
        self:Complete();
        return;
    end
    local time = 1000;
    FuncUtil:Call(self.CheckPlayComplete,self,time,1);
end

function this:CheckPlayComplete(checkedCount)
    if(checkedCount >= 5)then
        self:Complete();
        return;
    end

    if(self.deadList)then
        for id,character in pairs(self.deadList)do
            if(character and not character.IsDeadEnd())then
                FuncUtil:Call(self.CheckPlayComplete,self,1000,checkedCount + 1);
                return;
            end
        end

        self:Complete();
    end
end

function this:OnClean()
    self.deadList = nil;
end

function this:OnComplete()
    --LogError("播放死亡结束====================");
    if(self.deadList)then
        for id,character in pairs(self.deadList)do
            if(character)then
                character.RemoveAfterDeadAni();
            end
        end
    end

    self:ApplyPlayComplete();
end


function this:SetPlayCompleteCallBack(playCompleteCallBack,caller)
    self.playCompleteCallBack = playCompleteCallBack;
    self.playCompleteCaller = caller;
end

function this:ApplyPlayComplete()
    local playCompleteCallBack = self.playCompleteCallBack;
    local caller = self.playCompleteCaller;
    if(playCompleteCallBack)then
        self.playCompleteCallBack = nil;
        self.playCompleteCaller = nil;
        playCompleteCallBack(caller);
    end
end

return this;


