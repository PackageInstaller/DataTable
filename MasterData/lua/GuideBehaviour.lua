--引导行为
local this = {};

--新手战斗引导----------------------------------------------------------------------------


function this:TryHideGuide()
    if(self.next_guide_hide)then
        self.next_guide_hide = nil;
        EventMgr.Dispatch(EventType.Guide_SetShowState,false);
        return true;
    end

    return false;
end

--新手战斗1引导----------------------------------------------------------------------------

--跳过
function this:GuideBehaviourSkipStep_Fight0_1_1010()
    if(not FightClient:IsNewPlayerFight())then
        return true;
    end
end
---【日服特有】跳过
function this:GuideBehaviourSkipStep_Fight0_1_1020()
    if(not FightClient:IsNewPlayerFight())then
        return true;
    end
end
--引导使用普通攻击
function this:GuideBehaviour_Fight0_1_1040()
   EventMgr.Dispatch(EventType.Input_Select_Skill_Item,3);
   FightGridSelMgr.CloseInput(true);
end
function this:GuideBehaviour_Fight0_1_1050()
   FightGridSelMgr.CloseInput(false);
   EventMgr.Dispatch(EventType.Input_Select_Skill_Item,3);
end
function this:GuideBehaviour_Fight0_1_1060()   
   EventMgr.Dispatch(EventType.Input_Select_Skill_Item,1);
   FightGridSelMgr.CloseInput(true);
end
function this:GuideBehaviour_Fight0_1_1070()
   FightGridSelMgr.CloseInput(false);
   EventMgr.Dispatch(EventType.Input_Select_Skill_Item,1);
end

--巅峰战引导----------------------------------------------------------------------------

--召唤引导
function this:GuideBehaviourSkip_Summon_3010()
    return true;
end

function this:GuideBehaviourStart_Summon_3015()
    PlotMgr:TryPlay(10056,self.GuideBehaviour_Summon_3015_CallBack,self,true);    
end
function this:GuideBehaviour_Summon_3015_CallBack()
    EventMgr.Dispatch(EventType.Guide_Custom_Complete); 
end


--引导机神召唤
function this:GuideBehaviour_Summon_3020()
   EventMgr.Dispatch(EventType.Input_Select_Skill_Item,4);
   FightGridSelMgr.CloseInput(true);
end
function this:GuideBehaviour_Summon_3030()
   FightGridSelMgr.CloseInput(false);
   EventMgr.Dispatch(EventType.Input_Select_Skill_Item,4);
end


--引导机神大招
function this:GuideBehaviour_Summon_3040()
   EventMgr.Dispatch(EventType.Input_Select_Skill_Item,1);
   FightGridSelMgr.CloseInput(true);
end
function this:GuideBehaviour_Summon_3050()
   FightGridSelMgr.CloseInput(false);
   EventMgr.Dispatch(EventType.Input_Select_Skill_Item,1);
end
function this:GuideBehaviourSkip_Summon_3060()
   return true;
end


--抽卡----------------------------------------------------------------------------
---国内注释：拥有赤狼跳过抽卡引导 或者 通关了第一关
---海外注释：拥有霖跳过抽卡引导 或者 通关了第一关
function this:GuideBehaviourSkipStep_Create_4010()
    local idNum=30200;
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---如果是日本地区
        idNum=40290;
    end
    if(RoleMgr:GetData(idNum) ~= nil or DungeonMgr:CheckDungeonPass(1001))then
        return true;
    end 
end
---国内注释：拥有霖跳过抽卡引导 或者 通关了第一关
---海外注释：拥有赤狼跳过抽卡引导 或者 通关了第一关
function this:GuideBehaviourSkip_Create_4010()
end
---国内注释：拥有赤狼跳过抽卡引导
---海外注释：拥有赤狼跳过抽卡引导
function this:GuideBehaviourCondition_Create_4010()
    return true;
end
function this:GuideBehaviourStart_Create_4030()
    EventMgr.Dispatch(EventType.Role_Create_Ani_Disable_Skip,true);
end

function this:GuideBehaviourStart_Create_4040()
    EventMgr.Dispatch(EventType.Guide_View_SetTop);    
end
function this:GuideBehaviourStart_Create_4050()
    EventMgr.Dispatch(EventType.Guide_View_SetTop);  
    EventMgr.Dispatch(EventType.Role_Create_Ani_Disable_Skip,false);  
end




---国内注释：通关了副本、或者无赤狼、或者赤狼已在编队，跳过引导编队
---海外注释：通关了副本、或者无霖、或者霖已在编队，跳过引导编队
function this:GuideBehaviourSkipStep_Team_5010()
    local idNum=3020001;
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---如果是日本地区
        idNum=4029001;
    end
    local targetCardId=idNum;--赤狼卡牌ID
    local team1Data = TeamMgr:GetTeamData(1);
    if(team1Data and team1Data.data)then
        for k, v in pairs(team1Data.data) do
            local modelId = v and v:GetModelID();
		    if(targetCardId == modelId)then
                --赤狼已在编队
                return true;
            end
	    end
    end
    local idRoleNum=30200;
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---如果是日本地区
        idRoleNum=40290;
    end
    if(RoleMgr:GetData(idRoleNum) == nil or DungeonMgr:CheckDungeonPass(1001))then
        --LogError("跳过5010");
        return true;
    end 
end
function this:GuideBehaviourSkip_Team_5010()--通关了副本，不再引导编队  
end


--任务引导----------------------------------------------------------------------------


