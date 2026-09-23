-- function Awake()
-- 	--综合战力
-- 	CSAPI.SetText(txtFighting1, StringConstant.Exercise21)
-- 	--排名
-- 	CSAPI.SetText(txtRank1, StringConstant.Exercise40)
-- end
function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _isHistory)
    data = _data
    isHistory = _isHistory
    if (data) then
        -- -- role
        -- local icon_id = data:GetIconID()
        -- if (data:GetRolePanelID() ~= nil and data:GetRolePanelID() ~= 0) then
        --     icon_id = data:GetRolePanelID()
        -- end
        -- if (icon_id) then
        --     local cfg = Cfgs.character:GetByID(icon_id)
        --     SetIcon(cfg.Fight_head)
        -- end
        -- attack
        CSAPI.SetText(txtFighting2, data:GetPerformance() .. "")
        -- rank
        CSAPI.SetText(txtRank2, data:GetRank() == 0 and "--" or tostring(data:GetRank()))
        -- name
        CSAPI.SetText(txtName, data:GetName())
        -- lv
        CSAPI.SetText(txtLv, data:GetLevel() .. "")
        -- 积分
        if (isHistory) then
            local score = data:GetModScore()
            local str = "<color=#00ffbf>+" .. score .. "</color>"
            if (score == 0) then
                str = LanguageMgr:GetByID(33070)
            elseif (score < 0) then
                str = "<color=#ff7781>" .. score .. "</color>"
            end
            CSAPI.SetText(txtZf2, str)
        else
            local zf1 = ExerciseMgr:GetScore()
            local zf2 = data:GetScore()
            local zf = GCalHelp:GetArmyAddScore(zf1, zf2)
            local str = "<color=#00ffbf>+" .. zf .. "</color>"
            CSAPI.SetText(txtZf2, str)
        end
        -- head
        UIUtil:AddHeadByID(headParent, 0.9, data:GetFrameId(), data:GetIconID(), data:GetSex())
        -- 结果
        CSAPI.SetGOActive(result, isHistory)
        if (isHistory) then
            local imgName = data:GetIsWin() and "UIs/ExerciseL/img_06_03.png" or "UIs/ExerciseL/img_06_02.png"
            CSAPI.LoadImg(imgResult, imgName, true, nil, true);
            CSAPI.SetText(txtResult1, data:GetTurnNum() .. "")
            CSAPI.SetGOActive(txtResult2, data:GetIsWin())
            CSAPI.SetGOActive(txtResult3, not data:GetIsWin())
        end
        -- teams
        local cardDatas = data:GetTeamCardDatas()
        teamItems = teamItems or {}
        ItemUtil.AddItems("RoleLittleCard/RoleLittleCard", teamItems, cardDatas, teamGrid, nil, 1, {
            hideFormat = true
        }, function()
            for k, v in pairs(teamItems) do
                v.ActiveClick(false)
            end
        end)
    end
end

-- function SetIcon(iconName)
--     if iconName then
--         CSAPI.SetGOActive(role, true);
--         ResUtil.FightCard:Load(role, iconName);
--     else
--         CSAPI.SetGOActive(role, false);
--     end
-- end

-- 查看
function OnClick()
    if (cb) then
        cb(data)
    end
end
