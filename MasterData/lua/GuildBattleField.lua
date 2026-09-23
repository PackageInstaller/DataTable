--战场列表
local fieldType=1;--战场列表类型
local roomType=1;--房间筛选类型
local layout=nil;
local gfData=nil;
function Awake()
    layout = ComUtil.GetCom(sv, "UICircularScrollView")
    layout:Init(LayoutCallBack)
    CSAPI.AddDropdownCallBack(btnType,OnTypeChange);
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Guild_Rooms_Update,OnRoomsUpdate)
end

function OnDestroy()
    CSAPI.RemoveDropdownCallBack(btnType,OnTypeChange);
    eventMgr:ClearListener();
    ReleaseCSComRefs();
end

function OnOpen()
    fieldType=openSetting;
    Refresh()
end

function GetData(_fieldType)
    local list={};
    gfData=GuildFightMgr:GetCurrGFData()
    if gfData==nil then
        return list;
    end
    if _fieldType==1 then
        list=gfData:GetRoomList();
    elseif _fieldType==2 then
        list=GuildFightMgr:GetGFRooms();
    end
    return list
end

function OnRoomsUpdate(eventData)
    if eventData.isCreate then
        if fieldType~=2 then
            fieldType=2;
        end
    end
    Refresh();
end

function Refresh()
    SetBtnState(fieldType);
    curDatas=GetData(fieldType);
    layout:IEShowList(#curDatas)
    local supportNum=0;
    local list=GetData(2);
    supportNum=#list;
    CSAPI.SetText(txt_supportFieldNum,tostring(supportNum));
end

function LayoutCallBack(element)
    local index = tonumber(element.name) + 1
    local _data = curDatas[index]
    local isCreate=GuildFightMgr:IsCreateRoom(_data:GetCfg().index);
	ItemUtil.AddCircularItems(element, "GuildFight/GuildBattleFieldItem", _data, {fieldType=fieldType,isCreate=isCreate}, nil, 1)
end

function SetBtnState(type)
    CSAPI.SetGOActive(openFieldSB,type==1);
    CSAPI.SetGOActive(supportFieldSB,type~=1);
end

function OnClickField(go)
    if go==btnSupportField then
        fieldType=2;
    else
        fieldType=1;
    end
    -- SetBtnState(fieldType);
    Refresh();
end

function OnTypeChange(value)
    Log(value);
end

function OnClickAnyway()
    view:Close();
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
btnOpenField=nil;
openFieldSB=nil;
btnSupportField=nil;
supportFieldSB=nil;
redPoint=nil;
txt_supportFieldNum=nil;
btnType=nil;
sv=nil;
view=nil;
end
----#End#----