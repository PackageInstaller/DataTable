-- chunkname: @IQIGame\\Module\\GameChapter\\GameChapterItemData.lua

GameChapterItemData = {
	isUnlock = false
}

function GameChapterItemData.New()
	return Clone(GameChapterItemData)
end

function GameChapterItemData:UpdateData(_id, isUnlock)
	self.Id = _id
	self.isUnlock = isUnlock
end

function GameChapterItemData:GetCfg()
	return CfgChapterTable[self.Id]
end
