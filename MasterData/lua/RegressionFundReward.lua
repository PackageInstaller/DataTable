local item = nil
function SetIndex(idx)
    index= idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data,_elseData)
    data = _data
    if  index == 2 then
        CSAPI.SetGOActive(lockObj,_elseData and _elseData.isLock)
        CSAPI.SetGOActive(txt_get,_elseData and _elseData.isGet2)
        CSAPI.SetGOAlpha(node,(_elseData and (_elseData.isLock or _elseData.isGet2)) and 0.5 or 1)
    else
        CSAPI.SetGOActive(lockObj,false)
        CSAPI.SetGOActive(txt_get,_elseData and _elseData.isGet)
        CSAPI.SetGOAlpha(node,(_elseData and _elseData.isGet) and 0.5 or 1)
    end
    if data then
        if item == nil then
            ResUtil:CreateUIGOAsync("Grid/GridItem", gridParent, function(go)
                local lua = ComUtil.GetLuaTable(go)
                lua.Refresh(data)
                lua.SetClickCB(cb)
                item = lua
            end)
        else
            item.Refresh(data)
        end
    end
end

function OnClickLock()
    Tips.ShowTips(LanguageMgr:GetByID(60008))
end