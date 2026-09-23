local items = nil
local isShowJump = false

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

-- data:DungeonGroupData
function Refresh(_data)
    data = _data
    if data then
        SetText()
        SetGrids()
        SetBtn()
    end
end

function SetText()
    LanguageMgr:SetText(txtDesc, 130036, data:GetName())
end

function SetGrids()
    local cfg = data:GetCfg()
    local datas = {}
    local elseDatas = {}
    if cfg then
        local goals = TowerMgr:GetTowerDeepGoals(cfg.id)
        local cur, max = 0, 0
        for i = 1, 3 do
            if cfg["Reward" .. i] then
                for k, m in ipairs(cfg["Reward" .. i]) do
                    local item = nil;
                    if m[3] == nil then
                        m[3] = RandRewardType.ITEM
                    end
                    if m[3] == RandRewardType.ITEM then
                        item = GoodsData({
                            id = m[1],
                            num = m[2]
                        });
                    elseif m[3] == RandRewardType.EQUIP then
                        item = EquipData();
                        item:InitCfg(m[1]);
                    elseif m[3] == RandRewardType.CARD then
                        item = RoleMgr:GetFakeData(m[1], m[2])
                        item:InitCfg(m[1]);
                    end
                    table.insert(datas, item)
                    table.insert(elseDatas, {
                        isPass = goals and goals[i].isComplete
                    })
                end
                cur = (goals and goals[i].isComplete) and cur + 1 or cur
                max = max + 1
            end
        end
        isShowJump = max ~= 0 and cur < max or false
    end
    items = items or {}
    if #items > 0 then
        for i, v in ipairs(items) do
            CSAPI.SetGOActive(v.gameObject, false)
        end
    end
    if #datas > 0 then
        for i, v in ipairs(datas) do
            if items[i] then
                CSAPI.SetGOActive(items[i].gameObject, true)
                items[i].Refresh(v, elseDatas[i])
            else
                ResUtil:CreateUIGOAsync("DungeonDetail/DungeonGoodsItem", gridNode, function(go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.Refresh(v, elseDatas[i])
                    items[i] = lua
                end)
            end
        end
    end
end

function SetBtn()
    CSAPI.SetGOActive(btnJump, isShowJump)
end

function OnClickJump()
    if cb then
        cb(this)
    end
end

