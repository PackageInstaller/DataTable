---@class LangUtil
local LangUtil = {}
local this = LangUtil
local LangTypeList = {"HK","JA"} -- 公告、邮件、消息，后台发送过来的多语言解析用 

if LangType == nil then
    LangType={
        CN="CN",
        EN="EN",
        JA="JA",
        HK="HK",
    }
end
local currentLang= LangType.CN
local spriteConf = require "Config.Excel.Z_SpriteLang"

local  function FindChildInTransform(root,name)
    local tf= root.transform:Find(name)
    if tf~=nil then
        return tf
    end
    for i=0,root.transform.childCount-1 do
        tf=FindChildInTransform(root.transform:GetChild(i),name)
        if tf~=nil then
            return tf
        end
    end
    return tf
end

--获取当前语言
local function GetLangType()
    return currentLang
end

local function LangRequire(config)
    local suf = GetLangType()
    if string.IsNullOrEmpty(suf) then
        return
    end
    table.walk(config, function (k, tab)
        local temp = {}
        table.walk(tab, function(key, val)
            local splits = string.split(key, "_")
            local name = splits[1]
            local langType = splits[2]
            if table.count(splits) >= 2 and langType == suf then
                --tab[name] = val -- 插入导致出错
                temp[name] = val
            end
        end)
        table.walk(temp, function (key, val)
            tab[key] = val
        end)
    end)
    return config
end

--获取当前时区
local function GetTimeZone()
    local now = os.time()
    return os.difftime(now, os.time(os.date("!*t", now)))/3600
end

--获取当时区与0时区秒
local function GetTimeZoneS()
    local now = os.time()
    return os.difftime(now, os.time(os.date("!*t", now)))
end

--设置当前语言
local function SetLangType()
    currentLang = ClientData:GetInstance().LangName
    table.walk(ExcelConfigs, function (k1, config)
        LangRequire(config)
    end)
    LangUtil.TimeZone=GetTimeZone()
    LangUtil.TimeZoneS=GetTimeZoneS()
end

--服务器带时区的时间戳转成本地时区时间
local function GetCurrentDateTime(ServerTimeS,ServerTimeZoneS)
    local timeZoneD = ServerTimeZoneS - LangUtil.TimeZoneS --计算出服务端时区与客户端时区差值
    return os.date("*t",ServerTimeS + timeZoneD)
end

--服务器UTC时间戳转成本地时区时间
local function GetCurrentDateTimeStamp(ServerTimeStamp)
    return  os.date("%Y-%m-%d  %H:%M",ServerTimeStamp)
end

--服务器时间转换成本地时间
local function GetLangTime(server_time)
    return server_time+LangUtil.TimeZone*3600
end

--服务器时间转换成本地日期
local function GetLangDate(server_time)
    return  os.date("!%Y-%m-%d  %H:%M", GetLangTime(server_time))
end

-- 配置数据  配置中的字段名
local function GetConfLang(conf,name)
    if currentLang ~= LangType.CN then
        name = name.."_"..currentLang
    end
    if conf[name] == nil then
        return "["..name.."]"
    end
    return conf[name]
end

--根据当前语言读取配置表里的语言   配置表  配置ID  配置的字段名
local function GetLang(z_conf,id,name)
    if id == nil then
        return "[nil]"
    end
    if z_conf[id]==nil then
        return "["..id.."]"
    end
    local conf = z_conf[id]
    return GetConfLang(conf,name)
end

--系统的语言配置 Z_SysLang  配置ID
local function GetSysLang(id)
    return GetLang(Z_SysLang, id,"Sys")
end

-- 获取服务器返回错误
local function GetServerError(code)
    if Z_ErrorCode[code]==nil then
        return "ErrorCode:".."["..code.."]"
    end
    local conf = Z_ErrorCode[code]
    return GetConfLang(conf, "Content")
end

--根据当前语言读取配置表里的语言   配置表  配置ID  配置的字段名 获取Sprite 回调
local function GetSpriteLang(id,callback)
    local path="UI/LangChg_"..currentLang.."/"..GetLang(spriteConf,id,"Path")
    AtlasManager:LoadImageAsync(nil, path..".png",callback)
end
--根据当前语言 获取Sprite
local function GetSpriteByName(str, callback)
    local path="UI/LangChg_"..currentLang.."/".. str
    AtlasManager:LoadImageAsync(nil, path..".png",callback)
end

--根据当前语言处理并返回GameObject(中文GO,英文GO,日文GO)
local function LangGameObject(CN,EN,JA,HK)
    local o={}
    o[LangType.CN]=CN
    o[LangType.EN]=EN
    o[LangType.JA]=JA
    o[LangType.HK]=HK
    local go
    table.walk(o,function (k,v)
        if k==currentLang then
            v.gameObject:SetActive(true)
            go=v
        else
            v.gameObject:SetActive(false)
        end
    end)
    if not go then--todo 替换
        go = CN
        go.gameObject:SetActive(true)
    end
    o=nil
    return go
