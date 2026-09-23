function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Common/SignInNRewardItem1", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data, data[2])
    end
end

-- data {cfgName,num}  = 对应的表（含rewards）,当前已领的最大num
function OnOpen()
    InitDatas()
end

function InitDatas()
    curDatas = {}
    curDatas = Cfgs[data[1]]:GetAll()
    layout:IEShowList(#curDatas)
end

function OnClickClose()
    view:Close()
end
