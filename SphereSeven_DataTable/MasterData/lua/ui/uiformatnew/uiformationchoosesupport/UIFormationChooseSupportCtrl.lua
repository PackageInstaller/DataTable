
--
-- <代码文件解释说明>
--

---@class UIFormationChooseSupportCtrl
---@field model UIFormationChooseSupportModel
local UIFormationChooseSupportCtrl = BaseClass("UIFormationChooseSupportCtrl",UIBaseCtrl)
local this = UIFormationChooseSupportCtrl

local MAX_SUPPORT_UNIT_SLOT_COUNT = tonumber(Z_Misc["MAX_SUPPORT_UNIT_SLOT_COUNT"].Value[1])
local SUPPORT_UNIT_RECOMMEND_COUNT = tonumber(Z_Misc["SUPPORT_UNIT_RECOMMEND_COUNT"].Value[1])
local SUPPORT_UNIT_FRIEND_COUNT = tonumber(Z_Misc["SUPPORT_UNIT_FRIEND_COUNT"].Value[1])

function this:CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIFormationChooseSupport) 
end

function this:ReqSupportList()
    ---@type TeamComponent
    local teamComponent = Game.Scene.Player:GetComponent("TeamComponent")
    ---@param response protocol.SupportUnitRecommendResp
    PublicRequest.SendRequest(
        PROTOCOL.SupportUnitRecommendReq,
        {},
        function(response)
            teamComponent:SetSupportRole(response.friends, response.recommends)
            self.model:OnRefreshSupport()
        end
    )
end

---@return SocietyRole[]
function this:GetSupportList()
    ---@type TeamComponent
    local teamComponent = Game.Scene.Player:GetComponent("TeamComponent")

    local friends, recomends = teamComponent:GetSupportRole()

    if friends == nil then
        return nil
    end

    -- for index, value in ipairs(recomends) do
    --     table.insert(friends, value)
    -- end

    if self.model.role ~= nil then
        ---@param role SocietyRole
        table.removeget(friends, function(role)
            return role.info.roleId == self.model.role.info.roleId
        end)
        
        table.insert(friends, 1, self.model.role)
    end
    
    return friends
end

return this
