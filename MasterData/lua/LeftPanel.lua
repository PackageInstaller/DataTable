--[[	1、20220518 可修改父间隔 Init(--,_parentScale)
    2、20220518 可以滑动，由于子数量是动态的，所以大小放在动画进行时调整 SetContentScale()
	3/20221025 SetCanClick 能否点击
]] local mLItemAnimTools = LItemAnimTools.New()

local isCanClick = true
local item2Height = 113

function Awake()
    mLItemAnimTools:Init(this)
end

function Init(_panel, leftDatas, leftChildDatas, _parentScale)
    panel = _panel
    InitLeftItems(leftDatas, leftChildDatas)

    parentScale = _parentScale or 167
    mLItemAnimTools:InitScale(parentScale)

    isCanClick = true
end

-- 修改滑动的可见区域的大小
function SetContentScale()
    local width = 0 -- 234.6
    local height = 0
    local childItems = leftChildItems[GetCurIndex1()]
    local count = childItems and #childItems or 0
    height = parentScale * (#leftItems - 1) + 60 + count * item2Height
    CSAPI.SetRTSize(content, width, height)

    SetArrow()
end

function SetArrow()
    if (isArrowIn) then
        return
    end
    isArrowIn = 1
    local svArrow = ComUtil.GetCom(sv, "SVArrow")
    svArrow:Refresh()
end

function InitLeftItems(_leftDatas, _leftChildDatas)
    leftDatas = _leftDatas
    leftChildDatas = _leftChildDatas

    -- 父
    leftItems = leftItems or {}
    local path1 = "Common/LItem1"
    ItemUtil.AddItemsImm(path1, leftItems, leftDatas, node, Item1Select)

    -- 子
    leftChildItems = leftChildItems or {}
    if (leftChildDatas) then
        local path2 = "Common/LItem2"
        for i, v in ipairs(leftChildDatas) do
            local items = leftChildItems[i] or {}
            ItemUtil.AddItemsImm(path2, items, v, leftItems[i].childPoint, Item2Select)
            table.insert(leftChildItems, items)
        end
    end
end

-- 选中
function Anim()
    -- parent
    if (curItem) then
        curItem.Select(false)
    end

    curItem = leftItems[GetCurIndex1()]
    curItem.Select(true)
    -- CSAPI.SetAnchor(leftItems[2].gameObject, 0, GetLeftItem2TargetPos(), 0)
    -- child
    if (leftChildItems[GetCurIndex1()] and leftChildItems[GetCurIndex1()][GetCurIndex2()]) then
        if (curChildItem) then
            curChildItem.Select(false)
        end
        curChildItem = leftChildItems[GetCurIndex1()][GetCurIndex2()]
        curChildItem.Select(true)
    end
    -- 动画
    if (not isFirst) then
        isFirst = true
        mLItemAnimTools:AnimFirst()
    else
        mLItemAnimTools:Anim()
    end

    SetContentScale()
end

function GetCurIndex1()
    return panel.curIndex1
end

function GetCurIndex2()
    return panel.curIndex2
end

function Item1Select(_index)
    if (not isCanClick) then
        return
    end
    -- 锁定状态
    if (leftDatas[_index][3]) then
        Tips.ShowTips(leftDatas[_index][4])
        return
    end
    if (panel.curIndex1 == _index) then
        return
    end
    panel.curIndex1 = _index
    panel.curIndex2 = 1
    panel.RefreshPanel()
end

function Item2Select(_index)
    if (not isCanClick) then
        return
    end
    if (panel.curIndex2 == _index) then
        return
    end
    panel.curIndex2 = _index
    panel.RefreshPanel()
end

-- 设置能不点击
function SetCanClick(b)
    isCanClick = b
end

function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    content = nil;
    node = nil;
    view = nil;
end
----#End#----
