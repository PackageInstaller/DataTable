local poss = {
    ["up"] = {753, 116},
    ["tupo"] = {753, 116},
    ["skill"] = {-1243, 58},
    ["talent"] = {426, 480}
}
local curCenter = nil -- 当前聚焦
local curSkillIndex = nil
local curTalentIndex = nil
local curPanel = nil
function Awake()
    cg_lines = ComUtil.GetCom(nodeLines, "CanvasGroup")
    cg_talentLines = ComUtil.GetCom(talentLines, "CanvasGroup")
    cg_btnRT = ComUtil.GetCom(btnRT, "CanvasGroup")
    cg_btnSkill = ComUtil.GetCom(btnSkill, "CanvasGroup")

    cg_objSkill = ComUtil.GetCom(objSkill, "CanvasGroup")
    cg_objRT = ComUtil.GetCom(objRT, "CanvasGroup")
    cg_btnUp = ComUtil.GetCom(btnUp, "CanvasGroup")
    cg_btnTupo = ComUtil.GetCom(btnTupo, "CanvasGroup")

    cgs = {}
    cgs.up = cg_btnUp
    cgs.tupo = cg_btnTupo
    cgs.skill = cg_objSkill
    cgs.talent = cg_objRT

    -- 立绘
    cardImgLua = RoleTool.AddRole(iconParent)
end

