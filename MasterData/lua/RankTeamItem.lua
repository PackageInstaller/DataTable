local data = nil
local isTactics = false
local isEmpty = true
local isHideLv = false
local index = 0
local colors = {"FFFFFF", "00ffbf", "26dbff", "8080ff", "FFC146"}
local cardIds = {71010,71012,71020,71022}
local textMove = nil

function Awake()
    CSAPI.SetGOActive(assist,false)
    textMove = ComUtil.GetCom(ImageName,"TextMove")
end

function SetIndex(idx)
    index = idx
end

function SetAssist()
    CSAPI.SetGOActive(assist,index == 6)
end

function SetEmpty(b)
    isEmpty = b
    CSAPI.SetGOActive(node, not b)
    CSAPI.SetGOActive(empty, b)
    if isTactics then
        LanguageMgr:SetText(txtEmpty1,22071)
        -- LanguageMgr:SetEnText(txtEmpty2,22071)    
    else
        LanguageMgr:SetText(txtEmpty1,index == 6 and 22069 or 22068)
        -- LanguageMgr:SetEnText(txtEmpty2,index == 6 and 22069 or 22068)    
    end
end

function Refresh(_data,_elseData)
    data = _data
    isTactics = _elseData and _elseData.isTactics or false
    if data then
        SetEmpty(false)
        CSAPI.SetGOActive(tacticsObj,isTactics)
        CSAPI.SetGOActive(cardObj,not isTactics)
        if isTactics then
            SetTactics()
        else
            SetCard()
        end
    else
        SetEmpty(true)
        SetState(false)
    end
end

--TacticsData
function SetTactics()
    SetBgIcon(1)

    local iconName = data:GetIcon()
    if iconName~=nil and iconName~="" then
        ResUtil.Ability:Load(icon2, iconName)
    end

    SetName(data:GetName())

    if isHideLv then
        CSAPI.SetText(txtLv3, "--")
        CSAPI.SetGOActive(txtLv1, true)
        CSAPI.SetGOActive(txtLv2, false)
    else
        CSAPI.SetText(txtLv3, data:GetLv() .. "")
        local b = data:IsMaxLv()
        CSAPI.SetGOActive(txtLv1, not b)
        CSAPI.SetGOActive(txtLv2, b)
    end
    
    local _data = TacticsMgr:GetDataByID(data:GetCfgID())
    SetState(_data and _data:IsUnLock() and _data:GetLv() >= data:GetLv(),not _data or not _data:IsUnLock() or _data:GetLv() < data:GetLv())
end

function SetCard()
    local card=CharacterCardsData(data.card_info);
    SetName(card:GetName())
    if isHideLv then
        CSAPI.SetText(txtLv3, "--")
        CSAPI.SetGOActive(txtLv1, true)
        CSAPI.SetGOActive(txtLv2, false)
    else
        SetLv(card)
    end
    SetBgIcon(card:GetQuality())
    SetIcon(card:Card_head())
    SetColor(card:GetQuality())
    -- 小队
    SetCamp(card)
    -- break 
    local breakLv = card:GetBreakLevel()
    CSAPI.SetGOActive(imgBreakBG, breakLv > 1)
    if (breakLv > 1) then
        ResUtil.RoleCard_BG:Load(imgBreak, "img_1_0" .. (breakLv - 1))
    end
    -- star 
    ResUtil.RoleCard_BG:Load(imgStar, "img_01_0" .. card:GetQuality())

    --weapon
    SetWeaponLv(card)

    if RoleMgr:IsLeader(card:GetCfgID()) or RoleMgr:IsExtraLeader(card:GetCfgID()) then
        SetState(true)
        return
    end

    local _card = RoleMgr:GetDataByCfgID(card:GetCfgID())
    SetState(_card ~= nil)
end

function SetBgIcon(_quality)
    local colorName = "btn_1_0" .. _quality
    ResUtil.RoleCard_BG:Load(iconBg, colorName)

    -- effect
    CSAPI.SetGOActive(Yvaine_RoleList_Color, _quality >= 6)
end

function SetName(str)
    -- CSAPI.SetText(txtName2, str)
    if not IsNil(textMove) then
		textMove:SetText(str)
	end
end

-- 等级
function SetLv(_card)
    local _lv = _card:GetLv() or 1
    CSAPI.SetText(txtLv3, _lv .. "")
    local b = _lv >= _card:GetMaxLv()
    CSAPI.SetGOActive(txtLv1, not b)
    CSAPI.SetGOActive(txtLv2, b)
end

-- icon
function SetIcon(_iconName)
    if (_iconName) then
        ResUtil.CardIcon:Load(icon, _iconName)
    end
end

-- 颜色
function SetColor(_quality)
    local str = colors[_quality]
    CSAPI.SetTextColorByCode(txtLv1, str)
    CSAPI.SetTextColorByCode(txtLv2, str)

    local colorName = "img_x_" .. _quality
    ResUtil.RoleCard_BG:Load(color, colorName)
end

function SetCamp(_card)
    local _cfg = Cfgs.CfgTeamEnum:GetByID(_card:GetCamp())
    local imgName = _cfg.details1 or "01_montagnes"
    ResUtil.RoleClamp:Load(imgCamp, imgName .. "_3", true)
end

function SetState(isGet,isUndergrade)
    if isHideLv then
        CSAPI.SetGOActive(notGet,true)
    else
        CSAPI.SetGOActive(notGet,not isGet)
    end
    if isTactics then
        LanguageMgr:SetText(txtNotGet,isUndergrade and 9014 or 22072)
    else
        LanguageMgr:SetText(txtNotGet,37021)
    end
end

function SetWeaponLv(card)
    RoleTool.SetWeapon(card,objWeapon,imgWeapon,txtWeaponLv)
end

function OnClick()
    if isEmpty then
        return
    end
    if not isTactics then
        local card = CharacterCardsData(data.card_info);
        CSAPI.OpenView("RoleInfo", card)
    else
        CSAPI.OpenView("AbilityInfoView",nil,nil,function (go)
            local view = ComUtil.GetLuaTable(go)
            view.OnClick = function()
                if view.IsGrid() then
                    view.CloseGrid()
                    CSAPI.SetGOActive(view.skillMask,true)
                else
                    view.Close()
                end
            end
            view.SetIsRight(true)
            view.ShowInfo(data)
        end)
    end
end
