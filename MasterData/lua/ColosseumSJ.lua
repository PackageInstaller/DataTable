local ColosseumSJData = require("ColosseumSJData")
local chidItem = nil
local isSelect = false
local closeType = 1
function Awake()
    UIUtil:AddTop2("RoleListNormal", gameObject, Close1, Close2, {})
    scrollRect = ComUtil.GetCom(sv, "ScrollRect")
end

-- data : id 战斗后的id
function OnOpen()
    RefreshPanel()

    data = nil
end

function RefreshPanel()
    randModData = ColosseumMgr:GetRandModData()
    --
    InitDatas()
    -- 选人界面
    CheckSelectCard()
    -- left 
    SetLeft()
    -- midle 
    SetMiddle()
    -- right
    SetRight()
    -- down
    SetDown()
end

function InitDatas()
    curDatas = {}
    local randLvs = randModData.randLvs or {}
    for k, v in ipairs(randLvs) do
        local _data = ColosseumSJData.New()
        _data:Init(v)
        table.insert(curDatas, _data)
    end
end

--------
-- 检测选人
function CheckSelectCard()
    if (ColosseumMgr:IsNeedToSelect()) then
        CSAPI.OpenView("ColosseumTeam", {
            closeCB = SelectViewCloseCB
        })
    end
end

function SelectViewCloseCB()
    view:Close()
end

--------
function SetLeft()
    -- num
    local stars = 0
    local passNums = {0, 0, 0}
    for k, v in ipairs(curDatas) do
        stars = stars + v:GetStars()[4]
    end
    CSAPI.SetText(txtStar, "x" .. stars)
    CSAPI.SetText(txtStar2, "x" .. stars)
    CSAPI.SetText(txtStar3, "x" .. stars)
    CSAPI.SetText(txtStar4, "x" .. stars)
    CSAPI.SetGOActive(objStar, not randModData.isOver)
    -- 
    SetReward()
    --
    local _datas = {}
    for k = 1, 9 do
        local _data = curDatas[k] or {
            isEmpty = true
        }
        table.insert(_datas, _data)
    end
    resultItems = resultItems or {}
    ItemUtil.AddItems("Colosseum/ColosseumSJItem", resultItems, _datas, vlg)
end

function SetReward()
    local isOver = randModData.isOver
    -- 跳进来的
    if (data ~= nil and isOver) then
        CSAPI.SetGOActive(objReward, false)
        CSAPI.SetGOActive(objReward2, true)

    else
        CSAPI.SetGOActive(objReward, isOver)
    end
end

--------
function SetMiddle()
    items = items or {}
    local oldID = data
    ItemUtil.AddItems("Colosseum/ColosseumSJM", items, curDatas, mContent, ItemClickCB, 1, oldID, function()
        SetCorrectPos(oldID)
        SetMiddleAnim(oldID)
    end)
