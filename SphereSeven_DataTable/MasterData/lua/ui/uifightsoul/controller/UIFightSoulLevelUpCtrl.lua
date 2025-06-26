---@class UIFightSoulLevelUpCtrl
local UIFightSoulLevelUpCtrl = BaseClass("UIFightSoulLevelUpCtrl",UIBaseCtrl);
local this = UIFightSoulLevelUpCtrl;
local base = UIBaseCtrl

function this.CloseSelf()
   UIManager:GetInstance():DestroyWindowNoRecycle(UIWindowNames.UIFightSoulLevelUp);
end

function this.SendLevelUpRequest(fightSoulId, itemId, itemCount, callback)
    coroutine.start(function()
        ---@type protocol.FightSoulExpStrengthenReq
        local req = {}
        req.uid = fightSoulId
        req.materials = { {
            uid = itemId,
            count = itemCount,
        }}
        -- ---@type Item
        -- local gold = Game.Scene.Player:GetComponent("ItemComponent"):GetItem(10000)
        -- if gold ~= nil then
        --     table.insert(req.materials, {
        --         uid = gold.Id,
        --         count = goldCount,
        --     })
        -- end
        
        ---@type protocol.FightSoulDecomposeResp
        local fightSoulReq = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
                PROTOCOL.FightSoulExpStrengthenReq, req)
        if callback ~= nil then
            callback()
        end
    end)
end

return this