function OnInit()
    UIUtil:AddTop2("RoleCenter", top, function()
        -- if (curCenter ~= nil) then
        --     ToCenter()
        --     return
        -- end
        view:Close()
    end, nil, {})

    -- 事件监听
    eventMgr = ViewEvent.New()
    -- 卡牌刷新
    eventMgr:AddListener(EventType.Card_Update, CardUpdate)
    -- 切换卡牌
    eventMgr:AddListener(EventType.Role_Card_ChangeResult, function(_data)
        cardData = _data
        RefreshPanel()
    end)

    -- 物品更新
    eventMgr:AddListener(EventType.Bag_Update, function(_data)
        if (curPanel) then
            curPanel.Refresh(cardData)
        end
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    if (timer and Time.time > timer) then
        OpenAnim(false)
    end
end
function OpenAnim(b)
    CSAPI.SetGOActive(mask, b)
    CSAPI.SetGOActive(anim_tocenter, b)
    timer = b and Time.time + 0.6 or nil
end

-- 卡牌刷新
function CardUpdate(_data)
    if (_data.type == CardUpdateType.CardUpgradeRet or _data.type == CardUpdateType.CardBreakRet or _data.type ==
        CardUpdateType.CoreUpgrade) then
        if (curPanel.SetOldData) then
            curPanel.SetOldData(_data.other)
        end
    elseif (_data.type == CardUpdateType.CardSkillUpgradeFinishRet or _data.type == CardUpdateType.MainTalentUpgradeRet) then
        LanguageMgr:ShowTips(3010)
    end
    RefreshPanel()

    -- 刷新当前打开的界面
    -- 如果选择了天赋槽位并且跃升，那么越升后改为天赋升级界面
    if (curCenter == "talent" and curTalentIndex ~= nil and _data.type == CardUpdateType.CardBreakRet) then
        ChangeCenter("talent")
    else
        if (curPanel) then
            if (curCenter == "skill") then
                curPanel.Refresh(cardData, skillDatas[curSkillIndex])
            elseif (curCenter == "talent") then
                curPanel.Refresh(cardData, talentDatas[curTalentIndex])
            else
                curPanel.Refresh(cardData)
            end
        end
    end

    -- -- 会出现界面互换（RoleBreak，RoleTalent），所以要放到这里打开
    -- if (_data.type == CardUpdateType.CardBreakRet) then
    --     CSAPI.OpenView("RoleBreakSuccess", {_data.other, cardData})
    -- end
end

-- 回到中心
function ToCenter()
    curCenter = nil
    oldCurCenter = nil
    curSkillIndex = nil
    curTalentIndex = nil
    if (curPanel) then
        CSAPI.RemoveGO(curPanel.gameObject)
    end
    curPanel = nil
    RefreshPanel()
end

function OnOpen()
    cardData = data[1]
    curCenter = openSetting
    SetCurIndex()
    RefreshPanel()
    ChangeCenter(openSetting)

    if (curCenter == "skill") then
        cardData:LookPassive()
    end 
end

function SetCurIndex()
    local id = data[2]

    -- 跳转进来，如果无选择，则选中第一个
    if ((curCenter == "skill" or curCenter == "talent") and id == nil) then
        curTalentIndex = 1
        return
    end

    if (id) then
        curTalentIndex = 1
        if (curCenter == "skill") then
            local skillDatas = cardData:GetSkillsForShow()
            for i, v in ipairs(skillDatas) do
                if (v.id and id == v.id) then
                    curSkillIndex = i
                    break
                end
            end
        elseif (curCenter == "talent") then
            local talentDatas = GetTalentData()
            for i, v in ipairs(talentDatas) do
                if (v.id and id == v.id) then
                    curTalentIndex = i
                    break
                end
            end
        end
    end
end

function RefreshPanel()
    if (not isFirstOpen) then
        isFirstOpen = 1
    else
        SetNode()
    end

    -- skill
    skillDatas = cardData:GetSkillsForShow()
    skillItems = skillItems or {}
    ItemUtil.AddItems("Role/RoleInfoSkillItem2", skillItems, skillDatas, skillGrids, ClickSkillItemCB, 1, curSkillIndex,
        SetSkillItemEnd)
    -- talent
    talentDatas = GetTalentData()
    talentItems = talentItems or {}
    ItemUtil.AddItems("Role/RoleInfoTalentItem2", talentItems, talentDatas, talentGrids, ClickTalentItemCB, 1,
        curTalentIndex, SetTalentItemEnd)
    -- txtTalentTips
    SetTalentTips()
    -- btn的alpha
    SetBtnAlpha()
    -- imgRole
    CSAPI.SetGOActive(btnChangeRole, curCenter == nil)
    SetRoleIcon()
    -- role
    SetRole()
    --     
    CSAPI.SetGOActive(objSelectUp, curCenter ~= nil and curCenter == "up")
    CSAPI.SetGOActive(objSelectTupo, curCenter ~= nil and curCenter == "tupo")

    CSAPI.SetGOActive(objSkill, curCenter ~= "talent")
end

function SetTalentItemEnd()
    for k, v in ipairs(talentItems) do
        local isRed = false
        if (v.data.had and v.data.id) then
            isRed = cardData:CheckTalnetUp(v.data.id)
        end
        UIUtil:SetRedPoint(v.clickNode, isRed, 47, 47, 0)
    end
end

function SetSkillItemEnd()
    if (not isSetPassiveParent and #skillItems > 3) then
        isSetPassiveParent = 1
        CSAPI.SetParent(skillItems[4].gameObject, skillGrids2)
    end
    -- red 
    for k, v in ipairs(skillItems) do
        local isRed = false
        if (k == 4) then
            isRed = cardData:CheckPassiveUp()
        else
            isRed = cardData:CheckNormalSkillUP(v.id)
        end
        UIUtil:SetRedPoint(v.clickNode, isRed, 48, 46.7, 0)
    end
end

function SetTalentTips()
    CSAPI.SetGOActive(txtTalentTips, curCenter == "talent")
    LanguageMgr:SetText(txtTalentTips, 4200, useCount, 3)
end

function SetRole()
    -- role
    CSAPI.SetScale(iconParent, 0, 0, 0)
    cardImgLua.Refresh(cardData:GetSkinID(), LoadImgType.RoleUpBreak, function()
        CSAPI.SetScale(iconParent, 1, 1, 1)
    end, false)
    -- btn
    if (curCenter and (curCenter == "up" or curCenter == "tupo")) then
        CSAPI.SetGOActive(iconParent, true)
    else
        CSAPI.SetGOActive(iconParent, false)
    end
end
function SetRoleIcon()
    local iconName = cardData:GetModelCfg().Fight_head
    if iconName then
        ResUtil.FightCard:Load(imgRole, iconName)
    end
end

-- 封装天赋数据
function GetTalentData()
    talentArr = {}
    serverDatas = cardData:GetDeputyTalent()
    useCount = 0
    local subTfSkills = cardData:GetCfg().subTfSkills
    local id = subTfSkills and subTfSkills[1] or nil
    local cnt = Cfgs.CfgSubTalentOpenCnt:GetByID(cardData:GetBreakLevel()).cnt
    if (id) then
        local had = serverDatas.had or {}
        local use = serverDatas.use or {}
        local allDatas = Cfgs.CfgSubTalentSkillPool:GetByID(id)
        for n, m in ipairs(allDatas.ids) do
            if (cnt >= n and had[n]) then
                local _use = false
                for i, v in ipairs(use) do
                    if (v == had[n]) then
                        _use = true
                        break
                    end
                end
                table.insert(talentArr, {
                    index = n,
                    id = had[n],
                    had = true,
                    use = _use
                }) -- had是否已解锁  use是否已装载
                if (_use) then
                    useCount = useCount + 1
                end
            else
                table.insert(talentArr, {
                    index = n,
                    id = m.id,
                    had = false,
                    use = false
                })
            end
        end
    end
    return talentArr
end

function ClickSkillItemCB(index)
    if (curSkillIndex and curSkillIndex == index) then
        return
    end
    if (curSkillIndex) then
        skillItems[curSkillIndex].SetSelect(false)
    end
    skillItems[index].SetSelect(true)

    curSkillIndex = index
    ChangeCenter("skill")
end

function ClickTalentItemCB(index, isStow)
    if (isStow) then
        -- 装载或者卸载
        Install(talentDatas[index])
    else
        if (curTalentIndex and curTalentIndex == index) then
            return
        end
        if (curTalentIndex) then
            talentItems[curTalentIndex].SetSelect(false)
        end
        talentItems[index].SetSelect(true)
        curTalentIndex = index
        ChangeCenter("talent")
    end
end

function Install(_curData)
    local use = serverDatas.use
    if (_curData.use) then
        -- 卸下
        for i, v in ipairs(use) do
            if (v == _curData.id) then
                use[i] = 0
                break
            end
        end
        table.sort(use, function(a, b)
            return a > b
        end)
        PlayerProto:SetUseSubTalent(cardData:GetID(), use)
    else
        local isChange = false
        local quality = cardData:GetBreakLevel()
        -- 安装
        for i, v in ipairs(use) do
            if (v == 0 and quality > i) then
                use[i] = _curData.id
                isChange = true
                break
            end
        end
        if (isChange) then
            PlayerProto:SetUseSubTalent(cardData:GetID(), use)
        else
            LanguageMgr:ShowTips(3002)
        end
    end
end

-----------------------------------------------------------------------------------------------------------
function SetNode()
    -- scale
    local isChange = false
    local oldScale = CSAPI.GetScale(node)
    local newScale = curCenter ~= nil and 1 or 0.62
    if (oldScale ~= newScale) then
        UIUtil:SetObjScale(node, oldScale, newScale, oldScale, newScale, 1, 1, nil, 300)
        isChange = true
    end
    -- pos
    if (not isFirst) then
        -- 第一次打开不用做移动
        isFirst = 1
        local pos = curCenter == nil and {0, 0} or poss[curCenter]
        CSAPI.SetAnchor(node, pos[1], pos[2], 0)
        UIUtil:SetObjFade(node, 0, 1, nil, 300)
    else
        local newPos = curCenter == nil and {0, 0} or poss[curCenter]
        local oldPosX, oldPosY = CSAPI.GetAnchor(node)
        if (oldPosX ~= newPos[1] or oldPosY ~= newPos[2]) then
            UIUtil:SetPObjMove(node, oldPosX, newPos[1], oldPosY, newPos[2], 0, 0, nil, 300)
            isChange = true
        end
    end
    if (isChange) then
        -- 先隐藏线条
        CSAPI.SetGOActive(mask, true)
        UIUtil:SetObjFade(lines, 1, 0, function()
            OpenAnim(true)
        end, 300)
    end
end

function SetBtnAlpha()
    -- alpha 
    local _alpha = curCenter == nil and 1 or 0.3
    SetAlphaAnim(cg_lines, _alpha, 300)
    local cg_btnRTA = _alpha
    local cg_btnSkillA = _alpha
    for i, v in pairs(cgs) do
        local a = 1
        if (curCenter ~= nil) then
            if (curCenter == i) then
                if (i == "talent") then
                    cg_btnRTA = curTalentIndex ~= nil and 0.3 or 1
                elseif (i == "skill") then
                    cg_btnSkillA = 0.3
                end
            else
                a = (i == "talent") and 0 or 0.3
            end
        end
        SetAlphaAnim(v, a)
    end
    SetAlphaAnim(cg_btnRT, cg_btnRTA)
    SetAlphaAnim(cg_btnSkill, cg_btnSkillA)
    -- masks
    CSAPI.SetGOActive(maskUpBreak, not (curCenter == nil or curCenter == "up" or curCenter == "tupo"))
    CSAPI.SetGOActive(maskRT, not (curCenter == nil or curCenter == "talent"))
    CSAPI.SetGOActive(maskSkill, not (curCenter == nil or curCenter == "skill"))
end

function SetAlphaAnim(obj, target, delay)
    -- talentLines
    local func = nil
    if (obj == cg_lines) then
        if (curCenter and curCenter == "up" or curCenter == "tupo") then
            func = function()
                cg_talentLines.alpha = 0
            end
        else
            cg_talentLines.alpha = 1
        end
    end

    local cur = obj.alpha
    if (cur ~= target) then
        UIUtil:SetObjFade(obj.gameObject, cur, target, func, 300, delay, cur)
    end
end

function SetLines()
    CSAPI.SetGOActive(l, curCenter and curCenter == "talent")
end

-- 更换中心
function ChangeCenter(str)
    if (curCenter == nil and str == nil) then
        return
    end

    curCenter = str

    -- node位置与大小
    SetNode()

    -- btn
    CSAPI.SetGOActive(btnChangeRole, curCenter == nil)
    -- role
    if (curCenter and (curCenter == "up" or curCenter == "tupo")) then
        CSAPI.SetGOActive(iconParent, true)
        CSAPI.SetGOActive(objSelectUp, curCenter == "up")
        CSAPI.SetGOActive(objSelectTupo, curCenter == "tupo")
        -- anim
        if (oldCurCenter == nil or (oldCurCenter ~= "up" and oldCurCenter ~= "tupo")) then
            UIUtil:SetPObjMove(iconNode, -200, 0, 0, 0, 0, 0, nil, 300, 300)
            UIUtil:SetObjFade(iconNode, 0, 1, nil, 300, 300)
        end
    else
        CSAPI.SetGOActive(iconParent, false)
        CSAPI.SetGOActive(objSelectUp, false)
        CSAPI.SetGOActive(objSelectTupo, false)
    end

    --
    SetTalentTips()

    -- 主按钮透明度
    SetBtnAlpha()
    -- 线条
    SetLines()

    -- 界面数据
    local _curPanelName = nil
    local elseData = nil
    if (curCenter == "up") then
        _curPanelName = "RoleUp"
    elseif (curCenter == "tupo") then
        _curPanelName = "RoleTupo"
    elseif (curCenter == "talent") then
        if (curTalentIndex) then
            -- 如果未跃升则优先选择跃升界面
            elseData = talentDatas[curTalentIndex]
            -- if (elseData.had) then
            _curPanelName = "RoleTalent"
            -- else
            -- _curPanelName = "RoleBreak"
            -- end
        else
            _curPanelName = "RoleBreak"
        end
    elseif (curCenter == "skill") then
        _curPanelName = "RoleSkill"
        elseData = skillDatas[curSkillIndex]
        if(not elseData)then --预防报错
            curSkillIndex = 1
            elseData = skillDatas[curSkillIndex]
        end
    end
    -- 移除前一个界面
    local needAdd = true
    if (curPanel) then
        if (curPanelName and curPanelName ~= _curPanelName) then
            CSAPI.RemoveGO(curPanel.gameObject)
            curPanel = nil
        elseif (curPanelName == _curPanelName) then
            needAdd = false
            curPanel.Refresh(cardData, elseData)
            SetPanelAnim(_curPanelName)
        end
    end
    -- 生成界面
    if (needAdd) then
        ResUtil:CreateUIGOAsync("Role/" .. _curPanelName, gameObject, function(go)
            curPanel = ComUtil.GetLuaTable(go)
            curPanel.Refresh(cardData, elseData)
            SetPanelAnim(_curPanelName)
        end)
    end
    curPanelName = _curPanelName
    oldCurCenter = curCenter
end

-- 界面打开动画
function SetPanelAnim(_curPanelName)
    local delay = oldCurCenter == nil and 300 or 0
    UIUtil:SetObjFade(curPanel.gameObject, 0, 1, nil, 300, delay)
end

function OnClickUp()
    if (curCenter ~= "up") then
        ChangeCenter("up")
    end
end

function OnClickTupo()
    if (curCenter ~= "tupo") then
        ChangeCenter("tupo")
    end
end
--[[
-- 跃升/天赋
function OnClickRT()
    if (curCenter == "talent" and curTalentIndex == nil) then
        return
    end

    -- 刷新选中
    curTalentIndex = nil
    ItemUtil.RefreshItems(talentItems, talentDatas, curTalentIndex)
    ChangeCenter("talent")
end
]]
function OnClickChangeRole()
    CSAPI.OpenView("RoleSelect", cardData)
end

