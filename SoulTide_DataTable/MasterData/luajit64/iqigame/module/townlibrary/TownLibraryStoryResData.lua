-- chunkname: @IQIGame\\Module\\TownLibrary\\TownLibraryStoryResData.lua

TownLibraryStoryResData = {}

function TownLibraryStoryResData.New(storyResType, cfgID, isLock)
	local o = Clone(TownLibraryStoryResData)

	o:Init(storyResType, cfgID, isLock)

	return o
end

function TownLibraryStoryResData:Init(storyResType, cfgID, isLock)
	self.storyResType = storyResType
	self.cfgID = cfgID
	self.isLock = isLock
end

function TownLibraryStoryResData:GetDialog()
	local dialogID, dialogName

	if self.storyResType == Constant.LibraryStoryResType.TownResMainType or self.storyResType == Constant.LibraryStoryResType.TownResBranchType or self.storyResType == Constant.LibraryStoryResType.SoulShopResType or self.storyResType == Constant.LibraryStoryResType.NpcShopResType then
		local cfg = CfgTownStoryBookResTable[self.cfgID]

		dialogID = cfg.DialogId
		dialogName = cfg.TabName
	elseif self.storyResType == Constant.LibraryStoryResType.NpcResBranchType then
		local cfg = CfgTownNpcBookResTable[self.cfgID]

		dialogID = cfg.DialogId
		dialogName = cfg.Describe
	elseif self.storyResType == Constant.LibraryStoryResType.SoulNewStoryResType then
		local cfg = CfgSoulNewStoryTable[self.cfgID]

		dialogID = cfg.ChapterDialog[1]
		dialogName = cfg.Name
	elseif self.storyResType == Constant.LibraryStoryResType.SoulDatingResType then
		local cfg = CfgDatingEventsTable[self.cfgID]

		dialogID = cfg.Dialog
		dialogName = cfg.Name
	elseif self.storyResType == Constant.LibraryStoryResType.ActionStoryMainType or self.storyResType == Constant.LibraryStoryResType.ActionStoryBranchType then
		local cfg = CfgTownStoryBookResTable[self.cfgID]

		dialogID = cfg.DialogId
		dialogName = cfg.TabName
	end

	return dialogID, dialogName
end

return TownLibraryStoryResData
