
--
-- 邮件UpdatePush
--

local MailboxUpdatePush = BaseClass("MailboxUpdatePush",IMHandler)

-- 断线重连触发事件
MailboxUpdatePush.__init = function(self)

end

MailboxUpdatePush.Handle = function(self,pbMsg)
    ---@param pbMsg protocol.MailboxUpdatePush
    EventCenter:HandleMessage(pbMsg, function (pbMsg)
        if pbMsg == nil then return end

        local postBoxComponent = Game.Scene.Player:GetComponent("PostBoxComponent")

        ---@type HintComponent
        local hintComponent = Game.Scene:GetComponent("HintComponent")
        local PostHint = hintComponent.Post

        if #pbMsg.mails ~= 0 then
            for _, v in ipairs(pbMsg.mails) do
                if v ~= nil then
                    postBoxComponent.Posts[v.mid] = v
                    if v.status == MailStatus.MailStatusReceived then
                        -- UIPublic.OpenRewardUI(v.rewards)
                    end

                    local hintCount = 0
                    if v.status == MailStatus.MailStatusUnread or v.status == MailStatus.MailStatusReadNotReceived then
                        hintCount = 1
                    end
                    if PostHint:GetChild(v.mid) == nil then
                        PostHint:AddChild(v.mid, hintCount)
                    else
                        PostHint:GetChild(v.mid):SetCount(hintCount)
                    end
                end
            end
        end

        if #pbMsg.removed_mid ~= 0 then
            for _, id in ipairs(pbMsg.removed_mid) do
                if id ~= nil then
                    postBoxComponent.Posts[id] = nil
                    if PostHint:GetChild(id) ~= nil then
                        PostHint:SetCount(0)
                    end
                end
            end
        end

        DataManager:GetInstance() :Broadcast(DataMessageNames.ON_POST_BOX_CHG, {})
    end)
end

return MailboxUpdatePush
