function Awake()
    curSelect = 0
    layout = ComUtil.GetCom(vsv2, "UISV2")
    layout:Init("UIs/Test/TestUISV2Item", LayoutCallBack)
end

function Start()
    arr = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
    layout:IEShowList(#arr)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = arr[index]
        lua.SetIndex(index)
        lua.Refresh(_data, curSelect, ItemClickCB)
    end
end

function ItemClickCB(index)
    if (curSelect == index) then
        curSelect = 0
    else
        curSelect = index
    end
    layout:SelectItem(curSelect)
    layout:UpdateList()
end

function OnClickMask()
    view:Close()
end


function OnClickC()
    arr = {11, 21, 31, 41, 51, 61, 71, 81, 91, 100}
    layout:IEShowList(#arr)
end

function OnClickC2()
    arr = {1, 2, 3}
    layout:IEShowList(#arr)
end