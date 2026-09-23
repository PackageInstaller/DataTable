---当前选择哪个年龄阶段 默认选择18岁以上   1=没满16岁  2=16-17岁   3=18岁或者以上
local  JPSelectAge="JPSelectAge";

---是否勾选了满足十八岁以上不显示
local  JPCheckNotdisplaySelectAge="JPCheckNotdisplaySelectAge";

---选择年龄页面是否显示(当前只存在设置，打开该页面时候，获取查询)
local JPChooseAgeNotdisplay="JPChooseAgeNotdisplay";

---记录 togglle 开启还是关闭状态  返回 0 关闭状态 返回 1开启状态
local JPIsChoiceToggle="IsChoiceToggle";

---默认类型为3
local AgeType=3;
---0等于 false 其它 (1)等于 true
local IsChoiceToggle=0;

---Toggle  组件
local Lua_Under16yearsold=nil;
local Lua_SixteenToseventeenYearsold=nil
local Lua_Eighteenyearsoldandabove=nil
local Lua_ChoiceToggle=nil;
---回调事件
local  CallBackMain=nil;
--日服选择确认年龄界面
function Awake()
    OnInitUI();
end
function OnOpen()
    --LogError(table.tostring(data))
    --data.ExitMain();
    CallBackMain=data;
end
function Start()
    SetDefToggle()
    ---未满16岁
    Lua_Under16yearsold.onValueChanged:AddListener(OnClickeUnder16yearsold);
    ---16-17岁
    Lua_SixteenToseventeenYearsold.onValueChanged:AddListener(OnClickeSixteenToseventeenYearsoldToggle);
    ---18岁以上
    Lua_Eighteenyearsoldandabove.onValueChanged:AddListener(OnClickeEighteenyearsoldandaboveToggle);
    ---勾选下次是否显示
    Lua_ChoiceToggle.onValueChanged:AddListener(OnClickeLua_ChoiceToggle);
end
---初始化数据
function OnInitUI()
    AddRegistration();
end

---添加注册
function AddRegistration()
    Lua_Under16yearsold=Under16yearsold:GetComponent("Toggle");
    Lua_SixteenToseventeenYearsold=SixteenToseventeenYearsold:GetComponent("Toggle");
    Lua_Eighteenyearsoldandabove=Eighteenyearsoldandabove:GetComponent("Toggle");
    Lua_ChoiceToggle=ChoiceToggle:GetComponent("Toggle");
end
---移除注册
function RemoveRegistration()
    Lua_Under16yearsold.onValueChanged:RemoveListener(OnClickeUnder16yearsold);
    Lua_SixteenToseventeenYearsold.onValueChanged:RemoveListener(OnClickeSixteenToseventeenYearsoldToggle);
    Lua_Eighteenyearsoldandabove.onValueChanged:RemoveListener(OnClickeEighteenyearsoldandaboveToggle);
    Lua_ChoiceToggle.onValueChanged:RemoveListener(OnClickeLua_ChoiceToggle);
end

function SetDefToggle()
    local  SelectAge=PlayerPrefs.GetInt(CSAPI.GetSetkey(JPSelectAge));
    if SelectAge~=nil  then
        if SelectAge==0 then SelectAge=3; end
        AgeType=SelectAge;
        Log("AgeType:  "..AgeType)
    end
    local  CheckNotdisplaySelectAge=PlayerPrefs.GetInt(CSAPI.GetSetkey(JPIsChoiceToggle));
    if CheckNotdisplaySelectAge~=nil  then
        IsChoiceToggle=CheckNotdisplaySelectAge;
        Log("IsChoiceToggle----:  "..IsChoiceToggle)
    end

    ---当前选择哪个年龄阶段 默认选择18岁以上   1=没满16岁  2=16-17岁   3=18岁或者以上
    if AgeType==1 then
        Lua_Under16yearsold.isOn=true;
    elseif AgeType==2 then
        Lua_SixteenToseventeenYearsold.isOn=true;
    elseif AgeType==3 then
        Lua_Eighteenyearsoldandabove.isOn=true;
    else
        Lua_Eighteenyearsoldandabove.isOn=true;
        AgeType=3;
    end

    if IsChoiceToggle==0 then
        Lua_ChoiceToggle.isOn=false;
    else
        Lua_ChoiceToggle.isOn=true;
    end
end
function OnClickeLua_ChoiceToggle(Ison)
    --- Log("OnClickeLua_ChoiceToggle--Ison"..tostring(Ison))
    if Ison then
        IsChoiceToggle=1;
        PlayerPrefs.SetInt(CSAPI.GetSetkey(JPIsChoiceToggle),1);

    else
        IsChoiceToggle=0;
        PlayerPrefs.SetInt(CSAPI.GetSetkey(JPIsChoiceToggle),0);
    end
end
function OnClickeUnder16yearsold(Ison)
    ---Log("OnClickeLua_Under16yearsold--Ison"..tostring(Ison))
    if Ison then
        AgeType=1;
        PlayerPrefs.SetInt(CSAPI.GetSetkey(JPSelectAge),1);
    end
end
function OnClickeSixteenToseventeenYearsoldToggle(Ison)
    ---Log("OnClickeLua_SixteenToseventeenYearsoldToggle--Ison"..tostring(Ison))
    if Ison then
        AgeType=2;
        PlayerPrefs.SetInt(CSAPI.GetSetkey(JPSelectAge),2);
    end
end
function OnClickeEighteenyearsoldandaboveToggle(Ison)
    --- Log("OnClickeLua_EighteenyearsoldandaboveToggle--Ison"..tostring(Ison))
    if Ison then
        AgeType=3;
        PlayerPrefs.SetInt(CSAPI.GetSetkey(JPSelectAge),3);
    end

end
--function Update()
--
--end
---确认按钮
function OnClickOK()
    DataSettings()
    OnClickClose()
    if CallBackMain~=nil then
        ---回调传入函数
        CallBackMain.ExitMain();
    end
    --调用回调
end

---数据设置
function DataSettings()
    SetOKData();
    -- 设置刷新缓存配置
    if AgeType==3 and IsChoiceToggle==1 then
        Log("-------------------满足下次不打开页面年龄提醒----------------------")
        PlayerPrefs.SetInt(CSAPI.GetSetkey(JPChooseAgeNotdisplay),1);
    end
end



function SetOKData()
    if  Lua_ChoiceToggle.isOn==true then
        IsChoiceToggle=1;
        PlayerPrefs.SetInt(CSAPI.GetSetkey(JPCheckNotdisplaySelectAge),0);
    else
        IsChoiceToggle=0;
        PlayerPrefs.SetInt(CSAPI.GetSetkey(JPCheckNotdisplaySelectAge),1);
    end
    if Lua_Under16yearsold.isOn then
        AgeType=1;
        PlayerPrefs.SetInt(CSAPI.GetSetkey(JPSelectAge),1);
    elseif Lua_SixteenToseventeenYearsold.isOn then
        AgeType=2;
        PlayerPrefs.SetInt(CSAPI.GetSetkey(JPSelectAge),2);
    elseif Lua_Eighteenyearsoldandabove.isOn then
        AgeType=3;
        PlayerPrefs.SetInt(CSAPI.GetSetkey(JPSelectAge),3);
    end
end

---关闭页面按钮
function OnClickClose()
    DataSettings()
    view:Close()
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    OnClickClose();
end
function OnDestroy()
    RemoveRegistration()
end