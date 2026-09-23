local cb=nil;
--_elseData:CharacterCardsData
function Refresh(coord,_elseData)
    --初始化图标和解锁状态
    this.data=coord;
    coord:LoadIcon(icon);
    if _elseData and this.data:GetID()==_elseData:GetCurCoord():GetID() then
        CSAPI.SetGOActive(selectObj,true);
        CSAPI.SetGOActive(txt,true);
    else
        CSAPI.SetGOActive(selectObj,false);
        CSAPI.SetGOActive(txt,false);
    end
    local lockLv=coord:GetLockLv();
    local lockStr=lockLv and LanguageMgr:GetByID(1033)..tostring(lockLv) or  ""
    CSAPI.SetText(txtLock, lockStr);
    local isLock=_elseData:GetLv()<lockLv;
    CSAPI.SetGOActive(lockObj,isLock);
end

function SetClickCB(_cb)
    cb=_cb
end

function OnClick()
    if cb then
        cb(this)
    end
end