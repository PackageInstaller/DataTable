local data = nil
local datas = {}
local items = nil
local imgGos = {}

function Awake()
    local trans = imgObj.transform
    for i = 0 ,9 do
        table.insert(imgGos,trans:GetChild(i).gameObject)
    end
end

function Refresh(_data)
    data = _data
    if data then
        datas = data:GetMonsterInfos()
        SetItems()
    end
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("Tower/TowerFocusItem",items,datas,parent,OnItemClickCB,nil,{isPass = data:IsPass()},SetImgs)
end

function OnItemClickCB(item)
    local enemyIDs = data:GetPreView()
    local list = {}
    if datas and #datas> 0 then
        for i, v in ipairs(datas) do
            local cfg = Cfgs.MonsterData:GetByID(enemyIDs[i])
            table.insert(list,{
                id = cfg.id,
                isBoss = cfg.isboss ~= nil,
                isSel = i == item.index,
                isDead = items[i].IsDead()
            })
        end
    end
    if #list>0 then
        CSAPI.OpenView("FightEnemyInfo", list);
    end
end

function IsDead(index,cid)
    if datas and #datas > 0 then
        for i, v in ipairs(datas) do
            if cid == v.cfg.id and index == i then
                return v.hp <= 0
            end
        end
    end
end

function GetCardID(cfgMonster)
    if cfgMonster and datas and #datas > 0 then
        for i, v in ipairs(datas) do
            if cfgMonster.card_id == v.cfg.id then
                
            end
        end
    end
end

function SetImgs()
    for i, v in ipairs(imgGos) do
        CSAPI.SetGOActive(v.gameObject,true)
    end
    local pos = data:GetMonsterPos()
    if #items> 0 and pos then
        local girds = nil
        local name = ""
        for i, v in ipairs(items) do
            if v.gameObject.activeSelf == true then
                if pos[i] then
                    v.SetPos(pos[i])
                end
                girds = v.GetGridPos()
                if #girds > 0 then
                    for k, m in ipairs(girds) do
                        name = "img" ..(m[1] - 1) .. "_" .. (m[2] - 1)
                        if not IsNil(this[name]) then
                            CSAPI.SetGOActive(this[name].gameObject, false)
                        end
                    end
                end
            end
        end
    end
end