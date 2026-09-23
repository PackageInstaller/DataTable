--Overload启动
FightActionOverloadOn = oo.class(FightActionBase);
local this = FightActionOverloadOn;

function this:OnPlay()   
    --LogError("aa");  
    --FuncUtil:Call(self.DelayPlay,self,250);   
    self:Show();
end

function this:DelayPlay()
    local character = self:GetActorCharacter();
    FightClient:SetSkillSceneState(true,not character.IsEnemy());

    EventMgr.Dispatch(EventType.Fight_Mask,character.GetID()); 
    EventMgr.Dispatch(EventType.Character_FightInfo_Show,false); 
           
	EventMgr.Dispatch(EventType.Scene_Mask_Changed,true);
    EventMgr.Dispatch(EventType.Fight_View_Show_Changed,false); 	
       

    FuncUtil:Call(self.Show,self,FightClient:GetFightMaskDelayTime());   
end

function this:Show()
    --EventMgr.Dispatch(EventType.Fight_View_Main_Info_Show_State,false);     

  
    local character = self:GetActorCharacter();
 
--    character.SetMatKeywordState("_SRIM_LIGHT",true);
--    CSAPI.ApplyAction(character.gameObject,"action_overload_on");  


--    local cfgModel = character.GetCfgModel();
--    CSAPI.PlayRandSound(cfgModel.s_overload,true);


    self:Complete();
end

function this:PlayCameraEffs()
 
    --cameraEffs = {{res="overload/replace_camera_OverLoad02"},{res="overload/replace_camera_OverLoad02_Eff"},{res="overload/overload2"}};            
    local cameraEffs = {{res="camera_effs/replace_camera_OverLoad02"}};            
    CameraMgr:CreateCameraEffs(cameraEffs);           
end


return this;