--切换到周日常任务标签
-- function this:GuideBehaviour_Mission_11051()
--     EventMgr.Dispatch(EventType.Mission_Tab_Sel,2);
-- end

-- function this:GuideBehaviourStart_Mission_11051()
--     self.next_guide_hide = 1;
--     if(self:TryHideGuide())then
--         EventMgr.AddListener(EventType.View_Lua_Closed, this.Guide_Mission_11051_Event_View_Lua_Closed);
--     end   
-- end
-- function this.Guide_Mission_11051_Event_View_Lua_Closed(viewKey)
--     if(viewKey == "RewardPanel")then        
--         EventMgr.RemoveListener(EventType.View_Lua_Closed, this.Guide_Mission_11051_Event_View_Lua_Closed);
--         EventMgr.Dispatch(EventType.Guide_SetShowState,true);
--     end    
-- end



--副本战斗编队引导----------------------------------------------------------------------------


function this:GuideBehaviourStart_Team_5080()
    EventMgr.Dispatch(EventType.Drag_Card_Ctrl_State,false);
    
end
this.bronRow,this.bronCol=3,2 --队员首次放入阵盘的位置
this.targetRow,this.targetCol=1,1--拖拽队员的目标位置

function this:GuideBehaviourStart_Team_5091()
    CSAPI.DisableInput(100);
    EventMgr.Dispatch(EventType.Drag_Card_Ctrl_State,true);
    EventMgr.Dispatch(EventType.Team_Formation3D_SetRAndZ, {isRotate=false,isZoom=false});--禁用旋转和缩放

    local data = {};
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        data.forceData = {{row=this.bronRow,col=this.bronCol,cfgId=40290}};
    else
        ---日服以外地区
        data.forceData = {{row=1,col=1,cfgId=30200}};
    end
    data.forceCallBack = self.GuideBehaviourTeam_5091_CallBack;
    data.forceCaller = self;
    EventMgr.Dispatch(EventType.Team_FormationView_ForceMove,data);
    EventMgr.Dispatch(EventType.Team_FormationView_CharacterItemClickState,false);    
end
function this:GuideBehaviourTeam_5091_CallBack()
    EventMgr.Dispatch(EventType.Guide_Custom_Complete); 
    EventMgr.Dispatch(EventType.Team_FormationView_ForceMove,{});   
    EventMgr.Dispatch(EventType.Team_FormationView_CharacterItemClickState,true);    
end

function this:GuideBehaviourStart_Team_5110()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        EventMgr.Dispatch(EventType.Team_FormationInfo_SetRC,{row=this.bronRow,col=this.bronCol})
    else
        ---日服以外地区
        EventMgr.Dispatch(EventType.Team_FormationInfo_SetRC,{row=1,col=1})
    end
end

function this:GuideBehaviourStart_Team_5115()
    EventMgr.Dispatch(EventType.Team_FormationInfo_SetRC,{row=1,col=1})
    CSAPI.DisableInput(100);
    EventMgr.Dispatch(EventType.Drag_Card_Ctrl_State,true);
    local data = {};
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        data.forceData = {{row=this.targetRow,col=this.targetCol,cfgId=40290},{row=this.bronRow,col=this.bronCol,cfgId=40290}};
        --data.forceData = {{row=3,col=1,cfgId=40290}};
    else
        ---日服以外地区
        data.forceData = {{row=1,col=1,cfgId=30200},{row=3,col=1,cfgId=30200}};
        --data.forceData = {{row=3,col=1,cfgId=30200}};
    end
    data.forceCallBack = self.GuideBehaviourTeam_5115_CallBack;
    data.forceCaller = self;
    EventMgr.Dispatch(EventType.Team_FormationView_ForceMove,data);
end
function this:GuideBehaviourTeam_5115_CallBack(row,col)
    if(row ~= 3)then
        return;
    end
    EventMgr.Dispatch(EventType.Guide_Custom_Complete); 
    EventMgr.Dispatch(EventType.Team_FormationView_ForceMove,{});       
end

--进入副本0-1引导----------------------------------------------------------------------------

function this:GuideBehaviourSkipStep_Dungeon_6010()--通关了副本，跳过副本编队  
    if(DungeonMgr:CheckDungeonPass(1001))then
        return true;
    end 
end
function this:GuideBehaviourCondition_Dungeon_6010()    
    return true;
end

--副本0-1重复挑战----------------------------------------------------------------------------

function this:GuideBehaviourCondition_Dungeon_6070()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日服是整个函数注释掉
    else
        ---日服以外地区
        local state= DungeonMgr:CheckDungeonPass(1001);
        return state;
    end
end




--副本0-2引导----------------------------------------------------------------------------

function this:GuideBehaviourSkip_Dungeon_6010()  
end
function this:GuideBehaviourSkip_Dungeon_6020()
    if(CSAPI.IsViewOpen("Dungeon"))then
        return true;
    end    
end
function this:GuideBehaviourSkip_Dungeon_6025()
    if(CSAPI.IsViewOpen("Dungeon"))then
        return true;
    end    
end
--function this:GuideBehaviour_Dungeon_3020()
--    CSAPI.OpenView("Dungeon",{id=1});
--end
function this:GuideBehaviourSkip_Dungeon_6030()
    if(CSAPI.IsViewOpen("TeamConfirm"))then
        return true;
    end    
end
function this:GuideBehaviourSkip_Dungeon_6040()
    if(CSAPI.IsViewOpen("TeamConfirm"))then
        return true;
    end    
end
function this:GuideBehaviourSkip_Dungeon_6050()
    if(CSAPI.IsViewOpen("TeamConfirm"))then
        return true;
    end    
