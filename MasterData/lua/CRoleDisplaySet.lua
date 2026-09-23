local num = nil
local kbCache = 0 

function OnOpen()
    SetItems(CRoleDisplayMgr:GetSpineInType())
    -- 
    SetKBCache()
end

function SetItems(_num)
    if (num and num == _num) then
        return
    end
    num = _num
    for k = 1, 4 do
        CSAPI.SetGOActive(this["imgSelect" .. k], num == k)
        CSAPI.SetTextColorByCode(this["txtName" .. k .. "1"], num == k and "ffc146" or "ffffff")
        CSAPI.SetTextColorByCode(this["txtName" .. k .. "2"], num == k and "ffc146" or "ffffff")
    end
end

function SetKBCache()
    kbCache = MenuMgr:GetKBCache()
    CSAPI.SetGOActive(imgSelect5, kbCache == 1)
end

function OnClickSelect1()
    SetItems(1)
end
function OnClickSelect2()
    SetItems(2)
end
function OnClickSelect3()
    SetItems(3)
end
function OnClickSelect4()
    SetItems(4)
end
function OnClickMask()
    view:Close()
end

function OnClickS()
    if (num ~= CRoleDisplayMgr:GetSpineInType()) then
        CRoleDisplayMgr:SetSpineInType(num)
    end
    view:Close()
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end

function OnClickSelect5()
    MenuMgr:SetKBCache(kbCache == 1 and 0 or 1)
    SetKBCache()
end
