-- 随机事件老虎机
local eventMgr = nil;
local index = 0;
local events = {};
local animator = nil;
local choosieIndex=0;
local func=nil;
function Awake()
    animator = ComUtil.GetComInChildren(gameObject, "Animator");
end

function OnOpen()
    if data~=nil then
        Refresh(data.gridInfo)
        func=data.func;
    end
end

function Refresh(gridInfo)
    events = {};
    choosieIndex=0;
    local curData = RichManMgr:GetCurData();
    local curEvents = curData:GetEventList();
    if gridInfo ~= nil then
        for k, v in ipairs(gridInfo:GetValue1()) do
            local event = RichManGridEvent.New();
            event:InitCfg(v);
            table.insert(events, event);
            if curEvents ~= nil and choosieIndex==0 then
                for _, val in ipairs(curEvents) do
                    if val:GetID() == v then
                        choosieIndex=k;
                        break;
                    end
                end
            end
        end
    end
    -- 添加事件
    NextStage();
    FuncUtil:Call(PlayRand, nil, 160)
end

function PlayRand()
    if not IsNil(view) and animator ~= nil then
        animator:Play("Gacha_anim", -1, 0);
        CSAPI.PlaySound("temp/temp.acb","Monopoly_Effects_03");
        FuncUtil:Call(NextStage, nil, 208)
        FuncUtil:Call(NextStage, nil, 416)
        FuncUtil:Call(PlayOver, nil, 816)
        FuncUtil:Call(OnClick, nil, 2000)
    end
end

function NextStage()
    if not IsNil(view) and not IsNil(gameObject) then
        for i = 1, 3 do
            index = index + 1 > #events and 1 or index + 1;
            CSAPI.SetText(this["Text" .. i], events[index]:GetDesc());
        end
    end
end

function PlayOver()
    index = choosieIndex-1;
    if not IsNil(view) and not IsNil(gameObject) then
        for i = 1, 3 do
            index = index + 1 > #events and 1 or index + 1;
            CSAPI.SetText(this["Text" .. i], events[index]:GetDesc());
        end
    end
end

function OnClick()
    if not IsNil(view) and not IsNil(gameObject) then
        if func~=nil then
            func();
            func=nil;
        end
        view:Close();
    end
end
