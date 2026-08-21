local M = BaseClass("OpenPassUI", BaseJumpCommand)

function M:Execute(args)
    PassDataMgr:GetInstance():EnterPass(function(uiName)
        if string.isNullOrEmpty(uiName) then
            Logger.LogError("prefabPath 未配置！！！")
        else
            self:ShowUI(uiName, table.unpack(args))
        end
    end)
    -- 通行证活动暂未开启
    -- if not result then GameHelper.TipsById(5790) end
end

return M
