local data = nil
local cfg = nil
local infos = nil
local lines = {}
local items = nil

function Awake()
    if line and not IsNil(line.gameObject) then
        table.insert(lines,line.gameObject)
    end
end

function SetIndex(idx)
    index = idx
end

function Refresh(_data)
    data = _data
    cfg = data and data.cfg
    if cfg then
        infos = cfg.infos or {}
        SetTitle()
        SetNum()
        SetLine()
        SetItems()
        SetHeight()
    end
end

function SetTitle()
    CSAPI.SetText(txtTitle,cfg.name or "")
end

function SetNum()
    local cur,max = 0,#infos
    if #infos> 0 then
        for i, v in ipairs(infos) do
            if BagMgr:GetCount(v.item_id) > 0 then
                cur = cur + 1
            end
        end
    end
    CSAPI.SetText(txtNum,cur.."/"..max)
end

function SetLine()
    if #lines > 0 then
        for i, v in ipairs(lines) do
            CSAPI.SetGOActive(v,false)
        end
    end

    local count = math.ceil(#infos/5)
    for i = 1, count do
        if lines[i] then
            CSAPI.SetGOActive(lines[i],true)
        else
            local go = CSAPI.CloneGO(lines[1],lineObj.transform)
            lines[i] = go
        end
    end
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("Archive4/ArchiveBiteItem2",items,infos,grid,OnItemClickCB)
end

function OnItemClickCB(item)
    local info = infos[item.index]
    if info and info.board_id then
        CSAPI.OpenView("MulPictureView", {id=info.board_id,showMask=true})
    end
end

function SetHeight()
    CSAPI.SetRTSize(gameObject,1822,data:GetSize())
end