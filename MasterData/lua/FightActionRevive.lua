--复活角色
FightActionRevive = oo.class(FightActionBase);
local this = FightActionRevive;


function this:SetData(fightActionData)
    FightActionBase.SetData(self,fightActionData);
    self:Preload(fightActionData.datas);
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

function this:ApplyCreate()
    if(self.preloadComplete == nil or self.isStart == nil)then
        return;
    end
   local characters = CharacterMgr:CreateCharacters(self.data.datas);
   local castId = self.data.casterID;
   --复活特效
   if(characters)then
       for _,c in ipairs(characters)do
          if(c)then
              local x,y,z = c.GetPos();  
                
              local resName = "resurrection/common";    
              if(castId == c.GetID())then
                 local cfgModel = c.GetCfgModel();
                 if(cfgModel)then
                    resName = cfgModel.resurrection_eff or resName;
                 end
              end    
              ResUtil:CreateEffect(resName,x,y,z);
              
              c.SetShowState(false);
              FuncUtil:Call(ShowCharacter,nil,750,c);
              
          end
       end
   end
   CameraMgr:CreateCameraEffs({{res="HeiPing"}});  
   FuncUtil:Call(self.Complete,self,3000);
end

function ShowCharacter(character)
    character.SetShowState(true);
    CSAPI.ApplyAction(character.gameObject,"action_character_resurrection");  
end


function this:OnClean()
    self.isStart = nil;
    self.preloadComplete = nil;
end


return this;