end

--根据当前语言处理并返回GameObject, root=transform  name=root下面go的不带后缀的名字
--真实名字，不带后缀或带_CN为中文，带_EN为英文，带_JA为日语
local function LangGameObjectByName(root,name)
    local CN= FindChildInTransform(root,name)
    if CN==nil then
        CN= FindChildInTransform(root,name.."_CN")
    end
    local EN=FindChildInTransform(root,name.."_EN")
    local JA=FindChildInTransform(root,name.."_JA")
    local HK=FindChildInTransform(root,name.."_HK")
    return LangGameObject(CN,EN,JA,HK)
end

local function LangTextByName(root,name)--后面不用了,替换
    root = root.transform
    local text = {}
    text[1] = FindChildInTransform(root, name)
    if text[1] == nil then
        text[1] = FindChildInTransform(root, name .. "_CN")
    end
    if text[1] ~= nil then
        text[1] = text[1]:GetComponent(typeof(UE_UI.Text))
    end
    text[2] = FindChildInTransform(root, name .. "_EN")
    if text[2] ~= nil then
        text[2] = text[2]:GetComponent(typeof(UE_UI.Text))
    end
    text[3] = FindChildInTransform(root, name .. "_JA")
    if text[3] ~= nil then
        text[3] = text[3]:GetComponent(typeof(UE_UI.Text))
    end
    local temp
    for _, v in pairs(text) do
        if v then
            v.gameObject:SetActive(false)
            temp = v
        end
    end
    temp.gameObject:SetActive(true)
    text = nil
    return this.BindText(temp)
end

local function GetLangName(name)
    local type = GetLangType()
    local suf = ""
    if type == LangType.JA then
        suf = suf.."_JA"
    elseif type == LangType.EN then
        suf = suf.."_EN"
    elseif type == LangType.HK then
        suf = suf.."_HK"
    end
    return name..suf
end

if FontType == nil then
    FontType = {
        All_Number = "方正特雅宋_GBK.TTF", -- 粗体
        All_Dialog = "FOT-SkipPro-D.otf", -- 剧情
        --All_DialogTitle = "FOT-SkipStd-B.otf", -- 剧情标题

        CN_Word = "方正特雅宋_GBK.TTF" ,
        --CN_Number = "SourceHanSerifCN-Bold.otf",
        JA_Word = "FOT-MatisseProN-DB.otf",
        --JA_Number = "FOT-MatisseProN-EB.otf",
        HK_Word = "方正特雅宋_GBK.TTF",
        --HK_Number = "SourceHanSerifCN-Bold.otf",
        EN_Word = "",
        EN_Number = "",
    }
end

local FontRes = {}

-- 字体常驻   字体资源加载 
local function LoadFonts()
    table.walk(FontType, function (k, v)
        if not string.IsNullOrEmpty(v) then
            if string.endswith(v, ".otf") then
                if FontRes[v] == nil then
                    FontRes[v] = ResourcesManager:GetInstance():CoLoadAsync(PathUtil.Path_Language..v, typeof(CS.UnityEngine.Font))
                end
            end
        end
    end)
end

-- 获取字体资源
local function GetFont(fontName)
    if FontRes[fontName] == nil then
        FontRes[fontName] = ResourcesManager:GetInstance():CoLoadAsync(PathUtil.Path_Language..fontName, typeof(CS.UnityEngine.Font))
    end
    return FontRes[fontName]
end

-- 多语言文字映射
local function GetSystemLang(text)
    local key = "Sys_"..GetLangType()
    local lang = nil
    table.walk(Z_SysLang, function(k, v)
        if v["Sys"] == text or v["Sys_JA"] == text or v["Sys_EN"] == text or v["Sys_CN"] == text or v["Sys_HK"] == text then
            lang = v[key]
        end
    end)
    return lang
end

isCheckLang = false
BindMap = {}

