local data= nil
local ids = {37092,37093,37094}
local isLock = false
local isCur = false

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    data = _data
    if data then
        isCur = data.isCur
        isLock = data.isLock
        index = data.index
        SetText()
        SetState()
    end
end

function SetText()
    LanguageMgr:SetText(txtIndex,ids[index])
end

function SetState()
    CSAPI.SetGOActive(lockImg,isLock)
    CSAPI.SetGOAlpha(gameObject,isLock and 0.5 or 1)
    local code = isCur and "ffc146" or "ffffff"
    CSAPI.SetTextColorByCode(txtIndex,code)
    CSAPI.SetImgColorByCode(curImg1,code)
    CSAPI.SetImgColorByCode(curImg2,code)
end

function OnClick()
    if isLock or isCur then
        return
    end
    if cb then
        cb(this)
    end
end