local datas = nil
local currLevel = 1
local items = {}

function Awake()
    if itemParent.transform.childCount > 0 then
        table.insert(items,itemParent.transform:GetChild(0).gameObject)
    end
end

function Refresh(_data,_elseData)
    datas = _data
    currLevel = _elseData or 1
    if datas and #datas > 0 and #items>0 then
        SetItems()
    end
end

function SetItems()
    if #items > 0 then
        for i, v in ipairs(items) do
            CSAPI.SetGOActive(v,false)
        end
    end
    if currLevel > 2 then
        return
    end
    for i, v in ipairs(datas) do
        if #items >= i then
            CSAPI.SetGOActive(items[i],true)
            SetIcon(items[i],i,v:IsOpen())
        else
            local go = nil
            
            if not IsNil(items[1]) then
                CSAPI.SetGOActive(items[1],true)
                if i == 1 then
                    go = items[1]
                else
                    go = CSAPI.CloneGO(items[1],itemParent.transform)
                end
            end
            SetIcon(go,i,v:IsOpen())
            table.insert(items,go)
        end
    end
end

function SetIcon(go,index,isOpen)
    local lineName1 = index % 2 == 0 and 1 or 2
    local lineName2 = currLevel == 1 and 1 or 2
    lineName2 = not isOpen and 3 or lineName2
    CSAPI.LoadImg(go,"UIs/DungeonActivity11/line_0"..lineName1.."_0" .. lineName2 .. ".png",true,nil,true)
    CSAPI.SetAnchor(go,((index - 1) * 411 - 205.5),index % 2 == 0 and -12 or 0)
end
