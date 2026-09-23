--技能设置项

function SetData(itemData)
    data = itemData;
    if(not luaItem)then
        local itemGO = ResUtil:CreateUIGO("Skill/SkillItem", node.transform);    
        luaItem = ComUtil.GetLuaTable(itemGO); 
    end
    luaItem.InitItem(data.cfg);
end

function GetData()
    return data;
end

function OnClick()
    data.clickCallBack(this);
end

function SetSelectState(state)
    selectState = state;
    CSAPI.SetGOActive(select,state);
end

function GetSelectState()
    return selectState;
end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
node=nil;
btn=nil;
iconbg=nil;
txtLock=nil;
icon=nil;
passive=nil;
iconRange=nil;
goSelect=nil;
cost=nil;
costbg=nil;
goCostText=nil;
goCostText1=nil;
goNoCost=nil;
prohibit=nil;
mask=nil;
cd=nil;
select=nil;
view=nil;
end
----#End#----