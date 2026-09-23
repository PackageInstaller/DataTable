local layout = nil
local curDatas = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/RogueMapBattle/RogueMapBuffItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data)
    end
end

function OnOpen()
    if data then
        curDatas = data
        SetItems()
    end
end

function SetItems()
    layout:IEShowList(#curDatas)
end

function OnClickClose()
    view:Close()
end