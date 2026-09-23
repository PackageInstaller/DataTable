
local stepLen = 100;

function Awake()
    OnClickEnd();
end

function GetDatas()
    return (fightData and ProtocolRecordMgr:GetFightDatas()) or ProtocolRecordMgr:GetDatas();
end


function RefreshItems(index,len)
    local datas = GetDatas();
    if(not datas)then
        return;
    end
    
    ClearItems();
    index = index or 1;
    len = len or stepLen;

    local dataCount = #datas;
    local maxIndex = math.floor((dataCount - 1) / len) * len + 1;

    index = math.min(maxIndex,index);
    index = math.max(1,index);
    
    currIndex = index;   
    
    CSAPI.SetText(indexText,index .. "-" .. (index + len - 1) .. " / " .. dataCount);

    for i = index,index + len do
        local data = datas[i]
        if(not data)then
            return;
        end

        local go = ResUtil:CreateUIGO("ProtoRecord/ProtoRecordItem",itemNode.transform);
        local item = ComUtil.GetLuaTable(go);
        item.Set(data);
        item.SetClickCallBack(OnClickItem);

        items = items or {};
        table.insert(items,item);
    end
end

function OnClickItem(data)
    local str = table.tostring(data,true);
    CSAPI.SetText(Content,str);
end

function ClearItems()
    if(items)then
        for _,item in ipairs(items)do
            CSAPI.RemoveGO(item.gameObject);
        end
    end
end



function OnClickHome()
    RefreshItems();
end

function OnClickUp()
    currIndex = currIndex or 1;
    RefreshItems(currIndex - stepLen);
end
function OnClickDown()
    currIndex = currIndex or 1;
    RefreshItems(currIndex + stepLen);
end

function OnClickEnd()
    RefreshItems(9999999);
end

function OnClickProto()
    fightData = nil;
    OnClickEnd();
end

function OnClickFight()
    fightData = 1;
    OnClickEnd();
end

function OnClickClose()	
	view:Close();
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
Content=nil;
itemNode=nil;
indexText=nil;
view=nil;
end
----#End#----