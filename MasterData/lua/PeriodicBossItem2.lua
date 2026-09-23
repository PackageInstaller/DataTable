local info = nil
local isGet = false

function Awake()
    InitAnim()
end


function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _elseData)
    info = _data
    isGet = _elseData and _elseData >= index
    if info then
        SetNum()
        SetState()
    end
end

function SetNum()
    local damage = info.damage or 0
    local isReduce = damage / 10000 > 0
    CSAPI.SetGOActive(txt_num,isReduce)
    CSAPI.SetText(txtNum,isReduce and math.floor(damage / 10000) .. "" or damage .. "")
end

function SetState()
    CSAPI.SetImgColorByCode(nol,isGet and "191919" or "888888")
    CSAPI.SetGOActive(get,isGet)
end

function OnClick()
    if cb then
        cb(this)
    end
end

---------------------------------------------anim---------------------------------------------
local nodeAnim = nil
function InitAnim()
    nodeAnim = ComUtil.GetCom(node,"Animator")
end

function ShowEnterAnim(delay)
    FuncUtil:Call(function ()
        if not IsNil(nodeAnim) then
            nodeAnim:Play("item2Entry")
        end
    end,this,delay)
end
