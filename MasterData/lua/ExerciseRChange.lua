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

    b1, data1 = ExerciseRMgr:IsRankBreak()
    b2, data2 = ExerciseRMgr:IsDWBreak()
    panelIndex = b1 and 1 or 2
    SetPanel()
end

function SetPanel()
    if (panelIndex == 1) then
        CSAPI.SetGOActive(panel1, true)
        CSAPI.SetGOActive(panel2, false)
        SetPanel1()
    elseif (panelIndex == 2) then
        CSAPI.SetGOActive(panel1, false)
        CSAPI.SetGOActive(panel2, true)
        SetPanel2()
    else
        fade:Play(1, 0, 167, 0, function()
            view:Close()
        end)
    end
end

function SetPanel1()
    LanguageMgr:SetText(txtTitle1, 33014)
    -- LanguageMgr:SetEnText(txtTitle2, 33014)
    CSAPI.SetText(txtMIddle1, data1[1] .. "")
    local add = data1[2] - data1[1]
    LanguageMgr:SetText(txtDesc1, 33015, add, data1[1])

    panelIndex = b2 and 2 or 3
end

function SetPanel2()
    LanguageMgr:SetText(txtTitle1, 33016)
    -- LanguageMgr:SetEnText(txtTitle2, 33016)
    local cfg = Cfgs.CfgPvpRankLevel:GetByID(data2)
    if (cfg.icon) then
        ResUtil.ExerciseGrade:Load(imgGrade, cfg.icon, true)
    end
    CSAPI.SetText(txtMIddle3, cfg.name .. "")
    -- 
    local itemDatas = GridUtil.GetGridObjectDatas2(cfg.jAward)
    items = items or {}
    ItemUtil.AddItems("Grid/GridItem", items, itemDatas, glg, GridClickFunc.OpenInfoSmiple)
    panelIndex = 3
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