end
---【日服特有】
--- 修正：去掉 CloseInput(true) 引发的 first grid 为 nil 的报错
--- 6062 已取消，且不需要恢复到技能1，也不再锁战场输入
function this:GuideBehaviour_Dungeon_6061()
    EventMgr.Dispatch(EventType.Input_Select_Skill_Item, 2)
    -- 不再调用 FightGridSelMgr.CloseInput(true)
end
---【日服特有】
-- function this:GuideBehaviour_Dungeon_6062()
--    EventMgr.Dispatch(EventType.Input_Select_Skill_Item,1);
--    FightGridSelMgr.CloseInput(false);
-- end



--副本战斗TR-0引导----------------------------------------------------------------------------
function this:GuideBehaviourCondition_DFight0_1_7010()
    local data = GuideMgr:GetViewTriggerData();
    return data and data.dungeonId == 8002;
end

--引导破盾
function this:GuideBehaviourCondition_DFight0_1_7030()  
   if(FightClient:GetDirll())then
       return false;
   end
   local id = DungeonMgr:GetCurrId();      
   return id and id == 8002;
end

function this:GuideBehaviourStart_DFight0_1_7060()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日服内容已经注释
    else
        ---日服以外地区
        UIUtil:OpenQuestion("BreakShield");
    end
end

--副本同调战斗引导----------------------------------------------------------------------------


--引导同调
function this:GuideBehaviourCondition_Combo_8010()  
   if(FightClient:GetDirll())then
       return false;
   end
   local id = DungeonMgr:GetCurrId();      
   return id and id == 8003;
end

--引导使用霖大招
-- function this:GuideBehaviour_Combo_8030()
--     EventMgr.Dispatch(EventType.Input_Select_Skill_Item,1);
--     FightGridSelMgr.CloseInput(true);
--  end
--  function this:GuideBehaviour_Combo_8040()
--     FightGridSelMgr.CloseInput(false);
--     FightGridSelMgr.UpdateSelPos(2,2);--SP增加锁定女王蜂站位
--     EventMgr.Dispatch(EventType.Input_Select_OK);
--  end

--引导使用同调攻击
function this:GuideBehaviour_Combo_8030()
   EventMgr.Dispatch(EventType.Input_Select_Skill_Item,4);
   FightGridSelMgr.CloseInput(true);
end
function this:GuideBehaviour_Combo_8040()
   FightGridSelMgr.CloseInput(false);
   EventMgr.Dispatch(EventType.Input_Select_Skill_Item,4);
end

--基础引导
function this:GuideBehaviourCondition_Fight_9010()
    local data = GuideMgr:GetViewTriggerData();
    return data and data.dungeonId == 8001;
end

function this:GuideBehaviour_Fight_9030()
    EventMgr.Dispatch(EventType.Input_Select_Skill_Item,3);
    FightGridSelMgr.CloseInput(true);
 end
 function this:GuideBehaviour_Fight_9040()
    FightGridSelMgr.CloseInput(false);
    EventMgr.Dispatch(EventType.Input_Select_Skill_Item,3);
end
function this:GuideBehaviour_Fight_9060()
    EventMgr.Dispatch(EventType.Input_Select_Skill_Item,2);
    FightGridSelMgr.CloseInput(true);
 end
 function this:GuideBehaviour_Fight_9070()
    FightGridSelMgr.CloseInput(false);
    EventMgr.Dispatch(EventType.Input_Select_Skill_Item,2);
end
function this:GuideBehaviour_Fight_9100()
    FightGridSelMgr.CloseInput(true);
    EventMgr.Dispatch(EventType.Input_Select_Skill_Item,1);
    FightGridSelMgr.CloseInput(false);
end

--通关副本0-2引导----------------------------------------------------------------------------

function this:GuideBehaviourSkip_Pass0_3_10520()    
    return GuideMgr:IsGuided(110);--检测任务是否需要引导
end
function this:GuideBehaviourCondition_Pass0_3_10520()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日服函数已经注释
    else
        ---日服以外地区
        local state = DungeonMgr:CheckDungeonPass(1002);
        return state;
    end
end
--function this:GuideBehaviourStart_Pass0_3_10520()
--    self.next_guide_hide = 1;
--    if(self:TryHideGuide())then
--        EventMgr.AddListener(EventType.View_Lua_Closed, this.Guide_Pass0_3_10520_Event_View_Lua_Closed);
--    end   
--end
--function this.Guide_Pass0_3_10520_Event_View_Lua_Closed(viewKey)
--    if(viewKey == "RewardPanel")then        
--        EventMgr.RemoveListener(EventType.View_Lua_Closed, this.Guide_Pass0_3_10520_Event_View_Lua_Closed);
--        EventMgr.Dispatch(EventType.Guide_SetShowState,true);
--    end    
--end

--任务引导
function this:GuideBehaviourCondition_Mission_11010()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日服函数已经注释
    else
        ---日服以外地区
        local state = DungeonMgr:CheckDungeonPass(1002);
        return state;
    end
end

--30连引导
function this:GuideBehaviourCondition_Create_11310()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日服函数已经注释
    else
        ---日服以外地区
        local state = DungeonMgr:CheckDungeonPass(1002);
        return state and GuideMgr:IsGuided(110);
    end
end
--30连屏蔽分享
function this:GuideBehaviourStart_Create_11350()
    EventMgr.Dispatch(EventType.CreateRoleView_ShareBtn_SH,false)
end
--30连显示分享
function this:GuideBehaviourStart_Create_11360()
    EventMgr.Dispatch(EventType.CreateRoleView_ShareBtn_SH,true)
