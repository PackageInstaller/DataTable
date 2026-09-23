local sectionData = nil
local cb = nil
local enterCB = nil
local eTime = nil
local lastTime = 0

function Awake()
    CSAPI.SetGOActive(selObj,false)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Update()
    if eTime and eTime > 0 then
        local time = math.modf(eTime / 86400)   
        if lastTime ~= time then
            SetTime(time .. LanguageMgr:GetByID(11010))
        end
    end
end

function Refresh(_data, elseData)
    sectionData = _data
    enterCB = elseData
    if sectionData then
        SetTitle(sectionData:GetName())
       
        local numStr = ""
        if sectionData:GetType() == SectionActivityType.Tower then
            local cur = 0
            local max = 0
            local cfgTowers = Cfgs.MainLine:GetGroup(sectionData:GetID())            
            if cfgTowers then
                local time = TimeUtil:GetTime()
                for k, v in pairs(cfgTowers) do
                    if v.nEndTime then
                        local _time =GCalHelp:GetTimeStampBySplit(v.nEndTime) - time
                        if not eTime then
                            eTime = _time
                        else
                            eTime = eTime > _time and _time or eTime
                        end
                    end
                    if DungeonMgr:IsDungeonOpen(v.id) then
                        cur = cur + 1
                    end
                    max = max + 1
                end
            end
            cur = StringUtil:SetByColor(cur,"ffffff")
            numStr = cur .."/" ..max
        end
        SetNum(numStr)
        CSAPI.SetGOActive(timeObj, eTime and eTime>0)
    end
end

function SetTitle(str)
    CSAPI.SetText(txtTitle,str)
end

function SetNum(str)
    CSAPI.SetText(txtNum,str)
end

function SetTime(str)
    CSAPI.SetGOActive(timeObj,str ~= "")
    CSAPI.SetText(txtTime,str)
end

function SetSelect(b)
    CSAPI.SetGOActive(nolObj,not b)
    CSAPI.SetGOActive(selObj,b)
end

function GetData()
    return sectionData 
end

function OnClickEnter()
    if enterCB then
        enterCB(this)
    end
end

function OnClick()
    if cb then
        cb(this)
    end
end
