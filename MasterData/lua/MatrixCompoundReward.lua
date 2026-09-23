-- 副产品获得的奖励界面
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
    -- left 
    local reward1 = data.rewards[1]
    local data1 = {reward1.id, reward1.num}
    item1s = item1s or {}
    ResUtil:CreateCfgRewardGrid(item1s, data1, itemPoint1)
    -- right 
    local datas = {}
    local reward = data.sub_rewards
    for k, v in ipairs(reward) do
        table.insert(datas, {v.id, v.num})
    end
    items = items or {}
    ResUtil:CreateCfgRewardGrids(items, datas, itemPoint2)
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