end

--30连后出击引导
function this:GuideBehaviourCondition_Create_11440()
    local state = DungeonMgr:CheckDungeonPass(1002);
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        return state and GuideMgr:IsGuided(114);
    else
        ---日服以外地区
        return state and GuideMgr:IsGuided(110);
    end
end

--通关副本0-5引导----------------------------------------------------------------------------

function this:GuideBehaviourSkip_Pass0_5_11520()    
    return GuideMgr:IsGuided(120);--检测基地是否需要引导
end
function this:GuideBehaviourCondition_Pass0_5_11520()
    local idNum=1005;
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---如果是日本地区
        idNum=1007;
    end
    local state = DungeonMgr:CheckDungeonPass(idNum);
    return state;
end
--function this:GuideBehaviourStart_Pass0_5_11520()
--    self.next_guide_hide = 1;
--    if(self:TryHideGuide())then
--        EventMgr.AddListener(EventType.View_Lua_Closed, this.Guide_Pass0_5_11520_Event_View_Lua_Closed);
--    end   
--end
--function this.Guide_Pass0_5_11520_Event_View_Lua_Closed(viewKey)
--    if(viewKey == "RewardPanel")then        
--        EventMgr.RemoveListener(EventType.View_Lua_Closed, this.Guide_Pass0_5_11520_Event_View_Lua_Closed);
--        EventMgr.Dispatch(EventType.Guide_SetShowState,true);
--    end    
--end

--基建引导----------------------------------------------------------------------------
function this:GuideBehaviourSkipStep_Base_12010()
    --发电厂已建造时跳过    
    if(MatrixMgr:BuildingIsOpen(BuildsType.PowerHouse))then 
        --LogError("跳过12010");
        return true;
    end
end
function this:GuideBehaviourSkip_Base_12010()
    --return MatrixMgr:CheckBuildingIsUpgrade(2,1);
    --发电厂已建造时跳过
end
function this:GuideBehaviourCondition_Base_12010()
    local idNum=1005;
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---如果是日本地区
        idNum=1007;
    end
    local state = DungeonMgr:CheckDungeonPass(idNum);
    return state;
    --return true;
end

function this:GuideBehaviour_Base_12053()
    MatrixMgr:OpenMatrixBuilding();
end

function this:GuideBehaviourStart_Base_12070()

    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("Matrix");
    end

end



--通关副本0-8引导----------------------------------------------------------------------------

function this:GuideBehaviourSkip_Pass0_8_12510()
    local state = DungeonMgr:CheckDungeonPass(1008);
    if(state)then
        self.skip_Pass0_8 = 1;  
    end
    return true;
end

function this:GuideBehaviourSkip_Pass0_8_12520()    
    return self.skip_Pass0_8;
end
function this:GuideBehaviourCondition_Pass0_8_12520()
    local state = DungeonMgr:CheckDungeonPass(1008);
    return state;
end
function this:GuideBehaviourStart_Pass0_8_12520()
    self.next_guide_hide = 1;
    if(self:TryHideGuide())then
        EventMgr.AddListener(EventType.View_Lua_Closed, this.Guide_Pass0_8_12520_Event_View_Lua_Closed);
    end   
end
function this.Guide_Pass0_8_12520_Event_View_Lua_Closed(viewKey)
    if(viewKey == "RewardPanel")then        
        EventMgr.RemoveListener(EventType.View_Lua_Closed, this.Guide_Pass0_8_12520_Event_View_Lua_Closed);
        EventMgr.Dispatch(EventType.Guide_SetShowState,true);
    end    
end

--通关副本1-14竞技场引导----------------------------------------------------------------------------
function this:GuideBehaviourCondition_Exercise_13010()
    local state = DungeonMgr:CheckDungeonPass(1114);
    return state;
 end

--竞技场编队引导----
 function this:GuideBehaviourCondition_Exercise_14010()  
    return GuideMgr:IsGuided(130);
 end


--通关副本1-5引导----------------------------------------------------------------------------

function this:GuideBehaviourSkip_Pass1_5_13510()
    local state = DungeonMgr:CheckDungeonPass(1105);
    --LogError("1105:" .. tostring(state));
    if(state)then
        self.skip_Pass1_5 = 1;  
    end
    return true;
end

function this:GuideBehaviourSkip_Pass1_5_13520()    
    --LogError("bbbbb");
    return self.skip_Pass1_5;
end
function this:GuideBehaviourCondition_Pass1_5_13520()
    local state = DungeonMgr:CheckDungeonPass(1105);
    return state;
end
function this:GuideBehaviourStart_Pass1_5_13520()
    self.next_guide_hide = 1;
    if(self:TryHideGuide())then
        EventMgr.AddListener(EventType.View_Lua_Closed, this.Guide_Pass1_5_13520_Event_View_Lua_Closed);
    end   
end
function this.Guide_Pass1_5_13520_Event_View_Lua_Closed(viewKey)
    if(viewKey == "RewardPanel")then        
        EventMgr.RemoveListener(EventType.View_Lua_Closed, this.Guide_Pass1_5_13520_Event_View_Lua_Closed);
        EventMgr.Dispatch(EventType.Guide_SetShowState,true);
    end    
end


--通关副本1-8引导----------------------------------------------------------------------------

function this:GuideBehaviourSkip_Pass1_8_14510()
    local state = DungeonMgr:CheckDungeonPass(1108);
   
    if(state)then
        self.skip_Pass1_8 = 1;  
    end
    return true;
end

