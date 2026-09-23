--引导管理
local GuideBehaviour = require "GuideBehaviour";


GuideMgr = {};
local this = GuideMgr;
this.IsGuideEnd=false;
function this:GetGuideKey()
    return "guide_data_key";
end

function this:Init()
    self:SetCanSkipStep(true);
    self:InitListener();
end

--请求数据
function this:RequestData()
    self:Clear();

    EventMgr.AddListener(EventType.Loading_Start,this.OnLoadingStart);
    EventMgr.AddListener(EventType.Dungeon_Data_Setted,this.OnDungeonDataSetted);
    EventMgr.Dispatch(EventType.Loading_Weight_Apply,loading_weight_key);
    --FuncUtil:Call(self.ApplyLoadComplete,self,2000);

    PlayerProto:GetClientData(self:GetGuideKey());
end
function this:ReceData(data)
    self:SetData(data);
    self:ApplyLoadComplete();  
end


--加载界面控制

--开场角色加载loading界面控制用的key
local loading_weight_key = "guide_init";
function this.OnLoadingStart()  
    EventMgr.Dispatch(EventType.Loading_Weight_Apply,loading_weight_key);
end

function this.OnDungeonDataSetted()
   GuideMgr:ApplyLoadComplete();
end

function this:ApplyLoadComplete()   
    if(not self.guideData or not DungeonMgr:GetAlDungeonDatas())then
        return;
    end

    EventMgr.RemoveListener(EventType.Loading_Start,this.OnLoadingStart);
    EventMgr.RemoveListener(EventType.Dungeon_Data_Setted,this.OnDungeonDataSetted);
    
    --关闭loading界面
    EventMgr.Dispatch(EventType.Loading_Weight_Update,loading_weight_key);     
end

--清理
function this:Clear()
    self.guideData = nil;
    self.currGuides = nil;
    self.doingGuide = nil;
    self.canSkipStep=true;
end

function this:CanSkipStep()
    return self.canSkipStep;
end

function this:SetCanSkipStep(_canSkip)
    self.canSkipStep=_canSkip;
end

--设置数据
function this:SetData(data)
    self.guideData = data or {};
    self:InitCurrGuide();    
    
--    LogError("新手引导数据：\n" .. table.tostring(data));
--    LogError("当前新手引导：\n" .. table.tostring(self.currGuides));
end
--记录引导完成
function this:Record(group)
    if(not group)then
        return;
    end    

    self.guideData = self.guideData or {};

    local groupKey = self:GetKey(group);
    if(self.guideData[groupKey])then
        return;
    end
    self.guideData[groupKey] = 1;
    --LogError("记录引导：" .. table.tostring(self.guideData));
    self:SaveGuideData(self.guideData);


    --上报数数
    local groupName = self:GetGroupName(group);
    if(groupName)then
        local _data = {};
        _data["guide_step"] = groupName;
        _data["guide_id"] = group;
        if CSAPI.IsADV()==false then
            BuryingPointMgr:TrackEvents("guide_completed", _data);
        end
    end
end

function this:GetGroupName(group)
    if(not self.groupNames)then
        self.groupNames = {};
        self.groupNames[10] = "新手战斗";
        self.groupNames[30] = "机神召唤";
        self.groupNames[40] = "抽卡";
        self.groupNames[50] = "编队";
        self.groupNames[60] = "副本";
        self.groupNames[70] = "破盾";
        self.groupNames[100] = "战斗部署";
        self.groupNames[110] = "任务";
        self.groupNames[120] = "基地";
    end

    return self.groupNames[group];
end


function this:SaveGuideData(guideData)
    if(not NetMgr.net:IsConnected())then
        self:NetException();
        return;
    end

    PlayerProto:SetClientData(self:GetGuideKey(),guideData);
end

function this:GetKey(group)
    return "k" .. group;
end

