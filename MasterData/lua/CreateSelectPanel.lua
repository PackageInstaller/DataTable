-- 建造数量选择
local isSet = false

function OnOpen()
    day = TimeUtil:GetTime3("day")
    local dayRecord = PlayerPrefs.GetString(PlayerClient:GetUid() .. data.key, "0")
    if (dayRecord ~= "0" and dayRecord == tostring(day)) then
        isSet = true
    end
    SetDesc()
    SetSelect()
    --
    CSAPI.SetText(txtTitle, LanguageMgr:GetByID(data.titleID))
end

function SetDesc()
    CSAPI.SetText(content, data.content)
end

function SetSelect()
    CSAPI.SetGOActive(select2, isSet)
end

function OnClickSelect()
    if (not isSet) then
        PlayerPrefs.SetString(PlayerClient:GetUid() .. data.key, tostring(day))
    else
        PlayerPrefs.SetString(PlayerClient:GetUid() .. data.key, "0")
    end
    isSet = not isSet
    SetSelect()
end

-- 取消
function OnClickCancel()
    if (data.cancelCallBack) then
        data.cancelCallBack()
    end
    view:Close()
end

-- 建造
function OnClickOK()
    if (data.okCallBack) then
        data.okCallBack()
    end
    view:Close()
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if OnClickCancel then
        OnClickCancel();
    end
end