function this:GuideBehaviourSkip_Pass1_8_14520()    
    return self.skip_Pass1_8;
end
function this:GuideBehaviourCondition_Pass1_8_14520()
    local state = DungeonMgr:CheckDungeonPass(1108);
    return state;
end
function this:GuideBehaviourStart_Pass1_8_14520()
    self.next_guide_hide = 1;
    if(self:TryHideGuide())then
        EventMgr.AddListener(EventType.View_Lua_Closed, this.Guide_Pass1_8_14520_Event_View_Lua_Closed);
    end   
end
function this.Guide_Pass1_8_14520_Event_View_Lua_Closed(viewKey)
    if(viewKey == "RewardPanel")then        
        EventMgr.RemoveListener(EventType.View_Lua_Closed, this.Guide_Pass1_8_14520_Event_View_Lua_Closed);
        EventMgr.Dispatch(EventType.Guide_SetShowState,true);
    end    
end

--弱引导----------------------------------------------------------------------------

--格子副本0-1
function this:GuideBehaviourCondition_Battle0_1_100510()
    local id = DungeonMgr:GetCurrId();   
    return id == 1001;
end

--格子副本TR-1
function this:GuideBehaviourCondition_Battle0_1A_102510()
    local id = DungeonMgr:GetCurrId();   
    return id == 8001;
end
function this:GuideBehaviourStart_Battle0_1A_102510()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("TR1");
    end
end

----格子副本0-3
--function this:GuideBehaviourCondition_Battle0_3_101010()
--    local id = DungeonMgr:GetCurrId();   
--    return id == 1003;
--end

----格子副本0-5
--function this:GuideBehaviourCondition_Battle0_5_102010()
--    local id = DungeonMgr:GetCurrId();   
--    return id == 1005;
--end

--格子副本0-6
function this:GuideBehaviourCondition_Battle0_6_103010()
    local id = DungeonMgr:GetCurrId();   
    return id == 1006;
end
function this:GuideBehaviourStart_Battle0_6_103010()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("EnemyMove");
    end
end


--格子副本1-4
function this:GuideBehaviourCondition_Battle1_4_104010()
    local id = DungeonMgr:GetCurrId();   
    return id == 1104;
end
function this:GuideBehaviourStart_Battle1_4_104010()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("CaseMate");
    end
end

--格子副本1-9
function this:GuideBehaviourCondition_Battle1_9_105010()
    local id = DungeonMgr:GetCurrId();   
    return id == 1109;
end
function this:GuideBehaviourStart_Battle1_9_105010()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("ICeSurface");
    end
end

--格子副本1-11
function this:GuideBehaviourCondition_Battle1_11_106010()
    local id = DungeonMgr:GetCurrId();   
    return id == 1111;
end
function this:GuideBehaviourStart_Battle1_11_106010()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("IceTrap");
    end
end

--格子副本1-19
function this:GuideBehaviourCondition_Battle1_19_106510()
    local id = DungeonMgr:GetCurrId();   
    return id == 1119;
end
function this:GuideBehaviourStart_Battle1_19_106510()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("LightningStroke");
    end
end


--角色装备界面
function this:GuideBehaviourStart_RoleEquip_109530()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("Chip");
    end
end


--AI设置
function this:GuideBehaviourCondition_AISetting_111010()
   local data = GuideMgr:GetViewTriggerData();
    local idNum=1004;
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---如果是日本地区
        idNum=1102;
    end
    return data and data.dungeonId == idNum;
end

function this:GuideBehaviourStart_AISetting_111060()
    UIUtil:OpenQuestion("AutoBattle");
end

--助战
function this:GuideBehaviourCondition_Support_112010()  
   local data = GuideMgr:GetViewTriggerData();
   return data and data.dungeonId == 1101;
end


--日常副本进入引导
function this:GuideBehaviourCondition_DungeonDaily_113010()
    local idNum=1106; ----已通关1-6
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---如果是日本地区
        idNum=1008;---已通关0-8
    end
    -- local dungeonId = DungeonMgr:GetCurrFightId();
    local state = DungeonMgr:CheckDungeonPass(idNum);
    return state;
end
---【日服特有】
function this:GuideBehaviourCondition_DungeonDaily_113020()
    -- local dungeonId = DungeonMgr:GetCurrFightId();
    local state = DungeonMgr:CheckDungeonPass(1106);
    return state;--已通关0-8
end


---国内:通关副本0-7引导----------------------------------------------------------------------------
---海外:通关副本0-7(改为0-6)引导----------------------------------------------------------------------------
function this:GuideBehaviourSkip_Pass0_2_114010()    
    return GuideMgr:IsGuided(100);--检测战术部署是否需要引导
end
function this:GuideBehaviourCondition_Pass0_2_114010()
    local idNum=1007;
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---如果是日本地区
        idNum=1006;
    end
    local state = DungeonMgr:CheckDungeonPass(idNum);
    return state;
end
--function this:GuideBehaviourStart_Pass0_2_9520()
--    self.next_guide_hide = 1;
--    if(self:TryHideGuide())then
--        EventMgr.AddListener(EventType.View_Lua_Closed, this.Guide_Pass0_2_9520_Event_View_Lua_Closed);
--    end   
--end
--function this.Guide_Pass0_2_9520_Event_View_Lua_Closed(viewKey)
--    if(viewKey == "RewardPanel")then        
--        EventMgr.RemoveListener(EventType.View_Lua_Closed, this.Guide_Pass0_2_9520_Event_View_Lua_Closed);
--        EventMgr.Dispatch(EventType.Guide_SetShowState,true);
--    end    
--end


