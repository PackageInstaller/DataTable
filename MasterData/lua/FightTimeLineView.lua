----总个数
--local itemCount = 7;
----展开显示个数
--local unfoldCount = 4;

local items;

local key_time_line_item_align = "time_line_item_align";

function OnInit()
    layoutAlign = PlayerPrefs.GetInt(key_time_line_item_align) or 0;
    --layoutAlign = 1;
    canvasGroup = ComUtil.GetCom(rootNode, "CanvasGroup");

    InitListener();
end

function InitListener()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Fight_Time_Line_Update,OnFightTimeLineUpdate);
    eventMgr:AddListener(EventType.Fight_View_Main_Info_Show_State, SetShowState);
    eventMgr:AddListener(EventType.Fight_Reset_TimeLineIndex, ResetItemIndex);    
    eventMgr:AddListener(EventType.Input_Select_Target_Character_Changed,OnInputSelectTargetCharacterChanged);
    eventMgr:AddListener(EventType.Fight_Time_Line_Refresh,RefreshItems);
    AdaptiveConfiguration.SetLuaObjUIFit("FightTimeLine",gameObject); --节点添加
end
function OnDestroy()
    eventMgr:ClearListener();
end

function OnInputSelectTargetCharacterChanged(characters)
    if(items)then
        for id,item in pairs(items)do
            local character = CharacterMgr:Get(id);
            local state = characters and characters[id];
            --LogError(tostring(id) .. ":" .. tostring(state));
            item.SetSelState(state and true or false);
        end
    end
end

--function ApplyMove(state)
--    --CSAPI.MoveTo(moveNode,"move_linear_local",state and 0 or -800,0,0);     
--end

function SetShowState(state)
    --CSAPI.SetAnchor(rootNode,state and 0 or 10000,0);
    
    if(currDatas and canvasGroup)then
        canvasGroup.alpha = state and 1 or 0;
        
    end
    CSAPI.SetGOActive(clickMask,not state);
end

function OnClickLayout()
    layoutAlign = layoutAlign == 1 and 0 or 1;
    PlayerPrefs.SetInt(key_time_line_item_align,layoutAlign);
    if(currDatas)then
        OnFightTimeLineUpdate(currDatas)
    end
end

function SetActionState(state)
    if(enterAction)then
        CSAPI.SetGOActive(enterAction,state);
    end
end


-- function FixDatas(datas)
--     if(not datas)then
--         return;
--     end
--     local arr = {};
--     for i,data in ipairs(datas)do
--         --第一个是行动者
--         if(i >= 2)then
--             if(not data.arrow)then
--                local index = 1;
--                for i,arrData in ipairs(arr)do                   
--                    if(data.progress > arrData.progress)then
--                        break;
--                    end       
--                    index = i + 1;            
--                end 
--                table.insert(arr,index,data);
--             end
--         end
--     end
--     table.insert(arr,1,datas[1]);
--     return arr;
-- end

function OnFightTimeLineUpdate(datas)
    

    local playAction = not currDatas;
    
    ClearItems();
    currCharacter = nil;    
    currDatas = datas;

    -- datas = FixDatas(datas);
    datas=FightClient:GetTimeLineDatas();
    local count = #datas;

     if(playAction)then
        SetShowState(true);
        SetActionState(true);
    end

    if(count < 2)then
        CSAPI.SetGOActive(nextNode,false);
    end

    local currPos = -1;
    local len = 380;--时间条总长度
    local maxLen = 450;
    local minSpace = 20;--最小间隔

    local layoutAlignMaxSpace = 85;--整齐布局头像最大隔格
    local layoutAlignSpace = (maxLen - 15) / math.max(1,count - 2);--  65;--整齐布局时间隔
    layoutAlignSpace = math.min(layoutAlignSpace,layoutAlignMaxSpace);
    local index = 0;
    
    for i = 1,count do   
        local data = datas[i];  

        if(not data.arrow)then
        
            local item = GetItem(data);

            local isFirstItem = i == 1;
            local isShow = i >= 1;
            --local isNext = i == 2;

            if(isShow)then  
                local t = (1000 - data.progress) * 0.001;
                local targetPos = len * t;
                --LogError("a targetPos:" .. targetPos);
                local targetSpace = currPos >= len and minSpace * 0.5 or minSpace;               
                local minPos = currPos >= 0 and (currPos + targetSpace) or 0;
                if(targetPos < minPos)then
                    targetPos = minPos;
                    --LogError("b targetPos:" .. targetPos);
                end

                if(layoutAlign ~= 1)then
                    targetPos = currPos >= 0 and (currPos + layoutAlignSpace) or 0;
                end

                currPos = math.min(targetPos,maxLen);    

                if(isFirstItem)then
                    currPos = -120;
                end           

                local layoutInfo = item.GetLayoutInfo();
                if(not layoutInfo)then
                    layoutInfo = {};
                end
                layoutInfo.index = index;
                layoutInfo.pos = currPos;
                layoutInfo.isFirst = isFirstItem;
                --LogError(i .. "、" .. tostring(item.currCharacter.GetModelName()) .. ":" .. tostring(currPos) .. "___" .. tostring(data.progress));
                item.SetLayoutInfo(layoutInfo);     
                
                if(playAction)then
                    item.ApplyLayoutComplete();

                    local space = 200 / count;
                    delay = (count - i + 1) * space;
                    --LogError("i:" .. i .. ",delay:" .. math.floor(delay));
                    item.PlayEnterAction(delay);
                end 
            end     

        end

        
    end
