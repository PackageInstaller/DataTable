local selectIndex = 1 -- 打开前选中的索引
local curIndex = 1 -- 当前滑动的索引
local isDrag = false

function Awake()
    UIUtil:AddTop2("RogueTHard", gameObject, function()
        view:Close()
    end, nil, {})

    layout = ComUtil.GetCom(vsv, "UISV")
    layout:Init("UIs/RogueT/RogueTHardItem", LayoutCallBack, true)
    layout:AddOnValueChangeFunc(OnValueChange)
    layout:AddToCenterFunc(ToCenterCB)
    svUtil = SVCenterDrag.New()
end
--------------------------------------------------------------
function LayoutCallBack(index)
    local _data = curDatas[index]
    local item = layout:GetItemLua(index)
    item.SetIndex(index)
    item.SetClickCB(OnClickItem)
    item.Refresh(_data)
end

function ToCenterCB(index)
    curIndex = index == nil and curIndex or (index + 1)
    if (index ~= nil) then
        SetDetail()
    end
    --
    local item = layout:GetItemLua(curIndex)
    if (item) then
        item.SetColor(true)
    end
    --
    isDrag = false
end

function OnValueChange()
    svUtil:Update()
    if not isDrag then
        --
        isDrag = true
        local item = layout:GetItemLua(curIndex)
        if (item) then
            item.SetColor(false)
        end
    end
end

function OnClickItem(index)
    layout:MoveToCenter(index)
end

--------------------------------------------------------------

function OnOpen()
    curDatas = RogueTMgr:GetArr()
    for k, v in ipairs(curDatas) do
        if (v:GetID() == data[1]) then
            curIndex = k
            selectIndex = k
            break
        end
    end

    -- items 
    svUtil:Init(layout, #curDatas, {140, 190}, 7, 0.15, 0.5, true)
    layout:IEShowList(#curDatas, FirstCB, curIndex)

    SetDetail()
end

function FirstCB()
    if (not isFirst1) then
        isFirst1 = true
        --
        -- svUtil:Update()
        --
        -- ToCenterCB()
        OnValueChange()
        ToCenterCB()
    end
end

function SetDetail()
    CSAPI.SetText(txtHard, selectIndex .. "")
    alpha = 1

    -- 解锁描述
    local isLock = false
    local cfg = Cfgs.DungeonGroup:GetByID(curDatas[curIndex]:GetID())
    if (cfg.perLevel ~= nil) then
        local perCfg = Cfgs.DungeonGroup:GetByID(cfg.perLevel)
        LanguageMgr:SetText(txtLock1, 54048, perCfg.hard)
        isLock = (cfg.hard - 1) > RogueTMgr:GetMaxHard()
    end
    if (cfg.unlock ~= nil) then
        local _isOpen, str = MenuMgr:CheckConditionIsOK({cfg.unlock})
        CSAPI.SetText(txtLock2, str)
        if (not isLock) then
            isLock = not _isOpen
        end
    end
    if (not isLock) then
        CSAPI.SetGOActive(lock1, false)
        CSAPI.SetGOActive(lock2, false)
    else
        CSAPI.SetGOActive(lock1, cfg.perLevel ~= nil)
        CSAPI.SetGOActive(lock2, cfg.unlock ~= nil)
        alpha = 0.5
    end
    if(selectIndex==curIndex)then 
        alpha = 0.5
    end 

    CSAPI.SetGOAlpha(btnSure, alpha)
end

function OnClickArrow1()
    if (curIndex > 1) then
        OnClickItem(curIndex-1)
    end
end

function OnClickArrow2()
    if (curIndex < #curDatas) then
        OnClickItem(curIndex+1)
    end
end

function OnClickSure()
    if (alpha == 1) then
        selectIndex = curIndex
        data[2](curDatas[selectIndex]:GetID())
        --SetDetail()
        view:Close()
    end
end


---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
