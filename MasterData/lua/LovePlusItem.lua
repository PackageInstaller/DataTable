local data = nil
local isOpen = false
local iconItem = nil

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

--LovePlusData  
function Refresh(_data,_elseData)
    data = _data
    if data then
        isOpen = data:IsOpen()
        CSAPI.SetGOActive(lockObj, not isOpen)
        CSAPI.SetGOActive(nolObj, isOpen)    
        if isOpen then
            SetIcon()
            SetText()
            SetRed()
            -- SetPrograss()
        end
    end
end

function SetIcon()
    local currCfg = nil
    local imgCfgs= data:GetImgCfgs()
    if imgCfgs and #imgCfgs > 0 then
        for i, v in ipairs(imgCfgs) do
            if LovePlusMgr:IsOpen(eLovePlusUnLockType.Img,v.id) then
                if not currCfg then
                    currCfg = v
                elseif currCfg.id > v.id then
                    currCfg = v
                end
            end
        end
    end
    if currCfg then
        if iconItem then
            iconItem.Refresh(currCfg,data:GetID())
        else
            ResUtil:CreateUIGOAsync("LovePlus/LovePlusImg",iconParent,function (go)
                local lua= ComUtil.GetLuaTable(go)
                lua.Refresh(currCfg,data:GetID())
                iconItem = lua
            end)
        end
    end
end

function SetText()
    CSAPI.SetText(txtName,data:GetName())
    -- CSAPI.SetText(txtTitle,data:GetTitle())
end

function SetPrograss()
    CSAPI.SetText(txtPrograss,data:GetPrograss() .. "%")
end

function SetRed()
    UIUtil:SetRedPoint(redParent,LovePlusMgr:CheckRed(data:GetID()))
end

function OnClick()
    if cb then
        cb(data)
    end
end

