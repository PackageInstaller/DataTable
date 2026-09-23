local curLIndex = 1
local curTopIndex = 1
local curUseIdx = nil

function Awake()
    UIUtil:AddTop2("RogueTSelectBuff", gameObject, function()
        view:Close()
    end, nil, {})

    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/RogueT/RogueTSaveBuffItem", LayoutCallBack, true)

    layout1 = ComUtil.GetCom(hsv, "UIInfinite")
    layout1:Init("UIs/RogueT/RogueTCurBuffItem1", LayoutCallBack1, true)
    UIInfiniteUtil:AddUIInfiniteAnim(layout1, UIInfiniteAnimType.RogueT)

    layout2 = ComUtil.GetCom(vsv2, "UIInfinite")
    layout2:Init("UIs/RogueT/RogueTCurBuffItem2", LayoutCallBack2, true)
    UIInfiniteUtil:AddUIInfiniteAnim(layout2, UIInfiniteAnimType.RogueTM)

    InitTopData()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = lDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB)
        lua.Refresh(_data, curLIndex, curUseIdx)
    end
end
function ItemClickCB(index)
    curLIndex = index
    curTopIndex = 1
    RefreshPanel()
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

-- data:关卡组id openSetting: 1：存档选择与删除 
function OnOpen()
    SetDatas()
    RefreshPanel()
end

function SetDatas()
    curData = RogueTMgr:GetData(data)
    curUseIdx = curData:GetUseBuff() -- 当前使用的存档
    buffsDic = curData:GetBuffsDic()
    if (curUseIdx and curUseIdx ~= 0) then
        curLIndex = curUseIdx
    else
        curLIndex = 1
    end
end

function RefreshPanel()
    SetL()
    --
    layout1:IEShowList(#topCfgs)
    --
    SetVSV()
    -- btn
    SetBtns()
end

function SetL()
    lDatas = {}
    local len = curData:GetCfg().archiveMax
    for k = 1, len do
        local data = buffsDic[k] or {
            idx = k,
            tBuff = nil
        }
        table.insert(lDatas, data)
    end
    layout:IEShowList(#lDatas)
end

function SetVSV()
    arr = lDatas[curLIndex] and lDatas[curLIndex].tBuff or {}
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

function SetBtns()
    CSAPI.SetGOActive(btns, lDatas[curLIndex].tBuff ~= nil)
    if (lDatas[curLIndex].tBuff ~= nil) then
        local isSelect = curLIndex == curUseIdx
        CSAPI.SetGOAlpha(btnDelete, isSelect and 0.5 or 1)
        CSAPI.SetGOAlpha(btnSure, isSelect and 0.5 or 1)
        CSAPI.SetGOActive(btnDelete, not isSelect)
    end
end

function OnClickDelete()
    if (curLIndex ~= curUseIdx) then
        UIUtil:OpenDialog(LanguageMgr:GetByID(54037), function()
            FightProto:RogueTDelBuff(data, curLIndex, OnOpen)
        end)
    end
end

function OnClickSure()
    if (curLIndex ~= curUseIdx) then
        FightProto:RogueTUseBuff(curData:GetID(), curLIndex, function()
            curUseIdx = curLIndex
            layout:UpdateList()
            SetBtns()
        end)
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
