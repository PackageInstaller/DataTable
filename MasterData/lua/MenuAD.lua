local nextTime = nil
local curIndex = 1

function Awake()
    layout = ComUtil.GetComInChildren(gameObject, "UIInfinite")
    layout:Init("UIs/Menu/MenuADItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
    curIndex = index
    local lua = layout:GetItemLua(index)
    if (lua) then
        lua.Refresh(datas[index])
    end
end

function InitEvent()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Main_Activity, function(type)
        if (type == BackstageFlushType.ActiveSkip) then
            EActivityCB()
        end
    end)
    eventMgr:AddListener(EventType.MenuTheme_Change, function ()
        layout:UpdateList()
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
    ReleaseCSComRefs()
end

function Start()
    EActivityCB()
    InitEvent()
end

function Update()
    if (nextTime and TimeUtil:GetTime() > nextTime) then
        nextTime = nil
        EActivityCB()
    end
end

-- (登录后请求)活动数据请求回调
function EActivityCB()
    local _datas, _nextTime = ActivityMgr:GetDatasByType(BackstageFlushType.ActiveSkip)
    datas = _datas or {}
    CSAPI.SetGOActive(gameObject, #datas > 0)
    if (#datas <= 0) then
        return
    end

    if (#datas <= 0) then
        nextTime = nil
    else
        if (_nextTime) then
            --nextTime = _nextTime > curTime and (_nextTime - curTime) or 0
            --nextTime = nextTime > 0 and Time.time + nextTime or nil
			nextTime = _nextTime > TimeUtil:GetTime() and _nextTime or nil
        else
            nextTime = nil
        end
    end
    if (#datas > 1) then
        if (datas and #datas > 1) then
            table.sort(datas, function(a, b)
                return tonumber(a:GetSortID()) > tonumber(b:GetSortID())
            end)
        end
    end
    CSAPI.ChangeGridCellSize(points, GetCellSizeX(#datas), 8)
    layout:IEShowList(#datas)
end

function GetCellSizeX(count)
    if (count <= 4) then
        return 84
    else
        return (360 - (count - 1) * 8) / count
    end
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    txtAD = nil;
    hpage = nil;
    points = nil;
    view = nil;
end
----#End#----
