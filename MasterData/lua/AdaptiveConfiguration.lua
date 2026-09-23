--UI自适应数据配置 词典
AdaptiveConfiguration={}
local this=AdaptiveConfiguration;
local Screen=UnityEngine.Screen;
local orientation=nil;
---AdaptiveConfiguration.SetLuaUIFit("FightTimeLineView",gameObject); --节点添加
---AdaptiveConfiguration.RemoveLuaUIFit("FightTimeLineView");  ---移除事件
---指定机型 代码获取不了的
this.SpecifiedModel=
{
    {id="huawei lio-an00", topOffset=90, bottomOffset=0,},
    {id="iphone12,5", topOffset=132, bottomOffset=0,},
    {id="google pixel 8", topOffset=85, bottomOffset=60,},

}


function this.OnInit()
    --print("初始化屏幕状态："..tostring(Screen.orientation));
    CS.UIFit.ins:RegisterListening()
    --CS.UIFit.ins:SetIsLock(false);
    CSAPI.AddEventListener(EventType.LuaView_Lua_Closed,this.LuaView_Lua_Closed)
    orientation=Screen.orientation;
    this.SetSpecifiedModel()
end

function this.LuaView_Lua_Closed(param)
     print("------------------------------"..param)
    if param~=nil then
        if this.IsitinAdaptiveMode(param) then
            this.RemoveLuaUIFit(param)
        end
    end
end
---监听执行数据
function this.MonitorExecutiondata()
    if orientation~=Screen.orientation then
        --print("屏幕发生变化："..tostring(Screen.orientation))
        orientation=Screen.orientation;
        this.ScreenRotationOccurs()
        EventMgr.Dispatch(EventType.Screen_Rotation_Occurs,Screen.orientation)
    end
end
----指传入 主页面节点 需要自己查找节点
function this.SetLuaObjUIFit(UIkey,ObjItem)
    if ObjItem~=nil then
        if ObjItem.transform:Find("AdaptiveScreen")~=nil then
            local AdaptiveScreen=ObjItem.transform:Find("AdaptiveScreen").gameObject
            if AdaptiveScreen~=nil then
                ---print("存在指定节点-------AdaptiveScreen-----："..UIkey)
                this.SetLuaUIFit(UIkey,AdaptiveScreen)
            end
        end
    end
end
---自适应UI集合
this.AdaptiveSet={};
--自适应
function this.SetLuaUIFit(UIkey,Item)
    CSAPI.SetUIFit(Item)
    local tableItem=
    {
        key=UIkey,
        value=Item.gameObject,
    };
    ---执行规避重复传入key
    this.RepeatUIkey(UIkey,tableItem)
    ---print("打印："..table.tostring(this.AdaptiveSet))
end

function this.GetOrientation()
    return orientation;
end

---如果key 重复， 那么使用最后最新的
function this.RepeatUIkey(UIkey,Item)
    if this.IsitinAdaptiveMode(UIkey) then
        print("AdaptiveConfiguration Repeat  ---key:"..UIkey)
        for i, v in pairs(this.AdaptiveSet) do
            ---有这个key
            if tostring(this.AdaptiveSet[i].key)==tostring(UIkey) then
                this.AdaptiveSet[i].value=Item.value;
                return;
            end
        end
    else
        table.insert(this.AdaptiveSet,Item);
    end
end


---屏幕发生旋转调用  IsCheckUp：true 旋转时候进行扭转UI自适应， false 检查是否存在空数据剔除  原因是框架没有统一的 关闭位置
function this.ScreenRotationOccurs()
    if #this.AdaptiveSet>0 then
        for i, v in pairs(this.AdaptiveSet) do
            CSAPI.SetUIFit(this.AdaptiveSet[i].value.gameObject)
        end
    end
end

function this.RemoveLuaUIFit(UIkey)
    ---print("RemoveLuaUIFit: "..table.tostring(this.AdaptiveSet))
    if #this.AdaptiveSet>0 then
        local index=0;
        for i, v in pairs(this.AdaptiveSet) do
            index=index+1
            ---print("  输出："..this.AdaptiveSet[i].key)
            if tostring( this.AdaptiveSet[i].key)==tostring(UIkey) then
                -- print("移除key："..UIkey);
                if #this.AdaptiveSet>=index then
                    table.remove(this.AdaptiveSet,index);
                else

                    LogError("  出现越界情况："..UIkey.."index:"..index)
                    LogError(this.AdaptiveSet)
                    this.AdaptiveSet={}
                end
                -- print("打印："..table.tostring(this.AdaptiveSet))
                return;
            end
        end
    end
end

---是否处于自适应中 当前需要引导的页面
function this.IsitinAdaptiveMode(UIkey)
    if #this.AdaptiveSet>0 then
        for i, v in pairs(this.AdaptiveSet) do
            ---有这个key
            if tostring(this.AdaptiveSet[i].key)==tostring(UIkey) then
                return true;
            end
        end
    end
    return false;
end
--- 初始化 设置指定机型
function this.SetSpecifiedModel()
    local count=#this.SpecifiedModel
    if count>0 then
        for i, v in pairs(this.SpecifiedModel) do
            this.AddUIAdaptive(this.SpecifiedModel[i].id,this.SpecifiedModel[i].topOffset,this.SpecifiedModel[i].bottomOffset)
        end
    end
end
function this.AddUIAdaptive(DevName,topOffset,bottomOffset)
    -- print("DevName:"..DevName.." topOffset:"..topOffset.."bottomOffset:"..bottomOffset)
    CSAPI.AddUIAdaptive(DevName,topOffset,bottomOffset);
