local stopTime = 1
local isHit = false
local animTime = 0
local animName = nil
local ix = 0
local isGold = 1 -- 1黑色  2金色

function Awake()
    anim_node = ComUtil.GetCom(node, "Animator")
end

function SetClickCB(_cb)
    cb = _cb
end

function Update()
    if (animTime and animTime > 0) then
        animTime = animTime - Time.deltaTime
    end
end

function Refresh(_data)
    data = _data
end

function PlayAnim(_animName, _ix, _isGold)
    if (not animName and _animName == "target_quit") then
        return
    end
    if (animName and animName == _animName) then
        return
    end
    animName = _animName
    if (_animName == "target_entry") then
        animTime = 0.7
        isHit = false
        ix = _ix
        isGold = _isGold
        CSAPI.LoadImg(icon, isGold and "UIs/Spine/30180_skin_Machairodus05a_spine/img_04_01.png" or
            "UIs/Spine/30180_skin_Machairodus05a_spine/img_04_02.png", true, nil, true)
        CSAPI.PlayTempSound("Machairodus_Effects_04")
    elseif (_animName == "target_quit") then
        animTime = 0.4
        --CSAPI.PlayTempSound("Machairodus_Effects_04")
    else
        isHit = true
        animTime = 0.4
    end
    anim_node:Play(_animName)
end

function GetIx()
    return ix
end

function Click(score)
    if (animTime and animTime > 0) then
        return
    end
    if (isHit) then
        return
    end
    cb(this, score)
end

function OnClickHead()
    Click(isGold and 100 or 50)
end

function OnClickBody()
    Click(isGold and 100 or 50)
end