--战术界面引导----------------------------------------------------------------------------

function this:GuideBehaviourCondition_PlayerAbility_115010()
    local idNum=1007;
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---如果是日本地区
        idNum=1006;
    end
    local state= DungeonMgr:CheckDungeonPass(idNum);
    if state then --已通关TR3
        return PlayerAbilityMgr:CheckIsOpen(1) and PlayerAbilityMgr:CheckIsOpen(2);
    end
    return state;
    
end


function this:GuideBehaviourStart_PlayerAbility_115030()
    -- CSAPI.DisableInput(1500);
    -- EventMgr.Dispatch(EventType.Player_Ability_CanClick,false);

    local vpGuide = CSAPI.GetViewPanel("Guide");
    if(vpGuide)then
        local canvas = ComUtil.AddCom(vpGuide,"Canvas");
        if(canvas)then
            canvas.overrideSorting = true;
            canvas.sortingOrder = 101;--将旧的100改为了101  
            ComUtil.AddCom(vpGuide,"GraphicRaycaster");        
        end
    end
end


-- function this:GuideBehaviourStart_PlayerAbility_116040()    
--     FuncUtil:Call(EventMgr.Dispatch,nil,800,EventType.Player_Ability_CanClick,false);
-- end
-- function this:GuideBehaviourStart_PlayerAbility_116050()    
--     EventMgr.Dispatch(EventType.Player_Ability_CanClick,true);
-- end
-- function this:GuideBehaviour_PlayerAbility_116140_CallBack()
--     return not PlayerAbilityMgr:CheckIsOpen(1) and not PlayerAbilityMgr:CheckIsOpen(2);
-- end

--TR-3引导战术技能装备与使用

function this:GuideBehaviourCondition_PlayerAbility_116010()
    local data = GuideMgr:GetViewTriggerData();
    return data and data.dungeonId == 8004;
end
-- function this:GuideBehaviour_PlayerAbility_116040()
--     UIUtil:OpenQuestion("AutoBattle");
-- end

function this:GuideBehaviourCondition_PlayerAbility_116070()
    FightGridSelMgr.CloseInput(false);
    FightGridSelMgr.UpdateSelPos(2,2);--锁定角色位置
    EventMgr.Dispatch(EventType.Input_Select_OK);
end

--爬塔主界面进入引导----------------------------------------------------------------------------

function this:GuideBehaviourCondition_Tower_117010()     
    return DungeonMgr:CheckDungeonPass(1120) and not GuideMgr:IsGuided(1175);
    
end

--爬塔章节引导----------------------------------------------------------------------------
function this:GuideBehaviourCondition_Tower_117510()     
    return DungeonMgr:CheckDungeonPass(1120);
    
end


--爬塔第一关引导----------------------------------------------------------------------------

function this:GuideBehaviourCondition_TowerBattle_118010()
    local id = DungeonMgr:GetCurrId();
    return id == 10001;
end

function this:GuideBehaviour_TowerBattle_118030()
    BattleMgr:ApplyMove(10203);
end

function this:GuideBehaviourStart_TowerBattle_118080()

    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("TowerBase");
    end
end


--爬塔第二关引导----------------------------------------------------------------------------

function this:GuideBehaviourCondition_TowerBattle_121010()
    local id = DungeonMgr:GetCurrId();   
    return id == 10002;   
end
function this:GuideBehaviourStart_TowerBattle_121030()

    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("IceSurface");
    end
end

--爬塔第三关引导----------------------------------------------------------------------------

function this:GuideBehaviourCondition_TowerBattle_122010()
    local id = DungeonMgr:GetCurrId();   
    return id == 10004;
    
end
function this:GuideBehaviourStart_TowerBattle_122020()

    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("IceTrap");
    end
end

--爬塔宙斯引导----------------------------------------------------------------------------

function this:GuideBehaviourCondition_TowerBattle_123010()
    local id = DungeonMgr:GetCurrId();   
    return id == 10005; 
end
function this:GuideBehaviourStart_TowerBattle_123020()

    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("LightningStroke");
    end
end
function this:GuideBehaviourCondition_TowerBattle_124010()
    local id = DungeonMgr:GetCurrId();   
    return id == 10101; 
end
function this:GuideBehaviourStart_TowerBattle_124010()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("Block");
    end
end
function this:GuideBehaviourCondition_TowerBattle_125010()
    local id = DungeonMgr:GetCurrId();   
    return id == 10103; 
end
function this:GuideBehaviourStart_TowerBattle_125010()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("SkyEye");
    end
end
function this:GuideBehaviourCondition_TowerBattle_126010()
    local id = DungeonMgr:GetCurrId();   
    return id == 10104; 
end
function this:GuideBehaviourStart_TowerBattle_126010()

    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("Inject");
    end
end

--乱序空间引导----------------------------------------------------------------------------
function this:GuideBehaviourCondition_RogueBattle_130010()
    return GuideMgr:IsGuided(1270);--检测之前的引导是否通过
end

--机神解限关卡引导----------------------------------------------------------------------------
function this:GuideBehaviourCondition_KishinBreak_141010()  
   if(FightClient:GetDirll())then
       return false;
   end
   local id = DungeonMgr:GetCurrId();      
   return id and id == 1319;
end
--引导机神召唤
function this:GuideBehaviour_KishinBreak_141020()
   EventMgr.Dispatch(EventType.Input_Select_Skill_Item,4);
   FightGridSelMgr.CloseInput(true);