function this:InitCurrGuide()
    local currGuides = {};

    cfgsGuide = Cfgs.Guide:GetAll();
    
    for id,cfgGuide in pairs(cfgsGuide)do
        if(cfgGuide.group and cfgGuide.group ~= 0)then--未分组的引导，有特殊作用
            if(not self:IsGroupComplete(cfgGuide.group))then
                local line = cfgGuide.line or 0;

                if(currGuides[line])then
                    local currCfg = currGuides[line].cfg;
                    if(cfgGuide.id < currCfg.id)then
                        currGuides[line].cfg = cfgGuide;
                    end
                else
                    currGuides[line] = { cfg = cfgGuide };
                end
            end
        end
    end

    self.currGuides = currGuides;
    --self.currGuides = currGuides;--临时屏蔽引导

    --LogError("初始化引导完成，当前引导：\n" .. table.tostring(self.currGuides) );
end

--获取下一个引导id
function this:GetNextGuide(startId)
    local cfg = Cfgs.Guide:GetByID(startId);

    if(cfg.next_id)then
        return cfg.next_id;
    end

    local cfgs = Cfgs.Guide:GetAll();

    local currId = nil;
    for id,cfgGuide in pairs(cfgs)do
        if(id > startId and cfg.group == cfgGuide.group)then
            if(currId)then
                currId = math.min(currId,id);
            else
                currId = id;
            end
        end    
    end
    
    return currId;    
end

function this.OnViewTriggerGuide(data)
    --LogError(data);
    this:ViewTriggerGuide(data);
end
function this:ViewTriggerGuide(data)
    self.viewTriggerData = data;
    self:CheckGuide("ViewTrigger");
end
function this:GetViewTriggerData()
    return self.viewTriggerData;
end


function this.OnTriggerFlag(data)
    this:TriggerFlag(data);
end
function this:TriggerFlag(data)
    self:CheckGuide(data);
end


--打开界面触发的引导默认延迟100ms，以让Input_Event_Trigger优先触发
function this.OnViewOpened(viewKey)   
    this.openViewKeys = this.openViewKeys or {}
    table.insert(this.openViewKeys,viewKey)
    if (not this.ViewOpenGuide_lock) then
        this.ViewOpenGuide_lock = 1
        FuncUtil:Call(function ()
            local len = #this.openViewKeys
            for k=1, len do
                local _viewKey = this.openViewKeys[1]
                this:ViewOpenGuide(_viewKey)
                table.remove(this.openViewKeys,1)
            end
            this.ViewOpenGuide_lock = nil
        end, nil, 100)
    end
    --this:ViewOpenGuide(viewKey);
end

function this:ViewOpenGuide(viewKey)
    if(viewKey)then
        self:CheckGuide("ViewOpen_" .. viewKey);
    end
end

--检测引导.
function this:CheckGuide(flag) 

    local currGuideIds = {};
    if(self.currGuides)then
        for _,tmp in pairs(self.currGuides)do
            table.insert(currGuideIds,tmp.cfg.id);
        end
    end
    -- if self:CanSkipStep()~=true then --GM命令时执行排序
        table.sort(currGuideIds,function(a,b)
            return a<b;
        end)
    -- end
    --LogError("尝试触发引导！ Flag：" .. tostring(flag) .. ",待引导：" .. table.tostring(currGuideIds) .. "\n引导中：" ..  table.tostring(self.doingGuide));
    if(self.doingGuide)then
        return true;
    end
--    LogError("aaaaaaaaaaaaaaaaaaaaa")
    local triggerGuide = nil;
    -- if self:CanSkipStep()~=true then
        if(currGuideIds)then
            -- LogError(self.currGuides)
            for _,id in ipairs(currGuideIds)do
                local cfg=Cfgs.Guide:GetByID(id);
                local line=cfg and cfg.line or 0;
                if cfg and self.currGuides and self.currGuides[line] then
                    local guideData=self.currGuides[line];
                    -- LogError("id:"..tostring(id).."\t"..table.tostring(guideData))
                    if guideData then
                        if(self:CanGuide(cfg,flag))then                            
                            triggerGuide = guideData;
                            break;
                        end            
                    end
                end
            end
        end
    -- else
    --     if(self.currGuides)then
    --         for _,guideData in pairs(self.currGuides)do
    --             local cfg = guideData.cfg;
    --             if(self:CanGuide(cfg,flag))then                            
    --                 triggerGuide = guideData;
    --                 break;
    --             end            
    --         end
    --     end
    -- end
    
    -- LogError("执行引导" .. (triggerGuide and triggerGuide.cfg.id or "") .. table.tostring(triggerGuide));
    if(triggerGuide)then
        self:DoGuide(triggerGuide,flag);
        return true;
    end
