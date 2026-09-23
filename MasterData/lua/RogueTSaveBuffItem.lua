function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _curIndex, _curUseIdx)
    data = _data
    CSAPI.SetGOActive(entity, data.tBuff ~= nil)
    CSAPI.SetGOActive(empty, data.tBuff == nil)
    CSAPI.SetGOActive(useObj, data.idx == _curUseIdx)
    if (data.tBuff~=nil) then
        CSAPI.SetText(txtName, data.name)
        LanguageMgr:SetText(txtName, 54029, data.idx)
    end
    CSAPI.SetGOActive(select, data.idx == _curIndex)
end

function OnClick()
    cb(index)
end
