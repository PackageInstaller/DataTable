local panelIndex = 1

function Awake()
    fade = ComUtil.GetCom(gameObject, "ActionFade")
    fade1 = ComUtil.GetCom(goShaderRaw, "ActionFade")
    UIMaskGo = CSAPI.GetGlobalGO("UIClickMask")
end

function OnInit()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Exercise_End, function()
        view:Close()
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
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
    if (panelIndex == 1) then
        panelIndex = 2
        local socre = ExerciseRMgr:GetProto().score or 0
        local rankLe = GCalHelp:CalFreeMatchRankLv(socre)
        local cfg1 = Cfgs.CfgPvpRankLevel:GetByID(rankLe)
        local cfg2 = Cfgs.CfgPvpRankLevel:GetByID(data[2])
        CSAPI.SetText(txtL2, cfg2.name)
        CSAPI.SetText(txtL1, data[1] .. "")
        CSAPI.SetText(txtR2, cfg1.name)
        CSAPI.SetText(txtR1, socre.."")
    else
        fade:Play(1, 0, 167, 0, function()
            view:Close()
        end)
    end
end

function OnClickMask()
    if not isCanBack then
        return
    end
    SetPanel()
end

function AnimStart()
    CSAPI.SetGOActive(UIMaskGo, true)
end

function AnimEnd()
    CSAPI.SetGOActive(UIMaskGo, false)
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    OnClickMask()
end