end

--是否已引导
function this:IsGuided(group)
    return self.guideData and self.guideData[self:GetKey(group)];
end

--有引导
function this:HasGuide(flag)     
    --LogError("flag:" .. tostring(flag));
    if(self.currGuides)then        
        for _,guideData in pairs(self.currGuides)do
            local cfg = guideData.cfg;
            if(self:CanGuide(cfg,flag))then
                return true;                
            end
        end
    end
end
--是否有需要在主菜单上进行的引导
function this:HasMenuGuide()
    if(self.currGuides)then        
        for _,guideData in pairs(self.currGuides)do
            local cfg = guideData.cfg;
            if(cfg.menu_guide)then
                return true;                
            end
        end
    end
end

function this:CanGuide(cfg,flag)
    local conditionLv = PlayerClient:GetLv() >= (cfg.lv or 0);
    local conditionScene = not cfg.trigger_scene or (SceneMgr:IsLoaded() and cfg.trigger_scene == self:GetCurrSceneName());
    local conditionFlag = not cfg.trigger_flag or cfg.trigger_flag == flag;
    local state = conditionLv and conditionScene and conditionFlag;

--    LogError("引导条件检测========================================");
--    LogError(cfg);
--    if(conditionLv)then LogError("lv"); end
--    if(conditionScene)then LogError("scene"); end
--    if(conditionFlag)then LogError("flag"); end

    if(state and cfg.custom_condition and cfg.name)then--自定义条件满足
         local func = GuideBehaviour["GuideBehaviourCondition_" .. cfg.name];
         if(func)then
            state = func(GuideBehaviour);
         else
            LogError("custom guide behaviour missing:" .. tostring(cfg.id));
         end
    end

    --配置表条件
    if(state)then
        state = self:CfgCondition(cfg);
    end
    -- LogError(tostring(state) .. cfg.id);
    return state;
end

--自定义配置条件
function this:CfgCondition(cfg)
    local conditionArr = cfg.condition_check;
    if(not conditionArr)then
        return true;
    end

    local state = true;
    for _,condition in pairs(conditionArr) do
        local str = condition[1];
        local val = condition[2]; 
        if(str and string.lower(str) == "checkdungeonpass")then
            if(not DungeonMgr:CheckDungeonPass(val))then
                state = false;
                break;
            end
        elseif(str and string.lower(str) == "isguided")then
            if(not GuideMgr:IsGuided(val))then
                state = false;
                break;
            end  
        elseif(str and string.lower(str) == "getcurrdungeonid")then
            if(DungeonMgr:GetCurrId() ~= val)then
                state = false;
                break;
            end         
        else
            LogError(string.format("引导条件condition_check配置错误%s",table.tostring(cfg,true)));   
        end
    end

    return state;
end

function this:TrySkipStep(cfg)
    local name = cfg and cfg.name or "";
    local func = GuideBehaviour["GuideBehaviourSkipStep_" .. name];
    if(func) and self:CanSkipStep() then
        return func();
    end  
end

function this:DoGuide(data,flag)
    this.IsGuideEnd=true;
    if(self:CheckRoll(data.cfg))then--回滚到指定引导
        self:CheckGuide(flag);
        return;
    end 

    self.doingGuide = data;    


    if(self:TrySkipStep(data.cfg))then
        self:GuideSkipLine();
        return;
    end


    if(self:CheckSkip(data.cfg))then--跳过该步引导
        self:InputEventTrigger();
        return;     
    end 

    if(data.cfg.close_view)then
        CSAPI.CloseAllOpenned();
    end
    -- LogError("执行引导" .. table.tostring(data,true));

    CSAPI.OpenView("Guide",data);

     --引导步骤开始时处理
    local guideName = data.cfg.name;
    if(guideName)then
        --LogError("GuideBehaviourComplete_" .. guideName);
        local func = GuideBehaviour["GuideBehaviourStart_" .. guideName];
        if(func)then
            func(GuideBehaviour);
        end  
    end

    local openQuestion = data.cfg.openQuestion;
    if(not StringUtil:IsEmpty(openQuestion))then
        UIUtil:OpenQuestion(openQuestion);
    end
