-- 建筑列表
curIndex1, curIndex2 = 1, 1 -- 父index,子index
-- local curIndex = 0

function Awake()
    -- SetTab()
    layout = ComUtil.GetComInChildren(hsv, "UIInfinite")
    layout:Init("UIs/Matrix/MatrixCreateItem", LayoutCallBack, true)
    UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.MoveByType, {"RTL"})
end

function OnInit()
    UIUtil:AddTop2("MatrixCreate", gameObject, function()
        view:Close()
    end, nil, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Matrix_Building_CreateRet, function()
        RefreshPanel()
    end)
    eventMgr:AddListener(EventType.Matrix_Building_Update, function()
        RefreshPanel()
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data)
    end
end

function OnOpen()
    -- TabItemClick(0)
    InitLeftPanel()
    RefreshPanel()
end

function InitLeftPanel()
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", leftPoint.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    local leftDatas = {{10022, "Matrix/img_87_01_01"}, {10447, "Matrix/img_87_01_02"}, {10448, "Matrix/img_87_01_03"}} -- 多语言id，需要配置英文
    local leftChildDatas = {} -- 子项多语言，需要配置英文
    leftPanel.Init(this, leftDatas, leftChildDatas)
end

function RefreshPanel()
    SetItems()
    -- 侧边动画
    leftPanel.Anim()

    -- 红点
    SetRed()
end

-- 红点添加或者移除
function SetRed()
    for i, v in ipairs(leftPanel.leftItems) do
        local isRed = false
        local index = i - 1
        if (index == 0) then
            isRed = MatrixMgr:CheckBuildRed()
        else
            local cfgs = Cfgs.CfgBuidingBase:GetAll()
            for i, v in pairs(cfgs) do
                if (index == v.group) then
                    local buildData = MatrixMgr:GetBuildingDataByType(v.type)
                    if (buildData) then
                        isRed = buildData:CheckCanUp()
                    else
                        if (MatrixMgr:CheckHadBuildByID(v)) then
                            isRed = true
                        end
                    end
                end
                if (isRed) then
                    break
                end
            end
        end
        v.SetRed(isRed)
    end
end

function SetItems()
    curDatas = {}
    for i, v in pairs(Cfgs.CfgBuidingBase:GetAll()) do
        if (v.isShow and (curIndex1 == 1 or ((curIndex1 - 1) == v.group))) then
            local canOpen, strID = MatrixMgr:CheckCreate(v.id)
            table.insert(curDatas, {v, canOpen, strID})
        end
    end
    table.sort(curDatas, function(a, b)
        return a[1].buildSort < b[1].buildSort
    end)

    layout:IEShowList(#curDatas)
end

