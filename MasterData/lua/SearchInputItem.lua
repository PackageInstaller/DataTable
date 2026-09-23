--搜索输入框
local options={};
local opDatas=nil;
local drop=nil;
local data=nil;
local dropVal=nil;
local isChoosie=true;
local inp=nil;
local selectItem=nil;
local isShowDown=false;

function Awake()
    --设置mask大小
    local arr = CSAPI.GetMainCanvasSize()
    CSAPI.SetRectSize(mask,arr[0],arr[1]);
    local x,y=CSAPI.GetAnchor(gameObject.transform.parent.gameObject);
    CSAPI.SetAnchor(mask,-x,-y);
    inp=ComUtil.GetCom(input,"InputField");
    CSAPI.AddInputFieldChange(input,OnInputChange)
    CSAPI.AddInputFieldCallBack(input,OnInputEnd);
end

function OnDestroy()
	CSAPI.RemoveInputFieldCallBack(input,OnInputEnd);
	CSAPI.RemoveInputFieldChange(input,OnInputChange);
end

--_d:func:OnInputChange
function Init(_d)
    data=_d;
    opDatas=nil;
    inp.text="";
    CSAPI.SetAngle(btnDown,0,0,0);
    CSAPI.SetGOActive(downListObj,false);
end

function OnInputChange(txt)
    if data==nil then
        do return end
    end
    data.func(this,txt)
end

function OnInputEnd(txt)
    if data==nil then
        do return end
    end
    data.func(this,txt)
end

--显示列表
function SetDownList(list)
    local currNum=0
    if list~=nil then
        currNum=#list;
        opDatas=list;
        options=ItemUtil.AddItems("ShopComm/SearchInputListItem",options,opDatas,Content,OnDropChange,1,dropVal);
    end
    isShowDown=currNum>0;
    SetDownBtnState(isShowDown);
    --计算显示范围
    local num=4;
    local height=currNum>num and num*60+(num-1)*2 or currNum*60+(currNum-1)*2
    local size=CSAPI.GetRTSize(downListView);
    CSAPI.SetRTSize(downListView,size[0],height);
end

function OnClickDown()
    isShowDown = not isShowDown;
    if isShowDown and opDatas~=nil then
        SetDownList(opDatas)
    else
        SetDownBtnState(isShowDown);         
    end
end

function SetDownBtnState(isShow)
    CSAPI.SetGOActive(downListObj,isShow);
    CSAPI.SetGOActive(mask,isShow);
    if isShow then
        CSAPI.SetAngle(btnDown,0,0,180);
    else
        CSAPI.SetAngle(btnDown,0,0,0);
    end
end

function OnClickAnyway()
    isShowDown=false;
    SetDownBtnState(false);
end

function OnDropChange(lua)
    if lua and lua.GetIndex()~=dropVal then
        if dropVal~=nil then
            options[dropVal].SetSelect(false);
        end
        lua.SetSelect(true);
        dropVal=lua.GetIndex();
    end
    if not IsNil(inp) and dropVal~=nil and options[dropVal] then
        inp.text=options[dropVal].data.txt;
    end
    SetDownList(nil)
end

function GetSelectedInfo()
    if dropVal~=nil and options[dropVal] then
        return options[dropVal].data;
    end
end