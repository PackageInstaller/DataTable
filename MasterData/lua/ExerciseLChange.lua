-- {_addRankNum, _isRankLevelUp, _addCoin}
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
    if (data[1] > 0) then
        CSAPI.SetGOActive(panel1, true)
        CSAPI.SetGOActive(panel2, false)
        SetPanel1()
        return
    end
    if (data[2]) then
        CSAPI.SetGOActive(panel1, false)
        CSAPI.SetGOActive(panel2, true)
        SetPanel2()
        return
    end

    if (data[3] > 0) then
        SetCoin()
    end

    fade:Play(1, 0, 167, 0, function()
        view:Close()
    end)
end

function SetPanel1()
    LanguageMgr:SetText(txtTitle1, 33014)
    LanguageMgr:SetEnText(txtTitle2, 33014)

    local _addRankNum = data[1]
    local _rank = ExerciseMgr:GetRank()
    CSAPI.SetText(txtMIddle1, _rank .. "")
    LanguageMgr:SetText(txtDesc1, 33015, _addRankNum, _rank)
    data[1] = 0
end

function SetPanel2()
    LanguageMgr:SetText(txtTitle1, 33016)
    LanguageMgr:SetEnText(txtTitle2, 33016)

    local level = ExerciseMgr:GetRankLevel()
    local cfg = Cfgs.CfgPracticeRankLevel:GetByID(level)
    if (cfg.icon) then
        ResUtil.ExerciseGrade:Load(imgGrade, cfg.icon, true)
    end
    CSAPI.SetText(txtMIddle3, cfg.name .. "")
    CSAPI.SetText(txtReward2, "X" .. cfg.nGetCoin)
    data[2] = false
end

function SetCoin()
    local _data = {
        id = g_ArmyCoinId,
        type = RandRewardType.ITEM,
        num = data[3]
    }
    UIUtil:OpenReward({{_data}})
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