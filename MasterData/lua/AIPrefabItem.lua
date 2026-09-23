local data=nil;
local skillGrid=nil;
local maxOrder=0;
local conCfgs=nil;
local targetCfgs=nil;
local conCanvas=nil;
local targetCanvas=nil;
local conImg=nil;
local targetImg=nil;
local showOrder=0;--显示用的值
function Awake()
    conCanvas=ComUtil.GetCom(btn_con,"CanvasGroup");
    targetCanvas=ComUtil.GetCom(btn_target,"CanvasGroup");
    conImg=ComUtil.GetCom(btn_con,"Image");
    targetImg=ComUtil.GetCom(btn_target,"Image");
end

--data:CardSkillPreset类
function Refresh(_data,_maxOrder,_skillCfg)
    data=_data;
    -- Log(data);
    maxOrder=_maxOrder;
    local realSkillID=_skillCfg==nil and data:GetSkillCfg().id or _skillCfg.id;
    if data then
        if skillGrid==nil then
            ResUtil:CreateUIGOAsync("Role/RoleInfoSkillItem1",gridNode,function(go)
                skillGrid=ComUtil.GetLuaTable(go);
                skillGrid.Refresh(realSkillID);
                skillGrid.SetClickCB(OnClickGrid)
            end);
        else
            skillGrid.Refresh(realSkillID);
            skillGrid.SetClickCB(OnClickGrid)
        end
        local d=data:GetData();
        local conCfg=data:GetCurrSkillStrategyCfg();
        local tCfg=data:GetCurrAIStrategyCfg();
        conCfgs=data:GetSkillStrategyCfgs();
        targetCfgs=data:GetAIStrategyCfgs();
        showOrder=math.abs(d[1]-maxOrder)+1;
        SetSort(tostring(showOrder));
        if conCfg then
            SetCon(conCfg.description);
        else
            LogError("获取AI配置失败!配置表：cfgSkillStrategyItem");
            LogError(d)
        end
        if tCfg then
            SetTarget(tCfg.description);
        else
            LogError("获取AI配置失败!配置表：cfgAutoFight 表ID:"..tostring(data.cid).."\t数据："..table.tostring(d));
        end
        local num=conCfgs==nil and 0 or #conCfgs;
        SetEnable(conImg,conCanvas,num>1)
        local num2=targetCfgs==nil and 0 or #targetCfgs;
        SetEnable(targetImg,targetCanvas,num2>1)
    end
end

function OnClickGrid()
    if data then
        local cfg=data:GetSkillCfg();
        EventMgr.Dispatch(EventType.AIPreset_ShowSkill,cfg)
    end
end

function SetEnable(img,canvas,enable)
    img.raycastTarget=enable;
    canvas.alpha=enable==true and 1 or 0.5;
end

function SetSort(str)
    CSAPI.SetText(txt_sort,str);
end

function SetCon(str)
    if str then
        str=StringUtil:SetStringByLen(str, 6)
    end
    CSAPI.SetText(txt_con,str);
end

function SetTarget(str)
    if str then
        str=StringUtil:SetStringByLen(str, 9)
    end
    CSAPI.SetText(txt_target,str);
end

function OnClickSort()
    if data then
        local d=data:GetData();
        CSAPI.OpenView("AIConditionView",{max=maxOrder,select=showOrder,id=data:GetCfgID()},AIConditionOpenType.Sort)
    end
end

function OnClickCon()
    if data then
        local d=data:GetData();
        CSAPI.OpenView("AIConditionView",{list=data:GetSkillStrategyCfgs(),select=d[2],id=data:GetCfgID()},AIConditionOpenType.Condition)
    end
end

function OnClickTarget()
    if data then
        local d=data:GetData();
        CSAPI.OpenView("AIConditionView",{list=data:GetAIStrategyCfgs(),select=d[3],id=data:GetCfgID()},AIConditionOpenType.Target)
    end
end
