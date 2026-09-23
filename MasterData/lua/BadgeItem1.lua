local datas = nil
local items=nil
local selIndex= 0
local isHideNew = false

function Awake()
    InitAnim()
    PlayEnterAnim()
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data,_elseData)  
    datas = _data or {}
    selIndex = _elseData and _elseData.selIndex or 1
    isHideNew = _elseData and _elseData.isHideNew or false
    SetItems()
end

function SetItems()
    items = items or {}
    for i = 1, 6 do
        if i > #items then
            ResUtil:CreateUIGOAsync("Badge/BadgeGridItem",grid,function (go)
                local lua = ComUtil.GetLuaTable(go)
                lua.SetIndex(i)
                lua.SetClickCB(OnItemClickCB)
                lua.SetScale(0.6, 0.68)
                lua.Refresh(datas[i],isHideNew)
                lua.SetSelect(i == selIndex)
                items[i] = lua
            end)
        else
            items[i].Refresh(datas[i],isHideNew)
            items[i].SetSelect(i == selIndex)
        end
    end
end

function OnItemClickCB(item)
    if item.index == selIndex then
        return
    end
    local lastItem = items[selIndex]
    if lastItem then
        lastItem.SetSelect(false)
    end
    item.SetSelect(true)
    selIndex = item.index

    if cb then
        cb(item)
    end
end

function SetSelect(index)
    local lastItem = items[selIndex]
    if lastItem then
        lastItem.SetSelect(false)
    end
    local item = items[index]
    if item then
        item.SetSelect(true)
        selIndex = index
    end
end

function GetCurrItem()
    return items[selIndex]
end

function OnClickClear()
    local dialogData= {}
    dialogData.content = LanguageMgr:GetTips(36007)
    dialogData.okCallBack =  function()
        BadgeMgr:UpdateSorts({})
        EventMgr.Dispatch(EventType.Badge_Data_Update)
        LanguageMgr:ShowTips(36006)
    end
    CSAPI.OpenView("Dialog",dialogData)
end

--------------------------------anim--------------------------------

function InitAnim()
    CSAPI.SetGOActive(enterAction,false)
end

function ShowEffect(go)
    CSAPI.SetGOActive(go,false)
    CSAPI.SetGOActive(go,true)
end

function PlayEnterAnim()
    ShowEffect(enterAction)
end