end

function ResetItemIndex(item)
    local index = GetIndex(item);   
    item.SetIndex(index);
end

function GetIndex(item)    
    if(not currDatas)then
        return 0;
    end
    local itemCharacterID = item and item.GetID();
    if(not itemCharacterID)then
        return 0;
    end
    -- local datas = FixDatas(currDatas);
    local datas=FightClient:GetTimeLineDatas();
    local count = #datas;
    for i = 1,count do
        local dataIndex = count - i + 1;
        local data =  datas[dataIndex];
        if(data.id == itemCharacterID)then          
            return i - 1;--数组第一个为当前行动角色，剔除。lua索引从1开始，转换到C#索引-1。
        end
    end
end

--获取目标角色的item
function GetItem(data)
    items = items or {};
    local id = data.id;
    local item = items[id];
    if(not item)then
        item = CreateItem(data);
        items[id] = item;
    end
    return item;
end

function ClearItems()
    if(items)then
        for id,item in pairs(items)do
            local character = CharacterMgr:Get(id);
            if(not character or character:IsDead())then
                item:Remove();
                items[id] = nil;
            end
        end
    end
end
----初始化Item
--function InitItems()
--    if(items ~= nil)then
--        return;
--    end

--    items = {};

--    local itemRoot = nodes.transform;
--    local count = itemCount;
--    for i = 1,count do  
--        local item = CreateItem();
----        if(i == 1)then
----            item.SetAsFirst();
----        end
--        --item.AddClickCallBack(OnClickItem);
--        table.insert(items,item);
--    end
--end

function OnClick()
    if(currCharacter)then
        local id = currCharacter.GetID();
        if(FightClient:GetInputCharacter())then
            if (not IsPvpSceneType(g_FightMgr.type) and g_FightMgr.type ~= SceneType.PVPMirror) or _G.showPvpRoleInfo==true then --非PVP界面可以打开查看数据
                CSAPI.OpenView("FightRoleInfo",id);
            end
        end
        EventMgr.Dispatch(EventType.Character_FightInfo_Log,id);               
    end
end

--function GetFirstItem()
--    if(not firstItem)then
--        local go = ResUtil:CreateUIGO("Fight/FightTimeLineItem",firstNode.transform);
--        firstItem = ComUtil.GetLuaTable(go);
--        firstItem.SetScale(1.4);
--    end
--    return firstItem;
--end

function RefreshItems()
    if(items)then
        for _,item in pairs(items)do
            item.Refresh();
        end        
    end
end

function CreateItem(data)
    local itemRoot = nodes.transform;        
    local go = ResUtil:CreateUIGO("Fight/FightTimeLineItem",itemRoot);
    local item = ComUtil.GetLuaTable(go);
    local character = CharacterMgr:Get(data.id);
    item.UpdateInfo(character)
    return item;
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
rootNode=nil;
nodes=nil;
nextNode=nil;
enterAction=nil;
view=nil;
end
----#End#----