local ExpeditionComponent = BaseClass("ExpeditionComponent", Component)
local base = Component

local function Awake(self)
    base.Awake(self)
    self.selectCardInfo = {[1] = {},[2] = {},[3] = {},[4] = {},[5] = {},[6] = {},[7] = {},[8] = {},[9] = {},[10] = {}}
    self.AllSelectData = {}
    self.selectItem = 1
    self.leftCount = 10
    self.canGetCount = 3
end

local function SetSelectItem(self,param)
    self.selectItem = param
end

local function GetSelectItem(self)
    return self.selectItem
end

local function SetSelectCardData(self,key,cardInfo)
    table.insert(self.selectCardInfo[key],cardInfo)
end

local function GetSelectCardData(self,key)
    if key then
        return self.selectCardInfo[key]
    else
        return self.selectCardInfo
    end
end

local function RemoveSelectCardData(self,key)
    self.selectCardInfo[key] = {}
end

local function TableToStr(t, bArry)
    if t == nil then
        return ""
    end
    local retstr = "{"
    local function ToStringEx(value)
        if type(value) == "table" then
            return TableToStr(value)
        elseif type(value) == "string" then
            return '"' .. value .. '"'
        else
            return tostring(value)
        end
    end
    local i = 1
    for key, value in pairs(t) do
        local signal = ","
        if i == 1 then
            signal = ""
        end
        if bArry then
            retstr = retstr .. signal .. ToStringEx(value)
        else
            if type(key) == "number" or type(key) == "string" then
                retstr = retstr .. signal .. "[" .. ToStringEx(key) .. "]=" .. ToStringEx(value)
            else
                if type(key) == "userdata" then
                    retstr =
                        retstr .. signal .. "*s" .. TableToStr(getmetatable(key)) .. "*e" .. "=" .. ToStringEx(value)
                else
                    retstr = retstr .. signal .. key .. "=" .. ToStringEx(value)
                end
            end
        end
        i = i + 1
    end
    retstr = retstr .. "}"
    return retstr
end

local function StrToTable(str)
    if str == nil or type(str) ~= "string" or str == "" then
        return {}
    end
    return load("return " .. str)()
end

local function SetExpeditationCardInfo(self,tab)
    local str = TableToStr(tab)
	if str ~= nil then
		PlayerPrefs.SetString("ExpeditationCardInfo",str)
	end
end

local function GetExpeditationCardInfo(self)
	return StrToTable(PlayerPrefs.GetString("ExpeditationCardInfo"))
end

local function SetExpeditationTaskInfo(self,tab)
    local str = TableToStr(tab)
	if str ~= nil then
		PlayerPrefs.SetString("ExpeditationTaskInfo",str)
	end
end

local function GetExpeditationTaskInfo(self)
	return StrToTable(PlayerPrefs.GetString("ExpeditationTaskInfo"))
end

local function Dispose(self)
    base.Dispose(self)
end

ExpeditionComponent.Awake = Awake
ExpeditionComponent.SetSelectItem = SetSelectItem
ExpeditionComponent.GetSelectItem = GetSelectItem
ExpeditionComponent.SetSelectCardData = SetSelectCardData
ExpeditionComponent.GetSelectCardData = GetSelectCardData
ExpeditionComponent.RemoveSelectCardData = RemoveSelectCardData
ExpeditionComponent.SetExpeditationCardInfo = SetExpeditationCardInfo
ExpeditionComponent.GetExpeditationCardInfo = GetExpeditationCardInfo
ExpeditionComponent.SetExpeditationTaskInfo = SetExpeditationTaskInfo
ExpeditionComponent.GetExpeditationTaskInfo = GetExpeditationTaskInfo
ExpeditionComponent.Dispose = Dispose


return ExpeditionComponent