end
function SetCorrectPos(oldID)
    if (oldID) then
        -- 设置到合适的位置
        local contentRT = 394 + (#curDatas - 1) * 631 + 574
        local realWidth = CSAPI.GetMainCanvasSize()[0]
        local limitX = contentRT - realWidth
        local cfg = Cfgs.MainLine:GetByID(oldID)
        local x = (cfg.turn + 1) * 631
        x = x > limitX and limitX or x
        CSAPI.SetAnchor(mContent, -x, 0, 0)
    end
end

function SetMiddleAnim()
    local startIndex = 1
    if (oldID) then
        -- local cfg = Cfgs.MainLine:GetByID(oldID)
        -- startIndex = cfg.turn
    end
    for k, v in ipairs(items) do
        if (k > startIndex) then
            -- itemsParent
            local delay = 60 * (k - startIndex) + 1
            UIUtil:SetObjFade(v.itemsParent, 0, 1, nil, 300, delay, 0)
            UIUtil:SetPObjMove(v.itemsParent, -80, 0, 0, 0, 0, 0, nil, 300, delay)
            -- lines
            delay = 60 * (k - startIndex) + 1
            UIUtil:SetObjFade(v.lines, 0, 1, nil, 500, delay, 0)
            UIUtil:SetPObjMove(v.lines, -132, 0, 0, 0, 0, 0, nil, 500, delay)
        end
    end
end

function ItemClickCB(item)
    if (chidItem) then
        chidItem.Select(false)
    end
    chidItem = item
    chidItem.Select(true)
    SetRight()
    -- 
    MoveAnim(chidItem.cfg.turn)
end

--------
function SetRight()
    if (not chidItem) then
        if (infoPanel) then
            CSAPI.SetGOActive(infoPanel.gameObejct, false)
        end
        return
    end
    if (not infoPanel) then
        ResUtil:CreateUIGOAsync("DungeonItemInfo/ColosseumItemInfo", AdaptiveScreen, function(go)
            infoPanel = ComUtil.GetLuaTable(go)
            infoPanel.Refresh(chidItem.cfg, PanelCloseCB)
            MoveAnim2(true)
        end)
    else
        infoPanel.Refresh(chidItem.cfg, PanelCloseCB)
        CSAPI.SetGOActive(infoPanel.gameObject, true)
        MoveAnim2(true)
    end
end
function PanelCloseCB()
    chidItem.Select(false)
    chidItem = nil
    -- 
    MoveAnim()
    MoveAnim2()
end

function MoveAnim(turn)
    local realWidth = CSAPI.GetMainCanvasSize()[0]
    local offset = math.floor(realWidth / 2) - 800
    if (turn) then
        scrollRect.enabled = false
        -- 选中 
        local pos = CSAPI.csGetAnchor(mContent)
        local x2 = -631 * (turn - 1) + offset
        oldX = nil
        if (math.abs(pos[0] - x2) > 1) then
            oldX = pos[0]
            CSAPI.SetGOActive(mask, true)
            UIUtil:SetPObjMove(mContent, pos[0], x2, 0, 0, 0, 0, function()
                CSAPI.SetGOActive(mask, false)
            end, 400, 1)
        end
    else
        -- 还原 
        if (oldX ~= nil) then
            local pos = CSAPI.csGetAnchor(mContent)
            scrollRect.enabled = false
            CSAPI.SetGOActive(mask, true)
            UIUtil:SetPObjMove(mContent, pos[0], oldX, 0, 0, 0, 0, function()
                scrollRect.enabled = true
                CSAPI.SetGOActive(mask, false)
            end, 400, 1)
        else
            scrollRect.enabled = true
        end
    end
    CSAPI.SetGOActive(middleMasks, turn)

    isSelect = turn ~= nil
end

function MoveAnim2(isIn)
    if (not infoPanel) then
        return
    end
    -- if (isSelect) then
    --     return
    -- end
    local a1 = isIn and 0 or 1
    local a2 = isIn and 1 or 0
    local x1 = isIn and 900 or 0
    local x2 = isIn and 0 or 900
    UIUtil:SetObjFade(infoPanel.childNode, a1, a2, nil, 400, 1, 1)
    UIUtil:SetPObjMove(infoPanel.childNode, x1, x2, 0, 0, 0, 0, function()
        if (not isIn) then
            CSAPI.SetGOActive(infoPanel.gameObject, false)
        end
    end, 401, 1)
end

--------------
function SetDown()
    CSAPI.SetGOAlpha(btnQQ, randModData.isOver and 0.5 or 1)
    -- items
    local imgName = randModData.isOver and "btn_01_04.png" or "btn_01_03.png"
    CSAPI.LoadImg(imgQQ, "UIs/Colosseum/" .. imgName, true, nil, true)
end

function OnClickTeam()
    CSAPI.OpenView("TeamView", {
        currentIndex = eTeamType.Colosseum + 1,
        canEmpty = true,
        is2D = true
    }, TeamOpenSetting.Colosseum)
end
-- 触发保存路线
function Close1()
    closeType = 1
    ViewClose()
end

function Close2()
    closeType = 2
    ViewClose()
end

-- 触发保存路线
function ViewClose()
    if (isSelect) then
        PanelCloseCB()
        return
    end
    if (randModData.isOver) then
        if (randModData.isGet) then
            local b = ColosseumMgr:IsNeedSaveRoute()
            if (b) then
                UIUtil:OpenDialog(LanguageMgr:GetByID(64029), ToSave1, ToSave2)
            else
                ToSave2()
            end
        end
    else
        if (closeType == 1) then
            view:Close()
        else
            UIUtil:ToHome()
        end
    end

end

function ToSave1()
    ToSave(true)
end
function ToSave2()
    ToSave(false)
end

function ToSave(b)
    CSAPI.SetGOActive(mask, true)
    AbattoirProto:SaveRoute(b, function()
        if(closeType==1) then 
            view:Close()
            CSAPI.OpenView("ColosseumView") -- 触发打开界面，重新请求数据
        else 
            UIUtil:ToHome()
        end 
    end)
end

function ToHome()
    if (randModData.isOver) then
        if (randModData.isGet) then
            local b = ColosseumMgr:IsNeedSaveRoute()
            if (b) then
                UIUtil:OpenDialog(LanguageMgr:GetByID(64029), function()
                    ToSave1()
                    UIUtil:ToHome()
                end, function()
                    ToSave2()
                    UIUtil:ToHome()
                end)
            else
                ToSave2()
                UIUtil:ToHome()
            end
            return
        end
    end
    UIUtil:ToHome()
end

function OnClickReward()
    if (randModData.isOver) then
        if (not randModData.isGet) then
            AbattoirProto:RandModeGetRwd(SetReward)
        else
            -- LogError("无奖励")
        end
    end
end

-- 弃权
function OnClickQQ()
    if (not randModData.isOver) then
        UIUtil:OpenDialog(LanguageMgr:GetByID(64030), function()
            AbattoirProto:RandModQuit(RefreshPanel)
        end)
    end
end

function OnClickBG()
    if (isSelect) then
        PanelCloseCB()
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    if (infoPanel and infoPanel.gameObject.activeSelf) then
        CSAPI.SetGOActive(infoPanel.gameObejct, false)
    else
        Close1()
    end
end