end
--检测回滚
function this:CheckRoll(cfg)
    if(cfg.roll)then--回滚
         local func = GuideBehaviour["GuideBehaviourRoll_" .. cfg.name];
         local state = func(GuideBehaviour);
         return state;
    end
    return false;
end
--检测跳过
function this:CheckSkip(cfg)
    if(cfg.custom_skip) and self:CanSkipStep() then--跳过
         local func = GuideBehaviour["GuideBehaviourSkip_" .. cfg.name];
         local state = func(GuideBehaviour);
         --LogError(tostring(state));
         return state;
    end
    return false;
end

function this:GetBehaviour()
    return GuideBehaviour;
end

function this:IsGuiding()
    return self.doingGuide;
end



--执行引导行为
function this:ApplyBehaviour(cfg)
  
    local func = GuideBehaviour["GuideBehaviour_" .. cfg.name];
    if(func)then
        func(GuideBehaviour);
    end  
    if(not cfg.custom_complete)then
        self:InputEventTrigger();   
    end
end

function this:ApplyCallBtn(cfg)
    
    local viewGo = nil;
    if(cfg.view_open)then    
        viewGo = CSAPI.GetViewPanel(cfg.view_open);   
    end

    local state = CSAPI.ApplyCallBtn(cfg.btn_check,"OnClick",viewGo);
    if(state)then
        if(not cfg.custom_complete)then
            self:InputEventTrigger();   
        end
    end
    return state;
end

--分组是否完成
function this:IsGroupComplete(group)
    if(self.guideData)then
        return self.guideData[self:GetKey(group)];
    end
    return false;
end


function this:InitListener()
    EventMgr.AddListener(EventType.Guide_Trigger,self.OnCheckGuide);
    EventMgr.AddListener(EventType.Guide_Trigger_View,self.OnViewTriggerGuide);
    EventMgr.AddListener(EventType.Guide_Trigger_Flag,self.OnTriggerFlag);
    
    EventMgr.AddListener(EventType.View_Lua_Opened, self.OnViewOpened)
    EventMgr.AddListener(EventType.Guide_Skip,self.OnGuideSkip);
    EventMgr.AddListener(EventType.Guide_Skip_Line,self.OnGuideSkipLine);
end

--加载完成
function this.OnCheckGuide(flag)   
    this:CheckGuide(flag);
end

--网络异常
function this:NetException()
    self:CloseGuideView();
    CSAPI.OpenView("Prompt", {content =LanguageMgr:GetTips(8036)  ,okCallBack=function()
        CSAPI.Quit();		
	end});
end

function this:CloseGuideView()
    CSAPI.CloseView("Guide");
end

function this:InputEventTrigger()       
    if(not NetMgr.net:IsConnected())then
        self:NetException();
        return;
    end


    local doingGuide = self.doingGuide;
    --LogError("引导完成：" .. (doingGuide and doingGuide.cfg.id or "") .. "\n"  .. table.tostring(doingGuide));
    if(not doingGuide)then
        return;
    end

    --引导步骤完成时处理
    local guideName = doingGuide.cfg.name;
    if(guideName)then
        --LogError("GuideBehaviourComplete_" .. guideName);
        local func = GuideBehaviour["GuideBehaviourComplete_" .. guideName];
        if(func)then
            func(GuideBehaviour);
        end  
    end

    --引导记录
    local recordId = doingGuide.cfg.record_id; 
    if(recordId)then
        if CSAPI.IsADV() then
            local cfg =Cfgs.UpdateData:GetByID(tonumber(recordId))
            if cfg and cfg.TE_event then
                BuryingPointMgr:TrackEvents(cfg.TE_event)
            end
        else
            BuryingPointMgr:BuryingPoint("after_login", recordId);
        end
    end

    EventMgr.Dispatch(EventType.Guide_Scroll_Switch,true,true);
    CSAPI.DisableInput(500);--禁用小段输入时间，防止bug
    
    
    local nextGuideId = self:GetNextGuide(doingGuide.cfg.id);
    local cfgGuideNext = nextGuideId and Cfgs.Guide:GetByID(nextGuideId);

    
    if(cfgGuideNext)then        
        
        if(doingGuide.cfg.record)then--记录该引导完成
            self:Record(doingGuide.cfg.group);
        end

        --EventMgr.Dispatch(EventType.Guide_Step_Complete);  
        self.doingGuide = nil;

        local line = cfgGuideNext.line or 0;     
        if(not self.currGuides[line])then   
            LogError("miss guide data:line=" .. tostring(line));
        end   
        self.currGuides[line].cfg = cfgGuideNext;    
        
        if(not self:CheckGuide())then
            EventMgr.Dispatch(EventType.Guide_HangUp);   
            --EventMgr.Dispatch(EventType.Input_Event_State,false,true);	
        end
    else       
        self:GuideComplete(); 
    end