-- 参数1：需要多语言的gameobject， 
-- 参数2：不传参数，默认使用文本字体，其它字体需要对单种语言手动设置
-- 参数2：1.FontType.All_Number   所有字体默认使用数字字体
-- 参数2：1.FontType.CN_Number  只有中文使用数字字体
-- 参数2：1.FontType.CN_Number  FontType.JA_Number  中文和日文使用数字字体   
---@return UnityEngine.UI.Text
local function BindText(gameObject, ...)
    if IsNull(gameObject) then
        Logger.LogError("LangUtil.BindText：gameObject is nil")
        return
    end

    if isCheckLang then
        table.insert(BindMap, gameObject.gameObject)
        local text = gameObject.gameObject:GetComponent("Text")
        text.color = Color.New(0,1,0)
        text.text = "<color=green>"..text.text.."</color>"
    end

    local langType = GetLangType()
    local fontName = nil
    if langType == LangType.CN then
        fontName = FontType.CN_Word
    elseif langType == LangType.JA then
        fontName = FontType.JA_Word
    elseif langType == LangType.EN then
        fontName = FontType.EN_Word
    elseif langType == LangType.HK then
        fontName = FontType.HK_Word
    end
    local fonts = ...
    if fonts ~= nil then
        if type(fonts) == "string" then
            if fonts == FontType.All_Number then
                if langType == LangType.CN then
                    fontName = FontType.CN_Word
                elseif langType == LangType.JA then
                    fontName = FontType.JA_Word
                elseif langType == LangType.EN then
                    fontName = FontType.EN_Word
                elseif langType == LangType.HK then
                    fontName = FontType.HK_Word
                end
                --if langType == LangType.CN then
                --	fontName = FontType.CN_Number
                --elseif langType == LangType.JA then
                --	fontName = FontType.JA_Number
                --elseif langType == LangType.EN then
                --	fontName = FontType.EN_Number
                --elseif langType == LangType.HK then
                --	fontName = FontType.HK_Number
                --end
                --elseif fonts == FontType.All_DialogTitle then
                --	fontName = FontType.All_DialogTitle
            elseif fonts == FontType.All_Dialog then
                fontName = FontType.All_Dialog
            else
                table.walk(FontType, function (key, val)
                    if val == fonts then
                        if (string.startswith(key, "CN") and langType == LangType.CN) or
                                (string.startswith(key, "JA") and langType == LangType.JA) or
                                (string.startswith(key, "EN")  and langType == LangType.EN) or
                                (string.startswith(key, "HK")  and langType == LangType.HK) then
                            fontName = val
                        end
                    end
                end)
            end
        else -- 这个没啥用（没个语言设置特定字体时使用）
            if table.count(fonts) > 0 then
                table.walk(fonts, function (k, v)
                    table.walk(FontType, function (key, val)
                        if val == v then
                            if (string.startswith(key, "CN") and langType == LangType.CN) or
                                    (string.startswith(key, "JA") and langType == LangType.JA) or
                                    (string.startswith(key, "EN")  and langType == LangType.EN) or
                                    (string.startswith(key, "HK")  and langType == LangType.HK)then
                                fontName = v
                            end
                        end
                    end)
                end)
            end
        end
    end

    -- 动态获取对应的字体
    local font = GetFont(fontName)
    local text = gameObject.gameObject:GetComponent("Text")
    if IsNull(text) then
        Logger.LogError("LangUtil.BindText：gameObject is not Text.  gameObject.name = "..gameObject.name)
        return
    end
    text.font = font
    -- if tostring(text.fontStyle) == "Normal: 0" or tostring(text.fontStyle) == "Bold: 1" then
    --     text.fontStyle = (fonts ~= FontType.All_Number and fonts ~= FontType.All_Dialog) and 0 or 1
    -- else
    --     text.fontStyle = (fonts ~= FontType.All_Number and fonts ~= FontType.All_Dialog) and 2 or 3
    -- end

    if not string.IsNullOrEmpty(text.text) then
        -- 预制体的中文映射成其他语言, ***最好是自己赋值***
        local t = GetSystemLang(text.text)
        if not string.IsNullOrEmpty(t) then
            text.text = t
        end
    end
    return text
end

LangUtil.LoadFonts=LoadFonts
LangUtil.GetFont=GetFont
LangUtil.GetSystemLang=GetSystemLang
LangUtil.BindText=BindText
LangUtil.LangGameObject=LangGameObject
LangUtil.LangGameObjectByName= LangGameObjectByName
LangUtil.LangTextByName=LangTextByName
LangUtil.GetLangName=GetLangName
LangUtil.SetLangType = SetLangType
LangUtil.GetSysLang = GetSysLang
LangUtil.GetConfLang = GetConfLang
LangUtil.GetLang = GetLang
LangUtil.GetSpriteLang=GetSpriteLang
LangUtil.GetSpriteByName=GetSpriteByName
LangUtil.GetLangTime=GetLangTime
LangUtil.GetLangDate=GetLangDate
LangUtil.GetCurrentDateTimeStamp=GetCurrentDateTimeStamp
LangUtil.GetCurrentDateTime=GetCurrentDateTime
LangUtil.GetLangType = GetLangType
LangUtil.LangRequire = LangRequire
LangUtil.GetServerError = GetServerError
LangUtil.LangTypeList = LangTypeList

---@return LangUtil
return ConstClass("LangUtil", LangUtil)