end
function this:GuideBehaviour_KishinBreak_141030()
   FightGridSelMgr.CloseInput(false);
   EventMgr.Dispatch(EventType.Input_Select_Skill_Item,4);
end

--引导机神技能释放
function this:GuideBehaviour_KishinBreak_141040()
    EventMgr.Dispatch(EventType.Input_Select_Skill_Item,2);
    FightGridSelMgr.CloseInput(true);
 end
 function this:GuideBehaviour_KishinBreak_141050()
    FightGridSelMgr.CloseInput(false);
    EventMgr.Dispatch(EventType.Input_Select_Skill_Item,2);
 end

--机神解限强制引导
function this:GuideBehaviourSkip_KishinBreak_141510()    
    return GuideMgr:IsGuided(1420);--检测是否需要引导
end
function this:GuideBehaviourCondition_KishinBreak_141510()
    return DungeonMgr:CheckDungeonPass(1319) and GuideMgr:IsGuided(1410);
end

function this:GuideBehaviourCondition_KishinBreak_142010()     
    return DungeonMgr:CheckDungeonPass(1319) and GuideMgr:IsGuided(1410);
end
-- function this:GuideBehaviourStart_KishinBreak_142030() 
--     local roleListData = table.copy(SortMgr:GetData(1))
--     roleListData["Filter"]["CfgTeamEnum"] = {8}
--     SortMgr:SetData(1, roleListData)
--     EventMgr.Dispatch(EventType.Role_Captain_ToFirst);
-- end
function this:GuideBehaviourStart_KishinBreak_142050()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("KishinBreak");
    end
end

--钓鱼佬编队关卡引导
function this:GuideBehaviourCondition_FishMan_143010()
    local data = GuideMgr:GetViewTriggerData();
    return data and data.dungeonId == 96114;
end
function this:GuideBehaviourStart_FishMan_143020()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("FishMan");
    end
end
--宠物首次引导
function this:GuideBehaviourCondition_Pet_144010()
    return DungeonMgr:CheckDungeonPass(1008);--检测是否需要引导
end
function this:GuideBehaviourStart_Pet_144020()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("PetMainFirst");
    end
end

--第三章爬塔第一关引导----------------------------------------------------------------------------

function this:GuideBehaviourCondition_TowerBattle_145010()
    local id = DungeonMgr:GetCurrId();
    return id == 10201;
end
function this:GuideBehaviourStart_TowerBattle_145020()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("QuickSand");
    end
end

--第三章爬塔第二关引导----------------------------------------------------------------------------

function this:GuideBehaviourCondition_TowerBattle_146010()
    local id = DungeonMgr:GetCurrId();
    return id == 10202;
end

function this:GuideBehaviourStart_TowerBattle_146020()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("RockFall");
    end
end

--第三章爬塔第四关引导----------------------------------------------------------------------------
function this:GuideBehaviourCondition_TowerBattle_147010()
    local id = DungeonMgr:GetCurrId();
    return id == 10204;
end

function this:GuideBehaviourStart_TowerBattle_147030()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("SandStorm");
    end
end

--角斗场引导----------------------------------------------------------------------------

function this:GuideBehaviourSkip_Colosseum_150010()    
    return GuideMgr:IsGuided(1505);--检测跳过本身的情况
end
function this:GuideBehaviourCondition_Colosseum_150010()
    return not GuideMgr:IsGuided(1505);
end
function this:GuideBehaviourSkip_Colosseum_150025()    
    return GuideMgr:IsGuided(1500);--检测跳过本身的情况
end
function this:GuideBehaviourCondition_Colosseum_150025()
    return not GuideMgr:IsGuided(1500);
end

function this:GuideBehaviourStart_Colosseum_152030()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("ColosseumView");
    end
end
---【日服特有】
function this:GuideBehaviourCondition_Colosseum_149100()
    return ColosseumMgr:CheckEnterOpen() and DungeonMgr:CheckDungeonPass(1201)
end
---【日服特有】
function this:GuideBehaviourStart_Colosseum_149101()
    EventMgr.Dispatch(EventType.Section_Guide_Update,{type = 3,index = 2});
end
--能力检测引导----------------------------------------------------------------------------


function this:GuideBehaviourStart_AbilityTest_154040()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        ---日服地区
        ---日本地区 内容已经注释 已在表格中配置
    else
        ---日服以外地区
        UIUtil:OpenQuestion("RogueTView");
    end
end

function this:GuideBehaviourCondition_AbilityTest_155010()
    return GuideMgr:IsGuided(1530);
end

function this:GuideBehaviourCondition_AbilityTest_156010()
    return GuideMgr:IsGuided(1530);
end

--------------------------------------------------------------------------------------日服特有下----------------------------------------------------
--编队引导----------------------------------------------------------------------------

function this:GuideBehaviourCondition_RoleInfo_108001()
    return DungeonMgr:CheckDungeonPass(1001);
end

--0-1通过继续战斗引导----------------------------------------------------------------------------

function this:GuideBehaviourCondition_Dungeon_109010()
    return DungeonMgr:CheckDungeonPass(1001);
end


--特装构建引导----------------------------------------------------------------------------

function this:GuideBehaviourCondition_Create_11410()

    return DungeonMgr:CheckDungeonPass(1002) and GuideMgr:IsGuided(113);
end

--教程引导----------------------------------------------------------------------------
function this:GuideBehaviourCondition_Course_158010()
    return DungeonMgr:CheckDungeonPass(1003);
end

function this:GuideBehaviour_Course_158080()
    EventMgr.Dispatch(EventType.Input_Select_Skill_Item,3);
    FightGridSelMgr.CloseInput(true);
