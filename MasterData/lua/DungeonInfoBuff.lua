local cfg = nil
local data = nil
local sectionData = nil
local layout = nil
local curDatas = nil
local callBack = nil

function Awake()
    layout = ComUtil.GetCom(hsv, "UISV");
    layout:Init("UIs/Trials2/DungeonInfoBuffItem", LayoutCallBack, true);
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetClickCB(callBack)
        lua.Refresh(_data)
    end
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then

    end
end

function SetItems(_datas,_callBack)
    curDatas = _datas
    callBack = _callBack
    layout:IEShowList(#curDatas)
    CSAPI.SetGOActive(txtEmpty,#curDatas<=0)
end