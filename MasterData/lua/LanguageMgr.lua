-- 多语言
LanguageMgr = {}
local this = LanguageMgr


---this.mLocalLanguageType =1;---5.0之前使用
this.mLocalLanguageType =CSAPI.GetDefaultLanguageIndex();---5.0或者5.0以启用

function this:Init()
    if (self.mgr == nil) then
        self.mgr = CS.LanguageMgr.ins
        self.mgr:Init("CfgLanguage")
        self.mLocalLanguageType = self.mgr:ReadLocalLanguageType()
    end
    return self.mgr
end

function this:GetMgr()
    return self:Init()
end

-- 改变全局多语言
function this:ChangeLanguage(num)
    self.mLocalLanguageType = num 
    self:GetMgr():ChangeLanguageType(num)
end

-- 获取文本
function this:GetByType(id, type, ...)
    id = id .. ""
    if (StringUtil:IsEmpty(id)) then
        LogError("CfgLanguageTips can't id:" .. id)
        return
    end
    local cfg = Cfgs.CfgLanguage:GetByID(id)
    local str = cfg and cfg["language" .. type] or ""
    if (str and ...) then
        str = string.format(str, ...)
    end
    return str
end

-- 获取文本
function this:GetByID(id, ...)
    id = id .. ""
    if (StringUtil:IsEmpty(id)) then
        LogError("CfgLanguageTips can't id:" .. id)
        return
    end
    local cfg = Cfgs.CfgLanguage:GetByID(id)
    local str = cfg and cfg["language" .. self.mLocalLanguageType] or ""
    if (str and ...) then
        str = string.format(str, ...)
    end
    return str
end

-- 设置多语言文本
function this:SetText(go, id, ...)
    id = id
    local str = self:GetByID(id)
    if (str and ...) then
        str = string.format(str, ...)
    end
    CSAPI.csSetTranText(go, str)
end

-- 设置英文
function this:SetEnText(go, id, ...)
    id = id
    local str = self:GetByType(id, 4)
    if (str and ...) then
        str = string.format(str, ...)
    end
    CSAPI.csSetTranText(go, str)
end

-- 获取提示文本
function this:GetTips(id, ...)
    if (StringUtil:IsEmpty(id)) then
        Log("id is nil")
        return
    end
    local cfg = Cfgs.CfgLanguageTips:GetByID(id)
    local str = cfg and cfg["language" .. self.mLocalLanguageType] or ""
    if (str and ...) then
        str = string.format(str, ...)
    end
    return str
end

-- 弹出提示
function this:ShowTips(id, ...)
    if (StringUtil:IsEmpty(id)) then
        Log("id is nil")
        return
    end
    local cfg = Cfgs.CfgLanguageTips:GetByID(id)
    local str = cfg and cfg["language" .. self.mLocalLanguageType] or ""
    if (str and ...) then
        str = string.format(str, ...)
    end
    Tips.ShowTips(str)
end

-- 切换语言
function this:ToChangeLanguage(toType)
    local lanIDs = {14092, 14093, 14096, 14095, 14092, 14094} -- 简体，繁体，英文，日文，韩文，俄文
    local curType = CSAPI.GetDefaultLanguageIndex()
    if (curType ~= toType) then
        local str = self:GetByID(lanIDs[toType] or 14092)
        local dialogdata = {}
        dialogdata.content = self:GetTips(7014, str)
        dialogdata.okText = self:GetByID(14098)
        dialogdata.okText2 = self:GetByType(14098,4)
        dialogdata.okCallBack = function()
            self:ChangeLanguage(toType)
            UnityEngine.Application.Quit()
        end
        CSAPI.OpenView("Dialog", dialogdata)
    end
end

return this
