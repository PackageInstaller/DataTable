local eventMgr=nil;
local currPetView=nil;

function Awake()
    eventMgr = ViewEvent.New();
end

function OnDestroy()
    eventMgr:ClearListener();
	ReleaseCSComRefs();
end

function Refresh(petInfo)
    if petInfo==nil then
        do return end;
    end
    local isEqual=false;
    if currPetView then
        local _d=currPetView.GetData();
        isEqual=_d:GetID()==petInfo:GetID();
        if isEqual~=true then
            --删除宠物
            currPetView.Close();
            currPetView=nil;
        else
            do return end;
        end
    end
    if isEqual or currPetView==nil then
        --创建宠物子物体
        local path=petInfo:GetPrefabPath();
        CSAPI.CreateGOAsync(path,0,0,0,gameObject,function(go)
            currPetView=ComUtil.GetLuaTable(go);
            currPetView.Init(petInfo);
        end);
    end
end

----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
    gameObject=nil;
    transform=nil;
    this=nil;  
    eventMgr=nil;
    currPetView=nil;
end