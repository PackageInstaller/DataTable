function Refresh(data,_cb)
    cb = _cb
    ResUtil.ModuleInfo:Load(icon, data)
end

function OnClick()
    if (cb~=nil) then
        cb()
    end
end

