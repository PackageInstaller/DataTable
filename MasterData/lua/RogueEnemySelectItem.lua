local canClick = nil

function Awake()
    animator = ComUtil.GetComInChildren(gameObject, "Animator")
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_index)
    index = _index

    canClick = true
end

function SetDetail(mainLineID)
    local mainLineCfg = Cfgs.MainLine:GetByID(mainLineID)
    local monsterGroupCfg = Cfgs.MonsterGroup:GetByID(mainLineCfg.enemyPreview[1])
    local monsterCfg = Cfgs.MonsterData:GetByID(monsterGroupCfg.monster)
    local modelCfg = Cfgs.character:GetByID(monsterCfg.model)
    ResUtil.CardIcon:Load(icon,modelCfg.Card_head)
    CSAPI.SetText(txtLv, mainLineCfg.previewLv .. "")
    CSAPI.SetText(txtName1, monsterCfg.name)
end

function SetMonster(mainLineID, isOver)
    canClick = false
    SetDetail(mainLineID)
    CSAPI.SetGOActive(objOver, isOver)
    CSAPI.SetGOActive(objBack, false)
end

function Select()
    CSAPI.SetGOActive(objBack, true)
    animator.enabled = true
end

function OnClick()
    if (canClick) then
        cb(this)
    end
end
