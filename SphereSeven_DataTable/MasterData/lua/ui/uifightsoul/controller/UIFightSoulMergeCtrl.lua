---@class UIFightSoulMergeCtrl : UIBaseCtrl
local UIFightSoulMergeCtrl = BaseClass("UIFightSoulMergeCtrl",UIBaseCtrl);
local this = UIFightSoulMergeCtrl;
local base = UIBaseCtrl

function this.CloseSelf()
   UIManager:GetInstance():DestroyWindowNoRecycle(UIWindowNames.UIFightSoulMerge);
end


---@param materialList {fightSoul:FightSoul, addImage:UnityEngine.GameObject, noImage:UnityEngine.GameObject, fightSoulInfo:UnityEngine.Transform, enable:boolean}[]
function this.SendMergeRequest(id, materials)
    ---@type protocol.FightSoulMergeReq
    local req = {}
    req.uid = id
    req.materials = {}
    for key, value in pairs(materials) do
        if value.fightSoul ~= nil then
            table.insert(req.materials, value.fightSoul.Id)
        end
    end
    coroutine.start(function()
        ---@type protocol.FightSoulDecomposeResp
        local fightSoulReq = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
                PROTOCOL.FightSoulMergeReq, req)
    end)
end

return this