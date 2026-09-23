local isSel = false
local data = nil

function Awake()
    InitAnim()
    SetSelect(false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSelect(b)
    isSel = b
    CSAPI.SetGOActive(node1,not b)
    CSAPI.SetGOActive(node2,b)
    -- CSAPI.SetRTSize(gameObject,GetWidth(),1080)
end

--SectionData
function Refresh(_data)
    data = _data
    if data then
        SetTitle()
        SetDesc()
        SetNum()
        SetIcon()
        SetRed()
    end
end

function SetTitle()
    CSAPI.SetText(txtName,data:GetName())
    CSAPI.SetText(txtTitle1,data:GetName())
end

function SetDesc()
    CSAPI.SetText(txtDesc,data:GetDesc())
end

function SetNum()
    local groupDatas = DungeonMgr:GetDungeonGroupDatas(data:GetID())
    local cur,max = 0,#groupDatas
    if #groupDatas > 0 then
        for i, v in ipairs(groupDatas) do
            if v:IsPass() then
                cur = cur + 1
            end
        end
    end
    CSAPI.SetText(txtNum1,cur .. "")
    CSAPI.SetText(txtNum2,"/" .. max)
end

function SetIcon()
    local iconName = data:GetInfoContent("icon")
    if iconName and iconName ~= "" then
        ResUtil.StoryCollectionImg:Load(icon,data:GetID() .. "/" .. iconName)
    end
end

function SetRed()
    local isRed = MissionMgr:CheckRed2(data:GetTaskType(),data:GetID())
    CSAPI.SetGOActive(redParent1,isRed)
    CSAPI.SetGOActive(redParent2,isRed)
end

function GetWidth()
    return isSel and 711 or 136 
end

function GetID()
    return data and data:GetID()
end

function OnClick()
    if cb then
        cb(this)
    end
end

---------------------------------------anim---------------------------------------
local anim,moveAnim = nil,nil
function InitAnim()
    anim = ComUtil.GetCom(root,"Animator")
    moveAnim = ComUtil.GetCom(gameObject,"ActionMoveByCurve")
end

function MoveTo(x,y,time)
    if not IsNil(moveAnim) then
        moveAnim.time = time or 500
        local _x,_y = CSAPI.GetLocalPos(gameObject)
        moveAnim.startPos = UnityEngine.Vector3(_x,_y,0)
        moveAnim.targetPos = UnityEngine.Vector3(x,y,0)
        moveAnim:Play()
    end
end

function ShowSelAnim(b,callback)
    isSel = b
    CSAPI.SetGOActive(node1, true)
    CSAPI.SetGOActive(node2, true)
    if not IsNil(anim) then
        anim:Play(b and "switch" or "switch2")
    end
    FuncUtil:Call(function ()
        SetSelect(b)
        if callback then
            callback()
        end
    end,this,b and 600 or 500)
end