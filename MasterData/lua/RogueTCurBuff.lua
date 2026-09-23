local curTopIndex = 1

function Awake()
    topLua = UIUtil:AddTop2("RogueTCurBuff", gameObject, function()
        view:Close()
    end, nil, {})

    layout1 = ComUtil.GetCom(hsv, "UIInfinite")
    layout1:Init("UIs/RogueT/RogueTCurBuffItem1", LayoutCallBack1, true)
    UIInfiniteUtil:AddUIInfiniteAnim(layout1, UIInfiniteAnimType.RogueT)

    layout2 = ComUtil.GetCom(vsv, "UIInfinite")
    layout2:Init("UIs/RogueT/RogueTCurBuffItem2", LayoutCallBack2, true)
    UIInfiniteUtil:AddUIInfiniteAnim(layout2, UIInfiniteAnimType.RogueTM)

    InitTopData()
end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = topCfgs[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB1)
        lua.Refresh(_data, curTopIndex)
    end
end
function ItemClickCB1(index)
    curTopIndex = index
    layout1:UpdateList()
    SetVSV()
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data)
    end
end

function InitTopData()
    local _cfgs = Cfgs.CfgRogueBuffType:GetAll()
    topCfgs = {}
    table.insert(topCfgs, {
        id = 0,
        icon = "1000" -- RogueBuff
    })
    for k, v in ipairs(_cfgs) do
        table.insert(topCfgs, v)
    end
end

function OnOpen()
    topLua.SetHomeActive(openSetting == nil)

    arr = RogueTMgr:GetSelectBuffs()

    RefreshPanel()
end

function RefreshPanel()
    --
    layout1:IEShowList(#topCfgs)
    --
    SetVSV()
end

function SetVSV()
    curDatas = {}
    if (curTopIndex == 1) then
        curDatas = arr
    else
        local id = topCfgs[curTopIndex].id
        for k, v in ipairs(arr) do
            local cfg = Cfgs.CfgRogueTBuff:GetByID(v)
            if (cfg.buffType == id) then
                table.insert(curDatas, v)
            end
        end
    end
    layout2:IEShowList(#curDatas)
    CSAPI.SetGOActive(txtEmpty, #curDatas <= 0)
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
