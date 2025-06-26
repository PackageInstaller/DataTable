---@class UIShowFightSoulPropCtrl
local UIShowFightSoulPropCtrl = BaseClass("UIShowFightSoulPropCtrl",UIBaseCtrl);
local this = UIShowFightSoulPropCtrl;
local base = UIBaseCtrl

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIShowFightSoulProp)
end

function this.SendDecomposeRequest(self, fightSoulId)
    coroutine.start(function()
        local req = {}
        req.uids = {}
        table.insert(req.uids, fightSoulId)
        ---@type protocol.FightSoulDecomposeResp
        local fightSoulReq = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
                PROTOCOL.FightSoulDecomposeReq, req)
        UIPublic.OpenRewardUI(fightSoulReq.reward_results)
        if fightSoulReq ~= nil  then
            this.CloseSelf()
        end
    end)
end

function this.SendMergeRequest(self, fightSoulId, tempCount)
    local FightSoulComponent = Game.Scene.Player:GetComponent("FightSoulComponent")
    ---@type FightSoul
    local fightSoul = FightSoulComponent:Get(fightSoulId)
    ---@type FightSoul[]
    local fightSoulList = FightSoulComponent:GetSameFightSoulList(fightSoul.TemplateId)

    local req = {}
    req.uid = fightSoulId
    req.materials = {}
    local count = 0
    for key, value in pairs(fightSoulList) do
        if count >= tempCount then
            break
        end
        if value.Id ~= req.uid and value.Star + fightSoul.Star <= 5 then
            table.insert(req.materials, value.Id)
            count = count + 1
        end
    end

    if count == 0 then
        UIUtil.ToolTipFourth("没有可以升星的角色")
        return
    end

    coroutine.start(function()
        ---@type protocol.FightSoulDecomposeResp
        local fightSoulReq = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
                PROTOCOL.FightSoulMergeReq, req)

        if fightSoulReq ~= nil  then
            this.CloseSelf()
        end
    end)
end

return this
