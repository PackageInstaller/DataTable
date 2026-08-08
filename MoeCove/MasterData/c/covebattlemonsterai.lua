



local BT = require("CoveBehaviorTree")

---@class CoveBattleMonsterAI
local MonsterAI = class("CoveBattleMonsterAI")

---@param owner CoveMonster
function MonsterAI:ctor(owner)
    self.owner = owner
    local root = {
        type = BT_Action.Selector,

        --等待对战开始
        { 
            type = BT_Action.Sequence,
            {
                type = BT_Action.Condition,
                ---@param owner CoveMonster
                function(owner)
                    return owner:CanWait()
                end,
            },
            {
                type = BT_Action.Action,
                once = true,
                ---@param owner CoveMonster
                function(owner)
                    owner:GotoWait()
                end,
            },
        },

        --死亡
        {
            type = BT_Action.Sequence,
            {
                type = BT_Action.Condition,
                ---@param owner CoveMonster
                function(owner)
                    return owner:CanDead()
                end,
            },

            {
                type = BT_Action.Action,
                once = true,
                ---@param owner CoveMonster
                function(owner)
                    owner:GotoDead()
                end,
            },
        },

        --索敌 
        {
            type = BT_Action.Sequence,
            {
                type = BT_Action.Condition,
                ---@param owner CoveRole
                function(owner)
                    return owner:CanSuodi()
                end,
            },
            {
                type = BT_Action.Action,
                ---@param owner CoveRole
                function(owner)
                    return owner:GotoSuodi()
                end,
            }
        },

        
         -- 攻击
        {
            type = BT_Action.Sequence,
            {
                type = BT_Action.Condition,
                ---@param owner CoveRole
                function(owner)
                    return owner:CanAttack()
                end,
            },
            {
                type = BT_Action.Action,
                once = true,
                ---@param owner CoveRole
                function(owner)
                    return owner:GotoAttack()
                end,
            }
        },
    
        --分散站位
        {
            type = BT_Action.Sequence,
            {
                type = BT_Action.Condition,
                ---@param owner CoveRole
                function(owner)
                    return owner:CanRaidSpread()
                end,
            },
            {
                type = BT_Action.Action,
                once = true,
                ---@param owner CoveRole
                function(owner)
                    return owner:GotoRaidSpreadPoint()
                end,
            }
        },



        --播放默认idld
        {
            type = BT_Action.Action,
            function() 
                --print("idle") 
            end,
        },
    }

    ---@type CoveBehaviorTree
    self.bt = BT:new(root, self.owner)

end

function MonsterAI:Update(dt)


    local success, err, _1, _2 = pcall(self.bt.Update, self.bt)
    if not success then
        
        LuaLogger.es("===>>> 111回调错误 error:" .. err)

    end

end

return MonsterAI