local M = BaseClass("OpenPlotReviewList", BaseJumpCommand)

function M:Execute(args)
    local bookStoryChapterId = args[1]
    if bookStoryChapterId == nil or bookStoryChapterId == 0 then 
        return false
    end
    local allCfg = ConfigHelper.GetCfgs("bookStoryChapter")
    local cfg = ConfigHelper.GetCfg("bookStoryChapter",bookStoryChapterId)
    if not cfg then 
        return false
    end
    local itemIdx = 0
    local needBreak = false
    --获得idx
    for idx , tmpCfg in ipairs(allCfg) do 
        if not needBreak and tmpCfg.type == cfg.type then 
            itemIdx = itemIdx + 1
            if tmpCfg.id == cfg.id then 
                needBreak = true
            end
        end
    end
    local curTime = TimeUtil.GetNowTimeStamp()
    if cfg.time == 0 or cfg.time < curTime then 
        local group = {}
        local unlockNum = 0
        local totalNum = 0
        local bookStorys = PlotAtlasDataMgr:GetInstance():GetBookStorysBySubType(cfg.subType)
        for _, c in ipairs(bookStorys or {}) do
            if (c.time == 0) or (c.time < curTime) then
                local lockId = GameHelper.GetFirstLockReason(c.openCondition)
                if lockId <= 0 then unlockNum = unlockNum + 1 end
                totalNum = totalNum + 1
                table.insert(group, { Id = c.id, Type = cfg.type, LockId = lockId, Config = c })
            end
        end

        local data = {}
        data.Type = cfg.type
        data.EntryId = cfg.id
        data.SubType = cfg.subType
        data.Name = cfg.subTypeName
        data.PicPath = cfg.subTypePicture
        data.Groups = group
        data.UnlockNum = unlockNum
        data.TotalNum = totalNum
        if data.Type == EnumConst.StoryBookType.Personal then
            local ids = {}
            table.insert(ids,8)
            PlotAtlasDataMgr:GetInstance():SendEnterBookStory({ Ids = ids }, function()
                UIContextMgr:GetInstance():Show("PlotStoryUnlockUI", data.Groups)
            end)
        else
            UIContextMgr:GetInstance():Show("PlotReviewList", data, itemIdx)
        end
        return true
    end
    return false
end

return M 