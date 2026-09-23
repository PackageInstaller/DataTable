
local layout = nil
local datas = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/GlobalBoss/GlobalBossBuffItem1", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if lua then
        local _data = datas[index]
        lua.Refresh(_data)
    end
end

function OnOpen()
    datas = data
    if datas then
        SetItems()
    end
end

function SetItems()
    layout:IEShowList(#datas)
end

function OnClickClose()
    view:Close()
end