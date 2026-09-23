local curLIndex = 1
local curTopIndex = 1
--local toSaveBuff
local isMax, idx = false, 1
local curUseIdx = nil
local isSave = false

function Awake()
    UIUtil:AddTop2("RogueTSaveBuff", gameObject, OnClickQuit, OnClickQuit, {})

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

-- 存档保存、替换、离开
function OnOpen()
    EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "RogueTSaveBuff")
    SetDatas()
    RefreshPanel()
end

function SetDatas()
    curData = RogueTMgr:GetData(data)
    buffsDic = curData:GetBuffsDic()

    -- 封装将保存的数据
    local isMax, idx = curData:GetCanUseIdx()
    -- toSaveBuff = {}
    -- toSaveBuff.idx = idx
    -- toSaveBuff.tBuff = RogueTMgr:GetSelectBuffs()

    curLIndex = idx
end

function RefreshPanel()
    SetL()
    --
    layout1:IEShowList(#topCfgs)
    --
    SetVSV()
    --
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
    CSAPI.SetGOActive(btns, #lDatas > 0)
    CSAPI.SetGOActive(btnSave, lDatas[curLIndex].tBuff == nil)
    CSAPI.SetGOActive(btnReplace, lDatas[curLIndex].tBuff ~= nil)
end

function OnClickQuit()
    if (not isSave) then
        UIUtil:OpenDialog(LanguageMgr:GetByID(54044), function()
            FightProto:RogueTBuffSave(false, nil, function()
                RogueTMgr:Quit()
            end)
        end)
    else
        FightProto:RogueTBuffSave(true, curLIndex, function()
            RogueTMgr:Quit()
        end)
    end
end

function OnClickSave()
    if (not isSave) then
        isSave = true
        OnClickQuit()
    end
end

function OnClickReplace()
    if (not isSave) then
        isSave = true
        local str = LanguageMgr:GetByID(54045)
        UIUtil:OpenDialog(str, function()
            OnClickQuit()
        end)
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    OnClickQuit()
end
