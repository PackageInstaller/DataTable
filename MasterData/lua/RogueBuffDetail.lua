function Awake()
    tab = ComUtil.GetCom(tabs, "CTab")
    tab:AddSelChangedCallBack(OnTabChanged)

    layout = ComUtil.GetCom(sv1, "UIInfinite")
    layout:Init("UIs/Rogue/RogueBuffDetailItem1", LayoutCallBack, true)
    layoutTween = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.MoveByType2, {"UTD"})
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data[1])
        if(_data[3]==0) then 
            lua.SetSpecialName()
        end 
    end
end

function OnOpen()
    curData = RogueMgr:GetCurData()
    data = RogueMgr:GetData(curData.group)
    tab.selIndex = 0
    -- top
    local isMax = curData.round >= data:GetLimitRound()
    -- x轮 
    if (isMax) then
        LanguageMgr:SetText(txtTop, 50015)
        CSAPI.LoadImg(top, "UIs/Rogue/img9_10_02.png", false, nil, true)
    else
        LanguageMgr:SetText(txtTop, 50014, curData.round)
        CSAPI.LoadImg(top, "UIs/Rogue/img9_10_01.png", false, nil, true)
    end
end

function OnTabChanged(_index)
    RefreshPanel()
end

function RefreshPanel()
    CSAPI.SetGOActive(sv1, tab.selIndex == 0)
    CSAPI.SetGOActive(sv2, tab.selIndex ~= 0)
    if (tab.selIndex == 0) then
        curDatas = {}
        local _curDatas = curData.selectBuffs
        local useIDDic = {}
        local _useIDs = GCalHelp:GetRogueEffectingBuff(curData.selectBuffs, curData.round)
        if (_useIDs) then
            for k, v in pairs(_useIDs) do
                useIDDic[v] = 1
            end
        end
        for k, v in ipairs(curData.selectBuffs) do
            local useIndex = useIDDic[v] ~= nil and 1 or 0
            table.insert(curDatas, {v, k, useIndex})
        end
        if (#curDatas > 1) then
            table.sort(curDatas, function(a, b)
                if (a[3] == b[3]) then
                    return a[2] < b[2]
                else
                    return a[3] > b[3]
                end
            end)
        end
        layout:IEShowList(#curDatas)
    else
        local data = RogueMgr:GetData(curData.group)
        curDatas2 = data:GetCfg().globalBuffs or {}
        items2 = items2 or {}
        ItemUtil.AddItems("Rogue/RogueBuffDetailItem2", items, curDatas2, Content2)
        CSAPI.SetGOActive(noneObj, #curDatas2 <= 0)
    end
end

function OnClickMask()
    view:Close()
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end