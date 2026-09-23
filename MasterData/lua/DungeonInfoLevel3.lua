local cfg = nil
local data = nil
local sectionData = nil
local cur,max,realMax =0,0,0
local lastCur = 1
local isClick,tipStr,maxStr = true,"",""

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then

    end
end

function SetLv(_cur,_max,_realMax)
    cur = _cur or cur
    max = _max or max
    realMax= _realMax or realMax
    CSAPI.SetText(txtCur,cur .. "")
    CSAPI.SetText(txtMax,"/".. realMax)
    CSAPI.SetText(txtLv,"Lv." .. cur)
end

function OnClickAdd()
    if not isClick then
        Tips.ShowTips(tipStr)
        return
    end
    cur = cur + 1
    if cur >= max then
        if cur > max then
            Tips.ShowTips(maxStr)
        end
        cur = max
    end
    SetLv(cur)
    if cur ~= lastCur then
        EventMgr.Dispatch(EventType.Dungeon_InfoItem_Update,{level = cur})
    end
    lastCur= cur
end

function OnClickRemove()
    if not isClick then
        Tips.ShowTips(tipStr)
        return
    end
    cur = cur - 1
    if cur <= 0 then
        cur = 1
    end
    SetLv(cur)
    if cur ~= lastCur then
        EventMgr.Dispatch(EventType.Dungeon_InfoItem_Update,{level = cur})
    end
    lastCur= cur
end

function GetCur()
    return cur
end

function SetClick(b,str,_maxStr)
    isClick = b
    tipStr = str
    maxStr = _maxStr
end