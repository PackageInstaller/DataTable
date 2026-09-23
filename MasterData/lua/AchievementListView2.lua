
local listData = nil
local jumpID = nil
local currItem = nil
local layout = nil
local curDatas= nil
local rightItem = nil
local selIndex = 0
local isRed = false

function Awake()
    layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/Achievement/AchievementListItem2",LayoutCallBack,true);
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)

    ResUtil:CreateUIGOAsync("Sort/SortTop", sortParent, function(go)
        local lua = ComUtil.GetLuaTable(go)
        lua.Init(23, RefreshPanel)
    end)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnClickItemCB)
        lua.Refresh(_data)
        lua.SetSelect(selIndex == index)
    end
end

function OnClickItemCB(item)
    if selIndex == item.index then
        return 
    end

    local lua = layout:GetItemLua(selIndex)
    if lua then
        lua.SetSelect(false)
    end
    selIndex = item.index
    currItem = item
    currItem.SetSelect(true)

    SetRight()
end

function Refresh(_data,_elseData)
    listData = _data
    jumpID = _elseData
    if listData then
        local lua =layout:GetItemLua(selIndex)
        if lua then
            lua.SetSelect(false)
            selIndex = 0
        end
        RefreshPanel()
    end
end

function RefreshPanel()
    SetLeft()
    SetRight()
    SetRed()
end

function SetLeft()
    curDatas = SortMgr:Sort(23, AchievementMgr:GetArr(listData:GetID()))
    if selIndex > #curDatas then
        selIndex = 0
    end
    if jumpID and curDatas and #curDatas> 0 then
        for i, v in ipairs(curDatas) do
            if v:GetID() == jumpID then
                selIndex = i
                jumpID = nil
                break
            end
        end
    end
    tlua:AnimAgain()
    layout:IEShowList(#curDatas,nil,selIndex)
    isRed = AchievementMgr:CheckRed()
    CSAPI.SetGOActive(btnGetAll,isRed)
    -- CSAPI.SetGOAlpha(btnGetAll,isRed and 1 or 0.5)
end

function SetRight()
    if rightItem then
        rightItem.Refresh(selIndex == 0 and listData or curDatas[selIndex])
    else
        ResUtil:CreateUIGOAsync("Achievement/AchievementItem2",rightParent,function (go)
            local lua = ComUtil.GetLuaTable(go)
            lua.Refresh(selIndex == 0 and listData or curDatas[selIndex])
            rightItem = lua
        end)
    end
end

function SetRed()
    UIUtil:SetRedPoint(redParent,isRed)
end

function OnClickAllGet()
    if isRed then
        AchievementMgr:SetIsShow(true)
        AchievementProto:GetAllReward()
    end
end