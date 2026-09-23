--Overload
FightActionOverload1 = oo.class(FightActionBase);
local this = FightActionOverload1;

function this:OnPlay() 
    
   if(self.data and self.data.flag)then
       local xluaCamera = CameraMgr:GetXLuaCamera();
       if(xluaCamera)then
           local cameraEffs = nil;
            
           if(self.data.flag == 1)then              
               cameraEffs = {{res="overload/replace_camera_OverLoad02"},{res="overload/replace_camera_OverLoad02_Eff"},{res="overload/overload2"}};
           else            
               cameraEffs = {{res="overload/replace_camera_OverLoad03"},{res="overload/replace_camera_OverLoad03_Eff"}};
           end
           if(cameraEffs)then
                xluaCamera.CreateCameraEffs(cameraEffs);
           end
           EventMgr.Dispatch(EventType.Character_FightInfo_Show,false); 
           CharacterMgr:SetAllShowState(true);
           local character = self:GetActorCharacter();
           if(character)then
                --character.SetShowState(true);
				character.ResetPlace();
           end
		   FightClient:SetSkillSceneState(true,not character.IsEnemy());
           CameraMgr:ApplyCommonAction(self,"to_default_camera");  
           FuncUtil:Call(self.Complete,self,1000);
           return;
       end 
   end
   
   self:Complete();
end


return this;