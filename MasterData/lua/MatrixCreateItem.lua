local timer = 0

function Refresh(_data)
    cfg = _data[1]
    canCreate = _data[2]
    tipStr = _data[3]
    buildData = MatrixMgr:GetBuildingDataByType(cfg.type)

    -- name
    CSAPI.SetText(txtName1, cfg.name or "")
    CSAPI.SetText(txtName2, cfg.name_en or "")

    -- desc
    CSAPI.SetText(txtDesc, cfg.explanation or "")

    SetIcon()
    SetLv()
    SetBtn()
    SetPos()

    SetRed()
end

function SetRed()
    local isRed = false
    if (buildData) then
        isRed = buildData:CheckCanUp()
    else
        isRed = MatrixMgr:CheckHadBuildByID(cfg)
    end
    UIUtil:SetRedPoint(node, isRed, 183.8, 363.8, 0)
end

function Update()
    if (runTime) then
        timer = timer - Time.deltaTime
        if (timer < 0) then
            timer = 0.2
            SetTime()
        end
    end
end

function SetIcon()
    local iconName = cfg.icon
    if (iconName) then
        ResUtil.MatrixBuilding:Load(icon, iconName .. "_2")
    end
end

function SetLv()
    curLv, maxLv = 1, 1
    if (buildData) then
        curLv, maxLv = buildData:GetLv()
    end
    CSAPI.SetText(txtLv2, curLv .. "")
end

function SetBtn()
    runTime = false
    CSAPI.SetGOActive(time, false)

    baseTime = nil
    btnNameID = nil
    isWhite = true
    -- local imgName = "img_41_01.png"
    if (buildData) then
        -- 已建造  1：建造中 2：升级中  3:常态 :升级  4:满级
        local isShowBtn = true
        local _buildingState, _baseTime = buildData:GetState()
        if (_buildingState == MatrixBuildingType.Upgrage) then
            baseTime = _baseTime
            LanguageMgr:SetText(txtTime1, 10082)
            btnNameID = 10035
            CSAPI.SetGOActive(time, true)
            SetTime()
        elseif (_buildingState == MatrixBuildingType.Create) then
            baseTime = _baseTime
            LanguageMgr:SetText(txtTime1, 10048)
            btnNameID = 10037
            CSAPI.SetGOActive(time, true)
            SetTime()
        elseif (curLv < maxLv) then
            LanguageMgr:SetText(txtTime1, 10082)
            CSAPI.SetText(txtTime2, TimeUtil:GetTimeStr7(buildData:GetCfg().upTime))
            isShowBtn = true
            isWhite = false
            CSAPI.SetGOActive(time, true)
            btnNameID = 4012
            -- imgName = "img_41_02.png"
        else
            LanguageMgr:SetText(txtLock,10452) --满级
            isShowBtn = false
        end
        CSAPI.SetGOActive(build, isShowBtn)
        CSAPI.SetGOActive(lock, not isShowBtn)
    else
        -- 未建造  1：可建造 2：不可建造
        CSAPI.SetGOActive(build, canCreate)
        CSAPI.SetGOActive(lock, not canCreate)
        if (canCreate) then
            isWhite = false
            btnNameID = 10041
            -- local upTime =cfg.upTime
            local buildTime = cfg.buildTime
            LanguageMgr:SetText(txtTime1, 10048)
            CSAPI.SetText(txtTime2, TimeUtil:GetTimeStr7(buildTime))
            CSAPI.SetGOActive(time, true)
        else
            CSAPI.SetText(txtLock, tipStr)
        end
    end
    if (btnNameID) then
        LanguageMgr:SetText(txtBuild1, btnNameID)
        LanguageMgr:SetEnText(txtBuild2, btnNameID)
    end
    -- if(not isWhite) then
    -- 	CSAPI.LoadImg(imgBuild1, "UIs/Matrix/" .. imgName, true, nil, true)
    -- end
    SetColor(isWhite)
end

function SetTime()
    if (baseTime and baseTime > 0) then
        needTime = baseTime - TimeUtil:GetTime()
        -- needTime = needTime > 0 and needTime or 0
    else
        needTime = -1
    end
    CSAPI.SetText(txtTime2, TimeUtil:GetTimeStr7(needTime))
    runTime = needTime > -0.1
    if (runTime == false) then
        CSAPI.SetGOActive(time, false)
    end
end

function SetPos()
    local pos = build.activeSelf and 376 or 338
    CSAPI.SetAnchor(entity, 0, pos, 0)
end

function SetColor(isWhite)
    CSAPI.SetGOActive(imgBuild1, not isWhite)
    local code = isWhite and "fffffff" or "000000"
    CSAPI.SetImgColorByCode(imgBuild2, code, true)
    CSAPI.SetTextColorByCode(txtBuild1, code, true)
end

function OnClickBuild()
    if (buildData) then
        if (btnNameID == 4012) then
            CSAPI.OpenView("MatrixUp", buildData)
        end
    else
        if (canCreate) then
            CSAPI.OpenView("MatrixCreateInfo", cfg.id)
        end
    end
end

