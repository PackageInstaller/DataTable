-- 解禁成功界面
local showIndex = 1

function Awake()
    fade = ComUtil.GetCom(gameObject, "ActionFade")
    fade1 = ComUtil.GetCom(goShaderRaw, "ActionFade")
    UIMaskGo = CSAPI.GetGlobalGO("UIClickMask")
end

function OnOpen()
    -- music
    CSAPI.PlayUISound("ui_getitems")

    -- fade
    fade1:Play(0, 1, 167, 600, function()
        CSAPI.SetGOActive(bg1, false)
        CSAPI.SetGOActive(black, false)
        CSAPI.SetGOActive(shaderObj, true)
        isCanBack = true
    end)

    SetPanel()
end

function SetPanel()
    CSAPI.PlayUISound("ui_core_upgrade")
    -- 
    SetItems()
    -- 
    RoleMgr:AddJieJinDatas(nil)
end

function SetItems()
    -- 假的卡牌数据，大概获取即可，不用真实的数据
    local cardDatas = {} --
    local leader = RoleMgr:GetLeader()
    local jiejinDatas = RoleMgr:GetJieJinDatas()
    if (jiejinDatas) then
        if (jiejinDatas.open_cards) then
            for k, v in pairs(jiejinDatas.open_cards) do
                local newInfo = {}
                newInfo = table.copy(leader:GetData())
                newInfo.cfgid = v
                newInfo.open_cards = nil
                newInfo.open_mechas = nil
                newInfo.skin = nil
                newInfo.skin_a = nil
                local cardData = CharacterCardsData(newInfo)
                table.insert(cardDatas, cardData)
            end
        end
        if (jiejinDatas.open_mechas) then
            for k, v in pairs(jiejinDatas.open_mechas) do
                local monsterID = RoleTool.GetMonsterIDBySkillID(v)
                local monsterCfg = Cfgs.MonsterData:GetByID(monsterID)
                local newInfo = {}
                newInfo = table.copy(leader:GetData())
                newInfo.cfgid = monsterCfg.card_id
                newInfo.open_cards = nil
                newInfo.open_mechas = nil
                newInfo.skin = nil
                newInfo.skin_a = nil
                local cardData = CharacterCardsData(newInfo)
                table.insert(cardDatas, cardData)
            end
        end
    end
    items = items or {}
    ItemUtil.AddItems("RoleCard/RoleCard", items, cardDatas, grids, nil, 1, {
        isJieJin = true,
        isAnimEnd = true
    })
end

function OnClickMask()
    if not isCanBack then
        return
    end
    fade:Play(1, 0, 167, 0, function()
        view:Close()
    end)
end
function AnimStart()
    CSAPI.SetGOActive(UIMaskGo, true)
end

function AnimEnd()
    CSAPI.SetGOActive(UIMaskGo, false)
end