end

--跳到指定步骤
function this:SkipTo(guideId,donSave)
    local cfgs = Cfgs.Guide:GetAll();

    local guideData = {};
    for _,cfg in pairs(cfgs) do
        if(guideId > cfg.id)then
            if(cfg.group)then
                guideData[self:GetKey(cfg.group)] = 1;
            end
        end
    end
    if(not donSave)then
        --PlayerProto:SetClientData(self:GetGuideKey(), guideData);
        self:SaveGuideData(guideData);
    end
    self:SetData(guideData);
end

function this:SkipAll()
    local cfgs = Cfgs.Guide:GetAll();

    local guideData = {};
    for _,cfg in pairs(cfgs) do
        if(cfg.group)then
            guideData[self:GetKey(cfg.group)] = 1;
        end
    end
    
    self.guideData = guideData;
    --PlayerProto:SetClientData(GuideMgr:GetGuideKey(), guideData);
    self:GuideComplete();

    self:SaveGuideData(self.guideData);
end

function this:GuideComplete()
--    LogError("引导完成========================");
--    LogError(self.doingGuide);
    this.IsGuideEnd=false;
    local doingGuide = self.doingGuide;    
    if(not doingGuide)then
        return;
    end
  
    self.doingGuide = nil;
    
    EventMgr.Dispatch(EventType.Guide_Complete,doingGuide.cfg.id);   
    EventMgr.Dispatch(EventType.Input_Event_State,false,true);	
    self:Record(doingGuide.cfg.group);

    self:InitCurrGuide();

    self:CheckGuide();    
end

--跳过引导
function this.OnGuideSkip()   
    this:GuideSkip();
end
function this:GuideSkip()   
    self:GuideComplete();
end
--跳过引导line
function this.OnGuideSkipLine()   
    this:GuideSkipLine();
end
function this:GuideSkipLine()   
    local doingGuide = self.doingGuide;
    if(not doingGuide or not doingGuide.cfg)then
        return;
    end
    if CSAPI.IsADV() or CSAPI.IsDomestic() then
        local key=doingGuide["cfg"]["key"]
        if tostring(key)=="11310" then
            ---39.构建 跳过
            BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_RESTRUCTURE_SKIP)
        elseif tostring(key)=="6010" then
            ---28.出击跳过
            BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_SORTIE_SKIP)
        elseif tostring(key)=="11020" then
            ---35.常规任务
            BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_TASK_SKIP)
        elseif tostring(key)=="5010" then
            ---25.编队跳过
            BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_FORMATION_SKIP)
        elseif tostring(key)=="11320" then
            ---22.点击“确认”跳过构建引导
            BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_STRUCTURE_SKIP)
        else
            --LogError("------跳过：-----"..key)
        end
    end

    local cfgs = Cfgs.Guide:GetAll();
    --LogError(doingGuide.cfg.line);
    local guideData = self.guideData;
    for _,cfg in pairs(cfgs) do
        if(cfg.line == doingGuide.cfg.line)then          
            self:Record(cfg.group);
        end
    end
    
    self.guideData = guideData;
    self:GuideComplete();
end

function this:GetCurrSceneName()
    local cfgScene = SceneMgr:GetCurrScene();
    if(cfgScene)then
        local sceneName = cfgScene.type ~= 2 and cfgScene.key or "Fight";
        return sceneName;
    end
end



return this;