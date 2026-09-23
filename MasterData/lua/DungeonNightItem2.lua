local data = nil
local anim = nil

function Awake()
    anim =ComUtil.GetComInChildren(effect,"Animator")

    CSAPI.SetGOActive(effectObj,false)
end

--DungeonGroupData
function Refresh(_data)
    data = _data
    if data then
        SetPos()
        SetIcon()
    end
end

function SetPos()
    local pos = data:GetPos()
    CSAPI.SetAnchor(gameObject,pos.x,pos.y)
end

function SetIcon()
    local iconName = data:GetIcon()
    if iconName and iconName~= "" then
        ResUtil.DungeonNight:Load(icon01,iconName.."_01")
        ResUtil.DungeonNight:Load(icon02,iconName.."_02")
    end
    local info = data:GetTargetJson()
    if info and info[3] and info[3].icon2 then
        CSAPI.SetAnchor(icon02,info[3].icon2[1],info[3].icon2[2])
    else
        CSAPI.SetAnchor(icon02,0,0)
    end
end

function SetSiblingIndex(topIndex)
    local pos= data:GetPos()
    transform:SetSiblingIndex(pos.y> 77 and 0 or topIndex)
end

function SetAnim(isClick)
    if not IsNil(anim) then
        anim:SetBool("isClick",isClick)
    end
    CSAPI.SetGOActive(effectObj,isClick)
end