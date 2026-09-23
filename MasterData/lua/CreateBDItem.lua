local needToCheckMove = false
function Awake()
    clickNodeImage = ComUtil.GetCom(clickNode, "Image")
    -- luaTextMove = LuaTextMove.New()
    -- luaTextMove:Init(txtName)
    textMove = ComUtil.GetCom(ImageName,"TextMove")
end
-- function Update()
--     if (needToCheckMove) then
--         luaTextMove:CheckMove(txtName)
--         needToCheckMove = false
--     end
-- end

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_cfg, elseData)
    cardCfg = _cfg
    curIndex = elseData and elseData.curIndex or nil
    baseIndex = elseData and elseData.baseIndex or nil

    -- bg
    LoadFrame(cardCfg.quality)
    -- icon
    local modelCfg = Cfgs.character:GetByID(cardCfg.model)
    LoadIcon(modelCfg.icon)
    -- name 
    -- needToCheckMove = false
    -- CSAPI.SetText(txtName, modelCfg.key)
    -- needToCheckMove = true
    if not IsNil(textMove) then
		textMove:SetText(modelCfg.key)
	end
    -- imgStar
    ResUtil.CardBorder:Load(imgStar, "img_101_0" .. cardCfg.quality)

    -- bd
    isBD = false
    if (baseIndex and baseIndex == index) then
        isBD = true
    end
    CSAPI.SetGOActive(bd, isBD)
    -- had 
    isHad = RoleMgr:CheckCfgIdExist(cardCfg.id)
    CSAPI.SetGOActive(had, isHad)

    -- select
    isSelect = false
    if (curIndex and curIndex == index) then
        isSelect = true
    end
    SetSelect(isSelect)
    -- look 
    CSAPI.SetGOActive(btnLook, isSelect and true or false)
end

-- 加载框
function LoadFrame(lvQuality)
    lvQuality = lvQuality or 1
    local frame = "img_01_0" .. lvQuality
    ResUtil.CardBorder:Load(bg, frame)
end

-- 加载图标
function LoadIcon(iconName)
    CSAPI.SetGOActive(icon, iconName ~= nil);
    if (iconName) then
        ResUtil.RoleCard:Load(icon, iconName .. "")
    end
end

function SetSelect(b)
    CSAPI.SetGOActive(select, b)
end

function SetClickActive(b)
    clickNodeImage.raycastTarget = b
end

function OnClick()
    -- 已选择的不能选
    if (cb) then
        cb(index)
    end
end

function OnClickLook()
    local cardData = RoleMgr:GetMaxFakeData(cardCfg.id)
    CSAPI.OpenView("RoleInfo", cardData)
end
