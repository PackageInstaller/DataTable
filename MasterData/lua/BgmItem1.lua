local curMusicID

function SetIndex(_index)
    index = _index
end
function SetClickCB(_cb)
    cb = _cb
end
function Awake()
    nameMove = ComUtil.GetCom(nameObj, "TextMove")
    nameMove.duration = 12
    nameMove.isMove = false
    
    anim_neri = ComUtil.GetCom(neri, "ActionBase")

    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Bgm/BgmItem2", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    local _data = curDatas[index]
    lua.SetIndex(index)
    lua.SetSelectCB(ItemClickCB)
    lua.Refresh(_data, curMusicID)
end

function ItemClickCB(id)
    curMusicID = id
    layout:UpdateList()
    EventMgr.Dispatch(EventType.BGM_Select, curMusicID)
end

function Refresh(_cfg, _curMusicID)
    cfg = _cfg
    curMusicID = _curMusicID
    CSAPI.SetText(txtIndex, index < 10 and "0" .. index or index .. "")
    CSAPI.SetText(txtName, cfg.sName)
    -- SetSelect(curIndex == index)
    -- icon  
    ResUtil:LoadBigImgByExtend(icon, cfg.img)
    -- ResUtil.MultiImg:Load(icon, cfg.img)
    CSAPI.SetAnchor(icon, cfg.offices[1], cfg.offices[2], 0)
    CSAPI.SetScale(icon, cfg.offices[3], cfg.offices[3], 1)
    --
    if (oldCurMusicID and oldCurMusicID ~= curMusicID) then
        layout:UpdateList()
    end
    oldCurMusicID = curMusicID
end

function SetSelect(b)
    CSAPI.SetGOActive(right, b)
    if (b) then
        curDatas = BGMMgr:GetMusics(cfg.id)
        layout:IEShowList(#curDatas)
        UIUtil:SetPObjMove(left, 0, -187, 0, 0, 0, 0, nil, 500, 1)
        UIUtil:SetPObjMove(right, 0, 287, 0, 0, 0, 0, nil, 500, 1)

    else
        CSAPI.SetAnchor(left, 0, 0, 0)
        CSAPI.SetAnchor(right, 0, 0, 0)
    end
    if (b) then
        -- nameMove:SetMove()
        nameMove.isMove = true

        anim_neri:ToPlay()
    else
        -- nameMove:ResetAll()
        nameMove.isMove = false

        anim_neri:SetRun(false)
        CSAPI.SetRectAngle(neri, 0, 0, 0)
    end
end

function SetPush(isPush, curIndex)
    if (isPush) then
        local x = index > curIndex and 150 or -150
        UIUtil:SetPObjMove(clickNode, 0, x, 0, 0, 0, 0, nil, 800, 1)
    else
        CSAPI.SetAnchor(clickNode, 0, 0, 0)
    end
end

--------------------------------------------------------------
function OnClick()
    if cb then
        cb(index)
    end
end

function SetSibling(index)
    index = index or 0
    if index == -1 then
        transform:SetAsLastSibling()
    else
        transform:SetSiblingIndex(index)
    end
end

-- 根据X轴距离设置大小
function SetScale(s)
    CSAPI.SetScale(alphaNode, s, s, s)
    CSAPI.SetGOAlpha(alphaNode, s)
end

function GetPos()
    local pos = {100000, 100000, 0}
    local x, y, z = CSAPI.GetPos(alphaNode)
    pos = {x, y, z}
    return pos
end

------------------------------------------------------------
