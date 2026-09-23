-- data :fid
function Awake()
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/Matrix/MatrixTradingFriendItem", LayoutCallBack, true)
end

-- function OnInit()
-- 	UIUtil:AddTop2("MatrixTradingFriend", gameObject, function()view:Close()end, nil, {})
-- end 

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data, fid, ItemClickCB)
    end
end

function ItemClickCB(_data)
    local nfid = _data:GetUid()
    if (openView == "MatrixTrading") then
        if (fid and fid == nfid) then
            LanguageMgr:ShowTips(2101)
        else
            -- 新的访问
            CSAPI.OpenView("MatrixTrading", nfid)
        end
    elseif (openView == "DormView") then
        if (fid and fid == nfid) then
            LanguageMgr:ShowTips(21013)
        else
            -- 新的访问
            CSAPI.OpenView("DormRoom", nfid)
            --view:Close()
            OnClickMask()
        end
    end
end

function OnOpen()
    RefreshPanel()
end

function Refresh(_data)
    data = _data
    RefreshPanel()
end

function RefreshPanel()
    openView = data[1]
    fid = data[2]
    curDatas = data[3] or FriendMgr:GetDatasByState(eFriendState.Pass)
    -- count
    local max = FriendMgr:GetMaxCount()
    CSAPI.SetText(txtCount, string.format("%s/%s", #curDatas, max))
    -- list
    if (len and len == #curDatas) then
        layout:UpdateList()
    else
        layout:IEShowList(#curDatas)
        len = #curDatas
    end

    CSAPI.SetGOActive(SortNone, #curDatas <= 0)
end

function OnClickMask()
    -- if (openView == "MatrixTrading") then
    --     CSAPI.SetGOActive(gameObject, false)
    -- else
    --     view:Close()
    -- end
    CSAPI.SetGOActive(gameObject, false)
end

