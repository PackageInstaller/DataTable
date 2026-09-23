--战斗演出

FightActionStartPlay = oo.class(FightActionBase);
local this = FightActionStartPlay;


--虚假的播放
function this:OnPlay()
    local data = self:GetData();
--    LogError("播放演出");
--    LogError(data);
    
    self.delCharacters = {};
    for _,id in ipairs(data.dels)do
        local character = CharacterMgr:Get(id);
        if(character)then
            table.insert(self.delCharacters,character);
            character.PutOut();
        end
    end

    self.isPlayed = 1;

    self:ApplyCreate();
end


function this:SetData(fightActionData)
    FightActionBase.SetData(self,fightActionData);
    self:Preload(fightActionData.adds);
end

--预加载角色
function this:Preload(datas)   
    CharacterMgr:PreloadCharacters(datas,self.OnPreloadCallBack,self)
end
--预加载完成回调
function this:OnPreloadCallBack()
    self.isPreloaded = 1;
    self:ApplyCreate();
end

--被加进主队列时调用
function this:OnPush()
    --LogError("aaa");
    FuncUtil:Call(self.FadeOutBGM,self,300);     
end

function this:FadeOutBGM()
    CSAPI.StopBGM(0.2);
end

function this:ApplyCreate()
    if(not self.isPreloaded or not self.isPlayed)then
        return;
    end

   local data = self:GetData();
   self.addCharacters = CharacterMgr:CreateCharacters(data.adds);
   self.isCreated = 1;

   if(self.addCharacters)then
       for _,character in ipairs(self.addCharacters)do
            if(character)then
                character.EnterState("enter_ready");
                character.SetShowState(false);
            end
       end
   end

   self:TryShow();
end



function this:TryShow()
    if(self.isShowed)then
        return;
    end
    self.isShowed = 1;
    
    --CSAPI.StopBGM(1);
    --FuncUtil:Call(self.ContinueShow,self,1100); 

    self:ContinueShow();
end

function this:ContinueShow()
    if(self.addCharacters)then
       for _,character in ipairs(self.addCharacters)do
            if(character)then
                local stateName = "enter";
                character.SetShowState(true);
                character.EnterState(stateName);
                character.ApplyEnterShake();
--                local castStateData = character.GetCastStateData(stateName);                  
--                ApplyCameraShake(castStateData and castStateData.camera_shakes);
                
                FuncUtil:Call(function ()
                    EventMgr.Dispatch(EventType.Play_BGM_New, {bgm = "Battle_BOSS_02",fadeTime = 50});
                end,nil,3100); 
                
            end
       end
   end
   FuncUtil:Call(self.ApplyDelete,self,600); 
   FuncUtil:Call(self.Complete,self,3000); 

end


function ApplyCameraShake(cameraShakes)    
    if(not cameraShakes)then
        return;
    end
    --LogError(cameraShakes);
    for _,shakeData in ipairs(cameraShakes)do
        local delay = shakeData.delay or 0;
        FuncUtil:Call(ApplyShake,nil,delay,shakeData);
    end
end
function ApplyShake(shakeData)
    local decayValue = shakeData.decay_value;
    decayValue = decayValue and decayValue * 0.01 or 0.8;
    CameraMgr:ApplyShake(shakeData.time,shakeData.hz,shakeData.range,shakeData.range,shakeData.range,shakeData.shake_dir and gameObject,decayValue);
end



function this:ApplyDelete()
    if(self.delCharacters)then
        for _,character in ipairs(self.delCharacters)do
            if(character)then
                character.Remove();
            end
        end
    end
end


function this:OnClean()
   
    self.isPreloaded = nil;
    self.isPlayed = nil;
    self.isShowed = nil;

    self.delCharacters = nil;
    self.addCharacters = nil;
end


return this;