end
function this:GuideBehaviour_Course_158090()
    FightGridSelMgr.CloseInput(false);
    EventMgr.Dispatch(EventType.Input_Select_Skill_Item,3);
end
function this:GuideBehaviour_Course_158110()
    EventMgr.Dispatch(EventType.Input_Select_Skill_Item,2);
    FightGridSelMgr.CloseInput(true);
end
function this:GuideBehaviour_Course_158120()
    FightGridSelMgr.CloseInput(false);
    EventMgr.Dispatch(EventType.Input_Select_Skill_Item,2);
end
function this:GuideBehaviour_Course_158140()

    EventMgr.Dispatch(EventType.Input_Select_Skill_Item,1);
    FightGridSelMgr.CloseInput(true);
end
function this:GuideBehaviour_Course_158150()
    FightGridSelMgr.CloseInput(false);
    EventMgr.Dispatch(EventType.Input_Select_Skill_Item,1);
end
--星数引导----------------------------------------------------------------------------

function this:GuideBehaviourCondition_Dungeon_159010()
    return DungeonMgr:CheckDungeonPass(1004);--
end

--1-8自动完成引导-前置条件----------------------------------------------------------------------------
function this:GuideBehaviourStart_Dungeon_175010()
    FuncUtil:Call(function()
        EventMgr.Dispatch(EventType.Guide_Custom_Complete);
    end,nil,50);
end

--0-1困难引导----------------------------------------------------------------------------

function this:GuideBehaviourSkipStep_Dungeon_180010()
    if DungeonMgr:CheckDungeonPass(2001) then
        return true
    end
end

function this:GuideBehaviourCondition_Dungeon_180010()
    local viewGO = CSAPI.GetView("Section")
    if viewGO then
        local view = ComUtil.GetLuaTable(viewGO)
        return view and view.data == nil --检测有没跳转
    end
    return false
end

function this:GuideBehaviourStart_Dungeon_180010()
    FuncUtil:Call(function()
        EventMgr.Dispatch(EventType.Dungeon_MainLine_Update,1)
    end,nil,50);
end

function this:GuideBehaviourStart_Dungeon_180030()
    FuncUtil:Call(function()
        EventMgr.Dispatch(EventType.Dungeon_MainLine_Guide_Refresh,1)
    end,nil,50);
end

function this:SetRoleListNormalFirstPoint()
    local roleListData = table.copy(SortMgr:GetData(1))
    roleListData["Filter"]["CfgTeamEnum"] = {8}
    SortMgr:SetData(1, roleListData)
    EventMgr.Dispatch(EventType.Role_Captain_ToFirst);
end

function this:GuideBehaviourStart_RoleSkill_107008()
    self:SetRoleListNormalFirstPoint()
end
function this:GuideBehaviourStart_RoleInfo_108003()
    self:SetRoleListNormalFirstPoint()
end
function this:GuideBehaviourStart_KishinBreak_142030() 
    self:SetRoleListNormalFirstPoint()
end
function this:GuideBehaviourStart_SkillUp_157030()
    self:SetRoleListNormalFirstPoint()
end
function this:GuideBehaviourStart_FightLost_160020()
    self:SetRoleListNormalFirstPoint()
end
function this:GuideBehaviourStart_RoleInfo_210030()
    self:SetRoleListNormalFirstPoint()
end
function this:GuideBehaviourStart_RoleInfo_220030()
    self:SetRoleListNormalFirstPoint()
end
function this:GuideBehaviourStart_RoleInfo_230030()
    self:SetRoleListNormalFirstPoint()
end

--芯片自动匹配-日服引导-------------------------------------------------------------------
--------------------------------------------------------------------------------------日服特有上----------------------------------------------------
function this:GuideBehaviourStart_RoleInfo_220040()
    EventMgr.Dispatch(EventType.Guide_RoleInfo_220040,true)
end
function this:GuideBehaviourComplete_RoleInfo_220040()
    EventMgr.Dispatch(EventType.Guide_RoleInfo_220040,false)
end
function this:GuideBehaviourStart_RoleInfo_230070()
    EventMgr.Dispatch(EventType.Guide_RoleInfo_230070,true)
end
function this:GuideBehaviourComplete_RoleInfo_230070()
    EventMgr.Dispatch(EventType.Guide_RoleInfo_230070,false)
end

function this:GuideBehaviourSkipStep_RoleInfo_210020()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        local data = RoleMgr:GetLeader2()
        if(not data or data:GetLv()>=20)then 
            return true
        end 
    end 
    return false
end

function this:GuideBehaviourSkipStep_RoleInfo_230010()
    if CSAPI.IsADVRegional(3) or CSAPI.IsADVRegional(6) then
        local data = RoleMgr:GetLeader2()
        if(not data or data:GetBreakLevel()>1)then 
            return true
        end
    end 
    return false
end

function this:GuideBehaviourCondition_VirtualCataclysm_190210()
    local _datas = VirCatMgr:GetArr(VirCatMgr:GetStage())
    if _datas and _datas[1] and not _datas[1]:IsPass() then
        return true
    end
    return false
end

function this:GuideBehaviourCondition_VirtualCataclysm_190110()
    local _datas = VirCatMgr:GetArr(VirCatMgr:GetStage())
    if _datas then
        for i, v in ipairs(_datas) do
            if not v:IsPass() then
                return true
            end
        end
    end
    return false
end

function this:GuideBehaviourStart_VirtualCataclysm_190130()
    EventMgr.Dispatch(EventType.Guide_VirtualCataclysm_Item_Select)
end


return this;