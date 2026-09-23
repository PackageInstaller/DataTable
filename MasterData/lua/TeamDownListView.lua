--出战界面下拉面板
local maxCount=6; --最多显示个数
local currCount=0;--当前显示数量
local height=74;--子物体高度
local width=418; --子物体宽度
local topOffset=55;
local bottomOffset=45;
local onValueChange=nil;
local items=nil;

--pos:起始位置,options: icon=显示的图标,desc=描述文字,isSelect=是否选择,index=下标,id=队伍id
function Show(pos,options,itemID)
    if gameObject.activeSelf==false then
        CSAPI.SetGOActive(gameObject,true);
    end
    if pos==nil then
        pos={0,0};
    end
    currItemID=itemID;
    CSAPI.SetLocalPos(downListView,pos.x,pos.y,0);
    -- CSAPI.SetAnchor(downListView,pos.x,pos.y,0);
    if options then
        items=items or {}
        currCount=#options;
        for k,v in ipairs(options) do
            local lua=nil;
            if k>#items then
                local go=ResUtil:CreateUIGO("TeamConfirm/TeamDownListItem",downListContent.transform);
                lua=ComUtil.GetLuaTable(go);
                table.insert(items,lua);
            else
                CSAPI.SetGOActive(items[k].gameObject,true);
                lua=items[k];
            end
            lua.Init(v);
            -- lua.SetLine(k<#options);
            lua.SetClickFunc(OnValueChange);
        end
        if currCount<#items then
            for i=currCount+1,#items do
                CSAPI.SetGOActive(items[i].gameObject,false);
            end
        end
    end
    ResetSize();
end

--添加值变化监听
function AddOnValueChange(_onValueChange)
    onValueChange=_onValueChange;
end

function AddOnClose(_onClose)
    onClose=_onClose;
end

--值变化处理
function OnValueChange(item)
    -- if item.data.itemID~=nil then --已经被选中的不做处理
    --     Hide();
    --     return;
    -- end
    local options=GetChoosieOptions(item);
    for _,item in ipairs(items) do
        item.SetSelect(item.data.itemID~=nil);
    end
    if onValueChange then
        onValueChange(options);
        -- onValueChange(item.data);
    end
    Hide();
end

--重置面板大小
function ResetSize()
    local size=GetSize();
    CSAPI.SetRectSize(downListView,size[1],size[2]);
end

function GetSize()
    local num=0;
    if currCount>=maxCount then
        num=maxCount;
    else
        num=currCount;
    end
    return {width,num*height+topOffset+bottomOffset}
end

function OnClickAnyway()
    Hide();
end

function Hide()
    if onClose then
        onClose();
    end
    CSAPI.SetGOActive(gameObject,false);
end

--返回选中的子物体信息
function GetChoosieOptions(item)
    local options={};
    options[currItemID]=item.data
    local oldItemID=item.data.itemID;
    if currCount>0 then
        for i=1,currCount do
            local isSelect=false;
            local tempItem=items[i];
            if tempItem==item then
                if item.data.itemID~=currItemID then --判断当前物体的itemID是否与currItemID一致（itemID用来区分选择主队还是二队）
                    if item.data.itemID~=nil then--如果当前选中的物体的itemID不为空，则查找currItemID是否有选中的数据，有的话则互换
                        local tData=nil;
                        for j=1,currCount do
                            local temp2=items[j];
                            if temp2.data.itemID~=nil and temp2.data.itemID==currItemID then
                                tData=temp2.data;
                                break
                            end
                        end
                        if tData then
                            tData.itemID=item.data.itemID;
                            options[item.data.itemID]=tData;
                        else
                            options[item.data.itemID]={itemID=item.data.itemID,id=-1};
                        end
                    end
                    item.data.itemID=currItemID;
                end
            elseif tempItem.data.itemID~=nil and tempItem.data.itemID==currItemID and oldItemID==nil then
                tempItem.data.itemID=nil;   
            end
        end
    end
    return options;
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
downListView=nil;
downListContent=nil;
view=nil;
end
----#End#----