end
function this.RemoveAdaptive(DevName)
    CSAPI.RemoveAdaptive(DevName);
end






--
--this.UIAdaptiveDic=
--{
--    ["huawei lio-an00"]=
--    {
--        id="huawei lio-an00",
--        topOffset=40,
--        bottomOffset=0,
--        des="",
--    },
--    ["honor ann-an00"]=
--    {
--        id="honor ann-an00",
--        topOffset=40,
--        bottomOffset=0,
--        des="",
--    },
--    ["HUAWEI JKM-LX1"]=
--    {
--        id="HUAWEI JKM-LX1",
--        topOffset=58,
--        bottomOffset=0,
--        des="",
--    },
--    ["HUAWEI OXP-AN00"]=
--    {
--        id="HUAWEI OXP-AN00",
--        topOffset=58,
--        bottomOffset=0,
--        des="",
--    },
--    ["vivo v2073a"]=
--    {
--        id="vivo v2073a",
--        topOffset=50,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 4"]=
--    {
--        id="iPhone 4",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--
--    ["iPhone 4S"]=
--    {
--        id="iPhone 4S",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--
--    ["iPhone 5"]=
--    {
--        id="iPhone 5",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 5S"]=
--    {
--        id="iPhone 5S",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 5C"]=
--    {
--        id="iPhone 5C",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone SE"]=
--    {
--        id="iPhone SE",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 6"]=
--    {
--        id="vivo v2073a",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 6 Plus"]=
--    {
--        id="iPhone 6 Plus",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 6S"]=
--    {
--        id="iPhone 6S",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 6S Plus"]=
--    {
--        id="iPhone 6S Plus",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 7"]=
--    {
--        id="iPhone 7",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 8"]=
--    {
--        id="iPhone 8",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 8 Plus"]=
--    {
--        id="iPhone 8 Plus",
--        topOffset=49,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone X"]=
--    {
--        id="iPhone X",
--        topOffset=83,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone XS"]=
--    {
--        id="iPhone XS",
--        topOffset=83,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone XS Max"]=
--    {
--        id="iPhone XS Max",
--        topOffset=83,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone XR"]=
--    {
--        id="iPhone XR",
--        topOffset=83,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone 11"]=
--    {
--        id="iPhone 11",
--        topOffset=83,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone 11 Pro"]=
--    {
--        id="iPhone 11 Pro",
--        topOffset=83,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone 11 Pro Max"]=
--    {
--        id="iPhone 11 Pro Max",
--        topOffset=83,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone 12 mini"]=
--    {
--        id="iPhone 12 mini",
--        topOffset=44,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone 12"]=
--    {
--        id="iPhone 12",
--        topOffset=47,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone 12 Pro"]=
--    {
--        id="iPhone 12 Pro",
--        topOffset=47,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone 12 Pro Max"]=
--    {
--        id="iPhone 12 Pro Max",
--        topOffset=47,
--        bottomOffset=34,
--        des="",
--    },
--    ["iPhone 13 Pro"]=
--    {
--        id="iPhone 13 Pro",
--        topOffset=47,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 13 mini"]=
--    {
--        id="iPhone 13 mini",
--        topOffset=47,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 13 Pro Max"]=
--    {
--        id="iPhone 13 Pro Max",
--        topOffset=47,
--        bottomOffset=0,
--        des="",
--    },
--    ["iPhone 14"]=
--    {
--        id="iPhone 14",
--        topOffset=50,
--        bottomOffset=20,
--        des="",
--    },
--    ["iPhone 14 Pro"]=
--    {
--        id="iPhone 14 Pro",
--        topOffset=50,
--        bottomOffset=20,
--        des="",
--    },
--    ["iPhone 14 plus"]=
--    {
--        id="iPhone 14 plus",
--        topOffset=50,
--        bottomOffset=20,
--        des="",
--    },
--    ["iPhone 14 Pro Max"]=
--    {
--        id="iPhone 14 Pro Max",
--        topOffset=50,
--        bottomOffset=20,
--        des="",
--    },
--
--}

--function this.AddUIAdaptive(id,topOffset,bottomOffset)
--     local IsKey=false;
--    for i, v in pairs(this.UIAdaptiveDic) do
--        print("key:"+i.." "..table.tostring(v));
--        if i==id then
--            IsKey=true;
--            break;
--        end
--    end
--    if IsKey==false then
--        local tableItem=
--        {
--            id=id,
--            topOffset=topOffset,
--            bottomOffset=bottomOffset,
--            des="",
--        }
--        table.insert(this.UIAdaptiveDic,id,tableItem);
--        print(" 添加数据成功 "..table.tostring(this.UIAdaptiveDic))
--    else
--        this.UIAdaptiveDic[id].topOffset=topOffset;
--        this.UIAdaptiveDic[id].bottomOffset=bottomOffset;
--        print("刷新数据："..table.tostring(this.UIAdaptiveDic[id]));
--    end
--end
--
--function this.RemoveAdaptive(id,topOffset,bottomOffset)
--    local IsKey=false;
--     local Removeindex=0;
--    for i, v in pairs(this.UIAdaptiveDic) do
--        ---print("key:"+i.." "..table.tostring(v));
--        Removeindex=Removeindex+1;
--        if i==id then
--            IsKey=true;
--            break;
--        end
--    end
--    if IsKey then
--        print("移除数据ID："..id)
--        table.remove(this.UIAdaptiveDic,Removeindex);
--        print(" 添加数据成功 "..table.tostring(this.UIAdaptiveDic))
--    end
--end