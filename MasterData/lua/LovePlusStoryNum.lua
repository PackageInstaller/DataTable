local index= 0
local isLock = false
local curType = 1 --1.未解锁，2.已解锁，3.当前
function SetIndex(idx)
    index = idx
end

function Refresh(_index,_isLock)
    index = _index
    if index>0 then
        CSAPI.SetGOActive(left, index == 1)
        SetType(_isLock)
        SetText()
        SetState()
    end
end

function SetType(_isLock)
    if _isLock then
        curType = 1
    else
        curType = 2
    end
end

function SetText()
    CSAPI.SetText(txtNum,index.."")
end

function SetState()
    -- CSAPI.SetGOActive(nol,curType==2)
    -- CSAPI.SetGOActive(sel,curType==3)
    -- CSAPI.SetGOActive(lock,curType==1)
end

function SetSel()
    curType = 3
    SetState()
end