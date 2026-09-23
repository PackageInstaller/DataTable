-- 角色剧情详情
function OnOpen()
    cRoleData = data[1]
    storyCfg = data[2]

    local story = Cfgs.StoryInfo:GetByID(storyCfg.story_id)

    -- name 
    CSAPI.SetText(txtTitle, story.name)
    -- icon 
    ResUtil.Card:Load(icon, cRoleData:GetIcon())
    -- desc 
    CSAPI.SetText(txtDesc, story.desc)
    -- lock 
    local lockCfg = Cfgs.CfgCardRoleUnlock:GetByID(storyCfg.unlock_id)
    CSAPI.SetText(txtCondition, lockCfg.sDesc)
    -- reward 
    items = items or {}
    ResUtil:CreateCfgRewardGrids(items, storyCfg.rewards, grids)
end

function OnClickMask()
    view:Close()
end
