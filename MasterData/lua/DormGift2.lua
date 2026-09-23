local curRole
local curDatas = {}
local giftDatas = {}
local totaleExp = 0
local roleItem1
local roleItem2
local mExp = 0

function Clear()
    curDatas = {}
    giftDatas = {}
    totaleExp = 0
end

function Awake()
    slider = ComUtil.GetCom(Slider, "Slider")

    bar = Bar.New()
    bar:Init(Slider, CfgCardRoleUpgrade, "nExp", SetCLv, SetCExp, 2, SetExp, false)
end

function Update()
    if (bar~=nil) then
        bar:Update()
    end
end

-- 设置等级
function SetCLv(_lv)
    _lv = _lv or 1
    CSAPI.SetText(txtLv1, string.format("%d", _lv))
end
function SetCExp(curExp, curmaxExp)
    CSAPI.SetText(txtExp, string.format("<color=#ffffff>%s</color><color=#929296>/%s</color>", curExp, curmaxExp))
    slider.value = curExp / curmaxExp
end

-- data -》{CRoleInfo,oldLv,oldExp}
function OnOpen()
    cRoleData = data[1]
    oldLv = data[2]
    oldExp = data[3]

    -- child
    SetRole(roleItem1, childParent1)
    SetRole(roleItem2, childParent2)
    -- lv
    CSAPI.SetText(txtLv1, oldLv .. "")
    CSAPI.SetText(txtLv2, cRoleData:GetLv() .. "")
    -- exp
    SetExp()
    -- bar 
    bar:Show(oldLv, oldExp, addExp)
end

function SetRole(roleItem, childParent)
    if (not roleItem) then
        ResUtil:CreateUIGOAsync("CRoleItem/MatrixRole", childParent, function(go)
            roleItem = ComUtil.GetLuaTable(go)
            roleItem.SetIcon(cRoleData:GetBaseIcon())
        end)
    else
        roleItem.SetIcon(cRoleData:GetBaseIcon())
    end
end

function SetExp()
    local curMaxExp = Cfgs.CfgCardRoleUpgrade:GetByID(oldLv).mExp
    CSAPI.SetText(txtExp, string.format("<color=#ffffff>%s</color><color=#929296>/%s</color>", oldExp, curMaxExp))
    slider.value = curExp / maxExp
end

function OnClickMask()
    view:Close()
end
