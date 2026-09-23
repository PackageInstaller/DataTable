local cfg = nil
local elseData = nil
local data = nil
local dungeonData = nil
local isNew = false

function OnRecycle()
    if goRect == nil then
        goRect = ComUtil.GetCom(gameObject, "RectTransform")
    end
    goRect.pivot = UnityEngine.Vector2(0.5, 0.5)
    CSAPI.SetGOActive(gameObject, true)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _elseData)
    cfg = _data
    elseData = _elseData
    InitPanel()
    if cfg then
        -- CSAPI.SetText(txtName2, "")
        if elseData == ArchiveType.Role then
            SetCRole()
        elseif elseData == ArchiveType.Enemy then
            SetEnemy()
        end

        isNew = ArchiveMgr:GetNew(elseData, cfg.id)
        CSAPI.SetGOActive(new, isNew)
        if isNew and gameObject.activeSelf then
            ArchiveMgr:SetNew(elseData, cfg.id, false)
        end
    end
end

function InitPanel()
    CSAPI.SetGOActive(emptyObj, false)
    CSAPI.SetGOActive(txtFavor, false)
    CSAPI.SetGOActive(favorImg, false)
end

function SetIdxText(idx)
    local idxStr = ""
    if idx >= 100 then
        idxStr = StringUtil:SetByColor(idx, "ffc140")
    elseif idx >= 10 then
        idxStr = "0" .. StringUtil:SetByColor(idx, "ffc140")
    else
        idxStr = "00" .. StringUtil:SetByColor(idx, "ffc140")
    end
    CSAPI.SetText(txtFormat1, idxStr)
end

function SetCRole()
    SetIdxText(cfg.number)
    data = CRoleMgr:GetData(cfg.id)
    CSAPI.SetText(txtName1, cfg.sAliasName)
    -- CSAPI.SetText(txtName2, cfg.eName)
    if not IsLock() then
        SetIcon(data:Card_head())
        SetHei(false)
        SetFavorAbility()
    else
        local cfgModel = Cfgs.character:GetByID(cfg.aModels)
        if cfgModel and cfgModel.Card_head then
            SetIcon(cfgModel.Card_head)
        end
        -- CSAPI.SetText(txtName1, "???")
        -- CSAPI.SetText(txtName2, "UNKNOWN")
        -- SetIcon("test_chead")
        SetEmpty()
        SetHei(true)
    end
    -- isNew = data and data:IsNew() or false
    -- CSAPI.SetGOActive(new, isNew)
end

function SetEnemy()
    SetIdxText(index)
    CSAPI.SetText(txtName1, cfg.name)
    -- CSAPI.SetText(txtName2, cfg.name_en)
    if cfg.unlock_type == 1 then -- 关卡		
        if not IsLock() then
            local cfgModel = Cfgs.character:GetByID(cfg.aModels)
            if cfgModel then
                SetIcon(cfgModel.Card_head)
                SetHei(false)
            else
                LogError("没找到对应的模型表数据！！！id:" .. cfg.aModels)
            end
        else
            SetIcon("enemy_chead")
            SetEmpty()
            SetHei(true)
        end
        -- else --特殊
    end
end

function SetIcon(iconName)
    if (iconName) then
        ResUtil.CardIcon:Load(icon, iconName)
    end
end

function SetHei(b)
    if not canvasGroup then
        canvasGroup = ComUtil.GetCom(node, "CanvasGroup")
    end
    canvasGroup.alpha = b and 0.5 or 1
    -- CSAPI.SetImgColor(icon, 255, 255, 255, b and 125 or 255)
end

function SetFavorAbility()
    CSAPI.SetGOActive(txtFavor, true)
    CSAPI.SetGOActive(favorImg, true)
    CSAPI.SetText(txtFavor, data:GetLv() .. "")
end

function SetEmpty()
    CSAPI.SetGOActive(emptyObj, true)
end

function OnClick()
    if elseData == ArchiveType.Role then
        if (data) then
            if (isNew) then
                PlayerProto:LookRole(data:GetID())
                local count = ArchiveMgr:GetRoleCount()
                local str = "点亮角色图鉴"
                if CSAPI.IsADV()==false then
                    BuryingPointMgr:TrackEvents("unlock", {
                        reason = str,
                        unlock_num = count
                    })
                end
            end
            CSAPI.OpenView("ArchiveRole", data)
        else
            -- local cardData = RoleMgr:GetMaxFakeData(cfg.id)
            -- CSAPI.OpenView("RoleInfo", cardData)
            if g_FHXArchiveRole ~= nil then
                LanguageMgr:ShowTips(18001)
            else
                local cRoleInfo = CRoleMgr:GetFakeData(cfg.id)
                CSAPI.OpenView("ArchiveRole", cRoleInfo, 2)    
            end
            -- LanguageMgr:ShowTips(18000)
            -- Tips.ShowTips(18001)
        end
    elseif elseData == ArchiveType.Enemy then
        if dungeonData and dungeonData:IsHisPass() then
            CSAPI.OpenView("ArchiveEnemy", cfg)
        else
            LanguageMgr:ShowTips(18000)
            -- Tips.ShowTips(18001)
        end
    end
    -- if(isNew) then
    -- 	ArchiveMgr:SetNew(elseData, cfg.id, false)
    -- 	local count = elseData == ArchiveType.Role and ArchiveMgr:GetRoleCount() or ArchiveMgr:GetEnemyCount()
    -- 	local str = elseData == ArchiveType.Role and "点亮角色图鉴" or "点亮敌兵图鉴"
    -- 	BuryingPointMgr:TrackEvents("unlock", {reason = str, unlock_num = count})
    -- end
end

local startPosX = 0

function OnPressDown()
    CSAPI.SetUIScaleTo(node, nil, 1.06, 1.06, 1, nil, 0.14)
    startPosX = CS.UnityEngine.Input.mousePosition.x
end

function OnPressUp()
    local len = CS.UnityEngine.Input.mousePosition.x - startPosX
    if (math.abs(len) < 100) then
        CSAPI.SetUIScaleTo(node, nil, 1, 1, 1, function()
            OnClick()
        end, 0.15)
    end
end

function IsLock()
    local isLock = true
    if elseData == ArchiveType.Role then
        isLock = data == nil
    elseif elseData == ArchiveType.Enemy then
        if cfg.unlock_type == 1 then
            for i, v in ipairs(cfg.unlock_id) do
                dungeonData = DungeonMgr:GetDungeonData(v)
                if dungeonData and dungeonData:IsHisPass() then
                    isLock = false
                    break
                end
            end
        end
    end
    return isLock
end
function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    node = nil;
    IconBg = nil;
    icon = nil;
    favorImg = nil;
    format = nil;
    txtFormat1 = nil;
    txtFormat2 = nil;
    txtFormat3 = nil;
    txtName1 = nil;
    txtName2 = nil;
    txtFavor = nil;
    emptyObj = nil;
    btnClick = nil;
    view = nil;
end
----#End#----
